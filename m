Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3594606D806
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O/YltuWE;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=AHmZbAGd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF253606E6;
	Tue,  3 Nov 2026 16:51:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9HTLit4TogxB; Tue,  3 Nov 2026 16:51:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C5CB5606D9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793724687;
	b=km1tP79KFMcY80rELr7+m0oIDqdEx9rOw6QB2DMja53XvP/dEq30OmnbeJfplqu+ZteE
	 YkmPIir0IGpeuNpew+Kv4/u7xlILlsfO18vn+oFKLWIiukbx3vtz70hNkBJAr2VkalLxR
	 0pAoScvXj1UZVdIc19B0eEUo47+wPqTLktNcTeHeKpvJjlrs/J/TWqR4jBg9nu9jePhW1
	 n1eDi07JCGCW6FCxxh7n4h8PMbHKhOjGFYB1iKPo68bGY9YQ9JOyyfScqyg7D0R1C/wOq
	 ltJDOQ+d8q8JT8C+RtDItYJwdXcmobQHCH6kbZmre/kX10Wgz4zyEkyumG2kDH8pDdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793724687;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=afICiOJ0T1lrvZi3lyOhXaFIBsI9gIfY99Ay5vLRQPo=;
	b=c8JSyMP/XIOmrB/Y/XdJONjcrnonaQ2yroHkrKHeTzxQdVnMNmOMcbN6OKn2s4dF5BrN
	 j3Imskvmw8/7lHFN60LHLfRKn08QlNzdSlqURyLpnaepzvohMKdaAZ/F9Eu+T5mgRB75n
	 8BIIsdjNmK2pavc4EZZygrYCir27OX4UpJD1iV4gsyiPJHIZoSED50zLYEwMM7Ahoco2t
	 ezMGB/g9X/YxBjLYQxjmowW06EKoaLd067LnXQF6334Ogwj0fuFSmTuiQbmUZ6Y3ut4WD
	 qWnDbSzdkkQlB1ndiJRSPcD4rdC3HHZ6lQEqW7R/w+Y61bG1H0u3S+79qgWs9uueTtA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793724686;
	bh=afICiOJ0T1lrvZi3lyOhXaFIBsI9gIfY99Ay5vLRQPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O/YltuWESt55zTvJIIRrGTfeW25Abo7T6QcDZ/Rvwb/0drlhVg3SzcJo3oAFf4Lve
	 zU9pub3Upz7PC9GFEyGEL217FhNW+lUP41xDhS5rrYmOIX4Hr47GWdKBR+CoW8Z4Gq
	 zZPlMjLWocxxVxQZ6DB8Dkxd5D/vfreTnVaYzx9fxnL4lsuaxO9u8CvMAiY9vblUIz
	 BAQkwojtNNrNjLXbxjMsZEqj9U00jG3syJi5QKwfAzN2GWwyDWKcmXUuHO1k2A7YmJ
	 wRfD7MhgwF9S9eVe2E2Lzl7G7cwlfDWWnhE0NrxaEtQcOwciVgbpC5ONatGbSD4d1l
	 P6Va+wYztrStg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5CB5606D9;
	Tue,  3 Nov 2026 16:51:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E21BC356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:51:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF8CC4077B
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:51:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MGpVwET1ddKQ for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:51:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B454940726
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793724685;
 b=Zrbb3/dPF5ie8e39jUDJhPe4rPzOD4CHzbig8OXJyPHBCneZZ0WUGQtfjOCuPhowZVJL
 EuofgGZW7VjIzE3OJfP7AmYCT9DjkUoq6+KxSuv1AycShWT1q/ZDTahJBGSYdN2GbtozN
 umI4yxQbWP1PXDb7vMWplTu3O8iDtKOEuSeBr3/0/Nd6lbkC0wB8GjxLH2r5AoLht4+BS
 e0bh3mOqX6lMmus24aEzu/G7DQrHkiKxIv/zMv5AQ8qhqvVBFI/ISX/Og8no7trrqb8Ci
 N8KEY+rQswrbvU1Odb1JKRvyEwz7MChW0RfOgznqauyNUep3wQ7C+fCBui1HifJPh7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793724685;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=afICiOJ0T1lrvZi3lyOhXaFIBsI9gIfY99Ay5vLRQPo=;
 b=S0LyO22ixzny5yp/TQiFOvFb8loHAvNaa4mcqWZAyobx9hwVajlVbvJ1YXGvuD1w3ESR
 QQGEb8A2AldFQXe4RsF4GYCC/kYbXIGqA+zC891U98EeVbW3yqX6bDcmneGRAqzBcCHgd
 y0WPWq4EEIIvPaQnBwcjR3RXYozgnuFTgD9Yz1e6Y5Nbk4WkKF+XqGxVlXqd8uV8jXXac
 69vtE7VHS/HRCHJcXZRWsbErXtW/bGgX+P5SThNUeDbNcJd8cYpXypUmxxUkNN5i0wgH4
 nqKmsJwRpKNztUJdgJdUKUqgHG0a3UKPrqxIldNJZZlxCd5woNUpb2r7lF0ugb7XW6Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AHmZbAGd; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=AHmZbAGd
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B454940726
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:51:24 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso3083841f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 08:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793724682; x=1794329482;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=afICiOJ0T1lrvZi3lyOhXaFIBsI9gIfY99Ay5vLRQPo=;
 b=AHmZbAGdxAA3toHKx0Loav0lG3UkGjz7Unsw4DXMQxikRN3G8KdmnIFiGNAW9W9jVw
 qT5XC+wRm8C/9pSwWv3htuVy1d/p8KwgSM69rTh8Q+zgyixC93i3BWFmlPsNfywPDIhM
 h/MVg66uVhXG7eyd7DVo6OiCbZiziuTNbtTYVwDVN9fWGStN6v7WhS9vLTqHnSC6SLNV
 mOT3E4wSpbBKaagQoc81uHiyuFCkIDer4yDZq/5/c4AojSHs0kMyYrqri24VLTsuXnFy
 WH3eYhowD+5+NqmAkzVWGu24l5s+Dp1KBDqnhsMi4Z+ab9EiWXj2tbCybQAvFsibLtd8
 JxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793724682; x=1794329482;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=afICiOJ0T1lrvZi3lyOhXaFIBsI9gIfY99Ay5vLRQPo=;
 b=O7sq2vkZAB+IWyLoa8KwC+vjJMDAxKGNxd9tDDfZjAB921+366B0OUZzyV+RgX/g3j
 yLxqWJxlauqSQsVMABQ3W1fE/xAxY7WXr20z2cUnLikUcAqTbmE2As2MSICCPqAos47C
 +U2AUcxubTHQBo2WX5M2kLocoX6CH6eJhxdYzDeBxtQeOd6JJfKhkyad2qriC+nb8hDw
 0nYcT5EMrGkA+3ohHOMDDKvWCSLgPZIHaiS5qGd0xBKyBpAPsw+VlX4HJw5pQSCJ2t+q
 k1yWPIIXDelpmGhAWSg8wxx1dNhx/ekNxX8ZKi7I+4tRCIc6i2rVd1npg4L0sVtssTHI
 lYxw==
