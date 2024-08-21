Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15801C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 10:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9157388B14;
	Wed, 21 Aug 2024 12:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="jqm8HnG2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D05788B3F; Wed, 21 Aug 2024 12:03:09 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3953588AB9
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 12:03:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Conor.Dooley@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGTSIfYNab+NcZYd+GhYma8zua6KPwcoP2lce2JyUM7T6LteiCTfJg9wb+cVpqqAAz28gDgMn2Em8FJxTQif/8WnSHqRi55YEVgnVUVHmmNEPSrOfL1jmWe71lzcJjCmoAgyOJ4dcxdQw4qPgfO9LV8g94t6+Lp5xMeR2vcoFmouWiGsSgND8W1Sw/wcENSIbFsnA8QvssadFi9hrrxIO45o1yfk50TKus5L6fa+BUMdI9EG5gqcjsAHUkRo4SU8ntz2yRsTINKpPuojjbSVgMyizBj+b9Wlju/GynM2RfPrjj/miz4xfF8smCTbBxMCpPLONSrCqbce9hi3lD/8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5trXp3lB5u8KmFMVx3rFlviufdQrSXSRAQ0lWu1oHx4=;
 b=e7IVPK0K+CqWbXrXT5l63P2wlRPvkylZXLHZJFiwcj7XPgIUQuJKeVqANMIafGBzVFxvVHNgrdABQdyUqjYwKpi2dk3MhT8wHGb1j9DQ8baytZvhNNerNHuOu1ECtvyCjuOTmj302uLxjJqPBFh73KmflPkq6gDW6VKl3c3rcv/+UsdhOxDJ2oJtYIVCrN5UMIh0CgF8eB6AwydBDrDkEuUi5EksrYPjJaEXMO9jk+RDiuI2G3h+V0sAsCZr87SUCIshcQSc0TmO4zNrXHJe0hT0OCdXfW9+itxPfy7kKhP/f6V9uCryfEPw7fD/MmS4dvog5k5EPN7ayfkjngcpQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5trXp3lB5u8KmFMVx3rFlviufdQrSXSRAQ0lWu1oHx4=;
 b=jqm8HnG2JWwEmwFksPII2WERy0C03321Z9lOD4AFCmi0FgLrJoTqOnsPLxUP0ysab9X14pQD3JA/Cgcm9uyvaRydCb827UEY7Da5d9ypK+0q17PcDHolwbQX/fwCvIwbgqKd5ieBntgPR84V5uu9tDun3ILOo5odsIFMAhguf/s9Oo6NOrFNAhIwaf7ptBcTv67NIHkTJfpWEV8RTxxlzepOAwwMeQxVtWkiNuXRF6z3lxWBGpIgOeMQm6WWSab3NDi/rO50IaINgcYRdolyM2nuUIszRzQ6OU4iz3bQ7lE2TdlCsdeoVqApvvktRsG5eWbwchL61k5PcwtStjm3kQ==
Received: from BN7PR11MB2723.namprd11.prod.outlook.com (2603:10b6:406:b9::25)
 by SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.26; Wed, 21 Aug
 2024 10:03:00 +0000
Received: from BN7PR11MB2723.namprd11.prod.outlook.com
 ([fe80::66b9:8eb7:46c3:f39d]) by BN7PR11MB2723.namprd11.prod.outlook.com
 ([fe80::66b9:8eb7:46c3:f39d%3]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 10:03:00 +0000
From: <Conor.Dooley@microchip.com>
To: <xypron.glpk@gmx.de>
CC: <mchitale@ventanamicro.com>, <rick@andestech.com>,
 <ycliang@andestech.com>, <trini@konsulko.com>, <seashell11234455@gmail.com>,
 <randolph@andestech.com>, <michal.simek@amd.com>, <peterlin@andestech.com>,
 <ben.dooks@codethink.co.uk>, <samuel@sholland.org>,
 <dan.carpenter@linaro.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 2/3] riscv: cache: Add CBO instructions
Thread-Topic: [PATCH v1 2/3] riscv: cache: Add CBO instructions
Thread-Index: AQHa8u3xuSk9OpvQDESNwKXBUgSV3bIwDwWAgAFsLACAAAFtAA==
Date: Wed, 21 Aug 2024 10:03:00 +0000
Message-ID: <447d9553-6ca4-4f82-b2a0-4d445a09564b@microchip.com>
References: <20240820093800.5436-1-mchitale@ventanamicro.com>
 <20240820093800.5436-3-mchitale@ventanamicro.com>
 <9b9bde7d-e640-4502-831f-be06288fd9d9@gmx.de>
 <20240821-smilingly-lance-c051e89df945@wendy>
