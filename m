Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CCEEED603
	for <u-boot@archiver.kernel.org>; Thu,  1 Jan 2026 14:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD56C83B85;
	Thu,  1 Jan 2026 15:38:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="fmUM1Zne";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C712883B86; Thu,  1 Jan 2026 15:38:14 +0100 (CET)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6262683B23
 for <u-boot@lists.denx.de>; Thu,  1 Jan 2026 15:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j.ne@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 08B93240101
 for <u-boot@lists.denx.de>; Thu,  1 Jan 2026 15:38:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1767278292; bh=uDC7TSgtUloSKd/RmyeKiozu9ifDhZ301jZFUVr3XlU=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:From;
 b=fmUM1Zne9WM2d5V4G44wOfA8AEJCp2MUTGnXzbAYqHfdeAccuTiQkTf36XwmWg8+p
 CoCLvn1T9bMBQiABWETDeq1lNnHVMOdu6U7U01W4/nq56siFCVLTIXTSZk7PtUXj4k
 lUPRGqOx0ImMPWdUcM9RbH/xi2aoyxh8UBtRKKtjNgKxnahiLx7svSiz3Sf80zguZD
 mv71XXaCOqpNVtodFDblS6NBI+YPRlVokdE5jsFLTJJMXzJph7DEqYtX+h6gePp5i/
 1mvrg5eHnIeLpbGqZWi2hrzvG0YHjwQkN/JgqkELn4rcw+yiGRpIOiWAhwcHVi+fIn
 To/C4eh2ipdZw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4dhqDz4dCSz9rxD;
 Thu,  1 Jan 2026 15:38:11 +0100 (CET)
Date: Thu, 01 Jan 2026 14:38:11 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] doc: replace docutils.utils.error_reporting
Message-ID: <aVaG0xO2DSV7CAIy@probook>
References: <20260101142853.19083-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260101142853.19083-1-heinrich.schuchardt@canonical.com>
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

On Thu, Jan 01, 2026 at 03:28:53PM +0100, Heinrich Schuchardt wrote:
> Docutils has dropped reprunicode(), ErrorString() and SafeString() in newer
> revisions. This stops us from using a current docutils, e.g. 0.22.4.
> 
> Use the same definition of ErrorString() as Linux v6.18.
> Drop reprunicode() conversion.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

I didn't see this patch and sent an equivalent one at the same time.
This one works too.

Tested-by: J. Neuschäfer <j.ne@posteo.net>

Thanks!

>  doc/sphinx/kernel_abi.py          | 4 +++-
>  doc/sphinx/kernel_feat.py         | 4 +++-
>  doc/sphinx/kernel_include.py      | 8 ++++----
>  doc/sphinx/maintainers_include.py | 4 +++-
>  4 files changed, 13 insertions(+), 7 deletions(-)
[...]
