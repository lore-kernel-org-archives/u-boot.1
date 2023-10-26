Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C662C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 11:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B19487AA3;
	Thu, 26 Oct 2023 13:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=bluechiptechnology.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bluechiptechnology.com header.i=@bluechiptechnology.com header.b="ZL5H3eEe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D59E87AEC; Thu, 26 Oct 2023 11:36:58 +0200 (CEST)
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01on062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe15::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FA1C874F8
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=bluechiptechnology.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=crichardson@bluechiptechnology.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5+1qO7GcBFSHicrncK6Z05igZM3pMKiJrA+Tv6d9c45WaWrSmMW1VktcB00e5w1AUNw9WAL8NHs+UOtxuuCvY26Q8IqKZCpDXiXlAi/AA5U26KjJdxwwqwUKkbov57/SfKsUg59wV5LempyLg04FQLMEWbdyf85NzV5/DSYdNBlOKhphKj5naBqtwhMyWhFHbxSfDBCc/UDO9/TvTOe7VMr0r0OBFEkQIvh3Jhju1kGP03KDYuck2dQ4UBvKWnVv3hhgNmWe7fLsYhfFP0uCQobYqgQKaoqIUi8lRPjhVvwMGq2WzkBknZ76kaZZROnRCEkH04u/crhvKN9lqExIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZfy+3vYh4fawcos+PMbDPPOyJ/Qpx9U0O5VwHfMHX0=;
 b=BDY775qEWEL01+15DxwVyXgHOkiqcH4jW7vdbvj6YQr7AgFWVo2Tbpta95P2+dJU8RulNfHCBjSAHvCUVqiQhd462L3X5Cud5GskYtdHDljinxHkaE1xj64ktpjAZ6DEa2+Awp+AV/cgifQsuhcqQrf/W1oD7yORJNOzHhDo9xOeRKEkEdP5p4CbKyNhfjV3qo2R9OM0M7WYs8gKuE7QH2aF3enBKbQjWs6Q1xMhINX/JKtw201tP1Ccul+MG2mPWb8NE46RKFRjBTZp5je1jeAWMCl5Z7f0t3UqiVblbThJcyzsbDYr1R4BmKwNAhbFoxteDvPll9dueW43nbDI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bluechiptechnology.com; dmarc=pass action=none
 header.from=bluechiptechnology.com; dkim=pass
 header.d=bluechiptechnology.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bluechiptechnology.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZfy+3vYh4fawcos+PMbDPPOyJ/Qpx9U0O5VwHfMHX0=;
 b=ZL5H3eEerYxYETrEzwYHddrqaRUu5yLRvft7/sLt+mewmRM49yfxL866Rayt790NjcUgh9BHrOJHddqXZ5Vb1HrCaEfntQ1RNbSOHcXZjvNvJbeVwdVMliNv5AWcYBm9hCo0/GHYfNYbhIbhnU9ZM5+9eUg/gyphpjW6MQY+OroHf8Dqjfkw25UY80D/SuKbXO+gTTLUeDH/Yn0ppgB8Hg3su5+c4RF9V5SFfgCSNk1aArzFStvJah1ayb3HgNccz6CgcTmaI1AzmtAG4rVUwRbx6zyAOwxmt8KVbJQncW90wRosrX+/+KVwXlUH4vtd2rFJfY6rIdT0P9KRRtExQg==
Received: from CWLP265MB3059.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:cb::6) by
 LO2P265MB5038.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:22d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.22; Thu, 26 Oct 2023 09:36:52 +0000
