Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9515606A321
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Mfs7pQ1N;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IRc3j6/7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XfATLEwJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C726408EB;
	Wed, 21 Oct 2026 16:12:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H2e5Q1hNY6xk; Wed, 21 Oct 2026 16:12:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 75FF84089C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599132;
	b=DTRRrY7mhKLT7UVdH8sdCjeXCBxCq/P9QEQqEXIOFFOqwXBoJV0OWWGkCFlWV6gQuDKH
	 32ReIvhZg7OCdphcm8wOcdmmr/dXG0Ya74QEz/1SoEipTLmtI0XfqwBe7NVGd/PAEdmCd
	 vY2F3ax+PnaeNBvbdbWz0DSuJgQDto6XbHuzPbEJ3JQaptkEJ2bUMMSK4c74jV+EW5fIq
	 YxFdy0uJ1cJnY/Tk+7o0g1G1NSGEROMjxs03+f/OBbogwJJTJP6TdVXx5coEbckUv7Etx
	 2fP8LBP9ImOcprs1FKET+MPMpsoihDfzxTUaHwDAAsYygzZlHbZ2ua0gy3KrJlUaNrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599132;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mEYLm4hfNpIFDaA7VQu1U8Np5xCt6XPxeeG8x3i9lYM=;
	b=p6uqkfur+CRY7nDJ6XfqxSP/VkRQ50anwsMeGoiyAgUsiYQ9XqBgsQ44s6b/LUQLT36s
	 REIC2eJ1eTJ4NM5H9j1QM/mWI9aTi8NiFQuFMZgbrfOk9eMDliv7AGgpnlemtgvwK92/U
	 NRfnN8NyXwlZneY5lEZ59qv4sizzlPebgF+IymIBSBFg8n4QY56BrwbmeiNgn3UCWg6zr
	 ToWxiA9EJgk0x1Ye1tOK1AYJfOJdJZKAlnR90cZexnMCFcuH25syBWefTed0XnuR7LSKs
	 Hdd9fwKXbzLqpjBTfvwiP/WLIj5yjcUTPmlV8A3r5MoTOkZ0hRCrH64lqWwRpIIxmxQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="IRc3j6/7";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XfATLEwJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599132;
	bh=mEYLm4hfNpIFDaA7VQu1U8Np5xCt6XPxeeG8x3i9lYM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mfs7pQ1NVWCqhoja1wA5j8Qp5k5hEojzUQjXSQcjnFvFEkFJ783MYdviyOk3kDxSD
	 U1n21zXEV9Oc0AcOW130D23HHGEAruqKJT0X/vq9MLR+wajOUOiD0HcQTv4hWTlXC+
	 1y4U9HxM34fLbHyLMc7AsJ7rea4d8zla3Y67Y5MDNLyOTB22MC4W7frXwfORrNE9Ya
	 NHztHWaUEkPc03fETgiT4T/7avcuh7XldzdNVQEKJnH71fThpK9MdlbElAMigF13vE
	 2vPEPv7P99JJMco834VM9oqKIWGT9Pu1rFTtV48me+XMw09fOtIXest7BScYz+Ote3
	 6GxZT38yq8Hvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75FF84089C;
	Wed, 21 Oct 2026 16:12:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B4D771184
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:12:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AADD4089C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:12:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MOaKLkBLfRCs for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:12:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B6817406CF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599130;
 b=eg9rOSCLOwJRy9LQYVAvcT1xgxp9ygN17299RyBPBArUO8f8jwthItO8dJq1FH+XKrPG
 4ztOLMJKeTmucLXnhzvFm7j4qHeFRxjUjm4oVlCB36XdG6GsXPBR/JpnR/6ePaYaZ7irn
 QPEIZxvFUs0e0o94XyhnNQctB5DdE+9zpp/vpt8Vh2qpR73R0HFPgMnTSAnBpMys80Mdk
 SzoLj6VtehuxsVIv2n8HRfjJ1tNe+GRUinuzEtrjNzTs+i1KNfBY4fsl7mqis4d1MGQbg
 s6pekOWhSy3eRLJm4sssKEb2LjaCZnxiy50XBU2nAq7n6rxdSY2mWSioD9hsnkCdY2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599130;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=mEYLm4hfNpIFDaA7VQu1U8Np5xCt6XPxeeG8x3i9lYM=;
 b=mdXXLFG2fj8LapI7hyn+OCjefstZbsslxmcwt5BYfSM/xzXxUxeEfSfDH7FvAlnBk9aD
 4P7tK3r6RBn4LkGifQw8hDdHplByS80ncqNfifmv0sZa2TVB69VJrf3+qcrlw/NOYpdna
 J91rS2FD0ct17XH9ZbkWpUwOpwgO5KRboFy0CqkzUjclIV31mRqjIRtJQvknkyG6awUv8
 CFzNA6Ukewl0kW9OykbQdzBb/GGbtn59TDrtJqrAbKsyq0npywVVT22iyEF8bbxzB6SMZ
 VTT+c95Z+zClhzueugRzB8ktm7S2mJVx4RYtXECpDs0wAbv8pJg27krxUfer6fltExw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="IRc3j6/7"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XfATLEwJ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=IRc3j6/7; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XfATLEwJ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B6817406CF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:12:10 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFoI3n524343
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mEYLm4hfNpI
 FDaA7VQu1U8Np5xCt6XPxeeG8x3i9lYM=; b=IRc3j6/7KneivSguPX1brf8x6o/
 /iU4Z04ohXWub/e27jMx8nmhtprntCcFENy7/yEe8uDZq3r2Nb2O4SuryA3kjujf
 3Kk8j7D7GBPwa0KWNtAgrPx98TmNV6OmOiMvXGaYMCHPH33hYpTrM4l08UvQljR8
 oQxUCClof0dBHVf9WFKEjfZqksFrnv+Fbdge7yXNT8DI2HSQUSESSboT/515FcAR
 qQpmTsWhPovVR1ywc3b+z4C+XtPXfu77PFPVlIGVvmblqeO9Pr9WfULQTxvsyK+g
 PYYR0dgyKRYlFCacn7mnJUwfOD/0TSP3RIvlu+jdhVa8HLsEz+BfyBSQlGw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0cv0388-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:12:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so217183885a.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599129; x=1793203929;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mEYLm4hfNpIFDaA7VQu1U8Np5xCt6XPxeeG8x3i9lYM=;
 b=XfATLEwJn+DrnpYlc2fcqTavnXdKd1e5/I6ynO8gVlXWVgYp+EpLOxWKlC4Lrc4Lui
 ywaY9cm9955QxXmilvtsZkCFhxRctxQp1dvEqpls6lbIVkOWvi+if5M8oR6GzbcmzuGY
 /4ehcOqgdZH7FLPiL1zML5s7fjabMpnfU2hAcVEAbum9A0SSP/BN2AyTtHDkWI229+E5
 Eb9qzeV57/9+3K5rBk1TybWlcgaf0dpG9ospyUAb8zcJXfZFif/09QXzaOP/DcHP/WAD
 ga+tVncA5QcUoqDGCxGpSAmIeOq/tc/J+ZPaqS778wPI4AuiuZ02Cx4gWE7wgSiRQQlW
 ZrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599129; x=1793203929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mEYLm4hfNpIFDaA7VQu1U8Np5xCt6XPxeeG8x3i9lYM=;
 b=Jyy6h1plHiZu2MDULVLM6eSrtp47dDifAG9zM6xNS6piL/D5XbHhJr+kXgNDipPRCm
 ZUT/uh0loQrguc4f7vYEBPFY+GRWAQ99YDzIHGJDvDcTaVfdFHwuG8rzGgOHBfiTiHIS
 tOBsqplZjLmd8mBCY19Uoo5V/cfIJCzEk78tYt0fGDq0I85zvGGHlOZGyFgtft++7ToC
 NWsLmKhI8Nmg3zWTh4LCdHcEiUh+1ZZJGx9k5S/jLE8oZ91H/NMb+1KRTwXrMlg//YBY
 XfuvvuMAUgVosyXRLb1KFDcFWgbCUc7OK4j6pFpqyRTt71DBQKMofGze5pAu0qxIwoql
 0XLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1g/Dd3royWnnlyw94HgBYvkueZhG0/GnoJMafndhO2BaZRcBf+Nn1DAVH3Myo5zzPn1T+dfE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLJ559/SB2zy7sujSR3kxHTEH6DN2nvX5ylzQRB/ibB/uy4gZAf
 BB36kXpcWnWf5RKhyT/64Yt+Z3CJd3Mw/vecc7heh0Kzh5AtZpCKMhF5dXiFYQynhH6VrOcSDuJ
 FFP7ZGopoX22Td+jNdQvv3TotMKKCvEQp3YonSb8fXPGFhdbzM06JnXXp4eClnJFcfANpxTs=
