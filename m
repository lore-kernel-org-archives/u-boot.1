Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9ECCD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 15:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56072848EE;
	Wed,  3 Jun 2026 17:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gnudd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC1308467E; Wed,  3 Jun 2026 16:57:53 +0200 (CEST)
Received: from mail.gnudd.com (mail.gnudd.com [93.91.132.248])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4B5F8056B
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 16:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gnudd.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rubini@arcana.gnudd.com
Received: from rubini by mail.gnudd.com with local (Exim 4.94.2)
 (envelope-from <rubini@arcana.gnudd.com>)
 id 1wUn2T-0000Q1-8x; Wed, 03 Jun 2026 16:57:49 +0200
Date: Wed, 3 Jun 2026 16:57:49 +0200
From: Alessandro Rubini <rubini-list@gnudd.com>
To: mateusz.furdyna@nokia.com
Cc: biggerbadderben@gmail.com, u-boot@lists.denx.de,
 jerome.forissier@arm.com, trini@konsulko.com,
 andrew.goodbody@linaro.org, Max.Merchel@ew.tq-group.com,
 quentin.schulz@cherry.de, yuya.hamamachi.sx@renesas.com,
 mariusz.madej@nokia.com
Subject: Re: [PATCH] net: clear IP defragmentation state after returning a
 complete packet
Message-ID: <aiBA7bqqKQh2+AQK@arcana.i.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GnuDD, Device Drivers, Embedded Systems, Courses
In-Reply-To: <20260602-ip_defrag-v1-1-f4cc1265cc49@nokia.com>
References: <20260602-ip_defrag-v1-1-f4cc1265cc49@nokia.com> 
X-Mailman-Approved-At: Wed, 03 Jun 2026 17:58:23 +0200
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

> During the IP defragmentation process, after the reassembly is finished
> with the last packet arriving with MF=0, the reassembly state wrt.
> static counters is not cleared. In case this last arriving packet with
> MF=0 gets duplicated, payload bytes are mistakingly treated as hole data.

I agree. Thanks a lot.

   Acked-by: Alessandro Rubini <rubini@gnudd.com>

/alessandro, too old to remember he submitted this code.
