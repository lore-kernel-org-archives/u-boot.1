Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ECFCDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 15:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE6198494B;
	Thu, 25 Jun 2026 17:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kLxDQ9EA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 885D68495B; Thu, 25 Jun 2026 17:36:13 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20F8B84894
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c858961a8efso939442a12.2
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 08:36:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782401769; cv=none;
 d=google.com; s=arc-20260327;
 b=MCK1CRfd+ntW5Srbb9IORD1KAobRLAj55dp3Z1LTB0ElmJwoplRYIdlrt3fMLTWuSD
 rhYBpp6XE1wKhBnmznSJSRsvQb/jOZrXdoOH7oiSPg23qb7SI0vQErhAvMEEDV6I977K
 A3f4Tbqg2g7aclx4bDgepFqT27nZTVKWO3IUM+6O0yt6LRt4UM96ggBEjArf8s5yAvXX
 FHa91dXeMi1W+coZ77fS+VohYIiBS7jH4B4eHpDjmkswjp6VDHMneOTPpFcC6X7sEHUC
 lYT8nmgo/hyOZ3dCWQNPNsoCedN/DXBjZ0CLHvuTwZBI3HLKZi1OBtE4esurtumXRgA4
 4jrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NrEY6p22wxWmbAzkF5UBNpGeFHqnfo2e74pbuyrteRo=;
 fh=OaOIJxNuzpS1jjpTnPygbJf0gYDy1uz8TatCAc5/vg8=;
 b=TBslzZdnQmAUT+DNNKCECIfyrSLUNmMFDZ+uYNftNbN5dILFJJi/VBIAXhOzVmlcMr
 pxKuNWKXMQYJHwOUTB5pUZuhoRY/xcQEt6TPNjSYjF1be9ze36CSYuENAHPpLExMLMXW
 4pYh2Mtn330YkAV5+OLW1FdWT86Pdq9tPFPFVg+YEk91HL9mvSrQb7jHm+yY8E4zL1Az
 xaQJk502KbBDjxgFi8/dBt8t4Dgy/7yYefS4+FIYMXV9ieWHbsgk1bFkXaqP8Cro2yZ9
 XP9r5ivCDfk7mCYnnYp3Pod/as0KPckfhSB5hY4n12uC5u87Jdwr8yD5Qq7QoUTee2Iq
 CV0g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782401769; x=1783006569; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NrEY6p22wxWmbAzkF5UBNpGeFHqnfo2e74pbuyrteRo=;
 b=kLxDQ9EAEh+ktykOQdrHdu1+wu76r5y/AVzw4tmJrnWdWXpNSl09pac8LvfF2r4qXD
 J/YvzE1XF6xfd2kyGdz1525EIniCG78r8lp4jJN0TeAqMpGlwHMLiHF+VZpXMrzmOco7
 QLog+1LvbN4VWCA3FcKl5VjDPnID8pRB9hNH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782401769; x=1783006569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NrEY6p22wxWmbAzkF5UBNpGeFHqnfo2e74pbuyrteRo=;
 b=F9/tXEMLhMSth4CtDLAhzbW2RfHXc8jGzoWHP7dqPmZRD/OMve3FESGvl4X2nyIodo
 p3qUCC3VQRO6hePqQcOGnFF1EPvAxVAH2QsCt4PUS30oZs7B7yxDFDndzhqso4e6Wqr9
 Ohhher1d4qYnue16DIs2Cry8Lv7XP7Nists3epHv/k14Q6buIYxvPmVzV42bazt9HLB6
 M7t0E1aGbNUFEwKgpb2kSqX0Fvb3SwGCazfWRSNa/JhHYjwkXbi2jbHbZkVNPgg4lBa3
 4H6SnaR+ufUstZykkpA+Teytjows4ZTS6e9FVp5FBL/+/BN8fh59EpladSETIKctEoQ9
 fiSw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoET67lCQUS1A9QCWPgvaFsVyWaZIq9U1vR9UOTpsNUQbcsmf9G1q+lbXGMLKNt2kSP/4Kj5/8=@lists.denx.de
X-Gm-Message-State: AOJu0YzWuodiit1uINr0F8GResa1dc2FTaqOsApaeG8zrCbtyoV1maJY
 SumElZ888N1lRwQt/uGTe3ExDpCqUtb8qlh2IR8naGJJ0QlHXI+jfu6QbIdZlJQvIBydhh9br6H
 Ag/QqskEpQy7N7zkBFPpGWtwsj/5To7Ix9fLvRx59
X-Gm-Gg: AfdE7ckMq3ENVtyEj0YjnzTOp5RslqYZOnt1koiRh6j2pBT9cMcA+J4JMgKI19xpihe
 IOVezbDk4Q8ZFY1uofEWO/WFsM6oGexizE8vEQ1Wg3XH7YXpRWn6LOYxhPbxliMFrTNkiRh+vyy
 KNwSE/mkVx7AftpWqGGEO4GngGzUpcvl2QWZExFk+FRlHnhGDOSgfqicSZ/6NeJY1wXo5asP9GL
 Q3yiqWPm2V1gerPN0xJRIKEMnAxqr5E5jDJLG5/+6fmQzzMn7CcGjDBiFVWlC1qbE5LCYJXAQ==
