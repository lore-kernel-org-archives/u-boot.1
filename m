Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504DBC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 09:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC4C5884BF;
	Mon, 10 Jun 2024 11:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gNqFcIIZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F3287EBD; Mon, 10 Jun 2024 11:45:34 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30BB887E0D
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a6269885572so917983966b.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718012731; x=1718617531;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:in-reply-to:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/jDdtsnPkPsC4yWqLV7zP4peSlzjmLdK5xPV8yzJwVY=;
 b=gNqFcIIZe5ahW7zJ0/oybWTUFL/3bT2tMGblaaSHcYRsaa5DnA+2Udmfcgft0falns
 jXgUzTQYCIx59IAaebx10yCWdiNpq1EgeCfoP1UdYPXOanHiomKE0x8b4ZW8LwEtpxnY
 rWEMXNg54Ucdo7SPpGGCiboForR4zUtilMNu8jC+HlwbvVme8NXKPXe7egBf2j4JnjeQ
 rvQOLZKtolqMiTwiNJhHQidv/lT8XboXvlAj6JS6CqtTOqe5Wr5AS/qI3xjTPaeSs5Bg
 +yKotMM9DBz9jumgwY13JQD+C0byjmQIunQA1kiu8vMaexN4RnJ/RIavIXoZAe9SYNEQ
 Tq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718012731; x=1718617531;
 h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/jDdtsnPkPsC4yWqLV7zP4peSlzjmLdK5xPV8yzJwVY=;
 b=lupbKYSdvNsqrx6wAcqNmf+Kddx7fZGak6NUOg3hXrYTDsHaKTO+CVzA08hapjEau3
 xCt00rLavbiGX41w6k8+jE/q/9tyNqz/0YnM+YUmkPWYUt7VWLoWqp5BcHj/2ehC0NeQ
 l903n5qlih3w8G8lR0h1F0TI3txXsUYZOJ+HqXLzCTGKHhWD4d2GLKFiyqdPOsYm9lEp
 ywKI5N8hYexUKnfpYAtcWpNLSiOfk69+ozJBcWSu7c69WZLxZW9Qqmd0LylHH9CoBpHB
 +5g/Kk90orDnk+kC2JAVMU07li/pg9biu3yQW5LDwbZ1Cz4+6H1bfBoqWYL1ju1RmEn2
 5XtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/8G2iKu3I0B4lwA7+iII1NHRvNW0Zv+RsyYQAuR9fmdktUDNyYrOv27G4enoFxnFOUaQBQb+W8D5iF12ntZoQWaULwg==
X-Gm-Message-State: AOJu0YzbPP0RhEcsRH2rQe7ji/wIEFOTHaW9MySJoztdMaMpoGTdylHe
 4PKKfe1Mkr+ojqJvn+QKry7Vn5XKrzh4iRKMdTKKHEM7jsJPsvNaz/4ihrEndjg=
X-Google-Smtp-Source: AGHT+IHqXO4Pk6vfC3NCtspYoSTTzBasoJeA3gQeA9Hdl+SxFcPF9XcXmvbam+W4UcCfADGIqJYBAQ==
X-Received: by 2002:a17:906:3c04:b0:a6f:81b:9639 with SMTP id
 a640c23a62f3a-a6f081bd1d1mr342598966b.26.1718012731292; 
 Mon, 10 Jun 2024 02:45:31 -0700 (PDT)
Received: from localhost ([2a04:cec2:b:49d2:7655:6cc3:de57:63b7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c806eaa1dsm625292266b.107.2024.06.10.02.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:45:30 -0700 (PDT)
From: Julien Masson <jmasson@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Dmitrii Merkurev <dimorinny@google.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Cody Schuffelen
 <schuffelen@google.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] cmd: bcb: Fix bcb compilation when CONFIG_CMD_BCB=n
In-Reply-To: <20240603-bcb-compil-v1-1-4edc2c77eed3@baylibre.com>
Date: Mon, 10 Jun 2024 11:45:29 +0200
Message-ID: <87le3di11i.fsf@fedora.mail-host-address-is-not-set>
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


On Mon 10 Jun 2024 at 11:45, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> commit dfeb4f0d7935 ("cmd: bcb: extend BCB C API to allow read/write the fields")
> introduced the bcb_get() function.
> 
> When CONFIG_CMD_BCB=n, that function is stubbed.
> The stubbed function has a wrong prototype: value_size arg is missing.
> 
> Add the missing argument to fix build when CONFIG_CMD_BCB=n.
> 
> Fixes: dfeb4f0d7935 ("cmd: bcb: extend BCB C API to allow read/write the fields")
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/bcb.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/bcb.h b/include/bcb.h
> index 1941d8c28b4f..a56b547595a6 100644
> --- a/include/bcb.h
> +++ b/include/bcb.h
> @@ -58,7 +58,8 @@ static inline int bcb_set(enum bcb_field field, const char *value)
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline int bcb_get(enum bcb_field field, char *value_out)
> +static inline int bcb_get(enum bcb_field field,
> +			  char *value_out, size_t value_size)
>  {
>  	return -EOPNOTSUPP;
>  }
> 
> ---
> base-commit: ea722aa5eb33740ae77e8816aeb72b385e621cd0
> change-id: 20240603-bcb-compil-d8eaf7074475
> 
> Best regards,
> -- 
> Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
> 

Reviewed-by: Julien Masson <jmasson@baylibre.com>
-- 
Julien Masson
