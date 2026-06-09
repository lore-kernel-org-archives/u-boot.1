Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA0BCD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 05:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8316E838BB;
	Tue,  9 Jun 2026 07:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hycoTLTg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 040EF839A8; Tue,  9 Jun 2026 07:52:24 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 975AA807C4
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 07:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780984340; x=1781589140; i=xypron.glpk@gmx.de;
 bh=qg+l29Wr9SsnVvWexW2tHAiSwyb2iRUUIXYJPgtonOo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=hycoTLTgmZ744PflvgQy4ZNZu4Oa4ub4FCThuNmtygeJLbj1nB1d6o6XdonS/q5H
 wvOaYzQ9205/K2Ljtp5fmrR7AZXLCEKk1HlDk0W9cRh7OvefECJZ26AhJxOFvsFmw
 20gc9tzyMojGWWDegYvnMvJp7nuYVF2nUUI/kNjN5dGB/tXrdYqATkeWtQB0TBDMo
 Z10Q/wd6B5f0FK+9t9bNbavjwxpEJBzpMd0vnNlrPRGwNWIZ/oqbSL4sX2kALHTAN
 iTSyWn4k7GNpnO1lL6pyio0tODSgZ5IWDINpC/Yv6Vo35yKAohOEU5T+HdwF/ykDT
 BPM3IoRExaXW4sbjRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5G9n-1xDLxh19mf-0179C5; Tue, 09
 Jun 2026 07:52:20 +0200
Message-ID: <d29a93b8-c30e-45c7-a3c3-3875f0081a7c@gmx.de>
Date: Tue, 9 Jun 2026 07:52:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Francesco Valla <francesco@valla.it>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-07-rc5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WW9tzkr0ilasGcXeCYh/CtDM0xFRBGfwwI/LP8MMy10JHNxtwq3
 Kb3KTp4W6oe1F+9TthxMiQfzQTDoHE1g8/9eogCShgI71qfhS7F7LFwoTf/hv2kcYb0veKg
 Ea5fIYOt7Qtmd5Xp9XGFezjcP7JS4KGIAWrZlIbMVPovNvdslumb/9B5MEAkg4OLItfTBu5
 FMjHttGU3l2b3U2JytJdg==
