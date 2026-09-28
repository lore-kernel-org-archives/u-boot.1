Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DF0CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2D1940550;
	Mon, 28 Sep 2026 15:12:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 168twnmX5FET; Mon, 28 Sep 2026 15:12:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 25AF4404F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608358;
	b=R33QLDGvIxjlLu9GEmy/HeCTcFq2wu54g+FUgYxCZfzTSrgJr1cAa3+awravyeR8Uctx
	 MAwGKt1Zfianzk977QEc9C3SznDmazJB9SHEE0TdNQoKUOFXwAKmd46Y2eT82Gm6A+8iH
	 FbD0NLJMpfJqWvO34XutGPMW9bME+QIpy380qCtg+PMBSfiU+OmO2IAPTyzPGtNVP230A
	 vOUApsU5TV8Qln4A3FgCcr6bEz3p3PJU8iO4+2Q1flRmuLLCfijOfibs42vSN+09D05wt
	 LQFlyBnuOi6mYP0N8sudofHN2Bl64Q9QKNBdKkxPHdqT7g2CZWM5V3AaKXIpZ7AMr8A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608358;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=T9WE522pzcG9RBfc+Qp33catMrHKVWd+nXZGK7+/B78=;
	b=EuPVS0YGtUfWGdfz+jiL3wnimEZzrMKlUgvOIneqkKXAevnSnIrHEakV3ADltUdC88rP
	 RFw0lTiBoRk4h6XPc4DzKRKkFzu3AIAUm11MQnTKHqPcRORGHCNMW7edpNVUzOzqagC1h
	 qdPzGl2Kyo/SJuWZcjgaBpLmaw/I4mgQqahmQV2VBPjlKsgV+EOsmpyvwfAMKsTEiEiJu
	 FJVY7RP5nlkP7PACUM7uj4Oy9880DTeJWuBAjse+BR+teDyFE1s5WVNaI25qtohl118rJ
	 J33rGvlZHnyOqpwuIYkahP/v1drZCrA7KFJyDcK8A2nTZbEp7d5gzAl4URLfUf9j3vA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HpOmJKoR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608358;
	bh=T9WE522pzcG9RBfc+Qp33catMrHKVWd+nXZGK7+/B78=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F04bMxMXGfyt5vhBmqBYr2HyjlI8ZhD6K4IcFMlGtqHBMuf/xYkNRBPmJKOnjj0nQ
	 oB11deQ1f9RsDe1RkzHT907mmE1SRAu4L4z/5ks2cdTcYae+zIn2XTShnQXkenQsBH
	 /QQO4cLycPtoYbq5xySPK5Q+Oe+sQTrfEkJVstpY2qG1aoz2f86IQh50JHGS18ixC5
	 8PCbsY70y52cBhRBUCc/vuU37dLYE3ExDR+5aHj5mKzjAVLl9B/JvOP0iJPoLX4lQL
	 82NiJyu/JrpeCmszyxm1ycHLqrw3fv6gag4CzcKAVAxz9O9KT3nDprnlUAKLv+vH+0
	 dPde/7uK2e6CQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25AF4404F9;
	Mon, 28 Sep 2026 15:12:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EDA8D1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60D7F404EE
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d8Jp08NVCHBz for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:12:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5AB5440430
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608355;
 b=gTAAdGqh5K00QEQU/9cYfWIEcV9QNgIz8/GwNeYwXM9RFD351Cxgg12C5+OuX+n90Jlo
 Iekj6SheG2/p7QPWN9UXo7+T736/fSvxLeumF9NfTGvOQRijJaTfe268elvJtXjSzopgb
 L935M0VnhKexzTCD71JZSkHDbqpJm4qWepik22uiB7QeHYscIFubzUxw+NvhGqPvSNYSC
 eVDePhtjP4FEobWcU5RP/MWb39hWpGRxIcP5J8inXHSH1L2Wj9c6x3JNO0kmKRrxZxW+X
 QllONtK4Rk8odkAgJbN+eSSt5+2D0wo0uPQwweX0/ZwVSm9E5N1ojTVMHOpRvF4uQdA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608355;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=T9WE522pzcG9RBfc+Qp33catMrHKVWd+nXZGK7+/B78=;
 b=RgE74RiWwHusht1rOtamh6Y2OUksT9JV6QRy3HGiG/YnfgY/li5EZCZv1BeRvw8CEv0y
 bFtPNkF1r4wikyIJRghHIdDqP5xFTINdpnm5hfDqFad5Zzc1cn6m56MunVZDEMIdpa7xg
 gJjsUy1oiG8mXSzDA2aIOprlXrs0F1+vyLBbS7eKPbeUEEOAYVUVfnEH4YwGjp8ykbFua
 38QZcYywh3tHOB5wholjRvVLo4Gd7s7qPPFLk5wC2J32adJn1nGahFcH2PRP7xVWYCYK6
 Q1ipuLBLwkOFu2ZTSWpey+VVYal6skXjX3z9l4/78D8jNofl09JBIOH3x5EqIT8vFzQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=HpOmJKoR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=HpOmJKoR
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5AB5440430
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:12:34 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a9984f9adcso5349952a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608353; cv=none;
 d=google.com; s=arc-20260327;
 b=OgTzJqlD3HqSgEav7jxrn9OugqLvhUBaDqVgHAaw2Bi1SNITE6x6LwCmmAwdyM2i0g
 RceQYWBJxh0toFXQ57xPLDrwsasQoEN6lvOWvDCPd0aM4u5mTOFuU3vsoz9S7fbWf4xB
 JbjZ0thZWkgujkz4QGMSTfzzKRelCkdx57ARV2XNgR620NH5Zp1JV2rZQzoA53M3gqyc
 kHx7y+Vis7ITXFxQV/O0eAuRsMUhw2HjD4eG667ayB293jcR5QXqFJYKzHuS33t/mwQ0
 o4qER2k/tw/dWp2rM73QmgwzwMDnMNqQy24xmcAfg6pSH/BR4h/XWv5IvFBs/Z5qeQyg
 VCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T9WE522pzcG9RBfc+Qp33catMrHKVWd+nXZGK7+/B78=;
 fh=N0R5uArh1zzb/dpDBG3eoWSW979Y2B/M58pRDPw00ak=;
 b=IEmpPRSpMebW4qNDXx7u4A3lpzKgk6Ee7scIAuWh9Gw1yhjFQeDj8hWb0kptsAdovV
 G7QLg2snXBZ0Tk5hdYmlPWee3fC7eu5+cmw4DYQ+83axIj2TMIhQ7Cy5hQ9Jf+klM7QY
 HYvkEoQrBo/shcaeqGqxwOjQWju1k7IG+pIrz5y7xdOn8cEMLfcM+JTyOAdk4ofevW+F
 RPnztqYhmaI786P7cVQlCiwkofysE4JHlPlddaJqzZuj3EZ5VtQ3fJI6OmXhR7mNHmWQ
 PF2XXRhNQ96mUe3gqLa46FtBojR+CefHRi7ty7ztAcRyq4L080Bz5Bx55RbKnOYoAT13
 pwRA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790608353; x=1791213153;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=T9WE522pzcG9RBfc+Qp33catMrHKVWd+nXZGK7+/B78=;
 b=HpOmJKoRdQbHtJoBi5rm6A1JRv/GcGizZan+tgqP8bUYIkIei5gyrejH2jCKO4vfMq
 6LNIvBSwH+ti2rfkq7gysT7bVdUWmJ486+BPTc1WlX4BTRdsP5dcjlQw54OFxXv7Et1H
 G+p3aAJ7YtjZtfxIePyjWETp261tjBxLeRLH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608353; x=1791213153;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T9WE522pzcG9RBfc+Qp33catMrHKVWd+nXZGK7+/B78=;
 b=TUuV9KvnQF+7025hPvpCrVgiqOPs7f+CvoiJo/+7icNq1YjCphZ0esU+tBtyeRk6Mk
 M1d23fBWjWSIvYMU11Chl8IxO7Faf8A2mJ7cEwFj0H8xouEa/3DhD4B02Kb5DclFit4z
 DnTGEU9u+9QLKuL+DOIqCZkZxc61fjXyQrjQMKQMJykpX5eu9KWF6HsKJfvZAonsPixD
 IrMJVvmmM2D2/EkL/GwpU/3o2OqZ1JqMvBb4oz5yXHbVwvUE2aN3R42vnwmoPARoA4oU
 vz1oLGhumr7NY1maTqj4Q5KeGrZ1Ftwrap2ncpswnITVc3XDhhyhj0pyNUW0rEBtd1yy
 r9nw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1pPrSTqyZM1vMqQ6mTsfnB+EYnwMzkuAwR5B0myYnBPS/hQMdKLOmBTh2swSTZ5FvNpddo/Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYISRif04QvdSVgL2uEYFId87U+CXtOXcM+dj88Lqpy08kvtjDQd
 wSeOp7FVxcTIUZTLAnu7OjjvsG5no/f82CR8ywdqwrgM7oyG1bOmaA6jcPdMWgwYTWMqFPcXlGb
 lrkVsig3SPSWBlyBeQQSBWqQycviC/rxTb4K1lyiX
