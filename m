Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF155D2E9C3
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 09:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 029328902D;
	Mon, 11 Nov 2024 10:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="ow2a2BTJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E595688EBB; Mon, 11 Nov 2024 10:24:50 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99517891A4
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 10:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RREvunwNth4797+S9162wFAX9PZYP8rPr+rXuraKDT5deR8WSYFCrb3zYctUfC4v8oXlV/Un3/Hp2PvItcGrrWmHdtg69Pp51xvPiPzC7SEPToiKwHa/I60aL+D1R4PjXHGsHWsZYiZfhSa35SYqicpf3I8h7Pd61+z+198xAJmjhUKWbrh1HITAvFqJK16E5GTVY8GV97561+tNXmt8G4j89hWCACm0qT4PZNX7kzQTy6MEKdIHTnSByj3S2IrRbMMYM6O8nfLh308fT/1G8/8q7nW6h3kyxgIa4nk/iZlB0Oz7LrOyM4RdnhJ4sR350DNJ64wSZzGOztEq5sh1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dp1oFFtY2H9CKTY7k1LDnJapIFpQiamq+tqoFOOUB7A=;
 b=MKV9HI4g7eIDdEKK2IRIxyu9P5Cr47IqTVw8XcEP17t2TfecTeeHxW7mrs4jHx5ZC9ggvjbCotGfLGgVVhCQ0lv4bFlXUziXmBtfJ0nxP5eBc+GzvR3i0AGymH15G1DC4Q+0j1iHqSYqUo3MNQiwHy9yI5a75NmnpBAFbb7mWIADaoCB5o3gruobPTT22rwcHJmC2is99zz2KbGTJMwtTHvekJVUrismpeK0swvvK4Wuh4EukpEjU7iNDAnbfxm4eIBHrkNGFSlitnLBUEFAp2zzcJTKKD2MdYojGNVWEvQHKi6EvJ5CqzxlFGGSDsAc+TZYpLPn6GpdFSBuduM2mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dp1oFFtY2H9CKTY7k1LDnJapIFpQiamq+tqoFOOUB7A=;
 b=ow2a2BTJSc1CNnmc9URjXnASMsGgRpUSfjAI22+cN78eQuBMJXRECHXWX8/H0NmIK/EFKa9ICq57SND8LPExQ9QS8bEbQOcEjMMmjL/kOooObOVO86LndyETLfN71AfKk7cLGLeILhi1SuAyLHNcuBLKY/SyJqsQToGvS2SC0TUdgC6jYjGESM0cF7r/QCLQSxceVctTWtEi3XYvZpkZ177RQR6YlmVIGNdyHDtld6iXMqRBnasTRqOaTvWTiv5kkL2TOhdRUSZWpwD5vRNRcrp7SwR8C6nQpXteDJjZvIV5kmIVWbzJdw5YG2zhOODXxPMf7hF4duciFnCOLW9B9g==
Received: from DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:119::9)
 by DU4PR10MB9093.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Mon, 11 Nov
 2024 09:24:46 +0000
Received: from DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c697:dfe:4400:dd6d]) by DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c697:dfe:4400:dd6d%5]) with mapi id 15.20.8158.013; Mon, 11 Nov 2024
 09:24:46 +0000
From: "Leto, Enrico" <enrico.leto@siemens.com>
To: "hs@denx.de" <hs@denx.de>, Fabio Estevam <festevam@gmail.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, "Schweizer, Walter"
 <walter.schweizer@siemens.com>, "Sverdlin, Alexander"
 <alexander.sverdlin@siemens.com>, Anatolij Gustschin <agust@denx.de>, NXP
 i.MX U-Boot Team <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>, Tom
 Rini <trini@konsulko.com>
Subject: RE: [PATCH v1 15/22] siemens: imx8-capricorn.dtsi: small adaptions
Thread-Topic: [PATCH v1 15/22] siemens: imx8-capricorn.dtsi: small adaptions
Thread-Index: AQHbMZ4qB2uCVobT1U+Kqq0ZGhNWW7Ku23YAgAK9HACAACNJYIAADaMAgAAI2LA=
Date: Mon, 11 Nov 2024 09:24:46 +0000
Message-ID: <DB8PR10MB37378141219F29E1B2183FBCFF582@DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM>
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-16-hs@denx.de>
 <CAOMZO5D77WPgrjXXyBzk-rAApcqxfSS7nZCF8usz2jj_oF1QpA@mail.gmail.com>
 <4dadf359-8113-08b7-f198-42a2111cef81@denx.de>
 <DB8PR10MB3737C4C148FDD4045198C460FF582@DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM>
 <faee8636-da5a-f990-f506-e8bf1d975078@denx.de>
