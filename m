Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4B5606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DoX0ShVK;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b3n28109;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BbPfVWUI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBD0940787;
	Sat, 24 Oct 2026 18:23:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OC-YlDFYUHzq; Sat, 24 Oct 2026 18:23:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 04CE34070D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792866180;
	b=Gf1X2PzKU5uVWYKdHMs2qniQMUgb1WWU6NreKLgcQJLInQQQT1wvm39Csr44VZLj2SeE
	 KgWukjlPwoMXTwI3E6BDmm6P2oOmWF5ae9QMiJgWoC4hY0j+9BQCX0GgaOhJ+HDu+GMgn
	 P8PMl2+zs9SNgfwDAGh8IWyV9dhrN9xHfS7kOfdhGfegdrPFCc6htRhpn1CIrpMNdm15T
	 K7CjDnvD9Y9V052xMJELMS3F4SrSPCPh4FXSoj5oXLXWv0hbAnFYsYld3zvLRj+E/ibaZ
	 21lsn83oPtHvO9uD8UHZHU2G+JMMLVcBLzkZPB+8GyuyDFN4cfZ98RP9QN0ulYPgKZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792866180;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YiGiZV1VMdE7Vr/wDAGiYlKHWRPruPMFZSaCKrHMwvk=;
	b=TJcPAQxN+lVpfF7AlWBMsFOgaQsPH3e+d/fwjRZxjg32fD+uvDlZvhuzum3BVc/7fxkz
	 aVgFgc3x+mCvwlKB8UMb93laCsPndrqPevx1LlPd3iaks7hVka6vkVT/oBDTAp+Y/s07C
	 WHXcP9B58t1F5sixJ9cFLQTzvQzr7UH4uWJTo07NDmWdYrsXP50igD1aLShMPnDEgjb0j
	 KD7MQsgFulWKcjFkk1lnnqLLJtgqF55kdCLTu25EqqW7fPekzRFVzq3cr6d2A8fu1OdFO
	 iOt3Ia/hB1yRm0ZZPzTtXTstZDeBfwkrGVCQDqQrwC7rvJZEyRmxq6HtreQP1Sog8Rg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792866180;
	bh=YiGiZV1VMdE7Vr/wDAGiYlKHWRPruPMFZSaCKrHMwvk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DoX0ShVKbCnXzCx1txB9q8+6NPeEQBN5E85K+XJNKymdoqDJQSRdU/gWbUhzmpeBX
	 vUTMpAHCTZIcpIDmEP7S6wxzw0i+E0CCzV17g8lq/0h354NWsKEV2MP3vU5x9VOp/x
	 VpR3Wl6Bj6A0Iu2mml8Lf4H4jqm5crAkhAiGpiZceukCy87VGcWvO54MdLg9Uc9Wgg
	 oQlGaHZ9wCtTLihuOVeuQhxSYCI3tJHzGN2vvyDaJfBof1gHN+mdg/fjO9FRNjEh5f
	 R64ICoraawNpbt+/cZeqT3AwY506Tz6jkO8DVY6FwNri2tD1kZit70fJBO4cT0dD1g
	 wsyTTPZuUM1sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04CE34070D;
	Sat, 24 Oct 2026 18:23:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C22264D1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B27D881358
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:22:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G8ldHJ8HlQYn for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 18:22:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 80AB880E47
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792866178;
 b=MVLKrsghJmwmdtYA37QFRbFVlIgIjCZHEBpq5kvKunVFfJhwxJZKHsu+Z+xOVXOCB/dn
 R+tcHB+fMj1LkhiNLiJIVw+BDbjU8iaqSUa/EJrEF10O7705f2lfEeQV/KjpDL+k5d9ge
 69DcIatUMK8F+kxub0f7IZ9Jtp4YCSh5bPjAbg7DGhKyN+Dl3Uv5VVTxUg69RTI8tmhXw
 55ayD3SXcg+GoyAL2jKfg15FYRce6pHMMlNRJ1kPehaLc2MYwE5sv2Bo5mXhaw6g1OzPf
 uqLVfvIftEEyyDWPN/GjAnc9JDT0GM1YUKsY/3vGbiRbox0nn5PpNyCtgMRgvMxTsdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792866178;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=YiGiZV1VMdE7Vr/wDAGiYlKHWRPruPMFZSaCKrHMwvk=;
 b=AvLcfNK/kCcVO4oBrGOWVUVpA4Iy7Fa0MXqjCn5AzHOYO3PdZq3bzgWgZIshlvYEUbCo
 aNFMgHvTys9zzY15CxJYHyc5vYD+u+d8+bmOK0zuEatbGBVov0MQiBPhioPX91xHydDO5
 r6GmxAPqn/wXTzKXhHRFGP/2YGl0VMEkhLBakQyI3q4w/Oemf3BI0fjYtWEK8zSzMuMXM
 COtmcKoX2OjWdveJR3kCi9rrel54WP4DmCiDM1jxPhRCF+j2wBHhtCDXPapFdBamnatWv
 iLpSypLtdPE/w9+/h+1WWwcPkexbeApMZCrLDCPY4VSpcV2WoUHgSt2yhw6PExorROg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=b3n28109; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BbPfVWUI; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=b3n28109; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BbPfVWUI
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 80AB880E47
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:22:56 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF08iN1883594
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YiGiZV1VMdE7Vr/wDAGiYlKHWRPruPMFZSaCKrHMwvk=; b=b3n28109vzTy75gO
 fZPD5nZ67Y1uJzWL3qYp/C4TNY/O5rSz0AKAJlLTXAAxNrzslrZc2uj4OqxxOrqw
 xBKZpLFrayshC/nyLqgMlV2JdsjHxbH3NsRW0Z2m+hQqsGryhyiUeJ95GHLiVJH6
 Ew1ie1yyJxYhtxh35L1H51QMhIoTobzAxY6VgkmTJE8a//H/A85f7DgfIZr9pRCP
 dm7h28nUGaR1EvJ86F58tFrUGlH5NTnkf8UrsNcoo4UL7Oj4SkLn4QkJS0cFeQ4l
 LUJ+iglczKCECd5xPeJguozOcxe4lwDtfzWsT7ovn56o565RWmQlfrWx93JBlP7L
 8n5/OA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgj1p9w4t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:22:55 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3692c5b061bso6524868eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792866175; x=1793470975;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YiGiZV1VMdE7Vr/wDAGiYlKHWRPruPMFZSaCKrHMwvk=;
 b=BbPfVWUIzAuF+alsmTRnBPnlc9u4+nkEDAYlaMBSwG6Y5aQj893MwmRrhw72qaXlXP
 sc6ijRcuXaCn+Fr36QEk1z1nFxLMdMQBUie5ORhduQt8HfZFZYiMqG11GePRVA/bTAa7
 LvgQoLEP+sR4Ry9JleXEOArM7s0jepQMSA+/ZXXy4nAOB7vGLdeF4Z5KI4yu46prbqO/
 fJ24EgNFXbtsjXrXlYhlk84UgkTlLLKqdqe4om2A4OEmnXcLfWEO+pbUqProFiE9wsoO
 cQKf4FK8KHJff5gEF2f0YvMLdFkL2ysrAZNS1nvWo6niVdxHOU22RG3Kpkevp8Waxw/u
 gQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792866175; x=1793470975;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YiGiZV1VMdE7Vr/wDAGiYlKHWRPruPMFZSaCKrHMwvk=;
 b=gOJ49jL4/IiegpOMxsdcwZkY0Pq8ne20w5ZGTo3QYpwQbn87xCvEGfT4YXqeEFjUyx
 88VDlnLgmX/aM6mDJrlkqi7uCKy8xuznSQVq1lq2DCM3VihtLcN9SvjRzdeRMNV0hCih
 dMKNVZ9X7sP4LGEagSNCkxWpL418UqeSUX1a4PNtwqF64TDsUsNqb9wdB9HaCvbZ3q1e
 /V2RSUHBSWoywIV7uHRZX86sOLg6RfNhlhoOeJebEwZiIqmIzKScrXSbS2q/udbpJZUm
 aFzxVCIOfaVm+410xETp9lUJQGpr7uoAs+bLg41HtyqT2uavQ4GJbqFgO1p/vnttTpcj
 FI1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWKU5IbjLRHsf/6auAcZgt9CMXmRhv4kKB9/XfyEQ3Sxw8L8UXqeXsVIBxH4q4Gc7ONmU4xKU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ7Kt0shvumPcNJ951QJyptALgdY0xuqVLNVi2j9FVZh7QhZyrE
 hqnN9um+izz47uBBXgX5yrIn5iRc2BdBYU2dcrWwkhZJWB3ilJAqGVpOx38HdDda2GVPNaBqtDu
 7TYKlsjtfBdjVQfg/q4+WapWJkmqqwg9m3wwfwjA7gYZAZc6xkS3KOtqcuP8qAmVo1RqHtyg=
