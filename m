Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CC5C53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:49:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7D494061F;
	Mon, 27 Jul 2026 08:49:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QhNHDj0q28ta; Mon, 27 Jul 2026 08:49:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC63540608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785142177;
	bh=5FvNo85HA7oXPh/Jo1sMr+mBe5VKP7CCbaXEhRSoQrY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l0sKBxO8lhBYHSfCHVyLofU0dllAKeJ4y21K5/V4JB18OjSY7ETEeWKPS43Dad/r2
	 o8dQZkuZMggPkZWEMGTeGNaETh6JSF1A393/HrDKneeMUEPz4O0XuGtAc43pHD8Z4g
	 AogqH5rmuyTbEqZ0BuGWz8sqYsWL6+GR6xqT2fYpTa6oIBMLSQrW+qc5ANtaI41rjj
	 EGqPjufdr8QH4x9ABVaAv0Pg8An2mj+OsQMmmpeWeUoE81W+E7e+t211dn2OlGscff
	 NvD8zgUFVkXdnuLaPtssluVdyn5vAjaoy3m6PtXmXrSDEu8pgPTVWomfPUSCLbIwNZ
	 EZl7gmecUj3LQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC63540608;
	Mon, 27 Jul 2026 08:49:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 248AB3B1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A57B40536
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:49:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VAnqf7jgGelL for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:49:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 782004058B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 782004058B
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 782004058B
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:49:33 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c15c42a45adso486488466b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 01:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785142171; cv=none;
 d=google.com; s=arc-20260327;
 b=f08OAmCEfpNq+zF3EpdvbY8ixp4LvF7RFDfwsV3dkOG9KBJrF1KL8BrIE+xA6L98WI
 EEletjHCsLRAQVZ/Xx5ai+gzqD48LnC3I6rs96fLu0lQr5FV/OdrihSJa5Jro3EMdvBW
 Z9r0JYvl8J+LSY+urFO/DMiIhvolYZ6D16QVyC0IAm01i9gtpEASz9R0/tEP+T9wuo9P
 AyJ9Oqmm83oa1E/9a9CpRmTgE4M3jh/I/msWFl9825sgFyuGdco6YsJ8oTMLxx1X3YCM
 nOxbNjgFYEkNLeOFYhN/XmIpeSbKiww4K4BpEpgVldkqgt2A5TMzL9y1d3uLJixqA+j4
 QhJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5FvNo85HA7oXPh/Jo1sMr+mBe5VKP7CCbaXEhRSoQrY=;
 fh=ZSmALHzE+9iycq3fX1JXT1xWSK2XxZz25K8nVf59vU4=;
 b=N8r6af/o3gHws7+3umWTabdwfJy4po5mZPpDvNRYoRMdm2P6Eyz1fqT41so99ADXVW
 FGSy/Tj1CDAA9fmbWBrve+g9GR9oJrPA/Sy/AyiUH0j+7WniRU7hvtRBRRyz2lK8akuG
 hXEMsqGFpNedaI/Trnolrnhhk9CA7A2kJfH4vPQfdm0mtGswHgil8MrI4Lq6rJQ2J/Yt
 H2LBFfFUfKTN1kLxXPKKrxSUc3idr7euecOrsNZGj7tX8RmAGEJUsHtwIYdO7hOpolvH
 TwTq+/EIhZEbse+DPQ2zu/c5RRYLz3379AnDoFoeeB5xpEJbnnHMPe6HZIcF56g0P5kn
 7t5A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785142171; x=1785746971;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5FvNo85HA7oXPh/Jo1sMr+mBe5VKP7CCbaXEhRSoQrY=;
 b=kvVJ5LjH4MFN7iSOg47b5Q/beHCbLsRhcLRhqATgkrdO151OwKwFm2dKQsprpqbZia
 FVYcfEkLA1PL2s/bqape+e7kkRSYZDTySRWwWF4oDxrezSVHDP0sy0mfxAs/zIF38WKt
 +fx52kqdvpEVtsnU0Ub4ZPqSF8YXNo81a4qs29qVmb8kD8wM8GIIszUp9CwAwxChcX/o
 k7zzqJRB98WegtmRujNRBUnm0fM/zV5eUEh2So6wbQ7LpfNS1rQ0pVvUFRXDKkxoZEQq
 wg+nx09CZme/chTGEKAWqHkM5sADqbvE8owxEgHAbqpZwDnyoe+yx9Ax6ST+5sEbenPS
 l8uQ==
