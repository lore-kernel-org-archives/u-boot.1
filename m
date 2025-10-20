Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C08ECCD19F
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 16:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA54982E34;
	Mon, 20 Oct 2025 18:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hFbtCEwO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C33DE831D5; Mon, 20 Oct 2025 18:57:43 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C989A82C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 18:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BCAEB602BC
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 16:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FF1C4CEFE
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 16:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760979460;
 bh=tbEwkNCQf6x+4iN6wz4q3uzo87s72dt3Fet3XvY9RJo=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
 b=hFbtCEwOkM24LbVlYf92bah4uQK7q2ze7KW3xoTSGPwtrJrLEcBxoSOnMQ8Qg7zMi
 lcUnEAR3HExCu0JL+KF+hZT3RQXSFurC4gQagN6ObwFZ1yRQZdcb2GPhKWz/aEQ+tP
 menvcu6vC4S5FPMGbSpsq7zsd4vUbLzN9r9A7BUrGVULsxNVWPgF2fd0zjrTvQ3QwY
 XOm+XSErSUUifZ6I+8+HwoLzLdsbcoQij9He+zJLeqQkL22V/LiG8xWJkb9VhniMPo
 Buh7ZBjA0ye0O9miRoLxGVVaxahHYZ0oyvHG/ajiXS/oQIqpugkri3mKoOUd/lPlGn
 Gx9fI9MVX+0qg==
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-3778144a440so55112651fa.0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 09:57:40 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywyce0trdhYEbUOLmV/a6d+MSXI2UMCQPHi4Q/BR4yjI34/nLY4
 O/AIVHZnT2xgD7f00YArRt8ZPYBNbnLWtEIMBW09XRkQPxcTaWCLV677KhlBUXnqsWk4siufbUQ
 hPrxBqRWc19VyMiKXAUV9pG+1rN8pdhU=
X-Google-Smtp-Source: AGHT+IEJ11nUi/9MmADwmPCcmZBwPzpArt3Jo5D+vle9qaT3wF4aJeDOl19wLSdMLL9HBlPWGdrUX7LlrhJESdjTxI0=
X-Received: by 2002:a05:651c:3256:10b0:369:26f1:c428 with SMTP id
 38308e7fff4ca-377821dbd79mr45228281fa.15.1760979458776; Mon, 20 Oct 2025
 09:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20251020142622.1849108-1-andre.przywara@arm.com>
In-Reply-To: <20251020142622.1849108-1-andre.przywara@arm.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 21 Oct 2025 00:57:25 +0800
X-Gmail-Original-Message-ID: <CAGb2v65-qirhg0K09g66vA9ZXQJpdfJXk-e01vg_zFGBfZf5wg@mail.gmail.com>
X-Gm-Features: AS18NWAgCYoyEvILfYhDqpNcZIRTeRVwUdsmzoU05hOUQowLutmU9rjJqrvI06k
Message-ID: <CAGb2v65-qirhg0K09g66vA9ZXQJpdfJXk-e01vg_zFGBfZf5wg@mail.gmail.com>
Subject: Re: [PATCH] sunxi: a523: Re-use H6/H616 DRAM size detection method
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Reply-To: wens@kernel.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, Oct 20, 2025 at 10:26=E2=80=AFPM Andre Przywara <andre.przywara@arm=
.com> wrote:
>
> The H6 and H616 DRAM initialisation code recently gained a joint and
> improved size detection routine, which helped to avoid the occasional
> DRAM size misdetection.
>
> Use the same code for the A523 DRAM initialisation as well, which
> suffers from the same misdetection at times.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Previously I would get 8GB on my 4GB Cubie A5E every couple of reboots.
With this change that hasn't happened. Consider this a not so scientific
test.

Tested-by: Chen-Yu Tsai <wens@kernel.org>
