Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D25DC5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 05:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A00781F0D;
	Wed,  4 Jun 2025 07:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="du0mOcEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFD2E81FEE; Wed,  4 Jun 2025 07:59:50 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E180E81E72
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 07:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+9e2dB+KqXjgpCLqutw00gd6ib1yS9p7nvBRHpkJ6DXRO+ceINwvsgMBFjDEPiFqdkNrHbSvVxeQdsaZFm0fI/TWrwVFEUpMiLJyY0smZoazcZZyiUQ4kZ3xL6O4t4TNesChIvDQVlqQWuSXttYDiPaHwFFWQzS9S0biehR6zIzeEn4WlhHPmjFTanYBXJtrTq9xA4lQsxjjmSqgHQssNA1eik+kut34DuqMkqr1ldanNeAdmQ9lkK/dggYKLdILKq8SCSkBenXSyf5RH9is0x+TjXibWrpJXsSC3Ja2qfDAKA3wcrAYBmHiN441wNcNlHjbQkhmA/ekBdkY0rGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49B3g+A+hB29wYGRIlIIZfTW+rm306YDZnuNoFvPmj8=;
 b=OAPdVg99xLckYJHf3eM4cNHRulwZUp6EDyaNkb7cZ4WUImns1cOs18oUkpcH94HF1YGFUt+k0D2+aTnpZCWf+HnJP94ZJXxH4RUQoYFffLU6aZXw8d14bC39LE7pgvldN4RoQjNaK0xE9iS+UpoIE2pauQ64cZwdrXYOStWt+MloAytLrvW1RQybUvPUGQF0jOwCWMYsNAlKGGEy5MEDy5E9rYuKMuOm2VAa6Y0pixp74WP4OJjH3kxmPjFn40LViBx6UZ9q8CqarwYGlmx5XFlP+kowQs1Y9NwnNPOw3urq26TTfLN28iPRBYrRWjeW3dCWw6jBgAcpxsEXb38kzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49B3g+A+hB29wYGRIlIIZfTW+rm306YDZnuNoFvPmj8=;
 b=du0mOcEZvDI6RTYJruTh44+dgLK2q3LjqqItRlvFkK3vg2TeGZrQAYLM3zpeq2c9Hd7xaJ0uS3UpsMqfqdcJ/UvJEn9ztfkKI1akQ7wdq8I6IXhrvw6GXa6CSxVR8GQW84MhBbpsBWcBUeODETgMi8v3km0Qmz6+lGXrpaK33Ls=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 05:59:42 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%7]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 05:59:42 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: "hs@denx.de" <hs@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Simon Glass <sjg@chromium.org>
CC: "Simek, Michal" <michal.simek@amd.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH] i2c: mux: Fix the crash when the i2c-arbitrator node is
 present
Thread-Topic: [PATCH] i2c: mux: Fix the crash when the i2c-arbitrator node is
 present
Thread-Index: AQHbz356yVYZKTVOZ0GdNKuglyzjFLPnyJAAgAAKqwCACrkfsA==
Date: Wed, 4 Jun 2025 05:59:42 +0000
Message-ID: <SA1PR12MB86971269D32549C5793A9F7F986CA@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20250528031255.1762438-1-venkatesh.abbarapu@amd.com>
 <0f2037cd-3bfc-bc50-79e0-e84d8bf6766b@denx.de>
 <SA1PR12MB8697D1BE095030270EE6B1FD9867A@SA1PR12MB8697.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB8697D1BE095030270EE6B1FD9867A@SA1PR12MB8697.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: sjg@chromium.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bafe6c70-f625-4b3f-9e7f-623e54bbe333;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-28T10:13:09Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|SJ2PR12MB7917:EE_
