Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233EEC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 14:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84E818803A;
	Tue, 21 May 2024 16:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I6icSvKR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 688C4886A6; Tue, 21 May 2024 16:11:30 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A775388013
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 16:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2e538a264f7so52375571fa.0
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 07:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716300687; x=1716905487; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zynRDNBfdzvrIlu87109lC6C8DHRXcRnBe4tNhdwKbQ=;
 b=I6icSvKRnDmj+jNXnkOO2TryolbUv/OqKV4GPV89PTtvKJLLQbjwpbVBOwn7iP7vMD
 71R9Kx2J0zgiejPCbmx0U09YMeyh/SHUU8RUSHc6ohHqdjVZxk5obGKRsQ1HBvD1cVm3
 SpuNZWkfc/pWDiNpR7yo2l64lnCHlSYSyfwcNkY1zY0a/pnNU9b+34NJib0N6CG1gUqn
 MbGGzPO15/f5kwVv8WP6g0+MGxbidM/+P/sZO00y/PHAid/OHYgIntY9uIwr7P+sbAcX
 BqrWocHBLA6O2gHSsvbQbKOTUGtWlpJA+5uBeEFaB2G5r1a0Ue34qE9158F0MJhWW87q
 wung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716300687; x=1716905487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zynRDNBfdzvrIlu87109lC6C8DHRXcRnBe4tNhdwKbQ=;
 b=fKWyWqQ57zC4k8gBZQ/zWU6J9mdd7EXuBE5hgQ5YVn/WY6zSgTGy3UcaIzA+ovBtz0
 gSXoR20eaKaYqbIi/hjNrBJ40+ybLOOeo2euMqmlDH+G7rnE2bFpoeO01OCfbIV/lDMq
 cKXS+ZHypJDo5MZxMZ+mMqlzJjwY3L7Nuavvuj5vnOuUqVa/hHO40M+aBJYwS3C2AwzE
 Jy36sE6PtLldRhBqkvJo05hQRNI5u2WeUtwat9Zru3SHJnuu8j+bp+83Sv8F5fr+qHtY
 fKYn9GNROkYAUyKEV9DrE4KA+l0skkzTdy08afIAZPFt/wI7R+5U6XR6Ytf+74yPCAau
 VD3g==
X-Gm-Message-State: AOJu0YwxpkzHsPvgWm8fIQ3Lykgw7Hte/Ch8LYd+T6f50Sl1F2OJCEFw
 KQlKUbgPzT0eQjJPsm3rguO/909Cb8nj8fDJNv6F8gpczXqjSb7xDEBkBLV2A0Dk320V9V6oiR4
 HO1by1jdP1yaTIpS7pug+j55U/DFa9NqbYh1DFg==
X-Google-Smtp-Source: AGHT+IFiX9PX2E1tNAalJjGuZssoU5jpISmCuLnnh7rrJ4vnx17vz1OHmSdPduhEN5a764MlHb1IyFtWv7pSm/TsRzk=
X-Received: by 2002:a05:651c:510:b0:2e2:115b:effd with SMTP id
 38308e7fff4ca-2e5203a47aamr244416031fa.47.1716300686656; Tue, 21 May 2024
 07:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240405001722.2876240-1-tharvey@gateworks.com>
 <CAC_iWjL7nHxq7Yio6XqenxrMwfVBC-VK3UCDLX=4oNQWvcfTBQ@mail.gmail.com>
 <CAJ+vNU1H4GZ7Nq1MEcqWgSkZjPo9u-TDRVapLnn5Kq+3TyD-bA@mail.gmail.com>
 <CAC_iWjKA-bA=i6bzsnAvwn+JqtywbD8xWsQtECRjeswHBtT3fw@mail.gmail.com>
 <CAC_iWjJS+JhdDH8xPApna9ho8f4XxmTUGRZGZUEgt62xBcLRVQ@mail.gmail.com>
 <CAJ+vNU0ncveyq8M7PfQQrMEUr0z-qE5G6CDki9ms_4Ves=8G9g@mail.gmail.com>
 <CAC_iWj+Mm9is765HanRaMSc7Bntx9NrXu6uM2BdNT6PJcrdR5A@mail.gmail.com>
 <CAJ+vNU04G1y68ZCaS7+SEAWqCx+WPL99HQu8FmyGYduMS1PZRw@mail.gmail.com>
 <CAC_iWjJXsJFGQmzCqsArM50wvkDBR0HsCdMcYHW-ZjenhkWjCA@mail.gmail.com>
 <CAC_iWjJeP9gP_xyRULGsvvXtq=Po8kLiSUspGKYZaNrVy506oA@mail.gmail.com>
 <CAC_iWjJjprcdP++R2jJNakDhcjAQjoD=rJE0ODjUhEKzt-VrBw@mail.gmail.com>
