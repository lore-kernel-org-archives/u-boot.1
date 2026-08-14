Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1879C5CFDB
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 13:30:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DFDD813F5;
	Fri, 14 Aug 2026 13:30:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JxHqQ-xlSIP2; Fri, 14 Aug 2026 13:30:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98243813E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786714225;
	bh=+ZKwDhRC6Wq5wJpcAaB0f/fVrX8mKBs1/aT+Zoz0R4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ncAB01qFUZpREuSggZ5c6UrDy8pVxSkV8zaD45rLmrhgsOUpKNPXBnTlM0SDTRDsV
	 hACYZlMc0u0wfVVlMK6+7v/WAQoU3mnYRv0aj9k6/xsftI9R5qnAZSKdzDaGAXO4wa
	 TufJWPHeJegllpLqdi/6wM4HSEPCoZhyuXKYyM7Nul897KUKYtdW3lEzE6DPLYuNGk
	 ED4nP+aEqKuf1CBx1qLGCKw1CNnC2NQJlXwZeeprgWWmlaRJYOkyEV3KMU/s0TnE5e
	 xioNUnlqD0eRmxFEpwouI2rNSkHVaosuD8EjKWnZ0Qv4WrXRMxzLIpldsGzSYQmd2G
	 TAjdTGTDHxc4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98243813E7;
	Fri, 14 Aug 2026 13:30:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C9881B8
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E2EA813E7
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:30:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ShdwsEs26iVN for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 13:30:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.104.109.113;
 helo=de-smtp-delivery-113.mimecast.com;
 envelope-from=francesco.dolcini@toradex.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6A8F0813DC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A8F0813DC
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=Y9TzrQZ+
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A8F0813DC
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1786714221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ZKwDhRC6Wq5wJpcAaB0f/fVrX8mKBs1/aT+Zoz0R4k=;
 b=Y9TzrQZ+yX4M2+s0YmDyW/u2GaZ6LRHeqwGsES1bqGzG6VxnC2pVY1cpAvQlCUuxJVj6BU
 rxdhp2y3BjNEN/P87Qk3Yxg978ZwCOA6J2U9qX+9LzGRgtNGw1Cwy6/OVdVKipNE1ecCJZ
 2Nc0fawUdVky1UkgHGBW8Klwdwy1fyk=
Received: from GVAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandwestazon11020079.outbound.protection.outlook.com
 [52.101.188.79]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-48-5Wqn7-zJNmqkNZCwwR1M1Q-1; Fri, 14 Aug 2026 15:29:06 +0200
X-MC-Unique: 5Wqn7-zJNmqkNZCwwR1M1Q-1
X-Mimecast-MFC-AGG-ID: 5Wqn7-zJNmqkNZCwwR1M1Q_1786714145
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR1P278MB1248.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:6e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.16; Fri, 14 Aug 2026 13:29:03 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 13:29:03 +0000
Date: Fri, 14 Aug 2026 15:29:00 +0200
From: Francesco Dolcini <francesco.dolcini@toradex.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, sjg@chromium.org, peng.fan@nxp.com,
 u-boot@lists.u-boot-project.org,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH] configs: toradex-smarc-imx8mp: enable
 SPL_SYS_MMCSD_RAW_MODE
