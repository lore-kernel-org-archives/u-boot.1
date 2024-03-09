Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB9FC54E49
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 22:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE51986FB2;
	Sat,  9 Mar 2024 23:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wv6mg6pz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A197B87073; Sat,  9 Mar 2024 23:10:46 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1881086F1E
 for <u-boot@lists.denx.de>; Sat,  9 Mar 2024 23:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dd5df90170so21117215ad.0
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 14:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710022241; x=1710627041; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ly4vkRZX3WOQZ1pVuJd4gunEg80z25Gkrfht0n5WhYk=;
 b=Wv6mg6pzfaALqwYw8T1QJ/ogy10ZzgySP9+o83q55TNPM2Hl1mk3H6sZAsgBxuVwvf
 JGYQur2ZeegRLjI9NXDuOVtlrOfZZxBq26XgsqwcQ9JKTwQpx9qgee2/kWQcU+5bG4jd
 vx9YBPqZgCzJRMQeZcbMhSz5Y1pGB6tWriGQvHJN+yXUH9MscpqvMD7+kSJUYdtraGif
 jU7IAiSQZwWO7Ha9Nb1cw8ozbknd8ixoIN/QUZFojAMB1wAFik5wzki4g9meHVAgXQKA
 zXMLx6CZiICaby/mzRnBE3o3KFOxNc+WnY9Yiwq/6KHEV+glUJ3ktQt1aknDpVt+KFR2
 rarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710022241; x=1710627041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ly4vkRZX3WOQZ1pVuJd4gunEg80z25Gkrfht0n5WhYk=;
 b=Af2u9zbPU1jYynmtjrOM9xWZxBK5XyuvdyohMqmz8lQ5de9U5HIIONxkxtEt2Objy6
 dXXujYtwJ5uF5M2DCrmYbcooUmJGBaKZf7UzlQI1wIVF95sycd0QsOiZPzahi6jz5PP9
 bTxmLtwrK+/Leb+F36BOYvIQnJvwJtmvecVQlRPou+rQUccs97vlK71G2AOl/vjCKO8H
 +60w+yFSSBwopiQxJf69uLdvGFDzmWtJVagQ3Hbq6d9M+hkSEfovH1gMSEV1SOejTXvZ
 hdIUPwKPe21lPVwt/tacfUDUbwUaD0q1N7kHxa8kpXVevz6aaViZmxb4plgqKLPIVMVw
 t5ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfQeM9jjZcYdW9ECscajZxytTTj7DmqVrwUb5u8OTyvFP6ACiZthOXHXhyO0yxMkZmjHpVDaYggvWuitCVIcrO7cSjLg==
X-Gm-Message-State: AOJu0Yx9SsbMOVEViFSnuDACleYvOg9dnJoolGdhrX36WSVLvpuPpBtZ
 8KYU380zJzxdNid76xs9txsw01u/w2yynDtsLx7vioWOCbj8JfUK
X-Google-Smtp-Source: AGHT+IHEzBIQpEPJOqG9hQpl6d5Ge8kDx5q5Pp+/mNau6cINE9NKaYw1YrRNvwTI4TYWEY2Umu5qYw==
X-Received: by 2002:a17:902:e9cc:b0:1dd:6285:b84a with SMTP id
 12-20020a170902e9cc00b001dd6285b84amr2963708plk.9.1710022241133; 
 Sat, 09 Mar 2024 14:10:41 -0800 (PST)
Received: from hdebian.. ([2804:14d:8084:b86e:a499:faa9:8aa5:875a])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a170902d28900b001db5ee597e8sm1752433plc.261.2024.03.09.14.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 14:10:40 -0800 (PST)
From: Hiago De Franco <hiagofranco@gmail.com>
To: peng.fan@nxp.com
Cc: festevam@gmail.com, francesco.dolcini@toradex.com,
 hiago.franco@toradex.com, joao.goncalves@toradex.com,
 marcel.ziswiler@toradex.com, seanga2@gmail.com, trini@konsulko.com,
 u-boot@lists.denx.de, ye.li@nxp.com,
 Hiago De Franco <hiagofranco@gmail.com>
