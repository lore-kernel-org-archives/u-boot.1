Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257C7CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 15:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58F8B80819;
	Tue, 30 Sep 2025 17:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="mpw18SYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 493D883071; Tue, 30 Sep 2025 17:51:09 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE656800D7
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 17:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Conor.Dooley@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9PEHSu5VG/G4fJ9ZRMBrU4Yal9tIOu/yduK8sGeQPwOdnwwiVMnuhRfIxHfxqEELNerHwKYvJC5T9eHP/6XqWQ7QtN2iZdmYozHe40JeWv5rwYEJryKLC6d79O3DMcnCJRuWt8fOqaVQ5B8EokEzqj4pQV/6Rx0rlIjfdDKx7JTS3lzQiXOCzWFpoYCHPVP2jbULDoBpFBJuIdS5pIMi7SGdxg9Msy/AZSVaOs0pIjD5nMbpsupVu0rxmsFPaJfderHKKQFyTL5VzcMo5hjsmAaWzdjeZQrEEs61sIiIGw11y8TB8QhsPUNzX7YZqEJe8m2o3eoUIVo89FQ+DKIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSfQi75tuWv48uQC5eD+1HCcGgiyf6iS9O75SS9/HmU=;
 b=oKea99NwTpxRi899KS8hc404sugyHP81A5cEKhzbaHr4W2ktTarw/y0cq94XUUpUa/flz/G5pMbCMCDReOIS+KqnjHRUHtglAqk+1ulMXWXcEloVBwhBqZabZdps2XfYx1eoH6HYIcTM2zD6zhNrJQrACrArIcT4TN0N1hpy4c+VXzu3ROcoEcDSrYAy5EDxPQJUrE23HAApuPAyf+hn/3JYnnO948zuH5rjk5SZctyu2jqoTk3tEB3J+NFXSsk0K+mqsJUXUxI32gUB26NW73b4he0fGhdJGdT7LAhF5F36ERtAkuleTrkUAmpZBi+FfcDZdgpy9v2dMQ6aB8FYOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSfQi75tuWv48uQC5eD+1HCcGgiyf6iS9O75SS9/HmU=;
 b=mpw18SYrk/4msSFwxNs0Au78MibyrkUUktWsfJ4RIxdyhcoiQbdsoDqhYxv34WJrQwXRYSjouEgBGx0bEnoVz5uF52O+8LUa/OBBtaXYQdJKEbFhbrqCoL4AqAktHgTcz3LVWhH5f36OjjhAAvLzYsyg024hPsjf+vAInzVohvj9uZaC7pocxVEa20JRvoSXcNO0fPRRvBbHE/slN//oArViR9HejlPP5oAtHYOih9vDkbShlAao55Rzyvybo1JB11eT9dUIJ4TYdFBEQNffku7QcgiRXda43BAVAl8qCk12ewNifRiLHLnaoulrPBsFpf60uXYCeg4XlBaTIEbMaQ==
