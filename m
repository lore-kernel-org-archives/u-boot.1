Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAFE606A31A
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tkjcpRaj;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cb1Rhv+n;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EURdmKCk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A67E86061C;
	Sun, 15 Nov 2026 11:17:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MrsMNNn603Xv; Sun, 15 Nov 2026 11:17:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 816226064C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794741459;
	b=jKBLjdZxioNUHL9QTWJhyep9f1n9CXNPSZOFIX+WUjeLXLtR8Irqoc2vXmPtS3kabQRy
	 +3/WkyC1HdLBuBi1wDWsL1B4I4ATCUfTq415/CIJeZ7anV3jH04CWW7wIwhSIUADbEIEK
	 XrdqlCcTN1nW7K78LQvh/zoPIh5H9Xg88wdbV2+oDy39EUG0xY0mKI+1alx6JoHeunR5k
	 OeXXlceY2YvFOvVD1COj5H0PjTIOSSc+LYN9OvzeJIHxWtZRMcql+jmFT+ZXLrApFVQQK
	 CS8M1IS9onlEiBSgMNlAYEV9b03Mdul8jD6U06QBlYAQzlBFcfusJHeZrWExiYF8jYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794741459;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=juize2xUseFDzZ7giKIEXxS9GBeJLBQdOW0rcY6WUNg=;
	b=DDKDRTlh957TgjuctEV9T0EF0M4SN9pXmJhWnm02bX0iegYcEbcybxlA053ijjc6N84W
	 Z+QyMn2LGPyRLNaqBKavcH6IvR6JPFRpfjFk781MWfEk0eILa8ChIrxbhtC9KcCNjcqYK
	 wG+edmEcK+A1VJrzWyl43ZkHf4BmxRh9cMce0LrmFBdQXh+16AFV3NeEF/QhzA8J1DezK
	 +wdkx1i7B7JdJdt4xjsmyKm/32frhHiLhWQWtWxyUzc1NyeH9cd3IJqwSG+YGiEDuNR+D
	 aNa+rjp5lrfpaOypi09LtF7KSovVy+qnOpJ4Cc3whGrcmwuhDOdUA0YYDjGFZrPtAjw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cb1Rhv+n;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EURdmKCk;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794741459;
	bh=juize2xUseFDzZ7giKIEXxS9GBeJLBQdOW0rcY6WUNg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tkjcpRajAtha9+NasTjeMZYH2kFt1Z0FT8P0BE6b5GRfIfuSWw6F+J5HDLSXr5CS9
	 Jks0p3Dus+cBAoZza0c8vn2mVKzZBQUcPFn/lmb3YJPLrFfA9ZOI2Mv+HFXsHW1cs2
	 MpTftz2tlQ5coOrtyO6Dj+ymFlUZ3OCOE2yaQ7ikksd2vS31za//Y5/+oVHExcP5wo
	 2fqhQal136xkVFGVpCTf4IMCemzAFyj65hQ+T9i2UlcXWmS3zJ+/8il5PzI0J3k6UB
	 6XNewJO7HBSe6OdHZHzhiyI7CAJ/8ZflvhfMPlzwc5So29DkeuODH/9XIb+CoxL1hg
	 Xo1Ei0hlP71FQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 816226064C;
	Sun, 15 Nov 2026 11:17:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 438042E5
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F4B56064C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:17:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sTtQh9mMhHav for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 11:17:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3B4FB6061C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cb1Rhv+n; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EURdmKCk
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3B4FB6061C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:17:36 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF7wB001871225
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 juize2xUseFDzZ7giKIEXxS9GBeJLBQdOW0rcY6WUNg=; b=Cb1Rhv+nAz/7uxU7
 Vtm9gZdRleqPY4RRK7KfPLDKZSBUxzPUYbw1ZozyBa22tdr+yn6HJ8Xu16mYJQre
 hIhWY5KbvuTnbU9omlcq10l7ooD9xx7YEyIJ1DrPcW57wgHoI9CidbhyGksebccc
 KOqhJ0H3UipgRNNxu5QpzCrpse1D2qp7plPHGe95KJ3TGKK0B8Yd7WKbRv7RoJLS
 7B06NyUNmvxGbGVzqxb89wuobxdovgJsi/xBxE9bWw4hXBgSIVSaHHzMTNtp/6xf
 mxa+xazXPNUd+RBsdgYXvVY5ApFoCXI9oLeqvYzcJQxigk9xd9H2AwSE7q11PBFH
 UR2/wA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhnx2xe7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:17:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-378722fd4a3so2958420eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794741454; x=1795346254;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=juize2xUseFDzZ7giKIEXxS9GBeJLBQdOW0rcY6WUNg=;
 b=EURdmKCkn2snekEs3bir8dbJkSK4xTPXpt/c5dmuQYTZiDfEXpOoOeS70YMbfP2ZOa
 WvIjEE3TOb9urlvWYZklLfya1Ups91jhOOHsSDYchyb5tDcsFMO/TBZoPmuWN3E6MsQQ
 nnNXlGKYVlpb9BnOS2C7sVVNLTGp08sofLp/QVYznYYf8xDmwySRZ3LrDAMYbK1mYg5R
 uEUMbrzPDLMf2Ly1H3HURs0gv824OF5PYRSrgi56n2JJbgMC+zgB9TwmCGhiLDn3Sy+Y
 lbPJSPruQ79b3Ab7XcxOdT8Nh+OSaRfpcki7zHnHuTkzLMfn0UJdwiKECJHs8okU5XUJ
 FNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794741454; x=1795346254;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=juize2xUseFDzZ7giKIEXxS9GBeJLBQdOW0rcY6WUNg=;
 b=ycUwLk5nma61bYbaTxr/XH7Oa505Y32SwcRc2G5F/aIcZFKwBJgGlBqjhQZkjU3X8Y
 04+98Z+I+Xg8uZqLQrJoAtPOsz5a2BFUX597PymMdbj/m2F6tQSGbnPJ1oYuS6KEpv61
 xNGBWJPvQchhA15NZIS7VgTm963A9qpLNQ/8cu7cCZe3apgBalAb/khSsToEdnWli8yn
 +2hXesTVW3SwdwkGV8KlWpfxLmtImu/HgRu408TyIH4OCTNJq92SRVCD/EQiRWiRCzNc
 XRYe349RkmVNOwB+dbaXEJFypIT1vmAVORgQpCfr2Wki6L63xU3ypPq4JFBBJib+pO/U
 rZFA==
