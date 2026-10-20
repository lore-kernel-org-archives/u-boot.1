Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB4606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KLORwx18;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pAqUASsa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35D8E81135;
	Tue, 20 Oct 2026 10:34:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dOc2bG9JaX6r; Tue, 20 Oct 2026 10:34:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 347CA81111
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792492455;
	b=a+H4ppfMKegjBGrx/e5hF96SNnWYpunKTSUOSQ9spuvYGyeM57V82NBu2UQGrxHRyTvi
	 vK7mE6VKrDj3hRqoNYiMa8j2AYsLAs1iZJGZwxXD6AHwrs0XOmEr+LW3q/YGs1qUt1I4l
	 PzTaodqRvi8WK8FBN8Rw2X2yjV7aAVcjP88rNoUapMwmMU3Cphreu9CcXey2GtKNDN8HU
	 geJtosRSsv3o9F2g5It1mxwXKr6H98OdmctsMfkPsX9dZcOKaN0mZXEGsohtiPPsoQz1C
	 y387qQ/msSzvtBRJe862Lcn/5Q8zyO6+EgSS2EiN55d0YWRqJWqQ5bCdC6Djzs6yBtw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792492455;
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
	bh=W/8sft/QeI507DRxU+qRmrHJ1hKTF9Ck9hFTvIDqJns=;
	b=TBHFbVNRVr/J+9s4mGJg/0t7ZRblxoAwfj5ypsQD1nRXjnYOLzvilbczWIeQTbg6KH9o
	 oF7u9BqbFvQADWXue0gtTzjb3FQiWnDyNhAomoLc4n9R5cMovcz+owdzsUTyOYBj8rjpz
	 gMAGr9aoUBD1iyE/94hnWQTSyO2Bg6LkyKF6N3FymSRkXTz5tbFc0hjao4JhtJtxCZsjJ
	 vf7UsFVE3QwXyVyX6foAQbh48cvodEKcsGGlgtUWwITD/nzUrB+z08o/URcszVLimd4/1
	 TC3xqm8uoxE8EkyRP083FIDhTDBrQXgWunGwMXjQxMJ+zH2PfQf5yvz1noL/1gY+tCQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792492455;
	bh=W/8sft/QeI507DRxU+qRmrHJ1hKTF9Ck9hFTvIDqJns=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KLORwx18NeAFYAaBLyW0D7fgPA0wdQWnm5hgHr6/A5PliYxpvJRcYfFoMeDQpTo9F
	 wU9r7xq/b/GTqr140Tk0Viwt0KgoZQKFVk8nyvanbQQt+v28E68YeRm/hp4aMhIJFW
	 qu5/LcxdF7/zAACMgNm096ML5XBFbyTNVNnPZWspb3ZVb616SUq8lbdJzHe2Hrxdus
	 61YgeRcMq+2a+AvaZH577M2FI/VZxSXjwBltLD5KWSPEAJyTCnOZhWrkSGYYk3Hx5R
	 P0RIVdY43Jpg39D1lJLojPhYLE8Dbi4wwgbEA9JV6gYEvO+YsnJ3UdjEm71XFHPyur
	 uCX25Xzlf3rpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 347CA81111;
	Tue, 20 Oct 2026 10:34:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E20F1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F24D400FC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:34:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3wXH88FjaypV for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:34:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1A21240119
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792492446;
 b=JWMsC0+KmJ3PNOh8fptnBjgIOo6UQEMf6yaXyxELmkfA8Dh5coalG7WOGA22MHfoTFLK
 wL/E5CO3ID/JmNGR5KttW1k63OAT9nqYJGXQw1sppKRofA/f91Wf3VIPOYb6UdTzn4YDA
 0Ezyz5JpXXCcjlJvsTF4MqSt+Ma6OsgNujX1DVTNHFztw/zwZVKweCY++m0CHm57NNxWK
 fWjSgjrF5KQkeiFdx30Lg7cjtbBkzGfsqDVwefQA8wk2os6e9qdKCPmH3YNEdwcuARWvQ
 vuB4oqNTZRukhrIq2EOoyQyjeLOu5Fae90GXLGdt+tKb0pGwX8dU110RFmMAIjttX7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792492446;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=W/8sft/QeI507DRxU+qRmrHJ1hKTF9Ck9hFTvIDqJns=;
 b=huxVjB/5LZsAj+FweQ3cK7phQASHF8JaJj/HAwn+ePC7bth0zVkniclmTJlngB4+IPSS
 KgcjwqxCId7oaPZ5GYBJqpuEApIYVfyGy9uuRvVB1y9adyB6ZdOosHOZaWhvXYGzBY96L
 8IbMV3u9gcMciJRNpQ99HE2/G8q0i8ra7Er4cnUC77NdNKL570Rk/IcXPATIHLSYlqsB1
 cis0xP8okEuWwnKpqFpwLOIEyXT6sXP2Wk0q0unhtz0uW3RIKTqSojKe+f/NbbiGFcs5k
 0andadY+LRUeiRr0uBVuQOS/mCeLXrUHfQaijcMjqb2wMB0/qICeiswF2KP1MKz5mTg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=pAqUASsa; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pAqUASsa
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1A21240119
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:34:05 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1cef0439aso33743645e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 03:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792492444; x=1793097244;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=W/8sft/QeI507DRxU+qRmrHJ1hKTF9Ck9hFTvIDqJns=;
 b=pAqUASsa6dl4jOhdvQlbo3+hMjG9DxY25rY/Od/70q4Egup3/SIagFL0qLAe9hxGpX
 MjChbQHa0kIQib0H8Ze4d4KEjumM459VpoHeSwnHdUUciiHf6vcZ4qpgpR2ZlsM0IA4Q
 bAyLEzTNPC74AldZNyg8K4YmcOuYtrJHZaCkaAjOXJojCmj8RVYAGhLYNoU+vAvbOKFZ
 4Vwn2Do2LJcVo2PoZi6szVr/548Z2yu3HgGbVpma9uTQf/uXl57ZJZZx6P9hv/aP6exj
 kLqS6PSbS5V2LLlXTc2fuss0J779dZmATWnUmbCRGGIpUGe3kvDQQsFAH8Ac8yYXueTH
 j8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792492444; x=1793097244;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W/8sft/QeI507DRxU+qRmrHJ1hKTF9Ck9hFTvIDqJns=;
 b=oA6OW687JwTziBEJx9p5ew32UPyvV/ISTQzaYsAKqd+GzGxhc5fnDA5EDGkaHT0fWu
 +hb2B122YB733v7ubFs6IfZkSThdx02sSIe7ImpgTepwbcsAgvoaCWBLlXEduyYn4uwg
 0X4rtYr06k5V6O/qDRKBU4GaA2k1vOWdm3XcAbiYw8eLZZcDf2wMqSPh39viRcjIxlPc
 Hk8SHFfnh4ygiYiMbpv8RwKIq/3yaO1bqObBQh2mxkMTDjpEZxghVzt9BQSp1A9eMBI+
 o8R4IPsGZxwJNRkqxnMgBQ/LVKIpDjMUL3/RRNvoZhDDc45OAtiRq39HJj2L6JyVJVvD
 f7XQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzR36HgkG+O2kYxQ+DCVJTo/rQ28LYLj9qhPGSIK0SrlxjugDuLmNQpRMHZV3QUM0UPDteQtAo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLgOXpvh5cfMcfBDFuM48JmmzdyzUGwYGnXZQFFh8EXd2oP3gvz
 IRz2Vdk7FgQHsd+jpqlCLEBmKvOxbqn1rHtRWGSF0Balh3XbYNqokLmJafXk6lxPBcd89wQqKKW
 LlwpC
