Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3423C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 23:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3671682BA2;
	Thu, 17 Apr 2025 01:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744847230;
	bh=Qx76/Gzh2emTzesyC/f9fo20lfYovmqhlHgjw37B+Ro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xbqr1qHTVJx4/LQO+IIeg8QoLcvrvZnSSjBIkwVp5jJW6RXqqUZyt6Ho06yM6tw4X
	 LQrXrz2XY+30ze9Elf4mjeWMorMm4/XJoCueBVaJM7Uj462+eY4YOVeUDyahNXqVQC
	 Rv0tVVEcCtnGwb6VV3Z73SS2TZVBWsyp8veIZy19JqkZytILMEcJv16amaUl9dVjRO
	 FRBpXGd+Guy4WH5ZNKr+gTcy5CF8bNeJ/JMLM/v5juy2UnQHwmrCjxobqWmCusP3Sf
	 qjRg9yjtxhuzKFvLJEd1QDkYUecCsEcxEvLdZBZGZLhW3tLaQ2rX7RJIG28kkQnbti
	 J+Um+obLFzRkg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEB6D82BA4; Thu, 17 Apr 2025 01:47:08 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F3182B7C
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 01:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="NknUGKZw"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0FE901039EF2C; 
 Thu, 17 Apr 2025 01:47:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744847225; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Qx76/Gzh2emTzesyC/f9fo20lfYovmqhlHgjw37B+Ro=;
 b=NknUGKZw8twBBY0jWBORYUev241u2ViYgLSHz6f9GzPAaqzPHl5dHPXo/KOA5cjbkGqY0M
 KhOsP2Mnr6QhMmydUg2rYIf14pkY8fN8XE5b7tEH8Fvqn/wIwxXW/UdslaQRmMnbtD1/at
 NO8fKDm6Zf0l7KYsAqkyi/5ESEhbYGVCyGknSK0vtSsRQaYCgouqVhQthJPnAZWk+TCWWl
 LDGSxrAoqgVHb+XLlelsG7mFIRJFvqZwe5Bs/2UsiSzMMef7HrnMO09ACKDkcUKGrnY75m
 +U/zLz4vP/y+MBfKCSVriPwACEF/kLiDCKMtNDlcQC6EZeJ8Xhe38Db7rKn/5Q==
Message-ID: <b35218ca-df17-4423-9932-a2ad0ba14e50@denx.de>
Date: Thu, 17 Apr 2025 01:47:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH v2 16/24] clk: imx: Convert clock-osc-*
 back to osc_*
To: Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Fabio Estevam <festevam@gmail.com>, Fabio Estevam <festevam@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan
 <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-17-marex@denx.de>
 <20250415142846.GA244333@francesco-nb>
 <CAHCN7xLa5W-AtRso6RUZwZG_sfDm9CHierfzt_WfOqFjSGJZoA@mail.gmail.com>
 <20250415150344.GA246483@francesco-nb>
 <b396cb96-ff95-4822-ad24-ddff2e3b6545@denx.de>
 <CAOMZO5B=j=k8U6to2TDzohS11j4hPWQOho9bdrYCPe0WXtrQjw@mail.gmail.com>
 <20250416092639.GA24345@francesco-nb>
 <db2d623afd944df2bca6d1e4657d4031@dh-electronics.com>
 <CAHCN7xKyoBQPeXDA90-kcBTw7BhObvn6PVzreoUQ5+GjiCewyg@mail.gmail.com>
 <CAHCN7xLgS7FZ4ajbBa+p-_w_s6oHnfMYcZEMsNBNkqkgAG-7Jw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAHCN7xLgS7FZ4ajbBa+p-_w_s6oHnfMYcZEMsNBNkqkgAG-7Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/17/25 1:35 AM, Adam Ford wrote:

[...]

>          if (!parent)
> @@ -113,6 +114,9 @@ int clk_mux_fetch_parent_index(struct clk *clk,
> struct clk *parent)
>          for (i = 0; i < mux->num_parents; i++) {
>                  if (!strcmp(parent->dev->name, mux->parent_names[i]))
>                          return i;
> +               dev_read_string_index(parent->dev,
> "clock-output-names", i, &name);

You are not supposed to use "clock-output-names" for clock look up.
You are supposed to use "clocks"/"clock-names" DT properties and then 
resolve the remote clock from information in those.

> +               if (!strcmp(name, mux->parent_names[i]))
> +                       return i;
>                  if (!strcmp(parent->dev->name,
>                              clk_resolve_parent_clk(clk->dev,
>                                                     mux->parent_names[i])))
clk_resolve_parent_clk() is meant to look up the clocks in local DT node 
"clock-names" property by name, and based on that, figure out which 
phandle to use in local DT node "clocks" property to access those clock:

For example, in dts/upstream/src/arm64/freescale/imx8mp.dtsi

  745 clk: clock-controller@30380000 {
  746         compatible = "fsl,imx8mp-ccm";
  747         reg = <0x30380000 0x10000>;
  748         interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
  749                      <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
  750         #clock-cells = <1>;
  751         clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
                                    ^^^^^^^^
  752                  <&clk_ext3>, <&clk_ext4>;
  753         clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
                                        ^^^^^^^
                 This "osc_24m" is also the same osc_24m referenced in
                 drivers/clk/imx/clk-imx8mp.c imx8mp_a53_sels[] and co.

Is then resolved to these clock:

  188         osc_24m: clock-osc-24m {
  189                 compatible = "fixed-clock";
  190                 #clock-cells = <0>;
  191                 clock-frequency = <24000000>;
  192                 clock-output-names = "osc_24m";
                                            ^^^^^^^ Ignore this
  193         };
