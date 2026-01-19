Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D52DCCF2EF
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 12:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEEB783015;
	Mon, 19 Jan 2026 13:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zdqs6tMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BFC38313B; Mon, 19 Jan 2026 13:33:44 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9234D80B98
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 13:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIrCdYU925Lzz6E8iY/bi/hVpSBlu3hzNVJhG6RMZVacFCXEXOKQF66WObPKQ7b602CxKr3TNXju1IlMp6nx1tQ3K6/7MHwfdzK3tthk3ibj+Ug71SqxMHmEayYcPZy8kjMUNjau73UBKZCPbfhV/M2ZsPGboDYe7foKEh1ARMVi7eZF2i6LzlWcQ5DWsneUK9ZWjGUFS6AAzBSxd+lK25jblPkEMq2R7WpPqGW6tLkDtSrOI2mhkF4JrpB3WTRSBzc7S/0H3o25EpuFj3txh2IUAfzRBSpSS2+/ouuhkMnNrwByMOTWoNksWZ6qd2sVLtwxu78S6jv7DglQjq/cXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CI6mjFPQBr5Aw/ekYdG8kRi844JnP/1OuEn59rxvqZQ=;
 b=uxPa3HL+tZNmZ/pNjCMlKh8zrfTF1+4+fegi9qubHOOGI62goyTnJZmdQlX8tztTtsKxfAo1dTPUR5CMrrCHsXib7rrvR6KOIdy8A1wZVpQ7QWz8ttu4rtmgImM/cLp9if9D+4HSZk49wNV0c4WIxCXLN/twvT/OAc4ggHCI3vK0nsuPpe8RO2WkenhhvSh62zHkA4b3sdiHjOQ1boMfNiKJU5/nAiCYTlKtsZavNBlp+pTE7QkkMUT6TJDOm0gqXrUNuUhp3whQmH5wWOoenXtU9KCSkTQGKmmjA9h1BP1wM1ursjQ99OJdnzHo0b3JGzCeljvsstKE5zST9GlD9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CI6mjFPQBr5Aw/ekYdG8kRi844JnP/1OuEn59rxvqZQ=;
 b=zdqs6tMo4hP5VyH/415UCPaipXnrKX2u5fDiijMilItR9L0jqPTRnp2w8VIj5w5ui6zuGx5WxEyPS1485jb5MKPwX6IpcCp+0ydF3tCKWgFqBtyF9ncMavm9c6RW4drYq0JSt2mQJX5J0+gwfuvWDnk5i+WuInc6HkE4VPQLs3g=
