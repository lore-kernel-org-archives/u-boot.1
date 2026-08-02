Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B81EC55171
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 04:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E3804069A;
	Sun,  2 Aug 2026 04:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aEdEY2LWqWme; Sun,  2 Aug 2026 04:35:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1E89140695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785645326;
	bh=Xex2U89y3lUCzSgu48qS1G6ZfqhRvQlEKX/Wr6KXXrg=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=A/qUVlaqbGRJhM3J81QaK8AVHbiILl+R9gU2hXaz4H2LY61nAGaZeyj/PEIESHhkF
	 /95469WcM0W4oirwOM9yq3OAwoyYuMV5pFsa7QrDT1nRWtvemJINsKhOq4rGyjyefK
	 CUSTCdsZDKZHwTdG5+NIb1cKWbK/HQ2lP4ebkbNrt7NpsIQffFhU8pf3LLhB8AQWO2
	 YaOHe5xlJ9xmQXmw2HfIs5RgWHNLgHYQQhSS+LXACZJ2wy6/S+lAO9k9/n32rBv9Zu
	 PnaXugGPYITyNBooxx/2XRcvhTdBN9c2FOxpK79LqKxq+b45yozIgtlRSjMpb570hC
	 IgNisaQAcDBhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E89140695;
	Sun,  2 Aug 2026 04:35:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 123D723F
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 03:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F84180D7F
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 03:35:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kMj1EzoEzC6N for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 03:35:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0AC9D80D7A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0AC9D80D7A
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0AC9D80D7A
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 03:35:55 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hCQST1D9LzKn8Z;
 Sun, 02 Aug 2026 05:35:53 +0200 (CEST)
Message-ID: <07464dc0-19b8-47df-8276-d1662e534fe4@mailbox.org>
Date: Sun, 2 Aug 2026 05:33:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 03/17] spi: cadence_qspi: Use APB write protection
To: Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Robert Marko <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>,
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, Stanley Chu
 <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Anshul Dalal <anshuld@ti.com>,
 David Lechner <dlechner@baylibre.com>, Daniel Palmer <daniel@thingy.jp>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Phil Edworthy <phil.edworthy@renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Udit Kumar
 <u-kumar1@ti.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
 <20260731-rzn1-2026-07-v1-3-af2ce80db9d8@linaro.org>
