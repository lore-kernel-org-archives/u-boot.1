Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0352BCA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:04:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5132040665;
	Mon,  5 Oct 2026 07:04:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qijJYLnb_AG4; Mon,  5 Oct 2026 07:04:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7ED1240401
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791183876;
	b=VHhZVrbjg+HSQicsYot7CGeAbmDSDPBSDW/DRHLXtwezp+t0ROrgk+71WF94qHzemPjG
	 Z22j6ofE9im5+Cn9YUHC2UQgL6NWFPsXICmu5aFvzxBcSNmreerL85WVWQldZ6UNb7DnC
	 IOBIGAJhYM840q0G9zinEYHhKqePyKdvZdJhoed5L/gUT3ZIsx+bIuvHgPco3G52qm4OO
	 oiyvych6oh4rJA664cUeaGoXjCKl7fb9Mm9AlTXVSbnNTc+bCSjWeLzHhPrLbviuIi3KX
	 P9I1rig6rjEQHFsQtzKjdnEeyAEyXoj4XHSRARjenSPFPvfxclQxPzCyZjN95Ad/3xQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791183876;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=X+3rcfp2uolGX03DvOFESOO6mo2XENhYY4k+K8cOtEI=;
	b=Jbhwsz4H1J82cnfk/XYT6abUgU7RUojtlzaEoSuT4xM8XqM6/yVE7C5ZetSENIZEUjF2
	 6sfPDvSBruhwJJyxjvE5isePRE53O4pnzzX6yDXQWWDrTxrv97Kwk1dJgRuv2Mhp2Uq64
	 sqZrSQRTlq7QY5zpm0pHX/L52REmBuQk19/RFycEgSfS8dgfbfmkHJ4UKxnne8LlNFGA9
	 gpBbl5uwbPdgpTonTIls1zhrDs90jSzpceIKa0Jr+uTO/YnUNWtE1Almvw+Q7xnuvQ1h4
	 W5C6EaMr6VbYmmlPSimSEdLiuwGiunou6uEAfajgcFrohFuXfIxKcKGl4BAXnqdQE0A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791183876;
	bh=X+3rcfp2uolGX03DvOFESOO6mo2XENhYY4k+K8cOtEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IZbk5stQSmd+rfFEbswTOXC/mXBmDm39wxfIDss/+oSIFtxPeu1Zh/kHST8KWc3ol
	 iIkWbW2VBG5Y/TywJPLecXT5e1zwE2cnEBXzOBmlLsmb9tO9DubQUawDfxz0Ia5cXK
	 4HA9PIbdC9dmrl+43YhFUEcYbQmr2H3rVkT15I3cXhKvg7w5LPHPZ2GlqM00Y2W6IM
	 1tJlKKJmS68NCBOuiC3BCADMZfG4Tef0BjQ64icF51ebiRxOIqFkVTjQ3HlV4lMLE7
	 LuQdrVmFlsA3iQvhWCx7OMI3AoTM5apgtuk78eDzGj88xDi9iEjloAG7KmnAAbvcfU
	 DdKqHTadZoWow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7ED1240401;
	Mon,  5 Oct 2026 07:04:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 441F634D
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:02:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 41C9E8083E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:02:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qw1JfDU56Jyi for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:02:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 75F6C80839
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183773;
 b=Liiuw0s163k+3puKKbm3tXh+Ub74+yBjGM+SPKDLciZDo/s64JFTl0iL30o8Us1NUU1R
 ikMY0wV3rNznagnBFt+nSpU/fEaTUOiKv94e7cAdCRCWkktQ0hAOWSh2gwIJUp7ud2WdO
 TQ7MmS67gti7U+9uXkq0Dv7nasraUZ6TGK085tm4gWU1hXXzuhgK28BdOx8/5/1ms3Xor
 gp1FtkH6OrJvjXtCuespa2m+wSL3uwqIrgawQ8i/GXLRTsIn2Sh8fy9ki4PLKcaNjFoS8
 epFN/SJCxmlds2UOZelQsjLN90S5vcAZppT8/yOIW5mrLB6+IoCylu2nQ0pHEykpkew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183773;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=X+3rcfp2uolGX03DvOFESOO6mo2XENhYY4k+K8cOtEI=;
 b=sx/bdCb8ntX+imTppxvhb9Dw7q5bp1TePqEhmNo7rgfQTsOYyVN6UmhBhGWruSzFFU/J
 p37yEQi1BHFgCeuRGnqZxhLgc+/KhGYICZ+Qray3nInuSjOMXfl4g9oMulZQUt9QSWWDo
 24cREIsYhLUXO0bfylibCoVdM7rcCBOf5r1LyTnPtCPHvc2HqSm7IbcPNKuYwXAF4TMKK
 gVPD1SwpUKCVIhGKnuDHmR8S6ayDgovMYwtUWwtyLHv5Do38MHHv1OoZOqx8d4v8cV1bE
 uEHfHe0nsvexOkevswBskei9pWaSdzLRwTIPz2ahHrfvUt/w2wZoW79hTXtYqCrLdIA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=KIiYFUvF; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eEhKDrfT; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=KIiYFUvF; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eEhKDrfT
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 75F6C80839
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:02:52 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695103aD3688176
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X+3rcfp2uolGX03DvOFESOO6mo2XENhYY4k+K8cOtEI=; b=KIiYFUvFesLr5Wn/
 uql/9BLPXQF8fvIze+OEp1IjGHKRzRu9jkSk3rw2/7RRr71AeXoAxz7XoXnhMknt
 QcDsk3Z1wpT4p8uY/QU3eGqFO/6bEDr5CFAOIT8ovh774c9Z4ei/Z2zPkmObJbSM
 iK++swdnA/9bH4y4mIuP8ruZSG84Pc8WyeyPC3kuCFxPO0yNPxqiEgp+w8krUDRw
 v7a+/BtG6dXmueg8fxdzUAmjzPIgjmcdeapjiW2DKE/1t9s7/yq9k74sgN7llrVf
 EV3zrKoqblK9KQSRUbsWndiptRRoYFtbNhOAUVCbjmHGb+TNOHZD33+Orq5WL/PU
 oluJ6Q==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3chfjq53-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:02:51 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1416f32fe11so2503674c88.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183771; x=1791788571;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X+3rcfp2uolGX03DvOFESOO6mo2XENhYY4k+K8cOtEI=;
 b=eEhKDrfTijeFJ2+uoiDm1J6tEBVkyo30CyQd3Ai+J7laSRfkSWzG6c/Of4XBZOlg6L
 LoF6ETFy0AazJIBk0H1MZwmOpd928m2IMrM5Qi6B8dQpQ/pE6SZyHsubO8c8SHMfg7LX
 lgS3sSOevj2pfLF2o9hSyoXoyTxwjdGQvju42eqmozhbF8Ona+OgBwyyIaoyRxdq1umU
 GKws0yrnrwuxoYC9Uh5ytdWNtsrZAWEWH4TJdCM2CJvD/cId272h+tPOGstl/MKbF52L
 6yTerbdjWeHJgx66qrCmLNWC9yO5bhBENpAdO018VWI+h9OUJewkMYf2l0VvhwElm4i4
 fZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183771; x=1791788571;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X+3rcfp2uolGX03DvOFESOO6mo2XENhYY4k+K8cOtEI=;
 b=BHv8wTVuTmvH307cgU97SJv9KarUAYJjbTPBNAZqCWnAu9ZHEvt1WIpzEY2xNQ99zA
 ME9o0AxklWRjT/TxyBfM/lBdHydZGWI+RDKzmoHnyKrcDboOGWUE/vt1lh6/sxq+2Dg9
 cUOV1Eh8SyqnDIsGbrjr4ersE7J0bTvcgRl6Cx2e5OJ7SSo3zfLoU8ktjFzg3+DJ7ZxN
 fn8Nzz13642G6HcevDdkPCYAWysMX1lmJ2ktZiSFDBsXt9IXUPc+A3xywZNx9EQ2M5GT
 2P5A7zb7n4EJ1xkl+NGGbW9LzPqUUfmDyrEq5yoif2vXULZYtK1QT5CmO3etl3APl+eR
 bWdA==
