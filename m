Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA997E77188
	for <u-boot@archiver.kernel.org>; Sun,  5 Jan 2025 02:50:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1AF58036D;
	Sun,  5 Jan 2025 03:50:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XsA0eNQx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14258803DC; Sun,  5 Jan 2025 03:50:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCE07801DE
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 03:50:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736045416; x=1736650216; i=xypron.glpk@gmx.de;
 bh=GZqKm/BljjMIEW7B3XCOaKHZgU9xyLK88+tEew8PmNM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XsA0eNQxWm7bbvndC4X5/8mZa0kxyx4mtb3qIFUNxfnKRZpQs3PLrgkdURb3MtsN
 ugxpO/MhUQZf0jitLkyQQMoJ/aLzBhE3FjDSOzi9wAcuneFhNCdZVK8jb32g5PF3G
 iApHOxlncZ5LEWHn42eJ2WkpNJE0RjiodYsaKdfLRkHCBMNvqtu13yH8Vw2cBtd6i
 3laULgsS6EJXe/ZPpM9HeFrMYYAiQThm2yUK4z7gELqWba78/UC5uA4v6L0mJUYUL
 51MOHr+z2c6YfxAX1ahtO4UbsCIzGKIaiCrSVbRp+i62nc8C+6U1kahJmpnCvJJlU
 5uETBo0KgEdXZtbZiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.106.210]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC34X-1tK4V30UiD-009Qvr; Sun, 05
 Jan 2025 03:50:16 +0100
Message-ID: <517d087e-4ac5-4fd5-a37f-d4d3aaa534bd@gmx.de>
Date: Sun, 5 Jan 2025 03:50:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] RFC: Revert "bootstd: Make efi_mgr bootmeth work
 for non-sandbox setups"
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-5-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241113150938.1534931-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tB+LivLiK/oG8KV/b71oNwELBts7l4w0q7TNkJymWpU+EiUFzSl
 G576vwrrYbf/zN6SEtjdc5Z35HEym6kb64i/tRjsZIsypZvgOC18bHv1BvCCgNb1/8WOguQ
 q7D7uJ8l4BJo1zcqdMDBrkcXm84wPOMTIl1ptJ+gsI6IMnmqhVZ60K8eQPD594dsaCpwJbF
 BX8flrfI+yIFNM0Tsomfg==
UI-OutboundReport: notjunk:1;M01:P0:fxCuUcvoeX0=;tPhY0o03l2kcy/HyugMOtB4vNLl
 j+kadV2dP0xlsMVf0f3b1S978OEzKA1pw19WG2EAQW4XfTQfvzQs3OgLSt6e1TtRP2FH1w5V7
 lHOBbTERaUnNU+W8+PcbyGddqPaMxSdlSbntF2CS6je3FkM8sA5aAUgfFH+Wo2U8cqD9Cj5jM
 h/6L4n5sUdcnzDm3UANgCWoHWhLWVUpxxCCAS2fQF75G5z6zaLasWFrIV5PaYzNOkdnxo1+Hm
 RXhYaHGsXwUWF2//wi2MEL8cunLFvf8/uJ62LvgLKfcd+ulZaY+sWh2ECHIyAWRGp0IfpTmUK
 8QP7V2t7CxJzPj6KXWKoZ164glig0wiHWf+PPlAxrKk2s3AD9CbYpW+W535QbLzv11xvuW+JV
 H4T90pLpjMr8XiCzRL85+5Lkt4GmtT/3DEIig7/PHTVv/0YT57SSgp51B+ZD3rafTr+a44pYU
 BiFiku3vd4Sg5aBJAnEysvq953PTEwZDPVFDVzmbtPnEhtVuWhHnEIq44eFoDp5W+jHFh4bwR
 5c5MvYrDwA0UI/wSIpK1/SfH6lAU2vW3tOX4pQE019QKVuI9kwTa512lQZUXqe/U7F5xcgR2n
 JlVE6GLh4YTA0QBcWDdb33MZtBTkfF+Qe8NeGH/h0ku788KO3kHTO+V8pKZptRJC0XV3XYoI3
 fbadh8EUYyFWhbOHYoehiXuV6D0T4QydzqTVGKeJXUTej1mK0qyM6lf7TkZDQ9KHy4wAx6dyg
 ufWVTr4p/q+ho0SkjevBeLUM9RrTYDcW8QpE1aQfuBG3PLahg9tWTIlM9n9Sq3H+9FhRk2QoJ
 xXEU4hjOmuJc01DqZeRVrMWbIpirqoeDGYJzAxQyBsLrDisdQOwZJVF9ZQbAKdHlLJOGTX2qM
 PqgsMKkMwwnz29TUjgFlMLZdL07Y2U1q9tydGrQfuyMaZVi2cDLhHtsAhzKiI5o74C2e+Y/G+
 MbOZ5YGn3jnMVaxnqZOMiat9J5wfJu7W+uaWjSKhxc+wgPdpsEnGZEq28CJPfrgFgBkXFNGuD
 ijbSwqX8jLk9F7JUukQDK4vHsT99uwMKVTMRWBTgrsyfhXvcIQdPthGvZrCdXEWAyfNJJF1XP
 wuzJ5bPHmZANhKAXl4vkfLy34dAK1H
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

On 11/13/24 16:09, Simon Glass wrote:
> This is another option to fix sunxi booting with bootstd, which may be
> better since it will work for all boards. We can then figure out how to
> automatically and deterministicaly decide when bootmgr should be used.
>
> This reverts commit f2bfa0cb17948aa4a0fa20fdf9014296b9c4d9c7.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> If this patch is applied, we don't need to drop bootmgr for sunxi
>
> (no changes since v1)
>
>   boot/bootmeth_efi_mgr.c | 18 +-----------------
>   1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> index 23ae1e610ac..095fa74fc60 100644
> --- a/boot/bootmeth_efi_mgr.c
> +++ b/boot/bootmeth_efi_mgr.c
> @@ -14,8 +14,6 @@
>   #include <command.h>
>   #include <dm.h>
>   #include <efi_loader.h>
> -#include <efi_variable.h>
> -#include <malloc.h>
>
>   /**
>    * struct efi_mgr_priv - private info for the efi-mgr driver
> @@ -48,27 +46,13 @@ static int efi_mgr_check(struct udevice *dev, struct=
 bootflow_iter *iter)
>   static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow =
*bflow)
>   {
>   	struct efi_mgr_priv *priv =3D dev_get_priv(dev);
> -	efi_status_t ret;
> -	efi_uintn_t size;
> -	u16 *bootorder;
>
>   	if (priv->fake_dev) {
>   		bflow->state =3D BOOTFLOWST_READY;
>   		return 0;
>   	}
>
> -	ret =3D efi_init_obj_list();
> -	if (ret)
> -		return log_msg_ret("init", ret);
> -
> -	/* Enable this method if the "BootOrder" UEFI exists. */
> -	bootorder =3D efi_get_var(u"BootOrder", &efi_global_variable_guid,
> -				&size);
> -	if (bootorder) {
> -		free(bootorder);
> -		bflow->state =3D BOOTFLOWST_READY;
> -		return 0;
> -	}
> +	/* To be implemented */

The EFI boot manager can boot based on:

* variable BootOrder
* variable BootNext
* an existing file EFI/BOOT/BOOT<arch>.EFI

It obsoletes bootsmeth_efi.

>
>   	return -EINVAL;

We must always run the EFI boot manager if it is enabled. So -EINVAL is
wrong here.

Best regards

Heinrich
