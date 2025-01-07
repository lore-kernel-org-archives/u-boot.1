Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0102DE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 118FD80608;
	Tue,  7 Jan 2025 16:30:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4889B80654; Tue,  7 Jan 2025 16:30:55 +0100 (CET)
Received: from lisa.dawes.za.net (lisa.dawes.za.net [178.63.77.189])
 by phobos.denx.de (Postfix) with ESMTP id 4205A80601
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lists@dawes.za.net
Received: by lisa.dawes.za.net (Postfix, from userid 1000)
 id 1199D14024C; Tue,  7 Jan 2025 17:30:51 +0200 (SAST)
Date: Tue, 7 Jan 2025 17:30:51 +0200
From: Rogan Dawes <lists@dawes.za.net>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: MUSB compile failure for imx28
Message-ID: <20250107153051.GA21569@lisa.dawes.za.net>
References: <20250102092305.GA18027@lisa.dawes.za.net>
 <CAOMZO5AAtOP8RvyrKJuh4qY7xk+7bS5K5mWT9RZn5E5xKaacxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5AAtOP8RvyrKJuh4qY7xk+7bS5K5mWT9RZn5E5xKaacxQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

On Tue, Jan 07, 2025 at 09:09:09AM -0300, Fabio Estevam wrote:
> Hi Rogan,
> 
> On Thu, Jan 2, 2025 at 1:27 PM Rogan Dawes <lists@dawes.za.net> wrote:
> >
> > Hi folks,
> >
> > I am trying to get a modern u-boot running on my Wink Hub v1 (Hi Fabio!
> > :-)
> >
> > One of the features I am trying to enable is ultimately usbacm console,
> > but in the process of trying to get there, I first tried enabling MUSB.
> 
> There is no MUSB controller on the i.MX28.
> 
> The USB IP on the i.MX28 is ChipIdea.

That would explain it, then! :facepalm:

Thanks

Rogan

