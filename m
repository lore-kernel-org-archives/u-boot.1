Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C5CC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DC9380F18;
	Tue, 18 Feb 2025 13:10:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="d9VJ3X9K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D3B880F56; Tue, 18 Feb 2025 13:10:39 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B02380BA8
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5/+JsRU81D7Bwle/gy2v8DYAn3yNLico1b/x/L6tDVU1e4tvFH73nhuU4JRyps8r/wX/7G5j1xjUmuU0HPrAmQETJ7Wa8ipmO/dZK5LJJNpbXb0WdPRITtrrfkENQxDSap8dMrygoH33dhL5EC4zTnprtCA84qiqo/+CH93xO+Zxsz6/vPKREQ1vgMD3ef+kolA4K2mkPnjt+pKYRcrs5AIUl/lMcZ1BuBh9x18wA5gU5T7RP/DXaWSHNyp5P7o058nvSU3ZDaQB9FDSS8PAMV+U90ZE8yiDFWsb/Sb7x+FdO8qQQfZXUetdbr87p8DKl7evcMXJ/dvdn3huClnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCkzxxQbVTcUOmZUrblJ7rbJLHq6kIsy7rAnGXc7wiI=;
 b=ctFLPkiOpFldCTI3ywiHym/TsLXMyg7jEubbtXgOrbkFXJdq+zT/2RAbmB+5XCezDdZRJZcElbBqcHlQjajRzyKQdnNylGaXj/+kqr3tTh9JWRYsM70QEItyvINHeGd+X7229sNjZUILxlxeIv0nwUVmg1xkPsa2HhDF/a+mR5jXoQhb4/qd75X2ZKu8AQB+L+xsILcHwguXMz+RfSm8QtJ9HDQCe8krtXqFJ1CIhSR4pLl0VeFp/BMyeYv5e0C2g5SO/Hxzi0Sz8fWej6vRh1L1RUrueCMxJ1x8wXmMrlKCLwC+InG6H8G17ikhOSzLaN2RtTv0algayjakVw/oQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCkzxxQbVTcUOmZUrblJ7rbJLHq6kIsy7rAnGXc7wiI=;
 b=d9VJ3X9KJrOPJY2MxVIzrmNM2URg1HQlK+2jr6ceblUW26YNqwHwtf5fgi9we4d473Yqa1hJDxLcge9cWJ06NG8Quklslea1IuKVlLlv7zzLXsViqYIQ9W1qGemiHL9odNQ25cxuPhdQVkmhSsbKYJWSY8b883q3vUNcqmC4F3Pq71nJ4c/X2rK4t0Oy9gQZrsGbmTV94wyDrmv0/OuyLQ9RmZNgUAKjIkW0eh5ue2isHdqqom9Yi+9plRnTdehr0fp+B6LgtNytkBWcjgOF4sn3x0fRyyop8EDRYmG8i8SlHtr5gwqFPBUxkkDsF/RD8mmV4w4GeEbqD0gMXKVr0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10509.eurprd04.prod.outlook.com (2603:10a6:800:214::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 12:10:33 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:10:33 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 10/20] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
