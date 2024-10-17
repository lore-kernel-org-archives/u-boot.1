Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFF6D37485
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 12:52:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8667C88FFD;
	Thu, 17 Oct 2024 14:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="33oJVKaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32EBE88EE3; Thu, 17 Oct 2024 10:51:49 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7A4F88B0B
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 10:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Manikandan.M@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uu3+yCoQ4Pzx93W/4F5iTt/mhuNaaAswcX48R0GzbNJTHZ6IOcwKKRKbLmZ8GKPrAiRVu73ENuIU47+/u3pJkHolIKk2mKQSmnPpqAGlXuVD/RbS6lGs7HmXLavt5Mz6yvKou+FEHz4p7xErO4B//sIecno36tuJaNTonQH1Yg+fke4nygw5ICtSEDqvbqeq9fkGVb8f9zlzmrxqq0Lyjk7PBYAcRp1XZKRyIvClYtKjo7pBJTunSarJuZnC5QhI6eXwsjZT6L7GsogshUp2dFk3hCZy36IT0UngQ3xBqXMN8iTBeScQuyC65bxVefWzEW85q3IegUpRvu7GikL3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ror0e+2TZ0kH1EOp66KRua8zH2/wkdCygMIMze+25yI=;
 b=OLdyCQGz/CB5LLaLmkgEUKLmcRFN0XitlmwMB67+BAeOmWGh7Q4agGlBQSbg9gUAiJmKUongXcHpSCpecveQKEkfsMVBNKaOjSWD6VkPhGY7A/Eryv9JD20T/2kKdMVjm/T32EXVpAk7L/OQJZxutFhP2Aqs8o5LpDl6SWqih7LbWHhQyWTdd3Tuve1BTJ3FiJsTeDsLT8qAMQNWWF2DQnCo89p1CxYdx+EBdT4lci+y58tOQP0BNrDiJEQmX74WRAXmm2M3L0v0rAyKtPi/zAVboQVK9yJ+JzGnkZIh4cIwIYu/Jr6GIPl9TfoEodaons0x07GXbxbHFXSPtVEzWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ror0e+2TZ0kH1EOp66KRua8zH2/wkdCygMIMze+25yI=;
 b=33oJVKaTZiiD8wL+zThqkITxUGX+yH+WUrL0LRuzC+AAAB6Z+G7pDZ2JkQyCUAvlFH/GYEMkxPq7hYRUBZPsARDXGz2l1MdUPpvQ9Rx6s9pOWNgIQKNnziGizwpxdB+DeXcEuA2oL31dWGvKDYN4RaJCeVN4reWui2wTE0NdlG4ocTnGd/x6vpV5FGA0rxeqO6S348SghDqY/l7NloI3iEEzKltjhH7feacRh08hzB+uToNnA5djT1NjoDFCBuHhChOMWiEIgkCjPYS7edmiuDWQdUkJuAVyBM3VGGU925K9vsUtf/K51QnE8RS9XAXT+ZkG1LTemaDnApFhTbwKzA==
