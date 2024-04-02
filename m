Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDB5CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 10:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A1E880E5;
	Tue,  2 Apr 2024 12:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dNKuPPPX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ABF58837D; Tue,  2 Apr 2024 12:07:45 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79ADA879F3
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 12:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56df41365c8so303696a12.2
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712052463; x=1712657263; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n8KNYEYzDnSbZLoeP+uaIJtHe3nWjwW3XqljeStN6NQ=;
 b=dNKuPPPXYVOPQpt0uoiZpMmLpkEwCo1Y5V7Kqm/TZNCjVwQ72meA8FbmV4pvlAI+/p
 Dn5oUdjWkInZTwty2BcXbk7a11UPX6FqRO3hg1qgUEcZyyX7M0x3909g9xrSbE5hcjVv
 KqGnY5CJAMIpLHTuBoxZbtDhUMmLxZ/N4ZNfok69ztu81c4K6LvwvGXHBdSdh86WHSNW
 qVz8adPXQm2hRUoUXTGxuoiRUPKe30TMnzlc7kXE1+oZyjV4cihmo6xNSd05db+k4eeA
 4QNUUjxm3AKBd8ZZNskapEiOzrlrowfO2uk1qkEw3Q8dMMypqlQOIGRVAB79ZFWoTnkq
 /HCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712052463; x=1712657263;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n8KNYEYzDnSbZLoeP+uaIJtHe3nWjwW3XqljeStN6NQ=;
 b=c1UwsspA9eI0YTxgqOV5lEEJsgq46GcxqdqV5xrM6Ld1IqWOYdGMJ+y6Lzj9V++xFO
 0YGgEeFptsDvOjUuERkOrcRMXJ38iBZFJJLcjeLFMe/qUgZqYCmlT9gWQy0af5prig/U
 QbWqxBHr364wyRMAden9ItXqzc65sQLl9FyZuSSVJHZ1JwqdvmELoU9XBkQm7MOn9h7R
 NqBPvJVk41QFQIK0vkP11GlF4Dye9pPRYPRKDUguEd03Os1HvUIV9devDJ10eeqBB22l
 KcsWcrmAU7IHM0lIQxkRvER+00BP6AGhoSMEC1r8F6iMNoufIXbBZA80ZR4jH7mYehv4
 lcJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWkFEHZ67EHlBKzzPxTwRg7QQKPrwKKUskEhxYRhi7Aq2948qv61hyn/sfl/B9NOOE3geG0W0QdoMAB4zCL79WNfTytQ==
X-Gm-Message-State: AOJu0Yz1rwFrL7+e12YRREMEegpVEFnHVmAlWyKiDTd9mdPq01/K0j/N
 +WGLJANCZ4vTsx3/12jkqcFK1oZ/1Sif1SWn+lAXVeFXp+9f+crHCpfbwIcUKJ4=
X-Google-Smtp-Source: AGHT+IFT2EvGk4+cHRQ1mGX0/k7exaAkrji2wamtYe/U4LndkaZwJ0RyfG0tYgj+19Hhb/JnXdeaPw==
X-Received: by 2002:a17:906:5ada:b0:a47:4efb:b0f5 with SMTP id
 x26-20020a1709065ada00b00a474efbb0f5mr7683470ejs.67.1712052462912; 
 Tue, 02 Apr 2024 03:07:42 -0700 (PDT)
Received: from [192.168.1.23] (i5E863A89.versanet.de. [94.134.58.137])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a170906581000b00a4a3807929esm6308510ejq.119.2024.04.02.03.07.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 03:07:42 -0700 (PDT)
Message-ID: <e1ce6d8f-20f5-47af-84a3-d100f96c1b31@linaro.org>
Date: Tue, 2 Apr 2024 12:07:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/16] phy: qcom: Add SNPS femto v2 USB HS phy
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Bhupesh Sharma <bhupesh.linux@gmail.com>
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
 <20240328-b4-qcom-livetree-v5-3-4e98228b3d03@linaro.org>
 <CAFA6WYO=_2NQckqt11b81GPZXGE13Uw9hCkO6S+F6b3ve2nDBA@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYO=_2NQckqt11b81GPZXGE13Uw9hCkO6S+F6b3ve2nDBA@mail.gmail.com>
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

Hi Sumit,

