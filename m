Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CC9D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 18:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D4B683CF2;
	Mon,  1 Dec 2025 19:30:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1764613832;
	bh=Fy5wDTduDSeCdCL47I5SKvNwBvpev1UzhoR86gjVXrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZqQsjxilgovf7+6HVXp1wcMyFhk3+ds2JipfyG4mlF9Ue1ingboC5C1w9LbGHpgc5
	 IC29Mz+Q5t0Eod/GwaKt1BDfXwJvDdRt9v7OBOrcpebapKqgcNaJcbcTRRSzMC09TL
	 /m9LtSKtMl/81mNKtklPsafVjNzgjJwZocMxeHfvk1EfTTH+eAoFqyNocPpT0+9Ee3
	 z9TmrcNc4XhXtNQK9DJG9yQDbieq4nr8cXCB0sI7P22n6VZ4g4SRXVcUhUO2T/gN/M
	 Rk1wo8Gk7FczqjlPzcjrTcXs4qKUx+jfjRINtcfLHlJoxNew2oYFoD0YCiNDlsyRPw
	 LSBrqhaB27Gyw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF85883D03; Mon,  1 Dec 2025 19:30:30 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE35283CAA
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 19:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="I30g4ak1"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4A30F101CB393; Mon,  1 Dec 2025 19:30:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1764613827; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=Fy5wDTduDSeCdCL47I5SKvNwBvpev1UzhoR86gjVXrk=;
 b=I30g4ak19HuxuHGzV37tJhMHkzdytYWuFyTTyJDjH/1WIsUEDH5bk9dgF6uHXcSIX6BLq8
 mSLmZznw7bgNKU2fQ3w3f7tE8LtAmRi9TrDtCSLzVEO9cMw07Zp2bApqJ6U6di0SXWLv7D
 Fq5MG9/PHbuo137a9x8+vvE2xDXpzzlMtjRfNYvF7l4G2xemUniSYXhfDaplybcsKROgwe
 ExtjUGk4GBVztE5rm4/5zHZC/274Ab9fbzxskioJMRI2cQ9Sibt3HVV6JZVkx0vpbr6Ugs
 RRva9IJtoqL1AfWIS7QXzGvNrEgPnRKZYKD8wBH1QzkSV21IFm9dN+/XGpsIRw==
Date: Mon, 1 Dec 2025 19:30:20 +0100
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v5 0/3] Harmonize image size checks
Message-ID: <aS3evAXY7dTqGfdq@eryximachos>
References: <20251110091256.2422534-1-pro@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110091256.2422534-1-pro@denx.de>
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

On Mon, Nov 10, 2025 at 10:12:53AM +0100, Philip Oberfichtner wrote:
> This patch series aims at harmonizing image size checks, 

Hi Tom,

I don't want to be impatient, just to make sure this one won't slip
through the cracks: What's the current status? Do we still have another
reviewer we're currently waiting for?

Thanks,
Philip
