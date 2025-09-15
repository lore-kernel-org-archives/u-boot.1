Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F83CAC587
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 00:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F76E8309E;
	Mon, 15 Sep 2025 02:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HsjScWq8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9620E83106; Mon, 15 Sep 2025 02:07:37 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B38B83071
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 02:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cQ52F1SVcz9sq0;
 Mon, 15 Sep 2025 02:07:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757894853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XtmDfC/6/MJ22QaAsiDGpERgOy8599/6kH1Bb//AYWU=;
 b=HsjScWq8lD9v3spF4xAQ0tV5yIJbWo2PPFngtUQHmOTrxTThFJzGxm0NmoseZ90i7nxnBC
 ENhGBK1UnxEdwtgGmkn7AQbK29SH9GLARUFWOJNxAUlVTvYt+yU/TtTryUUBADucfG444L
 5BU8f9DMKteUpSbBMM/7mQOHZDazowiuAE1TomXaEiKrXZrnxj7bs+o0iCY18a7+MhUFuW
 L/7nT/ncyaV6zl2K/Gu716xzBnX3CJpJrAG5/5vRVBiEBDhTBtivc6I+OvChVnBhDpgLiD
 bTEfDRenR8VZZe1wpcJ2HEqV7ys67pSVWmyfd6LP05f9ROge6zSYLgkagg/6gw==
Message-ID: <7858181b-5558-4249-b9fb-0d17ea5b348a@mailbox.org>
Date: Mon, 15 Sep 2025 02:07:28 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] stm32mp2: Add SPI flashes support
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
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
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
References: <20250808151154.472860-1-patrice.chotard@foss.st.com>
 <827b1b5e-ac74-4710-8424-5bf0390441f6@mailbox.org>
 <9c805dc1-fc95-4d01-99cf-306264fd4b2b@foss.st.com>
 <905b7b4b-a216-4bdc-868b-5b38efb61317@mailbox.org>
 <d7d281a2-69c4-4bc3-8392-dd772f889a18@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <d7d281a2-69c4-4bc3-8392-dd772f889a18@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: on676m8xno4kusj86m4dcs58zstdmgfq
X-MBO-RS-ID: f7a98bb78f8a4cdee0c
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

On 8/20/25 3:11 PM, Patrice CHOTARD wrote:

Hi,

sorry for the late reply.

> If you refer to my previous e-mail with the stm32mp257f-ev1 boot log,
> with the following upstream components:
> 
> TF-A: v2.13.0-304-g000fe221b8

It seems this is missing PSCI implementation entirely, right ?

> OP-TEE: 4.7.0-26-g847ee2932

This does not implement SCMI, does it ? Does it need SCPFW or something 
as an external dependency ?

> U-Boot: v2025.07
> 
> I am able to boot a STM32MP257f-EV1 board.
Were you also able to boot further into Linux with this setup ?
