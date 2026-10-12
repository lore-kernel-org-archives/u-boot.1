Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70689CA9EDE
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 19:57:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99B9340539;
	Mon, 12 Oct 2026 19:57:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MJkDNqfbzaeh; Mon, 12 Oct 2026 19:57:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9F52B40565
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791835025;
	b=jSjDrb2q4sPNOSIm9UQHU8yKHKnT7VeO9/Qc5PKXBBbCdnZg8x9TWIjB/SH9KcZQzdvN
	 tfeSgj4IC/veSExNQu8UyKbHe0z38ipWOlbX0Xe9Pa+MKms3JX6+mmMlKavYhrOj7zcsd
	 KKe1K3t9ojPXHJLPKuFOMg3lBFh+ayr1qVisnBPkk3PL0hutjkryld9xrGSF4Hztxpafm
	 dNYTDFs1SMn1xPV6l6rZnf2NLBsFCP1YSIbtzDAIQg6ub6ohuXAE1bAIf8lDZ1jkkRbvz
	 gs5YVu+bR5f3wguSG2YUioKV+ejaDaBVfDNFBCwU9zQ37grzrgfeHfjIpjxwcDuouXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791835025;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Rvk0+0pKrTBNYh+6r2OE0SigxWuoazB4nwiNBjvmzU8=;
	b=V9aIWA7+QfrnN7xBOw6r/lz8wpHcCK6NXCPAGrCzO0bAzTDB+L7KC8eBBNdA9SQAfy1q
	 ajWTV2YQTaPl/i7cg4JqXHmvPMBuFS8OUDuIizoDBB9rTCqc1hiMoNBaZx1tJZPhs+CRX
	 AUTINYWNjqDw9RDuqQr9UOgoWoYRhMUbr8XUpK3dtIq2QSzLZ6MIdeaoPCGixD7tkbuGD
	 8RzGb6dl8omcx/y/EU7Kp8NVimQL02B6G1k8pByDF5zDw2FdjHB4b2jW0UD/2ii3Dn2Ek
	 Y7BoKqlSzlDs0X2kQLb09srjzWBCSLHse3kE+BU1eikc0zffbjv36mj6MqHh+p8Ebhw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791835025;
	bh=Rvk0+0pKrTBNYh+6r2OE0SigxWuoazB4nwiNBjvmzU8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tv4i5CDw+NOfmLu7xVzDemdPzw5IbAHc6Bn3yaqltNNbbHjWQHK5osGcraMEZ7dWB
	 y0ASGYpGEE6HvOOcC3/t2WGuPGjFpvhOPbQ03c1VRbhVGuqDWgVAAUG/rA4TTxSrWf
	 v5zGeYpLD8TaqaHyVHHBA2IpMrhkDT7yXofCW6tJgPbItCh+z463V4U9vLQ1QRQ0ft
	 WH6k9zmB3Y3rDwtOA/wO56YIFyTxHYZ836jUiGuvEsSpKKOp/XX5ue/a1Hgk5WVPJO
	 oTBuNM6VzPNjVroqHLj8E0h9x16z1/sAbg9eyukdmx9M1yIuh+UV9CF92Fnl5uThAy
	 IvHiw4z9Ff4Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F52B40565;
	Mon, 12 Oct 2026 19:57:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 256772E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1740B400B3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:57:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Icnbp3UpAKp9 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 19:57:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 68681400D1
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791835020;
 b=ml1rPeD7lXmsSaMdR6ywEhFXZSqUdlsoSRpf1ah5Sww0eSWG8REctNUYXVOHpuufDbZn
 /0KFH5irLr9rZLHB/W9GX9pX3AiDhtD2I29sz8FXDPxWlNT5S+u8OlccOdvqiNCozGd8c
 vvFE58Et0Q6Ul77moORhmaIL/NIAkv2fJhUlUaeS2ULQbw3h2Z0pBA2kBjbsvF02b7tDM
 yyQhr4hZAS7JpbXw2ij31RfvZyrEhcwYLp2W/ZyiSaqsxyVTMd1ojqhhOVihWe5/a54IP
 ULeuXRz5mSj//JZ+mmXG3q9pKBf2TsOdtkQQbYLHIhIotmiJg5YhuoPrmBvpa6hLF3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791835020;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Rvk0+0pKrTBNYh+6r2OE0SigxWuoazB4nwiNBjvmzU8=;
 b=WuDfAMpzstzyLlg1OaLuoiY6Vj5bEjzJEMZGpou+Ak1be+qxfxLOzvLg3SzzbBj1DoDm
 J5OHyeFbPreEtIbBAkfDoO6fJ3wHJC1pW6BH7o1xkCOdaxjRed4Dkz/qEOoqe+G/sgfGW
 coQU/Uqt+zdXcfWJhNYJQTzgrVORvQ/VgOImFI/gA5Yp52FwyETJuuLdnnush9UdS20Pl
 pLn9zaZH7J11S+k7hx413rEXbNxtf1DbiPO2I9S24nKZSwnkfF+QAVnSXMcWFmPI7gWrO
 34FBC0CseqytIn3cl5Lkk+u9LOo4lKrUDgodh+GtvdyeL03kPpIgBTFXeuKVQ9mt6aQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Y5eJl6Fs; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OZ5Yq0ws; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y5eJl6Fs; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OZ5Yq0ws
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68681400D1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:56:59 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CJN0Kj1779153
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Rvk0+0pKrTBNYh+6r2OE0SigxWuoazB4nwiNBjvmzU8=; b=Y5eJl6Fs1DT9Lhp6
 wUaqCHTQanUou0fa2W6qP7HT+ALXMz/FbEOoUEeKWUnon8ki8g2WuNUgRRqSdXvT
 JfAmX+2jUvq+ZJ67liuCxx655C1vwTBmK0SfcjiaWRzEGGPE/tZJwwCqwgwZLVw6
 I/4TaLf2ZO0tgNGj81VEvA0WdLYlJ3N+tBjwfCFcS7auwcn12WIDtIRiRL2qWlfH
 ryMS864h1IM74jj6RoX++1Zqlh/k4YAI19qTq2Daqtlw2FchfrPV5xHtyE+II1g7
 CJNvqCB/7XaBhXGe3xSwXbP9M9k5rTzuEuSVQbSLUyyD0pTB9KMGLlfKYTS8nbgz
 mGk0eQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wfctjtf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:56:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb71b1443so485163585a.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791835018; x=1792439818;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rvk0+0pKrTBNYh+6r2OE0SigxWuoazB4nwiNBjvmzU8=;
 b=OZ5Yq0wsp1JkfWO5fts+t6/GaoP6FO47HWoy0VnUIoI/z/U+wpOWdyL0pVgilrCXhl
 FXxJMo7Dsi6Toie4Ng7OlHogVPxY/bZFeEgDFqfYM7ICJdYm+nqCMxvl3DmFAd+kfNX6
 LafOlpDCUjs8Fm+RH0FlAUiusWy1c2gMKIGcNjMwtVSEiWyYE5zLzY0kgvCELVspVr2t
 liswqZcQTDCEQ5+WH6YZ46L8Hqt2XRmV2DdLD9L7iows52KWacnh61hhwSCOBmzJc0+k
 FdYrrBR52ZgFECo/kva+gpyX1SWryeJN1VCnoONm/1pHxH8pPwODhUHKkXeLxLH6mL35
 iV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791835018; x=1792439818;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rvk0+0pKrTBNYh+6r2OE0SigxWuoazB4nwiNBjvmzU8=;
 b=Kq1/Sfx3gRqFaEB2UILTv0MVhWH6PULI59nPdwNJ9q+qEEeIiyBeDTXekdHSnEwDNA
 hkMNY9AfhLnheKHbfPNWmvVKerSWkUuFWSkww1NzzM+kR7aqkpwU0w4zKtARTQQH3euo
 aH88bz2JlgZOAo11wwBQvGaZyIwKNDsjERy+19UD796H3f8DVbp0AwOBWqMwoozJW4Ma
 SKA+pA+RRN3lR2XPMZm5KUHHeeRdOs+W9t6ehE6Q/NUIy1blqOJCGEeAniSGELoofyhT
 dZWLUBKo/EIrAcqgkpuu6dEMgCpKKowBF1EcgrOYci5rGBu6aP+tuqgwUIcf8rlR16Sx
 TABQ==
