Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688DDCC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:47:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C9724071D;
	Tue, 13 Oct 2026 08:47:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kTNJY3dXrkja; Tue, 13 Oct 2026 08:47:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 348B640706
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791881238;
	b=mcNH97ZV8feoOpMt/JpEhJ1oiRVlOjpffXM5f/YopXKhEcKrRlgYsFDAMNYauS0zkp19
	 O9+zTc29x7mjme/07r42KVNujOhJPLYFuVK/mcy+o2LNjkimNrMMpuRtudfOutNdrVXLc
	 hgROAw+L0G6pwdmAy8nl+ajFzguhNwR7Gc+r5ErKGH+Y1PvYEIqJyghVs0hX6lYLsQdPa
	 M6RUJ4iE/2q2gOCM5WOLBfMMi9QSNJcuF12P9rL4uNc1QgNmzRcxE6bC16wzo9qflmw1+
	 c4pZVBUp912VpVZkak3KTylS0ExIOyhg+GOoP8EeGnYfu6lSRjdkpg0MxewEBlR/lDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791881238;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vvQGixoGOt+NeQpO4hNrQk0QDKpAv7YpnkdmtML6+C0=;
	b=gkOUu9wwebqvvChgWUE1agQ6R8fYyncMqXYCS6//0i9nIpuZMazBIS8sVKi0JO0LrtnS
	 rIeXHTASJzBtnkEYU6BWI7+1wm5cPknScDK8h0s2Xa8SfCxCCKCXUZOLbg2Lr1UpIpHY6
	 qBF/HeeHDx0qDZixptuCLknOBZjRlTpWM3TGu5Z6RJyWEgNY+MOfW0pax3jaPL7C/xN0u
	 LUH5pFrs6xi4csZhPLMJ2jZZUncvaMMIKx9Fhir58bLucXSsCjJZe/gymg9+mTqPPdPPu
	 WUsNxxIuCEjRO878ChsrCKFoVxPA/t65oSbwTMA2In02Kj/dnJZWKLUsXOtmcf5+vkA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791881238;
	bh=vvQGixoGOt+NeQpO4hNrQk0QDKpAv7YpnkdmtML6+C0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UWZ2ZQdAuVbPybQgPwtmeNmJnaGDc65pOWrsZ3XFRWKbquMMhEMvQvuoMAK0ztHPL
	 uGrsKrZAC9OSBJ44WiNr8acpOe5LCW+Asi/sNAvx13b8GZv85qOp3YLc/DAQAolxvH
	 erea+dUFUTllN4eZjj6wTmNXtErT+9zHwZVcnmbILc+hLhtc2H4RmYbE7XyeO8pc/R
	 3XEGdXgAWrZQaUV+ZFqHfBJZtm45FNLXcRh2IaND1r+BmaLbTdb6JiJ+fRkHnm4sT+
	 OKNjPIBH+Kzz5hMDxI26XUmz5366wp3dSRNjmCjIm26eHkbaeFYwWouf34usOAycFg
	 /1lo1Hn4oUOgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 348B640706;
	Tue, 13 Oct 2026 08:47:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D3831E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C99280CB1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:47:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M2Evvw8e91a3 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:47:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EEEA980AEA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791881228;
 b=Zw5MBXmhGIHwxjbu6qzBzKuzSRmSsrruRwpXSU8JecDaOU7VkH/u00eKFQ7UZWvt0dex
 0meac5CCTUQVG4AeLvFIn4paEpOpU9ZJS0VtW448bEq/fpPsSxHZ/N5cML1jFEGkYBW0e
 2QAQ5bA1/sJRFRAAhqdwsB6d8hEY9la9RiS5+SbINvX/WpA2uwiejquJgOveU9O8Boz1C
 es2DwYtVYbUtuLrLX6zjdw3aw++Mz0AwTSfZtjdckooGAGwNUVnnFdTAIbj1jInPPflbN
 CPhtk8g0rPM2LdoZiLKFIjrvkoTv9Z5WROT5ytSpGNjzYwkGrcSrxs11NK/b5/WtiZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791881228;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=vvQGixoGOt+NeQpO4hNrQk0QDKpAv7YpnkdmtML6+C0=;
 b=oEQhZ1ZpjR9e+Q2w4yv++HTIUow2ezSUxk2lKn5rhC8POnmOyZFl+RYIqvjqg44bX+ad
 ipJlBJ8+OQ+0wFtQEnUmpqy/6LTzISqL1+/edotvFRC8Jv8PDtaqv2bBKqYc8Bpqv7LQG
 RExXNeLwScOOFy5eqFgs6wgTwkRYr7Vt+y8w1E+zPNTJWxJ+PL20+PYV6fSWU+LdXgsbN
 74KY9BBq6LZMZ3NSteJ0aiIqTsupTsO58hTIpRiN1izfxINg6KDkmVOT9bJigQjdNghAz
 A8qxdwdeOkIRAHMqe/mOzW7Qfeyz/+57eMz0tAd3WvgpVySv54GUHP13eiYPVfI7PDQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VvWFec5m; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VvWFec5m
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EEEA980AEA
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:47:07 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a0213948d3so16381675e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791881225; x=1792486025;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vvQGixoGOt+NeQpO4hNrQk0QDKpAv7YpnkdmtML6+C0=;
 b=VvWFec5mOnw3vzPjL9rVEKuaTkXjsB8OqPEn4QFpCBi4KPggimZnqXabjsZwOlVKQ7
 aoGo1k/gLBR0XzLehfvDzt+a5+zJMmHGrkwYZOndCQdx2c24IXaaONm9Cfiq2yW+87+k
 hPrBoMMMwIREtxoIOZeM7QpUE2emDa0LQxvrbRR12A1nsZC+ISUYyHtaS4XdxFMsB6FR
 Xw2YqnbPqgYOHtTivgauGMvv7oiV5uIw7yG4fBXmF5n65TfvW1qbTD8dYCeBRNeY7cPi
 drewLanY7qdktuqQ6W9ufb7g9X7xHJ+4g1pLARPDW8vsDzTe8oJEplTg6tKi+pSKnUn+
 KolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791881225; x=1792486025;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vvQGixoGOt+NeQpO4hNrQk0QDKpAv7YpnkdmtML6+C0=;
 b=yrs9TW7LlNcyA8R9ImFzBf/AuZJKLcECxm+zB9cpPUVoxfWdswIBRPQB711X15469H
 yfdHqVSAj26WsoAAXeq9mz8Rpti7C5FCxWK/BsaAVRrRCHTeQytrJRbdpEs5o7tMaeoX
 ladrV/JVGZ8egC1oCfhzHuG7psa9OTLH2xNhZdV31mn9isPdhnygyzdEuuCUUB+M8JOt
 OCunFq5CeAfHEOctSugsDnunTZKKTpg83eNBX/0uiKJqllokMKj1zYUdslQal2k47Vdb
 hXD4OsQvf3vsWx6sdPEUqW7RuryYzseqZh74OsXjgfQHq1c8rPbb3g4D9kt0rqwNobVc
 ygQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxisKZhQKhItMAzDilb4WsOku2AB4P6Lx4fR0kDY3GPJLGfbukiixGvOKpbSWuFScfgVR4lh2I=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLgNuL0ZuKlQwX2+2gLM9G7oQfQ3C1nSMDQcKYH8mSFRN2kqrwQ
 sX3hhQa0v4ZdpLZoomrunwU2VzHQoxoIJbT9BOZe9AXS6GMadBPr3pzS6wgNvnQmS00=
