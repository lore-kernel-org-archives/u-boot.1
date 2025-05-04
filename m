Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA58DC369C2
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 02:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C1368215D;
	Sun,  4 May 2025 04:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9B8382163; Sun,  4 May 2025 04:24:53 +0200 (CEST)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C37CB8210D
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 04:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.147.253])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 330283430F3;
 Sun, 04 May 2025 02:24:47 +0000 (UTC)
Date: Sun, 4 May 2025 02:24:32 +0000
From: Yixun Lan <dlan@gentoo.org>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: "Meng, Tingting" <tingting.meng@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@altera.com>,
 "Ng, Boon Khai" <boon.khai.ng@altera.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "Rosdi, Danish Ahmad" <danish.ahmad.rosdi@altera.com>,
 "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@altera.com>,
 "Lim, Jit Loon" <jit.loon.lim@altera.com>
Subject: Re: [PATCH v1 1/5] arm: socfpga: agilex5: Add MMU mapping region
Message-ID: <20250504022432-GYA457276@gentoo>
References: <20250421051126.13799-1-tingting.meng@altera.com>
 <LV8PR03MB81376E5ED82217C31D926AEBA7B82@LV8PR03MB8137.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV8PR03MB81376E5ED82217C31D926AEBA7B82@LV8PR03MB8137.namprd03.prod.outlook.com>
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

On 06:32 Mon 21 Apr     , Chee, Tien Fong wrote:
> 
> 
> > -----Original Message-----
> > From: Meng, Tingting <tingting.meng@altera.com>
> > Sent: Monday, April 21, 2025 1:11 PM
> > To: u-boot@lists.denx.de
> > Cc: Marek Vasut <marex@denx.de>; Chee, Tien Fong
> > <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> > Hea, Kok Kiang <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> > <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
> > Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Rosdi, Danish
> > Ahmad <danish.ahmad.rosdi@altera.com>; Zamri, Muhammad Hazim Izzat
> > <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> > <jit.loon.lim@altera.com>
> > Subject: [PATCH v1 1/5] arm: socfpga: agilex5: Add MMU mapping region
> > 
> > From: Tingting Meng <tingting.meng@altera.com>
> > 
> > MMU mapping regions were added for the second and third DDR memory
> > banks.
> > 
> > Signed-off-by: Tingting Meng <tingting.meng@altera.com>
> > ---
> >  arch/arm/mach-socfpga/mmu-arm64_s10.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> [...]
> Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>
> 
You can simply reply to cover letter to give all patches a Reviewed-by
(No need to do for each)

and use tools like - b4 trailers to collect

-- 
Yixun Lan (dlan)
