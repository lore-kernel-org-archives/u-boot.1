Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E68CCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 17:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BCC4838CC;
	Sun,  2 Nov 2025 18:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ark3slg7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BE9183642; Sun,  2 Nov 2025 13:45:35 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 361718307F
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 13:45:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7aab061e7cbso251549b3a.1
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 04:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762087532; x=1762692332; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F4v3TQVnzy8Ktu4Bxb50uZjRNDWDDT+bWt+t0aaXuHI=;
 b=Ark3slg748F4JfTaMNquwAZyDt1n+i3ehl7VW0HPsB6FaxCFixC7hDL1sOFG+M5zXR
 AXvBpAaoze2qfMRCPTnOS7HkrDNAfXOiBaTEabGBpAAA2wD9NHlg0HPLUxRPPpGJTFkt
 ynk1k2eD9EzzSMIua6B9xfUhHXnVjRNJuBm8Ao/uLMXzaIsLGMLAtD1temZEV4GbkWm7
 ZADBJtAd/epvWJ5TsTNGhvlQrmQJ/ce6VDcLRJEMPf0fq1HXEtexqtYW/yc1rAZ8STq5
 eAhNggTKKeoMMCNCPR4DMeTGy/TNo3+ntiqC8K6vt5JbGZGoVg2ZDEdeQmyQrmrPdpeg
 rhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762087532; x=1762692332;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F4v3TQVnzy8Ktu4Bxb50uZjRNDWDDT+bWt+t0aaXuHI=;
 b=JG3ooDww5+2KTNioToqQJwGhMk5JYr5leMfVwRiY2eUwSMMwkPDJ4otGkP0CKixE5G
 AVN+iovV9OwYMjIRyBEahGbTjeG9KkvKXTwr554OnuAWWfCvCJF3NB8y8ixfX/T1Pz0k
 RnJ2ELC68Tu9YPMUZSmYyvtFFQuGfQbrhdAbMpADCK4Lm6LqMIhGDKY/yvjXTJUTzfnr
 rQsbbjYrhFqhrgy/9vewWTs0B1jlAwo4oOP25DOMdhqZ0oXy05m3H+Oaf/9yVXgrvkYz
 EEKyXGbpwKFtsqKJbT5QfD51MwhTByZsooBKAunojF748dOLLDyYokfcmG1imD/PR2iE
 3qIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcuI9BTMVlJzLNwlOwZaPYJCj5hBuu4TuovhhX/ipewGTfVilo12aoYi3Thzou+ItIQwk2Mm4=@lists.denx.de
X-Gm-Message-State: AOJu0YzbocAnqAZSjFxQ9doj8+oo3aF/2RJ84rWAOb30dobPBg00BzGp
 JrEN6zDsQqbYixkXqTHf9Ka6SQ0auM61F2BA4Lx7Q4wMlCsP3V94Z2yV
X-Gm-Gg: ASbGncu9UAdYwBJyVBDzRURavVm7FNkr+Ng1hQ448eToANbuU8Hb9xhGl8nq424KEiw
 0prpoUOPKoLUUG550XHdxXOPS7iFOb9RbsDFT/Fn0dyWdgzKOO/P0vfINlKgUcsa52JG1lqCALL
 7Pi2U7UlLSdmSeyKk5i0TzS24RBud5iE6aAUiJjnWkGaO6jCoU5vWIz4BezhPOG8DGWNbzTJ3hm
 BbSDoNFVtfqKbqiGFq1xjhUKIwu1KgJtqBaLGi1+vHmZbPO/l1TTu+FMkmgAxOWf5TQC880Awqe
 O3ICUkuEiGHOn2HUsAIJqV1XJ9+WcvOSf12DAShLH4MqF3SN884ABAN/Q83ys/7VKtAlJSH820m
 Mk2uyHINnd+JWOaP9dDa7lOZwmEnxNvp/+2U9c2BcZzt2ww3lPGnxTVIYP1gtGaJpTCuGaGkGEl
 oLJcMbfUakuqB8XQTbMKtt8fy2Ove268wEK9gguQJxHrwJoXB5iZiRYaajnC06O/eWfO9Z+QM=
