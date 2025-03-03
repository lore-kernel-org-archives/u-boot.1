Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA6FC282C5
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 10:43:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB4DA811CE;
	Mon,  3 Mar 2025 11:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hGHccmSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFE08811DF; Mon,  3 Mar 2025 11:43:32 +0100 (CET)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8770811B3
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 11:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDzv3LalMvtThEA/es3XHC8BUg1ucjmlrGfoCxpVP/3raRspwB5+k26p5QtveMmG5SzeXH+HSVInbyZBfh93bf9x4w+x1UlHbHYhYPlZR5tN96cnm4Gok0KEEQ6mbnt3JAxL5LtEJuwi/2eOQjVew2ZjH4CkI5uQRZmBwSMF9VBcO8R2izHnsJDJ4JynWjwdI8ucm/6L6EWY8GWLLR6yVlgsRhpKfw/dfbsadTI1+zyP2zelKd+VVmfV+fGMEyuYFc+pFi8cuiBEFWepZurem+k+K8dwA1rhiIxOoXEhdk/o0w0Upcg0m86zyHL+j0bJDjSKarCbpJYydSWRs8ARPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i44l2hIs3LP+6ad2QWkSPRK7HuO415JOXWFZ5+oh2mI=;
 b=DxawBZfYbW3rB0vpSJkLBlgZci713gGSQDhbWJLji3AMB3u093//lcjbNX/oqOn6TOr1b6ZU2NebtHsZ7Q0vmcemByrigW5fC47EglAVwkHo+uQ9KmYupyZFjYBsT0E5Xv9fEDicRWF38qRepKxXUO7Ci7DJi8lMZ/r1vQFrMbRjLFeSxzrrY62+i6N+VP6WEcUsXG3fid+XMsvHxNldaI8GAgTfUqfXKj4zy+hbBIh5vffLQ2CSRN5DArEkF03yqV6dE4Eu04J3MKP++QMOz7SHBzmho65rUUW8WzamqNIf5oCMGllaVqPOCo5ooToVGeoxXRK9L1FZUwxmDiPMvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i44l2hIs3LP+6ad2QWkSPRK7HuO415JOXWFZ5+oh2mI=;
 b=hGHccmSGdzbr9mjhrz1sHoK3B2AD5nnrdJ0pB72ixABpJw4p+bqW79f3ODrQp/xzumDXmB3WQQRrHovCk0t3B/DrGtPw8V8kgQ6BNYP6oKcoB6K6dkiJdH4zhTUmiIT4AneC1+JHjvPbvp9+6af3HQbTEFgFOhbADzWZ6xTaed3wdMj9U5AmlX4FsixWipJg7OiI+JX7PiRbztpkGXj5UHvsFYSQ6Z4DUFfOGnE9Lvrj2mvrFVKfDk1J0B9BItBF/pFdLEnmJWFMNvuZHpDYP2o/fGQUokYa6aYHeObhw/zzb2nxyMQXB0jZj0DHJmaZyyjtVay/6vjQtIFkSBQ+TQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB8910.eurprd04.prod.outlook.com (2603:10a6:102:20d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 10:43:29 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Mon, 3 Mar 2025
 10:43:28 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo
 <alice.guo@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjYgMTAvMjBdIHNjbWlfcHJvdG9jb2xzOiB1cGRh?=
 =?utf-8?B?dGUgc3RydWN0IHNjbWlfYmFzZV9kaXNjb3Zlcl9saXN0X3Byb3RvY29sc19v?=
 =?utf-8?Q?ut?=
Thread-Topic: [PATCH v6 10/20] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
Thread-Index: AQHbic8+xtCcSiIaykqz4mE/g1PaL7NdGV6AgAQjloA=
Date: Mon, 3 Mar 2025 10:43:28 +0000
Message-ID: <PAXPR04MB96444B1F034449DFF881933AE2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
 <20250228-imx95-v1-10-09594e93cc9b@oss.nxp.com>
 <d3722347-031e-4a2f-8898-4f270cf1be05@denx.de>
In-Reply-To: <d3722347-031e-4a2f-8898-4f270cf1be05@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|PAXPR04MB8910:EE_
x-ms-office365-filtering-correlation-id: c0675962-5f02-43b3-1892-08dd5a403c0f
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?eERBTHdYb1BZaDZKYXd4V1l2YVYxTXRVZ1p6aHJ2ejRRWFpBVmpDSEFxVkNH?=
 =?utf-8?B?clQzVVNBV3RGSXZ0YkdocSt2Vy9TT0czUDZYc2JPWDN1di9nRUpBcnkyaGZY?=
 =?utf-8?B?VndqNUFzdjJWVlkrL1oyTG9EaG5WYk5CS2ZISjZvZnU1R1RvQXFYMHIzOUpX?=
 =?utf-8?B?bzZLVG5YeXRYd25SaDNTbmwvRnIyYk1mY2ZlWlQrbVQ3eldNWlZrV1dmN1pC?=
 =?utf-8?B?VVFmRXZ6cG5iL1k4UVZHK0VRMWlCUk1NUko3Mk1WTy9PVExUZklwYUtWZGJx?=
 =?utf-8?B?ZmZRNE0vNzVYK1BObEVudzk1dmhZLzY1WmdCclpLQnJQWjE4VFVXYVd2d3FW?=
 =?utf-8?B?aTAvdTJkOWVrYStDV2N0SUlTTzNPeExVb1Z4c2ZnQUN6Z09pOXdkbjBnR2h2?=
 =?utf-8?B?RG9ZZnVuaHVXTFl6WUxoeFhDWjh5ZmJ5SlRHcUtvWVBSVGdITnFOdGJJaDFB?=
 =?utf-8?B?TnNjTDJyeGk4eG0xMlhESWpOK05CQTZKT3VUNGt4cVVNL1F0TjRLQzdYVDd0?=
 =?utf-8?B?M1JlRHI2TEYzejZkMy9IdGtwendtbmpRZzJFS2dVdVlmc2JVNFNRZlZFUVZK?=
 =?utf-8?B?QVM1M2JoYjBBTURqSFhGTUhrM1JtdGVubG1DU2gvSERBWnBQVWpoaVp4Tk9P?=
 =?utf-8?B?OERSOHU0Wnh1SjVtRERBL3lOQ0plWnd6UklMeWlKS0R5SWk3WUVjdTV0cUgz?=
 =?utf-8?B?RnJDZmZBVzJ6UDVLVGxCb1krbG93bzF6cW80c0xGbTkzaHIzVlZoOWRyUEFU?=
 =?utf-8?B?VStvVjJUWFpDelZFM3hPbDdLdlhwVlFSSXJxV3V6T1h2WTdtT20veXlkMENX?=
 =?utf-8?B?eFFHWXZlRFUvRmEvdnJYRjBFbHRjMDVwRHFjRFZjaHZmMGRxVVhBY1JyM3VP?=
 =?utf-8?B?MWhyak1oL2VLWkoxQjFXRkI3bjMzQWZoNVVKY29HU2t6SnFiRWl4SVNwSWxs?=
 =?utf-8?B?Yk83dkxqTWxaTitzSitwMGxBN2hIQXJwd2UzK2hORWhlWWlqVTBZNk5HN1pq?=
 =?utf-8?B?TXFHVklERnZURm0wemZwY2tXcXlwZTBLQVVuZU1zVElJM2VWQmZrY1hhT3li?=
 =?utf-8?B?cElFS0JJVVE3SW5ENDFBaFlrbm1odytDa2w0SnBhNzZ3cXg5UmxHRjc5SFpx?=
 =?utf-8?B?T1c3NWpkdkp4QzMwa2VEYmd3STNNRjEwT2Z5d294Vms4KzdQbW5qeHFyVUlk?=
 =?utf-8?B?MDI1KzRCSW53SkV5VWd1MW1HQ0VrTzBUMWV2QXlxdjIzdzF2dEZSTUU3Nlp5?=
 =?utf-8?B?Ukx3N0RTWnJDTUF5eVFLS05ycXNRalhkWWIwODZEZ3ZveEVTeFFRTG9oNEpx?=
 =?utf-8?B?TDE0Qi83TEdORllsOHZldEluV0g3K250eHRGMlRVQmxOaUFhODJ3aUVKVkJK?=
 =?utf-8?B?MnlXbmFvNE5UdU1URDV3UGdEMXUxM0JtamhIQ0pPRlpwTWErTDVsaFZuRkdn?=
 =?utf-8?B?alFzc0hJTGZVVDFJSEtvcmt3bFQ2blFkR090dXhiSmg2OEVUSFZuRXd5K0NY?=
 =?utf-8?B?dG5WSmVSWWw1SENKcWw1K3dEVzl1dUtERTJONEU2Uys2Vkk1U1lkNlAvUlQ5?=
 =?utf-8?B?WDd5TGxmUFllSmM3Ym5XU2taRys3dUhXUitqK3A3VG42QWhGdEdBN3JDU2lB?=
 =?utf-8?B?aXY2OXdjMGdXdk9jNHFxUFl5MHJqay9oY3IvTzRON0ZwbjVwSVR6K09ydEpo?=
 =?utf-8?B?Y1kzK1dCVzVzQVNTeGNZUC80MWsreEFDTmFiVDcvWnZ3TGg1czl2a0JJZTQ3?=
 =?utf-8?B?OHpSVzI4dHJjTnYwTE5DdXpjWHNEaWZwNUJTVkFNMFRrSkxpUFE2THNTN0wy?=
 =?utf-8?B?dXZZdGEvZHlFMWZ2OE1ieFV2bFFqN3piREpWclpCdnFUeENSdHRPMkJYbjF5?=
 =?utf-8?B?YlNsWWxvdTZlMzRVd2ZqdVA0elNSVWE2VzdqOXVkZjZaMEQ3djFleWpLV0Np?=
 =?utf-8?B?andQaTVxSjhFVnd0MHJKak5Oa3VtczNaMU84eGcwdm81TlFuMnBNZXlJZWZJ?=
 =?utf-8?B?VlNtaG16U1lBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2hLSzlFcFgwb3Y4VHBMSjZQQUhteTB4U0VkazR5c0ZBOTVmTEZ1aHhvRk9F?=
 =?utf-8?B?d1ovR3pCWmZWMmNWRldlcHFuUHg1NThodjlic1QySXJsK0NNMHVMKy9GZkZZ?=
 =?utf-8?B?T25QM24yamNsVzR4eldCcERPVWsyZFZhdmJxNGFoZGpaSFBDY3BROXRqZHUv?=
 =?utf-8?B?eWt4UkF5L1Z0cC9nWGZIejkwK01mc3B2VzdOZ3pSbDN0NHdNcStoWUJpaW1j?=
 =?utf-8?B?RC95MkxuVTdlUWg1TCtMVjB1ZE1ZNEtUdzZqY1E3ZGlZUmpWcThZRFhkdkhK?=
 =?utf-8?B?bUljenBnK1BzL1dLV2hBRG1YTVhhU0VSNHBxbFJIemE3REQvOC82a1JYckFT?=
 =?utf-8?B?U3BZUjJLTStVZG1rR0VaUDB0K1Q5empud29rYlcwdXdPNTRGVEo0ZFdjczZu?=
 =?utf-8?B?alFLUWtzMkI3YVlrS2Nxa1J0WXh4YjJINDBrcnZjeWYyYnNjZFhnbnQ0dGNZ?=
 =?utf-8?B?ZDRoY3h2SkpkR0FjVWJ1a1lZSWN5NTF3RjFxaHdwZTFvY3pxU3FxQzdYY05r?=
 =?utf-8?B?Z1I0QWZhQldtSDFxQXgrcVB5Tmt3c2Z2OWlTTEhVcTNETmJiUFdPT0d4c1lU?=
 =?utf-8?B?UTZ1ZHo2MldkOU5Lc2lVYWM1Ny9HNXlUK2NlNGE3dXo5RElBd2g0Z2lDWnBr?=
 =?utf-8?B?b3lEUXM4a0t2QU5Na29Ha0JCUzF2M2RuVGkzS2E4SkRmSHBMc0tCN2NTc05y?=
 =?utf-8?B?OS9qOWpYNjZkOURERk9JazNsSE5zaXhpY1Eva3NkTTdaamozY0tIeDVWZGQ0?=
 =?utf-8?B?cWROWXlua3dPcndIRzlMMUo4aWhQeDBadGRvYWtWcFpSZFZXaTZvU2FMY3VO?=
 =?utf-8?B?Mm43alpYZ0YxUmYzc0tBd2MzeU51eGMvaE1EK2s3dWNLUXk3ZjJlWFdodEpq?=
 =?utf-8?B?OVQ3UnliS3VzZWJpd1k3ZXM5MVhFN0NxLy9QQnBueGJRZVdkMzlQVm1sbUpF?=
 =?utf-8?B?YjdaQzBLdkw5N0ZNeU8rdUQ4R1pMNklzdW5LWmVWaG5LTkYxSW9yRVlxYkNj?=
 =?utf-8?B?UC9FaXZYeE1kQXBwR1poQTc0QlluSkRNMGtPQ3pBV0U4enBCOFRIZVZIRzlv?=
 =?utf-8?B?WXpZbVYvWjNOcGZGZ1cyeHFWbzVod2liTkRacnBib1ZYdXFYYzU4VmNtTXNM?=
 =?utf-8?B?VnkwWDBkYjBsb3FKYnYwUVQ5c08yYTM5R3JaVzhKZE9kY2xYMm5BckVqN0cz?=
 =?utf-8?B?Nml3RnRlUm4yM2JYbUpJOFJBaEF0M3hqQWVQb2hFN0d6N0xDMW53V0lXVDlt?=
 =?utf-8?B?bEpYcDJUYWlwb2xpQzhhNzExMjVwSnJPN01DK3U1VWNGSnU4dWFWd2pzTDVS?=
 =?utf-8?B?WWdQM1daOVdrWXZ3NFg2Q2xPMXF0S0R1WnNSZlNHQWRXSURUc08vUmxheTBY?=
 =?utf-8?B?dzhMcGFOUTZCNFdUUWVUdDRSZjN5RlpoUWlEMGhMYVJEQk4xUXBDWjJtT3Nw?=
 =?utf-8?B?OGpxcHFIdG9UTHFDUGNMdWZoa29id29NaTZwczlVYWlGd0ZnSFVjK3VSRXZU?=
 =?utf-8?B?YkwvZEdKM0I2dXFaaWhlbjltTUtJQ0xqQzJHaW44THNEQ1JSZldXNG1PNlZz?=
 =?utf-8?B?T05jdHlBdE53bmh0UUZlUXhNRU1XREFTNGRnaUFBMEJxSU14TGVETDZBamYw?=
 =?utf-8?B?bHlWS25LUVdRTFYwbFpPei9XNmFmZmMxa2lxYlpGdzlWSlhaeFZKZHo0UWhu?=
 =?utf-8?B?VW83TEE0eUhQMTJnMGdhMFVhSCt2dVpPc3NiMnVYNE5JZVBhYXg2bk9DUTJF?=
 =?utf-8?B?eDZPUFF1dU9wQ1o2TjZyRCt0WmxqRTBsOWt3dEV4aEZsVTd3eGRQM01uMmhv?=
 =?utf-8?B?TWl4QytFaks4VjNyT3VzNW9YVXBDWFFxVHAwRlVEc2hZMjlKTnpxY3BMTGxF?=
 =?utf-8?B?THMxLzB4MXlXVVZReHdWOGt1UDN3K3VNTTRtV01IMy9XNllFOWJMOEFDbnlu?=
 =?utf-8?B?bjBwbjl1ZjQ0QmtCMjZxc0QxWmZybXcrWHU1QTdiKzZ4L293bThsUkpLZzM1?=
 =?utf-8?B?SEs4dTJKbUxMdjd6cTVBU3NUOEtSSjVOVVFUaSs1SmNQa3Z1bzBpNHRTNXVp?=
 =?utf-8?B?WXNaa0hEZzVmU3RocTVyOFZ4cG12MjcreEx4V2NNV0RUaHdMay91eDY5ck1x?=
 =?utf-8?Q?TchE1daW54IBJKxltn26/a6j1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0675962-5f02-43b3-1892-08dd5a403c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 10:43:28.7916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FLUvBkuOkhiNiq1pY2oQzNtdID4xYdD/BJ5sosbgIfP6iaICj7NIYCaEwYOXWqOWeIdaO5luBIUjbF74+Cuinw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8910
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
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDPmnIgx5pelIDM6MjUNCj4g5pS25Lu2
5Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IFRvbSBSaW5pDQo+
IDx0cmluaUBrb25zdWxrby5jb20+OyBTdGVmYW5vIEJhYmljIDxzYmFiaWNAZGVueC5kZT47IEZh
YmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdtYWlsLmNvbT47IGRsLXVib290LWlteCA8dWJvb3Qt
aW14QG54cC5jb20+OyBMdWthc3oNCj4gTWFqZXdza2kgPGx1a21hQGRlbnguZGU+OyBTZWFuIEFu
ZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT47IFNpbW9uDQo+IEdsYXNzIDxzamdAY2hyb21pdW0u
b3JnPjsgQWxwZXIgTmViaSBZYXNhayA8YWxwZXJuZWJpeWFzYWtAZ21haWwuY29tPjsNCj4gQWxp
Y2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4g5oqE6YCBOiB1LWJvb3RAbGlzdHMuZGVueC5k
ZTsgWWUgTGkgPHllLmxpQG54cC5jb20+DQo+IOS4u+mimDogUmU6IFtQQVRDSCB2NiAxMC8yMF0g
c2NtaV9wcm90b2NvbHM6IHVwZGF0ZSBzdHJ1Y3QNCj4gc2NtaV9iYXNlX2Rpc2NvdmVyX2xpc3Rf
cHJvdG9jb2xzX291dA0KPiANCj4gT24gMi8yOC8yNSAxMTo1NCBBTSwgQWxpY2UgR3VvIChPU1Mp
IHdyb3RlOg0KPiA+IEZyb206IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiA+DQo+ID4gQHByb3Rv
Y29scyBpcyBhbiBhcnJheSBvZiBwcm90b2NvbCBpZGVudGlmaWVycyB0aGF0IGFyZSBpbXBsZW1l
bnRlZCwNCj4gPiBleGNsdWRpbmcgdGhlIEJhc2UgcHJvdG9jb2wuIFRoZSBudW1iZXIgb2YgZWxl
bWVudHMgb2YgQHByb3RvY29scyBpcw0KPiA+IHNwZWNpZmllZCBieSBjYWxsZWUtc2lkZS4gQ3Vy
cmVudGx5LCBzZXQgaXQgdG8gNCBpcyBlbm91Z2ggZm9yIGkuTVg5NS4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsaWNl
IEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL3NjbWlfcHJv
dG9jb2xzLmggfCA1ICsrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zY21pX3Byb3Rv
Y29scy5oIGIvaW5jbHVkZS9zY21pX3Byb3RvY29scy5oIGluZGV4DQo+ID4gMjY4NGY0MTc3ZC4u
N2NlNzNkZGZhZSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL3NjbWlfcHJvdG9jb2xzLmgNCj4g
PiArKysgYi9pbmNsdWRlL3NjbWlfcHJvdG9jb2xzLmgNCj4gPiBAQCAtMTQxLDExICsxNDEsMTQg
QEAgc3RydWN0IHNjbWlfYmFzZV9kaXNjb3Zlcl9pbXBsX3ZlcnNpb25fb3V0IHsNCj4gPiAgICAq
IEBzdGF0dXM6CQlTQ01JIGNvbW1hbmQgc3RhdHVzDQo+ID4gICAgKiBAbnVtX3Byb3RvY29sczoJ
TnVtYmVyIG9mIFNDTUkgcHJvdG9jb2xzIGluIEBwcm90b2NvbA0KPiA+ICAgICogQHByb3RvY29s
czoJCUFycmF5IG9mIHBhY2tlZCBTQ01JIHByb3RvY29sIElEJ3MNCj4gPiArICoNCj4gPiArICog
VGhlIG51bWJlciBvZiBlbGVtZW50cyBvZiBAcHJvdG9jb2xzIGlzIHNwZWNpZmllZCBieSBjYWxs
ZWUtc2lkZS4NCj4gPiArIEN1cnJlbnRseSwNCj4gPiArICogc2V0IGl0IHRvIDQgaXMgZW5vdWdo
IGZvciBpLk1YOTUuDQo+ID4gICAgKi8NCj4gPiAgIHN0cnVjdCBzY21pX2Jhc2VfZGlzY292ZXJf
bGlzdF9wcm90b2NvbHNfb3V0IHsNCj4gPiAgIAlzMzIgc3RhdHVzOw0KPiA+ICAgCXUzMiBudW1f
cHJvdG9jb2xzOw0KPiA+IC0JdTMyIHByb3RvY29sc1szXTsNCj4gPiArCXUzMiBwcm90b2NvbHNb
NF07DQo+IA0KPiBDYW4gdGhpcyBiZSBtYWRlIGR5bmFtaWMgPyBJIHRoaW5rIEkgYWxyZWFkeSBh
c2tlZCBhYm91dCB0aGlzIGxhc3QgdGltZSwgYnV0IHY0DQo+IGZlZWRiYWNrIHdhcyBub3QgYWRk
cmVzc2VkLCBjYW4geW91IHBsZWFzZSBkb3VibGUtY2hlY2sgdGhhdCB2NCBmZWVkYmFjayA/IEkN
Cj4gd2lsbCByZXZpZXcgbmV4dCB2ZXJzaW9uIG9uY2UgaXQgaXMgYWRkcmVzc2VkIC4NCg0KU29y
cnkgZm9yIG5vdCByZXBseWluZyB0byB5b3VyIGNvbW1lbnRzIGZvciB2NC4gSSBoYXZlIGp1c3Qg
cmVwbGllZCBpbiB2NCBhbmQgd2FudCB0byBkaXNjdXNzIHRoaXMgY2hhbmdlIHdpdGggeW91Lg0K
DQo=