X-Gm-Gg: AYBFou1LgWWIM+5cXTbP7Bjj0yBK9GcdV5+JbQdQczkZR9WH4D0jnmcQdejymGDUy7b
 dL8hUJ2fc+qojU/6VX34n9i+q0B2gdALFrdovOns6cmX5eIHUUaTyzXxIAN6L1gPQ/Lr9lt530Z
 SbKK9IeJ6yrO3WwpZyCkDEpZeQbyQsfhAFqqrHUqZ1KfHLBeIaYkKpjx9aos9+LrUexdJqH2SME
 BvlbsiYeK8/+2j2n3VeUG/hWKTyw+TBV/1v3DWHFeDXuxclu2YbxWgrlqPyBOxU+x1uDGgiYe7/
 r6xlpNjEviiCEI/W124BpC4Y7mYP5Rj66m75VD+lcxLlumXUjDZ2AA==
X-Received: by 2002:a05:6402:42d4:b0:6ac:765e:def4 with SMTP id
 4fb4d7f45d1cf-6ac765ee2d8mr2672605a12.12.1790608352714; Mon, 28 Sep 2026
 08:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787272661.git.daniel@makrotopia.org>
 <72724567f8aea0a89c09aa36318c5573f0e50879.1787272661.git.daniel@makrotopia.org>
