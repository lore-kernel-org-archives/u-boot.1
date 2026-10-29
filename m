Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFD1606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YFXwZtTJ;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d4imDW5+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QsbfEaBn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B15480D00;
	Thu, 29 Oct 2026 09:20:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 50pyXai_EWpZ; Thu, 29 Oct 2026 09:20:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 587D080E1E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793265633;
	b=BfgGVuSfpHKlKxoO+Z8/eBMFzxaVDKQ4Sgr83zTXFMnCUAfZlJehmsEAr34/9B7Fd81q
	 wsmkJv9Yb/2S2yGNga87GQEWgmDVHL4WG7wq77fdp3T6NiioMkKxNJDDVXlO80A7JnPcN
	 MFtw7qr3opXEcsPO6tXovMAPndd8E+zufWlj+EwFHIEVS8Obau3bcUoQaYM97urUIULFL
	 7hlFwVngw0hvQ9pMjEVRxFXIE56b46BmHv5ehWCoPROP8IpOLfW8ElBaYCUHiM+iYPCjQ
	 iz3S5uOuEa74ly3QFZsyNCokzkX8iGEcNJyOWNzSQDLUKjD54ji68sLuUA870dt5Svg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793265633;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dmJFaSMlp8e2fltFhh77YRBUDBv8ncLMxG6tX6ipWME=;
	b=nMZ8jGHFFV6QdZApAXwJxZf0Ai3fxGMzGAgByc9Afbt0yWQp9ruoiG++943P9kqXdZEn
	 2CKnmPsDYFu7TPZLNOO9fj6QaUt5OoJo3DpZwmEZmR/kt61cN0omGTb6tj7D9rERduMKu
	 SrAda+ACPADM8G7Mz6B3S1v9UvLCsmN1imBqOlL1LWs52UmSeR3k2VHWzQSG52VemId1N
	 F/bkRMkaqIGJXtFOK1pQXVdxydHrZVn0pQlJu4Fzt8IxefXRxoMBx0sYSXAtE4Eg8NfVa
	 +9nvB/CMegydABrNMRqshipWtqQGFTRD1ZpYkAqQ9ceq0rcN6Ky3WMjuq07+I6T95Eg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793265633;
	bh=dmJFaSMlp8e2fltFhh77YRBUDBv8ncLMxG6tX6ipWME=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YFXwZtTJCPQn2oCFnTFoXQ1SL+/wnyYthtt2HKOw9dssosznPrzLd85zZheXiK+Cb
	 yr5nn6b1qTMnB8p3tS8PeMOpyvRL9V72VCQFE/AXzdb2XFJ/+zE78FhyN7pEwucO5a
	 tXFH3DJuTwTzwf9V1o4ulD5IeAQSCq+dH0hLQt3fH7AZ2i1oYMuUdNwZVQAypedWYC
	 RMfJz7ATOLJNxYvfXtv7gSPepR4Rht3kg+EQeTeORW6170c9NWorM2HjZdFUmsF6Gh
	 UocM382nTbYX8xkiCVyjYgWUN3NTpURRaDklfG2nLkODDlFKQBDWq1jFqvKycTHlxA
	 Hj7CCLGuyQBTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 587D080E1E;
	Thu, 29 Oct 2026 09:20:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4533D380
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:20:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2AEEE4032E
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:20:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ag7YDRWkXDMb for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 09:20:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 757C440024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793265631;
 b=S6Ygee8+ElXyVpZofrTpkpurByHRgX2QBnv/r8C4knX8mAyngrn3XmhIOxbXGAYMs4+D
 7KOOQgxhwmy6aO1df5EgOWZS7V9Jdl2ZsTDZi6jkjKDSl5XiqRfPJZJ9GMFE9SDdTStzB
 BxJjytNmsMNW3oLrK9IE4y7/Jhp6xlmZsjdhR0u+/myNcHdpGDSrHFqbGGPZNphJPT9kP
 PLnHaXqDKOq17HGKhuVycnv8LPw9GN4RESz0TccjfltU0EBRpTjWESOHY0FFc/7qN6nok
 xe4ZVy4BuNKfVeTiLTt2dtKNamzZAkd2CIdkO/Pu4boVbfHRAVAJX1k293bD8XQjmmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793265631;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=dmJFaSMlp8e2fltFhh77YRBUDBv8ncLMxG6tX6ipWME=;
 b=gUlkLSD7ZbBMkdkp65+Jcyuj1d4Y/aBUUu6Y4pEH9e7dp4vGr+lc7YBWFQfEfCR3NhoT
 CCXAi1PSJ3ZA/zGR2r1YU1rzAIrYs4wMP2Np8z6eqc2tmRkMPlwmxjhgbjM6Q5Dx1D63H
 Wqv9makfM5bwdOsiG8gBF8v7LqfbTp2vxd2rHyMZJ2G5aLWviGKbEhXfKv2hVXpWAxQrZ
 9djQLOJcUUGEfdcZTRxllprpdsUoxLQd3POGfXM4dPForVi5qmKtAgefmMmGPnYvn5weB
 ho70IytsLLvAFER4SGrewDaZ1RvazDGs2v6Yt5weSGXE1VMycXVRPM8V9i3F3SuDYmw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=d4imDW5+; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QsbfEaBn; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=d4imDW5+; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QsbfEaBn
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 757C440024
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:20:29 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8vVRS179464
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=dmJFaSMlp8e2fltFhh77YR
 BUDBv8ncLMxG6tX6ipWME=; b=d4imDW5+XB10etzRuQaAIbB6b4LoBrZneCj5+g
 qGeoQttdDCDilc1CJ91dh17jF/7uVwhr4oPnucM4dA8SNHKp5pSxjOQvXIw7OBKn
 leLap/peMZ+H6svHdL4sBB8vpnWICM9Y159UVqNF2SRMmj0jNK9yHimXr1ifYtcW
 5uHfdUGSRH9INbI7Yjpe6CdVSN/xa9inSaeOH198lZ+yWVaDCO2DB2tjVu7hYjgk
 GmGu9vPvlgxCuNsw8KKsatafTkdA6RVwXffxzfgFxcVKngkViMT4FewjF4w/by/1
 oRsypoFwjvXA3+5I5HKjaS31wGncRLgOHzoB6yD1+YIzkT1w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpmc2tyu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:20:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f32050e72so422378185a.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 02:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793265628; x=1793870428;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dmJFaSMlp8e2fltFhh77YRBUDBv8ncLMxG6tX6ipWME=;
 b=QsbfEaBnHomjBJVUjbXzfYm1tUaJ045ghRic1Mbmf0ABNbBhTd9w+0xSHFpMh4oqe+
 XP5CGexWLdWVd96e1yYpg0FfhDtal44ywUliR3AZvuMcz6sY0OnqkaMSoBnjnWRhJjLO
 0to5uzgcCkAbFkN3LP9P55T/cEDGTyqp+VjM9BWm8frIv2msTTE/GrJvnl7ZIMl9LbZI
 Q4Yx+zXqg6zI2JXmezoI+4YAryzShJuJT55DbBCtvVwfe9kycUf2cJU/5u5OSVY3afpL
 +CQwV8WIahFBXLJ/xYbkt8ci7egSpluEu5IBxYEO5lADksdZcQE8WbGSheAOrPH2Gb7b
 6rCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793265628; x=1793870428;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dmJFaSMlp8e2fltFhh77YRBUDBv8ncLMxG6tX6ipWME=;
 b=eU4uRPetiUK7nZQP6N/qW6xdHwUYIPjCBzZx6qplfP6bbxMuk/Ve54L/OmB+NUx8TR
 K1zmUBBdnWCUx4ILLJ+xa1hVn+vqKKguE0Fyhs+/A3/NEvFDkDlulHv602MZzQOi+kgg
 cOHuFFKBttSHMlo2kZn3vn2FZudUXmQx4Ein/69ZWyCDFB4sztfy94lahn3H5DyFxTh7
 66qlouP4a+jjuSjXAA2OrzsO+rh05Cakq5I6rtygAfYwRDoWIy6UuCT3jEiV23NLstne
 Y/CL4dz9AExiK6ZYHGD4mhx8sdQLSdmkZSUR38kEVDhoETcybN4h/+yg2E3YpJPGvJQR
 ikng==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXqM4qRV7inctHdG2IWxjyi9PzjffeO4v3dQo2awLeCJsA0N2bOy59DTXqTLusa5GLQrRWCLY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIpNg7uBeUPETPIsyQym1lndNNB1vsyVXqlsFxiz17UM80TWAve
 6oudLdSgezQiy6Jy0ei3LygPRChLPRTyouiqsHXAgBgF9ygid1ZLBmCTNJMjbt9Ud8MsxXHpJYw
 xPOwY5BqULc5jcqvwpIvy7aH1sg22WE+C8aBKsH8ndLw9KOmu9JDkIvCdO9oHMSbDzZHf1pB8Jq
 nVP4z0fQ==
