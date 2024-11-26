Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277B4D5A6ED
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 07:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86CAE88A0A;
	Tue, 26 Nov 2024 08:57:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yl0JcEJZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 312468913C; Tue, 26 Nov 2024 08:57:50 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A0A387E30
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 08:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrUWntiipu4el6UdvELoPFEtIfX/U8J0CzudfpW96ZckfFSmbfjR8UxYAqMnloQMsSNxKmjUm67P1j7arnoJ/A3jSlF1rDX8kOxtxzSqchDd+JpssY7G3uo1OAPSCCk2pQqcCxarOXLEnDqqKKcUUEY7w+JmP5/SqBsxcgZGlVVOk5j5kqRWw9qBBA3z1t0rqd1zBUGofMQXj0+OeDLV1X9imxE3UCzippXRx/L1+RX+Q2Xxv4Q61gaQQxBkkrG2b3JW03K1RssDr0MkPvn2ns4AJuovZcLxyiMOuBFUTLtSKrK2Megk4WTZ5Iq+7MeK4K1xy7qTJ1hivpha0efnHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpciaU1KaMElDkpQOfGQXeRgNOhltSGsM8ATgsCzjuY=;
 b=t8dCyzhhFJzHlLeL9cTC/DB7dykt5VcgzrVTkkj+flUyKmOcpOmPonDhxmkJB3b8zhxy/JeVhQJpM5rD8p7wFV9Aaj5bjY6OlNETnS+zfx6Z87H9aqCWjbd4ehqVTWqiyAIKgPs29vwxir6X9tVh67F3gBD7jSe99ae7vGWiI0kd1CTLNpHVdLMJq7sR6OUFEwjzs8F0gALPNPOkRH9/1MaRD1QP99ZaqQOnVc7+BRofrESzNCPzC0Pk1r6O8d5U/GnTOeaNWY9hpSl62ZLMApt01KNWQgUyv2sUCC3wk3iwd0s0dkuiCWiTbPvdGGVOlvZsiXiBX6oZ2qZ/0ViDjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpciaU1KaMElDkpQOfGQXeRgNOhltSGsM8ATgsCzjuY=;
 b=Yl0JcEJZRJHAlRVpKuSofdWqmlGIMr2y90pCMN4JMvxttmmAUcg0TGt9Y6j0QlDPgr1btKJWX1TJSFCpmUdbI94/RjP8HPmUlyeu0spsU8dxyvru+VOzstfSeqCX2vZstdKfSZEGsPXKO2p6hEp9UfdxBz8/7CIDeI5FNJUJZ5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 26 Nov
 2024 07:57:44 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 07:57:44 +0000
