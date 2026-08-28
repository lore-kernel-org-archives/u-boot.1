Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B70C61DCB
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 10:50:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 722BD60708;
	Fri, 28 Aug 2026 10:50:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FlYnct3JuWwZ; Fri, 28 Aug 2026 10:50:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787914225;
	bh=tvd7FHLQI5fFTBM0ChGsPR926xEdsVjQA6s0zrmJsrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iYolnBThK4pv5nzk0j/Sq+iEvBPlyivkNYxKHFWMlGaneqJ3cjwonncZLk9fATbpn
	 zF4e9JqH+H9PewFOl98lqHMcSdfqiqNdeXZeiPGQqHGKBZVk+Fxhg5v8N45ktVdAmk
	 +lsSf3jI0G7UlXwsVQkzzsFYcGl2x5ID/sJQ/OGzKUp59xthIHp4xxlkco+lpwtnWT
	 NUWciy5lalQsCe4JGsDzFum12pS9CHXkoCaU+xMxPdrEseDWyMfWmu0zAx/VgJBxTj
	 apSRfFKpenbDfaeowWDM1j7R+Vv3Lr+gZBKJhk0QKuvh06ai+YkXWggGOG0VEsqAO4
	 DjKAe3tZyj10A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 137F6606A7;
	Fri, 28 Aug 2026 10:50:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A4DDCBC
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C3A140836
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:50:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DX02-YLZGVad for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 10:50:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=X3wrPEQR
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D1F2D4082B
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:50:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLd34/bOVRWB0BqdEfLBZh09cgQsuY9C3T3iwhdpbBuHnPIPSZwEfAI6f0+3Ws/2tLU3Z7nyCKbRZ8+249Tfp7AGl+JE2VQTB8Gh5xrbdjGpaB+vP/w51OvZZmB0jaMQUz85uKgIrq9fjRiqo/qqRBAZxLf0BAELCAlAmvqfA9BHZor99v6WOzPnBR2oQp0JWHltFQYyE5UCctYa5JDDCLiCU0VWFogd7sPA88K7Hs7iak4chOtL77WxocF/5bJDXpupT2VXTm5M3LaTdk5F0xLRDDFIU+FTC9pGwloQFuSjg9dCcfkel5fLrdJOfo3YLDQaraxWO8oZeXr16uxLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvd7FHLQI5fFTBM0ChGsPR926xEdsVjQA6s0zrmJsrU=;
 b=CyjEppjBcYi/0erpZ8JjQngFfs67OW8W7AfQwFQ04f1m+GxKniEorlAtnmYN6zLjumklfbsMrG4xl5QDxHV37JsCtwpRZHSnjvPjxlMLQ8mcEiDO7UJYxwhP6gmgCVNyUx9loGVS/E3Z2RpdFVLgbIjjs1pYiXNWPZ+0KaAQ5EsYp4DRz0hGLmlfg9zHHpam5XO5coVvFpHw+492w/yOQJWFN734ij3cXZ6m1Jpt4w1frZgFwsPIh0iPv+Cz8CDozQ/fzTjnRMJzgxIDiSM4gybdHmiffQ5cAd8ooedvr8dX+RIxHD4oxhZc5yG8IX4CGN6oC/Yv+Fp5NxA3og2tQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvd7FHLQI5fFTBM0ChGsPR926xEdsVjQA6s0zrmJsrU=;
 b=X3wrPEQRKk/tHZk7wguvoyktf+3ri3Pb6+FZXapqgu9djSxT0OSpvFkDpywpgsZC437h3bw9VhZbH+E41Cl6bqzKr6BmpXv/D7t30wx7JdFUrnL9Rc7gCS6VT28/ZzjjrRKOOCHAUwk87T8NMGAHNbM+NxBTdKLj0stGZi9y+tY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAXPR10MB5757.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:247::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 10:50:11 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 10:50:11 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 2/3] cmd: optee_rpmb: try to allocate large enough buffer when
 reading persistent value
