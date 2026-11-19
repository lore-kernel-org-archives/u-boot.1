Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC00606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SSS+EBLj;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UFk19njt
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BEE760896;
	Thu, 19 Nov 2026 17:02:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J2J7acz7Mlpu; Thu, 19 Nov 2026 17:02:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A4554606F0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795107759;
	b=LGYHOscn8wEnsLofCCZE0reJcbknSCrVh753A31Xe+7En1q82FObW5V6JDtKNriTKBiP
	 gg267Qa/tBv99zTlhaD9giMRBNOMfV7wepahO2fjtv6DfIKVxdtWpXuoYYyaHv55LobAo
	 w3udOkP7xN8JIrkYs5mTbVtrbcOhjzRPPXY6TpXDnXoqNh5lyhxDS8Oh7hI8dOg+vhKP8
	 gib8wEoeSWVs0qTv5woGCA76B21JUTb7QbQ+cEVUEhdUs2Nk1fnIeQf5pjSRJoCzTw8UY
	 CxQWjWebBqfVuhBNYJW62sBBgSbXdb1Zoe+OJzV30OdOfMqFQZ/xsyGl/dx+D01KYzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795107759;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=QywSPaFEoYQL4BUi/dA7ZsHxPYSdpj4y2lEAuVfmUtU=;
	b=jXgQ2KYabJSoHPdGCmKNm2Z5CXvb1u+QJQ1igb24IvU/kfdO8H71bze2O4XQ6+aZQBbv
	 cAoJXe0qD4NFB0Ar5QSB4QJfykvp3DDuMyt623+ywhtlmwzJmfAO+lam401TWkvaBBiLk
	 mWjdVRZCMYCwc2WWEp1c+yY4kkkpSTzbKbYXQi7kn1bKd1TqgkSw6JWm+lzl/rH0rlkDm
	 6l/+u1owF5uXy3yiaog6fRS1W2fUJl/9HwIwjqXg59GzENlqzK0FnN/gDhq9oKVlVDV7w
	 smsIB9zv/r4/Wk8DBbkNl1BUIXiuv7R6UsH0VNzEoMuGs8FQ8HsihjnzMHs4Bi1PEkw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795107759;
	bh=QywSPaFEoYQL4BUi/dA7ZsHxPYSdpj4y2lEAuVfmUtU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SSS+EBLjVKnBUB32TCAg/OItJVNQo1wkFtafr3vTNnQ3NlesezcmsYr+JzxSIl02j
	 kvarfom9aNrCIlwrc4YZC6UoBPk9iwBrdVcAejWrYeZ47k6VHIlGcWQ2XPBmp5e6gU
	 ouUZ4XB6CBFLamW8BI4dqBgxGgwNx1dLlepry7/61Jp6jD1FvvBDFdqnkemQFw5Asc
	 OZaf8W5NkFhQx9gi7HpTYLTOfYnKz3qLHkANrhZBUb8zefE0dl/ObSG0kN6jr90JZS
	 G0tjdjvuo90W1YRhVF0YcGZt33KTgCk6MwD3mE5qE0PW70RlbURvMjITxPD6F8D6tl
	 f2UsBxTsY7waw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4554606F0;
	Thu, 19 Nov 2026 17:02:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 988E13A8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7EB3E401C8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:02:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OI_7OijPE9_e for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 17:02:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AA77240180
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UFk19njt
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA77240180
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:02:35 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6b8e2d8df4fso1639622eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795107754; x=1795712554;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QywSPaFEoYQL4BUi/dA7ZsHxPYSdpj4y2lEAuVfmUtU=;
 b=UFk19njtRPaLd01GRWFgNnesi+bdgjIxGNpHQN5EnF/CWpsBtL+GAni3pqSsbgZX4V
 kjXE2XdkrTHuN1hZcnhbKcu+Ys0NHXwQYhWv5NRc7L0ktHmqD4Q1t7SUkQk5gC8AJvfe
 JwyiRAu9SIZcAEe2WgaajmDCur7TuZT+WJQcHZiG1Vx+zKywJSDRl6rq/ZFgzt9prvG1
 U0bZK25ATYUHGcOg5myF9B0SlDxYTXVmk/v6l/187tv/g+BuqKohlxF7FgTx/fPwCPiu
 FzhAOWbFqfhhRd8sd0mZqqxRHxwyOAF7Uo2NznrDzKZte7W7BVbObyDY9LjmmUZYvRGV
 n/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795107754; x=1795712554;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QywSPaFEoYQL4BUi/dA7ZsHxPYSdpj4y2lEAuVfmUtU=;
 b=Uhb2CEAKesoROMv+eWC0WhGshFeoU1K+NoKZOzZ/EL2InYEpfTAE2Bk1prtKP2NYhk
 IDEDFpsQ8ErTwmleWCuuWSHKDLFXkWH+pDctKvLVYYS72v2SI6D6MgslrT4HGNMTmdo+
 NqoLQLbcUeeb/Ed4BaEytb/0E8mrkenWaG7fV0OMfYEZ/5OxafYIiByJcRojpIKDsnVg
 4Ks8MPWd7tRWDaoXsOPS3NqkuVLJr72TdWREuVS72rdWiJa8S+pRP1X+LxWaj9e/i85G
 imgDiYif5XhrusBAh6Z++AExxxZAHBGJExXE3jBXJ6weApvvLLi2RL4LhKeoZS0yMOe/
 j4+g==