X-Gm-Message-State: AOJu0Yykhsz3e3tkr2pbEcTmXvJcd9XPeL68eBd23hPRJ9rQ9F+OexMJ
 n8d815jmAYdJNLeuJL1FpJG+82e53WeTymKSv2JtDQW2kiaBAzW0VzyxfZMQh4ijL2JLE2KjWDg
 UtyehodDmWvtjV+oZ+TOYkAuelFChH637miDo0KaGYg==
X-Gm-Gg: AR+sD10VYZ/AVXBwBQDSlFQpxKFm0m6Yqhg2UV/CeOrd/gq9IqzpMxJU9UQRfHD5naY
 Wmf9Y6th9qlIPa6OgwQO9rPPPR083JhCn0woGUHM+SQ7aU9TQ/k+d7DSlNnsECJYjIQ2g9lk8wW
 O6g8IsZgkNj1BUjJJ5yijgxhCW73QujTVrbY1ti3mrsafKUkSz49lHxq33ARw04XkYlxi17ynzq
 Z4IBPnSfKgfOKCl/WZ1k+JyF8vJAR20bVA8LxNuy/t0h3817O/YMtakM2+mM82RKf8eV89z+QwG
 SdJws+pX3vDAL86ltRhUrKtRm80vTwN46PPchIDvoYC/bcqXBv0N718dVpwClqI9W7ZPwyiWI7L
 wLFqtfw==
X-Received: by 2002:a17:907:cd0d:b0:c16:242a:4744 with SMTP id
 a640c23a62f3a-c1f1fd8997emr356882066b.17.1785142171039; Mon, 27 Jul 2026
 01:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260717-mt8188-add-ddc-i2c-driver-v1-0-e89ccd173567@baylibre.com>
 <20260717-mt8188-add-ddc-i2c-driver-v1-2-e89ccd173567@baylibre.com>
 <09824d1e-c2ea-8d66-a670-b57c911e2ed4@nabladev.com>
In-Reply-To: <09824d1e-c2ea-8d66-a670-b57c911e2ed4@nabladev.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 27 Jul 2026 10:49:24 +0200
X-Gm-Features: AUfX_mw2W-wcZMTS-lqvz9ELU8rLOLHaKTDm8cYWGTMX5dkdUARwuwtgCzkyFRE
Message-ID: <CAEHHSvb4LK+FKQ1JC1KkANbHCG4QOMY-+TAojJ4VYR5NwGzCUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] i2c: mtk_mt8195_i2c_ddc: add new driver
To: Heiko Schocher <hs@nabladev.com>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Johan Jonker <jbx6244@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785142171; x=1785746971;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5FvNo85HA7oXPh/Jo1sMr+mBe5VKP7CCbaXEhRSoQrY=;
 b=M88xeOJbG2foqRuf3u/7Xw46YNuSlX60amyeYq+hgTXr/xA1FaLpSlrgjqRfSpgQ0w
 p7Lj2b7GjbMZVZI3C/ApwT3UWAplaM+Oml0r0vDNXjLfn71Xm1RKCD0hD+fkOyBjWFQ0
 +0W/QXZDgQP3bCV9IoXCHQOWJo1/lCjT7KNTSKWlNkvW+F8KGOIVbqR5Oiy6aj43nBhl
 qkt6eqCAk6iR37JdJLWouSnBqaIE6Ioe77aV+BKgo0Vna3BHbfyeov1XSkX+m5CbRE1E
 9gyX2HB9QVEJ62GqH4BnylmGQ0tHv6FXjKk9TbyFlL00e0w7PMsK/Gb9saRbNSAu67Tt
 X0gg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=M88xeOJb
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Le mer. 22 juil. 2026 =C3=A0 07:20, Heiko Schocher <hs@nabladev.com> a =C3=
=A9crit :
>
> Hello Julien,
>
> (used the new u-boot ml address u-boot@lists.u-boot-project.org and
> dropped the old denx one)
>
> On 17.07.26 14:33, Julien Stephan wrote:
> > Add a new driver for HDMI DDC channel reading for MT8195 based SoCs.
> > The driver is based on the corresponding kernel driver.
> >
> > Signed-off-by: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> >   drivers/i2c/Kconfig              |  11 ++
> >   drivers/i2c/Makefile             |   1 +
> >   drivers/i2c/mtk_mt8195_i2c_ddc.c | 398 ++++++++++++++++++++++++++++++=
+++++++++
> >   3 files changed, 410 insertions(+)
> >
> [...]
> > diff --git a/drivers/i2c/mtk_mt8195_i2c_ddc.c b/drivers/i2c/mtk_mt8195_=
i2c_ddc.c
> > new file mode 100644
> > index 00000000000..7b6e57929a9
> > --- /dev/null
> > +++ b/drivers/i2c/mtk_mt8195_i2c_ddc.c
> > @@ -0,0 +1,398 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2021 MediaTek Inc.
> > + * Copyright (c) 2026 BayLibre, SAS
> > + *
> > + */
> > +
> > +#include <asm/io.h>
> > +#include <clk.h>
> > +#include <dm.h>
> > +#include <dm/device_compat.h>
> > +#include <edid.h>
> > +#include <i2c.h>
> > +#include <linux/delay.h>
> > +#include <time.h>
> > +
> > +#define DDC2_CLOCK 572 /* BIM=3D208M/(v*4) =3D 90Khz */
> > +#define DDC2_CLOCK_EDID 832 /* BIM=3D208M/(v*4) =3D 62.5Khz */
>
> What is v ?

