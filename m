Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723A7606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OvRQVM1F;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DQZGBnKo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mi1J4J9D
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D28E640575;
	Thu, 22 Oct 2026 23:24:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b5ETEV5I8KeI; Thu, 22 Oct 2026 23:24:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 263DC404DC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792711447;
	b=XCqai+f6R4OwOsX22j9anzeb6BviJMKFHzZwyVjFZORCFif5el2CkE1L7ROkNCxCoaO+
	 qxE4iBz0x5HzhDcHob7nsoYOW449sIGcXTtB/p8QJKYKi2r+aJQBmScQH9KQuMBg99r1K
	 08kbvWKNhA3lRB01R2bE0XcwhuSGJG+y9+JU+AM2fXcDNgLn2lF7WDY5QtpsY3oo7vkX8
	 bs64cAeiGTPKjZ68CVbZ/AIYtp6JnlDhxmE8fjbBTkcRAwX5P77MKfXKDyvu5qCZ4Y0vs
	 mMqYHhKhbyzVbqpBnzGZg+YMgHZfdDsHELWKWtP0oW5AVQ0+nUSlv5jdyshdJvoslzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711447;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LBlHSoEmzWNfo15ZpBuz9tCRYXe0vfzxIA+efQrmaNI=;
	b=B5HkvT+bUAzNiwzwjEdMu91sBpLDCQ1Tx6lVZL02nxauE4G5MCfHzJmNvsCaBDmINr0A
	 XiWIOLSO9m/ArcEB+qKPwkCFfg+lTAY8Y0983ZfO+7dXQCVDg0yMMTG2yqExg28ORuRyg
	 mm5bXVBJRHrhnQuLdyWH0MBvG08bGh0M9Mxs66db81KWUXfw3attDA8IBD3YqCVHZQ9V1
	 mHvLWSqebrcE+EbkxDJqZzV6Vi8m1ob5Ce71c22h6D/GIDCeTvay9U1jBvV+IRae0ef+g
	 ovswlwiOtCqs3KIL/eyo/UTIjEtngMCUsCuf5xXDDwSeOvlB91gS+CBML31K2Zr1Aog==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792711447;
	bh=LBlHSoEmzWNfo15ZpBuz9tCRYXe0vfzxIA+efQrmaNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OvRQVM1Ff9NU0rQEemubgJpd7N/8Aib9oVuYue0NS808n8YJL69bmE/QX48Og93lP
	 qkpBOd4Ef5ocv+2gFouTEzkUgXPNf1lcZVDJ4cb2oSnvOt1GWoQtF1aA5k+zhNBq1T
	 BwGlrbY3Q+jIfiicBULnzmPUs3kipXyRBZ9MLsemcp5sTAvhTuVgLtrGy70URa+nQ1
	 MiZ/C7MRirhVhRhJNISq7TNaBxO5HfBnH+yNCOjHww5jQ7Q00lnqgB646tv/m5NuOK
	 bK/fnWxO2tEp3amRQ0SE/b/6OYmmOtWbOBroqblqEhFJv6rm0sIy6oVdcAF9Uv4s1x
	 /KM0K5C8h3GJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 263DC404DC;
	Thu, 22 Oct 2026 23:24:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B9989499
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:24:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB2FC4040D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:24:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f2M-nlyn-2LX for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 23:24:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DB71240111
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792711445;
 b=qBRWupGxfdcnlG/DwEpZ9Q5jNPjVffGUW1wDjO79nGS+z6XTJIg6AUxTLO/OL2PJcAkb
 9VH1kdFBOMQy5YHEClmp/uhU2VEf2ntTEWy2SxQAkwB7ULEftWsp2jazsJKT4p57yK/GP
 9a4M7nfra6nxzR0j4PPqb0CoFeuLCQhPtsqq1UhoDeNwu5R9SpJDY6vLaF3jZckXGGS74
 O9UJJplf480rwbQHCwKeAhCVuuoOTtxtNkJJE7P6Bx6inXUmlHX28DRdYQcmULYbTMyq+
 QQSMsLUBPDN1UeLG29ohZzfakhvvOiVQu9I63B7PhGLdVcqTRaM60BOpfzpf/1x6Vpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792711445;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=LBlHSoEmzWNfo15ZpBuz9tCRYXe0vfzxIA+efQrmaNI=;
 b=Za44qaJC0NL840UKIHBMaZCrkh/ptmY4wCh6W24u3El2lV6eyaIU8kuk1u8OiN9fTCMi
 +3/3gp7cyHIHwa9yE6S1HVR52Rd0UKQPAEQwskzt8g+jofVn9haKoYPs30EBODTrFRARp
 yjZFkFSxnJATmKYaDJWdHlx5AWotAKzYG6f83bJcp6vxkMGkSOhlviqrM8MwhArufC3t9
 Z0SDDN/kmtFeDLMM4diVd+Nz3DY7+eawGTXJueNyhusTkEmhqL3yrXbXWBNjV57hH2Iu6
 QTtquom3uYZ90xiLX7UmRbxFupHuZnfhdXsvDQAcKfMqDXvE0L86/CjsB47XpGE+Z6g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=DQZGBnKo; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Mi1J4J9D; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=DQZGBnKo; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Mi1J4J9D
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DB71240111
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:24:02 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMEn201995996
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LBlHSoEmzWNfo15ZpBuz9tCRYXe0vfzxIA+efQrmaNI=; b=DQZGBnKoVWfqxha5
 glfHmsA8WGjMWn/An2ooEg+BerpSfdn+tcrbghZwREzile7ouFqyc9SAyTm7FHa0
 TLrUw3oWAkO5V5BSCtT0jJCV2+QaFG6Y3q0KEZUnMApkuoMLs/Ftcj9IWapWc8P4
 C5arkiuYRcA6zvPU/ob3zaDTk8DtcsiGs75jC2iPmhIN3g4ZnKmqdzNdVFPRM2Rb
 GTld+2rPt1vTvV+I2pLvRsIiB1yaX8NUA7dfQ4AnIlQkAOLoJLPx26O+7pZpHXEN
 ZM1SFeJRNeqHl8hyRILROCw4FQCpDDatBmuNzMrMzaE95EeslBck5FBQ/JZMEfVh
 iISeWQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmr8yjn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:24:02 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8b155f4eb8eso6854197b3.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792711441; x=1793316241;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LBlHSoEmzWNfo15ZpBuz9tCRYXe0vfzxIA+efQrmaNI=;
 b=Mi1J4J9Dnrr9eakxGHL4oHdZJzhwpl6L0lMUxEh5Y+Msz7xEMMOEAlLQ0WSFfOlnfm
 TZgJxjMfpUsIYi48RCN9shw4AhvFWH+h9f6TG0vxrv+iycEqPXKTCtPQVD6w6Gosd6DH
 OF54kKQkbkaR1zMGychTtAHsY/GGxRa/0XfEX9eJiGp1cPLNODtfrAHdCc2bLqdseAGj
 TUjFz3BX524JZc5NPIIdaz+x3lXttH2vCIJlPjXq0Mk+4tHqZazNcCWdC5WGeKQBOQdn
 YUeaL0HLgXMSMhFdtGqzY7AHAiIdBzwttedD2K+nPTQLgpsTl6tMXexPWgsgQH5UpYYN
 BdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792711441; x=1793316241;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LBlHSoEmzWNfo15ZpBuz9tCRYXe0vfzxIA+efQrmaNI=;
 b=SvtySE3v27G22mGKAD2RMwF2mCnR4vYGcoAvmQoxqJxvcxC6nytMXfnyftfUbIB1ym
 C1l1J0ruj/2/U5Tgb54745Y1tOIdYaPSwvlMsfw40DA0qaVaj2Dki+MXYwZ5Thp5ceuZ
 hZ2H9R2MpnK2q36t6PKSfCrS1C7tgexkFJ/WGMoqv4BCfTJaR11vSWMSoRZPndPjgQp6
 ZvtDxVKleOaj9V1SmujSegABOU7P5L0NCAfbnzgoB4xiMjYT/WLCEe51TuPSnWJGmRnW
 1TS3qyEMKSv99HawGZY23c6j5FvaDIZv+SA3zDk5ut+3XZ/zyGFxXTUMW/2IS/czP1KJ
 9yyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByDk/k8HWe+Eohby740CfTq4jRBaU9o6KB//X9nsOMJ8hgadBZqaa9iUSD8TzOEW9Hak0+KyVI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKft3rKm46KREfFt2UfT7GOhW+eIxNdlEQD0QQ1XglAqArCo8Gu
 x5R6J3Uto+Ebs9F9EaDd6Sotu8hYpkz0/aILi1tZ0F5LUhaRS5HF2iEhZwvwC//vJSeAOj9L5N9
 VNOZdN3dDtM7TUX8QZUMKBEyRCld4AsrRRds/k3zMWDwMfMpfpzMPLkO9C2FZuo1PSpzTZNs=
