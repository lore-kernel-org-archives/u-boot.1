Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE01C531F7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 16:04:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36F3360A80;
	Thu, 23 Jul 2026 16:04:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qlr3jcKw9psi; Thu, 23 Jul 2026 16:04:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6C3260A77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784822676;
	bh=/KPzjhajjmRKWVpV52oCizRx32lmeoBOdDZvYFI26mI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TcNsL0meOoet2XmLHAAd4316fIAcs8H6qnGkq/tEyFl9ACAUyhZe0pr40j6Vz3fRB
	 2k4cO5cQfpKLvHXCVPQn97TXwa9JxHyAGF0lcxNSp+Jnpek4ctDwVAtgMT5oQuUIZX
	 NoA+cmNdQtghScfIHLqipc2J3M3U5QAFm3sDI/y5AENQhDh7ul//NBxgw5+A6I+5jk
	 9yQgugcgKfCgEekltesBooJTrtaQiPLOGQFEla0Cs4IzKYgT8SCbRWfHxfE2ygFZCF
	 gvE46XgQOMJaOVaC58jEpH2DfGniNvDG0ze98QMMP6Z/mZjeOQ/24wSrf4VGJ60HSM
	 dtVQGLt12/Lxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6C3260A77;
	Thu, 23 Jul 2026 16:04:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C4C0C4BF
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 16:04:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9FDB40413
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 16:04:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id miezCmzXBRxb for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 16:04:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1905240411
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1905240411
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1905240411
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 16:04:31 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6aadbafd662so233370eaf.2
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784822670; x=1785427470;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/KPzjhajjmRKWVpV52oCizRx32lmeoBOdDZvYFI26mI=;
 b=qIE1tl35drwXVuS0nM/g+EbUWgSdzN9grde+7zhAfsVbld7RBpUZoM4P9INiHShZyf
 e6DSmVuumoRB1OVIJhy51FuzcLx2fYVcE4wi6fuiOkQjD2axhA7JMwiVi3D3jIk6k5kL
 fo1+hrdrK/0z8QAktliKUtEqRF4akUh1+OMcc/vCndjFBNjWvrp+W3IRxQzCroodxqWx
 BNDbxDJLhqPbm0nPMHQ9XdacL7v66nuHytWJKeyD0VgezQHlCE7x/ygpdvg+CCtWmtVN
 TomGVtYswqI222tzZ/vlyXhn6oO5wwWIlA0AMmP9s6W6Zlex+mwlySNa8svI/cu2GDr5
 4Ggw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtfDtSJM5jGyC9vFET56KyhppFIxDpAvZClUUJmkin/6vSc3BnoMiuD3sTDewtAxf5n2tExws=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyLSCHgYTKbQfXZrJ8MwLyEbKqSxGGZN2t2Lf1wKakLi7k/Xb7k
 Hm4l71VOWTSWpQDnYAfscBKqqhgOH+dPMwwm0YyS0nSQ32FRL1B+kXHV8BA5LiyTPgI=
X-Gm-Gg: AR+sD13KXc/Zg34yeX2YfTdgEPc6kIFoz5bCAQpLBd61A3oRBCoMjYvB6O3jwzKGu8O
 UQWlEjKusrtqDYItfVJ9hIj4GeB1SQcV2gQok7p3NoBkQFnhi5bMdx/8eujXerGVkO8ueLxOvEh
 40uRAU+ppyYRWxJw+Rv/BU3KDtLGiw6W7El+f8I7gcaEQ7U2ZX3UgteAaDEs6nISecmPcd2i9n8
 vuYAeCT9BDbobN+YvjAXESJF/AqiPFcF6P/7gceGSioZULm5JoRpsXa5b7TtanOiYs/vP605Sks
 JpYsKHSUXFKgTQznV2upp/RJDYg8lnZr3RB5zwH8A2AhZC8rsIrsPUg8TZahxlgdESh0FFstWtS
 yXY4wKbhoDr1RZC+TadZeC+SIJlDfQYx5TfaE24YTw6n7NYlIQeysXBH8QFNhMlmI99tN6XASEX
 tf8kdWCapa9QCr2JUPGmAPHogcdXnhQ6Zd5AxaXi5jL1sVJgCROg==
