Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9BF606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xwUqLRoF;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WqCBQjOR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HMupuHWu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03B2F407BA;
	Thu, 29 Oct 2026 13:33:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UBwGaZGR-hXe; Thu, 29 Oct 2026 13:33:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E2CC5407A2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793280781;
	b=Vyw2u7+HkT/BY6wUNCmZLPleLce0lphSW3KrNrNBNMvxaRYE8rK+SEJOlGqn54cJS0Pu
	 2QLG8XtRLneuv91W/KvDkbbg5pXSX5qaENc36ZYJ4xk0DXlWPyERMdXClO61aoMD3924P
	 wLWEI7AaRr59u5hi7owg/1jM90SbcPJILQ6+r1u7AsEpap0gTihBN5sbmd0DNow+WJtF9
	 0373EyrSpuLAy+6oW6rdMetwLutX7Wv78mNalDM1jR75scey3hbr3DouxwB8DrSp696S9
	 KrY5WuCfEpNBy7tipEZkGSIjE/HhcXHgm7sXUChAydRuafmTqO4+IxQN4ANFy2EgTRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793280781;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=k+yL5QYyHQJWFhsV3P/ymYvWofPw5VM7eZ6KLlOe15I=;
	b=al5BlhQDOm7IvnNxvyYQWwXtw+uOXbpyvK3lZ3Y4HDEXDdeEyVXlfCWGmkJPQPblwSFa
	 XbPjjKFXWyW2O1DRCT8iYunOrJZqx6n6TL/XUgb5PCUrc/t+G2BsN0Z9suaDNZOltzKxd
	 HDP5+I3wkchADUcdXlgnEA8YTrofXYAFM7r4+e2+qK9xJxnnIDRuRzyNDtz4cAFrqq1/z
	 oGRPtganLAXuf663YhD9E05wEOttEFGs//jkl/xh3WjpKQIHnkce41LOldZ6h9NwkN+Hf
	 EZRag7BnhPGfslSVCK8pXZLBjmNgsEKCviVtNdlhT8LlVB4BN8BAJ1Ju6XDxIi9Ng5g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793280781;
	bh=k+yL5QYyHQJWFhsV3P/ymYvWofPw5VM7eZ6KLlOe15I=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xwUqLRoFqRYzIv+s62vZhYHV4eGEzMHQNvnmKuJPMnksFHTqrZDr5PdbSdFwvMMTf
	 1zSm27t0d4sfCt+QaSIjBmMZTm7b9ho6Y0k3SAkeWyHbuYTamz+KPecqWHKEKGBvyF
	 JbcsjjY8WcAW13l3RKOfDCsi8LvRzX6T36m0snDAewZ7CPv6Ql4UJdjkZ6u8n4w8at
	 SRS+erhX+MBs0hhP262/J0cML7R0HvKDDqAJu6srXdlEj6CHxR5gCw8GK6+Z3pmgM1
	 FwCEaZONPREUQq27zKN3QiAPZCkXQsdctIu9HqyVZxp+9Qopl1T4NNyjdYVhUf4M3P
	 JhHYqXJdHL8WA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2CC5407A2;
	Thu, 29 Oct 2026 13:33:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 93E5E120
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 07:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8614A40176
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 07:30:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uBmT0YFsxaOD for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 07:30:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4EB6A40080
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793259028;
 b=VR70ttpqZyiOmsBOti5YbtOavscrRrnyNvKq9bjSj6P/k/NM7kG1z6Eg0Rdwbv7Hb2Tl
 difl594nwbazuCOUc7jUTCQ+bm1Pau2IAyM/vYxQaUgVL4UvpDgH3IpMrAo/8DLymX9e7
 KntHJRifMEFrNBvRg3zdjTdo/CuYT4mTKTceHHu8cwupPQMLDqCRmjMv8WID35kMUrBFL
 EAiQQbvTVZ8dFpRU6PwyPqV05h4a/8cSH9Y2Ufr/im30qidIz67e3iUMel8SlOWmaSmus
 UsXJBBrE8Q7iuTuShJl7mPkLbX48+2kjEWwoQM1DT/jiJt1BlQEUngYsvTOHu5MrBcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793259028;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=k+yL5QYyHQJWFhsV3P/ymYvWofPw5VM7eZ6KLlOe15I=;
 b=CYQjTzAZvzdAyAhIm0QBh3Ely/c49berIGAqACSlyQpe40a6mQSwN3Z2umB92wjESNrF
 fHaivKUzBZVWVzgsvMaoF9Sxq8k74ERyg9pcZ6rW3J6f5wVgkqNXQablr6ArEmo8mboYP
 tstDXIfOoDCdvhPuN5AZnZiW23dONOtwMOdmm0Cjt67ytzM1tBBIoF5ewPezEBqjiTaZK
 aAThz6JEyFw0PyJuwrA67aj/PMFvlSvZgtWry8ngdLGDxgfG0cqbYHzZxtwNF2uW7iou1
 qhwfLbq+y1iUVC7BtjGqqGqvQuo5VxyLpM7wdNHPSoC6nYhL96PRrZN6QTVDsGh+Ulg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=WqCBQjOR; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HMupuHWu; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=kr.sowmiya@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=WqCBQjOR; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HMupuHWu
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4EB6A40080
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 07:30:27 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5Gri72243694
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 07:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=k+yL5QYyHQJ
 WFhsV3P/ymYvWofPw5VM7eZ6KLlOe15I=; b=WqCBQjORuvjH+0iJgEj8FFpQW2G
 5QN/AI0yarHH29mLNJAlPpLLdqXtm/hyKCvsRjyE5Yz1oxZgJ7RD8EOCl61DxEOS
 8df/4oJlg7bpg1hRzkR4C+4GXX4/u2W1KIVgptrIa+WBPNENwYftq9ET+K8wK7Gq
 V8fjNQXIDNBecyPWHzqoFNxOZmpF5KcOzK8qe6On1eifTC2Uu1Scl/D/JeGFXb0R
 rqwMksJr/U31qZ5lVDtpAAA1CBjhb/+vM4vxZpBdWBEVbYzmRzshcBV3RY/sLGr2
 LehHh3/Udhaf8fSdU26cesewVKDM80fCDSOXXTqL3LQ9qsh3o5e2l8ELJYA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5s8js8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 07:30:26 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3692c5b061bso5174365eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793259026; x=1793863826;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k+yL5QYyHQJWFhsV3P/ymYvWofPw5VM7eZ6KLlOe15I=;
 b=HMupuHWuz2E1LfK5zDfhQ3CLo90NLJbMlCbtvMmuo2ZgT2Mg5hYWmRDHPu0+hwdDiR
 CdLGhswKrrL5/2b5Ks/rtkuotEbC2LoRoggsInwFEDh9m0WXDoMhrvmlTkSooIEVyQ1j
 2PZNyWMBDv4CmbZfg31YojNuXIFZypA3pl/CuoEtprOPC+1a+KAxs8iJB1WwAJ0NgZnx
 SAz66Kfnvo/+YhA02Mc7N8bOizdHeWxRiNsXIaPj2KX+m3IVpRtbRWQm+tr0005P4IPg
 hkvgbNe5KMxrPJbgde+um62xHPtTIMRHspekcC5m/YLFPjGmIBXAJ4o0M3z03h1Gdp+/
 HyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793259026; x=1793863826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=k+yL5QYyHQJWFhsV3P/ymYvWofPw5VM7eZ6KLlOe15I=;
 b=IttvN68Ej9F+JxepTRyayB8hqqEYaR32OMOPKrQifoXhFghT1rOA6BUIgb29sN0ryI
 /dI8XNslz5BzPBfO4mdht1A9vMoFog8kneuQ1Wc9o2txjzlyE8TbusaqOTeUtOHa3ObD
 XRw4LR4HHYqBBUOSKzG4qRcfm48lYa9I7gRvoHSKPwqVBp/StSHkedZLHW6t02jSMx5T
 1bA3Bk2unzmlduX3qs3GzGasLPVnym15VXNiFlRahr9D1CWemLoAFZ/iog2XA4XDVtFW
 4LRTPHARzNro2wuiieBm9F8yMdz+j8FpAvuLSPC7VkuTYFjq+Un2W/EFwRJzaHsBN+Hn
 NH4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMUZW9qCaFdtQW4WXK8aqg2MeBzehrK750nbDOLKSs7wThgpeNNqaXTO/rP+N+0LD3Q+TkqvY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJrr4rCOdh8/IdiZxJ9gckl15Cr99MRvwa1tqguslHCcDC/li9F
 kixuAjz/fDrbi0zj4AKYvrV2fF9uqmS67Q8uCtaV7JDSIgTVTJixgKs4HDldRfmnxmo0m9WGhoX
 M8Tu0NE4m3UWVY0P1EhTtS82D7k2wipoauP9nIp4uaQebZDueMPa+5tdrr7j36qmco+es31Y=
