Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40ECCF34A9
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 14:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32E2288CC3;
	Thu,  3 Oct 2024 16:55:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nJpVGDEh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E4988DFA; Thu,  3 Oct 2024 16:55:06 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A993788CC3
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 16:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbANdD2x4TZ4FQwcjhPqJ+PHWRiP7lmBSlTQ+PdQGSu5/IKPQVLvOfEkl09cjQSelk/Q/9NBQfR54oT8QYcI+WFYMJeTBHFdWucJMfj5SDQeuOniNMWQ0x5yBdAnrl1Yr7TxER5oUlvLXm249Tey3ckoXORIQxmWpWZPfhjDcOqtwarNyONUHnl6X8bn/VJdzxR68OHOfPShHRkJRflSpmszgCs62Gc7nAqXsi2HsLSAufyv2fJ8vg54+E0Vk1TXtEuUr7b6USJP3IzgrZaVJAKHlAgCxCl63myfqtR+0sGyJAUbYHjioIkMx1RB673/paMASd6rwRog6XjiK/Grcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRTX4sBuosv4VjuBB+Z50UaATfLljYRboT3EyuXYZmM=;
 b=xbz8b2PxUl3OZzid8mPpQZrZxM0z7Nd1JMIuqGIvhs5zznqUmdbSAxOnVUlodLuzCIHMfZSQLv0KkN5xwdFs0HI8kint8VJe+Kx4kAC0P6KErRxcLKLCDdl22yi6gEs9eEmgO2pCUQcIhZuUQtEIWlKzn9bv66m8vcXA94fkQfQIBTv8a3KnD72GkNVTun7RBumdPeUc1EwLFOaq8hiWblws5Llln9ULuJriqYdaLBa6T1AdVE+O7I6f6FE7SjFmkQLkXj1sOP0JYKw+y4DO3Rjs9Kv6qS7CbKZMFH/r+4mDwA2QS7hU5HBVJw5B2WmRAMsfYtDq75PGi6eboGy5Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRTX4sBuosv4VjuBB+Z50UaATfLljYRboT3EyuXYZmM=;
 b=nJpVGDEhf/QN5sB4lTrJoEjNpmhmeMdQXZ8l1Hea9brckMQpaIX8/AT3zfU5GwbtTQfYyQJMpBv9ooGownE7TkR23dO7/I60tZkbj2AraN+PVTIeBWSLh6kLRVqQ4QN/tDka5Z3AMqreRuBdmXPQmSCOWjRz9WR+07guzzg3iVE=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.16; Thu, 3 Oct 2024 14:54:57 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%6]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 14:54:57 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v3 1/7] usb: onboard-hub: Add reset-gpio support
Thread-Topic: [PATCH v3 1/7] usb: onboard-hub: Add reset-gpio support
Thread-Index: AQHbE8Cw1wwSjzBcqEOkNkd+RtrWkrJxyouAgAKoQHCAAH+OAIAALk6w
Date: Thu, 3 Oct 2024 14:54:57 +0000
Message-ID: <SA1PR12MB8697682FEEE48B015EE82E0398712@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
 <20241001050529.17922-2-venkatesh.abbarapu@amd.com>
 <6056a273-2699-4e94-93e8-ddc96084bbba@denx.de>
 <SA1PR12MB8697873F2C2EF86E6E9DAF9B98712@SA1PR12MB8697.namprd12.prod.outlook.com>
 <2e0928c8-e03a-44ae-aa36-3d664ed5bc6a@denx.de>
