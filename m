Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5BFCDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 14:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E088484704;
	Thu, 25 Jun 2026 16:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QvCx7PWN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 732F0847C8; Thu, 25 Jun 2026 16:55:22 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 537588460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 16:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c0c964d6470so418802666b.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 07:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782399320; cv=none;
 d=google.com; s=arc-20260327;
 b=SoLKH1zugRvm+wW/OSGnpL8pu/vejEGAuGo+iO9uDwsI+NFtnblX4AHm2URVRfkClx
 hRd+XGELeA56BLrBP9gAHz5yLjdiG9UjgnoLcozbsx4tA0ldKKTYLfpSfZyGOtGDikXq
 3g7z5q1dFXqbudqG87orQBzIXhYJEcUZxHNYrhtxCBZEEPTYT/vtAHhDHc4uNgbQypXc
 e7IqLNdg1UASJJ3iw6YBSYjrq/z8pnNQvVkU32+PH8TrM8X+5z/TC8RTmWgGhJD4CuWe
 vNylb8Y81Q+9vTFP3ayLoaUMeUFQp3y+J9XAvCmiYtAqM4cendxW8CL5cmQDFN45984p
 4R/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WWf7qkkefZS7klVI/yWyUmHv3bNdZIKYhErrnAPnHas=;
 fh=nvWXBzM7H+2SWq6TxayLG2f3U3bE/EkBS/MqXJY1b+0=;
 b=cx1l3PhIfX4NZvqvcI1+HoT6g/sVVg77B3xsMQj6IPRYXnx84eI/dA74eCbjTDhTQJ
 1ONnYE0/iFAhmb14TfNvnbb5P2dpp1LPypglinNCH0weKq+YB+03dl1IQCFCcrXv0GOr
 DvkT7UUDDo+0+o/lAe8+Bux0hiTUawd2UA1JDATF1KZvG2E0BJGABUAZF+Z8Q/azoLHm
 cGLJFRsOQKsGbpFmR5mgMxRoQz+D0x47WoCbdAHKwyAUKm69w5+aj+cKoiAO4fOeGEcO
 mxqLz8fa43yE1OFLgaacXlZE1VkTnP3OjTBcO4yOgGe+pOqkW0EsAYqmznLVsZUgvXWA
 zitw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782399320; x=1783004120; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WWf7qkkefZS7klVI/yWyUmHv3bNdZIKYhErrnAPnHas=;
 b=QvCx7PWNnYf1ooxQHjXcQXqsjp9J/4/sNwuBBhrI9ZP720xShWUQ33OBnvJETctOxQ
 Kz9Y51LUqUp32vrb8MkQ3JX/k5a5gKGpzpfaJw3WqnZSLthJzfgZM1qoPwUfZ6MKSkY2
 3RqpFkwOzSRp1srxccG6sw13qiIRSu2RUsgPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782399320; x=1783004120;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWf7qkkefZS7klVI/yWyUmHv3bNdZIKYhErrnAPnHas=;
 b=Q7vtrHjzZyXZVNrxgMRlNYM016RYor16B8wL/ciFieiUOUS/EySpvAnGKyLRfeEJ23
 RJUdq7rIQFptLvVu5E8J479PTVv+f68rueJZIZq13piKQ6T/u6WCcV8boph3Qvqxns4l
 bCbYpPgS+agM3XJaMJIpHANoRExbfR1zzpDdzZyFeCKuRWxYQKYybL2Ond53H9Ccbxrv
 9qWiJ95lCkthCGzzyaIdbdBCkgwU5275xjsNyh9AvXQTRpgpHGha4/i3aCsp3dpY4OnU
 S8mmYQj6ypwIenLJWdk4LJYgHo8ojUs53dutj3l8FyFrPLtN9BGPnL16JeZwRyk2NGa3
 EkEg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkTSnoijD/wO8zc48SBKqGAUqWT3ctqIY82Tw8qI26W79rahZ7f/dW8rUc/PTte71u5LAmBvA=@lists.denx.de
X-Gm-Message-State: AOJu0YxvNr6pgxA7Q0TiuERR4JSKQ1bo4A6UhT7opKZS9MkTpOQcvgFh
 +2jEKTy6/qdhTTQgywLJe1V5zmsmXRIUY9ueDmYcKu0PlRIc4NqaKZPOMAU0vgweARUS1uykVpj
 /S/GlNRFuNR+fbi1LqFitc+dbYOrWiBbjA3OXhmnX