X-Gm-Gg: AYBFou3XcLQbihvkw3yKmu3LyXVBlSWgNrl+iXzieRxNj85luWfrhNhikvci9x79+xW
 HlZ0nWJ5TqOViXTMvrNcK95taLi3ApGWpAxtPk2KMYxs33vFyqVz7dkdAlXDHxjG421qkWS+UL9
 /TvQTKIWzz/4PMw0viXZiboXZwh6iX9NiiDn8DoZu1rZvPX2Z/lXCFfhuh3mnSuWyUQLCKi7RcZ
 H3dvkS3opfqQU+OZ7sra8M2XzJm6pUBFk+H1Mvxk0KA5kJDkF8IhN18FJhHUBXhlWLmbKlyjZNK
 d5+1KDohBTsZy3doQj1qjsRa7NYLJszR803GK+tClk9JLjU4PfCNdy0+xUguNGUT1gPAyddyDae
 s3QTybkDX8ZDGqe9FtciQEQy46xKiXdSBq7KqeZpUYs8mxrQidXYVgF8szqHDBoWFflYZIhUFp+
 rvTqBaeJThSTaY3MQIoDLTdGIzbhfiAEi/BX3ZKiWkyUxRYxotiF69fqXx7HxF020PFw==
X-Received: by 2002:a05:693c:8811:10b0:36a:8a6:6916 with SMTP id
 5a478bee46e88-36a203cd278mr6729334eec.18.1793259025083; 
 Thu, 29 Oct 2026 00:30:25 -0700 (PDT)
