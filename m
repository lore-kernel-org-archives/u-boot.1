Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D2DCCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 07:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F4D282C84;
	Mon, 20 Oct 2025 09:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UwYhXIkZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3C1182C84; Mon, 20 Oct 2025 09:00:20 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4665807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 09:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZCfha19aBYTVovDJ3C6GDsqg0P+QuXZShKfvT+/SfDlCbKbwIz6+VUj7Z6iV3EZ4ZFoP8FDuWs/Gg6WqBWZKLYSsy6rCvlfjnUsa/8akPmaDawWoiWP6gS9jBUAafk4mkN4iRhGSuYX8TXnP4TkQocGw4n/+GjuE+kT74bUfIyHVLGYdxUI1eKkzBQqrMKf8gE3Ur3hCg1DoWz4b7CBXfT/puMl/bI9MrTETXA5Zowo7C9KJ0vHnAIPkjac8mgcDYC+2V1hxpcwfC4b9g/8WHhqFc/STB6zn9/QSNxfDhJTfhNxyv1yAdOVHUnY350NJjyY7vbB0qPd4crSCdo1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25VO/yogCqdLqX5DljBGyyvHr6luGB1pV5gwhLGEXEA=;
 b=zKtMiLGw3bd+HA5AsnY+h9ihQYlaXwU4f5F5Yj1/T/vKGmw1Lm5p2Vnju5ihlquAJX5tbODH3uzPDADb3vL+6tvFZk+S61V52UmubEnmqVzJmB2L/F0FU9WwnxZ66l1ctH9ALhe3NGXRG6S3GNp18evz5kgk8djb2oJV6Xvyv1Enb0GKbhtQ9InUXpSV6dQY0hBlIXvN6w+OlsB5DCAwPIo0cwiMgavbgHFOeNkaGFYzWfjkS+N7f8w4O6e7ii6GIIA4KTWxkoW1+hcKiuv9tsZG7U7ulRqpyuElPKezZ4q1vheZSGmcM9ipjApXEtHMgaL/diTp2G+estPeOS3OYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25VO/yogCqdLqX5DljBGyyvHr6luGB1pV5gwhLGEXEA=;
 b=UwYhXIkZT9JyAMfe8njqgPnGzjMoYhbRjuXh0gxp6Gq3UcMk62bVU1gTvzRKOKRBInZrkZyh1diiHp0jh2uoDDTJJ4gA3r/VC+nJN58uDcK3fGSKFQ3hUobczC50PFDYRk8OMGoBcT4ZrWDAfaBDTatvshtQK3EfNnVQGrZ8U8DhMyPCavkwKOPPZlrDunJMEFaq0exvuMUjCHRyhVygSMoO4nOV+JdzBzu1wVColNMEIyzkpJg028jqZ3M5eZJju9D08shLfNnpd6/IfTCnbfj8niJkTS0a2vCVS6mrSmgy6taxvgedq/DHBoBfd++S/ZlLibarzeFdPAXR5Z5gUw==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7549.eurprd04.prod.outlook.com (2603:10a6:102:e0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 07:00:16 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 07:00:15 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, Bough Chen <haibo.chen@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, dl-uboot-imx
 <uboot-imx@nxp.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "sbabic@nabladev.com" <sbabic@nabladev.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, Jacky Bai
 <ping.bai@nxp.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "mkorpershoek@kernel.org" <mkorpershoek@kernel.org>,
 "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgMS80XSBzcGk6IG54cF94c3BpOiBBZGQgbmV3?=
 =?utf-8?Q?_driver_for_NXP_XSPI_controller?=
Thread-Topic: [PATCH v1 1/4] spi: nxp_xspi: Add new driver for NXP XSPI
 controller
Thread-Index: AQHcQY8v536+T4nTh0qqy6bwI/WZwg==
Date: Mon, 20 Oct 2025 07:00:15 +0000
Message-ID: <PAXPR04MB9644EA959279B32DB302F6CBE2F5A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251014111756.446456-1-alice.guo@oss.nxp.com>
 <20251014111756.446456-2-alice.guo@oss.nxp.com>
 <CAOMZO5B0VWBwcpxRCF+iCN9jJw+0uWN_pJjyNha_B1Yz6e9h2A@mail.gmail.com>
In-Reply-To: <CAOMZO5B0VWBwcpxRCF+iCN9jJw+0uWN_pJjyNha_B1Yz6e9h2A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|PA4PR04MB7549:EE_
x-ms-office365-filtering-correlation-id: 8e611151-8055-426b-3967-08de0fa65294
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?NFRjZVJlNXNzd3B3RnliQldtMXNpdDNuQTNXM1BvNXV6WVBQc1QxNVpPRUxx?=
 =?utf-8?B?c3ZqZkRXbXFjanNlRzNYODVianJRajZRbWdZNXYxaFdQTDVQTmt0cXJPWW92?=
 =?utf-8?B?NzhuZk5YcUdNSzU0WnlTeHFGTEVaSDNvMXBqOEdWbjdzdWo2c09Wd0hheVRE?=
 =?utf-8?B?VTBJczhrSTJhUUhUUGk0alZxRTlpdDNPZzUzUC9MMWtBMTBpa3krV0lyWWxr?=
 =?utf-8?B?cTNZNTgwMVlzT3c1dDRPblhDMGExeldabnRwbFAvd3QrdW5SaC9YRWxXcnZw?=
 =?utf-8?B?QzlRMHN0VkVmZlVaSlVuSjNKNlhUNXZKbFhXZEJxR2lSZmRuNnFZVTlmYjlM?=
 =?utf-8?B?ckJFNVFYQTF1ZlhrZnlSUzlGWWJVbkRWM3lhTXRYc0x1ZzRUK29OSTU5TFRs?=
 =?utf-8?B?Z0Q2eDk3Z2tOSDVPVkdPWGdmdDExeUFDUnowRWljL3JGNm1sYTZMYTJmdTJL?=
 =?utf-8?B?YUhxRFljZm1mMWhTU21KcktUSm9OdTRZU25QVUxmWi9zb1FjU1VYVlpwUHJl?=
 =?utf-8?B?TkttYS8yQVlHcDErOGpZd2phQmFkZGVFSXh6ZmxlRWlEL1RxQmZ6ZkpqbC9q?=
 =?utf-8?B?bkdNRi9tdDdDSGkzeFBwSjNnWUNHaTE0TnBJdHV3NmQrRFg4cDZ6SzZpU3J0?=
 =?utf-8?B?Rjh0RHgxbnFySjVqamg0MFk5ekE4N2VhODBNVlV0K3JBVk0wS2R3emhINmlG?=
 =?utf-8?B?dVE0TlBtTDArOW0xQnVPRHdDaXdYaS8zVVk3YkRYZyt4bTFmVWl4SjAvL3Jj?=
 =?utf-8?B?WmNFQlZ2NkI5eXFyVTcyWCt3S0tYNDI4cnV1OC9JWVZmY3RWMzJzUHZhKzB0?=
 =?utf-8?B?bnNVcU1OUFN6WHVjdVVtdmlBaXdvU1RjTjRUZmRNdFlDNTloZzRDSjdXd3d3?=
 =?utf-8?B?ZXkzZk9KekZzbEs1L290QzFkbzBiRWFCVnRkYmJDbFVsRnBvejJGeXJzTnpy?=
 =?utf-8?B?Y04zRk5IdHBlTzJqWDZYZW5jb3EzVG5YeFVSLzFCakdZa08zSDFBckZhNWMx?=
 =?utf-8?B?dEw4WjZLWjRHL05La2hhdHRLZ2F5WE8wazFiV2VCT0wyMW1iSVg1ODJUdklI?=
 =?utf-8?B?RjB6NEhxTDM4VEJ5b1NqdlZhNmpScTJhSXVmU0ZQRFRJZFZWS0hwNDZPd0Vz?=
 =?utf-8?B?Q05uWUc1SVhRNkNKc3g2TUJrK1V4Yk1rWGNlcktiaHp0aCtHS2g1elNvN3l6?=
 =?utf-8?B?S09xK1hoNWsxcnYydktydnJDZk15aDY3TTlFS0U3RjFSMFM1Ujc3MnVJY1pk?=
 =?utf-8?B?eUExM1Q0ZXltMk9WUm9UZ0EyVVJyZHBzcXlDb0NkWUVNZm9LRTVhVGk1eXVX?=
 =?utf-8?B?eEF2T1JvV2F5bU84UXRSbzE3M1Q0SGlwR2dBNmFOTjZmYVl4UHYxT0xBc2Zy?=
 =?utf-8?B?MlhPalpGLzNHemE1anlaVGhUYTBHYW9BdDFSRUtSWXF4ODRJZjQ0K0ZZd3V2?=
 =?utf-8?B?V3Y4Y2VBQTcrR2syUUtwWVJTWHNscTI4aWFPNStoMnd1QUNDZU9MSFNMaW9y?=
 =?utf-8?B?b2JhcjlPdm5uYVBCWU05NndLWXJVaHRCOEFmNlFCeGluVk5sS2FZcFRpUDM3?=
 =?utf-8?B?WVRHUjRITi90RUo3THQxNTFMTFN1RkIzRUpocHRCUHBqYkJGOEdZZC9BUEFj?=
 =?utf-8?B?OUx3Wnl2cHpnd1dEVTdIQ2xzUkRuNFB4WVZ3ZEtRMnZNcmpybW94K0NLOWNK?=
 =?utf-8?B?MkQzb0ZlRFV5Tm8yd1hQYm9jb3FGSU9tRGtCMzYvdWc4Qzgvb1lZUmtPMCtV?=
 =?utf-8?B?STQzZ2QxYXJLckhKdU1xaDhyUk9LU3h0UCtXUUhmT2hDbEtVWlZGUHNuc0dl?=
 =?utf-8?B?aUhIQU15TVh2SHI1VlNZR0NvMm9BdmhiV0JvQjcrbVJPWG10cFR6ZkNYRjlZ?=
 =?utf-8?B?cVVxZ3o4cG41UHpzUGtvWHd0V1dDVWhxbGorVzN2S0FqTWhiczlYamRZdW5J?=
 =?utf-8?B?bk5mN3UvRHhjaUJVR0ZZcnRidFB5Z25VaWxlRE96YStPdEt6c2VUemczbU5k?=
 =?utf-8?B?bi9YS09hVFNxVHpvcXhvUkJyWml5SW9JQ0Z0VjUvZWZZZjJyQmJWVE15aFdY?=
 =?utf-8?Q?iPTKMG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3U1RjU3ajVZZWQ3M1FTLy90SVhsT2prWXdaQWgvZlZsVHg2ZC9JK0IwTHhV?=
 =?utf-8?B?akVVMy8yd1JCdGZ5d2Q2Y2crM1dkbGtEUXpEaGgxcXUxS1hhQTVzT0FxTmxV?=
 =?utf-8?B?QXRCODFQTUFwUjVVQndtcWhkTnU3cStBcUZXSzZiL2RNUFEyem8wUG1sQm9q?=
 =?utf-8?B?SUwvbFRIYUx5UWpQZEtUYnErSXR3L0Nrb1NtOERweGhJWFRvUzdlVjdKdXBp?=
 =?utf-8?B?N28walIvVHdSaDBkUXpUTkNnK0NpMFFOdjlYYk9RaWsyS0dublVIQlBhQTJL?=
 =?utf-8?B?QzlkRGhBcjNMenhqU1BpdGxIcG5lazZxNFI1N20wRWNxZkFLZExpaGU5WkRC?=
 =?utf-8?B?WXVsYUg3Q0UzQUI2UFBTaC9NT2Fpa0VaSVR3OWgzV3Jod0NZTVdScWxzaXlM?=
 =?utf-8?B?UHQzK0t5cVBGaG5Fc2RNd05vckNacXkxbVg3czdMRWRtUkFZMGVSdXViNzgv?=
 =?utf-8?B?RkZVekh2UytQZGc2dm9wUXFaenA4ZzZnNndwWEpYQmF3dVhhQ3JXbEdJK1Yz?=
 =?utf-8?B?K2lRSzZCQkhSVE1XY1BsVUN4dk1OSTM2Mno0S21ZZENxTWdyT042ZHRDZkJo?=
 =?utf-8?B?QlVKSkdJM2RKQmZvNGFYNk9OamozS3N4OGJVbFpYUVZMZEM5TERqa09qRkt3?=
 =?utf-8?B?bGZoMFp4cHZFL3FJSjk4QmNUeitoMHd3cnNWTUgzcnRyNGc3cVU0UmpsRDRs?=
 =?utf-8?B?ODdoMXNBS05CaExHam9YR1hKM3ducXpoNmY5b1l1bDRqRmFUSlRaYW9OQmZH?=
 =?utf-8?B?djN2ejJ1Rjc3RmJhSCtVMzhMSmRDZXBtdHFRMkdRdFo2czR2WUZnTHdWOU16?=
 =?utf-8?B?M3E0WTBuNnZ3VXVYZFFHeFRySzYwR044T0ZnaEFjVmZ1YjdhdWtRVnozcGxw?=
 =?utf-8?B?UU9pVnpmcnJJL29kOU1YZzJkZHJXakhkVHFhcUd0ODdnQmtlNHE5QmxUTWFx?=
 =?utf-8?B?U2F4SjlLMmQzV0ZFZ2h6Qlc4Zmt2Q2dGMFY5S09IYkdPc2F3Z2xWRFB2ZGRz?=
 =?utf-8?B?YWZZUDVYa2tjTWkxL1IxZENDK3V3U1QvTWxWRncxbXU0ZUJmeEw4cE9JeXU2?=
 =?utf-8?B?ZG80S3VBdzZjbXliSXM0WllVSFQ0U0FzdG9iZDE3VE5qdUdJM1kwNnJ1VCtT?=
 =?utf-8?B?bm9JNC9DZi9FeXpTUTNyV2JLb0dWZXNWL3dSZk9NdDFDTnJvNE9CS21hNGtT?=
 =?utf-8?B?M3h4aERNVFpVelQ0NGxOZHBSMkNjSXpWbW9QV2poM3QyZW1CSkNuQndCU3Rp?=
 =?utf-8?B?eDZDQ1Y5ODE3K2U2YjdXQkI0Z3ZDV2pKOTJCTE1VNmZoTkVnbzBDYTBXRzFZ?=
 =?utf-8?B?RjBWVnNGeEhBZ1hLcnlDMW41czNGNGxDVHdSbmJtckNpQzRSL0ZEQ2laSGZH?=
 =?utf-8?B?TUNDWUtvMFpyRVBwdDBEaEtVWHBjMVBkUHRnNjE2cWZ4VEJiRmpnQzFEUW10?=
 =?utf-8?B?eE8vSFY3VXpJRUpzZDZRcncyRmJEd3Zta2doL2JWVGEveEwvRFVDbmJTSGNN?=
 =?utf-8?B?YW1sU0FNMHZ3bWl1clE5VjZILzVxUHlwSkdlRW4yK0VSUWVhb0w3NUlDYVJx?=
 =?utf-8?B?VFZmcDE2dVB1blJTOHViVTlZc3dJK0VUWnZWQ2lrZVJhK1JDejNTbVZrUWlY?=
 =?utf-8?B?VVg0eXhiVDM3SFhqL3lLT2toWFhvNTVRck5ybFNlUTJSYVN3WTY3bkYvL1NU?=
 =?utf-8?B?dFBkM0lxSjROMHFpSFEzQWo0WmwyM1UrNGpjUlNjSkhSVGRlNVZWOWlVL2dT?=
 =?utf-8?B?TmpDbUF3UVJxZXlKb0l1MDkvYkhmd2RhaFpIU2lxVFdTdWM4ZUZRYWtCaE5S?=
 =?utf-8?B?clFBcTdORGVDVmI0Z3lpK0U2ZmcwVDNWUTJZQkxvZE9GaWJBMkZXRVZQTkFw?=
 =?utf-8?B?RjRhV0d3UmFWd0xhbWdJYUlWUm93V1dCajIwNlFmbjBlMzNrY2VqeHgwNndW?=
 =?utf-8?B?M0FZSVZpUlVDb1owSUp1eXNyZjkxSS9XMWtGVkMrVmhIb3VKa0NpM2w2bmky?=
 =?utf-8?B?UnRBUHY2cUdiUjZZalVPdHhjWlhCRkIzQUhQaVF4cFQvaU9mZVRjZ01CUVFI?=
 =?utf-8?B?Q29qRXR0S3lJN0YxNFBMUDhEVFhNTkxLN1B1Z25hUkcvSTJrbDU1Q1N5NE54?=
 =?utf-8?Q?QG4A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e611151-8055-426b-3967-08de0fa65294
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 07:00:15.7191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Onn8/fpr7JjAkR45HMmvl0bKOmrhR0drZY+6CPt44HWenn9+eDnO25KyyuwWbCPpKUZOD4JT5FLaVObgd0BZ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7549
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogRmFiaW8gRXN0ZXZhbSA8ZmVz
dGV2YW1AZ21haWwuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQxMOaciDE55pelIDQ6MjIN
Cj4g5pS25Lu25Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4NCj4g
5oqE6YCBOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgZGwtdWJvb3QtaW14IDx1Ym9vdC1pbXhAbnhw
LmNvbT47DQo+IHRyaW5pQGtvbnN1bGtvLmNvbTsgc2JhYmljQG5hYmxhZGV2LmNvbTsgamFnYW5A
YW1hcnVsYXNvbHV0aW9ucy5jb207IFllDQo+IExpIDx5ZS5saUBueHAuY29tPjsgQWxpY2UgR3Vv
IDxhbGljZS5ndW9AbnhwLmNvbT47IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29tPjsgSmFj
a3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPjsgc2pnQGNocm9taXVtLm9yZzsNCj4gbWtvcnBlcnNo
b2VrQGtlcm5lbC5vcmc7IG1hcmVrLnZhc3V0QG1haWxib3gub3JnDQo+IOS4u+mimDogUmU6IFtQ
QVRDSCB2MSAxLzRdIHNwaTogbnhwX3hzcGk6IEFkZCBuZXcgZHJpdmVyIGZvciBOWFAgWFNQSSBj
b250cm9sbGVyDQo+IA0KPiBIaSBBbGljZSwNCj4gDQo+IE9uIFR1ZSwgT2N0IDE0LCAyMDI1IGF0
IDg6MTnigK9BTSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPiB3cm90ZToNCj4gDQo+ID4gK3N0YXRp
YyBjb25zdCBzdHJ1Y3QgdWRldmljZV9pZCBueHBfeHNwaV9pZHNbXSA9IHsNCj4gPiArICAgICAg
IHsgLmNvbXBhdGlibGUgPSAibnhwLGlteDk0My14c3BpIiwgLmRhdGEgPSAodWxvbmcpJmlteDk0
M19kYXRhLCB9LA0KPiANCj4gSSBkb24ndCBzZWUgdGhpcyBjb21wYXRpYmxlIHN0cmluZyB1c2Vk
IGluIExpbnV4Lg0KPiANCj4gV2lsbCB0aGlzIGRyaXZlciBiZSBzZW50IGZvciBMaW51eCBpbmNs
dXNpb24/DQo+IA0KPiBQbGVhc2UgcHJvdmlkZSB1cyB3aXRoIG1vcmUgZGV0YWlscyBhYm91dCB0
aGF0Lg0KDQpIaSBGYWJpbywNCg0KVGhlIFhTUEkgTGludXggZHJpdmVyIHdpbGwgYmUgc3VibWl0
dGVkIHRvIHRoZSBjb21tdW5pdHkgc29vbi4gSSB3aWxsIGtlZXAgeW91IHVwZGF0ZWQgb25jZSB0
aGUgc3VibWlzc2lvbiBpcyBjb21wbGV0ZS4NCg0KQmVzdCByZWdhcmRzLA0KQWxpY2UgR3VvDQo=
