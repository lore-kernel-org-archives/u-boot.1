Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4178ACD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 12:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18FD1849F7;
	Fri, 19 Jun 2026 14:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VWm7wP2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F30F384A0B; Fri, 19 Jun 2026 14:46:21 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10B18849F7
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 14:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-69531108f25so3926203a12.2
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 05:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781873179; cv=none;
 d=google.com; s=arc-20240605;
 b=jQQOKSm8OLYeB7Eq+03hJUM/dcpoIXAIovs4jWB5t2oVXreFySQWKYik2N7AEDx/at
 qdQ5GgLiP8QKRDqN8+FzrUuJtiCS1MrmuqQ+MIsKix6Cv+G21iH03WlSLDSnGoJHwGb6
 x7nOCC7XD0Vtiio+xxfH+F0QL3OAGW1TzZQHfPgpjz/BSkOuPGtEUmIAzCojHTxUnNzy
 yuKvDTcrOjB5TWbdwk2njngCqvg8gSG0SmVIYdh7ZabBTx7uZ9MvClQtR7gG69qGX4NB
 e/8km0pXhw644FX7JBCTfFIbUZnzXPjp+X3CwJeL3erziHJJaGyPUgEfkQf6cHuAVuh7
 q4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KcDa8pX5clDXTwEwiBqHkfXW0dnikvYL/JfbOXVK5n0=;
 fh=TbghQz01ZiT8JyjnPNfPfWAtdj1jNj2NBDdNdBYZb8Q=;
 b=QN8uDviHhHY/8bbn/4cVzgpbDajFhiTQkZadY/RDEjBaznsqT3qe2qh2R1CXPjSFRg
 lN8qaum260tRmBfIWqA3THoQboIJ0fpZc9WGSrWJN3gTReV+VwHRAjZo+IuMUp7I60YZ
 b87v4o8CBYuBfIU8fCaStkmRMFNke9SF6Px86Bxj80Q++6dgma91AyXcKgcGJYmErWAU
 WWrerj3jPjsxMyy8cyyLXVJTLahrC1yML6z52z6/+FmQhsEWIKqXyKiCEUwEr7lG0ykm
 iEejxHN2za6/5gEDhIQ3R1kgdtilDt17/0RHt9QBzrv5yk77q899HRKw+PQsKZ/HJobV
 2CrQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781873179; x=1782477979; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KcDa8pX5clDXTwEwiBqHkfXW0dnikvYL/JfbOXVK5n0=;
 b=VWm7wP2PMl2JiMhYWt/75q4JBfr1JhHCV8dZ6uXDhXd3odZAZZGBv7w6GFniIxeR7D
 /SL7z+OqQim6ujaxVuzLfYTv5ZeP/U8KoIIEJT4oLCypcXVk3ayhzj+bzo6s4iUv2Cuj
 7ryMJF0jEODlbVgSTW8uWC7pGwv/3xs9AlT2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781873179; x=1782477979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KcDa8pX5clDXTwEwiBqHkfXW0dnikvYL/JfbOXVK5n0=;
 b=lxSOW7woEeE00qPbFOIhdtZ2+Oh2vRh0oEqlMRK8lxGH/3/mV9QA8i47CbeJQ8zNUW
 2f201EnuIHjglCHW5rRin/AmRHOOogUGBHsDFvTwuhYlo2BVQa+K4s95fEK7wzkEEOoy
 YbPoeHRJbNv2wQloPOIeNndfKN6fDNZOWTcFnCkBq+9jH6OTW6o3GlnQy/32buENjmaE
 ifPHA7b+k3bBJ3EurgaYes+KFig8WdC2XmiCoART517Ag8dSQV+tMznBgstBlYORmNUI
 KOjSC1eXBvzeztpjwM+P7tJ0UUYnBQyuDC+fFcwcpi+cCvXolLx+8Hm1Y+1j6mBFowNY
 Qv7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/sGhLoX4Mo1lz5gUxwkpgFxp5Fdqcyjulxno+RWzihScYiGA11zKakEZnlrCPzPL1GnPw15QE=@lists.denx.de
