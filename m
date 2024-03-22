Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56759C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 21:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1926A86D38;
	Fri, 22 Mar 2024 22:10:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="NowoI26Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94DDC86BDB; Fri, 22 Mar 2024 22:10:05 +0100 (CET)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E4C486D38
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 22:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:6430:4685:ff:fe12:5967])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id 48D515D8;
 Fri, 22 Mar 2024 22:09:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1711141799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rq8TxxJTImvgI/qhanca+ih7mioWj5KJrVYRvQiFyQE=;
 b=NowoI26Z3rO1GzKqImX7qkOomUnq62f1Oxc3WE/hBT3Jj1k8AQKQtZcfWxXMtok4WZ0kMQ
 oiSmwlzD2jXkaJgsdtD9P6ivTzGLvdy6GBbPJ+1Dk0UNqZUxHTats4W6P7lah9McXl7WnY
 CXWlgtvbww6k0LNcE+20Wz0n1DUy542m/uwsEzMruyjqP38PWyX43zgq6Z4NG00CBm1JaJ
 UtOIsxulTSs3yJT07AUJBtXUVhF7BIQIphuOho6QrKaSffIcE2u7/zr+vLICiYejKGVVaU
 FInF0RUw2yPV5c5ND9/bXj6KLO13KP0qR46D6gLZhvjXZ1RppKfaNNVC4JHn/Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Mar 2024 22:09:58 +0100
Message-Id: <D00L56D4IWTX.228PJHRM8H89A@walle.cc>
Subject: Re: [PATCH] arm: dts: kirkwood: Enable upstream DT on Kirkwood boards
Cc: "Tom Rini" <trini@konsulko.com>, "Sumit Garg" <sumit.garg@linaro.org>,
 "Chris Packham" <chris.packham@alliedtelesis.co.nz>, "Dave Purdy"
 <david.c.purdy@gmail.com>, "Evgeni Dobrev" <evgeni@studio-punkt.com>, "Luka
 Perkov" <luka@openwrt.org>, "Siddarth Gore" <gores@marvell.com>, "Simon
 Guinot" <simon.guinot@sequanux.org>, "Stefan Herbrechtsmeier"
 <stefan@herbrechtsmeier.net>, "This contributor prefers not to receive
 mails" <noreply@example.com>, "Walter Schweizer"
 <swwa@users.sourceforge.net>
From: "Michael Walle" <michael@walle.cc>
To: "Tony Dinh" <mibodhi@gmail.com>, "U-Boot Mailing List"
 <u-boot@lists.denx.de>, "Stefan Roese" <sr@denx.de>
X-Mailer: aerc 0.16.0
References: <20240322021747.14873-1-mibodhi@gmail.com>
In-Reply-To: <20240322021747.14873-1-mibodhi@gmail.com>
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

Hi Tony,

On Fri Mar 22, 2024 at 3:17 AM CET, Tony Dinh wrote:
> Enable OF_UPSTREAM to use upstream DT and add marvell/ prefix to the
> DEFAULT_DEVICE_TREE for Kirkwood boards. And so we can directly build
> DTBs from dts/upstream/src/arm/marvell, and including *-u-boot.dtsi
> files from arch/arm/dts/ directory.

Thanks for taking care.

> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Tested-by: Michael Walle <michael@walle.cc> # on lschlv2

lsxl should work too as it is just different in memory and cpu
frequency settings.

> ---
>
>  arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi   | 6 ++++--
>  arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi     | 6 ++++--

arch/arm/dts/kirkwood-lschlv2.dts
arch/arm/dts/kirkwood-lsxhl.dts

Should be then be removed.

-michael
