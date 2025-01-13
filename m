Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131F9E7719E
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 07:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D74C80141;
	Mon, 13 Jan 2025 08:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HH7eCz2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57379801CF; Mon, 13 Jan 2025 08:40:59 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4562A8007D
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 08:40:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736754053; x=1737358853; i=xypron.glpk@gmx.de;
 bh=uCatCkuc1PxE5/RMcx25gq8eN25cfzf9eeqdYwDU8As=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=HH7eCz2D8G7iQ2ePzikZHTFZUb184NcKqn4Afsba0Kq6xqT5bAKF/e4mYyeLWzPu
 3ey5y45fa0bhdxo72dGvCuuCrHbheAn7FNLFbI2vv4wsYVaYTOWzCmNng8qnNNUPy
 DctEZTdOP6LlMbbg6W7LdXBQGQTTXy8k3bM7JU4tfTp2vPCQsBaGnwj4j7ThBBXdd
 Mg3b+bh33Cwg28iCt9Nw8/5GK9k0ZDbnfgTGgVDlQEripB+3r0Qq2c/fI6UAOrWjy
 7IL/ybcbyToLB68EoxksaoEiHudM5rgszjtBRWlsfDnLKhoFwwLLQVINyG3zDWl+G
 CX1EbGMdKZdTeo00Ng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8qd-1t1V9U1Ht7-00o48P; Mon, 13
 Jan 2025 08:40:53 +0100
Message-ID: <97107163-de68-45dc-9462-c4f7cae06e31@gmx.de>
Date: Mon, 13 Jan 2025 08:40:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bootstd: Probe bootmeth devices for bootmeths env var
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250112034213.13153-1-semen.protsenko@linaro.org>
 <20250112034213.13153-3-semen.protsenko@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250112034213.13153-3-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rTikuoxv7t3k/QJBawCZv789a5CwEYnQmZ9Eshe3Lg1NpQDExJj
 VieJHPj6jbYxfsZxw7q8KeSkGOAU2UKNnSwyKzrobM9BHYNfZW5oO4/Lw1yB2t8qP/Z4qql
 aQWriR42QKL26sT4+bG0bPQppQfkGO80YClQxlNfj7SMOOsMYzcTKQrufXIxsjHzwyttpOJ
 2vihpxyy84g3QEcWHyh5A==
UI-OutboundReport: notjunk:1;M01:P0:ZWGlnlsA4Yw=;kRPfh9ypUp4t8GXN7EjUVL4biBU
 ROiFZ+R2sZp3Y5W9xHwEMisgCYRf8tkudha+zHt0zUiAs5uBMAG3MgBXZvcvxRm6AjFbyW7CM
 nB04y+X9LFc1fA39aC9hEo4XJRY5FgTEItxL9wOR+GYdPOFc6258tJ8OQhTxEV6PxP1E2Lp+m
 42KP0el+jnOZ2lN2Ze5yms9Rbk26H82JG8fZOD98aw1Dk5BZLQULlO8S5ib+u3zHalOAhRf/D
 BoL4NwNWaY+3ZTqKdaqCXwxkCvjmi0TbF0RrMtrH6H9K/DO+kIbtb6CRy54UAt5fqRxwV2tQa
 0xKHim9VxmRpzWBwelA4HF2GOk8b2j2qAktK4Ed8pgG62YaDlmV3IrW3R0TGYL+5YA3EZJXnO
 viEb1JUB8MC95Z/oYx50vAlHkMBB3YY0W6hu/ZmXMTUKMmVN3BzP+cyjVidWPnvWAFJsc5Pz5
 uQ3HUvJRrQeYrHKYZQXylht5Jd2hXND3xNfgKw7g4/Ywmb9/qO0TZf+W5WqJgdHkiMCAvY8eo
 jnLihBjan4RaSv9AtvRByt4AK7+8XmOJn9oHjc/lEuBfrIhxJq4iURqE/1Jq0CYs6OWjHitm5
 J908K5Bz+nndgTcRNWqF0GZMRbbL+KwiwTdozOqiT7srpZOSrB8owI5gf4CCiv5VRAwWSL+yp
 J/iATgwzVChkwJ3u1Wtn5pL/rEqGcaoOotFoqex0VcXcQ4D0kDSFZMunLBb63QVqUPrKCM5Kq
 q6v07gmW0IMbjwx5Lz4JKPF9ukawQp8zhc47TgQydSTfPXmXvadp+bIWcl+Ku3W50WCcEm+p8
 +87QS9HSt15tuSMq0vVmFdG46e5Rci5ZAfKjMZ2eLu/rLKaakaMq4Hli6RSRAaMi8viOnzpxt
 /GD6Yp60RiqfA9NqCdsGPIZgtgXG6iAp3gni01YO0T55SUZ+KRxSWia5Ii8Hsubvpse9LMFqH
 kvNvRsUcnN2Ow7g4waiMotuDKdsIJ6G5+CcFM1TnfGN/srqvWApOhU+2tlVbEeSZLy+krvu65
 CuGBd9X0H6XuN/31UrFDHyT1ZQN6S54D/8Hi62eIBpe0/1xHu5Wx+ARhLBEW5T8Qaa5JImAdU
 GlbRUruVJl+wxFQGfTLYbK1y5JeF0g
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

