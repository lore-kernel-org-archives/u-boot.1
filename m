Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91662606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OMtJzmO7;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Xugj3jS1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60A72605E3;
	Mon, 23 Nov 2026 13:27:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lmdvAYF8bge8; Mon, 23 Nov 2026 13:27:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8D4F060673
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795440474;
	b=evoDAb6rfamzydWLIuRTGsZRAYO9x+3AU0w2sJwvt5yb03/80fcLb4NEv43Y9bIPi2rf
	 jtOrL8df8xP20zVWK3D3m4DRwpAUZv1xqMh/lVb6LUnmEwK1VS6qR165TRzbw2mC4WIk+
	 qBfx7i/mfr4NeMFpzzynlzdyam8fQC34QMSJC+zI9AgJOf3X2a/GJOb36s8s/AJL7jrtY
	 pZBn/RVQvwwGvuTMm+rtUaNkg0awuVn3X5YiM1jBg0TbXMJRWFvIA2DLkb7zVqlW995vS
	 Ee+OWffWgwRnpctV4ulyV3t6CNr91kB1OTd683VmyAap9abpVUhomxkZ5JRe3/K6aKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795440474;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Jo9sBlCpStL19h3JKuY1DiDdv+XS6X4s7POBQ8DwY4k=;
	b=UXm8C5lDZukurjHTt6rfdfqBNZheLIYLpDYmdn525UC2mo64G0Dc+Hlz8JQbPydrKsE+
	 I6/oYswVQJvlVBkIoI2NaUdG1KG04N8II/KKsQaP+o8qtfo8vjijYJJfjrwJ2Mxb14YfM
	 uOcrb41Br+ZxrD0tdrHxBfPRIE3IYdPv9yeaRxz63bbp6Eo2pE/ML6SZidzAghNcZboWs
	 g57Iew6RzF9oqa+2OIoQ3pog+f9uN35ndRtOZBFF7mHdHPv3quYbSA/Rq/4VR/trmJdVE
	 2BTJmi2/ZtlK78tyv2o3zeNgx36pEG9bs1xH99fya4RBd4D7aLDJWHLrEbsBYbcXmuQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795440474;
	bh=Jo9sBlCpStL19h3JKuY1DiDdv+XS6X4s7POBQ8DwY4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OMtJzmO7UIRXH8dTo5kdaBihl8aVtWXwVChB9/Wf7HQWmms9TGtvirOPk00e+k1fH
	 fr3ZdPBFWl9jkfV2YCuqUSN/CPQ/py+5T+pQ2OAjaFSqY9xKEO5+9vehlk/b22ZWgz
	 Yx+PaynTXIXgxjtucVScA7cn8iQb9Whzc+Jj/oKcszqfZLCNg/WhXUbMqQ6RlEjcBF
	 glQAtfms5RBh/rjNLPho/NNlGT14T4qI7Sv2Vy92vEZPM3FVBcqxc2meFvLoOyODdK
	 UK6HM+H0f7XnOnoPZOU+N4boKAWcGzQ+3Nwa+ICJiAZCjEgErNP4Z4ooAA4qmn+alH
	 xYVPe+dYeI/KA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D4F060673;
	Mon, 23 Nov 2026 13:27:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 50BE7371
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 421494071D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:27:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r8TXTIf_q4pH for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 13:27:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2A8B44071C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Xugj3jS1
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A8B44071C
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:27:51 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c50d3ac6b51so874451666b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 05:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795440470; x=1796045270;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Jo9sBlCpStL19h3JKuY1DiDdv+XS6X4s7POBQ8DwY4k=;
 b=Xugj3jS1JTc6P1KueY6FJzTmdC4G+j+6jvkn3iofZ/qLsw1IN7BYJnPOsY0s0hR/46
 Phbaf4XBZUWObc8E5r2urYjcqyrUy+s4UJal+vqpXwraxzJaWihNXotxVH/BfmDZEHdl
 EY3y+zfAEv8xPELulnO2AblSOJhHZXT9+90cnoyDOgT7m7oD46b2JrUz2LZOy/va2HZ3
 v7AvvPluNm5ImgJz4youBTOMJdPAHVhDfD6fFFtnbw5fRpA3qjL4S4Dqb2Eg99W2w4Xu
 7gRBgJrukZp2HUJ9RC6C5f/EWE5LZxp/ycZqkwHtRlsqYCPfv+7ACIj3+ml4EHGh7uc9
 Hn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795440470; x=1796045270;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jo9sBlCpStL19h3JKuY1DiDdv+XS6X4s7POBQ8DwY4k=;
 b=k4uNWd4GWAZB7dPYJ/wGHJZUk3Mw0+FdudV7HWSSd7KdP/bcAgRr87g9D2A8bfoHPU
 9VUCKILkErX7IbDfVfqecWzeNWHbSzvTJm86Ji0852GQv6UQQdTT6UHyKmXg5dqgGoAe
 fLDniQIeTwOBo9RrLq/ocLn2StZihXHGCr8bAZb1w+j9kiYRrSRGI0SWQ4wCKSHRbfgX
 wEgC44Rfz3j2a0KJv0mQglUHHRBT2zrFYsYcI5KpKtrtAW8QV11/f4i8gxUv7qZ23RIE
 KIGAP0uqFPmBfpZvfKme4HKZMh6/SRbWjPcmJAVRyZ9OHkMIO5rEI7kTcI6XVHCFiQYl
 y0ig==
