Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B38CCD19A
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 13:06:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0888483826;
	Thu, 16 Oct 2025 15:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=avaya.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=avaya.com header.i=@avaya.com header.b="NkDSJSQ3";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=Avaya365.onmicrosoft.com header.i=@Avaya365.onmicrosoft.com header.b="U0yLRPzA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97A3A829E7; Thu, 16 Oct 2025 07:26:11 +0200 (CEST)
Received: from mx0b-00186901.pphosted.com (mx0b-00186901.pphosted.com
 [148.163.137.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84CE080077
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 07:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=avaya.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=amanea@avaya.com
Received: from pps.filterd (m0173337.ppops.net [127.0.0.1])
 by mx0b-00186901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FGABaR002840;
 Thu, 16 Oct 2025 05:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avaya.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=dk201908; bh=KzIr1XyShzIHBOZFDYIcdtFRO
 Z3vnUOqIJnLIjU9o5o=; b=NkDSJSQ3AfecJtfhlDqA2ipoJYSafYug1yv6p7RC3
 8B0tZxkkFBCA2thbnNkHGIhpN7GxClVW0jimXZlff+tnqGlRxKulFC8Xd7Xg1ydq
 JW07fX/02F5P0rOviOhd/b4DPSiSyVZcU5i8/izBs/Xou11nSv66vv1R/LDe2KnD
 BWsMYsaa1LfeZrkPdyd7A8Lj5ibN41rMo3pDCp+gdgDNzPfEd+AZzSGhdvWnzRB0
 1c9pvXOWqXWtOhhUi18B1K9MWQjpeqLipR8fGZPrPufpVmehsyRYbcpHWs0mvGFQ
 HxrE47qhePvAPuRacT7+MmYimDlaPDSIPS/P9wKP/VbJg==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012051.outbound.protection.outlook.com
 [40.107.200.51])
 by mx0b-00186901.pphosted.com (PPS) with ESMTPS id 49sgypnb37-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 05:26:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ir/53dIzGuyQAGQTBWSOEEWNlrw/+hvLyFl9rfyLXSc23rb0ab3jgLf3C7K6w6rcykyVlUQpfuYfKukRfI2EnuWe+Igva9TLHS4V2skBIZNBmjST6p4/h0fhzMv/N9eI5l96eFD5oTElndkWdr2dE+5Vduf0eRtuzhnjgfWrkfRbILgfWcAxeFZ60W29d4L+JpmiGtRB4tEYBpF+RdQfewzKDrLRlVaof5ZXT/Gwmiwcum3PJf0lo40rVkJG0jJdP+0pwpdg4JXqQS0BrVUo/fuH+nEkmWZIvrnLhfItCwP6PtRXY29Ix+wZKERQZWR98CALPC+AGm5xG9xQoRsL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfViDz8KXSO7SwoEXVe4LblUEcqjBsurI/RFQbvtdxI=;
 b=tEmFRECI3Izkh1Kh5uL9D3Gg1/S8OJw5++ApDGlO4821iEj+M5NrgVMfGPJnzJdfffqHpYh7+kX6EnUfHBfNGiHZU2mHSJxdgmgkKVN+BhVeDbaP17IQuVcrZrBH5HZzs8+IOByUZP5HjofXU9VpsFZ56Nsvy4OCXL/mAwUx2x1W/p0nQjwRuZftN9lLAsmYS7mRBXfBA/XbvApt3QMxTPB+QR55AXc83nGNHrZTU0AWAgNw8UOPkeHVhslvHloOc3q7PcOj7ZrfqstpOjUiEUzl568v9s4xThYpgllkDXll6c9seOBINtMIX9+jjzojSL0+mSZQc97zTlIM4gfS8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=avaya.com; dmarc=pass action=none header.from=avaya.com;
 dkim=pass header.d=avaya.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Avaya365.onmicrosoft.com; s=selector2-Avaya365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfViDz8KXSO7SwoEXVe4LblUEcqjBsurI/RFQbvtdxI=;
 b=U0yLRPzA0wOUj4uI5MTj8ZEcdo84ktEO4d/TRV1/Zcq5vCOtHJ4w9SMOj4TrDPNTR/hxnc7AHnkD/ivRUBzkosX9VkzL+N+vgJMo/iFJCcTqGkjqAMCs/uWKyK9itmg0QZjFouoxeSkuPAZ3jvWKDfhK6tD8WFRT+QFk1eIflzg=
Received: from SJ0PR15MB4758.namprd15.prod.outlook.com (2603:10b6:a03:37b::21)
 by MW4PR15MB4347.namprd15.prod.outlook.com (2603:10b6:303:bc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 05:26:04 +0000
Received: from SJ0PR15MB4758.namprd15.prod.outlook.com
 ([fe80::6b53:e8f:2b48:7c23]) by SJ0PR15MB4758.namprd15.prod.outlook.com
 ([fe80::6b53:e8f:2b48:7c23%4]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 05:26:04 +0000
From: "Manea, Alexandru (Alexandru)" <amanea@avaya.com>
To: Sinan Akman <sinan@writeme.com>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [External]Re: Uboot upgrade from 2016 to 2020
Thread-Topic: [External]Re: Uboot upgrade from 2016 to 2020
Thread-Index: Adw88+QOxL+rsyUwSIea/uTt5I12zgBLeRGAAAOGaoAACzVOgA==
Date: Thu, 16 Oct 2025 05:26:04 +0000
Message-ID: <SJ0PR15MB47583424C26BA0F2290F1532DCE9A@SJ0PR15MB4758.namprd15.prod.outlook.com>
References: <SJ0PR15MB475808D1A536E7E2993BDD1DDCEBA@SJ0PR15MB4758.namprd15.prod.outlook.com>
 <20251015221933.GW6113@bill-the-cat>
 <5b6c23df-1b90-4ff7-80b9-e68f6e08f242@writeme.com>
In-Reply-To: <5b6c23df-1b90-4ff7-80b9-e68f6e08f242@writeme.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB4758:EE_|MW4PR15MB4347:EE_
x-ms-office365-filtering-correlation-id: 02fe0117-43bf-4509-c2ef-08de0c748067
x-pp-secret: juy7654fvc87ki.jtred3xepo0.4g2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?VEpCMi8wSEN3TUMzczFtcWxIeEgra21uaVdyekdHUHRLYmp3czUvZnZCSCtH?=
 =?utf-8?B?b0V2R1c2TGFVVWh1anB4bWFsZkM3QTNZbnBBa0ppTjZBeUcyaFdQN0xwWVZx?=
 =?utf-8?B?eDB0ZUlDY1RrVnZwQTBYVEJzM3YzVTNuLzE5U0NqNTlnZTNZOHhzSDl0Rkth?=
 =?utf-8?B?WldldGljU0dEOHgyZWoyazhyOFBGV2pMSTZvNFBNNGd2d0RHL0YxYWs2ckZn?=
 =?utf-8?B?bXdYRFhHUTRKQ2paejBET3NudkdGS2hiSzBMQUVOWlV2aUlJSVFpUTBsTEky?=
 =?utf-8?B?QU9yeU9SNjNoVEYxOTNhSitpSXZEVEZsNXgyUHJnSldoSzZMRHJwZjN5bGVa?=
 =?utf-8?B?WlhaRlE2aGl0Tkd2QmRsVUMvM1ZrdHVWNk5xMlhOaURiWHdIS2I3c2VsUHph?=
 =?utf-8?B?UGJxV1lYRE1NbGdsQ3JhTHE5TzlUcDU5RXpZRkNidWxFQzhXUWdQVXJ3RG0r?=
 =?utf-8?B?b3JlQXlBS1lWbEhtZGE2SSsrT3dGNGlpVm5URWNPazhSclV5dFRPcmM5eEUv?=
 =?utf-8?B?cUN1SEFEM1VuTFpEV25WUGYyNnNFcUFoM3QyM0J5SWUrT0Y0djFPOHloYWFn?=
 =?utf-8?B?TEJiME1nRThDRldLRm16dFdjYlk4S012N2dmTkY4R3cvYWp5NFBCTGw1bE9h?=
 =?utf-8?B?S2VlVlZKdHVtSHBxWVJGcEFDalNKY3NWR0ZIb3N1eWhGRzA4SUdLajZkT3lN?=
 =?utf-8?B?b1d3MHliYzRySFlTU2gxb3VWbjVlS2JvNmdoYnJOS2hFVnhGTUZiL0U4R0hD?=
 =?utf-8?B?cDIrNmpNeC8rQU8raXJERCtxT3F5akZVY1NvcmhlWXBVNFVGRmZrY20vS3pS?=
 =?utf-8?B?bUZyZ2tHWHUwYkt5dmJSaGVYZHBuTTJwT3k3TWpVSUMwN2h1WVJlTFFFd0E3?=
 =?utf-8?B?NmhtZnplNVRUR2cyaUhIeXNrT3ZVV1E4aEpDL05qSVNMcGVPcTVsQ1Fmd1VC?=
 =?utf-8?B?TGE2YUk1TWdTbG1EK2pYRXpFeWNuZFR6T0VxQTFOOEVIbzJZazRyb1JaeHF3?=
 =?utf-8?B?bldweUY3Syt6Y3lad2JRTEtGZ1ljcUJ4c3J5cVNSeWJTd3h6OFgzYjUvZ3hJ?=
 =?utf-8?B?M1gyTEQ4dXFtNnBLWWZ1LzcxTlNoMG84VGJONUMrSm80WjVIcTFraTdCTFU1?=
 =?utf-8?B?R3NQWWpoZTRGUGtEZTFwdGVhTEw1eVpuVHlzdzhtVTRtMTZpeTNxcnB3OVZL?=
 =?utf-8?B?Z2dXeUVXL3hvUzVRbktJTTFQSzJ2WTd2RVhZYSsvM2NjcWU1UkkrNUdFZHlt?=
 =?utf-8?B?WHU0cWFtenRLVjBSZm1aM0FtOEw5VTIvMER2b3M4NFZ1SkpEbTV6S215MlZZ?=
 =?utf-8?B?S2t2cFRDK3hQTXZvYVVaaVJ3aGtPY0IyaFVYQVpSUnhFTUNENkNFZVhMZkha?=
 =?utf-8?B?dGZObmRNRmZLWUtHb1BXNCsyNXVaa3RnR0RHUlJ3cjdCbTY2bkN3TFRJVWlX?=
 =?utf-8?B?Sm5lTmVpeTdhUGZtUWVLM2dKalI0RlViZGVzekpoc3AxYjNoWTczQUZyaEVN?=
 =?utf-8?B?b1VlNGZ2Ujl0SEhGdm5oTnNtbVRDQzRwekpqWmcxU3JVZUZFZnVFd2pILzZw?=
 =?utf-8?B?ZXJ4bzVOT1k3TFdyV1E0OVVRVEU2d0p3T1pUYTd6RkZINFFnWDYrL2dVNXdY?=
 =?utf-8?B?UlJ1bGpDcWF4YzBrL1A1WDhjUjVId29VbUdUb1NSL2t4bjBKZStDUThwaGVi?=
 =?utf-8?B?d1JwOUpkQk9QUzZhZ1hialZMRUhkaEJOM1hBNlloRlp1b0g3T2xSdGlSQlJo?=
 =?utf-8?B?NWV1YzFWL0llaFVuTWp2WmxVbDJmTWh2NmF2MlA4cXNnbnQ1TWpoNVFYMHBZ?=
 =?utf-8?B?VnJhOWREQ1NRSVFaeGNiN1oxckg0eExFdDE4dGh1ckZTcEYybEZxeFRxWHdL?=
 =?utf-8?B?WXdxSW9FQWI5aUZnL01OaktnWk45TzlsMGx3RmtyYm11dkpYbU03V21pSHF1?=
 =?utf-8?B?N0JSMCtiR2lmYk5UTTZ1WjdYMHAwNDVUSDdmTitTY1hyRGErKzEycWFJRGpE?=
 =?utf-8?B?UGduMEhudlZXZGpDU2JWVDRwK3ljbkRReUFQYnRieE54L00vRW54bWNhcnJF?=
 =?utf-8?Q?IiD0qG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR15MB4758.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGRiOXRlOWxLQU5JQWRhTXRpZU1YbUg0YkY5YmIxZnZVMkhBYlFHc25hSVQ3?=
 =?utf-8?B?WjQwZXJnbGlBbWQzR2x5TU9qZnZHQ01CZTVUZlBYWmpJbFF6STZqQzdVQnlu?=
 =?utf-8?B?S0hkZTJjUFN3SDhSY3BZYkZIeEE5S3dRaVNCWldYYkpCdjFJUzZvU3Q3SXZ2?=
 =?utf-8?B?OTNQbmUzVEVtT0lmUnYvQ1VVM1hQQTI4RGhDeUpYN0xTUmNOeWhPTE00S1Vh?=
 =?utf-8?B?WXdjKzlTWEVQZU8xNVE2d3poOU94VlVQQW5WZWN4V2RhWXJDdjlKaXlBYnVj?=
 =?utf-8?B?cnh3UkRCMkFWend1MTBrekhyaTBRN3psUEMrR1hEN0Q3YlV3L0xNNEJSelJ1?=
 =?utf-8?B?NlZEeVdNeTBVMGtNMmRxNElOYTBsVllzSm85V280N1VGRFY5K014V0pCYWJ6?=
 =?utf-8?B?V2FLdGQ3ZnF0QkZDekovK294WnVBdFUzY2lDK0ZkZkU1RWFmWGljdkI3c0No?=
 =?utf-8?B?QUdCMnYzbXczMjJhK1lVVHRYaGxSVG51cDFHemxsU0ZERGNxNTk4KzhJeVZ2?=
 =?utf-8?B?WEhQZ09mYUduU0hESmZEbk9xWVFZN1M5dkNYRUkzVlVGNGMrQjhrUURra3FF?=
 =?utf-8?B?SXpwRk1oMVhmVGdXek91MmJvblBWcDFoSFNKdG1HNEJXa01ZaG5FT0tsM3Rz?=
 =?utf-8?B?aWtrdGZlTXh0TXcvLzZJeERiMDdVZVVPa2Y5TVR3MncxV2l3MUtRZmEvQUoy?=
 =?utf-8?B?YXlxQ0F6WGllWmo2UFhMRzlUNjdXR2Q5RmpUTGp2TXBpQXAvcW8yMUNieEVM?=
 =?utf-8?B?UmJhT0RxT2dYbkUyQ1A5akcyZGFkM3VxMWdGQTU1Mk1wSkNKNWI0Sit2UFJx?=
 =?utf-8?B?djNWa0dMT2FTclljQ2k4cDdDaW5MTXBDQ3VaaEdUQ0VnMzFxSUg3aXlQeisw?=
 =?utf-8?B?UDd6U2dRck9WUjF5TXlSVzBLeUt2S0hKQWdMcmhhMUJ5U3NhRTJxbTBnL3pB?=
 =?utf-8?B?SDNuQ2xKZkdORmh1OWFsZ1Jkd2h3Mk9aSWFRc055UUl4VHUxa0RrUXYwWk5C?=
 =?utf-8?B?enJuOTNzdmRlandIQWZZR2VWQXlpdFM0bTFNRTMxMk0zVUdNMHBrVGpNRUd3?=
 =?utf-8?B?TXFrUnJpU0hrWXMxVjRXOWdBM3JPeUZnWHpzMEVCYmcwQUtUM3JFdHY2WUhy?=
 =?utf-8?B?VUV2K0hIRXFucHNhMlNSdFZUWlpEdnRyWmh1bno5U0s4MnhLTWdCZGhIUUwr?=
 =?utf-8?B?bkJMOWNCMGJDMlI2Y0ZtaVVwenViaEo2YWllUXJTUC9VWWtxdmVYTkhCOHpL?=
 =?utf-8?B?OUhReEs4c1YzMTNYZGVCZmtndXhpK2dGYVUzMWxEK3pHNzVMcE9aT2o4Ym1N?=
 =?utf-8?B?Y0dmTGxkU044SGdGdzExdzdFQXBGUmFUNm5ubHV0REZvNk54WmsvaC9rM1hP?=
 =?utf-8?B?N0ZBS2JKaXNxL2hoV2JxRnB4YTltRlFZYlo5a0haQjhtd3pUU3lmWGNiTVdQ?=
 =?utf-8?B?WVYzUExMK2FCUlB6a0NyU2RrdWhDMXpHNEp2TDZob3crSEtDL1hiaTNSZG11?=
 =?utf-8?B?QjY4enBKd0wrQlFmaElWK2lYbkZsR1gwWEE2MjRVL01yRXprQnlvRW5EUHJH?=
 =?utf-8?B?VC9EMUdsN1BWUmNOMi9CRk1hc1lEY2FoT3A1YXpiaHBid2tVUVgvMWpvWlIx?=
 =?utf-8?B?VlBhNmZVdUpnODhjWW1neitTS1ZDYVovMjB6NnBTWEYvcEtpSVlycXBKNlkv?=
 =?utf-8?B?Wi9qR2tYOEVRTTFRbmk3OEQvYlhubHZDeEpVNXBXT3JWdkdwd2hRNHNxdndO?=
 =?utf-8?B?SzJDUnlJVUpaUVRoNWlQZm0wN3RXUUpBTjBFclVMS0ZrcG5BZGwxeGtTZ25X?=
 =?utf-8?B?Tk0yZzBNUmVBS1ZVTy91OUdZVklrZ1RheUlWenAwdU4xdnhsemJjUTkxeVF0?=
 =?utf-8?B?Y1lMbEM2RVF1Vkc0Y2x4ZExramwzUW1CY0s2WmFmaEZrNmVId1ZQM2lHOThC?=
 =?utf-8?B?Zm9mUGZYZ1RCRVFLWWhoR0FpNmRDbHVWSnV3RjZ4dmdjVWtCVjZacEx2SUNQ?=
 =?utf-8?B?RDE4V3d6SUNiRU5ib3JheHE2RHlzZXRYVEp1c290d0NZQjMzdTh1Y3NwcWNU?=
 =?utf-8?B?N0tKelVlODFjQmpjSmVib1NvTG94OXBqdFRsV252Z0VVd2FURGYyZUpUb3Nx?=
 =?utf-8?Q?C5/o=3D?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: voKUWz2sAl5eKE8hPbz2TiScQOrVV1AMgGshsXGYOaY/1BicgE/K4Kzua1FoGK/CHJ5OnS883Bk77ZoyRkO5O52s2TAvrzaqHEjOiojin+sm7Fv24sB0Kxm5a/rF4i2OkmmBHsRX3tqlq+eCJZcjn6LPjCIwowAzk/Rp52/K6jRi8qI46IYkA8aqXqvUvmoV55X92KjkBPlAva9Q6s/q7fqUm0QOROHqXnqsLyfb85XDLr3DEHHj5OZaecuglpOqZk4/Q7T/aBEV8QJUoOxuiny6PwfZP7hA81iTgbq9vOwzlkv+4WDPDre45u3LczISlguRcBb0qFSyDvMXQkUIImp8IEZu4NO3Z+MpciFjQxHLV4FCB8QHNG5aC0jjA6F2YAqyt0CL2bY184xuUhw4D97NSVq3Zmz/Ob48pF91SyH95YkSusTYryOT3Som7j+qq83UJSFrej3JTmkCb4xfSZqmBhKmAkcL3bOoJ8CjTRuMvAS7d7p5H/w7mX+f5t1gUJQ3HT41NXcZl5Bob2j8sByy9AskMbyH7iDodV9GwjV4nEaU1TkHsLwo/TMSLq9uYxxKnWtMzAtK0G8zk5m4KZrsAFTFqlaKzwfv6FIU9oP4Jg28YaMgDJ1f9ytuPeXmlFHSnsh4W6iOXt2Z/q9bpQ==
X-OriginatorOrg: avaya.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4758.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fe0117-43bf-4509-c2ef-08de0c748067
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 05:26:04.3088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04a2636c-326d-48ff-93f8-709875bd3aa9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/tUfhFGGajUnbsndEojqGNXLhuAxYf0tf7AakXU2yaYg3bD9ooNdXJBgAzRWHYE9uBbWqCH82oBoWcyqPITcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4347
X-Authority-Analysis: v=2.4 cv=AIMSTgfK c=1 sm=1 tr=0 ts=68f081ee cx=c_pps
 a=W7vQ9/Pp6pMPjVhEX4N8+Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=7_b1JmNPT6gA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RpNjiQI2AAAA:8 a=DDUcpTWQAAAA:8
 a=k-42gJp3AAAA:8 a=gEsRDbIwAAAA:8 a=JiIjFLXM_9vc-fzBQX0A:9 a=QEXdDO2ut3YA:10
 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=uYoH7J6toVgxnvLWdGYA:9
 a=ddLtR-_7MOLr4vz9:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10 a=IzUggT93oxiDeI-kYzx2:22 a=uCSXFHLys93vLW5PjgO_:22
 a=9PIBWyluFvSNxe44y-eH:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: Y-1KnNdSImSQJw800_HavEYxozYXuC9h
X-Proofpoint-GUID: Y-1KnNdSImSQJw800_HavEYxozYXuC9h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDA0NiBTYWx0ZWRfX2AXsJMbFtSnD
 cPHmTeHfkIfT8DGWpw9hPCKHE+upBh6Gh2CeJBd4Oex5TCmwxvtYLEGAa4lGRERHXWcWPsPd4cC
 q5M6em0Q9e/ka/CCB/L0qVar4GL3L5WlGCOaGSljrr4+bs8toBXRVmZZWyA6EN9qU8KJwDs/cC4
 5bgG6Pq9OfZPKTWuKXRL9DJXEGEWuPIJXmC2EuCJuWyH68OAJi4r+EMADLl09qprwWXsDqV0z2X
 +mKeRxU7relzNdmu0GSd774G88CsG/rUbO+uMX1cDd96GbyeNdiZtgiO7raMrNkgONNw6Ycn9L4
 Tmaq4dxhl89AIxbBsGjpM46ZgW8VOdepPbVGefYMSAcrDFpR+LPockS62dw5n8w+ewW5gcwjrBy
 9f+AyW7/TwJ9mySua7DgwPfXYEITcw==
X-Mailman-Approved-At: Thu, 16 Oct 2025 15:06:00 +0200
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Sinan,

First thanks for replying. I do hope you will be able to help me a bit.
The board is PPCE5500 used for Avaya IP500L platform.

What I noticed for hanging is that it hangs when setting mtspr    IVPR, r0 =
in start.s although this seems correct: CONFIG_SYS_MONITOR_BASE@h

Regards,
Alex

From: Sinan Akman <sinan@writeme.com>
Sent: Thursday, October 16, 2025 3:00 AM
To: Tom Rini <trini@konsulko.com>; Manea, Alexandru (Alexandru) **CTR** <am=
anea@avaya.com>
Cc: u-boot@lists.denx.de
Subject: [External]Re: Uboot upgrade from 2016 to 2020

[External Sender]
Hi Alexandru On 2025-10-15 18:=E2=80=8A19, Tom Rini wrote: > On Tue, Oct 14=
, 2025 at 10:=E2=80=8A21:=E2=80=8A37AM +0000, Manea, Alexandru (Alexandru) =
wrote: > >> Hi, >> >> I have an issue with upgrading our sources to use the=
 2020.=E2=80=8A04 uboot rather


Hi Alexandru



On 2025-10-15 18:19, Tom Rini wrote:

> On Tue, Oct 14, 2025 at 10:21:37AM +0000, Manea, Alexandru (Alexandru) wr=
ote:

>

>> Hi,

>>

>> I have an issue with upgrading our sources to use the 2020.04 uboot rath=
er than the one working now on our system which is 2016.

>> After adding all our board changes, I can see the SPL loading and settin=
g DDR and TLB entries but once it tries to jump to uboot from mmc_boot() it=
 hangs and I can't get to see anything...has anyone encountered this? Is th=
ere something I can do to make sure uboot is actually being jumped to or wh=
y the hang? I've set the offsets to go to the _start_e500: instructions lik=
e the old uboot. I can share the traces I have if needed. Looking forward t=
o an answer.

>

> There might have been some issue with certain PowerPC platforms

> introduced after the v2016.xx releases and fixed later than v2020.04,

> and git log might help. Of course, it would be better still if you could

> move to current mainline and then help with PowerPC maintenance, as we

> do need more people helping there. Thanks.

>





Which board is this for ?



-- sinan
