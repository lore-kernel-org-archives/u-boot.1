Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1139CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 14:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CC9F848D7;
	Mon,  1 Jun 2026 16:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gdSqU1el";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00846848FD; Mon,  1 Jun 2026 16:58:21 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D090848BB
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 16:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bed2195323cso163792666b.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 07:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780325898; cv=none;
 d=google.com; s=arc-20240605;
 b=J1jXKaK+XysaNe/ZYaoVJ/zIFkbYFUrU7/0n35OrHLQviUgf9vh95In32lfwM7Q13O
 N6LBr1o6zeyfXxnwzsmTZdhhnAVjHLT6ERzl1QHkD0DrNBtlULQZXwELxehI+7b1+BUN
 1ZSMMjpFq4lSncw6X7zMvDRjjgD6PTjuqVhqM3P1CbmnvYeYox1hSArT6Cx06JmRDKDB
 ZPU0FKAMp89AqNYF6gzlBMxjTRWGBOkN7GgGyZT1XlWYZHZrf2t80DJBmPN/BaykCClE
 zgKoyG2kzYsWoH7SSvE2ZMJIBJVurXIl5TL9MDeHMvoufJloJxUHnURQtn3aaraIETLh
 CaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=duSDNrQTnOewXTgn6RvyrEdAQOKtWRYatWVTShriMQc=;
 fh=aCaOJZgkkxSl3kG1DMjk4JErljQ5rHgaDbhrsapChVo=;
 b=Bw36up59yfY+6dWd7JFp461iMyXoXJPzxTYKiLbiEwVj9LoiYVrmESGxdD677Zs6ZP
 FNfhwOe4OV5XfyBzUpG22nIFm5Lmjh7F/VS3wvlvs6nD14b91p9gY2Vbs8n8MwgPqZDb
 REm6x3Jp5v6DSv3HTxn9RkJN1whyEyUthPbt0pBGTpKTKAs86Vw2y8k17TDAavFQAsxn
 D8ZAJYFeIcp3TMLsnjisZW65NhzqqDRIklt8bKpmPcYi7J5jvjbmtU/qzPQm2JcK2a3a
 kje7fHpfeTw7CmaiaNhgiU4lPVvhrBsrz7HADioI6Z537UHiy9C3VuOPQqlzrqyji4bR
 nygA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780325898; x=1780930698; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=duSDNrQTnOewXTgn6RvyrEdAQOKtWRYatWVTShriMQc=;
 b=gdSqU1elYyHgFzJISklKwyhhhEGXDAdqjiQtoM0JLukZVxx+r07gKP12DszUjkcfc+
 9XbeJ7loR8u9/D86qG4Hu5CeUDU7fQ4vRCkPt9i5nTezZGklXI2o2gwY6OMsaWDg5bg5
 GsRhSJDGc/QfKNJJf84/vZ3Ilf1K3whXKUXyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780325898; x=1780930698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=duSDNrQTnOewXTgn6RvyrEdAQOKtWRYatWVTShriMQc=;
 b=fTJNPmV+M3UolKzjZR/KRKFx/SFParDTVN0tl8iptW6Wt2bnU0mPigyvW9+u34WXjO
 ddEVcNep2axu1MujqyM1oKHTCoyeZeDe1Cbhic7aPnlv6JTeZpuyS9wC7dzQBIOfDnGu
 LZix6qm1rvMhFz9/9MNWkQGnC/Gxk0LuQMDlzPWzgSp/B2Jes8PmyedtVS2YC7uoJHfI
 +sLvf2+3PKlLHH0H2ZHs08DbyMmzUMvwgHA0qW0o0bhzU2pdX9Jv6fAdkFoyQQLe8UtT
 PJ3lrTLLFhphoxq9XgJlVvQSUqud8NHyhQQIN1FkM1h09lsb//yn46+N8BBTg+CHoGrX
 Okmw==
X-Gm-Message-State: AOJu0YyhaItFH3l6TIlTHGLTANDf8LrAAfAvAh99CfStFCDuyIsO1py2
 DpPfm7mnQubnr8E4L9hS2xNL2NefP983wxVplNLgVT0XSvSzkjPubqStVVUZePD7puno3AuqLE8
 hmxav5ZAisKlgny9iD979MsCA2sB+dMxO40h/F3Ke