X-Forwarded-Encrypted: i=1;
 AL+hErEPIgpf9kTbyNbfj+nbV37zGvvQEyUx8OVekuYET3TLpNx/Y9Zv446Vysg4iRnx3k48YnYchcs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z832e9VgpN0Qij/uuKVA+cI9ksIr3QbaGCq2yvEStfpbQqUHxTq
 ssbOlGix5e39dMBej4Zeg8cNvtWakkAsow2gWxXmIXyv09Nr6ywx8UfkeuT2IqdPIzE=
X-Gm-Gg: AZFdTZeYfECI8j4oI70y+7iqHljaLdo+yzMGO/ZTYUuILh2ioLBtPX+QjH7glpcZIG9
 9cPdqmi+qOuihAALDOtMZkSK3JGINhrrog2ATTf1TJ+NXzIsFCjbcDtsAE7CTzARRecWjFOCBZ6
 WLCMJ5wgJI0+/y8P+WJbgsAf8bj7GOvZWMCtTZraDn8y/XQVpWQBZjYSGmWNiNqB6l6+xpZbl0N
 yqkDdO6/vQ59p/xHlTogS7x9FnVBFhPcs5hlletKTHGCIg2odeVruuRWyHeJswBLYzPhZFhqryJ
 kM9KddfntuKR3PpD5L9pDnA6qHRALdbXRM3cf6lx7UrLrzSZ890qPwftWui+79/i7yIARJnNn1S
 S4V6ZgOQrOStIP+iF//0Tporfwua7YsYcTuvfS0Tn5ENCrJ1n3RrcEeyOVeoXCUcM61TkAau+Ss
 g1FKTyeOwDpe593y8jivYTTePs/BNGJ0gVvZPaYN+IYLdm1LGmXJaCCkhDf18WbX2OxXpLKLQKD
 2u/2U+mVzd8Kt/8H8JRvafQxXbH11rS+KOBmJagczvgdEMcz4F+bQjwYQoH4qklal4Xk9Sgr4gq
 JMuZcAJPAkcSYG9ppcpgDZibdU9CJ38JZORJi/ds0+ypLF0kxAQ2Phhsgj9JSQ==
X-Received: by 2002:a17:907:6d26:b0:c51:50c9:741c with SMTP id
 a640c23a62f3a-c5150c98208mr708738266b.10.1795440469779; 
 Mon, 23 Nov 2026 05:27:49 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff25:4f10:c1b0:1199:e313:6fb5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae8d0dbsm417819366b.31.2026.11.23.05.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 05:27:49 -0800 (PST)
