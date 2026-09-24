Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AA3C98310
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 06:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D2F840E02;
	Thu, 24 Sep 2026 06:40:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lznNJE5KBn6I; Thu, 24 Sep 2026 06:40:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4D9EC40CDC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790232028;
	b=dxAO56PaG+kPksOFtDvawbJJ7NaaNNQeixJSGIhMVFOO445EDyY1lFdPs+WSIIZYTj/6
	 GeQUxXz6lF1d4kLZemDi4i0WOpHQldwbG3SoaZ3tguyNpjJlebykUREC9YlmXtrN3hzhV
	 ssVPFhW8xlnDPeDb45R2H0RoJ/Fef/NO2X9HxCJu/et5kr3WLvMGIyDz0CcVH7TpvGGZn
	 SdVRG/lWrKd2pU7wLX3H6gCqrXVivQ7MmUXSNP27o4D6Xgu3Cu6PNGChxyn0sdqoZcjPY
	 K+G3prRxvZKSaw6LL5BipU2nYWMGYfW4UOyF37r1qjrrOx5DBemfNbpcIWC1fF2x8Lg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790232028;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=og49lSZZBj1XzLpXvVPt/0lcyR7AqUp8zxMhbJecso4=;
	b=AZe7NdC0MS9XUhGkdAAWndu5lJIbJpy5+ieRb5Sg6W5LyjJUBG6EyItqXqGESwIdCXBE
	 D50DDzE24uEalYEhHkRHcOekCKQdOR/9pmjtRx66KHSkzyQng99F3BxgpHsOYgHf+Z7wu
	 t9CJZ361RI6r5IXl1JF5U0jOoLrHNCPrffM6NCOeTfQ1xPEBNgtl7f/XUFoU0A0qLUYoH
	 7XGJbvWthWkvfkafq/kTeAGq3247uvE+BI5l5tih7UJhBQn1PHUnN+hXnn1vLEU6OC/L/
	 1+oirvoGM5dTu1OrgxFJYyEL3Mdb+NLTXzXzSCBABU4dxefjXmBeNxRceeWklpNILhQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790232028;
	bh=og49lSZZBj1XzLpXvVPt/0lcyR7AqUp8zxMhbJecso4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JCphM0tbDv5lB6rRPoZWcYfKTqxPcyHU+VyEo1+/oM98J/n/MRbEuGkkk3tKZNX0u
	 2BlgIur1U+TEOxldZ3/YD+g49o/rLlkv4bV0BVM0HI5KFRCdoPdpihEOAoQZ6SNDuq
	 UPcR1lMSmcqtcPcEE3BNSgR4xqv3lX/RbLb4FJCmhsT6VsDDNlnN/6nJpZUf8eNKXG
	 MkGcK0TBQ4F3z3Yz3B7xppzBCeubHQXoXzKCPIb9Ji3mzvnYGG05YN0fo+PLvn4cRM
	 a5ZaKVnSinMTmuOd0Z0uLiL/mkAhvUbmiLr+SnNjwzUUDD+Q6EggwOEByuMLd/Sxfl
	 GtuJjRAILx5ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D9EC40CDC;
	Thu, 24 Sep 2026 06:40:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 13973194
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 06:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04C6781AF5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 06:40:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aRJzptsmMfCo for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 06:40:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0758681566
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790232026;
 b=hGs6bumpkiQobR8MlaOSVRKo+QUwYEvod3ovREyzMAEsZ9ZNOtflsUxH4wEAmGcZb3y4
 FD6g3QD8BkUPr66aMANEAD72Xwm7e5ZEANMG8RMxM8ew9xI5B497l0ahg50ZGgNX9E9MA
 3FHxYKGGg9jI+7fLfdGTTLqekxsC1xnfIENhRdwD6nKySkC67GxlOnJ60VyqDyZj9nyF7
 foV7TUZlU0aP9SwqvCdCdR2QQjmWpCj2BKFzpZE3wY7u14x2YnWOZGJ9njwRL8iD07yM6
 B3eqrKJXsj3Kdm6ypPCWVe70jvUElhj+35r4UpmjLc62DXXvOVJv/ZtTDyvTID7Y0ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790232026;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 X-Google-Original-From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=og49lSZZBj1XzLpXvVPt/0lcyR7AqUp8zxMhbJecso4=;
 b=OaRI9fXnZZXP4WNQoH1Y2TeKZy6MmfstO7ggmoldgkQVddcB4bI2s3xpIa9nQfuiiTiG
 SUXY5sgCfSUU8Mm460lJE/ly9Y4Mqc/XnhcKomlm9GSVeR8xkOeDzgkzLIe10J2FgKD6O
 dOJLStdGvDUhSCAkzP5oscjuVWxxH9vY6ftew0bk9SD6Ri4yvqXeX6/jCfwbccVPkas/q
 LfZwe75QOp7S+Gg+YKkFUIf8ralgnmEcvqUIbcmclEScVuqZrQhNVT2hSmiXdpJAAZLp5
 Q25aufcwIRJ1kqJhsb34NmaMrCU8MwSV2w3tP5YwE7N/Vdz5lj5tpcqIiDUmxOioxRw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=oXjEcpUt; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=f4wLf2SX; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=oXjEcpUt; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=f4wLf2SX
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0758681566
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 06:40:25 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5eKrH1898771
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 06:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=og49lSZZBj1XzLpXvVPt/0
 lcyR7AqUp8zxMhbJecso4=; b=oXjEcpUtbRU3OJXPZf/8Yz2vx1ewySzGmP7X0X
 qKbmNTqMdk3UlRocnelLIM3Ipe9sJIRe14fSrFOnOklbBts1lbMrqlcYXnWXjDzy
 8f9uSeL/1EmYm7x+Gn+15OFfGixc4freX6vt75kmDw5sum/Q2Hzwj3TSMJ6RUR/2
 Hh64e93SvFZQrsxiMgZCWZcazNiACahtyEPfD79cM1dzFeZjMtX4OQLYq6G8V/wD
 4qnYCKmMNRJ9M7ZjHANHw4qIU7HFFnc4IwBpDPZcINW310fO0VAbE8/7nlbe3KJ2
 WTA7qCr9sc48g9L+Wk9U4K9aG/1T5JzDE3oAO7SDP+w6g+mg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvdb648u2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 06:40:24 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-331b2ec616fso1350945eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 23:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790232023; x=1790836823;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=og49lSZZBj1XzLpXvVPt/0lcyR7AqUp8zxMhbJecso4=;
 b=f4wLf2SXfZnkcj6T06R/aQ/KOk33NXXw5K9HUzTauLYMmAqzxY4lBIvqmpNrHaldqM
 v4L/0fmY0aJCX6/WhNp+EVJThMOniAQ3q3PPjklVfgn2hDKy3NNWdjqXeG3vOaiMFa5O
 cRniz9ATIu7Bz3S91V2jKKsWqLZ5PEQpRh1qJoCqMkckTWo/MnnDOS/xdzqfd5TSrhjn
 bx2danM2/25lbJgvtrJsFPg5eJ+3LR4CTaO0/GjCiuHqasJUivH9EdbAsIsvZ44eDn3J
 o5zYPYDiTw1ZwKBTk5VoNEn4j670UcN5/eDlOa93pPOhQfSnZZndAwdoNmGabS+jzVah
 an2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790232023; x=1790836823;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=og49lSZZBj1XzLpXvVPt/0lcyR7AqUp8zxMhbJecso4=;
 b=gX497unuAV8+n4suubsUxaRvQgN1XbtWNirFPyo9f3I/j1C5a3lYshd6HQj4FC6xga
 SezZaNYRwSMCl08yM/EFYD6lD93qxcj8nteLMDIgp2kcGj5Vf5L4GVvDxvBIIYcp4hWs
 Kjl8Z7ZbyKQYrLza0tw1hIrhrSonMQGhkmvn52qgLVkWhCLBeDxf6sUoeaiZc9BDIJf7
 4jgUJpaBQhC4cIR53Z5FzYvS+OaGF/+QiKKeBSXhbLgC+D6yxHaGtKgPNF8hiil/4YY3
 Gn6p1CAu2JLjU5HOuuZ3XgQlSgIao0bMXeZq/PYMBDvFl9ClrifDlMxUE1kVaDrz5nc9
 8P8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBywwSABXDeirj7+BxSRhIfg04frmbfG6hy8h5H9pezMikcRhDb843QgorEFTVnG3nUxIdcVysw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++noKQ+B0WU76i8Q/GlY4Mq3yw/r5sfZVdkXYPW0UYYQN/i6VeIz
 1QNAWIIdYw0PRFgos2n1/qsQ1TfUYg2t4XjJzpK2eJ6m8ElQGd6eG4pMq/vh49Lv3dhqIVq0qQu
 H96arqVgz/yc8MmPIyGPvIKnUXMXbCB2idVulW/wFkLK/MRfypgBbvJKmeyGdMEq1B3ePlEQ=
