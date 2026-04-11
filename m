Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E825BF3ED4F
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 14:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A32F841B9;
	Sat, 11 Apr 2026 16:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bg+sP9ZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65DEC841A2; Sat, 11 Apr 2026 16:56:56 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78B5B84118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 16:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-66bd4e0560fso4045118a12.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 07:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775919414; cv=none;
 d=google.com; s=arc-20240605;
 b=XiwQaxcC61IyBhh0f9/pxtCRSsmEuT717mUMbzCcKKsxw+4OPjan3ix5zUUeQM2ngh
 FzhxKAQth3I1/TqISJVOGLaGPV7zQ1FjoBZIL77deVJN7MpYThrwl1icqD14CKYH8aly
 r8aYJRercGFUvcC+LqMKTpvEWiIrCBKIF41U8B+vNggG7WFJy3Dw75B250d7UQlqDcdB
 /bMHlVHBnxfTjGj4jJkslUaY7XSO1J5Fx//haCrpIsi5wg5/AXnDAlIH1rQxve/O6+c1
 rZQONDYYKspHIevHCIiqjJvQp8djWtZRv3qAnDz5hnRAy8HQbMseHWcWvwmktNJRLSpv
 sMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/4fWAhKV22VZedRl+F8aJflHw0g/vRP9P1gGDojBFtI=;
 fh=2H2z42KegxqsJEnh3SHJTVPqVJ+qMkH85mYRIk+hC3A=;
 b=N5Qd2qgRQDSvNJW/pZWRbjK2t40cnXFT2dkxT6Ookxq6EZSAr2LZ5rgYn0Wk03RUsX
 6iPI+BbJqccGimuwDl8q+hqd5Sqx/eWeypSxRXiEoyVvQRsMQROCvJo9Tc4wVLXmIazR
 Ldpb+CU0FpqCztSDwW5WZBxDbTsWMpZyd2WxpJW70pr5E2zO/Ss20Q5bV2fy+2tK8Ij8
 fAD6uZP4DwM1vBd73WbT+r139FM28uoSNvO0aDs1Hp0bPPhNgnSk2K906gu/Y1gN9TQc
 z3o9I44H/35lFgas0TGw1UMbSLR4A2H6Nsln+CWdeLbtJQ4Xp2nJxuFq6cD/8ZzLy2s5
 w0ew==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775919414; x=1776524214; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/4fWAhKV22VZedRl+F8aJflHw0g/vRP9P1gGDojBFtI=;
 b=bg+sP9ZMPacoi37Iy64qjauVqFqu04WFqCmvsZeGCkDYQoavxkXzVaafNhi122tpLQ
 nLcvQNBKiFqr4oviXWUoWXtpp2vwnXIT1naayS+IjXIvhQLxq4lN0Szz2nB9XO4CLDqL
 h4dKbCoA7zhwMztHK+7fRsQqEE/wOTS2moIjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775919414; x=1776524214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4fWAhKV22VZedRl+F8aJflHw0g/vRP9P1gGDojBFtI=;
 b=UUHcNtgzxTwJQ+p+MUTGyLNoQX2/3GR9d46hDkBgnjXnNyTU78cMFxJ1sGgzSSBIDB
 QJuKeJcg6jcdCkU7/YzdocVZSUEO+HRWCgCM1nG8S0kos12ZarpomBNn7HMvwX/aPVb6
 VMJtZ90RdBdL5YwpF9XnTwKDQ160s3OHVG4ZvZUcswMY0OCYVhr3IP1mD+L0fhlZL4o3
 5UNqG0nIpNrqNtWEAbYaUgwv08ySfSolnkZskcRMvW4C4okX/zjTHrUzUKeTl2TBEZa8
 ACFDvGj3it4xJ75RdnGauVvxOgMtKrSDspmOW+sf2sdGUFAMXto2zkPyQV1leJ/YTsZD
 KqKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxUCFh2HZamQTNwYXpJOBxKjQm3Sg4qYFZcwRp8tbiF3vdtIUf3SZvFRvc7adEA0LMPEdm7vs=@lists.denx.de
