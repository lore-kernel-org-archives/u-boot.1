Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8DAF94CB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8228C8419C;
	Wed, 22 Apr 2026 00:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H6CQgHu6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E1AA84353; Wed, 22 Apr 2026 00:51:44 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AD198419C
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ba6b39871a3so482132866b.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:51:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811902; cv=none;
 d=google.com; s=arc-20240605;
 b=HAJ8aT8KIYJsV7SBmOQZQaU/8DDJ3azOR/QIXt455FR7qOIR5P4x5yuFXsOkWLreIn
 4dOClAmw04jDl77zljqVDK8dMHLwxZW7ND8jDB4ehMMl0Uc9jGMbWaENaCuRQMaXjLTB
 FfYs8WNkWhTGVwxdzbZOrGVX5Mr7fC/9l2rQt7xJSpsN8xUoq0KKldZ7VStros9xvtzN
 jC5xMl3pgMMIn8tNxhbJ/lj5YNkI/sgP7pUzCOx4UEfAHwe9FOcqbT4vD4/JWhkJmQSo
 d6p0PtyMPsm3no68Jonx4wg7Q2AgAYw6rQgIESs+v7vAeoucQ/+ibRgo5jA1JIruCoTP
 AKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=P4IhN9RfagnrQKFOizES+F2JLdbziOil8wFMjVgCMaU=;
 fh=T79q7iQaKgdBLSTuhvl3jRYD2v6g+8MB8Joags6q2NI=;
 b=COui6sM4sgbS/1x6/JPEKSQ5eV6UcGB6F6pB1n1WLtg55zpYJOIwLjGcfpr5IaVSEG
 nkk7hJn9xE+U+ImyOyzrLuLNCiElSoqgz0hD9ckQfX2kUyEKTxkrHWu2mHqpezEVt7Ir
 BtRqPjrAkcVoOHW2r/pFnAP17ZPaGbKEChLOGhDzSEZ9QzhkZpJYt1vK808jUtGQSLjt
 k48HSubp0jMMm5566mWmBjJL504YLqmzvXM68/hnWGCMWefTHiq6lNH+JviEbpYwEbfz
 cAX0AeiXTywi9DNlVeFueusoZzBhO3btWjt45dd62khqRMYcPPvtcCE3aQ1DfK6i0y/j
 jiqg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811902; x=1777416702; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P4IhN9RfagnrQKFOizES+F2JLdbziOil8wFMjVgCMaU=;
 b=H6CQgHu6EbhCYzG+/XGArz08FAh5G4h+uWBxNZOg8UK83rHMdBaTP0YQkIgaCeiGtY
 GfdUN2T4rivFdeamoPSKeubCo3QxrgEi+4lh9FXek2iksEAQm/LYIs1vsWOTlEZTyoqM
 rTDv+Ut+C7AjGEpevtRVpfyx93sZV5MVoywVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811902; x=1777416702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4IhN9RfagnrQKFOizES+F2JLdbziOil8wFMjVgCMaU=;
 b=VmiBtfdslpq1upQJ54W+nUQcqkRguo5ANwZ3KI5PnSUJS+xLoyLPkm+TImhdli0IdT
 e91h/jYSmWZ7mc/LY4ixPXp5zb3bGNLfEyZ0xK+u1a04kpxHh+6O02Nqq2IZIXPK6AGj
 yny1nxVG+ZH9mPQXVwN9sUzqVwYyTG/FyRrAqjNcLVYfsLleQf4Np+Zg4CSLpxvIp37e
 MBRUFmCPfl2uEAEXY640hC/c3SgClq8cRIJHYMr6lELD6iPt0in5qWupcpFSL+vltzsj
 RgGoYvWeGNLeECSMdYFOO54mvmtvWC8gE3eRjB3bTckhsMHsRdDMImgwTsZp3atgqM2Q
 vgRQ==
X-Gm-Message-State: AOJu0Ywp5oWoaLRRu5CD3yEyR5ygZL2+AuXZhP+Cjffp2fr+f7wwagp1
 Abm3pkl5kU/s7fDebykX6+Kav5wxvtPu2TAlWYdZkC9QLQ4agXJs7Al4NHjBplY2O5K/qnSKIBV
 10B0oJ9FuF1NxeWzT693Zp4b5q8M8fBTfc4aU1mn4u7oevRF2RuAJgg==
X-Gm-Gg: AeBDies88w+hZ46fstlTxsVSE6d3NE64Utfuc0OtGYTAR/Ui4fNmoFIlIJLcTGdxm23
 1M8eR2hE3wB6J9y+zsge7Siq12JAyUez0SPzncCsk7UBgYQI1ak/ZUasJTieof+QsXmcdUUrIp5
 FEKV+gh6xdYFitsEpfQjILOwtZAH9FdCwYuwUoeb8cmn6HPu+J/4euBhWbQHZfLPSNYjAKOvs1T
 3IqmApzDG4GQizOUdYeStDzPJDJ23i+RKBq7hLEtHPWlDq7jh46eE+YY1sy3BPHmjhFERcD/D/1
 Q9VH5jMNsxBz5RIowxq6
X-Received: by 2002:a17:907:60ca:b0:ba7:41d0:5efd with SMTP id
 a640c23a62f3a-ba741d06392mr537410866b.28.1776811902003; Tue, 21 Apr 2026
 15:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
 <20260421-ten64-add-usb5744-v2-4-eaa81288e393@traverse.com.au>
In-Reply-To: <20260421-ten64-add-usb5744-v2-4-eaa81288e393@traverse.com.au>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:51:27 +1200
X-Gm-Features: AQROBzBXkq0uAeg8MxDO7lTv7rAYXpan-beEMvHKf2_d5N9LrKkSRZkPtW0qt5M
Message-ID: <CAFLszTg1NbikHY+7P1kMGuFvuaisGPaGVxQamwR-YPT2Sm05fg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] configs: ten64: enable OF_FIXUP
To: matt@traverse.com.au
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Mathew,

On 2026-04-21T00:04:33, Mathew McBride <matt@traverse.com.au> wrote:
> configs: ten64: enable OF_FIXUP
>
> We have added board_fix_fdt to remove elements from U-Boot's
> internal FDT related to the USB hub, so COFNIG_OF_FIXUP needs
> to be enabled to utilize it.
>
> Signed-off-by: Mathew McBride <matt@traverse.com.au>
>
> configs/ten64_tfa_defconfig | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/configs/ten64_tfa_defconfig b/configs/ten64_tfa_defconfig
> @@ -21,6 +21,7 CONFIG_FIT_VERBOSE=y
> +CONFIG_OF_BOARD_FIXUP=y

The subject says OF_FIXUP and the body says COFNIG_OF_FIXUP

Regards,
Simon
