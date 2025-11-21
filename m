Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62349CFA46A
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 02:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 517AF838A5;
	Fri, 21 Nov 2025 03:09:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=unsw.edu.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=unsw.edu.au header.i=@unsw.edu.au header.b="d8yZH+Hy";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=unsw.edu.au header.i=@unsw.edu.au header.b="C4wsm1Fu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 709048042F; Fri, 21 Nov 2025 03:01:00 +0100 (CET)
Received: from mx0b-004a3801.pphosted.com (mx0b-004a3801.pphosted.com
 [148.163.138.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D080D8004F
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 03:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=unsw.edu.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=i.velickovic@unsw.edu.au
Received: from pps.filterd (m0437976.ppops.net [127.0.0.1])
 by mx0b-004a3801.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AL0aZwu775651
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 13:00:53 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unsw.edu.au; h=
 content-type:date:from:message-id:mime-version:subject:to; s=
 pps1; bh=iQckFVniEGw6wR2QXrY97jC9DQp+1/Q1rnuT+qpW37A=; b=d8yZH+H
 y8kdpeRf/U/YK+GaynT8fdhgNzusGnYh4ZoCWmAgpfmajm2n0XyymufeauPanSRj
 GwwhLV29MhdU5/D8XnDofJ7LEZbtJHZcQX2xWLrrYves8pcZTrE9dRN14CrvXEgi
 vsRYDUOIGfPljf8EdiLiWw2DvaZkr4GqRjuTQc6udsAGUEkGtlr/3pHTB8IcELPj
 eXVxmZ+Tr3FNpYl3i36pEdU+C1cfxV51N599di1bZ7qlGNsiSe2uWeXygf31BRXh
 4As+JFrex3fJ2OW+Pp2bJ4d/oaRq91yV/Z8kqiRQvBNQZ4FJxgwyqcLaSgzMWoZC
 wz3Ic15uhI+RBng==
Received: from sy5pr01cu010.outbound.protection.outlook.com
 (mail-australiaeastazon11012050.outbound.protection.outlook.com
 [40.107.40.50])
 by mx0b-004a3801.pphosted.com (PPS) with ESMTPS id 4ahtmpnq1x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 13:00:52 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/C0D1PLt+bTEeKoXe7qrYNjQ3O9+GGtkYJwygXQ9CG/hNJVXke0lqgfoNJ8hTQv9BAwo+LbtH9WaOZxMHxS5qyaP9+yJ2+UHr/a2SsYbfWN4nyfKkbwdQMRtRsSlvxc8B1dkAAb/nChqkzxKcVapB71dGaxDp94DDyY+B2xOH0GqH/DYX9MBydERzLPg5vfNtvjyOXKqYTzjTgVyoI+BHJigJLGMXRohxs4tZbIgprfb/2oAv7amCaevjX6cdeFNn33EmqUClwxdMmfGk1+trHrblFlijcF5YCu86dXxbIRUkgOodT/1Ji+cVTiWy8tYSZKRKdPLoqBhZgBfC8RZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQckFVniEGw6wR2QXrY97jC9DQp+1/Q1rnuT+qpW37A=;
 b=lyf8Apd6fCngihNHWMxH8ivpQHQDDFEncCKME+p3yEGWpFTzkquPFaplg55lIl/rC3c3hJzW7Ao4Z7buaZMpnQKiFs4bhvYIzKcodBFtOHI637vIR0P6Qubvuzl4xO7yhVM8rKcMi7KRpNYKLFHRtCd38gG9QRggejFgmBXW11WEzOzv2A9Ov2ovSYiwG2U43gEdm/oGQcSLJPOAP3kQ127ZioO0CcrbxoU3NZyEVDm/lhwS/UAnL7nWORK2tqX5Oyg4MnTA4BpY42eoCIuUOLiS9i0YpU7jTPDsCUhRxWlkOBLBXcCVx+WA0uSOjyTsVpwXelssC/sZUFxKm5Yehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=unsw.edu.au; dmarc=pass action=none header.from=unsw.edu.au;
 dkim=pass header.d=unsw.edu.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unsw.edu.au;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQckFVniEGw6wR2QXrY97jC9DQp+1/Q1rnuT+qpW37A=;
 b=C4wsm1FuuxpLsw+ehbaK00K+S72WVXK6l6SlnuNqz4pKgs2uqJxzf5gOVzGcvh+R6ixn5EV3d6MZLQeOcE350z9dc9BtFr2CWYYH8mgekmISNrDQpSGQAjeYduTI5bqaS5nyy9gX9DKO7hIS+tml7mMGUyq7vcHJHII3Mh4HLJM=
Received: from SYCPR01MB4015.ausprd01.prod.outlook.com (2603:10c6:10:3e::16)
 by SY3PPF5604A86CA.ausprd01.prod.outlook.com (2603:10c6:18::415) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 02:00:47 +0000
Received: from SYCPR01MB4015.ausprd01.prod.outlook.com
 ([fe80::1706:211f:3cf6:db9a]) by SYCPR01MB4015.ausprd01.prod.outlook.com
 ([fe80::1706:211f:3cf6:db9a%4]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 02:00:47 +0000
From: Ivan Velickovic <i.velickovic@unsw.edu.au>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Query on RISC-V booting ABI
Thread-Topic: Query on RISC-V booting ABI
Thread-Index: AQHcWoqnPcxVeXlo8UeIgjL4hsAmQg==
Date: Fri, 21 Nov 2025 02:00:46 +0000
Message-ID: <000D2537-636F-493E-8E6E-2BC18916A6BD@ad.unsw.edu.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYCPR01MB4015:EE_|SY3PPF5604A86CA:EE_
x-ms-office365-filtering-correlation-id: aa50b85c-d3f0-4edb-7447-08de28a1c990
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|13003099007|8096899003; 
x-microsoft-antispam-message-info: =?utf-8?B?Z0FmdE1waVo2T2Yvd2swU2dFUkVHN0E2YkwwemtKdlJHVVl1ZW1xVktsaTVi?=
 =?utf-8?B?eVdhTEU0TVB1eXBQUHRuNkFSOCtJa1poTnd0RWNPZzVKcHZEVHJXUWNxVFNT?=
 =?utf-8?B?bldULytWQVdPUlFSUC95Q3RFcHlNUlFMUXZZc0o1QlBtR0ZHSFJRT3NjbzA2?=
 =?utf-8?B?MTc4bU5HMWpRZ0lPQkhrQWwwRy9BL3FsTm94NzY2L3RGSDNjR3AyUmtNS0tR?=
 =?utf-8?B?R3RwejB2ck1OYkoyM3kybmRMRzVYL05uN05NNzg5azJneHlhdGN3UjdzRnBC?=
 =?utf-8?B?S2MvdThUUHczaTVRb2RWQWpFQUZsdEZNU1JzTXlpMkoyaTFyL3ZIS0V2M1hQ?=
 =?utf-8?B?QmFGMUtRVFJ0YlExM3luNGtmY2J2bjFnYlhUOGpXZlNPY0tZc2h6ME1qRm9F?=
 =?utf-8?B?VkZFVkppWjVzdklEUDdoR2xTUUxtVUtUN3RvTmgrdkhZZ0E4aDZHNWNVUldj?=
 =?utf-8?B?VXc3bERucTdRLy82Zi96MkJaTjQwSTRsZzhmMmN2RVVERjFieWtjc1ZPdkFD?=
 =?utf-8?B?ZlhVOU5VVFVpY1NRVXJxZURBdi83bmwxaGRxb1ZITjJZYmJFZmwvc083WkFM?=
 =?utf-8?B?R3FHdmIyaU5mOUNCcHd1SXFwd3JJNDZDbXM4ZTBMcmRIbGo0eENFT0JVOFlw?=
 =?utf-8?B?RXZ2WWM5ZDlXN25hTXdiOFVHSEhGeThPQVQzTm9pbWFsZmk5cjM5YVZjS0d6?=
 =?utf-8?B?MUl0dEUvTFJJWkZ5T0FmTndOOUJpODNrbjVHck1wSHB6SStpTzMwTTdxRmhY?=
 =?utf-8?B?cVFudnVJL1M5d014TkdPUDJycnR3YW1ZTlFMOGV1cTVLY1FDbW5NNGxwSkVr?=
 =?utf-8?B?QWFYN3dSdTN6VFYzcGI4MkdDNDlZanZldU1ha3hVcFI5dWhnOXFJZWs1dEpJ?=
 =?utf-8?B?bUhMWlAvc2xEUDFwMllUODFZcUtoOTQwQVJlTHRvd0lCUEo3WE1VS0t0RE9v?=
 =?utf-8?B?QTY0YkR3RUR1T3ZRR0NIYjNHaUllQll6NythUGxBVDNFTWo3UDA5NDVoRkJo?=
 =?utf-8?B?bUVjRzFBSXVRckxRRUpuN05tL05SSmJZMXlyNC9vdGxCbVZFTG1VVno2Z0Ni?=
 =?utf-8?B?UmZMOHo2Y0dMVU1CUFJDMGlHQVdKUDU3NlBtVDNJc1VxNGNGeDlNelBvWWw4?=
 =?utf-8?B?MWgvOCtxK0htOVR1OGMxQ0lNRkp4Smpyc1NBRDB5dnkzZ0Nma2lSVEVhOFBk?=
 =?utf-8?B?V3c0QSt0aytqcm84Q21zd2swWSt0b0pjUUhKdW83TUF0dXJqSjZWS0YrTGI4?=
 =?utf-8?B?WFd1Qjg4TXZSNnV6WXpDRUpZRW5qc3oySWtCOTkwVkRxZmlJM1JnM2tCODQy?=
 =?utf-8?B?ZEtzSW9DYzlOYm8vY1dONERWaExCenhQWGprdUQvb293YmxoWExjQTVNc0Zr?=
 =?utf-8?B?dWo4ckFlVnNOakRmOFFIUC93dXQ0SDhPVDIxQmRBcGpEazV4djBVZGVxVmVp?=
 =?utf-8?B?ZnBMM1ZDb2ZtTURXdUtrQ3JrVk1abU5OLzlkc2xLbHJ5MElCdU10S05NK2Zr?=
 =?utf-8?B?ZDRZNyszRTRFVEdnZks5UWljMlQ1WHZLem8vL29reVdnbkhEMXpmY0s5bzBW?=
 =?utf-8?B?dDkzaGpucWMvOHVkTityVU1FVGFGZndRT05rZXVmQTRBbkJHN3ZiWUwranJY?=
 =?utf-8?B?SlBaVHp6MWtRVGh2eGFrWWh3VG5qVXVER0gxNlZ6KzB2eGZWejBtZFVPWHJp?=
 =?utf-8?B?WndxRkRTR0o2bS85c25nc0hBRUpUQkJiZkpMZ0VkcjU0dmhHQWs1cXV0U3Rq?=
 =?utf-8?B?czN5N2FNN0lxZUZsVEtFWmhXOGs5Q2ZyQkN6WGUrZVRxTEJtS2tFL2xGU1cv?=
 =?utf-8?B?REh4bW05bmczcHVad3VlNHE0U1VwWTIrMmE2K1VYbGFZV0FJMno5eXNpOWRn?=
 =?utf-8?B?enRva0dUcWhKeTJ4RFE1YXdtcWVIcUtPZDVvdUdTNFJ3ZzIySlNveVRzenp3?=
 =?utf-8?B?VEZqa1FtbjBZQmFQUk0yWHJuRERyRFpuZEtJcmtxMG94NmxBaHNBRWU1bHE0?=
 =?utf-8?B?b0Y3ckFOU0I4T2hkVHNUQzJLOVhlMm96OG1JY2FsV0VSMHVuNk5UT1JHZEE4?=
 =?utf-8?Q?YYAQ+B?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SYCPR01MB4015.ausprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VERUU25HQmhCUnltZkpYSXpYQUpQRmtiTit2SWMvK211NXkrZHd3U09Ncisy?=
 =?utf-8?B?RXFaSk1BOUpWWTZpQnFUbFMzRHhlWVF5NkNMSmRzMlZBcG9rZHlqa0lnaVVj?=
 =?utf-8?B?NzJFWXJySlg1Q2FjR3M3SjZHcHl3S2Jwclh5UHdBRG9ZUk5uZkZXUGdJUHNJ?=
 =?utf-8?B?SmpmSzF0SWRBbXc4L0g5Ry8rL1hnaThDQ0ZSVUYvekZVbVlzR2xiS1NXTVR5?=
 =?utf-8?B?Zks4anhBZkQzRVN4bG0vekJHVU0xVzR5NW1yUFg5TFFFOE80N2MwbWZqenNh?=
 =?utf-8?B?S0d1eHBERXVlWlNGakUzQURILzBBdW4zV291VE12QzFHcmRuMnozeEhVZ3p3?=
 =?utf-8?B?TVc3YjJLMitQZjRWMzB2WlAvK2hENnk2dGVnb0lmNWUvR01MZ2RuakM3ZzJi?=
 =?utf-8?B?V2RFK1Buc3YzQWtKMGRwOU5DT0lHV3FneWMrc1J2SGdxM25IVDJBd0NBQ3M3?=
 =?utf-8?B?M2pyTjJDck95cm9GcmJ2SHYxUHpMc2p3blNDTVhveVQ5QmxaKzBjWmV1L2tR?=
 =?utf-8?B?WURETC9icFh5NzFNT1FwSzh4b0l2V0JUM3RxaDB0Z1YwamZaMUduY1ZKQWhU?=
 =?utf-8?B?ZXJrSXY3Q2FPVVJFanh3TzNndDVwN0cvdWw4cjh1cGF1aEpPZXpaK1dEb2tH?=
 =?utf-8?B?UWloU0VCVnlaNzVNb3RyZ241TzMwSk9LU2x0aU1zS2lqTG95STRqUnAyRld4?=
 =?utf-8?B?K0JVWm8yZ1JyUXZtckZHeGJXUzFUb3QzeUVxL1ZyVG9NTHNVTkh4U2tmK1ZD?=
 =?utf-8?B?alNtZ0l6QTRqYUR6UEFGT0lxd0lqN29MODRHMGpCSFlDOUFWSCtaNERMS2o2?=
 =?utf-8?B?Y2oxdFRDVTVUSURBcWtGT3JkaHAvZ0hrT2hRRnBwRHN0V0xlbm5sTHpodzF4?=
 =?utf-8?B?Q1l0aU9ZenpobFhYU2xicDlOLzBPb0d4cERtcXV0RG1lL0xKV0tFU0F2UC9Y?=
 =?utf-8?B?aE85M1VKdGl1NTVBc2V3a0l4ZUVSS3VZdjJWZjhweEk4Z3BFM200TGl0RnlG?=
 =?utf-8?B?TmEvZWZUYVBqdUxhWTRCSUVoRVYrcndKUWJaUWVoR2RSbk45UmNPbVozOGc3?=
 =?utf-8?B?MFV0ZjZac2lLMnNOU3hyYzBWakhOWCt5elpJTE1FbGxJNk9ETGljRGpkcksw?=
 =?utf-8?B?czRESnpEa0d1YXdtdzY1aDA2MFNObzc2a2x5NEZDYStaZkFNRS9jZUprZlBZ?=
 =?utf-8?B?YzdUZ0dQbzZFd2tCWC9XY2MvWkVOWWRCN0dPbFNadEF0VnlRVVJoeDY0Nitl?=
 =?utf-8?B?bFYxTlZMMFdIMkdVcVZHSWFsTTJFZUk2N3FyVVgxMXZoNVpwcDFXWHdzVzln?=
 =?utf-8?B?dktoVjBmNnltKzVuMWZ0N1EwR1lYVXRCbDg4MkNBc2hRNVhBVnV5SVphRnc5?=
 =?utf-8?B?T3NQd0ZmU2ZjajZuVXp2c1phdGpYOC92akRubytHMTFQN0V2d284STNCZ25D?=
 =?utf-8?B?Zml2T21GUVdjTVdZWC9qVEdZOUVsRzQ4WHZaTVBOZXVFZStzSk9hRGt2cUhW?=
 =?utf-8?B?U0ROZ1o4bnFqY0hKajc3czBlMlk1QUpUZDN4ZHhrNCtGL0ZnL1pUNEtBWFQ2?=
 =?utf-8?B?a2VVbnBkYWZkSTcrcGJEaUNzdEkrVEdaZEF4Vm43WmtxZVFuNmZOMHJwS2Ri?=
 =?utf-8?B?bWprWWJ3WTNEMlRielRUb0FZVGZjdkUyYzFMSjNCMlFjMjQyZUc2R1BkRERN?=
 =?utf-8?B?eDV6MXZWS0YzaEw5TlV0RzZ2dy84WmZuRGhKdTlNMTJkaWZXbENHQWVHRVlt?=
 =?utf-8?B?ckpBR3hDRTdWNkFZQ3FySFJLUU4zSnIxckZxeDhwazV5dXpSUkdic1dVSVli?=
 =?utf-8?B?QXc5a2xBZUhYSUhpZUFRLzdUNjRGZDQyZDFXemZIa2t5V2Z0T0lKUjJ2c3Rp?=
 =?utf-8?B?QXQ3UHdULzlScGFCUVFxbTQrSDdjVitUSWxMakJkdzRUdnBabnNheVg1VmdJ?=
 =?utf-8?B?akFsNWhkbFByT2ZxdjFnckVjRlIreTRXais2QUs3SzFwYnpteDhBZlFRVEJl?=
 =?utf-8?B?WUowZittZEYwVzN0SEFOZUl1Mmx4TWlBU1FCY01ELzZNU2lZeUdCUC81dVZW?=
 =?utf-8?B?MFpCVlJnMmIrTDZxYUVPd3F3WmFvZndPSE5HVWNJdlA5U2Uvc3BwVENJT3dS?=
 =?utf-8?B?ZjhpWTRKRmJzSmxxYTNQUDBLNW0wOENHcVE4VHREc3BVTnNCSkQ0QmVLVzBm?=
 =?utf-8?B?eXc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: unsw.edu.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYCPR01MB4015.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa50b85c-d3f0-4edb-7447-08de28a1c990
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 02:00:46.9172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ff6cfa4-e715-48db-b8e1-0867b9f9fba3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dIYaVbKjDdoV00vD6JJtrNjRxHV9YOJeXxBHoNmvdQs8dXXQbP7NmSjUUBNvQ/GrLklhE0vqKCrtPOt9xHIyeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPF5604A86CA
X-Proofpoint-GUID: Mgd6DNfBFmAhW49MAaWJgh5q51Mmdvyo
X-Authority-Analysis: v=2.4 cv=TMRIilla c=1 sm=1 tr=0 ts=691fc7d4 cx=c_pps
 a=SZCutxwynK5XdDG1FqfdWg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=x7bEGLp0ZPQA:10 a=Nz8yn8fW8ScA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XpE1AkgCAAAA:8 a=apn0q0EWAAAA:20 a=gpADgeIW2VticpwZSKUA:9 a=QEXdDO2ut3YA:10
 a=f7nS49b7AjcA:10 a=nH9O1qUWU4RO4MrvwREA:9 a=Hqi7Lu7Sdj4xf0qj:21
 a=_W_S_7VecoQA:10 a=dpZMgbseYPk84XhQl7oQ:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: Mgd6DNfBFmAhW49MAaWJgh5q51Mmdvyo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDAxNCBTYWx0ZWRfXzjHumb6PJob3
 jZq/0Cx1SVba3HHHx7KCcS2QbxVI0yh0BLpramUHKuiIOz9AcsgqhbJCDRC4FHZ1+bs7pM7uEKI
 NJ2TLScqwO6QdVdcmfcGm3xvaAKx2nz8Caxyh4CFlQBrHGYaSdChkQDyYSkT7thvVld6LrZoCsq
 9ZDmXx5B8G3Uc6lM/KOktK8BhAonCVxxyn/VTl2wcMFakMFNwS+x4MOTBzKDjJAOPoYGosydIzz
 RyWxN86PKhbec8lnNOKN01IIb5WcfvLl3iWBZlguYG+cA8IVtWUd79us4ilETDsG0W/R1D9Ngvz
 hO3yQJQSFc8ElxbuwqOurmCfmlkNS+0vwN6rpARxtv7KGzBjeVJ7vx6stMSu7YHwpCeiH1d2vv7
 7EV7kdIXvbYWF7M3H7rhJdou9TSIgw==
X-Mailman-Approved-At: Fri, 21 Nov 2025 03:09:02 +0100
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

SGVsbG8gZXZlcnlvbmUsDQoNCk15IHVuZGVyc3RhbmRpbmcgb2YgdGhlIGdlbmVyYWwgUklTQy1W
IGJvb3RmbG93IEFCSSBpcyB0aGF0IGVhY2ggYm9vdCBzdGFnZSBwcm92aWRlcyB0aGUgaGFydCBJ
RCBhbmQgRFRCDQppbiBhMCBhbmQgYTEgcmVzcGVjdGl2ZWx5LiBGcm9tIFsxXSBJIGNhbiBzZWUg
dGhhdCBVLUJvb3QgYWxzbyBhZGhlcmVzIHRvIHRoYXQuDQoNCkZvciBteSB1c2UtY2FzZSwgSSBh
bSB0eXBpY2FsbHkgYm9vdGluZyBteSBPUy9hcHBsaWNhdGlvbiB3aXRoIFUtQm9vdCB2aWEgdGhl
IGBnb2Agb3IgYGJvb3RlbGZgIGNvbW1hbmRzLg0KSSBiZWxpZXZlIHRoYXQgY3VycmVudGx5IHRo
ZXNlIG1ldGhvZHMgZG8gbm90IGFkaGVyZSB0byB0aGlzIEFCSSwgYW5kIEnigJltIHdvbmRlcmlu
ZyBpZiBzb21lb25lIGNvdWxkIGNsYXJpZnkNCndoZXRoZXIgdGhhdCBpcyBhIG1pc3Rha2Ugb3Ig
aW50ZW50aW9uYWw/DQoNCkkgY2FuIHNlZSB0aGF0IGZvciBgYm9vdG1gIGZvciBMaW51eCBpbWFn
ZXMgZm9yIGV4YW1wbGUsIHRoZSBBQkkgaXMgcHJlc2VydmVkIFsyXS4NCg0KVGhhbmsgeW91LA0K
SXZhbg0KDQpbMV06IGh0dHBzOi8vZG9jcy51LWJvb3Qub3JnL2VuL2xhdGVzdC9hcmNoL3Jpc2N2
Lmh0bWwNClsyXTogaHR0cHM6Ly9naXRodWIuY29tL3UtYm9vdC91LWJvb3QvYmxvYi8yYmMwNzE1
YjU1OGZhMWFjNWM4OGIxMWUyNTA3NDBiMTZhOTA1ODM3L2FyY2gvcmlzY3YvbGliL2Jvb3RtLmMj
TDEwMC4NCg0KDQoNClRoaXMgZW1haWwgYW5kIGFueSBmaWxlcyB0cmFuc21pdHRlZCB3aXRoIGl0
IG1heSBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbi4gSWYgeW91IGJlbGlldmUgeW91
IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBvciBhbnkgb2YgaXRzIGNvbnRlbnRzIGluIGVycm9y
LCBwbGVhc2Ugbm90aWZ5IG1lIGltbWVkaWF0ZWx5IGJ5IHJldHVybiBlbWFpbCBhbmQgZGVzdHJv
eSB0aGlzIGVtYWlsLiBEbyBub3QgdXNlLCBkaXNzZW1pbmF0ZSwgZm9yd2FyZCwgcHJpbnQgb3Ig
Y29weSBhbnkgY29udGVudHMgb2YgYW4gZW1haWwgcmVjZWl2ZWQgaW4gZXJyb3IuDQoNCg==
