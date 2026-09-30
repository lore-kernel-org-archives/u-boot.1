Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0D9CA5FB1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 06:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33FD580C38;
	Wed, 30 Sep 2026 06:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rDaJ1XDCQNdp; Wed, 30 Sep 2026 06:35:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4BD618102D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790750116;
	b=C4Nkhxr1bc0JcC1YwgVr9BYu9Ix342XDp01ukQ9HeCGh4/51YGG3nLODGkOCdVREVEuX
	 sH/ESz1G9hvnDIky5Sz7ygmqLn3zNxEU7cfmpsqlHGH+US04u5/lpPJ2IsZWBBWKvX5wR
	 ezOMI1bUPfq/DPM4XnvwrJbbQXrAX4EPp+GTwNwpLXxl6989zOXbNcx1aSFGnT3vH/mVj
	 McZ5M4s/QCOrVZW2MrSb8lWYkM+2cp2zw4cDTCZuBr0/Uikm3h9B3NCQS1yoNIa5/RdYh
	 DvVCMNQsmTpm5zC5rprMnV+TGP2U64Or8m652jy/oEmD0CET553oedJRaSsCihKQNDw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790750116;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
	b=DBJkrsJTyG2rMgs880rc5SWaOz+ujblyAWJm3k7HlTdgTkKo3smRVi0JDaVecBp+8pxQ
	 SjrIYG49pOqD1ngQBmexxvUDMRu0r0XIXyb5JjgLIUIwI/o0QRRlQKTa5SD9xwftSSt+Z
	 hPllE0ek1yeHrc66fazh4b7x3xR01+W/fkkY+aE1HfXXq4X4FZL/y8neUxOcqmWjbrX3p
	 6egBhoH5hlpEDWSNp19x4YT6OHIGC41sFGc1tJVTy4j4hB1b7269MIGwqbUSyUgFCfYL6
	 SojPm4Kx64caOAP+10/5xpi4TSQifPZlHH0qMgZLqZ/tBu8iYuYyhM+pO5H/BOwRqSQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=COCxMNiF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DGISN+oi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790750116;
	bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n1W66N8LsP6u0YW4Se1zmE9cCvvT/3r8IU/GU29LntmuN29hpsURaFI3muX8zhkRc
	 3MQ2PaP8tayeOVkl27ZwswI3XkhDxc2jbOEqVJmkfDtmqEaECbp1tPWFGj1vb/saOM
	 4p3PET+RWmZQMzCpA8Gwwt2KKkMhO0ynnaDgxeOSXDdD9AOFXCPhseHvBJ3bdkEdFo
	 flpQGHOGHLH72+MPonI5orr+9e6bDjwWqm5NWckbOG71nYettbFUojfK103UTsfCbZ
	 LI/5TYBQe3tw9m7OS6g4DW31nqlemw0oEKC2iFd7VuIg9Bx1cc1keuFQn4Pe4chGMj
	 gR9eCIjHY8Glg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BD618102D;
	Wed, 30 Sep 2026 06:35:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DE5EF32F
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D740F80EFA
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PrNXFZXsJqPX for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 06:35:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0D3B980AED
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790750108;
 b=Bh/5wJyDXx21ZZfegQS73uZYQdUzsT6yT6shhv4toZWemZyxSYT1gdu9xwcdnIHEFWgx
 O8qSMgmESVLPRraW0A+bJRyaaF5yOfNdI0r0qYopbYNpnzlnGB5XrpG+8E84vBBtwweb5
 vmMRRH1wTZEfS0LIVMYEceG28UztNrFAfsB/z9VXEgqlqQSLwUSjwf1FK45Mj9FmLM8SD
 +tlEoyc+0UyjBSFw7B9j7lsiW/B1T85KHnMtp5khuACP93T8tbxozNNW0D6UoVaa93zfE
 tiBxVUmfHzoKkuHFLAnv++N2qn4SQhG+snCuLWfYIX4ZKJikzpVr2kybY738HymNuWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790750108;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
 b=e+d1gfS10oK+2aKZMfZBM7IdHD+RWc2hlqCqFztPNDu+b2w0eZfAKQFIK+3wBnQH+1Qq
 YwoG6qHVdcMiGLFkewYJXEfEPuY9JTHUdH1UE2MdjunitaMPOTc1+gTmKv6GsGjbbpt9B
 B6Q0X1UyVEO0ZmZIkzfE50K9g79a+LA8nMyHynZVg9Lxy2rmUkTNv21odbfF/ffCP8ede
 5+33KjcF9BHxmUVw8/O3TxG1uSTQuYNBTtftPfz1fiMEdCJNcLqYJ1Qkh+BfYmKnT/DQh
 7xbut+WpMma9Y3WeM2JEo3wrORmqnxUMAxNn79YtA8Mh2xvEv4xUtkNl/JsxI4e48+g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=COCxMNiF; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DGISN+oi; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=COCxMNiF; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DGISN+oi
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D3B980AED
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:07 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U6R77O2876480
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8k212rEkKH7
 as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=; b=COCxMNiFHJi6kt8x0f+hRhe2xJC
 5inLH71LXHuU8Kk21S2LWmao/ey7+/5uuI7ks3GblgIczccagR+84UcmyN/lkMt7
 L6KyGSxIRTPZjmZ6ZQNjtDcjujg235Al3x8ai1R4mPuo+s585Lg/YTnslnG1AJGJ
 +9DKo6k9fLlDpv+uPGdXUPni5u8+NqORX7N/TDRxPxaobV0zukHJdjk5ufXbVKky
 RmkvwRhDX35cWFsaNSxgvFnBw1EyEQhRtnVTiQ8Ea1GUvl3GdxomS7spFJLvh8pz
 AJegyK3WYE5Jg34hfV/jJ/SbsDeA8i9rN3NKwRx8R+E1ep1I13U4ksUSvVw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0et2bv06-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:06 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-342b66c0b06so1887004eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790750106; x=1791354906;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
 b=DGISN+oiiu6ZpBHScqizQUIT3zJxuYKom2n6xIEnD8hJ2zErAsLgZNKVmvDZfgl2pk
 IbljGLiuCPvXD2hGk3a5uxleX25C8GQWfHFqdGI6MA0yOxmCXvJZEi16eLE7awi5Esbw
 M21huB0wNImfUhAp78s2Ya0quYiDIMm4RmzLQ79PM1jQ00d5OTpimz6hjPZ7bqYM4Wp3
 ZBzx+7RhqFt7ZSwpU9he6kkCM3bgnTBUaAWviEPsfIU5ZCFOj4kt+jZ/ncYwyarvAHAa
 6Z/r2urFxlluOksLo7VdbjH/0O68BF67HX66afzCyqt7SE5q3JZiav3bbH7dB0yui80n
 2nQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790750106; x=1791354906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
 b=uwYdsg7zt7KLuvVWhVqsVicR9lM4OW8rKpVQHMzgOvHUEAQnmsscTk/8/Cl4qPgVZm
 ZxrmHw2Imftzk07pEgtFoROdW6Fty/QMaXF+jmryoj4DOFvzjdzhbMr3aVG7Fg4M+gcG
 qWUP+7bQLUwEFZypTGzhaC4utTOAE59vH2ETOUQzgDl4m/WSEUvD8s3Y3N9VKZQVCcYc
 RP4VqX5KmrVRwCuR1cne4cnqnUHYR5Xo3Zflccm7z24nHedAnxaC9NN4ue/Wb7Aq4Fob
 yDViIVQ+M07zt5P1O66tHA+AWEbOMRJmSyvnOUSjaBx4hG9blUEpTOTK2Vqn7ahDiWOM
 oubQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnblOi7kqPkOK0iMCJYJX9FW7SV/3pXroRWjqPHOGpRDGxgajHCti0FtL0yfwWAvqRhbC+J+U=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIuY0i/uc+R/PSyBEDYBU3kr0INpZVkB7LZdk9ZX5xc6RSgpNIf
 kUe+FuHM6pQ0Vf60O/yIYnAipRP2ym+8aU4knnNUjcwMgBybNcgkVXLo7FPewRRTyvBetZfsFKQ
 M6whRySO0ZmNsbscpwEgDqurv77DrGBWD2ZnSeR4c4QvVvpp2fXKEZf4+egdE2/46/NOzDw1kzk
 AV4GPt3g==
