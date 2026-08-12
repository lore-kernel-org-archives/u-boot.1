Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2443C5CFDB
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 08:48:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92EB240840;
	Wed, 12 Aug 2026 08:48:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 37wwD_k4wvPe; Wed, 12 Aug 2026 08:48:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E011B40827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786524485;
	bh=LHIPl0z7d6UL9nfbBBoDoqTnomIhiLy1kbkt6KOqUSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fTDAq19aGoRgFAN5f4nwqZSerTXQPKgMpywQpqP45A3LNqHki7s1DtIzWoNWjr/EF
	 Fa9eh+U9GTmxp9LFB0dox9acQudjFC1A0HN45tuLl83HyS2mN4mZiplGvC1h3KZe4b
	 ZfaE7X2Vpm9PAHp1oQK+RzHH2JYVYSsoZLDfKz1dBA6xeZQQK/RFZecoMHWORKgg1Q
	 Ckc4mptNhd946IhEw8g8rVsdQb7K2W8Kc4YGEAC/gvT6bwMKa7CUfwHjrFaaJi6Owv
	 aK8mKtJjm+JEpIh0bf+m54nRV4q2RzDDVsdHwwMeKeQR+14UkFhslfNT/ikMuzxG6/
	 8BBTXtpODKQiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E011B40827;
	Wed, 12 Aug 2026 08:48:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A89BEC
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 08:48:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 63AF9403B2
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 08:48:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tMVZGk_QhC4l for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 08:48:02 +0000 (UTC)
X-Greylist: delayed 147046 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 12 Aug 2026 08:48:01 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C321740109
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C321740109
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C321740109
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 08:48:01 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id AA74B1F8D6;
 Wed, 12 Aug 2026 10:47:57 +0200 (CEST)
Date: Wed, 12 Aug 2026 10:47:53 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: Re: colibri_vf: CONFIG_TEXT_BASE and the Toradex eBoot flashing path
Message-ID: <20260812084753.GA93864@francesco-nb>
References: <20260806124816.262259-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806124816.262259-1-mehmet.fide@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dolcini.it; s=default; t=1786524478;
 bh=LHIPl0z7d6UL9nfbBBoDoqTnomIhiLy1kbkt6KOqUSc=; h=From:To:Subject;
 b=zo3/xYAZoFKBd+4I0yAcIlARvtklkCieOdm8CFRrrzCH+0rNtAGlErPUOk3pvJYFq
 Uf9ZudffSQjTSbLOx9cGujuHHlYxRP7h/aGk3vUZxGlvX954ATaKhxc0e0Q/1Bfz2F
 JYruoUd5wBVYwsuwz9j8cMQNDWs2eiuiI+s1jv4DJqe9JXZiYmAP2oKZoEh9yGld1K
 WszMI2Ow9h6MY+T/baE3B2lNfDojB5cCLe1TBOky1IrxbbwqAFbaTh0IHek/iuJIH0
 9rV4KX7VeHLFLuHz//18T8hF73XSsYA9s9iwvW3FZ0LsYqjR5+fqgh7n5zV58AqaV+
 w/AwIqqT9YkyA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=dolcini.it
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=zo3/xYAZ
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

Hello Mehmet

On Thu, Aug 06, 2026 at 02:48:16PM +0200, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> Hi,
> 
> a report rather than a patch, because I am not sure which way you want it
> solved.
> 
> Colibri VF50/VF61 modules that still carry the Toradex WinCE bootloader
> (here: "Toradex Bootloader 1.7 for Vybrid Built May 1 2020") are flashed in
> production by handing U-Boot to that loader:
> 
> 	> flashloader colibri_vf/u-boot-nand.imx
> 	Bootloader image size: 455448 bytes.
> 	Loading done.
> 	Flashing bootloader.
> 	Writing 223 sector(s) of bootloader code from sector 64.
> 	Flashing completed.
> 	> reboot

what if you powercycle the board, instead of doing a reboot?

> 
> With colibri_vf_defconfig as it is today, CONFIG_TEXT_BASE=0x3f401000, the
> module then prints nothing at all: no banner, no character, on a console
> that works before and after. Building the very same tree with
> CONFIG_TEXT_BASE=0x3f408000, the value the Toradex 2015.04 fork used, the
> image boots normally and the rest of the flashing flow (NAND partitions,
> Linux) completes.
> 
> The difference is only where the image lands in OCRAM:
> 
> 	0x3f401000: IVT entry 0x3f401000, image start 0x3f4004e8, len 0x6d000
> 	0x3f408000: IVT entry 0x3f408000, image start 0x3f4074e8, len 0x6d000
> 
> Our reading is that the loader is still resident when it copies the image
> in, so an image linked at the start of OCRAM overwrites the code doing the
> copy, while 0x3f408000 leaves the low 32 KB alone; we have not proved where
> exactly the loader keeps itself, so treat that as a guess. What is measured
> is the boot/no-boot difference above, on the same module, same card, same
> command, one build apart.
> 
> Booting the same 0x3f408000 image from NAND through the boot ROM works too,
> so the older base is not specific to the eBoot path.
> 
> Is the eBoot path still considered supported for these modules, in which
> case colibri_vf_defconfig would want to go back to 0x3f408000, or is it
> obsolete in favour of recovery mode, in which case it may be worth a note in
> doc/board/toradex? I am happy to send either patch.

I know very little on this board, eBoot and all the related, but my
advise would be the following, U-Boot here should be standalone, and it
should be possible to flash it from scratch on the device.

I would not focus on whatever you are getting pre-programmed on the
board, apart maybe some note in the documentation.

Francesco