X-Received: by 2002:a05:6820:1c92:b0:6a3:90c1:bb1f with SMTP id
 006d021491bc7-6aad404675emr1657637eaf.20.1784822670221; 
 Thu, 23 Jul 2026 09:04:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:50f7:57d3:643:9739?
 ([2600:8803:e7e4:500:50f7:57d3:643:9739])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6aae0250bbasm492980eaf.7.2026.07.23.09.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 09:04:29 -0700 (PDT)
Message-ID: <b0e0889d-3efd-4301-8784-0789f1f7e645@baylibre.com>
Date: Thu, 23 Jul 2026 11:04:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: probe parent providers on demand
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Sam Shih <sam.shih@mediatek.com>
References: <20260723-ccaione-upstream-fix-clk-probe-v1-1-6091925d72f3@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260723-ccaione-upstream-fix-clk-probe-v1-1-6091925d72f3@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784822670; x=1785427470;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/KPzjhajjmRKWVpV52oCizRx32lmeoBOdDZvYFI26mI=;
 b=C1HojpB6S5V20Sv4LTEW+S5s7QZFNxeQH6yTjQH7gB80Li00DHZ6NEnxlSBEelJ6lJ
 p8Yor9RV+GjVKokxprGGXSqD6v7Kiey0etIpTmGiLWmNbNyH+F0jb5U/u5jigfN9GNRo
 Lkttm5lAzHnxFXs768lxsThJoL9KJKvaheR1i7Ll4XA05WVsWwk7Ef5uRESFFigDGUtC
 ZIbiIeq1+pB2SX7Ku4wE0dLKY7e61k1fcEnLs2ayMnFvNylbRaB6x+OqEU/hsFh+2AYY
 +OG2zUIVEUVJuVqwLnMhWBvo8iF30S/GS1KwssVEyzJzPHUz55lbs0XmFKSHnLLIx4VP
 OSmQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=C1HojpB6
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/23/26 6:13 AM, Carlo Caione wrote:
> MediaTek splits its clock controllers into separate DM devices
> (apmixedsys, topckgen, infracfg), and a clock in one controller often
> has its parent in another. Cross-controller parent lookup goes through a
> small provider registry that each controller populates when it probes, so
> a provider's registry entry only exists once that provider has probed.
> 
> Providers set DM_FLAG_PROBE_AFTER_BIND to be probed early, but that flag
> only orders a device against its own bind; it does not guarantee that
> every provider peer has been probed before an unrelated early consumer
> requests a parent rate.
> 
> Concretely, in the SPL boot flow:
> 
>   1. The MMC device needs its clock and probes early.
>   2. That probes topckgen, which registers itself as a provider.
>   3. The MMC source is a topckgen mux whose parent is a PLL in apmixedsys.
>   4. apmixedsys has not been probed yet, so its registry slot is NULL.
>   5. The parent lookup returns -ENOENT and MMC is configured with an
>      invalid source rate.

Dang, I was hoping that probe on bind would handle all cases. I guess
SPL is probing in a different order since this works in non-SPL?

