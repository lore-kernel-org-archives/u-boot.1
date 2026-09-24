Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46917C98311
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 10:25:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EACFC60B8E;
	Thu, 24 Sep 2026 10:25:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KYkqt-drsk-l; Thu, 24 Sep 2026 10:25:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C4AE760B67
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790245508;
	b=HgBBumitJFP+mds9dyGb3ph8oUF3m9izhnnNLg5jfvYhVJT/1QNjIfJF7VjiRUnejJVr
	 FbadiXPV5FbSder/N0+2G1ePaqya8bZDlJN/IBAslggkcXck/h0nu8u9AoJuxM6vZXLXi
	 9oKnBe3tVSMpgDJN0ZFsOSaAyP63oxwc4QDnlagBzVQiNMKFaCWGsDJTcRiqKSymdLWWv
	 Sv4xQdFuZxegWD1CIBaXhhHg7SHVhb+NNS4I07MUHmMKHs7kOMtKC15wuO4BhSRX/2wsK
	 YLqjJ3jjo7pqGND0BIFdv/6mJV1/kX22H3Q2uE1C46Vyu3y0m4a8qCdxZVQj72qFpWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790245508;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:X-Google-Original-From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=okz+BEumpHAJnOGb2zLQCUJQdjxGI9ZMhFiugz+NJ6g=;
	b=mcOW7ZxCDZ+uHEhQdncTpycVcTXgpKsp5pihubHn3bqVvVikzABXFlrANA3FDKIpkAED
	 296YEhnfuQdM+b5+tZQrb1M/OoLyffKhCbrjJXqhg76b3gqlIkcZycqD2Roxcy5GdfbmT
	 n7O0NE9RoAWIejzHNXLFYtbuABdIPCKo3rr5F5lLTQCeXNTpegXw311VzkmcN+u34FU0h
	 IJjv0LIZBxetrDOzgTk8j2vJKu6/nz7PG9fv5+g75p6nAiMi207OA3MmUUQ0y6gQw/qSO
	 JTPDks88i4WFAPU1GYUulOhGeDa9oKqEKJtU+Lp7sFUmfCqFc3zx13nLMWPVF/wvwhQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790245507;
	bh=okz+BEumpHAJnOGb2zLQCUJQdjxGI9ZMhFiugz+NJ6g=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FDP0omyC7kn/FGyy8auLItZXT+kmprqVoTw9f0JvOmHWJHOmcuTCGF33TP8+LxCdB
	 hlODEuH2QqBJhKcTwfRMftKYOrIK3S8P/3qaxlbLXOdm07dIanhYEsnC7YuxgIpNOc
	 EC9wClojv8jd5p3YHJcDDazOiweEsSl+udApi2ldiGXQzOLU4Sggz1DhbN/vBf4w+6
	 G1VCJgMAapqka+9EYvJ5BY/BX4z2xsB0iGbHsTsifeu87zaoLvdkxRIJ2fhlvmUV9i
	 NL/RhRKD5fVS/7vdQLo6SWc5btKvkZYRFPwDlQlD/WDH9cpVH2pwP6khK3HlCfX3sb
	 4te+HxyvvuZqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4AE760B67;
	Thu, 24 Sep 2026 10:25:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C39021DBA
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:25:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A772B81AAD
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:25:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YRyI9lk5ED49 for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 10:25:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6BB3C812CA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790245505;
 b=fVVQ0WL0rW4RZymp4LhFmIEbTyvINAUhNbFBUqjfI3NcjZ1VzKp3NSaa9s0oWN4mRXe3
 /WROTi8CN0Itcs6RSTQ/Tt/KcOtYxN/h/JUgjaFyH1eoQnlWKYaviSOsmdfZA/XNX2saD
 EQ3+SHJYryQJamztDHqqeBOlJrACIwxUS87wpszKV8aSd1uDAauQc1xUrhRVBVFj+c1/6
 zsLe38ciPPvG8loE2aDhwTIy21FFIcT20HpMmKbKloLk8Cu1uxa4UcepIJ3/cXI9S7mqS
 tmLg6r/xsPlwNFIW3z3OPmxuGZiiGDg4TDb0IrCJMtibLsKPwlA6ypjLGh7UIqtkGGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790245505;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:X-Google-Original-From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=okz+BEumpHAJnOGb2zLQCUJQdjxGI9ZMhFiugz+NJ6g=;
 b=b0xaxY+2976ijFsqQMS+Wn+f58TzM/Lsv+XQc8YEkJzh2FeJ0ZmZaEpIEUHSc8ymLF+X
 4hogECLlZlu04vxN0EeeOIK1A85SEAs0XN97MqGQgm1LR6cyTtcrRJAm6o7gFVMMTvmDP
 baAsaGdYKVl1203azy5iDVmhu1Mc514rhaDAEXPxXHKBgaiCyp9lx8rHNmvYTSbHJzcWl
 hJb4xZDrxakPnrYuZd3RTuZpE6NWQUKr+OGqkPPzSpJXi6RWfNcBeBDcW8gWm1Kl4ph7D
 3Fb31fB2N47SJ4CWzsuoCZFcAFDGeZ/qrEd6NzD8rxlnM2fKfGQ7RfjBTZ4EB68k3Ig==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=K08PcBE2; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cIG0AbTU; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=K08PcBE2; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cIG0AbTU
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6BB3C812CA
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:25:03 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O9QCm51774063
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=okz+BEumpHAJnOGb2zLQCU
 JQdjxGI9ZMhFiugz+NJ6g=; b=K08PcBE2zRFgNJAUYlSQfKESiEcIpxw62pY+MS
 XrOoN106Gohje61CL4r4LSl4vNpsvAADW3BAMd11AJGJ8NR8odglP9m5R++t/7PA
 cUp/+ZJ2nlHpCPrpOYqeDWHXBQd5nIcWAXGH2GL7vs6lm3KCrq72Iq3A6YcihOhU
 wLR9Wzhy9gk4SCAR4oUz3dcHw3fAtjDIPJYfosOaJyqeXx2AUScX4jyBGly2u0Xx
 f2EiseoiJj71AUvFiDfFcZnUrAmgIebDXVfo4RtiTyL9gW64izD0fG82rWrYvrWR
 VIIGbpDhEdzfjWm+fj4qI0b+hZhlQyPjO76hiNRcoQHNPqlw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvhsb3y97-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:25:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30f1b904861so2624802eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 03:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790245501; x=1790850301;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=okz+BEumpHAJnOGb2zLQCUJQdjxGI9ZMhFiugz+NJ6g=;
 b=cIG0AbTUXl3iIW0PaMv7tMZhICiiqxJfD0IN1PgDqyEL0rbl6ENMbzNC5drpgzK7Y4
 1DFAW9fYrlcDu9Q7tc+0ga3yVVeE9dUKy/44nwPIZFDg9VizF/5HSM0l/sz7FeY9LiVJ
 OUvLkw00/4GP06V0Nkw3n+Y/fv9GkeMRlu/Wg2k5aOMvamLhXg5Zy9ZbkEq3yiEGBwyJ
 UbGVtIFpdh+fw6bk1DeE1+ym7G/X8aftoDkvOj0wGsqT4Y2Fgvyejpur6ajbPvgUQJoh
 JHoBhiV4h11fr4LE20zoSdK+Q2VI7a0BIgXKX1TY3htC7jUKwiWoO91HgvLdmfUo7B39
 KTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790245501; x=1790850301;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=okz+BEumpHAJnOGb2zLQCUJQdjxGI9ZMhFiugz+NJ6g=;
 b=mNoez8UUUjpTg7TSnswaZMx5uqUyhGGxl/YMpxSLmx9hwqi2fFWFgmKvUtk0086vMN
 Y0AObVt0b67zY/sSaKDuLVzVK1lbDnpxnls/i3NZjL43BQKns/9hKKvDdhW4Azu4xf/E
 GdnVkdIc10NAMG6xkI9XVm96o/MCzpdtIq1tY/5FvEBByzYU/jo8HTEAd/c12mvqdm5/
 Tsqq2I/2IzLwIYwZ2TCG/ylD3CMolJkSlJiUdVHIN0dx0AK8G9wSfVWq+Q0jQ7EvFK9i
 Nt4zt0e7bo638wB6WNtRnGZOMmykWInV+tE67AkbsNTJhn8Fk1syocmX2Ivzd1JZ9B69
 CC2g==