X-Received: by 2002:a05:693c:8811:10b0:36a:8a6:6916 with SMTP id
 5a478bee46e88-36a203cd278mr6729274eec.18.1793259024147; 
 Thu, 29 Oct 2026 00:30:24 -0700 (PDT)
Received: from hu-ksowmiya-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a2390929asm17579098eec.12.2026.10.29.00.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 00:30:23 -0700 (PDT)
From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 kr.sowmiya@oss.qualcomm.com, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v2 1/1] DDR training: enabled DDR training for Shikra SPL
Date: Thu, 29 Oct 2026 13:00:07 +0530
Message-ID: <20261029073007.385154-2-kr.sowmiya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029073007.385154-1-kr.sowmiya@oss.qualcomm.com>
References: <20261029073007.385154-1-kr.sowmiya@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyOCBTYWx0ZWRfX3tZh0JV4VMKF
 Mu2uPX0+aaUdE2ywBdo6toZEpnS3jRf+aV16OfEUm+WIStezojFmTvd/LoH3IIV2960Sx0CYfvc
 B6UljtVyGhnt8xaXlMerYRlhfmxV9h2ZDdUkTSIYCffLv83qw+ArRgbsFeROM2O4kaPxOltW3Hn
 oOsX1RL/z+PPr5sJd1HNQKzy6zBGA3dkZ6TvMsylN/M9NmDfsMBWCu9cd/EccyCRZw9WSIUB5UM
 kAhfs/cXWQswQJjgcDHwOsr54FTYy3WD4mStde0lw6Wu/lq3c4WZ/SbNrI9LpYk1cqogeCg70dg
 t+NyxjzkK60YMWG/WVtyFsygEPOJzySP5YveY6HvSGbqOS4ZCQ01E0IDDP6ySiHkYiPMXuupeH9
 0Imv/XxUXEncO6ZFNKNqJ1K5z2A9Cw1p/wOWEI3zdrVWG05dq3ZW+Z5thv0qOj/sOeMekxb1bAO
 JrS8XeoHHVE1ZKecsIA==
X-Proofpoint-ORIG-GUID: cMyB9cOh9tZE-YHcHtFHVL0p4vfh58Zg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyOCBTYWx0ZWRfX/s+DOjtZPe8b
 +R6saVcO/pjJZd66Tk9B6SIYtu49IIyGSjtPFyeRgztynlj6Hq02cN4nxwYhirgnnJBH6Je2KX/
 xVtqB/w9OSAToos2t1a7LSFp7Q+wwC4=
