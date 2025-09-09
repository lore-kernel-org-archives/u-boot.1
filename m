Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C915ACA1016
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 03:26:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3986480422;
	Tue,  9 Sep 2025 05:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YC4OeIJF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 668C182A9E; Tue,  9 Sep 2025 05:26:26 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3A7B800B6
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 05:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CN50+8YTHW+T9XWchPndvR0ZCxUrXmMWhBr0bYds2Go8ikdarthFPE8+HeqH/yKbAw2f2qKiL8Lk7xR5osS9GYBE5Q0mojQ/IS/NvN0ezUnPytUYxBoRzMMYKvYIL64t7gd0pPT9F386t6FmO49j6ckCDKIA9j+Ea1hM6Jsnh8A1ILN9F46pQIHagiPOL4oo8gMT8RCFGRp9ET1adhOX2E9fMxJMFkAtB7rhQyN7e0jD557b7Q6ify+jlbdZ7VxMBoWqo89RX5MxToFESMf6adf33OmiXSFYiuqz+MBBJunjVxmMu2d/Ld/g+pUwRMr4Q7TqBt9/6N69PxCYTtGm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gDYllhTJo28JE3rf+/x9k/z6C2quLxWJz7R6RDeC9Y=;
 b=c/DqsG1Mdb+U7lqfzb38C3BqWq09iJfWF1KjLys5FZI+DPd+MUTfTzpHm6swiGVxq/qWtHg5Ff3ckAKX8vG5y/dP0SRF7E8trSM+32UTCZslcBAUrcpNzKIkjoZ60woAJ7GTYvDjfi9jNYJLNkb78qnIg841iwYhoHubBbqzfskw5DYokAlPcjbejy4nENU565Vjh70/8eUSyWjKp9wAgRHSHsWln+E1hJgG3zEzw7t2ndlSW8vhcrBCcnhH4AIIpv24m9iXU7t+uyuE4BGUIIAa2oLV2UM1Sz5ldCK1nXT52LXXnDRFr6Dq9KR+HWC+S6jxwOZVSEsVpt9fOfdUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gDYllhTJo28JE3rf+/x9k/z6C2quLxWJz7R6RDeC9Y=;
 b=YC4OeIJFwOWuVoI4qV8Nhf0j94NIK5kxFNxO1iwCPYtaTSMy3kFpJ9rA7jGG4fBZ5P20gbVRwwdm4/qWXVNDqsXooMDys5av3G54JtuBzzO/d245QSSLiZQ+EKFfHLwV5Mfz89iHrYvuWyWdPZXN9+Tq9nqYX1pfOUc51xcH96s46jU7bYqwoq7JisC7AEF9Q3QAlEuej0BQO2bFpegrun9tHDCqm1Gft8zTpwxcnIot4TC+FCC57WByxkb7c1AjuAGsXg3h9Aadutno+U5ZTjDcB2nWQI1k/2693oCpxFLXCJF0q/yp2X5sEtNQEKZUXaB5+DfDhixB72x2Ua1nCg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GVXPR04MB11653.eurprd04.prod.outlook.com (2603:10a6:150:2c3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 03:26:18 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 03:26:18 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
CC: Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>, Alper
 Nebi Yasak <alpernebiyasak@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, Marek Vasut
 <marek.vasut@mailbox.org>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2NCAxLzJdIGJpbm1hbjogYWRkIGEg?=
 =?utf-8?B?bmV3IGVudHJ5IHR5cGUgdG8gc3VwcG9ydCAuYmluIGZpbGUgZ2VuZXJhdGlv?=
 =?utf-8?Q?n_for_the_i.MX95_platform?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjQgMS8yXSBiaW5tYW46IGFkZCBhIG5ldyBlbnRy?=
 =?utf-8?B?eSB0eXBlIHRvIHN1cHBvcnQgLmJpbiBmaWxlIGdlbmVyYXRpb24gZm9yIHRo?=
 =?utf-8?Q?e_i.MX95_platform?=
Thread-Index: AQHcFyEnGuGLh3dJd0CButZ5siesGLSFMLUAgAOFsACAALbfgIAAvgLg
Date: Tue, 9 Sep 2025 03:26:18 +0000
Message-ID: <PAXPR04MB96448DB6FB2EF55C97A528E8E20FA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250818-imx95-v1-0-f68a19fe30b6@oss.nxp.com>
 <20250818-imx95-v1-1-f68a19fe30b6@oss.nxp.com>
 <CAOMZO5C=ROcrsS256shQNP4Dfz9ca_55tT1hQNHUM=kOrxnVUg@mail.gmail.com>
 <PAXPR04MB964427E6CFEFCC51D44D046AE20CA@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <20250908143503.GQ124814@bill-the-cat>
In-Reply-To: <20250908143503.GQ124814@bill-the-cat>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GVXPR04MB11653:EE_
x-ms-office365-filtering-correlation-id: feb0f74b-5361-4881-f117-08ddef50a3d4
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?b3M5QSt4c24wMmhjcmEvTnFQWi8xbnRRblFZR29OMWh5TkxBOVlNUzhTbnNh?=
 =?utf-8?B?Nmw5bG8yZUhtVVpObGwrNlNHcVI1c0RxQkFUN2hZSEF4aTU2S2hCdlp2M0Fi?=
 =?utf-8?B?S3dKSDFaL2MzcUpKWTEwSDNmMDIrTHpnTTFFT1BvL3k5bkt4cjlIRmZCbTRJ?=
 =?utf-8?B?YzRvcHlyRkFmNmh5ak1yZmJqd0tIL2hrQXhpSEs3N3N3bVVlY1J0Tk9xODZv?=
 =?utf-8?B?M05vQUtCdTRxNncraWxsVmQzdlV1dVVzVXNnWUxhZnQ0ODNWSTE0S2V2L1B6?=
 =?utf-8?B?Vm5HN3FCYnZYaUFpOFVSbFZRaEQ4NW9xdWJJajYyODhaQWEvczZqWmxsL2dY?=
 =?utf-8?B?eFBSWEVnS1RwaWtNUHVIWHFXMHlyZTF1alpiM0ZkMUV4UHpUTzc3RWtUR1pS?=
 =?utf-8?B?cFRFWENBbXQ4U0tjVDJKaGF0TkVudlZ6bXZ5K0dablp1eWtaRElwSHJZdWpx?=
 =?utf-8?B?bkFrSUNaaUw2S09kQ2tEaVVnaCtNdGM1NzUrSXFtT1hVV0Y5WTREWDkvcUhR?=
 =?utf-8?B?QmRobjZwTERxOEZLVGdsdWtrUVNqNytTL3pmNk5TVFVGZ1ErOEkyVTNiTzVm?=
 =?utf-8?B?QVlaK2RhTmJsWk9FUWVrSXRwWTBiN1Vmb0gySmtYL2pyU0hzd0dsajJvY3Zj?=
 =?utf-8?B?RUN2TzRzUkFVYk9ZTlVUekcvbHg4Y2IvcDJ1WUh0dTJVcFdqbUlFeXI0YXFP?=
 =?utf-8?B?VEdDVjFkUSsvWnVDcjkydHEzOGRmVzAyQ3VkV3lsaG1seVVuK01iajFzd3Y5?=
 =?utf-8?B?TVNjWU1RUS9HUEZpczVLL1pHUDZ3dHYzOGVlZjNrSUd0YnlKOWR6b2R2bEdI?=
 =?utf-8?B?Ry9WSUtERHU0VGU4T1p0WUdDQ0I3YWtXaVdiUHdGRHlOL1htV2JlSWZscWYr?=
 =?utf-8?B?TTQ4RW5TbnpmQUhHZ0RQZGF2WVFBRXUrQmhPbm03UzZMWWdXakZjdXlGS3kr?=
 =?utf-8?B?cFY2dXdVMElHUTVOUXordzJ1MG1zSEZkTFBVL1pIY09DUkx1VFVYRU1CU2U1?=
 =?utf-8?B?blcyU2lSMHpnTWhtbEZkSi84MUM1bjdqS3J5UWo2VlFSYzBFYWJVYnYwVlFu?=
 =?utf-8?B?NElxL0g3Q3BjcDJXcmc5ZGlsZXhOOXhaNjcxTEdBWFB3NUtMbDZiRXlhY2g3?=
 =?utf-8?B?a0Z3T2hkYWFFeFpTMklSSFlrcmRFV3poTStGbGJ2SGlsZE0wRHNWdlpwRTVs?=
 =?utf-8?B?anl6enJPd3pSdEpEc0IxaTh5Z3I4TkwzZFdFVXBmYlFiYzlpWDhWTjVKNkFh?=
 =?utf-8?B?WTBrWUdUTjQ1ZG5TVGQ5cmIwVlVTZXBpeXZYcThvRHI5RFJWMC83QWJuNjEr?=
 =?utf-8?B?alM1cWNwYVN3eFU5L2NiaFlUdUJtNkhwbFBvbm00NERsQlh1ZEVnbWlDRGZs?=
 =?utf-8?B?R3NnY3R3c2xHSHNKUEg5aWRTektWWms1UXlrd1BCTGhyTHBpeXhKVkZiM3Jp?=
 =?utf-8?B?azdIY0x5Vk1WcXF2cFh5bjk3djZVK1FhMFZFaE1FTUp5OFhOcHdMSndnZGQw?=
 =?utf-8?B?LzRpUURucDV6TU5pWmtDV040NFlVeHQ0djZvWVZES3QxK1F0OU1lcDYwLzdz?=
 =?utf-8?B?VVlPb1o5djZDUzRCWnVNMXdVZHdKaHdIVlZMNlZFc0FYVVBIeUN2a041eG4r?=
 =?utf-8?B?TjRtTmM3bW1xMmZsSTdlTlliR3ZJbVRSM29yQ2M1cE1LMzBkV2FiUXdkT2xM?=
 =?utf-8?B?QkpaY3QyUEllaWZ5VVc0SmsyNFlkUGNJcms5dEs0OUhCZlhLT3N6MWdvVDdB?=
 =?utf-8?B?dzdGdTdlY3lHdkEwUDR3cndLZndMZmExZWczdkQydGY2clAvKzlkLzFUQkFU?=
 =?utf-8?B?MVptSmEvUVpZc2VSK25xZmpFQXJ0QkxTNDBocXl3Wjh4bXIwQnhLTFkxa1cx?=
 =?utf-8?B?TGJ1b24wZi80d3ltOTJYT0gyWjg4SmFwRjU4M25UMFJlQ2d5Y1duL3NoemdW?=
 =?utf-8?Q?QvdKDYERdMU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUZxSlZ4N3NjVEYrd1loamJpTjc2ODYveXl1azMwK2poaHZGdi9wT0ZGRWpz?=
 =?utf-8?B?ZHczT3RjRFNPcVAxRHEySXZtWnBjUGk2Ymtma2ZnRDFRWHcrUDZiRnNhYkJu?=
 =?utf-8?B?dnVsM3IrK1NBQWI2REJzM0hWUVpJSWF6MTdyRkxvaVNxWFVNdytMelZnK05h?=
 =?utf-8?B?eXMwTXFjWVByandmRVd1SW9vbnhRWFZTOWpMNDlQSU9PZzcvKzk3SGpsSGxQ?=
 =?utf-8?B?cThaZldUZlhnbWs2UVRScXZDSUdRUmMxRkVZOUpQdzd0WE12Y05UVmxLVkxJ?=
 =?utf-8?B?YlFUdlBGQlBURHZGSmM1TURXOGI0dmM4cUNKSlBFSHRDRVhOUnVWblR0SHBL?=
 =?utf-8?B?WHl0M0s2V0ZKdGVUaFgrVDdFcVh6TmxocHArY1E5ZVYzSkpOODJwS3llcUl5?=
 =?utf-8?B?U2xBL0UzaHNZaUQ1T3Z2WGU5RTZCUitaR0RwaXUveHJUdmM4MFUxTWNSbTFG?=
 =?utf-8?B?ZWFiek5hcngrN0pmU0x6R3ZkNkgycUtteUEySFJXZmZBcGZRZDRpd2lVdDV5?=
 =?utf-8?B?aC9QeU10aksxbFQ3NGNuMUdXdERUKzg5RWFNaDFjZEt5M2gyb0N3Y1lORlh6?=
 =?utf-8?B?S2xGMFhDeDBJVjJqVkJpV0x4ampkb0dicXZtZFBIcUljZUt4QVBMdmw0WGwx?=
 =?utf-8?B?Z3d1RFRadmRpa0N1aUtpbHBzTmZEUWdRMXRWU2FHWmVNcWZHQlI2NFdLZ2tt?=
 =?utf-8?B?SE83QitBdWo5bFVEMjMxZXpja2lmQlVuS2xtQ3B0blJDUEg2RTBsQUY2Y3Ux?=
 =?utf-8?B?SG16MThtNUI2MEV2M0F6cERGb2FXa2ptT0FxcnoyRUJxcVRpTWxsbmRHeTlp?=
 =?utf-8?B?MXh1a0FrVDhySTJCR05vektoeWszNmlIa0t1cTRnMDR5dzF4YmYxNHhoSVZS?=
 =?utf-8?B?WTIyVDEwZ1JoU1ZXUmZwai9LSzQzVXVWQjMvT0ZocTVHTExqa0F2Z3RsK0kx?=
 =?utf-8?B?N0pZVS9YOUVTT3l4Rnc2SjFQQ1JqYmJNN3N6ZkRmUVFGM3JmVURId2wyWnV5?=
 =?utf-8?B?U2k1cFlEdnlRZ0JkeE5qL2Yvck9nZ3NvdDNTVHR5UTlFSXcwMkxUbWdkOVZF?=
 =?utf-8?B?YndjS0ZXOWVnNExxTk1zRllLS3BJRkZVMFNTN0NlRDN0aWVab0k3ei9rVm9z?=
 =?utf-8?B?K0dQNXcrTzZFS3hYcGo4RDlOeDRhdGliRkJhanF6bnRqZUpPRXBtRnZuMU1j?=
 =?utf-8?B?ZnB6dGxvblpMQVJobjl4VkhsTXptNXFOWldadVZDc1NGWVk1bHE4MkdxVHpr?=
 =?utf-8?B?WFJmenJ6MEI1VVpKOXRIUy9kSEhXNC91UmZaaVRvNGVVY1FuVnllbWhTRytN?=
 =?utf-8?B?ZU9MekhwRkN6US94bHZrZkF6RFFxenJDNEJCN0pWZlg0VUhqY2w5dUJIb3BQ?=
 =?utf-8?B?Zmc0Wm1xK3FONkFrODVXQ2Irek9yZHlxbFdDWUJkdytDVTdjS2lkYm5yS2Fl?=
 =?utf-8?B?WTc4QjBoYWRJQ09aVSs1dW0rREY2eCtjMThtcHNYTWhlRW02RmFYQzR2azNJ?=
 =?utf-8?B?empsK3V3S3ZVZHM4STZTT1hsZXpxSnBCZEMwcXZTMTZiQ3ZQc2FqYmR1bWJx?=
 =?utf-8?B?Ty9QZFZuaytXUEQxUk4xOVhYNmRURHdUSDkyL1UreXJJL2JjdjJidnc0RU0y?=
 =?utf-8?B?ZlJQaWFkNkJsZ1E5clBtQjhwdTRWTUlTQkxlMjhsTFE2T1lFL04rRlgrVzla?=
 =?utf-8?B?SEFwcGF3Tkh0Y1N4OWw1OUtOMDFCWDRxNUV5d0djRlg2QzhlUFJsamY3VkNs?=
 =?utf-8?B?OWdPUHUvQ2VBb3Qrb0xKZnFPV3dtblE4bVJnUklxRTFDVE00amFXbjR1Nksy?=
 =?utf-8?B?NG1GK2V2V0pWTWhwSXNxaDVpdExTTkVXdHN2R0FlYW9qZHYrVDR1UGF1WWU5?=
 =?utf-8?B?T2x1LzBJVi9Qb3k0djJUd3AzOVEzYzNKb1p5NVJ3VnNKVGREcE1OdWU5SnN3?=
 =?utf-8?B?NjBOSnJVaktkeDFwRUMxUVBycWNZWEdQQVhWZm0wV1VBUStxWUZrTnRDaVZ5?=
 =?utf-8?B?THczT1pOekpQK1p6OWZXankzeERaWXdibHhTTUplVW80b3h1V3RjUFQ2c1ky?=
 =?utf-8?B?SVo1YXRtdjZ1dHNUV3hPcDhUWUpzdVpMUGcvay9KZGlVWEdoRWFZaVE1dUZU?=
 =?utf-8?Q?MO8b58+iQWyv3Ceu7+NThnDR2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb0f74b-5361-4881-f117-08ddef50a3d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 03:26:18.1145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LI0hCCPgPCH8ow56/gLbKyB5jEI29cDyi7rKhza58FT4sLj+WiWJZF/2uKWW0nuYgocc1hQpMJWbRBBJ8dh8DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11653
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogVG9tIFJpbmkgPHRyaW5pQGtv
bnN1bGtvLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI15bm0OeaciDjml6UgMjI6MzUNCj4g5pS2
5Lu25Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4NCj4g5oqE6YCB
OiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBTaW1vbiBHbGFzcw0KPiA8c2pn
QGNocm9taXVtLm9yZz47IEFscGVyIE5lYmkgWWFzYWsgPGFscGVybmViaXlhc2FrQGdtYWlsLmNv
bT47IFN0ZWZhbm8NCj4gQmFiaWMgPHNiYWJpY0BuYWJsYWRldi5jb20+OyBkbC11Ym9vdC1pbXgg
PHVib290LWlteEBueHAuY29tPjsgQWxpY2UNCj4gR3VvIDxhbGljZS5ndW9AbnhwLmNvbT47IE1h
cmVrIFZhc3V0IDxtYXJlay52YXN1dEBtYWlsYm94Lm9yZz47DQo+IHRoYXJ2ZXlAZ2F0ZXdvcmtz
LmNvbTsgdS1ib290QGxpc3RzLmRlbnguZGUNCj4g5Li76aKYOiBSZTog5Zue5aSNOiBbUEFUQ0gg
djQgMS8yXSBiaW5tYW46IGFkZCBhIG5ldyBlbnRyeSB0eXBlIHRvIHN1cHBvcnQgLmJpbg0KPiBm
aWxlIGdlbmVyYXRpb24gZm9yIHRoZSBpLk1YOTUgcGxhdGZvcm0NCj4gDQo+IE9uIE1vbiwgU2Vw
IDA4LCAyMDI1IGF0IDAzOjQwOjMyQU0gKzAwMDAsIEFsaWNlIEd1byAoT1NTKSB3cm90ZToNCj4g
PiA+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4gPiA+IOWPkeS7tuS6ujogRmFiaW8gRXN0ZXZh
bSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiA+ID4g5Y+R6YCB5pe26Ze0OiAyMDI15bm0OeaciDbm
l6UgNTo1Mw0KPiA+ID4g5pS25Lu25Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3Mu
bnhwLmNvbT4NCj4gPiA+IOaKhOmAgTogVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47IFNp
bW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPjsNCj4gPiA+IEFscGVyIE5lYmkgWWFzYWsgPGFs
cGVybmViaXlhc2FrQGdtYWlsLmNvbT47IFN0ZWZhbm8gQmFiaWMNCj4gPiA+IDxzYmFiaWNAbmFi
bGFkZXYuY29tPjsgZGwtdWJvb3QtaW14IDx1Ym9vdC1pbXhAbnhwLmNvbT47IEFsaWNlIEd1bw0K
PiA+ID4gPGFsaWNlLmd1b0BueHAuY29tPjsgTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0QG1haWxi
b3gub3JnPjsNCj4gPiA+IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgdS1ib290QGxpc3RzLmRlbngu
ZGUNCj4gPiA+IOS4u+mimDogUmU6IFtQQVRDSCB2NCAxLzJdIGJpbm1hbjogYWRkIGEgbmV3IGVu
dHJ5IHR5cGUgdG8gc3VwcG9ydCAuYmluDQo+ID4gPiBmaWxlIGdlbmVyYXRpb24gZm9yIHRoZSBp
Lk1YOTUgcGxhdGZvcm0NCj4gPiA+DQo+ID4gPiBPbiBXZWQsIEF1ZyAyNywgMjAyNSBhdCA0OjA2
4oCvQU0gQWxpY2UgR3VvIChPU1MpDQo+ID4gPiA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPg0KPiA+
ID4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEZyb206IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54
cC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IFRvIHN1cHBvcnQgcGFzc2luZyBzcGVjaWZpYyBjb21t
YW5kcyBkZWZpbmVkIGluIGVudW0gaW14OGltYWdlX2NtZA0KPiA+ID4gPiB0byB0aGUgaW14OGlt
YWdlX2NvcHlfaW1hZ2UoKSBmdW5jdGlvbiwgdGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGENCj4gPiA+
ID4gbmV3IGVudHJ5IHR5cGUgbnhwLWlteDlpbWFnZS4gVGhpcyBlbnRyeSBnZW5lcmF0ZXMgYSBw
bGFpbiB0ZXh0DQo+ID4gPiA+IGRhdGEgZmlsZSBjb250YWluaW5nIHRoZSByZWxldmFudCBjb21t
YW5kcywgZW5hYmxpbmcgZmxleGlibGUNCj4gPiA+ID4gY29uZmlndXJhdGlvbiBkdXJpbmcgaW1h
Z2UgY3JlYXRpb24uDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFsaWNlIEd1byA8
YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4gPg0KPiA+ID4gSSdtIGdldHRpbmcgQ0kgZmFpbHVyZXM6
DQo+ID4gPg0KPiA+ID4gKy9iaW5tYW4vbTMzLW9laS1kZHJmdy9vZWktbTMzLWRkciAob2VpLW0z
My1kZHIuYmluKToNCj4gPiA+ICsvYmlubWFuL20zMy1vZWktZGRyZncvaW14LWxwZGRyL2lteC1s
cGRkci1pbWVtDQo+ID4gPiAobHBkZHI1X2ltZW1fdjIwMjQwOS5iaW4pOg0KPiA+ID4gKy9iaW5t
YW4vbTMzLW9laS1kZHJmdy9pbXgtbHBkZHIvaW14LWxwZGRyLWRtZW0NCj4gPiA+IChscGRkcjVf
ZG1lbV92MjAyNDA5LmJpbik6DQo+ID4gPiArL2Jpbm1hbi9tMzMtb2VpLWRkcmZ3L2lteC1scGRk
ci1xYi9pbXgtbHBkZHItaW1lbS1xYg0KPiA+ID4gKGxwZGRyNV9pbWVtX3FiX3YyMDI0MDkuYmlu
KToNCj4gPiA+ICsvYmlubWFuL20zMy1vZWktZGRyZncvaW14LWxwZGRyLXFiL2lteC1scGRkci1k
bWVtLXFiDQo+ID4gPiAobHBkZHI1X2RtZW1fcWJfdjIwMjQwOS5iaW4pOg0KPiA+ID4gK0ltYWdl
ICdtMzMtb2VpLWRkcmZ3JyBoYXMgZmFrZWQgZXh0ZXJuYWwgYmxvYnMgYW5kIGlzIG5vbi1mdW5j
dGlvbmFsOg0KPiA+ID4gb2VpLW0zMy1kZHIuYmluIGxwZGRyNV9pbWVtX3YyMDI0MDkuYmluIGxw
ZGRyNV9kbWVtX3YyMDI0MDkuYmluDQo+ID4gPiBscGRkcjVfaW1lbV9xYl92MjAyNDA5LmJpbiBs
cGRkcjVfZG1lbV9xYl92MjAyNDA5LmJpbg0KPiA+ID4gK2Jpbm1hbjogRXJyb3IgMSBydW5uaW5n
ICdta2ltYWdlIC1kIC4vaW14OWltYWdlLmlteC1ib290LnNwbCAtbg0KPiA+ID4gLi9zcGwvdS1i
b290LXNwbC5jZmdvdXQgLVQgaW14OGltYWdlIC4vaW14OWltYWdlLW91dC5pbXgtYm9vdC5zcGwn
Og0KPiA+ID4gRmFpbCBvcGVuIGZpcnN0IGNvbnRhaW5lciBmaWxlIG14OTViMC1haGFiLWNvbnRh
aW5lci5pbWcNCj4gPiA+ICttYWtlWzFdOiAqKiogW01ha2VmaWxlOjEzMzk6IC5iaW5tYW5fc3Rh
bXBdIEVycm9yIDENCj4gPiA+ICttYWtlOiAqKiogW01ha2VmaWxlOjE5ODogc3ViLW1ha2VdIEVy
cm9yIDINCj4gPiA+ICtiaW5tYW46IEVycm9yIDEgcnVubmluZyAnbWtpbWFnZSAtZCAuL2lteDlp
bWFnZS5pbXgtYm9vdC5zcGwgLW4NCj4gPiA+IC4vc3BsL3UtYm9vdC1zcGwuY2Znb3V0IC1UIGlt
eDhpbWFnZSAuL2lteDlpbWFnZS1vdXQuaW14LWJvb3Quc3BsJzoNCj4gPiA+IEZhaWwgb3BlbiBm
aXJzdCBjb250YWluZXIgZmlsZSBteDk1YTAtYWhhYi1jb250YWluZXIuaW1nDQo+ID4gPg0KPiA+
ID4gaHR0cHM6Ly9zb3VyY2UuZGVueC5kZS91LWJvb3QvY3VzdG9kaWFucy91LWJvb3QtaW14Ly0v
am9icy8xMjM4OTY1DQo+ID4gPg0KPiA+ID4gVG8gcmVpbmZvcmNlIHdoYXQgSSBhc2tlZCB5b3Ug
YmVmb3JlOiBmb3IgdjUsIHBsZWFzZSBtYWtlIHN1cmUgdGhhdA0KPiA+ID4geW91IHNlbmQgbWUg
YSBsaW5rIHNob3dpbmcgdGhhdCBDSSBoYXMgcGFzc2VkLg0KPiA+DQo+ID4gSGkgRmFiaW8sDQo+
ID4NCj4gPiBUaGFuayB5b3UgZm9yIHlvdXIgbWVzc2FnZS4gSSBhbSBjdXJyZW50bHkgdXNpbmcg
QXp1cmUgUGlwZWxpbmVzIChmcmVlDQo+IHZlcnNpb24pLCBidXQgcmVjZW50bHkgdGhlIHdvcmxk
X2J1aWxkIHN0YWdlIGhhcyBmYWlsZWQgdG8gcnVuIHByb3Blcmx5LiBJIHdpbGwgdHJ5DQo+IGFs
dGVybmF0aXZlIHdheSB0byBydW4gdGhlIENJIHBpcGVsaW5lIHRvIGVuc3VyZSBldmVyeXRoaW5n
IGlzIHByb3Blcmx5IGNoZWNrZWQNCj4gYmVmb3JlIHBvc3RpbmcuDQo+IA0KPiBXaGF0IHByb2Js
ZW1zIGRvIHlvdSBzZWUgd2l0aCB0aGUgd29ybGQgYnVpbGQgcGlwZWxpbmU/IEkgZG9uJ3Qgd2Fp
dCBmb3IgaXQgdG8NCj4gY29tcGxldGUgZXZlcnkgdGltZSBJIHB1c2ggKGR1ZSB0byBob3cgbG9u
ZyBpdCB0YWtlcykgYnV0IGl0IHNob3VsZCBuZXZlciBiZQ0KPiBicm9rZW4uDQoNCkhpIFRvbSwN
Cg0KVGhlIG1lc3NhZ2UgYXBwZWFycyBpbiB0aGUgbG9nczog4oCcVGhpcyBjYW4gaGFwcGVuIHdo
ZW4gdGhlIGpvYiBpcyBjYW5jZWxsZWQgb3IgdGltZXMgb3V0LuKAnSBJIGFtIHVzaW5nIGEgZnJl
ZSBBenVyZSBEZXZPcHMgYWNjb3VudCB3aXRoIGEgcHJpdmF0ZSBwcm9qZWN0IGFuZCBwcml2YXRl
IHJlcG9zaXRvcnkuIFRoZSBtYXhpbXVtIGFsbG93ZWQgcnVudGltZSBvbiBNaWNyb3NvZnQtaG9z
dGVkIGFnZW50cyBpcyA2MCBtaW51dGVzLiBUaGlzIGxpbWl0YXRpb24gc2VlbXMgdG8gYmUgdGhl
IGNhdXNlIG9mIHRoZSBpc3N1ZS4NCg0KSSB3b3VsZCBsaWtlIHRvIGlucXVpcmUgaWYgdGhlcmUg
YXJlIGFueSBhbHRlcm5hdGl2ZSBzb2x1dGlvbnMgYXZhaWxhYmxl4oCUcHJlZmVyYWJseSBmcmVl
4oCUdGhhdCBjb3VsZCBydW4gYSBVLUJvb3QgQ0kgcGlwZWxpbmUuDQoNCkJlc3QgcmVnYXJkcywN
CkFsaWNlIEd1bw0KDQo=
