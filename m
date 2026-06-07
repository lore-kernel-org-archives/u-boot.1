Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B47CD8C88
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 05:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 786C5847C6;
	Sun,  7 Jun 2026 07:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="TI/f5FJ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50FED83314; Sun,  7 Jun 2026 05:41:22 +0200 (CEST)
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F176B80433
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 05:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780803674; x=1781062874;
 bh=thFAE96G5F48htQIwoF0rrvAduhnoXwejr0PKpWvMM4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=TI/f5FJ91zYD+/Oc0lhyadVz1gBKjKCPQXC1i9N7KJna8f8ymtm9UfMk4TEnKasZK
 qkXPJesUu4IW0QpHpV3CmlcbB3NMZ+vfawU1lcl+MxyKqUsYC9RbmKRJQpxgxtQwNw
 J6wRUa2XgU28khNlRRGrATIidcwnrA2Pm5H2fScAFo1HbIDSKByz2+A4jAPiY0Yq+G
 uvF5oBiG68VXRSPC4OHkOEnKz3ak5Y9lSezmfAqIPrPD/VPrAkEvNhGxz2OpLB4qec
 2DS8EKrUJ0t7BuPgiatQgXXkIcvAdYkxnZZ27PoSardGAVnJkwfFF4yyO0GPyrvA25
 cekoSdTRn0IuQ==
Date: Sun, 07 Jun 2026 03:41:08 +0000
To: Casey Connolly <casey.connolly@linaro.org>
From: Sam Day <me@samcday.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stephan Gerhold <stephan.gerhold@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Eugen Hristev <ehristev@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Luca Weiss
 <luca.weiss@fairphone.com>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jens Reidel <adrian@mainlining.org>
Subject: Re: [PATCH RESEND 12/16] mach-snapdragon: parse incoming ARM32 ATAGS
Message-ID: <cgO5DWzGDaZEKWME-xNffa_96Cx6Br1yWmjZQu_JRydq6m57FjznPbxqVCDpyosbTIJ1W5-DjTbLXmIP7Fpu3Y-LCWMd6L3LvoXgYNNcwsw=@samcday.com>
In-Reply-To: <a03c30b1-0458-4a04-9419-965bf398e5bc@linaro.org>
References: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
 <20260601-qcom-armv7-v1-12-05a08d87e476@samcday.com>
 <4ee71802-c673-4044-9f82-b2222d9527ef@linaro.org>
 <je7E3q3sgc4pOc_A_4j_Hw-sVSHWDLknrylYkqPPklCkXjXjQUM-Mb0g0l92c9cmtudVj39hbeXBKeoYy60N0wqB4Wi4W774gSru4dlrwyo=@samcday.com>
 <a03c30b1-0458-4a04-9419-965bf398e5bc@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: cc90b791cf27d0f440c5e5dfac67b35feb298d34
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 07 Jun 2026 07:11:15 +0200
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

Hej Casey,

On Friday, 5 June 2026 at 1:01 AM, Casey Connolly <casey.connolly@linaro.or=
g> wrote:

>=20
>=20
> On 6/4/26 00:27, Sam Day wrote:
> > Heya Casey,
> >
> > On Wednesday, 3 June 2026 at 11:47 PM, Casey Connolly <casey.connolly@l=
inaro.org> wrote:
> >
> >> Hi Sam,
> >>
> >> (CC list definitely needs some tuning on the next revision XD)
> >
> > Hmm? Is it incorrect to use `b4 prep --auto-to-cc` nowadays?
>=20
> Urgh yeah I think this is a U-Boot issue with MAINTAINERS, needs some
> improvement but not your fault.
> >
> >>
> >> On 6/1/26 10:12, Sam Day via B4 Relay wrote:
> >>> From: Sam Day <me@samcday.com>
> >>>
> >>> Many (often fused) bootloaders on older ARMv7 qcom SoCs do not suppor=
t
> >>> FDTs at all, and instead pass along ATAGS in r2.
> >>>
> >>> Minimal support for parsing memory info out of these tags is introduc=
ed,
> >>> so that we can support mainline devicetrees, which expect the bootloa=
der
> >>> to populate /memory nodes.
> >>
> >> I think this should go its own armv7-specific file. It would probably
> >> also make sense to just have a separate implementation of
> >> board_fdt_blob_setup() since it's already really quite complicated.
> >
> > I was considering that as well but decided against it, since sprinkling=
 #ifdef
