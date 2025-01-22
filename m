Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD79C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 04:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59395807A8;
	Wed, 22 Jan 2025 05:35:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VETKLRY9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A13B2806DC; Wed, 22 Jan 2025 05:35:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EA2F80283
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 05:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737520518; x=1769056518;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZIpdmNp+2GI49Jn69/Q5WdqPpUnipDfuD2g26QTDeeQ=;
 b=VETKLRY9N/XYPqcZ8Np8MWrjP2Qe0v8sWDDHeVvZLjM+uRti6K0+NUil
 RpqOkvE9i9qyJ9GFbs9wiaLiCGHd434j/Gs/Zus5SuKi/GttTDwE/j73U
 RJNnqyXyVJWK6ZDlXiqlHIbYHqsGtGTM2fQ9nSeBbips6Vos8zMc3TIdi
 t0hzWLKRXyeLGn8hd2ehyYmePA4KWqLR9VTxlix+JOoeo84yG91FyQkzJ
 igYUm1+mOlk7RBdDlYiEscPTUwpCgrlQR7FW47GGA1IoP8jjapY2NEEWM
 FiV475CET5qs/zRTijQqsElixuTTDtWohquUQ5L/UdmKFo3+/cvNFrV0D A==;
X-CSE-ConnectionGUID: 0D9keAmuRjifocCrxml0Iw==
X-CSE-MsgGUID: BMrQXCrhQ6KU28peFbmr9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="25566694"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; d="scan'208";a="25566694"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 20:35:16 -0800
X-CSE-ConnectionGUID: yWDsG11vSv2I2EJQt2Aoew==
X-CSE-MsgGUID: 7a0NPJb9QRWitf6b9Z41EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="137893247"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jan 2025 20:35:16 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 20:35:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 20:35:16 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 20:35:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7x3xdRrAZJsC+u5A6votAiXZFkg2cNx2wH3EgY20IQWj9Ml262GLnXSnzwQJ3y3S/I6T+4a1ux+KFOI+qw33Y471DbvQg/5KstMDAPpROaavuaBchIV9TsHGkt+6fpY0zd5d+E3dC5japrSlaB42uTKeE9zrOxPkTjRGhSNU5ZRjA7GUaBsl1IPX+qzcT8YJtBWqOjNtV780NHcOhqyNVTvi+agWA/R0wAaV2KIxIjRVCF5dYKDcasritTgm4A1TjqzaptrbbPQE7F4vbsVToYtaY529eY7Xka0lXm3QoTiIYWHvJxjLI8GE7eN4DaasoGVIhVrx0qwwCiag5vW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIpdmNp+2GI49Jn69/Q5WdqPpUnipDfuD2g26QTDeeQ=;
 b=FiI7lFAN+PlA5wF9Ca0e/KhCKjMZYZ4iHwWRMJcLI5D0GmENr5JLhQNMbBJYtO69x8M8Rzq+XryNS+vDqiz+8vuVDVOUlP0byQ6p1UshMIcFNBpeh6sSI0W0vQCk6FRTFgiiNqJEV8usKXR/z5Qf2a2JdzPG8bvHouq6iXCxSyjvz7D2jUYX8EydTUraiIz86Dk/5su4BNhcpzTWBJJbJ55XEMpKTqSxxGxCg7Fm4jzWtLTsrXCqezgMK68tDojN13rTmhV8gYmp2+3FTzgJ4dpY1sH+69Ps1RmXKlp2sN3lsZZQwaZBEmvx6LtKXnVtkpF5TDfvUr6V+wFfG291Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 SA1PR11MB8349.namprd11.prod.outlook.com (2603:10b6:806:383::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 04:35:12 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%4]) with mapi id 15.20.8356.014; Wed, 22 Jan 2025
 04:35:12 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "marex@denx.de" <marex@denx.de>, "simon.k.r.goldschmidt@gmail.com"
 <simon.k.r.goldschmidt@gmail.com>, "sumit.garg@linaro.org"
 <sumit.garg@linaro.org>
