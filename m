Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D93FD3760
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 786C183FF9;
	Wed, 25 Feb 2026 15:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Epu8pXfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C4B483FF5; Wed, 25 Feb 2026 15:39:46 +0100 (CET)
Received: from mail-wm1-x341.google.com (unknown [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC53183FA6
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 15:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-48372efa020so54453475e9.2
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 06:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772030089; x=1772634889; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0HkfTL169D0fGrdmLzQDRgZYg8tUQjAXGwSswhqog3Y=;
 b=Epu8pXfNxlSAD8NoJEedpGuxjUh1NIVW0Wzxh1bxKHA6Xc/IGL9tfE0TDzfKfHYgBA
 bSguL0s2Ig1uQgbMhRD/LsxLzbZVJ4DTuUYARnTdu/GXiZ++37AyflJrHyvfFneZ7nrd
 rNh6nPL++ie4R9WRtdXbnfx+h1nTBjOpx1QpMRIH/SRb7cwdCwQbghW5p4gg8YPNw7gu
 9/mS/CXqXA9FeiJ+xeiGlWg/CWS4DKGvwfOxFNA+547oATvzVjIU1pnScdZU1huUjotQ
 CZQLoEu/BSp1nXS17nzQ8WZo1l0/sCWZ+W9Ut7VqfrnSyj4Wl/CI2S7lqTI7JnljKOra
 LH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772030089; x=1772634889;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HkfTL169D0fGrdmLzQDRgZYg8tUQjAXGwSswhqog3Y=;
 b=cgLLzMVlCuG+NBkul6mZi+gibiiEozim+EcWhcG8FEI3feQK4SDThhuXb6g/ZnteDq
 F4I4q+EwnfBxfY8DWlSdajHKP8Vnc2eb70ZDXMkVl5NsmktJ/CGlqPRorLyXcvEa+s1C
 /tBHfAS2NPm6V2jfwa+Sj/ovYeQw1j5GSFi0KosKGqBuMLtV4U2Geugy5QTqbo05evc8
 7l4jGNC8U4VbEnZmYAZd3I54x1oI2NpbDv0AgzA11WzqFBJpttBjNYiuPZ3sXKg88FTF
 V/Sx4iez3utZL8miq5PCylrsEUteHbLQW3THQ2qOsz8Ql3wg/LQhhDaDaIfI6u+2CPbb
 eWvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFvR1Tj77MDSKUQ1BLuVe536y9xqc8GUX/3pOCiVCbkAxi01FXNo5aqohFiv1YT2ryY1LJgME=@lists.denx.de
X-Gm-Message-State: AOJu0YxFN+YVoskg3pvapWI429YeQBnB40VNtKjuHuR3eoRQI84od1XM
 sjx9rVI6PvseOZ/f2k5vBClEZWOTBtLvrOZT3NlejNY6G4edHGBkqi0emTaY5zVeK+M=
X-Gm-Gg: ATEYQzw87DyHk2A+JkwIpvy6PWpGgkR6TXvNgu2UX8jcoxOJJszZT2PftMAb4GRRykk
 kGzMICXBQqT4C1VoXCFD6uY8GF6BxY7x4SCUTKBlik5xNcm3dx95PClI+czHybIN7KX5yqZp0FU
 /DAQ4Z9M0NCwXhCLv+UMMn0Fp5O1jJd/abdrIoj8e6BqKMM/dBMucDdr6v1WxW1awbEGtRnqyeV
 1hIjdr+CgvS/V2fjc9rL+B/uDcVZUOWj08jF0VImzxitW79gSlrX4oKPjT3+8kslMMiaInqrgs/
 l8521394LERyWIChE8MVzJlCPTigeYGaMpuTkb69voZZFEjjwl/QnTqrocqmzJneDje0X80OJdY
 2Us0MBAB8uH5AV1EwZ0iHFB6+QHzKpAkifNAvOueObl0DMmsb9n6TFwGDXYgqQVL3ZYTvzzRxi/
 ARKrznSCLFiarqfOOiasYGUxVXpTe6W/i+p+tOi9gc7TTjqCHAcoc6rR/5GgE=
X-Received: by 2002:a05:600c:8b86:b0:480:6941:d38b with SMTP id
 5b1f17b1804b1-483c21b0089mr11214625e9.30.1772030088905; 
 Wed, 25 Feb 2026 06:34:48 -0800 (PST)
Received: from localhost (h136a.n1.ips.mtn.co.ug. [41.210.147.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfbb465bsm32600765e9.3.2026.02.25.06.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 06:34:48 -0800 (PST)
Date: Wed, 25 Feb 2026 17:34:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Marek Vasut <marex@denx.de>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Anis Chali <chalianis1@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Ye Li <ye.li@nxp.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>,
 Michal Simek <michal.simek@amd.com>, arm-scmi@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH 3/4] scmi: pinctrl: add pinctrl driver for SCMI
Message-ID: <aZ8Ig0nHh4Zz1nJj@stanley.mountain>
References: <cover.1771856828.git.dan.carpenter@linaro.org>
 <a9f8de77176cf0b8afa2f1addd0183f52da9d00c.1771856828.git.dan.carpenter@linaro.org>
 <aZ8BITY4Cag1tyas@nxa18884-linux.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ8BITY4Cag1tyas@nxa18884-linux.ap.freescale.net>
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

Thanks, Peng.  This is all good feedback and I'll fix it in the
next version.

On Wed, Feb 25, 2026 at 10:03:13PM +0800, Peng Fan wrote:
> >+int scmi_pinctrl_attrs(struct udevice *dev, enum select_type select_type,
> >+		       unsigned int selector, bool *gpio, unsigned int *count,
> >+		       char *name)
> >+{
> >+	struct scmi_pinctrl_attrs_in in;
> >+	struct scmi_pinctrl_attrs_out out;
> >+	struct scmi_msg msg = {
> >+		.protocol_id = SCMI_PROTOCOL_ID_PINCTRL,
> >+		.message_id = SCMI_PINCTRL_ATTRIBUTES,
> >+		.in_msg = (u8 *)&in,
> >+		.in_msg_sz = sizeof(in),
> >+		.out_msg = (u8 *)&out,
> >+		.out_msg_sz = sizeof(out),
> >+	};
> >+	int ret;
> >+
> >+	in.select_type = select_type;
> >+	in.id = selector;
> >+
> >+	ret = devm_scmi_process_msg(dev, &msg);
> >+	if (ret)
> >+		return ret;
> >+	if (out.status)
> >+		return scmi_to_linux_errno(out.status);
> >+
> >+	//estended_name = FIELD_GET(BIT(31), out.attr);
> 
> Drop this?
> 

Yeah.  I don't think anyone cares about the extended name ever.

> >+	if (gpio)
> >+		*gpio = FIELD_GET(BIT(17), out.attr);
> >+	//pin_only = FIELD_GET(BIT(16), out.attr);
> 
> Ditto.
> 

Huh.  Yeah.  It's not really clear how to handle pin only GPIO pins.

[ snip ]

> >+
> >+#define SCMI_PINCTRL_CONFIG_SETTINGS_FUNCTION -2u
> 
> I see spec is using 2, not understand well -2u here.
> When set to 2, no configuration values need to be returned.
> The command only returns the function selected for the pin or the group.
> 

This was just a magic define I used internally.

regards,
dan carpenter