> 
> When a parent type is not registered yet, probe the MediaTek clock
> drivers that declare the common provider bind callback. This preserves
> the small provider registry while making parent lookup independent of
> peer probe order.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  drivers/clk/mediatek/clk-mtk.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index 61d718f162d..3d37d190982 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -9,6 +9,7 @@
>  #include <clk-uclass.h>
>  #include <div64.h>
>  #include <dm.h>
> +#include <dm/device-internal.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
> @@ -57,9 +58,35 @@ static enum mtk_clk_tree_type mtk_clk_tree_type_from_parent_flags(u16 flags)
>  
>  static struct udevice *mtk_clk_tree_get_provider(enum mtk_clk_tree_type type)
>  {
> +	struct uclass *uc;
> +	struct udevice *dev;
> +	int ret;
> +
>  	if (!mtk_clk_tree_type_is_provider(type))
>  		return NULL;
>  
> +	if (!mtk_clk_providers[type]) {
> +		ret = uclass_get(UCLASS_CLK, &uc);
> +		if (ret)
> +			return ERR_PTR(ret);
> +
> +		/*
> +		 * An early consumer can be probed before all provider peers
> +		 * marked for automatic probing have been visited.
> +		 */
> +		uclass_foreach_dev(dev, uc) {
> +			if (dev->driver->bind != mtk_common_clk_parent_bind)

This is a bit fragile. If we ever need to do something else on bind and
replace the callback, it would break this. And this will end up probing
clocks we might not use.

If we want to only probe the exact parent, we could check the ops. If the
ops match one of this driver, then we know the driver data will contain
the clock tree and use that to match the type. Thanks to the patch series
from Julien, this is now possible (otherwise I would have done it like
that in the first place).

> +				continue;
> +
> +			ret = device_probe(dev);
> +			if (ret)
> +				debug("Failed to probe clock device: %d\n", ret);
> +

And if we are going to have to lazily probe clocks anyway, we might
as well drop all of the bind on probe stuff.

> +			if (mtk_clk_providers[type])
> +				break;
> +		}
> +	}
> +
>  	return mtk_clk_providers[type] ?: ERR_PTR(-ENOENT);
>  }
>  
> 
> ---
> base-commit: d0c49353a648e135f269a2953dc9326505ba87de
> change-id: 20260723-ccaione-upstream-fix-clk-probe-24a27764927a
> 
> Best regards,
> --  
> Carlo Caione <ccaione@baylibre.com>
> 

So basically this, probably split into two patches (one to add lazy
probe, one to remove bind callback).

