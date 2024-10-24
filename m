Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB27CE8E6B
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 12:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA0D788ECD;
	Thu, 24 Oct 2024 14:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="MX1R42ZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3588287D1A; Thu, 24 Oct 2024 14:27:44 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD9ED88ECD
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 14:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMrHjkGONzeeD0Px+oTGXyeyr6LYWvdybdGb7/QMLCLCDQSmnnLF1eeAUb75URyJ5ARKKMk/MZ9d7sSSIxO+IByeBcaW3nDlOiZUrQjYtc9rFrrW2ETuMltkDK6rnYlYllqfxkd+mL/dfke2twkTW0fSflHc4ZIAzm3m8RwDkBGK1FzRC/X3YTC7j0jckCosu7WRvdmA30Oh89H2ZSIqF5MiVlKI52dizugpr8WTubNCdP3aGMBl2DuG4xdHdfZmm260JhHol6HvGKP9CoebINePOndu2OhsfeXHcuFud6Ec8OVCuKWpi83cXvTFWQC4TL5tROKU4GoPo5EVPqbnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3sLfTTcggLmG4GBlCLQcoBBbfXliTkRLucJfVr1Z1k=;
 b=KL83ZcP/R0oWRTZ50+aXQO67Loy+ffFn4bOT2d01NAUAmbgxO0sZRSxxcnG4GvVj7LjYeStuqIHObt2QpA3DHdqN0EBoOeP4vMhm3Hr/V6I56wYIrvyvZdAWCYpZL3FmIaz2PI4OON+uofZVDMDjmifKbd/M7TEjAzR+FwFhH3kb8akV9jwWBVUgdvz7fK+Kr9DZINT8Imnc2WPbUTqhtnumG2VCTe/cEN+VAAVKit6PeSsHnq4K7dOUqM+17hy/SnkeumgSRpunm2sATxqS0RN6Qw6aKRws/DAlwIe5BrEzag72Rspj1Z3NX4ZHLPifsDG7BBLUjUPCpOFcrS0D/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3sLfTTcggLmG4GBlCLQcoBBbfXliTkRLucJfVr1Z1k=;
 b=MX1R42ZHdYDh7NXURmNcc5vZQID7sp7uawiHpDDKTW+jnFGKFgGmLMxSYDUzhvoDUoebQfSS45QWGWt2a2Z7h4tuS+FSlv1Z+UV8L5919H5ySrhgcuBHoftySv1C72RR1RFdGp3XawmYKJBtg/r0TrGvUBHAY176J5Q8CapDwoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ea::10)
 by AS8PR10MB7498.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ad::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.8; Thu, 24 Oct
 2024 12:27:35 +0000
Received: from AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::83c5:5c8d:5d3d:8b09]) by AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::83c5:5c8d:5d3d:8b09%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 12:27:35 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>, Marek Vasut <marex@denx.de>,
 Fabio Estevam <festevam@denx.de>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] imx: hab: fix size of IVT+CSF blob tacked on to u-boot.itb
Date: Thu, 24 Oct 2024 14:27:35 +0200
Message-ID: <20241024122735.893319-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0119.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::15) To AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5ea::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB7082:EE_|AS8PR10MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e3f6d6-3d27-4002-74c2-08dcf4273d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F9ADteGVbUT6dF7PJ57Fn7BS5fyH7OOnGcJnPK5Ek4JebmeelOrfasWGkmze?=
 =?us-ascii?Q?ROlTVr/Wx0nCyof/TFXxjpBSzknn7lKg2esiDf4wgiB3dbavZHwo+gy5x5Rw?=
 =?us-ascii?Q?cB8imxMvVwWoKAMeiHyv3o7fZO9kc57quW5gRu+UtTgwjnQOVcFuNG5EXAid?=
 =?us-ascii?Q?/abvTfUO4nSfDBr1K0T7MHP4m/uTBPQfRc89W2WXxX4awva2Dz1R9DLdQJiO?=
 =?us-ascii?Q?tXsxyq9C6vnRRy8xR7nGl2qVA4ujAJNuQMCQ8HhzgAvFrmc2DwDH14Z3MRnb?=
 =?us-ascii?Q?YH2mijQ9CE/lYhrYKei1FQmY/0AvT+UQwbK5wGPKPbJsd10aBwVhBt3URCqA?=
 =?us-ascii?Q?A44Sjjy79fO+GHeVbMpl/k2minfL+P0TsDwEcTTgRSC+VqnkA9P+yV2KNg/N?=
 =?us-ascii?Q?5ZtLsxnVNf1/EMMRvNme5j6URF18eIvasTymdI8kafedXk1EtexlxWdpGKt/?=
 =?us-ascii?Q?ZdzkUPfyOCEaq41xdHXolQrBrV1fCSeXRYw4TpZ/fNSogJLXUUGtMM+kwwKK?=
 =?us-ascii?Q?Q676yE6/PgxIORIg45bH0yabhomHSNwMmpL+i8tRe0klGtJhZa84sZN5/fqb?=
 =?us-ascii?Q?ZHGQvPK3L7XBZkhOD9IirexKY0ZtSHfM6qKM6Gx44eCqo3xbMewiNz75L6RN?=
 =?us-ascii?Q?0/nKxtR0UTcZ0cdF1fvUumquDlBaqYLZsXp3F0WI2QDsW37BgrHmuewG5hP0?=
 =?us-ascii?Q?Wmx//vuMJfoYH+MDlQUR6QYeiNBe8mRIi4XKUjF1Epx27uRfIzTYQzW6dLCz?=
 =?us-ascii?Q?88saQyFkYylJJ23MkNr/l3VOsH3j7TN6qe27gBIqS/OrnQWN3Ecg2RMqKTXn?=
 =?us-ascii?Q?2fSKWfQk8SMdmWDTMNHi0lbXr7OcorDh4InF36/6/cb/PF1cGdfuiOTLasSn?=
 =?us-ascii?Q?EeBCRhmOGespSNXcrwxH4QnAkZPiN8wOaQ24M8jNTbJdH1OIc/jWmzVSKC7I?=
 =?us-ascii?Q?uiL+CNufv2b+E77BtKSxywiaKKp/0+B4L8HsX+exPsA7RzvEwZAbaHx3f48w?=
 =?us-ascii?Q?D43XgDHufhw0eNz4ZMxg6AJuxgvejdb4s4LkwSPB0cBEkQ5bZORaGh8hNZfS?=
 =?us-ascii?Q?82WeY5jNLfhZXaDHjr4/L5Q6P5uvhMhOXY6d1n4IpZRsPhptwGRzaiXG+DIM?=
 =?us-ascii?Q?zXZLi07+teX5NwDYoFz3DgxV+/iWwuXAFV6le1V4auEvCSMOykiftn5/FMMF?=
 =?us-ascii?Q?nsWVPMaZdQgMldh6lFnTge1La38ukGo2jS0rFs/s9kXZ7RKO+PwYcN3bGGHY?=
 =?us-ascii?Q?vrMjpQFLIxwPQbNbCKXNnbAkxCpcO6H+C4zQHd1ur32PwWSMUFF9Bag3FC1/?=
 =?us-ascii?Q?F7czXpYLY6Ip24km35/b+KuZFGYrWDTdpScYHSb6F5NDVNUqYLAAWO/wjFu9?=
 =?us-ascii?Q?+R/uBCs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3xqNBmJJbKHg4zmsVtf/nkFRian5J9yNFQuE9di6/+yRRO+jzAwZoZVts5ok?=
 =?us-ascii?Q?eicb6Zd+kak1DMV96/UFHhgMGVAYKZK41VhfboqTk0O6RZo2ctopudRlpiIC?=
 =?us-ascii?Q?2VS/qV4zDL6ioQ5MTs7V6akIS2KyV77lt031rTLowdPCqlr4ZSy2NJ4HrKWR?=
 =?us-ascii?Q?YNQNhet8QCZM+pGCUtvEXsWXMjayAyNaGQYlHaJMQeTbYAW44lciKfPQvpza?=
 =?us-ascii?Q?lyOWn9IWHuOYyZMj0nzKU5tlJz0Cy+rWT0YOgy6P3o50XlH2szC9GdLg+hzo?=
 =?us-ascii?Q?pl8wvQ11FvOiSONfHVwQrgU7pbdQ0800Zicgum8HvGyNJYy6oQLaMcIN9fQu?=
 =?us-ascii?Q?OaxpTN7IL6kz5Ns7PwiB6vO7CZN74GyDIrIQ9bePShSk1dWdEM4AcppQZL+f?=
 =?us-ascii?Q?7p2p7Law04zHeE0xyYeJk2ig90IyWs32V5J9S4D7izUY1BfgxqRWa7KoiNXm?=
 =?us-ascii?Q?dBVsiVQTS4q1Oie0NAs9rG7yKFCFGmXjoySKir5hPHPii1I2s6KGboX6H7pe?=
 =?us-ascii?Q?SR2OssjrAxHLGQoRB3MVP53gVOt+ZcUKUz4lu9IiGRG4sLfVsfxiOu3dhRTl?=
 =?us-ascii?Q?FH7PjZesbdMqmXtC0LWhEojCZo3/rbIJ2Vs0SkzRl1SK876EPi6lWH/gFGbJ?=
 =?us-ascii?Q?SG0WK9ykTP71vmfS0Cqic6grpQHN04RpNNEkRxHP+cxP+REu1yCQuzU3Haj4?=
 =?us-ascii?Q?HUVCjUfwuVlkn9NfVcdgDIapYwzUKO8rsJCyn2+H/x7vDQ1eQChCBLg2Hz70?=
 =?us-ascii?Q?I1YZe4Pzld3qJM8d8kNEqqmJ7uAx8cWUhiURs1Sa5BLA6kcG6QjALtzpoNS0?=
 =?us-ascii?Q?dGbuNR+iqAaP54rtiFMF4zGEVeQL6Etzh6VqoVJz+xrEOCMEZTrkhVJ07k2R?=
 =?us-ascii?Q?gDoIud0eBaw/0ZoFsp0gmiTs+nk+EDXBdw/0gq5L6dqDtWMpi+GpJvk7ijib?=
 =?us-ascii?Q?QFRz40geePjJfAQzdDk0v1AtDn9IQoIRDX9g2Z0RsAzgvfbwDe5s0jTfcwU6?=
 =?us-ascii?Q?ETORf3TOtuHp4YRic19rOtTjIXnjTvNjqnMvaqvkInEqkPRqjHNXX+VBymjj?=
 =?us-ascii?Q?8KEZaofn/fxkUhmJFLIqJr/S916X2IPfPZQDwlBu081yBvJEMNlYLhRLywY/?=
 =?us-ascii?Q?NAhiFRMwR9bTPz7v59Hupc/iolajEkd3Q9vEJyjC3seQ1ilHqxM+L+zJpa5L?=
 =?us-ascii?Q?NW0Ob1BiwsX9l/IUgUax6BDjjnF5SAD8ztQzRQZXT6m/TfoDB/DbxqJXsAVs?=
 =?us-ascii?Q?Cd9p/dbKeA4nLkzeOvh7D+bxyVGHzjwjMSBu8GHtlOGbgiX0LwP/2pbo07k5?=
 =?us-ascii?Q?DL1xq63gdCEdY0LjIRc4zdCUTQrpszDuMYgyXuqZ9rHFh3+QyEiZhUZxYRYA?=
 =?us-ascii?Q?7ao2D+JK3YRpXMyWBUMDHwXFA0ml+oIvyPLNUl2H9/CDd992jYHAAN7bL5h2?=
 =?us-ascii?Q?BLPCAOgMQ5LQgkhLuH5R2tS/IYyi1CaMQMOfg470LRi98f8RFv+jSgplGcVK?=
 =?us-ascii?Q?SMuBLwm8CwQyIn5NzSaG0p5MMofBZsxO+Hcu+uQJeLSanyOav92o6sOcqYGY?=
 =?us-ascii?Q?iAJMU4MsUnlvCMw5jXhTYlHzIBCs5CskYc0pYCd4Z+FEtxxeS5crbuY3L955?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e3f6d6-3d27-4002-74c2-08dcf4273d98
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 12:27:35.5394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYIAYDmnKC6pMnsvit7y1ehNmgyiSi2UaPviy5DlZHaInQHQCDcy0o/JlqOEw/kqy7g3qmLbncoshMiAn8wMUZXe5W0/psamLcnnFwGoWa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7498
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

