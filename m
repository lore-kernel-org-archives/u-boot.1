Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CCCC53209
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 17:26:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC18A40763;
	Mon, 27 Jul 2026 17:26:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Unc_IENHWeeO; Mon, 27 Jul 2026 17:26:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C164940604
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785173213;
	bh=pNZ0iHbt3wpdLTnvaoWcFRy6zk4KHpSejvCyLwwgnwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ykntu12C6EjYUO148sSaoE5f1xp4wVtNgMgW1mFNEzxRUUI9+neqJvgvdiCPZry7f
	 Kc8RDtAc9H1sM8ABkd/xZLs7AZwVZfnX8aN+B14lxbpOQNJzMhqkTc/Cdmi7rdkcyn
	 m4u/qv9moYk8NPJfznfn7jU35kHR4gNPcx8LdbvSNQmLoiNmb9nkBQfNL3VVIrECNX
	 l9unFiQjsXCktiH6vpDAY7EHOx9WMiKEopKOhlWDacBIS8ZBR46EMj51uOUfuD1vNu
	 a/Fqjme83n+8Wv1YCjrLYNMnX+xuRrlGQSKIOuCiVTUl10bMlMecEkv9ExdxARYPRb
	 xNaDX4+WeGuoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C164940604;
	Mon, 27 Jul 2026 17:26:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5120B350
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:26:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 42EED40604
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:26:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xPMcu-e8Pivh for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 17:26:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.12;
 helo=sender4-op-o12.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 18975405D6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 18975405D6
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 18975405D6
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:26:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785173195; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=K4qo6wvkeDQymwbL0B9zqlky6itDrNiEdQuHMql1oK46Jn2PNFrif//hCJQsQke7Yp52Ym1BPILVvqM6CzeYGy0ibRf+CkaDZzX9nPZwvypBBAsLuPH8Fd+JJ87On8fhcyObBK7caM6gQwPOXDxGLZv22c1I1/q1P/UbRpcodSU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785173195;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pNZ0iHbt3wpdLTnvaoWcFRy6zk4KHpSejvCyLwwgnwY=; 
 b=mZv3Q13oC1fbWubfxZlhlTH5t050gGg51VVjgX3ZfWG6uSsbSCQgsgPu3BI4US67EF4bSrDYnvoZyu/ARSTuIXzW0ugo3hfOvaIdtC7wfSWeAM965icwmy9AHFrKOizt+S93qg9KIkkbKfz2GGXu/5JuyQ1YqNI81est9YL25FA=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 1785173191821966.3016791972968;
 Mon, 27 Jul 2026 10:26:31 -0700 (PDT)
Date: Mon, 27 Jul 2026 17:26:20 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Subject: Re: [PATCH v6 09/11] doc: spacemit: flash on K1 SoC based boards
Message-ID: <ameUvEoCHjeygBEd@pie>
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
 <20260727-m4-v6-9-2f58566d48ca@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-m4-v6-9-2f58566d48ca@riscstar.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.167.77
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785173195; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=pNZ0iHbt3wpdLTnvaoWcFRy6zk4KHpSejvCyLwwgnwY=;
 b=KQ/8PDs7mnXXR2skQMUYXq1GzXVYb1ud3qDqMFyQoI5o4z+1EPWgvebQQ5MDYe43
 ChBdVve2ckZ58BJYUgcxmONsRGylrJcemQcuWjtOPr+SBxRY2QAC/sQ9q9y9XIJYcgw
 eiXhyz1/eCwcH3NyLMIjBXRnLqWjXb4ZqspAavAs=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=KQ/8PDs7
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Jul 27, 2026 at 02:59:11PM +0800, Eric Chung wrote:
> Add document on how to flash images into eMMC of K1 SoC based boards.
> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> 
> ---
> v3:
> - Add document on how to flash images into SD card.
> ---
>  board/spacemit/k1/MAINTAINERS |   2 +-
>  doc/board/spacemit/index.rst  |   1 +
>  doc/board/spacemit/k1-mmc.rst | 320 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 322 insertions(+), 1 deletion(-)

...

> diff --git a/doc/board/spacemit/k1-mmc.rst b/doc/board/spacemit/k1-mmc.rst
> new file mode 100644
> index 00000000000..b0fe78c75ce
> --- /dev/null
> +++ b/doc/board/spacemit/k1-mmc.rst
> @@ -0,0 +1,320 @@

...

> +Chapter 2: SD Card Boot
> +=======================
> +
> +
> +SpacemiT K1 Bianbu SD Card Image Flashing and U-Boot Update Guide
> +==================================================================
> +
> +This guide explains how to prepare a bootable SD card with Bianbu OS for
> +SpacemiT K1 based boards and how to replace the U-Boot binary on the SD
> +card with a custom build.
> +
> +Prerequisites
> +~~~~~~~~~~~~~
> +
> +- A SpacemiT K1 based development board
> +- A microSD card (at least 8 GB capacity recommended)
> +- A card reader for your host computer
> +- A Linux host system (for ``dd``, ``fdisk``, ``lsblk`` commands)
> +- The Bianbu SD card image from
> +   <https://spacemit.com/community/resources-download/Images%20Collects/K1/Bianbu>
> +- A custom ``u-boot.itb`` file (device tree blob or U-Boot FIT image) to be
> +  written to the U-Boot partition
> +
> +Prepare the SD Card & the image
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +**1. Download the image**
> +
> +Download the released package from the official SpacemiT website:
> +
> +<https://archive.spacemit.com/image/k1/version/bianbu/v2.3.5/Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.img.zip>
> +
> +**2. Extract the image**
> +
> +.. code-block:: console
> +
> +   $ unzip Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.img.zip
> +
> +**3. Identify the SD card device**
> +
> +Insert the microSD card into your card reader, then run:
> +
> +.. code-block:: console
> +
> +   $ lsblk
> +
> +Compare the output before and after inserting the card to identify
> +the new device. It will typically appear as ``/dev/sdb``, ``/dev/sdc``,
> +or ``/dev/mmcblk0``.
> +
> +**4. Write the image to the SD card**
> +
> +.. code-block:: console
> +
> +   $ sudo dd if=./Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.img of=/dev/sdb bs=1M status=progress
> +
> +The SD card is now ready as a bootable Bianbu system disk.

This looks out of scope of describing how to create a bootable SD card
with U-Boot. In my opinion, you'd better describe the requirements of
parition layout and image position for SD-card booting, to allow readers
to create their own images/bootable medium from scratch more easily,
instead of sticking to the vendored image.

Best regards,
Yao Zi
