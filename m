Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8986C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 13:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6997B606BB;
	Tue, 25 Aug 2026 13:16:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hyPSww6TX6SV; Tue, 25 Aug 2026 13:16:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787663781;
	bh=/3hefqVq9tw8tRN4Ru7Si+tN69JKKwKJ0Z0wY8JLRfk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X6kwahNyRQpKW3NQg5fleZhQYkCFe78yMsU19eJYviFUAQLoh/A+/4fyQlMbGukQH
	 WCuTBEiiR2nv4iuKhL8VKfZF2bkvEE2uhpcgOTKhEWKg6mTLRulYm1R+OFlihDSAHQ
	 Q7utgDSaOoNR9ypkrjcpN91bLOIq1SfNszYGPgPOP2FZ+5+aDI2DVQr9sCF1W9zP9/
	 djJpiR39cJCZmKv0z2tnXOHCtEszMOZWQaDR1qX/1sHqBa9c0UBjV7Dj6TE2pvu0a2
	 YgNW2nUYUnZa3DZv0Wo+uwO9HNrGKID082WIn2QqE1tF7Knb/Elk5ZQIwIqA3l4N9Z
	 VXwNMkvRbk6zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08785606B3;
	Tue, 25 Aug 2026 13:16:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EEF1C35E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:16:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ECB9B80C7A
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:16:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qVhQgMPNg4W2 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 13:16:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=gxc9XnrX
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7261680C7B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:16:17 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so748749466b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 06:16:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787663775; cv=none;
 d=google.com; s=arc-20260327;
 b=E0cB0+7tBAnpcl+qSow8prZNhzLHEI1VJAgdUumlK6VdONLFDOqCauAurzxa6M0yB3
 4SSWHRBo3gbLghqARAYgAi5bEpfdx0CEnhFDAeGUZ6agneNOJqb/6Xnfl2PdL9dzGNuL
 X498OIvMi9rG/U67l15Org5ScVeohTC0aq7kTRszXEBsdu5+5LoNpeaMz9XIv2q9Ogt9
 xIX/puSEusyXbnhxou8yOMe4CimqytJ1eLJ6LuXZ7lQYlNPGyojIM+9YYwcQ3WBwZjUB
 mjO4pRmwXj3PFD4EUNemShu289Yiw1EHQtA1EvA/mYquSeNjd3jWXL8jXfPNaUnCRlZH
 JTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/3hefqVq9tw8tRN4Ru7Si+tN69JKKwKJ0Z0wY8JLRfk=;
 fh=/nML1aGeuBcdvzj600+T6tWGOxDOi4Q7PWsZ63CSxEM=;
 b=aik5buUfZ7oL3zOzYgjeZNZH5eSD39nyDw5+3D914HAVPg2yBzj3m77PQJKFuB/OC0
 7BwV3hBnJHyLnxJTPVKQhP6rFIzFvm80y5fT/1P+jxUXLRp4SQk79a+pd7CviG1QYhZ7
 8Kjov+NPhdA7V//uesRghFb0sy+1BPgsKfSh6VETe8n60JSdSvd0MfZuwT8/bo8WT2le
 kP/u7QAyqhjwPWusv7ggG7Y/H5py0HSqNY4VFVzkNTZIuX01dlWYYyolm/KVSkWbcTjh
 QKSO9m01DTJmgqahRqpsq5JPhdOTir5z5lfg+gfouR1c+8BPAIZyrj03ZUf8Z+slomjQ
 NoCw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787663775; x=1788268575;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/3hefqVq9tw8tRN4Ru7Si+tN69JKKwKJ0Z0wY8JLRfk=;
 b=gxc9XnrXgSKxYbD3GikkokLxWMYiHgl5uL9CYpY256TzTSyHkJ/HZRwBmZBBe80Lc8
 Iv8k63ZhRLGo0o0RPAId73W3brI2cHZM9CrApF0fVUYE9VPAEqaGuaqIineQpYvCZGsF
 VEknyELPHHBAT+pYZVf6+9jRE6dsdRSpf+dEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787663775; x=1788268575;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/3hefqVq9tw8tRN4Ru7Si+tN69JKKwKJ0Z0wY8JLRfk=;
 b=XSrSoZ8n+Zx3YrXQ6VBvz86ed0mp8d5IA0Fd9m16AAs3mzsBHxuC3Q6t2Vnq32UjqJ
 B78/U/G4tFbBW1pYYscrTcUynGB3WOhUydOJTcp5nJCPh2OI7cPlvD2i/nTYrthU1by8
 0pD8hxuscKRJMBnoAuq0zP0InyhuAemM12QMpfF2+GhiQEV7B4XxZepTCXlwt3GD1ioH
 LEIfr/+Jps4/fI4DQLf/lYlodlJ1oiA4EGRtDHYSMoBhb54uIKjNwQQSQAMbLwdYLifn
 pbRA5Mdv9sH8z+x54EFkUdmkjh0xUI9ecihKT+Wr/qygmu4vz69tTWErAAzEcrzzNwnk
 H4lw==