Loading flash.bin using uuu fails when flash.bin does not have the
right size.

When flash.bin is loaded from some storage medium (sd card/emmc), SPL
just loads some random garbage bytes from beyond what has been
populated when flash.bin was written, but when loaded via uuu, SPL
hangs waiting for the host to send the expected number of bytes. Which
is (size of FIT image aligned to 0x1000)+CONFIG_CSF_SIZE. The
alignment to 0x1000 is already done and is necessary in all cases
because that's the exact expected location of the 32 byte IVT
header. But the IVT+CSF blob tacked onto the end must be a total of
CONFIG_CSF_SIZE.

This is exactly the same fix as 89f19f45d650, except that this time
around I don't know how to cleanly get CONFIG_CSF_SIZE.

Fixes: bc6beae7c55f (binman: Add nxp_imx8mcst etype for i.MX8M flash.bin signing)
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
Heiko, can you check if this works for you?

And if somebody wants to pick this up and knows how to get at CONFIG_
values, feel free to fix up and take authorship. But perhaps it's not
really configurable at all; imx8mimage.c has the value 0x2000
hard-coded, so I don't think anything good could ever come from
modifying CONFIG_CSF_SIZE. If so, the right fix is probably just to
make that knob non-settable.

 tools/binman/etype/nxp_imx8mcst.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
index 8221517b0c4..9a1974cc522 100644
--- a/tools/binman/etype/nxp_imx8mcst.py
+++ b/tools/binman/etype/nxp_imx8mcst.py
@@ -137,6 +137,8 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
         args = ['-i', cfg_fname, '-o', output_fname]
         if self.cst.run_cmd(*args) is not None:
             outdata = tools.read_file(output_fname)
+            # fixme: 0x2000 should be CONFIG_CSF_SIZE
+            outdata += tools.get_bytes(0, 0x2000 - 0x20 - len(outdata))
             return data + outdata
         else:
             # Bintool is missing; just use the input data as the output
-- 
2.47.0

