Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F7ED60D18
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 03:22:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CA5E8926F;
	Tue, 19 Nov 2024 04:22:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Nqz3yu+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7F468926F; Tue, 19 Nov 2024 04:22:22 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE6BD89258
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 04:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7qpq2p33+PxcxMku+rjkOKp6PVd7cunUJcBCHeQ6E3bRUaLb/sUYAg8V4QboZgQ2i5s8tTwbZ9JdBbpJf2INB59nwfHAeriNdgIhK+sMr23EGXFQKUe4lE5W+try0LPg+/9xRSfRomFAF898DHCNYIchvDVdPZVygtn7TjM8Tg58sQ/bZpXljjKpIx9qoaBSrzTtKLo7QC5QCoRgS97WyDNMnnKTuMrvJiDOiGlMTBBruYBCUmfiRZgreACZJj77S7gbJYAYLxG8RtHiN3+aGKwv9Io9bMTbxLgBtKjN8mGRrAQgLEtjp+rHGIPgmQ/i/1vNDwEpaYGrXPoxMx1Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eS5H3W72nfF9u8N872DjUAaUl4tEM1DaKSrbmhjRTEg=;
 b=KPAYbccnyQU35V+LgZ6MDmQ+5V7za6RYJaFLGnufpGPb3zd9f3LVjcRpNYGNEabH4U4ndKUWeie7KsZLurAoAMYBmcKjQ0LvCM9izNOZFlm642ht5iTyxDyY9IYjB5a5ImcO02q99828rRZykDruHLmsOH5MEi4amgM0HAR8yGNy5kijj+eYgN/75M+cIKLcIOKCufkMF7lZdolHDIaAw57JpzCQerzXp3qt37vI0LJsEymmkKSfENXEN2bK2AEUvXg/ResOpVjssw4leQcgC1kbtNa3KowzOcYfICE2AEbDqbShTAifj33FegWDYeVJ/txcoaEtpH0Hf+Z9X+1+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eS5H3W72nfF9u8N872DjUAaUl4tEM1DaKSrbmhjRTEg=;
 b=4Nqz3yu+ICYwtNabeZoU4W6yWDVIXVu1JJ3XWFKZHJHsMKc9wmJmgY7CWvqjY2hnEaFAEWc10+egzd2nI/zZnLLjWUVR9jeg7/JCJD74PoFZpYZp4gpvLMcwNTXF8tv6f/zoaeTSYgGmtixnCPOjViXmv2cIzPuVFVsClIKRiXA=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 03:22:14 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 03:22:14 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
 USB5744
Thread-Topic: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
 USB5744
Thread-Index: AQHbNMKT41MM9BpbCkCVHbjRknnK4LKzJkQAgAAKwlCAANxLAIACID3QgAC2pYCABkWfkIAAGvuAgACzSwA=
Date: Tue, 19 Nov 2024 03:22:14 +0000
Message-ID: <SA1PR12MB86972FD15A7312EF59F1A5D298202@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
 <20241112050740.15343-4-venkatesh.abbarapu@amd.com>
 <d61ab683-744d-4024-a5d3-71b372e85d02@denx.de>
 <SA1PR12MB869770E331845B38B0BC2AC098592@SA1PR12MB8697.namprd12.prod.outlook.com>
 <5c4c73e1-4b47-427a-b84c-099b044d07a8@denx.de>
 <SA1PR12MB8697165267E847E8F8FDC0D9985B2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <b06d22ba-6629-4893-a90e-185f676017a5@denx.de>
 <SA1PR12MB8697C5004BB109302CE441B198272@SA1PR12MB8697.namprd12.prod.outlook.com>
 <5cd2a342-7208-4cf1-8faa-90dfd82ae5b0@denx.de>
