Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B986CCD183
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 07:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B30783966;
	Thu,  9 Oct 2025 09:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Vk5sbmXs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 477258396C; Thu,  9 Oct 2025 09:00:06 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43A0283948
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 09:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xveTBB0KGc4lmYqXpHftVUvAFjFWjdbRuFzhRAYMVbcysUW7GMO/e4Rfk+ZGyW4ibB+lVblkf8RLHSEYNCpjWgA/aUhbvgKq01ZfIpR6SxrQmVvfpm5o0FBhEQMSLNrrRUjvxx3WaRNpwmMjWz3qD3m29otCJ5MzFbcrD71ye1vPLUpYS5IbqBYHWfWx+4V57vWZG1sIcxHA4rLXK5+a1NCj3JOdwsxkETHSrL2iWKuZP0PVdtaZ0AXkwODOq4WHEtPWXBonwUy/FaPESzA1yXS/NcJyXEdptUuxEyMJD2dEERVoR8qCOvGNxzI/ZQoWMlf50Jd2i4tZLfeQv6Hnhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZz/T8stQptmiNZeo9DTFYTIfclI5XlzKgm44gicrcs=;
 b=X72RRWAJrcAsl95dxJMCZiLuwItM4BL6qJ9fJFj5aP54nWfRuXMat3JgQiTE8zadI/6uVB6hZRiMz89MhowQBTpgq15R6CAePPwSuF6vaPgX+bNrpRLlT89TGWZCX88OeVFs69a7mKui/V6E651Ge/zXI3RMnqveNDvF5dxST+aBmYUcBpQIMUZqh4A98RaQBWRqjtNGSM+rCVapRFE8YqiL1uOtMcGmHJnhw8VZSNMJmjW4IJ2FiNuvT9pCh7LO3WhKr/LwCq7sg2cn+jAo57tdPzPHEevJc+JdisFwmmuhqjFfDHN2JX8dSLtKYPu0rHARzyEszggCfQMwsmVR3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZz/T8stQptmiNZeo9DTFYTIfclI5XlzKgm44gicrcs=;
 b=Vk5sbmXsAuN1U2uySiV6/PfSHQ6TMqze7N1BOViHEh/hoLRuwH12Xqz72ygMv1TPKszrIpqX0xHjSbzV3yrup4amCQJ7ZrFopQVoudNVAZQ7XUnT9DYWzYonlFR9hVSRDsyBud9GKceuA4bqKz4Br0Kds7/rZwrrqvjP5stD0Znf1Skfrd/WrCclxOyUS62V6YB4QbHJo9Yk2bFSu56nFMthZj/lKSOU+lSyU4+t/HTUhCCKTYKRwoF6zAHSFEF9xUkH2BtoFF4nd1lrZh428Py0TW1lBm7DmnwUBQqYI7OJudGDN68UswWTE3IOz24uZZ+FbFV6a3rKddYsPetk6Q==
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::12)
 by DB9P195MB1356.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:299::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 07:00:00 +0000
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582]) by VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 06:59:59 +0000
From: Martin Schwan <M.Schwan@phytec.de>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Andreas Pretzsch <apr@cn-eng.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [PATCH] test: boot: Add test for bootmeth_rauc
Thread-Topic: [PATCH] test: boot: Add test for bootmeth_rauc
Thread-Index: AQHcOGLgl2Obcu8vRE6hiwuAM5brb7S5Y+AA
Date: Thu, 9 Oct 2025 06:59:59 +0000
Message-ID: <59720991a75ac4e68ac218fa1a1c81f7639c5039.camel@phytec.de>
References: <20251008-wip-bootmeth-rauc-tests-v1-1-3da21a731524@phytec.de>
 <20251008145017.GV298503@bill-the-cat>
