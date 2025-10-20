Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8EDCCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 07:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E159F82C84;
	Mon, 20 Oct 2025 09:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="D3QkgA/K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9B9482E34; Mon, 20 Oct 2025 09:10:02 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A72D807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 09:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f44Gk4P+Pa43ypW6Yx191KzVOzC7OPY3eoz5kbxJhkvPufImnX60eXQPBnrLR9WP5bwNQomUymZDxW0BkPffTiYAqxxEVeVeHPXY7kmB41FFkSkHNJSxKCXzHlDJVuNwzsc+Xjek42aNMgnWJ1qQ5rGy+rrRYNE+a+DogDzeWeUujVk5DERrsdSCxMZHxSnvjZra/wF+qvWlb5A8o9h37Fe6Tn4jkdD15X1RDeuMlcQxVdtxG9FoVSpeD/S4+mMehkZ7btjAk4kvWW9HaNDzHeMPXFQ0z3//+Tq98xV4mWJD0fcRaACBXxHBEAMFWhuz5fZ2maiVhEHmUGxAFHt2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QlLX70hrz4xFX2fH3bnxLTQ/cm7vOm09HM/pagm3sk=;
 b=CTH6BB0rZFwiNt1KePXD1wyaiIsNJ1g2jrchDuBLO4u2lpautW4BCLx2SI65tAwq3v+hT68QCxazcCF3Djd6xeLglW7B3snJfSOI2JO+5CapNMR7U0Lnsu94Yw4sLY5drNGp7DVx/IYhu2VZIKkDS5Mn3BTUf30DSv83yq9MiLwXsVg+taau080ezmjgxyevUkT4T5/DYohaeCM49wU9rB9cQSJU5SJUwkb4isidnsXDn60KWMdgFdAvfkgbXXwRwR0hjo/ycceZiEiFtrDvtmc0GnRBPdL6gOjF0r68UAqE/1tvtXAb/085mXRiPrjzArangfLGiv3erWjuGtsoYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QlLX70hrz4xFX2fH3bnxLTQ/cm7vOm09HM/pagm3sk=;
 b=D3QkgA/KI4Gsy6FdCzSgtiM+U9MPQtY+7FOwVYLDHgG78Z92qRcEx/lKKpJsDSva2T76Zndxc6KLKpUIVReFZiYFBv0wOq9TTAALQkScdBA4yx44ICQrr2+I7rXOfPGtopOszWWbgudJrp3Pn5+TMxvgKtPTg0RJFSgzhGjWfjQOVIXXLoUxUsGhWmIn3oCuJTtKOkt5P26gcM25gr1/KyRjTXOS6linjrxBAUTaP+Q0IL8/2MVm5pLiWiFkbtM1bSM5sj0Q30NqU9SGMfyzGO6JxWCoAM9rvCqWFCGCx+4cZT0lWkHNPGtindmpjJHavRc6uZPTf5x4W4LpjU9hMw==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB9PR04MB9844.eurprd04.prod.outlook.com (2603:10a6:10:4c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 07:09:58 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 07:09:57 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "sbabic@nabladev.com" <sbabic@nabladev.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>
CC: Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, Peng Fan
 <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "mkorpershoek@kernel.org" <mkorpershoek@kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgMS80XSBzcGk6IG54cF94c3BpOiBBZGQgbmV3?=
 =?utf-8?Q?_driver_for_NXP_XSPI_controller?=
Thread-Topic: [PATCH v1 1/4] spi: nxp_xspi: Add new driver for NXP XSPI
 controller
Thread-Index: AQHcQZCLmk5K6Pw+UUWD2LEQV2lNVQ==
Date: Mon, 20 Oct 2025 07:09:57 +0000
Message-ID: <PAXPR04MB9644DA5017638F3B0716710FE2F5A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251014111756.446456-1-alice.guo@oss.nxp.com>
 <20251014111756.446456-2-alice.guo@oss.nxp.com>
 <88093ae4-a18f-434b-b0a3-a362133871cc@mailbox.org>
In-Reply-To: <88093ae4-a18f-434b-b0a3-a362133871cc@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DB9PR04MB9844:EE_
x-ms-office365-filtering-correlation-id: 7dc4fdd6-b6b0-44bb-04dd-08de0fa7ad91
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?SXJZZHpUQ2k5MU9hcDhVYThmdUFZc0hUL1dHQ2JCUC9RZFFSUXl4ajdUc2ln?=
 =?utf-8?B?bHZyRVA3SnU4Q0QvZVJnN3laYys2U20yY2xhbWIxM2VyNUd1aVExbEhvcjlx?=
 =?utf-8?B?Q2crekZiTzVSdHZCZWtYSkJBUWo0Q2YrUTF4MHJTd2R2ei9tTTlNVGFzSkRi?=
 =?utf-8?B?Z3hUQnJDZ2U2ZUliN09nQnhlNVFEdmJFYlhZT0xFY2tKSkpwUWdFcnM5VnlP?=
 =?utf-8?B?Z0l6TGxzUEFmcVo3QzJkSFVBMjhPTlRRcVM4bndqVFVxUkt5cXBUeVlxRUNw?=
 =?utf-8?B?a0VjSzdUZ0owaUZaWWxsMnhvYzRPSnNMdHdyV0czZVF6QzlEMXVDUHdJR0Y0?=
 =?utf-8?B?VU5ROWFkUDNGYllKZ3c0QUlmTXN6WU0xWkVRQjZJT05lTzhFa0RNZFJOTy9V?=
 =?utf-8?B?Nzk0Z1lDT0NCWlZzK0RCZWZpZkFJRHZMWE96bWtpVWM5Nzl6bTBPQWhZMDRq?=
 =?utf-8?B?a0h0V3FpcE9zK3hNd2Z5NVY0ZlJzcVM0R09UNm40NUdra2RWK1dab2oxQ2No?=
 =?utf-8?B?dXU2dW9Ta2RxaHZkY0NZVDUxNnBpYVZHYXJqblVYZCtycTl2VmVDVnJnK0ph?=
 =?utf-8?B?R3RiN3plUGRaRk9sOUlrT0NLMWRwTUtLNk9yVUNLeWdGL0xmampiN0JLanpR?=
 =?utf-8?B?dXllcnkvQU45M2NXYURKeFMyVkFYK3d2WlFjVEdsYmVZNnY4YzVXdVl4WXVh?=
 =?utf-8?B?VGtiVjUza0ZZQ0tqSkFhM2NLWktmY0NNQmo2eUlqWDBpWnZUY0E5TndPZ0ls?=
 =?utf-8?B?UmFQckN1K01CMzRWU1BpVUdUSjBid09XSnNibm9RVmVES284TDBkR0tXdnd6?=
 =?utf-8?B?VEdQY2dzWWZaWjBFZ3JwS0VMSitMWERsaWtCRzhPbTRvamlHSnVYbzQ1Q1pp?=
 =?utf-8?B?akVFS3c1SUZ3NkpqS3NEUUNyTm1uaDEyQWJzdkpYOGVQSWI0eFZGcldPWlo4?=
 =?utf-8?B?eDJtd2lFVVJaNTN0QzlpZ0pvUjk4Y2NpRG1sdXg3RjUxN2RSRmh4YlVqRTVy?=
 =?utf-8?B?VG11OXVxdURreFlOMEZ2VVVpUTNUQ1NDUU4zVnRONVhqUms1bGc2S3ZDRFN4?=
 =?utf-8?B?N2lFRDR4MUYyZjRucXN2NzRrN2o4eWVoNXBidlN4NWlkM2VBeWJucThnMWpa?=
 =?utf-8?B?WUJPSlhJYm5uNU5Bd0xLNERZUVdsN1pzTExpT214VmMrT3I3Y3NXRUZ3Z1BY?=
 =?utf-8?B?QnhxTkk2TGx5MXVleWJhWkVac3ZFOEF3Q1lEOVNldDNUYzRwRW9EWFBaOFRQ?=
 =?utf-8?B?RkVHako3U29uZkdUMjAxU3Y2cHhHM3J3cklubjlia1Z0Q2ZDZGhZckExU3o4?=
 =?utf-8?B?SlZ0SlM2dXNRVHAybERUUmFEejFXZTZmbXQwQU80SldIUkp3RXJKby9zRUQy?=
 =?utf-8?B?d3paT2RNY01hM2FTUFZWaGhHUWZCRVd0cHlFU2M4QmVLams4NFRHMXdQQU01?=
 =?utf-8?B?dG5yVTAvOG9GREliS1dES2o5Yk1ldmlzK2ExUWdhK2ZuUzdvL3BpWklUT2VN?=
 =?utf-8?B?UVZTYVdOSmFCK3VPdnlUckdKbHlKNlJuMzFCM2FvZ3hjbmJhSUNQTmxmd3Er?=
 =?utf-8?B?dnJBKzJwVDREcW9iS0dMZERQc3NEd2tPOHFzd245eng2WkVNWVVBaEg3eXJk?=
 =?utf-8?B?ODErSjJpdGNZSmZVUWdtbjlnd2E3NWJtR2t2cUdNZmNiSHNTTVIrWGRCcGda?=
 =?utf-8?B?YkJJNENNSHhuTzdaM0FyclJ6bkQ2ZDZIWnBPYUlQQ0RuVkVuS2ZXaDUxbllR?=
 =?utf-8?B?L1g3Q1RaOGxONWljU2J6a0RqS21vcWVoK0htSGI1VU1najRFd3lMYmNvQTlV?=
 =?utf-8?B?Y0gxTTBMY0VpS1BYeXIwbFNmSS9FRlA0Q0k1V2JkclhMTnpKOVpxU0lub0tI?=
 =?utf-8?B?RjFVT1llUVE0VmNnaVFHcjd0azJoSXBPMFpFM0J1SzlvdFlUdkZITmhqZEdt?=
 =?utf-8?B?a1VaNmplSEZ6Z1Bjc3lYUjJRM2ZCYWRFM1JJRnJIeXQ5WjA4dkJLUXVpMnEw?=
 =?utf-8?B?VjBrdTJtbHUyR3lCeDdwdjZMNGEzU2p2NmJSODE5a0U3MWZ2anMxMmhMZlFR?=
 =?utf-8?Q?rfF1Ub?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OC9NQkNSajBRNk13VFRlamNVRTZhd2RxNllLOHBPZjJ6Ri8zN3VTdkEwS2tT?=
 =?utf-8?B?MGZESnNlWmgrN3RZdGlBam85akZzMmcyaUZjeEdXNjZXU1RSMXNGM1JyK3Mx?=
 =?utf-8?B?Y0RJOTBtVXJPZ1pPMHFyd2dZTUVMMHNJY24wTUJORjE3ejk0TjBRQXp4Qm81?=
 =?utf-8?B?VVRldnZQMy9JUG9reGg1ZkM5aWw5dUxubHJkcnRscDB5eisxaDJ3YnhadWsr?=
 =?utf-8?B?ZzkrS1hRVFIxNDQxZDlKNzdoYmdkY0tHdGdkeXpDbXZQWTZIbGVCbzdUTlYw?=
 =?utf-8?B?OGhuSFRIYTNUSHhNdmZwdndSeUI0U0tKWU4yR2ZpRGtSYTk5eVNsS2FJcHJO?=
 =?utf-8?B?dHR3b2ZFWWd3UVd4TFMvU0R1M2MvWnlsNmRFSGFRMkpyalhJK0ZYSCtGR3J4?=
 =?utf-8?B?dXh4aWk2RElxRWNzMWNPSkNVK1d1MVE5OGtGSStEMklxSndYN2FmWGpjYS8x?=
 =?utf-8?B?RENmdDVkd3hIYXd5UGhieWkzcmVBNVkrY0UzbEpTZDlwQ1NtZXp2ejUwc3Mr?=
 =?utf-8?B?L0U0ZTBha3ZQa0d5NDFVYjZUSDNkVXNhMWdRVE1UdWthck1zZWU2WVdZVjV1?=
 =?utf-8?B?dG5LbTZMc3dtYjZ0eEYrTUxQUE8vaTk5NFRVYnhtZmNibnc2YXozbG5yY0Ru?=
 =?utf-8?B?UXVoUnhNczdtU0U1ZnF5QzYxV0xGMU9rUEhFcnUya2J1OHd3Y2FEWjFuLy9l?=
 =?utf-8?B?UkkreHVrSDFmY3ZMT2pFRUVjTkdubWMzNTV1TmMyejBmdms0U0cweHFMRHh0?=
 =?utf-8?B?cFhzWkV2OWpyTGp1cjVsRjNNK0VvMmhKRExRYmgwS1hVREpnanMrams4QnBM?=
 =?utf-8?B?SmVFTFZtS3pSb2lkOHBSUWtYSE5wWlFvOS9QdWNSVWUyUU12aWZJYk9adEJL?=
 =?utf-8?B?eGhVR2hONkFKTDVPNGNOaFJ2SFRHZVFxQXdLdllwM2xnTTJweEVqZk5uMTVj?=
 =?utf-8?B?Y1ZBWk9ZUmQzd1NvQkJZMWZyLytYd0JTSzZ5eFlsQXpBMXBBSzh2ZHZaaHg4?=
 =?utf-8?B?RUs2dmQ4TmhacVEzYUlNcmhUekJqNGw4alcrZmwvdFY4QTRzQzdsemtCWWhn?=
 =?utf-8?B?K2pOc0hlajJZV2VuV1BKUEZYWCtJeHcxSHJsd3VTRHg1Q2w4WHJmRUtzUWVJ?=
 =?utf-8?B?UVFCSkFjdE96TTZxbGJPZFB3ZkdKQmRXWkRiMmpNeXZzbUNpVGtva0RJVytv?=
 =?utf-8?B?OFhqZElGNkdFWUlNZzcrRkdUMEFISFI2MUlaRFlvUTJHZzJBTFk5VWJIbVAz?=
 =?utf-8?B?c25zWWtKNklUamdpMk9QL1BLNGh5d3EvdGJYYi9WR2k3ZVJ0OHQ4em5WcWUx?=
 =?utf-8?B?UXhNWFdDTmZhdmtLRWtzWTdMT1BvdGpwTEZhYnlqQWFOWHlESDltVjdleEZT?=
 =?utf-8?B?eUlxak5wVElibFlSV3pRRmUwZEdZMWtNblhQdDRyQVBCQUhCSE42UHlFSU1K?=
 =?utf-8?B?UWFTS21DM09paitZbG1RK3VyOCs3cUJMdWI5Q1ZzdUVmdDBmVWdWSW1ZU244?=
 =?utf-8?B?UFpMVXFma1FLOWU4Y2UwUWlGdTNHVm9JMGRJdmQwditvQzJ4TmliME1SVFBP?=
 =?utf-8?B?bWw1R1AvdjRUbE52VGdiaG5Lc1RNbENmTys5RDQxUmFPNndQRnBPbWlGVUtL?=
 =?utf-8?B?cldhVi92aEkvUU5FN1gzbERSR2luMlgwRG1ldm9rVFF0WmNxR01jQ0J5YVBz?=
 =?utf-8?B?a3RqQklIcEZYZGsyWDhHZW1WemNHK3JTVW1GdE5vWnM5bHlHaHV5SE5ZaXZr?=
 =?utf-8?B?aFNDbnc5RDlCNlVhRXd5cjB0OTlZMUp1NThjdHpnTGs5bm0xeExXbWVCZTFD?=
 =?utf-8?B?dVg1R0lpdkw3aU5HM0ZqWFhRMWtJU25DR2xTSm5GVVIrWGQvb2g2OGhzVDNu?=
 =?utf-8?B?MkQzTjNJVStFK3FqM0pCeUlNV2ZyYWhjeTBON2FlK01ESkVqQmZwYTlleEd5?=
 =?utf-8?B?Rzk2aHFySHM5SUI4QzhMVFI5VS9nOVdnd1F2SUlzTG5MQzdGOStIUnh1bkJv?=
 =?utf-8?B?RFp4MFFsQUhUQkppTzlNeDhUN21hWEpHSnJ3dFk5a01QOStpVVRlblQ5VmIw?=
 =?utf-8?B?dkZpSGdEazJhWllNZlVEWjM5QW5KTGxOODN2THZNbkQyeXNGelhpZzBrSXNv?=
 =?utf-8?Q?VF3QihInVWyHqI0q8K3VFRNWB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc4fdd6-b6b0-44bb-04dd-08de0fa7ad91
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 07:09:57.8627 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKMEcW1kLkdfQVdlO9cIrcSyn9s7sGD4OneMuXZ1h292SWJADShwfoK1PqAm+KepDP46vN+thf0rRaZoeSdeYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9844
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmVr
LnZhc3V0QG1haWxib3gub3JnPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQxMOaciDE05pelIDE5
OjI3DQo+IOaUtuS7tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+
OyB1LWJvb3RAbGlzdHMuZGVueC5kZTsNCj4gZGwtdWJvb3QtaW14IDx1Ym9vdC1pbXhAbnhwLmNv
bT47IHRyaW5pQGtvbnN1bGtvLmNvbTsNCj4gc2JhYmljQG5hYmxhZGV2LmNvbTsgZmVzdGV2YW1A
Z21haWwuY29tOyBqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbQ0KPiDmioTpgIE6IFllIExpIDx5
ZS5saUBueHAuY29tPjsgQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT47IFBlbmcgRmFuDQo+
IDxwZW5nLmZhbkBueHAuY29tPjsgSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPjsgc2pnQGNo
cm9taXVtLm9yZzsNCj4gbWtvcnBlcnNob2VrQGtlcm5lbC5vcmcNCj4g5Li76aKYOiBSZTogW1BB
VENIIHYxIDEvNF0gc3BpOiBueHBfeHNwaTogQWRkIG5ldyBkcml2ZXIgZm9yIE5YUCBYU1BJIGNv
bnRyb2xsZXINCj4gDQo+IE9uIDEwLzE0LzI1IDE6MTcgUE0sIGFsaWNlLmd1b0Bvc3MubnhwLmNv
bSB3cm90ZToNCj4gDQo+IEhpLA0KPiANCj4gPiArKysgYi9kcml2ZXJzL3NwaS9ueHBfeHNwaS5j
DQo+ID4gQEAgLTAsMCArMSw4ODkgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjArDQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdodCAyMDI1IE5YUA0KPiA+ICsgKi8N
Cj4gPiArDQo+ID4gKyNpbmNsdWRlIDxhc20vYXJjaC9jbG9jay5oPg0KPiA+ICsjaW5jbHVkZSA8
YXNtL2lvLmg+DQo+ID4gKyNpbmNsdWRlIDxjbGsuaD4NCj4gPiArI2luY2x1ZGUgPGRtLmg+DQo+
ID4gKyNpbmNsdWRlIDxkbS9kZXZpY2VfY29tcGF0Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9i
aXRvcHMuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2J1Zy5oPg0KPiA+ICsjaW5jbHVkZSA8bGlu
dXgvZXJyLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCj4gPiArI2luY2x1ZGUg
PGxpbnV4L2tlcm5lbC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvc2l6ZXMuaD4NCj4gPiArI2lu
Y2x1ZGUgPGxvZy5oPg0KPiA+ICsjaW5jbHVkZSA8bWFsbG9jLmg+DQo+ID4gKyNpbmNsdWRlIDxz
cGkuaD4NCj4gPiArI2luY2x1ZGUgPHNwaS1tZW0uaD4NCj4gPiArDQo+ID4gKyNpbmNsdWRlICJu
eHBfeHNwaS5oIg0KPiA+ICsNCj4gPiArc3RhdGljIGlubGluZSB2b2lkIHhzcGlfd3JpdGVsKHN0
cnVjdCBueHBfeHNwaSAqeCwgdTMyIHZhbCwgdTMyIGFkZHIpDQo+ID4gK3sNCj4gPiArCXZvaWQg
X19pb21lbSAqX2FkZHIgPSAodm9pZCBfX2lvbWVtICopKHVpbnRwdHJfdClhZGRyOw0KPiA+ICsN
Cj4gPiArCWlmICh4LT5kZXZ0eXBlX2RhdGEtPmxpdHRsZV9lbmRpYW4pDQo+ID4gKwkJb3V0X2xl
MzIoX2FkZHIsIHZhbCk7DQo+ID4gKwllbHNlDQo+ID4gKwkJb3V0X2JlMzIoX2FkZHIsIHZhbCk7
DQo+ID4gK307DQo+IElzIHRoZSBCRSBtb2RlIGV2ZXIgdXNlZCA/DQoNCkhpIE1hcmVrLA0KDQpB
cyBmYXIgYXMgSSBrbm93LCB0aGUgaS5NWDk0MyBvcGVyYXRlcyBpbiBsaXR0bGUtZW5kaWFuIG1v
ZGUsIGFuZCB0aGUgQkUgbW9kZSBpcyBub3QgdXNlZC4gRG8geW91IHRoaW5rIGl0IGlzIG5lY2Vz
c2FyeSB0byByZW1vdmUgdGhlIGJpZy1lbmRpYW4gcmVsYXRlZCBjb2RlPw0KDQpCZXN0IHJlZ2Fy
ZHMsDQpBbGljZSBHdW8NCg==