X-Forwarded-Encrypted: i=1;
 AL+hErHTHs8PhC0hT7wbIoHeAPDI/ixFwWxmqam7yyjbY+sDRANzoKILi4Q+7bFJZd+nuTLzaUv0va8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/y0dWxN3TTaBGdmckXyWqEiP2Ap/sYtMeDF7/qhwo+ugZOH4dQ
 lJJ6fqEmPqGhlwWqxlqrlSYysFlaORq7xR74J5YlsmnM30N5qe2b++2t83C6sVGApZHT1gdgYOc
 eD6qk
X-Gm-Gg: AYBFou1y/7BO/5GOBev4xqRlIi/F1EFjVoPgf7xfJfImCvaTCSHlQddiLnqI+G/RD/e
 v+ePGcE3qDJGM/hlTdGdT6sjp4nzRNvmI6R1U/kVL7RG17IqFRY9+PsDJICY49hP3T88bIc7kU9
 tzsdrzFa9wZ1o1MwG9OGreCeqRBiffYv7ORHkdPp+tQLExcYVw3iYlDLDBhVyqSiGKSiGyUy3Z8
 Q1YILOiUmmHhQbHF0hApW5rfB8qVoxbbE17hkZFh0T9t/EeLUPUhIkRq5rJWCjkNP3JZIXh73V1
 d6+nYTYhc/4IpbaxKWZpL1bJSQz1+448UM637DwKtdwpGR/vUNjf+T0AG2VXWx2E7neRVSdIrAD
 Zeqt8uxB280woEbuwjSkS+L8HHVTb0UQqNU56XpczRe1xschw3y+kowbjE7SOf3Rsy57BdDawrZ
 qnqH8/rgTNVvn2mSGQFd6fjTPUbO68EbYvWfGFjcmxwTMx/YX7vmL3SizNqmULJFs5+ur/v37EB
 dg184wJbDyR0cTQilz/1a/FpEvOjYLaa3rCPuOXoMAWJHjOI9iNtHWQvaScppu8lVGsdwI3+rDx
 s5WqSHvW8SA/ollqRpazrV42QAwRDjDVKQMmefwPtsNsCY03eUeu6rY=
X-Received: by 2002:a05:6820:3388:10b0:71a:eb23:a7d1 with SMTP id
 006d021491bc7-71b394fc7c6mr115692eaf.53.1795107754259; 
 Thu, 19 Nov 2026 09:02:34 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:43e1:bc37:7497:58db])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b380e4a6dsm381290eaf.13.2026.11.19.09.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 09:02:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 3/6] fastboot: Add GPT/MBR partition table flashing
 helper functions
From: David Lechner <dlechner@baylibre.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>
In-Reply-To: <20261115-fb_gpt-v3-3-7ddd7ef832f6@oss.qualcomm.com>
References: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
 <20261115-fb_gpt-v3-3-7ddd7ef832f6@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 11:01:50 -0600
