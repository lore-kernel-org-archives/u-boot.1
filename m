Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D73C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 07:19:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF2B440866;
	Fri, 14 Aug 2026 07:19:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2YmKyF-A4Bml; Fri, 14 Aug 2026 07:19:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E843D4085A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786691970;
	bh=BwfwTm09jiZSmBQvA4mJhO6D3+nrUeClWBJ+5w5xVaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xrrKtXVd+Rl31/WbSdz40wQ4E/2hIMcWFWdJuwfb73MT+Mfxx0WSDRXxSc26Ztp8F
	 Twgf5CluQ3bAi1Pl2FsI1n8/yG+cQyIOcf86DrgBV1DNDvr1Aewf9AXeMe1/rTOnhz
	 cFMVlvSPtqwPkj2KBXZ7z19PvDckKcBVxb65QRA20bdo7queJxOFVQo3BK/PoZzhGv
	 aeouN2u8WmUeVjvpizcAx1YuqplcxcinYgb+AAFy7XkN6mLdvj53bwzLr7IA9k4r2c
	 tltiVpFWZOzSiDrz5QeigBoXWkH/HxUl++c6AMGZ3bTvWypEY+TEQweBJ5OS59IiLY
	 2x3xp5awFL+kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E843D4085A;
	Fri, 14 Aug 2026 07:19:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B39AA282
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 96B1160674
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:19:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pl0ZKvAzYi-1 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 07:19:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AE07B60633
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE07B60633
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=tAA7TnM7
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE07B60633
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:19:25 +0000 (UTC)
Received: from francesco-nb (2-224-16-253.ip168.fastwebnet.it [2.224.16.253])
 by mail11.truemail.it (Postfix) with ESMTPA id EC10022C44;
 Fri, 14 Aug 2026 09:19:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1786691962;
 bh=BwfwTm09jiZSmBQvA4mJhO6D3+nrUeClWBJ+5w5xVaE=; h=From:To:Subject;
 b=tAA7TnM7ADZztuhOgT94fGeJ4hG+jfPN6f4I+5zxP3nrZ/aXBFWPlkZS938j5ujwd
 Hqp6BxBjwfuFUz6H6Qqwpvr1JUxcoKVvc6141B1aRSqVvjjSC7YSOUovteOOzKWy7Z
 8x8bvQsdXcQqmfx3IE0dQcegLoVB8ftIP2ZdrIBGG6E5/HXrR5ZAECvcNql7fFxdjC
 mevKDH4cVXiO53vliazwWN0y24hBXTTAMASy2I0o7FAwOvjZGLZ22A0xyq6KnObGiY
 TQ0yw7YvWK6a5wI2ngJZpsfKPQS2XVHyi3evxyhrjrw86I51byyJQkCRkui4WRlJiV
 SVjxTAjFOlODw==
Date: Fri, 14 Aug 2026 09:19:20 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Mehmet Fide <mehmet.fide@gmail.com>, Stefan Agner <stefan@agner.ch>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: Re: [PATCH 1/2] colibri_vf: restore the pre-2017 text base, the
 BootROM refuses the low one
Message-ID: <20260814071920.GB5246@francesco-nb>
References: <20260813150726.2184452-1-mehmet.fide@gmail.com>
 <20260813150726.2184452-2-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813150726.2184452-2-mehmet.fide@gmail.com>
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

On Thu, Aug 13, 2026 at 05:07:25PM +0200, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> Since commit c0f432c37780 ("configs: vf610: increase maximum size and
> enforce correct limit") U-Boot for the Vybrid boards links at 0x3f401000, right
> at the start of the OCRAM gfxRAM area. On a Colibri VF50 the BootROM
> does not start such an image from NAND at all: the module drops into
> the serial downloader, verified by the 0x23454523 UART association
> pattern echoing back. The WinCE-era Toradex loader dies the same way
> when handed such an image with its flashloader command. Relinking the
> same tree at 0x3f408000, the value used before that commit and by the
> vendor fork since, boots through both paths.
> 
> The low 28 KiB of the gfxRAM area are evidently not usable as a load
> address for the ROM, so give them back and correct the size limit to
> match (0x3f480000 - 0x3f408000).
> 
> Tested on a Colibri VF50 128MB IT V1.2B on an Iris carrier: cold boot
> from NAND, both text bases, one build apart.
> 
> Fixes: c0f432c37780 ("configs: vf610: increase maximum size and enforce correct limit")
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>

Stefan: do you remember any of this? any comment?

Unless Stefan says anything against this change, I am ok with it. But I
really have no idea about it, I trust your analysis Mehmet.

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

