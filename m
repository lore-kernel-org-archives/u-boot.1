Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B2CC83F22
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 20:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58DD681D6A;
	Sun, 20 Jul 2025 22:48:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ItZ4dfGT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LNRyaMVY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97EED8303B; Sun, 20 Jul 2025 22:48:00 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73115805D7
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 22:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4blbFp0fVsz9t1B;
 Sun, 20 Jul 2025 22:47:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753044478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Fa5ai4jc+40/NpPqHvnkTnpcGE/uG8bPPwyw8AGCq0=;
 b=ItZ4dfGTKvyMb2NWyDI03a26bXPBfCkspEX+ceM/AFEU7ZrCQyYvV25Vw1SFTH9m3ZaJ6L
 p5Y/WAt1+Hh2DGzDbn9BwOae6PLDniS54Rm/oge8naZE1OVwoD8SmYYR9ZYPs2Oe/SRflB
 nrRKDMbTGQ5tt7QGNPJvQy9gEa4Kh9C6b3ntnr/cvXdHgLvBscR793NN34LFIyYQND0AGu
 o9r62zcAPTK7kBMuLVN0pwBj0xWW66y7mHbb5D6idq8binUOhknRLdLEcaQyFUpsNpzH/o
 pWcOOVfmPjwubcsqA2Opov+F7OMahZamr5YV4/m71gpzx/EsZrgEHsCO0cNupQ==
Message-ID: <f97fbf07-39c1-406a-9349-0ec84bf0300b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753044476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Fa5ai4jc+40/NpPqHvnkTnpcGE/uG8bPPwyw8AGCq0=;
 b=LNRyaMVYwfuPRvyintEzHTI8pfaS4qrMqXoFAn9pa+JbtCSlgSLU1LSjBGfiIcCqqTH6nj
 s9dhgf+OqbdELJQ6gCMScDRfY3J3xy4ImyYUggWHjtrOVcTGbq/f6y27XkGpy2TW9xfQ8F
 7UKll/uctIayLBKdjigQy7nOh3XaDMac+G5Nimsm4XJ84E1Ukq2yiOZGCtTqGz68ZON9WR
 Ign1BdM3nxrh9/uvFiVLBu6mqtlQBI+c/e6KQaKIItv86MuJC6Cbw3PXSpmNA7qZk8Kust
 j7XrLCcWFABZTL9xhZqMSYvng74H3HO9PYL66m3eIaPnrNs6oBMt9O/f+TqG8Q==
Date: Sun, 20 Jul 2025 22:47:50 +0200
MIME-Version: 1.0
Subject: Re: [U-Boot, v1, 1/1] misc: fs_loader: Add
 request_firmware_into_buf_via_env API for environment-based firmware loading
To: "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de,
 marek.vasut+renesas@mailbox.org, tien.fong.chee@altera.com,
 trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, seanga2@gmail.com
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org,
 albert-al.lee@airoha.com
References: <20250720150404.25844-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250720150404.25844-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0bc228145ff0468b084
X-MBO-RS-META: s5qcg7qwnrnzmu9whhcszdkrspkmyb6o
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

On 7/20/25 5:04 PM, Lucien.Jheng wrote:
> This commit adds request_firmware_into_buf_via_env() to the fs_loader driver,
> enabling firmware loading into a buffer
> using environment variables for path and size.
> It supports multiple entries via indexed variable names
> (e.g., "fw_dir0", "fw_size0").
> This provides flexible, scriptable firmware loading without hardcoded details.
> 
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
> ---
> Change log:
> - Re-sending as previous version and add more maintainers to review.
> 
>   drivers/misc/fs_loader.c | 59 ++++++++++++++++++++++++++++++++++++++++
>   include/fs_loader.h      | 18 ++++++++++++
>   2 files changed, 77 insertions(+)
> 
> diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
> index 66803f4b997..a4f4448f5cc 100644
> --- a/drivers/misc/fs_loader.c
> +++ b/drivers/misc/fs_loader.c
> @@ -228,6 +228,65 @@ int request_firmware_into_buf(struct udevice *dev,
>   	return ret;
>   }
> 
> +/**
> + * request_firmware_into_buf_via_env - Load firmware using environment variables.
> + * @dev: An instance of a driver.
> + * @buf: Address of buffer to load firmware into.
> + * @offset: Offset of a file for start reading into buffer.
> + * @fw_index: Index of the firmware entry to load.
> + *
> + * This function loads firmware into the provided buffer using environment
> + * variables to determine the firmware file path, address, and size. It supports
> + * multiple firmware entries by using indexed environment variable names such as
> + * "fw_dir0", "fw_size0", etc.

To make this really scriptable, this code has to run a script which does 
the firmware loading and then points the U-Boot code to the buffer with 
data in it.

Instead of "fw_index", use "char *script_name" or some such. Then, run 
the script. The script should set up two environment variables, call 
them e.g. "fw_addr" and "fw_size" or some such . Then, this code should 
read the two environment variables, validate them, and possibly copy 
their content into $buf . Finally, the code should always unset fw_addr 
and fw_size .

Note that request_firmware_into_buf_via_env() should also have 'size' 
parameter which describes the maximum size of loaded firmware, so the 
code could verify whether the copy of firmware into $buf would write 
past the buffer and prevent that.

> + * Return: Size of total read, negative value when error.
> + */
> +int request_firmware_into_buf_via_env(struct udevice *dev,
> +				      void *buf, u32 offset,
> +				      unsigned int fw_index)
> +{
I'm sorry for the slow response.

[...]
