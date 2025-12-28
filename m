Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBFCE784BE
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 05:27:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AA78839E2;
	Sun, 28 Dec 2025 06:27:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="OgX7iWUC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82CED839E2; Sun, 28 Dec 2025 06:27:00 +0100 (CET)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazolkn190110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d406::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F03C839D5
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 06:26:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juS78/NXQWmcdJIKXMrIpcLr+2nWd9bfLA2Y8xXbur87QvrbpOJzU3gAKipfhDw4nxB8GSxPqWzcRAVIA5IEa0GI8MILb11SZiz+Nbg3RH1A2j6TpbYj9d5HOelWpyrjlDBYPezp3bZNyZCdlrARGHAlzviIzzwgWH8zyb3Ljju7zt0ocIGhC/TZtKU+uUDRv0kJBAVz9WS2fbhUhmzBk6In8/prE1Opyzs8xv0Gp9KjRY2yFEjB3IPtlMdNyN0nlKh5Mi4x5aqlJdUqgHdYbqkbvk5n3Y47mcBuNkshwoI5JJxCNLaWiMdydBHmFxBYOUQOpYPsYNDjgkytczrIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6WIkH+B91oooajVcEEcmyrTWRlm+lqfsgBNAsqmUvU=;
 b=O7MfEeSeJVAf/v42LgeweF2vVpHiPlRhqL6QOJEM6d4TjSm60S0ZppQmvXlgcHUe1oapAljVIYl75EDwtt4emFeZ+4HSOtPQ3yLu/aUImvbWAXq37fel+ZL1YgYXvVY/3PidULCXLvWwh9U0NRHci1jBC33HTkYSLjBN71oU3hbl3pUFQ9SYvOdCAxnVm0UqVImnAow/a804pHJKghZyK180/1cPkF6Mp/EX01q9aRGjIcPXaNlHEkixGiaeA+2fHTrBSZReRNAzFH5SrU0PBxGNMZ7lLXhFCt2Agk0rfbs9GeK9thEKUwWWZaR2akuEoVodUduaLEECt5pQwSCM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6WIkH+B91oooajVcEEcmyrTWRlm+lqfsgBNAsqmUvU=;
 b=OgX7iWUCB7tOteKztv1GHW62fmApE70h9Jl5xw1o4bjhUubLCKczLpOyHQIaAuMsh9apTddVi+5TPQjSmoiAK983/S7uFx+iDkQi/yMZNZoPhW9JMdEtMd8MX6VWRPuLHcOQG5BnC2xbdpychJNgYEPoBOnfNrsJYJHYvFp/1h6VVmM/Q9wIBqpVNRo/MpRMm3DdOFY1egXtibndReerxB6cmWlTuNVNwHyKq5UAyQtsvcU60tdS1G4F2Z5PqkxO3OifEH3ue/Z+vUUYbQaj/qxNoaEY3+sXLmq6pR5oDfZg6Qym1EuUqktWFtJ2t6ZCIBQj/yyfoYwHODbS16HUJQ==
Received: from OS7PR01MB13834.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::14) by OSOPR01MB12216.jpnprd01.prod.outlook.com
 (2603:1096:604:2d6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 28 Dec
 2025 05:26:54 +0000
Received: from OS7PR01MB13834.jpnprd01.prod.outlook.com
 ([fe80::6e58:e4b5:3405:28d6]) by OS7PR01MB13834.jpnprd01.prod.outlook.com
 ([fe80::6e58:e4b5:3405:28d6%4]) with mapi id 15.20.9478.004; Sun, 28 Dec 2025
 05:26:54 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anton Moryakov <ant.v.moryakov@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] common: cli_hush: terminate all commands when Ctrl-C is
 pressed
