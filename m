Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471F7D58D40
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 13:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75DAF89A31;
	Mon, 25 Nov 2024 14:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iSK4RHMh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A64289642; Mon, 25 Nov 2024 08:41:05 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60C388963C
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 08:41:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4349e4e252dso7201305e9.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 23:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732520463; x=1733125263; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KJzRMNxwAasJBMFXGI/VcLXqXAVT16IvpUOD6PKMR54=;
 b=iSK4RHMhVeeEO5Dy9ER6gKK0RzL5lCEtkEQp+ezeJTSIUxofDRzMZaFUI8UBqCrPIx
 e3yZaOhEYvLymn4tDbBx6KqvgybyZkZhRphAd9r2Xnw3/ImP/rL75qbChBF4J9Hd8W6Y
 bvI9mpSCrCUoIXwExRI2vu2sYu5Ww8Xb+jMrQD9K8fFuRP1stJScZVfM61bxYhyZgcKD
 CRu03bLECI1GZEMGoqrRCvlYvwcThHW66NGTDiVeB4vtx8q4UKeUZa8MX+aiM52kWfIz
 vToCa9+QvuhphNtDaw/q0MhNliatZbBoZYPfMUELJa+65dy8BajbY0sytp0tZt1nl8CA
 GKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732520463; x=1733125263;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KJzRMNxwAasJBMFXGI/VcLXqXAVT16IvpUOD6PKMR54=;
 b=OBz8kSKdrnrqalE1L49LDEP8cQZDJ0eTc6SAV7Sp86Pxnaiv0ANoIYx2VjlkZiRyPS
 aOvXQpoiJSfVkFWgfuFB9xM+cBEOGxlW7MEe6jPbTBQZ1+R3S2hJgHKwW0bFfvXpLmpS
 qqOC+1Qg+C8ZGZ8rirDsPE3wTUwBnLnMMnsDL+ERwS3Iif5cAnSjZrUe198Afsw62yy9
 3VQYfGDFXK8+jS8f47vM6Liwd7TttRX0R8Cjl8IYZ9Zo5EQSAbH5QuLmRV6jsa2y+oLF
 /HR+K2d/3m9LfzN70bjiVbuQDJX+crFMuIVyNOynINGfB8deF/xxnn+NYNVFaM6twvDe
 hTCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW/g+voC9D7Vx17Y7Hy7e8Dykp3fMa6wsa8YkC+wkGWLrPTVv0HnDmC0B6Jg3vVbigGaFXQ94=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+t7lOGuUYtX3sj83LcUxk8lmB7Ro/a8jPrI2oXiDhcefdhAoI
 bcqykdUss60BMVjGuGJBvxJ1R48OkbsQ4gCRXqOF51tokAXCU2Ev2JJAs7yHA2E=
X-Gm-Gg: ASbGncs/MTMXHmBlZDDLsakxZjjOPKu3nHzIkgVBTB8R704ez2yYfHk+Fa3uQ00nBSO
 JBNGjYTPm2NPopy9BQ0uWyUMqeoKagSrKh70bTtL/BtAGiCo+bwBa9Muthjl4W59GUQQFXRM7Jk
 xxbJZi65yLtkO3m7YhmnhMYe58Znc4npXKMeUZrUYUgqJZOX2pcIFCUowC/jkR5zKP/9rLrRrZC
 RfGIEAnL00CL9AYq8/oMURAxVTRFk85KUtE1LtIO8NP+X0CgrKQ56D9pg==
X-Google-Smtp-Source: AGHT+IHfuERdiWlxG9w1Q6yCc0eBIVZoWqT0ImeFOlZLaGTijBVm5POI8nq6UY4xPoh8URmPjk+TZw==
X-Received: by 2002:a5d:5846:0:b0:385:bd85:59ab with SMTP id
 ffacd0b85a97d-385bd8559e5mr154003f8f.9.1732520462868; 
 Sun, 24 Nov 2024 23:41:02 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b464320csm181277665e9.38.2024.11.24.23.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Nov 2024 23:41:01 -0800 (PST)
Message-ID: <a3b87e0b-b908-446f-a9c2-e5e5af7e88c2@linaro.org>
Date: Mon, 25 Nov 2024 07:40:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx
 flashes
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, j-humphreys@ti.com
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 u-kumar1@ti.com, trini@konsulko.com, seanga2@gmail.com,
 caleb.connolly@linaro.org, sjg@chromium.org, william.zhang@broadcom.com,
 stefan_b@posteo.net, quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com,
 git@amd.com, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
References: <20241122092619.1376234-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241122092619.1376234-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 25 Nov 2024 14:06:45 +0100
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



On 11/22/24 9:26 AM, Venkatesh Yadav Abbarapu wrote:
> Enable mt35xu512aba_fixups for all mt35 series flashes to work
> in DTR mode, and return after nor->fixups is updated, otherwise
> it will get overwritten with macronix_octal_fixups.
> This flash works in DTR mode only if CONFIG_SPI_FLASH_MT35XU
> is enabled and SPI_NOR_OCTAL_DTR_READ flag is set in id table.
> 
> Additionally, a new flag, "SPI_XFER_SET_DDR", has been introduced
> to instruct the OSPI controller driver to switch to DDR mode.

Can you use the dtr fields from `struct spi_mem_op` instead?
