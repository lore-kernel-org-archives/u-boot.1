Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B636C25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 05:40:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D5F4886B9;
	Thu, 30 May 2024 07:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SYyZkKYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4668A886B9; Thu, 30 May 2024 07:40:08 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBFD2886BA
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 07:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqQRQ19YtozoeB8dgT7o5uuWiFHkbHANg3RSsagjkMHuYYTV+5/ZxVLtz4lMTsYlKqBFirRnVROd/Sz2CTaeUR8wwgLGP+dRvHSCu+UH1v6Y0jcfyN05v6QNWpYQbrdlNzbxyCTgwxxsOxTUyObfeLg+VeRtUgfcLKeW7s006fRP2DUQlomAYXqeqL8RcK2V4OQvZ3OPCIg3Z6rIcOv+eHyjUGFhXW+MK0HUJfx/xwlV5DSmT7Zm8XrOGcji7NvMMgAodDipJqh39Cp+rgh9hgDHzioQiMM3jMLhTTCZOdRIo9szf8yPA+oCYjivHHKmv0v/oTNbbdsLBF67gmF4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLRWyMqPkkq6uXJ2n9B1Q7qyzE/VtiWkJBzyZWFGdpQ=;
 b=ltOd/NChrsE33c6Cv3j+4CYmhdMcgnbptUQYLPRbU5NSA8S7qE3yOmoKcTXX46bu0gpzGQz95cwe3xTTHNZUE34udl+Ccy6zuZrWoZmxQnbkvaw7VV8wz7VDIC+l/5EE664ICbJFpMYyn2nbJsc5lholwr0eqjYDHx4y4ZHrBZq24HH6hQ72u6chJ5uBuo1Ls0u1hHQFVU6d3EJJoStAvdu34/RJhoWRSgZO/esDzgS18ywYV/O/GtDcjgqrekug6dXSW5cB0N4F9EKfb8Caj+iMrHMxIjp/F/LRVbDupsG3VTDTsPe2dif5u0oAQ8K4sB0phazNgQ1WyTlcoI+jVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLRWyMqPkkq6uXJ2n9B1Q7qyzE/VtiWkJBzyZWFGdpQ=;
 b=SYyZkKYPMOp3TFtu5Kbg75JIPKMabMgcj2iOkgHaeii7hf88wmyg9ux7oEYmOlSooPn+pkl2koi1ktPkRC0q0OJDkpY4twnUxu5TO8VY5yRgObeHPjsJPCAENkimTZu1ecESaOk8bphHheG/wepHY6JOnEjMJ6/iRZNI6aAHFNk=
Received: from CYYPR12MB8703.namprd12.prod.outlook.com (2603:10b6:930:c4::9)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 30 May
 2024 05:39:56 +0000
Received: from CYYPR12MB8703.namprd12.prod.outlook.com
 ([fe80::94fe:91b2:3a0f:3998]) by CYYPR12MB8703.namprd12.prod.outlook.com
 ([fe80::94fe:91b2:3a0f:3998%6]) with mapi id 15.20.7611.025; Thu, 30 May 2024
 05:39:56 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, "lukas.funke-oss@weidmueller.com"
 <lukas.funke-oss@weidmueller.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Stefan Herbrechtsmeier <Stefan.Herbrechtsmeier@weidmueller.com>, Ashok
 Reddy Soma <ashok.reddy.soma@amd.com>, Lukas Funke
 <lukas.funke@weidmueller.com>, Jaehoon Chung <jh80.chung@samsung.com>, Johan
 Jonker <jbx6244@gmail.com>, Peng Fan <peng.fan@nxp.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: RE: [RFC PATCH v1 1/1] mmc: zynq_sdhci: Only evaluate card-stable
 signal if card was detected
Thread-Topic: [RFC PATCH v1 1/1] mmc: zynq_sdhci: Only evaluate card-stable
 signal if card was detected