Received: from CWLP265MB3059.GBRP265.PROD.OUTLOOK.COM
 ([fe80::948c:ef46:4a38:52d5]) by CWLP265MB3059.GBRP265.PROD.OUTLOOK.COM
 ([fe80::948c:ef46:4a38:52d5%4]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 09:36:52 +0000
From: Chris Richardson <crichardson@bluechiptechnology.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Setting PMIC regulator voltage in U-Boot SPL, to specify DDR voltage
Thread-Topic: Setting PMIC regulator voltage in U-Boot SPL, to specify DDR
 voltage
Thread-Index: AQHaB+7D2bMGp89K60mWjPVr75G5Sg==
Date: Thu, 26 Oct 2023 09:36:52 +0000
Message-ID: <CWLP265MB30597747B64663614077F4A6C9DDA@CWLP265MB3059.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bluechiptechnology.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB3059:EE_|LO2P265MB5038:EE_
x-ms-office365-filtering-correlation-id: 4801431a-35ee-4541-0bb0-08dbd60715da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5pLZRAPijyeYsm7zRW9Pfy0e+6S9YYJhmrUroDI3O08Jdi4vQBUp4iMEHuLsdkof0NZrNIjxqDu15U//LjzslJbozQCk3j2ChIRq6rtkqPxPR3+m31qFeN8Pr2wr1DYluac5xYYK1HmemGxqqdbLiVJXr1Qb6L0pfQFlDPWDc58k4Z52qCkUIwwNWdTMlC+um/HnUrfibmTLMPv/HoFMDW+I7LHWkyclu9poWPdm+ki1ILaZpOz1FhDxPyZj52SK9FicVvCAIMA8yCgOjmjF9ne4PseCLyufwMnHlHvMJPILJrbwgyPJ+zJQWyBx6GCIzW2gCG7VPFeZNkRdAdV4VkXFbrsTm4TwG2pU4fnMUFBaaapZ0yWdpltnSIB4dSVhIwL2+QoHB93YgADGt0GkIuN4S9a8jZt8sTI4ioJP2wXZGpiVgTGalst6bPN1+7Z9WN2a2IipMMOCf7BEJz0Rk36x9YGklIhSLc26HLUFziB4O9fI1yJxXZE/p0dCmfybrfjYdIe7//zDNS7v0TX2S6umPxFEaZEfy8pbSaSFkdDM/rJM0PyGN2pzeX3+8DGMYcN0AqDTzv98lU4IrL6wv+AZhHZcVxEmZE/C4Uk3Sqnf4cLRVkZ/Aoos27pmXSIV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB3059.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39830400003)(366004)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66899024)(6916009)(26005)(9686003)(6506007)(7696005)(71200400001)(55236004)(83380400001)(41300700001)(5660300002)(52536014)(8676002)(8936002)(2906002)(478600001)(316002)(91956017)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(86362001)(33656002)(38100700002)(122000001)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EB4X5ReUBBL/DaEc9wWjRyCxmgmXUF73H7BrTHU/IKuW3LiSpSgbDP8oOI?=
 =?iso-8859-1?Q?yrdw+mHmkXrG0AaQzhuTF7YFl1DudayheLlAJ05sPhL8E9At0a64ZdXZvp?=
 =?iso-8859-1?Q?fOjRgV9l7Eut3dFvvVSOfzZLr3/ZkbHyJmnpZyfXnkSvv8q1ex/WPesHOh?=
 =?iso-8859-1?Q?jmKQCL2zk9UkGBIXvv6+ppLC2fGaZcpsHxxfAltvKvjLgnlpKcb0SVyZ8m?=
 =?iso-8859-1?Q?YPALMrfqjn745asFJ8c9aslylt53SWpgJjIFLi6XqnFpLbhSGRUos33rLr?=
 =?iso-8859-1?Q?EepDtnkAIMcloxW+B71mXLXWAky7hABcLWZ7Alie11w0zJeL1q9Iw2wA50?=
 =?iso-8859-1?Q?4+szkBM6/hbPFlzZbB6W1vonvMtzmmgl0VzW1R4CkiR8opyG5DOI7KmuCe?=
 =?iso-8859-1?Q?VCx7SALYn9+yGC2yTFvUZEYgIfY6vPPdzMiHO1l9/uBfGLCuInDHoTjn4j?=
 =?iso-8859-1?Q?6v6kIzxLLDXn3tOi3T//xThIa1VbgSqFPnvQ7arGTONqYPf6B79olytdA2?=
 =?iso-8859-1?Q?hVOV1y8K/C3Z2tscDJ4r2yCgjkU5kgcEbtpkB2D5B5RqH+ie48rU8GNYaJ?=
 =?iso-8859-1?Q?e4rtvVPBYiin9qyVLxeylQ5t6zOhIQhmuEjAIzkcJ2GsgokLOyA1S8QscD?=
 =?iso-8859-1?Q?hHol5G+l5xqFooQny3vODZ+nIKWBsgCV5Kbqu8ZtkW3nCN1i3KzGC9Dw5Q?=
 =?iso-8859-1?Q?xXCk+a/wN8wddf3jyee1tX7J7flvb7OuotSK87UMY64u2tAlFdHWfCckYl?=
 =?iso-8859-1?Q?9a4H9w+J9s+bUkLahj9lOOSqFLwsnnSSRZBouOm/iG6syqiMRdVLfTKRjF?=
 =?iso-8859-1?Q?OZJ7/lufNUtJgoZORSngikISnERn8wblBQu3VMHUWLsYKi39QhjSa67kAr?=
 =?iso-8859-1?Q?5EbgvTdZWPO/ezqPYdx5GCHh8bj3SYtV116p63jjJORzmPbRC+BbZN68/F?=
 =?iso-8859-1?Q?x14kCGOWxzM0V8ubwXxIus2LPRcZiysNcfpyt06H5fExZXCLE1YSe7V2Dk?=
 =?iso-8859-1?Q?eE3f5PP7v0DDJeq09/EF+olhXwdxj0Xwg/RvphpwnMFHg1WiP0n2348Lk3?=
 =?iso-8859-1?Q?3FNhCyaTgTZyVpHphmaTbUyPZZcUkLaLKkIUc1Cz6caT56rgWUI9ZXYo0m?=
 =?iso-8859-1?Q?c3QevWljC+JTnKy127dayVIXuZ86oTjLFeGqJAsQFZFm8Ku8KuIgeZzX0A?=
 =?iso-8859-1?Q?DSqteRV9AmoqWdkTgVVwDVXXnhGlQPNcp/SXOCPQTCGY0Ykl3F+wF7LFe3?=
 =?iso-8859-1?Q?9+l1dXWZEINFU4F5cF5A52i+93O4+K1nBtzCUnhEO5cnhana5xIHOI47RP?=
 =?iso-8859-1?Q?r3ocM/4jFOIisTtQQR96kMko+X4jeHZdctLopihaUMJYBYyHUgITE1Lv7n?=
 =?iso-8859-1?Q?aTvmNwoNJRgPJbgZYJ7Xz9yX8xMCPT7gHJh7h0EwR3ugylBM7RrC1pdAxM?=
 =?iso-8859-1?Q?dcxvygTtqqP2oD0E/0o341Guo5/Wtn+l91Yf7Win8YsW2VwIr2DPDJx+fu?=
 =?iso-8859-1?Q?9flMrgMZOah4s8SbSzrNdFApSy74vW2R4w24V9eXNAJ5jb3rGm+Ytpq/sP?=
 =?iso-8859-1?Q?ZLFOU4c7WMqQ2oCsu0BDqyujjXEQ9ElmTkobS6vC/MRFs7awp5BW8BD8Tb?=
 =?iso-8859-1?Q?hVNxKv1LZvVrKpJM/6AXohmH8B2aoIjvlcwszaXckleVTr/YcH5VNG9A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bluechiptechnology.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB3059.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4801431a-35ee-4541-0bb0-08dbd60715da
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 09:36:52.2638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04c569b6-0442-4190-8da5-3bf86e986b4d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YfgsX0Ef0cLcWPWFkeBDexzh+Ue9Asmx8bU9J9JQzJ2wXdedvVgGBwQj7lQTuTvx12w4g49bbAsufUdmNY4UnokJcaDDV8t/CfEKIUbulXZjs2QGOdLnzenwwaNuQ2BP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5038
X-Mailman-Approved-At: Thu, 26 Oct 2023 13:57:35 +0200
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

Hi,

I'm working on a board with an Allwinner H6 that uses
an AXP805 PMIC.

I'm using DDR3-1600, which requires 1.4V.  In my boot.cmd, I am doing the
following -

regulator dev dcdce
regulator value 1400000
regulator enable

To set the voltage to 1.4V in U-Boot proper, this avoids memory issues, suc=
h as random resets.

However what I would like to do is to set the regulator voltage in U-Boot S=
PL, so that
the voltage would be set ideally before memory size detection etc.

To do this I thought I needed to enable features such as 'CONFIG_SPL_DM'.
I've listed the main configuration I used below -

...
CONFIG_DM=3Dy
CONFIG_SPL=3Dy
CONFIG_SPL_DM=3Dy

CONFIG_MACH_SUN50I_H6=3Dy
CONFIG_SUNXI_DRAM_H6_DDR3_1333=3Dy
CONFIG_DRAM_CLK=3D648

CONFIG_SYS_I2C_MVTWSI=3Dy
CONFIG_SPL_I2C=3Dy
CONFIG_DM_I2C=3Dy
CONFIG_CMD_I2C=3Dy

CONFIG_POWER=3Dy
CONFIG_POWER_I2C=3Dy
CONFIG_PMIC_CHILDREN=3Dy
CONFIG_DM_PMIC=3Dy
CONFIG_SPL_DM_PMIC=3Dy
CONFIG_PMIC_AXP=3Dy
CONFIG_SPL_PMIC_AXP=3Dy
CONFIG_CMD_PMIC=3Dy
CONFIG_CMD_REGULATOR=3Dy
CONFIG_AXP_PMIC_BUS=3Dy

CONFIG_DM_REGULATOR=3Dy
CONFIG_SPL_DM_REGULATOR=3Dy
CONFIG_CMD_REGULATOR=3Dy
CONFIG_REGULATOR_AXP=3Dy
CONFIG_SPL_REGULATOR_AXP=3Dy
...

Currently I am overflowing SRAM -

aarch64-linux-gnu-ld.bfd: address 0x2a868 of u-boot-spl section `.text' is =
not within region `.sram'
aarch64-linux-gnu-ld.bfd: u-boot-spl section `.rodata' will not fit in regi=
on `.sram'
aarch64-linux-gnu-ld.bfd: address 0x2a868 of u-boot-spl section `.text' is =
not within region `.sram'
aarch64-linux-gnu-ld.bfd: address 0x2a868 of u-boot-spl section `.text' is =
not within region `.sram'
aarch64-linux-gnu-ld.bfd: region `.sram' overflowed by 22296 bytes

I'm just wondering if anyone has any suggestions?

Also I wasn't sure, if I can get the AXP PMIC supported in SPL, how I'd set=
 the voltage in U-Boot SPL?

Many thanks
Chris
Blue Chip Technology Ltd is a company registered in England and Wales. Regi=
stered number: 03110403 Registered office: Chowley Oak Lane, Chester, CH3 9=
EX.
