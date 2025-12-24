Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D79E776F0
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 16:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E16EF842F3;
	Wed, 24 Dec 2025 17:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="Zw+MTyK8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B960784295; Wed, 24 Dec 2025 16:47:20 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8B7C84261
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 16:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzDwRGrPymDshoeGqhqcktmGQUQqdgw5iVTgrljIpyGDM9zUCw/C7m3rLWWD0LSoFa09Jo0ZmewfEcluZu3ul7PM6Pnfbx9g2s799pOg9CYHwBYdmUiEItq0zWJ7odSrlgqEjR7doWvPI9zXDcuPtVKILI0uE9cXSqJlJWCDyEALezeXAs7+lYyOvKiWrPHanFl0qYpF5aS1zjAZQ04OMWdJfCSWBudDzKtHGjMxcGHXQAPvtuqviys41LWz+3K+l7SKsk5MQX5V0gmqcZCzlPmJ4GPl1xaU0tyXwlP6S/2cHFucmqEyOR7vi62wX+jGkd84iY6HIiC+vamqozjR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeE76XI3qhF7Jfyr/AdSLAmdgEx1F3qtbEyIijBA2Dk=;
 b=fjHkiV17XEB+SEgeN6Veff/ay04X3eElv+mlY1LqzHeDjIyotv7pFzE4cGg/1A1JdZZtSPmvia35mI18wci7MqCoaF0X+4Clc6N+vj2uVgPV9pzrUNdFvgMZ4fbeoO4rqsmBUjuMVei+hTyD/H9IDOZrLoDzpD1CGByECcv9121BZxU2zAMYedfyXmjerSQvIncuGlAi21a9W5GgKF4AdDkskPd/zFh3LO/cDm2U7DPAJ7tSwbuV8SPIl3+FIskU609uKXSnuQORI5D812DGtfgrPnT5GJSThFiD0+W+ecWVFlfq3n2awdW2q208Tyg3wfdVe6GZodcYyZ+uqJGSFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeE76XI3qhF7Jfyr/AdSLAmdgEx1F3qtbEyIijBA2Dk=;
 b=Zw+MTyK8taqfPwQZz4lcNsiYIp9fnIBFI25EWAQOWfip+zKk9wJXDUydSSEK3uwBEwy4bKcRMVyKkEv0WUQ0XA3CEgY4rYYNclKMZMaq19fAUWnIl5ICh1eZjA+3snwCfrW0vVb/Kj4l/qMFjyZ8XnFZt0XgDwX9oi2ETcUDOwPy/irimzJzuBnDJeGoWRThGWDZvDLw+mj4hDH8EL9PHZksuEPIy71wulUY68Qcc51MJY+DgcoToYRsw+oaVdN2ruBj2ELZKV9CXoyplsoZ9g9JRPzoUkAe1uEubeecJ39JlLDarT7wCczV0FzXqkTJfkPqsW9MbNqu3mJMR4xCCQ==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by PA3PR09MB8195.eurprd09.prod.outlook.com (2603:10a6:102:4ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Wed, 24 Dec
 2025 15:47:17 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 15:47:17 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v5 7/8] libfdt: Allow non-64b aligned memreserve entries
