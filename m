Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614C8C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 09:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6C9881F7B;
	Mon,  5 May 2025 11:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y71FR+xi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DEE581F7E; Mon,  5 May 2025 11:28:54 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1568680F03
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 11:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 95F11A4C78F;
 Mon,  5 May 2025 09:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDD2C4CEE9;
 Mon,  5 May 2025 09:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746437330;
 bh=QWdTI2x9zS25AMAi5+EcD/g2awECVOmeh/XJn/WbB8o=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Y71FR+xiFBFTxH7XXLUfJV1K1fCz0pyuVErMbMqCJQ2bd6SYSBT+FTIGmR+NYzkph
 tOz19EgxEcZb28SvnabnOszeU6j61P2yZf4t2lu2TRecxwqog1fij0pAT7VvWPS4/p
 2Gh8w9wtfcGt2bXJfC2bmAE6d4Plr6UlLFSOpMejCMDFpAJ4QtipoJYoCPoVOR7tfp
 Oya50o7pGMYDkUlB/oqJglf+9JNoxdW7gRWXq+1L/WINr4GTLhZLVREjdMz+fjiMdY
 D+/w1zLsOkT8fKTmjAYMzZ7beh5jPUcaxS5akF+sJxN3AeejvCDukio+eXpV/9uvT7
 FseIeTj9BBV0g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Tom Rini
 <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, u-boot@lists.denx.de, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] doc: u-boot-test-reset: mention power cycling
In-Reply-To: <20250503101237.48135-1-heinrich.schuchardt@canonical.com>
References: <20250503101237.48135-1-heinrich.schuchardt@canonical.com>
Date: Mon, 05 May 2025 11:28:48 +0200
Message-ID: <874ixz76en.fsf@kernel.org>
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

Hi Heinrich,

Thank you for the patch.

On sam., mai 03, 2025 at 12:12, Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:

> Using power cycling is a valid option to implement u-boot-test-reset.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  doc/develop/py_testing.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/doc/develop/py_testing.rst b/doc/develop/py_testing.rst
> index 824e3c0d9a7..33103bbd650 100644
> --- a/doc/develop/py_testing.rst
> +++ b/doc/develop/py_testing.rst
> @@ -377,7 +377,8 @@ this script again to restore U-Boot to an operational state before running the
>  next test function.
>  
>  This script will likely be implemented by communicating with some form of
> -relay or electronic switch attached to the board's reset signal.
> +relay or electronic switch attached to the board's reset signal. Power cycling
> +is another option.
>  
>  The semantics of this script require that when it is executed, U-Boot will
>  start running from scratch. If the U-Boot binary to be tested has been written
> -- 
> 2.48.1