Thread-Index: AQHasdli5t7IOsAX/UioiTK8EgVpwLGvPp4A
Date: Thu, 30 May 2024 05:39:56 +0000
Message-ID: <CYYPR12MB8703F5C687226352CCBBCD3898F32@CYYPR12MB8703.namprd12.prod.outlook.com>
References: <20240424082343.212554-1-lukas.funke-oss@weidmueller.com>
 <20240424082343.212554-2-lukas.funke-oss@weidmueller.com>
 <82f63d08-3dce-4166-bd82-246cade9ab87@amd.com>
In-Reply-To: <82f63d08-3dce-4166-bd82-246cade9ab87@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8703:EE_|DS7PR12MB8229:EE_
x-ms-office365-filtering-correlation-id: 17cd9030-74cb-4bd0-9409-08dc806af020
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Ti9jWGw1Z3dQYVQ5OHVHVjdZOE8vMTRrV25ZK3FNRjl1SFUzY092TWtHRFdJ?=
 =?utf-8?B?OHpabWx0a1hNTjE1YXpYTWp5SzR3RzZ3WFRaTDNQV2dPaGl4ZjRKWXNsYk50?=
 =?utf-8?B?VVh5UmNqVDBVVDVNd3JDL040T3NvVi9ZSk1FTHJTTFFBZW5pVGxPSW9aa3Vy?=
 =?utf-8?B?Z1hFRlU5S09uWGRBbm4zL0p4aWkvc2x5V2EzdXUzRU1EZ2JNNEZTNUxUTXd5?=
 =?utf-8?B?Y3Q3aFMyV0twbEhpMWhHZFZjQkpXSGhXYWlhb3k5ekt2cGxsa0dId0ZNUG5X?=
 =?utf-8?B?TFIyL0RXbC82Z2wxRWVoUXVVTEk2Yno4dE10OUI3STlKZVU4cUxYcSt2a3A4?=
 =?utf-8?B?OHEyQmtjNHNZVDY0NDA0WEdMMDJxRUhwYUVTVlFFNC95OXUvay9oV3dwK2Mx?=
 =?utf-8?B?c1JUMWJGa09zZmI3am5ZVE5tM0cwdmxzYnlrcU9mWTZncDJRb29yVEFsdkNR?=
 =?utf-8?B?cnp5T25wRUxsTlNydnZLSlQyYmxsUjNpekJLZG1JWHpXd0l1aHMwVlRyYjdO?=
 =?utf-8?B?Sk1rN0RNTFhUWmQreTgyeFpvVGpDWTZ0cjVabTZ5SU9HOHU0MUd1UEhySEVZ?=
 =?utf-8?B?cStvcG5iSkhVWUFqb1FXRUF0K2JyMG1kWVBDYWZmU2U0UWtTYXhQN0RGZ0Z5?=
 =?utf-8?B?RHZTTTcyZnlhc2hRbmxUODR0eTVvV1I2L2Q1QlBidCtWWU1jYWIzQWp0a0lt?=
 =?utf-8?B?akZpb0NZcHJndHNVcjkvc1A4NFEyanVjcjVhdDBoeUptR3VlYkNPZUFiQWhy?=
 =?utf-8?B?bnZkWWtaaEowTEluVDRiSlFxRFZzRzlNNVBkMk9WZXlMQUtxZUViNm5TRC90?=
 =?utf-8?B?SFFRbVhZSWRKQ1ZTMDlhc2t5d1MrcW1BSVAzQXcxdEFHelY4cVlRME8zejBL?=
 =?utf-8?B?cGlKUkdtRUJqZ2Z6a0x6YTFST25jK0JjSE4vRTlrajJlMUl0bnMxb09MSjIy?=
 =?utf-8?B?N3lnd3ZKSXlpcHhPU25aa2pNMTlBNXp1MUM1ZGpoY0hlYUVkUWlJYTBkWjA3?=
 =?utf-8?B?YSt6RTV6RGRGYmhBN0lhWk5rZ2dPRW8zTXk0WUZwWlZyYU12Vmh6a2xIbDRT?=
 =?utf-8?B?WmRoNjJISEFCY0FMNFpqaG9Ua2w1U2RZRnRtR3hEUWxsQUdqWGU4VDd0KzBT?=
 =?utf-8?B?M1NUM1RxR1pxZmFCd2pYOXNPaTlER2pZM1dBYmJPeUh0dXZBMFRBTnRZMlQx?=
 =?utf-8?B?aTJjZmYxOHpjWlRGZHRjRStpNkNTc0RIc0pkTDUzd09vK3JJdU9GSFJRbFJ4?=
 =?utf-8?B?SUFQY0hPV2Rud0dwRXVWTUJyQ1pXTmxnYjJYcTNDOGViR0R0azdQVEtZNmw1?=
 =?utf-8?B?S3ZneWdVaitGSzNMOTlETGh0UEZDMlpRSUsxV0tVd3dWZmJ0bzh6RFh1Yjla?=
 =?utf-8?B?V0ZhY2FVQ1BYSERGWVJBZ1FJWklpZkUvQ2ZVUkJkSGZxRXpEM3hjcGF2dFRk?=
 =?utf-8?B?RnlEcVZKSFJ2aThTazkyTFN4UEppaTZvWCtEMVRHN05Ta1UrQ0lqUFhHakJy?=
 =?utf-8?B?TW13WmlneDEvcWZ3YXdna2w3WDlPYk1Wd0dnM0Mvc1lCYzZka1FaazJKS25w?=
 =?utf-8?B?R0NkelhieGVVK1g3cWhpYlNjenArTlVjL2FKa0ZJdndWcTdlZzZqaXpLR3U3?=
 =?utf-8?B?M29UQnFTUFVDdFNqcjFEZG1Uc3ZMTEJrMzBvVHNLQ05makM0a2VjeXZtSDQ0?=
 =?utf-8?B?UWZER041bGJkck9pMXJNd0NkdnZRTTlTYlJNY3MrM1E2RDF6YjJneTZYSDAx?=
 =?utf-8?B?d3h3TlM3eTdvaGhBSnJoYXRsVmRsaWplaERFeHZ1SG1XWEx4Wk1makRTVlR2?=
 =?utf-8?B?Y1ZQN3RuU2wzUlo0TXRDQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8703.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d05VV0hqMjZuemxlc21xanYvMllURzVTMjJ5cEltbW9Dd25Ba3NWRzBjSHFO?=
 =?utf-8?B?M2JuVG9jUlgvWWpwV3BRbmZxc3lGMWY3d3RxNHllYkpkeDZQOUZWaVM2anRo?=
 =?utf-8?B?bDQ2N3pQc3VLYU5pKy9uM21DWmxnbDJWdW1BbzlUYmwrZE55L0hib1R5TTNG?=
 =?utf-8?B?ZVYxc1pGMEZ2cG03K1c4RVVqMWZObmZFZi9qdW5CN1FMNW5WUStmdUloYW1B?=
 =?utf-8?B?ZU9OQ1cxc3g0dHVqNWR4T3dOM2NIRE1hNXU2ay92M1dLYW5zYkJrZ3dkVkQ4?=
 =?utf-8?B?djRKRnUvWGJMZ2hIZGg4S3RwZG9vL1BBL3pIMGMrSnhCSVFhZTZaZ1VkSVJR?=
 =?utf-8?B?NUt6cWphOHBya1FRMkVqZS96Z3hYSXFPOUNvZmNJUzNzWXA1dnlnbStCYnBB?=
 =?utf-8?B?Z3BCOXlPdTRRRmRnL1U5QTBodmtUbTNWSG1meDRjUVFrWGNWQ2pEYlJxaVdG?=
 =?utf-8?B?bWhPdWdoNlp0YkcyeW1VOThLbkwrZ3pualZGWng1VUxQMzljOVFEVFBYRS9O?=
 =?utf-8?B?S3BPbnEyOGlUMEMvazRnT3EwOThrS1BYK3Q5bS95dElteVB0OFJrMkNWSTh5?=
 =?utf-8?B?Und3TVJCZ1lqZ3VXcUlyRk5JclJDeWx6NnRPTVBSRVRuaUlWT1ZHVG5qQXo1?=
 =?utf-8?B?UHpSUWMvbDhBOUhuMldZcTdIaUxsd1NMQ1B2Q2VEZEpQR1pSbzhSVitHeDcz?=
 =?utf-8?B?bDIvWVdYVU16eXljcTAzMXUvSkVsVDlJMndhQmlaQmhLNWZqc213VGNjOVV2?=
 =?utf-8?B?VkVhUFNWaEl2YTJnMTZPck9lZ1BodTZidWlORWIwSUU0dllvVSs1Qk00UmZC?=
 =?utf-8?B?cUhjdllqaE9GS01qY0NTZlNVUHUzVVpNY1FzZSt4REQ5UWlURkxOZ1p3U2Rv?=
 =?utf-8?B?U0ovZVhZRW0rQU5zL01wZzdnV0VoTW5iZS9JQVc5TXBaWUhyOHBJbHVXNFBJ?=
 =?utf-8?B?TE04UmFUL29Vc1NNL1liNWdnbWFpcGRwNU8rYXBXQ21oR0Z2a1U2WW02WW9P?=
 =?utf-8?B?RSs2ZmJ0TklUeHZ0YW8xeE5OUk5pd1NNSWgyL1pHZ1VoUHNvd05aUHVjeGZX?=
 =?utf-8?B?Q1QzTkVUbjFFdEt4Z3NFOEs5MEcrMS9nY0xKS2J1TnVjdjM3eVFxZjNzUGgv?=
 =?utf-8?B?T0ZYWXZaa0hERGp0b1Y4M3Ztd3A4YWtpandKSEtjSTdtSURUekNvSVIzNzB1?=
 =?utf-8?B?aU1kZCtEUko1Nm5OYjA4WFRGOUY4RTE3N1lnV2FYUThGdDdBanRLaFRITm9o?=
 =?utf-8?B?VkJJNmFrTlNVSXZDRHUxTkZuclhkRVpsbWg2STNiNW14d2NvWlNnQWwrejNZ?=
 =?utf-8?B?TEQ4S0dWald6eXRyZ0k3SksvU2VTQWRkbWd2enBXK0FGNUQ1YmFubjFkSUR0?=
 =?utf-8?B?eGZUTDh5RjFVaU5hZ0pzcTJHNVpZNlREeDZtTmNTaUQvcG1PVEREYks4TWVN?=
 =?utf-8?B?QkgvM3Ixb2Q5TDZwWWVvdFBodVRKdGpuMnVvWWh4VWxQZ0RPck80c1d6SWoy?=
 =?utf-8?B?K1dTMW9RQ0NiZGJmc25wUTBhVkxQKzIrVHRJdFNhdlhDU2hjNk1xVlFHR3Av?=
 =?utf-8?B?YXhPajhqRkIwbkNLbjQrZnMrOVpJS0lYM2UrVFRlSzA4SEdYYVBTYjYzZTRm?=
 =?utf-8?B?VFA4Ri9aeGxMWFhCZzhNNS9Ienc5K3dhL1FTQVJ4QXlZVm1EaE1taVZiMU5v?=
 =?utf-8?B?ODVKWmt3UE1HKzhwL09EMWQ4THVieDdTOHlJbmxBWnYvZ0dWLzBKRnNObU1h?=
 =?utf-8?B?bU5MT0Yzck9EeU1BNGxVenpHcUwxWlRDbjJTTHVzL3BOYjFkbGRhZnVBRFpa?=
 =?utf-8?B?N0kwTEhaTmxJNnNUU0JaVmZaemFPYXVvQ3FncTF1emVkSXNlQytSVHZGd2Qv?=
 =?utf-8?B?WVhmRXcvaGpWYXltYUxtMFZBNGwzeG9DTzRSNjU0bW1vdVNST3ppTGw4aTFm?=
 =?utf-8?B?UnJVeU1oMXBEUG5oU3NjZkF5VkhnUHpvc3djNEhxTk41NjFrYjdCZG1xUnpS?=
 =?utf-8?B?RldjY0p5cnZRUkVtSWpBVGlwNXNEN1pra3BrK2hWeUszK01iWjR1OTdrVWFF?=
 =?utf-8?B?OTRNMm9nY3FRWGxtUXZiWmF3U29JVFE1V2x0M3JqdVFkT2Zib0dMYnI3VDBK?=
 =?utf-8?Q?ctVg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8703.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cd9030-74cb-4bd0-9409-08dc806af020
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 05:39:56.2707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pylDaWa8rw/1zbsxE/KZaBRuhvRBVX5KDNiV+E+9CyAolB8h/a+L+0GE5FgewINFpIWwpmU/1RJNqUdqQrvsoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229
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