In-Reply-To: <CAC_iWjJjprcdP++R2jJNakDhcjAQjoD=rJE0ODjUhEKzt-VrBw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 May 2024 17:10:49 +0300
Message-ID: <CAC_iWjLFQO3bRD8Q0oEzVzo-0U_gKXbBhwetonGBoA4CLxer1g@mail.gmail.com>
Subject: Re: [PATCH v3] tpm-v2: allow algoirthm name to be configured for
 pcr_read and pcr_extend
To: Tim Harvey <tharvey@gateworks.com>, Eddie James <eajames@linux.ibm.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

top posting but if it makes your life easier this would probably work
on top of your patch (compile tested only).
We ofc need to make proper patches and merge this first, but it will
probably help you understand what's wrong with the current code

diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index 263f9529e55d..a1f8303523b9 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -434,6 +434,9 @@ static const struct digest_info hash_algo_list[] = {
                TPM2_SHA512_DIGEST_SIZE,
        },
 };
+#define MAX_HASH_COUNT ARRAY_SIZE(hash_algo_list)
+
+u32 tpm2_algorithm_to_mask(u16 hash_alg);

 static inline u16 tpm2_algorithm_to_len(enum tpm2_algorithms a)
 {
@@ -451,8 +454,6 @@ static inline u16 tpm2_algorithm_to_len(enum
tpm2_algorithms a)
        }
 }

