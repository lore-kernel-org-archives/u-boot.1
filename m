Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC34CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 15:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9957084928;
	Wed, 10 Jun 2026 17:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QdWypHgG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB16D8493A; Wed, 10 Jun 2026 17:03:20 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27C338491C
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 17:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqhqCx9kzhFFp9Nv2goV+D9hpw3n8IDuQvt025MBRXqw0fO7FPEbq4OVd++WAXfTBUtJuzqKhn2akwzXnXrLzM3ayZK1aGQjiY/ORrQyRk28gOLH+uk6HnR8ZceDmZcmJd9RbfwkJtUx9VqGefwAZw1GPuCo31BwxKeWaMgBtfpACt48jlHEYBuWoCyeW5y1T6DG6hNFC+VJZme+6CgyKv0NGVTnrtUtAfv9aFgmVLpF9eICTTmK0R5bHxcaWjW0qOwSRgODGSrKfUUTwpc5g1ZnO1mvvHZtQFORRWxl4qnTwvrUl9UAOj72bUPtb+tG4w75lyywZCtVlLwe8aaTWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4uLfDo+vSn/+YRLMEFduDf2IcAzZPSFUUmRzRhiuWE=;
 b=i70oGXR3ntPE8P+c9pTTMUwl6ZWd4nCdYBJc7zyMTkDPu08PZZInIVJf3oGYuAawdA13lL0qVw3+8mWVzkBJJCMEVZBoVgM3FsXj0szYd56SNLEwlu1uu19uGRmzO26ex2AiDZcybmdmVgC/OK8qQtWFeA4Jsu97rfXYA+gUqBzI8LqaCWsLCX80m0vfaSYfjNgMAyFALeU0qtwG9EJwq67zx32YfjE8NPAjYNZ8dGSiskE/qcKFxxOgiZSx7GRXrFDqgeL6gXJrTeMeJ/oV+l6cWFkkVzeJfJem+Ld4PCBjjcqB6mA+E5FQ1BBjXDKcs0EGaJFbv2heQ3FpgAL5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4uLfDo+vSn/+YRLMEFduDf2IcAzZPSFUUmRzRhiuWE=;
 b=QdWypHgGRsGZzeXrhgfjizpiPR9/qQQxPPa5DBGTZnoB/XDPEj4n5qHnLWA0DWjXjvYUJr9Siiy8dc5ti5BEabaS++1uk+BWYGh3ckmUrdvfyVQNS1PbVsdTMhnd6w0pC3P52a53jEUowYjZAgJ1awrlB382OFWOL8hfqWJaKJA=