In-Reply-To: <faee8636-da5a-f990-f506-e8bf1d975078@denx.de>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=a702ffd0-c8e8-4adf-99c9-0f4e055a39ab;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-11-11T09:19:18Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR10MB3737:EE_|DU4PR10MB9093:EE_
x-ms-office365-filtering-correlation-id: f484bb6a-e7ca-43a3-5489-08dd0232af10
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QVgzbmlCSHRWUkl4NXhjRnJhMHJDSTNvbFZOaXl4eXJtMmlVazEwTVhjMmtG?=
 =?utf-8?B?WnZXQzhCM1JmSmhYOFJmV1YybXlySEJNYVorcFhKUE5scFV1TWJ0Qy80MmFL?=
 =?utf-8?B?QlJHUnJZb1lKak9XQmExajh6L1N1RXZuNjYwcWpsMDFWOXQzb2dGazIyNDBx?=
 =?utf-8?B?YVFtenB6U0pScWlYdng3TEc4UnZnMXdaYVUvbTc3RVk3UEtTTUcyQlQrUEhQ?=
 =?utf-8?B?cnZqbVBSMzh3TVhUemhCbmlYT2JDYU5mVnlJWVF0NWxZZ1ZIVnR0YVBiYnlt?=
 =?utf-8?B?MEhuNzZqcVJWQkFGNURFNk1pODdLSzFqZFdkTEMxSll4ZTlsSmxSa0g2Ym9r?=
 =?utf-8?B?UmE4dGtXL2NuWE5uNEpFY2drejlXSUZrYmppVXI1cG1rRG1janVxVHhKc1Mr?=
 =?utf-8?B?NTg1QnNCU2c1RjhTdEdSM25hUERJM0YvVFYrcXcvcDN2dndyZzFtby9zQ0lT?=
 =?utf-8?B?RzVPdnAwc01pWjJrcDErYnZGNC96eU9DZ3BwR0YrQkt2bWxYMUNJeFdRODFy?=
 =?utf-8?B?K20xZHlpaks3WTNJZCtlZm91WUpkWXdxWkJwWHNlakxDeUZxQnMzWFVwdWdH?=
 =?utf-8?B?N2FDWmFmcnZ3bkd2MStiMjRMNmlaenRnbXoyREVHQTlIdmNPZE4ya0dLMXBl?=
 =?utf-8?B?aVAxL0taL3J3d0t2VDAyV2JYazhhN3ZmWVRRM3BtM1MvMEVreUJYb25xZFUr?=
 =?utf-8?B?b1RGdTltU3UxTVl4WndzU1FnbWxhWXdza25ZNkl1ZVBOR2o3U3NtRVZZMW5y?=
 =?utf-8?B?T3NmVlB6VmJpSUNvYmR6RXh3UDhxMUljY1dRcEVlNHNUSGhSa1hURkUrbE5Q?=
 =?utf-8?B?UDZ0ZWs4d2NyV2Y3U2tqTFJIYlRQbld2bHo5MEcwaGdzRzFpZENGckRKR3d5?=
 =?utf-8?B?TjJ4enY0RTZMR3BLQmhsN0syT3BqejdZU1o0TUtieGdXdlprOGFvWDQrUWJp?=
 =?utf-8?B?ckRuZDYyWEFYOXliQlBUWjhTWDBWSzdSV0xZYmpYd1hVMEVsR0tmYUxtaVZr?=
 =?utf-8?B?Yk1Najc4bFVYanFTM0JTeVRZLy9JMHF6SCtzbHdyWUpXNzdqdUZHTm0xY2J0?=
 =?utf-8?B?K3hXaG9GMlJwZWtPekJTRTNGWitXam1nVkIvTkFYdzNXNW96OVhWS3NpY1hm?=
 =?utf-8?B?ZDVXSVRsM0tEL24wZDdJUE5IVmJ0QjJwby8yMUlUN1BBVkJ6KzFhVk84Rytl?=
 =?utf-8?B?QTFmcm1aRjcyU0FnUjl5bHp4dWJydVkxNWg2SDNVQmdkeXNYYXNhRjdyL2oy?=
 =?utf-8?B?RjdYeXljYWVyUmVYTEFGRmFEaWVqZjgzUTY1K0lFcjR4VkJMenlFdEJHRUEx?=
 =?utf-8?B?TThnWkk1V29kWjkrTS9zWFZtdnJJUHBVdFdPc2t2d3NCUHUrdmt6blB6bVlB?=
 =?utf-8?B?OUNRTnhocUR3SXllZzAwS3Q1NlJNdTlYekhtZkhJcy9jWDVQc01SRGtySlZz?=
 =?utf-8?B?WUozWGEvS3RaTS9tV1V1WlpYZjdiaXNZb200NklNZ0cxWUFXTTkra2lZT08z?=
 =?utf-8?B?Yk5ERFdwaFBINmZ0bVJRZi94cWRwOTFKMDlmSXpoRXp4M0Z1eEUveEJsRnJE?=
 =?utf-8?B?TUtycDNhTWpjSnhvQjlIZnl0Y2MzbnpndW1wdXErM1ZJbFVpcUFiYkpqQi9k?=
 =?utf-8?B?bEthTjE0a1Q1eDRMWWlRZ253SjYzYy82K3VzN1ArenJWSmFKUXNRWThiMFRM?=
 =?utf-8?B?RlpZK01PaWRXdEttaEcxOG1rZkJIdmVCc0VycnRnRlUySFRZVG5lRHUrRkZw?=
 =?utf-8?B?OWk4OHhSNngzekNqK2lrb0dvaitBd3dKc3YyTGtnYmhTWWR2d2Vram9nZkJs?=
 =?utf-8?B?dGdpUTRPL1lhM2VBQ1BjMktqTCtZK0J1UWRCbXc4eW4yVzV5RkVsd1dBY0c0?=
 =?utf-8?Q?y9x66wu8mVOId?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEZYa1gvUDBNS01TaXdYUDQvWWtOMExrdHZPT3d1MXZoTmVxdUtlOWJobHl3?=
 =?utf-8?B?QWwxbkdvaHMvay9KdU1PeCtBNEVJS1dVUlFpQnVEdmFOMXZQWWVuaE93NGJR?=
 =?utf-8?B?ajBuQUdBM3hCcXdMZVZzQUZKeCtvc3dZVmxZVlUyWTJPV3oxMUhad2poeit6?=
 =?utf-8?B?T1QzcHMvK1FVVkVFRkROQmt1Um5wZnZJa1R1TnNtWEkvUGU2Z09qTHMzMk9Y?=
 =?utf-8?B?YThydXY2WWM3UnpSbnh4L3YyL2V4VHBuNHRVa1VnaXVJcmZFc3E4NXVHMHFo?=
 =?utf-8?B?ZHRYMlVUMFRXeEExeW04ZEc3VyszcStrdlJpd2J3UnFZVDMyOGMwcHF4UlBI?=
 =?utf-8?B?blc1OTQ1L3VGN3grNU1BeUdDRTZPcThRRmFhR2k3QVlIazZJYklaY1VEd0tt?=
 =?utf-8?B?ZW1lWG1VT2pDYmJTZndJYTl3Wld0SG1rdCtHZFdLRGVzK2RwNWxMOUZxeEVk?=
 =?utf-8?B?QXNSU1ZBYnJyTEd6aE1MVXpDa2s3NThvRTNUWkljODFxUUNUTkd5WHh6L3RL?=
 =?utf-8?B?RUNpVjJ3MUJibXN1ek92TXdoMTFtTXBlWWZhc0Y1eUxYaTJNTm1ZcVBJMElv?=
 =?utf-8?B?S0JtdmR5T2ZFb2MxNXBvSEEzek9pNE5uaW1aaDNiRzNJYlJ2emM3OXQxeTRN?=
 =?utf-8?B?S09jTEJySXg3dDVLRWthY1lYV3F3aE5RcVE4T2hleUJwSWVWVlFBUFNRUFV1?=
 =?utf-8?B?Q0tRVnM1aUF6cmZhQ1Z2YVN6U1N6eWdBRFdFYS9WR0J3YlpqbGxCbjhRdFpq?=
 =?utf-8?B?MVcwUGxYaWVXKzJkLzVvNnMzUUVzUHJOU3VmRjdGREFvNldKUTVTRFdJMmNL?=
 =?utf-8?B?TXBqZHFhVUhlUDVmeDBGU0IxY3FpMHgvNUF1WmxRL1hwZmVJVzFEc1Nkdnp3?=
 =?utf-8?B?L0lxOTRRK0QwM01OVjhZbjBXV0xQNURna0hiTVVoaGtTS2NEeWhrVzZJQVpu?=
 =?utf-8?B?UzVkRWFzckNnQ3VYNzFrNGVUOC9LaUZXY0hTK2t6RXVCOHJaT1VOSUNYZFpU?=
 =?utf-8?B?dk9IL1FLcFFLVHEzTCt4d1BtT1NzNE1Ya2dieUlnZU5DRTc0bUllRWxodnNS?=
 =?utf-8?B?SGFDRUNiWE9rbXJib0NVWnhWWHQrT2hRQlRveG5rRWkweFVyRCtVSHpvV1pu?=
 =?utf-8?B?R3JPQk0xb2VpalBxMkJqZElDYlhoN2N6dmluSVNSYVBOcmw2SzU1cElxTS9G?=
 =?utf-8?B?Z0syUlI3ZENUa29TQXVKeFMyVVdCT0VMUEs2OGQ5S0dFU3lha04yV3JXdDR5?=
 =?utf-8?B?TFk4SnNGZ2EvMjZ5VzQ4SGVPOW1EdDZWekNrcDJkTHJGSU5TQk1nOWdzNkpw?=
 =?utf-8?B?Z09lam94bjRYQTZCRzFiT2N2Qmh4MDR4MksycTc5M09NYVQ0a0kwaC80bkdm?=
 =?utf-8?B?Q0JVQ3Q5K2RBY1lWMElKUFFsVkZIZTAxQzdDNURpR2hiL0dhMWRmMnhpQ1ZL?=
 =?utf-8?B?L1BYUTUxSlRSbEtyazkxdDk2MXVXbnI1VHpLM0ZKNkZpUldHUXJlU0pDOWpi?=
 =?utf-8?B?dHNQYm4zSUNCWlluWjNES1FnUWFCNDBjVTBSMGF2bm1oYkFNZ0krNDh6eVhp?=
 =?utf-8?B?cU5WVWV4aXJwZUF4dUZyVzdkWGlTLzhpOXNFcXhGeXg5Y21tWm5RQTdoaWI3?=
 =?utf-8?B?bU5sNHd6ekpKeGZVT3BUQ1FHR3AxZUlmSmhxbXc5ZGdZNTRXaHo2OW9LUHZv?=
 =?utf-8?B?cHdvOUR1MzVtVTlkeWdKMzNiRWQzY1l5OThubTF6UXdxOXlObGxkRjYyNUYy?=
 =?utf-8?B?NDVwV3F4d0loSzdVTlhtVS82eEphQnUrZVlObGUzN1NNU1VmcnpoOWxzNTJt?=
 =?utf-8?B?MXRla3p4SWZvZTFqTTQ4c0pQdUpjSGVUWTQ2b2luaXZneldaaElEekIrOEZN?=
 =?utf-8?B?UFlsekh2SE44Y21maGhsdVBuM1pOTGFJS0UyY2FxZXh4dzB3Vm5UVEhtc1J5?=
 =?utf-8?B?NVgzQU9nKzhta0k0WnJKNG05dW1VYmRxcFg1UndqdkFKYzdtU2xoeTc3N3or?=
 =?utf-8?B?N2tvOFBkUnliSW1QRi9FOTc0NitFTXpVRW9BMHgvNFZBcHBKdXl4SHlvdnNi?=
 =?utf-8?B?MUZvZS9YaU1vUW1vTkh1elpmRlRTc0hnWXd0TnE0ZFoyclZOaVFRcUZBdTNh?=
 =?utf-8?Q?bBqLPWPPzmNSsi2G5I7dCdoIG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f484bb6a-e7ca-43a3-5489-08dd0232af10
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 09:24:46.5098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +VvuEyYA2+UBqjvk/OMPPxWNXN9VWQrksIz28TrzNv23pJizX7eMRjgQD+4XITMiIIaWBZ3ChdET+IzjBZbcXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9093
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

