Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264D1EEB560
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 19:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED8986A6B;
	Fri,  8 Sep 2023 21:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="YCSWZrIM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31A2586A80; Fri,  8 Sep 2023 21:06:42 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95E8586A1C
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 21:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694199995; x=1694804795; i=xypron.glpk@gmx.de;
 bh=RdAhEAWyjTkpLA58ppjyUOMWj7qVS149qxXl8lGvfRU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=YCSWZrIM09DwwQxxEjAKtUvUqWaIEUawehEMLfCkcXo3HBFtJk3h1m8mZRkobbyCkc+8FdF
 Pu1AvsVUkQyoHSt7HVvekmivcbbz9thWfbTZcdCusfkxQgRzG+DaJFOKnkZRrXwwwXp0IIJiy
 PtdSK1BIsXmZCEDQSBk3VA0zDx5l+zkWOMzstldH6gRhSlC1F3I+wcuF1TkChJ/aQKXqG1COx
 k+d7E3TmGte0Wssg6sZmWbQVsPTHQJj6xOTTFKyeq8yzkimuu34BysGngAGRhE5meCfZXjPiO
 7wmhyMFxk70r1SuH19pnRH/tE+fDQOfI2RPOY5MQxqaUfjolgzjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulmF-1pn8ie3CNP-00rpIT; Fri, 08
 Sep 2023 21:06:35 +0200
Message-ID: <99b66fba-e92a-4a6f-b1f7-428d814d402a@gmx.de>
Date: Fri, 8 Sep 2023 21:07:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] rng: stm32: Implement configurable RNG clock error
 detection
Content-Language: en-US, de-DE
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de
References: <20230907162200.205602-1-gatien.chevallier@foss.st.com>
 <20230907162200.205602-3-gatien.chevallier@foss.st.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230907162200.205602-3-gatien.chevallier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aShp9z5e5H2RoDLKXaqmg3xg8eRU9tYPJuIPv/iWyPzWsP8LAcZ
 WndZl2lAeWYhl+Xx9HT0Xp175XnZMMbDb+Y3fJRlC+QIl0mpCjMGssQTXrxgUwk92668mK0
 VQ+ini3RrXdlwvUT+EiMhVu4DIOZNmpfPtax5qbcpuzd0HevmCCHkdPeJmf9teQvSlCunpe
 yWDGBry+QNEzqYlBou3tg==
UI-OutboundReport: notjunk:1;M01:P0:OHf3BlVq7lM=;zo4xDZdl+XItKdtbB+QHuSlZrKS
 YxY2hfEvgAbj3wiPDQRE4ZfMktZeMwCUkM578a7mWlPCL5mjiOeXX5yNfABWz6xvPEYf3xuSD
 /6HeUKBu2It6rcNcJCQI9gH9royf9MPt5WATnNKvECmdg89S3qn9ATpa/IwuNQQqV0XqSXJpU
 1X9fbEMGtMlW7/8JWtWDvtegr4nD06Qhg4qhpBrexZlLXCH3EGOIF+WZAWWIXgWzn11rsiV85
 4d58IB8o8eIIB2t+BwUnXDNeilL7hmqNDVLJF3Te8W3Cse8zgo4jMrFIW26cuopuuqhuCessq
 MgJsCmuusNTV1WSjgkbZ2jnh+AE1W09yz0MLCmQ7nfVVWKp9Yj45FxMGtm8FtdCShX1o1lKmo
 o33myt/XiSGSj59fOdZCUH63e+2/VvnJe6lVdssG6gpl0eYn2j2S4KjJhOLK2eqxKqfNLiltc
 /xzA6mU1Q331Or/4cRpx/lvv+xVKjvoFZAmsa9oiQMrypVDTtP/EWSccIE+6A1HfmNyxOTA/c
 pIlNq4nH9M575a+uZx0BkKBKbBtLMfEz65gUilXL1+F6SJZR3tUQigDtqsa9i91fNQaLcNZES
 T3HxerCxXuUYw3+fZR6wb5ro3BoOOp49u8MGHs7G3Kl9yLEu61diZjPw0TI1FkmmPM8QPxmCH
 vEtfRq5MXQeBAqi4J3+74wKCFw2vFNPA1qmvyDtcAxyv4+uYVlc6J7BY71vJQeXSkmYIFO+49
 fCCaSiN7/rIgYE452PUSh29efRbRslhHc4/LXknobYfF/p4+rsQx0fY1d3i6kSTV4suUec3k5
 ocuJ8LreNvAQdlAJ3QO9eCRmWSKSIImPj366H16IQDp3EGRmVKAASE0vs4wU6dG7ZeaDeePY2
 7iOjyyTuu27dsgsfCDnf4QkZVZ1BD6aYZycMuJ4GfDScJGpAsyJnediIyigowpE+P/1sCe/85
 ZhQhzFcMzuiyN8zQG8S8Q3QZvWU=
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

