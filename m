Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB24C282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 12:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DAF1811C1;
	Mon,  3 Mar 2025 13:54:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IQGn8J0W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95EF4811C1; Mon,  3 Mar 2025 13:54:28 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF82A811B2
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 13:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2239c066347so22462595ad.2
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 04:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741006463; x=1741611263; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6tFcT4mlh86EHapzMKDETHxM3MZkSL8LyzaiHn+nP/A=;
 b=IQGn8J0WUH+VM/Yx/06UW+WrdQvpsZITrGInxYUTo7W6inH5IK3O9rcMtRRzm2DA7w
 yKfPOrhz+e16KYvLQJiUpZKJKPANAsfFxk9r/2iGNWsI0Zq2aC8H30+A7xEGPDE0GA2Z
 gBQjhAMCO4gFIT37HddOFYAVtJZtvSwcJM0HDBmqJEOpjuV+6YwO0BpS9Zuizrwdr073
 SWnlKuoSCG5L3Y1G2OGVuakhFbKDxsE1ea1qwzD0HkH+/72jne2yFDXhkHkBIHKUmG+6
 D3txK4CtqrFpWJoZ+OwmWIo8+AW7CDDkF6YSpD/CDX9RupVX82Ub6/np++5DNDBsH/YX
 KV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741006463; x=1741611263;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6tFcT4mlh86EHapzMKDETHxM3MZkSL8LyzaiHn+nP/A=;
 b=h7TmN2PiVVUZi8m9OFGKc6UYKmQBAPf5Tf1AgVOsEAmD50bPlz21yfV9edgQgD8gL1
 MwkZ6SR3oqKjZ5vXe5lRec4+UihjfY7jdyA0xkEhJR3nZRHTXGGG/fH1PPF0E7UwNjz9
 WfIPUmyMZik3QgZ3RQ/zMup+S6OmN8igaTPPRUIobHEOl98UMjRitONGtbxMil0uXyZX
 LttDHHffhqHhQj1QZgf0vXMvO3gbm1jDMYF8HHLKnNqER/Ih6w1L2X/XUFjzSO6Yv1y4
 2to9KqSVOVFtknipyJljXQV/iXPUID9tinZ5q9livyu9RH9bIvAdzd+nCK7tCvSnW2wm
 +XUQ==
X-Gm-Message-State: AOJu0YyM137Qba9uNt0kHUkTqWSd1whJEgDDcn72h2rjemOzz7mZ1/RN
 0Edk/YBq/1F2RM+cSqicoVkxsO5ZvDVBQBqWXWCMpmd8AUWXpzR4CEE+BEp+1+Wc5/2byqr4St+
 WcMMYbmE1N91NG1y/cjR2aCFEzHU=
X-Gm-Gg: ASbGncvLQ0Mumm87MBRylXyNA6S47zTwN09Hy5NUPQK69KkHgL94aiP9FCc8RsNZpul
 dcYrIzTQf7xmi03+xhC+MGCws1IARZOHgarKtFcomP1isnZaZLL9ghhSIPjqrBQY81/zuXeWgQX
 Z0XahgRP+ZALq8/xOug3D2F6vurg==
X-Google-Smtp-Source: AGHT+IE+tqf7Fr4miWP6mTNsNqR/RnA48PV9L8h+gHSfTiOgDIsNy6DqPw/jfEX7Zr2jxK8rVJOuHPQkFT+Ql880HUA=
X-Received: by 2002:a17:90b:4b4e:b0:2fa:ba3:5455 with SMTP id
 98e67ed59e1d1-2febab2be02mr21927261a91.7.1741006462971; Mon, 03 Mar 2025
 04:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20250302165249.267992-1-aford173@gmail.com>
 <20250302165249.267992-2-aford173@gmail.com>
 <CAOf5uwm3y4n9m3hw2OCV9kproJGAG6qiJU-ZcRrb4f3j1sQxXA@mail.gmail.com>
