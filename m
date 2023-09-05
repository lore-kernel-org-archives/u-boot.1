Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96344C83F33
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 08:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8D698690B;
	Tue,  5 Sep 2023 10:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D3F686977; Tue,  5 Sep 2023 10:27:26 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 40FF58654D
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 10:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FE4C11FB;
 Tue,  5 Sep 2023 01:28:00 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C06C3F766;
 Tue,  5 Sep 2023 01:27:21 -0700 (PDT)
Date: Tue, 5 Sep 2023 09:27:12 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Hans de Goede
 <hdegoede@redhat.com>, u-boot@lists.denx.de, Samuel Holland
 <samuel@sholland.org>, Jarrah Gosbell <kernel@undef.tools>
Subject: Re: [PATCH] sunxi: board: provide CPU idle states to loaded OS
Message-ID: <20230905092712.6ba245bb@donnerap.manchester.arm.com>
In-Reply-To: <20230904205430.1647654-1-andrej.skvortzov@gmail.com>
References: <20230904205430.1647654-1-andrej.skvortzov@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon,  4 Sep 2023 23:54:30 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

Hi Andrey,

> When using SCPI as the PSCI backend, firmware can wake up the CPUs and
> cluster from sleep, so CPU idle states are available for loaded OS to
> use. TF-A modifies DTB to advertise available CPU idle states, when
> SCPI is detected. This change copies nodes added by TF-A to any new
> dtb that is used for loaded OS.

Why do you need that, exactly? Why not just use $fdtcontroladdr for the
kernel? We now keep the U-Boot copy of the .dts files in sync with the
kernel. If you need to modify the DT in U-Boot, for instance by applying
overlays, you can copy that DTB into a better suitable location first:
=> fdt move $fdtcontroladdr $fdt_addr_r

In any case, there shall be only one DT, that one in the U-Boot image. Why
do you need to load another one for the kernel?

Cheers,
Andre

> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

> ---
>  board/sunxi/board.c | 120 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index f321cd58a6..e88bd11a99 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -870,6 +870,125 @@ int board_late_init(void)
>  	return 0;
>  }
>  
> +static int cpuidle_dt_fixup_copy_node(ofnode src, int dst_offset, void *dst_blob,
> +				      u32 *count, u32 *phandle)
> +{
> +	int offs, len, ret;
> +	struct ofprop prop;
> +	ofnode subnode;
> +
> +	ofnode_for_each_prop(prop, src) {
> +		const char *name;
> +		const char *val;
> +
> +		val = ofprop_get_property(&prop, &name, &len);
> +		if (!val)
> +			return -EINVAL;
> +		if (!strcmp(name, "phandle")) {
> +			if (ofnode_device_is_compatible(src, "arm,idle-state")) {
> +				fdt_setprop_u32(dst_blob, dst_offset, name, *phandle);
> +				(*phandle)++;
> +				(*count)++;
> +			} else {
> +				log_err("Unexpected phandle node: %s\n", name);
> +				return -EINVAL;
> +			}
> +		} else {
> +			ret = fdt_setprop(dst_blob, dst_offset, name, val, len);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	ofnode_for_each_subnode(subnode, src) {
> +		const char *name = ofnode_get_name(subnode);
> +
> +		if (!name)
> +			return -EINVAL;
> +		offs = fdt_add_subnode(dst_blob, dst_offset, name);
> +		if (offs < 0)
> +			return offs;
> +		ret = cpuidle_dt_fixup_copy_node(subnode, offs, dst_blob, count, phandle);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +static int cpuidle_dt_fixup(void *blob)
> +{
> +	ofnode idle_states_node;
> +	ofnode subnode;
> +	u32 count, phandle;
> +	const struct property *prop;
> +	int offs, len, ret;
> +
> +	idle_states_node = ofnode_path("/cpus/idle-states");
> +	if (!ofnode_valid(idle_states_node)) {
> +		log_err("No idle-states node in old fdt, nothing to do");
> +		return 0;
> +	}
> +
> +	/*
> +	 * Do not proceed if the target dt already has an idle-states node.
> +	 * In this case assume that the system knows better somehow,
> +	 * so do not interfere.
> +	 */
> +	if (fdt_path_offset(blob, "/cpus/idle-states") >= 0) {
> +		log_err("idle-states node already exists in target");
> +		return 0;
> +	}
> +
> +	offs = fdt_path_offset(blob, "/cpus");
> +	if (offs < 0)
> +		return offs;
> +
> +	offs = fdt_add_subnode(blob, offs, "idle-states");
> +	if (offs < 0)
> +		return offs;
> +
> +	/* copy "/cpus/idle-states" node to destination fdt */
> +	ret = fdt_find_max_phandle(blob, &phandle);
> +	if (ret < 0)
> +		return ret;
> +	phandle++;
> +	count = 0;
> +	ret =  cpuidle_dt_fixup_copy_node(idle_states_node, offs, blob, &count, &phandle);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* copy "cpu-idle-state" property for all cpus */
> +	ofnode_for_each_subnode(subnode, ofnode_path("/cpus")) {
> +		char path[32];
> +		fdt32_t *value;
> +
> +		prop = ofnode_get_property(subnode, "cpu-idle-states", &len);
> +		if (!prop)
> +			continue;
> +
> +		/* find the same node in a new device-tree */
> +		ret = ofnode_get_path(subnode, path, sizeof(path));
> +		if (ret)
> +			return ret;
> +
> +		offs = fdt_path_offset(blob, path);
> +		if (offs < 0)
> +			return offs;
> +
> +		/* Allocate space for the list of phandles. */
> +		ret = fdt_setprop_placeholder(blob, offs, "cpu-idle-states",
> +					      count * sizeof(phandle),
> +					      (void **)&value);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Fill in the phandles of the idle state nodes. */
> +		for (u32 i = 0U; i < count; ++i)
> +			value[i] = cpu_to_fdt32(phandle - count + i);
> +	}
> +	return 0;
> +}
> +
>  static void bluetooth_dt_fixup(void *blob)
>  {
>  	/* Some devices ship with a Bluetooth controller default address.
> @@ -914,6 +1033,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>  	setup_environment(blob);
>  	fdt_fixup_ethernet(blob);
>  
> +	cpuidle_dt_fixup(blob);
>  	bluetooth_dt_fixup(blob);
>  
>  #ifdef CONFIG_VIDEO_DT_SIMPLEFB

