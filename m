Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459BECA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 17:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9B44606DC;
	Mon, 12 Oct 2026 17:08:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UIDWl8s4ghQ6; Mon, 12 Oct 2026 17:08:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3B202606B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791824893;
	b=crMAQLEga7jzXlHeIUlDJ5eF2fDQufHWucQmyzLxSUpXfZx27a3fxEqZ8gXpMrN1lOW8
	 F1nuKscBI42MsGTQmSnNIkvVS8Xil12DqfNLNyeH0f1FLTtN+hKN3Rt+DZneo1fl9ezEv
	 OEpNv0xs7htheh9pSxkMB9SCVpx7vNpKKMURAk1nr2Y7B1W5PVrd1cuj/Uvx8h7IB4UtG
	 IqsR0x3pO5zHU6rP3Tsuolsi2B87pwC17YzSyb8tFAE5vZs59mZevQPBn7JM7udEAnQbw
	 CKE591M6V5GKj6H1nbtW47a2UONcDvcfJSX4ffOsUaGcoJ+xdW9pdhrEijfIzDUUhTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791824893;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DKSwgrZHrWTs96MTsOAIVHlObLki6hL3Y6WOu45XlCI=;
	b=iokMnyiIcawjLTrGWsR4GR422TuGH0uskeW92DnDO7djnKPvqr4oqAbPJrsV+zh/JnIZ
	 Ya/Fhvq4FLstqvA2OdNbuNWOhmWO9RVw/FwWRdbV6EbPiGRE9cTljftQz8cY5eP6dxV8A
	 MC0ai1yQzUtGJbj4jA3ecygSL/zmSUf8eOnlKtThTj3HYNZZu5+5zXApahTFGI1hhTc+K
	 jcshumD5WQj0k6rp9k1CJmVX+V4CSqGz3IUwz1Xf/n8ji0HtsrdEoIJEpvU4lN31dlwTa
	 BmAtYMjkB5WOTu3uzcWHeXko4eAUJymIe6e55EssllsdCurcf3ajByRpPXojyX5JVWA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791824893;
	bh=DKSwgrZHrWTs96MTsOAIVHlObLki6hL3Y6WOu45XlCI=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rrLQybi0E14eADiGXBeXJxHJoB4ePg1dYp3sZ+Bdsg69n8RV6Bi7KxChparAzPjFa
	 uQT6gZWU6c938YXAfR7siXilR0DnUlZ2/Q5KCG8DoLkYPkh2l03PI/KeJBajzZwU3g
	 hPf+yKDU1H3eaK6HrNNqkanV4Kws9llAV79lILzFVCg5Snvf0RcdC1Cc+w1fhgcDvx
	 aA6iXvmGO7KIBPwJU0d9eD6DYR9Ch3tuz77RzI8LDDp903+6A8fLXiCUCh9Us+xdX1
	 945PurgtWg3TG1luRmf4IprzLI2zyVKuH2xep2Ru0IyTQy3U/v1i3HVvL29KuCpaZw
	 5WFWen5IEjxfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B202606B0;
	Mon, 12 Oct 2026 17:08:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F2164156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3B5480DC2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aJz_N9HqJJUu for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 17:08:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E079E80DBB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791824890;
 b=bu8l5m+lbVbJfaj5eIOGudoihPLIeVLGQlabPdL7vtJehM1j5MIAJHUzEC4fAebAyJDz
 CW2hlkVmBKvcLj4uTInVPydiFvkJzWCsEB+INy3itz3HFHk1IpeuPJRBoKjfVvgrFc7b/
 4a2kiDwrlz+6LWccE/6EMi7xfQZQN9ByxjdzZE7G26ncNlPqnXLmCFz1OoJ+WTbNaWCoT
 +O+f/elXVl52bRJGJFohd4FD3Yu3Kg2YcXVWmZtKBsAALcswo0D9ONA+gx4ZTc4ULSu5X
 mjcSSUW4phjaPHao4o9NKvJ0GyOCPPdak6UDZyzVujs4SKICmRom4gCmsQ2GPIc1m9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791824890;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=DKSwgrZHrWTs96MTsOAIVHlObLki6hL3Y6WOu45XlCI=;
 b=HlcXc2U5wRTgsTRWJq43ye+Ots1qaq2efgqGNO6iGzyq+eZlS3YbNLPONbnoLplMt7Iu
 uo18f5weSsW8X0Bub/HMDNRY/93A3CSxSnpf3uEVt/xJQr/tNucVsw/r4cdz2/0rbUPkP
 JZk4XhAmOzwU2mtPnRkkkLM7E0d9ygTx6ff4T1CDhdEMZfAx0Km5vg/vbtsLY1Obtjyv+
 D+JTccAjDU1TgAdvTxenMAstsYv+uQXdrV3JRTa0NEtfVSl8UiILwuHR9W1IgtHrL8y4u
 eOGf3h5gPAhBl+1Q3F36E6ozUxNsWvqfzr/LSL3V1LUwIXW8PcMicw+Ak9sNe/tOgrA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=GR9uSiE7; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AI5WzANA; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=GR9uSiE7; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AI5WzANA
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E079E80DBB
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:09 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CFf52E2420110
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=DKSwgrZHrWTs96MTsOAIVHlObLki6hL3Y6W
 Ou45XlCI=; b=GR9uSiE7QQrDek30g+qMiZhD7HZcZHwt5yLFE0DpZ4h4SC5sEG1
 rNP59ZuJ/SVs4AokpaK4LY7VpWSNaIrlWoTC5b9DO680SwTMQtEjo5Rhc2CO3kD2
 gGiB+0no3P55tkZxJf/u8Eq/NslaV4t3P07GOIOalgtP4o9VKNTSYLZoaNXZHUm5
 VzOSII5XdaM3qPYnSQbEKVLdLrIPWB5DXWwzH5PzByJ8s5EQ+UHEBTPhiDb18Se+
 lX/pBtgH7DVp05oLXzN7m6YsuPzByoBfzpl9F5YM6PAG66ofpIdP1c+KhiVo1ga3
 LBWBf5i4CHvl0NcoogQb847HoQS4x+NIkQQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8qtkkd4j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:08 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-351788121cfso5333484eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791824887; x=1792429687;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DKSwgrZHrWTs96MTsOAIVHlObLki6hL3Y6WOu45XlCI=;
 b=AI5WzANAW5OPw+RvZGOAH6ZOZYrm/EWb5puGgTdTGhjkg6vnlSTFHrdnULQGdS1xbD
 Pnk/Et6SDIjupXVXShjCND5DioSndhkoDlC9o1IN4Jqx8jUogNO+GKNkDEqjFxXcjJMY
 kz/5whk4h6kH3G/Y/m9VOBrpVp4ugn3QonrdwY3O72PLkL7IAj244RTYnDagkuoaDKyZ
 ytxspREFJ8FeaMaEAZqyuCOVujXvXa9SSnYkM+T57zz4LskU31Hr/3HXUyDlLcC2wNZw
 Oo81w+lG7En3vgOEkKgeWe4HscgAkEBLhX+rVb5h+oPu3Wh6n7J+bHE1WRL0vvmRWyG7
 HoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824887; x=1792429687;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DKSwgrZHrWTs96MTsOAIVHlObLki6hL3Y6WOu45XlCI=;
 b=L9f1tHkVOoSENKXHQdDS6EE5994t4T/xT21Oe4oz2L2zfNUDj2hu4P097mlRhhmriL
 XBcSrpv6UuldfOCGEHxy2rOWcRe/GX+RLulJiZjOpyVd3vQPkOfjGOgQFBJEZbuoRGmy
 5HlYFLuyLcRzVhb+SnVOAhjxJhs+AWPMtsVopuuliQ2H2aNlqOUVvT8JTaSjeNW0jdE9
 xrXaens8fKu+l/G0uMyYtKaMSpl4rKdV/WNdeWpwlKp1VkjuwgSrF4pPsyASxZpVhIO+
 bcP+1oBU8suv68qGUUypVsCzdLwnr1yzpUqd53IcQLNV7Nvb1p+jL9x5chEWIc/u3E7J
 xobQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQ5hIZ2IJc3pV8AMXKV/DegTOZmITYN7mtMl2WqU5gVnieaNF/DXQcpMxEvUv0lv1iqAKQMhI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKJ00VYsblPXUrGigh7ScZDKfHAX2+rxCSqzTbxpC+/YOJ5PSco
 +eVfQM6lG48FdKepyqIMnPtpB7pVsOcjbcpu1/hSSW7CSyj6EB8dONPN221g9gEtc8k6YjICiKY
 ASgnhZgtzAniclQYPHJphqtS7r8mpoz8uDFfKD62pqqZo1esXmTWPEpXhhpFjT1QWIV2sX8o=