Message-ID: <8b3eaf58-4e5d-4d6d-ac3b-a4fb57568473@amd.com>
Date: Tue, 26 Nov 2024 08:57:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] configs: xilinx_versal_virt: disable USB_DWC3
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-4-heinrich.schuchardt@canonical.com>
 <8941f3cb-2993-4cbf-a24e-a7a77898d634@amd.com>
 <72bb7c7e-1103-4ffe-af26-fb70136d11fe@canonical.com>
 <e91068f5-e9b7-44ca-a09f-32fab22dc3b0@amd.com>
 <9a90a05e-1e93-49c7-a72a-523ef345e7fc@canonical.com>
 <30c3072c-8446-412d-a534-61d9c8e0b03e@amd.com>
 <20241125180847.GK3600562@bill-the-cat>
 <ad58b032-f618-498f-8cce-f13d0f6d6021@amd.com>
 <20241125184824.GL3600562@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241125184824.GL3600562@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0103.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::44) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 4350ecb9-c220-4ffc-e6df-08dd0df0025c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGR5WVJUUjIybllLR01kTUlNWnRsTWd5OWJSUVlJQ1FVTVErSlkxYWZzME8v?=
 =?utf-8?B?Nm5tVk1CeUltN0FXUmptSE5oRnZoS3FxMkFHR0FXUERCZkNwSXd1VWF5em5F?=
 =?utf-8?B?c0liOHdOZ2RtUnVlaDNXYWV2ZHkxQ04yblYybjd1eTAyZmtxQkVYWlVwTjRi?=
 =?utf-8?B?N1NWTW1YL0U5Um5ISzNjc2ZMdGVtWWNzQ1dPYjBQTzM4RERKMVZZNG1mTUpG?=
 =?utf-8?B?TmtUZ1p2V0hSdmxrZUl2ZkxyaWRaOFVDZldXWjIxd0lySFRUa3hOYXBXNWwz?=
 =?utf-8?B?ZXVNVjJHendzbm9HUEtuM0pZT1o1WWt1V0V3blFGYTVaSE9XN0NIVTBuODdH?=
 =?utf-8?B?V296S1lueGZrS0ZOb3hBWmR6VmE2VVQ5UVJqZHk1b3RIK1U2QUlZdFdQNFU5?=
 =?utf-8?B?M0wzTithdk5lZ0Rsam5CempYRCt4T2NWK1d1ek5rYWt1d2hITm1YejNsTHFQ?=
 =?utf-8?B?QjlndU8zVlc0MTJQbEZKM1J3Njh5YkR1OHladExBL0tLd1N4ZWxIcUVpOTAz?=
 =?utf-8?B?a1g3TFI3WWVXSVlydE5HbjF3UEhIT1hEVkF3NFkrVllWV0kyd295V0dNMXhu?=
 =?utf-8?B?TUlSYms2YkJXVzlWL2ZoMnBlMTdCYzhzQ0MyU2RSdGR3cWdrUk56Vm9PcFJ4?=
 =?utf-8?B?eEoyUHUvaHd6Qlh1dWkyWTVnU1pxTU5MNm83N1haWEp1a3l6dkVGOXAzR1hJ?=
 =?utf-8?B?OVVzRVUwUi9HcU5ya05rWEYyRTN3UnZxeWpicDVWMldQWm1RQU9sVWg3enVM?=
 =?utf-8?B?d0NSWFphWi9mU2M2dlZ4RDBPalQ0OUN1bFFFejF0MkJZNUZYbnBvMDNwbFFm?=
 =?utf-8?B?ZGdmeXEyak1wMy90dkVIUStHa0dzNjVRQ0VPb1R3R0JudnJ6Z3hhU2Y2Qmgz?=
 =?utf-8?B?SmovYUlnOXl3ZzlYM2RtZ25lMGlQRWtxUkFNRHZJWnhWZ2R4eHdpTldPQ2JJ?=
 =?utf-8?B?cVlQZ0hwK0RoekFoVXk3WFljZGVmby9HelM5MGhicjB0MjFKd3l5Mm5pMzF1?=
 =?utf-8?B?eVg5NHM4SDEybkp2bmRZTVZVK2pYRHIxUFRpdkc5STBiNGxRdjZvMWExOHpC?=
 =?utf-8?B?T2FKNmZQU0FJZGY1V1VzZ0FrbVNRYUJEbWdvMHZqRVpYOVQ4TFhoYzl4dWV1?=
 =?utf-8?B?U1NFdk8yZEpndEZHUFRPKzhEaEVCOEFXRjJldG10azJQdmFWUFdQMEVvYzZB?=
 =?utf-8?B?RW8zV3RJdTRyNmVJcSt5R3VadEFuVGRtWHJtbkdkMkFYWUdXNEhyd1h3aVM0?=
 =?utf-8?B?VGRUTGcrYjhCVFN0SWxvU2xDcjJEVXV5eTkyMkgzbFdHNHlZTHFCVlpuSXNP?=
 =?utf-8?B?K042SXI0NmVmeXV2QW1rNHlHNXVNeVJmWXVIUGhRcnFycVczWGFTOFJRMGNa?=
 =?utf-8?B?SmpVZ20zSUxieFBOaTN4bndacEdITzhPSmVEdmZGVXBLZzF6d0h5dkxtZ2k5?=
 =?utf-8?B?L1RsZUZpOGtsYk1IR2R6c1M0OUtsNFUvWnZBNDNqRThiN1FDcFJXdzdpM0g2?=
 =?utf-8?B?RGg3RmwvcVBFUGloMkJQZWhOWEYrNzJ1enNFZy9zTVNjdzFLa1FNWTRweDhY?=
 =?utf-8?B?ZTYwc25GVG5ub0JITlRZaUlFbUR2MG9LdVRSMzFMR3VzdHNYTXNxRmxFWEpo?=
 =?utf-8?B?b0RrTnFEZ01XeDF6alhsclN3cGJFV2EvSlREbm9kN2dRelJ2MkRlMXgyNjJL?=
 =?utf-8?B?YmdNOUk3QUZtMy9KekFwdHhONitlVjlZcUNMUk54aUZmeXdCSEhVN3VWRGpr?=
 =?utf-8?Q?XbaPrnWNlbegM7i+DQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGZuK2xGRzNLRDczc1JSbG83NDMxQmx3QUVDSUxyZ2VQTGIzOVlucDNuMlNC?=
 =?utf-8?B?QVJ2SHlJbXFkMjdsVjkvd2p6UjViTFVGQndvR3VtU0dFMkZzdk40NS83dzJq?=
 =?utf-8?B?UThRQ3ExN0VreWNPOUI1MFJJY0gxaXpvdG5mNk5pbmNpa0hBUGJDQ3dFalBQ?=
 =?utf-8?B?NlFBV3hzdWtNWklScFJDRVRoREtMR0k1WE03ZHhacHRGWjhMUGEwZ000UlNm?=
 =?utf-8?B?Skg4US9VazZLaEI3QXFkVUh4YjJaWUhFM0pFMXY0WHF5Ry9xSEhDenY1aEU0?=
 =?utf-8?B?YUVYcHpRVW15SGZNeEJjcjVucWV2SWRrZTVGQzQ2UXpGdDJ1SFEyMkNsSGty?=
 =?utf-8?B?NHcrQ3BJZWlGbFQ0TEc2Y2dFV1ZEeExDbmdTTGVxMXVSRG1jSGxLM0diRFg5?=
 =?utf-8?B?TDI1VkpvbjdvckhVVkp2aVZMNHlycDRtWDZZUUVBR1RzMFdEMW9pL1dzZzNk?=
 =?utf-8?B?OSt6czVzN05iNHBUQnUra0toUVZiWHZ3ekdSQWJZRnI2anpUZHZuTmVSaFpC?=
 =?utf-8?B?MklZM1htMzdlT3pJcDNSc2VvYjN6ankvQjRNL0JYZUtrWHNTd1drMmxEUHJo?=
 =?utf-8?B?OVFyVFhxQkZJRFZCelBlOEZqTjVDTHp2TW1WczloUVR3anZ5alR0NDViQUlL?=
 =?utf-8?B?WHBvRjVzRGxHMWx0dGhuejNTOVlKejRHY1ZreG02ak1YZ3FQdjNxSjlTdHIw?=
 =?utf-8?B?NHZmMi9KVFJrNjJrR1k1YTdoUFgwVm52Q0FJQXd2bEVJYXhVQSsxYUJrYjBN?=
 =?utf-8?B?bEZrYTRaWmN3d3hacktjZ21JOUxQQmVkbk9IejN4NXQ1c1lIek1yYWFxcmll?=
 =?utf-8?B?TDdDK3U1dC90MFo2dUl3WVhUS3NMY08xWDdzZ005b2dyanZJS2s1SGljaHhV?=
 =?utf-8?B?aklzUDFNTVUzK0o1bzZZUXRpQ0FJTjduOWtmdFJEZElMMElJWUdhQmlLY2Vw?=
 =?utf-8?B?alpWWmM4SGc2c2FQK2VVaGovcDBOeTdzV3JhMkNHTXhveFloMDhUOTUrREVJ?=
 =?utf-8?B?ZGF4ekRwYk9wTXBraXdrYnFBZUtaM080S29UakVJVHh0TnFzanFyVmJSamJV?=
 =?utf-8?B?YkU2TjRvTmV1YVUzZXEzNnFUZHJacTVPc3RBQ1EwWW5PQWc1SmwvQTdJM2Fj?=
 =?utf-8?B?WWw3K2U4SFV0WnZHWVZGQm92YjdFQmFvTmw4ZzVDc3ZJTTJSN2NXZGdVSUV0?=
 =?utf-8?B?YXBsck84L2hOOVIyWks1ZkltSU8wd29IbGNrVHN3R1pHT3V3MlRkeDhvOEhK?=
 =?utf-8?B?aFNwQ2V1SGgzd253VDZJSXBkRmt0Tjc0bXVEWjFCY1RJWGVEMlFKRU1XM2x0?=
 =?utf-8?B?Wnd6M0dRdUFiQTlDMDZOMW5NODl4N2FMRFkvR1dZY2phYm9lRHBISHNleWhN?=
 =?utf-8?B?N2wzMXR2WVM1djBGNzh1eXNmSEs4WG1jSDZrRitZVHRWR0haSXFRY2ZHLzRh?=
 =?utf-8?B?ZWp5Qy9rNXpETnVZSUpSRXdveUR2Y2ppRjlrZmN6SEgvV3dmTFprVWhGekxv?=
 =?utf-8?B?cDNqMlVkV0hzeUZQK3dxdW04TVR1Q0JZcTJRYkgyN0NYMXFxU00wMXVoN1lH?=
 =?utf-8?B?MGJ6SUhqaG5XVm1xVTM5b0hRVDVmM2s0Zld6R0ludzlaVUdDSWlES1FqbXJ3?=
 =?utf-8?B?WEY3S0RPOWs2VjB0Y3VpamtUTmR5QmVYeWhjdmFIeEptN1dWdzdGM0taUEFB?=
 =?utf-8?B?clNlSW95Mlg5NVNPYnZpb2hucUlmMEFDT1lUbkhkSTQ5bGtZblg5emt5QURF?=
 =?utf-8?B?QzRuQ0RhR0JpN3NReGxsMFE4cy95b2JnellkUG5MS2dTYitKV3dWbVc4VnZB?=
 =?utf-8?B?WW5kZlRPT25vMlhmenozL1pxWWg2QTgxSkR5VUttQy9LZ0VPbTIxMXM0RGhk?=
 =?utf-8?B?ZzdYbFBCNzE3QXJDekpKR0NWVkw5bG43Ykk5MXBSZyt2dGZxYnhuZ1dkeWJq?=
 =?utf-8?B?Sy9tSXIwWlFWZ3pPOU03ZHBQcTZBWk9JOFBNc09sdU55bDFGNFdDMUViaEJI?=
 =?utf-8?B?c3FsTXNiTGNCTExBMWpVNmZ5L0VRR1I4cXVoVUczTXJFRkxrNTg5RzRLbXk4?=
 =?utf-8?B?elNTN0theHU2cHRNbjI0MnpBUFJuTkFEak5xbUdMMUFaR2tzbVFWaVZhMlp5?=
 =?utf-8?Q?FU9PnqRun+D8fJAo9QleBnPih?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4350ecb9-c220-4ffc-e6df-08dd0df0025c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 07:57:44.0426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2CzkCAsScbQJ0B4EbcJewj0ZhFwx57ltitCFva9dwt4MCaFWCj4QWd+2629PmFa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367
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