Date: Sun, 28 Dec 2025 13:25:44 +0800
Message-ID: <OS7PR01MB13834BB74CEC85C67277849A2BCBEA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To OS7PR01MB13834.jpnprd01.prod.outlook.com (2603:1096:604:36a::14)
X-Microsoft-Original-Message-ID: <20251228052545.12310-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13834:EE_|OSOPR01MB12216:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de0adac-ec2c-4525-b785-08de45d1b498
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799015|15080799012|461199028|5062599005|19110799012|41001999006|23021999003|12121999013|5072599009|8022599003|440099028|3412199025|12091999003|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YYSsJHNqJLDjy1YopLcgQOYKLpZBnnlViPVplECE/5N6xVuUsbDQsgqurBKG?=
 =?us-ascii?Q?oK9CFgnOWJBG82+k6xKOmL6zqtoYA+7UqiGvj0nn5V7TmzVZCIKucL8PNRFO?=
 =?us-ascii?Q?kiQRhBOCEv92vY847KLxPJayjBRELbZiKc1Zy97in917plAl2eFcTm/96o6V?=
 =?us-ascii?Q?/VLGz41cZ7QyQAoKXuOFpJSZM5o6XUOtFn3aWsT9CMtExr5MbcFy0mR3QDdQ?=
 =?us-ascii?Q?NRFLNLGznNwyTSZ3DbUPCuHlMPfF7fP1IDm8YxluquqRg8Lts3ubIdRI0+XY?=
 =?us-ascii?Q?IjONBosxWHbqwOCPEwGcBGeAFIFfzY8hhHxO5RRSztaas6OfNPAlEedYd839?=
 =?us-ascii?Q?5StMk7hOTvKPDamy1v8D341fZx+U0cQGT8bA1ktpY23jpogP+MJ2m0cSzwXq?=
 =?us-ascii?Q?yeAP+SwUjb42sIVEErqsHS6tXU6+Maw3zfh/WAtB71eEykQqD8Ymgy/wNBAk?=
 =?us-ascii?Q?r8KQGJ2p2t9bG7EgCVgn/7U0FpRmunJ5M6llCu8+jpfU07ipa5Zh8AGzCuoC?=
 =?us-ascii?Q?poYcrLCp0vUyht4av5zeh2Qz6Nbif2uf92P8xLPMK+9usPMnBBXI0+uArZRv?=
 =?us-ascii?Q?rjiD9sUieUfMpuDmVWnC9owY6LJPvPVeVf+bTPpoMRNn7A7TPbZcknPo10Nu?=
 =?us-ascii?Q?9gqFJXuT223WL01eGBN89eBjwHM6ee6ooShLhd5ItXAvXIYtodclZ/Qy4oi/?=
 =?us-ascii?Q?btPF0Smxnci5fkPbi7AoKh7y97YB1DcI1fTuJuUiGtgllVZFJKWraVDkd64+?=
 =?us-ascii?Q?V0NyvEQPpwi3exIMTI8gV2O2VrTVsGKVtYDZ7yykc+hID015lbOUwhJUxHpU?=
 =?us-ascii?Q?jizPd0JhS3u1wz4TLoWtug5u9QXrMV3otSA++o9YHS3SmmlbjW3c8actHbOU?=
 =?us-ascii?Q?k117tnPY2yW/tXEdVufSUkZ0wDLWja1n/hKnhpEdyCzNBO+B+iXIIRXvdBVK?=
 =?us-ascii?Q?Q8t6O+ZFCKClU3/A0yopNN7MNAR1uwj4Win8OtV+eAvSr8zYcoB1CXJNyAAu?=
 =?us-ascii?Q?b4MnpZrzojPfyPdAIzDwk1i8LNiP/BCeqS9pI8uLfLltqbfAYhrwYCAVBGDT?=
 =?us-ascii?Q?HAbv4UTGlPRG/qULwYsBt2TBx3Tyl9BeKLieWEtgb+Wk9iYzdTq/jao4Okpt?=
 =?us-ascii?Q?gcV2x1V2gp1CIQEa4TUFwwCSBOit0qH4Gjqv21D3idxmD9/d4d5zD3JXJn/a?=
 =?us-ascii?Q?BDfTi1dbYbelXR0k48IkDXR9+k+PNXVofhjXOJBX7EnGnR8FItm0WDKpDaNt?=
 =?us-ascii?Q?GJUXkrosLsd8dDG4ViBBimAWBY8jfXkgsghu6SJfTSHFb8RXIJWy3fUhgpfA?=
 =?us-ascii?Q?n+g=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nyqx5dENE4ePVvD0JalUkMMMOwvtqBhrDJ1e2B4Z62keccBaE5RZRChEAuOc?=
 =?us-ascii?Q?hNebEPE2xacqDqiWDjI5P0vVF5LcBrIqRaI+K78G5Umhq/kTOhkpvPz4ZlLP?=
 =?us-ascii?Q?rS8AQwi6SrdCcLY59yYqcDqJN66PiMaDRDrX6aK+/qqbsts1/vVwn+dLBkQ4?=
 =?us-ascii?Q?y6lfGJW+EvtXKymwnu3JLpN/GH4ehfjHURautFdI0CH5x80t1Jo7dnu63V82?=
 =?us-ascii?Q?oQ6t95SjCRyV1oSetOv+yxeAYb1VnCoQi6w5UQ/XCD6pIhfMRiqOjn4L8hPo?=
 =?us-ascii?Q?H9NbKaNZAXIfmQ9UoZ83+dDALVqDqczJzbPwMe/Z4Gku7YZp7CJwnUNmin8Q?=
 =?us-ascii?Q?gGhyaM1kAPw46FQ1q3NApp4H4Y8gxwhy32XHWh4yxCtb+4NgWySnQUujr2j4?=
 =?us-ascii?Q?zkLYWRvz/gjtZBx7K6d+DH5nt06pm4f0bcxGZkWajpZ6vODiqdAhoFlWH903?=
 =?us-ascii?Q?Xbd1S2QoiRSwCMOKOXNrHPkE7GrAvVkEktBIB9DuvNxJjIuJMPFyUmV25rLz?=
 =?us-ascii?Q?Ht3jazcFxh0lOl3UlVpFAefk9llt9KosT6BfmayFgqBGZCHd+r1/pn+3GhVu?=
 =?us-ascii?Q?WmL41tPcxk+8dUHM/PgGBtAxnJ5hol4z1uitfsO11GI/QRodBjFDdD3ctO1K?=
 =?us-ascii?Q?rK4oEqjgbYlMVzI34A93lW6HimD9bS336Ta6hIHpdE0b+LIuz/gMsrndViLJ?=
 =?us-ascii?Q?ls0JHOqpxPKpmmGzof7Q3Z7j9leV2lTklnFL14AEXQyzIlbDvov1VNJsjIU4?=
 =?us-ascii?Q?clA2dGsPXbPY3vZYrHgOOdQnjBEy3XsnIdJTI16d26paeF+Sw9mI+0eZtt1u?=
 =?us-ascii?Q?yXpsjw5VZrokdyVE+KPTix+tzKxyZ+1DxWrx+6IZ28rYgXOF05EPYKGjuMjD?=
 =?us-ascii?Q?BVRvapm+lmIcRh7vMJCw3LuJuAGc8lmsV2FXMAMcPc3S5wnN5H7mVU7narXB?=
 =?us-ascii?Q?fmNyJaescqFHjEFStF5Ep3N7IpPcEriy96L46mqhgqdQjBvcmdYe/7g+T728?=
 =?us-ascii?Q?JfX1pN70pKn/sNnoOPfWawPTMZ0PxpAgpUgfaj1oiJPYagygdOrXbT+V7rIE?=
 =?us-ascii?Q?Jzs+ZVDJrlT6Wi7GEAgDH3VzaSKq4bk+DJ+2e+wkH6xRrldLJ4lHXfhDjJOw?=
 =?us-ascii?Q?ZmwalCnq+KRZNcxtltqAd8zy5ZxkXC4oX71NQTMNYhCu9B1Im5mLkQXfVvG6?=
 =?us-ascii?Q?YCsLQSTm2an09QMPWRY7ZAsLJin6pw+QdCvfVE+ObveigtYFi/FgBcb8Oc3L?=
 =?us-ascii?Q?Kh27yxArBQECAiGX3+MeBqctX5qUrE/nQvQ45blYqJfA8BbqxjECWyzDziXv?=
 =?us-ascii?Q?GluaGjWj7w4/9zj/bfipNVHNnWZ/sjDTbRdaz3oBzIRbwyj8YafjI4eHbDGx?=
 =?us-ascii?Q?h0e+wps0OI6QRUgklK0h+sCq5Gfe?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de0adac-ec2c-4525-b785-08de45d1b498
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13834.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2025 05:26:53.8643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12216
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