X-Gm-Gg: AfdE7cn6ti+kbtn6LZSUHsN3KteDvdvMv5kGjJlYavTu7Z7rcj1AL31LseQ94z5V2SF
 wTOKW1YE/Swv4ngItj5wLrNMtS79UJauv8uYGRhUJ9IhHNSHB8aQQ+lRVXAavX8n5EnnD1ikTGF
 mCMnzIPJmne/kAr11PSeDenACHlNdxMEq/DhabDK1nwXj9Nms1X0tdutu2uIa1EyfU4wuQ7ASEb
 e8mTfoUIBVVnvrW5zqydD4/6A4p8cqgKglRyCnaDEk+trVNbisGKg3YpiBLQ/rXtt8AjJ9Axg==
X-Received: by 2002:a17:906:6a19:b0:c0e:5893:196f with SMTP id
 a640c23a62f3a-c1205d2cc59mr235015766b.1.1782399319763; Thu, 25 Jun 2026
 07:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-3-heinrich.schuchardt@canonical.com>
 <CAFLszTiu0HSZ4JJ7ggMMAk4oe0-h=Xq-Wnw=hqwGr80wBdrGXQ@mail.gmail.com>
 <e262d779-4854-4360-8d9a-a91ff76b5347@canonical.com>
In-Reply-To: <e262d779-4854-4360-8d9a-a91ff76b5347@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 15:55:07 +0100
X-Gm-Features: AVVi8CdQ-shy4wkZrxgbqSu4gRxTtIEQUytkmeL8anSYew7IKWz8pPVjJKr_Kbs
Message-ID: <CAFLszTj7D-q5QtKTDX07t529wS+hfUUjEq2vK+6rJF9psC8KGw@mail.gmail.com>
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

On Thu, 25 Jun 2026 at 12:26, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 6/25/26 10:52, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On 2026-06-21T08:19:04, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >> efi_selftest: add ACPI configuration table test
> >>
> >> The new unit test checks if ACPI tables are available.
> >>
> >> If yes, it checks if the RSDP correctly points to the RSDT or XSDT.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>
> >> lib/efi_selftest/Makefile            |   1 +
> >>   lib/efi_selftest/efi_selftest_acpi.c | 138 +++++++++++++++++++++++++++++++++++
> >>   2 files changed, 139 insertions(+)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> >> diff --git a/lib/efi_selftest/efi_selftest_acpi.c b/lib/efi_selftest/efi_selftest_acpi.c
> >> @@ -0,0 +1,138 @@
> >> +     if (!checksum_ok(rsdp, 20)) {
> >> +             efi_st_error("Invalid RSDP checksum\n");
> >> +             return EFI_ST_FAILURE;
> >> +     }
> >
> > Please avoid the magic 20 - how about offsetof(struct acpi_rsdp,
> > length) or a named constant?
> >
> > Regards,
> > Simon
>
> Thank you for reviewing.
>
> 20 is not an offset. It is the length of the ACPI 1.0 RSDP header.

...which is the offset of the length field. See the struct:

struct __packed acpi_rsdp {
   char signature[8];   /* RSDP signature */
   u8 checksum;      /* Checksum of the first 20 bytes */
   char oem_id[6];      /* OEM ID */
   u8 revision;      /* 0 for ACPI 1.0, others 2 */
   u32 rsdt_address;   /* Physical address of RSDT (32 bits) */
   u32 length;      /* Total RSDP length (incl. extended part) */
   u64 xsdt_address;   /* Physical address of XSDT (64 bits) */
   u8 ext_checksum;   /* Checksum of the whole table */
   u8 reserved[3];
};

The original struct ended with rsdt_address as the final field. Then
they added a length and some more information. So the offset of
'length' is actually what you want.

My failure to use offsetof() was probably just that I didn't know it
existed, or perhaps because some of the code came from coreboot.

>
> Below is the precedent that Bin and you have been setting:
>
> arch/x86/lib/acpi.c:18: if (table_compute_checksum((void *)rsdp, 20) != 0)
> drivers/misc/qfw_acpi.c:310:    rsdp->checksum =
> table_compute_checksum(rsdp, 20);
> lib/acpi/base.c:36:     rsdp->checksum = table_compute_checksum(rsdp, 20);
> test/dm/acpi.c:371:     ut_assertok(table_compute_checksum(rsdp, 20));

Yes, this is quite common. How about declaring a constant for it?

Regards,
Simon