X-Gm-Message-State: AFuF++nBqegUSylBS8I/GUUpOTpQIMOj9MZySrcsyNyVWVM3tW9l6eop
 c4A+f+M3lqgOPouXYN8FQfIZrVhpFocbSQKnvaE4vg1hebbMjqD0KVEFjjxo/+36dtitu7cW63w
 KJBwHJCElaj/0bd7nDLCv6KZ4UAruJa0j8ZRy6EDDmKDqmYctk2SMnGTfpYMqKN/oPFAl6BqN2H
 ICqVE=
X-Gm-Gg: AYBFou1LpTkTj9nCr3KvDZ2w4gO9BLTp4JYYGDEubzeQKcqQ4255otahjn/Vipgrm8s
 aFFznqUKtSbItoOQn+dd70oaYpuu6pEJkwiiqtsXuvnL1SUeFG9ejBZAO1QUOQOquOCEFX3esMs
 8iKhwCigUae9HlqOYz63J1uaHqsr9zzOPZvk7coa1J0gviVYKEfqUjyZKz+3/bCPS4/MIWxNHPj
 Mnr2qwMnp7m7tgyuenniKQInPxkK9isc2wM9/chQ3QRCWgbHTEnT7EofXsLiAACaiR/sMlYAS++
 geqwj/hLIXclP6CsJeVSS5f2gnQsPQoF791WhnEUzljDMtB3QVLfGESTFrT0jF4Wed2oSTbG0Xo
 ao+BokRsdSXZWJuV9osObwKOEqCq6R2q2nb/Zvr9JACbHzr2wzIRJZkRpAjtRY2MqI9oLYZ9Ikg
 ==
