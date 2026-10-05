Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014AACA5FE2
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:07:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A788D40505;
	Mon,  5 Oct 2026 07:07:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FcqmqrTtDTHa; Mon,  5 Oct 2026 07:07:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A8E0A40441
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791184044;
	b=ZRiPkvKv/Wn5xniydGuNn1zSHPDqvvHxS0JqSp6TTMw3B+ZN16H4RSH2BWrSI5qyrkin
	 tUn7lXH1eRH+8wIsfoeI2bJThi5m2D6qHz6HN76atuTG3FN2phkdPD2qvYHwz474toct7
	 MlfyOGhe2D0/Fywjhr3CNYHeXiIxcqBn3HdnS6r1kDhgokl2jnSSxClqJOb7DDWbzYu4r
	 JV5dt4A6YFKfrWy9d3XPUYjVbHIGllCrLuKPvbo24+zXgy0ggkhV+ClAnWPBw68To7TKd
	 ljVXuWw/3n/sHnKuP2etLqCbVsG3/pEQouH1mlQvwuDaDl2tx7sEn01XzPfwY2rr67w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791184044;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PsDTcz6+5glb5rywMAXEdZ3tLUxJfOqcDIdJ3hpAV8A=;
	b=tEbWc7KxNJ6SDQOxRPMSeZy69pwYQ2L97FODDo12XxhKxteiMaGqOe462Husi1I0Zffb
	 AfAekhmhF2FwmHr1zshXrzkiUvRh94tY5u4uXOolKtYE1hRWFWL1uEV+YMZEt8L52KyeU
	 bh/vhVQiAC+xUXD6pnwd21MdR2RLlrWz4Yci8M2xgb6isyZiI6E5rFRYKNEn62Hx6nmtD
	 fixTOSkON+ynrN3oVjSsTsBnFe8gcRMSEZAczkIoLmacI0Cvuuobcm9tOb86bSGdi2SPJ
	 sFmrnDrvnRujN265OzwhrD0YWcQkhJZjfsfuXW4VgpSlWL645FM7CM+E2fy34IsMjDA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791184044;
	bh=PsDTcz6+5glb5rywMAXEdZ3tLUxJfOqcDIdJ3hpAV8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ygrPj0Gtdh4NYSicMVek4zblAH0nimN7HiW/3vmh7kjCO8Un2Ok93Hl7hlKpj5eCy
	 XXpAb6JjA+gvZQewloy3dWE2H8xSmOTfx+V5SgZMWG9MxAPuNxG6AT0zLgEVC/tvnn
	 xHnCd37VIiKY0q6+S7W3OpLAn2PDOyXuzqnbdxUlD0Ey0cuV+4UaZK8muPK9rT4GCk
	 C/naQRbQiaydVewmQBg8m+e+Ygs7kDoaJyt4klaxjyCoCrj0tx3TPUWVoP5WyTiHrp
	 db4QzSauHrtdDxjqSVBHnTDdJ8qdHBqyKsRx1h2bYnIclDchzYas/m8UCR08gGpRug
	 TvfMSF7C3KBJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8E0A40441;
	Mon,  5 Oct 2026 07:07:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5421F1A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A13D400AF
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:04:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id myUGRel7M6o8 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:04:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 535A8400AE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183875;
 b=ehotG5BI6TNEG2l0FkxYaUKKinQlssOp+y+EszzyVI7lCQGmda5lxDT5C9qUztA0vXoT
 Lsy/pBcJ/MBuhuzKXjLHsmFcqWNtyBz1mIoLlR2CTTjoCbn/WufzU1QjzCHibvQDFjH9V
 YAnTI1HDSn5TxhGGhtHwUc6ZJbBBp2nOUAirtaDBZkn9cRJNzJmugNnblsjXqRn3+tkcx
 XgOhUXb0eOvgnGgacLiX4U4yaGdgwSbb16qeNt1/sPNEBiD93HGKgLE5EdVs75CHaVhrE
 S+5AJ1MnBdqMRIOCSBRTAhFLxMPNoU2syeBwUFjP+DMYZVtC8XB8BgbEZ1sY1LT3gDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183875;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=PsDTcz6+5glb5rywMAXEdZ3tLUxJfOqcDIdJ3hpAV8A=;
 b=ACU4GPeGzNgVIcasEma6S/xWY3znLWvz8uZmF3k2trKLDtBoBbV7QNk7Ap9IuuLxAznD
 tzBzT5EEP8tlgYPgnlX/UH3iZ129Tb8l+JCV+D4BYKxyKp31bDVemhUU9QO0wI7stogG0
 tYZ77Vcm3i5d/ZukrfGMqcqoXh7podwMrYjklG8v38mK12lIxpCosINRALjX9M6//6eqY
 NMb8Nw7UWJzyVhCObPhCBE80KlJu/jlkbpeESpJtGrPcdjiWFTuwpaBfSBcv4VMVFiPDm
 LSCcM594Y438X7T48rkXsweoe13XcYwDdD0Uj/8jg5Muf72WmdAFFP3iKAnbQo7aeSA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=FGbruHtr; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LFBk+Dmh; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=FGbruHtr; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LFBk+Dmh
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 535A8400AE
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:04:34 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69510sa5788586
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PsDTcz6+5glb5rywMAXEdZ3tLUxJfOqcDIdJ3hpAV8A=; b=FGbruHtrZvRG80gl
 0gnurYkV/aPvXGu4fMrpEeCugDxqmYkzPsvodm9DAqq25B0E1iNbE9/jShkQ5835
 OyfTaPntEJFAlCdGE09BKTfiJFYPdGA6iFN84/jmbyU50RGzi+AcjpekQKmTsKVs
 b8H+NN40u36yaK62Hd1ZBxeZlRU9XHOs1GxN4Cc7dSw4GXVflQHwCi/SRbB9y0V7
 xSaqB/ok12FokYq4kUa6bjzUdERxaJNzPjySsWyd1FsmALl5qe2HH9y9MDYBSg9m
 YosVmJ1bZCeYF+iRCktoKEwnZmrDsnrtK3SjTmkFt1BPuvMDj6rmIf1FKhJXFNDA
 XNsEZg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2spa4uv0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:04:33 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso2723890eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183873; x=1791788673;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PsDTcz6+5glb5rywMAXEdZ3tLUxJfOqcDIdJ3hpAV8A=;
 b=LFBk+DmhqxJU1/iL6zqFFye1MT9u02JXXhwAGoYLXetd6GFBVAF3bp7vu0mSPSdUQr
 5SD5ypyU8gy23fdGBY/iL2KteBxaYyQZoOlz+Wixy6Ujz6hSubcFI/Cg7F38yAMyHUeN
 Tgbf0og5BU+uGOu34YDLnwkuk5DrjH/p5D3+2MD1d48MRfar9UBIebDsnREtsbFryULy
 ekXBX7MHhhJIVT7lTq3j2RbtN/P6WhIRTE1t3nSMjG4DP6ACl9SBRF/h8Bmp37N6a7yG
 MKpMR0Cv33oZ/hsJ10S6HduAueyDOkZETFsBycQvxjG3RbJjcWLUsbZRbGaORYBOOzYq
 m71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183873; x=1791788673;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PsDTcz6+5glb5rywMAXEdZ3tLUxJfOqcDIdJ3hpAV8A=;
 b=BFJjh0jNMGK9rTlZJzjl6x9mrpzNNi932mQOd/0Q1JD87u+Jx2EjkInIrwee2Tz4vV
 3EzhyDNlRx2utdkaX/0WmBAyoCZ4KEtM2/n8DHQEVPFaWWQutyN730sDAQ9jj2ivlR7o
 wkaYJmOT7ySSNYRascGaA3XpK11cC3L+7h9WGFBB8bielxgrlU1kCCXHZcVkHn1I7prV
 ecfrq7yfZ5NsCAahmEVxHluAQvrXVhkJ62fHg6/+h7lmTF+kJ+jsdWvZm3y5252ekG3W
 J7QEdv6qNBZ+YpmGXBwqvUWicdkG/D/rksTnQEKLVValWf1H+C0wDVS95ruE3JDFdJ97
 kVig==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4QsqTBSaXz0FgvE6+de+b25+BU46EE+GQdPE88LjV0xozqp1CvAOyhwEx6DOJBnG1iwPRyuE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kEninFmj1VGgrdq9NrT0XStxxtSlIElE1ab3J+6wYEODgpGWxR
 +LUHVkw5doVStKynrOT+72jffXMHmfueief444lmnMVv2QPADMeMgwAsXQvJVCsQl2I9C0I+YfD
 BiO3egGxkqluxZCOkglqlu+RjpSZJIiU+UKS4mbPE5yJRYGnrZtPkGKhiSKhPfcaQdlW0F0U=
