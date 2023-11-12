Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DF7C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 12:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A0086F64;
	Mon, 13 Nov 2023 13:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FE3B86EB5; Sun, 12 Nov 2023 20:17:09 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04olkn0825.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::825])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4040B86D3C
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 20:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRaXJGJK2+Zh7zQgBSena3q9bs2MZY8qCvc/H9JkVL7j+HHqyq7STFIo3hpfWKX+jp7M77VaodTzS0Lug/j2FrC3VnuA2qS6WYmfAO2cM50KhYjWjVBzT9pSI42NwOkFhdGS9wtyVxDdyin7xSLF8LyaJ8EgrglBuVQfDdvbZ3xcnG9/1SojS58LLHKjtMwdLVTmvFt8ADyysKUB4zSZ25caEG5c/X6xZkHAEQjiCClOFX54UO4Wm0PJPR4CkrvYrkElZFn3xBfabvWpgqqWAIjObYyzkjunqu6g86Aim1erRlxyfYR2t3bjT2ODCKOOMV3SSQ8Ur/b57TYKS5P51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+Mn/K5wqAx25a713Bfb/VkziXfn0xrUvuQBwkM0Nhk=;
 b=DPPCWyPrQtx+RIM8umTEunSgW1wVgBzPhcUDcjG4zhOiUiw4aD60tM7I0TQou38q21In9CEOz74cfBgHuCLFvZhzZwath/U2dU+bDBzpkZxTpzNzbxotPaDEIHOj5Px0mZFNGcuTk1CA7klsIGQnTZNEM4N3cym4qh1ILSBPbCUVL238lqaK7iqXGpnfCdqeAYryQMkR/KRVJ5B/JhAYYdfTCI0V48D9/SsREkdtJdoscCKsUModCWmIUqI1npKtQ3KTJ+Y+vDh4nowBZO4QFdUz8YcXVpiPN6zY6BCqZZsWakxJLUZJaOAPni4jtXoLW/aze1PhwpnfltcuNuQxkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PAWP194MB2055.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:337::6)
 by PR3P194MB0540.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:35::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Sun, 12 Nov
 2023 19:17:04 +0000
Received: from PAWP194MB2055.EURP194.PROD.OUTLOOK.COM
 ([fe80::b354:71fd:200:420d]) by PAWP194MB2055.EURP194.PROD.OUTLOOK.COM
 ([fe80::b354:71fd:200:420d%4]) with mapi id 15.20.6977.028; Sun, 12 Nov 2023
 19:17:04 +0000
