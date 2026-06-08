Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF3DCD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5570E84154;
	Mon,  8 Jun 2026 10:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fFrxkaT0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B78D847B0; Mon,  8 Jun 2026 10:17:33 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F27384154
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0907434EF;
 Mon,  8 Jun 2026 08:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43061F00893;
 Mon,  8 Jun 2026 08:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780906649;
 bh=WUHyxOAFmRrRW5RsIuMrZhweP0qK6py3CzvUuG7WeBI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=fFrxkaT08MK5tGld4j9PwZJeM2lycawseVZET38v/Elci74DnGcEuo75BvVxr5Slf
 AsCh/2Rv7pdRdxxzCfX6bDlE8vRk6N4CoVUq8kjUodVM1pQiXBdJAEe++aHcx9XaCr
 0k3aRp8ssNjM5M+N/wfPN1cYBACOW4Ba2eQWTrXn72yI+ma5xVz79UqOPBFLOshqOG
 xixR1yRtzkUGdfb3EX0fjOyxm7+w+x+VIVIBdfSK6yGwfrNksw3PTrf8JhZIYXLFHh
 GKObqPSkevsRPJjFS+Ychusf7xqLJV4lrMU7eaRjW0AdQqfuEJ4czHzdw4bQoIADjn
 HwXq5v22RbuSw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 02/11] test: Move extlinux image-creation to its own
 file
In-Reply-To: <20260523085455.750591-3-sjg@chromium.org>
References: <20260523085455.750591-1-sjg@chromium.org>
 <20260523085455.750591-3-sjg@chromium.org>
Date: Mon, 08 Jun 2026 10:17:27 +0200
Message-ID: <878q8pzbs8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Simon,

Thank you for the patch.

On Sat, May 23, 2026 at 02:54, Simon Glass <sjg@chromium.org> wrote:

> Move setup_extlinux_image() to its own module. The image exercises the
> extlinux bootmeth and is modelled on Fedora 31, so name the module and
> function after what they test rather than the distribution.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>