X-Proofpoint-GUID: cMyB9cOh9tZE-YHcHtFHVL0p4vfh58Zg
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae2f612 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=k1Jzc5MXYphDByd7_rIA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290028
X-Mailman-Approved-At: Thu, 29 Oct 2026 13:32:54 +0000
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

Add support for:

Reading DDR training data from eMMC during Shikra boot flow and sending it to
QcLIB via interface table.

Saving DDR training data in eMMC when QcLIB performs DDR training and
sends the data via interface table.

Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig              |  66 +++++++++
 arch/arm/mach-snapdragon/board_spl.c          | 126 ++++++++++++++++++
 arch/arm/mach-snapdragon/include/mach/qclib.h |   3 +
 arch/arm/mach-snapdragon/include/mach/spl.h   |   2 +
 board/qualcomm/shikra/spl-shikra.c            |  35 ++++-
 5 files changed, 225 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 9e23d6d8948..92bce79b25c 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -93,6 +93,72 @@ config QCOM_XBL_SEC_ELF
 	  The image is copied to the build output as xbl_sec.elf and embedded
 	  by the platform SPL linker script as a Qualcomm XBL-sec segment.
 
+config QCOM_DDR_TRAINING_SUPPORTED
+	bool "Enable DDR training data save/restore support in SPL"
+	depends on SPL
+	help
+	  Enable support for saving and restoring QCLIB's DDR training data
+	  to/from a dedicated storage partition during the SPL boot flow.
+
+if QCOM_DDR_TRAINING_SUPPORTED
+
+choice
+	prompt "DDR training partition lookup method"
+	default QCOM_DDR_TRAINING_USE_PARTITION_NAME
+	help
+	  Locate the DDR training-data partition on the boot medium either
+	  using partition name or partition type GUID.
+
+config QCOM_DDR_TRAINING_USE_PARTITION_NAME
+	bool "Look up the DDR training partition by GPT partition name"
+	depends on SPL_PARTITIONS
+	help
+	  Locate the DDR training-data partition on the boot medium by its
+	  GPT partition name (CONFIG_QCOM_DDR_TRAINING_PARTITION_NAME).
+
+config QCOM_DDR_TRAINING_USE_PARTITION_GUID
+	bool "Look up the DDR training partition by GPT partition type GUID"
+	depends on SPL_PARTITION_TYPE_GUID
+	help
+	  Locate the DDR training-data partition on the boot medium by its
+	  GPT partition type GUID (CONFIG_QCOM_DDR_TRAINING_PARTITION_GUID).
+
+endchoice
+
+config QCOM_DDR_TRAINING_PARTITION_NAME
+	string "DDR training GPT partition name"
+	depends on QCOM_DDR_TRAINING_USE_PARTITION_NAME
+	default "ddr"
+	help
+	  Name of the GPT partition on the boot medium used to persist DDR
+	  training data across boots. Locates the DDR training-data
+	  partition by GPT partition name.
+
+config QCOM_DDR_TRAINING_PARTITION_GUID
+	string "DDR training GPT partition type GUID"
+	depends on QCOM_DDR_TRAINING_USE_PARTITION_GUID
+	help
+	  GPT partition type GUID identifying the partition on the boot
+	  medium used to persist DDR training data across boots. Locates
+	  the DDR training-data partition by GPT partition type GUID.
+
+config QCOM_SPL_BOOTIMEM_DDR_TRAINING_BASE
+	hex "IMEM address to stage DDR training data at"
+	default 0x0c368000
+	help
+	  Address within BOOTIMEM where DDR training data is staged, to be
+	  consumed/produced by QCLIB via the interface table.
+
+config QCOM_SPL_BOOTIMEM_DDR_TRAINING_SIZE
+	hex "Maximum number of bytes to stage for DDR training data"
+	default 0x8000
+	help
+	  Maximum number of bytes read from/written to the DDR training
+	  partition and staged at
+	  CONFIG_QCOM_SPL_BOOTIMEM_DDR_TRAINING_BASE.
+
+endif # QCOM_DDR_TRAINING_SUPPORTED
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional
diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 31a06b1e002..19632948077 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -77,6 +77,132 @@ int qcom_spl_get_boot_blk_desc(struct blk_desc **descp)
 	return 0;
 }
 
