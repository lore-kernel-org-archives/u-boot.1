Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E45FF8861
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 10:55:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2691783693;
	Mon, 27 Apr 2026 12:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RxyWocW7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BA55839D9; Mon, 27 Apr 2026 12:55:40 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 546C880433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E41BD60138;
 Mon, 27 Apr 2026 10:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89D6C19425;
 Mon, 27 Apr 2026 10:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777287335;
 bh=KnYW0EVLNNhnPzZwOk6bwos0taRMbtm36c04+vY68yM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RxyWocW7o01VFwsat0ntVxyIltBg6HA1hWpiHCyrdeVeGdhtfHS1pkMZCurFMXQLv
 o5M6XwSoGmVKRCF3+rcV1csjjKgZ7iMbWKt00aYX5eqpi+Ng21WIUaCGXep4i+ze5d
 E7BFxgNLPcpO9EnPR0oJDLtfoES83+OxscGLMTGIj1YGNoJkKefPi9vCZbXLNKDSp/
 h96ssFM8yd2AnXG5Fc8XlnWH+VZGBKrrc1ygXaXh4uQCbLdbjY+thvKNyIXI41m716
 Gp3Z437XW0oWG4D/KdI7p/QejitUsbjkYA8kvJ8v+ioCshMmpbEtn85/QrRQ0K+tpf
 GuIo35eZIS4dA==
Date: Mon, 27 Apr 2026 16:25:29 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, neil.armstrong@linaro.org,
 Ajit Singh <blfizzyy@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PULL] Please pull casey/qcom-main-13Apr2026
Message-ID: <ae9AoajWAIRYJbi4@sumit-xelite>
References: <20260419030602.2470577-1-casey.connolly@linaro.org>
 <20260419154026.GV41863@bill-the-cat>
 <ae8JX1O7PGJaFSX8@sumit-xelite>
 <cd9e0278-2642-4a2f-9c56-f238bc0d1bac@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd9e0278-2642-4a2f-9c56-f238bc0d1bac@linaro.org>
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

On Mon, Apr 27, 2026 at 12:30:22PM +0200, Casey Connolly wrote:
> 
> 
> On 27/04/2026 08:59, Sumit Garg wrote:
> > Hi Casey,
> > 
> > On Sun, Apr 19, 2026 at 09:40:26AM -0600, Tom Rini wrote:
> >> On Sun, Apr 19, 2026 at 05:03:16AM +0200, Casey Connolly wrote:
> >>
> >>> Hi Tom,
> >>>
> >>> Various Qualcomm additions this cycle:
> >>> * USB superspeed support for 1 platform
> >>> * Initial support for the Milos platform and the Fairphone Gen 6 (chainloaded from ABL)
> >>> * Improved support for booting with OP-TEE on supported platforms
> >>> * Initial basic power domain support
> >>>
> >>> Notably there is a generic change to the device core, missing power
> >>> domains will no longer cause a device to fail probe and instead will
> >>> just print a warning. This shouldn't affect any existing platforms.
> >>
> >> Unfortunately I get a fail to build in CI:
> >> https://source.denx.de/u-boot/u-boot/-/jobs/1428016
> >> +(qcm6490) drivers/phy/qcom/phy-qcom-qmp-combo.c: In function 'qmp_combo_com_init':
> >> +(qcm6490) drivers/phy/qcom/phy-qcom-qmp-combo.c:288:35: error: unused variable 'cfg' [-Werro
> >> r=unused-variable]
> >> +(qcm6490)   288 |         const struct qmp_phy_cfg *cfg = qmp->cfg;
> >> +(qcm6490)       |                                   ^~~
> >> +(qcm6490) cc1: all warnings being treated as errors
> >> +(qcm6490) make[4]: *** [scripts/Makefile.build:271: drivers/phy/qcom/phy-qcom-qmp-combo.o] E
> >> rror 1
> >> +(qcm6490) make[3]: *** [scripts/Makefile.build:492: drivers/phy/qcom] Error 2
> >> +(qcm6490) make[2]: *** [scripts/Makefile.build:492: drivers/phy] Error 2
> >> +(qcm6490) make[1]: *** [Makefile:2205: drivers] Error 2
> > 
> > Do you plan to re-send this PR with updated USB super speed patch-set
> > from Balaji here [1] which should take care of this CI issue?
> 
> Tom: I'll fix the issue and send a rebased PR, I thought CI was passing
> but I guess I missed that :/ apologies for not doing this last week I
> was OOO.
> 
> v4 doesn't fix this warning, it also changes the fixup logic to use a
> compatible match, im a bit confused by this change since we discussed
> why that approach was preferable in the first place.
> 
> I'd like to understand how significant is the overhead of the old logic
> to justify this.
> 
> I'm going to keep v3 since that's what I tested and we can discuss
> dropping the logic if the overhead is too much.
> 

The overhead for DT traversal here was ~125ms on RB3Gen2. And it can be
much slower on platforms like RB1, see discussion here [1]. We do have
to care about boot time on all platforms. So it is rather better we keep
the boot time under check and hence v4 logic is better here.

[1] https://lore.kernel.org/all/aU5tx8VkWCxwLbHN@sumit-xelite/

-Sumit
