Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1F8105F79E
	for <u-boot@archiver.kernel.org>; Sat, 14 Mar 2026 09:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23FA5842DF;
	Sat, 14 Mar 2026 10:19:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="irDBZVmr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E07A384332; Sat, 14 Mar 2026 10:19:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0B5E842CD
 for <u-boot@lists.denx.de>; Sat, 14 Mar 2026 10:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773479954; x=1774084754; i=xypron.glpk@gmx.de;
 bh=5r2XcWRUb9CSC9BjNY+OkLCnfKHE0Qb1IMeLGa64suI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=irDBZVmr/ydPhKT7FpnwBvNMYUyOQ9Hvst6l+Oo5g98OJInXYtTG61EPQ+QXj8uD
 4fHWAjLw6N15GDu5cs8hBz/p4p8xFNw1kb//VyIzgrO+AMUNXwXwjdzJxKOLSMc9B
 dG8hiLD/0jPv/rfmKAjrACAS5LIF/per5YpNoIChuyaLSpizJ825M7Sec+bfz6XqQ
 tHfb5EQQ+I0WQroB8wLIkp+lwLLfNw1DsYtdmPaCnlzkOvP3FsGQZ/GSyqrcj8dyo
 GgnwuYe+16X+haHZaUrB7uIDjvY5fDiwAONA1/+Zn6puE46hSpmEGz8/eBLxLkyhH
 nx52WNt9WLQn3t2FTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5QF-1vnJ3t22gJ-00AKvC; Sat, 14
 Mar 2026 10:19:14 +0100
Message-ID: <9334dd3b-3bf9-43f3-b711-235246f3c901@gmx.de>
Date: Sat, 14 Mar 2026 10:19:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] efi_vars: Implement SPI Flash store
To: Michal Simek <michal.simek@amd.com>
Cc: Shantur Rathore <i@shantur.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, git@amd.com,
 u-boot@lists.denx.de
References: <8ee5fc7a49816d9e26f38999990aa1e4e354801f.1773416725.git.michal.simek@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <8ee5fc7a49816d9e26f38999990aa1e4e354801f.1773416725.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5WFNd3JwIVkT+2ojCnVgOg8I9usWNflJHKbWF3ffCISMpZdyEyF
 Uwtm7fh77owkLaiiDnS6HDvWhc17/cL5lUT0W6e+A0ZhHFLKitLYAKSQWfaUt2K5luE8GDe
 vIBCUnPMn8dFbYgvYOFzbfNethhx7reUNtjZQlOIj16E/K7uStsqMOdhbxTL6I4qVA68FKc
 wLWccar54aBItcbR4F3Og==
