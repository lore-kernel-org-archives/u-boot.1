Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408D606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UgtUX2FF;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YATZTArJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O76VRH4k
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8367581461;
	Thu, 22 Oct 2026 23:24:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P_LvN6cGpV9a; Thu, 22 Oct 2026 23:24:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BD3C081253
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792711457;
	b=B6hQy7/5QyOVK4Jy0Fg0a1Dv/DT+CMf7CF/L/ZXrg6cqAug+ETVFhxuUFMq9qHvEsLf8
	 MB+A6cP/ZwaMyk9bItp0iNfXC3wgMlCMcBkzkyfiBwrrJ5qwFHf0eea9syyIdd87TFJp5
	 i/+d/gu1vMC9NlpWvSkpF+XfkzxF6Vj+zX/dAHVOOwkvy2phplSkr0rDomC6V57/N1xuj
	 4/Knw9mY01/3z3Dbv2KanuXdfb2vFG8F0MiU0u0B10+ixNA50YcIsqAZHEo7ZBKWPw9kl
	 m6e0/+drFXm5tdlQi+RNE3e8gkTxvmUKGXgsUUU+JmG81x/dhknIgbhgpsguK9/E5pA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711457;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/9Y12Acvo+GbBTNr2IDKelWhDzFdQy5ZuccoLA2ITpA=;
	b=h09cI+oBXu5GXVXZc/SE8ic8k2dRMVarbi1M5iZVizy/rWFLxCaBf03wQ2ZB3/5l+zGz
	 wuL+AdqEk+nPUOja+ktL4nTDTMr4Yru2SfjP/IqULxApfYNZP2vhJXCp01yhM+mEmfVoM
	 /tWyHLuW+gauvQCV5rM8jDvVE8zZk0kgQMwf2tz2n5Ouj+ApPIdqxU0De5ss7O3Nvt4lE
	 wmNNXfyx+l3vydKbaN9V+1AjaLbamQoqCjAnExfdKHgBnyBpi+6rECSg8uK5VlQoLbnfP
	 yPLaiDi25k62RiBj5pBNpnJESLdl+u3NEDyASGs7M1S78fz8YpgA8TFkFsLzYVTD7vQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YATZTArJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O76VRH4k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792711457;
	bh=/9Y12Acvo+GbBTNr2IDKelWhDzFdQy5ZuccoLA2ITpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UgtUX2FFiikKQChA4uFpDZ6hQNfHT2C+UkhiTC4/G2IYesWX9QVWuYcsWFOOmrFCl
	 rjr279hj3ktXqLm3xdFtC2KzPmD8cV1NNEd19yCovh2nXJzxVNUmXhcl5uoCO6wRhS
	 HVj8fepwkNZ+zG1ZogItVaeuoO7Jo4bzOZyF0wPEMKHwGv3d91YoHEZNiOeWpAu7dA
	 Gk1a5ybCbCFtMTufphk3mwRKNeCk6vlI3QStiJYqboqGVxNsQt0PJ7GtS7UAeBnb5y
	 /hBE4c1ZYpB02DmVMGyMNsvS8Rsa0XCcW3dmsUQGnUw1WIc2UA2flg+vP9pS5Ti7kj
	 +1xBqMBgaCnpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD3C081253;
	Thu, 22 Oct 2026 23:24:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 84DC01DE
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 81590811CB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:24:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TAmlg9uPJyMF for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 23:24:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B091981136
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792711453;
 b=Z8oYejhh8dvAFTL7aVD2NanwG4xjv+wYoAtpxfz21yKl8Kotxwg8NgPBR3PaZ+dG5XAo
 JAjIfA4sbQI/+PLLJONQsxomDPJZtENAtyL6Ncf4YcOo1c/jt48s/HDc/1IsEzyQsTAnp
 tXmqeYWnGc0mJekge3PGrDSihzMmC1Ass9ZboAAlyHCyFHKlFnJm2BeCAVMAXzCVpRyTt
 0J6mymq0vcTx9prmuAlVGg9VoolkJKniB21IkJnpynALwOTL8ydmKpMzcv01ElWPpoKuP
 96bbL2Ulpo1a7PUsgPMiUIlLIrNXiAtES+F161wnydh0ru4au9D7eZQttR6Ecdfl93A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792711453;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=/9Y12Acvo+GbBTNr2IDKelWhDzFdQy5ZuccoLA2ITpA=;
 b=Amay1A+uHQpYZuPeuU/sFHT231DnFtfMvdvdt5Mo/EMchzMfxWvK7HdnNKOEUP9y5+62
 A2dit0x1myiARpTz79jGAladdjtlPp0y8uBXCw9mPfrqfcFYy1ibGAFpqnb7ZuzYHEL5l
 tS0qerh73Bu6/ApT3Ifk0LJ82OmvP7Sea2ZBm3Z6EmSuUK6qhsKrVPQ+FYQFwq1Quo4Gd
 odGmP78cdb3lHdUh75juwQyqfn+ja+5GyTUpq/oKk4rebB8u+R7y/UYXmYuWlMiPzcod0
 HCrqxXoBmCnWOaFTpUcyYFbF1aX5l88RXCWr78H1Qt14DGtsSvulHXjPYKcTGWE8MSg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=YATZTArJ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=O76VRH4k; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=YATZTArJ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=O76VRH4k
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B091981136
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:24:13 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMFDaI4082144
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /9Y12Acvo+GbBTNr2IDKelWhDzFdQy5ZuccoLA2ITpA=; b=YATZTArJjNyZ9ixt
 OSAduwdiTcjRBfcnmRLOJKJEOAU/Juq0n3JEsO32I7Dq8ZEgU1t3epnS5TG9ebpa
 iIyhNwLCii/GUF38BvEAW4kEmo1M0V/4HNROBKUCYqnfAoPnU65OTEj2Zs17QUJ3
 by80zhJyWB9wHGbPbFa4Cdb/s+Ot1xccqsvf6/lewa/sbvOYox9WcyrtchCEQEbk
 Gxz9432R4s2pVADPf8Cxwv3xltODF1dYGL3FX9Yx1VD5hVJDgqdveuvyJQBJXONK
 cJ2Tw14orm48RD0nZ3QPPHi8vltzZdfPS6pesQenuTXvffVtDLGssu0jlkG8HH3K
 v69OyA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbh0t2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:24:11 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8b0d978e4faso6866227b3.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792711451; x=1793316251;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/9Y12Acvo+GbBTNr2IDKelWhDzFdQy5ZuccoLA2ITpA=;
 b=O76VRH4kZyuLnnfyyjpmDzVkSxs8OEAYLbAtEP2rFfkxdVHyICi5ngvsxH40Z/MPiW
 W/fQpOUUGKHX/cu6BU33UQwMsDDBQ9tDh89mvDeA/9KZdFZAAcOE+5u/AkAj2Tsjx1cf
 3N1dnnd7OpNmXoP4tv92L3mEKGcwMkLLsG1rlxql15cBXlT/tP2r6IrHhTl4Qj5kGDQK
 Axu145115IS5EUbjrsaHDKd6MWtOkE/Hd7zYf7SXTB8M7k9V59fKbbrrvosZVD5Wrymg
 KYGVjcqFOcBLi+YItJb2YXLXtqedI4u31oLFYzDY4ov7FeoA3WB4h6u82yC4TMJjHmpr
 2cYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792711451; x=1793316251;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/9Y12Acvo+GbBTNr2IDKelWhDzFdQy5ZuccoLA2ITpA=;
 b=eHOChKz3YduGTVFvZfpIBUQoBtJN3gTJ5AuUwuqUs0YfstBkFxb4PYdz/NbQBuo+fg
 R1F7iNfp/pPCEMA19qeM/VQrLx6AAU+e6KT/NGnINiFYFAwB0FHTwQYfS/HrVBXdjL41
 udiNEoLLiQuNR7y2n8mBEukWAxkLMp5U/DbGKXmDRNY2+k3Z6RxguwDYM7dkCFvGyny2
 YMfEQQDxhHh/KGSgIk4krhhp3ojSYyZBjf/+N3HvoCH+mwz2VBct7Y6pI0+LB5h7/Rjx
 XCuPskKvkFufrPSKslzHJIn09+z1ttutHlYtMQvKaQ7hoQJCaYjcITKtdTOXGd3Pyfrg
 DR1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpKuZfCgO/I9lwqa+tMLlwHVSklA3cH6tphSbZEMlildSL1VY4816x//MXWDdimSC1fm+jOwc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLQ7vH4bb4xuycKpXFVsLh7OZTfb27dDIbAFl5p8Fb7k/9s7oAm
 EEw6mRyhFoluRxwRfmZFAofTZZyeWpZRkdiLiHAa8sv/6hrGqxAZVkI92iEaKeCmOjCT5eIk5EM
 UW1uGoIHNw037m4NzaQtBLXeH5Y8Dc0sQbwKI+67lXYnNOkA5JJXiWTggRPbCdNwHMHBmTVo=
