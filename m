Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C83C87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58072832E6;
	Wed, 30 Jul 2025 07:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="BgXNLctf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A1FC83045; Tue, 29 Jul 2025 18:24:58 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB2DA82BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2XMgkOV3XFQaIdkOAUap4wBNkYWWqrBhsMZBMRowpc4PJaZAcZhBojEGVto+WtJSpwDZ9ulYtBxgR5ANvJF8UJ6RhVa0dwwNPS55RMsLA1UuUjGRJdTsReJvA6YAERrZI0ABnHRpRTm0mWSVhcRbmqAiLtkd7R7W9uM11izjQTz0Xs5D6gMvd4BTT+NXnXYdoRYHOh+ZmQeo+LxeIB+twbUQnxk+uwbRWf43N3L4SOzlhpjPJL3dGH1JiXYNyBroBh304Oev/jDpe26Yn1yiVruMTYZy15dpPKdyKqGS7wbpI9O8ghO1NBGm1wzcDmlCs6eS7jeUIgmF58QUBPmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ir2KQn4YI8f+MnA2RR+1kTRmzrCseUzAMUQeTYjyIwY=;
 b=G0Gq/wgfQXIyLjE4YZ6L53sKN7YdpjMzArkFTM7T0i3VYihKRAuLDHQHuuqxQLqpGkyoGbEy9ko8IPglweftDZikH68URAQ5iBpYOH8eNk0wE4Ckqi2h3hj0QELhcDEU3OGWFoXsoEx2D1nnJqCVe5FtFlyZVODyI3RDLrFpNPxQo33sHaaRPJpTmksdoJUpMJ/1dWLSvUeX3L6YZPHT0w4a6WxDeNSNMYx41F47eLNX6bNG+qGCY6DbtFc+Yzp7lduu79ZnOoE0lxWAX6hlp90yBtTQz/QVjFuFC9mwbkPBCGDXeyPrFyMQmgMJGmbIvifHUoh2hx6VzWQOPdLv8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ir2KQn4YI8f+MnA2RR+1kTRmzrCseUzAMUQeTYjyIwY=;
 b=BgXNLctftm6DAJoEjGmed3LpN1KcqmVbcn6eMU5boO2aE6aWG90oEEAOOmo59M4/TEANgdzg7UIym0MxCMO1h8vUh5FDMj+wRAO4PXHoZKaQSFt1HIe07wvuIflnQjzYmSHKNSqnwRkQ4pxNSigvNDXxQ58CceeJClkMObqlCTjc6pEIQwAveOLGXvS8qaQMbtG3/i6aHTEEbyaxFwsV6x3+uF/1Hw6pBH5u9vldmozERkt7tFbgepfZosILiODGoUUhn6zW6PpqngjJdgpXUvXl2Acyq8iVaAHRjgUw3vU/7EdF1EAaJFgfeFTbowb83NjHZHUn1pyPxg17ih6RBw==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by VI0PR09MB8338.eurprd09.prod.outlook.com (2603:10a6:800:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Tue, 29 Jul
 2025 16:24:54 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 16:24:54 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v3 10/12] riscv: boston: Add support for LED character display
 command
Thread-Topic: [PATCH v3 10/12] riscv: boston: Add support for LED character
 display command
