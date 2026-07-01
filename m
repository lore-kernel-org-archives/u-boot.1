Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD954C43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BB9084B86;
	Wed,  1 Jul 2026 13:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="OLspkNWi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71AC184BA7; Wed,  1 Jul 2026 13:12:51 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 584C584AE9
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782904363; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Zedq9Zip3imoBCSmlr2QZnBfOz2OXp3U/HymZogvZSd+lqP1ZDLUOtqRpRyGg7nWsy2NBpDYkTBQ9DHxgNPIliIO0HzRRl+UVH6605/erlD8oQr073syzyGSL30HHJbLzrxIO92xlObTgckaa4DhXmLGTAZAgU/2g4grK1KgDZg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782904363;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=W4inksJwXhSwDsVmITWxuCUn/YO0cC9+7a8qLWsD/Pg=; 
 b=GH8O8NCYUkdnDQMTh4TBKeekedeq9AWP4ovWt/jfmeLwAZxRHmgIGB2zpNzNxUBoPKLHLtoY+nXabj/VI1yli3pwWQtZIS8JKvqHX8H9oNvSo0E7H9do1mGBzndqwynZnLeKYAvYmhp130TnmCTjdCb7kKH05n+UM7MmptEpQn8=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782904363; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=W4inksJwXhSwDsVmITWxuCUn/YO0cC9+7a8qLWsD/Pg=;
 b=OLspkNWiFMpc5DR0XmpGjiwlLnYUGeZDlgzDlyckgad/2kRscf/urCpmsblGIWO2
 13TSJoLwWo85ct/cBx5hzFG2QhY4RhcaxrF3z6jukNDH8XzFwnNKCBk5byloFzWPoux
 /+9ofuNtffRMUbV1I5eb6iEcHjXbDNStWreTHzYw=
Received: by mx.zohomail.com with SMTPS id 1782904360891252.47198170339277;
 Wed, 1 Jul 2026 04:12:40 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:11:52 +0000
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>
Cc: Yao Zi <me@ziyao.cc>, u-boot@lists.denx.de
Subject: Re: Unresolved conflicts after 0d8e33717d7e in MAINTAINERS
Message-ID: <akT1-Mwmc2022vTl@pie>
References: <akT0Mqg2JpDoKVOB@pie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akT0Mqg2JpDoKVOB@pie>
X-ZohoMailClient: External
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

On Wed, Jul 01, 2026 at 11:04:18AM +0000, Yao Zi wrote:
> Hi list,
> 
> I noticed merge commit 0d8e33717d7e ("Merge patch series "arm: aspeed:
> add initial AST2700 SoC support""), which has already landed in next,
> seems to leave a part of conflicted changes unresolved.
> 
> ARM AXIADO AX3005 SCM3005
> M:      Siu Ming Tong <smtong@axiado.com>
> M:      Karthikeyan Mitran <kmitran@axiado.com>
> M:      Prasad Bolisetty <pbolisetty@axiado.com>
> S:      Maintained
> F:      arch/arm/dts/ax3005*
> F:      arch/arm/mach-axiado/
> F:      board/axiado/scm3005/
> F:      configs/ax3005_scm3005_defconfig
> F:      include/configs/ax3005-scm3005.h
> =======
> F:      drivers/pinctrl/aspeed/
> F:      drivers/pwm/pwm-aspeed.c
> F:      drivers/ram/aspeed/
> F:      drivers/reset/reset-ast*.c
> F:      drivers/watchdog/ast_wdt.c
> N:      aspeed
> N:      ast2700
> >>>>>>> 4a72fd9fb09109857303ca64fd259009e1d4b554

Adding list to cc, sorry for the mistake.

> Regards,
> Yao Zi

Regards,
Yao Zi
