Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1293A606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wwHWeA2+;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kxULPHta;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TFKI8eVE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9D48405B8;
	Mon,  2 Nov 2026 05:49:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QX3K1CiBrKkr; Mon,  2 Nov 2026 05:49:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1A3C7405F0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598590;
	b=eFiABOnT+gd6cvIV1IWsYjK/RZPN8Dw1GHN0SCe566FGf4h3UyWBWnJC40FjrDAhab2e
	 30yPiZKjkeqrxZK1B0oRZFOJciWy5RmAi2KmzhbUyL0CeS4FxT3KRegnV+tL6fiPEuL7X
	 Bso96q5BZm+xYdVR5GEttaIWla8ntToK6B86zn20EBzyJNuRVNOz8TLrAt4LBvAD7fYuP
	 Pl4yQiOtYDeKj0K7hsAmnRT/9ME+912gRHuQ91XoQKtvhIpE5YhRlTk7T4iGcidkXlLVK
	 SV3WwRQWuA16MkzshS5S3G+QJfWvl2arIAxUBYDCOQkaOSTB2qJ+e2AxYyN8JfnEy8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598590;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=s2CUow/2i2KRACRml37yePvwISBZUSh36chFrvUzLyw=;
	b=NEUmQo6xjw8nfOAJBCCyE8qgiQ22vcQdx2507B95H4kV3VRaJEMnW2tL+es0rev4RE8s
	 IgEQBV9OB+CA0zsL5IcPTfl59FfVsbk8IKOLAais712u8Y/ZLT5NJBne8/SWalf0k4Cev
	 14BCJtsJM5XbpAJDf2G/IVNZIylNt5UZLdV1ZhtSpeOoQUKh6iCkXSzGjA8DuMSbEODLQ
	 1F1HeG7+RectBZndDefG6juEpsSFmlomIDgydIjLyNC/4HAhKyd17/xK7MXlc9khxW5nd
	 HmhaVz3ErsMoE7kmEri76KadK4oFOfkSTkWYWQY//5xXR/cjesHA6yZDFsTrLCBKf6A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598590;
	bh=s2CUow/2i2KRACRml37yePvwISBZUSh36chFrvUzLyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wwHWeA2+jRD3qZ72rsdq4KuQw3BoTY015wi2MJJx0Ql4URy86+Y9D1DxVNvwB5ASG
	 EJlLVgsIKnou5rbthLphH9YUo4zRH4kWhYdvnEWB3sb1zrMU6nCCopR8ZkhK0SAi62
	 clVzYlSPB5co77Q4Q8rajsK9wE/QpPawT+Hwbd6+W9rIZ/ZvwvHyRznVY6gqzUEUvi
	 g4Vqztfe/kvufLniHcNXv/EveJP4MtfsG6DSyBVMkwhSL/NSBGkd5vRcn5+ezepog9
	 1GV5H+1L90X5lwxkrAcrUa52sZZv+5ltwiM+xexgvlJP5vz6S6Q5NYbD0h9Uz8PL0e
	 3V5f0nGtRoajQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A3C7405F0;
	Mon,  2 Nov 2026 05:49:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EEE834BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4C5C400D6
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ssC9GyeytJn3 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:49:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AB9DE400C8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598587;
 b=gv94WhVK1YAeSVXGjyUdIDgwBYoy1l3PEimfmt0nfccdwXX0yu26Cz2kvAA9FtrwE1ze
 Plqt4Ai/JmK0l1jxLvC+WiKm0prLsaamiQTFXQN0nZFYxQ5CiIrKj/wEY8W177cgaLvxV
 c7cKqDS5L2scKTiKi5GJQVEg61hM95sKKndXA2mPFtUXpkgupR/P2Qc/lZp5yayUFk45f
 I3yMDdIMEtujBI+XmPxxFtLQRC8LBND8eYb6BaCXm/2+TC6pRovYwMARusd2rxypGPl6E
 STtCGpTQRuY6QgMOrfNk/Elnt8qe6KI1fUfYBIwjVVRneOgQMW+GVhrL3AKIKMye3EA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598587;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=s2CUow/2i2KRACRml37yePvwISBZUSh36chFrvUzLyw=;
 b=hWpx4DmJj9imbeBCh2ogqpchm8QnR9FtSwuPhSmYfYm/IRGDIswtgtSQjWu1kY072EFV
 rLEAPHEDMZQZaDVoZG1h6t+WX6DrLKsvcxiJVo0N0Kk/Z44s721/Aagh1pZs+hrENrpIz
 A2980OqykfZVsmLlUjmCTkzYm4/Cks3UtwHQ2pmoPvlhhy7gehwKgKm1hU8OgYLnnE49x
 IizUJg5nmzHILpBkeFytEc9u6X7tSQ9w48OGfDx2/6QNu7redFCmbcTIxUn0xJAvyaXgc
 xtMUuwM9PcEq4bt4rVwMWWTw6JSWy1Gn8snKPIfCGWzm+l6g7JIPYBtquR5+/VMt3AQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=kxULPHta; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TFKI8eVE; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=kxULPHta; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TFKI8eVE
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB9DE400C8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:46 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A23vCOo2752988
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s2CUow/2i2KRACRml37yePvwISBZUSh36chFrvUzLyw=; b=kxULPHta8TD4EipK
 yYDWbvR1oif18MdDglQMulNcnvT202soYWU6c3b2YtuBnBABE78GnaX9W9OsWawi
 hEs/WQZas+S45+uZZINUhq2oZM8LXfV9jftotkTcsoLmfhzWZPj7MAtLiYHYDCox
 qqdRo0RDUdMhi0zHJJB56Vz/zZtWRnn2hl0ufLDOx5988C32Xbmv6lsHhF1pswY2
 sTkpZ6rsRputJhYtQXhTBkdytEaAO/7hHAswSpPAin+5kn2BlXu3UvPddfIEgXoe
 kiR1b6W8Sfnbi8O4VC5wKLJjwUm+utd0qTTq0XwoUvYASu+CXzVj8IDP+D/lVnAy
 JD2EXw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpg200tav-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:49:45 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1a71dd190b0so9492352c88.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598584; x=1794203384;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s2CUow/2i2KRACRml37yePvwISBZUSh36chFrvUzLyw=;
 b=TFKI8eVEZCSvmZVGsB3bnc/FIkkGbyOUMZfivslW66J61FZ1jnbrU6nCW+0VcA13VX
 lXxny3/+BXdTTGVD01Mwore+gnIndThqTAk0LpXzRhzuSGK+wpegRB5caEbZy/lTKqfC
 NUV8+M0A1zbt94lFGiKUairh/Hc/eQf2RUfYfYzrktReBptiqAXtfd2j5X0BTQEyg7gD
 O1sisDkNeNm4KDglkK1un2aDPFbWujpK2i9TDx/iHi2D4ltfeJK7nEmiW/ODj+0CasiA
 aZbf5Rs1yww0sXlL3EoNH6mFickWn7xcdMtA+tydofJuYIu2HWZmFVjhxYo4ipFroyLT
 pRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598584; x=1794203384;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s2CUow/2i2KRACRml37yePvwISBZUSh36chFrvUzLyw=;
 b=Gz6D2gm6ZzU9f5ijpe/V6fXZwCzUoq/mJWeDuvrWAN5MsscdEn68D4Gvs/ibv4/d1b
 7zg1GESu1Bn8BlOoqu9ZxkyAB8+Fwz7yYP3HAxBMWk+kWxb+2pB9mkPdqDLnPTgMyZ0d
 OiVWIS9o4Q684tSJtHxsoRWmSLP15o5tY0/+c0Wn2og83b0HmjIDV5IQmfZkaEWg7Mhi
 j+YCJaBQCW23jOB/5sEpux0VkORYUtZv7rn1xy3RaWjiFniZmDgqlrg9cDsBByS44vmN
 UKMvyQHU1ui/TlNa2K+urTE/E0e8M2TA3trBGzi7K8dikNiVM7bRfDrTK7rCdwVrQaX6
 gqHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/s007GoMcsIGN8TTY9x637GbgR/epOZeZYAX2O4yGbEeoZSXQl09OZmJG+MkVMrLdc7k8dZE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKat8X5d1SyjpiNw7qgz0fm4r3LjV/PkrjGgOJsObvoYT0ZQDym
 CoYwXFcB7dTnwfzEYvKR3QwSBqKVF6nZ4lYO5rwr7dYMYttZ71XwKfyOmup4sPbADwRTaJBWgO7
 K0/Rq9m3gas+lpTNQYTznjWTALbyn4NbqO4i499O9a6S7YjTSAgJDnSfbVwiPxZRuj0VUsrU=
