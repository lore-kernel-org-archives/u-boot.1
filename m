Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523D2D30CC1
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 20:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BCF882C7F;
	Tue, 13 Jan 2026 21:03:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g4xuA7u5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11608808AF; Tue, 13 Jan 2026 21:03:31 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 293AF808AF
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 21:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b87003e998bso30528866b.1
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 12:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1768334608; x=1768939408; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eO1DdRVVRQTqrejF7fRwvbxZfYfElJHV9WLFar3GI9k=;
 b=g4xuA7u5ndSjFS+dSMwd7s/VNcLSn9go9JLgKfa+NDhK4UqMqPBQ04ZPBELj7kSN/f
 iEvk7pYCit70mh0L3jkNaPnvCzmc/K1NjuvGOqHNsKnb8n4NbiXK+AkTwRtkafEdR5Pe
 BsFfxYsalKxcZ2iwVw09L8RIs7AaOBGvoyPjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768334608; x=1768939408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eO1DdRVVRQTqrejF7fRwvbxZfYfElJHV9WLFar3GI9k=;
 b=tSjgEVs/isyF3eawCOvuwzZ0pJaUrraqLBJQR2BxYidMdeWIaJXq7XUtifoorf9hyi
 /7IDzEkT1I+sl+quayoKw0iphaw85Thl/Q1oRwRZJE0PZ3PBOi64JgAiaOiytLBQQ4Gn
 ytPsHmnLjB36mN91hMsO0EtduzbWyUKtcDrMzi6j0m+r+2hjkPbw/R+0kcGYqRkDKvaK
 fA7Y6dVIKgD3kjRuIeaAzxM3pgxkt2jnv1efR0HN58JM1bRhnOmR84W8CE+BjOzrtbK1
 86daP0sZJ9Wkw+qcTDrXYA07AT/aLpbyfwkPzeZZOCvs8UIZq1+a3LO66LzfUdKsifl6
 x7ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYfD/+SVgS5CvGMaR2oHiJFKcvV7sQ35r2vdKcQJd0LYZgK5Me32I/VuDdjVkDeYgGh0KhQZ4=@lists.denx.de
X-Gm-Message-State: AOJu0YwReXXyXUJxxk2fs7d7IA6nga/tHnmAJ//8fDObQ8tz8ivndiPj
 Irmzc5Xpen7XnHIFt41q+NSAQEkTcgDJFyaOGRBAbW7pT036NBdA713vLqkRE2I9DqhEQ4H5Hgw
 2oIieslfK9brfkgzVBuDur/7/eJtiwMKyJE6MZ3hz
X-Gm-Gg: AY/fxX4s9gG6tphXjadPj2Ig8PbwavqIkstRzrlv2q57INdIr36RtuCZpE2OlFKzfok
 6xsBmQheUmSLuxDMH4fza4PENsBOV6JYTws9hg1bOkkjxkUGLY3g8PuSAnwqkDtahhrjRrqDlv7
 zMu6wA27quusSGjJKJ6WapSn5KaibiyG6qtefLrNV6VwJVy4c7vCF3X4c6I9rIDwPRWoXgG2A8G
 BYXnwBnXdCYTs4VXpcp2t9H+FquzuMC3YBiEUxn1WmvxzaLzdT7lSVR8w13OnOel/gYsQ==
X-Received: by 2002:a17:907:3d8f:b0:b80:1403:764c with SMTP id
 a640c23a62f3a-b87359a092amr341267866b.24.1768334608536; Tue, 13 Jan 2026
 12:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20260113012037.2566942-1-sean.anderson@linux.dev>
 <20260113012037.2566942-3-sean.anderson@linux.dev>
In-Reply-To: <20260113012037.2566942-3-sean.anderson@linux.dev>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Jan 2026 13:03:10 -0700
X-Gm-Features: AZwV_QiQTfi_uRF1u-xuGabyImmqSB5aS93q1Tv0wk5jj2-9b-o3O2MIFQkDh-g
Message-ID: <CAFLszTja168RmKqzya-J-vPOLSBs6CnYevEOR+kR_Bn7R3nCOA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] PCI: sandbox: Add PCI bridge emulation
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Mon, 12 Jan 2026 at 18:21, Sean Anderson <sean.anderson@linux.dev> wrote:
>
> Add a PCI bridge emulation device. Although real bridges need to be
> configured in order to forward requests, this happens automatically for
> now (see arch/sandbox/lib/pci_io.c). So just record the window registers
> and check them in a test to make sure pci_auto is sane.
>
> As each bridge consume at least 4k I/O registers, increase the root
> port's I/O space so we have some left for other devices.
>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>
> Changes in v3:
> - New
>
>  arch/sandbox/dts/test.dts        |  35 +++++-
>  arch/sandbox/include/asm/test.h  |   1 +
>  drivers/pci/Makefile             |   2 +-
>  drivers/pci/pci_sandbox_bridge.c | 192 +++++++++++++++++++++++++++++++
>  test/dm/pci.c                    | 142 +++++++++++++++++++++++
>  5 files changed, 370 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pci/pci_sandbox_bridge.c

Reviewed-by: Simon Glass <simon.glass@canonical.com>
