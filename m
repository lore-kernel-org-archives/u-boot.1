Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C19ECCFA00
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 09:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF3882A9E;
	Tue,  4 Nov 2025 10:34:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="j4ajNCcA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66064838CE; Tue,  4 Nov 2025 10:34:57 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F1A88144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 10:34:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1762248892; x=1762853692; i=xypron.glpk@gmx.de;
 bh=GXHEVZ4M2dgdc2HHyVZ8nzQKLj1+rPGvlB5xPVHnefo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=j4ajNCcAOsiE+TsKv31rG8u+3E+FS2+VL6+x5rumt8IDJEJCKw74KPEn5AiUCF/8
 8CWwGNxERAIA1nJK8vF0YTDauvWUH0jmEbpDq3sSCKg/dk/AXHnBLGP3Q3Q4JsyBW
 lxCrNxUofSd7Xq5SvL9md8FESb8e/oKjgWTI7vVGPo72Oubvf8jjEjzpJeyRnV8V7
 XCD/0TSqVKdFNWM3rsDpuIJZyaiO2Agw3P6V79zkF3JCYeBMgyTqNisJhKi7MvzBG
 LVHrwUHtU+URP/01zgeOn675gsS85FIP7rbgTayrO/jg7ZigCuLvrsACOXY3nMVLC
 vPjZXCpij7mP/atTdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.183.149] ([93.94.208.154]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHXFr-1vTBzJ1t1V-001iqT; Tue, 04
 Nov 2025 10:34:52 +0100
Message-ID: <ec2afdd5-028a-4ca7-85db-3c2e366a12c5@gmx.de>
Date: Tue, 4 Nov 2025 10:34:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: video: fix mode info in payload mode
To: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20251027205627.3742502-1-ben.wolsieffer@hefring.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251027205627.3742502-1-ben.wolsieffer@hefring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kqPqxnF9AkvNmWs51KCnWHUSqnNNR6VQmSUGrOslQ6muv0XStt8
 /n+x1y7oXPoLNU9EKWKd0oERiKKbYCSX1lmy4Wqyx0fMxs+vXqask0pAo9U/0trYSl+bzou
 rgEYuOYvYhbxvVQ4iLB/VKFz8ZdS8RqTfGzEJHtGaGhDEPEHIFDIn54Z5pykoYHDGn9/gDt
 KBdVtPOQ6EQmvnikv2Log==
UI-OutboundReport: notjunk:1;M01:P0:zf23HTAtv9k=;GkC7LuWGOA7Z8FEdra1j6OkuUHC
 /zkvERE9mxZtcBFdnTqg6VwYzQd7CqcbZ0t4l2gb3N0/q1fyvmDz1bXLwUWFnLidrNmrep02I
 Z2+1S5eIG8v8CwBzr6e/F10XARB1cNmLxCvZzLhl4G5KVmuFbSzRJ8TqTxVQzfENXcVM/EKCK
 OcwoW6GePmo7dWhZHP1+8Xuv9Sp1HBaOU2P1wRmd1pYhTFaD0MqBvM/GWxLPT/ToR0b9jUsu/
 vA2Ls0xXExt70cXiaDTxB8/vcZnZmEB/fitJbZMEnv8BynO21fL3pQFQt4e1iC3WvAqXXNw60
 I+RAWwitxfCYm3CMd0fVa7F07vHys+WfU6BQfi1y4O4+UYEWHmAvoPgOda1y1h1o5MHcpNYLB
 5y8L+ZMDgGsCOno6aF5in8gMqNDqMD5qXppqdt5Jd7bi/HI3GAEb3L/FcnKH/x4Da/d8MiHX+
 UG7Yc2G9fy52o6HV/g5OfaEJh0LgUIu0/YilPBJSZE1qfclj5NPf/5RKq9L55NcNRUVLo8EDB
 gEhh4UMr23FpwGoY+WnbTmHu+w6Ypr+F3eZKqq8bBI9V0cfOvqZsJKTbwGEXtI9SATb0mgqIt
 0cZMUeGWULB4bmfkR5r6VlHBKE59C5Bxqv3HuS3BOOpocnAJxZpW0wq8mcsMlcK/UVHbSusD1
 Pv6QSJLqxreKjdMUh0pVFryURdTthSXGvIVFcGcktyhLGNldA2AKp5Uy0J/d+O0V0gxMaLKpq
 dzd7UmGxSf/TIE7OfRtAmL7UUP7X+RUkF8YF/oYW7Cf+J5rme4zqCpbsS5YbVEd2tuqhitOpy
 SRVYei2b2ax4MhRSTyz0falgHNbvnKRnsve8HTasc60w6mSbNQkh7OAd823N6wCTaGm8TZ87o
 gazOkOQfeC47RLrwlPZvtCsvr255TxgC1mRJPRs01RK6jjmJGbmNOGHeaBzh170jg9tJEs/L7
 y2kjFxhINabIHAC3sbnwgwKM90s06yIjcT+BTwII1bjK7Wm7HMLOPtVy8ZfI7N3glsIoYMyrO
 OEAa4klZTihNpKDFidOEeWOjuChIMYtx/A4aTbjUsH1c19yqSn8yqENSB6j2cAGS9GF+I/uWB
 dyJMznIXfDiGz5LL9kcSFUn1TXpWA28mC+Hu2554Fy5bnK+LpeVR9K4ttt7drITuRKceKCkrv
 NFQWnrMaF1kjC9ReQ1Ty7chCGvxqCEeoDtXFJ0NV84hEZHL2sNz+E7JHIzv7/TUieszc79/qj
 li4vlPEKsq6Ue2O1oR8DlEUOUj3bm+MVVJtO2fd0nxX6URBg/gGNKxD0qxpvdTKiqQyJauR1R
 4oHSmQ6VvnQNSddmNB+GhFAGtud1pcnqdLr9+qzHx7/9Sv7RTZxkK7UoUd0U9mpga4UYKMxGk
 nBy34D2qBkn4fNOCLaW4/2gTWHhKh8uYP4fKVPIFZIHJ0DgSP+3kgBcDBX7cgSI5EgVcFcTO3
 QjpFesx/HANPOZdXNDyPOJy0EVON/WOQpM0I6C5XH4X6aAv+Z/n8rzhn2BYYJg5fIXjWrkFdQ
 fA/n82ylzdJNQy1SO/8NPOB2M0lOH/CzNLF2ftk7XHVggWl6rSxBgbdKpbAfKWgmLsVcDR7IM
 QfKMhd/I4tUtVhymRYfm5bdyrHO3vVhQei3s54I7IzNWCzUA/7wmaWSZKVunIzDYV7EhhFX88
 PdOlkWhIJBqKK0Ski51ZcTfDHGD++g3aYM3FRkKbNWoaOBUU1/q+bLkAFp4eMqp6B/cv9SQCQ
 imR8PzaLy7dARo1xOYOmSR8sOsuYy8cpdLRN+npHntPXSnLP6bA3vM2nn9lArkFYq5nlCK9pl
 mKqIxNfHFy3NAhFQud0RLy4PEmUYBag74jABzbVeTspFVU9fdY1ps+PO08sEomWzRp23eM00k
 M5QLRLGTGgspkjm9yPo8DgVpLWU7AE2uiL28/Xk+sE0guQDisrDuRHfQQ3ObNxlKHM5STXaH5
 HNhR7k61cK8ikr/cz4R0W/LtHVztavegvm5Qj75KITzwqdb41whltOL9By9itz3MhZVFCmRFp
 D7YuB5+BLp/2rbZA83Gx64YkkrAjAQVxPPFQPTS8y+FLnIm8RDjvvuZbtmAzGJVcrRaULDLKV
 xkT7k+eRQgy9rj1bTazskBsoBgjFC5O+DN4KZqS5ckbJ1/76cfb0f1icZBbktW2fAoU+/YPmA
 JkkGmFG62fKK44Hs55ED6/CElzA3ijKxvOr7RMT+6kf1iZDw2jVNPH6XuA7C9FcqaPmGSNDVK
 e7ICmUA81JGasEfJkiqaJoedjqvXVjD8pnY9DJM3w34q2mRRxHgDdUXIXaUVH0IO5z5zpaeq5
 O3X88Pk0vxOx+M3zak72VGkXhvp6gS/yflmFP0qFUMpfELVLQKPLbkf0QxK++CYtlvxNIlvAQ
 +D0Y+mBb+0E/TAHK9gLFvxqYXe7isul34SjYAGy6enjbHyWGvnlgNgmG9o+i8LeytBrUN9ATf
 6ruNXJhvV4+GMH6kVd//LyLdoVEL8nJhwbxXTkbyV1xMzv+swHfC/yqI+zGYhtTjDWZ/XRJcB
 I0vqA7aKFnfoHGHOsOwQniD2Oi98iKMM9k1Y1c+r/fetZKDf11wSG55mBcMSjj1X4OA24brn7
 cTMBQPz6dXyf5ka7Td2xtI0WduZG0n5fT8zsBkwRr7tJQjSOZdylI4zYKDm4d1nt6/NcO1skf
 METWI+m+Y6MIa/hkNLs2xl0QMGeeVMwfPJOeNHkDX3OZWELYPk+4FqhfN8BusQ6ayov0DXiPP
 oB8ucmrr3sT3NIO82yZJUzgiLiY6kqenSNKlUgz1RKb8TWtyJEo1qw4BiPWyVT1OLZwxTIDsy
 +RrbFd9YqCI2JOr50tYfxe09rZFGRhsF38cTmj4ruTbsEbnYd/BJmYqEkUqba9gYtZ90qL4a2
 //lVMnZTwvRtN4PqVnoMlXoNT0FLnhPC7L4xjfF855a2Pr6z7lEWfoNPNxwsZmVt62BubVlh4
 9oBdhh1XeJ1UzMYNTQOnqd2AioWmjukmMRRJv0LjLZvQgTIaXipRfpXUO4D19Rl0yTmdtxUjI
 BILe9lMhgBC15N4Zr9r9AnMXKg6LPzOIzjI5aod7AbZr0IAxjYMfmYGJarudrenih7vGNjKkC
 ycLkrVQSi584quBI4XBVkiVG1kBzbkLT3tqhE1bQYndNR2q0yyd2Xqfu0Sk9RZBEdB7TUOozo
 WRbeCtrxfdhCVVOp7cQjJO2gCk4j8WIpPNMBROd8DwIWSSrTV22zN5N6Km6M9PTfMBWoMXEvb
 ckzF7+nWsySY7sR8XnK0yO1JmPRNYk+wvtUBTnEuMRTQA15H8NWzvrLjxih4JCN5OmBwgblj8
 cXpKtROaWymWP1K2z2qGx06xQAJXmFL5jNScU0tl97OHc+bkW7KIfPqQM+RWuMbK2DV2KYgbL
 GbWRL40syCG219I4+mJI+9BC2LaYlFTEqE03pVIn/8h+p6+UvuX7+fgVNzrkJBZbMBI86H2yU
 gJw+F1c8ck5avwoYaDnwvzBOgr1UAG3TzsxT7GE/BwRynNuTkYN0LkfdVp7o71vPXp13EwATv
 IjiikD+6Jk2m0h/BQ6D9c/oJAoupS//qqHVxTSjLIuHj9pJo7YPY0K0pkVfd04urF4Hs/IXBe
 ww0vMJ/VX/3qKM/U3neiZ9ZVKBDuK9LL0mMaZ1pbOLI9GC5HY2kmT6/LgLWa1K8NsEmwozGXt
 bbNHS9kGJ9v0QeUmRXxwLtdggFbMeHfTea8XmVoNKDUL5hIg0NfeUhmMcbH3XgiGlqqOJskQZ
 jBmTHmrNyBIGPlcSBsAY8AAoe7X+shXoXRpJd4UQFf2sbAUzWIgUJ+fl40hOPQQepHyK4fwdS
 6fYaoCLHYKQ3ULmnN0inAaie/eNDDuALr0Lg5Lh4uEKIP+WP///VjT6we3VH5zgp/YlPSJnlp
 Q18uAb7tvA5kQLU7MUUuqbTNL5FsN1Hry7PRHQy4eexfb94fOzwlzSCehc0YA/tA7ryfIM3T/
 YbFv7cJKsHvCpztspMIJXoQq4Usmdqb/0xlyFpt4A9jcPjp769alsqd8SslGo7jaJvOt2hTae
 EQcN4eCaG4BT8AcdhK0SQqnyCxf0RKrXkQsiP12ck8l4JPUtehmCqksWMEYkAOEuVRqK1AjZp
 Wg45voYx6lgfqSWz0dN5jNob66EBQ38cVEkKNitl88jTTaIyM0N4jr68GZbb9DmsGG2/gxclI
 OHRVDnGU+SQwyrftGCQoN/HTpEX9GbjvVkJnGwZI2WJvMDfcjBeUfP88ueNm8VlO1VSGohtuj
 sX5OFxNCjLXqp2d7OZf/9WTTfmSZtkP0DdRL+cbo17hsL5ItnPGieqyFRVWVIg2G6V0p6VRdH
 y3VnFBOXhkM64PtmZAfbLDDDgN/lLeDGKqsOBTiB9qwd19h+wwXgwpZiCniylap3cqOEsMUhm
 7j/2ue7fpTyOiJB14z4SPebrp89lszQwhZauZMYFjfqKsWlasoxGaCOvowpw2UOFvAveVnF3C
 zJ4THRKHsjgdiZqTUNTQrClGmi4WxuDNNsZbjN7WwdKrMsOH4rTQ5da7jyzSpnzUQFOcs5tR8
 yxlhfc5/4Of0ShFUnv6mJz4Mb1zELgYDPdINm8JFzM0ARxH/vdBXLqa82I9lWtoukPEJXVBJk
 agZgfbGKR4Y2aCGh6wM5S8GSbf6WUooAnTJGbkvADGkB+v0YpApBtV1IaqygSIorv3EWRA+4C
 qGRQ0kCAApgsrL0u6ORnPKFcpdg2uEG7CyYD4cgau9lue9p6GyZ8DoSxMN9xsfQ3j2xnrXIC5
 OZ+HKstNH6CfTLUCIq8vOkPHvBDgt+nvWURwBETpl/L1+YZ7OiwwNotnnxS2Hwkj+xPNselgv
 AUrLzoFppuzusBwHclqi9k0nZlfL/4PGDKkrRa/XruKaghOJ/SAjimnQB1ViKkF3Hv+yMMOGx
 oEJLnb3/LHWCUg7qTAX0z62s5Um0P59CKy7EcheEv+8S6zs212ZURWlKXdfWD94bV0wiwwvP0
 Ps48xPjMRUy92yJf1oeMjdV5ObS7kYJ04zdg+GxOlXiFci1S28BysftOhxjLEtkTKP0Ah86sL
 VMxpdvhOldGiNkErk961kvXwST6d4Wtv2kllTNM43yTOjUxGAntkTSIW2KH0l8K247gZwbWoL
 UpAv/abXtPdFTedbU=
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

On 10/27/25 21:56, Ben Wolsieffer wrote:
> Currently, the EFI framebuffer is non-functional in payload mode. It
> always reports: "No video mode configured in EFI!"

Hello Ben,

thanks for reporting the issue that you experience.

How can it be reproduced?

>=20
> This is caused by a copy-paste error that replaced
> "struct efi_entry_gopmode" with "struct efi_gop_mode".
>=20
> Fix the type and add a cast to avoid a warning because the "info" field
> is declared as an anonymous struct rather than
> "struct efi_gop_mode_info" (see the comment in efi.h).
>=20
> Fixes: 88753816cf54 ("efi: video: Move payload code into a function")
> Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
> ---
>   drivers/video/efi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/efi.c b/drivers/video/efi.c
> index 78d123fad4be..60df4334f1ed 100644
> --- a/drivers/video/efi.c
> +++ b/drivers/video/efi.c
> @@ -104,7 +104,7 @@ static int get_mode_info(struct vesa_mode_info *vesa=
, u64 *fbp,
>   static int get_mode_from_entry(struct vesa_mode_info *vesa, u64 *fbp,
>   			       struct efi_gop_mode_info **infop)
>   {
> -	struct efi_gop_mode *mode;
> +	struct efi_entry_gopmode *mode;
>   	int size;
>   	int ret;
>  =20
> @@ -117,7 +117,7 @@ static int get_mode_from_entry(struct vesa_mode_info=
 *vesa, u64 *fbp,
>   	*fbp =3D mode->fb_base;
>   	vesa->x_resolution =3D mode->info->width;
>   	vesa->y_resolution =3D mode->info->height;
> -	*infop =3D mode->info;
> +	*infop =3D (struct efi_gop_mode_info *)mode->info;

The definition of struct efi_entry_gopmode should be corrected instead=20
of adding this conversion.

The logic in save_vesa_mode() which calls get_mode_from_entry() is=20
completely broken:

The element info is an array. Without considering which mode is set up=20
you will not know which entry of the array should be used. To get=20
information about the current mode, use QueryMode(), please.

Best regards

Heinrich

>  =20
>   	return 0;
>   }

