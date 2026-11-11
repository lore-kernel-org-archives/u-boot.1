Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA4B606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rkJ4URqU;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YUn/IJBG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kAqnHMMa
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 292D340B0B;
	Wed, 11 Nov 2026 11:20:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G5UVdqUao439; Wed, 11 Nov 2026 11:20:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6272340B11
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794396037;
	b=PbY4XcADTk5uZNhMUhaYmzxrrxIDdMfZwpRZzthf/RSnoUWmOg5DZl2mQzJv6HSnieh0
	 vqribgcHPD+GBHxGT2si+NY58OIZdZtG1z4ddyY3febn2O2OD6hzt/Xgo4/N/k+cJeIS4
	 MJbdEAzNn++h4R94qBbRbK7ogI+E30QDzajZPMjVwFw5XIlW5CFAaf9C5HYza4/vtAqZU
	 nJRNwO3neQo9E8xhMk96qCedYR4jDXTFN/4C/h7agVL1HZu8h73Drg1CvH94Ouc4q1ZOc
	 XeEydV7WVVHFBbBd/BxnqL/04BYIHP7iwTAywCemeCAYQ3GZvGboWm0xgDCJShwGs0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794396037;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rAgTW5dRCZOWZP3vDtPpcpgsCWur9pAUm339WLIne4s=;
	b=msbLSTCeMMqJp/iaWNKOry9qsjMoOdx18gXmOTc1P70rqVlragEMDbBnViWAEE2oy0A0
	 5h6p29lkMgO5fg1Df7enO6K0jk7p7MK7XJ7M7OgLCOIwRlHfNatOPj0mrfc1ZPzj7oXoa
	 L7B/wUdWa/lDWQJUOp2D0F+rUT+dSHXvHeAK2z7US+2eyvAbD9Vw2LMoxfbV4dXa4xCRY
	 rHHE1zxaM3IqkP0LBLtRj56ED9opqqi3VKFhEWS+ZF3aNzW6jwHrVDrf80Klm16Nihcig
	 UtdzmjLTeDFc6OVtfSI11Y24jLcz4kA7l4mqI6aoCu08C1Lka/CiCP2X8PCoAaOWVvw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794396037;
	bh=rAgTW5dRCZOWZP3vDtPpcpgsCWur9pAUm339WLIne4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rkJ4URqUCu/DMfVbDOTd1+SOCw1OcKRxyoFvOojXgePa+wI2D8wZPZTeBaSgQuqKM
	 6v61ooe6ZTNxou36z+Bn4zkUC5nGrbzJghRstEPM9PSFgsAjM/Eos+TiJskYZuJz/w
	 e0Wq4W3zpoZ9hGWlsFh4rHzs0cpG0Gtlk/4ZcSKv0tzCCCDx+x6WDM6zX8NtjD4ERu
	 muuFbcoBsI5gd8akHgH9qM1OE6j+H9eNCWjw5KvklmCZJZ6RIqXznC2krM57iUs0uu
	 BEBbn+7V574D2pGXVyfxUwNpuqUtjTuLmw2UAVN+2Qt438Eoxniwf/9z8Wr08nISU2
	 QIsn4CNlGV2qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6272340B11;
	Wed, 11 Nov 2026 11:20:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D7C8917CB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BFAD381312
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:20:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6G-bhsmM8s23 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 11:20:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DF034812AF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=YUn/IJBG; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kAqnHMMa
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF034812AF
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:20:33 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABAp7Ba1052697
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rAgTW5dRCZOWZP3vDtPpcpgs
 CWur9pAUm339WLIne4s=; b=YUn/IJBGuOdeARqnkO4wzVBIfgwcj72xbxIrLBvL
 VT/Zr79XqTNz211khtYtp/cC3HRa7yia5h0gkXSE80wkklXjB+FO67cMF/nWS8QU
 jVTxNKXnjdD3OQPgqXwsO1a3h2xpA/oQ6CdE8eREe0zxpglgMLYbiESRexlrAVDz
 ytelkdxgjK0CY0O2tSkrbMqtKPUCeorW5ZHPD9byORtJHyOooidcH3/AabyUvK5t
 OecK3YJNVyrrY96k2mvfYKxHDnFn9NYvh9yzMwGOiGF29QQCb/W4sfpYgTL0PYcS
 JclRq9EyGDf9ha6s+ZEEYFYS8Nieyx5yNoKUP8ztqG0XCA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdrh2ak7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:20:31 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1aa0fb7f157so4929708c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 03:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794396031; x=1795000831;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rAgTW5dRCZOWZP3vDtPpcpgsCWur9pAUm339WLIne4s=;
 b=kAqnHMMaKDRPVlD1vetAf24wVaijHNxFhrwZzuF8CAJM/XjaRs4nVOa1IJvTYCP5i4
 0vX9uNmxsxjNCG7uG1aEqB62UVn9ivRyVGaCAuH/e3FN8csXYGbPogVJWgOT/UVshVOE
 gHcbuc0slp5Cdf+LBCj8WEd4s7p7wg6HVgI3fqjhtuiiNtfFZZG47iJai3uXyzDCwang
 pY/MPTonlphscUXdNJzNnmBS6kCqmNsIRwhnmNmfDuTjtTzpBR16xwhHM1YYeUF97XjA
 tvpO7YZfP7Fhxu2lKZ8zih3d5FpEcJqtipqiUzsULAvIBBwW3oiU7C+hCBhR++qQjiBM
 EeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794396031; x=1795000831;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rAgTW5dRCZOWZP3vDtPpcpgsCWur9pAUm339WLIne4s=;
 b=2gHaUmQ0fVFRPLHqdaS2JoOBX49gjG+28qu1+J6ARAYC3agk+WfpybZ71QjaBBIC6s
 u8AcbXvKh4zxMvi4RCamyBOrnvwfixXUF5/wvWHHXTqq7eWIXzcdZ/56wsnpWhh1ulH3
 YYZgL7TYyRbYYNfph++8bg1I+MFQ02oelWrjJ9YRByWSmnTEGzhr0pOS4U98vnb24Z1f
 TJsiAMBTJQTfrr4YfujK/J3t4p00mT9bS7qB24XGQtsxn4ZYTDhB4nN0wgN8W3ZhGYPk
 zJhF/dl5Cr/w+5xCIdG0nNqHN4ZMSFK0cmyDgdVEpHyZfhhA55r2BFuU3fyGFZ82hiG4
 gD1w==
