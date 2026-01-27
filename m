Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA87D2F02F
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 13:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3241A8405E;
	Tue, 27 Jan 2026 14:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="he8iQPUr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F50283FDF; Tue, 27 Jan 2026 11:26:39 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36E4083FD9
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 11:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jamie.Gibbons@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGZPd/VZRNX1RDzo+FHsE1dbznkIfTyWOihSBjmqk2Sl5D4zm7CQjd3HHTpQ5A2iK94Bj8qxqN5nowjh1V1noy3w/ObReX3KOzLOVj/Wbx9B82CvgvQdneiIlGNS5fqC+oi0xtvNcGB48isp2txJJ2uBK5QFiZ22V6ObtsJhPrRwUCgyeSRqZZLhlhYY9gA57G5VOHtKrGxCSTdT4Zgf4UvjmQttRd6qKoNUUdQjPSG5RHfP60QomZw0fEkqMbkoSYYO7BEswOTVfR+fD3V+5Xz0uLBcbzUJq7hVDQZe7NFU5kunC++5ReRqo44GGSyqYoexJm1gMtqTw/g8h6JcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ndvpWi83jLZeC6MMPrju4LwB0nx8XPLi29CZ5SvDA0=;
 b=denZGq4e+PEoI1l3WiDB3KT30Ez7QnbPNtkqvslxg5FBdaJtEUATnPwC5Sl2bxIkcwN1ajUDTOiO7NafdJhAEL9y4Y56iEnR5QlpKC5lUX3gz/2c9qnc0q+Vo4SzOsTqETlhwLMmu/VqfvetRekwjPOPyJ4VzYPoU72f1mjc+0LCJ3IQNZ0JLggg1hvxOf2qyB3dm3bAv9wKYVDgD7CKNxzdj7S1wztBRQNjglZFcPg3IG67euQdjq+6LM14aA9R+pF8a0gyqj+6FcAm24/AsYHBUTqwSHNYaZahW4+G8zi81fTp0ifIXOK84H7W8duRrFJU8dN9CnmoMjYkIiHAUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ndvpWi83jLZeC6MMPrju4LwB0nx8XPLi29CZ5SvDA0=;
 b=he8iQPUrX15RSRmWt8L/Nt8OOkh/MIHdCKiEQLvRnCTaRWCcbGTG5w6xaL1ba+XGD8GT0QubLDy1o90T+HON4iqFEbHISXXO6xyoe4O3tDfsKOfv6QCofwgJO7c0UMzGrGsRX4KTsDWV80aDsqN+AMkPafa+94j/2rLtQpAldTXMasn9SDsuvi1AjUIWx9UIdSwk8YvOsldgz4kUB8suUBdWgO+jtwNcLcJ1rEqA9TWMJuFPSeSg+6yD4QeD9SSH3t9fWJDvgi8WilSBsxdl/IySGiEaPejbkAi4031U5BRbvld0PGV54eHE9u78h0+hYElqRLv2Ur0cT0CkNb8Bag==
