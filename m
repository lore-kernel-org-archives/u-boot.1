Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A17CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 09:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0173960889;
	Thu,  8 Oct 2026 09:49:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oEC0IIhFk11o; Thu,  8 Oct 2026 09:49:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 37FBF6081F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791452984;
	b=qBuek1MvxXVLir/bAOqwdlVNL5Z/mH/T87SzNZAaTr5UytK4nI/wj1jGKI/6oWT3tMs7
	 wwsCAk5cLtitwxg34rY5UTMxKYpmM7A0dJNmiZRZW+nyXtYr7bD696QoNWhgypLwegfBh
	 QRoZvDYL16Wsb6Ve5rdvvAjdcpHBeGdwTkYS9aI08vcL3P8EbIZUq9eoxQx8c7w5GPLwG
	 IsvRhbBF+l2GLi7uWSpB/CNWzw8/AXq2mh81o5lfdomUraQsmzrNJIj+Fd22c7Tvk4rpL
	 Tq35o0sk2NgLzMH8m91Cb8hQ58+vfGiWj9g+RZMmTA0CSOnVGsijMpm/RH2Ah/Mf77g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791452984;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
	b=U5rUGToU4wYl92Rw5G59X+FMBIPgGLNPW5y4kOAECduPMVOH0Wp95uHXDbf9WTNN6x6M
	 vKDP3CR7Q9t8e9wKeUaGP28dVAsCUJT1Y0IxoJN6mZgtEu7/wU+4z65KbQ0Uq+FBV7+RQ
	 ckn2o5rCns5wS78l+3y14fILPF2sf+Z3EcCVo09ZJzyjVXqEpjPBY7uEr/8Ck1HNxEIWg
	 304+lbuMbrJMud54O5Yc2CArv7xFkCcBLO/LqX1IgPyVgHcWr5mo0odV4tC2ZNRHLzIYO
	 Z01CEloo3xKz6Ag+8ulhWlOlVKRFupORn/Hvm9X8ptRuysrLlnm83yV+AykYeJfZY5w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791452984;
	bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jAqRMhBrZhL3qZmcYu93UDjlT93TAVElbg/AoLeH7xkQGpn8j/ZNg/iXnC425uqDw
	 dAKknov+1gYxMIOoqZUiuNTnHoEhiXXqtetgkYDgBg5jQim1SBdprBzJuaWp7nxXIP
	 gQvrSLYINnPxhCzb4YFA65S+0uWbByP4g3UDTezvWctIZDAxBAPlZyq0sF1eBEWyXt
	 6+slyfuaKbNfNAuNdQ5HzJ/5K7qzDV9FXfNPmui6c5dbe/k+QB/BjQxr95TLhYtJ8M
	 szyPIwjNJIzTD1CFOpH1WYZbfZgCpNTyF522jYGx1KzZLnlSR063kt8lF70+JMwaPj
	 SgObaT7yZTstg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37FBF6081F;
	Thu,  8 Oct 2026 09:49:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C82D122F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AEC38400C5
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M8Mimy_pzWCa for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 09:49:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1F8E540050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791452972;
 b=JXhuv2unjD8ZNkV0Jsa10cYn+bVUgDNhlmTaogo5noZVqMSH6w6uYqgmWjCbQEBqpVsj
 /mAFvyUAhQKSDIGPBwEmkGX+80OOr3IQ0mS7S6wqIl/N/zvZkPT6Jc0Lz1Qj+RHB8MPYG
 AY2bOFFE1AHmCQ277+SIwOb1aNJGlR16JbM3OepYYcRZflxHDy73TU0gBvG/H6KHSrqG0
 N3HDWIziTqQR+bg6ItYuG5yByEhivK5O2Av0+vE5a4mdHllLarGZcHzlN1x3APiR7APBU
 gLY4uU+Xo5QcwJH98r745b1eDr2OMGKqyYckUOOuheszpOuJ7fcTVluGJ7RHTgpQoIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791452972;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
 b=FKb+2qDRDU/B9ozLYfk4iijageGylS7wQ47tK7KTHJeWh/pXwVazwn98CYly8ba0PY4I
 7uEieQOprXHyEnTCb8uf7/F7ySLHCaQtNEYSWPYcPt8l+ZeHfeJ/iG1+nd2Yn1Msuldc+
 9G/CDUeoChWTP0UQOSdhFfIj2OC0SqO2cYUKiRW8DjI+OZ4FOWtfm7W7febfBGdS6RzLf
 Tyl5DLEgnM9SIBggYM5mqeYdAeUpbPQwoQDQ5B95luOsCtiNYnGoooi0QF3hVT6LsFdSk
 RKDwJ5Daeu7xhtLCMMFKCAEc4fcftpxlQGCummFa4vkPYW1dov9XaiEhsUB51F8+D8A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=AeX0ifsL; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gP5Nbf2a; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=AeX0ifsL; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gP5Nbf2a
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F8E540050
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:31 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987K9Is1574559
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 09:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MKOaeljaoXm
 S4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=; b=AeX0ifsLeVA/XJ4y3UBgWDw3UR9
 AsqHvVbhy0KmUWAPj6nzKgTQiy3GoSF+CUVHMxwn4EfHTKfq3ccdEibN013jx5kD
 N/Hlw9hHYrwGSHdYtEDY3QQ6OAKpmz9fQ7fGzIYTUwWtlxWEenm2essG2OkekFUI
 yctiJEwZ9w3oC8pKV0AyePt73MUGtltrRexyUXYNeBlq7OONAmUMjzl63H223i20
 X9FfYryidIebz//A5DYT14305pSkMRp/SjCjxDJ1r3j8YdD+YMiqTway6ii96RcS
 Ry7T6PGH5Ixw092uo1ubPLpR7wHm9YqQrgCkrDXBPIIrd7YXkvs3EFJmAmQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe52af4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 09:49:31 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-139b62317d0so17769018c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791452971; x=1792057771;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
 b=gP5Nbf2aBKRdJhEjKka8i0CGmurUIWcwCQXt3plPOv09HeUmJQiSSSdIm4a6abbRDB
 XCI2Igo3kdNAdEjTgLxzGUpTmw+Vozyh06nqqBIx3KMfoD1ZwcTep7h/RCZeznkGigpv
 JieUxFIbmBkcAajZqZXo0IMaYMmO7B7XsNI23msqXVWjrZrqO7JHvGMERUsYq1vir+ds
 NwrDZA8TrXZA09wUmx9XQrrW2SatdFScTD5gfALOwocJalLIxpHrApkNHT8xNlYkF9Sf
 XT19R4LxMqJg1dpE2CkhR17cPPRpcDUHgWjXmA8xicVaR7Dxld3UmPwNzR+7dDu2RJTH
 9/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452971; x=1792057771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
 b=mIZMLw5ykJ+723Rxit7e0VSMiSXH1ygk4vKmxlKjquhKbZp3V7MteryLgWk+EFlwQZ
 vyEDMDqeMngM2aAyMpNLRopcuE6vQ+l3A1/mFfqZCkmUH7r3ZhZ9tLZAOS8CHdEqqBzr
 GxjZsRk+JI2+BCOho82BoY2rK59o3cJd7JWRHK91zFmLNCSTmF7zWh2hN3vFNijyDbAP
 4M3oJUNOtvd8s9CSCbQBQO0OvNmRyVNHpPTUp8gXAIq/3MDcItb46mvx2IWNPq0+Xr3b
 ZJoRlkkMOGgmFMmqDLDaiY6yTeMz08Qf6xG426jArX0MtBV3og+C5jZwntHCeJO8gmbS
 6KBA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzR4LPk/W2OGWZvuV71P5/NlEaLJ1IZ7jHqSZdCpceAx8cvl0tIBsuRPVT2oLGDK9DIoxRrQGU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mxjEy3btQiLBtxZEy8QAUidnL0/zxf+Th/aSDWUOLaSeU/TtTv
 0LlIT77p5YhI59dj/UzWTQRZ+lXoQrGiyCI+AyTCB2yHPTCz5nNuFXzD9tgXpfBt83J9NX1dRc8
 sD+zSGo8qC6NB6ELd/uwPoafAMZyYLDZUbuPU2hsiRwkKfi+EasQ3ZDhx6St7fKL6t6267xk=
