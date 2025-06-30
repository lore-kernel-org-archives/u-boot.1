Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031A7C8302B
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 16:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5332C80B9B;
	Mon, 30 Jun 2025 18:22:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ncTQiHxF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BBF781D6A; Mon, 30 Jun 2025 18:22:19 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4333A809A5
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 18:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bWBJP2T7vz9tRp;
 Mon, 30 Jun 2025 18:22:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751300533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2Y8ZoTgdB6ne37xslROUOvCPDrB3x1J2WtLcp86jSw=;
 b=ncTQiHxF1yu2JSoNcYBRIUsnCmDYLdBQWRaaj4UF3OAjR0jzYA6cKgGf2vsk9YQaxCIxYP
 jYKMApKZOTGVZin3Zb4mvG//nQ/2u/FIL8SBE5M5mbWsAKJ9W5t+dI+QI1VvKoeQdg/zhj
 AdVBHxFtYu2QUf7KjrBPWVTa7qpvp7V2dNsmMSOnEG2Pl7gFE2uKhq5mjpd2GbyNp4SSGf
 y3tOkN6TzprJElndI7xN8xPHwQtAHHhEQgo3xPGKzkD1dMNV/wniXLn1ni+/LtlIixBpwL
 2+et9/MkhRYgvds2S5Mzz/siQavF9jXYdegACQnjIjgmNTGTro6uvwHFV7E4Nw==
Message-ID: <c039089e-fc89-4cb9-9d98-86d0ecd11e1b@mailbox.org>
Date: Mon, 30 Jun 2025 18:22:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] spl: fit: Add ability to jump to Linux via
 OpTee-OS on ARMv7a
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250630000832.952206-1-marek.vasut@mailbox.org>
 <20250630000832.952206-2-marek.vasut@mailbox.org>
 <198d53d6-bd1f-480f-86a7-5bd2987cd2a7@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <198d53d6-bd1f-480f-86a7-5bd2987cd2a7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e764ecdd62d21e20b9f
X-MBO-RS-META: 3gpru67nteu4tur6gyw3jjjfdiibb6z7
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

On 6/30/25 4:30 PM, Jerome Forissier wrote:

Hi,

> On 6/30/25 02:08, Marek Vasut wrote:
>> Add support for jumping to Linux kernel through OpTee-OS on ARMv7a to SPL.
> 
> Nitpicking: OP-TEE OS
Is this the official spelling ? I was always under the impression it was 
OpTee-OS . but maybe I am wrong .
