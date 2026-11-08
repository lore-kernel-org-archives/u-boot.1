Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78228606A31C
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q+RaXUTA;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=VINRFE1m
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D203940648;
	Sun,  8 Nov 2026 16:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5y9D-jmTFDkX; Sun,  8 Nov 2026 16:31:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2119D4061A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794155486;
	b=Ckv77hSlWX5vi0kaCMbo+ECNR4To3aI4JCjU/lvkPMxtObum1hUnU0hYLqzpYLPTVATw
	 d9U3RXptDQwiL8mPjD8FyNBF5Q/6Y0KXCoZEDCKQLQvKePDTXOjAlMQAJrXduxK/mAXC/
	 nQmu1HXGuQqgpZN+3C42ovfPQ40qEJ1C2EEMVs9bDA40av9wkP0epo7V409gK6CtDgoVu
	 LBQ3WlRMFlU1nfB6FHDxeHOXHeGwkP6lM6Ra7u9fgQDG0A5YUoBqDJZULdGKGd1n52fMt
	 3Ld4gN5F1sHg/y4qdoYIv6143O9lbdY7d793s8TUe1C++dYw7vsq0nLPWFMzF3fiakA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794155486;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fXu30UbmjJZUDXIvrtsOv0cZ78FNETKgLdWNNRX0A0k=;
	b=RDK7pxPG4xCxC4SBWgrZKSN6sXOi61uqM755TNL3Nu5+DMFNzQ7cIWM97nVqETFqdgAI
	 gkfke/EB9+j1hOE9PNXirnhLF70gFLiKNMeNrlKGlx5HyyYKurtqaqyW1c+aVEfCEfBzN
	 c5A5g2I3cv0Yli8vUTVrIlua6ddFjQVLmyi+1h4lMDjD1ZZVU1UwJU3WL9nP2i03x18t+
	 e2T9IxHQEjTwzlsmSTQVr5K7XG87OFtK/xoZPQb1OijOcNSTagPNfgS7j3F4eiCYS+ZoV
	 6iwXCa5LLzaiK3v3GHBn/xpq0VbXVI4rlheQbIvbEfSNNKsZb9Ml1jHUH9tUB3QuH5A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794155486;
	bh=fXu30UbmjJZUDXIvrtsOv0cZ78FNETKgLdWNNRX0A0k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q+RaXUTAia/fF2yXoW2Mj6bmT4/Tda61EQyWsVcOTXOs9+B1MjgpwG/iSaYnPIY0L
	 Kqp/0iChLt0LaZI4pP+1RYsisyd42e463nojzWYXJyNjh+j9fzg+TCsM2nVmcVTwfW
	 JIGnUwbtvgVEL03Tt3o9DfMfSf49ifPqplccMjQ3jCjwVZj/NsOOajMUpbZykfAuUe
	 B38rJXlt7zINVEPb4Q5SdH6sWTdmlfcg4G4cjnhP2pO/Nz8csKhiJJs3pxJrLMN9xV
	 1ZyBFgTy4xebDaKR6v6CzVMihTaY5XT/kUad08OUM/dJClkkOE0y0Crov6wiP/48dS
	 IwQhG6h5LI7Ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2119D4061A;
	Sun,  8 Nov 2026 16:31:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A1D39D1
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 16:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5BC906061D
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 16:31:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7VagqeqnsD0t for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 16:31:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9F609605F8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=VINRFE1m
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F609605F8
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 16:31:22 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jMz1x0V99zMlLH;
 Sun, 08 Nov 2026 17:31:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794155477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fXu30UbmjJZUDXIvrtsOv0cZ78FNETKgLdWNNRX0A0k=;
 b=VINRFE1mTCyJ9jmN5ykRX+n9f2HnqomqqlTs/fhEGfvomG0htzQjT5of/OxR9e4uFeVPki
 hTRMd5b9EBDUqnjQPhQWH29yiuyz9v08Xmds12r5w6JVc3GZEDJfa4WiyCgBU021AvGI9V
 qtQXb5MPh7KEOk7Yzwl1dj9dQW/wNqZsn3jACD7i4FSh1INagQcNoUVwHM79wTe27a6NzN
 AtPWT3dCnbz6XV40eEBNHB0pdhozmVIFutT4oQS0xxvXyKQSKVcIsnNaV5DKIdLVHIWks9
 R2qRIKYwyUhoebEVz7/5sl9E/bVlPhyteZyjwN0Xdh3yftS19LwtOpzcXeEBtA==