X-Gm-Gg: AYBFou31kmk21IAAl26igGOw7MlkjJsdngmOWFHV20XmXy1WDRLLdUg8pa6ifKR9Kaz
 0OucziHcJmZA22Kimmwdnhfah+Q4LhRLwxVbB5LkzBnfFT0PmA+dj7ZmFY57wyf9OknT1bbJqlf
 qYGJ6wH2oUa0Omv7DBQECuyhUlf0bKvoo/4rs0p641WkUGVZ4lkLsKE4ivsatCpzHrwsTeRUp+p
 pQHIs4sA23i9Gva+7BNKOrz9rTTbMKk1gS+TaX74AP3CAIiasBsJX+yn/rcnrC6bEe1sW+Vu6tM
 qzOVcH8yN+WpOYCJHhmIlDCSQvxTd3Sf6/ljlG+KS0EEj9F+ff2bH/ktAJUeJlSPZyRJfSBZWU8
 BsAYTcQ1Nzhpu4n/u5Z5ChSIdhZgkrSzPJSmiciF6yqMZXCT3dodO2/vMT5ATxFlFf9pKLEVqC4
 Z0FqocrbKQtdNzU2f2Q2MXAq702e6z
X-Received: by 2002:a05:7300:e9c4:20b0:351:1e72:7470 with SMTP id
 5a478bee46e88-3511e727a9cmr7260517eec.13.1791183872519; 
 Mon, 05 Oct 2026 00:04:32 -0700 (PDT)
