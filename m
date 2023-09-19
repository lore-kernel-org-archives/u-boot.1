Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933C1CD54A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 10:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 874F786AB5;
	Tue, 19 Sep 2023 12:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="TUa/ANPo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 043EC86996; Tue, 19 Sep 2023 12:00:33 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::71d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E21D86AE1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 12:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOiIV3GcWmvPCod/s6nVcQm/KHQrhiVMo7ngNB/STabqYygYCMUvt7MIGmmnAinCXIDZqtZiCaNs2Sei481VO4Otq0/dR2So/1TDQ298LgnbnCCzrvgouaAokN4yFr6fJpqJdHTmCohZe4YpZ57l3AqhuHEFoZhLGGhTMtX11jXJC1WgbypUZGF9sbStRViL/ToYfL+C5yXRRAkfc/CjUgyNzLkN/AvBkQDoPPZBVLbXdm540fi/HfmF6KP5E0sItJbA6RKvjn2PIexBQKtM3SxvIBE0HzH3aO7huX8MRJtFbdHfO7HiSgAckUog5SY/kGXKp6wY8nhAhsNQ1YF7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XVH1mGRbUX6CRm5DhHdqhV7GDlm8x9+RmevLOcI3Yw=;
 b=oGB3DgScOlgvuNJ6ot5nwY1N7Zei960yafgQ63/i88zQUUQ7mY9+jb6FAJ8p6EwhueTSdkr0wRNvjD6SlV62Vx5AVtrY3clKC1N6gKhGAUW0n/7kHufbEW0vLwoM6Wd14alk1blDv5JXc6rGuljNexZ1mzmQJ/46ZxX0LV2AWvYl4adaskHbuDsMlR98pRiTWRcV83jHnOFmJ3xwzERFhyB6seehOcfr5eUCoJYhSJifhQmVopB+R32GwtNFZJU4JEfmttaz7pmSCHGrpt7oZU9BXymwBZiHPVpgBedtFZfUYUS41ZBaUfs2ikl4Dy9oAb6rCxzOvTsZgCQYsEuEIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XVH1mGRbUX6CRm5DhHdqhV7GDlm8x9+RmevLOcI3Yw=;
 b=TUa/ANPociY98xokBkndvCgwKYkS5AF3yVTeXRdVzyCXf3Aeqxv2Z7khdUMw59Wgy9FMyOYvv/bumbBQnd62Q7GZI6JhzYQtEZ1GiFvdvOtOpj7Sek6je1vx7cry9Bn+HyYPUK+aH0wkNadSgjJj5ZZitP2eITQ24xzfYJv6YyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB9PR10MB8286.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 10:00:28 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 10:00:26 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Marek Vasut <marex@denx.de>, uboot-imx@nxp.com,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH] mx8m: csf.sh: pad csf blob for u-boot.itb to CSF_SIZE minus
 IVT header
