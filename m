Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91894C3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 18:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A458881FDE;
	Sun, 13 Apr 2025 20:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sii.pl header.i=@sii.pl header.b="uTlUlU3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1155B81FE8; Sun, 13 Apr 2025 20:38:30 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::72f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6FA581F6B
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 20:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pkochanowski@sii.pl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVa+ZqvOJ+tcSVM+WLBHZ+8Zux6VKBhSDvaMn4XNoqkCG0VSQxs0vdCE/xba5xSdnKt/JZobb9t4Z2NYQ4h3QmPZEvTTdc0BA5IUhM1tnqP9vntdgdWq+49q+dYMGHp/ygok+poLOstIptF/krQKtzG82ZH/zsv6KmYqgwHk7sZcRrVyhUu+W7LzEtCFhhFmefFWl9Rqi0OPzoxVYA3A5kITc2JVjfq/nKx+9SI8cnjo+Z9kTpvIL3SvqGzZ6Qm7xTppl+MYb+LBLmhh8TJMvNoJGbx3QqcCe7tQygNPT575dM9gjm2nhWzVAw8JiZR83tY8xtM9OYV20an21uRxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C66cm4cuNy0xyXe0QLMb9XC8gAPNs9debdG3S7WPRjI=;
 b=Ry/rc1aBfn3pJPxqDDespjB6dxhxAfjAvTVgZHgeUDynCb1EvytRfCdQwW17SeZ9YgFl2pwDl7Z3y4plaGCmt4oO0EUBPmPxSdSVYwsofCtedNhiEwlBtSJmS4+ENgFFS4W6T4z3Q7IuCJqAJOo6rocRYwdPu+u/pHfIaobkPqXd+4eRLpazyy1Zu/jGSYqO/Vp4PRfLvctPzexaFqMfw4+PZ/JoB9xg0v1OlluZRXIeittj8XtvjLxGNcNGB/bikj6n8IiTFx++pU1u8jtzBKNpgEfQZJ513S18xR5oRraIRZoRBzOeoLixWqWbTiUhZ5wr6PgaLZ5/tbHRcQFFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sii.pl; dmarc=pass action=none header.from=sii.pl; dkim=pass
 header.d=sii.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sii.pl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C66cm4cuNy0xyXe0QLMb9XC8gAPNs9debdG3S7WPRjI=;
 b=uTlUlU3VMDfaOuQklfwkSuuEEAY8Pacpg031ZfVDx2wjm8KADEcGAXgNTT/20llsqb1w1Lnyca/Nq5U4t6BZNHAml+dCMB8buhOr2OmN+M1H3s9U3/OJNr2U4Tq27slAHy1SNgL09STc7c/LwdBvYonYwOKqyRJUwPOniFH/ZxRwhu7R5iHkjkcxVGS6X9sKwyeETJs0dHKN1i1zrC20RatRJY4xEw4Nz2ng8Ka+AeUcNcvoQF+pvkI7eB5XnQMSLxm3CdVwlncB0/yFKcanqNBYNend/ew7sev2aXDpUagfhvZXt0/nTTeoM1OlM8YgeULBlbW5t0ZCB7TdasMToQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sii.pl;
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::16)
 by PA2P191MB2492.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:40e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Sun, 13 Apr
 2025 18:38:25 +0000
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331]) by AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331%3]) with mapi id 15.20.8632.030; Sun, 13 Apr 2025
 18:38:25 +0000
From: Pawel Kochanowski <pkochanowski@sii.pl>
To: u-boot@lists.denx.de
Cc: Horia Geanta <horia.geanta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>,
 Varun Sethi <V.Sethi@nxp.com>, Pawel Kochanowski <pkochanowski@sii.pl>