X-Gm-Gg: AYBFou0Ljwc1Aa3pE+c/N1AkWyH7lFIz89TrUeXDzO5gdYLZYID3t+YaqPc4g6pJy0G
 kDDjqiwhg99sWJf8GlB/4j0iwXh8+x33xvgFHaX3jrzLGHEhCYdnkQ8V56GCChkKr2j1f/r/Npg
 AYcXS6RaPoEaGzpfA8zXM3nGoMAGEG1+mwPy3ZrOTTqtwkfdSp9AFSAzhW5rdST05YL3S2m7SkY
 vyAyAoCGzE4UOJU9//2snNDUza30nYCNHRaKozKW8Fe1IACJGhiilsyqy7PLSZ6W1wO0nXCKTcC
 U+Hg+PyIQnlKZow0kxS8T1mVGGgMkzE1MNvaI88t20wyCuVozkDrTnfqLIYZ7zALJ8yoA6X9RYq
 65RIoptmEqMMrvX/nJIO3VnRbRyv85b/IVtk+DjLA8bRiVtE=
X-Received: by 2002:a05:7022:43a5:b0:149:a91f:9e63 with SMTP id
 a92af1059eb24-162071eb9c0mr8174965c88.30.1791452970449; 
 Thu, 08 Oct 2026 02:49:30 -0700 (PDT)
