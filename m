Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF93C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:02:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C1D98083E;
	Wed,  5 Mar 2025 15:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="a7w78Y6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD67180F9E; Wed,  5 Mar 2025 15:02:43 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84DF9807B1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:02:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=treding@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Me8BPSnX5U3dnfBvkTt8C1qbWLZ6jN+ygoISBgk7gSMZRGjw8+aQllpvHIAK72eoB2352TvW3amsPVZNpDuEd0SwSbZD3/EMbbnIzfXhgbkJgrLo+8rw+uz0UHUOVKVk69YZ5Z70IjJ6ufdb1cI71rJ3YzyL5Dg6XT0Dx24S5j2sjFoUjfb36giuCG+PwJNr/s3ck2silVrvq+Mgu097YtMAuKh/JKR9M4a/lJW6dYOz/ecsUL/fmVp+B8P/cDuWR7G1D1BSRH/ArbWgnOwug4YStbF1yyylcJzC6BlZvUi4R0Yx3HlkoompGC8E1Y8rdeGgaeWyJgWBr81KJzfdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCka3gmhRCq2YLEywczgqzQkRm3ivmBYLICkf5U8+9A=;
 b=n+0e/ogPYbsboqu8g41IiJd00W1HXhEg5sAW7M7QonMIaw3BWDinFoor7g41njpRZ0RSBrLUO0hCCZKVFh03/Ck10tSfBU5ZHZHYWv2aNF/H9VjFKhzT0dvOZceiLmfEgztsR3lyzkCTMWCd0HOEKvhMz5BnzR53Aauy/vrfxcLje4pMa3OFEJoDuw/zfigX37M9iJny4L6IJBcEAxaKcI8wriG74pZ+kuBypF1p9vIg/48VI0dhgG7EaAK6G6WVmruPdq1bYX39GZudAehF6b19dtbsl+ZDUJ4/Es+wA0t0yEgjyR8PfFGOOSXd3ru0a/JCtErqdXHiZPFISThAHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCka3gmhRCq2YLEywczgqzQkRm3ivmBYLICkf5U8+9A=;
 b=a7w78Y6F9r1TzlhEGyLzEg3vXBTlGGHKte1AfHTZh/h2U5RcKOyDXBag3qRTCfTS64EqPpZ21NblvMdu2YXTqh6wG5RBPCqOTow7cXl7avDJQE0/EqJTvSnJPuZcVZ8hPlVIujRLdOX6GV7DD4GDvwbrgqr+MsVIyD84g/QXQrSSLsvB4V05EdUp1tkQttF+rhsQb/xC7q3mt/suXva731b+kryWabfcvfUJMQXofZThwT11SVLuJJ5Bn8rZOGPdcYEQ4jlErFD3rP3S/07XQ6isYfizbk+0Bg5JZU5C+bwyPlfHxu9ROWhBaNk7J/xmxtohPIK8xzbO2Cxw0FnmVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) by
 PH7PR12MB9074.namprd12.prod.outlook.com (2603:10b6:510:2f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Wed, 5 Mar
 2025 14:02:37 +0000
Received: from DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c]) by DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c%6]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 14:02:37 +0000
Date: Wed, 5 Mar 2025 15:02:33 +0100
From: Thierry Reding <treding@nvidia.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Jonas =?utf-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/2] ARM: tegra: clock: fix PLLD/PLLD2 related clock
 calculations
Message-ID: <tcwixvrk57o5rtrfycjj6u6r3e3lrbyfjbinddy7i3vqryy32u@m7emuzsuikdn>
X-NVConfidentiality: public
References: <20250305111213.163428-1-clamor95@gmail.com>
 <20250305111213.163428-2-clamor95@gmail.com>
 <kfyuo4l2w4menkfrb2sbvvp2ptumyed7bvz64vrnpm7lx6dpqe@hxo2633n2poq>
 <CAPVz0n1H5rktuYJ=HGMiXtOqyOFLSEJeyUJvcEdGcr1T_PfCrA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jjavjwdyei723emi"