X-Forwarded-Encrypted: i=1;
 AL+hErFj9sX1gagK66gBz7BnLgIhorrCUvCF1qIvM+P+pTkiI6w3UzT2ImQD+wjX4m5t00q3o0hERvM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9+dan5hxw0v77IYWB5uEKv+xkOV9Gn4TLbTLv2B47/fxAYKhLu
 yaKaN3x9k2HQcYjn0pDnPvTXA9LCvFzZDrjKpFn4BJn+Dp4TqAk15xuCmsmJsK51ryxKzZzBupM
 zgJoMBi4zf3aZDyCtxiEBTKOXkXkuu0LbsJywoW8QxsLfSOe6dU5hXegcEGGDvAuoy4U5UQYF7+
 WRYyw=
X-Gm-Gg: AYBFou1/13OYwI/oyilvkxzjGttD3hjizbsl7BN/D0BbcC3Ek2IkbMl9tBSkQ2zraz3
 4Y2xmD6DQicjPNXoCtoA89eFXSAoc2yAiJMKfylu8KABN92USdx3MIFbWjbl+egAfajhipEGrKO
 c0rK/UlmVoh70F/BCtsT/jHaDQ73ym/FUWxpvklknBuiRI0ohK9taU7V5SEaT3h/9uDJsDar3b0
 ZCPT1LIShxybmiyk4FL8kOMX0Q+RZ9YGsuFqvmTgnGP9uQUEkmPgJYzY4EMyJ7GgC4jR7JnuqHY
 lCo8WUbUv4+mfONRdnwojIO/hlnB3l2MGWPIcf1rLBbrzrr1hLvTP9u1tBvUfHVPzt2DQ1ZNKRO
 mq0Y2OL6E2D/ICzj7xG4PprSoT1if5HSxVrmM4CA6kH8QSfPJ9lZPoICxMK0UZ9HkFjDF13yXM8
 DNYeWU5u9UG3vUPBN5gOEH+SJsY//JdWKCpTiGw1MqyUXhIDskB2Rgiki+EADl3JOZeMfv5cagk
 lPihfQ=