X-Gm-Gg: AYBFou1sbG+eUPaq05UNAnQ0dLklFSyZCQQuvKDLYLH8SnR+5tXCyDlMfiZwgG5WFAr
 9+psPDiKCwrChQ+Is3rb20HxAHSz9jlPB1Z0pUarO6XNQhHp2mxsa4k6ETBM7B/+ZO18Gn+k2ts
 gumQD2a3PwBq6huSY7C9391BS0kO7035h3AgrdA1TTFmEQ6TzohO01WeVF8EJaBCs6t62B6qokF
 7j1jWJaNSDMu6/d9Q519Gni42F6TAxu6m+22Z3LcCMep6iVBy3H+4bN12M8p/gZ/z2hDMkR5+hj
 W4hUtesui+5crw7hJo4bzJM5qmN8m9kVhVhgW8UhK1aERRgZeU+V4S2v/EGuWiyqX4R0xfXGITj
 ZWrKFA52lECioABCWdoo8gRvmEH40BVNN4qDQN2EvKKnXWu7t+2Zdn55QibqwlpzINbYJ0mkWLc
 r2493Z+YCSVhr+7CqbAxy9akISQkSfGTTOvp5wDcnlwEB0XzXuGxGaH2gnm81TIxlTWOoHnnqlP
 IR/yQ==
