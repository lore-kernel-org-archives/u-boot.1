Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736C9CDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 617AA88E8A;
	Thu, 26 Sep 2024 23:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V7wFQpN8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52F7D88E77; Thu, 26 Sep 2024 23:33:43 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 265B388E26
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7a9a3e731f9so126939685a.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386419; x=1727991219; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1h5THxLVGZj3TY8ULRW+Ubp/vSXnj1UQClaUkIY8ues=;
 b=V7wFQpN8Ggpvig5Ploi7SRBnCsA7KyWqzkFJuQ/e47I+CkwDb2MZzCT8f+K7hKwkcQ
 mL2e3nk6bnWmsff8lDmfocumNSINuoNWO5acFg7auiE6EgvHPwaejxU+uhgPBgvWyiqe
 nnAWjn1OccTxR722oYOX4x2VF5dAdnsu054AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386419; x=1727991219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1h5THxLVGZj3TY8ULRW+Ubp/vSXnj1UQClaUkIY8ues=;
 b=DIh3aTefqwV7ITSa4csvUtbSPFiLElLG/JM81/PQR93PJivnnziLYjOpQuDl81zUSA
 BGtWyUNyxqlJBgf0BSnOKBxEvygmmQ2Y0tpl2LV0ihOHV/+4rdmpsOyWOoOekbkg8bbO
 ScJ+DXNW9bfliCzECUB+erXxfwXjfbeJKBSnefcIzyJIJJxVjL5+jl2iWqkOfctbEPyo
 p5EB/Yx2Lsg5AXirZdmFyJs5akpRZk5byE3WUgEclo9ZzNivUqstKQNpD/q+glVc7EOz
 eswicFKjztzWAoBs4Afv4pxC2QDuoJnou/p3qBRgARkCfxpGWy3Z3nTxb2Txd8K0G0mF
 vGdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg8Ba3Oiqfx2lqgjF5/u63Y8OsJ3VX/LzCvPu2iDni1g2oAfImaS4VB3yNx+ZXAfrTxptD/rA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1/lTDqpWX7PYt5UIpUAdsFjVMvviojgZ+5ZVY5/tLCCazR74K
 fx19bfFVY6eHFNpUjN7b0TlGaOiAKHPjuvn2znbIwW0MiA38XZp1evVIW10nCNpEjoBmnp5DzAb
 ZqUMiMRtBCFfQh8IsOCAl8aPOZWD/EpZHRb41
X-Google-Smtp-Source: AGHT+IGIgN/ID2tDoiYrEa2hsQM7g09djsNydXH+tYlY6WJ6k/AzgMXw+mk2tr4KlNO2soUfxHguht6x6UWTncjqT0s=
X-Received: by 2002:a05:6214:568c:b0:6cb:3045:9f0e with SMTP id
 6a1803df08f44-6cb3b643fcdmr12487146d6.33.1727386418949; Thu, 26 Sep 2024
 14:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
 <20240920225101.2008-9-ansuelsmth@gmail.com>
In-Reply-To: <20240920225101.2008-9-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:33:26 +0200
Message-ID: <CAFLszTgGA_D4XvnKj4xoVtO_u38xFu+FQzKannU+kdJtVmYKwg@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] ubi: implement support for LED activity
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>, 
 Alexey Romanov <avromanov@salutedevices.com>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
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

On Sat, 21 Sept 2024 at 00:52, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Implement support for LED activity. If the feature is enabled,
> make the defined ACTIVITY LED to signal ubi write operation.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  cmd/ubi.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
