Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4CBCA1007
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 01:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7829683AEE;
	Wed,  3 Sep 2025 03:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Fqhyhuth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D69BF83390; Wed,  3 Sep 2025 03:51:02 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC58283AA8
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 03:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cGlv55l6hz9tLk;
 Wed,  3 Sep 2025 03:50:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756864257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/iHG44iqSQDEWnq3+3w4HnQj1i1ZVPl/UM1WaHpXQlM=;
 b=FqhyhuthX7CzOMxYR1z/zLix9KRfMCcSBCbDUnVCLa26ogc2jpd21UR7cFQ2bKb1P9+sso
 RrJPSKzRp9vsRz5WFLOCetIEBXHCaAR3zXhhYrqUXihhimZcZTNbzr4WmSP+objvqj47dZ
 Yx5yphIv2ToUiuQqBz2ZQMcjchMeZbLaliLqe0r4c86Y8ztlCaW+znnPm7AtUrmIn3TrPH
 RsaL/1bmlm+x7k37QWmErPH00GlfcIQVJv1jx2cp40KsuCzHFLF6bPSyOBre7x6vR7Ceap
 Ggu++dme8oaEMN0RTkgao6QimLWl0u9zFCA3gp6F/LoEpvbltDg0omoAF3VRYg==
Message-ID: <63f1e637-bf6f-4298-9cba-ac55dbc90e07@mailbox.org>
Date: Wed, 3 Sep 2025 03:48:39 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 6/7] usb: host: Tighten USB musb-new host glue driver
 dependencies
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250806145601.1664563-1-trini@konsulko.com>
 <20250806145601.1664563-6-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250806145601.1664563-6-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: b31zgfyrtpqu5kmy1gu6j4ew7ajnsrkb
X-MBO-RS-ID: 14748090c781f0c3230
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

On 8/6/25 4:56 PM, Tom Rini wrote:
> A few of the USB musb-new host glue drivers cannot build without access
> to some platform specific header files. Express those requirements in
> Kconfig as well.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
