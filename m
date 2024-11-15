Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE68D6DDEC
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 08:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEA1689197;
	Fri, 15 Nov 2024 09:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kemnade.info
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="NlgODE00";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E2C789667; Fri, 15 Nov 2024 09:56:21 +0100 (CET)
Received: from mail.andi.de1.cc (mail.andi.de1.cc
 [IPv6:2a02:c205:3004:2154::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5703888EF7
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 09:56:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas@kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=wZPhoMuxG6ZzIXnY4/JpU/zY56bx3VEME5maAVg8QJA=; b=NlgODE00UVsNJUTILteZdvLkDC
 6XunuYbT6bwOCP0JF75Xm3i0cPx2G6MhfbriCtLB3CnH2pvB0c4He+vYB+M524GrKfong6EAL1Qcq
 Te4VJ0iFsLUG7ii2cZNgeAPP0yNDmQWbNM8F5HUchoC6tCgxs4GfJpTTGI+/+RNksBYJNKKSKRe2k
 LQ2FBn40szqu6gVdL3A+hQ6bda/90ZsldCDUK25ETtsfFUqaJS9Pd6L6T/zjW5gQdhean8BNNYgWX
 8iflMTm66c1tNeVOYroXBk+h5iWZKv54NlTviB8B10R3etq9GKQSGBrNbIUE9Y6fahCBj/xRN+TdA
 KY+0OGwA==;
Date: Fri, 15 Nov 2024 09:56:17 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: u-boot@lists.denx.de
Subject: OMAP4 removal
Message-ID: <20241115095617.08c607ae@akair>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

to my horror I found out that omap4 support is removed. I have some
code waiting for a brush here for the Epson Moverio BT-200. There is
some support for it in postmarketOS. It has a devicetree in mainline
kernel.
I did not manage to get hold of the vendor u-boot source, so when I
distribute sd card images, I use something more u-boot mainline based.
I have a pandaboard and use it as a known reference.
Is there any chance to have omap4 removal reverted? What is needed?
CONFIG_DM_I2C relatev stuff?

Regards,
Andreas
