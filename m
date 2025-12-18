Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2360ED68BED
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 08:04:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C71C83C94;
	Thu, 18 Dec 2025 09:04:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ubk9XDIV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S2xCJYlB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D50F883CAA; Thu, 18 Dec 2025 09:04:34 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EF9283C54
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:04:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BI1YZeS4147974
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 08:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=q0Hn/NNZnglya3aTsa99H6wW
 drz0fzsHZewJGi6ToRg=; b=Ubk9XDIV9n60rywC06rPc+2LVPU7YgePlG4EyjGa
 lIudwL43kjfu9KJ7O0rcilKEQPWMq58UnGUsfcTMJXEsYMuM0ZNLhBog2F5MnQTS
 jR5leVCvxgRvIrfKtp8K99JLYVdbIIMpIkNYs9B8M/BloTL2RsxF+W+iTV3blEnA
 V5tjexRzhEFHT8hr72y+yrA///v7wGEDT/5BNlcEZ/RmZzqztkWq0SmloaYorUGy
 LRcXkO/M0gsel6QBs9/3RJsjR8u6Z+lmwLrehpR8al6afDJsXB9s75J6Bn1HTACp
 2B9iil7IYlFH5AVrx3LG+9okCMLS8CmWzWmVSGkNDQ0wiQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40u7a7a8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 08:04:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-29efd658fadso11849935ad.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 00:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766045070; x=1766649870; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q0Hn/NNZnglya3aTsa99H6wWdrz0fzsHZewJGi6ToRg=;
 b=S2xCJYlBJHnk9tNnrVSrFjnU6kASoNIoqYxNdwzs7ICpS1WcHuENDKkB4eQGlhQlEv
 H9oAXN2uvUjfGB+tD0YY6KaIBC4mfQyiKjX+qo5I3Gt0UZgKKm0XqkKaeqZSP71UxVVk
 bLJ8g02Sf7orAQ6FZ9U7QBf/035RA5FFgUoW2vkcuYPxzVGUxI/Sib1gYzSFs5zyevX7
 mTgW+8LGXz+YRQhT2kTHVIJ6UJaZZlGKlEj2iMbfbGp8v6dKwn90Z8+fhPnA5Pkj625S
 bubCy5ha2RRUnPLaMAYOUg2V5TYpUJ+cE9/8pVw8nw7Rzh6G7ypvAkHmuyT4IXh88FL2
 2SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766045070; x=1766649870;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q0Hn/NNZnglya3aTsa99H6wWdrz0fzsHZewJGi6ToRg=;
 b=OBZh/etcqNrs6ZRFKvPwPVM5imCLZ7NBv/EokJcBPQ6TPtfuZzijusSm3FFHtgt8zq
 I7COxA1FderZEaKq7x5J6GIdjmoDJRD7VJUPHaSNfp9xH1DsDiU8U8DypzuVd6pWzInv
 aoyEpZP0nA252WCKrZ/icmBK3ENBNS+IoBxaOJYDc0vtN3Q02huDTqilGLjkwzrXSpJL
 +eZ4sXdV82zIpVumFh9/5Xq6Slj8nEDMSRpp3oU3x12jJaDmJjBsb9bKtay350zjblD3
 lAxyfs8T1gm3sApRH+yAUBb/jZQQUImy6JHg9dGh6vJZtWW9CryyXspRk2yDB6WpXH1g
 dodQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKp7mhbE8VaszPgnMpwY2CYnaNwpa5f2k/vK039zyROWYeeMeR6Frlpu5bi48RDiVu9YXnx+c=@lists.denx.de
X-Gm-Message-State: AOJu0YzoBaPO8fMQmmzXodUyLLsEfiQL2hmT19zrcXQ9czCKkuONU4WB
 CLnlp/0iE37skib6mApqnKVXSEYcdmgLkmsMDM4qmEDv7G+fqLwRum9GUkAddJXNlWgDZKhlgj8
 jNvmB1LME//wV9XmiBU6bUwBYebKcZ8F2ZL+yNlvikBHaqhh9IEEbUCVO
