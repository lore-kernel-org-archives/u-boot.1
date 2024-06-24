Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F76CC2BD05
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 09:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0F5687E30;
	Mon, 24 Jun 2024 11:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86F0F88352; Mon, 24 Jun 2024 11:14:43 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CF4A1801BA
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 11:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B83B4DA7;
 Mon, 24 Jun 2024 02:15:04 -0700 (PDT)
Received: from debian (X72Y076X74.nice.arm.com [10.34.129.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F8403F6A8;
 Mon, 24 Jun 2024 02:14:38 -0700 (PDT)
Date: Mon, 24 Jun 2024 11:14:35 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 0/7] efi: CapsuleUpdate: support for dynamic UUIDs
Message-ID: <Znk4-5xH7wtBPSSu@debian>
Mail-Followup-To: Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <ZnLk_pXstP2dlRGo@debian>
 <CAC_iWjL_rytosTAcsW2-3fmwVhjTgkMRAB0LwPuNpq73K=YmcQ@mail.gmail.com>
 <ZnVEALsxt2b9s-cI@debian>
 <b2f16a9c-e916-4fbc-9f9c-87b23c0277a5@gmx.de>
 <ZnWzJKEf1B0RLOyP@debian>
 <CAC-n0DzafDJqP7LwzKJ4Gii48X1pQMZ9hXuG8SsnwoHpo_FWxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC-n0DzafDJqP7LwzKJ4Gii48X1pQMZ9hXuG8SsnwoHpo_FWxg@mail.gmail.com>
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

On Fri, Jun 21, 2024 at 07:11:28PM +0200, Caleb Connolly wrote:
> On Fri, 21 Jun 2024, 19:06 Vincent Stehlé, <vincent.stehle@arm.com> wrote:
> 
> > On Fri, Jun 21, 2024 at 01:00:51PM +0200, Heinrich Schuchardt wrote:
> > (..)
> > > The current specification is in RFC 9562, 4.1, "Variant field"
> > >
> > > "The variant field consists of a variable number of the most significant
> > > bits of octet 8 of the UUID.
> > >
> > > ...
> > >
> > > Specifically for UUIDs in this document, bits 64 and 65 of the UUID
> > > (bits 0 and 1 of octet 8) MUST be set to 1 and 0 as specified in row 2
> > > of Table 1."
> > >
> > > This reference to byte 8 does not depend on endianness.
> >
> > Hi Heinrich,
> >
> > Agreed, variant is not concerned by the endianness.
> >
> > >
> > > U-Boot's include/uuid.h has:
> > >
> > >     /* This is structure is in big-endian */
> > >     struct uuid {
> > >
> > > The field time_hi_and_version needs to be stored in big-endian fashion.
> >
> > Thanks! I thought this structure was used to hold either a big-endian UUID
> > or a
> > little-endian GUID, but now you have convinced me.
> >
> > This confirms that the generation of the dynamic GUID is missing something:
> >
> >     gen_uuid_v5(&namespace,
> >                 (struct uuid *)&fw_array[i].image_type_id,
> >                 compatible, strlen(compatible),
> >                 fw_array[i].fw_name, u16_strsize(fw_array[i].fw_name)
> >                     - sizeof(uint16_t),
> >                 NULL);
> >
> > It is not possible to cast the little-endian efi_guid_t .image_type_id as
> > the
> > big-endian struct uuid output of gen_uuid_v5() like this; we need to
> > convert the
> > three time fields from big to little endianness.
> >
> 
> I'm inclined to disagree, the comment above struct uuid in include/uuid.h
> state clearly that the format in memory is always big endian, but that a
> GUID when printed has some fields converted to little endian.

Hi Caleb,

I read the comments above struct uuid differently: the GUID has some fields
little-endian when stored in memory (and can thus not be stored in a struct
uuid after Heinrich's comments).

This is consistent with how it is done in U-Boot in various locations; for
example, the EFI_GUID() macro stores a GUID with its time fields little-endian
in memory. Similarly, the callers of uuid_str_to_bin() or uuid_bin_to_str() with
format UUID_STR_FORMAT_GUID have indeed a little-endian GUID in memory (most
often an efi_guid_t). This is also consistent with the UEFI specification's
16-byte buffer format. [1]

When you have a big-endian UUID in memory, the version field is stored in byte
6, which is consistent with the RFC 9562. [2]
If you convert this big-endian UUID with uuid_bin_to_str() and
UUID_STR_FORMAT_GUID as in genguid, the "time high and version" field's bytes
will be printed with byte 7 first and then byte 6, as per guid_char_order[].

This is in contradiction with the RFC, which shows that the version field ("M")
should be printed first.

If you print the UUID with format 'STD, you will indeed have byte 6 containing
the version field printed first as it should (uuid_char_order[]).

This is confirmed by "uuid -d".

Best regards,
Vincent.

[1] https://uefi.org/specs/UEFI/2.10/Apx_A_GUID_and_Time_Formats.html
[2] https://www.rfc-editor.org/rfc/rfc9562

> 
> 
> > >
> > >
> > > tools/genguid uses UUID_STR_FORMAT_GUID which prints low-endian which is
> > > typical in the EFI context but not understood by 'uuid -d'. Maybe we
> > > should add a parameter for the output format.
> >
> > My understanding is that there is a single universal string format for both
> > UUIDs and GUIDs, which uuid -d understands, and which has no notion of
> > endianness. (Only the structures in memory have an endianness.)
> > This means we do not need an output format parameter.
> >
> > genguid is calling the new gen_uuid_v5() function, which outputs a
> > big-endian
> > struct uuid. Therefore, genguid should print it with 'STD format, not
> > 'GUID.
> >
> > Best regards,
> > Vincent.
> >
> > >
> > > Best regards
> > >
> > > Heinrich
> >
