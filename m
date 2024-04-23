Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A745C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 23:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80B3988CC4;
	Wed, 24 Apr 2024 01:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="IceZAruW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D9C288CC4; Wed, 24 Apr 2024 01:34:12 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 202D788CC5
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 01:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjsVoFhyBgM03+iGVGZQ2aWeg6EzBV+EC5KND9sQUJQJzyFni7PKDVBAVpVgN39NVAzDlGiPZgQZ/eW8wUShgX752p+azQd/jTWL2oN1yCzhjPZio0TfhJpAqSZyYUwWy9DkCnukPJhjvS9I27U/OzwJ5VH5z9M8F8K9gtiwQzPg6VEM5duF6IShMz4HPHXmcahAFD3krUlagC0zX4VMy43ecM3vnBVJHuyt0AQ+pcTz5B82fKM4WhtQaI+Z3YjVz8PlH5nF23WWr/cqsBpeL8K8Xk8HSIn3IORDU+oJPuxdf0U+SKkqtlUTIUK/Z7q5ZS03x87N0SCxu0R0loL6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez4KOzmq7pTCR80diH32qJisQJuFTSPFV8F1Gid+J9w=;
 b=LaEgubkcz3wcGdEz5zPWpLgusYu0sbdOvjUNPYsYfxN4Kl7rT9BbL/RXO/ix6yu47wsYsciI37Bq4OgpkuqyTE3G1iDygbL2a9Jbk2rAqQv5m2Xac9dTTnWoVDvxv1+wT/ujjNbvMz09l+bp/qwZwfFt/N0NMGrQF12dVxdWf6tz/2wG7v5w7odqa7AfJuyyKdkDNn+nHv9i9m4c2Cu4GdAgTxOwHyB28ERBqtu/9pDursEbrbzjKdlQGnVq8MthqGKsW3VHe853/oEKsxToelF4IypsLRxXk3N8I6t7vV7NEliUHD1mUOhgSpWc6LW4gb0PYaEMHMXcrP0VCNdKpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez4KOzmq7pTCR80diH32qJisQJuFTSPFV8F1Gid+J9w=;
 b=IceZAruWw0Zh85+AtsBQHroCdWuf0oJzmh67WxvFalNcRPndFzsRpJkUgJciuSJ7sKpywl8dYFZmz1qUvmUtZKKCdRX/rDRUljz/RreEOov84Gy9xne9u9PiyKXljtIIKfnTOZSKGbAOCb8jn6krGe8Cdw73BOcMtSGlZtrbs/k=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 23:34:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 23:34:08 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>
CC: "U-Boot@lists.denx.de" <u-boot@lists.denx.de>, Michael Walle
 <michael@walle.cc>