In-Reply-To: <CAOf5uwm3y4n9m3hw2OCV9kproJGAG6qiJU-ZcRrb4f3j1sQxXA@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 3 Mar 2025 06:54:11 -0600
X-Gm-Features: AQ5f1JoCofXBJvgJ0Mgh4YlWU7wIgXw2Vln7QhUwMiq0el1Ym8VmbxhYws77oOo
Message-ID: <CAHCN7x+kkhdcF563zEfkCoTY9UntY_GKY8upcVZhFSNGc6gBJg@mail.gmail.com>
Subject: Re: [PATCH 01/10] clk: imx6q: Properly handle imx6qp ESPI clk_sels
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Mar 3, 2025 at 6:34=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Adam
>
> On Sun, Mar 2, 2025 at 5:53=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
>>
>> The ECSPI clock has the ability to select between pll3_60m and
>> osc on the imx6qp, where it's fixed on other variants.  Fix this
>> by adding using a helper function to determine SoC variant and
>> register the clock accordingly.
>>
>> Signed-off-by: Adam Ford <aford173@gmail.com>
>> ---
>>  drivers/clk/imx/clk-imx6q.c | 22 +++++++++++++++++++---
>>  1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
>> index df9f0285e1e..de5e5d8132b 100644
>> --- a/drivers/clk/imx/clk-imx6q.c
>> +++ b/drivers/clk/imx/clk-imx6q.c
>> @@ -13,6 +13,11 @@
>>
>>  #include "clk.h"
>>
>> +static inline int clk_on_imx6qp(void)
>> +{
>> +       return of_machine_is_compatible("fsl,imx6qp");
>> +}
>> +
>
>
> It's static, why just not use direct compatible?

I looked at how it was done in Linux, and it seemed easier to read.
I can look at alternatives too.  There might already be a helper
function.

adam
>
>>
>>  static int imx6q_clk_request(struct clk *clk)
>>  {
>>         if (clk->id < IMX6QDL_CLK_DUMMY || clk->id >=3D IMX6QDL_CLK_END)=
 {
>> @@ -35,6 +40,7 @@ static const char *const usdhc_sels[] =3D { "pll2_pfd2=
_396m", "pll2_pfd0_352m", };
>>  static const char *const periph_sels[] =3D { "periph_pre", "periph_clk2=
", };
>>  static const char *const periph_pre_sels[] =3D { "pll2_bus", "pll2_pfd2=
_396m",
>>                                                "pll2_pfd0_352m", "pll2_1=
98m", };
>> +static const char *const ecspi_sels[] =3D { "pll3_60m", "osc", };
>>
>>  static int imx6q_clk_probe(struct udevice *dev)
>>  {
>> @@ -78,6 +84,12 @@ static int imx6q_clk_probe(struct udevice *dev)
>>                imx_clk_mux("usdhc4_sel", base + 0x1c, 19, 1,
>>                            usdhc_sels, ARRAY_SIZE(usdhc_sels)));
>>
>> +       if (clk_on_imx6qp()) {
>> +               clk_dm(IMX6QDL_CLK_ECSPI_SEL,
>> +                      imx_clk_mux("ecspi_sel", base + 0x38, 18, 1, ecsp=
i_sels,
>> +                                  ARRAY_SIZE(ecspi_sels)));
>> +       }
>> +
>>         clk_dm(IMX6QDL_CLK_USDHC1_PODF,
>>                imx_clk_divider("usdhc1_podf", "usdhc1_sel",
>>                                base + 0x24, 11, 3));
>> @@ -91,9 +103,13 @@ static int imx6q_clk_probe(struct udevice *dev)
>>                imx_clk_divider("usdhc4_podf", "usdhc4_sel",
>>                                base + 0x24, 22, 3));
>>
>> -       clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
>> -              imx_clk_divider("ecspi_root", "pll3_60m", base + 0x38, 19=
, 6));
>> -
>> +       if (clk_on_imx6qp()) {
>> +               clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
>> +                      imx_clk_divider("ecspi_root", "ecspi_sel", base +=
 0x38, 19, 6));
>> +       } else {
>> +               clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
>> +                      imx_clk_divider("ecspi_root", "pll3_60m", base + =
0x38, 19, 6));
>> +       }
>>         clk_dm(IMX6QDL_CLK_ECSPI1,
>>                imx_clk_gate2("ecspi1", "ecspi_root", base + 0x6c, 0));
>>         clk_dm(IMX6QDL_CLK_ECSPI2,
>
>
> Apart of that I'm almost fine with it.
>
> Reviewed-By: Michael Trimarchi <michael@amarulasolutions.com>
>
>>
>> --
>> 2.45.2
>>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com