---
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 21587b2a4be..416210a5845 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -797,7 +797,6 @@ U_BOOT_DRIVER(mt7622_clk_apmixedsys) = {
 	.name = "mt7622-clock-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7622_apmixed_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7622_apmixedsys_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -808,7 +807,6 @@ U_BOOT_DRIVER(mt7622_clk_topckgen) = {
 	.name = "mt7622-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7622_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 7a91ef9761c..930ce121342 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -1170,7 +1170,6 @@ U_BOOT_DRIVER(mt7623_clk_apmixedsys) = {
 	.name = "mt7623-clock-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7623_apmixed_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7623_apmixedsys_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -1181,7 +1180,6 @@ U_BOOT_DRIVER(mt7623_clk_topckgen) = {
 	.name = "mt7623-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7623_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 433036980c0..e3232a226a2 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -746,7 +746,6 @@ U_BOOT_DRIVER(mt7629_clk_apmixedsys) = {
 	.name = "mt7629-clock-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7629_apmixed_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7629_apmixedsys_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -757,7 +756,6 @@ U_BOOT_DRIVER(mt7629_clk_topckgen) = {
 	.name = "mt7629-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7629_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index b3bc95d01cb..dcddb6b4fef 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -690,7 +690,6 @@ U_BOOT_DRIVER(mt7981_clk_apmixedsys) = {
 	.name = "mt7981-clock-fixed-pll",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_fixed_pll_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
@@ -701,7 +700,6 @@ U_BOOT_DRIVER(mt7981_clk_topckgen) = {
 	.name = "mt7981-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7981_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -720,7 +718,6 @@ U_BOOT_DRIVER(mt7981_clk_infracfg) = {
 	.name = "mt7981-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_infracfg_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index c29cddf954a..55eff05555c 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -598,7 +598,6 @@ U_BOOT_DRIVER(mt7986_clk_apmixedsys) = {
 	.name = "mt7986-clock-fixed-pll",
 	.id = UCLASS_CLK,
 	.of_match = mt7986_fixed_pll_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
@@ -609,7 +608,6 @@ U_BOOT_DRIVER(mt7986_clk_topckgen) = {
 	.name = "mt7986-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7986_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7986_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -628,7 +626,6 @@ U_BOOT_DRIVER(mt7986_clk_infracfg) = {
 	.name = "mt7986-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7986_infracfg_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 43d880f47d8..61e1bb66799 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -79,7 +79,6 @@ U_BOOT_DRIVER(mt7987_clk_apmixedsys) = {
 	.name = "mt7987-clock-fixed-pll",
 	.id = UCLASS_CLK,
 	.of_match = mt7987_fixed_pll_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
@@ -487,7 +486,6 @@ U_BOOT_DRIVER(mt7987_clk_topckgen) = {
 	.name = "mt7987-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7987_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7987_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -810,7 +808,6 @@ U_BOOT_DRIVER(mt7987_clk_infracfg) = {
 	.name = "mt7987-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7987_infracfg_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 02ccf111192..a704a86465d 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -874,7 +874,6 @@ U_BOOT_DRIVER(mt7988_clk_apmixedsys) = {
 	.name = "mt7988-clock-fixed-pll",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_fixed_pll_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
@@ -885,7 +884,6 @@ U_BOOT_DRIVER(mt7988_clk_topckgen) = {
 	.name = "mt7988-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7988_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -904,7 +902,6 @@ U_BOOT_DRIVER(mt7988_clk_infracfg) = {
 	.name = "mt7988-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_infracfg_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 94f2fe38ed9..e0a63490375 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -822,7 +822,6 @@ U_BOOT_DRIVER(mt8183_clk_apmixedsys) = {
 	.name = "mt8183-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8183_apmixed_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -833,7 +832,6 @@ U_BOOT_DRIVER(mt8183_clk_topckgen) = {
 	.name = "mt8183-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8183_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 5e395eeec5e..eb98f7fdf6a 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -1767,7 +1767,6 @@ U_BOOT_DRIVER(mt8188_clk_apmixedsys) = {
 	.name = "mt8188-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8188_apmixed_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -1778,7 +1777,6 @@ U_BOOT_DRIVER(mt8188_clk_topckgen) = {
 	.name = "mt8188-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8188_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index 5303bf916ec..10859bce02f 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -2026,7 +2026,6 @@ U_BOOT_DRIVER(mt8189_clk_apmixedsys) = {
 	.name = "mt8189-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8189_apmixed,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -2037,7 +2036,6 @@ U_BOOT_DRIVER(mt8189_clk_topckgen) = {
 	.name = "mt8189-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8189_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -2048,7 +2046,6 @@ U_BOOT_DRIVER(mt8189_clk_vlpckgen) = {
 	.name = "mt8189-vlpckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8189_vlpckgen,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index 080eded38d0..48298df8fd9 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -1631,7 +1631,6 @@ U_BOOT_DRIVER(mt8195_clk_apmixedsys) = {
 	.name = "mt8195-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8195_apmixed,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -1642,7 +1641,6 @@ U_BOOT_DRIVER(mt8195_clk_topckgen) = {
 	.name = "mt8195-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8195_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 70d29e6970b..7dffcaa52f9 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -789,7 +789,6 @@ U_BOOT_DRIVER(mt8365_clk_apmixedsys) = {
 	.name = "mt8365-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8365_apmixed_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -800,7 +799,6 @@ U_BOOT_DRIVER(mt8365_clk_topckgen) = {
 	.name = "mt8365-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8365_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index dc567402544..1c4d16d9301 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -861,7 +861,6 @@ U_BOOT_DRIVER(mt8512_clk_apmixedsys) = {
 	.name = "mt8512-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8512_apmixed_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -872,7 +871,6 @@ U_BOOT_DRIVER(mt8512_clk_topckgen) = {
 	.name = "mt8512-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8512_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 2043009d9fe..22df1422743 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -802,7 +802,6 @@ U_BOOT_DRIVER(mt8516_clk_apmixedsys) = {
 	.name = "mt8516-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8516_apmixed_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -813,7 +812,6 @@ U_BOOT_DRIVER(mt8516_clk_topckgen) = {
 	.name = "mt8516-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8516_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index 81d0b701803..f7200f679d3 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -1558,7 +1558,6 @@ U_BOOT_DRIVER(mt8518_clk_apmixedsys) = {
 	.name = "mt8518-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8518_apmixed_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -1569,7 +1568,6 @@ U_BOOT_DRIVER(mt8518_clk_topckgen) = {
 	.name = "mt8518-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8518_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 1da89b3cc48..764d209acce 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -9,6 +9,7 @@
 #include <clk-uclass.h>
 #include <div64.h>
 #include <dm.h>
+#include <dm/device-internal.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -60,6 +61,41 @@ static struct udevice *mtk_clk_tree_get_provider(enum mtk_clk_tree_type type)
 	if (!mtk_clk_tree_type_is_provider(type))
 		return NULL;
 
+	if (!mtk_clk_providers[type]) {
+		struct udevice *dev;
+		struct uclass *uc;
+		int ret;
+
+		/* Lazily probe and register provider. */
+
+		ret = uclass_get(UCLASS_CLK, &uc);
+		if (ret)
+			return ERR_PTR(ret);
+
+		uclass_foreach_dev(dev, uc) {
+			const struct mtk_clk_tree *tree;
+			const void *ops;
+
+			ops = dev_get_driver_ops(dev);
+			if (ops != &mtk_clk_apmixedsys_ops &&
+			    ops != &mtk_clk_fixed_pll_ops &&
+			    ops != &mtk_clk_topckgen_ops &&
+			    ops != &mtk_clk_infrasys_ops)
+				continue;
+
+			tree = (const void *)dev_get_driver_data(dev);
+			if (tree->type != type)
+				continue;
+
+			/* Probe will add it to mtk_clk_providers[type]. */
+			ret = device_probe(dev);
+			if (ret)
+				return ERR_PTR(ret);
+
+			break;
+		}
+	}
+
 	return mtk_clk_providers[type] ?: ERR_PTR(-ENOENT);
 }
 
@@ -1082,17 +1118,6 @@ const struct clk_ops mtk_clk_infrasys_ops = {
 #endif
 };
 
-int mtk_common_clk_parent_bind(struct udevice *dev)
-{
-	/*
-	 * Clock trees that provide parent clocks need to be probed right away
-	 * so that any clock depending on them will work correctly.
-	 */
-	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
-
-	return 0;
-}
-
 int mtk_common_clk_init(struct udevice *dev)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index d08ff24075d..aad86c0e2f2 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -270,12 +270,7 @@ struct mtk_clk_tree {
 	const int num_muxes;
 	const int num_gates;
 	u32 flags;
-	/*
-	 * Set this if this tree provides a specific type for parent lookup.
-	 * Devices that set this should also include mtk_common_clk_parent_bind()
-	 * in the driver bind function to ensure that it will be registered as
-	 * a provider.
-	 */
+	/* Set this if this tree provides a specific type for parent lookup. */
 	enum mtk_clk_tree_type type;
 };
 
@@ -289,7 +284,6 @@ extern const struct clk_ops mtk_clk_fixed_pll_ops;
 extern const struct clk_ops mtk_clk_topckgen_ops;
 extern const struct clk_ops mtk_clk_infrasys_ops;
 
-int mtk_common_clk_parent_bind(struct udevice *dev);
 int mtk_common_clk_init(struct udevice *dev);
 
 #endif /* __DRV_CLK_MTK_H */