In-Reply-To: <20251008145017.GV298503@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2489:EE_|DB9P195MB1356:EE_
x-ms-office365-filtering-correlation-id: 7c4fd5c9-cb93-4a4a-5a91-08de07017635
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?R2NYZVJqdWtYeUhVa0pOeTArMXRsV0lWSHMxT3F3cy9DR0UyUlBlTUpmMWVz?=
 =?utf-8?B?Y1p6L0JyRERNV1gxV1BLRi9zanJHYmpSOG1PdDRGSk9mbVdjWG5qaVo0YnQy?=
 =?utf-8?B?cEYwbGZqNmdRdWdkNEFaS2J3cWhRV3ZDREg2YWFXNTcydGJIZEpCUllxQkQr?=
 =?utf-8?B?TzRpVWtFU1BVYmJuYUZrVVZKSWxLSGxaWk5hdlJ1S0tDV2N1MkxBZUhCK2lE?=
 =?utf-8?B?SDBaQytjR2dIT0FnaGpkQWVuUUFITkFxelFoU3YvK2g4TEhKQ2YybFdsTTFI?=
 =?utf-8?B?UTY5eENmSkJnTmVnVk5YYTY3eHljamxOZXRFb3RYVkMxa2Zzb253N2hpeStF?=
 =?utf-8?B?ZXpDSFUxV2NkZFZPaGtzT2xETjFwbTVoMGdPTkNyNHNkRVlOU1FBMnhYeDFY?=
 =?utf-8?B?OU11K2I3RFUxL09pcHQ2aUpYbnh3SU5WY0ZLOXE4d2FDNUpnMHB1UjdFWFVP?=
 =?utf-8?B?ZXJZbnJPbE13cFVQMUcyK3VmSHQzWk9KV3ExTmpPWndocS9jNjEvUnVwdmZY?=
 =?utf-8?B?bWhjVXZrakEwcDZneGhmTzF3bzRqTm42Z1AyT0xRN2RTTXJJdlo4emhvcksv?=
 =?utf-8?B?QXRSbUdWK3Buek12UlRxYzRLK1k3K2daeCtYMjlrTzBtVmE4OUx6UHpqSy9k?=
 =?utf-8?B?dThlU2RjSno2Q2hCWHBWdVpTcE52a0ZhRFE3VmdFeHNteVFsSElNNGwzUjUz?=
 =?utf-8?B?UlIwWUJQamxhMjA1cW84TnZ5YklLeVdMbHVYZSszbzc5TWEzdVM0L1ZWYUMr?=
 =?utf-8?B?bjJ4NUI0WHVDYUtVQnI5aTl0RmEvRUVHZlBqaUNWVW9LbEN5MkNmR2tsY1Vz?=
 =?utf-8?B?V2dQbFYzYjRDUFJUREYwUFVIek1sUEowVWNPTlZaVUJYR05iSVcxOWdzVE9v?=
 =?utf-8?B?cC9OYUR4T0RINkRxL3pTRlhnc3J2anFad2lSQWpSVUEvc1IrMzJSVTY5a0Nl?=
 =?utf-8?B?MnVTT3ZuY2RjdTE3SFdaODV0UzJLNGc5Sm9teTRtT1FkMWdqMC8wcktYbEpL?=
 =?utf-8?B?SHY0U2szVWZQbEVZZmE3THFjUXVSQlg0cm1hNjd5dmJOeGROQk85cE04dE5H?=
 =?utf-8?B?Z3Fid2FROUZLSjhUcktDRkhNUE9WRkxnZWE2Y2VVb0pRUEIwRUFUa09JTmI4?=
 =?utf-8?B?VjNOdFhxOEJlUUlScE50QW12SVd2TFpjS0dwY1J5Y3VkUDVLUFBhT0lDcnlq?=
 =?utf-8?B?VE4xRjFZYjk1N3pzak9GNnZ2WGFDN20rN0xkYjBGQ3VCTEJsaTdsZzBtanNU?=
 =?utf-8?B?QjI5ZksxSEdCaUE5NEorVU1XcTk3SXJpTWhkS1RCTUlaM1lsZEVHeThFZCtt?=
 =?utf-8?B?WGhlZW9vQUJTczE2Nm1md25tcTRYUnZuRWVsNDdrRnpBNEM3dDA3L2dDalpa?=
 =?utf-8?B?U1RSS21PZk9BRzkyRDl3YnAwdmJrMS9kMFltOE5POXFXNnVvdjNyTXZ5NnN6?=
 =?utf-8?B?QndBczlIbytVektSbDdRQ3d5OFNtRWtTcXVGSlkyQ1lxaFlPK011RllOUnNk?=
 =?utf-8?B?S3NEdWRGV0ZBcnVoZmg1cFNZTVN1RGJxSDE4b2xMOFZORmlJdmNMclZxdkFT?=
 =?utf-8?B?V25kdm5qMXBCWjl4bnlGVVpBSGFiTHdBSW1NWEF3UTdSdWU4VmlTUHhZbW9X?=
 =?utf-8?B?RTFtVHJ0TC9xaWtHL0hMb0dNYVBGS2R0dFlkUWd4QTJ1Uk8vcldXbHQ4N2pZ?=
 =?utf-8?B?dk9qSG9taFJmaWRwbEZlZW9CNXRtQkZhZHc0OUc3WEg0NWxwZDlqUnFUWjlC?=
 =?utf-8?B?YnJYWFBycmU1NEcyNXh5R3FFSDBQbkhwYno3TzR3eE5zMTgvWk8zbXRsRTZS?=
 =?utf-8?B?N0VzTzVVcXlycEtLZWQwUXFnVHl5ditOY0Z2UWlEWnBnbWk4c01BQ1NiS1cy?=
 =?utf-8?B?RTlzWnRmTEI3SDdPSHBiNE9xdURUci9QK2swdzI1bHA4bDV6dG9jVGxFTHZG?=
 =?utf-8?B?QnN5TkdpaW9sT1JLcTJvSkJCUlYwYmd2YkNIMUM3V3NMb3E1czI5UDBkYm9R?=
 =?utf-8?B?M3puSlpRU0FOV1J1RHZLWWxRTHBpSXBQR3VWdjlmT1JPMzg1bnVIbUllWlV1?=
 =?utf-8?Q?gk20et?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2489.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T25Wakc1Q0VLM2FOSUFXYlZaL2FCVHdZcHBxWGJZSjNnOGxTTXRpa2M0bGh4?=
 =?utf-8?B?NVgyOE1OcWpDenQvaFJrcUpZVStLOFV0RjFtaDNaMDRpM1IrYS9YWjl5Rnla?=
 =?utf-8?B?OGEwZ1RXZW1QcjZycjFwZlZPYUdzcnAvdDRLMFc2R0JmNDhvYW1kL0xPekNB?=
 =?utf-8?B?K3pxQUNnOW5TT2NOcUhpRnlOWWRzTk11eS9rNDFJb2gwSGRiVElicXJIUU11?=
 =?utf-8?B?QjkzQzdVNW9XTklkS04wSVBlSzJtQmdUQkExVTI0NzcvaC9SY2ZQV3UvSzl5?=
 =?utf-8?B?SFIxRmNIa21iNWsyMWJjU0tLdXV0WDV1eGwrQm1TN010cllxaHJhek5kdVJr?=
 =?utf-8?B?eTB5Z0lXNkQ5VzlPS3RDOGlGZldzMEN4R3hESW5VaEZBMmx1OXR4dVJhei94?=
 =?utf-8?B?MGU4cGNyYnpGSEl5NDNnVUlzaW1zN29SeWVXalZPbk5KeG9kQjFVUnFhRHgr?=
 =?utf-8?B?am1Eb3RXbTBqUG42NkppVWRSWmUrblRsR1hCWTV6UzBHNFE5aDNWbXN3ZWhs?=
 =?utf-8?B?R2NRdHl6SWk2d3VXakJEckRhSUQ2Ry9NaEVyNDlvWWZEQVM2eW9PUXI2SU1z?=
 =?utf-8?B?YmkydFpVQjVVanJjdmFjY3dBYmpiZWJ2bkxIa2lxSGo5VmNQY3Rtb2ljK2RO?=
 =?utf-8?B?bGE5dnd1QWRhMjIyUG0wNjJWb3NwUkN1VlpjaExPcE15S0x5MWZCaThDbHEz?=
 =?utf-8?B?OHl0SWo1cEtaTUY3ZXZ2ZitUNG1IK0RqeUUzUU5wUno4KzBsK2doUUMzNGp3?=
 =?utf-8?B?OXpVSHJjK29NNTA3Vk9VQUZPRGxyVnp4emhrajRCOFlkTVR2ajYxUHFhb00z?=
 =?utf-8?B?SlRsUEdvbTI4d3R5SnAwN3VOSkpHckRYSktNc2VtM0M1a0l6Qi82b0w4bDA0?=
 =?utf-8?B?Tk5BUkZ3dEFlYmMxNTlDRE5qMkw0blNVa1hHNVgyNzExWkFETHdQbGtCWk16?=
 =?utf-8?B?cml4VGl6SUhYNjBBUDBKK21ObVM2bm9qeVpYWUJ5by9KeS9zOUl3amlBZm9s?=
 =?utf-8?B?ZGR6cUNMR2E4QzdlclkrQXZRYjVyVnQ4SU5pcit1Y2s2OGJWalVUaHZtSG5x?=
 =?utf-8?B?M3JRNHhqNitCS1dQV1I1Q3d0R2V4ZW53T2E1S2l6d2NzK2xFK25HQWI0NVFS?=
 =?utf-8?B?cUwvMUpwZGMwcWZQZUE3eUFxWUpheU5iL2J4SksvSFoza2JEbWxOU0dnckxs?=
 =?utf-8?B?a2UzR2JZWHFCL1VhZVltYTg5QWFMWUpCK2ZjdUtVZWZjTzFCWWFwY2YxdVNV?=
 =?utf-8?B?ZUlYNHBnQW1Id29BVDVRUnQ5ZWZLMHVMeVNnNGtqNlpRTlFzOHlxWllrTlZh?=
 =?utf-8?B?UE5LSEh6T21xdTZiSDJnR2p5VThIaHVxS3ZPblgxVDAyamlwUnNuSHB2c0U4?=
 =?utf-8?B?QThGcDg3ZFpaVXUrTDY4RnNkY0JwUlpMQ05FdXNLZFlVQTlRT3FKNk50cVhU?=
 =?utf-8?B?eTBnMWIrM0tFRU03ZnJmQWdDckg4cXRTaWF4dDk4RGZ6MkppbGJLWkFLQjlU?=
 =?utf-8?B?RnlaUUREVjNiRGZSeFBoN0J0c0ZvOXZMa0pmb2lQVmFMUUVJcDlGNXIxc0Rv?=
 =?utf-8?B?aUxyMnIvcHQ2TG5GaGh0VG90LytVT2sxYnNmbVR3VmFzSCt6UGI0N1J0eXFB?=
 =?utf-8?B?Mk9KbmxON1pNTFBKd09NSW1DbTBlME5mbnVhTVIzVHRnbXU1TUV1ZGFpZmxs?=
 =?utf-8?B?V2lNT2dqVW9jcUNLQ0tZYUdtTTBGSXpmZ1hiY21tcE5vTTNGM3lDdmQrcHV0?=
 =?utf-8?B?SU43d3NYSDhsVFFHM3IzOFcwdVNTNjB4YkIvZkxrZHgwWXpxYW5Ob091cytz?=
 =?utf-8?B?VUNKYTFMQXVTMUlVS0ZDSkVTc09vSUhlK0lGM1pXUlNwR0RONWp2RmYzRWtY?=
 =?utf-8?B?NWQxZlhteXVTMkxjVWI3UHBGMisyaGsrVUpNVEoyR21qaWJsNnRLV0dtWm84?=
 =?utf-8?B?dFllbnhvUGF2VWcwcVhMdWNwRzgraXRIUFBxUDFSTXdHV1U0dXduYy9kU0FJ?=
 =?utf-8?B?Um40UW9rOUdHRHJoU0VwaVJHMDBMOWx2T3lOdjNXTWR6U2M1YU1qd0JQRmdD?=
 =?utf-8?B?R3N0VTZsWDdMQ2llRU9iRTlsQ2hYTng2cVJKcmRjTkZwTVlRNGlUdTFEK3ZD?=
 =?utf-8?Q?XFVw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19FCAEDDF7135941AD44D04DB0424395@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4fd5c9-cb93-4a4a-5a91-08de07017635
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 06:59:59.2102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mgcbBY5ZQ02jdbBwdOWcM7VgKDr938DdwRMbvqfo7tTHnrMg+JCWUAtrLK/T3HZ+U93nbxRn75PvXvXQql/j3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1356
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