X-Received: by 2002:a05:7022:ec02:b0:1af:16c4:d06b with SMTP id
 a92af1059eb24-1b3c02f36ebmr2266227c88.10.1794396030966; 
 Wed, 11 Nov 2026 03:20:30 -0800 (PST)
X-Received: by 2002:a05:7022:ec02:b0:1af:16c4:d06b with SMTP id
 a92af1059eb24-1b3c02f36ebmr2266186c88.10.1794396030237; 
 Wed, 11 Nov 2026 03:20:30 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5b2fc14sm14691648c88.12.2026.11.11.03.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 03:20:29 -0800 (PST)
Date: Wed, 11 Nov 2026 16:50:18 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>
Subject: Re: [PATCH RESEND v10 03/15] mach-snapdragon: Add PBL shared data
 defines
Message-ID: <avRPctqRvx2jBT1b@hu-varada-blr.qualcomm.com>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
 <20261102-spl-v10-3-224d421c6201@oss.qualcomm.com>
 <20261102162555.GW3309461@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102162555.GW3309461@bill-the-cat>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0NSBTYWx0ZWRfX1T0adizcG4Ot
 TIt2/FrfdpYkx/A+ONUEdFZcve3i6j0G9ZXyGgsW9NxQ/4GnVe3Q9fY/lohOolBijPbh8RhK9L1
 PnQxvR2B3/kJ1WXQ+JKfv+U3y2rLtyA=
X-Authority-Analysis: v=2.4 cv=PoQG/AM3 c=1 sm=1 tr=0 ts=6af44f7f cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=W7Xe9uuhWr1VwtNXXhgA:9 a=CjuIK1q_8ugA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: L0H9s6MdzHa_6mR0AnGYDF-TCLlUGtk4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0NSBTYWx0ZWRfX2gyWaENFJlGz
 n+egkfcG2oql4W5F2y/WRF9rN6UO/ksSTRLm8Vbg62DoMIbAxOESmrF129DMqCBQZ6SFRH2qPtH
 NOgDmAGbw0qEgKoSBjGqPQ5StIfj3V8t9ZA6leS46KfBFnGvAX/gJQ7i+elmfPnY3nlXkhzRBGg
 TWYOtauK/RlDi9OBFUkPetfTeQUXydbcp9y288LimSpc0UOOzeawJo7BAETKB6g+koX3MWoSkbQ
 Iy46Zqw140BSu5bURKXND3KjW51ebPFA/c82SfUnsxMdnfaQ4YhzR4D4YEFEdRm6kV7pz8ma77l
 5f30vxUVnutMwz3jCGXMRObwVO0TqSx4qfYw9Kpq6VrDnB1V5ooDZhh5f6J2QYGUlMYRZbSH6+A
 nuAFLWVMJ7EyQJoFfBUiAURwbeFiEv9LL1K4sjF8+At5T6eDvmzgmPOCt/vlyHRETJSkcApxD72
 wvQkm0QxCAb/LmKa9jA==
X-Proofpoint-ORIG-GUID: L0H9s6MdzHa_6mR0AnGYDF-TCLlUGtk4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110045
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 10:25:55AM -0600, Tom Rini wrote:
> On Mon, Nov 02, 2026 at 11:18:35AM +0530, Varadarajan Narayanan wrote:
>
> > Add structure and enum definitions to be able to parse the information
> > that is passed from PBL. This will be used to identify the boot medium.
> >
> > Since the PBL shared data defines are private, move spl_boot_device() from
> > board_spl.c to pbl-shared-data.c to parse the shared data and identify the
> > boot medium
> >
> > Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > ---
> >  arch/arm/mach-snapdragon/Makefile          |   1 +
> >  arch/arm/mach-snapdragon/board_spl.c       |   9 +--
> >  arch/arm/mach-snapdragon/pbl-shared-data.c | 125 +++++++++++++++++++++++++++++
> >  3 files changed, 127 insertions(+), 8 deletions(-)
>
> And this "PBL" doesn't / can't speak some existing format to pass this
> information along?

Yes. PBL is the boot-rom...

Thanks
Varada