X-Gm-Message-State: AOJu0YyRXp++J2BmeoZWi4J4I6Xy8qs88EY8YKvu+OV0J7SvDro7llqM
 mZ5NG+sx7YrIyRb99oCEDc9SsqnA03Xu79TUXl8JHmPHmQGaa0th2E1b7C0gwtJrspxUoVY2CsH
 2m9+9zyokwd6bQ+/Q5unb1QS5f+vFQCAZknXBLfM2
X-Gm-Gg: AfdE7cmM4fKBB63nPnIuGkvwKIqFyw9nKWHyNvjsjl8jbCQScNhDWgt98ay4NVRUsZE
 O9Ks2RG25t8LXIUBHVv6/ZyEE0S5ADObrUFjm690ejH76I20TD1jJ3HS+uh/zJ2UNBcNDlX4Lzl
 8J4ob5jHOh3E42KqopSz8N5Gbizp+khO/GLfpDR/vxjFo0oE7F1A4PayrhPePLaL33VXkfwPx0d
 FlBVKh3Y4Wfut0rMO9sTUu5y3wHtVzA/92qBNuvVb4tieIipKuVgYgiv3kNEqjrQk6MpFeplMOi
 ECy/Hvlo
X-Received: by 2002:a05:6402:5256:b0:670:8acb:e822 with SMTP id
 4fb4d7f45d1cf-696dde6e53fmr1712956a12.12.1781873179539; Fri, 19 Jun 2026
 05:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260616191845.6182-1-ansuelsmth@gmail.com>
 <20260616191845.6182-4-ansuelsmth@gmail.com>
In-Reply-To: <20260616191845.6182-4-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Jun 2026 13:46:05 +0100
X-Gm-Features: AVVi8Cdbh7BJtqJQoi7whlbKzNwWQGbb4ea_fAFT3g-SNaUKLLIbnbQ8EjZjehw
Message-ID: <CAFLszThvS7k9jM6f_s0y3YhkYedrfLAHX-HU3ad2cXTAc5Gw5w@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] misc: fw_loader: implement generic
 get_fw_loader_from_node()
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Martin Schwan <m.schwan@phytec.de>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Weijie Gao <weijie.gao@mediatek.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Randolph Sapp <rs@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

Hi Christian,

On 2026-06-16T19:18:35, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fw_loader: implement generic get_fw_loader_from_node()
>
> Implement a generic function to get a FW loader dev from a node.
>
> There is currently only get_fs_loader() but that is limited to chosen
> node and is limited only to FS loader.
>
> Introduce get_fw_loader_from_node() that will parse the
> 'firmware-loader' from a specified node and will search and probe a
> matching FW loader device, if found.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>
> drivers/misc/fw_loader/fw_loader-uclass.c | 23 +++++++++++++++++++++++
>  include/fw_loader.h                       | 14 ++++++++++++++
>  2 files changed, 37 insertions(+)

> diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
> @@ -108,6 +110,27 @@ UCLASS_DRIVER(fw_loader) = {
> +int get_fw_loader_from_node(ofnode node, struct udevice **dev)
> +{
> +     struct udevice *fw_dev;
> +     int ret;
> +
> +     node = ofnode_parse_phandle(node, 'firmware-loader', 0);
> +     if (!ofnode_valid(node))
> +             return -ENODEV;
> +
> +     ret = device_find_global_by_ofnode(node, &fw_dev);
> +     if (ret)
> +             return ret;
> +
> +     ret = device_probe(fw_dev);
> +     if (ret)
> +             return ret;
> +
> +     *dev = fw_dev;
> +     return 0;
> +}

Can you use uclass_get_device_by_ofnode(UCLASS_FIRMWARE_LOADER, node,
dev) here? It is more specific.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
