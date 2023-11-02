Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D90C4167D
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F9CD876B8;
	Thu,  2 Nov 2023 23:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DhbXxhLN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66F04875B5; Thu,  2 Nov 2023 23:46:28 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 391AD874B7
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5079f6efd64so1760099e87.2
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965180; x=1699569980; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qJlB7maCM/xPX/mt2DxU4yEzq9Wsw7Xzdv9ZIPYxsSk=;
 b=DhbXxhLNCg7LzIZNy5T6FCN+3QVDe6DPmDb64NNAJx5ugthKqONYvwJipLY0Ed1ihB
 JGzdRKo3o81Ufez26sklQoRkvHqRMm5t9JX/o+CwzrbrQ3LhcuaWdXCbTmMuLrSs8j2W
 S+axoXJIaLOxCmoVoYfbIGjotAcOKrtlHY6JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965180; x=1699569980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qJlB7maCM/xPX/mt2DxU4yEzq9Wsw7Xzdv9ZIPYxsSk=;
 b=N3CdCZVl6FOkCFcd1fgvsAxIAOnZH+BjG0cj+jnx0VqTFn/jVB+R0EOKte+itV/iPF
 ORmaUelLmuz9AEV1o8bP9TjKcJ4/f7XMxVQbbwifNL8OH0PlxTw1DskiOLsC3wP2A9UA
 OU3J3bsDDa0AF50Fv+VyRfmMFpWk5LnPmtamEkPdFE+bH0brPy1ceGPLO5DnlZncrvAk
 XJsUcE1HZ5bQ93L6NYx1db9tNsZJvuTq0/3uUhLt4VVWzRkflpxYxm9/ZAfxijdH5Ka0
 JH9yofJ01FADnI4o7+pQge5mYEx8UdJlPL92XbpH5+HBggQLZ08rdHY8R3z6XksKAm7U
 vLNA==
X-Gm-Message-State: AOJu0YzfJA67gNqFewm3Gegw0gyKI5oiwKHeYuMFuCpEouwAq/7EWvDp
 S6LpL7pHAF6gap3qo50O4UpC9lAxqqHiapTOWLYV96DbLpQ258unk/I=
X-Google-Smtp-Source: AGHT+IFN0p7LptF0z9A0L1niyzhGifd7g4bWSlZdFJC6XeOGszR03MrbulQgT5c+U+T5KBmHiPydWhuamw/XnoZKGDI=
X-Received: by 2002:a19:7617:0:b0:509:462d:556d with SMTP id
 c23-20020a197617000000b00509462d556dmr2935760lff.58.1698965180132; Thu, 02
 Nov 2023 15:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231031051805.62430-1-samuel@sholland.org>
 <20231031051805.62430-4-samuel@sholland.org>
In-Reply-To: <20231031051805.62430-4-samuel@sholland.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Nov 2023 22:46:04 +0000
Message-ID: <CAPnjgZ27hKC7QX1uOYV7ah4L3Lqyu5U5L8ccK558jNWmfxsn9w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] sunxi: binman: Support FIT generation for 32-bit
 SoCs
To: Samuel Holland <samuel@sholland.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 u-boot@lists.denx.de, Icenowy Zheng <icenowy@aosc.io>, 
 Jesse Taube <Mr.Bossman075@gmail.com>
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

On Tue, 31 Oct 2023 at 05:18, Samuel Holland <samuel@sholland.org> wrote:
>
> Some 32-bit SoCs can use SCP firmware to implement additional PSCI
> functionality, such as system suspend. In order to load this firmware
> from SPL, we need to generate and use a FIT instead of a legacy image.
>
> Adjust the binman FIT definition so it does not rely on TF-A BL31, as
> this is not used on 32-bit SoCs. Instead, after loading the firmware,
> U-Boot proper is executed directly.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
>  - Rely on binman min-size instead of using explicit offsets
>  - Use Kconfig for firmware addresses instead of an #ifdef staircase
>
>  arch/arm/dts/sunxi-u-boot.dtsi | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
