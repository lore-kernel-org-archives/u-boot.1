Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D274606A331
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nX2IUWcB;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kpnhNnjp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9FCF80D81;
	Wed, 25 Nov 2026 08:24:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Q0yjkZ3b0MS; Wed, 25 Nov 2026 08:24:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C7D2680D3E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795595089;
	b=Il0EhOC1y0Xf9bVcd5QqJvssbdMY+P0C6wOS7RwaIzZcOx3c0yocKkISQDwObZMzK1ES
	 Ghe+AOdvb16oSuhBVYGcN5Meb5htjocxhPk2x6fii3xMRKcFjvN325I7GJCISuVTnGqfV
	 Tifl6M6yApAawzHoHoVLqJaH1t2mdxO12p6klA9tDMGTTcgljkUfrmdPCmzYLMT1JhdHD
	 AJ3+V+Cqlba+OJefKI05AGjUCiJTvf1q9OAsRQR5A/Lq94mSRzDFWFo2alDQsIYk7la1V
	 V5eW94MzygPKJ3KZ4fHVgr/tu4FE/CrSmVI+fNN97nL37uEgAb5EUnO1/k8HIZGXkUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795595089;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Y77xhCIi2jIiRTEJFWtx5fbWL4bF5Vr2B76D3N7k7ok=;
	b=ig09W53RpffDiHxKDwUoIgUhbTOc742HesDh8JcB16/rhqi7lccKjgRMJU29f+wIfPsN
	 ypAeT2aly2/a0h+6z2VQIKUYlYqu0LE37COXWMtB/tL2a7N5Bh9YIaa1C1xkKpWdbRw2d
	 LUrYDpZL7ngw0+WbqU10bxNqj+V50pxGUfO0F262uJHoMDiPXP3rC4RvZwWIE18uFn34X
	 VfSBFslexxQMIAqTpc5M8rHpeGhq9mSdkwqlZbw+7ssRdqbtYu9S20PotlZLiJ9+zJMYK
	 ZwYmZZSRa9M/NEL+IyFYKOYmAxJXcWZKmadD4uPuij/bPjcxMateRCnfORHMV65Hggg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795595088;
	bh=Y77xhCIi2jIiRTEJFWtx5fbWL4bF5Vr2B76D3N7k7ok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nX2IUWcBdmAVJrDd85XFWEyg8E8pOtnb4vN7NEZYZ+W+SegcqyEW0sEvgTywkGi5o
	 wXimtOGJtxwsaWGICKf6EYDTRFWmIioPxySkcSFNou+lfOfmawmdz0Nev05XyuRbQf
	 VMTDlIBb7DQ3OrIfXYbVWVqNzZ7mkHIyls5OIJc2Nv7akE22rrDYd4kcZ8MNDwhpM4
	 +jG7N8+jGiHTLENehwo8T8UmBSOrgsn6nL5L+t1214V73LGwI3iX3yjK5eJ3VlDwlg
	 MBP2vKKheao2h00Ruidbo7XRpUhzF+XLcWo0xnw0ShbF9sOoxZhxUORFW/uEQrYHy5
	 PyrVeP1huGqkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7D2680D3E;
	Wed, 25 Nov 2026 08:24:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D1AAF2F5
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 08:24:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B7BE56069B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 08:24:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id In0p2UDj9DaE for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 08:24:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 48A2660627
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=kpnhNnjp
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 48A2660627
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 08:24:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id A811BC2BB3E;
 Wed, 25 Nov 2026 08:24:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D58CB60480;
 Wed, 25 Nov 2026 08:24:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AFFA611E69AFA; Wed, 25 Nov 2026 09:24:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795595081; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Y77xhCIi2jIiRTEJFWtx5fbWL4bF5Vr2B76D3N7k7ok=;
 b=kpnhNnjpWxkzgBSQ1HAziNtuCHvhm0HE4y8PJqMoSM3AZsa0YiPhf45BufcupuNkryHgzQ
 DyGmlMPHs9YrKNDV6s5wwrXwXIIjsaW8VaxoBQNjRMCXYFykTByHdgfnV2I2vL2PLlK8FY
 qfCWy4WN2k0ExDtizo0njSAKgmu82x2lqDrTkFX4jlsEJnRmZ10QTgDECLEgtcB8mgz7mR
 X1XUdT67F8w1/WgYq4V0BhviRFpJHB4HDnGy2iziCswekezot4osA7yxwtgRrGYNVFjquv
 J3c9+vmOZIu4CJRSMWtOhzwk5hOfsu0AYpIAbH0fLwXJk5gfUnFZ9zesWbtUrA==
Message-ID: <aa14819d-1ca7-4140-a146-5bb2824ebf01@bootlin.com>
Date: Wed, 25 Nov 2026 09:24:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] arm: dts: sl2619: Introduce sl2619-rdk-u-boot.dtsi
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
 Ryan Chen <ryan_chen@aspeedtech.com>, Guodong Xu <guodong@riscstar.com>,
 Yixun Lan <dlan@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
 <20261123-sl2619_base-v2-2-9e3b28c77cda@bootlin.com>
 <20261124182800.GV3176972@bill-the-cat>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20261124182800.GV3176972@bill-the-cat>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le 24/11/2026 à 19:28, Tom Rini a écrit :
> On Mon, Nov 23, 2026 at 03:22:01PM +0100, Richard Genoud (Synaptics) wrote:
>> Setup console before relocation
>>
>> In order to setup the console before relocation, bootph-all is needed on
>> sm_uart0 and on its clock provider sm_clk
>>
>> Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
>> ---
>>   MAINTAINERS                         | 1 +
>>   arch/arm/dts/sl2619-rdk-u-boot.dtsi | 9 +++++++++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5f66db5d4608..279193e8239e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -712,6 +712,7 @@ M:	Richard Genoud <richard.genoud@bootlin.com>
>>   M:	Terry Zhou <terryzhou05@gmail.com>
>>   S:	Maintained
>>   N:	synaptics
>> +N:	sl261[x0-9]
>>   
>>   ARM TEGRA
>>   M:	Thierry Reding <treding@nvidia.com>
>> diff --git a/arch/arm/dts/sl2619-rdk-u-boot.dtsi b/arch/arm/dts/sl2619-rdk-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..72e2adebde3e
>> --- /dev/null
>> +++ b/arch/arm/dts/sl2619-rdk-u-boot.dtsi
>> @@ -0,0 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +
>> +&sm_uart0 {
>> +	bootph-all;
>> +};
>> +
>> +&sm_clk {
>> +	bootph-all;
>> +};
> 
> These properties should be upstreamed too, thanks.

Ok.
Thanks!