UI-OutboundReport: notjunk:1;M01:P0:M6J2SPAEkrs=;nlopInHiLrfdhjW2/uYbMRRy+jq
 5SYCGb8TU/otcQ0SZ0nrCJjGMtm4MYvPesdBint/LmYB/Gjw9MIg+OPWR8tCsYm8ryeYJn3Yt
 djxXEVnDl1udfzqRdX8PwzHMqAYGgENHiRcI+1g/egIW3s3RsF1aIbImvisBrw0j1P2feNh4S
 zJAqZ+B432k9pZNvvDCWCUaiQs2DGxQCllHZdtMpblGwZcvuvUETQpUTxm+FxSSFyJIWeBZtB
 gL4Z+JaWkS7mqitkXenz7OxZC2Ms4RgcQ3ZHxUn83y7lkCuKeXH6sVZf/ik3lZeuZ+gEKW2R/
 XC0rK7tU5pvihR7CGhDE7v+5wYWEpDyROFVLgbc/2myonpJOS2saU6YkkdoE8/V9Z6V+t2QmQ
 FFTYqWn3+B2VhXWl1XD9S35c/obLf2bk8pQBQdb9meW+3MUlwAQCLdImdmGMOLok7aV0/TYDV
 CVqsQRYgbk5MhHV6iNOMNDWneGFilPoipGNaFC4iM+Xbvj2w+OtlYv6m22Jqx2qSAuXKfQNEB
 67qIYYt5HSKhbp9OJb0gbhR2LT3ibU4aR4m9tsoUgJx8BsrHVGebTszrB19NCPzhxf2bJeJV5
 4B0oo+ywb94vi7b/02v6jJj4fPDnNDp5aib5vZtd58yZfY6w2RhM9edyPVHxxUkT0gDkBmZiz
 YbBhSC2lp7z7f71FDiFb7axFs4N/HhxNPKCjWBfDOyFI2zI3W6Ew7qlECf6V87EU8O6MhbRtL
 oGE05bYm7GofnrRE/4UrM4aJG9CgrUxbruDMYJyHHJT5odA6E8uZTF0TnCZvLnNk5zZ3GoGkS
 HjyC/Ds84+woeDVQYyA1P7sv1AIfE7pPFASDAinvaEWgvWnTHb+5AQkkQJGxU+aQEzxjONr7f
 fzD3sq4WXggTp4IzqqwmBOrmej9Zz1nWfxK6kafTUhEfoKpSOvG06edJGAlBoeWYZ6ZgUZL9H
 opE0PqrWoBodUVYR+y0g/C3OUwXWDRUfuocLDBUO9sF1EgOfY3Hp0SZ8FaZW+lMk2txVrkrVY
 LHA0jHHHwFjAO+S/yY91iuNOBCJJNWxyE3XNt2iT+mulrc9iBNtM1cb3uIr73n747TR28Rj4f
 Iw92pRj5bgVZYYaquqxckeBiD1B/X1DShNkZHo4/2bPukSASZza//V3/rKjOkwsqCYQqn6KD0
 LnFFBgQoAuWHPIg35dXLF2AY0mod3QJBKsBszr9vjDC4tAdbYdPyqeDR+Xb+7a826aMMCv/OG
 AIlPSvz/lM3bln5/UoliIO+XdKvvz0c2lYbkghQUYQ7FUzZ6m8pYRqnOpRtZ5gkRUKdsDFJSG
 gUpUtLX96gUiroqdUTX5TQdorXS5ZvOe8YrFsMyyoJmhTaUScy/9+jBY1q5eK7Kx7+7p83cK2
 ZLU0oOJJxDc9DjlTBZwkt97eHQceCox8qjvytmneweUvg0D+d7hvW/0i8WkDZ63CTQTTXHSSz
 cSINncHOVC1oWI/89FpMDOgcrToaGSR3CnAjUhJGWO+/ga9kb58A4zXMYetxRDFna4GOYaMoJ
 lFj3La1fPFjAzpY2bHYXBvejq6EV9pgvwD04dsxj3RD3XqHgvUaDGFDTha7G0VxhqFbgSEZ5i
 SjKi67BuT9hjgGsKqo8pZKdZHsAH7JkNUj+Jaf+06r4cWaytp9zQKJc4qOxIB+Z9aLI8QnUfn
 jeNzZLBZTU62vPiioo3tpWQvZoJ1i8dmX+934foqUWX1c/qFA70qEjwQIMBe25plUZH8rLnCq
 VPeR4ijfnCZhEssaOmdb0QXoixwFg5u+mppUdOm+nk7VOJ2AITByFFt9URns/UaP6YObzko9m
 Fdl3PcSq0Ng4MaLI6ZOfKMxBLprRdsaI1AOKLpcHzInQpHjx2OOpDQqeUJ2gml/ueAnnvnrsB
 LSuiBb4uAoZJ4wSZpyChBti8gGatW2w/mL6NGs+ilFe+fDD00GT5TzSzvQu0JEGtwkkU3s/jF
 1EvE0S0wtuTkCftdRk+yf69a6JhZ6PaMwQjMUw1cXGgDojNQRTRrl/8Z3sT98iNeL2pl/n97C
 RxrsIQo0aNd8sS5/eCXcyMB5dzpO6khiFT3bkrtmiRWwK17oE6nLtbKAFMYPYMxPc8shAs3/0
 S2d9kYksNcevAF2DvdockcSRitQ2gsDnoLx7XFaZX/1p+md/inGhEr52KXrBh6SzufRO7Hd9p
 qXU0vptf26Llhz5FIAUi1hDM3m9RVL0m/T8vDOwyz5SYeMMCtds2JKowhD4mMDQgQnTFztO25
 yfx78icVfRCzmEq++W+GUT09u3YK/Jd36aLVfOKF/Dm/+DbFTzJAqRkTeOEgcZDN8qOoz7mvZ
 sZqIgrMEBL9Euqff/BqQ94UeJO2+uIu7xihD6mrRWVlzxWX+vSDbr668fEPBEc2W2+GTP07Td
 RgMJP9LkS+WXG6Qswi5mGw1Hp+ctOsITQflwB8oFv/DssGfekzSBEGVHTOaUDW3/89uXGvdkZ
 IlxfGcCp1MS5bsPEhHjFHAlWG8yGhw56sgcN9cq8JJZKsRrQdqCxO4UzP9lhO3z4ZsdDlO5Rw
 tAZMNmG9Z7Eba+bc7MguNRFIqmDbaVEUXU66y8rf2WHsdPNif5rWrCEN2jBc8G9w1JUNp1rwH
 7UVBXRA3deG3aYTLcrDB+YMiMCJdBO0LUBQSY4Bc54qVB3LZsHV02xTfmjzyXFAII3HgLLQdA
 mgyQqs9AzmNHA4s2S/o58IR/SaAlgfHOHfLhG8rx0P6VfXhE7om+fXGEE0/R4pWbujO3ABtFv
 Z2YB6+CJDW90JM+UX4947DzObwQ4Vn5oOecErUbVUlS5t0V0uPZ6TSbKn+zCwc2Iw1H8XqFik
 wnN5k3kEmOdaZmVmUZnrbXbReqt/UOYhe5sNGTZpcuihHATIy1joWK4zTUot8jIhuRbHC5crP
 39YgufAGNRNlFuTG/6KDudhD0Gwy+XntfBT42evnE/aDGvwetbCURn+zuQnlYyUkxIfphEBUZ
 EgUNrCr8i3x7PnVgJsH/A2DdFGRNyeM0LUpwEs3oAMhYmAU33Sj6XXvibs7qkbGfvP8BU7O6C
 92OkvIGGS0k5hHHWtdcy7Qh9w50g7zmBSJjmCSGYcgCE7+qLZpjRPtVulqSuaVIBShyVwZdYL
 17n+vfXJ5exiZgqxDGrg7/Ehw2fuc36BwLx6Q7YyhpOl4pq4e2JLSN+HEJDhg/qjY1kzPkq/6
 T6cPKAv4jfzawhpAkcTDfyZIjO10EaeUu8ba/BiZallrikf6TuEFofn5Cogq91rOcJAk2H+5E
 93QPlY/8FKSJNsrI2REYp5W4swundDrj/mYj9hjUcy7ogE4y1RSFFY1h2Tf8kbeLnA3cjJ8GM
 jyDj+Yc/QnmHXlUvL4lNA9SDBVbbzNQR3igu5TXP4RGmZwKgb1i3cSCV40Y2RPoMpwDjTDIVx
 IHrPWjrWy9SXGSlxqx8HspM+XZ5WhsP6VbVCl2/RKW0xobHe5GWdBdFKPIh+6pHioDVPt4Jbv
 WTC9JHjnlgJ604pWGJdhqr9Yrv3N9CGeoDMPDbiYNuSNKwPX49OAsZvC+k8GOtE/AFy8/YvAU
 //nPFTD2x2y2DQczFKUDau54O4lPelqdsT+G6VICydO5HWnjOUaJLhAbDPC/XKt9pVhLwKuLY
 DnSkY/2ve/HgE8at5YWdN9V4V3ofgPaSCzFkB/nc2XDgKq3rVdKNfj5p0XBrMREM10qXErrt3
 JjXUj/as4d3HzRIzZfsxMQWG1Es4rMs6v7PTbw/1iTC62wl50J7po1JVI89LzM1TmNp8AJUiH
 l1/tLnOwgiD7FISNWFs3DSjnXCVs+fiOCRXTLvMTtJ0FTj2kaH6kQ+ubtkm8Y8ARhqjcW9as1
 ndgfhQd7BjYdwhwCwyuZGQK5xEKmWF2jX+bVn8n3Jydi8JWDUh1j4wEMvTDnoKD+KE4x4vLp/
 KfU+dWj2MacPBNaJx3B7nhB7zzuLiIMY+hafsm9/sF9uOiXU69YtlO/EGf+ro//AILbXbzEr/
 QzokdldGQGwhtBSIXu+hxh9Li4F/TGvK4TXjGC9Ema9RgqaV9ZdPiAlWajbvAiokOapHPj7n9
 M5zJsnDl9tE4xOK1I/1IZTfldXwlITUnlesOwWldJheNim5lA/FHUAJqNNG3jNcT/MWDYVJB2
 cJKQP9tIm0zwpZ/ZRMveTdUNs5mPmF36K2ihyVH/RWDJNCBZzHwaRVNXSPs2pvLLU/5JDNGtd
 ajUcKosmNk6cLc4M2aGXFQAzZMp/CQgn8KB83C6hEF0B7p8R0+BVJOpQbORahFlbYh+swtSTM
 hJwLw1Vrnho7TLS/W8m5/ek0+U83mHfX5/d1CgRGW22gvVurBmnsiOXC3LTyjLWSRcv0kTGyv
 CntLvhX+VoWUSIcpoAvAwtfJabTx2vJTfa0CC5WW0q3Dpl6JrRFJqHdcy7j/08gptjTXVEWfK
 pfitsahqZkL+JOZ37mUZ19myg+G/sEmF9OhzzcTvVvLGeG4rCCVV+Yu27PhuWqDMYPMKhvs/b
 jIK/6HzckOkaMJL9fCnKl5cj4b4PqyHd7MDrLjheYOxwdGMigDiwAGn28+Erqp6F5QFlFOzgh
 TPDIBoyLXCHFJpwuvuC0Lc+YXIkAm1OkvB6wuomsyXl3geik9L3Yds9kOPddiiy8sg2YRjn7B
 znySU2Q1THjG1UEmHz+HcJEUKLHTmdvR9Mc4Ic/DOCxxRcBDI4lxa3AL9HsLJrPh+hdcKpE2z
 Vc3aaIsc2avOKhYQR/g/6fJPoKU7t+6B0RBLTN+OlajUfYFwcMnOkdDRfMF0LCDvuxLfB0UdV
 ZjBoLCjXxoR59gck6S3ekwZGl0S3AeVO+T03S3X3phVYBL2kKyg1W+RVKIJcDd7snCNrLua6n
 cPNl1v91MBdkZlNgob8Uc0PBknZFEaqET423ZdUHbO2KQfJyUJbKJSalPQqYb5Q12ymzeZ3kY
 6/XmrSuceXyjNo8fvmt0BvGbZ51sMOP60YCA1edje1VoIplHQyNzyYsKRxAd67r9ZupdDGSFw
 gHMFafXL9gryJ6CGPNGAigOmwed+Ck6VSsKfizolOUz4qfsKlWDrHA3kwLUqTVFHBJNiBuANd
 R5EY+sg8K/QP0FOXGPIUx56om3PYDa+kZGB+qInFpgHJIYD8e8AyAUxP/acqdl17KToq2Ji3o
 LDBoNXvRbY4zD19pwkLqS1T+3Gob+YFgkq32bYALjF3cDKFX+8x5WtmptJqcFzNE1fMVZxZf7
 hZa9tNijBPhl1pslG2RBt2Z2TsRLUvrRqsHlM8Oxe3ESHXLTHhpcvGGJks88eogLzVgzvkQVv
 3F9LgUdKA1g3A+3ln7+bHvbK77t2DNFlX2r9tAcuNSWn59kw/GUr9QFukNxtk4Pim2m0+kDsw
 7t3zoKePV6+fWFeTkbOq13fVS3RqK5+Wpi3YZn3E/e7/Z1jFEfqyJ5w7Be42E7pZBHAaiVpB3
 OMjntnvWrqAApORPZFmK5f/joIzB9LFjzlLBOA49dsxbc+JybNQY8Wcr9d4sdvXoik
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

