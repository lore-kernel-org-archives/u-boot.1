Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECDEC5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 06:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0803588024;
	Fri,  8 Mar 2024 07:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60FB588031; Fri,  8 Mar 2024 07:53:53 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20726.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::726])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5747688022
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 07:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1ooaIfBPaiKR3Fhn2WKiiv2xbVuTSoTt/qGd3LXFSMBu/bDtJ9MQQkY648R3E+vIQOLL6nSaKKHJwbpWdMwfncR2gC/RQko93o0LpssrffJi4SCBuVNDuYtm2s1UCNWQVLbS/L+lzK2Kj0NVphGgLu0iTRXFW4OCkUWEHHwFKTkvxieMIehPHLduSzOwEfkcWNdpDSO/Gbp1F1KQxM2M5x4JXrvIrKdeGdEehUHXuwjCcRRghVYrtAPDh3ebll0ABKcpT1mVNsuXKGYwYP/qa7X6IK9O99vAlUD5Ek8vICiGJS3EyICQb0cYm+P3lVLMS6HR1XuVXlqVWYSPEDWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHHUH9tms6B4gORyBduvEm4osRJGab7bOLn9RojrXhE=;
 b=D9mqHsQj99q+LcxqPF57GXECZT+B9z/ym55qzRvkdB9ChusUuiMScqHcFj7HvxSmG8jori0UgSaSBjT/XberVurqCS5x/4CIzp9Ao4/72FUMGH63OkJmI4Qo+ZpG5Q6LhrWzjD6806h/udj5KTyV7/3BVjORfJAh4N9JiKbyELUBrItUXo74p0xP8dDMEXqCKjWRBcNSnsbECvvPTV9F/i1Y7hcNu7P1iFPvWQd5I2FM1RuHjXYUOuLH/fLSobzyaLd9QCDHVc9XmdvOdxmBqwhsIvEjlo7iSYVktotQGcEgNeO/rST5fwDzh76tlofwchYKuWrz6UFCtQq2czE3Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0784.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.53; Fri, 8 Mar
 2024 06:53:43 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7316.051; Fri, 8 Mar 2024 06:53:43 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Leo Yu-chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/2] board: starfive: Update maintainer of VisionFive v2
 board
