Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E71CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E490847B0;
	Mon,  8 Jun 2026 15:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GTc7JteC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5E40847C3; Mon,  8 Jun 2026 15:27:10 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 665098481F
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-68d23430690so8597064a12.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 06:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780925228; cv=none;
 d=google.com; s=arc-20240605;
 b=GyeRWIqQFmE0JN0sXEwPJxMAJ+N/gASIPw8WFglBWe36rfnm7//oYN6zA/leWiMzUq
 Xolugux8UT9Er7nMyf52O7ddmdbGHA8Ak8mXj7DDWfKRjrQf1UJqKsbMO9VFNKK9djVg
 bbm/qB0M9FHqogi/Pja0kPHKY/pPUM3NFhM1dKUV5roxHeGBkQ9613yRkhuGB2lk1eAF
 ZPHh8wmpJ3X+hgHdpBWrfnPOHKWc6yLPnbltc6J6sQgx3TFF0UKPa+PvAiotV8Xyp5KE
 5E2JYODaC4AmYW7TxCpCnmFVJGMWkw5Ini0Z4u4Z2yzX9w+q0fiS+CMI6599VG7WHMGq
 HymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Qi5QRHotsO10XGCZURnUMCPlq3mWQWfG7ziIAhlHO8g=;
 fh=Odq9NGuM9IwpgVvl6kT7EijzuJ2AzFvZQNxDvfa4hmk=;
 b=Lvfyg99n+U9jqESUCoDLiEXTwQNKGrbXpGKWawPdarxe24y9rhSf5It7QWpWw4VAGj
 mrBhA0tYvrRI59Rbd0cgBrODV8d1VRr4E7DGh7zJttCSHrxqISJKWZwToLgIYAAD8yym
 OOCBa3Lxl3vSkHHabmCXYpxscyJ5qfkU7DORoojtl+Vlcy4izVqi+lV9+epG/Et+bJLi
 U47WdazJjKsRNUcKDA8nSpurBJgRNDzAAe1+AZt6zJPM2i9qsnEZRUDb2tXTJQYxTeaC
 +pBXy1b/V5Jkb1rcavDxZ+uHnAIoaBeyJuu3l1bi6oWPm3RfA0oeJrBRc8c+nI3xaf/j
 wzTg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780925228; x=1781530028; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qi5QRHotsO10XGCZURnUMCPlq3mWQWfG7ziIAhlHO8g=;
 b=GTc7JteCBmNa5QUcdFSelLWMJMmInki00xwxi+hZpF7DuFhnPdR0xRBb5kl1fKSf6H
 I/TmcUpzBYxehFtXiaSTOZ3P1jNxSrz9TEvpogv+Ozq/s/Dy9n15Idt3g5kG/W+Vh1rd
 rfkc4ggaCCcz7NMYby8A+QhZGIMFb/kHI7YTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780925228; x=1781530028;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qi5QRHotsO10XGCZURnUMCPlq3mWQWfG7ziIAhlHO8g=;
 b=F18w5oFwl9LwpeSpORiC4S6Adn9l4tx1i4t1Jfq0cQr4N/onNtU2+Rq7LEwDf0VpLN
 NW1L9ld5ym0QihJcyxrumdMt3KUill4+j/D5lR4XbvHgK323CMoYoUgHNMilixxxL1p+
 0Uq+SvDYSv6+2DrEjVQbDmjLVgUuoQXlZ0JJRhq2zcFyRjhUM931xP1wEwuFAUhPLEjC
 ZR8YmjLOJx6MjDYZa6ordMdkJ+mT9fpmi3QNsHOdWmbqBvNlN0iyDScgDTkv7vo+KR8x
 Weh1ZrSxxcnc4V0YEfFx1CjOpdRwjKrC7nfoZi6v70RQcBTDVUWK4ANPj3n83hSARfqa
 r1Lg==
X-Gm-Message-State: AOJu0YwJrNY6Ca+WlQz+8Km3BzFGvLwbTKeRvW68h7u58uSLPG0zWPSF
 8Wcs4kDB3GAu1cZ7V5zPDeomXgQnSgZ/7eyhBvWa2YIGFT/Yhvm87uwnH0H73+od2n2/+LNrn5B
 6ML/zzuQ9c5+7cIUvBVFHvR57V+vvEC+AgXt+PW1X
X-Gm-Gg: Acq92OFfrEWVePZomnHO51uL/s/me37Bt59AAhi9sEywHvaEjKkAJcQxe2Nc3UH+H2x
 J+iymQwrZvvXTcImNKExHyYC3HcCEw/B8H7IVVSbDDZkhwBXcwsy2hdPvejokTgRNJBd9ws9apS
 StnPxttlrM9NVXzDuNltOBjQsDRpki2ut7Ip9KOUa51+VVSN9kCeZtbi/7ANxQlj/L7U3YLThu1
 r/jecxXzHCHAuAue2SKRMfWHVK2PbhYxHW8ZC38eO7p2G35qudkwFivMUBv8JpWCZzXUi256kwV
 mH4TX02rMBB68RsC
X-Received: by 2002:a05:6402:845:b0:68c:eb73:391a with SMTP id
 4fb4d7f45d1cf-68fa4e1c3demr6889417a12.11.1780925227788; Mon, 08 Jun 2026
 06:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-3-b8203682507f@samcday.com>
In-Reply-To: <20260608-android-binman-v2-3-b8203682507f@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 8 Jun 2026 07:26:54 -0600
X-Gm-Features: AVVi8CeQWxu437vUnWmbLP3TLPzztjB8X82zBMDOjr4mPFHK2It6nXpN1nwtYkg
Message-ID: <CAFLszTiA8nCAuaWv4CsfEBWNfOJo74XD=fzpfLV=Q=ku=3FrRA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] binman: android_boot: vendor-dt support
To: me@samcday.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Javier Tia <floss@jetm.me>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>
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

