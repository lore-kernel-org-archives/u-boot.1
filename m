Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F19D5E392
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 08:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 091BC88D14;
	Mon, 11 Nov 2024 09:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="zIoPODZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09974892ED; Mon, 11 Nov 2024 09:25:37 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0A4E88D14
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 09:25:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNQ7CUntsgLEvEWwTlS6pom9Xi1gPW3z+TzR9aqCfUUchTx3kDezFYvglGet9OFLM5qMRpWDEyENR2ZYEPSGRgnxHkMepFFWwMPKSTOrix+YB8Qvnyz0oN/0dEIJuMjkem8B55/dXYlGQ4I3Q19vqpYBe2QeBr2JCD8ZrLVbJa9wxbm9RWO3+ECSDTVuRmCtc3hzkGrnAAoYJ+WJ18SUZS/EGqhzPInEbuBKT4XrTzSRPFZkll59EGvcELzOd3lnghIwFkzs0W7C2/7nr4ABni+F+rN79UBsCZRu8udT1kevb6s4WIIcIcMcIajkNJcsYfA8FQjFnVj9qBVzx2VrSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FZd7Pv1LjCQpx9jbF5ry2VRuMNChxkm+RVEcrofDcE=;
 b=PHj3qZQT+0BVmekPZ07XWCFu91SV3qSUilhVlHP4LPkFifXeZrIU6rfqY1rWBcecX8IzmHHUqiS11R/dVr7AxLTOuoKHMMwKR4nKwNOo6g83TdXkB2BWKOy/da53xDnE7EfipHQZ9veAKJHaUhMYkefpKmLBwWMMWLDvcdBMHp0/vJI5H2frn155n2mSFwDvdHHnrKIjKOKOahrvHALp2xsYkbB9yp63oBCV5u7bigWweJhTm+e5e7GBxozIgKVXWz/tFkKpFK+dXTuF6D2xPthFf+WfaaxLZKQng0Bc2H9K9iY6a1xj/12pFgyHKgao3EtjK2+42UElXsH7VPODjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FZd7Pv1LjCQpx9jbF5ry2VRuMNChxkm+RVEcrofDcE=;
 b=zIoPODZ28I2hDJLT32LQZsYfsspo7COk/VAbwClNK63SxRggDv6Ma0t47yzAmCMWxlegKfMSvKiTbQ9j8iVfXP6jr8ipbdgkC/qtO8g3hxQer4SDwfEIYSUb88nqjtvNuvQM9H0LWYYBIppbweG99PzsSMynkV89lNpJS0Y7Z9ROappDSQo4m3BWXqrN3hbTLS/e2Ggt+9b0Mkcl1rRijmQY6jfi/ZJIrWVAdGfTXVaZ6g2Jy4VUkubB8uuAp8TnDnRkhK8QKI7h/XRXxNnuirzYrRRlS7K0YO6zdGX1qL5YqfUzgPBbhbQfe6KbOE2DM8KdmTXsK9TFq9I7f05aBw==
Received: from DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:119::9)
 by PA1PR10MB9180.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:445::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15; Mon, 11 Nov
 2024 08:25:33 +0000
Received: from DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c697:dfe:4400:dd6d]) by DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c697:dfe:4400:dd6d%5]) with mapi id 15.20.8158.013; Mon, 11 Nov 2024
 08:25:32 +0000
From: "Leto, Enrico" <enrico.leto@siemens.com>
To: "hs@denx.de" <hs@denx.de>, Fabio Estevam <festevam@gmail.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, "Schweizer, Walter"
 <walter.schweizer@siemens.com>, "Sverdlin, Alexander"
 <alexander.sverdlin@siemens.com>, Anatolij Gustschin <agust@denx.de>, NXP
 i.MX U-Boot Team <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>, Tom
 Rini <trini@konsulko.com>
