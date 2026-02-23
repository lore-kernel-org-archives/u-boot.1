Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661BAEC1118
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B86883E40;
	Mon, 23 Feb 2026 18:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V7n6QMj4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9418F83D17; Mon, 23 Feb 2026 18:51:39 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 832608063E
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 18:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-65c01595082so6703596a12.3
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 09:51:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869097; cv=none;
 d=google.com; s=arc-20240605;
 b=c05E4QR/iIRBSqp6lNaJSCchSUNW/l/MZDzkgh0a0Db+VCjRfEnh36acTtKGGrwAhI
 +PiRVZf1fpevwVrcYTfS8Kc0KAWXrHelBkHDOWn8GDGj426qkh2NWssW2zCyhf+VXxwM
 ZwYiB57V09CpJGLkt9XeH0w6RbyJ88/uBAAx0TS9RhIOC6rAGTRuDQUlWWSofnNxiuMA
 uUy86DAMI5vVRWT+Uhil9FDLoFHswX2hlP2Vy05yvwyqP8uZbiNl70G0+F2Rqlm3B6Lj
 mJyMiTdtu9NwY6CSbJwhHLdnGLUaI62Efrm1lzsGV5Ig4cFkwkuYbONnw9m2JE6WxJEH
 v7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fRbtnfOLfbpO+NuKNDE3+QJi2lQvxvZT3CvRZlRxszQ=;
 fh=pMrEB/ZmUHYmmbxrAJxE0ss2NhTWPk9aQ8HxcwOX1y4=;
 b=T0fC2t7EV41sTwvCa6gDm5z7C3swgDzkTRQ0aCl7QFApWePYeI+j8hcFpEv9y1Nmd1
 Tdx1g4GJslbn0dc+06EEzFYT1MB0LVk4OnVtrdHvVio21OWQPjkL6YgyZsJUh4cMiKwe
 zPMCSqWTL7jBbG9xbSGlNFgLmYn/hLCkEEeUKEgnoxPL48d0YjskMUOMnlSekZAnCbT0
 Pru+1ALBxLcl//n525yRnwzdleF1nj988luhpcN1trGMimG0H9wqQ8Bq6TuOa5OxUYId
 MnUOSfjrKA6a2mFwfyZHj+y5hdc/CQpS4WZ+uKY+wPV6vqhqjSNBWKBmUxjDSouFJenu
 iplw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771869097; x=1772473897; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRbtnfOLfbpO+NuKNDE3+QJi2lQvxvZT3CvRZlRxszQ=;
 b=V7n6QMj4sM7TxAzom/qPsAzDL36YVu4t8wBi+dqdkbgex1qWwsYT5J7pGE/I0GUhZq
 AGqoxfVkfk9m+iYLGmuBcvIrE8TViQVJ7zMR0uaPuLrezh9N2f11H4pw/gtovgMhMxNQ
 BGi76ZtrjUu/Kr0vV3qjvIASOmomxZtsYu/nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771869097; x=1772473897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fRbtnfOLfbpO+NuKNDE3+QJi2lQvxvZT3CvRZlRxszQ=;
 b=nffNcdOyfcJBwe+VBe7nIqx6G8PlklW3Zr873H5F8bAPdB4hhAqCEPmpT8efbuHIdA
 MmBk5+aEElNaVc1pn3X6Tm7Mdaz487od5TZmmx3r/0uZFLd2dOtc2841OLI4wIzh9Vu6
 DM/7XPNeZFGgKOf85zUVkPFTyouzRQQud3IHghXQ4WbSWhoUShUUtl/lHaUAabY2/hTE
 X3wOrs2L7/Iq/7X7qV+DlOD/xPfUom9EhTRec3j5t/zdQHQE82Q4oP3hxBDW8Rsg9smT
 S61n5OQMyqWHzU5rYp1dFdKKTAdZIcWosg8Wrrklt9o3wJYiVmxQgBlfdk5Q+V5Qu5Ig
 pMAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb0wWZLaqP+uthz6Z3J6A58Ok/TtOfipJZxkRd/XPh2cbsxZsRs6jISMCmKQYMnhx+WL3d15w=@lists.denx.de
X-Gm-Message-State: AOJu0YwQevSCIYWErTJTB3ASDblO4Bn/84tKHCUid4wCsyXGeA3WsdY5
 so1pNYVg+PdacyVEwxDsb6vMgjPB/ZH4cIZyJI+bGGIoxZklDuVZvqkIZjowxFEbdYv4d2aLWqE
 XrlRpzNfmNkk0xcWmBu+ef1JvfjYgqgiZ6sUGqfFb
