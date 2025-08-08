Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B873BC87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 15:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FD118476A;
	Fri,  8 Aug 2025 17:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="v/RHvlFg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oU+j0hc0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB86F84772; Fri,  8 Aug 2025 17:25:01 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 301C3846E5
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 17:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bz7BJ00MSz9sjF;
 Fri,  8 Aug 2025 17:24:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754666696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gmk42PmiqaYuU28xvXAoRfgbqLcn/eaXEmic69dLSeg=;
 b=v/RHvlFg/M90cfcWm6uiMIqQNm0Aa5BuSl0h9stny/nEiRRtxk1c1TCdxCaAS/9i5T0i+C
 0SEFhJcqh4pr00cbQ567mX2CsDJLaGPmo2QZN5Yo/T0GuzYZKo6AZPdBkiFZwNnaVo+6HY
 pprzXuPOQ+TMS0CM+nlVvAtlWo471zG+pU+gF7khUKYmkj5X0EMSGO8m0c8Nx7i3srXK0y
 I0Hmr0Hb1akcbGm73ZoAaouEVe1/kGP9tM7QA4aIVOPzi09ihFx3Dcd5TWUYRIYSetB4IG
 U15eNaYh+E7YlNL/41quYVdAvURY3Bna5IrDgImUvbs9zgZ+aU+I30j11JNYwg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=oU+j0hc0;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <827b1b5e-ac74-4710-8424-5bf0390441f6@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754666694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gmk42PmiqaYuU28xvXAoRfgbqLcn/eaXEmic69dLSeg=;
 b=oU+j0hc0XHjrnzXWZI6eRZwIi80JE+stXu1Hrcn9Ts+iWI9vCq2MCEs8ZRWWjcJ/z8wY0u
 6keb9ibiNcxAeiGLA1TSVAdnriXbTYfE6zYbCFjqeSgLTyAAUmvQpqK/un5ImY0x6IYz4K
 4QSxLw3qv8iSKYDGxHv/DNgql/LiXfq4DbCORdRniok8JzQicg+1fzxb7yo0JyOxeVad/Y
 V0mq/IL/EtKPGcYETXQJqRqE/mv3wfZllU6idEHiIy9efNE1TfKDOZ7wUUHDUB9KBPW1zb
 WPZsmbCRWljn4z06am3zeGFdRa5OpLWeylPCdg3EV4CGldYTkQYzN53sKafRJA==
Date: Fri, 8 Aug 2025 17:24:47 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] stm32mp2: Add SPI flashes support
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Alexander Dahl <ada@thorsis.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Cheick Traore <cheick.traore@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 John Watts <contact@jookia.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
References: <20250808151154.472860-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250808151154.472860-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: x5ri4dxxcbzxg67kywxh7c4dm3eq59tx
X-MBO-RS-ID: 073dbef761e08948977
X-Rspamd-Queue-Id: 4bz7BJ00MSz9sjF
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

On 8/8/25 5:11 PM, Patrice Chotard wrote:
> This series introduces 2 new drivers:
>    _ STM32 Octo Memory Manager driver
>    _ STM32 OSPI driver
> 
> It adds resource check helpers which are used by OMM driver.
> It adds and enables OMM and OSPI driver support for stm32mp257f-ev1 board
Can I test this with mainline TFA and mainline OpTee-OS ?
