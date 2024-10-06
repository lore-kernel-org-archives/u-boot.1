Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAF7CFB43F
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 07:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1490B88D3A;
	Sun,  6 Oct 2024 09:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xxbMzH+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E2E688D3C; Sun,  6 Oct 2024 09:14:21 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94DF188D33
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 09:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOHTUq/NUlCALsp58UQni2uQNJodV+WBSdzUE4yffMh/mFxIJwE+qNQguUeWafqhOVeV+otaF8rsUuI9Eucz1IR26UxATEQX5hAgrt7z9qA5krlzNBJ5KWbMQEzdUIAlKc8M+VkD1fizqWRNWvjpA6yhxmR6QKfIAtmRz8n3+tf3N73aSWAwexAGl8H/aEctPhORwy6DQw2FcckVvfm5EVdhzfwJ38xDm/r6CTab3XSSA5MJAuS0hBfwyXUZ+/JT87PVT6TJZaikRVIqwtyWzUDcZ33e0bRCZOG2b7WKKUPyk7wEw7wpe/KvBvfDA1zdqhgvUrLJYGRmOzgJfw+9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5EEwFXMFHf9E/VRorlJfbUk2Y1VKiEa880pc1Zh1kk=;
 b=p+OaaJCHm5OOoOxFnz2NfrYaQv/wJJp3Pzz85vCIoS9M49rAOrkt1zGC8SFdgG8lM0sSHj21mJf2GOvclssu5WcXE+okglmDPqvZma5//+RQcavkFmTUYQ5j4kcVNMxmL9OUa0+rONox3LzAZ/5xqG0IQZ8qvqhuzifrxVm57rilXk+M9clyVnzVYfPm1WwIB5hxcL8WiZYFAiEMUxiUJ5cTCIiBzJfrc0oBMOH6Kit6FMlHCqmRV25hUDeBFTP/ESvC9uMzkOYm6NRrJrE1J96hrwfCUQbvBwQlgVW5wpcBDgkiiURYPNUIecmZCN5pfxdNfsYrT69TZr4hVmscJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5EEwFXMFHf9E/VRorlJfbUk2Y1VKiEa880pc1Zh1kk=;
 b=xxbMzH+1pOz0Dtk7H5T3QMrBB7sv+jWnKvjtzfmDoiAdliN+1v+p3dC4N3+Op1XT50QvwjQIDzVRx5lYwzSkv8SmU32JoaXwmHxB+Tt6zdZpEtCS93i7C0XcAQuCF2EN+e4kHvqjWldfTn8dBLHKR9NTfAMpShYn/TShlF/OVb+/bmqdLlp022vvvkfbj3j4W8oJaGQTxXdS/XxbNLw1ZbZjFC3s4ow+Aa9ZpxE/+zFX3ShEuPDtVCiC8fK24GL/qdFB3gaziZNj9/b3tBlxLp960JyEIUIVoA50ysTfjWv/RHspLGKdj+MZmIvhawZsbcmsz5w6FjGGWuzevBZ3mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10814.eurprd04.prod.outlook.com (2603:10a6:10:58d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21; Sun, 6 Oct
 2024 07:14:17 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 07:14:17 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, akashi.tkhro@gmail.com, etienne.carriere@foss.st.com,
 sjg@chromium.org, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v1] firmware: scmi: dump error string
