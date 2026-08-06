Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCE4C5AC7A
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 23:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4ED4740921;
	Thu,  6 Aug 2026 23:44:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HW0oSuO2uNMS; Thu,  6 Aug 2026 23:44:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D33E640910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786059897;
	bh=DOlqBpWgueXbfr6d7mczjBpvMpddtssHASAXGumaWjI=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QgY8rivj9m9xcXEFuCp+uSvoqe05srmep6/3O3snwpGPmahCQfUx4yA1Yc4HmZ60c
	 2KmvjeoCoRTOxHNbnK1WMu16WHorIdkb2t63AHOAZnuvRI7ASEJ9whYnKudXy2geOf
	 IvjnGq4RqgJPKN3UQRT6eayPMoauYRai5PMEHC+gS5z71y7Ltv93yohKdKvQ2cR+Ty
	 Jr/nPEiGIdt71O4FRh6To0ls/WLjp56m10FCQvVTLRn9qxrwIAm5RFKukys9aYQGvJ
	 yCIl5nKMKgDypFMxKMWmCFGvoywBaCLj5wKj0u+uIhPU7SaYRtSesoR/UzUcJBLEIq
	 KtraXsX3tSCKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D33E640910;
	Thu,  6 Aug 2026 23:44:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60019392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51FD94090E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ICH4fIY9mkR for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 23:44:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6EEBA40909
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6EEBA40909
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6EEBA40909
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kR/ik7iy2KvNgPfCoKeF9sBrgu/YpkUfNqRhOCX0uttrJnhUxOxE1P6SM0RuzLoytXfzeMqGL0gNgMybOwoduXXiAqFrHyJoPfWsOvvDUn7hqYCgi52jdIZM0HD81faz7/gcow+HZ94UvuXFoUEs8HJtfIC9MmcBzjrur9itbkk7/t/J55H/+baD0n+H9Y1gC1PJui+q+mD/+IPfG/CkApX2YYIY1ahuLFpOJzwQSVCiVneNDo1gM7bXFzhVtr2lm0IYkRc80ZkRIwR5GaXhLC/hLAO+KVYBgDAsBsLaoXZTotersSLFMot+CohGLQdQW+aNGmVog030w2+hIch+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOlqBpWgueXbfr6d7mczjBpvMpddtssHASAXGumaWjI=;
 b=BD898lmP6bVed0PTTOVLFj/5wTPxFGauARHvQYUpdEBqmmrCbliOngceMOJC/2rvkFgJo7AzFnN0rK+Jr79tISTvq10+zHT47/8XxDAchcqG/uF1+/RedlvK3M57da+saBbz2ka0giWKi5JMCq660dh04BsuURoup4nWfNnxLX6JxrKy6c5Qivd10dp0sT5P/x3xbNzH7kTXYkJCshoSHIRD0Fxw5UKMGO+NnNr3DKy8jfop08NhX4whD5PAnEaRlmJqQoc00CUALVAzuqw7vGNZDiorg9Y51dyg6OMij20cA4nzJuQuwhRxjcwSKe9e78QSCa24r9qrFyrcrNynRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAVPR08MB9530.eurprd08.prod.outlook.com (2603:10a6:102:314::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:44:44 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 23:44:44 +0000
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 04/16] clk: airoha: add support for Airoha AN7583 SoC clock
Date: Fri,  7 Aug 2026 02:44:20 +0300
Message-ID: <20260806234432.4098414-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC42.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2fa) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAVPR08MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: b5490f45-d049-4150-6d88-08def414b158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|921020|38350700014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0VPHrRyCJlHEHSjEJPid1hzPvDISyOAwlkI+wnm5mDcL7UtzUrpUcXBh4Zk9stKHZEKD6SccSieAHnBVb4bQUufKEFc4DSRH73Qjk4ji8OeEf1owIbqEucEa0pypqxOx7dtjobDq18OODATcY9dh9LQsuRNaKdZyuT0ZIGMDTwnZGsX3O5a1CrVpRXYOkQ//uSd5N5Z2GjH1X1p77LdYprTKEhYG6hRuAxoPuaKQHqa1dRwlQIt1i+E+8mLNzHSD/w1nn1jYG3qtdU75LyFiYXXrpiVv89L4Omtzpy6YBcMxPOaGhrr0dO2k8g57da2uIwAUxINnkT6TwyEHVkECY06dMOlt1DKI/F7NJxBsDVb/ES2VXucbqZliVnS8q93tCKOHhXEUfXLexZfQjZ0RLxN/0tg9pJvJ2TxLXLyh03DUfBKA06zVxLnzdJBiV4/iDEW9IkuypXCJlvcdJa5//OEshQzTY36XoipdS4SNGhJHgnzlnUaIRWWlFrUM2X+a8BBmCm00YwGMNaI11bbYVoWzLxu1ddwNGX8cJ3+ihW58E3SXYOCjFL1imrI0WmDk/H3Fn2D9k+9dfu40aRzh+34dApcywwQoFaTl5jEXhqUeq9jW4lK8gmxRaWp+I0y7EJLvMCTynb3dvEBvHZYMczl20+eZHdC+npmexawknxREFF04wks8s4h30Da02EK99hp5sfkMmH2RwBAcpTK9EBKtzl4gbHx8rOwD9Z4hHTxqpXtvuq/z+0Beg8sW7/tp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hxXKix+0SMtOb+vM7fpz/BhsbIBLu+FrAjiuiMAAXHrmWyzXP/WK8FkeRwbg?=
 =?us-ascii?Q?NTpp6tF6WGPwm/VRuGTThSyG0AmnHBtd6HC/s9/x7wXYZ4RWbv0Q1nb/qxwE?=
 =?us-ascii?Q?TaoSPZs6cgbnRUEG0ZOhvSZKhujjwRyyrIe94V0kksWgA9cCV+yoKLH4M1kZ?=
 =?us-ascii?Q?tdisnmHZdO85k0aZUfKU047qoggeV6fnB2c5SIJ7uf80KuuWRmSs5+LgI6Zn?=
 =?us-ascii?Q?iYwBhLo0o21fAJ+ADgTXSIyRgD5cNtmRU5QZ9p2ghkQZeOd5WtOgXguzMHtm?=
 =?us-ascii?Q?AghHjGDJUq2wdR3LcgciVAK/zI+e9jog6HmnzXiJ8Q02Thf3GPE9o8vp7nfW?=
 =?us-ascii?Q?QdtKOBG7yl4lYXNFj7nUnacQDgkXwOIDKVkTQNubYLV4ycZnbGsDpPha8lLr?=
 =?us-ascii?Q?Gspv6gQ7ypGV2vOLEt7z8gqfSCyUxH5ZFRSUiUyMODLZHt0/B1vPtCm6mbYJ?=
 =?us-ascii?Q?YJ1JUuER7+2HvtqLIV7IGJ3gypoobgcxdHtk3s1GYBxe/nNcQOiDMBtT10/S?=
 =?us-ascii?Q?zjBUCt0v4Q20VpiXZjEvsfjb3LL4r8sdiLExqw+/dJHfnS267K1cUSv2G/T6?=
 =?us-ascii?Q?9sCwZ93vOdkh3VqKpDU2/0q+WXBXzMGgxKBY9OySSviO4fNrqHpe1gbFBb6a?=
 =?us-ascii?Q?ygIH7fhqTLhmXFicCCXIERMc9qwiJ+vckiXwhx+tNsbGmiQW8CbTLcmB3Z7i?=
 =?us-ascii?Q?hl+qF9/kH+kpY6/iJrPz+KB5vT+/u9lsdeX6vgKqeiACT1NowQj9OsBrkUhn?=
 =?us-ascii?Q?K5R/8pNNu410sCJBZwkkbR8JBJvVX/YUdoW0SwC1+tPQYRTxfBviix8/WEN0?=
 =?us-ascii?Q?ix80pTBBroKZ+n5/NwvM6ysfaSs8LqS9wpcpzsY5JU88auDJeQ64KpXROg8f?=
 =?us-ascii?Q?9u4/KZKSAt5CiDzRabKRKxstirovPrTah7XEewRI63VZeHSKTHhaKV12S4zk?=
 =?us-ascii?Q?GP87MR+vdftsDNIt5b7ZqvMcxTD1Z3qhdwsaC/f0vmE7mooCcGTvwdixDwzw?=
 =?us-ascii?Q?/ebHeUYBX7NuHW/OYxBbDNyZHqgxnOSfxuBPAycZqfDVtRT4e+P2rJqVv/Vb?=
 =?us-ascii?Q?8SUq270A88Ya74OPkaA0AYCemfuEah/USN2i+VT2OEgfJzLqcVFgz/HQzU6s?=
 =?us-ascii?Q?2quGwjhUGLQESHVuetbWnBYRvRS67TV+draGgRHzjHQipKuRhwmesdzmyCdv?=
 =?us-ascii?Q?LeeUipS3G4xqoyqudGb1AIHR3Un9pDJWf9CmTZC/8xQo2xD61qg9ImFT4Vz5?=
 =?us-ascii?Q?MgPzyYnz9CR7RNDeHqXpKLDjzU58yk0CcT+TdzbUQV+Zul4+gDzqVIVEMI+F?=
 =?us-ascii?Q?a8/+xWgil8mEDTvEPe11cONBPHVgw9a/8TLfJkxfZGMIUshdi1Og5OsxSKoI?=
 =?us-ascii?Q?UgKtzTGG3bypixnPqZHJz+UX0s5HV24E8MK3rTC9e5rV5jabGPbwEr5/ZXRN?=
 =?us-ascii?Q?4K/4ao0RgnMSIk3nOrQ4Qt074BzWWIFrUct5NZXdG5JRuORItV9DlgqEk2ab?=
 =?us-ascii?Q?FFCsivMvcZYoCehmA81j5zDf1IfssIMk02dGkPQtJuQDVKapwmDNa8apZoaA?=
 =?us-ascii?Q?QwZibxGPdsBxbSR2VvY6JiC7JC2e4NCIavbqnxVmSZrkre9U/1OGJLGux6cn?=
 =?us-ascii?Q?NM7yI+1xD+5DspAdjn8osV3KOKWkma9TyWokrbHdOkqmv6BWq6vcvQFAGU6c?=
 =?us-ascii?Q?5WdFErVU1eXD2PwUmFEAuSXAXTjDNYjB7Q4Zw5M9b5VPCR7BJNgwrFdENNbp?=
 =?us-ascii?Q?hysDdM5MWtuSzTRHSUhTiQWfBrc2gag=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b5490f45-d049-4150-6d88-08def414b158
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 23:44:44.6053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFJCaOd05pW0eqnIKGnF/3xNlYh3bi13kg0y8pHrDjWijZgYkoNL+mj5t43ttFo22ET0jM9fB2JZdpDNW5qrJfIauYXD2vLaUAJgXKOEIXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9530
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOlqBpWgueXbfr6d7mczjBpvMpddtssHASAXGumaWjI=;
 b=Gs1oQf34xiedZoNhwnyQlWPJJT7kBpgnFslVxTucdoGR3PPuUyAViTYhGbkN8NLmtxhQbZo1K6mC6iCW7qFZjKWAbH09XsAqPAtFVzWbukm61ecKLJUJv8kcoVilzPdmGL9BXfFji0JbjS/bf94pnicQmzhfusHm6pnikix+wGDolwrW4PGffO2kuP4fPMUB8Z/wIfdvKvUUdhoAk0i8lo3soamdch+Qr4+9ZlsMyojSgMlhwuy9LJG8YrBQkaZMA+yPcxgBpCYVp3d/eDR7c/Jr59MBZD/tI5bZ/yi9plFO1WGPtn/ymqwyGU9odgMcqRvp+XyUAUu5jE7mOrnaIQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=Gs1oQf34
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
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
From: Mikhail Kshevetskiy via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Christian Marangi <ansuelsmth@gmail.com>