X-Gm-Gg: AYBFou1mEog3TGGI9zZMzNfekt+YyC80WIvRMqDNxx53375vDDSEsUETg5bij4X9LAv
 Pbmls/kbc9yDwOaq/d1uuM9/7JhPUvETf6/zHtFrooY0PRC8HYwiPbYjvhNb35SwfCKeEs7hzsi
 mUGYGPkgy9EOSNI9BMzJSFFtyLDSYqdEbeGL55XZim/zqfCvhag7w+elAk+2f6lJbXwKvIihxrY
 DlZ8PJFofms0jn+sRQ78srD36CwAeeBQsCHh4bd5mpyFT5Jf/G+bEYS3lA6mb1mKoyfl6wwTRW6
 l9EmGu/LBWL4945FYjpWuC/vTXeDxOYtRyVeD3+l1PG1hVDDLsGRVw9ZpEyxq2uvT8tyOijxOa7
 7jjrMIuyprdZYwAQIhs06OtR+yRJQdJervIjO6gMnxY+itGFDGGKgHRVmugoaWULYPLSQJuFqi7
 MSf9C1SI55DIYoQYF+rw==
X-Received: by 2002:a05:7301:9bc9:b0:35a:a68:7f85 with SMTP id
 5a478bee46e88-35a0a688182mr9094775eec.16.1791824886660; 
 Mon, 12 Oct 2026 10:08:06 -0700 (PDT)
