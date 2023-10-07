Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB83E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 829AE86DAF;
	Sat,  7 Oct 2023 23:35:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HBOMSPZZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="n6GaVS84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1578F86568; Sat,  7 Oct 2023 23:35:52 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30DE686DAF
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 23:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S2z9v73g3z9sQm;
 Sat,  7 Oct 2023 23:35:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5G05Y21WRXw8D06L+tAX/543vIG4QeO/yRfmORexH4I=;
 b=HBOMSPZZqqKauvK0WWOEDq154UyWyY6ggHU+1sy1r1ZpfDNtvWZ+8bqgwrarRlPBQ3dF/B
 ZaaNHJLX1PogOdduvXBauOoiAU8g2fVkDCyNdaspdRU0qeD6WVgZ0iGLToCArVpw4lssMz
 PJplPbcVz8eiCGZsIMqDiL6GYvXUCsvfZxsr4WmTBA8YAcFppVttFrpYM+0pvDpzNdut3f
 ZSKQvvuguo7IShX+adqTHA1T5e2rWBPMmWRvFhKJHpwIrjTwbLIv7ePLd6uBXEqvrdQEbI
 1adCA5hEQRu1aSXsdVYxKsoutGaf8krih9LtfyALold+uNA72Imp8cygeZJGpg==
Message-ID: <20e31b28-5bd0-4d29-b040-8d4c49e0b26a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5G05Y21WRXw8D06L+tAX/543vIG4QeO/yRfmORexH4I=;
 b=n6GaVS84ZFjL2Bjy6iszcnbxqH1Sk/5t3BMg/5dpEoHrSXqbnylPGj1qPuFFLVoAu91Q4K
 /rRYyffP+2uCRj0U2DxPdTBKd7BpnVIog4JPoPKTMVW58fbwYfXkUHiVLK+dccRMJP5ewG
 ed9+/gHzUNAQXT8bdpsKHPcMUrlzo4hy0i3Xs1dwav8vJkrGlFvrYnd0pX3zKW2eDBmtge
 TekChPC/CamqUghSLjoE6bnR0vJ2ejAnGpf+5MLq1lgIkLlxahszOztObONIyKwz/saYBv
 mAUc9LztpIVIi+PcFkRRktPpaHj1q9CTlhjKhTYAAW3c57bCmFjNRX/DAoPiag==
Date: Sat, 7 Oct 2023 23:32:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5 5/6] sysinfo: rcar3: Use int instead of char for
 revision
Content-Language: en-US
To: Detlev Casanova <detlev.casanova@collabora.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Simon Glass <sjg@chromium.org>
References: <20231002152142.76516-1-detlev.casanova@collabora.com>
 <20231002152142.76516-6-detlev.casanova@collabora.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231002152142.76516-6-detlev.casanova@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8nobxd9bjpo3q89diitms565sy84qdqn
X-MBO-RS-ID: fa8fd5a4982a594c735
X-Rspamd-Queue-Id: 4S2z9v73g3z9sQm
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

On 10/2/23 17:20, Detlev Casanova wrote:
> To be used with the sysinfo command, revision values must be considered
> as integers, not chars as some boards will implement BOARD_REVISION_*
> and might use numbers greater than 9.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>   drivers/sysinfo/rcar3.c | 73 ++++++++++++++++++++++-------------------
>   1 file changed, 39 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/sysinfo/rcar3.c b/drivers/sysinfo/rcar3.c
> index 7b127986da7..633e80bc19b 100644
> --- a/drivers/sysinfo/rcar3.c
> +++ b/drivers/sysinfo/rcar3.c
> @@ -68,8 +68,9 @@ static void sysinfo_rcar_parse(struct sysinfo_rcar_priv *priv)
>   	bool salvator_xs = false;
>   	bool ebisu_4d = false;
>   	bool condor_i = false;
> -	char rev_major = '?';
> -	char rev_minor = '?';
> +	char rev[4] = "?.?";
> +	u8 rev_major = 0;
> +	u8 rev_minor = 0;
>   
>   	switch (board_id) {
>   	case BOARD_SALVATOR_XS:
> @@ -77,81 +78,85 @@ static void sysinfo_rcar_parse(struct sysinfo_rcar_priv *priv)
>   		fallthrough;
>   	case BOARD_SALVATOR_X:
>   		if (!(board_rev & ~1)) { /* Only rev 0 and 1 is valid */
> -			rev_major = '1';
> -			rev_minor = '0' + (board_rev & BIT(0));
> +			rev_major = 1;
> +			rev_minor = board_rev & BIT(0);
> +			snprintf(rev, sizeof(rev), "%u.%u", rev_major, rev_minor);
>   		}
>   		snprintf(priv->boardmodel, sizeof(priv->boardmodel),
> -			 "Renesas Salvator-X%s board rev %c.%c",
> -			 salvator_xs ? "S" : "", rev_major, rev_minor);
> +			 "Renesas Salvator-X%s board rev %s",
> +			 salvator_xs ? "S" : "", rev);
> +
>   		return;

Extra newline got added just before the return here. If you want to do 
V6 with that fixed, that would be nice. In either case:

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks !
