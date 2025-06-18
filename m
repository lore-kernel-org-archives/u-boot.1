Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCB3C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 08:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B9D082C2F;
	Wed, 18 Jun 2025 10:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="tBTeykR4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 280DA82D2B; Wed, 18 Jun 2025 10:01:55 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D80882C2F
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 10:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 85AD11F996;
 Wed, 18 Jun 2025 10:01:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1750233712;
 bh=v2mb9hAG/7p8MWvfUwCNzQgdWqCtXs8P0+Ia2r/Dx8A=; h=From:To:Subject;
 b=tBTeykR4aZDydo7LcJ1moeNWwQNVCmV0kl5aTcL9/8vK433lpT/eHRq7msa7fFEC2
 LpTjDUe+eqpcYbfjsnOiXfsjXhBXDRaSlEo3+oW8x8D2hGI392ypav86b0JwLOfTmj
 60eC6tzgpgZXDJEt6t6z6c3llKhJ+Ys2OVX4XsODf9cundTZmLTLl3aoUTQC6hS3I3
 0QyFmRMlhHaPv8CT1A+hKqmpFSQ05E0VpPJdDh/tOfto0ZzeL43f0aSTXC5A8OnFAD
 k30JqKFIL9xIdBYGKrXiWj4DqBj8Y4MJyB654Fs9pgcm3GqAQYW7q3SeX2zTa9ua1S
 FctF8qflqTV+w==
Date: Wed, 18 Jun 2025 10:01:51 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de,
 Enric Balletbo i Serra <eballetb@redhat.com>
Subject: Re: [PATCH v1 4/8] imx: imx8qm: update packing i.MX8QM MEK flash.bin
Message-ID: <20250618080151.GB13226@francesco-nb>
References: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
 <20250618-binman-v1-4-373e66c7a51f@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-binman-v1-4-373e66c7a51f@oss.nxp.com>
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

On Wed, Jun 18, 2025 at 03:30:17PM +0800, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Using this patch, a bootable flash.bin can be generated. It contains
> seco container image, scfw image, u-boot-spl.bin, atf and u-boot.bin.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>

Do also apalis-imx8 needs updates? Or that's not the case? If yes it
should be part of this series.

Thanks,
Francesco

