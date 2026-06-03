Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375AACD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 16:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A185F84874;
	Wed,  3 Jun 2026 18:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SdpZ0svp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB5B484878; Wed,  3 Jun 2026 18:46:15 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7537F80433
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 18:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84229481d44so1842016b3a.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 09:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780505172; cv=none;
 d=google.com; s=arc-20240605;
 b=cIilKmNARjaCFAG3csArokfsoFbVhAbutJDP+TWRgiDmuByQajHmdH27ibR9UIwTcp
 Fit6mSvaYoalqhFci7mN/rlZ1kRQ+EuiPDJzNBZONaP+DYqx0hBMVmi4wCv/HFlciRJO
 QQrs+7fcKMx1bjWJJPknx4TI5yJ1OzgtaNuDbtzhVDuLH11wsMB0/KJToawqJMV5BYL4
 7MzVcrcrMxz7tmEO4dL1u28uu/5GICQTdESrn5VhVPmrg4gyUiAU+3eBYRW2ga6WYzs5
 GdAk6JKtP7WMOP7xF/YxB9bbSEemjMFy/MCIf2/OczV09XD4AGD9F760Ezn+BTAzXQNw
 K5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XlPE0+CX65qzy+eOlRDYvJMpPpK3Cx1wKI1IBFGilBY=;
 fh=3vbYSVaifU3E5yjV41YkOEuRcfdK8Bup9NZXioA8VLI=;
 b=NPrmoBZqHxd3NAeWtGfEckPoM2SD5hwM+oWvoI3p9KLpUOXArj21ErGG3Hjeyqd+Vl
 hIJPrsnfYP0uJ+XmuCeL8zbntxF09w6ehXac422yoVLgVyrraBinybU8eaapH1gFP+Fw
 5ZGyrxQ1G3J1pcTq1aPq+4z02/I501FOTbWbrfnF96GDwmm4eLCfHKCiHN4jfarXhA0m
 UQDrnl9nVtosgOG/DdFWEv9xenhhrPoXOVoB7HHYujy0tmlGkKh5SmNX0FELKRPmoNL3
 GZORF0u/Wt6ll0pVBDjUqpMhJKU0y/No0tXWDec0dILICTDTt3v1YJz5N2OCKVRzq0q4
 iDDQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780505172; x=1781109972; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XlPE0+CX65qzy+eOlRDYvJMpPpK3Cx1wKI1IBFGilBY=;
 b=SdpZ0svpMOBfC2ggDBeff9zjfceX8LuNPVSrwWxWVZxBKbyEnMBDt2puSh+iz/Tfkf
 Amt+MxIPBfqM7nLdyx5FqUHu/JJoekI5of2lkMBhFr0HcVQz7fsAtLN5TBLYEkGP1nxU
 0qoGN2hp7virA2P+hjfw8e7VOeLlzz9ayKCTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780505172; x=1781109972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XlPE0+CX65qzy+eOlRDYvJMpPpK3Cx1wKI1IBFGilBY=;
 b=TE6q52y6Sr39Kem8gL0X2KPwn/Fo+GiBvEFsdEL1uaG2YSk09yaIPp5iOBqho/Szam
 E3NfET6LXMJvCJRwVRSCc5bn6PRxdC9YZ/1IAApNXz0t7SfAocv5YFKORu/xvhKdXRZH
 YdEEfyPfUQ7BDOiMknTXfFrDXzALuCQGeBvbjUwlQvCOB04gGbtYVhXJCVwChVtgfBMm
 7LSxy7O/bQSL66UFaXUOmeooWp8dH3pak9REzQbrak62SlA7UXZqyTc4NuuNmHsydBLg
 Hgmo238RHf7AwJZkpGEEoXY8ZWKGws/icMbpgp3x2YP/P7knBB0vV+WQZQYYrKAvERgf
 YaHA==
X-Gm-Message-State: AOJu0Yzgbul+UNHEzYWHt0iqhv/7lzIcztkYGM+YbRGfs9jIDN1zusX3
 OW8iVfTOP98bJO99mcYEIgQGMqHG2ek0tpcSxwMtShupxfBdOS/Bl73K0mYdm1G6g4KAFmuq9Yk
 1m1QFPQfn59+UgSKm6vnD8Pvj2JJkfWZLuYFDQQRJ
X-Gm-Gg: Acq92OESxZGluUtLYrXnz0e/c7xwy1pAGVw9hHjrmZFsp6QRdcWiHVH7skz4YiTgFZj
 4v72Y3UCVAZ9B7TI9OMt7JdY7D2W3YAa/FouThvAfxWnKjZH9Sid9Nm7QMsIsGxbMroQG0jgIgK
 kachJn1e/YKWeNEFDXiyTK/3cW2HfyaCZo6BvOicap7Wpza+wiMLZaUIAGUMcQzVSL9usxIKUw9
 tcnh9ZWt0af+pQu5jwHcDON7cNsFyV53La8VXkMC//xMmYkxVNp1YfRhdUm4+4WyKgBA/XeCj+E
 pZbaEmB8X+sQPFxY
X-Received: by 2002:a05:6a00:b56:b0:838:a46:ce96 with SMTP id
 d2e1a72fcca58-84284f5f5b7mr3979302b3a.27.1780505171930; Wed, 03 Jun 2026
 09:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260525235155.96167-1-marex@nabladev.com>
 <20260525235155.96167-3-marex@nabladev.com>
In-Reply-To: <20260525235155.96167-3-marex@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jun 2026 10:45:46 -0600
X-Gm-Features: AVHnY4Lk2zFqkghdELWGRFJ-yi4GyGPGTRyUUkatQmN64cjonoESFnhkTY_9l9k
Message-ID: <CAFLszTh566_3bNimEfbuGs0ER8Mq5XuXYsgQ44_dY6L0g_RiFw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8mn: Generate FSPI header using
 binman imx8mimage
To: marex@nabladev.com
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, 
 Alexander Koch <akoch@initse.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On 2026-05-25T23:51:02, Marek Vasut <marex@nabladev.com> wrote:
> arm64: dts: imx8mn: Generate FSPI header using binman imx8mimage
>
> The binman imx8mimage now correctly handles generated fspi_header.bin
> in its imx8mimage etype. Make use of this, remove fspi_conf_block in
> favor of generated fspi_header.bin, and configure imx8mimage accordingly.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
>
> arch/arm/dts/imx8mn-u-boot.dtsi | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