Hi Heiko,

To be honest, I am not sure.. The code comes from a downstream driver
in MediaTek code base.
The driver is upstream in kernel, and contains the same comment
(defines was renamed during upstream process I guess, but meaning is
the same).
If you want, I can ask MediaTek to clarify this.

>
> > +
> > +#define SCDC_I2C_SLAVE_ADDRESS 0x54
> > +
> > +#define HDCP2X_DDCM_STATUS 0xC68
> > +
> > +#define SCDC_CTRL 0xC18
> > +
> > +#define CLEAR_FIFO 0x9
> > +
> > +#define CLOCK_SCL 0xA
> > +
> > +#define ENH_READ_NO_ACK 0x4
> > +
> > +#define DDC_CMD GENMASK(31, 28)
> > +#define DDC_CMD_SHIFT (28)
> > +#define DDC_CTRL 0xC10
> > +#define DDC_DATA_OUT GENMASK(23, 16)
> > +#define DDC_DATA_OUT_SHIFT (16)
> > +#define DDC_DELAY_CNT GENMASK(31, 16)
> > +#define DDC_DELAY_CNT_SHIFT (16)
> > +#define DDC_DIN_CNT_SHIFT (16)
> > +#define DDC_I2C_BUS_LOW BIT(11)
> > +#define DDC_I2C_IN_PROG BIT(13)
> > +#define DDC_I2C_NO_ACK BIT(10)
> > +#define DDC_OFFSET_SHIFT (8)
> > +#define DDC_SEGMENT GENMASK(15, 8)
> > +#define DDC_SEGMENT_SHIFT (8)
> > +
> > +#define HPD_DDC_CTRL 0xC08
> > +#define HPD_DDC_STATUS 0xC60
> > +
> > +#define SEQ_READ_NO_ACK 0x2
> > +#define SEQ_WRITE_REQ_ACK 0x7
> > +
> > +#define SI2C_CTRL 0xCAC
> > +#define SI2C_ADDR_READ (0xF4)
> > +#define SI2C_ADDR_SHIFT (16)
> > +#define SI2C_WDATA GENMASK(15, 8)
> > +#define SI2C_WDATA_SHIFT (8)
> > +#define SI2C_CONFIRM_READ BIT(2)
> > +#define SI2C_RD BIT(1)
> > +#define SI2C_WR BIT(0)
> > +
> > +#define HDCP2X_POL_CTRL 0xC54
> > +#define HDCP2X_DIS_POLL_EN BIT(16)
> > +
> > +struct mtk_hdmi_ddc {
> > +     struct udevice *udev;
> > +     struct clk clk;
> > +     void __iomem *regs;
> > +};
> > +
> > +enum sif_bit_t_hdmi {
> > +     SIF_8_BIT_HDMI, /* 8 bits data address */
> > +     SIF_16_BIT_HDMI, /* 16 bits data address */
> > +};
> > +
> > +static inline unsigned int mtk_ddc_read(struct mtk_hdmi_ddc *ddc,
> > +                                     unsigned int reg)
> > +{
> > +     return readl(ddc->regs + reg);
> > +}
> > +
> > +static inline void mtk_ddc_write(struct mtk_hdmi_ddc *ddc, unsigned in=
t reg,
> > +                              unsigned int val)
> > +{
> > +     writel(val, ddc->regs + reg);
> > +}
> > +
> > +static inline void mtk_ddc_mask(struct mtk_hdmi_ddc *ddc, unsigned int=
 reg,
> > +                             unsigned int val, unsigned int mask)
> > +{
> > +     unsigned int tmp;
> > +
> > +     tmp =3D readl(ddc->regs + reg) & ~mask;
> > +     tmp |=3D (val & mask);
> > +     writel(tmp, ddc->regs + reg);
> > +}
>
> May you want to use clrsetbits_* instead?

