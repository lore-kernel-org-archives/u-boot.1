Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AE8C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 09:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ACED87DCA;
	Mon, 27 May 2024 11:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="p40Tgc7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 620EA87DAB; Mon, 27 May 2024 11:23:08 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 399098826B
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 11:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 5C7531F9C5;
 Mon, 27 May 2024 11:23:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1716801785;
 bh=BJ/jQmt3Kqnyz+0JRwLjBncRrMQmKyITolBVSXCkZxA=; h=From:To:Subject;
 b=p40Tgc7VTqdz7siqhpS7ay/2v2igq+z9wu5ELiNv4tMCOf/XTJqXWMUhEmpm7Rqs0
 +krUg/8Utuw8J5tBsnJvRU8wx9WxiqbVfD517zViydVr2yyB/zR0jLtcpOv4JNMb91
 isC3OzCoJyyWTAAuaGFeZGcgAInC3CexXk/aYqzJvIoHe0dDhpRxoAlAWCeH4VO2+R
 juJSRH5C+el03FQqexTVNLOo2f1AI/4pfMT5rC99Pjwz6mDRdL5zTLkBhojHirpzHB
 kzgE0c51FQWjCLQg7Ljv/tj0k8HtifemD7VUnr3xgKXeK6tiGklRLYfwD+bKrntykY
 90X3s4ntUWE3w==
Date: Mon, 27 May 2024 11:23:01 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v2 00/14] Introduce the lwIP network stack
Message-ID: <20240527092301.GA7851@francesco-nb>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1716566960.git.jerome.forissier@linaro.org>
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

Hello Jerome,

On Fri, May 24, 2024 at 06:19:54PM +0200, Jerome Forissier wrote:
> - Make the support of HTTPS in the wget command easier. Javier T. (CC'd)
> has some additional lwIP and Mbed TLS patches to do so. With that it
> becomes possible to fetch and launch a distro installer such as Debian
> etc. directly from the U-Boot shell.

Why this is enabling this use case? Or it is just that currently,
without TLS, is not supposed to be something you should do?
I am a little bit confused reading this sentence, since to me this is
already possible using tftp.

Francesco