X-Gm-Gg: AYBFou1MDgjlPHjxlwdWyyZECLr9ik4U4utBA8526WfdebzdMgFdrOe4OF6H16RwTRJ
 BBwQDfamPaBbWM+2bSHvEp2U1RHrsvcBP3yU1XF/mLNtwcEtRCksrKjAEcaWALIW92myoVjLEwJ
 YH6kG/XppkshdRcC3rTN14t/aqsLdBOQJ6vuQs7mlJBNRYY8mQWbktLM1xZMScgtW+qt+TVIDnP
 LnTByffDL3Q4TSTEUvLSaEOdUnENyTDu4VN63eGlOQlouGyPCeK5HEX1sQySnMabPito854DGE7
 zSkx1KuyeqvOysbT1Pt/LPnIMO7pwPK5iLsnJGpchfP/j/OpU15GHu2Qyba+Uo2LSWnOA+A+rzf
 Uo3rSjWVN7JmzzkZhb45b0wYD4082JB9wAr3eCX1ROHQfpbayiZablLsqMR+Fkho3jiKUWYeBhL
 Zh9l6aGVGHKM08
X-Received: by 2002:a05:620a:1a27:b0:93b:ef24:bc8c with SMTP id
 af79cd13be357-94408cde203mr748180685a.47.1793265627767; 
 Thu, 29 Oct 2026 02:20:27 -0700 (PDT)