X-Gm-Gg: AYBFou0Uew8Q1dJOF4+/YVJUs4byUgzfaZu+Lp5iPdLaubEJ+LMt10ObyyF/UOMlsvu
 nwzraPG2IIpXDJ3jkLTl25wzwcNvNgcVav0YsI6EFip4pdBGXf0Vzi9O07SFLIOtq3Es55don+5
 LUGEO1kPDgc75WgB7Qvmm1Ljz00xJZR5QZiLRblTrqU2MjmKoLXcnc8hPX//WdcUYbEJJ0FjsNY
 s5GUFSFJI8b1aX7DULPPPtZECUke3Bt2ZLeKWJl7Rbgkq+N1MXNq/JDc30uxM03kqui8NnLzIIP
 feQHXOcukh7CFaTD+lNOQjAH+LgipVHew+3iyeNt6dfZjzfwtLy5lSJT1XrR4jbYRaQW7Uc0q+X
 nVrqQShrO4Q+oua6ElUXGWeJQuY+h/rU=
X-Received: by 2002:a05:693c:250d:b0:366:8efb:bab9 with SMTP id
 5a478bee46e88-369e848362amr3723112eec.11.1792866174538; 
 Sat, 24 Oct 2026 11:22:54 -0700 (PDT)
X-Received: by 2002:a05:693c:250d:b0:366:8efb:bab9 with SMTP id
 5a478bee46e88-369e848362amr3723082eec.11.1792866174015; 
 Sat, 24 Oct 2026 11:22:54 -0700 (PDT)