X-Gm-Message-State: AOJu0YzH4DA4RYzRPNUMYOEiOegyOBNYdgig22NiQTQpVJA3T4LgMEoO
 urzz9HdhUn9OKICjAmYhuYVFwElZnCaKJCr6qyqranUzveLTkQPdPehq7s5JT0eAGDGkVAbUQ9x
 Ia4GsR1BpxX40RQU+lBqMhh47JOhWMf5MbHRUUGGG
X-Gm-Gg: AeBDieuCNmrQ6Z74CFl5QFGA6BFvsKYDC/U7NC1F+xQYKk8Hb6zuUvlt97JChmpGB5h
 Oscv8UiynYZh7a0a9LbHKvyLHFyPQCC4eHePTXRI6LXXgZ3o6w+TqARrVSqhvQb3KzcOL8di9lw
 tRYdQhDl8Tnh3D7vR+V67yAHgQ+pPYrQO5KLsFwG7rzw8FcdZ1BXA/4r8fgQZmP1TjiVg+KeFxj
 mDwLEgdBc/htpBqfmZSBxUf3uc51w1qso+EKdl30IQModZ6Vw0gNX7U+PDInH4BiedgYxUNCtTM
 fQI3QQ==
X-Received: by 2002:a17:907:9719:b0:b98:284b:53b with SMTP id
 a640c23a62f3a-b9d76d2c9dbmr389652566b.14.1775919413913; Sat, 11 Apr 2026
 07:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260409133303.31875-1-ansuelsmth@gmail.com>
 <20260409133303.31875-4-ansuelsmth@gmail.com>
In-Reply-To: <20260409133303.31875-4-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 08:56:42 -0600
X-Gm-Features: AQROBzATp2q8ueRhsMMVGGQgqAoCia-Do_lD4NqWAt07BiuDBYPkMBOZmBErMJg
Message-ID: <CAFLszTiMVJ=YFJWDEGNtfq8fPAXePRaCVJr43yi1bqyX3AKiMA@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] misc: fw_loader: implement generic
 get_fw_loader_from_node()
To: ansuelsmth@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peng Fan <peng.fan@nxp.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Justin Klaassen <justin@tidylabs.net>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
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

Hi Christian,

On 2026-04-09T13:32:56, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fw_loader: implement generic get_fw_loader_from_node()
>
> Implement a generic function to get a FW loader dev from a node.
>
> There is currently only get_fs_loader() but that is limited to chosen
> node and is limited only to FS loader.
>
> Introduce get_fw_loader_from_node() that will parse the
> "firmware-loader" from a specified node and will search and probe a
> matching FW loader device, if found.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>
> drivers/misc/fw_loader/fw_loader-uclass.c | 23 +++++++++++++++++++++++
>  include/fw_loader.h                       | 14 ++++++++++++++
>  2 files changed, 37 insertions(+)

> diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
> @@ -96,6 +98,27 @@ UCLASS_DRIVER(fw_loader) = {
> +int get_fw_loader_from_node(ofnode node, struct udevice **dev)
> +{
> +     struct udevice *fw_dev;
> +     int ret;
> +
> +     node = ofnode_parse_phandle(node, "firmware-loader", 0);
> +     if (!ofnode_valid(node))
> +             return -ENODEV;
> +
> +     ret = device_find_global_by_ofnode(node, &fw_dev);
> +     if (ret)
> +             return ret;
> +
> +     ret = device_probe(fw_dev);

Using device_find_global_by_ofnode() followed by device_probe() does
not verify that the device belongs to UCLASS_FIRMWARE_LOADER. If the
device tree contains an erroneous phandle pointing to some other
device type, this function would happily return it.

Please can you use uclass_get_device_by_ofnode(UCLASS_FIRMWARE_LOADER,
node, dev) instead? That is the standard pattern for obtaining a
device by ofnode within a specific uclass. See get_fs_loader() for an
example.

Regards,
Simon
