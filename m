Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EED8C5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 14:25:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45D8D80D7B;
	Thu, 20 Aug 2026 14:25:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mtbDUfxsdzvF; Thu, 20 Aug 2026 14:25:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787235934;
	bh=jeEN8LNCdEgOLznhTnLNweANFeONWc8UsjDp8WFEhAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m3m8aAuK627ugUKwQ/ELvfXAZjytfNSyzb/CZz3Uj/JKXfRPKUuvH+hUOgWbYx/12
	 gzDl8kQc1FCMkSAOj/TQ8eD60MdF7/w/nggbh5WJvAreQAh0MRVDQWAaIpX57Qhz0y
	 hRzFScmvoHGSZle7rvRDJvbGW3YiekJ0xgfxVVmBhUgkT4xs/GpAvBLjWuSA7ZTIi0
	 GFg3etrfwru5EHvijyCA5n7VU3ATwU+99Ai+4YPdsh7SBOgAcaAh0FQ2tLlvUhSRJL
	 bv+0wKsw1TeXJBwJHcyDL2IW5IvvKdDJT5p7MNomCkM6w4RxaU/TB3h+/mVw5vSBW/
	 OsPDIPj6bIpEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 953B780D5C;
	Thu, 20 Aug 2026 14:25:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FF79279
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 14:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ECC77607D8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 14:25:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s01SUEtf6ZOs for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 14:25:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=SsE8JJ80
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 310FF607D5
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 14:25:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyyWPE8jdVklvWn0kS2VxP2A6KrO1BQhdx+8IAJ//e8VD7d+H0s65bf/8CCQGAVPCnIefChbMNGJ0XasoC6cnQsL+kU+QR0VBVAvTf8D5ce57IZ7dbnN3spRzrei3aOstKy6YhANEhttcKKj0eHUKxqLbyModcD8nFU4cinRGFSCSMEWjV12dB23Asg9p1JbBQ96ECToUtQHdb9zKleHJiiXxzw+Q2TUE0JLJ3J5v0CRDIWiNi+qk9JuFiiXDrTO+939LYYv20xkIaayoHCNODEQfzTU1kfBDFGYy6hkZudesHyyjA41wTmhMEVRUF0uh1cZTKrfUPygSA5R16+Mow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeEN8LNCdEgOLznhTnLNweANFeONWc8UsjDp8WFEhAk=;
 b=IU4Uop304xx9QyRaYUiKTlDTPy09nQLIRFjWe1sTaOljgzoojuNUdUW6wDaUqGER7BG1fTW0AdMnzJibcM0xx3JkLxuEry3mWNKoRJm/ik2IJVNNxDFcO7Sf/BnZnO2oGv5ThlwwTIaebJsfNBrBjow4HyQhO83GbA+FMTuAv284O4WsJuYxZuEfuKYRbUdRaRuH1/UDKgGnQgOyWwJNlzUWgTqCXA1xy1fwm6svhF29AK3TicEiFAxpR79rgWb9vs2CJQA0croEbiPoutstJX1IMNi9X9IWk76AZolBLcsT6kORn0VC+arfNRwN1jNFBgYi2Ris50ICeXP/Ifc4Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeEN8LNCdEgOLznhTnLNweANFeONWc8UsjDp8WFEhAk=;
 b=SsE8JJ80XfR7TY9fmbHUJTF4TTkFbZEY6Gp3/X0drU/xeag/Yp+ua4c+4djhNtdaJSquEMyePJdVmz21fOZayB17RmKrvpFIJc9WwltEP7voNQ9x1wrURZQyCOFwb2N/3yUchlnuljBe+dHAZVZ1cpN2g2XcoEhnTzFNrLmhGM/p7u5HLA9R+zwz42NE9+MOIm7iGREa8xMFN0IEY44GLwQFHZKHFY16wvonahAZh7G4M79tmXDFfXpPruQ42pAXX+i5W8Pm9gjSKWaquiuosLS18SG/P7n5NbVfLmy30yog0SMuryPsXgYfgouOF+5eYnLjArx9acoVchRWidSWHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by PAXPR10MB5360.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:282::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 14:25:25 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 14:25:25 +0000
