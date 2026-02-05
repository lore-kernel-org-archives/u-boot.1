Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06E5E9128B
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 07:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E48B83015;
	Thu,  5 Feb 2026 08:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="ZjXN2HaN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C4398341A; Thu,  5 Feb 2026 08:58:22 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BB048063E
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 08:58:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 306861FB2B;
 Thu,  5 Feb 2026 08:58:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1770278299;
 bh=7I4k7KEkbnPKVamcdSXwUKvSKxyKgUsC7RwKraXOs7M=; h=From:To:Subject;
 b=ZjXN2HaNLlYXAvRMRnIl+fEuhs5jUAAmU7az3bfyvztaxcrjWS49tfAfltHkRSY8U
 dYMufONFxaM39n2pH0VF5SXRfSTXWaq9jxtXDLD0UpFL3Cp+rQquQ9wYx7rQqXPPgG
 VCurZzniPYmTcUsz8I1E9Mo/nTuithWnnBgqGk++r/6JxP7rbApqkXxERzJeD7sxl9
 HAqJ7hk001P7M5MIgYdJipAX9Y/4tIy2pEBgOMGsrLFhmnFkXriVbXJ7+Tbpkaihl0
 BDVDSVRssXYJwAZz2gXfJdEMTWM1p4ogiikGqBLpP4TehLORtgh8nfuqgZ5WgH/W6R
 eD80P9ZEXX76w==
Date: Thu, 5 Feb 2026 08:58:15 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 07/14] toradex: common: Add missing headers
Message-ID: <20260205075815.GA10676@francesco-nb>
References: <20260203-cleanup-v1-0-4221c13e7558@nxp.com>
 <20260203-cleanup-v1-7-4221c13e7558@nxp.com>
 <20260204120855.GA30917@francesco-nb> <aYREqj0kkanBInMi@shlinux89>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYREqj0kkanBInMi@shlinux89>
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

On Thu, Feb 05, 2026 at 03:20:10PM +0800, Peng Fan wrote:
> On Wed, Feb 04, 2026 at 01:08:55PM +0100, Francesco Dolcini wrote:
> >On Tue, Feb 03, 2026 at 06:41:38PM +0800, Peng Fan (OSS) wrote:
> >> From: Peng Fan <peng.fan@nxp.com>
> >> 
> >> Include linux/types.h and asm-generic/u-boot.h. Missing the two header
> >> files will cause building error after cleaning up usage of
> >> asm/global_data.h.
> >> 
> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> ---
> >>  board/toradex/common/tdx-cfg-block.h | 2 ++
> >>  board/toradex/common/tdx-common.h    | 2 ++
> >>  2 files changed, 4 insertions(+)
> >> 
> >> diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
> >> index b28033d8332e09d063a6a8ad1d4e334703077f00..067daec0d776070b0b53fc26d1043d6eb781a527 100644
> >> --- a/board/toradex/common/tdx-cfg-block.h
> >> +++ b/board/toradex/common/tdx-cfg-block.h
> >> @@ -6,6 +6,8 @@
> >>  #ifndef _TDX_CFG_BLOCK_H
> >>  #define _TDX_CFG_BLOCK_H
> >>  
> >> +#include <linux/types.h>
> >> +
> >>  #include "tdx-common.h"
> >>  
> >>  struct toradex_hw {
> >> diff --git a/board/toradex/common/tdx-common.h b/board/toradex/common/tdx-common.h
> >> index d446e9f1d5ca7d3d5a1318b389393d28854e2263..db3369a8f9ef9b409c53c45e94aa5f22933a44fa 100644
> >> --- a/board/toradex/common/tdx-common.h
> >> +++ b/board/toradex/common/tdx-common.h
> >> @@ -6,6 +6,8 @@
> >>  #ifndef _TDX_COMMON_H
> >>  #define _TDX_COMMON_H
> >>  
> >> +#include <asm-generic/u-boot.h>
> >> +
> >
> >maybe just have the forward declaration?
> >
> >  struct bd_info;
> >
> >and that's it?
> 
> I would not add a common declaration here.

Why?

See also commit c3dc39a2f85b ("arm: Don't include common.h in header files")

Francesco

