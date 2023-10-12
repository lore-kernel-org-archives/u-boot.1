Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC7CCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 06:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6F9986D02;
	Thu, 12 Oct 2023 08:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="e13idn6P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8F9F86D02; Thu, 12 Oct 2023 08:53:55 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC24B86CE8
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697093622; x=1697698422; i=xypron.glpk@gmx.de;
 bh=crCIDlQi8ewz0A89BrIeG32YsuSbmRr9kvfD+KSXyAQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=e13idn6PC4lYv/lFX2fQWUJUc8OOo8e9mZfoFgC28gzTgrfxZ8cmCLnAXLJsHpqU8aCUEzvWXje
 3FW1PX8VAL9mpifXHoPKKE+GHep1w+LJy8jwRmq9MKqyjd+x8RcF/wpK8CmBIoEBCfiofng1C+NHi
 k56F1bmPnniGdKG+IEODY0vEgJ1bXBQev141XuAcMvEjrZkUpoac0T6MfFQ9v3oUm6AetEjDOiZ4h
 zhjEeS1vGywV90CA0ofKH69NmBw085u7VjF3p5/JR35V0MPPThiOu7k0YF72juocJXCzWFGwIpirb
 vMkTPz/cpI6vnVEr0E9nSBAz+Cz/KPM+E23A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dsb-1rbnLX0ZID-015WnZ; Thu, 12
 Oct 2023 08:53:42 +0200
Message-ID: <0df59181-0462-4abf-9dae-26dc293c9a32@gmx.de>
Date: Thu, 12 Oct 2023 08:53:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/26] net: bootp: Move port numbers to header
Content-Language: en-US, de-DE
To: Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-15-seanga2@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231012015626.3487451-15-seanga2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uc8lIJSj5nx4c0Y7lcORx/LJemREw8PS8U6IyqFcDCTzFRPWsbK
 GfPzD0kCbLOQ+lgE1u5mj/mpZ9qmsyjfjTFKW8L7IEjjjOKOKUlD3tblc+h7Rb4qB/wF62Y
 taVQ5SAiPpfwKcEXH6Y7O997kXYRe7FmPiWzh/AD0GdNu7soq1b8KYIIAAB94m5hXell7z0
 QnXj1SoMsKKNabcsbe8mw==
UI-OutboundReport: notjunk:1;M01:P0:05n2lOWX8ys=;81oBhqQcaeH1KvzZAmTxkxvZrxl
 XfWi7MGBHnFJC/D4kWZZo1zk/dTqdqpU14DfKaZpD/QZ6jCQf7zwThFeV6RpGDDZJSQxfM+H5
 DLZK13WdTZbFo0oh6MquxIUsbQFhnr4ZA3exAqAhB5Gz6/o1uBC9uSIzYIYb/oC1f1OVmk8ab
 nsplL8nIFCFfMfywAODleOS0gx63K/fOMejPx68UtYJ+KJpiSCrvuL2bFuvjk/axiC51iRLlQ
 5G0Kv+Rx1aoMbOZtF+MUzc+kxZzL87qvTROqC6eKXGZfW2FPbwQu64+02L7eNlsQZSvTDP3fj
 5vfqB8aofc082MDBRnUV5EgpM7sOpV9wfcM2ZtbJ93xhAsaHxOladTDj6rifMdGcSe6uHH4kH
 mm/jgKJXt/z2SF/HB64977q2OK6OXyP2vzfos981iOL8wdKfug+PA+xsVSXvfl93ZXXCZBuG9
 NPxu0DebLGg34JJC37JW1XBFmIgpPit9C9qYfP4mTw8HQkq6nKMVwsW2BB5kKJyFGgVoLFuNV
 +21mxsK7ig4CA/X4v7VxAVxEk3f9iOOjKLUckaZqWhBrXv4AB9uQXD2ZRe9J8uwiDZz06sYzf
 fQixgl14mtsOxrgw43nwr3+U/cU/xCSdG+X7Duy+O1wCtkZm/ndLEp0Lh1Lry0o9YNclWk4rK
 ZFZeJBE+BQ4JFZDOPy7FjrDn5ZIbGABT7vZGUM00YLygUwEQ3BX7iahIwSNIn8OjbdgYvydrd
 U94zPnznfSC3ADiHglSGrRAOidnpZ0r7EZmSIqxJixi9u2mbN+p4kiDSSR0jlyZedwSfGH+ba
 ibp81uauckosL0aAaYJ7CvM1lsuIEVD6E7P3QkU7i45+4zYouWjaxiqzDKJXR82qHeqQHGakE
 17/MiwgKVLV/W8uTVO37GvZduIabdOEIMslC33uChqm3H35Py9Rv4T1c1n2hnWhWXeplUQ+5E
 VUsRqtduc5ZCCsqQg1FiyqplrzU=
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

On 10/12/23 03:56, Sean Anderson wrote:
> These defines are useful when testing bootp.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
>   net/bootp.c | 3 ---
>   net/bootp.h | 3 +++
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/bootp.c b/net/bootp.c
> index 8b1a4ae2ef8..2053cce88c6 100644
> --- a/net/bootp.c
> +++ b/net/bootp.c
> @@ -41,9 +41,6 @@
>    */
>   #define TIMEOUT_MS	((3 + (CONFIG_NET_RETRY_COUNT * 5)) * 1000)
>
> -#define PORT_BOOTPS	67		/* BOOTP server UDP port */
> -#define PORT_BOOTPC	68		/* BOOTP client UDP port */
> -
>   #ifndef CFG_DHCP_MIN_EXT_LEN		/* minimal length of extension list */
>   #define CFG_DHCP_MIN_EXT_LEN 64
>   #endif
> diff --git a/net/bootp.h b/net/bootp.h
> index 567340ec5d4..4e32b19d424 100644
> --- a/net/bootp.h
> +++ b/net/bootp.h
> @@ -15,6 +15,9 @@
>
>   /*********************************************************************=
*/
>
> +#define PORT_BOOTPS	67		/* BOOTP server UDP port */
> +#define PORT_BOOTPC	68		/* BOOTP client UDP port */
> +
>   /*
>    *	BOOTP header.
>    */

