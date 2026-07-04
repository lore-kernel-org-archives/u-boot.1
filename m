Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ABAC43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 16:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBF4683FEE;
	Sat,  4 Jul 2026 18:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HMKvJhBh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76B9E84119; Sat,  4 Jul 2026 18:46:56 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5505A8341A
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 18:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1783183613; x=1783788413; i=xypron.glpk@gmx.de;
 bh=Gff8mbL5TH0MjPpK1p00BIF6QXxvBZVfpYgootclnOw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=HMKvJhBhnlEadD3Enxs7uh+pS0h0CBLIsdUPYd0PEKueA+03flzLb3rRdpZK0pya
 SS2xJ2OnqiNDmWkug0HnqeZM4GNAtKHlrF8+YxYfjpsJDWYvBzd1r1n8lQUqjvC55
 eZK4vCItFW4IljOIRMXreSokQ8Qp4T1bzeNp/K0za0ydENWTa8TGKiWbR+yAQv9z8
 5FDnwFi8vTCJ9fmVmCvusUl+KauY0PM66OZiNm9kKGGu+YVoGmlWz1kDmd2+jNFpT
 NrQc/b68IlqxkPu7vSdvAnD0efwMU6wLeczJaBSH4Tq/xKVf4e7O3DP69h3NgZ11T
 ynflM8ACw8nZRLeWnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6dy-1xJDkI3MYY-00emSt; Sat, 04
 Jul 2026 18:46:53 +0200
Date: Sat, 04 Jul 2026 18:46:50 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>
CC: u-boot@lists.denx.de, ilias.apalodimas@linaro.org
Subject: Re: [PATCH] efi_loader: stop watchdog devices in ExitBootServices()
User-Agent: Thunderbird for Android
In-Reply-To: <20260704161707.GL749385@bill-the-cat>
References: <20260704135258.68543-1-ccaione@baylibre.com>
 <20260704143251.GK749385@bill-the-cat>
 <590BC3A7-BA5D-4346-8757-5379EFFFEFBE@baylibre.com>
 <20260704161707.GL749385@bill-the-cat>
Message-ID: <3167C65C-B0F5-42F1-BB51-3CD64F3CFE83@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:clFJl7avgcEcgWIGePnEenIAckMRt+vDSBrhlz+2/HGXDuKyojG
 s/gKWsxuU75nB1cs9g6ScWpY+1Z1TJLd/gYbmc/AZ5y3LdPhOkkZtKaUeGTjnF7te7MTwYG
 Yjb5OzZEVbZnWIVdWachH0mioLxGuXtIIsYdIHRH3wgNsOl4Ka4opMY5J+9V6oLlMryKVKs
 bYbcGCGtcWU6JErz6LIcA==