X-Gm-Gg: AYBFou3IkqNtvSAfgVBnhMICCCXUx0y5NKtNc4KJO2btkywrneYzGAmIosW9y75gwIm
 VdHaJXboyMhMwkl1ZU33GMqLRHutU2nb5l0oS1opIfnHoVu/O18D5In7yofgf0CI/ho41PYDese
 BPPweW+AHx87e77FDoPccKf7SaEfLCkIi2aOq26rDnUTTp2Stf1Azk34cfK6gTA7HiNFhLDDR0/
 3IjXSlTxIOhcY/aO1R4eTFc8X8qDJHqGg1dqZJrnN6GPxiHN4GgZCimms+bOPYDBClAvvttBJ/6
 A+WusRguHFVeQ/KWUVontoZoPszi/24ruo8jgPVHGlXS3csh7kz8Ly23zG8coyUhiTWuGMIEQIb
 i5tsZpzxcIWPOf3V5OQEA0Nuc9gOoFmYXrvYxBNtrqZrb4y/v
X-Received: by 2002:a05:7300:ff48:b0:339:79c8:a8a with SMTP id
 5a478bee46e88-34ce32a6eb7mr558300eec.3.1790750105987; 
 Tue, 29 Sep 2026 23:35:05 -0700 (PDT)
