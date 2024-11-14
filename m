Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1714D6A249
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 22:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30A8489328;
	Thu, 14 Nov 2024 23:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1914B89653; Thu, 14 Nov 2024 20:41:44 +0100 (CET)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi
 [62.142.5.82])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33A6C89251
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 20:41:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=andy.shevchenko@gmail.com
Received: from localhost (88-113-24-75.elisa-laajakaista.fi [88.113.24.75])
 by fgw21.mail.saunalahti.fi (Halon) with ESMTP
 id 77efda10-a2c0-11ef-887a-005056bdd08f;
 Thu, 14 Nov 2024 21:41:40 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 14 Nov 2024 21:41:40 +0200
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] doc: replace invalid GPL-2.0+ SPDX identifier
Message-ID: <ZzZSdMH82HhQNmWn@surfacebook.localdomain>
References: <20241114103501.10014-1-heinrich.schuchardt@canonical.com>
 <20241114145851.GG3600562@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114145851.GG3600562@bill-the-cat>
X-Mailman-Approved-At: Thu, 14 Nov 2024 23:19:54 +0100
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

Thu, Nov 14, 2024 at 08:58:51AM -0600, Tom Rini kirjoitti:
> On Thu, Nov 14, 2024 at 11:34:59AM +0100, Heinrich Schuchardt wrote:
> 
> > GPL-2.0-or-later is the correct spelling of the SPDX specifier.
> > 
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> 
> I would reword this to say that GPL-2.0-or-later is the now accepted
> SPDX tag for this license and that GPL-2.0+ has been deprecated for some
> time. And please follow-up with a checkpatch.pl patch to ERROR on using
> the old and not new license. All that said, if you can do the commit
> message I can update everything excluding upstream dts files in one go.

+1 here. There is nothing wrong with the GPL-2.0+. It's just old variant.
FWIW, Linux kernel is okay to use it even in a new code.

-- 
With Best Regards,
Andy Shevchenko


