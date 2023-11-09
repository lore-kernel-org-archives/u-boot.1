Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB86C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 06:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A39E870D2;
	Thu,  9 Nov 2023 07:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2AF286F85; Thu,  9 Nov 2023 07:24:43 +0100 (CET)
Received: from mx1.tinet.cat (mx1.tinet.cat [195.77.216.146])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABC9C87075
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 07:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xdrudis@tinet.cat
X-ASG-Debug-ID: 1699511077-163e7b5e16a9b600001-4l7tJC
Received: from smtp01.tinet.cat (smtp.tinet.cat [195.77.216.131]) by
 mx1.tinet.cat with ESMTP id R2QqXJKqUOuyTOJv;
 Thu, 09 Nov 2023 07:24:37 +0100 (CET)
X-Barracuda-Envelope-From: xdrudis@tinet.cat
X-Barracuda-Effective-Source-IP: smtp.tinet.cat[195.77.216.131]
X-Barracuda-Apparent-Source-IP: 195.77.216.131
Received: from xdrudis.tinet.cat (191.red-79-152-186.dynamicip.rima-tde.net
 [79.152.186.191])
 by smtp01.tinet.cat (Postfix) with ESMTPSA id B5E5F605D080;
 Thu,  9 Nov 2023 07:24:37 +0100 (CET)
Date: Thu, 9 Nov 2023 07:24:27 +0100
From: Xavier Drudis Ferran <xdrudis@tinet.cat>
To: Sean Anderson <seanga2@gmail.com>
Cc: Xavier Drudis Ferran <xdrudis@tinet.cat>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Stefan Roese <sr@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 uboot-imx@nxp.com
Subject: Re: [PATCH v6 08/25] spl: Refactor spl_load_info->read to use units
 of bytes
Message-ID: <ZUx7DA9AAPiddLAs@xdrudis.tinet.cat>
X-ASG-Orig-Subj: Re: [PATCH v6 08/25] spl: Refactor spl_load_info->read to use
 units of bytes
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-9-seanga2@gmail.com>
 <ZUjdhAccsYbJS6AL@xdrudis.tinet.cat>
 <f546ba08-10b9-0cb4-4fa7-f7541dab1288@gmail.com>
 <ZUn577z8xINpURlO@xdrudis.tinet.cat>
 <0fa3a26b-9e28-357f-17bc-8a8cb60a05b0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0fa3a26b-9e28-357f-17bc-8a8cb60a05b0@gmail.com>
X-Barracuda-Connect: smtp.tinet.cat[195.77.216.131]
X-Barracuda-Start-Time: 1699511077
X-Barracuda-URL: https://webmail.tinet.cat:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 208
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4215 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=6.0 KILL_LEVEL=8.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.116503
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

El Wed, Nov 08, 2023 at 10:59:13AM -0500, Sean Anderson deia:
> 
> OK, what about
> 
> @offset: Offset to read from in bytes. This must be a multiple of @load->bl_len.
> 
> --Sean

Great. Thank you.