Thread-Index: AQHcAKVRta1O4CXiWE2EGYefZZabeA==
Date: Tue, 29 Jul 2025 16:24:54 +0000
Message-ID: <20250729162035.209849-11-uros.stajic@htecgroup.com>
References: <20250729162035.209849-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250729162035.209849-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|VI0PR09MB8338:EE_
x-ms-office365-filtering-correlation-id: f8346b09-e59a-40fc-8a50-08ddcebc73af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Eh+EGA3rYSjsGzXfJiO3bAJZ+Bvwb8yHkO+TNV1W0H9wKWCDlmD3A8SEoB?=
 =?iso-8859-1?Q?N8tb+imuhhtXDCeqjgMH1Z4JBgT9aKQtwV0I0h5hKZ89TrHLi3qVhe9Hwi?=
 =?iso-8859-1?Q?b+mBpKP6e5uVJlX48UW9DwEODx/p8WJR5LNrsXfpJeMaQA3k5JxwDKQDkm?=
 =?iso-8859-1?Q?XHJRuSgWEOh2nnu42uX+pGaPmGnjudeKwg/n/g0YLb+GaHd/WyqlxwC8u/?=
 =?iso-8859-1?Q?ndtHeKhK5MBeyEue47eynmWz30aRBD7PKHGtciWtCEFddUTNgIGkZx3gGg?=
 =?iso-8859-1?Q?N3B+vFSdqwIEKGU+fjVf5HwBsG4XKqIL3+gdHRU5Pi68oRPyJEC823Vpoo?=
 =?iso-8859-1?Q?YKjzZ1EqVXe516uB2Ze5c4x6iLyyzsMFT4r7qMFtVyy7fLNILDAHad0Tu2?=
 =?iso-8859-1?Q?9kBhRUFekKso68F4Itj9EQ7+ukIb33Vl/UU5dnvoJ6frIKtYpk8scxVAma?=
 =?iso-8859-1?Q?sk9oV7Lt6ojE0VAe491AN482Rz9O2r9D3lzAvoRBfkWhIDH1Np8oOiZbFR?=
 =?iso-8859-1?Q?C9ltPQ6uTV0QZyzle/ce8hgwtc0JEE99XrSdNyz6uIhX1tKrslqagjWi4i?=
 =?iso-8859-1?Q?Ft3TDdMa704pVJjNG4BkF4wXOqmucbEpupJU+oClwD0DXRe/OmrMd4mrkI?=
 =?iso-8859-1?Q?iP/zzTgZ+hw0hLhreo9RMIfRCqHzbJuZhihr8qQw9QcOTIh9HYKpuqtorH?=
 =?iso-8859-1?Q?szXEMW9dxnpnQo3DfJe9q+ysaKo3plBt7ahMDKbNjtBgxGq5bO1iniuQH1?=
 =?iso-8859-1?Q?sDlLQ0mVvtP5by/p0bpKGnLImZEDwOEBxsRdRPYKHRCkEUYuiOAylS9SL/?=
 =?iso-8859-1?Q?GAZBCoW0WwEAHBrLtv0EKCYvJAB3BrSe8mDl78btpWFN46+HcXvnXFJEMk?=
 =?iso-8859-1?Q?SK3BcKdtURZPg/LEpBix9PHljsOGbUZ13LOHNFPWJF8e8Z79Ws9DvuObvi?=
 =?iso-8859-1?Q?sB6s/9jIlRzP5pgxh9c6ypuNmVbLDSUXPJ/Oa3xtW7To8MwmVBfP+AkLt/?=
 =?iso-8859-1?Q?myrXyHxQJWHYgw+MR2ldKZ0RjfOmZjOPNp8l8hg0wQSe3TuJIQh6M4lkke?=
 =?iso-8859-1?Q?CW+6QqvT3tuiPbIbwD0ck+hayDPRDQaE6BgDrsZpw/hjnoionSRvssqKXQ?=
 =?iso-8859-1?Q?6AAy168o65VK3NhQOE9Gk+MQ2636NhwwsFr7NhPisCyvbWwV8/g8etj0O7?=
 =?iso-8859-1?Q?kioMx4PE0b+3hh0cCH6XnOKS7BaNG/sEzBAWr6YEK/vU1XCyuYl/X0i/6n?=
 =?iso-8859-1?Q?ndl7pHxgHr1VFkyBidQQzDwjOnaCCh81xiYrzzYQIzNCuHWZShiHgk7o7q?=
 =?iso-8859-1?Q?irsax7cVmY/vgQ5ytHjOWWtvybxWhptLWjXEtp/OHcqqn1bs9RoTvTNh+g?=
 =?iso-8859-1?Q?FBSNfZZAJLT3mPKhtimqz5TKM/J7m7Q3o7xkC8E49WFGtQHwTplKDcjbS1?=
 =?iso-8859-1?Q?KGL9Ge14nfrcPAM1tzx6riS00xARmvmBxHSsY1NdnZbJRV/a5h//uBgvY4?=
 =?iso-8859-1?Q?SeuxvLdBKT7BrdHAO0xqUbGI7GExpDc7yz62DFl6cZxw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Aejhx8TtQzZif3XeMhxKmSHef5ZgiEOQEg8cM6i4fmnxKg2bzoCecxdTfj?=
 =?iso-8859-1?Q?0Jh5NVJjM93fOpEdtjmVcFvd/UnV2o5tU2cdqvOumFLj3yXplAWTq2conm?=
 =?iso-8859-1?Q?zBjLVs6nEduF6GYKs1bpDVFadp1nhozsp5KA6mPnY/cEEiGkS0X17nACVU?=
 =?iso-8859-1?Q?2P3WN6/1h16XX611MDlAa8UiDHhk40RpEUjn6/ZTe8fNG3CpKeY63Vfp8A?=
 =?iso-8859-1?Q?TRTg09OkNIsRiTo3KWF3lffmMGK9V1+rxES4+Jl5/NYsSXFee+6LQZXtd0?=
 =?iso-8859-1?Q?eAyEqIdad2qcVtueYtVprsT1pg3HMmnDTMPggwlgRSVdGGSNAzVFyzTgri?=
 =?iso-8859-1?Q?XDanLreYwQnkVFIiu4ySETwYKrmL+xqQz9chXWeqfcrKDkUdWzJgRWqXK3?=
 =?iso-8859-1?Q?I2cOeepugebou6tsMx2TcyNFyL+bQM47P32AAp6+dQGqYP+zBIasfH0D5a?=
 =?iso-8859-1?Q?mwcZc3hqopBHUHIrFjfBhVEDE/G/kfK8vWKcFdYeW4LOpVR1gYh0/5M9cx?=
 =?iso-8859-1?Q?MqJXvy2wU771LfymLWoNSYCVYTE7TN1UeJL5avyZGOLKOJ51/pX4qHyhzo?=
 =?iso-8859-1?Q?G9V4Z8zSpC9jcA/9ZzmqF+N7NNt3Ol/V5396+HGeZoJ+vWF5bFfSz0aUEu?=
 =?iso-8859-1?Q?UqPiTcCKn35xXwdXUgkHfuELNlJoQhfNPo95mFmXcXXO3IbDVg+fZb538O?=
 =?iso-8859-1?Q?Yv8BH8WBf6WHpmM2pVabG2NGcyblhVdtAQuRRGvMSxdC8zYneVQBs3W2lF?=
 =?iso-8859-1?Q?1CA0OlGpBcvMc0J5Z78Vddyxjsmij3uupTUyccpTxdmw3YiMcnMAPOkWhu?=
 =?iso-8859-1?Q?gprU8G9YHhfodsIh6fHmD0EPlX0Sy9Y435QPwAzDLYn4tQfjbRJSfH9yWR?=
 =?iso-8859-1?Q?CnKKihVjqahD6bKW7zVNvEgqxsxnuAA2ZiPvTmM4iFguQWdCekTzCrPPzE?=
 =?iso-8859-1?Q?/vnS9uXv8EJZVvDFPJyeuCFwQYDJ6DLfMNfB8OSAFGEuRrWmedc3LDfCmq?=
 =?iso-8859-1?Q?bZkGyq+KOrTo1T0C4kUja4TlrO/T8VvQWoXhFrGmAawXAsmDayx7ieOyUD?=
 =?iso-8859-1?Q?Bj7SzVr/SdaFvreOA7nP9ENfcl1M3DrhBapNbtTAIDw958378B5r3n6P2r?=
 =?iso-8859-1?Q?oXuJndn413uhIUL0VKwpPAjRUD+q0Qj8fKfpQ6rD42aPupeDjXm7QLARF7?=
 =?iso-8859-1?Q?0Et0+jBRkynO/xOoI/JRXiWcJrLKwmc6WlXK0lxykDvLSCf2WkMAD+YlwV?=
 =?iso-8859-1?Q?FkPtFm+IoYqxEt4YEfZ6QiKvBeEQkkOcJcoPVMcBoRkdrOWdiCj5CoM4j5?=
 =?iso-8859-1?Q?R7wJZhGRzVIcTCBv1F2s9bJZFc/2kAIExVvQNbENWxqr/qOoD9CWiXya9q?=
 =?iso-8859-1?Q?sxFBbd0s7DfeFdtznSrqBQnWIUpdNTrXDefipCoOMBnea1yOC9yHhCV/p6?=
 =?iso-8859-1?Q?hXizcu5IkPzC0WJQRJGWnF56XMHMyC7jOzf9xMDlwwuD8HDY75gYjbS5Cf?=
 =?iso-8859-1?Q?QHnW4VwFB3iPk20JwkUDXj5xpJhTgH7ZgrpyVeCdCS7RvCpV2Ip2XDuN8y?=
 =?iso-8859-1?Q?INU2kaR89V0T9t3GU8ZhMPJAeav2UJCtZMMkbaAj3kbLxoOQStjzHuTrgN?=
 =?iso-8859-1?Q?ikU6PIxIaWZ9NEQl39pANOZYacMlj3opxbD3LMZCfTUwX99nN+EyCBYw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8346b09-e59a-40fc-8a50-08ddcebc73af
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 16:24:54.6128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jIy9eTuPg/Djt8sWKxdVs7kSdFVhXEKjTr7R6CiSvpdPgrldlDQU2+u3Zy5PzTakID4DvwgytUQZOMuUU+1+Da9KskJ2YXjcvuSVdVw40tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB8338
X-Mailman-Approved-At: Wed, 30 Jul 2025 07:10:08 +0200
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

