Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866A0E77180
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 08:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C056F8914C;
	Tue, 10 Dec 2024 09:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sqfilb3I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D18989169; Tue, 10 Dec 2024 09:33:03 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A288890DF
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 09:33:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZp4iojY2TUpYwy0ceUOqH1NrfnBMtg3g1YR/u3sxl3Vrw5863P3PKCLvvEPyy9mmfsK2SYlwQfuZhzvwd1VcBtvG32mkaMmkbjsQh3DeDD2L2lHL5H+Imo2fcUCB66kG6alQe02K8SkJlQgURdrtLjQ/TvCBhbxXkPjOzbieP4Gmo5n+DED1/z4+JVRNqxDhecs9uq0o3OQOlcID3DjDGnr76dW/cGIeVy5S7etYKu4Z7unoKJ6uJA87z22yEXe2w/ccq6hIPDjHuXda+V5FIOodVYHr9zoVCZTvFzFltxkneYMihc6Mt6O9AWI5tPgeNWvfRxLkJUSjPXdXg6k9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kvn/Q3R7R6TT5vkpbSHxQrdbhgsUxKYywWBUukVdRqI=;
 b=HQPpCqNSOc5XvxhixGNaVqE2h4eI/u5uee5s5h8V1tPPXXdg4evJ3zj9Q4TKSJYIht5y6WWYfGlnXUllYRJBYIoyR6HLzpncYsAqnfk/knPL1HtIjc//qogLCH7zmA3f80Vw9HzjP5YEKXLePYmbpycgJZbwW3rResTdn6C1DOpFKWCcO6c6DbXiinrvYWZSlL1Xx0JzPIFUFlDOliOLcXJoD9zKP6OXYwYegXjspII8hfgxV78BsK3KxaUAQxlW8ytjuuYmWUaZdOPbTm5CT1HSXwvzQaM9zOgEXc/nutqgdTe+EIts4XCNcKR537ppofdnaC3+ZScO+XtUsmAWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kvn/Q3R7R6TT5vkpbSHxQrdbhgsUxKYywWBUukVdRqI=;
 b=sqfilb3IHGwJu0aWqVeequWJhsfuSoRFyiaGu5HgpIzKb4I/ImeU96jSkGke0PQlHOkk75HqLvJCn88WhSqml1qZGKrquFOFMXOd+6VXwWcfwKxoxQdI/cqzJbUQ+f7N2ruMdT5r1cc6DLSpfJRZzDncJEpeuzxDE/vjbhcQ7IM=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 08:32:56 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 08:32:56 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>
CC: Jon Humphreys <j-humphreys@ti.com>, "Simek, Michal"
 <michal.simek@amd.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Andre
 Przywara <andre.przywara@arm.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Jagan Teki <jagan@amarulasolutions.com>, Michael
 Walle <mwalle@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Pratyush Yadav
 <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>, "uboot-stm32@st-md-mailman.stormreply.com"
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: RE: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel memories support
 in QSPI driver"
Thread-Topic: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel memories
 support in QSPI driver"
Thread-Index: AQHbJMZY/tA7en8DbUuS+Zl7COVM+rKT/mQAgAAGBACAFrNQAIAAGcaAgAAS3QCAAC8HgIAA/EEAgAAESoCABiukAIAlD9cAgAAC7HCAAZQxgIAAVmOggAB0ZICABWkNUIAAVKKAgAADb1A=
Date: Tue, 10 Dec 2024 08:32:56 +0000
Message-ID: <SA1PR12MB8697C12328D5809FC74528F5983D2@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <edcec18f-75a0-44d8-907a-f042779ca6ee@mailbox.org>
 <86ses458k3.fsf@udb0321960.dhcp.ti.com>
 <f7bb335d-681a-4b60-92f6-b605cc6f477f@mailbox.org>
 <86pln759j9.fsf@udb0321960.dhcp.ti.com>
 <33e99705-77e3-4acf-95f7-fad65f60ae62@mailbox.org>
 <86ldxp6ehf.fsf@udb0321960.dhcp.ti.com>
 <865xny69y1.fsf@udb0321960.dhcp.ti.com>
 <SA1PR12MB86974AC7EFCCBD7AE99FDD3E98302@SA1PR12MB8697.namprd12.prod.outlook.com>
 <8634j15t1y.fsf@udb0321960.dhcp.ti.com>
 <SA1PR12MB869743652A0B3EC3335A9F9F98312@SA1PR12MB8697.namprd12.prod.outlook.com>
 <20241206163931.GS2457179@bill-the-cat>
 <SA1PR12MB86977B7233CE821D113F369C983D2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <ba1bc243-bd1b-4580-ba1b-4f96058f661a@mailbox.org>
