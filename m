Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3256FCCF9EE
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 09:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9074C8004F;
	Wed, 29 Oct 2025 10:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BWb1ZVto";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C5F78006D; Wed, 29 Oct 2025 10:08:56 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 223AD8003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 10:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWxtpoRoYhHWsoJeMqj54RhQc1EwOhw2VPa3Jr52cXOu6YRA3F2tB2sgOWqMxJ0iQFMrzcDDEEQ+BexpNuoUGAkZThO/bMs+nqoI798+nk5jkaStwbzklhrwVVXej9HIEcrJVDDuFXTgOMMsfF/waY/5iBR/JmdFRjg4RZvDhXNaY69Wt5HUSymk6nytuyNrElAnmV2LZyROWHJGn+JZlhuXjxaVOMSse6LniplDPEfHNbYHEjCd8T6Fz51GVJibkzgLa27yJSQtNJbN5CwsaHUZUA+ZkkDhLpjWyoyPcZo+cz1WuznfGLw+15ydEzz2ny/5bVyNQKoW3GGqKDCDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOmjGOIEcsHthLukPonFP3cs8qGM2OZ9Tj2wbBRM1Fc=;
 b=y5GeTd1JswmexLw0RwcAah6Q17ASEzb2QV4UL9eR7VSEUhhWK62hc4brk8Zg4xDJYDPKRnwM8SEJj+nhBgB6frmFxiUMHvvokbYS/Q5E9sn3oeNVqiK39WUqYVBU8siQf9K7Q7fj/OFtYf22uTbwl+I8WUlCRLWTm/nunFyAh10ZsVbgrTjbzEXpvzIRI8rZ0DjCIUso32FxVkMCJwwmTiJ0W7aadrJP3Z4ZSZzvfR/noAXdZLEeaXUxJW3h0Icf5xJ8899AYVGcYLvw0hrZjlybIz9mutYluhGZTHtpH9i+F/VXTjAXzGpHUvoAleZVv1BUExXX/0socsQys0xtEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOmjGOIEcsHthLukPonFP3cs8qGM2OZ9Tj2wbBRM1Fc=;
 b=BWb1ZVtoEZTwGRKxYYm+87zvqDWsw8GaXwYocGZ20rpclRPOARkbBnU2clAjh0p+RPFXZvyDu+F2biwoZizK/TxdFqWhhYf92gLCLDrUuiktkxWWxJWmdQ/2NsUS73ulqNNx5TqcHASOs6ThtD6lU6X9gDRrtajkRO5EForkqb2HU0y1ETiLYgvKUo0eMi+Bl83oacCNFRe52a6cAIJR1tb59bmrnnt90H5bX5z2aVLelwoegXllVb1sCfSnBaXNgr/T6fVMuk7BLKlp2kjlnqBEoVQ4KwJRRHugkNgbHVlrWyFE3ABxlDf9b89/0Q4lJf7W+V58Njb1/FvoS+RX6w==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8434.eurprd04.prod.outlook.com (2603:10a6:20b:406::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 09:08:52 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 09:08:52 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Alice Guo <alice.guo@nxp.com>, Jamie Gibbons
 <jamie.gibbons@microchip.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng
 Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Tuyen Dang
 <tuyen.dang.xa@renesas.com>, Viorel Suman <viorel.suman@nxp.com>, Ye Li
 <ye.li@nxp.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBtYWlsYm94OiBBbGxvdyBvcGVyYXRpb24gd2l0aG91?=
 =?gb2312?Q?t_.recv_callback?=
Thread-Topic: [PATCH] mailbox: Allow operation without .recv callback
Thread-Index: AQHcSLOkKDrF76PzxUGfQp02qYIsag==
Date: Wed, 29 Oct 2025 09:08:51 +0000
Message-ID: <PAXPR04MB9644C1407BFE6DC0E7EE1833E2FAA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251027163904.11814-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027163904.11814-1-marek.vasut+renesas@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AS8PR04MB8434:EE_
x-ms-office365-filtering-correlation-id: 2eba6ed7-e0d6-492f-55bb-08de16cac779
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|38070700021; 
x-microsoft-antispam-message-info: =?gb2312?B?Unk2WS95Z1FwSGlSampqTFdwZHNlMWx5T0hwNkErYWZKRnU5QnFPU1hnWEgw?=
 =?gb2312?B?RjY3M3NLSmx0Z1ZDNW8rQ2RwbUQxRkNxZXJhUC9pTE1sNWFWOS9jNlhFM0lp?=
 =?gb2312?B?TDc0Z0NZbk12SnAwbFlvenQrMFlVZ2o1UmY5RzJtWWFobmNtVWtuQjNzenFi?=
 =?gb2312?B?Q3gwTkF3MmYxRnF6VXR0SEd1eE16TXFCYngzRlNsOE5ER254M0pQcTFDZ21s?=
 =?gb2312?B?RTRPNm03OUJDS1BhSzJTWGwxa1dtSTNsRWpoM2lNWGFIWXVVaVNOQkk4V1A0?=
 =?gb2312?B?TnE2bDhVWmRjZzRGcVd2a2FVU2llYVlIaEJvelNxRW9xcXhlZlljRGFIakRm?=
 =?gb2312?B?VVd1QXlrQlFQTUZoMWdDblQ5SU1NSzR0KzduVmZDY0N1blYrQVJ3OXNGOVBN?=
 =?gb2312?B?ZzhWT2V0SzE4RXgwRHRYcHdNWDZDdzI4N1BSQ0lUWWl6dHgzSy8za0kzV0JK?=
 =?gb2312?B?S1Z3aXVlYldRdEdDb0kvS3FnOEVzbW1aWW1rTmNsT1VzaEtxRkFmNkNaemt1?=
 =?gb2312?B?cUVIOVVSYWhJSStGK1NSanJObnA1Q1hBSDY0eGxMdkNyOVhkMExuNGdXOVkx?=
 =?gb2312?B?eVluMjM1Qlg2WGNUR1BHSnZUbm12OW5qVTJabTQrYjBpVHlvbVdvMDBrYVFp?=
 =?gb2312?B?WmJVTVJNRmdtVU8yaDIxUlB2eHE3T0swSTFhRS9PU2V5OE5WMm0vcTBrZGx4?=
 =?gb2312?B?TVB6eW1sQ3ZlZXFLUDltdGpPQUtTMWZCa1R3TzQrd1RBcDE5L1JlYURwUk05?=
 =?gb2312?B?YmIvUHhrc3FyYVk1Y0hxT1RuZTZjM2kycUlEREZoYTA5emtOaFUvaUEwNnB1?=
 =?gb2312?B?VzYxZkxuZHBKZEJ1WjFsUmRsMEFKaThmK3lZcmJNdjQ3aGVnZ0JUeHVjK3Za?=
 =?gb2312?B?NGdReHE3eU5qVVdEVldRS2x6NVVxNnI2VTVXOGcrZThLa25wMDRRelBlL0lV?=
 =?gb2312?B?SzdramxkUVc1MTRJUm41U25XQUx6akdLK2RaN25QY0lZd0MvcjN0cmRmcGIy?=
 =?gb2312?B?NXpwNGhIRkVsNFBJMjZZejdhRnhNRnhhbFVwbm5CMjVUQS9WTVhBdHczTnZC?=
 =?gb2312?B?a2xBOG5sOUdEVllSRnI3ZHdIM05iV1h0cHI3ZEZRaW9NVXYvY1dPeVBkaTV2?=
 =?gb2312?B?UlhtcWN6RmVEbmRaMExuVkZUUEh3dFZuWmNHQk80SWt3YnF0b3JYSTZjSlVo?=
 =?gb2312?B?eFZjYmtab1V6Q2FEbVpMR3FYTnY0WTlGVmpMcS9STUVDVms2eXNpeW94Z1Jz?=
 =?gb2312?B?TnQ0cGlkeEd1RWpFRy9UVEIyd2RZNFJnYm0zMm1tTDlRQVUvZGNrenk3cEtK?=
 =?gb2312?B?ckhvRmQ2S0FFTmcyMW50SmJKWkVzTXo1YmFzQlB2dkN5QklWSVZlQVZVZGdH?=
 =?gb2312?B?MUZCamtIaTJJa09EMk1XVjFReTNHcUQ1eWJrWG5IOGxiMVI5NVRtWkZ1cmlj?=
 =?gb2312?B?eDVTbG1xR1BLVDFuRHhDZ2NQVHBCUG9GUjYzTmFrM2czQ3dHU01sWDVqcnd0?=
 =?gb2312?B?Q1k1aHlDSHl6ZWRMZFUyaXRVcjhCRWppZXROSXNodHFYcExPTXl4YlpUZnJ5?=
 =?gb2312?B?RXd2dm9hWFlKcG1PMU5kSXJUSU5tOEZYRmYzaFVJSmZDd29JQjgzNHBqL0xB?=
 =?gb2312?B?cTFLOFBJUEs5ZTI4dGV4VUFKbEFOVENvaDBRdjdFY1ZEdU54RVF5bTVRSFV2?=
 =?gb2312?B?bEJWYm9IVkJ0dWdtRjZHUXJlRVM2VkhNZzhPd3pzYTh6bFJ1WURoNm9sbVcv?=
 =?gb2312?B?ODI4RTVDMnUwMzNoYjBRSVRvajk3Z2ViUkMxQXlteHQxaS9WTkFja1Jnc1Jy?=
 =?gb2312?B?Vmw0ZW5UaTIxa0xVQzBiRThxMG02K3pzcjNWNW4vY0xQU05XWEJUclVJNDNo?=
 =?gb2312?B?M1V6YVU0RjZhVmNvdkJDbXN1a1o3dHl0eHlBeFJiTEVNU2JaalowWUFRcTd1?=
 =?gb2312?B?VVBLWTVGTHUzZWtUYWJYTEp0US9DZG0xRUZLNFdQbWNOSmVIMmZUdzRlSFcz?=
 =?gb2312?B?RGttRjIvU2VyaUZEajBURGdHaEJKNzExU1FoNjNkMnB1TFFUNDZqVXJKcFNH?=
 =?gb2312?Q?a7mjiP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Rk10bjV5bFpjWVhvUy9QMmNFT3VydHdoYlFZb2F0eDJkdGlYaVZ6VWlSbURM?=
 =?gb2312?B?Um9Wd0NwZUUzcXFqTkM4dnd4RWFnRGtVYmtUWkhLYmNhVWhIZ1ExalZuTWxX?=
 =?gb2312?B?TWNiUTJNcFdZVEViWmh4ZFJUc0o4bE1va20wQStrMUJuZFl3eHFFK1dXTFFX?=
 =?gb2312?B?NWVLSlVhMUdJbVliWnBvR0JxSjhEUytnWld1MU1GVGh5V2luVFprdzA5RUxZ?=
 =?gb2312?B?em5xaUxKUWhKVitGL21DNkxRbTE1cTJNVVVQQTdTenlicXBNUVQ2M3hEZXJp?=
 =?gb2312?B?NlFONjdkT3dadzBLc0RRZ1NpQWQxMlMyMGkxVmx3MzFGcnpSelBMdU9rd2ZM?=
 =?gb2312?B?NHVTdzcycnprQS92bEs5eEJXMWxqVkVOemtZeHZUamZZalE2YS84NUtWMFhp?=
 =?gb2312?B?YWJ3SjVudTMwdW1KcWZ3NktGc2NWeEI0TEpwYzEzdWpqR1hyU29GcHEyRFU1?=
 =?gb2312?B?Rk1XODNWNzN5T1oreDRwL3BWZldKS09xNGhJb0M5WTBsSFFleUZqVjRtMFV5?=
 =?gb2312?B?MGl3c1Y0eDBmUGJtM2ZCRkRhdFc1ZVB0OURhN0lmQVNlK2pNUlBBcXdscG04?=
 =?gb2312?B?bSs4bVdFTUVmaUxTYW9TRmQ1STZTSDVLSUtOVXJzT2xhVkxtUlU3ZTFRUlZv?=
 =?gb2312?B?NlI5dEQxbHRSTWJkTmNIRE8wYTk5aWZGelFQYktRUStyMVVHd1ZyY05QMTll?=
 =?gb2312?B?WUZsN2tITjZPS1ZRNlhkMW92RExzK0tXSEgyTzlwR1NVV2M5UjU0RUtYWDEz?=
 =?gb2312?B?RUZpd2xlWFp0TWtRZVlOUExtdFRHTzJrMCtaUGJzYTRZZDBIeERmZWNPSkhy?=
 =?gb2312?B?VFlsa3MvRjU5RHhZdC9odFJKSkVmWmRlVlFGcUhkVmtWa3VWMXZRRVdTRVBX?=
 =?gb2312?B?ZmhmYjBpbGJETVFkVWgzeTN2YXVVbFFrMDFVOXljUVJkQ1pxS3U5UE5ROXBw?=
 =?gb2312?B?TVkxNExXWkZGV0J1dCtkcUZSaHVzTEkvMlF0VUlhVUZ1c2VuYlhrMTV6bVNp?=
 =?gb2312?B?ZXJnUW51OUtRcGJwS2NGbitPQnpWaWNhMmQvMHVFSXBHSUVFWDhzcjZCc2hT?=
 =?gb2312?B?bVF5cnBpSVREdnBoT0VtQVJkTitFYk1DRWE0YVNsQlN1UXpvd05mOURlQVdu?=
 =?gb2312?B?WlhOL09zY2tjRy9sOUlTYkg3ZnZlb3ZGaVd3NHdyUFFYY0d5S3dsOUl2MkRQ?=
 =?gb2312?B?S0hKU3VJSVJGRFlzT3l6WW54VVhEUmhpTXNiSFp5OEdVdXNNZHYweExiTHNL?=
 =?gb2312?B?U1NIcThFUUVMTVNFM05qWmRWUFJ1Ym1sRTlBc21mdXduZ3B0UzNIZ0lwNFNT?=
 =?gb2312?B?c0EwRmV2TEZnZlpFSk81cHByNnZUdFZxVkJ4ME9GSWRidWNkcWlsL3NHZGtz?=
 =?gb2312?B?YVBaakd2N3ZxaG1JR1Nwb1FtTGRMZmxlcG5VaVBQRWUyR2ppN2lmZktZemtL?=
 =?gb2312?B?cm8ranFuVzZnNEkwYkhVNHVldERPMW9tRjA2aTQ5Y0RJOXZNUUVPa1QxTmZH?=
 =?gb2312?B?NWtEQ1A2anB1TkZwaXI2Ny9LSzVsS1pwQUZoWFdEd2pUTkhtRWNic1JVRUJq?=
 =?gb2312?B?anlsdWxza1N1cllxT2ZERTlERmUrcks1bFJtdThheWk0SWtXZUxpVHhiUEJY?=
 =?gb2312?B?MG1hWWk2OWNJT3pTRmFsbHN3S1NhMGI2a2RadUR2R2lsUjBvQTc0TjVyMi9t?=
 =?gb2312?B?OGRZYTh1K0FTOWM2b1M3dEhFYXdiOTkyeDI5OS94SWpPamZDYWw2NE1NZmw5?=
 =?gb2312?B?RnN2UUVyWGZheGdhcmIrUEI4enZrcFN1aDZkdm9QUDdIVTc3dW1OUFIzbnVX?=
 =?gb2312?B?ekNwWUkvZmt5cnF1L1R6UmdFcC9vVkgxT3Z4cjVSZDBKUWFxcnVIbTNnTmpt?=
 =?gb2312?B?N1N4N2IyRnJ3K1h1clF5NUlrQVF2QTdzZGV0SUVUYnprNFRUeWFkZ0wrSXhW?=
 =?gb2312?B?eWtkaXNRc3FlZ2k1Rm01R0FWb0dycndXTjRCWENNRVBUWCtaZlVwWWpkOVp0?=
 =?gb2312?B?VVc1WW14WXIzZGpHVGJHdHQwajE3SW9DUkNzRWhGSk5sVHlCWXBVNHpUOExj?=
 =?gb2312?B?SGtSdWQxeURnMUJEMzl1dzg0UWNGUVVqeVBJb1BQOEsyV2ZPeFp0T3B4N3Vs?=
 =?gb2312?Q?6u80=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eba6ed7-e0d6-492f-55bb-08de16cac779
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 09:08:51.8868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RVzTpcGYWW2Ejl99r1E/t+OfbVhfN+xHjC5aESyNqfGyDVoMntrYcSiEt3q1WFXjef5W1VSJsAC0Vw9WypG9Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8434
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

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBVLUJvb3QgPHUtYm9vdC1ib3VuY2VzQGxp
c3RzLmRlbnguZGU+ILT6se0gTWFyZWsgVmFzdXQNCj4gt6LLzcqxvOQ6IDIwMjXE6jEw1MIyOMjV
IDA6MzkNCj4gytW8/sjLOiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiCzrcvNOiBNYXJlayBWYXN1
dCA8bWFyZWsudmFzdXQrcmVuZXNhc0BtYWlsYm94Lm9yZz47IEFsaWNlIEd1bw0KPiA8YWxpY2Uu
Z3VvQG54cC5jb20+OyBKYW1pZSBHaWJib25zIDxqYW1pZS5naWJib25zQG1pY3JvY2hpcC5jb20+
Ow0KPiBOb2J1aGlybyBJd2FtYXRzdSA8aXdhbWF0c3VAbmlnYXVyaS5vcmc+OyBQZW5nIEZhbiA8
cGVuZy5mYW5AbnhwLmNvbT47DQo+IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBUdXll
biBEYW5nIDx0dXllbi5kYW5nLnhhQHJlbmVzYXMuY29tPjsNCj4gVmlvcmVsIFN1bWFuIDx2aW9y
ZWwuc3VtYW5AbnhwLmNvbT47IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiDW98ziOiBbUEFUQ0hd
IG1haWxib3g6IEFsbG93IG9wZXJhdGlvbiB3aXRob3V0IC5yZWN2IGNhbGxiYWNrDQo+IA0KPiBT
b21lIHNoYXJlZCBtZW1vcnkgbWFpbGJveGVzIG1heSBoYXZlIGVtcHR5IHJlY2VpdmUgb3BlcmF0
aW9uLCBiZWNhdXNlDQo+IHRoZSBkYXRhIGFyZSBwb2xsZWQgYnkgdXBwZXIgbGF5ZXJzIGRpcmVj
dGx5IGZyb20gdGhlIHNoYXJlZCBtZW1vcnkgcmVnaW9uLCBhbmQNCj4gdGhlcmUgaXMgbm8gY29t
cGxldGlvbiBpbnRlcnJ1cHQgb3IgYml0IG9mIGFueSBzb3J0LiBBbGxvdyBlbXB0eSAucmVjdiBj
YWxsYmFjaywNCj4gYW5kIGlmIHRoZSAucmVjdiBjYWxsYmFjayBpcyBlbXB0eSwgZXhpdCBmcm9t
IG1ib3hfcmVjdigpIHJpZ2h0IGF3YXksIGJlY2F1c2UgYW55DQo+IHBvbGxpbmcgZm9yIGNvbXBs
ZXRpb24gaGVyZSB3b3VsZCBiZSBtZWFuaW5nbGVzcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1h
cmVrIFZhc3V0IDxtYXJlay52YXN1dCtyZW5lc2FzQG1haWxib3gub3JnPg0KPiAtLS0NCj4gQ2M6
IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+IENjOiBKYW1pZSBHaWJib25zIDxqYW1p
ZS5naWJib25zQG1pY3JvY2hpcC5jb20+DQo+IENjOiBOb2J1aGlybyBJd2FtYXRzdSA8aXdhbWF0
c3VAbmlnYXVyaS5vcmc+DQo+IENjOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gQ2M6
IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+IENjOiBUdXllbiBEYW5nIDx0dXllbi5k
YW5nLnhhQHJlbmVzYXMuY29tPg0KPiBDYzogVmlvcmVsIFN1bWFuIDx2aW9yZWwuc3VtYW5Abnhw
LmNvbT4NCj4gQ2M6IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiBDYzogdS1ib290QGxpc3RzLmRl
bnguZGUNCj4gLS0tDQo+ICBkcml2ZXJzL21haWxib3gvbWFpbGJveC11Y2xhc3MuYyB8IDkgKysr
KysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tYWlsYm94L21haWxib3gtdWNsYXNzLmMgYi9kcml2ZXJzL21haWxib3gv
bWFpbGJveC11Y2xhc3MuYw0KPiBpbmRleCA0YmY0OTg3Y2UwYS4uZmVmNDM3YTQyODEgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9tYWlsYm94LXVjbGFzcy5jDQo+ICsrKyBiL2RyaXZl
cnMvbWFpbGJveC9tYWlsYm94LXVjbGFzcy5jDQo+IEBAIC0xMzIsNiArMTMyLDE1IEBAIGludCBt
Ym94X3JlY3Yoc3RydWN0IG1ib3hfY2hhbiAqY2hhbiwgdm9pZCAqZGF0YSwNCj4gdWxvbmcgdGlt
ZW91dF91cykNCj4gIAlkZWJ1ZygiJXMoY2hhbj0lcCwgZGF0YT0lcCwgdGltZW91dF91cz0lbGQp
XG4iLCBfX2Z1bmNfXywgY2hhbiwgZGF0YSwNCj4gIAkgICAgICB0aW1lb3V0X3VzKTsNCj4gDQo+
ICsJLyoNCj4gKwkgKiBTb21lIHNoYXJlZCBtZW1vcnkgbWFpbGJveGVzIG1heSBoYXZlIGVtcHR5
IHJlY2VpdmUgb3BlcmF0aW9uLA0KPiArCSAqIGJlY2F1c2UgdGhlIGRhdGEgYXJlIHBvbGxlZCBi
eSB1cHBlciBsYXllcnMgZGlyZWN0bHkgZnJvbSB0aGUNCj4gKwkgKiBzaGFyZWQgbWVtb3J5IHJl
Z2lvbiwgYW5kIHRoZXJlIGlzIG5vIGNvbXBsZXRpb24gaW50ZXJydXB0IG9yDQo+ICsJICogYml0
IG9mIGFueSBzb3J0Lg0KPiArCSAqLw0KPiArCWlmICghb3BzLT5yZWN2KQ0KPiArCQlyZXR1cm4g
MDsNCj4gKw0KPiAgCXN0YXJ0X3RpbWUgPSB0aW1lcl9nZXRfdXMoKTsNCj4gIAkvKg0KPiAgCSAq
IEFjY291bnQgZm9yIHBhcnRpYWwgdXMgdGlja3MsIGJ1dCBpZiB0aW1lb3V0X3VzIGlzIDAsIGVu
c3VyZSB3ZQ0KPiAtLQ0KPiAyLjUxLjANCg0KUmV2aWV3ZWQtYnk6IEFsaWNlIEd1byA8YWxpY2Uu
Z3VvQG54cC5jb20+DQoNCg==
