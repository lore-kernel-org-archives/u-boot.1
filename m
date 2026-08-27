Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E53C61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 09:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F299D406E5;
	Thu, 27 Aug 2026 09:28:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a9kXzUSXsu0S; Thu, 27 Aug 2026 09:28:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787822889;
	bh=YPhsXnPdYw9oYJel9r34vqhRQU8ka51zXAJjqweapYU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H+wy/mPGBFsiIw642StafUpLO27lfa+vr6MwXAfoaWotjFwrkIiaB0rFQum19e8He
	 xAqsY7LEC4mn8niAz6DGD0jzsdSpA4MUr+5YLFfQQbgybDZetHWfWDxdmIX7LjSTW/
	 lxVMsmIahaDNvZSNdrGfsQNvb2s5gjTeoD6b1JkJfTmrzV855yiYazWRjTkOQrFsmS
	 CDCgBiws2OWaEl8OI1tTVGDQzye9uqLWSgwyb+lwTxYDfiZcJML9Y/uokgkG2dV45D
	 9A4vun/4UrE+E4ByLnEQnka0TxSLiTR2jkk9QPIZwvwIv6G85ZQkT5NbAWmMadHUMI
	 5HT9BIJkedlGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CECE440693;
	Thu, 27 Aug 2026 09:28:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8671A1DB1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78CF24066F
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:28:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B1Es0ED_C-RK for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 09:28:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=Jnl8hSr2
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A4C80406B2
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:28:06 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id BE8134E41314;
 Thu, 27 Aug 2026 09:28:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 920CA602B8;
 Thu, 27 Aug 2026 09:28:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8A00611C787BC; 
 Thu, 27 Aug 2026 11:27:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787822879; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=YPhsXnPdYw9oYJel9r34vqhRQU8ka51zXAJjqweapYU=;
 b=Jnl8hSr22UgQv3nK5VTABlvXjDicAoo/cHSaQajXLo4leegkODd8y3uyl83R4u4XDJum71
 TnbsIiTfNA5Ofkudw+pxsVyE40wLqJzlJVTOx0vSa0KIxOd1kZ5No+s+IhFeAWizv/yj1X
 x7VmDASgWPEDza1clsBsAcDh/PrUcuY5PdrjQy2xVK0sQn5Pu4TbTECW+S7XQglTE3i0dD
 dwnNG0RGdsQst5JAoZjmEWmgOl6mjj/MUusBdwkxelWa0WPQfxLB8IaashCzA+ceRK8o4U
 wOs4EfH/3UBt1bb4lo3THm10PiuWxANH3KRaTlh527vfgwbVIDNepmJp3pG11Q==
Message-ID: <5864126e-0282-4681-9135-cf8e89ce69da@bootlin.com>
Date: Thu, 27 Aug 2026 11:27:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] fs/squashfs: bounds checks on image-controlled
 offsets
To: Pranav Rajendran <pranavkasthuri@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: joaomarcos.costa@bootlin.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, trini@konsulko.com
References: <20260815220115.11335-1-pranavkasthuri@gmail.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20260815220115.11335-1-pranavkasthuri@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Le 16/08/2026 à 00:01, Pranav Rajendran a écrit :
> Two out-of-bounds reads reachable from a crafted SquashFS image, found
> while auditing fs/squashfs for image-controlled values used as buffer
> offsets without validation. Both were reported to the list earlier; these
> are the fixes.
> 
> Patch 1 covers sqfs_frag_lookup(), where the fragment index is checked
> only against a superblock field that is itself part of the image, and
> every subsequent access derived from it is unchecked against the buffer
> that was actually read.
> 
> Patch 2 covers sqfs_dir_offset(). Commit 57e0bb7bf00d ("fs/squashfs: add
> sqfs_dir_offset() error checks") addressed the negative return value; the
> positive range is still unbounded, and the callers use it to index the
> directory table.
> 
> Neither patch changes behaviour for well-formed images: the rejected
> cases all describe inodes that reference data outside the tables the
> superblock declares.
> 
> checkpatch-clean, builds for sandbox with no new warnings at W=1, and
> test_sqfs_ls and test_sqfs_load both pass against images generated by
> mksquashfs 4.6.1 (the default plus the three lzo fragment variants).
> 
> Review of the exact bounds is welcome, in particular whether patch 2 is
> too strict in rejecting a directory header that would start within the
> last SQFS_DIR_HEADER_SIZE bytes of the directory table.
> 
> Pranav Rajendran (2):
>    fs/squashfs: bound fragment table accesses in sqfs_frag_lookup()
>    fs/squashfs: bound the offset returned by sqfs_dir_offset()
> 
>   fs/squashfs/sqfs.c     | 50 ++++++++++++++++++++++++++++++++++++++++--
>   fs/squashfs/sqfs_dir.c | 42 ++++++++++++++++++++++++++++++-----
>   2 files changed, 84 insertions(+), 8 deletions(-)
> 
Seems all good!

Reviewed-by: Richard Genoud <richard.genoud@bootlin.com>

Thanks!
