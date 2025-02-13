Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62A0C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 13:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FAE480A55;
	Thu, 13 Feb 2025 14:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="i9MrrUG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EC0180C96; Thu, 13 Feb 2025 14:01:33 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 035CE806FE
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 14:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51DD1R6U741315
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 13 Feb 2025 07:01:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739451687;
 bh=cIaBcYC3AvYNCbs2SF/BXgBG84k0xwY1KNcueyeaoak=;
 h=Date:From:Subject:To:CC:References:In-Reply-To;
 b=i9MrrUG3/B3inD4vpt/+uFAlQIlyeGkLwzblQKKPTEC2VqnB4fnGCczxQARu70CIj
 SmFI5LilrOOjwOADkDNtpamrDkEdAFGRl40Gz8YtKhaxtiBIfZcpOopHFOrDiHijNd
 /ENY9D3fekhgg03qadr7OLpSjgryamDjVV/guVms=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51DD1Rtc047068;
 Thu, 13 Feb 2025 07:01:27 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Feb 2025 07:01:26 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Feb 2025 07:01:26 -0600
Received: from [172.24.227.18] (moteen-ubuntu-desk.dhcp.ti.com [172.24.227.18])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51DD1OHD021469;
 Thu, 13 Feb 2025 07:01:24 -0600
Message-ID: <5ea4ba59-3b98-4cc1-88c4-0ac8a47db21c@ti.com>
Date: Thu, 13 Feb 2025 18:31:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Moteen Shah <m-shah@ti.com>
Subject: Re: [EXTERNAL] Re: [RFC PATCH 2/2 v1] drivers: core: lists.c: Bind
 drivers using bootph* property in subnodes
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>
References: <20250212091820.213895-1-m-shah@ti.com>
 <20250212091820.213895-3-m-shah@ti.com>
 <CAFLszTiktZ8q54vD2Eswg2zvz2NJNZZnZgZeM91_Jcr5q-7nPg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFLszTiktZ8q54vD2Eswg2zvz2NJNZZnZgZeM91_Jcr5q-7nPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hey Simon

