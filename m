Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00550D6DDD7
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 07:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9D1D89348;
	Fri, 15 Nov 2024 08:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mHLu75+A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01D6089328; Fri, 15 Nov 2024 08:07:48 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6740889247
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 08:07:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T51r4gUUEpNTjrxPW7udJn6vBjSCCoeqMbomgpgmSFL28Gs2MU5IkILYVEL+twb38yGjtmA4oo46XFawR2KvYFGkpBUCF9jueO/XMK1/7y5DL0pW9vqORSs2hTNJKcj9Prx/Do5r/pv8hqECPIf61IlftYe9WNnatMc/M2ZxMV47H/2x3LXfft34Pc6PXgc7tR7EpbFmlvLZqD/UJIvM8G+qDeoGCZKgEQu9ceLyC+kudCLyGjWxfacJBo7cQRz6Wdl07+UkEFU1AKYyIJ3W+AApm9Ufvg8nK9NMLrloqKA9/TUilDYbvWm77DOyXx5gF98LGOLy45HYd3dE0/e8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH9GdQBXGvfL/UgwOO3eM83GjC/VO72AD1YZdc/7Xj4=;
 b=tAHE62WshumKxli6qn3ft0YfU/WbNQ84qIBzvQkKCgX50hncXHnNz6eLOBXv9PxjblkJlv2QuwNyYWGpEMcYHBJ2cuPAXD2yboWPh+icKkXlN1lmyKDQp4lySRm1v2nLYEnOEqxrQrGdPGaBn7Y7AP22au0zBAL3rLyUQZE/gdPqmRgNwq7whnGeI8o1PThwKQ541nzu7pq0tJAm8NqN412GJmSG7WFom0pbC422t8DsQ3xN1SQFx6KdgN0XXbledKNyuF2fAocukkhR4BGXGYce6CjgJ16k4xIZt36Gx9iY/PibzdCCCsqVHdumS3rFdiG6ExTRHNmn7gXH3vYIsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH9GdQBXGvfL/UgwOO3eM83GjC/VO72AD1YZdc/7Xj4=;
 b=mHLu75+AFFPcLKWPZWfzr7etBkS+4cn2beU1yRZyRTKgkjO6r2bhMV/S93wvuOmExMHpCD0r+FH1wKg3Jof2YlI+TWVoK/ivr13JyK5QG2HuCQTQ3T1zxystqRWoj0DL6i+86NZhzxe253+kxUb42/sRWaXYaXSn+BgTjg5r+iw=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by SN7PR12MB6692.namprd12.prod.outlook.com (2603:10b6:806:270::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Fri, 15 Nov
 2024 07:07:42 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%7]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 07:07:42 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Jagan Teki <jagan@amarulasolutions.com>, "Bhumkar, Tejas Arvind"
 <tejas.arvind.bhumkar@amd.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "joe.hershberger@ni.com"
 <joe.hershberger@ni.com>, "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "Simek, Michal" <michal.simek@amd.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "git@xilinx.com" <git@xilinx.com>
Subject: RE: [PATCH] mtd: spi-nor: Add support for Macronix flash part
Thread-Topic: [PATCH] mtd: spi-nor: Add support for Macronix flash part
Thread-Index: AQHaLqu+HaS92iioD0KOW6elNrQyjLCu7mCAggsN9BA=
Date: Fri, 15 Nov 2024 07:07:42 +0000
Message-ID: <SA1PR12MB8697C25DF887BF84248F5EA798242@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20231214163623.1924877-1-tejas.arvind.bhumkar@amd.com>
 <CAMty3ZA9TkeWDN3+t=uj=wikF_C5rQzUuCUwf00-cE024h28Yg@mail.gmail.com>
