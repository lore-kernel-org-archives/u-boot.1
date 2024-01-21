Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15C1C47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 09:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92BA28777F;
	Sun, 21 Jan 2024 10:11:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XdQSNg4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 311A987796; Sun, 21 Jan 2024 10:11:00 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4149187775
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 10:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705828257; x=1706433057; i=xypron.glpk@gmx.de;
 bh=UAlpcK/B6+/wuaZmZOo1bOkkihpR7YB8PNsDjVPppks=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=XdQSNg4qzSYZLwTOyDr109JfYu4uGRZJWdULEBmI1r47HKVowZuXz+Q6gfuO5F7/
 CLmO2WlrAf+XqU3W6rZsugf4l88hmjeLtaWksFNKBdTfS4iYeS1Z1s+fzC6woWOC3
 LDmXQMF+ew30M2ZYkKaWGk0UN1BMuDpqGY2OpEGR2kzuryO+eiHxXG7WNfTHXd/l5
 l8q1OXnZ2MSCKLtOyZIRD89Qp7RGY/TYmXLNwjFbx0eeWFWWgrfMHs7fFqJRnceQb
 qAqMtXtWEIh60Avhz1mGdQhyj7h9mv4rR3lUxuYFzQHqLTXPKvnd8GiOHohnXcxky
 BtKn4RXgajkTrci/OQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsEx-1r9OPG05e3-00syuc; Sun, 21
 Jan 2024 10:10:57 +0100
Message-ID: <5f52720d-0d0e-4147-bd67-fcaac3853a18@gmx.de>
Date: Sun, 21 Jan 2024 10:10:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: uefi: remove duplicate word "has"
Content-Language: en-US
To: Wei Ming Chen <jj251510319013@gmail.com>
References: <20240119013414.1407234-1-jj251510319013@gmail.com>
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240119013414.1407234-1-jj251510319013@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8Q3LrBPxXYEK06FxvUV28sANrmccZSEj4rpWdVWKwrHYvpj2jQ/
 tY50p6os6ivxCgQ1xKfQPB3GIkHbcr2n0Bh/F1a/TlKgeBYZpnFGSIA+VAh1toJrhlZCJ9E
 BalAN2vH4AmNNKgSoZHApmR50ZQW5GRAOMWDdhEXXnSB2knU5+zS6YNeMYFalhN8FxgsaJF
 xofjTzTdNXImDkdmZfTNw==
UI-OutboundReport: notjunk:1;M01:P0:iGXoygswGc4=;21wUqiWkTA0VD3FpCHrF2l9oXiS
 vev6IGrYwXvMMhTn+texCUUKBJyWmhiH3d+ADZJOXWW+8SHif62OPzQkDP84jxzyFRfOwDu6Y
 91CPWHp3+Q8GvHbtTYxyhidQMjiWrxq1aEJaD5N9eG92Lc0L3f01Kih+c9gSRzDTlM8mk3MxP
 3sZP2FsyWAGDsIyx0dv9GH+r+2OkvDwyawH/LDjD2XeJQjYAECA1rK1JbH3cdosHOdRTK3fLQ
 dsw3O6DvOJGpp9NceqeG9tYf9nTEJ6SB44Recsib4OAbxepV236DF6mXyFa8Imqx+Pbe3F8+0
 jEttom/6JFRenok585siHTozo2dVk9k0+1YLP884k9T/LZQ+YSxAnX6Xqje8owXLfhLckgZ+U
 McRdOpIzEKJmxPEo0uvve6AAuqGfSTxtBKVGouzn7J+hYxg8B5Inb4dXgAJWlZW2/shWVTZLV
 QP7gSsYWrIEvwY+7IUN2reDQBPH6oVEu6guzlnDey00MZ0wTjYfF89YzaS5x7J/hpQl9Dj4cP
 xNKQakDC9doEq/IkoDWzt/ho8kW/N5Of/MoBlISxvRiiOfGvhN98WeqJb5k+KCEB9VIRMTRps
 TQx78jp7jJQdaE0RX07BhyVp6V7SDLf2OlRDTqdKTJ3lxVQX3Jbqyu2SLAtZlNZ2PXo9tyH+m
 lgpzOhIZfZ61soCX2g/ZyRYPu01XoCWaWwpK0sLValE71jUKCUCcXcDl7HW7Jx+iCa1JWMzLz
 XcsL1M6ckRJyfOIIm/wB4U/W+bc/cYU4av3q7KH3hj0J4hrQgtbkERKUo6qnKJfkj4GSrYRF9
 +UhXzHHmP9zmr/sYb704BKuMwh8+kNfpH0K5P8cl6Q2bkreHfYqyXn6IK0sf4rr/HA7pa55+M
 6TQPvFsOUDd9sb0TWi1CHfDXUzjf2xxNi7SQ/f02RF8l7JMWTjpL5VvSEu2lAF9eI+yGNIMJt
 Lw4/UA==
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

On 1/19/24 02:34, Wei Ming Chen wrote:
> There should be only one "has" instead of "has has"
>
> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
