Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B567C4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02E2A84E31;
	Fri, 17 Jul 2026 15:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J1lTb9/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C83884DAA; Fri, 17 Jul 2026 15:44:27 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDE9784E31
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c15ba3a2b4bso953126066b.1
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 06:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784295864; cv=none;
 d=google.com; s=arc-20260327;
 b=o791Rf/tQlV9VXljSQGhA/SuP1zoX5FE5/aV4vpF6MbWNnhpsxmNfU+3OiVlUcr3CC
 /2nFLMoe7uY1DLsaEmDgwDkrCvY7qA0LlgTX2088/XXtBuwMbJ4srl3qBYxyfNMQ1+US
 vAjKOs1A1RBtxzEIVIa4J/4W6a/fmxnyNQJ3TYoPkpdHKlilhF/pxaqPd7tnZ2MC2h3D
 k8noEP+wMiwKSBjz6WcXWwIHooQP2OmlzZae6RY+cFYfb3SeIQsIqtA1yExCTKzLRqUR
 4OB0kB3xeWuECCSU9LQWzDMK9SH6GVFfjSdMxt+f0QycQJ/OVN+KkxJGtfTNTrfCGN9q
 Ktxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lUHoWUv2ZrYQM5dqGPwE6wwj4ganTURxw3m8CMKE/sM=;
 fh=QrZuJZBe+8mh2uKODcFlCJG96uGzFpowMhT1/LeHYRM=;
 b=LMfx2luL55pG7EN5jTGyl4kaioKn6E30DCyU7mSZYjcxb/WXrruidf5wx8tT/c105d
 5iXAtLsXh+dQu5pFXea53WRmhLA0VLfwO1v/NFgymQS5qgjZ7xPdQ0W/yWW5TnnJfeTs
 JHbd51UqnkOeRB3M+zXm+N9lv24bvd7O1vwZhRCGEZQ0kH6qCl78W8lg/K4nvnqKh9Xi
 z3Cb28UuwUrNltZ5j/ksVv7A+YmRY5QT5dek7+8//lptdzE4nDT4ggVGMzfKKxTF+fNU
 tMN8ea27AHejOKWPGwL0rPkeAr3HuXo4xtmsq1zAok81v/LgB+Kdo8yIGBok4Hwo7a2A
 ZAow==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784295864; x=1784900664; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lUHoWUv2ZrYQM5dqGPwE6wwj4ganTURxw3m8CMKE/sM=;
 b=J1lTb9/RLR4z7ylA698sZGJzjIEDREq3sq+IADGMzG5BSbjsyxvOCqoZ5NcQPt56n+
 P18hb7jBoTRfoZiCMEvf5X0cWR4heT+jIZuu8+tTHeuw/OeFNXn87JEhPQbTwtc32Shd
 Sz7JCS1KececkgGR7eYrp6zePxel2bU9KyTT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784295864; x=1784900664;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lUHoWUv2ZrYQM5dqGPwE6wwj4ganTURxw3m8CMKE/sM=;
 b=ZgezZErWKzIrj8N3lTfJ5CWWAI8Zo2SOL+XBIzg/oIumEbx/xwnCJxK92cKNsMqOVM
 cYwYsRs81pCbeFUHkROiacjYuIHjBv6uOF1s01+7Zv+JX/HgZ4ohQysYuT/ZsZizB9/j
 jU/icrtWhMkkN4MikBS82OkD7z/DdDArhvTUWN6QnFseV/9kv6lP51teTEXPcqSBtEtN
 Xdf+iNbr0PjPA7hMtblUeoBMtb0p0/ZFj35okjWSWrvKVCTmr3Xe/nm31TRNhBpJn1F6
 Kn1nCbg953JkOZOeQE3jeH/NYI0sJ2+LX7qQC2gITy1eAO5lNtPrdmns3YFKWmNXmH+b
 WKbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9LyRyqYIMhhR7ElkVELIcOJvnQ4Rpk6ZKVN7Xz2fpOrXp4pGve/tk092oTo1dvyksF5qRAYo=@lists.denx.de
X-Gm-Message-State: AOJu0YwUlkutaG0EFt+3g69awQGZSu9otTpYUNF4k4isr1t7J2pEClbc
 Dh1/ZxXw3cMaCrGPtHIMXDeDQmgMWrvVQKm305mI23Dhr7EdSnyaXQFl58mer7L7E4NjjoUP/gE
 Zw0DjwM5r2uGacr++dpBSz6ITin/uJpjEhm1l6DeJ
