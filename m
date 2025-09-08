Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28E4CA1016
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 19:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E40F982B20;
	Mon,  8 Sep 2025 21:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="IeP6McEU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F83882C84; Mon,  8 Sep 2025 17:02:17 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5560809A5
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 17:02:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvTpNPA6uhfvSe6SewM5ozTnjrNCnm2tDDfK/ptXc1IPwCH5FSex3dV7nCNMMqDrRadQYGeDtxY2hczJegMKc3qFci1B7VTm/D9mdF/zbTzVKydgGBDLXnylfGtwT/tWyJ4BmpQShapAUrlH7JVv4QxkaeygeoSDySRo90jBNZGpv/WLDGECA1/k1OSsIMkHYFBSixo++HbkAVOvGM62KDD+NDy8xG/plHPhQT/sWu9apOBzWMbUZYF+11SVqeDmvRS33jzQlo6+0C5gUCUQByoN4torCR0JAe0tdHRijCmBN7mldQsSdHVeq3lkzaLhkCNb3zTcQr36GWSlwIATKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qy/heaO2Uea9iuUv4hKskoBb4jhQP6BG4V9SH7LVAKQ=;
 b=ZlviVGRvc+CDJcRO1VeSW4mH4kyVeZ3+vEgHEMvjBaG8UjiIRufhygL/2lyy8koRfOdlT0Plc04sRyGQ3L7NqhBU8f1/02N5h8/KtT7Nu7/HY6o2U3v40E0FAp+PftVmz1bTgHhxoiik/oNWxgztJGPF9eNadB5pDP5ItROPu0eEeJwxW0kGnw5D2jzgvAPJRVw6szSbXpqJoOa0Va3zLanyEcp0coM2bYikkasnmM7F9PPeMMLP7PpPDmcsrZeg+9HiXXa9ufyJywpqJgtVz0J9NldeuEpbYyi49K9ksK4gQw5CN9EjaCwHRnEyJRwu1fjSGiFFMnjhEieheS0t0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qy/heaO2Uea9iuUv4hKskoBb4jhQP6BG4V9SH7LVAKQ=;
 b=IeP6McEUoqHEK6JCpl5OP89dG3+ICsE8cj4yGl3zIAMN+EuH0610lMsrafID0FmtmnOSX4aI/lB619sG4p8zfuCLRYFMYTUUxUmf4Ad+61p5oEsag1AQryULq7CIZcXGKqx2d2K9lDnJBgvRLYbLCRBoxFN27gTFwTbOzVkdM8LtJd3CFzTGc40gWeKOBdc7OyslFLr+wBN+rbNBugpVgK/Llawaw7N+eOkCprNFw0S37VeJAqqcscejXMJiOVvhds+xuxD04f4Y/8rMp0lL1EqhxfKto9bU8N2BthZW+musBzaCoQ+9zDSfL6zjRcRLXivBC0RD99USxBheHWc9iQ==