X-Received: by 2002:a17:902:ce06:b0:2bd:606d:b339 with SMTP id
 d9443c01a7336-2c7fc9c08ebmr37168645ad.21.1782401769453; Thu, 25 Jun 2026
 08:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-3-heinrich.schuchardt@canonical.com>
 <CAFLszTiu0HSZ4JJ7ggMMAk4oe0-h=Xq-Wnw=hqwGr80wBdrGXQ@mail.gmail.com>
 <e262d779-4854-4360-8d9a-a91ff76b5347@canonical.com>
 <CAFLszTj7D-q5QtKTDX07t529wS+hfUUjEq2vK+6rJF9psC8KGw@mail.gmail.com>
 <fa63ad61-57e8-4302-a3f9-a3dd86d07db3@canonical.com>
In-Reply-To: <fa63ad61-57e8-4302-a3f9-a3dd86d07db3@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 16:35:32 +0100
X-Gm-Features: AVVi8CeYRot2H-B-t27nRpPI3n9l4kQDtf0nG4zWOufAJC2x1xXa9vdeMB7TH2o
Message-ID: <CAFLszTgZsQd99eVRn4Qp+MHOxqG0q47it+mo_=91sBrjN1xkqw@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] efi_selftest: add ACPI configuration table test
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.denx.de
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

Hi Heinrich,

On Thu, 25 Jun 2026 at 16:23, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 6/25/26 16:55, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Thu, 25 Jun 2026 at 12:26, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 6/25/26 10:52, Simon Glass wrote:
> >>> Hi Heinrich,
> >>>
> >>> On 2026-06-21T08:19:04, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>> efi_selftest: add ACPI configuration table test
> >>>>
> >>>> The new unit test checks if ACPI tables are available.
> >>>>
> >>>> If yes, it checks if the RSDP correctly points to the RSDT or XSDT.
> >>>>
> >>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>>>
> >>>> lib/efi_selftest/Makefile            |   1 +
> >>>>    lib/efi_selftest/efi_selftest_acpi.c | 138 +++++++++++++++++++++++++++++++++++
> >>>>    2 files changed, 139 insertions(+)
> >>>
> >>> Reviewed-by: Simon Glass <sjg@chromium.org>
> >>>
> >>>> diff --git a/lib/efi_selftest/efi_selftest_acpi.c b/lib/efi_selftest/efi_selftest_acpi.c
> >>>> @@ -0,0 +1,138 @@
> >>>> +     if (!checksum_ok(rsdp, 20)) {
> >>>> +             efi_st_error("Invalid RSDP checksum\n");
> >>>> +             return EFI_ST_FAILURE;
> >>>> +     }
> >>>
> >>> Please avoid the magic 20 - how about offsetof(struct acpi_rsdp,
> >>> length) or a named constant?
> >>>
> >>> Regards,
> >>> Simon
> >>
> >> Thank you for reviewing.
> >>
> >> 20 is not an offset. It is the length of the ACPI 1.0 RSDP header.
> >
> > ...which is the offset of the length field. See the struct:
> >
> > struct __packed acpi_rsdp {
> >     char signature[8];   /* RSDP signature */
> >     u8 checksum;      /* Checksum of the first 20 bytes */
> >     char oem_id[6];      /* OEM ID */
> >     u8 revision;      /* 0 for ACPI 1.0, others 2 */
> >     u32 rsdt_address;   /* Physical address of RSDT (32 bits) */
> >     u32 length;      /* Total RSDP length (incl. extended part) */
> >     u64 xsdt_address;   /* Physical address of XSDT (64 bits) */
> >     u8 ext_checksum;   /* Checksum of the whole table */
> >     u8 reserved[3];
> > };
> >
> > The original struct ended with rsdt_address as the final field. Then
> > they added a length and some more information. So the offset of
> > 'length' is actually what you want.
> >
> > My failure to use offsetof() was probably just that I didn't know it
> > existed, or perhaps because some of the code came from coreboot.
>
> The field length does not exist in ACPI 1.0. So it does not make any
> sense to relate to it for calculating the checksum field.

Well in v1.0 we would just have used sizeof() of the whole struct.
Creating v2 created the length field.

>
> >
> >>
> >> Below is the precedent that Bin and you have been setting:
> >>
> >> arch/x86/lib/acpi.c:18: if (table_compute_checksum((void *)rsdp, 20) != 0)
> >> drivers/misc/qfw_acpi.c:310:    rsdp->checksum =
> >> table_compute_checksum(rsdp, 20);
> >> lib/acpi/base.c:36:     rsdp->checksum = table_compute_checksum(rsdp, 20);
> >> test/dm/acpi.c:371:     ut_assertok(table_compute_checksum(rsdp, 20));
> >
> > Yes, this is quite common. How about declaring a constant for it?
>
> That is beyond the scope of this series. It has enough patches.
>
> Let's do it separately.

Yes, sounds good. Either offsetof() or 20 is fine by me.

Regards,
Simon
