Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FE5C87FCC
	for <u-boot@archiver.kernel.org>; Sun, 27 Jul 2025 14:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF07883013;
	Sun, 27 Jul 2025 16:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fLNNf74t";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GLwIqomU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 719FF83015; Sun, 27 Jul 2025 16:46:57 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1408E82F8F
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 16:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bqkvy6Mbbz9tJx;
 Sun, 27 Jul 2025 16:46:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753627614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xrJf1T7U3SZib7iJN6Ga1XI0WqtvyKaGcIUdN3xTTs8=;
 b=fLNNf74t9wrhE0ccFg1ZovTO0/Igwj5IiPE79FH2MsG9yJwFeeWarfMVfBF5ENQNRg9JdP
 0OfpfdP7RuP6swu92IFpCIP7bVzshxIt4v4K9dDbc7K+8Q2HAmEDDjVx72v3KWKgD0uQ9B
 d3fg0I2ZKgGGaMyvyJnQwELivr1lf2+VlsWe/n8jF4JspR+LM30IUIZxL4u+YrhqwXezFI
 2W4MxcepuM+I8p9ZnBCzhjQLjPxsIdrRqSRsqLn6Vy+ekUctU7juO+7doypfEnDU8MSUmR
 Rj8CdUlNjjtaQLPPlFcRTdWJLsjWHnFmb9pDh5qjPpfzdOvgcJ3P9OUwYW6+Vw==
Message-ID: <2f6dcd69-1e18-4a9a-a07e-9b59f79212da@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753627612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xrJf1T7U3SZib7iJN6Ga1XI0WqtvyKaGcIUdN3xTTs8=;
 b=GLwIqomU9xNr57n2eOScUf8/zkLMYqdhWaYgkmu6QCImidUAxd0IU2K7cW+1aydC7u5gXD
 ypfJU5TZc5TNrwjl+hue5ZMW9nShc6vYzsmNn2kUf/HzM6mfkO1aRPNU+5yqVRlWxK+qQT
 xFiEF9lWmTWEEBlM/8Q5zArhcKqxOrHf37Pb2Gr0kHDklxJX4th1nQNIc2yu9iYupkTaGu
 vWpysmOpI7zEOa4kuskoNMp58zwXGhFEGmRyoDiNMx+an+OR9gUFGSz1Grk9VmjJMcqTR5
 vqT41IB3Y9XnOKwOdWo8d09XVeM1HJwS1wrvVZu8TQY1i0WRiJ46AeH8UxTdig==
Date: Sun, 27 Jul 2025 16:46:49 +0200
MIME-Version: 1.0
Subject: Re: [U-Boot, v2, 1/1] misc: fs_loader: Add
 request_firmware_into_buf_via_script() for flexible firmware loading via
 U-Boot script
To: "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de,
 marek.vasut+renesas@mailbox.org, tien.fong.chee@altera.com,
 trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, seanga2@gmail.com
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org
References: <20250727141609.15425-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250727141609.15425-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: q48wwgnene46okyy7uzfd7ccymgrjnym
X-MBO-RS-ID: c376857de0649359616
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

On 7/27/25 4:16 PM, Lucien.Jheng wrote:
> This commit introduces a new API, request_firmware_into_buf_via_script(),
> to the fs_loader framework.
> This function allows firmware to be loaded into memory
> using a user-defined U-Boot script,
> providing greater flexibility for firmware loading scenarios that cannot be handled
> by static file paths or device/partition selection alone.

Please run some 'fmt -w 72' on the paragraph above.

[...]

> I've validated this API on the Banana Pi R3 Mini. Here are my test commands and logs:
> 1.  `env set en8811h_load_firmware 'env set fw_addr 0x46000000 && env set fw_size 0x24000 && load mmc 0:3 0x46000000 /boot/EthMD32.dm.bin && load mmc 0:3 0x46004000 /boot/EthMD32.DSP.bin

The 'load' command sets $filesize variable AFTER the load completed. The 
$filesize variable contains the actual size of the loaded data. You will 
likely need to expand the script a bit:

env set fw_addr 0x46000000 && env set fw_size 0x24000 && \
mw.b ${fw_addr} 0 ${fw_size} && # Make sure the memory backing the
                                 # firmware is initialized to some valid
                                 # content.
load mmc 0:3 0x46000000 /boot/EthMD32.dm.bin && \
if test ${filesize} -lt 0x4000 ; then # Validate that the size of loaded
                                       # data is correct
   load mmc 0:3 0x46004000 /boot/EthMD32.DSP.bin
   # Validate loaded data size here again
else
   env set fw_size 0                   # Indicate failure
   exit 1
fi

[...]

Looks pretty good otherwise I think , thanks !