On 9/7/23 18:21, Gatien Chevallier wrote:
> RNG clock error detection is now enabled if the "clock-error-detect"
> property is set in the device tree.
>
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
>   drivers/rng/stm32_rng.c | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/rng/stm32_rng.c b/drivers/rng/stm32_rng.c
> index 89da78c6c8..ada5d92214 100644
> --- a/drivers/rng/stm32_rng.c
> +++ b/drivers/rng/stm32_rng.c
> @@ -40,6 +40,7 @@ struct stm32_rng_plat {
>   	struct clk clk;
>   	struct reset_ctl rst;
>   	const struct stm32_rng_data *data;
> +	bool ced;
>   };
>
>   static int stm32_rng_read(struct udevice *dev, void *data, size_t len)
> @@ -97,25 +98,34 @@ static int stm32_rng_init(struct stm32_rng_plat *pda=
ta)
>
>   	cr =3D readl(pdata->base + RNG_CR);
>
> -	/* Disable CED */
> -	cr |=3D RNG_CR_CED;
>   	if (pdata->data->has_cond_reset) {
>   		cr |=3D RNG_CR_CONDRST;
> +		if (pdata->ced)
> +			cr &=3D ~RNG_CR_CED;
> +		else
> +			cr |=3D RNG_CR_CED;
>   		writel(cr, pdata->base + RNG_CR);
>   		cr &=3D ~RNG_CR_CONDRST;
> +		cr |=3D RNG_CR_RNGEN;
>   		writel(cr, pdata->base + RNG_CR);
>   		err =3D readl_poll_timeout(pdata->base + RNG_CR, cr,
>   					 (!(cr & RNG_CR_CONDRST)), 10000);
>   		if (err)
>   			return err;
> +	} else {
> +		if (pdata->ced)
> +			cr &=3D ~RNG_CR_CED;
> +		else
> +			cr |=3D RNG_CR_CED;
> +
> +		cr |=3D RNG_CR_RNGEN;
> +
> +		writel(cr, pdata->base + RNG_CR);
>   	}
>
>   	/* clear error indicators */
>   	writel(0, pdata->base + RNG_SR);
>
> -	cr |=3D RNG_CR_RNGEN;
> -	writel(cr, pdata->base + RNG_CR);
> -
>   	err =3D readl_poll_timeout(pdata->base + RNG_SR, sr,
>   				 sr & RNG_SR_DRDY, 10000);
>   	return err;
> @@ -165,6 +175,8 @@ static int stm32_rng_of_to_plat(struct udevice *dev)
>   	if (err)
>   		return err;
>
> +	pdata->ced =3D dev_read_bool(dev, "clock-error-detect");

The kernel describes this property in
Documentation/devicetree/bindings/rng/st,stm32-rng.yaml

Which patch is adding it to the U-Boot device-trees?
I can't find it in this patch series.

It would have been helpful to send a cover-letter with the patch series
to get an overview of the changed files in the patch set.

Best regards

Heinrich

> +
>   	return 0;
>   }
>