Add support for Airoha AN7583 SoC clock that implement more base values
for clocks compared to AN7581.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/airoha/clk-airoha.c | 158 ++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/drivers/clk/airoha/clk-airoha.c b/drivers/clk/airoha/clk-airoha.c
index 89a8b4cb1cf..23cb04aa5ef 100644
--- a/drivers/clk/airoha/clk-airoha.c
+++ b/drivers/clk/airoha/clk-airoha.c
@@ -36,6 +36,7 @@
 
 #define EN7523_MAX_CLKS			8
 #define EN7581_MAX_CLKS			9
+#define EN7583_MAX_CLKS			11
 
 struct airoha_clk_desc {
 	int id;
@@ -78,6 +79,14 @@ static const u32 bus7581_base[] = { 600000000, 540000000 };
 static const u32 npu7581_base[] = { 800000000, 750000000, 720000000, 600000000 };
 static const u32 crypto_base[] = { 540000000, 480000000 };
 static const u32 emmc7581_base[] = { 200000000, 150000000 };
+/* AN7583 */
+static const u32 gsw7583_base[] = { 540672000, 270336000, 400000000, 200000000 };
+static const u32 emi7583_base[] = { 540672000, 480000000, 400000000, 300000000 };
+static const u32 bus7583_base[] = { 600000000, 540672000, 480000000, 400000000 };
+static const u32 spi7583_base[] = { 400000000, 12500000 };
+static const u32 npu7583_base[] = { 666000000, 800000000, 720000000, 600000000 };
+static const u32 crypto7583_base[] = { 540672000, 400000000 };
+static const u32 emmc7583_base[] = { 150000000, 200000000 };
 
 static const struct airoha_clk_desc en7523_base_clks[EN7523_MAX_CLKS] = {
 	[EN7523_CLK_GSW] = {
@@ -293,6 +302,147 @@ static const struct airoha_clk_desc en7581_base_clks[EN7581_MAX_CLKS] = {
 	}
 };
 
+static const struct airoha_clk_desc an7583_base_clks[EN7583_MAX_CLKS] = {
+	[EN7523_CLK_GSW] = {
+		.id = EN7523_CLK_GSW,
+		.name = "gsw",
+
+		.base_reg = REG_GSW_CLK_DIV_SEL,
+		.base_bits = 2,
+		.base_shift = 8,
+		.base_values = gsw7583_base,
+		.n_base_values = ARRAY_SIZE(gsw7583_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_EMI] = {
+		.id = EN7523_CLK_EMI,
+		.name = "emi",
+
+		.base_reg = REG_EMI_CLK_DIV_SEL,
+		.base_bits = 2,
+		.base_shift = 8,
+		.base_values = emi7583_base,
+		.n_base_values = ARRAY_SIZE(emi7583_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_BUS] = {
+		.id = EN7523_CLK_BUS,
+		.name = "bus",
+
+		.base_reg = REG_BUS_CLK_DIV_SEL,
+		.base_bits = 2,
+		.base_shift = 8,
+		.base_values = bus7583_base,
+		.n_base_values = ARRAY_SIZE(bus7583_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_SLIC] = {
+		.id = EN7523_CLK_SLIC,
+		.name = "slic",
+
+		.base_reg = REG_SPI_CLK_FREQ_SEL,
+		.base_bits = 1,
+		.base_shift = 1,
+		.base_values = slic_base,
+		.n_base_values = ARRAY_SIZE(slic_base),
+
+		.div_reg = REG_SPI_CLK_DIV_SEL,
+		.div_bits = 5,
+		.div_shift = 24,
+		.div_val0 = 20,
+		.div_step = 2,
+	},
+	[EN7523_CLK_SPI] = {
+		.id = EN7523_CLK_SPI,
+		.name = "spi",
+
+		.base_reg = REG_SPI_CLK_FREQ_SEL,
+		.base_bits = 1,
+		.base_shift = 0,
+		.base_values = spi7583_base,
+		.n_base_values = ARRAY_SIZE(spi7583_base),
+
+		.div_reg = REG_SPI_CLK_DIV_SEL,
+		.div_bits = 5,
+		.div_shift = 8,
+		.div_val0 = 40,
+		.div_step = 2,
+	},
+	[EN7523_CLK_NPU] = {
+		.id = EN7523_CLK_NPU,
+		.name = "npu",
+
+		.base_reg = REG_NPU_CLK_DIV_SEL,
+		.base_bits = 2,
+		.base_shift = 9,
+		.base_values = npu7583_base,
+		.n_base_values = ARRAY_SIZE(npu7583_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_CRYPTO] = {
+		.id = EN7523_CLK_CRYPTO,
+		.name = "crypto",
+
+		.base_reg = REG_CRYPTO_CLKSRC2,
+		.base_bits = 1,
+		.base_shift = 0,
+		.base_values = crypto7583_base,
+		.n_base_values = ARRAY_SIZE(crypto7583_base),
+	},
+	[EN7581_CLK_EMMC] = {
+		.id = EN7581_CLK_EMMC,
+		.name = "emmc",
+
+		.base_reg = REG_CRYPTO_CLKSRC2,
+		.base_bits = 1,
+		.base_shift = 13,
+		.base_values = emmc7583_base,
+		.n_base_values = ARRAY_SIZE(emmc7583_base),
+	},
+	[AN7583_CLK_MDIO0] = {
+		.id = AN7583_CLK_MDIO0,
+		.name = "mdio0",
+
+		.base_reg = REG_CRYPTO_CLKSRC2,
+
+		.base_value = 25000000,
+
+		.div_bits = 4,
+		.div_shift = 15,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[AN7583_CLK_MDIO1] = {
+		.id = AN7583_CLK_MDIO1,
+		.name = "mdio1",
+
+		.base_reg = REG_CRYPTO_CLKSRC2,
+
+		.base_value = 25000000,
+
+		.div_bits = 4,
+		.div_shift = 19,
+		.div_step = 1,
+		.div_offset = 1,
+	}
+};
+
 static u32 airoha_clk_get_base_rate(const struct airoha_clk_desc *desc, u32 val)
 {
 	if (!desc->base_bits)
@@ -542,6 +692,11 @@ static const struct airoha_clk_soc_data en7581_data = {
 	.descs = en7581_base_clks,
 };
 
+static const struct airoha_clk_soc_data an7583_data = {
+	.num_clocks = ARRAY_SIZE(an7583_base_clks),
+	.descs = an7583_base_clks,
+};
+
 static const struct udevice_id airoha_clk_ids[] = {
 	{ .compatible = "airoha,en7523-scu",
 	  .data = (ulong)&en7523_data,
@@ -549,6 +704,9 @@ static const struct udevice_id airoha_clk_ids[] = {
 	{ .compatible = "airoha,en7581-scu",
 	  .data = (ulong)&en7581_data,
 	},
+	{ .compatible = "airoha,an7583-scu",
+	  .data = (ulong)&an7583_data,
+	},
 	{ }
 };
 
-- 
2.53.0

