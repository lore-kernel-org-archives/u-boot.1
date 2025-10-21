Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51B6CCD1A5
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 07:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51DD4831D6;
	Tue, 21 Oct 2025 09:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EA2nKqGM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8616E832BC; Tue, 21 Oct 2025 09:41:04 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C07C98004F
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 09:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A0B4622CD;
 Tue, 21 Oct 2025 07:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD621C4CEF5;
 Tue, 21 Oct 2025 07:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761032460;
 bh=Fq8toEmyzdS73KbDd1aNzIzb7qcPUpkFjF+CD2dDb70=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=EA2nKqGMXhJKGg5kzeciA4D3VC72U4XthMmCfIR6B2HvGioBTXFbcsQWzELPmkkGj
 GhqA9xD02ZW45XaSyZGYmIahSkpP53McdmY4IOyq/Gw8kZpsQak1xT4jBXQEimawGx
 sCmTcVQ5knJODPrkh4Z2GceF9oIroYOW8Q7ZaqryA0RKk5GdmwoxwaxPu7KXL6Pbv7
 cH6bYe3GSWyxw5ah+6AQWn/JXllDEYTDWYALyoXIo7kHjAktEOSy5xJCKY9Qcn/MtX
 PjOMY4n6Db4ZweOnC/ETg4UwklEeWbou1NQc2pMMzze0aFNMfLhm9lncebdwqr4jv+
 1kq5m+Fl2ZUng==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede
 <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX
 U-Boot Team" <uboot-imx@nxp.com>, "Ying-Chun Liu (PaulLiu)"
 <paul.liu@linaro.org>, Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth
 <praneeth@ti.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v3 00/20] Convert extension support to UCLASS and adds
 its support to boot flows
In-Reply-To: <20251020171707.GA6688@bill-the-cat>
References: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
 <CAFLszThGVL1powrtDa+niBuxU-b_3YDs6TQ96igx-cj-PGvf=g@mail.gmail.com>
 <20251019162234.GQ6688@bill-the-cat>
 <20251020115009.532a1a99@kmaincent-XPS-13-7390>
 <20251020141548.GS6688@bill-the-cat> <20251020143729.GW6688@bill-the-cat>
 <20251020171613.76ffddac@kmaincent-XPS-13-7390>
 <20251020160527.GY6688@bill-the-cat>
 <20251020190854.4b318829@kmaincent-XPS-13-7390>
 <20251020171707.GA6688@bill-the-cat>
Date: Tue, 21 Oct 2025 09:40:58 +0200
Message-ID: <87h5vsbt2t.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Oct 20, 2025 at 11:17, Tom Rini <trini@konsulko.com> wrote:

