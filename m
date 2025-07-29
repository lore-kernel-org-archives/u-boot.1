Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC97C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 18:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ADF682B20;
	Tue, 29 Jul 2025 20:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gpJ9x4pb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="r5Vb693I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26CDE82BA1; Tue, 29 Jul 2025 20:07:44 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEB3E82B07
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 20:07:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bs3Gh5JY7z9shm;
 Tue, 29 Jul 2025 20:07:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753812460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t8Ckp0aXvNQuMk9NfR3vQR3mMjwZaKGYoJEJq9b2W/8=;
 b=gpJ9x4pbDIppwl8bAdjZ5s9QPmEaGy6l3lBiCLjmbPAhbQur1n/2qKJqXhPQhUm1GRa4/7
 drjzVsBIvNLTRBuGQWg/aiKsIKJTw0g+GcvoivXxOc8vRqfQo1tbBm7kxxORIhb+dW1fDU
 Yi5fDAjQmM/Oi7kj4kNc5wz6Vpyenf5O7/eh74rYWDzhFhqYVO22f9wsc6zYny0GJPGp33
 n26O4KsJbgkTslIIaG69LlB79GC8c7w6FFx08z2tYHOigPXubAKxP3zEAlQEWyXhPS1itH
 gSHl17xhhiEbn6hDySLCRDceiudFZtAETJZ9R9ww4fxr8jg+o/BVXCdqF1s8JQ==
Message-ID: <ed7d3970-b550-431a-9f41-3fccdf5bed73@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753812458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t8Ckp0aXvNQuMk9NfR3vQR3mMjwZaKGYoJEJq9b2W/8=;
 b=r5Vb693IIaCqYEdu/Y4uq4Xgz6t5rR/Q8qpQEMOe+1CFow5kkLhWsuA3enFlN5gLUF+q/Z
 ozp0TCsXPXRxNeV8m0Iytnx6GMKG2a5EZDi8+z2hNczSYQmEQGkIcVokkXhD+GWADilnyI
 jot3f78B/+uHjBsVKuTWMBdk9zLWjgRU2HoEPH8GtzguVxvTOvQOWZorurZNX5KEa1gGRP
 OZrDYw6sTstgppANH88IRdPFDR85Jl0qTEAY0GWsKCjZKX2aTUiKPVpE2Tk/xnw7Bkn+sr
 psPKeew30PWy/GzO1VEVRQ/CpW5TD1F5po75cB/NpBrEksU9nEQXVPX5VL7O6Q==
Date: Tue, 29 Jul 2025 20:07:35 +0200
MIME-Version: 1.0
Subject: Re: [U-Boot, v3, 1/1] misc: fs_loader: Add
 request_firmware_into_buf_via_script() for flexible firmware loading via
 U-Boot script
To: "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de,
 marek.vasut+renesas@mailbox.org, tien.fong.chee@altera.com,
 trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, seanga2@gmail.com
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org,
 albert-al.lee@airoha.com
References: <20250729145146.2935-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250729145146.2935-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 8ff6e5082fdea50e4b6
X-MBO-RS-META: s3fdh94yd9qdwz6ntzzop88u1wx17eqd
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

On 7/29/25 4:51 PM, Lucien.Jheng wrote:

[...]

> +int request_firmware_into_buf_via_script(void **buf, size_t max_size,
> +                                      const char *script_name)
> +{

[...]

> +	*buf = (void *)memdup((void *)addr, size);
> +	if (!*buf) {
> +		log_err("Failed to allocate memory for firmware copy.\n");
> +		return -ENOMEM;
> +	}
One more nitpick, do we want to memdup() the firmware here, or would it 
be better if user passed an already pre-allocated buffer pointer into 
this function and this function would only copy up to 'max_size' bytes 
into that buffer ?

This:

int request_firmware_into_buf_via_script(void *buf, size_t max_size,
                                          const char *script_name)
...
memcpy(buf, addr, min(size, max_size));
...

What do you think ?

Also, I would really like if someone else voiced their opinion this 
firmware loading mechanism.