X-Gm-Gg: AYBFou0fuSy66VEQmoe9l6ziWS0a31XO3L3qpfk92TGhvji3bWf5J2CoxMXjfw6fbie
 O8iSwGTRWoS+XXEbouweWJ095mJW4YZqbyAQvR6YuXF/qaYRXcAzdkHRR29E25fSOxXj3hnIysE
 5XE6ehFcMfYImJjgJY5Sb9okWfuvh72RxTc3XJVjoRZc1KcR6nZIU+jrYfNoAVFi8p+tqw41QGq
 K5/QtJy3whjslGJC8GFIY32cvaJiwE0yBeiB3GmUW0ktPndQYUVgqfoRVCzAVOza0Uhjwjp7bfd
 l1ljUzmfxozpQ6RG9rcv85Xq4Gz5LaJ3UyeOevtQUaoBEle3/CtUrHhtEhIFghraLUiTf113Wt/
 ONJClsQDrNvSkscOyziigCjUcB1s0MWzm/PBFbyiz1RRoATExoCTvacFiq3rf
X-Received: by 2002:a05:690c:e256:10b0:8b0:eb93:fba1 with SMTP id
 00721157ae682-8b157d96b67mr3124927b3.47.1792711451600; 
 Thu, 22 Oct 2026 16:24:11 -0700 (PDT)