Message-ID: <434743b6-17af-477d-a09f-d110d565f023@mailbox.org>
Date: Sun, 8 Nov 2026 17:31:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] dts: build the DTS from a directory outside the
 tree
To: Vincent Jardin <vjardin@free.fr>, u-boot@lists.u-boot-project.org
Cc: Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Tom Rini <trini@konsulko.com>
References: <20261108155019.1485598-1-vjardin@free.fr>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261108155019.1485598-1-vjardin@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1210c196f465597dda4
X-MBO-RS-META: 1t36azq9ejng9kreqcbxhdakhizpjc1z
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/8/26 4:50 PM, Vincent Jardin wrote:
> A board whose DTS is not in U-Boot does not have a clean way to build it.
> 
> Today the build systems copy the sources into the tree and follow its
> layout: Buildroot has copied BR2_TARGET_UBOOT_CUSTOM_DTS_PATH into
> arch/<arch>/dts since 2017 [1][2], and had to learn
> dts/upstream/src/<arch>/<vendor> for OF_UPSTREAM boards this September [3];
> Yocto layers copy their .dts into arch/<arch>/dts and sed a dtb-y line
> into its Makefile [4], copy their -u-boot.dtsi there [5], or tell the user
> to patch the dts into the U-Boot source [6].
> 
> This series adds a way to build it from a directory outside the tree:
> 
>      make EXT_DTS_DIR=/path/to/dts DEVICE_TREE=myboard
> 
> The benefits for the build systems:
> 
> - Buildroot: BR2_TARGET_UBOOT_CUSTOM_DTS_PATH could become a make option,
>    EXT_DTS_DIR=<dir> in UBOOT_MAKE_OPTS, for every U-Boot layout at once,
>    without the copy, the sed, or the question of where the -u-boot.dtsi
>    goes: next to the .dts. A U-Boot upgrade no longer moves the files.
> 
> - Yocto: a BSP layer adds EXTRA_OEMAKE += "EXT_DTS_DIR=${UNPACKDIR}/dts"
>    and keeps its device trees in the layer, versioned with the board, not
>    with the U-Boot recipe; a UBOOT_CONFIG with several configurations
>    passes its DEVICE_TREE per configuration as before.
> 
> - A bring-up, or a board whose device tree is maintained with the
>    kernel's, keeps one device tree repository for both; nothing is copied
>    into U-Boot until the board goes upstream.
> 
> Patch 1 makes "make DEVICE_TREE=<name>" build that device tree in the
> directories built through scripts/Makefile.dts, which listed Kconfig's
> only (the VisionFive 2 report [7]). Patch 2 looks for <name>-u-boot.dtsi
> next to the .dts before arch/<arch>/dts. Patch 3 adds EXT_DTS_DIR.
> 
> It was tested on main at 2515b39e3f1 using:
> 
> - imx8mp_evk (OF_UPSTREAM, SPL, binman): with its .dts copied out of the
>    tree, the external build gives dt.dtb, u-boot.dtb, u-boot.itb,
>    spl/u-boot-spl.bin and flash.bin identical to the in-tree build,
>    in the <vendor>/ layout. A *-u-boot.dtsi next to the source is taken
>    first. Touching the source rebuilds, nothing else does.
Upstream your hardware support and you won't need external DTs.

Also, regarding 3/3 , directories (not folders).
