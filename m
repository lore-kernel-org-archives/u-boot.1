Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67CBC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32F1B807D7;
	Fri, 28 Feb 2025 11:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="tZGe72Ny";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 279D3809A5; Fri, 28 Feb 2025 11:02:35 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6DAF801FB
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 240C31FB6E;
 Fri, 28 Feb 2025 11:02:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1740736952;
 bh=B5lpBkrSJYbAZFE5bzZNrcFvCG4txBeRA7rJR9uXx9k=;
 h=Received:From:To:Subject;
 b=tZGe72NyWXMJLMi/gfXPJp8Smx+D2QX7cL80GsVVB0OoJlDYKUEiabUgqtmVtxuNM
 7TUM7Sk7uxtRdF3zUNO3Mf80/Qe4MHKGZeCQUrtxZK4pUF6DHEoIdd4hVB+ZlGJfTQ
 A+JeCrdbnjY6QFfCJscFVB2jMNzP72jnNXxlSG+Hqm4j+8F3P6S05SZgkC8f3wTuWn
 EcOmdZmXfA6fJ7GfBdO+1cJzZqZg1aCR6fwhzvIE2E5TM3sXsjEkuO5icuUmLJFHqn
 XGahpFIcOwNmBYTIY1ygV+hftntAx+tTcaAzED0h5Za4BmZ5D/ln+MrI+548CQHXCP
 aobzKWItup9Lg==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
 id BCBBE7FAC5; Fri, 28 Feb 2025 11:02:31 +0100 (CET)
Date: Fri, 28 Feb 2025 11:02:31 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Parth Pancholi <parth.pancholi@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v1 0/2] Support Apalis/Colibri imx6 v1.2
Message-ID: <Z8GJt9PxgFzW007M@gaggiata.pivistrello.it>
References: <20250228095317.621037-1-ernest.vanhoecke@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228095317.621037-1-ernest.vanhoecke@toradex.com>
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

On Fri, Feb 28, 2025 at 10:52:52AM +0100, Ernest Van Hoecke wrote:
> Apalis/Colibri iMX6 V1.2 will replace the STMPE811 ADC/Touch controller
> which is EOL by the TLA2024 ADC and AD7879 touch controller.
> To support this new version, we detect the presence of either the
> STMPE811 or TLA2024 during boot and set a new environment variable named
> "variant". This will allow us to select the correct DT easily.
> 
> "variant" environment variable behaviour:
> - Empty or absent for all versions below v1.2 (STMPE811)
> - "-v1.2" for all versions starting from v1.2 (TLA2024 + AD7879)
> 
> This behaviour is then used by the PREBOOT logic:
> preboot=test -n ${fdtfile} || setenv fdtfile imx6q-apalis${variant}-${fdt_board}.dtb
> 

For the series,
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