On 11/25/24 19:48, Tom Rini wrote:
> On Mon, Nov 25, 2024 at 07:44:15PM +0100, Michal Simek wrote:
>>
>>
>> On 11/25/24 19:08, Tom Rini wrote:
>>> On Mon, Nov 25, 2024 at 07:03:41PM +0100, Michal Simek wrote:
>>>>
>>>>
>>>> On 11/25/24 11:35, Heinrich Schuchardt wrote:
>>>>> On 25.11.24 11:02, Michal Simek wrote:
>>>>>>
>>>>>>
>>>>>> On 11/25/24 10:21, Heinrich Schuchardt wrote:
>>>>>>> On 11/25/24 09:32, Michal Simek wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 11/23/24 22:45, Heinrich Schuchardt wrote:
>>>>>>>>> The CI uses the following command to launch xilinx_versal_virt_defconfig:
>>>>>>>>>
>>>>>>>>>        qemu-system-aarch64 -M xlnx-versal-virt \
>>>>>>>>>        -display none -m 4G -serial mon:stdio \
>>>>>>>>>        -device loader,file=u-boot,cpu-num=0
>>>>>>>>>
>>>>>>>>> 'usb start' or invoking eth_bootdev_hunt leads to a crash when function
>>>>>>>>> dwc3_core_init() tries to access a register at offset 0xc704 (DWC3_DCTL)
>>>>>>>>> relative to the register start address 0xfe20c100.
>>>>>>>>>
>>>>>>>>> Disable CONFIG_USB_DWC3 until the driver problem is fixed.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>>>>>> ---
>>>>>>>>> v2:
>>>>>>>>>       new patch
>>>>>>>>> ---
>>>>>>>>>     configs/xilinx_versal_virt_defconfig | 2 --
>>>>>>>>>     1 file changed, 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/configs/xilinx_versal_virt_defconfig
>>>>>>>>> b/configs/ xilinx_versal_virt_defconfig
>>>>>>>>> index c8f166c1221..06a240173ba 100644
>>>>>>>>> --- a/configs/xilinx_versal_virt_defconfig
>>>>>>>>> +++ b/configs/xilinx_versal_virt_defconfig
>>>>>>>>> @@ -153,8 +153,6 @@ CONFIG_USB=y
>>>>>>>>>     CONFIG_DM_USB_GADGET=y
>>>>>>>>>     CONFIG_USB_XHCI_HCD=y
>>>>>>>>>     CONFIG_USB_XHCI_DWC3=y
>>>>>>>>> -CONFIG_USB_DWC3=y
>>>>>>>>> -CONFIG_USB_DWC3_GENERIC=y
>>>>>>>>>     CONFIG_USB_ULPI_VIEWPORT=y
>>>>>>>>>     CONFIG_USB_ULPI=y
>>>>>>>>>     CONFIG_USB_GADGET=y
>>>>>>>>
>>>>>>>> NACK. That's not the way to go. If one test is failing in CI
>>>>>>>> disable that test not really support which is for HW too.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Michal
>>>>>>>
>>>>>>> Hello Michal,
>>>>>>>
>>>>>>> It is not that a single test fails. USB is completely unusable
>>>>>>> on the board. 'usb start' leads to an immediate crash.
>>>>>>
>>>>>> I am not applying any patches on SOM with HEAD and usb is partially working.
>>>>>
>>>>> Don't you see a crash when executing 'usb start'?
>>>>> What QEMU are you using?
>>>>>
>>>>>> I can agree that it is not super stable with upstream only patches
>>>>>> but that's different story.
>>>>>>
>>>>>>>
>>>>>>> The problem already existed in v2021.01.
>>>>>>
>>>>>> Any log?
>>>>>
>>>>> $ git reset --hard origin/master
>>>>> $ make xilinx_versal_virt_defconfig
>>>>> $ CROSS_COMPILE=aarch64-linux-gnu- make -j$(nproc)
>>>>> $ qemu-system-riscv64 --version
>>>>> QEMU emulator version 9.0.2 (Debian 1:9.0.2+ds-4ubuntu7)
>>>>> $ qemu-system-aarch64 -M xlnx-versal-virt \
>>>>>    > -display none -m 4G -serial mon:stdio \
>>>>>    > -device loader,file=u-boot,cpu-num=0
>>>>>
>>>>>
>>>>> U-Boot 2025.01-rc2-00172-g880fcc49eb40 (Nov 25 2024 - 11:18:35 +0100)
>>>>>
>>>>> CPU:   UNKNOWN
>>>>> Model: Xilinx Versal Virtual development board
>>>>> DRAM:  2 GiB (effective 4 GiB)
>>>>> EL Level:       EL3
>>>>> Core:  32 devices, 13 uclasses, devicetree: board
>>>>> Warning: Device tree includes old 'u-boot,dm-' tags: please fix by 2023.07!
>>>>> MMC:   sdhci@f1040000: 0, sdhci@f1050000: 1
>>>>> Loading Environment from nowhere... OK
>>>>> In:    uart@ff000000
>>>>> Out:   uart@ff000000
>>>>> Err:   uart@ff000000
>>>>> Bootmode: JTAG_MODE
>>>>> Net:
>>>>> ZYNQ GEM: ff0c0000, mdio bus ff0c0000, phyaddr 0, interface rgmii-id
>>>>>
>>>>> Warning: ethernet@ff0c0000 (eth0) using random MAC address - 5e:f6:37:a3:68:24
>>>>> eth0: ethernet@ff0c0000
>>>>> ZYNQ GEM: ff0d0000, mdio bus ff0d0000, phyaddr 0, interface rgmii-id
>>>>>
>>>>> Warning: ethernet@ff0d0000 (eth1) using random MAC address - 5e:8a:ec:a9:d7:e8
>>>>> , eth1: ethernet@ff0d0000
>>>>> MMC: no card present
>>>>> MMC: no card present
>>>>> Cannot persist EFI variables without system partition
>>>>> Missing TPMv2 device for EFI_TCG_PROTOCOL
>>>>> Missing RNG device for EFI_RNG_PROTOCOL
>>>>> Hit any key to stop autoboot:  0
>>>>> Versal> usb start
>>>>> starting USB...
>>>>> Bus dwc3@fe200000: "Synchronous Abort" handler, esr 0x96000050
>>>>> elr: 0000000008068fd8 lr : 0000000008069940 (reloc)
>>>>> elr: 000000007ff17fd8 lr : 000000007ff18940
>>>>> x0 : 00000000fe20c100 x1 : 0000000040000000
>>>>> x2 : 0000000033310000 x3 : 000000000000003f
>>>>> x4 : 000000007ffa74b0 x5 : 000000007c112880
>>>>> x6 : 000000007ffa74c0 x7 : 000000007c300000
>>>>> x8 : 0000000000000684 x9 : 000000007bda668c
>>>>> x10: 0000000000000003 x11: 0000000000000188
>>>>> x12: 0000000000000000 x13: 000000007bda6be0
>>>>> x14: 0000000000000000 x15: 000000007bda6224
>>>>> x16: 000000007fee9244 x17: 0000000000000000
>>>>> x18: 000000007bea6be0 x19: 000000007c111b48
>>>>> x20: 000000007c111240 x21: 0000000047822004
>>>>> x22: 000000007ff998b2 x23: 000000007ff998e8
>>>>> x24: 000000007ffd4514 x25: 0000000000000000
>>>>> x26: 0000000000000000 x27: 000000007c111130
>>>>> x28: 000000007c1110d0 x29: 000000007bda67b0
>>>>>
>>>>> Code: b9030660 f9416e60 d5033fbf 52a80001 (b9060401)
>>>>> Resetting CPU ...
>>>>>
>>>>> resetting ...
>>>>>
>>>>> $ cat u-boot.map
>>>>>     .text.dwc3_core_init
>>>>>                    0x0000000008068f24      0x6a0 drivers/usb/dwc3/core.o
>>>>>     .text.dwc3_of_parse
>>>>>                    0x00000000080695c4      0x310 drivers/usb/dwc3/core.o
>>>>>                    0x00000000080695c4                dwc3_of_parse
>>>>>
>>>>>>
>>>>>>> Do you know of any QEMU/U-Boot combination where USB ever worked on the board?
>>>>>>
>>>>>> Why was this visible in CI in past and why this pops up now?
>>>>>> What has changed? I don't think there was any change in QEMu
>>>>>> regarding USB but I can double check.
>>>>>
>>>>> We never started USB in the CI.
>>>>> With patch 6/6 of the series usb_bootdev_hunter() is invoked which starts USB.
>>>>
>>>> Did you push this to gitlab CI? Which test/py is failing there?
>>>
>>> Er, we don't do "usb start" in CI yet, is why it doesn't fail there. Or
>>> are you suggesting this is a QEMU problem ?
>>
>> This is where it is failing from dwc3_core_init().
>> dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
>>
>> It means it is likely qemu model limitation.
> 
> And since this is for the virt platform, doesn't it make sense to
> disable it until the model is fixed?

If we are talking about CI it is about pytests. It means we can simply just 
disable that particular test which wants to call it.

And I can't see any issue in CI when this series is applied on the top of rc3.
https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelines/23565

 From my perspective make no sense to remove usb from defconfig because it is 
used on real HW (we are using this defconfig for real HW).
If there is any issue with USB then we can just disable USB in CI only.

Thanks,
Michal