thank you, done in v2!

>
> > +
> > +static void mtk_ddc_disable_hdcp_polling(struct mtk_hdmi_ddc *ddc)
> > +{
> > +     mtk_ddc_mask(ddc, HDCP2X_POL_CTRL, HDCP2X_DIS_POLL_EN,
> > +                  HDCP2X_DIS_POLL_EN);
> > +}
> > +
> > +static void ddc_wr_one(struct mtk_hdmi_ddc *ddc, unsigned int addr_id,
> > +                    unsigned int offset_id, unsigned char wr_data)
> > +{
> > +     if (mtk_ddc_read(ddc, HDCP2X_DDCM_STATUS) & DDC_I2C_BUS_LOW) {
> > +             mtk_ddc_mask(ddc, DDC_CTRL, (CLOCK_SCL << DDC_CMD_SHIFT),
> > +                          DDC_CMD);
> > +             udelay(300);
> > +     }
> > +     mtk_ddc_mask(ddc, HPD_DDC_CTRL, DDC2_CLOCK << DDC_DELAY_CNT_SHIFT=
,
> > +                  DDC_DELAY_CNT);
> > +     mtk_ddc_write(ddc, SI2C_CTRL, SI2C_ADDR_READ << SI2C_ADDR_SHIFT);
> > +     mtk_ddc_mask(ddc, SI2C_CTRL, wr_data << SI2C_WDATA_SHIFT, SI2C_WD=
ATA);
> > +     mtk_ddc_mask(ddc, SI2C_CTRL, SI2C_WR, SI2C_WR);
> > +
> > +     mtk_ddc_write(ddc, DDC_CTRL,
> > +                   (SEQ_WRITE_REQ_ACK << DDC_CMD_SHIFT) +
> > +                   (1 << DDC_DIN_CNT_SHIFT) +
> > +                   (offset_id << DDC_OFFSET_SHIFT) + (addr_id << 1));
> > +
> > +     udelay(1250);
> > +
> > +     if ((mtk_ddc_read(ddc, HDCP2X_DDCM_STATUS) &
> > +          (DDC_I2C_NO_ACK | DDC_I2C_BUS_LOW))) {
> > +             if (mtk_ddc_read(ddc, HDCP2X_DDCM_STATUS) & DDC_I2C_BUS_L=
OW) {
> > +                     mtk_ddc_mask(ddc, DDC_CTRL,
> > +                                  (CLOCK_SCL << DDC_CMD_SHIFT), DDC_CM=
D);
> > +                     udelay(300);
> > +             }
> > +     }
> > +}
>
> This magic delays... are they documented somewhere?
>

Same as before, not sure where they are coming from, but Kernel driver
uses the same values.

