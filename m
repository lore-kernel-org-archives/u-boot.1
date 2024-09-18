Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E260DCAC5B2
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 00:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 344EA88D57;
	Wed, 18 Sep 2024 02:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="PcNUzXTe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2540B887D1; Wed, 18 Sep 2024 02:48:49 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FD6288E15
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 02:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+zUWKgC7MkJBZcESLP1m98IIswh9PQIR9K0pQMX4doi4/NmuPg0MIzzgU3tlwPWTqV34YRW1m2ni2ZgSa4ZhXdPeTFbUDpedsPEHUZE0VCdRrXY429zAVs7qFe/rJhTB2u5WDHOcdlcqoDfihqKKW8Zfo1y/NRVNACO+PNQfVa5EqeUA3n59gG4R8ZtadkqAENRiaHgCstEuoEEFNxsUz11dCsBWJTXx1n3d5XoFfmtxmJqjKMqyufUPYaa6vf8G1lz1I8cZ2oR/t8xN/zdfIaIJbu1EY4h5hEvM7SJ4igsc9AfHEFbFMqK+n+33cpiKkpmbiNQwiAaemgTJI+yJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlk377eIRi+xyyGt1ZME7RqlRr7oxwMmEi3EzUe4Lbg=;
 b=bVHphJMyC7kUzZ2Kp4aOMblc1NfWJ0wkFFJAFNxQrjv8r/xNjJwV9jhK/dye3ghybgoc/8YA6PHe1BfK0n1HBxmwE9I3i0qOEZ6ZNLBdk3vqrY95O738vqUnj2/Njjsb5bY0RQDiMDurEFApq4UM0h3PvINRKJRRWhIMIfU/byTAxiUI0pocgArEaFGDtVFyA45S8uD8jm9cgLWs0UCOA98g1Bs7xlEfmTI3BcZFHMrOx8QbJdHKpdEmRlADkT1lKRoijTUqt5PznFMkoramHfFmbEuVqeN4vGwD+n+puSEl0srSiH88lkzU35NeSTR+I2YIWp777q7E3QQow12BuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlk377eIRi+xyyGt1ZME7RqlRr7oxwMmEi3EzUe4Lbg=;
 b=PcNUzXTeWUfCCv+Gd+n+ceCBlWKl/iBBGR8oiQfcams0gRZo2T+tB7NGgIAM4ikV7gRKhjatNweoMcnP+2waw/trzd2bIgsPQ7DDZcNpBwrnEaOwW5raOynBuIOSQULrAo7OYC6o3TUI2dyEHOfI4ajzlwXXEJZopYHcsDW7FPTwtNpkUxVil5a+SD2/wZPfQLVr4YCxlAYOHeT2KIt2gANvkBWVb0f1tdZCl2DZ2Vzf9z2sIEuMx7p6/3jlBUyrF3P+ejtWnE4qSzsnDu4l1GcCSccD38lw0JIoQdboGIeRvqAaguWz2fopOHSik3nPOMHW2aTIukwDU4rbAaOEkg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8419.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 00:48:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 00:48:44 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Stefano Babic <sbabic@denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH 21/21] imx93_evk: Enable M.2 VPCIe_3V3 and deassert
 SD3_nRST
Thread-Topic: [PATCH 21/21] imx93_evk: Enable M.2 VPCIe_3V3 and deassert
 SD3_nRST
Thread-Index: AQHbCKmwtXn5HoU12EiUCrPjGGILZbJcrb2AgAABQBCAAAg3AIAAAGMQ
Date: Wed, 18 Sep 2024 00:48:44 +0000
Message-ID: <PAXPR04MB8459F487D4517EFE0E89C92F88622@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
 <20240917-imx9-update-v1-21-4fe8effc937e@nxp.com>
 <CAOMZO5BzLSCTOpOz7vvp-uGfPQAjViuoCP-fyV3BZ3KnxeZm9Q@mail.gmail.com>
 <PAXPR04MB845979D1A524FC309F7A84CF88622@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAOMZO5AN4i8n3BKBqKpU4M9AfVP0U80XA6+somUTM1MkSKXxuA@mail.gmail.com>