X-Received: by 2002:a05:620a:1a27:b0:93b:ef24:bc8c with SMTP id
 af79cd13be357-94408cde203mr748177385a.47.1793265627313; 
 Thu, 29 Oct 2026 02:20:27 -0700 (PDT)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd350a61sm709538966b.12.2026.10.29.02.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 02:20:26 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 10:20:19 +0100
Subject: [PATCH] bootstd: android: load and verify init_boot
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-upstream-android_init_boot_b4-v1-1-30c95feee363@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBA0avIrBtIBrHGq0gJsZnaWTSRiYoQc
 ndDNx/e5hfIJEwZpq6A0MmZU2wwjw7eXx9XUhyaATUORuOoji3vQv6nfAySODiOvLslpZZeoQ3
 WY/802g7QHpvQh6//f37VegP/00F5bwAAAA==
X-Change-ID: 20261028-upstream-android_init_boot_b4-29d9a2471096
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=X4nHu2Te c=1 sm=1 tr=0 ts=6ae30fdc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=dv4hJVC322V3UhSBL6YA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: Pm6q2SkHI__qJ-1uUQ7SZxzdq2sOAbcZ
X-Proofpoint-ORIG-GUID: Pm6q2SkHI__qJ-1uUQ7SZxzdq2sOAbcZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzNiBTYWx0ZWRfXz/BVP3kcXjGJ
 X4W8l+W77+V8MGWgz7Z1mgSu0+I+elcDT8NIlmXEqAB/CP/Nfw6q7r/iNX2QsbRRU/dwQje917G
 geyXepqkZ24aTC512YHi9jz0sdi7clhkGJg+XWztA5tGbT72aJZ/iN5omtkG2cq8NV+YMraxdCr
 jLjRZEUbuOmO9OJGN0m2px7U3/6FyDqsNpUNXgnZhA/j75VTFIE2wBKVDKM9JHndB1hlTpdDHaC
 huxdmmKnHOy3+FJd+qTKVWGkGK0qHHTJDwLm6MCo2yvaeEbiFY4UlmbeNcfK+KLVBE0xlE3bu1u
 lchc3f7ZKdqHocvSL4iryhTB8eXOiCWLsqk3IISIa/DIxJDZgLpGNXDoo0s9Fb5w6wV4ESitkW2
 yR1AjJS4o2VMPdhhcvJElETZdbmzvZKQJqXJcmDnzouwHNGVEXVQfSJeOIubFjDHGf22UPE7v59
 AFqh360cOncgf1aLavQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzNiBTYWx0ZWRfX4kVDgjEn6LIf
 SpfNNisXS43eEvGsNAkjCKGZuph3n/jSPrTyQk1mzZox8A3Cf8C6E9BWJ9FrvE/HWipf1n4ZZhn
 sdZbQS10aFkExU8H0dTxQtLtMyAbj1E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290036
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since Android 13 (boot image header version 4) the generic ramdisk lives
in its own init_boot partition and boot holds only the GKI kernel. The
bootmeth loaded boot and vendor_boot only, so such a device could not
reach init unless its images were repacked.