Date: Mon, 23 Nov 2026 14:27:47 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sam Day <me@samcday.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] mmc: sdhci: delay the status clear after a
 response without CRC
Message-ID: <awQ_U60Q5mJbTJVj@linaro.org>
References: <20261123-msm-sdhci-wait-send-cmd-v2-0-5de53eb34ff6@oss.qualcomm.com>
 <20261123-msm-sdhci-wait-send-cmd-v2-1-5de53eb34ff6@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123-msm-sdhci-wait-send-cmd-v2-1-5de53eb34ff6@oss.qualcomm.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 09:57:01AM +0100, Igor Opaniuk wrote:
> The issue was observer on Qualcomm SDHCI controllers, where the
> first CRC-checked command after an R3 response (CMD1, ACMD41)
> fails at once with a command CRC error:
> 
> - SD: the CMD55 after the first ACMD41 fails, the card is not detected;
> - eMMC: the CMD2 after the last CMD1 fails and only passes on the
>   MMC_QUIRK_RETRY_SEND_CID retry.
> 
> The R3 response leaves a latent CRC error in the controller. It does
> not show in the interrupt status and does not go away with time. It is
> removed only by a status clear issued a few SD clock cycles after the
> command has completed, and the clear in sdhci_send_command() comes
> earlier than that.
> 
> msm_sdhci hides the problem with SDHCI_QUIRK_WAIT_SEND_CMD, which
> delays that clear by 1 ms for every command.
> 
> Wait 16 SD clock periods before the final status clear of a command
> whose response carries no CRC. Only CMD1 and ACMD41 are affected.
> 
> Tested on the Arduino UNO Q (QRB2210, eMMC, identification clock
> 188 kHz), with a status trace in sdhci_send_command() and without
> SDHCI_QUIRK_WAIT_SEND_CMD. First CMD2 of "mmc rescan":
> 
>   Without this patch                                 CMD2 result
>     as is                                            fails   6/6
>     50 us .. 10 ms wait before the CMD2              fails   3/3 each
>     final clear of the CMD1 delayed by 1 .. 8 us     fails   6/6 each
>     final clear of the CMD1 delayed by 12 .. 32 us   passes  6/6 each
> 
>   With this patch (85 us at this clock)
>     as is                                            passes  30/30
>     1 ms wait before the CMD2                        passes  10/10
>     10 ms wait before the CMD2                       passes  10/10
> 
> Reported-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>  drivers/mmc/sdhci.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> index 97de02c262c..ba355096761 100644
> --- a/drivers/mmc/sdhci.c
> +++ b/drivers/mmc/sdhci.c
> @@ -346,6 +346,19 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
>  	if (host->quirks & SDHCI_QUIRK_WAIT_SEND_CMD)
>  		udelay(1000);
>  
> +	/*
> +	 * A response without CRC (R3) can leave a latent response CRC error
> +	 * in the controller a few SD clock cycles after the command has
> +	 * completed. It is not visible in the interrupt status, but unless
> +	 * the status is cleared after it has settled, the next command that
> +	 * checks the CRC fails with it at once (seen on Qualcomm SDHCI). Give
> +	 * it a few clock periods before the final clear below. Such commands
> +	 * are only sent while the card is being identified.
> +	 */
> +	if (!ret && (cmd->resp_type & MMC_RSP_PRESENT) &&
> +	    !(cmd->resp_type & MMC_RSP_CRC) && mmc->clock)
> +		udelay(DIV_ROUND_UP(16 * 1000000U, mmc->clock));

Nitpick: Maybe you should put this into an "else if" of the above
if (host->quirks & SDHCI_QUIRK_WAIT_SEND_CMD) check so it doesn't wait
twice for platforms still using the quirk.

I'm also not sure if we should make this conditional to QC platforms (or
another quirk), although presumably the application of the new delay is
fairly limited and fairly short.

Thanks,
Stephan