Thread-Topic: [PATCH v5 7/8] libfdt: Allow non-64b aligned memreserve entries
Thread-Index: AQHcdOyU+hjYlttjF0usnk+3K9+TBQ==
Date: Wed, 24 Dec 2025 15:47:17 +0000
Message-ID: <20251224154449.946780-8-uros.stajic@htecgroup.com>
References: <20251224154449.946780-1-uros.stajic@htecgroup.com>
In-Reply-To: <20251224154449.946780-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|PA3PR09MB8195:EE_
x-ms-office365-filtering-correlation-id: 3d6c1303-21c2-4df3-1069-08de4303b76d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?mvVTWSEjTx5jnLBkjvKuTTuPtoUZGDllYAv3tPyivWZk+jWLYtgPqmhATc?=
 =?iso-8859-1?Q?vIkFZ9sb36IBVtv2kH4HcSsSY9BNr8URiBDEqK2vyFd2c4ubjEoHfoH/s1?=
 =?iso-8859-1?Q?wbBxADMupJRcIrnn+mFyeQhgxMJwXk147dAe34Q5xIuOJnZaibrtm0g7SS?=
 =?iso-8859-1?Q?M3WFeb9tfn/B/XrQrTRs8TLAmhj4SoRil+pxUOSTHdmYt/XYP9A3H/CXk4?=
 =?iso-8859-1?Q?1vFRHGSxwBX7Jp2SbQsaCDZy2qu6vUmW4vS9Rt9+nI3eGWHK+OzctjYRjm?=
 =?iso-8859-1?Q?wQ5UsqvzZIZunRyjec4Egy7K1yJs3ofbxhZMhNmcG7qAqGzSJXNoRTUCmf?=
 =?iso-8859-1?Q?xiPiv4Ax3u5vITrVF2BOSKDSjxYznVoaT0zbBun2Ztk2dgoPW4V0KJW0MB?=
 =?iso-8859-1?Q?T85UD0ImYkXd3O64R2PwsdR4RU/axnMtoU/QlsKjPAK0s60mkKe/f2A+DQ?=
 =?iso-8859-1?Q?HhK+EJIBegwTZ2TpjBL7iC5b40BoEEso0woI4SwNFzFRPfgJLLK3ICkGvM?=
 =?iso-8859-1?Q?g0Ty8wH4oqvy3K68qFWVUj419od7kdcMjuqP62DNfBWwXmbu5Yiwb5TSxD?=
 =?iso-8859-1?Q?Kz084tVB0YEqCL5X1C7CeWLuyqj7ICIoUb72QClspgonTYc49hAo+HIVZ7?=
 =?iso-8859-1?Q?xU1WVvJ4tUy+R9pshH+rUzUl9sHztttvDJYf5V3vDlLLMxWpZo1Xf0olkO?=
 =?iso-8859-1?Q?ACpgmoDEzgN2x0LlW3YfgqGDQA93MmZEIxwhdIBynx7dgc6geVLSjNrIL7?=
 =?iso-8859-1?Q?6ljgWuaVyInFDZilOsu0ZWa38WdZNGAHQ630d/xfOrMBQ3KzUcCig22or9?=
 =?iso-8859-1?Q?WRFbCqj3wLeDmuc9/pVyqIpo9MfPegoYwdai34NrboEAFe0XrZLIfKgeSm?=
 =?iso-8859-1?Q?0kim8Er7+qoOGMCf9WnA/cVRmw1vMGFi09eQk67ZqnfY/u1T1FIEEolwJ0?=
 =?iso-8859-1?Q?PTDH9jFTwdiUm+UemRm9Jiudz6UfixnAu5jmkXRscErq5Y8bQmEOL8TnSK?=
 =?iso-8859-1?Q?inJJEGblXfYCkW9H34ntQp7Qz2E4NPDwtazQ2AmYwJFEGEjmug7ujiBMXE?=
 =?iso-8859-1?Q?hd/ZlAJYn7KQCmQMN3qIZaMSEgJZDKJ8nRARVv+pyaZFnUQyrkJR8uw6Il?=
 =?iso-8859-1?Q?ec9qcNxXMddQjfID16TNVkaelVlojBMD2S964eliv8cOO0I9dOv3Gadmk5?=
 =?iso-8859-1?Q?lTBsfQAlcBuu9gCb5BouXcmOvRJmd6+fKgTJ82vHwXJemlUIzOTHfljUt4?=
 =?iso-8859-1?Q?D6wCtTRV0mAmoT3GL5HwNrNs+R0m9Zxhr4TndTBNajLQe8ohnmU/CjjKRf?=
 =?iso-8859-1?Q?Snpowx+jXtCN/nY3VpN6Xuk3KqEN+n/RWH/84XNzduvgCFIvoeLUV4HRxW?=
 =?iso-8859-1?Q?W4Q6hpOVo5HddLHyPNFJB9krYI5cL2CAjPL9X6nddjdhoO7u9BU3ZTHDdZ?=
 =?iso-8859-1?Q?dsLAy0YJBqY2738F+nexa4xnoE5Q9KiPS6AHgd2chK+Re0+hv7HcEe/5YM?=
 =?iso-8859-1?Q?GLqws2pqBKPfs1LfHjD4IybMFfmfDnLlNAQeEWazL7saoO0tfO1LrL/HRP?=
 =?iso-8859-1?Q?kOBYqzQYBtUzEAUlpFw8Z34bzesq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bEQykK1qbcOHr+fyAg1AskhIVDrMwos5AgoBXxiOG37UgCS5rghtsQ2YCd?=
 =?iso-8859-1?Q?ob+3s81Ko9x95BYaIzSEoWQRZInF6ZxivmFGNzEgR2ErgutumxrxzJC136?=
 =?iso-8859-1?Q?SueN99E5NVxY0hmfppfdHBvHDsV9qU8p++xBQUh48t/PQyMiCDsxMlfZch?=
 =?iso-8859-1?Q?LU0RPl5K7hN4oCvd1Sgi3PZJaMJ8kACAfxHedrnFSZpcgoNLL0bCACSlYF?=
 =?iso-8859-1?Q?OzS9ec8VedWpWtgpH3SWkLhG6eUut3DbYFFGyLmiCvv2OSIIFCVkGMw9KE?=
 =?iso-8859-1?Q?Ye4HQVPZrEuIf0aDqNQp84IoCn67SiqQUqIQUgoEZzOT3oWK5RkqlLcuxR?=
 =?iso-8859-1?Q?bX9AD2VfCCr6i0lbBKx5GtQs1Y/ufP64kymJCb9n6MX8W7DX/PcPpwhTH5?=
 =?iso-8859-1?Q?pCnngAQeCcXrG+OnWb9GwY65epsrUmmklF/6u4suz1Ca1R11wkrDoRskX4?=
 =?iso-8859-1?Q?q2aPYUEmGV0MBJdMlbbWiUO6PaCgR9xOi7/TeqVQH14S993RanbouPDpmz?=
 =?iso-8859-1?Q?jIvFNGWQFa27O6D2m43u/ODkGSadcpNrSIR+3s7Z6QxTjOux8+g3BkmrHt?=
 =?iso-8859-1?Q?NsCvFwA/HP470WIRLsSeCp1trVGP4lf26xD0tzAaf31U5xinv4bO4CadHQ?=
 =?iso-8859-1?Q?kuTX03NBqprq7lQIHs2sDLzXoBihI6Qeeih5ZGgcLAqt6HHVQPS0+CFC8e?=
 =?iso-8859-1?Q?opOpSP7Ka7bUH6z460dxgAXHD8Oj3S3YaheYGHp8Brk122sQUjjqNGktR8?=
 =?iso-8859-1?Q?8+0DdkoNkmqqsgRgSyajQg/4ZXRpEMSnSF3NZa9NEG4RhFq+1u8OMSndxm?=
 =?iso-8859-1?Q?5WhmB2uqeVVZ8fJrEq51+muaY4PxWxYFNO3nz3as6kZWtWf18LpoI2UvIa?=
 =?iso-8859-1?Q?D4RsWz56+de7IChLENJrRL8kKW4NJzv8J3zkB9liNdi23VjDYA3gzR52Fq?=
 =?iso-8859-1?Q?6zHl0LFvBPTB+QGvQSG/DIJD72sjBdav7+fNjZ/ejDLHMWo0uFDvhjbsJw?=
 =?iso-8859-1?Q?eTaIEDM7O7KaaidzxU88EGocy/Xehn0SoI76rKG0DyW0YDqpAvqqmsAqGs?=
 =?iso-8859-1?Q?qcFmmlD6hPB6LbXJ8AzeFgAGXouPlhmzwTKTtALKlA+QV3bCh5JEVKOAEA?=
 =?iso-8859-1?Q?VI7EExdrWDZrK0Sl82iA9dE4Tf2BKn3fnE+fDYrMbCnv4aFC3tOR3thHuy?=
 =?iso-8859-1?Q?EVRspwOtl61PQNhw5JX1y2ximCziEllsqII9jwfwkpR07ctSQas9uj3bVm?=
 =?iso-8859-1?Q?eqm/hIcTTqmgAcw1Si0tg0ktOxgq4FYJfPKHTNKRmpXctfvaTe5/lDHwxO?=
 =?iso-8859-1?Q?0KFOJ5y5mUC2hoUnuRqEjNBKTLLsGBkHtV38ovK0+19JfyeJH7Klj1xeJE?=
 =?iso-8859-1?Q?dLm8yfk5lASass/gagAQ75+xXaPJjR1SEFrQjtaZDXedJJ0/v0OoBf6O8s?=
 =?iso-8859-1?Q?oW+diyDuHj7leo1AiXDVJ9xB3fDLhkp04iGHKLlP4RQXV/P1SPfckUW5vq?=
 =?iso-8859-1?Q?W6CaE5ZnCJ7KC5P9ZC4UgAc7jqIz8b1hNUlx/FiXwBfRT1CBd36fCULH+A?=
 =?iso-8859-1?Q?Ys4JuvsA5gbCG1MxrFB75TtADkpTPI9sWIAESwIJZtnbgTNDadTbsORXCg?=
 =?iso-8859-1?Q?XhFP3k6vQD90InSvB5D1DH0QAstgc5jEW/cCh1NdOJbrP3lQSjJhY50Xbv?=
 =?iso-8859-1?Q?K0SIg6c9ErIRq0VnUZMPWzVzlct2HwSrLvjh4O31VDu6Zu5rKzK+VvwtUl?=
 =?iso-8859-1?Q?GE+srIcno3ocea9VY1/lxSFF3sj/itEdybPM1Wfyp2p/wmg6nU+QjP5HtW?=
 =?iso-8859-1?Q?+xSZez2Il/fE7+phwP6mYBI7m+/H70U=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6c1303-21c2-4df3-1069-08de4303b76d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 15:47:17.4367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOa5Ati/wuvBQJX6dv/p2UF5boc2AVkg9j8wO/UJjDmlK4tRDNVnNrImwhXU9t6gFjQ0LhsQEkF+yQhSdalrOMXErKTUxD5KSNxKLJHPo60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR09MB8195