X-Gm-Gg: AYBFou2i0DYrBS0ih3UETVAwPgQ5DqNfieSfz+oWTzxl+ETyshtDyqoJ57L8D1vlHeF
 DixEMoZ4Uv+Baw8tHcnlTUXkgMMLvZcW7H70ZPJfhDCCRey2I+N6qt5GmeLQu73xpycWwuEXtF1
 apukyDQfq8RiIH2CHT01w7b188HJaYM3PsYQr/plGqBvDDb7IumyTyDEk2ZlBCcc/jpDYNQD+Qf
 PAtzLikjk3LO7u73VtcY48Z8RD0a1wsDhv4udN6ra1YZuM3pPYHc0vrdg7DioKhxzQeeXIFdlVg
 s29mTmtg5nUlqKDeHK2Rg+9/eW0S15wnR1mmoAdYr9KYnIjjmwWxrfCLZcfCdLb1jGWwFA3ozyE
 T1P7/T3LqHX7W2myqy7/wFTi4zQkKFzoXjT1zjuCJJnlKiOAbsJeZ0Ei8qU+OHu6eQuW4I82Y+4
 1NNd2vRGVUTQ==
X-Received: by 2002:a05:693c:8812:10b0:33c:16c5:6f3d with SMTP id
 5a478bee46e88-340040a6d47mr1096217eec.37.1790232022898; 
 Wed, 23 Sep 2026 23:40:22 -0700 (PDT)