Date: Tue, 19 Sep 2023 12:00:17 +0200
Message-Id: <20230919100017.43523-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0115.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::28) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB9PR10MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 027e3824-eacc-4594-f4df-08dbb8f73f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irCjGq5pGbAS9U9ZBewO2pso3prWjx2lPNCXlhaM137W+9+d+ClYUfXvcysqbt4461TNdoY+lwo6iv3s7/z/bRIFlBBvLzpL2xr1l/CJBQ7P34CEw5rP62mhAO85VzhADv4zWLBJFWtv0thoF5nuYnK8Rc2ziSvOT9o6qfJVm1osc8QJ4fGdV5tdFbkD9vuXtUXVWA3Vb1VyElI8vOYWNoaEb5OQX0haUl8PEoF1DI0zawAYruPJ32db/RcquY4uRSNEfb1ryoE64M8CWZK/n2KGt/frNxDNpDjzGG9rh5VQ+9RfiLGosDBeh+/WfIuDShiwkONhS/aarlFgW72t+e8NqZx/vUDLFuomX10s74GL9nsSPHSquKi2l3WQELZ20O7I7/fxym3wzqpIcNCvEB+mVUC/yn+h7dgRtgg0vRlq5dO12FgEvLOOvU5gQax6bV8uhKBdt+LdbAo5DxpwJJ5Zs2TsIup5kf6yWr2NziVEBGMdq3MasqDVaNg9ATFxkvQAlRXpvRAbZ1ep9J8MK4VstnE5LWELmsMJYf33JEwOxkrmAHlrEkXOk3Qtmvl+TQwyk+T8p2FlbaT3oyQAXZvFtEbRjHf1veH2rDxSnmbV0hdr/Hoyd1ZSOvGnWlHnhhx7qNPPJi1/ErQqzQlhQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(376002)(366004)(396003)(136003)(346002)(1800799009)(186009)(451199024)(316002)(4326008)(54906003)(6916009)(8676002)(8936002)(8976002)(41300700001)(1076003)(107886003)(2616005)(26005)(83380400001)(6512007)(478600001)(52116002)(36756003)(6486002)(6666004)(6506007)(86362001)(38350700002)(38100700002)(66476007)(66946007)(66556008)(2906002)(5660300002)(44832011)(32563001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OMIWc8m4Mb8cG+rkbmhMTKEMkfpIT3ojkkvjKt67sEKMCQbtn1ieWmmt0bSb?=
 =?us-ascii?Q?kYAzu28quVEmrXcU+kx8oHP5rjKFD1enSKjIAnkZ2R07ImXvyDTdA4K3GAi1?=
 =?us-ascii?Q?0AZj6Ewv0s3+cVdqdtoOjaQE3XuxDEXuNv01JgiG8weg3S/rPZ9oq5AF9bH6?=
 =?us-ascii?Q?0wrO8ahgfBjHxBAcQToCNBdJnkNphlLzUaUeDD7x+5zUlJzOb5GMn3DQ4klY?=
 =?us-ascii?Q?i5U3olH0CoZneNsmgKqXPnCk6cYfLTgyjN1hGJyuN7Lv9kjBgJwFMSSyar8t?=
 =?us-ascii?Q?c8FZ2bEnPDRXrN75mj177EqZFsIRCeW6js35ExW5qUbdurIt2Uybb84glGBL?=
 =?us-ascii?Q?hqhNeW7G29Wp9eU/PZ53bT1bv3U189p8fxsL+thwOA3dRI45y8qPQWv20q/h?=
 =?us-ascii?Q?TQUx5833Z5YiIA/LpGEw2CjpH3xbGKFXkvwbQeAz4727oruOgM0ERUDm9Syk?=
 =?us-ascii?Q?sc52G4vVBD8Uk5IYiY9iY/mLmq634MONEHlIKkMi408duCwYCaudvdRR+03W?=
 =?us-ascii?Q?Ca0bfTBZUeL89ifN927MYLvHLAtBq7TjH4PRRBb2S//2f/qZCZPRSMIaO9Ee?=
 =?us-ascii?Q?YGetNnGt2yfCEm7QPREHCjHSeP85TJZi6KC2G5m801ZxeekBfjqFMpbSPlQ1?=
 =?us-ascii?Q?UGwNMBrcY3Zi7jsEB6XdqXMP1BiqN6VQkxEWKUInFLkGWel8AjrzOGJ1A03v?=
 =?us-ascii?Q?bjB9o5XFbZncvhlcaXAyxesayp8gYKOKFTG7xt9FtMseZSEWySroOCebAecr?=
 =?us-ascii?Q?wcll343CAAGtIVGLHS530WQPIK6E+6kGyiSm7A5KEmf+5IMBjlyUgUo7EeAW?=
 =?us-ascii?Q?lnPvlgb7s9kZul0Cid8aLcvN4jzQjB6DiOEDHlxJK78kZa/g3Rk5MCHofaDH?=
 =?us-ascii?Q?8RMVA7DRmMroIhjT8PPN9eX7jzp/Wh5/t5ciBXXNfoAnzp4DNqAf/RIfli/R?=
 =?us-ascii?Q?7m1A62MqfEMDYUxI2maxp8a5WBTc6ilxpI3fQcyQAnpcAUer6mVQRIUH+ELj?=
 =?us-ascii?Q?ISAiPtLHEKjDVNZxOLfEgCFfrZ/4//8m7q7JFZsMNPagxMfWS9JF5Luuh37D?=
 =?us-ascii?Q?HwMgWY+pVBiNUi+WyNdNeEhZXKvIryJB+M3VmzR2cUY4jJvlwb9eqpTabk2V?=
 =?us-ascii?Q?oR61a2IsmDb2sFWbo64Pdc97ZGFcbeSahA2D6WdiiKtLrL7xonbIB6SeMwuA?=
 =?us-ascii?Q?SIPqx9Ele2AM3ZKkW3ipH/drSiMK0BwDoUXA6CChBh5R2hl1KYN6/cbA0OgM?=
 =?us-ascii?Q?qN5C/4bBO4tIdaufioHBvgg5KrvOPG/CURdE+jvCFr+OgEdOWJWKi9AZ8TuA?=
 =?us-ascii?Q?hNi5hTOZRCg3ttMXbGGHldSEpTJDyh2OiXp2fLvSS4W1gElkkaQPw5X4HLXm?=
 =?us-ascii?Q?suAy32VkrCiRYslf4M5eAVJzpWuZFRRCD/w6S18fv54IggRXjkU+bV/8lqgb?=
 =?us-ascii?Q?iaSZjpkeyVJDfmqk8TKqnoJ5b2XcW9VvBx0jPG/hnXySnf3rKBOFXFLms3YM?=
 =?us-ascii?Q?3OnsuoIT29tFS5bk2LDagOhUvKtJsV4aWfCzB//iEypADINIO5t4TAoDPWga?=
 =?us-ascii?Q?e4FBLEpayj7cq4X8ZA+IenlI8K3zuIFrtdrb8BxKtmEgC6VnsTCFsnGeIGQq?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 027e3824-eacc-4594-f4df-08dbb8f73f8b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 10:00:26.6837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asHEfyOfnQ+zgXbbFUcNW0GFPFjZ47LDCoO+u1XE2M6QENsTaPn2zE2fuSe6U4pPRf1AGSnnsizWHI6TBzOxI7M+2ieE9cSmkU9g92lM6u0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8286
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

When built with CONFIG_IMX_HAB, the full FIT image, including stuff
tacked on beyond the end of the fdt structure, is expected to be (fdt
size rounded up to 0x1000 boundary)+CONFIG_CSF_SIZE.

Now, when the FIT image is loaded from a storage device, it doesn't
really matter that the flash.bin that gets written to target isn't
quite that big - we will just load some garbage bytes that are never
read or used for anything. But when flash.bin is uploaded via uuu,
it's important that we actually serve at least as many bytes as the
target expects, or we will hang in rom_api_download_image().

Extend the logic in the csf.sh script so that the csf blob is padded
to CONFIG_CSF_SIZE minus the size of the IVT header.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 doc/imx/habv4/csf_examples/mx8m/csf.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/imx/habv4/csf_examples/mx8m/csf.sh b/doc/imx/habv4/csf_examples/mx8m/csf.sh
index 65c143073c..80edc94aeb 100644
--- a/doc/imx/habv4/csf_examples/mx8m/csf.sh
+++ b/doc/imx/habv4/csf_examples/mx8m/csf.sh
@@ -75,5 +75,13 @@ dd if=ivt.bin of=flash.bin bs=1 seek=${ivt_block_offset} conv=notrunc
 
 # Generate CSF blob
 cst -i csf_fit.tmp -o csf_fit.bin
+
+# When loading flash.bin via USB, we must ensure that the file being
+# served is as large as the target expects (see
+# board_spl_fit_size_align()), otherwise the target will hang in
+# rom_api_download_image() waiting for the remaining bytes.
+CSF_SIZE=$(sed -n "/CONFIG_CSF_SIZE=/ s@.*=@@p" .config)
+truncate -s $((CSF_SIZE - 0x20)) csf_fit.bin
+
 # Patch CSF blob into flash.bin
 dd if=csf_fit.bin of=flash.bin bs=1 seek=${csf_block_offset} conv=notrunc
-- 
2.37.2