In-Reply-To: <20240821-smilingly-lance-c051e89df945@wendy>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR11MB2723:EE_|SJ0PR11MB5072:EE_
x-ms-office365-filtering-correlation-id: d0ad00f6-a0b9-4fa6-8f9e-08dcc1c87056
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR11MB2723.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MkhmbXlyUFhodGxUclFGejhEd1NkT25KYzBJRlpwMk9CMFZUSENpYmhrbUNi?=
 =?utf-8?B?UWlqcVNjTWtnLzFWOFJwTHlsaXZVVUFFKzRtK25venI0TUd2S05PSnUrL2hN?=
 =?utf-8?B?eVJCZFRmYkVpSTNxRTBEUklYWmZMcXJHVkl3OFN2RWxtMHJFSzc1b2ZOOWI1?=
 =?utf-8?B?UGE0L1NpSmljVEVJVE9EWWNoV0U4VFE5Smd1OU1LaUdjbGNKV1IrdGVnL0h3?=
 =?utf-8?B?QkJteHYvY2FnSWx6RkdmRXpkYlVtRE1hSUJUSGxnc0swT2tjVHR4V3NqZUhm?=
 =?utf-8?B?U1RoZ3pTN3BLcmRuZzByck02dldKOUV1dXNHUG9wazZJZzg2R2kyU2s3V01G?=
 =?utf-8?B?WjhyZm1rZWRwN0RnZHVxTzBRWE41eE5Wa3piallZSzUvRXlTU1JSVTJoL2xi?=
 =?utf-8?B?VlRiRlBHT3d4UDVaRnk3TDg4Nmo1cjcxVEhWVUE5TU5JQzVlaGZmYXJtczZt?=
 =?utf-8?B?eDVac0s4SHdXZGZUMEhXcDU4dU13T0d2TzNDSHZTUmxjdmUwUkg4ay95RzJH?=
 =?utf-8?B?blEvd1NSVU9Gc3VsNGtRNmJTS2E3SHB3Z1A2WUhGNDR2VzBrYjE2a2pseENk?=
 =?utf-8?B?MVppNm5UWUdndDZOYTlLcEZOVTgrMlcyMjJCb0FEUHlSQWM0R240ZVdCRjZs?=
 =?utf-8?B?bWlobW9XbWV6bXBYdzlsNmUrSGRsU1VJQmtxWGJmU2U3WGpFenhsNXp0dFNr?=
 =?utf-8?B?RFdTYzlrRzEvSnZOZzdWa092V0lEYUpNQTFNbVI4WUQrVTFzT1lEdkx4cDZi?=
 =?utf-8?B?M2dBVnVTbXlGL3h6VjhmaUdKRUFHV2lCbXliVGltYk5KN0w0M3ZqMnRHZFhP?=
 =?utf-8?B?L0tPdU03OTFuRElUTUYzNlNKU1U5UjZydVd4VjVzVmhDRlBzQ1NPRHQyNlNz?=
 =?utf-8?B?ejQxaTVHSDJ5RU16NHpKMmVZWWk5ZkdMRkZxZDN6Sm1YQ1RrUlhPWW1tYVlx?=
 =?utf-8?B?QVVxamVjb2wvM24vTE9ocEk3VDBMano3Y08zNWUyYnNuTWFNRlBmUXltdENp?=
 =?utf-8?B?YllwVjhyK1hRaUE0REZ6c1lPWVdXa3FKMDhTS1J1WnpBamgxYzBFN2o3TnRx?=
 =?utf-8?B?VHM4K0x0TS9YNEdPdHpMelYxU25VVktBUFdXSmEzRFdoRnV2L3V1L1BrM3dY?=
 =?utf-8?B?d242S2dCZUJkUXZ5cnovQXVESUd6KytPNWhiaU9mY2gzZHpyRXUyYnQzTUt6?=
 =?utf-8?B?NGVTODRjZ0thTXN4TUJUQ3g3OVVGMVBDbmZHWXRzWm5XbGZRZWY2c2F0UVpT?=
 =?utf-8?B?UTVOWE0rT3hnemxGYS9lR1FTRFVNMXA3Z1plQURPOUdZNDAzaFpBWi9EMHI3?=
 =?utf-8?B?THhKS1N5S2p6M25JSVcvSkpEcmZJbDAyVUE0VGkzVU5ESkc0ZjV6V20xeDVD?=
 =?utf-8?B?N09Gem1Hd052Y2NvYmpRLzFuZVJxSzZDcU1qdWIvMktFY3JCUm93cnJhakRO?=
 =?utf-8?B?ZmpzelRrRHdFaWsrc09mY0YwNVlHcWR5QlRneEdDeklFL0VYRTlpN3JpcWx0?=
 =?utf-8?B?aXg0SERGQTV3MkpTS1JlT2JtbTZSZ0tiUHJsRTg5WWpXNmJOKzN5S0c4V09t?=
 =?utf-8?B?SnhCNytiUmhrdXBZY0ZHSjdjays3REsvckI2NUxDWEp5WVkwUmVtM0xBNlRk?=
 =?utf-8?B?eHArY29xTHlBOUMvWnlibmlkNG40emtLNW1hWFlLMWkvN2VsWTNnakhtSjND?=
 =?utf-8?B?TXNyUjluVlR0ZlF3UkdHTzdzOThCU1FCNG84ajJMZ1o2ckRUbFI0V2kyNzla?=
 =?utf-8?B?SHhob2Evam5rUmp2Y0NWZEtBVEtsSHhNVGpxd1J4Ukh5Q0xoUTF6UXE3VUZp?=
 =?utf-8?B?UUpmRFVTVGpwM3NJc1JYcnZuN3JmV1BPMitrSGgxdU84M3JKaWpNMDE0MFVU?=
 =?utf-8?B?ZWF0eTRibXNUbnVuWkR0dGZQb2h6bmlnWGRLaXpGR3lldnc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWoxMW16NGFOYzQvdlhBdXNVa3V6YW5PNHROT1JpN1NPTFZ5c1FQeEZGOTUx?=
 =?utf-8?B?QUJEa0lsRkZqN2lDWEw2akI2amx3Tm1LaVAwQ2VyY0ZUaGE4WUFZWHEzSzJ1?=
 =?utf-8?B?VWM0VzhMN1FKaDVER1RWYkxkY0FLK1ZhZFhuaTAvZnJIbStZbHV3VnVGSzJ3?=
 =?utf-8?B?elE0UWVQc3BqeXZRbkRXazZ3YnRYcERSV05XMFNiK0V6UUpwNVBsd2UvbURG?=
 =?utf-8?B?WlZpMWd1L3FmWFBsS2k0R2x4eUJ5NjZtbUVIZTcwNlJFTDB5RHh0aDE3UG1Z?=
 =?utf-8?B?bTdYRk1nUFlXVW5XVkRTNmxMNE85UmlpN1ZjcndVUkkwZmJBYUdTKzEvOXRD?=
 =?utf-8?B?RmE3Ky9WUE1wQUovc0VtQVBFRVVwUWVoK0R2amgvN0ZwT04wdlFsNGpkVXdx?=
 =?utf-8?B?ZFZIK1BxWlVwa00rVXoyTmNxSkxNejFUaFI3MENzeEN6SUFjT0wxdUw0alJs?=
 =?utf-8?B?R2FRMWhCdnNGTURNZUE0QzFGTE5qZnAvUEdQd09OUzQzWVRMeWZ2RERVSFdt?=
 =?utf-8?B?QVdOUGZNRzJsai9UWU84a2N4cXArZEdxT3JXbkxQL09Mb2F1Z3NBQVVLcFNP?=
 =?utf-8?B?OUhicmNoQW04aXozRnIyQUtnS2tmc1NRd0tQYTBUbXZxZkVsY3ZoMDkvaHY3?=
 =?utf-8?B?Z0ZuaVk0a0k3d3pWSDJ4ZWtCZFlNNElBbCtvdDFiTmZRNmtqM0lndmV1NXNj?=
 =?utf-8?B?RkRNemFxZW5IYURRejd0M1N3QzZtVktOcnphdW1DVHpBZHhJWHpDTkR1bkpZ?=
 =?utf-8?B?M3B3NFI3aFo5dkhrMkZBbUYwMFlyZjc5d0kyUmNlNlp0OTlvbXpoQzIxUXA3?=
 =?utf-8?B?KzBjUG4rV2poZSt1bWR6UU5TeE5mWVU4eldVNUZyQk9mYnl1M2w4YTNlaHcw?=
 =?utf-8?B?YThqVG5OVlI0Y2tBaFVFTXNVOWlkTkFKTHlXcUhJVEVmM2VTbjIzSHg1d0pO?=
 =?utf-8?B?MndMOHpRcFJsN2RxMUVrc2hjTnNEZzJQMTBqUzFXUzROTFl3azMreXVwU3Bk?=
 =?utf-8?B?RjFhQ1RNR3Q1dTU3MmVvcGJMbFErZ09iUU90ZE1ZSFRSU2k4aFB1YjBDd1Fx?=
 =?utf-8?B?b21jalRjMGVMOEtiOGVSKzZkbFoyN1UrdlM4OWFia2hUY1RQZlZuenVPeHdF?=
 =?utf-8?B?ejRjRnhlVkF6RUtNdVVUVDZRQXEvVzlPNmRncWZFNzduSS8xS2hvWFJoM01z?=
 =?utf-8?B?a3VDTlB2RUtRRDN5MklSZTF2NVkwd2FybUhWMkNIbDhvRlBuZnpxMnFnRWNC?=
 =?utf-8?B?SEpKU3Riam1uNDNNWlhkbzh4K2syYVQ3V0oxYlBqMXp1MWhBQnRsUmZZc2I1?=
 =?utf-8?B?bk1UR2dqREFUNU9TTEFORFNESGtTSlVUazhyVThhMTdrenFtTGtEUGthY1JK?=
 =?utf-8?B?b01SaEgweENTVnk4TGlXRmxpQmRteHVZYStrVlNRRzloMzkzWW5VUndQMzBj?=
 =?utf-8?B?UlExcmhSbExLWmNzVGwrS1EzQjB5alNBNU1TZzI2eEZ5cHZ1Nmh5eHVMdE1U?=
 =?utf-8?B?SXgrMC9uK0VOTjZPS1JYSlFtdmY4djhFSXo4ZWFHZHFDWC96NmRadVM4cDJs?=
 =?utf-8?B?VUFOVis1Y2hqMktOa081czNwSzBZRlhMMDRPeW0xTjFURHBJVmJhMG01Mk9l?=
 =?utf-8?B?Q2djdWo5N285WVNrVko1Kzd3elYxWUtaTE96WHRGYlNLWERzSll6WGcxUENY?=
 =?utf-8?B?NDZDRzZUaG5UNjZoVmM3ekRFcXVPNC9taXRGYVAybVBlN2RKMWJpMHdiSnVz?=
 =?utf-8?B?cUV3Vi95SngxeVZBOSttd0oyU0lLK2dieCtpWVdNRnB4RjZyOWFIdTUwSDBi?=
 =?utf-8?B?TUxjVlBIOU96dy9IbU9FUktwZlFDSGxjYm9HM0t0a1crajRxTzBVbnViY3lp?=
 =?utf-8?B?aENtQUlsd1I0cndWa2pGdzcrR091N2JXYVZ6UUJtdUU3eVhWMlBlcVlPcTBU?=
 =?utf-8?B?TDZEYm5palRWQlU5RjNORnJNNDZyQlk0R1VCSWo2RG1ZOVhRYk5VR0NQbE1G?=
 =?utf-8?B?V0lsdHBSQUJ3UXBtTE9KNlVFOG82dDlyMm9ua1RpVm03eTdNVFBxckhjaFJh?=
 =?utf-8?B?THF1Q3pRV2pVcFBtbWVZY0xCM2FZNkNqaVhJN2JHUk5mY0w1WlAvcHYxcTBq?=
 =?utf-8?Q?O5CwKjMK0oMovIlwZMRiodDeA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFC0911CCC7C0144B44460B154017C63@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2723.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ad00f6-a0b9-4fa6-8f9e-08dcc1c87056
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 10:03:00.1791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epFuzS+YUXx/OXadV83+bx6H8wUaa1F/8ZT9iHQiqPWanLpnhOv4i/+b9jitTOcBKyXdOVkoSP/o5u/ksPcBWRfd6/b7Ok+s6ITFo49KUak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5072
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