Message-ID: <an8YHJRKbm13jETw@francesco-nb>
References: <20260814131535.308025-1-eichest@gmail.com>
In-Reply-To: <20260814131535.308025-1-eichest@gmail.com>
X-ClientProxiedBy: ZR2P278CA0074.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::8) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|ZR1P278MB1248:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a7eb12-9f2b-4479-1040-08defa0801f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|56012099006|22082099003|18002099003
X-Microsoft-Antispam-Message-Info: 3TwUZGqS3v20567HPcBHebdLdbKM+sUf519nd8rghHjjH+YAhMTA/VhRqA6gI9YTFXbnkvEvZY5wH0DNEtGeE2V1Jx8AwqPiqIqeFwi/Wni50G6wlp6ShefnldjtQJITM/YEPBKhwYbzLOxKRP06WkhG0liXre7VeDpHma/zbW/TwfKqOt+uSvf2f3glrFk1M8S1zYfm2WCj5yetTb8wDvB64J/mgrw2MiGqSsX7y2yOz4JgpZwMT7GV7dbVK3vMXvtPAjzF9NpDYZAGxVOn7SnJlhea2dA9rENeJFxfw8XU4V69iFxBS0tmSIwQXLTMyi5FLnn0FF4m66aG5tBbO05AXs0dCGr0Uzzkf4optvRoJl4Fd+zxR/kp2q6/k1CB9SZs/rnN/3bxU4AqAkmdoJOpFHgJHQ1Qlz2DldGKKmJ7BBNsEuP/mrRvTF5yVHnAWvHCwjiGqlKQIPla2Z/L/2oZnmivvuj5VizNwfHez/0sWxfoGIXrVYguWJvLG5X8pgz8TecoXDci+ujIR19EwaO3bth4FtGNnoMn14xFYipSLmadqJgmrQfUozkr1S4y3gwvidLPe6G2tgN1or56xNamLqW78E3GNpC85LWmYqrOFZ3WB8prhLdPgFBEefA+KeAVGlYvjEAheV5jgkmfex95AECnwgEYfatp2lfBeXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o9KxwblNWKxmJtU8Wy9A21ZUfCY+WB2UNpHmrg1oCso0/gJGoXpXOupNzRiS?=
 =?us-ascii?Q?ou0iOTSnV7jW+uCaOvY2BrpnuDryD0BNOPVTTRypeRI1j/YHSab1FvQdclFz?=
 =?us-ascii?Q?+FKu5O3hkY+Xwpxsx13K61PUEiH+R7+shd6sQueWyXOOBlSh3a6ZeU8uJQmj?=
 =?us-ascii?Q?U5cj4fmD/9jaD/S0HCe3O6TFBSdpdrqslrPkM6vEZ/AVgR3S5sVDJuFALyJZ?=
 =?us-ascii?Q?IhAqDhY6nIbJ5YpLGtdUe1pXfzu7VNi6H3fdPa6e4yqxo01h9LRaEg84uVp/?=
 =?us-ascii?Q?PMVdW1FcjJwrbS7nZnQ0eUd3172ZP2kNiij2QZiSvaNWcJ8CYZtbWeONrFvS?=
 =?us-ascii?Q?6FuqnntFJUcWTP8QKFczlW1SPK2FSJ4NsWGTaAm0SBy02nrLzb1q1ru7sZ1q?=
 =?us-ascii?Q?3rWz+y6DNX0I+EXSZ96g2wIQgX99/bupS0XXGwTPsRb4caz1O3AMOdEw1GKf?=
 =?us-ascii?Q?+yzfnB8EKXEXeV78ionkKeQKYLWUUaMs4x4hVQXv4ptAG5OhtoQ5LMcQmto+?=
 =?us-ascii?Q?elah/vV93kP/lBxDVU7E10KL669jHwylQGafpt9bIypt04OlmCL/bIE78V+1?=
 =?us-ascii?Q?/blqoheF4+ak34ml4EOTKk9f14h26lu59QAaWCdTTJVDcXmw3ExBs8P7npO9?=
 =?us-ascii?Q?gmiHCNRCZk/sWeIstpDde/sgfaKc0KZVtPvwvZVmVE1WJS+98E6Mhmqf4yNo?=
 =?us-ascii?Q?vdsEW6sS+J8ubwm0R0Hjp/8PstrWFSWUT4LgrGRxn1T3IBLMFLh4HhiPdyS3?=
 =?us-ascii?Q?QSlVq11ZMHQ4dxoOoE5aQZ0qZo6hdef8Tc4rbEffYSxgBDPcE2cQxONhQg67?=
 =?us-ascii?Q?qOYT5J4GVhC/5w3lI6wueqTavr137MKuIcaRCndT3xb+XzH9g9WffhKXn4qs?=
 =?us-ascii?Q?L7oZZ5Bw+DvyO5jvZpo7NLOSvqCCfZZk1+esAEmRB6EwM21IpFvSQHav5Z9s?=
 =?us-ascii?Q?+jsDn+HUcD/aO7BMpz398aN1tZd2ZFR2WTuFWilXph4uEa6Vt0lo09X6XytQ?=
 =?us-ascii?Q?BmdZOVatEt7ZntR05dj+NJGiAdpdVk+C9xSUBURSz1yra5wKVd772fIZu2fy?=
 =?us-ascii?Q?JK7+tUHj9Nt9JusrPbL8keDXtNkZeOIim0KzKMnDXSmn37e6QCEKA/ReyRWZ?=
 =?us-ascii?Q?zmOiTBRRHd2g5x9f8W+VNFQHNtYaf07WuuAPRfS+y0C9PrhFNrd35ZdHvWKk?=
 =?us-ascii?Q?t9uuAKcv4rtc1U6tGLBdXEYcHxJ07DD0rgfyb9+qTKeMhiVMjLcWjLYxT8ZL?=
 =?us-ascii?Q?AQdTpga+jbaWc5Gz7dBniEXsXvUjDJequnHJujB7W3jJxziH1uvk43CfEHL7?=
 =?us-ascii?Q?BerkL3HZjXL5/IPnow9EPfJQZEn57AIJbWhFuNPqzGzqDKRQq98s+afW+ZAH?=
 =?us-ascii?Q?0eaQyX71quNuO0nuXv4uXw3xNlM5gFeGFMfh9IxCuRf5a8j0WzzWq09ev3GJ?=
 =?us-ascii?Q?tpIhTcgPuoB1bF0Gkj34DBpZ3AsV2vf0x1+LxYvEYY/QuWh0jtG0fjslDWG8?=
 =?us-ascii?Q?PZ9S2C+RWrkiqd2aStxRYhgXdQPMoUJdKHPZY+2Kl6j69OlDdUnyterj+lX7?=
 =?us-ascii?Q?gUL5TDsopdR8ETNqlWMynTpevrA+s2eaRUrmfEVzFnPnXEHvAVBULgWJaOBR?=
 =?us-ascii?Q?u5s7C6Ib5zSzwzFB46r4uanJB8TMMH8+o2b/bLRM1n2GB9+9O/8EjM5JOSJX?=
 =?us-ascii?Q?ntEgVEWt1R+3YFUpqJDx8eRC6otrrA+XIj8hOqdrBiyVoY7RytI5uPngGU0D?=
 =?us-ascii?Q?rlqi/QrDb1q2cc9VYs6ATDL/XPNMEsQ=3D?=
