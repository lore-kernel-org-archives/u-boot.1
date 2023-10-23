Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCD9C25B47
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 19:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5BD787496;
	Mon, 23 Oct 2023 21:17:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F1B68773E; Mon, 23 Oct 2023 21:17:25 +0200 (CEST)
Received: from mx1.tinet.cat (mx1.tinet.cat [195.77.216.146])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA5886FD1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 21:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xdrudis@tinet.cat
X-ASG-Debug-ID: 1698088640-163e7b5e153a4970001-4l7tJC
Received: from smtp01.tinet.cat (smtp01.tinet.cat [195.77.216.131]) by
 mx1.tinet.cat with ESMTP id m5WkBx1w0npe2pj1;
 Mon, 23 Oct 2023 21:17:20 +0200 (CEST)
X-Barracuda-Envelope-From: xdrudis@tinet.cat
X-Barracuda-Effective-Source-IP: smtp01.tinet.cat[195.77.216.131]
X-Barracuda-Apparent-Source-IP: 195.77.216.131
Received: from xdrudis.tinet.cat (191.red-79-152-186.dynamicip.rima-tde.net
 [79.152.186.191])
 by smtp01.tinet.cat (Postfix) with ESMTPSA id 01680605DE48;
 Mon, 23 Oct 2023 21:17:19 +0200 (CEST)
Date: Mon, 23 Oct 2023 21:17:18 +0200
From: Xavier Drudis Ferran <xdrudis@tinet.cat>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@google.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] general: fix GPL-2.0-or-later SPDX headers
Message-ID: <ZTbGvqHziuSu_z9O@xdrudis.tinet.cat>
X-ASG-Orig-Subj: Re: [PATCH 1/1] general: fix GPL-2.0-or-later SPDX headers
References: <20231022174707.72695-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3q1im+5GwvZ_U8KMERFczD4EbR9T9gG1aeKews3yyZRg@mail.gmail.com>
 <62d107c2-7e24-4ae0-972d-9995b796c9f9@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <62d107c2-7e24-4ae0-972d-9995b796c9f9@canonical.com>
X-Barracuda-Connect: smtp01.tinet.cat[195.77.216.131]
X-Barracuda-Start-Time: 1698088640
X-Barracuda-URL: https://webmail.tinet.cat:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 311
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4807 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=6.0 KILL_LEVEL=8.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.115780
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
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

El Mon, Oct 23, 2023 at 10:21:52AM +0200, Heinrich Schuchardt deia:
> 
> We will need separate patches for LGPL-2.0+ and LGPL-2.1+, too.
>

That'd be for LGPL-2.1+ 
The only case of LGPL-2.0+ in code is included in the patch you sent.
Well, there's another appearance of LGPL-2.0+ in
Licenses/README

