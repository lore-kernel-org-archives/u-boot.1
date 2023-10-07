Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C23E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2BFD86413;
	Sat,  7 Oct 2023 23:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ww2WRm6j";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jSXwbVoI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 612258642A; Sat,  7 Oct 2023 23:21:03 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03BDD8640F
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 23:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S2yrq5QN9z9sks;
 Sat,  7 Oct 2023 23:20:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696713659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHGQLDFyPRmQ+kl1JrHBxAo8eddJHrXtqVOQSk8ph8Q=;
 b=ww2WRm6jzwt2LR9D62uR8U2hCWisNwoduMVBEPWh2WeJ23NF7U2sJNudxNB8MDdY+BKk5d
 q6maTMAdhv9yFdYsNa09v/LMxjcn1DRASzfca/ijZeWNvg2j2Fr9eK4l/Se6Fcw4tXLm3U
 h79cqx4LMG5vACm0XQcxwhe+nafOJNFWaIcMUllaJZhKcjTAVyvIzvL6oeePCvf49w7F3S
 Pji97nzHoMWDDXjfmehT5+Y2v3JoHJfh313KLsGqv1XAlFirHqVp0GwTxGEUd5kXse0xeT
 hIjc9c8JsoZibay44NioEIz/xDgbdDpDlNoyDzqaHLzcJfqTl1XVDZKmwFodWA==
Message-ID: <e32b13b6-44b8-46a4-ba5a-ce774e626845@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696713658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHGQLDFyPRmQ+kl1JrHBxAo8eddJHrXtqVOQSk8ph8Q=;
 b=jSXwbVoIQxBbPpB9xFuJ+8sA/AbRBvathgnWyEfX4wDrnIPyx/kg60UN0Xn0CgDYqKzHXE
 9D5XZsO/rQYj6ULra9yWojVierCPzheRSw0Y1aeO/ra4Au4jVn7iPNjYqMZm4pva/iNcy8
 QpYxUGUakGASrMlJDUAEcrg7TQq7UCvZnCGS4GKuLBSAPbiYrtv873Klgbji6FeKQo3UMt
 wFxl3lM3oh/guNu43SAJfpFwwMKpdm/w1ifQUCc4FdcyIE3VRdEHrP1/IHTzdUkpU0P6jX
 XEtjBOyQVQ+NE6I7ZdFkAePmapoVyrIYBFGd+kGUO6JN0u4NSdaGkwsMvB4Aew==
Date: Sat, 7 Oct 2023 23:20:56 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] doc: Migrate Renesas board docs to rst
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>
References: <20231005170705.31319-1-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231005170705.31319-1-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 4mz9ta9x8t7hu1c76s4qhj4637mt6x5h
X-MBO-RS-ID: 4d23892912aa03afc7a
X-Rspamd-Queue-Id: 4S2yrq5QN9z9sks
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

On 10/5/23 19:07, Paul Barker wrote:

[...]

> +   * - R-Car Gen3
> +     - Salvator-X

Salvator-X(S)

> +     - R8A77950 (H3)

These ones are actually not 77950, but 77951 , all of them.

> +     - arm64
> +     - ``rcar3_salvator-x_defconfig``
> +
> +   * -
> +     - ULCB
> +     - R8A77950 (H3)

DTTO

> +     - arm64
> +     - ``rcar3_ulcb_defconfig``
> +
> +   * -
> +     - Salvator-X
> +     - R8A77960 (M3-W)
> +     - arm64
> +     - ``rcar3_salvator-x_defconfig``
> +
> +   * -
> +     - ULCB
> +     - R8A77960 (M3-W)
> +     - arm64
> +     - ``rcar3_ulcb_defconfig``
> +
> +   * -
> +     - Salvator-X
> +     - R8A77965 (M3-N)
> +     - arm64
> +     - ``rcar3_salvator-x_defconfig``
> +
> +   * -
> +     - ULCB
> +     - R8A77965 (M3-N)
> +     - arm64
> +     - ``rcar3_ulcb_defconfig``
> +
> +   * -
> +     - Eagle
> +     - R8A77970 (V3M)
> +     - arm64
> +     - ``r8a77970_eagle_defconfig``
> +
> +   * -
> +     - V3MSK
> +     - R8A77970 (V3M)
> +     - arm64
> +     - ``r8a77970_v3msk_defconfig``
> +
> +   * -
> +     - Condor
> +     - R8A77980 (V3H)
> +     - arm64
> +     - ``r8a77980_condor_defconfig``
> +
> +   * -
> +     - V3MSK

V3HSK

> +     - R8A77980 (V3H)
> +     - arm64
> +     - ``r8a77980_v3hsk_defconfig``
> +
> +   * -
> +     - Ebisu
> +     - R8A77990 (E3)
> +     - arm64
> +     - ``r8a77990_ebisu_defconfig``
> +
> +   * -
> +     - Draak
> +     - R8A77995 (D3)
> +     - arm64
> +     - ``r8a77995_draak_defconfig``
> +
> +   * - R-Car Gen4
> +     - Falcon
> +     - R8A779A0 (V3U)
> +     - arm64
> +     - ``r8a779a0_falcon_defconfig``
> +
> +   * -
> +     - Spider
> +     - R8A779F0 (S4)
> +     - arm64
> +     - ``r8a779f0_spider_defconfig``
> +
> +   * -
> +     - Whitehawk

White Hawk

> +     - R8A779G0 (V4H)
> +     - arm64
> +     - ``r8a779g0_whitehawk_defconfig``

[...]

Looks good otherwise, thanks !