CC: "sjg@chromium.org" <sjg@chromium.org>, "xypron.glpk@gmx.de"
 <xypron.glpk@gmx.de>, "michal.simek@amd.com" <michal.simek@amd.com>, "Lim,
 Jit Loon" <jit.loon.lim@intel.com>, "barnas@google.com" <barnas@google.com>,
 "l.rubusch@gmail.com" <l.rubusch@gmail.com>
Subject: RE: [PATCH v4 v5 03/10] ARM: dts: socfpga: add Mercury+ AA1 for
 u-boot dts
Thread-Topic: [PATCH v4 v5 03/10] ARM: dts: socfpga: add Mercury+ AA1 for
 u-boot dts
Thread-Index: AQHbbIbRaKvNIiszZUGiRoP9ziYF1rMiNPyA
Date: Wed, 22 Jan 2025 04:35:12 +0000
Message-ID: <DM8PR11MB55929EF6AD9A39B38967126CD2E12@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20241119224643.27692-4-l.rubusch@gmail.com>
In-Reply-To: <20241119224643.27692-4-l.rubusch@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|SA1PR11MB8349:EE_
x-ms-office365-filtering-correlation-id: f30c783a-f25a-4d4c-7ae4-08dd3a9e28d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Wk5qR0NRYXNJN1ZMVGp6aG12bVZDWS8vRHh2SW5CNnUxMWNrYXpQV0o5Y3RY?=
 =?utf-8?B?cERpNUE2eGprWHEzVmxXT1RLQU9WenliZlRHRUJ5S3RuZDZyRG5Oa1R1allL?=
 =?utf-8?B?bEJUaHZwK2pmUEJ0bkhDdzJ4REVtdWxRSnYvTTFrUTdTWTBPS3ZtcFZJQnVR?=
 =?utf-8?B?VG5EQVgzZmR1ZWRPR1BzclAwSFJraGd5c1F6MkRnWFhlZUl3OW1JSkdoMGwz?=
 =?utf-8?B?aEJUMWZ3VGY0MkVoMWpBMVgzNVg3NDV1SlVISW9CQmdjemZLN3ZKeGRaOFRB?=
 =?utf-8?B?eTNvU0lZcFJRZWZaSk9RbUJiV01tZ1RxZlZ5MnR2bU4rMnZSakJGdXZxR1FX?=
 =?utf-8?B?ZWQ1MXNQWFJOSGhRdTlhbEpKTks0bjd2UDMwWnR1NSsvRFlyYmhkUWwrNEhk?=
 =?utf-8?B?elR3VFVuRXFqZ25ZUHN1bTRwUi8yTFNpZGtVOWxiWDVtYlFkaC9jZE9ORnVG?=
 =?utf-8?B?M1FYTzlqRTdjZWptd1RveFkxVkg4SHJyTEYxVHV6K3J5bHVxYVB4MUZoanNO?=
 =?utf-8?B?Mmg0alhHaGdyNVJLMElRU3h5aWhTc1J5Zm0wRHhxN1pJZWd1dXJTVm5DcUIx?=
 =?utf-8?B?L3VzcUhMVG5SQVAyUFBvS3Z2dFd2NlM1WndvYnY2WHk5dGtNcEwwTWFjbDJ5?=
 =?utf-8?B?dFVsbDhKcCtNVGhRWWRGT2NVVUtYTVpldkVFQ2tuaTU1Z2Zrc2ZUK3dLdWRx?=
 =?utf-8?B?RnZob3dXcGoyOUhOcllveEdUdXRWZEJjbXllUnVsTEJRNDdYdEFpdUFNdWZW?=
 =?utf-8?B?WXdsV2dLN2NiZnFLSmhiQ0pJZSt6UGprUDFtWHBmRC9Ed3N1YUVsU3gxRWhn?=
 =?utf-8?B?REpVSjQ3bFhSK3FyTDRGbDVaZ2c1Szh6VnhJSmEzTVNOVnF3M3FlSjAvNGdL?=
 =?utf-8?B?L1J0bDVQb2pKbEh4V0VuMzl1K0xvY3NBQnhDTnJhejMyYktRNi91dzkzM1RZ?=
 =?utf-8?B?N21HSUhRTDNNdTViSjFSSG4zV0JrOXkzNHU2SmlNd3A0Z1pjSnBacGUrU1BP?=
 =?utf-8?B?Mm1SSXJwa1FNTUVpSW1PQU9SQzNTNGg3N09hRnh6ZUF1ajFpazY2dlQ4ckcr?=
 =?utf-8?B?WjhPWXJJeTlOY1R2RHpMVlZqNlNVd3B6WkUweDhoZlZmbkRkSlVvelB6Rmtu?=
 =?utf-8?B?VWJwcmJkcVBCdlBoZXpoSmp0cEx6OTE4U2xsSDdvVmdadENZZUI2UjNGVHRo?=
 =?utf-8?B?VVhiaUhnRFd2ZER1amIrR3REdnI2bXVjbTI3YUlZNDR5S3JkVHZsVHBhV3J1?=
 =?utf-8?B?anZBOCtYOFdhTEdNeUtlbFFYMERaVWxJTHBuSnZxK1VHaDhGenFOUjlBa1A3?=
 =?utf-8?B?MllGYWJHWlNBdUx4VGlEbWtQTDhuQjU2dlBieG1IaEFBd3huZmtHRVJTUnVS?=
 =?utf-8?B?REhSRTh2cGEzTTN5bVBPLzQ4TlNDZnZCcHJFTGMvMUNBYW54RGVuVUs1Z3Bj?=
 =?utf-8?B?K2lWZUk4S2NKeGFrVUkxRGx5T3Avb3g4RkhkNVNMY3Q2MXhVTWVTK2NHVmFU?=
 =?utf-8?B?T1N0WTg0MVYyWm11SVFzVVF2U0hsTktqN25MTGpKV1VDcUFjaUN5Y3RhSnlU?=
 =?utf-8?B?aC94cHpqUXBRU2xXakRtcXlraVlOTUdqZE5DZ2E2N3YrcERNTGgvS0xrR05v?=
 =?utf-8?B?d2U5bk9sVS9ncy9WQXMvUDVCaEUreU9xb0Vua1dkenZmR1dDNmVkZ2hGM0VY?=
 =?utf-8?B?cm5pdEoxRGlQZVlpdDVDRENjSXdqdndiUWlBajZ0ekFrdXB5SjlrKzVSQ0ZI?=
 =?utf-8?B?UGtSRzJxSWRkMmVuTmRqc28vQzlFcU5VS1k1SzZNRk1relROYUhUakUybURS?=
 =?utf-8?B?TmJNaGE2RnJpSmRMeDZHRzdqWVc0clR2V0wvdC84VG9iL283eXdncCttckxp?=
 =?utf-8?B?ckY5QlVnejRXNHVHQnY4NFR1K01LOWw4cG5tV1BpeWRyK0dsVG1sU1Y1bVdh?=
 =?utf-8?Q?ikheFMNtCd/P6DkE03TqM65YLyrl7nsk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MC94OXR5MUllZURQcWhjcTg1RUNPK3VGZ0xadjBoU3d4U203RHdGcEFIUDR4?=
 =?utf-8?B?S01BbTdSQktXcnFybTgreUgydVI1dEJFbGNNNHkzL2dKRXJDbWFEUFIzaUhm?=
 =?utf-8?B?Z2RWbDBIMS9haDlmd1M2RXE3TTVsbFJNbFlrS2JMTXIyNmYzNURiVTRPTFM5?=
 =?utf-8?B?bU1MQUZOZU1RRDloeG5WdWJDdDU2M1h4QXBlZm90d2VoOEd3a2tGMVRiVlE2?=
 =?utf-8?B?UkRsOVVyZzVkbk5pNllpVmJXWXRKakNIR3VoV096OHc4TjRMWDdxT0I5MW1G?=
 =?utf-8?B?MEVlekRCamxFam9ZcFNkUjVHME9nYkE3Yk1Ec2JvOEhRbkxYRXArTEg2eWlx?=
 =?utf-8?B?UmVIOWVtdFJ6V01jWnA3WTluV1BRckFLb0ZBYVVXRXRBU2Z0cWxNK1lPTkwz?=
 =?utf-8?B?U3NieGJ0U1owTFkxbksyQlJNVmpPR3dwWU9Ec043S1l2MkpDMlRiUTFDbXUz?=
 =?utf-8?B?S2llaVpqa2hjcnZEWGZQZnNGQW5OS21GK1ZJbFhQOG81ZmVVS1REcUdrMys4?=
 =?utf-8?B?TUhROXRoMHdVMmt5bGIwQmdXQytaQVBMV2M1bHVVZnRmbHRkTnZMTVBYc0d0?=
 =?utf-8?B?UitNa3JkSWMxR3pDbTFPbkVUSFNrR2JMWU9jYnNzV1gyNjlMaFprNXlHK1ZL?=
 =?utf-8?B?R092UTFMdHQrYk9BVS9zQjNNckFaWGlhblJhNXZtODlRYWZmVXRvZjZoT2ZW?=
 =?utf-8?B?T1VjTkMrTVE5QlVPWGlocy9EcGhZMENKaThLOTViVHU3SlphRHhnUUltL0ZK?=
 =?utf-8?B?dnR3U2VGVjZUS2RJaUlpWENkQXpybGoyUmN5enY0bFB2L3E3NXBvVEU2U2Rz?=
 =?utf-8?B?M0JwZnMwR1Z4aVMyOGxaSjh2S0gwd240cEpJNHQ3NDhXTldvTFNWbTBOVlBL?=
 =?utf-8?B?WlF2Z3lWendmSGw4dElneWJLZ1VpMFZ3V3UzRmtHSXl6Mk9zSWxQVFpZTVlI?=
 =?utf-8?B?WWRjZTBQSThId2Y4ckhPV21nZ0VlSjI2MWpLc2VibmZadmRERTJvZlRsOUFq?=
 =?utf-8?B?ZE1WUVlRQ1lDUDIvdWh4M29ZUkl1aHVKK213bEwwRU5kZkJkYkJ1dldvaEd5?=
 =?utf-8?B?TEVCRmUxZHZtVzFnRUJzRjcrVlRsOGMyb2hJZTFrbnVBOU5TU2hzV1ZHc3ZH?=
 =?utf-8?B?cHpkQVZCUk03SmRUV2EvV1pobHp1MVJjcFJ3Q1VpT3pnTXJNWWxjV2ZQOFFk?=
 =?utf-8?B?ZC9MR1Z0THpOczJUNHQ2Q0ZtcU0rekhDVzBwOGZ1Ri9IYlVoQjVuT2VBYW9O?=
 =?utf-8?B?ME5EMU50TU9vd0s2dWowNlhnVlhIaTJMZy9XdVBObWFtVEVybktlUGxUbC95?=
 =?utf-8?B?U3JCZlZtOUhlT1RNU0NZcXAyTDR2emFVdG1kRmYvVTVDcXhmNHFCQmZtTjk1?=
 =?utf-8?B?OFpGOVdNYUtPcHVZTFVJcmMxOEt5dDgwT2JHWU9Qa0U3VzRmdlVUU2xJbVJY?=
 =?utf-8?B?L0xLTnJxNjBERGJ0VWJJbkIxZytOSk5WYUJlMHFRbzlVSlg5REhRdERDMkw2?=
 =?utf-8?B?N0xFcitRZ3pYNWRtVlQ0N3FsM2RjdFRFZFpMUjB6SmtRaVAvNlhUbFJCTmwv?=
 =?utf-8?B?c29CbGRZVzBDdEdlcmF5b3VaNVBEM09lMHliNUFqWmthdGpFazYxMnFodlY1?=
 =?utf-8?B?THlPTERVM1RrNnhKL1hKelMrWmJGUHJJUU4xWlFnQXlSejMzNHBCeUlhSElt?=
 =?utf-8?B?N2twaGxSa3NTSGVGK2hHK3czRnBBU2pCVDNtOFdzdmdYbjJQY25Cd2owMGJj?=
 =?utf-8?B?RE1SOFcweWZ3Z1JpMytOekRvV2dYdEt0dTM0NjNVSVpmTHA2M0VVRHRwelVI?=
 =?utf-8?B?a2xQbEF0ajVZZUpFUEZYRGtkZXhzWUdRL1lYcGZwNDZyWDdjbzhXSXQ4SnN4?=
 =?utf-8?B?VEhENWNKazVlVFdqRlhGNEFjU1hTNFFzZnVHNm82N2JiRCtub0xzM0pIcCtv?=
 =?utf-8?B?Z3BaeHJiMmJHd3ZER243R0VrdjVqczB4cWF6bnZzMm5MeDB0TU9hbmpnblIz?=
 =?utf-8?B?STJkU1YySEJIUTh0UzN6d3dTL3BMTVpCTFBveGUrS2pLVTFJRS91UHl5NVlM?=
 =?utf-8?B?KzlGZEd0WW9LS0R4V1kwczFrSFBBalBDdUJoSHRrcU5uUGtnMzNtei8yZnZR?=
 =?utf-8?Q?KwpmKlFDC2dDXfQcPSNTp+1RW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30c783a-f25a-4d4c-7ae4-08dd3a9e28d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 04:35:12.0283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CVRUIE8am/VNDxSAhQRyqBoSZ2+x456LA9HwCW2CZCxf0AlIDZ6cfnTVuzUVbwKMlJsWhKJPQwsZwLjaol/qkf4DuiRAnY+dSCibOyYZF8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8349
