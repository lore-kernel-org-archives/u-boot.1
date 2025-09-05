Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC860CA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 08:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B01C83734;
	Fri,  5 Sep 2025 10:19:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1757060396;
	bh=BmRz50A//B5ez36P0GZfnGwdEuG2hSZN5MQKwcbnL/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MVkSY6p5F5iRE2vF7bAXOemsXA7+u6Djz0+bAlyluKlKrYp9ySugvuPzVkg0BEkL9
	 QrfcsfOAF12kBKFJkVLb/UfjvCZXovwkSBfiieefCsmGLiQLbhcvQaoqOi2H4nzJAw
	 r9PaNWqXkLPbGbMT5BKURWFuo1ANwAusgWr7LAzEPlDm9qANxHviMB8t3itUB0jKOY
	 qeVw/zn8IktRDILJwRG7Gfn2lDGx9NC30ozGa/7u3Kb64Kz4h3biBxCsEJkDGoQdRS
	 q8Sqqk7ESFkyux7CIHs9Ra7F8ymksx2IDjfFTihei5lDlgvR+vvboVafoLovyP+UEb
	 1Dz7QzHaAv/OQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26FE9838CC; Fri,  5 Sep 2025 10:19:56 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46AC483390
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 10:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Oo8hxdgn"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 532E41026E167; 
 Fri,  5 Sep 2025 10:19:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1757060392; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=BmRz50A//B5ez36P0GZfnGwdEuG2hSZN5MQKwcbnL/Q=;
 b=Oo8hxdgnU9ucYYFL6iK9OcKt9qBtjjq+4uhKxcGjrTzGhwmxdHzkfz+CBMY/ZGcE0v0nLH
 1Z3dW1e8ENswQtmCjjn/U9wCJBk9Fki/fspdqxxBSdeT58hCT6kTV9sC+Uwa8R6xwfwJ74
 +XH04OH3gdQlLjXTIEpfy1BFy4j0TViAi7DQ6QtEb+FzGIZmxxLyflwuLY2BhYnjqJfqpw
 6L6hdXMgsgVLkemsP6h/AZ0W0utk56Rfg9hO5aAzD1RQUA7aReX5jPJyUSMI2gdZzGZYG8
 3p9tu4FuwMmHGaVx3D0I0UKfBU9Auz4NtpjMg9I+Vr6G0/jhajZOCgKYbChZtA==
Date: Fri, 5 Sep 2025 10:19:48 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v3 5/5] Image size checks: Simplify SPL_SIZE_LIMIT logic
Message-ID: <aLqdJLy-FsgZD4H2@aristophanes>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-6-pro@denx.de>
 <21adca4e-834f-479d-a944-e4369c1b8c5e@mailbox.org>
 <aLlMjQb0Qs-VkiaX@aristophanes>
 <1c505e20-74e4-4525-bba9-1f1d74ce6b6f@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c505e20-74e4-4525-bba9-1f1d74ce6b6f@mailbox.org>
X-Last-TLS-Session-Version: TLSv1.3
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

On Thu, Sep 04, 2025 at 05:02:30PM +0200, Marek Vasut wrote:
> On 9/4/25 10:23 AM, Philip Oberfichtner wrote:
> > On Wed, Sep 03, 2025 at 02:59:01PM +0200, Marek Vasut wrote:
> > > On 9/3/25 12:56 PM, Philip Oberfichtner wrote:
> > > > Simplify the depends-on logic for SPL_SIZE_LIMIT. No functional change.
> > > > 
> > > > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > > > ---
> > > >    Kconfig | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Kconfig b/Kconfig
> > > > index aa00669ba20..343299eed50 100644
> > > > --- a/Kconfig
> > > > +++ b/Kconfig
> > > > @@ -588,8 +588,8 @@ config HAS_SPL_SIZE_LIMIT
> > > >    config SPL_SIZE_LIMIT
> > > >    	hex "Maximum size of SPL image in bytes"
> > > >    	depends on HAS_SPL_SIZE_LIMIT
> > > > -	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
> > > >    	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
> > > > +	default 0x11000 if ARCH_MX6
> > > This makes it less obvious what the other case (!256 kiB SRAM SoCs) covers,
> > > why is that an improvement ?
> > 
> > This was originally Heinrich's idea. I personally find it better this
> > way, but I won't argue about it.
> 
> Why do you send a patch which you cannot even argue is correct ?
> 
> > Can you please find a consensus the two of you?
> 
> No, you should be able to clarify why this patch should be applied, do not
> shift this onus to other participants.

I prefer conciseness over verbosity. That's all. But I'm okay to step
back on this one. There may be different view points.
