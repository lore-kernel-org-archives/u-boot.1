Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8666D6407A
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 12:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6B2683B64;
	Wed, 17 Dec 2025 13:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VgdOdY10";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SA3bP7Eg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7403A83AB0; Wed, 17 Dec 2025 11:51:50 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 398FC83979
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 11:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BH4XUlM2316144
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 10:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Fz1ZLPSB+M2BtLRIgKE0/sx6
 5U3nbdo5dKEAI3dls7k=; b=VgdOdY10ZB99VY0y0rQcr5WoTucLh8OwwFB9RQ0k
 AbD4KFbWqi84OlSTsGafNX/nNzyYszWd6kzqWWpZvLqxCnUWXjTe82nzJQYFVJL8
 3RwIeqY4yVJ+OgmOam8daEJx2rWTk7gO1sX6sGQblf/D/tNBfM2W9Xl14OfWB2NV
 2ArZQTu7+d0km0IP91SkFDbW3r4N3X5cGzierVE7jNXeItbqWHeDWnU0CuvIbGNn
 3LWqWVpSloQTjgDrvgEWwLRNLFnvxmlOx5gl0rWaas+ZRAU74SCKhVKrTPA1hEvE
 VjifZjk46t93TyujNr09YlKsD1h93vlB2Trtf5oxEFFQ/w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3nkkh6f8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 10:51:46 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34e5a9de94bso608997a91.0
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 02:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1765968705; x=1766573505; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fz1ZLPSB+M2BtLRIgKE0/sx65U3nbdo5dKEAI3dls7k=;
 b=SA3bP7EggRpRoozkgJhVVnBEqOXe6UDevoRZfCGs/0e+GnQSOY7AdqE7HiScjbPgv0
 nhsGlkumNiP9uHiiv3iZAEmNjJ4fvtbrg70FPfkSqijWfc2NX73nft/2zXroQMTX5f3g
 9UstQNNDvbtJa44g97FxDzTLMr0Fmj1bszV5URYjFClRHBFAI/UDst9YeRRF2YvXRiIo
 f0ArhShf9bQS+kQOpyJHug/YBOjUYcBjBAmFG86P1sJZ6A3YgD1QrChdEooekGwgnH7I
 z2hkp5Qv0/bFXDtUqsLKjV+zVtSgQcaVh5xZu67B18TrqDnbBtD4koQcAbn8hr9oD2WJ
 apng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765968705; x=1766573505;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fz1ZLPSB+M2BtLRIgKE0/sx65U3nbdo5dKEAI3dls7k=;
 b=sFJkPpqVvXCjzRZKxVDJsO5+UQQT9txWW2RpCOKt5yYYqVKPfJ1LN2tns7dC3bxRin
 O76lFuS+cZQUiZrpQDo6oTct+vWtel3xfm3km1UVPk7XWesuxAqfiDUH5iQNPf+S1G6h
 ukdq794oiepZj1KxnCGuOik6k1x3tn1z42Nwdt/0eRGGEtJQmAyXKw98u3PUiMvwTVBy
 C1HDjDZSZsf3BuDIq5a1iuHxrIEZpNwfmLFLXn37UmgWNhxHC1+6HN0syJq1by/DLfET
 8fcII+gTeRyxd+tQKsPXDC+5aYVvZ99EuwUAqbKNzRNCGzIKQWNY4ZDxSAC3BiOAamAF
 T3sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuyXqibNYa6psOK6kweynPcj/iVB+aJJqcZq/z2ZGYE1FTS+a8TtG31wF34aG9uNp3nYjy0Nk=@lists.denx.de
X-Gm-Message-State: AOJu0YxS5x84BPuRS5kZ/S7CsNfvS41Sai/9rqvJIl5bXxlQvsTA5dXw
 2YfUkKrnqRaR3pAvaQcLgirA8PsQ65oxs+Vl4C3OUXL4zsYX91H4JEfZ9eb5zWg3jc3D+F6F+Bo
 YOxQvJgydWzdHIV5D9AdGpekc8A4NOsrAI3kO3osK88H0DVdL3L3aoihm
X-Gm-Gg: AY/fxX62IaAvKHUxB2D78mOcfmtK84govXwykSCDPe+oCHFOba4nGWsMHZaTL6iVqWy
 PIt+RiTmkY+bYygjLpXW2ewwNxS+/20Uqow5Ts2cmhM+KKC4BHOom0sFi6iP9n2/gTtRcRcD00w
 MSVO1M3yT2qK5jW3V8W6uONwZ4DZSz4bHgNTJRSiq2rAaWw+rRFr1lfE6rbvu1q0LnSQLjFPTKH
 wzRJ9rxz2WtjLvxze0ZAMKxipA+T1jMQrnc+97+VMgYuNrs/V0BgFdxhXy3ShtW8UYoo0ArWtGt
 3uux/CbUdihQASPucVZZ5etAmk5KdLgGcW1WQGqAd+XfOct00mk0owwmDuBUFPLwsbRC4iRGa0P
 wEiWc9VTK4/nh7oe4Re14eaRC/8SBn+PUAjPt8xoUfHpbTjKB30j2dS6TcwiSOWwuJGn0marRpo
 ImpkEnyGxOjOC8wF3DIZ8U4ZNAe5GX5PPuRu1IOtA=
