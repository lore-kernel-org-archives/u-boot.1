Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59212CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F7C4406C2;
	Mon, 28 Sep 2026 15:13:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JA6yMTdE02wY; Mon, 28 Sep 2026 15:13:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 19879405E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608389;
	b=WSlLaWZhK88lOOdCCo8tEQEcJDAGbI+O5LjpgvN0hX1LdfRSf0xajtownpZNtI/irrSd
	 5OmXU1EGfkM28TQQWIHn5oJgD9yIPtb3355VPh5IIZQHa8XwXhGCoWcEh53/xmzZnoGVP
	 LbEqF/dijFMa76Q01worvS3uj45jhyzZCxvV/YBQc7EPALsmeSZ5vMn7PNqxCD1CWtUXR
	 iltRSxRhoLlbNMmV7jdWW7z/Edzw1AW+VkjhnjVWGtU+9z8bXiEo3nghYmWWbDkVaMaRp
	 tNF7eZjES0HMKr80VMguIXbnvXT8JuqsCnQxGltCm7yHQ48fuJEGUKUz+P4LzayqnBA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608389;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=IlR0jpXOzz1y1N2Nup6Y69icE0DiSdSONUU3jJ+vOxI=;
	b=Hes518ibQ3i21mtPNrzyuz1ry7726FJxPAqnSqmpICcgVymbxANPKflnxrGA+EQSXVSG
	 cqU7KpqwmE55THRGryhD9JHJhMnPFIY0pJ7toCObH4seqg7jtVHlo5MV7XgHm/JMjnR3k
	 ZcwtAn9tpTJ8M423a+f6DIpeRx/42+NlcoU96JEkjUo+RNacrgWYoRI20IxngCANGUWFK
	 Xlyve9GAAeBJBN1I6OnkFjV77irSEyDUt3998YgB2YOvjDhnWwPm0lKZFDEFdGhDUnYN3
	 4sektioNG+k6ln9IXIL5ICHcq8Kd+Ns2DdQA8Xhr+aJDg5we6kDYWk0y3evcGnPkriQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608389;
	bh=IlR0jpXOzz1y1N2Nup6Y69icE0DiSdSONUU3jJ+vOxI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bun/ax/BdhukSXUVJpkB79Nh2WfytRlgaZaYneitYebliZ4lJRGwfKExt1OoTZmcc
	 8b8VLr4Z36OioBYBX0M8Kjg+7xBbH6X+mjZeAQ6EKCdzrV1BRaHAEu8U2XQ5kLiRQh
	 CKd+Gcz2YGx+tAJCmzGnBlTArSvlkCCGcHtz7jMuf4/V56ZWedfqlLCdNTrhrc1psz
	 TyAzVCGwI9qA8xvT07JNAmZBAH0izWqDne7r/uf/yyQz3c9cqxYZu1iehND0x6w8Q8
	 g4O42L+2G++yN3n1OTOas4KKgdyCnyoU53As7QkDgD6J1HpYfPooNE42v7MFYlc/Jl
	 ZzJQzwtlv79mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19879405E8;
	Mon, 28 Sep 2026 15:13:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E15324E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 720E840055
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:13:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AcroXF4_4jA3 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:13:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A2C3740048
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:3b::2a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608385;
 b=V8jfpkOg0m7/CF78h5+YdE0sQP2+X/pO8hXyGjt56Qg3PihbhEUVjHaIjRptn7V3jShc
 QS1VXXLdZlm8LsW8cshcYVdxJhLEWB/KDqFJFxqUfeEouvGHFSQQ1HZHfNrbOgYtYBlVx
 5433RMYxa1JS2xwXRlV84HJN2agAg3ZWjQq8VW0LA1TPH/SzcumWytANjrqsfboQirTjE
 yEmD0oc7skcye4W9Z522X2yFL1HnZhC/6T/5IwJytH86hiqVvUMviEme14vUPdUKVtoP8
 qpyxx4DTSLIN/AfP2mRruUw+895gcArfZ+DJXTuR2Vr9AsnP1TWuqS2YklE0kLY60Uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608385;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=IlR0jpXOzz1y1N2Nup6Y69icE0DiSdSONUU3jJ+vOxI=;
 b=WhPMuXXQNOJCUfESKosGb6LosLqWjeVeXZMXAvEuXvLokVpYpsKoJ9B6aeh+nZKBQSoN
 4/hryHKUH8TrbffIPymYAH0MM66Bm3mtWt5dcPHJReBhK67B57VB+Vof/QIEolb8Ui+VS
 CHb8+QJNx2X4edOPmgTT1F2X7UD17cC2th20OBER7kXdQITW5PydKhE44xuFcwbpOYEs6
 VNY3MsmulfIalt4RL4A2bqqhgAieistVICUKChRofH9h5OmlFvce56qCUmYqydhYK4LbB
 gZXHaTkmhVhz0qWyjgWINhOM3m9eXsthu9UrISE5ZPmSVcawf0gZ0ZOPJ5g9paYgcTQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=D2YB3yoR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:3b::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:3b::2a; helo=mail-pz2-x2a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=D2YB3yoR