Check Ctrl-C status before executing each command in the pipeline so
that the Ctrl-C can skip all subsequent commands. This should be the
default behavior of most shells.

Before the change:
```
=> echo start; while true; do echo loop; sleep 1; done; echo int; if true; then echo if; fi; echo stop
start
loop
loop	<-- Input Ctrl-C
int
if
stop
=>
```
After the change:
```
=> echo start; while true; do echo loop; sleep 1; done; echo int; if true; then echo if; fi; echo stop
start
loop
loop	<-- Input Ctrl-C
^C
=>
```

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 common/cli_hush.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/common/cli_hush.c b/common/cli_hush.c
index 7bd6943d3ed..6757a94a454 100644
--- a/common/cli_hush.c
+++ b/common/cli_hush.c
@@ -1792,16 +1792,15 @@ static int run_list_real(struct pipe *pi)
 		}
 	}
 	for (; pi; pi = (flag_restore != 0) ? rpipe : pi->next) {
-		if (pi->r_mode == RES_WHILE || pi->r_mode == RES_UNTIL ||
-			pi->r_mode == RES_FOR) {
 #ifdef __U_BOOT__
-				/* check Ctrl-C */
-				ctrlc();
-				if ((had_ctrlc())) {
-					return 1;
-				}
+		/* check Ctrl-C */
+		ctrlc();
+		if (had_ctrlc())
+			return 1;
 #endif
-				flag_restore = 0;
+		if (pi->r_mode == RES_WHILE || pi->r_mode == RES_UNTIL ||
+		    pi->r_mode == RES_FOR) {
+			flag_restore = 0;
 				if (!rpipe) {
 					flag_rep = 0;
 					rpipe = pi;
@@ -2024,6 +2023,12 @@ static int run_list(struct pipe *pi)
 	 * In the long run that function can be merged with run_list_real,
 	 * but doing that now would hobble the debugging effort. */
 	free_pipe_list(pi,0);
+
+	if (had_ctrlc()) {
+		printf("^C\n");
+		clear_ctrlc();
+	}
+
 	return rcode;
 }
 
-- 
2.51.0

