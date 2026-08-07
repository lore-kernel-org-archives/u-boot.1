Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE54C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 14:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DC1481324;
	Fri,  7 Aug 2026 14:39:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rq5Yq_BC_mlS; Fri,  7 Aug 2026 14:39:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2189581312
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786113554;
	bh=1iS0hdeRtIISdLk+f+PpexeMgnd2mO1gM5IjHdcigak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o7APtnICiwApxWQ4U2DnsYyksaXuXJEWTuaYR1TzS8hAhNjafe68F+A0x7iA1N/Rc
	 M1LFGedmrXBR3PQZvanUI/QcFf8/SVcKzg2pvNCh8O3UwdJw4SFuob/M83f7cnh2wz
	 ecF4AP15U/y4+Z3pA0UTLtwzvfgZX0IXCC1vMouZxGnaIGeFXvBUaZRZRd1r6ByCZk
	 iQcC0n6zkR5ncXbsppzmfGpc4WlpmmCM3U2kfWKmuTfMWOjerN1126lG5etb3JVqe4
	 JqU4EeV/oYGh0qStIUFvvO26dSl8biCry0tfwKDirrSi+BXJ0MWtPGibPJ9J1Y6T2O
	 37dpdMSnGxQmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2189581312;
	Fri,  7 Aug 2026 14:39:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 33DF7D3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B8D581312
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:39:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XGnLt7Ks-95x for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 14:39:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8177B8130E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8177B8130E
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8177B8130E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:39:11 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c2022323c37so435574066b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 07:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786113549; cv=none;
 d=google.com; s=arc-20260327;
 b=jUaNwF1VTSK9OxqBQb0d6hxQ+W5vdpj1wGmVTo45HesFTBODc44+8Uv6jmpk9ba/Al
 sGlYI8pZfH6RvwPnLWA5tEqk2VDnjV41KUED37HeTV3nrS7ELqrZkc4Urr9WZpZbWMRF
 EC7Fu5igvB4nfPIbb3kH0fJiVXk4DED6GO6uznOZucfP/e2V2PZfpHpVre6Zy7YUuXkc
 KfKkF6OyZUGi2ProxjY4YI0nBIJbg/9ELfUb2RCLuKSoY/8lOz7zgWy+XVh3LlyOBWDk
 EP46MVZW60BMorQFnj9m/+4sBozx30cFcrIZfczniT55wOjnLfk6Q48bgePhFIlE6mXs
 XMCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1iS0hdeRtIISdLk+f+PpexeMgnd2mO1gM5IjHdcigak=;
 fh=zXhEIU3UMspTqpr3LqygWIWAl24d9+TJeUB26IqYL9k=;
 b=k3ynvqe4YVFW729c5Irir+caU+BITp85arPKFyaCE1ZOLUj7B1pzjmlaZhZUd8zF1J
 YKfz8AGOjqkO3iiX/oaleSDE+mJtzAu0qQU8Ht5u5cU8AFjNtFZGwr7Dlkn04DQIlR1F
 fn37FkzEP91WDcd8k87GKzVbTQt0/prY8BH5Liyas1CkxuoCmGtJa+uPyJDFgInVY5ag
 MPZTrOo4DNo6QqzCEF3KqKr4FzhoVR1jqjygR5qvPFLbWj7z3GcjlG7yfb/ZWgJqHjzN
 2JD8M1kVhtOAM1Oq1FG3YzDz1qkEBBt2xjzGQUONQYj4DvXJ+rcmdTWi6hV8BfFEe5WY
 k8kg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786113549; x=1786718349;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1iS0hdeRtIISdLk+f+PpexeMgnd2mO1gM5IjHdcigak=;
 b=S6AIUzwyIECIbDPVu4SVkeVrX7JYfCy6QRfLJ8rpv1qQUGr/sOWCySoo0seeWLYve6
 ljrxdXeBaggU/gsdnULre0vAJw1QT24qQ6sSrS2t6BWMijQdwqAsK+xlhu7WlJhwV0BR
 tBZwqphHGnh+ROj7hP3A6RDE+KJiXWd3+bdBPKfiJYvcNQJRJfUDDaweznpBN1Dp/Nx8
 MLBd4LEnIA8OI7DLc3XCMeDLZxJWp4Ktc9N3JoAUeP1SPxX6TfWOaFYdkNpLm1aXGMlN
 MHf2t2OM1ivS0lnOCon09rHs0cVx7Hv+eBIYyIMmg7qSTGXyf3f4I7C4eWg/FhDATJxp
 VCrQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr85NE9Zs91W1N3hnDm6ubOMxQ/YgD2qWxc3LEuj7U7sF9snLfv3CH5lfKhuTqegvTrHt496uE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzA5JnfQ3HGONw8i+BlkGUiO3zHxIfG0ZvOJ6BhTBUc9k4sAZYS
 nHM9W9Q08KXLj1TfWUQ8vyESfvi9fP9ikhlAOUUyX3L4DSl6prr8y0qEdsoq1IvKTHknCPcTBQ0
 4z6vP4CJO8ZAtTu+DUPbOuWaMKJ66HW3hxpurzdwahg==