X-Received: by 2002:a05:7300:ff48:b0:339:79c8:a8a with SMTP id
 5a478bee46e88-34ce32a6eb7mr558271eec.3.1790750105389; 
 Tue, 29 Sep 2026 23:35:05 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34cf22f85b7sm1287502eec.3.2026.09.29.23.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:35:05 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 04/12] clk: qcom: add configurable FSM-voted PLL helper
Date: Tue, 29 Sep 2026 23:34:41 -0700
Message-Id: <20260930063449.3251317-5-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
References: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XIApbuHxcwPT0c4FzCdXO61XRFXRyKHS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfXxHzZ5Pq+bA/M
 CwHsjJVEES/yDVTDb1JQ7Mn9iTB0NhjiGnKCfyzctBlj0Rl9JnO0pMaZWN1CS6xaE6ZPreCtSkY
 IKBGBb/xkxIBR2NV1cs4jkIYsrZCgispDsyORbMf7bDVSPbXJRM5unLn1gzGQZ9H6C1WfQMGnN9
 AhnErnJjBprSgfg3ltd9OJu7iOw4NxHR4U0vO75/RCb2J6yE16esV1Klf2vsMB2SYQrz1O18zsy
 VCi6TPk7dT5BiGKB6FuZL36pbVCzvpGm2LzcmQLtZw6Gk3cmJoLGlmTiq2ySlUT1s1jLOPEAXkU
 YQ7PcIbWR8qOBe56OKpLkK4aFhf0N5PwmdUu62Z1Fc83KALVRfbY6tvny4X/2970vDCHzVnJ6Vf
 YH7GonJT4NWvdqHadQDrGipD8Z4/NRII/YdjNENdDXHeAh7IXZCEU+m3kOmIInK3ok88Z54NtZx
 iOZcMoc8EK7FPj6ZXiQ==
X-Authority-Analysis: v=2.4 cv=cokOAF4i c=1 sm=1 tr=0 ts=6abcad9a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=enMxUgKZn3LVR2H3xcYA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: XIApbuHxcwPT0c4FzCdXO61XRFXRyKHS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX0Ww4nxyPKpfP
 Bcnc8aki2oHKwG9E8WqiEbq6gCFgY89hbkiHX2aOf6VUD/kOKDTN5dgOpK/wGFdrSfXL3UIpArT
 i7FewMRKowdYA2MMwMmTfHkayVOgQ38=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300026
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

Add a reusable helper to configure and vote for Alpha PLLs
controlled by the GCC vote FSM. Per-PLL register offsets
support targets with different PLL layouts.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcom.c | 48 +++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h | 24 ++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 6b46d9db744..30127c1fffe 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -59,6 +59,54 @@ void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0)
 		;
 }
 
