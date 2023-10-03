Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FF8E75420
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 04:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3AB28719C;
	Tue,  3 Oct 2023 06:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696307850;
	bh=9SFPNOhBlXbrAbYXsbuX72cMiUK8CIjxS4WIp2sRt/M=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=aBraqzUomi4kktAoQ3nqPXJjEip15SQB8DfFsyxXawBZlM04j9rZsNQktNkvfcjoh
	 /mButRav0MMNUZHVB31gPNNIu5l2o8uKS//SSLbgKD+zRDUeBz8Ovfc0pZR8XLm53p
	 ZOuCW/6PLNsppxpA/94uwZVI2Fp5fXTrhAOP4Ss8A6hi4rnFwo9GIa/ssmFtqsi35y
	 cZ2SC426IaNO0s9J1fONMQiJNtkbGcMJT3Y0fFcwvIw+dRtE0RME2GbTHorE3YQDnS
	 QIwMd7CJVgZLGO4ZiYfH4AkCxJwXGpB02MhjQVb4jk3CEIV1lQ+k5JkUIxew8rR6dZ
	 derUkrpjyCr1w==
Received: from [192.168.1.107] (87-97-106-223.pool.digikabel.hu
 [87.97.106.223])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E6B1086E15;
 Tue,  3 Oct 2023 06:37:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696307848;
 bh=9SFPNOhBlXbrAbYXsbuX72cMiUK8CIjxS4WIp2sRt/M=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=hamWN8YnYzGWqwyJC6LX+Fuy52f8444tus47bYNRAU/Vfa244VwTewhh//0p3CZ+u
 9cUmsB6WshifRddnPMP3MWXYpzpBX0hzjuUEFoBP62eod0INgQPWGsEOhYvxCI7QRZ
 GKGqo9UV3px72htR/sZDu5GIiVdlkzUJJsh15kTf78KZua7UgM+Kss/RU/djAZ2+/N
 d3edluZy6M9uDf5eJEG4TfgUHucxKZIFrxo/UJKXNDxTyzuuWY68LKryHTt+E6UmQG
 3OAyBUlPDXoReMIO9esgAeJJOWWaA2jpSHIaxnvqrMHVUvXQeIJK+Dt0NQJ0QW0Ql8
 qpqwGNat8PG6w==
Subject: Re: [PATCH v1] i2c: nuvoton: add support fast mode
To: Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com, KWLIU@nuvoton.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20230926090808.408095-1-JJLIU0@nuvoton.com>
From: Heiko Schocher <hs@denx.de>
Message-ID: <ec256874-0fca-83fe-d207-67e4048b461c@denx.de>
Date: Tue, 3 Oct 2023 06:37:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20230926090808.408095-1-JJLIU0@nuvoton.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Jim,

On 26.09.23 11:08, Jim Liu wrote:
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
>  drivers/i2c/npcm_i2c.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/i2c/npcm_i2c.c b/drivers/i2c/npcm_i2c.c
> index ea4ef53256..b867b6c8e9 100644
> --- a/drivers/i2c/npcm_i2c.c
> +++ b/drivers/i2c/npcm_i2c.c
> @@ -517,11 +517,6 @@ static int npcm_i2c_init_clk(struct npcm_i2c_bus *bus, u32 bus_freq)
>  	u32 sclfrq;
>  	u8 hldt, val;
>  
> -	if (bus_freq > I2C_FREQ_100K) {
> -		printf("Support standard mode only\n");
> -		return -EINVAL;
> -	}
> -

Is it so easy to enable fast mode? As original code explicitely
says "Support standard mode only" and returns -EINVAL?

And please add some text into commit message, may you can explain
why current driver supports fast mode?

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
