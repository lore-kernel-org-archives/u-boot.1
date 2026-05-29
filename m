Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B429CD5BD2
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 06:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 259D6844CF;
	Fri, 29 May 2026 08:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dl/4wMyJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02172846A3; Fri, 29 May 2026 08:58:57 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD47A83FF5
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 08:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-68852b58d87so6340497a12.3
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780037934; cv=none;
 d=google.com; s=arc-20240605;
 b=ATyz8zHi0qPedoeIRohxKU3wN1Cx0lKlYymYz8ThgRzxz3saWHIAt0iE+9ft2ZVIio
 MpZuYXzlPhqQuud2PU82Og/eaqop4CXNE9GyYQwA2mL5j7t7NmHhjqsrAYRWOxwB8kHI
 H28uOJADtRVS4hEKWXsJRIJhYdHkwe+aldw8vzNbMwGbKQzC6p6/qvnpYgNeEMqhEDDq
 eUKxM5FQBK10oGHLLxBu+Lx6z/hvdC/sQRJwFAKI3OFGLUl+7B5c35g0cvlPIf07XwxW
 H4kw61KTBt3BQ2Ax6U5xp7hQprhUcWiFDuVXm65Hcn1GbIhQbH09nx0JozM3uFIsVBKT
 Y4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NC88pLGcPOkxoctMiKkZe/cy6ax+EpUZxqNL6f6gatw=;
 fh=5tM1+nOIQUbod7+XLiLoZvIoSvCB9s3qNZ20Q+Oe0sc=;
 b=kBXTDscU411z4CAGWUT0ECJqaep78tp6nqxBSEsqNhA3RVafWvqCrBWT0QlY9xvcMq
 m0hAHmP4kMooSrkhVPRUT1S5zRjRN9ffsW7dZKnWSKooH5J1ZZk/iQouFT47542WiNRs
 nOl5eJGIoa5AjwD5mjF82uiVf/l4SmnM+JT+pghXVgKD5A5mwQBY+5pIwevB9JyGWc1G
 fNJjlVHjhJqMLRlo8mNbuo5tfChC73PVF+WkV1Z38Q8RMuld20UmBcHXve7PhZ3AiI5n
 w+x3vJ5jyfA4jxLxyb0VbZckoVDgSTly+18SIRh5zGupPbMXjfudZWR5Ef7hmHNlzXSB
 u99Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780037934; x=1780642734; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NC88pLGcPOkxoctMiKkZe/cy6ax+EpUZxqNL6f6gatw=;
 b=Dl/4wMyJxakVRrPjgXL8/RqNreLpYFBnVZOPTIMh4sIlaSzsStFciKxtnCMm2jMIa8
 JM8xasVRb7eU/zByqWosLoe6Fdu8c3OwMkPEzitv6B/KWN56wXgkhRBXp3jJUWAp+9Fu
 +B2fU2+o5JSzhfCwBQW3e+PTc5HXvFjO+uumI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780037934; x=1780642734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NC88pLGcPOkxoctMiKkZe/cy6ax+EpUZxqNL6f6gatw=;
 b=ogYTK5WI4xZeOZ3g+mcRb8DANL5c7Oqntb+BPSENnKjl/Est6Hff4Q9UIVoLJyyFU0
 RHkQF3z+C1x5nrRDL4V6aO+9Yia6i2A6nwphmw28xx0+Dynz00VU135MdB/cjC/GBzTM
 3EirqFwOomPXLJEXDWF/rzsWYUF/NA1eCmdjLFdBq+lF0W+sCXaB2eH4XUpN9AZBq32v
 6xvcEuFKDJEzSZBnoyyOR3A+UcNfEMWCWCN/yqUiMgzrlHzFF0JFZAt04OfoZWjX+j7d
 R5R0Rq3emJkGp7rd6oobjJCtK/hw1Qm3/sjz+afjhFsr85vX2Fdz3Jms5OQtbcjheI73
 nkjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+vyjVquMGc4UMznhedR75P8QCJSUakDhBH0jzPoa9QzRUCg5+qAg+y7QFmJx84P7WT/vBNaao=@lists.denx.de
X-Gm-Message-State: AOJu0Ywx13sHqvtptUbUvCrNE0Jfd6QoFvuvtOHhVrIpNMS6kPx139Mi
 cfW5HyYlwYu2mhB6ZVOAo5FC2BmMDKpDkHt5EqORoQGmetsu7G32GJbOMn6S+PWzjpRTMytAfhW
 UVR3lf38hHROy6542lQCl9f66IaJbSpBzjP2bnFrR
X-Gm-Gg: Acq92OHo5VEuOtSx93Q/rVde0ltiB6eF8D+eRo7XOhSBdrWcGgErKPWvScgH1vZZdEV
 hy604/3DV42s0cX36aDf/7q2tcgJY1Pp7e0w6wWB7tGexcUa8Es7r0aHDzVHe6wByekpeC7kUZA
 7VqxLZj35xVe7VDK3KpQXd972n1gtFtuR77iQlNYcC/jJybmjvyW63v/Arobm5Z27cF6B1eEsBn
 WtZos2UXTl+1onYH5K7nkiRsNVSKU/th3w5eI6fDjNB/5D7hBcp8jWZdEO+GizJ9z/J6iz2JnI2
 G6QVyE9fWgV0vFssTKg=
X-Received: by 2002:a17:907:d15:b0:be2:d66:eb4d with SMTP id
 a640c23a62f3a-be9cdc3b8d0mr68997766b.44.1780037934150; Thu, 28 May 2026
 23:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260527-devfdt-spi-v1-0-37db1f6c168a@nxp.com>
 <20260527-devfdt-spi-v1-2-37db1f6c168a@nxp.com>
In-Reply-To: <20260527-devfdt-spi-v1-2-37db1f6c168a@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 01:58:42 -0500
X-Gm-Features: AVHnY4JouDI3efYXpf82Sp0jeEcL8wj2xiCh_acwrJtdHJzch04SEJ6JbSdgjlw
Message-ID: <CAFLszThmW=CTeHAyx0BmQzsjX-6pAH7vvyWG9GfLXgwnhKNrXw@mail.gmail.com>
Subject: Re: [PATCH 2/5] spi: cadence_qspi: Use dev_read_addr_index_ptr()
To: peng.fan@oss.nxp.com
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 "Noah.Shen" <noah.shen@mediatek.com>, Meiker Gao <ot_meiker.gao@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
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

On 2026-05-27T02:35:23, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> spi: cadence_qspi: Use dev_read_addr_index_ptr()
>
> Use dev_read_addr_index_ptr() and dev_read_addr_size_index_ptr() which
> support both live device tree and flat DT backends, avoiding direct
> dependency on devfdt_* helpers.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/spi/cadence_qspi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> @@ -418,8 +418,11 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
> -     plat->regbase = devfdt_get_addr_index_ptr(bus, 0);
> -     plat->ahbbase = devfdt_get_addr_size_index_ptr(bus, 1, &plat->ahbsize);
> +     plat->regbase = dev_read_addr_index_ptr(bus, 0);
> +     plat->ahbbase = dev_read_addr_size_index_ptr(bus, 1, &plat->ahbsize);
> +     if (!plat->regbase || !plat->ahbbase)
> +             return -EINVAL;
> +

Reviewed-by: Simon Glass <sjg@chromium.org>

Not quite "no functional changes" - this adds a NULL check that didn't
exist before; previously the driver would store NULL and crash later.
The new behaviour is better!

Regards,
Simon
