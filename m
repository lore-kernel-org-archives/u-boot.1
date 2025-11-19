Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB2ACF34D5
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC7A83FAC;
	Wed, 19 Nov 2025 16:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="O+H7nsdu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B24983FAE; Wed, 19 Nov 2025 16:22:16 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B27EF83FA5
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:22:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gS6IxowksL1csi3o0cZLGzfZeVbMQWY34leDrxTilazfSTkQl33tqxrxBjINdKTPrR//J/5B9gIx4ZlmNu8x7RqmjwGLA+C2KJir0sEQ7nmS66jbhJtTwAa1/tGB55ZTEtiy6FvbchHlqNgGj7muRtDpEfiNdh2V+TaxPWHFovwxQ9CxQ8AszBJuEloEqDNhbmjsxQNgK8CJ7Uldf0Yk+B02045H9Z7CTB7Z9kHkESYf3Wotizvufl5n6TZa8YVobYUVlN52xN2r0G2tY8RfmE0yGvv32Ckf2jWgHFH5Weo46bzzKwEBjAC12Ut0SmreZ30Z+fHUV2to1R9LSnx2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxqjD3iY3P6jeOaWekyZglQU7AKcAYYEZrTXxohFh+c=;
 b=sADWPMXz+DFQd0JkdGckTQ1hAIAN3/+PqkTtQyAlHw9f7eEA4tGm9BOdRjj8N6CzXgifMKES3BILDvEbpkoyRTLf73ppQWREaWOT1KulCTyHzY8h4YWHmuX+/vdOnsb/x9j2cF9FJCQnFHQbk0m7qktuTBB/BYTkXVgd0hjkMiDEM96ZffuVJ+8pkF1dCOK4I0e+mQuToegSsPSk9OlzPgfBsR8c9uNgPuzGyLSUTR0dd5nASZPkFPThq8hpHGudAMKwcFclZaVWwbuwPR4X8DMJO1YwjElRDlulV0CXV/b+BEmBBpBcNK2ECDaV2akIf7mc0sXMJyf04Tte9WbP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxqjD3iY3P6jeOaWekyZglQU7AKcAYYEZrTXxohFh+c=;
 b=O+H7nsduAhDAqReqCl6Phpo6v+4fqjqe2ZUJRjsVqADYt/noSL4Ig/XJX/y5th2Geq2F5r0q4isdZLAA687gVeB0vRH1f9bHLoroy6da1jtQ9A3VlNa39lqf643XJzxq5bUWKtGtqlVc0Vqr/NHbnarQ/zBCNYprSqoc+9xqWXxMGNcV8YyWSW9WG6lJOkmmdIBkrZ87fa/DY4pp6Q4BMbRArPeFh1/Q6SGYtLDnFNj0uFLoiOVNjxb2TJ3rSH2ECD//dkh+pZ5WVgMQKbENQJHtuJV50CAH4ZuWGj5QQSmpvN63EqDDscI7pEFRV0JPnWtgF2ibWjCXArxZdAoGpg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8379.eurprd04.prod.outlook.com (2603:10a6:10:241::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:22:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9320.013; Wed, 19 Nov 2025
 15:22:12 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH] mx6ul_14x14_evk: Stop disabling device tree relocation