X-Received: by 2002:a05:690c:e256:10b0:8b0:eb93:fba1 with SMTP id
 00721157ae682-8b157d96b67mr3124877b3.47.1792711451247; 
 Thu, 22 Oct 2026 16:24:11 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b1560cc857sm5572067b3.9.2026.10.22.16.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 16:24:10 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] mach-snapdragon: dram: fix SMEM error pointer check
Date: Thu, 22 Oct 2026 19:24:05 -0400
Message-ID: <20261022232405.845399-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020-dram-smem-errptr-v1-1-b79712e1b39a@oss.qualcomm.com>
References: <20261020-dram-smem-errptr-v1-1-b79712e1b39a@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5MyBTYWx0ZWRfX/w6bjFcoiRWd
 fIPQa2L8ss9i9zcnMdctZ/1Npdkc4nUMhLaaKgMWgWC+S26oIlZvVgbShnYjdVuzauetrPIzaco
 cdA+S0GKlk3YkdZtDdUs6C/LjQiVn50=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5MyBTYWx0ZWRfXyZfYw3jgxNHu
 dPztbFeS3EV0tFcMi8kXFymfwB4djh1fBih/tdxj+IepGqlwWMRcaK3iGrDIb1saaKg5QfJt5iW
 IaHemfJwe7GhhxIYRZv3RxfqqaXkh8ogPrY7gogEd/pGAitpmKelLwXvYewP/OtjA7uSdSq/bcH
 J2vjQVD3ZXy3UYnBMuzKvC9NWltJlQ7sMvQx/DlZ3wr23700b2ubhZaUVlS7/3eB+iihETePL80
 oRZUn/08BlTgP6p1tNxOESrdY5u3k50gDl+WCa7WZ9V+Rw5xUVRfSf8y/sQie+1AMW2iwJo7A4Z
 TIAThVeUna1Htf8As+vuyyWr57PjOIbnR990s553nCkzOjL9ofVvsqBp/Q59RiduEJlpg6apCmP
 6ZVvs5bGTWT6Dss44WCMzGGplH+NDySEuauHbev/1vH59mneefxljQZS50DpDqMribwVvapMwS6
 nJiwUrO2DdzJC9zR8IA==
X-Proofpoint-ORIG-GUID: Ezap2gxh3gULVXZoVAX5bipfwzSnhJ9Z
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6ada9b1b cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=2fKlGwYCuM1t6vtR_mIA:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-GUID: Ezap2gxh3gULVXZoVAX5bipfwzSnhJ9Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
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

On Tue, 20 Oct 2026 at 11:59, Vandhiadevan Karunamoorthy wrote:
Reviewed-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
