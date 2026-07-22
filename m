Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8C0C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 11:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CCA140718;
	Wed, 22 Jul 2026 11:38:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qtee-kdp71UX; Wed, 22 Jul 2026 11:38:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 200F740704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784720319;
	bh=/GpdaT4yUGgHA8IpuCYsT58iOhP9WIo7GINW1AouReA=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=H7MGz0sMglH1fuSIy4BoEbEGIQlGwmfN6SZMU1T0sMrDLzZRh23qsyIg1sYx9Kt6H
	 z46yBO+QxKAXEYLJy8dgAXnqrDM7V1EmYZuZXKfY4OW3pJbl33DeLHYG/2tcY4HR+6
	 Ovfpph0l81f6t61egw6rvWsjmTisdQDUHj5Ww+C1xTt6e62661AlnGtsI3Ts8dxxYW
	 PVaXIs4sa3S8cH1HoCwyzzVB9gbGqHIR1KyZgafbYYn/5oqvua4wOny37THSUBJ0EH
	 k150nCR7CaCjfl2pEUJJVWHkKRg9QJe8v2zdSeKlXZJA89wGzvYvlNyl83g6TznuY8
	 DIkw8TyVRLvFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 200F740704;
	Wed, 22 Jul 2026 11:38:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 96572EB
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 11:38:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 886B7607AA
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 11:38:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H9JJ7C7vU3rl for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 11:38:37 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 90683607A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 90683607A3
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 90683607A3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 11:38:36 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F332848BA; Wed, 22 Jul 2026 13:38:33 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0F17803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 13:38:30 +0200 (CEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8x35h524020
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 11:38:28 GMT
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjrtt15w6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 11:38:28 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb74d5db64eso3846959a12.2
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 04:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784720308; x=1785325108;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/GpdaT4yUGgHA8IpuCYsT58iOhP9WIo7GINW1AouReA=;
 b=AlclgL5JPgbRlSCY4QXWM6EoloMZlNxV21R+5UNsevKvc83FJ+SHVUsURxUF8IxBeZ
 QlfZa7aU1n6a++5u7dROqsAdyn/TSdsLec6jdx+JrvelTFElxMh67QaPl4T/BEUXHSIP
 VCRurs71SlJcI8Lk4x8F8SKBvXX1+ImFIkwJMBGHKJtNdP/s4QZTQ9FfludJ6h4w1BB2
 J9hNsMWob9rS4euYcmLiLxnNqfvBYLgldFhKHYZRUMgYqSybnrsyF8dR/kQGwcoqcPhD
 FzDrR6KHjasJynOtqaKPT3Scp2x0zMZSJ2yXjRdsTGBCeRKOc/UqMFRwldzm7h+LvE49
 jQGw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFKdjBCcKWhIag5/14hkfGC7eJtydlHg+ZUWimQvSPbEhDCH2hLeAlsDx9KgLL2dJnDzXcqf4=@lists.denx.de
X-Gm-Message-State: AOJu0YzuwlGUKVb73N6L9RN/u/fXLEMXmulOPoAP0U/T4Bhjd/7KGo1C
 a73x2/g8vUL7YeEVENERmivyeivc2hS/L9ge4ibjbLiWpZexg6Epz/07p6VuwfnGwITFxv5g4xV
 EMT9Kt0LT4Et8MXnK+TVS2O5U6gWMo4ZkNmHy4jjuhusKCm1xz3Yu5v+p
X-Gm-Gg: AR+sD12ao0ERffxDTx4ebMCr9MG6bDioS8ac0h6uapnAEhYvQi2NhA7lIdXv8ZoHAL2
 xtrsnEEwRz4Gxycxw7fK1lOFnjH3SGpxNCWKozo/VHmHdDecMii5mRgX/JEa588u2hfd5v1Ug5e
 j5vT7EG+ZsL461eqOPqsEmgUwbVmOuqgISowf/+Q0Cg0eJdvho1kQ5GL6dPo6Pv/Clmec0IA/o7
 NeuW36eNveQwbPoJTXXkX2Bk5oHBy4DZcEm/f94t82/8o+aTQ9YoOM+fxgW5rto1EAk7s1UfCtU
 ytjx6jB0QsKdtm1BvdojfmJcmF73WK/hvhCDIr7gytjYECdli8S4qrI3yLfLf5miyR4hDWvz73H
 tWLoBtensDKuhNZWWBAFH7WsaJAFSbve2ZH9gurH1xcekOaFkHjAHzRcq0hlhpUH3bDlhMwxsrD
 CHzFbZUp6om8tJ0MqvsX322g/nXYnHHA==
X-Received: by 2002:a05:6a21:a382:b0:3c3:a140:9380 with SMTP id
 adf61e73a8af0-3c3ad7c6224mr23036025637.16.1784720307825; 
 Wed, 22 Jul 2026 04:38:27 -0700 (PDT)
X-Received: by 2002:a05:6a21:a382:b0:3c3:a140:9380 with SMTP id
 adf61e73a8af0-3c3ad7c6224mr23035982637.16.1784720307358; 
 Wed, 22 Jul 2026 04:38:27 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1ca3efsm10759172eec.30.2026.07.22.04.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 04:38:27 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:08:18 +0530
To: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, michal.simek@amd.com, luca.weiss@fairphone.com,
 danila@jiaxyga.com, adrian@mainlining.org,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v4 1/4] clk: qcom: Add initial Clock driver for ipq9650
