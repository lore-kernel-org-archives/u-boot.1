Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61338C531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:17:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E967F40981;
	Tue, 28 Jul 2026 11:17:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wO9KRL0vrHXy; Tue, 28 Jul 2026 11:17:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0EE8D4092A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785237443;
	bh=BRVVjE3uZ5nQ/kUEsRO6MM6gSzmnc85diOR1g0Dg+Xw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zvbZbCHpBvJvK/LaTQq78QRKhIp1mgmJ4wQIps3ckuzd1Av/8TJpuq5twn9dgjsLC
	 tzgWwOr7eNb0wUMJkWZPYu0lsbv1UKjExo5n8DlDuiKkmzzs3XOEdqRkjw5zFPcx7O
	 d2iI/To29f22sDjWMhXXPBJse/HzJNlDGYkTB871zomD9YdkMyjzSgqsYnlsY1a8Hv
	 acOORcHFM6QxdMNCplRrzwPjKd3Gd03NpXuX2D2tk377CILPT2LxyTFKtx2LzhDsv/
	 rM25DzlvnvX9ySkoXBRdh+iznk54M32hkQeEGtS6HyGIqTfCqy06uFG/LGW3x9Tybu
	 Gc6MkHH/2xYjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EE8D4092A;
	Tue, 28 Jul 2026 11:17:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 65676788
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:17:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 579F481292
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:17:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WFUEIfKtr3fe for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:17:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1C66781290
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C66781290
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1C66781290
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:17:20 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B9198494B; Tue, 28 Jul 2026 13:17:17 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A3D5848BA
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:17:15 +0200 (CEST)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-69ffb48d599so3063816a12.2
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785237434; cv=none;
 d=google.com; s=arc-20260327;
 b=Tdg/6GVmPjQEvKlDKMXlbkWTXcIvMW4CYcA6Php7nu3kBQfppr5ij6OAm1JYqWbHpc
 zk38RpLoNP9mPLJDKfJsAfcNFZgc5ROQ11PCFlqoozTTIyUNumW3GHggY/1cMnRCbxwb
 bIwSBazCwOr30cGeBpjTTeFsArZZx40w4Mnq3UgEZKez6kgI49FYoJU90tifhm4DUvFB
 7RiBDybup2e6q3fS1XiSyxU3dCav4SZdRZPk+2xnNgZBI9DuG0E5IRiV7G8BvXcEnxEc
 B/pTsP2gvDKQGUIHR8x3//hZxzYda84zvVhRgqctrDozRy7+7zdza6SaG23XE3Zw5kMK
 5LuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BRVVjE3uZ5nQ/kUEsRO6MM6gSzmnc85diOR1g0Dg+Xw=;
 fh=AyyfhjLJd6PyO99DkSy4yvMSq2CpXCTAiVAju7z9Rck=;
 b=Sfyao+Y8CdjRWiEXqNXEId3aK11nLcodPEDzCUKDPWLisPTD1aLC6dQiprxTKLWobN
 El6A+wIBr/4xy23jk666BzULjwLcAbZjlAZ8QeytfUCDWM6C2EkYjHnMRqGh9rFbkg1y
 XYI2uTTd9qftZHqvxzcTiYHk8LL4MjahlQ6CnxfV4WeumP5PSU7k6r/o0tbSQTKAClAF
 t4gIQbO8lzU73N2++4DOBBp2go+W+wfYNSFaD+3va0w/JSaHaPtxdbmFZtnaNAk1/hWT
 oo7Picj1N8Aj26skzx9qRdh+/3uut/Bj7StUOo3emP78a751MM7hRSdsAbMw6NxBLmWW
 OStw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785237434; x=1785842234;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BRVVjE3uZ5nQ/kUEsRO6MM6gSzmnc85diOR1g0Dg+Xw=;
 b=Uwu+YHP0F7BsOILRX03TI6I8UPmmKR4BxjoudCZibthDtjXBTISPR2+cgVWmi5ZQB8
 xhRycQuNQl9o63sJrYO/5IpRxr3kZpfr4sd23hj/hJS5FYCvBS9cd2mv439dQnpbauNY
 DKVeSdBIDdMu/BoIm0b61HhhLcF+SLgaQcx8/69EnubaYNeXXtjQQQ0TDxCfyI66oQBn
 u/86tzzA6RATe5moD/FClwsEJjZmhjJgezB74gAs/JK9GlZHL2Goxo6lY5thFuXb6COv
 ykvhywSLYCay4bvtQGsbSonvoDEULB/eHZkpzYyb6y/+V0p76OGrVEsePR5aSRr1SdG6
 zMRg==
X-Gm-Message-State: AOJu0YwY5R5T+LsX5kxC9lsTKBl7UvuoZ9WhhyAHFUd2MV5XmdbKEK3c
 jg61JvIHdasIXs4ltjPTVdULzXM/GJA8/GeQU9nMxcYqVDWjpWTxTgZiU5m1cAxxdwccH4WnaF+
 MCco13OZeYvymFb1+q0XPgGEg3wSg5/vCwfltd9O6
