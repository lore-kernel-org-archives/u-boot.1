Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF67C4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 14:34:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDC0387C78;
	Thu,  1 Feb 2024 15:34:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w0FgtGTZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F286187C76; Thu,  1 Feb 2024 15:34:33 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 440C987C78
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 15:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33b1b21c020so179741f8f.0
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 06:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706798068; x=1707402868; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xty1A/YKB+bP1+68m+kZFtA+OaqBYfl1/DT11huMdL4=;
 b=w0FgtGTZkdtRTi3CC3hi8ozScnN4z80PLhmBgtdb6ASP5J4n+go6XbI7SFmHBO9DYr
 hvGDQ9bD6Dy/NgnT3aQkpd9PW9UvjoC9wullJUXOCYsEZoo4USuM0DOuSDW0gdp4XImG
 X3dJvRWge+SaeQX2YvSzQqPiQDczSxfnHl39DOZIJKOUv5tbQxbZ3fXGmMaULxrJnJgG
 El1yKa9tv4mm8anqsuPOEI1FtRycMDyaSX6kzGic7aeW8Tupe1+YcpjziSk7haf6OLtF
 XoBD+Y/7V3mjjwXDNwsgH1rm8p1HLulmP7a3PhBFghgon4bdMtNm7pWl7uzcD9GQLBJZ
 CPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706798068; x=1707402868;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xty1A/YKB+bP1+68m+kZFtA+OaqBYfl1/DT11huMdL4=;
 b=J9dSROMTCCREjlsNGm8ggzbvmiL+83uAJFaQL8WiLpcbmpq31iLxyGKffkdx1CdwHI
 3lMsIsRt0JiItU6eEgbokwzspY3J/5WW6drv35rPxjzi/jKmmQ0acFKO6dFEbnavVkDo
 PFdRmh/h3qNL+oZlWAfT7MzdsLvVNdVaxqwS3DKVB6MgNzRVI8NpO7bY6dANZcSv05Co
 r43s6vHdGcVF4Msj+SpDpUbzmjCvV8paKAEd+jVN+Io4+kvgJe1iySoG/kt0NF0f6mdB
 KVs86AhlQjVgOJvNegJBeXc59tTWXlUvqqgz96qa3Do+5Dq382G48Z5lbb+K4bSgngZi
 eOqQ==
X-Gm-Message-State: AOJu0YzruLFFjjcA5elwbmWbrtg/YyswBrSQCh7hJYwa4fVWJGgsfN0i
 eDpu9UmTWwU14mBfTVW0xMj12WEVd05knelHbMDi/OikfbDcx6ltGJFzuvH+ldQ=
X-Google-Smtp-Source: AGHT+IEYAeajAM23rULB5kn6UpqIT2kuFn5+eXpn8FY3yt1mGFz3RRe+5Cbs+Was1zgyTaeddLfuVA==
X-Received: by 2002:a5d:4445:0:b0:33b:187c:4ca0 with SMTP id
 x5-20020a5d4445000000b0033b187c4ca0mr1001961wrr.62.1706798068657; 
 Thu, 01 Feb 2024 06:34:28 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXuLAtbwV9ttQXFGIlAZ0X8Tm9vWnomqlvb+O3KrFhs/je5hTBavv8ivciYibptN6056Usb6lrvLYUq+cSVeAVGN+bfwflhH4NzIHMM2ZkBeTwc79hn4zvDwHvIrUMtGHcPvqKZrnz6QOH0iQfTbv27zph1H0Cnw8UrHLvhjULBXrbtIvQLCi0NvDrj+sCqn9nvXVl7yJdprjR33J6vkO77DFQGSml7sImi6qpTqwrkj3QCrXrhx0VJAgw9Npnp8hN6LwciLNAvnftHAZHXGHE3BSEHLyvnVASACICBI0hRKMBk2fzi/YvL6T/KuI1Gw9NENBNv6NZHSTMzkE1P3vt8WbUGdUlsqZ5WQRzDXx+n349XNAHk7I5UWRmicH8JRS/a
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 d2-20020adf9c82000000b0033929310ae4sm16384680wre.73.2024.02.01.06.34.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 06:34:28 -0800 (PST)
Message-ID: <cefe7d3b-876e-4680-b9e2-6b612579b803@linaro.org>
Date: Thu, 1 Feb 2024 14:34:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/36] mmc: msm_sdhci: use modern clock handling
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski
 <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
 <20240130-b4-qcom-common-target-v3-3-e523cbf9e556@linaro.org>
 <CAFA6WYPveDeXdq70-jRV7ZM80g6kZN2=45gFgy92qv49xirfAw@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYPveDeXdq70-jRV7ZM80g6kZN2=45gFgy92qv49xirfAw@mail.gmail.com>
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



