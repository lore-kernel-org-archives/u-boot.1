Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03473C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 14:50:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19E1280548;
	Wed, 30 Jul 2025 16:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1753887020;
	bh=jc5/7ycIm/mqcS3ClPNMsozFpqWyQgmuJQ5G6ceXHWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jZFU+Viw/sWKDsx4FNt79eX7lZOj7yMbzRzorpfmDJBtXqbjoJL27lT7EaDfHmYiW
	 DlYubDTRioppID+V6iKIajVkUIu0uiBz35bJIXzYNexeQ9Lh2q1g9KzH/mfpfED247
	 alOdxc2Oox2ez91v/V8sNPcrs+z9FHZHb3tH/dGoBpjuHea5lVUdHaohqdTQ31XdqX
	 TzOJj8HDO3nU/05+gH75RjJTPd7XZMPKMVI72QGZzow72vqCzoUkN9DjAQqZx++dF0
	 H3MsPUtLeMfYmBA/xjDo8yGcBXwRQfxmcXuzMb6J8K4Q7tggtBXb+PdIJhBzIR+LPt
	 LwIeeAWV5nMDg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6B40805D7; Wed, 30 Jul 2025 16:50:18 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C2C1803CC
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 16:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="V+UqfQDU"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5E4BA1038C126; 
 Wed, 30 Jul 2025 16:50:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1753887015; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=jc5/7ycIm/mqcS3ClPNMsozFpqWyQgmuJQ5G6ceXHWE=;
 b=V+UqfQDUaQax2SqkGL2LVSDXV4lrMKw2kUbhY0VezRqICMYUls+YEQGQQ4MTDnaBi4oNpK
 hBgP00YLAqwHUXvJG5zkI726trU/5cFWmPDOYTIEt7xwzXMqRU1lTz7SyKEsszKAqb1OSG
 uCk8NMf8B54Ii48KAbFbv5uC2Qxu/xbJOL1VJu7AQEJQQ9N1uPofR8ujY9yamfZmcCN2S7
 M0SesqQwy8AeBIcKZNhRbHogbb3CsWhvy8n0rl82Wqqtx77xeGITOoUu32QN4lWxVnaFop
 9RUF1G/+4ohkGNYmULX7sm9ZyNimMQfAcoYDvULXix+5U+tc9TwqRSoa3Vtk8A==
Date: Wed, 30 Jul 2025 16:50:10 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Paul Kocialkowski <contact@paulk.fr>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Trevor Woerner <twoerner@gmail.com>, Marek Vasut <marex@denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] Kconfig: typo restict
Message-ID: <aIoxIl6rdyN3NbNc@antares>
References: <20250730125427.587976-1-heinrich.schuchardt@canonical.com>
 <3f34945e-9e4f-451e-85eb-5a5e4e5cd265@cherry.de>
 <0b5e6888-6652-4ec7-971e-710dc9cd3a77@canonical.com>
 <20250730143250.GP1807455@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730143250.GP1807455@bill-the-cat>
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

> > With VPL_SIZE_LIMIT and a patch for UBOOT_WITH_SPL_SIZE_LIMIT pending things
> > get even more involved.
> > 
> > We should think about a documentation page on size limits:
> > 
> > CONFIG_HAS_BOARD_SIZE_LIMIT
> > CONFIG_BOARD_SIZE_LIMIT
> > CONFIG_SPL_SIZE_LIMIT
> > CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD
> > CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC
> > CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK
> > CONFIG_TPL_SIZE_LIMIT
> > CONFIG_VPL_SIZE_LIMIT
> 
> As Philip has hit adding a new MIPS board and need for specific size
> check, yes, better documentation (and then perhaps adjusting and
> cleanup) of our various size checks is much needed and would be
> appreciated.

Hi,

Just adding the reference to my current proposal on how to simplify the
Makefile:

https://lore.kernel.org/u-boot/20250730123833.249923-2-pro@denx.de/T/#u

Best regards,
Philip


> 
> -- 
> Tom



-- 
=====================================================================
DENX Software Engineering GmbH,
Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
=====================================================================
