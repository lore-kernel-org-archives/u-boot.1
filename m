Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE6010ED674
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 13:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9500D83C14;
	Fri, 27 Mar 2026 14:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pmTzEfkN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A29A283DA7; Fri, 27 Mar 2026 14:12:50 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DA5D8394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 14:12:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-486fb112c09so21067575e9.1
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774617167; x=1775221967; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yFcQ4Sl0ZMU698JmoMJ07dM7B4EObVEuLCmaVE+8m2E=;
 b=pmTzEfkNjy0WcEcJWOuRHSXiwq2BuMYZf38YxDRJIEcyRzi3b8Etaav+YkQrdzMhTc
 +S7KKfDmD3uQqL0WFi3XQ5KUIrrqraoJg+6KKkvwMBQmqdBH5mSL1npFmb2qf9N9MWIx
 YKlt/tub5OqVaP6Y7y2xneBea0SmwPcQ4UXJn2qyAPFtgbHCvQ9L+OMfJU91dNOgLB+A
 Io08rnG3jAJrIeZa8fLeaKo65ymgoWAr7xxVGRuX2KbQ168TufNFpXHe1xztsbkMb5KI
 Sz14S9VVXw0y7fLIikgyz2Pt6Gz2NT9qI1OGYm5tHqf0TxX8C34g4xlBgGSk+qXPYk8A
 cDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774617167; x=1775221967;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yFcQ4Sl0ZMU698JmoMJ07dM7B4EObVEuLCmaVE+8m2E=;
 b=PepR5gKJYsYfbW6AqO8RGoZDRDKBgkYhw3lqS6max1hmA8MZpRlA5zbcp6T9frTGwo
 h4tzlHglppGnVg7Zda38T4BHRb0DaHRaeINRO9vFzGgDBBIGb7BwpIWGpjZALWl+XPGo
 ++ufJoP5jMw1U+VZcBsMlRcRDyWV/9SzXlq5PNLI5+RTV2tQlugV6mX6JO1GcRivB/VL
 5Hl2/oJoCKiQ+7HJuzSWH4PgU5tqXoKJcH9zcxHruPUGhWYfY6195fIv1s5fN6IR4E77
 /DmycIUzUq1sY7wVQwzRX2ekQ5GIVbPTsTlqaBVRCFvxne91DRQjfYVnxTgKL4GDrqXF
 RZkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+UqzZWUr4okUAx2ry0UKtuBsaTP9m8W8JunVZVmCjqg17JhN8+6QE6M/XJB0mypmQ/WWrHLU=@lists.denx.de
X-Gm-Message-State: AOJu0YwrIU1/qY26hhJhp2e/eRqZQ+9uzEhX4p7PN7f8vbUlYU+5QKrQ
 YhR+S/2B/GYGfar4YUFyrTTToV4AemTu9I4UmkSm6Bwhm/K+1UmLBey+BIDiFdS3PGY=
X-Gm-Gg: ATEYQzzglXKeC2Fpv14xmbTAMUqBEEaOKQ607qbYTpF0STxfZi7xGJiyEnPQViFIT8Y
 yvrvEDWKhil0UhPSJ6O5N5t04ZERvLkVTgV7jiS5ami53nD43vRI4vXYZixCxG5jeKPGzZ2V3Dh
 nWs6Ptn4EfPaw6mb0tEwgCC3QHeaGdE2xFXDsM2tbiA4CXPJOVC8ek3gC30thBDWchejluFdkd6
 xbz8MUDA/5UGdDudyR2gozxHYCWdrqKy63Gvj8Iw/XQf/UqnvL4zkwndK/J+4Q4QsIO2zRpLffu
 fhJAqbOefHCnQwOlCZzAFzjHQFHVdQtaqs1eYt2Nzj9lUNenpWvwXCrmNhkm6BZT4jirz2yCjNK
 3zybDjdGnvu4a2u1/kHFNk9JFE7EwlBrmd0DjmiTqvSI2vVyrkBApzL9BkWSvjCo0R1fE2v4jgJ
 MvhQzUiO92jXGHbZGmpXUJVg7SwUzf
