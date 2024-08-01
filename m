Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABF9C52D54
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0402D88B3A;
	Thu,  1 Aug 2024 16:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="aKa8UrJs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3323B88A15; Thu,  1 Aug 2024 13:32:40 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D879F88A15
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 13:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722511957; x=1723116757; i=fiona.klute@gmx.de;
 bh=f+7s0IJ5NL2kfXicxLyuD5dHsNjhkqWxUfbrXvpch5A=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
 Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=aKa8UrJsCJyWtCswBEj+V4IeKofhUXBIDwSPyopkiXw/+38XDeuewxA7vweIFbh9
 6AcWGqn4YJruPnk9PDwWBVQsAimhLq4WZ2qHLRPxEpZQo8ToedPBVNI4l0Y3vjDmS
 ygdNyGTs3aKuLmt/zOAAsGUrIaku2uyY1bNtv4xZwpypija+zUguZm2pJo7QoVwbE
 h1/t7lOv0TzwAVR1gn8cTEQKK1q95yqi6gJ0P1D2JWWJocyyRBntIGYsG3zpSCPm5
 HW5ZWts5laeGu9rBuiLRHmow5ZtYCPssaVpv1Ru4CG/I9H5d3F1jFMCc6oREOlG1w
 CpEN8o57hyglv9RZ0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.123.85]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Jn-1s4X4e1SXh-00dGPd for
 <u-boot@lists.denx.de>; Thu, 01 Aug 2024 13:32:37 +0200
