Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA81D65C70
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 11:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B20FB895CE;
	Thu, 14 Nov 2024 12:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Ee5ZcH08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92E0A8960D; Thu, 14 Nov 2024 12:04:07 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DA6B89574
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 12:04:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731582242; x=1732187042; i=xypron.glpk@gmx.de;
 bh=H/fj9iwqqjoOcPexsilBItXOpLgezq4kQJOzWCnooEE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Ee5ZcH08V0gk/KYpUxaU/HB8pp0Qf2YrnYduaWCXx+wlHV7AOYx7JynKhqx/ohxs
 J2GHVb8z1swf2YsnfnBVkx2oYwj+hggVq5gCZ2Uo0tpr0xJCJAf9zToaz28DvGXEx
 AcgKkvrtXSqahCecFaJk8zLtiTqU/HotTwQyAcvOE4wK7Ue5SxwEGH45DVFUiFP8E
 NYGpOUJk2rzIbkqCTrsnM5vMDcv3xj1m6VBKvzaLxFLXYOszbvQsI0Pg/Bx/hADkX
 Mii2bveE7NF7ztdcIP+ragksK2zKK44GqGoePyqY4v/Q086Ml+pO4/bzKHcRB6tIE
 L9Yn+D9jvbFBWggYdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU0q-1tjVTy2aCS-00cvQg; Thu, 14
 Nov 2024 12:04:02 +0100
Message-ID: <231691b6-d730-44aa-a8ca-9eee3e7521de@gmx.de>
Date: Thu, 14 Nov 2024 12:04:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/20] command_ut: test: Move test into lib
To: Simon Glass <sjg@chromium.org>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Tom Rini
 <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241102193715.432529-1-sjg@chromium.org>
 <20241102193715.432529-7-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241102193715.432529-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XGe1FAOfR4jPbY0kKEN+R8jMZbVcLnOI9E/UuYQKB/iCdYZoa3a
 6Wwjrd3gDJqwb1AgH9ZSOnLHHundk2mSnSd5oDNNpIuXwJ2KBOcSX3W8ZKV657sVAOpSXFW
 CUISoWW38Zp1Bshsn7rYEQVqmJv+vcHUvCUX+b+y4ee6OTmb/+CH/f2iiQzYcYBTGzhufwi
 B1HQsDphYjxWoe6nxXvQg==
UI-OutboundReport: notjunk:1;M01:P0:XmPLChNOsWo=;Go+ohG1UJtmQKI/VlOdggVBUc80
 dHM2zYDZlwxRyL/o8iHfggIYE1U38a81wjyqlbZIYRxYtYDRyr2J02zGSHmAgMV6AMcZ4cOGh
 Alq8P4cI/wNYc4+rk5ojwXXi/rLQC0C8FfVzSERGE30nhNVSL/rwEb6Lzrds/Ga/nASgTUsSn
 5iJRenCvsaaIBBcD7+O1NZB6ebmFF5+i3BGLQ+hqKMefmasNJmmjjFu5aEMBP6CKCNOOQnxKB
 4rtoFu5gSPEgtWdyn1F1fgydRLAfytHXQYSVokJvMPVUc05472ZtRjon6uV7UytnUq0m6TxmZ
 q12n8wfv+JygL5+cqA+U6C3aCnENqlOW7Jnheq86sbFyIDcCX/Gx4MZndpx1pJUziYV0LOCIv
 iZRUTwzHskP//cKcFM6J2cRz7ZSJfB8vnMz0wq4k0hL03TWbnqkO5JJtZoiPcKMLMraAVarEd
 WJ49z9ZVDPmRPz2F+v1MfelzmzDVATfM4MQAXzInjMng+4gURWFvADy7sIbFTO6LXY4NIOtm3
 M0WU0Gp2Scc10/4D4AMY1lrb7ZPAh9FuB8dNRZl5PZZg/AkGVTRwX8HY2ldHDRNwXLTRxaivI
 0RTd7hJaIHQnkUOGeM5rU0GkYBLqMVUUM0sEPnEyR8TVfW3tfvwZL9py3gRvg+UI8HGZD9/S0
 UkIlwXo/1B0KBBjcYq2HZdafdg/1kwcku/vSwhhuxIbyFXYlSRFnxVoRZrGFwcYl0XexOzcGb
 dc0yzgbLwiMVaOCmnxVAvtZMTgn7zlOG5TQWvDWdqFy8wOcc9WZ758NnAJrtA1Hb3gfs8l5xY
 gbrc+OYRVrfQ0A/V/eathyacsHYNhGC2KhINP9VGWVY0xAI2YLLJQOf5f9QdBglNEXmn1xGhi
 nfxMs/uIN8t0cN/pDeJzIqlgS3sQQCP0vDA+/nayttwBP9hRRRDFugvGE
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

On 11/2/24 20:36, Simon Glass wrote:
> This test doesn't belong at the top level. Move it into the lib/
> directory, since that is where compression is implemented.
>
> Rename it to just 'command', since it is obviously a unit test and the
> _ut suffix does not add much except to make it different from the names
> of other test files.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   test/Makefile                        | 1 -
>   test/cmd/Makefile                    | 1 +
>   test/{command_ut.c =3D> cmd/command.c} | 0
>   3 files changed, 1 insertion(+), 1 deletion(-)
>   rename test/{command_ut.c =3D> cmd/command.c} (100%)
>
> diff --git a/test/Makefile b/test/Makefile
> index ff621344a03..48d8bc91ae6 100644
> --- a/test/Makefile
> +++ b/test/Makefile
> @@ -9,7 +9,6 @@ obj-$(CONFIG_$(XPL_)CMDLINE) +=3D bootm.o
>   endif
>   obj-$(CONFIG_$(XPL_)CMDLINE) +=3D cmd/
>   obj-$(CONFIG_$(XPL_)CMDLINE) +=3D cmd_ut.o
> -obj-$(CONFIG_$(XPL_)CMDLINE) +=3D command_ut.o
>   obj-y +=3D dm/
>   obj-$(CONFIG_FUZZ) +=3D fuzz/
>   ifndef CONFIG_SANDBOX_VPL
> diff --git a/test/cmd/Makefile b/test/cmd/Makefile
> index fe7a2165af2..6231a08186d 100644
> --- a/test/cmd/Makefile
> +++ b/test/cmd/Makefile
> @@ -5,6 +5,7 @@
>
>   obj-y +=3D cmd_ut_cmd.o
>
> +obj-$(CONFIG_$(XPL_)CMDLINE) +=3D command.o
>   ifdef CONFIG_HUSH_PARSER
>   obj-$(CONFIG_CONSOLE_RECORD) +=3D test_echo.o
>   endif
> diff --git a/test/command_ut.c b/test/cmd/command.c
> similarity index 100%
> rename from test/command_ut.c
> rename to test/cmd/command.c

There are CLI variables using env and others that don't.
The latter we seem not to be tested.

Maybe we can add a test like the following after your series is merged.

=3D> a=3D123
=3D> env set b 456
=3D> echo $a$b
123456
=3D> env print b
b=3D456
=3D> env print a
## Error: "a" not defined
=3D>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