X-Received: by 2002:a05:7022:b909:b0:196:e2d0:129 with SMTP id
 a92af1059eb24-1ac55968f57mr12174629c88.2.1793598584214; 
 Sun, 01 Nov 2026 21:49:44 -0800 (PST)
X-Received: by 2002:a05:7022:b909:b0:196:e2d0:129 with SMTP id
 a92af1059eb24-1ac55968f57mr12174589c88.2.1793598583518; 
 Sun, 01 Nov 2026 21:49:43 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm28960066c88.12.2026.11.01.21.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:49:43 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:18:38 +0530
Subject: [PATCH RESEND v10 06/15] mach-snapdragon: Kconfig: Add rules to
 create SPL images
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-spl-v10-6-224d421c6201@oss.qualcomm.com>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
In-Reply-To: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
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
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: K4oYdA5JntXb2JiJ2CVyFbVKVgt203x_
X-Authority-Analysis: v=2.4 cv=fZY4WEQF c=1 sm=1 tr=0 ts=6ae82479 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KPGK5uzhZNYWFyxW8pwA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: K4oYdA5JntXb2JiJ2CVyFbVKVgt203x_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMiBTYWx0ZWRfX9Le9zTsPxFJ4
 R/zHxj180Cfe9folIc79eh2iW69POEPeRpsUnLXv+hQVxOZdsKP35RmlIi8k5MngZpWzYb8LWKu
 4l50K+fRsq/AhB0QVoFzGZLnUBAgnl85Qx/lfA2XrjSoeAzB58A7QsVnBdtgkHnbPXZaXcrv1X9
 8Yo5r22fi0qO0A+bzbUI4VO7txXwoqMN6tEYDtzsfUkFlEqpBIQzGZVc35AiNw7FjF9lqYgRcgg
 IGlG3jS4gS2N2ETZWMqVstA5jYWPwggjEeCb2hm3M1vXiC6wWz8Gttpc+OI/THkIovC/n72ay53
 iLllczZZxDSUoH7AUv7rfBwOFBi/z/bdi15MBTZSuQLJZQS04z3a6524Zm51xiRHJAXTE7i2PhD
 BtqXea4Cq+uy8s0wF7vxe6Ssete1PlWIiZ4WYJXNqVW2zyHs2pNDGE5AEChAjBg7cQTXJQLkf6v
 qWyDxEzGovlWWvczw5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMiBTYWx0ZWRfX7petwzUoNqgs
 NEP5R+7JZ2kHqsJvETANusW6q3LnGvF8rIfLuCaU35Rd3Fjd2IMM6X+VnSjCQijpcuG74Pie0LP
 z08+DmpqU7qurzaAG1J21mmhzEVgLCQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020022
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The boot rom expects the secondary boot loader in MBN format followed by
the TME executable. Add rules to board/qualcomm/config.mk to create
u-boot-spl.mbn and u-boot-spl.melf.

