Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D4A60A2616
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 00:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G6P4uKTP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oTihuDhW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DB4860E22;
	Fri, 20 Nov 2026 00:07:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I9LfC1qQncSB; Fri, 20 Nov 2026 00:07:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CC85460DD2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795133220;
	b=gsTGAcWhwpGB4W2RqdWE78esPGxe5N388xP9y+tGAm2GJlBaid4OVA9Q80GK3j6azk7p
	 4cZenQaPfcrc7QvuyWmT7pXzZfu6TSPtDKB0Ibri9A0OwPwtkU5G0UCGN9itAJTAZX9Ra
	 aRO2N+4cX5ylCaHXVOanCcPvEtrhI8GT2jz7tSaRfUcmzkNX9HrFCe4J9I5KyGEILDzCx
	 08IF6jdQFbrqvZVHKv2S/O37HMwu9jfy6pI3s9cpG15WmQeJ26JNcs/mJDFyhKC6cmiBb
	 sT0h8URTBMeV794H7pYbsrxT5xh5HBS/QXp0ID3/Dpv2noXv46t1cD2So7B8UWWG9FA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795133220;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FBBX+Aktc4xRva0VldxBHbCHcj1L3OStGa7nl1CwiFg=;
	b=W5TJQ8mBV9oSweX7S7ufyjIXAQnVvXHIdMMeC5QHITmG7a4qehB0SlI9u/51fCN9TQLS
	 HAxP3uC5TRCzEJxIrKRewASefyMXzxvqp0h6iUYKPNmgPZboz1ozcxpOXuPGp7APX3sAQ
	 warCpDLTWi5ykKIzLjU17d8nXspnoJQUwwJzGo7hxlJhiJ7NTQLBjY7VHdIE6p5RfdP2A
	 BsB34BC4iqlveRENbnip09+Ii9zWh7Vtp1OVWHVAB+CZxrG3RKEzK6N5mUojmt8jwX//t
	 PqTzTob9f+QGPniu065xH+d36XISYcHUzrIothL6EHRnAHLo1cq3UehuGbrF5Oaea6w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oTihuDhW;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795133219;
	bh=FBBX+Aktc4xRva0VldxBHbCHcj1L3OStGa7nl1CwiFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G6P4uKTPPQOypG5nQFoaaD3ANvuyd0kmawJSC5D86J1RzxB/DrWwqPDw+gt+zg6Uj
	 dcXX2RlDCximwhz0mxtIO8iDeHKUQ8ag280T9KC89dAbM8nrk8mpBs4YlN4+rDmJ9k
	 z3U1wuZGJbrhqY1IGA0jFTxhd/DVCnK3nFJj9e48L2AL0tmZ9dxD0o+NVES0d12EsD
	 vsO4Dxjq9pn8dfwldW6I7x2ia/C3lpUp0zpq+OqjE/r/bnssWRBsTE6vQrT0mRfhqt
	 w79sChFzNIbBu/y810tK1xj0koMQXWXiCnLOW+brbBF1LEJcqn4e2Ihexu6zdFfXot
	 f6O+wx5qHQwfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC85460DD2;
	Fri, 20 Nov 2026 00:06:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C9671C9
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 00:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EAB760DD2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 00:06:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JMr_0Kp0VsLa for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 00:06:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1FBD360D8E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=andre.przywara@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=oTihuDhW
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1FBD360D8E
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 00:06:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE56C1575;
 Thu, 19 Nov 2026 16:06:52 -0800 (PST)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E34FB3F632;
 Thu, 19 Nov 2026 16:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795133215; bh=IoOL2kk5wVzykTzzbXxikD3ll4LD4rxLGGlbeC6O09A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oTihuDhWbOKN1Rmboa5pdL1H1NWeUDfTZOCckJ7T5usKB9NwoHXADTKv1JELEMEEv
 akeUTRKXYW7B+Gexj2SCN2EaNLW92gby8nqesE7piiN3UwT/kQT2vHO6rCl3IEIHxN
 3uQj3pVnxGQ0rZU1ZA9bkt31sDGVKnqLt8Gh8nIY=
