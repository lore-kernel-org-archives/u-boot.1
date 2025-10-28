Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95353CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 10:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF23883A35;
	Tue, 28 Oct 2025 11:20:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="XaYaXTK1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11BA283A56; Tue, 28 Oct 2025 10:41:07 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15C5383A35
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 10:41:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 69DE31A16F1;
 Tue, 28 Oct 2025 09:41:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 35250606AB;
 Tue, 28 Oct 2025 09:41:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6A73D102F74FC; Tue, 28 Oct 2025 10:40:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761644462; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=OmoiSV3xtl3/pcgilnIuVeJyeggUhK9sFdwrU3eYLXg=;
 b=XaYaXTK1wzbXr8lVBV8nPeLEC1svM+7BmP6R2tSf7KnnkEALC1ucm0whf++MKKMFXoBpFZ
 qeqk+Es9Q5BqJlLt0Q+5Y+ocAw/80FOyPQdLbfB3Z3rFg+PUItXwwsErSgda1h+3Qzp/5T
 C7zSemdiydh0MUQONu1cyMQ5Nodd10YLO6ne8VSRrsr58CS4eyUo68JZHBLpKhWgr3Jf/s
 uho4/qiVQIKZeu39o9vocDRiMHkhyEUORfOtaqLTrG6B7lFGoKhHE+gHfK5GRw7yfi5P8k
 14ra5osyBF5ofxrk0ugpBBlDsQKgvenrv5MnVAgTmbzwlTMxudiLdO8wSN+dHQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,  Michael Trimarchi
 <michael@amarulasolutions.com>,  Tom Rini <trini@konsulko.com>,  Jagan
 Teki <jagan@amarulasolutions.com>,  Andre Przywara
 <andre.przywara@arm.com>,  Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Linus Walleij <linus.walleij@linaro.org>,  Anand Gore
 <anand.gore@broadcom.com>,  david regan <dregan@broadcom.com>,  Greg
 Malysa <malysagreg@gmail.com>,  Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,  Marek Vasut
 <marek.vasut+renesas@mailbox.org>,  Philip Molloy
 <philip.molloy@analog.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  u-boot@lists.denx.de,  James Hilliard
 <james.hilliard1@gmail.com>
Subject: Re: [PATCH v3] tools: sunxi-spl-image-builder: support H6/H616 NAND
 boot
In-Reply-To: <20251028083733.574757-1-richard.genoud@bootlin.com> (Richard
 Genoud's message of "Tue, 28 Oct 2025 09:37:33 +0100")
References: <20251028083733.574757-1-richard.genoud@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 28 Oct 2025 10:40:43 +0100
Message-ID: <87bjlruzxg.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 28 Oct 2025 11:20:08 +0100
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

Hi Richard,

On 28/10/2025 at 09:37:33 +01, Richard Genoud <richard.genoud@bootlin.com> =
wrote:

> The H6/H616 boot ROM doesn't expect a SPL scrambled the same way as
> older SoCs.
> It doesn't use a specific seeds table, it expects a maximized ECC
> (BCH-80), a specific BBM (FF000301) and doesn't work if empty pages are
> skipped (it needs its specific BBM, even in the padding).
>
> So, add a --soc=3Dh6 option to support H6/616 with:
> - more ECC strengths
> - specific BBM
> - default_scrambler_seeds[] with all values
> - no empty pages skip
>
> In Kconfig, select BCH-80 by default for SUNXI_SPL_ECC_STRENGTH to make
> BROM happy.
>
> And in scripts/Makefile.xpl, use --soc=3Dh6 option when building for a
> SUN50I_GEN_H6 SoC.
>
> Tested on Whatsminer H616 board, booting from NAND.
>
> Co-developed-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