Message-ID: <75114aa0-2de7-4f5c-b764-0953ebf08263@gmx.de>
Date: Thu, 1 Aug 2024 13:32:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE-1901, de-DE
To: U-Boot Mailing List <u-boot@lists.denx.de>
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 xsFNBFrLsicBEADA7Px5KipL9zM7AVkZ6/U4QaWQyxhqim6MX88TxZ6KnqFiTSmevecEWbls
 ppqPES8FiSl+M00Xe5icsLsi4mkBujgbuSDiugjNyqeOH5iqtg69xTd/r5DRMqt0K93GzmIj
 7ipWA+fomAMyX9FK3cHLBgoSLeb+Qj28W1cH94NGmpKtBxCkKfT+mjWvYUEwVdviMymdCAJj
 Iabr/QJ3KVZ7UPWr29IJ9Dv+SwW7VRjhXVQ5IwSBMDaTnzDOUILTxnHptB9ojn7t6bFhub9w
 xWXJQCsNkp+nUDESRwBeNLm4G5D3NFYVTg4qOQYLI/k/H1N3NEgaDuZ81NfhQJTIFVx+h0eT
 pjuQ4vATShJWea6N7ilLlyw7K81uuQoFB6VcG5hlAQWMejuHI4UBb+35r7fIFsy95ZwjxKqE
 QVS8P7lBKoihXpjcxRZiynx/Gm2nXm9ZmY3fG0fuLp9PQK9SpM9gQr/nbqguBoRoiBzONM9H
 pnxibwqgskVKzunZOXZeqyPNTC63wYcQXhidWxB9s+pBHP9FR+qht//8ivI29aTukrj3WWSU
 Q2S9ejpSyELLhPT9/gbeDzP0dYdSBiQjfd5AYHcMYQ0fSG9Tb1GyMsvh4OhTY7QwDz+1zT3x
 EzB0I1wpKu6m20C7nriWnJTCwXE6XMX7xViv6h8ev+uUHLoMEwARAQABzSBGaW9uYSBLbHV0
 ZSA8ZmlvbmEua2x1dGVAZ214LmRlPsLBlAQTAQgAPgIbIwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBOTTE4/i2fL6gVL9ke6nJs4hI1pYBQJkNTaZBQkNK+tyAAoJEO6nJs4hI1pY3qwQ
 AKdoJJHZpRu+C0hd10k6bcn5dr8ibqgsMHBJtFJuGylEsgF9ipWz1rMDWDbGVrL1jXywfwpR
 WSeFzCleJq4D0hZ5n+u+zb3Gy8fj/o3K/bXriam9kR4GfMVUATG5m9lBudrrWAdI1qlWxnmP
 WUvRSlAlA++de7mw15guDiYlIl0QvWWFgY+vf0lR2bQirmra645CDlnkrEVJ3K/UZGB0Yx67
 DfIGQswEQhnKlyv0t2VAXj96MeYmz5a7WxHqw+/8+ppuT6hfNnO6p8dUCJGx7sGGN0hcO0jN
 kDmX7NvGTEpGAbSQuN2YxtjYppKQYF/macmcwm6q17QzXyoQahhevntklUsXH9VWX3Q7mIli
 jMivx6gEa5s9PsXSYkh9e6LhRIAUpnlqGtedpozaAdfzUWPz2qkMSdaRwvsQ27z5oFZ0dCOV
 Od39G1/bWlY+104Dt7zECn3NBewzJvhHAqmAoIRKbYqRGkwTTAVNzAgx+u72PoO5/SaOrTqd
 PIsW5+d/qlrQ49LwwxG8YYdynNZfqlgc90jls+n+l3tf35OQiehVYvXFqbY7RffUk39JtjwC
 MfKqZgBTjNAHYgb+dSa7oWI8q6l26hdjtqZG+OmOZEQIZp+qLNnb0j781S59NhEVBYwZAujL
 hLJgYGgcQ/06orkrVJl7DICPoCU/bLUO8dbfzsFNBGQ1Nr0BEADTlcWyLC5GoRfQoYsgyPgO
 Z4ANz31xoQf4IU4i24b9oC7BBFDE+WzfsK5hNUqLADeSJo5cdTCXw5Vw3eSSBSoDP0Q9OUdi
 PNEbbblZ/tSaLadCm4pyh1e+/lHI4j2TjKmIO4vw0K59Kmyv44mW38KJkLmGuZDg5fHQrA9G
 4oZLnBUBhBQkPQvcbwImzWWuyGA+jDEoE2ncmpWnMHoc4Lzpn1zxGNQlDVRUNnRCwkeclm55
 Dz4juffDWqWcC2NrY5KkjZ1+UtPjWMzRKlmItYlHF1vMqdWAskA6QOJNE//8TGsBGAPrwD7G
 cv4RIesk3Vl2IClyZWgJ67pOKbLhu/jz5x6wshFhB0yleOp94I/MY8OmbgdyVpnO7F5vqzb1
 LRmfSPHu0D8zwDQyg3WhUHVaKQ54TOmZ0Sjl0cTJRZMyOmwRZUEawel6ITgO+QQS147IE7uh
 Wa6IdWKNQ+LGLocAlTAi5VpMv+ne15JUsMQrHTd03OySOqtEstZz2FQV5jSS1JHivAmfH0xG
 fwxY6aWLK2PIFgyQkdwWJHIaacj0Vg6Kc1/IWIrM0m3yKQLJEaL5WsCv7BRfEtd5SEkl9wDI
 pExHHdTplCI9qoCmiQPYaZM5uPuirA5taUCJEmW9moVszl6nCdBesG2rgH5mvgPCMAwsPOz9
 7n+uBiMk0ZSyTQARAQABwsF8BBgBCAAmFiEE5NMTj+LZ8vqBUv2R7qcmziEjWlgFAmQ1Nr0C
 GwwFCQPCZwAACgkQ7qcmziEjWlgY/w//Y4TYQCWQ5eWuIbGCekeXFy8dSuP+lhhvDRpOCqKt
 Wd9ywr4j6rhxdS7FIcaSLZa6IKrpypcURLXRG++bfqm9K+0HDnDHEVpaVOn7SfLaPUZLD288
 y8rOce3+iW3x50qtC7KCS+7mFaWN+2hrAFkLSkHWIywiNfkys0QQ+4pZxKovIORun+HtsZFr
 pBfZzHtXx1K9KsPq9qVjRbKdCQliRvAukIeTXxajOKHloi8yJosVMBWoIloXALjwCJPR1pBK
 E9lDhI5F5y0YEd1E8Hamjsj35yS44zCd/NMnYUMUm+3IGvX1GT23si0H9wI/e4p3iNU7n0MM
 r9aISP5j5U+qUz+HRrLLJR7pGut/kprDe2r3b00/nttlWyuRSm+8+4+pErj8l7moAMNtKbIX
 RQTOT31dfRQRDQM2E35nXMh0Muw2uUJrldrBBPwjK2YQKklpTPTomxPAnYRY8LVVCwwPy8Xx
 MCTaUC2HWAAsiG90beT7JkkKKgMLS9DxmX9BN5Cm18Azckexy+vMg79LCcfw/gocQ4+lQn4/
 3BjqSuHfj+dXG+qcQ9pgB5+4/812hHog78dKT2r8l3ax3mHZCDTAC9Ks3LQU9/pMBm6K6nnL
 a4ASpGZSg2zLGIT0gnzi5h8EcIu9J1BFq6zRPZIjxBlhswF6J0BXjlDVe/3JzmeTTts=
Subject: Selecting serial device for console
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DaLuPVoP1ervOlnHDfVaQKT25I9AhF1yvg7TVr/DcEbW9JNcDNR
 lul+Q7WjCLiiYL6fwsDpLnXIva7OWrUb9jGGUqY1NpShkI78TPnsgWulSrAkhuA9g2dVRTN
 a3Vrb4CMPWet4ys/mCDORkttJ6jw1iBjq3AceTYF/PvAKsyuMtEmD5/R4yWlZGsvhtpY42S
 Q+OwJcKu59CN76UBBIDhw==