X-Gm-Gg: AYBFou2COfZIgd2ai99z7fk2GABiB0gTPI2PWjEEth/utt0ulu/EWME3q0eVQUb6OVY
 iarw90e/c4f8YcvVPiUJxL3dS7wgd6KnF7jXQkQDtNbLgFffiiPTsqcpVTOKo78L8aw4kshLNon
 WobYv9LEkjd+aTC2MN3F79qxGXM+jldJacq0UU9BmtghWTG8sSHL7lDvBZSilZ36iYGU0kIRzlJ
 95gJzFAN4vZoIL9oTYEB4UnXdE5upG1QACeejh6rWJXT0o7NXLP1hXVjbeZ9hKArcZuW6B0XwJy
 Mz2Zc/jKKiLSBjLRZDZggono6ds49jqompHM9wQBIuKVSsv2bVS38tMO6o1DVNIe/pJhdq5/M4u
 AvDAZ4p/n0K/qbPNWtzN9rvW6bsm+7x+OKSydhUlfWoX44Wy6mmb+as2fq5TISOr3zEnDtsmT7Q
 oJUd1f/EWJhgqE64VfJao=
X-Received: by 2002:a05:620a:4503:b0:93e:dcb4:c73e with SMTP id
 af79cd13be357-93f57e3ff66mr517905185a.5.1792599129104; 
 Wed, 21 Oct 2026 09:12:09 -0700 (PDT)
