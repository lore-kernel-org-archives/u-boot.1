Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80362D5E150
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 13:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ADD8839D7;
	Tue, 16 Dec 2025 14:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XAYEzpFX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A18E839DD; Tue, 16 Dec 2025 14:45:52 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D17BC83971
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 14:45:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fi7Ew03YPnmSxc4QXdbPBClbhhXFPMj1AEU9XAteGEncZyb3vx57KyZnBZe5pDuUsb/7AunAS6Ja4TkFSXKYm/0d+0NgdvNeaf2PiEi+S7zrn4oGX2OM5vmTvktNTUIIX0hiOnTmUhOs7vHcgZJc3n9zD9G59aW6oryQzf438nc4eSzrKW9ITgoPUBdKPNa7GzsDH6jePBj1DhDB7U9fVye2yLICtBDI/L9EliTJTjlMCUmSNddmOJdlC4p2+xq+e8/m1Oynk7wQp+FOFFKcgX60plMMD+CkU2Dcly0Iv1Tlr1JdN0K6HbtTkR6C/Lnf7T0Uz1d+aacIlbTcC3zFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7wr9HMFWCHbGaN8E8T1oMEaryEe3GyAaX05Qy/Pyyg=;
 b=uT77eL7fdXY/kgcs0IKOTme6YWngdqiwSo3KB+JgzqaQJkUHffZO6kJIdyGDR91lRdXbh2qLDLg1IzOKN9S+Sr+Em2ezfts+aCJJhVoEfaCwofwqIpXstHDrBPsa/4tr4zhpJOzozByL4fiFaaE3Ov6bFMCMSBsG7BjNNWO2Me8w9KIJQvX9BrtUDoPFoB6UhczxvGNXGWEkWAHzqk8lbXmsQLBSHccaZ/1u+FKPyc1dKZLr4c41SokFj/7WMrKAARgTCwLyjPqdmZ8gpXpAjdQ+6kBMx38bO8/NuvwG+FoIeBq6dQx6RjR4//R+V25M7bqwXC+svv69yle1SBc46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7wr9HMFWCHbGaN8E8T1oMEaryEe3GyAaX05Qy/Pyyg=;
 b=XAYEzpFXHDifxK5+2UzAav+IwPR5rzRGsvBfvB+QLTZRNwoSxFNUsFcnRvURiL6/LwgTdb244ytaIaEbVcL8yQxti3ldJL9vVCM+yzLfZziY4PTFAyhKIG6rrlJDo2H4GQCyK7iccBMH8N6FV8eKbzi/2KN5CXgMVpitBMyy2z4=
Received: from CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10)
 by SJ2PR12MB9007.namprd12.prod.outlook.com (2603:10b6:a03:541::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Tue, 16 Dec
 2025 13:45:40 +0000
Received: from CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::5f77:799a:c1c8:cd04]) by CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::5f77:799a:c1c8:cd04%6]) with mapi id 15.20.9366.009; Tue, 16 Dec 2025
 13:45:40 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tudor Ambarus
 <tudor.ambarus@linaro.org>
CC: Jagan Teki <jagan@amarulasolutions.com>, "Simek, Michal"
 <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, "Erkiaga Elorza, Ibai"
 <ibai.erkiaga-elorza@amd.com>, Vignesh R <vigneshr@ti.com>, "Kummari, Prasad"
 <Prasad.Kummari@amd.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Mutya, Havish" <havish.mutya@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Daassi Bacem <Bacem.Daassi@infineon.com>,
 Shinsuke Okada <Shinsuke.Okada@infineon.com>, Hiroyuki Saito
 <Hiroyuki.Saito2@infineon.com>, Takahiro Kuwano <tkuw584924@gmail.com>
Subject: RE: [PATCH 00/11] mtd: spi-nor: Isolate stacked/parallel support from
 core
Thread-Topic: [PATCH 00/11] mtd: spi-nor: Isolate stacked/parallel support
 from core