X-Received: by 2002:a05:7300:e9c4:20b0:351:1e72:7470 with SMTP id
 5a478bee46e88-3511e727a9cmr7260476eec.13.1791183871969; 
 Mon, 05 Oct 2026 00:04:31 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127160107sm9797561eec.11.2026.10.05.00.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:04:31 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:32:29 +0530
Subject: [PATCH RESEND v10 13/15] mach-snapdragon: spl: ipq5210: Add SPL
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-spl-v10-13-c4ca29bf27ed@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX1eFR0YhsKp52
 oMT03597U/aIsjCEqvJ/55G8Kqs5scsxpll+Ca4TAlE/5s8gpluRrErADhvW0hZx9TL/sbTMOGR
 EEN+J4RlONY4Nygm7USQ5g9xszNwk+dR598BeCeMOLkbUnSQ2d3BP5SeBHCNi0dVpmfq02iCZUS
 SFy0A387Lt3Dtn6RgkEmcmq7EDrv0yjpvcQ+6WCn5HS8K3YpXdqnhrL+jydU4Hf6XeN9ZeZ4gLi
 vuwIeXd66pB9ZR/UY5EZinzzd4XEly6Jro5yQ2jzCrLKxuDlDivhNyitC2AkCrU85RMcyKLHsdx
 mREXrIBwEVb+mVmQAT9HIpLr3eEgLZ2/x7fEtkFp6TfEoGKHpiifE5CjR3xUFVR5Y163QwVbiKg
 aiOqG6wskrAIaGOa8DvJ7pbot3svEPagQ5oB+Yn/qOQv2vb233E+ufX4apKhrsjKL19ThbUHzOD
 hrngjDlfEe4hQXAV/jg==
X-Authority-Analysis: v=2.4 cv=b7MncdGx c=1 sm=1 tr=0 ts=6ac34c01 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=-zc8TOuOcBEM41oa4wwA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: vsPNdiWJ3uoiJA_53_l1VVV6QwYQRwLo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX9SliKtCb5m4K
 b2HYGUbUHFW9iZrxtCuPIdRqzG62JB0EDPvpLIU1AT6FdY7OLDiRYlvDVbklbBGvIJOgh+Q0PzF
 l2/cwQqVVnyx/ViJhl5vI52mm7wvZL8=
X-Proofpoint-GUID: vsPNdiWJ3uoiJA_53_l1VVV6QwYQRwLo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