Hi Sam,

On 2026-06-07T23:37:09, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> binman: android_boot: vendor-dt support
>
> There's many Android bootloaders out there that expect non-standard
> abootimgs. Samsung and Qualcomm, and likely many others. This quirk has
> been codified in the widely used osm0sis fork/rewrite of mkbootimg.
>
> Presumably, these vendor-specific abootimgs were conceived before the v2
> format was widely available or specified. The evidence for this is their
> hijacking of the header_version field to specify the length of a payload
> that follows the main abootimg.
>
> At least QCDT and DTBH (both of which will be implemented as binman
> etypes in following commits) use this approach.
>
> Link: https://github.com/osm0sis/mkbootimg
> Signed-off-by: Sam Day <me@samcday.com>
>
> tools/binman/etype/android_boot.py                 | 37 ++++++++++++++++++++--
>  tools/binman/ftest.py                              | 11 ++++++-
>  .../binman/test/vendor/android_boot_vendor_dt.dts  | 27 ++++++++++++++++
>  3 files changed, 72 insertions(+), 3 deletions(-)

> diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> @@ -131,17 +136,26 @@ class Entry_android_boot(Entry_section):
>                  self.Raise('page-size must fit the Android boot image header')
>              if 'dtb' in self._entries:
>                  self.Raise("Subnode 'dtb' requires header-version 2")
> +            if self.vendor_dt_node and self.os_version:
> +                self.Raise("os_version not allowed when vendor-dt is in use")

Two things. The message uses the Python attribute name; users see the
DT property, so this should read 'os-version'. Second, the commit
message doesn't explain why os-version becomes invalid in this mode -
in the v0 header layout, dt_size (the field we hijack) and os_version
are separate u32 fields, so there's no obvious conflict.

If a downstream bootloader interprets os_version differently when
dt_size is set, please document that - otherwise I'd drop the
restriction. Either way, please add a test for the Raise().

> diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> @@ -152,6 +166,15 @@ class Entry_android_boot(Entry_section):
>              entry.SetPrefix(self._name_prefix)
>              self._entries[node.name] = entry
>
> +    def _ReadVendorDtEntries(self, vendor_dt_node):
> +        entry = Entry.Create(self, vendor_dt_node, etype='section',
> +                             expanded=self.GetImage().use_expanded,
> +                             missing_etype=self.GetImage().missing_etype)
> +        entry.page_size = fdt_util.GetInt(self._node, 'page-size', 2048)
> +        entry.ReadNode()
> +        entry.SetPrefix(self._name_prefix)
> +        self._entries[vendor_dt_node.name] = entry

Forcing etype='section' here works only because qcdt/dtbh later walks
up via getattr(self.section, 'page_size', 2048). That coupling is
invisible from this file. Please add a comment noting this attribute
is consumed by child etypes (qcdt/dtbh in later patches) - otherwise
it looks like dead code. A cleaner alternative would be for the child
etype to look up the android-boot ancestor directly, so page-size
doesn't need to be smuggled through an unrelated attribute.

Also 'page-size' is re-read from self._node here, but ReadNode() has
already cached it in self.page_size. Just use that.

> diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> @@ -246,7 +278,7 @@ class Entry_android_boot(Entry_section):
>                               0, # second_offset
>                               self._GetAddr(self.tags_offset, 'tags'),
>                               self.page_size,
> -                             self.header_version,
> +                             len(vendor_dt),

This conflates two distinct fields. For a plain v0 image the slot is
header_version; for a vendor-dt image it's dt_size. The current code
only produces the right bytes because both collapse to 0 when there is
no vendor-dt. Please make it explicit:

    dt_size = len(vendor_dt) if self.vendor_dt_node else self.header_version

and add a comment that this slot is overloaded. As written, anyone
adding a new v0 header_version in future will silently break vendor-dt
builds.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5662,7 +5662,16 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>          self.assertEqual(U_BOOT_DTB_DATA,
>                           data[0x1000:0x1000 + len(U_BOOT_DTB_DATA)])
>
> -        self.assertEqual(U_BOOT_DATA, data[0x800:0x800 + len(U_BOOT_DATA)])
> +    def testAndroidBootVendorDt(self):

You're silently dropping a duplicated assertion left over from patch
1/8. That cleanup belongs in its own patch (or a fixup to 1/8), not
buried in the vendor-dt commit.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5662,7 +5662,16 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testAndroidBootVendorDt(self):
> +        """Test that android-boot can embed an arbitrary vendor-dt section"""
> +        data = self._DoReadFile('vendor/android_boot_vendor_dt.dts')
> +        header = struct.unpack_from('<8s10I16s512s32s', data, 0)
> +        vendor_dt = b'howdy'
> +        self.assertEqual(len(vendor_dt), header[9])
> +        self.assertEqual(0, header[10])
> +        self.assertEqual(self._AndroidBootId(U_BOOT_DATA, b'\0', b'',
> +                                             vendor_dt), header[13])
> +        self.assertEqual(vendor_dt, data[0x1800:0x1805])

Coverage is thin. Please add tests for the two new Raise() paths
('vendor-dt' on v2, os-version with vendor-dt), and assert that
vendor_dt is padded to page-size - slicing [0x1800:0x1805] only proves
the first five bytes landed, not that the next 0x7fb bytes are zero or
that the overall image length is right.

Regards,
Simon
