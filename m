Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B57ACA1015
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 08:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 078E583734;
	Fri,  5 Sep 2025 10:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1757060554;
	bh=KKE7rq2VLJQhVpM5gBVha2OhRU8wIdRmYa70pVYmV1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P4IZh+vbcIhfLErxqJPHHidJpFROooXOTVG/9gQB0/3V5spzYnrkW9CORXeJiXeI7
	 OAp1U9vV325YxZb0pNk7KIIUhjENH+kKtZpbNIrcNd8WrjVAqA0hEoCjjJMTcWRLtp
	 5VHbtWx29z3JM3vNC0a/isQVdI6OYIAS+pysZflyPckdCe5wMqJGIGdOvuJqUJFtaK
	 bC1AOS5lnZfqjCUbmxx1q5NfaxTrqBFH17/ZlfPRWf2udn5bQuYNhy7mUB100zLJim
	 AD4Vk8WPHaCLTB8kHwvldVr0JirVmxPaFTk/lnCi+0eaX8s49MCWOtmziucbuwExM3
	 350Wfx4U56y0A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C06C5838E5; Fri,  5 Sep 2025 10:22:32 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F15583390
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 10:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="GjF9daM+"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 55C901026E167; 
 Fri,  5 Sep 2025 10:22:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1757060549; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=KKE7rq2VLJQhVpM5gBVha2OhRU8wIdRmYa70pVYmV1g=;
 b=GjF9daM+yGH7unKv72vAygz2FIS+qsHcPFDh1REONnueSMN0Ky4QoR7dp5dlh/HaFaGFDh
 TK5ByBd8VOpm0Zd9hpSIgnZKlzZI+8Pa0xWhq865ERv2rTGp715YGQlwo4vxXwosNJKIJD
 m8dRY1DNNGys2Q4qrtCRqZe85lDAFiFLJw2p08Lb7bdNnwLsYMPwhy7t1zia+xERNt8/nJ
 IL3dwNIMkUAFjFt3cw8WSPtfSQjnCg+stZSAYb99TBi7kIdGyMV7gCBRAX3cbnYARr85Ec
 cMMSDy1niXtHoKLt/KspPoDuI/tbXqdSCQlpKrLazDidDjCPK73sqGJw8TiryQ==
Date: Fri, 5 Sep 2025 10:22:25 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v3 4/5] Image size checks: Deduplicate Makefile
Message-ID: <aLqdwQjt8wKUnWa3@aristophanes>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-5-pro@denx.de>
 <937b1be4-68cc-4853-94e5-2f14cbcef194@mailbox.org>
 <aLlOG9of7r4sdLok@aristophanes>
 <99ad1032-3048-4e4b-bd4a-91dc2a20c2d5@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99ad1032-3048-4e4b-bd4a-91dc2a20c2d5@mailbox.org>
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

On Thu, Sep 04, 2025 at 05:03:24PM +0200, Marek Vasut wrote:
> On 9/4/25 10:30 AM, Philip Oberfichtner wrote:
> > On Wed, Sep 03, 2025 at 03:02:20PM +0200, Marek Vasut wrote:
> > > On 9/3/25 12:56 PM, Philip Oberfichtner wrote:
> > > > Deduplicate some redundancies within the SIZE_CHECK code in the toplevel
> > > > Makefile. No functional changes.
> > > > 
> > > > Note: To make this work for the special case of SPL, spl_size_limit.c
> > > > has to print an empty string "" instead of zero when there is no size
> > > > limit in place.
> > > > 
> > > > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > > > ---
> > > >    Makefile               | 45 +++++++++++-------------------------------
> > > >    tools/spl_size_limit.c |  4 ++--
> > > >    2 files changed, 13 insertions(+), 36 deletions(-)
> > > > 
> > > > diff --git a/Makefile b/Makefile
> > > > index a17d8b57196..b6f01591ee9 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -428,8 +428,9 @@ KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
> > > >    # Check ths size of a binary:
> > > >    # Args:
> > > >    #   $1: File to check
> > > > -#   #2: Size limit in bytes (decimal or 0xhex)
> > > > +#   #2: Size limit in bytes (decimal or 0xhex), always return OK if undefined
> > > 
> > > You should be able to use the HAS_ variables to correctly test for and
> > > handle the undefined case .
> > 
> > In general, I agree. But this would mean to reintroduce the multiply
> > duplicated Makefile bloat à la:
> > 
> > 	ifeq ($(CONFIG_HAS_BOARD_SIZE_LIMIT),y)
> > 	BOARD_SIZE_CHECK= @ $(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
> > 	else
> > 	BOARD_SIZE_CHECK =
> > 	endif
> > 
> > 
> > That's why after all I preferred my "test -z" solution. Is there maybe
> > a third way I am missing out on?
> > 
> > What do you think about giving size_check another argument, i.e.
> > call size_check,$@,$(CONFIG_HAS_BOARD_SIZE_LIMIT),$(CONFIG_BOARD_SIZE_LIMIT)
> This could be an option , yes .

Okay, I'll try it this way in v4.

Unfortunately I'm on leave the upcoming three weeks. I won't be able to
pick up this patch again before the end of this month.

Best regards,
Philip