X-Received: by 2002:a05:7301:f26:b0:33b:fbb0:5428 with SMTP id
 5a478bee46e88-34006c87a3dmr1405188eec.38.1790245501274; 
 Thu, 24 Sep 2026 03:25:01 -0700 (PDT)
X-Received: by 2002:a05:7301:f26:b0:33b:fbb0:5428 with SMTP id
 5a478bee46e88-34006c87a3dmr1405139eec.38.1790245500601; 
 Thu, 24 Sep 2026 03:25:00 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e96f47d52sm14374789eec.28.2026.09.24.03.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 03:25:00 -0700 (PDT)
From: test <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Google-Original-From: test <test@test.com>
Subject: [PATCH v2 0/2] qcom_geni: idempotent GENI firmware re-initialization
Date: Thu, 24 Sep 2026 15:54:53 +0530
Message-Id: <20260924-series3-oem-spi-nor-init-v2-0-fd8ac27e7057@test.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHX6tGoC/3WNQQ6CMBBFr0K6dggt2IAr72FYYDuVMUKxA0RDu
 LsF1m4mecmb/xbBGAhZXJJFBJyJyfcR1CkRpm36BwLZyEJlSmelKuDwc/DYAQ8EvQ9APY2gHFb
 a6iJv3FnE9yGgo88+fasP5un+RDNue5vREo8+fPf2LDfvyFSy/J+ZJWSQy8o6RKuNMlfPnL6n5
 mV816XxiHpd1x+bXvPb2QAAAA==
X-Change-ID: 20260824-series3-oem-spi-nor-init-2fe96d643af5
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790245495; l=2528;
 i=test@test.com; s=20260817; h=from:subject:message-id;
 bh=q0OlNfy4o41t7PiDK9HBinnL8OmRpZ6xC2x/6VMItoQ=;
 b=aMuhufnbh0DCQKJcT+iAMTem5iSkl7etdfVX3TI2idkVVYZzYNfwef5D7YHLk3QFEL7RD5Wtj
 VKFSkC4QvPcBb6B8Yq0jJp27BsPoNioYYhme3AFuLHjCy9FbzyierWr
