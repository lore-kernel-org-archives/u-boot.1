Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7D5606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CyDpmIVf;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IsCeuNzB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hzPld4xg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E704B81D5F;
	Fri, 30 Oct 2026 16:10:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 52_BzSfDXMO1; Fri, 30 Oct 2026 16:10:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E293081BCB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793376636;
	b=EQ3472ebcQ5cggFKgsA+g5y0ncjNjrPb6vcCmJwwLpvGX/4sOTL64FTZ3mKHKTIUg2VG
	 8HLe2n9qj3BjTfM1z8UqhsVLkNBrW+C/s9K74WyPFJ8X0ilG2j8hiQMYauXbRy4AYWZzk
	 2NaQZIjiKAlUjd8EQWZbP8l/PPO65sw/35ShlHZfMvUM23lGZUznco08KDjeTdaaRhJ0p
	 1lZO9YIlaDL7mhjgke3teSA0X9qRk8k49YnZ1LBMqaxPlwhXe7nEq/j6XbdBQE/tOKJFt
	 ur0IFU0VDNGaRPm1HtkvH8ZSUioJytWXxePY7UKUbOVkM8DhoabtL6qHVEMlAHy9eXg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793376636;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VEZ0ymS6Igw+MWk0TmnPtYwUVaFnFUipT3IylunB9Ig=;
	b=tVk9MkaRQgo0cnWr03QDgXSHazb8Q2CgxI70buiwEgvjDoBTypkzvoRqBVFoMeLnElI/
	 JQVgQi5K6nBy6DSZLPnhey85d0C092fTd40YzkLKbSuDgrBg2b4lfhY2E5mfFXuSwis0g
	 ft9G/9IcAs+XX41SC04cLC1uMajb+/ckFqF7OW+KMy/P9xgsHQT46x5k0UnF2gIP+qpHR
	 4t58NyplNLpBSd7a09GqiTpQoK+9CTT41RRr6ZtmjnHagWVK5L6swaiGh2h1ygJs3uufm
	 mkPJTG0edB3ubbWVEyvyyT6ux4+j0MSBT2FtaGd1i5H9UHWXoJ8x3OxSL1hA/L4Hk+Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793376636;
	bh=VEZ0ymS6Igw+MWk0TmnPtYwUVaFnFUipT3IylunB9Ig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CyDpmIVfIbCZmoweDMvnZrRXJQv4SiYzxDHzgKnuhOLjGWKcqR8UGXcm4C7Ty9RWS
	 cXt/pqLe2iHhLjmUZB90t6WUkk01UBpWkEfGgvAXFJPfC0nZ4OVunyTn07m5BdbnPm
	 aTUmZAT+RQ9mmd4Em6DIWD5FWrIVq0fJt0AP9dXV+pVOqW5su9nBTciWnr1m4YIUYX
	 O3ZOvpYNtHVmBvHP24dGoFz5p2Cx/H+VhAJeFIsiOwkwfLkEmvJS6iUQA7tHUQr7rn
	 uraSNxJ0BFhZsktTLvSR6gVP9UhqQxJ2nfn2wXvIJ62BdeezBhF2Iu06kZ2EW30t9J
	 c4md+KaHzTjKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E293081BCB;
	Fri, 30 Oct 2026 16:10:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 61432529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:10:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52BD540D04
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:10:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dnm7AwtRs8kY for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 16:10:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3598240CF6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793376633;
 b=kDO8AtOxSJnXItoHdm2uJlQdFI1VJqSIM+VDlfdv9FbaTyhgr4J39HixW826e68x2oo2
 g/VO5c2VqDlqxv1FQcbNBg8fTaHuQd+uLLYZMEwpa+T9xoAhg67GIg7KaqhzMQOW8WcIh
 yBMDawznL6exA/J1paTUoRoq7MRR029Tqxwf7UWPLvdFuDNsQ3P4z3k1zhy3c8chrJkYb
 82NtxonO56XQk+2WicFrArSp/XHvjVHlRx/MWHBtCLYL9A+YB7L9jOtAIHViEyoX580Vn
 e1BckBjp2yVFoTuUptwPa3MQe3G+DKVVxWj76DhAMtHAh6jgd41MgaCcjL/VqbWQPaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793376633;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=VEZ0ymS6Igw+MWk0TmnPtYwUVaFnFUipT3IylunB9Ig=;
 b=JsQt+tPokGmM3f2jbG2LLwOZ03TlDXWCiPyxquRufWnvfmi6RSM8e7Bw7kO0mL7X/XeP
 vApxLRfvfCVDFygbkxx3gNAQiSSZahmDORj84uSPlTDxpYHdwdp2mBVW0MIkS96fsxuhB
 Qo/rEgIkkHsUcLZZWDQX5uGfESKsD+BvkqHCSTdOeKac3GdOnNxs2wPi8Q9/oQIfWZu5s
 xxILqvLI7ejFT3bQ+SPaLwibGbB5x7SAGcJ+gPSH08AXnjuuChJnQfLuFaCiQ445YAaIn
 YNuoL3dMTyhJRHdwxcXBEnfx4ywt/l8DecH4lpbjgpm41OCv5eXYscXscoYITIZd0oA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=IsCeuNzB; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hzPld4xg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=IsCeuNzB; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hzPld4xg
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3598240CF6
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:10:30 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERB3Z2494580
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VEZ0ymS6Igw+MWk0TmnPtYwUVaFnFUipT3IylunB9Ig=; b=IsCeuNzBeVIL9ss/
 D6Gf7MyovDRf8RMDUosm+QvG5H7E5u2f6k0UhDOaWeFyNeOQ31EZXF5bxYGU5/ZT
 qefkbFYPFi8KGn8odlsnrJnbnPlEmi9Z/PZ+HbopntHQhC+agRnBq51ojcCNE/zP
 +ArLvoJOl/i6AQxaerC4morQc+21S7TgYt6hMWC0yJorlDIHAU4d5+fSOgpCiFZV
 6M3/fADSjf5xNgZaTPlErVCpT3V18QgRz0t+LgFvZRlPuKGIy9qdaCd2f1gv4mPT
 yNrSyW8DA6Y6N5jov4qOmJhl4+hfR7V8ZxMeS6LWK9R1+bcZc2jFWkA4+gD0TeRX
 cmnOzA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p3yd2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:10:29 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8acc7fe346cso13582017b3.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:10:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793376629; cv=none;
 d=google.com; s=arc-20260327;
 b=nlP2eS2FGAHjRryyiToUMAAjqEgZJaY8t+X+veOvtRjbx57p00lYDa6HgEcnkKmf9n
 cTCJamE4Fvd7H3l2U6QJjyYsNvf7rEL+2vNo8y6lWUUvFy2WyNllLdOQeK5qhuMzg44o
 OkerqyEa/IkXCqxO13pgT5ddgA2uziRYhtyOm+4umltHCgDJc3BPTFSDb02//CSgAxd0
 6ipQ5Z3UnxDbw5VRWEEGU6bwtln36U1O+ld6H7AhNE4H59m+/UKbhGu3xbvjxrsrtFtA
 u3u1xLoIHhoGbtaNaRhe7gnIgjP790g9aCuibvjlywdtTvJDr8nUFjMGouQ1JUxMMjhM
 J6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VEZ0ymS6Igw+MWk0TmnPtYwUVaFnFUipT3IylunB9Ig=;
 fh=hPwIHusEFTDOh1ypKE8Su8y5M9CCu9S3bdmQuE23iP0=;
 b=d8xuONtscfoM+nJtU35HSBYtnXSKz0ICLo/HvtITglqABjWzqNmNLwNwrTy4VagKm9
 XnjBPzRpTRVWS85K2pyPwvyCAFk4k3e0cyN7KkKalIvSKsmdno6VCwuaeKI4sobNiYsR
 oD6MNvf9pNpLDgZ8FQHE6RntRWJp4oBfUg1FP+jmO3eBgIQWviwAFIIUpGYgZKIcH03e
 pHRUtvlhAVdtF9YnhE4PFb7Vr6VZDkdMzP2ADdwsHRMQeaEiKe1gsDSRlEBvMarYlTIe
 Fsuueonfg+R4boQ6MP3u4CfonMx0QUC8usWDGcva/25DCtBZche5hygdMBYbeTUo54Ql
 1UIw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793376629; x=1793981429;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VEZ0ymS6Igw+MWk0TmnPtYwUVaFnFUipT3IylunB9Ig=;
 b=hzPld4xgz2935yMNn2DSqopeDp/rLtSgLcJiGc0tkPB50ws2Q+lqCF/LFp0fQxW7jk
 A402oK2qUmbj+YzlRLwZ75fklQcjAQg6KqSPT2uhIXovocshe5pwT21huDjoyJpoXPj4
 w0sCPnCODy8XXuRPJUJwwUoWRUZuuCZazLJ33ntN3NRNquoiRCtHND4Nh0kb/vCMjVtz
 GGAgmBoelq4hPMRUyDoc926fhivof94i5yCMPuRLiXrWrIX53CkzTwKKEyGMRnqTVCbz
 lgGhOqr8RGA6Fy+KyEiL1/Yi6q46BVadR9+QkyQ/SKQzoulfdFIj3isrLa1lS2erVuz0
 TkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793376629; x=1793981429;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VEZ0ymS6Igw+MWk0TmnPtYwUVaFnFUipT3IylunB9Ig=;
 b=2zX03hSdOE718JnnBruDZDVVLg7GI/tDvksmyQsIHgKwVhd17nQNxDgfTo8oWa3zw1
 q4gZ0MviqHdNjHnCtwyz7XZLeh5rVZZKJLFKYlcXppz+U4hnsm/C/y6QR5aFZI6IQYOi
 0m8Y1NkDvU5ZKtQwghingQyyIjf/yftmq3XrWCVRMgqJNJZYruQbxTJXwicPfqDcZtFn
 cAuWHRutRyX8lPEOT6BQZsLSK/ibquGrF0bxr7FNheVaauBeVy1OBkmpT4C2yq7wXiQU
 UCg9Fhs+WvHm4nCKtMbSRUaLwlwN5HaWMc26Wu9QhTTIR4vOeQA/P7B2vzPr4Am93lEJ
 j6FA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVZtGXkc78DOipQu1cweJkZ09AhR4lp3qQKW4zlBPM/DbKJYkMiZgcwqEqT1h/Qj0Q+0Jb0oE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJSzqT8FbefOrw2tHnwZX6m8n65yHro4g4CTMaudHaTXOXweTUS
 GvNasOpodedvDSigHGSkKfNoMs17tHYAAdVcMTwzKfHAeAM98pVvgF+Ic/IKjex7Tzm/g1tcx+H
 JaIC/x8X0c3McDCIZkWkWr85QWSv+W11AXw3D4bgMVQSGQtSaV+iFMjcTzg0Ed/dGwzYTHA5p95
 CVkBdeRrIC7uYvPdUVUQ+mu9nJ4/xMquZQByIyxPBHUxi4Gg==
