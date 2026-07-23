Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43A8C531C7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 09:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40C3C4087E;
	Thu, 23 Jul 2026 09:39:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iWr2P67b3Pxx; Thu, 23 Jul 2026 09:38:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF7B84081F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784799538;
	bh=ifrzG0BUg01zeOrelwC5oBDBKormJ5WEmFvIFP5I5KI=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=j2vGSrIQH2JmA3BKx9NGKxquXH2zobHhHGNSxZ18YJ4dlHis3vu9aNBcMABoQ//0Z
	 URclc9f24+4tme/KaeXIqBAVq7V0WpdNWB9AXhx4850LfphnsKfkf0F7BJWsVRCeSK
	 JSW9OkcBQNl5jvrrRULy6PwrHf1JPHLwLS/R+6DM4Ss/PXcQrcR7Iv5Abr0PMbweJb
	 vmshmMVw4dQ3bc62ug5zwPbz0ELq6yqqoZTYEmkLjXvYGmDXnPdCnd1EmUDARIi9MU
	 SNLEbe584zfqsYc8Tx/sNBptlSkLBBgP+E0zveGQtAECBYzKNIJburKiojlIWQWXP0
	 +YVM2NtA0DeYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF7B84081F;
	Thu, 23 Jul 2026 09:38:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DDE2736E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF83340026
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5sVmSAFgldjz for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 09:38:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B5D3F4034D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B5D3F4034D
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B5D3F4034D
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERJGweerRGf6waBk1HcwDC2R9IjqYG8cHFEidb3EhPZMJfxbjqMqIc43KdyBpcUDvmMrNGbvyNKFjjL5i9yXJsmgqhxEyBye78Q/lG7/6oHd1PkLkJX5FBPVmxQtNT5CIkd7mDaYrY+fO3DmnahsQDRShdVj7HAwmQZ3+symSO/yzMoLliPcbLVqkiZCLluTLDgRY93C5BpOWoSCTTnycbT1iD+gbkezZXBcjVYF9iPjJw7oZQGsVzXI3vepfgRyJ8YqNCMOQgDVr/oD3J+V2jJHmPnohYN3FZgoaERj4nysuF5PsZXtNCVOK6ov1npvImhITLrRmqJpEXHxLE7SMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifrzG0BUg01zeOrelwC5oBDBKormJ5WEmFvIFP5I5KI=;
 b=ubmbtSWnfr39ZPmPwmrN6r+FCogWlJwfnnZmySmElCGR17hAzIiIHzPj35Z5FsTlwyHzdhaa6G8H2n5+5/6XbNsq6sB24vayhFA1tWVN1OTKV6Ndj6mw4sP4nLdMzO8GfmOUHcTXfRruLlATaxWhFTzH3ZohK6bw3GFNF0PTTd6teG5KM9TkQrxsstIWg5c1baVkAx8k1FG0QQQIN9NDUQxJC2zwMXepXGA/V9ogjNI0R0jK8U4iV/VXrQDdftl7M4o0ENibcIXZcmYAHszbQCCqyu6Bt6lm9Tc4P28Af2hzGNPJsXlFyG1lkQWYPPhjVWfvdW5/SO2IFGNA0N4P6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU4PR10MB8712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:568::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:38:44 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 09:38:43 +0000