Received: from PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16)
 by DS0PR11MB8184.namprd11.prod.outlook.com (2603:10b6:8:160::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 08:51:41 +0000
Received: from PH8PR11MB6609.namprd11.prod.outlook.com
 ([fe80::ebc1:5d63:a07c:60d]) by PH8PR11MB6609.namprd11.prod.outlook.com
 ([fe80::ebc1:5d63:a07c:60d%5]) with mapi id 15.20.8069.020; Thu, 17 Oct 2024
 08:51:41 +0000
From: <Manikandan.M@microchip.com>
To: <alexey@all4bambi.com>, <u-boot@lists.denx.de>
CC: <Varshini.Rajendran@microchip.com>, <Hari.PrasathGE@microchip.com>
Subject: Re: [PATCH 1/1] Fixed sama5d3 dts file so PIO sections are inside
 pinctrl as in kernel dts
Thread-Topic: [PATCH 1/1] Fixed sama5d3 dts file so PIO sections are inside
 pinctrl as in kernel dts
Thread-Index: AQHbIHHIjJjcFcSOAUC5zUTn8g7/iA==
Date: Thu, 17 Oct 2024 08:51:41 +0000
Message-ID: <60f174bc-dd15-403c-9606-5e18fd183754@microchip.com>
References: <20241015145307.118784-1-alexey@all4bambi.com>
 <20241015145307.118784-2-alexey@all4bambi.com>
In-Reply-To: <20241015145307.118784-2-alexey@all4bambi.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6609:EE_|DS0PR11MB8184:EE_
x-ms-office365-filtering-correlation-id: a5f596bc-af07-43cb-9f06-08dcee88eb63
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6609.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RUlSOUJuS2dTVi9yaHpRb2h1UlkwNCtmWjhvS3EydzNCT1ZqVjZWWWxTNm1r?=
 =?utf-8?B?ZDdJeHJXaVgydGFZTkthRzBaQ2NnTWJWK3ZQUy82dTVXWTJlaW1SeTgzK2Rp?=
 =?utf-8?B?TGt6UkRjbURLbElVR1BlMVVrbk82UU4rU3luc0trSVFnYjgyYlF1ZFFiaFBl?=
 =?utf-8?B?b01MWm02aUxOQWcyK05LbXJ6cjdwRCt2b3pFZUFqTThKaEV1Q1Y4UWxVUVkv?=
 =?utf-8?B?b0R6S2V4ZnJmTGoyMjBjTCszRC8yOEQyaUY4UlVibHlIUExta2FQTlRLQnJO?=
 =?utf-8?B?elgzNE80V1J5Z3Vzc0lzdHdxbkxscy9DVHRDaFhVbzdoYmN0am8yWm5aWU1C?=
 =?utf-8?B?Y1UyK2k5d3NaTzZSdll3aktGSk1UZHV6M3l1L0hDTnQ5NDJsQm8vWmlhRU9P?=
 =?utf-8?B?Y3pJTS9FZUM2TENCRFpSbW51VGJpZDg4NzFJM0tkdXM1eC9BS3hndFp1QzNF?=
 =?utf-8?B?Tk1TZzA1VU1yQ0Q1dnZtUnRHQjFucUJoOXhYVVN5N2s1UzAydDU0UklyKzUx?=
 =?utf-8?B?MmY0amdLM3VVOFNPU1hVdFRNSHV2NVJRS2dRS09LL1ltVnBEemQvRm5rcDhN?=
 =?utf-8?B?Y2toMXl4MDgvUmwwVis4NXdPNkFha3hmRHV4NmQ4SEJCV1FMcjRjcm9wQm93?=
 =?utf-8?B?OWc4VmJ4bU0zOVRiQ1RiREQxamZoZE1rWDY4V2g2S0g0b041eFJaNCtEMm9r?=
 =?utf-8?B?cFVzR3JwQnBvcXVBQ2ZuQzIzU0pUNFBacDV5WFFGTlZ4Rmh3S1FyMzZWSG9E?=
 =?utf-8?B?dFlCamp2bGxua3NqdmwxR3dnZjRGVjU0alV6bGE2cGd6dzJTSVQ5TGpVelZZ?=
 =?utf-8?B?cmhsUjdFa01qZ2VVTTk3NkJqRm5vMEFWVTZ5aXRrRDlVNUhhVmtPSHEzNFNu?=
 =?utf-8?B?OTBGVkpoTFh5aGlxb0VRY2pkdmV0QnlVSUpEZDVMNW9FdENLNmJHMTJ4U0E5?=
 =?utf-8?B?UWRZazI2cmVVajl3RmtsZHZQM2JBNnNsam55SFFKQ05WM1BlU3l1TE9LMStM?=
 =?utf-8?B?eFpRaXRhMHVCVlRJVy9oaTV5OEFPWUVOS2t3anRlWjZCWmRjOEVPc0tCbG51?=
 =?utf-8?B?UjF0R2dnK2U2VXU0NjlFckpyQ2FtUGc0cFJpdXh1UmJiYU1iZGpVVmNHNWUr?=
 =?utf-8?B?U0JsYk8rL3A1bFZ3VHRJeEUrbVUxenZoQU5GSU5HRGVVeEIyNSs2TjhNay9I?=
 =?utf-8?B?djVTdW9sWThncjVqMXpNRXNWNFZnVkxKS1RlbGk2RkUwZ2UxYVlnc1ZPeHh5?=
 =?utf-8?B?djY0cUFwckpNa2xqVy9jMUo3ZzdqN0NDWHZUTjh2L1ZBbzBSWVBWamxjdngw?=
 =?utf-8?B?VmYzc05FcE9POVlmb0FlaEFpdkVCTThXM0ZXTkVwSmtTY000eVFVK2RLa2x6?=
 =?utf-8?B?bHBCcmdVWFhDWWpOcUdvcTFjMDg2WmZOMktVaWt3Smo2ZGxnOVdjclVXZFdP?=
 =?utf-8?B?V2tjQmkzQU9tYTFQVUVuams2R2ViZWNGZDI1L1VMVlViK1Z1V1dhdFAvSGlB?=
 =?utf-8?B?R3U2ZlU2RFV3cXE2T3dONncrbUFwZmVyMUFBNWN6d1pDRXRISlFCMGFBVE9C?=
 =?utf-8?B?azFKampneGdLaW1vQzNTUXV0UHlpRFhvWDdwMDd5K29QRVo5bzNXNUZXTWxv?=
 =?utf-8?B?ajFyTjVsdll3TFVBM0tJOGtGa2g1TktNa2JjUG1ocGpaMUU0YzN5eGh1QVlV?=
 =?utf-8?B?S3pOczFFVDZ0bytlVTc0U1VaelVJNnlrZkhTMWpEQ0RhdWdYQkV4amZrbUFX?=
 =?utf-8?B?ZEpPT3BUSFdCZDZUdFNCK2JrOWNIVTRMUE5OOFJXMEVTeG9WeDZRQmpSRDlt?=
 =?utf-8?Q?EKbut3B8n66BBlbJ8vCSRklTXfUU6tfPnhHi8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0pEY3hKV1U3SGhSQUQrL25wVEpHMnVxQnNIOFBqTi8wYnJBUFZMS0ZLSDVt?=
 =?utf-8?B?YW5OYndUTGZ1bkVXVVlvRTJVbmwxejRic1RoUElKNXdScnpGcjlSaE9GeEJQ?=
 =?utf-8?B?eGFZUFV1RlJ3cE1acTRMMWpEY1ZGU2xZR1h6am84SFFDMlpLdUJ3RUd6WHFG?=
 =?utf-8?B?ZGdoOE9UUUZ2T0h5TlY5V1p0QjZKdTl4Z3cwWmRRbzlwajNRSndjYjRtL3ZM?=
 =?utf-8?B?dU9pZmI4NjhZT3M3YXJBYXhRRGNxSzlPTDBkcVhYWXUzanMxbjU5bTVFKzll?=
 =?utf-8?B?UDVkdytqa3FOaWZSQ25tT051dHR6QjVBMlkyT0JQTytEMWNiSnVqM3V5eXJP?=
 =?utf-8?B?b1pQbU1GWDdTMFJ5alhNTE10WUlrNUt4ZXYxMVhiTmRUbVdyek5xbGpzSk5q?=
 =?utf-8?B?VVpmVzNyZEE5ZGJ6dXEvMEczakFzdkhvUVU4VytLRTNVVXd0K3Jvai9iWVlm?=
 =?utf-8?B?R21RZnFqWkw0QkFad2paT01RaXBHUmhEV3pCVGxjTysyUGE1QXJDMWlETDkv?=
 =?utf-8?B?bm1KU3N4RGtyL2lWNFE3RkRwbUhxQlR6UEpKTGw2QTlzWmowK0tnVUZPOG9a?=
 =?utf-8?B?dEF0R0VYcGdWai85c3BvaWluZXBDOTFhY2dUVWN1enhZeTZJOXkvTjFPUCtT?=
 =?utf-8?B?STVibXFiN3hIVnpydWxCNXZObkUzbXlIVGltZzcraW5RTCtaMDlNQmR1WXkx?=
 =?utf-8?B?N1JLSVd3a2wzQ1I2R1JZYjBwQThHZDRTYjNkN1hMb3dmNjdWUTBoRTBBemw4?=
 =?utf-8?B?N2l1N1JReTJrZzVHQ2kzK2dhMjJGK3RtdHFTZ1IxaFMzMHdOcmpkYVJISCt3?=
 =?utf-8?B?THh5Slh1aUFzb1NtRlhKcGxET284RDlMVFRSTFVzK1AvOTRQNFpHcTF3dk44?=
 =?utf-8?B?TU11WTAzaDlJaWdiRnpWbWJ5QzlaMFFKSCtPVUdjZHFvdEtDR0JxTjh4Ylpn?=
 =?utf-8?B?bkFDU3B6cllmV3pzRzI2QzEweUd3YitPWGJ2WVQxb1QvQTVUNkd2eXFvSjMz?=
 =?utf-8?B?QTVZWGV3aHh3T3Q3NC9teDNDeElKekVQc05ZYi9YOHNUU1JFMXNpMVdqWGhF?=
 =?utf-8?B?YWhqanlTWXphZS8rNVRaVjFFSzVvVHhWNisrbmZVdS9OdVk1U0ZJQmNKSGxh?=
 =?utf-8?B?QmhDWFBpT3dTOXN0M1BWYlBtaGRXQ0NoTVhMQzdIb0YzUDN5UkRYT2pzaDdP?=
 =?utf-8?B?cXRZUjVjbU1YVDA0OEdScHBoUnF3K1U2K1ZjeXZIdmtrMm1SallaSzlKQjRU?=
 =?utf-8?B?NVQxZ01MekFIWkdZRDk2aTFQSkVFck9jMkowR2tlQkxPcUlJT3c5ZWd2TFZo?=
 =?utf-8?B?RUlxRUpnbEpwWWV6RHNjQlltQy9pWVk0QXI3ejRzLzk4a0pON3dHK2JBY2Zs?=
 =?utf-8?B?SnR2aXI0aXd4M3VBWHE4dmRWRm9DdXJtazlzOVVsdHNpWHdjSzVnSm45d01E?=
 =?utf-8?B?ejV3c2p5VWY4bENXV1QzajhiemdrRk5ZZlF2ZGJ4czI2cG5zVkFPS0daSE1k?=
 =?utf-8?B?dHRTUjFKMktDdmlpVU80dEVuT01EdEpiUHpCY1hDOEQrNUxHZ0hLK0NDc1Fv?=
 =?utf-8?B?bit1VFp0SWhIdkN1c0VVMFBLeTBSZE9kb2UyVHZRdGgrc1hhRXE0enVOUFlq?=
 =?utf-8?B?RXZXWmRLWHk0aGhLY0x0UmNsZ0NxTmJiaDF5YmVZdkN1eXZsUnpaS1I5ZXUr?=
 =?utf-8?B?cjBacVN3dVE3TmNGb1UzbW5IZ3cwbUt0NHM0cUdiQzE0UnYzMEw5emcrMjY5?=
 =?utf-8?B?Uk55Q09zeWJTMHQwWS9acnliVVMvYWJMZ2xLS2tOam1pT3BoR3dSYmYwMTBS?=
 =?utf-8?B?QytxdkFpMVJtbjVzSkk1YUptcmZvZ2Q0clk4aXlZM3ZTYzUyclhSSVp6WkFu?=
 =?utf-8?B?a21YcmZRMzFneWZOVkZHdTV5NzNkSmRkVFFQaTYvRGlsTUhJK0ZKS1Ztekw4?=
 =?utf-8?B?NUtIdWFLVXgrT01XT2dyNW52T21pdWJabkMwbTREa2RqN3pUNjVFNU52Yk1u?=
 =?utf-8?B?U0t2UnMvN0FBMVlwMjlYSWN5R2tMZ09iNnFwSFd4M1dybVdxbVpFOXdnY1pj?=
 =?utf-8?B?d3puTHgycTJ5UXBwRHROU09QK2FxLzYrUHdqVVFGOTRLOXhyVzdMS3BSNnI0?=
 =?utf-8?Q?DGN5SiL/yTcW2l7wXUuZcK9wz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8345E55BB3B6B943B87AB2312FC120EC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6609.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f596bc-af07-43cb-9f06-08dcee88eb63
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 08:51:41.1370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PIGEqWxaGuvn6oC/oOwo300U6XSrvyeuz2RMbh6ywYx8J+jrWZU1S4EjHFl4OF+VsjENUvRNwzBVJJKIG9YWz5ZsLU9AyNlGsXwkQuXiwSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8184
X-Mailman-Approved-At: Thu, 17 Oct 2024 14:52:24 +0200
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

SGkgQWxleGV5LA0KDQpPbiAxNS8xMC8yNCA4OjIzIHBtLCBBbGV4ZXkgVHNpcmxpbiB3cm90ZToN
Cj4gVGhpcyBhbGxvd3Mgc2V0dGluZyB0aGUgR1BJTyBwYXJhbWV0ZXJzIGZyb20gZGV2aWNlIHRy
ZWUsIG90aGVyd2lzZSB0aGUNCj4gYXQ5MV9waW5fY2hlY2tfY29uZmlnIHdpbGwgZmFpbCBiZWNh
dXNlIHRoZSBwcml2LT5uYmFua3MgZXF1YWwgdG8gemVybw0KPiANCj4gU2lnbmVkLW9mZi1ieTog
QWxleGV5IFRzaXJsaW4gPGFsZXhleUBhbGw0YmFtYmkuY29tPg0KPiAtLS0NCj4gDQo+ICAgYXJj
aC9hcm0vZHRzL3NhbWE1ZDMuZHRzaSB8IDExMSArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1NiBpbnNlcnRpb25zKCspLCA1NSBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvc2FtYTVkMy5kdHNpIGIv
YXJjaC9hcm0vZHRzL3NhbWE1ZDMuZHRzaQ0KPiBpbmRleCA0YzAzYTMwMmVjLi5jNjcxZWE0MmYy
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9kdHMvc2FtYTVkMy5kdHNpDQo+ICsrKyBiL2FyY2gv
YXJtL2R0cy9zYW1hNWQzLmR0c2kNCj4gQEAgLTg3Myw2NiArODczLDY3IEBADQo+ICAgCQkJCQkJ
CSBBVDkxX1BJT0UgMTcgQVQ5MV9QRVJJUEhfQiBBVDkxX1BJTkNUUkxfTk9ORT47CS8qIFBFMTcg
cGVyaXBoIEIsIGNvbmZsaWN0cyB3aXRoIEExNyAqLw0KPiAgIAkJCQkJfTsNCj4gICAJCQkJfTsN
Cj4gLQkJCX07DQo+ICAgDQo+IC0JCQlwaW9BOiBncGlvQGZmZmZmMjAwIHsNCj4gLQkJCQljb21w
YXRpYmxlID0gImF0bWVsLGF0OTFzYW05eDUtZ3BpbyIsICJhdG1lbCxhdDkxcm05MjAwLWdwaW8i
Ow0KPiAtCQkJCXJlZyA9IDwweGZmZmZmMjAwIDB4MTAwPjsNCj4gLQkJCQlpbnRlcnJ1cHRzID0g
PDYgSVJRX1RZUEVfTEVWRUxfSElHSCAxPjsNCj4gLQkJCQkjZ3Bpby1jZWxscyA9IDwyPjsNCj4g
LQkJCQlncGlvLWNvbnRyb2xsZXI7DQo+IC0JCQkJaW50ZXJydXB0LWNvbnRyb2xsZXI7aGFyDQo+
IC0JCQkJI2ludGVycnVwdC1jZWxscyA9IDwyPjsNCj4gLQkJCQljbG9ja3MgPSA8JnBpb0FfY2xr
PjsNCj4gLQkJCQlib290cGgtYWxsOw0KPiAtCQkJfTsNCj4gKwkJCQlwaW9BOiBncGlvQGZmZmZm
MjAwIHsNCj4gKwkJCQkgICAgICBjb21wYXRpYmxlID0gImF0bWVsLGF0OTFzYW05eDUtZ3BpbyIs
ICJhdG1lbCxhdDkxcm05MjAwLWdwaW8iOw0KU3BhY2VzIGluc3RlYWQgb2YgdGFiIGJlZm9yZSAn
Y29tcGF0aWJsZScsIHNob3VsZCBiZSBjb25zaXN0ZW50IHdpdGggdGhlIA0KcmVtYWluaW5nIHBy
b3BlcnRpZXMgb2YgcGlvQSBub2RlLg0KPiArCQkJCQlyZWcgPSA8MHhmZmZmZjIwMCAweDEwMD47
DQo+ICsJCQkJCWludGVycnVwdHMgPSA8NiBJUlFfVFlQRV9MRVZFTF9ISUdIIDE+Ow0KPiArCQkJ
CQkjZ3Bpby1jZWxscyA9IDwyPjsNCj4gKwkJCQkJZ3Bpby1jb250cm9sbGVyOw0KPiArCQkJCQlp
bnRlcnJ1cHQtY29udHJvbGxlcjsNCj4gKwkJCQkJI2ludGVycnVwdC1jZWxscyA9IDwyPjsNCj4g
KwkJCQkJY2xvY2tzID0gPCZwaW9BX2Nsaz47DQo+ICsJCQkJCWJvb3RwaC1hbGw7DQo+ICsJCQkJ
fTsNCj4gICANCj4gLQkJCXBpb0I6IGdwaW9AZmZmZmY0MDAgew0KPiAtCQkJCWNvbXBhdGlibGUg
PSAiYXRtZWwsYXQ5MXNhbTl4NS1ncGlvIiwgImF0bWVsLGF0OTFybTkyMDAtZ3BpbyI7DQo+IC0J
CQkJcmVnID0gPDB4ZmZmZmY0MDAgMHgxMDA+Ow0KPiAtCQkJCWludGVycnVwdHMgPSA8NyBJUlFf
VFlQRV9MRVZFTF9ISUdIIDE+Ow0KPiAtCQkJCSNncGlvLWNlbGxzID0gPDI+Ow0KPiAtCQkJCWdw
aW8tY29udHJvbGxlcjsNCj4gLQkJCQlpbnRlcnJ1cHQtY29udHJvbGxlcjsNCj4gLQkJCQkjaW50
ZXJydXB0LWNlbGxzID0gPDI+Ow0KPiAtCQkJCWNsb2NrcyA9IDwmcGlvQl9jbGs+Ow0KPiAtCQkJ
CWJvb3RwaC1hbGw7DQo+IC0JCQl9Ow0KPiArCQkJCXBpb0I6IGdwaW9AZmZmZmY0MDAgew0KPiAr
CQkJCSAgICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTl4NS1ncGlvIiwgImF0bWVsLGF0
OTFybTkyMDAtZ3BpbyI7DQpEaXR0bw0KPiArCQkJCQlyZWcgPSA8MHhmZmZmZjQwMCAweDEwMD47
DQo+ICsJCQkJCWludGVycnVwdHMgPSA8NyBJUlFfVFlQRV9MRVZFTF9ISUdIIDE+Ow0KPiArCQkJ
CQkjZ3Bpby1jZWxscyA9IDwyPjsNCj4gKwkJCQkJZ3Bpby1jb250cm9sbGVyOw0KPiArCQkJCQlp
bnRlcnJ1cHQtY29udHJvbGxlcjsNCj4gKwkJCQkJI2ludGVycnVwdC1jZWxscyA9IDwyPjsNCj4g
KwkJCQkJY2xvY2tzID0gPCZwaW9CX2Nsaz47DQo+ICsJCQkJCWJvb3RwaC1hbGw7DQo+ICsJCQkJ
fTsNCj4gICANCj4gLQkJCXBpb0M6IGdwaW9AZmZmZmY2MDAgew0KPiAtCQkJCWNvbXBhdGlibGUg
PSAiYXRtZWwsYXQ5MXNhbTl4NS1ncGlvIiwgImF0bWVsLGF0OTFybTkyMDAtZ3BpbyI7DQo+IC0J
CQkJcmVnID0gPDB4ZmZmZmY2MDAgMHgxMDA+Ow0KPiAtCQkJCWludGVycnVwdHMgPSA8OCBJUlFf
VFlQRV9MRVZFTF9ISUdIIDE+Ow0KPiAtCQkJCSNncGlvLWNlbGxzID0gPDI+Ow0KPiAtCQkJCWdw
aW8tY29udHJvbGxlcjsNCj4gLQkJCQlpbnRlcnJ1cHQtY29udHJvbGxlcjsNCj4gLQkJCQkjaW50
ZXJydXB0LWNlbGxzID0gPDI+Ow0KPiAtCQkJCWNsb2NrcyA9IDwmcGlvQ19jbGs+Ow0KPiAtCQkJ
CWJvb3RwaC1hbGw7DQo+IC0JCQl9Ow0KPiArCQkJCXBpb0M6IGdwaW9AZmZmZmY2MDAgew0KPiAr
CQkJCSAgICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTl4NS1ncGlvIiwgImF0bWVsLGF0
OTFybTkyMDAtZ3BpbyI7DQpEaXR0bw0KPiArCQkJCQlyZWcgPSA8MHhmZmZmZjYwMCAweDEwMD47
DQo+ICsJCQkJCWludGVycnVwdHMgPSA8OCBJUlFfVFlQRV9MRVZFTF9ISUdIIDE+Ow0KPiArCQkJ
CQkjZ3Bpby1jZWxscyA9IDwyPjsNCj4gKwkJCQkJZ3Bpby1jb250cm9sbGVyOw0KPiArCQkJCQlp
bnRlcnJ1cHQtY29udHJvbGxlcjsNCj4gKwkJCQkJI2ludGVycnVwdC1jZWxscyA9IDwyPjsNCj4g
KwkJCQkJY2xvY2tzID0gPCZwaW9DX2Nsaz47DQo+ICsJCQkJCWJvb3RwaC1hbGw7DQo+ICsJCQkJ
fTsNCj4gICANCj4gLQkJCXBpb0Q6IGdwaW9AZmZmZmY4MDAgew0KPiAtCQkJCWNvbXBhdGlibGUg
PSAiYXRtZWwsYXQ5MXNhbTl4NS1ncGlvIiwgImF0bWVsLGF0OTFybTkyMDAtZ3BpbyI7DQo+IC0J
CQkJcmVnID0gPDB4ZmZmZmY4MDAgMHgxMDA+Ow0KPiAtCQkJCWludGVycnVwdHMgPSA8OSBJUlFf
VFlQRV9MRVZFTF9ISUdIIDE+Ow0KPiAtCQkJCSNncGlvLWNlbGxzID0gPDI+Ow0KPiAtCQkJCWdw
aW8tY29udHJvbGxlcjsNCj4gLQkJCQlpbnRlcnJ1cHQtY29udHJvbGxlcjsNCj4gLQkJCQkjaW50
ZXJydXB0LWNlbGxzID0gPDI+Ow0KPiAtCQkJCWNsb2NrcyA9IDwmcGlvRF9jbGs+Ow0KPiAtCQkJ
CWJvb3RwaC1hbGw7DQo+IC0JCQl9Ow0KPiArCQkJCXBpb0Q6IGdwaW9AZmZmZmY4MDAgew0KPiAr
CQkJCSAgICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTl4NS1ncGlvIiwgImF0bWVsLGF0
OTFybTkyMDAtZ3BpbyI7DQpEaXR0bw0KPiArCQkJCQlyZWcgPSA8MHhmZmZmZjgwMCAweDEwMD47
DQo+ICsJCQkJCWludGVycnVwdHMgPSA8OSBJUlFfVFlQRV9MRVZFTF9ISUdIIDE+Ow0KPiArCQkJ
CQkjZ3Bpby1jZWxscyA9IDwyPjsNCj4gKwkJCQkJZ3Bpby1jb250cm9sbGVyOw0KPiArCQkJCQlp
bnRlcnJ1cHQtY29udHJvbGxlcjsNCj4gKwkJCQkJI2ludGVycnVwdC1jZWxscyA9IDwyPjsNCj4g
KwkJCQkJY2xvY2tzID0gPCZwaW9EX2Nsaz47DQo+ICsJCQkJCWJvb3RwaC1hbGw7DQo+ICsJCQkJ
fTsNCj4gKw0KPiArCQkJCXBpb0U6IGdwaW9AZmZmZmZhMDAgew0KPiArCQkJCSAgICAgIGNvbXBh
dGlibGUgPSAiYXRtZWwsYXQ5MXNhbTl4NS1ncGlvIiwgImF0bWVsLGF0OTFybTkyMDAtZ3BpbyI7
DQpEaXR0bw0KPiArCQkJCQlyZWcgPSA8MHhmZmZmZmEwMCAweDEwMD47DQo+ICsJCQkJCWludGVy
cnVwdHMgPSA8MTAgSVJRX1RZUEVfTEVWRUxfSElHSCAxPjsNCj4gKwkJCQkJI2dwaW8tY2VsbHMg
PSA8Mj47DQo+ICsJCQkJCWdwaW8tY29udHJvbGxlcjsNCj4gKwkJCQkJaW50ZXJydXB0LWNvbnRy
b2xsZXI7DQo+ICsJCQkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8Mj47DQo+ICsJCQkJCWNsb2NrcyA9
IDwmcGlvRV9jbGs+Ow0KPiArCQkJCQlib290cGgtYWxsOw0KPiArCQkJCX07DQo+ICAgDQpFeHRy
YSBsaW5lDQo+IC0JCQlwaW9FOiBncGlvQGZmZmZmYTAwIHsNCj4gLQkJCQljb21wYXRpYmxlID0g
ImF0bWVsLGF0OTFzYW05eDUtZ3BpbyIsICJhdG1lbCxhdDkxcm05MjAwLWdwaW8iOw0KPiAtCQkJ
CXJlZyA9IDwweGZmZmZmYTAwIDB4MTAwPjsNCj4gLQkJCQlpbnRlcnJ1cHRzID0gPDEwIElSUV9U
WVBFX0xFVkVMX0hJR0ggMT47DQo+IC0JCQkJI2dwaW8tY2VsbHMgPSA8Mj47DQo+IC0JCQkJZ3Bp
by1jb250cm9sbGVyOw0KPiAtCQkJCWludGVycnVwdC1jb250cm9sbGVyOw0KPiAtCQkJCSNpbnRl
cnJ1cHQtY2VsbHMgPSA8Mj47DQo+IC0JCQkJY2xvY2tzID0gPCZwaW9FX2Nsaz47DQo+IC0JCQkJ
Ym9vdHBoLWFsbDsNCj4gICAJCQl9Ow0KPiAgIA0KPiAgIAkJCXBtYzogcG1jQGZmZmZmYzAwIHsN
Cg0KLS0gDQpUaGFua3MgYW5kIFJlZ2FyZHMsDQpNYW5pa2FuZGFuIE0uDQoNCg==
