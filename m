Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB30606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sxKo2O1p;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fFAHy6Y/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A2546085D;
	Wed, 18 Nov 2026 08:17:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yBNRpy_rFU1V; Wed, 18 Nov 2026 08:17:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9096C6081D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794989873;
	b=MPXusEHzkqu433/OqXhqFJubOn3UAKFbGvphAxh6dl0KZRXoVw+gi1uc4WP0gcZLEBGG
	 6oobLNvclcO0zkveR3gym+hkmi2tzMe6JacYRxkRe0ztzV5JoCXPatGV9fHdrBBGkdfWM
	 SWXhpv1zI8y8sQal4aO556cnq33h4P4IW3yeDu/mH0c8+6uSsupUQmUHCVnS6Ge2DgiWz
	 sjcHA6Sc4O54idR+RybxL1xBRap7d/SECCUMsSIMJlefhGXkvUWHvLe+OxbAs3qt+FRR1
	 87Ji6GXh2A2+MI/uwWu8Rc+ZFZDje9WOz2etbQnN9OvWWtDGMi9H/O5VC9rMLOSqg7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794989873;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Cn5nVEuhJ4ft/5AENmCHvE7A41MprqrAl/ogmFNegEI=;
	b=JSZo7kQkMF1qnxLcpWmUeW7oo49aDGqRz7tv3HiASgQRUqpSjVAt+2dpTVMY76hrvK4i
	 epVtrEy81P/SiGdxU35h/aYeXWQOpgdjFkUD3FAig36+b4TqIJ7egxxt3Sglo3LL0aYTf
	 PZqdaJTkX4WIG3f2j+pLqR3JWnISRw2fdwlY4LkWYyHUA3ie2L8qWHz7O5nLiRD3sLUAs
	 A/E3R5ZfE8Oi70sgqzGx11wfHHaG/H01hrlk+a+bAwe0xbxyn2/n9dFg3rEDZmya71My0
	 mawfh48D4nSfQvpMPv1nl7j8/5EaTxBoDs8TGukzWm9dEUY8JIPsQFZqCfzzj7uLceQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="fFAHy6Y/";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794989873;
	bh=Cn5nVEuhJ4ft/5AENmCHvE7A41MprqrAl/ogmFNegEI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sxKo2O1p6ivEwDVGuYoCxJ2jAkwmMrqDmXmMYgaTabRYLynVoe+nXd15Vh3sffbwO
	 PJDt3AEJxn3qxqL/PBaCBLv0YdGLamvab2TkesvJWk0LkxxN11+6VSRXCOjY5S8zIE
	 zZMcZosz4Y8DKTi0G4Ir7+dCPqyd9grWngcPZeFnve02DJKxh8kf5OV1GNk16qCVX9
	 NH5ae5NlRgC6bvQncdtizpOiDThneQXdhgutpwU1tc/5iBWGzt/898g94sjiMwzosh
	 NLlpoDv7WVKDrpZBLpTWOrZ8YvFmaVDd3lBol+pBBXGjhRS9FJdgEEESk3rMWF/axY
	 t6U7X2MZsk6Qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9096C6081D;
	Wed, 18 Nov 2026 08:17:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 03AE89F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:17:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DDAD06081D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:17:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PfLww7drL8aq for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 08:17:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 964A46081A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=bastien.curutchet@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=fFAHy6Y/
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 964A46081A
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:17:48 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 27BCD1A16AA
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:17:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E8B265FE9B;
 Wed, 18 Nov 2026 08:17:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CB61C11BC08DF; Wed, 18 Nov 2026 09:17:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794989865; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Cn5nVEuhJ4ft/5AENmCHvE7A41MprqrAl/ogmFNegEI=;
 b=fFAHy6Y/K+vQOil2rIM7uVy6Er9PKttzJxwGaCLgwyNZDK/MmG/6LRH2+LObWqwadyepof
 7FVSHcL4YC0r6hPpOQ7V7KZ+GHmmkJ5euZq3Yho1IdsrzoqYjtp6LofhUPbUPjXtYMhze1
 M7c892+PjutAF9gbrKqcfChAAb+4SfQyDGHxLr5lPt5687IkC+U2rT2wy79KuROwiOzIZL
 YsleK5n/0fZCvdVS92EAc0E6FwG25c/ZAnDlBTd/tgBKWUn2iiokBEKBp89AqQlNH0OGUj
 0RP0xBeIRpsWnp+wHGrrMrtF78Z6+x1swLTsflCV0NAM0ZH8WJSUUzX5Dz/wgA==
