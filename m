Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CEF606A337
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z1CmVcWa;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IhD+dbsj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KHKuYoC1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9483C81101;
	Tue, 20 Oct 2026 16:47:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uGy45rbaKW_v; Tue, 20 Oct 2026 16:47:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A0D6C810EE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792514820;
	b=mR6mVDF6KE28VNNrsBCSxt7899h6eN28K+sRQkg+eNeTsbUnJNyjePMralbXz454SMlE
	 1zIMGKGXysHBQOZfzvJcsTxqB5oP0dhEAywc8DvyoZ2uDIOhvBrWpTGeOHIfTieqA+97R
	 4Fjj0nReaLWrCrAqV/TiP0Xl4hnD091Kb2NIRNHLsBxVwicQqbhdEZkpRli9eK+XK5A9O
	 UBIr7xjS/l01X2g+CsSMN/KEFOYEciID77SuT9jx82fPFpM76bJjz9hUHAQHWyMTaQl5s
	 6z8C/v8fMfVMBGuKGuSChOdOpQOL6FAIRJhXuS4aWpnhZg9Wx3IpYZoWIl2V711emuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792514820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wGNkaNC526kI3KW0hSdXHa2cDLNzuttY22Rxmf/pstM=;
	b=ixESf0xqcj+Fy49cp9AnikirKug/iijcHyJOko4QomQc2mlpdN1hd/3lkJUOksgomcO8
	 FO+/xPfblmKEnLTJqmOvUUdhaeew6gJCduCcMrULwu4l9W0dTZYOODQG1E5y/JQcKSfnQ
	 8qQkpSOPgORjb7xP4Q7SySuDKaeWzPtSVyjUBuGBuTIkebPx4v/R7/R7hQ8BcfI4tTUwZ
	 gI4AR50DVKj23vAQqIyhnnvQt7rGDChXarOejWBAECWSYR7BMqOPGZJbx7RL+wl43dxck
	 ZATIQNYgahiiMoTzlJv2oJPXd6l7sGpg+gN92EIqpGpiWMA+dhVRWCL8s4tvn7EM2NQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IhD+dbsj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KHKuYoC1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792514820;
	bh=wGNkaNC526kI3KW0hSdXHa2cDLNzuttY22Rxmf/pstM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z1CmVcWaHHvhWiDx2OWHtIH215nNPOlDBUwLsaV/2lwl/SlLBAv7sl18Vu1KAeXeT
	 gBUg3CXlwaw6uKEodOkcXPXQLPsFpYWHiYRjfziAYcKFHM0DrpGS298XAHRY0sHU/4
	 +XBcSRTIz5vNsQ9XQzwjtHYqCoA+jJnHoiJBtLvk8nMIJfbm0lVM7ArIro3rBqA/tL
	 8eeljOIVep2g5V0NUiSaS4y4Ouvzr0TtTyV5nUNShX31w6uwB7Jclr88q0+wc4MQq8
	 U0Z86wvFR5tF5gtNc/+MnUcTWvEW6JH7SXM4sG1qRq+SbUGdgqje6WR2as8Oir9Oak
	 C1XvXybolJ9bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0D6C810EE;
	Tue, 20 Oct 2026 16:47:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 93E8E1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:46:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 85A07810EE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:46:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fy0L4-34dijf for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:46:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C90A3810CB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514818;
 b=Z5yAU/SIq92KPYiSCdRVXDgQVG1rJ+8GmRxtPdJayG763IF0Tz+rqa+9zT+OgOFtUgA+
 PBGPkf3cQkwgNe9b3V83kteFVnfMVib7qsDra+Rt9FmPl0SS1yCz4aLlh+MY6fMYE9Skg
 obahx9M6D5hwB399SmJsp1I4LCNBJ1RCKyOTUt3BkEva3JY3dlE/sr/7JHdfMHU9kfUko
 GmeuCf0mM8F2MsOJ6WvmssZmHC76ta7QSeUwp/Q1LqrVbiI1IAzEjNkkxnIpyoavtfE8T
 dZyIPvHCHpC2HvB9eJyxqlaZYWAEHHjyW00VH7kq2Qmyup+BGg6jDg02e1nN3IfN+kA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514818;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=wGNkaNC526kI3KW0hSdXHa2cDLNzuttY22Rxmf/pstM=;
 b=tB7TTBpgAU3KfwBuiTPlRG52dqQ2U4a4fbIyblShER1i6HWAEqleHqopjUYMEwUffOOj
 xnqrKHmqGGiv8fu9a35eLxNZpTvJ++w2+dexb7TO0B5CmTdWQIFD4bPhj0iblc5ZqHxdQ
 h4XqEaRYX06QoSehJtKWmqscESHw2172LNeTKH55sbbYSIjUxh3WE8uH4APpcR7G1/Hg1
 +LWyLXfBTibCt/fIrH4KdLtRfAwjkE5P6wK99+B+95k7+ppzKaosSGrfqKe2YlEZEBzuR
 e+EohazgLQmMH8BpVeKpDr3gsK+3238QuWSacqUAzP4SyLt1qW512BhQL6qsmoRhMpQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=IhD+dbsj; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KHKuYoC1; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=IhD+dbsj; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KHKuYoC1
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C90A3810CB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:46:57 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KD9pnc1781302
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wGNkaNC526kI3KW0hSdXHa2cDLNzuttY22Rxmf/pstM=; b=IhD+dbsjr8G1KPZd
 7xZoPsdoIJuC/qg95C7tt/EsOQDwWhZqa7bowfVQF1KHk1uPuRlwnOyAgkcUAa5T
 yTCNsNROfa/G+Pd04LHhagmwgky0iaAwchEHET+k1iK2uxx9O4A7ly0BFfNX0Y5L
 qDbwJsnwOmTa+G//Yn31miiFA0v+Bqmy80wJ0QgY7N9DlyE2iyEgR9VyCNJNGXMY
 rCleR6R3+tVMURuLL8mRSvj0+Qo47FtYUd8GjtqnNO2w78VKfjXR2t1PTTIpB4oW
 kNInKNPQIF2SQDNlwLnbBYPzcDXk32PcvNGFwQBHsqGHy8TsHvbWSJZMvSYxXFBM
 JzvuYw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7h2970t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:46:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so9697273eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792514817; x=1793119617;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wGNkaNC526kI3KW0hSdXHa2cDLNzuttY22Rxmf/pstM=;
 b=KHKuYoC14neWL+NSzKAgPQA9Tve9iq9FzjdZ1ytpXFXdkP5wydqXoDrykx3diMwZR0
 chCqmwpKlcBoPMQLDPdpcGj490AtK03EBNo/bWyLqlvS8dk1Usryj2p3PsNJmxx1cEhW
 Ek668NaqD47zsfKEQpecZ2LpMJDvIk9FtL4eO06mgwgdvpYaaKFXMnMmQ2vSfp9kdeHa
 MX/+hEvNa8cWQURAHpbVqUbW79PNRZ47yxRvPeXhOHIbbFPXtbnE4BojvnQxZ+obOBQs
 B8Cpe+3SlCDWk5yPkjEamdhQ3qn3GtcMc9CkynzxB5UJ2evB3WOX52SEJ0X9NLIbhOsS
 Hnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514817; x=1793119617;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wGNkaNC526kI3KW0hSdXHa2cDLNzuttY22Rxmf/pstM=;
 b=W7GlBEBaJD8A8t4ZVQsEzjitvUAdeu4Us5qi3tjK52ppvgIu8wqq/kKrVM34WRndHF
 Ox5318MJILDfUFU0EW707WWHqA4oXC3g03SDhxkwqb/8HDvqfw9jn0ZhpuyXea8egl7J
 FvH0Hd8P/29UxtlHOOiqKjddO/TJiLQ71esU6wPEY9lIAwtVBE17fYoXnYMFCbeRMLe8
 L/PAqPbmhVBfZ0sN9LMGrlXJDwvWXw1AHnK2HO+as5ZYAunntpGjeUb/aR5ey0FVU8Ya
 uEvxRTVkMlvs5ejjs1USAADlTmEFP17m0tRYURVHDwl8svgS0Xzj0VRkKuSlkhQB9PZR
 veoA==
