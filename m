Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE463CF34B1
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 03:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37B2688580;
	Fri,  4 Oct 2024 05:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r2n2m3hM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CECE488CC1; Fri,  4 Oct 2024 05:02:39 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7747788580
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 05:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njhCAmlY6YyXIrg80Zyvcz2DAJpa90UnTFpL+f6tlC+B6iCn+SnN/smAxNxWeWwdC7lDGTbnjkd1AOP9hBjh7SbVwjpdmM06XEkfJdL0SAD3K09mQK6f4iAqTDqwlt3Gk/3quOX/MJLd6mMjk4x2IjTUMwFWqp8Y5xqP4ad2YkeITO3PmkJ3XI54FMySs17jPReSCDWN8fGHjNkTZEuCHGCuP/o9E/Nijkauv5bfOmshEjV1dm7JT9/7RTAYBh9zIhcSxSPb6lixk9vNEjzcyhsGaT103AJ4+xsaEmUzdXwmo5/cGhDRUHHJ3Epma9XcqET3Lkc+aShX0aIm/XvYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVJAoAZmkXtacWoX7JLWDMo/0hdp7vSWj/8B5I3nuE8=;
 b=GsemtiHIEDBTwirf2bavA5yF6B5bUOd1vyzRzreNOAX8qHJRcuYQzwrMGMUay2PhOzkLQEAyMWoVmN9BSbxpxSW8/Cc6dzD9aEPrLkKG82QwVnWAtVGIBmaPnz2ryZEErhumF5WMHQmXdMNHfsvymSSYjkKgN92roNI/PK4J/YfciZrDFnFHI+Pb14T3znPXrv/5EBQ0XZeZAX6qr/KY3bdOYZkU6pnSr5YqEOkgnoIFzvkIy8felKdFeQb0oJNVm6I3+wr0UfDOCzRLMahPmA5ax3+n7J+BRh0gvitnqcaQb+KU0pnOzvOVyVf076kmjAfIC1EojGNO3FaCOV5JPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVJAoAZmkXtacWoX7JLWDMo/0hdp7vSWj/8B5I3nuE8=;
 b=r2n2m3hMoWnIDhNrjJYn2tcjBp2mSIE6uPJ6E1xf5O66sSywHFgdelldRDFPuaMFM2sgD7tDQAcf4nIOo2DuMllql0rsZHAEh5YvdYtI5l9KlXT/4Zje9sRldTwXS0PsSeLuyggMEZ+nA+6Z99Tc0/9zm3wZc83dCl5ABTcxSBs=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by DM4PR12MB8521.namprd12.prod.outlook.com (2603:10b6:8:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 03:02:32 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 03:02:32 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v3 1/7] usb: onboard-hub: Add reset-gpio support
Thread-Topic: [PATCH v3 1/7] usb: onboard-hub: Add reset-gpio support
Thread-Index: AQHbE8Cw1wwSjzBcqEOkNkd+RtrWkrJxyouAgAKoQHCAAH+OAIAALk6wgAAknwCAAKXiUA==
Date: Fri, 4 Oct 2024 03:02:32 +0000
Message-ID: <SA1PR12MB869735B41B6F7A86520E2D3D98722@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
 <20241001050529.17922-2-venkatesh.abbarapu@amd.com>
 <6056a273-2699-4e94-93e8-ddc96084bbba@denx.de>
 <SA1PR12MB8697873F2C2EF86E6E9DAF9B98712@SA1PR12MB8697.namprd12.prod.outlook.com>
 <2e0928c8-e03a-44ae-aa36-3d664ed5bc6a@denx.de>
 <SA1PR12MB8697682FEEE48B015EE82E0398712@SA1PR12MB8697.namprd12.prod.outlook.com>
 <c40f47cb-7245-43b7-9b01-6b8d1cdff04c@denx.de>
