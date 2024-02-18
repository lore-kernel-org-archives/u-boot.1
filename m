Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC51C48BF6
	for <u-boot@archiver.kernel.org>; Sun, 18 Feb 2024 16:10:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 684A787E43;
	Sun, 18 Feb 2024 17:10:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="D1vCz0WX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D280787E7C; Sun, 18 Feb 2024 17:10:16 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D72E687D73
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 17:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1708272604; x=1708877404; i=xypron.glpk@gmx.de;
 bh=28+KJtevXIAhxZezx9conwGp0j2yb+4oAX+ZjK8HjdA=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=D1vCz0WXuj2AUEfBDFk/CbrZeKdcKIg+cfMZKdgOqDpQDNWh1Dx5ZfCnzGZYPTvL
 rDyjWrwZ86aLpxttdPNfu4cWpDZcKlAuScQ7Cfqnrwovt6y16iAVvkDwAWUQdZ0PJ
 Wslhhwi0o6j1lWkmKx45iz6G9eK96HjBcZRSrogwaUkUp9rq5kB6g2/T66wRmHgOM
 r9Y25y73pqbj0em1/CPWWwP/DRKzxHS2x1vj4O8fdzClDwSlv4OC+mJv7n98Hw3Hk
 UsWzEGClV4dlA6Mbx9PF9W4kPjyYZYLOHbHwhgFqCJiUar2tsRfaTTUHwT6x+8jNB
 cffJbMxMu58NcZBWcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTqg-1rP8o93RXa-00WTmb; Sun, 18
 Feb 2024 17:10:03 +0100
Message-ID: <6f8d2b57-ce5b-4a8b-bc19-8ef23510f8b3@gmx.de>
Date: Sun, 18 Feb 2024 17:10:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remove Broadcom Northstar 2 Target entry
Content-Language: en-US, de-DE
To: Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240218111629.849167-1-pbrobinson@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240218111629.849167-1-pbrobinson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WgERDFL4CGmiGp0Bb+vg5XlnL0VgAC0Aq9UiYUfDDuqCy4Z8pKP
 owrUPuIT1Kb3wXrYTQSbLpD9U1waKvDQMb4czjjq1L3jLcK3jQzYG/Z1c1uqarXCOBWO4jw
 JXSHmJgcTn3c6znxuWcmUlebdNFLSTMila8d0YP4gqFqmt4k5dE1bPXdmC8YA/bx9V737E3
 0F71mPY4E741gik4G6Z2A==
UI-OutboundReport: notjunk:1;M01:P0:ZInQ/2ixEa0=;+rXdFSgdPmW/7hfuKfp30EJGgzS
 pHuv/5JbcqSsa9t86NpLRSc73z8GqZUwNMIOVM3pRzuk29zRlyO/5SkQdMkvEAZfrRQMy9d5n
 zebRzaYl8GA3Jceveiov9t7hKhFkzGdJMW9TLf6OSan9HM4KTFwxFykckHy5lapp1kkqaxy6o
 nJnItX/yO7w7ubO4P+jNK1TumDHDhyQD/V7B0cCy8iEZlkFr/7/UmsyFw6pA5On3dTzpWgLgy
 YFcQUoe97I1WMsbVb0ylQfSxV3fBGY6xvzQRPHJ9d6+ddU5Im1F6Tuek15mIz6xwxLJ1F2KOU
 VP7KneOkJR8RV9AMmx7oK5d8sZQjP2kyNekr2RL0vmlQDhC3/90DH5HGkFbv/RkqWpyGeicud
 qxhePJy+fYyKbvfRhIYT29AIv3e3OLreSnMRlFEKlvCP2d+QBKAAJyoxaWCy953WhorTiiyrD
 TgaX3SBes3I2x0u22PB2paVWqSSEbuJ5pXQbZ78+USDvQE6Lm8Wv5mtqincE0aUzEcy07f+5z
 YAd9OHNHpop01jDaX5huilGIdQTSnHHEWXBVz83XE0s1MBDWmyZjU+H6/ockbNQb4EedQelgT
 Jc+xmKB7GMn8ptnxcfAF56zR2y2cBhQ4d13u5ympUHHt4wKgFikTPc+wjn2Wt5PtOV3K7UUXd
 xEEjuabD2a3ndGgz4L0Z7w843VRrn8QGUaYgdA23pgZUoEtYao9yuNIJyU3/BkyD1uk9c3Ke2
 MR65A3AIaAFSLByvvWYseZj6T4AQei+0qhVh3bYjdFo1TZxsc1xPiYHAK/dkJUg4jGh5RPGfI
 /SuhDTwhptczt3U5Pzycqa18UclyUdn1PTIC4EA5xbqRQ=
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

On 2/18/24 12:16 PM, Peter Robinson wrote:
> The Broadcom Northstar 2 support was removed when the
> bcm958712k board was removed but the target entry was
> missed so clean that up as well.
>
> Fixes: d59bc09d829 ("arm: Remove bcm958712k board")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   arch/arm/Kconfig | 9 ---------
>   1 file changed, 9 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 6b072be2463..9367287327d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -699,15 +699,6 @@ config TARGET_BCMNS
>   	  ARMv7 Cortex-A9 SoC family including BCM4708, BCM47094,
>   	  BCM5301x etc.
>
> -config TARGET_BCMNS2
> -	bool "Support Broadcom Northstar2"
> -	select ARM64
> -	select GPIO_EXTRA_HEADER
> -	help
> -	  Support for Broadcom Northstar 2 SoCs.  NS2 is a quad-core 64-bit
> -	  ARMv8 Cortex-A57 processors targeting a broad range of networking
> -	  applications.
> -
>   config TARGET_BCMNS3
>   	bool "Support Broadcom NS3"
>   	select ARM64

