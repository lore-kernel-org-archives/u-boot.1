Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C86CD3427
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 08:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD7B84836;
	Mon, 11 May 2026 10:45:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="m96CApbt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC2E284848; Mon, 11 May 2026 10:45:19 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EA3E84715
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 10:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 1AA491FA0B;
 Mon, 11 May 2026 10:45:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1778489116;
 bh=LlcCJDCrGBAv0GzGeA1Ww4PEFhpUWfi7H0N/ZZm9Yig=; h=From:To:Subject;
 b=m96CApbt3WbdGnL7AkMKIO+z5m2SQBsYjTVWGVRD/PuY9J16Gi0zqi3/tYqfPeTrr
 o08kIcZ374IwMF9ib9VsFcRvU8XR/wzQBgtwLSqPGB6ziUe+SyAdZ7I1uUV9kTmAzs
 YNb063TNahnk7wcYCPLL2umr989byNFAm5Khh9Z1y+mwEihshpR6qJnDF2MSW6Hn4V
 WVNVUDn237cDtc4SUFJKqB+TCSC9GEBa9Pv9BEOqur0EqBHMl4lh069VZRRvC9J+uQ
 6BqrFjk2GquVsqLb2gYeuT66mk/3P496cpEqIbnFUqf6JNjJPfRTGmJhicREO1AoI2
 2pU55NDZJg5zQ==
Date: Mon, 11 May 2026 10:45:12 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: u-boot@lists.denx.de, Sparsh Kumar <sparsh-kumar@ti.com>,
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Bryan Brattlof <bb@ti.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Subject: Re: [PATCH 0/4] board: toradex: k3: Sync rm-cfg with TIFS v12.00.00
 firmware
Message-ID: <20260511084512.GA29876@francesco-nb>
References: <20260508-v1-update-rm-cfg-v1-0-ec9d033f8ec1@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508-v1-update-rm-cfg-v1-0-ec9d033f8ec1@toradex.com>
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

On Fri, May 08, 2026 at 10:52:08AM +0200, Ernest Van Hoecke wrote:
> This series updates the Resource Management configuration for Toradex
> K3-based boards and makes sure the TIFS-specific RM configuration is
> used where applicable.
> 
> For Verdin AM62P, the tifs-rm-cfg.yaml file is refreshed with
> k3-resource-partition V12.00.00 so that it stays in sync with the
> existing rm-cfg.yaml update for the v11.02.09 and v12.00.00 TIFS
> firmware resource reservation.
> 
> For Verdin AM62, the missing tifs-rm-cfg.yaml file is added. The file
> matches the TI AM62x configuration, and rm-cfg.yaml was verified to
> remain unchanged when regenerated with the same tool version.
> 
> For Aquila AM69, both rm-cfg.yaml and tifs-rm-cfg.yaml are updated to
> match the resource allocation changes already present in the TI J784S4
> configuration files.
> 
> Finally, the Verdin AM62 and Verdin AM62P binman descriptions are
> updated to use tifs-rm-cfg.yaml for the TIFS RM fragment when building
> tiboot3 images, following the same pattern used by the corresponding TI
> AM62x/AM62Px platforms.
> 
> The generated/updated files were compared against the matching TI board
> configuration files where applicable.
> 
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

