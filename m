Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEF4C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 10:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A63D981E1C;
	Fri, 28 Mar 2025 11:26:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mB3buOEY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EF2B81E1F; Fri, 28 Mar 2025 11:26:54 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1276881CFD
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 11:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdAL7phAhI9IjjWpP3jnKWEpL1DfdI+jAmUFsvRu4s28nuWZtaqiUW4fNUSMaV6CE5WEIHXMadDTjzTcL8ZHWQwDyzNnQjaw3B8C/N87MDnS0M9N1koVoIK6H4ahAyViZ1m/MLGjqqCSSO4MumUkuKYn2tGDG0jFUL+Xtol0Xl1/LOQ7w23K5wnPx186bEW5EpRidBV5ofXlUGgL1XHTtJh+pMNVA0m+bHGSpatOeC46o7BLEi2pRstV+munGVWwL+Yp1QPo7GezJA8UKHUuQeXk98/O9J3RVBMgc+Xfeh/+T4TqcI3b9/5pc7+INYHTUPf8RE5ViLSnZjwLM7dUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqikprEyV869zuuXG24mdl5Xl4ZLekDM5W1kt8BANWw=;
 b=AAIACDNC1stiZiyExUYq/Et/Ov2Z1f/PDve+B5//10IFDafyIVVFAR/RGYKR+T+Dbo37bvunzUcqOY6VF8ZPrUxYKXqc+vjTjthU0Kpot/bDNL7hxekWbg9bng8nwX+BMc7o48rHlWVS8ocRX4+WanU3i/U2zz6KNmVZZjEiJTOs1lQwhXo8BkUreiw/4LWR+1dA2LOy5lvAZJbeGtfYVmVN0Bz943elpRaIX6qyPsDYu/vM/nRJsGceqgNnJ4waZ+VshgRZ++XTG1VmB2pKbmaKmbxtpEOFHZUO7vEVctBymUuQF191Q4v27myCuqxFyWcjenYowQYikqr/t7wJPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqikprEyV869zuuXG24mdl5Xl4ZLekDM5W1kt8BANWw=;
 b=mB3buOEY0A76UUunQIikCgaQ9PE+lp3hlOx52orDtJtoBqdwjNgkfg+7YivV+PSLvBvtbwt3wg+SnglIvlQHEi/82D8vxamBo9zwzYKS89wnHMTYiK38IkYbdsXcuVtpPZiGZC1pCIa90qNKHLUpFYXAss0tmmwfmld2GoAmaxPXdnT+iPi2Q3+aRQqQcoUgdh8jChQSbMj40J6avRLRcsjqOcdNPgv8j8GmrP4znBiJby1oCrf1Jf/S6L37o9RFE5EM383KAZJh3YAXWIe4swUZeNnwL7eI/GvRJjZ+wf/gABMFqewQ7hVFufw/KXmbwxGtV7/AuPn/qwcKRTKVmQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8570.eurprd04.prod.outlook.com (2603:10a6:20b:435::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 10:26:48 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 10:26:48 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Stefano Babic
 <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo
 <alice.guo@nxp.com>, =?utf-8?B?TG90aGFyIFdhw59tYW5u?=
 <LW@KARO-electronics.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>, Peng
 Fan <peng.fan@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjggMDcvMTldIGNsazogc2NtaTogY2hlY2sgdGhl?=
 =?utf-8?Q?_clock_state/parent/rate_control_permissions?=
Thread-Topic: [PATCH v8 07/19] clk: scmi: check the clock state/parent/rate
 control permissions
Thread-Index: AQHbmjEmwIgKs59o90GSL+fsqCmt37N+aHoAgAn6hNA=
Date: Fri, 28 Mar 2025 10:26:48 +0000
Message-ID: <PAXPR04MB9644F826CFC88160CF9CF2EBE2A02@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-7-f2c8ba815f89@oss.nxp.com>
 <78f7d9f2-6226-49bb-8568-41e7ca0cdaba@denx.de>
In-Reply-To: <78f7d9f2-6226-49bb-8568-41e7ca0cdaba@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM9PR04MB8570:EE_
x-ms-office365-filtering-correlation-id: a8db03b1-7ebc-43c6-63b3-08dd6de30c35
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?QVQ0UjJxZTJzMjBFRzBwUFNPN05oWi92OUlSOWR6N1c5aDl0NWMrQXcrbmhQ?=
 =?utf-8?B?K1RiczRsekpxU0xWdVVkNEhaSEpsWFA0SXlBR2tXMFY5bFcwOHBsOUNrVHkv?=
 =?utf-8?B?TlN1LzVGQUhvR1FoaHdSLzJaU0hjLzloSlhVdGk4cnBRamVLdUNBdGlkTVNC?=
 =?utf-8?B?ZnFqS2VRa0pFRGpRSnJBUVVoWklQdHNmSjNydVdoWW5oRkpxd0hwd0NNTDRo?=
 =?utf-8?B?R1BzeGNyK2NZekRNWkRMK29Yc0pQdThQNk8vdGwxZFRoYTdxN1ljSngzV1JF?=
 =?utf-8?B?YkxBL3g1cHlMYUNWMzZvb2pPNU5ONWhsdUxvdlo1amlBUDhKN0xQa052ZGdH?=
 =?utf-8?B?aG9UekJZNGlaWXVzLys5TTRpZjNoS25DQmFDaWZXTzJqbVduRjlaL2xUbkJJ?=
 =?utf-8?B?enVGLzV3MnJzK0tqeUdUK29ZcEVjK0J0YkxRV0JhWVQ0NG9yVmR5MVZ5K0tC?=
 =?utf-8?B?ME1FY0Nha2o4aTlhdmZvRTA0WllFWlE0WFFhanRSZnpZVHplQThrVHZycWtu?=
 =?utf-8?B?VG9zT29MTzQrck81c0VyenNCcXpWS0VNYW82S0JiaGhmaGpUQ1M0SDRTcFd4?=
 =?utf-8?B?MmJ1ZVNiSWZkbnh4UTJHUWg3WFVVZlhJUCtlTTRORjVEL3pMZ2U5K1dZcjVQ?=
 =?utf-8?B?SXhCb20ybWErRXIvRElyaG93c2pQaVlxbW11dld5MEFpdFZDcWZ6RUpKQ2xs?=
 =?utf-8?B?RHgvZjUrNFcxeXlmM04rWXlnM0w2SWE5a1ZibkN3bWpWdk5Wb1JvWE5xUlZ1?=
 =?utf-8?B?TVpQcmI0WkhlbkdJbVdaa0plYWFEc0VhM3RmOGMvL2djZi9CSktjOFBBZ2Jr?=
 =?utf-8?B?cTh3Z05NZkszb2l3OXdTN0ZCWmlKbFNzQW01cjN0NHZBSXZ4MnlCUVgzOWY2?=
 =?utf-8?B?QjIwWGQ4KzkvMGhmWjRSWkhqN2Z6T3pFTjBtejh5Ykc1aExnS2dWdDBSN20z?=
 =?utf-8?B?K2RESEgrbC9lRWRDbnFNY09zSFo1VHcrR3ZDeU1XSEd1ZXFWZ3pHZmo0L1hH?=
 =?utf-8?B?d0dxZ1R6OVZsLzBJbk5WUmQyZDAwQVRFRlBBUGJvcnRBYjZmYW9ucmNmVjEz?=
 =?utf-8?B?M0QrK1lzbFl6NnpERTIvTEdILzdnSlBGRkRLOXduVGRQVWFOMmx6eXpwcTI3?=
 =?utf-8?B?Ly8wL1RraW5yZEZ1TURrYktyNkpKUTgvc1l5SDJIVEpOR0FOb2hDSGdzd0hU?=
 =?utf-8?B?SkxFUmczLzkxcERDRDcvQUxTN1k5RUdVb3UxblFyZmNJWE1VdFJRVXBVYVRI?=
 =?utf-8?B?SjZvTDZhYytJaDUwSm1vWFArVjYrV25jbzd6clJaMi9QSDBTdmlIWHREYW9Y?=
 =?utf-8?B?dFpDSHF0amk1RnoycTJoU0xiUFNCTEtZcFdPZzQ2TUtwUkh4WlZjbEZzVGJO?=
 =?utf-8?B?d1ROUGlZNDBGWVFhbUFJYVE2SGh5NGF6aW16NW1MUDRudzIxTzlCOU1JMmJ3?=
 =?utf-8?B?ZlZNWFhZZEhmNExRa0tuNmRzUkhzSm9lZGdSWTdZRWNYai84ZmVMUXBpTEtZ?=
 =?utf-8?B?bW9zcEFnbk13SHAza3dHMXV3TWlOYnB6VmliSGN2M25ycmRmNlBCZXJ5YzN2?=
 =?utf-8?B?OUxhWGFWeDZYWXZsa2QrM3J4VU1pMXBBeFFEeGU0TVJXWnpFMDZSMnVmTmNI?=
 =?utf-8?B?alJSbGZxcER0UklFL09aZHRUeGZrdUErbzF5UC9vRzdzVitwcGhHaWVId3dt?=
 =?utf-8?B?WkZVSGI3QVlHWnBDQUc3Y2RlUUlDenpaWGp1SHIyV21NVmFlbjA4ZDFYbGw0?=
 =?utf-8?B?aDFQQnZKa1pUM1ZUU1hZVVduYldmUmhlMU9FYTZYclNxd1ZBRnBjZmlVYVdP?=
 =?utf-8?B?MWE2clhEd2twL01GU1B2SU1WWXl2b3RKaVlYNkJPUTBERG0rUUJSOThhdFRL?=
 =?utf-8?B?UENKZk5YTmkrQVJIV3JxZlh6RDU4TTNBRVJpL3BpWHU2ZUZpRWJ4VlJtdytY?=
 =?utf-8?B?ZG5NMGFvbXVKUFZSZ1U0YnJIdW5rUXIvV0Z0ZWhrWDVsbWMwYU15L0VKMlIz?=
 =?utf-8?B?eDl4V3R1ekJ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anNzOThWaGkrNngvdXBncVNIN3dUK0JRUkI3M2FiekZBZmV2TmxxQlpScUpD?=
 =?utf-8?B?enFIazBEWUJCYWMxY1Mvb3hrdUhLYVlhM08zNmNHaVVGQ2VrQWoybVlPQUhV?=
 =?utf-8?B?TkRaNEJtNE1pVWgydlVCSzBDOGpCTENGRStZL0xtOUxFUU5sd1doS0d2QUtN?=
 =?utf-8?B?M2V5Z0hDSS8yU1lseldyM05zcFN1M3J3R04vSndQWGtKaFNnNDAwblJHdWVZ?=
 =?utf-8?B?ekVSNU02Y3dIMUpQbTdNVHEzNWErMlVUcHN0ak5ZNlVDZS8xbDZpVHQrSHVs?=
 =?utf-8?B?YmtLd1JyRU5LQ2x5R2JKZmdrcDYwaVlaTVd6Z25SODlXSm1SWnlwaWUxTEsx?=
 =?utf-8?B?VXFCamFtRklHTWVDdmduMVF6TTlPTW5RNWZJQzUrUmxFYmJqelFlWUMwUkl0?=
 =?utf-8?B?TlpPSzdyS2pWTjgxdFdXRFVLQmt2Um45MFBDOThpTlZlOGxEOWZoYXI3Yk5q?=
 =?utf-8?B?bVlEc2NXTTJkejRZbFloYStSZ0hKTXVEcEU1R29SN0lCRWxIZGdCS0FYL0c0?=
 =?utf-8?B?bWc3d1Q0OXdiTi8wbmRwazhxckR4OVBZaG1oNWkycnF5YzZkaFJpcHVVSW9l?=
 =?utf-8?B?Znd2ZXk2MFJWZkt4UDl4OFBWbDFRRUVkR2pDMjJpLzR6QlJkY1hlT0xBWm1w?=
 =?utf-8?B?Z2ZxUW1QZmpQdlRQTkxNa2tQWk9YMG1MejMwUTJHWFRhRHcxN0FiSjVVdjZP?=
 =?utf-8?B?SGRzSk9taHJ4ZmZFc0x2RzVQVHdoZjhPK0pmazFtQ05rTFIzai9qemFhLzd5?=
 =?utf-8?B?M1dSVVFxNlc3UVN0V1ZRNzdIRFRybTlZOGdqbXZ4T2pGL0VGNHRtQTFJK1lU?=
 =?utf-8?B?SmJzV2ZUVS8vSWl3NFN6NmNXSDhINmE4bFhPZEx5OXgzL0J6Tk9Ia01tNDRk?=
 =?utf-8?B?R2xMWlJwUU5JdDN1bG0zWWFsVmxVQ0Fwby9nbjBNTVM5aXFhbU1WTGxwdUhj?=
 =?utf-8?B?Nnc4ZXRCdXpuNlZEcWRlUFpoU1doSzRQRXI3VFh1dnZHOHh2VUsrZFlkQWxR?=
 =?utf-8?B?YUU1dlFPMmc5YS91Ylk2aVAyL1N1VWJubTd2UFJxL3c5bEhjb080SERTVnRi?=
 =?utf-8?B?QkpPOU4vellndC9wcExMUHJzaElrUEZOR0lEUS9BZkcweFcvcUNRZGRWVVFx?=
 =?utf-8?B?UEMzcEVWTUVKYW52OFN3VitZNmtOQWZVSFJnNVJRK3ExNkRIano5Q3dKWnN0?=
 =?utf-8?B?RjBkL0lkTDNxRXJadVFYZ3dWODR6Z0RlQ0o2RE1rdkRobmpFcVprR0dnYUxQ?=
 =?utf-8?B?VTVzWTBZN3BDSEJ3eWI2UkIvV09xWGg3YkdUZit3c2IyazJ1T04vaE5GeFBP?=
 =?utf-8?B?SldBbXQyT2c2cXBoMkJidVJRelhLQVd3dzF4RU05UGh6WXVxdTFYamxLNnVx?=
 =?utf-8?B?UzdFNVMvRXBmdFZsWU1nR25VYllWY3ZCSlB3bnRlRDRYcjJGRjF0bGY2STh4?=
 =?utf-8?B?QzJKVDdoMDFYcWwyaStGTEg0WHRkY3hkS1ZtNEU2L0JPdGNlRm52V29FVEo3?=
 =?utf-8?B?Umd1ZG9qMmdxMHFmem05UGhQeVhtVHEyWnBOdit2endsNklubEZNZFp1aUkv?=
 =?utf-8?B?d3Z3OG5yQ3Q1Ylh5WnlRNW5kNFJhakhIVzZXMnB3dzdDYVVOdW1FbElMZm1M?=
 =?utf-8?B?dkVqemxaandiWWNFTlNuQmdZMFZISUNIY3ByQ2lpS0FFN0pHVDRkeW5oc1U0?=
 =?utf-8?B?VCtCeGhkTG9QdlYxTGdhQnVBdGh1STVzVDNsQmJJZDMzRE90a05JdWN4c0ZD?=
 =?utf-8?B?eHpWTlVrZ0QwOUx3R1BzUW9kME91WEw2Nk9HZUtGc0JQdE52THV5L2gydXpC?=
 =?utf-8?B?N245NVN1TDl4RmF5Vk5CODJNNGFtQmVmUGZFMkVLU0oxSVFBaXg0a2xGTXVn?=
 =?utf-8?B?b2RZSWc4cWN5MGlUdE5xcEd6aWhVTFRNQ0M5TEg5Yk1mRnFab2RjNnZ5dVJa?=
 =?utf-8?B?aWpvZXNBeGYxajVwOE1wV0c1blBzVWl2cE5aOExHdSswQm5MUG9abzg3NlZy?=
 =?utf-8?B?NVdIVFVkdWswZmNUT1hSQUU5cGRKYk41RSs2UmJKNWpGbHpOOGVOa0ZCdzlz?=
 =?utf-8?B?ODYwRXlNdS9JT0ZQTUs2SWFlUHA0ekhpU3J3MTVTdGZ2dHdqR2FQRklXZDRY?=
 =?utf-8?Q?9kL4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8db03b1-7ebc-43c6-63b3-08dd6de30c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 10:26:48.6122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6nZ7TltfE0PWK4baXePS3NjDXtl/YueXRQjeF56+DeEMWieTHanlDnACTI2siZL+Yyd85zAtvE3TAnJMVGxfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8570
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmV4
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDPmnIgyMuaXpSAxMDowMg0KPiDmlLbk
u7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPjsgVG9tIFJpbmkN
Cj4gPHRyaW5pQGtvbnN1bGtvLmNvbT47IEx1a2FzeiBNYWpld3NraSA8bHVrbWFAZGVueC5kZT47
IFNlYW4gQW5kZXJzb24NCj4gPHNlYW5nYTJAZ21haWwuY29tPjsgU2ltb24gR2xhc3MgPHNqZ0Bj
aHJvbWl1bS5vcmc+OyBTdGVmYW5vIEJhYmljDQo+IDxzYmFiaWNAZGVueC5kZT47IEZhYmlvIEVz
dGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47IGRsLXVib290LWlteA0KPiA8dWJvb3QtaW14QG54
cC5jb20+OyBBbHBlciBOZWJpIFlhc2FrIDxhbHBlcm5lYml5YXNha0BnbWFpbC5jb20+OyBBbGlj
ZQ0KPiBHdW8gPGFsaWNlLmd1b0BueHAuY29tPjsgTG90aGFyIFdhw59tYW5uIDxMV0BLQVJPLWVs
ZWN0cm9uaWNzLmRlPg0KPiDmioTpgIE6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBZZSBMaSA8eWUu
bGlAbnhwLmNvbT47IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29tPg0KPiDkuLvpopg6IFJl
OiBbUEFUQ0ggdjggMDcvMTldIGNsazogc2NtaTogY2hlY2sgdGhlIGNsb2NrIHN0YXRlL3BhcmVu
dC9yYXRlIGNvbnRyb2wNCj4gcGVybWlzc2lvbnMNCj4gDQo+IE9uIDMvMjEvMjUgODoxNSBBTSwg
QWxpY2UgR3VvIChPU1MpIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+ID4gK3N0YXRpYyBpbnQg
c2NtaV9jbGtfZ2V0X3Blcm1pc3Npb25zKHN0cnVjdCB1ZGV2aWNlICpkZXYsIGludCBjbGtpZCwN
Cj4gPiArdTMyICpwZXJtKSB7DQo+ID4gKwl1MzIgdmVyc2lvbjsNCj4gPiArCWludCByZXQ7DQo+
ID4gKw0KPiA+ICsJc3RydWN0IHNjbWlfY2xrX2dldF9wZXJtaXNzaW9uc19pbiBpbiA9IHsNCj4g
PiArCQkuY2xvY2tfaWQgPSBjbGtpZCwNCj4gPiArCX07DQo+ID4gKwlzdHJ1Y3Qgc2NtaV9jbGtf
Z2V0X3Blcm1pc3Npb25zX291dCBvdXQ7DQo+ID4gKwlzdHJ1Y3Qgc2NtaV9tc2cgbXNnID0gew0K
PiA+ICsJCS5wcm90b2NvbF9pZCA9IFNDTUlfUFJPVE9DT0xfSURfQ0xPQ0ssDQo+ID4gKwkJLm1l
c3NhZ2VfaWQgPSBTQ01JX0NMT0NLX0dFVF9QRVJNSVNTSU9OUywNCj4gPiArCQkuaW5fbXNnID0g
KHU4ICopJmluLA0KPiA+ICsJCS5pbl9tc2dfc3ogPSBzaXplb2YoaW4pLA0KPiA+ICsJCS5vdXRf
bXNnID0gKHU4ICopJm91dCwNCj4gPiArCQkub3V0X21zZ19zeiA9IHNpemVvZihvdXQpLA0KPiA+
ICsJfTsNCj4gPiArDQo+ID4gKwlyZXQgPSBzY21pX2dlbmVyaWNfcHJvdG9jb2xfdmVyc2lvbihk
ZXYsIFNDTUlfUFJPVE9DT0xfSURfQ0xPQ0ssDQo+ID4gKyZ2ZXJzaW9uKTsNCj4gDQo+IFdvdWxk
IGl0IGJlIHBvc3NpYmxlIHRvIHF1ZXJ5IHRoZSB2ZXJzaW9uIGluIC5wcm9iZSgpIG9uY2UgYW5k
IGNhY2hlIHRoZSB2YWx1ZSBpbg0KPiBwcml2YXRlIGRhdGEgPw0KPiANCj4gPiArCWlmIChyZXQp
IHsNCj4gPiArCQlsb2dfZGVidWcoIiVzOiBnZXQgU0NNSSBjbG9jayBtYW5hZ2VtZW50IHByb3Rv
Y29sIHZlcnNpb24NCj4gZmFpbGVkXG4iLCBfX2Z1bmNfXyk7DQo+ID4gKwkJcmV0dXJuIHJldDsN
Cj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAodmVyc2lvbiA8IENMT0NLX1BST1RPQ09MX1ZFUlNJ
T05fM18wKSB7DQo+ID4gKwkJbG9nX2RlYnVnKCIlczogU0NNSSBjbG9jayBtYW5hZ2VtZW50IHBy
b3RvY29sIHZlcnNpb24gaXMgbGVzcyB0aGFuDQo+IDMuMC5cbiIsIF9fZnVuY19fKTsNCj4gPiAr
CQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXQgPSBkZXZtX3NjbWlf
cHJvY2Vzc19tc2coZGV2LCAmbXNnKTsNCj4gPiArCWlmIChyZXQpIHsNCj4gPiArCQlsb2dfZGVi
dWcoIiVzOiBnZXQgU0NNSSBjbG9jayBtYW5hZ2VtZW50IHByb3RvY29sIHBlcm1pc3Npb25zDQo+
IGZhaWxlZFxuIiwgX19mdW5jX18pOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4g
Kw0KPiA+ICsJcmV0ID0gc2NtaV90b19saW51eF9lcnJubyhvdXQuc3RhdHVzKTsNCj4gPiArCWlm
IChyZXQgPCAwKSB7DQo+ID4gKwkJbG9nX2RlYnVnKCIlczogdGhlIHN0YXR1cyBjb2RlIG9mIGdl
dHRpbmcgcGVybWlzc2lvbnM6ICVkXG4iLA0KPiBfX2Z1bmNfXywgcmV0KTsNCj4gPiArCQlyZXR1
cm4gcmV0Ow0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCSpwZXJtID0gb3V0LnBlcm1pc3Npb25zOw0K
PiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gDQo+IFsuLi5dDQo+IA0KPiA+IEBAIC0xNTYsMjkg
KzI2Nyw0NCBAQCBzdGF0aWMgaW50IHNjbWlfY2xrX3Byb2JlKHN0cnVjdCB1ZGV2aWNlICpkZXYp
DQo+ID4NCj4gPiAgIAlmb3IgKGkgPSAwOyBpIDwgbnVtX2Nsb2NrczsgaSsrKSB7DQo+ID4gICAJ
CWNoYXIgKmNsb2NrX25hbWU7DQo+ID4gKwkJdTMyIGF0dHJpYnV0ZXM7DQo+ID4NCj4gPiAtCQlp
ZiAoIXNjbWlfY2xrX2dldF9hdHRpYnV0ZShkZXYsIGksICZjbG9ja19uYW1lKSkgew0KPiA+IC0J
CQljbGsgPSBremFsbG9jKHNpemVvZigqY2xrKSwgR0ZQX0tFUk5FTCk7DQo+ID4gLQkJCWlmICgh
Y2xrIHx8ICFjbG9ja19uYW1lKQ0KPiA+ICsJCWlmICghc2NtaV9jbGtfZ2V0X2F0dGlidXRlKGRl
diwgaSwgJmNsb2NrX25hbWUsICZhdHRyaWJ1dGVzKSkgew0KPiA+ICsJCQljbGtfc2NtaSA9IGt6
YWxsb2Moc2l6ZW9mKCpjbGtfc2NtaSksIEdGUF9LRVJORUwpOw0KPiA+ICsJCQlpZiAoIWNsa19z
Y21pIHx8ICFjbG9ja19uYW1lKQ0KPiA+ICAgCQkJCXJldCA9IC1FTk9NRU07DQo+ID4gICAJCQll
bHNlDQo+ID4gLQkJCQlyZXQgPSBjbGtfcmVnaXN0ZXIoY2xrLCBkZXYtPmRyaXZlci0+bmFtZSwN
Cj4gPiArCQkJCXJldCA9IGNsa19yZWdpc3RlcigmY2xrX3NjbWktPmNsaywgZGV2LT5kcml2ZXIt
Pm5hbWUsDQo+ID4gICAJCQkJCQkgICBjbG9ja19uYW1lLCBkZXYtPm5hbWUpOw0KPiA+DQo+ID4g
ICAJCQlpZiAocmV0KSB7DQo+ID4gLQkJCQlmcmVlKGNsayk7DQo+ID4gKwkJCQlmcmVlKGNsa19z
Y21pKTsNCj4gPiAgIAkJCQlmcmVlKGNsb2NrX25hbWUpOw0KPiA+ICsJCQkJZnJlZSgmYXR0cmli
dXRlcyk7DQo+IA0KPiBEbyB5b3UgcmVhbGx5IG5lZWQgdG8gZnJlZSgpIGFuIHUzMiBhdHRyaWJ1
dGVzIGhlcmUgPw0KPiANCj4gPiAgIAkJCQlyZXR1cm4gcmV0Ow0KPiA+ICAgCQkJfQ0KPiA+DQo+
ID4gLQkJCWNsa19kbShpLCBjbGspOw0KPiA+ICsJCQljbGtfZG0oaSwgJmNsa19zY21pLT5jbGsp
Ow0KPiA+ICsNCj4gPiArCQkJaWYgKENMS19IQVNfUkVTVFJJQ1RJT05TKGF0dHJpYnV0ZXMpKSB7
DQo+ID4gKwkJCQl1MzIgcGVybTsNCj4gPiArDQo+ID4gKwkJCQlyZXQgPSBzY21pX2Nsa19nZXRf
cGVybWlzc2lvbnMoZGV2LCBpLCAmcGVybSk7DQo+ID4gKwkJCQlpZiAocmV0IDwgMCkNCj4gPiAr
CQkJCQljbGtfc2NtaS0+Y3RybF9mbGFncyA9IDA7DQo+ID4gKwkJCQllbHNlDQo+ID4gKwkJCQkJ
Y2xrX3NjbWktPmN0cmxfZmxhZ3MgPSBwZXJtOw0KPiA+ICsJCQl9IGVsc2Ugew0KPiA+ICsJCQkJ
Y2xrX3NjbWktPmN0cmxfZmxhZ3MgPSBTVVBQT1JUX0NMS19TVEFUX0NPTlRST0wgfA0KPiBTVVBQ
T1JUX0NMS19QQVJFTlRfQ09OVFJPTCB8DQo+ID4gKwkJCQkJCSAgICAgICBTVVBQT1JUX0NMS19S
QVRFX0NPTlRST0w7DQo+ID4gKwkJCX0NCj4gPiAgIAkJfQ0KPiA+ICAgCX0NCj4gPg0KPiA+ICAg
CXJldHVybiAwOw0KPiA+ICAgfQ0KPiANCj4gWy4uLl0NCj4gDQo+ID4gICBlbnVtIHNjbWlfY2xv
Y2tfbWVzc2FnZV9pZCB7DQo+ID4gICAJU0NNSV9DTE9DS19BVFRSSUJVVEVTID0gMHgzLA0KPiA+
IEBAIC03MzgsNiArNzM5LDcgQEAgZW51bSBzY21pX2Nsb2NrX21lc3NhZ2VfaWQgew0KPiA+ICAg
CVNDTUlfQ0xPQ0tfUkFURV9HRVQgPSAweDYsDQo+ID4gICAJU0NNSV9DTE9DS19DT05GSUdfU0VU
ID0gMHg3LA0KPiA+ICAgCVNDTUlfQ0xPQ0tfUEFSRU5UX1NFVCA9IDB4RCwNCj4gPiArCVNDTUlf
Q0xPQ0tfR0VUX1BFUk1JU1NJT05TID0gMHhGLA0KPiANCj4gQmV0dGVyIGNhbGwgaXQgU0NNSV9D
TE9DS19QRVJNSVNTSU9OU19HRVQgdG8gYmUgY29uc2lzdGVudCB3aXRoIHRoZSByZXN0IG9mDQo+
IHRoZXNlIGZpZWxkcyAsIHVubGVzcyB0aGlzIGlzIHNvbWUgU0NNSSBzcGVjaWZpY2F0aW9uIG5h
bWUgPw0KDQpDTE9DS19HRVRfUEVSTUlTU0lPTlMgaXMgZnJvbSBBcm0gU3lzdGVtIENvbnRyb2wg
YW5kIE1hbmFnZW1lbnQgSW50ZXJmYWNlIFBsYXRmb3JtIERlc2lnbiBEb2N1bWVudCAzLjIuDQoN
CkJlc3QgUmVnYXJkcywNCkFsaWNlIEd1bw0K
