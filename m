Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B2CC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 14:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F703875FF;
	Thu, 26 Oct 2023 16:38:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="uYj1l48J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C159F87B5B; Thu, 26 Oct 2023 16:38:16 +0200 (CEST)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1E47875EE
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 16:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
 :Date:subject:date:message-id:reply-to;
 bh=RAbJoZzI7RAYfFx23Hfq/7OawJNP7JXFchpuvUY/z5Y=; b=uYj1l48J+uVxgXu+tLSHdpjp+L
 e1nSzQLkty+cCsEs0oBx20xQY88RVqzLXLjdktqwMILAo0FWKOPlN3jmGS8rxMQekhz2j3on4t4Go
 2pv0r+8t9qsnvTxaf8XxOXNYjR1vmyxj8z8IvnY6f/xtweOt/47wkVeMhmvXHXFDGpGE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41652
 helo=pettiford) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1qw1Ur-00087F-Ie; Thu, 26 Oct 2023 10:38:06 -0400
Date: Thu, 26 Oct 2023 10:38:05 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
Message-Id: <20231026103805.81d1236a9ce15eeb9cbd43d4@hugovil.com>
In-Reply-To: <CAOMZO5DyK+PDgk=2cOsQogVb+vCP=WhyR3MK8isYtm_KoAbESQ@mail.gmail.com>
References: <20231023152629.2727547-1-hugo@hugovil.com>
 <CAOMZO5DyK+PDgk=2cOsQogVb+vCP=WhyR3MK8isYtm_KoAbESQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH] MAINTAINERS: Remove non-working address from MAINTAINERS
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
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

On Thu, 26 Oct 2023 11:25:19 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> On Mon, Oct 23, 2023 at 1:45 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The Subject does indicate which board it refers to.
> 
> It would be better to have it like:
> 
> imx8mn_smm_s2: Remove non-working address from MAINTAINERS
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> 

Hi Fabio,
since the change concerns two different boards, that is why I didn't
indicate it. If required, I could send it as two separate patches.

Hugo.