In-Reply-To: <2e0928c8-e03a-44ae-aa36-3d664ed5bc6a@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|DS7PR12MB6023:EE_
x-ms-office365-filtering-correlation-id: 29764cd7-fc3c-4330-fd9c-08dce3bb5915
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U05xc1RQaWtlbHpjWlpiaHpDeVdNNFE1QncyVm9IZ0pyRFBiSGJvanFVR014?=
 =?utf-8?B?OG85VlVOWlVocXNHSEUreVIwSVdDam1mbUFtcE9IQUNnOWV6NG4zcE5iTUFV?=
 =?utf-8?B?V2ZMS0E4aXBNYjVWNGZTY0d4akszMGQ1T1g4eXNVVTFzcU9ibEJyQ2U4Y1pH?=
 =?utf-8?B?MDk4T25kREN0b281SS9Qdmd5cG01aHJtS2NYVnJZYUw4elIzQlg5TVBuU3R2?=
 =?utf-8?B?NzhjeU9BOTJFdUlLUWVPRUJHK0FjUDUyeGhCd1hHalIzTGNXeTFzSGZaR0hP?=
 =?utf-8?B?Wm1CQ2xTT2VuNHlTdFBMSTNmT3pwWlZqQnBUT2hYOEg2V3BpdHdzN3ZaSnJM?=
 =?utf-8?B?Y2xTR0tUUFd2SVdnd0lxankxVTc4czB1WWxUS3hVLzJFbmQ4bWxPcWswcmlr?=
 =?utf-8?B?NUZLOWVpOVhhejk2RXYrcnlqRERNbkVDZk5xOTdOWjN0R3gxMVBYak9FM3dU?=
 =?utf-8?B?RXUweCtzT3YzdkNqdXN3ZCszYVZQM1RwSlc0bjQzRk1ZQSsrUXlmUWhCZTVY?=
 =?utf-8?B?RHVsQm8zQjNyRElzL2NSak1xZEFRS1ljQjl0eWRidFo5aEUyNHZySHVLNDZL?=
 =?utf-8?B?WW91WUp1TUdqdVdJcHE1RFlCa0tZSENIcmswUDFHMElGd2VHSUtGTzNnTkJK?=
 =?utf-8?B?NWVzVU1hZHE2NFVEWnQ2eWQwcUM2czRkaVJOblZjbkZjZ1kzWm9SanRIM0s0?=
 =?utf-8?B?TE15ejN2YjE3aXAraU9WWnAraXo5ZmhBbndvcTVxaGE1TG0yTUJnM2JKQXgw?=
 =?utf-8?B?Wk1EcnlmQW9VdU1CdFJVcXRQVDdqQVBJR0ZpS2x2N1k4TFNKem1zVFhKL2Fh?=
 =?utf-8?B?cU5NT0JrMVp4SG0zQ0hKZmdpWHhRaThla2Foc2tiTXE4UUxzZDRoQTVpVTYz?=
 =?utf-8?B?SnNoYUJ3WVdJSk9ES2NBUXUyZTBUMmhNczRpT1pUNDlvYzVEbUF3bm80eWhN?=
 =?utf-8?B?TkFkUHhoZnFtZkxEcTIyN01OVVIxQWQ5NUtZN0FyZW9SV3VYSmV4bVluZDFk?=
 =?utf-8?B?bkJxejhDb0RodTYyakdYUGljQk43eGlPcG1zejhNSVM3RTJURUkxOTliVnlD?=
 =?utf-8?B?Znp2VWk1ZloxdzBXRWRTZzRrd2xLS0lEeWo5a0JjODE2N2lqbUVxWU5NZ0dC?=
 =?utf-8?B?ZGNkdEJOMWxzR3AwYWlGT1c1Nks4UXNScUhBM0I5dWZpOWo5Skp5MEJZU1Jr?=
 =?utf-8?B?Tk9LUGlVUmxQdXdoMmpSNjk2czBza0o4dTRiM2wyTkVDeGEzTzBKekF0VFF5?=
 =?utf-8?B?ZTc3azRhZkpNemVadGZGMXVoRFRWU3VGcHYwb0l6N1g2bFgzbnQvOGJFWUs4?=
 =?utf-8?B?dmZtcnJHL3JJR21HbUtKNlNscVlnNkQ4K1VJR1A2L2NWNGNBQ3RNNEErazNy?=
 =?utf-8?B?N1R2WFdVdkg3eCtONnFDTTJQeTV1TGw2aVpqZDd3emhRQm5pZnZzb21GVWtz?=
 =?utf-8?B?dDRZbEY2UWVJa3htdXR5Qzh6UzVIMXZpU0lTMjVyUDM3ZkpFRlFseWtHR2Nu?=
 =?utf-8?B?Myt2Nmp1Vmt6L29pMU54MUVpRStTL0dRMGZPTUtrK01BdW96MDZBMWp1MlpY?=
 =?utf-8?B?RXdkQktiemYxWXRqUUtFRWlTZThjaTNQWkdtWEZqWGRSMUxJMEhZTHRRRUJC?=
 =?utf-8?B?S09CcS85RFdxbERiM1JmRHV0T0hwc0hKYTFWUkNESEQ2eGNWa3NCYTdmekpP?=
 =?utf-8?B?YjVuQWFKOCtIS2V4cmx3TTFyM0pnbWtzWm5ab1pvNkUwOGtMdG9wWkhMQktY?=
 =?utf-8?B?QlIva2hnbHhXNFdFVTkrVk5maEZwTkNvTW96UzJPaU4wL0tDalNQQWQxdVVz?=
 =?utf-8?B?THowVUFQNlFYZGRhbnNlUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEVtbkk2dlZiZ0dmL0xMZTJOelZiQmxOa3JsMkFYOXZZc0gwNEorWEVoaUVu?=
 =?utf-8?B?NGpDN0lTaSsxTDZYNHRrODUyMmVlQzdCWitRRityZ0JEMzBuaURkRGlSalNh?=
 =?utf-8?B?SHZ6enNlMkFqSEQ3OVNwdW9FUFJvRFNYOTRYOGhrTVZsMlpSNlpuZHBuOWIx?=
 =?utf-8?B?N2o2SGVuSDhXL0pRSG9WSi9HZlphRUZLTjQ0YXlrc2hhUzE0N0l2UzB3WG1F?=
 =?utf-8?B?L0J5ZFVjaTVkTXZaM3RTUXExODlSdmFTZ0V2WkY4SFpQbXA2TFI0RlIzSEVk?=
 =?utf-8?B?eWgzWG9nWjBxVzYxOUljYmIzTDBiL05KeVp2bGlkRmdlTFBoVmFSZmh2WC96?=
 =?utf-8?B?QzV0dmoraG5xc29uUVlrRFUxdllrTWt5WG9KMlh6NnpRcmFRU2x2WFQyQitu?=
 =?utf-8?B?WkI4cTRJRmtaVkwvakl0TE9MeG13S3JtNmhCZnQxa29pcTZ2bG1qcVAzSk00?=
 =?utf-8?B?QkNuRExMa2NGZ0VjZmIxa1hJRzBneW9nQlViT2MydnozaVNzZFhtNXBRNFJx?=
 =?utf-8?B?b3BmREgzek96VUl2Q1RuK293M1laM3JsUGdLWTRRWUMwcEJPVHY5b3R6K1c5?=
 =?utf-8?B?Y3hwaEtyTkJYKzVXWXZJTGJ1ek9EelRFUThPckhSdEJCZGFtU25NTmRsR1V1?=
 =?utf-8?B?UWJJY3NJTlBrVGQwblU4WkRZTS8vc3EvbzlCVEJUNlROT2l4RWIyY3JnN1RS?=
 =?utf-8?B?L3V1OEdWelJzRlh5RFFpVlpCL1R2c0dsb292YnhmSnZrZFdxME9tSW5BdkZN?=
 =?utf-8?B?Ni85WlhWQTY5ZEVnbmN5RStydllDR2JpWjd4M21ramk3T1dUd0NwODdKOGVv?=
 =?utf-8?B?WlpQb1cvbFN1S2lwMU9mdEJhakQraVllcWVBR3ZaS0tod1c3dEhJNXBKbkVX?=
 =?utf-8?B?a1h0UHVDeWFncFVvRC92ZVc1cUx5WURlNzh4c2lIQTV3U0hzcWprL3hpUU95?=
 =?utf-8?B?dHpsSUJQWU5GWTRHSy9oTGtZK3J1WGdIS1FUbWljYXRLUHU1aGpWN0pobHNm?=
 =?utf-8?B?bmlrekRxcHJtdzhIY1FFWnNHcXlieFhhWDE3bjBmT0tqS214SEozZjg0eXNq?=
 =?utf-8?B?eE9uaGJ0UUVTWFcrOVp1WWRWTHFGMktmVmlJTUVJZnhaVjJCTWZvenpkanhJ?=
 =?utf-8?B?My9TeGVYU2JhdWdMbnNnWUdLODJxOU9pc05IeWRYMEpUZzhpN29TZ21rWGhs?=
 =?utf-8?B?WEFLelBHeE1KNVMxSkVOK0RpTkU4UWNBdnQxZkpaSHdpVlM3UGs4QVJRSnpY?=
 =?utf-8?B?K2ZXd3F2cU02V0NHY3Z6Nkxybms3THVlVGlURng1UEdkNzdRTGdIODV1M2Nk?=
 =?utf-8?B?VCtrTjdNTmVuVzN0ejB2NHk5V2p5Z2pFaHBYaUM3VjNTUzlYRFV0TFRDQk9p?=
 =?utf-8?B?R3ZPcGI2Zkk1WHExVVhRVExTQ0MzN3oyMW51RG9PdUZpL002MUdjSXBldVZE?=
 =?utf-8?B?cE10TmNPT2VHSCswMzh6V1kwcFlpVEhmdWtJTXVyUE1LdjRZYUxwckhmRGhi?=
 =?utf-8?B?MC9JV05XR3FEQ3ZNR1FSK3BLQ1QxWGdkN1VFbVpqRk1QWnU3eXhrQldLZXlp?=
 =?utf-8?B?c3pDOUpWQWFqVXNDQ1kvT1VnRTgxcjVYNGZXUmZtQUtidXB6TEFVVnJVNFpE?=
 =?utf-8?B?ZU5GNXgvWU01V2ZRZTZZTHhCRkFHQ1RIMWRsVUNleWVVcjNzTm8xRG1JNTQ5?=
 =?utf-8?B?ODNTcVhmSHRkanJVaVV6NXNxWnJKYmJyaTlHdUpPR2YydVhLblh4OXJUSno0?=
 =?utf-8?B?SFhlQUxSVnpkNXZkeUVyOXdxVGpiSHdrV1dTUDBjcWgzOFh0SXFJVStsZWtY?=
 =?utf-8?B?R1Q3d21uTFpGTVpqK2orYituU2J4alRJNCsyOG1pSGFvejJXUStiaFNraXM4?=
 =?utf-8?B?ZFFtSGlJYVZFZGpOZDRYemtpM2Rmb2VGUTRmaUwzYlVray9GbWlzMFNqaVhM?=
 =?utf-8?B?TmlUL3h6SHNHTFFKc2hoY0hNL3NraDMwWHRnUkgwZlA2STJJZ1Q4Z3hjRGh4?=
 =?utf-8?B?TTlDeDRIRmNwV3hlZHJVT05JaVNjb01FNytqMUhaVVRLSHRlMDdGaUxZbVRQ?=
 =?utf-8?B?V0daaFJzUXhycndhc1cvdkJKc2dLaXFHNTNmOU5pNU5kR1dNVXdNTUZoOFo1?=
 =?utf-8?Q?H548=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29764cd7-fc3c-4330-fd9c-08dce3bb5915
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 14:54:57.2617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gyd23lXBK0MR7LKWBalHFYHrNLnw5473irwzYuuKMo+OxRjWx8YzLSlLhHIeA4OvQsBRX4PmUEmIKeCFcRduQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023
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
NTozOCBQTQ0KPiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFyYXB1QGFt
ZC5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogU2ltZWssIE1pY2hhbCA8bWljaGFs
LnNpbWVrQGFtZC5jb20+OyBmYWJyaWNlLmdhc25pZXJAZm9zcy5zdC5jb207IGdpdA0KPiAoQU1E
LVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvN10gdXNi
OiBvbmJvYXJkLWh1YjogQWRkIHJlc2V0LWdwaW8gc3VwcG9ydA0KPiANCj4gT24gMTAvMy8yNCA2
OjQwIEFNLCBBYmJhcmFwdSwgVmVua2F0ZXNoIHdyb3RlOg0KPiA+IEhpIE1hcmVrLA0KPiANCj4g
SGksDQo+IA0KPiA+Pj4gQEAgLTMwLDcgKzQwLDI0IEBAIHN0YXRpYyBpbnQgdXNiX29uYm9hcmRf
aHViX3Byb2JlKHN0cnVjdCB1ZGV2aWNlICpkZXYpDQo+ID4+PiAgICAJaWYgKHJldCkNCj4gPj4+
ICAgIAkJZGV2X2VycihkZXYsICJjYW4ndCBlbmFibGUgdmRkLXN1cHBseTogJWRcbiIsIHJldCk7
DQo+ID4+Pg0KPiA+Pj4gLQlyZXR1cm4gcmV0Ow0KPiA+Pj4gKwlodWItPnJlc2V0X2dwaW8gPSBk
ZXZtX2dwaW9kX2dldF9vcHRpb25hbChkZXYsICJyZXNldCIsDQo+ID4+PiArCQkJCQkJICBHUElP
RF9JU19PVVQgfA0KPiA+PiBHUElPRF9BQ1RJVkVfTE9XKTsNCj4gPj4+ICsJLyogcHJvcGVydHkg
aXMgb3B0aW9uYWwsIGRvbid0IHJldHVybiBlcnJvciEgKi8NCj4gPj4+ICsJaWYgKGh1Yi0+cmVz
ZXRfZ3Bpbykgew0KPiA+Pg0KPiA+PiBpZiAoIWh1Yi0+cmVzZXRfZ3BpbykNCj4gPj4gICAgIHJl
dHVybiAwOw0KPiA+IDxWZW5rYXRlc2g+IEFzIHJlc2V0X2dwaW8gaXMgb3B0aW9uYWwgcHJvcGVy
dHksICBieSByZXR1cm5pbmcgMCB0aGUgaTJjIHNlcXVlbmNlDQo+IHdvbnQgYmUgZXhlY3V0ZWQu
DQo+IFRoZSBjb2RlIGluIGlmIChodWItPnJlc2V0X2dwaW8pIHsgLi4uIH0gb25seSB0b2dnbGVz
IHRoZSBHUElPIHJlc2V0ID8NCjxWZW5rYXRlc2g+IFllcy4uLmlmKGh1Yi0+cmVzZXRfZ3Bpbykg
b25seSB0b2dnbGVzIHRoZSBHUElPIHJlc2V0Lg0KDQpUaGFua3MNClZlbmthdGVzaA0K
