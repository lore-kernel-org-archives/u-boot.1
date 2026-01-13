Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3383D2F358
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 18:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07067800AB;
	Tue, 13 Jan 2026 19:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="YD3chj/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC8D0800AE; Tue, 13 Jan 2026 19:13:22 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B08580077
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 19:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1768327999;
 bh=OcOi6F8M7wUrwWYeuWA3ldkJiXBEwjqhUnYZsbbhIeo=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=YD3chj/pC83VINs7xyyJhy7a6Q+3uom9+s5Lvixeepf9yvI8OqU2fo04y5S6UCTlY
 HUPKovj9rO2OnTWmUQ2TgfOcQ8a2DUyU7em1c7DegFx9/KbxLJTZyrfjDwXFQzK03j
 N/FDA7xQD5tzsEeVgJUy4lTDmOQza5z1iFsApQn3az14Ja0PXP8IN1FAHJFHKE/d7C
 TqqmddGR7yxMm1WYRfHmq9FyDizabgKEnjnAP/AdKXlHeE9yaqTg8zB/HdvJN42s8/
 942fnYC9MQ9TxB4Q6wX99BPP9CzUgAVbLQgNTVEubPcN3hDNdlZzpb+rmvGHeGGKvg
 aggeetMUPNuKw==
Received: from [IPV6:2605:59c0:2078:cf00:c0b6:e37b:5515:2b98] (unknown
 [IPv6:2605:59c0:2078:cf00:c0b6:e37b:5515:2b98])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 92B1CB2200ED;
 Tue, 13 Jan 2026 19:13:18 +0100 (CET)
Message-ID: <20f3a996-b1a7-4db0-a684-cd776ecc09e0@freeshell.de>
Date: Tue, 13 Jan 2026 10:13:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: u-boot.dtsi also possible for dtso?
To: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de
References: <trinity-3f748198-84ca-4da1-a48d-3f6e1c1818af-1767437709081@trinity-msg-rest-gmx-gmx-live-5bb597646f-r2jdb>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <trinity-3f748198-84ca-4da1-a48d-3f6e1c1818af-1767437709081@trinity-msg-rest-gmx-gmx-live-5bb597646f-r2jdb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Frank,

On 1/3/26 02:55, Frank Wunderlich wrote:
> Hi,
> 
> i make new attempt to change mediatek boards to OF_UPSTREAM because i found out, that dtbo merging is now possible.
> 
> but i faced a problem:
> 
> e.g. BPI-R3 has 2 SPI-devices (nand,nor) on same spi switchable via hw. i need both in dts to probe the right
> device for linux and to allow install from sdmmc to both of these devices based on hw switch.
> 
> currently in uboot the nor is device 0 (unit-address and reg) and nand is 1. this does not work in linux, so i need a
> way to overwrite the dtso from linux with the new values in uboot.
> 
> for dts there is a way using -u-boot.dtsi files...do they also work for dtso? where do they need to be placed?
> 
> regards Frank

Define compile time DEVICE_TREE_DEBUG=1 for verbose output, however the
output is not very helpful. You might be interested in the patch v2 I
posted "scripts/Makefile.lib: increase detail for dtsi debug output":

https://lore.kernel.org/u-boot/20250901094506.647427-1-e@freeshell.de/

The strategy I settled on for contributions toward OF_UPSTREAM enabled
starfive_visionfive2_defconfig is to avoid that automatic selection so
that it is reserved for local development use, and to explicitly bring
in binman and U-Boot specific override dtsi snippets via the
CONFIG_DEVICE_TREE_INCLUDES symbol:

https://lore.kernel.org/u-boot/20250917000254.1134031-5-e@freeshell.de/

For context of the order of how these things are implemented, firstly is
the automatic inclusion iterating over the first match of any of:
[active make target]-u-boot.dtsi,
{CONFIG_SYS_SOC,CONFIG_SYS_CPU,CONFIG_SYS_VENDOR}-u-boot.dtsi,
u-boot.dtsi  (these are around line 200 of scripts/Makefile.lib)

and then followed by the list from CONFIG_DEVICE_TREE_INCLUDES symbol in
addition to the former. That, when there is not usually any user of the
automatic inclusion, permits the developer to insert (as automatic
include) some devicetree nodes or include statements referring to local
Linux kernel source tree i.e., while preserving any binman configuration
that gets brought in by the CONFIG_DEVICE_TREE_INCLUDES list following
it. I've sent several RFC patch series this way to just touch an empty
placeholder file in dts/upstream/src/... so the build system will see
that as a target and adopt the automatic inclusion dtsi for that target
name; later when upstream changes filter down to devicetree-rebasing I
send a new revision dropping the RFC prefix for the series and drop the
patches responsible for the placeholder file and any corresponding
automatic inclusion dtsi file with the now-redundant content.

I don't know specifically anything to do with dtbo, yet, but I hope this
helps you in your search for answers. I'm interested in what you may
figure out as it may also be applicable to the many possible
configurations of Milk-V Mars CM system-on-module boards (in Raspberry
Pi CM4 compatible form-factor).

-E
