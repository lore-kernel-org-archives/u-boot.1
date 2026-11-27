Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15970606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 06:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H2GGUaB5;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a/VOSG1I;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=chlUlmCZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61C5B60716;
	Fri, 27 Nov 2026 06:15:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dSGseX77zY1i; Fri, 27 Nov 2026 06:15:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B1D1260A3C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795760127;
	b=hEYd8fhCJpKA7IIpV0bZ9q95L7xfIt/Kr8QGFMGZAqXBw4c0eckosXGYv687gExALtFw
	 LRn7lJZWffW9+ojG0eWzy5ee+PeIaZmVZW6PpuFIfBQJPz7gHKMsHGDtYx2hv6VgS+vWO
	 9dVGkW1a1sARRwt94KE/XNmHEqHp+/xKmmek6Ac65nqxOfXY/xb2tz9GFxzU2YX0uMZb2
	 JrYqjeJwbY7T0v40rPKYd6ZazQBbitO5+svvB2Eh19W/qjAI1Ppb5MTB7XsflTg6UtBJu
	 5bzQNp1OLUmvYvpmIwHzjCmtFMknYH0+1t6r83/fz7jXPIc/snIQFQPXK8ykSK89g+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795760127;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=76pxojFC+rFHQiZAJMUGyLLH6+a9Gr1t19HayoyrDdQ=;
	b=dFqvIZCmLCcWvmZPulEQfaVNbUpiRryWz0aespHuWgDyEzAQCpcPYiR/EAJDmWKW8hSx
	 ynxoq8iLopksERtW5r7ITfEhwBP6Xvgk50/O7UgX2s9t0X2GTyEPcrfVV2zpQfymtQhFe
	 YGdKwbm1q0s2JJ5bkusKjebaFnXd3m475AxWkQqQCp6p5DeFC9M8iRKArjl7Dmm/5l7I0
	 ayAbLBftjv90IErl778kyLPcVbDpmPMO5doRVlWEWMPDHcQ32Je107VviqeJCrLno20OS
	 j6N+DYPDCKP+1748JNtrgfBIHr7EhI2jHdZtlLL0ybtbenqXJb7o7U7ntxKgLVOrgXw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="a/VOSG1I";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=chlUlmCZ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795760127;
	bh=76pxojFC+rFHQiZAJMUGyLLH6+a9Gr1t19HayoyrDdQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H2GGUaB5T6P3ECr9gWb1sr4lPwz5wIQF1SbfQSJ8cSHw/bSWoSYOlTU4egNVduk3e
	 KBIHbq7M28I1a+Xf00pPO2LJ0zD6cCxZhW6iL3nOee7FAJcBxXTfrr3Q9Pu/QVOEyt
	 qPtfG6gc6R3Rj5kbZ0OPGebBeXN4a+feBRNxz13ctgcD87QxE8jpKi57JK28js2mZt
	 8yA/k49Aci+kb2h1alJD1lASlNrIWpSZFIqH5BPPN0aGFI1gV66gjkwIbbcbXE2GAi
	 UjWxKE+3uekuk5FjsJgtgBTp893lw8QukHrvu/bgqLUPyMG8j+3+5IpVRDzPmegXcO
	 Auss0tqijDMYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1D1260A3C;
	Fri, 27 Nov 2026 06:15:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5389C2DF
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:15:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3949B60A3C
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:15:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JN-ljOPgBoJd for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 06:15:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 963AD60716
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=a/VOSG1I; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=chlUlmCZ
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 963AD60716
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:15:23 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AR0m0FL375629
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=76pxojFC+rFHQiZAJMUGyL
 LH6+a9Gr1t19HayoyrDdQ=; b=a/VOSG1IjzLQtPUuod+zN2anSOdtIZH7sGyap4
 xREBqz/lYN7jglTynf7ylgPpmQrgOr/iRIeGjfo893HdsjRmvjfm43IvrezoN3rE
 9YKh5BO/nJN4vItlLjqlFTuSTopdRXwiocAYV0fd5V+0yoWyxTpXkrpp8SgdQMeF
 fR1bmNC48mrp9UO2nhJ/ryCMwqybxXwlyYhADKaYKDmIUmKFL1+k0IJseU15Fs1w
 WSPIEU7g5pPoAMQdyncLjAL4sggO1FZBf6MpNZ47jk1Fc0em37ecMInTC1zaQDpe
 GBEnBs96v0HUKHqW4oD3/CAu3bZziVH4ntaIs9ATzIPqJhBA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ymw8twg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:15:22 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so11211904eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 22:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795760122; x=1796364922;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=76pxojFC+rFHQiZAJMUGyLLH6+a9Gr1t19HayoyrDdQ=;
 b=chlUlmCZ54Zk5onHg4M31cyP/aeAMsBU7Fn//BeMsKuL3XdAJQOFUgWEGighWtScFZ
 n50WhZ0RyT43aqSgDxnm+fZlNYBOQQRVeqW2JXYKszh4DI9ONn7IZQxqvlw7tZu5Afj4
 j851v8ctue7TBL5wCSmCx+TSEYw4DLp2yMir+ohYzLTaHHfP7JUpSWsXVcSDsrMthIod
 pBQCjN+VnX8czqTIK3l8G2GDqhBOAqtQyNN1TaTzbpj6amrLv0bLcC7CQEkbUUiQtnaS
 o/xE70fxTEIEiT+1jBbdXzt2FAy7n10VZoaDVjMaivruNdtLLBSbIMULysDMu4q3qI7q
 5MWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795760122; x=1796364922;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=76pxojFC+rFHQiZAJMUGyLLH6+a9Gr1t19HayoyrDdQ=;
 b=2ccwlq9wd7c0kmXx8Kfz08Md8l+rtJDEODrVAJNOsNby6ZzlC3Bmukg4TdhrqeIiQY
 D4tbCuUTjjBpYyq+++mb8W5g7IKJJyWyBXFhktnpfZNfjo/MC1pu+cK6gM3YU83QvKAm
 Lct/gcVFpWgPjruGzDmzzbOgvgIgljneJnTZ3laWU+G9WPgsg8/CUdo1NtXBIovVNyNn
 1ubm7Asz28p5SKgjd6HMEAjvTol5P2jWuM57pfuHDjiAuSrzebuqgBQdJrm24PHCKsWF
 tS03BKFPSPonlQk1moT5shb1khqOG5jR5Mg/04icjGPQzk7yH83Jqj7KdCDhbBEi/ZqA
 5J1g==