Date: Fri, 20 Nov 2026 01:06:49 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Alastair D'Silva <alastair@d-silva.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, Hans de
 Goede <hdegoede@redhat.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, Tanmay Kathpalia
 <tanmay.kathpalia@altera.com>, Yixun Lan <dlan@kernel.org>, Yixun Lan
 <dlan@gentoo.org>, Enzo Adriano <enzo.adriano.code@gmail.com>, Junhui Liu
 <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH 01/26] power: regulator: axp: Fix AXP318W ELDO voltage mask
Message-ID: <20261120010649.3219583a@ryzen.lan>
In-Reply-To: <20261113023236.569054-2-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
 <20261113023236.569054-2-alastair@d-silva.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 13:32:11 +1100
Alastair D'Silva <alastair@d-silva.org> wrote:

> On AXP318W, ELDO1-ELDO6 span 500 mV to 1500 mV in 25 mV steps (40 steps,
> selectors 0x00..0x28), requiring a 6-bit selector mask (0x3f) rather
> than the 5-bit mask (0x1f, max 0x1f -> 1275 mV) currently listed in
> axp318_regulators[].]

That is correct, but can you say what this fixes?

> 
> Fixes: 71f07932756f ("power: regulator: add AXP318W support")
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/power/regulator/axp_regulator.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/power/regulator/axp_regulator.c b/drivers/power/regulator/axp_regulator.c
> index 16d3a8f7f90..e425f3bf8b2 100644
> --- a/drivers/power/regulator/axp_regulator.c
> +++ b/drivers/power/regulator/axp_regulator.c
> @@ -227,12 +227,12 @@ static const struct axp_regulator_plat axp318_regulators[] = {
>  	{  "dldo4", 0x22, BIT(3), 0x37, 0x1f,  500, 3400, 100, NA },
>  	{  "dldo5", 0x22, BIT(4), 0x38, 0x1f,  500, 3400, 100, NA },
>  	{  "dldo6", 0x22, BIT(5), 0x39, 0x1f,  500, 3400, 100, NA },
> -	{  "eldo1", 0x22, BIT(6), 0x3a, 0x1f,  500, 1500,  25, NA },
> -	{  "eldo2", 0x22, BIT(7), 0x3b, 0x1f,  500, 1500,  25, NA },
> -	{  "eldo3", 0x23, BIT(0), 0x3c, 0x1f,  500, 1500,  25, NA },
> -	{  "eldo4", 0x23, BIT(1), 0x3d, 0x1f,  500, 1500,  25, NA },
> -	{  "eldo5", 0x23, BIT(2), 0x3e, 0x1f,  500, 1500,  25, NA },
> -	{  "eldo6", 0x23, BIT(3), 0x3f, 0x1f,  500, 1500,  25, NA },
> +	{  "eldo1", 0x22, BIT(6), 0x3a, 0x3f,  500, 1500,  25, NA },
> +	{  "eldo2", 0x22, BIT(7), 0x3b, 0x3f,  500, 1500,  25, NA },
> +	{  "eldo3", 0x23, BIT(0), 0x3c, 0x3f,  500, 1500,  25, NA },
> +	{  "eldo4", 0x23, BIT(1), 0x3d, 0x3f,  500, 1500,  25, NA },
> +	{  "eldo5", 0x23, BIT(2), 0x3e, 0x3f,  500, 1500,  25, NA },
> +	{  "eldo6", 0x23, BIT(3), 0x3f, 0x3f,  500, 1500,  25, NA },
>  	{ "swout1", 0x11, BIT(3),   NA,   NA,   NA,   NA,  NA, NA },
>  	{ "swout2", 0x11, BIT(4),   NA,   NA,   NA,   NA,  NA, NA },
>  	{ }

