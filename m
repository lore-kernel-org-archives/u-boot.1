Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33087D75BCD
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 07:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0A0089677;
	Thu, 21 Nov 2024 08:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="aTn2GhOI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EE8089675; Thu, 21 Nov 2024 08:59:20 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1295989677
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 08:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNznPtR0WLQnSD2Mq9Hqrs8+j4fJHBNse4vNNM5uEwiVPcI0UlIlc7eG/5tKs7OkhZA0tgxW4wxJIDcDsEqGjTsMl3rlX3r7tmhZuT1Q3H9sdz/rKTEzeV+ockK3F2G/QGIH9K/uQeBhC7Dk48Uu78kVXY98TJjjv3XZ7+Dz+yrsgJYKB+TUAPZ4sLutODLvDvd467edHGXBu+7gaMEVPBe+KeAU6BmDmD06dX0Ul/hSE6YjBhwhZBAH4uzZlA8dOBWeMJ3Yr6CuoGQTvUVkZDPSysl+1sW4St9YXkDV5oagvwTWIg0HMXcoynOJiQmSHcZmax3EVSk8F5D/JhRPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zvl6w4HkMDFjqd0U+r5RPGN63r5rsfsBvNVV83rEpNo=;
 b=RN7RWdGK+kAyS/6lW/Dt2YL4dv0qPlZ8KCR0epdkOLNfKprcOxSVR+UFXU6XzC4cQhxky49CgF6Ryi7EP5jJm4Fg6GTKOSXHQTniMPQJHvLHna2UANyH5rnriDVIdqgUW9rHZtgYgoXU1jOqrmoc3FM162mKxJeIKo/oFrZkKq8YIw3cWdsv+ZhxUw+LkZXlsdkMFRCWMLLaQbGTdnVfDRyBiNtNEPR4AQJ2aTTPf+PjJlNo7mC05ugwZ2McnaClXNC+Yujn/UsfxR9x2UR33rCCcQG4v2elCTefus/75tlxwtKLf7X7ERggO2gG1vbsVHKVVlpwkOujtlta7f7eNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zvl6w4HkMDFjqd0U+r5RPGN63r5rsfsBvNVV83rEpNo=;
 b=aTn2GhOIwMcwpPd34YDMXWcy30/2a6waTYkVgPx4m3xxUFjwpy7E+qS+418CQO6x8b2BlaBOVMEqXLDRP1S2xZ6XDOutMYDG0ysaJced3gbI37+cNlMaA/nISUrh0GCLlDqH0YLVksBBT/3sKFQzt2DHqzew4gayZbi3zmVtN5NgXCgqEXNiIvGJFr7yDhzulgYVvldLTkcJYWCcOSsSeZqL32i2gUzE7B2rLOhzLyyFSbB4dzuDyIrSKLFUEeWMVJ3oWAUSBSimQtGUjv6C1A4NhJl1xSnZ5WSUiUE08XFs0UoJUHd2YLJ6W5lnU0Ieht0GBcKai/GvN0fG0347CA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS2PR10MB7131.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.12; Thu, 21 Nov
 2024 07:59:15 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 07:59:15 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>, "Li, Hua Qian" <HuaQian.Li@siemens.com>, "Su, Bao
 Cheng" <baocheng.su@siemens.com>
CC: "sr@denx.de" <sr@denx.de>
Subject: Re: [PATCH] watchdog: rti: drop hack manipulating WDT clock rate
Thread-Topic: [PATCH] watchdog: rti: drop hack manipulating WDT clock rate
Thread-Index: AQHbO5sgeSRd5BT9xUi5l6putblZ47LBQpsAgAAcsIA=
Date: Thu, 21 Nov 2024 07:59:15 +0000
Message-ID: <8b7025ad09a0080e4e1f94407cc075a1c345c6db.camel@siemens.com>
References: <20241120222412.1873381-1-alexander.sverdlin@siemens.com>
 <9cdf32bb-d76a-42e5-8f81-7cafa753f14c@siemens.com>