Date: Fri, 28 Aug 2026 12:50:04 +0200
Message-ID: <20260828105005.200338-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828105005.200338-1-ravi@prevas.dk>
References: <20260828105005.200338-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF0001A324.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::689) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAXPR10MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b208fd0-9fc6-44bb-ea2e-08df04f22219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: S/peSAvFFf5NwnwvZjLz98Va5R2zzJ3v8lUwBANsIWXa4Mh9Is8XnTTDeEWc9v+nO1VSdRzKKLV6UZIjG9OnpUAXW4trd21rXx0sW/Zn8v9ZuiixLtRhVROoXxfYuw8LvIPKOzBqOmn4/dXKKmWAZQR4bu/bkoseT81tSdqKphsvcSHRWnPBnyk8zaUUB/lTT1/rh9h5+d1dC8cvdgXPTTrB4lbx5o0c81dyCJTWoVC9HVhHeQl/JB4lrU1bzYL8sXLcCbPc+TcVMBkYN2vpcnSzSi0UfFpDoH6PXp+ZxhjUy2CWVpnWnImazSUqePLh1K0/xQAoX8s6xRAyiY02tCmX5Bh+r9HGr5nfRdzBFxojb8nOaLrB6J4QJYqF121ttitYlbYsQZdXkFWcuPi2q1hT0y+ZdqBofu7yAD7qspJeWkOV4GdDAEOUk8WTQ9qygKXn3d1zMu7YXtHU7J3+Yih17lbH08N3pj7AU9DPveIX4YaDv8cVyMiUySCQiElcqrxo7M0xJ+xSEoRZFKoU1bBCRxUPiIna+s575oeI+wKobMCJeeIV8wX5ZZAjUfcXcOBzMNG+h0bftxhLu9BI9JidbKGtS9/cg3ZXIT8yldlv2rWls5AKEQLfDcN4BeCKBRLo0BxsOoMOJel8Hlai/DGMmuotKEqHNo5qQ2vAc4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2k2XrtVjZ1Z7fvHH7cr+Wayoh4araWI+VtKe1QB04w6RSpc95M89Oj4YNAJE?=
 =?us-ascii?Q?APrnLfWBsHJHu0+TqaYU03oPo3QZTS5XniZtKUrF4lIIeShrsnBJPs7maFd2?=
 =?us-ascii?Q?JOX3J0ZWUO0dBmVSZmjt4d8qMz8ye3mZs7zoLzPCLqfsf2x4RLniEAcL4kYz?=
 =?us-ascii?Q?g+qN2sN9QLPgsOYYK0IK9sxE7mnOtc21r/WlF6hFWmi7lN2IYKV6Zfu+ccgf?=
 =?us-ascii?Q?o1+BOXhAO7m8PD5T11po9QIqMvfFF3yEA6U7c3+IkOVqAN5ZVWqHh9Uo1LAI?=
 =?us-ascii?Q?7i2rYyeC17itIJxzi7+lrhi7i0WmYQkcuGR4RDNUHwX240p7dCoLaJ6lbF4k?=
 =?us-ascii?Q?sV8kPhs73b+8545bBnkLnzlQluwGAbL+fWvceksW6ZTR1O78BxxUhk7wqq5J?=
 =?us-ascii?Q?ZFPlZKIiDU7i5oKjZBa0shnYKLXyO1Wq3YPRFrGaGKE6wlg4XWqqfCESl1PR?=
 =?us-ascii?Q?MicNevUHbDEr4XsBIDo00iMvDB85FyQJhcUQJNTLqS8dqlULp0mBeZMPV8vD?=
 =?us-ascii?Q?en9m95ImDLiBq6istFuPJckwSYa/8BBB7he3juzlqQm66U8jbrrwelPFNIqC?=
 =?us-ascii?Q?zvnboQeGIiSN36JuEGsLYImFh26eSqH2qCJpJvktlgMPHwhViLDmj8CX7+la?=
 =?us-ascii?Q?rc2HrCwcZOW2H5X3JNSVrDa0ymU8rrtadKdkH5wpz1Z0dfzt0vD6ElMgcM68?=
 =?us-ascii?Q?9hZi4HGTrGJzRrI51cU+YbYsKv+5eCd5hJlnKblatSWaS0mGH2EMQSjwpWs2?=
 =?us-ascii?Q?1kx8n0PA+P0/WVZ+e2GLPVe7LYbDp4aMxnA2KPWJimiRlE5yeyZemjkEIvoA?=
 =?us-ascii?Q?goCwRkjc5v7OwyGlQeHP7SRebhNevS9GoXphFQ5aqNE6z0yLKpHfAltzG3IU?=
 =?us-ascii?Q?FFl6q7w+0cn5vVif5CwXP5Zqdv8I1xUWpPpWR9ZMyhN53fplwxjqaffTFCav?=
 =?us-ascii?Q?7iFTKyGlzcmSLr7Oh/mUFOIQuJmueAqcvvkN3kHjfPplvCNAh4N30s7hL2zE?=
 =?us-ascii?Q?9vr4/fz7lgBhAlb7P0SpbZoZUvWOIOLI0/uv3+dH2e1E3i+WaCQvYvl2v+ds?=
 =?us-ascii?Q?WIbyL0vkKsH/mvYgNyvGB2NcB8IJKMTcTw9GKN0UBzIviw5Th4Nw6x4DC+G3?=
 =?us-ascii?Q?mSoWvd1H9KZRpDk08huQTF47T2WjzvPYss/9Wc3jnQJn99zrCmoObhwLMvy6?=
 =?us-ascii?Q?/uNbBJsII1h7RdKu/VvI3MXe6taajQ2pTWFgWgHqA1VXzJhP0zVkLx7W8E+a?=
 =?us-ascii?Q?Dh1X5U7DnVtfRzWaTDXIRDe2rQ4JT5tQtM+iZkFIC9t6+DVVwbh8+PFtH/7d?=
 =?us-ascii?Q?j1gO4dbLTxqodHAyjBry60zc3e57+1KPuU8pa6rUZHs5pvDvhRoom05aicVj?=
 =?us-ascii?Q?X4lG0oVc6isv+KYRxABfNLFGZZuDmp2XiBjq2lwRj8LSajMOMPX+YNART1U5?=
 =?us-ascii?Q?086Aw2x4iQMErQH0o+XvHDijIK+Wfbq9bZ3g7nRba7IClW6uOl3td5Ns9MYY?=
 =?us-ascii?Q?OVAfw8oGhXRCClmpJYB/PVBncQQYk8WOclYNHWsa3HhUrhMimLOeginLqmtS?=
 =?us-ascii?Q?k47Syt4mPMIjZ0WcHsC85CxHcwrbMuD66v1PS4VaxoIzFjaWzbByPou3yaWt?=
 =?us-ascii?Q?0Wpt1tzOgiZNpV9/n6cxhOMbvLD44zFo8+O5O2tIQLE5h5yG1x8R30uoZ26C?=
 =?us-ascii?Q?Fjbz8u5390vQuhsqqQy7assFom7qFloX/seiQoh1zRj+2pPfMxKbGwlyqNvP?=
 =?us-ascii?Q?eA9e2+d/GK+BPVo+x8dqO3+Rqn7RdDU=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b208fd0-9fc6-44bb-ea2e-08df04f22219
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 10:50:11.2091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76qhK4c19iLEMBYZTNyrW9q3V5ev2uegsTgGh7tDGDAkYjtoZP4ASX4AQ8rYncAi2S7BI/G9kLIjX9bLW3L5+XhFoMR1hWc1b0NOXgvPRB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5757
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

