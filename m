Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BCEC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 17:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 056DF87B25;
	Thu, 28 Dec 2023 18:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0B0C87A40; Thu, 28 Dec 2023 18:23:53 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D94D87A7B
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 18:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 3CB13215AA;
 Thu, 28 Dec 2023 18:23:51 +0100 (CET)
Date: Thu, 28 Dec 2023 18:23:49 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>
Subject: Re: Regression: i.MX6ULL reset not working
Message-ID: <ZY2vJYySJ5CL1PQG@francesco-nb>
References: <ZY2ZDWAQuTlRjV9H@francesco-nb>
 <CAOMZO5BSt4rbdSDNrcchg89qYJ6kK2nkHLFqfjdu21H_joU-jg@mail.gmail.com>
 <ZY2mVMg0532pbuFh@francesco-nb>
 <CAOMZO5AeEWRbpYsNDhno3gEo-0ab01Kd62v8inDt6V40BLqp5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5AeEWRbpYsNDhno3gEo-0ab01Kd62v8inDt6V40BLqp5A@mail.gmail.com>
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

On Thu, Dec 28, 2023 at 02:08:33PM -0300, Fabio Estevam wrote:
> On Thu, Dec 28, 2023 at 1:46 PM Francesco Dolcini <francesco@dolcini.it> wrote:
> 
> > With that we would have to enable the watchdog, something that is not
> > done today. Any potential downside on doing it?
> 
> I don't see any.
> 
> The watchdog was being used originally too, but not via DM.

Are you sure? After the related kconfig changes you'll have CONFIG_WDT
enabled, and with that the watchdog is started and you need to
periodically refresh it. At the moment the watchdog is not enabled at
boot and it is used only for the reset.

While the change might be fine, my concern is that this might affect some use
cases. Debugging? Kernel not having the watchdog driver enabled? Any
other fancy use-case?

Assuming I am not getting this all wrong, and enabling CONFIG_WDT has
no real effects, please correct me if I'm wrong.

Francesco