> > everywhere is quite ugly, and the ATAGS handling code is quite minimal.=
 Are you
> > sure it really needs to be split out?
>=20
> I would have the two implementations in different files
> >
> >>
> >> The SMEM series will do a bit of rework, in the next spin I'll probabl=
y
> >> move the caching stuff out as well, maybe I should also take
> >> board_fdt_blob_setup() then the file can be arm64 specific?
> >
> > I'm not sure how we can have a separate version of board_fdt_blob_setup=
. On
> > ARMv7, sometimes you'll br receiving ATAGS in r2, sometimes it'll be FD=
T. It
> > depends on which bootloader you're chaining from.
>=20
> I see, can we impose any limitations on this in practise?

I'm not sure what you mean here. If we want U-Boot to support chaining from
fused bootloaders on ARMv7 qcom devices, then we need to meet them where
they're at.

> If not then I
> guess this is fine. I'd like to see all this logic cleaned up a bit as
> I'm just worried about introducing bugs

FWIW, I share your concern (remember that my fingerprints are on this
unhinged function too xD) and I spent quite a bit of time looking at this
before proposing it. I also tested it on sdm845/sdm670. Happy to address
any further specific concerns you have, though.

Otherwise, it's starting to look like maybe we should abandon the
"big tent" aspirations? I have no issues with respinning this series to
introduce a separate mach-snapdragon-armv7 to avoid any potential breakages
for newer hardware. As you can see, these older SoCs are different enough
from "modern qcom" that we're not really gaining much by co-habitating
everything.

