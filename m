Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7DDCF64BC
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 05:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 614C183E40;
	Thu, 20 Nov 2025 06:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nathaniel.land
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nathaniel.land header.i=@nathaniel.land header.b="MUyR56TO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 336C383FD3; Thu, 20 Nov 2025 06:55:02 +0100 (CET)
Received: from goldencat.email (goldencat.email [45.45.221.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5B5583E0E
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 06:54:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nathaniel.land
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=i@nathaniel.land
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nathaniel.land;
 s=dkim; t=1763618096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TiYISpTShPqtVN087uaiHJPq/qVeyIXv0rBCuQUFJBM=;
 b=MUyR56TOOLcSx2BgCmqXg6TqsbMu83YjcMGMmjIb0b9dDpqXSkI38svkGPFZAmp2QPmupy
 kYCqZOpm07636nQ5og0s35ckntAC/qN9HwniyYIje3zRu9jLPNJU98MtjugPuVPQDpx6iA
 CLoeen6JN3882auAmn2gHWzgDgiNiu6OJZ8nk2F/4XPHD6h7YfKVXrxoh50CxfVnoubWU0
 8+8sTy3bljqClNLjpw90SS1j86MPc45VqsQ8R+8ZDzZ2ZB83IO0m6Tv6ydTA9CeUTayBoh
 g6owZ8B2ufI6pYY8rcX0siCiFniLKgafnZdSLYkKypJgOh0USY3C1L3rwf8KMw==
Authentication-Results: goldencat.email;
 auth=pass smtp.mailfrom=i@nathaniel.land
Date: Wed, 19 Nov 2025 23:54:56 -0600
From: Nathaniel Hourt <i@nathaniel.land>
To: u-boot@lists.denx.de
Subject: Re: tcp server with tftp
In-Reply-To: <BY5PR09MB49772032490F7E91C03B9760D2D7A@BY5PR09MB4977.namprd09.prod.outlook.com>
References: <BY5PR09MB49772032490F7E91C03B9760D2D7A@BY5PR09MB4977.namprd09.prod.outlook.com>
Message-ID: <faaa20665a2fa04ee12ec08b2c3d1250@nathaniel.land>
X-Sender: i@nathaniel.land
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
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

On 2025-11-19 17:16, Yonkee, Nathan Paul wrote:
> Hello all, I am writing some custom uboot to run a tcp server to 
> communicate with our lab computer. I would like to be able to do a tftp 
> file transfer while the server is connected, but when I try I get error 
> -13. I wrote a custom tcp server with lwip and I am using tftp_loop() 
> to do the tftp transfer.

TFTP is usually a UDP-based protocol... Are you sure you mean to be 
using TCP with it?

If you're just looking to send a file to your device with u-boot, have 
you looked at the wget command? 
https://docs.u-boot.org/en/latest/usage/cmd/wget.html Or are you trying 
to send a file from u-boot to your lab computer?

—
Nathaniel
