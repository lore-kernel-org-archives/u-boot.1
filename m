Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A8FD41D5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 06:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9A2788E78;
	Tue, 12 Nov 2024 07:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qT265gTm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7818A88B6C; Tue, 12 Nov 2024 07:42:32 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92DB6893AD
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 07:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1Xll3JAtDGYbFnEr+TNoNSnC7tEh+nSD6qmrkA/3GZEyozklYJUDeuq4/YmT79prhsV7ZjXcRFPG6p9b9PgOFNvcBRrs29nrr6uHzUPtUIRIeKwfiSsnkrwvoZ4FqC6Xu37aWOt7wfohTZa5+ifQLgQdN7tUFBXTKE2HhWn/nLBobJ0Ccp0vR879IM4aQkLx5zTkwJWrStlqXmeHS/+Ie9BvAQLQk3vucjqi/leC4cTR2kGhYJbnifZYgb9i8JklL0umQvbvc/8QI0vHmDKAn9d/30ekAxQcGUsPacV5Eq8dsN6jj1wtXKAT3RUuw0YXdugGGSsP0XvEBCUylpq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gOILh5+9Bhe06QN77PLAvzVznecch+NYuRiauJ9asc=;
 b=BhpJL55mqcwHC7WxJeUtmcdr6iNXIfQGptaUw53fQ5sPfkfndmwoLWGRj9cF+K5X80yhL3g+3ko68sKbhfjgSdj4wimLrMDxMXd1fwvYg5gokp04AJ3M3nScKSbY+ZImwtaSQ0ibujc9Z22A+ouvqUkroM6KSNr1VVDZyC3bx9+8OQzc3lHJFGhfHseS/NUDU2vGDTft9cDduRDVaplephF6TH4mk3rP4U+JlBh0LdLmLKQJ/XD49lnXixMulXMyb429CC8Nm9+qCi1AoRFTPTukv91csVySnwzZxpFJgctKu0ZLwQmPAAvOZJVDT7dPb2twsSxxFm9DkyUsS+L73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gOILh5+9Bhe06QN77PLAvzVznecch+NYuRiauJ9asc=;
 b=qT265gTmNArHlEH4N6yGYDFxvLrMWenCLDPA0LLgpm5It5zVB7vKaINeIxejjgIhZlT7+k0mua/lKZ5pHiSA9T8Rl1s+EBJ5Hk2ICiCg5FH1vR8hk3HmzfS3VZjotSMnV82VRtpKRz3fWJyJEYa6wy6GYMoetk8ogKGb1wKAq4s=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Tue, 12 Nov
 2024 06:42:23 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%7]) with mapi id 15.20.8137.022; Tue, 12 Nov 2024
 06:42:23 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
 USB5744
Thread-Topic: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
 USB5744
Thread-Index: AQHbNMKT41MM9BpbCkCVHbjRknnK4LKzJkQAgAAKwlA=
Date: Tue, 12 Nov 2024 06:42:23 +0000
Message-ID: <SA1PR12MB869770E331845B38B0BC2AC098592@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
 <20241112050740.15343-4-venkatesh.abbarapu@amd.com>
 <d61ab683-744d-4024-a5d3-71b372e85d02@denx.de>