To: u-boot@lists.u-boot-project.org
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 5/7] k3-binman.dtsi: add empty distinguished_name_template
Date: Thu, 23 Jul 2026 11:38:27 +0200
Message-ID: <20260723093830.3132465-6-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723093830.3132465-1-ravi@prevas.dk>
References: <20260723093830.3132465-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0024.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:2::10) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU4PR10MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: ca8cff7d-44e9-4cf7-d9b1-08dee89e2f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mKzwh17CnF/aH0Mfu8EEs6Sdgk7npgwXZp7qD7LrQpYC6Vt5FVDYZWJD7iXADFtrfm+Djp5OGGtRhwJ5hjtxTPQ74AXGneGv/ZjZEH1TwldQL2RmxOCsrmBpqD8zarRPrTNhE4AcFjRFPeFqPe1KgDXdoc/D6Vtjt1k64DP+LizfkYap6k7uS2irMBwAKYvdEM2ex6YsbrPE2hOgcxjFE4XqQ3dw6A4B1zJD7ZmBfVnr2dYuM9xBMPU83pkUedTpgib6hrzUs43Ftj2J0FlSly8xh7csSBsGnTdzpeJKQsVc1kFtd4YxeS6Ag+1yfw3W3G75C1sBG2LODTQ8GBBRRJtGgJQOCVdQBg/OfjObX1aF+Idk7bU2XFxWlHoDuTLmsiwxRLnk53aULHZETOQURw5OUHKHNbDyQz1Ev7yx24kQPR5gpSPehzGF4Gd01qjV/6UsHzec2DCAROQ0RFlCxLhOE9kExNYnxMyabOj0fA+hoiqMmVZ70Ee2Dc199EWY5TdEEU1zQTqtV6wBMPYColA4gPFL8Wg6KoC6rS1cuv2qff+wrKvjwPY7DTbzoLp0L0YSPsXlwkQr/ObDE9lb9weCFv1dWPPCPumbZBmRFO/30Xh6sU86tVC7dieWOwOfzlTdqXRyCadBVrxnTNHMY/FZfem0MHFOb11fgdYDWO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wfFDLZ750+nUFTLuj9f4CQJaZJYgeVZC2vfD5Gp1NUi5OApUce9vBfxfO6Dp?=
 =?us-ascii?Q?fJbIStydqF/CyPE3+PjSAEf84u9U4dzmWfF07blCLa/eZbSQ+DnllAR/PMXF?=
 =?us-ascii?Q?PRPx2SiKp0Hq+a9+cj26WeiMU6ccB8j384rLjO1KhiVn0zYXXrLGvRdelppZ?=
 =?us-ascii?Q?NK+QiSzPhCatwVo5t0JEQNJKoqrcJBF0HaejGt+EXcqFWLyZV8zFf73tNKcN?=
 =?us-ascii?Q?oiYt4zq3iO/VrDO2qvvOjRVcWDHusAtVBtIX9DQdwjefPEhdMFBsBNeTpv7t?=
 =?us-ascii?Q?jdo+4Ga2UG65gt9sYYNbzn6zAflqIA4EJNqRjIgUNmaQIoerhrP5petUPPR/?=
 =?us-ascii?Q?nxxfHsPQL+w4uKx7pLB3LQlVQ0GkvIVX9nHBG8hK3wsbDcsJG2F8VAuwbUTQ?=
 =?us-ascii?Q?xzbIljbATBDrdMdZyZHvB1WMoWkZnSjr/Vkc+OTNKx0b3mIxytlSUhJGKfxf?=
 =?us-ascii?Q?Te+NMgC9fTE801fxZvdxMqL9ufOxwHaCpmak6SkMsNkgFczCDvBppoqODaMG?=
 =?us-ascii?Q?pISh2njUxsOzqqRbRksmurG3z/2x/Ip2ySjkxY2gW3jMpSFcxyVNSxif7hp+?=
 =?us-ascii?Q?6HUgRRZorwWYTUdId2RRuFYUJ9ksNm6sNSdi7aqzagWR2LKHIFU5yWuuVeXI?=
 =?us-ascii?Q?jgT4SVQ7+zOXoCNPhEKBefw+FwfqUucEQyIQ4ch5SVJVr/16I3tXm7sztlcx?=
 =?us-ascii?Q?f6sKkLZxHe1cfjXjLcEca0QyU6q9hoCsSeH7V+fBr4hhaMoV80vFhDXH64do?=
 =?us-ascii?Q?X3u259xRv6kIqkynbFMeX3DroRCiKwYeQvnk/pnMk6tQXzhX8o4JUJrGvOzw?=
 =?us-ascii?Q?wN3H+3hVBLf5dEQyEc+l6FptyxA/WWY9UWIkCH+qygsAxx0HfokZs37sEU4r?=
 =?us-ascii?Q?xRZpnE2ngSPb0ZLVEBjN4cbSXsojsCSGixMxOD3ovMrwotejP7wTvSonOlH3?=
 =?us-ascii?Q?jmFc9aY7bSRuk7h5rYkyyVJNhG5L8fhqAeoygjcL0p74Oc/rDEjyMRrXJLCh?=
 =?us-ascii?Q?fzr83ubxX2rSE5la/oaUvQKzjJe4C5oklKxmzKRWebcZCt0Kb7l5cL7B7/tq?=
 =?us-ascii?Q?j2JxQOWdtq8t0pIOQoSKLa9N3cOQol2FHnvrkikkQNlB4M4yQW9T9BSmYf0P?=
 =?us-ascii?Q?VS9gtu7v/mCHFtA0RIX0kc9AQLcWp9hjeVsEF+Od1tfXxqkQ6jb9Bgab+Pu5?=
 =?us-ascii?Q?/zeDsz+gz5FQAJYa+dVRAGNJ6f3sHDe4AZfj1jqUBWuHMDKEHITFNQiOs8B2?=
 =?us-ascii?Q?1e1rUZbiYceRvR+na7KovXomOrk6Pj+Knz2sP3MX4iK+6LOKW/Di+nbD4Aho?=
 =?us-ascii?Q?YEJneNtm7uIOpq1yiYDrOKH2t+pk49x6iN3F+NR7NtxBKbC6Wb7GvPY9QfSU?=
 =?us-ascii?Q?zd22gaYkhxHGWv6k6Bk8ljPGfmqZ6xMim9q/nHXk0mEQM0Ld7Pcu3Aq6ZCso?=
 =?us-ascii?Q?9BCC2fODiDe7MT615f3vwmG47A7KwM2v6gs5592Ow63KxAI+gNW3I8ppYtQq?=
 =?us-ascii?Q?PUDrZ724CGBuCPGH4tiFih+5vBY7o/6Ayq9Xg13oaDGs8EW+jBYURR80A9d9?=
 =?us-ascii?Q?O1CqZBwGZnxTaUMoX6FJX2yoRNynn/S8SrFTeW6PcLkbleB+2G/kJDXBSzsd?=
 =?us-ascii?Q?wM0vYPpsVJ/4FaxsDQSVmHj6VFW8zr6OhsRIJjSOT2BcxN5+MRm+UjB+ubx/?=
 =?us-ascii?Q?qq7BtwYMU46xS0y8GbObuHLVehAi3ZEwiV/NR6EuVyD+nL7sTYHoKst6t55M?=
 =?us-ascii?Q?YZGB8mb1UZ4hZoAqWNE3TZTqd0C1+eo=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8cff7d-44e9-4cf7-d9b1-08dee89e2f46
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:38:43.1969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywG/RJAwfIsBiKq5IQzAZI5z+y2cidzJuG4XfPiiJypc6P3NyHdXJwsk+CpJVjwGdK0zD4htYwSMi/smWazVdhkGeST3MXRPKn/TtyAgwlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8712
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifrzG0BUg01zeOrelwC5oBDBKormJ5WEmFvIFP5I5KI=;
 b=eEmfyEcENi66BeDLUBLGALMDxzhN1GL7wsergd6PQK4szFVvSmVLLjY+TKyTa0d41mBXVIHv71fJfvL0RyUPr9sWegFLikX4J/ItD8O8ZvQmOn2bLNOsZx7nsQHuRvinG5sCwzd1J2Q4pRi+1eQgtd0S41bgtQ7ADER628pE+Aw=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=prevas.dk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=eEmfyEcE
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
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
From: Rasmus Villemoes via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Rasmus Villemoes <ravi@prevas.dk>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

With the previous commit, "binman: x509_cert: allow and parse
distinguished-name subnode", it is possible for downstream boards to
put more appropriate values in the req_distinguished_name section in
the certificate being generated than the hard-coded TI
values. However, that requires adding a distinguished-name section to
each and every ti-secure or ti-secure-rom binman node.

In order to avoid lots of repetition and make it easier to just add
the information in one place, add an empty template-dist-name template
which we can inject in every such binman node. That makes no
difference for existing boards, but makes it possible for downstream
boards to simply do

    &distinguished_name_template {
        distinguished-name {
            C = "DK";
            ...
        };
    };

in their -u-boot.dtsi.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/arm/dts/k3-binman.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 69214bb32fb..2c9e5b619b7 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -29,6 +29,16 @@
 	keyfile_template: template-keyfile {
 		keyfile = "custMpk.pem";
 	};
+
+	distinguished_name_template: template-dist-name {
+		/*
+		 * Empty, but allows downstreams to inject a
+		 * distinguished-name subnode with appropriate
+		 * contents from their -u-boot.dtsi, which will
+		 * propagate to all ti-secure(-rom) nodes including
+		 * this template.
+		 */
+	};
 };
 
 #ifndef CONFIG_ARM64
-- 
2.55.0