From: Chao-ying Fu <cfu@mips.com>

Add basic support for the 8-char LED display on P8700-based Boston
Board using display_set() and display_putc(), enabling the generic
'display' command with clear and home support.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 board/mips/boston-riscv/Kconfig         |  4 ++
 board/mips/boston-riscv/MAINTAINERS     |  3 ++
 board/mips/boston-riscv/Makefile        |  1 +
 board/mips/boston-riscv/display.c       | 33 ++++++++++++++++
 board/mips/boston-riscv/lowlevel_init.S |  2 +
 cmd/Kconfig                             |  8 ++++
 cmd/Makefile                            |  1 +
 cmd/display.c                           | 51 +++++++++++++++++++++++++
 doc/README.LED_display                  | 26 +++++++++++++
 include/led-display.h                   | 33 ++++++++++++++++
 10 files changed, 162 insertions(+)
 create mode 100644 board/mips/boston-riscv/display.c
 create mode 100644 cmd/display.c
 create mode 100644 doc/README.LED_display
 create mode 100644 include/led-display.h

diff --git a/board/mips/boston-riscv/Kconfig b/board/mips/boston-riscv/Kcon=
fig
index 4d55d96603e..5ab89cb5a69 100644
--- a/board/mips/boston-riscv/Kconfig
+++ b/board/mips/boston-riscv/Kconfig
@@ -44,4 +44,8 @@ config TFTP_FILE_NAME_MAX_LEN
     int "Maximum length of TFTP file name"
     default 256