X-Exchange-RoutingPolicyChecked: nKLrueINtkePFEieML5ZznM7xO8ng8jDZRzOu65fVUpttpBzSJ1i5A9c5tYlR3hYWdJy6Ad2CU7UjtT5egz/SZvSTXFPBeKsNFneNPn1EebP/4gWaLA9Aaa/FoJJ5+yY1puRZuPijGCbqTpiEpqJjt08GqzWHSgnmjicLn0LNy0M0UY4M6W83Kq0EU1RF6hWt7dTHjyIAJ8egv+qG7mHU8IFwOfzl3j/wJfj47MgrbZKVzf/Siupp9SV1/J6T+STmU1ud/PCi7rDnhGFm5XgqeL/Opizkj8d5madA+mnQCv44dZt46xXQbRTI2/MUxeKCawYVU54Y8R6YPrQtm5U2g==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a7eb12-9f2b-4479-1040-08defa0801f2
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 13:29:03.3550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4fpuliERGY1QqjbMY/RkyWkwPCTFQOeWC+ROOkAB140dGnq3VB2rSQLLs/YlaePWiGMBelmf0FWcBTx1JSbLM+kTl52VpXIR88KyhNePrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1248
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uYXbDSB4gRyfULDr7gcP2DIYaOoXRsXU9n_UmS79odQ_1786714145
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, Aug 14, 2026 at 03:15:17PM +0200, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>=20
> Enable raw MMC/SD boot mode again so that the SPL can load U-Boot proper
> from a RAW U-Boot sector. This was previously removed in commit
> 25fefa05d732 ("configs: Resync with savedefconfig") but is required for
> the Toradex SMARC-iMX8MP board to boot from MMC/SD.
>=20
> Fixes: 25fefa05d732 ("configs: Resync with savedefconfig")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

And also this,

Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")