X-Google-Smtp-Source: AGHT+IEeb3/VBEdaqUpemlx6BRupHBltWZgPmjv0fQvUiZ9gbMOlyN+8OZVa0y1a6rLNXJXiXPbntw==
X-Received: by 2002:a05:6a00:4b4c:b0:7a2:84df:23dc with SMTP id
 d2e1a72fcca58-7a7796bdb73mr13076498b3a.28.1762087531495; 
 Sun, 02 Nov 2025 04:45:31 -0800 (PST)
Received: from [192.168.0.3] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a7db28d3fbsm8001092b3a.43.2025.11.02.04.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Nov 2025 04:45:31 -0800 (PST)
Message-ID: <81e9ad4f-2d21-42b1-99c2-05c184ab472d@gmail.com>
Date: Sun, 2 Nov 2025 20:45:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot, v2, 1/1]net: phy: add paged PHY register accessors
To: jerome.forissier@linaro.org, skylake.huang@mediatek.com,
 s-vadapalli@ti.com, paul.barker.ct@bp.renesas.com,
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org
References: <20251006124915.13647-1-lucienzx159@gmail.com>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <20251006124915.13647-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Nov 2025 18:18:08 +0100
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

Hi

This is a gentle reminder for review of this patch.

Please let me know if there's any issue with the patch

Thank you