Date: Tue, 18 Feb 2025 20:05:47 +0800
Message-ID: <20250218120559.451678-11-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218120559.451678-1-alice.guo@oss.nxp.com>
References: <20250218120559.451678-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10509:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c110bd-f644-420f-1ac5-08dd50153e56
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p/glWdUUdoEKidMfgLDgU3VY7zgNBiTUPfdRwSs8el5lnYC3hxd5BYsqSPdf?=
 =?us-ascii?Q?kF0hMy8FqfOzs3ZQ+yxN/hqPzBMdlQSqqdvydzb8f1yMyAJIn4VAPQU6lZak?=
 =?us-ascii?Q?Z+YjjvP8HIAOlTvKqpe2Zbmo2xkx/HQxpYfsQyozW64a6jvk4YP/YcXNmYeZ?=
 =?us-ascii?Q?X3lS4204bAkM9bVe9LM5T7mdqqyqARautoIJNwOXCgHWCpot10R2uuQ/FuzE?=
 =?us-ascii?Q?ApPJg63qK2ySOK1DATsoQsbIsbr7BHrWrLxKSL2rLiU1nNXF4K8e/ItYrqwr?=
 =?us-ascii?Q?LDwUu96PTSwkQP58TLNfxYAb2bc6EGaGzrLyWizNU3V0g/BE/qQ+XYNlIiv9?=
 =?us-ascii?Q?xx7ACSs2HN4AKq8M2BT6IKQ2DHGuJc23g7uSdJ9ZycB709LtLGKlLJWRbA/R?=
 =?us-ascii?Q?fVJCKyXmEYUEBC86C8+L0seVGfZGo/OWOdL7uHmkxyCuXue5UbRPH33NfJHL?=
 =?us-ascii?Q?2+eZiwpI+m5pbzvSoFARCpW2rtjk7KY5cneOEN6qOjVCzdajoEXvdMademyF?=
 =?us-ascii?Q?WZtijOSVBaU8WY1qLasWDaZBhCP2h64whRRMYq6xdWRKbXe6jK4MzP34yQVb?=
 =?us-ascii?Q?pFQZOALjSkNGWmLl2FGevl6swVultVUnU9mzOAYVeS+1Vt4UxONPPKs44ud/?=
 =?us-ascii?Q?0fXxMXowN+ueQkCsJDA10UAJkouS5+/ENENPPaHdpFSeanmSSV1kc+1mauDw?=
 =?us-ascii?Q?VBgRHL1iNoJoHcYANoLuHHMSJcCP7jJCMbV0aRxWmLjuf5LWJB9ls0aXj+qb?=
 =?us-ascii?Q?TVZtd5+5DqQionsFSMp7n/zuN4xvfbLvWepF3DBKEfQmz6m/sb4exxy+vj27?=
 =?us-ascii?Q?OHpBZgxeYu4T+bNyx2ROTk6MeQEUFFHsMw2JbjxXnzAa748mNOGP8mlZTkIA?=
 =?us-ascii?Q?VM0nvGVhbs1W3iWLQv6Rlsh6UrKImzvDUCFfVZwh/5crFauvAJaE6W8/f1mB?=
 =?us-ascii?Q?zJailRhSZazrVu0ef/0xThaYPio5mz08HOD/+RzTpOZhXVrIg8y5ygvTs2Lv?=
 =?us-ascii?Q?L3ItD+Z2YcTm86BT+YCiUQjl+5vY0p2DP7MHGCCEQwDuygiSj2qeZMgb8oMp?=
 =?us-ascii?Q?mOOxkfp3kOwDedUgZ4yM2MkMruY4fbpi9USKrSzXHpP4QshzcwT27MtFshbb?=
 =?us-ascii?Q?05h5iwiEH5rQps0PziP9+4wmFOGHXPte2h+e89zaB7r2ot7sLqPpO9tBmsea?=
 =?us-ascii?Q?oUkyEhi0R8QUvTRVKu9rTDNLEeiVmzl6s3w9iT7Bn9S+rWxWzXQFOSSfBs2M?=
 =?us-ascii?Q?4/eYVvt6GKQGYd0CH+RXi1YYN0vj22BC9t1uKVB1Z8HCcGE0izEB+NkSfgmw?=
 =?us-ascii?Q?RIMukUzGUKHTKAP+Rve/BihxamHyi7/C4WLCZnh53FwS8+QrItzHIXsqH9Uz?=
 =?us-ascii?Q?ZLIPcOWw2PUN74AWvLM69whZ/tgQluui9m8Fpc6HOJfMQ+njNY7diLkl1DpC?=
 =?us-ascii?Q?RAZmQmv6kXuQslG7pF8+HRXa9d9o6lf0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z+Z/flL7faqlHZHnNxPu1Jrf+PGAM5T/OcopT23FGK++KknOF8KD7s9yQ6IV?=
 =?us-ascii?Q?sk6s+KqSccvN9aO+7fVqWeoyvjvExfeAOabg6kxnxAKD2gemnwjbiduT750t?=
 =?us-ascii?Q?rCA//N0/ZH+cN1dgxC5fwbMKZqlnIRzkzbQtQK0jLyjK3W2HLNXilvEwm1e7?=
 =?us-ascii?Q?dAl43BE7548HxyaAS5pWuT7y9m2neDdzUerepP8m6UpvL7JeUliFBJ3v5qPx?=
 =?us-ascii?Q?OIr72+W2MOoIncEawJmiBEMDrn1VRe5XcJLavROFMb2I+wGVySmdlUy7H5cv?=
 =?us-ascii?Q?H5AsK+t8Yy6gpUtLEP2NBipHnDe9X0qEFtuKoJavm+0h52eqWl35HVx2asU7?=
 =?us-ascii?Q?3Yjo8xNZThAqbFlbTEFrOZ6yQFQqeL02sPk2Bs5vO3cb1iHyvdO52fSWtkLr?=
 =?us-ascii?Q?USVbsbumawkVFtQmM0LcKXK+0QzwU5wI2Rlu3/D0vd5kZeOjGvqPCdGyc/m3?=
 =?us-ascii?Q?gGQIFdNmaE5zzT3+Yy/mskvwkmuHzhHEMMH4FqnaSa9uW1LNmohdd5dw6RDy?=
 =?us-ascii?Q?7Fcmrs0qqs+gKIZy6blm3WDyfoOrl2tl8MrSScrr3XyLNtuDqCVWlP9ObEjH?=
 =?us-ascii?Q?F6/jU/FswPTHos9B4J/wv+Eekf+0fCZidEcnSUjQPo60Q7fbOuNliAVtOPgV?=
 =?us-ascii?Q?ey45iLd1vGISE4jon4ubpMGRuMsJ0R6F4TQZj90FKJ4/sh4mX2c/GN+QhIME?=
 =?us-ascii?Q?SaK87SpQrwYZgq1uEk4flGA45v8nakQ/gV5QCR4Sj8r6j8c4Pbq7XZR3d4h6?=
 =?us-ascii?Q?eXtyfY6REykmCnYY45RzTlbHFV/m00Hyaa2vwTiN30ZqdadaTxwewdzAAWjB?=
 =?us-ascii?Q?GDb+dkHV4GJ/BDzoSyKx7exlaXHHPcYFaJ6iQCpvH5Dmn4Hylm/Wey9sgD06?=
 =?us-ascii?Q?PV00K+kAy5vHWOFRQqOc6K8SkJFHegM81SDdrzccJWYXT8/Yh2ff1i2repNX?=
 =?us-ascii?Q?vHeDr1AOrShpJNc7Y6yH8CPBtVUsnnYtCSi/p0TzoCade6jw2fHkdlrLPdm2?=
 =?us-ascii?Q?VZKP5Cq5RbvsD3sM4qdpCTS2tn+gj2AT0iZAnYCacqVlMhYYbCf9RfD7RUl9?=
 =?us-ascii?Q?WDO62lRov5O3JsMCRABBsp5ZqR1mdh84xKBBtOGtBzRv5mMfKu2NSBNC0AiN?=
 =?us-ascii?Q?Av4E/PBuGOD6kBFbBI0Xs11UjFx4cM0Fr+9TbYab4vJELGiPpd9lAIgoBquu?=
 =?us-ascii?Q?t8vYFyq2F8EmUhHMRYK1D76FuVVKIMXRU7dJYaYeTZY/Q+X77Zjos+E64u7I?=
 =?us-ascii?Q?TG+9i1DBStwGPw0i4cjcUS3NDUKqwCkOjcmRKeY1BXv3+a4izb+tRmtYMRnK?=
 =?us-ascii?Q?q3k+vmrQjITWfcRq+Aq6FcycdJh4a47WzHfuA4PSrjYI7iKqKukYmLS8yb3U?=
 =?us-ascii?Q?nK8F9/RUt1WiuZ5rAKmlljhD8eCwE1Ko+y6/zzkjRfU87d1dBg2TePA0tINF?=
 =?us-ascii?Q?wWITjTgz5qUu/BumM7zJ4GvndZW2l3RHbGg7pPOQ0b4EaMm6nJ2vq9M5EpxS?=
 =?us-ascii?Q?iZDCyQv/K4Mh6BOtI9lZtG0FQa6eH0W16sS6kn5wlAGkGFMCbO3ZvU3yXUsn?=
 =?us-ascii?Q?GL0DZ+pEykw1ndMAF90uiNBfFexGX1G6Dn3NtnlX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c110bd-f644-420f-1ac5-08dd50153e56
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:10:33.0180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBPtsqx3T/PQ5uHX+cWDm/Bf10mfqSYO8Vtway/R3n3WpcyZadnBORCQSIP47R/GsOyY9Z1j1T4HNqTTX8hziw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10509
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

From: Ye Li <ye.li@nxp.com>

@protocols is an array of protocol identifiers that are implemented,
excluding the Base protocol. The number of elements of @protocols is
specified by callee-side. Currently, set it to 4 is enough for i.MX95.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/scmi_protocols.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 2684f4177dd..7ce73ddfae2 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -141,11 +141,14 @@ struct scmi_base_discover_impl_version_out {
  * @status:		SCMI command status
  * @num_protocols:	Number of SCMI protocols in @protocol
  * @protocols:		Array of packed SCMI protocol ID's
+ *
+ * The number of elements of @protocols is specified by callee-side. Currently,
+ * set it to 4 is enough for i.MX95.
  */
 struct scmi_base_discover_list_protocols_out {
 	s32 status;
 	u32 num_protocols;
-	u32 protocols[3];
+	u32 protocols[4];
 };
 
 /**
-- 
2.43.0