In-Reply-To: <ba1bc243-bd1b-4580-ba1b-4f96058f661a@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|CH3PR12MB7763:EE_
x-ms-office365-filtering-correlation-id: 27a9ee1f-5b7e-47fb-cfb1-08dd18f53f3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WWhUakxIamNCYW5QTFNFZXhvczRvU0VaRkJQWG1nQ05BUGNyOG5lWTd4VGFw?=
 =?utf-8?B?Q3lwSmNyc3hyM0dEajgzQWVNbTI4Zm5jaGlEQ1JmYzkyZGtrRGRDQ1U0NlU4?=
 =?utf-8?B?cGJ3NVNYVHJUMHgxLzcxcFlSMHN5cE9mT3VRNjNRTjJvWjFMUm5JdVM3dk5H?=
 =?utf-8?B?SkNkY1BPOEhOSDFTWXVQU1lnSVRzZThSZ3lmUW4yOFlWMzMxWFp0ZEJVQ3hH?=
 =?utf-8?B?TngyQWJGNmJuZ0twQVBIVGlnRXVzSnRTdjFGaklVT3pQQlJOTk9ObU1CRTBR?=
 =?utf-8?B?ZWZtT08xUXBpamVyK0laZUJwMVFrQnJJLzJlbEc5c2hETlV4WndXUkRLZkZl?=
 =?utf-8?B?VTlVdTBDZmpWbFQzK3Rkb09vL1lkVE82aG5oM01KdDhCeXhpSjhBbm56L3RD?=
 =?utf-8?B?cjdHZ3dvbC81bWlHajVISmdlTjFhWmVNWlhyRmZ1disrRlJXTzZqZFArcVhJ?=
 =?utf-8?B?NXhUUFlCVkl5N3M4aTczNmp5VHRYL1FUY2FhK1dYTlA4OXhLemNRZ1VNQWo3?=
 =?utf-8?B?ZzBJYVRSMFNtZlgyZVB1THAyaU91UlZoTi9ZNXlITllhMGRvQnVQWVNERkJW?=
 =?utf-8?B?MmlMU1hQSFpsRU4zZ1B2QjUxb09LcDBGTUJEL2NPL20yMGVrQUdQVzFmV29F?=
 =?utf-8?B?TzlXbkdGSlNwNDB4YnBxVmNLc1lRREh1RCsvb1d3OVpOTHdMTXNvcFRwVkl0?=
 =?utf-8?B?Ti80YWlUbkZKRm9WYTdhOS9KMk5FM3lTR2xNRmwwUXRzWlNtRUJJUG9CZi8x?=
 =?utf-8?B?NjNOa21sYy9MNlVxTWJ4YkVUMHR2RUF0SElQcHo5Z0dSTk5RUm9vaEhHaWFM?=
 =?utf-8?B?MldPK09aZGp4bFhrYWhFNXB0RU9OWms4Zy85ZXB2dTRKQ3NibUQzamZwWUV5?=
 =?utf-8?B?MFd1Tm5abm0xTC9FZ3Q1WEFBQ3lveFhxYmpsRFRtY0NPRmVTRUIyL3Ribng3?=
 =?utf-8?B?cjhCWi9mSGpRbE9icDY5WnJDMzNpTTJLakhaSzBMRUFFcEsvQnBwcFQ5RFZ6?=
 =?utf-8?B?ZllpQUt2ZHRESjhWN3d5bVIybytpZ1dsZ1pKSldXdWI2dWpkcnUyT0hVTVlm?=
 =?utf-8?B?cEJ4M1JlUS9yY1ZsR1ZJUjlzOFY5TXgyTnpsTlZLWUJCYjlLU3NzWm95Q3d4?=
 =?utf-8?B?Vkh2TWJCeCt6ZnJkcFM5TUlqWlVUYnQvcm5VRFhHdnROUFUvbDg5UlQvWnJ2?=
 =?utf-8?B?S2hrY3NoNEMyR0NKV1FXcVN0Zzc1MGRTeU9CNW5NVzhONlp4TU9XMnIyZjRN?=
 =?utf-8?B?OU14NnNKaStnMVdBMVV1emcweWpZMnNQZmdzc1U1N0Y5NER5NTE2OVltZEFw?=
 =?utf-8?B?QnIyR05waEt5YmJyYmNlWFFSZnJrSWVhWkkzaDlmMXJaOWRLSVV5T0haa3Ri?=
 =?utf-8?B?TE1iUEozelhZQzJoWWVvV3Y4Q00rVmlJdDFRYUtRcytQcEpocWtCMzdxY2x2?=
 =?utf-8?B?cDdRT3RqeVQ2UVhNalViaFZyNGk5K2tUYkNpS20vakQyWjh2S0Q0blltKy9O?=
 =?utf-8?B?bUNHemFUZ0drNlhxSExXOFFjV1Ard1NZZXVXWFF1MkpqVFRDU1dJMEVkQnha?=
 =?utf-8?B?MGdMVERoVjlvM3pKektPQzI5NHFtTWc0N2hCS1pwTmJ2WGIxREp1MGhEZURH?=
 =?utf-8?B?dmhqdS9LWG9uN3FrUVNrdmhFRWxscFFHRy9tRS9Ld0pCK2JkWURLMGpQTG0v?=
 =?utf-8?B?SEpWeG9xYWNXcUhUV0pyOWFEdnMrM1QwNm84ZGpZcEo3OGxWd1I5VFgrSWgx?=
 =?utf-8?B?TXhsMDlKcWxtL0tIZmFpU2dqUXY3alJieVBDTzdtRnhKQUhtKzRTMDB2ZXU2?=
 =?utf-8?B?T3FCcVhhdzlJMzlzYW1qQS82UGlmK3lJa0FvdVEwbXVNbk82QW03aEc1Tjcx?=
 =?utf-8?B?VG80L1RZS2hRK0o3Q2wvZ2plRXhKVE9meVhRK1k4M1UxN3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGRoNTdpeEJDVVlidWZScGRPTms5YTVwZEc0WHpzaUM0UjRIbGRSZUQ3cUty?=
 =?utf-8?B?aHF5ZDZXYnZidFg1V29aOE5oZ2NPUkZJanArcEZld242aEFsRVRvSXdpRUtt?=
 =?utf-8?B?dmNMNUg2SWlIUFFrWmF5V2Z2czByZ1dvVnBjc1gxbEo3K1dNcWlPUEM0aFRM?=
 =?utf-8?B?c0U2Q0k4dW5ZcUlPcGxFRnRnc2xlVEdIajIzTktaQWp3emkzZEhuNXdFZkdW?=
 =?utf-8?B?MjlUNjBYS3pwL1dySitaSlVMY2VTbHZnMHJQaVcvZ3MrK0FBUHFnbGZ2Tm9t?=
 =?utf-8?B?YTNhbjdSZFlUYmVmc3A5bXRMN05NTE1icWpIdHJBTnJXYmpoZXpMd0Y4ak95?=
 =?utf-8?B?VmI3Rm0zeXBDUkIvSUJBWFdDR05rUkFvbm4rdVRwWXoveFRQbFp1L1hWb2hj?=
 =?utf-8?B?YTVWbXlqZHN2aUNsVW41ZjlnbkxLZGlocXdOVFlFcGRobnJ1WFpWMEV2Q2JF?=
 =?utf-8?B?M25FREFTM0ZqVnRObXVQa3lHZlU0NEVZS3B3WGU1ZXRvZlNUVU9PUDBiQ2dt?=
 =?utf-8?B?ZTlzQno4MXRVb2krNlFid1pxODZUckRkamo2dld0VEtGci9wZDFSYk9lY1Jj?=
 =?utf-8?B?SlFlZEFpakRVSlVlMng3VGZyK3QzRDZtZFRZWHdUVnk3YmpFdm1sb2xEd3h5?=
 =?utf-8?B?NWc0b2RUTnprcFN3Z0pKSk9zekh0WG00bVExNVlXZ0xPbVlUbFJwbi81OEFa?=
 =?utf-8?B?Z1RqZXBhU3FTOVZhd2QxejJFT1p1REc2eW9CeWQ4SEd5SDRUbXpZNndaM1Bh?=
 =?utf-8?B?U21BSVVBdjNzemJrRk5TblErUEk3dWlaaTdpei8yOVdQcXZBcU9uR29qbEhs?=
 =?utf-8?B?cDVmN1d1a0NxRHNLOGRvbGZTdXVINWh1bm1TbzgvcFhUTlh2NU5XNTdwM0My?=
 =?utf-8?B?azdlNjROWGlnN1ZFODY3S2ljVjF1d05MRkE0U0VCTkg4RDdPdCt6VzdDYkFJ?=
 =?utf-8?B?VFZ6dDAvTDNmREEwMTlwbTNSZnAwTFp3NjJBeHhBT3FidzRoeGhKK1ZsQXB1?=
 =?utf-8?B?UU1zUUF1bTFjY1dXaFNzdmJZbXowc3lBRVE3bFZsbHBRRXVyWWk1TjlqK09S?=
 =?utf-8?B?U2lOU1djUUNnb0JHcVJ0ZjEzT2xnSWNyY2lhSEdXc3NpZ1hhYS9yRWd1bEVa?=
 =?utf-8?B?UnJLWVVhM3FwR3Q1VXV1VkVZZ2tlQ3piMnBEaERWY1RYNnhpMkZralZMb1pa?=
 =?utf-8?B?N1JTYi9jeXZmSml6VEM4TWxDWGdQcWh4dTdKMzdBTklrb2c5Tnd1RFdNalZS?=
 =?utf-8?B?aUgwY1RQT3o0QW45bFpQeTVOVG9Jdk4yRVVMdGZacWV5UFNCWTlHWDBoRStw?=
 =?utf-8?B?WHk2SjJsNXBSMVdnY1dTbVZUZGliUXpUaldiQW93Q2lqeTRtSkcveUNNRVN6?=
 =?utf-8?B?c3RJeWxneXRMS1hrUDBZNjh3R1lsOVZ3c1JhS0F6Z1lGeHZnOEE0aW5mc2dw?=
 =?utf-8?B?Y1pVUlJncmVTcWdIZ3BoM3lBaS9MZU80YkVuTkpMSDV4Q3VPWDJSNXRxWlow?=
 =?utf-8?B?U1R6QTlWd3h5cDdsa0FQWjlGL2tCMkQzT3hFamlWVEpwNWl5Ukc0VDNoL2pi?=
 =?utf-8?B?ampXZGsrSmtkQUFvQWdjb1pLRG9nUEh4elZ2VVlzZ0t0eWtZVFZPcVE5YmRr?=
 =?utf-8?B?dDl1T2VtQWY0K0NMdzk5Z3lucnRyeE9pWEFxbkdhT0phZ1Q2SHRhdjJTR0pI?=
 =?utf-8?B?UDhtM044bTBPSHM5bkdqZ0xZNVhpTU1NbXR4bGEvZzhjdFFYUmhCR0lNbTA4?=
 =?utf-8?B?ZWNxSVVKT1pBN21VWTNxQzdaUVZZbC9UQkFBTktDYTlHTnF5dzR5aTllNmor?=
 =?utf-8?B?OU5kQVJLL256UDRHRlNrWTZKMS9NUlhsdzJwNEZPeHVHeTZpMFNEZHlwOEEv?=
 =?utf-8?B?SSsrbUUySzI4elk5bmZEWGtaMHQyU1FXZ0xxbHdNMEhZZXNlMUwva1VHVHZ1?=
 =?utf-8?B?NTZ3anpGSnpyNUNYU1BIYzYxSWZ0NUpPZ2RzZWY0RGVSdnVWL3VYc3RaL09n?=
 =?utf-8?B?NVprRk5LbFQ2SGIrdjRhV2tpY3lBUnRGVGJnWFp6L2E4Mi85VTBQUEhieW1x?=
 =?utf-8?B?Y3lkbDdla1o3MjJqTDJQTDFWMzNtS0Jnajl5ck53Mmg4eWppMFdxYUk4VFRY?=
 =?utf-8?Q?J6ao=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a9ee1f-5b7e-47fb-cfb1-08dd18f53f3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 08:32:56.3471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DuPE7GgnSCevTtjdyBkpDkoUikoN7nmI3Nvc2OhEGUmhF/0YL8MlhJ1+osAFgJUO4GWwfiiAf56DPh+9erhNAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQgPG1h