UI-OutboundReport: notjunk:1;M01:P0:2Q+x75RGDIc=;flk9f0/YYmXdB7y9KAFtAE3609a
 vOqL0n7kwR/1zobOfIJ+AB2C0SOeT8x8uw9ySgnhGahjofOnlrKhPajFguk7ywx/vcKk/IxfL
 wgFmNXFPytLJguqimTXZe2n3iYKLRw/og3ndwM4SIIjaS2p8//TOlImeuEj2/WzAq8I4ScixX
 qpW4X6FmVurzviA0c7e7pZZ324ZBHgVcVXGSxniqOT5rawhqdBi5ICb3GAb0E55hjNJjGiP+G
 NTZGtzjBd4zABvhVtnkvMVNmEwC7qjonSxCaduwRhEDOXHqCCOPMSaJJpGeC7p7qIJAzy0OjO
 vbUyvJdiv4wYeJ49J4Etg+ejt6iZNEZrzfphL18uLdQMK/f9Aw0Ff8aApTOlzax17tOvqIvO8
 YS80KhBrSJXf1BF/hE7qyNMawyAbeAZkb7ke2k3jRL+vBoFl1vKk7NixyUA3GHEpj+6VKzRrU
 0qav1iCSm9TpO41C3J1xINNZmreD4aWjph+wpWETNz8ABqxukLd0xhRk6HmYtK6C8CRgyxLAu
 2DhM4YP7R5bKBidRs3CupLWgAUbYIu3QM1rBjgBd90Qha+0JhTGlJIvuAB70UiJR6/f2dwXTO
 rVOsFAL7aY9K/qFrEuGTaYzCB3UIUDVotJurpU4jLZ5HzxFakk8lqjKGe277aDCsN+ZxAj9aa
 seWIhlAxbP+ACK8+JY8OokC9g3TMqNLCzsgM0ERBVSAPXFPV2T9HAwZp1hqda6IGQP5RIdBIL
 si6BljY0T34t85XlDb10IcEtbYG425F10AD5UcTktrRb6Alof2KG0nkVcaVXHldfuwPc9WxOh
 JdIZhzxwaO+ObXNv6jKMKtJjgr7HMbPR/LETe31PTX3K9I2CfLCPoMdDjBMKuhdq5VIg8/UDo
 XSah2xTdDMSgsvJ/HOsqTH7/lz7VVivycVWs4zNIJW53wZvOfv33sn5mH6sg7R/3EMPLRu+i9
 hGPZdaSSshQDXVJh/3P3Qr9o8KgF1XJox0O/nwuqVrp/MNJ6jdAI3p1GcUd3ZtfO9Jgbhq1qs
 UR28SeuEuZInbS/ouPBnDHFw8t8pYUSBS6AXHRA+5qRM1fCExQmBRyywCN3rLJJKRh6hstjBk
 Q9rFJvd6wu7SWx2IawD0IJXrgovco5Sx+WdaFMKkRubn1wmVZFat2g7KYvZWtFLSNohaJqoA8
 NGLBdwgnXdbL+DJAo0cQ4t4zu4F+CSZqvPANrN6eGCsUXLFutlBCSClUaXkgg+YqFI+vQswPZ
 gpbxJftyqKcbKDPrMlUomE2AjM8yq5cYe53vtfS1y77q+jguHd3oCyTWemzT++yeUR/oZqGou
 VuPBtWErX6F4WXy1lf8sUy2eEzKd5zdRfg0nN7XQ3uKhKGqjhhJVNNzMkCLCZnONBcm7tTaK9
 0jzba6cgEVzNqpaW40UHPsziIswxKfEyB6I9k00P6FuneWS2aZSk7AUtfgXEssdSqm9JnPSAi
 Jvu/xcYseHIYhDj9Ndy8LpMGJbVWpIupV9DWVgL4hRlPlhGzVWBTMAdB0/uXkQm7Mwe+mtOzh
 NUnti5YK2VFvylQLytjKARpT9Pt3A1xfiyH/4I2UMQ+5KlRXV7yoLf8XkdR/8ZE3PS8jY5Vtf
 XnUDDAB3kKhaU8vb8xKn+Z27z0j1K3sCHyEGF3/L2heDwAZHPU0zX1+tnQEw4nYbJe9HVjW+3
 CbVGDc2axdfwGDvDnNn6zgujkEUJWhF2RMKwCVTBcRgDTp7gyC9NB75MQO+1WEkxYng/mV3WJ
 mbfIwJXBpLN05vNg5tiTZh4ULlhLhslj4q9IckY29WfguEbTs+kcBDjk3TnAZR1S+hqsmxdkt
 Tq27y0G1+zEGPdi4++GQgb+VGQd9D2mi8IA27EuypyDkXpuX3gaklXS5O3O/aUymnYtxQXJlk
 h2305Ke/F9xUvmt2tCD01fCdYeemhC0oBtgGgEpIfTuqc7p6SrzQDhWWbRksPVmtZoN8AOLjX
 BBPi7T0KnyHo2bwJbe9dmpzR19FhU7swHVRmH5NwxaHi1yngJnLODdqtSPdBO4ogNnBDNVR7h
 quOPFeCBeSjmSK50bRvP1TiOENfMNIfIKEs7xRuN4HHy1p9EMbd1xBEqZlGtvnutUdEJ3GYy7
 JpxrSa/BAaQAo74//xlG9mzm/sWcLYz/yQ8BAA9Rb6rMrvcxW800zPkJYHFUkrSBY71I7BsFF
 VvsYX4HxTW3veuKQVrNKcioQnmA3DMLNEUAQB1e9b+lNilxWZ5xyKBwYAQ0DGfI11D06W5tSx
 WKDrWl95zIKY9vm7y4SFYGKQj+RWHSjvEVynaEHe4PfsC8vmPW9dxZUomTWXcJxGFAtA9bFav
 aMcl555zPhzyxhdh1486i7yEO+txGVOB71qeq6aqSrGdGPMFkYGUTP8c0r+ehvc9hb0+Jzubi
 VGajzk+WNL1L3xCj2nb7661R0IBBeWySj4yVXGJWW1hpj4PtOKK7+4nN/rqFIo+GXLDu5O0O2
 htJsqDh7IcGUv18t46Xpj9v4rDtsLpsFg5eXLh0TzJJ58YnlCZcFrgGo4KvrTtw7kObq7qrvw
 56gTeAiuIW/K68p9k1B1w+bbi7O5WQGOwwrbKu2qmfZpneBtSo6BWEcE6jT0URRwTLa/fzyBH
 8cJf/oQd+AmF+3pPaNvUYy0V/nY0OgImv3fCi3mtO8hA6PXyObOtNeXYZknvM+Y1TIigaXH+C
 cBHERVz0GNi1RHKVhGJOcgN12LjjmQak5seoEAHRzy7vlU0iJW6Hjtsi4f0IWXs0bpCZ0Upkl
 2Fixr3W9//5SV7uSuILYgPlfe/U8f+9hIyCHIL51HeyHww05ue2p873UD+TQC1quU4Axbdbie
 X8rRrzYPWKBDCwIU1tbE4llQoiA7xSmJJN4dfyChyYjRR9QY0RmuL9qYD3hKAsKqXbO1aDYC8
 iH0RpIOCRwjY65jfJgDw7mcybztLN4Ox3MyXqH4vFmZLyONKNvaH2euKSp5+87CuPUuVcWjm+
 FP7via9ssP0cpvUEG7yxiClgiVgs2Vdana9bTGcXUiB3LUAf3f+nRU+mK4iFYxX+YIUDi7qqA
 SA/IfwbjmxZ3Bi/4FFW1W/lC1xxPqbWO/0omcmLYgMWtizGZ4d3T+Hpppvah5nWCUxfiCD67Q
 nuPsM9vF+7UHwoW34F+dA0FEnICLmVJs9BMxgt/+XbCHkA67mgVyQWdd0qpozz8ZYXynTlxZX
 lZcLDhSDNPv+WLVA9hTVQc+B83/N9v2nUrXgPfrCskJ3Roy5bnhq6zgdlW26eGBbBKfanmAwc
 HfLLo1MQ08+efRyiGmQZZd3uP/LRXx2W50NXj2cwJZ1h3RAfk4OJLJmoO4EimbcSeq5KNyCkb
 XNtdZoLoTixbz2TvsEe6VAY20lFb6zSNyvL1UGOGXIG3GZL2OJst1WIaZaJL5vc/hrsIVdqb5
 E3qz29RUTPJ2AhhdDhbuRLlHu7X58pHiDr9hpIeAN2YqS4fYj2JIHrSnDADAkBUk/1AN8+3Yu
 mRlB7JQFDOdyOcznoRlmHGVYSRrziOkMyUwC7yZqBCpMBlDLnWQzFRrzSNA82EkT5PiN02vx+
 K/xYgUs4R8LXxQDrzB8z2VxecSLNm1eWQJ01l6KI62nYLKkPer+dz/vz4Y8BrMzWaUWbqzsAD
 dKLdrbID7D+Q0W9L0L76tzb1Lm6M+1hNrbTile9l9pJel/Z7uxh/4y7cS5GeOivguQMdX7rR/
 5DADDwA/+xD+FigHKlKs93j74jsdXDtbK+yAgK5Bx8v7CgWlhS3KAOmub3ss1bI6dfHM7gxHS
 O9E3jGZqLSOOOgyALdVlsmqhTE+he+LUk3w37EqqyTFcfx/o74h2ZwSWQdD0KTTaW6rS0csRd
 qvg4dI/5zLl/60PZp+e4vE4Gx1h6mFZsXyrqFa2mljlFhyprkOKwxPjHRDTcFJuYL5Nlcrz+z
 nqtzkKp/ShgoqQJ2JF9R0UYYw7YlRcXpJ04B0ISzablOIzGYjKBYAiEpkByeW6PGcjwViWoJV
 a6ftZp8kI8d3GEQM6B7P4gG0zXNVByh1wsf/FS7dWwtBj1wfNwvTvs8MIfDXX7Adtw8SV4Lgn
 3hzrwohXK4LK6qRyLBRnZwdn+tby8/ca7Bwf/IWhoctwM5ff1X7CX6u26mcXvIBsl8GluUcUu
 d3eWqCnz1exwCaFfHRuKgExeScL7bXDP60XWDqB/zDdKdGPPeOAvMFM3mD5fEDHbrCbuGadFg
 RjujLMR7T7JSS7IV2bYsw6IlmW95FPNqW1DP2SqXS9bCSTeI8XT+R7Aq3Sjgub2PUqJTWph3x
 i0kbwiMORSeWIlAIyWLSb9FFlU8Jfm/YQ+Le7Jefqbk7NFfrxCLLkqmgnw7TAAvpRAo0+5AoU
 gDyr5rlIWdPkjtvas2+uLZhEgR0oxQesjIcF1dtlA0cvfn6tIkn+kATt/bIjB37g5mtOq+xK/
 TUEeV9xXdJ5oRTDUwzbjeZSgCQSSnhxaiJhxtZ5RuRLXDMp5dN1WtxhpMGjKNng0m/qe+PkYz
 bO+daLB0KYx8ddJ/y4Z3pQUAMNYVCDqaWlWAIJxA2nPrSJkzm6flN9NKEludiXrRZ4KCVL0b7
 wgnsQkzSjo16Kd/ANzVcwLZi72qNq+4Or/tkbHh0Y+n3u+ef5kaBfrYYolpHU+SmU1DkFLu2G
 JwGKG4EF7a2n25CaKysPhm0RfGGOOVuIxvc/7a4JutpowcX3iINsRanavg0VZdorZLS0619Dm
 oXOeoHMPdHXxVa8HY+b6IA5Gg3feqpTxK2Fr1qWaj//C01riyuRPKb05/UwvuJmyePtb6IYFM
 LoXlIldU+B5G1UlqswvnEmjV0pMRGzLFWu2VUbMIo/lrpmk8kf+XBUvZSDsry8G3oiCTTgo8l
 fARTCELe097iYaL0KkmxY68fvSHVbjoPDLeePl43yIbeGuhbHngDHCMbt8wf83/yQGTiJTixo
 6eQ8ABLhzeEAKySCFEk9nIlDwZLse9BRjgxxT0Nbh6CLlHeN67nEl/OsDCjAYPsrDnAXsezU1
 QsqtuR4vyz5Wf5iPKcmqwPHbs74nsCr+kJDSwGatB9KwWPBJSIZD7xuyUwdZe+V190poH2EBN
 o359DzdebDxJOM5YXPxHtXwUslwJyDpyRIXyNiPtfCER/rcISytV7xxTMVfa2nOKNdiX4lIvx
 3CDgeLRvfr61CYOFh+4fA+soYmq1a35dAg6UGdrKQqrcJ3ZqegMXYkWNMs/+AgcaioMelebnN
 kaXRUvl5CWliNnO71XfrvGnTuVh0ahTEE9i6i7HAT6KHmd1hZXSvz7gJvbqQ6JAecjhoq+tA/
 Xr8tQs25ErR556acpe0jBxRbhzLfoPRWbgwTyqmR9vfbuHTOEZvx3Ggkk5aSl+CBxEXbORYmh
 CKd0PH8RWnAWZP6ygkG2poTvw+KsiKqUu9SMeod78Y7geQlavZeExAN5CTrn456ofXDR+V89w
 7D7Z8VeE787RwDggzkq+GZtYgxXB98khYpvSC63dAK9r2A3KX3PGsfa6TMxwfpctRu9tdiLgj
 zEaDo2GFZQq7r9NZMeQbCzqyu18cvXVbGNvx+DBDNjCt7Inhq1r3sjyrRXorTBC5RthwTl1c/
 y+/f8xp1jQHK6vRL0V1Eg7js9WocAm308N7+jdLBhHjIofkJCipJFW87QfRgyySjbNLk+Q==
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