X-Gm-Gg: AYBFou0kPtlYYtINH53bK+L5ONcEicM39zCyMNuAMfWTbS106eeZn4ht17XSW0Tq+8c
 Dfn6Hh56d+90Gy34BkWtnjhm/KfQgRLL0mjIiF0/TaZf01OkbF1zPyqFgTEPHdk5HDUsI3IjeWu
 xdLY3ZIc9aPbg0REFe/YclzIeKof1Cz7sxXFFaPzORqBtVQpeV5tAhjPw=
X-Received: by 2002:a05:690c:4388:b0:8a8:466a:72a with SMTP id
 00721157ae682-8b2b67c9c92mr14994207b3.67.1793376629130; 
 Fri, 30 Oct 2026 09:10:29 -0700 (PDT)
X-Received: by 2002:a05:690c:4388:b0:8a8:466a:72a with SMTP id
 00721157ae682-8b2b67c9c92mr14994107b3.67.1793376628614; Fri, 30 Oct 2026
 09:10:28 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030-qcm2290-qup-pinctrl-v1-1-f7940c974a30@oss.qualcomm.com>
 <20261030152545.58608-1-nathbappai@gmail.com>
In-Reply-To: <20261030152545.58608-1-nathbappai@gmail.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 17:10:17 +0100
X-Gm-Features: AclHuK8bBoDf7nR2WChkpT6mbpZMKQDGiZKEAJk7-p7cCcMMSHgzhwW4W166fIE
Message-ID: <CAPzfCAZp=t2g2ve2fj-6tyxFdDiPcsm+8svGfrV4A1+zAY1wsg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: qcm2290: add the QUP pin functions
To: Biswapriyo Nath <nathbappai@gmail.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2NCBTYWx0ZWRfXwM0xwr9kcbyC
 k74GxzT+cJVOfyHJKe26rqPT0JBMDQbX0cbXlf1N5JGSwOr1yCn3VRsRPaIa1AwrSeC9aBY+s9+
 sksxX8YoXCP7orEuHrbo/O5cYhECk/rMXAhlzHgs1yPeXZFSrSjFvenF3H4h6RUy5dUkWPIQ+5n
 fc/kgj1zwHRZeAlDyHbxsS5pt6jQ8ijXvjFIyHQd9bIEkMXoLHMeAkBlw9duQdHdLzJXuTOwnrk
 BV2vnY22nVCF8c6GRvfYd+fPMHMOT1yv7Ssco/t38OApIiGdpv6AAifhqeemJffOWMcDz8WyHvW
 0puRIJqitUV/ptTk+GoqkijC1L2VuMci+nQnk9jRRlIyp62mQqVWQcRLebSnOsr0Rd1NnSMSCPW
 QZ1O6/+4PFEYDwRUujdGSrvHhER1mO6CYN3+eMKRyyXQO3OgMFna52GZt028LL2ljAP2DL200oh
 e9hZVAciI+7KM1ZMpHQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2NCBTYWx0ZWRfX6lfHoH5jGZY+
 CWCtps2L2AVWtICcOikfYbsilzdxptV/ZLCIEnRc1oxY19fhPzmH3MnxOtiXXUhiw0+IA16GHKx
 Bgz28jxmymJLHAJeJ5SzHoSIW3vEUig=