Subject: RE: [PATCH 1/2] clk: clk-imx8qxp: Add LPUART IPG entries
Date: Sat,  9 Mar 2024 19:09:32 -0300
Message-ID: <20240309220932.166254-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DU0PR04MB94175939E19F7DDFDA77758388262@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB94175939E19F7DDFDA77758388262@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On 09.03.2024 01:15, Peng Fan wrote:
> > Subject: [PATCH 1/2] clk: clk-imx8qxp: Add LPUART IPG entries
> > 
> > Since commit cc7df0b9e8bc ("serial: lpuart: Enable IPG clock") the colibri-
> > imx8qxp board no longer boots.
> > 
> > The reason is that the imx8qxp clock driver does not handle the LPUART IPG
> > clocks inside get_rate(), set_rate() and enable() functions.
> > 
> > Fix the boot regression by adding the LPUART IPG entries.
> > 
> > Fixes: cc7df0b9e8bc ("serial: lpuart: Enable IPG clock")
> > Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > Signed-off-by: Fabio Estevam <festevam@gmail.com>
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Toradex Colibri iMX8X

> > ---
> >  drivers/clk/imx/clk-imx8qxp.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
> > index 8bf7e325481..d900d4cd528 100644
> > --- a/drivers/clk/imx/clk-imx8qxp.c
> > +++ b/drivers/clk/imx/clk-imx8qxp.c
> > @@ -88,20 +88,23 @@ ulong imx8_clk_get_rate(struct clk *clk)
> >  		resource = SC_R_SDHC_1;
> >  		pm_clk = SC_PM_CLK_PER;
> >  		break;
> > -	case IMX8QXP_UART0_IPG_CLK:
> >  	case IMX8QXP_UART0_CLK:
> > +	case IMX8QXP_UART0_IPG_CLK:
> >  		resource = SC_R_UART_0;
> >  		pm_clk = SC_PM_CLK_PER;
> >  		break;
> >  	case IMX8QXP_UART1_CLK:
> > +	case IMX8QXP_UART1_IPG_CLK:
> >  		resource = SC_R_UART_1;
> >  		pm_clk = SC_PM_CLK_PER;
> >  		break;
> >  	case IMX8QXP_UART2_CLK:
> > +	case IMX8QXP_UART2_IPG_CLK:
> >  		resource = SC_R_UART_2;
> >  		pm_clk = SC_PM_CLK_PER;
> >  		break;
> >  	case IMX8QXP_UART3_CLK:
> > +	case IMX8QXP_UART3_IPG_CLK:
> >  		resource = SC_R_UART_3;
> >  		pm_clk = SC_PM_CLK_PER;
> >  		break;
> > @@ -170,18 +173,22 @@ ulong imx8_clk_set_rate(struct clk *clk, unsigned
> > long rate)
> >  		pm_clk = SC_PM_CLK_PER;
> >  		break;
> >  	case IMX8QXP_UART0_CLK:
> > +	case IMX8QXP_UART0_IPG_CLK:
> >  		resource = SC_R_UART_0;
> >  		pm_clk = SC_PM_CLK_PER;
> >  		break;
> >  	case IMX8QXP_UART1_CLK:
> > +	case IMX8QXP_UART1_IPG_CLK:
> >  		resource = SC_R_UART_1;
> >  		pm_clk = SC_PM_CLK_PER;
> >  		break;
> >  	case IMX8QXP_UART2_CLK:
> > +	case IMX8QXP_UART2_IPG_CLK:
> >  		resource = SC_R_UART_2;
> >  		pm_clk = SC_PM_CLK_PER;
> >  		break;
> >  	case IMX8QXP_UART3_CLK:
> > +	case IMX8QXP_UART3_IPG_CLK:
> >  		resource = SC_R_UART_3;
> >  		pm_clk = SC_PM_CLK_PER;
> >  		break;
> > @@ -263,18 +270,22 @@ int __imx8_clk_enable(struct clk *clk, bool enable)
> >  		pm_clk = SC_PM_CLK_PER;
> >  		break;
> >  	case IMX8QXP_UART0_CLK:
> > +	case IMX8QXP_UART0_IPG_CLK:
> >  		resource = SC_R_UART_0;
> >  		pm_clk = SC_PM_CLK_PER;
> >  		break;
> >  	case IMX8QXP_UART1_CLK:
> > +	case IMX8QXP_UART1_IPG_CLK:
> >  		resource = SC_R_UART_1;
> >  		pm_clk = SC_PM_CLK_PER;
> >  		break;
> >  	case IMX8QXP_UART2_CLK:
> > +	case IMX8QXP_UART2_IPG_CLK:
> >  		resource = SC_R_UART_2;
> >  		pm_clk = SC_PM_CLK_PER;
> >  		break;
> >  	case IMX8QXP_UART3_CLK:
> > +	case IMX8QXP_UART3_IPG_CLK:
> >  		resource = SC_R_UART_3;
> >  		pm_clk = SC_PM_CLK_PER;
> >  		break;
> > --
> > 2.34.1
> 
