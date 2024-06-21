Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90739C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 17:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BFEA8840F;
	Fri, 21 Jun 2024 19:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52FBF88440; Fri, 21 Jun 2024 19:06:52 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3AF76880FB
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 19:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AE90DA7;
 Fri, 21 Jun 2024 10:07:14 -0700 (PDT)
Received: from debian (unknown [10.57.8.27])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD3E63F73B;
 Fri, 21 Jun 2024 10:06:47 -0700 (PDT)
Date: Fri, 21 Jun 2024 19:06:44 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/7] efi: CapsuleUpdate: support for dynamic UUIDs
Message-ID: <ZnWzJKEf1B0RLOyP@debian>
Mail-Followup-To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <ZnLk_pXstP2dlRGo@debian>
 <CAC_iWjL_rytosTAcsW2-3fmwVhjTgkMRAB0LwPuNpq73K=YmcQ@mail.gmail.com>
 <ZnVEALsxt2b9s-cI@debian>
 <b2f16a9c-e916-4fbc-9f9c-87b23c0277a5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2f16a9c-e916-4fbc-9f9c-87b23c0277a5@gmx.de>
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

On Fri, Jun 21, 2024 at 01:00:51PM +0200, Heinrich Schuchardt wrote:
(..)
> The current specification is in RFC 9562, 4.1, "Variant field"
> 
> "The variant field consists of a variable number of the most significant
> bits of octet 8 of the UUID.
> 
> ...
> 
> Specifically for UUIDs in this document, bits 64 and 65 of the UUID
> (bits 0 and 1 of octet 8) MUST be set to 1 and 0 as specified in row 2
> of Table 1."
> 
> This reference to byte 8 does not depend on endianness.

Hi Heinrich,

Agreed, variant is not concerned by the endianness.

> 
> U-Boot's include/uuid.h has:
> 
>     /* This is structure is in big-endian */
>     struct uuid {
> 
> The field time_hi_and_version needs to be stored in big-endian fashion.

Thanks! I thought this structure was used to hold either a big-endian UUID or a
little-endian GUID, but now you have convinced me.

This confirms that the generation of the dynamic GUID is missing something:

    gen_uuid_v5(&namespace,
                (struct uuid *)&fw_array[i].image_type_id,
                compatible, strlen(compatible),
                fw_array[i].fw_name, u16_strsize(fw_array[i].fw_name)
                    - sizeof(uint16_t),
                NULL);

It is not possible to cast the little-endian efi_guid_t .image_type_id as the
big-endian struct uuid output of gen_uuid_v5() like this; we need to convert the
three time fields from big to little endianness.

> 
> 
> tools/genguid uses UUID_STR_FORMAT_GUID which prints low-endian which is
> typical in the EFI context but not understood by 'uuid -d'. Maybe we
> should add a parameter for the output format.

My understanding is that there is a single universal string format for both
UUIDs and GUIDs, which uuid -d understands, and which has no notion of
endianness. (Only the structures in memory have an endianness.)
This means we do not need an output format parameter.

genguid is calling the new gen_uuid_v5() function, which outputs a big-endian
struct uuid. Therefore, genguid should print it with 'STD format, not 'GUID.

Best regards,
Vincent.

> 
> Best regards
> 
> Heinrich