X-Gm-Gg: ATEYQzwITKZjXxZ+hnvcnpLgqSBP6dCjFaT6fhSpzMT1dDFLEzVrjgXZR8pc+bLZHJS
 Xf/oX10s+kOpJivWaphcKEyI/MOR+ikszKjLxAr/q+EFs+FHFp9nnNBDxc5vKI+cKXuOLf15/z5
 sCvhlFAvTIvjFYo2GnCg5xocBk1T1Olmxyxhpxi0MZEFoQfE23/DbvSki7TU6q4lPcHc1i4aeYa
 vO0/K9ZpCsg5iUQIx4lObo7AniMRkaWBaGtY9cAGdSD88jfoUeQeghWyFwBGOq8JDTp0L28t3j7
 piFZfqEFGj4TdBLJ
X-Received: by 2002:a05:6402:27cd:b0:65c:149b:dfea with SMTP id
 4fb4d7f45d1cf-65ea4f19807mr5883726a12.15.1771869096916; Mon, 23 Feb 2026
 09:51:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <ab7837536e4567b90d7cb662984dd7e637ef4361.1771275704.git.daniel@makrotopia.org>
 <CAFLszTi3r_6VynzrZKkDNbcucntoEW=4nLCV_q8kv3+vQojLBg@mail.gmail.com>
 <aZc-tSa3jkduf9aJ@makrotopia.org>
In-Reply-To: <aZc-tSa3jkduf9aJ@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Feb 2026 10:51:07 -0700
X-Gm-Features: AaiRm53pcU8_w_7I6u1AqyOWSKzfUoK4htYLADU6-hq-sdjnpBFsbyyntd4empA
Message-ID: <CAFLszTi_2pnkayQyCTayOqfJCwMcvdxzY72JenWJij1ZksRGuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 09/20] boot: fit: support on-demand loading in
 fit_image_load()
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>, Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de, 
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Daniel,

On Thu, 19 Feb 2026 at 09:48, Daniel Golle <daniel@makrotopia.org> wrote:
>
> On Thu, Feb 19, 2026 at 06:09:26AM -0700, Simon Glass wrote:
> > Hi Daniel,
> >
> > On Mon, 16 Feb 2026 at 14:22, Daniel Golle <daniel@makrotopia.org> wrot=
e:
> > >
> > > Add an on-demand loading path to fit_image_load() for use when
> > > images->loader is set (storage-backed boot).
> > >
> > > For external-data FIT images, the new path avoids dereferencing
> > > fit + data_offset (which would point into unmapped memory) and
> > > instead:
> > >
> > > 1. Extracts the data offset and size from FDT properties
> > >    (data-position / data-offset + data-size) -- metadata only,
> > >    no payload access.
> > >
> > > 2. Returns early for IH_TYPE_FILESYSTEM sub-images, which stay on
> > >    storage and are never loaded into RAM (e.g. squashfs rootfs).
> > >
> > > 3. Determines the RAM destination:
> > >    - If the sub-image has a load address, loads directly there
> > >      via image_loader_map_to() (zero-copy).
> > >    - Otherwise, allocates scratch RAM via image_loader_map().
> > >
> > > 4. Verifies the hash/signature in-place using
> > >    fit_image_verify_with_data(), which is address-agnostic.
> > >
> > > 5. Jumps to the common tail, skipping the normal
> > >    fit_image_get_data() + memcpy() sequence since data is already
> > >    at its final location.
> > >
> > > The entire path is gated by 'if (images->loader && external)' and
> > > USE_HOSTCC, so the existing in-memory flow is completely unchanged
> > > when no loader is set or when building host tools.
> > >
> > > For inline-data FIT images (no data-position/data-offset), the FDT
> > > structure loaded during format detection already contains all sub-
> > > image data, so the existing path handles them correctly.
> > >
> > > Also adds a 'struct image_loader *loader' member to struct
> > > bootm_headers (initialised to NULL).
> > >
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > ---
> > >  boot/image-fit.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++=
++
> > >  include/image.h  |  4 ++
> > >  2 files changed, 100 insertions(+)
> > >
> > > diff --git a/boot/image-fit.c b/boot/image-fit.c
> > > index 3ed69b5f7bc..73d3bf7df08 100644
> > > --- a/boot/image-fit.c
> > > +++ b/boot/image-fit.c
> > > @@ -24,6 +24,7 @@ extern void *aligned_alloc(size_t alignment, size_t=
 size);
