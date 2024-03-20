Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339F0C6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 13:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F2F687D4B;
	Wed, 20 Mar 2024 14:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="we7slQLd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F29787CFC; Wed, 20 Mar 2024 14:47:05 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC6F8804F
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 14:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41412411622so23241055e9.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 06:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710942421; x=1711547221; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/wsEpsgfwnCLcL7HRhkjGcuaNIMH5SGwEa2KoB+x5jU=;
 b=we7slQLd9iS7GArNIlgWsqD2tf72n+ETVonyPWxdIl1V7IlbXBA8msKI7iEnEvb3E5
 Mrc3+Za2ZYIxm9xt4r7faxp2abE+CSjKIbcQB3n1jKtaVrFlVguVHdZZr8MaJDB1TbQx
 9ME3mtGyrx1ku9NaQ/+Y7n1RE873/gPKUku6DIeM7VGohhs+4Ru9eq56LVYJmOwtnHrd
 PnuxXUJ+zcGk9LcZl3GhbZkdPIKRu9+aIRI1tfnqc2KRWW+ZxPL684k/TOTwsKvqp6mX
 5PmgKnZAD4WIarXsg97KjXAFxRgX268F5uklewKJGI/pYp7M+P/NPROBhbrCkwQGvE76
 UoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710942421; x=1711547221;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/wsEpsgfwnCLcL7HRhkjGcuaNIMH5SGwEa2KoB+x5jU=;
 b=e/sGJnVdCt70ZbOMT7XY+cYoh75T7KwFqbiaLLtDGcovYlkH/pjrWrlASNu859hv3I
 Wkj3YPO3a3w+PDOyuBz1qHXMET3NeTCd4bxjPa40kSd8iGeG2qxYtj4BmuDWinoMT7Xx
 /DCXJjJmyBF3i0XyZs5FVghf316fYYJwl3JCgtPckvzgt/lSUp6g9M5eRPYWIJIUgaE9
 4++abe/3hdjpJ3WBkFHdkXnMmCF8NFxCaXCYVk5VH2aQWhHa3i3FSK/JfcQyXrPHhjpQ
 OhhFtaj8sNvhoC5hlvucW/9Jdsj2+OpUDJnVGhInDcTuwHuRJptPKIXuokhP1e8nafIS
 lF4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAuXdrV4qz+koy0O54eVFWwH9cSNw48RmTIbrlOxNAAi2AiMtr95uPLkBizztM64UZ67FY2X4VbCDr4jOyl4GXNNxvIA==
X-Gm-Message-State: AOJu0YxAI3Hl8/09Qp/NiKUDtp+P46WnP3sTpVV1aGu9JZzWmy8hNXND
 /vzPDMaJUu7cd6B0E6jsL0PHXvOZBk7PVn1KouR3xXhfGin5o0R3ELHMSeRH5dE=
X-Google-Smtp-Source: AGHT+IEMpqROPq4XWhtV3lFWOPDnaFEyjHwbRMNoIgmHP7CDtX0wzLWhoRsQEKKN5J5YmmnKKApyOw==
X-Received: by 2002:a05:600c:46cd:b0:413:f28d:1cf2 with SMTP id
 q13-20020a05600c46cd00b00413f28d1cf2mr13347467wmo.4.1710942421355; 
 Wed, 20 Mar 2024 06:47:01 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 m2-20020a05600c3b0200b0041463c2c6ccsm2316368wms.4.2024.03.20.06.47.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 06:47:00 -0700 (PDT)
Message-ID: <636b1ef5-1139-457c-9785-12ffe06bdb49@linaro.org>
Date: Wed, 20 Mar 2024 13:47:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] phy: qcom: add Qualcomm QUSB2 USB PHY driver
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Bhupesh Sharma <bhupesh.linux@gmail.com>
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-2-e1b38d9b4fa4@linaro.org>
 <CAFA6WYOF44dKAQouFN3Z8h86CuRJ9unp2m9dSA52cMvaF0UCjQ@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYOF44dKAQouFN3Z8h86CuRJ9unp2m9dSA52cMvaF0UCjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

