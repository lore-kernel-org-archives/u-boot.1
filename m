Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1959CD2ECE9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 14:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 857D483A8F;
	Tue, 20 Jan 2026 15:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JJi5pV0r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 554DB83A8F; Tue, 20 Jan 2026 15:01:52 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC7AE839E2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1768917699; x=1769522499; i=xypron.glpk@gmx.de;
 bh=enqW1bPC3QaiIrm90hgPIfdcmRL/rGwKCnOVzVfQf6w=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=JJi5pV0rztr4G+owMaHJOVbu4MNDgRCMSz/8Weo5WjJPTVuZoNC9WhJWKiKAZj9g
 klqfkkIKURCf28QN6kfoXAU0uojtp4XvJltYyBQo77GFHAYRaK2KfrYwA2KHwFMUL
 iUxvCcvpJ++8FrKt30ftA5HF0jo7WSRe686a2DX2GgD+QcxJvK5NPC6cRH0J8q9Oc
 VJDKZrkM1foWa8L1l415GgNQVEwJqCNQXrywSGvwA/nT+7N/SeMlkJ19sciP7xw6f
 J+jkJwXhtMPQRD64YcTC5Xp1cU+vqf1kvsfTzPlqi0g+NZmPT5pVu/VL1uuRLN+Wa
 wm2Y2vz3RBGJLXKuGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.127] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUm7-1vVIoH45wl-00DdZT; Tue, 20
 Jan 2026 15:01:39 +0100
Message-ID: <177fa1c7-edaa-4693-8f3b-c3ceabc3d563@gmx.de>
Date: Tue, 20 Jan 2026 15:01:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, E Shattow <e@freeshell.de>,
 =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
 Manjae Cho <manjae.cho@samsung.com>, Paresh Bhagat <p-bhagat@ti.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-04-rc1-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y1zpvKzXDWtI48TTflY4ylA2M1HSFA3NuTZ1NLD1RvU5rJ38iOF
 Hdarrx57sNXhUQ+xuw0mzsQ/ogbPfoFup/Kva4FOa0Up4DtFHD0oq5fPBxsRH2eN0Grg7mt
 rpAKr+kjAmwou9NaDaYMq3h7afXN91xHBrW2c4F5T/zl3wzNF+60HVG4SB3W3JL3gQZTXS/
 SvmzDdfMfCQCAp+Xj2jWg==