Subject: [GIT PULL] please pull fsl-qoriq-2024-4-24
Thread-Topic: [GIT PULL] please pull fsl-qoriq-2024-4-24
Thread-Index: AdqV1nlFLFSdotLXSK+s7c48ImkWWA==
Date: Tue, 23 Apr 2024 23:34:08 +0000
Message-ID: <DU0PR04MB9417C878C2E50F0425AEA54A88112@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB7750:EE_
x-ms-office365-filtering-correlation-id: 4fe151cf-c539-4d57-0ba9-08dc63eddf7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?eXA+kjmLUibzXbINx/NJqyMugRROA/5EuKY/9t/0y9Bcj2tzYbjkmcqy1C54?=
 =?us-ascii?Q?fxSaCRxsmGj8El1BUT564cKZLRkJg+zOMR2BNNXo6gzWHG3N7szSR5nibNnI?=
 =?us-ascii?Q?bbsyGvWKaxPrvVz9Yk66J1DP+pXTpVW3Uw6R9w4CUpbv7npXGl0Xxl07uj2s?=
 =?us-ascii?Q?DaANWpfeIlxSrf07kXU9/D3FTuZDFGvVKkY8SPHs9GLHwAKGppsaqfbZhHPA?=
 =?us-ascii?Q?HfsrBQAEoe6FUGk+UlyeO5rgIRU/CklWHonO2j0kjRZgdo4+wc/6v5iSgeCI?=
 =?us-ascii?Q?kzZXMFKsIfPYbz+AXe/G1lT7i/qQ6naEVqhqw9NsX/YsQGYA+RaGJD7F0OJZ?=
 =?us-ascii?Q?YmGeLtAXNpGWGkFhLhSQLLt86oB7xF1HGPimo6k272mh+3rP+jfnZntQeeo+?=
 =?us-ascii?Q?uvhRbGRg0CxJig4xZnlEeGjyDTRHTsrdU7C/muJo6WR0bCze74BEg4gxQMhQ?=
 =?us-ascii?Q?YzKGFbpDzXd1AY3fdCTNvCtkElWear2NG7nDejJ1m0zb1prxOdHjx56IOEox?=
 =?us-ascii?Q?ctMmyVseOVyfJfcNLPiKXZ239d5aPqmDTfnv+B04iBICMyOsnY/6bd10mYpq?=
 =?us-ascii?Q?XPIwKxsAOczdpnCeyLROzQUmiyNTaWHTAMCSHv6PZFtIJDhJN+ct6B9MmPkn?=
 =?us-ascii?Q?OpyZYuQw77sXyMK0b4s9gTrgI/PEmnrqViLWFMIngck1V3jPVUlSR62H7iAt?=
 =?us-ascii?Q?GQ/o/di7Dgz/UyZiT8Yv8LaVHkIP3pNkuXEgkoEymqUN0hyLG/TmRbTrNpJu?=
 =?us-ascii?Q?0Xy0mZ1GOHXMsL53GnXbcrnrTa4P+Fvbuc3H4gpPPuVHlQqQg/wv4jvkVOtx?=
 =?us-ascii?Q?r6hF1Oo3kM3w6Ttk4/xTgv3a0/RaoLQLI7MAab3t7J7kOi6t/7DEP/ejYlEN?=
 =?us-ascii?Q?KohNgLcsMp/D/sBQcsm1oOENs1ocXsn1/RCSMpoWQVTQQHRQPLyjGNYe6CCi?=
 =?us-ascii?Q?f0Jfi7PYz/EC2BLT5vXzAYNr/I3sz+BEOe8XMfuQVpj5v+nqa4k6zPENkb5r?=
 =?us-ascii?Q?GHM16ozLJg1r9Z8ZVNesGUmwc/qqlSUWTJr4kdggzpjdFNxVOlMd1vRjpCdW?=
 =?us-ascii?Q?fDaQQgfBN3kwp1KNjHD0eGLAgcxHjSE22L0IDntoqAtgZ0iSz3iTxoh0vn7t?=
 =?us-ascii?Q?SK+wilQsMDqTGYoVUEQ7xQ+7npMaQgVfPLz+i2ygP55YZvdV8TMX6mNaNxdy?=
 =?us-ascii?Q?MEI0keAfmubuI4W8+7OE149ToMZ8FsixtYY8ZfWISZx4dw0VZ00Cym1eTLZf?=
 =?us-ascii?Q?OM/TdWcps862ZoSchTufTPiHxoZ4hHVkqxg6eYDgbA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aUTqSOhCfX9sKmAVlnXcmaHk+l8WFAB8rZgbjkfbQqxn+azxWhqaI4RwpBzX?=
 =?us-ascii?Q?lZLFB7X7sytex8We/d9Vn9mK6Zhi6QR3f/KV5nlNm1fYMs+kPiBubZhgJdTb?=
 =?us-ascii?Q?PKzTNbFcyz3FQClkVOYSWXVDaLzLzZh42RZ4Df0snQHYycEaZ53ptLC5tK7l?=
 =?us-ascii?Q?RL2herOHDkcuz3plTNdEayOm2qHDIBujbJhRlqrX+74StKrDCDHrbEInkpV1?=
 =?us-ascii?Q?qgc86m5obdRpL2S3KbIwwgbMJ6YaU3euSDe+FBC45PHs96Hqde7J16kbZ67+?=
 =?us-ascii?Q?BCHGoBW6Swzr9AdEFmFpuk+dKRXVfDYDieAFAVq42NpcJFCFOdhqaTTZRhqE?=
 =?us-ascii?Q?KwVFKlE5s/kp8jLLTQKRlpTJjYyC0Pahot7Ju9q5ZRGClSO0BnYPtwhFJk28?=
 =?us-ascii?Q?uzeRMtuo5fmMi30Ox+dazFv2hA2iEqHaWMeZEMgdpzPkq8qCPjZnzkvBfF2S?=
 =?us-ascii?Q?Do3K7NrhCkWZEzi98UpWO0d6CTSYAcG/U0k36FpDrbH/LF89rblOYTQw/y8S?=
 =?us-ascii?Q?f1OdoZgWa9bZFEW/JIgXgsGjU1wxvVNJI/UzShHE8sSr78CSqy4dxiSKbubj?=
 =?us-ascii?Q?qEW/M8oJ1ibbkxnWpDBB6r7e278X8zfhS9GtCCGskFXdDtfG5KTcgnKxXy+c?=
 =?us-ascii?Q?cJgJ+zPCvXObK31r25/WbpTXjuxC0QxeAv9mcuVXfJlcwuxF3BApB9Ka0opN?=
 =?us-ascii?Q?UPR/Ov8SAS5oXySnxfNEBbGs2gqpJoivotxApNqojr2ojNeGvuk8UllOFJZ9?=
 =?us-ascii?Q?CcMhWgKPWKy1RQZfnc5gaXltomVvn5XZRtdmfrh/QfnPyUDQg/yoyApvIxt5?=
 =?us-ascii?Q?iGgNvw2RNylrvs2qZyVRb32+kYChNSIArhCrlcaPD6TB1NnkJ5BmTj9DSViM?=
 =?us-ascii?Q?FY3RHDQyaLYd4vrgu1OS07B9/RIdnplCQkGaEJsXe6fRdyzX1G5g/d41Hvy3?=
 =?us-ascii?Q?LT+OQt/d85vCnSLkBulAz4w6LAyXJ+oCd8+lBD4BpDLk5GG+3WrAizt/5fj5?=
 =?us-ascii?Q?jg2NN2B+UkNVniPqnC1484haFDwqGVFPHwOrckmXl1QYGoiwcFej8bk8Bs2+?=
 =?us-ascii?Q?tpwG9l1aVnVKRGDIksMwSMQXWoqujiyZvrTXj2ARNcNaKt2GikznhJRBKCyg?=
 =?us-ascii?Q?TJRmxgEgFqDI3iNLfTLZLZNdpndyTLygN2L4ZcLDAhzCwIvfkwSb56s+oJG1?=
 =?us-ascii?Q?2LL7EtCELAIXLPFNN6EuPNESLGd/oFqVabrHguGCJs+kImEKc2CI6gbwkXuN?=
 =?us-ascii?Q?f4pJ2k7GAgQHa5Zyk4kR64126Kkv0MxN6Nl1heiONHwIinrAw7rexV9XXztw?=
 =?us-ascii?Q?XyF9kvQ84qtuaYZu4RWHLhurbV+yA7sLw9gx4ewoF4oLrWfIxvSktl9xhfr3?=
 =?us-ascii?Q?rlj//6WxIc3PiDbFEgldqwPbY4OUy61fEfNTUvSlujfV7ltoxTcToTB0UZnd?=
 =?us-ascii?Q?cOzRoEHuqvu6OkVr4xyI0vZJDTUI8PVDxbO/gK90nfmFQ+JHlHhjkauaRLV3?=
 =?us-ascii?Q?qxltLLvOl/k676ywMcwiJsXA5tymvJc/fbAkHj0RzaG1LWPf+GOFFnja5kAF?=
 =?us-ascii?Q?pdEEMu7mPuNWzyKPWE8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe151cf-c539-4d57-0ba9-08dc63eddf7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 23:34:08.7169 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JXISJE2zgCnnNrqIb7++CCNJ3+P9CzkpgEOxK8Y7jgeaMXYRUX6ac1Ikqs36HxWn+yUNvEZ/v1+v5SsenoXVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750
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

