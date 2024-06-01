Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10655C25B76
	for <u-boot@archiver.kernel.org>; Sat,  1 Jun 2024 14:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0318B88193;
	Sat,  1 Jun 2024 16:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="h0ZDPDvC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CBE3881DB; Sat,  1 Jun 2024 16:23:31 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13D8988193
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 16:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=elena.popa@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBrVYx8baV0qIwAZw6EXwa0xGlW9u50gN6EKXuLnSTdaCbavrztO32h3QQCiFDaaM5EaqkJV6s5emB52pik+1+VUWP1VTCt68F+0GgQfa12KXfY+of4Gu37BFIRvs0CILt/rlfmYjmsbizwTZkpJT5SHFQXUQ7OhTkOrQjdw97NSGEgBZvIA3Fjd3SIkPMhsUOeFAoXr0hcyCv6bG/CGb8YaQ6mIsHoeilJDVRuO0V24Tadva6ft9Oxz2AeiammUlhS7sVv9Fc7g0fry2nxOqF+pM39Vz1OPzvfXj/+wDPtQupIaE6PcHuXJtOrV5BwNQ1pNX2qttVEebrGzausCZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eUWBPQTUXp66gAlaL0Un6Jx2WdyO6CxABl9OxjYEeo=;
 b=WcCm3q6/D5urNpR9UkWObAf5Hj9r9EJ1Nq/sHsoctqQ2Y2Z+IcvriC9Rk6wGWqixMp8EZo8IMnCX5HyhNCBatGz/wlH2wIm3DpNfGnHCDv9KsWXN1+UQFhld7hV0lBYbvQMSeimtUYCL9bxaUg8jvXQj3nwgOjvojJ3E36XG5qLthXYiRyFbPO7Qwy4oWDYY8S2mrmYj6H+epkihQ+Usf3xO2d00uLlKorrIHrHvXLVT8fIrUqk/NFkcxG5H74ELC+uQIqBjG/boR5y+QS0V2QejlFLq6NJTIRywkJ830zK5PmhEJFUK5PmkVZJQb8FLfPECr3gvg1CmQ4w6I99MPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eUWBPQTUXp66gAlaL0Un6Jx2WdyO6CxABl9OxjYEeo=;
 b=h0ZDPDvCugHpX3XQtucYNdnDBsSGlKpo4V+RlNIYV/mLtD4o39iNRODiXN25wij0YGOmj+oSe8sK0de+kbpoy9P9VPpl+rYzu7sOgtZQum/Nd8yxhOlSEc97/xOL8mruP0b6AoML+vFWqJJA5cUnvUmzKCMv5GhNgui1QkV39XU=
