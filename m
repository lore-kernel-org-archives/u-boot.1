Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE5BC98318
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 02:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72D4B40B30;
	Fri, 25 Sep 2026 02:41:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LQ4YYx-HB4sn; Fri, 25 Sep 2026 02:41:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AB15840B39
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790304107;
	b=DjrsUT3LxuiL+PHo+XYkSAmDJzqPAaArQgc24HFV86xF0qQp8Kg3t//01rOM5Yd3Rnm7
	 zkDsOnL6fyCw18oCMZImPFTijxWp/rhqNJyRVi5gtxRWUnCX463Jhqy8i1vBm+qNG24rb
	 jdwxMzKPrpvVK97O4b/fDclfFEdfUuVMs4dt2VBH2ilCZxQUNrxzWtbki43bKhWEK7JA0
	 nGfBvVtye8BmqlIRMkCaOb/9Gn10bS44UfmUnK5TobwRIMDt0QtgMLk0OSFeM+qTwhv98
	 Hji4BCLonJmx2hDuQ9qwI9aUsiW1p9369qOTTFeuiq6iTTZ0RSoRC4Wtr7jP/pUKluQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790304107;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bJcmc5i0JVGgrsPE5MC9mWKYxu58/IRt///JdOsZses=;
	b=Jdsd1dDNMm8rtMl6L5aTSIeK8nzK0p7A9LWQ4Hqp+fzgXo2m6pEh159leUDNIhpSNU64
	 d7UEYJrxSZbiLXXxDeJ3q6YMTRYH23x9HB+hSRMnimCO0R0xlJisOLmccp2eZgrpCfXh8
	 XzBlaLwAd/TIne3fH+B5B0k8wnlkYJbQRJG6FUd1++J3bJ7i/kzaIqmOd2dttLn3bappf
	 rlzscdslb30k+A64wltHxI7l9de5bOXItIHGgZrjf22sXZdmDM+ulaj/taMlVk7JtodT3
	 1Wkr7PCx3pwUz+oBdu1PBDw96BHYmSWFVlLdAMylMVB2VbCxpRPo/hy7PoVeqWbbtqA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VlBUykZ8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HQLwS3DJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790304107;
	bh=bJcmc5i0JVGgrsPE5MC9mWKYxu58/IRt///JdOsZses=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EQkkuwFMUookDTJHxjWV32s0r8s7+eEDRrke4sWpVYSipd7uw3QaMYx2+JhKSA7sa
	 HNkv83PsaqCK71htbnfG5ciWKXaf9Ce3kI47vmsd+YBUKEIvvQ1y96HdntoGSxGnEo
	 2FxCNYYP5hd/r1/xbxIDTGJEZJDx32rmxFG6yMtRXfPjMKJdi8sLIODaQojzbYQJdD
	 8z6K1K9wrQGmCA1tShBM4y9DIob5wotnWCkrGmDFYKtevnebaRSIRLE+Lf+zmXEXoS
	 bqZFRMvEZX950xYFvpkJlPgnBzli7W1v6YkmRu9Pntj7zdJdySleXiKHWxXzCcIJc7
	 aa+G7PkPkPuTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB15840B39;
	Fri, 25 Sep 2026 02:41:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CFCD1A32
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B659340AF5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id StGwxF15Y229 for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 23:38:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 316C740AFB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790293093;
 b=SEZ8p04aelFF/i7c7Y3dg40f7wmoxmPRJCxplwCrofNXqmU8uVFP5FcjiDvk46fNencQ
 P6rqvEdBknxsgP89zKRTZmj/6MuPAhrSvP1bKG98TPvWXDK1YT7GLkXiGNom4ramZYYEb
 1ChQaAu1QdwFg6QdaKfeu5yrAS6lGO2BIAUI7xC/wSH/mcSf7a+GZZL+cqMo31L4uK+sw
 YUb3rEVPZ4jWRKFhPmVEbZF0y5tHwTFQnDgXImMhS8O2FK2NLHw+WcRUHPQ4VnlQLR8no
 KGkCcbv0UROjatjglYhyA7DRKZ1TQD2j9N/eM7q+WtonXHry93rpjsCt1dMcd4SOcbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790293093;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=bJcmc5i0JVGgrsPE5MC9mWKYxu58/IRt///JdOsZses=;
 b=JoCUqkYFo4PpGx4TUXu/rsjtT+FMfV2eYQxAkOBzoLeOEp58cY5egh+3xToD9FMFXExN
 Mw6+JtqaIaPJZhW5zoigTKM+FpMxDcyVAhmAvvB77qxknogm+CufGgGlr/TvWzba23zvy
 JxsG0rl9DPQfjhOphZ2xkd4muEPluYEyUdebDoeIPT/bN1nvXJsArfPdM6ahtAkK7w96A
 QxyUubRAGrRe2vxkNaszhnuABylD8naMIXkeqs7IS4F7BOHzLZsWaVlIu7iFNttmKTUwW
 2PRv3bLLYH+/OhzVnIH7NcrqNSFhzlfSYsggKJS9SMD8F15yM10SZDWANai8v7RXvww==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=VlBUykZ8; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HQLwS3DJ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=VlBUykZ8; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HQLwS3DJ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 316C740AFB
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:13 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OMPswR430588
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bJcmc5i0JVGgrsPE5MC9mWKYxu58/IRt///JdOsZses=; b=VlBUykZ8pANjhf85
 spnWz0vYODOynOJYrhLoez1IsCpOqwKOq265DxKy0CZtxf5yE7BjwhPsavnOv8wy
 MeQN5r/Qh9lo3R56SJLXBizJk3y2tEY+bmbe99q+dTgpB6rI0Ba3u+IQLgGinkbs
 4+idOEsrzZSHsnE4b5mUx052o/VB+7pb97Tuj7DBEYB/ZwgGCrTSsfnv7MuyN6Et
 8+yfNcqX1OU6PzYiZpmQ8Lbgr63WnaBoy8JIUkdTy5fZtBlfm3C1PPgmr6wd4P7d
 w2oyxyrmox4183Ny+EyTsXB/YwNW3Sut4PrFKzW7DYurSL0MsYBKzuU2Nwb8u31+
 EgVk+w==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw874h8w1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:09 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-879b1d03d5fso6022477b3.0
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790293089; x=1790897889;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bJcmc5i0JVGgrsPE5MC9mWKYxu58/IRt///JdOsZses=;
 b=HQLwS3DJKfUK3+AOGpDUIG1U3+QdE/GJfWSnJh9IkcCVeB+krEgNm89kLkvUUeeNGz
 L41K6+XsQHhWqaJBa4HBDDBE1aVVnMN73e0AqBBGzXNFHwK0CFH4ZuMW6Dfz8/nSwDmf
 RBxyyeTs26rG38zVF3WaJOeAbmarHIXZa57FGHQu+BvR+rTkACSch87ERJJm34l002Ou
 wHlpGAfUkSw+Pd/atozAejddiKgUigybvOJ8aG2kccbmz5CN/pMzkHIoM8pCz6aJY2Vq
 D0JW9tSSHHOVjrYqg+rMizIRFSaWRVCGCt+FhE2Cgw762KLowcKbluidQH9cI0056UsV
 ZdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790293089; x=1790897889;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bJcmc5i0JVGgrsPE5MC9mWKYxu58/IRt///JdOsZses=;
 b=QGpIckfOtqwH9Jz83gs8ug7US9h1D4CZoppdKQMWK6CFiMbWccoxCHC6sQPkb1yCXr
 5Hxao00AO+flPZpVdFyAi27YaN5eBayMG/A+MNd5fRkHSInOs/2+5fvjMYDwy7GCegsg
 E6yTg0kRbehPZN5qZgVRMtKpC1Kr3Z5WcAcN8DOAfUw8UZASg31I2+ezn7LWZabwpcF7
 2/e4iHb9VEjVfqgvz/PjoaW+3NRwWyelC34h2e7a1t2G7yza7Zo3SWa7k/GNAgc7fVlN
 vBq1cXoEpIJxPWBTPy0tr61Znh4mkYJD+7TzlW77WVOCuj5x0rIFS4wMRL2P6bMn/gGE
 nsmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+1Y5pS2sF0dMe38oOz14gWuBYTtpM5arjDrwbHmKfeUC4Lh+zYNF862PZUOytnjyhu+X8BSo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kgi5vXGSDvegyT3hSZqCUpntshNWS/VdOJ9VD95fV1hsaP51BF
 O7qvApkVWNuMs4laVNdHyVPK/qZRsSE1E+/20EQvUh3dMH7GmuxBT7rOfB6jMvqNqjioisiihuX
 9alLHphoUXJLWA9aSTa2vzuQAGhQkOm22/FGH6d0VRXadLCn/umbf+pVywGEcOiYVWnXzPuA4of
 y1GBY=
