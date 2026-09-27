Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B487C98332
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 15:02:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7337D60673;
	Sun, 27 Sep 2026 15:02:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jLwai41fWIPK; Sun, 27 Sep 2026 15:02:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 97AA960633
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521347;
	b=NsVaYMCbsugN3NdqPqMO/f0jNAR4ehhN/oIQfrXcfSzLAyQlfACRF5whhMMnc+1cDSak
	 Sc3wjOyi/7BSPQcD17WnKfIhoprD9EGndjFbGJ7YBrtAn/irTaGdGGIQ2N8yMoO7YyPH2
	 fPasfbzfn9Kodp4MMShD4jYfk5lTsm+yuNs2fMxQk5WkpmTRJqXU0ur5tPVWZTnPnQmrD
	 7uSfl2yNfzUWK/FMmwLYjqyyj6GQOzkbfgRh5UJGSN5FsuFwFkppNs/lTrHkRYmyqfyEU
	 v+fyVIWKQqY99tkzX9JP+Hfsr3/TkQ+W2r14lnZCncL/fZFPg9kJfqvzIR9z28WaYNg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790521347;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=IDybEWpfYkwmsyUhJUTx5pCtZuOZj7UTkjzX8yUrrWg=;
	b=oUhUQAsIHgQbRd+hpnLewsShydFD/Eea6osFaHeIZjvZzHM/3SxG2Lt20gu9vL2kgbUF
	 onkWysG/rJnEnJyl7H8HXLVV6lYNV4vhRl2op5QEP4WIlkNT1kA2VSJrXrXSRV+R/T8Vb
	 2gLK+NczaffApTN2uoLgmxhYXzWvKQMcNONV3V/TZ0xBBdGpe6rKEQDy/5F764xwkkPBp
	 u0Ggp9WqoiRwS8RZxX3CNhS/waz/duY/Tc1U5otOVPZBYhMT/cSB7zteLbBDzeJnfGpSP
	 khpLJ0ER4oWV4F22Vr9vuUELPLWUUi2l6tNZSAB+joCKK4S9d5qoPUrIssN3GrNP9Ow==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BZLDXugY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790521347;
	bh=IDybEWpfYkwmsyUhJUTx5pCtZuOZj7UTkjzX8yUrrWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yEEhqHIjj9ZYa+5CtvgH5Aa2Gi1/ZZCSpcSWkrmUHzw1N4Z5y/Ahzm0W5Su1+RlyW
	 +63jYmkeIDqcukwi2KerGntwKG1S8C5LZLWsjZctlymwTtbdG6BKH9nRfXHatjxTLT
	 VG4WzOcduZb1tm/4gdz+w5mPqdgdlwUdgl75DflRGYHm0zIsBtCr5RWehq1DbUqOsH
	 QZtspXQlY4+069OWTMaY2hTivXgT87s2XyhYuGh6FjmDW0bNLFAYvIhGYl699KhFDD
	 xvVsz6iL6ix/+yG1n8+zAugGlH3stZGxx8VHQRT+tN90ZOTzDG0uLl/R4JdKcxxcuo
	 sI2tr0j40f/Iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97AA960633;
	Sun, 27 Sep 2026 15:02:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DF56A72
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:02:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C565160633
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:02:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id spNjJ5axnCQa for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 15:02:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AB66360619
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521345;
 b=ESlNfUIBBC/jNpcFXx9BrlQIRwMpsNVuHPPTRJO7MZeFH/TxdCKc7H9Z2XzmUxkeW1EB
 +tJ0zDw0ZyreTZa7oF6aXT0Ii91xg54QlDYLbp3w5YloCqFbb3qlle+n+ZXVzdXYA81v3
 T6g9QvF4gkCOCdA/wgn69HWuxbZubvcFAuNIUiGmC9Uv65qXvvYmMe/fC0tmZfiZaJ56Y
 dXYAyCamu86MIJCQntQHHNi6gI7DJSTUwMN4A315hm2Touf2OxovJxDXbctTDqr6pdzSC
 8c36t2f8K1+cz42Gmff2TZuDLg/SvYZ/HwMXC6yuykY/t9ptc8x3Eiq9ozn9DL/bFQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790521345;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=IDybEWpfYkwmsyUhJUTx5pCtZuOZj7UTkjzX8yUrrWg=;
 b=a6twV/+qut7Bwf6NVU/b1hCAx5tbArnVzMP8biAS7ShcuxkJnHYNScY+H4PvPpaNgKeP
 i2lvoryzdWKuzfqDnuANKelBXWBgw40WlMiVnEgJYN2OsSPN7kOIMXX2dOAAmycxvj8Yh
 yG38xRpnUohm/BmyVY4LdOAqAuwsthRp9qkEQnDvMoGsgDeX9018XF8dlZd6smJfAgmTM
 pskrA0+s7yOVVehAn6Y0REgr/1/Tuy/U/uuXqGGDse8GXUOLakzQQaO+r4iYYC7CJykGS
 FFIcuzpHGSGghSd7HWstodzE8Z0p82DukQVu6lHXYsNTPCvEp1vHvQ1aB5tBXPm40QQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BZLDXugY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BZLDXugY
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AB66360619
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:02:24 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6abe19c4262so936080a12.3
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 08:02:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790521342; cv=none;
 d=google.com; s=arc-20260327;
 b=ky7WHjQCH7dzpTi7722AXkNVFrji9gGs+IBA7qk9I95/2rU11wAALBj8i1OYuzAKCz
 b3eMBDENGnzW5sCRWrU2H0p3pGHjJIe/aQcYcMcV5ygVmDvzKi3xbkbTdweYZLMpmISJ
 lMeBpHuRMxTFZ/Os2U+UgPt+b0g8Vq2F9yfNMMu+aL7j/fIFCaRpGVQ0phdHhZs6Pfbz
 j6ttn0GgeNnlb7O0ziTVWGljaHF9GjNRQ02GpYlZELBGTzlweXT2iLLAtuqP5omjxlPg
 Wm3STOgx7JkZEQ3gZG2xcze41OEgU9Hywdm8aVdN6bNbbSv1s9kpY/dxYSFYjk6IH/64
 mskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IDybEWpfYkwmsyUhJUTx5pCtZuOZj7UTkjzX8yUrrWg=;
 fh=gM6xwFYHAHEYhwfnwb5GA6JCXhQT8YDCp6c+ILn1MfY=;
 b=FeY+jkPJp0UscE4E7mFY+UqG0GPAnCZw6/gwcfSstIcAE0AmCVW1XyzrdLQuqu/a6X
 IkeAqCgXmQOkgf3gCpfrcpPVv4TrRhpqc4x8hSBVagFo4nwqeJYM/+82OpguI9Wy/u27
 EhLqWj/LSTsxIZSTM3eT8WNjzKDU7HvtGDxQd5q57dfNvrxxXkp3JZa9fy5k5l+8BkMN
 6rsBwdYHYF5B38vavPsgw6Vu0wTdy1++hVEB1xDHvbY56WsvrCZJ5oGyZe9g0j5dDRLJ
 rSCJUm8e/zX6P7cOmzp1VGqJt/vKhH6m5n6jMd/fZGLOPq6KuVeSjiWp0V4/f7NTva5J
 rPAg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790521342; x=1791126142;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IDybEWpfYkwmsyUhJUTx5pCtZuOZj7UTkjzX8yUrrWg=;
 b=BZLDXugYjNl4MPqUYY1WbTRkbLiuTtr5i2mKSr64NSY2jwNRkQApfFcQwNnk8wYaMT
 0oKLGvYRARPZrVJ7OIWYm4Z+7wN61SVAbXeqxBbd5pVtXXYgvXkQ1q50mSHDMbk5Jrxk
 8LVs8/SMBktduzWIxo/+TgU3I/UuOwXBeotuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790521342; x=1791126142;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IDybEWpfYkwmsyUhJUTx5pCtZuOZj7UTkjzX8yUrrWg=;
 b=kPXuyz+eCzhWC2kDuIVQgBgbLKHupEdsTy9fax+CWGPyujz5Z0Sc4MnbySqQV8FlEj
 HgBG3t7SVwZeJabzw78GYepd4z4TWp5o0dl7kSzXtezouaXb7QBD3/i5ZdTas0MOXzXj
 iAfEUwZxd8f216FlyLLcYLdR3u/TSA9lQjZAX7CtxRALepWNvTHyCzoI38N0FwnIWZRu
 p5YqxmcAba/33lL6pLuteZ0N9nruL0gWBy1Qb2CfPdwgRgmAmn9exDzvmh6B8oLxfZLu
 XrgDWoT5Lvivizg/wN/+kCmgoLmGYtwZgA6inBC7UB5WcurMbQvB5y+eUG8ZPPBN5Dse
 mS4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx92rrsdHJJbcUt1rSpLL/0dTXL8vYo+j1h3tKEp8fIUXzfDVNI4m6n85jJkoo1p8KwVatAYkM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIdmDPmw1GHG8ITlYDY8VMXYpY1ycqGlaZITH67ClVRFUWf34hp
 MLFWxLVJ59Iv26BK8kj3g/U+OSpSdJ4qoenMigfjKkmqJfhVRloqdLWSiaqFMI0yFpBF0S0esB3
 bIYf4eskdtAiqXQmczV6u8MKlLIPau4m4wXJWKvvh
