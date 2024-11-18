Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D47D49231
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 15:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E04488F24;
	Mon, 18 Nov 2024 16:09:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1XdE799k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FF3388E3F; Mon, 18 Nov 2024 16:09:30 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9CA188F24
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 16:09:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMoPt3BIm6qLUH39MB1krIneKhDhhv6y8rVcgfSeaytuSHuLLW/ouffVuAedWEX6AHQkKVduqVZNao68idUybOfMF1EoWUBiMh7vhn/OzvKY4icyvfhpZWRj/oPL8o6E2ezYQ35cNbTc6NccPR03/WrP1agPQgPFXgdw/2WBuo77G1TRLcqsEymFP7FSJkqvtBT/UEIx/653XELFRg2laiSdmo7ugcFctgPAvUVlnW0SQxZgV0ypdiU2kww4+3c1C4a3818Tg4UCTSRorhQZmVTiFYbC/WBL3sAWyK1S4pzWL9X8SMmwSXBqnokiY4Cid5cxwNbmbtAWiNNVAYxEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRD0330MlARExfIc8PuPkU6eqiOsPkDR9bnNVV6N+Go=;
 b=vBirx2ZQwWBLzo/2ydSKFYdEabeYa1kJZnIGECObTXiFtevDomsfqBKyCSWVy5qf8wHON+sriBM5nIMqMpL89QEDx1sJ9DQ4muuRg3meXcvfwa5KgpSTdUP9rSrmGcdmweSTvMeqf+cIzevq3TvOJg/rQuWB/nA12ZkhmOIaqWAOdgDUjcrfGRk6EWQmYdR9FMYoI+Xkfh2P446++V6NEScM4sCSlDichbgIQK/QmThyeMwVrH9Q3mmc1HjGkIrFIR/jWIRwGhqUyF8d5oQkd/27ONPJUZiUjzmvadccFk8VL8N5/cQMeXi21W5tTKyhVWv647X8bgUKvz6yhdd9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRD0330MlARExfIc8PuPkU6eqiOsPkDR9bnNVV6N+Go=;
 b=1XdE799k6eowXnspY+05lf+CKOOaxR3bw4bdBYUWGx+2GWGXXTwGSXKLgFN1CCTzmARsFJ9IOEp6p8842f6XesTDtwqToOHO80fKpBJon5NA5dcSqMBxLMdnFrQS9tfNM3tG+diui5Af54slmJHQV7ulcVPr3iJQJEmHlGLxCpY=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 15:09:19 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%7]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 15:09:19 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
 USB5744
Thread-Topic: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
 USB5744
Thread-Index: AQHbNMKT41MM9BpbCkCVHbjRknnK4LKzJkQAgAAKwlCAANxLAIACID3QgAC2pYCABkWfkA==
Date: Mon, 18 Nov 2024 15:09:19 +0000
Message-ID: <SA1PR12MB8697C5004BB109302CE441B198272@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
 <20241112050740.15343-4-venkatesh.abbarapu@amd.com>
 <d61ab683-744d-4024-a5d3-71b372e85d02@denx.de>
 <SA1PR12MB869770E331845B38B0BC2AC098592@SA1PR12MB8697.namprd12.prod.outlook.com>
 <5c4c73e1-4b47-427a-b84c-099b044d07a8@denx.de>
 <SA1PR12MB8697165267E847E8F8FDC0D9985B2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <b06d22ba-6629-4893-a90e-185f676017a5@denx.de>
