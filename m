Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCEAC36005
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 01:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FCB88186D;
	Wed, 26 Mar 2025 02:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="gX7tN7IO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1BC08192A; Wed, 26 Mar 2025 02:52:14 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7867A8083E
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 02:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFzBvLu50W14jSWYbnHrOj2dSRm1skSzQOCdsGY0SXQMXmql254lufAxjWce+hypDfITq5E7ebRRwZUmQAnpRJ8Rnst7kizfrEE3kINGqfNlYiuW1m82RzcAhMtwV4lIioW7Y2KwJYurm04VNFAVG8zEUju/U56xJPk3dxsliVmRoNh7PFRz4GZWdjzhfI2rcRF6c7pvtlcpY6K4crepdUPSd5J77R5bAR2oym3LztBcsNgIDTs31CDo6gYcTkEz4ANL6+smnmccg3qq5/8OVaYU59kcE3eHO2GxpSsnDNwVL8/8myx2M/vUkjlX7mCtL81ZP4tADwdFj23B58M2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCnfCQqQlYgOo1i5VO0LSoIenKi7nwvHmRw4Fs6jlFk=;
 b=vN2ILC2QuOi08+iTrZlkyglDFd6Jc0nC2yWNSZWwsJhsB/5WPW8AmKep5dYM735INpTCgONk8x+hNBvhMUcqSzSolcuZAa7geNuQHHvSDB+Tw/TXtM+5PcR3n8ZxIRkQIeERl+U0zkZgDviUCEwrURtqUt0gV4XQixLkjHWDEoWGmupCSjTNKmGp4AoH/iC+2SVXBjIUxUeGSRgfltD1c0+bEAHaW7Aeb8s66V4qdkBracvn0EjRbaynO83qE8xv6c10fNIRgeyBCHkSBviDHFjCf9V85VeBaCSbD/aIzML1s5V06/rx4NU8Eyj1fj2DKksMMttmqUbsqpHACM/B9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCnfCQqQlYgOo1i5VO0LSoIenKi7nwvHmRw4Fs6jlFk=;
 b=gX7tN7IOiMa7YIv8kS8Nhp05/+3kkW44GF1cUhAcgpVsUghhcQWqbJT1ZnrbVUlu8sb39NvGPQBO0jTIbG7qD7+m5jH2MGLaN2F5btjdNi5M8UHYTHJWFTtCiUUgutg0DPP6dTr4AMM68MKsx9NLBQ0Dj8IuNPnpRZKne3avJxUWqC6+Biqn7SQFsc0cRlSfr8hN+IPWxmLubs/wJ0TJ/Ek6TDnGV+ZqDLlGBbM6bt9H0yHNPLUGjJKqKTkxB3pMsJDrOzGbw01N7XCiHKOVLmrO/bBTDzCEYTJUw99punj45fqeBOW/zLoHaEGdNL81vNhanGU0iDOBhlSfpLPUlw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9423.eurprd04.prod.outlook.com (2603:10a6:102:2b3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 01:52:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 01:52:10 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon
 Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ranjani Vaidyanathan
 <ranjani.vaidyanathan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH v8 02/19] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
Thread-Topic: [PATCH v8 02/19] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
Thread-Index: AQHbmjEaKrmczG8t6k6faxPwia7E+7N+Uy8AgAUx/ACAASH9AIAABs+Q
Date: Wed, 26 Mar 2025 01:52:10 +0000
Message-ID: <PAXPR04MB8459808C7CC6C16DB43B973388A62@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-2-f2c8ba815f89@oss.nxp.com>
 <a180b7e6-6978-4814-97ff-05e34223938f@denx.de>
 <20250325080614.GC27303@nxa18884-linux>
 <a84f63fb-61c2-4f0e-89ed-8046e8eeed85@denx.de>
