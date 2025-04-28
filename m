Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87559C369D3
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 11:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD264826AD;
	Mon, 28 Apr 2025 13:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mXcjLrpS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FA4682724; Mon, 28 Apr 2025 13:23:35 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B23F8269F
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 13:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53SBNTHv3525077
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Apr 2025 06:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745839410;
 bh=Lb6yVB6mVO/JP+xMNlxJ//UrEycyjVCyRRTdJan/38k=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=mXcjLrpSWj8+dLb1zv/wV0+ahJsb28QYL4DzaVRy4o4sM7mOKTYZLR9S14eNkUSnv
 VWsp76//Z0XxGS3pGbciGwf4qAZgMIDy3YjUfYf8WrPaEcWllank0rQGc/HWOr55Co
 DZ3ew3jt4aeH/t7rLGODsjfz38Wtdhvj1p2pQDHQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53SBNTCp036512
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Apr 2025 06:23:29 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Apr 2025 06:23:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Apr 2025 06:23:29 -0500
Received: from [172.24.227.136] (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53SBNQrj086495;
 Mon, 28 Apr 2025 06:23:27 -0500
Message-ID: <8e4b59f2-687a-4f02-a779-960c79b7de59@ti.com>
Date: Mon, 28 Apr 2025 16:53:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wip: binman: Move processing after templates
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Neha Malcom Francis
 <n-francis@ti.com>, Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan
 <peng.fan@nxp.com>, Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, Tom Rini
 <trini@konsulko.com>
References: <20250423123009.779628-1-sjg@chromium.org>
 <20250423123009.779628-3-sjg@chromium.org>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <20250423123009.779628-3-sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hey Simon,
Thanks for the suggestions and review.

On 23/04/25 17:59, Simon Glass wrote:
> Do the bootph processing after templates are handled, since templates
> can change the tree structure quite a bit.
>
> Also avoid changing the u-boot.dtb file since that is an input to Binman
>
> Add some other suggested code tweaks:
> - Only sync the dtb if something changed
> - add more comments
>
> Note: This patch is just for illustration; please just combine it into
> your existing work.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   tools/binman/control.py | 70 +++++++++++++++++++++++++++--------------
>   1 file changed, 46 insertions(+), 24 deletions(-)
>
> diff --git a/tools/binman/control.py b/tools/binman/control.py
> index b703bdf482e..6b7c5507513 100644
> --- a/tools/binman/control.py
> +++ b/tools/binman/control.py
> @@ -530,34 +530,55 @@ def _RemoveTemplates(parent):
>       for node in del_nodes:
>           node.Delete()
>   
> -def prop_bootph_to_parent(node, prop):
> -    """Propagates bootph-* property to all the parent
> -    nodes up the hierarchy
> -    """
> -    parent = node.parent
> -    if parent == None or parent.props.get(prop):
> -       return
> +def propagate_bootph(node, prop):
> +    """Propagate bootph-* property to all the parent nodes up the hierarchy
> +
> +    Args:
> +        node (fdt.Node): Node to propagate the property to
> +        prop (str): Property to propagate
>   
> -    while parent:
> -        parent.AddEmptyProp(prop, 0)
> -        parent = parent.parent
> +    Return:
> +        True if any change was made, else False
> +    """
> +    changed = False
> +    while node:
> +        if prop not in node.props:
> +            node.AddEmptyProp(prop, 0)
> +            changed = True
> +        node = node.parent
> +    return changed
>   
>   def scan_and_prop_bootph(node):
> -    """Scan the device tree and set the bootph-* property if its present
> -    in subnode
> +    """Propagate bootph properties from children to parents
> +
> +    The bootph schema indicates that bootph nodes in children should be implied
> +    in their parents, all the way up the hierarchy. This is expensive to
> +    implement in U-Boot before relocation, so this function explicitly
> +    propagates these bootph properties upwards.
>   
>       This is used to set the bootph-* property in the parent node if a
> -    "bootph-*" property is found in any of the subnodes of the parent
> -    node.
> +    "bootph-*" property is found in any of the parent's subnodes.
> +
> +    Args:
> +        node (fdt.Node): Node to propagate the property to
> +        prop (str): Property name to propagate
> +
> +    Return:
> +        True if any change was made, else False
> +
>       """
> -    bootph_prop = ['bootph-all', 'bootph-some-ram', 'bootph-pre-ram', 'bootph-pre-sram']
> +    bootph_prop = ['bootph-all', 'bootph-some-ram', 'bootph-pre-ram',
> +                   'bootph-pre-sram']
>   
> -    for props in bootph_prop:
> -        if node.props.get(props):
> -            prop_bootph_to_parent(node, props)
> +    changed = False
> +    for prop in bootph_prop:
> +        if prop in node.props:
> +            changed |= propagate_bootph(node.parent, prop)
>   
>       for subnode in node.subnodes:
> -       scan_and_prop_bootph(subnode)
> +        changed |= scan_and_prop_bootph(subnode)
> +    return changed
> +
>   
>   def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, indir):
>       """Prepare the images to be processed and select the device tree
> @@ -573,7 +594,7 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
>           dtb_fname: Filename of the device tree file to use (.dts or .dtb)
>           selected_images: List of images to output, or None for all
>           update_fdt: True to update the FDT wth entry offsets, etc.
> -        use_expanded: True to use expanded versions of entries, if available.
> +        use_expanded: True to use expanded versions osf entries, if available.
>               So if 'u-boot' is called for, we use 'u-boot-expanded' instead. This
>               is needed if update_fdt is True (although tests may disable it)
>           indir: List of directories where input files can be found
> @@ -596,10 +617,8 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
>           indir = []
>       dtb_fname = fdt_util.EnsureCompiled(dtb_fname, indir=indir)
>       fname = tools.get_output_filename('u-boot.dtb.out')
> -    dtb = fdt.FdtScan(dtb_fname)
> -    scan_and_prop_bootph(dtb.GetRoot())
> -    dtb.Sync(True)
> -    tools.write_file(dtb_fname, dtb.GetContents())
> +    tools.write_file(fname, tools.read_file(dtb_fname))
> +    dtb = fdt.FdtScan(fname)
>   
>       node = _FindBinmanNode(dtb)
>       if not node:
> @@ -620,6 +639,9 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
>           fname = tools.get_output_filename('u-boot.dtb.tmpl2')
>           tools.write_file(fname, dtb.GetContents())
>   
> +    if scan_and_prop_bootph(dtb.GetRoot()):
> +        dtb.Sync(True)
> +

I applied the suggested changes, u-boot.dtb.out does shows the bootph-* 
being propagated on reverse compiling, but
on reverse compiling u-boot.dtb I cannot see the same behavior. I think 
we might have to make an explicit call to sync
the two of them somehow because the dtb.Sync() here as per my 
understanding is syncing the changes done back to
u-boot.dtb.out.

Any pointers on how I can make the changes reflect in u-boot.dtb without 
doing this:

tools.write_file(dtb_fname, dtb.GetContents())


Regards,
Moteen
>       images = _ReadImageDesc(node, use_expanded)
>   
>       if select_images:
