Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B38EEB569
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 19:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0EA186A4B;
	Fri,  8 Sep 2023 21:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tn7WaSbV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5D9286A4B; Fri,  8 Sep 2023 21:28:26 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24EB0869EB
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 21:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694201302; x=1694806102; i=xypron.glpk@gmx.de;
 bh=PPoixplBuylQpvvpyhQT2WmiUQhkyM8UIaaYFlgqe1I=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=tn7WaSbVfVZ5KfgcBh3PFhdVTExxj7jgc7OOuPhZE7eN8az74gmrRrWtDRw8BMpQCKKsyRW
 9LCsuJJ6I2uY1ONJQzrYaS2qGvNAL0f6dfuBeJhRZxkh0kGYV+MTw71bJ/HjIEwFmJYblnuD1
 ajw670221s11wRJ7ckCi+jhbWEFF3WBpSojJXp7RpCDxaIgFGL/30aOwrG8qmNvE3/KcecKo0
 xUCL4bJAQ0pQwddijscOE1E97ROYUGcDgUrOeT/uGms4TlveOu3E+VlZYWtaOAicedpOwOzOW
 FLsZtHEAyhWQugcd6QLs6p7M+UDPttLDpYkdt5z7DWCb0ICs2DpA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0X8u-1pke3800qy-00wZ48; Fri, 08
 Sep 2023 21:28:22 +0200
Message-ID: <2e7387ce-e47a-4f51-8521-a43971ab62d4@gmx.de>
Date: Fri, 8 Sep 2023 21:29:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] doc: Update path to source_file_format.rst
Content-Language: en-US, de-DE
To: Joao Marcos Costa <jmcosta944@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, miquel.raynal@bootlin.com,
 u-boot@lists.denx.de
References: <20230907205045.15406-1-jmcosta944@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230907205045.15406-1-jmcosta944@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ci2P+ExMEj5Y0Aq0vc1/PKmkN6egdW9tllR6Zv4DPYCUeJoeW1z
 ICXJseMnmRfV5MplHl5lB+POU1+Dda+PQzlawGha+OyYcKvWVhgzSfvziBWrxhQnlQqZix3
 YQr7V8qgyG/PWjtzj/OQKJWU+awOPhkGN9ZqYCxrZXcXDwAPVrQ/AByBxLKUlkSXpyBwpN7
 TD4k3jrUtf4Tq7bvh6plQ==
UI-OutboundReport: notjunk:1;M01:P0:xD8xdVP2P8A=;evFRVj+bBgRnzRiXpUrAj7jCTS8
 YPiT6xrYeZAr0M9+PnlX9mAJ42djhUCdZgjcVR4mbvN1kWl8FMsCGhg9jt079KOJhF2GphVwL
 c6GnmWENW2WT/AsmvAHj291VIZMMUgBwDb5wDkuWlZoihTpWUT9V9gRjwYndI9V20T7h6IVh8
 kqRPNAFWax2WaWr3wjciGvyZB/DVHK7fBqnA7sTJpVV97mhisi7QiNC4ez04whUR8iRxfSLTh
 4lqbe++foOM2eM/4EcL/yiUp6k/tI/U3+rbwPtrLKccjv1yu95I9Ku3oRUp1ECGMIaQFLxahX
 FMZVbRg3slOLME291L+MCBZbECSqqJd4ID+/jZcciS3lH70g8KAT0UFl3U+htdXwcFV4LPduz
 iI8vQdBO6i9Qkw4L5Y0V2HK933iGje58WwI/haJWoupweupNnnJqbG+NkVM0c839CfTnq54d0
 ShFk42KwoPyhAaSJdEHmGeVLReXcpJAnx+AwWrtvbGSiJEZIf+V1TOK04rJrUJlaOaxvHRTqi
 zqFToT8evpxfUFVnsLFpGE5WZw9AoWvJls4ODaVvfhAgp3j9J9bbk21otwIWEZt8y4Rqwt66O
 rM1CgYjsVZ6/h+6q7fACH61cFag5vfptnJSpjyhVOn0bs1V1oEwOfGyRBNQXxgbJHO43W/54d
 DSKN5mgqYt7yrtl6tPfYLf+igBiuGNQ5BqALIx1pBCQ+nejFrKE32D+Jzw1kEE/tjJ7+t68GE
 yhdkd9Fg/tv5Ih1EbtMnfdeNa24R3TiXRTPjqGB4sTtI19u8+UyqTm6HrYuNBBTtb7SPgYfkl
 nHwrWXALx1soyx9PnlLASkipOOnByUgc/Lbm18wKALDnEDGjnz9cpeygwZAVPxLjlqufv3L6M
 V2S6EjogAjTlF/M/CXttedlG2VV8paFJXpSVNdLbiWrTw+4X3MKG2leKv3Liv7hqZYlm+9R0a
 UjdCOWA6omBhXhINblGbrNlywME=
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

On 9/7/23 22:50, Joao Marcos Costa wrote:
> Previously, the file extension was .txt, and it referenced the uImage.FI=
T
> directory, which no longer exists. This commit updates the path accordin=
gly.
>
> Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
> ---
>   doc/usage/fit/howto.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/usage/fit/howto.rst b/doc/usage/fit/howto.rst
> index c933703d1d..8b38cd534d 100644
> --- a/doc/usage/fit/howto.rst
> +++ b/doc/usage/fit/howto.rst
> @@ -22,7 +22,7 @@ for its latest version. mkimage (together with dtc) ta=
kes as input
>   an image source file, which describes the contents of the image and de=
fines
>   its various properties used during booting. By convention, image sourc=
e file
>   has the ".its" extension, also, the details of its format are given in
> -doc/uImage.FIT/source_file_format.txt. The actual data that is to be in=
cluded in
> +doc/usage/fit/source_file_format.rst. The actual data that is to be inc=
luded in

Thank you for updating the reference.

In the HTML documentation we want to generate a link here using:

     :doc:`source_file_format`

Best regards

Heinrich

>   the uImage (kernel, ramdisk, etc.) is specified in the image source fi=
le in the
>   form of paths to appropriate data files. The outcome of the image crea=
tion
>   process is a binary file (by convention with the ".itb" extension) tha=
t