Subject: [PATCH] crypto: fsl - Add cache flush after job descriptor swap
Date: Sun, 13 Apr 2025 20:38:09 +0200
Message-ID: <20250413183809.7696-1-pkochanowski@sii.pl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0047.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::16) To AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:1ea::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8P191MB1394:EE_|PA2P191MB2492:EE_
X-MS-Office365-Filtering-Correlation-Id: 69162cca-b973-4054-c73e-08dd7aba5fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oDDOfYzt3CXgSOIsUoKTuvlAfPNaE3T/ZZ3H8Hkvu9bSK/oXqwcxwwdQKHfL?=
 =?us-ascii?Q?TwM6yq5dNGSDpk0DN6kor4eGY2u5YNooSylTqU+AvpmkeO9pwhrViS5Jnm+T?=
 =?us-ascii?Q?JYChLWastVdYdmkPLLHt6XdQD3euE9zzC+Kak68XL/ATbbT3NdGG98UHuhHg?=
 =?us-ascii?Q?yca2Cq5jUnVPIHm71I3FE/TZbUdh0fffBpq0Mrx+wDGP6u0QG8j6piJkIdNV?=
 =?us-ascii?Q?UxNgrKT4vHZmDg7jrWocDMyraBZMgFAtyfljHaxfa+mkS1lI4sdgUlAya1FS?=
 =?us-ascii?Q?pHh+Kg3StWCoKR7fulz5Bq4TJZZQ4ecFcw7CS5G1X4SSCLyxNwT6YoRup3IK?=
 =?us-ascii?Q?GT0XoiXicp+f6ULFIONWMISCUIGc8moBHAmCMgszuUaV+nF6/LI1Lo+GL18t?=
 =?us-ascii?Q?cn9kfAu6cNjPGmeseWUiROL12pzPua4N2m9+ExbjZiSSREzzhxiIg+JIu0gZ?=
 =?us-ascii?Q?bube+XlB8n4QO8yF5pb6tU9BHdPFFjeGnnw2caZssIbh1c4kAAPyWvUKFZWD?=
 =?us-ascii?Q?qiOQI/RG3cu5/3GWli8A8tFolfWfXFk2RCh2ue048HX+/omy9XAG5jv1HTS+?=
 =?us-ascii?Q?S65eeUuP7oPgsj90qUr9PUgD8cROXshHJnBY6paplRR4duJ49W3ugg4jHk0Y?=
 =?us-ascii?Q?MtPqjQQKjMvPkDx1BxRA8JH9ojYrGFgFlBX4fIcc33LWiVc1mbfPqIZ7ijAq?=
 =?us-ascii?Q?/3rJdTU0hYwj1R1qg1lEtY6sMaGsdEEnfUoPdzuy6A4emQt1oyI3nOQgNYAj?=
 =?us-ascii?Q?X6lK+RecAYOG2N6isonaR4+P4Wq5UtK+acWxp4SWRYEhCy1enL2qK5my9K/s?=
 =?us-ascii?Q?sa0pnGIIx6uzCRfVNL4BKxUC0YiigsL+7ujnMrmhhyKNuBwMv9zMiPYM54P/?=
 =?us-ascii?Q?JI5fhlAnPe40geA8oze+dXpAgTmhjOtMmD4q53SFDfjYMEMBw401yxumuDc3?=
 =?us-ascii?Q?Q8KFOzcY+/jbhpMjYSFf5yPQFsxOy/Z/H1LBaJk9W5z62q7eIW5pnV+TXIpN?=
 =?us-ascii?Q?uGjtlbmx3lgmB1WMW0kL0cRg1anG1beuejV93V21N2RWa0Xl/2IM/Mvx84pH?=
 =?us-ascii?Q?9X/droDp0AyAx4q/pcpQo/PETmOkmeRt8Z1Q5400Ut6evj4g+3bh1QUdo3E6?=
 =?us-ascii?Q?nu/9OjT19SqpeMAiKnno8Z9be0eW+1B8tIlCwDWWZeNcfRecSuh6pRO2b8xQ?=
 =?us-ascii?Q?t3LB3q6LsYukk2HFEpWcxIBOwHLVkYUOXP1nE7vSXmwhytlMN5kpqPOpJEA0?=
 =?us-ascii?Q?qWe1g4llbTUa2rMCDqwYLZFVNtVmfMM5ISz114GEyN/e4yRHN16NUG/qkiVZ?=
 =?us-ascii?Q?Nz3W/HxShy4ubRlKEQpcUPF9fLsNgC3oGnyqtgq7mMSE6+7LAG46QaXz+bqN?=
 =?us-ascii?Q?ykYeEyefyQs26EKOjyMuxgUYtvyT1EbiDrtcO5hN2I8dYItw2faEQGVMuYAw?=
 =?us-ascii?Q?qWTFe4M8FUUrD7ClRCB0OGFELmUe1tIZSS3PVDa5GgpZ1jRA29bHrw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8P191MB1394.EURP191.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jKAAFXseKBjY+TqN7trVP94fDYeJXH/Uemf5q0EVbXuNBOSGRV6fxN9fsGON?=
 =?us-ascii?Q?cqs+zcSKpVgFBnEAZlJwb8L4VUuD7PXQsQJfOF+H3ZW1g6vYtC1DBYtLIXJI?=
 =?us-ascii?Q?tIrjTCYHg1stg0F7D+fP4dw0xe7fPVw1hu4W+F4RH96YSxbU2ZSz8yMeK6I3?=
 =?us-ascii?Q?VsS3CbjpmItsBMZJ72aPon2JvJ+762tB9ASwLJMchjB75/Wd5TOrS0CulyQT?=
 =?us-ascii?Q?123+F/JHh6oalwYVWkCJSUJPRjC23FQVo8zLLn2i9eZWnGZkZ4/WDv18szjD?=
 =?us-ascii?Q?etS9k0elkcXD/Lc75Kdzv60jbMZaHIE+bKKKEYpuqmuztMfIHN82ABWqxx/z?=
 =?us-ascii?Q?CFOSOFTfj/EoA3ZKhmRwUFE5k1YG8mJ9iabKxyKpgyAldvQS4NMIpzzAT4cR?=
 =?us-ascii?Q?5UAOSbqPsBBw9CCg+S7WO6MlZZIvy9bETxlYIiuvbos1e163ZJGU2wTUWHdz?=
 =?us-ascii?Q?bkoznRT5itgyfw9Al5bQ3PQFrMNlEkFTx9XcogmxMuWYM3vldhPIvb+N5qev?=
 =?us-ascii?Q?MvhyIA81BMQZ728RH5Q03D2IOrFVL0Q8LqZ2hheWM6OSFR3tmf4enlb0EcKo?=
 =?us-ascii?Q?UzeuYhaudMQRBxvzsSMgqREPy6qKn4+R9naj1DlHsnWMOxDYtVVE1eNVQ3PI?=
 =?us-ascii?Q?lu9pOl7Sx8PXCsHAQU0Z+Hfdefnqf0SqNYKdRy40zyRBDpb/z6KuSdhlG0k4?=
 =?us-ascii?Q?PkvY07ffb8QgCgWKr2zgJfvoVUX97/0xc4OtGlnfo5yCF0narLFspBNLlCBP?=
 =?us-ascii?Q?d3hNBacOREr6ERInU5G/9B8SRsCvvxCqXtjIyQE8yh05XhIUoSiOB7B88WPY?=
 =?us-ascii?Q?z7j9Wo8WXX79Cq9JrskwfrtdwrbQi3Hgh8mXXeWkWKVI+ijoQYes+fVyldpc?=
 =?us-ascii?Q?DGNfcbaHKSH4dwHhp98IbMlW14cseyHhoxYPizqH7TLh05KaAsk+KCngu6XL?=
 =?us-ascii?Q?+U0XMerlIbroN4oYm7/IDbOGO//hmhc4kWDH3gCXCMOlytMGHsiWWalGDzEY?=
 =?us-ascii?Q?DYVxyVTEpLCebYgzZlz0sXeXqHK9D2ew9BPy4N3yiLyjRempmRuuilZFrOxS?=
 =?us-ascii?Q?O12N425g6g3sUlsrDSAFN4uv+BI5XiwKSM86thIJLOex3KJBDUGTsy/zPsLs?=
 =?us-ascii?Q?c2Pg1BQ+Pr2K5qfKyaCmPUjdu2wfrGrH3Z1jO+LrjazSZvyWGM6mm5sp2Zmc?=
 =?us-ascii?Q?AQh75KS9xQ33eFpJYIsFCwERQpZbCfE3eBN+QL/wfgqtjIpwPgCkWnB0+niu?=
 =?us-ascii?Q?NHruaSOqbJLefnCEpt8hKxepVNalTlBmX/jd9NzI7JAwAxfyLLVUMIqnqsHc?=
 =?us-ascii?Q?jjMiWhHTxC25UbbmVLyGAtZeejryyv6Ihgbz2HxyvcHlhhXq2hIVrYrJoxHo?=
 =?us-ascii?Q?kUJe71bxraxa9QiiSf4REvbZP7K5tzueHBJlW2skgxmWMsIUdZAWlAWni7O2?=
 =?us-ascii?Q?lKOz4V7kC8yvjFCy1Q67qKwxTp8PFO/6nsC+g48QOR4JnrjgEKkYuLjpGh2v?=
 =?us-ascii?Q?N7fr3PKRah9U/wJYjiv+6f2UICzw1BqtcBPTjQK5MCaOUf5XbwuPPMLWWDZF?=
 =?us-ascii?Q?PAY3BufaPkn3t/Rc7apA+84qWX3ddaF7HtcvbeU2?=