Date: Fri,  8 Mar 2024 14:53:35 +0800
Message-Id: <20240308065336.40795-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::21) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0784:EE_
X-MS-Office365-Filtering-Correlation-Id: f284e828-2ea0-4fca-f21c-08dc3f3c7eb7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bu340tSfvLrAJQ6IWpFaSU954jaF76+rgF20Mbi+X9XyFzU71F9bYL26k4AfzoEhwdwU+3HU/V/BjK16HCtQD+ktWqx2cZbFNr+M8FpysZwJKwMidE1GMrLa7uOJyfmDWQau0LrxrAmMpZI/ck0WeHe0OxlTdoZqEsmnlHITE2DzFESFwGp6IYWUOSVhXiM4PioKFPz4ImUPUho4gzCZ0DDR5MbqqzqWHoR8C6brjzQdywCrh3daRXwCV9MLHNtwo80X2BdF1wid+PWLpnJWC7pB6yeVYQ481qGoDs3UU45rmogAfWbGA8Io/P1Ul3kVgVtCcXS0xtxApmp08K004Z8LtKuumbHzBX6Qix4AzpcbuFP0x9Bx6Znsz6cGyF0zc7GVxkkl767/aAW+kZjhOWT9ax4fxW0SgmPEIefay9PQx4WQFUOgdq8x+VNZjn386iRvf9ZezfQ96rD7Wdi4cbs18KI8Eujd1ZlMaPfSCS0Pf0iOvu40v8dDDerdK5bq5owOFasNxY//6RCr1gVDbWc1o0WM+gmplvpfu91nNhejeGBG0RBjVcV8B+crPXjqPnPP1/2oY/jInLOZVPXAx2Bxw19k/cXyGApWTgGbmgLXpHQtx9CLGtEW2+bGnUWa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230031)(52116005)(41320700004)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5AOnDPLQhX2mv+443lDXACQjLNXiyXxfzzT1GarQyOSh87mFFycW187YlYD+?=
 =?us-ascii?Q?rmIrQyxgb22oDe4tygB7HJNKnjWbsGlkXmdUB7xIKGcYTOzs3B5eIitU+dbE?=
 =?us-ascii?Q?ntgBMKtVgO6O+2q6MXTMjWjbxqMkek/k8aabyb7u+MmNGGEZGDRJMx8tvfkE?=
 =?us-ascii?Q?TJB9kPMnNLnCUZ8cZSb33unujlEmvRCqByxWkdQ1R6+em8cuYcod96SYZ8oS?=
 =?us-ascii?Q?ZK1CRbK3L45UHppq4xzYi6Q84QPRO6aiHPLtXvUGwsyVckKBOGZG/JTAdXjG?=
 =?us-ascii?Q?hR1kIoz0pYFXT6PGpNHPJz/lAgZQJR0h5w1pFV2/joR0EofKI4J9/hme21s+?=
 =?us-ascii?Q?+szeSixDbSZ94C3Kk3wTZ39pWYYrejMMq0qcHlYKpYwF5qV6TbF2BTmcxJSc?=
 =?us-ascii?Q?fIcilE3MRuN1v12zaYi5sgIauAi7uSibj6E/WMlvj+jWdiNuHcAHIvHixGji?=
 =?us-ascii?Q?PCT1TdUTZyJtmFf63+52sl2ua6GEk693vjS7tdj+tjQKscrpVnU0I5lRqK5F?=
 =?us-ascii?Q?1HFx4Xsd1lknBOzLTgynCgxZuMOWz61kMxDc3FBFn7thQpRYPrDKmD+bg9rJ?=
 =?us-ascii?Q?2QwlpD6ICAFHRy4Sni1l++mFblT7ETu4AnPfKtknHbGlBBcy0B9kXl+Cv5zt?=
 =?us-ascii?Q?pMJizcAFwBzMLOZTvjOTQZRpsTpMLe3wA1qknYge/anA4CfO014dPkFf7ibm?=
 =?us-ascii?Q?GSBHYp93QVrgUlwov1H2a0Eh5LNYJadg0VQN5WJ74Rb/8d6b8Rid+xlEkOY/?=
 =?us-ascii?Q?PcWuqTvATUDuvXtThZ3/vHbVmCEc9gMqnFeMhXN195aB39kkmUgxWddI91D8?=
 =?us-ascii?Q?+YgvWkmTEdlJ9avVlP0KRX3LZNlgxZ9zNtSPtL3KchjiTBdmDLuPuSvqKarY?=
 =?us-ascii?Q?1D5ob7NAklf9JRH5h2nuwmXbzlakRk7oeprc5r3Q/FUOwypPqC+XYjn5i7Xh?=
 =?us-ascii?Q?iT73KM7vYSvXZ1sz6YlgbCqbkSG6r1ZiWq7KX9NeZnlMlpJ7ZL63zfXWGUoR?=
 =?us-ascii?Q?PUCzw/qO6BQMPNmviNBI/fUbxPpIa4jW6rT+wn7fJEEJM60BlLB7QYcsNr9R?=
 =?us-ascii?Q?zTOjJBUzoZjz/q00lR2HEOENRPm/SXLd1q1x0G/5GDWaS9KhXrcoZdYcaUUq?=
 =?us-ascii?Q?4BBBEsPvso1yUEOKfh5nySWXR7folBljU+s5WbN9tLrjBha30m/Veb3Qs279?=
 =?us-ascii?Q?+QTA/vx8NnCV42UlAvYOwUrw4iUgE7+X4JvIGed5/jsPKKh6HYXMyMBd7xnz?=
 =?us-ascii?Q?FcNebaHOTy/Q6517WSH7Y/iDkNVIHHOBcU440pFbZPlUrBPanBnuBp0qj8rl?=
 =?us-ascii?Q?WIMVam3ff095hOjiYU5J9ptXJ47kND9ZKqpgbYvKiwhc7yaN0FmmaEzgC3a/?=
 =?us-ascii?Q?j4M+eJwMwICXO4Uh0yc6OhZmOi6dHlfi/Xux9vxCEgmF+4r0RjMe2x7tkAiW?=
 =?us-ascii?Q?kG7XhmmMytQC0617CzQ6OeuRUt6+AlQLxvKCfDSDag1Wp4Frr4RFmPEM2hiE?=
 =?us-ascii?Q?dLy6HEYUqpFfhK7N77UKSRIbsgXovgv9Z2cm36fldLf8sy11A/zdoYnIuIIN?=
 =?us-ascii?Q?b9UvH7SSpRj5t793WBg/SKcK+btbPRbdrnneta4C3kqb0DWbfXj7bYmT+/SZ?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f284e828-2ea0-4fca-f21c-08dc3f3c7eb7
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 06:53:43.8092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8W2M0GKh4FS6u2Ujv947lM/kw4qRUbgM6TnJNe7OcYzVbYd8u69R2DHxoQVWZdvHY1enqUASOdx6aC4b6v6tgXQf7QGMk06vUff/iUhpZRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0784
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

Update the maintainer of Starfive VisionFive v2 board.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 board/starfive/visionfive2/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visionfive2/MAINTAINERS
index 600ff9575b..5056e9c713 100644
--- a/board/starfive/visionfive2/MAINTAINERS
+++ b/board/starfive/visionfive2/MAINTAINERS
@@ -1,5 +1,5 @@
 STARFIVE JH7110 VISIONFIVE2 BOARD
-M:	Yanhong Wang <yanhong.wang@starfivetech.com>
+M:	Minda Chen <minda.chen@starfivetech.com>
 S:	Maintained
 F:	arch/riscv/include/asm/arch-jh7110/
 F:	board/starfive/visionfive2/
-- 
2.17.1