X-Gm-Gg: AYBFou0lV9sDo/uod3B2/T39OhklF8Qql/3Vav/XNoPmky9X+VU+IJXnIWTDwp1LR5X
 TxwobvDJC1165eLaIF75GDOHXRCfBAzIdZqY9Fz7IDksmaVPYIKHU/C3K9CfJiIxUtkIXqeOdH+
 iFV0HMqFXOLYXQ4rDmBd4tRGRXKWpivcBscd4jRpOP5HEvSunTRH3LXZlgy+sG/G0v4aRBW3Gg7
 JUfDACPcW0vWSJMGDFv+erCBWePw7lcAI0OBLtHSY9m+7WS1NVdx2022BHof8C3c7n9LzBAFK5i
 HCqNdE5LSaiXtNFKMcaeXz0QpuJ8iQcTn24cJU8SdgGHpvLaBxFKPg==
X-Received: by 2002:a05:6402:52c5:b0:6ac:6c00:bd27 with SMTP id
 4fb4d7f45d1cf-6ac6c00c1a0mr1059973a12.2.1790521342180; Sun, 27 Sep 2026
 08:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260925105432.0F27E68C4E@verein.lst.de>
 <20260925105617.71F7668C7B@verein.lst.de>
In-Reply-To: <20260925105617.71F7668C7B@verein.lst.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 09:02:07 -0600
X-Gm-Features: AclHuK85uUv1iMvVqB6awZ3Al3y03hgcxw_FPa2Butj0MmetSyH2ui1ivRBdsbo
Message-ID: <CAFLszTiMXxraXAiB8vRGYTtrkExMhPo-d-PKHdSGhwozURC8gw@mail.gmail.com>
Subject: Re: [PATCH 2/8] test: add dma-ranges UT for dynamically created nodes
To: duwe@lst.de
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Martin Schwan <m.schwan@phytec.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Anders Roxell <anders.roxell@linaro.org>, Michal Simek <michal.simek@amd.com>, 
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>, 
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, u-boot@lists.denx.de, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Torsten,