=20
+config CMD_DISPLAY
+	bool "Enable display command"
+	default y
+
 endif
diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/=
MAINTAINERS
index 0d9a951441f..b04dcde943a 100644
--- a/board/mips/boston-riscv/MAINTAINERS
+++ b/board/mips/boston-riscv/MAINTAINERS
@@ -9,3 +9,6 @@ F:  configs/boston-p8700_defconfig
 F:  arch/riscv/dts/boston-p8700.dts
 F:  drivers/gpio/eg20t-gpio.c
 F:  arch/riscv/lib/mips_gic.c
+F:  cmd/display.c
+F:  include/led-display.h
+F:  doc/README.LED_display
diff --git a/board/mips/boston-riscv/Makefile b/board/mips/boston-riscv/Mak=
efile
index c67c001d4e6..2a180820a74 100644
--- a/board/mips/boston-riscv/Makefile
+++ b/board/mips/boston-riscv/Makefile
@@ -7,3 +7,4 @@ obj-y +=3D checkboard.o
 obj-y +=3D iocu.o
 obj-y +=3D lowlevel_init.o
 obj-y +=3D reset.o
+obj-y +=3D display.o
diff --git a/board/mips/boston-riscv/display.c b/board/mips/boston-riscv/di=
splay.c
new file mode 100644
index 00000000000..cd222cb6648
--- /dev/null
+++ b/board/mips/boston-riscv/display.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2017 Imagination Technologies
+ *
+ */
+#include <led-display.h>
+#include <asm/io.h>
+#include "boston-lcd.h"
+#include <string.h>
+
+static char buf[8];
+static int pos;
+
+void display_set(int cmd)
+{
+	if (cmd & DISPLAY_CLEAR)
+		memset(buf, ' ', sizeof(buf));
+
+	if (cmd & DISPLAY_HOME)
+		pos =3D 0;
+
+	lowlevel_display(buf);
+}
+
+int display_putc(char c)
+{
+	if (pos >=3D 8)
+		return -1;
+
+	buf[pos++] =3D c;
+	lowlevel_display(buf);
+	return c;
+}
diff --git a/board/mips/boston-riscv/lowlevel_init.S b/board/mips/boston-ri=
scv/lowlevel_init.S
index 8fa85749e40..f65021a0974 100644
--- a/board/mips/boston-riscv/lowlevel_init.S
+++ b/board/mips/boston-riscv/lowlevel_init.S
@@ -15,4 +15,6 @@ msg_ddr_ok:	.ascii "DDR OK  "
 	.globl lowlevel_display
 lowlevel_display:
 	li	t0, BOSTON_LCD_BASE
+	ld	t1, 0(a0)
+	sd	t1, 0(t0)
 	jr	ra
