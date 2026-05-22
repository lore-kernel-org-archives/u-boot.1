Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B345CD5BAF
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 06:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEC14846DD;
	Fri, 22 May 2026 08:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="G7q3cM1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40B16846E2; Fri, 22 May 2026 08:15:23 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5D8C846BD
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 08:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id D44FA1F8CF;
 Fri, 22 May 2026 08:15:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1779430520;
 bh=2E9QymghbNWg8+65ZgfpNMPVivfizpB7VgoQpiRNrgQ=; h=From:To:Subject;
 b=G7q3cM1Uhe/G/sOZ+j1M/WYhmOw7JExUQhtLJFx/wWa/fGE8+fXoO1nN6MXbyZRxk
 h21YGpgNy+2vribHiKMclZbR6F921FnKLuMRpabr13ORRvaU92lxL0TJA4Oi7Qvd2K
 dKZBisvdheZmpSICDWqbIoekUxNoswf4bkXGbgLNzXoAHFOC2zm79UkJBBpaMZI4vc
 /8BeQ/7hvntGxE+yrOhbP6HGVXvLIuKPDf8/AmA0i5fkmW0l6BMeheCQPsCv5W2Epd
 0f4udBxxxfcurcgR9mjifGcIqU73NBqA3FM8vcWO0oEWhZGPsVwd4gSB36WX9IOpHM
 KdaaLqjDlAxlg==
Date: Fri, 22 May 2026 08:15:15 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Shiva Tripathi <s-tripathi1@ti.com>, Andrew Davis <afd@ti.com>,
 Francesco Dolcini <francesco@dolcini.it>
Cc: Ernest Van Hoecke <ernestvanhoecke@gmail.com>, trini@konsulko.com,
 vigneshr@ti.com, bb@ti.com, u-boot@lists.denx.de, u-kumar1@ti.com,
 praneeth@ti.com, kamlesh@ti.com, vishalm@ti.com,
 k-malarvizhi@ti.com, anshuld@ti.com
Subject: Re: [PATCH v2] arm: k3: Kconfig: Enable fTPM and RPMB support
Message-ID: <20260522061515.GA8642@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513142336.GA123538@francesco-nb>
 <b42fe4a0-a0f3-4773-be29-ac881c750799@ti.com>
 <677d1d7c-8276-44f2-b563-d2b0d0a263ea@ti.com>
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


Hello Shiva, Andrew

On Wed, May 13, 2026 at 06:36:40PM +0530, Shiva Tripathi wrote:
> It's not expected for all K3-platforms to build OP-TEE with RPMB
> support, some platforms lack eMMC entirely. fTPM is an optional
> configuration for users who need measured boot, disk encryption, or
> similar TPM related use-cases.
> 
> The Yocto SDK we release for K3 platforms includes the fTPM TA embedded
> in the OP-TEE, not sure if the same is true in your case.
> 
> RPMB provisioning is needed for full functionality, but even without it
> you shouldn't see these errors. Maybe the fTPM TA is missing from your
> OP-TEE build, or something similar is causing loader error.

Any comment on this? We are just integrating current meta-ti master with
latest master U-Boot, as I wrote a few days ago. There is nothing
special going on on our side, and your recent changes are introducing
this unexpected behavior.


On Wed, May 13, 2026 at 08:49:31AM -0500, Andrew Davis wrote:
> This makes me think we are at the stage in boot where EFI variables
> are trying to be persisted to some media, and when trying to use
> the fTPM for this it fails (as would be expected without RPMB).
> So this should be harmless, but why there is such a large error
> printout we need to investigate and try to make it less verbose.

Any chance TI can help on this?


Francesco