On 2026-09-25T10:54:32, Torsten Duwe <duwe@lst.de> wrote:
> test: add dma-ranges UT for dynamically created nodes
>
> When devices were found using PCI(e) autoprobing, there is usually a
> connecting bus node as parent, and the device node itself, both
> created dynamically without a corresponding device tree node. If the
> device needs to do inbound PCI transfers, DM looks up the DMA mapping
> ("dma-ranges") in the parent's DT node; but in this case there is
> none. Test whether DM is able to find the property on the grandparent
> node.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
>
> arch/sandbox/dts/test.dts |  9 +++++++++
>  test/dm/ofnode.c          |  4 ++--
>  test/dm/phys2bus.c        | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+), 2 deletions(-)

> When devices were found using PCI(e) autoprobing, there is usually a
> connecting bus node as parent, and the device node itself, both
> created dynamically without a corresponding device tree node.

I read this as your discovering something in previous testing, but I
think you mean 'When devices are found'

> diff --git a/test/dm/phys2bus.c b/test/dm/phys2bus.c
> @@ -31,6 +31,38 @@ static int dm_test_phys_to_bus(struct unit_test_state *uts)
> +#if CONFIG_IS_ENABLED(OF_REAL)
> +     if (uts->of_live) {
> +             /* DMA-ranges are to be found on the grandparent bus node,
> +              * DT nodes neither here nor at parent.
> +              */
> +             struct udevice *pdev;
> +             ofnode psave, nsave;

Thanks for the test. I'd rather see this as a separate DM_TEST (e.g.
dm_test_phys_to_bus_dyn) - the test name then describes what it does,
and the of_live guard becomes a single ut_skip_on() at the top instead
of wrapping the whole body. It also avoids the #if in the middle of a
function.

> diff --git a/test/dm/phys2bus.c b/test/dm/phys2bus.c
> @@ -31,6 +31,38 @@ static int dm_test_phys_to_bus(struct unit_test_state *uts)
> +             /* pretend the devices were discovered dynamically and have no DT node */
> +             psave = pdev->node_;
> +             pdev->node_.np = NULL;

Please don't reach into dev->node_ directly - the struct comment says
'do not access outside driver model'. Use dev_ofnode() to save and
dev_set_ofnode(dev, ofnode_null()) to clear; that also stops the test
from silently assuming the live-tree representation of ofnode.

> diff --git a/test/dm/phys2bus.c b/test/dm/phys2bus.c
> @@ -31,6 +31,38 @@ static int dm_test_phys_to_bus(struct unit_test_state *uts)
> +             /* DMA-ranges are to be found on the grandparent bus node,
> +              * DT nodes neither here nor at parent.
> +              */

Multi-line block comment should use kernel style with the opening /*
on its own line.

> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> @@ -664,6 +664,15 @@
> +                     subnode@8 {
> +                               compatible = "denx,u-boot-fdt-test";
> +                     };

Stray extra spaces before 'compatible' - the rest of the file uses a
single tab of extra indent.

Regards,
Simon
