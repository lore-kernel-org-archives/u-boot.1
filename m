Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C12CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:07:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AF2780E2C;
	Wed, 14 Oct 2026 16:07:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x3jVEEXhVd-u; Wed, 14 Oct 2026 16:07:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 930BC80E43
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791994062;
	b=Bj6zT/ljFoutEsHtfOgAgJoOB8U3MqYP5amOLew4tdfEBGKsTb3gTNmTL0DBT15May6f
	 pO09exODsHdBCo+2rnxkrXmirfC4mduaW0gE25VAoFWmeFJ1kKdfIHQo0NlGzJ8ExM4Hr
	 out8gEy7o78AGzsUIGRV+PE0UF4maih4BV0pSzAaX7EE4y8pXLrDaqr44JWnVhM/nYu7g
	 J1sKv+1dQfsav7phBHEzcuRWfebC3FJ2Se320BcRWWVHkiif5zUKGoeVecgDSLDt9P3C0
	 pCHW0bjfsOO/0FASOFu5vLgu638xCTxc3qvHQXOkAMEK3Z8d1nTZ1rNDkuhsFcU6cNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791994062;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bqwZzYlOtmm3bnbxauKPSuFVom7XYOoLMJjpZm0Csqo=;
	b=IQMqKJ86ccj0IaOf1LQZmlO0SRDnTLe0s1uBA9y0VWzObJkzbubQZcp/L0gEMejE5stf
	 C4JebQYQR3U9syO8Oyuh5a0h6KnOaIGNDT+xr9xNIskX4JIMWQ+nN9yexbh+GgXu6GvNx
	 BRlQc5FerxTtNEyjD9YpzPQ07NptO8Sd0gGpJMh1C4fXJ/7VwdK7yuCHQjx3q7TkVezhk
	 thrYWnoLHoKiT/ROQtYJ8q+LsZhh8jdM5Ri2/6D5CkxLbMaXx2woOAzSHP9DYyn9JaOxK
	 uhrGSjHIQc1tVCnu/M195lyW/COwY7Hz2/WbX2bLFrIZ2VUJElkBe6q6Fhi006CeZTA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791994062;
	bh=bqwZzYlOtmm3bnbxauKPSuFVom7XYOoLMJjpZm0Csqo=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XaMuz9O27hooJ7oJEnq+ki0z8FcbdL8L26e/yZT84G2lJGlUrlSBxi3ylpUhLmB9t
	 r/7TDUHbEAkRxGz1kKbOZ24i6ryIZed6kUlFkrPpHuEpSfRCbkNcebmfjuywrgV288
	 lOUjzD//4gZ3tC0U+u0mAY8ebo/K/m4ZHgn1ZRb76OKie0uBboctLL9wAhuqNQr3lO
	 Yty7TTTyxMA1JHvpipEm+k/s1j8gmn/a+RLaUvOD9rSnZNoKfWOGWUlbEAgqW5RGIj
	 03sR9LDWALABtyF6R4sjUmPXqEQNmmorcouw9Yr317vfcC++S6aPzFuBYmgXTRzFCk
	 rSK+pLqGb00lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 930BC80E43;
	Wed, 14 Oct 2026 16:07:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BF894DD
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:07:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D875405D8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:07:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3RZOVyytlIQG for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:07:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D186A405D0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791994060;
 b=Dh8o+gWUFCDTOqndULXHBeoEQLDif2j5HCQ5reAgHIv3DglL1lEZo7KwuGBAUorzN1nw
 EDXLFu7LA7Ohwvcey559JUJRQQ0u5NPGrKThbvq55YmV63iwx6toIlAYsGGhEx1FSeSAV
 ljLZg//jWk602FPNn4wBfEb86cNZDU0SJsJC9bJLB75lkmdHjdPNJugyp64Ur32Rkkr1O
 +zRjhdB9NR9kjtM86ItmPjCIv8zSF4Has5EGupK/UibMlnL39N58YigEnA26Q31iKN/lr
 OO8HkGgWLrpKcD2EjuSUsL0JnVzbQj+IoKYGJFzH5DyH6b9Dbq/LgbURGDUNJ+Yjd7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791994060;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=bqwZzYlOtmm3bnbxauKPSuFVom7XYOoLMJjpZm0Csqo=;
 b=XKjvg7SPbrgboWOtHB4jyQuqSYqKJkxJHYKrp/G4sqKLckiQwBOB0gFzYre/lOOveKgb
 2kLpT/HmRAKQ0PQZoZFUhTMWqsSsFD0cox9KgViEjbAJuJmLh41+P1mwgtnd+k9Fm8Qce
 NISryihbmYSawl40yiJiajKoSG74jtcdtZa8UqY8jkP8oujsV4vB2K07EtFpWTpb44Zr2
 x3hivjfoE/ubQ3pvIuJMNyfVhnmLquqnstvuMbhxKtRvjadTESX6S6avLyE/r4m9vnmY4
 TnflmkWz1t0qc4kC+2MJBdaWTCS1SJGtRp7zuRcpeGsysNlAaZIIWBbmg8BkRuenA+A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=a8lkm4uf; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SCbfd5Fk; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=a8lkm4uf; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SCbfd5Fk
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D186A405D0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:07:38 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbJBk3642822
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=bqwZzYlOtmm3bnbxauKPSu
 FVom7XYOoLMJjpZm0Csqo=; b=a8lkm4ufdrP47O4TSDhDAN3V46HepLYKmha1jr
 5UhS8o0hwwkfc3hmIhq9Hio5xMHH3dIwR1hbQlxDYXl/vrsYTyw/ZzM1b6fhn6S/
 d+WAmYTj2/3xHRLn0aEaMDFnE8wFx3Lo3yxlPfcD/wLZwIjTrkk9KRKOL1cKp6rO
 q/dIGZcIwswwqHj0KJ3DoI0Ba1DROBt+lNqfIBmabJ+kcEvlNZObuSjKVYOZW2VH
 Vuk1oVEL0jhJnhIQuH74m97FGPFRIsqDeqqIikaig/05ZF6T70qhw06FivNM7I6m
 9KEGDbxrl1tzzKEl7/BzOJhl6P9WbFxSEyYjBOUnhLer15uw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha470acu1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:07:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e83df1d54dso15033395ad.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791994056; x=1792598856;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bqwZzYlOtmm3bnbxauKPSuFVom7XYOoLMJjpZm0Csqo=;
 b=SCbfd5FkKW4UI7RvR/KNBENOalZHij0Dmdl/JyUUHsldgJ8xvu8bSZrh9W7fiCrXbR
 VkElojjeTZ87Wg8m+CWjY1Y8xyulpZPBsnGRjmcw8BiUoxJAahVk7ksxkDGrThdEQDd3
 Zc9p4mOFjM9BQcx8+YSaWYtk+N/Ws6lcUL/oGJnBNwACnbd7J9m+33A84jbDI8qHZ64G
 bNIey7jUnz0GekQo39RT7leM0gBZaidWlPwujvoZ9kyhQqvIES3m9ens9h5wbwyp8CcT
 14+uZCb1jGmWbNHQrfoWVaHFBY3Iwd0nETqcMV4L/Qfv436H6dFdoFcZm1JfbEp/gkCq
 wmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994056; x=1792598856;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bqwZzYlOtmm3bnbxauKPSuFVom7XYOoLMJjpZm0Csqo=;
 b=DnL0A5oqxOxOczcBCGgIXR5jwO4yO893/5wuinhobYlD0Ihtt8xbTv6M1F31GX6BNe
 QeD2w469CjUcJKoowwdwuoPdcclhvuggfLoK7xwh86jgvvkqLMDRq7HhAPm0n6JKE/Tz
 Be9rta8jyCgSaDjRAmByRg0qgY77kr+anQl4zb7jNMJkesVJBgZ71IFA1tB1Iq76NYOq
 WHptLRcfEreaA/4Dheus7S/RibBUo7H7xDWqTyijdsFQnaflyNEaRy0QncjONLXVRUu5
 iggMfjBWr21BpPu0Rsc2FYxH4SE92zz2zVXYzLlbfAp+/0OcDeHvVpPTDq9UWfijaZ4c
 A3rQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8UMbizRwJLXj0fH+Us5c16WXUK+PNmKbkIflHrNvjLaxvBru5ys+TNC4863tQPAcEyG6lqgk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLGzqvR5T8INlWgnJcIw9Ldq8QJ5gMZkSu6GN3FOwyyPPqzL0T9
 B3Kq57aDBpMEiSAFXYTb+HZcl0ATCVAGoUwvxlPYftFnM+1wsnkM0AvOUExE6tdTWRGDFJwb08q
 2ED8v0kajjcImwc7alMMl8o+j3jsuvyy8Ns6tRfW+QRI6B/32GxnVQJdI4979Bgja6BRkwWtv7+
 WCpkk=
