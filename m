Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5CDCDB466
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F1E847C8;
	Thu, 25 Jun 2026 10:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="elNYAObY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D77D8848F0; Thu, 25 Jun 2026 10:08:39 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F86A84704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:08:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 3A9724E408CB;
 Thu, 25 Jun 2026 08:08:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 087D05FF03;
 Thu, 25 Jun 2026 08:08:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2622E106C8210; 
 Thu, 25 Jun 2026 10:08:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782374916; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=CTdMyzsgtZY27ZOSwlp41pC9H2y1+zx63n11CXl47pM=;
 b=elNYAObYiU3blaClDMDjJYCHMBbmFxGbxItGwgbCNh7I4itfOQvXKIhgqdIhREtoBEyl9f
 rvKVRMd34xfMdaeCV3jwMnqVft1IkXsRAs/Ich0ptAbjg97StRAsAq1/b/3SsNMRVpw5/D
 TP2qjNjngcl1wpiCy3kHZSsFraCfdfyg4OECZW7Fmv5ZKTRld3qAAWqMIreP0sDDoWmS1D
 qpSjl95ll4a84rNfJWrrpgzmYTXD4edlBaoDWAvOPDoYBu5jYIZqcDKggE1EmQmsOu9x1p
 s1IUbVPi9h9oFkQNNya0HsLtSjfp4NSE1cX3vYHRihK+rkXSLrfMUZdNDdvp9A==
Message-ID: <cef44406-c4cf-4795-931f-e0b110d36282@bootlin.com>
Date: Thu, 25 Jun 2026 10:08:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fs/squashfs: fix two out-of-bounds reads on crafted
 images
To: Piyush Paliwal <piyushthepal@gmail.com>, u-boot@lists.denx.de
Cc: joaomarcos.costa@bootlin.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, trini@konsulko.com, eric.kilmer@trailofbits.com
References: <20260612075424.83462-1-piyushthepal@gmail.com>
Content-Language: en-US, fr
From: Richard GENOUD <richard.genoud@bootlin.com>
Organization: Bootlin
In-Reply-To: <20260612075424.83462-1-piyushthepal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Piyush,

Le 12/06/2026 à 09:54, Piyush Paliwal a écrit :
> Two independent out-of-bounds reads in the SquashFS driver, both reachable
> by pointing U-Boot at an attacker-supplied image (e.g. ls/load on a crafted
> USB/SD/netboot rootfs). Either one crashes the bootloader (DoS); patch 2 can
> also copy adjacent heap memory into the loaded file (information disclosure).
> 
>    1/2 sqfs_find_inode()/sqfs_inode_size() walk the decompressed inode table
>        using on-disk sizes with no check that the cursor stays inside the
>        buffer -> wild read / SEGV, e.g. from a simple "ls".
>    2/2 sqfs_read_nest() uses the on-disk fragment offset as an unbounded
>        source index into the fragment block -> out-of-bounds heap read when
>        loading a fragment-backed file.
> 
> Both were found by fuzzing the sandbox build (CONFIG_ASAN) of sqfsls/sqfsload
> with mutated images. With the fixes, the crashing inputs are rejected
> cleanly, 2000 fuzz iterations produce no further crashes, and the valid-image
> path is unchanged.
> 
> These are distinct from the 2024 SquashFS CVE cluster (CVE-2024-57254..57259,
> fixed in 2025.01-rc1) and from the sqfs_frag_lookup() fix (e365a269df5): the
> earlier work added NULL checks at the callers and fixed the symlink-size and
> fragment-table paths, but left these inode-table-walk and fragment-data
> paths unbounded.
> 
> The two patches are independent and can be applied in either order.
> 
> Piyush Paliwal (2):
>    fs/squashfs: bound the inode table walk in sqfs_find_inode()
>    fs/squashfs: bound fragment offset/size in sqfs_read_nest()
> 
>   fs/squashfs/sqfs.c            |  50 ++++++++++++----
>   fs/squashfs/sqfs_filesystem.h |   6 +-
>   fs/squashfs/sqfs_inode.c      | 106 +++++++++++++++++++++++++++++-----
>   3 files changed, 134 insertions(+), 28 deletions(-)
> 
Those patches look good.

NB: a patch correcting the same issue as patch 1 was sent 12 hours 
earlier by Hem Parekh, but it fixes less problems than this one.

Reviewed-by: Richard Genoud <richard.genoud@bootlin.com>

Thanks!
