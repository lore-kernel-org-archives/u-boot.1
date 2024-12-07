Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEE9E7717F
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 22:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEF3588E5C;
	Sat,  7 Dec 2024 23:03:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gjcQsZOe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C552892CD; Sat,  7 Dec 2024 23:03:39 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43F8F88C53
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 23:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733609015; x=1734213815; i=xypron.glpk@gmx.de;
 bh=bTnWCc4suYwM3RrHs/nRjX3GaoWZt0dXHmOQ+kifzD4=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=gjcQsZOenvrH0P2AWdZYfMAdvGbEjYQZcGtfT4TKIijlODB6FlEpiyllUjo0j6/Y
 ZCKkbqChuLQ0aNnDwE8mrXgfp7WhH8zK18p8kNmfGBBiplQEBgTnWFMvR7c1diADN
 5eF2OzCxL3Y+6AP/vmU7vg7951hCJZ9/KEs+geGLPaJ586cdIZB82cHY4UmP02Gjr
 9obDi3tjuTKrxM/jC7owL/7t5TPU+4naWV0R+J8kUQGV36dbTBlPDtXf4L4WkS4MT
 nJ8f8rPByVmqD4YIMJ+asu3mja/YMIS6i3z1VLz7eZYsxHzNQ1+WNkMWb9qTPM88r
 dI7jz9RWiZbpaBvx1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCKBc-1tTQY91xY2-001hYn; Sat, 07
 Dec 2024 23:03:35 +0100
Date: Sat, 07 Dec 2024 23:03:32 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: UEFI messages on startup
User-Agent: Thunderbird for Android
In-Reply-To: <20241207212749.GF2457179@bill-the-cat>
References: <CAFLszTgnwTtUdgSHu6-1AC7cFU-oBNSp3oHAFTzisG5LmWs4gQ@mail.gmail.com>
 <20241207212749.GF2457179@bill-the-cat>
Message-ID: <638B58C8-3E91-4EE6-96B0-13AC610F42C7@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EfUa4nENpVZWlIvEzTKvctrH7/hS3SrnVAHmVm04Ek3+wpBBLWl
 DcSOBQOpXeUrvYGWcCNYyD5Kvi4+jFTk8ZzcDXcHqIxC4wfGYQ/gmnUGHj2sHkY6bZ0qHfr
 LPcD7705Mb7dKNaeOSiDManyNYB3FvZ4ye5+l7Quma9tf4VAvlOLLGtvlVRb+IH0FUo2L3S
 7WtCQ7k4YUKA9XuU1LQHA==
UI-OutboundReport: notjunk:1;M01:P0:epNa3QFFpGE=;HNMPQxoT5N/1ZY7K9xnispFCjlv
 xOTuhjkelCr0ObF5hlO92eLjO3aX90iaJW3cVcT2Lc8H0HYVdOytYMjTiZjJL4C69VYi/zeV5
 XWuzRX3vHq2qsRGM0V1j62RGGGSfjaVJ6/H8U3WhKWUoP1n7298wUyeBa05x3HOLk4njR0ur7
 HapDDKbpYxLc9fBOZYJ2WTG4espOAqHsPW/tG5S8DbXAd/M95+Pyeng6bTnR0XFU/rozr2p5v
 DuW9jBjxny1ac7Da0odj/jRG8ddgEwIDxkqadFaEFseunTbu+zWWHDoxDcUr0axuYKS7bUfr/
 SKnulU8cZQ5GXiJHLT7c2yNjBtVMlzXeMX942sMcnWKjT7hK8BtcSh3D2dsvpbA1HKdWRJq2F
 Ok6yMg/awhChNQwHHsvcorCBsvdgWmy/1ldP+1Y4aj48amWAlvINtbfEe+S+OdVNKG/TtTLEU
 YLvHJboGj2EW5eiGZ/mzmu0fgxKJuNuRuVxLfp/qM7KkuH3gCH+YSCwsq/yUdG0C3lU090ot5
 ct8rGnLbHfGffCf4pn4XI8rHH8zrncBEWsa6i3bbCImpDqa87NotqXZkSRrEymtHA/4ywEYGU
 PDoDUQ9zjAMm0ovVBmbL8kK9C4hfIuwdN0LV9Usz3KqZ7IXFCe2qKxs0xR/wdjECAowY15vwJ
 E1eI8NAf3ThgV2R+ocFGx4bPYvFiermlIwIUJMZl2/TNj+U6+2FWkhbyuNTd8RCuVuYqddOjH
 l57IRoDxhfRDsVrN/+S7MeUfVzEL0oGfAUE61kSqRddIalM5UtXp7KsQULrdsvJj/n9Tvlu6w
 JDuUconIU5TMwcEEKMUEqH7FbHFO9yA4tykyOZEz9QeUL65LfoYgxvLolXd8VDWXasqRu0Xvy
 ukoEITEjjO6cWLeiRSS+xkqLn95DCc9dwZD0jhRTCpv16c7WbcAjJYe4MRW1w0IQ6FtpHbkhT
 dPs513+pJsazPQEjijlYY4WWSULBn0vEFqGXKnZxzfXYDJqCCoy63MxjgpFbGnrMss4M3//H3
 TV14/8yztU8kuhLCQ+VhkIhowFpMeNWflrrn1bXgI5tkQX6ra501NXbw/FmBNiYXjI3dBpfSI
 SmKyGmc2oX9QKQFEsOJuyauk2IL3bf
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

Am 7=2E Dezember 2024 22:27:49 MEZ schrieb Tom Rini <trini@konsulko=2Ecom>:
>On Sat, Dec 07, 2024 at 01:48:41PM -0700, Simon Glass wrote:
>
>> Hi,
>>=20
>> I see these messages on startup with a rpi_4 - what can we do about
>> this? It happens on every boot=2E
>>=20
>> ** File not found ubootefi=2Evar **
>> Failed to load EFI variables
>> ** Unable to write file ubootefi=2Evar **

No, ESP was found to write ubootefi=2Evar=2E

>> Failed to persist EFI variables
>> ** Unable to write file ubootefi=2Evar **
>> Failed to persist EFI variables
>> ** Unable to write file ubootefi=2Evar **
>> Failed to persist EFI variables
>> ** Unable to write file ubootefi=2Evar **
>> Failed to persist EFI variables
>> ** Unable to write file ubootefi=2Evar **
>> Failed to persist EFI variables
>> ** Booting bootflow '<NULL>' with efi_mgr
>> Loading Boot0000 'mmc 0' failed
>> Loading Boot0001 'usb 0' failed
>> EFI boot manager: Cannot load any image
>

Neither mmc nor mmc has an ESP with EFI/BOOT/BOOAA64=2EEFI=2E

I think these messages should be debug only=2E

Best regards

Heinrich

>Please elaborate on what your boot command is and what's on your SD
>card=2E I don't see that with just "bootflow scan" and I think an older
>Raspbian on the SD card=2E
>