X-Gm-Gg: AYBFou0+bIQ2wZ7YSghpAjXrbPxOMXi97HUVf11MpweoPIcHb+R4tEmjO35dAuE5o4+
 SJxLNWJxj7qht3orHuwbvWJwycF88/QW7NNBHfWk0Yl2tdnd6w1PZ5aXyCiF2dN8EuYPMVdGOxY
 DCPSE8ESQ9MQijz+gmcTlhx08KAGH0jzTve76VokxSozljsrnOIN65E+/NVs5kApoDbeiQKoaee
 b7isragZM6ahSKwYR/+nT7+cfPZT4ykFR7BWGoHhOJbSgXPnVkOs7ZOVW0mBUPc6vH7rXd9/FcO
 N/G9CuHnbo43U1/casxJsxQoRPDacgKrywKPebe8ryxZBTukVfitvFcgsqES1Lx3877dM86Q9me
 L9ygfuCBrgepWU60p2H18EH3PdIS/khKlOvIW/PSgt0F1jem6Tx+JVymmJC4F3Ktd4bHwmrnZD4
 +jGHzgjLbvlSkqWCIK1DfKL9HahA4i9cfkfjRBIpkadlXWk120t1RFC0wh3jwpjUZPEhnqDsVSO
 d6+kVlrH7buWB0bvle9