X-Developer-Key: i=test@test.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-GUID: _q6cw4TYnG1JAiu4pYIV1LGWJe4rd-Ry
X-Proofpoint-ORIG-GUID: _q6cw4TYnG1JAiu4pYIV1LGWJe4rd-Ry
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0MyBTYWx0ZWRfX3hwRx4ulN1Xi
 mRkEbQ13248lQNcznY3Njofhws1gKu9xK93yF9qWG0TrzGrr6rODX3nxfZ4KWkJOYoFYIRJoMe9
 bmfflqPCio0TWoMqAFx39m0uUbzkQPysy+5jwUcgLJJAqcItFppjqcWV7ecKu/LaJMZkckQSPhc
 1PVfYSZv/HGqZxa7YQnVdZEhKMsQJeaDdpedc3FNLXTQkajXn78YyJptlRSzA23JuhbEHtTjeM5
 gubOKH3lWsTbPVNQoifeJCfLX44QdSVVYytbCNm4dj0f+vixDm1Q0GN0BjFnLnvRILS/hx3aJL2
 WDQNLLKyFlhnBk3sxpsr1LRJCOWCNmcIQYN1v4tkaG5E7px4r8q48cvJkKnU04tO2nL/mzJsSQb
 GqYdRl/PjpLUt586EdS7j0B6QUXhHApyombbLMVgoiJko02DPFe5q4M/wketjJn+qav5DWdWW64
 7v0EjmAGa9TzR2sdenA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0MyBTYWx0ZWRfX2PG1IZq38prQ
 8P+c/Dlda/TCjEgDOpXeV7QMlmHfmYPDA4hv3Fi4uZsb4pCYYR1jLYcW8ziJp4vSPb2BDbQS9l4
 41E8j3Ug4bRuWJf3jrOZNTcrOUfNtZM=
X-Authority-Analysis: v=2.4 cv=f7vdl+yM c=1 sm=1 tr=0 ts=6ab4fa7e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=r6LF-9bVAAAA:8 a=Ug-H45lWc9DSuyxF3tEA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=sL0kBDm1BSwOBZmmfnro:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240043
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

qcom_geni_fw_initialise() runs once, at EVT_LAST_STAGE_INIT, and caches
whether each GENI SE wrapper still needs firmware at device-bind time.
If the firmware partition doesn't exist yet at that point (e.g. first
boot, before it has been flashed), it finds nothing to load, and there
is no generic way to retry once storage becomes available later in
boot.

Patch 1 is a standalone bugfix found while working on this:
qcom_geni_fw_initialise() only populates the GENI wrapper's private
data if it finds a firmware partition at EVT_LAST_STAGE_INIT. On a
board with no MMC/UFS storage and an unprovisioned SPI-NOR, that
leaves it NULL, and a later GENI peripheral probe crashes
dereferencing it. This affects qcom_geni_load_firmware() regardless of
the rest of this series.

Patch 2 makes the re-initialization path idempotent by re-checking
live hardware state on every call instead of only trusting the flag
cached at bind time, exposes qcom_geni_fw_initialise(), and adds a
generic 'qcom_geni fw init' command so a retry can be triggered
manually or from other subsystems without hardcoding SoC-specific
calls into generic code.

No existing API signatures are changed.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
Changes in v2:
- Drop the "oem spi-nor-init" fastboot command and the
  fastboot_oem_spi_nor_reinit() hook
- Add a generic 'qcom_geni fw init' command instead, exposing
  qcom_geni_fw_initialise() directly
- Make qcom_geni_fw_initialise() idempotent by re-checking live
  hardware state instead of only trusting the flag cached at bind time
- Rebase directly on current mainline, dropping the dependency on the
  "oem set-block-target" series
- Link to v1: https://lore.kernel.org/u-boot/20260918-series3-oem-spi-nor-init-v1-0-319dfeed6c2c@oss.qualcomm.com/

---
Vandhiadevan Karunamoorthy (2):
      misc: qcom_geni: fix NULL pointer dereference in qcom_geni_load_firmware()
      cmd: qcom_geni: add idempotent qcom_geni fw init command

 cmd/Kconfig                    |  9 +++++++++
 cmd/Makefile                   |  1 +
 cmd/qcom_geni.c                | 26 ++++++++++++++++++++++++++
 drivers/misc/qcom_geni.c       | 28 ++++++++++++++++++++--------
 include/soc/qcom/qup-fw-load.h |  7 +++++++
 5 files changed, 63 insertions(+), 8 deletions(-)
---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20260824-series3-oem-spi-nor-init-2fe96d643af5

Best regards,
--  
test <test@test.com>

