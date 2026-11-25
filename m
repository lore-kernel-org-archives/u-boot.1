Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CDB606A321
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ikQzL6u0;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qqtqF3RB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C1C280827;
	Wed, 25 Nov 2026 08:28:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eHsV4i1YSmJb; Wed, 25 Nov 2026 08:28:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6D054807EF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795595304;
	b=ajmdGAqc7O4t/Pp/xW+w0YQdJpe90vmWAk09J4QNpnYvRWliT3FxRyMsGsreHXLFBl5R
	 bYvYKzyjx40QztSkR3idAk3j7SOF97yh8MQbEnI8M0NwCfJyfx4T1StdV18xCM5pskn7x
	 XUYicm80Gm4OZTZU91IqAn+hJ/fvzCH6V+Bv0Jx8aPW1+hWkYaGahZx1FSt1Ev7HjlTzN
	 L3Z9rsLMNT5TJBc4mONPkwMZFdnFcrbPld6lxMop0GE86uKvArpXIATItzihLg8hhn/FR
	 kH+arBnv8AGUxfqdksX1C02g7yUMKfgtI/YoJrLiCQqHRFRlmyAH68sf7ugHfuDEDZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795595304;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lUs5OBO3K6YughEWZKSjSx/Pe0FkwR3GzhUx3M44A9Y=;
	b=Jo+sIr/nhuJMCmnYX6+HwaHUizHXQaDmEJ5ClMs+P+yBu+naMXk0kwrAE5j0mVGOk4Sa
	 ct4r/ibGLfyPHxWSzjCeK+RgKxl1hI5QI9NY4TssCrdKbfPgGlNf820m3MFkwyio2FBoy
	 h+y1S4aC1ZahUinAAq8H7C1EfJtlrL4GgbxLv/pTJ6illjJNsV9Af/x35AI1Y9MS4uMmb
	 Z5nlS2xnzNcWToRKXmemFoYSc3BHOu0VtZZ2D73sar4cJhKMhyFjQb0Q/mGlzn7u8HorF
	 DouKbyRm5nPmYakZQrPzkBMVSxGRJlVGaQGEDMSSYvadAIajFEWAdsCo+w3xHNLTY5g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795595304;
	bh=lUs5OBO3K6YughEWZKSjSx/Pe0FkwR3GzhUx3M44A9Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ikQzL6u0kTvLOu99eHuCOhhJQNc3WVct7MnaVgG2o2f+paHWbLzVYE3IgT06rVNJv
	 dgHKQtPV9MhiSvvatsL75XXflfsD+4gJW8SzlE6oFL7LG4sFRx+Cy5OPfEkOPNQ9wb
	 d9ine0idRiCFsoB11hviBHVAwwFWECVvaq+CvlrBxY8ux+TRAoGyosarfzotbrmXYT
	 4w1bvcKjcNTuuN6TI777N/cbeMGz9guUcfraBiptK11zBtBqCUYaNPRmtBJ7Q7Gdls
	 W15X1CneSyFeul/jejPcM+ROdwc4Ufvc7xg0n/wpDRquuZqi+bFElvlTOk8A/JiljX
	 clOzJGah7iphw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D054807EF;
	Wed, 25 Nov 2026 08:28:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E6A11AB
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 08:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0BFC7606A3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 08:28:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BROyMShl_7gA for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 08:28:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 28B2660627
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=qqtqF3RB
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 28B2660627
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 08:28:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 4E59AC2BB3B;
 Wed, 25 Nov 2026 08:28:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8182A60480;
 Wed, 25 Nov 2026 08:28:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2105C11E6993C; Wed, 25 Nov 2026 09:28:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795595298; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=lUs5OBO3K6YughEWZKSjSx/Pe0FkwR3GzhUx3M44A9Y=;
 b=qqtqF3RBz79Y4KmXpvLkqOZyJZPFfOEdN1bF++lXvvg3gZVL2toeibtrSEvE7XXtFiF9bR
 NPNr7krjw5fHe/zcBQXLLmdgQarKs/0MMTeKno9usV0H7ySt7+CJIzHAPDt2LGJWJqKJLG
 6f9oL70vAkxnV4PXAMYYJi8kvloxVboS3IOGZO5oHUpGn+aaWxUCwQJ8Nalrny6LLptG6T
 d9lTS6awj8lNX6VPaPZj7iVQKcnUOdtBOvh6Uvw/BlaoavWbRnRdIkrYvdjPDJc11isrXo
 AC7Zu6BwALK7ek7qI1dMp07L2PzP/8dcbg+/k+xTXrpjHH76yuI6z3vr4QTrkA==
Message-ID: <a3410822-3627-4645-9f54-26e5abf22aa2@bootlin.com>
Date: Wed, 25 Nov 2026 09:28:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] clk: synaptics: add Synaptics sl2610 family clock
 drivers
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Terry Zhou <terryzhou05@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker
 <jbx6244@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Michal Simek <michal.simek@amd.com>, Linus Walleij <linusw@kernel.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Chris Packham <judge.packham@gmail.com>, Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Lukasz Majewski <lukma@nabladev.com>,
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Peng Fan <peng.fan@nxp.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>, David Lechner
 <dlechner@baylibre.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Torsten Duwe <duwe@suse.de>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Yixun Lan <dlan@kernel.org>,
 Jisheng Zhang <jszhang@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
 <20261123-sl2619_base-v2-5-9e3b28c77cda@bootlin.com>
 <20261124183429.GX3176972@bill-the-cat>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20261124183429.GX3176972@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le 24/11/2026 à 19:34, Tom Rini a écrit :
> On Mon, Nov 23, 2026 at 03:22:04PM +0100, Richard Genoud (Synaptics) wrote:
> 
>> Introduce Synaptics sl2619 clock driver.
>>
>> The code is based on Linux driver by Jisheng Zhang:
>> https://lore.kernel.org/lkml/20261115102401.3520-1-jszhang@kernel.org/
>> It has been kept as close as possible to the original Linux code, thanks
>> to U-Boot CCF.
>>
>> The main difference is for sl2610_soc_clks_probe, where we force_probe
>> sl2610_aio_clk and sl2610_system_clk, to resolve dependencies.
>>
>> NB: this driver has no compatible string because it is bound by the
>> system controller driver
>>
>> Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
> [snip]
>> diff --git a/drivers/clk/synaptics/Kconfig b/drivers/clk/synaptics/Kconfig
>> new file mode 100644
>> index 000000000000..295a126ccea5
>> --- /dev/null
>> +++ b/drivers/clk/synaptics/Kconfig
>> @@ -0,0 +1,12 @@
>> +config CLK_SL2610
>> +	bool "Synaptics SL2610 clock driver"
>> +	depends on CLK && ARCH_SYNAPTICS
>> +	select SOC_SL2610_SYSCON
> 
> This option depends on SYSCON so you can get invalid configs here. I
> think you need to add select SYSCON here, if it's required rather than
> optional.
> 
It is, I'll fix that.

Thanks!

-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