X-Received: by 2002:a05:7301:9bc9:b0:35a:a68:7f85 with SMTP id
 5a478bee46e88-35a0a688182mr9094719eec.16.1791824885862; 
 Mon, 12 Oct 2026 10:08:05 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353814b556esm39945402eec.18.2026.10.12.10.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:08:05 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 quic_varada@quicinc.com, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, u-boot@lists.u-boot-project.org,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, jbx6244@gmail.com, quentin.schulz@cherry.de,
 anshuld@ti.com, marcello.bauer@9elements.com,
 tan.siewert@9elements.com, u-boot-qcom@groups.io
Subject: [PATCH RESEND v5 0/5] Add FIT multi-DTB selection for Qualcomm
Date: Mon, 12 Oct 2026 22:37:49 +0530
Message-Id: <20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfX5o7cNIvIXFj+
 zBHrUPSg0rqtColMPLs9AFTE+/8qGgWijHaE9wIpSw7+468MRD6v2jr9l/CivSHbWkJjSTC67fU
 M93y6qfm+knfKltMC0vI7SUyJGHQIZq9bR50FFJxtBob6rYk6tCeOL7PewAnjpaltDh1Btzrl6T
 SuRQK/SWUB7MeOaHef99GpplfnT8/ZjJHb94mbEcJ9e499noAVVjRp2lIRYh5KeZEeQY8qqvfu+
 pS4DIwaDD2Q099wXF/WJoJcnTVjpAvgXLLTMV6yetU2RxMIcTRFYrISyz05mqiAGWhz3OFiyJZz
 2/Mw7yMrj0J0YX23YTKnBl7AuluXJg/wWaJbpqxpgzSzyXm7NIcl8tyqlhLyhcUUxYIkj4ufFcT
 aHURs6BXaXHSdqRIom2o9xjTLIQRv0LjYwbDYuqlC7PMrE2Kb+ZXFbetmhXySFOWAvbxfHhzguG
 deM4GGe2gwmakUU5IFQ==
X-Authority-Analysis: v=2.4 cv=c8U+0h9l c=1 sm=1 tr=0 ts=6acd13f8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=cSziVDP4AAAA:20
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=u38HHJEOLTUlGKIKg8AA:9
 a=PxkB5W3o20Ba91AHUih5:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfX8vr2c/Q8nMdG
 4ckqz3UqrBPFQAavIokdu506ciPUwBAlkyeMIO5Uq9dvblv+pir8AqarmXsZ2z4/1HuzsXxbaVf
 IbbhXtT8TC3ti/fXdtqWKeEnkW8YzHI=
X-Proofpoint-ORIG-GUID: HEI7rNnqDrrAy7TVXYkhfcO-xsKq6PIk
X-Proofpoint-GUID: HEI7rNnqDrrAy7TVXYkhfcO-xsKq6PIk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120068
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

This series adds dynamic device tree selection from FIT images for
Qualcomm Snapdragon platforms, enabling U-Boot to select the
appropriate DTB based on hardware parameters detected at boot.

Qualcomm FIT-based DTB format is documented in [1].

The FIT image contains only DTBs, while the kernel is provided
separately as part of a UKI image.

The implementation consists of:

1. Hardware detection infrastructure: Introduces the qcom,hwinfo
   driver and qcom_hwdetect helper to collect hardware identification
   data from SMEM, IMEM and TCSR into a single qcom_hw_params
   structure for consumers such as FIT multi-DTB selection.

2. FIT multi-DTB selection: Implements DTB selection based on the
   aggregated hardware information. The code parses metadata DTBs,
   matches FIT configurations against detected hardware attributes,
   applies overlays, and loads the selected DTB for EFI boot.

[1] https://github.com/qualcomm-linux/qcom-dtb-metadata/blob/main/
    Documentation.md

---

Changes in v4:
1. Drop the SMEM cache infrastructure.

