Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1355CC3DA66
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 03:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CDFC864BA;
	Thu, 24 Aug 2023 05:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gUA4/X5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0CC8864BA; Thu, 24 Aug 2023 05:27:23 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F93186556
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37O3R9Nn102860;
 Wed, 23 Aug 2023 22:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692847629;
 bh=KwuKf6I0rM5kJ0zAPZnBc0ILhBKjJaswItpeoNZoFYQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=gUA4/X5k1hVUNqZ7c8ZzoB1sdKEEf/sXFt8AEO+/rgE3co7wByC55KX7mZQQcCV8t
 8VWigS7DZBeA9w/yKE73XxCA602gCKrg+eVrzG/lr4UWSAL9eONcWVXSePXsBpj0eI
 bj0B2RDU5ZRSgZlU7W/Ag768fHtnWx8/j3dr57jM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37O3R9Wp008371
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Aug 2023 22:27:09 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 22:27:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 22:27:09 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37O3R9x3026638;
 Wed, 23 Aug 2023 22:27:09 -0500
Date: Wed, 23 Aug 2023 22:27:09 -0500
From: Nishanth Menon <nm@ti.com>
To: Simon Glass <sjg@google.com>
CC: Tom Rini <trini@konsulko.com>, Neha Francis <n-francis@ti.com>, Bryan
 <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
Message-ID: <20230824032709.phneggflsw2ps2dv@reanalyze>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ1wGkq66ZEXHUVzLpc47fYgV0+Kk9WNwqDWcO0R7jEYVA@mail.gmail.com>
 <20230823171502.GQ3953269@bill-the-cat>
 <CAPnjgZ2t2aUnreA8Hzg11moQ2Z5hqW1r-16WTF0PRMjK3iXe_A@mail.gmail.com>
 <20230824001848.vgzl7rcphic3gu2n@carnival>
 <CAPnjgZ2qxm0KGFp5dM2Jzzcuib5npXodhYQ6u+dbO3oSBHA55A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2qxm0KGFp5dM2Jzzcuib5npXodhYQ6u+dbO3oSBHA55A@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 21:01-20230823, Simon Glass wrote:
> Hi Nishanth,
> 
> On Wed, 23 Aug 2023 at 18:18, Nishanth Menon <nm@ti.com> wrote:
> >
> > On 17:57-20230823, Simon Glass wrote:
> > [...]
> > > > This is how we have a common bit of rST for how to build N boards,
> > > > without having to do a literal copy and paste N times.
> > >
> > > How about using this?
> > >
> > > https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#substitution-definitions
> >
> > I was not able to succeed with complex includes such as:
> > https://github.com/u-boot/u-boot/blob/master/doc/board/ti/am62x_sk.rst?plain=1#L89
> >
> > am62x complete build procedure defined once and reused in other am62x
> > platforms.. But the am62x build procedure itself is reused from common
> > k3 build steps.
> 
> I followed through these instructions. I find the env vars quite
> confusing, since I don't really know what it is doing. It feels like a
> script:
> 
> do $a $b $c
> do $f $e
> 
> it is pretty hard to follow. I think it would be better to write
> everything out in full for each board, like rockchip does.

Unfortunately, this is a few major steps that is repeated for
(currently):
	AM62x SK
	Toradex Verdin
	(pending: beagleplay - )
	(once all the dust clears up, hopefully phytec)
	SK-LP
	....

I have no reasonable way to offer to keep them all in sync.
	https://libera.irclog.whitequark.org/u-boot/2023-07-26#34662854;
is kind of why I went down this path.S

> 
> Some other minor feedback:
> 
> - The 'make' lines should really have -j $(nproc) added

Different styles of shells..

> - The $ signs at the start of each command in the docs are a pain
> since it stops me copying the commands into the terminal - can you
> remove them?

hehe.. "dont" let people blindly copy paste without understanding what is
going on argument?

If folks are OK, I sure can send a different patch series for that.. (or
maybe motivate someone to do that instead of me ;))


> - It doesn't build for me:
> 
>   BINMAN  .binman_stamp
> Image 'ti-dm' is missing external blobs and is non-functional: blob-ext
> 
> /binman/ti-dm/blob-ext (ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f):
>    Missing blob
> 
> Some images are invalid
> make[1]: *** [/scratch/sglass/cosarm/src/third_party/u-boot/files/Makefile:1115:
> .binman_stamp] Error 103
> make[1]: Leaving directory '/tmp/b/play'
> make: *** [Makefile:177: sub-make] Error 2


^^ Neha: This is what I was complaining about.

https://u-boot.readthedocs.io/en/latest/board/ti/am62x_sk.html?highlight=am62#sources

source: https://git.ti.com/git/processor-firmware/ti-linux-firmware.git
is missing, we never used to break build previously binman converted now does.

I am wondering if I need to explicitly call out git clone instructions
out..

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