> On Mon, Oct 20, 2025 at 07:08:54PM +0200, Kory Maincent wrote:
>> On Mon, 20 Oct 2025 10:05:27 -0600
>> Tom Rini <trini@konsulko.com> wrote:
>> 
>> > On Mon, Oct 20, 2025 at 05:23:45PM +0200, Kory Maincent wrote:
>> > > On Mon, 20 Oct 2025 08:37:29 -0600
>> > > Tom Rini <trini@konsulko.com> wrote:
>> > >   
>> > > > On Mon, Oct 20, 2025 at 08:15:48AM -0600, Tom Rini wrote:  
>> > > > > On Mon, Oct 20, 2025 at 11:50:09AM +0200, Kory Maincent wrote:    
>> > > > > > On Sun, 19 Oct 2025 10:48:37 -0600
>> > > > > > Tom Rini <trini@konsulko.com> wrote:
>> > > > > >     
>> > > > > > > On Sun, Oct 19, 2025 at 02:05:51PM +0100, Simon Glass wrote:    
>> > > > > > > > Hi Kory,
>> > > > > > > > 
>> > > > > > > > On Mon, 13 Oct 2025 at 14:32, Kory Maincent (TI.com)
>> > > > > > > > <kory.maincent@bootlin.com> wrote:      
>> > > > > > > > >
>> > > > > > > > > This series converts the extension board framework to use
>> > > > > > > > > UCLASS as requested by Simon Glass, then adds extension support
>> > > > > > > > > to pxe_utils and bootmeth_efi (not tested) to enable extension
>> > > > > > > > > boards devicetree load in the standard boot process.
>> > > > > > > > >
>> > > > > > > > > I can't test the imx8 extension scan enabled by the
>> > > > > > > > > imx8mm-cl-iot-gate_defconfig as I don't have this board.
>> > > > > > > > > I also can't test the efi bootmeth change as I don't have such
>> > > > > > > > > board.      
>> > > > > > > > 
>> > > > > > > > You can test this with sandbox, using one of the bootmeth tests,
>> > > > > > > > perhaps. Let me know if you need help with this.      
>> > > > > > > 
>> > > > > > > But the question is, does the real hardware platform work
>> > > > > > > before/after this, not does the sandbox test still work
>> > > > > > > before/after this.    
>> > > > > > 
>> > > > > > It seems the bootlflow scan is not working on the sandbox on next
>> > > > > > branch. Is this issue known?    
>> > > > > 
>> > > > > Is it fine on master? The next branch will be out of date until it
>> > > > > re-opens with -rc2 being released (2 weeks from today).    
>> > > > 
>> > > > ... out of sync local calendar, 3 weeks from today, not 2.  
>> > > 
>> > > bootstd test suit is not working on master with the sandbox_defconfig:
>> > > https://termbin.com/un0p
>> > > 
>> > > Noticeable things are;
>> > > test/boot/bootdev.c:160, bootdev_test_any(): 0 == bootdev_find_by_any(seq,
>> > > &dev, &mflags): Expected 0x0 (0), got 0xffffffed (-19) Test:
>> > > bootdev_test_any: bootdev.c (flat tree) test/boot/bootdev.c:160,
>> > > bootdev_test_any(): 0 == bootdev_find_by_any(seq, &dev, &mflags): Expected
>> > > 0x0 (0), got 0xffffffed (-19) Test 'bootdev_test_any' failed 2 times
>> > > 
>> > > And a nice segfault:
>> > > Test: bootflow_set_arg: bootflow.c
>> > > Test: bootflow_system: bootflow.c
>> > > [3]    569337 segmentation fault (core dumped)  ./u-boot
>> > > 
>> > > Maybe things are missing to run sandbox_defconfig on my computer?
>> > > With the sandbox64_defconfig there is not core dump anymore but there is
>> > > still the failed line:
>> > > Test 'bootdev_test_bootable' failed 2 times
>> > > 
>> > > And the uboot is reboot infinitely during the bootflow test:
>> > > ./u-boot -T -c "ut bootstd"
>> > > https://termbin.com/alu5  
>> > 
>> > I see the same thing you do when running them outside of pytest, but
>> > they're also fine within pytest.
>> > https://docs.u-boot.org/en/latest/develop/pytest/usage.html should help
>> > get you started, and you can just run all of the ut tests under that.
>> 
>> Weird I got errors also within pytest.
>> See the html test log attached generated by the following command:
>> ./test/py/test.py --bd sandbox -k bootstd
>
> Same. There's some implicit dependencies around I believe. Doing "-k ut"
> should work, as I tried that (via my wrapper around all this) as well as
> just running all the tests (which is longer).

That's my understanding as well

In Kory's log we see:

        MMC:   Can't map file 'mmc1.img': Invalid argument
           sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
        Can't map file 'mmc1.img': Invalid argument
           sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
                   mmc_probe() mmc1 - probe failed: -1
        mmc2: 2 (SD)Can't map file 'mmc1.img': Invalid argument
           sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
        , mmc0: 0 (SD)

These mmc1.img are needed for the bootstd tests to run properly.

These mmc*.img are generated in test_ut.py (see setup_cros_image() for
example)

So, In order to only run the bootstd tests, I think we need to to run:

    $ ./test/py/test.py --bd sandbox --build -k test_ut
    $ ./test/py/test.py --bd sandbox --build -k bootstd

Then we can just call:

    $ ./test/py/test.py --bd sandbox --build -k bootstd


>
> -- 
> Tom