Dear Tom,

The following changes since commit 75daa277941702bf58c88d65c0cb6ed962899d9=
e:

   Merge tag 'u-boot-imx-master-20260604' of=20
https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2026-06-04 18:56:57=
=20
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-07-rc5

for you to fetch changes up to 5a1818d54c8abfe8f4f72a3fa370b299b2bfe125:

   usb: typos 'requird', 'current' (2026-06-07 16:44:04 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/30365

=2D---------------------------------------------------------------
Pull request efi-2026-07-rc5

Documentation:

* Update urllib3 version for building
* usb: typos 'requird', 'current'

UEFI

* Improve PE-COFF relocation data validation

Devicetree-to-C generator:

* dtoc: test: add missing escape in help text

=2D---------------------------------------------------------------
Francesco Valla (1):
       dtoc: test: add missing escape in help text

Heinrich Schuchardt (2):
       efi_loader: validate PE-COFF relocation data
       usb: typos 'requird', 'current'

Tom Rini (1):
       doc: Update urllib3 version for building

  doc/sphinx/requirements.txt       |  2 +-
  drivers/usb/host/usb-uclass.c     |  2 +-
  lib/efi_loader/efi_image_loader.c | 86=20
++++++++++++++++++++++++++++++++++-----
  tools/dtoc/test_fdt.py            |  2 +-
  4 files changed, 78 insertions(+), 14 deletions(-)