Content-Disposition: inline
In-Reply-To: <CAPVz0n1H5rktuYJ=HGMiXtOqyOFLSEJeyUJvcEdGcr1T_PfCrA@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::11) To DS0PR12MB8317.namprd12.prod.outlook.com
 (2603:10b6:8:f4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8317:EE_|PH7PR12MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: 833b8ac1-4fb1-40cb-6009-08dd5bee62a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkIreDRuY0Q4dzlEbW9TREg0WlRNc3BicnZRSjhPelQ2dGVNaEFDMkExcmF3?=
 =?utf-8?B?RTZMY3dkbE5oMU9pdFduM1Y0K1Q0ZnN4ZlpZOFp4WHBGNmtHNnNQV0ZJQis2?=
 =?utf-8?B?ZE9qSjluV0ZzbHBZUmU4OGtGSkhGMXNhb0E4NUFKVE9jQjQzZnBjT0ZVam5t?=
 =?utf-8?B?WE5tWlBuZytDa3F3NFUyMEFYSTM2MEEzZXVmekxvY0twS0MvaXFNNjVzcEVt?=
 =?utf-8?B?UWtmM0pCMHE0eUYrY1hCS3c1UHIvNkRnTjgzVGZSNThGWWY5akl0RVlDbEEw?=
 =?utf-8?B?cFdlTXl4bTdScVJyNXRYUzd5VVV3SFdNc0cxektqb3ErbHh2WUZZRElXZjlZ?=
 =?utf-8?B?S1VCUnJ2ME9EVUxVWXprSDhjT2xVVzRCSTlKTWtUU2VVVm1Na210WjNzKzBl?=
 =?utf-8?B?UDRaWENFWGl3RmRtY3o2QUVUaFJ4T21VRzBOWWZLZFZKdWpPejkyeFpLZWlW?=
 =?utf-8?B?RE15ZXV3RzIyelkwQWdXNlI0SjVhMGJkSHhpaTlZcFJZeXg5YjBTdG56bS9M?=
 =?utf-8?B?ZGJhNEtSOE41bHFacVVrTGpCTXY0RElmdE82MkhVUnpRRUFHeEQ1UTR6dHpF?=
 =?utf-8?B?SHc5Vmh6UUZuRW4zRGRsMUd6aVZCTWNEeVA5eHdpU0prdE4xbzZsY2U5aHhR?=
 =?utf-8?B?REowZjF6MWpEMnhoN2pjVWZTdDRFcHpXWGhjTUxuRmtZSTNHYm1yVldENVFz?=
 =?utf-8?B?TVA4VmthUUtBakVQMGNBeFZGUnpnN2tqWGsxSlFYQU9kbFVHOVRIRThIV3Fp?=
 =?utf-8?B?dmZzU2tKNkZ1aWVVVWFEMHltQVI2S29SL2x1THpSdE5mVUwveVVRVjN3Qk1B?=
 =?utf-8?B?OGg4MzVETzlxWElwNzczU05vRUhHWjNSMEVEdmxnSFcyOGV5Mk82QkN5M3pC?=
 =?utf-8?B?Wm5KRWRrSDkzbDEwb1dCc1hqVjhZMFl3NnRNamh6T1g1M09uYWNGaml1SU9o?=
 =?utf-8?B?S0NmdjBiYVpyK01qNk5Zazl5Ty9DZHVSbW5rYnRyeFdjMWNpTWk5UHJpNUtD?=
 =?utf-8?B?cENBemNZNHZRNWRXUm9ITFEyd1QwVEJIb0QwYlE4ZTRyeUJLaExLbmFxVHdk?=
 =?utf-8?B?R2kvZGZMWGppUFVuTEJnYW82UG9zaUs4SnRtTmJEZGE5Tk5HUXh0NzhUTUVH?=
 =?utf-8?B?RjVyYkg2YWsrR3pBb1JqMEx2RzQ0TTl2RGpiOXUxdEdoRUh3NGZWVU5UaXla?=
 =?utf-8?B?L25oUnFoQXdqQnhTdnF5c21KbDUwb0g4c3hWYUowVC9CbTkzTmdPaDc1VUxn?=
 =?utf-8?B?YXhxSUJjOG9YRjFEZG0wdHJpd3p4YnFzKzBDWDdpTCtRNDJjd0FmL2Z0WEE4?=
 =?utf-8?B?UWpzTHhVZEVJTEtCVndLNEJTMlFHNThtUTQ2NXlFL0tKeng4WUdtbUhaeEUv?=
 =?utf-8?B?cXNFdkJQdHpEenVjUDRaamM1VG1EWi9jRVljcDV3eGEwdUhRZk9mZm1KQ2FK?=
 =?utf-8?B?WmJRcVpUNnFQZHROK3VFbWoycGRaaFkvaXRidmtpY0FFL0RTZXJCWW9NRWR1?=
 =?utf-8?B?SW9jVzhZNE1mbERua1dpL2xmcVNkbVFUS3dvcEUwc1kzdWNOVHdONFgxcERB?=
 =?utf-8?B?cTVweXBEaWhzaU9JSWFmUXRTaVQ4Ym5nUzFrTnZTeDMyZTVBZWhTWlByNnlM?=
 =?utf-8?B?dWRFQytabG1DOGlXbDZ4RjdwN0Fxc1daMUZ2UHZGWFNQejd5VWlBVUloMTd1?=
 =?utf-8?B?U0dCbG84VGFtMWhaamYyMTBRVlJ0SytLYkQ2QnVHS1BxUGUvaTBNaDlYYzFX?=
 =?utf-8?B?S3duc2hvekEvNkVVWHFKbzZNSXNUTStYakpKNTBIbWJBKzAzcnE3b0V6ZkVm?=
 =?utf-8?B?N2t6Q0dMa1lqcWhtY004TzZETDhRbEhURWtUdGRQL3lMZjI4a1RCeS9ZYUpC?=
 =?utf-8?Q?+RS/FOwqelr4l?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGxuTCs3YS9xMnJCTU1JN0ZIOEdxMGo5bWJ5N2ZZV3hvbDZBMnZVRDlVMFBQ?=
 =?utf-8?B?M3hDNnI1U3QwWVZoNWNDRlVKV3BFVW1HN2IxNFRKUHFIbEhZOUFkZXp3bTV6?=
 =?utf-8?B?VDRHUE1iUEhrMlU1a0VkTUxXOUtNZjVIWTJnUmIyaXBaN2FHT2UvbG5TM0wr?=
 =?utf-8?B?cnZqck50aWVoeGRxZWdTdjRVaFdzK09wbFhKRXJmVjZha1NQaXJEQ056NTk5?=
 =?utf-8?B?ejBKV1ZxRkZMQmtiN0RLUTQ1ZWVGUmg0Y09oNmlkUkVhOXBRMWFvODYwZE5D?=
 =?utf-8?B?NUNrUlorNmVNSzBnRk5QbVZCQmlLMkF2bTJpK1dmQmQrajdOYlBrVUFERFBQ?=
 =?utf-8?B?bEpROTl0R0t0bWttRjE2MHliU0lGbVAxT1pPaVczVDFtRVBvejZBZnJhb3BH?=
 =?utf-8?B?WW04NllxMzZWeU9jbUpaQi9MOG14dDQwbCtvM0VaZllLaS84MEZncVBoT2gy?=
 =?utf-8?B?emdQTlpwZzZob0p6NFMwQ2RQUFJWaS90MUNpcnMxOVRRNjk5UHVUWkJvM2tv?=
 =?utf-8?B?eithTEpyK1NUL1d1OW5uNmpzU1QyVVJOSlE4S25aTmZsSlhydkV5eER0TDlu?=
 =?utf-8?B?YWYrWFJXcE9vWVdKcERtcDZLYzNtclhLcU8xRjFQTC93anBXTm5nbmRHNGk3?=
 =?utf-8?B?VUREYUlxaXpKZ01zMVZUd2d0R0VWZGtpZTZXYkl2VTFxck43S1Y2YzVRcGFX?=
 =?utf-8?B?bEQ5VkduZ1FBbXE0bVVLQ1hwYWlKeW4xZ2xuVlQvQjAvRjlFVHZJc3pyVE9w?=
 =?utf-8?B?eXoxVTVPRUJqeXIzMU9MVDNIV0RPOFU1eVY4MnQwVThmUVNTbjFBYkdxVlBL?=
 =?utf-8?B?cVVJZUhZdXQ4cC9PTGdiRGR5cXRGQ2xSN3p4eFdaUFhmRkJxSWZPY2ttZitY?=
 =?utf-8?B?VUNiRzYvc21CR0pOUzlqZklpeHVXZ2ZjT0swUUNDS1IreXNtN2d1WWVGUisy?=
 =?utf-8?B?MnBFM0xxYlZkRk5IRHhMVHdEb2tGanZ4dXBBV0F1a2tNaWprNDhUMHVaUGJn?=
 =?utf-8?B?QS9JZEY3MjloZXNFaUN0SlpMR1Q5cGlhdDR1RnVlZDhGUm0vVDVmeitRdjhr?=
 =?utf-8?B?dnVROWVoSnZVc0kzQVFJYkVxZ2JuZDAwSlRSTXM3b1ZvK1hrbGE3cW5WWVBw?=
 =?utf-8?B?dkVrdlpaeVZLd3RrSFBHQ202bDA1a2NtdmhHcG94UE4wdUxPdFBVMExCbHdl?=
 =?utf-8?B?clZTMEtkM01aVGcvcW1VUHJ4a3YvbGU4MGRYV284dzVFcHlkOTZlT3UvZzRZ?=
 =?utf-8?B?dFJoR0F5MDcyQkpwbHV1dFUvbkFoMVl6aWptYkMzMkxpS2RtdGxZMkpHcndT?=
 =?utf-8?B?QVRER1krbTRTbEk5NGhPcWFVSit1aUZtd2JJdXNvbHR4bDFRRlRQRWdKNWFh?=
 =?utf-8?B?QWpXR2crVE9rNFdzRWM1eWt0VEl5am5tczBiYlRmVURuRWxBbWRWcWNYanYz?=
 =?utf-8?B?N3cwOVFkbUN2SXZJSWptY2lWMmVsa0pldFJLRVg3TEVKaDR1VGlOb3JUbmZO?=
 =?utf-8?B?MmtXQWpzZmpmWmozdEIveVBnSFpnU1ZVL25TVGRHUEJScWJNektHQ3MrVWhV?=
 =?utf-8?B?K1lZZzhHZjJxOVUxb0NwSHF2MnhCVWlNRnlEbkI4RmZvbUI4eXdBQWx3blNX?=
 =?utf-8?B?QmdQTnJZUURkaXgyVTFnT09WNU91UjFYaWhtTkoxMDZXcThhRFVWS1VRa2p1?=
 =?utf-8?B?N3RaUU9BM3BPZGhybkgyNG5lWTVuS0o3b3FEMXdodmRqdUVLeTFXQUlhdHJI?=
 =?utf-8?B?RTBVQnExekVWSWNBcnk4TGZCbGJWUGpFSDdJajVGMStiOTJENDhoNTlsVXZX?=
 =?utf-8?B?dDhhV0hHc1E5SzIyRytaNWlSWml6Tk5YQmowQVpxQ0kxTEtwM1BIMWlid1lG?=
 =?utf-8?B?MUNGdjFjN0JnRTUrS01rNkt6YVB3aWJVR2ViUkwrKzZKRFpkY3EycnNmWVlP?=
 =?utf-8?B?cHJnTjY3d0Ryc09FejlscjI4eVZia2c2cnpNZzYyNFRPUm1zUzdGM0wrTjJE?=
 =?utf-8?B?UU1wbXhCNWRlRXNjbzFvZEFoMFNxempPWTMrZWkwMjJFaVVBT2ZmRFgrUGZW?=
 =?utf-8?B?cGJMVEl2ZDYyYkpYNHdJY0FlWC9RZHV4aDJBTEEvWmZ4MW9NQm5sRDVXdyt5?=
 =?utf-8?B?bEp5VWw4bExkMFBDVDlhYlpTMEcrU2phTFg0YWF3VEU5QVpIa2poaXhYZ1NT?=
 =?utf-8?Q?T5T/alXUlsdFR0EfNzv1pEuua4lqHojsh2LNbhLGN5uw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833b8ac1-4fb1-40cb-6009-08dd5bee62a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 14:02:37.4049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDPfnsEqrIUgG1oMpASic6+ZJtk/LBboQrmA/5a01quFr2E5avTvDXREs+kFzEoCRD0ZN24COSrp+Xa3HmlAcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9074
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

--jjavjwdyei723emi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/2] ARM: tegra: clock: fix PLLD/PLLD2 related clock
 calculations