Received: from [192.168.1.10] ([122.164.245.57])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db7b23sm12317305eec.19.2026.10.24.11.22.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 11:22:53 -0700 (PDT)
Message-ID: <31a34a36-30b6-4422-a877-a24ce218bce7@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 23:52:47 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] arm64: qcom: Add initial support for Nord SoC
To: Tyler Baker <tyler.baker@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, nikroks@mainlining.org, luca.weiss@fairphone.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
 <20261022213356.765702-1-tyler.baker@oss.qualcomm.com>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20261022213356.765702-1-tyler.baker@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MyBTYWx0ZWRfX1Z8RYM0OuH+A
 /dlKP/t5HJmUsz0mp4rqk4SWjfhcU44UPstxYBSI+kYCGs8KVvnSZuejxrT+kP5vE4aiiJMtjoh
 9LD8fCU3YKLueB3LiCopEh5AK/SA3X4=
X-Proofpoint-GUID: 8WgywNrJ22NLEGI8gkodq6yBwvKz1iPt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MyBTYWx0ZWRfXyKzMrEfbRKAC
 MbxHSOAh+AVRWqUODZjtOVZMepqdJDY2S9mp0Zp87mAKNIvznTYqHVKP90i2j8DBl7Haue/Jap2
 i9KZZT+7TgdnKsfXOI306BHtqfymSN/IhMhARx/OjFRv6TrJ5Shf6U+lyPLoNjB3F3FUf82P5e6
 a1olUXqiV6nzOGIsyrvB2/t96wPukdph6BeBSD335lABBD/aem1u6ftjLaaqcdon6nQih9O6Kiw
 qOvb9BE8rwaYOGqDG4MGm4CUPgcZR9PKwc0f2JWpZtEh97PjQAb+VzWgRRlSPFDXU6WUq7TtuAM
 zX/V4kJDTUcpi4Dpx0zmSIHVEYuIJXVP5O3VHBcbpnvUKpZ1/jgLwsv7g+EBN7nqxRZIXERp0y6
 lKP0bKbks1dVvAyNLlbrbaPaABC0oqk3hCFrWQ3oCpe/nMwO1/ztRwrC2q+hqdrHg6BOKbJ+zBa
 2/Jom7jMWM/NoV1bYCQ==
X-Proofpoint-ORIG-GUID: 8WgywNrJ22NLEGI8gkodq6yBwvKz1iPt
X-Authority-Analysis: v=2.4 cv=D5vSufRj c=1 sm=1 tr=0 ts=6adcf77f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=TCmZHHD8nNTMiv+1QRkMpQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=hdYqa4qpa_qOGptkwM0A:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240073
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tyler

On 10/23/2026 3:03 AM, Tyler Baker wrote:
> On Wed, 21 Oct 2026 at 21:34, Aswin Murugan wrote:
>> This series adds foundational support for the Qualcomm Nord SoC in
>> U-Boot, including clock, pinctrl, USB HS PHY, and configuration updates
> There's no Nord DT in dts/upstream and nothing builds a Nord board, so
> none of this is used or tested in tree. Please send it with the board
> enablement.

DTs for newer SoCs typically take longer to reach upstream. In the 
meantime, we are posting the required platform drivers for review so 
they can be discussed and iterated independently.This follows the 
pattern commonly seen in the Linux kernel, where SoC support drivers 
(clock, pinctrl, PHY, etc.) are often upstreamed before the 
corresponding board DTS files become available. The board enablement 
series will consume these drivers once the DT support is ready.

Thanks,
Aswin


> The commit messages only restate the subjects. Say what U-Boot needs
> each controller for.