In-Reply-To: <5cd2a342-7208-4cf1-8faa-90dfd82ae5b0@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|SA3PR12MB7805:EE_
x-ms-office365-filtering-correlation-id: 215cc2db-6887-469e-a981-08dd08495cf2
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bmt3bzJSK2pEcVFEditseXZzb3k5MlhlMkNWdlgzc3BzUGx3QlM0NzJYNHNy?=
 =?utf-8?B?YkZ1bmZ6Mjh1Mko5VUwwNXhjS3RBeFNpUGlaQlJJakd3blNWR0lHc2RUYXNq?=
 =?utf-8?B?T010T1puNEVFNEtXa2pOc0VsenpMMnlSQW5QSGlRWitleDJRMFJmbnVJWGlU?=
 =?utf-8?B?R2Vmd3FSNTJ2SzB3YksvTkgwVkgxTzlZeTJFeThNK0hCQWJ5QW5UcDhJeXVG?=
 =?utf-8?B?THFHYWMwL2ltMU1BMk1DdEpmbkYvNndIOVFRN2dkS1MxMU9CdGxpdHhoY29y?=
 =?utf-8?B?bk56OWtiQ3NRakV5aC9NcHBsQkFJSWtqM1NQQi9UWGNzNFFJU1lCVlB3eVRa?=
 =?utf-8?B?YUQ4MDFxb2gxZ1Zma3BrMUd3TFJkb1JBd1A1L1diYWVSK1F5Mk03TkVCYUt1?=
 =?utf-8?B?MDI2L1M3LzZFemJwTE1DdWRTMWhNMlM5bFBnNnVlNmIyTWxMR29HNVFDZklL?=
 =?utf-8?B?TU5wQXVDZnRtZ3RXOGpML3oreWthWElPdVlaVjFXV1YybkFmVmgwWkVLNC9X?=
 =?utf-8?B?NkNWRklCdnlrdk9ESmRHSXVzaTdTc1ZnaDkwdUlEc1F2Tm9HTGJkZ28zRjg1?=
 =?utf-8?B?Mk0vVXhlbUdJYm9LUVd0NlFMeFRpUEVHR240dlFxYWV0MmQ2QThMOU5TMHZY?=
 =?utf-8?B?am9TVGdxNXhXVFdtU29URGt2aGNsaTZyMDlENHBVOUg5YWhIVkFwWlE0eDFJ?=
 =?utf-8?B?cDBsVU1PQlN1MlJrQWtnTi92RHRnTTlyRUh3ZFRNQ1k3aXk3TGRtcUZxTjR2?=
 =?utf-8?B?UnZrYlA4aEhzajJSTGljUGRUdDE0K05Ob3k0VGpNaDBPZWlXZ2JzVElDcTh4?=
 =?utf-8?B?OTVadFluaXRZVjZ5ZUVIYVVqVzhnSWx6ZFB0a2V4dGUxYUJKa3lVM0h5VEk1?=
 =?utf-8?B?N2J1eDBiRC9oaStEVURyMVhHU29MMG5YejNaR091ODdjQVhETXBMKzUwV0Mz?=
 =?utf-8?B?eHV0OVhaa3orMUJ4dHdIVHE5dE1JOWJEZHJoa2Z6M1ovakVqZ2owbUQwYzQy?=
 =?utf-8?B?eTEwRnd2UTF6SWRab1hWeVdreDNXOFhCQ1JPNG5WT1ZyREZxNUZneWxhdnMw?=
 =?utf-8?B?NC90K0cyV0ZYTjdqQ2t6eTZVMTF0WWlDbDVOV1VYSjVvaFVMRFZEai9tM2tp?=
 =?utf-8?B?M3NhTjRESHh0VU5nU0Fla3Nlam5ETlNxUEs1SWFlUUo1dFRlK1R5TWc4MDhR?=
 =?utf-8?B?SFZnZm1EQjc1ZXdyTjc3R2VUUi9keDFMWW0wTFV6U2pORFl3SzBRYlhHMEVy?=
 =?utf-8?B?ZDBPajQwYU9FbzJQY2FYaHFYbG1oSTdZNFYvSVJ2aklPc1NxTTZtSUJzYjNQ?=
 =?utf-8?B?ZUhBY0tXQkRBdlFCR20zRmd5QWdUMkErSXZnaWE2d2lHNXFHYUx5bUU4NzFX?=
 =?utf-8?B?YnkyK2NxR2RVTkd0YUtwWWJCODEzTWliYjhxVW9aOFluenh0Q2tTT3ZmV2w4?=
 =?utf-8?B?VGhsRXF1NnlDcDUxZWtpTW9TWlQzZitYNGJJSk1ZUitYWUNwcnJ3QVYxL2FI?=
 =?utf-8?B?ZFdHQ2N3SUlCSkZmUXRYL3dxRG1jVnZrajAyYTJkbkQ4QzBFc1ZwTnVzYW1G?=
 =?utf-8?B?VUEvTC9pdkt6MDlQbXBnSkI3T0xaSGgyN1NsWEc1eGZIZ0xob0FGN05YRi9a?=
 =?utf-8?B?UzNobmxKYVlpNVF3VWdjbm9ZUFQ2MkZ5ajl1dlhrUnhOMGx4blRQNFNyY3di?=
 =?utf-8?B?SkVmQnJrVGl6NXJwb3NKUFBveHVYN0lSZ0lXQnBSSHNFNjg4U3FTVlV1ZWdO?=
 =?utf-8?B?WEliNllBMEcyRlBaZ3p2UmZuNXErOWV3SVovSmVvbzIrbXkwQXlmOTM4b2to?=
 =?utf-8?B?NDF3RU5TejVvaXBoNWQ4UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2FHcForMzB2SFlQallVMVJpNG55c1pXZ3lSdlQ5YUtKdUdEamYwb3gzWnZy?=
 =?utf-8?B?bG9OeS9VWWdtNTNXL29nRVIrUFl2K2Z6U0ZKblRvQ25wVjVSZXMxNzNHQ2xr?=
 =?utf-8?B?OEF5MFlPd2k4MlNhTUFra0hyNUJPd2R5dUo0MVhrck5RMVltcHNTeU9LZ0My?=
 =?utf-8?B?TWtQRlJleWQzVC9iOTVxNExrTVk4Wm9kTTIwWGExeU9peUxOZjhkQ0ljTHNO?=
 =?utf-8?B?enVpSlRoczBMYldEZ3EyRVRZRWFwUlU0RjhHNnRRa2FlSytQRDV5SVNORmxJ?=
 =?utf-8?B?RjF4OWoxdU9SenRVcUN3bE9mZ0FYaTlpd0VvUGN4WURhZnBONUhJa3pCMjR6?=
 =?utf-8?B?a0VCRXNUdkxzcWlVSmxyOWd3alA4U3lOK0RQcDkrbFp2QWZUQ3B2NXVyMCtW?=
 =?utf-8?B?QnA2cUovRGpCTjNqeW1iOEZwR0RJeWs4Wm04RU53TnlsZnk3TksxaUh0L1Z0?=
 =?utf-8?B?NTBZM0R3NjFsRnZNemxsWmtBTGVUVW0rb0JaTzlTenRTc2lYRWNvUlpoZG1k?=
 =?utf-8?B?N0s4Z0E0V1BSRmRNc0xkTjJhbVR6a2ppTWdIbTVBUk9mNTVxM3NxMFZ5NS9M?=
 =?utf-8?B?NWwrL0QydENObm42SllaTEx2b0UrRThUL0MyR3hKRTZhNzVHT3FVWUdybzdH?=
 =?utf-8?B?ZFBzZGIxbnZDRnpGdjQxYXRURVdIUXlScWF2WjNYemFDbzRoMktDQTBwUXBl?=
 =?utf-8?B?bHBCS2xyRy9iWGFDYmprSDVveDRrUWJ0M0JoWXlXMXNjV1hVSUZZNGJRb2lS?=
 =?utf-8?B?aWZSR0Y2amozM0NjbEh5b05PekVzazBvd3hRc3RUY1BIdjl2V0ZkVkRPVVAy?=
 =?utf-8?B?K1R4U3psZWZ6UXlZMVB0YjRDeHArQ0o1Tm1xYnpTNWNnWElML3NHQVFsb0Yv?=
 =?utf-8?B?MUdzaVgrMVdGOTk2VnBOM29vUTYvYzBLL25heTcvVE5UejJocWlLc2lLMi9B?=
 =?utf-8?B?MmxEVTA0Nys0R1FPK1B1eTZOcUZGSzZlcGh3aWVDN0d2Wkg4dThaZ3ZYdThr?=
 =?utf-8?B?N2liVzNpRzR3RkNLV3ZuLytQWUwxYnRHMGEzR1MyQnhTQmM2MUlDZGNiRy9U?=
 =?utf-8?B?R2JMUU1NOXRRWDhhVEkwUVdzVkJaYTIrbTU3dU9IcktxMzZRTUwzb0M0VnJN?=
 =?utf-8?B?VWU1Q2dqcEx4QkJkMlV5QVRnSU1nYmVqeHp1Nm0vK2NRUFY3SDQyRFZaYzl5?=
 =?utf-8?B?RVVWSHc1V0w2UWpBR0J1VDlNQzA4Vkh0RDR2cFZLTnNqKzRkOElYY1NZMXZP?=
 =?utf-8?B?NGwzQUpIdTZZWVlqd2dWOG1WWFFBMkYyNWxFRStWMStPTXJXMi9GMkE3Y1Nu?=
 =?utf-8?B?V0k5aGlTWTI4TnllN3AwRGRNd2hHZjgyTWU2MjMveHpzS3hrc2paV25UYXAr?=
 =?utf-8?B?elhMNVZsYmJLNHJySkFJSVhNYkFhdkpwTzEyQUNwSnlnZTh4aU5aNHhoZkN1?=
 =?utf-8?B?SlpwMHZnNGE2VGpPSlZ6VkFGcCtYQ2hNOTJEa2lSMlBTVHJ6QmVtZEkwSTFP?=
 =?utf-8?B?S09MYXIrNVo1VEljUnJGdHd1Y295NGNqTExmeklsT3p2dFRQVVBZdXA1TEk1?=
 =?utf-8?B?ZXZhR1pHYy9YSDBhRkkxalNUTm9EUzRaZktnVUlPYlFlWlFCcFZXT1dqWWtk?=
 =?utf-8?B?MDZMaC9ib2Jod0VzYnhuWkZYNlRuK2szcWQxcWh1NHhUdExoekdkc1JvK1E5?=
 =?utf-8?B?Q1lzcGh6d1FtT1BUZ3p5OU9xU0pJTmJ0Y3A4Y1NUclM5Y0hNY2xQSlFvMFhr?=
 =?utf-8?B?R0o5VUVwS0ZXSWo1QVRlZ1lLUHJiRHhOais3c2QvZUZCN0FHblBsc29SclYz?=
 =?utf-8?B?NWVuUUkwUTFpNDFGKzFyc2xuTUp3UDNnNEU1T0RIYVNUTEtDcjZtZDNQa1RB?=
 =?utf-8?B?RU1iTFlDdXpTT2t4cXJpdEpzd3VIQ1JtbFpnNFJWZFFaTjlVblI0dm1CZVJL?=
 =?utf-8?B?K2F1TUxFUGUrZ1k2bWVmblYyamp3dFZsUVRHOEovWkNQV0ZLRTQzdXhhTUpC?=
 =?utf-8?B?VTVyclZ6UjFYdDh4WHZjNGI4TGpWeEhrTDI3MFJ3cUg5RVZLVmt6TnluaVlC?=
 =?utf-8?B?VVNQeWtDckRoekh0Q1JxQTlnWmtORHRrNGNxaXlwa2NDRkRHc2h0R0FxbXU2?=
 =?utf-8?Q?Gxns=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215cc2db-6887-469e-a981-08dd08495cf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 03:22:14.1404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bD8BSGhjbfSu7ZaMcwz0tXBGGfP0keGe3wyN9GF0rZB4XN+XoJvIpky8/aq4ynZQ8pWOsouK0QEDlu+kro124Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805
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
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMTgsIDIwMjQgMTA6MDAg
UE0NCj4gVG86IEFiYmFyYXB1LCBWZW5rYXRlc2ggPHZlbmthdGVzaC5hYmJhcmFwdUBhbWQuY29t
PjsgdS1ib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1l
a0BhbWQuY29tPjsgZmFicmljZS5nYXNuaWVyQGZvc3Muc3QuY29tOyBnaXQNCj4gKEFNRC1YaWxp
bngpIDxnaXRAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMy83XSB1c2I6IG9u
Ym9hcmQtaHViOiBhZGQgc3VwcG9ydCBmb3IgTWljcm9jaGlwDQo+IFVTQjU3NDQNCj4gDQo+IE9u
IDExLzE4LzI0IDQ6MDkgUE0sIEFiYmFyYXB1LCBWZW5rYXRlc2ggd3JvdGU6DQo+ID4gSGksDQo+
ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogTWFyZWsgVmFz
dXQgPG1hcmV4QGRlbnguZGU+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAxNCwgMjAy
NCA4OjM3IFBNDQo+ID4+IFRvOiBBYmJhcmFwdSwgVmVua2F0ZXNoIDx2ZW5rYXRlc2guYWJiYXJh
cHVAYW1kLmNvbT47DQo+ID4+IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+ID4+IENjOiBTaW1laywg
TWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47DQo+ID4+IGZhYnJpY2UuZ2FzbmllckBmb3Nz
LnN0LmNvbTsgZ2l0DQo+ID4+IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+DQo+ID4+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjExIDMvN10gdXNiOiBvbmJvYXJkLWh1YjogYWRkIHN1cHBvcnQgZm9y
DQo+ID4+IE1pY3JvY2hpcA0KPiA+PiBVU0I1NzQ0DQo+ID4+DQo+ID4+IE9uIDExLzE0LzI0IDU6
MTYgQU0sIEFiYmFyYXB1LCBWZW5rYXRlc2ggd3JvdGU6DQo+ID4+PiBIaSBNYXJlaywNCj4gPj4+
DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+PiBGcm9tOiBNYXJlayBW
YXN1dCA8bWFyZXhAZGVueC5kZT4NCj4gPj4+PiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDEz
LCAyMDI0IDE6MTUgQU0NCj4gPj4+PiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNo
LmFiYmFyYXB1QGFtZC5jb20+Ow0KPiA+Pj4+IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+ID4+Pj4g
Q2M6IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsNCj4gPj4+PiBmYWJyaWNl
Lmdhc25pZXJAZm9zcy5zdC5jb207IGdpdA0KPiA+Pj4+IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5j
b20+DQo+ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMy83XSB1c2I6IG9uYm9hcmQtaHVi
OiBhZGQgc3VwcG9ydCBmb3INCj4gPj4+PiBNaWNyb2NoaXANCj4gPj4+PiBVU0I1NzQ0DQo+ID4+
Pj4NCj4gPj4+PiBPbiAxMS8xMi8yNCA3OjQyIEFNLCBBYmJhcmFwdSwgVmVua2F0ZXNoIHdyb3Rl
Og0KPiA+Pj4+PiBIaSwNCj4gPj4+Pj4NCj4gPj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+Pj4+PiBGcm9tOiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4NCj4gPj4+Pj4+
IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDEyLCAyMDI0IDExOjI4IEFNDQo+ID4+Pj4+PiBUbzog
QWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFyYXB1QGFtZC5jb20+Ow0KPiA+Pj4+
Pj4gdS1ib290QGxpc3RzLmRlbnguZGUNCj4gPj4+Pj4+IENjOiBTaW1laywgTWljaGFsIDxtaWNo
YWwuc2ltZWtAYW1kLmNvbT47DQo+ID4+Pj4+PiBmYWJyaWNlLmdhc25pZXJAZm9zcy5zdC5jb207
IGdpdA0KPiA+Pj4+Pj4gKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT4NCj4gPj4+Pj4+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjExIDMvN10gdXNiOiBvbmJvYXJkLWh1YjogYWRkIHN1cHBvcnQgZm9y
DQo+ID4+Pj4+PiBNaWNyb2NoaXANCj4gPj4+Pj4+IFVTQjU3NDQNCj4gPj4+Pj4+DQo+ID4+Pj4+
PiBPbiAxMS8xMi8yNCA2OjA3IEFNLCBWZW5rYXRlc2ggWWFkYXYgQWJiYXJhcHUgd3JvdGU6DQo+
ID4+Pj4+Pj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBNaWNyb2NoaXAgVVNCNTc0NCBVU0IzLjAgYW5k
IFVTQjIuMCBIdWIuDQo+ID4+Pj4+Pj4gVGhlIHVzYjU3NDQgZHJpdmVyIHRyaWdnZXIgaHViIHJl
c2V0IHNpZ25hbCBhZnRlciBzb2Z0IHJlc2V0Lg0KPiA+Pj4+Pj4+IFRoZSB1c2I1NzQ0IGh1YiBu
ZWVkIHRvIHJlc2V0IGFmdGVyIHRoZSBwaHkgaW5pdGlhbGl6YXRpb24sDQo+ID4+Pj4+Pj4gd2hp
Y2ggdG9nZ2xlcyB0aGUgZ3Bpby4NCj4gPj4+Pj4+PiBBbHNvIHVwZGF0ZSB0aGUgdXNiMjUxNCBo
dWJfZGF0YSB3aXRoIHRoZSByZXNldCBkZWxheSBhcyAxdXMuDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBWZW5rYXRlc2ggWWFkYXYgQWJiYXJhcHUNCj4gPj4+Pj4+PiA8dmVu
a2F0ZXNoLmFiYmFyYXB1QGFtZC5jb20+DQo+ID4+Pj4+Pj4gUmV2aWV3ZWQtYnk6IE1hcmVrIFZh
c3V0IDxtYXJleEBkZW54LmRlPg0KPiA+Pj4+Pj4+IC0tLQ0KPiA+Pj4+Pj4+ICAgICAgY29tbW9u
L3VzYl9vbmJvYXJkX2h1Yi5jIHwgMjAgKysrKysrKysrKysrKysrKysrLS0NCj4gPj4+Pj4+PiAg
ICAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+
Pj4+Pj4+DQo+ID4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2NvbW1vbi91c2Jfb25ib2FyZF9odWIuYyBi
L2NvbW1vbi91c2Jfb25ib2FyZF9odWIuYw0KPiA+Pj4+Pj4+IGluZGV4IDgyN2VjZjliMDIuLjFk
MTQ2ZWNjZWUgMTAwNjQ0DQo+ID4+Pj4+Pj4gLS0tIGEvY29tbW9uL3VzYl9vbmJvYXJkX2h1Yi5j
DQo+ID4+Pj4+Pj4gKysrIGIvY29tbW9uL3VzYl9vbmJvYXJkX2h1Yi5jDQo+ID4+Pj4+Pj4gQEAg
LTg4LDEwICs4OCwyNiBAQCBzdGF0aWMgaW50IHVzYl9vbmJvYXJkX2h1Yl9yZW1vdmUoc3RydWN0
DQo+ID4+Pj4+Pj4gdWRldmljZQ0KPiA+Pj4+ICpkZXYpDQo+ID4+Pj4+Pj4gICAgICAJcmV0dXJu
IHJldDsNCj4gPj4+Pj4+PiAgICAgIH0NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IG9uYm9hcmRfaHViX2RhdGEgdXNiMjUxNF9kYXRhID0gew0KPiA+Pj4+Pj4+ICsJ
LnJlc2V0X3VzID0gMSwNCj4gPj4+Pj4+PiArfTsNCj4gPj4+Pj4+PiArDQo+ID4+Pj4+Pj4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3Qgb25ib2FyZF9odWJfZGF0YSB1c2I1NzQ0X2RhdGEgPSB7DQo+ID4+
Pj4+Pj4gKwkucG93ZXJfb25fZGVsYXlfdXMgPSAxMDAwMCwNCj4gPj4+Pj4+PiArCS5yZXNldF91
cyA9IDEwMDAwLA0KPiA+Pj4+Pj4+ICt9Ow0KPiA+Pj4+Pj4+ICsNCj4gPj4+Pj4+PiAgICAgIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgdWRldmljZV9pZCB1c2Jfb25ib2FyZF9odWJfaWRzW10gPSB7DQo+
ID4+Pj4+Pj4gICAgICAJLyogVXNlIGdlbmVyaWMgdXNiVklELFBJRCBkdC1iaW5kaW5ncyAodXNi
LWRldmljZS55YW1sKSAqLw0KPiA+Pj4+Pj4+IC0JeyAuY29tcGF0aWJsZSA9ICJ1c2I0MjQsMjUx
NCIgfSwgLyogVVNCMjUxNEIgVVNCIDIuMCAqLw0KPiA+Pj4+Pj4+IC0JeyB9DQo+ID4+Pj4+Pj4g
Kwl7CS5jb21wYXRpYmxlID0gInVzYjQyNCwyNTE0IiwgLyogVVNCMjUxNEIgVVNCIDIuMCAqLw0K
PiA+Pj4+Pj4+ICsJCS5kYXRhID0gKHVsb25nKSZ1c2IyNTE0X2RhdGEsDQo+ID4+Pj4+PiBUaGlz
IF4gaHViIGhhcyB0byBiZSB1cGRhdGVkIGluIDEvNyAsIG90aGVyd2lzZSBpZiBvbmx5IDEvNyBp
cw0KPiA+Pj4+Pj4gYXBwbGllZCAoZS5nLiBkdXJpbmcgYmlzZWN0KSwgdGhpcyBodWIgcmVzZXQg
d2lsbCBiZSBvcGVyYXRlZCBvdXQgb2YNCj4gc3BlY2lmaWNhdGlvbi4NCj4gPj4+Pj4+DQo+ID4+
Pj4+PiBBbHNvLCBsb29raW5nIGF0IHRoZSBVU0IyNTE0IGRhdGFzaGVldCBmaWd1cmUgNS0zLCBp
dCBzZWVtcyB0aGUNCj4gPj4+Pj4+IGh1YiBuZWVkcyB0ND01MDB1cyByZWNvdmVyeSB0aW1lIGlu
IFNNQnVzIG1vZGUuIERvZXMgdGhhdCBtZWFuDQo+ID4+Pj4+PiB1c2IyNTE0X2RhdGEgLnBvd2Vy
X29uX2RlbGF5X3VzID0gNTAwIGlzIG1pc3NpbmcgdG9vID8NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBB
bHNvLCBpdCBzZWVtcyB0X3JzdGlvIGlzIDV1cyBpbiBVU0I1NDc3IGRhdGFzaGVldCBmaWd1cmUg
MTAtNCAsDQo+ID4+Pj4+PiB3aGVyZSBkbyB0aGVzZSAxMDAwMHVzIGZpZ3VyZXMgYWJvdmUgY29t
ZSBmcm9tID8NCj4gPj4+Pj4NCj4gPj4+Pj4gV2Ugd2VyZSBzZWVpbmcgaTJjIGZhaWx1cmVzIHdo
ZW4gd2UgdXBkYXRlIHRoZSByZXNldCBkZWxheSBhbmQNCj4gPj4+Pj4gcG93ZXIgb24gZGVsYXkg
dmFsdWVzIG1lbnRpb25lZCBmcm9tIHRoZSBkYXRhc2hlZXQgc28gdXBkYXRlZCB0bw0KPiA+Pj4+
PiAxMDAwMHVzLCB0aGUgbGludXggcmVmZXJlbmNlIGlzIGJlbG93DQo+ID4+Pj4+IGh0dHBzOi8v
Z2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9jb21taXQvOTA4ZjYxYmVkYjJjNDBjNmQ4NTZiYmZk
Nw0KPiA+Pj4+PiBmOA0KPiA+Pj4+PiA3MA0KPiA+Pj4+PiBiOTY3YTRjYjQ5OA0KPiA+Pj4+IElz
IHRoZXJlIGEgbWF0Y2hpbmcgZGVsYXkgcmVxdWlyZW1lbnQgc3BlY2lmaWVkIGluIHRoZSBVU0Ig
aHViDQo+ID4+Pj4gZGF0YXNoZWV0IG9yIGlzIHRoaXMgYSB3b3JrYXJvdW5kIGZvciBzb21lIGJv
YXJkLXNwZWNpZmljIGJlaGF2aW9yID8NCj4gPj4+IFRoZSBtYXRjaGluZyBkZWxheSBpcyBub3Qg
c3BlY2lmaWVkIGluIHRoZSBVU0I1NzQ0IGh1YiBkb2N1bWVudCwgYnV0DQo+ID4+PiBiYXNlZCBv
bg0KPiA+PiB0ZXN0aW5nIG9uIDIgYm9hcmRzIHdpdGggdGhlIGFib3ZlLW1lbnRpb25lZCBkZWxh
eSBpMmMgZmFpbHVyZXMgd2VyZSBub3QNCj4gb2JzZXJ2ZWQuDQo+ID4+IElzIHRoaXMgMTBtcyBh
IGJvYXJkLXNwZWNpZmljIHJlc2V0IGRlbGF5ID8NCj4gPj4gV2h5IGlzIGl0IGluIGEgZ2VuZXJp
YyBkcml2ZXIgPw0KPiA+IE9uIG91ciBib2FyZHMgd2Ugb2JzZXJ2ZWQgaTJjIGZhaWx1cmVzIHdo
ZW4gd2Ugc2V0IHRoZSByZXNldCBkZWxheSBhcw0KPiA+IDV1cyBhbmQgcG93ZXIgb24gZGVsYXkg
YXMgMW1zIGFzIHBlciB0aGUgVVNCNTc0NCBkYXRhc2hlZXQuIFRoZSByZWFzb24NCj4gPiBvZiBh
ZGRpbmcgMTBtcyBkZWxheSBpcyBiZWNhdXNlIG9mIGkyYyBmYWlsdXJlcyBhbmQgdGhlIGxpbnV4
DQo+ID4gcmVmZXJlbmNlIGlzDQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4
L2NvbW1pdC85MDhmNjFiZWRiMmM0MGM2ZDg1NmJiZmQ3Zjg3MA0KPiA+IGI5NjdhNGNiNDk4IERv
IHlvdSBoYXZlIGFueXRoaW5nIHdpdGggcmVzcGVjdCB0byB0aGVzZSBkZWxheXMsIGFzIHlvdQ0K
PiA+IG1pZ2h0IGhhdmUgdGVzdGVkIG9uIHNvbWUgb3RoZXIgYm9hcmRzPyBJZiBhbnl0aGluZywg
cGxlYXNlIGxldCBtZSBrbm93Lg0KPiBJZiB0aGUgMTBtcyBkZWxheSBpcyBhIGJvYXJkIHNwZWNp
ZmljIGRlbGF5LCB0aGVuIHRoaXMgaGFzIHRvIGJlIGhhbmRsZWQgaW4gYSBib2FyZA0KPiBzcGVj
aWZpYyB3YXksIG5vdCBoYXJkLWNvZGVkIGluIHRoZSBkcml2ZXIuIFByb2JhYmx5IGFkZCBzb21l
IG5ldyBwcm9wZXJ0eSB3aGljaA0KPiBzcGVjaWZpZXMgdGhlIGV4dHJhIGJvYXJkIHNwZWNpZmlj
IHJlc2V0IGRlbGF5LCBidXQgYmUgc3VyZSB0byBydW4gdGhhdCBwcm9wZXJ0eSBieSB0aGUNCj4g
TGludXgga2VybmVsIG1haW50YWluZXJzIHRvby4NClRoYW5rcy4gSSB3aWxsIGNoZWNrIGhvdyB0
byBhZGQgdGhlIGJvYXJkIHNwZWNpZmljIGRlbGF5IGFzIG5ldyBwcm9wZXJ0eS4NCkFzIHRoaXMg
ZGVsYXkgbWlnaHQgYmUgc3BlY2lmaWMgdG8gdGhlIGJvYXJkcyB3aGljaCB3ZSB0ZXN0ZWQuDQpU
aGVyZSB3b24ndCBiZSBhbnkgaXNzdWUgaWYgd2UgY2FuIGFkZCB0aGUgZGVmYXVsdCAicmVzZXRf
ZGVsYXkiKDV1cykgYW5kICJwb3dlcl9vbl9kZWxheSIgKDFtcykgZnJvbSB0aGUgVVNCNTc0NCBk
YXRhc2hlZXQsIGFzIG90aGVyIGJvYXJkcyB3aWxsIGJlIHdvcmtpbmcgd2l0aG91dCBhbnkgYm9h
cmQgc3BlY2lmaWMgZGVsYXk/IA0KDQpUaGFua3MNClZlbmthdGVzaA0KDQoNCg==
