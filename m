Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D033C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 17:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A30D18893C;
	Thu, 13 Jun 2024 19:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nM+2TULL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2008288938; Thu, 13 Jun 2024 19:11:02 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF14F8892E
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 19:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-35f18e66530so148046f8f.1
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718298659; x=1718903459; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7rGpnLuzdBWiPo+CXU/EnlTq8ff3QE8grATl4MIg/8k=;
 b=nM+2TULLrK564IxQR06emlmXXOOou3TFo6Ox7tIVcFW/cJvGyxwTTnG15X54LL3+eK
 dNN+ZvRNqJO9gzImj+2UF3qKcgJgydG0XgD2eu+tzRYESwlPY2e397a2lXWwiOPoD50E
 8hv+XFKdk0sI/5DJUY/ePZmD6xXXDqFCSRx82NmlUgv4lZcM4Qko3+C80QZBlGgwf8VL
 rhfJsZ271XSP8H3NuuWbccPubKV/cN1j1GDaQU1J4csmF5lfxIEs2l9fcIr2/+aHDWsR
 jekurLd+lcly5EyP4rwT3d+Zpjie2+adSNFIfhoUd9/o7DIeyuU6QUiuoCLn3ZWhOc0i
 CBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718298659; x=1718903459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7rGpnLuzdBWiPo+CXU/EnlTq8ff3QE8grATl4MIg/8k=;
 b=ntchZhwwX6Wej393DbsZLLQsiOKf1J2UvyK0JUh9cBjAYodpg0GOVDp5PdpWiby3dy
 6NbTKAf4V+M+SYdnVeNqYjhzPF5QSo7298+jNCfoD4JXUV9hZhMrQ5SV3Wf29IziVlW/
 IZLWN5d87Yvarw7dcNVYgqWSRrHEz9Mtd91d3wML/e/p5Lxa98C+x4KpvPy24DKkVeFC
 su2tjsAk6D6p9OZ+ia/jCyv4dxmMfIadf1KhRXPxBOMMGBsQURujXVVX2vGO8TB7BsCo
 035PA4mVu9npMKCAMGIr9nA25A9KC+Env4OK5yS/XL7Q7Ifx0x7rOqkAPt9Qa2wZNIHv
 17EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQlmz0/t4THDD6gaMstfTxBMlvd26I7foXUf/bRoXWQVFp/FS77OtwVPohVieJmPn+ERJVpJt1NC0/IhtyWVFdhJWjqA==
X-Gm-Message-State: AOJu0YyHBZN5wKFOK7Mq2m9KqIwqlEudT+xTUKcc4wg5/hwmSynrTymX
 /X40lQY3HIaOM6828B+tJrgtE+bOL1ifNUJxUdWpxtxeOZOp7bjvKH3KPvSPpraafkNdb8f3DIz
 SaEsQw6zSOeIzGpqrd2S6F9JrcEU=
X-Google-Smtp-Source: AGHT+IFMwhZhVFlkOreiFqtBqPX6xpy1z7QjuU/j1WV0pjLSYV4OAK8b4NX+vTe/vDc0bCZZu/s/0KUEv9eLY4aFuRc=
X-Received: by 2002:a5d:6c69:0:b0:35f:1f7e:892e with SMTP id
 ffacd0b85a97d-3607a78685amr199831f8f.7.1718298659154; Thu, 13 Jun 2024
 10:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
 <20240613-bootmeth-android-v2-1-397f6e66eb29@baylibre.com>
In-Reply-To: <20240613-bootmeth-android-v2-1-397f6e66eb29@baylibre.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Thu, 13 Jun 2024 19:10:47 +0200
Message-ID: <CAByghJYJ0ed=i79JLK_Lh217-AgeJ2eN8qjd1i8yUQcKBChkDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] boot: android: Provide vendor_bootimg_addr in
 boot_get_fdt()
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, u-boot@lists.denx.de
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

On Thu, Jun 13, 2024 at 12:13=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> When calling android_image_get_dtb_by_index() using boot image v3+,
> we should also pass the vendor_boot ramdisk address.
>
> Use get_avendor_bootimg_addr() to do so.
>
> Notes: on boot image v2, this is harmless since get_avendor_bootimg_addr(=
)
>        returns -1.
>        for legacy implementations that don't have CMD_ABOOTIMG, add a wea=
k
>        implementation to avoid linking errors.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  boot/image-android.c | 5 +++++
>  boot/image-fdt.c     | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index ee626972c114..09c7a44e058a 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -56,6 +56,11 @@ static ulong add_trailer(ulong bootconfig_start_addr, =
ulong bootconfig_size)
>         return BOOTCONFIG_TRAILER_SIZE;
>  }
>
> +__weak ulong get_avendor_bootimg_addr(void)
> +{
> +       return -1;
> +}
> +
>  static void android_boot_image_v3_v4_parse_hdr(const struct andr_boot_im=
g_hdr_v3 *hdr,
>                                                struct andr_image_data *da=
ta)
>  {
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 56dd7687f51c..8332792b8e80 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -502,7 +502,7 @@ int boot_get_fdt(void *buf, const char *select, uint =
arch,
>                  * Firstly check if this android boot image has dtb field=
.
>                  */
>                 dtb_idx =3D (u32)env_get_ulong("adtb_idx", 10, 0);
> -               if (android_image_get_dtb_by_index((ulong)hdr, 0,
> +               if (android_image_get_dtb_by_index((ulong)hdr, get_avendo=
r_bootimg_addr(),
>                                                    dtb_idx, &fdt_addr, &f=
dt_size)) {
>                         fdt_blob =3D (char *)map_sysmem(fdt_addr, 0);
>                         if (fdt_check_header(fdt_blob))
>
> --
> 2.45.2
>
Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk
