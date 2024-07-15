Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA5CC3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 23:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2387E882B6;
	Tue, 16 Jul 2024 01:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BvRKIvlX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 811A0886F5; Tue, 16 Jul 2024 01:09:34 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ACE687F9F
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 01:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721084969; x=1721689769; i=xypron.glpk@gmx.de;
 bh=Fss2BBlJ3f8nFpUuwwUEVBEIeRAB8E2IObnZgy0WJpY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BvRKIvlXlUf/D2rSekn+ynyX4F5eOChk5kehXP6n7JJbOtC6Ix3hrM9wGaUWR5sN
 vbeNMgYcp/bKzNaGhlla36yIiPuqcagbviUOmezsXGkH80401cVF98vyUmLSjHaEx
 bBxjBcW0lyc/4jHtmqSnPaUOtFqL104EYwnj+YRb9fWjFdoSip78AjXfEuQlpQ/a6
 W+deq35OlFujprA0N92ahFTEmpIFXUOgly1wvPawvVGoogwWW2Hpb5/f8ULTXrkQp
 5szo36MKsBTY+JFy4kPMt/eUsFyOaP/z3S9F9iGk9ufM0//QrnliMu0ZchZv8o1jW
 wZ5Pgsf6Xvhi2cd2dQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KPg-1sL98V0zvW-00rexi; Tue, 16
 Jul 2024 01:09:29 +0200
Message-ID: <b9af9c26-165a-426b-bb6d-f936541dc7f9@gmx.de>
Date: Tue, 16 Jul 2024 01:09:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] doc: Add a link to VBE from the bootstd docs
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nam Cao <namcao@linutronix.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-12-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240715101354.97895-12-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i8TPK/lRcuz9d7V11zToFhKxWvh1uuB7DgVUNYDy2JKjZYmTCUH
 Ll75TnRhosm0rjTQHJnjExtaAhkumQSVXy4irB/hE4quJDhvbywRmMZUq2DtYiCGprUBGIv
 BiBKxz1epU4Az5TDxAj1OjWjX2Wt24VkGJ1eIEOYJMhUFHgy4By6R9nqQHcpfjQjdBT09BA
 Oa++HhAgFjxkabQ7GDYBQ==
UI-OutboundReport: notjunk:1;M01:P0:r3aJJz1du0A=;u5/X/Su+193/f3JhJpml9m3+nvX
 FRFKfUt1Z3p2kKNjb+21KR26wN0dZx9ejmYO1c7F2sgT8YyQC6hor2A110WFgejPdqpyI8i9F
 /fOk2pjuCZv2bIC4kCSmY7he35FlusrOuAbpoTfYsbeoQ4KdXSEOYyz7Boj9QO6KSXSJrY3eq
 BpO2b5g7niQS2DN8DIMMgNfzcFG+bvfIq7Qn04LzBQZUrd59NV2GV1a13OA7HDSyWjFVQbDpN
 BVTpCabbzzxhOkBbUwH7r2uFXCGbPlBaAMyQcKbbPA69muqJYUP285aPaCF6LiFdy/xlh+HAm
 H1ILcZx3nDQYal7+Szja+aiSO3nBhwoKyd5RdANqzz9FaW3EUnYnp8x05dilbjXcSc444dl0h
 ftFa/ItUF7hmExvAp/LpA70skH3x5C9pLIg8rZhWkpoACQjk8j86uKCjG6P1s8ymh08w6crk5
 SFbZJndLGOUNpBsULKiHl1Gme+6JFjAugiulpN4SCxLbEJYDyzoIjMw0J1nN+pU0lake+24o8
 TdmvHcqCM1kD2uRjCzlZJbT+odl2uguxnGdaENdlSUTgj6o+vEW3APaQiVijOqgEjR4qYeixr
 KcjxioGRg2yn0T0j9KdXefsDGDk/WbmKDULVp0rLY18s3FUPakjws5eUMOXh0i+bKRUl2S9Sz
 cnzwQhreTG+k61QphoyzuRS4UGdXQRTQnWEhJ8Yz+dI5EowGmXN+6cM94/+MVUiX3BsFKk8nZ
 NDPq+dP8p7jdChfums2GA0LyOe0lPtAmVGqAhU61uauVJTUwWFIPFi8Ez3oz26XHpYfQjtWvu
 Yazd3utMz6z7LJ2rZzDEwVUA==
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

On 7/15/24 12:13, Simon Glass wrote:
> Link to this page to make it easier to find the VBE docs.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   doc/develop/bootstd/overview.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/over=
view.rst
> index 7d31d5e6427..0d7454246f6 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -416,7 +416,7 @@ Bootmeth drivers are provided for:
>      - :doc:`extlinux / syslinux <extlinux>` boot from a network (PXE)
>      - :doc:`U-Boot scripts <script>` from disk, network or SPI flash
>      - EFI boot using bootefi from disk
> -   - VBE
> +   - :doc:`VBE </develop/vbe>`: Verified Boot for Embedded
 >      - :doc:`ChromiumOS <cros>` ChromiumOS boot from a disk>      -
EFI boot using boot manager
>      - :doc:`QFW <qfw>`: QEMU firmware interface

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