Hi Tom,

Please pull fsl-qoriq-2024-4-24

-----------------------------------------------
move to OF_UPSTREAM for sl28
-----------------------------------------------
CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/2=
0501

Thanks,
Peng.

The following changes since commit 38ea74d6d5c05224acdb03f799897c1bdd56f8cc=
:

  Prepare v2024.07-rc1 (2024-04-22 15:10:21 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qo=
riq-2024-4-24

for you to fetch changes up to 61ff13283c3b3858989c038a5dc57b1370e5d8ce:

  board: sl28: move to OF_UPSTREAM (2024-04-24 00:22:09 +0800)

----------------------------------------------------------------
Michael Walle (1):
      board: sl28: move to OF_UPSTREAM

 arch/arm/dts/fsl-ls1028a-kontron-sl28-var1.dts |  59 ------------
 arch/arm/dts/fsl-ls1028a-kontron-sl28-var2.dts |  65 -------------
 arch/arm/dts/fsl-ls1028a-kontron-sl28-var3.dts |  15 ---
 arch/arm/dts/fsl-ls1028a-kontron-sl28-var4.dts |  47 ---------
 arch/arm/dts/fsl-ls1028a-kontron-sl28.dts      | 308 ---------------------=
--------------------------------------
 board/kontron/sl28/spl.c                       |  11 +--
 configs/kontron_sl28_defconfig                 |   5 +-
 7 files changed, 8 insertions(+), 502 deletions(-)
 delete mode 100644 arch/arm/dts/fsl-ls1028a-kontron-sl28-var1.dts
 delete mode 100644 arch/arm/dts/fsl-ls1028a-kontron-sl28-var2.dts
 delete mode 100644 arch/arm/dts/fsl-ls1028a-kontron-sl28-var3.dts
 delete mode 100644 arch/arm/dts/fsl-ls1028a-kontron-sl28-var4.dts
 delete mode 100644 arch/arm/dts/fsl-ls1028a-kontron-sl28.dts