Received: from PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20)
 by DS4PR12MB9684.namprd12.prod.outlook.com (2603:10b6:8:281::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 15:03:10 +0000
Received: from PH0PR12MB7470.namprd12.prod.outlook.com
 ([fe80::c3e8:ee3e:aae:e211]) by PH0PR12MB7470.namprd12.prod.outlook.com
 ([fe80::c3e8:ee3e:aae:e211%3]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 15:03:10 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Simek, Michal"
 <michal.simek@amd.com>, "git (AMD-Xilinx)" <git@amd.com>, Sughosh Ganu
 <sughosh.ganu@arm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [PATCH] rng: tpm_rng: start TPM before reading random numbers
Thread-Topic: [PATCH] rng: tpm_rng: start TPM before reading random numbers
Thread-Index: AQHc9/hSzE/dtTMxOU2PTLJSym5MB7Y2B58AgAHZaSA=
Date: Wed, 10 Jun 2026 15:03:10 +0000
Message-ID: <PH0PR12MB7470002892F5A593AC1D9ACFEC1A2@PH0PR12MB7470.namprd12.prod.outlook.com>
References: <20260609101039.584994-1-padmarao.begari@amd.com>
 <CAC_iWj+gfnGQyi6MHJaJ0zRLue8TD1_K9yVNQ898+eu5daBD2A@mail.gmail.com>
In-Reply-To: <CAC_iWj+gfnGQyi6MHJaJ0zRLue8TD1_K9yVNQ898+eu5daBD2A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-10T14:50:31.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7470:EE_|DS4PR12MB9684:EE_
x-ms-office365-filtering-correlation-id: 124eb650-efe2-45c1-0182-08dec7016304
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|3023799007|4143699003|11063799006|38070700021|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: UGnBxtpcZljJ3t9o3DMjWeMTktA+Ey1KEmJMp+McNDTb/uw1YkqbZbpJV5kQxHouPjg5PKU6pfsBHAH1dQAX+SvqUD2ykSL/lxUfJlttW3nRwa90GlQyNMRrpI33Dx8U9dq8byK4KI4/ItmsKL/uURBf0EyPaj69NZ14SQ9xC4XB4wgfmCL7lHBx8kJYGz7nQfOXkHHY6mVzDgMFDG69vpF7MGgakYXpvgNudoJVxAzrtTTHRgV0qOLeo1JTKUh4s2kmVNSCXjO/r8JmQdeV2NjvHO5acRM0h1u+Af9YvUoyzfhang6QJWEt/C2mtWXMAkBZ9b4gzGQtw6ZzOcgRPi7UrT/mMRjMPgJXYz+KCm2bfCIj8vk3rpDlljBMW96qCnIgLhSNBwUNnXAm4a/ZioY8WxhxybNe4DsditStVrMOU0C710Ye9qyausn7RpJ4gXEXc4eO59LSBITK9Zl3QwXgn2zARkUrqQNElQyQ7qp2g/uK3jwomGYVCOcJZiNQWyZRfgIPaQ1kVHazQ2U4A9zLupQBZC0opKPIOISreboJ1Gfqxq3uKMglEXL9kh4PBCVsiuhJg3U53xG5DIY/94ROBX42AmZh3o5GKNSvcUppLVL9hjG6FdJlcxgYOX2C45PLm7Qs1Ifdfu/UEb2qMtRw9tBMbkKJRQwGRYSWqy8mYvDDi9QF3WYw3Q01xYQyR0m/Qy2LXAPN8BJXXwX0ucpnkrv49Wl9ollB8JbYFw57V0BkVjqaGHk0TpIzPv9n
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7470.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(3023799007)(4143699003)(11063799006)(38070700021)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGhHUmZZR3dEOGM1K0NDMlJTcjZWU0JHTTRMUlVCRzhtcHNCQlM5VWZXVTlr?=
 =?utf-8?B?aG0xTWRIRkE4cndiVmhxd2g0STJVZ2syRHozWXhJSFVIYVZkTkl5Q3BDWURr?=
 =?utf-8?B?bzIxUUhPeWU1NkoxWFU2UlhBQXZMbERTS1lGbU5EQ3U4YWtSUEFBRCtvWEdm?=
 =?utf-8?B?NHBBOW5MZFNINHlramNxa0ZYMURDSWJXVTBqb1M0Rkc5V0RRd1NmK2tTZnp4?=
 =?utf-8?B?TnZ2UUFBV3hqUkFIS01lK0x3MjF2RWNkbWYzdnRKcUlJMysvU2pWUzQ3eEk0?=
 =?utf-8?B?RFdzVHRpYk1pRVlJYVNKQWcvTFpYTlNjSHoxRXFhS203Szlralp0TVk3UlJH?=
 =?utf-8?B?U2NrbTU5SmU4NGd3dm9FOVg2bEovQWRyT1E1dDI3MkQ3NktGakdSSWNzaDgz?=
 =?utf-8?B?UkxCTkFIVWs4Z2M4WjFWaEc0UGpZNC9XVFR1M1ErVFpxT1FQSmNYTzZMZmU1?=
 =?utf-8?B?aEthenFCSHlDRW1GS0prNzduOEUvNXA3NXJzUnRqckEzbEFxYUFkZnBDM0pH?=
 =?utf-8?B?TWlITit6QlpmRmo2bzJJUjN6N3llUDVQRGdyVTZobGVBdlNlNkpZTVRnMlo3?=
 =?utf-8?B?dndHZU92SlJIQ2hmM1N5Q084YWcyazVwelR1ZDVZWm1XT0NOaFM1bEZGRGRl?=
 =?utf-8?B?QjRHNy92K2sycHlkbk9wekNuS0NabHVLWnhteExSWlNscDF5OU00azFLOHBP?=
 =?utf-8?B?UWJoY3pmRmdTVFg3cUZJOTVHQWpxYUVMbTBxZGNaZXhOc2htUTBFSkZiTnBq?=
 =?utf-8?B?RkJ4aytHTWFtL3hqaGFjRmlITEd4T3J3NnVHemNxZGRoNkd6R2g2dGRjRXFQ?=
 =?utf-8?B?d0d2bVpRS09OU1F6U1pPQW9zWWgraDlrZ2FMc2J3djJZL2dLeTJXS3RsNFZH?=
 =?utf-8?B?Z2taa1lEQldWM3FPRndSWkZqMjJ6ZXZHdXlsTzU1K1FseVlXblBOYWQvS3Bk?=
 =?utf-8?B?TFF3ZnNMV1hvR0dpTmZyRHhDeFlSMGZ6a1BHZHJqcnhKbzM0MEU2d0wyQmdK?=
 =?utf-8?B?eFZMek8xemxpaTBYSzg4ZjJKQkxuNFlNeGVuTDFFaG5VeGZJbSt1WjRpQ2dW?=
 =?utf-8?B?bWdnTVdUeXgrYUpYcUEweGNCb3RMRWhBT0dQcUpYZ0ZIZ0ZnTUJiRlRoczlU?=
 =?utf-8?B?Nk9BaWdxMmpPNS85UGhiazlxa3VjRnJaMTRHcXlFL3B4WThLNzVjVTNSNUU0?=
 =?utf-8?B?czR0a1ZkbHRCQ1FVMnFtQURYdjlsL2hCSzJ3OGhRdk5VUkx4SXJ1dklROHln?=
 =?utf-8?B?Z2pQOUU4L01pWTd4QW83Z3lXVWp6MS96WCthVFljcHlxUW16M0RJdW1uellX?=
 =?utf-8?B?c3VQK2xiQXJkNVNIYVU3OFlxbjFDdkZDZ0VweEhiRWtId2ZKdHhhZkxCTytR?=
 =?utf-8?B?OG5nSkEvQjQzTjFuZW1FZGJhRzBTVDd3M3lWMTZSUU81NUE5SHhoN0tRZktz?=
 =?utf-8?B?L084dGxnSTdkemJPcGpOTFh5S0IwT3l6RUtEUEk4eVZ5NXhOYUJ5WUxsQVhI?=
 =?utf-8?B?UVJXb2l6S012YU1UVkVkMkUxdUlqT1ZqMTcwMXV0dGduaHJNUUE3SXZEckIv?=
 =?utf-8?B?WXhEekQ0eStnL0JFcWhuem0rN1pSeUIyR3NaZWdpdHlUWDArVHNVZnpVZS9m?=
 =?utf-8?B?L3Rzd1hGVEFPUkJFb1cxYlpJWU5UL0lOVlJxZWN2eXNLM3ozVVJCTXhyQW1C?=
 =?utf-8?B?d1AzQXFhSUI2QXVvUDE2Rzd1clg1K1dNOW55RHpNL3FXUnFFcUc3N1FTRzlu?=
 =?utf-8?B?by9sOWQybkorMVZaRlp5aGZ5VFliMEtxcHBEc0ViTlcyaFJFVXMxQUcrT2tH?=
 =?utf-8?B?MWdUc3JvelYzdWdYbTd4MzBkK1VITHdONzF4OEhQc3Zxd0FUQVRkYjQyRFVE?=
 =?utf-8?B?M3d6L3lEbWlNckF4cnYxNlB1QzZqZkFyV09Sa3hBWU9PQ0tJMGN4Ny9yOWdO?=
 =?utf-8?B?V2tHamU5NUNGaWYrckdRWmUwcytScmxYSHVKek5JUTlMRWh2dmZGRkNTZEFa?=
 =?utf-8?B?dkpZSWJNa3JRSHV6OERpU21HNUJyS3FBN21QcnR4ZndGVE9COWg0VEFqd1RQ?=
 =?utf-8?B?K1dUSUlzcFh1N2ZWQktQUWtjREZXaFE4a0VnZjgxWVdlM3FqOTl4a29uQ3VG?=
 =?utf-8?B?Z0tncUVBaVZHU04rWm16bFlaMWlXeXV4eTNCN053alprbGg2WDFERGFZNzhm?=
 =?utf-8?B?VloxdUxTaU54UzF6MkpLeEtMdlc4SE1hT1RiR2xsSUY3WjZPbkx2aGU0NXQ2?=
 =?utf-8?B?eURZVHZmV0lOR2Ywb0lpbCtOZWl5bGszbHE5RXk2OFBHV2IxZmdoRDQyWmVZ?=
 =?utf-8?Q?C7NN8l5NQLpHWaMJGn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7470.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124eb650-efe2-45c1-0182-08dec7016304
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 15:03:10.2085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /7hTME8wDMhdsjWrA5zu0rojTygQyMcyYbg7hKMN78G1vVpTyvftNVX7/0vxBxsj3vozKS+2EFXY/jyPhPZb7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9684
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

QU1EIEdlbmVyYWwNCg0KSGkgSWxpYXMsDQoNCj4gRnJvbTogSWxpYXMgQXBhbG9kaW1hcyA8aWxp
YXMuYXBhbG9kaW1hc0BsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDksIDIwMjYg
NDowNiBQTQ0KPiBUbzogQmVnYXJpLCBQYWRtYXJhbyA8UGFkbWFyYW8uQmVnYXJpQGFtZC5jb20+
DQo+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVr
QGFtZC5jb20+OyBnaXQgKEFNRC0NCj4gWGlsaW54KSA8Z2l0QGFtZC5jb20+OyBTdWdob3NoIEdh
bnUgPHN1Z2hvc2guZ2FudUBhcm0uY29tPjsgSGVpbnJpY2gNCj4gU2NodWNoYXJkdCA8eHlwcm9u
LmdscGtAZ214LmRlPjsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gcm5nOiB0cG1fcm5nOiBzdGFydCBUUE0gYmVmb3JlIHJlYWRpbmcgcmFuZG9t
IG51bWJlcnMNCj4NCj4gSGkgUGFkbWFyYW8NCj4NCj4NCj4gT24gVHVlLCA5IEp1biAyMDI2IGF0
IDEzOjEwLCBQYWRtYXJhbyBCZWdhcmkgPHBhZG1hcmFvLmJlZ2FyaUBhbWQuY29tPg0KPiB3cm90
ZToNCj4gPg0KPiA+IFRoZSB0cG0tcm5nIGRyaXZlciBjYWxscyB0cG1fZ2V0X3JhbmRvbSgpIHdp
dGhvdXQgZmlyc3QgZW5zdXJpbmcgdGhlDQo+ID4gVFBNIGRldmljZSBpcyBvcGVuZWQgYW5kIHN0
YXJ0ZWQuIFdoZW4gc3lzdGVtZC1ib290IG9yIGZkdF9maXh1cF9rYXNscg0KPiA+IHRyaWdnZXJz
IGFuIFJORyByZWFkIGVhcmx5IGluIGJvb3QsIHRoZSBUUE0yIGRldmljZSBoYXNuJ3QgYmVlbg0K
PiA+IGluaXRpYWxpemVkIHlldCwgY2F1c2luZyB0aGUgY29tbWFuZCB0byBmYWlsOg0KPg0KPiBJ
cyBzeXN0ZW1kX2Jvb3QgY2FsbGVkIHZpYSBFRkk/IElmIHNvIHRoZSBUUE0gc2hvdWxkIGJlIHVw
IGFscmVhZHkuDQoNCllvdSdyZSByaWdodCwgVGhlIEVGSSBUQ0cyIHByb3RvY29sIGRvZXMgc3Rh
cnQgdGhlIFRQTSwgYnV0IG9ubHkgd2hlbiB0Y2cyX3BsYXRmb3JtX2dldF90cG0yKCkgcmV0dXJu
cyBhIHByb2JlZCBUUE0yIGRldmljZS4gVGhhdCBmdW5jdGlvbiBpdGVyYXRlcyB3aXRoIGZvcl9l
YWNoX3RwbV9kZXZpY2UoKSwgYW5kIHRoZSB1Y2xhc3MgaXRlcmF0b3Igc2lsZW50bHkgc2tpcHMg
YW55IGRldmljZSB3aG9zZSBwcm9iZSBmYWlscywgcmV0dXJuaW5nIC1FTk9ERVYuIFNvLCBhIGZh
aWxlZCBwcm9iZSBtZWFucyBFRkkgbmV2ZXIgc3RhcnRzIHRoZSBUUE0uDQoNClRoZSBmYWlsdXJl
ICh0cG0tcm5nIHRwbS1ybmc6IGRtX3JuZ19yZWFkIGZhaWxlZDogLTEpIGRvZXMgbm90IGNvbWUg
ZnJvbSBzeXN0ZW1kLWJvb3QsIGl0IGNvbWVzIGZyb20gVS1Cb290J3Mgb3duIGZkdF9rYXNscnNl
ZWQoKSBjYWxsLCB3aGljaCBydW5zIGR1cmluZyBib290ZWZpL2Jvb3RtZ3Igc2V0dXAgYmVmb3Jl
IGNvbnRyb2wgaXMgaGFuZGVkIHRvIHRoZSBFRkkgYXBwLg0KDQo+IEFib3V0IGZkdF9maXh1cF9r
YXNscigpLCB3aHkgZG8geW91IG5lZWQgdGhpcz8gV2Ugc3BlY2lmaWNhbGx5IGNsZWFyIHRoZSBr
YXNsci1zZWVkDQo+IHdoZW4gYm9vdGluZyB2aWEgRUZJIGFuZCBFRklfUk5HIGlzIGluc3RhbGxl
ZCwgc2luY2UgdGhlIGtlcm5lbCBpZ25vcmVzIGl0Lg0KDQpBZ3JlZSwgcmVmZXJlbmNpbmcgZmR0
X2ZpeHVwX2thc2xyKCkgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIGlzIGEgbWlzdGFrZSwgIEknbGwg
Y29ycmVjdCB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNClJlZ2FyZHMNClBhZG1hcmFvDQoNCj4NCj4g
VGhhbmtzDQo+IC9JbGlhcw0KPiA+DQo+ID4gICB0cG0tcm5nIHRwbS1ybmc6IGRtX3JuZ19yZWFk
IGZhaWxlZDogLTENCj4gPg0KPiA+IEZpeCB0aGlzIGJ5IGNhbGxpbmcgdHBtX2F1dG9fc3RhcnQo
KSBvbiB0aGUgcGFyZW50IFRQTSBkZXZpY2UgYmVmb3JlDQo+ID4gdHBtX2dldF9yYW5kb20oKS4g
VGhpcyBlbnN1cmVzIHRoZSBUUE0gaXMgaW5pdGlhbGl6ZWQgYmVmb3JlIHVzZS4NCj4gPg0KPiA+
IEZpeGVzOiBlNjdmZmI1YWE1YWIgKCJ0cG06IHJuZzogQWRkIGRyaXZlciBtb2RlbCBpbnRlcmZh
Y2UgZm9yIFRQTSBSTkcNCj4gPiBkZXZpY2UiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFBhZG1hcmFv
IEJlZ2FyaSA8cGFkbWFyYW8uYmVnYXJpQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
cm5nL3RwbV9ybmcuYyB8IDEwICsrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cm5nL3RwbV9ybmcuYyBiL2RyaXZlcnMvcm5nL3RwbV9ybmcuYyBpbmRleA0KPiA+IDFhNWU5ZTJl
NGI0Li4zNzRlMGFjMWZmOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3JuZy90cG1fcm5nLmMN
Cj4gPiArKysgYi9kcml2ZXJzL3JuZy90cG1fcm5nLmMNCj4gPiBAQCAtNCwxMiArNCwyMCBAQA0K
PiA+ICAgKi8NCj4gPg0KPiA+ICAjaW5jbHVkZSA8ZG0uaD4NCj4gPiArI2luY2x1ZGUgPGxvZy5o
Pg0KPiA+ICAjaW5jbHVkZSA8cm5nLmg+DQo+ID4gICNpbmNsdWRlIDx0cG1fYXBpLmg+DQo+ID4N
Cj4gPiAgc3RhdGljIGludCBybmdfdHBtX3JhbmRvbV9yZWFkKHN0cnVjdCB1ZGV2aWNlICpkZXYs
IHZvaWQgKmRhdGEsDQo+ID4gc2l6ZV90IGNvdW50KSAgew0KPiA+IC0gICAgICAgcmV0dXJuIHRw
bV9nZXRfcmFuZG9tKGRldl9nZXRfcGFyZW50KGRldiksIGRhdGEsIGNvdW50KTsNCj4gPiArICAg
ICAgIHN0cnVjdCB1ZGV2aWNlICp0cG1fZGV2ID0gZGV2X2dldF9wYXJlbnQoZGV2KTsNCj4gPiAr
ICAgICAgIHUzMiByYzsNCj4gPiArDQo+ID4gKyAgICAgICByYyA9IHRwbV9hdXRvX3N0YXJ0KHRw
bV9kZXYpOw0KPiA+ICsgICAgICAgaWYgKHJjKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4g
bG9nX21zZ19yZXQoInN0YXJ0IiwgLUVJTyk7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIHRw
bV9nZXRfcmFuZG9tKHRwbV9kZXYsIGRhdGEsIGNvdW50KTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZG1fcm5nX29wcyB0cG1fcm5nX29wcyA9IHsNCj4gPiAtLQ0KPiA+
IDIuMzQuMQ0KPiA+DQo=
