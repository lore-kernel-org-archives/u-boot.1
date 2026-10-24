Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9C8606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TJ6yKYbG;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gnAtwgUd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M0c29XN/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39E49407A4;
	Sat, 24 Oct 2026 18:27:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C0lGToJnM5aV; Sat, 24 Oct 2026 18:27:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 423E140787
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792866456;
	b=AelfNm9LXkhMoE2aF62yVnfZsS0tyr8KCQ2wl6FU6dj1PMmHQgaAepOY4jslZ2vjXE3A
	 v48pXdEe0fjF3G2EVHtE1DFvFRsYHYrfVPF7ZVYfYzGI1eVtDfSwVgtx76RVCMMT1i1cT
	 74od8/KvjkhvLEMjxB+OjZMZ5SmGXpVwkHbuCbr6lanq3MTr0s8SeHFm6uVMNeeWhrLxl
	 IA0whzRAAzVJKn+Q1mKPPbBuTC+mn5dVF+BuZPKiUEaJ1cyKyiqMZMe+Yz5sYJ/IY7c5E
	 Ra0rRdx763h5fYQWAqtYalvzLl1N41cT8EDyv32kuAmzi+M1Y10UVnjtyxqxkH3KW4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792866456;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=V0TQijaZxvJTf3o6i/Z4s9408ZKrSacPAg25vR1zwn8=;
	b=JO3R6EKvfdpOdMP5I8pxnVb+2DGP16Fh9D+GWgTNfJhTNSh3VKeGYZAkYz6OEyTgoLpU
	 r4hkKQoi+6fpFCzrI+UFjUC3y1LXTUV+R8WW9zkk+JOXF0Ki9n2pajkNTmEof7IQja/F2
	 OR9HxYAYSy0CGQiRbQ+GTWxp6nPaT7lDdtsY/hFd5lju1fYvLkG+wxRCl4+p1XGDYlol0
	 JfC0oMKFK/OfIdkGgSLetIUvDMErcdzp1O9Jb6VlyEHjyGH9+ynGtWelcGVi9aCUsTdPq
	 vlcI9E+NMI0O/UWihKMb9vH35MvhAjN1m20HEuvXq7uOn9kQGm5LjXEv2qqdpPMcxXQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792866456;
	bh=V0TQijaZxvJTf3o6i/Z4s9408ZKrSacPAg25vR1zwn8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TJ6yKYbG78nBH1pljJHD1jmXIVeWeQiIOaGK5HP+vd9D7Tv+KD05GYb6W8UUK/la1
	 oXBpHRVtgw8QfhUsDIYH7H7DuHC/PslSUDTxbelpwb0mxOGa7lgCuD8uHEsy86xCUV
	 UxO/3wVKGqtrESLwrs7joXAf6KBX0O+Z3nQXL6TKENgSXfpi49ACN0KC3Bf2qQfI3Z
	 Gv5m3xa0i3p9/j7xbVQMs8xDQHv3po07emuYXf+RA4E4EF/xQOSHzyPaWKUfMyES30
	 iHo+TH8+7y1Pp+490T36wh9AKW4OCUbIK3JnxPq3pefvIedyVMDbEXFWxbthFUIMQt
	 VEo36IN6v3wsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 423E140787;
	Sat, 24 Oct 2026 18:27:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B51D34D1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6E684009F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:27:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UO0Q0e1h6QjD for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 18:27:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6447140049
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792866454;
 b=HjRzG6FYmZTi6Z7Zi1tSFrSFynSHJa+UZjd50pCmPS+ATb1vd5ZQ71Gn2Yjh9U40j5oz
 4FJZoVCSGVSVV21KYvoE6zED5mSBrSwj1N//S0Fx3m/LDiL/kMq3QwnnCB6zs0I5YmnKm
 1v8ElumjIiZEcfMQsyhjTahqwhTkAJtvKpoDen/LNYMYOm2GlRkQEsTypLL6ASbBw5mgM
 8FkcZkD6walKMwxYRaUS0PQRy1A3B3U3mGFS1y7wBRqQlmpOsLRnCMzJwhYLzKXX4R39F
 g9eu1rM2opoEhkcfpdkeW4Y8RC7jIRBmGMJtFxGjjNvPTsEHRjt0sevCUOgCK7ZydZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792866454;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=V0TQijaZxvJTf3o6i/Z4s9408ZKrSacPAg25vR1zwn8=;
 b=sKwcFBnXhFN8n0xZ1hBaCSVx2zSRHLkQcCP9NQynEVQFdg1CwZCj3fbJ7PHRD1pbW2yv
 Me9znZ9P/clPzUyhi1vGW+ak/BWgSwLOKINlh3apUXbvA+rLu1ZLFncDTybcQofgaQwDQ
 rPihBtfTe/txr2fM/gxnJWf1tM2EJ2xc+0kw3tevkZHaNmN0eHFpYhqEhW42OJXxxHUEB
 JxhoPGIy6n+ObvM96FJT4GbB+biK4C5+sBYtf9gyTodEBuvJ8qtpb6S0zN8Uc4kDlcj/o
 Ox4Zha1AZjqBLyaaGiUmMzWjaDeINe2OXEwB0ijEScLC6Y89E857bUz6cjXCG7QCK5g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=gnAtwgUd; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="M0c29XN/"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=gnAtwgUd; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=M0c29XN/
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6447140049
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:27:32 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExocL996404
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V0TQijaZxvJTf3o6i/Z4s9408ZKrSacPAg25vR1zwn8=; b=gnAtwgUdINlqfEJJ
 aHxdkbgzs2fy84OpmGbP9rt3kLOZjzgD06qwsBOEq8ERBh3IIHXJ67L/x/b9GBgd
 +xxTomSZ6kH1n64H6AzmLFBByxIr/FENh80m388F8j6uFE7IrGDKqIkGIUXDT28Q
 GvGDW7kKCW/ig8E+Gg0p1mFyUzmoWFAIj9ZJf8TQNMBzizpaQzSPna/9ZklOFn9I
 cpb4XW3SBpONK9ODbrq8zZsMRNRbUdDNlpCqMJeB3Vo1oZtjFuXrhNxcQupquVMx
 kNNh+0zoHZXruoBW1PWIqRoZ5eI79J+z1vQM5SA1Y+vcN6RyoD97RANEIdVdBetH
 aa9bXg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgny9sde0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:27:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-351788121cfso7316945eec.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 11:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792866451; x=1793471251;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=V0TQijaZxvJTf3o6i/Z4s9408ZKrSacPAg25vR1zwn8=;
 b=M0c29XN/kIdvd8dXGu29qMlssPxbHC5LLDJYeOIe92LjRNJfETQdUUtW1zqlrFyHMl
 rXdZqyp85Toqu6+4kox1G/mwF2tKPtQIAWlbUq0EnQY3wDH/2NEviZmjQduKl0BO3xPz
 E6L4QlH8BoNF7x93M4+jvB8ZNIVEMrs2sLqTDMFX32prONTy9kRsUgvEVwJbMPcBB5py
 hvnxCln2I/cadSr43oYoLLs+ZyiN/ny2mxmL3X1RS2u1ZYgGI45zbou9kLAhjNz5DsSp
 LKPLhhUfpQ7jaYB3QEzQvxavacGY0Dx47W6Z4uWe3rMW8uNzTaChKeysB3dcL1EaUHmu
 xVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792866451; x=1793471251;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V0TQijaZxvJTf3o6i/Z4s9408ZKrSacPAg25vR1zwn8=;
 b=L8TsHJdS7QiO8kejcK68r1oKdbDmlpufePbn5iXAy7PK5IDc/cDBvbX392RZufDz4H
 eU/gNvfpdJktJmPSi9SEXgtzvNgeR2V9M3YNmSaR4c9n5eqBzww5lCdRAASRzYkqyE03
 2tSJPIMnB23xNNne3AFqbv834K5fLT9/1iviuiPYLzhMbD7hKw9ENkgOdD8g8QzBEkAQ
 saOePPH0muO7TJsOCrdx9Y4YbHc9o0pVVvLQ+Vaed37Wwcbcld9vzqAJYvFnzeR2DpIT
 uaWw2Q0gYQay9yBmP5XS3Fyud7q6gegW8tBa++f8sJeZuPASImh/2Aznk6iwMdk69h/3
 RBjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxL9YiXRrixyogvPXP1GcEElBvCLROnvYi0GKFT6noGerVHzHvyf0hk1aaeE1TMgBb8bQKa8Dk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLsjAiQYojB8BA0YAl92ZWPWkfq/Xd131owE5N9hPuBKbYhEx/z
 hSi+RcVb7KMvu+gyBTuGuZEYZk056ULuzBLrtuOG4PAi89XiMFxY6L6VZUKt2B+QIZ/UpktLY5y
 UJOh3zSQPs+HmiA0T+HmtUH47ZGoeMDcu3i5aCa75P3SrchisXrrfUKQXnBGRseCmWT7AOg5Z2l
 crVD8=