X-Gm-Message-State: AFq9FYKX3ehYGHO9Hgp4xtoIiEseaxGPYEMJSaFZYBGaAvpg36tcGce9
 PZ+PWVJ4pW+31hkresvcOuqkCGpNzmjYdQGAks5dimeetiU3f/b9ynlc00dyIxD3CP1ymOejOKr
 O+e75osiyA28IR14cMKpbs5UvNIZaZ1VjODevmeUg9YZjva3X9lPSWYezVEBHypGYv66lvE4=
X-Gm-Gg: AYBFou3Pngjt70sCxA9tIDqg/vxwGA58yz6aVmELeO7cZkk5qjdz/pkiwXKRKpDCTUB
 wSPQlca20pAZRNdPTomddKjSX8eZryFInWWhV0AwFkiAFSOr4/dW8Rl3L4FLTBAGk5nbH9t9wKq
 HQswPzCEcCIb8EhT8NhDZAy2eM2gmePzUYuvEIQ1sMFaC/NN1lnqwZ2KsmPiSyYCwIR9AGyGMNg
 KbGXdhPOWmyM8ApsbAoPy+uWib4VFviCO7Q8iIRuhpsMbDNpxakpsCIqO6myjTqTY8rtrajDD3Z
 sQHDw1jCkmvwcQ8zgzFFrjjLhbnznugY5zKyAUYNJH9fMF+CS27VdGyaQDy2z1E5Djgb6Ja8Hmh
 J8PGVk6/9qt2ULY1wZr3tvGVNphkL3YugoC+y0AIBO3Rk
