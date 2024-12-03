Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDAEE74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B80289634;
	Tue,  3 Dec 2024 20:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jp7DrOzq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C87B88BFB; Tue,  3 Dec 2024 20:46:41 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D79C989634
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:46:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e56750bb0dso4412571a91.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733255197; x=1733859997; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W4dDcFRi9TMtQePwTEZKn7EN2iWPam1RJ/Wu9pQEF3c=;
 b=Jp7DrOzqODooqcfe7dLUooFB/7ErNUnu2Kfgwei8zhCTEpvpyVXBac8cfYD2NZhzSl
 c3xqpO96Yr/3eHl7MvvRwqLf4U/5BNtT19FKZhsnGOPFWFNv+c2J3IhmTOR7R2nUGJeK
 +HJHGDiMB7xxmXoRoJmiH1HeH5OXDIkYT6Mxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255197; x=1733859997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W4dDcFRi9TMtQePwTEZKn7EN2iWPam1RJ/Wu9pQEF3c=;
 b=FSa2aXVRYHLuif04QWK3IwvYcXAXiVoeEevzApOy7Wc/WPNTx4J3gI65QISMFke7pj
 yRTg/YHcs623pY2n9MyCVVoAA6WlXarWDE5UUz/QqyH41hUVZtG/w2r+PFkMFrLZq9kv
 Y4Ptww/mN0qJnk+erM0IP9HxfXBFd21FZC0kKF1VHjNAhpasrAU7G0+JYMW4wFf6UX3j
 cuAlxW3+jjqF0BZ7hZo87s91siCfyfjRy8YbqQreupYeXfaLfUqdY2VWYKm/tCCaDgbZ
 Ya5ivPpE2U+Ibj092YQblkMD8WfqZaIwO/Xydy5Fmkzq8xbgc2901lp8TgYfIqj453nq
 uH5w==
X-Gm-Message-State: AOJu0Yx+oLwyg8WWo1rftCClP2ioxWmKWj5R3ZGcPQCvjFfeE+q0NYT4
 ZsmySIms9Ik9TGViHpIDxV4WhwaL/tIwhGPYW1iRp19Eg69KRYR6Rcqf9W2pCTOib8O7CdP4RgW
 FBn3UEiU0AhFhvFWXvn8MnsSu+kHMdLuXY6IW
X-Gm-Gg: ASbGncthJU68W7HY8azklnpyWAI5ggkKeRIWy3QGnKamZXhfOwMsg9Fj0FoiM8ej4Ud
 GYX1wckxboWyxxvL3fdLAFBE7U6soOoG7
X-Google-Smtp-Source: AGHT+IGFFAdyiTvWljgpEqDmrxGGfieRXwNylcl4KKvutnkx8+PFQOUHQm9ZUGyQLZRGJZk+jj6GfezPmg7PWoWuKDw=
X-Received: by 2002:a17:90b:52c4:b0:2ee:8e75:4aeb with SMTP id
 98e67ed59e1d1-2ef0121357amr5667377a91.17.1733255197498; Tue, 03 Dec 2024
 11:46:37 -0800 (PST)
MIME-Version: 1.0
References: <20241102221737.547938-1-sjg@chromium.org>
 <20241102221737.547938-9-sjg@chromium.org>
 <e27167fa-5d65-40b4-92d7-27bfcba1e2b3@foss.st.com>
In-Reply-To: <e27167fa-5d65-40b4-92d7-27bfcba1e2b3@foss.st.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 12:45:58 -0700
Message-ID: <CAFLszTgAjrEUhS4s669W7-BVYTKDJC3uVCM+o=Uo9AgSg8t1_w@mail.gmail.com>
Subject: Re: [PATCH v3 08/25] st: stm32f429: Drop old LED code
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Kamil Lulko <kamil.lulko@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 uboot-stm32@st-md-mailman.stormreply.com
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

On Tue, 12 Nov 2024 at 04:20, Patrick DELAUNAY
<patrick.delaunay@foss.st.com> wrote:
>
> Hi,
>
> On 11/2/24 23:17, Simon Glass wrote:
> > This predates the LED framework, so drop it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   board/st/stm32f429-discovery/Makefile |  1 -
> >   board/st/stm32f429-discovery/led.c    | 39 ---------------------------
> >   2 files changed, 40 deletions(-)
> >   delete mode 100644 board/st/stm32f429-discovery/led.c
> >
> >
> Thanks
>
> for information LEDs are also defined in device tree:
> arch/arm/dts/stm32f429-disco.dts
>
>      leds {
>          compatible = "gpio-leds";
>          led-red {
>              gpios = <&gpiog 14 0>;
>          };
>          led-green {
>              gpios = <&gpiog 13 0>;
>              linux,default-trigger = "heartbeat";
>          };
>      };
>
>
> but today the CONFIG_LED_GPIO=y is missing in
> configs/stm32f429-discovery_defconfig
>
> to restore the LED support on this board
>
>
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>

Applied to ci/master, thanks!
