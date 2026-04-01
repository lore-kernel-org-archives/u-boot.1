Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39C71112242
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 23:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1EE684020;
	Thu,  2 Apr 2026 01:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y+8aKlL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90B5284011; Thu,  2 Apr 2026 01:23:28 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A67018408D
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 01:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-66e02a7ee78so396064a12.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 16:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775085806; cv=none;
 d=google.com; s=arc-20240605;
 b=fuBk7AUzfDNmRpX6x0RGyfq42qF0Wdv+1UZ+riKmwJge2J4KIy5huaSsjgE6RUjVrx
 ip1Ba3AXxG9sU5B5lZCiJp2PI/Vg8XjA4E7WZNIEDtmDBiCLVg5G4TRti7RC8F8clwYU
 0cSxnNQW9zHIA+QGIYYzSkdKHHVqbqVsJ33kD/SqsoKweCfftztZ+Gb685R+rXCvrhV9
 nbB1xXu1oG8pS7CfB+98nc1Iqn5yFX8bYXW/V0QbPkjRkdV8yhEDdgm5ODg7CLXnkUei
 uWudvB+4gXA04wg4Qr5Q8OOIRg6ejDhpVeAaAbpMZysITbnYwC6SFvNua0wG9d/V6NXf
 Q/qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=H4wMy8OcPA7S8mvu3dXr7gFOo6vHVEl2cTbZQIDBrUs=;
 fh=SGHXci2xJXT3h8As2/rDrB+mIGJ1RTnI7tx126xkHuw=;
 b=RaztwadPa3CevlGerqiYa/KE3i6Ge/H4tqQeKflSxHEeieC2z/SqwYDuXk4DsdECNH
 CrsItLneFwwL65Y52MknvwEJ2u8zRldWbDQNA4EqeDXD32brXgA3qwI8O9lPW4z7EPgm
 0zC5MPfcURA7e/HgKf9bo83Hse8nwzgHcb8hHbx5A/p+4cgD3WYv1XGzh/qcznd3HrBq
 TQaV+VahhQ4SYhZrfsfUN8l6ksEWoG4nSICU24FwkqHkbTjq2xngxNCZG9oNGAuULcoI
 f+CYXZj9OOCV8xJIEnAsiuMampHdNJC6AaxTmChsRCpkDjChguxtXJR2O+F1ulpwbzLV
 CSCQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775085806; x=1775690606; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H4wMy8OcPA7S8mvu3dXr7gFOo6vHVEl2cTbZQIDBrUs=;
 b=Y+8aKlL7XeMQaSxS5fc58ibcqJtwq5uRbyyHdqyNeavwqGNFy5ukCcQ0MiSB7CIdwg
 bb47LYDjs4fO38ADvstkYk0RUnOAhsE7tyOAhmLHGFdacXmt/ZqJFBLDlFNP+sr3iqBO
 hFFn3xO4ZXlzuJJMw2xkZ2LtNpL0ypGhTifo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775085806; x=1775690606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4wMy8OcPA7S8mvu3dXr7gFOo6vHVEl2cTbZQIDBrUs=;
 b=cCTRjUaIhfANd3oQKieoD9MNCyOavVWOQnzpMLcUHVRqX1EtcQorNdBkiXQ/gGgPqp
 0rghAp7FPZldQPgx5ZXA2D0Dmvt+ebIxXBxZ4fxctut7DZyY0xNqyslwkOQVb+p4SC5l
 jhGYJWIrY+Vgya0JODYbiy1B/yXXY3Av40PxaneFFtkExTD3neVEPm/skHDVj/Ga6Dn8
 qNVq/QlZSY5F2QQ+Lx0TtMs8V8uB62XuNzCtiUo13JxVC+kjhb0+JTsZJthFCDIiQm2P
 xE0MbxOQF2+gs4CIeji9G9mznivNLEvMm079j2dt5pFUnAw5Fvnpwgl3M843QvgaPKY2
 RY2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDuh983B6R/t6WeGiEVOXeXHip3C6HleaYTs0GAJHpzwuhz2Zf7vPtqFKlDYRTpJZV2yOO7+c=@lists.denx.de
X-Gm-Message-State: AOJu0YwvnqHXK3FW0VkjlequtUQ3bnD5hm+EPEzzfEeDrF6LMlNGDbdr
 yUrzcTaGFBMzzGTCIy2JNbB9VD7jMaoFaGIu0uM5TNRFXk/54dZzjXD4xK7PJKGW/U7dpcN+9o9
 GqjvUTzTXWJ00BX5GaKgSMJb12rDk3whbKRyRfyXm
X-Gm-Gg: ATEYQzzRyBb4WvUzRyV9F5QSEHlR2l4WPYOk5/mpYfbnNsvHMRD0vk2qE4IvQIaIQjV
 TsSKwnufVZLXFJoZc7MQCLH8ihZIrMbA/mcUI2zNQTu4MC9S5NWvOhjZQoFhfGnlALChiXpaOJl
 gSsHFY01eOBsMixvCJdX8KQYISDcZRVSEFL/C3otQ+Gql8pTf0S8Z71O3Wd/4FymYZrhXJ2Mca4
 4/iM+8OmSLNJ0/rmtVoIAWSDfqW+OJlfAYTXR1mNBptrZ0j6HOsdonrn1r7XXBG1yadlutTStTM
 IuPqUg==
X-Received: by 2002:a17:907:d7ca:b0:b99:d2d9:da47 with SMTP id
 a640c23a62f3a-b9c1378f282mr362824966b.2.1775085805898; Wed, 01 Apr 2026
 16:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260331075338.2391-1-ansuelsmth@gmail.com>
 <20260331075338.2391-3-ansuelsmth@gmail.com>
In-Reply-To: <20260331075338.2391-3-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 19:23:08 -0400
X-Gm-Features: AQROBzBxVbNvAZOT8wkxsq3VECZZ2k36JfW6XJBPq284EZ_3WUUbfr1Xe7HR9S4
Message-ID: <CAFLszTgt05WWZ8RB7CY9aSa6t9YqazJiDhcNpU92YDRyR5aaBw@mail.gmail.com>
Subject: Re: [v4,
 2/5] misc: fs_loader: reorganize and split to FS and FW loader
To: ansuelsmth@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peng Fan <peng.fan@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Justin Klaassen <justin@tidylabs.net>,
 Harsha Vardhan V M <h-vm@ti.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, 
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

On 2026-03-31T07:53:19, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fs_loader: reorganize and split to FS and FW loader
> misc: fs_loader: reorganize and split to FS and FW loader
>
> In preparation to the introduction of variant of the FS loader,
> reorganize and split the driver to generic fw_loader function and
> specific fs_loader function. Create a dedicated directory for the loader
> and move the internal structs and functions to a dedicated header file.
>
> This will permit to reuse all the property and logic of FS loader
> with container that are not exactly a readable filesystem.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

> diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
> new file mode 100644
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0
> + /*
> + * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>

The leading space before `/*` breaks the block comment alignment.

Regards,
Simon