X-Proofpoint-ORIG-GUID: 3WMpaIi4cCMUtFXm_Gynk6gVoxMkHx1p
X-Proofpoint-GUID: 3WMpaIi4cCMUtFXm_Gynk6gVoxMkHx1p
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4c175 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=b45o4kL6AAAA:8 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=O5qQgMBuf_ecLZAaAisA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22 a=dhdsR-PFWuPJUldTnwXm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300064
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	KHOP_DYNAMIC,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Biswapriyo,

On Fri, Oct 30, 2026 at 4:26=E2=80=AFPM Biswapriyo Nath <nathbappai@gmail.c=
om> wrote:
>
> On Fri, 30 Oct 2026 13:34:05 +0100 Igor Opaniuk <igor.opaniuk@oss.qualcom=
m.com> wrote:
>
> > The QCM2290 function table only lists "qup4" (the debug UART) and
> > "gpio". The default pin state of every other QUP serial engine refers
> > to its own "qupN" function, so the function name lookup fails with
> > -ENOENT when such a device probes. On the Arduino UNO Q
> > (qrb2210-arduino-imola) this prints a warning for each enabled engine
> > on every boot:
> >
> >   i2c_geni i2c@4a80000: pinctrl_select_state_full: pinctrl_config_one: =
err=3D-2
> >   i2c_geni i2c@4a84000: pinctrl_select_state_full: pinctrl_config_one: =
err=3D-2
> >   serial_msm_geni serial@4a88000: pinctrl_select_state_full: pinctrl_co=
nfig_one: err=3D-2
> >   serial_msm_geni serial@4a8c000: pinctrl_select_state_full: pinctrl_co=
nfig_one: err=3D-2
>
> Hi, I can not reproduce that warning with the same device. I built
> u-boot from latest master branch with max log level option and early
> debug uart enabled. Does it need any extra hardware?