X-Gm-Gg: AYBFou0cwkTIaf1lma73qQp2c/3/XR9SZvfCTAC8C4RZ/weejKhsbaLIp78Ewq+F3Qb
 8WZU9ucYr24gkUb9mwgKVFqZ8NXnGC8DZc4b+l86vwUjE6+5WyEh8BRjuZVu6HP8qUzmeVhSRnH
 Bb0RkPWMgZ1Aqf0xAc0fkEyS0q4IPJXWlvCxZeLiiv8OXBrxlh0x+n/2omAMKvTbE4et68Bxcxz
 kzWnRYN+YyrwU37UwFDryH3m3tHWdSWhnI+vLhJrq0ituxxyy5nk1ucPNBjboLYpHbxDjhFjZ3J
 jdUI5tFFhXEJE1GolU6JL0kYLy50LdyiZlpfeNUFHv9c8iklgcqr0PO8bY6ndkT4+algIKxG9yO
 82Lbag19qxzSgRZKhOR2q2qUDooOdBryfU0KEmH+6u6iGEx4dEn2T6v1beISU
X-Received: by 2002:a05:690c:9d:b0:8b1:e7c:cdcf with SMTP id
 00721157ae682-8b157c8acd3mr3918127b3.1.1792711441204; 
 Thu, 22 Oct 2026 16:24:01 -0700 (PDT)