In-Reply-To: <CAMty3ZA9TkeWDN3+t=uj=wikF_C5rQzUuCUwf00-cE024h28Yg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|SN7PR12MB6692:EE_
x-ms-office365-filtering-correlation-id: 98b4be46-223e-46bb-3499-08dd054432ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T0RwSGFjQlhkd0RtdkZJaEc5Z1VPM2xtTjJobFltSHRLTWJxcExBQ0RKNzNW?=
 =?utf-8?B?R0I5L0VLUjFsL3NOTExyTERieWJrYXVQams0RGhMNDhtVUgvR3hUaGlJcEZU?=
 =?utf-8?B?MThGdWtEMk5QTHRhMGV3KzF1dTJpRU5LTUE5ZEx5R3ZFM2ZldmZHSFQyYU9l?=
 =?utf-8?B?eHRkUVZUcnAyLytqUmhxOGhDQnlBRVFwSWFoS1RRbEFzZElXRGV6Y2JkZHJ6?=
 =?utf-8?B?cGttbG5mYlJ6WjEvdlJVMTgyTVlJZm8xMXNLdDVUVnE0NGtTYlI5bk5XMXQ0?=
 =?utf-8?B?SFdVKzlEWDZzMTAxWStoQ3ljNVNmMS90cEplY252VFdEVnh6ZWxwZEVKV0Jz?=
 =?utf-8?B?eEJZZWJiTEFkSThDaVBzeXZPcXJYV29OVG9RaUYxQUdpZ3cvbGpITHFlejht?=
 =?utf-8?B?YzBncVNzbWs2K0RjdUE2MVZKTFk0M3pVSE5DSGoyYVExVFdWQmwrbE5sR0F1?=
 =?utf-8?B?ZzR6OG1pN01NS0o2MGR6MXNTYmJUeHBwVTJqLy9PeW9maG1mL0V5RHJvbDdH?=
 =?utf-8?B?QlhUM0hCamErbjJlNXYxUjFBZXpsYkJ1YUFxaUEreGh3b2V6amFzSHpUR0Yy?=
 =?utf-8?B?cjlFRzR0cXBvOEdoNmVaNFdPNkNqbWJ4NXFTeWNGcnUyRUI1b2VKeTVoZXFv?=
 =?utf-8?B?QklZdThzTFVYNCtkMzlSdHdTN1ZtMUVqT1N2ckZBSUlWVG95TS94Y2p0bWRW?=
 =?utf-8?B?MjByeExkMW0yV3I1SkxlaVVwK0pLeUU1ZkZNRmJRREw3YmhmbjUrekhhV2Zz?=
 =?utf-8?B?ckFlemJiaGRGbnN5T3NYd0dNbDgxdEw0dW0yM1dram9tS2F3Wmp2SzdObTY4?=
 =?utf-8?B?cWtlOFdYWTA3aXFDa2J6THVKMVI2dEVJWjRna081bklFVGl6aXB4aTROTUxy?=
 =?utf-8?B?TDM2VnBScE0zM29JUDNRdFd3Y1Rjd2gwOGFqL0l0YllsNUl1WWU1RzVHaXR4?=
 =?utf-8?B?eGRKbGZiSUJLTGhrVHZISml0N3NCV2xmSTlzbTN2VmxVa1FSOWNOUUFHMHdm?=
 =?utf-8?B?MEhISEp3eGNSbzVmelJOQkxhR2RNcHlnYk5vcUZqQjNLaXFvUlA5TkF5Q2dM?=
 =?utf-8?B?dHAvK0JEbzR3SFR3bG02bEVWeUkxelhRbklzNFA4d21kM3pVV0RCY0owQjc0?=
 =?utf-8?B?QnZkTVRYdCtwemRYcy9seFdNZ1lneGh5QXhzZktJb3RzNUVpdENJNlB5K20x?=
 =?utf-8?B?c1pIcnNXWHd5NHNrOFA1WVhEMENrTkVRYmdRR0kzRjFDVklQckNZTXl6NEtC?=
 =?utf-8?B?ZDkwMURUK0EzZC9TUm1iUkJTYm1jZ29qd0pFTUNmcWhoVUxSb0ZOVHdnWHF6?=
 =?utf-8?B?OFdNeGw4WXNmRWcvL3gxWWdSeXVldFJ1bVVKWUtRK1NFVkgvbUxkakJmczVU?=
 =?utf-8?B?SU55ajRKeWkwRklXZ0ZnM25CT2RsdjlxNld5VVk0TEFXUUhUcTYwd0xPbDlm?=
 =?utf-8?B?NVIrbm5IdkJQWmNaeWtmb25hMzhMOHV1d3B6MUxLUzBKMjdvN2czdmRGaHE0?=
 =?utf-8?B?WXdDSE5yT1JHKzJEQUNQUE1qc0wvOXVlbFdOZEpwc3NDK0VyTzVHdkJNS2kw?=
 =?utf-8?B?enVRRnIyZnppNHpCZE92MmZZSnZQQVBnVDE2QVdEbnRicG53TW4xQksxdDkz?=
 =?utf-8?B?UVlNSGErSWJlRFoxOVRpYlFGOHg4UlpHMUxaY2RRZVBPZjVzTkNNeWNvalRX?=
 =?utf-8?B?RHB5L1V4UnNINW9JNkk1MGpIZWU2SU90ZVdjdFZyd0grem81bk5EWDVKUkZU?=
 =?utf-8?B?MWY5ZkVJd2R5a0VFOU92M1g5RjNCMUF4VnZYVVE5cFd6aXRIQ1M1bmVLRFl1?=
 =?utf-8?Q?GORaWXZOx3uJCjj1/2mhNSvy/Ku/kFp4shugE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjRnSkhaMnZmcDE4RmowZFBwK29DdjVDejVMSmtVTTJ3YndsRlR4WmFldnla?=
 =?utf-8?B?aHR1ZllBMjV5eGxiWWJtMFBDejdNb3hKRUZYbWhva2NGTVRnMGxEdGZ1bWZS?=
 =?utf-8?B?Z21VZHdQN0tLVWJGbEZDYk1mY213SnJ0UWRSVWgwRWt4cEpiNXE4dTVvV1pS?=
 =?utf-8?B?bFRqS21USlNOU1ZwTEZhNHU0ZTR4ODJBUnplenBWazh4bGkvbFFqYlBOVmQ0?=
 =?utf-8?B?TlFlOWJwN3pwNFdFamtYZFFMZlhEanI5U0JHaHhCL0xrUWFLUE5vWWpSSFpk?=
 =?utf-8?B?QURWOGg4VzJ3bjVDZnovMmV4eHA1YUsyOHFSNlZERHBzay9oZVdVK1ZiczQ5?=
 =?utf-8?B?VGh5VFR1VUxmUFI3YlJjV0lqNElaOXp0T1ppT2k1cVFJY1BZdnp6dWlIME02?=
 =?utf-8?B?aldGQU9YS09BVzVRSUIyUHlPRFlOV0oxN2xtQ0NlT2N2K2FJZWZsN2lWZ2hj?=
 =?utf-8?B?RHprQUtUTUVhQ2RHQzg2S1V4TFFuMTdRT3RMZG1jQmgvczc1VHpMb3NNSHFH?=
 =?utf-8?B?d1o0MkxOOTVlYnBZekNZWjc5YXQ3bXduYmswWXIvNU9SVnlLclIyWGxvMWNK?=
 =?utf-8?B?b28vemRvTG0zQzI3MFUwNHlUT0ZzUmlUekxyVGorRU1ZYk5PRy9qd1RDZEZt?=
 =?utf-8?B?WEJMRHVKOWs5eUxudSsxV0treHVVRU9FQ2s1cEIwOHpXdi9mSUpXM2dsaFBN?=
 =?utf-8?B?dHFlOU04aXNXalVKSHFsZnpudHJNd2grcFhzeVNEUm52L3RBUGJIMlVQbUZy?=
 =?utf-8?B?b2FTRktoOExxd0QxdVpZTGhEcHJZY2FBcXFZZWJjSGVLbHpXdWxoY1RpeVBy?=
 =?utf-8?B?WVNNZkZKNE01WXZVRVFocStNYzR5Zmh3VUVPaUdUTEhnamovbVJVQysxNFhJ?=
 =?utf-8?B?eXhSZWJtTnk2WC9JRlp2VEpPbmRXYWhCTWdtS09CWFlJMlVNTnphVG5ySEd3?=
 =?utf-8?B?ZDhwVWVTaDVHRHRIYm9xRlc5NW5ZYVBNOVhjck9iZDIzTmQyakRmWjNKamVh?=
 =?utf-8?B?MWpkWm1SN0lpcXVNdHlVaG5YSGJ3MUhqQlFvL2tzTGkvd1BsaWYrVjc1SFJ4?=
 =?utf-8?B?aXJLN2lKRStDUFl5TmU0SWpFWEs3S1doVkJnQ2xTSFhVSXMxajFpY3Zkam4v?=
 =?utf-8?B?SysrQzhRSFdhYkNDN05jdWp3bk5COUxpemU4TEFHbkIrQ2JvaklITzFQSmxi?=
 =?utf-8?B?SXpNZUx1M0REVG85MGdsaUljOHlzVnVPdlN1ZjN3bDBXR2NSbVBMak53UkF4?=
 =?utf-8?B?YjdYb2MzbjJtRnFxYWhlQklVdmljMjJqR3RYWHZKdm5oNjVyOCtycWpad01B?=
 =?utf-8?B?MEM4RktETTBrU0tySnNwM3lWekM4bEVnWUIyREdUVVNCckJJM2NkMlRrTU9I?=
 =?utf-8?B?bFZTSlZTcVdpd0dJcTY0WmE1S1hjOVBkMi9rejMxbERXYlduRWZ1VTJsT2la?=
 =?utf-8?B?YytRZFh0eTRkakQ0bnhINWErcWlFdnFScEVqd29lS0N6em05SkNnVnNDZmg0?=
 =?utf-8?B?Y0tPL3lnaFVzUnloYzZoNUo2RTFuUXRFOC9wdHF6Z3UxRlFaaE5UZUJvOVlo?=
 =?utf-8?B?Z0VyUG4zZElNVVUrQUlNQ1M1Qll4MnNXbzFZaFI2cUJDblJlKzBkT3JJeFYx?=
 =?utf-8?B?VEt5M2VxbkFkanM4RCtZM1RQYXJRYmNhUkErL2pnU1ovQjVJbWMzN05kTGhK?=
 =?utf-8?B?MS9tUDY4akpzL0lPSXp4djVpdks0V0E1ZXVpdE9ZY3crUjhsSzNuY2g5Rm1Y?=
 =?utf-8?B?TDhaa3hBSmVhdkhERW1RY0tBYmZjMUNza3dtc2F1eE4ycEJtRDVjdDJ1Rmw3?=
 =?utf-8?B?bTJIVUd3VGZ1Zmp0WnhOYTRJa1pyR2s4cFFXa3NmY2h1cTRzRmVpT0RmeW1y?=
 =?utf-8?B?UzJKZUxweHpudTBQak5YMldZM21ienRDRnNFbE9DTThUNkpiUitHOXNlKzZq?=
 =?utf-8?B?STk3bGwzU3NYS0tERVlDUE5KZll3RlJPQzRXb2J2VTZ2OGtIV3RoWUhLREdk?=
 =?utf-8?B?Uk9wK3BFR05PWi90THJZMlBNc2tVcStObzdpVHh6NSsvMVVDSW9sYUVwaHlS?=
 =?utf-8?B?RlV2U2FmeUZpTnhBYjE0NkNHc08reVp4dlRnekx5bytZU3ZRTCtzME4rdWpF?=
 =?utf-8?Q?aViI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b4be46-223e-46bb-3499-08dd054432ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 07:07:42.2335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYKhiYRgfpPfBbbXrXSDiLLLz5N5efvQF8ffcxy3pVrEOnAlHgYGQoVLLWOCRosocEPj+i+PkEjXQ/BRSTuw7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6692
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