X-Gm-Gg: AR+sD10vGEZ5H1Npc3cB0dr1y4UsT3I8DqBmnH/aTaQMwx2kHf0gU8wyHt92mMZV+ib
 s8W2ZGNUprgm9tugDvLkt1VNOIm3ivR5SMpTOfZWFW3OOgJKq7TaQsp64/PxPBhPN5HiUlVf+uG
 TRoZuQG2OQwIoPh8+Ku1hDA7cwteeycOxEc2Qjsqff3ErxkIUSG4kxIqCtULnm4c+LopzTtDMK/
 CHCOzSVd1Vz/eCaAOnLumvpduQ9PJLUg/OW2H9vNWWBi631N8IaMc9ayMYx
X-Received: by 2002:a05:6402:2b92:b0:6a0:eb:ae41 with SMTP id
 4fb4d7f45d1cf-6a0349fcd30mr992446a12.10.1785237434586; Tue, 28 Jul 2026
 04:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260716223401.378989-1-dmukhin@ford.com>
 <20260716223401.378989-2-dmukhin@ford.com>
In-Reply-To: <20260716223401.378989-2-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:17:02 -0600
X-Gm-Features: AUfX_my-e3uZU1T61rXefi5dPMCfP8CfWX7ulQOk8NSCaCqi3iCr-B3YRBmhawk
Message-ID: <CAFLszThJyByoTw5Jw_jJ1TDb4QjTPB=qi8bdr+CKGR-Z_r8qOQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] drivers: nvme: Enable Force Unit Access (FUA)
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, seanga2@gmail.com, 
 sjg@chromium.org, trini@konsulko.com, Jon Lin <jon.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785237434; x=1785842234; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BRVVjE3uZ5nQ/kUEsRO6MM6gSzmnc85diOR1g0Dg+Xw=;
 b=gth5i2I5a5P+MWj2c2+t3yVCaFg0TN0YjeOh2B6iBpGa6/YzQj3qyqpoLueZ2SuvG3
 dGFqjQOT0sEHzLNgX514AkLrDONOYh+pV97hnOiPZTJA9CQuYXnCu9hxob4VPIwrzcsb
 ih+1Qx/D097bZZVcklkyg+M6k8IillRAw1wKA=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=gth5i2I5
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="gth5i2I5";
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Denis,

On 2026-07-16T22:33:54, None <dmukhin@ford.com> wrote:
> drivers: nvme: Enable Force Unit Access (FUA)
>
> Enable FUA (if present) on NVMe devices to prevent any potential data
> integrity issues caused by accidental power loss or malformed device
> handoff sequence to the OS.
>
> Original FUA effort has been started in [1]
>
> [1] https://lore.kernel.org/u-boot/20211019104049.v3.1.Ic581ec99f46b6dfa2e0b1922e670a333ac859e82@changeid/

Oddly that link doesn't work for me.

> Original-patch-by: Jon Lin <jon.lin@rock-chips.com>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/nvme/nvme.c | 17 +++++++++++++++++
>  drivers/nvme/nvme.h |  5 +++++
>  2 files changed, 22 insertions(+)

> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> @@ -916,6 +923,16 @@ int nvme_init(struct udevice *udev)
> +             /* Check whether volatile write cache is enabled. */
> +             if (ndev->vwc & NVME_CTRL_VWC_PRESENT) {
> +                     u32 features;
> +
> +                     ret = nvme_get_features(ndev, NVME_FEAT_VOLATILE_WC, 0, 0,
> +                                             &features);
> +                     if (!ret && (features & 0x1))
> +                             ndev->flags |= NVME_VWC_ENABLED;
> +             }

The volatile write cache is a controller-level property, not
per-namespace, but this sits inside the namespace loop, so the same Get
Features command is issued for every active namespace. Please can you
move it out of the loop, e.g. into nvme_get_info_from_identify() next
to where dev->vwc is read from the identify data?

Also, 0x1 is the WCE bit from the spec, so please add a named constant
in nvme.h rather than a magic number.

BTW this adds the first caller of nvme_get_features(), so please drop
the stale 'At the moment there is no user of this function' sentence
from the TODO comment there.

> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> @@ -788,6 +788,13 @@ static ulong nvme_blk_rw(struct udevice *udev, lbaint_t blknr,
> +     /*
> +      * Enable force unit access (FUA) for data integrity if volatile write
> +      * cache (VWC) is enabled.
> +      */
> +     if (!read && (dev->flags & NVME_VWC_ENABLED))
> +             c.rw.control |= cpu_to_le16(NVME_RW_FUA);

Just to check the design here: patch 3 implements the flush command and
patch 5 exports nvme_shutdown(), which already flushes the cache before
hand-off. With those in place, per-write FUA makes each write
synchronous to media, which defeats the write cache and can slow down
writing large images considerably. My understanding is that flushing at
the appropriate points (explicit flush command, shutdown) gives the
same integrity guarantee without the per-write cost. Could this patch
be dropped once the rest of the series lands? What do you think?

Regards,
Simon