SGkgTHVrYXMsDQpUaGUgcG9sbGluZyBvZiBjYXJkLXN0YWJsZSBiaXQgYWxvbmUgaXMgZW5vdWdo
LCBhcyBpZiBjYXJkLWRldGVjdCBiaXQgaXMgbm90IHNldCBhbnl3YXlzIHRoZSBjYXJkLXN0YWJs
ZSBiaXQgd29uJ3QgYmUgc2V0IHdoaWNoIGxlYWRzIHRvIHRpbWVvdXQuDQpJIGRvbuKAmXQgdGhp
bmsgaXQgaXMgc3BlY2lmaWMgdG8genlucW1wIHBsYXRmb3JtLg0KDQpDb3VsZCB5b3UgcGxlYXNl
IGxldCBtZSBrbm93IGlmIHlvdSBvYnNlcnZlIHRoaXMgaXNzdWUgb24gYW55IG9mIHRoZSB6eW5x
bXAgYm9hcmQ/IA0KDQpUaGFua3MNClZlbmthdGVzaA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBNYXkgMjksIDIwMjQgODozMyBQTQ0KPiBUbzogbHVrYXMuZnVua2Utb3Nz
QHdlaWRtdWVsbGVyLmNvbTsgdS1ib290QGxpc3RzLmRlbnguZGU7IEFiYmFyYXB1LA0KPiBWZW5r
YXRlc2ggPHZlbmthdGVzaC5hYmJhcmFwdUBhbWQuY29tPg0KPiBDYzogU3RlZmFuIEhlcmJyZWNo
dHNtZWllciA8U3RlZmFuLkhlcmJyZWNodHNtZWllckB3ZWlkbXVlbGxlci5jb20+Ow0KPiBBc2hv
ayBSZWRkeSBTb21hIDxhc2hvay5yZWRkeS5zb21hQGFtZC5jb20+OyBMdWthcyBGdW5rZQ0KPiA8
bHVrYXMuZnVua2VAd2VpZG11ZWxsZXIuY29tPjsgSmFlaG9vbiBDaHVuZw0KPiA8amg4MC5jaHVu
Z0BzYW1zdW5nLmNvbT47IEpvaGFuIEpvbmtlciA8amJ4NjI0NEBnbWFpbC5jb20+OyBQZW5nIEZh
bg0KPiA8cGVuZy5mYW5AbnhwLmNvbT47IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPjsg
VG9tIFJpbmkNCj4gPHRyaW5pQGtvbnN1bGtvLmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFU
Q0ggdjEgMS8xXSBtbWM6IHp5bnFfc2RoY2k6IE9ubHkgZXZhbHVhdGUgY2FyZC1zdGFibGUNCj4g
c2lnbmFsIGlmIGNhcmQgd2FzIGRldGVjdGVkDQo+IA0KPiANCj4gDQo+IE9uIDQvMjQvMjQgMTA6
MjMsIGx1a2FzLmZ1bmtlLW9zc0B3ZWlkbXVlbGxlci5jb20gd3JvdGU6DQo+ID4gRnJvbTogTHVr
YXMgRnVua2UgPGx1a2FzLmZ1bmtlQHdlaWRtdWVsbGVyLmNvbT4NCj4gPg0KPiA+IE9uIFp5bnFN
cCB0aGVyZSBzZWVtcyB0byBiZSBhIGRlcGVuZGVuY3kgYmV0d2VlbiB0aGUgY2FyZC1zdGFibGUg
Yml0DQo+ID4gYW5kIHRoZSBjYXJkLWRldGVjdCBiaXQuIFRoZSBjYXJkLXN0YWJsZSBiaXQgaXMg
c2V0ICppZiBhbmQgb25seSBpZioNCj4gPiB0aGUgY2FyZC1kZXRlY3QgYml0IHdhcyBzZXQgYmVm
b3JlLCBpbmRpY2F0aW5nIHRoYXQgdGhlIHNpZ25hbCB3YXMNCj4gPiBzdGFibGUgYW5kIHJlbGlh
YmxlIGR1cmluZyBjYXJkIGluc2VydGlvbi4NCj4gPg0KPiA+IElmIHRoZSBjYXJkLWRldGVjdCBi
aXQgaXMgKm5vdCogZXZhbHVhdGVkIHRoZSBjb3JyZXNwb25kaW5nIGNoZWNrDQo+ID4gbGVhZHMg
dG8gYSB0aW1lb3V0IGluZGljYXRpbmcgdGhhdCB0aGUgY2FyZC1kZXRlY3Qgd2FzIG5vdCBzdGFi
bGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMdWthcyBGdW5rZSA8bHVrYXMuZnVua2VAd2Vp
ZG11ZWxsZXIuY29tPg0KPiA+IC0tLQ0KPiA+DQo+ID4gICBkcml2ZXJzL21tYy96eW5xX3NkaGNp
LmMgfCA3ICsrKysrLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvenlucV9zZGhj
aS5jIGIvZHJpdmVycy9tbWMvenlucV9zZGhjaS5jIGluZGV4DQo+ID4gOTM1NTQwZDE3MS4uZDBi
Y2NkNDFjYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy96eW5xX3NkaGNpLmMNCj4gPiAr
KysgYi9kcml2ZXJzL21tYy96eW5xX3NkaGNpLmMNCj4gPiBAQCAtMTE2OCwxMSArMTE2OCwxNCBA
QCBzdGF0aWMgaW50IGFyYXNhbl9zZGhjaV9wcm9iZShzdHJ1Y3QgdWRldmljZQ0KPiAqZGV2KQ0K
PiA+ICAgCSAqLw0KPiA+ICAgCWlmIChJU19FTkFCTEVEKENPTkZJR19BUkNIX1pZTlFNUCkgfHwN
Cj4gSVNfRU5BQkxFRChDT05GSUdfQVJDSF9WRVJTQUwpKSB7DQo+ID4gICAJCXUzMiB0aW1lb3V0
ID0gMTAwMDAwMDsNCj4gPiArCQl1MzIgdmFsdWU7DQo+ID4NCj4gPiAtCQl3aGlsZSAoKChzZGhj
aV9yZWFkbChob3N0LCBTREhDSV9QUkVTRU5UX1NUQVRFKSAmDQo+ID4gLQkJCSBTREhDSV9DQVJE
X1NUQVRFX1NUQUJMRSkgPT0gMCkgJiYgdGltZW91dCkgew0KPiA+ICsJCXZhbHVlID0gc2RoY2lf
cmVhZGwoaG9zdCwgU0RIQ0lfUFJFU0VOVF9TVEFURSk7DQo+ID4gKwkJd2hpbGUgKCh2YWx1ZSAm
IFNESENJX0NBUkRfUFJFU0VOVCkgJiYNCj4gPiArCQkgICAgICAgKCh2YWx1ZSAmIFNESENJX0NB
UkRfU1RBVEVfU1RBQkxFKSA9PSAwKSAmJiB0aW1lb3V0KQ0KPiB7DQo+ID4gICAJCQl1ZGVsYXko
MSk7DQo+ID4gICAJCQl0aW1lb3V0LS07DQo+ID4gKwkJCXZhbHVlID0gc2RoY2lfcmVhZGwoaG9z
dCwgU0RIQ0lfUFJFU0VOVF9TVEFURSk7DQo+ID4gICAJCX0NCj4gPiAgIAkJaWYgKCF0aW1lb3V0
KSB7DQo+ID4gICAJCQlkZXZfZXJyKGRldiwgIlNkaGNpIGNhcmQgZGV0ZWN0IHN0YXRlIG5vdCBz
dGFibGVcbiIpOw0KPiANCj4gVmVua2F0ZXNoOiBDYW4geW91IHBsZWFzZSB0YWtlIGEgbG9vayBh
dCB0aGlzPw0KPiANCj4gVGhhbmtzLA0KPiBNaWNoYWwNCg==