X-Gm-Gg: AYBFou0vE+9eW+ajXj/bNcsGJcQQuag511JxsQFymCdVP70DSAhuRgSvgnHMhsoU79x
 kqcjnlL1qOjyWDCtIlbx2FALxQ/dti7AQiF+pCMM5zJdPZMchNqBKk5J4lCkusfEHADaM21wSGW
 rCMs+rewp1l9rfJ0q9WmKTSELy+WeXIrtmL0yYpXI+S6NVTY2DHaad1R2pNIqp0DgoMYXjUNSDF
 F3nSlSn1haY5zqWrSP4DnSDhFkbB3+cO/h9flJ11+CVO9XBSYHwl0xdaKFTvsQDs2kpd9AAmbw8
 crQDNM2oMGBEDR+Vmb61C+NcPHqWX70wdzpOC9CD88/WG1DU1aPl5ykRpGlAQ4nlb7xWbt/YE97
 UHew/ZjR6J+d6wgtRDmq/S//5iywEfr5th4jsqM5Cm+5EE6g+ZHnUUbCyfSZpYAPXLoxIvctjgE
 1shpJud9Q5JEveQGyQHOsNEeYKhHiOoHZ9yADxU042045+ysXs6teCKjJcuI05OE/cCb+ejQrlb
 kwKzXnhsdIyfoUpoyT8ScFpBQhJnUr2CbDmRzvYiAL5T4RFeOMkm+s6UWnKCOHq8a8+x+5/Otkm
 uUaeMSsHtlvGLQoGCX5QdFHFzK58RIGZB7pz7MU6Y6/f07ab+zHk6S0=
X-Received: by 2002:a05:600c:a088:b0:4a0:333:253a with SMTP id
 5b1f17b1804b1-4a18e49c331mr232360605e9.14.1791881225302; 
 Tue, 13 Oct 2026 01:47:05 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-8278-849f-666b-c282.rev.sfr.net.
 [2a02:8434:7c41:c701:8278:849f:666b:c282])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c85009csm271972705e9.2.2026.10.13.01.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:47:05 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 09/13] video: mediatek: add an eDP driver
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261009-mtk-genio-720-edp-v1-9-4fbcf5b2904d@baylibre.com>
References: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
 <20261009-mtk-genio-720-edp-v1-9-4fbcf5b2904d@baylibre.com>
