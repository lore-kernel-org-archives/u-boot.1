Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DC3CCF2C4
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 20:51:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FAA2406CC;
	Sun, 18 Oct 2026 20:51:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N7x8eVflbpOt; Sun, 18 Oct 2026 20:51:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 538A3406CE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792356676;
	b=cyTYmSvEJdHSxX59JweSQsycSRdZpHS68w2K5RJhl10hrDfDv7lTotyAg5fRiopwwgGE
	 ixuPt03GDfJYgEkEvOwTHcb4As8CH4+kl2eUbhQU/hvZt9WnSzk8klfWkBrRGkDN92zJD
	 FFGNWmVR46yVBdbhWsG9Ha3K+J9fozYn0Ed/iHJ07Bcmov3mOCiAyZFh5GKp7XefVVbhM
	 PWQhg8lFVuhuA1O787AVq/xOwnAmJr2FoFr5ZjQJi4CyxVRMVnFLIvPtPLic43/aUni/Q
	 9qHYKiVr2teDAUEwOexi+AdazJtan5+DC2yW96gis9WY0qanU4MJaq6GK2tV1d1pZDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792356676;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sfc1yaW7l2XcjneL5IvZceBD2edYdM8XVa/4Y/SuReM=;
	b=EU0/NgUuVHD9qWle4WEykw2kqqQxvdXX4IhF0wYQ9E9KkJIPMKN6dTR0IBOt7GHGItyA
	 158PwSlj3vYTj+vtrOV0m1NHHbzmRQ4nfccm9XxFFbRspbtab72F70DyyIR4UXlvi9liX
	 8l0XLUExht0tbTzlwJN2rswHYcUSo3NurkUxR2+3bINvoCwuJ1bM35qypFt1jcPmZbvmJ
	 9AfZ4PmqqrMdyMfisbQ23pCIEvToWkjIXFYRJqNLVtDKtsdiPWx+Rou1hMO/NF5Cc5Wp6
	 bDs/iJNHFIJlLccJVZzxbbAmmmJsNwcmMefoZ9dJomwjizOLO65OuHHGaQyPWVms6rw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792356676;
	bh=sfc1yaW7l2XcjneL5IvZceBD2edYdM8XVa/4Y/SuReM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l9zETkJGUtihFnlabPwlTeHEugRImPUq2g3cPdIkZH+r+pZi8CO9YDd66bYw8riyP
	 jyL8BRgG0vWrmxXXuU7RiQUIJqQu4RJJIyuWIAfx47uDpyOtnGqIn1FxqRMQA8jZj5
	 WZLioWvJw5GeoFlyDVRPKyqBODItKoDMbmsbzIqBlTDwzvWenFGQ0qEPJPw8UnNci2
	 p0xW9SbfXxsM9cNirVVraG8n9oPol/bbOjZukNmjpftglg/KFMEy+XGZYBUgSGQJmM
	 Fsh+Tzs4Gsr4lu/qKAuQ61iy6uqNMFP63uAXr4h1ytfmCYd3Vx+4powFbGYVxwervh
	 FjlJ6w085lfOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 538A3406CE;
	Sun, 18 Oct 2026 20:51:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C7BD72A8
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE5C240068
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dAl35F-wzgH4 for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 20:51:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B3BAE40049
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792356673;
 b=hb0eTRfb5FrJucE+jUakveldT+xTEmudThvzSJ2h/iMrnK4Nn7vd7YccgWSGua5p3Nw2
 MyzI4gIKZIev1pIe5UIv4f4h2ATe3xpxO/V7CfAk05hf92/gja8sXBtMH/xtgRDCNF6Xj
 lZbjd6VPyimSX2BRjFQ3ZODGUxIkJCLoFc1lW0dh5k8Aj820m/4c5l8X3ZH+p9pmXjtM3
 NoQCJU2ubNB1BWIMSDn5iSzl7UoibQGfVlVeuLNj8RwzzfsZHO5bmizsy6EdRiSidT74F
 JEdEZJcDjy9Iny32w0hWztScQaR562QvUxsYSBad6ZtIUGINQq4h4pHJU3mIuAY2ZaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792356673;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=sfc1yaW7l2XcjneL5IvZceBD2edYdM8XVa/4Y/SuReM=;
 b=EB4JFrgshbx6khj572DekisGcZTzdNWBO4b3iR2vuwItWrFM6kQ8vp0l54ySVWMM6bxd
 c1YHlL8Zuy51lTSJGt1PgKAcQ5psLtNF1OpzJ3MIvlysS/iXZsZfZpkavrY0HT+/eI4n1
 DWSFj12whz52dw70fUluKZOCobh6pxi9MjO2hc0nYMJSyXYko7/CRY/DtueXDiwdqAc6i
 uiEXGMiGuGnYdhj1/xLTMIBwPK/nYxeARicYG2yPots1T2nN8b/fPoXRZw3wIZTtXHRiN
 tUa8V/OBX/wCb0WUW27Zi3JYvc21cBy4Gzr9KehbiOFEduBHqepCE8fJN3fVbxJkQQw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=MlY0HBOs; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TKE6xSJI; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=MlY0HBOs; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TKE6xSJI
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B3BAE40049
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:12 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69IKBF9B3381004
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=sfc1yaW7l2X
 cjneL5IvZceBD2edYdM8XVa/4Y/SuReM=; b=MlY0HBOsozwacpNdgO0lvjgCvWF
 /V2CZpOFd0dKHchrLuWIJuqeDiruml9VvSjzn6Dxn9xiUA5FocqHHNdoaLW3FAYB
 kMHJZKNaA0DvJ6ob/nM+oNeWmT+R1gdMqV5Nqfh7EmpesCde1Y7ju5z8LFoydQDz
 TYMitjoUF4Qy3KFS6YahR9I3fW7jpqR36nLPQvFV3Q8LOD+MDKJ5JGly/oDoyB01
 FJ+qtQ36JyBivFHF0kUxFzxzILY+svIRt6Lmp3+y0DUX1U4QLz0x9XvXKYQHxPT7
 OvoSKQVicwe2cYaNxB0+fgmCu4vKCa1ktGV4HRMYpSjoQwHxbRq+5msU+Tw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc26k3rhc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934963b2bc0so303265585a.3
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792356671; x=1792961471;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sfc1yaW7l2XcjneL5IvZceBD2edYdM8XVa/4Y/SuReM=;
 b=TKE6xSJIN6jbOYmZuXWWrTyfjGrxoJNhOyVCP964kl/K6rCRl0PSfoOMP0GxwaztTe
 OXtfsnSAQyyu8UdEfs1H4FMCDnsykarURUpVdN1fobq2mXGu63sK6dE6XxGxLs7WloPd
 s5QFD72+gbLsc5s+xOYyh19y8fF29fvlYjZs6qqLUqY4FM35iLxGwQuAVOPw0A9Lt50U
 3O1JzbsBjABTY2s057Q2cYMkBpZTt5THseL3uexD7vUWvSl09vpwGt5BuFBh5HtmLiPw
 4jZh5g4ZJcLfELJryeOz7UXM3Ae14E6uk0I+zQqNWdeoweMAwXZkWkVn2sSRznvK8KGc
 RTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792356671; x=1792961471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sfc1yaW7l2XcjneL5IvZceBD2edYdM8XVa/4Y/SuReM=;
 b=wkDmAXgGkpx6X4E8sapWf5uQuMg+ByToira2zeh/KvLBKOaghgkC9fRHCE7lkOClm/
 Uo6/MmcTOMUxm55DB3z4tYeX1sTT6qW9nwyx0g5S3PYcaH47yMBpCh03hYDxoTL1VAsh
 lQ7CDYeiwqzN9GbJdRaWKRT0ZXGdPAKWec4EHsj34nEuddOCkNF2Fhzj0FZjbFgsmzny
 k8vCcMgfrSa3WaijBLME8ga+mWbBp0Neg05/h2IniNclM1S86FXLowRqDk+VfaGq1IL/
 alkpcmlAqe5atEUaiwaL2qMK9ObhnuHNOdGfFysjdtq7O0xRctrC9f7OjhYkvF3++tmM
 +fpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7YaFawjOEC9KoIjHKqkXOuq1W4fvZAQKq6X3lxKRLUVfZn6KFSTh0sFT8PtJwOmE7Yvwzkic=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLNywb1w3YBGdPoXecS1p/m4mb0pu272bGGVzkoCL/e6U7vPFZw
 S49E60WH0zMsistrQL0+mktOme2xoGmTBCQ124730f0NV4kEIPU484OtkfUh7b8m9pzo2m1/ZUC
 X1lVnYlr5ewFkaWBSahHp6HQ/q5ZzhmqlD/+pi9hsEdmy8ZDixC+bh2TYwJhMUCvyul2tvbE=
