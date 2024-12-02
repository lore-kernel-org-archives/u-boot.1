Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351AFE69E86
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 19:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06F1589492;
	Mon,  2 Dec 2024 20:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733167421;
	bh=9uw7b6BtxkXWjHAEcYaTil/VZDIPkTZUQ03dy4i9xUs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HPuBwyKh4000jRHBNQS2WasUpErcZt7DHocjtXUN641jxEGAMoRMYT7fYuoTbmyZd
	 2DR3p74SPfrKpeTWYkQQyLPFmOQCoEilU3Y8wmkwFLCB40M109kCksH5s8RkUIyn+X
	 5y/WXUReFh7ot16zWYt038aBNcUPnzTa/CW3FBX65lnSao7oABLxdkX1wcuT4KLftl
	 UL9hg+w0sfkqsWHhjhnA1UT0+2HxaassUAYAyDb6Pc1dtWVzp/8IufF4acqwdwnyjB
	 xnAHipnPo3qSPiVSDI7KVnuiCDGjDEftX5XeOCqrXC9lhkF/PdSG8Op9lS88myZl0F
	 QlM+/l6DwVemA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 89D3389378;
 Mon,  2 Dec 2024 20:23:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1733167419;
 bh=9uw7b6BtxkXWjHAEcYaTil/VZDIPkTZUQ03dy4i9xUs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=yPiBbwtUJFiFtjphd3LDe085AZ93gJQhjB1TLWs6A9DiLWf9F5KTTlqGv5Fts34RB
 ie7K+wFXD3UXlzo0h22k86dKL08YWaOv7H44dRKXcyA0iuuSGRc1RjEwED9d4U3Tl+
 0NcyrITalWZ2LyaT/k7rsWLxGr0Mfst5sao06EaepnnqeXwxAZu7lvtp8BKr0dXY+L
 Zhuc2d85A2/RuxmvLakDdXD4ZgKshcYBa+p9HkJIOV86DMw43OO3nTSAkHmtzG0u7T
 TB6BBRKK2EHuedhfz9SP9DOk8mBAxM88TW+m6Yk1jZ+HDFauomNxP64eS8j0OoJeHA
 ogPcxOfCOOmlQ==
Message-ID: <ec100e70-2943-4885-8070-31273beaad90@denx.de>
Date: Mon, 2 Dec 2024 20:09:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/4] arm64: imx8mp: Read values from M24C32-D
 write-lockable page on DHCOM i.MX8MP
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20241202172950.35460-1-cniedermaier@dh-electronics.com>
 <20241202172950.35460-3-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241202172950.35460-3-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/2/24 6:29 PM, Christoph Niedermaier wrote:
> The new i.MX8M Plus DHCOM rev.200 is populated with M24C32-D EEPROM
> that contains an additional write-lockable page called ID page, which
> is populated with a structure containing ethernet MAC addresses, DH
> item number and DH serial number.
> 
> Because the write-lockable page is not present on rev.100 i.MX8MP DHCOM
> SoM, test whether EEPROM ID page exists by setting up the i2c driver.
> 
> There may be multiple EEPROMs with an ID page on this platform, always
> use the first one. The evaluation of the EEPROM ID page is done in two
> steps. First, the content is read and checked. This is done to cache
> the content of the EEPROM ID page. Second, the content is extracted
> from the EEPROM buffer by requesting it.
> 
> For the ethernet MAC address the i.MX8M Plus DHCOM currently supports
> parsing address from multiple sources in the following priority order:
> 
> 1) U-Boot environment 'ethaddr'/'eth1addr' environment variable
> 2) SoC OTP fuses
> 3) On-SoM EEPROM
> 
> Add support for parsing the content of this new EEPROM ID page and place
> it between 2) and 3) on the priority list. The new entry is 2.5) On-SoM
> EEPROM write-lockable page.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>

Reviewed-by: Marek Vasut <marex@denx.de>
