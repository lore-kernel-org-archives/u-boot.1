Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A86CD5BC0
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 13:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B0C86B6B;
	Tue, 19 Sep 2023 15:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Va4MWM9w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBCA486A26; Tue, 19 Sep 2023 15:50:02 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAD3A86B6D
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 15:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GydSQu7TNo1HXSK4W74l3FVpAcD/Ewi2uttfeMm5Kira3D/pG9r5tyWEAs/fnbDYF1rGr906t2CSlXIrIpbbksgaCTp75iRjTsKIVeeR3A2zSLJvkD1ErqpNuOnPRWzGmv3a3rB4LQy5SOkUgNo06gwZJ9jjBAF3Ozn8gf81OxZFx+QeZknCWTPSqveLEcAk+WKukUyNA4gZNbuFPNLGmTSLcXf33zy/d+Jmca8WnFSo+OE7fGn293NozkVXPu+WFsH/DaU3n3+3fMCPiw9SARVhCiR1W96+KKvV47lV46oeAUc2JMqQFfp4fw0a+Z2n7j3uMe4Hc52GlCPYExRmSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp1EM5Cmmi4JUu0nsf2N5aeWVCswOVRc/ZiyC743yiE=;
 b=Ufl0N/zs/Pi5yW+CFfwwyw2G4DdJfmFjTB/8y2LxgJCRw2uWQOXhi4jTnhm531HPljurjR2hprqUz67KZimTWMqFVfi6tuRpxq0E80Mnx5hcMwbAmDM0EV4etPpB39qmeI7m/viRR9QrwO80ZokZUgNMKCo+0MNj5/NZ02mrTFd5HEyuacYU0XDPS7w8O60yTIBimhxCzTF5DskkqUnV7cWPODhj3dfrXpM1/m2q6HyNUqzVqYSh/lXVYQjGT64QWUuFpu+jwBvZcMAEKGP/GdLDIfXEludc8E/BxNcYhxze1KBK5JFgeONPLNwoF9G/mENcmTCrOv4+/WsT/Inp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp1EM5Cmmi4JUu0nsf2N5aeWVCswOVRc/ZiyC743yiE=;
 b=Va4MWM9wzMuathj2/XNvevW+/IZ3UDo03cEIQiBq7zz1pjqSK9/ch2UeMqJkrUmP/XJjRAAXIuYvW1iZCF0yRfP8qox1G6TYAUBwdl3pIdn7MiPnOAKmuRdR/z1Ky3UYYDi5z0AFgxo2J+nfaKzQD4yBFnO4U7lWYM3DpXRPvow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV1PR10MB5938.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 13:49:58 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 13:49:58 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH resend 2/2] imx: spl_imx_romapi.c: remove dead code