Message-ID: <amCrqsQLNyW5zTsD@hu-varada-blr.qualcomm.com>
References: <20260722104624.3842833-1-badhrinath.s@oss.qualcomm.com>
 <20260722104624.3842833-2-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722104624.3842833-2-badhrinath.s@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: HV_Wz56_Uo3Dv1i8bwPtL7Z_MSXfR3Dg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDExMyBTYWx0ZWRfX/PuvyBe7B6Pt
 f7Z9Z+FwesuHRGXFACFL3uzczw59wSciqWbO5eoD6Op/AiNGtk3Tcz4yxN4Y/XeqNskuKC/KXx+
 3sUNn7wh9u3j7GJYseBPOXjAqpW6LNHmeh6hxM1LoeoVwXV8qaqnVNdwIBmJwqSVdDOPOQnebBO
 Kw1ohgVQLSP2gMnoSW6aYGD6ZchzaBpq47ereBm/bJyhtci2JQZQ5JLdX4Z8nx8lWw4c7uC2tX8
 2KjUVWZW2A5QskrKrPuUrd0twqpb4wvnC9ATSbQIEP8jG113QPjGz3qJT5EGMJGoh04IavEJBd9
 pSQW6OfJCFmReLZ6XPVkG+ljXOVUnL7FaqWHg6exH3NdmQ7e87m1keaGkkEU5WSG0u6qh1gpy+4
 kPqM8vLt+Z8o/qAfkzaJXhPNA5/+fdBIyHexuSiYnbtSN3qP94z1XN8DEe9qSKVUgYk9K2eUysE
 RGibOq1adekNJwUed4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDExMyBTYWx0ZWRfXzmL2SVGh5Uzs
 ikdw5p1h/55EZLEGlHgoS/h9+OTa7AKpJb8ZXHaBdl/6/UEGdq0v2fB1bVghd5jJVicdTZNpNud
 siHJOfOHoPGVwFkJbBJ5hcVXUun1ph4=
X-Proofpoint-GUID: HV_Wz56_Uo3Dv1i8bwPtL7Z_MSXfR3Dg
X-Authority-Analysis: v=2.4 cv=V8lNF+ni c=1 sm=1 tr=0 ts=6a60abb4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=zWj5ubxJUX3AJK_KDQEA:9 a=CjuIK1q_8ugA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220113
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/GpdaT4yUGgHA8IpuCYsT58i
 OhP9WIo7GINW1AouReA=; b=nJZHJSbJ5PhwQs77KL/7b07OZqns8NLbPax5+zSe
 DwCeu1X6YfTJNKrmzkYuraZDlraRDEKCe7WcIhBGmcqWIIeYREQwTJftSagKsAeP
 ZQppy34bBUivIB3C32lccfg+41QJgYEZSmNW/gYyD9OCclIkxRuSXPirXcgrNCtf
 3hwDMHYFRhhmJk5WukEY3P53cREeuNixgSI981P3rcZJHKR10QeJzgHESrib+oQs
 uaf3udSHaS1OqHLdVS4+shB2SwkoYNcFyBCO+BaCu1MeY60Bz6h0NbTGyg25kvIf
 6f/h1Oh4lUPkqdGvL4eDrHW+Fwu1cUdZOulUEcASxAe/CA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784720308; x=1785325108; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/GpdaT4yUGgHA8IpuCYsT58iOhP9WIo7GINW1AouReA=;
 b=WXRvB5aVPStwvB7w4lF2Nbme2DkX8OqqWkq3cfrqWg2KzvJvIEc6EHozRUXZcWaDwT
 /uHCmdZpUeWPI+pNM8PmxNVR45LKiikmVxumwn2P32ZRVoT4VlctREGwR5/49t8MRoir
 U9NAxwlq22PivAyxCWxmoWQUPlHuHcdzGW1n0zALKBWjXY6XmmSeIKwCl3Ajv+aOG+G2
 B54lpxIcxfkYTmHaAWVfjNBBNobsG1AFFC+RzTmskYwH2i47b+fAcT1CzXu7h8f8DmD9
 a4un+QUhn1exftlQpwW+Srx+UCyV+b+oUkL0KsCzyJrKskyZYJgb8ZVhYk1TBWh11ycZ
 sScQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=nJZHJSbJ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WXRvB5aV
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nJZHJSbJ";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="WXRvB5aV"; 
 dkim-atps=neutral
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
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

[. . . ]

> +static const struct gate_clk ipq9650_clks[] = {
> +	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x3303c, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x33004, BIT(1)),
> +	GATE_CLK(GCC_QUPV3_WRAP_SE6_CLK, 0x04004, BIT(0)),

Use GATE_CLK_POLLED. GATE_CLK is deprecated.

> +};
> +
> +static int ipq9650_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (clk->id >= ARRAY_SIZE(ipq9650_clks) || !ipq9650_clks[clk->id].reg)
> +		return -EINVAL;
> +
> +	qcom_gate_clk_en(priv, clk->id);
> +
> +	return 0;

return qcom_gate_clk_en(priv, clk->id);

[ . . . ]

Thanks
Varada