Subject: RE: [PATCH v1 15/22] siemens: imx8-capricorn.dtsi: small adaptions
Thread-Topic: [PATCH v1 15/22] siemens: imx8-capricorn.dtsi: small adaptions
Thread-Index: AQHbMZ4qB2uCVobT1U+Kqq0ZGhNWW7Ku23YAgAK9HACAACNJYA==
Date: Mon, 11 Nov 2024 08:25:32 +0000
Message-ID: <DB8PR10MB3737C4C148FDD4045198C460FF582@DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM>
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-16-hs@denx.de>
 <CAOMZO5D77WPgrjXXyBzk-rAApcqxfSS7nZCF8usz2jj_oF1QpA@mail.gmail.com>
 <4dadf359-8113-08b7-f198-42a2111cef81@denx.de>
In-Reply-To: <4dadf359-8113-08b7-f198-42a2111cef81@denx.de>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=87f0b84f-7957-4905-9c2b-71fe377bad04;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-11-11T07:58:51Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR10MB3737:EE_|PA1PR10MB9180:EE_
x-ms-office365-filtering-correlation-id: 956a7cc0-e85c-44e6-96e4-08dd022a68ee
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VEdpZHE3Wk42YUNDWkZDT0xBTCszQmNmVmZJazl4VHEvSmxyNFo4T1F1TVJR?=
 =?utf-8?B?T0Y0K0JTVlVHekNoM3hXTjlCYVhzdnJyV1NRVS83ZyswMXdncHpGY1BJNTMr?=
 =?utf-8?B?ZkpQTU83b2EvMXNXbVhrMnNHL0NCdjdXL0RMdVhSV1JDN3ZONml3djRBZXhW?=
 =?utf-8?B?S2pJRTlZbll0WUVQU2Rhb0xtZ0xvYmtKazJCNTVLUFQ1aGh0ZVdiVU9WZ1Vk?=
 =?utf-8?B?UWNyMHZpWnRoanRuZllsZWJtc1lIOStlZURkWmc3VEJXTGkyWURINGNFdWx6?=
 =?utf-8?B?WU1XK2JMd3ZPZHdoTHJKNHJLS2laODgvSVJsZDBXRUpaMm95dTliVFVlZ29I?=
 =?utf-8?B?d1ZXa2FJSkd4Q09UOVhjVlpQNVZta3VhOFc3WTZmaCs2S2J5akpqakJ0bnU0?=
 =?utf-8?B?V1VhOHRnWXFZOC9qeDUzVzZqLzBOYy91NDJ1SmVJcmFuaTBuZGNZTHd4WXV0?=
 =?utf-8?B?OUVFSER3UStScTFJL2NLcU9HRjF2T1BpRmJ0UDNMeEQ5WkRSWWtJNkdLeHN5?=
 =?utf-8?B?dmw5SDFWV0JZSHFlSHhPOW1jNk0vbFZnSGJGcDhpY1piQmtwRDE1WXRTN1da?=
 =?utf-8?B?VlI1Uk1TclNOYUV4Um5ndVkwT1dsQy9JOGV4YWxNdnBnMVBudDZvd01tbDAv?=
 =?utf-8?B?R1dNSWo5Qk5IQng1Ti9lTnVGY0plUkhHTHNkaVEzU0RyOEVMdjc0aEZpNlND?=
 =?utf-8?B?cWpDYk9JenE4dHhFaFpwL1VnVEIwNkUwKzlLaGI0RllSR01LazFvbHVuQ0lE?=
 =?utf-8?B?OXVURmNxSGxqdUZSbFoyakRxcjhtb1QweWxvd1l5eldXNkQ2M21UeHFrODJk?=
 =?utf-8?B?YkFqMUZGa0crZ0FxR1dwWnI4U2lwYnVsSnZJZ0Ftd3E0SEJvU2RLMVpTT0do?=
 =?utf-8?B?MGhGeEJ2N0dlVU9qVEpvKzdVZGsrT3ZZb3RESU5OdEFyMk5NK0Jncm1JTGhr?=
 =?utf-8?B?KzZBSnBzMDJPbnlsR0lNR296Q1FGK1d1TWU3M1JJZUdFcHVzQnplUG83WEU3?=
 =?utf-8?B?cGR3anhNblpHVnNIU20vNFVxRlIvUXp6NEtOMWdQNkRYNUs4YzY2OTM5ZGFS?=
 =?utf-8?B?eGlPWGoyRjA1VjZMaDd2ZFViOVV2clkzcFFNUzhYbXRheXR6WDJQMXhkNWpx?=
 =?utf-8?B?TC9nZ3B4OTJRamJHQVdNQVhLS0s3MFYwekpld0g1N1Nqb3MyeXdwbm1yRDl4?=
 =?utf-8?B?a0dPcUsrNFJsTjdqZjBTV1JuRHBPbXozTmU5cVdOL1orTkRBRUtMQXJYYzBK?=
 =?utf-8?B?d2dJdm02WDFsMVJleVFReHJGZGhLRkhSMWd0WFRzVmFFOHM4NTZxc0x1Szhp?=
 =?utf-8?B?azZ1ZCtjTVV0U3NaNmtycmZZZmNOeEdndzVnd1RIYU1lU3Mra2VLVHBZSmR0?=
 =?utf-8?B?ZDRPbkU4MGlDQkd6SFFlNnFGUnJldzRoVkdRckR5dXJzUUQ1YnBsOHZsaXRq?=
 =?utf-8?B?OEpIVmoyK1NsTjJQSkcvUnpFajZWVHEzby8rYjEwRE1id2RRdWwzSnZzTFRw?=
 =?utf-8?B?a0JiVlI4UzRzTEhveDZzM2pJaExQN3JWZUl2NkpZajYwY2szWkVLMXpBZFRI?=
 =?utf-8?B?Q3BpaGhyTm0xeDlQVXd1WEZyOXYyYjl6QVpnWHYxYVgwV1doOXlzMUlCRHVj?=
 =?utf-8?B?UUowV2t2SXhBdXFyK3NwRDZINkJlOUpkeXZqQUZiK2c1TWx0Ty9rakcwMkJy?=
 =?utf-8?B?UGFOSGxkMlBweU1FVkRPcktqUU9NRDdjUUxwd0JBZ2hQYm5OdFJEUm5iNFVG?=
 =?utf-8?B?dmxGY2xKK09CYjZyb21WNGR4aVlYbUhpV3A2aDRPdjlXWk9GclNWOWtoNGZV?=
 =?utf-8?B?QnBoblFIVTkwRENJOHU4bmV2bmJFRTNUUVlhUVZBYlB4WkNKUERmVHh1ZU42?=
 =?utf-8?Q?hX3ZuLh5MV5En?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2FrSVZjSkppSzdZYWNXL2c5L3RWSURPM1V2bS8xb3g5UG1PbDZObllXbjJL?=
 =?utf-8?B?djI3VVN2dnNnb2kzVlQxdHZRUzh1Qkc4aWhRencwTTlFSDFpNWdidUNMa0JX?=
 =?utf-8?B?LzN4TkR0TkViY1dMT3VpdWZxSW1ZUi9ubkxvK25zMlhabjdSL3dQbHdKRVpr?=
 =?utf-8?B?RVZpU2JZQTVQS1VTekxHZVpXRm8xenpVUWVwdEJqdlFXcG1HUnIvTGFvRzMy?=
 =?utf-8?B?QVdNVGJjOTQyK0hXVUMyWWptaEpadlRINGM1SXByVHRIZTRmL0J4OGdEcGd2?=
 =?utf-8?B?L1Zxd1JCdFRIVnh6OE9RK09rVWpRd1o5dy9kM0dTQW1PV05nN2lmRHZ2bk84?=
 =?utf-8?B?TUREWnZIYWFWcHFhbFpFNzJjdWtndzZHM2hDSWxlSnFXc3M1bWpKYmxrWU9r?=
 =?utf-8?B?WmVRYU9nK3FOcXRmZWJPenFaS3Bhbk9KanZLV2lyVVZ6anZqdTIxcUlqSGFX?=
 =?utf-8?B?SjhtTTRPTUMrOUJMMHlyNkx1RnQ0ZHJjaHFqQjROWjJlUXVkY3llQjUvQXha?=
 =?utf-8?B?QWE2Z0dwcmFjaDJGMnk4ZStYQ0RjUHdmamtlZXFDNURzRnJXbTREZUZCanh1?=
 =?utf-8?B?ZmJ1M05FMkVId3F0ZTBGL3J1ZWpCTzQ4d2tWbVRERFo3VnMxdlZtbyswVE0y?=
 =?utf-8?B?ZDAxcGJUVGlkbnkwdkRla2xJamNaSFVVQmFTTXc0YittN216K0k5Y0hoZUVj?=
 =?utf-8?B?cnd4MVFMVHhUazNmSnAwcVV4dzdOdURLSE5pMWdpK2xCWmlNM2MxekZwUXRJ?=
 =?utf-8?B?cHkrYmk3aWdSMkxkeEtqYXJDMTFPQWdybFJEUWEvVWF0ZjVFREFVR3AyRVpE?=
 =?utf-8?B?R0RBVGVGcnF3Y1F5L0d0VEZ6TkNnbThQWnNlK2NCeEc5dEMybWowZGVDOHp1?=
 =?utf-8?B?Yit1SWkyM0dZYktPM2hXcFFNb3M3QXR6R3RqcFNHZHVXeDFxM2JMUFd5ei9D?=
 =?utf-8?B?TlpKcEZLdEdlYVNJVGJNczRIWks1SGNuQ2JzSjlPUG11TDg5RHVlQVVrdHZ5?=
 =?utf-8?B?YXVEYkovVlNMUzQxVE9EdFNqRzJmOW9FZW1pd1FPVmxUblptWC85VERTSmtZ?=
 =?utf-8?B?TUpPcElxOHFYRDBwaGNBUzRmL2lMTjlxd0l1UEsvTUg4cjdlYkhocDAzQzlT?=
 =?utf-8?B?Y1NjYmJLZitSNDY2ejNKWUFmazhKNitHUmFDSFVaeGU2TkkwaDBSZGtOckZo?=
 =?utf-8?B?K0VKV1M3cnlJd0VXNzBrdjdQbXBXODRULytsTEZOejJpYTVieFY5T2I5aXkr?=
 =?utf-8?B?UEhvVUltSmxhMDlPY2Y5RkVKZjRHWW55UU5qWW9vcGQrSCtJSlU1NTJCRnBt?=
 =?utf-8?B?N1JMUnkyS01vZ0FTSHExVzhueWNBeW1xc0dOVzcxUWZCeDB5NVVOa29rN0Vy?=
 =?utf-8?B?TEpTMGxuSDRhaE1oZWR6Y2VlaE9ENmNVSVpWZHMxbjNEOHBsS2NWVDV0aEd6?=
 =?utf-8?B?TEdyM0lULzMwVXBmeWNFUVFzeTBHQ1M0NWIveWhTUnJ0eTdMb24rYm5QOENz?=
 =?utf-8?B?UTlrUlpoM3FzSlJqNmJ0YytpdFpLWmRNbzlRRmYrbFBuZzNoZ1R0YzI3MWtn?=
 =?utf-8?B?Umw0R2JPNXJKZ2xrTFlmbGU4VldqMFRpUWdwdmFQSVNyYVpIa0FBeE5PL0xN?=
 =?utf-8?B?SjhPaUU2MWpDckFkMW43WUlQK2kwYUNsUzhMdTIyN1J2OVMrVmFyaTlKcHFH?=
 =?utf-8?B?Z1FPOXFmbnFDLyt4TE0vRzF5SVlpemVtMDdhS1gxN0FSbEcxdy9rQzFHdlRN?=
 =?utf-8?B?bE5YUDdTeENtTXdGRGRJdlZacGxEdlQyOCtjbVRZZzlRU1poaXo4anFRMUpM?=
 =?utf-8?B?SEVoQitXSi9BWkplcE1TMyttRXRPb3ZFVldzZnhzV0lSblFJNm9WeWFaRGkv?=
 =?utf-8?B?Z1ZSQnNZUjJhcFVpUFNKOWVmclV2SjBuMDcvV3pKTEVyTGNoZzhHcnRYaStB?=
 =?utf-8?B?N3BGY2VySDVVQjJTL1l3d1B0Y3pqR2pMT1FoK1dGS040U1QwMWtvdzZPTWlz?=
 =?utf-8?B?S1VqSi9QQ3UxdEIxQkRCdERDVW9Ealh1SHExR3hjSnpReStoeVJPVGU3eWZZ?=
 =?utf-8?B?ekg1UkpscGVnRU1aZEZGUDJOdy9LWlpTLzZIR0RCaVN6MXhkZDJyWFdRNFEr?=
 =?utf-8?Q?AiO73HNnldZfRLAoC3PLVEho5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 956a7cc0-e85c-44e6-96e4-08dd022a68ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 08:25:32.8655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jcJ1RgOZgRBM0Fez1rMbPZc8tRzvVsq06syLVjHHaIyE5ZOLaNS8VbKnDfPpsuhZNnqR5T3YrYKHlS6dukT18Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9180
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