X-Received: by 2002:a05:693c:8812:10b0:33c:16c5:6f3d with SMTP id
 5a478bee46e88-340040a6d47mr1096193eec.37.1790232022222; 
 Wed, 23 Sep 2026 23:40:22 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e96d47157sm9475052eec.24.2026.09.23.23.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 23:40:21 -0700 (PDT)
From: test <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Google-Original-From: test <test@test.com>
Date: Thu, 24 Sep 2026 12:10:17 +0530
Subject: [PATCH] clk: qcom: sa8775p: Add QUPv3 wrapper 3 SPI clock support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-b4-sa8775p-qup3-spi-clk-v1-1-8e9c297a20b6@test.com>
X-B4-Tracking: v=1; b=H4sIANDFtGoC/yXMyw6CMBBA0V8hs3aSPniov2JctGWAUYO1I8aE8
 O8UWJ7FvTMIJSaBazFDoh8Lv8cMfSogDG7sCbnNBqNMrS6mRF+iuHPTVBE/U7QokTG8nlgHpVu
 rvbXkINcxUcf//Xy7H5bJPyh8tx0sywoyEGP7ewAAAA==
X-Change-ID: 20260924-b4-sa8775p-qup3-spi-clk-6c01d31b33ea
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790232018; l=4214;
 i=test@test.com; s=20260817; h=from:subject:message-id;
 bh=FBCBK3vsW+zSF36CqHtKGrYTWjSYGWhQso+5LQaB4HM=;
 b=qXygyo/4IoddF3lfDNNCcTeEPvvaFFkjhBiulylOsXf91rEau308nWUNOJM5ppc8ZbIpQesYS
 dc8SOd5fk08CukR1xOKIjfu4EptJoyXAgLZxUru8uqlxnInbIF7hXuU
X-Developer-Key: i=test@test.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-GUID: tIkRTvRdwtvreFnFbwRwWhLiA0xBBFFe
X-Proofpoint-ORIG-GUID: tIkRTvRdwtvreFnFbwRwWhLiA0xBBFFe
X-Authority-Analysis: v=2.4 cv=QeXzLcbv c=1 sm=1 tr=0 ts=6ab4c5d8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=r6LF-9bVAAAA:8 a=aBlBvB-F2evWav5k4gIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=sL0kBDm1BSwOBZmmfnro:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyOCBTYWx0ZWRfX1la2DgXAJxrs
 HKnaG7InyMIt7je5Ku2EJb63sGGfz2SvUsTLeAVHZo7FDhMdmQCwXpmR5LTG7/lq5VQrhXO3+9g
 0O+/4q84cYBhW4HPSTy2kHxjfDWg3pc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyOCBTYWx0ZWRfX0ggtDwPlm0fA
 B07GNcIeVms2zE9W/KT6EXBg5Qx2SHHxAld1HpjtJKjJAt/fR3oGA7o0OcgGcASoV4SITpvCLlv
 6OQOQD+IuxiPw2peBi0LJCfvr0PdEHuJ0Ph+hI5bUYS7uRnZ4aIP2Zrwu4vyXhNWTCc30snjsgi
 tmBfIsvZ7BbrKn/PIs6Tj5RPmrTlarQYhl+99omblqjlCFfeBhXdGwrEXGvUa77Y4uYR66nNgTG
 0rvKAVg6Kt1Qt0Jf4S0SO9QwObsDDbaRqkE9KO/JFNhftvsixknllEtjAIJ9uBCGPwTYEamumZD
 Qt+jcoyeBzkGNwKRy6K5dZXVxtWm/X0vAmMjqB6iXp1byxa5Fl2Fvo5mb/9Ca7e/3d+UqC05cfl
 vWn+tGwgEsBWDSLaMsMJ+p+uSafXG3ItHex+9EqOj2PhDBEVEmCsLDJqgi/7IJ6XBPwKJw37PdI
 CyU6h7me+c7j3ENPhyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240028
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

