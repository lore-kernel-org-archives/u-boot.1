Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABF7C2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 09:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFAA58801A;
	Fri, 21 Jun 2024 11:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DB6087DEB; Fri, 21 Jun 2024 11:12:40 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 427078801A
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 11:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32C74DA7;
 Fri, 21 Jun 2024 02:13:02 -0700 (PDT)
Received: from debian (unknown [10.57.8.27])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFAA13F73B;
 Fri, 21 Jun 2024 02:12:35 -0700 (PDT)
Date: Fri, 21 Jun 2024 11:12:32 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/7] efi: CapsuleUpdate: support for dynamic UUIDs
Message-ID: <ZnVEALsxt2b9s-cI@debian>
Mail-Followup-To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <ZnLk_pXstP2dlRGo@debian>
 <CAC_iWjL_rytosTAcsW2-3fmwVhjTgkMRAB0LwPuNpq73K=YmcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_iWjL_rytosTAcsW2-3fmwVhjTgkMRAB0LwPuNpq73K=YmcQ@mail.gmail.com>
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

On Wed, Jun 19, 2024 at 10:15:32PM +0300, Ilias Apalodimas wrote:
> Allô Vincent,

Hi Ilias :)

> 
> Thanks for testing!
> 
> On Wed, 19 Jun 2024 at 17:02, Vincent Stehlé <vincent.stehle@arm.com> wrote:
> >
> > On Fri, May 31, 2024 at 03:50:34PM +0200, Caleb Connolly wrote:
> > > As more boards adopt support for the EFI CapsuleUpdate mechanism, there
> > > is a growing issue of being able to target updates to them properly. The
> > > current mechanism of hardcoding UUIDs for each board at compile time is
> > > unsustainable, and maintaining lists of GUIDs is similarly cumbersome.
> > >
> > > In this series, I propose that we adopt v5 GUIDs, these are generated
> > > by using a well-known salt GUID as well as board specific information
> > > (like the model/revision), these are hashed together and the result is
> > > truncated to form a new UUID.
> >
> > Dear Caleb,
> >
> > Thank you for working on this proposal, this looks very useful.
> > Indeed, we found out during SystemReady certifications that it is easy for
> > unique ids to be inadvertently re-used, making them thus non-unique.
> >
> > I have a doubt regarding the format of the generated UUIDs, which end up in the
> > ESRT, though.
> >
> > Here is a quick experiment on the sandbox booting with a DTB using the efidebug
> > command.
> >
> > With the patch series, rebased on the master branch:
> >
> >   $ make sandbox_defconfig
> >   $ make
> >   $ ./u-boot --default_fdt
> >   ...
> >   U-Boot 2024.07-rc4-00028-g1c96225b0b3 (Jun 19 2024 - 15:29:04 +0200)
> >   ...
> >   Model: sandbox
> >   ...
> >   Hit any key to stop autoboot:  0
> >   => efidebug capsule esrt
> >   ...
> >   ========================================
> >   ESRT: fw_resource_count=2
> >   ESRT: fw_resource_count_max=2
> >   ESRT: fw_resource_version=1
> >   [entry 0]==============================
> >   ESRT: fw_class=FD5DB83C-12F3-A46B-80A9-E3007C7FF56E
> >   ...
> >   [entry 1]==============================
> >   ESRT: fw_class=935FE837-FAC8-4394-C008-737D8852C60D
> >   ...
> >   ========================================
> >
> >   $ uuid -d FD5DB83C-12F3-A46B-80A9-E3007C7FF56E
> >   encode: STR:     fd5db83c-12f3-a46b-80a9-e3007c7ff56e
> >           SIV:     336781303264349553179461347850802165102
> >   decode: variant: DCE 1.1, ISO/IEC 11578:1996
> >           version: 10 (unknown)
> >           content: FD:5D:B8:3C:12:F3:04:6B:00:A9:E3:00:7C:7F:F5:6E
> >                    (not decipherable: unknown UUID version)
> >
> > Version 10 does not look right.
> 
> So, this seems to be an endianess problem.
> Looking at RFC4122 only the space ID needs to be in BE.
> 
> >
> >   $ uuid -d 935FE837-FAC8-4394-C008-737D8852C60D
> >   encode: STR:     935fe837-fac8-4394-c008-737d8852c60d
> >           SIV:     195894493536133784175416063449172723213
> >   decode: variant: reserved (Microsoft GUID)
> >           version: 4 (random data based)
> >           content: 93:5F:E8:37:FA:C8:03:94:00:08:73:7D:88:52:C6:0D
> >                    (no semantics: random data only)
> >
> > A reserved Microsoft GUID variant does not look right.
> 
> This seems like an existing bug. RFC4122 defines the MS reserved GUIDs
> in the variant as
> 1     1     0    Reserved, Microsoft Corporation backward
> compatibility and the existing UUID_VARIANT_MASK is defined as 0xc0...

