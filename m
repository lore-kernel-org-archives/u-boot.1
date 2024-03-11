Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793F1C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 19:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B203C87F00;
	Mon, 11 Mar 2024 20:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="T8fmovKP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B31387E62; Mon, 11 Mar 2024 20:32:20 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87DC087F10
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 20:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 831C620A8B;
 Mon, 11 Mar 2024 20:32:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1710185536;
 bh=ynRtQgnBWOHR99aAzab83ZBliyAvchxySkBa5UYZh2k=; h=From:To:Subject;
 b=T8fmovKP3gQ9tFrarVRd35J1l4jEVEQfR4lsDC34oKHJqyjU0n/AO5hsBcWoCd+3q
 Lk5FZpxLFrbU0V24gFB3vun6acFKT+LMqYERZCTApUoJmWtuXJr5cGHfcFbovZ8Zc6
 FUIR3Pddk99Oe6PWMZ4VmmM5hnIsBUrSTcD8o0OfZp2Fl9fxSWVMj3OCBxzRiP6xjh
 /+jcaZJaXiVN9inCFhd34XRFYOcqeMOCpSx9NwQFJK4FbCGAYohX3/veWPUIlzJW21
 jI/wX47H2PMXl5ksXV7ag5bVn+Ui9SOl+QglWULIO70/c/DYzSaDe/ITSwZ85Pjxd4
 3vnvvB6En/SLA==
Date: Mon, 11 Mar 2024 20:32:11 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>,
 Kumar Gala <galak@kernel.crashing.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 1/2] lmb: Avoid to add identical region in
 lmb_add_region_flags()
Message-ID: <20240311193211.GA4582@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311143918.2927406-2-patrice.chotard@foss.st.com>
 <20240311143918.2927406-1-patrice.chotard@foss.st.com>
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

Hello Patrice,

On Mon, Mar 11, 2024 at 03:39:17PM +0100, Patrice Chotard wrote:
> In case lmb_add_region_flags() is called with the same parameter than
> an already existing lmb and this lmb is adjacent to its previous lmb with
> different flag, this lmb is added again.

Is this

On Mon, Mar 11, 2024 at 03:39:18PM +0100, Patrice Chotard wrote:
> In case a new region is adjacent to a previous region with
> similar flag, this region is merged with its predecessor, but no
> check are done if this new added region is overlapping another region
> present in lmb (see reserved[3] which overlaps reserved[4]).

or this, related to some

ERROR: reserving fdt memory region failed

message in your opinion?

More details in https://lore.kernel.org/all/fe9431c5-6806-1b7a-f9f4-dbe97ee13bba@toradex.com/

Francesco