X-Gm-Gg: AY/fxX4V2R5thMiKhprboyte0cNCGxHnw2F8q5G1k4UXQHK0tRW8h8axxDkcDGCrXQM
 3mxu0iD+9QOkr29q9ThWwNYL0boim/RtaYAClij7NGCJcMLe8uYngUeLmuWEziChCjF5fgK2LXq
 87QrbV/52b25RQA8IdrZubqR8Dhxp4cxpPW3lMPWBRn/f25oqctspVa1SEZjHrOvgNLm1Zmzwkp
 ioSR8m/RbNQdr54TtFIf+cqDFFW29DbCXh5NF2BP9D3NGMSfGEbbkwagYbLaH6jRhX9CDCiWdbN
 S1O20hM6pCywnN4MwbYS5F1M5PQ8uhra+aQNHfRIRwcv+thPxVS7I91+KBh29HKKeD3Dp3cxF7g
 W2Rp8683fHfPt9gwbhAc3ahI3w7DbcFJKGgHYkIIFw3JbQfYdAeuo4iplrdoBwOzHLR3gVej78r
 E8HCtFK0m9mBewF6qmmmlVc/lP7xMOTe1XAo4sCHk=
X-Received: by 2002:a17:902:ea0c:b0:2a1:325b:2cba with SMTP id
 d9443c01a7336-2a1325b2e27mr95250465ad.53.1766045069621; 
 Thu, 18 Dec 2025 00:04:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5UUEPiwcAQMV4ybY8JPaupUlzQRfg/sJYS31Xzy4i7jWC6KGG+WS6nCDr+NbFia7BIwj90Q==
X-Received: by 2002:a17:902:ea0c:b0:2a1:325b:2cba with SMTP id
 d9443c01a7336-2a1325b2e27mr95250025ad.53.1766045069032; 
 Thu, 18 Dec 2025 00:04:29 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d0889379sm16201425ad.24.2025.12.18.00.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 00:04:28 -0800 (PST)
Date: Thu, 18 Dec 2025 13:34:19 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 malysagreg@gmail.com, vasileios.bimpikas@analog.com,
 utsav.agarwal@analog.com, arturs.artamonovs@analog.com,
 nathan.morrison@timesys.com, peng.fan@nxp.com,
 kory.maincent@bootlin.com, patrice.chotard@foss.st.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 alif.zakuan.yuslaimi@altera.com, hs@nabladev.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v3 4/6] arch: arm: mach-snapdragon: Auto-detect USB SSPHY
 driver support
Message-ID: <aUO1g+0MEzrad577@hu-varada-blr.qualcomm.com>
References: <20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com>
 <20251203110735.1959862-5-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203110735.1959862-5-balaji.selvanathan@oss.qualcomm.com>
X-Proofpoint-GUID: TSTRv3tFaqyotTAjcfnXNW782wClNLvP
X-Authority-Analysis: v=2.4 cv=Z8Th3XRA c=1 sm=1 tr=0 ts=6943b58e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=sb7SZJ5qkl1fgBpHmBIA:9
 a=CjuIK1q_8ugA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: TSTRv3tFaqyotTAjcfnXNW782wClNLvP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA2NCBTYWx0ZWRfX3+9l33QgfL3n
 P2yU7D1r1GhfvR6D/JUAMeFZBvqvAYzUKn5rBkUME68EhAh5mnmQ8J0ky59gxzSPzKZy1hYzITT
 rxhCScejvqqxaemCHn7PTPXjegPzSNbWpX3LZdE4IKNlV5BSGW+IgFgQ6K+HycUzinUoDRiMZAI
 ij8iCS3mL3xeJcCLDox7K63bPmThkhdhuALIeYauRRNXBVAyBqyumUujTWRYHH6g6G9Lb/dVdaO
 9mdg3dXSUb7jr2kR5VfdQW6M+4ZH4eQDRjAMSjmjvr28bH4FsNbmYZX8ziGja36k8ChoReujkvU
 YozKjZGGdqZPYdsUAnBI7kTHLzvcvD8zFY5strlx+VZvaCR8E+5gQssql8XcC7y58I9sNhaXp8Q
 SYvp3iXTrB+jMoXqwlTbgg8IKJyCdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180064
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