T24gMjEvMDgvMjAyNCAxMDo1NywgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBUdWUsIEF1ZyAy
MCwgMjAyNCBhdCAwMjoxNDowMVBNICswMjAwLCBIZWlucmljaCBTY2h1Y2hhcmR0IHdyb3RlOg0K
Pj4gT24gMjAuMDguMjQgMTE6MzcsIE1heXVyZXNoIENoaXRhbGUgd3JvdGU6DQo+Pj4gK3ZvaWQg
cmlzY3ZfemljYm9tX2luaXQodm9pZCkNCj4+PiArew0KPj4+ICsJc3RydWN0IHVkZXZpY2UgKmRl
djsNCj4+PiArDQo+Pj4gKwlpZiAoIUNPTkZJR19JU19FTkFCTEVEKFJJU0NWX0lTQV9aSUNCT00p
KQ0KPj4+ICsJCXJldHVybjsNCj4+PiArDQo+Pj4gKwl1Y2xhc3NfZmlyc3RfZGV2aWNlKFVDTEFT
U19DUFUsICZkZXYpOw0KPj4+ICsJaWYgKCFkZXYpIHsNCj4+PiArCQlsb2dfZXJyKCJGYWlsZWQg
dG8gZ2V0IGNwdSBkZXZpY2UhXG4iKTsNCj4+PiArCQlyZXR1cm47DQo+Pg0KPj4gUGxlYXNlLCBy
ZXR1cm4gYW4gZXJyb3IgY29kZS4NCj4+DQo+Pj4gKwl9DQo+Pj4gKw0KPj4+ICsJKHZvaWQpZGV2
X3JlYWRfdTMyKGRldiwgInJpc2N2LGNib20tYmxvY2stc2l6ZSIsICZ6aWNib21fYmxvY2tfc2l6
ZSk7DQo+Pg0KPj4gUGxlYXNlLCBkbyBub3QgaWdub3JlIGVycm9ycy4NCj4gDQo+IEknbSBjdXJp
b3VzIHdoYXQgdGhlIHBvbGljeSBvZiBVLUJvb3QgaXMgdy5yLnQuIGV4dGVuc2lvbiBwcm9iaW5n
LiBJcyBpdA0KPiBva2F5IHRvIGVuYWJsZSB0aGUgb3B0aW9uIGZvciBaaWNib20gZXZlbiBpZiB5
b3VyIGhhcmR3YXJlIGRvZXMgbm90DQo+IHN1cHBvcnQgaXQsIGluIHdoaWNoIGNhc2UgcmlzY3Zf
emljYm9tX2luaXQoKSB3b3VsZCBiZSBleHBlY3RlZCB0byBmYWlsDQo+IGdyYWNlZnVsbHkgYW5k
IG5vIENNT3MgZG9uZT8NCj4gU2F5LCBmb3IgZXhhbXBsZSwgeW91IGhhZCB0d28gdmVyeSBzaW1p
bGFyIGNoaXBzLCBvbmUgd2l0aCBETUEgbm9uLWNvaGVyZW50DQo+IHBlcmlwaGVyYWxzIGFuZCBv
bmUgdGhhdCBvbmx5IGRpZmZlcmVkIGJ5IGhhdmluZyBETUEgY29oZXJlbnQgb25lcywgYW5kIHlv
dQ0KPiB3YW50ZWQgdG8gcnVuIHRoZSBzYW1lIFUtQm9vdCBiaW5hcnkgb24gYm90aCBkZXZpY2Vz
IHVzaW5nIGEgZGV2aWNldHJlZQ0KPiBwYXNzZWQgZnJvbSBmaXJtd2FyZS4NCg0KVG8gYmUgY2xl
YXIsIEkgZGlkIG5vdGljZSB0aGF0IGlmIHRoZSBkZXZfcmVhZF91MzIoKSBkb2VzIG5vdCBwb3B1
bGF0ZQ0KemljYm9tX2Jsb2NrX3NpemUgbm8gY2FjaGUgb3BzIHdpbGwgYmUgZG9uZS4gTXkgcXVl
c3Rpb24gd2FzIGFib3V0DQp0aGUgYmVoYXZpb3VyIHJlbGF0aW5nIHRvIHRoZSBjb25maWcgb3B0
aW9uIGFuZCBvciBlbWl0dGluZyB3YXJuaW5ncyBldGMuDQoNCkNoZWVycywNCkNvbm9yLg0K
