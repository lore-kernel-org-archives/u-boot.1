Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDBFD32D81
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 18:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B2F892CF;
	Tue, 12 Nov 2024 19:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=initse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=initse.com header.i=@initse.com header.b="gX4lgCQv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E950D89440; Tue, 12 Nov 2024 14:58:13 +0100 (CET)
Received: from mx0.init-ka.de (mx0.init-ka.de [85.115.11.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DABDB893C2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=initse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=akoch@initse.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=initse.com; i=@initse.com; q=dns/txt; s=mail;
 t=1731419892; x=1762955892;
 h=from:to:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=zJP+9T+mDILeHYHMTwTyS9FZK9INKzt1INwb0kZtGQs=;
 b=gX4lgCQvgia7bNago2x9Q7by0zxo8ChqzQxe/hr3u2TOFcng6ifZANh6
 V+RyeHBqB5DYBY5OlVWCz8tkRbnpFTVO4IlqQF95Hzwk+2Pzpnpzc09JG
 PPNw6wW+mKCjfCi6uc5LVKcGxnuXoTZpGrQFo2wx2W0CyQD74sZa0KARw Q=;
X-CSE-ConnectionGUID: JNm9cmnCQGeYlksmEE/BvQ==
X-CSE-MsgGUID: aaNG67RxRiqLYwWZezkMcQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2B7BQC2XTNn/xpkFaxagQkJgUqCHIEjggOXPJEXi2uBf?=
 =?us-ascii?q?g8BAQEBAQEBAQEIAUQEAQGPRCc2Bw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBA?=
 =?us-ascii?q?QUBAQEBAQEGBAGBIYU1RwyHbAEVaicEhXmxRYE0GgJlhHvZOIFtgUiBaoZiA?=
 =?us-ascii?q?YYhhQGBSUSBFYJyB4t2BIEQgTGCcYE2diVNSYd/kESIC4FNHANZIREBVRMXC?=
 =?us-ascii?q?wcFgXYDgXuBVoE5gVFDgRaBR0qFGoEFgkppSzoCDQI2giQkWYJPhRqEbYRmg?=
 =?us-ascii?q?iEdQAMLbT01FBsGomZsOIQAA7BslQ+EJAWhVDOEBJNlAxmSSJh3IqhXAgQCB?=
 =?us-ascii?q?AUCF4FuB4IHMxoIGxWDI1EXAo4HAYFWAQjHYoEzAgcLAQEDCYZIiQgBgRwBA?=
 =?us-ascii?q?Q?=
IronPort-Data: A9a23:bnZhe6yR6GcV2W+T/bd6t+eLxCrEfRIJ4+MujC+fZmUNrF6WrkUCn
 TMbUGCHOveDa2L3co91Ydmz/U4PucDUn9NrGwZurS00HyNBpOP7XtnIdU2Y0wF+jyHgoOCLy
 +1EN7Es+ehtFie0Si+Fa+Wn8D8lk/nVG9IQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn8gVaYDkpOs/jf8Uo25qyp0N8llgVWic5j7Qe2e0Y9Ucp3yZGZdxPQXoRSF+imc
 OfPpJnR1n/Z5RokFuS+mb/9dEAQKpaKVeRZoiMLM0QKqkEqSh0ais7XBtJFAatko2zhc+RK9
 Tl4ncfYpTHFn0H7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhljJBleAGEWxgp4KUNo8
 K0TLTYmVz+Otua127eWZ65GmP12eaEHPKtH0p1h5SrDE/ArW53eWOPL495EmTQ5wMRHG54yZ
 eJANmApNk2GOkUXfA1JYH49tL7Aan3Xej5fo1K9pKw2/3Peigd21dABNfKJIofTGpoJwS50o
 ErP9kLWXE4gJOae0B607U2ei/3MuCjCDdd6+LqQs6QCbEeo7nFWAhoRSXO/oOKlkQiyVtRPb
 UAZkhfCtoBrqxbtFIC7BkXg5iTa1vIBZ+dt/yQBwFnl4sLpD8yxWjBVJtKdQLTKbPMLeAE=
IronPort-HdrOrdr: A9a23:JUKHFKDX9yvvsC/lHelz55DYdb4zR+YMi2TDj3oBLSC86qSj5r
 2TdYcgpHjJYVEqKQ0dcLG7SdO9qBznhPxICOUqUotKPzOWx1dATrsSiLcKqgeIc0eSmtK1vp
 0AT0EKMqySMbEMt6bHCWeDferJSbK8m5xBC4/lvglQpEpRGsddBk9Ce3+m+gcdfng/OXMWLu
 vm2vZ6
X-Talos-CUID: 9a23:O2EPqW8tBAbJK/hzvhOVv2wyH5Eud3v29VjdEku7EmNEZfq/V2bFrQ==
X-Talos-MUID: 9a23:DH/hBQQhOde4y+fBRXTljRdNaphS856vEWQ8jqo0ttuHECdJbmI=
Received: from unknown (HELO srvnereus.init-ka.lan) ([172.21.100.26])
 by gateway13.init-ka.lan with ESMTP; 12 Nov 2024 14:42:32 +0100
X-AuditID: ac15641a-b19ff700000029e4-4b-67335b6458a4
Received: from srvkamail01.init-ka.lan (Unknown_Domain [172.22.3.254])
 by srvnereus.init-ka.lan (INIT-Mailsystem) with SMTP id AB.00.10724.46B53376;
 Tue, 12 Nov 2024 14:43:00 +0100 (CET)
Received: from srvkamail01.init-ka.lan (172.22.3.254) by
 srvkamail01.init-ka.lan (172.22.3.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Nov 2024 14:42:32 +0100
Received: from srvkamail01.init-ka.lan ([fe80::d3a9:1958:3669:69bf]) by
 srvkamail01.init-ka.lan ([fe80::d3a9:1958:3669:69bf%9]) with mapi id
 15.02.1544.011; Tue, 12 Nov 2024 14:42:32 +0100
From: Alexander Koch <akoch@initse.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Using secondary UART for board initialization
Thread-Topic: Using secondary UART for board initialization
Thread-Index: AQHbNQi5BSmqYxJZaUG6ehz3/p41qw==
Date: Tue, 12 Nov 2024 13:42:31 +0000
Message-ID: <7f6a7ced1e4b64c4f14bf35ca294ed5435776452.camel@initse.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.1 
x-originating-ip: [85.115.11.137]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <D6B5E43F4C6CDD48906701A890663A1B@init-ka.lan>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWyRoz5n25KtHG6waN/qhZv93ayOzB6nL2z
 gzGAMYrLJiU1J7MstUjfLoEr48eNR8wFRzgqdnXOZmlgvMPWxcjJISFgIrF79k7mLkYuDiGB
 PYwSK+5eZodwPjBKnFm9FqxKSOAAo8Svfh4Qm01AXWLBSZAOTg4RAUOJv7t3s3QxcnAIC5hJ
 7N2WDBG2lmjuusgIYetJfP89mwXEZhFQlXj8+QTYSF4Bd4m3eyeDxRkFZCU2bDgPNpJZQFzi
 1pP5TBDHCUgs2QMRlxAQlXj5+B8riC0KVN/y9DUrRFxR4ueO1ywQvfoSqxsOsEHYVhLTV/6B
 imtLLFv4mhlir6DEyZlPWCYwis5Csm4WkvZZSNpnIWmfhaR9ASPrKkbO4qKyvNSi1NLiTYyg
 mBBNkdrBeHuS5SFGAQ5GJR7egEDjdCHWxLLiytxDjBIczEoivKecgUK8KYmVValF+fFFpTmp
 xYcYpTlYlMR5X6vYBQgJpCeWpGanphakFsFkmTg4pRoYVX+6zn7DzKdacaH/CUfenH8Mm/Km
 3ji8gmXlhplHXiUG/Drn0fjQaGLeR5emBaYl2zkso4N/hz7ozKowmbvyhZWcYOv2zAlnlpWH
 nYh0eiJZuixGfd/BvzbvKy9V/Dq2p4O3ZW72jdNej/yD7ZRP//d8dvT5umVP4jcwFCedcm06
 vyawa2X8LSWW4oxEQy3mouJEAD4gLHqFAgAA
X-Mailman-Approved-At: Tue, 12 Nov 2024 19:41:23 +0100
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

I need to write to (and read from) a UART during board initialization that =
is
not the same UART the U-Boot serial console is running on.

I'm using CONFIG_DM_SERIAL so I've extended my .dts to enable the additiona=
l
UART (including pinmux registers). In my board init code I can find the ser=
ial
driver instance of this additional interface via `uclass_get_device_by_name=
()`
but now I'm stuck finding a way to actually do I/O with this device.

All `serial_putc()`-like functions that I could find are either static to t=
he
actual driver and thus not accessible from `board_init()` or do not accept =
a
`struct udevice *` as a parameter and seem to work on the main U-Boot seria=
l
console device only.

I could of course copy the functionality of the implementing driver but tha=
t
seems wrong to me, given we already have the concept of driver instances.

Could somebody give me a quick hint as to how this is supposed to be done?

The target is an i.MX8MM (thus serial_mxc), in case it matters.

Thanks in advance!


Best regards,

Alex