X-Gm-Gg: AYBFou0wKiCTexZyuqM6RB5WmwYAmiRWPmbM65GuvbkEhLUU1jAeQf0O33NONOBPTc7
 2LocRJD0U1ZspKclP/aypAxiLKG0j6KPmrZBml1/Q1mKETQ5UhtT7mTWQv5+NuagDFZGfwDjSEh
 DAQpS7XcwyndVs3Xr3FxpZkpIiMsM3KfWOuQB2kCLE7ZY/D8Fjt+28EVNQCQ3b2ni9vLvsHx84y
 BPBxCwA879U7/zINt57DaJ64sAitul5ylo+XSFLDZU0LfOdejlCK5fQEaRQoB9S0PNhpbVwHnmQ
 Z+BT47scnp9SodK5D4UY5fJK4f52Udnjik8DKJoNpDCXnvpww8pTV/IG9zvdte02sEUp5Ii7SrH
 fWyq4sEurAbllyAtuf37Cg0vNoErUuAVXBi/srXa3OA0+WVbCGBVQ8Q1QIo+l9iqhAJ1lOmEswC
 cZWTdsZYWEsKZ8+PLPmeI4Dm8esctiONg0XmP0lw==
X-Received: by 2002:a17:902:e748:b0:2dd:c100:4259 with SMTP id
 d9443c01a7336-2e842f13e23mr146527255ad.61.1791994056008; 
 Wed, 14 Oct 2026 09:07:36 -0700 (PDT)
