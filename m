Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC19E77170
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 19:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01D3488ECB;
	Wed,  4 Dec 2024 20:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="Vt9vgSK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B68589464; Wed,  4 Dec 2024 20:57:33 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A8488EC9
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 20:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eabachinin@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id F0D3712000A;
 Wed,  4 Dec 2024 22:57:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru F0D3712000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1733342247;
 bh=fR0n5gBSZ8EKUhhNm2xUaMVbNj/w45VLqpsbqqBru0Y=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
 b=Vt9vgSK081PTbhs8N0nlTw/79fo9hCRBya6QT2ks+UBJBgNla928mspcrpzK4atpW
 3TtKq1a/XzbnkQZ1BLDQu99XRqDikeQrptM+oojqjKSy+GhNTA5Hp3liTT4Wy3wL/M
 eqjrJyeoH04HqAeOcessGVduQq/51YFk4lX/1z/GJTbQ27XEumFrJjw3JfzZdGi+sK
 mPyP3nw9bLXplmnXyZxaMsViIe4VIGexldv0f/SxqrBzymehdF69z9PuRRDxjxiq/G
 KM4fqdlxbBdD+bjnrHt1UuhSo0XFWD6dY/Z8NgitiBdhVFfrXDqppFfLMFVV58fEMP
 rQd1J43/WA23Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed,  4 Dec 2024 22:57:27 +0300 (MSK)
Date: Wed, 4 Dec 2024 22:57:26 +0300
From: Evgeny Bachinin <eabachinin@salutedevices.com>
To: Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 "Sughosh Ganu" <sughosh.ganu@linaro.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Christian Marangi <ansuelsmth@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, <kernel@salutedevices.com>,
 <evgen89bachinin@gmail.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] common: relocate fdt_blob in global_data for
 FDTSRC_EMBED case
Message-ID: <tqejglhbc2qgqjzlmidkmscm37fxoamkkw6tyeylyfvngatrv2@ppbyancgyakr>
References: <20241125-of_embed_fdt_blob_garbage-v1-1-faa78e2e1ee9@salutedevices.com>
 <35slrpavqjk23bsybse752vmwsjqzk3ej6stozo3gtlbpe5pfg@3rytobz4ewik>
 <CAFLszTgEKamsa6FTnjzrEWQBLkqAR7EBbZqffx09AKgQ7ppuVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFLszTgEKamsa6FTnjzrEWQBLkqAR7EBbZqffx09AKgQ7ppuVA@mail.gmail.com>