X-Gm-Message-State: AFq9FYKKpAeNwXJg2B78QBFu0S3csT5q766u/lwuyYOAi8iGMYNq/LqE
 SO2jEvL/eubC5EEP3dqGh3eglal/9thMmILbJDDe4XILSG2h82Cyi8UT3wyGOdSe4IBkjl0uBHA
 tGKh47nunM9cvISRkXJkF7azDJqV5MhQwlj7f4N6nYj09jrFJ1rzkHKLJkr5VJiimARt/3pM=
X-Gm-Gg: AYBFou3IfWapONDkWKHEgZewjla+SxfWaQvXXwR8XyY2Mi4abDgGSfVVangOtF2QN0d
 0/nsVTe9FAqfh9HkYu0G2U6j5QaD8BYo2Re6Eu8MK1tTGbFK7oF509zT2wBCKPyNBA59g1kWegG
 EaV/4Zhc067HDWoUyQaGdgqICwm6WWR3upmbARELgfGGwA3nAqSf47Nc+2bDxN92mgEZYNbiAKT
 HFg92GZktKmRMOl0Hkq8Mca3Cx+xf2qM3qp9J3uSslfqJvK30Iq092LKa91AmYhefY39J+tsJxf
 yNoHuR0A+hNmwuxuDDR2UaJ7EzDmr9FXTpi/4RZv+kXYreAQJzot8t8GZmJzfu0kdkBaTA82kl6
 +DVUOSC+r23cf3zv3tQhXw1Q+hd5Y7u1PcH7rmylPySXHwM7n1+Zo5yoh45RDZwKxiN3GvoVCoD
 TnBL4IyGk8wMVyPyNm6c57iiHBln8=