UI-OutboundReport: notjunk:1;M01:P0:fRFCPN02IJc=;T4o3sLRa3btLs0p7/5dkTemqdRf
 hOQbnFHBx2ZzKOMGdW7eB95hhiFWz3uNcvzk2UPNgWK/80Nvum6On1XKOF5dC2I0AKAXhHPnp
 Ef06P/58Tgb1kPCVO9wZ4ZQDuc5gnG8BaQhK38dx0WOlRDVUh+B2qqRJAZw2faF8VJ5FLfwQO
 8HK6hYxUFDXCsHGT3YL0B+5O8b4yc9ADofaknKpNwFgtUpeZ5Rtllq3SPdrAGsx6OI/pkBU9Y
 Wo2mp77j/2WaKZTxlt2ln0/bgwohzmWxiZ4Fn/LedhRW6849ayNZWMRgHOgXM8BEIJ4mMri2/
 45jFwvoOdp6cSlyviIogrBl06/+UL6fFB23UCsUqEEiTrJX17IOVySqpAfJE2W8zqcHbu6S37
 2mvmIXDGWhJo3CZnbU4gthY6X1KSw6k6S9ociwVcqpROgP9nyX94Ha2jeOByg0Xe49bgbmqbJ
 Oc6h5dHYg6p6jEp7KtJLgcKNl0PjW5NyLP2QaMCtDmhmfT4TgZmd+q8zk1rpXx9d4IsWHBHsQ
 9LK/298F3HhrJvIXX5I2kiiqRGw19WTtfKTatnpuMhoG4yO64zQ0Eg/qTXYQmeFub43U3CMyy
 p+Drypt9J60f+1Pq8ff6k1Gjiy0k1LYFvaccZiO5dy7ISJ/C2L7PQeGs8qrO5+McQ3TFdH2tD
 viv1dIJTDABcYAvzXHHS4s6fkozrqhoair8SQqeYaGl/rCQZ4i9q8gRAh2/wNi9jMh+XpElkG
 TuUTextwzjbuICb6rTPddggI+vljmDrxrS5RytarEkYV2dsCPDo+kxTj9Dct0b9S16HiQ1+sI
 4N45yga6AtZ5vnPAmwdT7FnQHjPaaxL+2Xs/oJ8DghT2lkwlmVgrdmzFd204y+fYXslG5OBGc
 MYdvYWchuk3YeBB75n4VteSrl9P3OZLE3YI5MLVvS3NVI5hggdtP8rhGy1fqEa5lGktPQxzAH
 Cu6NDCle/k1nECJgtnkcuTFU/m1gbG2GQ0V6iZmn9SVOqLWGYs27/Wcj9B7jxOCWu5R8TFn64
 LP2NECwc3Ti14gvgJDgfEFlbOd2ekIYznYmesD1Z3A0FpjfNLuNCWK4wD2iMuEzlkc9uV1+Wr
 VRyHsHkfcppJuo3HAw/9SmmA+e4uqUbMZaLOp9JHTNIznvg+Mx5Na4e16mhJxz2tAA0oBKhku
 0AlvYMYmsGXnxLXquK+54nyQqDODvdlgD9JejqR7tCL+ie9y4UQQ70qR1XRg5b7pj9vl6vbrD
 56Pgf7gNxkjBHBp7bxWoxl444vJRdlo8NIB94K/0+zh9qtTi9ztA769vBTyHGQ3r6/IqhSkR6
 O89dE5gmsR49mwx/W1n+09qybdYESV0IZm5C17GLuj8osZzRZWkX0kAyF3N6xCGLdRmpb1yL2
 lHZ6mUE/UwzFYyFaUSV5/L3rhoH/qrWaQfM5fgcuW3J8wEy4zX6z2Z9rUkN8vNTt07apjMXY/
 Wy6h42YEuNecT/3ZRsOTlVf5cwwjSaDNISYuYiNzskhc49GmLUeDQ9vOAgUENVrxrmT56qHin
 njxNWt5WH/M94abA6w8kOtnGHjwggVg6oTLBDBCA3UACKM2DjPs9sciM/cnK/NoNtOZ+vhwqv
 VATitNQb7n+nI/v4WMS2m3gW+yDZ6QOLpYYKdmaY6o7nSS9AaU5vpJTljxi8xOjiEGyKrHyAr
 mRptAPwJtaKy+gbgZQ/nJdtvct6a0hu2EmDTKnH9BKuXbYgiYQdQpKl8mv6iEfY/dv3PpyPGv
 kmglRRJQ2HSbl45snt5TtCdBliK8Kb7UiVJCEIn5BPrUHUifHni62pj3iSULC0y3lOnjPkJv8
 aC1XReu7Xak0rCSC8TrRj0dIP4ykjFysx/yikuI6dYTL9JFnt4GXsQplSUC1usGkAsI7+l5op
 JHvhVhbCfnVAnnHnvMTWRiiDZPJ+yeLo35NPf6uGLVNAC1bxUKvFqj086o4u1N8JTD9iGxHtH
 2VDCkl0lUa/1qbeSzWxEWHYWRamq0hu1GEVkD5bDnHlB05FzNrqzw40NSYxNc9yLGK3Fc53in
 +cJjVh1/5AMpPpntsfcvzootBY1d6xfAQ2pCHPjxHTSGy3urSJIsUMnNJ17p1MtfZefmk7e/h
 PTnBr/COXEWG6Xlsd9cJoMPz54vEnlUBqANO+CHE9S5OEPsRGmSck2jjqSRMTHrmbPv69+f1f
 IC75kmZaR6GFgcqg0+8HoxdWcLT6M/6ZHtE4Rx97LYxtJH/hog+hcdCYF5hmUGzNB49x7aP8c
 hsc9tsPXD26/GRf2YHLp8L6pgxOyfa8A47dFW8Fl5vBwS+aNkNcf/ANN+rL71CDTh4ZXldC+H
 /+IK/aXPauJRishm/PSJbUYyDHqIpV3vbHIncxmT2M3rJln8wXtyFznMDDIuoAqccVH4B/EKZ
 hRJT85olrwEdg0D3Nnuo6sZtQ3+aDKY5nv2v50VU5Mwu+U8tBVITGqtX70D2/K+4Ab996nsMf
 SLzt7i7X183DjzDH+U/RXISt0a6a+Yx2nX5l/SOKDkd7r3oWMiMqDW16JpT2Uecyl6CtIFQd3
 NpKInQ8l0JndIktTWtCjm47+Re/je/X97+lf+knwA9H/ZvODG1UZi46DQrCB8yNoDlcpxFuXr
 QTWUiYz8uFFGqHe6M++r1PlxsBJX5zZ5uOhFr0ehMQxzsES0jPZx5UsJCHUCMxM5wuvqkyGCa
 jMYIeiEFOaOhkIO44s1+SdCv4aPh700maaa4r7PJnOBfiFlCNra/oUbTvoVW9AifRdYYUYoDD
 Nh6OvMO7Qt2GP28TOy5zpFN7I8QX12rGSXMJk9dQduHZNjW4zVvzMueUP0ekLWjl9eTyyQ9oU
 1khmLRxkGbjmTbbljI2WMq4K5AI3nIwecCM5y+Aw9pec2H8VHso2H23GiKcS2vniuzRdmTUhJ
 /qw76wDNC0KW6h0fAuHpbs9Glw0v4PKTx57/N5jdBbOrEcui5l63dI+xV/PnOBBCHxuOmauDj
 /bJ12+XkJPyIbKCuPCSdZOvyZTbVMsIiOXNCKXrcbYvkCbMR07XCuxzayWblf9129dEBwoMui
 hW0Jawjq20f12yaDp+YeOuQM4bKHyuzVREQrjR5ddCoH59Khv5BjpMLyYIHlx4gLZQ0lIDIT2
 jfboDNBZg2k4X40tpic9LGeVnu7SKvrnY+r2yDCUUTHej5HrXWzUcxtJoEMJcbYyBOBlOYaqO
 QCslp4UmW/Nr4pTD7Mb0p8pokjcePzuEYHDcIZ3TcUSxrznQzxlElrP0AszzSAOYfDiptRdKo
 ZZXnftIjNNeHXTmrh1V7cH3hTyl1849kt02oQvsWBevQ0xVAfsjA2gnJc1sosRb1gH/v281nS
 Lo/D+v4VcXI9BKblKGEBJj+ZhE0yipCganXd3l2hiZ5A/sGElfgfKcbnXVHKBhas23Gh+yIAk
 iyhg5qUzg8kwe0gcPvT5kBC8ULRF0iZCQuf5xyD0htUSfg/LkfVR6Y8j2XbFP8aDPV4NL8mal
 iEK0gQc0zIkJayCXS2mEvhR4p3Zy4MooRT5Bnuc0y9GKAOrRXnZ/oAM9nC+H3/pg+e0Nbg8/x
 RIG6u/8DL04dyZaFqzVmSltlbKfNpi5ov7lMaN54Lf7S4KqV2B6NIFtTTAyk3c0/xY00/5sTZ
 9xY/xyMIdYwlIxT1GmvtzckzOzQ0FVq//hMI8y3BgOTB+h2t15lMcgJCOI1WYb3BzHUVOluYP
 yGG58ayeIQBWHX4qF5w9iNsjunovIfVhG5tL8m9vtMF5WohBCuEbnBi1cV++YQ1/2D4/KaYRK
 zWQ13wMx0tRkezujrbEDQi3oCDiOZB4M5avE7yjYVDFZicMMkUm1pPRGjAAYumcgTMbgPqvUW
 CML87oSgXezVLKVH4nC3szoRYD19akKMyDrF0vSkfjF/Dt+pLI8ze8qy8hhn/nXA2ivi+bdFA
 nK9dFcShVnkYzg+g2Ht2IfkN6YIlM4Iw7qfyfVCbXhHaJes1RWYA/uSWD+eplSj59w9vA3Q8S
 IP5UOoTc6YCFAw2hYZh7xdbcSzLj0KvpUaMBPomM5TTQorYG9XBYHncFhQAHT5LbJ+23FasIi
 Kcqvk0yW8/ia2rmzaSnIiC+ge3Y83UwTis+V59YZWOC5cB8cX0H9vT+ir7O7RmSR4zS/Vnsei
 ZKN90WXSPDhEMz1vb0bLotZ8n4eUDlFQbal9PGMngmBW+2vGZ0VfKRrNdlgYLyPZyl17+UFDn
 ZPhh6LN1ZJSPyfXN8PS0vwUf61NDMBwFntPDHPQxndeIO41ej/2+c6rgegfBbEHxPAfxn0urL
 apT4NjOKqLAsAPaQ+oHNAyMYimCR7ldgA+UIcQ61peDshDcAKXWOTvHVq8Cf4Tf5K3sR9kEwa
 2JnoGcS8CLQrrLoNcvEuZQN1MevUBbFg2/slqMz1TSS5oRlNG46LS1kCLI5Z4wAdgVsetnx7h
 f+f0bMq7EHhk/CZ+RqHP8ReBa3PO9xwkPGo4yAfPaJIcBFbwf62Qqirpcx/8mRYMhms+RGM4u
 CKqGjSyVN8tjR3wWeI51XPqcahiuPXCPqqqAsk3xxHi1Ev8aiHzBz/qJO1YY/KwnpdUx3elHb
 Mbj2OG4tzXqIaOCJ7xzjf0n7TyD/+XfpXY/JB0ZOeyFuJvcay3FAmBBnyH/FSNnwx4Z5K4E1D
 5POkQ58Y9tL7592CIwvJzl1hHlzVtQBI49qhQtn+OcA9CQtXxNDT5mlmtPKHofUABCBosMdLy
 SiREsskjNqMdheNjyhxcsUVUkJhEecLSScw9q/roU2YADuqE+4KgQOhepgOu6pSKCnowxjZSr
 t8336eJJQdfPgVIyF/7tBOW8+HeTikpmX8Vn93LDDsfex+xwk+u16VvoUWo0lagcxo3BHw9XA
 7xbG0LVDoROZkjuKNRpmc4NUdNYRmJt8/k851sAh0Yj10sOUy+uoe9x/MWxEIjS8a60LdgOfT
 aeyda+GE27pnB0gjWa2+U0qUsjp+4aJc0DgTA5bZ9gravAXCYJp1PLC/dnvl2eLKr/TwO+zvN
 yPIot5G6xNGtrWuf612VnYq1oNabNRgtq86fqhiqfXPHvPvyu2Y0RbRcPsiYQayTJXUurGpbB
 AAfdJuMIpjrwD+pP3o35+jxDhCJpLFYRm5Pe1K8BAXPUf80cBuDo5YpVuP3CKSojebOpPb49/
 Yjry9Jqyf96AUEtKJsmj6q8zuerFqUxW5EDW+wE3n995e5i6AcerCbemolag==
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

