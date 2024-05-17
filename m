Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57440C04FFE
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 00:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFC698851D;
	Sat, 18 May 2024 02:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KJbHPnWg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63B7088568; Fri, 17 May 2024 21:13:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC4D98851D
 for <U-Boot@lists.denx.de>; Fri, 17 May 2024 21:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kalen.brunham@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715973234; x=1747509234;
 h=from:to:subject:date:message-id:mime-version;
 bh=ybz1tv6s6Dwxpx0XqUBEcCglEzv7gMsmNpOhlpaH1ok=;
 b=KJbHPnWgSH7KC3b0w0gKhzASQFMQFA/x2d/pv2EOpoGa7X3Cr6u6rw5t
 PPk68/XMAVCUYpIPZ8CO2DOyj4utaQM/7rkHXAmcfET+T7ZZzCvhWhjzo
 fG8P17zFy2bMC5lQCin6GsCt/aqhdBh5NimuQebtPaxIE7dAAj/qyhQ0j
 gOVOFyi7PZGhIprjx6gKy0xMFwihk4PFnS7SOG2rh/VDS2LV4U5k/ZjGl
 YKpqQag6da+86iNQdSpOtEVci40demLYLE2pkhrQ9Pqay8dQH4XEziDZ4
 Sr9jGDWz7MawOoan4jc7SGgoNsmyFYop6Iv/veDNe/QienI8rj0bgSaUV g==;
