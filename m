Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB09C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 05:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D440C888A5;
	Wed, 31 Jul 2024 07:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gT9TLIZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8643D8890A; Wed, 31 Jul 2024 07:16:52 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5563D8889C
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722403000; x=1723007800; i=xypron.glpk@gmx.de;
 bh=F2XsOgdwQR62bO7pdFZsVn5uJpUR47W4tf3YcdssOgA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gT9TLIZnKPnqqa19KN8wZ/xm9ZDI+4CIHSBKB449DRQeVF7qS95o8Vhp9qyOhvY/
 0D6gq8kcl+iLVrUcXSa7x/xwtHQbuDRItlwjEcPunl5i51bgv0jkr1awjmcvrcBFX
 wUCSkmGW6jY0dxvgsKGg+UZ7bsT6BV82yD8qX2JKQ0sIw/iODTpozdID0aUIa1N9Q
 vXpEbFJ4lE+KVUScNfyQvYKZD2Dv+/9D4i3sNisR1Sc2MawFkXMJ3ivCpKaAozc0R
 ZyC2Ba2lTQGsqSAhYX3DYkjeVDzn/R6BaYsURx5dkAogSoAFQlnBSHpfoJgPh8GtS
 RK5/ivWgfT3A74XkkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ycl-1sX61b2AGJ-00B8zu; Wed, 31
 Jul 2024 07:16:40 +0200
Message-ID: <4de5193f-194b-41e8-a064-be66246852bb@gmx.de>
Date: Wed, 31 Jul 2024 07:16:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] doc: board: stm32mp1: add missing newline at EOF
To: Grzegorz Szymaszek <gszymaszek@short.pl>
References: <41ae952bf3f45545e3c6579463df3d0408f6343a.1722014005.git.gszymaszek@short.pl>
Content-Language: en-US
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <41ae952bf3f45545e3c6579463df3d0408f6343a.1722014005.git.gszymaszek@short.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nt37t8pDjyN4ABE9RAPO4kX1nxv+A8NRBlKYnHPCgDKVrYQ/v5a
 tjBKFIFVq/jMA6oegmoQOObUNxpiSqLEpHx2fzEVbwsTnhI2S0tgwgbBJlgpWQImh3/SgYW
 c9gSHhvzfAB+u6u1ntJREXhXpI/T1le1hZC9RZVkig71+gP5tmdECbxwRdFUJ8OZPyhgLK2
 NyuRdTG6zKZweH1qJChSA==
UI-OutboundReport: notjunk:1;M01:P0:1xO4CSqoQdA=;Pliy5Z0QDDInhby+L/PCLInhwdL
 u3F7+HmAuAtDHT52IjFm9iaDkSSlOtnfS4IzN04FEBLuxD37i4sB1HU849fWn/Njzw1QJMscQ
 sBHyleyt36QyiUTOccyx3BxHmUsWKo6f/0SIlCGfrkeag04n4pnmsVY1kBESWzjLs34uRF34E
 PNRZ+X8XgSn20qXNd+izFKd6ya5biz5Xj7lKd19OIJgtTZnP3l/7j4G1OTD5yDGjcO89u58/2
 hldQLy5JFNIg2FbLBmfo0DbxEI90zujoPfdYBcABZSaloyXL9rUCUNK5v74b9DQKok/UscmQz
 DApYh5wYatxgqh3WSw4UEG0mY1XC1fMqHoMFx9wtjre4BOW11kxsUxZMbPUsM87V82Cz34aEw
 EexxHTEWnFRgk8yJ5FDIAL3fOu6PhJrClH0Uqt+0G2Iydtp2hZdv0EQ88qcy7/zLaxOOw7ZAL
 V97UnpU/rfJTyZRX+fBP1TebvcqUMkcewkiuILv3w9JWtO4hXOJV1FjLJU+HFtRZTcd8r9aES
 ugJUrTxHSDeF7c0BpHTTI0QRc+69Klswvy1z4AmjtA8qGPdzF7L4L4DXiUKHchxKsmfOPZ2Jn
 a3NoThJYRSjZyWfxuD2JsADhYIXcNAkeFWmbpjrOMG1HGhIL7R06VYfbe/WVKlgmGy6rPQVl3
 MIAsEtYn/oQY5JjiJNsoCEJutalQqghDLr36jRe9HB0HpX73UPyW8CIZnMYJVbYtmpHnqu3ve
 h6NysZsSii9SmW6snwaZGpHhdn9VoFYo9i9hBZEBke1n4mmRRtM6ERrllngNNTcDSBzKFmH2o
 YhgcyEpGFJ28OcKm5GfDCNZg==
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

On 7/26/24 19:17, Grzegorz Szymaszek wrote:

Please, provide a commit message explaining why you are making this change=
.

> Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
> ---
>   doc/board/st/stm32mp1.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/board/st/stm32mp1.rst b/doc/board/st/stm32mp1.rst
> index 63b44776ffc..239e18b5e17 100644
> --- a/doc/board/st/stm32mp1.rst
> +++ b/doc/board/st/stm32mp1.rst
> @@ -838,4 +838,4 @@ Arm TrustZone technology
>     + https://www.op-tee.org/
>     + https://optee.readthedocs.io/en/latest/
>     + https://optee.readthedocs.io/en/latest/building/devices/stm32mp1.h=
tml
> -  + https://github.com/OP-TEE/optee_os
> \ No newline at end of file
> +  + https://github.com/OP-TEE/optee_os