UI-OutboundReport: notjunk:1;M01:P0:TC0RGRDa5pk=;EDv5U81O7uWBFRX+PzqhgnxP8cF
 3x1qwRlQBs9ALtUngu3yUKG6yYCQl/Yyec2Pugim9IHUKTQYgw3XdzxdqjS42Xk02bQ55Elcc
 Bc7/phbSjJoq7B0i559EA21ux0+qe7OhZjF+X11NFDZWXyVAn3OnCPBB0/CeWlD/tALpEflLc
 Lsp8OCZA9Razu0VdeKJgSOZahmcpWqI/uDLgWz4elCS2N+46Ji7LniNLZb0E0hhNREK0dmh+E
 8JK3wM/OZX+mJrC0upcikB+rDq0tPrJVLk85a5Sj0nIfXH448YTLOCYZpn3Rrp5+64+aG8+Za
 y3rSsxYr1efKwwwKnO9j7YEblheeZ0EA1nIiSgeLQUJZJsT+3Vl9Ub28t5lAhMUc9ik2KLRQT
 tzFG+QDOLgrmRLSzUeUIKHzvLrBbODYtrpVRSY0LijuoOaGu92FuoRn7tS04kVyDiNVnaDf9H
 XWbNVFZyxn/jpfXk0Ul9CMJomgN/QXmlTFfJQaEDt8Y3LSxP1uEmto/TiqRwtHtrZe1WrqcIR
 KwKA66bJhntpxWVSshlB+a9nXO3eWqlSCV2XVPCDZAVd5ZQaLJ+ZCDBT0C8LIHoCqQjwEHZ4p
 VKawzJzV18jkdWu1/ZP2iBwzni30oPfo2W9hwxnJccqG417u/8VPv5q9nNw+ybDf9EImMmxNe
 8Cp3BdyCfa3/GlaGkG2f04Q32/FSJhMY/bDMlW6eiKXjjhJgtX7ZqsNbvavrHtgV8YybfoK+l
 7vz5CGn9GBg5GejH3N/DYvBk+2y+wvjPsl+Vp7cB+6m3GxXMG/ffpqs3z086kBl+25UriV3tk
 ieHL460T5PloGRQUoTRANsAjzn0dZV15yTekZwSp0ohATZ0X4w+0EYdJ5t2Ks+OrW8IOpySUd
 WnnlJteq4wH4SLbssf+bkCwHv+nLhvQRXNFaNKB+K2ID0h8TUUtVpgO7RlEfCTaeGrpizt4Jx
 paBl73cKvpbSX6Hmtb0M74nyBLQCfAjRsobYB1Sbq1cLYSBQnxjYg+TnoDzh9oJifkmsz9R/9
 uTsKvF/YyqbQMtAzqTl5UMWVLobobgI+gIJl7mr0KNey+PPnpuULsJ/K1qRQPLaIB8MqNy7uk
 /Aq2JugG9oZGHv/NrgbTShx28L1jDbZz2kf0YIjVx1iKfESv6TJnI/GlZNS51Kh47cmRD5JKN
 WDpTUYZ1IkAPAbvuLmEFEc8K3biDzGXkkPBjqfH5Wf7/OxBlkBSTLJE80cfld7dt1lTowQTG/
 al7hZb0KZSFogkd9Br6hC+UVUYrVSEXgOSJ7AcAiby2P4aS0fk27lBWvuO3YPmd2Ke96pbHCF
 JIMYuOsymolePy4iSKWVlLilrlmt4uQzKUI5rIBY5Sos6S+Q4w8cTciOhH/8QYiZpMDcK61CK
 6EHbZC2Gu4JDk3vZVm5Xsmzhs71RcmWX2OvvnmgAJukPUHPEOK9wzTLcbKrx88tnHcp270EBd
 CgThd56srQIQ9v6iL/DpHH4+HKohxH/J5HI/41xRvFkClJLlIGsEhZ5PaMYzl+Ar37XSZfz8b
 3EToM74CrBw7BFIJ0gVXdm0zHYu/w0c0LJvToHvj8ePpzcPrFCrI+VjytYaOAvin38QmD/IIM
 AGBqvNem20gQ5ciy9FvkbPkVjjsBnDH5ZgxKkgvMwiVa74pN5OTTKLBcHSIOTVyy+mGCM4Fqy
 Zt2NG84SE84lwtuvhhK9aw8AP3eO4I9x8YoZ7kt6XT8k+rhg2G0Wcd6ypDhPKN5EzL9kXUaL9
 s+23xOlY01se+vr8hVQF91nP+ktrnWWgTgd9vlP3ORi9NsqePMd0vMPV/NXomtNDcAGRsH6mR
 JD5Nx85w9rHdygZCSZ7jvtda8VIHuXsLWyOaaAacHqdSrWByOUGTPIhePfQpe3f/eh9QX4XKk
 PYtvWgeDyKVLwgwf0loEte3MXz96JO6iwuqQ7COkdTl+UT/bC/sDe7f1n2qNYYDusoNyU44GU
 +hSS9EUjPq8HAAVfBUAsTUdY7GtBmDY4+m/KAU54nQafFVZX9SMGOLt6hcF5yL75XjdpxQVQG
 Il+Mv0bixCndSt5mTBt5FbQiLRWy2QJ93+UUlZfrS3HWeFCGDOnl1Zbd4Y3ZEMhTECf2FidzQ
 yNUPkieTe26SjzICU+/IlYRi0fOOxahd9RBFkuM6w9FTY52r/NUivQZBJsMC0EqRjOFYV/wMq
 GB5GM2LqsfwQEsaLdHprnUCFVgkrykcNgvAHQHl5YtsJ30fZI/tkLa4o7tqJltXafiOwfW3Ge
 IJYbImYgdp9UKwqytWPOlZnOsyGTAmsDpWhaZb5aidw9Gv5dhQnqoaMh1NEDzIwRK8Yd0zE/S
 Oy3IceLh184LJq9/+VLqPGgaghsRfpdDfjIkmmgHtYCM8TBYPF6rORRX6H5ElrG9oARkHdN39
 qSGKGhO+uFH2GIJMDV584K4QsGgYGHSPjNzpS6HxAy3io6aIRhs/KN87n5exLCJJmjHnBGxdm
 tjeJth2vLW4/KtrOIME5rJOtGH/oju15nvX3gtsewwhcTf1zQsi35yx3EvAP1HY8jTZ/PzcZp
 X2k1TB67V8ICP6Ar90ugkOd5bFDM/F/m+36kkE8DeJHOmIpKUJi8k228QjkYWWqE0AQfxYdLG
 FtopAAy4PHyvnCegyzohMFx9A/GOENuKQg+MPzPjl5g3whue4sj+OjnwBt6kSBnN2PbBkq9Oi
 OrsoXvlYAdYaL4b99yueU5kjYgiwmF0i+DnaixDdUjAiOzf1zFQjMNzFJvLWRMbBwppCQTwhk
 Oty+jLfQR29N0sjMM7P2H4amJI5tNBQskQs83WT1XrYBz2uRse8hSidxT1UVtZT8QB49ln/4/
 CZVUf0cgv/6AxN3pXcNPjhTy93P3saJmg3+TiFIL7NqFcWJRxvDLuaUyuETu4bs/ajaU1UqOD
 ZAAEib3n78iSTJ8AFuPQHHkydD1q1FCO+MsTRDrapx9rA7H47aNPF8l3jkeKhP9NsYOTBev+m
 dp0QxV2ptyGEVUCug4MhaVfRLhbJi2mLkcvcqKghqbe+kjEG10irIYdZDwBJFECJd1COMSnYN
 fbeo9qEFbaNK5C+ouVfrcEoUooayIy22eBrIIVT6JJx3fXja+J59TWSD7NDq4XwT6AiwlhKAi
 3jkwaxbjk5/hYMntF+1zJmjep/eeZlSNmJCGNbIt/u6r0afEXiPsY0ut5HJ0Sm4jvwJmEvVxz
 k/tkT6RRSRbGLzpcr8nD3Rf1dvbePNWACXX+JYxNI3BzySQN7DT6jxAT/2hj9FO5MrJ+60TEZ
 zfIG+ltikskbkqoQmtN/GZzve4L3mHugnqsEdDUcmz2R61YzRdx+nTIpyk8pcGQiJV/gCZj+u
 YNLmkhXUmQkOJfeQQi7AhL+8BRThCnd4K6xkFfH7QUcfbvbJAXOHfqgT1unPdniml/Zwh0InB
 1EFz+XyKf07K9nZg84ICkGx+EnzXWe8xAvDdepCMsJbyRJNqlu6NZs4LHhnvoz1cUFLW6Madp
 RO2BO2ZIstDJPbrcl9qIVPJYttk+Di/iS+d6x3eWKJCmR2h2o3VG38RA+ojQ1DojYbqLc3WoI
 L+hJnmVZlsT5KG2/y0XTRv8qxLBpzx5dGk804AVd3nNmD9wgmdoe36FWTUGgwNxC+qWYnMIcQ
 CKzfvEK/eB2PdTSm8Ujfo27BMWxC2gNwhPEPktoTvtluo2gXz9oNOb5wMlfCrg8IwZ6On93X+
 I975otC1THluDzmfCrqq6z9W4ue4IegEZH7hxlACVjyuZ1+suDgghlHBkSTnB+8EFbfhLiW00
 XGhoHhawK3c2LfHqR9r2fyf0aYLBuQel7V0CTQDqYh/XOyuqX8E45sjru3vptdK/x2mTEi/cR
 dv703XFdkNIy8RkYvQUhoyixJ3Jp7JX0+JpA9Qd+yRYfvLd2OmryfybrojHV0PwmdiBJzAmFa
 0NYkE+z/B/6SObx0uaF97+Vxv3u0C+Zb9C20jL22T0b4B23LtU2an4ezxihPtvFvRatnHyT7s
 vAQhf9nveq6c0ffpU1gAuFwkHJxGOBASDPyMJl2CnLQvM2LOvgUFdFSHbcCA/UVyZWUwHFLZN
 gh1HKdW42ARbFLbSz8ehxML3Am7WKZf8quGeZNtTFhagKvglXI48bHSNrwu7KDhaFlhNsTD1a
 /oAYfTd2tCVkYUUOkXUXwN35CkgeSpxX6OTn0DSDRO+LwYqWW1BsJvrQp1qoF2aqFh+omAtWS
 BVq4UhiFGJmtje+fJddRUp91xjsMQZ4qP7mQnSAvYvEk32ziLSUyiPMeGK3LxfcDUaYvSrhpY
 Ub3SiJrfR9I+KmmQeNBp9Wlonpq7JdSgIo89WfdNAGx45ZSHLY7lsSNGyf5MRWg4q4wOblbiN
 VN8Hgik5zqm78DWhXy9GMHaM0usS0Jq0GZcNPen11wSQtdrdb111fXOXUiBAA1PbRpLi9tX/J
 Fg32U/t80lFdG9kVY27t93IefDb2M3Wv+twiu6Gb6K6AEIefrb1ojX3ZOFr8fgLbQwKsybA5L
 mGXo6WqYOsDu7dhgfJDnoXB+f+6Q20/yKdSOg3dQjXerB5g8phZpLLyIBOv5m0pEnlQFcUarD
 YIPswiiVP2FaOI1JRl3ypb0Jg7gdAPSL24/zeTxcEVBW2jAhSZIeleSjvfhj8iYyZYOvmWT9G
 3Ms8qYCqwrBEXUt2UdUJAW9OyF4zJUhWJJfkqAj5BD35yoJ0jBiiCBSU324SZpoosQYjX9rJS
 HZsoXhwQOrQkGGjCQsTUpyTwaA1K6LhDVhMzDxs9c9/sE22aorMdRJ+q/VXEhRvWRXiYBCzA4
 RHEGl8XHb49fmOtIfSVeAEmsfBaADWo34K6FTukO3IsXxo2EV6y+QmXcx72B6WsF5aJzF7ZxV
 9S3FS8D9D3xZwDpm11YW8xNLgdydLWlclth6Gl9yHuxMCNht9t80Fnhv+WSfg07LlxrjFbJfN
 QQSPoPkUuGr9XDoIwy9DOkOHk+yZhY+UtAOavWRfoAz4akcrzrjNx88H1bIVqIcVMSCmfRZ6r
 6yrSBuI5xJ6Nckfuv1AXbcvBX4iSJIoobpWWmNEcPFIAKubqNCE7QqL6X5NcdzK3XBbo+yqcg
 kd/g1mqjsbBORTVv3U/Yd9DEOZEN/Mit4oZtfR1CpkWLVP07EY3VTqjyNwSrEEyxtRqx7bFr0
 0F71/duzRsXWor3vV8e/HKJylayOQg71mDtZrfidfdXFOWWevsn5Xv3X6TMtf0pvMgO9VsSdF
 8P3wHHeAd0IjxsnupV2ubthZQa6Oi89BoUtkt4ykoaMrcNZS7diQoExW7zDHlqAVpvFIHjJi1
 gnTCBJusQ2/u91bWI9jGujUtZEvDkKbhFxOOVQVu3+8u7u6f6ke2LFD/i0hcwvQ/7AhRwzfpn
 ffPnlORcsQt
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

On 3/13/26 16:45, Michal Simek wrote:
> From: Shantur Rathore <i@shantur.com>
>=20
> Currently U-Boot uses ESP as storage for EFI variables.
> Devices with SPI Flash are used for storing environment with this
> commit we allow EFI variables to be stored on SPI Flash.
>=20
> Signed-off-by: Shantur Rathore <i@shantur.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905D3-CC
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Tested on StarFive VisionFive 2.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>


The next logical step will be to define a value like RTStorageVolatile=20
and allow to select CONFIG_EFI_RT_VOLATILE_STORE.

One way to define the location would be a SPI flash partition defined in=
=20
the device-tree. An EFI variable could provide the compatible property=20
of the partition that efivar should write to.

     partitions {
         compatible =3D "fixed-partitions";
         #address-cells =3D <1>;
         #size-cells =3D <1>;

         partition@c0000 {
             compatible =3D "uboot-efivar";
             reg =3D <0xc0000 0x20000>;
         };
     };

cf. Linux
Documentation/devicetree/bindings/mtd/partitions/partition.yaml

Best regards

Heinrich