X-Gm-Message-State: AFuF++m32IZ271goUoNdCg8UBLWRgs8RL3CX1Uxc1wswWvCcEeZi6UTs
 NqXfMD16gMT31H7I3jbbypb6KRlwLZJQmdUwK0Qp1fcCEcdrXsVOuUi6AEtLz9N0hqj61pP6W0L
 XjxHcJr6llV6cIprWsaQ4zUj4egoF+tT24ms6Uk8H
X-Gm-Gg: AR+sD13Da6q7jXOXvZQFBWdRITng+eNEhkjQUg/M6EC7tcU1mOUIuF5RixAjl+CJ1fB
 +a2ZDD8F9b3Evtmb38h/hSUNsm+LHEuks5bBJzAxVTI+S1NLPxpdqEqNXDqh6AqZbg7PI8k3v3g
 1fx3nzySoRqcuH6nu4kseBc9ZAPKu/rgqkquMMs68jZ6Xvf2/Zp+NMyJj14wj56/Ph5kjWSUDbS
 VHFL3vmbKLOHJIgpEpRVLerY93Z6jkJ+aj6ctS27BZ0TqEf0iGsKXBb8FrsDM7vKRKbtJKGhSPx
 QEV04s+iyg1TTWSN+mTBBkHTq0e4e8qEoj05Gqczx5E=
X-Received: by 2002:a17:906:1005:20b0:c1f:97f3:7225 with SMTP id
 a640c23a62f3a-c246a3072dcmr2661795366b.6.1787663775007; Tue, 25 Aug 2026
 06:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260818175301.818739-1-valentinliu@icloud.com>
 <CAFLszTj8g4xxzt9A7txOhDMU6hLe2=twZoZPo_sr7Z5m=6BC4A@mail.gmail.com>
 <05f6b482-fb91-4979-a513-c991657b55bb@me.com>
In-Reply-To: <05f6b482-fb91-4979-a513-c991657b55bb@me.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Aug 2026 07:16:01 -0600
X-Gm-Features: AcwNN1WchAYn062EvSwuWFPWC1GwgMksL8fAUtGnGmpJyW3YM7aJa54-YyiIx4Q
Message-ID: <CAFLszTiTiYHCzwc6yN9hn49FQUeOkPRjP5H-JxJr45_Pae-_Gg@mail.gmail.com>
Subject: Re: Re: [PATCH v1 1/2] boot: android: Add Android 13+ bootflow
 support to bootmeth.
To: =?UTF-8?B?5YiY5Z6j6L6w?= <valentinliu@icloud.com>
Cc: u-boot@lists.u-boot-project.org, mkorpershoek@kernel.org, 
 trini@konsulko.com, igor.opaniuk@gmail.com, alchark@flipper.net, 
 quentin.schulz@cherry.de, marek.vasut+renesas@mailbox.org, 
 daniel@makrotopia.org, rs@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi =E5=88=98=E5=9E=A3Valentin,