x-ms-office365-filtering-correlation-id: 3b35484b-7655-4534-60f9-08dda32d001a
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TjErQ2ZFQ3RtTEx4UElKN0RldVlvaWtWQ0VwNTBlVFZFOVozYXd4V1dNaElq?=
 =?utf-8?B?bW9HN0tnMzNvanFJdCtSS1JETlpDeE9vZnRKVjVDZ1R6TXh6SlFPb3hrblJ0?=
 =?utf-8?B?ZHhPV1RSdU9OeEViTGYxdENrT2xwWk1pT3Y4MFF6WFVYRHByckE4Wndvem1V?=
 =?utf-8?B?WHp5WDQwWlE2VzJKQUljK25TV3ZzZW16MmNKditUNXd1dCt0aUZqVmN5ZG9K?=
 =?utf-8?B?SlYvb1V2WUVGMDN2R2dHTWNXaGQ0L0l5azdRZ3VTc1A1N1dDQTRYczR1a1Na?=
 =?utf-8?B?NjNodndHOUtaWHBPSTEvQXBUUGRFcnN6SE0zN293TDlMZmJXSnpFSVROWS80?=
 =?utf-8?B?eTRlRURON3NUb0pwN2xNcEZESjFqKzEyRXZvTWV0L2hCZGJVMndlT3ZDSWJz?=
 =?utf-8?B?RU40N29hbXB5dm9sNEk2eXRmVCtCMlp0ZmVqS2xpQzhBWDNvMkp4aVc4VkJD?=
 =?utf-8?B?Z3VNbFR2YkJXb1ZrMW1VczlZNDVTaG9aWGJ0NWJHc0x6MWMxaUlOZzFJSUtI?=
 =?utf-8?B?aU1uR2o5MGdlWmZXOVZzM2RFbkJQZzRnZlJpVDZUeldvd3V3WXBoYVMxSzY2?=
 =?utf-8?B?SElFWG5tWjUwSG1Jam04bzM1SlNNN2UxeE9zQ1ZJeTZCZjVsYTltSDM0UUhY?=
 =?utf-8?B?V256RnFUMHdhaTUzdEJsbFd4M0V4bk5Na3RwTEJjelhtaHo1aktPYngxMU16?=
 =?utf-8?B?Y3VXNm1ubC93VFdtTlVaWjN0bzRjd0xodnRrQlBjSC9JWHUzK1ljbXhXNU5W?=
 =?utf-8?B?My9xam1yTGwwazVsamFUS3ZneTRxU0pFdjRiN0E5ZWdVZHBPWTcrUnVTRzAr?=
 =?utf-8?B?UE52eHFMZVlQQXRHKzhkZUV3b2lWNCtoRFo5MlQ4NE1zOFp2SUJqQUV6WDV2?=
 =?utf-8?B?Tmc3N2ZvVk9IUkVaYXZCUCs4bkJ6aVZKUkZlQTBVZXo5cXB1T0NFWHZydWNC?=
 =?utf-8?B?SEtxT0JUMUhMS1hlODdkcGNwdUpUTFlPdnl3YUxTRFdXaUIybjhnSnk4eUhu?=
 =?utf-8?B?NEpLd3I2NHdZcksxRWFTUVBQUE5MQm9sRDlLREJZREZ3SGJWNU90bzRnY1NQ?=
 =?utf-8?B?UmRSKzZwdHBzYlNoMjluWVZDS216RGJ4a25ZcHMzRFBsM3pQTXEzNUpJbm9J?=
 =?utf-8?B?R1RnTC9XMkxBRXU3VFdPTFArMzdBMDQyTEZjS0FkY1NUTTU2Q0FZT3RFV0Z0?=
 =?utf-8?B?R0RBbEt5V1FVWmw4SmZRbkx2YzAxS2JXNVBWd1lhWDhqd2JQVWVyVnk3ZFFL?=
 =?utf-8?B?Y0diNWhBRVVic05Cc01mMU5EQ1VUcy96TThXM2s3eGpzT24vRFpaUnRRMDZt?=
 =?utf-8?B?N1NpNmVhb0VXZ1NsRFRzdTU2NjJVUllvZVFjeVdnaVI2VjNmWnY4cy9CZ0RD?=
 =?utf-8?B?L2R6bFNxeWJ4YWxLSURDbWpiUVcxcE56ejFWaHJNZXNYSWkwRmlNMko5TmYv?=
 =?utf-8?B?YTlIYngxcU8vcElTblpva2I5Yk15THpmWW5RSEpjUjhiMHZsdnRhR3l4bzNZ?=
 =?utf-8?B?eWlpL3RsUmdYbitZQkY1RThVdEtzeTBMdzJVdk9KSUhiNmZ5R29CMG93MCt1?=
 =?utf-8?B?ZlJCbjJ0VGJ1akRTVnFONnVHblF4MXVhV2g3U045ZkpzTHdUV3Vmb2JsTm1n?=
 =?utf-8?B?N2o4KzhpUmFGRUpWaHBxR01YMkUvc094eHlkTmIzdkFwZkFaVEZpRFRRYm9N?=
 =?utf-8?B?QWtLODZDZ3c4UDE3Yzh6elV6TGQwS1MyRWdjTTVCaWw0MUtJRFM2MDRMVWNu?=
 =?utf-8?B?TWozWGtYZVlqQ0xuVXh4YVJjM0g3d1dleU9MMXdxa29iN0Fqai9yRVpsMnNo?=
 =?utf-8?B?YXVBTDkxdk1DU3Y2R1d1UHVOUWdaeE5RRWpCSWFEZlE3MWl5NW5sVWNvVXhJ?=
 =?utf-8?B?d1pmRGN3VU9keUZ5YnZpUkxsMGRDQXM2UnkrU0NsaWI5VE5zb3ZxOUJzbWsw?=
 =?utf-8?B?NERMelNVbWJJckhHdEJWOSt4aERQSUFYTjIza25zbDVVWUljaVpSalA1d1Qz?=
 =?utf-8?Q?vxs+asMTahp5KxyEz89m4KXQigzSSE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2oxYXRGY3JNcWFkOW1zKy85RmttSHpPZnVtUVpIMFRQZ0ZrbnVpMkNkZ3Zu?=
 =?utf-8?B?dFNNTmloWDJCYm93NTFnc1NBNFk2Wjk2WjVZYXpzb0JjbExhTWlmdnZTdVBN?=
 =?utf-8?B?eThweEM5Nys0MVFLME9URUxZOHZFRzhSSHF3VnkxalFtYVFwdDRJeWJQNHRw?=
 =?utf-8?B?SHJyV2VCNktGcU94bkxuZmlybVY1WmhKamJ1bThhSHd5eEVuWUtIamRXVEdT?=
 =?utf-8?B?NmRLbVExMEtUZEVWZGRad1REcm02anFEUkFZSzV6MUR5ZkJ0a0VEN2l0amlp?=
 =?utf-8?B?cG4zMUk1VlBvYUUvZEVQODhtTm03VFJyOWtxbFZwTzRCQTA1S1p1MlV4NGJV?=
 =?utf-8?B?Q2o2NUVJWlhYS2lFK3hQRlBoNVIyUzEvTGFkSGkxVER3TzRScGJIOG4zYjZz?=
 =?utf-8?B?SjlWQVg0UGNROGpGS1ZnTDBPa25xaGFTVFlpQVhDZTNrR2hwakl0KzFGRGNR?=
 =?utf-8?B?clR2cmFBVFZEVW9IR3B0eFFFMU5GU00yVkhRS3ZtMnFxenlHVEVpQ2M3SzhY?=
 =?utf-8?B?bVpsTklUdFpvNnlSdkV2MUorZ1JmRUtxdmdWejhxbThSeXRSQk5sQUZTeC9p?=
 =?utf-8?B?M3piOWhQSVViTU1oN2ljeWdrK1FCSFdVMUlDV2RvRlRWdTd4c3dsUGtXWDRw?=
 =?utf-8?B?Z0VqS1dWS0RjOUFmcDhxNmtZR2lWUlJjVVhFN0NYZ2dUL05iWFVDSXlaSmky?=
 =?utf-8?B?c2J0eUYvdHpwM0xwTFQwa045QTc0MDI3eDZtSXNrWVRmTU0xUi9xSUVSb2VI?=
 =?utf-8?B?dkwwZW1lRnozdzkvQUNRWHdqV0NGdk5IOWMwdkUzS3NrSUJXeGQxditkQlMx?=
 =?utf-8?B?ZkR5UXhGZi9yMDBPNHF5b05SNk5MaW04eWMrMGxyVUQxbnQvYUdPWWxGWkto?=
 =?utf-8?B?YXZpdlFQTk92ckxuSVlDYkJPdEdLelpibUZXQ1RnVmphU05QMTZON2tScXRL?=
 =?utf-8?B?eTFPbEYveTZKQVpReUM5b0YxeTdkc1lCWWlsMjh3SURCVU5PenJZM2dpVmRW?=
 =?utf-8?B?V21kUFhEUEQyNGhuck5lSWFLcnd4S0xaTUJDREpjdFQxdk9kazJMaTZqYW55?=
 =?utf-8?B?SGRJSTZndDM2WDR0RCtIUlI2aVdia1c4bzF1SEQ1RnFGc0VjR3pCRzdDejFm?=
 =?utf-8?B?RmlCMi81VDB0Y2liMVo5ZDNyc3V1SXU2aHZneXcra0U0Y0V0NVBsZVoxampG?=
 =?utf-8?B?N1k0dVVXTWl5Z0p6dENWaFp6VTc3ZElHdVNRQUd6M04yVjJjYzMzdzNWTkhp?=
 =?utf-8?B?TE9lK09vaDZnZUdmMmFvR0dTeEJLM1VKTW5sUkhkTWQveHpNZEFkS1p3VTVU?=
 =?utf-8?B?QWUwL3U1TXFkcUpsczN4Z0pITENsNTFoLzRxTXh4V3NlS2JyblF5SHBpRlZx?=
 =?utf-8?B?TTErUzVtcG5GSDF3VFBnVkVGVG9sdzhXbmFIQUYrK1BOcy9YeHNLY0ZSdFJH?=
 =?utf-8?B?UXcrSU5TR01Ka3ZYdzQ4YW5rODNORnZUdllBNnEzSi9paUVOQ2ZET1puRmJi?=
 =?utf-8?B?akQrY3FPdFpTaFJzNUtzd3A0a0J6TXNVU2c0cGRZYUg5S2N1ZWc3T0xseFJU?=
 =?utf-8?B?bUlyMlR5enYydkNpWlE2d2p3NHdHKy8wR3RtT0hkSmVRTXhINC9LV3FxWGxS?=
 =?utf-8?B?dUZBT0dTVmxzTUNBcGVlUDZVVzF1OW5mOWJjZWs0MnZJVTI4b2VRVUJ6ckEy?=
 =?utf-8?B?cnN6WVF3amM3TDJqTjQ2QnA3UGZqNzY1dHZvMHRNbjZWZmVJVDBCZGR2TmZD?=
 =?utf-8?B?enQ3K1lpK2VTZ2pOZUR3VGNiVngveW1RcUR0cWJkbWlnMmJERmNBcEhaeUtF?=
 =?utf-8?B?d2d2Z2tVNE5tZTUvQkpWdG9LdS9vSEFyN1Z4RWdhVmQydUZUSmZ4dXRtZElp?=
 =?utf-8?B?YnZjMEpaSE52NEJGR1dpVlMyVG9aSUcwckdDdEQyZFVWTlZpbHIvMTFkaVBa?=
 =?utf-8?B?NkY4SHdqblhYM0Y5V0tDMkdzUWgyeDJ3aEN6NjRlbXRhbGZxdEpTaE9ramVZ?=
 =?utf-8?B?d1VhbEpTY1pGaGlmN2xjakx6WHhNN0dRaVNSK1gzekxtZ3d1YithdVd6Z2hU?=
 =?utf-8?B?a2k2MHVZek1FZm9QNnhpTTFHV2wyUkl4QkI2SGZlcm85QlBjSXNNeHpyTUtL?=
 =?utf-8?Q?6xDY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b35484b-7655-4534-60f9-08dda32d001a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 05:59:42.6885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7Ow+mo7zIsH69dyCo7by0/jnBJSe9KXIdUQsfvONJf1w7yuFyjk9B+A8k5jxpnF1BqRwtObZpN2GNh8Tzc/pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917
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
Cg0KSGkgQFNpbW9uIEdsYXNzLA0KRG8geW91IGhhdmUgYW55IGZlZWRiYWNrIG9uIHRoaXM/DQoN
ClRoYW5rcw0KVmVua2F0ZXNoDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEFiYmFyYXB1LCBWZW5rYXRlc2ggPHZlbmthdGVzaC5hYmJhcmFwdUBhbWQuY29tPg0KPiBTZW50
OiBXZWRuZXNkYXksIE1heSAyOCwgMjAyNSAzOjQ3IFBNDQo+IFRvOiBoc0BkZW54LmRlOyB1LWJv
b3RAbGlzdHMuZGVueC5kZTsgU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IENjOiBT
aW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IHRyaW5pQGtvbnN1bGtvLmNvbTsg
Z2l0IChBTUQtWGlsaW54KQ0KPiA8Z2l0QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hd
IGkyYzogbXV4OiBGaXggdGhlIGNyYXNoIHdoZW4gdGhlIGkyYy1hcmJpdHJhdG9yIG5vZGUgaXMg
cHJlc2VudA0KPg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3Ry
aWJ1dGlvbiBPbmx5XQ0KPg0KPiBIaSBIZWlrbywNCj4NCj4NCj4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+IEZyb206IEhlaWtvIFNjaG9jaGVyIDxoc0BkZW54LmRlPg0KPiA+IFNl
bnQ6IFdlZG5lc2RheSwgTWF5IDI4LCAyMDI1IDM6MDUgUE0NCj4gPiBUbzogQWJiYXJhcHUsIFZl
bmthdGVzaCA8dmVua2F0ZXNoLmFiYmFyYXB1QGFtZC5jb20+Ow0KPiA+IHUtYm9vdEBsaXN0cy5k
ZW54LmRlOyBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCj4gPiBDYzogU2ltZWssIE1p
Y2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyB0cmluaUBrb25zdWxrby5jb207IGdpdA0KPiA+
IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gaTJj
OiBtdXg6IEZpeCB0aGUgY3Jhc2ggd2hlbiB0aGUgaTJjLWFyYml0cmF0b3INCj4gPiBub2RlIGlz
IHByZXNlbnQNCj4gPg0KPiA+IEhlbGxvIFZlbmthdGVzaCwNCj4gPg0KPiA+IE9uIDI4LjA1LjI1
IDA1OjEyLCBWZW5rYXRlc2ggWWFkYXYgQWJiYXJhcHUgd3JvdGU6DQo+ID4gPiBPYnNlcnZpbmcg
dGhlIGNyYXNoIHdoZW4gd2UgYWRkIHRoZSBpMmMtYXJiaXRyYXRvciBub2RlIGluIHRoZQ0KPiA+
ID4gZGV2aWNlDQo+ID4NCj4gPiBXaGljaCBjcmFzaD8NCj4NCj4gT2JzZXJ2aW5nIGNyYXNoIGxp
a2UgYmVsb3cNCj4gVS1Cb290IDIwMjUuMDEgKE1heSAyMiAyMDI1IC0gMTI6MzI6MDEgKzAwMDAp
DQo+IENQVTogICBaeW5xTVANCj4gU2lsaWNvbjogdjMNCj4gQ2hpcDogIHhjazI0DQo+IE1vZGVs
OiBaeW5xTVAgU0MgSzI0IFJldkENCj4gQm9hcmQ6IFhpbGlueCBaeW5xTVANCj4gRFJBTTogIDIg
R2lCDQo+IGluaXRjYWxsIGZhaWxlZCBhdCBjYWxsIDAwMDAwMDAwMDgwMzczNjQgKGVycj0tMjIp
ICMjIyBFUlJPUiAjIyMgUGxlYXNlIFJFU0VUDQo+IHRoZSBib2FyZCAjIyMNCj4NCj4NCj4gPg0K
PiA+ID4gdHJlZSBhcyBwZXIgdGhlIERUIGJpbmRpbmdzLiBUaGUgaXNzdWUgaXMgd2l0aCB0aGUg
Y2hpbGQgbm9kZSBvZg0KPiA+ID4gaTJjLWFyYml0cmF0b3JANzIgaS5lLiwgaTJjQGYxOTUwMDAw
LT5pMmMtYXJiaXRyYXRvckA3Mi0+aTJjLWFyYiwgYXMNCj4gPiA+IHRoZSBhcmJpdHJhdG9yIHVz
ZXMgdGhlIHVjbGFzcyBvZiBtdXgoVUNMQVNTX0kyQ19NVVgpIGFuZCB0aGUgbXV4DQo+ID4gPiB1
Y2xhc3MgZHJpdmVyIGNoZWNrcyBmb3IgdGhlICJyZWciIHByb3BlcnR5IHVzaW5nIHRoZQ0KPiA+
ID4gaTJjX211eF9jaGlsZF9wb3N0X2JpbmQoKSBmdW5jdGlvbiwgaWYgaXQgd29uJ3QgZmluZCB0
aGUgInJlZyINCj4gPiA+IHByb3BlcnR5IGl0IHdpbGwgcmV0dXJuIC1FSU5WQUwgd2hpY2ggaXMg
bGVhZGluZyB0byB0aGUgY3Jhc2guDQo+ID4gPiBTbywgYWRkIHRoZSBsb2dpYyB0byBjaGVjayB3
aGV0aGVyIHRoZSAgY2hpbGQgbm9kZSBoYXMgdGhlICJyZWciDQo+ID4gPiBwcm9wZXJ0eSwgaWYg
dGhlICJyZWciIHByb3BlcnR5IGV4aXN0cyB0aGVuIHJlYWQgdGhlICJyZWciIGFuZCB1cGRhdGUg
dGhlIGNoYW5uZWwuDQo+ID4gPg0KPiA+ID4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9pMmMNCj4gPiA+IC1hDQo+ID4gPiBy
Yi50eHQNCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBWZW5rYXRlc2ggWWFkYXYgQWJiYXJh
cHUgPHZlbmthdGVzaC5hYmJhcmFwdUBhbWQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgIGRyaXZl
cnMvaTJjL211eGVzL2kyYy1tdXgtdWNsYXNzLmMgfCAxMSArKysrKysrLS0tLQ0KPiA+ID4gICAx
IGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4g
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9tdXhlcy9pMmMtbXV4LXVjbGFzcy5jDQo+ID4g
PiBiL2RyaXZlcnMvaTJjL211eGVzL2kyYy1tdXgtdWNsYXNzLmMNCj4gPiA+IGluZGV4IGQxOTk5
ZDIxZmViLi5iMTg5OTljMWZlMyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvaTJjL211eGVz
L2kyYy1tdXgtdWNsYXNzLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvaTJjL211eGVzL2kyYy1tdXgt
dWNsYXNzLmMNCj4gPiA+IEBAIC00MCwxMSArNDAsMTQgQEAgc3RhdGljIGludCBpMmNfbXV4X2No
aWxkX3Bvc3RfYmluZChzdHJ1Y3QgdWRldmljZSAqZGV2KQ0KPiA+ID4gICAgIHN0cnVjdCBpMmNf
bXV4X2J1cyAqcGxhdCA9IGRldl9nZXRfcGFyZW50X3BsYXQoZGV2KTsNCj4gPiA+ICAgICBpbnQg
Y2hhbm5lbDsNCj4gPiA+DQo+ID4gPiAtICAgY2hhbm5lbCA9IGRldl9yZWFkX3UzMl9kZWZhdWx0
KGRldiwgInJlZyIsIC0xKTsNCj4gPg0KPiA+IFNob3VsZG47dCB0aGlzIGZ1bmN0aW9uIHJldHVy
biAtMSAodGhlIGRlZmF1bHQgdmFsdWUpLCBpZiBwcm9wZXJ0eSAicmVnIiBpcyBub3QgcHJlc2Vu
dD8NCj4gPiAoQW5kIGFsc28gaWYgZGV2X29mbm9kZShkZXYpIGlzIG5vdCB2YWxpZD8pDQo+ID4N
Cj4gPiBTZWVtcyB3ZSBzaG91bGQgbG9vayBpbnRvIHRoaXMgZnVuY3Rpb24gYW5kIG1heSBmaXgg
dGhlIHByb2JsZW0gdGhlcmU/DQo+ID4NCj4gPiBBaGEsIHRoaXMgY29tZXMgZnJvbQ0KPiA+DQo+
ID4gZHJpdmVycy9jb3JlL3JlYWQuYw0KPiA+IGludCBkZXZfcmVhZF91MzJfZGVmYXVsdChjb25z
dCBzdHJ1Y3QgdWRldmljZSAqZGV2LCBjb25zdCBjaGFyICpwcm9wbmFtZSwNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGludCBkZWYpDQo+ID4gew0KPiA+ICAgICAgICAgIHJldHVybiBv
Zm5vZGVfcmVhZF91MzJfZGVmYXVsdChkZXZfb2Zub2RlKGRldiksIHByb3BuYW1lLA0KPiA+IGRl
Zik7IH0NCj4gPg0KPiA+IHdpdGggZHJpdmVycy9jb3JlL29mbm9kZS5jDQo+ID4gdTMyIG9mbm9k
ZV9yZWFkX3UzMl9kZWZhdWx0KG9mbm9kZSBub2RlLCBjb25zdCBjaGFyICpwcm9wbmFtZSwgdTMy
IGRlZikgew0KPiA+ICAgICAgICAgIGFzc2VydChvZm5vZGVfdmFsaWQobm9kZSkpOw0KPiA+ICAg
ICAgICAgIG9mbm9kZV9yZWFkX3UzMl9pbmRleChub2RlLCBwcm9wbmFtZSwgMCwgJmRlZik7DQo+
ID4NCj4gPiAgICAgICAgICByZXR1cm4gZGVmOw0KPiA+IH0NCj4gPg0KPiA+IGFkZGVkIFNpbW9u
Lg0KPiA+DQo+ID4gQFNpbW9uOiBtYXkgcHJvcGVyIGZpeCB3b3VsZCBiZSB0byBjaGVjayBpbiBv
Zm5vZGVfcmVhZF91MzJfZGVmYXVsdCgpDQo+ID4gICAgICAgICAgaWYgcHJvcG5hbWUgZXhpc3Rz
LCBhbmQgaWYgbm90IHJldHVybiBkZWZhdWx0IHZhbHVlPw0KPiA+ICAgICAgICAgIE1heSBhbHNv
IHJldHVybiB3aXRoIGRlZmF1bHQgdmFsdWUgaWYgbm9kZSBpcyBub3QgdmFsaWQ/DQo+ID4NCj4g
PiAgICAgICAgICBXaGF0IGRvIHlvdSB0aGluaz8NCj4gPg0KPiA+ICAgICAgICAgIFRoYW5rcyEN
Cj4gPg0KPiA+DQo+ID4gPiAtICAgaWYgKGNoYW5uZWwgPCAwKQ0KPiA+ID4gLSAgICAgICAgICAg
cmV0dXJuIC1FSU5WQUw7DQo+ID4gPiAtICAgcGxhdC0+Y2hhbm5lbCA9IGNoYW5uZWw7DQo+ID4g
PiArICAgb2Zub2RlIG5vZGUgPSBkZXZfb2Zub2RlKGRldik7DQo+ID4gPg0KPiA+ID4gKyAgIGlm
IChvZm5vZGVfaGFzX3Byb3BlcnR5KG5vZGUsICJyZWciKSkgew0KPiA+DQo+ID4gSWYgd2UgZml4
IGl0IGluIHRoaXMgY29kZSwgeW91IGNhbiBoZXJlIHNpbXBseSByZXR1cm4gaW1tZWRpYXRlbHkg
aWYNCj4gPiAicmVnIiBwcm9wZXJ0eWlzIG1pc3NpbmcsIHNvIHlvdSBjYW4gc2F2ZSB0aGUgaWRl
bnRhdGlvbiBsZXZlbCwgYW5kIHBhdGNoIGxvb2tzDQo+IGNsZWFuZXIuDQo+ID4NCj4gPiA+ICsg
ICAgICAgICAgIGNoYW5uZWwgPSBkZXZfcmVhZF91MzJfZGVmYXVsdChkZXYsICJyZWciLCAtMSk7
DQo+ID4gPiArICAgICAgICAgICBpZiAoY2hhbm5lbCA8IDApDQo+ID4gPiArICAgICAgICAgICAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ID4gKyAgICAgICAgICAgcGxhdC0+Y2hhbm5lbCA9
IGNoYW5uZWw7DQo+ID4gPiArICAgfQ0KPiA+ID4gICAgIHJldHVybiAwOw0KPiA+ID4gICB9DQo+
ID4gPg0KPiA+ID4NCj4gPg0KPiA+IFRoYW5rcyENCj4NCj4gVGhhbmtzDQo+IFZlbmthdGVzaA0K
PiA+DQo+ID4gYnllLA0KPiA+IEhlaWtvDQo+ID4gLS0NCj4gPiBERU5YIFNvZnR3YXJlIEVuZ2lu
ZWVyaW5nIEdtYkgsICAgICAgTWFuYWdpbmcgRGlyZWN0b3I6IEVyaWthIFVudGVyDQo+ID4gSFJC
IDE2NTIzNSBNdW5pY2gsIE9mZmljZTogS2lyY2hlbnN0ci41LCBELTgyMTk0IEdyb2ViZW56ZWxs
LCBHZXJtYW55DQo+ID4gUGhvbmU6ICs0OS04MTQyLTY2OTg5LTUyICAgRmF4OiArNDktODE0Mi02
Njk4OS04MCAgIEVtYWlsOiBoc0BkZW54LmRlDQoNCg==