X-Received: by 2002:a05:600c:a44:b0:486:fbf6:abd4 with SMTP id
 5b1f17b1804b1-48727efc11dmr36124745e9.9.1774617166813; 
 Fri, 27 Mar 2026 06:12:46 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48725eb5417sm25845595e9.3.2026.03.27.06.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 06:12:46 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:12:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michal Simek <michal.simek@amd.com>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Vincent Guittot <vincent.guittot@linaro.org>,
 arm-scmi@vger.kernel.org, Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH 1/2] firmware: scmi: Fix setting the function
Message-ID: <acaCS0DdVEilbygK@stanley.mountain>
References: <cover.1774526652.git.dan.carpenter@linaro.org>
 <401560217b674c299cb0f344e6f24c271fa7583a.1774526652.git.dan.carpenter@linaro.org>
 <93019930-f082-445c-a3c4-90024aadbf60@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93019930-f082-445c-a3c4-90024aadbf60@amd.com>
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

On Fri, Mar 27, 2026 at 12:45:00PM +0100, Michal Simek wrote:
> 
> 
> On 3/26/26 13:08, Dan Carpenter wrote:
> > Set BIT(10) when the function needs to be set, otherwise the setting is
> > ignored.
> > 
> > Fixes: 1048331f5d3c ("scmi: pinctrl: add pinctrl driver for SCMI")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >   drivers/firmware/scmi/pinctrl.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/firmware/scmi/pinctrl.c b/drivers/firmware/scmi/pinctrl.c
> > index 47f7a8ad9b81..e670538c87f9 100644
> > --- a/drivers/firmware/scmi/pinctrl.c
> > +++ b/drivers/firmware/scmi/pinctrl.c
> > @@ -259,6 +259,8 @@ static int scmi_pinctrl_settings_configure_helper(struct udevice *dev,
> >   	in->attr = 0;
> >   	in->attr |= FIELD_PREP(GENMASK(9, 2), num_configs);
> >   	in->attr |= FIELD_PREP(GENMASK(1, 0), select_type);
> > +	if (function_id != SCMI_PINCTRL_FUNCTION_NONE)
> > +		in->attr |= BIT(10);
> 
> hm shouldn't be macros to use for holding that value instead?
> 
> As I see GENMASK above is the same case.
> 

I think adding macros here would make the code less readable...  If we
were going to re-use them then, sure.  But really, the code is shoving
the num_configs into bits 2-9, there isn't any special meaning beyond
that.

> >   	memcpy(in->configs, configs, num_configs * sizeof(u32) * 2);
> 
> Another magic here.

Sure, I'll send this patch on Monday.

regards,
dan carpenter

diff --git a/drivers/firmware/scmi/pinctrl.c b/drivers/firmware/scmi/pinctrl.c
index e670538c87f9..2ae02ffc81b8 100644
--- a/drivers/firmware/scmi/pinctrl.c
+++ b/drivers/firmware/scmi/pinctrl.c
@@ -245,7 +245,9 @@ static int scmi_pinctrl_settings_configure_helper(struct udevice *dev,
 		.out_msg = (u8 *)&out,
 		.out_msg_sz = sizeof(out),
 	};
-	size_t in_sz = sizeof(*in) + (num_configs * sizeof(u32) * 2);
+	/* configs are type/value pairs of size u32 */
+	size_t config_size = (num_configs * sizeof(u32) * 2);
+	size_t in_sz = sizeof(*in) + config_size;
 	int ret;
 
 	in = kzalloc(in_sz, GFP_KERNEL);
@@ -261,7 +263,7 @@ static int scmi_pinctrl_settings_configure_helper(struct udevice *dev,
 	in->attr |= FIELD_PREP(GENMASK(1, 0), select_type);
 	if (function_id != SCMI_PINCTRL_FUNCTION_NONE)
 		in->attr |= BIT(10);
-	memcpy(in->configs, configs, num_configs * sizeof(u32) * 2);
+	memcpy(in->configs, configs, config_size);
 
 	ret = devm_scmi_process_msg(dev, &msg);
 	if (ret)