Thread-Index: AQHcWRMrXSugh3UOmUCfHXjIgKacX7Ukajnw
Date: Tue, 16 Dec 2025 13:45:40 +0000
Message-ID: <CH0PR12MB5266F135209E332A46DB24DCECAAA@CH0PR12MB5266.namprd12.prod.outlook.com>
References: <20251119-amd-cleanup-v1-0-c555bd85e6e4@infineon.com>
In-Reply-To: <20251119-amd-cleanup-v1-0-c555bd85e6e4@infineon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-16T13:16:27.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5266:EE_|SJ2PR12MB9007:EE_
x-ms-office365-filtering-correlation-id: ebefd7cb-f058-4254-d868-08de3ca966c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UUlpZ09wQkNXQ2Z4cHFmNElCQXR5NlBCZFBMRE01Vy8zc1pKY1lKS05CZVJH?=
 =?utf-8?B?VHh2MFdwUHZ6TUZGNHNZY2EybzVtcElGQk5wTU4yWFMyamFJMDFNdHpPRk1P?=
 =?utf-8?B?cER2T3lLUjZVZU8xNm1VWjlKNDJ2VXBDSW5yMlR2Y1BpeXBTd0NwOXJGVlVW?=
 =?utf-8?B?OWd2R0RubFlwdEIvYlhhWENGa3VlQUVTL3c2ajdmWUxVdVowWGRuVEdjM3N3?=
 =?utf-8?B?V1k5ZEc0YmF6cGpqNnAwa3dHd24rZHlZdTc2cUg5QmMySmhFSzMwQ2FWbU9q?=
 =?utf-8?B?RkZvZjl6YmcyRmY4Q05rQnV1eHFIZHN0KytlYnFDSDAyVWN1YnVrdktPRENJ?=
 =?utf-8?B?VnowbWpnNmVhVHhnMjdOaEJWNDV0NUxzZDA0ZXc1MHg2VXBrSndVZFFnR3c4?=
 =?utf-8?B?QnZURXJ2bmw0K2s2SW8rOVZQYzNiNjZ2bnFvL2xReXZTelJPNzN5YTRoRHpy?=
 =?utf-8?B?cXpzMkFOSmpUMkRYYStTUVVPQzlLdzF0WUx1MEFpaWs0QUZpN1I5ZnV6Um1Y?=
 =?utf-8?B?T1k5V1FvQnl5Q0dobTF6UGYxVldCeTVlZm5xaE1aejllaHRiUU1kL1ZQUXV5?=
 =?utf-8?B?QVo5US95ZmMranVoVWgzeGRkR3dxYzBMNVhONDU3V2pmVHIzK0g5WDdQbloy?=
 =?utf-8?B?RlI1ZWhDSEVFYjh3L2tmbW1oN1owcGZleVQzd3lYdVFRUkkwQzRjYTc2VGFE?=
 =?utf-8?B?amxKUTBHWDZYT0RLU1BUSlpHa0pFYmpBZnl1QWtMR2FNNzBUVVc5K1drWHI4?=
 =?utf-8?B?a2xmOUtsTGlza2FoWnNoaC8xOGR2YllnaGIwV0VacVltMWdWNmRuOXRad0NB?=
 =?utf-8?B?NUFIbzlFMC9wNTNjNjduN1psMzVsTHBXSlBqeFNvRmVtbWJzeWhMa2Y1QVMr?=
 =?utf-8?B?UU93eEFKdFZJOCtpTC9oQlk4K3VyMTFrS3ZSd1FQai9ndy9WM1ROMWhnNXh6?=
 =?utf-8?B?VTBIR2hUWmlkQzAzeUZBaTJaTnFIT0RSN2FLQmFtYmNuSzNkNURBSnBKQndQ?=
 =?utf-8?B?SjlHZytjSkU1ejdjaHV4QURrNzFUazMxSk9zRGtFZndjeVMrNjYraFFJN01W?=
 =?utf-8?B?N0Z4T0IwTkh5WjAybFBvVU5UbFZXclVzKzUzZmRtejFZbTZMbnB5MnJoVFhD?=
 =?utf-8?B?UmZXdGZTT3JidlhiaEg0dWFNUFNSSkdIaTJpT2ZhRk11T216QzNmZkt6Z2w2?=
 =?utf-8?B?ZkJFK2Q1RE9jaWRqN3IyRzhrZlpLamwrU0ZOazdIejJlK21uMENPUWRKOUFl?=
 =?utf-8?B?TEl1ejFZRDFWeVdrMEZUaEVRWkxlY1N2SWUxV1lWZjR5T1Q0dUVIdTVCRDBX?=
 =?utf-8?B?N2cza0VnbThyelhVQUxtRGtCRnZmTk5uZnJ2SFg3dVQrSGFwMkl1V3Rqa3lm?=
 =?utf-8?B?VkR2NThWbnlNTlRrRk1CVVg0Y3pZNVExYlVnK25KN0JTcVpXNjY4bmR6REcy?=
 =?utf-8?B?Q3N5aU1GMWw3ZUpyYmIwT3RITzYrVy96U2szb1IrL0h4RkxBQ1c3NEdvK1p4?=
 =?utf-8?B?bm5DcURGV1REN2w5S0FWek02elJPZ0NGNEExNjQ3ZG1oODZoR2xoeTNicHVX?=
 =?utf-8?B?RE0vT0JOWElCTVpndGhjVEd1NU0vYldZOUVIZWxIdE9EQmFaa1hYSXVNNUZa?=
 =?utf-8?B?NVZjQmN0K3hjMFJybXVhRWtSZ0Y2U0NKZ3ptZ0w3ckRaTnM2eUU1M1JYbVRR?=
 =?utf-8?B?Ry9iT0QrbHdySitmV01Tc3J0ZVBoLzJDZm9xcmcxNVJKY2sxTnM1dndpZmZv?=
 =?utf-8?B?NGRXRzZRcG96bkYzdVBHRFNPUW91ZFZiR3Q4NVVvNXB2b2RSS2VTQ05sUmtP?=
 =?utf-8?B?K1JBUEd6QU4xVkJOQzh1OTRkTDZacnJuSHM4TWkyaEFmYjg4a0ZFT3oyUjhs?=
 =?utf-8?B?R0ZpaktFR0Y4cVBQa1FZZWFQZVM3T1hsbUpyeVFJRmdIR3lpTlE5SWhZQlND?=
 =?utf-8?B?bDdCSEp6R082UkEvMXRjYWlYbE85ZkVybHQ0cVhkNkJtVnFsMnEzdUdMTHps?=
 =?utf-8?B?b3hFd3gwVUtBdm1aZEtkYmE0TDdhMlNlRnVERU0vYXIzN0FwbEJOaG9JOU1x?=
 =?utf-8?Q?4UExkP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5266.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXNtbTgwd05JSkxaNnJhM0R3V2dpZzhlM1M1QUZGWlMyeXJ1eVBWQU5xekdZ?=
 =?utf-8?B?c01rcUNkVXA3eEQ5UlFwRzUwM0ljQ00zWWx4YU14Rnl1OVE0SW9GMU0zaGJy?=
 =?utf-8?B?SStUV3prdWlXSmdEaVhxMnZ6SUxRMXBmVnRmeXJHZmpCdjh1VHZPYkhuUUN5?=
 =?utf-8?B?MGpuQzFROGJQRmZRVmdvRGx1N1ZBd29qYTR0RmV1T09YNTVDSVpPbWdiSzNs?=
 =?utf-8?B?VDhZOWlkZUJFUzhrcnBvWXJpeHhvVW5VMlZ4UEROUlRHblNzK2hSQU1KaWFI?=
 =?utf-8?B?WUZCdkFZWGNXcUtFbjYwM0c3ZnZYZVZ6SnZPUmE4UFBJc2VYL1pqT0JEVVIv?=
 =?utf-8?B?bEhBcHlGd1NPUUlMNFhwY0U5a1lzZHBFQmNFenhCZDBtQXFWNGpKRVpNOFNH?=
 =?utf-8?B?elF5bHF2RVZ6Rk5RSHU5U2ViLzB4NWVrSDdNWkYySlk0K0pBOGRpTEtUcW4y?=
 =?utf-8?B?bHZGaUlabUFwYjRrMi95NnlaaTVXVytOSkNUS1BzSEpsVG50T2UyalE1Nzk1?=
 =?utf-8?B?SjZnYjJweXZNSHNDcHAzT09TNnR6Nm5JR1FKcE85dVdhaVMybDNZTmNPQ2hp?=
 =?utf-8?B?Mk9QQVlvY2o0TUNGK0hCUXROQTBwR3JKK0U0MkNUNVVTcnU0NEk3L2JKZnYr?=
 =?utf-8?B?Z29jSkpkN3l3TDhwcENLQTI2Ky9IYzd5eisxVW16K3RKd3JoMnJDNDUzWnFH?=
 =?utf-8?B?OGltZUpBZ29yMUtPcnhQSzY2VDBoUDVxd1EvNkJKR3R3K1A1VHJ1OHAvU2ow?=
 =?utf-8?B?NjZkNG80WDhZZFJ4Y05wTkVTMC9xT004Mi9SUHdMem1PWmpWSlFFaGFvdGF2?=
 =?utf-8?B?MzNBOEFxUjhnTHFuWFZvaWVrUWdGSlNXQVFOYTJYVXByUWt6MER4aTR1WUZr?=
 =?utf-8?B?enpvZGkwZXV6NVJsam5TTDM2TU9rS2NtTHJMQ1FuRy9FV2g2TFBpQ3ZjV3VR?=
 =?utf-8?B?YzV1T1BUb3ozL29uK2EzKzd5TUY0NlVVUGJpTGlOb2tBZElMb0VqRDRacDBm?=
 =?utf-8?B?ZXBlZTZKMy9xSCtDckI3K3dnemhjRUZGdUZ5SkNQQ2trclNQWkFhQUs1Y2J5?=
 =?utf-8?B?WmplbGNXME40ZEFEN0gzSU9zWTRnZzFRdHo0anhjVk5VYU16TE5wYUNKNDVn?=
 =?utf-8?B?OFB3cFNWcFVZdmxYMnN5K3pWVFpIS2FFRmdRdFgrVFhqbXRVOGF3MmRRNDNO?=
 =?utf-8?B?QUhTZ3ZEVlRRQW5wU0Rwd1RrZXVScnk2Z0N2Q2gyTWVhOXZGNUpFTHo4UzJB?=
 =?utf-8?B?MWJJMlQyb2NwY1pKVzFKZHFMMlpQRFBqUGluMTlWbU53dzJVU2lzRTlJVWpV?=
 =?utf-8?B?eGZvemNEeUcyM1hTZmMrQ21KdlU0cHBIRzZydTl4b1hjQUE3UE1Sc0h2ZStt?=
 =?utf-8?B?RmRHa3l6MTYyM2I3ZDd2eXV2MWg5YUthc2RVcXQ2a1g0MEJKUUdXc1RseGtj?=
 =?utf-8?B?L2IvdzBmam1YLzMzSHg3VXBXb2hpODVZaU9GYnJMTTE1T1lNeUdtWXhzSGls?=
 =?utf-8?B?N0FtQ1A3aEFVWmNVL1ZiRm12QzdNOXlDQ1hoSmRrVWxNRGJsUU5Xdm54eHJX?=
 =?utf-8?B?M3E1NGxSNlp4SW5iTWI2dGJ0MElETElOakJ4ZWR2QWdxOHhiWSt6S21NczFU?=
 =?utf-8?B?TDM0M2d3eS85QWtSbS92ZlFjU3BGZ3NLOGlFamlVb01JMjh4UUIxWmRpRlFX?=
 =?utf-8?B?NzFmcDZ2a0VHeGt4UkxOcTMwOTkzc3pOSUtwcHE4dVBudThNdDhVNndkdHlj?=
 =?utf-8?B?ejFJWnRuYXRaakVQNUwwWFFvd2Q4ZlBYa1U3ZVU2YWh1djlYYWpOODV4d0xs?=
 =?utf-8?B?ZXdCd2JJYXdBeU9xckl2OEhiZWFESVdKN0ZDS3hRSTYvQS9ncHNCR0liZGNV?=
 =?utf-8?B?YS81V3RvR1pqdkZOSUFueTNjR0JLUno3d1VJdzBTMW5CQzlYamhpcXMrSW13?=
 =?utf-8?B?a29jYnlHRDYvMEFpdW1IaHdsZ0RnUGsrVFhFbXpkZ0dsdHRnUDBHeXJ5TWVN?=
 =?utf-8?B?KzlNclVhbXFpb01YN3NaaFBtRVR1dkRKUTZLTUlZcGJtWG5WVkxmQ1AxMGlB?=
 =?utf-8?B?cG1ocS9RSWdTbUNyTFcxbUV4Z25CQUJaaExpS054b1BVbXhCckRVWWtYTDZY?=
 =?utf-8?Q?Dtvs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5266.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebefd7cb-f058-4254-d868-08de3ca966c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 13:45:40.4252 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhU8WANZsFKyM6csORMo4LHiiLQRa9F05y52D5ZfSbiJMRu7VSVoKZ6QB7PINeiXKTftFvYoebOe5+KKIEubZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9007
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
Cg0KSGkgVGFrYWhpcm8gS3V3YW5vLA0KDQpBcG9sb2dpZXMgZm9yIHRoZSBkZWxheSBpbiByZXNw
b25kaW5nIGFuZCB0aGFuayB5b3UgZm9yIHNlbmRpbmcgdGhpcyBwYXRjaCBzZXJpZXMuIFNpbmNl
IHRoZSBjaGFuZ2VzIGFyZSByZWxhdGVkIHRvIG91ciBBTUQgc3RhY2tlZCBhbmQgcGFyYWxsZWwg
Y29uZmlndXJhdGlvbnMsIHdl4oCZbGwgbG9vayBpbnRvIGl0Lg0KDQpUaGFua3MgJiBSZWdhcmRz
DQpQYWRtYXJhbw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFUtQm9v
dCA8dS1ib290LWJvdW5jZXNAbGlzdHMuZGVueC5kZT4gT24gQmVoYWxmIE9mIFRha2FoaXJvIEt1
d2FubyB2aWENCj4gQjQgUmVsYXkNCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxOSwgMjAy
NSAxMDo0MyBBTQ0KPiBUbzogdS1ib290QGxpc3RzLmRlbnguZGU7IFR1ZG9yIEFtYmFydXMgPHR1
ZG9yLmFtYmFydXNAbGluYXJvLm9yZz4NCj4gQ2M6IEphZ2FuIFRla2kgPGphZ2FuQGFtYXJ1bGFz
b2x1dGlvbnMuY29tPjsgU2ltZWssIE1pY2hhbA0KPiA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBU
b20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsgRXJraWFnYSBFbG9yemEsIEliYWkNCj4gPGli
YWkuZXJraWFnYS1lbG9yemFAYW1kLmNvbT47IFZpZ25lc2ggUiA8dmlnbmVzaHJAdGkuY29tPjsg
S3VtbWFyaSwgUHJhc2FkDQo+IDxQcmFzYWQuS3VtbWFyaUBhbWQuY29tPjsgTWFyZWsgVmFzdXQN
Cj4gPG1hcmVrLnZhc3V0K3JlbmVzYXNAbWFpbGJveC5vcmc+OyBNdXR5YSwgSGF2aXNoIDxoYXZp
c2gubXV0eWFAYW1kLmNvbT47DQo+IEFzaG9rIFJlZGR5IFNvbWEgPGFzaG9rLnJlZGR5LnNvbWFA
YW1kLmNvbT47IFZlbmthdGVzaCBZYWRhdiBBYmJhcmFwdQ0KPiA8dmVua2F0ZXNoLmFiYmFyYXB1
QGFtZC5jb20+OyBEYWFzc2kgQmFjZW0NCj4gPEJhY2VtLkRhYXNzaUBpbmZpbmVvbi5jb20+OyBT
aGluc3VrZSBPa2FkYQ0KPiA8U2hpbnN1a2UuT2thZGFAaW5maW5lb24uY29tPjsgSGlyb3l1a2kg
U2FpdG8NCj4gPEhpcm95dWtpLlNhaXRvMkBpbmZpbmVvbi5jb20+OyBUYWthaGlybyBLdXdhbm8g
PHRrdXc1ODQ5MjRAZ21haWwuY29tPjsNCj4gVGFrYWhpcm8gS3V3YW5vIDxUYWthaGlyby5LdXdh
bm9AaW5maW5lb24uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMDAvMTFdIG10ZDogc3BpLW5vcjog
SXNvbGF0ZSBzdGFja2VkL3BhcmFsbGVsIHN1cHBvcnQgZnJvbSBjb3JlDQo+DQo+IFRoaXMgc2Vy
aWVzIHN1Z2dlc3RzIHRvIGlzb2xhdGUgc3RhY2tlZC9wYXJhbGxlbCBzdXBwb3J0IGZyb20gc3Bp
LW5vci1jb3JlIGJ5DQo+IG1vdmluZyB0aGF0IHRvIFNQSSBjb250cm9sbGVycyBhbmQgbmV3IG1v
ZHVsZXMgdW5kZXIgbXRkL3NwaS4NCj4NCj4gVGhlIHBhdGNoc2V0IG1haW5seSBmb2N1c2VzIG9u
IHJlbW92aW5nIHJlZmVyZW5jZXMgdG8gc3RhY2tlZC9wYXJhbGxlbCByZWxhdGVkDQo+IGl0ZW1z
IGZyb20gY29yZS4gVGhlIHN0YWNrZWQvcGFyYWxsZWwgc3VwcG9ydCBsb2dpYyBpdHNlbGYgbWF5
IGhhdmUgcm9vbXMgdG8NCj4gaW1wcm92ZS4gUmV3b3JrIG9yIGZ1cnRoZXIgY2xlYW51cCBpbiBz
dGFja2VkL3BhcmFsbGVsIHN1cHBvcnQgd291bGQgYmUgZG9uZSBieQ0KPiBvdGhlciBwYXRjaGVz
IGFmdGVyIHRoaXMgc2VyaWVzIGlzIGFwcGxpZWQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFRha2Fo
aXJvIEt1d2FubyA8VGFrYWhpcm8uS3V3YW5vQGluZmluZW9uLmNvbT4NCj4gLS0tDQo+IFRha2Fo
aXJvIEt1d2FubyAoMTEpOg0KPiAgICAgICBzcGk6IHp5bnFtcC1ncXNwaTogU2V0IHByaXYtPmlz
X3BhcmFsbGVsIGluIGNoaWxkX3ByZV9wcm9iZSgpDQo+ICAgICAgIHNwaTogenlucW1wX2dxc3Bp
OiBSZW1vdmUgcmVmZXJlbmNlIHRvIFNQSV9YRkVSX0xPV0VSIGZsYWcuDQo+ICAgICAgIHNwaTog
enlucW1wX2dxc3BpOiBSZWFkIHR3byBieXRlcyBvZiBTUiBhbmQgRlNSIGluIHBhcmFsbGVsIG1v
ZGUNCj4gICAgICAgc3BpOiB6eW5xLXFzcGk6IFNldCBwcml2LT5pc19wYXJhbGxlbC9zdGFja2Vk
IGluIGNoaWxkX3ByZV9wcm9iZSgpDQo+ICAgICAgIHNwaTogenlucV9xc3BpOiBSZW1vdmUgcmVm
ZXJlbmNlIHRvIFNQSV9YRkVSX0xPV0VSIGZsYWcuDQo+ICAgICAgIHNwaTogenlucV9xc3BpOiBS
ZWFkIHR3byBieXRlcyBvZiBTUiBhbmQgRlNSIGluIHBhcmFsbGVsIG1vZGUNCj4gICAgICAgbXRk
OiBzcGktbm9yOiBNaWdyYXRlIHN0YWNrZWQvcGFyYWxsZWwgcGFydCB0byBuZXcgbW9kdWxlcw0K
PiAgICAgICBtdGQ6IHNwaS1ub3I6IHN0YWNrZWQ6IENsZWFudXAgc3RhY2tlZC9wYXJhbGxlbCBm
bGFncw0KPiAgICAgICBtdGQ6IHNwaS1ub3I6IHBhcmFsbGVsOiBDbGVhbnVwIHN0YWNrZWQvcGFy
YWxsZWwgZmxhZ3MNCj4gICAgICAgbXRkOiBzcGktbm9yOiBSZXZlcnQgc3RhY2tlZC9wYXJhbGxl
bCByZWxhdGVkIGNvbW1pdHMNCj4gICAgICAgbXRkOiBzcGktbm9yOiBDYWxsIHN0YWNrZWQvcGFy
YWxsZWwgcG9zdCBpbml0IGZpeHVwcw0KPg0KPiAgZHJpdmVycy9tdGQvc3BpL01ha2VmaWxlICAg
ICAgIHwgICA0ICsNCj4gIGRyaXZlcnMvbXRkL3NwaS9wYXJhbGxlbC5jICAgICB8IDQxMg0KPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL210ZC9z
cGkvc2ZfaW50ZXJuYWwuaCAgfCAgMTggKysgIGRyaXZlcnMvbXRkL3NwaS9zcGktbm9yLWNvcmUu
YyB8IDQyMg0KPiArKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAg
ZHJpdmVycy9tdGQvc3BpL3N0YWNrZWQuYyAgICAgIHwgMzg5DQo+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvc3BpL3p5bnFfcXNwaS5jICAgICAgICB8
ICA0NyArKystLQ0KPiAgZHJpdmVycy9zcGkvenlucW1wX2dxc3BpLmMgICAgIHwgIDU1ICsrKyst
LQ0KPiAgaW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5oICAgIHwgIDEwIC0NCj4gIGluY2x1ZGUv
c3BpLmggICAgICAgICAgICAgICAgICB8ICAgMiAtDQo+ICA5IGZpbGVzIGNoYW5nZWQsIDk3MyBp
bnNlcnRpb25zKCspLCAzODYgZGVsZXRpb25zKC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogZTJk
NTFmOGRiMjA3ZjdkYjcwZGQ4MTA0ZmExZGEyY2ZmZGE0MTlmMg0KPiBjaGFuZ2UtaWQ6IDIwMjUx
MTE4LWFtZC1jbGVhbnVwLWM4MDIzODcyZTNjZg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+
IFRha2FoaXJvIEt1d2FubyA8VGFrYWhpcm8uS3V3YW5vQGluZmluZW9uLmNvbT4NCj4NCg0K