>> +static inline void qusb2_write_mask(void __iomem *base, u32 offset, u32 val,
>> +                                   u32 mask)
>> +{
>> +       u32 reg;
>> +
>> +       reg = readl(base + offset);
>> +       reg &= ~mask;
>> +       reg |= val & mask;
>> +       writel(reg, base + offset);
>> +
>> +       /* Ensure above write is completed */
>> +       readl(base + offset);
>> +}
> 
> Function unused?

Will drop
> 
>> +
>> +static inline void qusb2_setbits(void __iomem *base, u32 offset, u32 val)
>> +{
>> +       u32 reg;
>> +
>> +       reg = readl(base + offset);
>> +       reg |= val;
>> +       writel(reg, base + offset);
>> +
>> +       /* Ensure above write is completed */
>> +       readl(base + offset);
>> +}
>> +
>> +static inline void qusb2_clrbits(void __iomem *base, u32 offset, u32 val)
>> +{
>> +       u32 reg;
>> +
>> +       reg = readl(base + offset);
>> +       reg &= ~val;
>> +       writel(reg, base + offset);
>> +
>> +       /* Ensure above write is completed */
>> +       readl(base + offset);
>> +}
> 
> Any specific reason to not use setbits_le32() and clrbits_le32() her instead?

This is just copied from Linux. I tested with set/clrbits and it seems
to work ok... I'm a little worried this is a workaround for some obscure
bug but eh, I guess we'll just go without and see what happens.
> 
>> +
>> +static inline void qusb2_phy_configure(void __iomem *base,
>> +                                      const unsigned int *regs,
>> +                                      const struct qusb2_phy_init_tbl tbl[],
>> +                                      int num)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < num; i++) {
>> +               if (tbl[i].in_layout)
>> +                       writel(tbl[i].val, base + regs[tbl[i].offset]);
>> +               else
>> +                       writel(tbl[i].val, base + tbl[i].offset);
>> +       }
>> +}
>> +
>> +static int qusb2phy_do_reset(struct qusb2_phy *qphy)
>> +{
>> +       int ret;
>> +
>> +       ret = reset_assert(&qphy->phy_rst);
>> +       if (ret)
>> +               return ret;
>> +
>> +       udelay(10);
>> +
>> +       ret = reset_deassert(&qphy->phy_rst);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return 0;
>> +}
>> +
>> +static int qusb2phy_power_on(struct phy *phy)
>> +{
>> +       struct qusb2_phy *qphy = dev_get_priv(phy->dev);
>> +       const struct qusb2_phy_cfg *cfg = qphy->cfg;
>> +       int ret;
>> +       u32 val;
>> +
>> +       ret = qusb2phy_do_reset(qphy);
>> +       if (ret)
>> +               return ret;
> 
> Do we really need to reset here? Wouldn't just
> reset_deassert(&qphy->phy_rst) be sufficient here instead?

The reset is not asserted by default, so de-asserting it would do
nothing. Yes we need to reset because we have no idea what state the
hardware is in, depending on what board and what bootloader you've come
from this phy could have already been powered up and configured before
we get to U-Boot.


> 
> -Sumit
> 
>> +
>> +       /* Disable the PHY */
>> +       qusb2_setbits(qphy->base, cfg->regs[QUSB2PHY_PORT_POWERDOWN],
>> +                     qphy->cfg->disable_ctrl);
>> +
>> +       if (cfg->has_pll_test) {
>> +               /* save reset value to override reference clock scheme later */
>> +               val = readl(qphy->base + QUSB2PHY_PLL_TEST);
>> +       }
>> +
>> +       qusb2_phy_configure(qphy->base, cfg->regs, cfg->tbl, cfg->tbl_num);
>> +
>> +       /* Enable the PHY */
>> +       qusb2_clrbits(qphy->base, cfg->regs[QUSB2PHY_PORT_POWERDOWN],
>> +                     POWER_DOWN);
>> +
>> +       /* Required to get phy pll lock successfully */
>> +       udelay(150);
>> +
>> +       if (cfg->has_pll_test) {
>> +               val |= CLK_REF_SEL;
>> +
>> +               writel(val, qphy->base + QUSB2PHY_PLL_TEST);
>> +
>> +               /* ensure above write is through */
>> +               readl(qphy->base + QUSB2PHY_PLL_TEST);
>> +       }
>> +
>> +       /* Required to get phy pll lock successfully */
>> +       udelay(100);
>> +
>> +       val = readb(qphy->base + cfg->regs[QUSB2PHY_PLL_STATUS]);
>> +       if (!(val & cfg->mask_core_ready)) {
>> +               pr_err("QUSB2PHY pll lock failed: status reg = %x\n", val);
>> +               ret = -EBUSY;
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int qusb2phy_power_off(struct phy *phy)
>> +{
>> +       struct qusb2_phy *qphy = dev_get_priv(phy->dev);
>> +
>> +       /* Disable the PHY */
>> +       qusb2_setbits(qphy->base, qphy->cfg->regs[QUSB2PHY_PORT_POWERDOWN],
>> +                     qphy->cfg->disable_ctrl);
>> +
>> +       reset_assert(&qphy->phy_rst);
>> +
>> +       clk_disable(&qphy->cfg_ahb_clk);
>> +
>> +       return 0;
>> +}
>> +
>> +static int qusb2phy_clk_init(struct udevice *dev, struct qusb2_phy *qphy)
>> +{
>> +       int ret;
>> +
>> +       /* We ignore the ref clock as we currently lack a driver for rpmcc/rpmhcc where
>> +        * it usually comes from - we assume it's always on.
>> +        */
>> +       ret = clk_get_by_name(dev, "cfg_ahb", &qphy->cfg_ahb_clk);
>> +       if (ret == -ENOSYS || ret == -ENOENT)
>> +               return 0;
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = clk_enable(&qphy->cfg_ahb_clk);
>> +       if (ret) {
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int qusb2phy_probe(struct udevice *dev)
>> +{
>> +       struct qusb2_phy *qphy = dev_get_priv(dev);
>> +       int ret;
>> +
>> +       qphy->base = (void __iomem *)dev_read_addr(dev);
>> +       if (IS_ERR(qphy->base))
>> +               return PTR_ERR(qphy->base);
>> +
>> +       ret = qusb2phy_clk_init(dev, qphy);
>> +       if (ret) {
>> +               printf("%s: Couldn't get clocks: %d\n", __func__, ret);
>> +               return ret;
>> +       }
>> +
>> +       ret = reset_get_by_index(dev, 0, &qphy->phy_rst);
>> +       if (ret) {
>> +               printf("%s: Couldn't get resets: %d\n", __func__, ret);
>> +               return ret;
>> +       }
>> +
>> +       qphy->cfg = (const struct qusb2_phy_cfg *)dev_get_driver_data(dev);
>> +       if (!qphy->cfg) {
>> +               printf("%s: Couldn't get driver data\n", __func__);
>> +               return -EINVAL;
>> +       }
>> +
>> +       debug("%s success qusb phy cfg %p\n", __func__, qphy->cfg);
>> +       return 0;
>> +}
>> +
>> +static struct phy_ops qusb2phy_ops = {
>> +       .power_on = qusb2phy_power_on,
>> +       .power_off = qusb2phy_power_off,
>> +};
>> +
>> +static const struct udevice_id qusb2phy_ids[] = {
>> +       { .compatible = "qcom,qusb2-phy" },
>> +       { .compatible = "qcom,qcm2290-qusb2-phy",
>> +         .data = (ulong)&sm6115_phy_cfg },
>> +       { .compatible = "qcom,sm6115-qusb2-phy",
>> +         .data = (ulong)&sm6115_phy_cfg },
>> +       { .compatible = "qcom,qusb2-v2-phy", .data = (ulong)&qusb2_v2_phy_cfg },
>> +       {}
>> +};
>> +
>> +U_BOOT_DRIVER(qcom_qusb2_phy) = {
>> +       .name = "qcom-qusb2-phy",
>> +       .id = UCLASS_PHY,
>> +       .of_match = qusb2phy_ids,
>> +       .ops = &qusb2phy_ops,
>> +       .probe = qusb2phy_probe,
>> +       .priv_auto = sizeof(struct qusb2_phy),
>> +};
>>
>> --
>> 2.44.0
>>

-- 
// Caleb (they/them)