X-Received: by 2002:a05:7022:43a5:b0:149:a91f:9e63 with SMTP id
 a92af1059eb24-162071eb9c0mr8174914c88.30.1791452969835; 
 Thu, 08 Oct 2026 02:49:29 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16375a1f898sm9977818c88.0.2026.10.08.02.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 02:49:29 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v4 08/13] mmc: msm_sdhci: make tuning callbacks optional
Date: Thu,  8 Oct 2026 02:49:07 -0700
Message-Id: <20261008094912.419090-9-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
References: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: R9MIMkOkrKbV3jluZAjSKuFlUsh0_0FH
X-Authority-Analysis: v=2.4 cv=E4dYNqdl c=1 sm=1 tr=0 ts=6ac7672b cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=ybWPJh-q2Zyr6sHLyusA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX3z18w18VgKHb
 Uiqyc6CfjO7LQ9jN7IS4LkcEdr/dB4q6TOih6xSlauu9ONPUDCsvSXOud5BmM5EDS0WlTrUGuqo
 HRh7zl5i21hy92vKeBNayWn9sj1XbiA=
X-Proofpoint-GUID: R9MIMkOkrKbV3jluZAjSKuFlUsh0_0FH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX8nYLAFGg+2yd
 cezj7H9v3cNDvSQR+2sduouMJwd+4Kemb7HkRS+qBZGd/Tv5iFHXIM54YpvWGnSxdriauLyO1EG
 SVjHLUz3ZY9BeV9boA3fCZFc/EtPLr5XJ9IDHqgo7rNQ+moeY3Vl1h1b3WXUDbihBia2p3QdV/2
 vLtbabwAjhS7QmLCecMVgvKGVL8yDqPdPio53KmAvnjgf7Xizas0hmC1zpsoHdb3h27MKrpK5kH
 0axdcGdwb7OmkGBZa1PdL44epKT7gL+bNfisTIeKNx/8j7iKaqlU/YwNQGffld1Fdf2pYTJjaht
 NTIod4DHMTbZCf/hUKpcqRKt1gJWtQJM2M5ar6Z02C8THi/SDp5cqKfg3EVYBx6+E7t4hlyqMFf
 KuNnFaoKUD8pknp+Q85Zd6cuBl2XHG2fqH98jLFFBCsw8nWBrmKJOCtSBx6hTtxi3p439VVm6iX
 mHF0ObnUSeeXGs9zbFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080038
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

Build the tuning implementation and callback only when the
active configuration supports MMC tuning. This lets Shikra
SPL use MSM SDHCI without unused tuning support.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 503ebf0c5ee..40e2ee15801 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -558,6 +558,7 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
 	return sdhci_msm_cm_dll_sdc4_calibration(host);
 }
 
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static int msm_find_most_appropriate_phase(struct sdhci_host *host,
 					   u8 *phase_table,
 					   u8 total_phases)
@@ -711,6 +712,7 @@ retry:
 
 	return rc;
 }
+#endif
 
 /*
  * Configure HC mode selection. Runs from set_control_reg(), which the
@@ -907,7 +909,9 @@ static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
 struct sdhci_ops msm_sdhci_ops = {
 	.config_dll = &msm_sdhci_config_dll,
 	.set_control_reg = &sdhci_msm_set_control_reg,
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.platform_execute_tuning = &sdhci_msm_execute_tuning,
+#endif
 };
 
 static int msm_sdc_probe(struct udevice *dev)
-- 
2.34.1

