Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA817CD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 04:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 226E3881D3;
	Wed,  3 Apr 2024 06:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QKeFeEuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89F00881DC; Wed,  3 Apr 2024 06:48:06 +0200 (CEST)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EDE5881D3
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 06:48:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7e3cc62a78aso82570241.0
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 21:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712119683; x=1712724483; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fe3uoxiJ718LVZYHqUKWO3mmfORWoIjg2z6XWP1ZnSU=;
 b=QKeFeEuwLxaNJARL9/iz9CWu6jkto1GwS5cKFfa1y+H6TFz+R2LD1bbJFCBQgXIKs5
 6QmDjLPxqZDBu70NChyBjrqsTQi2NK24UQLhuNNHY+XzV4Hs0B9V9QbG4JcluCBQxxTY
 TCihp96ISOgEjYT2Z8SF26zIGJZf7jcPJ0miPbt90ILDYnznE4MJCr87IPQZi++0fl1Q
 0Gc4tPB5+Crsj7pTUnakM3HgDkYqyABc2HZn7a4f8DtWRrb0jneWZHfeNw3FJrSUyHJo
 ubmBp04SKpczZmKPkdIqBU01+cRbi0De2xa6Lh14pnCL5wlBYwnqBhCEOcImCS+rH6+6
 FrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712119683; x=1712724483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fe3uoxiJ718LVZYHqUKWO3mmfORWoIjg2z6XWP1ZnSU=;
 b=JoSKMTBF88UAz45VQvpsImrNX+PTbyrgxjAydeJV0AMbbX7sm0fkyazc8f59UzTRA7
 fNyfrQSl/PY8dA/Yl1UrhCJx1j8N8Re8b6YmT8E5QATQ3iBqQNRVQg1g3cNMiuhxkaeh
 tqCIxz/LPzJUeaX+vhwckC+C8CVsVhrVh9izw6JJmDLza85xJ9kX1fKp+doOsbCIKwXU
 lDLaiGXuRjrVqOQmyxWh1w4P489Ip/TfeGxztO+UCNjcPo7bh7l4jHMtEtZc3Hf2M6zk
 p5DpmpP0nwatAEFMSNwIr4L6IA/uSK74cjH4zKq4rBv+d1DhY79Dw1WyFu/BajF3vKUV
 igPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURxPliZdtSE7BPgO4D2DzxzgxjKSEAvETddqZn47zPaBqepeAtc4E8bF3MY9NEJC5rxwCabY4JKo9w3stjxGddCoTEWQ==
X-Gm-Message-State: AOJu0Yx9S31TrsZ2abQEFQGurG6XCBUCyUS/VrDb1btye41YtMo0f81g
 Cp510zQHuNWQm3p9BKKV8LtSqM43Tke97zIRSz0WuId6QjHpKCpq068lZI/OL8DSFI3SBHK5309
 bA5ayKxSfPoj8qwNDRQ5YoM0mQfeAmM2o2Lxnqw==
X-Google-Smtp-Source: AGHT+IFLlc2fjqAY74L+MVYbt70gb1rfY6SotEy2GMJmxgwNAGNH1qPNg6+4j3wGb+72cURNj8iLqhxPvqtOFamEH5A=
X-Received: by 2002:a05:6102:3b85:b0:478:763d:857b with SMTP id
 z5-20020a0561023b8500b00478763d857bmr7914504vsu.5.1712119683127; Tue, 02 Apr
 2024 21:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
 <20240328-b4-qcom-livetree-v5-3-4e98228b3d03@linaro.org>
 <CAFA6WYO=_2NQckqt11b81GPZXGE13Uw9hCkO6S+F6b3ve2nDBA@mail.gmail.com>
 <e1ce6d8f-20f5-47af-84a3-d100f96c1b31@linaro.org>
In-Reply-To: <e1ce6d8f-20f5-47af-84a3-d100f96c1b31@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 3 Apr 2024 10:17:52 +0530
Message-ID: <CAFA6WYOqvQ5Ybu2jdPmLiv42DHtYs0XJv8NVEHWKLtvwCs3HQA@mail.gmail.com>
Subject: Re: [PATCH v5 03/16] phy: qcom: Add SNPS femto v2 USB HS phy
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 2 Apr 2024 at 15:37, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Sumit,
>
> On 01/04/2024 06:46, Sumit Garg wrote:
> > On Thu, 28 Mar 2024 at 23:29, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> From: Bhupesh Sharma <bhupesh.linux@gmail.com>
> >>
> >> Some Qualcomm SoCs newer than SDM845 feature a so-called "7nm phy"
> >> driver, notable the SM8250 SoC which will gain U-Boot support in
> >> upcoming patches.
> >>
> >> Introduce a driver based on the Linux driver.
> >>
> >> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> >> [code cleanup, align symbol names with Linux, switch to clk/reset_bulk APIs]
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >>   drivers/phy/qcom/Kconfig                  |   8 ++
> >>   drivers/phy/qcom/Makefile                 |   1 +
> >>   drivers/phy/qcom/phy-qcom-snps-femto-v2.c | 207 ++++++++++++++++++++++++++++++
> >>   3 files changed, 216 insertions(+)
> >>
> ...
> >> diff --git a/drivers/phy/qcom/phy-qcom-snps-femto-v2.c b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
> >> new file mode 100644
> >> index 000000000000..58eb01972402
> >> --- /dev/null
> >> +++ b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
> ...
> >> +static inline void qcom_snps_hsphy_write_mask(void __iomem *base, u32 offset,
> >> +                                             u32 mask, u32 val)
> >> +{
> >> +       u32 reg;
> >> +
> >> +       reg = readl_relaxed(base + offset);
> >> +
> >> +       reg &= ~mask;
> >> +       reg |= val & mask;
> >> +       writel_relaxed(reg, base + offset);
> >> +
> >> +       /* Ensure above write is completed */
> >> +       readl_relaxed(base + offset);
> >
> > It looks like you have missed addressing comments related to this API.
> > Again, why do we need this special handling in U-Boot? Why not just
> > clrsetbits_le32()?
>
> I have tried to find more info about this, but from what I can tell it's
> important (my guess is that it's a weird bus arbitration thing with the
> QMP phy's).
>
> If I replace this with clrsetbits_le32() then my SM8250 board crashdumps
> while probing USB. So it is needed (and I'm wondering now if I ought to
> switch back to this for the dwc3 qcom glue as well).

Strange, probably it's due to some strict device memory ordering
rules. If you can add some reasoning in comments for this API then
feel free to add:

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit
