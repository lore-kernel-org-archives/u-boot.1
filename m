Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B76C54764
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 09:10:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DCCB87E20;
	Wed, 21 Feb 2024 10:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="OCe/ZIhW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8819987E26; Wed, 21 Feb 2024 10:10:40 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A09C987DA2
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 10:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id 5AF6A1F94B;
 Wed, 21 Feb 2024 10:10:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708506634;
 bh=8GmTQLSlG4ZNM+pGkFJVnIWLgbkFelRhaPIqLqecJrg=; h=From:To:Subject;
 b=OCe/ZIhWtZn9JrMBaqbB0Fa3EtTQeLB3n4FvuEG2ElKFL1TF+yNTV9YT3u+l7qlHT
 aWvfGINUArLGFhzWmH1IhgVL+NWWas8Da5WLxc0X3jJRE5y5HOLX189SG7TBMRj85f
 g7czNqtjxfkZnpDZhy7+2oP0gRatQLZFG1T1wnpax3/WyhCN5UuP1J0JEOd464KCna
 3AOlydDOfFZVMPptf1wB8bsdAWeLiYQHZHIHb4q+r49AGBb5Ik4/DuhZHqkc3y2UVz
 MgSa0A0ZG344ixd99Fco3Z+Kgdip8GaCzJCdTSGRsOc22Hf/2O0FzAA60pc323kR7N
 hTe0E3kHM/S+A==
Date: Wed, 21 Feb 2024 10:10:28 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@google.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Andreas Dannenberg <dannenberg@ti.com>,
 Romain Naour <romain.naour@smile.fr>
Subject: Re: [PATCH V6 07/20] configs: am62x_evm_a53_defconfig: Switch to
 bootstd
Message-ID: <20240221091028.GA6328@francesco-nb>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-8-nm@ti.com>
 <87f154591fee4979570e78cbc8c73eb0a56469eb.camel@gmail.com>
 <e6222770-cbcd-45e2-94fe-eb55fb0a2f94@siemens.com>
 <5679ced7e927e1eb858a47d25abbd4025b4b67b7.camel@gmail.com>
 <dba0d25f-121d-4146-a78b-ac3beeeb1531@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dba0d25f-121d-4146-a78b-ac3beeeb1531@siemens.com>
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

Hello Jan,

On Mon, Feb 19, 2024 at 07:37:55PM +0100, Jan Kiszka wrote:
> My personal observation is that continuous integration testings with
> all-upstream components is not really a common thing. I saw that with
> multiple active SoCs from various vendors.

With some limitation we have this running in Toradex since a couple of
years, we do integrate latest mainline kernel/u-boot and OE master
layers and run all that through our Lava test suite on real hardware.

It has challenges, even getting the build to succeed is not obvious and
requires continuous care, but we do spot regression on RC releases and
we actively report and/or contribute fixes for it.

Unfortunately the test results are still not published on some website
and are only internal, but we are working on making this available.

Looking forward to have more players doing it, starting from the SoC
vendors!

Francesco

