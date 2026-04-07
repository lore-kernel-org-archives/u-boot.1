Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC08FB519B
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 06:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 654DE83936;
	Tue,  7 Apr 2026 08:17:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3JrjLxBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 153C583A41; Tue,  7 Apr 2026 08:17:25 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A64908352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 08:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjzwln1lc96qfnZFhWSz2FJMmqD69aQTP+yLqOd0j98BQZP1jioFUFW+6LJ4PiDvJSB07dUUQQFnB3TAlX+r+HunL5oWqA8JxXLZSOJcYHOMc7UF39eCxhz1dVcFQ71Bk6RM1cRLLclncJstBESMf4FbTZR1wYg2x8xVZTuiwiqrqg9T/TBhShr1Mp6rfLliOnwZOGOI7L+kfeoik+pl78JHcaukVDeEfS4fakq3I6+6y8Lut0fIAnk/jWRcPe7lGTUYtFEa1H7p8525Gs0Et6zSWGMS043KylGvF1eMMZTd7xU4q8bLNuOB+DgKldAWU4TXf+txIOfzk9/9tokn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOhwlGfebmo03cqIct90wzqF/rlso+DyzJle8IV6tVo=;
 b=RQjkNF1PDG3CUcSOsMb0wlCidjgCnI2Sb+RTW04dMM/6AsR3qq0VMEMGNru2pfea1D6CKXZPRATSwUp5EZixVAeIp/mvI0LiT5ueGJGp+YfKmoCUXS26ZD9Qd4F9EldySm7OCDIXLc5g+oOvka2LRKVxzxfQn3tHxfdIqegZQ1ojSOTe4WqrEkLZ5m8iRS2tlvexe3nuvn6ItONpgFKIGZCzWj5hFyK0BqBf9s0YI3YsFusMRKm2Clvv4vagfW1kSeHrD7+gkZO9GworXxKkFvJyBC4BluFI7nTFuHToZ1RdLGPqahFkGwCpw8NVVJtLW510Yw2aAscisyyVlkenHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOhwlGfebmo03cqIct90wzqF/rlso+DyzJle8IV6tVo=;
 b=3JrjLxBnENZoKLwaLZ3VFnJ+m3IMTnAfNIoaXugWmtTHLueleqUmn9n0pkhh9bTLO+gjuhhJf53gC3dyd6mlrRWTg6KfcBCji4jWmERXuefYzjvydpK28D0u2gwrlzSjH3EFBIyWKXhoHEP+/lR6NwFLNV+VcsQJDjlGd8jqxdE=
Received: from MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17)
 by PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 06:17:16 +0000
Received: from MW6PR12MB7088.namprd12.prod.outlook.com
 ([fe80::e56b:9894:876a:c049]) by MW6PR12MB7088.namprd12.prod.outlook.com
 ([fe80::e56b:9894:876a:c049%5]) with mapi id 15.20.9769.017; Tue, 7 Apr 2026
 06:17:16 +0000
From: "Vinay Tilak, Pranav" <Pranav.VinayTilak@amd.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "Simek, Michal" <michal.simek@amd.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "Begari, Padmarao"
 <Padmarao.Begari@amd.com>, Jerome Forissier <jerome.forissier@arm.com>, Tom
 Rini <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: RE: [PATCH] net: phy: ethernet_id: fix duplicate eth_phy binding
Thread-Topic: [PATCH] net: phy: ethernet_id: fix duplicate eth_phy binding
Thread-Index: AQHcxaFdqdjt0yumpUS35QsS7cIkP7XSMwCAgADqSjA=
Date: Tue, 7 Apr 2026 06:17:16 +0000
Message-ID: <MW6PR12MB70885DCB91C886A069CDC726FB5AA@MW6PR12MB7088.namprd12.prod.outlook.com>
References: <20260406084204.1274302-1-pranav.vinaytilak@amd.com>
 <3e515a8e-710d-4664-ba49-ce287bd5edc2@mailbox.org>