X-Gm-Gg: AYBFou1W5v+nCNmUaGxs8u8U+O3ozhHQVxq4vbdimfJ+Q1xG/ibd8rGP2TyTga8ZAE5
 NQgBM2XfM0oWRtlcKhgockBhLsUtS3/H+EnkQ97UngB3sKdhcsGO8qzDBmXUa1fTWUbFdyuH32j
 eltbif4fCHsl+Ip1huIWB9lUQZG+SJa/xxul5dXlk5HJrNLe0ZGfgL9sbCXG37QEi3t8f4OvxyA
 x54GL1kbKA1xo98jnvIb15TCXZp5rfZDi+jfb4zLjSrf97jQw4E68XQlyPioRFL5JETtV2mVYz3
 /2si68057LWOwYZ9QjJWfN9ZdqWXEfkD923JWp3TvCgv4e9AKT65dLXFl8CmPZ7YSsN6n/MJbYx
 u6lJAGbL8w6KyAxzKUxPk2ub7kL2Vr5jVpHpeMQOMTbDjQpYtcuE9Z39KHMpo2Nup8nZu414w
X-Received: by 2002:a05:690c:6893:b0:8a7:4207:64dc with SMTP id
 00721157ae682-8a74207776bmr14570677b3.63.1790293088505; 
 Thu, 24 Sep 2026 16:38:08 -0700 (PDT)
X-Received: by 2002:a05:690c:6893:b0:8a7:4207:64dc with SMTP id
 00721157ae682-8a74207776bmr14570607b3.63.1790293087904; 
 Thu, 24 Sep 2026 16:38:07 -0700 (PDT)
Received: from x2e.localdomain
 (108-208-224-205.lightspeed.gnbonc.sbcglobal.net. [108.208.224.205])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a860325fbesm3025817b3.5.2026.09.24.16.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 16:38:07 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 19:38:04 -0400
