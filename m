Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96688CF3186
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 09:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 603C783F2F;
	Wed, 19 Nov 2025 10:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="gnVSsXOe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E18E83A8C; Wed, 19 Nov 2025 06:40:41 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42C088397A
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:40:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DBAF910A453; Wed, 19 Nov 2025 06:40:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763530836;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=fhZTasBjZaeplN+wNG1OsdKA3RfQwWaMUw9Q+W4aJoY=;
 b=gnVSsXOezaDuJLLzqkJXv1gRZgx7K4ps6IaBe/juIobIdroJx0d/AbFVpTPN5Lt3z4oE1+
 j89vU+lTb8m9HYHEdRNvd8J/fOr/VnYs3wW1QxgAdE2qOrrQQI8tz4Mh2Au9qmiFViVpM3
 KCES6eVOfJElGTNXPTk0T8h33v309bIZ5X8d9kzITbcPIdaWnSDjFfH3d/078/a681VsA7
 YwisS6WltYzL0vfPK72EPqZnxaQ8jWC6w0+xhOFs1XuVm92pOL7xOJRKcEPxMVusYvlM5D
 IzfMALiH7yxx2ACxHU5uyS+QyQA6Rzi7tk5rpFvYdi1nQxpIPc1ziHuKkL0EDA==
Message-ID: <2d9173e4-6b86-79d6-8d7d-f6d953efe61d@nabladev.com>
Date: Wed, 19 Nov 2025 06:40:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 0/6] Add support for SM3 secure hash
Content-Language: en-US
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Greg Malysa <malysagreg@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Sean Edmond
 <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 briansune <briansune@gmail.com>
References: <20251118043042.27726-1-hs@nabladev.com>
 <CAMDkj5x_9Vo5S4cA1OGbzhzwNsgs+fKryuLve1mm3H9eK9tLzw@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <CAMDkj5x_9Vo5S4cA1OGbzhzwNsgs+fKryuLve1mm3H9eK9tLzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Wed, 19 Nov 2025 10:51:00 +0100
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

Hi Raymond, Ilias,

On 18.11.25 16:11, Raymond Mao wrote:
> Hi Heiko,
> 
> On Mon, Nov 17, 2025 at 11:30 PM Heiko Schocher <hs@nabladev.com <mailto:hs@nabladev.com>> wrote:
> 
> 
>     Add SM3 secure hash, as specified by OSCCA GM/T 0004-2012 SM3 and described
>     at https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02
>     <https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02>
> 
>     TPMv2 defines hash algo sm3_256, which is currently
>     not supported and prevented TPMv2 chip with newer
>     firmware to work with U-Boot. Seen this on a ST33TPHF2XI2C
> 
>          u-boot=> tpm2 init
>          u-boot=> tpm2 autostart
>          tpm2_get_pcr_info: too many pcrs: 5
>          Error: -90
>          u-boot=>
> 
>     Implement sm3 hash, so we can fix this problem.
> 
> 
> Did you add a Measured Boot CI test for SM3 on any boards? The QEMU test with swtpm I added might 
> not work since it does not support SM3 (Currently it is configured to SHA256 only) .

Not yet, I have to look how I can setup this, as Ilias also mentioned
that. Any chance to setup this with QEMU and swptm ? Ah, if I see it
correct no SM3 support yet in swtpm ?

bye,
Heiko
> 
> Raymond
> 
>     Azure build:
>     https://dev.azure.com/hs0298/hs/_build/results?buildId=194&view=results
>     <https://dev.azure.com/hs0298/hs/_build/results?buildId=194&view=results>
> 
>     Changes in v3:
>     Added Reviewed-by from Ilias
>     rebased series to
>     commit: 69cc92d6869 ("Merge tag 'efi-2026-01-rc3' of
>     https://source.denx.de/u-boot/custodians/u-boot-efi
>     <https://source.denx.de/u-boot/custodians/u-boot-efi>")
>     add comments from Ilias
>     - use sizeof(*sctx) instead of sizeof(struct sm3_context)
>     - use output[] instead of output[SM3_DIGEST_SIZE] comment from Ilias
>        This leaded to CI error:
>        +lib/sm3.c:241:50: error: argument 2 of type ‘uint8_t[]’ {aka ‘unsigned char[]’} with
>     mismatched bound [-Werror=array-parameter=]
>        +  241 | void sm3_final(struct sm3_context *sctx, uint8_t output[])
>        +      |                                          ~~~~~~~~^~~~~~~~
>        see:
>     https://dev.azure.com/hs0298/hs/_build/results?buildId=192&view=logs&j=182673a4-17b9-5c0c-69ad-98f742450579&t=34b689f8-3e29-5ffe-50ea-32bfe99f47c7&l=334
>     <https://dev.azure.com/hs0298/hs/_build/results?buildId=192&view=logs&j=182673a4-17b9-5c0c-69ad-98f742450579&t=34b689f8-3e29-5ffe-50ea-32bfe99f47c7&l=334>
>        so made this change back to v2 state of the series, to have the same
>        arguments as the other hashes in lib/
>     - seperate linux and U-Boot parts into 2 commits
>     New in version 3 as Ilias recommended to split linux
>     and U-boot changes.
>     use CMD_TEST instead of DM_TEST, as Heinrich confirmed
>     add comment from Ilias
>     - add SM3 support in tcg2_hash_pe_image()
>     Added Reviewed-by from Ilias
> 
>     Changes in v2:
>     rebase to
>     6b27b688694: ("Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh
>     <https://source.denx.de/u-boot/custodians/u-boot-sh>")
>     add Ilias to Series-cc
>     add sm3_hash to header file, so we can use it.
>     add comments from Ilias
>     - use ARRAY_SIZE(hash_algo_list) instead of a fix number
>        in tpm2_get_pcr_info() for the count of supported hashes
>        in U-Boot.
>     - add SM3 hash in tpm_tcg2
>     Added Reviewed-by tag from Heinrich
> 
>     Heiko Schocher (6):
>        lib: Import rol32 function from Linux
>        lib: import sm3 256 hash parts from linux
>        lib: sm3: implement U-Boot parts
>        test: cmd: hash: add unit test for sm3_256
>        tpm2: add sm3 256 hash support
>        test: cmd: fix a typo in md5 test
> 
>       MAINTAINERS               |   7 +
>       boot/Kconfig              |   1 +
>       cmd/Kconfig               |  15 ++
>       cmd/Makefile              |   1 +
>       cmd/sm3sum.c              |  48 ++++++
>       cmd/tpm-v2.c              |   1 +
>       common/hash.c             |  42 ++++-
>       include/linux/bitops.h    |  11 ++
>       include/tpm-v2.h          |  12 ++
>       include/u-boot/sm3.h      |  35 +++++
>       lib/Kconfig               |   7 +
>       lib/Makefile              |   1 +
>       lib/efi_loader/efi_tcg2.c |   3 +
>       lib/sm3.c                 | 312 ++++++++++++++++++++++++++++++++++++++
>       lib/tpm-v2.c              |   4 +-
>       lib/tpm_tcg2.c            |   9 ++
>       test/cmd/hash.c           |  49 +++++-
>       17 files changed, 554 insertions(+), 4 deletions(-)
>       create mode 100644 cmd/sm3sum.c
>       create mode 100644 include/u-boot/sm3.h
>       create mode 100644 lib/sm3.c
> 
>     -- 
>     2.20.1
> 
>     base-commit: 69cc92d6869b8ff4591e5b8850872da34934bab9
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
