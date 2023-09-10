Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550A7EE7FF4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 05:17:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D99D1864D4;
	Sun, 10 Sep 2023 07:16:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="L7nXbdUr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E9886538; Sun, 10 Sep 2023 07:16:58 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0DF98642D
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 07:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694323014; x=1694927814; i=xypron.glpk@gmx.de;
 bh=iDMEXycCg5rOSEC7dtVPlIkAwvsmPaBh0uTbUfDU8ko=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
 b=L7nXbdUrMHoJRGwZFaG3uXGvn+ABmAi899WyTaW8mBKPJ3+QPB7eFghulEZtyiezejaggk4
 4j1qSm7kQw7mLvddIgOwIhuNJZmL5PurOvytr4wfSJeEOViBbBSqybkH8PsXfeUvZagd2kD2p
 vdd+dIu/LDnWqxxDtHHS9W97HFNFrZS6yGMBvDEQGoAv8Iy5m91Locy2IZrdNuNi5Vkz0V6bp
 bvlY62SBQdBPO74PF88VQ64r1+mwTM0gDSRTk9VlLXmwaLlw8NVEHiTmsjHxKJEf9gNQVoPOg
 RFi0x0e5M2twdp8ocVV4dpIreB1TqRKpByQScBkY5H0xgDdzPW/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXGvM-1q7ca0041m-00YiIU; Sun, 10
 Sep 2023 07:16:54 +0200
Message-ID: <a5ae2e45-b37a-4c23-8638-3e5aecbd58d2@gmx.de>
Date: Sun, 10 Sep 2023 07:17:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: doc: fix reference tag placement for Logging
 section
Content-Language: en-US, de-DE
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
References: <20230909135235.21242-1-massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230909135235.21242-1-massimo.pegorer+oss@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KvUCRoeSxhcI8D2claN7cPhYRmFVQxXdjMfuLLrW/DybZaYlhI6
 x4rM4rfGqpHy/NKRrCBVmTmDcZut966m65UCblHZNVP5lAMSs9IeYh/O03xR2RSN9spfxwC
 tgRK+/bd4ZRvWcghjfKvYv9ajRwo6PMkogFr/j6VYckkbz3hwIZUr/ZOYbaotTQCmNvLWqZ
 RH4KEoubNes6hjnYaLeVw==
UI-OutboundReport: notjunk:1;M01:P0:oaipjSdmad4=;5re5XcScRvIMQg5anRNC7Jd5RPm
 yptcD7t30SL+r6ZmCVauOKCVLvwvSsLFjTu+Zb+NAMPQYNkbjFljIwvmZaKKMD9YHNvIWOmQr
 /jU1ohyn/x5gVwk6SHW8KWUJc3UbHZUC+YJcweY200tkJl9cdZ8rDjahJR3DnMaAy0SFlBFVd
 kd+A7Jer41/FsRVCyGg/3mWU50pHZ1a9wzxsuHrKbJmUz+0srjdY7hqafOjNzWNT5O3hzHPyh
 YdHOhZ7LrjOvu04WMuXLN/8b5f0lee33RxXmsSx/AebA/nUFZv1YqXQCHr6aR+/MwD+zb6XSN
 TkSkydGuF6iPOBpGJcVeDhL+PkqYu7wTTVEbovNmZZnzvmpdzhPwg87F15aIog02EVU2ipIwg
 rkr7MfoZYThg9Qas8gSxpftAhbefSlcxc3v8CB5QsgDGi0ZFW8/c2uXjWsC+UKDXSbLlJrBV8
 vpN+WGkxU7HC0h+zyyMHtQTLIoZZNhcT8POKtoIhPAAbXx4CoFQtTec0zRztro9IpB2YYxIlj
 fPMXz5AxBujoo9DrtPsXvqXOEI6DXyobzaaMo+ett83ew/rGw/hgu1NAbQ4odo3HduUWLINxT
 ejg/SB3xFvr0dirqlMWuxqNqwv/9jPp6Xnqy1ZFEUNGGYn8SVBhNpwDe8of8H1PxZOeyIOj07
 7iIqOHavOIi8nvhJAS1tGj5f5vAqYBcJck+4m7u5Rs3pIcKE/vUjQC2qriylYCgmdMSwjoATb
 fV9u2PpS8vPRN423fZFXqzhxhbBerfLWeyAPInyBDdm1vLoRcS8aL3FGvxBnholimVP37HfZq
 VX35qJx3QjbuNWeiDtMQk9wMwACufisakjcsEgHD905JLUUYYpgvuCV/A2Yvv1HPzk+xO1qaT
 1+MwPrAH64HyLWy+rw85CJi7bVy5uoSQcNUauJpQpt6oF+KMoTH5owoQMWLDm9xo3UWn2YVNp
 NMNJGA==
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

On 9/9/23 15:52, Massimo Pegorer wrote:
> Move BinmanLogging reference tag after section "Signing FIT container
> with private key in an image" and just before section "Logging".
>
> Fixes: 0f40e23fd22 ("binman: add documentation for binman sign option")
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
