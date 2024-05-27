Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF18C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 09:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C1F8824B;
	Mon, 27 May 2024 11:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=NetBSD.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EA09882A2; Mon, 27 May 2024 11:45:26 +0200 (CEST)
Received: from mail.duskware.de (mail.duskware.de
 [IPv6:2a00:19e0:3004:291::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BE6988229
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 11:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=NetBSD.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martin@duskware.de
Received: by mail.duskware.de (Postfix, from userid 205)
 id 87DCDA7DC0; Mon, 27 May 2024 11:45:22 +0200 (CEST)
Date: Mon, 27 May 2024 11:45:22 +0200
From: Martin Husemann <martin@NetBSD.org>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v2 00/14] Introduce the lwIP network stack
Message-ID: <20240527094522.GA22281@mail.duskware.de>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <20240527092301.GA7851@francesco-nb>
 <23a33323-35d8-4ece-b57b-cdfbc318d3c4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23a33323-35d8-4ece-b57b-cdfbc318d3c4@linaro.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
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

On Mon, May 27, 2024 at 11:36:26AM +0200, Jerome Forissier wrote:
> You're correct. The point I am making is about using a secure
> (authenticated) connection, and I should have clarified that. While using
> HTTPS might not be critical on a local network, things are different when
> downloading from the internet (think man-in-the-middle attacks).

(Sorry if this sounds like nitpkicking, but I am genuinely curious)
How is it supposed to work?

You need not only https but also verify the presented certificate chain,
and for that you need up-to-date root certificates (e.g. the bundle
available from mozilla).

This sounds a bit outside the scope of u-boot to me (or you should 
avoid the man-in-the-middle argument, which leaves the still valid
"sites stop offering plain http" argument).

If you really worry about man-in-the-middle you need to download via
https in an environment that does certificate validation, and then
even better verify the hash of the downloaded image. After that you
can offer the image locally - via http, https or tftp - for installations.

Martin
