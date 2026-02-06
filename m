Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4457EECD9AA
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 00:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB64D831AC;
	Fri,  6 Feb 2026 01:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nwl.cc header.i=@nwl.cc header.b="DObm3jao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6874683AA4; Fri,  6 Feb 2026 01:43:22 +0100 (CET)
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4893183015
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 01:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=phil@nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
 s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fT90w+jcPZQMhw/bjAKhr1MgL/fxQWJCGNEwGJepIds=; b=DObm3jaoWfe3j0oy5jyTnsBogo
 jX3dloXriwdSwO3RxSNT1dz4TvsFJmBk+MpWw+joakxHkw1pZmyPsOIzTBUJJzHcGnRDJ5tvY8jQI
 hPGS7aG02py7OW2Nxo4GkLvroPjkKRYCkCPGoP/P8ia+N/IbCfaMRqaxzAZn6Mzk/hwWrDvOfJ+QM
 MVQiCtG6ZQXopMVfMiHxBPjn1DDat3k9zWe3xexU/DnCcfp4qXSJxsv4r3T1svEjlMUweBPgIfgrX
 GSj2TrVI8nrXJEy9gSs8HZtDJa6IwqOSiaL6DR6Zf9+bAJmoxZgjd80+2hEZhbP8lGXIuvKFMYhDz
 MlkNM1AA==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
 (envelope-from <phil@nwl.cc>) id 1vo9wL-000000005Ws-1Aqu;
 Fri, 06 Feb 2026 01:43:17 +0100
Date: Fri, 6 Feb 2026 01:43:17 +0100
From: Phil Sutter <phil@nwl.cc>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Brian Sune <briansune@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, adsp-linux@analog.com
Subject: Re: [PATCH v2] arm: spl: Ensure 8 byte alignment of appended DTB
 without separate BSS
Message-ID: <aYU5JSRC985d49hn@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Brian Sune <briansune@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 adsp-linux@analog.com
References: <20260130183635.2612933-1-trini@konsulko.com>
 <20260205234158.3768337-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205234158.3768337-1-trini@konsulko.com>
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

On Thu, Feb 05, 2026 at 05:41:58PM -0600, Tom Rini wrote:
> Historically, when we have an appended device tree and also our
> resulting binary will contain the BSS section, we have ensured that
> everything will be where it's expected to be by declaring that the BSS
> is overlayed with a symbol matches the end of the port of the ELF binary
> that is objcopy'd to the binary we concatenate with. This in turn means
> that the logic to generate a "pad" file, which is the size found in the
> __bss_size symbol, will be correct and then we can concatenate the
> device tree and it will begin at __bss_size at run time.
> 
> With commit 5ffc1dcc26d3 ("arm: Remove rel.dyn from SPL linker scripts")
> we removed this overlay as part of trying to ensure that we met both the
> requirements of the device tree to be 8 byte aligned as well as that our
> logic to generate the -pad file would match what ended up in the
> resulting binary. While it was correct to remove an unused section it
> did not solve ultimately solve the problem for all cases.
> 
> To really fix the problem, we need to do two things. First, our final
> section prior to _image_binary_end must be 8 byte aligned (for the case
> of having a separate BSS and so our appended DTB exists at this
> location). This cannot be '.binman_sym_table' as it may be empty, and in
> turn the ELF type would be NOBITS and so not copied with objcopy. The
> __u_boot_list section will never be empty, so it is our final section,
> and ends with a '. = ALIGN(8)' statement. Second, as this is the end of
> our copied data it is safe to declare that the BSS starts here, so use
> the OVERLAY keyword to place the BSS here.
> 
> Fixes: 5ffc1dcc26d3 ("arm: Remove rel.dyn from SPL linker scripts")
> Reported-by: Brian Sune <briansune@gmail.com>
> Reported-by: Phil Phil Sutter <phil@nwl.cc>
> Signed-off-by: Tom Rini <trini@konsulko.com>

On Synology DS414:

Tested-by: Phil Sutter <phil@nwl.cc>

Thanks, Tom!
