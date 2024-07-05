Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C34AC30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 07:56:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AABB88582;
	Fri,  5 Jul 2024 09:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="avhuw989";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BF5D88684; Fri,  5 Jul 2024 09:56:40 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69BC488261
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 09:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 935131FB37;
 Fri,  5 Jul 2024 09:56:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1720166197;
 bh=VuKEhzDNjwQU35LqMxPx+WFGBwVrCaw5u4uU63fr2jo=; h=From:To:Subject;
 b=avhuw989VuPrYjbvLv4NNXjCBKFTh00OtDTpmVQBUdGQv2fIND4OqbBCt/1wthMAu
 kajSpUOXjEmABaI/sqhh6Z6vy2wzGF6qn831ZxkBLq8m5Au3z8Od4YB8MLQLiB7MF4
 XawSwpxukNd+YQQYofAmAvLO4lBpTakNYXk1qGK8zYAJpwtQDYOa86kJ9Fja9JptjP
 z3vD9Mz3qvOACWuwAhSf69TG+iERJqonX4NLOs/8pV0v8Tcc3nnYmi9XVq6ivJO1qv
 QwUom0HdZtqzrD1sQS26X7laWeRMv9MnzLExgNaHqqRmRuZenVGRrNtC8r3RpxXczh
 I+cYX1Wj8GVfw==
Date: Fri, 5 Jul 2024 09:56:32 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Vitor Soares <ivitro@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>,
 Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] verdin-am62: add DFU, USB and UUU fastboot support
Message-ID: <20240705075632.GA4756@francesco-nb>
References: <20240704154932.434266-1-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704154932.434266-1-ivitro@gmail.com>
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

On Thu, Jul 04, 2024 at 04:49:32PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> Enable USB host as well as USB gadget and DFU support for a53 and r5
> configs. Also, enable UUU fastboot support to download files with
> the UUU tool from a53.
> 
> Additionally, configure usb0 to peripheral mode and add extra
> environment for DFU use.
> 
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

