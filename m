Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBB2D132BB
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 12:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6530388CE7;
	Mon,  4 Nov 2024 13:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T2ssHeal";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E8FD8862E; Mon,  4 Nov 2024 09:46:26 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DB118855C
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 09:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9a2209bd7fso710775166b.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 00:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730709984; x=1731314784; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oSstqte0B7LN4CzSE3iPJ+KLGQcDZY5ndrNEG/7PCcs=;
 b=T2ssHeal/+eOtnyUXVE82oFFv3u1qVx75qzzX7KAISXeeZBv5+Grlb0OqDO7rFFvHk
 KBmVLBBOLxnvlxtwzO+SQWm2NsXo1u3vwiDr5mXCW2FGLEf9SZXpTR65REf3Vcnrndhs
 t1/ksnn/p9GXBO9TPbRhzpRw6YMYlSq14vjYvEGz+DkDJeJWc77y9BG515kOkwWnN5eT
 8LG74lXEnT5HGylcW+WSHXtMk5+i6EIQP/yGucxnAGxSzgY2u5v9tzK7OK9slIitJTVI
 rBbUrQ0SmKvB4LhtvMOpelWK0V0SR34mdqPM6MuPevheaiYjOG19uq25CVFXpirEiF8H
 TElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730709984; x=1731314784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oSstqte0B7LN4CzSE3iPJ+KLGQcDZY5ndrNEG/7PCcs=;
 b=phl//buUB/fmOMo0dYSzsrbObvRxG3lWsHAAZibnq6JyQlIFY0Usw/23hus+poZnZM
 c/8NT5qV9qT1gkXJajQWajCv89Stle3Oy98XKuVORsi09rzFsQFE9+ch017WTTyOMMtI
 SmMMAUodMHfidw8bG5rLchMYPFuq6N/d3/t8netlGT1BQvkQvqtVpIH5/78oe5+KcIGX
 /i/As7pyZvM1i8vJd2hIMAgnfTEGdQ3yrsKJV43uqhhqCMoNIsksW9eX3PRlqNCjju/n
 4mjiJlw5BOuUpxHr0PQgvPz6OW/vPr5o1lKAXZerSkrSnAUA3fQhixpY2Egab1exbjFg
 TsSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKbOjR9kRscQwmZeT4wX3gHh8tdee7KO1iSLTFRYPiKut+54k8bvZyk+7tbu7qF98rv7Ofq2M=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8Qtao+GZq84ds0NGd3OYGEf9YBJd50QqaIowj+5SXbqftlwyL
 SnmttSfxFAn23pZC3HbdPdbRFzzqcbVTgudnixVgtWFody9MZ+S5wI4j9yXPenk=
X-Google-Smtp-Source: AGHT+IFHRAHLe/6dW73HwqaQP7G5Q+hgBON4WIaDqNTdbBXRC0PvSszI2Q9WjmqdJdVIWf/KhYeTWg==
X-Received: by 2002:a17:907:e8b:b0:a9a:714:4399 with SMTP id
 a640c23a62f3a-a9de6167a45mr3081718466b.51.1730709983652; 
 Mon, 04 Nov 2024 00:46:23 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ceac7700dbsm4013646a12.34.2024.11.04.00.46.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 00:46:23 -0800 (PST)
Message-ID: <ae7e731c-2e12-4c7a-84db-147f5e7a9e85@linaro.org>
Date: Mon, 4 Nov 2024 08:46:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Store stacked memories sizes in parameter
 array
To: Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 padmarao.begari@amd.com, git@xilinx.com, jagan@amarulasolutions.com,
 n-francis@ti.com, d-gole@ti.com, mwalle@kernel.org,
 patrice.chotard@foss.st.com, patrick.delaunay@foss.st.com, p.yadav@ti.com,
 quentin.sulz@cherry.de, seanga2@gmail.com, sjg@chromium.org,
 Takahiro.Kuwano@infineon.com, trini@konsulko.com
References: <20241028082723.3842308-1-prasad.kummari@amd.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241028082723.3842308-1-prasad.kummari@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 04 Nov 2024 13:47:00 +0100
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



On 10/28/24 8:27 AM, Prasad Kummari wrote:
> @@ -1155,7 +1155,35 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>  
>  		if (len == mtd->size &&
>  		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
> -			ret = spi_nor_erase_chip(nor);
> +			if (nor->flags & SNOR_F_HAS_STACKED) {
> +
> +				ret = 0; idx = 0;
> +				while (idx < nor->num_flash) {
> +					if (idx == 1) {
> +						nor->spi->flags |= SPI_XFER_U_PAGE;
> +						rc = write_enable(nor);
> +						if (rc < 0)
> +							goto erase_err;

how many levels of indentation do you have here? Please refactor your
code, this is unreadable.
