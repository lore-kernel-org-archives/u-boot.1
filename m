Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EB1CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F21B8390D;
	Mon, 27 Oct 2025 17:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="07YtBOrF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24E998391B; Mon, 27 Oct 2025 17:52:33 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA04482E34
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 57E9B1F9D0;
 Mon, 27 Oct 2025 17:52:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1761583949;
 bh=OySco++81cP42C/vfq3MQOZBlEFVNYnCTg14/78t2Fo=; h=From:To:Subject;
 b=07YtBOrFHAn0UclVEpRqos5TQ8m89gmSkgDMwrSnQZ+FNy5647k0sCFAMxVQOm/iB
 8JknLEOc7WBXwUD8yiBW7lA+eXzpu7t7r+6ajvu9omQvlYhXF4FoVlQVUxwiKy3oXp
 GwYhd2TpJyj1EgDAJYhVusmuR0sXv2K6IYs2STgFZ/IlDncfJV8NWkd2uok+3t6yF8
 A26Ocj1Xuhl/X6+vIzyrKwzfM5aCr2zVrykR3FYbe8H5FoLFA2txyZXuB8NR3Zfnyg
 Hb0XKpvMXgues5Y95+I5HDYSbJH9rlm+QJEI7Ab525a76DlEtjqoHW5lLeH3wNttXo
 SJdmQg75GdeyA==
Date: Mon, 27 Oct 2025 17:52:25 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, d-gole@ti.com, b-padhi@ti.com, vigneshr@ti.com,
 trini@konsulko.com, nm@ti.com, robertcnelson@gmail.com,
 w.egorov@phytec.de, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, m-chawdhry@ti.com, afd@ti.com, bb@ti.com,
 u-kumar1@ti.com, devarsht@ti.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [REGRESSION] Re: [PATCH v11 00/11] Add support for dynamic MMU
 configuration
Message-ID: <20251027165225.GA71553@francesco-nb>
References: <20251017131540.3636067-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017131540.3636067-1-anshuld@ti.com>
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

Hello Anshul,

On Fri, Oct 17, 2025 at 06:45:22PM +0530, Anshul Dalal wrote:
> Hi all,
> 
> In U-Boot, TI only provides a single memory map for all k3 platforms, this
> does not scale for devices where atf and optee lie outside the range 0x80000000
> - 0x80080000 and 0x9e780000 - 0xa0000000 respectively.
> 
> There are also issues for devices with < 2GiB of memory (eg am62SiP with 512MiB
> of RAM) as the maximum size for the first DRAM bank is hardcoded to 2GiB in the
> current memory map. Furthermore the second DRAM bank is mapped even for devices
> that only have a single bank.
> 
> Therefore this patch set adds the required functionality to create the MMU table
> at runtime based on the device-tree.
> 
> The patch set has been build tested on all effected platforms but boot-tested
> only on TI's K3 EVMs, the beagleplay and phytec's phycore-am6* platforms.
> 
> The following effected boards have not been boot tested:
>  - verdin-am62

it seems that this series introduce a regression on verdin-am62, I have
not done a bi-sect yet, but we run daily build of U-Boot master and the
regressions seems to have started when this patch series was
merged.

On verdin-am62 we detect the RAM size at run-time, see
board/toradex/verdin-am62/verdin-am62.c:dram_init(), and now we always
get 2GiB even for modules with only 512MB or 1024MB of memory.

I'll try to find sometime to bi-sect this, but maybe you already have
some suggestion on what to look for.

Thanks
Francesco