SGkgSmFnYW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFnYW4g
VGVraSA8amFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb20+DQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1i
ZXIgMTgsIDIwMjMgNTowMiBQTQ0KPiBUbzogQmh1bWthciwgVGVqYXMgQXJ2aW5kIDx0ZWphcy5h
cnZpbmQuYmh1bWthckBhbWQuY29tPg0KPiBDYzogdS1ib290QGxpc3RzLmRlbnguZGU7IGpvZS5o
ZXJzaGJlcmdlckBuaS5jb207IHJmcmllZC5kZXZAZ21haWwuY29tOyBTaW1laywNCj4gTWljaGFs
IDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IHZpZ25lc2hyQHRpLmNvbTsgZ2l0QHhpbGlueC5jb20N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbXRkOiBzcGktbm9yOiBBZGQgc3VwcG9ydCBmb3IgTWFj
cm9uaXggZmxhc2ggcGFydA0KPiANCj4gQ0FVVElPTjogVGhpcyBtZXNzYWdlIGhhcyBvcmlnaW5h
dGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBQbGVhc2UgdXNlDQo+IHByb3BlciBqdWRnbWVu
dCBhbmQgY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBv
cg0KPiByZXNwb25kaW5nIHRvIHRoaXMgZW1haWwuDQo+IA0KPiANCj4gT24gVGh1LCBEZWMgMTQs
IDIwMjMgYXQgMTA6MDbigK9QTSBUZWphcyBCaHVta2FyDQo+IDx0ZWphcy5hcnZpbmQuYmh1bWth
ckBhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZGVkIHN1cHBvcnQgZm9yIE1hY3Jvbml4IE9T
UEkgZmxhc2ggcGFydHMgTVgyNVVNNTEzNDVHIGFuZA0KPiA+IE1YNjZVTTJHNDVHLCB3aXRoIGlu
aXRpYWwgdGVzdGluZyBjb25kdWN0ZWQgb24gdGhlDQo+ID4gVGVuemluZy1zZTEgYm9hcmQgdXNp
bmcgU1RSIG1vZGUgZm9yIGJhc2ljIGVyYXNlLCB3cml0ZSwgYW5kIHJlYWRiYWNrDQo+ID4gb3Bl
cmF0aW9ucy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRlamFzIEJodW1rYXIgPHRlamFzLmFy
dmluZC5iaHVta2FyQGFtZC5jb20+DQo+ID4gLS0tDQo+IA0KPiBBcHBsaWVkIHRvIHUtYm9vdC1z
cGkvbWFzdGVyDQoNClRoaXMgcGF0Y2ggaXMgc3RpbGwgbm90IHByZXNlbnQgaW4gVS1Cb290IHRy
ZWUuIENvdWxkIHlvdSBwbGVhc2UgYXBwbHkgdGhpcy4NCg0KVGhhbmtzDQpWZW5rYXRlc2gNCg==
