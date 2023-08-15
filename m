Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA861C0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 17:09:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A2486384;
	Tue, 15 Aug 2023 19:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E322A86940; Tue, 15 Aug 2023 19:09:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B4D4786366
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 19:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 441061063;
 Tue, 15 Aug 2023 10:09:51 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.35.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 903EC3F64C;
 Tue, 15 Aug 2023 10:09:07 -0700 (PDT)
Date: Tue, 15 Aug 2023 18:08:58 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: nd@arm.com, u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [PATCH 2/2] configs: sandbox: test: dm: blk: Enable NVMXIP QSPI
 and update test
Message-ID: <20230815170858.GA446212@e130802.arm.com>
References: <20230813214659.441964-1-marek.vasut+renesas@mailbox.org>
 <20230813214659.441964-2-marek.vasut+renesas@mailbox.org>
 <CAPnjgZ0rCX+hUn2rtH-gpVB9X+Rfv-FTGoxGsB8tKa0e_QEBGA@mail.gmail.com>
 <85390ee0-acf3-8e39-1074-250e07bf5e5f@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85390ee0-acf3-8e39-1074-250e07bf5e5f@mailbox.org>
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

Hi,

On Tue, Aug 15, 2023 at 12:45:57AM +0200, Marek Vasut wrote:
> On 8/15/23 00:42, Simon Glass wrote:
> > On Sun, 13 Aug 2023 at 15:47, Marek Vasut
> > <marek.vasut+renesas@mailbox.org> wrote:
> > > 
> > > Enable NVMXIP QSPI driver on sandbox, since it is already enabled
> > > on sandbox64. Update blk tests to match.
> > > 
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > ---
> > > Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > ---
> > >   configs/sandbox_defconfig |  1 +
> > >   test/dm/blk.c             | 63 +++++++++++++++++++++++++++++++--------
> > >   2 files changed, 52 insertions(+), 12 deletions(-)
> > > 
> > 
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> NAK, this one has to wait. All of this NVMXIP stuff needs closer look, I
> think it is really weirdly broken and doesn't even pass sandbox and
> sandbox64 tests. Can Abdellatif try and check whether ALL sandbox and
> sandbox64 tests pass with this enabled ?

Initially the NVMXIP feature has been introduced with sandbox64 support.

The test case runs fine on sandbox64.

I've just sent a commit enabling NVMXIP for sandbox [1].

Tested on both sandbox and sandbox64.

I hope this helps.

[1]: https://lore.kernel.org/all/20230815164300.444701-1-abdellatif.elkhlifi@arm.com/

Cheers
Abdellatif