In-Reply-To: <d61ab683-744d-4024-a5d3-71b372e85d02@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|MN0PR12MB5977:EE_
x-ms-office365-filtering-correlation-id: fbd045f7-c74a-4f78-594f-08dd02e52a4b
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aHlqd2VBT25nWDVsOU9BMzgvK0FEYVZWb1FoOFVidVg5aVp5dHJhbDh0LzY1?=
 =?utf-8?B?VlZsMXhaOXhCMmF4RXhuako3SUF0SGN1eFpDQmZkUDFERXNDTVl3LzhhOTh5?=
 =?utf-8?B?NjBWUUdVeFNWclZXK3MrckcrdDlxZUVJMVYzdGxjWHBSUEx5b0xZNk9PQmps?=
 =?utf-8?B?RVJtYm5XT2RFbWlCQU5aeTdRNVF1U0pTMEdQTFFtQVJjcFpNVTNZZDRpbzZv?=
 =?utf-8?B?b3phKzlvaWpUaHhadzdacVpRc1RPNlhJVVFYNDIydlJaY1pFMG5RUFQyZEt6?=
 =?utf-8?B?T094bzBoTVA0RzRRUGtFd3ZseDBVSTJkZWdZNkFqQmh3aE02Z0FiZHZUZVdF?=
 =?utf-8?B?MFN0dnRSVitzQ20vRXYwMit4eUtRRk1PZ0Z0MFBGMC9JN0pZeVNwbllEWG5Z?=
 =?utf-8?B?NUhsbWhrbkFJOEFORTZ0ZnhBVlNlQW1ERmMwRGg0ZUgrK3cxOUhzakdya1NW?=
 =?utf-8?B?cjZSL3lHaFY0Uy9iOER1SkN5T0JKL2VMY0laS2FiRGh0SFZOR3pwRXRqUmhB?=
 =?utf-8?B?UUM2b0xHaGoxb1dwUEs0YmErckxZNnRFeVNuVEY4akM0NFNMWGJuUGVKb3dy?=
 =?utf-8?B?a01hMWdRQ3hHYWFWQXE4b2RjR0ozTDBpVDRPd2JHSlF0SDlGQlp4Nm04Y09L?=
 =?utf-8?B?RDdnQVhTVzBjcTBNNWVFeVNKYXowcitYdE82Mi93eFdCa3dKR1JoZDNBLzdx?=
 =?utf-8?B?dnF0RDBHZENFRTJ3aUdQM2ZRNTBFNStzUXhhQTVKR0pCV0hHT1lUYWJwaWc2?=
 =?utf-8?B?dHVXb0IrbUw3MW9EU2lqVmh1WGxvTTBSdE5JVkR5dXlLcFZhKzN6RExBOVBC?=
 =?utf-8?B?UktneDZLU0xuREl6dmxWUHRPTEJpUDNJWmVteVNrRXB0RFhlZnFyelNrVkdt?=
 =?utf-8?B?aHZhakZ1VmlsNGtpMlhPclAvWnZVNUNwTkpKOUMwUDZoR0hrZy9LdExBc3oy?=
 =?utf-8?B?czIvUDRSWS9OUXArV2JvZk05VnE2VVdPODc0QlpzS1NCenp0VWsvcEZlSFZ2?=
 =?utf-8?B?R2VMM2FpUTlwLzNZUWJNNlVnaWhBMmo3SHlFYzllQWZVdGthL2JvUU1NSGRN?=
 =?utf-8?B?eE56aWNJcmNvdm5hQjRLWVYvU2ZsbGlnUEZWMUd3eHJ3c2IxUGtwZTZ4NkpI?=
 =?utf-8?B?ZWxzbnlYMUZhbWUyM1ZjN3RSUEErcGpFUHN4N0ZIN09Fc3dPbHBtN2htRCtx?=
 =?utf-8?B?aVNaYlBubmg1NXRROHZ3MTZVUHBEOWVZM3dncllpVXk4RDI1U2ZpZXJaanRQ?=
 =?utf-8?B?cHNoVVhRQ2dCSk1wWjBWVS9Gb3M1TjRSL2wrYXp2UkVUamdGQ0xsYndDVE9o?=
 =?utf-8?B?THJQV2NHVFRvU1dpSE5jN09mbGxHa0h5WEpMejVMK0RuK0FhSjNqemZndERY?=
 =?utf-8?B?L0hnanRRNVZMVjdmRWlubFJHMi9LQXpkTjZFVmJwTmZob1lSeHhNQzFnRjZE?=
 =?utf-8?B?dkdUbHRza0pVQTlOeGc1c2V6NGdDRG5LWUpPOU5zbzR5QWdPaFZVSXBsR2Ur?=
 =?utf-8?B?SmNoUnROeW5kVW9MWWdHR0ZsbWFvK3pnREozQnRvK296KzVLYXRZTFRrallY?=
 =?utf-8?B?ZXJMWk5IbVNuY1IxSHRNNGxjelhLZkNxVGxBRUJ5MDhwRkloYWxCdnRrY01S?=
 =?utf-8?B?VHhBOFR5MUNyUFRsQkhhUk5tRmdtTVU2WWw4RHlpV05aMnFEWTJtRWViSzZB?=
 =?utf-8?B?VHJEWGJ3MmhZRHdBSzRaTzN5S01YTVZXMWtxcDEwaTlwT0VWdXJuWEk5V3lE?=
 =?utf-8?B?NlEzVlRucGE3VmphV0tNcUxqYkxHTElISllKU2hYQmxxODdWUkE2eXJ5UU1W?=
 =?utf-8?B?TlZiK2c3aXBsalNockhNNmpaaFBlNE9jeGNwSlEyK0U0QUVkUkdBS2c3WjRa?=
 =?utf-8?Q?O5xig9tSOdZec?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlFmRlNFMlJHa09ubFpBSzBPRzQ4b0s5TUdSVHUrUnpvZDRCa2NQRkVFajNp?=
 =?utf-8?B?b1JQNmlXcCtCUXVZb3piT0dHZ2lWaFplc2xtY0hLOS9uRjJTdXo0ZCsxaDdX?=
 =?utf-8?B?cWg0cVdVMkpOWnBKcXJ1U2VEbVUvaUNwTUxVQStISVVKOWplbWZlWlJoZnBU?=
 =?utf-8?B?aTlnT2U3UEtXd3NVK3dSYTlWTDdtbi9NMFpSeDJiSGxPWlA4MUQvK0RpS0pH?=
 =?utf-8?B?QmpyZWFHSXlUSnpud0RJZHpJc0xjblVSd1NVQ1lhSzZNZk9sak0xZmZKaUxG?=
 =?utf-8?B?NndaYUN3LzNWYlZjNDBEaTQ0ekdYV21VWk5BTU85L2ZBOTQxcUFxN1czbnE2?=
 =?utf-8?B?RmlwdHFmREU5VCtsdUVaMlJJOWhFbGtJOWZ3SnJMTm54cHBuK2tTNjNCTkRO?=
 =?utf-8?B?Q0ZpV2N6ZlpoUS91Ynd0am15VlBiTmhUUzFnZmdxM1RZN2cyUGsrbW1KejdP?=
 =?utf-8?B?bUNTY2pYaUZmVXMxaDZLLzJlaFRqNHdvSW9FbWFBWmxCeU1tQUFjL2lGNGdM?=
 =?utf-8?B?QTg3WDVMcHVCbyt6eVlOdFFQTDh2N2NBVHlPZU44Zjl2TnNGNzdsaW5KRWRP?=
 =?utf-8?B?NEF0dThJQTkrWnZwaUFKbzQ0SzJMc0tUY2VRMkFCSXYxU2hENjh4OXVjNWZQ?=
 =?utf-8?B?L2dBTWhpQUlJTTZKMGprVTVScGt2K1B1b2ZML1NVellkcjdQVGs0RGdEZGRS?=
 =?utf-8?B?OTJUaU44ZE5qUitsQkh0b0tmRlQ5c1ZwbEJWNmNPbUo2bzVmaXN5QUhpcWVY?=
 =?utf-8?B?QVgvcmFBTUJ1d213OURGWDU4UUJsUXVEUzROdGF6MEUwcEJnaW01bVJQeU1S?=
 =?utf-8?B?SDh1Um4wd3Ewb3FzN3JabDAydWM0TnAxS0hSVUF5WG5XenhxNGUwdnV0LzlQ?=
 =?utf-8?B?cjBUdWRDalVQQ29WVnFHMVFubTh3UFRWVkFCdzE1UGlmSEFpNkVZT1dONGhZ?=
 =?utf-8?B?NnFsdkpRSHdsMENqV0dBNmx5eFJkYnNuSWUxR0sveHdyamdqU2VpSHlpcldY?=
 =?utf-8?B?Nk50alZ0eS9HZmEzZjcraWxyY2hQWnhCVE0raE5mRStOU1hhbWdkdzA0WXEv?=
 =?utf-8?B?Sys2cmFnTWN1ZG02TWpnekl0WUs3blFkVGFvSnd6cW9zYlFvSFpUVGppcUZh?=
 =?utf-8?B?U25Sczllb2tnT2hUVis5WGRGdUtTMFdrQzhIbElzY0x2MndUK3B3dlJGVjFU?=
 =?utf-8?B?d3lTQ0dPOEVxb1BONElwYVFJQ3NreERPb044VVhKVmJyZS9VeFBIVXBMeHpP?=
 =?utf-8?B?cnpNSEpOZThvUW5tekJYOGJlWmk3MlY3THd3VnRoODBCeHFlQ2VIb1RCeUlh?=
 =?utf-8?B?SzloUVVpWE9vQU5IeHNMZjVZSEF2L3JPTEF1aXVpN21DWG43OG9vU1Z0VFFK?=
 =?utf-8?B?VHlzYy9lZjNEV25ZNjJlR1Y0OEo4dC9HbzM3RzBBcXNkQ0psR0dlK2VDc1Bi?=
 =?utf-8?B?STVPTVFVV3ZxTlFVZmh4RWladG1na1ZYaTBKeDVsalZCTmdpVm9UYUVJWFla?=
 =?utf-8?B?UkVZdkJWWFdxejZWR0lHcXFJdWFGWUgzR2VLQUMwUTRFU2hoS2hRZGN6R3py?=
 =?utf-8?B?Q3NMTlgrYkMvSzEyMlJCc1B6S09rS241WVhiNFZzbWJLRUNPekU0UHN3NVpY?=
 =?utf-8?B?SzFxYXcvUFZWbmNIbWR4cElqZ0lCZWQ3RC9oSEpkejA2blBVakx4VzhLR3Nx?=
 =?utf-8?B?c0Q1UExob1J0YjhPQkt6VmxvR1N6anRmVWgzYTJQbE0yVTQ4OWsrR1pNdWgr?=
 =?utf-8?B?R25mYXRmTG9salNSNWcxVkRiZTdsZDJDOUdMQTNXQXBQa01EZXpJQnZnYk9E?=
 =?utf-8?B?dlFaVHZVN0cxZEdaTUVQdVI5S3ZQV1Z2bG91QmdIZWVJQkJMR2d1SDlPbStl?=
 =?utf-8?B?RWlzOEp1V1ZQOUhUQWZ4dFByMlNrV0hlUU45UDhRdC9xYi9kMkhoSnZGMWxS?=
 =?utf-8?B?SkNwOUFjaGJ2M1Bud3M0YjExdFd3WkpDbXJYNDRFZ3o0N2Y2UWVjbnN4VVRo?=
 =?utf-8?B?bkhrdEc0Y25WV09lNklQRjJ1YmZYVXlSdEJaVzBoczluOXduWmdWVmVmM2x4?=
 =?utf-8?B?ZkdxN1lzeHpmaDI4dEh2MzRwQVlzRXpaYzhkdU8rSDI1UEVuSng4cEtqY0s1?=
 =?utf-8?Q?alGk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd045f7-c74a-4f78-594f-08dd02e52a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 06:42:23.6208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QkF1vLmMXPvglQZnRX+Pgv6NXloY3wFa+V7ztDftJRaeNqoSIZG8cTk+EMY5cHObEzWEcNZU2jWlMOLYncT5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQg
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDEyLCAyMDI0IDExOjI4
IEFNDQo+IFRvOiBBYmJhcmFwdSwgVmVua2F0ZXNoIDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNv
bT47IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+IENjOiBTaW1laywgTWljaGFsIDxtaWNoYWwuc2lt
ZWtAYW1kLmNvbT47IGZhYnJpY2UuZ2FzbmllckBmb3NzLnN0LmNvbTsgZ2l0DQo+IChBTUQtWGls
aW54KSA8Z2l0QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjExIDMvN10gdXNiOiBv
bmJvYXJkLWh1YjogYWRkIHN1cHBvcnQgZm9yIE1pY3JvY2hpcA0KPiBVU0I1NzQ0DQo+IA0KPiBP
biAxMS8xMi8yNCA2OjA3IEFNLCBWZW5rYXRlc2ggWWFkYXYgQWJiYXJhcHUgd3JvdGU6DQo+ID4g
QWRkIHN1cHBvcnQgZm9yIHRoZSBNaWNyb2NoaXAgVVNCNTc0NCBVU0IzLjAgYW5kIFVTQjIuMCBI
dWIuDQo+ID4gVGhlIHVzYjU3NDQgZHJpdmVyIHRyaWdnZXIgaHViIHJlc2V0IHNpZ25hbCBhZnRl
ciBzb2Z0IHJlc2V0Lg0KPiA+IFRoZSB1c2I1NzQ0IGh1YiBuZWVkIHRvIHJlc2V0IGFmdGVyIHRo
ZSBwaHkgaW5pdGlhbGl6YXRpb24sIHdoaWNoDQo+ID4gdG9nZ2xlcyB0aGUgZ3Bpby4NCj4gPiBB
bHNvIHVwZGF0ZSB0aGUgdXNiMjUxNCBodWJfZGF0YSB3aXRoIHRoZSByZXNldCBkZWxheSBhcyAx
dXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBWZW5rYXRlc2ggWWFkYXYgQWJiYXJhcHUgPHZl
bmthdGVzaC5hYmJhcmFwdUBhbWQuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBNYXJlayBWYXN1dCA8
bWFyZXhAZGVueC5kZT4NCj4gPiAtLS0NCj4gPiAgIGNvbW1vbi91c2Jfb25ib2FyZF9odWIuYyB8
IDIwICsrKysrKysrKysrKysrKysrKy0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9jb21tb24vdXNi
X29uYm9hcmRfaHViLmMgYi9jb21tb24vdXNiX29uYm9hcmRfaHViLmMgaW5kZXgNCj4gPiA4Mjdl
Y2Y5YjAyLi4xZDE0NmVjY2VlIDEwMDY0NA0KPiA+IC0tLSBhL2NvbW1vbi91c2Jfb25ib2FyZF9o
dWIuYw0KPiA+ICsrKyBiL2NvbW1vbi91c2Jfb25ib2FyZF9odWIuYw0KPiA+IEBAIC04OCwxMCAr
ODgsMjYgQEAgc3RhdGljIGludCB1c2Jfb25ib2FyZF9odWJfcmVtb3ZlKHN0cnVjdCB1ZGV2aWNl
ICpkZXYpDQo+ID4gICAJcmV0dXJuIHJldDsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IG9uYm9hcmRfaHViX2RhdGEgdXNiMjUxNF9kYXRhID0gew0KPiA+ICsJLnJlc2V0
X3VzID0gMSwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb25ib2Fy
ZF9odWJfZGF0YSB1c2I1NzQ0X2RhdGEgPSB7DQo+ID4gKwkucG93ZXJfb25fZGVsYXlfdXMgPSAx
MDAwMCwNCj4gPiArCS5yZXNldF91cyA9IDEwMDAwLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgdWRldmljZV9pZCB1c2Jfb25ib2FyZF9odWJfaWRzW10gPSB7DQo+
ID4gICAJLyogVXNlIGdlbmVyaWMgdXNiVklELFBJRCBkdC1iaW5kaW5ncyAodXNiLWRldmljZS55
YW1sKSAqLw0KPiA+IC0JeyAuY29tcGF0aWJsZSA9ICJ1c2I0MjQsMjUxNCIgfSwgLyogVVNCMjUx
NEIgVVNCIDIuMCAqLw0KPiA+IC0JeyB9DQo+ID4gKwl7CS5jb21wYXRpYmxlID0gInVzYjQyNCwy
NTE0IiwgLyogVVNCMjUxNEIgVVNCIDIuMCAqLw0KPiA+ICsJCS5kYXRhID0gKHVsb25nKSZ1c2Iy
NTE0X2RhdGEsDQo+IFRoaXMgXiBodWIgaGFzIHRvIGJlIHVwZGF0ZWQgaW4gMS83ICwgb3RoZXJ3
aXNlIGlmIG9ubHkgMS83IGlzIGFwcGxpZWQgKGUuZy4gZHVyaW5nDQo+IGJpc2VjdCksIHRoaXMg
aHViIHJlc2V0IHdpbGwgYmUgb3BlcmF0ZWQgb3V0IG9mIHNwZWNpZmljYXRpb24uDQo+IA0KPiBB
bHNvLCBsb29raW5nIGF0IHRoZSBVU0IyNTE0IGRhdGFzaGVldCBmaWd1cmUgNS0zLCBpdCBzZWVt
cyB0aGUgaHViIG5lZWRzIHQ0PTUwMHVzDQo+IHJlY292ZXJ5IHRpbWUgaW4gU01CdXMgbW9kZS4g
RG9lcyB0aGF0IG1lYW4gdXNiMjUxNF9kYXRhIC5wb3dlcl9vbl9kZWxheV91cw0KPiA9IDUwMCBp
cyBtaXNzaW5nIHRvbyA/DQo+IA0KPiBBbHNvLCBpdCBzZWVtcyB0X3JzdGlvIGlzIDV1cyBpbiBV
U0I1NDc3IGRhdGFzaGVldCBmaWd1cmUgMTAtNCAsIHdoZXJlIGRvIHRoZXNlDQo+IDEwMDAwdXMg
ZmlndXJlcyBhYm92ZSBjb21lIGZyb20gPw0KDQpXZSB3ZXJlIHNlZWluZyBpMmMgZmFpbHVyZXMg
d2hlbiB3ZSB1cGRhdGUgdGhlIHJlc2V0IGRlbGF5IGFuZCBwb3dlciBvbiBkZWxheSB2YWx1ZXMg
bWVudGlvbmVkIGZyb20gdGhlIGRhdGFzaGVldCBzbyB1cGRhdGVkIHRvIDEwMDAwdXMsIHRoZSBs
aW51eCByZWZlcmVuY2UgaXMgYmVsb3cNCmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51
eC9jb21taXQvOTA4ZjYxYmVkYjJjNDBjNmQ4NTZiYmZkN2Y4NzBiOTY3YTRjYjQ5OA0KDQpUaGFu
a3MNClZlbmthdGVzaA0K