X-Gm-Message-State: APuU4Z9hSVDswpaYeTFoCmKipOYnF8I/WUjO4Bb62t0P6N6IWQsSQH+K
 bE3RkO/vv0xdU1GZGKbjnPnQHAiZjb8iC+C+fFOPBGVBUtqN4wtZ9Gfrzg2ldGBmLSA=
X-Gm-Gg: AYBFou34evyYbqnyq9ut9ApxdeDVmx6nMV2CqxTGun0QwUgm2uRSF5yao4KN0REp+mf
 e4jP4BVnMS4NitNF3EVSrrnk19D6pd+4BSI4cLn28w+qVI1aQ71hps4OdK89i4jnZ3bMQG2nXRG
 BTHIvz6cwQgkhMS692c1LLJeJ9EahAaRS2rIIY2RROQPhss2DPjcN2oic4SHZsWIpRYex9qZKlo
 MKTRWUh+urKqaAk6D08grJUzSYQLWLGQ/suyjny2YY9B7f0QvsW44T/1o19uMcbHnaSF+fl7OD6
 /gJVe2V/B4uDye8F4gbozxjMqmP9/SUrSaBeQCsaTFPaRGBswJHgGn88nhg+Tlit0nBTKKllBMk
 M7kKy0qcpJ0qfIpw6lSZDMqpxYUjWDWkiI6RpZoRHAKOousPVCnpzn4u/odk0m2gv5pl2n4US76
 0g0kbOvTkph8L9TQ11nbzX/U1wMu/r0hRlPB4BeudSy788+H1mX7/4jrT3DIrU6bQ01leG9WGsL
 JawtXMsV1PSK8sDfpufc/sgeu9EdPkvBh0arRqoK8DEV/rOA0hbAoRgnfMWJkVfcTB1xjFyIg5J
 AiPnGQNF38AQFZbVqgLp/Z6mvVFHAnsdsOTqOQ+fzJI2F8NqDsAF1MOPG93iUHrNAiCc95YIIIm
 ixg==
X-Received: by 2002:a05:600c:1385:b0:4a3:5991:718 with SMTP id
 5b1f17b1804b1-4ac182dc0a1mr335666595e9.16.1793724682523; 
 Tue, 03 Nov 2026 08:51:22 -0800 (PST)
Received: from macbook (net-93-150-243-29.cust.dsl.teletu.it. [93.150.243.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a93232f0sm71881545e9.10.2026.11.03.08.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:51:22 -0800 (PST)
Date: Tue, 3 Nov 2026 17:51:19 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 York Sun <york.sun@nxp.com>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Day <me@samcday.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Alexey Charkov <alchark@flipper.net>, Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 4/6] spl: support booting FIT images downloaded with
 fastboot
Message-ID: <auoQt-dK88mCJqXQ@macbook>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
 <20261014-ccaione-upstream-spl-fastboot-boot-v1-4-d29df15fb9b8@baylibre.com>
 <179370057187.349126.1249068431082363401.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179370057187.349126.1249068431082363401.b4-review@b4>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 11:09:31 +0100, Mattijs Korpershoek wrote:
> > Test farms need to run successive U-Boot builds without rewriting boot
> > storage. Add an optional RAM boot path for FIT images, including firmware
> > needed to enter U-Boot.
> > 
> > Accept the Android v0 envelope used by the standard fastboot client so
> > the same fastboot boot u-boot.itb workflow can be used with SPL.
> > 
> > Do not boot after a failed USB acknowledgment, in SPL or U-Boot proper,
> > so the host can retry the command.
> 
> This looks like a bug fix on its own and should be in a dedicated patch. Please
> split it out.
> See the following
> https://docs.u-boot-project.org/en/latest/develop/sending_patches.html#general-patch-submission-rules

I'll do, thanks.

--
Carlo Caione
