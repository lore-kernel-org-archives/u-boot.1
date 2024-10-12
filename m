Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C85CFD347
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 00:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B79E893F3;
	Sat, 12 Oct 2024 02:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="SuFhxsRF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC7FB8942D; Sat, 12 Oct 2024 02:16:19 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9E3E893F3
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 02:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfbmXfJNc5e3wz9YtI4fxaX9WYeqRPy+vNDyZ59Fp0qwF7+19JULnrXQ2xY13FTcuSR+stIcg85Ll2pm++89uWCuAtDoRkILYkO5qSYQP7TSaTkmIynKX94bUFSih0ghm4OW0yjVyqy3KdgSthsC6hyh4zn1X0mp6G6pUElhEZwUcgjD9O3qn7JEn2KaboAGr1WhmoOfh0l0R6AwIm0f78sGwO1oUP1GJeZ0yQIiyHAuHkuKKHoPfU1PLWGSO4KEAk5HTD81KR+YD8RZboI+y6OJmptA5rARtyKiZS2K8urlOxFkkU+EPu73obDotv2ExCvhj/bC4kp9EnWx2q4A6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/qOhlPgoNUIm4fP+vNdgjOl5HbhpEpLrlnooQoPIEg=;
 b=b9rDycLnRa7BVTIJM53mmq6mGlgGVyTeozJQl3rnVkx/B6/vbO90l02QevN/MZBJqmWGpBv+d/rbZoac+3MW7jCSZLrveBk0bRtdpYKYoWiUlWX3MqGCSWtG4w4iT2PzpACjyHHTiz/ZuEPoiJhJtVOGNeH8diHj0S3oXEFUz5GgtehuGz8sZZIBts7AVCZVXg0Boo8xURmDfkqTHqsUYxJh6C7MtGS0i3XEQfse4aogMboXG1qUitFj1tFKODUULSBAR71GB0TRI63p/oehtzqhxH5dbq8fimR5mpXQrOd5ahH9wvat14Nx+0qLqck+rZ765QyaCP9dOcOaKW2hRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/qOhlPgoNUIm4fP+vNdgjOl5HbhpEpLrlnooQoPIEg=;
 b=SuFhxsRFWnli68xMpXNeusapvcQ6WEQEx7IJ3OdlAM+h5X+dsS7EFFH/3g6MEZYyMVw5qNxJ3F666nQskqdbQi1+P1KWOkl7RaTcSl/u+c2NZkl2Qqb9Vv2pxTibbTrpJmNbv+9Mrbb00hzi5r89egkHgq/0NyQIHrYaotyC4h8F335fR2VtNdc9bxqI501qYRqFzjpV0LuOudc75MD6D8kvvsB1zv6jPHXN6R8J9Iurlj9yLqHPglhdVoMgVc2JJdejt4MarPekZZbAERSANOaS+4Iakwk8F+uOCvanO92JnBggMsB3r+N/EpKg2XZT97eApYvoSAlDAlTi6GLrfA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10975.eurprd04.prod.outlook.com (2603:10a6:800:26b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Sat, 12 Oct
 2024 00:16:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 00:16:14 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Simon Glass <sjg@chromium.org>,
 "sbabic@denx.de" <sbabic@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, dl-uboot-imx <uboot-imx@nxp.com>, Gilles Talis
 <gilles.talis@nxp.com>
Subject: RE: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device tree
Thread-Topic: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device tree
Thread-Index: AQHbG8OV2ytJDPNYZkWDYfI8Ze6VULKBxXEAgAATiACAAGYkoA==
Date: Sat, 12 Oct 2024 00:16:14 +0000
Message-ID: <PAXPR04MB845979AC895A90D969E5F216887A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241011105827.7729-1-peng.fan@oss.nxp.com>
 <20241011165616.GW14210@bill-the-cat>
 <CAOMZO5CSK74_TcubtN1W1MpVmTwTmbv_XfhaOexpdvoc5WGb=w@mail.gmail.com>
In-Reply-To: <CAOMZO5CSK74_TcubtN1W1MpVmTwTmbv_XfhaOexpdvoc5WGb=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB10975:EE_
x-ms-office365-filtering-correlation-id: 1e361639-bcad-44a2-5d82-08dcea531563
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dXlXeEhqNGJvdldmTXptRVlsaGQ3L1psRHdSRVlnWi9HbFlsajVOQ1dmMnFv?=
 =?utf-8?B?eXF4Sm4vU1cxS3k2WnJ3ekwrbnFUM0QzRE5JQ0p5OW9EK1hzZHZ4Z0U1OUdK?=
 =?utf-8?B?S0xxT1p1bHIraUFza0RTRTFjWXBYR0h1UU5teThRRTZjZW5EZ3p2dWhBQVYv?=
 =?utf-8?B?VkFVU3hjYnBzNVduSGd6dWlHRWt3ZW4xUEdoMURhaDFldVhUT0pna3ZDN1RW?=
 =?utf-8?B?K3pkZ1BFTlhPbnZyZ1FBRDFkOU5CdHMzSnFRcmYrWmZlK2ZiaUZyckowb1pY?=
 =?utf-8?B?Y0w0WURtM2pJTDVRWnlBcVJjQktKQ3FWMFJkdlUyYTJ5WjkxcjlLQmlJOFZY?=
 =?utf-8?B?TGVYTFBIejRlZkc5R3JIYnk0cTEwYzVGUXpOMjFuKzJpNlFhdUY4NDZSQzRu?=
 =?utf-8?B?UHNqMGdLSEpWOXVHMXFiRVhneVVEZmhSUXZ6ZDlwUytXTnRjeDZKN2RRVWRU?=
 =?utf-8?B?bmc1SmJZOC9LdFh1TG1laXd4OEo1WlhEaHI3QUxDSzkvL3dhNEdBNTBGdzZW?=
 =?utf-8?B?Vzc0cHBpTFlQTkhncnVDYVZtSFhmQW1FdkE0azB1VkRiVGRQQk1nM2xqODZT?=
 =?utf-8?B?OWRXRDB2YUc2d05NeUZoV204RWVUSTNVU29NNGMwUWFqbnJENE1VK0RneUVF?=
 =?utf-8?B?dGRwS1E1Vlk3UUZzM1dRMC94UDRGQTVRTGlJZDVTTCs2TmpGcWRqdUFiQ3E3?=
 =?utf-8?B?TnNseFFzV1BvekZjdkNIQ3EyUW1tQVFxNnJmMk45YjBKMHcvYmh1RCtmQzJO?=
 =?utf-8?B?cG0vN29QTERTbjV6V3prRFJmS3ZEbkJJanlBUXhpWnUvdmZpVWtLcFNQamRD?=
 =?utf-8?B?VWtpUldhclVRRDEvNkF4UEE4UlZ1aW12bU1VTm5GaEt0dXI0Q1V6RWluU0d3?=
 =?utf-8?B?dkZUcFpWaXp0VmEwZWQwYnlIK0dnUW5qUzJoK0U5cGxoaEhCNnhsR01ZaUh6?=
 =?utf-8?B?UTY0dHp5akdSR3ZJU3R2cVdONDA5MkhKNG94ampzYk94RGkyUnJzOE0yenYv?=
 =?utf-8?B?bzBjRjBxdUh2VXBra0pvWmNsU0FSU0xMcmlmZGs3cUhVUGt5UHptYk04aHB0?=
 =?utf-8?B?VE5IUjd3MWNEckxUTTVkODVoTTRjRUkwMGdqakpoMWRPTTdDWTNjSThIdE1B?=
 =?utf-8?B?QkhsVnhqS21CWkxOUlNBakhnOEFsVWdlRTlDL0NwR01LaEliS1BuT3BHV01w?=
 =?utf-8?B?Z2JGcU1ocmtrbjJFdUYxZ09UUlJObnFLQUpZNHdwVmVEbDNUSHN6dXZpVVVm?=
 =?utf-8?B?MnRIb2JCd2tWb3R1TUY4bVQxQWtJLzh6dnR3UXBqSHZISVMrWHlCaTVMNlJv?=
 =?utf-8?B?bzhxYjUyNVZGWVcxS3c1RklBcFlEUC9IUTQxWHhhWlRtVXMza3R1NlQyYmNp?=
 =?utf-8?B?eEhwSmdMa0RVUWluQVZDZWZpSnVQakxOZXQxYStqVzE4WjJuOWE4Y2JVa3dv?=
 =?utf-8?B?UDNlL3dDcldxbVl1VTRNMEQ0OTV4UFB0VE5qNHQwVjM5UG1mTzVBMno0NmNt?=
 =?utf-8?B?R1Rna2tWTVBwUzgza1lDMVB1T2VZNUV2MmRsRHE0TkpVeElkUlRCTlFhQzhH?=
 =?utf-8?B?R2R2ZWZFRCtaK0lBVEZpcE5iVlFkeU1RcTVFTC9rcFIxNENKMWVSYnlKcXU3?=
 =?utf-8?B?bWRsbkQwdVlncnNjRlJWN0dUT01SUEg0aWtvcExKcGxLci9uYnpiQ0VZcHor?=
 =?utf-8?B?ZGpyb3JTL0FnSWs3VHp6NGVMTm05Rnl0RlpKTmVyM3hacHY4eXZHQjB1Vmxt?=
 =?utf-8?B?RjJtQlNwYmNkYTJVMVYzU1JhdTZyY3lRRnB3ZG5HTW4xVXFSQm1acnJMMi9H?=
 =?utf-8?B?WGhpQjVDd2hIT0FXOGlXUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWJOc09FaHdJRnpPZ2VTcmNCQ3hJQTlXUHVXdVJGQ2JjYzUzY0JVcXk3TDRp?=
 =?utf-8?B?QkhyZlN1WmRvVW5KZXhwc3VxZVZGZHBwWU81b3o3VWNYWlBDNDNnNGxsaU5X?=
 =?utf-8?B?YU5sWjh1NmpuU3pHSkxxYWQzb0xoVXVOTmdzREFYVmNVWVhiQ2pzZWw1RDBF?=
 =?utf-8?B?MUlkclZJQ2k3SG5mOWxwNDZWaHRzYThaNnFjbTRmZ29RRnB5bmF5ZjVCUTZF?=
 =?utf-8?B?UEpadGttcUNnT1JFc0lrektuaWZOVWJWQzluTVM4NHU0VndPSGJVTkRzRWMw?=
 =?utf-8?B?UjgyR1ZhZ3ZNeUdzU3doWnMxcTlMTmFjNjBKYW84d3NDTEZMUk1jZ1hiWTc1?=
 =?utf-8?B?MjVNUlliS3VnVUZPZDJuaVZaYXhQK1BVQTM2azlXcHZrcjRnbG5yc3VaeUlv?=
 =?utf-8?B?cjJKM3BTS1dqZ1oxUjZHSEFIWWRldmNySThwelNEaW42NFptVldkVitLODdZ?=
 =?utf-8?B?TVhFQkVvMm5xKyt6MEpFR1NESVBFS081a3plZ1VaaEpWenJacVlySWtYRGdQ?=
 =?utf-8?B?ZmtWUXYxeU1pbGRjT3Z1Z0l5aTgrY0VBd3JHMUJ1Z2NwSnZwOGQzK3VkV1lG?=
 =?utf-8?B?cUlwZkZBdUFmMjdPU3NsSjk0RlJoSnBsRDBndS85aU5PWDRhK2FMakZ0VWJH?=
 =?utf-8?B?Y0lEbnhnL01FNStGNURkeUFSNUxGTTBObjNiWFpTT21uWnFqRHh0WUtOYWtD?=
 =?utf-8?B?ZTRFUVpWa0lqUVpiamQrZm1pYmxVNjVMMmR0dmE3UDBpQnBUN0NWQkl3aVVv?=
 =?utf-8?B?UmZjeC9jeXp2UVlXZkc0MlVJZEVzVG5BbzNKZUIycEhZVE5OaXlMdjdZamVo?=
 =?utf-8?B?SThYRGdYNWltMUczbVkvOUFBcm4yOEUwc0M2cHpTQVh2ejlMNXAwd3U4cjlW?=
 =?utf-8?B?Um4zYjR6bWQwOUM0aWJ6dU1zYmJiWE80TDczQy9tZGFxL05DUExzSm1hTW1y?=
 =?utf-8?B?aUd0MDE2WHdTRExCWmkxeXpUTVJ0WEdyVTZOQVhuUnlGeGsrMUkyVmk4cU1J?=
 =?utf-8?B?N0NXNU1iK1FrZ20rcUF5ZTFZNndqQmgyRWxKNndqKzZ2czl3U3pBOUljNW9Z?=
 =?utf-8?B?UzJUd2E0Q250R2JyYWpJQkpFQUJ3NXNWRWo1eEQrS253UFRqSkROZVRBNVFF?=
 =?utf-8?B?NVRNRXNKWk5ieDRya2IxSzFaU09tWVhET3kxbSt5YUV2QU9uRE5UWitacVEx?=
 =?utf-8?B?T05tRHlSUUZIQ0VTdy93bFByRUxibTRJZld0ZzlaWDZQNjhIT3FzOEJuTHY3?=
 =?utf-8?B?S2l3UW4wR2JZc1BHMGRSd2FOdHZQd2h5cGxtUE0wWWMxR1NMcms5ZktOYU5P?=
 =?utf-8?B?b1M4S2lHMXh3ZVg5enR3bzNEWVhhZmtHd0wvcEsyd045eEhCbVFPV2c1YWdN?=
 =?utf-8?B?UmYrMU0xUHFwS0NKbCt3a1d1WXFRSXlnY014SmZpdkZOMGJtWnlhVkF0eWp1?=
 =?utf-8?B?cEN3K0lDZWhHUmdYZjY0YXJCU0I4ZWp0UTE3eVRDKy8wdWNVMzE1aUdPSitr?=
 =?utf-8?B?Q2VoREtQM3psRXU5cVlTNXBJM0FFNURqTDlMeng5T1FkVHRDcndBSFl4RjZR?=
 =?utf-8?B?Q0IyWWxpN2NqYWMwajdCMWo4cHYyQ2sySC9wR21PZWJ0SDRzM2NzbnJCaEVv?=
 =?utf-8?B?VG9DcTlMVktndVc0b1E5Y2NFUjBzakVDNmIzVk1RTzJoM1hIQmx6R1Y1RU45?=
 =?utf-8?B?K0VnV3RkSDhZcHdkSlVWclBPVDBmQnJhQmptaXp4NDYyT3lCcDNqSTVSTkI3?=
 =?utf-8?B?Q2puUXJrQWM3MTBnZDU3enBsd0l4ZkVMK0pHM2ZURUlBY3JQNUZmTEIxVjVr?=
 =?utf-8?B?bTRFOHBsVllGZVp6SXFXV2I1Zy9CbURFTXhHZGx3MDdaVWhIS0drNENod1dY?=
 =?utf-8?B?UnN1S3M0dkQ0cElnbGVyeVRBWDFsRDhZQ3lJTHRSU1AzcktVazF3YjRvdGll?=
 =?utf-8?B?VTB2UU1ZbmZNQktaUzYrZGJCS2FUN2w0YnY2QkJ2aGRWYW5YQllTVjB4elMz?=
 =?utf-8?B?ZjBDVFJ4QUNKSlg5TTdkMGpndVRYc1JMeXVKWUlrd2VJMERaMnFBczFybDFG?=
 =?utf-8?B?eVBxU3UwY25ycTRyWEh2OVNBMFQzMHNUZTFScW4xeTEzcUptZGtGOVBSYk9p?=
 =?utf-8?Q?PRW0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e361639-bcad-44a2-5d82-08dcea531563
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2024 00:16:14.1771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nSjyrnW7jDcl28bMutmOcw6FvEGvHNK/r5PCDva2bOyAbbSlg75fyGxZKpV9zYw6scpvKW5cY2uma2R0nk/JUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10975
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

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBjcHU6IGlteDhfY3B1OiBBdm9pZCByZXZpc2lvbiB0byBj
b3JydXB0IGRldmljZQ0KPiB0cmVlDQo+IA0KPiA+IFdoeSBpc24ndCB0aGlzIHBhZGRpbmcgYW5k
IGFsaWdubWVudCB3aXRoIHRoZSBCU1MgYmVpbmcgdGFrZW4gY2FyZQ0KPiBvZg0KPiA+IGluIGVp
dGhlciB0aGUgbGlua2VyIHNjcmlwdCBvciB0aGUgYmlubWFuIGR0cz8NCg0KU29ycnksIEkgYW0g
bm90IHN1cmUgd2hhdCB5b3UgbWVhbi4NCg0KQWRkIGEgYWxpZ25tZW50IGluIGJpbm1hbiBub2Rl
IGZvciBGSVQgZHRzIHRvIGF2b2lkIGR0cyBhcmVhIGNvbmZsaWN0DQp3aXRoIGJzcz8NCg0KPiAN
Cj4gUGVuZywgaW4gYWRkaXRpb24gdG8gVG9tJ3MgY29tbWVudDogd2hpY2ggY29tbWl0IGNhdXNl
ZCB0aGUNCj4gcHJvYmxlbT8NCj4gDQo+IFBsZWFzZSBhZGQgYSBGaXhlcyB0YWcuDQoNCkl0IGlz
IGp1c3QgdGhpcyBjb21taXQgbWFrZXMgdGhpcyBpc3N1ZSB2aXNpYmxlDQo1MWU3YzFmODIyZmEy
MjJkODhkMWVlMDY5OTVjZjM1NTU0MjQyN2NjDQptbWM6IGZzbF9lc2RoY19pbXg6IFNlbmQgODAg
Y2xvY2tzIGJlZm9yZSBJRExFIGNvbW1hbmQNCg0KQnV0IHRoZSByZWFsIGNvbW1pdCBzaG91bGQg
YmUNCjM4ZTMxOTc4MmU5YzNhMTI1NzMyOWI4YjdlMjc2ZDEwYTMwZWZiNzMNCmlteDogaW14OF9j
cHU6IHN1cHBvcnQgaS5NWDkNCg0KUmVnYXJkcywNClBlbmcuDQo=