X-Gm-Gg: AYBFou1Mrl8G03Y7rWCxqDlKD8dd+JdZjAj8QvN6MJW5Z1EVFJW9X7/jImZ1+KMZv1F
 4FyaFN2hOxC6SFywxYTTaGVv8HSksX+QIgHJbUE0OvjEs1PBMLYLEKyQWoyNAMHsiN8Eg09vZkG
 S55SgXy34Hfc5f182i898d090quXmWqrrGSXRdxycA/3Bx821SojgU8PM5xexdgMuQBOcPp1muj
 nzfz82To4XzZCF/N35TEGCI0Wa5jo7TnjEVrx11trx8+V5cPCHDDudWllNd9YLuVrctmOS4qB7K
 oCoHXo3oNc8OHKyEXE1tyXswq4tTtxa0ce6QUKLC5JYtmT8bHYOq+scgexQlgkRp1Z7ujbWnYZa
 bZfmJyJUYvAyLE38dhhgTyUgu9s30N/Q=
X-Received: by 2002:a05:7301:f26:b0:362:fa87:2aa6 with SMTP id
 5a478bee46e88-369e81be93dmr3419850eec.0.1792866451154; 
 Sat, 24 Oct 2026 11:27:31 -0700 (PDT)
X-Received: by 2002:a05:7301:f26:b0:362:fa87:2aa6 with SMTP id
 5a478bee46e88-369e81be93dmr3419835eec.0.1792866450645; 
 Sat, 24 Oct 2026 11:27:30 -0700 (PDT)