In-Reply-To: <9cdf32bb-d76a-42e5-8f81-7cafa753f14c@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS2PR10MB7131:EE_
x-ms-office365-filtering-correlation-id: 213b7246-77e0-4b61-ba11-08dd0a02650d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YjhIQVZXQXZ4b0VibWxoUGRnNTdhN0ZidUJIakczcVBtRHRHZWNqVVdtdlJ4?=
 =?utf-8?B?bXVmMTkwbVBjTlJlaGlNV1ZEdmo4M3pFZk0wTWtJS3dPTWVybHJXMUUwTU1n?=
 =?utf-8?B?VmVIQWxNb2t0eWZRbU1jZDdNcDl2R2w0ZTdoODYrUWRNS01IVjNvOUZaTWwx?=
 =?utf-8?B?dFVrZ29Bc1pLbGFRQ0pidVVOZzMxSGxkT2Q5RWpLR2hWcVNXNFdYZEVmWEJE?=
 =?utf-8?B?b3JvSWpPVkIrQWV2OURIeUptU1pRZ2N6QnlIOVpiRFVTMlc5Z0xzTTRDaGx2?=
 =?utf-8?B?dVVuYXZTN2FOVmZ1RDRSOWxXbDN4Ly9pcXBxN3dXa01WSU9QZzNLckk2QTYw?=
 =?utf-8?B?cjF5d0JYTnp2bFduT0E1K0h0YmQxeFNzbGVzaHA5Zy9YbmMxZUlTSjNGVkRB?=
 =?utf-8?B?YytFeWlSRVpUR0hjdEQ5NDZpaEVWVHhya3Q3NWphTlcrSS8xSDN6QVBUMUVX?=
 =?utf-8?B?ZmVuRUkzemYwWWcrOHFkWG94aVNocHlxbjhweVdMZUpieEVEUEYxWHFWMUpQ?=
 =?utf-8?B?RVNzOG5HMGx1QUxsb3l6NVlwQis2R2Njc210Wmw1b1J1ZDhiYjFmVDUvUWp3?=
 =?utf-8?B?RFlVMmZSMWtmUjNid3FKRUZ0WXhuVEcwaWNkUE1DOThobGttMFJ4dmtXL0NI?=
 =?utf-8?B?ckNZcml6dG1wS2FYTFdlS09Md0N4bTNrWXRQOUw1T1FUU2Q1SnlLc3BqOVFS?=
 =?utf-8?B?S25mZ244ZUY5US9FOU95ajBNTUN4UFBpTmlUSUc4ZlNmeWw0c3hOUE0xMWhv?=
 =?utf-8?B?b1BpS283Sy9xTm1xaG9XTkY2RnVka25CNEhsNzQwSWNIcjZ2Uno2dGJuSnFx?=
 =?utf-8?B?bVZBTUtNajZWRHJ5andwTC9TQURJTzcrT1FXUGc4bTgxeExWZFVCSitCcFlv?=
 =?utf-8?B?MGxTckhUV2xONURqdnhjQWFQMmxNU09VVVVLa2tJUENNZHE3WktSNlgvTXJE?=
 =?utf-8?B?MERLYzhad1pETUpzcHJPMlE0QWZzRXJGTmhkT1JhMWRQVVJFeCtZUDB1SExH?=
 =?utf-8?B?MCtYVU1LdW4xRi9aRzNha2gyMEV2MmNxVEdyNm4yTTY0U3M5Tmxrczc5eXJ4?=
 =?utf-8?B?UmRaU3BCYXJOM1dSM2NpZkVMN0FkdDdha28yVHJpMmlKditodDBWNTZMTFBm?=
 =?utf-8?B?Sjg4eWJ2aUtnU3U2VEY2S2U1Y09Nd3BnOWdFb2dsUEJVbDFPTUFGd2E1Lytx?=
 =?utf-8?B?bjRMTWJwdjVnY29LeW9jbFdCcU9TVDI2aERFS1lpRkpoSmVNSUUzeXhiTWdU?=
 =?utf-8?B?NVcvNXQ2ZWo2NkFNNCtJTHJMRnhPRVhjZDNmbjRkUVVxWEViMjBTSDJacWhR?=
 =?utf-8?B?bkUrNzZQTC9yREc0YW9xajhGaThFUU9naTJROHp2UzdpRmlGeGZpRUZza3A2?=
 =?utf-8?B?d2F2MkZ4Z2xqRDAwaUpNcjM2dlZHM2JjY1R4bktEN0orS0VXdk9tRDNpUUQ2?=
 =?utf-8?B?TGV4R216Z0MxMndKK3JlU3FWM0VCSzIvemNSU3JNWXJ4anNSNzJMNlZjVExW?=
 =?utf-8?B?S2FmNEhjRjlBd1BncjlQK2IvT2srWVhYYWlUSmhGK2VxUlVpQmhnb3VOdlpI?=
 =?utf-8?B?cW9wVFZ5Y2NHVEpZT2FIb0hWTEU0TFFaNVFxQ0NwT2dIL1RXK1JsR2Zwak92?=
 =?utf-8?B?aGxtUzBvbzlSZ0hNQ2UzeFJoYk50czFyTFEzMVVOd0s0MTlzYTBSRVg3MDhB?=
 =?utf-8?B?SFdHSDJXRnJwcXlxTVdWcXd5Y2Z3RW5BTXFMMUxyTEMwNm5CODdmN1Y3ekxy?=
 =?utf-8?Q?XZDpkBwQ2vSaYdT1Fe+YOeQroP0f24jBEegWiVO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVdKZTJXWUdHdENUZVpaTCtVUURkRnlOS0hLTzZqcExzd0hwaERySlhOS1Ra?=
 =?utf-8?B?OXdNQ1FzS1ZNbStUSGhpWVg2WGJ2ODJVNzBucVU1VThabGdHQkFmOUw1anlS?=
 =?utf-8?B?TUhibmhRL2t4ci91aVBHWkU5di9PdS9PMHd2NWRxUXNzSzRGZXIzQlRWVW85?=
 =?utf-8?B?NVV6aWhZMW9WKzdqQ3FwSUg1VjVJeGhadnZhZGt6NDh6T1pjREZ3Q3lvTG9l?=
 =?utf-8?B?VkVnMHJlV3pOR21xaVhnY0hjeUdmc005OS9CTDdFNlJ3QXBiTzg2YlJMSHpp?=
 =?utf-8?B?d240cWpEWkc0TDVqKzdCbmFFM1JMVmtnQTBkN09tcVp3a2J2YkgyWGhyazF4?=
 =?utf-8?B?bTRYZmpzTFhHbWJwVHBkR3hkWUJVUHhIb3Q0NmFQK1BaZlJIMWNkUUcxQjA2?=
 =?utf-8?B?SlBHSGlXL2FNaDZjWTdYeHd0bG5Zb0RVQXZ0RlI0R0pIY1VybXZCOHBwUGFP?=
 =?utf-8?B?SEY1dklNZzVHYm1JYk00aFhncmdGNUw5bEtHcjFrb2xwSFROVXZ6WVYzYmlV?=
 =?utf-8?B?NmFmOHJyeGZMcVhOSHQxa0VPTm5EZnRxY1d6S3ZBLzBzK0tYaGwrMEx0dTA1?=
 =?utf-8?B?VFJEYVRZaklPRDdnWXRZRmVwNmN4Z2MzcU1MWHcySUZkRnZRK0duNTVSTEE4?=
 =?utf-8?B?NHhnVDNxUXA5Z0krdUJHSlMySlBwOUpOSDBwZHdiQkxESGJJeHRENVJFcFlJ?=
 =?utf-8?B?RTEvaGxoNDBJc3hVdDhXeWhjOElNYmdtUkVaWnMxT09xYjU4ZDdxa3c3b29O?=
 =?utf-8?B?UFEvQWl1UG45cXJzRVJBOUd4MHpJeFZ6U2NQZGdEclh1emhyY2dYQ0E0aHFB?=
 =?utf-8?B?UVJhakVzTFpmaDh1NFp0eXExVmRJamxpT2twSmliazh5WVhyVURaL3JZTVho?=
 =?utf-8?B?M1JZWXFrMVpNZVVya0w3MWlCa0s5WmxDVkRveWpJK3NEU3lsdXhIWlZxUUVB?=
 =?utf-8?B?SVl3Uk0rVXo2OGgyWkdQNGpJSFlmV24xbmNOR3NxQXRMV2RXVWo3bUlaTzNn?=
 =?utf-8?B?SXk1Qk9HYURkV2V1WlpWdzNiL3VscXNPWTlQcS9GZkFxTWtteUsvSWZsUzhL?=
 =?utf-8?B?YXBmckpvM0FpcjZUYjRCTFVURTF1bHlWSEI4K2Y5SFk0eUExSXdQZUNkZmh5?=
 =?utf-8?B?cHNlQm5YK1g3ZG9XQlBONWVpcnk5cnptNlhrT3hNT1hCWHBwbmFHblpXT3hY?=
 =?utf-8?B?bDREaHk1d3doZXFURjhhWng0WGZHY0picElaV3l1U2srdEN3SWxRNW5uMFZI?=
 =?utf-8?B?QksrUGpCZnFxZlcyOEFnTGVWRzYrWEFzWHVobWMwd2ZUMjcvQU5uYWpoRVNq?=
 =?utf-8?B?bWxZMmY2TUhjM0Q1RHBGVFZ4MEswMi9lY3VYdFRXRDNmN2JZMDBhYXp0TVRZ?=
 =?utf-8?B?cVVkeGRrWDhFaVM3NUNwN3c0amF6SlZQS1dPdHh3KzJPdjhzVEhiT2JCVmNl?=
 =?utf-8?B?bVdGZkJYQmZnT3dTOVY4V1NZUHBKcDlsSXBpMWtsVTkwblFUVlV4QTdkWE12?=
 =?utf-8?B?WmIyS3l1NDlRN3dUSXc0YVdVNmcvOXVrVmVjYWlMUnBsNWxYM2VMZHkvUG9I?=
 =?utf-8?B?MWpOV1BsSnR3dzBPZnB0RHJ6RmZOaGVYNERxK2Y1L0R1Rm9CZUhwZlc0VlhU?=
 =?utf-8?B?NUZxYjRPbHlFano1bmdtN1UyRWJFN3puNkpkR3YrMmVuM2ZkejMxcDZaSy9t?=
 =?utf-8?B?NVgrNURmVHhVQk4yUnZuSGR6aGhDT29tazh1SXFRT2RhdnhmSlhiTmFYa2Er?=
 =?utf-8?B?MUd0M2c1M2N6amxMdlE0Sk5yRnMvbTBXRE8wY2J6a2dBZkZyYURFYVlrSkRp?=
 =?utf-8?B?b2cxUkpJcmtSem1zdXZ0R0pQSjBSdmdJQmlhUFY3M1g2b3c0cDdab2h1MnNn?=
 =?utf-8?B?UU95dFh2Ri9LWWI0dXV2TU16SGJNM2tlRm1VMkVSWEcwRDZGVlk1LzJnZzAx?=
 =?utf-8?B?cE5yQy95MDVIdVJ6eWpJNGRhVVRWUkFGaFdnK2ZOdEpHbHB0M3BWNVlQMFQ3?=
 =?utf-8?B?N1ZrK2VtbFFrYmhqd0FXNnE5OUNhU20zQjhacDRYdFBJT0lBbkJHU0NwOUtQ?=
 =?utf-8?B?TFpmRXFhbFR5b0Y1cERtbGNkYjdMdml0MmpXd3JZTk9LNkowODNlVzVqZlVr?=
 =?utf-8?B?aE5XMElvN0thM0FHQUdWdm9NaEdHeFNjdVdsRkYxWWJVUkRUeEFJVStIQTJW?=
 =?utf-8?Q?8JvXK5Bg0WwzCe2j/ERt73g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F3CC6122A4A784094977526F71B0E6E@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 213b7246-77e0-4b61-ba11-08dd0a02650d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 07:59:15.7510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7UVfpR/izncuqxqwAGAOhyHwhzNeAXtC+RsF8VQ4cmbMRCwNt0Q4D6qezUwwT4SjtQoqvPcKpY1knszHI+7J1zciwAcIA/XorVqFK9fD5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7131
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