Date: Tue, 19 Sep 2023 15:49:32 +0200
Message-Id: <20230919134932.134678-3-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230919134932.134678-1-rasmus.villemoes@prevas.dk>
References: <20230919134932.134678-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::11) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV1PR10MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba745c7-868b-46f5-7212-08dbb9175020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdt0aLLCgOxGcx2FUqo9ZaJZjNhb74LfWSv0Rj9Z/uvzVc8ooINC4Il1JEp4pMSt+LbHQLRnjjFd4RGZQHigXA40/pGZ70FTfmtlDyRTGVMSdnYk7sS/RfTcElkRrbqPGNhx06RqTq3bukyFI8UeizhDgGlgP9OR7PGfZyE3Iuy11RtkkgCmlyIvQK4RILbH60uARMRkOgzMzbrE8lYJlJ11N83UO0Ms0Ty/ydk5VZdZGmff2TegF67QWD5HGTFPJbtinzoeoxtc1ZajMkQHWVTVImDba4JD4g6j8Pwd4X4C+f2Htmhwjjg23V1PH6XrQs1umdL7IBbO5ftJ1+JWUIgShp9zio3a7Xyx0BiI+kkjOlWYrM0ayBHA55fBgjtRsb4ilD8/xiqiw9VnaMaUprrxSBtMItQIaNPYOGQ8kmt/tRiu3XbidQkSMMFMsvrV2MIbwWGDd80v8mpqnmXpLqRttwJ20zbQxC2qDRztmJVAkHe33N1w0wYCMD10juXzHW2qwn7MeJatmZqPW1m+X7y3L23NiyyNE2b0Y5QK1A0FwWYDxTAI7EKAIRZHC8EjqHJaXu2yJ1Jg+ahhZIFrJBRMtxgsMxCDPQ8tMSy2ruLmKeQhc99YjWvgfRomjB4T
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39850400004)(396003)(376002)(346002)(1800799009)(186009)(451199024)(26005)(2616005)(8976002)(8936002)(8676002)(107886003)(4326008)(1076003)(83380400001)(2906002)(36756003)(44832011)(86362001)(52116002)(6506007)(6486002)(478600001)(5660300002)(6666004)(6916009)(316002)(54906003)(6512007)(66946007)(66476007)(38100700002)(41300700001)(66556008)(38350700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0bxFalIWwdHritLHacPHig1nd0iYycjPYsGBfpbVKP+6GD42pyrYtlQGpcSM?=
 =?us-ascii?Q?U6CQDYOTBV9/S8Itadk8OC7bCuo6WHkvNqIrcvvVHJ1vlbD5vr8XLUY1C8gR?=
 =?us-ascii?Q?XXdz+9My6c7V47LHDhY2EOM8vCA8Q+YM36oi89B2jekjPw7wv7XHgdDMj7XI?=
 =?us-ascii?Q?WplgDVzVsMkC9hyTdEMWfs60GJS0CWCbgFpZV9mnbfkb+FJjX/9z2HclZlZY?=
 =?us-ascii?Q?AOYQQAyV8/e7NF40d5PbZ3VeZQXl8WGdfvFXZtaOrSChMjD+iLBZMXhcVUVI?=
 =?us-ascii?Q?BpoSogM07eTMTOtr/8q+POjv1Ipv4amzBtYEf/tMjSzmDzLWmWGJpvc0LJPr?=
 =?us-ascii?Q?Z00o0mG1Q+cBjpG6Zkv6aaNdzIzCB2WAqPLSQMxR6BFTKAmDZlf6vjBi18fY?=
 =?us-ascii?Q?PLvAp5W3U46aZDc4DMHQ3xoMX4bwN5AHRNE2t+NHyJLD3zi6/k8g1bxWDHot?=
 =?us-ascii?Q?mzAVFONVi3IxxLHjEG2E0a9EmmTCR4S6b/IkPAD2cJ+PeKEj9F4vVD47oySM?=
 =?us-ascii?Q?Q/IDGLpEK5XLDFrhktEaVy7WpZA/Il+FxfiLfE/ZRUzxT1nRJBu630cYnIH1?=
 =?us-ascii?Q?BsgT6L8tp0vQNbzCRw1tAzkGuk0sXbveIgZttHMZYnG/ZftazvCaOZdCbVy/?=
 =?us-ascii?Q?vCR7h1vBGli5zOtnwA6M6RF73+QQPYlFB314vxYKUhujXoJtcS17eiK8mu+O?=
 =?us-ascii?Q?BZwRrrOtgMhzO3h2hZMF8RTsA/vA/DAhnFl4i+5ygoGgcZQy/5IkDRnkXGZi?=
 =?us-ascii?Q?TR4xZK+rRkYSMcmBDnhob3SqWaRhWYHgJiLgJAQrbh1jIAAdmeiltrNM+rHH?=
 =?us-ascii?Q?JZWDQ3WffzyORtN62rf2BViCK1l4fwdtTMl/0PmnQ8NLa2i/HvmwLDFr/1SU?=
 =?us-ascii?Q?S/b7LEpKongN7YSU4MKUDk710Q9JseCHqZb1sAI+rjv9XlwRludCUeqSTp7X?=
 =?us-ascii?Q?nTOjiWLwsSYUBOoy/kfhMWoeys0Rp21gxC9Kk/cs8EWmXb20rpL9yDhBZsbC?=
 =?us-ascii?Q?e6IZkFQ2JCIJwjzHF36tmF7DIjmVJ4rSakINMmiEEdcx0RdX92H/xxMOsbIu?=
 =?us-ascii?Q?Ioh9wWlCyRQmbbMPUp12piLSQSATGpENisEBRQnuklFNRFVXo02YsAgk4l+f?=
 =?us-ascii?Q?Hnbrdf7YLLB2anMIS8gT6CrqVsxvjWFOrO2BjW8FhaQKWNNtlNk98Dtkkt6F?=
 =?us-ascii?Q?EJdichTtsJFR3oI4Oc7oEropAzSGaTS0goi56/T0JcRbCTxU7tmQdbq2F/A9?=
 =?us-ascii?Q?n0va3ZAi5cmPWCftdVurKjoPKwII2YFiefjEioFTRiPeGBhkWUAr1yW130om?=
 =?us-ascii?Q?nCR6QBKLMzyG4HdVf1LhIlaELlqXUG/NSzdCamrqQ2/lvsHDK49Yne3QNQ/x?=
 =?us-ascii?Q?VchDjvN/xCbZwotJxG9Trih+7Ykg1X91ua8jWMBdJG+8iy+s7Re3xIR4yWTG?=
 =?us-ascii?Q?5PgC3EVEavfYtEpoUbKGJ4y5ef+IxqKQ/aZe8TM3c7iVxOoXrbpEIAFTseLt?=
 =?us-ascii?Q?0dfrV6DUTMgefOu0RigllAcrvSsvvYovv9wVvzscyi20gR+C8AxPqpgtPT6w?=
 =?us-ascii?Q?KMDagVHBB2m3rMOxxJqHsfw68MUu+YNShE6E+W23NqeKNgdB4t8v7YyvYVdA?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba745c7-868b-46f5-7212-08dbb9175020
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 13:49:58.3831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3e5XIyijAAm/wYBtqQoeI9utVktSRwzuiollkJGDGyJtpl9yXAWtoxRVnbWKo07uC7ToTx18UE6YfoiURsY8cvW7IumEqQ29Snj56S3zoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5938
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

These IS_ENABLED(CONFIG_SPL_LOAD_FIT) cases can no longer be reached,
and thus get_fit_image_size() is also redundant.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 arch/arm/mach-imx/spl_imx_romapi.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
index b9dfb3d41d..c4a4185eed 100644
--- a/arch/arm/mach-imx/spl_imx_romapi.c
+++ b/arch/arm/mach-imx/spl_imx_romapi.c
@@ -184,23 +184,6 @@ static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
 	return count;
 }
 
