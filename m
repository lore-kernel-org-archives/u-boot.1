Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47006D3C53E
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 01:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B141088DFF;
	Fri, 18 Oct 2024 03:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="U9wyqfYD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 314D78911F; Fri, 18 Oct 2024 03:02:28 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1943C88883
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 03:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUOOuGgD+fT71EL3VxLdVrsIjbMyVlxwTHtYhbNncUA/HGYTwG/ZVrIvL5oDqDq4fRXWqUAcBSZayL1wFDiEz1CHUi9H2XViS8BdU9KUg3UJd7SUkJahaOAXt8qlOo83xjNFqBoJSZEprapVbCeMU0q5g9jmoCtJwQ/Qw4QX07FGPgAjnkhGnHti9d9zYqqZkcM+vJg1zENESt9GldJvP1+W7/CaLG9cUQQpeqyXesStmwCUZ+XDE6SwHMcIwrMtHv+i6pzTPvbJVVW/UcuuyDDTh+kqKeD5PEL6laKETJJ9J8C7qJbv/vcEpbIf3lKHn8LeSJL1D+Fd4/Z9AAG3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuYhYCskdNXdU72HjRGmbyQw1zzM7ciAtJd9Cc/RgoI=;
 b=Wf0VCSXPkX3vtNZ+526hg5PkrdFe6q6yjZWkFV+WFLoPBVYNzf6nGAN8HnVYw2wJr+whv+NgBqdqjIQkygZiKhm9Np5/d5HpZNHrk38yvNfb4piPDcZZfXplGQrgUW5a52oJUv/B1JbDBfZxXUdTaOUQv9sbHAcYFykPMFEGcfCuWYy2FGnEonrC60pClGKoJO6r7dCuV4AQmVCoCh+7xS6bv9NuNS8Ltz3nXI3ZaQedwLs3HHMU+B8OVNeR4sIbPJGxHHKt79m+mieBvwxkEW3jGSuiLlynfTm+qZz/dSRHQv2wYGX2zA44bDoQC6WDQ2YyxYChj73fEdo4XD8/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuYhYCskdNXdU72HjRGmbyQw1zzM7ciAtJd9Cc/RgoI=;
 b=U9wyqfYDNUt/r4qPXEaKdmVmYmxG0P1XXHJWwdss9W24VqOsuHFpxNY3r3Bct+SLG+r2h5rtlSATA0ftiiB1QbT0CZusKvku2VGed7XJbrxTGzUfeaL8FzDu7M+Rk8+X7EAcCYl3S4M8InK3x3eguAh4O1D937C40VDIxR5ErysW+mGdrPEcPHsRXvoCYcJnvSpXpzdoISbqmXeYJsnTB58NWqtJiUTypgBqgo8PRqhsvRTRN02kSIrmDZgr3uFGsyksT4tXyxqzHgdXYB8ZQ4S5etiYufln+Fa0tAoVnPSo8pg32Zqa1s0BIFj8CCvsTTLlt7KRg5qQnHyizh4J+A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB8003.eurprd04.prod.outlook.com (2603:10a6:20b:240::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 01:02:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 01:02:22 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "sbabic@denx.de" <sbabic@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 dl-uboot-imx <uboot-imx@nxp.com>
Subject: RE: [PATCH V2] cpu: imx8_cpu: Avoid revision to corrupt device tree
Thread-Topic: [PATCH V2] cpu: imx8_cpu: Avoid revision to corrupt device tree
Thread-Index: AQHbIGNnnH52cCnroUCvyoJvsosYnbKK5XoAgADMMXA=
Date: Fri, 18 Oct 2024 01:02:22 +0000
Message-ID: <PAXPR04MB8459C9BDB1F44470D54ED90188402@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241017081236.26742-1-peng.fan@oss.nxp.com>
 <CAOMZO5Aikd3f5-Cnbtcn74qBAkLOs5hv_42FeZk2nxz94vksBg@mail.gmail.com>
In-Reply-To: <CAOMZO5Aikd3f5-Cnbtcn74qBAkLOs5hv_42FeZk2nxz94vksBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM8PR04MB8003:EE_
x-ms-office365-filtering-correlation-id: 8130c8a5-d525-4622-1b49-08dcef1085f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Qk1KTHRLS05obUhMaU44RlBqd0xjZmV5bWlXUVZVUHM2YmtLWlZOS094QlpN?=
 =?utf-8?B?Q205SlVvaGxxS1lNNm1UdUQxTDFjbndMMUpMM3VUcmZWdm9ZUVUzK0hSRVBX?=
 =?utf-8?B?TUpOSm03NHljY0NhMkxvSzM5dzUrMGpDOFR5bVQ0VndneE0rb043RUNzblI1?=
 =?utf-8?B?dGJBTGN1Z1FpQ0plSWVPWGZ3L1FtSVZva3JMR3M2c1ZiWjRYUUl4OXdNZEhV?=
 =?utf-8?B?UjdlQktuYWpRVmZtTUdmV3hCL2p3YkExc3k0cW5ncTl4a1VXSktCLy8vQ2xr?=
 =?utf-8?B?RzBrMnZHd1luVmYrRU1MaXJ1VlBRYnB3TFhsd3hTejJMQXZQYm9ZM1ZSbDVi?=
 =?utf-8?B?MVFJa250bkRzbVpyUCtZMEszOGFqempnMWVIM1BYTWVaalNucndkQ1pOU0NE?=
 =?utf-8?B?aWhkdkl3NUxRSEY3OVlUdWs2bXpsRlMxb2NINTV4OFNYN3JTWWFpK09HelRu?=
 =?utf-8?B?cDBSNm1Zekt5ZTdVRnl1YlprU2hwRTQ3K3p6MW5YbFZVenVTWm9tWUlXM1NN?=
 =?utf-8?B?RnJabEhQM2ppTnNrQ0dEbnR2N1M4UUtMd1RKbGRBRncxcVNMejZYWnE5T1ND?=
 =?utf-8?B?OE0wK083NkthamF0M0dtWkpLYzlvM1luaWlZblRvUk5ZMFY4cGxvT20rb3lk?=
 =?utf-8?B?bk4yYXErSUlnV3ppdFNMem55SUZHNjNnbUxTV0pkUG5NUWJpbWpnUTJDL1ZY?=
 =?utf-8?B?UC9XTTVZckVVQmFHRzdwaWtoR1hseVRpQkdMR0VPa2RCeElReE5TRGJvZm5z?=
 =?utf-8?B?VjNoUVRyZjNNZXE0blFMVTJMTk5LZjJtS0JJaEJXNXZKV2xYNUpmdUZGbzBL?=
 =?utf-8?B?OEhQMDQ5RG5VRG1zV0RvWk5HVFN5NmYvWTB0dVJWRG5iUUZTSVYxTzB1UEpX?=
 =?utf-8?B?TGtXYjFyNzJJdXo4eHNuNHMyNXdHTUlwWFJwMExGSjlobjlLMEdIQllMZFZG?=
 =?utf-8?B?ZWJWWVVZeUFqcDZuR1ljZGVoekZjQkRCQkZOZHhLa1cwWWU0Z1dFV0N6NGhU?=
 =?utf-8?B?aEtHSHdDcXhSTnRocGwzSDRwMmdxSktJT3FKbzY4YXg2dVNVUVJLU2hLaDhG?=
 =?utf-8?B?cTdNZlNZU2tVYTVvSE9kekhNOGg1cVJ5ZFN3ZWEzN3VSYW0rYWI2ejVodVVZ?=
 =?utf-8?B?d2ZPdUtZQitkK0xQQzdVcTFIcDM1eWhkVUVqTXFhZm41bHB3Ykp4c3VELzdw?=
 =?utf-8?B?elBVTGVKKzk4QmhLS29EalJlRTZ4SGI3YXNRT25tamMvdit1WXdxRE1WTWRi?=
 =?utf-8?B?a3Vxa0xSVEFOLzNSQytHVVZ5V3BXV2QxczBhUkF3dU1lMExmQ3hpQnJaQ2tl?=
 =?utf-8?B?M0JIaDBOTXJjVnZSa1BzdmE1U2ZnY2l4cHhkZU1BcXBEcWUveFpvN0ZXNS9M?=
 =?utf-8?B?NXFJU1RzR0cvdms2aWR1eHhkT3FLcHQyRGFocXlnOXc5ampvejBjQkdnRG1P?=
 =?utf-8?B?M3hXOU9sV21NS3J2bzVkSUdzbnpjZ3NoTm9PbzU2bE1JTE5hVlZrT01GUVZm?=
 =?utf-8?B?YkR6bXhaWXMvNFFqb0QvQnh6VU1EUEt5eG8xRGZyL3crQTNORGczQ2gvZzlz?=
 =?utf-8?B?Z1V6SGVac3F1N1RKaFBtTUhneGZOUGJDUkZpRTd0RTdrNGpTQVRwN1hBdjlU?=
 =?utf-8?B?ZkRLcWJoNnVTdDhDMWF6aUZkcjlKYitEOWpVMTJpUXkwMXorcWNtclJGa1Q1?=
 =?utf-8?B?R0VUVkFPRXVzcERHdURITUtkdzNNODIxUmF5a2ZVYTlmRkVyY1NPbTlZdGhK?=
 =?utf-8?Q?Afv5JtYAJ+9OWTTtQ0f8qodpiGS1q3qWcT01WcD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXFpWGxsWU9OOFJhK0J3eEpha3I4OHMydG5oVGxYWkg3TmVycWRNbDkvZ0F5?=
 =?utf-8?B?T2F2eEt0MWZ2dEE3NFlMUUdHVnlSMm1PNUdDMExLbWZIMlRnb3hVa2xyeXN2?=
 =?utf-8?B?V3RiemRoSUpiVWRnN1F6dmxwMThtUDJYSFZKbkdCcXpjM0NYM2taVzQvSXJr?=
 =?utf-8?B?NERTUU1lTzg1OWU2TWdEREI2NGlhcEVIRDV4OE92UC9NUlA5TEFiYUxkSHRC?=
 =?utf-8?B?RzZpMkRqSmU0L0JaMXB6WDY0ejl6YXhxOHlZTDJmN1ZQZVVBQ0xpY2Q4dFI3?=
 =?utf-8?B?ZHIzS1QxU0M0OXVnZmh5NFptWlUxZmg3eTBPWDFYcEF4T0xYOTJtYjBLd0ZS?=
 =?utf-8?B?d2txQzJadEloY2JmOEZ1WUJqaTg0Y3NnZVB2R1JNM2pxaGEyeUZodWFRMjNr?=
 =?utf-8?B?VFdLVDdzYUJpS1ZPNGRQV05VLy9wbEdpZ0liZERSVXlrclppcVgrMElybGJs?=
 =?utf-8?B?ZTNaSDdXb3VVSUVQaHdqR04vTGVjWHZ6N2g3SUFlMTN5dFkvL3dRYm5QZ2xj?=
 =?utf-8?B?a0pLQ2pid3BHMWdYaWhBVkwvaXZUNmwrYWlDUlcyVlV3Y1NtN1g0U1hVUVBh?=
 =?utf-8?B?Mm1nNVVZL1ljVlV6ZXNDbGlEODAySFZnTEJvQjUxZVVER05lTHdpNE5ZWHlK?=
 =?utf-8?B?MVBMc3VDdGJvcTVpT1hSVWJ4NDRHRW1MaDJHK2s2T0w0Nng1dlhxSnNXRDdY?=
 =?utf-8?B?UlBFQzFPM0xnQkNCdlNob0ZCMm95dFZZdmNvWjUybXBweDJ6bVJ0YWVKYklk?=
 =?utf-8?B?MTRNZ2Y2N0NPeVNzTWRzWEwwZ0VhM2NZTGxRcEttcnFjTmJRdXhwVHlwQ1Vk?=
 =?utf-8?B?RFlhc3RCU0Qvcjl1YXNSWlVtVndaVHJBdDhGa09well3bEdnL1A0c2N6RTFT?=
 =?utf-8?B?eXJib21uNURqdFk1aEEyM0d0MTRFZUx6RW4vTU05Zmk2c0lFVk1aNHZqckJN?=
 =?utf-8?B?emJmbmdiLy9veEdTdnUvdnpRR1JvdDFZbFZHSVFYQ2JPQVNPbWZjN3BtRCtO?=
 =?utf-8?B?VTByNjhhVWh3d01GT3lRRm9tZERGZ2YwY2dUbGt1ajNWUk56ZmxMTFFxQ1cr?=
 =?utf-8?B?Yzh6amZ1ZWFCeXhubGFsZ0FkWTF1bjdMK0dGMFNwek01eVFCMlNQRk0rZUZB?=
 =?utf-8?B?NjJORDZDWGhCd0wrZ2QwbHc2V2ZHRTJ3RENYaElNb253RnYyL0wrM1hXNmQr?=
 =?utf-8?B?NitHdFdMdStvREE1ZkhsNjlhUWdJSDJhSFBsVDRtRlV1U0ZFZHlrdTdSaXk4?=
 =?utf-8?B?YmNpcGMvN3prcGpLMm14aFd6emlvdW9oVm4vbVdEZWs4ZVVjT3VkSzR3ajZ4?=
 =?utf-8?B?Q0dpeEFUbVZFMUl6Qi9zTlFVZnB3UHpuOUJGdnJGS20zd2IrdDExZk1jWUhU?=
 =?utf-8?B?aGVGcFErSkhCRWZONVlKME55OFJVckNxUUdORDk3Y3NoblpaS3hRbXp6OEFB?=
 =?utf-8?B?bUl6emJNTmJVUDdwa0FHZ0o4OFhVTUlMYnErU2EzZ0RIV1lsQUU4eWk5THdq?=
 =?utf-8?B?QllrRlBHcm1nZjYxZHlNK1psOG9xY2RJbjVCNmc4QlZwTCtRTnpndWo5a3Vt?=
 =?utf-8?B?Z25qMEJzeHRTWjMxN09EQ05LSmpEQXZBS2V2NHRtV2hGc2lMam9mVEdNdTV3?=
 =?utf-8?B?RkF2T25zMHdTZ05PR1RVYzM5b3NBSVNQd1Bxb1I4L09lRnY4UmI4SVhYTU1p?=
 =?utf-8?B?TXdEa1p2Rmwyd1JEbkQ2NEtOdENQTXcwMTB4Sy83OGgwMEdnQW9OZHRVZDRw?=
 =?utf-8?B?QjRKWnV6dWk3L3JUUU5kR3RlQml2RnJpbWlOaWFJblVSUmdWdVBwZ1ZJd0Q5?=
 =?utf-8?B?K3dtZSt6dzVDNmxnbndjRENOdHlNdDFWZkJiREhxbm5vT0xZK0tybWJ1c0xN?=
 =?utf-8?B?SDN1R1U4eUgrYXFCK1h2am92WjF2ZjU2VXlaSEFhVmNjU3d5bmdUOUpsbytJ?=
 =?utf-8?B?T2RqUGQxTk84Y1VUcm5QQVFRbTkxeTY2ejN3NHA5MzUvYXZsYjFFeWFxaE9N?=
 =?utf-8?B?Q1pYWjlHNlhER0psTjkrelVENXZsNmU4RExEajEzTkc4NGxhS25VS0poSWp4?=
 =?utf-8?B?TVIxWW1tZHBIc1lIUXEreXplc2xGOWJHcDE0QVUwbUJob3g2QUl4KzRKaVVv?=
 =?utf-8?Q?E/sw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8130c8a5-d525-4622-1b49-08dcef1085f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 01:02:22.5435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NG/SAWbt8VQZuUrrtNuPrmy5623/zA3v1irUVFO0r3C4ZV4kEiqTjr3JRyxLQfwvZX1Y8a3DhFEUrjMKUkLwlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8003
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBjcHU6IGlteDhfY3B1OiBBdm9pZCByZXZpc2lvbiB0
byBjb3JydXB0DQo+IGRldmljZSB0cmVlDQo+IA0KPiBPbiBUaHUsIE9jdCAxNywgMjAyNCBhdCA0
OjA44oCvQU0gUGVuZyBGYW4gKE9TUykNCj4gPHBlbmcuZmFuQG9zcy5ueHAuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gVS1C
b290IGRldmljZSB0cmVlIGlzIHBhZGRlZCBqdXN0IGFmdGVyIFUtQm9vdCBwcm9wZXIuDQo+ID4g
QWZ0ZXIgdGhlIHdob2xlIHN0dWZmIGxvYWRlZCB0byBEUkFNIHNwYWNlLCB0aGUgZGV2aWNlIHRy
ZWUgYXJlYSBpcw0KPiA+IGNvbmZsaWN0IHdpdGggQlNTIHJlZ2lvbiBiZWZvcmUgVS1Cb290IHJl
bG9jYXRpb24uDQo+ID4NCj4gPiBTbyBhbnkgd3JpdGUgdG8gQlNTIGFyZWEgYmVmb3JlIHJlbG9j
X2ZkdCB3aWxsIGNvcnJ1cHQgdGhlIGRldmljZQ0KPiA+IHRyZWUuIFdpdGhvdXQgdGhlIGZpeCwg
dGhlcmUgaXMgaXNzdWUgdGhhdCDigJxiaW5tYW5faW5pdCBmYWlsZWQ6LTLigJ0gb24NCj4gPiBp
Lk1YOE1QLUVWSyBib2FyZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5n
LmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+DQo+ID4gVjI6DQo+ID4gIG1vdmUgdGhlIHJldiB0
byBtYWxsb2MgYXJlYSBpbiBjcHVfaW14X3BsYXQgIHRlc3RlZCBvbiBpLk1YOE1QDQo+IEVWSw0K
PiANCj4gUGxlYXNlIGFkYXB0IHRoZSBjb21taXQgbG9nIHRvIGluY2x1ZGUgdGhpcyBpbmZvcm1h
dGlvbi4NCj4gDQo+IFRoaXMgcGF0Y2ggYnJlYWtzIENJLiBNYWtlIHN1cmUgdG8gcnVuIGFsbCB5
b3VyIHBhdGNoZXMgdGhyb3VnaCBDSToNCj4gDQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRg0KPiBzb3VyY2UuZGVueC5k
ZSUyRnUtYm9vdCUyRmN1c3RvZGlhbnMlMkZ1LWJvb3QtaW14JTJGLQ0KPiAlMkZqb2JzJTJGOTIw
ODc1JmRhdGE9MDUlN0MwMiU3Q3BlbmcuZmFuJTQwbnhwLmNvbSU3QzM4NQ0KPiA4OTcxYTE5NjY0
NTRjM2M1YzA4ZGNlZWFhNGI0NyU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzUNCj4gYzMwMTYz
NSU3QzAlN0MwJTdDNjM4NjQ3NjYyNDI4NDc5MTU3JTdDVW5rbm93biU3Q1RXRg0KPiBwYkdac2Iz
ZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3cNCj4g
aUxDSlhWQ0k2TW4wJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT1BY1lycTJKRmcxQlBlZ3BLMTglMg0K
PiBCN0tzYUQ0Wm94SUFxR1g4WllsR21VQjJvJTNEJnJlc2VydmVkPTANCj4gDQo+IGFhcmNoNjQ6
ICsgaW14OHFtX3JvbTc3MjBfYTFfNEcNCj4gMzIxK1dBUk5JTkcgJ214OHFtLWFoYWItY29udGFp
bmVyLmltZycgbm90IGZvdW5kLCByZXN1bHRpbmcNCj4gYmluYXJ5IGlzDQo+IG5vdC1mdW5jdGlv
bmFsDQo+IDMyMitkcml2ZXJzL2NwdS9pbXg4X2NwdS5jOiBJbiBmdW5jdGlvbiAnZ2V0X2lteF9y
ZXZfc3RyJzoNCj4gMzIzK2RyaXZlcnMvY3B1L2lteDhfY3B1LmM6Nzg6MTc6IGVycm9yOiAncmV2
JyBpcyB1c2VkIHVuaW5pdGlhbGl6ZWQNCj4gWy1XZXJyb3I9dW5pbml0aWFsaXplZF0NCj4gMzI0
KyA3OCB8IHN3aXRjaCAocmV2KSB7DQo+IDMyNSsgfCBefn5+fn4NCj4gMzI2K2RyaXZlcnMvY3B1
L2lteDhfY3B1LmM6NzY6MjI6IG5vdGU6ICdyZXYnIHdhcyBkZWNsYXJlZCBoZXJlDQo+IDMyNysg
NzYgfCBjaGFyIHJldjsNCj4gMzI4KyB8IF5+fg0KPiAzMjkrY2MxOiBhbGwgd2FybmluZ3MgYmVp
bmcgdHJlYXRlZCBhcyBlcnJvcnMNCj4gDQo+IEkgYW0gZ2V0dGluZyB0b28gbXVjaCBleHRyYSB3
b3JrIHRvIHByb2Nlc3MgdGhlIHBhdGNoZXMgZnJvbSBOWFANCj4gZm9sa3MgYW5kIEkgYW0gbm90
IGhhcHB5IHdpdGggaXQuDQoNClNvcnJ5IGZvciB0aGlzLiBJIHdhcyB0b28gY29uZmlkZW50IHdp
dGggdGhlIHBhdGNoICg6DQpJIHdpbGwgdGFrZSBjYXJlLg0KDQotUGVuZy4NCg==
