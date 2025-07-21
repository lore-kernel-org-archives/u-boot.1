Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2613C83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 14:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA65F831AC;
	Mon, 21 Jul 2025 16:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1753107294;
	bh=MPQSHt5OVG7wukLeP5WnStgu71c54/ry2bJQ6oMch68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xTyhvnj882Oo+XcqSCdQbC2I9ujteecVrdbNMXAegMxBnQKZjCq9qv9YsA4Mqg3Tp
	 v3xEA2Rw2TZOX2pSlzKOKKxKZvlNaEJf5sEOE8wlY2oGVx+QOKyQmlynX0bEE9lEaV
	 d7k73FDluh5t8TTYKjAbSzGObQmxpx6twPgqFqTTtqXouf/cvlZ2tgo62MCm74pXDL
	 MDm3O2NJdb4AfpFZMDTCOlplonYno9A6MRTYCMeeQuvTaz39sulQ77XBf/Or/EX7L+
	 /51Y6+kT9NgkTXjK1eEXfb1K3xsIh5u/YtAKVlc5ovuVGmwLva17isecN3PpKKh+d4
	 9CfQcPfh0rMfg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DFAD831B4; Mon, 21 Jul 2025 16:14:54 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F237D83164
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 16:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BFBQI+E5"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A7A081027235A; 
 Mon, 21 Jul 2025 16:14:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1753107290; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=MPQSHt5OVG7wukLeP5WnStgu71c54/ry2bJQ6oMch68=;
 b=BFBQI+E5h9e5/b921ssCPKI1uaed/DaqaEW7ka8PwmFWFhr9fc9K6V/b8xhJp3XHOVMuce
 gtJ2d1wf3EWlifBY8WqW9322t9DRRj0nUklMI/VrZqriZF2ZqwS5civO1ev1LsQG8F3BdO
 RHN3zcUyzEEqPyrBmGOwsCMKGIYDlhnA+cyd9dBxPGS8+F9UawNJBf9yOlVcztsWgIlrrO
 ZcZrAVG8tFJDOiIW89DDnyEbCs8MdeZEcyaUxol1WkZ6CSZhn2Is7d/R7csBeVk7nKGFB2
 AqYQWLUY3ykR5pHP0TF70Up+k2fTbD0GwTg9fOOpo31PI6K4BcfA6qVXPSpBDA==
Date: Mon, 21 Jul 2025 16:14:46 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Fabio Estevam <festevam@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>
Cc: sf@denx.de, u-boot@lists.denx.de, trini@konsulko.com
Subject: Re: Gitlab down
Message-ID: <aH5LVtpBemHhNNAs@antares>
References: <EB8511BA-0BBE-4770-85BC-EA2E8C56E5F5@public-files.de>
 <CAOMZO5ALd2FhnpySAK0pKKRUoNouPR8j6Ssqyv-d=PPZMkekeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5ALd2FhnpySAK0pKKRUoNouPR8j6Ssqyv-d=PPZMkekeg@mail.gmail.com>
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

Hi,

Thank you for the notice. We'll have a look.

Best regards,
Philip

On Mon, Jul 21, 2025 at 10:11:16AM -0300, Fabio Estevam wrote:
> Adding Simon.
> 
> On Mon, Jul 21, 2025 at 7:50 AM Frank Wunderlich
> <frank-w@public-files.de> wrote:
> >
> > Hi,
> >
> > I guess you already know,but gitlab on https://source.denx.de
> > only prints a 502 message since at least yesterday. It does not look like maintanance.
> >
> > I change to GitHub repo,but i want to know if maybe your own gitlab instance will be dropped.
> >
> > I found a thread from december 2024
> >
> > <https://lists.denx.de/pipermail/u-boot/2024-December/573566.html>
> >
> > But no actual one.
> > regards Frank

-- 
=====================================================================
DENX Software Engineering GmbH,
Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
=====================================================================