Date: Tue, 13 Oct 2026 10:47:18 +0200
Message-Id: <179188123839.53105.16613390010590944006.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1791881242; l=3631;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=h8jlGN7XB44MG3N5hn9Ssn27szfBQ104mjfPOkDmwrs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QD6SqzV9PGrMtAXSSpOargvdsnBYAVrP8OCQvT6urZ3ZFYqXGwb+xkn5rOxI3DVEYANLiyRwFkU
 o098kQFpzSww=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

> Add a video uclass driver for the embedded DisplayPort transmitter found
> on MediaTek SoCs such as the MT8189.
>
> The register programming, the AUX transport and the link training
> sequence are based on the Linux driver drivers/gpu/drm/mediatek/mtk_dp.c,
> reduced to what a bootloader needs: one panel, one mode, no hot plug
> handling and no audio. The PHY is a device of its own, driven through
> the PHY uclass, as the in-flight "drm: MediaTek DisplayPort cleanups and
> MT8196 eDP" series does in Linux. Register offsets are therefore relative
> to the transmitter itself, without the 0x2000 the PHY used to occupy
> ahead of it.
>
> The driver owns the whole output path: it brings up the vdosys0 front
> end (OVL, RDMA, SMI and the display mutex), routes it to the DVO output
> stage, and drives the transmitter and its PHY.
>
> On probe the driver powers the panel and its transmitter up, reads the
> panel's EDID over the AUX channel and takes its preferred mode, trains
> the link with rate and lane count fallback, programs the video stream
> and hands the resulting framebuffer to the video uclass. Failures are
> propagated where the reference driver discards them, because DRM can
> retry a modeset and a bootloader cannot.
>
> On removal it hands the link back quiescent: the backlight goes off, the
> stream is muted, the panel is put in D3, and the PHY and the panel supply
> are turned off. The display domain itself is powered off when the DVO is
> removed.
>
> The driver requests no clock. The transmitter generates its link clock
> internally, and CLK_TOP_EDP_SEL, the eDP mux, is the parent of the DVO's
> pixel gate, so it is driven through the DVO.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> diff --git a/drivers/video/mediatek/Kconfig b/drivers/video/mediatek/Kconfig
> index 6e9ad26ab54..f26ce979077 100644
> --- a/drivers/video/mediatek/Kconfig
> +++ b/drivers/video/mediatek/Kconfig
> @@ -57,3 +57,25 @@ config VIDEO_MEDIATEK_HDMI
>  	  connected display, selects its preferred mode and drives the
>  	  vdosys1 display pipeline (MDP RDMA, padding, merge, ETHDR
>  	  mixer, DPI) to scan out the U-Boot framebuffer over HDMI.
> +
> +config VIDEO_MEDIATEK_EDP

can you sort it?  Should go before VIDEO_MEDIATEK_HDMI. Same in the
Makefile below

> +	bool "eDP video path for MediaTek SoCs"
> +	depends on VIDEO && ARCH_MEDIATEK
> +	depends on ARM64 && CLK && PHY && POWER_DOMAIN
> +	select ARM_SMCCC
> +	select BACKLIGHT
> +	select DM_REGULATOR
> +	select I2C_EDID
> +	select MISC
> +	select MTK_SMI
> +	select PHY_MTK_DP
> +	select SYSCON
> +	select VIDEO_MEDIATEK_DISP_COMP
> +	select VIDEO_MEDIATEK_DISP_PIPELINE
> +	select VIDEO_MEDIATEK_DVO

VIDEO_MEDIATEK_DVO already selects VIDEO_MEDIATEK_DISP_COMP and MISC. Do
we want to add them here again?

> +	help
> +	  Enable support for the embedded DisplayPort output found on
> +	  MediaTek SoCs such as the MT8189. The driver drives the vdosys0
> +	  display pipeline (OVL, RDMA, DVO) and the eDP transmitter, reads
> +	  the EDID of the attached panel over the AUX channel and scans out
> +	  the U-Boot framebuffer to it.
> diff --git a/drivers/video/mediatek/Makefile b/drivers/video/mediatek/Makefile
> index 3bd69617b74..0f4eb6b5c0f 100644
> --- a/drivers/video/mediatek/Makefile
> +++ b/drivers/video/mediatek/Makefile
> @@ -28,3 +28,5 @@ obj-$(CONFIG_VIDEO_MEDIATEK_HDMI) += \
>  	mtk_ethdr.o \
>  	mtk_hdmi.o \
>  	mtk_mdp_rdma.o
> +
> +obj-$(CONFIG_VIDEO_MEDIATEK_EDP) += mtk_edp.o

sort

-- 
Julien Stephan <jstephan@baylibre.com>
