Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A511C02185
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 09:55:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 358A980711;
	Mon, 20 Jan 2025 10:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dQNv0AgN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 475FC801CF; Mon, 20 Jan 2025 10:06:33 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5522D80077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 10:06:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AS/gwNsI07GXYV9ak8FyFpeRH3AZvi/dc71mo3GcYRao0HrWd/i6ifezdRXPG/JdBeuKl7y6Rl+rG4rDztF9tdLPbsHn3EThK19rrYGiAMoOkFDe9tz3ixiklXYedd+Nl/3kLsQQiHOiaAmtztm7bQoICCDPEfzUCgRcojNC9rOdPBXQrqRYDWvOrbprDcsucVWR5y/piPJX7VexOgHU93278Bst5oT6pTNfHUQ7eFb1mQxswlVXOmYkLDEPj+IKD8CwbLfVFX94J9U0l1fn2N+2J1PUwCUvvy0YZ60u6OPSd4OauKHCG1chvkeQNRNpF/Tcxi3CGHHsFbbXPaZVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVuc1iCNxTiX5klPEZEe6CpDf/sNSwz+7vU72RU1NfM=;
 b=jNkDicD3ECMuCK0Q8IS3xWO7bSpHs/68NvKyXeloWhAVTCBkNQa86KnDZ+zO0dm0XEZLv01eeBFpUZtSJlN0Juu4+aWPg2+7TCDwC/CcXRpAmTZjVCmCcdbuZgSF/CZNoA2PEMmjfmapa66pSc5KSfxzxN4DOmQ2jtZ3wKU6psdhp8zFuKSQewwsQDMW18DntZBkcbF0Bbk8n6/9SpmfMhPs/vrkEpy15d8hHwRG63Z69gcYYy7Kq/gKjRoY7jny+qFSXMQpDK5DTCtNIOhY4J4kRV1txunoNdkD5mAMSQqkgiqLbdAJJ1suygFg8fYAhvFGHlnnXA0Hu1h02+lEWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVuc1iCNxTiX5klPEZEe6CpDf/sNSwz+7vU72RU1NfM=;
 b=dQNv0AgND4ABuFSikZqzkRLBvGT9c+9nu8nQK/FWLZKlJaV/GQ/71E8Y9UUqVeLYTWsBJ8jWmoFqmqOr+nv/KNCOSZIZ9bi8bl0WRLe+H7U9I0tvqOOE/FCWAObmi80UpuZBO+aYdUXwtSGBeLQqCDWhHDvTzvikiNgHBm8yBXQ=