X-Gm-Gg: Acq92OHLN/U32c8URnvp5/GpK/3vX5q51o4b/csUV+/HskJPC+c7RI0zudSDR94Wpy/
 YGYhyFLuK0TMqEwDP0l+vIq71KKrTH0WLVu9tqMbLEMUGfTTaVvJPjjT2Sb2NS2t83BM9eWWTo8
 AqnKH901npuH2lkqrURbOsxFUY7zMWx8H25+rsBi6ktwwFiaTEbnikh1mCSqXzXUnQCf7kdJxTk
 ob7aDxSoXMJRVTuwFE00A2Duc7jskqli1jh3VxvlGN3Y7VgnNySep/j7fMiZpv+dyKpRQr6JPty
 3LWepfL/aQPoBNsJ
X-Received: by 2002:a17:906:5a49:b0:bec:4a86:938d with SMTP id
 a640c23a62f3a-bec4a869908mr271533666b.0.1780325898427; Mon, 01 Jun 2026
 07:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260526-devfdt-usb-v1-0-a4e22b23bfae@nxp.com>
 <20260526-devfdt-usb-v1-2-a4e22b23bfae@nxp.com>
In-Reply-To: <20260526-devfdt-usb-v1-2-a4e22b23bfae@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 08:58:06 -0600
X-Gm-Features: AVHnY4LskMpP1gaF9svOwVjGIR9rHeuikAbIKpZjTeHD4PgnjKSgFOO5JnLGpg4
Message-ID: <CAFLszTjJOtXbU_ya4GuC3_jyOYKhadOA0xLUc-n1d=N2SubErw@mail.gmail.com>
Subject: Re: [PATCH 2/6] usb: musb-new: Use ofnode and dev APIs
To: peng.fan@oss.nxp.com
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Peng Fan <peng.fan@nxp.com>
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

Hi Peng,

On 2026-05-26T09:09:56, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> usb: musb-new: Use ofnode and dev APIs
>
> Convert the TI MUSB driver to use dev and ofnode-based device tree APIs
> instead of legacy FDT interfaces.
>
> Replace dev_of_offset(), fdt_get_alias(), fdtdec_get_int(), and related
> helpers with their ofnode equivalents such as
> dev_ofnode(), ofnode_get_aliases_node(), ofnode_equal(), and
> dev_read_s32_default().
>
> The USB index lookup is updated to compare ofnode handles instead of device
> tree path strings. Also remove direct dependency on gd->fdt_blob.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/usb/musb-new/ti-musb.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)

> diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
> @@ -51,29 +51,25 @@ static void ti_musb_set_phy_power(struct udevice *dev, u8 on)
> -static int ti_musb_get_usb_index(int node)
> +static int ti_musb_get_usb_index(ofnode node)
>  {
> -     const void *fdt = gd->fdt_blob;
>       int i = 0;
> -     char path[64];
> -     const char *alias_path;
> +     ofnode alias_path;
>       char alias[16];

Please rename alias_path to alias_node since it is no longer a path string.

> diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
> @@ -51,29 +51,25 @@ static void ti_musb_set_phy_power(struct udevice *dev, u8 on)
>               i++;
> -     } while (alias_path);
> +     } while (ofnode_valid(alias_path));

This trailing check has always been dead - alias_path is guaranteed
valid here (we returned -ENOENT above otherwise) and the loop only
exits via the inner returns. Since you are touching this function,
please convert it to while (1) so the control flow is obvious.

> diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
> @@ -81,15 +77,16 @@ static int ti_musb_get_usb_index(int node)
> -     plat->base = devfdt_get_addr_index_ptr(dev, 1);
> +     plat->base = dev_read_addr_index_ptr(dev, 1);
> +     if (!plat->base)
> +             return -EINVAL;

The added NULL check is a real behaviour change. Previously a missing
reg[1] would silently leave plat->base as NULL and the driver would
carry on. Please mention this in the commit message.

> diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
> @@ -51,29 +51,25 @@ static void ti_musb_set_phy_power(struct udevice *dev, u8 on)
> -     const void *fdt = gd->fdt_blob;
>       int i = 0;

The last reference to gd in the file is gone (yay!), so
DECLARE_GLOBAL_DATA_PTR on line 23 and the #include
<asm/global_data.h> are now unused. Please drop them.

Regards,
Simon