u-boot-spl.melf is the combined multi-elf file that has u-boot-spl.mbn
followed by the TME executable.

Additionally, this patch adds a config option to specify the path
of the TME executable to be used to create u-boot-spl.melf.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig |  7 +++++++
 board/qualcomm/config.mk         | 25 ++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index ddded0029ef..5718b66cde1 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -59,6 +59,13 @@ config QCOM_GENERATE_MBN
 	  New platforms can be added to tools/qcom/mkmbn/mkmbn.py if they aren't already
 	  supported.
 
+config QCOM_TMEL_ELF
+	string "TME Elf to concatenate with U-Boot SPL MBN image"
+	depends on SPL && QCOM_GENERATE_MBN
+	help
+	  Path of the TME Elf file to be concatenated to u-boot.mbn to create
+	  boot rom expected multi-elf image
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional
diff --git a/board/qualcomm/config.mk b/board/qualcomm/config.mk
index 769e4a51ca0..5c45f993a41 100644
--- a/board/qualcomm/config.mk
+++ b/board/qualcomm/config.mk
@@ -8,7 +8,30 @@
 # Create Qualcomm signed elf images
 CMD_MKMBN = $(srctree)/tools/qcom/mkmbn/mkmbn.py
 quiet_cmd_mkmbn = MBN     $@
-      cmd_mkmbn = $(CMD_MKMBN) $<
+      cmd_mkmbn = $(CMD_MKMBN) -l $(CONFIG_TEXT_BASE) $<
 
 u-boot.mbn: u-boot.bin FORCE
 	$(call if_changed,mkmbn)
+
+ifeq ($(CONFIG_QCOM_GENERATE_MBN),y)
+
+quiet_cmd_mksplmbn = SPLMBN     $@
+      cmd_mksplmbn = $(CMD_MKMBN) -o spl/u-boot-spl.mbn -l $(CONFIG_SPL_TEXT_BASE) $<
+
+INPUTS-$(CONFIG_SPL) += spl/u-boot-spl.mbn
+
+spl/u-boot-spl.mbn: spl/u-boot-spl.bin FORCE
+	$(call if_changed,mksplmbn)
+
+ifneq ($(wildcard $(CONFIG_QCOM_TMEL_ELF)),)
+
+quiet_cmd_mksplmelf = SPLMELF     $@
+      cmd_mksplmelf = $(CMD_MKMBN) -o spl/u-boot-spl.melf spl/u-boot-spl.mbn $(CONFIG_QCOM_TMEL_ELF)
+
+INPUTS-$(CONFIG_SPL) += spl/u-boot-spl.melf
+
+spl/u-boot-spl.melf: spl/u-boot-spl.mbn FORCE
+	$(call if_changed,mksplmelf)
+endif	# CONFIG_QCOM_TMEL_ELF
+
+endif	# CONFIG_QCOM_GENERATE_MBN

-- 
2.34.1