Received: from DM6PR11MB4282.namprd11.prod.outlook.com (2603:10b6:5:1db::24)
 by DM4PR11MB5246.namprd11.prod.outlook.com (2603:10b6:5:389::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 15:51:03 +0000
Received: from DM6PR11MB4282.namprd11.prod.outlook.com
 ([fe80::da3e:dd0:e4ef:f2be]) by DM6PR11MB4282.namprd11.prod.outlook.com
 ([fe80::da3e:dd0:e4ef:f2be%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 15:51:02 +0000
From: <Conor.Dooley@microchip.com>
To: <trini@konsulko.com>, <Jamie.Gibbons@microchip.com>
CC: <u-boot@lists.denx.de>, <Valentina.FernandezAlanis@microchip.com>,
 <Cyril.Jean@microchip.com>, <ycliang@andestech.com>
Subject: Re: [PATCH] board: mpfs_icicle: fix pointer assignment in
 board_fdt_blob_setup()
Thread-Topic: [PATCH] board: mpfs_icicle: fix pointer assignment in
 board_fdt_blob_setup()
Thread-Index: AQHcMiDJOBM3kXBI00CKAui/dLrTGbSr3xyAgAAArQA=
Date: Tue, 30 Sep 2025 15:51:02 +0000
Message-ID: <f6b35b7a-457b-48e9-bec7-df3e57b9f6ed@microchip.com>
References: <20250930154534.3914214-1-jamie.gibbons@microchip.com>
 <20250930154837.GB6093@bill-the-cat>
In-Reply-To: <20250930154837.GB6093@bill-the-cat>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4282:EE_|DM4PR11MB5246:EE_
x-ms-office365-filtering-correlation-id: 1f371724-2c64-4dd4-4931-08de003928b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?RzFjbWNyS1ZKS1pmaHhQSHlOKy9mcGYyWXI5MnZQNVJNbTlpL0xnaDV1TFdF?=
 =?utf-8?B?bmsyVmlSd0U2VUxHWnZqc0RaQ1FBRVBOT21ROVUzaVgwRGpJZXljcDV5WnQz?=
 =?utf-8?B?OE5SYi9EdXFmdk13cFpnK25Pd0lMeVp3NE9FV1lvOWErQ1BIYkRVdXBqRHFy?=
 =?utf-8?B?NXhIUmRDR1BOS05vdFBSbzlNa0d4dnpqZGJTTEwvVThvVDZLK1Z4YTBnRmVv?=
 =?utf-8?B?Tzd5MTI4b1dqYTBIdHYyRlUzUnJmZHN2cGp6MnRXRCsyVFNmZkFRL2lYMTE5?=
 =?utf-8?B?bmZ4a0JhaFl1MERFRkZySnpTaGdSSkpNRVNzYnJJNzdPUUhpZlNJbitIaHVH?=
 =?utf-8?B?bjRnaGtIcnRzeTZ6TWZIS0xFRGE5ZU1zUmNtVXdwZEpLRldGY2tvQVFUZ05i?=
 =?utf-8?B?RGNEd3lSYU1oV2Y2N1hEK05XVzhmZXhEVTZ5MlFMaFc4eTFUWkYwN2V0MTg5?=
 =?utf-8?B?S3laWWFUWjNUTXdWbHlEN3VYQjF3aUtJditpUzh0d2R3elczcHRrNWhscith?=
 =?utf-8?B?WmNQd3grcENUbGcxS1JHRlNHMllkLzd6Y1BRekRjdmdodHYxNUhaaXVSVzRx?=
 =?utf-8?B?L080dGsyMTBQQzBWQys2b0tsWWhUYmsvMGY1em9wckJzdENiUjRHZmlXNU4y?=
 =?utf-8?B?RDJ2OTZjdWNpZ2NKZkNPdklQdEJCdHp3RnRFWFYwYTBLalMwaVppWUswR1BS?=
 =?utf-8?B?UkxvTFNyODRmczlEalJ0QnkzQkdpWDZlNU5nQXkrdEFEZW5SVUtrSi92cDRu?=
 =?utf-8?B?VGNqdk5IT2l3aXpIZlV3NlpRbHNlaWcyUk1WOTRyQWphakIxTjNDbXFtblBV?=
 =?utf-8?B?MXVxQ0ZsNEo4M25Ock1NaUNXNVZlaHA2QXRBSDNWcDlVVmVhSXpOOU1XZVFJ?=
 =?utf-8?B?WXExMkN1UGFJS0VidXRodXVzaVVBTkJ1eHdNWFgzbUxkZ005WERQcG13dkFy?=
 =?utf-8?B?Z0x6V3ZDVEQ3OXEvUm1oOWJUbHFBM1lTZGU3UHVLazI2VzBVclJlZnB4NWw4?=
 =?utf-8?B?Z3RtQnh5ckJFelIyL2dOR1hmNWt0WjBPcFhHNkovQmwrZWNKRXFFaGJpa29s?=
 =?utf-8?B?SFJYd3hmUlVOMG91MGdZTGZmQm1SZEZxZGg1eE5yMEE5UDd0THhieDBMcGxH?=
 =?utf-8?B?V2V4S2h4d3AzM0lsTjlzaTJtUEp0bnY1cE8ydlNxN1AzekZZandFUFJLQ1hQ?=
 =?utf-8?B?RUcvUFZqZzFVTUVROVhsd2t1Vlh3ZmtTRm0zM3dSVkhVQ2cxSjZMZ0puN2pi?=
 =?utf-8?B?MVFQM2IwU2xuY3dCRlcveFY3UGF5UVVwbko5a0RKY0xBT1pyZUliT243T1pP?=
 =?utf-8?B?c0lPVXFXaTNNSHc4VDAxWGx4RlgxNmoxUjdZN3B2bkg2eG9HNDZWeWs3a1Q3?=
 =?utf-8?B?eEhCY0I3Ym5DblZUZlEzZ1VrUU55eUJqeExOcTlZQk44ejhPUVpVZUN6aVJJ?=
 =?utf-8?B?aUFmRDlzM01XcnZGWGpkT3JudmRCcHUxVVQ0VlpaMlZwcitVRmlVUXBVMUNB?=
 =?utf-8?B?RnNzU2MwRGFubDIvY0t0bURLRks2aUZTOGE0UmZUMEdTcnpMRGtMczdxM1Iv?=
 =?utf-8?B?MTFFdE9TUHpHWm5Obm92NUpkdjlqNU1sUDRFTWpUaklVR2g0S2FCSkI1cmJr?=
 =?utf-8?B?TW5sT3RFVS9uSk10T0ErOWxqM1hmK0s4czEzeEFzK085Vm5KWDFjZmQ4aFVC?=
 =?utf-8?B?Ny9GSko4WXN2OHR1SU5CaFhPL3NMK1J2aUtFSGI5aCs0U1hKZEM2bGY1eEFQ?=
 =?utf-8?B?QjR1WjNuRkU5Yk54YkZtcmdmbndHRUNGbjFNVWFPZysyc2RkZWlkaFN1TDI0?=
 =?utf-8?B?ekU3ZEVHVjhKdFBkV1I0UTNxQU5FSnVoNDc2SVFMSGRORzF2NnI1NlhWRHd3?=
 =?utf-8?B?aVhjK1FqbGR3VVlhUTU3UkhvWDZTbjJtdTJsUnNRWGtTQjdxdkpoWHdiajhs?=
 =?utf-8?B?eHYwcnJrZlhvdVJiTGoxcER4Z2xYbU9kUW9NbXZLVUZoeXlKblNhODdzb1Y2?=
 =?utf-8?B?MEUyOFYzTlpGOGJkcTlsbXNxaVdjc0JkQ1ZiWCtSNFdVTGVCeHVhQ3ZzcUxS?=
 =?utf-8?Q?eXdlgH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB4282.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0FWQjc5TmVVYTI5TUhWc2tHSlJoRDBGNkNJamh2M29YdVFCZGlNNjBTVHRu?=
 =?utf-8?B?NGhLYTdWeGxZalVsU3p1eTJSUzFoWGFuYWpldTAzdEFYeDU0ZHFsblFuOW9Q?=
 =?utf-8?B?ZDBSZHBjYk51SlZKRlV0dkU5MFpTOFFlTmpoVEc5NVd5TlVFYysxeVNEYVFL?=
 =?utf-8?B?ZTk5RDk1WFc5MFZMejFkc0F6NHhsUFlNQTVib1hRQ0NQamQvSXVZM2lFQnJB?=
 =?utf-8?B?R0ZqM3NDTE9USm9YNUlyTnVvdU1UWVRWeE5oWHdJOTY4QlhpSlFhZ2cwYUdv?=
 =?utf-8?B?c2xuSE9iclNoTUgrMFl6bG12TjlFNHluZy9hd2twUDJzSTgvMUNub1VsQ294?=
 =?utf-8?B?RmxSaWpnNmdHeXgwbU51UzQ3akZyMjljcEYxZENIU2grMEpHQmRZQkJQb0Nt?=
 =?utf-8?B?bGx5d08zZ1RPK0Fybm1OVUtvOVdpYmNvaUFVRjB4KzJhQVhoMElQem1maW84?=
 =?utf-8?B?WHBjK0NocnZVeW41aE1KeW1PTmNjb2pHVFBxWVNEVnU1WkwvT3RyVVp2RFFQ?=
 =?utf-8?B?ZEN5ZFRhWTVhQW1vWDNvVzFkRkI2MllXYXM1NHptamxvZ0M5amN5ODRHQldQ?=
 =?utf-8?B?ZzluSlJEZUxXaUxSWDlEYkxjRXFuUmVMOGxpM21VcGEyd0VLcmFMSDFuZ0Qx?=
 =?utf-8?B?RlVUdlZIblVqUGZXQ2FvK2F4ZzQ0c2xFcE5zR3ZUQUJFM2dzOTdnVTN4YjZ5?=
 =?utf-8?B?TXFwa3Y0R1NnZzd2ekdJQVZPdnp4NlZZdjg4Qjh0V2Q3RzcvaEowRGN4QWlI?=
 =?utf-8?B?SHlPL2hmTlFib1RoUCs4d1I2a3pBd2dNc1hoUFBQTnY3ZEdXaW9GRHBtOStU?=
 =?utf-8?B?eXk1Mjdoam94S2NMME1oRCtJWkIzS0tzdnhGY05XSTRlRTlrOFhMZlFrQkJh?=
 =?utf-8?B?S0RlTjBCTlA0QjFGN3J5L29QZDRYUFpnWWRJNkVWVERpU2RvNVdhaDI2czhU?=
 =?utf-8?B?V2VjTTZkOU1SWkZsNzNFRHU0dXdDQnR1cW1EVDU0VjE5bHc0QmpNZDBadXRw?=
 =?utf-8?B?R1dYUDNhSC9laFdjN3djenVldDUxY3JFSFBZcmFDMlFiZHpBeG9sS1ppY0oz?=
 =?utf-8?B?U0xvQ1FsQ3NRdXhFc29ncTlVb3ZNVEliNFhhRDN0SW1kT0RFUVNPU0RadWpU?=
 =?utf-8?B?K05ncythOW10TWtUaW8rNkJOU1BtM2R3bWVJR2VpYVBwT0wzUWdKUW45eUNO?=
 =?utf-8?B?T3ovM0NyNjJZTyt1K2ZwdWVlWGt0RmlkYW8ram1HTVUxdWdzK0VFSGdCVDR4?=
 =?utf-8?B?bGkzOCtrM3VkOFpDUEpLMTZ6MzlsMWs5MGJVUHBzeWt6cldlMXFxTXJ3S2FS?=
 =?utf-8?B?dmFSVWpZWng4amJOTlp5aW1JVjUvRXB1N1krOWVQQlRCUWphYjhBSENmMmdU?=
 =?utf-8?B?MWdNbTNZUkdmckpwY2lZWXpUVktKRmZqS0JxU0Vxa2h2dnNHUTJxYXNhN0lo?=
 =?utf-8?B?NVp1MTFVSFRjMjQ3bTY5OURJT1RjTkl3N3U3ODhFZE5SbWZPdzV2emp6U1Ir?=
 =?utf-8?B?eFQ0aXkvTVZPc29MeDUzVFdGM1dlWlpLU0ZDeUFOc1dJazhLcndtaC9mOW41?=
 =?utf-8?B?TVNVOCtycTZUNmxRMFJWTUpzUitCRWMwb1NIT25ZR2pmSWgyYlhCNHhwRGdu?=
 =?utf-8?B?SGR0WE03VE1nSjltMU5lUGlwTmtVWU9tOVhFYzkzMmk0WUhqWjdJWEUvT1ZM?=
 =?utf-8?B?a3lzSGdPRTZYVFNKUUo5SlYwczNaVG8zTy8xSkt1VVREUEg1UnVkTUxSVFhy?=
 =?utf-8?B?a2NlS1Q2VmRveng1eUlLVitYRzlySlVhM3ViaXJkNmVackkzK3V4Z2NkVk9p?=
 =?utf-8?B?MmdxVWtTVEp0YklzcjZtVzlNdmU1WkROb08vRXFEN3JCNTlySnp2OGx6NExO?=
 =?utf-8?B?dGVmaFRqMmxQUW5VYXd3b1EzNDFjVWtSUnhnV1FTQnA2OURIamJMaEM0VUsz?=
 =?utf-8?B?Nk5jYndYNlBocVZKQ0hNekZ3Njc2ZFNzZXBoZVFwdys3Z1BDQ2cxQ05FWXJq?=
 =?utf-8?B?N3NFNVpzcnhUSDR3SGZYOG93TG5UUGJuV21KTm5Vak5RV1h4TFJCak02RXlO?=
 =?utf-8?B?cHU5a2NJSm0vUzRUMGpmTHh5b21SNEZUVWJEQS91allmcG9aYmtWTDNIak9Y?=
 =?utf-8?B?UWRkSitpeFV2ZFBtbTFkbWIxWk9BQWhDTVFNbDh4UEhwQ3RSVFV4ZnJhTXBk?=
 =?utf-8?B?TzRuVTZ6a21aVVRYOHNuS3pIN3RNdFpxY2QxdjdWdENEUTBkalF6SlBXYTVa?=
 =?utf-8?B?b0dBazdKYlFaaDhrekpOclNFS2VBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA182CA570130347A5DF5E07707ED523@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4282.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f371724-2c64-4dd4-4931-08de003928b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 15:51:02.8823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8hJ1rYYJaMr5aJL1vymHxNGJJYFdUSxAClFPJH5OOv3WUtv9xmS0KwJeuyeacrt2/ii/JWwX+0hZZs/E9bawLkb461I3lWQWe1aysbVOVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5246
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

T24gMzAvMDkvMjAyNSAxNjo0OCwgVG9tIFJpbmkgd3JvdGU6DQo+IE9uIFR1ZSwgU2VwIDMwLCAy
MDI1IGF0IDA0OjQ1OjM0UE0gKzAxMDAsIEphbWllIEdpYmJvbnMgd3JvdGU6DQo+IA0KPj4gQ29y
cmVjdCB0aGUgYXNzaWdubWVudCBpbiBib2FyZF9mZHRfYmxvYl9zZXR1cCgpIHRvIHVzZSAqZmR0
cCBpbnN0ZWFkIG9mDQo+PiBmZHRwLCBlbnN1cmluZyB0aGUgY2FsbGVyIHJlY2VpdmVzIHRoZSBj
b3JyZWN0IEZEVCBhZGRyZXNzLiBUaGlzDQo+PiByZXNvbHZlcyBhbiBpc3N1ZSB3aGVyZSB0aGUg
ZGV2aWNlIHRyZWUgcG9pbnRlciB3YXMgbm90IHByb3Blcmx5IHNldCBkdWUNCj4+IHRvIGFzc2ln
bmluZyB0byB0aGUgbG9jYWwgcGFyYW1ldGVyIHJhdGhlciB0aGFuIHRoZSBkZXJlZmVyZW5jZWQN
Cj4+IHBvaW50ZXIuDQo+Pg0KPj4gRml4ZXM6IDYzYTg1MDY1ODBiNiAoImJvYXJkOiBtcGZzX2lj
aWNsZTogaW1wbGVtZW50IGJvYXJkX2ZkdF9ibG9iX3NldHVwKCkvYm9hcmRfZml0X2NvbmZpZ19u
YW1lX21hdGNoKCkiKQ0KPiANCj4gVGhpcyBjb21taXQgaXMgbm90IGluIG1hc3RlciBub3IgbmV4
dCwgd2hlcmUgaXMgaXQ/IEkgdGhpbmsgdGhpcyBpcw0KPiBzb21ldGhpbmcgdGhhdCBjYW4gYmUg
Zm9sZGVkIGluIHRvIGFub3RoZXIgcGF0Y2ggYW5kIHRoYXQgcGF0Y2gNCj4gcmUtcG9zdGVkLiBU
aGFua3MuDQoNCkl0IHNob3VsZCBiZToNCkZpeGVzOiA3YzE2ZWJiYTFlZCAoImJvYXJkOiBtcGZz
X2ljaWNsZTogaW1wbGVtZW50IGJvYXJkX2ZkdF9ibG9iX3NldHVwKCkvYm9hcmRfZml0X2NvbmZp
Z19uYW1lX21hdGNoKCkiKQ0KYW5kIHRoZSBwYXRjaCBpcw0KUmV2aWV3ZWQtYnk6IENvbm9yIERv
b2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo=