Message-Id: <179510771079.2216103.15768055986164454694.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3573; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=/x6lqmtQu569DWm0yY5qXTNrQIyz+egZfGAKwaqa5k0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/yuRjst33uN5LzWO2Uc9p291w6iEuUxxBucyG
 vhfk5zNEDaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav8rkRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A+TcIAIyIiWUmBcuUv6AzexrZ5njhpYWiDBXYoBQ89mL
 BMLAbvCYvZRkYTt6WZ027YOgY0zBA3puKtlK1WG8tA9xrMwxkEEWm62YNgXCeUDoU6+3bCtrwDf
 1x9gp5tNOV/Ruo7blAoDPjHk9rgdD7wAj7MaGKD3Z7WbW5tGOWdI7cZdEXrpUARy/W1fgqeEUXj
 EEguubgj1wiu8A9FLoqT/TSlXR86ISlU6gEtPNlnEsg1M0kfG0UbRnKZqTYFCNfdfU78+3x2WnZ
 mjc3ZcMoCQ9eWHylG99nmgM1GL96QGVDtGnp6+6FUA6tLDd8dOxuSr2tbD2o2PI9YHOxiY+TATU
 vWi0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Move the GPT and MBR flashing code out of fastboot_mmc_flash_write()
> into fastboot_block_flash_gpt() and fastboot_block_flash_mbr() in
> fb_block.c, so that the block backend can use it too. fb_block.c is
> already built for both the MMC and block backends.
> 
> Both helpers take a block descriptor and share one function for
> validating the image, writing it and rescanning the partitions. Only
> the validate and write callbacks differ.
> 
> Convert fastboot_mmc_flash_write() to the new helpers.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v3:
> - Pass a block descriptor to the helpers rather than an interface name
>   and device number. fb_mmc.c keeps using fastboot_mmc_get_dev(), so
>   the DEV_TYPE_UNKNOWN check is no longer lost
> - Share one validate/write/rescan function between GPT and MBR
> - Move the helpers from fb_common.c to fb_block.c, which already
>   includes <blk.h> and <part.h>, and rename them to match
> - Drop the interface check from the helpers
> - Drop the __maybe_unused on fastboot_mmc_get_dev(), no longer needed
> 
> Changes in v2:
> - Newly created in v2
> - Adds fastboot_flash_gpt_partition_table() and
>   fastboot_flash_mbr_partition_table() helper functions
> - Update fb_mmc.c to use these functions
> ---
>  drivers/fastboot/fb_block.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/fastboot/fb_mmc.c   | 45 +++++--------------------------
>  include/fb_block.h          | 26 ++++++++++++++++++
>  3 files changed, 96 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
> index fb0face0429..cf03c600772 100644
> --- a/drivers/fastboot/fb_block.c
> +++ b/drivers/fastboot/fb_block.c
> @@ -315,6 +315,70 @@ void fastboot_block_write_sparse_image(struct blk_desc *dev_desc, struct disk_pa
>  		fastboot_okay(NULL, response);
>  }
>  
> +#if CONFIG_IS_ENABLED(EFI_PARTITION) || CONFIG_IS_ENABLED(DOS_PARTITION)
> +/**
> + * fb_block_flash_part_table() - Validate and write a partition table
> + *
> + * @dev_desc: Block device to write to
> + * @type: Partition table type, used in messages
> + * @validate: Checks that @buffer holds a valid partition table
> + * @write: Writes the partition table in @buffer to @dev_desc
> + * @buffer: Downloaded partition table image
> + * @response: Pointer to fastboot response buffer
> + */
> +static void fb_block_flash_part_table(struct blk_desc *dev_desc,
> +				      const char *type,
> +				      int (*validate)(struct blk_desc *, void *),
> +				      int (*write)(struct blk_desc *, void *),
> +				      void *buffer, char *response)
> +{
> +	printf("%s: updating %s on device %d\n", __func__, type,
> +	       dev_desc->devnum);
> +
> +	if (validate(dev_desc, buffer)) {
> +		printf("%s: invalid %s - refusing to write to flash\n",
> +		       __func__, type);
> +		fastboot_response("FAIL", response, "invalid %s partition",
> +				  type);
> +		return;
> +	}
> +
> +	if (write(dev_desc, buffer)) {
> +		printf("%s: writing %s failed\n", __func__, type);
> +		fastboot_response("FAIL", response, "writing %s failed", type);
> +		return;
> +	}

There are changes in addition to just moving the code like changing what the
FAIL messages print. The commit message should mention these changes. Or perhaps
even better, do the moving in one patch and the changes in a separate patch to
make it easier to see what actually changed.

-- 
David Lechner <dlechner@baylibre.com>