Scan init_boot like boot and vendor_boot through a shared helper (the
header is the boot image header with a kernel size of 0), load it to
init_boot_comp_addr_r, add it to the partitions libavb verifies (as a
preloaded buffer, like the others) and hand it to bootm through
set_ainit_bootimg_addr(), which then takes the generic ramdisk from it.
A header version 4 device without an init_boot partition still boots
with the ramdisk from boot; a broken init_boot is an error.

Tested on QEMU virt with the Cuttlefish arm64 images: boot, init_boot
and vendor_boot are verified in place and Android starts from the
unmodified GKI boot image.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Devices launched with Android 13 or later keep the generic ramdisk in
the init_boot partition, so the Android bootmeth could not boot them
from an unmodified GKI boot image. This adds init_boot to the images
the bootmeth loads and has libavb verify.

Split out of a larger Android bootmeth series; it applies to and builds
on its own on main.
---
 boot/bootmeth_android.c          | 187 +++++++++++++++++++++++++++------------
 cmd/abootimg.c                   |   5 ++
 doc/develop/bootstd/overview.rst |   4 +
 include/image.h                  |  10 ++-
 4 files changed, 149 insertions(+), 57 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 6f7e232d2c3..0fabeecdb7b 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -30,6 +30,7 @@
 #define BCB_PART_NAME "misc"
 #define BOOT_PART_NAME "boot"
 #define VENDOR_BOOT_PART_NAME "vendor_boot"
+#define INIT_BOOT_PART_NAME "init_boot"
 #define SLOT_LEN 2
 
 /**
@@ -41,6 +42,16 @@
  * @boot_mode: Requested boot mode (normal, recovery, bootloader)
  * @slot: Nul-terminated partition slot suffix read from BCB ("a\0" or "b\0")
  * @header_version: Android boot image header version
+ * @boot_img_size: Size of the boot image (from its header)
+ * @vendor_boot_img_size: Size of the vendor_boot image, header version >= 3
+ * @init_boot_img_size: Size of the init_boot image, header version >= 4 and
+ *	the partition exists (0 otherwise)
+ * @boot_addr: Where the boot image was loaded (0 if not loaded)
+ * @boot_part_size: Size of the boot partition in bytes
+ * @vendor_boot_addr: Where the vendor_boot image was loaded (0 if not loaded)
+ * @vendor_boot_part_size: Size of the vendor_boot partition in bytes
+ * @init_boot_addr: Where the init_boot image was loaded (0 if not loaded)
+ * @init_boot_part_size: Size of the init_boot partition in bytes
  */
 struct android_priv {
 	enum android_boot_mode boot_mode;
@@ -48,11 +59,13 @@ struct android_priv {
 	u32 header_version;
 	u32 boot_img_size;
 	u32 vendor_boot_img_size;
-	/* Where boot and vendor_boot were loaded, and the partition sizes */
+	u32 init_boot_img_size;
 	ulong boot_addr;
 	ulong boot_part_size;
 	ulong vendor_boot_addr;
 	ulong vendor_boot_part_size;
+	ulong init_boot_addr;
+	ulong init_boot_part_size;
 };
 
 static int android_check(struct udevice *dev, struct bootflow_iter *iter)
@@ -71,7 +84,25 @@ static int android_check(struct udevice *dev, struct bootflow_iter *iter)
 	return 0;
 }
 