I think the variant mask 0xc0 is correct:

- The variant field is in the top three bits of the "clock seq high and
  reserved" byte, but...
- The variant we want is 1 0 x (do not care for bit 5, a.k.a. "Msb2").

With the mask 0xc0 we can clear the top two bits as we set the top most bit just
after anyway.

...the mask needs to be used correctly, though; see below.

> 
> The patch below should work for you (on top of Calebs')
> 
> diff --git a/include/uuid.h b/include/uuid.h
> index b38b20d957ef..78ed5839d2d6 100644
> --- a/include/uuid.h
> +++ b/include/uuid.h
> @@ -81,7 +81,7 @@ struct uuid {
>  #define UUID_VERSION_SHIFT     12
>  #define UUID_VERSION           0x4
> 
> -#define UUID_VARIANT_MASK      0xc0
> +#define UUID_VARIANT_MASK      0xb0
>  #define UUID_VARIANT_SHIFT     7
>  #define UUID_VARIANT           0x1
> 
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 89911b06ccc0..73251eaa397e 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -411,9 +411,9 @@ void gen_uuid_v5(const struct uuid *namespace,
> struct uuid *uuid, ...)
>         memcpy(uuid, hash, sizeof(*uuid));
> 
>         /* Configure variant/version bits */
> -       tmp = be32_to_cpu(uuid->time_hi_and_version);
> +       tmp = uuid->time_hi_and_version;

Not caring for the endianness at all does not look right.
Indeed, while this does work on my side in little-endian, this does not work on
on big-endian simulators.
Also, this is a 16b quantity, not 32b; we need to redefine tmp to uint16_t and
use the be16 functions.

>         tmp = (tmp & ~UUID_VERSION_MASK) | (5 << UUID_VERSION_SHIFT);
> -       uuid->time_hi_and_version = cpu_to_be32(tmp);
> +       uuid->time_hi_and_version = tmp;
> 
>         uuid->clock_seq_hi_and_reserved &= UUID_VARIANT_MASK;

We need to mask with ~UUID_VARIANT_MASK, I think.

>         uuid->clock_seq_hi_and_reserved |= UUID_VARIANT << UUID_VARIANT_SHIFT;
> 
> Can you give it a shot?

This does indeed work on my little-endian machines, but not on big-endian
simulators.
For testing on big-endian, I suggest using only genguid as the sandbox will not
help there:

  $ make sandbox_defconfig
  $ make tools-only
  $ ./tools/genguid 2a5aa852-b856-4d97-baa9-5c5f4421551f \
        -c "qcom,qrb4210-rb2" \
        QUALCOMM-UBOOT

...and feed the resulting UUID to `uuid -d'.
(The genguid command is the online help example.)

> What I am afraid of is breaking existing use cases using a different
> variant mask....
> If that's the case we might need to keep the buggy existing
> UUID_VARIANT_MASK and use the new one only on v5 and newer code

I tried to debug further and I suspect that:

- Operations on 8b clock_seq_hi_and_reserved might need further casts.

- My understanding is that we are generating the v5 UUID as big-endian in
  memory; if this is indeed the case, genguid should not print it with the GUID
  byte order.

For the moment I am unable to make the code work in all the following cases:

- genguid on little-endian
- genguid on big-endian
- sandbox ESRT on little-endian

I will let you and Caleb know if I make any progress.

Best regards,
Vincent.

> 
> Thanks
> /Ilias