diff --git a/cmd/Kconfig b/cmd/Kconfig
index b3b5be1ea79..298a3ca6ce3 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2319,6 +2319,14 @@ config CMD_CLS
 	  Enable the 'cls' command which clears the screen contents
 	  on video frame buffer.
=20
+config CMD_DISPLAY
+	bool "Enable the 'display' command, for character displays"
+	help
+	  (this needs porting to driver model)
+	  This enables the 'display' command which allows a string to be
+	  displayed on a simple board-specific display. Implement
+	  display_putc() to use it.
+
 config CMD_EFIDEBUG
 	bool "efidebug - display/configure UEFI environment"
 	depends on EFI_LOADER
diff --git a/cmd/Makefile b/cmd/Makefile
index 12e948fd1b9..a313ddb1f29 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_CMD_SOUND) +=3D sound.o
 ifdef CONFIG_POST
 obj-$(CONFIG_CMD_DIAG) +=3D diag.o
 endif
+obj-$(CONFIG_CMD_DISPLAY) +=3D display.o
 obj-$(CONFIG_CMD_ADTIMG) +=3D adtimg.o
 obj-$(CONFIG_CMD_ABOOTIMG) +=3D abootimg.o
 obj-$(CONFIG_CMD_CYCLIC) +=3D cyclic.o
diff --git a/cmd/display.c b/cmd/display.c
new file mode 100644
index 00000000000..0602345e6c9
--- /dev/null
+++ b/cmd/display.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2005
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ */
+
+#include <command.h>
+#include <led-display.h>
+
+#undef DEBUG_DISP
+
+int do_display(struct cmd_tbl *cmdtp, int flag, int argc, char * const arg=
v[])
+{
+	int i;
+
+	/* Clear display */
+	display_set(DISPLAY_CLEAR | DISPLAY_HOME);
+
+	if (argc < 2)
+		return (0);
+
+	for (i =3D 1; i < argc; i++) {
+		char *p =3D argv[i];
+
+		if (i > 1) { /* Insert a space between strings */
+			display_putc(' ');
+		}
+
+		while ((*p)) {
+#ifdef DEBUG_DISP
+			putc(*p);
+#endif
+			display_putc(*p++);
+		}
+	}
+
+#ifdef DEBUG_DISP
+	putc('\n');
+#endif
+
+	return (0);
+}
+
+/***************************************************/
+
+U_BOOT_CMD(display,	CONFIG_SYS_MAXARGS,	1,	do_display,
+	   "display string on dot matrix display",
+	   "[<string>]\n"
+	   "    - with <string> argument: display <string> on dot matrix display\=
n"
+	   "    - without arguments: clear dot matrix display"
+);
diff --git a/doc/README.LED_display b/doc/README.LED_display
new file mode 100644
index 00000000000..19977ea7e0d
--- /dev/null
+++ b/doc/README.LED_display
@@ -0,0 +1,26 @@
+LED display internal API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This README describes the LED display API.
+
+The API is defined by the include file include/led-display.h
+
+The first step in to define CONFIG_CMD_DISPLAY in the board config file.
+Then you need to provide the following functions to access LED display:
+
+void display_set(int cmd);
+
+This function should control the state of the LED display. Argument is
+an ORed combination of the following values:
+ DISPLAY_CLEAR	-- clear the display
+ DISPLAY_HOME	-- set the position to the beginning of display
+
+int display_putc(char c);
+
+This function should display it's parameter on the LED display in the
+current position. Returns the displayed character on success or -1 in
+case of failure.
+
+With this functions defined 'display' command will display it's
+arguments on the LED display (or clear the display if called without
+arguments).
diff --git a/include/led-display.h b/include/led-display.h
new file mode 100644
index 00000000000..50830903b0d
--- /dev/null
+++ b/include/led-display.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2005-2010
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ *
+ * (C) Copyright 2010
+ * Sergei Poselenov, Emcraft Systems, sposelenov@emcraft.com.
+ */
+
+#ifndef _led_display_h_
+#define _led_display_h_
+
+/* Display Commands */
+#define DISPLAY_CLEAR	0x1 /* Clear the display */
+#define DISPLAY_HOME	0x2 /* Set cursor at home position */
+#define DISPLAY_LINE2	0x4 /* Move to line 2 */
+
+void display_set(int cmd);
+int display_putc(char c);
+
+static inline void display_puts(const char *str)
+{
+	while (str[0])
+		display_putc(*str++);
+}
+
+static inline void display_sets(const char *str)
+{
+	display_set(DISPLAY_CLEAR | DISPLAY_HOME);
+	display_puts(str);
+}
+
+#endif
--=20
2.34.1