X-Forwarded-Encrypted: i=1;
 AL+hErGHkkgrxef4LxKB1ePqCfmlXGqNvjfb+efzMQD8tTktD3Jn9w3kxDIAMCTe0HYxgMHVlwbAnuk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z81fSmLhIWKrpIr62N+G8LUNnjd5y19L7lJbBmHo8gqezPQOv/+
 6z/yZwV8jRUe3ka7C/DP2ZPDkidCf1lNd/2GQxZpOMM064BA7uYbWV6zG7bwYjyR3gR1uaKlCrE
 WixIv+p7MT3/vExQu+r4A3ca1u8scmefZ/g9lcBlodCbWTmCX3rJF/3Gw3LjWiNgIQVWhS78=
X-Gm-Gg: AZFdTZeactLisBYooZVcu8J+fC47nBOlHHOZVHZj0zox/odHz2VIRyjnQlXbDVSaYqX
 V2+0gVKSq7qLuRW7CDb6lHLqNPxbdirvFpfVf8JF55b1jWJkcETwGQZBV/wA7+oncRzvF5BAmw1
 HTwGH9lSAOykGolLWKOPTBhqvBmyXq7D80BT9Fl1QcTYce3wbM5kkYzXDyGAbMHAiHvNN6uJAwd
 B3e03sGZssxgN519VuzkLIgvQ632IeOE0TP6cFMduFmoACSBkWhJ9BwkKeIkOJdkBAS0kKTTmvK
 AWSUns1FVUMOYvjjKWfFIX60a6kNZJ5kt9LOcJMIbB3KJnPTwjgmNEsQbTeUIJxJT/y40Mc0kwT
 XwSY5Gkud6b8aKWxCcj0MKhFArsmUcPN3amXfz+hxoG/95i/sG8l4yHmMo08uf+SLCax8YKka0r
 n5fo4203JblZin8fjkiecbVZ6rKAAiT9vzr5Roov2zi0w3rtJMCNcXqq7TmOh+ASFSzfGorFaSy
 Bty0+pFfTe9gHnk
X-Received: by 2002:a05:7301:211a:b0:373:5561:8d06 with SMTP id
 5a478bee46e88-38570c36e7cmr20901793eec.37.1795760121616; 
 Thu, 26 Nov 2026 22:15:21 -0800 (PST)
X-Received: by 2002:a05:7301:211a:b0:373:5561:8d06 with SMTP id
 5a478bee46e88-38570c36e7cmr20901769eec.37.1795760121111; 
 Thu, 26 Nov 2026 22:15:21 -0800 (PST)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385d2b93dd9sm77437699eec.24.2026.11.26.22.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 22:15:20 -0800 (PST)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 11:45:16 +0530