X-Received: by 2002:a05:620a:2796:b0:939:6c31:2318 with SMTP id
 af79cd13be357-93ebd25082amr1676999185a.34.1791835018024; 
 Mon, 12 Oct 2026 12:56:58 -0700 (PDT)
X-Received: by 2002:a05:620a:2796:b0:939:6c31:2318 with SMTP id
 af79cd13be357-93ebd25082amr1676996285a.34.1791835017482; 
 Mon, 12 Oct 2026 12:56:57 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a3bbe2sm489178266b.27.2026.10.12.12.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 12:56:56 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 21:56:44 +0200
Subject: [PATCH v2 2/2] optee: do not announce RPMB from within a
 supplicant RPC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-upstream-optee_rpmb_b4-v2-2-85d76a54273b@oss.qualcomm.com>
References: <20261012-upstream-optee_rpmb_b4-v2-0-85d76a54273b@oss.qualcomm.com>
In-Reply-To: <20261012-upstream-optee_rpmb_b4-v2-0-85d76a54273b@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: Db3oZaEVanmX-6IkizSo7MP4j1eRM8ZZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA3OSBTYWx0ZWRfX2UGAE63hHok3
 +1lRTF9h1T0A2ji+e4fLl1o4LaYHKvnASngWa6kRH6mL3iE4nps9crmgjQSb0bB9Kln7TdXPXlE
 YTht6W/8eWUDuYbCs1n5CERVQSl6Qnc=
X-Proofpoint-ORIG-GUID: Db3oZaEVanmX-6IkizSo7MP4j1eRM8ZZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA3OSBTYWx0ZWRfX5/fTpOAHQDNm
 x4zhS1/sS2G/QVrjBbz2+gDfxaS1q6LsEArk83ujlytng/tEYtWop4KZw2j+hWTd/PltppPUOA5
 uZv1TE/kSmSgc8wGwmAM4eQwD/sOvKlQ+6L03g814L5TxNr0XGdRpp4toDq2cY9CZrgr8QoUReL
 s7bQbcnqZbOGo8WCzwS1ZlV/cde0lzVyen67hnhdUfKqcvHQ0zlnaxTWEveWM4CXYwE3mXnvnJk
 G0Ib7YYXT/uU0Ll9M8ysbbNDuJLmUj5yoN4eukx5RiUjcrbEXLfRYHORxUYMRfmC4kHc/tuCU8u
 keEnww/85pkJofPlsP23b6J1OIiYeIUpwS4TOHYj9zNwf0U3ENxKQ4yueZfkNwo6wCxw43HnUEC
 oTuRBCubVxOLJTMKCz1JGiF0TiR8LYEXoQ7J2bUFqGEXIQchhNzzBoU9knG3F4adH1u3Me3oEQF
 vny84FoO2dtmf5ysrXA==