On 12/02/25 19:07, Simon Glass wrote:
> Hi Moteen, On Wed, 12 Feb 2025 at 02: 18, Moteen Shah 
> <m-shah@ ti. com> wrote: > > Add a function to scan through all the 
> subnodes of a given node > recusively for bootph* property. If found, 
> propagate it to all > of its parent
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK!tDdkczlA_gRXoS0MsZKL_DT2tZpXfsvUu_exS1E1jUk7Sm4iKSS-jq4dD2ZmFBvi3F-y_3fESFLg5xMd4B_mX8lyj-MIXHAbpyrcoh9f55Q5L2iNtE7kn3s$> 
>
> ZjQcmQRYFpfptBannerEnd
> Hi Moteen,
>
> On Wed, 12 Feb 2025 at 02:18, Moteen Shah<m-shah@ti.com>  wrote:
> >
> > Add a function to scan through all the subnodes of a given node
> > recusively for bootph* property. If found, propagate it to all
> > of its parent node up the hierarchy so as to bind the respective
> > drivers of the nodes in the pre-relocation stage.
> >
> > The current model skips the node if there is no bootph* found in
> > it, even if the property is present in one of the subnodes. The
> > issue is tracked in [0].
> >
> > Signed-off-by: Moteen Shah <m-shah@ti.com>
> >
> > References:
> > [0] https://urldefense.com/v3/__https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/21__;!!G3vK!W_iIPAjX_8KQ0KYkaLmMpffBZbsxQLF5MvKHbZeivm2bxn7gih_UYCufMU0pfun_xo1lK17Y$
> >
> > ---
> >  drivers/core/lists.c | 88 +++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 86 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/core/lists.c b/drivers/core/lists.c
> > index c7be504b6fc..5be556ea951 100644
> > --- a/drivers/core/lists.c
> > +++ b/drivers/core/lists.c
> > @@ -17,6 +17,7 @@
> >  #include <dm/platdata.h>
> >  #include <dm/uclass.h>
> >  #include <dm/util.h>
> > +#include <fdt_support.h>
> >  #include <fdtdec.h>
> >  #include <linux/compiler.h>
> >
> > @@ -196,6 +197,80 @@ static int driver_check_compatible(const struct udevice_id *of_match,
> >         return -ENOENT;
> >  }
> >
> > +/**
> > + * scan_and_prop_bootph() - Check if a driver matches a compatible string
> > + *
> > + * @param of_node:     Parent node for child traversal
> > + * @param fdt: Blob to use
>
> We stopped using @param, so just @of_node now
>
> Document return
Noted, will fix this up in v2.
> > + */
> > +static int scan_and_prop_bootph(ofnode node, void *fdt)
> > +{
> > +       static int bootph_index = -1;
> > +       static const char * const bootph_props[] = {
> > +               "bootph-all",
> > +               "bootph-some-ram",
> > +               "bootph-pre-ram",
> > +               "bootph-pre-sram",
>
> Since this is pre-relocation, you should only need the first two. But
> there is ofnode_pre_reloc() which you can call.
>
> BTW ofnode_pre_reloc() has the checks you have here. I'm not sure if
> this code can be dropped?:
I started with using ofnode_pre_reloc(), but the function won't return
which bootph-* property was found hence the manual checks here.
> /*
> * In regular builds individual spl and tpl handling both
> * count as handled pre-relocation for later second init.
> */
> if (ofnode_read_bool(node, "bootph-pre-ram") ||
>      ofnode_read_bool(node, "bootph-pre-sram"))
> return gd->flags & GD_FLG_RELOC;
>
>
> > +       };
> > +       int offset;
> > +       int ret = -ENOENT;
> > +       ofnode subnode;
> > +
> > +       /* Note the index where bootph-* was found and return success */
> > +       for (int i = 0; i < ARRAY_SIZE(bootph_props); i++) {
> > +               if (ofnode_read_bool(node, bootph_props[i])) {
> > +                       bootph_index = i;
> > +                       return 0;
> > +               }
> > +       }
> > +
> > +       ofnode_for_each_subnode(subnode, node) {
> > +               if (!ofnode_valid(subnode))
> > +                       continue;
> > +
> > +               ret = scan_and_prop_bootph(subnode, fdt);
> > +               if (ret != -ENOENT && ret)
> > +                       return ret;
> > +
> > +               /*
> > +                * Break the search if bootph-* is found in any of the subnodes.
> > +                * Breaking the loop early helps in avoiding unnecessary traversal
> > +                * of the sibling node given that bootph-* has been found in previous
> > +                * sibling node.
> > +                */
> > +               if (!ret)
> > +                       break;
> > +       }
> > +
> > +       /* If no bootph-* found then return no such entry */
> > +       if (ret)
> > +               return -ENOENT;
> > +
> > +       if (bootph_index != -1) {
> > +               offset = ofnode_to_offset(node);
> > +               if (offset < 0) {
> > +                       log_err("Failed to get offset %d\n", offset);
> > +                       return -EINVAL;
> > +               }
> > +
> > +               ret = fdt_increase_size(fdt, 32);
> > +               if (ret) {
> > +                       log_err("Cannot increase FDT size!\n");
> > +                       return ret;
> > +               }
> > +
> > +               ret = fdt_setprop_empty(fdt, offset, bootph_props[bootph_index]);
>
> I don't believe you need to actually add the property. It costs time
> and I don't believe anything else will read it. You should just need
> to return a value indicating whether the tag was found.
Considering a case that we are deep inside the recursion and bootph-*
is found, with the return value approach we will be able to bind the
super parent node but for nodes under this super parent, we will again
have to traverse the DT right?

One more approach I thought of was to bind the nodes in this function
itself if bootph-* is found in subnode, but for that we will require the
driver/device info of that node which we don't have at this point in the
code flow. (Again considering a node deep in the DT).

> > +               if (ret) {
> > +                       log_err("Failed to add bootph prop to node:%s ret=%d\n",
> > +                               ofnode_get_name(node), ret);
> > +                       return ret;
> > +               }
> > +               bootph_index = -1;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> >  int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
> >                    struct driver *drv, bool pre_reloc_only)
> >  {
> > @@ -205,6 +280,7 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
> >         struct driver *entry;
> >         struct udevice *dev;
> >         bool found = false;
> > +       void *fdt = (void *)gd->fdt_blob;
>
> Could you drop this var? I am hoping you don't need to change the devicetree.
Sure, if the return value approach works.
> >         const char *name, *compat_list, *compat;
> >         int compat_length, i;
> >         int result = 0;
> > @@ -256,8 +332,16 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
> >                 if (pre_reloc_only) {
> >                         if (!ofnode_pre_reloc(node) &&
> >                             !(entry->flags & DM_FLAG_PRE_RELOC)) {
> > -                               log_debug("Skipping device pre-relocation\n");
> > -                               return 0;
> > +                               if (IS_ENABLED(CONFIG_BIND_FROM_CHILD_BOOTPH)) {
> > +                                       ret = scan_and_prop_bootph(node, fdt);
> > +                                       if (ret) {
> > +                                               log_debug("Skipping device pre-relocation\n");
> > +                                               return 0;
> > +                                       }
> > +                               } else {
> > +                                       log_debug("Skipping device pre-relocation\n");
> > +                                       return 0;
> > +                               }
>
> Can you either use a bool or combine the statements so there is only
> one log_debug() ?
Noted, will fix this in v2.
> if (!IS_ENABLED(CONFIG_BIND_FROM_CHILD_BOOTPH) ||
>     scan_and_prop_bootph(node, fdt)) {
>       log_debug...
>
> >                         }
> >                 }
> >
> > --
> > 2.34.1
> >
>
> Please also add a test for this, probably to test/dm/test-fdt.c
Noted.
> Did you look at doing this in Binman?
Haven't explored much on the binman implementation, if my understanding
is correct we might have to decompile the blob and do the fixup in
blob_dtb.py likely?
If you have some more pointers on this do let me know.
> Regards,
> Simon


Thank you for the review.

Regards,
Moteen