From: Francois Berder <fberder@outlook.fr>
To: u-boot@lists.denx.de
Cc: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] lib/slre: Fix memory leak if regex compilation fails
Date: Sun, 12 Nov 2023 20:16:50 +0100
Message-ID: <PAWP194MB205547087E126BAE0D2EB0DDDAACA@PAWP194MB2055.EURP194.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [/kmu4jS6XswB1eOpnvYNeUt8tRuUbe2Tv/fsvmHaVkw=]
X-ClientProxiedBy: DU6P191CA0041.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::21) To PAWP194MB2055.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:102:337::6)
X-Microsoft-Original-Message-ID: <20231112191650.44414-1-fberder@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWP194MB2055:EE_|PR3P194MB0540:EE_
X-MS-Office365-Filtering-Correlation-Id: befe5f40-792a-4911-09fa-08dbe3b3f458
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M1HS1GF3IkEcbzYZHitZhDgkKln/DOmVSPutr1BbuvYLFjzAvyXDDNqcFrPRe2lAWRLVT4uMrIaD1GVHOeCo54BTpK8j0LrPcLLniITlYXWygGjC6EorG2QPgYDMUQXLXrtDD14k6pghUCwQfjeSB3Dgpf+Oke/mvLvRAcp26hOH4GQ+fJesTXQ/xqB2rssSYBTSdRJ8YLWNK31xuGgFphbya/5NMtw7iuA+7qBsRbkqXSAOes6RnYV0SZ0ijl1UgLXVoy92y64t5qHBzTGqMQk+XPKz4gR+FVlGddu8Chax9q1AhByhyyM+tgzIHc9aldiNPqabTlhlqPuYQ6tkqzAQX3zOFiGEn+1OqTS/NGOn5NZ/qVT8uWsaDlg0F8XwcPh8zvEq0h68My2HsT5I+xvv2Tf9kVxE5w/FRQJPa1Iw9WF6wxEqA+/k0/2q3AA5I2ZFo3meGNejfID5rGCTSaTGfF6tuMr9eMO05WeHtK9CeB1Ig0jmdgs3PfQOs57+wuZCS93KgIVhzmlmFI8vblxBhxY4zzb9qKPtzZXJBF4GfdZfbzuLoUFSNi97n28h1MsImvGOc39xYiQot0v3n+Gmo3YrOKmrlwCpHleMVNUf7qs3e1JyfHmayeBuCK0Y
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EBA+Fj9HK52LzpK0wrXoAegiH9RtFOelNh9yUSVdBDz2UKSNyQv4QILVsEvc?=
 =?us-ascii?Q?xHFnC8fHSxgyx67fSvSrIXrkNOQmTEMGooE7LkR0ny85hDF2HEBRd8L7PGnO?=
 =?us-ascii?Q?hDAXO7WO8+fHsc/kK5+0LEY6D9dzDe86UVuJBoeq8c1cN7Cib1T4zIji84P5?=
 =?us-ascii?Q?R5IAwKThgM8FTwcpX2ZkWraXti7IZpyZNStsuce8FP+7rDf1OJLuWp8kSDbX?=
 =?us-ascii?Q?Wj3r/r/OiC0arujTZT40fdv1telJ9qKaqrLp84CRzcO5F6D7OAnWOmO3shFE?=
 =?us-ascii?Q?MXm7QBIy+8InRzUMKsOZY5KhVwHaRMkS7StZZ3omxIoDMTELIefyI6rh9vpX?=
 =?us-ascii?Q?6J9HYPALlIYRzQwBdXFe+4NWkASE6P2oAGEvKnleAyw12L6+hnvIbLcZfJWU?=
 =?us-ascii?Q?rOsUBWSqG172CvuPLaD9G/O78NGa5AFh1ITGUt8nSOGndqExaTIrUu8zahdU?=
 =?us-ascii?Q?Xs9BiOeGaF6m16Mn1mGTRTviZMG68maX3S48aJlGoiLBvl3MqZKTeE/wXVok?=
 =?us-ascii?Q?+M3ZcL1DLMHET6T/QirE9M4aJewvlPvLct1JeLhW4jC9B/PFtqB5V/cMFZTu?=
 =?us-ascii?Q?QAEJbofks116QUyTvMNtoq7KKehoaHLRoxfAHXgLL2MdXAwX8ep+oRg4p5Nm?=
 =?us-ascii?Q?h6/LW5JBBNEtN1KE/8GSfH+MNICsU39TtPGANBRqHs6sfTwVA9n9PtOPJc+B?=
 =?us-ascii?Q?knBgU+Bnj13Mqj8IIw8c1UgMGaTFIQw8J8GALoNlNynt8INztQ3VBzQ4W+0Z?=
 =?us-ascii?Q?qsxmljU1HllA/8jpQH+hKlbA+B4RMio6E495wkOKYyjOmAZLgOALHx7imHPN?=
 =?us-ascii?Q?NQK4jlaZoOckqylDw8xiTcuZUcMNT5OHFkFr7NW5h9HkJ9o2nR88ScCbN5Xh?=
 =?us-ascii?Q?JlwbWTc2WwbWU4Ktbml1ZIJfH9SR0JaOsE/kUXHqJqRB/2mmzWcAkshHl7KL?=
 =?us-ascii?Q?H+F08uOcx20Hqu1ZzHbYcGY5DOCs6gFlTQYNv6Agk5DTGl9U2bVydC9bZ+3N?=
 =?us-ascii?Q?9frCdd4A8B4pqo3mCZl507QMsaogVkyhTxUClhFxAqFtoQc1ixA25LSE70FW?=
 =?us-ascii?Q?jHFS/adGQyb8iymu5tm6z/zE1wNUjnsRlil80XO3XD2fx+2yNcP2Qn6VQIqh?=
 =?us-ascii?Q?ztKCLKYs5yhIe2x6WFMEpuKKISN7bZ7zusSkObNWxzWopKGMHBFptATPV8FZ?=
 =?us-ascii?Q?ivqu6Gw1hqujbA9hgEBq6S8lAqGm97cR6GC7hw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-84264.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: befe5f40-792a-4911-09fa-08dbe3b3f458
X-MS-Exchange-CrossTenant-AuthSource: PAWP194MB2055.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2023 19:17:04.7360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P194MB0540
X-Mailman-Approved-At: Mon, 13 Nov 2023 13:26:24 +0100
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

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 lib/slre.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/slre.c b/lib/slre.c
index e82a9e7635..e1a50443e0 100644
--- a/lib/slre.c
+++ b/lib/slre.c
@@ -686,6 +686,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (!slre_compile(&slre, argv[1])) {
+		(void) fclose(fp);
 		fprintf(stderr, "Error compiling slre: %s\n", slre.err_str);
 		return 1;
 	}
-- 
2.34.1