Am 4=2E Juli 2026 18:17:07 MESZ schrieb Tom Rini <trini@konsulko=2Ecom>:
>On Sat, Jul 04, 2026 at 05:21:25PM +0200, Carlo Caione wrote:
>>=20
>>=20
>> > On 4 Jul 2026, at 16:32, Tom Rini <trini@konsulko=2Ecom> wrote:
>> >=20
>> > On Sat, Jul 04, 2026 at 03:52:29PM +0200, Carlo Caione wrote:
>> >=20
>> >> U-Boot can autonomously start a hardware watchdog
>> >> (CONFIG_WATCHDOG_AUTOSTART, default y) and service it from its main
>> >> loop, but the EFI boot path never stops it: efi_exit_boot_services()
>> >> tears the devices down without calling wdt_stop_all(), and a watchdo=
g
>> >> driver without a =2Eremove hook leaves the hardware ticking across t=
he
>> >> firmware-to-OS handoff=2E
>> >>=20
>> >> An EFI-booted OS that does not take over the SoC watchdog within the
>> >> remaining timeout is reset mid-boot at a wall-clock-dependent point=
=2E
>> >>=20
>> >> The UEFI specification (v2=2E11, section 7=2E5 "Miscellaneous Boot
>> >> Services", EFI_BOOT_SERVICES=2ESetWatchdogTimer()) is explicit about=
 the
>> >> one watchdog it allows across the handoff:
>> >>=20
>> >>  "The watchdog timer is only used during boot services=2E On
>> >>   successful completion of EFI_BOOT_SERVICES=2EExitBootServices() th=
e
>> >>   watchdog timer is disabled=2E"
>> >>=20
>> >> U-Boot's UEFI watchdog (an EFI timer event) complies by construction=
=2E A
>> >> platform watchdog silently surviving the handoff defeats the purpose=
 of
>> >> that rule: the OS has no generic way to know it is running, let alon=
e to
>> >> service it=2E
>> >>=20
>> >> Stop all watchdog devices in efi_exit_boot_services(), before the de=
vice
>> >> teardown=2E
>> >>=20
>> >> Signed-off-by: Carlo Caione <ccaione@baylibre=2Ecom>
>> >=20
>> > NAK=2E We have had this come up before, and in short, the UEFI
>> > specification needs to be fixed here, as generally speaking a watchdo=
g
>> > should never be stopped, as that leaves a gap where the system can ha=
ng
>> > and thus defeat the point of having enabled a watchdog=2E
>>=20
>>=20
>> Fair enough=2E
>>=20
>> For the record, the failure that motivated this: a pristine Ubuntu 26=
=2E04 arm64 image on a MediaTek Genio 700 EVK dies silently about 60 second=
s after ExitBootServices(), 100% reproducible, at a wall-clock dependent po=
int=2E The generic kernel ships the watchdog driver as a module, so nothing=
 services the watchdog in time, and nothing tells the OS that it is running=
=2E From the user's side this is indistinguishable from broken firmware=2E
>>=20
>> In the meantime, is the accepted pattern hooking up a wdt_stop_all() in=
 the EFI path via board_quiesce_devices()? That keeps the watchdog armed fo=
r the whole firmware lifetime and makes the handoff behaviour the board mai=
ntainer's call=2E
>
>No, Ubuntu needs to fix their kernel image to have the watchdog
>available early=2E I hate to be difficult on this, but it's been a known
>issue for years at this point that the spec needs to be updated=2E The
>workaround here is for the watchdog to not be started until the OS is
>ready to maintain it=2E
>

Nothing wrong with the spec=2E Some hardware engineers simply don't read i=
t and create watchdog timers that cannot be set to a 5 min timeout=2E

Best regards

Heinrich

