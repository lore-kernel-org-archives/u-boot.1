Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79864F8D74F
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 14:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4EB4841C2;
	Thu, 16 Apr 2026 16:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="TfscIOV5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D629841D5; Thu, 16 Apr 2026 16:12:28 +0200 (CEST)
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14213840AB
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 16:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Date: Thu, 16 Apr 2026 14:07:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776348744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xhlz/RfXe7mesvWuW31IHFLDPa0Xv2PkIAvh7INWNE8=;
 b=TfscIOV5AD+O1rjwSHlU51KrFMIA8EZ4W1s//fUwXMJxc6wKMcemOqzl0B4GoDMp6ZD2Xi
 n1+Ad10exeU19njNHDPOytTR4vjX7dgs/JUm9ByMuIOm2knmzL90qgs6EGOu4PrLZSNCFQ
 e6p6Qxb0PQMd8taVfsoOd8RLj6NL7mwra8ymbHQvPmQdRsnLu2q21OWK9L/+9llTB9sP0A
 X0jURl8t36pdiWtoTsOKknu1mxgKQ+bX0wuQZ4oI74c61ECZtmMiHX9GXRlml1evig6ZU3
 tEGW94omtAnudewAfyn7ktg1ylrKbfS+MgJAALrVKkFNBhuxlctCzFINoVLmSQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Martin Schwan <m.schwan@phytec.de>, David Zang <davidzangcs@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v3 3/3] doc: usage: convert autoboot README to rST
References: <20260415-ui-cosmetics-v3-0-aa8308a47e33@postmarketos.org>
 <20260415-ui-cosmetics-v3-3-aa8308a47e33@postmarketos.org>
 <61DCA2CF-A66E-47C5-8921-9747FAC8C75B@gmx.de>
 <tdjxih.1juw2c1se87sl@postmarketos.org>
 <2D15A5D4-D938-4DDD-801A-84F7B0230E55@gmx.de>
In-Reply-To: <2D15A5D4-D938-4DDD-801A-84F7B0230E55@gmx.de>
Message-ID: <tdlbgf.3no8h56kslrf@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
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

Hi Heinrich,

On Wed, 15 Apr 2026 23:17, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
><...>
>>Do you think it makes sense to rework autoboot documentation with these
>>changes or would it be out of scope for this patch series? The only
>>changes I did was to convert to rST and move AUTOBOOT_PROMPT docs
>>outside of KEYED (as per patch 1/3).
>
>I would suggest to have one patch for the conversion and another patch to correct the content.
>

OK, makes sense to me. The stdin flush patch (which I suppose is 
https://lore.kernel.org/u-boot/20260413152526.153605-2-gregor.herburger@linutronix.de/)
seems to not be merged yet so I won't adjust the docs for that now, if
that's fine for you.

Thank you for your feedback!

--
Best regards,
Ferass
