Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD97AE92722
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 03:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2E9083EC8;
	Tue, 30 Dec 2025 04:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.b="FuinNMAT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ED3D83F15; Tue, 30 Dec 2025 04:53:25 +0100 (CET)
Received: from mail2.out.flockmail.com (mail2.out.flockmail.com
 [52.206.209.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 443BF83EA6
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 04:53:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
Received: from localhost (localhost [127.0.0.1])
 by smtp-out.flockmail.com (Postfix) with ESMTP id 4dgK1s1h84z9rwF;
 Tue, 30 Dec 2025 03:53:21 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=yHsOJOSAg9IdqWTbA8SoWkvh6a195ws3umCCYEeLsOg=; 
 c=relaxed/relaxed; d=ziyao.cc;
 h=date:message-id:mime-version:from:in-reply-to:cc:references:to:subject:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
 q=dns/txt; s=titan1; t=1767066801; v=1;
 b=FuinNMATSTQRNhBsRtj2o9LC4e8f1Qe30hGrTQG74nVb8XrxMQ1GBdzjpS1Twc8xB2dsuWD4
 YbXGz7IfiazNB/ChfvoI1+D2/k06tmfFv1n/+FnyStQsXDrYm/YdapRE7GyoY9yqAmG28VeUDIQ
 aq01npK26QD02tpu1vwKyI9g=
Received: from pie (unknown [117.171.66.56])
 by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dgK1q3QH7z9rw4;
 Tue, 30 Dec 2025 03:53:19 +0000 (UTC)
Date: Tue, 30 Dec 2025 03:53:11 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Timo tp =?iso-8859-1?Q?Prei=DFl?= <t.preissl@proton.me>,
 u-boot@lists.denx.de
Cc: trini@konsulko.com
Subject: Re: [PATCH 0/4] fix multiple integer overflows in fs
Message-ID: <aVNMp1yXjwEvjqbs@pie>
References: <20251229194418.69780-1-t.preissl@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251229194418.69780-1-t.preissl@proton.me>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1767066801068400505.21635.722660733644392309@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=a8/K9VSF c=1 sm=1 tr=0 ts=69534cb1
 a=ILiXPvH1yGBXwyP4YTaA5g==:117 a=ILiXPvH1yGBXwyP4YTaA5g==:17
 a=8nJEP1OIZ-IA:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10
 a=GPurIyfZBuU3PN20XBsA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=3z85VNIBY5UIEeAh_hcH:22 a=NWVoK91CQySWRX1oVYDe:22
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

On Mon, Dec 29, 2025 at 07:44:21PM +0000, Timo tp Preißl wrote:
> This series fixes integer overflow issues in several filesystem
> subsystems of U-Boot. Without these fixes, certain size calculations
> could wrap, potentially leading to under-allocation and heap buffer
> overflows.

You should bump the series version when sending a new version of the
series with changes, and provide a changelog and link to the previous
version.

This helps others to distinguish and track different versions of you
patches, and understand what has been changed and what hasn't.

Regards,
Yao Zi

> Timo tp Preißl (4):
>   fs: prevent integer overflow in fs.c do_mv
>   fs: prevent integer overflow in zfs_nvlist_lookup
>   fs: prevent integer overflow in sqfs_concat
>   fs: prevent integer overflow in ext4fs_get_bgdtable
> 
>  fs/ext4/ext4_write.c |  7 ++++++-
>  fs/fs.c              | 16 +++++++++++++---
>  fs/squashfs/sqfs.c   |  8 ++++++--
>  fs/zfs/zfs.c         |  5 ++++-
>  4 files changed, 29 insertions(+), 7 deletions(-)
> 
> tested on:
> make sandbox_defconfig
> -- 
> 2.43.0
> 
> 
