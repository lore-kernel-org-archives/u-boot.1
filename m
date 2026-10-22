Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CC1606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HuxcX6b1;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l53WmJfT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jFcILCF7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42A38608D5;
	Thu, 22 Oct 2026 22:00:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UOHIBzwyjW6l; Thu, 22 Oct 2026 22:00:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6BEA2608C9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792706435;
	b=J7bOlOtS/sNzVw/8g10NrTBKKbmPMgMCE69RQ+TCLyI91BCokL5wUP452WgCOIR//Gq/
	 MEHbeIEzRMRlxdhJSCH5LdhgCxIsQqlpI/LvoG6locxwobBGxUUyE0j4Zva17CzmXCsG+
	 635tuLomEnP0H3M8pX2xOtbINmFVM0AkhS4KRQXM23tSfqAHJKOg4964CouZFTRqgj5D2
	 1gdL35rtgQnYuMZ9IkFdJUVgvfPgkxbXAhZpqOfCYFtD7hprIK+jb0OpJ2HAmYRL7pBDL
	 Tp5B0iLTC4fFbK8TYxnRBi6buH5yuCw1Ov5zUaFFh2hLTMvn7zfNBdSYpkNk0sgsptQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792706435;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VsMEThZcZmcjl2AVrmEmzwOFDEd3Hx16MWesAliysAk=;
	b=oeig+XLzuANWLlUEXPXoNV4K4Wcfn4omisOwbWWJmd2zGD8qzltbjSqtkUFUlLrI77z7
	 waTzKPw1VtWNs2y4iku52TjWHaLCs4vsWxGsT7EzrSCCRcjATPx6QwHJrzor53auyHSgP
	 S9K7W8BEl13R2VZrTM4Nx1CG6L1hhHOaxr/n6cGi724teOGYDnzPVZohrjtQTDVWjij3C
	 BhK0bHpy/MQWlpiziW43iyFqgGm3iGKz2OsrSiQRIBrKyFaOY5JXallK/jDxog6egrh7u
	 0/Z+78hHZvXIFBxGOaVyokRLeb43d9AFqHaipaNDNJILbMAf//frfB3VK3PgAVNPL1g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l53WmJfT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jFcILCF7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792706435;
	bh=VsMEThZcZmcjl2AVrmEmzwOFDEd3Hx16MWesAliysAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HuxcX6b12QHbOzNPSej8K6nc2qJ5wOuhf/S+okiOMc7C8hk3UbEDtTgDElbHBZ9Xe
	 sMirLVUWWumVleO5lAaEhtpPUYvZrWTFWEd0u6vBf9uGbmTCxv3VMqyJlOOCCSnN7L
	 sPCuV6Djl4AjsWgdMjHQHH71/H8MFDtR5cfoxK3oyZTNtZ4HFHoWeY5N2FqdO7jDfa
	 uu66Hf9yA93l+yR4wULeWC3U33BMuU3ZLK3+21c7N85IFS48YeX6s9YCfDOTPCkqTB
	 Ry5lBqnXjTC55PiBdEw0aWtrlZ1nHP3UeSjnJtien+1rf27vjgph9p0SWPL/Rf+zLo
	 FKLbPYMbG8nrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BEA2608C9;
	Thu, 22 Oct 2026 22:00:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 57B183A7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D58F608AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UNrdm8oYy8kb for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 22:00:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4540C608AA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792706433;
 b=GvbjPaYaEBwzzfzndnwtvuNhDZCt2e50ODliU2kQM1VQCmhOu1CE851MMzVW6PVdnJ1L
 HzAUwOkuYBNBNC7nGsTqmi675+gqLYR9egUA6v75P8deNMEImZxtCfSU367aR/ojh0QlA
 zNL434z2tj83FCNHZNG/cLE7B78cAcy1BzLjnmXJj9FGFDOrG5vKtBa6gxxdHq/Tpxpug
 Q++59+fdsyLAoAD92KqSiNhv2yDtMZ+odWz1NlGj6w9SA2bZQVb8aYVEb79idUDN4EFqY
 XL7loSCjmvo61UqHjRVyv6YfoKUfUkAIKmFjBtCp9d7NwNabHuqX+LmSla1zfBBxBBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792706433;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=VsMEThZcZmcjl2AVrmEmzwOFDEd3Hx16MWesAliysAk=;
 b=sqN3QjiVqchvh2mXYAP3ScV9appebIwkCOuUMiO1GvVI63OY/yhaAYX+BpcKum2wYhw7
 djh4OYb3SEPFX3dpLdnIatUjNJChX9yXwCeYcMLAGzPp/1EWpu7P6CqrokaVdlBNbbU5S
 OM9UQ4Xc5gdJJfyp90mbE+N/hSU28BMWWy7xHJROebmZe7obCL4lAYDp1BqslMEX5ghLI
 BdC5xhVpblYAVKwoKMBCJ9asAnGfsOI8Yvi4HiBmnCIzXNhT55lsTeQnAw0WP34I/COwk
 kcssrQrITWgQY5csA0jgH7lHM7KtW9PJmpD9MB07XV2A64fL86GvbRzA3JJpWnPdnmQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=l53WmJfT; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jFcILCF7; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=l53WmJfT; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jFcILCF7
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4540C608AA
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:32 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MKunnH792146
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VsMEThZcZmcjl2AVrmEmzwOFDEd3Hx16MWesAliysAk=; b=l53WmJfTtV80eBuN
 Zx9fC6MmMy8kFPRD63mw3lHXosS1LBZyGNLYd/fnIUUeg1gukq8qCbieTQdTkySg
 TkRpVggi8jyJvArHl7FKyKaDyV3a+h1AXCVwv1MmLEX+nC/2C0LR7lL3Ec5nl1jl
 HmJKWabTmvKvbmk2bLTb1RRs12r5KmCJP/WwmAPgDI6aLdpxpSh0AC2e5/osYsRD
 3ovmxT3dVwk8cbMlAKJZS1QeB5vi30fC2maR8LQSpfYyKmKMGgVOjINrCPllnyZu
 FKOeZ2OWw4v0CEYh4OJxqNHvzSkDoYeA4FQu4+o4WoKogAvb+GwPKAu4S0MhP939
 awvf9w==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsyk863r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:32 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8b0c6e7151cso5994787b3.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 15:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706431; x=1793311231;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VsMEThZcZmcjl2AVrmEmzwOFDEd3Hx16MWesAliysAk=;
 b=jFcILCF739jQP1GhGqKf6Iaaa+GD478GdvZJw4C3B9lKEF8Nh2gJk7t4nn65KZEYay
 H1sxHGM6CTStMKGeljT3Un0VVOP1RdOoZ+BMyuEyoWFo4ZGqw9KCPpztWux+UXc4hhwv
 coKUz20zIJVn25T+IeSrZ9iuoFDW5Bs2z8C4Q/V8LTuiD4YNBrqDYlWBT4EAn+TIlwLp
 jvu+RvWdNjOlKfUDDdLMFyimLB0T/LDbv9U2f7082mSVesvkGDDyFXJUMFkeBghh3Ldz
 lJA+D1k21lXbbNDuDQDwAuZLT9xzbYsgA4411m0+R2jPPLgUY+3N97N9Dgh37LzOpGdz
 +QyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706431; x=1793311231;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VsMEThZcZmcjl2AVrmEmzwOFDEd3Hx16MWesAliysAk=;
 b=dRQsUGECbXJuWqD/3wWLyJXVTOwgrq1puuh62yvMra2oduEs1Yd9UAwVYKSjkWJTG7
 c6UmqRRrHT3WpEOou1vQvs7I+4wO0RY29BtLD1In5cFlft+SRtX1qPTSaVKLOgHmZVAM
 aRbhBv2Lj7meLD71U0D+zj6GIZFSBimDt/vDbIs/Xsr9ahgKhaJwSQeF9Z+ywFrNz/hl
 pxFVH48/XEMaYkhU5NyUarpVkDkjr1UAci0gnxtb1F5rUWFALb476ZcClNOMgQFoCbJo
 H9DrS8NRB9WbcO30rc2xYGo6Zbrp2+iNbnXSmJLgxdlnEY04BzzJI2sXoUAdSh9MwNx1
 JRRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzULIfGBg8n8a1az55aorTZwwl+E3Rm3AsgO85tProU07aeDQBuY8YCltUdeBYg41oC6RzY/pg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL5TAjHds9ioa9FJS+VspwlATK4wLA15hy4Pm/n6wvgcVmviP7e
 cJP8ProNB17KFTNRY0AcBLIAbK18MDUhdJ/wcY2cPEhia0y6gD7i+3l/YGPFvtCARWHZTuctjEW
 uy5UEQ1ueX+pGf2FCKW85gLPvYkAlwdrHhVy04rWG2HHCK0Y20UVOsAQLsJiwhWQqSDiig4w=