X-Received: by 2002:a05:7300:50c4:b0:366:83dd:46f7 with SMTP id
 5a478bee46e88-36683ec8c2cmr2357402eec.17.1792514816211; 
 Tue, 20 Oct 2026 09:46:56 -0700 (PDT)
X-Received: by 2002:a05:7300:50c4:b0:366:83dd:46f7 with SMTP id
 5a478bee46e88-36683ec8c2cmr2357355eec.17.1792514815391; 
 Tue, 20 Oct 2026 09:46:55 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36632d8b273sm6318507eec.15.2026.10.20.09.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:46:55 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 22:16:21 +0530
Subject: [PATCH v2 2/8] reboot-mode: add trigger op and request helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-b4-reset-edl-rebootmode-v2-2-f690da515804@oss.qualcomm.com>
References: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
In-Reply-To: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Vincent Jardin <vjardin@free.fr>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792514792; l=5628;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=xla6Eak+okuwvB4gm3OaqucXrT5s+gDsU/AHVKd2uO8=;
 b=rI/FbHcmaBJGQiy828f6qKEaw3A9v7/5wBFiSV89EmymXv6PIISwguph27Azo1nPFtEmP7sAB
 3rWmD9MX+keAWtxhtYhi+xMc2aSe5nWa6NL4RhAGVPwsZfpDkPzeO4+
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: fbWyQ3w9k8ydkpF4IBTtFy9w9Xtp-PRj
X-Proofpoint-ORIG-GUID: fbWyQ3w9k8ydkpF4IBTtFy9w9Xtp-PRj
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6ad79b01 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=cYLggO2AOuIoYTYeAxQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2NiBTYWx0ZWRfX+EVRJqMrpEQ2
 gbc7AAhbXNDLm70KIbV2SlmGUGss1/H5oj7IBsb8jCoE93li03kw31soVt97bnO/Tdd75hzwZVz
 4Gz7V5DQElk3GSnoLKnkC6ihAy9pkwA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2NiBTYWx0ZWRfX4RnP7SAVIs8h
 KHqGQEpFhtefFQLZnHmJnfigPQ/YHqULDJUbifxH+EaosYIggnkktXtUqXSqQjtjOLH9fGFEb4/
 arXD+6/z+BD8gcInhHDVCLSnXD5tEcjZPqSSg4u6wvtjB+wTx0sBfrXYyLG9fX4EOfmw6/yHi0q
 PtCioI09WMLNOiBnd4Oy2O2dM5NjK+b7kTIdC9/wO4mLRHPZSkTubua3327idexO4GX1mnHY7xh
 JQK9hq5rbcr0rpSt5hvfR2Rqse/mSeUsXOmwKvQUPNXRoJYNaXKslVe/j50ZyBgDysKpwQ2WYNa
 YXNxU6yXuRAgdZvJDFB141HCH8Bxe7qJH+FUQA/oYvOPmCbGatSAhNYejtTIQpXBx2yYYcD69JL
 mJwuw9moCF3FogIE7Oulwn2z5Dsk7HVG1dhXuThFAgO08VXGjApn6HcxQnvFhIxKHnfke2kuBqT
 GT8zuSXrDGQRdbpkUGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200066
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The reboot-mode framework so far only reads a value from a backing store
on boot (get/set) and maps it to an environment variable. Triggering a
reset into a specific mode on demand - e.g. rebooting a Qualcomm SoC into
EDL via a PSCI SYSTEM_RESET2 vendor reset - needs a different approach.

Add a trigger() op to struct reboot_mode_ops. It takes the decoded magic
cells for a mode and resets the system immediately; on success it does
not return, so a driver that fails to reset must return a negative
value. Backing-store drivers (nvmem, gpio, rtc) leave it NULL and are
unaffected.

Add two uclass helpers built on top of it:

  - reboot_mode_find(name) looks up a triggerable mode by name across
    all UCLASS_REBOOT_MODE devices. If two devices declare the same
    name, the first one found wins.

  - reboot_mode_request(name) finds the mode and resets into it.
    Returns -ENOENT if no triggerable mode matches, and -EIO if the
    driver returned 0 without resetting.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Drop reboot_mode_list(); the caller enumerates modes itself
- Add reboot_mode_find() so a caller can check a mode exists before
  resetting
- Treat a trigger() return of 0 as an error (-EIO) and document that
  trigger() must return a negative value on failure