X-Mailman-Approved-At: Wed, 24 Dec 2025 17:41:15 +0100
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

From: Chao-ying Fu <cfu@mips.com>

Although memreserve entries in an FDT are 64-bit aligned relative to the
start of the FDT, we cannot guarantee that the FDT itself is 64-bit aligned
in memory. This is especially common when using a FIT image, where the
alignment of the embedded DTB cannot be controlled.

On systems that do not support unaligned 64-bit memory accesses, this leads
to faults when accessing the memreserve section before the FDT is relocated=
.
To resolve this, copy the 64-bit values into suitably aligned on-stack
variables before accessing them.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 scripts/dtc/libfdt/fdt_ro.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/dtc/libfdt/fdt_ro.c b/scripts/dtc/libfdt/fdt_ro.c
index d65656aaa8b..1c18aea66ab 100644
--- a/scripts/dtc/libfdt/fdt_ro.c
+++ b/scripts/dtc/libfdt/fdt_ro.c
@@ -174,6 +174,7 @@ static const struct fdt_reserve_entry *fdt_mem_rsv(cons=
t void *fdt, int n)
=20
 int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *s=
ize)
 {
+	uint64_t u64;
 	const struct fdt_reserve_entry *re;
=20
 	FDT_RO_PROBE(fdt);
@@ -181,8 +182,10 @@ int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *=
address, uint64_t *size)
 	if (fdt_chk_extra() && !re)
 		return -FDT_ERR_BADOFFSET;
=20
-	*address =3D fdt64_to_cpu(re->address);
-	*size =3D fdt64_to_cpu(re->size);
+	memcpy(&u64, &re->address, sizeof(u64));
+	*address =3D fdt64_to_cpu(u64);
+	memcpy(&u64, &re->size, sizeof(u64));
+	*size =3D fdt64_to_cpu(u64);
 	return 0;
 }
=20
@@ -190,9 +193,11 @@ int fdt_num_mem_rsv(const void *fdt)
 {
 	int i;
 	const struct fdt_reserve_entry *re;
+	uint64_t u64;
=20
 	for (i =3D 0; (re =3D fdt_mem_rsv(fdt, i)) !=3D NULL; i++) {
-		if (fdt64_to_cpu(re->size) =3D=3D 0)
+		memcpy(&u64, &re->size, sizeof(u64));
+		if (fdt64_to_cpu(u64) =3D=3D 0)
 			return i;
 	}
 	return -FDT_ERR_TRUNCATED;
--=20
2.34.1