SGVsbG8gSGVpa28sIEZhYmlvDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogSGVpa28gU2Nob2NoZXIgPGhzQGRlbnguZGU+DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIg
MTEsIDIwMjQgNjo1MyBBTQ0KPiBUbzogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29t
Pg0KPiBDYzogVS1Cb290IE1haWxpbmcgTGlzdCA8dS1ib290QGxpc3RzLmRlbnguZGU+OyBMZXRv
LCBFbnJpY28gKFNJIEIgUFJPIFRJIEVBQw0KPiBDQ1ApIDxlbnJpY28ubGV0b0BzaWVtZW5zLmNv
bT47IFNjaHdlaXplciwgV2FsdGVyIChTSSBCIFBSTyBUSSBFQUMgQ0NQKQ0KPiA8d2FsdGVyLnNj
aHdlaXplckBzaWVtZW5zLmNvbT47IFN2ZXJkbGluLCBBbGV4YW5kZXIgKFNJIEIgUFJPIFRJIEVB
QyBDQ1ApDQo+IDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+OyBBbmF0b2xpaiBHdXN0
c2NoaW4gPGFndXN0QGRlbnguZGU+Ow0KPiBOWFAgaS5NWCBVLUJvb3QgVGVhbSA8dWJvb3QtaW14
QG54cC5jb20+OyBCYWJpYywgU3RlZmFubyAoRVhUKSAoREVOWA0KPiBTb2Z0d2FyZSBFbmdpbmVl
cmluZyBHbWJIKSA8c2JhYmljQGRlbnguZGU+OyBUb20gUmluaQ0KPiA8dHJpbmlAa29uc3Vsa28u
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDE1LzIyXSBzaWVtZW5zOiBpbXg4LWNhcHJp
Y29ybi5kdHNpOiBzbWFsbCBhZGFwdGlvbnMNCj4gDQo+IEhlbGxvIEZhYmlvLA0KPiANCj4gT24g
MDkuMTEuMjQgMTM6MDMsIEZhYmlvIEVzdGV2YW0gd3JvdGU6DQo+ID4gSGkgSGVpa28sDQo+ID4N
Cj4gPiBPbiBGcmksIE5vdiA4LCAyMDI0IGF0IDI6MjLigK9BTSBIZWlrbyBTY2hvY2hlciA8aHNA
ZGVueC5kZT4gd3JvdGU6DQo+ID4+DQo+ID4+IC0gcmVtb3ZlIERNQSBmb3IgY29uc29sZQ0KPiA+
DQo+ID4gV2h5PyBEb2VzIGl0IGNhdXNlIHByb2JsZW1zIGluIFUtQm9vdD8NCj4gDQo+IEZvcndh
cmQgdGhpcyBxdWVzdGlvbiB0byBFbnJpY28uDQoNClRoZSByZWZlcmVuY2UgaW1wbGVtZW50YXRp
b24gb2YgdGhlIGlteDhxeHAvaW14OGR4IChtZWsgYm9hcmQpIHVzZXMgbHB1YXJ0MCBmb3IgdGhl
IGNvbnNvbGUuIFdlIGhhdmUgdGhlIGNvbnNvbGUgb24gbHB1YXJ0Mi4NCg0KR2V0dGluZyBhIGxv
b2sgb24gTlhQIHUtYm9vdCB0aGF0IGlzIHRvZGF5IHRoZSBiYXNlIG9mIG91ciBjb2RlLCBETUEg
aXMgZGVmaW5lZCBmb3IgbHB1YXJ0MS0yLTMsIG5vdCBmb3IgbHB1YXJ0MC4gTlhQIGRvZXNuJ3Qg
dXNlIERNQSBmb3IgdGhlIGNvbnNvbGUgYW55d2hlcmUgZm9yIGlteDguIEl0IHNlZW1zIGl0IGRv
ZXNuJ3Qgd29yayBwcm9wZXJseSB3aXRoIHRoZWlyIGRyaXZlci4gRm9yIHRoaXMgcmVhc29uLCB3
ZSBkaXNhYmxlZCB0aGUgRE1BIGhlcmUuDQoNCkdldHRpbmcgbm93IGEgbG9vayB0byB1LWJvb3Qg
dXBzdHJlYW0gSSBzZWUgdGhhdCB0aGUgRE1BIGlzIG5vdCBjb25maWd1cmVkIGFueXdoZXJlLg0K
TW92aW5nIHRvIHVwc3RyZWFtIHdlIGRvbid0IGhhdmUgdG8gZGlzYWJsZSBhbnltb3JlLg0KDQpA
SGVpa286IEkgcHJvcG9zZSB0byByZW1vdmUuDQoNCj4gDQo+ID4+IC0gYWRkIHdkdCBkZXZpY2UN
Cj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogSGVpa28gU2Nob2NoZXIgPGhzQGRlbnguZGU+DQo+
ID4+IC0tLQ0KPiA+Pg0KPiA+PiAgIGFyY2gvYXJtL2R0cy9pbXg4LWNhcHJpY29ybi5kdHNpIHwg
MTYgKysrKysrKysrKysrKysrKw0KPiA+DQo+ID4gQXJlIHRoZXJlIGFueSBwbGFucyB0byB1cHN0
cmVhbSB0aGlzIGR0c2kgYW5kIHN3aXRjaCB0byBPRl9VUFNUUkVBTT8NCj4gDQo+IEhtbS4uLiBn
b29kIHF1ZXN0aW9uISBDdXJyZW50bHkgd2Ugd29yayBvbiBVLUJvb3QgdG8gZ2V0IG1haW5saW5l
IHJlYWR5DQo+IGZvciB1c2UgaW4gcHJvZHVjdGlvbiwgc28gd2UgZ2V0IHJpZCBmcm9tIE5YUCBj
b2RlLg0KPiANCj4gSSBkbyBub3Qga25vdywgaWYgd2UgY2FuIHJlYWNoIHRoaXMgd2l0aCBtYWlu
bGluZSBsaW51eCB0b28uLi4NCj4gDQo+IE1heSB0aGUgc2llbWVucyBndXlzIGNhbiBhbnN3ZXIg
dGhpcy4uLg0KDQpIZXJlIHRoZSBjb21taXQgImZlYXQoc2N1X3dkdCk6IGFkZCBvcHRpb24gdG8g
Y29udHJvbCBleHRlcm5hbCB3ZHQgdmlhIElNWDggU0NVIiBodHRwczovL2NvZGUuc2llbWVucy5j
b20vY2NwL3UtYm9vdC8tL2NvbW1pdC9hNWI5OWQxYzQwNmZkZjkyY2QxZDdkNTBkNTY2YTRlMWU2
NmM0NDdiDQoNCkBIZWlrbzogQ2hlY2sgaWYgd2UgaGF2ZSBhIGNoYW5jZSB0byBwdXQgdGhlIHdo
b2xlIGNvbW1pdCB1cHN0cmVhbS4NCg0KPiANCj4gYnllLA0KPiBIZWlrbw0KPiAtLQ0KPiBERU5Y
IFNvZnR3YXJlIEVuZ2luZWVyaW5nIEdtYkgsICAgICAgTWFuYWdpbmcgRGlyZWN0b3I6IEVyaWth
IFVudGVyDQo+IEhSQiAxNjUyMzUgTXVuaWNoLCBPZmZpY2U6IEtpcmNoZW5zdHIuNSwgRC04MjE5
NCBHcm9lYmVuemVsbCwgR2VybWFueQ0KPiBQaG9uZTogKzQ5LTgxNDItNjY5ODktNTIgICBGYXg6
ICs0OS04MTQyLTY2OTg5LTgwICAgRW1haWw6IGhzQGRlbnguZGUNCg0KVGhhbmtzLA0KRW5yaWNv
DQo=