Subject: [PATCH 3/7] pinctrl: qcom: add QCS8300 TLMM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-monaco-ventuno-q-v1-3-290b6a4d10c0@oss.qualcomm.com>
References: <20260924-monaco-ventuno-q-v1-0-290b6a4d10c0@oss.qualcomm.com>
In-Reply-To: <20260924-monaco-ventuno-q-v1-0-290b6a4d10c0@oss.qualcomm.com>
To: Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
X-Mailer: b4 0.16.0
X-Proofpoint-ORIG-GUID: ml-OWFUD2mLeDcORWvfusTG5N6RT42ir
X-Authority-Analysis: v=2.4 cv=MI71C8Zl c=1 sm=1 tr=0 ts=6ab5b461 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=0QzwHjVCg53gEVBlFjMA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfX/AlM0fJM9Tqi
 I3Vrud6CJAXr423hNLzkUFjjqeJlRGzjy4adMt6R1qbeS06GTqFa89zCV/Z8lYexR+CgHGDRXoO
 oQxVusfHfwy4rQIMHpCVWtbTlymeLI537qqFkFVOKATDgcMftcf8B2s49EunEBnAdVjsoY3x4tv
 6+kYYhSg+JbI87gsvPofyGPIdMJ8JBi4asQJFXpPaON+Y/Lpm7JLTnjXB3a28xDN055wPso3DBN
 CLvZSpTSzYIc6JP5KDZ6VSoDkxLmWhnhiC7GfMgzgAihAZh0NOXOnp7pq7YaX1nEGd45uC2n4dS
 ZwDNxusenD/g9B5P/vRTnkLsnWv3SgcfjcxhVT5krcdGhfklLaPUp0jElcdQKo78Opgzn93hSbi
 QCRv0Rcvb7+mit2sOyDSN9XuUWKMHIoroNMH2WoNwPl0/lb7Nr6Z/JSTbXMik554gHqBMK2zKHU
 9k2n1zWcH7PmGtJpBZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfX4ZViHBC1PL6V
 5XAz7vvDuoXvzB14qkLZRFMdvh1qjdhTGtVum7pWUFh6ELbjDVzNNueFdkIbh+LMhM1/3OXSPnh
 jAbBiVZo4+CrCo9pCGraHjnLLSI+il4=
X-Proofpoint-GUID: ml-OWFUD2mLeDcORWvfusTG5N6RT42ir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1011 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240096
X-Mailman-Approved-At: Fri, 25 Sep 2026 02:41:35 +0000
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

U-Boot has no pin controller driver for QCS8300, so every device with
pin states in the device tree fails to look them up and keeps what the
boot firmware configured, and gpio-keys cannot probe:

  serial_msm_geni serial@99c000: pinctrl_select_state_full: ... err=-19
  msm_sdc mmc@87c4000: pinctrl_select_state_full: ... err=-19
  Button button-home failed to probe

Add a TLMM driver for the 133 GPIOs and the UFS reset and SDC1 pins,
with the pin functions and groups of the Linux QCS8300 driver. A
function's mux value differs between pins (qup0_se0 is function 1 on
GPIO 17 and function 2 on GPIO 19), so the driver keeps the full
per-pin function table.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-qcs8300.c | 531 +++++++++++++++++++++++++++++++++
 3 files changed, 540 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 7dd3782c14..fa0385f159 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -86,6 +86,14 @@ config PINCTRL_QCOM_QCS615
 	  Say Y here to enable support for pinctrl on the Snapdragon QCS615 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_QCS8300
+	bool "Qualcomm QCS8300 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon QCS8300 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_SA8775P
 	bool "Qualcomm SA8775P Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index a7a9ad0356..97d59f5eac 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_PINCTRL_QCOM_MILOS) += pinctrl-milos.o
 obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS615) += pinctrl-qcs615.o