X-OriginatorOrg: intel.com
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVS1Cb290IDx1LWJv
b3QtYm91bmNlc0BsaXN0cy5kZW54LmRlPiBPbiBCZWhhbGYgT2YgTG90aGFyIFJ1YnVzY2gNCj4g
PGwucnVidXNjaEBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjAsIDIw
MjQgNjo0NyBBTQ0KPiBUbzogdS1ib290QGxpc3RzLmRlbnguZGU7IHRyaW5pQGtvbnN1bGtvLmNv
bTsgbWFyZXhAZGVueC5kZTsNCj4gc2ltb24uay5yLmdvbGRzY2htaWR0QGdtYWlsLmNvbTsgdGll
bi5mb25nLmNoZWVAaW50ZWwuY29tOw0KPiBzdW1pdC5nYXJnQGxpbmFyby5vcmcNCj4gQ2M6IHNq
Z0BjaHJvbWl1bS5vcmc7IHh5cHJvbi5nbHBrQGdteC5kZTsgbWljaGFsLnNpbWVrQGFtZC5jb207
DQo+IGppdC5sb29uLmxpbUBpbnRlbC5jb207IGJhcm5hc0Bnb29nbGUuY29tOyBsLnJ1YnVzY2hA
Z21haWwuY29tDQo+IFN1YmplY3Q6IFtQQVRDSCB2NCB2NSAwMy8xMF0gQVJNOiBkdHM6IHNvY2Zw
Z2E6IGFkZCBNZXJjdXJ5KyBBQTEgZm9yIHUtDQo+IGJvb3QgZHRzDQo+IA0KPiBJbnRyb2R1Y2Ug
dS1ib290IHNwZWNpZmljIGRldmljZS10cmVlIGZpbGVzIGZvciBFbmNsdXN0cmEgTWVyY3VyeSsg
QUExIFNvTXMNCj4gKEludGVsL2FycmlhMTApLg0KPiANCj4gR2VuZXJpYyBkZXZpY2UtdHJlZSBm
cmFnbWVudHMgZm9yIGxpbnV4IGFuZCBVLWJvb3Qgc2hhbGwgYmUgcHJvdmlkZWQgaW4NCj4gZHRz
L3Vwc3RyZWFtLiBUaGUgc2VsZWN0aW9uIG9mIHRoZSBnZW5lcmljIGRldmljZS10cmVlIGZyYWdt
ZW50cyBkZXBlbmRzDQo+IG9uIGEgc2VsZWN0ZWQgYm9vdC1tb2RlIGFuZCBhIHNlbGVjdGVkIGNh
cnJpZXIgYm9hcmQuDQo+IA0KPiBPbiBJbnRlbC9BcnJpYTEwIGEgaGFuZG9mZiBzZXR1cCBpcyBu
ZWVkZWQgZm9yIGluaXRpYWxpemF0aW9uIG9mIHZhcmlvdXMgY2xvY2sgLw0KPiBwaW5tdXggLyBE
UkFNIHNldHRpbmdzIG9ubHkgdXNlZCBieSBVLUJvb3QgcHJvdmlkZWQgYnkgdGhlIGN1cnJlbnQg
cGF0Y2guDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWFzIEJ1ZXJrbGVyIDxhbmRyZWFzLmJ1
ZXJrbGVyQGVuY2x1c3RyYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IExvdGhhciBSdWJ1c2NoIDxs
LnJ1YnVzY2hAZ21haWwuY29tPg0KPiAtLS0NCj4gIC4uLl9hcnJpYTEwX2VuY2x1c3RyYV9tZXJj
dXJ5X2FhMS11LWJvb3QuZHRzaSB8ICA0NQ0KPiArKysgIC4uLi9zb2NmcGdhX2FycmlhMTBfZW5j
bHVzdHJhX21lcmN1cnlfYWExLmR0cyB8ICA0NSArKysNCj4gIC4uLi9zb2NmcGdhX2FycmlhMTBf
bWVyY3VyeV9hYTEtdS1ib290LmR0c2kgICB8ICAxOSArKw0KPiAgLi4uL2R0cy9zb2NmcGdhX2Fy
cmlhMTBfbWVyY3VyeV9hYTFfaGFuZG9mZi5oIHwgMzA1DQo+ICsrKysrKysrKysrKysrKysrKw0K
PiAgYm9hcmQvZW5jbHVzdHJhL21lcmN1cnlfYWExL0tjb25maWcgICAgICAgICAgIHwgIDM3ICsr
Kw0KPiAgYm9hcmQvZW5jbHVzdHJhL21lcmN1cnlfYWExL01BSU5UQUlORVJTICAgICAgIHwgICAy
ICsNCj4gIDYgZmlsZXMgY2hhbmdlZCwgNDUzIGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBhcmNoL2FybS9kdHMvc29jZnBnYV9hcnJpYTEwX2VuY2x1c3RyYV9tZXJjdXJ5X2Fh
MS0NCj4gdS1ib290LmR0c2kNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBhcmNoL2FybS9kdHMv
c29jZnBnYV9hcnJpYTEwX2VuY2x1c3RyYV9tZXJjdXJ5X2FhMS5kdHMNCj4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBhcmNoL2FybS9kdHMvc29jZnBnYV9hcnJpYTEwX21lcmN1cnlfYWExX2hhbmRvZmYu
aA0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0cy9zb2NmcGdhX2FycmlhMTBfZW5jbHVz
dHJhX21lcmN1cnlfYWExLXUtDQo+IGJvb3QuZHRzaSBiL2FyY2gvYXJtL2R0cy9zb2NmcGdhX2Fy
cmlhMTBfZW5jbHVzdHJhX21lcmN1cnlfYWExLXUtDQo+IGJvb3QuZHRzaQ0KPiBuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwLi42ZTM4Mjg2NTcyDQo+IC0tLSAvZGV2L251
bGwNCj4gKysrIGIvYXJjaC9hcm0vZHRzL3NvY2ZwZ2FfYXJyaWExMF9lbmNsdXN0cmFfbWVyY3Vy
eV9hYTEtdS1ib290LmR0c2kNCj4gQEAgLTAsMCArMSw0NSBAQA0KPiArLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjArIE9SIE1JVA0KPiArLyoNCj4gKyAqIENvcHlyaWdodCAoQykg
MjAyNCBMb3RoYXIgUnVidXNjaCA8bC5ydWJ1c2NoQGdtYWlsLmNvbT4gICovDQo+ICsNCj4gKy8q
IEFycmlhMTAgaGFuZG9mZiAodS1ib290KSAqLw0KPiArI2luY2x1ZGUgInNvY2ZwZ2FfYXJyaWEx
MF9tZXJjdXJ5X2FhMV9oYW5kb2ZmLmgiDQo+ICsjaW5jbHVkZSAic29jZnBnYV9hcnJpYTEwLWhh
bmRvZmYuZHRzaSINCj4gKyNpbmNsdWRlICJzb2NmcGdhX2FycmlhMTBfaGFuZG9mZl91LWJvb3Qu
ZHRzaSINCj4gKyNpbmNsdWRlICJzb2NmcGdhX2FycmlhMTBfbWVyY3VyeV9hYTEtdS1ib290LmR0
c2kiDQo+ICsNCj4gKy8qIFNwZWNpZmljIGJvb3QtbW9kZSAodS1ib290KSAqLw0KPiArI2lmIElT
X0VOQUJMRUQoQ09ORklHX0VOQ0xVU1RSQV9TRE1NQykgfHwNCj4gK0lTX0VOQUJMRUQoQ09ORklH
X0VOQ0xVU1RSQV9FTU1DKQ0KPiArDQo+ICsvIHsNCj4gKwlmc19sb2FkZXIwOiBmcy1sb2FkZXIg
ew0KPiArCQlib290cGgtYWxsOw0KPiArCQljb21wYXRpYmxlID0gInUtYm9vdCxmcy1sb2FkZXIi
Ow0KPiArCQlwaGFuZGxlcGFydCA9IDwmbW1jIDE+Ow0KPiArCX07DQo+ICt9Ow0KPiArDQo+ICsm
ZnBnYV9tZ3Igew0KPiArCWJvb3RwaC1hbGw7DQo+ICsJZmlybXdhcmUtbG9hZGVyID0gPCZmc19s
b2FkZXIwPjsNCj4gKwlhbHRyLGJpdHN0cmVhbSA9ICJmcGdhLml0YiI7DQo+ICt9Ow0KPiArDQo+
ICsjZWxpZiBJU19FTkFCTEVEKENPTkZJR19FTkNMVVNUUkFfUVNQSSkNCj4gKw0KPiArLyB7DQo+
ICsJZnNfbG9hZGVyMDogZnMtbG9hZGVyIHsNCj4gKwkJYm9vdHBoLWFsbDsNCj4gKwkJY29tcGF0
aWJsZSA9ICJ1LWJvb3QsZnMtbG9hZGVyIjsNCj4gKwkJc2Zjb25maWcgPSA8MCAwIDUwMDAwMDAw
IDM+Ow0KDQpUaGUgUkFXIHJlYWQgaW1wbGVtZW50YXRpb24gZm9yIGZzX2xvYWRlciBpcyBub3Qg
dXBzdHJlYW0geWV0LCBJIGFmcmFpZCB0aGlzIG1pZ2h0IG5vdCB3b3JraW5nLCB5b3Ugd2FudCBo
ZWxwIHRvIHVwc3RyZWFtPw0KDQpbLi4uXQ0KDQpCZXN0IHJlZ2FyZHMsDQpURg0K