In-Reply-To: <b06d22ba-6629-4893-a90e-185f676017a5@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|DM4PR12MB7696:EE_
x-ms-office365-filtering-correlation-id: a118f58c-6ba1-495e-b81e-08dd07e2fa04
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?blRoMHQvNW1kZ3F0bWhlNkpObDR6UFVFZVpiaWlBU3lHZEovY0ZYd3UyVXh1?=
 =?utf-8?B?eG1OOUE1bDU0SHlRdC9KQndMRUp5NWtieHdZMWhiSFlzeThkV1psU01GSnFJ?=
 =?utf-8?B?L245WWMyaFUzYzhHeEdwdllRY3dOOGsxWkdMRmdHaXdjQncxMlpyQWhTUkR4?=
 =?utf-8?B?aGlkOFJtZHdXZDJOblZHRVlsRytyRys1V1lEbWpWemN2RmxqQThQK2pxMmJW?=
 =?utf-8?B?a0w3TGJBRzNhM01qMUY2OFZXdUQ5TGFDV0x3bjRVVlB1czlnejlWR3lRSnZr?=
 =?utf-8?B?dkV1Z3ZLVG9NTS9UbnYxS00rK1A2OFlXYUtoY3VtdkxSaWRHZ2kzaVk2ZVZv?=
 =?utf-8?B?UitUd1Z6SzdYZDAwdHR6RGNtQlplN21BY2dzeEI2VmhxODRIWVpXYng3MG5K?=
 =?utf-8?B?bnhQeU5zcExvcWtRSVhZUEQ1WmRFUGttRTN6enRDaTBJREhCVC9PYXo3ZFB0?=
 =?utf-8?B?VUdSbExJY1lRK3l0RGlsbUE3aFVSV1JHdHpEeHBxaFAxcWp1WlBNczVVd0hG?=
 =?utf-8?B?UTlWOHJIN1JuYnNscUdmWkJIZE9hajE0R1NrOGxtV3htc1VMRjB1aTgvMHp5?=
 =?utf-8?B?YlFDeEhIazdUcmo5RTkrNnllSmF0MFpjcDI0Q3UrVXJCaitqMEVrWDlaVXRF?=
 =?utf-8?B?bENXdTN4L1ZDM3Zyd0ZSTEo2SGpoaCs5VW9xSG90bWtTOUUyaTVFek5ITjJm?=
 =?utf-8?B?bGVIYUZjV1dORmcrTEVyWVpxTWNLWk1NK05wdnBVNW1CMlRuK2VueTZ6WVNJ?=
 =?utf-8?B?L2NWSXQ1ZUg0eXdhNnc5dG1sWnBqa2pHa2R5NEVxYUVFV0R6ZEREdGFaVHFL?=
 =?utf-8?B?YmVIMzdNOUtYWllwTEFOV1MvVTNmcGRuMWY1ZGZzYTNVYXViT1hCcDBjM2F1?=
 =?utf-8?B?cnNCNm9Db1NLd1FIdHREbzQ4cXlBenh0WnNMSFRXWlFaaWdwamZTZVpCUE9L?=
 =?utf-8?B?ZVRDMXBjRWREMzZHZEFwOFBJMHJQVHRqK1VrSGtPZGF3cXJZWEZCazYrVFB2?=
 =?utf-8?B?bzRmWFFDMlhjT1JSMDd1ZFp3ck5VTmxLcEM1dTNKM3AvcmJveGpiTy9HWlVS?=
 =?utf-8?B?M0IzelhyRkVqL3FoWXBjYlZsaUYyTlZjOFRsSC9yc09UZUJqVHF2cERTWmJs?=
 =?utf-8?B?bmhESHczRTNiaDhlb05sQ2dTdFdQVWpacVd0MDAzNTh3amFNUnlaZEdnc3k1?=
 =?utf-8?B?elhTdmRNQzljYUxpSlNFMFpaNWVaNDJXczFkOGsvdVhVVXBBVEhqT1JLdHB6?=
 =?utf-8?B?WjNPV1U5dXRTc1RpWk92ajNyOUtPUGViUDQ2OWtHRkwzenU1QkhjSUNzS2lr?=
 =?utf-8?B?a0ZscTdlQXJKa2ErZ2dOYWFIdEtXSzBCTHRGRm13Z0J6NVYvQUlKNW93L3hV?=
 =?utf-8?B?OWcvN2IyK084bUhBL3R3VVhhQUpYUVo5WGtORG50bzZib0xlTE9hUzRNc3pV?=
 =?utf-8?B?UnhVRG9Ib01hdjB1dGRPL2pIUUE0OTdYZ1FGOGdHYzdsRlZIRFdtVC85TGpy?=
 =?utf-8?B?R1FtVWNKZmdBdm1rQmlwdlZObUx5cjJiSDYxRXhBUWNsQ1owaStudmRDdUNB?=
 =?utf-8?B?dWpuS2dnSWhlUXorRVNRWVhDM09NeUl1YU5ORnRZU240Z1paQWxsOHpPZFh3?=
 =?utf-8?B?d2l3cVRHa0x2T3RZUTRuN1p5V0k5S2pTL3krN1FiTk03Q2d3ZUFFOTVSMUVo?=
 =?utf-8?B?dndvL1VxS2tTWGVDTTRGaC96SXR2OEFHbDRaeXRDUzl2aXBiNSs5NEIxSy9U?=
 =?utf-8?B?Yldpb29hM0p4OFRKU2ZIK0MrYmJGektTVHpYb01zYlhzaDAyVnpIUjk0YU9n?=
 =?utf-8?B?VXk0L3U4dlVPdiswcGNqQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTBLTE4yUWF6YjJxbkw0NXYva2ZHUmJVbEZaekVZS1VCL1BkenpZQ0NSckNq?=
 =?utf-8?B?cUxDV0hMUUg2MzNzbm1VVGdrM0prV1VBWEVkR3NoNXRHMjkvSVcrQkt3VXBE?=
 =?utf-8?B?cm1oVCtIYy9Fc3VQSzV1cXYrQXk3N2lWU0J5enNhdnkyMnVCSkI5L01oUzBq?=
 =?utf-8?B?QUhlMWl4QUdMZHNhODVnQVlzSUVRZ0U2RW9ibjladWpnNXJxbFd2cUozWGZo?=
 =?utf-8?B?eGFka1FnZ2pZeXhBVjBlNGJFZCtnN0E2by9wQlFCZkxNQzJxeEdwUElKRy95?=
 =?utf-8?B?R1lTcW5Yb3FGaVhGNjZmOG1MbGc3SllrTkpyRTVTbStzR280QmlaTGZPWmlP?=
 =?utf-8?B?RG9Sc2dscGVJbm5WcDFsUWJibTBsanYzR2tibnExS01pUGRHQVZrcjFWVDBD?=
 =?utf-8?B?LzVMeUtjRVBpTjVwQVpJaXQ1TlBZRVhzaXRTVmRNUjZDaVVBSnk0UTJHd00w?=
 =?utf-8?B?SjM4bXhVOHFNNGtGN2RmOGtNQURvLzN6Q093NjlmamprY1krMEVmVitsV1JC?=
 =?utf-8?B?Vlh1SVlYaFczOUM0djgrTjVPOGN4eXdxeE1CaEJJYkNQbXpRQ2E5eWJNWmpR?=
 =?utf-8?B?VmkycXBmVVd1dVUrTEZ6R21aU1RlWXcwVHVMRWl3UVpEQ2kwVjE2OC8veTVn?=
 =?utf-8?B?QjA3Z3MyL1RzSGpBOWdyazQvWjN0UmNHd1NwdnNLNUJISDJmbVQ1VXUzdTU2?=
 =?utf-8?B?TEtacVcydDZrV3k0TXVLU2FTQ1BGenpnUDBvODhEaExqSkFrVWIzdXorUkwx?=
 =?utf-8?B?WEJTSkp5L29zOGtpZXBSdzNad1BWVGFHWUw3aUhObURHYkxJdGVsVmpLWlVo?=
 =?utf-8?B?U2hqMEQ1ZGxiMjVyRGJqZUJoQmlNeHpqUzZsRWFLdkJITENzYklpRGp3U1RX?=
 =?utf-8?B?dHVSVzRRSi9KUlNVcC9MR2ZBZ3lFMnFSRWFhWWR2WDlicXB3emgvd2VUb0hw?=
 =?utf-8?B?TXk4QUhPeGNrUmpQd2hlbDBCN2hiYnJ4MGRYYTZjd2plUGhBN0loblBsZjhC?=
 =?utf-8?B?aXVUUGp6WWhKMnhBaXQySm5seCs0b1AvMnJBcFY2MkhyUmZseFJseU8xUlN6?=
 =?utf-8?B?Kys5L21IcURlWFFSM0pBUE9aeUk3cUd4ZCsrYXcxejljQkVUZWx6VW1CSzJJ?=
 =?utf-8?B?UGd4ZHB2M2Fvc2JhdFNybERDRlZRV25hN2g4ZVBkMUxUOUZzZ2lsNlZxdEtY?=
 =?utf-8?B?Skx6STMzY2xPR3RRdlpSWldTbEpCY0VDbTUraTBJQ2RrYUlZaDJWTFFxSGxI?=
 =?utf-8?B?MmJZcE9ZcG5seS9PbThEWEdvSlhiYUgrak9iTEg5c2tTZE9vNzcvR3lSSDV2?=
 =?utf-8?B?eThFL2FIcFEzdE12R29DeUFNdFV3SlB3aTF4bC9rYUpDTTlTWkFxUmhvdFdG?=
 =?utf-8?B?bDlGUE81N3l4aUh0LzlSdDFnZko0ZzVQbGx6ZWMxNWljQlpsbHlRUVk4VUZh?=
 =?utf-8?B?N2VCYjJyQmhTSDJQR1RLNFN5KzBIU3ZRa21rYkFyRUNNYUhzQldYdjJxbkhz?=
 =?utf-8?B?TktoZnlBeGpxQVZqeHdhenJ2UnVhc1E0NUFnSkZxanJsK1NkYTFQNHVZdmVt?=
 =?utf-8?B?RW84VkdZdFF5OXJrWmtHYXpqcHhHcGRxYWZjZC80MENnNVF3eDB6UDczYXhB?=
 =?utf-8?B?LzFZc2Y0SnV6dTBnbWZFdzM1R2hGR2xIb0wyeVpOWTBOT2lSRG4vRVB5NmtV?=
 =?utf-8?B?QjRwbEtiQW9TMEhxY1BPSlkxeDhkcmoyWEkwdHpLV2NBN1FwWWRmMk5tVWR2?=
 =?utf-8?B?U0dVZkxabnVrbWlUWFZUQnRLV0ZjMUV6ckpVa2VvRk9odVFZaU45alFNSmg2?=
 =?utf-8?B?OXIwais3ZXBrUG9CNXNWeG1TSmFTVitpWnpzV3FZOWNmU0VpSk5TRk1oZWIr?=
 =?utf-8?B?bmRVTTkrYUVYbW1USlRiYnhISkR5eWF0dGRNS21wb1o1Yy9Bc3hEMmpGNTY4?=
 =?utf-8?B?enpQekNEWWFIOHNqRDNmam1YampxNnNaY2xiVlltSFp3c3c4YVE2cmRmWmRa?=
 =?utf-8?B?VkFKNk1UWXJFOEhubGs1WXcycU8wTHcraFFVZmtyR3BTdnZXOWxNRTB0RFlC?=
 =?utf-8?B?VVJjQnZma1huMmVab1J2QXZ2Uk5GdGFzQ3FSM0U1T1c1cVZQRjM3ck5LclVU?=
 =?utf-8?Q?R6VM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a118f58c-6ba1-495e-b81e-08dd07e2fa04
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 15:09:19.4970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3eA3HyWMFJnqFyzkyZL+DEfIE5Y0Y0j5Oj7/VzEuNYtrNcsQfU1yaxIyc+933Ua2lm7Nfn/FV9+PyI/wV8Swmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696
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
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAxNCwgMjAyNCA4OjM3
IFBNDQo+IFRvOiBBYmJhcmFwdSwgVmVua2F0ZXNoIDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNv
bT47IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+IENjOiBTaW1laywgTWljaGFsIDxtaWNoYWwuc2lt
ZWtAYW1kLmNvbT47IGZhYnJpY2UuZ2FzbmllckBmb3NzLnN0LmNvbTsgZ2l0DQo+IChBTUQtWGls
aW54KSA8Z2l0QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjExIDMvN10gdXNiOiBv
bmJvYXJkLWh1YjogYWRkIHN1cHBvcnQgZm9yIE1pY3JvY2hpcA0KPiBVU0I1NzQ0DQo+IA0KPiBP
biAxMS8xNC8yNCA1OjE2IEFNLCBBYmJhcmFwdSwgVmVua2F0ZXNoIHdyb3RlOg0KPiA+IEhpIE1h
cmVrLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IE1h
cmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVy
IDEzLCAyMDI0IDE6MTUgQU0NCj4gPj4gVG86IEFiYmFyYXB1LCBWZW5rYXRlc2ggPHZlbmthdGVz
aC5hYmJhcmFwdUBhbWQuY29tPjsNCj4gPj4gdS1ib290QGxpc3RzLmRlbnguZGUNCj4gPj4gQ2M6
IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsNCj4gPj4gZmFicmljZS5nYXNu
aWVyQGZvc3Muc3QuY29tOyBnaXQNCj4gPj4gKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT4NCj4g
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMy83XSB1c2I6IG9uYm9hcmQtaHViOiBhZGQgc3Vw
cG9ydCBmb3INCj4gPj4gTWljcm9jaGlwDQo+ID4+IFVTQjU3NDQNCj4gPj4NCj4gPj4gT24gMTEv
MTIvMjQgNzo0MiBBTSwgQWJiYXJhcHUsIFZlbmthdGVzaCB3cm90ZToNCj4gPj4+IEhpLA0KPiA+
Pj4NCj4gPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206IE1hcmVr
IFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPiA+Pj4+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDEy
LCAyMDI0IDExOjI4IEFNDQo+ID4+Pj4gVG86IEFiYmFyYXB1LCBWZW5rYXRlc2ggPHZlbmthdGVz
aC5hYmJhcmFwdUBhbWQuY29tPjsNCj4gPj4+PiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiA+Pj4+
IENjOiBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47DQo+ID4+Pj4gZmFicmlj
ZS5nYXNuaWVyQGZvc3Muc3QuY29tOyBnaXQNCj4gPj4+PiAoQU1ELVhpbGlueCkgPGdpdEBhbWQu
Y29tPg0KPiA+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjExIDMvN10gdXNiOiBvbmJvYXJkLWh1
YjogYWRkIHN1cHBvcnQgZm9yDQo+ID4+Pj4gTWljcm9jaGlwDQo+ID4+Pj4gVVNCNTc0NA0KPiA+
Pj4+DQo+ID4+Pj4gT24gMTEvMTIvMjQgNjowNyBBTSwgVmVua2F0ZXNoIFlhZGF2IEFiYmFyYXB1
IHdyb3RlOg0KPiA+Pj4+PiBBZGQgc3VwcG9ydCBmb3IgdGhlIE1pY3JvY2hpcCBVU0I1NzQ0IFVT
QjMuMCBhbmQgVVNCMi4wIEh1Yi4NCj4gPj4+Pj4gVGhlIHVzYjU3NDQgZHJpdmVyIHRyaWdnZXIg
aHViIHJlc2V0IHNpZ25hbCBhZnRlciBzb2Z0IHJlc2V0Lg0KPiA+Pj4+PiBUaGUgdXNiNTc0NCBo
dWIgbmVlZCB0byByZXNldCBhZnRlciB0aGUgcGh5IGluaXRpYWxpemF0aW9uLCB3aGljaA0KPiA+
Pj4+PiB0b2dnbGVzIHRoZSBncGlvLg0KPiA+Pj4+PiBBbHNvIHVwZGF0ZSB0aGUgdXNiMjUxNCBo
dWJfZGF0YSB3aXRoIHRoZSByZXNldCBkZWxheSBhcyAxdXMuDQo+ID4+Pj4+DQo+ID4+Pj4+IFNp
Z25lZC1vZmYtYnk6IFZlbmthdGVzaCBZYWRhdiBBYmJhcmFwdQ0KPiA+Pj4+PiA8dmVua2F0ZXNo
LmFiYmFyYXB1QGFtZC5jb20+DQo+ID4+Pj4+IFJldmlld2VkLWJ5OiBNYXJlayBWYXN1dCA8bWFy
ZXhAZGVueC5kZT4NCj4gPj4+Pj4gLS0tDQo+ID4+Pj4+ICAgICBjb21tb24vdXNiX29uYm9hcmRf
aHViLmMgfCAyMCArKysrKysrKysrKysrKysrKystLQ0KPiA+Pj4+PiAgICAgMSBmaWxlIGNoYW5n
ZWQsIDE4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4+Pj4+DQo+ID4+Pj4+IGRp
ZmYgLS1naXQgYS9jb21tb24vdXNiX29uYm9hcmRfaHViLmMgYi9jb21tb24vdXNiX29uYm9hcmRf
aHViLmMNCj4gPj4+Pj4gaW5kZXggODI3ZWNmOWIwMi4uMWQxNDZlY2NlZSAxMDA2NDQNCj4gPj4+
Pj4gLS0tIGEvY29tbW9uL3VzYl9vbmJvYXJkX2h1Yi5jDQo+ID4+Pj4+ICsrKyBiL2NvbW1vbi91
c2Jfb25ib2FyZF9odWIuYw0KPiA+Pj4+PiBAQCAtODgsMTAgKzg4LDI2IEBAIHN0YXRpYyBpbnQg
dXNiX29uYm9hcmRfaHViX3JlbW92ZShzdHJ1Y3QNCj4gPj4+Pj4gdWRldmljZQ0KPiA+PiAqZGV2
KQ0KPiA+Pj4+PiAgICAgCXJldHVybiByZXQ7DQo+ID4+Pj4+ICAgICB9DQo+ID4+Pj4+DQo+ID4+
Pj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9uYm9hcmRfaHViX2RhdGEgdXNiMjUxNF9kYXRhID0g
ew0KPiA+Pj4+PiArCS5yZXNldF91cyA9IDEsDQo+ID4+Pj4+ICt9Ow0KPiA+Pj4+PiArDQo+ID4+
Pj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9uYm9hcmRfaHViX2RhdGEgdXNiNTc0NF9kYXRhID0g
ew0KPiA+Pj4+PiArCS5wb3dlcl9vbl9kZWxheV91cyA9IDEwMDAwLA0KPiA+Pj4+PiArCS5yZXNl
dF91cyA9IDEwMDAwLA0KPiA+Pj4+PiArfTsNCj4gPj4+Pj4gKw0KPiA+Pj4+PiAgICAgc3RhdGlj
IGNvbnN0IHN0cnVjdCB1ZGV2aWNlX2lkIHVzYl9vbmJvYXJkX2h1Yl9pZHNbXSA9IHsNCj4gPj4+
Pj4gICAgIAkvKiBVc2UgZ2VuZXJpYyB1c2JWSUQsUElEIGR0LWJpbmRpbmdzICh1c2ItZGV2aWNl
LnlhbWwpICovDQo+ID4+Pj4+IC0JeyAuY29tcGF0aWJsZSA9ICJ1c2I0MjQsMjUxNCIgfSwgLyog
VVNCMjUxNEIgVVNCIDIuMCAqLw0KPiA+Pj4+PiAtCXsgfQ0KPiA+Pj4+PiArCXsJLmNvbXBhdGli
bGUgPSAidXNiNDI0LDI1MTQiLCAvKiBVU0IyNTE0QiBVU0IgMi4wICovDQo+ID4+Pj4+ICsJCS5k
YXRhID0gKHVsb25nKSZ1c2IyNTE0X2RhdGEsDQo+ID4+Pj4gVGhpcyBeIGh1YiBoYXMgdG8gYmUg
dXBkYXRlZCBpbiAxLzcgLCBvdGhlcndpc2UgaWYgb25seSAxLzcgaXMNCj4gPj4+PiBhcHBsaWVk
IChlLmcuIGR1cmluZyBiaXNlY3QpLCB0aGlzIGh1YiByZXNldCB3aWxsIGJlIG9wZXJhdGVkIG91
dCBvZiBzcGVjaWZpY2F0aW9uLg0KPiA+Pj4+DQo+ID4+Pj4gQWxzbywgbG9va2luZyBhdCB0aGUg
VVNCMjUxNCBkYXRhc2hlZXQgZmlndXJlIDUtMywgaXQgc2VlbXMgdGhlIGh1Yg0KPiA+Pj4+IG5l
ZWRzIHQ0PTUwMHVzIHJlY292ZXJ5IHRpbWUgaW4gU01CdXMgbW9kZS4gRG9lcyB0aGF0IG1lYW4N
Cj4gPj4+PiB1c2IyNTE0X2RhdGEgLnBvd2VyX29uX2RlbGF5X3VzID0gNTAwIGlzIG1pc3Npbmcg
dG9vID8NCj4gPj4+Pg0KPiA+Pj4+IEFsc28sIGl0IHNlZW1zIHRfcnN0aW8gaXMgNXVzIGluIFVT
QjU0NzcgZGF0YXNoZWV0IGZpZ3VyZSAxMC00ICwNCj4gPj4+PiB3aGVyZSBkbyB0aGVzZSAxMDAw
MHVzIGZpZ3VyZXMgYWJvdmUgY29tZSBmcm9tID8NCj4gPj4+DQo+ID4+PiBXZSB3ZXJlIHNlZWlu
ZyBpMmMgZmFpbHVyZXMgd2hlbiB3ZSB1cGRhdGUgdGhlIHJlc2V0IGRlbGF5IGFuZCBwb3dlcg0K
PiA+Pj4gb24gZGVsYXkgdmFsdWVzIG1lbnRpb25lZCBmcm9tIHRoZSBkYXRhc2hlZXQgc28gdXBk
YXRlZCB0byAxMDAwMHVzLA0KPiA+Pj4gdGhlIGxpbnV4IHJlZmVyZW5jZSBpcyBiZWxvdw0KPiA+
Pj4gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2NvbW1pdC85MDhmNjFiZWRiMmM0
MGM2ZDg1NmJiZmQ3ZjgNCj4gPj4+IDcwDQo+ID4+PiBiOTY3YTRjYjQ5OA0KPiA+PiBJcyB0aGVy
ZSBhIG1hdGNoaW5nIGRlbGF5IHJlcXVpcmVtZW50IHNwZWNpZmllZCBpbiB0aGUgVVNCIGh1Yg0K
PiA+PiBkYXRhc2hlZXQgb3IgaXMgdGhpcyBhIHdvcmthcm91bmQgZm9yIHNvbWUgYm9hcmQtc3Bl
Y2lmaWMgYmVoYXZpb3IgPw0KPiA+IFRoZSBtYXRjaGluZyBkZWxheSBpcyBub3Qgc3BlY2lmaWVk
IGluIHRoZSBVU0I1NzQ0IGh1YiBkb2N1bWVudCwgYnV0IGJhc2VkIG9uDQo+IHRlc3Rpbmcgb24g
MiBib2FyZHMgd2l0aCB0aGUgYWJvdmUtbWVudGlvbmVkIGRlbGF5IGkyYyBmYWlsdXJlcyB3ZXJl
IG5vdCBvYnNlcnZlZC4NCj4gSXMgdGhpcyAxMG1zIGEgYm9hcmQtc3BlY2lmaWMgcmVzZXQgZGVs
YXkgPw0KPiBXaHkgaXMgaXQgaW4gYSBnZW5lcmljIGRyaXZlciA/DQpPbiBvdXIgYm9hcmRzIHdl
IG9ic2VydmVkIGkyYyBmYWlsdXJlcyB3aGVuIHdlIHNldCB0aGUgcmVzZXQgZGVsYXkgYXMgNXVz
IGFuZCBwb3dlciBvbiBkZWxheSBhcyAxbXMgYXMgcGVyIHRoZSBVU0I1NzQ0IGRhdGFzaGVldC4g
VGhlIHJlYXNvbiBvZiBhZGRpbmcgMTBtcyBkZWxheSBpcyBiZWNhdXNlIG9mIGkyYyBmYWlsdXJl
cyBhbmQgdGhlIGxpbnV4IHJlZmVyZW5jZSBpcyBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMv
bGludXgvY29tbWl0LzkwOGY2MWJlZGIyYzQwYzZkODU2YmJmZDdmODcwYjk2N2E0Y2I0OTgNCkRv
IHlvdSBoYXZlIGFueXRoaW5nIHdpdGggcmVzcGVjdCB0byB0aGVzZSBkZWxheXMsIGFzIHlvdSBt
aWdodCBoYXZlIHRlc3RlZCBvbiBzb21lIG90aGVyIGJvYXJkcz8gSWYgYW55dGhpbmcsIHBsZWFz
ZSBsZXQgbWUga25vdy4NCg0KVGhhbmtzDQpWZW5rYXRlc2gNCg0KDQo=