X-Received: by 2002:a05:701b:2305:b0:164:3237:4483 with SMTP id
 a92af1059eb24-190a6cc887fmr2731315c88.42.1792598734726; 
 Wed, 21 Oct 2026 09:05:34 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903d3ae06fsm7480185c88.19.2026.10.21.09.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:05:34 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, aswin.murugan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, nathbappai@gmail.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, jbx6244@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 4/8] clk: qcom: add NWGCC driver for nord
Date: Wed, 21 Oct 2026 21:34:44 +0530
Message-Id: <20261021160448.3893858-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NrRE4MdJ c=1 sm=1 tr=0 ts=6ad8e45a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=3B2p8TlSs3hVEobYSyMA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 8DEdVAGaRGz3Krt5LsrcV6IFbqlWfS_F
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX46Cj34fsBM8+
 nxj/xamOzbY2rMLjevothzmPhhYKhcHa+LEtKoxPdufPNWjmnG151ZLotMG5SmhFRPMChmxeNHt
 vwaZUuaJDnOkr/XIPE9ix07Yydo0u2U=
X-Proofpoint-GUID: 8DEdVAGaRGz3Krt5LsrcV6IFbqlWfS_F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX4syIbi6ZZdA6
 A3ZpEIKcIvyfawHVnwGjPyka3I+luGnWl+2+rWEzBbVOSMwCfCNf+VTD6I3Iapo/W9zcjGX8+Et
 FgG6gsqRJU992hzL0lX0V8FnawM2oC63UdR8MfDaGVUD3U5d0qFjSH7NQYB9etnCkwItky1S7n/
 FwzuF1qs8RTDFZnefK58tsUrS7/32XzYauYBaxqdoiiikwlZmFumX0kplM13C2X1jJzacwMJNZc
 tkUKq0sb5wibh62SrNpNcEVj8Edeeeg8Z9/iqa0sZqwWsCNlgqnMRlqHs8BEAF6Ae8dLQgMRln+
 dEtqo90SKe9LDPSCe7Pf57gNWcb4C/McvkVGeMfZCd69nadTvCPWudwhqnW7f6JfpujFC0gQAUV
 reWPgUyfv5UnV47Mb3oUUlTgBhe+eBEouO6Rjts5dAfFQij3CmVvO8JdfgeOpNCMHj7tZVWoaf9
 s1kePSRjWiWmprHXCzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064
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