On Thu, 20 Aug 2026 at 10:41, =E5=88=98=E5=9E=A3=E8=BE=B0 <valentinliu@iclo=
ud.com> wrote:
>
> Hi Simon,
>
> Thanks for your reviewing and suggestions.
>
> I can merge all scanning function into one "helper", just introduce a new=
 variable to condition which partition we needed.
>
> But I have no idea about test and document and I have not seen anything i=
n test/ or doc/ folder. Can you give me some advice?

Yes you can see the documentation here:

https://docs.u-boot-project.org/en/latest/develop/index.html#testing

The android tests are in test/boot/bootflow.c and
test/py/tests/test_android/test_abootimg.py for example. Let me know
if you have trouble running them.

BTW we try to avoid top-posting as it makes the thread confusing.

Regards,
Simon

>
> I will refactor the AVB logic in the next patch in future.
>
> Best regards,
> Valentin Liu
>
> 2026=E5=B9=B48=E6=9C=8820=E6=97=A5=E4=B8=8B=E5=8D=888:31=EF=BC=8CSimon Gl=
ass <sjg@chromium.org> =E5=86=99=E9=81=93=EF=BC=9A
>
>
> Hi Valentin,
>
> On 2026-08-18T17:53:00, Valentin Liu <valentinliu@icloud.com> wrote:
>
> boot: android: Add Android 13+ bootflow support to bootmeth.
>
>
> Please drop the trailing period and keep the subject under 60 characters.
>
>
> The devices launching Android 13+ were using a new partition
> named init_boot to store generic ramdisk.
>
>
>
> In the new bootflow, kernel still be stored in boot image,
> however, the First Stage files in ramdisk were moved to
> init_boot image. We should load it to memory and verify it
> so that the kernel can execute init program to continue booting.
>
> Currently, we have supported loading the init_boot image by
> abootimg command, but we still need bring this ability to
> bootmeth, so that booting Android 13+ will be more easily.
>
>
> Please use present/imperative tense throughout: 'were using' -> 'use',
> 'kernel still be stored' -> 'the kernel is still stored', 'were moved'
> -> 'are moved', 'we still need bring' -> 'we still need to bring',
> 'more easily' -> 'easier'.
>
>
> In the new bootflow, kernel still be stored in boot image,
> however, the First Stage files in ramdisk were moved to
> init_boot image. We should load it to memory and verify it
> so that the kernel can execute init program to continue booting.
>
> Currently, we have supported loading the init_boot image by
> abootimg command, but we still need bring this ability to
> bootmeth, so that booting Android 13+ will be more easily.
> Bootmeth will be able to recognize the new partition layout,
> and boot Android normally.
>
> Link: https://source.android.com/docs/core/architecture/partitions/generi=
c-boot
> Signed-off-by: Valentin Liu <valentinliu@icloud.com>
>
> boot/bootmeth_android.c | 67 ++++++++++++++++++++++++++++++++++++++++
> boot/image-android.c | 16 ++++++++++
> cmd/abootimg.c | 5 +++
> doc/develop/bootstd/overview.rst | 3 ++
> include/android_image.h | 1 +
> include/image.h | 35 +++++++++++++++++++++
> 6 files changed, 127 insertions(+)
>
>
> Please can you look at how to add a test for this addition?
>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> @@ -113,6 +115,51 @@ static int scan_boot_part(struct udevice *blk, struc=
t android_priv *priv)
> +static int scan_init_boot_part(struct udevice *blk, struct android_priv =
*priv)
> +{
> + struct blk_desc *desc =3D dev_get_uclass_plat(blk);
> + struct disk_partition partition;
> + char partname[PART_NAME_LEN];
> + ulong num_blks, bufsz;
> + char *buf;
> + int ret;
> +
> + if (priv->slot)
> + sprintf(partname, INIT_BOOT_PART_NAME "_%s", priv->slot);
> + else
> + sprintf(partname, INIT_BOOT_PART_NAME);
>
>
> This is a near-duplicate of scan_boot_part() and
> scan_vendor_boot_part(). Please factor the common logic (build
> partname, read the header block, check magic, extract size) into a
> helper rather than adding a third copy.
>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> @@ -291,6 +338,17 @@ static int android_read_bootflow(struct udevice *dev=
, struct bootflow *bflow)
> + if (priv->header_version >=3D 4) {
> + ret =3D scan_init_boot_part(bflow->blk, priv);
> + if (ret < 0) {
> + /*
> + * Android 12 devices do not have the init_boot partition.
> + * Some devices upgraded to Android 13 or later from
> + * earlier Android versions may also not have one.
> + */
> + log_debug("scan init_boot failed: err=3D%d\n", ret);
> + }
> + }
>
>
> priv is allocated with plain malloc() above, so it is not zeroed. On
> failure here priv->init_boot_img_size is left uninitialised, then
> boot_android_normal() and (in patch 2) run_avb_verification() read it
> back as 'priv->init_boot_img_size > 0'. Please use calloc()/memset(),
> or explicitly set priv->init_boot_img_size =3D 0 before the call and on
> the failure path.
>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> @@ -556,6 +614,7 @@ static int boot_android_normal(struct bootflow *bflow=
)
> ulong loadaddr =3D env_get_hex("loadaddr", 0);
> + ulong iloadaddr =3D env_get_hex("init_boot_comp_addr_r", 0);
> ulong vloadaddr =3D env_get_hex("vendor_boot_comp_addr_r", 0);
>
>
> If init_boot_comp_addr_r is unset, env_get_hex() returns 0 and you
> silently load init_boot at address 0 and call
> set_ainit_bootimg_addr(0). Please check that iloadaddr is non-zero and
> error out with a clear message before using it - the vendor_boot path
> has the same weakness, but let's not extend the pattern.
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> @@ -326,6 +326,22 @@ bool android_image_get_data(const void *boot_hdr, co=
nst void *vendor_boot_hdr,
> +bool android_image_get_data_v4(const void *boot_hdr, const void *vendor_=
boot_hdr,
> + const void *init_boot_hdr, struct andr_image_data *data)
> +{
> + if (!android_image_get_data(boot_hdr, vendor_boot_hdr, data))
> + return false;
> +
> + if (!is_android_boot_image_header(init_boot_hdr)) {
> + printf("Incorrect init boot image header\n");
> + return false;
> + }
> +
> + android_boot_image_v3_v4_parse_hdr(init_boot_hdr, data);
> +
> + return true;
> +}
>
>
> I can't find any caller of android_image_get_data_v4(). Please either
> wire it up to whatever consumes init_boot_img_total_size, or drop it
> (and the new struct field, and the header declaration) until it is
> needed.
>
> diff --git a/include/image.h b/include/image.h
> @@ -2167,6 +2184,17 @@ bool android_image_print_dtb_contents(ulong hdr_ad=
dr);
> +/**
> + * is_android_init_boot_image_header() - Check the magic of init boot im=
age
> + *
> + * This checks the header of Android init boot image and verifies the
> + * magic is "ANDROID!" (same with the boot image)
> + *
> + * @init_boot_img: Pointer to boot image
> + * Return: non-zero if the magic is correct, zero otherwise
> + */
> +bool is_android_init_boot_image_header(const void *init_boot_img);
>
>
> Declared but never defined or called - scan_init_boot_part() uses
> is_android_boot_image_header() directly, which is correct since the
> magic is identical. Please drop the declaration.
>
> diff --git a/include/image.h b/include/image.h
> @@ -2199,6 +2227,13 @@ void set_abootimg_addr(ulong addr);
> +/**
> + * set_ainit_bootimg_addr() - Set Android init boot image address
> + *
> + * Return: no returned results
> + */
> +void set_ainit_bootimg_addr(ulong addr);
>
>
> Missing @addr: description, and a void function does not need a
> Return: line - please drop it.
>
> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overv=
iew.rst
> @@ -293,6 +293,9 @@ script_offset_f
> +init_boot_comp_addr_r
> + Address to which to load the init_boot Android image, e.g. 0xd0000000
>
>
> Since this env var is required for Android 13+ to boot, please also
> document it in the relevant board README(s) / sample env, and handle
> the missing case gracefully in the code (see comment on
> boot_android_normal()).
>
> Regards,
> Simon
>
>
