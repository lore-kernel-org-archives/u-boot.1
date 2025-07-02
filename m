Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E747C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 03:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DB4A81FEE;
	Wed,  2 Jul 2025 05:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fhzPsiMn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CBF482103; Wed,  2 Jul 2025 05:42:06 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D837A81E13
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 05:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpDzsFjUC+zM5APaRzugZN2meJ2McZnNeQmb54FYArdmnz5cXnE9yGJcgcirFriVQq789NF4iTSXBDwzZE6rlDLUNG8N141/EmSQ0KePjI+XmKctql920Eg3jW5v/mw89qY0w9MYb1o/kSqMhaia4xlv2wJV9yad3vPmvUUFTdviuT3K8Ose02IUkFWmHn1M3sbqweLA1+JWzGdB/4lL4bgn0Zk6BdapDJseBwujX8wAkgUeG3c/q0c+Y6RZ0iZCHdyqBfR4uZhCzBbaNKWpVhvnyD4s1wYFcAZkySMCoWRf3gQuA2rIQMDej6KE1e7hlglUadt04zYd2b4llL0Iig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZPSDkycTm2yTSylDMcaFrEEiR2bNbN+OfvdagFrldY=;
 b=fukZdlmN1nlz2awcxs0NeXs14HQpPfHmhVq5tTqLaHKckutPPnikBBwVfUe7Euy9UGDERYPDUW8DhnIV7Oy0zuBI1WZ0QEGxOQOmsgJdIlFFudSkFrWjPXtY13CQroLgFY4J1E6vtnt/E5VdI73S9qH05xJKZ5YF3MEPETZStUCg9UEO7LEP5QZOwNiUqOYW13IY//MvETAKHRa3/U4TB2WB3weQ7+1OY8ZWzOwvs4PyM0lX6DNLbL+InPq3aLufT2J8DIRpyz2LKTH9+wQZ+DSD4SvMRWMxUR4xHKAXjNg0sX/+ULgOOCJam2vTzLEGfh9nC9E1WMLDasboF0ExTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZPSDkycTm2yTSylDMcaFrEEiR2bNbN+OfvdagFrldY=;
 b=fhzPsiMnU+0o6LG6LnUpeG23XotmSFZc4NaooB+Tr6ID6LvaPrK0Me4Rg2RmYKrLFMUA9JFogM44oKc4/ITmx/Knl3pCPA6DgNKbR3m/YJ8tBDM5pkq7nycZ1Eg0AE56nlE7NwWl94rCE22vG1G3ZK1uz+P/HbxuJYFfj+QzKGaPPlYvoenLrs4sU7IzZF5o3dCS8RhbKfDlL0PktCWSF3exaW7CHcXI38nDJfBnBcMIUn4rInPnyHrsHXuqbNhCpVAPZc5ZtntSO0vXbFhHJnoyy9QLZyGyslsXrHoTNnnZPgKC11MXoBnKi+rTn9Op+M/Rtp1qvlEGKQHppxKUoA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU0PR04MB9249.eurprd04.prod.outlook.com (2603:10a6:10:350::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 03:42:00 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 03:42:00 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: u-boot <u-boot@lists.denx.de>, Fabio Estevam <festevam@gmail.com>
Subject: =?utf-8?B?5Zue5aSNOiBpbXg5NSBTRFAgc3VwcG9ydD8=?=
Thread-Topic: imx95 SDP support?
Thread-Index: AQHb6hwPSltqRiEQ1EiZiGF4RaO9ErQdPXwAgABw3YCAAHt4MA==
Date: Wed, 2 Jul 2025 03:42:00 +0000
Message-ID: <PAXPR04MB96444DFCEED12C6DF8B1A382E240A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <CAJ+vNU0p4BZX-853gmcgEMzXn+es5SV5aTUcU-kzTjPZLFtLOQ@mail.gmail.com>
 <PAXPR04MB9644C2E63CE6649A1818ED82E241A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <CAJ+vNU0-wUW=j0N3RYVMsjhdpjxoU-GA8uVD_MAawYdj=X2N9Q@mail.gmail.com>
In-Reply-To: <CAJ+vNU0-wUW=j0N3RYVMsjhdpjxoU-GA8uVD_MAawYdj=X2N9Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DU0PR04MB9249:EE_
x-ms-office365-filtering-correlation-id: 313a616c-c977-4a4c-65fb-08ddb91a66dc
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ck1DZE5jdEJESGNBVFBwK2xNd1pyY1Z0REFteExGNWxzYUNqcVBqOEZDYkVJ?=
 =?utf-8?B?eXVoT3JuSkpqU1paODZGeWI3SUNST0s2VVI1UGhITkllajdlZGtOVWlMTFFa?=
 =?utf-8?B?eEZLeFAzelRDRVdXZFNaUE85Qk1ITk96TW5vQ2o5dnVYenMvbGhndnBMM2J3?=
 =?utf-8?B?UjlmQnhtQ2pWSmlLaXpEckEyeTFLcGFYVWpMc1h4U29pTUF2ZHRFN1BlVWZ1?=
 =?utf-8?B?aW43UUM2S0h4WGlWcUxaZm9WdnRXZ0dELzdCejhYSHpQZHdzSURxd1R1aWps?=
 =?utf-8?B?VVAvVC9DdlNsUGFkeXdPVFNBcDVURWUwakVhcHNva1FKdVN4OTNoMEMyUFp6?=
 =?utf-8?B?VjZteEJaQ0lvdUdqemNnMU5CK1R6MDhXakVhdmxtUWxSVElpWmN6cjBxbi9T?=
 =?utf-8?B?QzlORkxkWThCWlJKeU5OcWlKSUxSK1hiUFZIZHJnZjc4Lzk1bjFod1RESk1o?=
 =?utf-8?B?SkdnRXVVWWE3VXl3akY2MlovRURwcGNvSmtFekl1VnJNOE5renRQTUhvTVow?=
 =?utf-8?B?VTBZdlNibytBcGFyMk1ncElvVE1BYUF0SVFwdENEZTdDa0wybkd4d0dLQzZB?=
 =?utf-8?B?eGYzSkQ4cU1NSkxWTXgwRFkxT0wyME4rY1dERkVsS01ZT242RDBOQ2hzNzV0?=
 =?utf-8?B?L3JNeDJJMzJvU0RjTkJxTnJLM1E4ZHhld3R2VXAwb25WbnFWRFZaNy9ZNHF3?=
 =?utf-8?B?dkhreHpYbXFyb05lenRWT2FidkFpZmJOb2ZGb1JVUkFVYkp5aVhNUHVaM0V1?=
 =?utf-8?B?Y0JaT2x2ZU1QMGVwTnF5UzdIWkprc1JRdVlVNUlGUXQ0a21ibnptQ3hLZnZr?=
 =?utf-8?B?bnUwZVNlVitCN3l6R2k5Zm1lMCtEZWFKZWlVS3FhbUUzWHVsSEZWS0NDUEZ6?=
 =?utf-8?B?dEpMWFgrN3IrMW4yRXgyY21oUGpuZG5sQkVGQzlOMUNtaldjbTFjMEI5MDhO?=
 =?utf-8?B?L3lldWczYkMyTmFIVi91K2pRUU9QNHVDTTdwUFd1L1dtRllTcnVSMWV1Wmdm?=
 =?utf-8?B?K1JRNmt2OUY1amF3d3ZoeWRGTEV3bERLZ2c0eE0rOXlkMkpSZFZCWndFQU5t?=
 =?utf-8?B?RmE3b2pvM2tNRmF4VTRiemJaRlgvL2h3aUNuUjZod3lQcHlVZVZHMTZJajR0?=
 =?utf-8?B?TnpONitJVm5Oc1d0OVRicytmVFRlTXZYZ3lFSnlKSXl3U2RRLzY5YlNhMW51?=
 =?utf-8?B?djZMQVgyZFBLQXRCcmFBZUg5b2VMSzE2QUZ5eUxOUndiNWNPR1BHeENCb3Uw?=
 =?utf-8?B?MHZMSm1ubFQ0aEl5Y1lOR2wvbm1PSFpOb1JPbTgrM1llZUFWcVJvZE5MdExZ?=
 =?utf-8?B?YS9BMXhwZnloQWFBUFg3dllRZVNybWdHckpkcUc3akRBRitKeGlmQXptU0Vi?=
 =?utf-8?B?SCtkN2JaWVpBVVhGb1RaZVk2NlNPSTkySkQrQU40SGgyREVpdktRS2dPRG92?=
 =?utf-8?B?bHZ1NTJvdEF2b3JRRmJ2NWZLYytyMGZsQlZ1T3kyZzJpZ0F4LzBvbVlEVk9Y?=
 =?utf-8?B?SVhhcWdTVDlWTk83eE5IZVRwSnZoMHpROG8zWTVBYmpBVFh1eUJTNVlKNWNO?=
 =?utf-8?B?L0xVWFpKb0JKQ3hhRTJTZ1k1UENmNVROZklmdC82Yk9XT3VjQ2x1OUtLWGRF?=
 =?utf-8?B?blh1WWM4TlNjNXh5MTJaeGZFdkRJSU4rNDZTazN3aTV2Nmc0dmxXaWxsTy9C?=
 =?utf-8?B?Y3d4MlRLU1ErK0lEdTltOENwV1kzUnNrdk13RkQ2b0FzcGVTZHFVc3h3MkVn?=
 =?utf-8?B?aVljZW9xWG9aWUxTOUNuNHptcjZ4V051QzBNZ2p0Q2IwVkxNWjl1ZGxiV0RR?=
 =?utf-8?B?Wms3ZUZhVWsxc3JUSlFzZzhJM3pZNkRFSUhmTzExZWpzanRrbXNMRUJwNW8x?=
 =?utf-8?B?L1FTRTg3UzlTS0V1WDZ2bUcydXVxZ0E2ZzlWdTE3TktidlZuVXVQK2d3aWxm?=
 =?utf-8?B?NDh3dzMxNGd5ckt1M0ZjZUZJOWVOblgzMVQxRjhNTTEvWlJLTWtrSXl0MzFV?=
 =?utf-8?B?QnhlVklVNWRnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlhwS3NqMjA3WXFwcmhmU2lkaDUvVzBrTFdGeTZYSVdhRXh6VDlqbTdRa2da?=
 =?utf-8?B?b1gySWtSRmVyVnUvSklEaGhZS1pNeFM4M1BER1Juc0owcldKRTRnTkhZSG5y?=
 =?utf-8?B?OFoxN2JMYjl5SWJPZlEzZ3J0RndjTlc0M0poQTBXSzgvOEg1ZjNkeVFHQSs1?=
 =?utf-8?B?MEJscmZvOUpORHd6bkNHTzEyRFpyR2tqYnVBUmpoY1ZNZjFQU2xnTzhXajky?=
 =?utf-8?B?T3dENjROWDNUdlFIR3VpcHhXRVRjWEkxbEVPU2JidGpjY3JjTG9WWjJ2L2FX?=
 =?utf-8?B?MllPMU5WZkQ2dnRyK0hBRGFkTGRBaFdZTVR4QkFDNmZZVHhJOFpMRmhqbkps?=
 =?utf-8?B?dkVsNlhzSUVQVjk2TVc5eEZSVFlTTWE2UlM1NDFaRks0Z2M2R0V1WWR2YXk2?=
 =?utf-8?B?ZDMra05qMVdIK09XQmF3K2Y2MTZHTWUyVUhVeFFVUkdxS2x4REc0cndYaksr?=
 =?utf-8?B?SlY1MkI2RGVyb1hvZEJ3UUxoRU9xOE9YQkN3eVc3MGdYbExqWkI1Mk1LODBS?=
 =?utf-8?B?MWhwQng4bFhTUHJnYmU1R0FqWnIwVS94ZGtJSFlYQXdubFJpdmZPSU5hbUV3?=
 =?utf-8?B?VGhkbDNJNlRzOWJjUlNPNEVNZWRGQjNGT1d5MHJFVmx1NDJQU3V3NXVUMGNT?=
 =?utf-8?B?S3V5aStQdnVIbE5zbXhuN3ZndXJLdzBCTDVpMGw2dG51SjFlNkV4K0haVUlM?=
 =?utf-8?B?Smt2ZzVnNE5QUnMvMmQyTUZqN05qSGYxbmlGSDBrMkJwUThicEpKazhsVCs3?=
 =?utf-8?B?L1VicmlJYWFnR2hPdEtSVnNXY0U5aXUyelZUb2YzdVdNRWhxdHJ1RUU4elhy?=
 =?utf-8?B?RlJ4MGNRNnU3bkwyZDY0aEsrNE5jWGJDVlh1enNzNjNOYkh3a1hMYXBLT2R0?=
 =?utf-8?B?TlFtdUpHNEVxL2tKVTZ2cEVWaVBoaHk4VDhiNllJdGRmeTNOYkFUam82WGtK?=
 =?utf-8?B?YXdxK2swWnJOeWdoMk9QQlVlSEZDaXU2NXQ1Y2lzaFRWa1ZtS1ZEUGpXMDNR?=
 =?utf-8?B?K1c3Z3lPUFd2b3hpN2orcS9MdUE2RGw2QkorbFcrQ1Q4cFJ0QTVpSG52OEZ5?=
 =?utf-8?B?aDdRRVFkZTdtcTJtM3dWWkdEZkoxOVFkbDdKZEpueEh6NktRNFJqRlErMHV1?=
 =?utf-8?B?dHUzM3JXWVl3cmVXRGk2eGN4QVQvdXJoVXVCNkpLUkR3R3o0SXdFdGwxSXdt?=
 =?utf-8?B?WFBNU3RXNk8xZThETnQyNUl0dVBNZUdnTVdEcENhUDJiMXd1akJuZlA4RFh6?=
 =?utf-8?B?a1pXK2ZQcFNCMEw0dnRNSE5OOHBzSTc4WUVCaWM1TXBlZDV1K2lBWmIyMXBl?=
 =?utf-8?B?b2xiT2JmYkxaL0VaM3RvZjJIQi82WGF3VllqTkp2RFM1b0RUcmJBMHJ4Rklm?=
 =?utf-8?B?K1F4QTRjbEVGQnlNcHpjcWhCRUhnNk5TeGxIMGczeTNtQkxBM1hMRXJlNCtC?=
 =?utf-8?B?U01jbE9SdGhhUTJHZjhwTk5mTS9tSTNNN0lhekFwZnRQZkdtTi9pa2V1R1BM?=
 =?utf-8?B?Mms3REFybEJORkl3OXRkclNJOE9UV0dVd2YrSFY4b01WT3dneDErOHFodDlY?=
 =?utf-8?B?MnRxY0laN3dteUpVYXpvUzU4QUU4T3pMVHN4SnVFVENKVHUzQ3E3SG5pVzFx?=
 =?utf-8?B?ZEsxUjE4R2FPQTlpZVpGTFpNZzJFRmFCRmF3VUx4VjN2clJqdnM4Yk5LRXVv?=
 =?utf-8?B?YklCYXVUcnl6RnpVUUVLeFFDejQ5bWF2LzkxbHpVSnhUSUE1L21uZjZqcEFC?=
 =?utf-8?B?djRiMW03L3BRZGZuLy9BWWF5R0tKTzJzNXp3RS9FQTBpbCt4a3VubXlqQ3k2?=
 =?utf-8?B?dmRRR1dMYmlBTHdnWlJ5ZC9CT2NoRVZiZ1lEeitkczN0dUFCTUpyRHRGV0gy?=
 =?utf-8?B?YWJVZTExaVU0VFFZS0NReFZmdDdESktvd0lYSU1JL1pwS01UOHc3c1ROKzNQ?=
 =?utf-8?B?SFlSY2VtRm9GY3BSQW00R0dvZHh0NmNpSFEvUlRpOHBBN05Kc241dHNJMERn?=
 =?utf-8?B?ME9jcGJXSEdhZk9adXZFYWphYmZYZnRaeHJGSVpDMU5jTysxNmRiTGVGclZU?=
 =?utf-8?B?eXNGQ2N6NGJqL3ljMGlZaGpGWVVrSDFQTVBDQUU1YS9iVWRlb293bU9CWER2?=
 =?utf-8?Q?FwtxZgZWzmOy/oK2IXNFEBLxC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313a616c-c977-4a4c-65fb-08ddb91a66dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 03:42:00.2056 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZXtfPeach8YrakIZ1sR5tSbb+vrJi5PjfM6eshsuO6EGKIFXqAr6qPLfxWJfvg+Ve0mYnACwEPnRpJcl/IK/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9249
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

SGkgVGltLA0KDQppLk1YOTUgQk9PVFJPTSBpcyBvbiBNMzMgc28gdGhhdCBjYW5ub3QgY2FsbCBi
b290IFJPTSBBUEkuDQoNClRoZSBkaWZmZXJlbmNlIGJldHdlZW4gaW14OG1tIEJPT1RST00gYW5k
IGlteDhtcC9tbiBCT09UUk9NdjIgaXMgdGhhdCBCT09UUk9NdjINCmNhbiBjYWxsIFJPTSBBUEkg
dG8gbG9hZCBhbmQgaW14OG1tIEJPT1RST00gaGFzIG5vIHN1Y2ggZnVuY3Rpb24uIE5vIG5lZWQg
dG8gYWRkIFVTQg0Kc3VwcG9ydCB0byBpbXg4bXAgYW5kIGlteDhtbiBTUEwuDQoNCldoZW4geW91
IGFkZCBVU0Igc3VwcG9ydCB0byBpLk1YOTUgU1BMLCBoYXZlIHlvdSBpbmNyZWFzZWQgdGhlIHNp
emUgb2YgaS5NWDk1IFNQTD8gaS5NWDk1IFNEUA0KdXNlcyBVU0IzIHdoaWNoIGRyaXZlciBpcyBp
biBkcml2ZXJzL3VzYi9kd2MzLy4gQ29uZmlndXJlIFVTQiB0byBnYWRnZXQuIFRoZSBVU0IgcGh5
IGRyaXZlciB1c2VzDQpkcml2ZXJzL3BoeS9waHktaW14OG1xLXVzYi5jLiBpLk1YOTUgaGFzIHRj
YSBtdXggc28gdGhhdCBpdCBpcyBuZWVkZWQgdG8gYWRkIGNvZGUgaW4gdGhlIFVTQiBwaHkNCmRy
aXZlci4NCg0KQmVzdCBSZWdhcmRzLA0KQWxpY2UgR3VvDQoNCj4gLS0tLS3pgq7ku7bljp/ku7Yt
LS0tLQ0KPiDlj5Hku7bkuro6IFRpbSBIYXJ2ZXkgPHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbT4NCj4g
5Y+R6YCB5pe26Ze0OiAyMDI15bm0N+aciDLml6UgMzo1MA0KPiDmlLbku7bkuro6IEFsaWNlIEd1
byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPg0KPiDmioTpgIE6IHUtYm9vdCA8dS1ib290
QGxpc3RzLmRlbnguZGU+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IOS4
u+mimDogUmU6IGlteDk1IFNEUCBzdXBwb3J0Pw0KPiANCj4gT24gVHVlLCBKdWwgMSwgMjAyNSBh
dCA2OjA34oCvQU0gQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gSGkgVGltLA0KPiA+DQo+ID4gaS5NWDk1IG5lZWRzIHRvIGVuYWJsZSBVU0Ig
Z2FkZ2V0IGluIFNQTCB0byBsb2FkIHRoZSBVLUJvb3QgcHJvcGVyLiBJdCBjYW5ub3QNCj4gdXNl
IGJvb3QgUk9NIEFQSS4NCj4gPg0KPiANCj4gSGkgQWxpY2UsDQo+IA0KPiBUaGlzIGlzIHVuZm9y
dHVuYXRlIC0gaXMgdGhlIFJPTSBBUEkgbm90IGdvaW5nIHRvIGJlIHVzYWJsZSBmb3IgdGhlDQo+
IGlteDk1IG9yIGlzIHN1cHBvcnQgY29kZSBzaW1wbHkgbm90IHdyaXR0ZW4geWV0PyBJIGRvbid0
IHJlYWxseSB1bmRlcnN0YW5kIHRoZQ0KPiBkaWZmZXJlbmNlIGZvciBleGFtcGxlIGJldHdlZW4g
dGhlIGlteDhtbSBCT09UUk9NIGFuZCB0aGUgaW14OG1wL21uDQo+IEJPT1RST012MiB3aGVyZSBC
T09UUk9NdjIgY2FuIHVzZSB0aGUgZm9yIFNEUCB3aGljaCBncmVhdGx5IHJlZHVjZXMgdGhlDQo+
IFNQTCBmb290cHJpbnQuDQo+IA0KPiBIYXZlIHlvdSBiZWVuIGFibGUgdG8gY29uZmlndXJlIFUt
Qm9vdCBTUEwgZm9yIGlteDk1IFNEUD8gSSBhbQ0KPiBvdmVyZmxvd2luZyAuc3JhbSBjb2Rlc3Bh
Y2Ugd2hlbiBJIHRyeSB0byBhZGQgJ2VpdGhlcicgc3VwcG9ydCBmb3IgdGhlDQo+IFVTQjIuMCBj
b250cm9sbGVyIG9yIHRoZSBVU0IzLjAgY29udHJvbGxlci4NCj4gDQo+IEJlc3QgUmVnYXJkcywN
Cj4gDQo+IFRpbQ0KPiANCj4gDQo+ID4gQmVzdCBSZWdhcmRzLA0KPiA+IEFsaWNlIEd1bw0KPiA+
DQo+ID4gPiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+ID4gPiDlj5Hku7bkuro6IFRpbSBIYXJ2
ZXkgPHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbT4NCj4gPiA+IOWPkemAgeaXtumXtDogMjAyNeW5tDfm
nIgx5pelIDg6MDcNCj4gPiA+IOaUtuS7tuS6ujogdS1ib290IDx1LWJvb3RAbGlzdHMuZGVueC5k
ZT47IEFsaWNlIEd1byAoT1NTKQ0KPiA+ID4gPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IEZhYmlv
IEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4gPiA+IOS4u+mimDogaW14OTUgU0RQIHN1
cHBvcnQ/DQo+ID4gPg0KPiA+ID4gSGkgQWxpY2UsDQo+ID4gPg0KPiA+ID4gSSdtIHdvbmRlcmlu
ZyBpZiB5b3UgaGF2ZSBhbnkgbm90ZXMgcmVnYXJkaW5nIFUtQm9vdCBTUEwgU0RQIHN1cHBvcnQN
Cj4gPiA+IGZvciB0aGUgaW14OTU/DQo+ID4gPg0KPiA+ID4gVGhlIFNQTCBib290cyBvdmVyIFNE
UCBqdXN0IGZpbmUgYnV0IEknbSBpbnRlcmVzdGVkIGluIGdldHRpbmcgdG8NCj4gPiA+IHRoZSBu
ZXh0IHN0ZXAgd2hlcmUgdGhlIFNQTCBwcm92aWRlcyBTRFAgc3VwcG9ydCB0byBsb2FkIFUtQm9v
dCBwcm9wcGVyLg0KPiA+ID4gSSdtIG5vdCBjbGVhciBpZiB0aGUgaW14OTUgdXNlcyBhIHNpbWls
YXIgYm9vdHJvbSB0byBhcyB0aGUgaW14OCBhbmQNCj4gPiA+IGlteDkzIG9yIGlmIHRoaXMgaXMg
ZG9uZSBvdmVyIHNjbWkuDQo+ID4gPg0KPiA+ID4gQmVzdCBSZWdhcmRzLA0KPiA+ID4NCj4gPiA+
IFRpbQ0K