X-CSE-ConnectionGUID: mZaU8RXOQYu2hqGNamcoKw==
X-CSE-MsgGUID: jc9r3suOTXmyMv4x+IWQdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="11579824"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; d="scan'208,217";a="11579824"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2024 12:13:51 -0700
X-CSE-ConnectionGUID: fgiTlERJTHeyXBd/nLPygQ==
X-CSE-MsgGUID: qX+lpJTqSgWHMPzGYynxog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; d="scan'208,217";a="31993819"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 May 2024 12:13:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 12:13:51 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 12:13:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 12:13:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 12:13:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXjxPQ1kUgl5o9KRbY3+cZQTpqqCc8d5nHFljuZOKC7uKN+4wGrN7rwN2zfh1J6gKXQqY+yQMgikzQw7DNybhjl8iNVqdgmIiPNm1hlm9YKfst8bss0IpzeghAvBo+5VvVG923xzF66Tx1SmE8GVwdmNzWj+fL+2hnOwdO3Y4t8Hj1llH9a3xyHBegn3Ce/IxxZDVF2dsWuQXR3CYwPNHXlThSDiwnUFntQ/FLe00DGkT09iqekVKwJMYEQdvUpIx9O2Bre6JYT5D0UtIGd8ZD865+hhkXx004hXgWIglFN98S6iKNfuT0UrXueQCfQ1EFiwI+7yaA+za6o3dzIVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqpqb5iRg7V/pWE4rYl7lnYlrUYwPueidBzxnbt8Zig=;
 b=g5FgfdfwLO3pPs/cRSZ8enTEmrnZbDXVStGwUEjYP+znYl9xHqgQtixa1LJPlhm41P76PdIIUISTNrHKtbpRXsHdfOtnW9ASNBtdcXyTCDJzFJFNhtr99yS42OC2B0y4K2fZlPiJo/kN0M1j11SFJl2kGYazqwpngm5JQTYWLC11tUisfd8HtTbakJrVH453xJP6n/hN2uHGgp71cV4aUOStrbqddC/coPutLRMYohRsUVW16Ra3VTZLTqFQz0Fx69iOwqirCilvs/ZuAeUiuKkyDN7qjvJvvTW+ExVwP7pahUOfnPAacYFfac9iuqEW7Ht9hWT0BPR5A12iUVO22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5296.namprd11.prod.outlook.com (2603:10b6:5:393::22)
 by PH7PR11MB6745.namprd11.prod.outlook.com (2603:10b6:510:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Fri, 17 May
 2024 19:13:48 +0000
Received: from DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::4976:d526:d3f2:d785]) by DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::4976:d526:d3f2:d785%4]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 19:13:48 +0000
From: "Brunham, Kalen" <kalen.brunham@intel.com>
To: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Topic: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Index: Adqojlev93VX2sPCRR6waFJsm7XUJg==
Date: Fri, 17 May 2024 19:13:48 +0000
Message-ID: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5296:EE_|PH7PR11MB6745:EE_
x-ms-office365-filtering-correlation-id: cc3d25bd-e55e-42d6-ecf0-08dc76a57af5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?/lhwvtJgGTBwxujE8U/DnlcHmbmKBuf5aoqqV05qvOHWuZ4kWGk5gXAQh5K1?=
 =?us-ascii?Q?SwSuFyKHc3W2ciNaZheujl4XLMdet02ttsKDLGjJXjPQ4fXBLHH1PTx+stJG?=
 =?us-ascii?Q?+C9+LGYvSbV3RC+Ha+baMwzbma+Hx8yL6o5gRqWOSvXFZqjMfNsZkPn0uXN1?=
 =?us-ascii?Q?BjK+97sdIuXQhEA2g8Q9RJmrVr9bUFLh+3tSHwkjA1LonpnKcgyCOLdTzkB7?=
 =?us-ascii?Q?yCGO/OjpyKBYy/EMKxM2wIjHVrrzz0qYBcYHZrXNA+2+Chq1337ETzgf8kpR?=
 =?us-ascii?Q?0CYvjZEn6x2aaAOf3g5zBdMLMScdjLPZZFVpnIXd/wkbsOQdTyloNEmUU+FI?=
 =?us-ascii?Q?GSALwSO9mtYSelTfMHZ2WcCvWw1SOCcrMDUgoKY6e8afuPbFynbDQyo6Uc1S?=
 =?us-ascii?Q?l1uxb+KUWAWOK2apTR0YaWse8QEoUrgEv0+tqaMPgUPYn/vd8IYRw5iXf+zv?=
 =?us-ascii?Q?K+4gQ7NOqJs5iRnrOICwpYekMYNPCSRmIQAwMlihwSzVSE+WhUXqMq/d7vbQ?=
 =?us-ascii?Q?xJylkEB/U2iPa6/TO0nYVzDNsgPouXNh9ytXARq5WOEGnQYCf5RsFyBoenl2?=
 =?us-ascii?Q?+MTSmcFZIbMryo4o6MZcLlgxeDuyIngFHrkHR++rv0QnjpFznxNeJvk6sSor?=
 =?us-ascii?Q?cmVnEl7/PtKQGT3ZtkuDHqjBqboDvZJBAvgyyKHS7blOILfe+HWvY63/zha5?=
 =?us-ascii?Q?DmBnAL0YS3F7itzkhR+SzYylFB0WgiH1HyilQazPgv94VLYSXRiY2+H2T99H?=
 =?us-ascii?Q?VVBOKfuLBypALWJD1BPuq2y3a8eMijT10yC1zlqKaj8UG+RBMTa/w6ApOAf8?=
 =?us-ascii?Q?5E6m5obDRwzvFHgZBKSq/TUzb5pj8xoqICC1NKRH3iX6bNLeahyzrmlJW2xO?=
 =?us-ascii?Q?mwrf9d8/suj0MGgERhZeWZ5GxqfmPoCKp6F4riRWp24UQKAH2OPvYofWBG0o?=
 =?us-ascii?Q?zdpXI5Hqc3DNlFSTb8+X5YhRHkmkmdQGVFMQ2AiIMqQ20+WtJhhemCT+lpuQ?=
 =?us-ascii?Q?8SJnaHGWgq59/vNwYcZg9H9t1vD6HO6mDO2uwMpgNNvA291kqQOjaCzG/zxE?=
 =?us-ascii?Q?RBzJCHwkq2jBNxg0+xCRvXF815VJ9sdZqeEFY2WT+jBQcz+mRoHuvxl6emSP?=
 =?us-ascii?Q?dYw3eWjaVeGJc46VjXeG14w51GYIGe+gJ43JqDh1iUYnDJZ2iiBKN3NUoH8+?=
 =?us-ascii?Q?hgZX/Mb8hxm2TtqgpyhL2GaFhqXvK12XIr0Mg62IhS3DYhSUE5x+bARMGlaw?=
 =?us-ascii?Q?bVPZKSBzYO7Fzvs0SgNA3+u1otyCoNETqBtdw+teIA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5296.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4fJc0TTMwXV1nQSDHfFdyPpYF4noaFymJzqFynBZ6r4MqpI0+8cUpkNsSh1Y?=
 =?us-ascii?Q?5Yi67exsqLCEjFMjKpnUWBRDNlU3SO4tYs8Un+JT3XYJGlw/Q+d9bt2TpWjy?=
 =?us-ascii?Q?2pRkDQqHj17yfC4Nrp/76NnnyHh2yW8vapvVv73U2kGdwn8WSwRL/bzes9oP?=
 =?us-ascii?Q?1Wph13NZNNJdOb1ZIbQ7Vn9Wg+ygLY9jh6D+PlkH0ecVOis9HAe55W8ZWXo6?=
 =?us-ascii?Q?F8C97twLVshr8gZ5JtJjXU4rQM43BSDtqZJIEF/BZdzc5F6Jcr5o+30e0vo+?=
 =?us-ascii?Q?qLwgYcdABfvvOAHZka8jZ3Dc4KafgY+jJ0yLKanaCN1nv1XRr0abIkJe05TA?=
 =?us-ascii?Q?6eM6odfPwjUIohHhoCRQ/6s3Jo/M3gU1ZR1boRYrUds1z4FWQvbTwkqE2Y6S?=
 =?us-ascii?Q?scvSLRBLKWMgp0SmTAM+XeL6uKsriObPHulwcLS4GxUEpoLRifzoEFbTZln1?=
 =?us-ascii?Q?SU6nIhxcXnblXFjdHqr7lErJtcjfaZZn2ocuUyOPuWoS7UgUdnyiJxzmeoCc?=
 =?us-ascii?Q?JmHnveIVx2tQfJlJxrU40213EASdm8IhHoizNXzknrSvKcf2ThbYqnMe+Fi8?=
 =?us-ascii?Q?Gpsx4x6u5yjnPJj+MEXeHVGmjsORu9nyZz6lLS6/BFJXZmio09fVhdfHGwNk?=
 =?us-ascii?Q?h2rIraVId0qDRV7n5EwDqLdBY2+WmCDW49NLQp4I2c/AieExiHdflr9WoGr1?=
 =?us-ascii?Q?FUj7n+VQ9SqnGJ5yn5VpE/XJYOn6Ka42y6r+W7Di+3zFKkRqqRr3tFAx0aDY?=
 =?us-ascii?Q?0WqjRK11UP90iLr22/w7kMnp8NLm6sXzvmufBg5h//3kr2xfVhlFF/SE44As?=
 =?us-ascii?Q?a6yy8bI3WmQgT51t9oBulEoz3p/CDLjwZQoyXt+arHAwhMn2JP2vNXrhKm8p?=
 =?us-ascii?Q?zi/1OG7DsO3rw4WFOTqTmmWeZ9eJBSU34sce7ApH5KjIoTEDcyc0O25cBGRn?=
 =?us-ascii?Q?WgaiSGTizz9TLSt5WH6YXyIAlOB7AHOfH0VmK+1LL/bNA7fZ8hF7K9UZY6vG?=
 =?us-ascii?Q?Yb0KtENINl/YgOXsToeOZQq+NCXZ9yQdEgXLmYp/fN+vAnTDbEfQO6Mm5zQq?=
 =?us-ascii?Q?9I3RPKcwj+aDnkPZbGMDsCollqZtp0bXS+UQaqcMsKCxk1PrhbprwoJbHbhZ?=
 =?us-ascii?Q?3WuJfsfKQhferaKBNO7a7MBjSd26fhOpoEIyxrKDrbOMWBptZ3QG78oDd/uO?=
 =?us-ascii?Q?sg4b2fPmelSXGhF+1FeXLzPzdsfRXC+QxelbP3rfCEYV+HoopPEcvX5+aFKV?=
 =?us-ascii?Q?rFzFeHggJa66cdiOAhrCfA1/lVaxdpcE4MqWwp80v7JenqJbtFOklXhi+09O?=
 =?us-ascii?Q?cw8jvwsDZBB5VP3LRJwteBeEWqjH/IRctLMEJ709SRwu5eY9ouuLCR0kwuk3?=
 =?us-ascii?Q?VP0L5QLbGALkTzSrHHEI102KjnOdQ0FBw8mgAO6sEk7MNRpbESp5bfPoUNNZ?=
 =?us-ascii?Q?+vY+nngWAKk1VMCxDgDTZfcosVu/i7/eB1Km3Azt5wBivrBC/lXrtn6v2EM/?=
 =?us-ascii?Q?6hNkB1ai6ELLsPOFzGHqGYMJ7PsoEIezMCLw4L/Oy+BhH7IPNUe6HXmOsqeF?=
 =?us-ascii?Q?QABd3ExB9YZ8yaW+ELaXQZQVvoVf3KzVBRTEjlRP?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5296.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3d25bd-e55e-42d6-ecf0-08dc76a57af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 19:13:48.4106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +W0pL3HrpO+/Bs3IVL7TRBzwRAZF6/Sl8EirMDxfdryIXmV2R5rcBgl8B8L6KqJXfY/h17VAYAHJ4geMGoAQYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6745