X-Received: by 2002:a17:902:e748:b0:2dd:c100:4259 with SMTP id
 d9443c01a7336-2e842f13e23mr146526905ad.61.1791994055356; 
 Wed, 14 Oct 2026 09:07:35 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b1807sm71664985ad.43.2026.10.14.09.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:07:34 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 21:37:30 +0530
Subject: [PATCH v4] misc: qcom_geni: fix RX_RFR_WATERMARK to use RX FIFO
 depth, not width
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-geni-rx-rfr-watermark-fix-v4-1-2902fb3f953e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMGoz2oC/32NQQ6CMBBFr0K6dkhLsRBX3MOwKDCFqlCdAmIId
 7fg3s0kb/L/fyvzSBY9u0QrI5ytt24IkJ4iVnd6aBFsE5glPFE8TwS0OFigBcgQvPWI1Gu6g7E
 LNGkuMqHVORWGhf6TMLyP7Wv5Yz9VN6zHfXBPdNaPjj6HfJZ77vAIztUfzyxBQCVVblCaymS8c
 N7Hr0k/atf3cTis3LbtC9A2rb3bAAAA
X-Change-ID: 20260821-geni-rx-rfr-watermark-fix-d48171a6541f
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791994051; l=5469;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=0bqvlO6PMivBVesCedJKunXr8jV81g8829Ml71WEkC0=;
 b=TX8lCbLy+TfLLBXeF9iHWveGUGuj02vJ9LRsQ5SW82QWfv/AVP8O3jFK0PBH5q2PotBhVuYTh
 ngaOEtuIvu+C7VCfNGjMrMqErtK4cXL8xJ9m6xYgSpaBv7mhDB4bwE2
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NCBTYWx0ZWRfX+xcTpeaUpg0H
 5DvZ0xdUFsG2gjlOBbu706+PA6iAWBMynfoNKI3oHL37DzDUFUH3HAH9D1nyQKeoIW6oeKErq5P
 AqCiGOFcDlLPjUAcSn8bOVK+9VGlFzvkDnB2h02ypsfrK7BpOlnh+PR6iUyLOz/9gMV2O0eB66Y
 XZYDY42ZeGhVwbddxOaHutYKzLhXrpRCpo9PjtLQTTNYasTBE81Yn9so7TGKBOazETr1dbD/EhA
 +K1sjKxqB+sb4CTOJcfM3IUQt4aw642Cz4kQGzQ+3UFr8hkm/aCC5CbZjqzJ9mDyXnVuBLARDJi
 TBfAofD33JmsWW4fcBhnsRci+VJrGYcarQSc4UU0gEIN/wS7mgcH3YGriJNLWRjTY1RdPzYjkH5
 Dw5AN3oNPBxN5g9VJzwUntzPC/QysDmjBL9ocpJ02o8fYm3wNpSA8vFbu0hRwwH7ShmjpM1YbTL
 6xN0RCmGLD0FYWJzkxQ==