X-Gm-Gg: AYBFou0/ABqWGe6a1uwjDfUpVhYA35reOloHR0bt5QZgCsZ7dZOwRNw1nQNMz3P0ENp
 1vXRvDtd/cHIngkYAt+G40TfSkNnOsZaGuCo4/eL0GQ9ZPB4GggcwspZdvvvnIp5D82DIdL+6x7
 k1OlQB4WHta95Rh8trb3SlsV5pVupR/oRWOmLY7qG3o0lWxY77iqSgFd0Q9HbMXlWhyXFvaYVhq
 ih2umpvjhgL28TqE1gvVSSCILvhg+s1FLnTknbWb55yPEKY/YdjcvcGAvdGSERcb3NmeXrC2F9M
 B27L31rstWElyEX0yCyetJ+7MLu0lCfhESMBtdrsnCKbiI20TVGw827h692F7RoZqlWOEqbQUt6
 70wtA3XAdraNOL4+4hsPMYEXLfwtQSQF8UJLHqRxH8Tue
X-Received: by 2002:a05:620a:29d5:b0:93e:5016:e3a6 with SMTP id
 af79cd13be357-93f29cf1578mr1021531785a.26.1792356670597; 
 Sun, 18 Oct 2026 13:51:10 -0700 (PDT)
