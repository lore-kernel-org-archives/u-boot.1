Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8D6C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 12:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9179A82E9A;
	Mon,  7 Apr 2025 14:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=cknow.org header.i=@cknow.org header.b="y2mYCb4I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ED5B82D0C; Mon,  7 Apr 2025 12:27:20 +0200 (CEST)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com
 [91.218.175.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DABEF82CF4
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 12:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cknow.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=didi.debian@cknow.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
 t=1744021637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/6m/nJUu/Y88nbC5WK/AjQbFlbCAIlA9wrJR1T7io6E=;
 b=y2mYCb4Ijmfm2RlqIx7/Qmbjj6sIwGRPfNDRfRGjodJ4PLU/E+w7+9b8TzQv4ZusBLajUp
 0zNKgMmJzspdDQ6RMb3zrg1l/bB2xji59ZZZJNcl1ZHwZCSI1fzYq9EdEI0T+S5qp/BfNN
 inqkYokMhL/OIfMFU9nyavT+Hpnas/4rWZo80D50Fw0pgigLSdKGEoISLAd5vRBKcuiwtF
 mRz+i6lvrXXIBte7a158P0y3RGlxeb36klBfWzg+f5bQmEx7lp7oi98Cb2lrVm1K/7K2Ft
 n2V6EtuHpyeDvsHj3/HRIl8+ZK7c+xb0TJ4JRujMQvoU3jCUAeXO6FFLQYu90w==
Content-Type: multipart/signed;
 boundary=e67bfe6347b3aa36e547f5648e142fe07bcdc92f2c21d11fc22983397c1f;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 07 Apr 2025 12:27:07 +0200
Message-Id: <D90C2JA20RDJ.103XJHRFDLW4U@cknow.org>
Cc: "Kever Yang" <kever.yang@rock-chips.com>, "Simon Glass"
 <sjg@chromium.org>, "Philipp Tomsich" <philipp.tomsich@vrull.eu>, "Joseph
 Chen" <chenjh@rock-chips.com>, "Andy Yan" <andyshrk@163.com>, "Tianling
 Shen" <cnsztl@gmail.com>, "Nicolas Frattaroli"
 <frattaroli.nicolas@gmail.com>, "Jagan Teki" <jagan@amarulasolutions.com>,
 "Akash Gajjar" <gajjar04akash@gmail.com>, <u-boot@lists.denx.de>, "David
 Wu" <david.wu@rock-chips.com>, "Eugen Hristev"
 <eugen.hristev@collabora.com>, "Frank Wunderlich"
 <frank-w@public-files.de>, "Stefan Agner" <stefan@agner.ch>
Subject: Re: [PATCH v2 6/7] configs: rockchip: Enable ethernet driver on
 RK356x boards
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Jonas Karlman" <jonas@kwiboo.se>
References: <20231001191730.4167035-1-jonas@kwiboo.se>
 <20231001191730.4167035-7-jonas@kwiboo.se> <2086393.9F9pDXStbY@bagend>
 <D8ZTTOA3Q6Q1.39Q6ZX28395IG@cknow.org>
 <050bd778-3f0c-4f8a-9140-aa73a7943cb0@kwiboo.se>
In-Reply-To: <050bd778-3f0c-4f8a-9140-aa73a7943cb0@kwiboo.se>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Mon, 07 Apr 2025 14:38:56 +0200
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

--e67bfe6347b3aa36e547f5648e142fe07bcdc92f2c21d11fc22983397c1f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Jonas,

On Mon Apr 7, 2025 at 12:31 AM CEST, Jonas Karlman wrote:
> On 2025-04-06 22:09, Diederik de Haas wrote:
>> On Thu Jul 11, 2024 at 9:38 PM CEST, Diederik de Haas wrote:
>>> Some time ago I reported to Jonas privately that I had a problem with
>>> my Quartz64 Model A and B and that I bisected it to this commit.
>>> I just verified that the problem is still present in 2024.07, so I
>>> guess it's time to report it to the (right) Mailing List.
>>>
>>> The problem: packet loss, varying, but sometimes massive
>>> Q64-A: The packet loss was usually between 8% and 30%
>>> Q64-B: Packet loss up to 80% sometimes and this also resulted (then) in
>>> its inability to receive a DHCP address.
>>=20
>> I just build a ~2025.04-rc5 (i.e. 'master') version and tried it on my
>> Q64-B and the problem is still there.
>> Furthermore, there have now been several ppl on #quartz64 IRC channel
>> (on Pine64 IRC network) who have confirmed both the problem and the
>> 'solution'/workaround. Hopefully they'll also report here themselves.
>
> I did a quick test on my Q64-A and can confirm it sometime behaves
> strange when Ethernet has been initialized in U-Boot.
>
> At times my iperf3 test report ~0-1 Mbits/sec instead of the more normal
> ~941 Mbits/sec. After one (or more) "ifconfig eth0 down/up" cycle
> everything seemed to work okay again. However after one (or more) eth0
> down/up cycle the retries was no longer 0 and speed could instead be
> ~0-1 Mbits/sec.
>
> I will see if I can replicate this on other rk3566 boards beside Q64.
>
> Can you please try one or more "ifconfig eth0 down/up" cycle and see if
> that improves your packet loss issue?

I used ``ifdown end0`` and ``ifup end0``, but also with more direct
``ip`` calls and whether it *appears* to work, seems rather random.
I've noticed that ``ping -c50 <ip-address>`` is a reliable way to show
the problem. Often I'm in the 90-95%+ packet loss range, but I've had 1
time where it was 'only' 74%. But which packet number succeeds? I have
not found a way to predict that. If that happens to be packet nr 1, 2 or
3, that may give the *impression* that it (~) works.
That's also basically a requirement for DHCP to work ...

What was interesting is that network 'topology' may be a factor?
Most of my tests were ``ping -c50 192.168.2.1`` ie to my router, which
is also my (caching) DNS server and DHCP server (normally; I switched to
a static address for these tests).
I assumed that was the most basic test possible.
But 'technically' the route is Q64-B -> switch (192.168.2.5) -> router.
And when I did the ping from my PC, which is also connected to the
switch, the ping results were a bit better. Still bad (ie the 74% packet
loss), but not in the usual 95-100% I got with Q64-B -> router ping.

I have no idea (at all) if this could be relevant or this was just
another random score. When I use the 'fixed' U-Boot, packet loss is
consistently 0%, so I'm quite sure neither my switch or router could be
problematic. I have never noticed any networking problems (although
technically I'd only look when I notice an issue). Only with those Q64's
and an U-Boot with this commit in it.

Cheers,
  Diederik

> Regards,
> Jonas
>
>>=20
>>> And the fix in my case has always been easy:
>>>
>>> diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-r=
k3566_defconfig
>>> index 1ea8e0f40cc..641452f9162 100644
>>> --- a/configs/quartz64-a-rk3566_defconfig
>>> +++ b/configs/quartz64-a-rk3566_defconfig
>>> @@ -67,9 +67,6 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dy
>>>  CONFIG_SPI_FLASH_GIGADEVICE=3Dy
>>>  CONFIG_SPI_FLASH_MACRONIX=3Dy
>>>  CONFIG_SPI_FLASH_WINBOND=3Dy
>>> -CONFIG_PHY_MOTORCOMM=3Dy
>>> -CONFIG_DWC_ETH_QOS=3Dy
>>> -CONFIG_DWC_ETH_QOS_ROCKCHIP=3Dy
>>>  CONFIG_NVME_PCI=3Dy
>>>  CONFIG_PCIE_DW_ROCKCHIP=3Dy
>>>  CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
>>> diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-r=
k3566_defconfig
>>> index f61b2c181a1..aae5d66edeb 100644
>>> --- a/configs/quartz64-b-rk3566_defconfig
>>> +++ b/configs/quartz64-b-rk3566_defconfig
>>> @@ -65,9 +65,6 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dy
>>>  CONFIG_SPI_FLASH_GIGADEVICE=3Dy
>>>  CONFIG_SPI_FLASH_MACRONIX=3Dy
>>>  CONFIG_SPI_FLASH_WINBOND=3Dy
>>> -CONFIG_PHY_REALTEK=3Dy
>>> -CONFIG_DWC_ETH_QOS=3Dy
>>> -CONFIG_DWC_ETH_QOS_ROCKCHIP=3Dy
>>>  CONFIG_NVME_PCI=3Dy
>>>  CONFIG_PCIE_DW_ROCKCHIP=3Dy
>>>  CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
>>>
>>> IOW: a (partial) revert of commit 25f56459aebc

--e67bfe6347b3aa36e547f5648e142fe07bcdc92f2c21d11fc22983397c1f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZ/OofgAKCRDXblvOeH7b
bn40AQC3uBRuWmguTW0uiG3NU/eXlnlV9E9kIOQ/4ukJ4mTYtwEAwJTAbrZU1HIm
s8W0BQzw3e+CmYKbHgYQSowEkPgLBQc=
=V8j/
-----END PGP SIGNATURE-----

--e67bfe6347b3aa36e547f5648e142fe07bcdc92f2c21d11fc22983397c1f--