Message-ID: <4a1108a1-bb09-448c-bd3f-2075656ebe81@bootlin.com>
Date: Wed, 18 Nov 2026 09:17:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/20] clk: ti: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
 <20261116173546.3487841-16-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <20261116173546.3487841-16-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 11/16/26 6:34 PM, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
> Cc: Lukasz Majewski <lukma@nabladev.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>   drivers/clk/ti/clk-ctrl.c | 2 +-
>   drivers/clk/ti/clk-gate.c | 2 +-
>   drivers/clk/ti/clk-mux.c  | 2 +-
>   drivers/clk/ti/clk-sci.c  | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/ti/clk-ctrl.c b/drivers/clk/ti/clk-ctrl.c
> index e3564277982..3feac53a7ff 100644
> --- a/drivers/clk/ti/clk-ctrl.c
> +++ b/drivers/clk/ti/clk-ctrl.c
> @@ -187,7 +187,7 @@ static int clk_ti_ctrl_of_to_plat(struct udevice *dev)
>   	return 0;
>   }
>   
> -static struct clk_ops clk_ti_ctrl_ops = {
> +static const struct clk_ops clk_ti_ctrl_ops = {
>   	.of_xlate = clk_ti_ctrl_of_xlate,
>   	.enable = clk_ti_ctrl_enable,
>   	.disable = clk_ti_ctrl_disable,
> diff --git a/drivers/clk/ti/clk-gate.c b/drivers/clk/ti/clk-gate.c
> index 873ceb8a2ab..3159e75a9a8 100644
> --- a/drivers/clk/ti/clk-gate.c
> +++ b/drivers/clk/ti/clk-gate.c
> @@ -73,7 +73,7 @@ static int clk_ti_gate_of_to_plat(struct udevice *dev)
>   	return 0;
>   }
>   
> -static struct clk_ops clk_ti_gate_ops = {
> +static const struct clk_ops clk_ti_gate_ops = {
>   	.enable = clk_ti_gate_enable,
>   	.disable = clk_ti_gate_disable,
>   };
> diff --git a/drivers/clk/ti/clk-mux.c b/drivers/clk/ti/clk-mux.c
> index db539341431..007bb7ab120 100644
> --- a/drivers/clk/ti/clk-mux.c
> +++ b/drivers/clk/ti/clk-mux.c
> @@ -171,7 +171,7 @@ static int clk_ti_mux_request(struct clk *clk)
>   	return clk_ti_mux_set_parent(clk, parent);
>   }
>   
> -static struct clk_ops clk_ti_mux_ops = {
> +static const struct clk_ops clk_ti_mux_ops = {
>   	.request = clk_ti_mux_request,
>   	.round_rate = clk_ti_mux_round_rate,
>   	.get_rate = clk_ti_mux_get_rate,
> diff --git a/drivers/clk/ti/clk-sci.c b/drivers/clk/ti/clk-sci.c
> index e374bd3bcc2..e16f8d83219 100644
> --- a/drivers/clk/ti/clk-sci.c
> +++ b/drivers/clk/ti/clk-sci.c
> @@ -196,7 +196,7 @@ static const struct udevice_id ti_sci_clk_of_match[] = {
>   	{ /* sentinel */ },
>   };
>   
> -static struct clk_ops ti_sci_clk_ops = {
> +static const struct clk_ops ti_sci_clk_ops = {
>   	.of_xlate = ti_sci_clk_of_xlate,
>   	.get_rate = ti_sci_clk_get_rate,
>   	.set_rate = ti_sci_clk_set_rate,

Reviewed-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
