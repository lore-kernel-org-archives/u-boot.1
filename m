Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AC2C44506
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 18:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43AE984B73;
	Thu,  9 Jul 2026 20:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kIQFo+5c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17CED84BF6; Thu,  9 Jul 2026 20:38:31 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2D9584A78
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 20:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6974a6e54dbso181176a12.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 11:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783622308; cv=none;
 d=google.com; s=arc-20260327;
 b=NT3D7196mb8zFJEzxPkSTfBrIJ7Ee12w1gCHwM2UqZJxE8TyIpHhRZw4O5Lfs69+C/
 e3DvEmXiaUi06n2fwW8e8AQiiWzKUqvJqpUZvjJ8tKtJgSj5ypwgz/DWqENyzHTbw5nX
 5kWSlqlA8XJf1NPL8wM6bImmNa+H/wBuiXI9W/lTD7Z2ndxjcbwEdONlU7l5E9ioEt0k
 yWprckKShb5XDcKHCNhMdt51Q98dCI0jUuHneQ0Ai6XRIz5TXzSte0sZPNfsvNfvNvoa
 QbJLvOHSOIBTa32SNiqNewGkq/8ZOMIxnuTE2FXHCQJqvm0LthRM8lBKJX8QeYbgm+2F
 v82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Yw+aHnjMhmoAa9Gl6Vm/OcpsdOsIjjg3mNNRGo6NQC4=;
 fh=H63b4aTsUkkyP0A1mpkDJp2D8BvQ6Kq6vx11stwyLJc=;
 b=CYB3ARWLUrvU6taihaBeGoW0V/cNDjIWhDkIa8yN7UgFDteREutXQ+bUcmhtQdbQ16
 mKfuN6KNBGgH7oXwz0b4qUFDRghRmKm1ZxjQcD+ihN+BX5durUlwc9Gpt63RNMkycnk4
 6kgIxhhAO8ncBSDMxi1ZM+ZW6/ZYYbXSkf8DletykgeHTHGKudu4AuRUlbz8VyaH3poD
 TFB+aCj35yxncd0G3gLfHAZNWdVKm/bnSvq416NC77RwMuVvpf59Vs1J5uV8EzBER9ym
 SE4+0di6iz5BlmQVAtyMoQ1rkD3LYrVNruD3o3qP7fSW9nbQNlv1VUkoXNByAKVizk7t
 jb/Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783622308; x=1784227108; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Yw+aHnjMhmoAa9Gl6Vm/OcpsdOsIjjg3mNNRGo6NQC4=;
 b=kIQFo+5cuXRqPFeRsI1ez9DWNnagcWpPxuLEo3EjHuvcmcTlSphzHSAMnH4fsAobjm
 Hvk3kBDKU8ImXeTmT2JvDp80mCxtBY2/LhsXV6h3vENpjax5jgf6Cr07eMiSVcIjHjGM
 JUhf0MxKiP1A7NMXEYJGeLazQrmf1c1Fr3V28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622308; x=1784227108;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Yw+aHnjMhmoAa9Gl6Vm/OcpsdOsIjjg3mNNRGo6NQC4=;
 b=LyXgrO57aNhzyHFKURYUr/W6xKHoyAY+/COjvLAwbqAO7F1Fct8/+fdMrUoyNz+EXF
 R/MU1uwTpQNr2EelwxA6R9vo5dAB7Nbi3q4BN/7jZYyaQvJLrpnyb4Y5G8LB5gcCl+j/
 DRoYeh7BDwSSgXFpcTL04xab6RnM6R0trcl3JVkhMAoAkeaoNHhKlMgExQ/hyMHYdJaQ
 Rqdhe18SZsqN9cYLkB+BrnOCabjv7XGTeaH2eVEpg8+0B2lVrTzT5CbYnbNFu18MpX2Y
 e+MJjSSslyWRrnVgUKrZZxDKUJnl2GIJ0QTnjuNqf3pDin6TfzoDkpxp91t3BQ1HWegI
 a0FA==
X-Gm-Message-State: AOJu0YwZ73T/eQFnouLrB7hThgWgfALVvmxUzRA/jf0gI4drGRt8HWWF
 i9JI9Ya2VqHxKlHqih0WXR7WMEjv6crnp7g5wmQjmmTH8OHNn71OeA+++AgN5zw/GQorbVHOBFF
 pMjRWOBtY/+OGZSG+DJH34k0Scc/TSRmIhJiBQ1QKMu9wRMlQWxsBsw==
X-Gm-Gg: AfdE7clFO4VL32CJk7Zg2U+fjQVg1AGY2tLkhIBrJJnqNLPjk+Fxwau0zbPDuwRhdZI
 nQII4/wMD2q/cnQ1QxhJ9N3sIChqyZMVm3dHBGZTtGR93mi/nWPoxlh+bUIUkiyOeejXSIXzMRU
 PZeOAclTItSk4SOGoMXAou0xZHaLxZORAF0eS39X9kOWOB8DpQoRTbY52nrVLqAdP9BgkvYf8yZ
 LoDepGktELfTMuWhC2BqioFVRkeV8mieBaErm8HSl9qYGJ+wkhHEbrrCRUKM7h7eo6VCWb1oLae
 LFLaUw==