X-Received: by 2002:a05:690c:9d:b0:8b1:e7c:cdcf with SMTP id
 00721157ae682-8b157c8acd3mr3917887b3.1.1792711440743; 
 Thu, 22 Oct 2026 16:24:00 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b1560cd2dbsm5602957b3.7.2026.10.22.16.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 16:24:00 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, mateusz.kulikowski@gmail.com,
 trini@konsulko.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH RESEND v1] spmi: msm: Fix V5 ownership table offset
Date: Thu, 22 Oct 2026 19:23:54 -0400
Message-ID: <20261022232354.845166-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261008101830.703427-1-aswin.murugan@oss.qualcomm.com>
References: <20261008101830.703427-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _UkidZKr5xi3XJ83csh3LDmpU8tvZZpk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5MyBTYWx0ZWRfX746ksaFJx2kN
 OcdKtgfW6Z38QL9qt5mAKX4hoJG0pEANhA42QRrbG4m/8fBgtLb+0R0BysMfYcKeN7U8My1Rb5x
 m/pnTpr44YD3269HVFpAGg89QttY3M8=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6ada9b12 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=QrNXdSXaJS-RK9Vs7WwA:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5MyBTYWx0ZWRfX3WvyFL7HtzW7
 fYex1G/4h70ALcmZnLJhizu5H2o4Bta/ZEgMC2MK0yAA4nqxTK5FDmwo2inkCPTDF5ohiVA9skm
 Rj7ptxwP/Zfb60o3hkzk92AyC92sG6IofKYujL3oGqsSsOQF8xgSGXesAb423Yvx+escN1mpzHW
 F6kR3rBiAiYWoTfIP6dnlQQac9gTc3DouNuNyxWvo2b48ATlHmMnniByNYQxvb11H/Vv3FuR2PE
 1H8onm/RD6+2+JgC4Yh6U6Vv0S7vDncQUhmRKrXXdX/nvOvnx1cu89UEp68hVwfuvvs9rjjLcqM
 NczXlUHllBGgsOB0V4LUKsB/psDtR3zssXCNjqqdU6eHwKGYMbgP3lq1fPVC5XJ26X7lyPRKFwK
 VSPje3EgYb4BNCR+2kXL/Bw/+xAlLrpefwegfXB2nVMrAKnxuK7qPYFqWDTBHkvzDd81/2o376h
 7NEkGyVeJClYx7lLkaw==
X-Proofpoint-ORIG-GUID: _UkidZKr5xi3XJ83csh3LDmpU8tvZZpk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220093
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 08 Oct 2026 at 15:48, Aswin Murugan wrote:
[...]
> +		owner_addr = priv->spmi_cnfg + 0x700 + ARB_CHANNEL_OFFSET(i);

A define for 0x700 would be nice.

Reviewed-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