Thread-Topic: [PATCH] mx6ul_14x14_evk: Stop disabling device tree relocation
Thread-Index: AQHcWLXEHRrL142b4UOuJm50ZHzAy7T6HwtQ
Date: Wed, 19 Nov 2025 15:22:12 +0000
Message-ID: <PAXPR04MB8459D28D929053B1250782C088D7A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251118180416.591255-1-trini@konsulko.com>
In-Reply-To: <20251118180416.591255-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB8379:EE_
x-ms-office365-filtering-correlation-id: e6ea50a1-7523-4af0-b062-08de277f6a39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?WWKuA4/60tcjW9ZeWSwhkkR2pHxxfF9Epn7j4YKm22QbPFnf3h64A3H32oDR?=
 =?us-ascii?Q?YDAqqToD2AyFzatyCEf+damhMVDG3XYQVsKM/QSQ/uYKEs55kbHZjOa+z9jT?=
 =?us-ascii?Q?qUM53N+qC+0xyfr5SmxzjC6+sjp/j2UMP2V0SS4FPMm4ZPA+vxVm6YUP+5sE?=
 =?us-ascii?Q?5vbjbJ6I5+MRh10kFOtX7aRshSDwB/ll68KBrU7n5bWmH+v/il8XA0cKOAj6?=
 =?us-ascii?Q?eQ3T6lOVHMgpt5dHntitKtvP25AHCPnU2l/WawM8JMjHIhCa1l7Avr307NuB?=
 =?us-ascii?Q?4849v2h7NxfYTo01kJMW0j2tpwKG8607Dve51vVlerIYbo6vgYdGuQrGRbdK?=
 =?us-ascii?Q?rkkBi2TmXCMzBLiLNwYntRqgTZYa776+mInsgosKHe7NZiqY7h8nS/FI4xkS?=
 =?us-ascii?Q?CfuJ9Fqk0xlfrJrENqaYB6GU68VJD/2VZHpkEy0ELmGqCb1L5NbzI72h4H5q?=
 =?us-ascii?Q?aW+IYA3WI/2JGf/CYA8moL+Kh5eL3acq0avVw7mqSIrvAUQcVg6vcMbH1DvA?=
 =?us-ascii?Q?xHWiHg3eAW9BtuUzsKANPts7mgn7bskv7kjp05eoz/bMDcEziT2XgiRm6tLl?=
 =?us-ascii?Q?olQ0mLRMyigJrtSMjqQKHNCNjWonEHBBXfXnNKD7hQZkormS12abLQlsd+wT?=
 =?us-ascii?Q?Bgk3xarmlBDW1XcRLkXGFRG90nms4LtWoPpdt9h5JpIowCSb0SNyFpAXtSw+?=
 =?us-ascii?Q?SHnT20iY9sOFOY29Hx6Z25KYZe8PR8vZLdzh8iarAicwFGzvhfqMax1k2Tdn?=
 =?us-ascii?Q?27TYX/HaOIRjapgGWYaR9ZOvAuY56jGIteD6k02fcm4F7Y+AJYCFh/xPMPW0?=
 =?us-ascii?Q?Rv+AGkGG31Z8OdhzX0aaovgilM+jBDC3CAtfmvniKyY+FIYmsC9cvOmu5IKM?=
 =?us-ascii?Q?Sj2eutFw9VVpZZP+L6ulSALac4mqslKDjGtsAPFUfGZpi0SiOPQ6qC3Ty5Sx?=
 =?us-ascii?Q?cg4YCaK1zzR9H0wqvzOdKI0fdEtPHf9vNGOP1SE80AsFTnFy2shjy5XELA3D?=
 =?us-ascii?Q?TjoYVrMExSoVW+naSJHrOFNnLe8KzqGxTwOamM5QYz36sboLG7NnbrjHEwd/?=
 =?us-ascii?Q?c6vnGLFyy64ZXHjCaAtB9sm+f/ar561RWsyMax/tU4/NLiAa+O7PxEf2+ni5?=
 =?us-ascii?Q?CdZopANsfvEmpbnbf9yM1K6SzDTgmL0GStzLEr2S3FAGe7AMNSemv2g+Fuzu?=
 =?us-ascii?Q?frxMKQEX8Pkf/6CdXtqP3FUDXQXvbsy1VsPpVwnVyGunZfxckDPpYBbfrFhn?=
 =?us-ascii?Q?Il/DqwCDJjHhFxF2R/8SEyT3dX4n7wjzGeH93Lh3Enq29X5OPHJ3D+0QC9ob?=
 =?us-ascii?Q?LqNUUuNqsLGXQ7kcEo8/ukoLzNv/8U56V/cxCIH5bevdmxeRvFDWjHGz37sI?=
 =?us-ascii?Q?zbSxH5VTwpDrF93/BkhU7mnetvVK9kiYWr9QuI2RXZLl2KjOMIri4f21VApz?=
 =?us-ascii?Q?S4/QTSK8OTsJplD4+f1oIc9An4Weu+GJSiLCmdiDcnCf6hE9Vhl6FcWPStWt?=
 =?us-ascii?Q?cqCnRQCg+c2Zz/oge0FPqo2mXYATarCLyKol?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KoF5vKx/L2z8b+Q+tHbtfMYjDaRBlCk4Slb3QKKHyga5UjADJpjw55YjyMNa?=
 =?us-ascii?Q?0NIIiF9PeO0BwX6pNoHC7TsYg6n3dYSZlHdWd7R+uKdfwEjiPCctLRcJWCl6?=
 =?us-ascii?Q?v9q8Gc54bsptGBNEJKKfljdor16vsYm6BAJYlQjmOneu5jWAgY9F/GVDjfal?=
 =?us-ascii?Q?LSlor3WCqL718U0bFYE15/Mq2k26FXlSuWDcXeiCjx0s4VHAfn5DTzdRPRjs?=
 =?us-ascii?Q?Nt2jqLZoGF7x2sk91Dx2cHQeDC9Ige+yLpLPJ0Irol34axr2UNy13BDybkdp?=
 =?us-ascii?Q?aTljoSCNPrBaLcEN5qoGVez3m2c4pqJLZkKVR6RxAckmQ8O+ZgxTrgVQXVRc?=
 =?us-ascii?Q?MVpNCh+yWSmnwC6nW8nPEA9ZvhsyquAIU9YHLDn1bz1bVqzBK60NYqZyB5JL?=
 =?us-ascii?Q?9vFiRETPoJO89bg94QaA7PFgf5sD0bCSvXDstCxy2kaTLBLKnNiSxwiOt01q?=
 =?us-ascii?Q?T9GDP4D48nZJ7vmy8BiBCp8KQ8X07fqzaXw0H8F0NYgEpvUHziyzrE1jOPAo?=
 =?us-ascii?Q?SyF+6F2dKKDcUO1OuzBVZ63psYLChDGi0YQ3JuCuXl6HMoJ11GKGSmzVt4Zm?=
 =?us-ascii?Q?gTQVKCdrm9lnCj/KRa9EtjZe+mLr5TxwwcpTC9WpOUzQLfWCXRJaOdABDoml?=
 =?us-ascii?Q?LpeZ8WEMZtqV2hQORzvOUBg7kujJUwqRQIY+sIym0ZJuRSnEeLoi4nCv5N41?=
 =?us-ascii?Q?Cqeo9ibZKOLQj6tCHXdhZhpAYBS8JrBEbVBeV9ssSLyKdB8dfhAB/T8S1qn0?=
 =?us-ascii?Q?F4H9HIY7mbVDr5TUeJxUtWYloz0eORcitbQTUeLKv8JOw/4DLdrnWm1kGnQr?=
 =?us-ascii?Q?ePPYDs7GLXl35EzYfZN7wlxIv/2wjY5NbWhABk0NVMiph57LWzkYDJ8teQ8P?=
 =?us-ascii?Q?baz/DqBvAzKP724x50NUbAZ46LPJHYZ/LJoiBuajnKvjq5bPcn+Ys5khmt9z?=
 =?us-ascii?Q?IGFjExlZ/8LzOzdx02LqqwyA4QuVhB/c9AXWBWn3+a6a+Q1M5ZwO5lyYIEBM?=
 =?us-ascii?Q?cGklwAcYSxnsixv4UisSGWoinMZvocqD24ltRu5lKuplCTXNHpDkkwvGKkDQ?=
 =?us-ascii?Q?CEfhKdkMcobQU2N7/GmqNUYmBBWzKn8uI7Ti03u/AnfX1HBU1T4we+1idfoq?=
 =?us-ascii?Q?vvBD9T3SUpBF5057ZcFHhD9WDTEzd7/HUBgRQe5EpxsEhtQIMb5NXyvQnt1X?=
 =?us-ascii?Q?tJ4n9ZKQwSxAUpXqyd4xmfoMI66Hv/vKWu6fEjrRlv3FOHz4KFJxzjXIABDo?=
 =?us-ascii?Q?KoIwKKuNI2G6WYoMPn9HKsOEIG3N3y9nWEm/FBVYrX6xPvlk58/STW65JokB?=
 =?us-ascii?Q?++QlDjtF5Onk2xcN3+k4bgNzhjuME47L6pRX4ic8hp+rgQ/TGWuhBgIyHtP6?=
 =?us-ascii?Q?YkjGoeI+onhJdW/pzKT1/ouVDo8m9FBgihiw9kffAyft/yAMQnsCX+KCT7PD?=
 =?us-ascii?Q?vibZDCcQYrT8PI++q7ABCuqLN3RLH6kW0Qpfm3pa0gUc5zfg2xWKbHYQvrN/?=
 =?us-ascii?Q?nQzbcQ6OXck+rILbd57ClQO5pS3staQ4Vb8fTcK70MgjM6uIRBq9HJI8ISPl?=
 =?us-ascii?Q?7gWO2MndTs3vmi38l3g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ea50a1-7523-4af0-b062-08de277f6a39
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 15:22:12.9147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gm+I12LkCE6+E7djTQQFxY423KFzS9ZjHEYjH9cEw/pskuhE2J8AGBK4jXqqo3UxDYICGc7h+8mL1hJmpztJhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8379
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

> Subject: [PATCH] mx6ul_14x14_evk: Stop disabling device tree
> relocation
>=20
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from
> correcting problems such as having an unaligned device tree and leads
> to various failure modes in the OS.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