+obj-$(CONFIG_PINCTRL_QCOM_QCS8300) += pinctrl-qcs8300.o
 obj-$(CONFIG_PINCTRL_QCOM_SA8775P) += pinctrl-sa8775p.o
 obj-$(CONFIG_PINCTRL_QCOM_SC7180) += pinctrl-sc7180.o
 obj-$(CONFIG_PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
diff --git a/drivers/pinctrl/qcom/pinctrl-qcs8300.c b/drivers/pinctrl/qcom/pinctrl-qcs8300.c
new file mode 100644
index 0000000000..6abf69bede
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-qcs8300.c
@@ -0,0 +1,531 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm QCS8300 TLMM driver, with the pin groups of the Linux driver.
+ *
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+typedef unsigned int msm_pin_function[12];
+
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11)\
+	{					        \
+		msm_mux_gpio, /* gpio mode */		\
+		msm_mux_##f1,				\
+		msm_mux_##f2,				\
+		msm_mux_##f3,				\
+		msm_mux_##f4,				\
+		msm_mux_##f5,				\
+		msm_mux_##f6,				\
+		msm_mux_##f7,				\
+		msm_mux_##f8,				\
+		msm_mux_##f9,				\
+		msm_mux_##f10,				\
+		msm_mux_##f11				\
+	}
+
+#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\
+	{						\
+		.name = pg_name,			\
+		.ctl_reg = ctl,				\
+		.io_reg = 0,				\
+		.pull_bit = pull,			\
+		.drv_bit = drv,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = -1,				\
+	}
+
+#define UFS_RESET(pg_name, ctl)			\
+	{					\
+		.name = pg_name,		\
+		.ctl_reg = ctl,			\
+		.io_reg = ctl + 0x4,		\
+		.pull_bit = 3,			\
+		.drv_bit = 0,			\
+		.oe_bit = -1,			\
+		.in_bit = -1,			\
+		.out_bit = 0,			\
+	}
+
+enum qcs8300_functions {
+	msm_mux_gpio,
+	msm_mux_aoss_cti,
+	msm_mux_atest_char,
+	msm_mux_atest_usb2,
+	msm_mux_audio_ref,
+	msm_mux_cam_mclk,
+	msm_mux_cci_async,
+	msm_mux_cci_i2c_scl,
+	msm_mux_cci_i2c_sda,
+	msm_mux_cci_timer,
+	msm_mux_cri_trng,
+	msm_mux_dbg_out,
+	msm_mux_ddr_bist,
+	msm_mux_ddr_pxi0,
+	msm_mux_ddr_pxi1,
+	msm_mux_ddr_pxi2,
+	msm_mux_ddr_pxi3,
+	msm_mux_edp0_hot,
+	msm_mux_edp0_lcd,
+	msm_mux_edp1_lcd,
+	msm_mux_egpio,
+	msm_mux_emac0_mcg0,
+	msm_mux_emac0_mcg1,
+	msm_mux_emac0_mcg2,
+	msm_mux_emac0_mcg3,
+	msm_mux_emac0_mdc,
+	msm_mux_emac0_mdio,
+	msm_mux_emac0_ptp_aux,
+	msm_mux_emac0_ptp_pps,
+	msm_mux_gcc_gp1,
+	msm_mux_gcc_gp2,
+	msm_mux_gcc_gp3,
+	msm_mux_gcc_gp4,
+	msm_mux_gcc_gp5,
+	msm_mux_hs0_mi2s,
+	msm_mux_hs1_mi2s,
+	msm_mux_hs2_mi2s,
+	msm_mux_ibi_i3c,
+	msm_mux_jitter_bist,
+	msm_mux_mdp0_vsync0,
+	msm_mux_mdp0_vsync1,
+	msm_mux_mdp0_vsync3,
+	msm_mux_mdp0_vsync6,
+	msm_mux_mdp0_vsync7,
+	msm_mux_mdp_vsync,
+	msm_mux_mi2s1_data0,
+	msm_mux_mi2s1_data1,
+	msm_mux_mi2s1_sck,
+	msm_mux_mi2s1_ws,
+	msm_mux_mi2s2_data0,
+	msm_mux_mi2s2_data1,
+	msm_mux_mi2s2_sck,
+	msm_mux_mi2s2_ws,
+	msm_mux_mi2s_mclk0,
+	msm_mux_mi2s_mclk1,
+	msm_mux_pcie0_clkreq,
+	msm_mux_pcie1_clkreq,
+	msm_mux_phase_flag,
+	msm_mux_pll_bist,
+	msm_mux_pll_clk,
+	msm_mux_prng_rosc0,
+	msm_mux_prng_rosc1,
+	msm_mux_prng_rosc2,
+	msm_mux_prng_rosc3,
+	msm_mux_qdss_cti,
+	msm_mux_qdss_gpio,
+	msm_mux_qup0_se0,
+	msm_mux_qup0_se1,
+	msm_mux_qup0_se2,
+	msm_mux_qup0_se3,
+	msm_mux_qup0_se4,
+	msm_mux_qup0_se5,
+	msm_mux_qup0_se6,
+	msm_mux_qup0_se7,
+	msm_mux_qup1_se0,
+	msm_mux_qup1_se1,
+	msm_mux_qup1_se2,
+	msm_mux_qup1_se3,
+	msm_mux_qup1_se4,
+	msm_mux_qup1_se5,
+	msm_mux_qup1_se6,
+	msm_mux_qup1_se7,
+	msm_mux_qup2_se0,
+	msm_mux_sailss_emac0,
+	msm_mux_sailss_ospi,
+	msm_mux_sgmii_phy,
+	msm_mux_tb_trig,
+	msm_mux_tgu_ch0,
+	msm_mux_tgu_ch1,
+	msm_mux_tgu_ch2,
+	msm_mux_tgu_ch3,
+	msm_mux_tsense_pwm1,
+	msm_mux_tsense_pwm2,
+	msm_mux_tsense_pwm3,
+	msm_mux_tsense_pwm4,
+	msm_mux_usb2phy_ac,
+	msm_mux_vsense_trigger,
+	msm_mux__,
+};
+
+#define MSM_PIN_FUNCTION(fname)				\
+	[msm_mux_##fname] = {#fname, msm_mux_##fname}
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	MSM_PIN_FUNCTION(gpio),
+	MSM_PIN_FUNCTION(aoss_cti),
+	MSM_PIN_FUNCTION(atest_char),
+	MSM_PIN_FUNCTION(atest_usb2),
+	MSM_PIN_FUNCTION(audio_ref),
+	MSM_PIN_FUNCTION(cam_mclk),
+	MSM_PIN_FUNCTION(cci_async),
+	MSM_PIN_FUNCTION(cci_i2c_scl),
+	MSM_PIN_FUNCTION(cci_i2c_sda),
+	MSM_PIN_FUNCTION(cci_timer),
+	MSM_PIN_FUNCTION(cri_trng),
+	MSM_PIN_FUNCTION(dbg_out),
+	MSM_PIN_FUNCTION(ddr_bist),
+	MSM_PIN_FUNCTION(ddr_pxi0),
+	MSM_PIN_FUNCTION(ddr_pxi1),
+	MSM_PIN_FUNCTION(ddr_pxi2),
+	MSM_PIN_FUNCTION(ddr_pxi3),
+	MSM_PIN_FUNCTION(edp0_hot),
+	MSM_PIN_FUNCTION(edp0_lcd),
+	MSM_PIN_FUNCTION(edp1_lcd),
+	MSM_PIN_FUNCTION(egpio),
+	MSM_PIN_FUNCTION(emac0_mcg0),
+	MSM_PIN_FUNCTION(emac0_mcg1),
+	MSM_PIN_FUNCTION(emac0_mcg2),
+	MSM_PIN_FUNCTION(emac0_mcg3),
+	MSM_PIN_FUNCTION(emac0_mdc),
+	MSM_PIN_FUNCTION(emac0_mdio),
+	MSM_PIN_FUNCTION(emac0_ptp_aux),
+	MSM_PIN_FUNCTION(emac0_ptp_pps),
+	MSM_PIN_FUNCTION(gcc_gp1),
+	MSM_PIN_FUNCTION(gcc_gp2),
+	MSM_PIN_FUNCTION(gcc_gp3),
+	MSM_PIN_FUNCTION(gcc_gp4),
+	MSM_PIN_FUNCTION(gcc_gp5),
+	MSM_PIN_FUNCTION(hs0_mi2s),
+	MSM_PIN_FUNCTION(hs1_mi2s),
+	MSM_PIN_FUNCTION(hs2_mi2s),
+	MSM_PIN_FUNCTION(ibi_i3c),
+	MSM_PIN_FUNCTION(jitter_bist),
+	MSM_PIN_FUNCTION(mdp0_vsync0),
+	MSM_PIN_FUNCTION(mdp0_vsync1),
+	MSM_PIN_FUNCTION(mdp0_vsync3),
+	MSM_PIN_FUNCTION(mdp0_vsync6),
+	MSM_PIN_FUNCTION(mdp0_vsync7),
+	MSM_PIN_FUNCTION(mdp_vsync),
+	MSM_PIN_FUNCTION(mi2s1_data0),
+	MSM_PIN_FUNCTION(mi2s1_data1),
+	MSM_PIN_FUNCTION(mi2s1_sck),
+	MSM_PIN_FUNCTION(mi2s1_ws),
+	MSM_PIN_FUNCTION(mi2s2_data0),
+	MSM_PIN_FUNCTION(mi2s2_data1),
+	MSM_PIN_FUNCTION(mi2s2_sck),
+	MSM_PIN_FUNCTION(mi2s2_ws),
+	MSM_PIN_FUNCTION(mi2s_mclk0),
+	MSM_PIN_FUNCTION(mi2s_mclk1),
+	MSM_PIN_FUNCTION(pcie0_clkreq),
+	MSM_PIN_FUNCTION(pcie1_clkreq),
+	MSM_PIN_FUNCTION(phase_flag),
+	MSM_PIN_FUNCTION(pll_bist),
+	MSM_PIN_FUNCTION(pll_clk),
+	MSM_PIN_FUNCTION(prng_rosc0),
+	MSM_PIN_FUNCTION(prng_rosc1),
+	MSM_PIN_FUNCTION(prng_rosc2),
+	MSM_PIN_FUNCTION(prng_rosc3),
+	MSM_PIN_FUNCTION(qdss_cti),
+	MSM_PIN_FUNCTION(qdss_gpio),
+	MSM_PIN_FUNCTION(qup0_se0),
+	MSM_PIN_FUNCTION(qup0_se1),
+	MSM_PIN_FUNCTION(qup0_se2),
+	MSM_PIN_FUNCTION(qup0_se3),
+	MSM_PIN_FUNCTION(qup0_se4),
+	MSM_PIN_FUNCTION(qup0_se5),
+	MSM_PIN_FUNCTION(qup0_se6),
+	MSM_PIN_FUNCTION(qup0_se7),
+	MSM_PIN_FUNCTION(qup1_se0),
+	MSM_PIN_FUNCTION(qup1_se1),
+	MSM_PIN_FUNCTION(qup1_se2),
+	MSM_PIN_FUNCTION(qup1_se3),
+	MSM_PIN_FUNCTION(qup1_se4),
+	MSM_PIN_FUNCTION(qup1_se5),
+	MSM_PIN_FUNCTION(qup1_se6),
+	MSM_PIN_FUNCTION(qup1_se7),
+	MSM_PIN_FUNCTION(qup2_se0),
+	MSM_PIN_FUNCTION(sailss_emac0),
+	MSM_PIN_FUNCTION(sailss_ospi),
+	MSM_PIN_FUNCTION(sgmii_phy),
+	MSM_PIN_FUNCTION(tb_trig),
+	MSM_PIN_FUNCTION(tgu_ch0),
+	MSM_PIN_FUNCTION(tgu_ch1),
+	MSM_PIN_FUNCTION(tgu_ch2),
+	MSM_PIN_FUNCTION(tgu_ch3),
+	MSM_PIN_FUNCTION(tsense_pwm1),
+	MSM_PIN_FUNCTION(tsense_pwm2),
+	MSM_PIN_FUNCTION(tsense_pwm3),
+	MSM_PIN_FUNCTION(tsense_pwm4),
+	MSM_PIN_FUNCTION(usb2phy_ac),
+	MSM_PIN_FUNCTION(vsense_trigger),
+};
+
+static const msm_pin_function qcs8300_pin_functions[] = {
+	[0] = PINGROUP(0, _, _, _, _, _, _, _, _, _, _, _),
+	[1] = PINGROUP(1, pcie0_clkreq, _, _, _, _, _, _, _, _, _, _),
+	[2] = PINGROUP(2, _, _, _, _, _, _, _, _, _, _, _),
+	[3] = PINGROUP(3, phase_flag, _, _, _, _, _, _, _, _, _, _),
+	[4] = PINGROUP(4, sgmii_phy, qdss_cti, _, _, _, _, _, _, _, _, _),
+	[5] = PINGROUP(5, emac0_mdc, qdss_cti, _, _, _, _, _, _, _, _, _),
+	[6] = PINGROUP(6, emac0_mdio, _, _, _, _, _, _, _, _, _, _),
+	[7] = PINGROUP(7, usb2phy_ac, _, _, _, _, _, _, _, _, _, _),
+	[8] = PINGROUP(8, usb2phy_ac, _, _, _, _, _, _, _, _, _, _),
+	[9] = PINGROUP(9, phase_flag, _, _, _, _, _, _, _, _, _, _),
+	[10] = PINGROUP(10, qup2_se0, emac0_mcg0, _, _, _, _, _, _, _, _, _),
+	[11] = PINGROUP(11, qup2_se0, emac0_mcg1, _, _, _, _, _, _, _, _, _),
+	[12] = PINGROUP(12, qup2_se0, _, _, _, _, _, _, _, _, _, _),
+	[13] = PINGROUP(13, qup2_se0, _, _, _, _, _, _, _, _, _, _),
+	[14] = PINGROUP(14, qup2_se0, tb_trig, _, _, _, _, _, _, _, _, _),
+	[15] = PINGROUP(15, qup2_se0, _, sailss_ospi, sailss_emac0, _,
+			_, _, _, _, _, _),
+	[16] = PINGROUP(16, qup2_se0, _, _, sailss_ospi, sailss_emac0,
+			_, _, _, _, _, _),
+	[17] = PINGROUP(17, qup0_se0, qup0_se1, ibi_i3c, _, _,
+			_, _, _, _, _, _),
+	[18] = PINGROUP(18, qup0_se0, qup0_se1, ibi_i3c, _, _,
+			_, _, _, _, _, _),
+	[19] = PINGROUP(19, qup0_se1, qup0_se0, cci_timer, ibi_i3c, _,
+			_, _, _, _, _, _),
+	[20] = PINGROUP(20, qup0_se1, qup0_se0, cci_timer, ibi_i3c, _,
+			_, _, _, _, _, _),
+	[21] = PINGROUP(21, qup0_se5, cci_timer, _, _, _, _, _, _, _, _, _),
+	[22] = PINGROUP(22, pcie1_clkreq, qup0_se5, cci_timer, _, _,
+			_, _, _, _, _, _),
+	[23] = PINGROUP(23, qup0_se5, cci_timer, qdss_cti, _, _,
+			_, _, _, _, _, _),
+	[24] = PINGROUP(24, qup0_se5, emac0_ptp_aux, emac0_ptp_pps, qdss_cti, emac0_mcg2,
+			_, _, _, _, _, _),
+	[25] = PINGROUP(25, qup0_se3, phase_flag, _, _, _, _, _, _, _, _, _),
+	[26] = PINGROUP(26, qup0_se3, phase_flag, _, _, _, _, _, _, _, _, _),
+	[27] = PINGROUP(27, qup0_se3, _, _, _, _, _, _, _, _, _, _),
+	[28] = PINGROUP(28, qup0_se3, phase_flag, _, _, _, _, _, _, _, _, _),
+	[29] = PINGROUP(29, qup0_se4, cci_i2c_sda, cci_async, emac0_ptp_pps, tgu_ch2,
+			_, _, _, _, _, _),
+	[30] = PINGROUP(30, qup0_se4, cci_i2c_scl, cci_async, emac0_ptp_pps, tgu_ch3,
+			_, _, _, _, _, _),
+	[31] = PINGROUP(31, qup0_se4, cci_i2c_sda, cci_async, emac0_ptp_aux, _,
+			_, _, _, _, _, _),
+	[32] = PINGROUP(32, qup0_se4, cci_i2c_scl, emac0_ptp_aux, mdp_vsync, _,
+			_, _, _, _, _, _),
+	[33] = PINGROUP(33, qup0_se2, qdss_gpio, _, _, _, _, _, _, _, _, _),
+	[34] = PINGROUP(34, qup0_se2, qdss_gpio, _, _, _, _, _, _, _, _, _),
+	[35] = PINGROUP(35, qup0_se2, gcc_gp1, _, _, _, _, _, _, _, _, _),
+	[36] = PINGROUP(36, qup0_se2, gcc_gp2, qdss_gpio, _, _,
+			_, _, _, _, _, _),
+	[37] = PINGROUP(37, qup1_se0, ibi_i3c, qup1_se1, aoss_cti, _,
+			_, _, _, _, _, _),
+	[38] = PINGROUP(38, qup1_se0, ibi_i3c, qup1_se1, aoss_cti, _,
+			_, _, _, _, _, _),
+	[39] = PINGROUP(39, qup1_se1, ibi_i3c, qup1_se0, aoss_cti, _,
+			_, _, _, _, _, _),
+	[40] = PINGROUP(40, qup1_se1, ibi_i3c, qup1_se0, aoss_cti, _,
+			_, _, _, _, _, _),
+	[41] = PINGROUP(41, qup1_se3, _, _, _, _, _, _, _, _, _, _),
+	[42] = PINGROUP(42, qup1_se3, _, mdp_vsync, _, _, _, _, _, _, _, _),
+	[43] = PINGROUP(43, qup0_se7, _, tgu_ch0, _, _, _, _, _, _, _, _),
+	[44] = PINGROUP(44, qup0_se7, _, tgu_ch1, _, _, _, _, _, _, _, _),
+	[45] = PINGROUP(45, qup1_se4, hs1_mi2s, _, _, _, _, _, _, _, _, _),
+	[46] = PINGROUP(46, qup1_se4, hs1_mi2s, _, _, _, _, _, _, _, _, _),
+	[47] = PINGROUP(47, qup1_se4, hs1_mi2s, _, _, _, _, _, _, _, _, _),
+	[48] = PINGROUP(48, qup1_se4, hs1_mi2s, edp0_lcd, _, _,
+			_, _, _, _, _, _),
+	[49] = PINGROUP(49, qup1_se5, hs2_mi2s, cci_timer, qdss_cti, edp1_lcd,
+			ddr_pxi1, _, _, _, _, _),
+	[50] = PINGROUP(50, qup1_se5, hs2_mi2s, cci_timer, qdss_cti, _,
+			ddr_pxi1, _, _, _, _, _),
+	[51] = PINGROUP(51, qup1_se5, hs2_mi2s, qdss_cti, _, _,
+			_, _, _, _, _, _),
+	[52] = PINGROUP(52, qup1_se5, hs2_mi2s, qdss_cti, mdp_vsync, ddr_pxi2,
+			_, _, _, _, _, _),
+	[53] = PINGROUP(53, ddr_bist, _, _, _, _, _, _, _, _, _, _),
+	[54] = PINGROUP(54, cci_i2c_sda, phase_flag, ddr_bist, _, _,
+			_, _, _, _, _, _),
+	[55] = PINGROUP(55, cci_i2c_scl, phase_flag, ddr_bist, _, _,
+			_, _, _, _, _, _),
+	[56] = PINGROUP(56, phase_flag, ddr_bist, _, _, _, _, _, _, _, _, _),
+	[57] = PINGROUP(57, cci_i2c_sda, prng_rosc0, qdss_gpio, _, _,
+			_, _, _, _, _, _),
+	[58] = PINGROUP(58, cci_i2c_scl, prng_rosc1, qdss_gpio, _, _,
+			_, _, _, _, _, _),
+	[59] = PINGROUP(59, cci_i2c_sda, prng_rosc2, qdss_gpio, _, _,
+			_, _, _, _, _, _),
+	[60] = PINGROUP(60, cci_i2c_scl, prng_rosc3, qdss_gpio, _, _,
+			_, _, _, _, _, _),
+	[61] = PINGROUP(61, cci_i2c_sda, qdss_gpio, _, _, _, _, _, _, _, _, _),
+	[62] = PINGROUP(62, cci_i2c_scl, qdss_gpio, _, _, _, _, _, _, _, _, _),
+	[63] = PINGROUP(63, cci_timer, cci_async, qdss_gpio, atest_usb2, _,
+			_, _, _, _, _, _),
+	[64] = PINGROUP(64, cci_timer, cci_async, qdss_gpio, atest_usb2, _,
+			_, _, _, _, _, _),
+	[65] = PINGROUP(65, cci_timer, cci_async, qdss_gpio, atest_usb2, _,
+			_, _, _, _, _, _),
+	[66] = PINGROUP(66, phase_flag, _, atest_char, _, _, _, _, _, _, _, _),
+	[67] = PINGROUP(67, cam_mclk, vsense_trigger, atest_usb2, _, _,
+			_, _, _, _, _, _),
+	[68] = PINGROUP(68, cam_mclk, gcc_gp4, atest_usb2, ddr_pxi0, _,
+			_, _, _, _, _, _),
+	[69] = PINGROUP(69, cam_mclk, gcc_gp3, atest_usb2, ddr_pxi0, _,
+			_, _, _, _, _, _),
+	[70] = PINGROUP(70, qdss_gpio, atest_char, _, _, _, _, _, _, _, _, _),
+	[71] = PINGROUP(71, qdss_gpio, atest_char, _, _, _, _, _, _, _, _, _),
+	[72] = PINGROUP(72, qdss_gpio, atest_char, _, _, _, _, _, _, _, _, _),
+	[73] = PINGROUP(73, _, qdss_gpio, _, _, _, _, _, _, _, _, _),
+	[74] = PINGROUP(74, pll_clk, qdss_gpio, atest_usb2, _, _,
+			_, _, _, _, _, _),
+	[75] = PINGROUP(75, _, dbg_out, qdss_gpio, atest_usb2, _,
+			_, _, _, _, _, _),
+	[76] = PINGROUP(76, gcc_gp5, tsense_pwm4, _, _, _, _, _, _, _, _, _),
+	[77] = PINGROUP(77, gcc_gp5, tsense_pwm3, _, _, _, _, _, _, _, _, _),
+	[78] = PINGROUP(78, tsense_pwm2, _, _, _, _, _, _, _, _, _, _),
+	[79] = PINGROUP(79, emac0_ptp_aux, emac0_ptp_pps, emac0_mcg3, _, tsense_pwm1,
+			_, _, _, _, _, _),
+	[80] = PINGROUP(80, qup0_se6, mdp0_vsync6, _, atest_usb2, ddr_pxi3,
+			_, _, _, _, _, _),
+	[81] = PINGROUP(81, qup0_se6, mdp0_vsync7, gcc_gp2, _, atest_usb2,
+			ddr_pxi3, _, _, _, _, _),
+	[82] = PINGROUP(82, qup0_se6, gcc_gp3, _, _, _, _, _, _, _, _, _),
+	[83] = PINGROUP(83, qup0_se6, gcc_gp4, _, atest_usb2, ddr_pxi2,
+			_, _, _, _, _, _),
+	[84] = PINGROUP(84, qup1_se2, gcc_gp1, _, atest_usb2, _,
+			_, _, _, _, _, _),
+	[85] = PINGROUP(85, qup1_se2, _, atest_usb2, _, _, _, _, _, _, _, _),
+	[86] = PINGROUP(86, qup1_se2, _, _, _, _, _, _, _, _, _, _),
+	[87] = PINGROUP(87, qup1_se2, _, atest_usb2, _, _, _, _, _, _, _, _),
+	[88] = PINGROUP(88, qup1_se2, _, _, _, _, _, _, _, _, _, _),
+	[89] = PINGROUP(89, qup1_se6, qup1_se7, mdp0_vsync0, _, _,
+			_, _, _, _, _, _),
+	[90] = PINGROUP(90, qup1_se6, qup1_se7, mdp0_vsync1, cri_trng, _,
+			_, _, _, _, _, _),
+	[91] = PINGROUP(91, qup1_se7, qup1_se6, mdp0_vsync3, cri_trng, _,
+			_, _, _, _, _, _),
+	[92] = PINGROUP(92, qup1_se7, qup1_se6, cri_trng, _, atest_usb2,
+			_, _, _, _, _, _),
+	[93] = PINGROUP(93, atest_char, _, _, _, _, _, _, _, _, _, _),
+	[94] = PINGROUP(94, edp0_hot, _, _, _, _, _, _, _, _, _, _),
+	[95] = PINGROUP(95, _, _, _, _, _, _, _, _, _, _, _),
+	[96] = PINGROUP(96, _, _, _, _, _, _, _, _, _, _, _),
+	[97] = PINGROUP(97, mi2s_mclk0, jitter_bist, qdss_gpio, _, _,
+			_, _, _, _, _, _),
+	[98] = PINGROUP(98, mi2s1_sck, phase_flag, _, qdss_gpio, _,
+			_, _, _, _, _, _),
+	[99] = PINGROUP(99, mi2s1_ws, phase_flag, _, qdss_gpio, _,
+			_, _, _, _, _, _),
+	[100] = PINGROUP(100, mi2s1_data0, phase_flag, _, qdss_gpio, _,
+			_, _, _, _, _, _),
+	[101] = PINGROUP(101, mi2s1_data1, phase_flag, _, qdss_gpio, _,
+			_, _, _, _, _, _),
+	[102] = PINGROUP(102, mi2s2_sck, phase_flag, _, qdss_gpio, _,
+			_, _, _, _, _, _),
+	[103] = PINGROUP(103, mi2s2_ws, phase_flag, _, qdss_gpio, _,
+			_, _, _, _, _, _),
+	[104] = PINGROUP(104, mi2s2_data0, phase_flag, _, qdss_gpio, _,
+			_, _, _, _, _, _),
+	[105] = PINGROUP(105, mi2s2_data1, audio_ref, phase_flag, _, qdss_gpio,
+			_, _, _, _, _, _),
+	[106] = PINGROUP(106, hs0_mi2s, phase_flag, _, qdss_gpio, _,
+			_, _, _, _, _, _),
+	[107] = PINGROUP(107, hs0_mi2s, pll_bist, phase_flag, _, qdss_gpio,
+			_, _, _, _, _, _),
+	[108] = PINGROUP(108, hs0_mi2s, phase_flag, _, qdss_gpio, _,
+			_, _, _, _, _, _),
+	[109] = PINGROUP(109, hs0_mi2s, mi2s_mclk1, qdss_gpio, _, _,
+			_, _, _, _, _, _),
+	[110] = PINGROUP(110, phase_flag, _, qdss_gpio, _, _,
+			_, _, _, _, _, egpio),
+	[111] = PINGROUP(111, phase_flag, _, qdss_gpio, _, _,
+			_, _, _, _, _, egpio),
+	[112] = PINGROUP(112, phase_flag, _, qdss_gpio, _, _,
+			_, _, _, _, _, egpio),
+	[113] = PINGROUP(113, phase_flag, _, qdss_gpio, _, _,
+			_, _, _, _, _, egpio),
+	[114] = PINGROUP(114, phase_flag, _, qdss_gpio, _, _,
+			_, _, _, _, _, egpio),
+	[115] = PINGROUP(115, _, _, _, _, _, _, _, _, _, _, egpio),
+	[116] = PINGROUP(116, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[117] = PINGROUP(117, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[118] = PINGROUP(118, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[119] = PINGROUP(119, _, _, _, _, _, _, _, _, _, _, egpio),
+	[120] = PINGROUP(120, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[121] = PINGROUP(121, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[122] = PINGROUP(122, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[123] = PINGROUP(123, _, _, _, _, _, _, _, _, _, _, egpio),
+	[124] = PINGROUP(124, _, _, _, _, _, _, _, _, _, _, egpio),
+	[125] = PINGROUP(125, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[126] = PINGROUP(126, _, _, _, _, _, _, _, _, _, _, egpio),
+	[127] = PINGROUP(127, _, _, _, _, _, _, _, _, _, _, egpio),
+	[128] = PINGROUP(128, _, _, _, _, _, _, _, _, _, _, egpio),
+	[129] = PINGROUP(129, _, _, _, _, _, _, _, _, _, _, egpio),
+	[130] = PINGROUP(130, _, _, _, _, _, _, _, _, _, _, egpio),
+	[131] = PINGROUP(131, _, _, _, _, _, _, _, _, _, _, egpio),
+	[132] = PINGROUP(132, _, _, _, _, _, _, _, _, _, _, egpio),
+};
+
+static const struct msm_special_pin_data qcs8300_special_pins_data[] = {
+	[0] = UFS_RESET("ufs_reset", 0x92000),
+	[1] = SDC_QDSD_PINGROUP("sdc1_rclk", 0x89000, 15, 0),
+	[2] = SDC_QDSD_PINGROUP("sdc1_clk", 0x89000, 13, 6),
+	[3] = SDC_QDSD_PINGROUP("sdc1_cmd", 0x89000, 11, 3),
+	[4] = SDC_QDSD_PINGROUP("sdc1_data", 0x89000, 9, 0),
+};
+
+static const char *qcs8300_get_function_name(struct udevice *dev,
+					     unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *qcs8300_get_pin_name(struct udevice *dev,
+					unsigned int selector)
+{
+	if (selector >= 138)
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "unknown");
+	else if (selector >= 133)
+		snprintf(pin_name, MAX_PIN_NAME_LEN,
+			 qcs8300_special_pins_data[selector - 133].name);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static int qcs8300_get_function_mux(unsigned int pin, unsigned int selector)
+{
+	const msm_pin_function *func;
+	unsigned int i;
+
+	if (pin >= ARRAY_SIZE(qcs8300_pin_functions))
+		return -EINVAL;
+
+	func = qcs8300_pin_functions + pin;
+	for (i = 0; i < ARRAY_SIZE(*func); i++)
+		if ((*func)[i] == selector)
+			return i;
+
+	pr_err("Can't find requested function for pin %u pin\n", pin);
+
+	return -EINVAL;
+}
+
+static const struct msm_pinctrl_data qcs8300_data = {
+	.pin_data = {
+		.pin_count = 138,
+		.special_pins_start = 133,
+		.special_pins_data = qcs8300_special_pins_data,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = qcs8300_get_function_name,
+	.get_function_mux = qcs8300_get_function_mux,
+	.get_pin_name = qcs8300_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,qcs8300-tlmm", .data = (ulong)&qcs8300_data },
+	{ }
+};
+
+U_BOOT_DRIVER(qcs8300_pinctrl) = {
+	.name		= "qcs8300_pinctrl",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+	.flags		= DM_FLAG_PRE_RELOC,
+};

-- 
2.47.3

