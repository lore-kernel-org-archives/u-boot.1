Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4E6606A334
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m/djdi4P;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZBu5e1+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C16E060907;
	Tue, 10 Nov 2026 14:58:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gi0gBz1_RsmX; Tue, 10 Nov 2026 14:58:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 07EB0608FF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794322690;
	b=JizYgFeLw2xt3TFiSe6huDnVel6RvapYCzrA2O4KfaZq07hr32XBQQoJvYgLnUIEA2B7
	 1eaWzrMR6D3qbmBqEU4U/SJyUjKGQEYCWgLHqjhuH/h54EEBHfqQJPpxmsFDaVi/tVqh9
	 O99+oI7hhhlTpEFVWf1XPILpJiHraWkkb88qRNQXO+hD1DwKESlPaNkwY59zexhMDFDbA
	 /SHOoIoiv25kpZI7+rIulNLyqk23kAhpAC0EEJx7hTIJD8i3+KP+Lv11oQsnPzRSVax33
	 pQQ33O/UrTF1NOmFY+Ktb85JGi5dXyaPnf0F9INHleDXuVoAr1zbHuX/FlG++zIcL0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794322690;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VgrW+wMPtwGcJo4fA/VKgnyv894LwxPYKJCXfF7BQrI=;
	b=EkaJaDG6dJrEgYq/X9lq4ZNuQDrn1IN5mMrjrWh6tzkrgx98jB15rFX1vV7CNk1hpCPH
	 krJBuFh+z7G3lusuvarZjMO1995hC2/qSd1stdZDz54fY5CV9RbO5w5Bs5jqarwNycBbS
	 dR0Qp6rew4/WdL2XLv58Por6PDIr6jG5mpghDlraQ5Vpswt7D5ypfpAqBme+5aUAEccfn
	 ED788N/A93+OxqCc4J2Yc2h9aIgy8YsslvB5TcsR5jPiPElFp/vldJy5wZlR73D7p9uSD
	 3/8CfgkQ1KC3tpJb+N1WBzIiLY6EBr0ec1zsRHPf0sbAjuwKamqI1vY3K8sNSPNrLUQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794322690;
	bh=VgrW+wMPtwGcJo4fA/VKgnyv894LwxPYKJCXfF7BQrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m/djdi4PvRHXAQ/XNpXgV3+Ug3/XccN/A14nc+Ayc9ml9g3ve+5XVdjXbUGpX94EJ
	 hrDJRADAFb/d55y1ROqKCYrSUjelj6PdYf1e5Tn4jvmQVG9g8yfjoaddyEKpo8H55x
	 T6j+rZgJ3erC8Z7CBP4zz7n0QjlNvx+RRhlyyIn+B6x6D1UdDuONX1uEF2w3Qk7RU0
	 LjZ4rGWD0SpwhvUu/oxxi5UYWtt4LLTquDYGwYxMWTUlFoEtfMAxGTA1bmcux4xSYk
	 IEN6AxrSkzhX9CGTXBWQL5bDjvhFXdXyWotFkhpJ7ST8OiU3ZzTef7RQTAeImEigCY
	 CdwWoMGk7pY8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07EB0608FF;
	Tue, 10 Nov 2026 14:58:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 1574E1A6
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:37:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id EF47840845
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:37:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id nujxYMDo1DLb for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 14:37:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 914AC405F5
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=brgl@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JZBu5e1+
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 914AC405F5
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:37:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with UTF8SMTP id A055D61304;
 Tue, 10 Nov 2026 14:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 76F641F008A1;
 Tue, 10 Nov 2026 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794321421;
 bh=VgrW+wMPtwGcJo4fA/VKgnyv894LwxPYKJCXfF7BQrI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JZBu5e1+RU8s7gMjaj65WcIoNoSelVA7twMVBj0hAG9rH+cNqW9w/Csjl2YrXJCZX
 QS3fR4416qW5m5EjPUC2NRNsZFWk2Ie9qvrIhe1qkSIUZW+/tcH+mdiqmGlGkH48Em
 jC5yQtnSi06jIgETWpWjaUetzvCF9M9F7LSh6HzzoDxeWISjBMx8oDRHwYLpXlZNao
 alp86FHCz8E57D5eG2xYji0/9W8gqTGFF6XPepKJcVEIQo4TJTVBu9rSK3r3iVeON0
 mRNMcj+QHWExoauzicj4uAZkubZJMsH75reC4bhh3eWy0RHUoXN9K5HhFFy4LRqE1j
 vnVaC6hh0USJQ==
Date: Tue, 10 Nov 2026 15:36:57 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 nathbappai@gmail.com, 
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 tyler.baker@oss.qualcomm.com, 
 jbx6244@gmail.com, nikroks@mainlining.org, bartosz.golaszewski@oss.qualcomm.com,
 shengchao.guo@oss.qualcomm.com, andersson@kernel.org, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v4 07/13] pinctrl: qcom: add TLMM driver for nord
Message-ID: <pw32os6c5eqo6n2tl5k4skh7cwij5p5tv5ay5ebzhdwfenr6pa@5xdf6rg5hu4e>
References: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
 <20261105182614.2405482-8-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105182614.2405482-8-aswin.murugan@oss.qualcomm.com>
X-Mailman-Approved-At: Tue, 10 Nov 2026 14:58:09 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 11:56:08PM +0530, Aswin Murugan wrote:
> Add support for the nord Top Level Mode Multiplexer (TLMM).
> 
> Implement the qcom,nord-tlmm pinctrl driver to provide pin
> configuration support required by nord peripherals.
> 
> Reviewed-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---

You may want to include kernel commit fbfd6d0d3596 ("pinctrl: qcom: nord:
Split QUP1 SE2/SE3 into lane-pair functions") in your patch, otherwise 
u-boot and linux will diverge wrt pin functions.

> +
> +static int nord_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)

This isn't __maybe_unused, it's used below.

> +{
> +	unsigned int i;
> +	const msm_pin_function *func = NULL;
> +
> +	if (pin >= ARRAY_SIZE(nord_pin_functions))
> +		return -EINVAL;
> +
> +	func = nord_pin_functions + pin;
> +	for (i = 0; i < 10; i++)
> +		if ((*func)[i] == selector)
> +			return i;
> +
> +	pr_err("Can't find requested function for pin %u pin\n", pin);
> +
> +	return -EINVAL;
> +}
> +

Thanks,
Bartosz
