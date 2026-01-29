Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3B0D358E5
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 08:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA40883B64;
	Thu, 29 Jan 2026 09:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QtJGGna3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CCEE83C01; Thu, 29 Jan 2026 09:52:01 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5BF28003E
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 09:51:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EA46E443A0;
 Thu, 29 Jan 2026 08:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B163C116D0;
 Thu, 29 Jan 2026 08:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769676711;
 bh=YP2giJ0o+Ry8bOLMdwrJ1HQfc4leQqe1zWTa5U5yEV8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=QtJGGna38JvzJnmNtBfSow1lCEyIKqE4xRInTPBSpcwlYKHvwjZBjuyQDDNd7W6oJ
 MBzPflu/pco3+/DLveeDBlmvIR9tYKV7IvwLvUHIZHuXsy7Vz6JBd7ffrdi310uiex
 IJCNSZ5wCrr8iiUKmEQUfuanYNq5T/iZvSpVhkiCtmpM4jX6MxxJucocSX513JrUui
 wT7rPuIWNTcGKvG5HQrqoCMx0xlOadaSnPyJfIgNH3HlWKTzsNi62Uws0697vZKfzy
 Sv2EsXfXN0CtSMPdxjt+99nH8xS/aqYUlUT8aPgctEruKZwP5p02Ks6cIme0xCsDt0
 rHH0UTmZpR2mA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: thinhn@synopsys.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 felipe.balbi@linux.intel.com, mkorpershoek@kernel.org, lukma@denx.de,
 trini@konsulko.com, marex@denx.de, macromorgan@hotmail.com, Wesley Cheng
 <quic_wcheng@quicinc.com>
Subject: Re: [PATCH V2 2/4] usb: dwc3: Increase DWC3 controller halt timeout
In-Reply-To: <20260115230135.183158-3-macroalpha82@gmail.com>
References: <20260115230135.183158-1-macroalpha82@gmail.com>
 <20260115230135.183158-3-macroalpha82@gmail.com>
Date: Thu, 29 Jan 2026 09:51:49 +0100
Message-ID: <87h5s4ol7e.fsf@kernel.org>
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

Hi Chris,

Thank you for the patch.

On Thu, Jan 15, 2026 at 17:01, Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
>
> Since EP0 transactions need to be completed before the controller halt
> sequence is finished, this may take some time depending on the host and the
> enabled functions.  Increase the controller halt timeout, so that we give
> the controller sufficient time to handle EP0 transfers.
>
> This patch was originally submitted to Linux in 2022, but is required to
> use USB gadget mode on my device in U-Boot.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=461ee467507cb98a348fa91ff8460908bb0ea423
>
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/dwc3/gadget.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