User-Agent: NeoMutt/20231006
X-Originating-IP: [172.28.227.91]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189626 [Dec 04 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 44 0.3.44
 5149b91aab9eaefa5f6630aab0c7a7210c633ab6, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 salutedevices.com:7.1.1; 127.0.0.199:7.1.2; github.com:7.1.1;
 smtp.sberdevices.ru:5.0.1,7.1.1; docs.u-boot.org:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/12/04 19:06:00
X-KSMG-LinksScanning: Clean, bases: 2024/12/04 19:06:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/12/04 11:51:00 #26935746
X-KSMG-AntiVirus-Status: Clean, skipped
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

Hello Simon,
please, see below

On Tue, Dec 03, 2024 at 08:55:15AM -0700, Simon Glass wrote:
> Hi Evgeny,
> 
> On Fri, 29 Nov 2024 at 03:03, Evgeny Bachinin
> <eabachinin@salutedevices.com> wrote:
> >
> > Hello, dear reviewers!
> >
> > It was my 1st attempt to use b4-tool and it did not list all relevant
> > reviewers.
> >
> > So, let me manually CC relevant stakeholders/maintainers.
> > Please, take a look on the fix of bug/vulnerability
> >
> > P.S. If you wish, advise me, please, whether I need to re-send with
> > updated CC list or just publish v2.
> >
> > On Mon, Nov 25, 2024 at 12:15:07PM +0300, Evgeny Bachinin wrote:
> > > Patch resolves two kind of bugs, one of which is vulnerability related
> > > to KASLR.
> > >
> > > === Issue briefly ===
> > >
> > >   Working with FDT (via non-relocated gd::fdt_blob) from inside bootm
> > > command may lead to the reading the garbage instead of FDT nodes. And
> > > this can result in various side-effects depending on DTS nodes, being
> > > parsed during bootm.
> > >
> > >   But below is my specific story how I faced with this issue due to
> > > MESON_RNG probing failure.
> > >
> > > === Bugs description ===
> > >
> > > 1) Bug is revealed on:
> > > * configuration below
> > > * U-boot 2024.10 - f919c3a889f ("Prepare v2024.10")
> > >
> > >   It seems, the following patch is a trigger:
> > > ea955eea4f ("fdt: automatically add /chosen/kaslr-seed if DM_RNG is enabled")
> > >
> > >   Generally, CONFIG_OF_EMBED=y & CONFIG_RNG_MESON=y are the most
> > > valuable ones for reproducing the issue.
> > > ```
> > >   CONFIG_ARCH_FIXUP_FDT_MEMORY=y
> > >   CONFIG_CMD_FDT=y
> > >   CONFIG_DEFAULT_FDT_FILE=""
> > >   CONFIG_FDT_64BIT=y
> > >   CONFIG_OF_BOARD_SETUP=y
> > >   CONFIG_OF_CONTROL=y
> > >   CONFIG_OF_EMBED=y
> > >   CONFIG_OF_LIBFDT_ASSUME_MASK=0x0
> > >   CONFIG_OF_LIBFDT_OVERLAY=y
> > >   CONFIG_OF_LIBFDT=y
> > >   CONFIG_OF_LIST="meson-axg-our-device-name"
> > >   CONFIG_OF_REAL=y
> > >   CONFIG_OF_TRANSLATE=y
> > >   CONFIG_SUPPORT_OF_CONTROL=y
> > >   CONFIG_SYS_FDT_PAD=0x3000
> > >   CONFIG_TOOLS_OF_LIBFDT=y
> > >
> > >   CONFIG_DM_RNG=y
> > >   CONFIG_RNG_MESON=y
> > > ```
> > >
> > > 2) Due to CONFIG_OF_EMBED, the DTS is embedded into U-boot ELF and
> > > accessible via __dtb_dt_begin symbol.
> > >
> > >   On early boot stage (board_f.c) the fdtdec_setup() is called only
> > > once before U-boot's relocation into top of RAM. fdtdec_setup()
> > > initializes gd::fdt_blob for FDTSRC_EMBED case:
> > > ```
> > >   gd->fdt_blob = dtb_dt_embedded();
> > >   gd->fdt_src = FDTSRC_EMBED;
> > > ```
> > >
> > > 3) Then reloc_fdt() is called in board_f.c
> > >
> > >   But due to CONFIG_OF_EMBED=y the reloc_fdt() does not update
> > > gd::fdt_blob value (strictly speaking, it is impossible for
> > > CONFIG_OF_EMBED=y, because U-boot ELF has not been relocated yet
> > > at this moment).
> > >
> > >   As a result after relocation we get fdt_blob, pointing to DTS address
> > > before relocation:
> > > ```
> > >    # bdinfo
> > >   <...>
> > >   relocaddr = 0x000000000fedf000
> > >   reloc off = 0x000000000eedf000
> > >   <...>
> > >   fdt_blob = 0x010ce6c0 << points to __dtb_dt_begin before relocation
> > >   new_fdt = 0x0000000000000000  << empty erroneously
> > >   fdt_size = 0x0000000000000000 << zero erroneously
> > > ```
> > >
> > > 4) During bootm command (according to our ITS-config file) the Linux
> > > is loaded into 0x01080000 (which is very close to fdt_blob addr
> > > 0x010ce6c0).
> > > ```
> > >   ## Loading kernel from FIT Image at 04000000 ...
> > >      Trying 'kernel' kernel subimage
> > >        <...>
> > >        Load Address: 0x01080000
> > > ```
> > >
> > >   So Linux image overwrites the gd::fdt_blob memory location
> > > in RAM (0x010ce6c0).
> > >
> > > 5) Issue:
> > >
> > >   Hence any manipulation with DTS (say, via FDT API) inside
> > > implementation of bootm command leads to accessing the fdt_blob area
> > > with garbage, that can lead to two situations:
> > >
> > > 5.1) Abort.
> > >
> > >   Call to fdt_off_dt_struct() from fdt_next_tag() :: fdt_offset_ptr()::
> > > fdt_offset_ptr_() returns with garbage, that leads to tagp value
> > > being out of RAM top addr (256 Mb in our board), causing the abort:
> > > ```
> > >   Boot cmd: bootm 0x4000000#boot_evt1
> > >   bootm_run_states()
> > >   <...>
> > >   image_setup_libfdt()
> > >    fdt_chosen()
> > >     fdt_kaslrseed()
> > >      uclass_get_device()
> > >       uclass_get_device_tail()
> > >        device_probe()
> > >         device_of_to_plat()
> > >         meson_rng_of_to_plat()
> > >          clk_get_by_name_optional()
> > >           clk_get_by_name()
> > >            clk_get_by_name_nodev()
> > >             ofnode_stringlist_search()
> > >              fdt_stringlist_search()
> > >               fdt_getprop()
> > >                fdt_get_property_namelen_()
> > >                 fdt_first_property_offset()
> > >                  fdt_check_node_offset_()
> > >                   fdt_next_tag():
> > >                     ```
> > >                       tagp = fdt_offset_ptr(fdt, offset, FDT_TAGSIZE);
> > >                     ```
> > >                   fdt_next_tag() tagp:0x22890766
> > >                   fdt_next_tag() ram_top:0x10000000 (tagp OUT of RAM)
> > >   "Synchronous Abort" handler, esr 0x96000010, far 0x22890766
> > >   elr: 000000000108be24 lr : 000000000108be24 (reloc)
> > >   elr: 000000000ff6fe24 lr : 000000000ff6fe24
> > >   x0 : 0000000000000041 x1 : 0000000000000000
> > >   x2 : 000000000ff3b57c x3 : 0000000000000012
> > >   x4 : 000000000ded2ad5 x5 : 0000000000000020
> > >   x6 : 00000000ffffffe8 x7 : 000000000ded2f40
> > >   x8 : 00000000ffffffd8 x9 : 000000000000000d
> > >   x10: 0000000000000006 x11: 000000000001869f
> > >   x12: 000000000fffffff x13: 000000000fffffff
> > >   x14: 0000000000000000 x15: 000000000ded2abb
> > >   x16: 000000000ff3b080 x17: 0000000000000001
> > >   x18: 000000000ded3dc0 x19: 0000000022890766
> > >   x20: 00000000010cb0f0 x21: 00000000000015e4
> > >   x22: 000000000ff8f4d8 x23: 000000000000000b
> > >   x24: 000000000ded2fbc x25: 000000000ffe2000
> > >   x22: 000000000ff8f4d8 x23: 000000000000000b
> > >   x24: 000000000ded2fbc x25: 000000000ffe2000
> > >   x26: 000000000ffe2000 x27: 000000000000000b
> > >   x28: 000000000ff9cf2d x29: 000000000ded2f40
> > >
> > >   Code: aa1603e1 91197484 52801742 94004de8 (b9400276)
> > > ```
> > >
> > > 5.2) Vulnerability situation "KASLR is disabled".
> > >
> > > Almost the same as in (5.1), but 2 situations happen (depending on
> > > the value of garbage):
> > >   * call to fdt_offset_ptr_() :: fdt_off_dt_struct(fdt)
> > >     returns not so big garbage, leading to tagp, being inside RAM.
> > >   * or calculations of absoffset inside fdt_offset_ptr() leads to
> > >     failure of the one of if() conditions with NULL as retval.
> > >
> > >   Result is fdt_next_tag() interprets the tagp as FDT_END. And we are
> > > returning from our callstack via functions' error paths, leading to
> > > "No RNG device" and "KASLR disabled due to lack of seed":
> > > ```
> > >   fdt_kaslrseed()
> > >    uclass_get_device()
> > >    <...>
> > >     device_probe()
> > >      device_of_to_plat()
> > >       meson_rng_of_to_plat()
> > >        clk_get_by_name()
> > >         clk_get_by_name_nodev()
> > >         <...>
> > >          fdt_stringlist_search()
> > >           fdt_getprop()
> > >            fdt_get_property_namelen_()
> > >             fdt_first_property_offset()
> > >              fdt_check_node_offset_()
> > >               fdt_next_tag():
> > >                 ```
> > >                   tagp = fdt_offset_ptr(fdt, offset, FDT_TAGSIZE);
> > >                 ```
> > >               fdt_next_tag() tagp:0000000001890677
> > >               fdt_next_tag() ram_top:0x10000000 (tagp is inside RAM)
> > >       uclass_get_device_tail():486 device_probe() ret:-22
> > >   No RNG device
> > >  Starting kernel ...
> > >
> > >   [ 0.000000] Linux version 6.9.12
> > >   [ 0.000000] KASLR disabled due to lack of seed
> > > ```
> > >
> > > Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
> > > ---
> > > Tested:
> > > * on board with Amlogic AXG SoC.
> > > * on sandbox: make sure that certain code from patch is called (of
> > >   course, when CONFIG_OF_EMBED=y)
> > > * U-boot CI: https://github.com/u-boot/u-boot/pull/698/checks
> > > ---
> > >  common/board_r.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/common/board_r.c b/common/board_r.c
> > > index 62228a723e12f8742437acae380e82f79903a8f5..88dc756b2a5e5a44f55f9b0fd012adc798a8afdb 100644
> > > --- a/common/board_r.c
> > > +++ b/common/board_r.c
> > > @@ -152,6 +152,15 @@ static int initr_reloc_global_data(void)
> > >        */
> > >       gd->env_addr += gd->reloc_off;
> > >  #endif
> > > +
> > > +     /*
> > > +      * For CONFIG_OF_EMBED case the FDT is embedded into ELF, available by
> > > +      * __dtb_dt_begin. After U-boot ELF self-relocation to RAM top address
> 
> U-Boot
> 
> > > +      * it is worth to update fdt_blob in global_data
> > > +      */
> > > +     if (IS_ENABLED(CONFIG_OF_EMBED))
> > > +             gd->fdt_blob = dtb_dt_embedded();
> > > +
> > >  #ifdef CONFIG_EFI_LOADER
> > >       /*
> > >        * On the ARM architecture gd is mapped to a fixed register (r9 or x18).
> > >
> > > ---
> > > base-commit: cca05617a8f585f3a98a8fa82f75cc68a530d771
> > > change-id: 20241119-of_embed_fdt_blob_garbage-ea729a8236e1
> > >
> > > Best regards,
> > > --
> > > Evgeny Bachinin <EABachinin@salutedevices.com>
> 
> Note that OF_EMBED is a development feature[1], for debugging with
> JTAG, etc.


Yes, that's right.

  Due to the legacy, it's ok for us (for now) when dtb is inside U-Boot
ELF. We are migrating from Amlogic vendor source code base into
upstream one and chose more obvious and fast way (OF_EMBED), available
and workable both in vendor's (old) U-Boot and in upstream one.
One day, we will get rid of OF_EMBED, being fully on mainline
sources...

Nevertheless, option exists and it is not prohibited for usage. And as
my patch reveals there were bugs, one of which led to KASLR disabled
on real production board.


> Which board is this?

Our production device is based on Amlogic SoC A113X (AXG family) and
is not public. The closest board is S400 [1].


> Also, you should normally disable relocation (with gd->flags
> GD_FLG_SKIP_RELOC) when using OF_EMBED, since the code ends up
> elsewhere, which is a pain when debugging.

Thank you for your advise! I'll take it into account.


> This macro is for use by fdtgrep...perhaps I should have added an
> underscore at the end to make that clear.

Sorry, did not grasp your comment.
What macro?
P.S I tried to guess you talked about FDTSRC_EMBED or OF_EMBED, but
anyway I can't relate them with fdtgrep by seeking in repo.


> So please add a function in
> fdtdec to handle this, calling it from initr_reloc_global_data(),
> perhaps.

Have I understood you right?
You meant to move initialization of fdt_blob by dtb_dt_embedded() into
a separate function something like this:
```
diff --git a/common/board_r.c b/common/board_r.c
index abe2395346..424954ea67 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -159,7 +159,7 @@ static int initr_reloc_global_data(void)
 	 * it is worth to update fdt_blob in global_data
 	 */
 	if (IS_ENABLED(CONFIG_OF_EMBED))
-		gd->fdt_blob = dtb_dt_embedded();
+		fdtdec_setup_embed()

 #ifdef CONFIG_EFI_LOADER
 	/*
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 6865f78c70..484954a262 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1664,6 +1664,12 @@ static void setup_multi_dtb_fit(void)
 	}
 }

+void fdtdec_setup_embed(void)
+{
+	gd->fdt_blob = dtb_dt_embedded();
+	gd->fdt_src = FDTSRC_EMBED;
+}
+
 int fdtdec_setup(void)
 {
 	int ret = -ENOENT;
@@ -1698,8 +1704,7 @@ int fdtdec_setup(void)
 			gd->fdt_blob = fdt_find_separate();
 			gd->fdt_src = FDTSRC_SEPARATE;
 		} else { /* embed dtb in ELF file for testing / development */
-			gd->fdt_blob = dtb_dt_embedded();
-			gd->fdt_src = FDTSRC_EMBED;
+			fdtdec_setup_embed();
 		}
 	}
```


[1] https://docs.u-boot.org/en/latest/board/amlogic/s400.html

Kind regards,