Content-Language: en-US
In-Reply-To: <20260731-rzn1-2026-07-v1-3-af2ce80db9d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: drq5bzcuwdeq1uzb14hhh8jtb38x67mm
X-MBO-RS-ID: c286e3628d87dd23cd0
X-Rspamd-Queue-Id: 4hCQST1D9LzKn8Z
X-Mailman-Approved-At: Sun, 02 Aug 2026 04:35:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785641753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xex2U89y3lUCzSgu48qS1G6ZfqhRvQlEKX/Wr6KXXrg=;
 b=Ls4r+ZtC9VXmM14gdvF7e2lYSHX6SsclqXBp4vfvG/sYfe3fKBn3ftBmdi6myAkKbuZctz
 cV2ILVkGNTFVxqyVDjT/nGOO3ql8yMJtU8Mh2FxBKRgUeuJTKUI06oOXeU9qQ8xsTSBive
 ag89PHkTLsQRC+pY7xmzSd/YmZYIEZUqb1DtwkTsQ5pA6qBLJj3fLFUd6xDhcGFP1brA6I
 Wg0C79vOlHjsIpIWK3fppTooiuCuZUj46ccvfDM+wRvv+UDMo+pUxQxJg/D5O+MCTB02m3
 54GxaaXxlTkcWIyscOjIbEwpOiQY1RS9gbM2aghtfXfFHQzmh607wr07eeZ49A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785641750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xex2U89y3lUCzSgu48qS1G6ZfqhRvQlEKX/Wr6KXXrg=;
 b=sDdTVBJibj1VnzkUc9koattHnYkAdU8o0qBkGmn8H7P79IV/ZvFiYagRxDujG2uS2WzL9i
 ae0mSXVDCQcGYKOyuaZ5vSedlzjKpETR3MihpJpJXUuG2L9IiHzRIPUamwuGoi08sKb0j/
 JinDvIY3UgFTGxTcn4NfQj++CPRlEQBx1oWqkfGpRk95SKvsqFJmNciiTjsImGHqsl+HBz
 mVIb7nBWJzO6XXAQWt49khRk1a4W1HptCLwSWBuGI6WwzAnPhk1rQQwzs8dxE2/cK1MF3a
 dWIJq1ycj+QLoM3AVKc6q6TGiB4XRftnZd8kD1pl1rC7F+c0mawh/1O3vyZqrw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Ls4r+ZtC; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=sDdTVBJi
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=sDdTVBJi;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/31/26 6:33 PM, Ralph Siemsen wrote:
> Prevent random memory writes from corrupting flash memory.
> 
> When using the Direct Access Controller (DAC), the QSPI flash appears as
> a memory-mapped device. A stray write within the DAC region can corrupt
> flash contents.
> 
> To prevent this, enable the hardware write protection feature. Due to
> known errata [1] of the QSPI controller, the entire address range is
> protected, and only gets unlocked during intentional QSPI writes.
> 
> [1] https://www.renesas.com/en/document/tcu/qspi-contoller-issue
> 
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
>   drivers/spi/Kconfig            | 11 +++++++++++
>   drivers/spi/cadence_qspi.h     |  6 ++++++
>   drivers/spi/cadence_qspi_apb.c | 27 +++++++++++++++++++++++++++
>   3 files changed, 44 insertions(+)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 007ad5e7733..19f8d48507b 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -168,6 +168,17 @@ config CADENCE_QSPI
>   	  used to access the SPI NOR flash on platforms embedding this
>   	  Cadence IP core.
>   
> +config CADENCE_QSPI_WRITE_PROTECT
> +	bool "Cadence QSPI write protection"
> +	depends on CADENCE_QSPI
> +	help
> +	  Enable hardware write protection in the QSPI controller. Helps avoid
> +	  flash corruption due to stray writes. The direct access region is kept
> +	  locked by default, and only gets unlocked during "sf write".
> +
> +	  This is similar to SYS_FLASH_PROTECTION however blocking is done by
> +	  the controller, rather than by the flash device.
> +
>   config HAS_CQSPI_REF_CLK
>   	bool "Cadence QSPI static reference clock"
>   	depends on CADENCE_QSPI
> diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
> index 1e9081c2d17..6b3ed46977a 100644
> --- a/drivers/spi/cadence_qspi.h
> +++ b/drivers/spi/cadence_qspi.h
> @@ -119,6 +119,12 @@
>   #define CQSPI_REG_IRQSTATUS                     0x40
>   #define CQSPI_REG_IRQMASK                       0x44
>   
> +#define CQSPI_REG_LOWER_WRITE_PROTECT           0x50
> +#define CQSPI_REG_UPPER_WRITE_PROTECT           0x54
> +
> +#define CQSPI_REG_WRITE_PROTECT_CTRL            0x58
> +#define CQSPI_REG_WRPROT_ENABLE                 BIT(1)
> +
>   #define CQSPI_REG_INDIRECTRD                    0x60
>   #define CQSPI_REG_INDIRECTRD_START              BIT(0)
>   #define CQSPI_REG_INDIRECTRD_CANCEL             BIT(1)
> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
> index 0d4bc685f5d..353b57a46af 100644
> --- a/drivers/spi/cadence_qspi_apb.c
> +++ b/drivers/spi/cadence_qspi_apb.c
> @@ -325,6 +325,17 @@ void cadence_qspi_apb_delay(void *reg_base,
>   	cadence_qspi_apb_controller_enable(reg_base);
>   }
>   
> +static void cadence_qspi_apb_write_protect_enable(void *reg_base)
> +{
> +	writel(CQSPI_REG_WRPROT_ENABLE,
> +	       reg_base + CQSPI_REG_WRITE_PROTECT_CTRL);
> +}
> +
> +static void cadence_qspi_apb_write_protect_disable(void *reg_base)
> +{
> +	writel(0, reg_base + CQSPI_REG_WRITE_PROTECT_CTRL);
> +}
> +
>   void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv)
>   {
>   	unsigned reg;
> @@ -346,6 +357,18 @@ void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv)
>   	/* Indirect mode configurations */
>   	writel(priv->fifo_depth / 2, priv->regbase + CQSPI_REG_SRAMPARTITION);
>   
> +	if (IS_ENABLED(CONFIG_CADENCE_QSPI_WRITE_PROTECT)) {
> +		/*
> +		 * Enable AHB write protection, to reduce the chance of corrupting
> +		 * flash memory due to a stray write within the DAC region.
> +		 * Protect the entire address range, regardless of the flash size.
> +		 * During "sf write" the protection will be temporarily disabled.
> +		 */
> +		writel(0, priv->regbase + CQSPI_REG_LOWER_WRITE_PROTECT);
> +		writel(~0, priv->regbase + CQSPI_REG_UPPER_WRITE_PROTECT);
> +		cadence_qspi_apb_write_protect_enable(priv->regbase);
> +	}
> +
>   	/* Disable all interrupts */
>   	writel(0, priv->regbase + CQSPI_REG_IRQMASK);
>   
> @@ -955,7 +978,11 @@ int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
>   	 */
>   	cadence_qspi_apb_enable_linear_mode(true);
>   	if (!priv->dtr && priv->use_dac_mode && (to + len < priv->ahbsize)) {
> +		if (IS_ENABLED(CONFIG_CADENCE_QSPI_WRITE_PROTECT))
> +			cadence_qspi_apb_write_protect_disable(priv->regbase);
>   		memcpy_toio(priv->ahbbase + to, buf, len);
> +		if (IS_ENABLED(CONFIG_CADENCE_QSPI_WRITE_PROTECT))
> +			cadence_qspi_apb_write_protect_enable(priv->regbase);

Wrap the if (IS_ENABLED()) into 
cadence_qspi_apb_write_protect_enable()/disable() and simply do

if (!IS_ENABLED()) return 0;

in there.

Also, maybe fold the two functions into a single one 
cadence_qspi_apb_write_protect(..., bool enable);