Add support for the nord NW Global Clock Controller (NWGCC).

Implement the qcom,nord-nwgcc driver to provide clocks, resets and
power domains required by nord peripherals.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig            |  9 +++
 drivers/clk/qcom/Makefile           |  1 +
 drivers/clk/qcom/clock-nord-nwgcc.c | 91 +++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-nord-nwgcc.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 943405863ba..78acc9dd42b 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -81,6 +81,15 @@ config CLK_QCOM_NORD_SEGCC
 	  EMAC and QUPv3 clocks and resets exposed by the SEGCC hardware
 	  block.
 
+config CLK_QCOM_NORD_NWGCC
+	bool "Qualcomm Nord NWGCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the North-West Global Clock
+	  Controller on the Snapdragon Nord SoC. This driver supports the
+	  camera, display, EVA, video, and GPU clocks and resets exposed by
+	  the NWGCC hardware block.
+
 config CLK_QCOM_QCM2290
 	bool "Qualcomm QCM2290 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 7ae39fa2026..1ca23a0e022 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
 obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-gcc.o
 obj-$(CONFIG_CLK_QCOM_NORD_NEGCC) += clock-nord-negcc.o
 obj-$(CONFIG_CLK_QCOM_NORD_SEGCC) += clock-nord-segcc.o