X-Received: by 2002:a05:6a20:e293:b0:352:d5b:c427 with SMTP id
 adf61e73a8af0-369ad9d75b4mr17256595637.3.1765968705532; 
 Wed, 17 Dec 2025 02:51:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6xuJbqbPDBkBIqfI6MmJC8IcY+ccw3pB6sH5w6b6iQDGz+musrsdYTWZQU5PX5ulwzk/xnw==
X-Received: by 2002:a05:6a20:e293:b0:352:d5b:c427 with SMTP id
 adf61e73a8af0-369ad9d75b4mr17256570637.3.1765968705036; 
 Wed, 17 Dec 2025 02:51:45 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c264211cbsm17861187a12.11.2025.12.17.02.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 02:51:44 -0800 (PST)
Date: Wed, 17 Dec 2025 16:21:37 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, peng.fan@nxp.com,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org, me@samcday.com,
 sajattack@postmarketos.org, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, alif.zakuan.yuslaimi@altera.com,
 tien.fong.chee@altera.com, miquel.raynal@bootlin.com,
 balaji.selvanathan@oss.qualcomm.com, w.egorov@phytec.de,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v6 4/5] mach-snapdragon: fixup power-domains
Message-ID: <aUKLOTD0Hgi3kbpk@hu-varada-blr.qualcomm.com>
References: <20251113113427.2218045-1-aswin.murugan@oss.qualcomm.com>
 <20251113113427.2218045-5-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113113427.2218045-5-aswin.murugan@oss.qualcomm.com>
X-Proofpoint-GUID: gFpQOqc06OWbN2Hh80iyl9In9u63GUHf
X-Proofpoint-ORIG-GUID: gFpQOqc06OWbN2Hh80iyl9In9u63GUHf
X-Authority-Analysis: v=2.4 cv=f/RFxeyM c=1 sm=1 tr=0 ts=69428b42 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Po2OY-HkD6r4WAYvqj0A:9
 a=CjuIK1q_8ugA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA4NiBTYWx0ZWRfXwwW2u5Wy22HP
 /O1DEBP+7+gd+N2Q9//IiJAWK7AQMSo3Ff3FaIFgNkZ3VcRh7jRhm3ALMQS3y0sGxPwmhYp4mVx
 l8UXA9+B2j5+7h/I3gy7jVt9QW6j+nv2eaE7w7MQCHdyTRTWQxW+ALoOCmParwq+UuOeVxKp3rT
 bmM7fzJrlxkZOeCTDZAKSJKU7mFLbPKAgOuFmgXgrXX/1oihlDBQiyTB+2BPkH6buqN6Jwqfe6e
 m8UhFtcoE5sxGnRHkLOlypabTvaI1obNnIIMIdGu/XGW/pPNyNBvW8nW2FoTHRHG6l7N/SV0d64
 2uv/SVOCVpDrN8h3wn+Ho0Rx5CDx4hI2C7w6DCMoxmXokwOrYDhtoj/BrFLHrbVZVCaz+npg1gs
 X9tvIsNCT4cuPW8N2/hErYMHGe2p7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170086
X-Mailman-Approved-At: Wed, 17 Dec 2025 13:57:17 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Thu, Nov 13, 2025 at 05:04:26PM +0530, Aswin Murugan wrote:
> RPMH power domain properties were initially removed from the
> device tree due to the absence of driver support. Since RPMH
> power domain driver is added now, the fixups are removed.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> v6:
> - No changes to this patch in v6
>
> v5:
> - No changes to this patch in v5
>
> v4:
> - Reverted the inclusion of qcom-rpmpd.h header in pervious versions.
>
> v3:
> - Removed OF_LIVE_SA8775P config, since there is no SA8775P specific fixups are done
>
> v2:
> - Removed the power domain fixups, since the power domains are handled in qcom-rpmhpd driver
> ---
>  arch/arm/mach-snapdragon/of_fixup.c | 31 -----------------------------
>  1 file changed, 31 deletions(-)
>
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index eec2c0c757e..93c16821e54 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -116,36 +116,6 @@ static void fixup_usb_nodes(struct device_node *root)
>  	}
>  }
>
> -/* Remove all references to the rpmhpd device */
> -static void fixup_power_domains(struct device_node *root)
> -{
> -	struct device_node *pd = NULL, *np = NULL;
> -	struct property *prop;
> -	const __be32 *val;
> -
> -	/* All Qualcomm platforms name the rpm(h)pd "power-controller" */
> -	for_each_of_allnodes_from(root, pd) {
> -		if (pd->name && !strcmp("power-controller", pd->name))
> -			break;
> -	}
> -
> -	/* Sanity check that this is indeed a power domain controller */
> -	if (!of_find_property(pd, "#power-domain-cells", NULL)) {
> -		log_err("Found power-controller but it doesn't have #power-domain-cells\n");
> -		return;
> -	}
> -
> -	/* Remove all references to the power domain controller */
> -	for_each_of_allnodes_from(root, np) {
> -		if (!(prop = of_find_property(np, "power-domains", NULL)))
> -			continue;
> -
> -		val = prop->value;
> -		if (val[0] == cpu_to_fdt32(pd->phandle))
> -			of_remove_property(np, prop);
> -	}
> -}
> -
>  #define time_call(func, ...) \
>  	do { \
>  		u64 start = timer_get_us(); \
> @@ -158,7 +128,6 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
>  	struct device_node *root = event->data.of_live_built.root;
>
>  	time_call(fixup_usb_nodes, root);
> -	time_call(fixup_power_domains, root);
>
>  	return 0;
>  }
>
> --
> 2.34.1
>
