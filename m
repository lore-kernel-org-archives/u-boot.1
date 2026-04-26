Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DF4FF885D
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 16:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A860683FF5;
	Sun, 26 Apr 2026 18:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NPGx5LAH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="X062I0kP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE22C83FF5; Sun, 26 Apr 2026 18:30:25 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB07B839D9
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 18:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g3XHL2mBMz9tFL;
 Sun, 26 Apr 2026 18:30:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777221022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n1lKdsfJaSAyfYTqC1Vs5+wLEsY/OyIHiBcmKFqMksQ=;
 b=NPGx5LAHlNMuLeyE71rrl3KfX/ToGSkTk3tRMlmpfKdy3ypUqTEnIxeL7jn7qR4fBZz7q9
 U2T3tRUCmmwIzy80GE0zF0bhF4r8ACy0FQ7rDKYMkQ6HRZWfHad9zIgghReGcsIRXD2SlI
 HTP2Wju9vOtQ5cQajME5tr3cPoVkJrO551+L0ya0tMz6s4yAb/RsAYZ6K3atH0pJwcLTsy
 zjlMxIiASDTR0tZ5W5sQ9AbXV+FMj7mJ4YE9qkbzDhHSoIA14fV8FFT+gwxZSpkQ/xhx69
 JMxfcv0HDd2PrBl8qyAgbvdcyyLlGHoXO2kypKRnT8b5IiNIpKrrLSjJooxykw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=X062I0kP;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <041715e7-c75c-487b-8d99-6a00e48b6a35@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777221020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n1lKdsfJaSAyfYTqC1Vs5+wLEsY/OyIHiBcmKFqMksQ=;
 b=X062I0kPtPGasRB8K+oXaRCwoJ1bCXjOfdKqfIEOgjkkd5dM3gqkdBJXes5zAvGDvJYkh7
 lS/a1fUOKUFjaxSLCHuS3KY1A47j0b8vz5U+mPcm6rwrlrucfbzU1oSXhvpv5ZsSY9LYzQ
 q6FpNZlon6X1M+fRAlBYfV4/cnOfX4S7MZ5BzNIwSdhEyn0zL72R9bMGEGYSTUhIOcvhZl
 Zui3mZhvUQ/xEi60Qz2NYqmFMJC7+MyXUOpc+kyEzAV+53ygClkweE16N+c4eBjG6P+f0B
 KxzXbtnl1V6WbtMjmfBSB7MBB7tsHXvxmDAcDEK0ieJzy8R6Z//vfGEju/OCaw==
Date: Sun, 26 Apr 2026 18:25:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/6] common: Clean up setup_dest_addr()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, u-boot@lists.denx.de
References: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
 <20260416055948.130041-6-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260416055948.130041-6-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c33c58327b4ed86510b
X-MBO-RS-META: 16ecg9kx3ansqair465gb5wan3yfwei3
X-Rspamd-Queue-Id: 4g3XHL2mBMz9tFL
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

On 4/16/26 7:59 AM, Ilias Apalodimas wrote:
> Right now the function does
> - Re-adjust the ram_size based on Kconfig options
> - Set ram_top
> - Set the relocation address
> 
> It also does not set the ram_size in case ram_top grew
> from it's initial value. But ram_top and ram_size should
> always be changed together.
> 
> So let's make things a bit cleaner and move the ram calculations
> in their own INITCALL
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