Lucien.Jheng 於 2025/10/6 下午 08:49 寫道:
> Synchronize paged PHY helpers with Linux v6.17.
>
> Add support for PHY devices that use paged register access by
> implementing the following functions:
> - phy_save_page(): Save current page number
> - phy_select_page(): Switch to a specific page and return previous page
> - phy_restore_page(): Restore previously saved page
>
> Also adds read_page and write_page callbacks to the phy_driver
> structure to enable driver-specific page handling.
>
> These helpers allow safe access to paged PHY registers by ensuring
> proper page selection and restoration,
> even in error conditions, which will be used by the Airoha PHY driver.
>
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
> ---
> Change in PATCH v2:
>   * Change the commit message from "Synchronize paged PHY helpers
>     with Linux v4.16" to "Linux v6.17."
>   * Remove unnecessary commit information.
>
> I have verified the patch by loading Airoha PHY firmware on Banana Pi BPI-R3 Mini.
> Since we need to switch pages to access en8811h PHY registers, this patch is necessary
> for initializing the PHY and loading the firmware correctly.
>
> 1. Implementation in air_en8811.c:
> ````air_en8811.c````
> /*
>   * Driver for Airoha EN8811H Ethernet PHY
>   */
> #define AIR_EXT_PAGE_ACCESS		0x1f
> ...
> ...
> static int en8811h_read_page(struct phy_device *phydev)
> {
> 	return phy_read(phydev, MDIO_DEVAD_NONE, AIR_EXT_PAGE_ACCESS);
> }
>
> static int en8811h_write_page(struct phy_device *phydev, int page)
> {
> 	return phy_write(phydev, MDIO_DEVAD_NONE, AIR_EXT_PAGE_ACCESS, page);
> }
>
> U_BOOT_PHY_DRIVER(en8811h) = {
> 	.name = "Airoha EN8811H",
> 	.uid = EN8811H_PHY_ID,
> 	.mask = 0x0ffffff0,
> 	.config = &en8811h_config,
> 	.probe = &en8811h_probe,
> 	.read_page = &en8811h_read_page,
> 	.write_page = &en8811h_write_page,
> 	.startup = &en8811h_startup,
> 	.shutdown = &genphy_shutdown,
> };
> ```````End of air_en8811.c`````
> 2. Test log:
> ````Test Log````
> Net:   16384 bytes read in 1 ms (15.6 MiB/s)
> 131072 bytes read in 9 ms (13.9 MiB/s)
> addr: 0x46000000, size: 0x24000
> Found Airoha Firmware.
> MD32 firmware version: 24112802
> ````End of Test Log````
>
>   drivers/net/phy/phy.c | 113 ++++++++++++++++++++++++++++++++++++++++++
>   include/phy.h         |   8 +++
>   2 files changed, 121 insertions(+)
>
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 9702d042296..b58283fe3d5 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1250,3 +1250,116 @@ bool phy_interface_is_ncsi(void)
>   	return 0;
>   #endif
>   }
> +
> +/**
> + * __phy_read_page() - read the current page
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns page index or < 0 on error
> + */
> +static int __phy_read_page(struct phy_device *phydev)
> +{
> +	struct phy_driver *drv = phydev->drv;
> +
> +	if (!drv->read_page) {
> +		debug("read_page callback not available, PHY driver not loaded?\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return drv->read_page(phydev);
> +}
> +
> +/**
> + * __phy_write_page() - Write a new page
> + * @phydev: a pointer to a &struct phy_device
> + * @page: page index to select
> + *
> + * Returns 0 or < 0 on error.
> + */
> +static int __phy_write_page(struct phy_device *phydev, int page)
> +{
> +	struct phy_driver *drv = phydev->drv;
> +
> +	if (!drv->write_page) {
> +		debug("write_page callback not available, PHY driver not loaded?\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return drv->write_page(phydev, page);
> +}
> +
> +/**
> + * phy_save_page() - save the current page
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Return the current page number. On error,
> + * returns a negative errno. phy_restore_page() must always be called
> + * after this, irrespective of success or failure of this call.
> + */
> +int phy_save_page(struct phy_device *phydev)
> +{
> +	return __phy_read_page(phydev);
> +}
> +
> +/**
> + * phy_select_page - Switch to a PHY page and return the previous page
> + * @phydev: a pointer to a &struct phy_device
> + * @page: desired page
> + *
> + * NOTE: Save the current PHY page, and set the current page.
> + * On error, returns a negative errno, otherwise returns the previous page number.
> + * phy_restore_page() must always be called after this, irrespective
> + * of success or failure of this call.
> + */
> +int phy_select_page(struct phy_device *phydev, int page)
> +{
> +	int ret, oldpage;
> +
> +	oldpage = ret = phy_save_page(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (oldpage != page) {
> +		ret = __phy_write_page(phydev, page);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return oldpage;
> +}
> +
> +/**
> + * phy_restore_page - Restore a previously saved page and propagate status
> + * @phydev: a pointer to a &struct phy_device
> + * @oldpage: the old page, return value from phy_save_page() or phy_select_page()
> + * @ret: operation's return code
> + *
> + * Restoring @oldpage if it is a valid page.
> + * This function propagates the earliest error code from the group of
> + * operations.
> + *
> + * Returns:
> + *   @oldpage if it was a negative value, otherwise
> + *   @ret if it was a negative errno value, otherwise
> + *   phy_write_page()'s negative value if it were in error, otherwise
> + *   @ret.
> + */
> +int phy_restore_page(struct phy_device *phydev, int oldpage, int ret)
> +{
> +	int r;
> +
> +	if (oldpage >= 0) {
> +		r = __phy_write_page(phydev, oldpage);
> +
> +		/* Propagate the operation return code if the page write
> +		 * was successful.
> +		 */
> +		if (ret >= 0 && r < 0)
> +			ret = r;
> +	} else {
> +		/* Propagate the phy page selection error code */
> +		ret = oldpage;
> +	}
> +
> +	return ret;
> +}
> \ No newline at end of file
> diff --git a/include/phy.h b/include/phy.h
> index 36354aaf774..ae9fd1652cc 100644
> --- a/include/phy.h
> +++ b/include/phy.h
> @@ -123,6 +123,11 @@ struct phy_driver {
>   	int (*write_mmd)(struct phy_device *phydev, int devad, int reg,
>   			 u16 val);
>
> +	/** @read_page: Return the current PHY register page number */
> +	int (*read_page)(struct phy_device *phydev);
> +	/** @write_page: Set the current PHY register page number */
> +	int (*write_page)(struct phy_device *phydev, int page);
> +
>   	/* driver private data */
>   	ulong data;
>   };
> @@ -314,6 +319,9 @@ int phy_modify_mmd_changed(struct phy_device *phydev, int devad, u32 regnum,
>   			   u16 mask, u16 set);
>   int phy_modify_mmd(struct phy_device *phydev, int devad, u32 regnum,
>   		   u16 mask, u16 set);
> +int phy_save_page(struct phy_device *phydev);
> +int phy_select_page(struct phy_device *phydev, int page);
> +int phy_restore_page(struct phy_device *phydev, int oldpage, int ret);
>
>   int phy_startup(struct phy_device *phydev);
>   int phy_config(struct phy_device *phydev);
> --
> 2.34.1
>