-#define tpm2_algorithm_to_mask(a)      (1 << (a))
-
 /* NV index attributes */
 enum tpm_index_attrs {
        TPMA_NV_PPWRITE         = 1UL << 0,
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 83f490c82541..0b27d70a4144 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -22,6 +22,26 @@

 #include "tpm-utils.h"

+
+/**
+ * tpm2_algorithm_to_mask - Get a TCG hash mask for algorithms
+ *
+ * @hash_alg: TCG defined algorithm
+ *
+ * @Return: TCG hashing algorithm bitmaps, 0 if the algorithm is not supported
+ */
+u32 tpm2_algorithm_to_mask(u16 hash_alg)
+{
+       size_t i;
+
+       for (i = 0; i < MAX_HASH_COUNT; i++) {
+               if (hash_algo_list[i].hash_alg == hash_alg)
+                       return hash_algo_list[i].hash_mask;
+       }
+
+       return 0;
+}
+
 int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *active_pcr_banks)
 {
        u32 supported = 0;


On Tue, 21 May 2024 at 15:31, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Tim,
>
> > > > > > > > > > >
> > > > > > > > > > > -const enum tpm2_algorithms tpm2_supported_algorithms[4] = {
> > > > > > > > > > > -       TPM2_ALG_SHA1,
> > > > > > > > > > > -       ,
> > > > > > > > > > > -       TPM2_ALG_SHA384,
> > > > > > > > > > > -       TPM2_ALG_SHA512,
> > > > > > > > > > > -};
> > > > > > >
> > > > > > > The current tpm2_algorithm_to_mask() operates on those values and bits
> > > > > > > shifts based on the enum. Since you remove the enum above, you must
> > > > > > > also change the function implementation and return
> > > > > > > hash_algo_list.hash_mask
> > > > > > >
> > > > > >
> > > > > > That's already taken care of as the calls to tpm2_algorithm_to_mask()
> > > > > > in my patch were adjusted from:
> > > > > > tpm2_algorithm_to_mask(tpm2_supported_algorithms[i])
> > > > > > to
> > > > > > tpm2_algorithm_to_mask(hash_algo_list[i].hash_alg)
> > > > > >
> > > > > > The hash_alg is the value from the previous enum.
> > > > >
> > > > > The previous enums were defining TPM2_ALG_SHA1=1, TPM2_ALG_SHA256=2 etc
> > > > > The current values are different. On top of that the .hash_mask  entry
> > > > > of digest_info is never used. So you need to change
> > > > > tpm2_algorithm_to_mask() and directly return the hash_mask
> > > > >
> > > >
> > > > Hi Ilias,
> > > >
> > > > Just getting back to this. I don't agree with your assessment.
> > > >
> > > > The previous enum:
> > > > -const enum tpm2_algorithms tpm2_supported_algorithms[4] = {
> > > > -       TPM2_ALG_SHA1,
> > > > -       TPM2_ALG_SHA256,
> > > > -       TPM2_ALG_SHA384,
> > > > -       TPM2_ALG_SHA512,
> > > > -};
> > > >
> > > > is defining 4 values which equate to 0x04, 0x0B, 0x0C, 0x0D (not 1, 2,
> > > > 3, 4 as you say) which is what I'm putting in the hash_alg field. The
> > > > tpm2_algorithm_to_mask macro shifts those values (not the index into
> > > > the enum).
> > > >
> > > > So with the current code:
> > > > for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); i++) {
> > > >         int alg = tpm2_supported_algorithms[i];
> > > >         printf("alg:0x%02x mask=0x%02x\n", alg, tpm2_algorithm_to_mask(alg));
> > > > }
> > > > alg:0x04 mask=0x10
> > > > alg:0x0b mask=0x800
> > > > alg:0x0c mask=0x1000
> > > > alg:0x0d mask=0x2000
> > > >
> > > > With this proposed patch:
> > > > for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
> > > >         int alg = hash_algo_list[i].hash_alg;
> > > >         printf("alg:0x%02x mask=0x%02x %s\n", alg,
> > > > tpm2_algorithm_to_mask(alg), tpm2_algorithm_name(alg));
> > > > }
> > > > alg:0x04 mask=0x10 sha1
> > > > alg:0x0b mask=0x800 sha256
> > > > alg:0x0c mask=0x1000 sha384
> > > > alg:0x0d mask=0x2000 sha512
> > > >
> > > > Am I misunderstanding something else you are pointing out?
> > > >
> > > > Maybe it would be easier to compare if I named the new struct
> > > > tpm2_supported_algorithms?
> > >
> > > Ok, I think we are looking at a preexisting bug, because the prints
> > > above make no sense to me.
> > >
> > > There was an enum in the current code
> > > const enum tpm2_algorithms tpm2_supported_algorithms[4] = {
> > >        TPM2_ALG_SHA1,
> > >        TPM2_ALG_SHA256,
> > >        TPM2_ALG_SHA384,
> > >        TPM2_ALG_SHA512,
> > > }
> > > But those values are defined in include/tpm-v2.h hence the enum values
> > > were not starting from 0...
> > >
> > > Reading at the TCG spec [0] we should be adding any of the values
> > > defined below to HashAlgorithmBitMap.
> > > #define EFI_TCG2_BOOT_HASH_ALG_SHA1 0x00000001
> > > #define EFI_TCG2_BOOT_HASH_ALG_SHA256 0x00000002
> > > #define EFI_TCG2_BOOT_HASH_ALG_SHA384 0x00000004
> > > #define EFI_TCG2_BOOT_HASH_ALG_SHA512 0x00000008
> > > #define EFI_TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
> > >
> > > We used to do that in v2023.01. The patch below is on top of 2023.01
> > >
> > > diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> > > index a525ebf75b58..7371c9e94b5c 100644
> > > --- a/lib/efi_loader/efi_tcg2.c
> > > +++ b/lib/efi_loader/efi_tcg2.c
> > > @@ -1628,6 +1628,7 @@ static efi_status_t create_specid_event(struct
> > > udevice *dev, void *buffer,
> > >                 u16 hash_alg = hash_algo_list[i].hash_alg;
> > >                 u16 hash_len = hash_algo_list[i].hash_len;
> > >
> > > +               printf("Trying to add %08x and %08x\n", hash_alg,
> > > alg_to_mask(hash_alg));
> > >                 if (active & alg_to_mask(hash_alg)) {
> > >                         put_unaligned_le16(hash_alg,
> > >
> > > &spec_event->digest_sizes[alg_count].algorithm_id);
> > >
> > > prints
> > >
> > > Trying to add 00000004 and 00000001
> > > Trying to add 0000000b and 00000002
> > > Trying to add 0000000c and 00000004
> > > Trying to add 0000000d and 00000008
> > >
> > > The values of 0x00000001, 0x00000002 etc are what's added to the eventlog
> > >
> > > But since 97707f12fdabf we are putting different values (which I think
> > > is wrong and not what the spec expects....)
> > > I also think Eddie intended to make tpm2_supported_algorithms an enum
> > > that starts from 0, but the values he used were already defined and
> > > that's how we missed it ...
> > >
> > > Eddie any idea if that's what happened?
> > >
> > > Tim, we will need to fix all this regardless.  The fix should be
> > > relatively simple, just return the newly added values instead of the
> > > algorithm_to_mask value, when adding it on the eventlog.
> > > Can you take a look at the spec and verify what I am seeing? At some
> > > point, we also need to add the value checking in self-tests, rather
> > > than only looking at the EFI return code.
> >
> > Apologies for the noise, I wasn't remembering the spec properly.
> > The hash values are only supposed to be used on getting the capability
> > and active PCR banks.
> >
> > Let me read this patch again
>
> Ok, I figured it out. The bug is indeed there, but it's while reading
> and interpreting the TPM capabilities, instead of writing those.
> What I wrote above is still relevant and I still think Eddie wanted to
> define the enum as 0,1,2, etc instead of the values that are there.
>
> A simple way to reproduce the bug is checkout v2023.01 and add this patch:
>
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index a525ebf75b58..b06dd47575d3 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -617,6 +617,7 @@ static int tpm2_get_pcr_info(struct udevice *dev,
> u32 *supported_pcr,
>         }
>
>         *pcr_banks = pcrs.count;
> +       printf("ACTIVE BANKS 0x%08x\n", *active_pcr);
>
>         return 0;
>  out:
>
> If you load u-boot and initialize the TPM (e.g do a printenv -e),
> you'll get prints looking like this:
> ACTIVE BANKS 0x00000003
> when sha1 and sha256 banks are enabled
>
> If you apply a similar patch to -master the print looks like this
> (which doesn't match the TCG spec)
> ACTIVE BANKS 0x00000810
>
> Now I understand the bug is completely irrelevant to your patches, but
> I can't pick it up before we fix it properly.
> I can either send a fix here, but it will take me some time to find
> free cycles, or you can send it as a prerequisite for your patches.
> That new patch will use the new TCG2_BOOT_HASH_ALG_SHA1/XXX you added
> and fix the algorithm checking before adding any capabilites on the
> cmd line.
>
> Let me know what you prefer
>
> Thanks
> /Ilias
>
> >
> > Thanks
> > /Ilias
> > >
> > >
> > > [0] 6.4.3 Related Definitions
> > > https://trustedcomputinggroup.org/wp-content/uploads/EFI-Protocol-Specification-rev13-160330final.pdf
> > >
> > > Thanks
> > > /Ilias
> > >
> > >
> > >
> > > >
> > > > Best Regards,
> > > >
> > > > Tim
> > > >
> > > > > Cheers
> > > > > /Ilias
> > > > > >
> > > > > > Best Regards,
> > > > > >
> > > > > > Tim
> > > > > >
> > > > > > > Cheers
> > > > > > > /Ilias
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > > > > -
> > > > > > > > > > >  int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *active_pcr_banks)
> > > > > > > > > > >  {
> > > > > > > > > > >         u32 supported = 0;
> > > > > > > > > > > @@ -82,14 +75,14 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
> > > > > > > > > > >                 return rc;
> > > > > > > > > > >
> > > > > > > > > > >         digest_list->count = 0;
> > > > > > > > > > > -       for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
> > > > > > > > > > > +       for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> > > > > > > > > > >                 u32 mask =
> > > > > > > > > > > -                       tpm2_algorithm_to_mask(tpm2_supported_algorithms[i]);
> > > > > > > > > > > +                       tpm2_algorithm_to_mask(hash_algo_list[i].hash_alg);
> > > > > > > > > > >
> > > > > > > > > > >                 if (!(active & mask))
