Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60485CE835E
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 15:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C950A88D08;
	Mon, 30 Sep 2024 17:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0/XABYA0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822CD88D86; Mon, 30 Sep 2024 17:48:37 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91CE682BA7
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 17:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37cdbcb139cso2137701f8f.1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727711315; x=1728316115;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cA16t2CUZjldB6eLxK8bMZ+a9TQTpoYXYqT59Wsxpx0=;
 b=0/XABYA0OqfMpoJQmK2BrnxADtWfBgxoRWHsSNQxfhGuvRV9WYB498HLuHTk6wChnc
 B8aeclyAuorBQfYlhbBPAtSn/DokJ/9ENsDICJXE/P33EFF/LTVHY7+jUM1vrAUn8l9p
 BsVWJZh3/wik482vQkkrrOM3tqKMwKoIlOGrbGpUey1vOLGSj9NM773Nq+oML4ygrHV7
 HSwEsuUioKkzMd3DXhIJq2+SC0OkrR7J33uHfD4Wvj4Q1MDGzlsjPLwUL+groNPxtutm
 oUpDv0qR2vD9ebnkDHDUou9LVXEVc6WmQXYhW9nzfBpmHLhlJOYUJVwgkkhDjqyVPwdu
 5W3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727711315; x=1728316115;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cA16t2CUZjldB6eLxK8bMZ+a9TQTpoYXYqT59Wsxpx0=;
 b=dShN2PzvHZ6QmuC21D/n8BhMSj+unXSkbqqk0gKgQHgm7C8yQSqhlf1RDUcBdSmjQX
 ew0CcN+sWaw99JFbP2yfGxPLcyuI4FL6UXWg7+zbbZ7ATPE8wFXIsx6Qlimc76WsG1+p
 mY6BkB4pw9Pa4i9F6tzdpfE51TnueLrGHUxWCA/4UKg7dijv64yYUnKJXBfsn9MuEuQx
 B0SJttTT6bE7QRBo7mfTf6LWtR3lvnpU8+2a6F5RRQzAZJH8qBuhuuBjF+UECHk7uhg3
 vs9ZVadrvePe710wzXMNiN1tjj+vAsqgQaelzqdTq8rT1K98X4tElwUxoL+AOlY/308L
 bMYA==
X-Gm-Message-State: AOJu0Yyh+rHJVIk8Z9IyEgQoudElFzd3KQmf5ts38KBdz3sk5mXGD05f
 NviM6L3FDidYv7iyBxuxmJcZyRDTxSEgbE5PQ0KGYV1bDNggZ/kA1tPKItjgbJSsEBF92eJ5ZhD
 kesE=
X-Google-Smtp-Source: AGHT+IE1fCrj9h1EzYZzVifbbJfL1Gc8y80yeuak9Xo5iO2i+pM3ie3g1jXoaM1rITRxoypeul+yBg==
X-Received: by 2002:a5d:5910:0:b0:37c:c60d:f9b5 with SMTP id
 ffacd0b85a97d-37cd5a60a1fmr6638115f8f.2.1727711312100; 
 Mon, 30 Sep 2024 08:48:32 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57310f6sm9338185f8f.78.2024.09.30.08.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 08:48:31 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, igor.opaniuk@gmail.com,
 sjg@chromium.org, semen.protsenko@linaro.org, trini@konsulko.com,
 colin.mcallister@garmin.com, 4.shket@gmail.com, avromanov@salutedevices.com
Cc: u-boot@lists.denx.de, kernel@salutedevices.com, rockosov@gmail.com,
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v2 3/6] cmd: bcb: change strcmp() usage style in the
 do_bcb_ab_select()
In-Reply-To: <20240911214945.15873-4-ddrokosov@salutedevices.com>
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
 <20240911214945.15873-4-ddrokosov@salutedevices.com>
Date: Mon, 30 Sep 2024 17:48:30 +0200
Message-ID: <87bk05m9bl.fsf@baylibre.com>
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

Hi Dmitry,

Thank you for the patch.

On jeu., sept. 12, 2024 at 00:49, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> In the entire cmd/bcb.c file, the return value of strcmp() is not
> directly compared to 0. Therefore, it would be better to maintain this
> style in the new do_bcb_ab_select() function as well.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  cmd/bcb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/bcb.c b/cmd/bcb.c
> index a56535a743c0..a888549eed3a 100644
> --- a/cmd/bcb.c
> +++ b/cmd/bcb.c
> @@ -432,7 +432,7 @@ static int do_bcb_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
>  	bool dec_tries = true;
>  
>  	for (int i = 4; i < argc; i++) {
> -		if (strcmp(argv[i], "--no-dec") == 0)
> +		if (!strcmp(argv[i], "--no-dec"))
>  			dec_tries = false;
>  		else
>  			return CMD_RET_USAGE;
> -- 
> 2.43.0