+obj-$(CONFIG_CLK_QCOM_NORD_NWGCC) += clock-nord-nwgcc.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
diff --git a/drivers/clk/qcom/clock-nord-nwgcc.c b/drivers/clk/qcom/clock-nord-nwgcc.c
new file mode 100644
index 00000000000..f5345238c9f
--- /dev/null
+++ b/drivers/clk/qcom/clock-nord-nwgcc.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,nord-nwgcc.h>
+#include "clock-qcom.h"
+
+static const struct gate_clk nord_nwgcc_clks[] = {
+	GATE_CLK_POLLED(NW_GCC_CAMERA_TRIG_CLK,        0x16034, BIT(0), 0x16034),
+	GATE_CLK_POLLED(NW_GCC_DISP_0_TRIG_CLK,        0x1801c, BIT(0), 0x1801c),
+	GATE_CLK_POLLED(NW_GCC_DISP_1_TRIG_CLK,        0x1901c, BIT(0), 0x1901c),
+	GATE_CLK_POLLED(NW_GCC_EVA_TRIG_CLK,           0x1b028, BIT(0), 0x1b028),
+	GATE_CLK_POLLED(NW_GCC_GPU_2_GPLL0_CLK_SRC,    0x76000, BIT(6), 0x24150),
+	GATE_CLK_POLLED(NW_GCC_GPU_2_GPLL0_DIV_CLK_SRC, 0x76000, BIT(7), 0x24158),
+	GATE_CLK_POLLED(NW_GCC_GPU_2_HSCNOC_GFX_CLK,   0x2400c, BIT(0), 0x2400c),
+	GATE_CLK_POLLED(NW_GCC_GPU_GPLL0_CLK_SRC,      0x76000, BIT(4), 0x23150),
+	GATE_CLK_POLLED(NW_GCC_GPU_GPLL0_DIV_CLK_SRC,  0x76000, BIT(5), 0x23158),
+	GATE_CLK_POLLED(NW_GCC_GPU_SMMU_VOTE_CLK,      0x86038, BIT(0), 0x86038),
+	GATE_CLK_POLLED(NW_GCC_MMU_1_TCU_VOTE_CLK,     0x86040, BIT(0), 0x86040),
+
+	GATE_CLK(NW_GCC_ACMU_MUX_CLK,          0x1f01c, BIT(0)),
+	GATE_CLK(NW_GCC_CAMERA_HF_AXI_CLK,     0x16008, BIT(0)),
+	GATE_CLK(NW_GCC_CAMERA_SF_AXI_CLK,     0x1601c, BIT(0)),
+	GATE_CLK(NW_GCC_DISP_0_HF_AXI_CLK,     0x18008, BIT(0)),
+	GATE_CLK(NW_GCC_DISP_1_HF_AXI_CLK,     0x19008, BIT(0)),
+	GATE_CLK(NW_GCC_DPRX0_AXI_HF_CLK,      0x29004, BIT(0)),
+	GATE_CLK(NW_GCC_DPRX1_AXI_HF_CLK,      0x2a004, BIT(0)),
+	GATE_CLK(NW_GCC_EVA_AXI0C_CLK,         0x1b01c, BIT(0)),
+	GATE_CLK(NW_GCC_EVA_AXI0_CLK,          0x1b008, BIT(0)),
+	GATE_CLK(NW_GCC_FRQ_MEASURE_REF_CLK,   0x1f008, BIT(0)),
+	GATE_CLK(NW_GCC_GP1_CLK,               0x20000, BIT(0)),
+	GATE_CLK(NW_GCC_GP2_CLK,               0x21000, BIT(0)),
+	GATE_CLK(NW_GCC_GPU_HSCNOC_GFX_CLK,    0x2300c, BIT(0)),
+	GATE_CLK(NW_GCC_HSCNOC_GPU_2_AXI_CLK,  0x24160, BIT(0)),
+	GATE_CLK(NW_GCC_HSCNOC_GPU_AXI_CLK,    0x23160, BIT(0)),
+	GATE_CLK(NW_GCC_VIDEO_AXI0C_CLK,       0x1a01c, BIT(0)),
+	GATE_CLK(NW_GCC_VIDEO_AXI0_CLK,        0x1a008, BIT(0)),
+	GATE_CLK(NW_GCC_VIDEO_AXI1_CLK,        0x1a030, BIT(0)),
+};
+
+static int nord_nwgcc_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map nord_nwgcc_resets[] = {
+	[NW_GCC_CAMERA_BCR] = { 0x16000 },
+	[NW_GCC_DISPLAY_0_BCR] = { 0x18000 },
+	[NW_GCC_DISPLAY_1_BCR] = { 0x19000 },
+	[NW_GCC_DPRX0_BCR] = { 0x29000 },
+	[NW_GCC_DPRX1_BCR] = { 0x2a000 },
+	[NW_GCC_EVA_BCR] = { 0x1b000 },
+	[NW_GCC_GPU_2_BCR] = { 0x24000 },
+	[NW_GCC_GPU_BCR] = { 0x23000 },
+	[NW_GCC_VIDEO_BCR] = { 0x1a000 },
+};
+
+static struct msm_clk_data nord_nwgcc_data = {
+	.resets = nord_nwgcc_resets,
+	.num_resets = ARRAY_SIZE(nord_nwgcc_resets),
+	.clks = nord_nwgcc_clks,
+	.num_clks = ARRAY_SIZE(nord_nwgcc_clks),
+
+	.enable = nord_nwgcc_enable,
+};
+
+static const struct udevice_id gcc_nord_nwgcc_of_match[] = {
+	{
+		.compatible = "qcom,nord-nwgcc",
+		.data = (ulong)&nord_nwgcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_nord_nwgcc) = {
+	.name		= "gcc_nord_nwgcc",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_nord_nwgcc_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