-static int scan_boot_part(struct udevice *blk, struct android_priv *priv)
+/**
+ * scan_image_part() - Read and check the header of an Android image partition
+ *
+ * @blk: Block device holding the partition
+ * @name: Partition name without the slot suffix
+ * @slot: Nul-terminated slot suffix ("a\0") or NULL without A/B
+ * @hdr_size: Size of the image header to read
+ * @is_hdr: Checks the magic of the header
+ * @get_size: Computes the image size from the header
+ * @img_sizep: Returns the image size
+ * @hdr_versionp: If not NULL, returns the boot image header version
+ * Return: 0 if OK, -ENOENT if the partition does not exist, other negative
+ *	errno on failure
+ */
+static int scan_image_part(struct udevice *blk, const char *name,
+			   const char *slot, ulong hdr_size,
+			   bool (*is_hdr)(const void *),
+			   bool (*get_size)(const void *, u32 *),
+			   u32 *img_sizep, u32 *hdr_versionp)
 {
 	struct blk_desc *desc = dev_get_uclass_plat(blk);
 	struct disk_partition partition;
@@ -80,16 +111,16 @@ static int scan_boot_part(struct udevice *blk, struct android_priv *priv)
 	char *buf;
 	int ret;
 
-	if (priv->slot)
-		sprintf(partname, BOOT_PART_NAME "_%s", priv->slot);
+	if (slot)
+		snprintf(partname, sizeof(partname), "%s_%s", name, slot);
 	else
-		sprintf(partname, BOOT_PART_NAME);
+		snprintf(partname, sizeof(partname), "%s", name);
 
 	ret = part_get_info_by_name(desc, partname, &partition);
 	if (ret < 0)
-		return log_msg_ret("part info", ret);
+		return log_msg_ret("part info", -ENOENT);
 
-	num_blks = DIV_ROUND_UP(sizeof(struct andr_boot_img_hdr_v0), desc->blksz);
+	num_blks = DIV_ROUND_UP(hdr_size, desc->blksz);
 	bufsz = num_blks * desc->blksz;
 	buf = malloc(bufsz);
 	if (!buf)
@@ -101,66 +132,53 @@ static int scan_boot_part(struct udevice *blk, struct android_priv *priv)
 		return log_msg_ret("part read", -EIO);
 	}
 
-	if (!is_android_boot_image_header(buf)) {
+	if (!is_hdr(buf)) {
 		free(buf);
-		return log_msg_ret("header", -ENOENT);
+		return log_msg_ret("header", -EINVAL);
 	}
 
-	if (!android_image_get_bootimg_size(buf, &priv->boot_img_size)) {
+	if (!get_size(buf, img_sizep)) {
 		free(buf);
-		return log_msg_ret("get bootimg size", -EINVAL);
+		return log_msg_ret("get image size", -EINVAL);
 	}
 
-	priv->header_version = ((struct andr_boot_img_hdr_v0 *)buf)->header_version;
+	if (hdr_versionp)
+		*hdr_versionp = ((struct andr_boot_img_hdr_v0 *)buf)->header_version;
 
 	free(buf);
 
 	return 0;
 }
 
-static int scan_vendor_boot_part(struct udevice *blk, struct android_priv *priv)
+static int scan_boot_part(struct udevice *blk, struct android_priv *priv)
 {
-	struct blk_desc *desc = dev_get_uclass_plat(blk);
-	struct disk_partition partition;
-	char partname[PART_NAME_LEN];
-	ulong num_blks, bufsz;
-	char *buf;
-	int ret;
-
-	if (priv->slot)
-		sprintf(partname, VENDOR_BOOT_PART_NAME "_%s", priv->slot);
-	else
-		sprintf(partname, VENDOR_BOOT_PART_NAME);
-
-	ret = part_get_info_by_name(desc, partname, &partition);
-	if (ret < 0)
-		return log_msg_ret("part info", ret);
-
-	num_blks = DIV_ROUND_UP(sizeof(struct andr_vnd_boot_img_hdr), desc->blksz);
-	bufsz = num_blks * desc->blksz;
-	buf = malloc(bufsz);
-	if (!buf)
-		return log_msg_ret("buf", -ENOMEM);
-
-	ret = blk_read(blk, partition.start, num_blks, buf);
-	if (ret != num_blks) {
-		free(buf);
-		return log_msg_ret("part read", -EIO);
-	}
-
-	if (!is_android_vendor_boot_image_header(buf)) {
-		free(buf);
-		return log_msg_ret("header", -ENOENT);
-	}
-
-	if (!android_image_get_vendor_bootimg_size(buf, &priv->vendor_boot_img_size)) {
-		free(buf);
-		return log_msg_ret("get vendor bootimg size", -EINVAL);
-	}
+	return scan_image_part(blk, BOOT_PART_NAME, priv->slot,
+			       sizeof(struct andr_boot_img_hdr_v0),
+			       is_android_boot_image_header,
+			       android_image_get_bootimg_size,
+			       &priv->boot_img_size, &priv->header_version);
+}
 
-	free(buf);
+static int scan_vendor_boot_part(struct udevice *blk, struct android_priv *priv)
+{
+	return scan_image_part(blk, VENDOR_BOOT_PART_NAME, priv->slot,
+			       sizeof(struct andr_vnd_boot_img_hdr),
+			       is_android_vendor_boot_image_header,
+			       android_image_get_vendor_bootimg_size,
+			       &priv->vendor_boot_img_size, NULL);
+}
 
-	return 0;
+/*
+ * init_boot carries the generic ramdisk since Android 13 (boot image header
+ * version 4) and uses the boot image format, with a kernel size of 0.
+ */
+static int scan_init_boot_part(struct udevice *blk, struct android_priv *priv)
+{
+	return scan_image_part(blk, INIT_BOOT_PART_NAME, priv->slot,
+			       sizeof(struct andr_boot_img_hdr_v0),
+			       is_android_boot_image_header,
+			       android_image_get_bootimg_size,
+			       &priv->init_boot_img_size, NULL);
 }
 
 static int android_read_slot_from_bcb(struct bootflow *bflow, bool decrement)
@@ -304,6 +322,22 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 		}
 	}
 