On 1/12/25 04:42, Sam Protsenko wrote:
> Specifying efi_mgr in 'bootmeths' environment variable leads to NULL
> pointer dereference when 'bootflow scan' is executed, with call trace
> like this:
>
>      priv->fake_dev // NULL pointer dereference
>      .read_bootflow =3D efi_mgr_read_bootflow()
>      bootmeth_get_bootflow()
>      bootflow_check()
>      bootflow_scan_first()
>      do_bootflow_scan()
>      'bootflow scan -l'
>
> That happens because in case when 'bootmeths' env var is defined the
> bootmeth_efi_mgr driver is not probed, and the memory for its private
> data isn't allocated by .priv_auto. In case when 'bootmeths' env var is
> not defined, the std->bootmeth_count is 0, and the execution flow in
> bootmeth_setup_iter_order() takes "no ordering" path, which in turn runs
> uclass_get_device_by_seq() -> ... -> device_probe(), so issue isn't
> present there. But when 'bootmeths' is defined and contains efi_mgr, the
> std->bootmeth_count > 0, so bootmeth_setup_iter_order() follows the "we
> have an ordering" path, where devices are not probed. In other words:
>
>      'bootmeths' defined           'bootmeths' not defined
>      --------------------------------------------------------
>      priv =3D=3D NULL                    priv !=3D NULL
>           ^                                ^
>           |                        device_alloc_priv()
>       no probe                     device_of_to_plat()
>           ^                        device_probe()
>           |                        uclass_get_device_tail()
>      dev =3D order[i]                uclass_get_device_by_seq()
>           ^                                ^
>           | have an ordering               | no ordering
>           +----------------+---------------+
>                            |
>               bootmeth_setup_iter_order()
>               bootflow_scan_first()
>               do_bootflow_scan()
>
> Add an explicit device_probe() call in "we have an ordering" case to fix
> the issue.
>
> Fixes: c627cfc14c08 ("bootstd: Allow scanning for global bootmeths separ=
ately")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>   boot/bootmeth-uclass.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
> index ff36da78d5a1..049389403191 100644
> --- a/boot/bootmeth-uclass.c
> +++ b/boot/bootmeth-uclass.c
> @@ -11,6 +11,7 @@
>   #include <bootmeth.h>
>   #include <bootstd.h>
>   #include <dm.h>
> +#include <dm/device-internal.h>
>   #include <env_internal.h>
>   #include <fs.h>
>   #include <malloc.h>
> @@ -146,6 +147,12 @@ int bootmeth_setup_iter_order(struct bootflow_iter =
*iter, bool include_global)
>   				struct bootmeth_uc_plat *ucp;
>   				bool is_global;
>
> +				ret =3D device_probe(dev);
> +				if (ret) {
> +					ret =3D log_msg_ret("probe", ret);
> +					goto err_order;
> +				}

This would mean that we fail boot if probing one of the boot devices
fails. Shouldn't we remove the device from the order instead?

Best regards

Heinrich

> +
>   				ucp =3D dev_get_uclass_plat(dev);
>   				is_global =3D ucp->flags &
>   					BOOTMETHF_GLOBAL;