Subject: [PATCH] qcom: ipq9574: use the eMMC RDP433 devicetree for the MMC
 defconfig
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-ipq-emmc-v1-1-091bd9e53665@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPMfCWsC/yXMQQ5AMBCF4avIrDXRCRquIhbUYCQtWkQi7q5Yf
 sn/3gWeHJOHMrrA0cGeZxsg4wj02NiBBHfBgAnmUqISvKyCjNGiwyJLMclTVSgI+eKo5/O7qur
 ffm8n0tu7h/t+ABy5yHpsAAAA
X-Change-ID: 20261127-ipq-emmc-d29542064797
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795760117; l=1544;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=DfZbzn007DlWsH+po+W0Lrc7fn9Vc9k2VA7oLRKHwHI=;
 b=GLHmosD43Pj4c2Z+YPQmUhvT54iyb+5FuUHWdibbi3CSkqqUbCpj+mfA3FZNMXKtEcpB2zzNI
 NJc1Jp/EOA+BPszjrRM8QG2xPEjqtPF/SFo65qoxnWa9VvrKqsL1Yrt
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAyNCBTYWx0ZWRfX6rWwck/Y5tuz
 g7eGphp58LlOJuYxM1Dn1rqVuQCfjcDM87YQxLm8s3TvfjrrkZxmqxAZHmL2FWmndGSdL8/xeIy
 bk15G4njLp7oE7kztRIYmMC2oHkTOJY=
X-Authority-Analysis: v=2.4 cv=ZKtCCn7b c=1 sm=1 tr=0 ts=6b091ffa cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=9nzTc5iahQVKGEZTfPAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAyNCBTYWx0ZWRfX8r4pcNIEY23C
 gyCcUEh8kcMnlyoWF31y/QsvWTSfne22ikBkg6WPyKgNE79MzIf0VAI393pKctZOlv5vWBXWvlw
 5P49aD2AiRp5S/54krAvNi9WOUQmmxy07Nboo+69oNNipAN6QDNn4JSfn9r2M83KW4eH6G4G8+o
 q+O4O2N5HNwnxoHa3SEoFYkzCb53sbXOQ1kWHGd3g1oLKIl5HZy/ppT206HcndPrAhGQTkAyGTy
 U9e6wCflcdePGL+fRgXBx0o2XTxD7yCrpaESJbSkCTwbAOAt8ildchd64bHjFo8ipV+TggSZvu2
 TOpwKIdef5YSM9CIwJIrCQns8kUutbvNT5KNbm8I/2K5s/3Sx8H5qnyn+dBOp7vIXqog0nT6oh0
 G4Z0bM2qykXFmk3x2ZONZ5/1f0Vr5jnZf31Pix1wPYJRLM5EeVU5m/engwvVgKbU1y7PDN3X4qg
 9S4xYweUVxDK1RzSX2Q==
X-Proofpoint-GUID: qO9LeEMFBuCAfrDJR_iQejbZDbjXKEgf
X-Proofpoint-ORIG-GUID: qO9LeEMFBuCAfrDJR_iQejbZDbjXKEgf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270024
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

qcom_ipq9574_mmc_defconfig builds the NAND variant of RDP433
(ipq9574-rdp433), where the sdhc_1 node stays disabled, so the eMMC
controller is never probed. Use the eMMC variant (ipq9574-rdp433-emmc),
which enables sdhc_1, and rename the board u-boot.dtsi to match.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 .../dts/{ipq9574-rdp433-u-boot.dtsi => ipq9574-rdp433-emmc-u-boot.dtsi} | 0
 configs/qcom_ipq9574_mmc_defconfig                                      | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi b/arch/arm/dts/ipq9574-rdp433-emmc-u-boot.dtsi
similarity index 100%
rename from arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
rename to arch/arm/dts/ipq9574-rdp433-emmc-u-boot.dtsi
diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
index 429a17755d7..1445537108b 100644
--- a/configs/qcom_ipq9574_mmc_defconfig
+++ b/configs/qcom_ipq9574_mmc_defconfig
@@ -7,7 +7,7 @@ CONFIG_TEXT_BASE=0x4A240000
 CONFIG_NR_DRAM_BANKS=24
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0
-CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9574-rdp433"
+CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9574-rdp433-emmc"
 CONFIG_SYS_LOAD_ADDR=0x50000000
 CONFIG_QCOM_GENERATE_MBN=y
 CONFIG_DEBUG_UART_BASE=0x78b1000

---
base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
change-id: 20261127-ipq-emmc-d29542064797

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