Date: Sun,  6 Oct 2024 15:13:17 +0800
Message-Id: <20241006071317.2792980-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10814:EE_
X-MS-Office365-Filtering-Correlation-Id: f4aad89f-9383-4aa6-befb-08dce5d67d7b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aOWNQKAg6wNRhqoMSsgrkx2WTY5nysyt1cpwORzGgQanBgXbUDQNfiPdiOp1?=
 =?us-ascii?Q?VPVl6txDOY1cvwjf4J7Or5+roX9VqRK0UEp5rZ3R0VOvxAM24N2tl9UMKMV7?=
 =?us-ascii?Q?ys2gThoqNssF2WDt0vTnQU+W1H0stOIZcPNMCZKRdPCmSIWtgR+VNlkhHWxx?=
 =?us-ascii?Q?5T+dPyYzw5pHDpDGuzmHHiBMJBmclQoPx8VSHNfDRpMBa3xw/cd8gb0dVeTU?=
 =?us-ascii?Q?pKMEtWGfihEF7Hz88/IEsBu2Sr38B2n+/aQmcD1gASVoX215R1eSgk9hRcLe?=
 =?us-ascii?Q?Mls1UDtT8JVsZ0bN1eAsPMQSJmBUdNrs2S93SpBx1F7IoWr6TTg4LcJcCIfj?=
 =?us-ascii?Q?uMfwJMbpD8S9zzoXuDL85IXKgEi+85tafvV04UeRp6cFA29npvndqxcBNCzM?=
 =?us-ascii?Q?4cs3qnm5Uvl4zhseRqNbamrtRLSfIAFrg5rFRrPG1LL77ARKDYymEurfzVaL?=
 =?us-ascii?Q?59jXD1vyi4DirhYYYDypH/62Gd2YSH6Bn3B5yx9MeUA6mpHBjBWHb6fqzR+w?=
 =?us-ascii?Q?0+nKPcWzW1aS7dsZzT1sc7I5IBuEsDzumCiP2LdS64RPKq6mcb41PgVUk8j0?=
 =?us-ascii?Q?jWZ8D78S5Mb+9U1plQTpyBs4eapVDo4X7JeS8Yjeys0Wuq4lw7sYnBxMdriP?=
 =?us-ascii?Q?yh42FW+t4+c5OPC8seVKZSoNdCPW9xtmyazswAQQXTbLpz2VeV1ZbLM5XVsm?=
 =?us-ascii?Q?JWr1ya+MEkV9A3J+4ejQ7eW5v48CVuDKdADiqfTKeMrZez2eFH9+AFY2Tkc2?=
 =?us-ascii?Q?NAqhHarR0bgwj5+xHV/Zt6GKAal4iq445D27tvzlO+mZv1TJFcb1ul1ndFSv?=
 =?us-ascii?Q?ymVhPvTkzhUsrDe5B0wXc3oavDX+UFmA9+typis96RqHDdk/MUUQsUwrsNcY?=
 =?us-ascii?Q?7v5BFccQ8AFzY6feaYCNaOQfWqXj27yILJahq3cdi6YVcFHzZo9fcyYxSG17?=
 =?us-ascii?Q?yhCC8BF4/x3C36MtrfvOkp3SOAsSeGG2y/xihQsGkguxMwDhegX5f2xNIhSk?=
 =?us-ascii?Q?7tWp0ZmpmZZ8GsA4DhGO8C/EOiRfOBgjNNljoo23CUiBRVs0K6vUt79bQ1aU?=
 =?us-ascii?Q?Ep/94DRVzZIzlbfeM4xa6zSrFcTztZwN/rW+E+HbNgcGY2Up2w4LKfAXehuf?=
 =?us-ascii?Q?VC2v29ldOf+PPSfZ4J2Y369GTEtFmrl2FYCPuxHOgzc86RULjWDVl9TuyZYZ?=
 =?us-ascii?Q?wfadTlF7YypcGuHy5hyNQX4gHGaRTrOuooPLBPpdvKDtEz7akyTHFhKHAf4i?=
 =?us-ascii?Q?W9aUgrMAL/E08vkUvnl9Zi0m/dXLPh3jKcctLaJbYW0cYPc2982E5Blz9qfS?=
 =?us-ascii?Q?fq58C3xC4Yy3K3DJfOqcWhBB5wNr3wB4/+Ji/zAXCUZneQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IFo5UBHaBgRje39ncqxLxDR3PeWFcektLhFxNAZrW91CoEjYJtD3qgf8v6EO?=
 =?us-ascii?Q?JbTaqd9cCGbc+ZvCFOkDIVE7nkfTiPAqbQYTAydJc2+beA2dfpfzFFawRNRf?=
 =?us-ascii?Q?GGhmJE1t0SnFaScEDma/zke0YYk7fmPIPEoTFIDdfd7DNQnvoDZUL4bWq1Gg?=
 =?us-ascii?Q?gu5txa1ZpXVGsKDp5ayKYYR4rVNV996/Lekg/ui2zBXqzO7BmhLKxGm1U6zv?=
 =?us-ascii?Q?tg8R1Ny132tkZ4R/+Z/b/awj/BuAd61dRx1Cw2JS2BE17DOhVxD6aGNQuDkE?=
 =?us-ascii?Q?szy0xdwvbKPF0T4NT/ObedSVXXfG8hnNP2pQHkytpFI0EUh1hPLLd8l0y3iM?=
 =?us-ascii?Q?z24bqVF+dpUux2fWaY4YLrtAB/wS8h5K0sAYWfoyGPOF3EGK/KuOdKn7xtQI?=
 =?us-ascii?Q?gQFqhaIf0gukllv0xKlU9Bmv6ei5wrARNucvo84zQ3x8ZHngpNsDn99YUhq9?=
 =?us-ascii?Q?Kplsj6BWhwRfZAOJoZb8eFz218KItFjEUu8yL58ALMshMbDJ+TNvZAG8FFKv?=
 =?us-ascii?Q?MyTPU3Nj0+5DQAPSu2qnD9o09MakUDlv6y1zhByVqQfl7PfIqDlSt1NAgZVc?=
 =?us-ascii?Q?lezgvKOJUwTI2Bp/33RU5Zf40VRISF5hfKLNJ8IowTXYLVtgnoYxZFPst1dK?=
 =?us-ascii?Q?qbbvZ9EMCTQTcZK0oq5/6/mSGAljy33lbVT8P+5Yx/rH1ei0pLp2yT7EFnPN?=
 =?us-ascii?Q?6PgmZqbuECk7gcbRhayobcOtwlb9Lqqb04Gk+cTrYM0ozh3mT3Sfgb8bqQHW?=
 =?us-ascii?Q?NM8XtbxAA9UZT42gGWJa8uyc3R08xgTFot7BdmN1nzam8ukdtPgOGV48kjxf?=
 =?us-ascii?Q?E6b8kimH+cy+Cjd60O1DnDkrxMDruSnp7yges5Z56c5d2Fv9bqoh3VLawnTY?=
 =?us-ascii?Q?1cmPFmV4Lbsy5SdfHXX9hL9QfxCoibZIP/JZ7VH15BCYcjh+1U1s3Mr8k/fJ?=
 =?us-ascii?Q?5PzhRnYNgwG9+D/9DnW2N/grmzuiz3KADM/b6mlEZaUMhOgaEGJ+1capmA1S?=
 =?us-ascii?Q?WeGkXaxihZ1uVocGnDq8ZFjF4tYjNXn53YxPT7yta7vt4BBGUDubgtt3TOTs?=
 =?us-ascii?Q?suSwISVKnZqq3mwQADQCs5/ImIfC5hjTDYc8Zc1LSgulz23qs0iS3Y+UN18f?=
 =?us-ascii?Q?1c+2mXh9knQEkTAJ35QhEs5DQC6VjoXHA+Dy+2yngsHhffz2+M4PsNy/wbTd?=
 =?us-ascii?Q?51pboywiStKLipzb9mQZyiUvToUP1AtCNEGDD3Swr8AMXBvOiqpCQWjioFK0?=
 =?us-ascii?Q?4E8cEcPp4Tb/UIVbunNKDTreQWByodOsp0l4J2mj+lvdR97aYInokZ+KO1Iv?=
 =?us-ascii?Q?rDKfyEI7kNPb5p2kBjQCCaD9nbmHm8Cf25L2Q7u1xeTM7lqKlnJu4Sw7EDku?=
 =?us-ascii?Q?yyWxjsXcXQ/RyhYgbQpE/TfbL6yBmNlhEIMU9OXY7x+g3Mcgm04+s31r0URn?=
 =?us-ascii?Q?2MJ70cR3aZibpbYmrntWIyAI7Pr/qNuUutEIAy2wbmf751eHxfysRnieO1Wf?=
 =?us-ascii?Q?aJvTukBX0sX9bBNNHpX1ktMN5fQ4fw8T7lrf7/mH/uQ3CquilZFZM0WXo8bn?=
 =?us-ascii?Q?rDWhKsnhiBA43conv/21Qk1EySKUMpgRY7Of7DGR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4aad89f-9383-4aa6-befb-08dce5d67d7b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 07:14:17.2504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +M3Zk/F9P0BEFDCoAmzp/SmLOGbYEzWAkuYH7DiBzBryLpj31JO60GFAsHapTulzC0ugG+4wxKKyNnR2aklhwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10814
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