X-Received: by 2002:a05:6402:2b99:b0:698:99be:29d6 with SMTP id
 4fb4d7f45d1cf-69ab44a96bfmr3473864a12.29.1783622308219; Thu, 09 Jul 2026
 11:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <CA+DkFDb-nAaiECtYX-QcX4-iW6hQPxRtYt_EeKOhDzznqR2ofQ@mail.gmail.com>
In-Reply-To: <CA+DkFDb-nAaiECtYX-QcX4-iW6hQPxRtYt_EeKOhDzznqR2ofQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 12:38:14 -0600
X-Gm-Features: AUfX_mxGBaXvBwYQsxkFu4lWdRTmOG7R7wxHGmie2jgYa5JtLa3QEsVuXrBVBcQ
Message-ID: <CAFLszThPV2jG0a4OkKzdeAQ53Vgu5co82Htt6XMhTQmyhOZnpQ@mail.gmail.com>
Subject: Re: DRA821 Firmware Update: A/B boot and dynamic SPL payload selection
To: Patryk <pbiel7@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Patryk,

On Thu, 2 Jul 2026 at 10:43, Patryk <pbiel7@gmail.com> wrote:
>
> Hi
> I've been exploring the possibility of firmware update on the DRA821
> platform and have a few questions regarding the solution that came to
> my mind.
> I target both SD and eMMC storage but SD is rather for development
> purposes although extensively used so it should work as similar as
> possible to prod solution. I need to update as much as possible with
> possible rollback in case of boot failures.
>
> For those not familiar with this SoC the boot flow is roughly (let's
> skip details) something like this:
> - bootROM loads tiboot3 (that contains spl) on R5 core
> - spl loads tispl.bin (that contains BL31, BL32, A72 SPL) on A72 core
> - A72 SPL loads u-boot.img with u-boot proper
> - u-boot proper loads kernel
>
> So my initial idea is to
> - store tiboot3.bin on boot0/boot1 eMMC boot hw partition
> - store tispl.bin, uboot.img, fitImage (with kernel) on boot-a /
> boot-b UDA partitions
> - put all the logic of slot selection in R5 SPL
>
> So R5 SPL once loaded by bootROM, would use some sort of metadata
> (let's assume some env variables for now, btw any better idea?), to
> decide what slot to boot, then based on this information would load
> tispl.bin. In the next phase A72 SPL would basically do the same for
> the u-boot.img, and finally u-boot proper would load appropriate
> fitImage. In general the selected slot index would be propagated to
> each stage so each stage knows what slot to boot.
>
> R5 SPL would also handle possible rollback by using some sort of boot
> counter (e.g. stored in backup registers of SoC).
>
> tiboot3.bin would also be updatable but I would update it only for
> some special reasons - in this case I would just switch boot0 ->
> boot1, or boot1 -> boot0. This case would require special care because
> if an update failed, there would be no automatic rollback and users
> would be forced to use backup boot mode.
>
> In theory and from my perspective it looks good, however I've stumbled
> upon some problems.
> First - there is no possibility to use a board specific function to
> select the boot partition. Currently SPL iterates over a list of
> partitions and selects first bootable - more about this in
> spl_mmc.c/spl_mmc_do_fs_boot() - would it be sensible to add here a
> board specific weak function that would select the appropriate
> partition to boot? If so - would it be welcome also in the mainline or
> rather not?  CONFIG_SYS_MMCSD_FS_BOOT_PARTITION is obviously not the
> case because the partition has to be selected dynamically.
>
> Second - some SoCs do not support GPT partitioning schemes, and when
> more partitions are required for various reasons there is no simple
> way to provide separate partitions for boot slots (e.g. boot-a,
> boot-b, root-a, root-b, data). In this case one could potentially use
> single boot partition and use e.g. boot/tispl-a.bin / tispl-b.bin for
> "slot" selection, but this is the same story as in case of partition
> selection - the name of payload is hardcoded in config - would it make
> sense to also support dynamic payload selection?
>
> I would be grateful for any suggestion, especially if the solution I
> outlined above does not completely make sense.
> Just for the record - I come from another SoC where the first external
> bootloader was implemented in TF-A (BL2) which has a well-defined boot
> slot selection through PSA firmware update - that's why I try to
> figure out something similar on DRA821 SoC.

You could take a look at VBE[1], which implements A-B boot, storing
each slot as a FIT at a raw offset on the MMC (does not support
partitions at present).

So far I have only tried enabling it for rk3399, although I've never
quite been able to get the rockchip-specific changes into mainline. I
do have a Play board so could try implementing it on that, if it is
similar enough to your situation?

Regards,
Simon

[1] https://docs.u-boot-project.org/en/latest/develop/vbe.html
