Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7BF606A31C
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T9BMblDI;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BzsqNE5x
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 554E580E13;
	Sun,  8 Nov 2026 16:38:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ElnQRh-uDLR; Sun,  8 Nov 2026 16:38:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 64C5380D82
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794155907;
	b=a7NsqDiOxCtjafS/FJxaKV/HU7bhm+pOitc/Hy/vAg/ifTgOtDxS8e7JEAY8r6yaKXxd
	 NmwbULIsXyCIR3u+mPQK9VyJhD9QrS834gBFgIyi+s8V2x7Gk10lbk1k6qLnNzDC8jUhR
	 8Ra4bzMV8HdXF1nMfNXajbdhL2Ic80siYladcDFitssuKMr54/APlooz++v3Et4K4ZzTu
	 pHlpUv7leRc80mlQtk1vtz54E46SCpiT/JDPBkswilh30bTB1I+VkP32UNzqDbNzMxe3a
	 3r02XZh8E0j/w9qqK2hjVYZgTiM6LF+wce6s8WOE5qcnt7LqWsc2SZkAMFk3NUykTNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794155907;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EosK11gUrnZ1ka7Z6W2gjVh034I8ufyC+q9YRT49tpA=;
	b=MjdHgND6FQB+MPmUbqx9JlHVsA+/kIgmTDC5/eJ9aGwC7SUcaUuskao6U4aAuTAvj9QF
	 mPbdRA/B9sCD9XwXnJ0tVPm/plEZ/qAYdIkF3+/cb+xVEEqKpNIqyOze1UucuXbfhfChG
	 sidcanydqDckAYQN+NOf+ACwO7wUkl1IN77xUm3x/0+LEkO4WSvjhOescqEA5KQTUa8T6
	 DoKHKujwTvxdhhvvaa9Kcxx7SIY+U/mn/epnpz5ZnhpLfoPvzynPbJ2UArj+hnGzxlTRE
	 OMyyE9ZcHAiX1AsHk5nvdofmo8+j5FLiGUtwvbGS+5ZqtkYwI9n6kDKxysCjOE04IAg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794155907;
	bh=EosK11gUrnZ1ka7Z6W2gjVh034I8ufyC+q9YRT49tpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T9BMblDIF/lcXMxkPrpLLVSQEDjKRYQlj0xO99pxlC76ITgGDUQpNoWfYmlR8RCKd
	 gtvzANqm36MN86nrSzht1WSL4vxtKEbqiOHN0gZM1xOePTZSu/0FgO0SH6M3Za4OxZ
	 z0pdmz/1TRmUb9kWHQgxnZFQcOg6fI6zoke16NoaCjLZrdYjDgtVyXkr5NNJ2gwdRL
	 t8wANETvjrdXpD6yh+7MY2zbJlfw9mOsO305nPm3Q/91Z0sBdDrS3i/2cO+cdGU9ei
	 SikbXOdVUr7opcCKSVAHHpwyzTsl+4TYM377jqVw5DFwpdUT8kSwTa42h2an2tfM1g
	 IBRSDVGamWbJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64C5380D82;
	Sun,  8 Nov 2026 16:38:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B96F2932
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 16:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AB41660601
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 16:38:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 37Cd7NTAheIh for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 16:38:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 621A6605F8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::8;
 helo=mail-wr2-x08.google.com; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=BzsqNE5x
