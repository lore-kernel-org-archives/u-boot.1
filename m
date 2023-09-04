Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD4CC83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 07:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5952868D9;
	Mon,  4 Sep 2023 09:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y5fgkoLv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA201868D9; Mon,  4 Sep 2023 09:40:14 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74E91868D7
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 09:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31c6cd238e0so1163802f8f.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 00:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1693813209; x=1694418009;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZksL5n4LMYkHVNUHLjYBOWLEY+wGAfEZPNtiROCJ7lw=;
 b=Y5fgkoLvnYnYqM++7uu2iXSvera3dbHVCyf4oU49zr+0rL9JVGRQr87r5lRC4a+PvB
 9M2vMJUa/E6i2Y5vIZcf6HzQZdmBUt8y8DRVACUm62rHol/1Atf1h2XV/LjsbpCrD6wr
 QB8DFOsEFCO9UsMvUfvCXrpvpqv09vRPx2US5p27nxWxombqigAY5WWWTTiKcO2wjnqy
 IWoi/iCSHrhYKlyYQsAjT21Q75YP3FWtIpVbzAPmOrcAwKeWeHV8WDHPukFhgaKXIAG9
 oINrd75fSfXF3gkPGEPT8H8oShUiYTt/SL6qSdKb1nkj/BORPNDUOVClquPzezpZQHXo
 W/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693813209; x=1694418009;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZksL5n4LMYkHVNUHLjYBOWLEY+wGAfEZPNtiROCJ7lw=;
 b=bVmJgkWL2uqJxiuMEaKeK+oLFfhC+ato4KeVD6uShANQRIBaFeOFrtDF5el9e9JTGC
 iC6oebPdcrtwmJRrJpa0DLAOZYc1BLb/jXKMvYalix4vZ4/fPr0UhoFGjxauw8RDNpVv
 UWqu88NGIUi6JsWC6OHbqyjsk8N8h5wNYk2RUtwmXLkmDdfoBVPZdnfRMW8hPdhLT/Zj
 G/SQ5qIs8plLIKfC4yimzwimEVCXluLOwGmMgs61n4+bwuethHVvBkDhmLkInY2mVqTC
 ow/UN/3yl0El58N9mm4KixMll5SgVmfqjftblLg8DLH94HTTrf3sJcWpeKpH/XjApTCn
 FY5Q==
X-Gm-Message-State: AOJu0Yx17u1hrEmr8thyPersJCXJOoo1ol+JSL69rCT3hc7pgzBIWsjF
 yw4pS41XZdaIyyyBuYnDlJd1cA==
X-Google-Smtp-Source: AGHT+IE1Yu861wX1yB+vqXOY46IFmhAEzU+nRcDycy7zTsZNXyq///x4KMP6m/+WImBaIOqxFBGz1Q==
X-Received: by 2002:a5d:69cf:0:b0:319:7ec8:53ba with SMTP id
 s15-20020a5d69cf000000b003197ec853bamr6616773wrw.14.1693813208670; 
 Mon, 04 Sep 2023 00:40:08 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 h18-20020adff4d2000000b003141e629cb6sm13678995wrp.101.2023.09.04.00.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 00:40:08 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Angus Ainslie <angus@akkea.ca>, Dmitrii
 Merkurev <dimorinny@google.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, Stefan Roese
 <sr@denx.de>, kernel@puri.sm
Subject: Re: [PATCH v2 07/17] cmd: thordown: Reorder variable declaration
In-Reply-To: <20230901095003.352930-7-marex@denx.de>
References: <20230901095003.352930-1-marex@denx.de>
 <20230901095003.352930-7-marex@denx.de>
Date: Mon, 04 Sep 2023 09:40:07 +0200
Message-ID: <87fs3u2xpk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On ven., sept. 01, 2023 at 11:49, Marek Vasut <marex@denx.de> wrote:

> Move the variable declaration around to improve code readability.
> No functional change.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Cc: Angus Ainslie <angus@akkea.ca>
> Cc: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Eddie Cai <eddie.cai.linux@gmail.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: kernel@puri.sm
> ---
> V2: No change
> ---
>  cmd/thordown.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/cmd/thordown.c b/cmd/thordown.c
> index 838764ccef7..0d8dcee5314 100644
> --- a/cmd/thordown.c
> +++ b/cmd/thordown.c
> @@ -15,22 +15,23 @@
>  
>  int do_thor_down(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
> +	char *interface, *devstring;
> +	int controller_index;
> +	int ret;
> +
>  	if (argc < 4)
>  		return CMD_RET_USAGE;
>  
> -	char *usb_controller = argv[1];
> -	char *interface = argv[2];
> -	char *devstring = argv[3];
> -
> -	int ret;
> -
>  	puts("TIZEN \"THOR\" Downloader\n");
>  
> +	interface = argv[2];
> +	devstring = argv[3];
> +
>  	ret = dfu_init_env_entities(interface, devstring);
>  	if (ret)
>  		goto done;
>  
> -	int controller_index = simple_strtoul(usb_controller, NULL, 0);
> +	controller_index = simple_strtoul(argv[1], NULL, 0);
>  	ret = usb_gadget_initialize(controller_index);
>  	if (ret) {
>  		pr_err("USB init failed: %d\n", ret);
> -- 
> 2.40.1