Received: from BL3PR11MB6314.namprd11.prod.outlook.com (2603:10b6:208:3b1::13)
 by SA1PR11MB8544.namprd11.prod.outlook.com (2603:10b6:806:3a3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 10:26:34 +0000
Received: from BL3PR11MB6314.namprd11.prod.outlook.com
 ([fe80::2fa8:f753:ee68:e2]) by BL3PR11MB6314.namprd11.prod.outlook.com
 ([fe80::2fa8:f753:ee68:e2%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 10:26:34 +0000
From: <Jamie.Gibbons@microchip.com>
To: <trini@konsulko.com>
CC: <Valentina.FernandezAlanis@microchip.com>, <xypron.glpk@gmx.de>,
 <Conor.Dooley@microchip.com>, <Cyril.Jean@microchip.com>, <sjg@chromium.org>, 
 <u-boot@lists.denx.de>, <marek.vasut+renesas@mailbox.org>,
 <ycliang@andestech.com>
Subject: Re: [PATCH 1/2] boot: Fix dtbo application by ensuring overlay
 alignment
Thread-Topic: [PATCH 1/2] boot: Fix dtbo application by ensuring overlay
 alignment
Thread-Index: AQHciiF0YRm86pfc8E+QGT81o835bLVgNdMAgAWmFIA=
Date: Tue, 27 Jan 2026 10:26:33 +0000
Message-ID: <36c8cbb602754cdad8a20221548da8a79d81b3a2.camel@microchip.com>
References: <20260120153314.95091-1-jamie.gibbons@microchip.com>
 <20260120153314.95091-2-jamie.gibbons@microchip.com>
 <20260123201540.GA2406606@bill-the-cat>
In-Reply-To: <20260123201540.GA2406606@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6314:EE_|SA1PR11MB8544:EE_
x-ms-office365-filtering-correlation-id: 1212b65d-cdf6-45c0-8d1d-08de5d8e8b7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eExkczFuNVkrQVM1OU9GVlZ5Ymo2L24zaW0wcXEwL1kzOEsyOGFxbm1IZC9P?=
 =?utf-8?B?dFd1VC92OUdBOTI3R3J0eEhMWDJ4QlhyRDJLcmkwZS9mVnhCTVJrOG5HaGZo?=
 =?utf-8?B?TnFkZlZkNjFob2FVQ1ZMYkhUQWV1bHdoeFI2QXFJZlFjYXpyWmxWNDJ6UzZv?=
 =?utf-8?B?NWVBRHhsc2duRDJCWE1XblVnZDk0L2QzWGxFV2lvTHlyekZwaTRBWlMxVkpU?=
 =?utf-8?B?YWlwSVZyRDBaQ1JTeGRneEFFWnk5QUVQcnYvSGV4aHl0ZEFSalBjUEpVRzJH?=
 =?utf-8?B?bzNVRmVzL2VpM01kVHpLaDZMVElSRU55RW0zcytTOThUdFFxNk96bWt5OHNa?=
 =?utf-8?B?YzdtbkRMRVVuUWJObmNCeXRRMmhpaUYvRHJYSmRpaFVBSUNPTXI2MUtoaVhj?=
 =?utf-8?B?MVJtWXBHNkJoaTVjb09qdmNXYnM1NGppRXdOandqM0FkaWd6Q3I0Qkh6MEls?=
 =?utf-8?B?eUlXbHB0OEFVZCtTalJJYndCL0tsY2FvSDNCODkzeEg2QWxxUE9IMTEzQmZ2?=
 =?utf-8?B?a08wOVVER04wSC9iREh3dkhleW9RQ05ucEhHK2NpcndyQzU3dmlJbzFHRjdL?=
 =?utf-8?B?Z3JQM0R6YmZaQ1FkbzhnTk5UdVVlZEppS3h5UGRPY1FXcHcvbzhobm05cnFR?=
 =?utf-8?B?ZXhHOWI3MEV0Zk5Pak05ZkErNWFpU1FBWjBCL2dCMzBIenJvMUt1Y21kQThi?=
 =?utf-8?B?T1I1ZzR3ZVYrbnFYd2VOWEdveitCc2ZxbkV0Z21QdXgzZkh3U0JtWThjdXZN?=
 =?utf-8?B?U005T2xrNkdmWGtTb2dyT3BxcXR1MWF1TDNsTEVsdUFyQjd6NE84bFFpYS9h?=
 =?utf-8?B?WmlkaCtxTGVHV3FZcUtaalZTeW5mS2RVQU1WSi9FTFdjRmh2ZGtlOXVzNHZm?=
 =?utf-8?B?VVZCVmFpSTkzVXBRVEZ2WVRBY2FablA0Y2N2V1FuTG05TTAyUmQ2SWFvcU1M?=
 =?utf-8?B?YmU3ejUwOTdwamZTTkRZd3pnazlRSGFodzE1WEZCY25FSlgzSUJ1eGxLcW8r?=
 =?utf-8?B?dkY5aHVUSzlDMEZtOWk4d09PNTBjNnVtYjZzdVdyUEszTUxGbkdIcmxKalJn?=
 =?utf-8?B?TENuYjhyU2ExQktDazdyOGtjTHFuN3NFY2FMZlhxOHBGcG05T045eHBzTWZL?=
 =?utf-8?B?c2hvQmhzR0hreFdVeTNRdEs1L1F6MTU2WHAxUHJOQ3FZUTBtL1lEWW40Z3N0?=
 =?utf-8?B?bjlDTWJJbkFEU05LdEp3RWNDa3M2d1ZNS3haaVBvZXBSMnZBMWNGSTByMHhW?=
 =?utf-8?B?LzFZUkR0OTR6NDg1SklTL0VIL0VFYWNFY0tUU2lpN1BTSXdMV2hqVVpRYTNW?=
 =?utf-8?B?MlAvOFMzSHh1UnV1emJDTlFzemJMSGgyWWw3bWQvZkh2VUhrMm96emZXVFQy?=
 =?utf-8?B?T2xrWkFPblNqTDZxbURuWVVNZW9nUHArSDVOeGEvS1podENwd2dCcWQwaUpQ?=
 =?utf-8?B?RUxNbWtFOHdBMjhsdnlyOGFBV3Z2QVkrV1E0bXlVYThPRlFKUWdFd0hpVU1O?=
 =?utf-8?B?R3NZNDRrRzArcGdaN0xYc002UFdjN0djZ1JUU1JFcG1xamZBeEtOK1VFUmsz?=
 =?utf-8?B?YzlDSFlVWlNZV1A3NzE5a0IyRFJCNEZ1YzRwKzFsSFVMTGNmcFgyMUVXL2pZ?=
 =?utf-8?B?YnFSM3pjT3I0SDNMd2tnbXlINmx2YWxZcW0zdDJheDZoSnRkL2h5cWxQREVH?=
 =?utf-8?B?WFZQbHl3VmN6UlFvTmdFeGh5S24vMVJVaE44OW5GbkFLQXhNckx0VGExK2gr?=
 =?utf-8?B?VFhNUjVrUlY1QmQzcE8zK0gxR2NkWVFZcWloNDhXWkYvT1M3SjJCaHZqTDZU?=
 =?utf-8?B?TW9Bdmh2c2hySXpzVEJIdzdyTkZiZDhZUHhOdXd5WFlHalpiK3dQSmpsL1pi?=
 =?utf-8?B?ZEJmdmpUamFKTjJ1WWxWWWd3aTdlMTZrd3pkTllUbEpaWmlxWUxHL1Z6VDNw?=
 =?utf-8?B?MzlubHJiY2RTTXFjaFhQYTJWREpZb0dLZ1NQL1BVMzNSZ2xuNWgzZlZYR1g0?=
 =?utf-8?B?c1o3R09hNE5RY3AzTnhKU21OMlN2S1ZYRXpsT3dwZ1AzcGhvbmdRWHFpY0lI?=
 =?utf-8?B?YUVyQTR2L1RHWkIxSFBqdW1HRkFjSUJtKzhoNTRlemg4MEdRVkMvSUJYak9P?=
 =?utf-8?B?ZmVyQklBb1FWVXNML1dpeHlFQVozNW02aFFPYkg0cStKZVhndHdIQ1ZzYVYy?=
 =?utf-8?Q?TOfQ4qO/wlYpJHGCkaY8QaE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6314.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXNRZ242L2c0QThGdTJkcERkRnVmY0xhTG9STVFaakVnZHp5UlFnRWR1NVh3?=
 =?utf-8?B?aG9sWTh3TDZ6NUNydEhTQXdxWkZYK1RNMWV6RVZGUE1FZWNDT3NaZDlnSEVR?=
 =?utf-8?B?WEZuN3lNN1M5VGxkeE1kV1hFdVk1aWtwc3dnRkM3MEh0WTBxR1l4ZXZJcUZS?=
 =?utf-8?B?c1p1dE1Vc3VwU21mbEY3VlVmbzRiV1UrdmdtQjVoSDVia0tqV2s1M3JqdXVM?=
 =?utf-8?B?V2RoTFRTNHNPUUhzN2lpYnJ0a1BmTWloMmlXaUlQKzRCK2xrVURoT0EvOUg0?=
 =?utf-8?B?MWxPbEpsaTBSU3E5dGQwNDlaVWltc3o1MUtTK3Z1bnBzTURjY1g0bHB0ZXVh?=
 =?utf-8?B?Z1JvODdoT2xmbDhTZGxNbmQ0aXNrcVAwYmNrOVIvZk9wMDU5S3FkK3ZtQTJl?=
 =?utf-8?B?YW96c0w0N29LRjZDUitKR1NSNVJjYldFL1ZSVld0d0hLUlhIclh3UmRzUGlS?=
 =?utf-8?B?M0Vway9NYnUrNm92MFFHb1c5RlYvN3lWZGFUNWtOb25XUmFjL3pacDZBVkNW?=
 =?utf-8?B?ZWUxKzBhZEdIdFJyQzI3bThrWkVTZkg0TEFhQXU5OXhJN0RvZHhaamg1eW9L?=
 =?utf-8?B?V1RhWk95U2tvS1F1Z2pQOU9yNktGVnViSzlSdVRYNythejJkcE9uTEd1MlRY?=
 =?utf-8?B?NDlxUUU0YytYWFA4OWdRemorYmFVUVdmV1RGdVNuZGIxQWRLWlFGalowNmww?=
 =?utf-8?B?NFpkT21yaGkwcU9sWXBzZEpIT203Tk5CSHJoaHhtZjlCWnRrNG1PZG1EaWtQ?=
 =?utf-8?B?RUtvRnZiYW83OVJ0Z1diNjd6V2lydEtCNG1DTTUvM2NuZEgyWWZyZklXQXRQ?=
 =?utf-8?B?L3ZGTzlHQlZRcW5GUUdLUWZFSmg4YktBRzJ0L29RQStQUkpWY3VjQ1BDU3J6?=
 =?utf-8?B?N1pwa2kySGdpSXp5b2Qxd2pJV1ZyYnc4VzdTVTkvTTAxYy94Sm9DSGk3UThu?=
 =?utf-8?B?c21uS1RjdS84c0FmKzFxeXozK0MxeXFTem94eWgwZ1lydXFSU3dJOExiT3Zr?=
 =?utf-8?B?d2xYS3B1ZkZKTVVrdEM5TVRtUWMrWWtVdTRObXlJT29ibEFvMGV3MEVlNzJS?=
 =?utf-8?B?clVaOUFHNVVycGRQOWo2TXd1MHNQVER1RGMyK3oxY0VOYnc5QjVkd3I0NXRv?=
 =?utf-8?B?SmZpbGsreUNuNUFBY2lJeFZTY3R1WlBhc1JaMGoybzEzTW0zL1NHRHVGQVpi?=
 =?utf-8?B?bDdoQjhmVHJYYkIrOHBGQ3FlS25Zd0lDeDh4cVNPcENFTGNiQ3h1RzYxaDZt?=
 =?utf-8?B?cVRxY21JN2F1RWJJSy9ZNzd6Y3ZEM01nRkM5TWdkQ2RacndUMnRqM3JDWitC?=
 =?utf-8?B?MC9iVUZraStNRlk4R2UyVk9NN0RNanRDTDUvN256aDNJc1J4emtPK2wzUEow?=
 =?utf-8?B?MnFFcGhjdjVkNVdnaUZpMjJ6RmFMUExid24xR1RoUE03Mjg1M3gxaEJzRW9Z?=
 =?utf-8?B?cjBuTTNHUnFlTWRmbjB2NXRKT0JtcWNCZjhtWmFmT25tR1dpOGsrMXJHekVC?=
 =?utf-8?B?ZmVmRnd0M3MrYkUybHFpS1RIRlUyS0hNVDdSblA5NXZpcWFaZmFNZm5xQmc0?=
 =?utf-8?B?YWxaRnBGN2Q1NERjci9sejdlMnN0b3dya2JtWDBvVEZhTlh1VTQzK2xyd1Ix?=
 =?utf-8?B?c3ZuSWcxYnptb0FwYUVNd0wwT1ZDaXZqTXlNa045YmdyaVlIdmx6aXlaNjlu?=
 =?utf-8?B?MVVVa3I4U3lwSi9JUlpPU0lmKzNjMHBiazgwZnd4eG1IanJvS2VWK3FEUEw1?=
 =?utf-8?B?dEFRUHhFdVk3eWZOMXU3Ykx4ZkxUZmVQNnpRZmxVMkV2cVZsZVZQaEFUdEVY?=
 =?utf-8?B?VVFteUIzZVhKb2JXQnFzUWQxVVpTTDA0R1RDUTU1Ukd2am9CTTVTbllieXY2?=
 =?utf-8?B?YllYYVFmL0dWTUtnZnBQZWhpdU1HUkhDempGdVRINkdlS1BkSis3bUtBZUlP?=
 =?utf-8?B?MUsyVkJGSEZWbnl2bGJTc0ZMUk1neFc2MGtqZVV4U3JGamEzU2s3VzgrMldI?=
 =?utf-8?B?OTFZVkw4c1RXWHB6TkZmOWJTMkR3TUtNWVRNam9tL3RyNGl5S1RiQTlqanhI?=
 =?utf-8?B?R0IwUSthUEZoRCtlb1JxOW8ydzZIVGJ3TkJGNmtTS3NoQTZGVnN6ZnNvQTlC?=
 =?utf-8?B?aVdpT0ZzUXRFVjZ2RndUUzBhK3pMd21SSTBXL0h1M21pSkRYRzBkSGgrSmo0?=
 =?utf-8?B?SHNrYU5UNEd4elU0Z2pLRlQ4UFQ5Q3JEcVZUa3N3L3VjV21GTkprTm9ZK3Uw?=
 =?utf-8?B?aDZFLzY4WUVLNFQxUytvZFNxNk5UMjRIS2tyNmVLRmZacUlHalRFc1FXSW5n?=
 =?utf-8?B?S1l2MktnR0NFdVpWZStmNFFlZ3grK1VZajdaSWpxNkNWeEpUa3NTSjhib3hn?=
 =?utf-8?Q?faIPGmOdgRiyEdUw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06C85160BD771849A0D1A2996E90748A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6314.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1212b65d-cdf6-45c0-8d1d-08de5d8e8b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 10:26:33.9844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wEV2wSja/eSaew//966JBI/pm5QmnSrYTn6+aXRA1FGC1mDU+fgaoyBUcOCZzEuW+o2XuRzL7etXVENpDRseyLp0Cm4btnDw76/UNb5upnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8544
X-Mailman-Approved-At: Tue, 27 Jan 2026 14:54:50 +0100
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

SGkgVG9tLA0KDQpPbiBGcmksIDIwMjYtMDEtMjMgYXQgMTQ6MTUgLTA2MDAsIFRvbSBSaW5pIHdy
b3RlOg0KPiBPbiBUdWUsIEphbiAyMCwgMjAyNiBhdCAwMzozMzoxMlBNICswMDAwLCBKYW1pZSBH
aWJib25zIHdyb3RlOg0KPiANCj4gPiBBZnRlciBVLUJvb3QncyBEVEMvbGliZmR0IHVwZGF0ZSwg
ZGV2aWNlIHRyZWUgb3ZlcmxheSBhcHBsaWNhdGlvbg0KPiA+IGNvdWxkDQo+ID4gZmFpbCB3aXRo
IEZEVF9FUlJfQUxJR05NRU5UIGR1ZSB0byB0aGUgb3ZlcmxheSBEVEJPIGJlaW5nIGxvYWRlZCBh
dA0KPiA+IGENCj4gPiBtaXNhbGlnbmVkIGFkZHJlc3MuIENoYW5nZSB0aGUgRklUIGltYWdlIGxv
YWRlciBvcHRpb24gaW4gaW1hZ2UtDQo+ID4gZml0LmMNCj4gPiBmcm9tIEZJVF9MT0FEX0lHTk9S
RUQgdG8gRklUX0xPQURfT1BUSU9OQUxfTk9OX1pFUk8sIHRvIGVuc3VyZQ0KPiA+IG92ZXJsYXlz
DQo+ID4gYXJlIGxvYWRlZCBhdCBwcm9wZXJseSBhbGlnbmVkIGFkZHJlc3NlcyBhbmQgYW55IGFs
aWdubWVudCBlcnJvcnMNCj4gPiBhcmUNCj4gPiByZXNvbHZlZC4NCj4gPiANCj4gPiBUZXN0ZWQg
b246IFBvbGFyRmlyZSBTb0MgSWNpY2xlIEtpdA0KPiA+IA0KPiA+IEZpeGVzOiAwNTM1ZTQ2ZDU1
ZCAoInNjcmlwdHMvZHRjOiBVcGRhdGUgdG8gdXBzdHJlYW0gdmVyc2lvbg0KPiA+IHYxLjcuMi0z
NS1nNTJmMDdkY2NhNDdjIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pZSBHaWJib25zIDxqYW1p
ZS5naWJib25zQG1pY3JvY2hpcC5jb20+DQo+ID4gLS0tDQo+ID4gwqBib290L2ltYWdlLWZpdC5j
IHwgMiArLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Jvb3QvaW1hZ2UtZml0LmMgYi9ib290L2ltYWdl
LWZpdC5jDQo+ID4gaW5kZXggMmQwNDBlMzhkOTcuLjNhMzI3ZDA3Nzg0IDEwMDY0NA0KPiA+IC0t
LSBhL2Jvb3QvaW1hZ2UtZml0LmMNCj4gPiArKysgYi9ib290L2ltYWdlLWZpdC5jDQo+ID4gQEAg
LTI0ODEsNyArMjQ4MSw3IEBAIGludCBib290X2dldF9mZHRfZml0KHN0cnVjdCBib290bV9oZWFk
ZXJzDQo+ID4gKmltYWdlcywgdWxvbmcgYWRkciwNCj4gPiDCoAkJCWFkZHIsICZ1bmFtZSwgJnVj
b25maWcsDQo+ID4gwqAJCQlhcmNoLCBJSF9UWVBFX0ZMQVREVCwNCj4gPiDCoAkJCUJPT1RTVEFH
RV9JRF9GSVRfRkRUX1NUQVJULA0KPiA+IC0JCQlGSVRfTE9BRF9JR05PUkVELCAmb3Zsb2FkLCAm
b3ZsZW4pOw0KPiA+ICsJCQlGSVRfTE9BRF9PUFRJT05BTF9OT05fWkVSTywgJm92bG9hZCwNCj4g
PiAmb3ZsZW4pOw0KPiA+IMKgCQlpZiAob3Zfbm9mZnNldCA8IDApIHsNCj4gPiDCoAkJCXByaW50
ZigibG9hZCBvZiAlcyBmYWlsZWRcbiIsIHVuYW1lKTsNCj4gPiDCoAkJCWNvbnRpbnVlOw0KPiAN
Cj4gQWZ0ZXIgdGFsa2luZyB3aXRoIE1hcmVrIGFib3V0IHRoaXMgbW9yZSwgd2UgdGhpbmsgdGhp
cyBpcyB0aGUgd3JvbmcNCj4gYXBwcm9hY2guIENhbiB5b3UgcGxlYXNlIHRyeSBkcm9wcGluZyB0
aGUgbG9hZF9vcCB0ZXN0IGZyb20NCj4gOGZiY2MwZTBlODM5DQo+IGFuZCBzZWVpbmcgaWYgdGhh
dCBhbHNvIGZpeGVzIHlvdXIgcHJvYmxlbT8gSWYgc28sIHBsZWFzZSBwb3N0IGENCj4gcGF0Y2gN
Cj4gd2l0aCB0aGF0IGFuZCBhIEZpeGVzIHRhZywgdGhhbmtzIQ0KPiANCkRyb3BwaW5nIHRoZSBs
b2FkX29wIHRlc3QgYWRkZWQgaW4gY29tbWl0IDhmYmNjMGUwZTgzOSBkb2VzIG5vdCBzb2x2ZQ0K
dGhlIGlzc3VlIC0gZmFpbGVkIG9uIGZkdF9vcGVuX2ludG8gZm9yIERUTyBkdWUgdG8gbWlzYWxp
Z25tZW50IG9mIG92Lg0KDQpSZWdhcmRzLA0KSmFtaWUuDQo=
