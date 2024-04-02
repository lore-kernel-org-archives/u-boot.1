Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D328CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 19:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4335288179;
	Tue,  2 Apr 2024 21:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=wahrenst@gmx.net header.b="gMms3BW3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9DEF8815A; Tue,  2 Apr 2024 21:52:13 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 163A388123
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 21:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wahrenst@gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
 s=s31663417; t=1712087528; x=1712692328; i=wahrenst@gmx.net;
 bh=IkJEVzoVILRNqLJbkzKMTwe00jiddmTrC/RUwaa2xn4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=gMms3BW3HUEZ6AWC5+Thhpqs9HAyRKONfGyDsk0rEb+yQ8PckqLFE6VaPxQc+raQ
 U4BKKs3eD8c8DjkxJ3XMm3PG2QFlSxX42JDs3wa/y7/0tZxUjHQitw/tArKSbwNGa
 mg5TTqNBII1eoJRHjzLLv5TBBT/FkcZqC5O37Xx3rWeSb4naQCzeAL3jJ8U7eY5Hm
 6tmq1Uh8+uacvzey2nszDfeSA8uaHgGsSYutf2G99/Wch6yemuBl44/rqcUReuz29
 1Q+zPyz6oTUiERAtieZwFbVZOi2Kn37DHRGkDDu/9DcGQdNEuSLEVRLPey1fo+Dlo
 FgluiuryZX5QWUqZiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsQ4-1s0VbM04jg-008vp4; Tue, 02
 Apr 2024 21:52:08 +0200
Message-ID: <2e15ab46-f29c-44ac-8a2a-8baa140ee1a3@gmx.net>
Date: Tue, 2 Apr 2024 21:52:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] dt-bindings: arm: bcm:
 raspberrypi,bcm2835-firmware: Drive-by fixes
To: "Ivan T. Ivanov" <iivanov@suse.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Naushir Patuck <naush@raspberrypi.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
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
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <bcf8093ab0ea6f3738bf4a4623de700a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HZGpeGLDEZJI0DgXnOrYDrVKn3dV6ZB3U4O98GuXVERWAufBKa8
 sKDQ5aJ/P09eRPvT9wl0XU3L8YN2wGLGZjLjM476f2vHYBL8jiW59TK3DeCOaDmelaFQWVV
 P3YdzbtPSXDFg6ENWWgoiowPFrxYsYQo24jbrTcVJYG8IGca4gPl5h/PbL8K3LLcQUFhKgj
 g56+DgcL8G6WntLXsZTfg==
UI-OutboundReport: notjunk:1;M01:P0:EYu2/wYT3L4=;y9y65saxcrZ0sPsUk8rgil8wZ58
 Mxj8i6l1eG77gJBl/Nqb7fvCLAbdtxjlISYsh6vcjU0ioDl7V5V7X3fp9JdYh4vKYbCp4V6Zn
 ZoY/n+j5p+av/EJPP2JMB5Stl+32d80OnpU6GdykYkRUjfLAnIUdpKCtRfFDhQmz/PUmkeq6J
 GFvK84qDFb+i/Iv8a2V6b/uZ4cpVJZtJwd94BZYGqiKqkxG1IlhZuxln8jeZVQ80kpLSAAAvJ
 Tt2gTARs/f+I8HqKhb3M283XovxDadZOTV0UAxwJf77+XgxrgBMfV8oPjPWLwyIoi6qkmeAxx
 l7PqK6Jyl4xFTm1a9fakWwnnUrq30AF9CERcOoUCy0olpgrxFXSlpJV8kJy+sBOsFF6ll79c4
 CAjsX9fKYyS2oRufA6bn7C3uWvXe0ihVCK4qiNIA8ddCTa3dwr21ypG7iaNu8X+wbmMLB4prW
 FALbG1z27v5EreO45xbiISCiWkq+OlrtHyAu4wa2gb8TlIF+tS6Y0yLnrniKaFAbhbpt6J1B5
 OvEZTcPuRGxnvpxp+Cj7wMYM32FZkpj767wIEzrXR53zL0BjPSGScF/MpECha9966Mvoqy7Ur
 NhVgEAwKH1EIQagUMMsl0RKNsfuT2jCVpsXROMA4rsfWfBveu36LI4+qzdtKL2csIBFiavopE
 yrmnY5gXG2Ejn38FJhH7vcSSWTMf85b4WA93PhRbVwHh1yCV0d2ybBgljGSmqH3yGkufywCko
 abFtBEqTwy9IEPIwrSH8JmJRwDD3QIC2ZxNN5CNkpil3UQS5mX9oe3Yuf4FuPdCBfqSKVRnzO
 Kbi2ytY9L/iY+O2gBg8FENs39TrSD1IrnGo5jOrHp7ty8=
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

Am 02.04.24 um 10:58 schrieb Ivan T. Ivanov:
>
> Hi,
>
> On 2024-03-28 01:37, Laurent Pinchart wrote:
>> On Wed, Mar 27, 2024 at 07:49:38AM +0100, Stefan Wahren wrote:
>>> Hi,
>>>
>>> [add Peter and Ivan]
>>>
>>> Am 26.03.24 um 20:58 schrieb Laurent Pinchart:
>>> > Hello,
>>> >
>>> > This small series includes a few drive-by fixes for DT validation
>>> > errors.
>>> >
>>> > The first patch has been posted previously in v1 ([1], and now
>>> addresses
>>> > a small review comment. I think it's good to go.
>>> >
>>> > The next two patches address the same issue as "[PATCH 1/2]
>>> dt-bindings:
>>> > arm: bcm: raspberrypi,bcm2835-firmware: Add missing properties"
>>> ([2]),
>>> > but this time with a (hopefully) correct approach. Patch 2/3
>>> starts by
>>> > fixing the raspberrypi-bcm2835-firmware driver, removing the need
>>> for DT
>>> > properties that are specified in bcm2835-rpi.dtsi but not
>>> documented in
>>> > the corresponding bindings. Patch 3/3 can then drop those properties=
,
>>> > getting rid of the warnings.
>>>
>>> since this series drops properties from the device tree, does anyone
>>> have the chance to test it with a recent U-Boot?
>>
>> I don't have U-Boot running with my RPi, so I would appreciate if
>> someone could help :-)
>
> Sorry for taking me so long to verify this.
>
> I think on RPi U-Boot side we are fine. API used when accessing Mbox
> device do not follow DM model and do not use DMA, but just access
> device directly using this nice macros phys_to_bus/bus_to_phys.
>
> I build new DTB files with this patch included and U-Boot build
> from the latest sources. No obvious issues on RPi3 and RPi4.
> Devices boot fine.
Thanks you, Laurent and Ivan

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
>
> Regards,
> Ivan