In-Reply-To: <c40f47cb-7245-43b7-9b01-6b8d1cdff04c@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|DM4PR12MB8521:EE_
x-ms-office365-filtering-correlation-id: a8c3f7fd-aa41-43d9-0896-08dce420fdb5
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WWpYRFI1cVZkZ0tJVi83RXZQakpoSlhtUkRpdGNDRk1VT3IvZFkwd0lCY0hG?=
 =?utf-8?B?VkxUR0loODlmTUMwZTRIQXdkNEJKWkFXRWY5WTU1bThKS3dzRHZTMVpaeVlL?=
 =?utf-8?B?VEtCOGlPQUMzN0Z5T0NZQXYrSmxHcUZsZHlVVm9aZ3Y4L25xUmphRWFHK0o5?=
 =?utf-8?B?SHlGQVRPZGNzTDNmd21QMFU3T2tKK3VkRXZnazBXNUxQVW9QOHhlQmhMZGd1?=
 =?utf-8?B?aTZlbXpQVDVxNThwM05DVkwzd2EvN2NiRUhqQ0ZzbWxPTDFERUZ6YXk5Q3V3?=
 =?utf-8?B?WjNxMUtxbkZxaW1ZbzM2dDFSdmJxSFpRQTZTdCtyUERkaXVWRlc1UXRkR3Vz?=
 =?utf-8?B?MmJzSFNQaTlVeFR1NXBGMUpRWEMrbExkNHd5a2hUYytzWDZBRWtmdVNHMFhL?=
 =?utf-8?B?TWg2OUZFbTN1SDQ2YndIemhYdW9BR1J4ajFMRHcvVlBBanFBbjRzVTlydzAr?=
 =?utf-8?B?ZW1YQnBMeThDZmVsSDFWN1c1eVJTYkV4d3M0eFZJUlAwbUxURTRPc2dKY3pa?=
 =?utf-8?B?Z2t5djhMaDl5QWFzUVZSYXNGUkF5bllpOTk5aFExQzlTN2pNNkxjdCtwVEhZ?=
 =?utf-8?B?eTBidE1xZzJ5Tit1RTBEVm15dlpOS3dkV011OWFIMkE4bkNPS0ErUHZ6NE5y?=
 =?utf-8?B?TGRNdDhpTVB1UUQ0MlprN0dFTGFJYk9hOE9RaGtrcFM5SDd3YXdJUlVWbTN5?=
 =?utf-8?B?TnZvWDJtYzhRWlRVRkxRMkVCQndtdTY2ZlBqL1JUREZMWjRPajNVMmxFSUoz?=
 =?utf-8?B?YkhkZnZGVEd2Vm9XbXkxc2tnc0tVWkRvdmZDMkhESW45Ykx3VHUzTFVGY2pC?=
 =?utf-8?B?MHVmU29ydTF6RkFUcHBEYUNQK1lLSlcvazJaVm5QbGlIY3gyMW1tWmxSSXZn?=
 =?utf-8?B?aDdvR0tPYXYvUncwZDJjaURyOGcxdElQaUxTU2ZwWlpaYU1RbTVJT3Azclgy?=
 =?utf-8?B?RVNoS2lpTFhFQUZucnYxMkZLaGEwYWRIbE1vY3VFclVjN3dSQ0xGcHJGQlFy?=
 =?utf-8?B?SlcrT0xUeit5dWR5RVFpK2psRUNUZGwzVUhna3RVU1NBclJWSjhIZUt0TTM0?=
 =?utf-8?B?MDlLMTU1ZWFjWTJwaDFHWU00L0RMcXZWbWlXdmoxU3BsT09oMHloMWFYc1Jq?=
 =?utf-8?B?VmpLNlgzVHI1WGlxWmlsNVNrRUlPdFdNTS92emREZy9pRGFhRWVLWWcvbjZH?=
 =?utf-8?B?bDNUQXZiQW5KVkduVWdsR1E1ckQzbzhwTFc4Rm5ucE5LU21BYnNFeWlxak9h?=
 =?utf-8?B?U2djVUErM3cxUjRIM3VydEJSRVpSN2J4ODNVRzVIQUtqM05QWUNPTjFOak1o?=
 =?utf-8?B?Q2RiM2pTVHVWVDFqUFcrWHhmQzVoczJtR3hxRDlTYiswQmRka1Bja2R5cE5z?=
 =?utf-8?B?QUNoclNBWHNYYW1CQ2xSbGU3RFR6bEg4M2FIRzN1bHoxc3J2VHFhOUpQWDU1?=
 =?utf-8?B?YzVDR1lHWTlRNjVocEgvcE5aR0lHUkxNK3ZwWmUwN240OXl2YXNpMUxiTTNw?=
 =?utf-8?B?c0JEeDNmbHVaMG43Q1lnZnh2eS8xTkFmazNST2EvdmFGek9uT0hPT0RacFd1?=
 =?utf-8?B?MmZaRHpWclJ5amNZMmovVkVXQU1rVWZ0NGdJSDhOcmFQbTVnL0N3RkVveHB1?=
 =?utf-8?B?aHpUamZEZ25qSTA0NkFtOG1wc3NUNjJURk92aXBrSjEwdllYRHZmUk1IN0pB?=
 =?utf-8?B?YzNKRVRoVjdpMUt0VDhUZFRJNTJzckFoSVVCVVIrQVdYa2x3cGIyUjB6Ri9Z?=
 =?utf-8?B?OUxpQld1OXViNmRxZUw2SCtocU94UCsybTg5NktXTGh2aGJLSlBnS3lxcUZF?=
 =?utf-8?B?VVRwQTlKaDVDdTRMN1htUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YS80SlBxbnR5RW93c0hnSmUxaExwZVVnQU9oNWh1OUhnU25PdnBXWWs4WXVh?=
 =?utf-8?B?RWhiZldZN2hvY0Yyc2plTklpUXREbG0rTStMSUMwQzFUSmlvbXdFZGNxNDNo?=
 =?utf-8?B?MllOL0tvSFNMS1BvcWVhRFJaV0hOdFBYN3czWDN1aDBJVmZNVWFDcFVqakY3?=
 =?utf-8?B?KytiaFV5Z0hLZzJET2p3c3N2c2o2cDh6ekJOVURDYXYzMUhpSXl0Rng4NjF6?=
 =?utf-8?B?aEdSY0RXeEc0WC9DODQ3SHEzRXJBSklHWitVYTA4RGZ6K3FhcGVyNkh1a2tU?=
 =?utf-8?B?SnZoYW5TRGFyQU9DM0dJb0RjZER4Tyt4NFkrK2lSSnZpVjhENzJIWllZUlJ1?=
 =?utf-8?B?cjFuYmZycUo0SFJwZTk4dnVaaDRKZGgyL1h4YmhrZllCUUcwdFdkZmRySWln?=
 =?utf-8?B?ZFhocS8rZkloQityeU9yQmkyQ3E5OEZVU3c2SVpRalVFVDUwdU9HN3RLbTQz?=
 =?utf-8?B?YlhURG1PUHRySHU1bUNtYnRqcG1KRXBZVm9MTGM0MjNZblNEUGRiayt2YTZj?=
 =?utf-8?B?KzlDbGJmMGxnN2dFWUFUOHZPV3dzdzlvZWcwVDNBNTFTV25uY0k4U1VLcFQ0?=
 =?utf-8?B?ajVKV2FKTG8wVlVyUVNwelQ5UmRWK3IwSStPTlF2clY3NGZwQm91czNnMXc4?=
 =?utf-8?B?VXg5MUdpWjJrVlZsYXNZV0NWLyt1ZXhiQlg4bVp2aW9pQXIwb2VkMEEyY3ky?=
 =?utf-8?B?ZFNranQvT3Qxb0YzM1lob0M4dWhlRDRwdkZtWkpYY0NmcndrYTFONjN1bmND?=
 =?utf-8?B?cWdWeEVzZFRiVmJWdGl4ZGlQbUZUYlJ5Vkx5eitzK1Z2YXpGR1d5MlNKTGox?=
 =?utf-8?B?TzFod3BvMWZ5bXVPTzFwMEZhNjZ1SjRSV0ZHcjgydG9MR2VRS204cGhhYUkv?=
 =?utf-8?B?OEk5NklLSFhjczZhQ3Q1d1VPVEZVUzcwUW1SZm1WeUZGdG13alVLOGVRejIz?=
 =?utf-8?B?TmM4YUNZRllzVjFBcFBWaDZFVEpkNWdBVjNEMDA3SUdJL3RXQ2hhWDcwTXJJ?=
 =?utf-8?B?N3FLMzhyQW8zanI1d0syQnByNnNnTGZVcWJZSUhaajgwMlBKUHdjQktlcXlu?=
 =?utf-8?B?bEs0cFdZRHl1c1d3N3NLaUowZHNIc3FjejA3V0YxR1paTDRQWm9nK1RvVVVw?=
 =?utf-8?B?OElBZ2NiMGkwVUZtZ0dGRytXakQvL2FtOTBLZmtyTDNqZldrZlp5bm52VzFj?=
 =?utf-8?B?cHlYMmFqWEwrSDZWT0E1ckxLSE5zOGd0dXRBaGR0Tjh2ZjR0OVlHWkdESytS?=
 =?utf-8?B?QXIzZWtvSzRqa0RoeTJWTFhBSzFJTmUyVXhSYmxBQjgydlFMa2hzQ1NuQlBV?=
 =?utf-8?B?K1V6YzhITXo1WUhJRUxpRVRndTFHNjc5YW84eUFCUkRrTzl0bnBtNHZRTnpU?=
 =?utf-8?B?V21UTXNMTHFUaFNHalhCbU42M1NWQ0xzNXdyZFJQSVRROHdRR3FMUHNnWDBY?=
 =?utf-8?B?OE1UREVhVnBUTWp5TE5PUTlMUmxWODlrUW5tSFp4WTBDaktQYWdzWjk2ZmZ0?=
 =?utf-8?B?U2FRKzlPbUc4WVZGODFJWUhuUnRPUjNmUlNqTUFLQjcrTnpVWkZaUVRVK0gx?=
 =?utf-8?B?OXVVV0NkRkQvcCtzMUFmdjJvd3ZIZUttZkhtOGtUMWVxYkhxRFh6Ym1Ud2ZN?=
 =?utf-8?B?MjRVZ1VzWk0zZXlwUmFwNW5TdWlDRHV6elNlQ1pkNGV0ZDdPRXdkbDlsL3Nk?=
 =?utf-8?B?SHRsSVo5bkp5NHRtZFFaNE9vY0tmUDZDS0tOQW9IbGR5bk1TbnVQZm95ZmJa?=
 =?utf-8?B?dXU5Y0p0SFpGOElKdERvSEJOaWNuREwwbi9BVTdhRDY2R2JJdHBCaFF1SVNF?=
 =?utf-8?B?VlphTDFFWkFDd28rN0NwNHJ0K3dvelBTak5hQXBMNUIzaTVuaXMxNm1Vdk1U?=
 =?utf-8?B?Wi90d0RvN3NoTGRDaXpuZldVSHRZM2NrK0QwWTJaOFpQNEV6VmhwMC9jaXFh?=
 =?utf-8?B?ZFpPc2hsdldoN2xTV1lBUDZRUTZ1dDM5UldLU05Wb3V4SUZzanV6RGYvRDNP?=
 =?utf-8?B?QVRtbGZlSHhYWnRCQlczYXJKdzRuWURCT2tvK1F4YmVZaHplenRUdUo1T3hH?=
 =?utf-8?B?NytNdUUrcGNhNEIwU2M5OVlaRTZsSkNKNkJJSUcyRnQ2VTdoM2I1WDd1aURP?=
 =?utf-8?Q?3rQg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c3f7fd-aa41-43d9-0896-08dce420fdb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 03:02:32.6230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XEHTm5PZuXRxjO+dC9rablgtKoEqguyTey0PWODlgy9O7xPSdMrrDCzNcsXxvmmy+QWQtPOhVoYeZbaTqzcv5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521
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

SGkgTWFyZWssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsg
VmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDMsIDIwMjQg
MTA6MzUgUE0NCj4gVG86IEFiYmFyYXB1LCBWZW5rYXRlc2ggPHZlbmthdGVzaC5hYmJhcmFwdUBh
bWQuY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IFNpbWVrLCBNaWNoYWwgPG1pY2hh
bC5zaW1la0BhbWQuY29tPjsgZmFicmljZS5nYXNuaWVyQGZvc3Muc3QuY29tOyBnaXQNCj4gKEFN
RC1YaWxpbngpIDxnaXRAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzddIHVz
Yjogb25ib2FyZC1odWI6IEFkZCByZXNldC1ncGlvIHN1cHBvcnQNCj4gDQo+IE9uIDEwLzMvMjQg
NDo1NCBQTSwgQWJiYXJhcHUsIFZlbmthdGVzaCB3cm90ZToNCj4gPiBIaSBNYXJlaywNCj4gPg0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBNYXJlayBWYXN1dCA8
bWFyZXhAZGVueC5kZT4NCj4gPj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMywgMjAyNCA1OjM4
IFBNDQo+ID4+IFRvOiBBYmJhcmFwdSwgVmVua2F0ZXNoIDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1k
LmNvbT47DQo+ID4+IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+ID4+IENjOiBTaW1laywgTWljaGFs
IDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47DQo+ID4+IGZhYnJpY2UuZ2FzbmllckBmb3NzLnN0LmNv
bTsgZ2l0DQo+ID4+IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+DQo+ID4+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjMgMS83XSB1c2I6IG9uYm9hcmQtaHViOiBBZGQgcmVzZXQtZ3BpbyBzdXBwb3J0
DQo+ID4+DQo+ID4+IE9uIDEwLzMvMjQgNjo0MCBBTSwgQWJiYXJhcHUsIFZlbmthdGVzaCB3cm90
ZToNCj4gPj4+IEhpIE1hcmVrLA0KPiA+Pg0KPiA+PiBIaSwNCj4gPj4NCj4gPj4+Pj4gQEAgLTMw
LDcgKzQwLDI0IEBAIHN0YXRpYyBpbnQgdXNiX29uYm9hcmRfaHViX3Byb2JlKHN0cnVjdCB1ZGV2
aWNlDQo+ICpkZXYpDQo+ID4+Pj4+ICAgICAJaWYgKHJldCkNCj4gPj4+Pj4gICAgIAkJZGV2X2Vy
cihkZXYsICJjYW4ndCBlbmFibGUgdmRkLXN1cHBseTogJWRcbiIsIHJldCk7DQo+ID4+Pj4+DQo+
ID4+Pj4+IC0JcmV0dXJuIHJldDsNCj4gPj4+Pj4gKwlodWItPnJlc2V0X2dwaW8gPSBkZXZtX2dw
aW9kX2dldF9vcHRpb25hbChkZXYsICJyZXNldCIsDQo+ID4+Pj4+ICsJCQkJCQkgIEdQSU9EX0lT
X09VVCB8DQo+ID4+Pj4gR1BJT0RfQUNUSVZFX0xPVyk7DQo+ID4+Pj4+ICsJLyogcHJvcGVydHkg
aXMgb3B0aW9uYWwsIGRvbid0IHJldHVybiBlcnJvciEgKi8NCj4gPj4+Pj4gKwlpZiAoaHViLT5y
ZXNldF9ncGlvKSB7DQo+ID4+Pj4NCj4gPj4+PiBpZiAoIWh1Yi0+cmVzZXRfZ3BpbykNCj4gPj4+
PiAgICAgIHJldHVybiAwOw0KPiA+Pj4gPFZlbmthdGVzaD4gQXMgcmVzZXRfZ3BpbyBpcyBvcHRp
b25hbCBwcm9wZXJ0eSwgIGJ5IHJldHVybmluZyAwIHRoZQ0KPiA+Pj4gaTJjIHNlcXVlbmNlDQo+
ID4+IHdvbnQgYmUgZXhlY3V0ZWQuDQo+ID4+IFRoZSBjb2RlIGluIGlmIChodWItPnJlc2V0X2dw
aW8pIHsgLi4uIH0gb25seSB0b2dnbGVzIHRoZSBHUElPIHJlc2V0ID8NCj4gPiA8VmVua2F0ZXNo
PiBZZXMuLi5pZihodWItPnJlc2V0X2dwaW8pIG9ubHkgdG9nZ2xlcyB0aGUgR1BJTyByZXNldC4N
Cj4gU28geW91IGNhbiByZXR1cm4gMCBpZiByZXNldF9ncGlvIGlzIE5VTEwgYW5kIGV4aXQgZWFy
bHkgLiBXaGF0J3MgdGhlIHByb2JsZW0gPw0KPFZlbmthdGVzaD4gaWYgcmVzZXRfZ3BpbyBpcyBO
VUxMIGJ5IHJldHVybmluZyAwIHdlIG1pc3MgdGhlIGJlbG93IGNvZGUgd2hpY2ggZG9lcyBpMmMg
aW5pdGlhbGl6YXRpb24gc2VxdWVuY2UuDQpOZWVkIHRvIHRvZ2dsZSB0aGUgZ3BpbyBhbmQgdGhl
biBkb2VzIHRoZSBpMmMgc2VxdWVuY2UgaWYgdGhlIHJlc2V0X2dwaW8gaXMgcHJlc2VudCwgZWxz
ZSB3ZSBkbyB0aGUgaTJjIGluaXRpYWxpemF0aW9uIHNlcXVlbmNlLg0KDQpUaGFua3MNClZlbmth
dGVzaA0KDQo=