It is implied by the comments in avb_ops.h and the translation of
TEE_ERROR_STORAGE_NO_SPACE to AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE
done in common/avb_verify.c:invoke_func() that the
TA_AVB_CMD_READ_PERSIST_VALUE could return TEE_ERROR_STORAGE_NO_SPACE
when the value is longer than the passed buffer size, and that
param[1].u.memref.size would be set to the actual size, so that one
can allocate an appropriate buffer and re-read.

However, that has AFAICT never been the case; there is no mention of
TEE_ERROR_STORAGE_NO_SPACE in the history of ta/avb/ in
https://github.com/OP-TEE/optee_os.git, and what the code does instead
is to return a value truncated to the given buffer size. In other
words, not only can one not determine the correct buffer size to
allocate, one is not even told that truncation happened.

A fix is proposed on the op-tee
side (https://github.com/OP-TEE/optee_os/pull/7959), but the
maintainer would like to see at least some callers updated before it
can get merged, which makes sense.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/optee_rpmb.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/cmd/optee_rpmb.c b/cmd/optee_rpmb.c
index cc384c7041e..ba10c1d7b82 100644
--- a/cmd/optee_rpmb.c
+++ b/cmd/optee_rpmb.c
@@ -71,8 +71,8 @@ static int invoke_func(u32 func, ulong num_param, struct tee_param *param)
 }
 
 static int read_persistent_value(const char *name,
-				 size_t buffer_size,
-				 u8 *out_buffer,
+				 size_t size_hint,
+				 char **out_buffer,
 				 size_t *out_num_bytes_read)
 {
 	int rc = 0;
@@ -80,6 +80,8 @@ static int read_persistent_value(const char *name,
 	struct tee_shm *shm_buf;
 	struct tee_param param[2];
 	size_t name_size = strlen(name) + 1;
+	size_t buffer_size = size_hint;
+	int retry = 1;
 
 	if (!tee)
 		if (avb_ta_open_session())
@@ -92,6 +94,7 @@ static int read_persistent_value(const char *name,
 		goto close_session;
 	}
 
+again:
 	rc = tee_shm_alloc(tee, buffer_size,
 			   TEE_SHM_ALLOC, &shm_buf);
 	if (rc) {
@@ -111,6 +114,14 @@ static int read_persistent_value(const char *name,
 
 	rc = invoke_func(TA_AVB_CMD_READ_PERSIST_VALUE,
 			 2, param);
+
+	if (rc == -ENOSPC && param[1].u.memref.size > buffer_size && retry) {
+		retry = 0;
+		tee_shm_free(shm_buf);
+		buffer_size = param[1].u.memref.size;
+		goto again;
+	}
+
 	if (rc)
 		goto out;
 
@@ -120,8 +131,9 @@ static int read_persistent_value(const char *name,
 	}
 
 	*out_num_bytes_read = param[1].u.memref.size;
-
-	memcpy(out_buffer, shm_buf->addr, *out_num_bytes_read);
+	*out_buffer = memdup(shm_buf->addr, *out_num_bytes_read);
+	if (!*out_buffer)
+		rc = -ENOMEM;
 
 out:
 	tee_shm_free(shm_buf);
@@ -199,22 +211,24 @@ int do_optee_rpmb_read(struct cmd_tbl *cmdtp, int flag, int argc,
 	const char *name;
 	size_t bytes;
 	size_t bytes_read;
-	void *buffer;
+	char *buffer = NULL;
 	char *endp;
 
-	if (argc != 3)
+	/* Use a third argument merely as a size hint. */
+	if (argc < 2 || argc > 3)
 		return CMD_RET_USAGE;
 
 	name = argv[1];
-	bytes = dectoul(argv[2], &endp);
-	if (*endp && *endp != '\n')
-		return CMD_RET_USAGE;
-
-	buffer = malloc(bytes);
-	if (!buffer)
-		return CMD_RET_FAILURE;
+	if (argc >= 3) {
+		bytes = dectoul(argv[2], &endp);
+		if (*endp && *endp != '\n')
+			return CMD_RET_USAGE;
+	} else {
+		/* Probably enough for most cases to not require two roundtrips. */
+		bytes = 64;
+	}
 
-	if (read_persistent_value(name, bytes, buffer, &bytes_read) == 0) {
+	if (read_persistent_value(name, bytes, &buffer, &bytes_read) == 0) {
 		printf("Read %zu bytes, value = %s\n", bytes_read,
 		       (char *)buffer);
 		free(buffer);
-- 
2.55.0