X-Received: by 2002:a05:620a:29d5:b0:93e:5016:e3a6 with SMTP id
 af79cd13be357-93f29cf1578mr1021529485a.26.1792356670105; 
 Sun, 18 Oct 2026 13:51:10 -0700 (PDT)
Received: from trex (5.red-79-144-193.dynamicip.rima-tde.net. [79.144.193.5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d756ce69sm148645925e9.4.2026.10.18.13.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 13:51:09 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, trini@konsulko.com,
 neil.armstrong@linaro.org, ilias.apalodimas@linaro.org,
 jens.wiklander@oss.qualcomm.com, sumit.garg@oss.qualcomm.com,
 dlechner@baylibre.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 tanmay.kathpalia@altera.com, bhupesh.linux@gmail.com, n-francis@ti.com,
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com,
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org
Cc: stanleyjhu@google.com, Macpaul.Lin@mediatek.com,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 2/6] ufs: surface sense data from ufs_scsi_exec()
Date: Sun, 18 Oct 2026 22:50:52 +0200
Message-ID: <20261018205101.2362593-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018205101.2362593-1-jorge.ramirez@oss.qualcomm.com>
References: <20261018205101.2362593-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA4MyBTYWx0ZWRfXwUFAN6/HzMBN
 ZGR9KJP5XC2oOLZpeNmE8r97th0f2dkHwL9mvgpNavcqKMaP8jaa7NPdnEGo40qCO9ZSun/Gz4M
 YXRAUHqHrHDhx1ON+yUwM6eTECmmcNkcOIgjrxSpMLvBomLBX+S+4BN0rKA0UW6jtW3FwCbo5eu
 LZMiCaQ14tl3GyX8Xx4WQvbzv7Jj+3wRCRSJKgp6/8KtRHNJeNgJWOk5nw39A6UX2UjpiNR8TfU
 0ftM1OEz86x7qB/dy9M2++pOvM4tUH275D4D8wsri64oYHO17hDSWO3yQg2WBSIPoNQRwTuhMDH
 Q+GtGPkMWCfZ2kWIq3W/J+DG+D/Yy0dbwYVvGGMiFOMpoX896TKHC4uyj3LAHvRI8gpyi2DTgML
 fa5DxKiqaVRONDy1Rx7qUUja+qDbtHz3uAqB8BEFOrs8BXr3IlC8nrQ2jT2gPYko0t8imdjkSKW
 xUmYJ7acHZqucRDoS4A==
X-Proofpoint-GUID: fKoixaTPQfLN1SqoJ1M2g3QXExa-KK0z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA4MyBTYWx0ZWRfX/iVAJTIkXMF6
 ffVKR95Xt1JYvJDYSj2ybgVwk+0rGURP1gi5Dp/UZiYlv5jeS31QesotrfjxD5ezTf/pUMvkF3C
 UNW61WisNfpJBQomMVxbQMRftyV54gQ=
X-Proofpoint-ORIG-GUID: fKoixaTPQfLN1SqoJ1M2g3QXExa-KK0z
X-Authority-Analysis: v=2.4 cv=Cowq4X4D c=1 sm=1 tr=0 ts=6ad5313f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nno+U714v6U58lXnMUU6PQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=OKVFKRVrtuEbveMjFjUA:9 a=O8hF6Hzn-FEA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180083
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

On a CHECK CONDITION the UFS device returns SCSI sense data inline in the
RESPONSE UPIU, but ufs_scsi_exec() discarded it and reported every
failure as a bare -EINVAL, leaving callers unable to tell a transient
condition such as a power-on UNIT ATTENTION from a hard error.

Preserve the sense data and SCSI status in the scsi_cmd. No caller
inspects them yet, so behaviour is unchanged.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs-uclass.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 21aed9f97bd..3d96a05281c 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1657,6 +1657,22 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 	ufshcd_cache_flush(req_desc, sizeof(*req_desc));
 }
 