X-Received: by 2002:a05:600c:3b82:b0:4a1:f625:2108 with SMTP id
 5b1f17b1804b1-4a1f625225amr35171755e9.33.1792492443856; 
 Tue, 20 Oct 2026 03:34:03 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cdc342sm67880245e9.13.2026.10.20.03.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:34:03 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 4/5] fastboot: add flashing
 lock/unlock/get_unlock_ability
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20261012-upstream-avb_lock_unlock_b4-v2-4-87460a24e559@oss.qualcomm.com>
References: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
 <20261012-upstream-avb_lock_unlock_b4-v2-4-87460a24e559@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:33:56 +0200
Message-Id: <179249243657.2829155.388045425581183783.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792492440; l=3167;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=hzpXt/WsHda3qWiB4UgHUZrGaFBQyl0hEztZlDKY0sM=;
 b=C9/P0wKwOd2TSYwnZ4eGpVFUbpH8mFUYJqcCzaBB8NnbO542ma0KD9lgWaCDdmwzK7QNriF+/
 reIrPitLu8oAHTbSZWe4poxUEoShcC3zGReMLrQVyFdXijuVwbMYV+u
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 12 Oct 2026 22:25:06 +0200, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:

Hi Igor,


general comment , perhaps i miss somehting but  if i do a fastboot flash
userdate or anyother partition with lock at true fastboot flash function
don't check lock state.

>
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index 18d86988f4c9..9bf012645ef2 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -589,3 +611,100 @@ static void __maybe_unused oem_board(char *cmd_parameter, char *response)
> [ ... skip 40 lines ... ]
> + * @response: fastboot response buffer, filled on failure
> + * Return: 0 on success, -1 when userdata could not be erased
> + */
> +static int flashing_wipe_userdata(char *response)
> +{
> +	fastboot_mmc_erase("userdata", response);

what append if we use CONFIG_FASTBOOT_FLASH_NAND or
CONFIG_FASTBOOT_FLASH_BLOCK ?
it could be better to call generic function which are backend support

> [ ... skip 11 lines ... ]
> + *
> + * Verification errors stop the boot afterwards. The AVB TA resets the
> + * rollback indexes on a state change.
> + */
> +static void flashing_lock(char *cmd_parameter, char *response)
> +{

you don't check unlock_ability

> [ ... skip 10 lines ... ]
> + * flashing_unlock() - unlock the device
> + *
> + * The unlock is refused if userdata cannot be erased.
> + */
> +static void flashing_unlock(char *cmd_parameter, char *response)
> +{

same here

> [ ... skip 14 lines ... ]
> + * unlocking is always possible.
> + */
> +static void flashing_get_unlock_ability(char *cmd_parameter, char *response)
> +{
> +	fastboot_okay("1", response);
> +}

this ability should not be common with android status ?
if we boot in bootloader fastboot mode we can disable lock mode without
action from developer setting in android no ?

>
> diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
> index e8aa0e09aa63..92c8e702a0b5 100644
> --- a/drivers/fastboot/fb_getvar.c
> +++ b/drivers/fastboot/fb_getvar.c
> @@ -88,6 +89,10 @@ static const struct {
>  		.dispatch = getvar_partition_size,
>  		.list = false
>  #endif
> +	}, {
> +		.variable = "unlocked",
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (getvar_unlocked), (NULL)),
> +		.list = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)

with this when FASTBOOT_CMD_FLASHING not defined unlocked value  not return on fastboot getvar 
all but if we do a fastboot getvar unlocked dispatch will be null.
do same as other or do a getvar_unlocked to return unsupported or
something like that

> @@ -346,3 +351,32 @@ void fastboot_getvar(char *cmd_parameter, char *response)
>  		fastboot_fail("Variable not implemented", response);
>  	}
>  }
> +
> +#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
> +#include <avb_verify.h>

include should be on top of file .

> [ ... skip 20 lines ... ]
> +}
> +#else
> +static void __maybe_unused getvar_unlocked(char *var_parameter, char *response)
> +{
> +}
> +#endif

/> @@ -53,6 +53,9 @@ enum {

-- 
Guillaume La Roque <glaroque@baylibre.com>