X-Proofpoint-GUID: Y0KgJ98_U4S4-TO6fF5xXT9rbUk66Saq
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acfa8c9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=di3mCngd5N4KDXw-K4oA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Y0KgJ98_U4S4-TO6fF5xXT9rbUk66Saq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NCBTYWx0ZWRfXwa4jl2jlYQgc
 EqAgxxkESbZDhOod22fdzk2tb2qTT4QRQuGxcbUb+PJutOyIO/2RlInQu67yzbvRE5D8kHd4Ece
 kQKeOmuOmkOdkqmr7Uy51ElV0NudnJ8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140064
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

load_se_firmware() derives the RX_RFR_WATERMARK value from
QUPV3_SE_HW_PARAM_1 using RX_FIFO_WIDTH_BIT/RX_FIFO_WIDTH_MASK, which
decode the RX FIFO element width (bits per FIFO word), not its depth
(number of entries). The watermark register expects a depth-based
threshold, so this produces an incorrect watermark value and, on QUP
HW versions >= 3.10 where the depth field widened to 8 bits for
256-byte-deep FIFOs, an inconsistent one depending on core revision.

This mirrors geni_i2c_get_tx_fifo_depth() in drivers/i2c/geni_i2c.c,
which already reads SE_HW_PARAM_0 with the HW-version-gated
TX_FIFO_DEPTH_MSK/TX_FIFO_DEPTH_MSK_256_BYTES masks for the same
reason on the TX side.