In-Reply-To: <3e515a8e-710d-4664-ba49-ce287bd5edc2@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: marek.vasut@mailbox.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-07T06:11:08.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB7088:EE_|PH7PR12MB8124:EE_
x-ms-office365-filtering-correlation-id: f27229ec-538f-497e-2bc6-08de946d50c5
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: JGbwzALo2gJbokY1nsMdjEc84p1yXc5h+2ysDeTvXgV6c24HPVYNS6N4qzRDfyTcJy0IypbLVOTVPngqIocrrO1+6MOccZFpc/StvVtQ1YuhNp0fOdQaXGKkIL+fMlNIYZfc1MjliIUVak0Pl/cnZ+oKPM6nTzcdVl1sxropT5MhAjkJG2U0jbbABy193AT2dY2atPWnESPRZ6MDzb5m1E51C5x2KvgiJ4pUIZrm7Wmrf0+eTIUsRiZH+6m0e4kyEsHZlErrFiJ+mbYATaHl3lCi20zadhzizT3iIPIuAQ+XiPE8OK1KumAIPQcSwsmkXRmG76MWczTMUSG+69+FglwbcD/Cl5VMweGia7lSv6B1iEhqF+vDSme5KC/krNSbAgRrQILL81+6B81WSAaTYik2zbZUar4CK0H/0qLU6b7Nt+o89DOEgwe8UgwXN7dw26MFiDLIY7wW/BYSSS56QNoeEhSk38o5tjA2TOvw9LsZ1IjFKpqNx81FMV0D4Zct3rvpL1UZf1faJSiupG+dw3C6Z7cccPSsTGTWf8PEToOeAUC1vwg5Hb/YGb7Ctm1WralhGn8avJilpSbKWl5d5z7+1U7UBXJnZAaT/FOZbY4nWY2o618q1QV5EPhuHEkUQQS3qPSfRdMqHoV2kF947+lrNgwaGPoiRc+dnq73nVzeuLMkhqM9nz+E2OfDvPIrlWFdx8JYQ5DN8I1fwCH8vSzGnC4J/Mhj3mcBsa9TpXCjvG5eNj85zi7h3DKmErOXRs73zAMzF37XfTFlvJBmnTsnDMdlSOafZP8k2ZZaoKs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB7088.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm5UL1pEVXI3djJpUHpiZ2NYbklMNXl0RExyUVFRWWQ1V0dBWFpuU052Yjkr?=
 =?utf-8?B?ZWh0MElEbEhUK0VmN3Y0aHRvSXNXRDVPOUt3TjJad1pWYzMzczJHR0NIRjdS?=
 =?utf-8?B?NERpVThlR3hwa0YrSERrcVdmVzdSdXR0MmlDek9vbG1NVkhaZGlWOVhXenV5?=
 =?utf-8?B?VlpLN1dqL0p2S3FLTk9zVVFIYzVrbHUzaklGOWdxQ3ZJaXIzeFpsMUczTmlk?=
 =?utf-8?B?TjFjcG9YMjR4d0Nsdlg5ZzM4YUxrbXhlY204dFV1bE9LYmpVUm56MmFhSGdU?=
 =?utf-8?B?MGIxQkVFWE5MTXd4ZXR6YlRubVczOXZkTktJUldCLzZ3SUV0bFlPbkVEVnhX?=
 =?utf-8?B?ZStubHpVOFErQzJNb1Q1MHRhclRWWFJvSld2NDIrVW5RanlaMkVLdlNZYWhr?=
 =?utf-8?B?SlE0UHNYblUxMmFSQ1lXWGNKWWtLdTJWSWppeUNvNXp6Sk5NUnZFWkpwd1dV?=
 =?utf-8?B?Rzh3TThxY1kwdUM2ZlVzdkZyMWdpaVNXRlRXQm1ZM3E3UXRUNEI5QXdIZ3lX?=
 =?utf-8?B?UVVkbFQ1dDVqTUZTcnhNODhLcUlwZWdJNkQzdTBWdnhNa3A5SGdaTmxMUGVz?=
 =?utf-8?B?MWJZQWJFOUFjQnAxbU5lamN6VDM5bm9od2tRSUpWaGlPZlFhcUFZeFdlTVA1?=
 =?utf-8?B?dlZyQ0dHVytON29EamphRkZzQzF1MDIzZ2tiRmNERjBqbHVoWnlIeGdaOTZY?=
 =?utf-8?B?eWlnNG5ZQ3RiMG5nampXUXZ6U0VncmJYNklQdEN0L2xSTFlCak9LVkFEcHpX?=
 =?utf-8?B?TmlveHJYOFJNaTVsbk9JWmlKbVBod0R3TVk2d0I1ZkdzZC84SlpNVFRXSTM0?=
 =?utf-8?B?NXRKay9UYzNoZm44cjRuNGN0R2EwZStheXluUG00R2V5RERON0ZXSTYzdnR0?=
 =?utf-8?B?RmNQc1RFQ1pQbkZEWTdZaXU2TFJTSEFVR1NFWnRKTEFnUzRVQnZmTHltb1gy?=
 =?utf-8?B?UjFiODFmVlFVUEJBenFZV3dna1JWdjNiYlRDL2x3emo0d1V0OUs0ci8vcUd5?=
 =?utf-8?B?cHM5S1BxUDM3aUxURTFsUUpHcEhEL3RsUFdNMGJGZndCYlBCMjJmMmE4WjN1?=
 =?utf-8?B?eFBZMkRid0dWcVQ4MWtSOFdUcVdVcFlGUUJHNy9CVVd3SVIyKytFNzZwbHlL?=
 =?utf-8?B?LzJGN2loSExmNDVyc2dDRHRXRERBdmRwU0xkQlNZVnNiTk1uM2hnQXJxVExR?=
 =?utf-8?B?M3Vkbm5Wd0syT3ppM2MwSmZFYmNqOGN5eU5JSkRIT2EwWVdjOFhuc2FiQXVR?=
 =?utf-8?B?ZHZubGEyU3U2aTJtTEVJUmN3Yk44QzhwdTRMbXFOMEV2dlJsbjdlRkhnN1pC?=
 =?utf-8?B?YVVxbVdPMWpGZWlXWTZOT0h6WVhDQlcyV00zTWVjL2hFcEhGdWd6ZkszWUlz?=
 =?utf-8?B?QktaN3dQUDBORWhFV2ovdGFoV0duMmlYVUtBd0N6a054NDJSYmhwbmJobjRI?=
 =?utf-8?B?QXkrY0ZPR05hRUdHbVNBOEI4eUZjWXhaS0tuaHZ3SDV0REs2UXAvdzlHTmtj?=
 =?utf-8?B?VTRGcjhJZWpNL08vR1FMdG84Q3VHaE5Db3FEU1hOSXhZMkdPUEhRR2NzY0Rk?=
 =?utf-8?B?eHdVM1RUYkQ5blFDbFVYMUZ0NXVaZ1pnRnUyMzZISTRmYXBTU2lQMGxZN3hm?=
 =?utf-8?B?UldTTDVIUjNvZUNma3VXSjBhbGFzS2Rid21odThaVkF2OUZLSFRRdUNDclc5?=
 =?utf-8?B?Z083bE0zaUlKZlNpajJMMDZLbS9Gc3YzbEtmTnJtbE10dGRvWXNpbW5DcFB2?=
 =?utf-8?B?dFhMK2JwVmhQM1dDTStkbERYU05aS1N0RmVGQStQY25vaXpNeTcvMXUzYVgw?=
 =?utf-8?B?bWR1Rm92M0ZSYlo2QTg1c1RLL2puS1Q3Z3dVVDg2VEFsZkltcUJkbWhUTmVw?=
 =?utf-8?B?QWMvUFZHdUFlb2lKRC9Ka0tNaktaQkxKc2Q5c29CK3Roc2xQTGNGYkYraC9C?=
 =?utf-8?B?WGZ5MTJUVjZkOEFBZmdpTHNOQzVYemRvV085dDZtMUJteTAra25JR0MxUkZQ?=
 =?utf-8?B?VldMelJjQkxXd0g3T2dJUFl1Rnk0NWlVMXY3SmxNZStuK3RTL1ZnbTlSYXdX?=
 =?utf-8?B?aDg5UXJSbjV1NUs5TUtiVlVPK3ZZWDNwVU55bzQ2OGRtVWJ1WFNXMWRDZStE?=
 =?utf-8?B?cVFmOVh2UDdRYnpIQUJSVEVQRnVGSDBhOWdvWHo3eXdKSjc0MUJOc05UN0Jz?=
 =?utf-8?B?dHNzcWhXbEM1dUZQTWVhd01uT1ZQaXUzU0lTT1gzWWRROXJoaWEyMW9uZXQ5?=
 =?utf-8?B?UlBuSEVPeUNEQXFsNXI3Q2w5OTZIdG9oSWttK1ovYlpsd3RQd3hmNndhdTRK?=
 =?utf-8?Q?PLRt2N4WCOU/OnN7k7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7088.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27229ec-538f-497e-2bc6-08de946d50c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 06:17:16.0465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ya/vjune4vl0I4zrSFz9Ysfu5KDfsgNpfNFwDhJd/aMOEu8pn9dwvoHHpHY2cSMM4KSkigwTrB8S8LZskPYUkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124
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

