Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602D0C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 16:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CDD888599;
	Fri, 26 Jul 2024 18:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Rkdijd4L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CDEC8861A; Fri, 26 Jul 2024 18:01:58 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E57C388614
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 18:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSkqYnE788aZ2LL+E9cRMeTqF4Z+ar5I8dBBNP+BYFpmpUFjkyEy0F32iG49xPoJWzk6/APHkUQm70Ad05iCz9z/dnHv+WYhB419NJsADWOBVEgJf6Ii6+GHBpdhT51qGqawS+NPMVq05USdGvX4Vyk72yUxXcqK/mCwZmi08inIK69tuHAJNE5D8N8Z0ZTqHX5ynlSyOYa5k9l+dx5WnlezQe2HnWy5sjpIfQJKEDfSJQyH++0nAnt+rSGb9rcqaYXqspSYG6Lx49ZQ6PKVwdjkUpTWfrWACGbypH9kNU6O4t67tKyOyyiYJ5NmRWnwEn1mAEBQ/gNXkOyRu9Xb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KD50mJsD/6B3iAfp/owjvxOqlQH7dXNNfZtjoPJ08xg=;
 b=WCSa/fxEgOiqKIPUKSvs/Vz/9nZ1HR7xKjYK7SjgGhKKPq7ZYIhf/sKr6zP6U9iHL9IChBJmv/q79D7V2fCGXVO9c7Q2wCDFCsQLmaQbevs8a2OywY+qRObYisykhsHpzvmFWmRisHwn2cAyQ32vs6mY+KeS6IUD31cU1Rl0+D9w+u4dcaN4i/NdkrPGL8v/onhnxurrGgPBlNVzhYQZ7oNtnL5O2PTI6J2fJEIoG6TmuT9MO8AU7HOKookj4UYZPUYWbunxJJV0xCfMyWacA25fLKQWG7xFXQ6KVfmgZ5iYtX685CqNyWunpK3vmTTipXDfgVGSoHkPczCRMATmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KD50mJsD/6B3iAfp/owjvxOqlQH7dXNNfZtjoPJ08xg=;
 b=Rkdijd4LRxQdmA6qc8FEup0ph/M6mdScfFUeAPAmagtotJFbYDXLsewOP8gs+YND5Pt5O3P0IbxdMBAZbNo7wPE/ZcP2MGYHmOApcU5nvxW2+AzYCQrcPeD8DZPompNY2MDbIarOyWG7/V/hPI3O/T3mA09Cu77qVNVRbKMp+1N0vNNmZ8GC0lYSnACq0zu/j/E5Oj0qGWaEp929hvUqkVI5iHWr6WYGbodOHxqvO9qO7w/qYdZGgF2T7dpeym4ef8xKpTXBYhqeupUuQF1pKkbF/tGPz1rMn+hdBKCubQxFaXq4KmTLHfn6AF0y7xGdWUZpet6DX3YYr/XMHf/k9A==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by DU2PR04MB8742.eurprd04.prod.outlook.com (2603:10a6:10:2e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Fri, 26 Jul
 2024 16:01:54 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7784.017; Fri, 26 Jul 2024
 16:01:54 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCHv2] clk: imx8m: register ARM A53 core clock
Thread-Topic: [PATCHv2] clk: imx8m: register ARM A53 core clock
Thread-Index: AQHa30Pexqt2O5+IbECip2K9bcxtxrIJCysAgAAa8iA=
Date: Fri, 26 Jul 2024 16:01:54 +0000
Message-ID: <DB9PR04MB9236DE687B0FB9543836F55084B42@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240726102954.14546-1-Zhiqiang.Hou@nxp.com>
 <0a40ee6f-1fa1-469b-ac9a-f7d8b6ca9f40@denx.de>