In-Reply-To: <72724567f8aea0a89c09aa36318c5573f0e50879.1787272661.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 09:12:19 -0600
X-Gm-Features: AclHuK-aZPZbP9WwusCbGzSZugDcbyJjGvVcS_zWCvXiSEx0nx7GKFRNJ1nd5A8
Message-ID: <CAFLszTiZY_hjr85kfUU03sxb2Wzh9qt=6zDqQtAjW-FNuQBtyQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] cmd: ubi: create a ubi_blk device when attaching UBI
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Neil Armstrong <neil.armstrong@linaro.org>,
 Randolph Sapp <rs@ti.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Daniel,

On 2026-08-23T19:12:43, Daniel Golle <daniel@makrotopia.org> wrote:
> cmd: ubi: create a ubi_blk device when attaching UBI
>
> A UBI volume can be reached as a partition on the ubi_blk block
> device, but that device is only bound from spinand_bind(), so it is
> missing on every other flash type (raw NAND, SPI-NOR, ...).
>
> Bind a ubi_blk device when a UBI partition is attached, unless one has
> already been created, parented to the MTD device UBI sits on. UBI
> volumes then become reachable as block-device partitions regardless of
> the underlying flash. The imagemap block path relies on this to read a
> UBI volume.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> cmd/ubi.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -670,6 +673,29 @@ int ubi_detach(void)
> +     ubi_bind(ubi && ubi->mtd && ubi->mtd->dev ? ubi->mtd->dev : dm_root());
> +}

The return value from ubi_bind() is silently dropped, so a failed bind
(e.g. -ENOMEM) leaves ubi_part() reporting success while there is no
ubi_blk at all. Please propagate it, or at least log a warning.

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -670,6 +673,29 @@ int ubi_detach(void)
> +     /*
> +      * A single ubi_blk device serves all volumes of the attached UBI
> +      * device, the volume being selected through the block descriptor's
> +      * hwpart. Bind one when UBI is attached -- unless a previous attach
> +      * already did -- parented to the MTD device UBI sits on.
> +      */
> +     for (uclass_find_first_device(UCLASS_BLK, &dev); dev;
> +          uclass_find_next_device(&dev)) {
> +             if (dev->driver == DM_DRIVER_GET(ubi_blk))
> +                     return;
> +     }

ubi_detach() doesn't unbind the ubi_blk, so after 'ubi part A; ubi
detach; ubi part B' the existing ubi_blk stays parented to A's MTD
device even though UBI now sits on B. Reads still work because
get_ubi_device() returns ubi_devices[0], but the DM tree is left with
a stale parent (and A's MTD isn't safe to remove). Either unbind in
ubi_detach(), or re-parent here when the target MTD has changed.

Also, walking every UCLASS_BLK to detect a single ubi_blk is awkward.
Since ubi_blk is always parented to an MTD device, iterating the
children of that parent e.g. with device_find_first_child_by_uclass()
(or tracking the bound udevice in a static pointer) would be more
direct and avoid poking dev->driver.

Regards,
Simon