+/**
+ * qcom_spl_ddr_training_restore() - Restore the DDR training data from the boot
+ * medium.
+ *
+ * This function reads the boot medium for DDR training data which gets saved
+ * in IMEM location.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_ddr_training_restore(void)
+{
+	struct blk_desc *desc;
+	struct disk_partition info;
+	lbaint_t blocks;
+	int ret;
+	void *blk_buf = NULL;
+
+	ret = qcom_spl_get_boot_blk_desc(&desc);
+	if (ret) {
+		pr_debug("DDR training: boot device not supported (%d)\n", ret);
+		return ret;
+	}
+
+#if defined(CONFIG_QCOM_DDR_TRAINING_USE_PARTITION_NAME)
+	ret = part_get_info_by_name(desc, CONFIG_QCOM_DDR_TRAINING_PARTITION_NAME,
+				    &info);
+#elif defined(CONFIG_QCOM_DDR_TRAINING_USE_PARTITION_GUID)
+	ret = part_get_info_by_type_guid(desc, CONFIG_QCOM_DDR_TRAINING_PARTITION_GUID,
+					 &info);
+#else
+	ret = -EINVAL;
+#endif
+	if (ret < 0) {
+		pr_debug("DDR training: partition not found (%d)\n", ret);
+		return ret;
+	}
+
+	blocks = DIV_ROUND_UP(CONFIG_QCOM_SPL_BOOTIMEM_DDR_TRAINING_SIZE,
+			      info.blksz);
+	if (blocks > info.size)
+		blocks = info.size;
+
+	{
+		blk_buf = malloc_cache_aligned(blocks * info.blksz);
+
+		if (!blk_buf) {
+			return -ENOMEM;
+		}
+
+		size_t read_size = blocks * info.blksz;
+		size_t copy_size = min_t(size_t, CONFIG_QCOM_SPL_BOOTIMEM_DDR_TRAINING_SIZE,
+					 read_size);
+
+		if (blk_dread(desc, info.start, blocks,
+			     (void *)blk_buf) != blocks) {
+			pr_err("DDR training: failed to read partition '%s'\n",
+			       CONFIG_QCOM_DDR_TRAINING_PARTITION_NAME);
+			free(blk_buf);
+			return -EIO;
+		}
+
+		memcpy((u8 *)CONFIG_QCOM_SPL_BOOTIMEM_DDR_TRAINING_BASE, blk_buf, copy_size);
+		free(blk_buf);
+	}
+
+	return 0;
+}
+
+/**
+ * qcom_spl_ddr_training_save() - Persist DDR training data QCLIB asked to
+ * save.
+ * @address:	Address of the blob to save (as updated by QCLIB on return).
+ * @size:	Size of the blob to save, in bytes.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_ddr_training_save(u64 address, u32 size)
+{
+	struct blk_desc *desc;
+	struct disk_partition info;
+	lbaint_t blocks;
+	int ret;
+
+	if (!address || !size) {
+		pr_err("DDR training: QCLIB requested save with no data\n");
+		return -EINVAL;
+	}
+
+	ret = qcom_spl_get_boot_blk_desc(&desc);
+	if (ret) {
+		pr_err("DDR training: boot device not supported for save (%d)\n",
+		       ret);
+		return ret;
+	}
+
+#if defined(CONFIG_QCOM_DDR_TRAINING_USE_PARTITION_NAME)
+	ret = part_get_info_by_name(desc, CONFIG_QCOM_DDR_TRAINING_PARTITION_NAME,
+				    &info);
+#elif defined(CONFIG_QCOM_DDR_TRAINING_USE_PARTITION_GUID)
+	ret = part_get_info_by_type_guid(desc, CONFIG_QCOM_DDR_TRAINING_PARTITION_GUID,
+					 &info);
+#else
+	ret = -EINVAL;
+#endif
+	if (ret < 0) {
+		pr_err("DDR training: partition not found for save (%d)\n", ret);
+		return ret;
+	}
+
+	blocks = DIV_ROUND_UP(size, info.blksz);
+	if (blocks > info.size) {
+		pr_err("DDR training: data (%u bytes) too large for partition\n",
+		       size);
+		return -ENOSPC;
+	}
+
+	if (blk_dwrite(desc, info.start, blocks,
+		      (void *)(uintptr_t)address) != blocks) {
+		pr_err("DDR training: failed to write partition '%s'\n",
+		       CONFIG_QCOM_DDR_TRAINING_PARTITION_NAME);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 #if IS_ENABLED(CONFIG_SPL_SMEM)
 /**
  * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
diff --git a/arch/arm/mach-snapdragon/include/mach/qclib.h b/arch/arm/mach-snapdragon/include/mach/qclib.h
index 10865b03ea1..a643f3240c5 100644
--- a/arch/arm/mach-snapdragon/include/mach/qclib.h
+++ b/arch/arm/mach-snapdragon/include/mach/qclib.h
@@ -15,6 +15,9 @@
 /* interface_table.global_attributes bits */
 #define QCLIB_GA_ENABLE_UART_LOGGING	BIT(0)
 