- Document that the first matching mode name wins
- Make the trigger() count argument uint
---
 drivers/reboot-mode/reboot-mode-uclass.c | 48 ++++++++++++++++++++++++++++++++
 include/reboot-mode/reboot-mode.h        | 46 ++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/drivers/reboot-mode/reboot-mode-uclass.c b/drivers/reboot-mode/reboot-mode-uclass.c
index 80aabf54750..f405e95c92f 100644
--- a/drivers/reboot-mode/reboot-mode-uclass.c
+++ b/drivers/reboot-mode/reboot-mode-uclass.c
@@ -54,6 +54,54 @@ int dm_reboot_mode_update(struct udevice *dev)
 	return 0;
 }
 
+int reboot_mode_find(const char *name, struct udevice **devp,
+		     const struct reboot_mode_mode **modep)
+{
+	const struct reboot_mode_uclass_platdata *plat_data;
+	struct reboot_mode_ops *ops;
+	struct udevice *dev;
+	int i;
+
+	uclass_foreach_dev_probe(UCLASS_REBOOT_MODE, dev) {
+		ops = reboot_mode_get_ops(dev);
+		if (!ops || !ops->trigger)
+			continue;
+
+		plat_data = dev_get_uclass_plat(dev);
+		for (i = 0; i < plat_data->count; i++) {
+			if (strcmp(plat_data->modes[i].mode_name, name))
+				continue;
+
+			if (devp)
+				*devp = dev;
+			if (modep)
+				*modep = &plat_data->modes[i];
+
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+int reboot_mode_request(const char *name)
+{
+	const struct reboot_mode_mode *mode;
+	struct reboot_mode_ops *ops;
+	struct udevice *dev;
+	int ret;
+
+	ret = reboot_mode_find(name, &dev, &mode);
+	if (ret)
+		return ret;
+
+	ops = reboot_mode_get_ops(dev);
+	ret = ops->trigger(dev, mode->magic, mode->count);
+
+	/* trigger() must not return success: the system should have reset */
+	return ret ? ret : -EIO;
+}
+
 int dm_reboot_mode_pre_probe(struct udevice *dev)
 {
 	struct reboot_mode_uclass_platdata *plat_data;
diff --git a/include/reboot-mode/reboot-mode.h b/include/reboot-mode/reboot-mode.h
index 54a8c09650e..630454b453d 100644
--- a/include/reboot-mode/reboot-mode.h
+++ b/include/reboot-mode/reboot-mode.h
@@ -46,6 +46,23 @@ struct reboot_mode_ops {
 	 * @rebootmode:	New reboot mode value to store
 	 */
 	int (*set)(struct udevice *dev, u32 rebootmode);
+
+	/**
+	 * trigger() - reset the system into the given mode now
+	 *
+	 * Unlike get()/set(), which persist a value for the next boot to
+	 * consume, trigger() performs the reset immediately. On success it
+	 * does not return, so a driver must return a -ve value if it fails to
+	 * reset. Drivers with a backing store (nvmem, gpio, rtc) leave this
+	 * NULL.
+	 *
+	 * @dev:	Device to trigger
+	 * @magic:	Array of @count 32-bit magic cells describing the mode
+	 * @count:	Number of valid cells in @magic (1 to
+	 *		REBOOT_MODE_MAX_MAGIC)
+	 * Return: does not return on success; -ve on error
+	 */
+	int (*trigger)(struct udevice *dev, const u32 *magic, uint count);
 };
 
 /* Access the operations for a reboot mode device */
@@ -59,4 +76,33 @@ struct reboot_mode_ops {
  */
 int dm_reboot_mode_update(struct udevice *dev);
 
+/**
+ * reboot_mode_find() - find a triggerable reboot mode by name
+ *
+ * Search every UCLASS_REBOOT_MODE device whose driver implements the trigger
+ * op for a mode called @name. If several devices declare the same name, the
+ * first one found wins.
+ *
+ * @name:	Mode name (without the device tree "mode-" prefix)
+ * @devp:	Returns the device owning the mode (may be NULL)
+ * @modep:	Returns the mode (may be NULL)
+ * Return: 0 if found, -ENOENT if no device declares a triggerable mode
+ *	   called @name
+ */
+int reboot_mode_find(const char *name, struct udevice **devp,
+		     const struct reboot_mode_mode **modep);
+
+/**
+ * reboot_mode_request() - reset the system into a named mode
+ *
+ * Find the mode with reboot_mode_find() and, if found, reset into it. On
+ * success this does not return.
+ *
+ * @name:	Mode name (without the device tree "mode-" prefix)
+ * Return: does not return on success; -ENOENT if no device declares a
+ *	   triggerable mode called @name; -EIO if the driver returned without
+ *	   resetting; other -ve on error
+ */
+int reboot_mode_request(const char *name);
+
 #endif /* REBOOT_MODE_REBOOT_MODE_H__ */

-- 
2.34.1