Received: from MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17)
 by SN7PR12MB7180.namprd12.prod.outlook.com (2603:10b6:806:2a8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Mon, 20 Jan
 2025 09:06:27 +0000
Received: from MN0PR12MB6004.namprd12.prod.outlook.com
 ([fe80::8146:4908:c42d:7eb5]) by MN0PR12MB6004.namprd12.prod.outlook.com
 ([fe80::8146:4908:c42d:7eb5%3]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 09:06:27 +0000
From: "Erkiaga Elorza, Ibai" <ibai.erkiaga-elorza@amd.com>
To: Alexander Dahl <ada@thorsis.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Simek, Michal"
 <michal.simek@amd.com>
Subject: Re: [U-Boot][PATCH v3 4/4] fpga: xilinx exclusive commands
Thread-Topic: [U-Boot][PATCH v3 4/4] fpga: xilinx exclusive commands
Thread-Index: AQHbaNKa99jaRB9NJE6O/S45hHuqoLMfYRUAgAACKMs=
Date: Mon, 20 Jan 2025 09:06:27 +0000
Message-ID: <MN0PR12MB6004AF623FC6495A13E63B53A0E72@MN0PR12MB6004.namprd12.prod.outlook.com>
References: <20250117112557.3729416-1-ibai.erkiaga-elorza@amd.com>
 <20250117112557.3729416-5-ibai.erkiaga-elorza@amd.com>
 <20250120-surprise-exploring-cb7738514bf9@thorsis.com>
In-Reply-To: <20250120-surprise-exploring-cb7738514bf9@thorsis.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-20T09:06:26.913Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6004:EE_|SN7PR12MB7180:EE_
x-ms-office365-filtering-correlation-id: d32882ed-62dd-4c73-3976-08dd3931b8c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TG9vbWVEUVV0MlhiREJXR1cyRHR6NGgwRDRuYWo4M2hLZ1d2am1YWDU5K09J?=
 =?utf-8?B?ZTE1RHRxT0svVEZ4KzJRNU92RWRXMnlHUzdENDlVY2dIa1BlTDNkdldaRWxt?=
 =?utf-8?B?SExCaVMxektzRElyMFNxRWh5cjhiMWxPY2I4QmRJMnRDZG9IUGptcEM3Sk4r?=
 =?utf-8?B?dVBaNEtjbzM5VmU1QUV5VVJjSW96UVBITW1qdStEKzE3ZGlkWTBEeVZiQUlM?=
 =?utf-8?B?L1BNcEJBWGtKYzdIeE1VR0pacjR4bVhlNHh1MXpWUk5LQkwrNDZCSGhuMFpN?=
 =?utf-8?B?cjQ3MlQwYkQ1cGh6SzhmNHI1azE0RkZZVmFZdXNLY1VwZklwZllyd2lRQVhU?=
 =?utf-8?B?NFFZR3RiL1M3QU80aWh6ZUg0Zjljd0F5SU1sSmNjSE9xYm9EMFJzck9Kc1hs?=
 =?utf-8?B?SnpjK2Fvbm5zWjRtQ0NlYmhub1J1eXVsZVd6TkczV2xFM0pmUXRGZUh5cUF2?=
 =?utf-8?B?QzlYVGtYc1FzWExFeS9DR3ZXSnAyT2VWcHV1Mm5VYmc2VHRFdy81cGQvRTdJ?=
 =?utf-8?B?RzVNdnd5RmgrZ1JjSjN4T29OR1p0eGh5VSs4TjFuVVNXZEs3QXJISUUrazVE?=
 =?utf-8?B?TG9JRnphSWJEcllXajBheGpBRkhKeUh1ZEptZ0w3ZlZreWQxcWJDM1VxN3FV?=
 =?utf-8?B?eU9icGxyVFd5RWM3bkc3RllwekdQMHViajVudytDRFNiMmp3VU5VRERFTjZP?=
 =?utf-8?B?MXJLWVhITFhOVXBFUkdtTi9KcXAxTUcvekhITzBZcHczUzhKakFwRTQydGdE?=
 =?utf-8?B?K2tPNHZ6d29UQ1FHVTFlUjU0SlUrZ0JUQXgySjdMOHNRMkJJT1QyTVkwKzBS?=
 =?utf-8?B?c1V3dGpVeWl6Z1NJYkduOTZOcEZiRmRLOHVhVmlPb0QwbDZGZ2FpVHVIcW4z?=
 =?utf-8?B?aWlpYVozTXBINXRLVUJsZWVQdkN0TWxjVExMZ3dkTHB0b1o4OTNFSlZOa2Ix?=
 =?utf-8?B?eWxLOVZyQXlRRDNyQzYwWnByNlJ1a3hVcmxvVjZvRU1hWU5ESFVWNHF1d3p2?=
 =?utf-8?B?VFRjazREUEZxMTByVkVTWnhCaW1oVVBmcVVxdGVqcmcvdXRNOEZKTFA4SkYv?=
 =?utf-8?B?Unl4QlExUm93ZDh0VHZVMHJZeDJDbml0V0tLWFJGanUvSlhTQzUvcTRYbGIr?=
 =?utf-8?B?N01KcEFpVFZNdU9kdXRHaWVuQlJ3R1N6MlVXRkVzaDJ5UElWTHMyQk5LbW5S?=
 =?utf-8?B?TXNzUWtZaEZuVUtzcU12VzFGYXV1bHRuRWRZcVpCNHVJWHh1cy9RUm9ycU1r?=
 =?utf-8?B?SXF2N29EVHhlb1F5ZmdBazEwNXd6ZVNyYlpvalNpOHJBRzliaHo3ZXVmOG9B?=
 =?utf-8?B?TVdndGl3YUgyMmlMZVVEOVBFWlpwbmJqL1BYMUYzQmM0bzlhN1FzTUpSZ1h2?=
 =?utf-8?B?ejBqa2R0NXlQa3Fua3hpZmZnNFhBd2h1WkFLb2JZeXdHQmxXN1ZKR3ljWnZT?=
 =?utf-8?B?dGFGMTJ0aTZOUmRBRFd4Y1hmcHZYNnFBM3NFUW00MENpM3ZWMlVsNGRCQnpi?=
 =?utf-8?B?ejhlclJVOGZnSTZNSDFyYTNiYUhFeTE1eDRoT3RnaUtuOTFYNWxwdWVjL3dM?=
 =?utf-8?B?a1dKTExKcUYyaDNtTHFORkpYRExua0JDWXZ2bERoTDJFT1pYQVJobVFUb2lB?=
 =?utf-8?B?dDAxWjlnMlBRS0NuQXNPRW5lNFpLK2p0djRmRkdPQ25tQ0hUYU5NVjdQNWt0?=
 =?utf-8?B?U09ybDNyR3BaZTRZNTlVVldTNjVrdVQ2c3hERUpHemluOXRNR0t1bTV2SUZ5?=
 =?utf-8?B?ZkJscjlmU0gvV2tRKytucjRKM1NIS1FvUnVPblY4Q0JPb0NiWThTMW0wRzEz?=
 =?utf-8?B?RW8xYkJJNDd4cXVTb1BDemVzU3BQR0lxa1N3czdjL0grOThOUXZjS2ovdzB5?=
 =?utf-8?B?TlJjOXJoaWlBQ000UGs0ekJ3ZlZ4U29WRHFxVHZyWXZ3eEdpZmNiN01qaGtq?=
 =?utf-8?Q?UCNtOyUYjOCxa2MmesP5maVQ01jZ6Cnn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6004.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2N2Um5ITDZaUm9Tbzh1Tk1yYTlGSmVzelpLdjZMRzJIRTk0Wm8vQ0xHQUZq?=
 =?utf-8?B?WVVpQlFQZmlURER4Rnh6SEVYV2tLanlQZCtBNDg2SytlSmMxa0tVa0hHY0U3?=
 =?utf-8?B?WElzTXpYVEVpdnl4VDBtVHFSZXFOUTVIaEp0elJVS0JjTy8yUWdGNXFrT0s0?=
 =?utf-8?B?LzBRT3JkdTZOWFFWczVUYnVjRlNabitTYjB0VjN3WVdDcEc2bitNSXhjSFQ4?=
 =?utf-8?B?L2ZkYjFDQzFZSEQzRTFWeFcvY0JqbWJybkhXSzlndFhETGN2TGlTNHhPYUU5?=
 =?utf-8?B?SENNOCtlZVl5OFdFMi9iSmhndllaYjZ5WUtPZnVETUJ6bTV3T0p5U1JNWVRR?=
 =?utf-8?B?bkQveHo4NlFwRlhOZDVmck15WE5LUjFMVCs4b0Z1alJqRjNNa2NSMjhBL0p6?=
 =?utf-8?B?c1pScGxpMFZkc3hScGM5RVAvcFVOUFY3RnMrL3F0SCtvOGd5d0lENHdiQ2VL?=
 =?utf-8?B?ZTl0ZXpOMU9yL200ZkNZMEhMWXpaRHVRdVFubThPYXpPOHF4amNYLzc2Zk14?=
 =?utf-8?B?U09PcWdwajVRTW1kaFVwbnNMUE1vbDFUVDEzMm1pcndYd3ZEb0JZcmRuZ3I0?=
 =?utf-8?B?UktuOFR3ME4xNDBpWU0wNVdINjhFRXRiRVpNQ1A5T3p3RUM4VVRZYWdlc05U?=
 =?utf-8?B?SVFQdXluODFicHViY0tBeUljMjlwMmEzR3dUc0ZCeDZHb0JWME9jd1ozV3pO?=
 =?utf-8?B?dW9PVCtqVU9vU2RBNkhYRWwzL3JHbDhhaHh6SlIwcm5QeUdqcXdwMjNLTyts?=
 =?utf-8?B?VXB3bCtYQUU1citXSXJBb2h5Wnh2TlB1T2lSdWhodkw1K1AzMGVHeVRYTDVS?=
 =?utf-8?B?WnJxYk1IN2FoTHRTWDBaNlF6VFZlRnBab0FSalBNSGU5Z2FId3NMMXk0VWEx?=
 =?utf-8?B?R0ExbUJoL25GVFZYR2pMdnNZeTQrUGZHZU56VC9sUWFYZ2FwUlZ4NCsrN0U0?=
 =?utf-8?B?OHRReTBHRklSZnpyRi8xUUxDczFSRmdpQ0JzMHBtK2htYnBqendxbnJvblRQ?=
 =?utf-8?B?S0RFU1NKeE9mN3RBTWx5ZUdxUTNpWXpMOHExUms4RHhBK2FZZzZTbG9HTGsz?=
 =?utf-8?B?MzBnN1pjWXpNOWZNSkxKZmlURHJJaUVOUDdjOFIwK1h5OURCVEE2TXFKTCtx?=
 =?utf-8?B?ajl0VVVVL2g5SStyazFTSFJaVS92MFdMamw0Vkt6M2YxYVBNWlBxcnNMb1da?=
 =?utf-8?B?MEkzenhGb05oNzJZRzNVRUJKSGNsZEUxSzczaTJkV3NlbWZUS2czVUtVeHJ4?=
 =?utf-8?B?UnVjNCtCWHVqUkhxVXhMdjh1TVYyVVhPY1BTS2JDOEFZb2xZTlkrY3B4YTQw?=
 =?utf-8?B?R012ZWt1aHNqVGNmVU5JN2tEN29YaWNUZUZuWi9ZQnh1d1RQekxNdk5Rb0FL?=
 =?utf-8?B?QzNhcVFOb2h2YmtEdFkwd0VwZGlaTHQ4aXU2SWttenNtWk9PcjRkMmJ2ZUNs?=
 =?utf-8?B?elBVdEVoQzVEYWRHeTBSN0hWYUI2VlEvY3YrVEdJUEdXR0dadjdIbnY0RnlB?=
 =?utf-8?B?MkdZS1ZTWmR1SHZDVWU5U1ErRXYyYVU2RXU4UTAycHpuWk5leXV6UzdhZnBD?=
 =?utf-8?B?YUovc0YrcTdsOThGUk8zVzBXYzZMcGFNQWxHM2NTNm5vNHZha0w1QnRKR2hE?=
 =?utf-8?B?OWJuTStZQVkvcURLckt4K0dhaHhFNW9ReWowbE5salgybFgwMXRNcjZ6UTJV?=
 =?utf-8?B?aXlIbTNhRGdJMUhxenBnZmZaSzFSeW5vY1d2UVA2MmxhV0p0L3pQTFFPT211?=
 =?utf-8?B?a1c3c2RsNkhaaE4zMWV1aWxMdW41RlNUOW9XR2h6Ymt3K1dranRJMEJ6UGYz?=
 =?utf-8?B?cWVSM3ZxTnM1bTNkOFZGV2IxNG1FZ3pEMktmWkJOUzBTdW13S0hEUEIvTmRN?=
 =?utf-8?B?SDhkZ2xTM2dWMkNRb0JMdS84dmZkc216ampYMlhlWXp1Z0lLQyt1OERVdzhE?=
 =?utf-8?B?d0pSK1BXTXNDOFc1MTJ1azROQThDWkw0MkhQUURFeElxbExUTkJkejFRaHJN?=
 =?utf-8?B?S1ZlOFo5UExEQ0ptVVVmY01IUEJMNk93WW5uMVExbVNNN0x2QTVTVlFEc2lO?=
 =?utf-8?B?ellsYk96Mkp1TGxLa2ZUb1NSOWlFZWVIOC80ZktPL2J1bW9kcVJ3KzdiakVB?=
 =?utf-8?Q?lVL4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6004.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32882ed-62dd-4c73-3976-08dd3931b8c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 09:06:27.2092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hWzCBygdbPt0thHxzjalropIkA/enjcQcTjhnkDgs5tzNI5DwMKzPT+iV+KN3muL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180
X-Mailman-Approved-At: Mon, 20 Jan 2025 10:55:32 +0100
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgQWxleGFuZGVyLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcsIG5vdCBzdXJlIGhvdyBJ
IG1pc3NlZCB0aGlzIG9uZSDwn5mBLiBUaGUgRlBHQV9YSUxJTlggaXMgZGVwZW5kZW5jeSBub3Qg
YSBzZWxlY3QgaW4gdGhpcyBjYXNlLCBJIHRoaW5rIEkgYWNjaWRlbnRhbGx5IHdyb3RlIGluIHRo
ZSB3cm9uZyBsaW5lIHdoZW4gZG9pbmcgc29tZSByZXdyaXRlIG9mIG15IHBhdGNoLiBXaWxsIGZp
eCBpbiB0aGUgbmV4dCB2ZXJzaW9uIG9uY2UgTWljaGFsIGZpbmlzaGVzIGhpcyByZXZpZXcuDQoN
ClJlZ2FyZHMNCkliYWkNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkZyb206
IEFsZXhhbmRlciBEYWhsIDxhZGFAdGhvcnNpcy5jb20+DQpTZW50OiAyMCBKYW51YXJ5IDIwMjUg
MDg6NTcNClRvOiBFcmtpYWdhIEVsb3J6YSwgSWJhaSA8aWJhaS5lcmtpYWdhLWVsb3J6YUBhbWQu
Y29tPg0KQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlIDx1LWJvb3RAbGlzdHMuZGVueC5kZT47IFNp
bWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtVLUJvb3Rd
W1BBVENIIHYzIDQvNF0gZnBnYTogeGlsaW54IGV4Y2x1c2l2ZSBjb21tYW5kcw0KDQpDYXV0aW9u
OiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHBy
b3BlciBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9y
IHJlc3BvbmRpbmcuDQoNCg0KSGVsbG8sDQoNCkFtIEZyaSwgSmFuIDE3LCAyMDI1IGF0IDExOjI1
OjUxQU0gKzAwMDAgc2NocmllYiBJYmFpIEVya2lhZ2E6DQo+IEBAIC0xMTkyLDcgKzExOTgsNyBA
QCBjb25maWcgQ01EX0ZQR0FfTE9BRE1LDQo+ICBjb25maWcgQ01EX0ZQR0FfTE9BRF9TRUNVUkUN
Cj4gICAgICAgYm9vbCAiZnBnYSBsb2FkcyAtIGxvYWRzIHNlY3VyZSBiaXRzdHJlYW1zIg0KPiAg
ICAgICBkZXBlbmRzIG9uIENNRF9GUEdBDQo+IC0gICAgIHNlbGVjdCBGUEdBX0xPQURfU0VDVVJF
DQo+ICsgICAgIHNlbGVjdCBGUEdBX0xPQURfU0VDVVJFICYmIEZQR0FfWElMSU5YDQo+ICAgICAg
IGhlbHANCj4gICAgICAgICBFbmFibGVzIHRoZSBmcGdhIGxvYWRzIGNvbW1hbmQgd2hpY2ggaXMg
dXNlZCB0byBsb2FkIHNlY3VyZQ0KPiAgICAgICAgIChhdXRoZW50aWNhdGVkIG9yIGVuY3J5cHRl
ZCBvciBib3RoKSBiaXRzdHJlYW1zIG9uIHRvIEZQR0EuDQoNClRoaXMgZG9lcyBub3Qgd29yaywg
eW91IG5lZWQgdG8gaGF2ZSBvbmUgbGluZSBwZXIgc2VsZWN0ZWQga2NvbmZpZw0Kc3ltYm9sLiAg
WW91ciBjaGFuZ2UgbGVhZHMgdG8gdGhpczoNCg0KICAgIGNtZC9LY29uZmlnOjExODQ6IHN5bnRh
eCBlcnJvcg0KICAgIGNtZC9LY29uZmlnOjExODM6IGludmFsaWQgb3B0aW9uDQoNCllvdSBzaG91
bGQgaGF2ZSBub3RpY2VkIHRoaXMgd2hlbiB0ZXN0aW5nLiA7LSkNCg0KR3JlZXRzDQpBbGV4DQoN
Cg==