W1B1YmxpY10NCg0KSGkgQE1hcmVrIFZhc3V0LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IE1hcmVrIFZhc3V0IDxtYXJlay52YXN1dEBtYWlsYm94Lm9yZz4NCj4gU2Vu
dDogTW9uZGF5LCBBcHJpbCA2LCAyMDI2IDk6MzUgUE0NCj4gVG86IFZpbmF5IFRpbGFrLCBQcmFu
YXYgPFByYW5hdi5WaW5heVRpbGFrQGFtZC5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZTsNCj4g
U2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+IENjOiBnaXQgKEFNRC1YaWxp
bngpIDxnaXRAYW1kLmNvbT47IEJlZ2FyaSwgUGFkbWFyYW8NCj4gPFBhZG1hcmFvLkJlZ2FyaUBh
bWQuY29tPjsgSmVyb21lIEZvcmlzc2llcg0KPiA8amVyb21lLmZvcmlzc2llckBhcm0uY29tPjsg
VG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47IE1hcmVrIFZhc3V0DQo+IDxtYXJlay52YXN1
dCtyZW5lc2FzQG1haWxib3gub3JnPjsgUmFtb24gRnJpZWQgPHJmcmllZC5kZXZAZ21haWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBuZXQ6IHBoeTogZXRoZXJuZXRfaWQ6IGZpeCBkdXBs
aWNhdGUgZXRoX3BoeSBiaW5kaW5nDQo+DQo+IE9uIDQvNi8yNiAxMDo0MSBBTSwgUHJhbmF2IFRp
bGFrIHdyb3RlOg0KPiA+IFdoZW4gYm90aCBDT05GSUdfUEhZX0VUSEVSTkVUX0lEIGFuZCBDT05G
SUdfRE1fRVRIX1BIWSBhcmUNCj4gZW5hYmxlZCwNCj4gPiBldGhfcGh5X2JpbmRzX25vZGVzKCkg
Y2FsbGVkIGZyb20gZXRoX3Bvc3RfYmluZCgpIGFscmVhZHkgYmluZHMgdGhlDQo+ID4gZXRoZXJu
ZXQgUEhZIG5vZGUgdG8gZXRoX3BoeV9nZW5lcmljX2Rydi4gSG93ZXZlciwNCj4gPiBwaHlfY29u
bmVjdF9waHlfaWQoKSBjYWxsZWQgdmlhIHp5bnFfcGh5X2luaXQoKSAtPiBwaHlfY29ubmVjdCgp
DQo+ID4gY2Fubm90IGF0dGFjaCB0byB0aGUgYWxyZWFkeSBib3VuZCBQSFkgZGV2aWNlIGFuZCBj
cmVhdGVzIGEgc2Vjb25kDQo+ID4gaW5zdGFuY2UsIHJlc3VsdGluZyBpbiBkdXBsaWNhdGUgZW50
cmllcyBpbiB0aGUgZG0gdHJlZS4NCj4gPg0KPiA+IEZpeCB0aGlzIGJ5IGd1YXJkaW5nIHRoZSBi
aW5kL3Byb2JlIGJsb2NrIGluIHBoeV9jb25uZWN0X3BoeV9pZCgpIHdpdGgNCj4gPiB1Y2xhc3Nf
Z2V0X2RldmljZV9ieV9vZm5vZGUoKSB0byBza2lwIHJlLWJpbmRpbmcgaWYgdGhlIFBIWSBub2Rl
IGlzDQo+ID4gYWxyZWFkeSByZWdpc3RlcmVkIGluIFVDTEFTU19FVEhfUEhZLg0KPiBTaG91bGRu
J3QgcGh5X2Nvbm5lY3QoKSBjaGVjayB3aGV0aGVyIHRoZSBQSFkgaXNuJ3QgYWxyZWFkeSBib3Vu
ZCBhbmQgYmFpbA0KPiBlYXJseSBpZiBpdCBpcyA/DQoNClllcywgaSBjaGVja2VkIHdlIGNhbiBt
b3ZlIHRoZSBkdXBsaWNhdGUgYmluZGluZyBjaGVjayBmcm9tIHBoeV9jb25uZWN0X3BoeV9pZCgp
IHRvIGl0cyBjYWxsZXIgaW4gcGh5X2Nvbm5lY3QoKSBhbmQgdXNpbmcgdWNsYXNzX2dldF9kZXZp
Y2VfYnlfcGhhbmRsZSgpIHRvIHNraXAgcmUtYmluZGluZyBpZiB0aGUgUEhZIG5vZGUgaXMgYWxy
ZWFkeSByZWdpc3RlcmVkIGluIFVDTEFTU19FVEhfUEhZLiBXaWxsIHVwZGF0ZSBpbiB2Mi4NCg0K
VGhhbmtzLA0KUHJhbmF2IFRpbGFrLg0K