+/*
+ * On a CHECK CONDITION the sense data is returned inline in the RESPONSE
+ * UPIU; copy it into the SCSI command so callers can inspect the sense key
+ * (for example to tell a transient UNIT ATTENTION from a hard error).
+ */
+static void ufs_scsi_copy_sense(struct ufs_hba *hba, struct scsi_cmd *pccb)
+{
+	u16 len = be16_to_cpu(hba->ucd_rsp_ptr->sr.sense_data_len);
+
+	if (len > RESPONSE_UPIU_SENSE_DATA_LENGTH)
+		len = RESPONSE_UPIU_SENSE_DATA_LENGTH;
+
+	memcpy(pccb->sense_buf, hba->ucd_rsp_ptr->sr.sense_data, len);
+	pccb->sensedatalen = len;
+}
+
 static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
 {
 	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
@@ -1664,6 +1680,9 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
 	int ocs, result = 0;
 	u8 scsi_status;
 
+	pccb->status = 0;
+	pccb->sensedatalen = 0;
+
 	ufshcd_prepare_req_desc_hdr(hba, &upiu_flags, pccb->dma_dir);
 	ufshcd_prepare_utp_scsi_cmd_upiu(hba, pccb, upiu_flags);
 	prepare_prdt_table(hba, pccb);
@@ -1683,8 +1702,12 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
 			result = ufshcd_get_rsp_upiu_result(hba->ucd_rsp_ptr);
 
 			scsi_status = result & MASK_SCSI_STATUS;
-			if (scsi_status)
+			if (scsi_status) {
+				pccb->status = scsi_status;
+				if (scsi_status == S_CHECK_COND)
+					ufs_scsi_copy_sense(hba, pccb);
 				return -EINVAL;
+			}
 
 			break;
 		case UPIU_TRANSACTION_REJECT_UPIU:
-- 
2.54.0