In-Reply-To: <CAOMZO5AN4i8n3BKBqKpU4M9AfVP0U80XA6+somUTM1MkSKXxuA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8419:EE_
x-ms-office365-filtering-correlation-id: c149d752-e7f7-4e6a-eab7-08dcd77ba5b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c3NJK2o1RWpPZU9yUjAzb0ExcXp3bmYwRExaYVA0VjZYWEVhVzJ6bnBZN0xF?=
 =?utf-8?B?cmpIWGF2RGQxRkljWENNa1ltWFIzMUVSQ0FiSmlwRGQ5RDgxTXhtWHluRjR3?=
 =?utf-8?B?UlF4bnN1dU1RQU9kcWRMcXN0eThxNG5EeFFmSE10WnVMNXp5NVBwS2hDTUlE?=
 =?utf-8?B?NlJ6blIzL2NjWHUrd0JndStoamxkbS8vR2MxcUZhSlRDaG9OYk1xY3Z2d1FU?=
 =?utf-8?B?dk9Ia0JsYlNxbWhuTHVnY2Q5YUpHOFNPVUdDWWYyNk82bXYyT1h1VWJTcnJi?=
 =?utf-8?B?ZGszckZwODZrMlI0UWtkOFZQakh6YTlwRGZ0Qi9wOU44SzcvdnNma0MxNXFr?=
 =?utf-8?B?Yy9NQzZveHVPMmlWSEl2KzVJbHdxTXhXK2ZnRGZ2ckhnRGVuQTcyN2xhNDVj?=
 =?utf-8?B?MGtwMnBjazdxY2g4cllRYWZnYlYxd2VtRGhXWXBncDAxd3NyZm9aYUNFM1Ro?=
 =?utf-8?B?U29JYXNmNy9qSlBPa2toa3dvN1d6bTNjQzh5VWxsdUpISjh6cnB6STNrYnBY?=
 =?utf-8?B?TTd0em1xSHNqaFpkU0ZwMTdkZGd0Tm4ydU1wb3dKdll4UE9tb2RqVnRTQ2x0?=
 =?utf-8?B?dWZiSGJrUFlMOExxTi9yd1h1bnZWVytjTWNBVlFFbThrMnV5aU9aOVlyQ2k4?=
 =?utf-8?B?SHo3L3pUZitwenlIdkpnRjV3cWFyWUhaU3hySmMwblQrVFhjYldORDBtK2lj?=
 =?utf-8?B?U0svNnBTZlU3dXZKMFpOd05uUFBWUkMwUEhrY2VFNXRXb2k1MUtadVVoUzBX?=
 =?utf-8?B?UU11ZGUyZENDVHpJdlBrdmFuZmZjOS9xdi9pWFYzYVNWWUVhSWFSTEQzYkx4?=
 =?utf-8?B?VVFJVDZVREdwSzdXaWNvNmtsVWNwSFI4QTFRMEtqT0h0VkI4WXoxM2MwSUt6?=
 =?utf-8?B?K0xLeksyLzBjY1lWRXRSb2o2UHhZajd6M0JCUmpENHVJaEs1Z05JRFN1Y01w?=
 =?utf-8?B?NTFNTnpRblV6R3cxK2RHMVpCSXY1bFNxMHhZb2JleUN5R1EvVVNCcVZUZEFv?=
 =?utf-8?B?KzF2TnlGcTV2MUpNNml0ZC90d1ZTeVY1eVdJV1F3WXdxWnJJWXpMalpqUFMw?=
 =?utf-8?B?UXJlU1lwZUdZR1RyQXpDMUVHMGVOMFBZTGY1V20wenM2TE55a1NBck9PaDZx?=
 =?utf-8?B?clY5bGtqeDlUZFRBWVFZdHh1cGwyVndMOHc1b2FCRE8zZmZVclJmMHdoSG04?=
 =?utf-8?B?SExDVFRkUzFZZ0ptUnJ3R2JGTGhncDlpWGFOTnh0aWRuZlpsMkFHUzI1emZJ?=
 =?utf-8?B?UE5FT3ptSWVWY0thRUZ2aWFLaG9rSEhFUDVkRWRrb3BtWFkrNGJGbjd4V0tv?=
 =?utf-8?B?T1ZvTVQ4ekhGdjQ1QXZNZi9qcE1yQTQrNnJETW1RdVFybUVqbkNoYVN4MHRh?=
 =?utf-8?B?UkNBVGptUGxRclUvd3RhUi83eUxvaHJVb3Jxbi84Y2FvOFgwUWRTdFRXK2Fs?=
 =?utf-8?B?bGJOTWhCT1hBVjMwUTNoU25leVBZNlFhK2xiOXJGUGloK3pCa2RwMDd0RnBn?=
 =?utf-8?B?T2h1VmwwbHh4WVNtNEU0czJsTHVweVlmK2l4T1VkWGhBZ2xIWFYycW9COURD?=
 =?utf-8?B?cjM5Wm1sMHJJNXE2ZEZWRk10Z1lXU0h6RENGN2JxTUFvQVhNZDErc016L1lU?=
 =?utf-8?B?QWtZWXBhOG5ORSsrSHloSDNuRDN3ZUFiSmpnVDkyVkMvKzNWZjN5RWNiQ1Q5?=
 =?utf-8?B?UVRiNEhGanhRQVB0OWFNWUVBWkQyRG45Wi9Gc3lwUkhNTGlDZ2FDRWVhOFBx?=
 =?utf-8?B?MGJMbVBJenY4c2EvdUFaTXlSck1aWG1VLzRJTmkyRkpocnBDdW1DMHNvOUd3?=
 =?utf-8?B?MUkwVThJSDE1aDJEMVdta3JYQkVwOExoS29VRlptOTNsZEtsNTQyTFJzeHZl?=
 =?utf-8?B?cyt2S200UG0xRWxGUmhtaSt1RUtrSHVZbkxxMWRNdmwvRVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2JpTjZBKzhVRzN2eUJsaEhWUWJPcnJmdFIxOTJFajduWGxhdEpSZ2wwVHlD?=
 =?utf-8?B?bFlycUhVaXlLdEtOZ05IZ3ROUnJ5L0ovZlFTNGJoWC9rLzBsd05LZVhUNjJT?=
 =?utf-8?B?cUsrOS9iVng4YXk3MW1lcDl5cEJ1cDRRRHgxcGJyOThEWDd2LzYxdG1XRmdu?=
 =?utf-8?B?OWV4ZGhQcHZDZlZRcFA5NHpuT3NZZVpIOTQxT2NjK1RNWTVZT0FIZ1gxNUNk?=
 =?utf-8?B?dlliZE1DRms3VlFZVnVPdXhKR2NtNitIS2t2QTUwS2xhNWUvSHduS1cxMko1?=
 =?utf-8?B?WkgxRU1vRlZadStXQlJDSjNZcWVORVgvbzhZVnNSdTlkNE9RbURvdjl6NDdw?=
 =?utf-8?B?eUtCeEk1a2RocTZLNSt5UDdvK2ZYTzRRMk9LYVhxMnpRd0lsRzUzVUtjRDlt?=
 =?utf-8?B?UitXWmdqSXY1N2dyeUtSSFU1N0xEUEJsL3VvYnNyMzlUd0k2Rko1Yk1WU1ZX?=
 =?utf-8?B?aURSRDFRMnpPU0tuTDlHZzNzSHVrNFdKMnd5ZlFVVUpNRFhLS3RKaDVPSU4z?=
 =?utf-8?B?N1o1ditBRXhXQmFKeHJHT0xHZ0k4UHZlRXIzREMzbjBQU2x1dlNJZ3BtcVUx?=
 =?utf-8?B?a2cwRStsdTBMNGMrY1V2Vll3WEEyNFpESjJBZ09PRUw4Z2hQVGZGK3UxSUx6?=
 =?utf-8?B?REtqdUdWK1JsTE00a0UwZXpSdGg4N2lxUmRhODN3QjRlM2tIalUzZ1BQRVZm?=
 =?utf-8?B?YlU1dklNTzBNZjQxODBLTGhnZmduK2NCMDFkVHp6eVlKSmtTZVdocm8xRDZ3?=
 =?utf-8?B?YVBkd1VyQ3JVUjY2SDFhTFdZZTBFVCt3aDFkU21yb0hXaTFOMHhpdUlkekhu?=
 =?utf-8?B?TXB3ZVNoUmh4d0FhZ3pmR1dxQ0xYRGFaQ1BiNGE3d2VLYjlISDJNb0RsUW90?=
 =?utf-8?B?Q0J6ZnMwN2VHUTZoUnJVRjlaVEN2SUp3VU9UVDdVUllxeGk2TG50bWV6RmF2?=
 =?utf-8?B?ZXZGTEJRR0NGUkhQelRDbWwydWxTTVdsbFFMUWdGZlVVNk1veWNMbVZHelRR?=
 =?utf-8?B?SnQwdTdiNm1PMEdZOVVkaWN5VDFDVXdJa3FyelM2SjJjbkhGWHBzcGNBTUI5?=
 =?utf-8?B?eWhwOFhkQnZFeHpCemUzMXh6OE8wZWdWMnFzdGt5SXVRVERCSTQyVDJkSjF4?=
 =?utf-8?B?WEFSQ24yMlV6UStwcEFVb3ZZTkdhVEhBb1p2WmFZVnFiVWZYSFN3R1FFZDdR?=
 =?utf-8?B?NzN2S0E4czB2L2xFYitSVXpPK2VZTzR0Y1U3SVByTjE1OS93NU9qaklBaFBE?=
 =?utf-8?B?a2FzbDNER09oZlZDZTl4ckw3MGMrZGtOWVZXSE10WlRXNkg5NnhSbDF4bW5l?=
 =?utf-8?B?YzV5ZHY4alBaMmdwN2dDSTBGL1JOTlR2ajNlUDg4cXZORE5Ya290ZUFxYVNm?=
 =?utf-8?B?V1h2MFJnY3N0MlFZcEplT2dYYVp4aldUaGdHQytQczdGTlpSMlArU0lBOGdL?=
 =?utf-8?B?Q2dKZnF3akZVVVJwMkY2ay9ydGY5U2VSa24xblVTTkw5elRDVjVMbjhzRys2?=
 =?utf-8?B?bEZhMnVXM2FNYWdVSStwcnFZRFpQZ2J2VmxrQWFlN1NKMk1PUkZhU0Vhci84?=
 =?utf-8?B?QXJhWHlkVnkxd09PM3FwN2NlSHZMSlE0c0VERk4yd29CNkVYVU1WWkxGT2FW?=
 =?utf-8?B?TTMwd2U0SFpHckp2SFZ2enVwSEZzYTJtZ3JhRFBSNWVjS1B4Rmx1MElmRXZl?=
 =?utf-8?B?bi9FN3VKK0VubTRlWHlOWXBtQ2RZOWR6SzB2ZXFObTZaVU9nemlGZ2NoVkQw?=
 =?utf-8?B?R250b3UyN1dQRmV1cnlqYzBXNTE4TzVyUmV6MzVhK1NKSUc2V3FEUFZ5dEll?=
 =?utf-8?B?MkhRcGQ1OEVjMW43U2ZkZ1czS0NhNU1nQVlOM2dXYk1zVWJpN2ZhSFd2aEhU?=
 =?utf-8?B?S3A4djdBWnZyM0ZXcGZvZE5vb0o1UkxPUEVvOXB1RVNWd055V3RjcjBzNWhU?=
 =?utf-8?B?d3gzSkNXQkpLTS9tZmtHaEFjSDFucTMydEdmTklUYVVKb3ZIejBaQ3JSWW9Q?=
 =?utf-8?B?MG9VS1lKdzZJZ1hnTkhHSHBWcmV2bm5vWkpxQnFIOHZZazR0akRSVUlxenRQ?=
 =?utf-8?B?d0x2N2x5ZXpsNk5KdVEyL29pZVhoZDJkQnI0UDdGaW5pQStUK1h4RmIwUVVu?=
 =?utf-8?Q?EimI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c149d752-e7f7-4e6a-eab7-08dcd77ba5b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 00:48:44.0555 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uzLgekd6oCBIa8qwnbOoGpNmVqrS5iZCbCNMARRz4kvSBPJ+OHHvf58XwkFNsHBevXIOf2zptOKcPEodCJr76A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8419
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIxLzIxXSBpbXg5M19ldms6IEVuYWJsZSBNLjIgVlBDSWVf
M1YzIGFuZA0KPiBkZWFzc2VydCBTRDNfblJTVA0KPiANCj4gT24gVHVlLCBTZXAgMTcsIDIwMjQg
YXQgOToyMeKAr1BNIFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiB3cm90ZToNCj4gDQo+
ID4gVGhlIGxpbnV4IGNoYW5nZXMgc3RpbGwgaW4gZG93bnN0cmVhbSBhcyBiZWxvdzoNCj4gPiAg
ICAgICAgIC8qDQo+ID4gICAgICAgICAgKiBGb3IgdGhpcyBzcGktbm9yIG9uIE0uMiBjYXJkLCBu
ZWVkIGZpcnN0IGVuYWJsZSB0aGUgVlBDSWVfMy4zdi4NCj4gPiAgICAgICAgICAqIE5vdGUsIFZQ
Q0llXzMuM3YgbmVlZCBhYm91dCAxLjc0bXMgdG8gY2hhbmdlIGZyb20gMHYgdG8NCj4gMy4zdi4N
Cj4gPiAgICAgICAgICAqIFUtYm9vdCBhbHJlYWR5IGVuYWJsZSBWUENJZV8zLjN2LCBzbyBpbiBs
aW51eCwgY2FuIGlnbm9yZSB0aGlzDQo+ID4gICAgICAgICAgKiAxLjdtcywgaWYgdS1ib290IGRv
IG5vdCBlYW5ibGUgVlBDSWVfMy4zdiBmaXJzdCwgdGhlbiBuZWVkIHRvDQo+ID4gICAgICAgICAg
KiB0YWtlIGNhcmUgb2YgdGhlIDEuNzRtcyBkZWxheSwgYmV0dGVyIHRvIGJ1aWxkIHRoZSBmbGV4
c3BpIGRyaXZlcg0KPiA+ICAgICAgICAgICogYXMgbW9kdWxlIGluIGRyaXZlciB0byBhdm9pZCBz
cGktbm9yIHByb2JlIGZhaWwuDQo+ID4gICAgICAgICAgKi8NCj4gPiAgICAgICAgIHBpbmN0cmwt
YXNzZXJ0LWdwaW9zID0gPCZwY2FsNjUyNCAxMyBHUElPX0FDVElWRV9ISUdIPiwgIC8qDQo+IGVu
YWJsZSBWUENJZV8zdjMgKi8NCj4gDQo+IFRoaXMgJ3BpbmN0cmwtYXNzZXJ0LWdwaW9zJyBpcyBh
IE5YUCBoYWNrLiBJdCBvbmx5IGV4aXN0cyBpbiB0aGUgTlhQIGtlcm5lbC4NCg0KWWVhaCwgcmVz
ZXQtZ3Bpb3Mgc2hvdWxkIGJlIHVzZWQgaGVyZS4NCg0KUmVnYXJkcywNClBlbmcuDQo=