X-Gm-Gg: AR+sD13sjCNyeoVkjW3kw4cpJNQutuskqUQRo2vDXQxwB+8M/yn+zogMuwya8vEufhy
 /XwYicJCBZw4/AxIE10mpuLD6xL0HSBkQgMFx+hKsXdNLF3h+2ehKK7SKzWIdaLe0Ypyvp2f6O+
 PjRswgh3YHp3xR9WB3fzcWfimnw2nYZGh4VKUjzotDKoVXBJZy+hlw03P4vFV3DO9I91mtmM3ZU
 ta7NUaxYnugkqed5pXN5Ms9Ejiypg/GYf2fDvlgwH7ICFsK5xgDYHbNb+dpJoY6xqXif5x2Q9w5
 JCU+GiNnYpSPKQnsd25Y19lmi1+fvqgpbTKe3gLcnYJbMdh2nNRL+pONwiGy41eCBlSg1drVUMG
 NAQfGMO5Ovr1x9eVINBrTNlqupH1PkEm8O9aXq+YwtcuI+WCm9seuMUU/pVAZR8o=
X-Received: by 2002:a17:907:9303:b0:c16:6a42:c7d6 with SMTP id
 a640c23a62f3a-c20731e111emr450834666b.9.1786113549017; Fri, 07 Aug 2026
 07:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260804-mtk-pmic-mt6366-v1-0-f3b36b8a1a47@baylibre.com>
In-Reply-To: <20260804-mtk-pmic-mt6366-v1-0-f3b36b8a1a47@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 7 Aug 2026 16:38:58 +0200
X-Gm-Features: AUfX_mydecvwV-lBPyzD6GtDmKliW86MsPgMCehF9QSBm3jL7POP1weBEJeYMqU
Message-ID: <CAEHHSvbkRBs3aghMwcUT8CzCOxTZXjaiG4a+wSzSLLSNcjfxQw@mail.gmail.com>
Subject: Re: [PATCH 0/7] power: mediatek: add MT6366 PMIC support
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786113549; x=1786718349;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1iS0hdeRtIISdLk+f+PpexeMgnd2mO1gM5IjHdcigak=;
 b=Dif/s9j6ugWs2CF+npWAx/WnhmbywSGoYp5deFgmh5IdAo4ZfWzWc/diR9z8tRDsKe
 w+i3KXfGMsqD1mAFyG0srHACyAiRkvg1f+YPH4NV9eiKaVjejB1eJn6nYX+DIGxI3XED
 jZThSoDhQEBZNe5Pv4v/2la2mE4BjZ1aFfMyiSYgoaYke/tZLgpwp34gbqd6kSsfjne9
 9KoufE22xD+dgAdaSYZwzran16VpAp+HJcySgBGADcZux6XiNQFI5WmYvG3ND7UEBuUG
 A7k1PWiuzBye+kjsUr8AhB50b79AdynJQQ4mTIXGr1iiNuAJukoTBCerG1d+69GfzNv1
 YHUw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Dif/s9j6
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

Le mer. 5 ao=C3=BBt 2026 =C3=A0 00:32, David Lechner <dlechner@baylibre.com=
> a =C3=A9crit :
>
> As part of bringing up Genio 360 EVK, we need a new PMIC driver for the
> MediaTek MT6366 PMIC. This uses the same PMIC wrapper as other Genio
> platforms but the PMIC itself has a different register map, so gets a
> new driver.
>
> This also includes all of the devicetree and config changes needed to
> enable it on the Genio 360 EVK.
>
> The patches prefixed "arm: " depend on the recent board bringup series.
> "power: " patches could be applied sooner (no dependencies) if we want
> to split this up.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (7):
>       power: regulator: add MT6358 driver with MT6366 support
>       power: pmic: mtk-pwrap: fix clock names
>       power: pmic: mtk-pwrap: use mt8195 fallback for mt8188/9
>       power: pmic: mtk-pwrap: add mt6358 PMIC
>       arm: dts: add mt6366 PMIC include
>       arm: dts: mt8366: enable PMIC
>       configs: mediatek: enable PMIC on Genio 360 EVK
>
>  arch/arm/dts/mt6366.dtsi                      | 273 +++++++++++++++++++
>  arch/arm/dts/mt8366-genio-360-evk-common.dtsi |  23 +-
>  arch/arm/dts/mt8366.dtsi                      |  12 +
>  configs/mt8366_genio_360_evk_defconfig        |   6 +
>  drivers/power/pmic/mtk-pwrap.c                |  92 +++----
>  drivers/power/regulator/Kconfig               |   8 +
>  drivers/power/regulator/Makefile              |   1 +
>  drivers/power/regulator/mt6358_regulator.c    | 371 ++++++++++++++++++++=
++++++
>  include/power/mt6358.h                        | 130 +++++++++
>  9 files changed, 848 insertions(+), 68 deletions(-)
> ---
> base-commit: 5e3d0c7cea29c6d31493af34f21ed6c3e30d0e80
> change-id: 20260804-mtk-pmic-mt6366-fd63c609df2a
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