Received: from AM7PR04MB6968.eurprd04.prod.outlook.com (2603:10a6:20b:dc::13)
 by AM0PR04MB6865.eurprd04.prod.outlook.com (2603:10a6:208:181::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Sat, 1 Jun
 2024 14:23:27 +0000
Received: from AM7PR04MB6968.eurprd04.prod.outlook.com
 ([fe80::31a7:17e5:a4e8:ef5f]) by AM7PR04MB6968.eurprd04.prod.outlook.com
 ([fe80::31a7:17e5:a4e8:ef5f%4]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 14:23:27 +0000
From: Elena Popa <elena.popa@nxp.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>
Subject: RE: [EXT] Re: [RFC] usb: xhci: Some USB devices fail to initialize
Thread-Topic: [EXT] Re: [RFC] usb: xhci: Some USB devices fail to initialize
Thread-Index: AdqwWVW3P9w5ugCBRoKUpk8i6qFE+AADGHsAABx7kSAAmuvoAAA6tSAQ
Date: Sat, 1 Jun 2024 14:23:26 +0000
Message-ID: <AM7PR04MB6968EB78F957243D25BDD80890FD2@AM7PR04MB6968.eurprd04.prod.outlook.com>
References: <AM7PR04MB69685A41537BA13AB3D32C7590F02@AM7PR04MB6968.eurprd04.prod.outlook.com>
 <a00e3b3f-2248-48a6-ba48-544ac09f2dc1@denx.de>
 <AM7PR04MB6968BB208B38C3DA9F11B9D890F12@AM7PR04MB6968.eurprd04.prod.outlook.com>
 <9ef2b0f0-13b7-4caf-8f99-7803dffc2afb@denx.de>
In-Reply-To: <9ef2b0f0-13b7-4caf-8f99-7803dffc2afb@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB6968:EE_|AM0PR04MB6865:EE_
x-ms-office365-filtering-correlation-id: 0dbb5170-d76d-4599-18b8-08dc82466737
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UE9tRTU4aVpuZE9vaTZveXIxZ1MybnlHUEpIYnFBZXRVWVZkNDh0TlY3eW1R?=
 =?utf-8?B?WnhjN2haaWh4bUZ4WGFQekhqenVEdHlIMkJ5M051MjBjT3RpRkROYlJoMmVD?=
 =?utf-8?B?RnBpZEhST3Y5aWlvYlFJSEdQV2NZc21HZXZkWDc2K3B0Uis4aDRzVmRBUFVX?=
 =?utf-8?B?UDU1c3RSbnZvdW9Md1RaeC9jZGhlcmpDOEQyVkdaR1o3T1dqT0l0S2oydFky?=
 =?utf-8?B?N3ZkS1VVQU1ZUDVzY29yZTZZUUdQTVpETlpiM3lqcWR5QW1HVlg4eXNJQWdv?=
 =?utf-8?B?RFBrYzEzMEtnQ002TzV3UmorNjRVVzRkYzB5eUVJTTBpTTlBdEt5dWFWYS9k?=
 =?utf-8?B?UWo4Ylp4ZFFObG9Fd3RySndoTDNqVXpzeStTRnlsdzhDYkpob2g0SjBZY1cz?=
 =?utf-8?B?eHR4emd6bXFvdDZCU1M3dHpxKzZRNWFFZmtJRmxDYWpxQTliK1U0RGQ4NU1C?=
 =?utf-8?B?ZGdtbFNpZnd3VVhRZWkzaC9kaVNqdDVSWUd2QU9zVGI2K01nN25udjIrSE5z?=
 =?utf-8?B?Q05VN0hiaUlkT1hzRmxwTkRRa2dpaVBaZjFxdTE3ODNtSndzaDl0NHpkTEs2?=
 =?utf-8?B?cGQ1Uk1SZ0kxT1lycG11UVFpbHlmWW5wY204Nk1ZeVlqM1RkM1N3ZEVSZm9k?=
 =?utf-8?B?V3Y3RFdDWDVDY2JUY0wrWDNNdE5TWnZ5TkVUUSszV045TTRudGpTSnU3UTAv?=
 =?utf-8?B?UE9aZ01Tc215TGo5U0h2Vyt6NVRtWFZmbW02WHhmMERwdm9INHFCZzRkZ0JW?=
 =?utf-8?B?MS8wM2x0ZHlCSExmVFB6alN4OXhZNjBQRDZkUHNNVzFDaUpmZm9RckJBeWlp?=
 =?utf-8?B?eDNDZndZRDgzM1NSb056akNldkxaS1NQaFNkaS9la3VGWWVyY1hPUUV0dVY5?=
 =?utf-8?B?RFVhM1F1Ritqbmh1Ulg0UmVzWHVzdTNaQ05US3VLcE91QnRsSXR6MWdmKzBK?=
 =?utf-8?B?dG1WK2MveTg2MHQzbldiSTkzTzdvU2paQUU0dVVRUjBRUEdzK0NldzhzOWRv?=
 =?utf-8?B?UHBYZlJ4cG9rNG82QWtNT1ZLRklLaDVZbXgxMGowN3gwNGpvNXV0eEpTak96?=
 =?utf-8?B?Qkp0RFVzZ2Z3cjFJbGsxVHVhU253QTc3aUQxelF6ZFExQ1hINWYrazZwN1FX?=
 =?utf-8?B?SGFLczA2dVVxdms2VXdrTzA2dEViTnpJMlJleUd4eWg4TnhhMFlxY1dwL1hT?=
 =?utf-8?B?VmJrenorTUhGdUdWL1gwSzFyQStYWW5od1o4VFdQeWVqVmxvZ1lEZHR0ZW9J?=
 =?utf-8?B?SVVHeXM3YTQwQXFXWFlQQ1IrNlZWVDdoU1NPaVFtUXp2TWJaUjd2K01yeXFQ?=
 =?utf-8?B?WkdEYmtjbzlhb21ndGVhN2UweENuVm1xQ2JpNXJTbnBuYkVJMjQ3VmJ3WHBl?=
 =?utf-8?B?NC82Q2d2MGROak55RjYzYkhMY2Fyejh0WXBQdDl3NmpVM3FDSlBNVkwwUTZO?=
 =?utf-8?B?RmNhcks0a3pFWjJCcDdRRFVOVG1uV3JuR2FtdnpjWWp0WDMvMVpkWVF5d1Bt?=
 =?utf-8?B?QjcxM0ZUd1lwZnRrV2dMaWZ5bHI4K1F2MEhTZzhhZVI0RkpPazhWazZkUXV3?=
 =?utf-8?B?NGtvNmp2YWJJclFqSFp4dnZ2NWF4a1Y1T2ZTR2JnVVdXc3hUeTROT2ExMEFG?=
 =?utf-8?B?N1NqNy9QNi9IUFVZWXBxdERIRUlzTkJhdEIzZWk5anl4TU8wdzg5OWV6ek1H?=
 =?utf-8?B?SHZ3d1FpZXlhOGpHbW5YSllUTExRd0dZYzF1ZUxPTFZrNGRsSTJNUzhidEs5?=
 =?utf-8?B?UzJwR2VBRVJRNjYvekdzRFREdkppeFpoZTBqQ044dmlVbXpzeFNrR2YzUlZZ?=
 =?utf-8?B?NlR4TVRnRnkzNURIMlMyQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB6968.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGEzWTJrVnZ6Z0R2QVI2c1BVb25iaE5zbFptM0JUc21BYm1FYnFQdHF4QnlV?=
 =?utf-8?B?d3lpQ3hXU2hWWHRud21SYytoMDR2UWUvclBzUTYxU1ViRHJuQ0IwRmpuL2gx?=
 =?utf-8?B?eU9oQlZtQVRIVUZwMGwxL1F5cXppc1BvMi90Z0tmOGR2UTRXOVBtUnFGZmVV?=
 =?utf-8?B?UjZsNzYvRk9KVXplZTZsbEpaanl6T2t2NVNBU2tMblJMbUJzN3YyVGdtdjZ0?=
 =?utf-8?B?Kzg0emwyNlV3N2xSeEhKalRyVlh1dDZSU0hkajY5L3l0SHZmTUVXN3o0YzBG?=
 =?utf-8?B?eG92UktLaTFsVXNBWmFoNHlZelVWL2t0eE11RWlKMENRRytkRGRndlJnUEZx?=
 =?utf-8?B?TWI2YVRDcEtYZ0g2OXM2SXhHa0FkS0pSd0lYUk41Qm9vSWJsYmVhenh2bW1o?=
 =?utf-8?B?VlN5aVFRYXU2YmRmMzYyQ1RVc0xkRS9MWFFLSVRmaWNGMDlaelRVdjROemd1?=
 =?utf-8?B?bDViRFNOUkRNZjZlQk9zZnpTOWtweUh3QXR4UkZrbmhSK3Q2U2VZS0FNWWtH?=
 =?utf-8?B?WmNkc2JBaGNsUUtGTGliSU9ZRTNnNDZFakkxbXlmamxqWlFxb3lZZ2VvTEhZ?=
 =?utf-8?B?T3B5czAxWXdZeXkzU1hSK2RXbW1GU2RjUTR4clJ0bXJuQzN2bzR0RjB0dnMw?=
 =?utf-8?B?aE0vKyt4STV3TFpsYWc3ZjN2d1NJVlY4Qk9jb2NKVnNiS3htR0hDUjBWZ0Ro?=
 =?utf-8?B?Q1NONW05TWpzMWt3QmVaUGVyZXMzL0h6OGN3R1lZSDZyQXdsK3hHVXNoMXo4?=
 =?utf-8?B?YVBhdHZYcGl6OTM1TG56ZXdPTGdjUG8zU1E5S2d3Q3ptRktMU0xXNE9DZTNP?=
 =?utf-8?B?cTBGc1pLRjFlVXdCODZVQ1VzblBNbmJRNFhxVmpOdHQrWmtBa0czYkp3T251?=
 =?utf-8?B?VTFsUkhOSmRaa0VBMlA2MHRkTnV0WDRGQmtaQmJwZ3VVNXd1S0ZNM2tqRTly?=
 =?utf-8?B?c2VMSVl0azMvVHBLb3JRUWxoMjVuclE3NGJkRmd4aXhidW44S3A4d2NCMnkx?=
 =?utf-8?B?dGFKWlFxcjRIcm9XVFptZTg2OGJpU2dxNDJaWGJNYUNPN2IwZHZGc2ZnMWhK?=
 =?utf-8?B?MzJNS3hNUzNhYVlYQUVqNm1xZFhxRkphR0NINXUxWnFCZkNkOXJYRy9la1pm?=
 =?utf-8?B?VFg3ZDl2UDZtQ0sxZXdWUTNFOTZrbnBmZnRwZUhXMWdSZHdLdnR2THdpaVRT?=
 =?utf-8?B?TDRpczU5TlNNbEdjQUFXMXJhUUVXY1lzcVhkNlNxcWNzSWxUMEF6dmpkR29w?=
 =?utf-8?B?VE1kVXpZeUp2WWJTWDYrMGR3OGluUFBEUi8ySzlhenRiWXpMZHorYTdZWTE1?=
 =?utf-8?B?ZFFmRlFScXhReDNRWFZqSkozYjNPTVY2azY4Q3F0NmxYelFKRUdqejIrMUpv?=
 =?utf-8?B?UFM2eUYzNWNRRXlZajZxS3F1aTRnWkp6ek90ZTZJdVp0ZzBmSTBkYWNUN0Ey?=
 =?utf-8?B?ekI2UmFQak11d3ZoaWhRMXVwM0NpL0tDc0pNZFlGK2VXanBPTGpNbTZLdHE0?=
 =?utf-8?B?R2xPREdhSFlvMFFzbXJEVE0xMVZYVmdpUldZS2J1NFBPaHJwekFLdTVtZDdL?=
 =?utf-8?B?Y3o2TjFOZkdTMmxKNUdsanp6MVZrVTJIT3BJR2pGdnZha3NoSy8vVENHWHhx?=
 =?utf-8?B?aHhYc1BUVFJOZlRSVkE2ZVozcitlYTJWdm5RdGQ4bGM0eWZDU2QwQ2NkTWkr?=
 =?utf-8?B?emg0VTVRc1c1QnhrQU83UW9wejdvRDlDamFFR2M4WmJyNEl2anJrRmdyY3hL?=
 =?utf-8?B?SWtsZkFEejFvM0ZSMUJxSkloSHljSzhwM0IwMkJPU2MyWjNsSzRWODJ1cVp2?=
 =?utf-8?B?NmRaWDBsTFpSRUdOMTlmY2M2RzF5V2k5T1VsS2M0cEw2a1d5WHJQd3RpamhO?=
 =?utf-8?B?RStScGRKR0I5K24ydjFiVDhnMG9uVDZTTGgrNWpxT3d5VW94eGJYSG50OTVU?=
 =?utf-8?B?UXhyU1JWWnp1Y0JEUXZrWUFlZlc4OHorM25RNFVNZ05aeTcrelpzWjAzNlQx?=
 =?utf-8?B?QWxBUlF6VHdNWHdwYTdBcUk4cG9qeHNpcGRJcVNBWXd0ZHlBQVdEVXZPWEl4?=
 =?utf-8?B?ajA5a2JJbnRjM2FaYTN2RGtWUFFZOGFnVGhIZGpNcTVhTnQwK3BnNkNlSWpw?=
 =?utf-8?Q?UmfttfV3cL7o7A2a12UcbUkK7?=
Content-Type: multipart/mixed;
 boundary="_002_AM7PR04MB6968EB78F957243D25BDD80890FD2AM7PR04MB6968eurp_"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6968.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbb5170-d76d-4599-18b8-08dc82466737
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2024 14:23:27.0632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLFQM50gLzF/BzpgNU7IDO8u3EU+xQHO/SMywCrwPUlwfLE2bMZJ7zShue0diSmtr5t6fOkHp08sSuOLBLCaOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6865
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

--_002_AM7PR04MB6968EB78F957243D25BDD80890FD2AM7PR04MB6968eurp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgTWFyZWssDQoNCj4gRG9lcyBpdCBhbHNvIHdvcmsgaWYgeW91ICdzZXRlbnYgdXNiX3Bnb29k
X2RlbGF5IDIwMDAnID8NCj4gDQpObywgdGhlIFVTQiBzdGljayBpcyBzdGlsbCBub3QgaW5pdGlh
bGl6ZWQuDQoNCj4gQ2FuIHlvdSBpbmNsdWRlIHRoZSA1bXMgcGF0Y2ggPw0KDQpJJ3ZlIGF0dGFj
aGVkIHRoZSBwYXRjaCB3aGljaCBtYWtlcyBpdCB3b3JrLiBPZiBjb3Vyc2UsIEknbSBub3Qgc3Vy
ZSBpZiB0aGlzIGlzIHRoZSBjb3JyZWN0IHdheSB0byBmaXggdGhlIHByb2JsZW0uIFlvdSBjYW4g
YXBwbHkgdGhlIHBhdGNoIG9uIHRoZSBtYXN0ZXIgYnJhbmNoLg0KDQpUaGFua3MsDQpFbGVuYQ0K
DQo=

--_002_AM7PR04MB6968EB78F957243D25BDD80890FD2AM7PR04MB6968eurp_
Content-Type: application/octet-stream;
	name="0001-usb-xhci-Add-delay-for-the-control-messages.patch"
Content-Description: 0001-usb-xhci-Add-delay-for-the-control-messages.patch
Content-Disposition: attachment;
	filename="0001-usb-xhci-Add-delay-for-the-control-messages.patch"; size=845;
	creation-date="Sat, 01 Jun 2024 14:18:08 GMT";
	modification-date="Sat, 01 Jun 2024 14:23:26 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkY2RjN2E4NDYwNWY1MDc2MzkwYjlkMjc0MWEwZjc2YmEwNDUxN2JiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbGVuYSBQb3BhIDxlbGVuYS5wb3BhQG54cC5jb20+CkRhdGU6
IFNhdCwgMSBKdW4gMjAyNCAxNzowMzo0MSArMDMwMApTdWJqZWN0OiBbUEFUQ0hdIHVzYjogeGhj
aTogQWRkIGRlbGF5IGZvciB0aGUgY29udHJvbCBtZXNzYWdlcwoKQWRkIDVtcyBkZWxheSBmb3Ig
c29tZSBVU0IyLjAgc3RpY2tzIHdoaWNoIGZhaWwgdG8gaW5pdGlhbGl6ZSBvdGhlcndpc2UuCgpT
aWduZWQtb2ZmLWJ5OiBFbGVuYSBQb3BhIDxlbGVuYS5wb3BhQG54cC5jb20+Ci0tLQogZHJpdmVy
cy91c2IvaG9zdC94aGNpLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLmMgYi9kcml2ZXJzL3VzYi9ob3N0
L3hoY2kuYwppbmRleCA3NDFlMTg2ZWUwLi4zMTZmNWFmMWYzIDEwMDY0NAotLS0gYS9kcml2ZXJz
L3VzYi9ob3N0L3hoY2kuYworKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuYwpAQCAtMTE5Nyw2
ICsxMTk3LDggQEAgc3RhdGljIGludCBfeGhjaV9zdWJtaXRfY29udHJvbF9tc2coc3RydWN0IHVz
Yl9kZXZpY2UgKnVkZXYsIHVuc2lnbmVkIGxvbmcgcGlwZSwKIAkJCQkgICAgdm9pZCAqYnVmZmVy
LCBpbnQgbGVuZ3RoLAogCQkJCSAgICBzdHJ1Y3QgZGV2cmVxdWVzdCAqc2V0dXAsIGludCByb290
X3BvcnRucikKIHsKKwltZGVsYXkoNSk7CisKIAlzdHJ1Y3QgeGhjaV9jdHJsICpjdHJsID0geGhj
aV9nZXRfY3RybCh1ZGV2KTsKIAlpbnQgcmV0ID0gMDsKIAotLSAKMi4yNS4xCgo=

--_002_AM7PR04MB6968EB78F957243D25BDD80890FD2AM7PR04MB6968eurp_--