MIME-Version: 1.0

On Wed, Mar 05, 2025 at 03:52:36PM +0200, Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 5 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 15:47 Thi=
erry Reding <treding@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Wed, Mar 05, 2025 at 01:12:12PM +0200, Svyatoslav Ryhel wrote:
> > > From: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> > >
> > > While PLLD/D2 is the nominal parent clock, all derived clocks are gen=
erated
> > > from its single output, plld_out0, which is PLLD/D2 divided by two. D=
irect
> > > use of PLLD/D2 is absent in peripheral clock configurations. Therefor=
e,
> > > clock derivation formulas must take in account this division.
> > >
> > > Signed-off-by: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  arch/arm/mach-tegra/clock.c | 30 +++++++++++++++++++++++++++++-
> > >  1 file changed, 29 insertions(+), 1 deletion(-)
> >
> > In Linux we ended up exposing the _out0 branches of the display clocks.
> > Wouldn't that be a better way to describe this?
> >
> > Thierry
>=20
> You are not satisfied with the description or with solution?

I meant the solution. However I might have misunderstood what you're
doing here. This is actually computing the rate of the _out0 branches,
which are the ones listed in the DTS files as parents, correct?

Thierry

--jjavjwdyei723emi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfIWXkACgkQ3SOs138+
s6GHJhAAscV2oJP00APrDCx1nszydHwn6SkaGSm2cUQtjSZEYHJlI0AoHhOMd0zO
fqLntpGqVL7UxHUabAD2SC9T+ZMtO4J+QkcNpdvOLPMGeGXpiU58YLXl3FYKvcQF
pag51sel3YW76XEgDuGnx538v73uqboV3FkELUWQiqWLtlPZ9O29C4HdnSMnDaNx
Z3Iz6jRYQVoT5lLnxs2THJuOtbRj9tl3C1EvKJfUh6+/zRe7hWEk9romItnKHXJO
AlO3cmrjHse2T8g0H9eEuICdCZlj4mmIQEx/bLVw3PBkHAoa5nEDV9ILQxoEMR6F
/VqUOAiw5+5ervFanMOL38ezTZrk9XhHPzCKli6AK1PVAt+VZfmWob0Q0oKyLxNi
k6tM5dRFNkDpmK0PpO3Zp4MwP/V37rEmFNLwGlpjCj5hxMrmM4xRYqUcCfAV+gMC
dpig7zePfTv91lKirxuL6PwZ/7wI6pL6uhoxSdHnr5n+Cjix/lTgFMCMEyWeNKVs
UvOCg0snGNoNkkrii3To8XjKcYWnPxTy4EC1Qu66XRytm7+GoZEXLh/h71KiRL/4
CBLuTu/0LQbslqxvjQRJXwxYW4pxkRXNWKCkuQo80VLG+4jo9jLy2Ffl4X07mSp7
jI1UUUf0BUInFsexqLpKdo1tVqvkbY4IrjtdDqndDj21fduAT8U=
=HztZ
-----END PGP SIGNATURE-----

--jjavjwdyei723emi--
