Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E45C25B78
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 07:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 339768823C;
	Fri, 17 May 2024 09:32:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CpfnQW3E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FA40883C7; Fri, 17 May 2024 09:32:11 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E4D687FA7
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 09:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715931129; x=1716535929; i=xypron.glpk@gmx.de;
 bh=gNL23OX4hPLN2lMnPbchyHEDNMnlPJ8Ocng+TXxATQo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=CpfnQW3EkA88XSOCyNnwLHpTCiFd6GjcpBGhgiNCkcw+pgfTk5y6hSomkPVd+h7s
 imiZlx1gO/7VFXbbkltEc6gkmO6gwr2fcuuwSpMDBLlbWJRax+fS+kUAhcxzvu7z3
 9LNyMPk1tbzzt3k//NDLwzUSLxGV43AYslegESmu9ArzxuewNy5GUZwz8q55pRWxd
 p05V/E2A7QcJadwN3dBEmPYdtnVNgbRPBtxudfoJTDpsATmgxJfnSzUKKwKWaXtDm
 GE3zca90n7BnYTpKzX7jo8gnWYtJQX25nktgQplVYcLdR2HLJVzFRWcInA+3exZrj
 YEwvMCdEpbFLPC0ldg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.55.2.71] ([149.11.192.251]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsEn-1sNk8F3sOt-00sx8f; Fri, 17
 May 2024 09:32:09 +0200
Message-ID: <ca354685-cdc4-42b9-ad84-f3d8ed05154d@gmx.de>
Date: Fri, 17 May 2024 09:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] doc: Detailed example for netconsole setup
To: Fiona Klute <fiona.klute@gmx.de>
References: <20240514202041.386027-1-fiona.klute@gmx.de>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240514202041.386027-1-fiona.klute@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/di/BrrsVGmYlktB161alqI5XLDzEWsBeNzCpCHUYaoLuvONa/S
 2YXnc+cxRXr0qlwq5M5iZwJ33LCOhZjWr4dydyAcXTL2zZG4ml4iBbX/G6m7wK4s0ZwcOse
 QgWBAY22+0G/Fp2vdmkF1S+9ORytfXgYYh7t+c+/p6BSOkf/SOyq1T7MkT5E/KP7Rxf8SS/
 KS/ouP9tv+1y8ocuXH5+w==
UI-OutboundReport: notjunk:1;M01:P0:mXpVPra//BI=;NbvNgO10qinhoM2r7IeU3fdsHO0
 9k+rOZit4n75L+w5aFlLsZScDFwPz+a9uDZBhPcTSo0X6BKJHHSw3E9pR7cueYOX0m7ELXEzg
 9iYBvua+CO+zX/RuOxUgjzz2IjUdTXxIBOHlbEm7oRLZFbHqyVtj4G8lFuI3nwuJdEiIUlPJS
 RlAAB3euBBjoS1Gvh1/KS/pxxusAIrJqbeizHz60tiS8oH3SJgR0VuFzvATT8VH/2FmWBWRuw
 NMqwWBHe8vAkyrFuBY+Vd/o1ua+UvxtunmBb/KI5SE32GGtg07lcn34NzGPZM0MpwbvG2zVbL
 pUERwYxUSxreOT6kXzSEIWGtCTmuP09vFxyGvOkVEyFtCi5GQar7L0SsDVEGjSmWsd88jJARw
 KWZrS6rDPmCwjncGcnTvdP3I3mLOQISJJfo26VwVDyMw+kd7rsjYxTO4hahItl2ZVH/osLvpy
 /XlcwGoNxwrRmsXunhQ48oozRklcwKjj6PFNXIRoVRUKxfbFuuvqivahOzGMozt0Gc1Rpnf6u
 mebqoKYSVmkw77Q2u8Za9gDUfKbJFYr96sYyK+/zvM8LFi1zJYwBycdBuFDLOYEkwGAiB6adL
 db0aNX2rK4JZ89uQhqbwe1KqgF2X5gX0+bO+AXu/P7/fO6M13t0HBBFkg0XUmkHLhcV+CxCH2
 V0nCeljIVvQ/qOLT97qhKPGcegTAXdc1hG06m0u7upPEx4COc+V5wMDtqNm17p9J75UQLLyyw
 lujqLdtR1mt4Um+FHHm85SnlTi2I2PuM1DCstGm0PfgfGtIWCFCv3KjFmk260MTuZA3eZ3qcf
 k3yZJAQQr60K3HjJi46QI/EYba9bfARGMU6Dexrfm92u8=
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

On 5/14/24 22:20, Fiona Klute wrote:
> This adds details that I would have liked to have readily available,
> in particular how to activate the network interface before enabling
> netconsole, and how to integrate netconsole so you can use the U-Boot
> prompt.
>
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> ---
>   doc/usage/netconsole.rst | 33 ++++++++++++++++++++++++++++++++-
>   1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/doc/usage/netconsole.rst b/doc/usage/netconsole.rst
> index 2aa3b9ccc5..0c983e6970 100644
> --- a/doc/usage/netconsole.rst
> +++ b/doc/usage/netconsole.rst
> @@ -18,7 +18,9 @@ broadcast address and port 6666 are used. If it is set=
 to an IP
>   address of 0 (or 0.0.0.0) then no messages are sent to the network.
>   The source / listening port can be configured separately by setting
>   the 'ncinport' environment variable and the destination port can be
> -configured by setting the 'ncoutport' environment variable.
> +configured by setting the 'ncoutport' environment variable. Note that
> +you need to set up the network interface (e.g. using DHCP) before it
> +can be used for network console.
>
>   For example, if your server IP is 192.168.1.1, you could use::
>
> @@ -107,3 +109,32 @@ as follows:
>
>   Note that unlike the U-Boot implementation the Linux netconsole is
>   unidirectional, i. e. you have console output only in Linux.
> +
> +Setup via environment
> +---------------------
> +
> +If persistent environment is enabled in your U-Boot configuration, you
> +can configure the network console using the environment. For example::

Thanks for adding this information.

Prefixing lines with =3D> makes copying harder.
If you see value in showing the prompt, please, use

.. prompt:: bash =3D>

Best regards

Heinrich

> +
> +	=3D> env set autoload no
> +	=3D> env set hostname "u-boot"
> +	=3D> env set bootdelay 5
> +	=3D> env set nc 'dhcp; env set stdout nc; env set stdin nc'
> +	=3D> env set ncip 192.168.1.1
> +	=3D> env set preboot "${preboot}; run nc;"
> +	=3D> env save
> +	=3D> reset
> +
> +``autoload no`` tells the ``dhcp`` command to configure the network
> +interface without trying to load an image. ``hostname "u-boot"`` sets
> +the hostname to be sent in DHCP requests, so they are easy to
> +recognize in the DHCP server log. The command in ``nc`` calls ``dhcp``
> +to make sure the network interface is set up before enabling
> +netconsole.
> +
> +Adding ``nc`` to ``preboot`` tells U-Boot to activate netconsole
> +before trying to find any boot options, so you can interact with it if
> +desired.
> +
> +``env save`` stores the settings persistently, and ``reset`` then
> +triggers a fresh start that will use the changed settings.
> --
> 2.43.0
>