In-Reply-To: <a84f63fb-61c2-4f0e-89ed-8046e8eeed85@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB9423:EE_
x-ms-office365-filtering-correlation-id: 044e632b-1999-424e-9ff5-08dd6c08d27d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?eit5SXB5ZytSWnpLQVJBQjkrbGxPRWNEMWxGMWUzcjIvTXE4bTBBSHpWVEM4?=
 =?utf-8?B?UHJsMExmaTM3ZHNrQWY4SCswOFNBVUpsK3B6WlV4OUVMWVhQSEpPemZEdWx1?=
 =?utf-8?B?M0RwOUIrV3V1cUtaelpuaWRBSFB1b3F5NU8zNXBndDI5UFJnbnlCWnQ1NHNF?=
 =?utf-8?B?SHFFb00wK1NFaWc2Q0psL2t0QmRjdE14Ukx2Q3diTlpiN0FsUEVTbit0czhO?=
 =?utf-8?B?V3dWUjljQ2N3Yzhpcm5jNGdkeFA3a2JYcCticmxLZUtGeTNHWEwwYjE3WjFP?=
 =?utf-8?B?SVJvSE40TXRTRUxDbTNLd0NqSG5XRit5VWRubUZPNzAzeGhRczVVbC9aRWZn?=
 =?utf-8?B?a3podUJyaWFsc1VVV3BreTJUSVRlbVpJcWxMVGtsUkVwRytYYlVDOHNlRURp?=
 =?utf-8?B?c2YzbUdJSXd5NUwrQVNiNnN2b1R0N0RLbGxPNDk0ajhzbFVxZEFCVUtVdnF4?=
 =?utf-8?B?bXV1K3p1czBsZTAyWXFaQmpySGxvakJiVExVZlhWYzlEUjh0TUgrZTFaQ1Az?=
 =?utf-8?B?ZG5Ed3pGSmtuU1lRTHlRUm9ZQTdhRUNOR0VuSkg5VCsrVDREZ0JsemkyNFdO?=
 =?utf-8?B?SVZSUDNFbGNZUXh3TU5TQ2QwNmtlQ25tTDZYMUZVN1FVa1hUK28zQUVKemZq?=
 =?utf-8?B?bG5hWU90d3g1alZtMnRUQVprNjVDd0dXc29Ed2JwbjZHRzhzZVdpbjlyUnFU?=
 =?utf-8?B?TUpneG5lMlJ6V1RicHI3cW9JVzdlRi9oaFd2RlNCZTMvakc0a1haV0RuVEVD?=
 =?utf-8?B?ei9RTG51ZUpVRmNML2FLTkNIdU9sMnlkMUc5QzZPMVFEQjFPZXltRE1iZUZE?=
 =?utf-8?B?K3pvenIvVkpIeFl6Wmc4VmYybG1WM3pRQlhrYUl0WXBxSmNiRENZbUVPK3Ni?=
 =?utf-8?B?eWZUWmtiTy82U1NqUFVxQUx5bWFmQ3hNclZKRDhaOUVJalNVZzdYeU1QODVu?=
 =?utf-8?B?Y2dBT1F5UVVvNXZ5cmszN0xmNDZyc1lRN2FsYVk1QVFpcE5EWEJWNlcwWjJs?=
 =?utf-8?B?QkdIaDdPVUkwVG44NTVNbUQ5RWxSQlN3bHV1ekdESEVaUEN2VllvUFN5OFND?=
 =?utf-8?B?b3ZQRUVQZ1E1ZEtwNkRCQlNGUXdmQkttZXNxUjByVmIyT1pxajB2dTU2cmpm?=
 =?utf-8?B?MnhEQjRnMERTNU9yYkhBT2Y0THR6NDNUTlprYjA3blpvSWs0ZndVZnVHVXoy?=
 =?utf-8?B?blFMRDUzV0s4NGVKdGIzbGlScDJmM2g3MitCNnVkS244UFB5aHpFMjVNdUpE?=
 =?utf-8?B?UzdUUHZnQlRWVVBVVDVKYTVzODhBQVM0dnBjSGJQMHVselRqOTMzV1JLL3FJ?=
 =?utf-8?B?WkNjeFhHaTlVYU0va2c3cElzVFY5THE2eHNRQ1lBdldqb1BiSWRWdHppTmpT?=
 =?utf-8?B?dGI0VXFyQjQwOWVGUWxqUS9LeVhOb2UxLzM4YVZxb0xwRzBIOGRaa2pSVFlR?=
 =?utf-8?B?cFlneUg0TUl5ZFNEc0JzOVQ1RUZBbFp3a1RLZGlycEttaW1UdFcwWVhLbWpQ?=
 =?utf-8?B?TkVneFJlakhXdW9TRUNMdDVwUUoveWJnbVhRNHVrMVI3QmtURjdTN09NTTZl?=
 =?utf-8?B?MHpLdW5PSlRCWGl3RVFnUldKaFNrVlF1aW5BZmpqY0h5TnlYSUFtWEpvZjdN?=
 =?utf-8?B?bWlVQU9EVzF2R2xqVTBCMzBpc2U0dklzS2xhUjdQblp2Zk5qVkZyS2o5eUtS?=
 =?utf-8?B?WlFMTmtaMnpWclpZM09KMGQ4ZXRlZDZCZ2o0R3d1eDdReEhrR3VnTzBOUFFp?=
 =?utf-8?B?d1A5N3hoUUFYd1J4N1dTcXR3eUg4KzV5QUN4UlErQndjaCtsSHhJWHA5cExv?=
 =?utf-8?B?dXo3bFdvaXVBVUVjcTg2K21RR091UGhXVWdjWk1sbDA3WlY0U1FmYm9HQnNV?=
 =?utf-8?B?QnhNWk4yQWhZTFlnb0JaVUR0dFlDb0lWc2RQNURKbEptQnF2VFU0bHNKMjVv?=
 =?utf-8?Q?lR/RdugAIeRtIq7pYHuyvo6iRtXx2jSW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qmw4elZhMkVhdlgyYUJkTFpoZjZqcnJTSkZQWENWOFljY3dUMUdCdGtaR0p2?=
 =?utf-8?B?QkRjZW84UmhCbTZuaDA1bVhuWE9RcGVpRmhsRWplQzJTdnRlcDVuaTA1TWdi?=
 =?utf-8?B?QkRwYmQwQzRieXhCNVlRUVFNcWdXb3IwS0RQVXhYaC9FMGtRRVJCV0k3aEIw?=
 =?utf-8?B?K3p1L2N1YnNwNXp0TlJVVWF3cGt2dzczNTQ3K2hneTRJZEV5TmNUZS9BYTg2?=
 =?utf-8?B?OWJFbkVXc3FleGpkMnRsUHkzZ3RRWERPYTJKN1JzNUZFYWdKVUg0VVZDdGY0?=
 =?utf-8?B?Uk5JMFFqMnlHS0U1L01rUmFCalBOclUxQkNCejI1YmNPRFdZZDhQNndOdnVz?=
 =?utf-8?B?RUlSbmhkS2VZOXVUd3JOQjY4a2ZKaUhPMHA5RnlzeFRNOHNBaUlFbFFkbUJk?=
 =?utf-8?B?QTVpNTI3U2RmcnIzajlkcEVBRGJZNDcwa2VGcTV4STgwNFNxeUFuMVFJWmF5?=
 =?utf-8?B?NkFOREFFWk50RjMyQUZ0a2xkYjJjK3ZOWlNNbTdOd203OG5vWW84Z1Y3NTBu?=
 =?utf-8?B?c2NoWDlZSzBRcHB1eWZhSkV2WXhIQUNQZm1Gdy9aUFNBTHlwZDJJZE9BaG5N?=
 =?utf-8?B?K1hObHk3R1NZUWJPbE5wcklUNGRSTzVkN3FkSjZYT0FnNTlILzhsUWRkMnJU?=
 =?utf-8?B?QzNEc1dPOUJwcFBndlNkMDZ2Nzlxb1VGcEliNE11YUNtNjM5TG9xOE9DOTZ2?=
 =?utf-8?B?SE9nOWhqUS9Ncm8vOXQzeDNZdEY5OTQ1bTlnRnVuUkltczhDK1dnQmJEYWYx?=
 =?utf-8?B?dnVycTZKM2JORFJEVERDZEtEMnJrM3o2VEo3MUdtaDNia0szK2dRQ1pUeGk3?=
 =?utf-8?B?UGNieWtac3pkK3FNSnFReWNFTXhnUWowYWZURE5pOHhFU3gxQkNDQlJMN3Aw?=
 =?utf-8?B?OTF2eVVHTjVSUXI3ODlMWmlzTWl4eEM2Y2dxRlBOdnZ6d2ZUNTNkWXZiUEZl?=
 =?utf-8?B?bThvUGlDNjdnYzM3YTdOL3FXL0pJcFU0QmRxcEJPWGovcHRVMXZkc1JHYlhz?=
 =?utf-8?B?cUpOM2J3SjJmdnEvTnZKY3dpaUVKNldMZngrdHUzdlBSdVNIK2VPYldmVzlx?=
 =?utf-8?B?Z1pwRkhGTzNFa2VFNnZnNVdSRTFaM25IdVRkV21VRTZXZlpYVzhSNkYwakRv?=
 =?utf-8?B?SkZKVThnNE9iendZQ0ZIMTJIR1RteDA2elltd2wzS1hVU0VKRDV2YitTS2cz?=
 =?utf-8?B?RG9NVThLQVBUZkJ0TkVnVEp4VVA3VzBrU0FJbTQyYzQ1V3JWK280b2ZicEFE?=
 =?utf-8?B?Uk9HTzBRMmRod2dmM1NIMFE5WkdHSHN3RjhoVU4xODU0ZEhnN0piQXhGNGpL?=
 =?utf-8?B?Qmd5L2MweTgzeldIK2dNZ0JmTjVoMHQ1V0V3SVBkWisvUmd2RTVZMjAvclg5?=
 =?utf-8?B?bHBsZ3JEM2lzM00weXBGaFN3U2cvQXE1OFU3M1hlUE16QzIvelhjWEEzZm5a?=
 =?utf-8?B?OGNOYmIxdXFka2VMSWN1YU1mVC9zSUZ3MzR1RmM2WjVlcnYrdGFvK0dUaXlQ?=
 =?utf-8?B?WkVQZEJOT1dUemFzMWxkSVQ5Tm5FZ2ZwdUJCdWFIRmhnUGQ1TEpvcFZaS0wy?=
 =?utf-8?B?YkZLN0FkcVg2eXNWaGxEVGpXempIbFhSRllSLzQ0ZHlVajNiQWptdlpDR0F3?=
 =?utf-8?B?S3dweGpUMDNQWm16MFpFSFR3WGlGd09pWU42bm83OFZKUUMvcEFCV3V5cHZh?=
 =?utf-8?B?dkhhZlFuYTdUdVhqNEJKUnl6akh0ZXdYUHZCVllIZ1d5NkVZVmNFMkpLbFBP?=
 =?utf-8?B?SXlFNUQrdEpCQU9iUWJ5REphMVVYMlFYZ0tYM3pHK3EzYmtlNDdYVTBrbVdL?=
 =?utf-8?B?aEpOU3FPQ3pSQzlnSjRncVZwaUQwdXRBVXEzbTVJOWZzR0Q2ME40dTJqdzJO?=
 =?utf-8?B?VmdoVGorWm5kKzcxbDRibXNTTjJhM3Y3bDRRQW1iNk9nWTNUcWFHb2djYkUy?=
 =?utf-8?B?TEhLNHB6VTlxS0NVRHh3bFNLd3JXWDhyVXVTQjVuMmhxTXp4ZzJzUVpQcVZq?=
 =?utf-8?B?eGwraWRhbnhVUHZ0Q0laT1hoWFBEckRPclFkWVpzKzdRcnphSWRNUDdQbTRT?=
 =?utf-8?B?c3VwN2I3elowKzVQV2dLV2pSQzZ3dnN6MXNtek5HKzRrcklXbjBqbDlwTUhO?=
 =?utf-8?Q?pZt4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044e632b-1999-424e-9ff5-08dd6c08d27d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 01:52:10.3145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Svzx4higSam+Ik5dO4560EV0PChqg6N0MeFd5G9t0MPAL6LbeKvnJbCD+i4sKwnLv8DlLSzP3CCC3wGAdRfLFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9423
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDAyLzE5XSBwaW5jdHJsOiBueHA6IGFkZCBhIHBpbiBj
b250cm9sbGVyIGRyaXZlcg0KPiBiYXNlZCBvbiBTQ01JIHBpbiBjb250cm9sIHByb3RvY29sDQo+
IA0KPiBPbiAzLzI1LzI1IDk6MDYgQU0sIFBlbmcgRmFuIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4g
DQo+ID4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zY21pX3Byb3RvY29scy5oIGIvaW5jbHVkZS9z
Y21pX3Byb3RvY29scy5oDQo+ID4+PiBpbmRleCA3YWJiMmE2ZjM2Yi4uMjc5ZWJiYWQ0NDAgMTAw
NjQ0DQo+ID4+PiAtLS0gYS9pbmNsdWRlL3NjbWlfcHJvdG9jb2xzLmgNCj4gPj4+ICsrKyBiL2lu
Y2x1ZGUvc2NtaV9wcm90b2NvbHMuaA0KPiA+Pj4gQEAgLTI0LDYgKzI0LDcgQEAgZW51bSBzY21p
X3N0ZF9wcm90b2NvbCB7DQo+ID4+PiAgICAJU0NNSV9QUk9UT0NPTF9JRF9TRU5TT1IgPSAweDE1
LA0KPiA+Pj4gICAgCVNDTUlfUFJPVE9DT0xfSURfUkVTRVRfRE9NQUlOID0gMHgxNiwNCj4gPj4+
ICAgIAlTQ01JX1BST1RPQ09MX0lEX1ZPTFRBR0VfRE9NQUlOID0gMHgxNywNCj4gPj4+ICsJU0NN
SV9QUk9UT0NPTF9JRF9QSU5DVFJMID0gMHgxOSwNCj4gPj4gSWYgdGhpcyBpcyB0aGUgSU1YIHNw
ZWNpZmljIHBpbmN0cmwgcHJvdG9jb2wsIHBsZWFzZSBtYWtlIHN1cmUgdG8NCj4gPj4gbmFtZSBp
dCBhY2NvcmRpbmdseSAsIFNDTUlfUFJPVE9DT0xfSURfUElOQ1RSTF9JTVggb3INCj4gc29tZXRo
aW5nIC4NCj4gPg0KPiA+IFRoaXMgSUQgaXMgZ2VuZXJpYyBJRCwgbm90IGkuTVggc3BlY2lmaWMu
DQo+ID4NCj4gPiBpLk1YIFNDTUkgcGluY3RybCBmb2xsb3dzIEFSTSBTQ01JIHNwZWMsIGJ1dCBp
Lk1YIHBpbmN0cmwgYmluZGluZ3MNCj4gYXJlDQo+ID4gZGlmZmVyZW50IGNvbXBhcmVkIHdpdGgg
QVJNIFNDTUkgZ2VuZXJpYyBwaW5jb25mIGJpbmRpbmdzLCBzbyB3ZQ0KPiBuZWVkDQo+ID4gYSBz
ZXBhcmF0ZSBkcml2ZXIgZm9yIGkuTVguDQo+IEJ1dCB0aGVuLCB3aHkgaXMgaXQgdXNpbmcgdGhl
IHNhbWUgcHJvdG9jb2wgSUQgPw0KDQppLk1YIFN5c3RlbSBNYW5hZ2VyIEZXIHBpbmN0cmwgZm9s
bG93cyBBUk0gU0NNSSBzcGVjLA0KdGhlIElEIHZhbHVlIGlzIDB4MTkuDQoNCg0KSWYgeW91IGxv
b2sgYXQgbGludXgga2VybmVsIGRyaXZlcg0KDQpkcml2ZXJzL3BpbmN0cmwvcGluY3RybC1zY21p
LmMNCmRyaXZlcnMvcGluY3RybC9mcmVlc2NhbGUvcGluY3RybC1zY21pLWlteC5jDQoNCkJvdGgg
dXNlIHNhbWUgSUQgMHgxOS4NCg0KSXQgaXMgZmluZSB0byB1c2UgYmVsb3csIGlmIGl0IGlzIGZp
bmUgdG8geW91Lg0KU0NNSV9QUk9UT0NPTF9JRF9QSU5DVFJMX0lNWCA9IDB4MTkuDQoNClJlZ2Fy
ZHMsDQpQZW5nLg0KDQo+IA0KPiBBbmQgSSBmZWVsIEkgYXNrZWQgdGhpcyBxdWVzdGlvbiBtdWx0
aXBsZSB0aW1lcyBub3csIHBsZWFzZSBkbyBpbmNsdWRlDQo+IHRoaXMgaW5mb3JtYXRpb24gaW4g
dGhlIGNvbW1pdCBtZXNzYWdlIC4NCg==
