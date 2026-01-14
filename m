Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE779D29FEC
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 11:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 288E680081;
	Wed, 14 Jan 2026 12:20:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H7CO3Hvx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3264C802C1; Wed, 14 Jan 2026 12:20:44 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B6688003E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 12:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F1D4360051;
 Wed, 14 Jan 2026 11:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D599C4CEF7;
 Wed, 14 Jan 2026 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768389630;
 bh=1zY4125DUihBElYuWZ+sdIgfeg8KKOrn74PMTDdIVg0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=H7CO3Hvx4ZNJHIS/zbrka2OLeaOhrCMIy52LbAJa4as5CQKqywH92dxKCAYlG3dWE
 8zzI7zOK1CBsCEr+hf4kuGc9JP4LBJMdwXLqPy6c80t5TwW6jqtO18y6g+L2+pB3E2
 cWMOOdDW/fGJJvqICEBLOt4rirGydn39u0ZQX4LS/FP3GwVlAx8B+MeFO2JAisgqXr
 Gc1sALzlA/Badc3FI4oJHGt/G5KN52wcfACxEw5t8G1wJBjJGSaZ5ubLEjPQwyesdw
 v4tSZL2T/am0wFqix+k5nggFu/Iy06Z9KcfFU/MoT9ngpVrsxfafF0RYiyv4EHyLpC
 qFgViBMu1Cqcw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>, Lukasz Majewski
 <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.denx.de
Cc: Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH] dfu: Report error codes
In-Reply-To: <20260106222212.744823-1-sean.anderson@linux.dev>
References: <20260106222212.744823-1-sean.anderson@linux.dev>
Date: Wed, 14 Jan 2026 12:20:27 +0100
Message-ID: <87ecnsfnk4.fsf@kernel.org>
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

Hi Sean,

Thank you for the patch.

On Tue, Jan 06, 2026 at 17:22, Sean Anderson <sean.anderson@linux.dev> wrote:

> A lot of things can go wrong while parsing dfu_alt_info. Make sure to
> pass the real error codes all the way up instead of replacing them with
> an unhelpful -1.
>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

This is a nice improvement! I'm happy to pick this up.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>
>  drivers/dfu/dfu.c | 52 ++++++++++++++++++++++++++---------------------
>  1 file changed, 29 insertions(+), 23 deletions(-)
>
