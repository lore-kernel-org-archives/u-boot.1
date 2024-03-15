Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B734AC54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D52E87FCC;
	Fri, 15 Mar 2024 16:35:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="Cgve6rG/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A4C587FFE; Fri, 15 Mar 2024 16:35:50 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98A5087FAA
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:35:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id AB6021FA91;
 Fri, 15 Mar 2024 16:35:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1710516947;
 bh=FWP7N2cJf6MuHZYSEoK8ifKI6yPhGKeYJxTGETZGPxQ=; h=From:To:Subject;
 b=Cgve6rG/0TtIjQlrAXMQhJ9Kn4occmGe0KJfMczIwH4A/gWPKLX8rXJVRONTXWbKs
 hazWtcZfQY9OaGdWpV6MDFgBmsS1Sfexg6m5edX4Hp1GRnUc8OzlxTXS6qPE8u05Eu
 SedYTyKx99xVpjLRD1WLx8SwDNVtVG83yhjmRlvM3kRzcIahAQUXHf/rJd8qi4ClHl
 TyekhvHksLhjGHwwAL+y7jNMSKVt6nQNtQTDJINwiwBarJJvaaSzIyjY0hd0jbbOgF
 gDt0H+4Xf9BZ+tulJIVcugl2yj4Se75o9lDnbePY15q6Yu9j/PggH+jKeNIzaaDJ5C
 zIddQt856kelA==
Date: Fri, 15 Mar 2024 16:35:43 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH v1] doc: board: colibri-imx8x: Update and improve
 documentation
Message-ID: <20240315153543.GA4032@francesco-nb>
References: <20240315143930.29155-1-hiagofranco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315143930.29155-1-hiagofranco@gmail.com>
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

On Fri, Mar 15, 2024 at 11:39:30AM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> Update and improve the building documentation of Colibri iMX8X.
> The following changes were made:
> - imx-atf repository changed to nxp-imx GitHub.
> - imx-atf branch updated to 'lf_v2.6'.
> - imx-seco updated to version 5.8.7.
> - nxp-imx mfgtools link updated to GitHub releases.
> - General writing improvements.
> 
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