The same depth-vs-width distinction, and the HW-version gating for
QUP HW >= 3.10, was introduced upstream in Linux by commit
fe8aa1ba0783 ("soc: qcom: geni-se: Update Tx and Rx fifo depth based
on QUP HW version"). The Linux driver this file's firmware-loading
sequence was ported from, added by commit d4bf06592ad6 ("soc: qcom:
geni-se: Add support to load QUP SE Firmware via Linux subsystem"),
computes the RX_RFR_WATERMARK value via geni_se_get_rx_fifo_depth()
which applies that same depth mask -- confirming this is a porting
bug rather than an intentional difference.

Extract the major/minor-gated mask selection into a new
geni_se_fifo_depth_mask() helper in <soc/qcom/geni-se.h> instead of
inlining it here, so that other GENI SE drivers (SPI, I2C, UART) can
share it for their SE_HW_PARAM_0/1 TX/RX FIFO depth decoding instead of
duplicating this logic.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
Changes in v4:
- Include <linux/types.h> and <linux/bitops.h> in geni-se.h to make it self-contained
- Make commit message generic, not SPI specific
- Carry Reviewed-by from v1: https://lore.kernel.org/u-boot/20260824-geni-rx-rfr-watermark-fix-v1-1-d83fd078850f@oss.qualcomm.com/
- Link to v3: https://lore.kernel.org/u-boot/20261006-geni-rx-rfr-watermark-fix-v3-1-b368fe3fbf70@oss.qualcomm.com/
---
 drivers/misc/qcom_geni.c   |  9 +++++++--
 include/soc/qcom/geni-se.h | 27 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index a62ae6a2478..f3cf05c1c0b 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -168,6 +168,7 @@ static int load_se_firmware(struct qup_se_rsc *rsc, struct elf_se_hdr *hdr)
 	const u32 *fw_val_arr, *cfg_val_arr;
 	const u8 *cfg_idx_arr;
 	u32 i, reg_value, mask, ramn_cnt;
+	u32 hw_version, rx_fifo_depth_mask;
 	int ret;
 
 	fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
@@ -207,8 +208,12 @@ static int load_se_firmware(struct qup_se_rsc *rsc, struct elf_se_hdr *hdr)
 			       rsc->base + GENI_CFG_REG0 + (cfg_idx_arr[i] * sizeof(u32)));
 
 	/* Configure condition for assertion of RX_RFR_WATERMARK condition. */
-	reg_value = readl_relaxed(rsc->base + QUPV3_SE_HW_PARAM_1);
-	mask = (reg_value >> RX_FIFO_WIDTH_BIT) & RX_FIFO_WIDTH_MASK;
+	hw_version = readl_relaxed(rsc->wrapper_base + QUP_HW_VER_REG);
+	rx_fifo_depth_mask = geni_se_fifo_depth_mask(hw_version, RX_FIFO_DEPTH_MSK_256_BYTES,
+						     RX_FIFO_DEPTH_MSK);
+
+	reg_value = readl_relaxed(rsc->base + SE_HW_PARAM_1);
+	mask = (reg_value & rx_fifo_depth_mask) >> RX_FIFO_DEPTH_SHFT;
 	writel_relaxed(mask - 2, rsc->base + GENI_RX_RFR_WATERMARK_REG);
 
 	/* Let hardware control CGC */
diff --git a/include/soc/qcom/geni-se.h b/include/soc/qcom/geni-se.h
index fc9a8e82cd8..8af78c3a61d 100644
--- a/include/soc/qcom/geni-se.h
+++ b/include/soc/qcom/geni-se.h
@@ -6,6 +6,9 @@
 #ifndef _QCOM_GENI_SE
 #define _QCOM_GENI_SE
 
+#include <linux/bitops.h>
+#include <linux/types.h>
+
 enum geni_se_xfer_mode {
 	GENI_SE_INVALID,
 	GENI_SE_FIFO,
@@ -277,6 +280,30 @@ enum geni_se_protocol_type {
 #define GENI_SE_VERSION_MINOR(ver) ((ver & HW_VER_MINOR_MASK) >> HW_VER_MINOR_SHFT)
 #define GENI_SE_VERSION_STEP(ver) (ver & HW_VER_STEP_MASK)
 
+/*
+ * geni_se_fifo_depth_mask() - Pick the TX/RX SE_HW_PARAM_x fifo depth mask
+ * for a given QUP_HW_VER_REG value.
+ * @hw_version: value read from QUP_HW_VER_REG
+ * @depth_mask_256: mask to use on HW that supports 256-byte-deep fifos
+ *                   (QUP HW version >= 3.10, 8-bit depth field)
+ * @depth_mask: mask to use on older HW (6-bit depth field)
+ *
+ * QUP HW version >= 3.10 widened the fifo depth field in SE_HW_PARAM_0
+ * (TX) and SE_HW_PARAM_1 (RX) from 6 bits to 8 bits; both fields are
+ * gated by the same major/minor check.
+ */
+static inline u32 geni_se_fifo_depth_mask(u32 hw_version, u32 depth_mask_256,
+					  u32 depth_mask)
+{
+	u32 hw_major = GENI_SE_VERSION_MAJOR(hw_version);
+	u32 hw_minor = GENI_SE_VERSION_MINOR(hw_version);
+
+	if ((hw_major == 3 && hw_minor >= 10) || hw_major > 3)
+		return depth_mask_256;
+
+	return depth_mask;
+}
+
 /* QUP SE VERSION value for major number 2 and minor number 5 */
 #define QUP_SE_VERSION_2_5                  0x20050000
 

---
base-commit: 32ebe922e574a733d01c3f106fa77d9176bfecad
change-id: 20260821-geni-rx-rfr-watermark-fix-d48171a6541f

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