In-Reply-To: <0a40ee6f-1fa1-469b-ac9a-f7d8b6ca9f40@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|DU2PR04MB8742:EE_
x-ms-office365-filtering-correlation-id: 3c602115-8085-4f21-38fa-08dcad8c44f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OVU5dUtSS2d6ZXdadGhZYk1Ray9rdXF4bEx1aG5QMVZja3pMVnpNenZ4dDJ0?=
 =?utf-8?B?VU9jdVZEbGkxa0dNNTViS0VuR1dSY1Q4ejNoYjgrNTgrbmFHRTl6dFIzMnhZ?=
 =?utf-8?B?dXd3M2J4MW51bWs5Y0lnRGZKVXNlVnkvZlgzZnBxbDVZWTBJajFOWGswd3Jq?=
 =?utf-8?B?TGkwQ2gzUDNYUytteEFwWThvdVVKeDExMng3OGN4T215cmFOT09hNDJQK3Bx?=
 =?utf-8?B?a2NmK3pKUTlpb1o5eUxDbDZOK1ZvbWJpZXAxQUc2akNmUmlEczZuSWEzdDFq?=
 =?utf-8?B?UnZXd1pjNmczczlqYnBIMVVGN3praFUzK2dacXNjY3lYQ24yTGI1elFTTU5C?=
 =?utf-8?B?U2krek5ZaWtVTTlFUzdpNUlwVk9KVnRMcHFaRnBYbXdISGYrK3FuZGkwYlFR?=
 =?utf-8?B?aXVGZHF0RVJSLzJzbnBDZ0JuYnkxYkp6LzhSYXViU2hRZDBUc3pRemF3K0Ra?=
 =?utf-8?B?SWdCR1dDV2Q5TFhJZUtaM1ZEaitjNnEwbWFFc0tsSzMySEJqRkR4MDRNWjI3?=
 =?utf-8?B?RzNaQm84ODloajJBU2Y2ZnY4clROY3cvSzlJN2V0RERsMjRpa05aU0ZiRzJK?=
 =?utf-8?B?UTVoMGtZbmdDV1hXdDAzU3cxY1RFaUM5amdiOEtPYWExRjZTVkN0S1Z5SFFX?=
 =?utf-8?B?RzJ1V09EZEQ4a0x6WithRGlJeXBzVjZ0V3VsaGxtZ0x6SjNYRXRidENQdVJM?=
 =?utf-8?B?UmNHci85L3dTelh4MHZvemllWFZiOTZOTTZNV1BYbFVmZHZuTGRoQ3p3TUtZ?=
 =?utf-8?B?SE5wcVZSY0JUMDlocUc1SWZoaHFxdm42SDBCMzhtby96c1JTZnA3aENGRTF2?=
 =?utf-8?B?NmMwSWFZei9CMk5kQnpXOWtoZjRGOUZLR2NCSndRSFJUY3V1Nnk4T3hlcysz?=
 =?utf-8?B?bTVXTUt4VkJYdi9Ua3pXT0t1cER5YTYrTzNVa1FWZFduTHNvU0tFTUV3b3kz?=
 =?utf-8?B?V0Iva3diVW9SZmd1Sld3ZGRNVUZ3c3NJSk8zUERTQXBvQy90ck1mMDIrN1lz?=
 =?utf-8?B?STMzbUhqNk5zRVVRbVhCamo3VmYxaXlqOHNLSjZLb3FNVDZzK2JTelFiandE?=
 =?utf-8?B?VkJibWF0SGVEQmkxQnJkZUQ1eWZpU2EvWWJKNi9iQ3UwWC9SYXhhZThVTklL?=
 =?utf-8?B?QkpobTJlOWRkM0ZXWlo4bUZNcHpIWXE4K2dheGNaUXA0WkVHZ2VGZTVPN2s1?=
 =?utf-8?B?am9ON0lseEs4TmR0S2ZuUGo1dGNrTnpkREw4dG50TGY5b1lGeUxCSm9POEw0?=
 =?utf-8?B?dG9Cb3JuaEJCdlZrU2lOekZjc3dScXcyR0IvVnBtU1N3NWZBWXhHdFVlVHEv?=
 =?utf-8?B?M29ZZjJHQUVyZlBCTlIxTGZOdHhNYkdDZnNnUlloVGtlOGIyM3BrMmIrQ3BC?=
 =?utf-8?B?ckJxdVlYeHBnUWFnckdqVFE3aHpBUVo5Zk00UWtkaTQ5RjJ5RDcxb3BhRmx3?=
 =?utf-8?B?Y1lOcGJFRWZ6QmI5eWNSMUNDcU4xdWphLzBKRm1rREp3WXBtU2ZPTDhlUklq?=
 =?utf-8?B?ekViZ25BSWZ1SDRlUzZhSVJYT1NrQ05UbFcxaFFuS3o4Uk9BdVpmcWVvZU9C?=
 =?utf-8?B?UG1EcmcrSzB4YXY0ZHpYM0gxV0hsQUpmQitsMVRUQXJkS3hERENtUEdiMlVG?=
 =?utf-8?B?dzhaSkZZSE96TVR1VFFqMERhbDRoaHd2SGc5SVJ5cVdmVlRTQmswQS8wVm83?=
 =?utf-8?B?Qmw5UUhab0NsWTIvM1BvWk91OWFFemxkd2pLVUhCUGoxejBPZm42bzk4Z3cx?=
 =?utf-8?B?eTBtczQxQzNOU21HU0k0eTBrclI5L1lmVkZhT0NiZldyKzJQczRSTzhMaGpT?=
 =?utf-8?B?akZ1WFpacHRlZGdGcmJCYmwvcGZlTld5TlNMVldCWVdOSkFCbEpGd2FTVUFO?=
 =?utf-8?B?SUlyV0FMdEIwZi94WmkxcHRYK1pSZzFvRk1vL0ZreEJCbWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzViS0U4Mmo0T1hiYkpDSGEvSk5Fd3l1d1g0OWdOZTAzeTN4aEJIUHg5STh5?=
 =?utf-8?B?NFZ0NVFyV3NFaEEvVFc4Q2VidnJ1Yit6K05iYXdYTGlOLzZTYmZYWVphYmpu?=
 =?utf-8?B?dmJjRmlhZ0E4Rkp4RGdyRmk0MXBoQk1oTlMxYzh5ejZBQzhEYWVHOS9jTzJt?=
 =?utf-8?B?OVhPc2RNZTBzeU9TYTFEZHEzbTlwM2o4bHFZa3VCTUhSNFRwaXhTMGtuTDRW?=
 =?utf-8?B?ZWR4WHpneGRPZzlGYjg1WXhRVzBkcVlyUGtQWk9BcnFkSGNua1FBaEdSVXNR?=
 =?utf-8?B?THdCRlE2dzFDMmtIcG9SQkZCb2EyR0hWaHBDQ2FRMHJwYVRaU1l5eTFYVERP?=
 =?utf-8?B?UWNVaUk1R1RMdXB3dHJxLzd6enBBTG5oL2tOOGdFQlRQWnFlQVZENjZucW9Y?=
 =?utf-8?B?KzFMWUdreHF0TWsvNGQ3dlEzV1pLb2daVUh6NG13eVlaZnVkWUl4c080NEVP?=
 =?utf-8?B?TGdTaDdidTlKak5GVzR1OUFyWWVvQk0zZnhDY2hTVmxkTFVEcFhPbENNZlp2?=
 =?utf-8?B?SWhtREMyQnltQUlGTmJwb1hkMmlIYU1PY2g3aWdCTXlPNUoxYnpkd3MyejhQ?=
 =?utf-8?B?S0hEdFB2OFFvYk01aXpJd0ljQXZEZ3haRXRENDdySlpwMGVJWDBFdmpPMGE5?=
 =?utf-8?B?b0NmWVhIdStmVEhOL0ZndHlBa3dXd05HNlFuQWlEZkxqQ1lobVVHWDZxTTk0?=
 =?utf-8?B?U3M1RElUZmNDK2lyZ0JMbFZ3SEtkazR1OERzeGhHMW1DVVBNYzlFUTJaVlBz?=
 =?utf-8?B?ZEhjMXB6Qy9BbldnZFlkdERhaVJXc1lQTTJpdjFnMWVvbFY4RU9VZVZmaHhy?=
 =?utf-8?B?cnA3a2JGYTZzbkh3SkpvOXVFakw2S2ZLSWhQd2t5d1ZSblppWVhJU3UvUDQ0?=
 =?utf-8?B?N3pWY1BleGxTeEY3dHV3Vjg5b0hYNWVScUZORVh3eVdXL1BKa1Q2WGJ0UFZN?=
 =?utf-8?B?ZHRlZU4yclpiMnhPWE0xRWx1bmtiemhTRTkxU0ZOdHpjN2JnSnk5OWluangv?=
 =?utf-8?B?NlZFZVlEN2VsQU5kd3V2M2VrcHJ0dEhObmdKeXBmekYwZmdNTzBDRWkrdVpy?=
 =?utf-8?B?MkZUVUE5cVpRcUZISzMvYlY4WEhrZGZVMm9VTnM3NHFjS1RFR1JocCtTaitm?=
 =?utf-8?B?cDJGZUVBME5wUlhpNUZuZzJpZFNZZGtDWmVEbWljdlBpbnNaSnlvT21ZWVdr?=
 =?utf-8?B?T3RUOUdhSExKdHMzU1lzVVZLNkRXT3dNMms4dFlCVVppMkY1enhYcEpNMk5Q?=
 =?utf-8?B?WHdYZko3ZDRLYVZlOFl0NExwSUQxRnNzSGxXWWg1OEFuYUo3aWs2L1hxSXdS?=
 =?utf-8?B?NFh0T1UyQm9xUW9FV0txbmRXYW14eDkrR2g2LzRNdVkwUE9sanNsYUpwVytY?=
 =?utf-8?B?SDZOSm9VLzE4ME1XbEpFbUNyeStLVUtKQmMxVXZtUFBFNkNvNDdURHdwVmJZ?=
 =?utf-8?B?Yi9zZ1R3L0xkakhkdVA1Q0JrS0V5UjlrMEVUMUhrV1dBYXlDZkxYM3RNaURl?=
 =?utf-8?B?dHMyZDJwUGdEUjBLUXhTdVNGMFpSUXJZT2pEeGhLWjE1QW4xQzNndXJ6TnlX?=
 =?utf-8?B?M1lxdHR2MEJvSFVLYU8yd09FQVhGYWE4NTZpeEJYdDBobHJ0Y2ZhZGlteW9G?=
 =?utf-8?B?dWNXSzU2aUVWV2V1VTFmYXorWmViZ3I2VzFxRUVNMzM4N0JTU0EwcG0zODNl?=
 =?utf-8?B?cnpYMmFJZ0hXMnRFc2VjZGFWclRjYkczeVluSlVTbkRlLzJYaTVvdk4veGRE?=
 =?utf-8?B?dkpmRHNvZy9heklRbEhHbmF4UWE3TWFHNkt5MXQyZlNiSkhqNVBQTFBKby84?=
 =?utf-8?B?TlhRRGxhdHJsQ0JuQzFkUjlJeWtEVi9uRzdQc0cwVHJSaTVzajUyWFpJTVBa?=
 =?utf-8?B?TGY2UzhyMnR1SVMweCtWcm9UK3BQS0VSbXBOU2xaYnZ5aEtMay9BdWtsa3pi?=
 =?utf-8?B?d0RHMndlVDZDRWhHd05VVUM4WHhsR3U2QWcrbndwbHA2M1JkOGU1UG9UdENT?=
 =?utf-8?B?b09rbWtqejQ2MnBiWjNaNzVKRXozRlhlMk4wdUF5U01UWDNzcHVlbHd4eGZD?=
 =?utf-8?B?OWxSN3dkbktTK1JIMEx5TzVVL0tPTEhMYWsyWUFodWN0OXVQdEx0VmdEODRj?=
 =?utf-8?Q?vYWVOsAc6l4ihLgYzpdX4EXFF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c602115-8085-4f21-38fa-08dcad8c44f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 16:01:54.3412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DUrst15yd99jA1hbeOyfcOVr8jqkUlx9USdeOS/JaYVvjdMIWyDLgq/hGjOBqKseEblW9a11v9wwRDWkLcu/vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8742
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

SGkgTWFyZWssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsg
VmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IEZyaWRheSwgSnVseSAyNiwgMjAyNCAxMDow
NSBQTQ0KPiBUbzogWi5RLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPjsgdS1ib290QGxpc3Rz
LmRlbnguZGU7DQo+IHRyaW5pQGtvbnN1bGtvLmNvbTsgbHVrbWFAZGVueC5kZTsgc2VhbmdhMkBn
bWFpbC5jb207DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0h2Ml0gY2xrOiBpbXg4bTogcmVnaXN0ZXIgQVJNIEE1
MyBjb3JlIGNsb2NrDQo+IA0KPiBPbiA3LzI2LzI0IDEyOjI5IFBNLCBaaGlxaWFuZyBIb3Ugd3Jv
dGU6DQo+ID4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPg0K
PiA+IFJlZ2lzdGVyIEFSTSBBNTMgY29yZSBjbG9jayBmb3IgaS5NWCA4TSBNaW5pLCBOYW5vIGFu
ZCBQbHVzLg0KPiANCj4gV2h5IGlzIE1YOE0oUSkgbm90IGluY2x1ZGVkIGhlcmUgPw0KDQpJIGRv
bid0IGtub3cgaU1YOE1RIGFuZCBpdCdzIG5vdCBpbiBteSB3b3JrIHBsYW4uDQoNClRoYW5rcywN
ClpoaXFpYW5nDQo=
