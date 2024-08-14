Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06819C52D7D
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 04:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DC7A88155;
	Wed, 14 Aug 2024 06:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723608701;
	bh=3PqHlC+3x8INAjcIQPD9Zg3c7W+uvBbaI4842JThl9I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=pZwtpqjcLm+GCnQdjIV2DBOLdKujDB1/7vykNV5ryII0DkajRs/gJZSh2eLsT+cqq
	 D6yFu1GaxHpR7bI0K5F+JbVMuNL9PJG9IFf0K/fbxwoV6FDcHlp8hb+FtQb6Ambh6m
	 h+K1ibFBONONUvr8JA73BNHc6qmkL/OUuVezC2O6DwblMeWRY1+tAjt5IBrEurlUj/
	 xX9W/JYGJ4zcIAk3eWqOs0LHN/ORCKxA4Fw2FEvjV5V7JRObj/v1h6dgrbb2bwGcBC
	 TBfCdO46TktL8FGAPKZEiiCok8CfkuI0w4sYCZ4vfLF9y/HKNis15zUlmAdSioUjrg
	 tBKCiAZGO99cg==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AE43F880A5;
 Wed, 14 Aug 2024 06:11:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723608700;
 bh=3PqHlC+3x8INAjcIQPD9Zg3c7W+uvBbaI4842JThl9I=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=XgmD988TrTVSjy9Zov/I6GcsfFUcuxzx2OiVdOIxCEvTJv1olw7fm81JL6yhKTqDT
 kuOD/u3EreytBB4/uT584Qv9CuGoYbLHbmnijGHReRKh+FB0FfDvtKpyAOaoNDL11B
 vWABS+6mW5swfP+LVVPTBKWM0ES5PT2gA9KLB/tOYnw5baBUcS5F2k5pADUOVRPihT
 wiJdHN4CRqzJtZ1B4BN6SMlNrGR29voQLBKuTxgavfElea8yR/4JpCg8FUcmK7gEuI
 2IH4Dw4q5hWIH4FdNd9Ah3XRZvJDG5CnmWDZps+ndPWZFtajRJUoxxMeUKSfy22YLq
 CzMIAIqfkoXSg==
Message-ID: <1ce4c23b-b006-afbb-89ed-dfd844926e22@denx.de>
Date: Wed, 14 Aug 2024 06:10:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] driver: pwm: pwm-imx: fix probing on imx6
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Anatolij Gustschin <agust@denx.de>,
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
References: <20240807155343.122377-1-hs@denx.de>
 <CAOMZO5A23hR6CbLbvUR-ck111iowq=BKrMz_4PHwL4hQsmyxDQ@mail.gmail.com>
 <36b5a4e3-0848-7275-134b-a0929a1fea27@denx.de>
 <CAOMZO5AHFdKxNspP1fAzpGmGPABCQeAohepg55Q+YRR-PttbCw@mail.gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <CAOMZO5AHFdKxNspP1fAzpGmGPABCQeAohepg55Q+YRR-PttbCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Fabio,

On 13.08.24 22:12, Fabio Estevam wrote:
> Hi Heiko,
> 
> On Tue, Aug 13, 2024 at 10:58 AM Heiko Schocher <hs@denx.de> wrote:
> 
>> Should we revert this patch?
>>
>> I just can say for the aristianetos2 board, that I readded exactly this
>> define in my work for the port to currentmainline ... and with my patch,
>> pwm and so bootlogo works again ...
> 
> What about the change below on top of your patch?
> 
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -14,6 +14,8 @@
>   #include <asm/io.h>
>   #include <clk.h>
> 
> +#define IMX6_PWM_PER_CLK       66000000
> +
>   int pwm_config_internal(struct pwm_regs *pwm, unsigned long period_cycles,
>                          unsigned long duty_cycles, unsigned long prescale)
>   {
> @@ -75,7 +77,7 @@ int pwm_imx_get_parms(int period_ns, int duty_ns,
> unsigned long *period_c,
>           * value here as a define. Replace it when we have the clock
>           * framework.
>           */
> -       c = CFG_IMX6_PWM_PER_CLK;
> +       c = IMX6_PWM_PER_CLK;
>          c = c * period_ns;
>          do_div(c, 1000000000);
>          *period_c = c;
> @@ -162,7 +164,7 @@ int pwm_dm_imx_get_parms(struct imx_pwm_priv
> *priv, int period_ns,
>          if (CONFIG_IS_ENABLED(CLK))
>                  c = clk_get_rate(&priv->per_clk);
>          else
> -               c = CFG_IMX6_PWM_PER_CLK;
> +               c = IMX6_PWM_PER_CLK;
> 
>          c = c * period_ns;
>          do_div(c, 1000000000);

Hmm.. yes, setting a default value is a good option, so I would add
a check, if define is not set yet?

And we should simply let the name "CFG_IMX6_PWM_PER_CLK" ?

If okay, I can make a v3 if you want?

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
