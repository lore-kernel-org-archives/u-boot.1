Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD880CA0FE9
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 08:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CC1582FC7;
	Tue, 26 Aug 2025 10:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="3Ooyo6BE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73C1D830B3; Tue, 26 Aug 2025 10:19:32 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 579FB828A2
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 10:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1n6aRQU9fGELb8TzT91bu6DbeXaCPZkPnEzSSO+Ukyiidq5y7mNF0Lttui0zcRhVf4Alk9I+KdRtNPZe7DtGjyWQNxrUDo3sA7zRw9wIS2ZT3OEn/ZfLtt0ugR7LiXA26aefOMbIiNVlkGdGCrh3TsWscQZcxici4VHK+YD4Du9ZqS38xfAt4XLzQfABztI4cVTN36RRcF0J6m0IsuFPRJpxf8p67VhGvSM9iy4H4jClvrmxX1AJ2ztxDvvd1hDrnGYe3Mlz2+mVEYivWzZkKzvkrSxBr/ijYjT4LkcjHDtWCssqTX4tBAZcOmbbaeKeWGUK9/6/knHfGTw3Fk/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIx0zvEJiHBmzmCsPpwYwgQ+yQKUQM/X6X/ye0BaCew=;
 b=vLtvmPMUDRfw5WNYaxv6agNKCYmwakIYDzPVP7OYnS43VM1zbiFXJw4MmPjIM25W8C9mJgmFYP5hqy4xqg7x7NdDmAyqnUjjirWN6oJH+HFXeXqd6vmvpPgPNH54l6DE9LNHukSzs9sTG5DMAVnc5+15N91M3IhJqSDsE8n/yzsJhrHOYaBNvM0bD8MtK1NCTpmCHHhAv9iMH7HTNOk4pPnRjY/TiMxhLjA1EMwolFS5Rylq0aR4u65vjEC+iUJAj6jvsg4TeP9cr0nyc6zg3QdYH+wzp/7w7kIF5N6bkJ8t1dcaYuBMjb/9FXno1/MZoY42bjqqstLDiNuPvU2Iig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIx0zvEJiHBmzmCsPpwYwgQ+yQKUQM/X6X/ye0BaCew=;
 b=3Ooyo6BEM48dTqQGpZeITnDJwvAOhr6GfUHErxgT5ScJH2ETT/6ff/T63bDjuLWLFsNDBqEcJYlQWw3hmOOBCNavGkUGo3d9pn8CKvbrJlZgGc0pSGqaGnCjMw/H6OyDJi8EtOqj/C6CaF3Hgfy/NJWQW74pH/obF1YNhV/IrJdIlPG1z/AtVB3gKbYL4iGqFW5dlBrLnoSSdF5+0b67Ye7cDpT5LAWrcJGYTPB6jW6l+iI3Yg3q6pmRJiU5OMm9F8bQ5waxjnsQSbbltQP2AuPb8X6W1ER2I2MYRGrzGMat2bOj4xojr5RpdI84UPEDuDBmnGy6BPY725XbXa+pxQ==
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by CH3PR11MB7276.namprd11.prod.outlook.com
 (2603:10b6:610:14b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 08:19:25 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::3e5:a1de:4a96:d1b5]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::3e5:a1de:4a96:d1b5%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 08:19:25 +0000
From: <Mihai.Sain@microchip.com>
To: <eugen.hristev@linaro.org>, <Ryan.Wanner@microchip.com>,
 <trini@konsulko.com>, <Romain.Sioen@microchip.com>,
 <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>
Subject: RE: [PATCH] configs: sama7d65_curiosity: Resync with savedefconfig
Thread-Topic: [PATCH] configs: sama7d65_curiosity: Resync with savedefconfig
Thread-Index: AQHcCpHZ9EcTCgDV2EC5EiwVKi/6RbRjVWqAgBFPHgCAAAoIUA==
Date: Tue, 26 Aug 2025 08:19:25 +0000
Message-ID: <PH3PPF37F43E35DF0D8E49CA52DCC49A31B8239A@PH3PPF37F43E35D.namprd11.prod.outlook.com>
References: <20250811073033.5173-1-mihai.sain@microchip.com>
 <2d968b86-b45e-4d72-9f65-7696cdd0f617@linaro.org>
 <2e40fdd9-2cee-4538-ae62-68449e526a9e@linaro.org>
