Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B8FC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 16:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E73686D4C;
	Sun, 12 Nov 2023 17:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fOpv/5cp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 848FC8708B; Sun, 12 Nov 2023 17:53:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2FAC86D4C
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 17:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699808000; x=1700412800; i=xypron.glpk@gmx.de;
 bh=eM5n38TYBWDObcplL0bRYLv67Ht+sP1SEMncJF2jYLc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=fOpv/5cpMCgjGT2/z9o1w2yVGjQ7y3WpvfO17FEuo3ubduuo3+m9+BNqRXypC4EM
 zJKyhoZ+pf74Yeji8aFJa8vYQW6IRcmbTtxg7TQnOXgeV9MoSaosnXx6YSrI9CES7
 93A5mdZ2mhPPSah3XFpOWFmJZ/wlU6oWRf26SAA7Ms9itDl+g0UuElfHD0P+aNSLl
 qi9LvG+EW0om9Y/cKaM2T2Hj6kS+2SvF8FGwHpdkFtybq7XTzqAIGZExyJ9ndyn5Y
 hSLLtwSDhRrCjsjKpeJRrZzwJCa3mLTSY+qkQdaPsOajm02WZeKLBbFQ7Xe65pjQM
 O/1aXgAlCUIffUgo5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4JqV-1r1wj83VJ3-000H4T; Sun, 12
 Nov 2023 17:53:19 +0100
Message-ID: <44e30885-88c8-4a22-814e-77fcc9ee339d@gmx.de>
Date: Sun, 12 Nov 2023 17:53:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] efi: Correct display of table GUIDs
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231112155808.135585-1-sjg@chromium.org>
 <20231112155808.135585-4-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231112155808.135585-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mQbVQEuWw10eI+LsLMHSXBH0esnq1jClOoaGVxw5DmVLMKZ5PQM
 3bUyHvzNGFr9fNKDEZkoO1VmW0rnmxjhL25sieNmY4LxadkBZmaITNXBOXOfoD3HYG9qPUL
 1Y3ifqDhf1dT77Ra0YR8x+t95bok/LJ12RW4iDqIoI3cNyQUOw8X+nlvzrGFEaL2vmiwmXs
 usZYJbG0TD0xNv8dhd41g==
UI-OutboundReport: notjunk:1;M01:P0:xC1XyAaZrmU=;eQegjk4ovxxgNsJ9+jso56XGQM9
 xK1O8xSQNs/D7jyxRElLEvWkgOwVEGypsI6faCrxzEEjXiS91gK+iNzZ9LDrgh6/maqMvu6Ry
 Dvuda3IESMwZmoKZK0sym7o/G1zXrqKOA0OcbnhUVnI4AjnSbHLIuIu9R/IMOlVFxwlHitAAv
 Iyz6L8KHZVHHhIHrlMdc7X/NBw3bksQLVUqiMmJdiAzTDanYUKmLsepqi3d+5HB1UK8wk/Zjh
 3TWx1XPeMx9yaRU30JuDBJq7OYecjf/HI+i0ioOBqxaZqdOakQ4oO6BWs8d/RRCWEU7fN3wNi
 r5owHw5mh8wHQ4J+mQ5MGXo3od04tf/gWZo+2phqw8BzEWGmz5anLEhtlyxThxhZITarE2es2
 P8cIaA8iC9K85SJ23KNZ8IqHR9IP+OEYnleZ1elnru+1Oh3gYfDhIdKBbzkSVjxJA36pMCdCr
 19tagiQxXYqMKUxIBeT5soLqedg6xLTCcK/DElDHMbPjmOwS3PoaUrGL06MIEKUkak33Q64cv
 CV0T4875q+pjdx0d8pYnnPZVYmVB5A9eqbUeqvsvQ2/LZRwuM2Rg8S8gJKXcgTL/2v68jgAP5
 aQdpesaNfUVzp5dSpBOacnB/fbtnxAOMhj6tXMowM7uQsPmF2Ex8QeGk/ksLCkTIYekp3SZpf
 t6A9C0N97W7vZkH2FlgbQNFd+sCquRh4dpI0ggfzQaaASlx4tlaYg4VQIw/jML8NwR3DHn++x
 1PgPxY8/7m+Q0+SKXT9ao1LbtnLHCwZaD+0BYtWqdooxgot3gLg7mVfOd4Kk+8n9VQ1DS3jAl
 NxDBCfyQlFTfLBaPrtyJUPDlhSCYMi1TkTJB8TSdbId3auxV8y5MOaZdBAQAqLRdG3Addem5X
 vWzTPZNTL7LwMH1my1NqKwJo2qWqTkhaQK5e91yzd9T2gOp8zS/YHQPYHmKiOjFeTxI9zZZoN
 Euvzk/RE7St10q+60VdesJDwSDE=
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

On 11/12/23 16:58, Simon Glass wrote:
> The printf() %pU option decodes GUIDs so it is not necessary to do this
> first. Drop the incorrect code.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   cmd/efi_common.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/cmd/efi_common.c b/cmd/efi_common.c
> index f4056096cd3f..1aa2351fcdfd 100644
> --- a/cmd/efi_common.c
> +++ b/cmd/efi_common.c
> @@ -17,10 +17,8 @@ void efi_show_tables(struct efi_system_table *systab)
>
>   	for (i =3D 0; i < systab->nr_tables; i++) {
>   		struct efi_configuration_table *tab =3D &systab->tables[i];
> -		char guid_str[37];
>
> -		uuid_bin_to_str(tab->guid.b, guid_str, 1);
> -		printf("%p  %pUl  %s\n", tab->table, guid_str,
> +		printf("%p  %pUl  %s\n", tab->table, tab->guid.b,
>   		       uuid_guid_get_str(tab->guid.b) ?: "(unknown)");

Please, observe, that we have printf("%pUs", &guid) for printing the
text representation of a GUID. If the text representation is unknown, it
will print the numeric representation.

Best regards

Heinrich

>   	}
>   }

