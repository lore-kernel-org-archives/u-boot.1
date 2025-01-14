Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCC6E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 05:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D03D38070F;
	Tue, 14 Jan 2025 06:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="YSVAiHX/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33C5A8061B; Tue, 14 Jan 2025 04:54:04 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A14E805DA
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 04:54:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thFB4/xm7dUe/M2XNTq0SLcTerDpzAd+WaXJ6FyCDHze7tho3b/O+KDGBU+j2WIRmFvnHaHlc8n6qFi8RgYVEUadv+HStrcVwFDLGwSU/xUb4/nURi1q0lgy1DDJI5C9sI+XwIOBoeZtQ7ISdiHreLepDuzK7lSweAu88y58IjdYIYQu060NURwNHqgvH8/3a7f9+L9rQX/G8DAkiCuaU16ArUcRqusFKka+7pRTf1K+k0dzUxnXnAfVZ/0zbLEvVP3XTPkikaaN7yQCou0SkCWgTggEuieCHRMMLUAoFmR5cx0U2Uk4z9u3PRUwlgjm3eDAcrlqRSO6MY02QgBR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYFnZqGdm254lsutmq/VvznKDHfhU0YU0Yt6l12JMeE=;
 b=wTVh9XwH/HOAMf+jm22fCjyFamV9by+6cpC4wC+v2zjJhI36aHQVvnCO+N0MPvyUJdkd7pR+FSPIOS/I93fElU4oMtdPv41UEYDVrA2P3xUI0tIs4J0vH8LTPONRbMeK6KrodLsaHhkq9VAkxSBVwrFAJCMT/m7ikXm0VUklyuOJgKYpbpuzf6oA9v5LjfWoXvYaMQsqRK82O72lcOctFe80dMvd3G+CiP5V2NPW6MIVF9v2qmkWIQ/ul0uTcOoR9DCKLxGINiYpwvhyjkVzRAPSLPYlkZQuFhrGaKTLv4IDjxB7KZBrI4UM6pa/gcFgEK8uJraikWvteVbn1/5Ppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYFnZqGdm254lsutmq/VvznKDHfhU0YU0Yt6l12JMeE=;
 b=YSVAiHX/aG2XIYXZKEJ6WZ4VqJByQiU3hL2CJltF4vTAPyPUK9Ow9Oe9wVb192l2YXyAZhM8ZZZsHsP0NvZ/qIE6kR4AYIIWJLQam9YB3TOmA5+JkCfTOy8XZSbSA0SnAdo9zUReoJWV0PfpzXVNX5CseDkvFnxTFCE5c0dgIuPr0utYe7G74goklRij9WgfW0M37BQf5eyqnqyNcoBinJB7hCfYlSR9yaYzkqGozueM79YnRk6isZdVubQriWeKmVyfAVkU5atiXrTPd8Uxsn7YL4uerk30s3w3UsnoM+7AXZcRRi8M1sbCl24G/Ru+YTnjhr14GyK58VAWztCBuw==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by BN8PR03MB5106.namprd03.prod.outlook.com (2603:10b6:408:df::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 03:53:56 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 03:53:55 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "muhammad.hazim.izzat.zamri@intel.com"
 <muhammad.hazim.izzat.zamri@intel.com>, Tien Fong <tien.fong.chee@intel.com>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, Tom Rini
 <trini@konsulko.com>, Tingting Meng <tingting.meng@intel.com>, "Meng,
 Tingting" <tingting.meng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v2 1/1] arm: socfpga:agilex5: Fix system manager watchdog
 mode setting
Thread-Topic: [PATCH v2 1/1] arm: socfpga:agilex5: Fix system manager watchdog
 mode setting
Thread-Index: AQHbZWAcSiyfaG+ddUGv4kFigXBYALMVpOFA
Date: Tue, 14 Jan 2025 03:53:55 +0000
Message-ID: <SN6PR03MB3583F8A23A2C8459BF33065FA7182@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250113020807.32728-1-muhammad.hazim.izzat.zamri@intel.com>
 <20250113020807.32728-2-muhammad.hazim.izzat.zamri@intel.com>
In-Reply-To: <20250113020807.32728-2-muhammad.hazim.izzat.zamri@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|BN8PR03MB5106:EE_
x-ms-office365-filtering-correlation-id: 9d39bf75-82f4-451a-9366-08dd344f1191
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?p5oQA1+5nVz0A37HGH/XRpZfwmJ68K8vpRMmpSbzANiDYDCQpLiP39+ARa+1?=
 =?us-ascii?Q?Om06Ypf+6PJd5zydHNqeHlR3jaa9XaNVnSDQt4F4ftav897eesIwFLFqjXE6?=
 =?us-ascii?Q?YUJm1UlfQS11uaDiRB9G/FDSSvE8xDg0cAiDUmKtqRMZyYcqey1YJKH2tlEf?=
 =?us-ascii?Q?ucr5JtMC0ffG2hHSvCLBeBCdoa56eMW0GM8SkmjyAoAOmn58y+4+bpRr2XZy?=
 =?us-ascii?Q?Pm6WwRtscYYiIseBwjNeqsZaZ/3WR0KEplmyM2nsuJSTxSxm6vWmeEtiFkGA?=
 =?us-ascii?Q?/IlvCpGUw+p/WfdFeNNdSvYOy/PVKijmQxmVk6KNyrwPsFjV4gcNpcIP250q?=
 =?us-ascii?Q?R1dmHNR2LOUzaA7vYAICmvshQs1w2JS9In4JEaFAiOx6/kv5vSpnvCxHZyHM?=
 =?us-ascii?Q?an3mUAEoZzgQLr44XCCQf8xsH+Jm5bSmv7IiTq/+kU440vHzEOa5Nfftk09s?=
 =?us-ascii?Q?SpE+831419923HyP5AwBetrAaGjeB2u/ZfMenlu5NaRnBlmO78T+/NqHtClu?=
 =?us-ascii?Q?GkN6dWoTwWwMFt00EZSDR1sEV21aJ6U2SyZSD7QxxiTcZVKZ86ZcVTBX3vWH?=
 =?us-ascii?Q?RHthtvtmWCU1U3l1U2AZZFoXeMf/vIHfOcIEr1LE5giWBR91+flYhzX88F+J?=
 =?us-ascii?Q?j0TFZiczDmZWN8HHeC6r7wILFzMHLUjIO60H5klRZVIlEeZTluqq+DJpax1O?=
 =?us-ascii?Q?nIPNqjahyF9nnsTKhJGxetZUqqWhaEdqVrH56jTLdSRgo7Fey1iJPONh+9P6?=
 =?us-ascii?Q?4xvhx+WkOUHcRURRXMcPd2pIzmZaLqiYVqQOqju79+7otaRzwngF3HONtGqQ?=
 =?us-ascii?Q?xy6cEuOaxiu8sdRfr558zKIUtTo+PCRVc/Zgfq83tnF7KyZAxpNfNjiQC0Bx?=
 =?us-ascii?Q?aVno0voEO+Q3XWLnAFJn0+qrMgNZB2aviGVpKKSJc8gmM9D6nMnt/AeYhHtb?=
 =?us-ascii?Q?oAL4qr8t/CH38AsFENEjHVPNF1Rkm5TIEIUA7zUOB2sgiTMd4SoDkPwFWFVg?=
 =?us-ascii?Q?0MVqP/l9xtpmA/4U/ic7gX3zVEMHDm/r9HEYZ+XEeCZgcCaaWrNuhlYHjORB?=
 =?us-ascii?Q?C2xszMeEguFDAJ1khq1JlQ1rKEJjEXodkFf5eXrZGRefo+O/XlvzLE832AhG?=
 =?us-ascii?Q?dfRRdQvJLFd6y3BVMD9D8yXs6i+QLJAGnVOTU5cdqx8/CvwTpmHBUA33RDGv?=
 =?us-ascii?Q?NbN+qul3/0+tjmZZKDUtybuYA9jwWXlpSucLSKj4MTmD0zn9BXe3hAqe9ues?=
 =?us-ascii?Q?GUhD81Wg3tlnRU/NwRKfdzMDmZjOi7yp/2caswXlRUfx+N7aK42YC7Z9Vdza?=
 =?us-ascii?Q?8KMb2O/tkeJsq3nrY+B43V36B+dAKcXwS8pvOTirB9u97g6tHwNOZ0VIuFnz?=
 =?us-ascii?Q?lAt667eCx+ffLkRGty/6Rk/NWhHQCWt12m5fREZlX6YcYikiRO+j3sTCjP5V?=
 =?us-ascii?Q?rPCBJXZ4zmat/htCUENHzMVeHeqW6Cps?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jqa0oSEiHmM3famfIfe5ZCUYJyANGon7iJA8Mc64n3QCp+9np37jub0DRi/N?=
 =?us-ascii?Q?NXS+BaPU0XK+OpCt+E++TbT6mNK28xXf0oaQthpWF5+B2AyR5uSSfkdnErXc?=
 =?us-ascii?Q?m58/Tlbqkj16iFQIfAOfnONtwX+BtWKg4xH9AUTef3HLvQqCxavzlaJUM/0y?=
 =?us-ascii?Q?gCKqmt4DwmBW7a38doDDe4VB0A99bcuF7hQEaGB0vlzwhwYp1Kd4SDeyFLa7?=
 =?us-ascii?Q?O/E44pXRJdnPjUIswwJ03EAIooWACPU57j87i0NF3LZXEWISWlNrNI0YBtXO?=
 =?us-ascii?Q?lVVJsspLLKXgZUMjvqUHPBtXBnrO7md1xje3tQSckfVnE8QkGwGoBD4qww82?=
 =?us-ascii?Q?7eKQtw1BsBqauKgrE1kd71ksn6I1NqObSvHdMezpDB3cobkgcKyraKNVkz2F?=
 =?us-ascii?Q?rRvqZFGdVavrCDxnu1kX9FZmzf0jCJdoLTn4rfukz1c5bEHTrKqESs6iDzV/?=
 =?us-ascii?Q?Hl+dMmE0M7AbZdQuh4RrmD0aGLHtqz8l4C4fYusXAdJ8mG5JpiBvzea2+jni?=
 =?us-ascii?Q?51qLYwpc0Rqh8GM7jeaqGlie5cQCDftEG++wcXx/pq59qUV+Dye/RciKi0t3?=
 =?us-ascii?Q?hl2P8OSLn+MUG7LGhNUEadZOGKHLDVa+D06k9CvkecMaXmMnvcXpMnNsVcxx?=
 =?us-ascii?Q?Y4ODUFUqe3/GHGipLuGr/tFn/441Su5GrkBy0AV2m9dFqTwOZKOBpaxmmHJv?=
 =?us-ascii?Q?io13RTy3U3jbAyt7Gnu6NWvTJ3Hd/H0Qa4XOcQIYf0zE+sJkIlig12PY5nBn?=
 =?us-ascii?Q?EtRWzVEHZOpAe2PagY/nSkqpWTxwJr+shWbI3/vGt1uPfVJcWjtP2ThRWYCQ?=
 =?us-ascii?Q?8EwYmC3zstkKVQgQwqMyow/umCbdPV5ADIXrmjSN0VVKEk7qTH7chUE3AYLk?=
 =?us-ascii?Q?n+XcJuqaG9D3KbCMZS+sfGF9lDMp3/NnyUzj8Iv6Yg8cfqnimmBiAaUkyN4q?=
 =?us-ascii?Q?JjzrvINyOElKCoYQgcoPGk7BwoltS14FI0fUKrp6imfQb5XJFPeCSD72NfN1?=
 =?us-ascii?Q?lzgFhgGWX+m3myxwxE1Oa7UFt3/VDjgNENZ0mGMD9d0dPyC89YYaEhlq34F0?=
 =?us-ascii?Q?Y9nNYVWq9vG4udTSb6b3gOKs2gH/yK1YlaT0wG+YzS6DCJz5r8sagF54Dvg3?=
 =?us-ascii?Q?5EcPrSmn2XgjGyRXgkkdFLC9P5n/LIMr/cP3mx9PR0c9MrJGCU4FyZsmEU6X?=
 =?us-ascii?Q?uxWdzg2FeeaKsIPhDRgTZ3efuGHfbDgfCMT0NSNlrNq6QIafivvboB9hFi0H?=
 =?us-ascii?Q?/gC55dSm5VZi5zVIpQo8FB7W4YYy9a2lbnoIL87UpiK9BMxk3XGmEOE9NI8Q?=
 =?us-ascii?Q?7KPD9nQuQxZMQnF1IJ7UfQHg669Dj6Gx9uKv41ELBSyWZ469hrdj9feTvj66?=
 =?us-ascii?Q?Q2AjZZWhbj8C7PPhwE/rni0qadT6WwfCDvJgfdYVjrdNy+d8mnjh4kHGzQdV?=
 =?us-ascii?Q?Gd8SNKTB4uhGVBDMEZJuXuqbT8OZ0NUcL2o6PEzkDC/+Bqmwl/+TBSHB8a8D?=
 =?us-ascii?Q?OWzcLJ+hn7dwfWyK4Iyx6WeChXWq5+3/3xGhcfI8jueFlSlsNWjaQXp/yXUZ?=
 =?us-ascii?Q?9XnXPG2rT7mk5ZdyLc2Z81Bq7CM9QCv41ima1nXo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d39bf75-82f4-451a-9366-08dd344f1191
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 03:53:55.7742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jp89Uws5jn9QDav3JSL3kdBbt9ma1N177gCMpWCK6vCah4WQ/rKDhYuWTYNUYfGbMBiB5FD36d6blrZ/fM4OiJ1DkGpZ5Q+ra1N/1OLFm1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5106
X-Mailman-Approved-At: Tue, 14 Jan 2025 06:36:13 +0100
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



> -----Original Message-----
> From: muhammad.hazim.izzat.zamri@intel.com
> <muhammad.hazim.izzat.zamri@intel.com>
> Sent: Monday, January 13, 2025 10:08 AM
> To: Tien Fong <tien.fong.chee@intel.com>
> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> Tom Rini <trini@konsulko.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tingting Meng <tingting.meng@intel.com>;
> Meng, Tingting <tingting.meng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@altera.com>; u-boot@lists.denx.de;
> Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@intel.com>
> Subject: [PATCH v2 1/1] arm: socfpga:agilex5: Fix system manager watchdog
> mode setting
>=20
> [Some people who received this message don't often get email from
> muhammad.hazim.izzat.zamri@intel.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> From: Muhammad Hazim Izzat Zamri
> <muhammad.hazim.izzat.zamri@intel.com>
>=20
> This commit is to fix the system manager watchdog mode setting to support
> until mode_4 for Agilex5. This changes can refer to system manager regist=
er
> map on wddbg fields.
>=20
> In Agilex7 it is not detected as an issue because Agilex7 only have 4 wat=
chdog
> until mode_3 and it is already been set correctly for it to halt on any C=
PU in
> debug mode. However, in Agilex5 this fix is needed in order to enable the
> watchdog pause feature for mode_4 when entering debug mode. If 0xF is
> not been set on mode_4, the Watchdog Timers will not halt on any CPU. As
> by default value, the pause signal does not assert when any CPU is in deb=
ug
> mode and the watchdog continue to count.
>=20
> Signed-off-by: Muhammad Hazim Izzat Zamri
> <muhammad.hazim.izzat.zamri@intel.com>
> ---
>  arch/arm/mach-socfpga/include/mach/system_manager_soc64.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> index b1ef4a70641..670aa3cc07e 100644
> --- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> +++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> @@ -182,7 +182,7 @@ void populate_sysmgr_pinmux(void);
>=20
>  #define SYSMGR_DMAPERIPH_ALL_NS                0xFFFFFFFF
>=20
> -#define SYSMGR_WDDBG_PAUSE_ALL_CPU     0x0F0F0F0F
> +#define SYSMGR_WDDBG_PAUSE_ALL_CPU     0xFF0F0F0F
>=20
>  #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
>  #define        SYSMGR_SOC64_DDR_MODE_MSK       BIT(0)
> --
> 2.26.2

Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>

Regards,
Tien Fong