X-Forwarded-Encrypted: i=1;
 AL+hErGlBWK8TPqGCnsFeOGupmkTNswdjP2L/UPlRb4VH/VcsJ2aim4Rh6aaQkq9mvR+9iOVaWagKZ0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z807CEZ6WvVRKXCkhMmH/AvGWlr3hSEASWqZ9NcbrYDNeNb9HuW
 V1ioVC2g6bukRSAs53aBDIEjwVUKavDHm4ZuWyGmTC+evW5YmerCY70wWn+RS+CcAlXzrsuZmcm
 onyEAuR71Uz8KIJPLGIJvcuPIz3d3w+8jUGJoRd+kp8i+jRmP5PYjPSETpyvEW+F78gaS5ik=
X-Gm-Gg: AYBFou3Hx2AzdZQjVSMc8xvsSAekl9BClxj0GQozOW+uknnBJCZpMBPV0ATkMum6oLU
 3+1sxP/Y3mNizeR4GzyciHYaqSZE8Uxp7TBXmITuRat3kfsZTp1ENgIH5paM1GF368TXM6yt7qH
 EZXYEzrEFpjGZ4sIc53Wxuq77C+pFnWg+feu/56/GBGy9M+y6o9JFYTGwKQBXT/UoNpyuSTrh4y
 Gz1iqrNJNK9uRsu9sprk1eEJthItrfMXtqSPlqr20PtplgaYMp84XXzcVtxUUL7Q4eVizySTqfa
 3ZVAUfnN2emcSEZoYnaLEJ1k9x96AuFTjtv31Kf7tKGDkR3eybLMe5JDYeYt12e+wJAxk5BVhPD
 LQJwhRGLvAAnTzqpNeaPmyiR69brkER9OCBIh1aGH+wBS7mc+Oe/nC6CsBc4ZyrC/qoCqqQk957
 6PHdaqnGU=
X-Received: by 2002:a05:701b:418c:10b0:1a8:ff0b:a4e1 with SMTP id
 a92af1059eb24-1b5030fc737mr7734336c88.18.1794741454378; 
 Sun, 15 Nov 2026 03:17:34 -0800 (PST)
X-Received: by 2002:a05:701b:418c:10b0:1a8:ff0b:a4e1 with SMTP id
 a92af1059eb24-1b5030fc737mr7734325c88.18.1794741453834; 
 Sun, 15 Nov 2026 03:17:33 -0800 (PST)