On 01/02/2024 08:19, Sumit Garg wrote:
> On Tue, 30 Jan 2024 at 19:35, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Use the clk_* helper functions and the correct property name for clocks.
> 
> This still doesn't handle fixed clocks like in case of QCS404, upstream DT says:
> 
>                 sdcc1: mmc@7804000 {
>                         compatible = "qcom,qcs404-sdhci", "qcom,sdhci-msm-v5";
>                         ...
>                         clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>                                  <&gcc GCC_SDCC1_APPS_CLK>,
>                                  <&xo_board>;
>                         clock-names = "iface", "core", "xo";
>                         ...
>                 };
> 
> Due to that "xo" fixed clock we get:
> 
> MMC:   clk_set_rate(clk=00000000ffaf7348, rate=19200000)
> Unknown clock id 0
> clk_set_rate(clk=00000000ffaf7598, rate=19200000)
> Unknown clock id 0
> clk_set_rate(clk=00000000ffb08868, rate=400000)
> mmc@7804000: 0

Does MMC work? This doesn't look like a probe failure to me.

But yes this does look odd, somehow qcs404_clk_set_rate() is being
called with clk->id == 0. The xo_board clock uses a different driver so
it can't be that...

Could you try and add some more logging around here? I can't see what
might be causing this.
> 
> -Sumit
> 
>>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  drivers/mmc/msm_sdhci.c | 69 ++++++++++++++++++++++++++++++++-----------------
>>  1 file changed, 46 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
>> index 604f9c3ff99c..863e6007a905 100644
>> --- a/drivers/mmc/msm_sdhci.c
>> +++ b/drivers/mmc/msm_sdhci.c
>> @@ -44,6 +44,7 @@ struct msm_sdhc_plat {
>>  struct msm_sdhc {
>>         struct sdhci_host host;
>>         void *base;
>> +       struct clk_bulk clks;
>>  };
>>
>>  struct msm_sdhc_variant_info {
>> @@ -54,36 +55,56 @@ DECLARE_GLOBAL_DATA_PTR;
>>
>>  static int msm_sdc_clk_init(struct udevice *dev)
>>  {
>> -       int node = dev_of_offset(dev);
>> -       uint clk_rate = fdtdec_get_uint(gd->fdt_blob, node, "clock-frequency",
>> -                                       400000);
>> -       uint clkd[2]; /* clk_id and clk_no */
>> -       int clk_offset;
>> -       struct udevice *clk_dev;
>> -       struct clk clk;
>> -       int ret;
>> +       struct msm_sdhc *prv = dev_get_priv(dev);
>> +       ofnode node = dev_ofnode(dev);
>> +       uint clk_rate;
>> +       int ret, i = 0, n_clks;
>> +       const char *clk_name;
>>
>> -       ret = fdtdec_get_int_array(gd->fdt_blob, node, "clock", clkd, 2);
>> +       ret = ofnode_read_u32(node, "clock-frequency", &clk_rate);
>>         if (ret)
>> -               return ret;
>> +               clk_rate = 400000;
>>
>> -       clk_offset = fdt_node_offset_by_phandle(gd->fdt_blob, clkd[0]);
>> -       if (clk_offset < 0)
>> -               return clk_offset;
>> -
>> -       ret = uclass_get_device_by_of_offset(UCLASS_CLK, clk_offset, &clk_dev);
>> -       if (ret)
>> +       ret = clk_get_bulk(dev, &prv->clks);
>> +       if (ret) {
>> +               debug("Couldn't get mmc clocks: %d\n", ret);
>>                 return ret;
>> +       }
>>
>> -       clk.id = clkd[1];
>> -       ret = clk_request(clk_dev, &clk);
>> -       if (ret < 0)
>> +       ret = clk_enable_bulk(&prv->clks);
>> +       if (ret) {
>> +               debug("Couldn't enable mmc clocks: %d\n", ret);
>>                 return ret;
>> +       }
>>
>> -       ret = clk_set_rate(&clk, clk_rate);
>> -       clk_free(&clk);
>> -       if (ret < 0)
>> -               return ret;
>> +       /* If clock-names is unspecified, then the first clock is the core clock */
>> +       if (!ofnode_get_property(node, "clock-names", &n_clks)) {
>> +               if (!clk_set_rate(&prv->clks.clks[0], clk_rate)) {
>> +                       printf("Couldn't set core clock rate: %d\n", ret);
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
>> +       /* Find the index of the "core" clock */
>> +       while (i < n_clks) {
>> +               ofnode_read_string_index(node, "clock-names", i, &clk_name);
>> +               if (!strcmp(clk_name, "core"))
>> +                       break;
>> +               i++;
>> +       }
>> +
>> +       if (i >= prv->clks.count) {
>> +               printf("Couldn't find core clock (index %d but only have %d clocks)\n", i,
>> +                      prv->clks.count);
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* The clock is already enabled by the clk_bulk above */
>> +       ret = clk_set_rate(&prv->clks.clks[i], clk_rate);
>> +       if (!ret) {
>> +               printf("Couldn't set core clock rate: %d\n", ret);
>> +               return -EINVAL;
>> +       }
>>
>>         return 0;
>>  }
>> @@ -188,6 +209,8 @@ static int msm_sdc_remove(struct udevice *dev)
>>         if (!var_info->mci_removed)
>>                 writel(0, priv->base + SDCC_MCI_HC_MODE);
>>
>> +       clk_release_bulk(&priv->clks);
>> +
>>         return 0;
>>  }
>>
>>
>> --
>> 2.43.0
>>

-- 
// Caleb (they/them)