Thanks for testing. The warning depends on how the previous boot stage
leaves the QUP serial engines.

I boot the UNO Q with TF-A and OP-TEE in place of the Qualcomm TZ. The
support for Agatti recently landed in TF-A [1] and OP-TEE in [2]. On that b=
oot
chain nothing in the secure world loads QUP firmware; it is loaded in
the normal world, as on the other Qualcomm platforms supported by
upstream TF-A/OP-TEE. U-Boot does it from the qupfw partition in
qcom_geni_fw_initialise(). Linux does it through
the "firmware-name" property of the GENI wrapper.

U-Boot probes the engines from there only when they report an invalid
protocol, i.e. no firmware is loaded. On my setup that is the case for
i2c0, i2c1, uart2 and uart3, so each of them applies its default pin
state at boot and prints the warning. With the stock TZ, the engines
already have firmware, nothing probes them at boot and the default pin
state is never applied, so you see no warning. Probing one of them
should show it on your setup as well, e.g. "i2c dev 0" (i2c@4a80000).
I'll make this clearer in the commit message.

[1] https://review.trustedfirmware.org/q/topic:%22agatti-uno-q-reworked%22
[2] https://github.com/OP-TEE/optee_os/pull/7921
>
> Also, I am wondering if this driver can be written with pingroup
> support like sc7280 instead of choosing individual pin functions.

Agreed on the pingroup table, will do in v2.

>
> Thanks <3
>