Received: from [192.168.0.2] ([49.206.98.25]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b505b5bf76sm18449502c88.10.2026.11.15.03.17.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Nov 2026 03:17:33 -0800 (PST)
Message-ID: <1f4f829f-1c1b-4295-bfa6-d76ec9a69d05@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 16:47:28 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] tools: mkeficapsule: Add support for parsing capsule
 params from config file
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>
References: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
 <20260727-mkeficapsule-v1-1-5b162866b092@oss.qualcomm.com>
 <DKF799VHIW2Y.SN931OAT6JCC@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <DKF799VHIW2Y.SN931OAT6JCC@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0NCBTYWx0ZWRfX6LgSEhemINjI
 v15c+KaIHYh1zUVTrFNZ71T4VR7o/AZ8azZ4GZq8AzMjGnBn3gVe7y6dCXhHSfUnvyfby6gVSnP
 +lXwS0Xex2yZItrCUmoeEMF4fm1m1RSvg7hKfmzwW7hK7BkVss3xqMcjZNGUyjjn0EryekSEXFw
 qTt1Q37CU5MWyT1eTO/tKe/431EO5K2bHb9IptxYvRWGuFuXh6qIv8CMu+04xsZWi8ch2J0iiXh
 jF58GH/Ane5qG3BW2jnMpZIFjfANiYIbmyuGyq71Pl3PaODsjYoar1zsWJTF6PaW8eN4v0rD7Z1
 RGRG8FsfEzHvjfm61caGMgd18GnkbDczLUVlcxq8oYpTP/07IhYGLAOCxvFBWzfHpymDFulynul
 FqPLb+MnckidtjVL+jSgTgG7Pwq7+Oj+831pUQjZUsNvyq+9Lp92DKjlezDn5aZbFHDhTrmqEZo
 hZm0sfxkTs9INXXeelA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0NCBTYWx0ZWRfX4sPvayewLmKh
 1Hh2zkKvoRsjxfHq10Y4LmA90EDDYFsozw/qlntxvdZUjQq1SZWxnLTw6Heo5O8sbIvid9IHnNp
 uux9sJ/O5tQg3Sh7Y1xoc1SQcjwZwww=
X-Proofpoint-ORIG-GUID: tFzON4EcS-ZpLzAPPLNszUKZs2iBay9T
X-Proofpoint-GUID: tFzON4EcS-ZpLzAPPLNszUKZs2iBay9T
X-Authority-Analysis: v=2.4 cv=Jr5kP84C c=1 sm=1 tr=0 ts=6af994cf cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=B+jc5o7RI9DO8wW/BDIZNw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=AjMvqbvzeM-aRCwd2YgA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150044
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ilias,

On 8/3/2026 2:56 PM, Ilias Apalodimas wrote:
> On Mon Jul 27, 2026 at 6:55 PM EEST, Balaji Selvanathan wrote:
>> From: Sughosh Ganu <sughosh.ganu@arm.com>
>>
>> Add support for specifying the parameters needed for capsule
>> generation through a config file, instead of passing them through
>> command-line. Parameters for more than a single capsule file can be
>> specified, resulting in generation of multiple capsules through a
>> single invocation of the command.
>>
>> The config file can be passed to the mkeficapsule tool in such manner
>>
>>   $ ./tools/mkeficapsule -f <path/to/the/config/file>
>>
>> Signed-off-by: Sughosh Ganu <sughosh.ganu@arm.com>
>> ---
>>   tools/Kconfig              |  15 ++
>>   tools/Makefile             |  10 +-
>>   tools/eficapsule.h         | 101 +++++++++++++
>>   tools/mkeficapsule.c       |  90 ++++++++----
>>   tools/mkeficapsule_parse.c | 353 +++++++++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 533 insertions(+), 36 deletions(-)
>>
>> diff --git a/tools/Kconfig b/tools/Kconfig
>> index ef33295b8ec..8e09427fbac 100644
>> --- a/tools/Kconfig
>> +++ b/tools/Kconfig
>> @@ -114,6 +114,21 @@ config TOOLS_MKEFICAPSULE
>>   	  optionally sign that file. If you want to enable UEFI capsule
>>   	  update feature on your target, you certainly need this.
>>
>> +config EFI_CAPSULE_CFG_FILE
>> +	string "Path to the EFI Capsule Config File"
>> +	help
>> +	  Path to the EFI capsule config file which provides the
>> +	  parameters needed to build capsule(s). Parameters can be
>> +	  provided for multiple payloads resulting in corresponding
>> +	  capsule images being generated.
>> +
>> +config EFI_USE_CAPSULE_CFG_FILE
>> +	bool "Use the config file for generating capsules"
>> +	help
>> +	  Boolean option used to specify if the EFI capsules are to
>> +	  be generated through parameters specified via the config
>> +	  file or through command line.
> There were valid comments in [0] which don't seem to be addressed.
> Also these options seem unused in this patch. If they are needed they belong to the patch that uses
> them
>
> [...]
>
>
> [0] https://lore.kernel.org/u-boot/d50d88c9-445e-45cb-936b-0c1fac2cf8ad@gmx.de/

Have addressed the comments in [0]; the options are not needed as they 
only used for sandbox testing; removed them and hardcoded the config 
file in sandbox test.

Regards,

Balaji

>
> Thanks
> /Ilias