From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

Add the clock RCG, gate bit definitions, and frequency table needed
to enable and configure the SE0 (SPI) serial engine clock on QUPv3
wrapper 3, GCC_QUPV3_WRAP3_S0_CLK. This is required to bring up the
GENI SPI controller on QUPv3 wrapper 3, e.g. for SPI-NOR flash
attached to that wrapper.

Also add the wrapper's M-AHB/S-AHB clock gates, and the QSPI/AGGRE-NOC
gates that are auto-enabled alongside the SE0 clock.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-sa8775p.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index 4957abf6f58..3f422c0b2e3 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -18,6 +18,7 @@
 #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1b040
 #define USB30_PRIM_MASTER_CLK_CMD_RCGR		0x1b028
 #define USB3_PRIM_PHY_AUX_CMD_RCGR		0x1b06c
+#define QUPV3_WRAP3_S0_CLK_CMD_RCGR		0xc4154
 
 #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
 #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
@@ -42,11 +43,32 @@
 #define GCC_QUPV3_WRAP2_S5_CLK_ENA_BIT BIT(9)
 #define GCC_QUPV3_WRAP2_S6_CLK_ENA_BIT BIT(29)
 
+#define GCC_QUPV3_WRAP_3_S_AHB_ENA_BIT BIT(20)
 #define GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT BIT(25)
+#define GCC_QUPV3_WRAP3_QSPI_ENA_BIT BIT(26)
+#define GCC_QUPV3_WRAP_3_M_AHB_ENA_BIT BIT(27)
+#define GCC_AGGRE_NOC_QUPV3_AXI_ENA_BIT BIT(28)
+
+/* QUP Wrapper 3 SE0 (SPI) clock frequency table */
+static const struct freq_tbl ftbl_gcc_qupv3_wrap3_s0_clk_src[] = {
+	F(7372800,   CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600,  CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000,  CFG_CLK_SRC_CXO,        1,   0,     0),
+	F(29491200,  CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,   8,    75),
+	F(48000000,  CFG_CLK_SRC_GPLL0,      2,   4,    25),
+	F(64000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,  16,    75),
+	F(75000000,  CFG_CLK_SRC_GPLL0_EVEN, 4,   0,     0),
+	F(80000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,   4,    15),
+	F(96000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,   8,    25),
+	F(100000000, CFG_CLK_SRC_GPLL0,      6,   0,     0),
+	{ }
+};
 
 static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
 
 	if (clk->id < priv->data->num_clks)
 		debug("%s: %s, requested rate=%ld\n", __func__,
@@ -63,6 +85,12 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
 		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
 		return rate;
+	case GCC_QUPV3_WRAP3_S0_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap3_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP3_S0_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n,
+				     freq->src, 16);
+		return freq->freq;
 	default:
 		return 0;
 	}
@@ -105,7 +133,11 @@ static const struct gate_clk sa8775p_clks[] = {
 	GATE_CLK(GCC_QUPV3_WRAP2_S6_CLK, 0x4b018, GCC_QUPV3_WRAP2_S6_CLK_ENA_BIT),
 
 	/* QUP Wrapper 3 clocks */
+	GATE_CLK(GCC_QUPV3_WRAP_3_S_AHB_CLK, 0x4b000, GCC_QUPV3_WRAP_3_S_AHB_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP3_QSPI_CLK, 0x4b000, GCC_QUPV3_WRAP3_QSPI_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP_3_M_AHB_CLK, 0x4b000, GCC_QUPV3_WRAP_3_M_AHB_ENA_BIT),
+	GATE_CLK(GCC_AGGRE_NOC_QUPV3_AXI_CLK, 0x4b000, GCC_AGGRE_NOC_QUPV3_AXI_ENA_BIT),
 };
 
 static int sa8775p_enable(struct clk *clk)
@@ -127,6 +159,10 @@ static int sa8775p_enable(struct clk *clk)
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
 		break;
+	case GCC_QUPV3_WRAP3_S0_CLK:
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP3_QSPI_CLK);
+		qcom_gate_clk_en(priv, GCC_AGGRE_NOC_QUPV3_AXI_CLK);
+		break;
 	}
 
 	return qcom_gate_clk_en(priv, clk->id);

---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20260924-b4-sa8775p-qup3-spi-clk-6c01d31b33ea

Best regards,
--  
test <test@test.com>