+#define PLL_MODE_ACTIVE_FLAG	BIT(30)
+#define PLL_MODE_BIAS_COUNT	GENMASK(19, 14)
+#define PLL_MODE_LOCK_COUNT	GENMASK(13, 8)
+#define PLL_MODE_VOTE_FSM_ENA	BIT(20)
+
+#define PLL_MODE_BIAS_COUNT_VAL	(0x6 << 14)
+#define PLL_MODE_LOCK_COUNT_VAL	(0x0 << 8)
+
+#define PLL_LOCK_TIMEOUT_US	200
+
+void clk_configure_enable_pll(phys_addr_t base, const struct pll_config *pll)
+{
+	u32 mode = readl(base + pll->mode_reg);
+	unsigned int count;
+
+	if ((mode & PLL_MODE_VOTE_FSM_ENA) &&
+	    (readl(base + pll->ena_vote) & pll->vote_bit) == pll->vote_bit &&
+	    (mode & PLL_MODE_ACTIVE_FLAG))
+		return;
+
+	writel(0, base + pll->mode_reg);
+	writel(pll->user_ctl_u, base + pll->mode_reg + pll->user_ctl_u_offset);
+	writel(pll->config_ctl, base + pll->mode_reg + pll->config_ctl_offset);
+	writel(pll->test_ctl, base + pll->mode_reg + pll->test_ctl_offset);
+	writel(pll->test_ctl_u, base + pll->mode_reg + pll->test_ctl_u_offset);
+	writel(pll->user_ctl, base + pll->mode_reg + pll->user_ctl_offset);
+	writel(pll->l_val, base + pll->mode_reg + pll->l_val_offset);
+	writel(pll->alpha_val, base + pll->mode_reg + pll->alpha_val_offset);
+	writel(pll->alpha_val_u, base + pll->mode_reg + pll->alpha_val_u_offset);
+
+	mode &= ~(PLL_MODE_BIAS_COUNT | PLL_MODE_LOCK_COUNT);
+	mode |= PLL_MODE_BIAS_COUNT_VAL | PLL_MODE_LOCK_COUNT_VAL |
+		PLL_MODE_VOTE_FSM_ENA;
+	writel(mode, base + pll->mode_reg);
+
+	setbits_le32(base + pll->ena_vote, pll->vote_bit);
+
+	for (count = 0; count < PLL_LOCK_TIMEOUT_US; count++) {
+		if (readl(base + pll->mode_reg) & PLL_MODE_ACTIVE_FLAG)
+			return;
+		udelay(1);
+	}
+
+	WARN(count == PLL_LOCK_TIMEOUT_US,
+	     "PLL @ %#llx [%#010x] never locked\n",
+	     base + pll->mode_reg, readl(base + pll->mode_reg));
+}
+
 #define BRANCH_ON_VAL (0)
 #define BRANCH_NOC_FSM_ON_VAL BIT(29)
 #define BRANCH_CHECK_MASK GENMASK(31, 28)
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 9899cd28aad..47930ae9d5e 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -36,6 +36,29 @@ struct pll_vote_clk {
 	int vote_bit;
 };
 
+/* Configuration for an FSM-voteable Alpha PLL. */
+struct pll_config {
+	uintptr_t mode_reg;
+	uintptr_t ena_vote;
+	u32 vote_bit;
+	u32 l_val;
+	u32 alpha_val;
+	u32 alpha_val_u;
+	u32 user_ctl;
+	u32 user_ctl_u;
+	u32 config_ctl;
+	u32 test_ctl;
+	u32 test_ctl_u;
+	u32 l_val_offset;
+	u32 alpha_val_offset;
+	u32 alpha_val_u_offset;
+	u32 test_ctl_offset;
+	u32 test_ctl_u_offset;
+	u32 user_ctl_offset;
+	u32 user_ctl_u_offset;
+	u32 config_ctl_offset;
+};
+
 struct vote_clk {
 	uintptr_t cbcr_reg;
 	uintptr_t ena_vote;
@@ -107,6 +130,7 @@ struct msm_clk_priv {
 
 int qcom_cc_bind(struct udevice *parent);
 void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0);
+void clk_configure_enable_pll(phys_addr_t base, const struct pll_config *pll);
 void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
 void clk_enable_cbc(phys_addr_t cbcr);
 void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk);
-- 
2.34.1

