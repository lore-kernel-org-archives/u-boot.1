Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AD2E77180
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 12:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1298889494;
	Tue, 10 Dec 2024 13:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xxWq0L/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 114C688F41; Tue, 10 Dec 2024 12:37:04 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E355588F41
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 12:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9a68480164so778797066b.3
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 03:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733830621; x=1734435421; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MbdIDjHFBo+Vmazs5XSWzAjMFBDPf1XrmWrYS3FnVZI=;
 b=xxWq0L/8AybE3HouCS48o7kaYOvCmuvz2ew9S/39mDPataIeR5jrCJIfkVC/jOuM+g
 AjOB0/eBqIfL2GEQtDG0aNoH0jc8cLQnmzRBk2Nibt6R7UyMMt4ASgg4zNS8nmq+Bw32
 5QepnBJJ7WFs3V8XbZgldy6sCwiDiQzwMkY0N8dfRN2m9i0c+R3sLZIwRZSwzajvMaEE
 Bsx2ClEr2HQTeb1mTT27tIKIN6TRtKfqSZYIbM9U6CPQ5pfywgaEiz9Toh1O2koi/lsj
 hA46SoHBQ3AJalHzK0bm77d08f1dece9Q2XOIP/Qs4ytmb+cgRcUUh9QGkyg7O5Nm64m
 cB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733830621; x=1734435421;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MbdIDjHFBo+Vmazs5XSWzAjMFBDPf1XrmWrYS3FnVZI=;
 b=uRO6PPAzFXE5jH1917qbjG/9IOepXhLRw3tBTbA5SpyLSBozuv16B6xvS91XxhPMb0
 ltLaQMYzyv9dZTjHAaxBbEZM4ZkaUphgsfd3FyPGpXexBzH5mq91XEi05NcY9XokM7qy
 rQ8qhctpwD9wBL//CdadHTbW9VERo5DHmFcq8bKu6eRu/tqFvflVEZaPD8CwazG/eg1S
 ev36htzS1IclKU1L8Gf1Z9owX08OmEwj1+GqE3LbWKUqmhJCt4R4ONbgrBcHTwOnzVwi
 J10i4hhWOhP+IoQNeT8/35HbXux7siJjGn/2z5zTPh43bu4mPMO7kd4iUxLklnIzTFur
 r7bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkX0n+14O3ksbHuXeq7qz+gnj3FQWsi1Bqq0C8bz1W6DDwB8SRRHJ8q4eTsFcUxCVVJWY/dBU=@lists.denx.de
X-Gm-Message-State: AOJu0YynIS8JJx8EJz6cp4856VmvSTv0q/A+Pi3XawaLSYk7+OuIwDNq
 1rvBjd7SaCbO1AJ1ouijNAENYBxQIsfzdNH8QYYZYQd6+RFYmo5t52AGhh37gvA=
X-Gm-Gg: ASbGncudDw13/wy5uCQmlyYwMj5Jqd5xQhBiT1mkfYtL0gF04hDTc0x486YnuJKcRa/
 vzuYjFc6BKrVaF0PZGRZCwqtkwtiwIQcJ2+8RD/umF0QsLAipOU7r3rA/AwZrwolMYTcoA1gmmS
 Xq3w6EOPSkdeWJZhB98IXHqvHnNC463869j3DEf+NvfgNS5fWMVnNX5/eqmFpC0kQdhO69woEOs
 1/vXw3BlW4LMYDDDo4BSlU1qJwnuQZcatqHzt+uPdvJoI1L9wr/vq8YyfXP6g==
X-Google-Smtp-Source: AGHT+IGSkGAsUGQ/UtYKIT08e22va7Xz08q5s8CuIr9IjJOOyO/DpcXLfcQHF+9+OGnG0I+ciZ6FVg==
X-Received: by 2002:a17:906:2191:b0:aa5:43c4:da78 with SMTP id
 a640c23a62f3a-aa63a24bf41mr1446100766b.51.1733830621306; 
 Tue, 10 Dec 2024 03:37:01 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.27])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67770d264sm404065566b.64.2024.12.10.03.36.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 03:37:00 -0800 (PST)
Message-ID: <ae4d6b8c-8a3d-4a9a-88a0-67c1727ff06f@linaro.org>
Date: Tue, 10 Dec 2024 11:36:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel memories support
 in QSPI driver"
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut@mailbox.org>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Jon Humphreys <j-humphreys@ti.com>, "Simek, Michal"
 <michal.simek@amd.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Michael Walle <mwalle@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 "uboot-stm32@st-md-mailman.stormreply.com"
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <edcec18f-75a0-44d8-907a-f042779ca6ee@mailbox.org>
 <86ses458k3.fsf@udb0321960.dhcp.ti.com>
 <f7bb335d-681a-4b60-92f6-b605cc6f477f@mailbox.org>
 <86pln759j9.fsf@udb0321960.dhcp.ti.com>
 <33e99705-77e3-4acf-95f7-fad65f60ae62@mailbox.org>
 <86ldxp6ehf.fsf@udb0321960.dhcp.ti.com>
 <865xny69y1.fsf@udb0321960.dhcp.ti.com>
 <SA1PR12MB86974AC7EFCCBD7AE99FDD3E98302@SA1PR12MB8697.namprd12.prod.outlook.com>
 <8634j15t1y.fsf@udb0321960.dhcp.ti.com>
 <SA1PR12MB869743652A0B3EC3335A9F9F98312@SA1PR12MB8697.namprd12.prod.outlook.com>
 <20241206163931.GS2457179@bill-the-cat>
 <SA1PR12MB86977B7233CE821D113F369C983D2@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <SA1PR12MB86977B7233CE821D113F369C983D2@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 10 Dec 2024 13:51:03 +0100
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



On 12/10/24 3:20 AM, Abbarapu, Venkatesh wrote:
> Tudor, Do you want me to implement separate 
> spi_nor_erase()/spi_nor_read()/spi_nor_write() for the parallel/stacked 
> configurations?

I lean towards it, it will spare maintainers and contributors of dealing
with this temporary situation. The core will look like before the
stacked/parallel support.

You'll have to introduce nor->erase(), nor->read(), nor->write(), define
your stacked/parallel methods in a dedicated file and set those function
pointers with what you need.

If Marek/Jagan finds the idea fine, go for it. I limit myself just to an
advisory role here.
