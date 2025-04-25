Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD841C369D3
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 17:17:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C5628295C;
	Fri, 25 Apr 2025 19:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745601409;
	bh=2uJfMdHq0cNmDxvR7q06QtLAXjLSWUvf01YZVEPhDpk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JI5EjxpqE6FWEzsf3X4AUVPa9KWjjHHOeqYMERE2GUgBOjvvAIcxFUOIiejD1p3+C
	 M9kbgk5krX67lHUqRLff2QWA/oecxle8t9e43f4iIc7RNrSspVQaXgHyO7r5yJJhRh
	 LS2KpqoVh5foSv/SNIpwNdm5h5Tz8GQEZzpB0q/khzbf/OThn85OXuOZCTiEOkFJl+
	 N9CGBjtRzagDB5QMIGxDTnNOaRXpz1d1aahyD/NkX/N46c5Fw6ZD8bwXGUUsOF5ZBK
	 476y7EJPLNcr5p+ts7FPBcnYcyIR29DFXJ5cCBbmYHsMv2+kcRt1TTMpmGJEgk1VN+
	 Xd6vGEmSARABg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 620088298E; Fri, 25 Apr 2025 19:16:46 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D4CF8295C
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 19:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="cIYjgOLo"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7FCF210271412; 
 Fri, 25 Apr 2025 19:16:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745601403; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=2uJfMdHq0cNmDxvR7q06QtLAXjLSWUvf01YZVEPhDpk=;
 b=cIYjgOLo34ZiUJGC6CG483j8xAbp5uVC3t4PZbf42r1Gxy0sWZCs7DH3lVkQnIgTh34nQV
 6CPrt764N5ZkcXuOUxL57xPvx1nbcxqsTCFzKrJWrdMRewnjiqTDlmQv8AUN+p5oRHIeUq
 xXdYgORI8f4Y/m1pKrNgjeRNTxMjZeRItmCuFqpNaP9UHy37/VRcWYewUqt5d9r3QKhUC7
 Lbo61JcuJA2rWadEqQljkixpClTeySwz2HHiF9q/HIYgbAh15ukwDdlFsRt7VSq1w+4mvW
 ZOnR932cHTb2WEd4DLpeuITfsfa7bjnks6HFvxt/GEJc0jFmGCFcfxTp4NyveA==
Message-ID: <3d7c1428-5c47-4d54-b32c-d77f79a3b1ff@denx.de>
Date: Fri, 25 Apr 2025 19:13:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Fabio Estevam <festevam@gmail.com>
Cc: Adam Ford <aford173@gmail.com>, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, francesco.dolcini@toradex.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
References: <20250417171101.2566447-1-festevam@gmail.com>
 <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
 <CAOMZO5C_9yojvxO1NoNjtTHxD85ZcGd_cK2t-rofyY_Zxm1xcg@mail.gmail.com>
 <CAHCN7xLkDnLX5PHFNjXYn7AFXA5+S22aksgv62PpWpg80ZDQmA@mail.gmail.com>
 <d81112ad-017b-491a-b517-de828dd30c25@denx.de>
 <CAOMZO5CpQ-yv=8GhNv7=yjnA+uzzP9ZmB=P2d+xmhY1ktQJX9A@mail.gmail.com>
 <28b4bb24-4c56-4fe3-ae9b-db43c63290b1@denx.de>
 <CAOMZO5Cz1atyi0OSOrzUfSGiLb-9XdnyX-d8L7un5PuAdkBeBQ@mail.gmail.com>
 <703a0297-24b2-42f3-9fa7-62a78e38f1a2@denx.de>
 <CAOMZO5BitKDL2QRAzBuKK9rdfPsob_jdsYx86CRXJq8RjC8xoA@mail.gmail.com>
 <CAOMZO5B6V4=5et8XpnN0-TkaCSLaiAf2sRw8C+_H97LeU17U+g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5B6V4=5et8XpnN0-TkaCSLaiAf2sRw8C+_H97LeU17U+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/25/25 2:55 PM, Fabio Estevam wrote:
> On Thu, Apr 24, 2025 at 11:35 PM Fabio Estevam <festevam@gmail.com> wrote:
> 
>> I haven't had a chance to debug this issue yet.
> 
> I applied this debug patch:
> 
> --- a/drivers/mmc/fsl_esdhc_imx.c
> +++ b/drivers/mmc/fsl_esdhc_imx.c
> @@ -1539,6 +1539,7 @@ static int fsl_esdhc_probe(struct udevice *dev)
>          }
> 
>          priv->sdhc_clk = clk_get_rate(&priv->per_clk);
> +       printf("****** sdhc clk is %d\n", priv->sdhc_clk);
>   #else
>          init_clk_usdhc(dev_seq(dev));
> 
> With the top-of-tree U-Boot, SPL calculates the wrong sdhc_clk on the
> imx8mm-evk:
> 
> U-Boot SPL 2025.04-01380-ga9820e12db18-dirty (Apr 25 2025 - 09:40:45 -0300)
> No pmic
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
> SEC0:  RNG instantiated
> Trying to boot from MMC1
> ****** sdhc clk is 204522251

Look at cmd/clk.c and import soc_clk_dump() into this driver, and then 
call it here, so you would get the current topology of the clock tree. 
What do you see there in the output ? Please include it here.
