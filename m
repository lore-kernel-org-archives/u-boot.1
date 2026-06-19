Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C51DCD98F6
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 04:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 481E384874;
	Fri, 19 Jun 2026 06:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thundersoft.com header.i=@thundersoft.com header.b="GBQILwTe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4418C848EB; Fri, 19 Jun 2026 06:25:34 +0200 (CEST)
Received: from mail-m103131191107.xmail.ntesmail.com
 (mail-m103131191107.xmail.ntesmail.com [103.131.191.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5609D84873
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 06:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=thundersoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hongyang.zhao@thundersoft.com
Received: from localhost.localdomain (unknown [113.235.125.44])
 by smtp.qiye.163.com (Hmail) with ESMTP id 42fe34840;
 Fri, 19 Jun 2026 12:25:26 +0800 (GMT+08:00)
From: Hongyang Zhao <hongyang.zhao@thundersoft.com>
To: sjg@chromium.org
Cc: balaji.selvanathan@oss.qualcomm.com, casey.connolly@linaro.org,
 dlechner@baylibre.com, hongyang.zhao@thundersoft.com,
 jerome.forissier@arm.com, jstephan@baylibre.com, kory.maincent@bootlin.com,
 marek.vasut+renesas@mailbox.org, neil.armstrong@linaro.org,
 peng.fan@nxp.com, philip.molloy@analog.com, quentin.schulz@cherry.de,
 raymond.mao@riscstar.com, rosh@debian.org, stefan.roese@mailbox.org,
 sumit.garg@kernel.org, trini@konsulko.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, visitorckw@gmail.com
Subject: Re: [PATCH 3/3] doc: board: qualcomm: Document RUBIK Pi 3
Date: Fri, 19 Jun 2026 12:25:16 +0800
Message-ID: <20260619042517.44769-1-hongyang.zhao@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFLszTgc0zOkcRnJbVXzVH5J7==fdEg=OQJ0cMtey7-GQB8Dpw@mail.gmail.com>
References: <CAFLszTgc0zOkcRnJbVXzVH5J7==fdEg=OQJ0cMtey7-GQB8Dpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ede20675e09d5kunmadaf7f85252c32
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTR1OVkJOHUhMS0sYQx0YSVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSkhVSUhOVUpJTlVPT1lXWRYaDxIVHRRZQVlPS0hVSk
 tJT09PSFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
 b=GBQILwTeF3GxIx1WHraXNz7520NYo32CcV18cnlmCF1tXQGB5/GfRj0wcUB2d2GJb6pGvMy1nHZUGQXaP5A0FdWlUCPvQhP61CZc53KNPBV1MMUiaZD2gd34Sx7YTyUkPPUL0AGKBinZUNKhauFVLz1wTPYcN8VNd8tH+o7PSt0=;
 s=default; c=relaxed/relaxed; d=thundersoft.com; v=1; 
 bh=L1f5NO5Qz80Q3nGNT6sPbsYvOft0N3RNIbZAijwPTdk=;
 h=date:mime-version:subject:message-id:from;
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

Hi Simon,

Thanks for your review.

On 2026-06-17T10:56:10, Hongyang Zhao <hongyang.zhao@thundersoft.com> wrote:
> > doc: board: qualcomm: Document RUBIK Pi 3
> >
> > Add build and flashing instructions for running U-Boot on the
> > Thundercomm RUBIK Pi 3 and include the page in the Qualcomm board
> > documentation index.
> >
> > Signed-off-by: Hongyang Zhao <hongyang.zhao@thundersoft.com>
> >
> > doc/board/qualcomm/index.rst    |  1 +
> >  doc/board/qualcomm/rubikpi3.rst | 51 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 52 insertions(+)
>
> > diff --git a/doc/board/qualcomm/rubikpi3.rst b/doc/board/qualcomm/rubikpi3.rst
> > @@ -0,0 +1,51 @@
> > +Note that fastboot may not be available after replacing the original firmware.
> > +To restore the original firmware, or to install a new version of U-Boot, EDL
> > +mode can be used with the firehose loader binary appropriate for the board.
> > +
> > +A tool like bkerler's edl_ can be used for flashing::
> > +
> > +  $ edl.py --loader /path/to/prog_firehose_ddr.elf w uefi_a u-boot.mbn
>
> Please can you describe how to enter EDL mode on this board? The
> rb3gen2 page points the reader at the Qualcomm Linux documentation -
> without similar guidance here, a user who bricks the board has no
> obvious recovery path.
>

Got it. I’ll add instructions for entering EDL mode in v2.

> > diff --git a/doc/board/qualcomm/rubikpi3.rst b/doc/board/qualcomm/rubikpi3.rst
> > @@ -0,0 +1,51 @@
> > +First, set up `CROSS_COMPILE for aarch64. Then, build U-Boot for
> > +qcs6490_rubikpi3`::
> > +
> > +  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> > +  $ make qcs6490_rubikpi3_defconfig
>
> Since you are renaming the defconfig in v2, remember to update the
> build instructions and heading reference here to match.

Got it.

--
Thanks and kind regards,
Hongyang