In-Reply-To: <2e40fdd9-2cee-4538-ae62-68449e526a9e@linaro.org>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|CH3PR11MB7276:EE_
x-ms-office365-filtering-correlation-id: 9c78ee09-6cef-43b1-1ea5-08dde47944bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d0RDb2lkQXR5U2pqWDM1dWxKZHdac2IyQWI4ZVpYcGl4bERjMHlwQS9ESG5F?=
 =?utf-8?B?NlBnOFZKWUtXRjRhQzRMYlhVbEhtazNFZnZYMGdabXhrV1FQMVl6SkNZWElp?=
 =?utf-8?B?emt0QzhnMHZWdlZLZzZxdFNCYzlBdm5qY0N5V0FPd1F3VXdZcjVRUWI0ZGNv?=
 =?utf-8?B?c1dOeDg4bUpYYUpucHpySzRBQS95WUFWZ2I4YUFCQzdlbldQUFlUMWtvaWZ1?=
 =?utf-8?B?N2NRdFZGREY3WU1NNUF2cWQxRm82M0htY3ZUc0V5R0duKzNyMVg2MG9qcmRh?=
 =?utf-8?B?VnEyWUVYWHJTR1d0bXZLSXZuOFpDNC9CNHM5bE5RdmNHNTV2c2x5ZkVPZVlQ?=
 =?utf-8?B?L1NQdjN1aUdDVmllcmx2YkZkQWxzKy9aQ3JlMHZsQWxnTFk0L3NpL0RmY1dZ?=
 =?utf-8?B?dUVNcVNNWVJua2dTVDhEQ2JBWVRyZFQ5aVZwVWF3aG1HZ3ZaRnNIOHNxME5t?=
 =?utf-8?B?KzlndEJ1NlVxY3cwVzdTUGZveS9FU2l4QlNTSTJWQ2hMYkJzK20vWC9ER3NC?=
 =?utf-8?B?dzh3aXE4cjBjYTByYTdnbEhzMTRwVldiWkZsWkY0a0ZXbDIvK1F0akdTRWI2?=
 =?utf-8?B?RWZxY0J3emtkR1FXUWtYUm44cTBZY0w2MzhxMG8rY1FwSHdpV00xVVJmaUZV?=
 =?utf-8?B?N21xZ1RZWWtlbFdQNWRtSXBudUphRXh3cm5oa1hIRllVR1lHUFVGT1N6NERB?=
 =?utf-8?B?V3E4R3l6RVZNTHZhMkp1dURKR3MzQ3B6bUpFbnB6Ui9adENkZzhLOVNiRVh3?=
 =?utf-8?B?eldaNUN2RlZ3R3l0a1pBeHRyRXFWcmVYRUkvdyt0ZFJMNHVuYmVIYjZLeTZN?=
 =?utf-8?B?TlczWUZUZ1k4TXVrNUgrTGgrdVEvV0FaMmhGNHpDQkI2MHVHd25tRWVwRTUw?=
 =?utf-8?B?UU5rK0pjN3lFUXd1VUpVV1N0UlA3Z25JN2FrMGdBTHNZdUFoSnhJb2lvRnBa?=
 =?utf-8?B?ZENPemhweTJDT2E3ZzlCQWQyS24wTndHZU5xUlFYMVI2SkUySjZnVUdvOTh3?=
 =?utf-8?B?MGRoNENQN1VmeW9kcng3V3QwS1NxWHYyWnNCbC9acndMenlXOE9LSjhQVkZm?=
 =?utf-8?B?bE9VUWY2aG01dnFIeFJlWFFyS0N1UHJtRGRPOTRBaE5hWlZOS1NWYW5TZlhl?=
 =?utf-8?B?ZDFFNWZEWTZ6djczejRGSjZPS0JVa0J5ekd3ZGM1SFN1bFd3UXZKdG9tYUpk?=
 =?utf-8?B?NlVJMmdJMW5Qa21KRGFkcUNoSWNuYUhlNS9xQkNQdS9sTWN2ZHVxQUwzSXNY?=
 =?utf-8?B?dXFOSXpqOXBSdWNZM0E3U1JIODhTelp4SnJTUFp0eEoxZjFMSTZoWG9jTGNv?=
 =?utf-8?B?dXRpSnNRTnFXTk45ZGRHY1BodHF3Wnord2FBUEZiSkFEb09oWEVSdlA4bkQ1?=
 =?utf-8?B?am84QkZ3V3B0a3A0VWxwS1JTVEJzcDQ2MGF1UmtDWDh0MGtRLytUVll2REsy?=
 =?utf-8?B?dEdoWEYvWG03ZjFNUXdweVpEczJLSVRyVlRCNmdoN1dzUDMxR2g5ZlNCZEVy?=
 =?utf-8?B?cVFuNk5WUXlCemdLdVh0T1JGalBTdWg2cUtmTEo1bVYyOW4yS1RzRzlHcEtZ?=
 =?utf-8?B?L2tDeEpISDk3L05iSUd5V2ZWZHY0ZzFEeUs5YU9IN1lXVUs0NU53b1ZmQ0Uy?=
 =?utf-8?B?YWp0SUczaEFTZlNJUzRsSnhkdXpaS3Y1dUhFUUFZQkxRbDg5a3h6WHZRMjZp?=
 =?utf-8?B?K2FNSy9XeTVXamJyeE01ZHlNNlhmMDR5SEZsYnY5RFJ0aWNCU2ZYSjBpSGhF?=
 =?utf-8?B?VkJZK2k5Zjl5Qk1JNDJCMVVzQ3JWZmhrNEVMT0JGenFobXNCL0hmKy9QZGJV?=
 =?utf-8?B?R0xKZFllRVd6b25SSDRnSzl5b2U5YlU0S3Noa0kyKzQyT3RlM3FSSmVaVHB5?=
 =?utf-8?B?VzR1cjhYL0dBUEliYXdScG94enYyREZvS2FBTVJBQ2VybzdEMXRud3pXL0pj?=
 =?utf-8?B?a3RhTEx4QkttWUtEVEJPRkkzM251aGlqWEJ4bnFpOU9IWGFtRm9MU3ozb2NG?=
 =?utf-8?B?R0VjaFhtR0t3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnNmMHNrYkYwZlVLd1NJL09mV2VLM1hxbys5MURtVVo0Sm5KZWdYcWlwdU53?=
 =?utf-8?B?clhQU3UvaEtBRlNNd1IvcFdHWjRqMHBCRDhndFNjcDNkcGs3Zmp6NWF5V1A3?=
 =?utf-8?B?NkNnZSt1R2l1WGVUY0ZkdEoxb0RWbVkrbmIrWHQwMExEUUQzQWFRb2hXcEtG?=
 =?utf-8?B?QlBybUp5UXpKdlRLVDFZNXVuUXg5emtkRlNKMEpSTStLZ2VPQ1Q5L0ovNUFV?=
 =?utf-8?B?T3BQWEY2YXA2bWxYMlg0aEwwelhhdDRlUjZaNERJSzhrdDBMZFVBNmUxd3BZ?=
 =?utf-8?B?TUE1Rno0b1loVEVzYWFCVVhjLzlHcHROVGJvNXlHRHdrTzVBWnF2ck9odWM1?=
 =?utf-8?B?c3pKL1dxTTU3dnFvOUxtUDRjMDZIa0FIYzllV3dLZmEvYWVxazFseG01d1U3?=
 =?utf-8?B?djlMUHJoNWJwem9vYndUTGR5cC9TbDl1d29Rdlh1RFZhR3ZhalNFaEtBZWpX?=
 =?utf-8?B?dS9EczdLb1lwYXNSOWI4bjlONmVmb3hJL29SYlJFcFFYUDZxc2lJVlpHWnB3?=
 =?utf-8?B?b0hEZXRldUg3Vy9rQzRkUjFrRlJjL1U5YjUrQ0VvbmJRcUxtcWMvVHc5bVNx?=
 =?utf-8?B?S09YejJaSDB0RlZBYmhHQSt1cGpMRGZ6d3JLdlpNRFZ0QjZsNEJ4N2d5aXJ5?=
 =?utf-8?B?Wm1DQTlsSGFpd1lFbUxJTW5xUzVLTDJ2MFFYNHNIeVV2TVhVRTUyY2o0NjRj?=
 =?utf-8?B?Um1QYlNlZC9QTkk2TWtHVURmZ2Y5TTBwcHRUUjcwdnREaGJ2MGlKRkNtNEdv?=
 =?utf-8?B?SlJ4ZXNWdlhUVlhSSUFHK0YxOC90UUtoZlFMemYycHVlRk9uZ3hId1UrSWN0?=
 =?utf-8?B?UnkxSDJvZTk4YVlpRzNmTXE5WDRTU1Q2ZHBVY1ZBQ29tN0YrSG8vY2JLeUVk?=
 =?utf-8?B?ZHFPUDI2SW0wckJKaGJrWTgyOTc1TEx5bjFnZ0ptVXdvdXBXNStDUlFVRTlm?=
 =?utf-8?B?L3JMQXl2cloySlZZeG9rb1RjNDFHbnUzZXNUOUx2cWg2cW9zam1POUlZMWN6?=
 =?utf-8?B?dnJLb1gvM1FnYmdqOHNHcDhjS0xTVXc0cEZ4RW9sU0pBcHI1OHFBanNnOXI0?=
 =?utf-8?B?K2ppcWVnbzhydkhoaVYrZnpSVVJodG12a2JQUEdMUXNrMDdUdUhHYkM4alpZ?=
 =?utf-8?B?ZFNpZDUwUUxLVzd2YWJJV1pBcnVCZGdMNzVyaHZ0ZmdIb2dmbDRYb0dud3h0?=
 =?utf-8?B?a0lLd0NSV040QlNoYnlhZXVJeVE1K1RxUUV3dXk0b0E3RmU1bjhrTzVEanov?=
 =?utf-8?B?bDVKY3k4NXVuOXJBTGJOV2FZUm9BbzZ5YlJNT2VzZGJpYnJOWldPOTY1UDNl?=
 =?utf-8?B?TXhtOTFVek9sN0NRWmJBaHFpUW5VRHRMbWExTmdrdDJmTnZzM1p3V1Y1N0ND?=
 =?utf-8?B?WGthN2UvM0phUndrbEh3Nm9XY0E3eWc4UVFveG45eEV0MWJlTlRaY3JjV0l4?=
 =?utf-8?B?UWxpa0tlTWRuL3JvOWNQTVZPNmpRcVBtajhWQTNIQkc2VUhYQVZ3WnBLdW1m?=
 =?utf-8?B?WktjaUdDWmRMMWlFTURhcmhhS2tjRTliSEk0cWxRVVdSY3JDQmpOOVFraEk5?=
 =?utf-8?B?V1k5Mlh2NUtGSGFodUN5QmZxNG1NQUF0MmFuQWtTR3BTaE9Gem5iMzd2WGNT?=
 =?utf-8?B?NUxsc01HZkk3TTFYdnV0RFR0MnVlRE8wWHYxVGpEd042RjVkQWVBb2wwcTJU?=
 =?utf-8?B?dVp4NFk4bjlUckt4b0diczk2TW4wR0xTR2o0OXFheUNyRzV6RjFLRmNCelZJ?=
 =?utf-8?B?UDUweGxad1Y3cG8xa3pZOFowd2QrVzVpTFE0MjF0ckJhRmVGODdYNGFxVTNI?=
 =?utf-8?B?a0UvT1ZMTnZPbXBnV3d0K2hha1dVYllOQjQvR09peEJVOWRBbG5JQXVuSU5h?=
 =?utf-8?B?SDJmQzU5L2FSLy9oV1ExSU40bnpDYUx0aFhBMXpjdWU1T2pCTmhTSjlGYW50?=
 =?utf-8?B?dTkwNHlOc2oxVzhPM1ZQYkZYdjVjeVlRcUVWcUk5YjdIUmcwUVNyRTRjdTFr?=
 =?utf-8?B?bmhDNWR5cm1ya2UvZzNXT0dONDhSdUpPNkFzSDloRERKT0w0SWRkSXZadDFv?=
 =?utf-8?B?b1pIQ3J6RHNVNjBqQ2VtWnhkZThLYVlwRk5xd2t2MXA4a0ljSHQyVGp1SDBC?=
 =?utf-8?Q?DhBO0vbN6kod9MZtlCeXWmm+P?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c78ee09-6cef-43b1-1ea5-08dde47944bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 08:19:25.1430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3znQX0LKoVd2Gh59nG7TTRQeOyoSn856h3axs0N5zqGFsTZ8LH+2bz0Bzou3GdNPsroN08jiQpOacLT3ocYEfp76E7aTynQYG7Al5aCs6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7276
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