Received: from [192.168.1.10] ([122.164.245.57])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369ef6a71easm5761358eec.5.2026.10.24.11.27.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 11:27:29 -0700 (PDT)
Message-ID: <d6f963b8-e20f-4242-af53-a9bb795aa791@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 23:57:24 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] mach-snapdragon: Add early EL2 hypervisor switch
 support
To: Tyler Baker <tyler.baker@oss.qualcomm.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 quic_varada@quicinc.com, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261013110525.2465737-1-aswin.murugan@oss.qualcomm.com>
 <20261023174731.1554193-1-tyler.baker@oss.qualcomm.com>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20261023174731.1554193-1-tyler.baker@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: v-CS5B01fk52VFjvAo18aZJTB5-2AyTX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MyBTYWx0ZWRfX66Tf/7hrevgH
 yte5vT2egmbuHeAM8W9pfzQ/x6I/PUdYBsiFfGWSzWZQB1PM5eXc1iRUE8u6fuIQSFXQD5p/kas
 Xxeb+UWbdc2696Md8YZPzkIS1GUFEONcWqHrzDNh0Oaq5zBs0vHiZtpWPnQbdON4pEpBkhf4/oA
 uFA7/d0jCotVKpIvtovp1pHmtvuWo6VRaPCUZeTl6PNKIunr0S5lEYp6AXG/a3wWuYurN7Nc9RP
 Irw8Bp+fCOMDC+bk5BhNP/9QP12pPDgm92Gd+B/LvyH11LVY0XqUdWmSpWQ0nIgGIuXOsbF2V7q
 kZwZcFovE7ZtXlpvg9/KmARcdg+xROmERzzqGBcNmHc2RG01kjCn6FgvDKG3Eef1jMvmA/ABtWY
 I3SkC8aaQQykkmBUhEy3RvdBbA2YqXl6mmx5e+mVymiBoytPApeTN2WC+PsDRYDd2gUl1sGrEXd
 IiVf+1vMAEb2nLJ/KZw==
X-Authority-Analysis: v=2.4 cv=PqcG/AM3 c=1 sm=1 tr=0 ts=6adcf893 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=TCmZHHD8nNTMiv+1QRkMpQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=sNia4u96opvZwPxOjvIA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: v-CS5B01fk52VFjvAo18aZJTB5-2AyTX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MyBTYWx0ZWRfX+KGe5oYOvpEF
 /Hh0ms/MJILtMXeHWrYFjR+Tk3bxp/5EO1ae2NJt3t1rp10B3B0TEWCjxVf/xjb6LeXWugX4mQR
 LbQjjBvSV6m9EP8gzELGg7rpiKaL1aY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
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

Hi Tyler,

On 10/23/2026 11:17 PM, Tyler Baker wrote:
> On Tue, 13 Oct 2026 at 16:35, Aswin Murugan wrote:
>> This series adds support for exiting Gunyah hypervisor and switching to
>> EL2 during early boot on Qualcomm Dragonwing family platforms. This
> On boards that take their memory map from SMEM before relocation
> (VENTUNO Q on the stock boot chain), this hangs U-Boot before the banner
> once it moves to EL2: SCTLR_EL2 comes up with C set and M clear, so
> qcom_smem_init() calls mmu_map_region() before there are any page
> tables. Can those calls check mmu_status() instead of dcache_status()?

This is a separate issue that was already pointed out and discussed as 
part of this series [1] discussion

I would prefer to address it separately rather than expand the scope of 
this series.

[1]: 
https://lore.kernel.org/u-boot/6ce5b9ab-d6b3-47d2-81f9-56b4ee1edc67@oss.qualcomm.com/

Thanks,
Aswin