2. misc: qcom: add qcom,hwinfo driver to provide a common interface
   for reading IMEM boot cookie and TCSR SOC version information.

3. arm: snapdragon: add qcom_hwdetect helper to aggregate hardware
   information from SMEM, IMEM and TCSR into a single
   struct qcom_hw_params.

4. Refactor FIT multi-DTB selection to consume qcom_hw_params instead
   of accessing SMEM, IMEM and TCSR data directly.

5. Separate hardware discovery from FIT parsing and DTB matching
   logic, reducing complexity and improving code organization.

6. Load FIT images directly from a raw GPT partition and remove the
   FAT filesystem image based loading approach.

7. Drop IH_TYPE_FATFS, mkimage FAT image generation support and
   related documentation updates.

8. arm: dts: enable qcom,hwinfo on qcs9100-ride-r3, qcs615-ride and
   qcs6490-rb3gen2 by adding the required qcom,hwinfo DT nodes and
   board-specific offsets.

Link to v3:
https://lore.kernel.org/u-boot/20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com/

Changes in v3:
1. Runtime IMEM address lookup via DT: Removed CONFIG_QCOM_IMEM_SIZE Kconfig option.
   Added qcom_imem_table[] mapping SoC compatible strings to IMEM addresses.

2. Split SoC version sources: SoC hardware version now read from TCSR register via
   qcom_read_tcsr_soc_version(). The soc_info->plat_ver from SMEM is stored separately
   as board_version. Added socver and boardrev metadata node matching for finer-grained DTB selection.

3. qcom_load_fit_image() returns int: Changed return type from efi_status_t to int,
   returning standard Linux error codes for consistency with the rest of the driver.

4. Code cleanup: strtok() replaced with strsep(); memcpy + manual null-termination replaced with strlcpy();
   DDR thresholds use SZ_* macros; compatible matching and FDT loading extracted into dedicated helpers.

5. image: add IH_TYPE_FATFS image type: Added new fatfs image type to represent a raw FAT
   filesystem partition image, registered in the image type lookup table.

6. mkimage: add fatfs image type for FAT partition images: Added fatimage.c handler that
   uses mkfs.vfat and mcopy to create FAT images from a directory.
   New --fat-extra-space, --fat-type, --fat-volume-id, --fat-mkfs-opts long options added
   to mkimage.

7. doc: document mkimage fatfs type and Qualcomm multi-DTB: Updated 'doc/mkimage.1' for the new
   fatfs type and options. Added 'doc/board/qualcomm/multi_dtb.rst' covering FIT ITS configuration,
   QCOM metadata format, socver/boardrev guidelines, and image creation steps.

Link to v2:
https://lore.kernel.org/u-boot/20260129184817.224101-1-aswin.murugan@oss.qualcomm.com/

Changes in v2:
1. In v1, a combined DTB format was used for multi-DTB support. Based on
   feedback, v2 implements FIT-based DTB selection instead.
Link to v1: https://lore.kernel.org/all/20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com/


Aswin Murugan via U-Boot (5):
  misc: qcom: Add HW-Info aggregator driver
  mach-snapdragon: Add hardware detection helper
  mach-snapdragon: Add FIT multi-DTB selection support
  configs: qcom_defconfig: Enable QCOM_FIT_MULTIDTB
  arm: dts: Enable qcom, hwinfo on qcs9100-ride-r3, qcs615-ride and
    qcs6490-rb3gen2

 arch/arm/dts/qcs615-ride-u-boot.dtsi         |   10 +
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi     |   10 +
 arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi     |   10 +
 arch/arm/mach-snapdragon/Kconfig             |   17 +
 arch/arm/mach-snapdragon/Makefile            |    2 +
 arch/arm/mach-snapdragon/board.c             |    7 +
 arch/arm/mach-snapdragon/qcom_fit_multidtb.c | 1033 ++++++++++++++++++
 arch/arm/mach-snapdragon/qcom_fit_multidtb.h |   61 ++
 arch/arm/mach-snapdragon/qcom_hwdetect.c     |  167 +++
 arch/arm/mach-snapdragon/qcom_hwdetect.h     |   52 +
 configs/qcom_defconfig                       |    2 +
 drivers/misc/Kconfig                         |    9 +
 drivers/misc/Makefile                        |    1 +
 drivers/misc/qcom_hwinfo.c                   |  160 +++
 include/qcom_hwinfo.h                        |  109 ++
 15 files changed, 1650 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.c
 create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.h
 create mode 100644 arch/arm/mach-snapdragon/qcom_hwdetect.c
 create mode 100644 arch/arm/mach-snapdragon/qcom_hwdetect.h
 create mode 100644 drivers/misc/qcom_hwinfo.c
 create mode 100644 include/qcom_hwinfo.h

-- 
2.34.1