+/* interface_table per entry attribute bit */
+#define QCLIB_ATTR_SAVE_TO_STORAGE		BIT(0)
+
 /**
  * struct interface_table_entry - Meta data for blobs in QCLIB interface
  * @entry_name:	Name of the data blob (e.g., "dcb_settings").
diff --git a/arch/arm/mach-snapdragon/include/mach/spl.h b/arch/arm/mach-snapdragon/include/mach/spl.h
index a32a85c48fd..868e19cfcd7 100644
--- a/arch/arm/mach-snapdragon/include/mach/spl.h
+++ b/arch/arm/mach-snapdragon/include/mach/spl.h
@@ -12,5 +12,7 @@ void qcom_spl_malloc_init_f(void);
 int qcom_spl_loader_pre_ddr(u8 boot_device);
 void qcom_spl_error_handler(void *arg);
 int qcom_spl_get_boot_blk_desc(struct blk_desc **descp);
+int qcom_spl_ddr_training_restore(void);
+int qcom_spl_ddr_training_save(u64 address, u32 size);
 
 #endif /* __SPL_H__ */
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index c2a5d2d692b..49026209be1 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -119,8 +119,6 @@ int arm_reserve_mmu(void)
 #define SHIKRA_DCB_LP5			"dcb_lp5"
 #define SHIKRA_ECC			"ecc"
 
-#define SHIKRA_DDR_TRAINING_DATA_ADDR	0x0c368000
-#define SHIKRA_DDR_TRAINING_DATA_SIZE	0x8000
 #define SHIKRA_PMIC_COCOS_SIZE		0xbc00
 #define SHIKRA_PMIC_WAILUA_SIZE	0x6000
 #define SHIKRA_DCB_LP4_SIZE		0x4800
@@ -357,11 +355,14 @@ int qcom_spl_soc_qclib_override(struct interface_table *table,
 			return ret;
 	}
 
-	ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_TRAINING_DATA,
-				    SHIKRA_DDR_TRAINING_DATA_ADDR,
-				    SHIKRA_DDR_TRAINING_DATA_SIZE);
-	if (ret)
-		return ret;
+	if (IS_ENABLED(CONFIG_QCOM_DDR_TRAINING_SUPPORTED)) {
+		ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_TRAINING_DATA,
+					    CONFIG_QCOM_SPL_BOOTIMEM_DDR_TRAINING_BASE,
+					    CONFIG_QCOM_SPL_BOOTIMEM_DDR_TRAINING_SIZE);
+		if (ret)
+			return ret;
+	}
+
 	ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_INFORMATION, 0, 0);
 	if (ret)
 		return ret;
@@ -383,7 +384,11 @@ int qcom_spl_soc_pre_qclib_routine(void)
 {
 	qcom_spl_soc_shrm_reset();
 
+	if (IS_ENABLED(CONFIG_QCOM_DDR_TRAINING_SUPPORTED))
+		return qcom_spl_ddr_training_restore();
+
 	return 0;
+
 }
 
 void qcom_spl_soc_rpm_reset(void)
@@ -417,6 +422,22 @@ int qcom_spl_soc_post_qclib_routine(struct interface_table *table)
 		return ret;
 
 	qclib_set_ddr_sr_exit_address(entry.address);
+
+	if (IS_ENABLED(CONFIG_QCOM_DDR_TRAINING_SUPPORTED)) {
+		ret = qcom_spl_get_iftbl_entry_by_name(table, SHIKRA_DDR_TRAINING_DATA,
+						       &entry);
+		if (ret)
+			return ret;
+
+		if (entry.attributes & QCLIB_ATTR_SAVE_TO_STORAGE) {
+			ret = qcom_spl_ddr_training_save(entry.address, entry.size);
+			if (ret) {
+				pr_err("DDR training: save failed (%d)\n", ret);
+				return ret;
+			}
+		}
+	}
+
 	return 0;
 }
 
-- 
2.43.0