SGkgSGVpa28NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIZWlrbyBT
Y2hvY2hlciA8aHNAZGVueC5kZT4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxMSwgMjAyNCA5
OjQ4IEFNDQo+IFRvOiBMZXRvLCBFbnJpY28gKFNJIEIgUFJPIFRJIEVBQyBDQ1ApIDxlbnJpY28u
bGV0b0BzaWVtZW5zLmNvbT47IEZhYmlvDQo+IEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4N
Cj4gQ2M6IFUtQm9vdCBNYWlsaW5nIExpc3QgPHUtYm9vdEBsaXN0cy5kZW54LmRlPjsgU2Nod2Vp
emVyLCBXYWx0ZXIgKFNJIEIgUFJPIFRJDQo+IEVBQyBDQ1ApIDx3YWx0ZXIuc2Nod2VpemVyQHNp
ZW1lbnMuY29tPjsgU3ZlcmRsaW4sIEFsZXhhbmRlciAoU0kgQiBQUk8gVEkNCj4gRUFDIENDUCkg
PGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT47IEFuYXRvbGlqIEd1c3RzY2hpbg0KPiA8
YWd1c3RAZGVueC5kZT47IE5YUCBpLk1YIFUtQm9vdCBUZWFtIDx1Ym9vdC1pbXhAbnhwLmNvbT47
IEJhYmljLA0KPiBTdGVmYW5vIChFWFQpIChERU5YIFNvZnR3YXJlIEVuZ2luZWVyaW5nIEdtYkgp
IDxzYmFiaWNAZGVueC5kZT47IFRvbQ0KPiBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTUvMjJdIHNpZW1lbnM6IGlteDgtY2Fwcmljb3JuLmR0c2k6
IHNtYWxsIGFkYXB0aW9ucw0KPiANCj4gSGVsbG8gRW5yaWNvLA0KPiANCj4gT24gMTEuMTEuMjQg
MDk6MjUsIExldG8sIEVucmljbyB3cm90ZToNCj4gPiBIZWxsbyBIZWlrbywgRmFiaW8NCj4gPg0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBIZWlrbyBTY2hvY2hl
ciA8aHNAZGVueC5kZT4NCj4gPj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxMSwgMjAyNCA2OjUz
IEFNDQo+ID4+IFRvOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+ID4+IENj
OiBVLUJvb3QgTWFpbGluZyBMaXN0IDx1LWJvb3RAbGlzdHMuZGVueC5kZT47IExldG8sIEVucmlj
byAoU0kgQg0KPiA+PiBQUk8gVEkgRUFDDQo+ID4+IENDUCkgPGVucmljby5sZXRvQHNpZW1lbnMu
Y29tPjsgU2Nod2VpemVyLCBXYWx0ZXIgKFNJIEIgUFJPIFRJIEVBQw0KPiA+PiBDQ1ApIDx3YWx0
ZXIuc2Nod2VpemVyQHNpZW1lbnMuY29tPjsgU3ZlcmRsaW4sIEFsZXhhbmRlciAoU0kgQiBQUk8g
VEkNCj4gPj4gRUFDIENDUCkgPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT47IEFuYXRv
bGlqIEd1c3RzY2hpbg0KPiA+PiA8YWd1c3RAZGVueC5kZT47IE5YUCBpLk1YIFUtQm9vdCBUZWFt
IDx1Ym9vdC1pbXhAbnhwLmNvbT47IEJhYmljLA0KPiA+PiBTdGVmYW5vIChFWFQpIChERU5YIFNv
ZnR3YXJlIEVuZ2luZWVyaW5nIEdtYkgpIDxzYmFiaWNAZGVueC5kZT47IFRvbQ0KPiA+PiBSaW5p
IDx0cmluaUBrb25zdWxrby5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTUvMjJd
IHNpZW1lbnM6IGlteDgtY2Fwcmljb3JuLmR0c2k6IHNtYWxsDQo+ID4+IGFkYXB0aW9ucw0KPiA+
Pg0KPiA+PiBIZWxsbyBGYWJpbywNCj4gPj4NCj4gPj4gT24gMDkuMTEuMjQgMTM6MDMsIEZhYmlv
IEVzdGV2YW0gd3JvdGU6DQo+ID4+PiBIaSBIZWlrbywNCj4gPj4+DQo+ID4+PiBPbiBGcmksIE5v
diA4LCAyMDI0IGF0IDI6MjLigK9BTSBIZWlrbyBTY2hvY2hlciA8aHNAZGVueC5kZT4gd3JvdGU6
DQo+ID4+Pj4NCj4gPj4+PiAtIHJlbW92ZSBETUEgZm9yIGNvbnNvbGUNCj4gPj4+DQo+ID4+PiBX
aHk/IERvZXMgaXQgY2F1c2UgcHJvYmxlbXMgaW4gVS1Cb290Pw0KPiA+Pg0KPiA+PiBGb3J3YXJk
IHRoaXMgcXVlc3Rpb24gdG8gRW5yaWNvLg0KPiA+DQo+ID4gVGhlIHJlZmVyZW5jZSBpbXBsZW1l
bnRhdGlvbiBvZiB0aGUgaW14OHF4cC9pbXg4ZHggKG1layBib2FyZCkgdXNlcw0KPiBscHVhcnQw
IGZvciB0aGUgY29uc29sZS4gV2UgaGF2ZSB0aGUgY29uc29sZSBvbiBscHVhcnQyLg0KPiA+DQo+
ID4gR2V0dGluZyBhIGxvb2sgb24gTlhQIHUtYm9vdCB0aGF0IGlzIHRvZGF5IHRoZSBiYXNlIG9m
IG91ciBjb2RlLCBETUEgaXMNCj4gZGVmaW5lZCBmb3IgbHB1YXJ0MS0yLTMsIG5vdCBmb3IgbHB1
YXJ0MC4gTlhQIGRvZXNuJ3QgdXNlIERNQSBmb3IgdGhlIGNvbnNvbGUNCj4gYW55d2hlcmUgZm9y
IGlteDguIEl0IHNlZW1zIGl0IGRvZXNuJ3Qgd29yayBwcm9wZXJseSB3aXRoIHRoZWlyIGRyaXZl
ci4gRm9yDQo+IHRoaXMgcmVhc29uLCB3ZSBkaXNhYmxlZCB0aGUgRE1BIGhlcmUuDQo+ID4NCj4g
PiBHZXR0aW5nIG5vdyBhIGxvb2sgdG8gdS1ib290IHVwc3RyZWFtIEkgc2VlIHRoYXQgdGhlIERN
QSBpcyBub3QgY29uZmlndXJlZA0KPiBhbnl3aGVyZS4NCj4gPiBNb3ZpbmcgdG8gdXBzdHJlYW0g
d2UgZG9uJ3QgaGF2ZSB0byBkaXNhYmxlIGFueW1vcmUuDQo+ID4NCj4gPiBASGVpa286IEkgcHJv
cG9zZSB0byByZW1vdmUuDQo+IA0KPiBPa2F5LCBpIHJlbW92ZSBpdCBhbmQgdGVzdCwgdGhhbmtz
IQ0KPiANCj4gPj4+PiAtIGFkZCB3ZHQgZGV2aWNlDQo+ID4+Pj4NCj4gPj4+PiBTaWduZWQtb2Zm
LWJ5OiBIZWlrbyBTY2hvY2hlciA8aHNAZGVueC5kZT4NCj4gPj4+PiAtLS0NCj4gPj4+Pg0KPiA+
Pj4+ICAgIGFyY2gvYXJtL2R0cy9pbXg4LWNhcHJpY29ybi5kdHNpIHwgMTYgKysrKysrKysrKysr
KysrKw0KPiA+Pj4NCj4gPj4+IEFyZSB0aGVyZSBhbnkgcGxhbnMgdG8gdXBzdHJlYW0gdGhpcyBk
dHNpIGFuZCBzd2l0Y2ggdG8gT0ZfVVBTVFJFQU0/DQo+ID4+DQo+ID4+IEhtbS4uLiBnb29kIHF1
ZXN0aW9uISBDdXJyZW50bHkgd2Ugd29yayBvbiBVLUJvb3QgdG8gZ2V0IG1haW5saW5lDQo+ID4+
IHJlYWR5IGZvciB1c2UgaW4gcHJvZHVjdGlvbiwgc28gd2UgZ2V0IHJpZCBmcm9tIE5YUCBjb2Rl
Lg0KPiA+Pg0KPiA+PiBJIGRvIG5vdCBrbm93LCBpZiB3ZSBjYW4gcmVhY2ggdGhpcyB3aXRoIG1h
aW5saW5lIGxpbnV4IHRvby4uLg0KPiA+Pg0KPiA+PiBNYXkgdGhlIHNpZW1lbnMgZ3V5cyBjYW4g
YW5zd2VyIHRoaXMuLi4NCj4gPg0KPiA+IEhlcmUgdGhlIGNvbW1pdCAiZmVhdChzY3Vfd2R0KTog
YWRkIG9wdGlvbiB0byBjb250cm9sIGV4dGVybmFsIHdkdCB2aWENCj4gPiBJTVg4IFNDVSINCj4g
PiBodHRwczovL2NvZGUuc2llbWVucy5jb20vY2NwL3UtYm9vdC8tDQo+IC9jb21taXQvYTViOTlk
MWM0MDZmZGY5MmNkMWQ3ZDUwZA0KPiA+IDU2NmE0ZTFlNjZjNDQ3Yg0KPiA+DQo+ID4gQEhlaWtv
OiBDaGVjayBpZiB3ZSBoYXZlIGEgY2hhbmNlIHRvIHB1dCB0aGUgd2hvbGUgY29tbWl0IHVwc3Ry
ZWFtLg0KPiANCj4gQWVobS4uLiB0aGlzIGlzIHRoZSAicmV3b3JrZWQgZm9yIG1haW5saW5lIHBh
dGNoIiB3ZSBjdXJyZW50bHkgdGFsayBhYm91dCENCj4gDQo+IDotUA0KPiANCj4gVGhlIHF1ZXN0
aW9uIGlzLCBpZiB3ZSBjYW4gZ2V0IHRoZSBzaWVtZW5zIGxpbnV4IHBvcnQgYWxzbyB0byBtYWlu
bGluZSBsaW51eCENCj4gQnV0IHdlIHNob3VsZCBkaXNjdXNzIGZpcnN0IGludGVybmFsbHkuLi4N
Cj4gDQoNCk92ZXJzZWVuLiBUaGUgcGF0Y2ggbWVudGlvbmVkIGFib3ZlIGlzIG5vdyBzaGFyZWQg
aW4gMDEvMjIgYW5kIGhlcmUuDQpJIHdvdWxkIHVwZGF0ZSB0aGUgY29tbWl0IHRleHQgbGlrZSAi
c2llbWVuczogaW14OC1jYXByaWNvcm4uZHRzaTogZW5hYmxlIHNjdS13ZHQiLiANCg0KPiBieWUs
DQo+IEhlaWtvDQo+ID4NCj4gPj4NCj4gPj4gYnllLA0KPiA+PiBIZWlrbw0KPiA+PiAtLQ0KPiA+
PiBERU5YIFNvZnR3YXJlIEVuZ2luZWVyaW5nIEdtYkgsICAgICAgTWFuYWdpbmcgRGlyZWN0b3I6
IEVyaWthIFVudGVyDQo+ID4+IEhSQiAxNjUyMzUgTXVuaWNoLCBPZmZpY2U6IEtpcmNoZW5zdHIu
NSwgRC04MjE5NCBHcm9lYmVuemVsbCwgR2VybWFueQ0KPiA+PiBQaG9uZTogKzQ5LTgxNDItNjY5
ODktNTIgICBGYXg6ICs0OS04MTQyLTY2OTg5LTgwICAgRW1haWw6IGhzQGRlbnguZGUNCj4gPg0K
PiA+IFRoYW5rcywNCj4gPiBFbnJpY28NCj4gPg0KPiANCj4gLS0NCj4gREVOWCBTb2Z0d2FyZSBF
bmdpbmVlcmluZyBHbWJILCAgICAgIE1hbmFnaW5nIERpcmVjdG9yOiBFcmlrYSBVbnRlcg0KPiBI
UkIgMTY1MjM1IE11bmljaCwgT2ZmaWNlOiBLaXJjaGVuc3RyLjUsIEQtODIxOTQgR3JvZWJlbnpl
bGwsIEdlcm1hbnkNCj4gUGhvbmU6ICs0OS04MTQyLTY2OTg5LTUyICAgRmF4OiArNDktODE0Mi02
Njk4OS04MCAgIEVtYWlsOiBoc0BkZW54LmRlDQo=