X-OriginatorOrg: sii.pl
X-MS-Exchange-CrossTenant-Network-Message-Id: 69162cca-b973-4054-c73e-08dd7aba5fe1
X-MS-Exchange-CrossTenant-AuthSource: AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2025 18:38:25.2950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f9bd6df6-c449-481f-abb5-37bd036beb76
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Mb+71mHx9Gq7Mu0xmYxA3cF4UVJTnEfe4b2DthL6zUpr+qZWc1CHCh4KJe5QPPn/0rfQqyWjT34dUSEfbmahQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P191MB2492
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

On devices with CONFIG_SYS_FSL_SEC_BE an endianess swap is done before
sending descriptor to SEC/CAAM engine. A cache flush needs to be
performed to ensure that the updated descriptor is taken into account.

Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>
---
 drivers/crypto/fsl/jr.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
index 8f7a821ebf3..5a69e1f6bd8 100644
--- a/drivers/crypto/fsl/jr.c
+++ b/drivers/crypto/fsl/jr.c
@@ -162,6 +162,8 @@ static int jr_enqueue(uint32_t *desc_addr,
 	uint32_t desc_word;
 	int length = desc_len(desc_addr);
 	int i;
+	unsigned long start;
+	unsigned long end;
 #ifdef CONFIG_CAAM_64BIT
 	uint32_t *addr_hi, *addr_lo;
 #endif
@@ -176,6 +178,11 @@ static int jr_enqueue(uint32_t *desc_addr,
 		sec_out32((uint32_t *)&desc_addr[i], desc_word);
 	}
 
+	start = (unsigned long)desc_addr & ~(ARCH_DMA_MINALIGN - 1);
+	end = ALIGN((unsigned long)desc_addr +
+				length * sizeof(desc_addr[0]), ARCH_DMA_MINALIGN);
+	flush_dcache_range(start, end);
+
 	caam_dma_addr_t desc_phys_addr = virt_to_phys(desc_addr);
 
 	jr->info[head].desc_phys_addr = desc_phys_addr;
@@ -183,9 +190,9 @@ static int jr_enqueue(uint32_t *desc_addr,
 	jr->info[head].arg = arg;
 	jr->info[head].op_done = 0;
 
-	unsigned long start = (unsigned long)&jr->info[head] &
+	start = (unsigned long)&jr->info[head] &
 					~(ARCH_DMA_MINALIGN - 1);
-	unsigned long end = ALIGN((unsigned long)&jr->info[head] +
+	end = ALIGN((unsigned long)&jr->info[head] +
 				  sizeof(struct jr_info), ARCH_DMA_MINALIGN);
 	flush_dcache_range(start, end);
 
-- 
2.43.0