SGkgVG9tLAoKT24gV2VkLCAyMDI1LTEwLTA4IGF0IDA4OjUwIC0wNjAwLCBUb20gUmluaSB3cm90
ZToKPiBPbiBXZWQsIE9jdCAwOCwgMjAyNSBhdCAwODo1NzozMEFNICswMjAwLCBNYXJ0aW4gU2No
d2FuIHdyb3RlOgo+IAo+ID4gQWRkIGEgc2ltcGxlIHVuaXQgdGVzdCBmb3IgdGVzdGluZyB0aGUg
UkFVQyBib290bWV0aG9kLiBQcm92aWRlCj4gPiBvbmx5IHRoZQo+ID4gdmVyeSBiYXNpYyB0ZXN0
cyBmb3Igbm93LCBydW5uaW5nIGEgc2NhbiBhbmQgbGlzdCwgdG8gdmVyaWZ5Cj4gPiBjb3JyZWN0
Cj4gPiBkZXRlY3Rpb24gb2YgdGhlIFJBVUMgYm9vdG1ldGhvZC4gTW9yZSBhZHZhbmNlZCBib290
IHRlc3RzIG9mIHRoaXMKPiA+IGJvb3RtZXRob2QgY2FuIGJlIGFkZGVkIGluIGEgc2VwYXJhdGUg
cGF0Y2guCj4gPiAKPiA+IFRoaXMgcmVxdWlyZXMgYW5vdGhlciBtbWMgaW1hZ2UgKG1tYzkpIHRv
IGNvbnRhaW4gdGhlIGZvbGxvd2luZwo+ID4gcGFydGl0aW9uczoKPiA+IAo+ID4gMS4gYm9vdCBB
OiBjb250YWlucyBhIGR1bW15IGJvb3Quc2NyCj4gPiAyLiByb290IEE6IGNvbnRhaW5zIGFuIGVt
cHR5IHJvb3QgZmlsZXN5c3RlbQo+ID4gMy4gYm9vdCBCOiBjb250YWlucyBhIGR1bW15IGJvb3Qu
c2NyCj4gPiA0LiByb290IEI6IGNvbnRhaW5zIGFuIGVtcHR5IHJvb3QgZmlsZXN5c3RlbQo+ID4g
Cj4gPiBUaGUgYm9vdG1ldGhfcmF1YyBzY2FucyBhbGwgZm91ciBwYXJ0aXRpb25zIGZvciBleGlz
dGVuY2UgYW5kCj4gPiBleHBlY3RzIGEKPiA+IGJvb3Qgc2NyaXB0IGluIGVhY2ggYm9vdCBwYXJ0
aXRpb24uCj4gPiAKPiA+IEFsc28gYWRkIEJPT1RNRVRIX1JBVUMgYXMgYSBkZXBlbmRlbmN5IG9u
IHNhbmRib3ggc28gdGhhdCB3ZSBjYW4KPiA+IHRlc3QKPiA+IHRoaXMgd2l0aDoKPiA+IAo+ID4g
JCAuL3Rlc3QvcHkvdGVzdC5weSAtQiBzYW5kYm94IC0tYnVpbGQgLWsgdGVzdF91dCAjIGJ1aWxk
IHRoZQo+ID4gbW1jOS5pbWcKPiA+ICQgLi90ZXN0L3B5L3Rlc3QucHkgLUIgc2FuZGJveCAtLWJ1
aWxkIC1rIGJvb3RmbG93X3JhdWMKPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTWFydGluIFNjaHdh
biA8bS5zY2h3YW5AcGh5dGVjLmRlPgo+IAo+IEknbSBnbGFkIHRvIHNlZSB0aGUgdGVzdHMuIEEg
cXVlc3Rpb246Cj4gCj4gW3NuaXBdCj4gPiArwqDCoMKgICMgR2VuZXJhdGUgYm9vdCBzY3JpcHQK
PiA+ICvCoMKgwqAgc2NyaXB0ID0gJyMgZHVtbXkgYm9vdCBzY3JpcHQnCj4gPiArwqDCoMKgIGJv
b3RkaXIgPSBvcy5wYXRoLmpvaW4obW50LCAnYm9vdCcpCj4gPiArwqDCoMKgIHV0aWxzLnJ1bl9h
bmRfbG9nKHVibWFuLCBmJ21rZGlyIC1wIHtib290ZGlyfScpCj4gPiArwqDCoMKgIGNtZF9mbmFt
ZSA9IG9zLnBhdGguam9pbihib290ZGlyLCAnYm9vdC5jbWQnKQo+ID4gK8KgwqDCoCBzY3JfZm5h
bWUgPSBvcy5wYXRoLmpvaW4oYm9vdGRpciwgJ2Jvb3Quc2NyJykKPiA+ICvCoMKgwqAgd2l0aCBv
cGVuKGNtZF9mbmFtZSwgJ3cnLCBlbmNvZGluZz0nYXNjaWknKSBhcyBvdXRmOgo+ID4gK8KgwqDC
oMKgwqDCoMKgIHByaW50KHNjcmlwdCwgZmlsZT1vdXRmKQo+ID4gKwo+ID4gK8KgwqDCoCBta2lt
YWdlID0gb3MucGF0aC5qb2luKHVibWFuLmNvbmZpZy5idWlsZF9kaXIsCj4gPiAndG9vbHMvbWtp
bWFnZScpCj4gPiArwqDCoMKgIHV0aWxzLnJ1bl9hbmRfbG9nKAo+ID4gK8KgwqDCoMKgwqDCoMKg
IHVibWFuLCBmJ3tta2ltYWdlfSAtQyBub25lIC1BIGFybSAtVCBzY3JpcHQgLWQge2NtZF9mbmFt
ZX0KPiA+IHtzY3JfZm5hbWV9JykKPiA+ICsKPiA+ICvCoMKgwqAgIyBDcmVhdGUgYm9vdCBmaWxl
c3lzdGVtIGltYWdlIHdpdGggYm9vdCBzY3JpcHQgaW4gaXQgYW5kIGNvcHkKPiA+IHRvIGRpc2sg
aW1hZ2UKPiA+ICvCoMKgwqAgZnNmaWxlID0gJ3JhdWNfYm9vdC5pbWcnCj4gPiArwqDCoMKgIHV0
aWxzLnJ1bl9hbmRfbG9nKHVibWFuLCBmJ2ZhbGxvY2F0ZSAtbCA4TSB7ZnNmaWxlfScpCj4gPiAr
wqDCoMKgIHV0aWxzLnJ1bl9hbmRfbG9nKHVibWFuLCBmJ21rZnMudmZhdCB7ZnNmaWxlfScpCj4g
PiArwqDCoMKgIHV0aWxzLnJ1bl9hbmRfbG9nKHVibWFuLCBbJ3NoJywgJy1jJywgZidtY29weSAt
dnMgLWkge2ZzZmlsZX0KPiA+IHtzY3JfZm5hbWV9IDo6LyddKQo+ID4gK8KgwqDCoCB1dGlscy5y
dW5fYW5kX2xvZyh1Ym1hbiwgZidkZCBpZj17ZnNmaWxlfSBvZj1tbWN7bW1jX2Rldn0uaW1nCj4g
PiBicz0xTSBzZWVrPTEgY29udj1ub3RydW5jJykKPiA+ICvCoMKgwqAgdXRpbHMucnVuX2FuZF9s
b2codWJtYW4sIGYnZGQgaWY9e2ZzZmlsZX0gb2Y9bW1je21tY19kZXZ9LmltZwo+ID4gYnM9MU0g
c2Vlaz0xOSBjb252PW5vdHJ1bmMnKQo+ID4gK8KgwqDCoCB1dGlscy5ydW5fYW5kX2xvZyh1Ym1h
biwgZidybSAtZiB7ZnNmaWxlfSB7Y21kX2ZuYW1lfQo+ID4ge3Njcl9mbmFtZX0nKQo+ID4gKwo+
ID4gK8KgwqDCoCAjIENyZWF0ZSBlbXB0eSByb290IGZpbGVzeXN0ZW0gaW1hZ2UgYW5kIGNvcHkg
dG8gZGlzayBpbWFnZQo+ID4gK8KgwqDCoCBmc2ZpbGUgPSAncmF1Y19yb290LmltZycKPiA+ICvC
oMKgwqAgdXRpbHMucnVuX2FuZF9sb2codWJtYW4sIGYnZmFsbG9jYXRlIC1sIDEwTSB7ZnNmaWxl
fScpCj4gPiArwqDCoMKgIHV0aWxzLnJ1bl9hbmRfbG9nKHVibWFuLCBmJ21rZnMudmZhdCB7ZnNm
aWxlfScpCj4gPiArwqDCoMKgIHV0aWxzLnJ1bl9hbmRfbG9nKHVibWFuLCBmJ2RkIGlmPXtmc2Zp
bGV9IG9mPW1tY3ttbWNfZGV2fS5pbWcKPiA+IGJzPTFNIHNlZWs9OSBjb252PW5vdHJ1bmMnKQo+
ID4gK8KgwqDCoCB1dGlscy5ydW5fYW5kX2xvZyh1Ym1hbiwgZidkZCBpZj17ZnNmaWxlfSBvZj1t
bWN7bW1jX2Rldn0uaW1nCj4gPiBicz0xTSBzZWVrPTI3IGNvbnY9bm90cnVuYycpCj4gPiArwqDC
oMKgIHV0aWxzLnJ1bl9hbmRfbG9nKHVibWFuLCBmJ3JtIC1mIHtmc2ZpbGV9JykKPiAKPiBDYW4g
d2UgdXNlIG1rX2ZzIGZyb20gdGVzdC9weS90ZXN0cy9mc19oZWxwZXIucHkgZm9yIHRoaXMgcGFy
dD8gSQo+IGtub3cKPiB3ZSBjYW4ndCB1c2Ugc2V0dXBfaW1hZ2Ugd2l0aG91dCBmdXJ0aGVyIGNo
YW5nZXMgdG8gYWxsb3cgZm9yICdzcGVjJwo+IHRvCj4gYmUgcGFzc2VkICh3aGljaCBtYXkgb3Ig
bWF5IG5vdCBiZSB3b3J0aCBkb2luZywgSSdtIG5vdCBzdXJlKSBidXQgSQo+IHRoaW5rIHdlIGNh
biB1c2UgbWtfZnMgaGVyZT8gVGhhbmtzLgoKWWVzLCBta19mcygpIHdvcmtzIGhlcmUuIEknbGwg
c2VuZCBhIHYyLgoKUmVnYXJkcywKTWFydGluCg==