Received: from mail-wr2-x08.google.com (mail-wr2-x08.google.com
 [IPv6:2a00:1450:4864:30::8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 621A6605F8
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 16:38:23 +0000 (UTC)
Received: by mail-wr2-x08.google.com with SMTP id
 ffacd0b85a97d-48e3465b262so61285f8f.1
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 08:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794155902; x=1794760702;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EosK11gUrnZ1ka7Z6W2gjVh034I8ufyC+q9YRT49tpA=;
 b=BzsqNE5xb15R0B+0kBom63HGoY/CSFCHAZedkBOMnyJy3fEmIk+lU1B3O8YUmNOsR4
 dZAtmlj87Iamdvj5iBklMwtYYc4U3aLCFZGsx/lE9c8/0vmMPBvjxEv5tQEr6QG+f3s4
 oohEAqif+MZe5TwuZs60ZzoRd3G1xmAmxZTcop09NUs5+xO/n8Ao9BItydj7nW0Kq/2V
 GTY4iomuZJ0xgqSU1tmt+n9W13pDsdFXToRGifHSe/O/H/Whs3uN3atkZRzeSdrjuGeD
 18xu+05LibwAdbg3VRfiNtTxZo0JViuEqie6PMf6Q/qeg70KwcM4eoYKApa8CyT3nRd8
 s35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794155902; x=1794760702;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EosK11gUrnZ1ka7Z6W2gjVh034I8ufyC+q9YRT49tpA=;
 b=D4AJoEtl2ho7Ek8y8gZChh1YEz07/D3i9yBCKp8a7kVTZJmKeVlkaw7YydfjEz6xbm
 SjRJ9mO4ivF3/jnrPOt3UWPK757nS54bkOONs1IbOFb4KJk5xDXIHC4KB3Awti/DFJxZ
 6I5EpQFFOVzPUeLhp2ZlG23hSe8pUwfQ1mWh5GdosKnZCkobv77+jhgFgnIsxELNmgqM
 ywfzExWQRhm8L6AWE81kaTi2b0V4f/DToO+UZ/fUDf4bRcWpspZ5ovVRPtwK2ng0zU8s
 r4PaL+LngH6hCaYgv6SNBXbvxJjcRKBsTr+w7jAwctOOX/W7czJb5xw2MloLlUcPEeBv
 uKqQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEcFIkmE9bqLEJcj821bLfcGYWVEjNeiU3sc+9Av9LRp2TSX3mcOpkD7KPZQ9RSyKTHTmrppHw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+q6ZPveDpHD+HqyqQkG3bkFOfBEgHgljtbuj6dcyTrWFQzC7pg
 3j7EF73LG04eyp58E5sCePHEvYRHh2Oi0jSyjtZVoduBIV2KbL5cEFpRFh7N9yx/9oo=
X-Gm-Gg: AYBFou2vZClQKBNmkrXd8FCJkhmmVCedYoF8HZIGXEtAckF23mvB71zm8c7EolPvIJo
 Fjrp9xeGC5Dfuk9mKzXdRDa8uGcEi+FWfpa2i7MLLI4QLQU4UAfXu6L758NAx1bgbQpoCQiMrCN
 FDoRc5w1Ng6V63IyBsRJRdTEP8nVruv1w5lZzFwZav7rAycJtsZhBIhDRwJMMC49gl0lvxp+FhB
 SOtu9/aGPg3JyltCigRGaU4sNw6hYpbo+o8bx1opMsNCbbdKyBl45N0/H2QKJBlq9Q1H2+7oXxx
 Qpce8exfjjY32ZNXN4DntlBBytoH95EPGFJ7pU9Urr8TnE9C+76QKvuKpQdPH0pC8P3fs4cCa9g
 TQRRdatn+i7cZBsniQJ6H3iTcBeLY4IyyB3aXggauxmFgX1ZwcSydih4uoM+L+J+MAVQZFjKWlH
 Q9Umi2cA0B3DiOY+ZLhEgpFF5P53wuJTMTOqW4E+ni0WQi+1Bl0csiwtCQGdOAxdBNGlEouEMBy
 9qBDxFaTwhixrKzg9+7Zxsb8UyHXNZRP5bs8UL96IkFbKqiwFsC4B4TSnbcnA/OZtp9aJ8dqv4A
 2693cLQbrbbyx1Ao8YTMPeknDi8sbmLJ0RBh40d/GgU5yNbKw+zoLtretDn8se4Aqewp
X-Received: by 2002:a05:6000:2289:b0:492:149f:67ae with SMTP id
 ffacd0b85a97d-4958502c5a3mr3990205f8f.32.1794155901674; 
 Sun, 08 Nov 2026 08:38:21 -0800 (PST)
Received: from [192.168.1.37] (p549d4ba8.dip0.t-ipconnect.de. [84.157.75.168])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4959774736bsm5152460f8f.43.2026.11.08.08.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 08:38:20 -0800 (PST)
Message-ID: <01c106ef-a383-4e8c-8046-a9a56cf32815@linaro.org>
Date: Sun, 8 Nov 2026 17:38:19 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] reboot-mode: update env from every reboot-mode device on
 boot
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>
References: <20261020-reboot-mode-env-update-all-devices-v1-1-62f428488321@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20261020-reboot-mode-env-update-all-devices-v1-1-62f428488321@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Balaji,

On 20/10/2026 09:33, Balaji Selvanathan wrote:
> REBOOT_MODE_ENV_UPDATE only updates the reboot-mode env variable from
> the first reboot-mode device found at last stage init. A board can
> register more than one reboot-mode device, and if the first one has no
> get() op, dm_reboot_mode_update() returns -ENOSYS and the others are
> never read.
> 
> Iterate over every UCLASS_REBOOT_MODE device instead. Devices without a
> get() op are skipped, so the result no longer depends on probe order.

patch seems fine, commit message and kconfig description need rewriting.

Thanks,

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> This patch depends on this series: https://lore.kernel.org/u-boot/20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com/
> ---
>  drivers/reboot-mode/Kconfig              |  6 ++++--
>  drivers/reboot-mode/reboot-mode-uclass.c | 15 +++++++++------
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/reboot-mode/Kconfig b/drivers/reboot-mode/Kconfig
> index 35f12e1bdfc..710baf85200 100644
> --- a/drivers/reboot-mode/Kconfig
> +++ b/drivers/reboot-mode/Kconfig
> @@ -44,7 +44,9 @@ config REBOOT_MODE_ENV_UPDATE
>  	depends on DM_REBOOT_MODE
>  	help
>  	  When enabled, the reboot-mode uclass will automatically call
> -	  dm_reboot_mode_update() on the first reboot-mode device at last
> -	  stage init.
> +	  dm_reboot_mode_update() on every reboot-mode device at last stage
> +	  init. Devices without a get() op have no backing store to read and
> +	  are skipped, so only devices with a get() op update the env
> +	  variable.
>  
>  endmenu
> diff --git a/drivers/reboot-mode/reboot-mode-uclass.c b/drivers/reboot-mode/reboot-mode-uclass.c
> index 976544d2810..dc8dc754c25 100644
> --- a/drivers/reboot-mode/reboot-mode-uclass.c
> +++ b/drivers/reboot-mode/reboot-mode-uclass.c
> @@ -122,8 +122,9 @@ int dm_reboot_mode_pre_probe(struct udevice *dev)
>   * stage init.
>   *
>   * Called via EVT_LAST_STAGE_INIT, which fires after the environment is fully
> - * initialized.
> - *
> + * initialized. Every reboot-mode device is offered the chance to update the
> + * env variable from its backing store. Devices without a get() op return
> + * -ENOSYS and are skipped, so probe order does not matter.
>   */
>  static int reboot_mode_last_stage_init(void)
>  {
> @@ -133,11 +134,13 @@ static int reboot_mode_last_stage_init(void)
>  	if (!CONFIG_IS_ENABLED(REBOOT_MODE_ENV_UPDATE))
>  		return 0;
>  
> -	ret = uclass_first_device_err(UCLASS_REBOOT_MODE, &dev);
> -	if (ret)
> -		return 0;
> +	uclass_foreach_dev_probe(UCLASS_REBOOT_MODE, dev) {
> +		ret = dm_reboot_mode_update(dev);
> +		if (ret && ret != -ENOSYS)
> +			dev_dbg(dev, "reboot-mode update failed: %d\n", ret);
> +	}
>  
> -	return dm_reboot_mode_update(dev);
> +	return 0;
>  }
>  EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, reboot_mode_last_stage_init);
>  
> 
> ---
> base-commit: e6af0ff0a6e884320938f9c698efad3e217b4e99
> change-id: 20261020-reboot-mode-env-update-all-devices-2bb1457e3a3c
> 
> Best regards,

-- 
// Casey (she/her)