cmVrLnZhc3V0QG1haWxib3gub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxMCwgMjAy
NCAxOjUwIFBNDQo+IFRvOiBBYmJhcmFwdSwgVmVua2F0ZXNoIDx2ZW5rYXRlc2guYWJiYXJhcHVA
YW1kLmNvbT47IFRvbSBSaW5pDQo+IDx0cmluaUBrb25zdWxrby5jb20+OyBUdWRvciBBbWJhcnVz
IDx0dWRvci5hbWJhcnVzQGxpbmFyby5vcmc+DQo+IENjOiBKb24gSHVtcGhyZXlzIDxqLWh1bXBo
cmV5c0B0aS5jb20+OyBTaW1laywgTWljaGFsDQo+IDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IHUt
Ym9vdEBsaXN0cy5kZW54LmRlOyBBbmRyZSBQcnp5d2FyYQ0KPiA8YW5kcmUucHJ6eXdhcmFAYXJt
LmNvbT47IEFzaG9rIFJlZGR5IFNvbWEgPGFzaG9rLnJlZGR5LnNvbWFAYW1kLmNvbT47DQo+IEph
Z2FuIFRla2kgPGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tPjsgTWljaGFlbCBXYWxsZSA8bXdh
bGxlQGtlcm5lbC5vcmc+Ow0KPiBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBmb3Nz
LnN0LmNvbT47IFBhdHJpY2sgRGVsYXVuYXkNCj4gPHBhdHJpY2suZGVsYXVuYXlAZm9zcy5zdC5j
b20+OyBQcmF0eXVzaCBZYWRhdiA8cC55YWRhdkB0aS5jb20+OyBRdWVudGluDQo+IFNjaHVseiA8
cXVlbnRpbi5zY2h1bHpAY2hlcnJ5LmRlPjsgU2VhbiBBbmRlcnNvbiA8c2VhbmdhMkBnbWFpbC5j
b20+Ow0KPiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz47IFRha2FoaXJvIEt1d2Fubw0K
PiA8VGFrYWhpcm8uS3V3YW5vQGluZmluZW9uLmNvbT47IHVib290LXN0bTMyQHN0LW1kLW1haWxt
YW4uc3Rvcm1yZXBseS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzZdIFJldmVydCAic3Bp
OiB6eW5xX3FzcGk6IEFkZCBwYXJhbGxlbCBtZW1vcmllcyBzdXBwb3J0IGluDQo+IFFTUEkgZHJp
dmVyIg0KPiANCj4gT24gMTIvMTAvMjQgNDoyMCBBTSwgQWJiYXJhcHUsIFZlbmthdGVzaCB3cm90
ZToNCj4gDQo+ID4+PiBIaSBIdW1waHJleXMsDQo+ID4+PiBUaGFuayB5b3UgZm9yIGNvbmZpcm1p
bmcgdGhhdCB0aGUgcGF0Y2ggd29ya2VkIGFuZCByZXNvbHZlZCB0aGUgaXNzdWUuDQo+ID4+DQo+
ID4+IE9LLCBidXQgZ29pbmcgYmFjayB0byB0aGUgcGF0Y2ggaW4gcXVlc3Rpb24sIFR1ZG9yIGhh
cyByZXF1ZXN0ZWQNCj4gPj4gY2hhbmdlcy4gV2hlbiBjYW4gd2UgZXhwZWN0IGEgdjIgdGhhdCBh
ZGRyZXNzZXMgdGhvc2UsIHNvIHRoYXQgSm9uDQo+ID4+IGFuZCBNYXJlayBjYW4gYWxzbyBjb25m
aXJtIHRoZWlyIHBsYXRmb3JtcyB3b3JrPyBUaGFua3MuDQo+ID4NCj4gPiBUdWRvciwgRG8geW91
IHdhbnQgbWUgdG8gaW1wbGVtZW50IHNlcGFyYXRlDQo+IHNwaV9ub3JfZXJhc2UoKS9zcGlfbm9y
X3JlYWQoKS9zcGlfbm9yX3dyaXRlKCkgZm9yIHRoZSBwYXJhbGxlbC9zdGFja2VkDQo+IGNvbmZp
Z3VyYXRpb25zPw0KPiA+IE1hcmVrLCBhbnkgc3VnZ2VzdGlvbnMgcmVnYXJkaW5nIHRoaXMgaW1w
bGVtZW50YXRpb24/DQo+IA0KPiBXaGF0IGRvIHlvdSByZWZlciB0byA/IElzIHRoZXJlIGEgZGlz
Y3Vzc2lvbiBJIG1pc3NlZCA/DQoNClRoaXMgaXMgcmVnYXJkaW5nIHRoZSBjb21tZW50cyBtZW50
aW9uZWQgYnkgVHVkb3Igb24gdGhpcyBwYXRjaCANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Ut
Ym9vdC8yNzczZDE1Ny0yYjc1LTRmZTUtYmYxNi05ZTY5MjdlMGY2ZjRAbGluYXJvLm9yZy8NCg0K
VGhhbmtzDQpWZW5rYXRlc2gNCj4gDQo+IC0tDQo+IEJlc3QgcmVnYXJkcywNCj4gTWFyZWsgVmFz
dXQNCg==
