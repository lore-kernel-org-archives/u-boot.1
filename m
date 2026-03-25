Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218EA109C040
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 18:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82415838BB;
	Wed, 25 Mar 2026 19:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=initse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=initse.com header.i=@initse.com header.b="oUvSJROU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B793A83A91; Wed, 25 Mar 2026 19:08:15 +0100 (CET)
Received: from mx0.initse.com (mx0.initse.com [85.115.11.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 921A680077
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 19:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=initse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=akoch@initse.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=initse.com; i=@initse.com; q=dns/txt; s=mail2k;
 t=1774462093; x=1805998093;
 h=from:to:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=kbXOKuPKsQQfkoiKhf9tU81+nDJA3KxRKV7xy01q1TU=;
 b=oUvSJROU/4tdhFtZ+zibMJm01K6KiHTRE22R0/U/m9xqEL7+F1EDYwH3
 YS+m/xo6PVI5s6PSxOoUMPolbt0eaAIwNqQUk+5Tnkga6Y9EStBK7LYZB
 RMW1uzrQ6nLkfp2JeiirDf+OGi98IZy3u+SJLRa6gzqf21Gz1oxOWhzxr
 rn/qMnRM9xqULhdDXyS+bX1uhYMXrQrybuLS8YQsUDf+Z+yPP5UcEZpMi
 XC5HzKXkH8unlEnP7YKXyYUQQmMGybwAJr97ha/mOzIt8hWSZ0fxyXAHK
 fxeIRaPQ2pBtaHzWPDkIhcBuGdEmuMMO/MttLU0Nh3eUPcQWF99i5rqXd Q==;
X-CSE-ConnectionGUID: E6chxf07Su+n4lMvter/dQ==
X-CSE-MsgGUID: a28HhdGFS0Gm0dih1FjnhQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2CnDAAdI8Rp/xpkFaxagRKBSYVNAbZJDwEBAQEBAQEBA?=
 =?us-ascii?q?QgBUQQBAZItJzkFDQECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQEFAQEBAQEBB?=
 =?us-ascii?q?gQBAYEghglHDIJbhREBFWonBIYJshaBNBoCZYR82UKBcIFOgWmGawGFdTiFB?=
 =?us-ascii?q?IFJRIEVg2iLBwSBDoEUgQ6Bf4olhVSBShwDWSwBVRMXCwcFgWYDKi8tbjIdg?=
 =?us-ascii?q?SM+FzRYGwcFggQPiWFtgROELQMLbT03FBsEkSFKRIIixweEJqFyM5d9A5JrL?=
 =?us-ascii?q?phYIqNahRoCBAIEBQIYggCBfTMaCBsVgyNRFwKOPBbMQ4E1AgcCBw0DC4ZGi?=
 =?us-ascii?q?1YsAYEcAQE?=
IronPort-PHdr: A9a23:b4vQ0xcb1N9Kcy9Z9QvHMDeClGM+Ld7LVj580XLHo4xHfqnrxZn+J
 kuXvawr0ASVG92DoKke1rOM+4nbGkU+or+5+EgYd5JNUxJXwe43pCcHROOjNwjQAcWuURYHG
 t9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oI
 xi7owrcutMKjYd+Jao8xAXFr3tVd+hI2GhlOU+dkxHg68i/+5Ju7z5esO87+c5aVqX6caU4T
 bhGAzkjLms4+s7luwTdQAWW/ncSXX0YnRVRDwXb4x/0Q4/9vSTmuOVz3imaJtD2QqsvWTu+9
 adrSQTnhzkBOjUk7WzYkM1wjKZcoBK8uxxyxpPfbY+JOPZieK7WYNUXTndDUMlMTSxMGoOyY
 ZUSAeodM+hWrIfyp1oSohWxCgahH//vyiZSi3PqwaE3yeAsHAfb1wIgBdIOt3HUoc3pOacWT
 ++0w7PHzTPeYPxIwzf29Y3Gchc9rvGMQLl9dtDeyUooFwzZjlWdso3lPzWU1uQRqGiU8fBsW
 v6oi24isgx8pCWkycgwhIfTnI0V1kzE+jtjwIYzPdC1SlB2bMO5HZZTtCyXKot7T8IhTmxpt
 ig31LILtIK7ciUXxpkr2x3SZfyZfoWV/x/uV+mfLCl3in54ZL+xiQu//E69weP/Tsm5yEtGo
 yhbntXWqHwBygbf5tWbRvdh5EutxzeC2xjQ5+xEO0w4iLfXJp47zrIti5Yfq1nPEyH0lUjwk
 aSYbF8r+vKy5OTierjmo5icOJJqhQzmKaQun9C/Afw/MggTQ2iX4eS826Pn/U3+WLhKlec2k
 rffsJ/EP8QUuLO5AxRP3oYi7Ra/Dium3M0bnXYdNl5FfAiIj47xN1HPJvD3E+u/jkyxnDpp2
 fzKJKPtDojXInTejLvtYaxx51BdxQYryNBQ/ZNUCrUPIPLpXU/xscTVAQU6Mwyz3+nnCM5w1
 oIYWWKOHq+ZK73dvUWU6eIoJumAfJUVtyrlK/g5+/7uimc0mUIEcaay2psXb2y4E+9iI0WYe
 nrsnswBHX0XsQUgSuzrh0eOXiNNaHqqWaIz/Sk0CJi6AofbWoCtnLuB0T+mEpFOe29GCVGME
 XLweoucVPkDZjycLNN9nzICTbSuVooh2gu0tADm07dpNvPa9DUXu577z9h1/+PTmAkq+zJtF
 8qT3HmBT3psnmMGXzA23L5woUh6ylqbyaZ2muRWG9MAr89OB00ncJTbyPBSD9HpRhmHctqPW
 BCqT5/uVSx0RNU23/cKYl1hAJOugxbTmSanVew7jbuOUbUw/7LV2XT8PY5ezH3GnP0ojF4tQ
 uNOM2y6naM5/A/WUd2a236FnrqnIPxPlBXG832OmDLmgQ==
IronPort-Data: A9a23:/mY94axVIytHFXuSs7h6t+eFxCrEfRIJ4+MujC+fZmUNrF6WrkVWn
 TMXCGqAP6ncYTemKtEgOYy39E9X68fUzodgQQBprC00HyNBpOP7XtnIdU2Y0wF+jyHgoOCLy
 +1EN7Es+ehtFie0Si+Fa+an9T8gk/nRGNIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn/gFaYDkpOs/jd8Eg14ayr0N8llgVWic5j7Qe2e0Y9Ucp3yZGZdxPQXoRSF+imc
 OfPpJnR1n/Z5RokFuS+mb/9dEAQKpaKVeRZoiMLM0QKqkEqSh0ais7XBtJFAatko2zhc+RK9
 Tl4ncfYpTHFn0H7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhljJBleAGEWxgp4KUwQ/
 vwIJmhSVQ3Agb6y5aynR/Mriv12eaEHPKtH0p1h5SrDE/ArW53eWOPL495EmTQ5wMRHG54yZ
 eJANmApNk2GOkUXfA1JYH49tL7Aan3Xej5fo1K9pKw2/3Peigd21dABNfKIIozUG50Exi50o
 ErPpTTZAh01GufH5j/d/nOs38HNmyPCDdd6+LqQs6QCbEeo7nFWAhoRSXO/oOKlkQiyVtRPb
 UAZkhfCtoBrqxbtFIC7BkXg5iTa1vIBZ+dt/yQBwFnl4sLpD8yxXwDokhYphAQaifIL
IronPort-HdrOrdr: A9a23:Si589KM2SQYiCcBcTh6jsMiBIKoaSvp037By7TEUdfTMGvbo6v
 xG785rsiMc7wxhJE3I+OrwQpVoLkmsl6KdjbN/AV7AZniYhILLFvAG0WKK+VSJcUCTygc378
 Zdmt1Feb7N5C9B7foSjjPXLz6oq+PtzEgn7d2usUuFBjsaDZ2Ipz0JczpyWCdNNXF77LQCZe
 Gh2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3AnemjE2sV0/bOg0pjvQENKynu6IsILHbd3HmIfHS?=
 =?us-ascii?q?lSmA1TJiLVVKKv69dxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ADoh/6Q0UvZjO2xtpd69tWoSBNjUj6v7+KEABvrs?=
 =?us-ascii?q?94+aBbSBxO26zjjK3e9py?=
Received: from unknown (HELO srvnereus.init-ka.lan) ([172.21.100.26])
 by gateway13.init-ka.lan with ESMTP; 25 Mar 2026 19:08:13 +0100
X-AuditID: ac15641a-1db6d70000004999-8d-69c4248c7034
Received: from srvkamail01.init-ka.lan (srvkamail01.init-ka.lan [172.22.3.254])
 by srvnereus.init-ka.lan (Symantec Messaging Gateway) with SMTP id
 12.42.18841.C8424C96; Wed, 25 Mar 2026 19:08:12 +0100 (CET)
Received: from srvkamail01.init-ka.lan (172.22.3.254) by
 srvkamail01.init-ka.lan (172.22.3.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 19:08:12 +0100
Received: from srvkamail01.init-ka.lan ([::1]) by srvkamail01.init-ka.lan
 ([fe80::5268:42e0:6f9d:2b71%9]) with mapi id 15.02.2562.037; Wed, 25 Mar 2026
 19:08:12 +0100
From: Alexander Koch <akoch@initse.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: imx8mm_evk: Broken defconfig for SPI boot?
Thread-Topic: imx8mm_evk: Broken defconfig for SPI boot?
Thread-Index: AQHcvIJYjSCZrhKPPECB1z2jEarhRg==
Date: Wed, 25 Mar 2026 18:08:12 +0000
Message-ID: <98d645eb53a37bbc6b3519b4f16a25d38d20d6dc.camel@initse.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.58.3 
x-originating-ip: [85.115.11.137]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <A5EB9B307F14B6408A04B6EE1D6B09F7@init-ka.lan>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWyRoz5n26PypFMg1k/LC3e7u1kd2D0OHtn
 B2MAYxSXTUpqTmZZapG+XQJXxse9G9kK1nJVzOnpZmxg/MLexcjBISFgInF+bk0XIxeHkMAF
 RomfMyayQjgfGCXOvf/ABuGsYpS4uPEDYxcjJwebgLrEgpM7mUFsEQFDib+7d7OATBIWMJa4
 dqQQImwhse/YGqgSPYlD024wgdgsAqoSL1fNBIvzCrhLbP+4Fmwko4CsxIYN58HizALiEree
 zAerlxAQkFiyByIuISAq8fLxP1YQWxSovmnbDqi4osTPHa9ZIHr1JVY3HGCDsK0krryeAGVr
 Syxb+Bpqr6DEyZlPWCYwis5Csm4WkvZZSNpnIWmfhaR9ASPrKkbR4qKyvNSi1NJivcy8zBLd
 7ES9nMS8TYygWBFNkdrB+OhQs/4hRiYOxkOMEhzMSiK8FxcdyhTiTUmsrEotyo8vKs1JLT7E
 KM3BoiTO+6rPMENIID2xJDU7NbUgtQgmy8TBKdXAdGudy/rWI7uW3TKu1BSdbX2ociVfWtr1
 RsuQb7p769fs+PryYmnC7IUP3t23SPZ9dPXqPdY968+mrzhR4P5bj0OxtPvMnC83Yrol+Zn1
 94WFnzq93f3RZ/nCV+2R5pMKXPfu4HTzcLq0brtGsfEKxnUzbu8t9DfIvF+0eiGHqYv1gnP9
 ciKy18/k/tz7LzBZhkdh251plwvdne6vZ5vGdWdNrV+o04RVfkldNiyz01P7W2pfPus99vne
 VvGs3UcX7og/tXDX8aNulYXnFp+05FMMnVa8cO7iflWxiSsZa80vRx6Z+XTV+9jHp2aEqq46
 9mUa//wHzIp/1q3o4vYrk3iYNilgWQnzDo1tU6NuBmQpsRRnJBpqMRcVJwIAD2AktgQDAAA=
X-Mailman-Approved-At: Wed, 25 Mar 2026 19:21:12 +0100
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

Hi all,

I am currently porting a working i.MX8M Mini based board from U-Boot v2024.=
01 to
v2026.01 as I cannot seem to get HABv4 Secure Boot working with the old ver=
sion.

After rebasing our commits onto v2026.01 I ran into compilation errors so I
decided to take a step back and build the i.MX8MM EVK Defconfig as a starti=
ng
point for the port (our board is very similar to said EVK).

Taking the exact steps from 'doc/board/nxp/imx8mm_evk.rst'

    $ export CROSS_COMPILE=3Daarch64-linux-gnu-
    $ make imx8mm_evk_fspi_defconfig
    $ make

the build fails, complaining about a missing image for the FSPI config head=
er:

      COPY    spl/u-boot-spl.bin
      CFGS    spl/u-boot-spl.cfgout
      BINMAN  .binman_stamp
    Image 'image' is missing external blobs and is non-functional:
        fspi_conf_block
   =20
    /binman/section/fspi_conf_block (fspi_header.bin):
       Missing blob

    Image 'image' has faked external blobs and is non-functional:
        fspi_header.bin


Strangely, 'fspi_header.bin' is present (and non-empty) and if I repeat the
build it gets through without an error message.

Unfortunately the resulting 'flash.bin' does not boot.

So I'm wondering: did I do something wrong or is the EVK SPI defconfig brok=
en?


Best regards,

Alex