X-Authority-Analysis: v=2.4 cv=PbhqFShd c=1 sm=1 tr=0 ts=6acd3b8b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=qSO02MnChB0fnR7m3KIA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120079
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

mmc_init() calls optee_rpmb_available() once the card has been set up.
When the first initialisation of the eMMC is triggered by the RPMB
supplicant, that is while OP-TEE is blocked in an RPC and holds its RPMB
mutex, the announcement opens a nested session to device.pta, whose RPMB
enumeration takes the same mutex. OP-TEE's second thread then tries to
sleep through the notification interface, which U-Boot does not
implement, and spins forever. This happens whenever a TA touches its
RPMB secure storage before anything else in U-Boot has initialised the
eMMC, for example a TA call issued from the shell right after reset
("optee_rpmb read_pvalue" with the AVB TA, "tpm2 init" with the fTPM).

Linux never runs into this: the RPMB device is registered by the MMC core
long before any TEE client, the OP-TEE driver announces it from a
workqueue rather than from an RPC, and the kernel implements the
notification wait. U-Boot serves every RPC synchronously on the one
thread it has, so make the supplicant record that it is servicing a
request and skip the announcement in that case: OP-TEE is using the RPMB
already and will find the device when it probes.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/tee/optee/optee_private.h |  2 ++
 drivers/tee/optee/rpmb.c          | 11 +++++++++++
 drivers/tee/optee/supplicant.c    |  4 ++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index daff3e04493..92e3b3bea10 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -42,6 +42,8 @@ struct optee_private {
 	struct mmc *rpmb_mmc;
 	int rpmb_dev_id;
 	int rpmb_original_part;
+	/* Non-zero while a supplicant RPC from OP-TEE is being serviced */
+	int in_supplicant;
 };
 
 struct optee_msg_arg;
diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
index ea5507af086..83dc0cc11aa 100644
--- a/drivers/tee/optee/rpmb.c
+++ b/drivers/tee/optee/rpmb.c
@@ -215,6 +215,7 @@ void optee_suppl_rpmb_release(struct udevice *dev)
 
 void optee_rpmb_available(void)
 {
+	struct optee_private *priv;
 	struct udevice *dev;
 	struct uclass *uc;
 	u32 tee_sess;
@@ -224,6 +225,16 @@ void optee_rpmb_available(void)
 		    !device_active(dev))
 			continue;
 
+		/*
+		 * mmc_init() may run from the RPMB supplicant itself, while
+		 * OP-TEE is blocked in that RPC and holds its RPMB lock. A
+		 * nested call would then deadlock, and OP-TEE is about to use
+		 * the device anyway.
+		 */
+		priv = dev_get_priv(dev);
+		if (priv->in_supplicant)
+			continue;
+
 		if (optee_open_enum_session(dev, &tee_sess) != 0)
 			continue;
 
diff --git a/drivers/tee/optee/supplicant.c b/drivers/tee/optee/supplicant.c
index 8a426f53ba8..c0eeaed7003 100644
--- a/drivers/tee/optee/supplicant.c
+++ b/drivers/tee/optee/supplicant.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2018, Linaro Limited
  */
 
+#include <dm.h>
 #include <log.h>
 #include <malloc.h>
 #include <tee.h>
@@ -73,8 +74,10 @@ static void cmd_shm_free(struct optee_msg_arg *arg)
 void optee_suppl_cmd(struct udevice *dev, struct tee_shm *shm_arg,
 		     void **page_list)
 {
+	struct optee_private *priv = dev_get_priv(dev);
 	struct optee_msg_arg *arg = shm_arg->addr;
 
+	priv->in_supplicant++;
 	switch (arg->cmd) {
 	case OPTEE_MSG_RPC_CMD_SHM_ALLOC:
 		cmd_shm_alloc(dev, arg, page_list);
@@ -95,6 +98,7 @@ void optee_suppl_cmd(struct udevice *dev, struct tee_shm *shm_arg,
 	default:
 		arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
 	}
+	priv->in_supplicant--;
 
 	arg->ret_origin = TEE_ORIGIN_COMMS;
 }

-- 
2.53.0