> > >  #include <linux/sizes.h>
> > >  #include <errno.h>
> > >  #include <log.h>
> > > +#include <image-loader.h>
> > >  #include <mapmem.h>
> > >  #include <asm/io.h>
> > >  #include <malloc.h>
> > > @@ -2166,6 +2167,100 @@ int fit_image_load(struct bootm_headers *imag=
es, ulong addr,
> > >
> > >         printf("   Trying '%s' %s subimage\n", fit_uname, prop_name);
> > >
> > > +#if !defined(USE_HOSTCC) && CONFIG_IS_ENABLED(IMAGE_LOADER)
> >
> > This function is far too long so this code should go in its own
> > function. Also use if() and tools_build()
>
> I have significantly changed this whole part and folded storage access
> into fit_image_get_data(). A pre-loading stage in fit_image_load(), much
> fewer lines than the current do-it-all storage path, currently still
> remains in fit_image_load(). I will present it soon in a (manually...)
> reworked RFCv2 once I looked into and adressed all the other comments
> received for the initial RFC.

OK

>
> >
> > > +       /*
> > > +        * Storage-backed path: when an image_loader is active and th=
e
> > > +        * sub-image uses external data, load the payload from storag=
e
> > > +        * instead of dereferencing fit + data_offset. The FDT struct=
ure
> > > +        * (containing all metadata, hashes, and signatures) is alrea=
dy
> > > +        * in RAM; only the payload is on storage.
> > > +        *
> > > +        * Sequence:
> > > +        *  1. Print image info (fit_image_select with verify=3D0)
> > > +        *  2. Extract data location from FDT properties (no data acc=
ess)
> > > +        *  3. Skip IH_TYPE_FILESYSTEM sub-images =E2=80=94 they stay=
 on storage
> > > +        *  4. Determine RAM destination (load address or scratch are=
a)
> > > +        *  5. Read payload via image_loader_map_to() / image_loader_=
map()
> > > +        *  6. Verify hash/signature in-place
> > > +        *  7. Jump to common tail (FDT validation, output params)
> > > +        */
> > > +       if (images && images->loader) {
> > > +               int data_off =3D 0, data_sz =3D 0;
> > > +               bool external =3D false;
> > > +               u8 img_type;
> > > +
> > > +               if (!fit_image_get_data_position(fit, noffset, &data_=
off)) {
> > > +                       external =3D true;
> > > +               } else if (!fit_image_get_data_offset(fit, noffset, &=
data_off)) {
> > > +                       external =3D true;
> > > +                       data_off +=3D ALIGN(fdt_totalsize(fit), 4);
> > > +               }
> > > +
> > > +               if (external && !fit_image_get_data_size(fit, noffset=
, &data_sz)) {
> > > +                       /* Print image info without verifying data */
> > > +                       ret =3D fit_image_select(fit, noffset, 0);
> > > +                       if (ret) {
> > > +                               bootstage_error(bootstage_id + BOOTST=
AGE_SUB_HASH);
> > > +                               return ret;
> > > +                       }
> > > +
> > > +                       /* Skip filesystem images =E2=80=94 they stay=
 on storage */
> > > +                       if (!fit_image_get_type(fit, noffset, &img_ty=
pe) &&
> > > +                           img_type =3D=3D IH_TYPE_FILESYSTEM) {
> > > +                               *datap =3D 0;
> > > +                               *lenp =3D 0;
> > > +                               return noffset;
> >
> > Should add a comment here about why you are not doing verification. I
> > assume the FS is protected with dm-verify, iwc should the root hash be
> > stored in the FIT?
>
> Yes, I agree with that. A single property won't be enough, so what I
> came up with and currently test is a node under the image, ie.
>
> dm-verity {
>         block-size =3D <0x1000>;
>         data-blocks =3D <0xdead>;
>         algo =3D "sha256";
>         root-hash =3D "averylonghashasstring";
>         salt =3D "anotherverylonghashasstring";
> };
>
> This is sufficient to then let U-Boot generate the dm-mod.create=3D"..."
> parameter handed over to the kernel.
>
> Currently I'm just putting this in the its source file, but of course we
> could also extend 'mkimage' to call 'veritysetup format ...' and
> populate such section like it is done for the hashes.
>

Yes this looks very nice to me. Don't forget a PR for the FIT spec too.

Regards,
SImon