+	/*
+	 * Header version 4 devices normally have init_boot, but a device may
+	 * still keep the generic ramdisk in boot: a missing partition is not
+	 * an error, a broken one is.
+	 */
+	if (priv->header_version >= 4) {
+		ret = scan_init_boot_part(bflow->blk, priv);
+		if (ret == -ENOENT) {
+			log_debug("no init_boot partition\n");
+			priv->init_boot_img_size = 0;
+		} else if (ret < 0) {
+			log_debug("scan init_boot failed: err=%d\n", ret);
+			goto free_priv;
+		}
+	}
+
 	/*
 	 * Ignoring return code for the following configurations:
 	 * these are not mandatory for booting.
@@ -442,7 +476,9 @@ static int run_avb_verification(struct bootflow *bflow)
 {
 	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
 	struct android_priv *priv = bflow->bootmeth_priv;
-	const char * const requested_partitions[] = {"boot", "vendor_boot", NULL};
+	/* boot, vendor_boot, init_boot and the terminator */
+	const char *requested_partitions[4];
+	int num_requested = 0;
 	struct AvbOps *avb_ops;
 	AvbSlotVerifyResult result;
 	AvbSlotVerifyData *out_data = NULL;
@@ -461,10 +497,21 @@ static int run_avb_verification(struct bootflow *bflow)
 		sprintf(slot_suffix, "_%s", priv->slot);
 
 	/*
-	 * Hand libavb the buffers boot and vendor_boot were loaded into by
+	 * Verify what gets booted: boot always, vendor_boot from header version
+	 * 3 and init_boot when the device has one (header version 4). All of
+	 * them are hash partitions in vbmeta.
+	 */
+	requested_partitions[num_requested++] = BOOT_PART_NAME;
+	if (priv->header_version >= 3)
+		requested_partitions[num_requested++] = VENDOR_BOOT_PART_NAME;
+	if (priv->init_boot_addr)
+		requested_partitions[num_requested++] = INIT_BOOT_PART_NAME;
+	requested_partitions[num_requested] = NULL;
+
+	/*
+	 * Hand libavb the buffers the images were loaded into by
 	 * boot_android_normal(), so the bytes it hashes are the bytes that get
-	 * booted and the partitions are read only once. vendor_boot exists from
-	 * boot image header version 3 on.
+	 * booted and the partitions are read only once.
 	 */
 	snprintf(partname, sizeof(partname), "boot%s", slot_suffix);
 	ret = avb_ops_add_preloaded(avb_ops, partname,
@@ -486,6 +533,18 @@ static int run_avb_verification(struct bootflow *bflow)
 			goto out;
 		}
 	}
