Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C14CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 14:55:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C11EC848D7;
	Mon,  1 Jun 2026 16:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A4rpTxXn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3236848BB; Mon,  1 Jun 2026 16:55:22 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBC2D848D7
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 16:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bec449cf976so156190266b.2
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 07:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780325720; cv=none;
 d=google.com; s=arc-20240605;
 b=hNcGk1oplYMMIHNUbHBlohVOoHk11QLvX2RERmmKWsR8TGwqdBSgTobAXStztWzQ38
 vqHesKVE4Yj+tDPJgK3Zvc4QarMQOA2H4ujMZ14qpNvriDSpiTkR5lVAsdKBtQFaXtBu
 U2KX9HxHVRT3lVvYCuHsH+xuQ685Wi82Cl3uYZ7FOBztzcyzmiCEZbdbhU6nLdmFEGVo
 1HWztY5/gDZB2MeO4DNrh5cjUsz5YcGqawZq/F2nyIhnmiFYKg9x6cCyuiMJ913i30ZU
 Y7zKhbQwAp6uChkl/Z23Pz08bH4smtdmBP/4LtvryQgs3/CMozClKhItXNbytGSIKB5l
 i3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=04vsbf5kuOqFy1s9tenzeutpSsJbLto8CCbeA5yB5bk=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=il0vYXQg+IWLlFuyPCe2qDePdkXKto3X2wcRL4X5CCtsBqe6zQCFGiAhr1+4JuAdbl
 DmGmd+KIcX9C0YAEIAuqPEH+cLt7b3RVX2qLGzCo7bdVENgye542oO9nNrHK2o+Ivf35
 v7OOeAXTbIIwKa5XKlsPYJyoF86O/qqCfFZdYpoM3WbKuDZpvGdymEZSRztlFXgYHGWp
 oLJuPJxkdBLEqM2LoafmUtgL2CDIBx7kriaPbDTHMX1gGH1o2itRYeDXjNYEB87rmrGd
 ixYZIAIM42uZUVGGLEIwuzS7p9PZb9s7zdQLcnoiT0ToIOy1hrzP9rDsD+nB4g7dC0/k
 lsIQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780325720; x=1780930520; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=04vsbf5kuOqFy1s9tenzeutpSsJbLto8CCbeA5yB5bk=;
 b=A4rpTxXn9upwdSE06uGfR6r//9HrDaHnPfPBQKcP5FTKbXmeOy+9102Rm0sYMc9Vxv
 pH+3YnGIX5pkPOEM9vzU9mD+TJdkM8wNjXBFS/UIfPv8wLASLsGQLJLwJ7kWpzogdeOX
 Xsk6+1ry3sbs0Hf/xsg9JLjajBMqZOiOXYE7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780325720; x=1780930520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04vsbf5kuOqFy1s9tenzeutpSsJbLto8CCbeA5yB5bk=;
 b=PoHjonCoxLkIywdEfUHcA1fW0RFFmNXhKRo3HRTkazqddOuOM51p1FZjdjNzwJn5Jp
 kHobAjnT6j+TLhKZnVMjwkUhzVphrJhUawpv5gmPUjXExTbIFlvCUNdvUixOMtS+BCLG
 rIOf/gZ/vPIwWvROGimxOxNDprzkuOun+FMPLbI23BPlIy2AFnC2UlKIQ69HXI7xxVQm
 wJ61HVREWe/wSWk0S8ZKtn4C21NrxqJ2m5NWzwpmVOsDLweV0yOwrEI/SJFvZZJOFrqR
 RLyANV0c+ld4S8pyg6h5qOl2Xpo2VM76IjLtczJDAYHGO9czNwdeGJxn85AV1ryie56n
 2ixQ==
X-Gm-Message-State: AOJu0YwyP1r4fXFVacPkaYzro73JVP4LRV0xzAyBoJm+MOfpDr4ntUfH
 sK3+2qCXNxkeDWlMrYV0KOMttAP/bw0al1dtbOmDRCVpDo3uc3ovoeaTdkaRPEe99mlibgBNu4M
 gwg3Q4IdqbEehex2Bw0PyTR4EcwVDpQrkVTVMBu6h
X-Gm-Gg: Acq92OExxYO7XD7o02EYBtEcqXIclcvXFqHx/i8ALchirNNFvywJpWH/Qz9oDGj0giU
 1asFgHn+Qxkhb1OIcRgADNtHbBR8+BsTUQFtQJsekwOS47xfW3utXGayU1MguMcYMYPciyl7g8+
 IIQO5kGDpwY9grwdHdBeS+PwzJp8P0fPWNAfc/fKuJzbbBTCMJjNMicmy5rlSoCjS2IhsLvyjcB
 E56PR+rz8jA2OQ9Ba4NMCyD6o9dUcDhnTAQDGBaV45BTLeimKxNLQkm4GW9Mg1TtKss5La3H0xq
 M+meUl2D9tQDgFBa
X-Received: by 2002:a17:907:72cf:b0:bd3:cb24:ae61 with SMTP id
 a640c23a62f3a-beab0dd8e72mr606675766b.6.1780325720128; Mon, 01 Jun 2026
 07:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260529034839.2075806-1-dmukhin@ford.com>
 <20260529034839.2075806-7-dmukhin@ford.com>
In-Reply-To: <20260529034839.2075806-7-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 08:55:02 -0600
X-Gm-Features: AVHnY4LCs8DZ28g7Cdt8mayQ1aYpMDw1s09DauspzFCqaUKilXvkhoEU485S3bI
Message-ID: <CAFLszThyECKSwFFsssbZM9fcMqsY_SgPUyG3-TU2GsyODQohkg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] tests: reset: add cold/warm reset types
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-05-29T03:48:33, None <dmukhin@ford.com> wrote:
> tests: reset: add cold/warm reset types
>
> Extend reset tests to cover both -c/-w reset command flags.
> Make sure sandbox reset tests are passing.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> test/py/tests/test_reset.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

> diff --git a/test/py/tests/test_reset.py b/test/py/tests/test_reset.py
> @@ -52,12 +52,12 @@ def test_reset(ubman):
> +@pytest.mark.parametrize('reset_type', ['c', 'w'])
> +def test_reset_type(ubman, reset_type):
> +    """Test the reset -{c,w} command in non-JTAG bootmode.
>      """
>      setup_reset_env(ubman)
> -    ubman.run_command('reset -w', wait_for_reboot=True)
> +    ubman.run_command(f"reset -{reset_type}", wait_for_reboot=True)

U-Boot uses single quotes throughout ('hush_parser', 'reset -w',
etc.). Please keep that style - @pytest.mark.parametrize('reset_type',
['c', 'w']) and f'reset -{reset_type}'.

Regards,
Simon
