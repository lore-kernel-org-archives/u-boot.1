Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A06AF3ED4F
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 14:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8D0B8419C;
	Sat, 11 Apr 2026 16:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jyn9yvg4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E0518419E; Sat, 11 Apr 2026 16:58:46 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F4884118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 16:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b97f9587e6eso397680266b.3
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 07:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775919524; cv=none;
 d=google.com; s=arc-20240605;
 b=dw0Jm4KMnrPO2M67QVUePlyHivPCU/T0waepmJSAyJL/VSnDZzVS4RMYzWz8p2SAyu
 Hl+PGAnOZ1P+jrMCcBRsdzuc3ICZ6GUx5dZ5PV5eCOVRJEWXq7xjMSoTH5qTsv8Pm7B6
 GYjV3YpUrA97V6y8FaYxiJf177tNll2t//PyWeajoIfWBoSkbzWXRItdr4tjoO8baAAp
 lVes70Byk2QAW7SbAJPoXbkizRd2rHuan4CSbpy9F7/+kjU0oNLUZcEpOm0RN28dfh3T
 +huYoLHrJHwlng+7a8Y3wcUk222aOAEri9WcGcd/mtSWZ3Pbd67F96r1vhW95H5h52SC
 ecEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=C+L/dz1mtXKl8SeIkRJN/gsCMXJq1AIlJRj6CSEh2bA=;
 fh=zqgypZo7V5l1Z09kqIenDlLd4mYts5FYV4cZ78J1pho=;
 b=S5XU9bvcR3D8WzKu8ef6sAw9p3SfMAofdIs81rxAWiLiSuxZYozArdukCr0ksIJciT
 xD9pHGBKY7qhwCper+4rbE55CfsCBHbJlvjcOwBpJVIuBXvshLZo/SpsReXUuqMoaes3
 fbeRy5yZLbWaWkEyUQ1VZYpLnUtkvdg10OLWRgFQ8UPebjNEh09ieiocQBaxVzvJggCC
 bmuDDp5D/6tzaUHQQHxZRh1yI0W2jxGPeQtwbkhDdEvJK2/YigI3SPWO8DcvndE8V96X
 aU8la7+Ym3SoR8zWI510FBK49/PjPKJmZp9t+QLXJ8Bxp+ZOS1f5Qt8XQQfMGebELrre
 ojHg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775919524; x=1776524324; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C+L/dz1mtXKl8SeIkRJN/gsCMXJq1AIlJRj6CSEh2bA=;
 b=jyn9yvg4BvryEsERRPZMjvb6b15fMnhoW9Q8LfD8iZhNnv56lgU2z4+am+LaYeHrM5
 wOHkbn68P/Sh9Lqq7ZbgJmEPZp/B1yzMf+q36X3Uneb5l3zL4gu5duFLSma7i83/pyj9
 DEGgx+VNF79KFr3CJQsK3htIvIs7Rupk/Dksw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775919524; x=1776524324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C+L/dz1mtXKl8SeIkRJN/gsCMXJq1AIlJRj6CSEh2bA=;
 b=W3LD3FWStCNOYLsjsazoSjzbh/YR1R7+2DrFbCEBCP9HmwY0EBsM8/ZUogIKn8nlvB
 Z2Iq5m1QTx4VdXrb010Jzdtuc0AzrJ5Nd/N+XvKzoY6aB2rW5SpUHHcTiAzrjTWbjR9u
 oIkdxaXgFElOvdglWrUmrVfxiu/8c440Z53HdazQFjib8oeBjhFPH2krZSqApKXEUka8
 l5W2V52xA31u2sWX9xJb6+WTsXMumYxNOz5PyQKcFk/nTHmatyH4F/AlWBIOw1drwAnx
 qTydY73eF0r/iJRn42D9RvQbRO4qp+woJfVCvblrmvUZBnSIYMppWx5PQZvpAqb62HGp
 ARbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb/UYgb5Xh/EF4h7qo4Bu9busgTSEQT3o25XhvhAPMXW/rSvm/3SRFNVVECx1Lyep3lAoI108=@lists.denx.de
X-Gm-Message-State: AOJu0YzPW5NBOmfwHZq/rYBBM4EsXa2owPecN1cAlxOlRHZilE0btkv+
 zXZDOwBoXGu2/Pp6Cf3T5nrP+a/eJJitogFCABL4+b139U5SnwPbEV+lXOpKexyuzDYEljvbAW2
 XfF2IaUch4jkdMv6g7659YPTd909FHsGGPBgiMpy+
X-Gm-Gg: AeBDiesfrPbuJLjSBJ52OUd4WmZA22YW3PTbAUKDDO6o8hvsMjBxyopiqo7rRhTZHa6
 MxH3ZZgHh+tTK7MScl4wIWtagYqgQOdzXZy4zYx5+ls0s0ZRLBNN7J1rLi4eIqeW56+8G1W+RMN
 fTuFZYjmTabDrWrWfhICibXI6bSmRtgx2Ya0F91OdEWUKaW7jC4FZ48chuz/dSFjCrTOmX7qNpc
 WgB38MI8tP9ZHbKkNgqu7d63j1g8ws50YxDa1ngFdjTMisCXG5g8eiByD4dXkh5y0LPYothmVId
 T8eN8PdNPL7Vz8tP
X-Received: by 2002:a17:907:9452:b0:b9c:7ed6:df70 with SMTP id
 a640c23a62f3a-b9d728322famr423790366b.44.1775919523626; Sat, 11 Apr 2026
 07:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260409133303.31875-1-ansuelsmth@gmail.com>
 <20260409133303.31875-7-ansuelsmth@gmail.com>
In-Reply-To: <20260409133303.31875-7-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 08:58:30 -0600
X-Gm-Features: AQROBzCMpTW15jGl42c4MJkLLDXZ0UYzgMSUVhaCyyAcTgH28pbBWtjOjE_dVyg
Message-ID: <CAFLszThY6ioJG5mJt+13j_9_kqr7dJeXTg7LzSACWk-owGNmPw@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] doc: dtbinding: Update documentation for Generic
 Firmware loader
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
> doc: dtbinding: Update documentation for Generic Firmware loader
>
> Update documentation for Generic Firmware loader, generalize it from FS
> specific and add new property and example for FIP loader.
>
> Also add details on the usage of 'phandlepart', 'mtdpart' and 'ubivol'
> property.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>
> .../misc/{fs_loader.txt => fw_loader.txt}          | 29 +++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)

> diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fw_loader.txt
> @@ -1,17 +1,23 @@
> -* File system firmware loader
> +* Generic Firmware loader
>
>  Required properties:
>  --------------------
>
> -- compatible: should contain "u-boot,fs-loader"
> +- compatible: should contain "u-boot,fs-loader" or "u-boot,fip-loader"
> +- phandlepart: which block storage device and partition the image loading from,
> ...
> +- mtdpart: which partition of ubi the image loading from, this property is
> ...
> +- ubivol: which volume of ubi the image loading from, this property is required
> ...
> +- partoffset: valid ONLY for "u-boot,fip-loader". Offset of the partition to

All these properties except compatible are listed under 'Required
properties' but they are actually optional, right? Only one of
phandlepart or mtdpart+ubivol is needed, and partoffset is
FIP-specific. Please can you split this into 'Required properties'
(just compatible) and 'Optional properties' sections?

Regards,
Simon