X-OriginatorOrg: intel.com
X-Mailman-Approved-At: Sat, 18 May 2024 02:19:31 +0200
Content-Type: text/plain; charset="us-ascii"
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

I've encountered a problem when compiling the 'examples/api' directory for =
ARM64 in U-boot. The problem lies in the assembly code in 'examples/api/crt=
0.S' where the current CONFIG_ARM code is only 32-bit. When targeting ARM64=
, a 64-bit version is necessary.

I have proposed a fix by including a 'CONFIG_ARM64' section in the assembly=
 code as shown below.  These changes have been check via https://github.com=
/u-boot/u-boot/pull/538.

Feedback is welcome.

---
examples/api/crt0.S | 15 +++++++++++++++
1 file changed, 15 insertions(+)

diff --git a/examples/api/crt0.S b/examples/api/crt0.S
index 57bba9d851..4c23a54b21 100644
--- a/examples/api/crt0.S
+++ b/examples/api/crt0.S
@@ -24,6 +24,21 @@ syscall:
                mtctr     %r11
                bctr

+#elif defined(CONFIG_ARM64)
+
+              .text
+              .globl _start
+_start:
+              ldr           ip0, =3Dsearch_hint
+              str           sp_el2, [ip0]
+              b             main
+
+
+              .globl syscall
+syscall:
+              ldr           ip0, =3Dsyscall_ptr
+              ldr           pc_el2, [ip0]
+
#elif defined(CONFIG_ARM)

               .text
--

Signed-off-by: Kalen Brunham <kalen.brunham@intel.com>