On 01/04/2024 06:46, Sumit Garg wrote:
> On Thu, 28 Mar 2024 at 23:29, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> From: Bhupesh Sharma <bhupesh.linux@gmail.com>
>>
>> Some Qualcomm SoCs newer than SDM845 feature a so-called "7nm phy"
>> driver, notable the SM8250 SoC which will gain U-Boot support in
>> upcoming patches.
>>
>> Introduce a driver based on the Linux driver.
>>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> [code cleanup, align symbol names with Linux, switch to clk/reset_bulk APIs]
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   drivers/phy/qcom/Kconfig                  |   8 ++
>>   drivers/phy/qcom/Makefile                 |   1 +
>>   drivers/phy/qcom/phy-qcom-snps-femto-v2.c | 207 ++++++++++++++++++++++++++++++
>>   3 files changed, 216 insertions(+)
>>
...
>> diff --git a/drivers/phy/qcom/phy-qcom-snps-femto-v2.c b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
>> new file mode 100644
>> index 000000000000..58eb01972402
>> --- /dev/null
>> +++ b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
...
>> +static inline void qcom_snps_hsphy_write_mask(void __iomem *base, u32 offset,
>> +                                             u32 mask, u32 val)
>> +{
>> +       u32 reg;
>> +
>> +       reg = readl_relaxed(base + offset);
>> +
>> +       reg &= ~mask;
>> +       reg |= val & mask;
>> +       writel_relaxed(reg, base + offset);
>> +
>> +       /* Ensure above write is completed */
>> +       readl_relaxed(base + offset);
> 
> It looks like you have missed addressing comments related to this API.
> Again, why do we need this special handling in U-Boot? Why not just
> clrsetbits_le32()?

I have tried to find more info about this, but from what I can tell it's 
important (my guess is that it's a weird bus arbitration thing with the 
QMP phy's).

If I replace this with clrsetbits_le32() then my SM8250 board crashdumps 
while probing USB. So it is needed (and I'm wondering now if I ought to 
switch back to this for the dwc3 qcom glue as well).
> 
> -Sumit
> 
>> +}
>> +
>> +static int qcom_snps_hsphy_usb_init(struct phy *phy)
>> +{
>> +       struct qcom_snps_hsphy *priv = dev_get_priv(phy->dev);
>> +
>> +       qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_CFG0,
>> +                                  UTMI_PHY_CMN_CTRL_OVERRIDE_EN,
>> +                                  UTMI_PHY_CMN_CTRL_OVERRIDE_EN);
>> +       qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_UTMI_CTRL5, POR,
>> +                                  POR);
>> +       qcom_snps_hsphy_write_mask(priv->base,
>> +                                  USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON0, FSEL_MASK, 0);
>> +       qcom_snps_hsphy_write_mask(priv->base,
>> +                                  USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON1,
>> +                                  PLLBTUNE, PLLBTUNE);
>> +       qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_REFCLK_CTRL,
>> +                                  REFCLK_SEL_DEFAULT, REFCLK_SEL_MASK);
>> +       qcom_snps_hsphy_write_mask(priv->base,
>> +                                  USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON1,
>> +                                  VBUSVLDEXTSEL0, VBUSVLDEXTSEL0);
>> +       qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_HS_PHY_CTRL1,
>> +                                  VBUSVLDEXT0, VBUSVLDEXT0);
>> +
>> +       qcom_snps_hsphy_write_mask(priv->base,
>> +                                  USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON2,
>> +                                  VREGBYPASS, VREGBYPASS);
>> +
>> +       qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_HS_PHY_CTRL2,
>> +                                  USB2_SUSPEND_N_SEL | USB2_SUSPEND_N,
>> +                                  USB2_SUSPEND_N_SEL | USB2_SUSPEND_N);
>> +
>> +       qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_UTMI_CTRL0,
>> +                                  SLEEPM, SLEEPM);
>> +
>> +       qcom_snps_hsphy_write_mask(
>> +               priv->base, USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON0, SIDDQ, 0);
>> +
>> +       qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_UTMI_CTRL5, POR,
>> +                                  0);
>> +
>> +       qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_HS_PHY_CTRL2,
>> +                                  USB2_SUSPEND_N_SEL, 0);
>> +
>> +       qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_CFG0,
>> +                                  UTMI_PHY_CMN_CTRL_OVERRIDE_EN, 0);
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_snps_hsphy_power_on(struct phy *phy)
>> +{
>> +       struct qcom_snps_hsphy *priv = dev_get_priv(phy->dev);
>> +       int ret;
>> +
>> +       clk_enable_bulk(&priv->clks);
>> +
>> +       ret = reset_deassert_bulk(&priv->resets);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = qcom_snps_hsphy_usb_init(phy);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_snps_hsphy_power_off(struct phy *phy)
>> +{
>> +       struct qcom_snps_hsphy *priv = dev_get_priv(phy->dev);
>> +
>> +       reset_assert_bulk(&priv->resets);
>> +       clk_disable_bulk(&priv->clks);
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_snps_hsphy_phy_probe(struct udevice *dev)
>> +{
>> +       struct qcom_snps_hsphy *priv = dev_get_priv(dev);
>> +       int ret;
>> +
>> +       priv->base = dev_read_addr_ptr(dev);
>> +       if (IS_ERR(priv->base))
>> +               return PTR_ERR(priv->base);
>> +
>> +       ret = clk_get_bulk(dev, &priv->clks);
>> +       if (ret < 0 && ret != -ENOENT) {
>> +               printf("%s: Failed to get clocks %d\n", __func__, ret);
>> +               return ret;
>> +       }
>> +
>> +       ret = reset_get_bulk(dev, &priv->resets);
>> +       if (ret < 0) {
>> +               printf("failed to get resets, ret = %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       clk_enable_bulk(&priv->clks);
>> +       reset_deassert_bulk(&priv->resets);
>> +
>> +       return 0;
>> +}
>> +
>> +static struct phy_ops qcom_snps_hsphy_phy_ops = {
>> +       .power_on = qcom_snps_hsphy_power_on,
>> +       .power_off = qcom_snps_hsphy_power_off,
>> +};
>> +
>> +static const struct udevice_id qcom_snps_hsphy_phy_ids[] = {
>> +       { .compatible = "qcom,sm8150-usb-hs-phy" },
>> +       { .compatible = "qcom,usb-snps-hs-5nm-phy" },
>> +       { .compatible = "qcom,usb-snps-hs-7nm-phy" },
>> +       { .compatible = "qcom,usb-snps-femto-v2-phy" },
>> +       {}
>> +};
>> +
>> +U_BOOT_DRIVER(qcom_usb_qcom_snps_hsphy) = {
>> +       .name = "qcom-snps-hsphy",
>> +       .id = UCLASS_PHY,
>> +       .of_match = qcom_snps_hsphy_phy_ids,
>> +       .ops = &qcom_snps_hsphy_phy_ops,
>> +       .probe = qcom_snps_hsphy_phy_probe,
>> +       .priv_auto = sizeof(struct qcom_snps_hsphy),
>> +};
>>
>> --
>> 2.44.0
>>

-- 
// Caleb (they/them)
