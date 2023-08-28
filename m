Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24BDC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 22:04:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55DA38648C;
	Tue, 29 Aug 2023 00:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fEQHSxGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32190864A6; Tue, 29 Aug 2023 00:04:36 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A501286456
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 00:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693260272; x=1693865072; i=xypron.glpk@gmx.de;
 bh=6Ck8WuqUE0RBbzhfh8KcafKwqu/QzZ0yQGCYCfJ96bo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fEQHSxGovsN8okSVKDPjoJXOipcfoPmCguTZgLh7uJ0J2LZp2yxvL2zckvibCNZ6i8+oIMu
 KyKsdjh2WXxpiEL+x05nwu+8ezfh/23djdGoI9KWm/r3LmXK19ude2xCUKuzkkiiYxjYr+d+o
 z1bLmd1NuKxw3MI8n+mv+9/F0wgH4Y+BAvdn3h0HBfgAxhRFXwoDuti9kliAByVxXzigSIh/K
 4H0kx8FBAhae5SnICKyjaLRGqzh8pV4ccgyWCjbux5WJFKXbg8YaIcEOw5V3shWySd/hwhdEw
 oSjHafJ1FLE9W2Jj6PEX7vSzn08z+L457ciQVUQ3oc8/blZ+x4mw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3HU-1qU9hP3DTM-00FSZK; Tue, 29
 Aug 2023 00:04:31 +0200
Message-ID: <8bae8d14-3f8d-402b-9e0f-850c7dc92126@gmx.de>
Date: Tue, 29 Aug 2023 00:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] cmd: gpt: Remove confusing help text
Content-Language: en-US, de-DE
To: Joshua Watt <jpewhacker@gmail.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
References: <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230828215623.3727536-1-JPEWhacker@gmail.com>
 <20230828215623.3727536-2-JPEWhacker@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230828215623.3727536-2-JPEWhacker@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lgDrvHnKaCgGcWMovcXZuFn+9mnOSSmygQ68L+FPos7q6ZE3/Jd
 Mr7a1zozRB/TuK78Fq2jm0Z8CsIi0GB17kLRnJahDQoF3p6nuKoC85E/6B/3oMX5G9Js7YV
 EAdKiJ4giA+8neqekXLZzFLX0i2BZ/4gMGOjaQoVgrowEIsDij4yLi7QmHrpFrXHiiC2Y9c
 n2xk2p1VbZUkvGs0tXTxw==
UI-OutboundReport: notjunk:1;M01:P0:9gPGC4Xgy8Y=;sJ7lzagsiuhMGeWyg/kjGD1TFAg
 bp9rRPIQNtXpShjDClv/fHIjIT8ZwpqqxK566juS6V6Vs62shWtJKlTCxj9OpP9wbTrk1EaQG
 PWzCC0ibRquiLOVl2qpcgUqJcZvcIRo6VURM8hVBDVH6dc/hajKrrPGBO1CD9dB6mwEdOWhvD
 eIWDha0a2sVou7q/spgWdWHiPoAxYo4JdRtzYHvWB+aB51Gm6RsQe8IsNtQhtvIzixwLqO52L
 UgKcpDC1EMC+03vhDmRQS++iL+7S0bmsmMDaqaV3VCX6VRI7Ofq9/ASltWjLa4V0D69CxoAJo
 +fJMf60NQ5rOJ0z8AMm8rgXrO9nQfLRpWvda/dIrUFDWMrTUeRz+dvJDRuamP9DlvTSQ/Yl2K
 PJvBJ85AL/xoqLRA4bnnK24adFgjcHYs6GmY8/qRPYgy6atE4ilL2KHnno5a9H7liSMES3ZkQ
 gzojU6N2Eex7yauoWM0oWv8MnU5E6tjZlOHZ2/Pg4zi1ucO682FUhQHqzIW+8FvD3bNgXnOzG
 ktl4RcEF4wIytDBj3cEN7w/TRDcUFJumLsPBwwzJMR5C8lbQt4pQf1RMDserAicKHWaiiGXcK
 EM0ZwVRqAWJnD5aqqBHuHXCSpj+Goi8yE5BPIeSLFWbtVtrkDkH0kJFbqEwjOSu/aL26ZbPVy
 KhDvKnLBvzqN9lpFDU4wxqoPApEjbUTGYp8nE+Oz/UdxmsiG3DP511FUznd/+aLwPbWJtoIrt
 8gibnUtxFXlgEXqbHhWqu5/jzoIqbA/j3ev+wJ6zOPNO2Qn8FPunty4PRQd/KqjZs/lC2CNkn
 ieyA5pdAmP/T1RaVuCBh08YR8SLdSTaennDBdt3MiMCbYe4Sd2rUp0rgUEOl8luFeWSHDAoAy
 vGYBAM0VDyxVad10/0qQ/9coas72A/HDqqVFo2+WWsuqcZiWelpSzBTR2QtOYAJm4wok2C4dx
 rJM99QPxuEUkSIZMnUljbiPq4b0=
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

On 8/28/23 23:56, Joshua Watt wrote:
> This help text appears to be a fragment of the text shown when
> CONFIG_CMD_GPT_RENAME is enabled, but is confusing so remove it.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   cmd/gpt.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index 964056bd28..fe9e06681c 100644
> --- a/cmd/gpt.c
> +++ b/cmd/gpt.c
> @@ -1060,8 +1060,6 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
>   	"      gpt_partition_name, gpt_partition_entry\n"
>   	" gpt enumerate mmc 0\n"
>   	"    - store list of partitions to gpt_partition_list environment var=
iable\n"
> -	" read <interface> <dev>\n"
> -	"    - read GPT into a data structure for manipulation\n"
>   	" gpt guid <interface> <dev>\n"
>   	"    - print disk GUID\n"
>   	" gpt guid <interface> <dev> <varname>\n"

