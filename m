Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E21C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 16:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA208870C;
	Mon,  8 Jul 2024 18:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="N98s4Bh7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0980F886C8; Mon,  8 Jul 2024 18:04:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1614B887B9
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 18:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1720454678; x=1721059478; i=xypron.glpk@gmx.de;
 bh=WQZy1FZiu8FU7Y99DyFlnhl9LMDNYzlN1nOokIl5C1M=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=N98s4Bh7J0cN2zmRxccmqF8UBpvHVU0hklhtjSdH23ixvrgl0NKv3xmH36GomzC5
 HT4Gu5y1DDsZgEcyUO9P//jPGubyHi1i+F/FiGN9nKE8YgNhyLqL9KLbs5qx02Anh
 nXtWPNNGC0uIUsMZmZ7KYpAHMVZ7iTjvq+CdRML+noMZYU2qlKBS/BRtUeIgP8ITN
 Bh0aFy/uCGa3HXZfrEJ3MI1vcd4dBeF+MkDw5QNncILnTCGGtUgaOHaOMDCmW910Y
 Yb8JRpVoyE/9HZK1p2HOOI0V4zaQzQAPy/RIt9hcYYSBmHhuCekn8g7eWzVL0BXMq
 Hc3RiANUSXtMqnhaBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.93.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5fIW-1sTbjz49fe-007xu2; Mon, 08
 Jul 2024 18:04:38 +0200
Message-ID: <99203b22-a57e-4f78-b4ad-221726fbf56b@gmx.de>
Date: Mon, 8 Jul 2024 18:04:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 2/2] doc: add missing table of content links
To: Sam Povilus <sam.povilus@amd.com>, trini@konsulko.com, sjg@chromium.org,
 u-boot@lists.denx.de
Cc: git@amd.com
References: <20240708153941.1045588-1-sam.povilus@amd.com>
 <20240708153941.1045588-3-sam.povilus@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240708153941.1045588-3-sam.povilus@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NxONCtFtTNiTjJ5ve75uyjwCxvnCdDQyA1BZDPtyxy+Ag0I8lyU
 w6gTT6069j8DlJ01YfcdvUu3vTFhPq/HX+TDJ9fFMaQv/xEySKaA9QuH+AbrfehDoynnip9
 yUFNV2SBjXQtRL4g5WlIxK6dpyxOYWylJUYkl5bKtgb6ODwCT+YM5v4E6JQPX6oh0vPeyPl
 Dgvw2vC7nUx/C48EoYGzQ==
UI-OutboundReport: notjunk:1;M01:P0:+j9I6ZxBheA=;6U+jrzoFo3V0PdNqgv/FDEK/cXv
 WEeasEUdS4VzhC3fR1mA7tzHSk5JLuJymMPHqjeAW25yVUYbwUD6GAIFjhl/kRJmMgN5B8JS5
 cloLWSPnRYh/N4gaFaQNFI/10nFlAP8sNCWiyopkKLjrDug5yBnfMgVc1MvQpJ5blLH6VrDUp
 swRHBaO009KNs+1OgcSnFGNqBAGSjzfsPSkVl5+jRVQrqGViNvyif3CRFow+1WtsFk2HRvinB
 5detxfv8Yu7vzYFSPzzQjC0lcbydHdNVq63f/Zyl9pcRCwa0EWLUuEbs11M0MKc+nPdclXx5l
 3+uaaVlxEOgHK7hD4O1zRkxIb+ETQ1/7w5IOrJbuWbYEWj92H3KWZxhrtsQVWxi0mW6VdSy9t
 ZHaRvpdgwzJ8/aaq9z2evj0wRISN+d6SrispPYxPsad++2cxS5cJvYWsLTKIWFDDBGjGelvXx
 2ehYty+CY4lH93xE1gmeTUsaw+ETqIGE7adW1AJNqnl9EbgMfhaM2O5aQvY39+eP1gl7+iuEX
 0UR9ku+fWBfz6/a47swL2m63FvaO57PQeDj7Y9Rfasr1+A6cqYIVAWh2r5Emdtm/zc3ohRhce
 PYpHKVylf//GtfGbB1bptTa21npw3aNvg+cLKGoHmp3vEtrwUXe2Gz1ZyyX0ro5lpl8Uo8Rkg
 FD2Tjwt/WWuYb+zZizeasoDcCTt5vX+7srT82pWcyzF5KkR+Q8GJoUakA0o1N6fmJMhlvg0XN
 LQPRR7bTwTcAq9gDJpfanWv2gwvctLTZm0M8EpzlupeBeKq/iZJWJLBgq+WgmickHg9gUpOdj
 9tmwXznVKZeRH0oq90PZR0JDNk4Siq4/vkaZlEM1jlbmg=
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

On 08.07.24 17:39, Sam Povilus wrote:
> add missing table of content links, make alphabetical
>
> Signed-off-by: Sam Povilus <sam.povilus@amd.com>
> ---
>   doc/usage/fit/index.rst | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/doc/usage/fit/index.rst b/doc/usage/fit/index.rst
> index af2e481212..ed28dc89ae 100644
> --- a/doc/usage/fit/index.rst
> +++ b/doc/usage/fit/index.rst
> @@ -10,9 +10,24 @@ images that it it reads and boots. Documentation abou=
t FIT is available in
>   .. toctree::
>       :maxdepth: 1
>
> +    beaglebone_vboot
>       howto
> -    x86-fit-boot
> +    kernel_fdt
> +    kernel_fdts_compressed
> +    kernel
> +    multi
> +    multi_spl
> +    multi-with-fpga
> +    multi-with-loadables
> +    overlay-fdt-boot
> +    sec_firmware_ppa
>       signature
> +    sign-configs
> +    sign-images
> +    source_file_format

In patch 1 you delete this page.

Run 'make html' fails on this.

When changing documentation, please, build it.

> +    uefi
> +    update3
> +    update_uboot
>       verified-boot
> -    beaglebone_vboot
> -    overlay-fdt-boot
> +    x86-fit-boot
> +

We should avoid trailing blank lines at the end of files.

Otherwise looks good to me.

Best regards

Heinrich