Received: from DB9PR09MB5987.eurprd09.prod.outlook.com (2603:10a6:10:3dd::7)
 by PAVPR09MB6605.eurprd09.prod.outlook.com (2603:10a6:102:32b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 15:02:03 +0000
Received: from DB9PR09MB5987.eurprd09.prod.outlook.com
 ([fe80::1253:5735:5402:4ef2]) by DB9PR09MB5987.eurprd09.prod.outlook.com
 ([fe80::1253:5735:5402:4ef2%6]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 15:02:03 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 00/10] riscv: Add support for P8700 platform on Boston board
Thread-Topic: [PATCH v4 00/10] riscv: Add support for P8700 platform on Boston
 board
Thread-Index: AQHcINGJHAaEqNyXvEq9GnNZVf+ELw==
Date: Mon, 8 Sep 2025 15:02:03 +0000
Message-ID: <65c17d55-e3b9-4aeb-99ee-60cc0b7d47d9@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR09MB5987:EE_|PAVPR09MB6605:EE_
x-ms-office365-filtering-correlation-id: ee32b775-f1be-4b1e-56d4-08ddeee8abaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OU0rSU9jUXZDQWdtRW11SFdrbFdUQjNoNGI2dVZleXI3RVltdk1wQTBLU3dS?=
 =?utf-8?B?OGZKampDa1Z6ajVrSndhQ0l3aVdPanBxLzBBSlU1Y0hhQTkxMnVqcVBZMFFn?=
 =?utf-8?B?UzI2b3dIVHhnM0RvNEpqQnBycTcwbE8zS2hnbzBZeFQraWJnVzJXTzJBZ2N4?=
 =?utf-8?B?THJFeStaK0ltVnE1S0N4R1BvanJDZ3FjSmVnSXBsbnRMSy9FakZpUHR4SXlB?=
 =?utf-8?B?T1hQNkVVWEhGSHhvRC85MFFmTG1pb3NrejkzeExxQjNQQVdwbkdabmtrbjhw?=
 =?utf-8?B?SEFNcFRGa0taemlKWi9acE1KbTJtVE1YZTg4aEFEVm9UNnZhdUxIcW50Tk9r?=
 =?utf-8?B?VzVxei80dEhpVFRQWmVWQVZBUWJSMTdwenVCai9CMEE1SFA1UzRkNTlLMk92?=
 =?utf-8?B?VGM4ZnVKSDR4eG5LalNxSUtIeksxeVYrSFRVQS9rTnJ5UjdpL2FwVnROUUZX?=
 =?utf-8?B?Vlc3RlF0MFJnVlNEV090b3hEV3UrK2Mrc1NpSlBxMWZnY1dhdVJMcHRyUWIr?=
 =?utf-8?B?bVhWS1c3MWt2K3hZcWRXbGNZZDJOMTZiVHRBWkVlVnVtWFI4NEFGMm9aRERv?=
 =?utf-8?B?YUxzTkpJQzJGUzhTYkgzeU51enB4U2xJOGFIck84RHFGK2J4NUdKR1U4T2Q3?=
 =?utf-8?B?QUxtbEtNTTgwblJvSHU4TFJ6bXRVRkdpOGtraWpvczIyb252U1dsaVVJTngr?=
 =?utf-8?B?NWxGM2VZWjAzd1ZXUEl1SXNPbFJvVmpZeWRiQmZsZVRWRGpNNTJSRUJSMzdS?=
 =?utf-8?B?d1d2NHN0SU9SczNpckVlbEt3dE5jUG9MdG1SZDQ1OFArYkxZcFpVVGVMMjBy?=
 =?utf-8?B?UStoeG1zaE16OGRMMnAyb3VBUms1WGR2U0JxblJzejgreDdHbEVjMUVVcWJD?=
 =?utf-8?B?ekNCVjN4NmxEU0psU0pkdUtKZ3prWEdnaVFqalM2RTdXaFpmeWQ3akZOLzY5?=
 =?utf-8?B?Q0JOd09JWGVUd1FTc21ROHY2VGJsc29BQktZTnJXMGxvTGVzdDhNWXBna3Na?=
 =?utf-8?B?YWwvREZNK0RCbEJjd0VJV2pUMkhtL1RSL0hqKzNTVkpNemxmREE5ekhHbzFN?=
 =?utf-8?B?dVVjRGliajFEOHdobnRsTHBuOHUzbm0yOHordWtlUTBxRU1TdVVseHdiTVN2?=
 =?utf-8?B?RDlaSy9Wclc3NWdWNW5vYm9FbGR5cTBoYXI1R0dUTlF6S1V4SXdLbUdDTERh?=
 =?utf-8?B?clBlNW0xL3dWd3VCdDFRU3kvcTZQSElFWGo0K09IQjhtcGIySXUwSmdQaGx6?=
 =?utf-8?B?QmlvMjF4TVh1dFVPZVE2VTk2VWpTS2tsRWpUaSsvQWp6Qk94dnRkQTVJbUdl?=
 =?utf-8?B?U0ZCekNyRE05bTI0bFdWdzh3V1F1Sy9XSVR4aDFRaGZZRlJsa3NjeityQ1Bl?=
 =?utf-8?B?MFpFTHltcEVEdDFxKytReGJERmhqaDgyYzlkMnl3RDllSXlHbjBTMGpqRjJO?=
 =?utf-8?B?Z2RkQzI2eVgvNGtiN3FQY2RzOC9NM2NMTFVObzhTaGozcEkyK09ZcUlPU0gx?=
 =?utf-8?B?ZzFZUVFlaDJHWm9DMmJkQnNMZHpRTXRZbG9GWHNocHR1NTI5OHp4N0YvaFRY?=
 =?utf-8?B?NUd3cU9GY2R3ZVIrNWNlSHBLTXdJS2RFdEZmL3lHWmlmVXZaWEUyTkNROE45?=
 =?utf-8?B?ZDlwMHpGV1pEQzBtOS9uZkx1Q3loUGVnbWh6WUxBLzljdmUvcGwrL0tDM2FW?=
 =?utf-8?B?YUlVU1B6aE9ucmtxSXNXSDBTZzI3aVptajltQUI3aTdIbzJ1QzNPNDZZaklX?=
 =?utf-8?B?N21UdU9DbGhyRWk5eVloSExtOEFVQjVSUldEdTNVOFlKcDM1TCtuWTdPeDlw?=
 =?utf-8?B?dGRvVmFFTFZLbm4rN09BSGpYbXpXTlAwVXFidWRzTHR6NStFcDJDQ1NSTDBF?=
 =?utf-8?B?VnJDM2Zjdm1TNGgrMEUybFNFbll4TGszTGpRVkpRTEx6UzY5c3RqRThzNHNi?=
 =?utf-8?B?NDM2RGk2VUpWMEppcXRpQWpYK0kwZk1QVjlFU3FPRWhIbVg0cHpWQ0ZEcWs5?=
 =?utf-8?Q?iIpWVOmn5TebBHUNDp5vlAaLDVbxgI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR09MB5987.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1NjWGwxV2M0ZGJ5eGZncTV3SCtYU3hFUEluL1FSTUlzVWY5OVl2R0QxRFMz?=
 =?utf-8?B?YzU5aSsrMmFlcXVwbDJISk1VN2QvaVV0QitRZWlYUm1xdGFBSWM0RjJoTEZY?=
 =?utf-8?B?TFR1U29aNTI3aCtFODA0eDNYOHdzY3g0cFlPNVJNb20yZUpXNit3NU5Ddlpx?=
 =?utf-8?B?emw4RUk4VGN4MER1K2FWZjlIclpwNnJmS3NzdFhmR1ZtbzZOQWJEMm5PVkc5?=
 =?utf-8?B?ZFQ0VE1JVkcrb2NnZjVORHVFanNnWHhNK3NxU0lMTkYzVkRCY1BtOGozOHlv?=
 =?utf-8?B?bEM5ZU5sMzRzeEJHRjVBQmZDVHBxeVRGUjI3d1I4a2dteWhoNVBUSVZlb1A3?=
 =?utf-8?B?Mkt0NkFNSHRMcE5ZMFZtZ1BZWEVIcXNuUnFkTklCM2tDeDhlc0V5YnM3VkFI?=
 =?utf-8?B?R1pTRFQrNTkra0pTY3IwTWtzQWJET0orUEV4djh3eVB0NmQ3Nks0RXByeEFr?=
 =?utf-8?B?WXgwMGNsbTJWZmZ6SCtOdnA5aHFnS3poL3lMOUJMMXRBV3BGZFhpMGhDZHlB?=
 =?utf-8?B?c2h4cmtCRmFqZTJVbHZkS0NjNEI4c2VmNWdvbkRJZFNlWGc0c2ZlV08veWVD?=
 =?utf-8?B?VWtlc2FGNlUydXVEbHc1R3hLcmJ3SUw5MUxuNXZ0c1FZVE5zYVdibGNRMzMr?=
 =?utf-8?B?b2JsQlRYTzBiM3ZxUHBsQjNXeUpib09LVFo2cUxMc3JJd3BXM2RVZVVxeXQ4?=
 =?utf-8?B?WEpscVJGTkhqWEZFTnJ6dm1IQUlPME55M3J6Y1JDT3JlSndyR0ZOT2hFTWV3?=
 =?utf-8?B?VitwMEZmRWU0cHp3MzJiWFpsK1BRV2JWdjczcnNjUDNKYnNHenhzZ2Y5K1hl?=
 =?utf-8?B?QkJ5TUxnOElMeGVMTTdSc2dabWdpeGZKNkszZG9YdTVwQ2V4Z3BPTG1zekNy?=
 =?utf-8?B?ei9KNmQzc2Z1TGwrOVNOT1A0bERSRWs0UHh5elJjNlBrQjRHWC90NzdtMGE2?=
 =?utf-8?B?VkZ4Mm9Lb0hNZmRIRjBkK0pGWHpXRDFYTUh5cjJHWDFHekVsTWIwQW56cita?=
 =?utf-8?B?R05IWTM2VGdDWTdDR1NUMG5ieVlMNldNdFFpVHBtMG9IVm14Z1hBZ0xvaCtt?=
 =?utf-8?B?NEljS3NKck8rS1ozci9IQ1hNN2lueGpQYW1iRGRXK21XZk5yZ2hVQ1pHZTZT?=
 =?utf-8?B?Qld3QjZiWHJrd0NhUkNqQ0h5TmZ0eDBlbkx5OG52YldyZEd2UVVFSDZodHMv?=
 =?utf-8?B?cXhmcHhBU2FEYytPdm1lcG05TzVSaXRMV0RWU25ramVJMlgzZ3dqcVJUdElR?=
 =?utf-8?B?c2k3d2NEeTQ2cUs5QlZDZnRwbXBSWW5qVE9pRVE0MHFpNDJoazU1dDdaclcr?=
 =?utf-8?B?eGdCQ2hnRmd4aldRMzc0VkhobSt0TURNc2JzTXhyQW1pTGVaL2xDU1J5aGV4?=
 =?utf-8?B?NmxKZDBLWmtyVEFPR0xpUFM4bTRrb3lwV0FPanRzcVFuSEI2cmdFSjBnRFNJ?=
 =?utf-8?B?WWVlL1hmTUk3bEhRdmtXUFVFZ21MdkVucTkyNGxEVzNVTGMxT0hkSDNqdWpu?=
 =?utf-8?B?Y1BRNklLemdMM0xqOEdvZjlOeDkzRld0OC9EN080azJwb1JGTm9lQmlzN0U1?=
 =?utf-8?B?YlhlbnM5bzk3R2lVN2xjR1I4bVdvdWNUT1NlRVVVZFo1VE12bmRNZUdwdEtI?=
 =?utf-8?B?UzBHa2x6cWlFWWZzMHd0NGNIemJaWXY5VTgvbjJOUUpiSno2U3dKenlpZlhj?=
 =?utf-8?B?YUp5NElacFBJT2k1Zk9hRVF4cTBMa25SSWJhUnFoczU4Q2hSYW5pN3FvVGdx?=
 =?utf-8?B?TlVCRVhLSHlwcDVCTEpIdEdaN3ZTZ3ZLdFdGVjJ0dnBjMkJMb1BMM2dQQmlU?=
 =?utf-8?B?dDl3RkRLeEdJNTJRbTFyV01wVmpxRWx1RENsdDl5VEM4TzE3YVZZYzh3MGlK?=
 =?utf-8?B?QVFpUFBmS1dYMUFUblRlaFI3VWk0Wkh0a05ZSjJROURzcUt1Si9RdnJrOUxF?=
 =?utf-8?B?TWZ1M2JWeWxIb3VCNUwyOXkrVCtiZklxZmFOMzZLb2ZJMGFkUHNXTnlNVTVi?=
 =?utf-8?B?cEFiSHRFUnBVaUpDK095WVhhM3pVM1JzcXAwMm9MWWxKd0oyRnhTclJJYWgy?=
 =?utf-8?B?YTFiSXg1cmFXa2JzNlU1eElvUkdRZ1Z1UUhpalU0NVRTbGZEYm1GOFVtSWNH?=
 =?utf-8?B?TXJybUlBZ1ZjWnkwSEdVSUFNcUxBTVd6aVgxTkpTblBsUkQ3RjRZTUxtOHNZ?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EB6D34BAB1840449A2847FD626E468E@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB5987.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee32b775-f1be-4b1e-56d4-08ddeee8abaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 15:02:03.6095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dymefLu1sC1sWBUegUgkw8ZVu3bUuuA03Ora61Txaj65rIqRacq8P4qq6brcSl7jJ63j8dG7pm7oj/mAH1UA04ysZ0vWTgb8B38EbzzLSNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR09MB6605
X-Mailman-Approved-At: Mon, 08 Sep 2025 21:42:16 +0200
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

SGVsbG8sDQpwaW5nIGZvciB0aGUgZm9sbG93aW5nIHNlcmllczoNCg0KaHR0cHM6Ly9wYXRjaHdv
cmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L2xpc3QvP3Nlcmllcz00Njk4NzENCg0KSeKAmWQg
YmUgZ3JhdGVmdWwgZm9yIGFueSBmZWVkYmFjayB3aGVuIGNvbnZlbmllbnQuDQpUaGFua3MgaW4g
YWR2YW5jZSBmb3IgeW91ciB0aW1lIQ0KDQpCZXN0IHJlZ2FyZHMsDQpVcm9z
