Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F844CA0EDC
	for <u-boot@archiver.kernel.org>; Sun, 17 Aug 2025 23:00:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A06AC8319C;
	Mon, 18 Aug 2025 01:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="R9MeqeTB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VLUGCkd3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76FE2831B4; Mon, 18 Aug 2025 01:00:25 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4C7283164
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 01:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4c4rsd3623z9tQQ;
 Mon, 18 Aug 2025 01:00:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755471621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bw2c4SSecIJyayxz4gOhbs6JHI7znoDWVb4q9H0VoKg=;
 b=R9MeqeTBpafpOrT0uZ0YthQdWDo0as+RslCr9Q8C9fnXarDUM7QS5vkaapn4AIzEGfvnHJ
 TO6dZ2MJx6ASMm7ucHs8rxV8fCAmdYj+M4AhbjHPVSO7nzj+fGV8LjNI4PNSsZ1RdXgOco
 TiQaY484ENYNEL3FSrtz5Ii+BV5bnubsV4K10yN14e6qMJsAWl7t1N5WqnordXDeaeyAKl
 zEXUk+A1govm/gn/8ZzvT4YaHmfSJz/5vCiGjay40x93Qx1Vitvaey/XpCoMLOZuN44MfR
 18qyy9/ACAuXizvV0HcNLSRSTxcrFPSmRHbyAGngUj2AacvhV6zevWjmeJAMDA==
Message-ID: <5cb388f9-d488-4091-9556-c0063f637aed@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755471619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bw2c4SSecIJyayxz4gOhbs6JHI7znoDWVb4q9H0VoKg=;
 b=VLUGCkd3IGfshnNj/UP1QhVWgjJtgbSFM8Cj229F0ch8l/4Ng7cUgK+HkJWlaAJv/GUMUI
 /vKtqnvXkEcU7Ixrtsm+0dIoCvsqGJJgvYQL83sn6P1JVvI8SsvdWrjY6pL8/om6kzw5EI
 rz42fJcHXxtVV22yUe7M4MlWUwTcBWi0yz8SgSpRHxSEjj3zTbw1tHJkDuXfSD3nolnflq
 b1PQ5bQwdTg9JWXlTs3BMTxD8BCKqsl6oFsaW2LFhQSQdBNSVSuPCcO58MXXVb0rcq0iXe
 bGC40rPWuomuS7CVe/HKs8fgynlEn0Yw1tWaNZqOgdzOH1l/c3VDggktxOcUAw==
Date: Mon, 18 Aug 2025 01:00:16 +0200
MIME-Version: 1.0
Subject: Re: [U-Boot, v6, 1/1] misc: fs_loader: Add
 request_firmware_into_buf_via_script() for flexible firmware loading via
 U-Boot script
To: "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de,
 marek.vasut+renesas@mailbox.org, tien.fong.chee@altera.com,
 trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, seanga2@gmail.com,
 daniel@makrotopia.org
Cc: lucien.jheng@airoha.com, frank-w@public-files.de
References: <20250817150203.52850-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250817150203.52850-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6d72b0128a225c147c5
X-MBO-RS-META: zwnxcpzct6tc5b6ezbtnjyh8fkk5s5qj
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

On 8/17/25 5:02 PM, Lucien.Jheng wrote:
> This commit introduces a new API,
> request_firmware_into_buf_via_script(), to the fs_loader framework.
> This function allows firmware to be loaded into memory using
> a user-defined U-Boot script, providing greater flexibility for
> firmware loading scenarios that cannot be handled by static file
> paths or device/partition selection alone.
> 
> Key features:
> - The API runs a specified U-Boot script (by name), which is responsible
>    for loading the firmware into memory by any means (e.g., load from MMC, USB, network, etc.).
> - The script must set two environment variables: 'fw_addr'
>    (the memory address where the firmware is loaded) and
>    'fw_size' (the size of the firmware in bytes).
> - The function validates these variables, copies the firmware into a newly
>    allocated buffer (using memdup), and returns the pointer
>    via the provided double pointer argument.
> - The maximum allowed firmware size is checked to prevent buffer overflows.
> - The environment variables are cleared after use to avoid stale data.
> - Detailed error messages are provided for all failure conditions to aid debugging.
> 
> Usage example:
> 1. Define a U-Boot script in the environment that loads the firmware
>     and sets the required variables:
>     => env set my_fw_script 'load mmc 0:1 ${loadaddr} firmware.bin &&
>     env set fw_addr ${loadaddr} && env set fw_size ${filesize}'
> 
> 2. In your code, call the new API:
>     void *fw_buf = NULL;
>     int ret = request_firmware_into_buf_via_script(&fw_buf, 0x46000000, "my_fw_script");
>     if (ret < 0)
> 		return ret;
> 
> This approach allows board integrators and users to customize the firmware
> loading process without modifying the source code,
> simply by changing the script in the U-Boot environment.
> 
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you for all this hard work.
