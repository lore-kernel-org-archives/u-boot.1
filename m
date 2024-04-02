Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29178C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 20:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D8E887BE0;
	Tue,  2 Apr 2024 22:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=wahrenst@gmx.net header.b="swoWPG18";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D77F987FBC; Tue,  2 Apr 2024 22:22:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F5228787C
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 22:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wahrenst@gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
 s=s31663417; t=1712089359; x=1712694159; i=wahrenst@gmx.net;
 bh=EtKP0CQ+TpkA4UXnNV+4vRhHD9R077pswvcYeEVZ6zw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=swoWPG18R/zBNG7sDxEdsZtiMwgeLjpeZSX3P5soLPNdg1vSTLrqsq4ALKVre5Vz
 98IC6hVCrLmw8CRv87vG51Rl8wlMfHIv204ZRnCoLDnTFIlnBr5JZqUpxx6980CsN
 SZ4Q5QNdhlbAqLQgH8t+wkLzgY7CnFEH8Hc9dPQngf4x+9K8bipmZO10bkVZuTVRS
 zKUdduW3F9XQ5EpTnw9XLYHJ8Dv5oWtV6rXuz863CeoBUKVUnX4kQESvPsfPYo9XV
 WK80DYGDyjbU2sQbKN0yHfuivLG9jdd0hYaTgPGYLJu/eJepUli1b9mg5x6R803Y5
 adXn1451T00efHZWYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV67o-1sHVHN2Kk2-00S7kw; Tue, 02
 Apr 2024 22:22:39 +0200
Message-ID: <7eb955ae-b55d-485a-9c74-b5d7a9fc3271@gmx.net>
Date: Tue, 2 Apr 2024 22:22:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] dt-bindings: arm: bcm:
 raspberrypi,bcm2835-firmware: Drive-by fixes
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: "Ivan T. Ivanov" <iivanov@suse.de>, Peter Robinson
 <pbrobinson@gmail.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Naushir Patuck <naush@raspberrypi.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Rob Herring <robh@kernel.org>, Scott Branden <sbranden@broadcom.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, u-boot@lists.denx.de
References: <20240326195807.15163-1-laurent.pinchart@ideasonboard.com>
 <b044eec1-ae64-4de7-9ab0-e3fe756131ef@gmx.net>
 <20240327233700.GA21080@pendragon.ideasonboard.com>
 <bcf8093ab0ea6f3738bf4a4623de700a@suse.de>
 <2e15ab46-f29c-44ac-8a2a-8baa140ee1a3@gmx.net>
 <20240402200855.GA32172@pendragon.ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240402200855.GA32172@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+d3jbTgavD0pQE6h9Pzr8h+M1Ho7yon9VjRWpiERucJCK8K21Hz
 FgiEIC3LyoUElE7GRWCepg5BdqDXz+xXrZlFfavl9my6euiOqYFBbYfhsilkAceG2TODTL1
 t40zfrTzuTbQ9t03r2X6hXfghJVTCjC2ImAEa8E9J0dQJvpY98KRHerZeUesMZtnatCeRUE
 nJmCDBJIpzPCvj+DTHxAg==
UI-OutboundReport: notjunk:1;M01:P0:C23QAP3deNA=;HaEOdld/5VVrVAQRQwhaxbt3jNF
 PKtvsMqNFysU9GRmXGSIFcy3sQed74TRBZkMTrIlqA6Qclkhp3YTyzE4rNfgtucMirwfdgjVb
 qpiTTt4PeuAC6L0/k2IaMi4WfDb2NbnFQowz98dVahSsJ6ICwGjZCoRdfH5dhK7u4qH3pUc07
 g4gpeZS0+ssYPvTYM3FJ3AfPRS76iKijxc8UfQCEXoI2UjBpH+kbbbT4iB3O3GHpJifAKJsIR
 YMFNLvEoIG6J4KUS2tPhi0wn74OkYJxcjQZwN/Aee3sMotCi2KJYi1kyFPrXleOaxbKva3ogC
 FQVFN8dNSyfrvjsdwcMS9SE5knXtgI0YnBmHgkrDuBNScD0pfvHaULy+Czyo19B2UNOCVv+I4
 Sb8P4O3BXSCWIE8SmzEfRZbQ6AxJnAYI9i6zngcG7hkgHZY8LQqzNwTyYMNSI5llg5XiTFNnf
 55Imrj7/BWemR5d4rJ+NnMQkOxAh8BOJUmOHKc+RUYfD9tApQ7OsN9bplWbmdFVXCerZV3fbk
 tT+KYYE5HASc6KCSRljxEXY7xC6XthTW301+jE4CVd3nbYnHVh67+syCOYwZfBhM8Xmf49xf8
 HFD9k2kcK/JjziijKmHX6AwKOTa9wgWV42KhvQZL/amIsj/K1StrPDuNFPKHsTgaN61MTzodZ
 9n9T2PpQXZqRylx93XFh6rwuGiHATy8s1IktIZCirpbJBFwAWHEGY5auhaNPiVNKxnrf30FvM
 1O36Wh1RF/H001rvqxHlcKcdrdBK6JlC6ewLKwGKKD3QZBk5VgXwJ6isfy/2TMJYb/c1bxq4z
 0PxPemPySpevYah0d1vsySjN75O+RBglpYxX3WiQD+oa8=
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

Hi Laurent,

Am 02.04.24 um 22:08 schrieb Laurent Pinchart:
> Hello,
>
...
> Stefan, I'm quite unfamiliar with the Raspberry Pi upstreaming process
> (despite having sent patches for ages :-)), do I understand correctly
> that this patch will go through your tree, or do I need to work with
> someone else to get it merged upstream ?
>
i'm not the maintainer, but i'm trying to help. Florian is the
maintainer, so i would expect this series goes through his tree. So
MAINTAINERS file is correct here.