+	if (priv->init_boot_addr) {
+		snprintf(partname, sizeof(partname), "init_boot%s",
+			 slot_suffix);
+		ret = avb_ops_add_preloaded(avb_ops, partname,
+					    map_sysmem(priv->init_boot_addr, 0),
+					    priv->init_boot_img_size,
+					    priv->init_boot_part_size);
+		if (ret) {
+			ret = log_msg_ret("avb preload init_boot", ret);
+			goto out;
+		}
+	}
 
 	ret = avb_ops->read_is_device_unlocked(avb_ops, &unlocked);
 	if (ret != AVB_IO_RESULT_OK) {
@@ -602,6 +661,7 @@ static int boot_android_normal(struct bootflow *bflow)
 	int ret;
 	ulong loadaddr = env_get_hex("loadaddr", 0);
 	ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
+	ulong iloadaddr = env_get_hex("init_boot_comp_addr_r", 0);
 
 	/*
 	 * Load the images first and verify them in place: libavb hashes these
@@ -623,6 +683,19 @@ static int boot_android_normal(struct bootflow *bflow)
 		priv->vendor_boot_addr = vloadaddr;
 	}
 
+	if (priv->init_boot_img_size) {
+		if (!iloadaddr) {
+			log_err("init_boot_comp_addr_r is not set\n");
+			return log_msg_ret("init_boot addr", -EINVAL);
+		}
+		ret = read_slotted_partition(desc, "init_boot", priv->slot,
+					     priv->init_boot_img_size, iloadaddr,
+					     &priv->init_boot_part_size);
+		if (ret < 0)
+			return log_msg_ret("read init_boot", ret);
+		priv->init_boot_addr = iloadaddr;
+	}
+
 	ret = run_avb_verification(bflow);
 	if (ret < 0)
 		return log_msg_ret("avb", ret);
@@ -634,6 +707,8 @@ static int boot_android_normal(struct bootflow *bflow)
 
 	if (priv->header_version >= 3)
 		set_avendor_bootimg_addr(vloadaddr);
+	/* bootm takes the generic ramdisk from init_boot when set */
+	set_ainit_bootimg_addr(priv->init_boot_addr ? iloadaddr : -1);
 	set_abootimg_addr(loadaddr);
 
 	if (priv->slot)
diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index eae3e643b60..e8e6b8f5ced 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -33,6 +33,11 @@ ulong get_ainit_bootimg_addr(void)
 	return _ainit_bootimg_addr;
 }
 
+void set_ainit_bootimg_addr(ulong addr)
+{
+	_ainit_bootimg_addr = addr;
+}
+
 ulong get_avendor_bootimg_addr(void)
 {
 	return _avendor_bootimg_addr;
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index eab44d0cdb2..058a97a6915 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -296,6 +296,10 @@ script_size_f
 vendor_boot_comp_addr_r
     Address to which to load the vendor_boot Android image, e.g. 0xe0000000
 
+init_boot_comp_addr_r
+    Address to which to load the init_boot Android image (boot image header
+    version 4 devices with an init_boot partition), e.g. 0xe4000000
+
 Some variables are set by script bootmeth:
 
 devtype
diff --git a/include/image.h b/include/image.h
index f059fc5811c..af977069451 100644
--- a/include/image.h
+++ b/include/image.h
@@ -2210,10 +2210,18 @@ void set_abootimg_addr(ulong addr);
 /**
  * get_ainit_bootimg_addr() - Get Android init boot image address
  *
- * Return: Android init boot image address
+ * Return: Android init boot image address, -1 if there is none
  */
 ulong get_ainit_bootimg_addr(void);
 
+/**
+ * set_ainit_bootimg_addr() - Set Android init boot image address
+ *
+ * @addr: Address of the init_boot image, -1 if the ramdisk is in the boot
+ *	image
+ */
+void set_ainit_bootimg_addr(ulong addr);
+
 /**
  * get_avendor_bootimg_addr() - Get Android vendor boot image address
  *

---
base-commit: c267fa81d42b5a5bd1055d3858f74496faa6082f
change-id: 20261028-upstream-android_init_boot_b4-29d9a2471096

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