On Wed, Dec 03, 2025 at 04:37:33PM +0530, Balaji Selvanathan wrote:
> Automatically detect super-speed USB PHY driver availability and
> skip the USB speed fixup if driver is available, eliminating the need
> for manual configuration.
>
> Previously, U-Boot unconditionally limited USB to high-speed mode
> on all Qualcomm platforms because most lacked super-speed PHY
> drivers.
>
> This change implements runtime detection that checks if a PHY
> driver exists for the super-speed PHY node referenced by the DWC3
> controller. The fixup is automatically skipped when a compatible
> driver is found, allowing the hardware to operate at full
> capability. Platforms without super-speed PHY drivers continue to
> receive the fixup automatically.
> ---
> v3:
> - Removed support to manually disable the fixup via Kconfig.
> - Instead added code to automatically detect if
>   SSPHY driver is available.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Move 'Signed-off-by:' above the '---' line.

> ---
>  arch/arm/mach-snapdragon/of_fixup.c | 130 ++++++++++++++++++++++++----
>  1 file changed, 112 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index eec2c0c757e..85dc1c4573d 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -4,7 +4,7 @@
>   *
>   * This file implements runtime fixups for Qualcomm DT to improve
>   * compatibility with U-Boot. This includes adjusting the USB nodes
> - * to only use USB high-speed.
> + * to only use USB high-speed if SSPHY driver is not available.
>   *
>   * We use OF_LIVE for this rather than early FDT fixup for a couple
>   * of reasons: it has a much nicer API, is most likely more efficient,
> @@ -21,32 +21,108 @@
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dm/of_access.h>
>  #include <dm/of.h>
> +#include <dm/device.h>
> +#include <dm/lists.h>
>  #include <event.h>
>  #include <fdt_support.h>
>  #include <linux/errno.h>
> +#include <linker_lists.h>
>  #include <stdlib.h>
>  #include <time.h>
>
> -/* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
> - * USB controllers. Rather than requiring source level DT changes, we fix up
> - * DT here. This improves compatibility with upstream DT and simplifies the
> - * porting process for new devices.
> +/**
> + * find_ssphy_node() - Find the super-speed PHY node referenced by DWC3
> + * @dwc3: DWC3 device node
> + *
> + * Returns: Pointer to SS-PHY node if found, NULL otherwise
> + */
> +static struct device_node *find_ssphy_node(struct device_node *dwc3)
> +{
> +	const __be32 *phandles;
> +	const char *phy_name;
> +	int len, i, ret;
> +
> +	phandles = of_get_property(dwc3, "phys", &len);
> +	if (!phandles)
> +		return NULL;
> +
> +	len /= sizeof(*phandles);
> +
> +	/* Iterate through PHY phandles to find the SS-PHY */
> +	for (i = 0; i < len; i++) {
> +		ret = of_property_read_string_index(dwc3, "phy-names", i, &phy_name);
> +		if (ret)
> +			continue;
> +
> +		/* Check if this is the super-speed PHY */
> +		if (!strncmp("usb3-phy", phy_name, strlen("usb3-phy")) ||
> +		    !strncmp("usb3_phy", phy_name, strlen("usb3_phy"))) {
> +			return of_find_node_by_phandle(NULL, be32_to_cpu(phandles[i]));
> +		}
> +	}

fixup_qcom_dwc3() somehow assumes the second phandle *will* be usb3 phy.
Can't we continue with the assumption here too?

> +
> +	return NULL;
> +}
> +
> +/**
> + * has_driver_for_node() - Check if any PHY driver can bind to this node
> + * @np: Device node to check
> + *
> + * Returns: true if a PHY driver with matching compatible string exists, false otherwise
>   */
> +static bool has_driver_for_node(struct device_node *np)
> +{
> +	struct driver *driver = ll_entry_start(struct driver, driver);
> +	const int n_ents = ll_entry_count(struct driver, driver);
> +	const char *compat_list, *compat;
> +	int compat_length, i;
> +	struct driver *entry;
> +
> +	if (!np)
> +		return false;
> +
> +	/* Get compatible strings from the node */
> +	compat_list = of_get_property(np, "compatible", &compat_length);
> +	if (!compat_list)
> +		return false;
> +
> +	/* Check each compatible string against PHY drivers only */
> +	for (i = 0; i < compat_length; i += strlen(compat) + 1) {
> +		compat = compat_list + i;
> +
> +		/* Iterate through all registered drivers */
> +		for (entry = driver; entry != driver + n_ents; entry++) {
> +			const struct udevice_id *of_match = entry->of_match;
> +
> +			/* Skip non-PHY drivers to improve performance */
> +			if (entry->id != UCLASS_PHY)
> +				continue;
> +
> +			if (!of_match)
> +				continue;

		if (entry->id != UCLASS_PHY || !of_match)
			continue;

> +			while (of_match->compatible) {
> +				if (!strcmp(of_match->compatible, compat)) {
> +					debug("Found PHY driver '%s' for SS-PHY compatible '%s'\n",
> +					      entry->name, compat);
> +					return true;
> +				}
> +				of_match++;
> +			}
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np)
>  {
> -	struct device_node *dwc3;
> +	struct device_node *dwc3, *ssphy_np;
>  	int ret, len, hsphy_idx = 1;
>  	const __be32 *phandles;
>  	const char *second_phy_name;
>
> -	debug("Fixing up %s\n", glue_np->name);
> -
> -	/* Tell the glue driver to configure the wrapper for high-speed only operation */
> -	ret = of_write_prop(glue_np, "qcom,select-utmi-as-pipe-clk", 0, NULL);
> -	if (ret) {
> -		log_err("Failed to add property 'qcom,select-utmi-as-pipe-clk': %d\n", ret);
> -		return ret;
> -	}
> +	debug("Checking USB configuration for %s\n", glue_np->name);
>
>  	/* Find the DWC3 node itself */
>  	dwc3 = of_find_compatible_node(glue_np, NULL, "snps,dwc3");
> @@ -58,20 +134,38 @@ static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np
>  	phandles = of_get_property(dwc3, "phys", &len);
>  	len /= sizeof(*phandles);
>  	if (len == 1) {
> -		log_debug("Only one phy, not a superspeed controller\n");
> +		debug("Only one phy, not a superspeed controller\n");

Undo.

>  		return 0;

Earlier, the fixup was at the top, so you can return here. Now you have
to apply the fixup in this case.

>  	}
>
> -	/* Figure out if the superspeed phy is present and if so then which phy is it? */
> +	/* Figure out if the superspeed phy is present */
>  	ret = of_property_read_string_index(dwc3, "phy-names", 1, &second_phy_name);
>  	if (ret == -ENODATA) {
> -		log_debug("Only one phy, not a super-speed controller\n");
> +		debug("Only one phy, not a super-speed controller\n");

Undo.

>  		return 0;

Can't return. Same as above.

>  	} else if (ret) {
>  		log_err("Failed to read second phy name: %d\n", ret);
>  		return ret;
>  	}
>
> +	/* Find the super-speed PHY node and check if a driver is available */
> +	ssphy_np = find_ssphy_node(dwc3);
> +	if (ssphy_np && has_driver_for_node(ssphy_np)) {
> +		debug("Skipping USB fixup for %s (SS-PHY driver available)\n",
> +		      glue_np->name);
> +		return 0;

Both the node and driver can be present. Should we consider the
possibility of phy DT node status = "disabled"?

> +	}
> +
> +	/* No driver available - apply the fixup */
> +	debug("Applying USB high-speed fixup to %s\n", glue_np->name);
> +
> +	/* Tell the glue driver to configure the wrapper for high-speed only operation */
> +	ret = of_write_prop(glue_np, "qcom,select-utmi-as-pipe-clk", 0, NULL);
> +	if (ret) {
> +		log_err("Failed to add property 'qcom,select-utmi-as-pipe-clk': %d\n", ret);
> +		return ret;
> +	}
> +
>  	/*
>  	 * Determine which phy is the superspeed phy by checking the name of the second phy
>  	 * since it is typically the superspeed one.
> @@ -150,7 +244,7 @@ static void fixup_power_domains(struct device_node *root)
>  	do { \
>  		u64 start = timer_get_us(); \
>  		func(__VA_ARGS__); \
> -		debug(#func " took %lluus\n", timer_get_us() - start); \
> +		printf(#func " took %lluus\n", timer_get_us() - start); \
>  	} while (0)
>
>  static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
> --
> 2.34.1
>