>=20
> At the very least I'd like it if the atags parsing was moved to a
> different file then here we can do if
> (CONFIG_IS_ENABLED(...SNAPDRAGON_ARM32)
> =09qcom_parse_atags()

I've queued up that change for v2. Note that it's still slightly messy.
The anonymous prevbl_ddr_banks struct definition and ddr_bank_cmp prototype
need to be hoisted into qcom-priv.h so that atags.c can use them.

>=20
> the compiler will optimise out the function call so there's no need for
> a stub version

Huh, TIL. That's very useful to know thanks :D

Peace,
-Sam

>=20
> >
> > e.g my nokia-fame can run U-Boot directly chained from SBL3 since the b=
ootchain
> > on this device has been broken enough, in which case U-Boot gets ATAGS.=
 My
> > samsung-expressltexx chains from lk2nd, in which case U-Boot gets an FD=
T.
> >
> > Cheers,
> > -Sam
> >
> >>
> >>>
> >>> Signed-off-by: Sam Day <me@samcday.com>
> >>> ---
> >>>    arch/arm/mach-snapdragon/board.c | 119 +++++++++++++++++++++++++++=
+++---------
> >>>    1 file changed, 91 insertions(+), 28 deletions(-)
> >>>
> >>> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdra=
gon/board.c
> >>> index 627b566d178..753983467a0 100644
> >>> --- a/arch/arm/mach-snapdragon/board.c
> >>> +++ b/arch/arm/mach-snapdragon/board.c
> >>> @@ -11,6 +11,7 @@
> >>>
> >>>    #include <asm/gpio.h>
> >>>    #include <asm/io.h>
> >>> +#include <asm/setup.h>
> >>>    #include <asm/system.h>
> >>>    #include <dm/device.h>
> >>>    #include <dm/pinctrl.h>
> >>> @@ -175,6 +176,67 @@ static int qcom_parse_memory(const void *fdt)
> >>>    =09return 0;
> >>>    }
> >>>
> >>> +static bool qcom_atags_valid(const phys_addr_t p)
> >>> +{
> >>> +=09const struct tag *tags =3D (const struct tag *)p;
> >>> +
> >>> +=09return tags && tags->hdr.tag =3D=3D ATAG_CORE &&
> >>> +=09       tags->hdr.size >=3D sizeof(struct tag_header) / sizeof(u32=
);
> >>> +}
> >>> +
> >>> +static int qcom_parse_atags(const struct tag *tags)
> >>> +{
> >>> +=09phys_addr_t ram_end =3D 0;
> >>> +=09const struct tag *t;
> >>> +=09bool atags_end =3D false;
> >>> +=09u32 words =3D 0;
> >>> +=09int j =3D 0;
> >>> +
> >>> +=09memset(prevbl_ddr_banks, 0, sizeof(prevbl_ddr_banks));
> >>> +
> >>> +=09for (t =3D tags; words < SZ_16K / sizeof(u32); t =3D tag_next(t))=
 {
> >>> +=09=09if (t->hdr.tag =3D=3D ATAG_NONE) {
> >>> +=09=09=09atags_end =3D true;
> >>> +=09=09=09break;
> >>> +=09=09}
> >>> +=09=09if (t->hdr.size < sizeof(struct tag_header) / sizeof(u32))
> >>> +=09=09=09return -EINVAL;
> >>> +=09=09if (t->hdr.size > SZ_16K / sizeof(u32) - words)
> >>> +=09=09=09return -EINVAL;
> >>> +
> >>> +=09=09words +=3D t->hdr.size;
> >>> +
> >>> +=09=09if (t->hdr.tag !=3D ATAG_MEM)
> >>> +=09=09=09continue;
> >>> +=09=09if (t->hdr.size < tag_size(tag_mem32))
> >>> +=09=09=09return -EINVAL;
> >>> +=09=09if (!t->u.mem.size)
> >>> +=09=09=09continue;
> >>> +
> >>> +=09=09prevbl_ddr_banks[j].start =3D t->u.mem.start;
> >>> +=09=09prevbl_ddr_banks[j].size =3D t->u.mem.size;
> >>> +=09=09ram_end =3D max(ram_end, (phys_addr_t)t->u.mem.start + t->u.me=
m.size);
> >>> +=09=09j++;
> >>> +
> >>> +=09=09if (j =3D=3D CONFIG_NR_DRAM_BANKS)
> >>> +=09=09=09break;
> >>> +=09}
> >>> +
> >>> +=09if (!atags_end && j < CONFIG_NR_DRAM_BANKS) {
> >>> +=09=09log_err("Provided more memory banks than we can handle\n");
> >>> +=09=09return -EINVAL;
> >>> +=09}
> >>> +=09if (!j)
> >>> +=09=09return -ENODATA;
> >>> +
> >>> +=09qsort(prevbl_ddr_banks, j, sizeof(prevbl_ddr_banks[0]), ddr_bank_=
cmp);
> >>> +
> >>> +=09gd->ram_base =3D prevbl_ddr_banks[0].start;
> >>> +=09gd->ram_size =3D ram_end - gd->ram_base;
> >>> +
> >>> +=09return 0;
> >>> +}
> >>> +
> >>>    static void show_psci_version(void)
> >>>    {
> >>>    #ifdef CONFIG_ARM64
> >>> @@ -227,42 +289,52 @@ static void qcom_psci_fixup(void *fdt)
> >>>     */
> >>>    int board_fdt_blob_setup(void **fdtp)
> >>>    {
> >>> -=09struct fdt_header *external_fdt, *internal_fdt;
> >>> -=09bool internal_valid, external_valid;
> >>> -=09int ret =3D -ENODATA;
> >>> -
> >>> -=09internal_fdt =3D (struct fdt_header *)*fdtp;
> >>> -=09external_fdt =3D (struct fdt_header *)get_prev_bl_fdt_addr();
> >>> -=09external_valid =3D external_fdt && !fdt_check_header(external_fdt=
);
> >>> -=09internal_valid =3D !fdt_check_header(internal_fdt);
> >>> +=09int ret =3D -ENODATA, setup_ret =3D -EEXIST;
> >>> +=09struct fdt_header *internal_fdt =3D *fdtp;
> >>> +=09phys_addr_t prev_bl_arg =3D get_prev_bl_fdt_addr();
> >>> +=09bool internal_valid =3D internal_fdt && !fdt_check_header(interna=
l_fdt);
> >>> +=09bool external_is_fdt =3D prev_bl_arg &&
> >>> +=09=09=09       !fdt_check_header((const void *)prev_bl_arg);
> >>>
> >>> -=09/*
> >>> -=09 * There is no point returning an error here, U-Boot can't do any=
thing useful in this situation.
> >>> -=09 * Bail out while we can still print a useful error message.
> >>> -=09 */
> >>> -=09if (!internal_valid && !external_valid)
> >>> +=09if (internal_valid) {
> >>> +=09=09debug("Using built in FDT\n");
> >>> +=09} else if (external_is_fdt) {
> >>> +=09=09debug("Using external FDT\n");
> >>> +=09=09*fdtp =3D (void *)prev_bl_arg;
> >>> +=09=09setup_ret =3D 0;
> >>> +=09} else {
> >>> +=09=09/*
> >>> +=09=09 * There is no point returning an error here, U-Boot can't do
> >>> +=09=09 * anything useful in this situation. Bail out while we can
> >>> +=09=09 * still print a useful error message.
> >>> +=09=09 */
> >>>    =09=09panic("Internal FDT is invalid and no external FDT was provi=
ded! (fdt=3D%p)\n",
> >>> -=09=09      external_fdt);
> >>> +=09=09      (void *)prev_bl_arg);
> >>> +=09}
> >>>
> >>>    =09/* Prefer memory information from internal DT if it's present *=
/
> >>>    =09if (internal_valid)
> >>>    =09=09ret =3D qcom_parse_memory(internal_fdt);
> >>>
> >>> -=09if (ret < 0 && external_valid) {
> >>> +=09if (ret < 0 && prev_bl_arg) {
> >>>    =09=09/* No internal FDT or it lacks a proper /memory node.
> >>>    =09=09 * The previous bootloader handed us something, let's try th=
at.
> >>>    =09=09 */
> >>>    =09=09if (internal_valid)
> >>>    =09=09=09debug("No memory info in internal FDT, falling back to ex=
ternal\n");
> >>>
> >>> -=09=09ret =3D qcom_parse_memory(external_fdt);
> >>> +=09=09/* the prev BL arg is either an FDT or ATAGS */
> >>> +=09=09if (external_is_fdt)
> >>> +=09=09=09ret =3D qcom_parse_memory((const void *)prev_bl_arg);
> >>> +=09=09if (ret < 0 && qcom_atags_valid(prev_bl_arg))
> >>> +=09=09=09ret =3D qcom_parse_atags((const struct tag *)prev_bl_arg);
> >>>    =09}
> >>>
> >>>    =09if (ret < 0)
> >>>    =09=09panic("No valid memory ranges found!\n");
> >>>
> >>> -=09/* If we have an external FDT, it can only have come from the And=
roid bootloader. */
> >>> -=09if (external_valid)
> >>> +=09/* If we have a prev BL arg, we assume it came from ABL */
> >>> +=09if (prev_bl_arg)
> >>>    =09=09qcom_boot_source =3D QCOM_BOOT_SOURCE_ANDROID;
> >>>    =09else
> >>>    =09=09qcom_boot_source =3D QCOM_BOOT_SOURCE_XBL;
> >>> @@ -270,18 +342,9 @@ int board_fdt_blob_setup(void **fdtp)
> >>>    =09debug("ram_base =3D %#011lx, ram_size =3D %#011llx\n",
> >>>    =09      gd->ram_base, (unsigned long long)gd->ram_size);
> >>>
> >>> -=09if (internal_valid) {
> >>> -=09=09debug("Using built in FDT\n");
> >>> -=09=09ret =3D -EEXIST;
> >>> -=09} else {
> >>> -=09=09debug("Using external FDT\n");
> >>> -=09=09*fdtp =3D external_fdt;
> >>> -=09=09ret =3D 0;
> >>> -=09}
> >>> -
> >>>    =09qcom_psci_fixup(*fdtp);
> >>>
> >>> -=09return ret;
> >>> +=09return setup_ret;
> >>>    }
> >>>
> >>>    /*
> >>>
> >>
> >>
>=20
> 