SGVsbG8gRXVnZW4sDQoNCj4gSGVsbG8gTWloYWksDQo+IA0KPiBXaGlsZSBtZXJnaW5nIHRoaXMg
aW50byB0aGUgbWFpbiB0cmVlLCBJIHNhdyBzb21lb25lIGFscmVhZHkgcmVzeW5jZWQNCj4gdGhl
IGNvbmZpZyB3aXRoIHNhdmVkZWZjb25maWcuDQo+IEhlbmNlIHlvdXIgcGF0Y2ggb25seSBjaGFu
Z2VzIDIgbGluZXM6DQo+IA0KPiBAQCAtNDksNiArNDksNyBAQCBDT05GSUdfQ01EX0hBU0g9eQ0K
PiAgQ09ORklHX0hBU0hfVkVSSUZZPXkNCj4gIENPTkZJR19DTURfRVhUND15DQo+ICBDT05GSUdf
Q01EX0ZBVD15DQo+ICtDT05GSUdfUEFSVElUSU9OX1VVSURTPXkNCj4gIENPTkZJR19PRl9DT05U
Uk9MPXkNCj4gIENPTkZJR19FTlZfSVNfSU5fRkFUPXkNCj4gIENPTkZJR19FTlZfRkFUX0RFVklD
RV9BTkRfUEFSVD0iMDoxIg0KPiBAQCAtODgsNCArODksNCBAQCBDT05GSUdfU1lTUkVTRVQ9eQ0K
PiAgQ09ORklHX1NZU1JFU0VUX0FUOTE9eQ0KPiAgQ09ORklHX1RJTUVSPXkNCj4gIENPTkZJR19N
Q0hQX1BJVDY0Ql9USU1FUj15DQo+ICtDT05GSUdfRkFUX1JFTkFNRT15DQo+IA0KPiBBcmUgdGhp
cyBzdGlsbCByZWxldmFudCwgZG8geW91IHdhbnQgbWUgdG8gbWVyZ2UgaXQgbGlrZSB0aGlzLCBv
ciBkbyB5b3UNCj4gd2FudCB0byBoYXZlIGEgbG9vayBhbmQgcmVzZW5kIGEgcGF0Y2ggdGhhdCB3
b3VsZCBqdXN0IGFkZCB0d28gbmV3IGNvbmZpZ3MgPw0KPiANCg0KTm8uDQpUaG9zZSBjb25maWdz
IGFyZSBub3QgcmVsZXZhbnQsIHlvdSBjYW4gZHJvcCB0aGlzIHBhdGNoLg0KVGhhbmtzLg0KDQo+
IEV1Z2VuDQoNClJlZ2FyZHMsDQpNaWhhaQ0K