X-Gm-Gg: AYBFou1rbcZO/h8i4K+JceTbugC4+bDfJzBrc+be4ZxLu+GNnqdGpG6ZXTSdZ1uoD7C
 KeBm3YyTTXxoC1AktLGcaXFnZkYtbXF7HKC6T3XjEEX1OPSeoJJnrQus9etxAW81FbozVK586nG
 qIK8WW6RMlQRTg/BqjVcTB7aLD9I8nDzfkonUGKMJ7zsDEj0Poeoj6rE64pIKEHCSpQhOxUq6lB
 4ZCU2gCGhC0udtjG2Xc0NR3iKshmEJQp/PwRfgzdbxT+oTywCRozVTs7OSC5hDEhBxABBVT17n0
 rQFJ9HVSr3FTRxEdZPuJPJBlCSMFrxDhxS4lqbqcOuFm0BNJZsRpztQD2yUkdSP1jLBWEjlpnjS
 YSs0Jrehf4z6hc0OaUj6bfIi/HJZIV6pKEgHTvKDSF02tJD703KSu6qLy+qZ1
X-Received: by 2002:a05:690c:a201:10b0:8af:e4ee:a915 with SMTP id
 00721157ae682-8b157e410d4mr1900757b3.44.1792706431289; 
 Thu, 22 Oct 2026 15:00:31 -0700 (PDT)
