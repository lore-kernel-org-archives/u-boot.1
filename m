Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F41FC61D94
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 13:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ACEB87582;
	Tue, 21 Nov 2023 14:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="OO6DaN1+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9D8B875B1; Tue, 21 Nov 2023 14:26:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7560A87253
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700573174; x=1701177974; i=xypron.glpk@gmx.de;
 bh=MMCa+xQFZchZid5YCCrqQPWZx0hLDu/i4lTNwYcFvwc=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=OO6DaN1+g/zq4wUJAIS3PirhG6UICiObjBG800fBdxhQs/+yUSY6ufCPKo3JZ06I
 vdepqBtjmDs1mG1iFlMK6vFlDKKntVqxoGwx45BVhapUIhqZ6l79YdPEWMKsxnA60
 3d/d4WET1Axk+kMsuoe64CLjH/25s42k+hbS6SW8gdZLFynLnxagiNFNnUq7zmycN
 gMrGVEi9cOVS6LkF3cjwvzwvYZAbygT7Nnc57RC0vDGywOmt3VekOO+7NJwebHkfV
 9i7RpmZ7EecE1pwMug1oNakglRJe+Bl4jUAuC/ECB1SlUj1fyxnh1JjgErHnj9Jsb
 X7GDbZlcVzWGizD1xg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqs4Z-1rj99j3Ogz-00mtIX; Tue, 21
 Nov 2023 14:26:14 +0100
Message-ID: <0b74d785-62e6-48c9-82eb-739242ab1ab5@gmx.de>
Date: Tue, 21 Nov 2023 14:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] doc: clang: Update and correct support notes
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
References: <20230405234859.1446811-1-trini@konsulko.com>
 <20230405234859.1446811-10-trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230405234859.1446811-10-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zKcQbwd8jAmWgf+t3KagUi1CHuthTCIg/V9tlew6gS+0vq8T77x
 peR7uQw/1CE5rEEieeszBCF6I7oTj363J0GfHfuwoUuACIencY+chBI6heMpmRiTcJrc6c0
 CsY5ElkBi54+7nmBueSIqKLKZw5eBDs9EWCJvuXT0ZAYKVDvLaZLLaq0Fh0XK6LnKQrlAiY
 hGHKj19jVFEl3vkgtFT1w==
UI-OutboundReport: notjunk:1;M01:P0:YPmV8r6nYe0=;eOqLjWLZGbv+3qCq0ooH3c7U/Ck
 GSByTtB3mtz4E67Xc/YF9HOc0iyeI8n+ewtpLWsvuNoa9eTq0Gs8zZwn0Bvci3zXJNho9QLRO
 BZra9l75uoh7C15VAoUuUvxmc3MDxWxVhiY2+/XmAI+bEV2lr8CvBoqzoi6lOKlhCZBDaGYmM
 WQbuA2NorkMZ1PpoXRzt46hYQZUNXwYUtCvLHYRR2jC2SU2DUD5OV9jOwpyG0wWZaAsEI5J3z
 FD/9EkxJ6W5AG1GVZwljqWR0Aiygn4jbN2hneBSQ+kJalpKK5Y8kKsUCKtXCak6B2f4pCQZlE
 49tTpZ5AGXnzReX/gwoAy/SWvRO01ZDJljJljMg9nsOHjRvw1MAVg3whNbPvWf0laBbegzZaI
 dAZQMlVvwFM7aEjzofCGIU1mIdJX4cyKcNsC4t9L9jeO7q/HyjOfGYkKc0Ua+v5eUh8Ka+3zU
 M7k8uI1Osn/Hh7YfuWTyj2tRa5pEEyQFGBi5ifDcbXpXOVvbglU8KY6+nbnQuy4gremgTVuK5
 l+1c90W57zQ5CvQqSHezohjyn/cW34Qqfe85yIQdiALcv7Le9Nv34XsKFv9HlMf69o/MyREA2
 HSQZAw+64+ZYVXZ+RkNZrOg6v6njCgPpyK3caUmA7vi7qevawB2cLMNbvtkRWb1l6+2oaawft
 RwEf2x6zxTawzYlnQi+2w3Pv9iOv1FpLCSCIDqKVQlPmk/lq6o2AFZTzzeTAjYO6dyGcuLDn1
 tmYaNkz6HMy0l6Pbh6WObroPExJXRaVtCUVyyyNrug+y3Q8ve4IV5Zx5aaAWuhnUw2twyBapx
 cOB5catrMJbvl50PY9rTpQlBZvYZCG+N6uXqk7lIYqip4IrpaD1eGDcbcppXIP8hIZE09WyIW
 jJICTHkgYVX1jksSQGZYDcwTyhxGV0LOUz53kdv7mhY2jWyxJ8+5wqZdzIEciVbWkrmx9QGNj
 akrtcQ==
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

On 4/6/23 01:48, Tom Rini wrote:
> At this point, clang can be used on both 32bit and 64bit targets without
> issue.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>   doc/build/clang.rst | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/doc/build/clang.rst b/doc/build/clang.rst
> index 1d35616eb5ef..222487032ce0 100644
> --- a/doc/build/clang.rst
> +++ b/doc/build/clang.rst
> @@ -11,14 +11,6 @@ The ARM backend can be instructed not to use the r9 a=
nd x18 registers using
>   supported inline assembly is needed to get and set the r9 or x18 value=
. This
>   leads to larger code then strictly necessary, but at least works.
>
> -**NOTE:** target compilation only work for _some_ ARM boards at the mom=
ent.
> -Also AArch64 is not supported currently due to a lack of private libgcc
> -support. Boards which reassign gd in c will also fail to compile, but t=
here is
> -in no strict reason to do so in the ARM world, since crt0.S takes care =
of this.
> -These assignments can be avoided by changing the init calls but this is=
 not in
> -mainline yet.
> -
> -
>   Debian based
>   ------------
>
> @@ -28,14 +20,14 @@ Required packages can be installed via apt, e.g.
>
>       sudo apt-get install clang
>
> -Note that we still use binutils for some tools so we must continue to s=
et
> -CROSS_COMPILE. To compile U-Boot with Clang on Linux without IAS use e.=
g.
> +Note that we make use of the CROSS_COMPILE variable to determine what t=
o tell
> +clang to use as the build target.
> +To compile U-Boot with Clang on Linux without IAS use e.g.

I had a hard time understanding this text block.

Do you mean:

"We use of the CROSS_COMPILE variable to derive the build target which
is passed as -target parameter to clang.

The CROSS_COMPILE variable further determines the paths to other build
tools. As assembler we use the binary pointed to by '$(CROSS_COMPILE)as'
instead of the LLVM integrated assembler (IAS).

Here is an example demonstrating building U-Boot for the Raspberry Pi 2
using clang:"

Best regards

Heinrich

>
>   .. code-block:: bash
>
>       make HOSTCC=3Dclang rpi_2_defconfig
> -    make HOSTCC=3Dclang CROSS_COMPILE=3Darm-linux-gnueabi- \
> -         CC=3D"clang -target arm-linux-gnueabi" -j8
> +    make HOSTCC=3Dclang CROSS_COMPILE=3Darm-linux-gnueabi- CC=3Dclang -=
j8
>
>   It can also be used to compile sandbox:
>