X-Forwarded-Encrypted: i=1;
 AKwUvByTEkcGBIaYplI5nJmp36pQ9ZC5assv0qjXdoJpTsWrrGkd+Ro8oKb0ZWCbJpaYe0qHuaaiRII=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n65aurChGyUu87ztD095vZUitMtxzBPlqGPSddQX8crfe/YYI0
 N/q7ASQp8y/hFnx3b6TH2kZOUoCq+k0VmNYHYh9d8EoWF+OT6dWRS6r9yLq+NNRmiLFQwOQBKuX
 DrDJ5PviFePOVskgp5wKIcNJjRN1/UqWISzj4U9KIOMBnShT2QzH/IUsaN30iFJln+m21ExQ=
X-Gm-Gg: AYBFou1WL+/pmqyQvSAc/0bfg/RhvIkkG2AbnvvQ2RnAwTi1uLoWb0+crhKq7f2fMeN
 M51iHTyEL25ApdeYlWMsnwZdcr8UfP6vlzd6E3XN78pdCvv9Q560ykxolOKrE6RWI9WsYmd0uoH
 bwhIMQQ43dyhkzfim1xoAMeSxRm8HJ02j7H4OuQ/ScKOPfGmgTaChwkSKXfcCvoanhHUa9j6JCT
 h71aT87xoKIagVdkR2d6i3254xbvZhFSvX6FcLBc4lrjefj+DkEeIvSnxkKn75i2mrWhmcFsPh2
 fhv1pF9poUhTYwjv3AhD/XS+ipAQqrvOOOSKkmE8m3ikUMRJIoi7Ldv2ODsAp2PSrtrJ/f/RfYa
 Ud2o4xPgQVLjPubDLVP+Ylovn0TUjN7WM1C2BCoWUB9OYecVaedPMg4OprGRglb+GWzX4VbM9LS
 9FWDQcJ75XiXD3IhI4Q58arVIBJKYm