X-Received: by 2002:a05:690c:a201:10b0:8af:e4ee:a915 with SMTP id
 00721157ae682-8b157e410d4mr1900587b3.44.1792706430701; 
 Thu, 22 Oct 2026 15:00:30 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b156156d27sm4713207b3.26.2026.10.22.15.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 15:00:30 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 William Bright <william.bright@imd-tec.com>
Subject: Re: [PATCH v4 1/5] clk: qcom: Add shared RPMH clock driver for
 SM8550/SM8650/SA8775P
Date: Thu, 22 Oct 2026 18:00:27 -0400
Message-ID: <20261022220027.784323-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021-b4-monaco-v4-1-c90f0c01d312@oss.qualcomm.com>
References: <20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com>
 <20261021-b4-monaco-v4-1-c90f0c01d312@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX0C7FmBmPKPqn
 r8Wlnr53qUEqEu7vjn7U7AknhOKVGdDfB3srf3a6DWgkAsCXtjR7x5olkUE0GUtbsTQ4NxC7PVn
 gq+9BJpCvfOcnHDx6nJXwn4+h8u7cOv0BYhR0E+maF8798RA5r1OHSy55VQiB5fRiakzpO/GXou
 cxxDUJrqroN067G/WENS52nRb56P17pDfCqGBhBXFTl+1Dh6bH+TGz/JsNSwLcU1j1qqQt7MIDO
 WCldCDbDysj8JYdZyfaSVLtXJS1yneiJVxnsodCDeMj6RO6co1hBpx7TBPFx0oINABGzWnl/DKv
 hUltndlN2NM8+YzbVlgS0RwAOFZWn1OlrdxOgIhukGxT/jyVAvE+XOU70IpQYdlH0L/6w2Oq2QV
 1ZONrsux2i185errgc74ZytJKgQ+CMgvp7Xn1o2dBHgdxM5/B1VmiD+qeCzsjV9EGfqR4kdO05j
 LLL9kM6eMykIHkPXGXQ==
X-Proofpoint-ORIG-GUID: fB2iGRm3Skw4LZfyZ2HcDKOfP_q40uyq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXyaMKtBXltYOV
 Jd73Pct7wqMMikelGzE3/pSwV3JGg29R+3D2LY1bRFMJgT93ke/D986NM4xbBuTN+8m/0sOv+14
 tEipy2UYR+ODgbquDKkpQFmt5DINgZM=
X-Proofpoint-GUID: fB2iGRm3Skw4LZfyZ2HcDKOfP_q40uyq
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6ada8780 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=IgeaQt2eEsHdHqljjyMA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 12:13, Balaji Selvanathan wrote:
[...]
>  config CLK_QCOM_SA8775P
>  	bool "Qualcomm SA8775 GCC"
>  	select CLK_QCOM
> +	select CLK_QCOM_RPMH

CLK_QCOM_QCS8300 needs this too. monaco uses the sa8775p rpmhcc
compatible, which is gone from clk-stub now.

clock-milos.c has the same stub, fold it in here.