From: Peng Fan <peng.fan@nxp.com>

When error happends, dump string is more intuitive.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 26 +++++++++++++----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 8c907c3b03..e2d42d2914 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -18,23 +18,25 @@
  * struct error_code - Helper structure for SCMI error code conversion
  * @scmi:	SCMI error code
  * @errno:	Related standard error number
+ * @string:	Name the scmi error code
  */
 struct error_code {
 	int scmi;
 	int errno;
+	char *string;
 };
 
 static const struct error_code scmi_linux_errmap[] = {
-	{ .scmi = SCMI_NOT_SUPPORTED, .errno = -EOPNOTSUPP, },
-	{ .scmi = SCMI_INVALID_PARAMETERS, .errno = -EINVAL, },
-	{ .scmi = SCMI_DENIED, .errno = -EACCES, },
-	{ .scmi = SCMI_NOT_FOUND, .errno = -ENOENT, },
-	{ .scmi = SCMI_OUT_OF_RANGE, .errno = -ERANGE, },
-	{ .scmi = SCMI_BUSY, .errno = -EBUSY, },
-	{ .scmi = SCMI_COMMS_ERROR, .errno = -ECOMM, },
-	{ .scmi = SCMI_GENERIC_ERROR, .errno = -EIO, },
-	{ .scmi = SCMI_HARDWARE_ERROR, .errno = -EREMOTEIO, },
-	{ .scmi = SCMI_PROTOCOL_ERROR, .errno = -EPROTO, },
+	{ .scmi = SCMI_NOT_SUPPORTED, .errno = -EOPNOTSUPP, .string = "SCMI_NOT_SUPPORTED" },
+	{ .scmi = SCMI_INVALID_PARAMETERS, .errno = -EINVAL, .string = "SCMI_INVALID_PARAMETERS" },
+	{ .scmi = SCMI_DENIED, .errno = -EACCES, .string = "SCMI_DENIED" },
+	{ .scmi = SCMI_NOT_FOUND, .errno = -ENOENT, .string = "SCMI_NOT_SUPPORTED" },
+	{ .scmi = SCMI_OUT_OF_RANGE, .errno = -ERANGE, .string = "SCMI_OUT_OF_RANGE" },
+	{ .scmi = SCMI_BUSY, .errno = -EBUSY, .string = "SCMI_BUSY" },
+	{ .scmi = SCMI_COMMS_ERROR, .errno = -ECOMM, .string = "SCMI_COMMS_ERROR" },
+	{ .scmi = SCMI_GENERIC_ERROR, .errno = -EIO, .string = "SCMI_GENERIC_ERROR" },
+	{ .scmi = SCMI_HARDWARE_ERROR, .errno = -EREMOTEIO, .string = "SCMI_HARDWARE_ERROR" },
+	{ .scmi = SCMI_PROTOCOL_ERROR, .errno = -EPROTO, .string = "SCMI_PROTOCOL_ERROR" },
 };
 
 /**
@@ -163,8 +165,10 @@ int scmi_to_linux_errno(s32 scmi_code)
 		return 0;
 
 	for (n = 0; n < ARRAY_SIZE(scmi_linux_errmap); n++)
-		if (scmi_code == scmi_linux_errmap[n].scmi)
+		if (scmi_code == scmi_linux_errmap[n].scmi) {
+			debug("errno: %s\n", scmi_linux_errmap[n].string);
 			return scmi_linux_errmap[n].errno;
+		}
 
 	return -EPROTO;
 }
-- 
2.34.1