X-Received: by 2002:a05:7022:7e0d:b0:14c:d38d:72f0 with SMTP id
 a92af1059eb24-14f5b218240mr13039914c88.15.1791183770770; 
 Mon, 05 Oct 2026 00:02:50 -0700 (PDT)
X-Received: by 2002:a05:7022:7e0d:b0:14c:d38d:72f0 with SMTP id
 a92af1059eb24-14f5b218240mr13039869c88.15.1791183770211; 
 Mon, 05 Oct 2026 00:02:50 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127160107sm9797561eec.11.2026.10.05.00.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:02:49 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:32:18 +0530
Subject: [PATCH RESEND v10 02/15] mach-snapdragon: Kconfig: Auto select
 options based on configs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-spl-v10-2-c4ca29bf27ed@oss.qualcomm.com>
References: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
In-Reply-To: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 974Hi7wIvGZ7EAI-22gyIbuEcSdaXmlJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX+nNWP0BsNOcR
 zwVNrahsI309Ef4/+6wEu8X5M7wyXQg0KVyGRqE567I/aXjaJkmDSYQ2xTSIWVKJk2dhRdKXHaN
 A47l4hHkNe/SoAPm2aSjNLJndRVssAc=
X-Authority-Analysis: v=2.4 cv=eZSo7LEH c=1 sm=1 tr=0 ts=6ac34b9b cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=BYZ-A9fJ0MEHusibbq4A:9 a=RW3EtsfI09ntgIjO:21
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: 974Hi7wIvGZ7EAI-22gyIbuEcSdaXmlJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfXxEuHG1uzpplo
 VVmKqN5sxGcNZHfY0fzZjgWwZri8R3h4MApfouTff3dJrNB2X+PzdIHDioegRvtcy7InW29UCE3
 xMvIBOquQrWexqW+i8hPaLNro0I7jlaB2OCMO6QNNMhA7WeejQl3JOav1uHo8Yrgy/3vwuLYxlm
 6PF22i+me6RSX+XIJx2J/Sun4x/YVfjK+uzBgGT5V7N58LNuSYmanUz0bOOq86BWCy7VRRV14Fj
 yUiQZiRh0jyBE6uj1N6bySHUTFik7owAiajqGtwKyJSR0Qyk6xEhw27OS1PUZHthzLjxibMziUJ
 XD9sBDalI4eGkRSMxnc90NbdgrRHgTuWCfDDxzBCR1E0ef/aXGTvDoeivHLNgZcgyAmJwCi/jB9
 ZzI16y59kgOE4RDOrutG0a9wxogaigSXiXa1L4ihrL4OegwNtlo1505hx+qgCYsqe+zkQuVtyxM
 TdV6w4CpRDZCehFlYcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050027
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

The commit d38787bb5dafa ("mach-snapdragon: Kconfig: changes / additions to
support SPL") auto selects options that may not be applicable to all
platforms. This results in warning messages during make xxx_defconfig
and/or waiting for user input for on/off or values for certain configs.
So auto select options based on the enabled configs in xxx_defconfig.

Fixes: d38787bb5dafa ("mach-snapdragon: Kconfig: changes / additions to support SPL")

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f307340e3aa..51d60ef65fe 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1147,8 +1147,8 @@ config ARCH_SNAPDRAGON
 	select SPMI
 	select BOARD_LATE_INIT
 	select OF_BOARD
-	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
-	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
+	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK && !SPL
+	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK && !SPL
 	select SYSRESET
 	select SYSRESET_PSCI if !SPL
 	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
@@ -1161,12 +1161,12 @@ config ARCH_SNAPDRAGON
 	select ENABLE_ARM_SOC_BOOT0_HOOK if SPL
 	select SPL_DM if SPL
 	select SPL_DM_GPIO if SPL
-	select SPL_DM_PMIC if SPL
-	select SPL_DM_USB_GADGET if SPL
+	select SPL_DM_PMIC if SPL && DM_PMIC
+	select SPL_DM_USB_GADGET if SPL && USB
 	select SPL_ENV_SUPPORT if SPL
 	select SPL_EVENT if SPL
 	select SPL_GPIO if SPL
-	select SPL_HAS_BSS_LINKER_SECTION if SPL
+	select SPL_HAS_BSS_LINKER_SECTION if SPL && SPL_SEPARATE_BSS
 	select SPL_LIBCOMMON_SUPPORT if SPL
 	select SPL_LIBDISK_SUPPORT if SPL
 	select SPL_LIBGENERIC_SUPPORT if SPL
@@ -1181,7 +1181,7 @@ config ARCH_SNAPDRAGON
 	select SPL_SPMI_MSM if SPL
 	select SPL_SPRINTF if SPL
 	select SPL_STRTO if SPL
-	select SPL_USB_GADGET if SPL
+	select SPL_USB_GADGET if SPL && USB
 	imply SPL_MMC if SPL
 	imply OF_UPSTREAM
 	imply CMD_DM

-- 
2.34.1