UI-OutboundReport: notjunk:1;M01:P0:2A4tQqKRNUY=;v8zotpOHDHEs44yG5UrFJwGoEXJ
 vXlrJREYUQDYRkWnDhSGodlNBkGFrCA/m41nUxAiT74hEdAb2aYgrU6a5ndCerR1OYPaxSN4u
 8JyX4P50hPTHr4GOX/aHtn8LzOj3bDwQWasgoHBi+DDCfBNDQe2t5nX156ON8adUzqeUmBPPO
 kXFF81Rq/Z5P+FRQWY+ugs7pFRqQJoCPZyKcZeGAEetLI+YKezyMZVzAUtGrWtSl8XHWPVYCX
 YsDFv+5b7runLVrh9L42hnaqVDESeQmY855cwP25/gcRqpLR/TdXuBpMOD4vQkAjYgxtdU+nn
 nFinQs92sPX0fbKozHj4rBZ8A3sW1aK1CUd0pR7jGHKk6Bfu6x7+PyJgQXueFfajMFT9QvO4E
 xMDGipP8gjvU4dpOK/cr9H7HVoimK92w44Mxh293558unhBj7wK0THeWttvi613rLgA/P/3Ix
 nrT08cbFKEVGLZ3qdJ4ssBQAuutdG7m76uqzbiW7HaRBbxSlAI9gkDptW3vfHoiShCP/5xmaJ
 IA49Jt0nWUHVmBIYavYTqmt9G2zJSbnuRe2xEwJ648gEXK24n/xBRe0bChLQ2zfWrrEePx/jd
 gmxGiqDELILrG5uYDgo3hxTsMQnyPENJBAUbIM0K6VDcKRVG34XqH+y43dQMFEd88EABueE9s
 PC5X3++ONwYvHKd+nrbxrxfu+lk85Agkqy9Hlm5rccacsArDwQ3jSTDpWCSft9yB6wASGvlje
 T+eqtmz1N/P7OVm2CbUeiavIm88eYi3a93Nomu79gagQJYTSmlzk6zoIX3/L1vDXtANmDC8nx
 VJSFMmAmNna2+7u4B/rXBjFw==
X-Mailman-Approved-At: Thu, 01 Aug 2024 16:06:21 +0200
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

Hi everyone,

how can I configure which of the available serial devices U-Boot will
use for its serial console?

Background: I have a device based on a Raspberry Pi CM4, which has 6
UARTs (UART1 is a mini UART, the others PL011) [1]. In the default
configuration (including the mainline Linux broadcom/bcm2711-rpi-cm4-io
device tree) the Bluetooth module is attached to UART0. Unless I either
completely disable UART0 (status =3D "disabled" in the device tree) or
reconfigure it to be a serial console (e.g. using the RPi disable-bt
DTBO) U-Boot fails to boot, I assume (it doesn't get far enough to show
messages over netconsole) because it tries and fails to set up a serial
console where there's a BT chip listening.

That happens even if another serial console is available: With the RPi
bcm2711-rpi-cm4 DTB plus "disable-bt" (disable the Bluetooth module,
reconfigure UART0 as a serial console) and "uart1" (set up a serial
console on UART1) DTBOs I can see that U-Boot discovers the serial
device on UART1 (serial@7e215040):

U-Boot> dm uclass serial
uclass 108: serial
0   * serial@7e201000 @ 3af3b200, seq 0
1     serial@7e215040 @ 3af3b2d0, seq 1

However, I can't find a way to make it *use* it instead of UART0
(serial@7e201000). I tried to set CONFIG_CONS_INDEX=3D1 but didn't see any
change (unfortunately the help does not describe exactly how the number
is mapped to DT UART definitions). If I completely disable UART0 in the
DT as mentioned above U-Boot uses UART1 just fine, so it's not an issue
with UART1 as such.

To make matters slightly more complicated, the specific device I have is
a RevPi Connect 4, where a vendor overlay [2] describes how to set up an
RS485 serial console using UART5. The pins defined there are wired to
the outside of the box [3], so eventually I'll actually want to use
UART5 for the serial console. Which means I really need a (build-time or
preferably DT-based) way to configure which serial device to use.

My goal is to create a single DTS which both U-Boot and Linux can use,
and get it upstreamed if possible. If there are configuration options
and they're just missing from the documentation, I'd be happy to send a
patch to add them once I have a solution.

Best regards,
Fiona

[1]
https://www.raspberrypi.com/documentation/computers/configuration.html#con=
figure-uarts
[2]
https://gitlab.com/revolutionpi/linux/-/blob/4ae9a35871799004300f83694a243=
59a7b4ef8fa/arch/arm/boot/dts/overlays/revpi-connect4-overlay.dts#L281-292
[3]
https://revolutionpi.com/en/tutorials/uebersicht-revpi-connect/serielle-ge=
raete-anschliessen-connect
