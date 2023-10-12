Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DC5CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3704886D3F;
	Thu, 12 Oct 2023 05:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="2ik2JGeH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC7F386DED; Thu, 12 Oct 2023 05:43:17 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD02886E0E
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59e88a28b98so4153067b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697082157; x=1697686957; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rrceUh8S5ZVcikh9IXp1SmEqVdh6uXXG9GSo6+xCtEg=;
 b=2ik2JGeHxjhlo+qQpNBgBbNLf6NZU/Sovq5otpewuCThLpJtr9YiipCOEINMr52ceN
 bUVd7EVzYZP4qoKukYQ3UNOWi7hhdqHU6AVjhvWg5zRyfv7eBp2p+0d1I7r/uixhkwiu
 3LSacqT0UCuAcTjdRPGt1xLYKt5E3cSj+sEkJanrWz1KIwaEFolbQzBfMsjow3lNAjNH
 ngA2zP34k7k3nD+jwOQcinA+Rtx4R6eY070F79TLsPubwIvKn+ua/tGbJKKuynidgX1f
 0ScfmKLC/g8EP30AEDB46YlVdC4Hxbi32jyNAOiv52DSUaGQWAlZcAHfhCRujJzFAq45
 0fvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082157; x=1697686957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rrceUh8S5ZVcikh9IXp1SmEqVdh6uXXG9GSo6+xCtEg=;
 b=A+tJz/fCGCSPDBaK7dYEZzKo62oHi1Tr5DUCo2gRGhZkGy0Fv4c4Jfx9NhDIlSOVAm
 5ESgCQjH6J3QuXl6MJLtBeuX3u/IPSt8HdaDUeQ5Sme/YHF6t4FmZ4oTS6qn1ebeZkWh
 n3YgvbFxlLd/2EyZf//zGAcsaL0E+R0jiUyO6ZGriLMrV3U2eZanZwTG79/JgKIraK9h
 0xSrihe+bW/2qVQ1dLw5wl4kA4n98bmESooG9DdLi4xK9ZpGLHIW7BgzV9RMb6dU2uGf
 yP3eAEqudpBH9nZB0WwV/VNGqVg0ietBwgqH3iz8XhsCsuVnTXnv8oyxoE6wOgK7NKtH
 mk7Q==
X-Gm-Message-State: AOJu0Yzp9ulldiSfF97HNah8V2KsUcRCx2I1dKcS7L1hRBnTjWOMn2S6
 djsCf7HbUACdN41Qru4tn6YMmDnZrPDP2Gq7GYFj0tCx4rGSBq4M6U0=
X-Google-Smtp-Source: AGHT+IE6UYiVjYBb9CQHlssME8zvrWzCC6agg1rdN1NeP/4uTLgY5CDngfLR62wqGpVP2dS/nRlnWqcTlWjSmaGPlVU=
X-Received: by 2002:a81:9254:0:b0:5a7:dac8:2fa with SMTP id
 j81-20020a819254000000b005a7dac802famr2920138ywg.24.1697082156820; Wed, 11
 Oct 2023 20:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231011110052.2958231-1-bmeng@tinylab.org>
In-Reply-To: <20231011110052.2958231-1-bmeng@tinylab.org>
From: Simon Glass <sjg@google.com>
Date: Wed, 11 Oct 2023 20:41:00 -0700
Message-ID: <CAPnjgZ28PL-ikWSATgj0PnRC-F-f66n415R6_pEiFtNtFjja2A@mail.gmail.com>
Subject: Re: [PATCH] mmc: pci: Drop the superfluous cast
To: Bin Meng <bmeng@tinylab.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de
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

On Wed, 11 Oct 2023 at 04:05, Bin Meng <bmeng@tinylab.org> wrote:
>
> dm_pci_map_bar() return a value of (void *) already, hence no need
> to cast it again before assigning to host->ioaddr.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
>  drivers/mmc/pci_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