-static ulong get_fit_image_size(void *fit)
-{
-	struct spl_image_info spl_image;
-	struct spl_load_info spl_load_info;
-	ulong last = (ulong)fit;
-
-	memset(&spl_load_info, 0, sizeof(spl_load_info));
-	spl_load_info.bl_len = 1;
-	spl_load_info.read = spl_ram_load_read;
-	spl_load_info.priv = &last;
-
-	spl_load_simple_fit(&spl_image, &spl_load_info,
-			    (uintptr_t)fit, fit);
-
-	return last - (ulong)fit;
-}
-
 static u8 *search_fit_header(u8 *p, int size)
 {
 	int i;
@@ -261,9 +244,7 @@ static int img_info_size(void *img_hdr)
 
 static int img_total_size(void *img_hdr)
 {
-	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
-		return get_fit_image_size(img_hdr);
-	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
+	if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
 		int total = get_container_size((ulong)img_hdr, NULL);
 
 		if (total < 0) {
@@ -386,9 +367,7 @@ static int spl_romapi_load_image_stream(struct spl_image_info *spl_image,
 	load.bl_len = 1;
 	load.read = spl_ram_load_read;
 
-	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT))
-		return spl_load_simple_fit(spl_image, &load, (ulong)phdr, phdr);
-	else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER))
+	if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER))
 		return spl_load_imx_container(spl_image, &load, (ulong)phdr);
 
 	return -1;
-- 
2.37.2