I now removed your patches about the development process as some=20
comments came up.

The following changes since commit 6b2d05748cf3cd6ba417a96c00602b0122e10af=
6:

   Merge tag 'u-boot-imx-master-20260117' of=20
https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2026-01-17 22:29:24=
=20
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-04-rc1-2

for you to fetch changes up to 8304f3226700561d219850ee3f542df37373c843:

   doc: board: starfive: update jh7110 common description (2026-01-20=20
11:03:03 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/29050

=2D---------------------------------------------------------------
Pull request efi-2026-04-rc1-2

Documentation:

* Update StarFive JH7110 common description
* Add TI AM62D documentation
* Update urllib3 version for building
* Update links to doc/develop/falcon.rst
* Describe QEMU networking
* kdoc: handle the obsolescensce of docutils.ErrorString()
* Fix typo "addtional" -> "additional" in pflash section.

UEFI:

* Fix boot failure from FIT with compressed EFI binary

Others:

* cmd/meminfo: Correct displaying addresses above 4 GiB
* test:
   - Consider configuration in meminfo test
   - Consider initf_malloc is only traced with EARLY_TRACE
   - Clean up test_trace.py code

=2D---------------------------------------------------------------
E Shattow (1):
       doc: board: starfive: update jh7110 common description

Heinrich Schuchardt (5):
       cmd/meminfo: display of addresses above 4 GiB
       test: cmd: consider configuration in meminfo test
       test: initf_malloc is only traced with EARLY_TRACE
       test: clean up test_trace.py code
       doc: describe QEMU networking

J. Neusch=C3=A4fer (2):
       Update links to doc/develop/falcon.rst
       docs: kdoc: handle the obsolescensce of docutils.ErrorString()

Manjae Cho (1):
       Fix typo "addtional" -> "additional" in pflash section.

Masahisa Kojima (1):
       bootm: fix boot failure from compressed image for IH_OS_EFI

Paresh Bhagat (1):
       doc: board: ti: Add AM62D documentation

Tom Rini (1):
       doc: Update urllib3 version for building

  boot/bootm_os.c                               |   4 +-
  cmd/Kconfig                                   |   4 +-
  cmd/meminfo.c                                 |   8 +-
  common/spl/Kconfig                            |   2 +-
  doc/board/emulation/index.rst                 |   1 +
  doc/board/emulation/network.rst               | 152 ++++++
  doc/board/emulation/qemu-riscv.rst            |   2 +-
  doc/board/starfive/deepcomputing_fml13v01.rst |  32 --
  doc/board/starfive/jh7110_common.rst          | 635=20
++++++++++++++++++++++----
  doc/board/starfive/milk-v_mars.rst            |  73 ---
  doc/board/starfive/pine64_star64.rst          |  77 +---
  doc/board/starfive/visionfive2.rst            | 449 ------------------
  doc/board/ti/am335x_evm.rst                   |   2 +-
  doc/board/ti/am62dx_evm.rst                   | 256 +++++++++++
  doc/board/ti/k3.rst                           |   1 +
  doc/develop/falcon.rst                        |   1 +
  doc/sphinx/kernel_abi.py                      |   4 +-
  doc/sphinx/kernel_feat.py                     |   4 +-
  doc/sphinx/kernel_include.py                  |   6 +-
  doc/sphinx/maintainers_include.py             |   4 +-
  doc/sphinx/requirements.txt                   |   2 +-
  test/cmd/meminfo.c                            |  20 +-
  test/py/tests/test_trace.py                   |  38 +-
  23 files changed, 1019 insertions(+), 758 deletions(-)
  create mode 100644 doc/board/emulation/network.rst
  create mode 100644 doc/board/ti/am62dx_evm.rst