X-Gm-Gg: AfdE7clS10wlp2ljJ8L3umkMvmEqkrughhIReNkeZZ9mj7E+k3PYBWsz3Lb3wVKAxPm
 nGzcfJpOfStyCpuydrJa8KLVY0PMSmT5WMHLs96GIRYE96cOs0JM0amBR5wWkH3nsvjPwU8BEX3
 swW/LzVGHO3HUK3IWWqY26RubfOeETmLkayepsSSErknezpiPCaHKKrqiiVvntiGzxEeJ59J9s1
 Yl3nOskMf6b3HkbrKLCL5n95lyWMP9QHfOvUP3nV+wFGMMwqEmsQ1Ui+acisdTpjj14Njs=
X-Received: by 2002:a17:907:8dc3:b0:c0e:883e:93fd with SMTP id
 a640c23a62f3a-c16b47bb1f3mr124709966b.48.1784295863946; Fri, 17 Jul 2026
 06:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260711160808.2022242-1-jonas@kwiboo.se>
 <20260711160808.2022242-5-jonas@kwiboo.se>
In-Reply-To: <20260711160808.2022242-5-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jul 2026 07:44:10 -0600
X-Gm-Features: AUfX_mz9XsVWz3gRkvyPQ2sWwQDgfIkDRfsHyUTWhMl2BcvMV1MQYyxUtIbBF50
Message-ID: <CAFLszTh7uPheLfpAROsj5Sr=LO8Q_X1KGzXmwitB0Qmjj1n8Ow@mail.gmail.com>
Subject: Re: [PATCH 4/8] usb: Extract usb_select_configuration_no() helper
To: jonas@kwiboo.se
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
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

Hi Jonas,

On 2026-07-11T16:07:58, Jonas Karlman <jonas@kwiboo.se> wrote:
> usb: Extract usb_select_configuration_no() helper
>
> U-Boot only has support for one configuration for devices.
>
> Extract handing of selecting active configuration to a helper function
> to make it easier for drivers to select a different configuration.
>
> This include a small change in behavior, errors from parsing config
> descriptors are no longer ignored and is instead returned.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
> common/usb.c  | 59 +++++++++++++++++++++++++++++++++++------------------------
>  include/usb.h | 10 ++++++++++
>  2 files changed, 45 insertions(+), 24 deletions(-)

> Extract handing of selecting active configuration to a helper function
> to make it easier for drivers to select a different configuration.

>
> This include a small change in behavior, errors from parsing config
> descriptors are no longer ignored and is instead returned.

Typos: 'handing' should be 'handling', 'This include' should be 'This
includes' and 'is instead returned' should be 'are instead returned'.

> diff --git a/common/usb.c b/common/usb.c
> @@ -1149,11 +1149,38 @@ static int usb_device_is_ignored(u16 id_vendor, u16 id_product)
> +     usb_set_maxpacket(dev);
> +
> +     return usb_set_configuration(dev, dev->config.desc.bConfigurationValue);
> +}

The mdelay(10) after Set Configuration stays in usb_select_config(),
with a comment saying some devices need time to process the request.
When the CDC ECM/NCM drivers in patches 5-6 call this helper to switch
configuration during probe, they do not get that delay. I suspect the
mdelay(10) should move into this helper so that every Set Configuration
request gets the same treatment. What do you think?

> diff --git a/common/usb.c b/common/usb.c
> @@ -1193,34 +1220,18 @@ int usb_select_config(struct usb_device *dev)
> +     err = usb_select_configuration_no(dev, 0);
>       if (err < 0) {
> -             printf("failed to set default configuration " \
> -                     "len %d, status %lX\n", dev->act_len, dev->status);
> +             printf("failed to select default configuration " \
> +                     "len %d, status %lX, " \
> +                     "skipping device %04x:%04x\n",

This message now covers several failure modes (descriptor-length read,
-ENOMEM, config parse, set configuration), but 'len' and 'status' are
only meaningful for the last of these - for the others they are stale
values from an earlier transfer. Perhaps print err as well, or drop the
len/status part, so the output is not misleading.

> diff --git a/include/usb.h b/include/usb.h
> @@ -900,6 +900,16 @@ int usb_scan_device(struct udevice *parent, int port,
> + * @dev:     Device to select configuration
> + * @cfgno:   Configuration number to set
> + */
> +int usb_select_configuration_no(struct usb_device *dev, int cfgno);

Please can you add a 'Return: 0 if OK, -ve on error' line, as with
usb_scan_device() above? It would also help to state that @cfgno is the
zero-based configuration index (as passed to usb_get_configuration_no())
rather than a bConfigurationValue, since the two are easily confused.

Regards,
Simon