VGhhbmtzIGZvciBxdWljayBmZWVkYmFjaywgSmFuIQ0KDQpPbiBUaHUsIDIwMjQtMTEtMjEgYXQg
MDc6MTYgKzAxMDAsIEphbiBLaXN6a2Egd3JvdGU6DQo+IE9uIDIwLjExLjI0IDIzOjI0LCBBLiBT
dmVyZGxpbiB3cm90ZToNCj4gPiBGcm9tOiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5z
dmVyZGxpbkBzaWVtZW5zLmNvbT4NCj4gPiANCj4gPiBUaGUgaGFjayBpdHNlbGYgc2VlbXMgdG8g
YmUgY29waWVkIGZyb20gTGludXggcnRpX3dkdC5jLCBidXQgdGhlIFdEVCByZXNldA0KPiA+IHBy
aW5jaXBsZSBpcyBkaWZmZXJlbnQgaW4gVS1Cb290LiBXaGlsZSBMaW51eCByZWxpZXMgb24gY29y
cmVjdCBmcmVxdWVuY2llcw0KPiA+IGFuZCB0aW1lcnMgYW5kIGRvZXNuJ3QgY2hlY2sgdGhlIGFj
dHVhbCBXRFQgY291bnRlciB2YWx1ZSBVLUJvb3QgZHJpdmVyDQo+ID4gc2VlbXMgdG8gYmUgbW9y
ZSBydWJ1c3Q6IGl0IGRvZXMgY29tcGFyZSBSVElEV0RDTlRSIHZzIFJUSURXRFBSTEQuDQo+IA0K
PiByb2J1c3QNCj4gDQo+ID4gDQo+ID4gTm93IHRoZSByb290IGNhdXNlIG9mIHRoZSBvcmlnaW5h
bCBtb3RpdmF0aW9uIHRvIG1hbmlwdWxhdGUgdGhlIGNsb2NrIHJhdGUNCj4gPiBpcyBzYWlkIHRv
IGJlIHVuZGVyc3Rvb2QgYW5kIGZpeGVkIGluIExpbnV4IGNvbW1pdCBjYWU1ODUxNjUzNGUNCj4g
PiAoIndhdGNoZG9nOiBydGlfd2R0OiBTZXQgbWluX2h3X2hlYXJ0YmVhdF9tcyB0byBhY2NvbW1v
ZGF0ZSBhIHNhZmV0eSBtYXJnaW4iKQ0KPiA+IHdoaWNoIHNpbXVsdGFuZW91c2x5IHJlbW92ZWQg
dGhlIGhhY2sgaXRzZWxmLg0KPiA+IA0KPiA+IFdoaWxlIGlzIGZpeCBwYXJ0IG9mIHRoZSBtZW50
aW9uZWQgcGF0Y2ggaXMgbmVpdGhlciBhcHBsaWNhYmxlIG5vciByZXF1aWVkDQo+IA0KPiByZXF1
aXJlZA0KDQpJJ2xsIHJlLXNwaW4gd2l0aCB0aG9zZSB0d28gdHlwb3MgY29ycmVjdGVkLg0KDQo+
ID4gZm9yIHRoZSBVLUJvb3QgZHJpdmVyIGp1c3QgZHJvcCB0aGUgaGFjayBzZXR0aW5nIFdEVCBj
bG9jayByYXRlIHRvIDkwJSBvZg0KPiA+IHRoZSByZWFsIHJhdGUuIFRoaXMgaGFzIGEgbmljZSBl
ZmZlY3QgdGhhdCB0aGUgV0RUIHRpbWVvdXQgaXMgbm93IGFzDQo+ID4gcmVxdWVzdGVkIGFuZCBu
b3QgMTAlIHNob3J0ZXIuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIFN2ZXJk
bGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQo+ID4gLS0tDQo+ID4gwqAgZHJp
dmVycy93YXRjaGRvZy9ydGlfd2R0LmMgfCA4IC0tLS0tLS0tDQo+ID4gwqAgMSBmaWxlIGNoYW5n
ZWQsIDggZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvd2F0Y2hk
b2cvcnRpX3dkdC5jIGIvZHJpdmVycy93YXRjaGRvZy9ydGlfd2R0LmMNCj4gPiBpbmRleCA5OTE2
OGQwY2FkMDMuLmY4MDZlMjRlNTNkYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3dhdGNoZG9n
L3J0aV93ZHQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvd2F0Y2hkb2cvcnRpX3dkdC5jDQo+ID4gQEAg
LTE4NiwxNCArMTg2LDYgQEAgc3RhdGljIGludCBydGlfd2R0X3Byb2JlKHN0cnVjdCB1ZGV2aWNl
ICpkZXYpDQo+ID4gwqAgDQo+ID4gwqDCoAlwcml2LT5jbGtfaHogPSBjbGtfZ2V0X3JhdGUoJmNs
ayk7DQo+ID4gwqAgDQo+ID4gLQkvKg0KPiA+IC0JICogSWYgd2F0Y2hkb2cgaXMgcnVubmluZyBh
dCAzMmsgY2xvY2ssIGl0IGlzIG5vdCBhY2N1cmF0ZS4NCj4gPiAtCSAqIEFkanVzdCBmcmVxdWVu
Y3kgZG93biBpbiB0aGlzIGNhc2Ugc28gdGhhdCBpdCBkb2VzIG5vdCBleHBpcmUNCj4gPiAtCSAq
IGVhcmxpZXIgdGhhbiBleHBlY3RlZC4NCj4gPiAtCSAqLw0KPiA+IC0JaWYgKHByaXYtPmNsa19o
eiA8IDMyNzY4KQ0KPiA+IC0JCXByaXYtPmNsa19oeiA9IHByaXYtPmNsa19oeiAqIDkgLyAxMDsN
Cj4gPiAtDQo+ID4gwqDCoAlyZXR1cm4gMDsNCj4gPiDCoCB9DQo+ID4gwqAgDQo+IA0KPiBNYWtl
cyBzZW5zZSB3aGVuIHRoZSBrZXJuZWwgaXMgdXBkYXRlZCB0byBhIHN0YWJsZSB2ZXJzaW9uIHRo
YXQgY29udGFpbnMNCj4gIndhdGNoZG9nOiBydGlfd2R0OiBTZXQgbWluX2h3X2hlYXJ0YmVhdF9t
cyB0byBhY2NvbW1vZGF0ZSBhIHNhZmV0eQ0KPiBtYXJnaW4iIGJlY2F1c2UgdGhlIGludGVudGlv
biBvZiB0aGlzIGNoYW5nZSB3YXMgInRvIGhhdmUgY29tcGFyYWJsZQ0KPiBwcmVzZXQgdmFsdWVz
IGZvciBib3RoIGRyaXZlcnMiLg0KDQpBY3R1YWxseSwgSSBiZWxpZXZlLCB0aGlzIGRvZXNuJ3Qg
bWFrZSBhbnkgY2hhbmdlIG9uIHRoZSBrZXJuZWwgc2lkZSwNCmJlY2F1c2UgaXQgdGFrZXMgdGhl
IGNvbmZpZ3VyZWQgUlRJRFdEUFJMRCBhcyB0aGUgYmFzZSBmb3IgaXRzIGNhbGN1bGF0aW9ucw0K
b2YgdGhlIHBlcmlvZCwgYnV0IHRoZXJlIGlzIGVpdGhlciAiaGFjaytubyBzYWZldHkgbWFyZ2lu
IiBvciAibm8gaGFjaywgYnV0DQoyJSBzYWZldHkgbWFyZ2luIiBkcml2ZXIgdmVyc2lvbi4NCg0K
PiBIZWFkcyB1cCBmb3IgbXkgY29sbGVhZ3VlcyAoeW91IGFscmVhZHkgdXNlIHN1Y2ggYSBrZXJu
ZWwpIGFuZCBhDQo+IA0KPiBSZXZpZXdlZC1ieTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVt
ZW5zLmNvbT4NCj4gDQo+IGZvciB0aGlzIGhlcmUuDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGlu
DQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