Received: from mail-pz2-x2a.google.com (mail-pz2-x2a.google.com
 [IPv6:2607:f8b0:4864:3b::2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A2C3740048
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:13:05 +0000 (UTC)
Received: by mail-pz2-x2a.google.com with SMTP id
 d2e1a72fcca58-8814e797a5bso951681b3a.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:13:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608385; cv=none;
 d=google.com; s=arc-20260327;
 b=a6DkGyz1HTr0STuDWTBq7BglyhL4930qHKL0vnbXD3q4d5imsf6JreiaVBUZuKwTr6
 E4FfMvWtjR/RB9v9uqbCYTtHyK1WimKdr3fL7qkfQa1YTvboOXmjJd80CIOXOAWtsYYl
 aftHgEwgXu0gajgS90mzcWRFMPHVmd03ZGUegtWqFOf9Jy2BrNZIN8uc8iIQg27mHiXm
 3l5zwYtha2U2axmWSdp6vZIKbL8mpWQYaIluyWjXcAvdblJWo9Raaq2wr5+q3y48iRLf
 iFFyBmOU3jy9lZqOwvO4x888ZnsHcR1otWhG3Ob9qoW24CEwLCsJT0ZnasrOT8KGz+Ks
 qUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IlR0jpXOzz1y1N2Nup6Y69icE0DiSdSONUU3jJ+vOxI=;
 fh=7TZtTZyPy8vpNJcT3ltC07bYqG9jXSmCrN/96n8rwgs=;
 b=TaJtYrLdZx8Cz6ks6F8yD57r/LRiPgjl62rc6IpPm0i8wGGtM6xyWJQp848x35DlrR
 6wTErZerTF5YVPKZpd3xZyE7jPaBR2GRZJXz3TYXONmR6wwQEaP2/rwlZgMj5eVCmXcP
 CA+4V2RIzZ+NcLKH7P1r80nQJdU28HqvXNJyvOs8POc8+7AMYyMteLDoCH88gC1jNK/o
 cw6RilGmR04WRVFHD/8ZxAwDbrTE2EDWjVtHScZTh99m9Q6OGu7vhiHZ8aih3VeTcYAg
 SFXYxGAykuID9ZiLPUXl+EwvCbjEKmnqRUIOP4X7Q2jl/ViBDn3cqK+zJt2/dMQ5B0XM
 x93g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790608385; x=1791213185;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IlR0jpXOzz1y1N2Nup6Y69icE0DiSdSONUU3jJ+vOxI=;
 b=D2YB3yoRrhFzXAUm0im5h7yWwXVvVMOSEBnS/X+8+p7V8NNrjnG0voqRZpfrN9/WyN
 1E1WlPvDzCVWBgN+JpCsGxIA8nZBhKJUJ4tYZNa11grqXke96hiiGfTuyB7j7FKi4mvA
 WAMSeRNTb7CNInxQ7xI7c5t8brVlMbeokz19I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608385; x=1791213185;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IlR0jpXOzz1y1N2Nup6Y69icE0DiSdSONUU3jJ+vOxI=;
 b=KfGO0r1rTIusxSPKb1puiSSsHMBamJUMhtMeaqh8dJr5t7Qtze9HIA9qL7JJI0daue
 Cn0XJNKabWwLhHA/aWgF0p9AqF65XORIor7U1d6Pi2aRQ+PJ2GAXOZ3H/g0HwucxzeEt
 O1HW/xSbZ+THRcDxqrZr8+sVe5iwbUZkBbuFnkN1G5nUxGIMaVWp6NBoSKVgXQ74hx+p
 4Ya6IMmaNiOb7l1rWaXPhVOk3lhhNtQWxsy3c+ZA/Pecvbv5gVOZxHtG862YnXnd3BJr
 akp4+fe/BMmR4egolRgKG7PbUiIVj5ivZwZo8qDhn4+DiF6hEB6VWId0aPjLlEmWnkr1
 1t9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQRC7tf6t95+0Vg2eL1KlvGUrdQ5mWTGBZgqsP9k3HXrr5EHEXmuGrDamLQIA3ieB5xmzGSWg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++leJHuq54YxMeggPRltDelX/3TjiZTpHK6AnD2Tg7MDHGLOBn4c
 hjfBQ9fmdLgycMBhbVaUgYGEN/FYWzcJTZHm4th2PnNqhZp3ZDKJSoZqH5KVAaCLR2e8Czb88dr
 MAV918JwQNormP1l9oouAPshe1CnKWCf4RcxVGTQZ
X-Gm-Gg: AYBFou13mbNE5+HAJwgfjBJ9oDvX+tKR7M8HR3qOpWczit/oIYOXrXwnvwPDTPyOt8/
 4ZYte5IDX/GsOYzb/5mZg9xiELkYZx/EDYWiSrzmJlMjOG7GtjZaR5MtMakA0i4Fri4WYRPxF9o
 gWaPMTLdSvD+x63r92/Gt4ddSXnmAb9xa/qhfmGw6nydWoPGse6MujDJrXPCsnxaplRaiGh0e0/
 W3o7j3t43Ej596j5igMbzv744iOEb733Xl3oZgXoC1bN4LeXy7oZsAzPkYjAETWWzfrQR15V/jf
 pKD54OlJzOpMG1eGe2nicADzHJtR6Pc8qvh5lg9nAR2+T5KjTUCHhg==
X-Received: by 2002:a05:6a20:6f04:b0:3d3:adad:f171 with SMTP id
 adf61e73a8af0-3de0e6fb644mr11493396637.19.1790608384612; Mon, 28 Sep 2026
 08:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787272661.git.daniel@makrotopia.org>
 <0d1a6ae2867fddcefe2c224ed47af14fc41abd2e.1787272661.git.daniel@makrotopia.org>
In-Reply-To: <0d1a6ae2867fddcefe2c224ed47af14fc41abd2e.1787272661.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 09:12:38 -0600
X-Gm-Features: AclHuK9EH6mmbr2SqZ5EWlxgKqzolCW5aa8MZrs7fAORa3zf0uqsc8BPoZJVBtk
Message-ID: <CAFLszTjn=uuqLzhVpJri5qRHqyTzNupbJ-HYT7aeNJ9uVEZ3oQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] boot: add imagemap on-demand loading from storage
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
> boot: add imagemap on-demand loading from storage
>
> Introduce imagemap, a small layer that reads image data from a storage
> device on demand and keeps a translation table of the byte ranges
> already loaded into RAM, instead of copying the whole image up front.
>
> An imagemap device (UCLASS_IMAGEMAP) is created over a partition of a
> block device with imagemap_create(); imagemap_map() then returns a RAM
> pointer for any byte range, reading it in on first access and reusing
> it on later accesses -- so a header probe, verification and the final
> load of the same range share a single read. Block devices cover more
> than raw disks: an MTD partition is reached through mtdblock and a UBI
> volume through ubiblock, each exposed as a named block-device
> partition, so imagemap needs no storage-specific code of its own.
>
> The read path is built on the SPL struct spl_load_info abstraction and
> a new spl_load_region() helper (added to spl.h): the block reader
> reports the device block length and spl_load_region() performs the
> native sector alignment. imagemap_map_to() keeps a payload byte-exact
> at a caller's load address, reading the aligned middle straight to the
> [...]
>
> MAINTAINERS            |   7 +
>  boot/Kconfig           |  16 ++
>  boot/Makefile          |   2 +
>  boot/imagemap.c        | 451 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/dm/uclass-id.h |   1 +
>  include/imagemap.h     | 136 +++++++++++++++
>  include/spl.h          |  47 +++++-
>  7 files changed, 657 insertions(+), 3 deletions(-)

> diff --git a/boot/imagemap.c b/boot/imagemap.c
> @@ -0,0 +1,451 @@
> +void *imagemap_map_to(struct udevice *dev, loff_t img_offset,
> +                   ulong size, void *dst)
> +{
> +     struct imagemap_priv *priv = dev_get_uclass_priv(dev);
> +     void *p;
> +     int ret;
> +
> +     /* If already mapped to this exact destination, return it */
> +     p = imagemap_lookup(dev, img_offset, size);
> +     if (p && p == dst)
> +             return p;
> +
> +     ret = imagemap_read_exact(&priv->info, img_offset, size, dst);
> +     if (ret) {
> +             log_err("imagemap: read failed at offset 0x%llx (size 0x%lx): %d\n",
> +                     (unsigned long long)img_offset, size, ret);
> +             return ERR_PTR(ret);
> +     }
> +
> +     if (!imagemap_record(dev, img_offset, size, dst, false))
> +             return ERR_PTR(-ENOMEM);
> +
> +     return dst;
> +}

If an earlier imagemap_map() has already recorded a region at the same
img_offset with lmb_reserved=true, this calls imagemap_record() with
lmb_reserved=false, overwriting the entry in place - so it looks like
the LMB reservation is silently orphaned and never freed by
imagemap_cleanup(). Please free the old reservation before overwriting
or refuse the overwrite.

> diff --git a/boot/imagemap.c b/boot/imagemap.c
> @@ -0,0 +1,451 @@
> +     if (bl_len == 1)
> +             return spl_load_region(info, off, size, dst) < 0 ? -EIO : 0;
> +
> +     /* Partial head block: bounce and copy the wanted tail of the block */
> +     if (overhead) {
> +             ALLOC_CACHE_ALIGN_BUFFER(u8, blk, bl_len);
> +             ulong chunk = min(left, bl_len - overhead);
> +
> +             if (info->read(info, cur - overhead, bl_len, blk) < bl_len)
> +                     return -EIO;

ALLOC_CACHE_ALIGN_BUFFER() with a runtime bl_len expands to a stack
VLA. For MMC that's 512 bytes, but a UBI/ubiblock leb_size or MTD
erase-block-sized reader can push this into the KB range. Probably
this is fine, but do you know what the upper limit will be?

> diff --git a/boot/imagemap.c b/boot/imagemap.c
> @@ -0,0 +1,451 @@
> +     alist_for_each(r, &priv->regions) {
> +             if (r->img_offset == base_off && r->size < read_size) {
> +                     addr = map_to_sysmem(r->ram);
> +
> +                     /* Free old LMB reservation if we own it */
> +                     if (r->lmb_reserved)
> +                             lmb_free(addr,
> +                                      ALIGN(r->size, ARCH_DMA_MINALIGN),
> +                                      LMB_NONE);
> +
> +                     /* Try to re-reserve at the same address with new size */
> +                     if (lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &addr,
> +                                       alloc_size, LMB_NONE)) {

Two concerns with this extend path:

1. If r->lmb_reserved is false (the region was recorded by
imagemap_map_to() at a caller-supplied dst), this happily
lmb_alloc_mem()s over that memory and then re-reads on top of it.
Whatever the caller placed there is silently clobbered. Please skip
the extend path in that case, or refuse to extend a non-LMB region.

2. Even in the LMB-owned case, when the in-place re-reservation
succeeds the whole range gets re-read although the first r->size bytes
are already valid - the whole point of the translation table is to
avoid redundant reads. Only the newly-covered tail needs reading.

> diff --git a/boot/imagemap.c b/boot/imagemap.c
> @@ -0,0 +1,451 @@
> +     ret = device_bind_driver(desc->bdev, "imagemap",
> +                              name && *name ? name : "imagemap", &imdev);

Just to check - is the intent that only one imagemap device is ever
active per block device? Two calls with name == NULL (or two different
partitions selected by index) will bind two children both called
imagemap under the same parent, which works but makes the DM tree
confusing. How about deriving a unique name (e.g. including the
partition number) or documenting the single-instance assumption in
imagemap_create()'s kernel-doc ?

> diff --git a/boot/imagemap.c b/boot/imagemap.c
> @@ -0,0 +1,451 @@
> +void *imagemap_lookup(struct udevice *dev, loff_t img_offset, ulong size)
> +{
> +     struct imagemap_priv *priv = dev_get_uclass_priv(dev);
> +     const struct imagemap_region *r;

The long block comment is useful but says the second guard prevents
underflow on LP64 'where ulong and loff_t have the same rank'. loff_t
is signed long long, 64-bit everywhere U-Boot runs; on ILP32 it
doesn't share rank with ulong. Please tighten the wording - the guard
is needed unconditionally because size is unsigned. Also you could
wrap the comment to 80cols so more of it fits on the screen.

Regards,
Simon