Received: from PH7PR12MB6696.namprd12.prod.outlook.com (2603:10b6:510:1b3::10)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 12:33:36 +0000
Received: from PH7PR12MB6696.namprd12.prod.outlook.com
 ([fe80::3f0:b0e5:e6a0:9016]) by PH7PR12MB6696.namprd12.prod.outlook.com
 ([fe80::3f0:b0e5:e6a0:9016%6]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 12:33:36 +0000
From: "Vinay Tilak, Pranav" <Pranav.VinayTilak@amd.com>
To: Tomas Melin <tomas.melin@vaisala.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "git (AMD-Xilinx)" <git@amd.com>, "Simek, Michal" <michal.simek@amd.com>, 
 "Begari, Padmarao" <Padmarao.Begari@amd.com>
Subject: RE: [PATCH v2] rtc: zynqmp: Add clock framework support with
 calibration fallback
Thread-Topic: [PATCH v2] rtc: zynqmp: Add clock framework support with
 calibration fallback
Thread-Index: AQHchUiOoRCz406/ZUSC/GtmPNpdAbVUSzeAgAUj+MA=
Date: Mon, 19 Jan 2026 12:33:36 +0000
Message-ID: <PH7PR12MB669654415930FEFCF4D74D0AFB88A@PH7PR12MB6696.namprd12.prod.outlook.com>
References: <20260114112505.2851622-1-pranav.vinaytilak@amd.com>
 <058a381f-4fc5-49b6-a999-67d67a54d571@vaisala.com>
In-Reply-To: <058a381f-4fc5-49b6-a999-67d67a54d571@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: tomas.melin@vaisala.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-19T12:20:05.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6696:EE_|DS0PR12MB7510:EE_
x-ms-office365-filtering-correlation-id: 6fd4a6a8-8082-4a97-0459-08de5756f7a0
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WFQ5RHVaUFcrL1l3T3hHQXV6cVNhZzRrTnVQUEc4TXM0dklTZnVzR3NFV0cy?=
 =?utf-8?B?TG4xaVJQRXQ5L1FaMGc1RFAwbnB5T1JpNDdiVmJVSGdhWVdTa044Rzc4cjlv?=
 =?utf-8?B?TWl5WldsQ1Q4OGZMcUIrQjM0RzdiUmszY1hXY2QzTDYydjZ3dWg2aWttOHdB?=
 =?utf-8?B?bmNjRUhQSmU0djl3TWFRUFl1d1ZtS0ZGcEg1YVJKY3FJcWxXbHZCTlluWlhh?=
 =?utf-8?B?cXUvZGVicXRna2J0eDRQNG05a0RvcTEwOVA4S0VIVnUwY1lqblNSUlRDTU5C?=
 =?utf-8?B?ZzBCdzUzQ3J6dU9FbGJFTytqbzFaSlFQMmp2TDdxOWFQYjBOV2tLNmltaG94?=
 =?utf-8?B?clpwdzc0M25INHdlbW9NTTJPSG5RVVVJZHB2c1kwRGNpRVEweVlFOGRONjNo?=
 =?utf-8?B?VjF1ZzVodEZGUk15ZXhHZ1F2MGpGdktGZW9kYm80aU9MbWNpaWE3NDB4Ujho?=
 =?utf-8?B?ZHkvSXNwZ2VycFUvQ1cydDJ0K2lSSVlBdE9BUEgvQzB1eHFMV1ErNnhYZUgw?=
 =?utf-8?B?L2lqVHEwTXM5OGpwVmdJYnBsMXBEWnBVWGZCZzJFdHcrVGZmbi9oY0VPUUtH?=
 =?utf-8?B?cjJva1pEaTZZM0dBQXVVd0QzU3gyejdPRGdwZitlZk5iUyt4cjFNK2JiQ1pu?=
 =?utf-8?B?S3Q1QUZYOUxwMUcrZTIyM2hUVGhXYXBCNXJzTUNoci82a0Z0a3JITWdmMXpk?=
 =?utf-8?B?REp2ZksvYUw0U3YxUG5XZGZyUW1iTGJZcFdVNGJZQUNrZTRMUVhYS0dtYkJV?=
 =?utf-8?B?UzAwV0lhcEx2QnI4T3VhVlBlcXlDYWl4Q3VCWGtxbzRDVkdUMk52V1diQTBn?=
 =?utf-8?B?ckIzYWZmWk1Oa1F6VFMwM1N6aEF2TC8wMFZUckR3N2dZTkVYekxCOTk1NXpy?=
 =?utf-8?B?cEZLemowdC8vYWhSV2cwWkNud1dsRFkwL0FIK2JSQWdQTkdGWThSMmtzK2g3?=
 =?utf-8?B?V3FzWlZweHBYRHRWcHl6Q1dYeWlGSWNubitlOXVJRngwL2lXZ0ZJV2lNSkNh?=
 =?utf-8?B?eWhaSnhXT2RDamFHNXQvbWt5bktHK1JNVXlaRjMwVElMN29yN25rVHpCTmhu?=
 =?utf-8?B?bFlZcWxwNXkxRElrS1VteEREY2ZvRHVoSTVydFR0VVZrWWhWRXNBd1liK3I4?=
 =?utf-8?B?VTEwYUlpNjRTeGg0TzVsbk5YdWZMWm92RWlQdnF1ZWxvMHZVeWVQTzExeTVF?=
 =?utf-8?B?SlBISHg2VmxsSVFrWld2aDd6V3QzWmJmeURhQkZuMTUrQUk4YWQ5T2V6QzUz?=
 =?utf-8?B?Rkd2emg4R1BDOStTMnFHZEtIbmtFeGt5d1VpUVVDS0VEc3cxSUtLN2xKNjVJ?=
 =?utf-8?B?SWhEc3N1REJ0TGF4TlFRN2V4N3hicHBYWGJ0UWZEVW9KR0JwVXRFcTQ2b3VS?=
 =?utf-8?B?MHlOQytxNXB1NUx3eit4dUQyNUp2TnNleWpMVWdpbXRyT0pQNEN0bFRQaW5H?=
 =?utf-8?B?czRtQnlGMUZFUEZyVWNIOVVabmJldUNvSUZzZ3U4bHM5SzVPb2oyTzFLTG8y?=
 =?utf-8?B?Ym5mNFdha0xtZmljOUR2WUovSmVJN0FBaUlTbndobHZvaDlLNENlOWNzYkN2?=
 =?utf-8?B?d1MvMXRBNUtHZ2djVEZkRFY4OE9mQ1RHWm4rUEdJb0RnKzJvS0ZQNHgxNTJE?=
 =?utf-8?B?MXpqUHlaOEZZV3Z2NlB5RitjWEtjMGpiYkY2WWNNbzF2UXNBaWJyQm1mRjBM?=
 =?utf-8?B?MnZ3SXJjRlNMMTBlVWpGL0pzWW9vR0R6VmNMMmNFUTRlb0w0Tmk5ZE0yRmlu?=
 =?utf-8?B?SUM2R09KRzVsRDE5WitRWkVtT01QRWNRL3N1cFArSDlCNWJBREN2ZWkwUFkw?=
 =?utf-8?B?RHFTWVdISFVTcTRMT2puRWVja1FGSklBYjNZZ3ZXamNYbVNOQTRqWmRqVWdr?=
 =?utf-8?B?M01hM3BnWWtwaUFhVjlraGRVVU5PbTBpeXRncm5KWmUwcjRuUlZ1U0tHUzJ2?=
 =?utf-8?B?NVcyczNGUVN5OGVTeWR4Y3RwMlhlSGdGT2NQL2YxZTRYbmFhNU1xYU1lQk9s?=
 =?utf-8?B?Yklhbk5vc0Y1ZGZORXlScDh4YVlLbXJrdW40SGJpcmVCQzRtWThVUEJOcU5i?=
 =?utf-8?B?L1FHeEZ5UFhtbStUMU4zalFrdVg3dEhzSTJwNVFManIyQXNreitGb1NxM1VM?=
 =?utf-8?B?dlFaU2M2YStwcUpIOE42Q285bWluMzlDaWJQdDNLVkpsU2Yvd2dhQVUxdmNE?=
 =?utf-8?Q?WWt3qb9QGvoUYL78mHW0pbc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6696.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TERSVWdnTGlzK3RiZHBWZFVVaUZ2eTcvUnkyTHZTOXIxU01ISFRGelJXUG9P?=
 =?utf-8?B?OGJYUXB3R1VXZFVnNVJ5SjlXZmpvL2g2dGZMeXhGN3hKT2Z5TUMyQmZmZ2wy?=
 =?utf-8?B?VXZaSVVWemdmQXFhMHFVUkpPWnFtWFI0UmQ5bVhNb3E2ZnU3VWZzNEx5d0ZZ?=
 =?utf-8?B?STJKbGkvNndIRHRUQ0wxc1RiMnBoTVRuN0dIT3J0cExnTGVYNUdMQW0vOThi?=
 =?utf-8?B?NW96d09LNHdVTE1QSE1UTkUxQUFnMHVHeWNDMlRrSnNjR2M3YTV1ZmxwVjc5?=
 =?utf-8?B?eHlwc3BPWTIxaWVOVlBjU1NEWDdobm9MTlo4cVU0V2czNTR1QVlybmNKOEVY?=
 =?utf-8?B?NE9pV0xyREhDMHpxMVo0MkJnL2JKd2ppWXk0SjVzUnJxZzkyVmhkWWp2YXhL?=
 =?utf-8?B?S1VDZVBXT1JrbXJodmkxakZMSUNOUkZVSW5JR1Ava1J2SXlpZlo1MlhkOGpH?=
 =?utf-8?B?MnZjNUhxSXdYeDFWNU5XWWF2NWZKZGRzTXp6R0x4NzRsYWdVZUkyNTNWOGo0?=
 =?utf-8?B?Y3FwTHJEaEF1TmcyN0poOXBvRGZrMktzN0VhcVFqZmgwb010Njh6VFdSUFpN?=
 =?utf-8?B?a21jOXhxMWY2dWgxOG10b2dQb2V5VVVNRXZLQVBkK0Y1Yk9nTkcxTXE5MzVR?=
 =?utf-8?B?Q3lhMW9GVmhQeVRFckFueHRIY1ZWQ1gxV0NXNHhnaHo2WjJpSkpYWHJ2Z0Fv?=
 =?utf-8?B?WnRwNE02NCtaa0JxcEVkSW54dWNHYTV4a280dHRWTjJoU2g2TVhLSVZVeTcy?=
 =?utf-8?B?OHN1N1pMTlhmYzZmWE4yTS9YV0I0aUJjRmdjdjZGOU5GMzBVQmQrZXRkMTFV?=
 =?utf-8?B?NEQxWkpCSjhLaHAyTEdNcWVJMzRzVjM0cEJpNjJIQ3ppYkRNRnMrYk91SkZj?=
 =?utf-8?B?elFkMUFIT0lOR28xaFc0WlpMMlRRSGZmUjBkcmlrQ0hXNzMxVHZCdlFLeWl4?=
 =?utf-8?B?YVVrYjVLc1VBTUhlNVRjdnY0aGE5WW9xS2o3VXJKUFhNNVI2Q1FKcXBOamFR?=
 =?utf-8?B?SVhWYmhlbnF4dmdhSlpnWUp0Ulh6cWY0cUtBd2prTE1PMk8rODRsYUUwN3JQ?=
 =?utf-8?B?T2hneUlPU2NrdDEvZVRsNk1vY1F0a1FmaUViSUxLOHN4ZmEvNDdrSDdQMXVv?=
 =?utf-8?B?Y1BYU0hHcWk4Y1RRTThjUEx5N2RWWGhnNmlGcXBvSENRdncwU0c1THNoazds?=
 =?utf-8?B?Z1lEdDlHZ3YzSG5RZ3VoQ1RyNW5WWC85K2hlbEpKWndOaE16OG95UHNjZ2lV?=
 =?utf-8?B?NEIzank1NDJxTlcxZVZFTWlTNFByeisyQkMzTHB1ZGk3L1FBNDZwZVM1eTF4?=
 =?utf-8?B?bUhoWDduTEhuWTBHeVVXelNOUEJ3anJuYzhybzBHSW9vQ0t1eGVaSllOMEdt?=
 =?utf-8?B?TERGNWtVN2dZQVE1T2NDUWZrdzA0OVB3ZGFoVTdLK1lVcFhRZlpldUZrbEZ1?=
 =?utf-8?B?SXduNkpVYzdUcFlIQVJYZi9Ya3ZMYWk0b29tTGpsYi9mWU1RcWN1blNobGYr?=
 =?utf-8?B?TTd0TGR3YjVFRmFJdXhjdDBjV2lpcU1ObGN4cFd5d2hpaC9LdXNuS3dLRjdE?=
 =?utf-8?B?V2UwS3FYL05uRDdMTy9KMjFTUDBBeS9DK2EyRU5Ba29GbEtMNjk2em1JMFlU?=
 =?utf-8?B?akJ4MUtlV3VUd1lkOWZiZHZPaGVvWkNDR3BIaEg5NTRLSlNmd3hsOUh5SWFa?=
 =?utf-8?B?M3ZPMDc2TGtSaXJpYUhldmdBOWEzZTRwVXZWM3lySmVObVRNdGJBOFVYdzdR?=
 =?utf-8?B?MkdLemNDb0pzSjhBZEZoaWJRTnErZ09qeFZIaTl1dmpRWVJ3b2RWcnp5Sk5X?=
 =?utf-8?B?MkIzVlpkM002K1EzTEprRGtKelhNclZpM2V0aDVVZnpLS29IYnNhcHJ0U21V?=
 =?utf-8?B?VW1YVWJtd1Rnd21KZy9xMCt2am4xZ2Vscms5THQyKzVHcXFocE9yMnNVQlBD?=
 =?utf-8?B?UEpLT2xlTlEzK0hXS1AzTDZIbW9lY2E3TWJpelZtSXY0NVc2Ui9mZlFPU2lJ?=
 =?utf-8?B?eFdUK0hzTkRKSDlobWFkWUQzb2p3NVByWkJJREZwQXBDdjhSSk05aTNzdWFL?=
 =?utf-8?B?VlNGYXJ5SnZXQXdMOEszZFp6Rm1YaFNCVmlFaFlQUG43aWFBbXdlY1d3dFRz?=
 =?utf-8?B?MGJtbHl1c1BEUHhZaEI4aFFieUdrdWpPbWY2OUxKT2xTU2Niem1xRTh6U3Fh?=
 =?utf-8?B?WVU1ZGdqWG1ZSTd5Z2wwU3ZKNFoyK3pGYktqclp0dVBDcHo2R0ZLK3JHTngx?=
 =?utf-8?B?a0hseUlVMXV3clJPUVN0ZWt2T2RlY2JXYTd2eDhOYTY0d0lPU1RWeE12VkdY?=
 =?utf-8?Q?O5bp+zKeh50VhRvZfJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6696.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd4a6a8-8082-4a97-0459-08de5756f7a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 12:33:36.6153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h1hfugbCI1AOYPzamkJXyUfDwuz6a1HKH3ETx8NioxXHDbPrl/EQDyDqarYoTp/enPiLvlcFbk8PVjifG3ZhPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510
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

W1B1YmxpY10NCg0KSGkgQFRvbWFzIE1lbGluLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IFRvbWFzIE1lbGluIDx0b21hcy5tZWxpbkB2YWlzYWxhLmNvbT4NCj4gU2Vu
dDogRnJpZGF5LCBKYW51YXJ5IDE2LCAyMDI2IDExOjEyIEFNDQo+IFRvOiB1LWJvb3RAbGlzdHMu
ZGVueC5kZTsgVmluYXkgVGlsYWssIFByYW5hdiA8UHJhbmF2LlZpbmF5VGlsYWtAYW1kLmNvbT4N
Cj4gQ2M6IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPjsgU2ltZWssIE1pY2hhbA0KPiA8
bWljaGFsLnNpbWVrQGFtZC5jb20+OyBCZWdhcmksIFBhZG1hcmFvDQo+IDxQYWRtYXJhby5CZWdh
cmlAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gcnRjOiB6eW5xbXA6IEFkZCBj
bG9jayBmcmFtZXdvcmsgc3VwcG9ydCB3aXRoDQo+IGNhbGlicmF0aW9uIGZhbGxiYWNrDQo+DQo+
IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNl
LiBVc2UgcHJvcGVyDQo+IGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2lu
ZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gSGksDQo+DQo+DQo+IE9uIDE0LzAxLzIw
MjYgMTM6MjUsIFByYW5hdiBUaWxhayB3cm90ZToNCj4gPiBbU29tZSBwZW9wbGUgd2hvIHJlY2Vp
dmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbQ0KPiA+IHByYW5hdi52
aW5heXRpbGFrQGFtZC5jb20uIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdA0KPiA+IGh0
dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+ID4NCj4gPiBB
ZGQgc3VwcG9ydCBmb3IgcmVhZGluZyBSVEMgY2xvY2sgZnJvbSBkZXZpY2UgdHJlZSB1c2luZyBj
bG9jaw0KPiA+IGZyYW1ld29yayBhbHNvIHVwZGF0ZSB0aGUgZGVmYXVsdCBjYWxpYnJhdGlvbiB2
YWx1ZSB0byAweDdGRkYgYXMgcGVyDQo+ID4gUlRDIHNwZWNpZmljYXRpb25zLg0KPiA+IEZhbGxz
IGJhY2sgdG8gJ2NhbGlicmF0aW9uJyBwcm9wZXJ0eSBpZiBjbG9jayB1bmF2YWlsYWJsZSwgYW5k
IHVzZXMNCj4gPiBkZWZhdWx0IGNhbGlicmF0aW9uIGlmIG5laXRoZXIgaXMgcHJlc2VudC4gT25s
eSB3cml0ZXMgY2FsaWJyYXRpb24NCj4gPiB3aGVuIGhhcmR3YXJlIHJlZ2lzdGVyIHJlYWRzIHpl
cm8uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmFuYXYgVGlsYWsgPHByYW5hdi52aW5heXRp
bGFrQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiAtIFJlbmFtZSB2
YXJpYWJsZSBmcm9tIGNsa19mcmVxIHRvIGNhbGlidmFsDQo+ID4gLSBIYW5kbGUgY2FzZSB3aGVy
ZSBjbG9jayBub2RlIGV4aXN0cyBidXQgaGFzIG5vIGNsb2NrLWZyZXF1ZW5jeQ0KPiA+ICAgcHJv
cGVydHkNCj4gPiAtIFRyZWF0IGludmFsaWQgY2xvY2sgZnJlcXVlbmN5IGFzIGVycm9yIGluc3Rl
YWQgb2Ygd2FybmluZw0KPiA+IC0gTW92ZSBjYWxpYnJhdGlvbiB2YWxpZGF0aW9uIG91dHNpZGUg
aWYtZWxzZSB0byBhcHBseSB0byBhbGwgY29kZQ0KPiA+IHBhdGhzDQo+ID4NCj4gPiAgZHJpdmVy
cy9ydGMvenlucW1wX3J0Yy5jIHwgNjQNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAyMCBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3J0Yy96eW5xbXBfcnRj
LmMgYi9kcml2ZXJzL3J0Yy96eW5xbXBfcnRjLmMgaW5kZXgNCj4gPiAxNTEyMmEwNDgzOC4uOTM4
ZGE0YzA1NjkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ydGMvenlucW1wX3J0Yy5jDQo+ID4g
KysrIGIvZHJpdmVycy9ydGMvenlucW1wX3J0Yy5jDQo+ID4gQEAgLTgsMjMgKzgsMjcgQEANCj4g
PiAgI2luY2x1ZGUgPGRtLmg+DQo+ID4gICNpbmNsdWRlIDxydGMuaD4NCj4gPiAgI2luY2x1ZGUg
PGFzbS9pby5oPg0KPiA+ICsjaW5jbHVkZSA8Y2xrLmg+DQo+ID4gKyNpbmNsdWRlIDxkbS9kZXZp
Y2VfY29tcGF0Lmg+DQo+IFBsZWFzZSBrZWVwIGluY2x1ZGUgc3RhdGVtZW50cyBhbHBhbnVtZXJp
Y2FsbHkgc29ydGVkLg0KDQpPa2F5IHdpbGwgdXBkYXRlIGluIHYzLg0KDQo+DQo+ID4NCj4gPiAg
LyogUlRDIFJlZ2lzdGVycyAqLw0KPiA+ICAjZGVmaW5lIFJUQ19TRVRfVE1fV1IgICAgICAgICAg
MHgwMA0KPiA+ICAjZGVmaW5lIFJUQ19TRVRfVE1fUkQgICAgICAgICAgMHgwNA0KPiA+ICAjZGVm
aW5lIFJUQ19DQUxJQl9XUiAgICAgICAgICAgMHgwOA0KPiA+ICsjZGVmaW5lIFJUQ19DQUxJQl9S
RCAgICAgICAgICAgMHgwQw0KPiA+ICAjZGVmaW5lIFJUQ19DVVJfVE0gICAgICAgICAgICAgMHgx
MA0KPiA+ICAjZGVmaW5lIFJUQ19JTlRfU1RTICAgICAgICAgICAgMHgyMA0KPiA+ICAjZGVmaW5l
IFJUQ19DVFJMICAgICAgICAgICAgICAgMHg0MA0KPiA+DQo+ID4gICNkZWZpbmUgUlRDX0lOVF9T
RUMgICAgICAgICAgICBCSVQoMCkNCj4gPiAgI2RlZmluZSBSVENfQkFUVF9FTiAgICAgICAgICAg
IEJJVCgzMSkNCj4gPiAtI2RlZmluZSBSVENfQ0FMSUJfREVGICAgICAgICAgIDB4MTk4MjMzDQo+
ID4gKyNkZWZpbmUgUlRDX0NBTElCX0RFRiAgICAgICAgICAweDdGRkYNCj4gPiArI2RlZmluZSBS
VENfRlJFUV9NQVggICAgICAgICAgIDB4MTAwMDANCj4gPiAgI2RlZmluZSBSVENfQ0FMSUJfTUFT
SyAgICAgICAgIDB4MUZGRkZGDQo+ID4NCj4gPiAgc3RydWN0IHp5bnFtcF9ydGNfcHJpdiB7DQo+
ID4gICAgICAgICBmZHRfYWRkcl90ICAgICAgYmFzZTsNCj4gPiAtICAgICAgIHVuc2lnbmVkIGlu
dCAgICBjYWxpYnZhbDsNCj4gPiArICAgICAgIHVuc2lnbmVkIGxvbmcgICBjYWxpYnZhbDsNCj4g
PiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgaW50IHp5bnFtcF9ydGNfZ2V0KHN0cnVjdCB1ZGV2aWNl
ICpkZXYsIHN0cnVjdCBydGNfdGltZSAqdG0pDQo+ID4gQEAgLTcwLDEzICs3NCw2IEBAIHN0YXRp
YyBpbnQgenlucW1wX3J0Y19zZXQoc3RydWN0IHVkZXZpY2UgKmRldiwgY29uc3QNCj4gc3RydWN0
IHJ0Y190aW1lICp0bSkNCj4gPiAgICAgICAgICAgICAgICAgICovDQo+ID4gICAgICAgICAgICAg
ICAgIG5ld190aW1lID0gcnRjX21rdGltZSh0bSkgKyAxOw0KPiA+DQo+ID4gLSAgICAgICAvKg0K
PiA+IC0gICAgICAgICogV3JpdGluZyBpbnRvIGNhbGlicmF0aW9uIHJlZ2lzdGVyIHdpbGwgY2xl
YXIgdGhlIFRpY2sgQ291bnRlciBhbmQNCj4gPiAtICAgICAgICAqIGZvcmNlIHRoZSBuZXh0IHNl
Y29uZCB0byBiZSBzaWduYWxlZCBleGFjdGx5IGluIDEgc2Vjb25kIHBlcmlvZA0KPiA+IC0gICAg
ICAgICovDQo+ID4gLSAgICAgICBwcml2LT5jYWxpYnZhbCAmPSBSVENfQ0FMSUJfTUFTSzsNCj4g
PiAtICAgICAgIHdyaXRlbChwcml2LT5jYWxpYnZhbCwgKHByaXYtPmJhc2UgKyBSVENfQ0FMSUJf
V1IpKTsNCj4gPiAtDQo+IElzIHRoaXMgY2hhbmdlIGRpcmVjdGx5IHJlbGF0ZWQgdG8gYWRkaW5n
IGNsb2NrIGZyYW1ld29yayBzdXBwb3J0IG9yIHNob3VsZCBpdA0KPiBiZSBzcGxpdCB0byBzZXBh
cmF0ZSBwYXRjaD8gQXRsZWFzdCBuZWVkcyBtZW50aW9uIGluIGNvbW1pdCBtZXNzYWdlIHdoeSB0
aGlzDQo+IGNoYW5nZSBpcyBkb25lLCBsb29raW5nIGF0IHRoZSBjb21tZW50IGl0IGxvb2tzIGxp
a2UgaXQgaGFzIGhhbmRsZWQgc3BlY2lhbA0KPiBjYXNlLg0KDQpUaGlzIGNoYW5nZSBpcyBkaXJl
Y3RseSByZWxhdGVkIHRvIHRoZSBjbG9jayBmcmFtZXdvcmsgc3VwcG9ydC4gVGhlIG9sZCBjb2Rl
IHdyb3RlIGNhbGlicmF0aW9uIG9uIGV2ZXJ5IHRpbWUgc2V0LCBidXQgc2luY2UgY2FsaWJyYXRp
b24gaXMgbm93IGR5bmFtaWNhbGx5IHNvdXJjZWQgZnJvbSBjbG9jayBmcmFtZXdvcmsgb3IgRFQg
ZHVyaW5nIHByb2JlLCBpdCBvbmx5IG5lZWRzIHRvIGJlIHdyaXR0ZW4gb25jZSBhdCBpbml0aWFs
aXphdGlvbi4NCkknbGwgdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZSBpbiB2MyB0byBtZW50aW9u
IHRoaXMgY2hhbmdlLg0KDQo+DQo+IFRoYW5rcywNCj4gVG9tYXMNCj4NCj4gPiAgICAgICAgIHdy
aXRlbChuZXdfdGltZSwgcHJpdi0+YmFzZSArIFJUQ19TRVRfVE1fV1IpOw0KPiA+DQo+ID4gICAg
ICAgICAvKg0KPiA+IEBAIC0xMDcsMTUgKzEwNCw2IEBAIHN0YXRpYyBpbnQgenlucW1wX3J0Y19p
bml0KHN0cnVjdCB1ZGV2aWNlICpkZXYpDQo+ID4gICAgICAgICBydGNfY3RybCB8PSBSVENfQkFU
VF9FTjsNCj4gPiAgICAgICAgIHdyaXRlbChydGNfY3RybCwgcHJpdi0+YmFzZSArIFJUQ19DVFJM
KTsNCj4gPg0KPiA+IC0gICAgICAgLyoNCj4gPiAtICAgICAgICAqIEJhc2VkIG9uIGNyeXN0YWwg
ZnJlcSBvZiAzMy4zMzAgS0h6DQo+ID4gLSAgICAgICAgKiBzZXQgdGhlIHNlY29uZHMgY291bnRl
ciBhbmQgZW5hYmxlLCBzZXQgZnJhY3Rpb25zIGNvdW50ZXINCj4gPiAtICAgICAgICAqIHRvIGRl
ZmF1bHQgdmFsdWUgc3VnZ2VzdGVkIGFzIHBlciBkZXNpZ24gc3BlYw0KPiA+IC0gICAgICAgICog
dG8gY29ycmVjdCBSVEMgZGVsYXkgaW4gZnJlcXVlbmN5IG92ZXIgcGVyaW9kIG9mIHRpbWUuDQo+
ID4gLSAgICAgICAgKi8NCj4gPiAtICAgICAgIHByaXYtPmNhbGlidmFsICY9IFJUQ19DQUxJQl9N
QVNLOw0KPiA+IC0gICAgICAgd3JpdGVsKHByaXYtPmNhbGlidmFsLCAocHJpdi0+YmFzZSArIFJU
Q19DQUxJQl9XUikpOw0KPiA+IC0NCj4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4N
Cj4gPiBAQCAtMTI4LDggKzExNiw0NCBAQCBzdGF0aWMgaW50IHp5bnFtcF9ydGNfcHJvYmUoc3Ry
dWN0IHVkZXZpY2UgKmRldikNCj4gPiAgICAgICAgIGlmIChwcml2LT5iYXNlID09IEZEVF9BRERS
X1RfTk9ORSkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4NCj4gPiAt
ICAgICAgIHByaXYtPmNhbGlidmFsID0gZGV2X3JlYWRfdTMyX2RlZmF1bHQoZGV2LCAiY2FsaWJy
YXRpb24iLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBSVENfQ0FMSUJfREVGKTsNCj4gPiArICAgICAgIHJldCA9IHJlYWRsKHByaXYtPmJhc2UgKyBS
VENfQ0FMSUJfUkQpOw0KPiA+ICsgICAgICAgaWYgKCFyZXQpIHsNCj4gPiArICAgICAgICAgICAg
ICAgc3RydWN0IGNsayBydGNfY2xrOw0KPiA+ICsgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25n
IGNsa19yYXRlOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgLyogR2V0IHRoZSBSVEMgY2xv
Y2sgcmF0ZSAqLw0KPiA+ICsgICAgICAgICAgICAgICByZXQgPSBjbGtfZ2V0X2J5X25hbWVfb3B0
aW9uYWwoZGV2LCAicnRjIiwgJnJ0Y19jbGspOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAoIXJl
dCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNsa19yYXRlID0gY2xrX2dldF9yYXRl
KCZydGNfY2xrKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAvKiBVc2UgY2xvY2sgZnJl
cXVlbmN5IGlmIHZhbGlkLCBmYWxsYmFjayB0byBjYWxpYnJhdGlvbiB2YWx1ZSAqLw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGlmIChjbGtfcmF0ZSA+IDAgJiYgY2xrX3JhdGUgPD0gUlRD
X0ZSRVFfTUFYKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBWYWxp
ZCBjbG9jayBmcmVxdWVuY3kgKi8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHByaXYtPmNhbGlidmFsID0gY2xrX3JhdGUgLSAxOw0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIH0gZWxzZSBpZiAoY2xrX3JhdGUgPT0gMCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcHJpdi0+Y2FsaWJ2YWwgPSBkZXZfcmVhZF91MzJfZGVmYXVsdChkZXYsICJj
YWxpYnJhdGlvbiIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJUQ19DQUxJQl9ERUYpOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBkZXZfZXJyKGRldiwgIkludmFsaWQgY2xvY2sgZnJlcXVlbmN5IDB4JWx4XG4iLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbGtfcmF0ZSk7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgLyogQ2xvY2sgZnJhbWV3b3JrIHVuYXZhaWxhYmxl
LCB1c2UgRFQgY2FsaWJyYXRpb24gKi8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBwcml2
LT5jYWxpYnZhbCA9IGRldl9yZWFkX3UzMl9kZWZhdWx0KGRldiwgImNhbGlicmF0aW9uIiwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFJUQ19DQUxJQl9ERUYpOw0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gKw0KPiA+
ICsgICAgICAgICAgICAgICAvKiBWYWxpZGF0ZSBmaW5hbCBjYWxpYnJhdGlvbiB2YWx1ZSAqLw0K
PiA+ICsgICAgICAgICAgICAgICBpZiAocHJpdi0+Y2FsaWJ2YWwgPiBSVENfRlJFUV9NQVgpIHsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIkludmFsaWQgY2FsaWJy
YXRpb24gMHglbHhcbiIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcml2
LT5jYWxpYnZhbCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7
DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIHdyaXRl
bChwcml2LT5jYWxpYnZhbCwgKHByaXYtPmJhc2UgKyBSVENfQ0FMSUJfV1IpKTsNCj4gPiArICAg
ICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAgIHByaXYtPmNhbGlidmFsID0gcmV0ICYg
UlRDX0NBTElCX01BU0s7DQo+ID4gKyAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgIHJldCA9IHp5
bnFtcF9ydGNfaW5pdChkZXYpOw0KPiA+DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0KDQpUaGFu
a3MsDQpQcmFuYXYgVGlsYWsNCg==
