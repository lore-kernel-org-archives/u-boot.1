Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0989C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 20:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40F4788657;
	Tue, 16 Jul 2024 22:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="KdZt1EMk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4584183333; Tue, 16 Jul 2024 22:06:00 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24C2988657
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 22:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id 27CA21F928;
 Tue, 16 Jul 2024 22:05:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1721160357;
 bh=obEujfkBWo+ceiexJmuJAgK80P31SuWcWS9btjckmSo=; h=From:To:Subject;
 b=KdZt1EMkl9t8UYFgl2LLAHDnTWUV0vcxeIxoif2GxXKWYnNMNhU9ePC1V6OUDQ63u
 2jGb2dLJKLKong6BzZ4pzIF+lvjQfJzn0guEqGdpa4XOe3wuLVqGNvoaZf0U7zzXB0
 3EBL1wsa2Zw7PmmbcsjFapYa68wXnPaE+EtSoB3j9gbZlgQSSE5PSBjXy3FiXjcRpn
 I6jNqk5u3NDOndsFHlKVtNoOvoFj8bAUJK/4A3AQlhInfJ40topiJvZwAJ5M8jwmy0
 8ZgB3+AL5YRenKW/hnXO2dAjS/CLxC6JT0G4qXyBwv0PHHlL8dO+ddyhQQCIg30Ir+
 juD9iMbXVAHGg==
Date: Tue, 16 Jul 2024 22:05:55 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Udit Kumar <u-kumar1@ti.com>
Cc: trini@konsulko.com, nm@ti.com, u-boot@lists.denx.de, j-humphreys@ti.com,
 marcel.ziswiler@toradex.com, vigneshr@ti.com, b-padhi@ti.com
Subject: Re: [PATCH] configs: j784s4_evm : Increase Dynamic memory allocation
 size
Message-ID: <20240716200555.GC85916@francesco-nb>
References: <20240715174301.2688466-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715174301.2688466-1-u-kumar1@ti.com>
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

Hello,

On Mon, Jul 15, 2024 at 11:13:01PM +0530, Udit Kumar wrote:
> Increase malloc size to 32 MB to align with other J7
> family devices.

Is this needed for any specific reason? I am asking to understand if
other boards using the same SOC should be updated to prevent
$random_issue.

Francesco