This patch adds the basic board init routines that invoke the common and
mach-snapdragon specific SPL frameworks to proceed with the hand over from
boot rom to the next stage i.e. U-Boot proper. This also provides the
linker script to generate the SPL image in the format expected by the boot
rom.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c            |  2 +
 arch/arm/mach-snapdragon/include/mach/spl.h     | 13 ++++
 board/qualcomm/ipq5210/Makefile                 |  3 +
 board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds | 18 +++++
 board/qualcomm/ipq5210/spl-ipq5210.c            | 99 +++++++++++++++++++++++++
 include/configs/ipq5210.h                       | 11 +++
 6 files changed, 146 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 2655803b31e..3293eab8f81 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -12,6 +12,8 @@
 #include <spl.h>
 #include <soc/qcom/smem.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 /* in SPL, we always use internal DT */
 int __weak board_fdt_blob_setup(void **fdtp)
 {
diff --git a/arch/arm/mach-snapdragon/include/mach/spl.h b/arch/arm/mach-snapdragon/include/mach/spl.h
new file mode 100644
index 00000000000..50cc8dc4e8f
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/spl.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __SPL_H__
+#define __SPL_H__
+
+void qcom_spl_malloc_init_f(void);
+int qcom_spl_loader_pre_ddr(u8 boot_device);
+void qcom_spl_error_handler(void *arg);
+
+#endif /* __SPL_H__ */
diff --git a/board/qualcomm/ipq5210/Makefile b/board/qualcomm/ipq5210/Makefile
new file mode 100644
index 00000000000..d808c106524
--- /dev/null
+++ b/board/qualcomm/ipq5210/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SPL) := spl-ipq5210.o
diff --git a/board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds b/board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds
new file mode 100644
index 00000000000..f0ced6765da
--- /dev/null
+++ b/board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds
@@ -0,0 +1,18 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+PHDRS {
+	ptype PT_LOAD FLAGS(0x7);
+}
+
+ENTRY(_entry)
+
+SECTIONS {
+	. = CONFIG_PLATFORM_ELFENTRY;
+	_entry = . ;
+	data : {
+		*(.data)
+		. = ALIGN(4);
+	} :ptype
+}
diff --git a/board/qualcomm/ipq5210/spl-ipq5210.c b/board/qualcomm/ipq5210/spl-ipq5210.c
new file mode 100644
index 00000000000..5fc42e64c11
--- /dev/null
+++ b/board/qualcomm/ipq5210/spl-ipq5210.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <hang.h>
+#include <cpu_func.h>
+#include <event.h>
+#include <init.h>
+#include <image.h>
+#include <linux/string.h>
+#include <spl.h>
+#include <spl_load.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/sections.h>
+#include <soc/qcom/smem.h>
+#include <atf_common.h>
+#include <linux/err.h>
+#include <dm/device-internal.h>
+#include <part.h>
+#include <blk.h>
+#include <dm/uclass.h>
+#include <mach/qclib.h>
+#include <mach/spl.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define QCCONFIG			"qc_config"
+
+/**
+ * qcom_spl_soc_qclib_override() - Populate ipq5210-specific interface table
+ *				    entries.
+ * @table:	Pointer to the QCLIB interface table being built.
+ * @fit:	Pointer to the FIT image blob.
+ * @images_node: FIT "images" node offset.
+ *
+ * Appends the "qc_config" entry and a placeholder "qcsdi" entry, filled in by QCLIB itself.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_soc_qclib_override(struct interface_table *table,
+				const void *fit, int images_node)
+{
+	int ret;
+	int entry_idx;
+	int qcconfig_node;
+
+	qcconfig_node = fdt_subnode_offset(fit, images_node, "qcconfig_1");
+	if (qcconfig_node < 0) {
+		pr_err("Failed to find qcconfig_1 node in FIT\n");
+		return -ENOENT;
+	}
+
+	entry_idx = table->num_entries;
+	memcpy(table->if_table_entries[entry_idx].entry_name,
+	       QCCONFIG, strlen(QCCONFIG));
+
+	ret = qcom_spl_get_fit_img_entry_point((void *)fit, qcconfig_node,
+					       &table->if_table_entries[entry_idx].address);
+	if (ret) {
+		pr_err("Failed to get qcconfig_1 entry point (%d)\n", ret);
+		return ret;
+	}
+	table->if_table_entries[entry_idx].attributes = 0;
+	table->num_entries = entry_idx + 1;
+
+	entry_idx++;
+	memcpy(table->if_table_entries[entry_idx].entry_name,
+	       QCSDI, strlen(QCSDI));
+	table->if_table_entries[entry_idx].address = 0;
+	table->if_table_entries[entry_idx].attributes = 0;
+	table->num_entries = entry_idx + 1;
+
+	return 0;
+}
+
+/**
+ * qcom_spl_soc_post_qclib_routine() - Cache the QCSDI address after QCLIB
+ *					returns.
+ * @if_tbl:	Pointer to the QCLIB interface table, populated by QCLIB.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_soc_post_qclib_routine(struct interface_table *if_tbl)
+{
+	int ret;
+	struct interface_table_entry qcsdi_entry;
+
+	ret = qcom_spl_get_iftbl_entry_by_name(if_tbl, QCSDI, &qcsdi_entry);
+	if (ret) {
+		pr_err("Failed to get QCSDI entry from interface table (%d)\n", ret);
+		return ret;
+	}
+
+	qclib_set_qcsdi_address(qcsdi_entry.address);
+	pr_info("QCSDI address: 0x%llx\n", qcsdi_entry.address);
+
+	return 0;
+}
diff --git a/include/configs/ipq5210.h b/include/configs/ipq5210.h
new file mode 100644
index 00000000000..5cbf838af82
--- /dev/null
+++ b/include/configs/ipq5210.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __CONFIGS_IPQ5210_H
+#define __CONFIGS_IPQ5210_H
+
+#include <linux/sizes.h>
+
+#endif

-- 
2.34.1