> > +
> > +static unsigned int
> > +ddcm_read_hdmi(struct mtk_hdmi_ddc *ddc, unsigned int u4_clk_div,
> > +            unsigned char uc_dev, unsigned int u4_addr,
> > +            unsigned char *puc_value, unsigned int u4_count)
> > +{
> > +     unsigned int i, temp_length, loop_counter;
> > +     unsigned int uc_read_count =3D 0, uc_idx;
> > +     unsigned long ddc_start_time, ddc_end_time, ddc_timeout;
> > +
> > +     if (!puc_value || !u4_count || !u4_clk_div)
> > +             return 0;
> > +
> > +     if (mtk_ddc_read(ddc, HDCP2X_DDCM_STATUS) & DDC_I2C_BUS_LOW) {
> > +             mtk_ddc_mask(ddc, DDC_CTRL, (CLOCK_SCL << DDC_CMD_SHIFT),
> > +                          DDC_CMD);
> > +             udelay(300);
> > +     }
> > +
> > +     mtk_ddc_mask(ddc, DDC_CTRL, (CLEAR_FIFO << DDC_CMD_SHIFT), DDC_CM=
D);
> > +
> > +     if (u4_count >=3D 16) {
> > +             temp_length =3D 16;
> > +             loop_counter =3D u4_count / 16 + ((u4_count % 16 =3D=3D 0=
) ? 0 : 1);
> > +     } else {
> > +             temp_length =3D u4_count;
> > +             loop_counter =3D 1;
> > +     }
> > +
> > +     if (uc_dev >=3D EDID_ADDR && u4_clk_div < DDC2_CLOCK_EDID)
> > +             u4_clk_div =3D DDC2_CLOCK_EDID;
> > +
> > +     mtk_ddc_mask(ddc, HPD_DDC_CTRL, u4_clk_div << DDC_DELAY_CNT_SHIFT=
,
> > +                  DDC_DELAY_CNT);
> > +
> > +     for (i =3D 0; i < loop_counter; i++) {
> > +             if (i =3D=3D (loop_counter - 1) && i !=3D 0 && u4_count %=
 16)
> > +                     temp_length =3D u4_count % 16;
> > +
> > +             /* EDID_ADDR(0x50) + 1 .. 0x53 select an EDID segment */
> > +             if (uc_dev > EDID_ADDR && uc_dev <=3D 0x53) {
> > +                     mtk_ddc_mask(ddc, SCDC_CTRL,
> > +                                  (uc_dev - EDID_ADDR)
> > +                                  << DDC_SEGMENT_SHIFT,
> > +                                  DDC_SEGMENT);
> > +                     mtk_ddc_write(ddc, DDC_CTRL,
> > +                                   (ENH_READ_NO_ACK << DDC_CMD_SHIFT) =
+
> > +                                   (temp_length << DDC_DIN_CNT_SHIFT) =
+
> > +                                   ((u4_addr + i * temp_length)
> > +                                    << DDC_OFFSET_SHIFT) +
> > +                                   (EDID_ADDR << 1));
> > +             } else {
> > +                     mtk_ddc_write(ddc, DDC_CTRL,
> > +                                   (SEQ_READ_NO_ACK << DDC_CMD_SHIFT) =
+
> > +                                   (temp_length << DDC_DIN_CNT_SHIFT) =
+
> > +                                   ((u4_addr + i * 16)
> > +                                    << DDC_OFFSET_SHIFT) + (uc_dev << =
1));
> > +             }
> > +             udelay(5500);
> > +             ddc_start_time =3D get_timer(0);
> > +             /* timeout in ms: about 1 ms per byte plus some margin */
> > +             ddc_timeout =3D temp_length + 5;
> > +             ddc_end_time =3D ddc_start_time + ddc_timeout;
> > +             while (1) {
> > +                     if ((mtk_ddc_read(ddc, HPD_DDC_STATUS) &
> > +                          DDC_I2C_IN_PROG) =3D=3D 0)
> > +                             break;
> > +
> > +                     if (time_after(get_timer(0), ddc_end_time)) {
> > +                             dev_err(ddc->udev, "DDC transfer timeout\=
n");
> > +                             return 0;
> > +                     }
> > +                     udelay(1500);
> > +             }
> > +             if ((mtk_ddc_read(ddc, HDCP2X_DDCM_STATUS) &
> > +                  (DDC_I2C_NO_ACK | DDC_I2C_BUS_LOW))) {
> > +                     if (mtk_ddc_read(ddc, HDCP2X_DDCM_STATUS) &
> > +                         DDC_I2C_BUS_LOW) {
> > +                             mtk_ddc_mask(ddc, DDC_CTRL,
> > +                                          (CLOCK_SCL << DDC_CMD_SHIFT)=
,
> > +                                          DDC_CMD);
> > +                             udelay(300);
> > +                     }
> > +                     return 0;
> > +             }
> > +
> > +             /* get the DDC data from the FIFO */
> > +             for (uc_idx =3D 0; uc_idx < temp_length; uc_idx++) {
> > +                     /* latch the FIFO output */
> > +                     mtk_ddc_write(ddc, SI2C_CTRL,
> > +                                   (SI2C_ADDR_READ << SI2C_ADDR_SHIFT)=
 +
> > +                                   SI2C_RD);
> > +
> > +                     /* read FIFO output value from DDC_STATUS */
> > +                     puc_value[i * 16 + uc_idx] =3D
> > +                             (mtk_ddc_read(ddc, HPD_DDC_STATUS) &
> > +                              DDC_DATA_OUT) >> DDC_DATA_OUT_SHIFT;
> > +
> > +                     /* increment FIFO read pointer, un-latch the FIFO=
 */
> > +                     mtk_ddc_write(ddc, SI2C_CTRL,
> > +                                   (SI2C_ADDR_READ << SI2C_ADDR_SHIFT)=
 +
> > +                                   SI2C_CONFIRM_READ);
> > +                     /*
> > +                      * if the hdmi block was reset while reading, the=
 DDC
> > +                      * speed falls back below DDC2_CLOCK: abort
> > +                      */
> > +                     if (((mtk_ddc_read(ddc, HPD_DDC_CTRL) >> 16) &
> > +                          0xFFFF) < DDC2_CLOCK)
> > +                             return 0;
> > +
> > +                     uc_read_count =3D i * 16 + uc_idx + 1;
> > +             }
> > +     }
> > +
> > +     return uc_read_count;
> > +}
> > +
> > +static unsigned int vddc_read(struct mtk_hdmi_ddc *ddc,
> > +                           unsigned int u4_clk_div, unsigned char uc_d=
ev,
> > +                           unsigned int u4_addr,
> > +                           enum sif_bit_t_hdmi uc_addr_type,
> > +                           unsigned char *puc_value, unsigned int u4_c=
ount)
> > +{
> > +     unsigned int u4_read_count =3D 0;
> > +
> > +     if (!puc_value || !u4_count || !u4_clk_div)
> > +             return 0;
> > +     if (uc_addr_type > SIF_16_BIT_HDMI)
> > +             return 0;
> > +     if (uc_addr_type =3D=3D SIF_8_BIT_HDMI && u4_addr > 255)
> > +             return 0;
> > +     if (uc_addr_type =3D=3D SIF_16_BIT_HDMI && u4_addr > 65535)
> > +             return 0;
> > +
> > +     if (uc_addr_type =3D=3D SIF_8_BIT_HDMI)
> > +             u4_read_count =3D 255 - u4_addr + 1;
> > +     else if (uc_addr_type =3D=3D SIF_16_BIT_HDMI)
> > +             u4_read_count =3D 65535 - u4_addr + 1;
> > +
> > +     u4_read_count =3D min(u4_read_count, u4_count);
> > +
> > +     return ddcm_read_hdmi(ddc, u4_clk_div, uc_dev, u4_addr, puc_value=
,
> > +                           u4_read_count);
> > +}
> > +
> > +static int fg_ddc_data_read(struct mtk_hdmi_ddc *ddc, unsigned char b_=
dev,
> > +                         unsigned char b_data_addr,
> > +                         unsigned int b_data_count, unsigned char *pr_=
data)
> > +{
> > +     mtk_ddc_disable_hdcp_polling(ddc);
> > +     if (vddc_read(ddc, DDC2_CLOCK, b_dev, b_data_addr, SIF_8_BIT_HDMI=
,
> > +                   pr_data, b_data_count) !=3D b_data_count)
> > +             return -EREMOTEIO;
> > +
> > +     return 0;
> > +}
> > +
> > +static int fg_ddc_data_write(struct mtk_hdmi_ddc *ddc, unsigned char b=
_dev,
> > +                          unsigned char b_data_addr,
> > +                          unsigned int b_data_count,
> > +                          unsigned char *pr_data)
> > +{
> > +     unsigned int i;
> > +
> > +     mtk_ddc_disable_hdcp_polling(ddc);
> > +     for (i =3D 0; i < b_data_count; i++)
> > +             ddc_wr_one(ddc, b_dev, b_data_addr + i, *(pr_data + i));
> > +
> > +     return 0;
> > +}
> > +
> > +static int mtk_hdmi_ddc_xfer(struct udevice *dev, struct i2c_msg *msgs=
, int num)
> > +{
> > +     struct mtk_hdmi_ddc *ddc =3D dev_get_priv(dev);
> > +     unsigned char offset =3D 0;
> > +     int ret;
> > +     int i;
> > +
> > +     if (!msgs)
> > +             return -EINVAL;
> > +
> > +     if (!ddc || !ddc->regs)
> > +             return -EINVAL;
> > +
> > +     for (i =3D 0; i < num; i++) {
> > +             struct i2c_msg *msg =3D &msgs[i];
> > +
> > +             if (!msg->buf || !msg->len)
> > +                     return -EINVAL;
> > +
> > +             if (msg->flags & I2C_M_RD) {
> > +                     /*
> > +                      * The underlying DDC hardware always issues a wr=
ite
> > +                      * request that assigns the read offset as part o=
f the
> > +                      * read operation, so use the offset value stored=
 on
> > +                      * the previous write request.
> > +                      */
> > +                     ret =3D fg_ddc_data_read(ddc, msg->addr, offset,
> > +                                            msg->len, &msg->buf[0]);
> > +             } else {
> > +                     ret =3D fg_ddc_data_write(ddc, msg->addr, msg->bu=
f[0],
> > +                                             msg->len - 1, &msg->buf[1=
]);
> > +
> > +                     /*
> > +                      * store the offset requested by the EDID/SCDC
> > +                      * framework for use by subsequent read requests
> > +                      */
> > +                     if ((msg->addr =3D=3D EDID_ADDR ||
> > +                          msg->addr =3D=3D SCDC_I2C_SLAVE_ADDRESS) &&
> > +                         msg->len =3D=3D 1)
> > +                             offset =3D msg->buf[0];
> > +             }
> > +
> > +             if (ret) {
> > +                     dev_err(dev, "ddc transfer failed: %d\n", ret);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int mtk_hdmi_ddc_probe(struct udevice *dev)
> > +{
> > +     struct mtk_hdmi_ddc *ddc =3D dev_get_priv(dev);
> > +     int ret;
> > +
> > +     ddc->udev =3D dev;
> > +     /* the ddc node sits below the hdmi node, which holds the registe=
rs */
> > +     ddc->regs =3D dev_read_addr_ptr(dev->parent);
> > +     if (!ddc->regs)
> > +             return -EINVAL;
> > +
> > +     ret =3D clk_get_by_index(dev, 0, &ddc->clk);
> > +     if (ret) {
> > +             dev_err(dev, "failed to get ddc clk: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D clk_enable(&ddc->clk);
> > +     if (ret) {
> > +             dev_err(dev, "failed to enable ddc clk: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct dm_i2c_ops mtk_hdmi_ddc_ops =3D {
> > +     .xfer   =3D mtk_hdmi_ddc_xfer,
> > +};
> > +
> > +static const struct udevice_id mtk_hdmi_ddc_ids[] =3D {
> > +     { .compatible =3D "mediatek,mt8195-hdmi-ddc", },
> > +     { }
> > +};
> > +
> > +U_BOOT_DRIVER(mtk_i2c_ddc) =3D {
> > +     .name           =3D "mtk_i2c_ddc",
> > +     .id             =3D UCLASS_I2C,
> > +     .of_match       =3D mtk_hdmi_ddc_ids,
> > +     .probe          =3D mtk_hdmi_ddc_probe,
> > +     .priv_auto      =3D sizeof(struct mtk_hdmi_ddc),
> > +     .ops            =3D &mtk_hdmi_ddc_ops,
> > +};
> >
>
> beside the nitpicks
>
> Reviewed-by: Heiko Schocher <hs@nabladev.com>
>
> Thanks!
>
> bye,
> Heiko
> --
> Nabla Software Engineering
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
> Gesch=C3=A4ftsf=C3=BChrer : Stefano Babic
