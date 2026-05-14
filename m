Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D007CD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 09:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB2BF8341A;
	Thu, 14 May 2026 11:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="VUDmzgVH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95978838BB; Thu, 14 May 2026 11:19:49 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6511180F0E
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 11:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 742C52292C;
 Thu, 14 May 2026 11:19:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1778750386;
 bh=jCbubNtMvBOfoNhsQEKeBIKf3NKL2FaCZDUVdj+HFVQ=; h=From:To:Subject;
 b=VUDmzgVHyOog3wnpeP+U7uoGQvEjaq5g74aawEgnC7a4Q0tPxM4OrGGe/I7ub2tbJ
 dG2kQpSGNv9LOffNCgePyNoRf23SPTRpT7QmhVSVzhCCE02jAFgjgt3MsQXXo6bdh5
 NuYIhMh9r26lAIMm5jUjN4z1LzObfsrjSqLzy5ie4DfGdQTYEXUi6IFWSn4S/9Qpg5
 m/UfhudE3Q6OD7s00mhjNJ/ixxTIQ2z2WRzpYzPyNI5XR4zVvVu2Ugu8noxHcwKM6w
 ZlHpJUFDro39CEyImxKHFI8qT1ktXjD0g8pLGvRYIwwf2dRlocYYm3ctlbX34ticdM
 RjJsFj7+m4OPQ==
Date: Thu, 14 May 2026 11:19:42 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH v1] arm: dts: k3-am69-aquila: fix combined boot firmware
 image build
Message-ID: <20260514091942.GA11740@francesco-nb>
References: <20260514091516.2784772-1-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514091516.2784772-1-ghidoliemanuele@gmail.com>
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

On Thu, May 14, 2026 at 11:15:12AM +0200, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> The combined boot firmware firmware-aquila-am69-gp.bin depends on
> tiboot3-am69-gp-aquila.bin, which in turn requires the GP variant
> of the TI system firmware blob (ti-fs-firmware-j784s4-gp.bin).
> 
> Fix the combined boot firmware image build by adding the missing binman
> nodes.
> 
> Fixes: f62d4535cf17 ("arm: dts: k3-am69-aquila: add combined boot firmware image")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Tom: for master, thanks

