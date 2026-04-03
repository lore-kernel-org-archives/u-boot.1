Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7FCE8538E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3375D840AB;
	Fri,  3 Apr 2026 21:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=initse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=initse.com header.i=@initse.com header.b="hwoRKrJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CDE28407E; Fri,  3 Apr 2026 21:23:39 +0200 (CEST)
Received: from mx0.initse.com (mx0.initse.com [85.115.11.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A9783F9D
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:23:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=initse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=akoch@initse.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=initse.com; i=@initse.com; q=dns/txt; s=mail2k;
 t=1775244217; x=1806780217;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ZMDGcU78bC3RK4yYtxaWk9vcv37tIx91t6uJGAsJttw=;
 b=hwoRKrJW54DAnFbi5ww8oMSzgrNuf/YOcXzNdcseQwIDt24EH0TBHQ6B
 DXsbJx5+PvcO79KuzSU/OsZlw2/sn1MhiIpuAiMztn1kDfy2rlFyE2WjJ
 ZFuzTMfohsLM+LpNOOBhwXoB6MPofMDyZnJdPlei+12oCMZGi49btmMiN
 NTccr8e779aSJew6p5ENQijc99Q0A6HJdPLVykLYgFK881ErpyGBVFejs
 Jz0kZdi5dKv0b1PCUrKzSH/2yYV1Jpf73F83hWoNO2ph88GCTSWaFw5V9
 DE5tN3oQcPD+7BU/r+4gn2Wj3YzrUuiIf1lCIb6+LXJm5cnL/XzcQ5QmI w==;
X-CSE-ConnectionGUID: ssAAAOWmTF6MV6hXbRbAkQ==
X-CSE-MsgGUID: Y+PMjpSHT3yS2LY2nnvqog==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2CCBgDVEtBp/xpkFaxaHgEBCxIMSYcWAbZJDwEBAQEBA?=
 =?us-ascii?q?QEBAQgBUQQBAYUHAo0rJzgTAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBAQUBA?=
 =?us-ascii?q?QEBAQEGBAEBgSCGCVOCW4QABnkQAgEIDTkxJQIEAQ2Fe7VLgTQaAmXePoFwg?=
 =?us-ascii?q?U2BaoEngXSDUgGFdjeEQ0KBSUSBFYMqPoEFAYM9hkQEgQ6BFIEOixKFQVJ4H?=
 =?us-ascii?q?ANZLAFVExcLBwWBIxAzAyAKLy0CFA0QEg8EFgUtHXAMJxIPHRcVH1gbBwUSI?=
 =?us-ascii?q?SpuhRh2Ll4aDiICKBEDWTgSPgtSBYIEAoEfYwMLbT03Bg4bBJEKFIEByCmEJ?=
 =?us-ascii?q?qFyM4QEk3kDGZJSLphYIqh0AgQCBAUCGIF/gX4zGggbFYMjURcCjjkOC8hUg?=
 =?us-ascii?q?TUBAQcCBw0DC4FohF6LViwBgRwBAQ?=
IronPort-PHdr: A9a23:9CBp1B/m0d2woP9uWRq6ngc9DxPPW53KNwIYoqAql6hJOvz6uci5Y
 QqHvb480wKBHd2Cra4f16yO6+GocFdDyKjCmUhKSIZLWR4BhJdetC0bK+nBJGvFadXHVGgEJ
 vlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+I
 A+5oAjftsQam5duJro+xhbNoHZFe/ldyWd0KV6OhRrx6cm98ZF5/yhMp/4t8tNLXLnncag/U
 bFXAzMqPnwv6sb2rxfDVwyP5nUdUmUSjBVFBhXO4Q/5UJnsrCb0r/Jx1iaCM8L5VLw5Rzus4
 bpzRBDnlCkIOTg58HrKisNrl6JUvAihpx1kzIHKZoyeKedzcbncfdMeQmpBQ9pRWilcCY6yc
 4cDE+wMNvteooLgpVUBsAG+CBGsCu3x1DJGm2P206M53eQvEw7J0g0gEM4Bvnvbt9j1KL4SX
 PqpwKXU1zjOa/Vb0ir95ojSdRAhpOmBUK50ccXPxkggDQXFgUiOpoz/Ijib0+MNvHSb7+F9U
 u+gkW0nqwZtrTiv3cosi4/JhoMJylDf6yp12po6Jdq9SENiZ9OvDZRfuT2AOYRsXsMiX39nu
 Dw8yrAeuJO2cjUHxZAnyhPQZPGKfYiF7BLiWeieITl1i3Jrda6wihu970St1u3xW8u63ltOq
 idLnMTAu3ED2RLT6saKSP1w9Vqi1zaXzw3f9+NJLV4umabFNpIt2KM8moYPvUjZACP7mV36g
 ayWe0k+5+Sk9uTqbq/7qpOBLYN4lw/zP6Yol8eiG+o3KBIOUHKe+emk0b3j+lD2T6tSg/0tl
 6nZrIjaJcMGpq6lGwNV0pgs6xK4Dzq+y9QYh2cHLFRbdxKdkYfpJkrOLOr5Dfe5glSsjC5nx
 /PcMbH7BpXCNH7DnK/gfbZ79UFc1BI+wc1d6p5KEL0NPu//VlXsuNDEEhM1KRK4zuf/BNV4z
 IweWGaPAqGDMKPVtF+F/vggI+qLZIAJuDbwMPkl5/jvjX8lgl8SY7Ol0ocQaHC9BvhmOVmWY
 WLwgtcdFmcHpg8+Q/bwiFKcXj9efHCyULgn6TE/Eo2pEJnMRp63jLOd2ye7G4VaZnpaBVCUD
 Xfoa4KEVu8QaCKSOMBhiCIEWqahSoI62hGhrhP6xKRpL+rT4C0Ytonj2MJp6O3UkBE+7SZ0A
 NiF02GRU2F0mXsFRyIv0K9kpkx9zUuD3LN8g/xZDtxT++hJXh0nOpHCyex7BMr+VR/fcduRU
 lapXs2mAS0tTtI229IOe1hyG9OtjhzZ0SqlGbkVmqeMBJwv6aLQxX7xJslly3rcyKYhiFwmT
 tNVNWK6nq5/6xTTB4nRnkSZiammb6Ac3C/W+WeFwmuOpFtUXxJ3UaXARXwffFfZrczl5kPeS
 L+jEbonPRVayc6eNKRKdMfmjVBdSffsPdTReWOxm2OqCRmUwbOMaZLme2MG0yrFEkgLjxgT/
 WqaNQg5HiqsonrSAyFtFVLuZkPh6fFwpny1QUEq0w+Hc0tvhPKJ/Utfi/GHV/4N17cstyIoq
 jEyF1G4lZqCBdebuwd/daB0btY04VMB3mXc4Ug1dIStKa8kiFcYWwNspAXoxw0xAYJF24B+t
 H4sw0x8IKSw10haMTWIxdb7PbiBbiG4+Rm1Zr7+3FjU1N+a97lJ4/M94R23uQizG1oK9Xxt1
 9BZ3mXa7ZLPWk5aG4P8FEI23x5qv/fRZSx3r9fF2DtoMIGyoieE0NUsUrgL0BGlKv5bPbONE
 gP/CYU5AMOuYLgjmF+ibjoFOuFO76NyNMSjIajVkJW3NfptyWr1xV9M55pwhxrkyg==
IronPort-Data: A9a23:ZF/OnqldTtbShRDQUhVOVovo5gyfJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIdWWiGM6yINmqjKNFya9+zoR8CvZLXm4RhGgVlqX1gFi4T+ZvOCP2ndUqhZCn6wu8v7a5EA
 2fyTvGacajYm1eF/k/F3oDJ9Cc6jefUAOKlVoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GSNhXguaQr414rZ8Ekx5Kiq42tC1rADTakjUGH2xiF94K03ePnZw0vQGuF8AuO8T
 uDf+7C1lkux1wstEN6sjoHgeUQMRLPIVSDW4paBc/H/6vTqjnVaPpcTbJLwW28O49m6t4kZJ
 OF2iHCFYVxB0psgOQgqe0Iw/ylWZcWq8VJcSJS1mZT7I0buKxMAzxjyZa07FdVwxwp5PY1B3
 ecDARkkSS+Gu8zo5YzlStlmvM4KL/C+aevzulk4pd3YJe08X5bOWajX/plZ2jYsw8NHW/LXY
 aL1axI2M06GOUQJYw9PTshg9AurriCXnzlwoVGSrqof4m7S0Bd8lrPqNbI5f/TXHJ0ExhjD/
 woq+UzIQSk/NsSk6Qbe40n2ot6VmyXlQYUdQejQGvlCxQf7KnYoIBgfT1arif+wgEq3V99Bb
 UcT/0IGsag77lKmX/HyVgG1v3mevQVaUN1Ve8UnrQuKzbb85weCGnNCQjNHeJoquaceXTEs2
 RmHltXBAid09ruFUTSW8bL8hSK/fywUBWkSfWkPSg5ty9fuu50+kBvKZtlmGa+xyNbyHFnNL
 yui9Xdkwe9Ky5dTj+Phozgrng6Rm3QAdSZtji2/Y45vxloRiFKND2Bw1WXm0A==
IronPort-HdrOrdr: A9a23:ta9j4K5Itkg/qiW1wQPXwR6BI+orL9Y04lQ7vn2ZFiY5TiXIra
 qTdaogviMc6QxhPE3I/OruBEDuexLhHPJOj7X5Xo3SOTUOxlHYT72KhLGKq1Hd8kXFh5ZgPM
 xbE5SWZueAb2SSwPyKnjWQIpIF+p2q4aqojeDRwzNEShxrUbhp60NcBhyAGkN7aQFaDd5hfa
 DslvZvln6FQzA6f867Dn4KU6zqoMDKrovvZVojCwQ84AeDoDu04PrREgSe3D0ZTzRTqI1SgF
 Ttokjc3OGOovu7whjT2yv66IlXosLozp95CMmFmqEuW0jRozftQL4kd6yJvTgzru3qwk0tis
 PwrxApONk2w2/Nf0muyCGdqTXI4XIL0TvP2FWYiXzsrYjSXzQhEfdMgopfb1/w91cghtdhy6
 hGtljpwqa/MCmw6BgVpuK4IS2Cr3DE1kbLkoYo/gZiuMUlGfZsRLwkjSRo+ag7bVnHAaAcYZ
 VT5ZLnlYlrmBWhHgPkl2NrwNCqQzApEg+bTlIe/syZugIm+kxR1EcB2MAEgzMB+fsGOuB529
 g=
X-Talos-CUID: 9a23:AhHJR2Hkh8Es3TQtqmJ872c9M+cad0HzklLufU+IA1xjYb6sHAo=
X-Talos-MUID: 9a23:j0eDTAuZ57JaaUbvh82ntXJaEcVw2ISSU1E2y7E34c+CKzV3NGLI
Received: from unknown (HELO srvnereus.init-ka.lan) ([172.21.100.26])
 by gateway13.init-ka.lan with ESMTP; 03 Apr 2026 21:23:37 +0200
X-AuditID: ac15641a-1db6d70000004999-26-69d013b831cc
Received: from srvkamail02.init-ka.lan (Unknown_Domain [172.22.3.1])
 by srvnereus.init-ka.lan (Symantec Messaging Gateway) with SMTP id
 EB.69.18841.8B310D96; Fri,  3 Apr 2026 21:23:36 +0200 (CEST)
Received: from srvkamail01.init-ka.lan (172.22.3.254) by
 srvkamail02.init-ka.lan (172.22.3.1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 21:23:36 +0200
Received: from srvkamail01.init-ka.lan ([::1]) by srvkamail01.init-ka.lan
 ([fe80::5268:42e0:6f9d:2b71%9]) with mapi id 15.02.2562.037; Fri, 3 Apr 2026
 21:23:36 +0200
From: Alexander Koch <akoch@initse.com>
To: "festevam@gmail.com" <festevam@gmail.com>, "peng.fan@oss.nxp.com"
 <peng.fan@oss.nxp.com>, "marex@nabladev.com" <marex@nabladev.com>,
 "ye.li@nxp.com" <ye.li@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>
Subject: Re: [REGRESSION] imx8mm_evk: FSPI build broken by 37e50627e
Thread-Topic: [REGRESSION] imx8mm_evk: FSPI build broken by 37e50627e
Thread-Index: AQHcvSjV1dNpFpsg1kCvt5aj9JNg7LXBC3UAgAEEqwCAANbeAIAFXWIAgAAoF4CAAADDgIAFNacA
Date: Fri, 3 Apr 2026 19:23:36 +0000
Message-ID: <032b2f81f63f0fa9f3f5910edd4222932b4a4741.camel@initse.com>
References: <fcc606350e96e03911f6c67537853de1ad51dc10.camel@initse.com>
 <861d61d6-3d35-47bf-9cea-21f7cfd13c1a@nabladev.com>
 <24e183b2fc5419b9ed1685f49a67fb9822b1ad73.camel@initse.com>
 <a5f735cc-e699-422a-b88d-e5fe33fc8b7b@nabladev.com>
 <ea2937eabb137e2c5845bc451f7c28a827496eb3.camel@initse.com>
 <CAOMZO5CsuTw92safK80f0v+0hPkOQvHVEfKZyqWvfdw7ghnxmg@mail.gmail.com>
 <CAOMZO5AqeMmeWLXX3mPKceshw8T=fcFax7Ja=tfm0Qf6Mh_cOg@mail.gmail.com>
In-Reply-To: <CAOMZO5AqeMmeWLXX3mPKceshw8T=fcFax7Ja=tfm0Qf6Mh_cOg@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.58.3 
x-originating-ip: [85.115.11.137]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <326E00AD92EDFA4E874234CDECAA955E@init-ka.lan>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsWyRoyZUXeH8IVMg4fTrC0eXvW3mNrfwmrR
 vrKDxeLiiU/MFm/3drJbtB0/xOjA5nGu5y6bx85Zd9k9zt7ZwejRcq2TzWPjux1MHo+O7GYJ
 YIvisklJzcksSy3St0vgypg8cQlLQStPxf7ZM1kaGL9wdDFyckgImEi0H3/G1sXIxSEkcIxR
 Yvuex0wgCSGBt4wSCzaJQyRWMkrs/3aAFSTBJqAuseDkTmaQhIjAGkaJx22fmEESzAIpEquu
 rAHrFhZwkbi7bzMbiC0i4CrReaifHcKOkti85SuYzSKgInFnSwtYDa+Au8TiZw/ZIbYdZpb4
 23warIhTIFBixvQzjCA2o4CsxIYN56GWiUvcejKfCeIHAYkleyDiEgKiEi8f/wO7VBSovmnb
 Dqi4osTPHa9ZIHr1JVY3HGCDsK0kXhxaCmVrSyxb+JoZ4iBBiZMzn7BMYJSYhWTdLCTts5C0
 z0LSPgtJ+wJG1lWMosVFZXmpRamlxXqZeZklutmJejmJeZsYQbEtmiK1g/HRoWb9Q4xMHIyH
 GCU4mJVEeKd0nc8U4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvuqzzBDSCA9sSQ1OzW1ILUIJsvE
 wSnVwFRxgPOLd4jGmcQX7FvqNjFc3rvcYK3P6yu2VnwN2p+9lso+bFL9erPoCldkCEPcdgOZ
 O6Kr5ygevvOjXPCf74xp7d8Vbib0Jd6at75vzuHPn11FjF6/13rCYRb994zLcetbV95qZh86
 YM0g/OvagucOL9Nnd8Wxh1x+3OG0sDNtiZOG4JF83ssyaSUqj1reGaY/dZzOEX3nhfemM8t8
 A01vymTbl82RP8bZnXEv3bNh9cyHEn1yCXMtt3U5nasVnX/o+rE7k2Mfi9yecNpvpsnHI8Xq
 sU/EOjZPE6lli93a/Ob9ae0VbTXCWhJlr2+/VJxcI+/J2Sgvs/rF7i7vLXfTu1Yk68k7ZXgJ
 zmLK+KvEUpyRaKjFXFScCADGAkXLXAMAAA==
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

I think I have narrowed down the cause for the broken SPL blob but I don't =
fully
understand it.

Comparing hexdumps of the last working SPL+DDR blob and the first broken on=
e we
can see three chunks of difference:

1) two bytes near the IVT
2) U-Boot version string and compile timestamp
3) four bytes around offset 0x18b50 (striped at 16 bytes)