Message-ID: <fa652a2f-addc-47a4-b89e-755aba42509d@kontron.de>
Date: Thu, 20 Aug 2026 16:25:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ddr: imx: Allow to call ddr init without logging
 failure
To: Marek Vasut <marex@nabladev.com>, Frieder Schrempf <frieder@fris.de>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com, Simona Toaca <simona.toaca@nxp.com>,
 Viorel Suman <viorel.suman@nxp.com>
References: <20260819070758.51350-1-frieder@fris.de>
 <20260819070758.51350-3-frieder@fris.de>
 <b8c844ab-7ea8-4044-95e5-edac173b3c9f@nabladev.com>
 <a8be2bf7-aafa-4e8e-9685-5fa100941805@kontron.de>
 <cfe8d0e1-c652-408c-bc47-0ae96dd0a65d@nabladev.com>
 <c81db5f1-600c-41a1-91d3-7638fc4d3d58@kontron.de>
 <b528b642-5010-4843-bfe1-d24e8b709876@nabladev.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <b528b642-5010-4843-bfe1-d24e8b709876@nabladev.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::7) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|PAXPR10MB5360:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfb3d97-235a-413b-0b32-08defec6e00a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|7416014|366016|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tN2JRtNeSSVTYYbiIpG7L0RKYq/sb2EchqVk2mYM4R2BMePPHauckPd3szm1paP9zW7TSkPjSH9tJjBWsV8ZG8w6vq2IhpIQjL7Fg6WI4UQvOY9kyPQomjTtvLl8b7XxtlRAVobJM5aKaiOgFv0+hcRJAVUweBkOIz/Ln59SmMLyHj7rwbaB6txwDW6rbYoon3ACXwK8B0T+cdnyUd+5sOueUpDKQD2yGtwAZU3cnGe49FfcaEAlwPBYQwLj/Cimc+pBSSxjZz+E7pVuY+3/X40YIoS1HQ4fwueuDOWCJl2E4K42bc5OOHjPWbxB0GegQUy6LblGUoblEDP1LZOUKwKHobB5I5RDypjD/g3V5impwHMRWd6IOiMq9L8maMpTrt81qrViVwUIstNrL+4KFBF/Dz4+vb7YaI54zZy2BiXfcYaykh3qEsBfBXEBumrVhYmXZtYEM+juoDAItgH+/kbgdRkxgGNP51sm64tS0RezAcmza+IQEEKUwiEfomct2u9QnsEbHLJvO6rB1xn5ezJBXV1+f0JVwEDQmh4gaNxX2clAxVSaYxn8siEp9FXN0IVjU1iYHAZQDPPcYIh2CUyaFPp0w+khmLANe52rIMFlCTArXRf1c7vf/INNMLWi7ILCHIT97uDqIYJSaaeHh3vVaaFit5EB3E2ync9FRuI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW1hQ2RRYU1EMlZGU24rR2FxQXBVbE1yQ3FYc2dtemFMY0dXL1M0cUh1a0VM?=
 =?utf-8?B?SWNGd2hjZlp6NHFrZHRmVkw3SGZiRHJWbVdqYklCUHU5VEMzNUxMTW9IeXlM?=
 =?utf-8?B?bXRoRithWS9iWnJrWTJDcWtVcTdHc2pySlNmZUhTYTVIemorSm52cXNVcnYw?=
 =?utf-8?B?NFFqL3l2M3hKb2VvbEh0clY1OGFBQ0ZaK0I5VDdIRFR4ZVZMeGZ0RS9WZlBa?=
 =?utf-8?B?UW9tMEVlOEZNOEt4WXZXQzRMQnNrVnNRMHdRMXpza1Bhdmwvc0NFMG9jSGcr?=
 =?utf-8?B?NThoMVZkWm5taGszQTAxQ0cxUnA2enQ3MFBQbTZPOElYeHVIRnZnRVVBandN?=
 =?utf-8?B?aWZKK2tRMUhVZDNwS3hOOXNKWVFINnREV1JwL0lRQTRoRmdTelQwSlM1ekZ0?=
 =?utf-8?B?aUxqV2dhaEVCRHVEbklDT2FwSFVTN2owZ3EwYkhONm15c3BnUWtJZWdvNWZR?=
 =?utf-8?B?aWg1aWVxdWwyTnBhTnZvalNBbS9UQTZwQ0NYamo0T05ROVpPOURUVVJ2aWtu?=
 =?utf-8?B?MXFWUk9CSmZyRkphOUhyYnRqcUdlckxxMmRqTyt5THNFdnQwREFhSUxWVlNK?=
 =?utf-8?B?bzd2ZWtWMUlOM2VPNVhtbVkraVV0SzJhMzluN2RIL3dCRml6MmYrOWpwY2FK?=
 =?utf-8?B?dmVCb3FDcmVJMVRVUWs0ajh5K2lpYjM4L3krOWhuRW04d1U2bUg4bmZteFFH?=
 =?utf-8?B?WlNNMk9NL3FZMFFCVFFxL3lBeElvUDJ3cjUxdkM1YkhWOC9uMFlQeEprOGs4?=
 =?utf-8?B?ZnpMR0dFVTdDV2VFVHFIcHFlM3dqWXJGRVhIU09yNm00OEwwRDE1eVN1TDc1?=
 =?utf-8?B?V1M0SWVKYXNBaDdlZ3c3RjJDUFJpTStwczB2eHdXQi9oRlNTQ1RuMThGK1J2?=
 =?utf-8?B?aUlkVlhMdGFMUjR6OC9aNzlHL2ZIOE95dmVzWUdTQVN0c0w0YlhlSVZkRUp6?=
 =?utf-8?B?dStSdW9mUEs1elh4ZDBEeS9RZjhhUXNLbS9lRWxXNjJzNVRLdjdqbzhPL1pm?=
 =?utf-8?B?bzNkb1ppR3Fia3RRSldMOVhFWk1tTW5MTmVBMkp5RG4rS0lTNGVLZUtDeXJq?=
 =?utf-8?B?UUZGZ0l0RTdsSmpMQmdBL2NKblhPTlZDN1ZiQ2xuM1Z4TldjMFVKeFR1VmpJ?=
 =?utf-8?B?Z3VKSWNUdU12VXQrZXlrdy9RVDNMNS82ZnpGaksxSEg2alJxTmJYaWk0TEtH?=
 =?utf-8?B?SjA4V0xOR3J6S2lybTNJR2REVXh2VE9NSHB0bmRDOExHa1ZxV2NzQnRzdS9O?=
 =?utf-8?B?M1NoUCs3RzN6bWVCY0ZKenV3c29ueVZYNGkxUTZzYmc0WnlEcE1iSVJzWnFI?=
 =?utf-8?B?UXFRMmgwUmZONVJpbEdGbGdpTHNSbTlsaUVuNlc2elN2aXpTMVBqUDlTZUZL?=
 =?utf-8?B?VkJaUXRvSWlqWXY1TGhEcXZGK0JkWEhYSHZobU5jVzd2MXJ1d01vVTQzT3Ey?=
 =?utf-8?B?YlJteVRtUnY3ZmxnVkw3c3RXQldSaGQrZlphcHJNdXdJUW5Yay9xcndoMHhF?=
 =?utf-8?B?SHFvR2tldVZtVEVQN3pBR0tNNjBpVy9kS0lWSE5qNEtEL2VOVUJTcFNFMHYx?=
 =?utf-8?B?VEVuRllIVzNvUmd6NDZmV1NoZDJEMngwbUlWV1dFam1sbTNWTHh4NE82eSsv?=
 =?utf-8?B?R1YxSWtYY0FkQUlNWFpaMUhmNmpjR0s1YlI0ekw2dktqaUkwL2JsaWo5R3pT?=
 =?utf-8?B?R2NxYnY0aVNkanlEaUE5ejNjbGNKdDJ3Y2JNOTJtTm05aWtPNDdoTHNxVUdC?=
 =?utf-8?B?Rlc1L0pZVEdtRlNmRTZ3YzI3SlZRMGtBNVFCK2loRVk4MllTaUFOb1ZPaEFT?=
 =?utf-8?B?T2d3TUhSb3BuNUQxVCtscVIzaHptWVV4SFdDTTZEWElrUWpzamcwZmMwTVBk?=
 =?utf-8?B?RC8ybWF0RkFBRjBKNFFFSURwQVM5YlJUODhVOXUzd3FaQytkSFpaUTIzMS91?=
 =?utf-8?B?UTZxV1hPS1J2OXVjTDZDNlcrcEdJN1ZUYU1lcXB3SFFDbE9zR0hWcDdNS1Z4?=
 =?utf-8?B?VEl4RUJnRnRnTjlBWnBRU3RQREVET012Qlp0N3daRk0rUmltRUk4ajZnMXpT?=
 =?utf-8?B?d1hLaklaWUFzNE9VSTZZN2pnd1NZWVJreTRyNDZLalhCcm85TkdocStsVjlw?=
 =?utf-8?B?Wnd1dTU4bnQvcXdsOG5ZdEJIUUFHQTJ2WFRuVmt2M1RsOTZFOG9McVlsWGgv?=
 =?utf-8?B?RUpzYVBTMXNzdU1Cd0RCZjhTWlNreFh3SmlKdkd1YmR3bUtDdTBwWmtlN3Nv?=
 =?utf-8?B?RGdjQXZqSjRGRlNVaVg3RUJDQmhicDlpOFNBYjViUHJ3UEVJR3VoY0VUdGU5?=
 =?utf-8?B?cmM1UUlrR085Mks4Q2FVNFV1S1JKelpiK0U1aktqc0FoTzg1ODE1ZkpzbTd4?=
 =?utf-8?Q?zuTbNI4vRJZLvL00=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfb3d97-235a-413b-0b32-08defec6e00a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 14:25:25.0053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uafnF8a1WPlp5+KALxALvNWoHRmYh8kDWI/GLFk9+B5i24RXpCyebZpfYqr516RDZ97OyFgHhz85yr1oBiiQpXbzndXIi2t7fFONRzlADLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5360
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 20.08.26 10:05, Marek Vasut wrote:
> On 8/20/26 8:34 AM, Frieder Schrempf wrote:
>> On 19.08.26 14:47, Marek Vasut wrote:
>>> On 8/19/26 12:10 PM, Frieder Schrempf wrote:
>>>> On 19.08.26 12:04, Marek Vasut wrote:
>>>>> On 8/19/26 9:07 AM, Frieder Schrempf wrote:
>>>>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>>>>
>>>>>> In some cases we need to call ddr_init() multiple times to try
>>>>>> different configurations.
>>>>>
>>>>> What different configurations ? Details please ?
>>>>
>>>> The detection of different DDR types/sizes on our SoMs has always been
>>>> based on trying the init and seeing if it succeeds, falling back to the
>>>> smaller sizes on failure. See here [1].
>>> Could you maybe bring the interface up in some minimal 400 MTps or 100
>>> MTps configuration and then read out the MR ID registers from the DRAM
>>> to discern which DRAM configuration is present on your SoM? This would
>>> be the ideal generic way of doing this, and it would be reliable since
>>> the IDs are stable and surely indicate which DRAM chip and how big it
>>> is.
>>
>> No, unfortunately this doesn't work. We already tried. The MR ID can't
>> be used as we have single and dual rank setups that report the same ID.
>> We have no way of knowing how many dies are connected unless we try it.
> 
> Is the controller unable to interact with each rank separately ? I would
> expect in single rank setup, that read of MR ID from one rank would pass
> and from the other rank it would fail ?

I'm not sure, but even if it would work, it would require several
separate init attempts only to read the IDs, so I'm not sure if there is
any benefit. Also I'm not seeing anyone doing this kind of thing. It
might be worth looking at, but my primary goal now is to land patch 1 of
this series in order to fix the regression.