Let's ignore number 2) as that is expected and focus on 1) and 3).

For the first difference we have at offset 0x20 in spl.bin (0x1020 in
flash.bin):

  good: 0000 0020:  C0 0F 7E 00 00 DC 02 00
   bad: 0000 0020:  C0 1B 7E 00 00 D0 02 00

I first thought it could be the boot data pointer not reflecting the FSPI c=
onfig
blob offset but if I read `struct ivt` correctly this is actually _after_ t=
he
IVT itself.

So I patched these two bytes in the broken 'flash.bin' and that made the SP=
L run
(while console output still stopped before ATF).

The second chunk of interest is at offset 0x18b50 in spl.bin (0x19b50 in
flash.bin):

good:
  0001 8B50:  B8 C4 80 00 00 00 00 00
  0001 8B60:  F8 69 80 00 00 00 00 00
  0001 8B70:  74 63 80 00 00 00 00 00
  0001 8B80:  80 E5 7F 00 00 00 00 00

bad:
  0001 8B50:  B8 D4 80 00 00 00 00 00
  0001 8B60:  F8 79 80 00 00 00 00 00
  0001 8B70:  74 73 80 00 00 00 00 00
  0001 8B80:  80 F5 7F 00 00 00 00 00

After patching those 4 bytes I got ATF and U-Boot proper running so I'd con=
sider
that flash.bin fixed.

Can anybody tell me what we have in those two locations?


Best regards

Alex
