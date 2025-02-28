Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46914C282C1
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 03:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ED86807D7;
	Fri, 28 Feb 2025 04:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tDiLq+/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6D2A808B6; Fri, 28 Feb 2025 04:02:53 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22BAF801FB
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 04:02:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpgdSAiPOFQ6mMTgnF/uncaGpEtAznfTQIV9G4OqFn1wnVnWJ4ldL4g1UnmdFIQU6li4BhcYwKoBr0uu7BYmsyTknHdJkkwdcnyx3tQWPM9P6PAa/6VX5YgJGWryyyA301WoRcnIC6DlhVXf1fNtFIwxfsPSWL1CP2/Hn85KOExAhWkuCmLy0KmN82n4VzICijhcZ3QXOcKssn1jmkgHlWaN6A+XYZociL9zw5fb3PAu5okB/8mBGcvClZELDKzvL6YRUwwQxREY52b0r8NvJ3f3FHcQf6LeXsTbf3nHo5MRIU1Jhv4LdC7YOa9nSImq8Z1Xy2GSDO/AkpSPoh1EVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCr3LatM0TRcELt5iYpVr0aH9gNS6T3sl5CXt6J8c6k=;
 b=gsYJyTQAP/gkS7MGxIDV9ow5vY5ZfskMYJ3dJomrBzvM84VygJE7C8qqTLBecANTy7Ao+KuHS9rehySRB9Iv9+qFJAtfX6rDcwHgDVzrP75uw2YGYTiLs78wjlmHdvfkkXsU0CjH/8+buFHSFg/SlDg1RK9h7TJrEvJAhJYoqrV0WtE/a9uD+yXI+w3p9yrHTDHoOx+kqNataztIMD0j4GWjRO6kjXw/wPa5OYbZZ6unMI3PYhTAlZfdOgMcame2aNSlVEPSM1lTi5HkxA/RKzu3Y9yDtQDd8lKi6qaqHDBlGMfiwPoAj/UDMW0QCruxhw6kra+Gptw/3myUkuYozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCr3LatM0TRcELt5iYpVr0aH9gNS6T3sl5CXt6J8c6k=;
 b=tDiLq+/wMNvxS/Rn8qIBj5VT42/VSPV/wijqeDJHuG9u6lW9arnMcSaWi9gqmWlDyFr5dCALnXqj1vS8/ehnvnSxDdSrykFHu+8DwSYt1p2Hmk3l5d6SA90Zlz8SHchh1z17zaVK0PTR+C4jwcYLtIXDA5w+9T+sgH5si11D7Yr4Qc0oxAH10sY9gbaEFqcMxTSEcZtoTB0u6lLh9KLSW91tlJqDJVrsxHxhUbB4Rt+PlwxZ9UEmRjNdWUdGSDaFsQiZq7EfNiiXnBKIZ7N72Vm5o/0X49u9GcDXghx1NNgG6Ok04u2tNkrZRrj62cqdOGpR5pW4ZEbmoImT5n9i0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7413.eurprd04.prod.outlook.com (2603:10a6:10:1a6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 28 Feb
 2025 03:02:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Fri, 28 Feb 2025
 03:02:45 +0000
Date: Fri, 28 Feb 2025 12:10:01 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: blemouzy.ml@gmail.com
Cc: u-boot@lists.denx.de, alison.wang@nxp.com, sjg@chromium.org,
 trini@konsulko.com, olteanv@gmail.com,
 Benjamin Lemouzy <blemouzy@centralp.fr>
Subject: Re: [PATCH] board: freescale: fix LS1021a build
Message-ID: <20250228041001.GA30605@nxa18884-linux>
References: <20250217153603.100767-1-blemouzy@centralp.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217153603.100767-1-blemouzy@centralp.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0067.apcprd02.prod.outlook.com
 (2603:1096:4:54::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBAPR04MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: a420c129-1346-4758-ce43-08dd57a46000
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|1800799024|376014|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KU+BsRTfNiL9btDvuAakKnNVSiWBpZbzOeeyk/fq42SHgqCj0jz4V2Cf9FE9?=
 =?us-ascii?Q?4P6posQFVd/p5Ay2cJBkH04fHGK7e286yGpIUIO9ge2I3JxBpSUmKYjF7B4s?=
 =?us-ascii?Q?0xfkKX84TndAGgWxKQltkzR2NOe4vN0QI+U+wLT/bezxl1lO/apuzIrHys+2?=
 =?us-ascii?Q?mhqyai8jfLqf3QND0IECrODoyK0y3RGhl8/VJV4KFhqvabRgOsdlATY8/541?=
 =?us-ascii?Q?Qnao/Br/UGQqpuNxtooZ8ERzfE7hELYrNz/K2diMeVxKz/Wc6i7CyJ1LNY/u?=
 =?us-ascii?Q?PiS8gW5QDxBGchCFVTGBvkq2wEUi0BgPzjTluSjVTgY8M9MBrXsMhfYd3TEt?=
 =?us-ascii?Q?snf8szsA7EI1MOXDH35Vps21v2d1iynrvnP6YoyHyK29p2sCb+JeaBWcUcJX?=
 =?us-ascii?Q?fyNWV1KW8rLDsuQ8kSQCnC23Te2sJApnQgM6aajhCe/1nGk4PYEgdhbYcy00?=
 =?us-ascii?Q?5KvUCSvyz9ZZdP0WHwgbKKjB/I1ZdHInzRMNQwRaCQcdN//9fe6SAvafvehb?=
 =?us-ascii?Q?8L5KDV73m/cU/IjsiCV+np2Wex4RTvryJlzTQ7Thc9LXTCq6UW4rkA8zj5p2?=
 =?us-ascii?Q?9ZlMA1M6jWjj0t2NrPU5Z3+cbmwcWUKfbe5JKEHOy015slcgD9uT04Z97cua?=
 =?us-ascii?Q?t8ZDMLxi6/z8UUnlvTcnZ3tAEc2+A9N8gWc54ic7F4FbgXL6XrkHYWY57Kng?=
 =?us-ascii?Q?vSrT0OYRuoF3ircGUjx585ReD/OaVMQ8ck3TSCxuD0Z+lD++Zmu4v6zHHil1?=
 =?us-ascii?Q?m3gAPaHTafVTVW4R5SRl7vJ2IxJmKTSSe9P/XRdNbpQfQDVS1tu36DOlGYLJ?=
 =?us-ascii?Q?e6xJ8E/E3ehICYFpedyRzJ80oKwKKYuMGAlgiCvuVEcLh6wXtZE7yu5rJcJ8?=
 =?us-ascii?Q?HNrspjLJWP6wfYRqFdFFdJanjPQR4JHRv8fROiU7wYpeqYmQJsE3KSOiy9q1?=
 =?us-ascii?Q?58xpUTr3+mgL552zLwp2w2pPohjHjCa0shB8I6QwHjv6NLbE4XIONIqu2RJW?=
 =?us-ascii?Q?C7srAuiXrzCJRSfgrRcHRZmKhm+S3HNL/5kiQ8L4m/ABnKEyYAGA44Dv9xeY?=
 =?us-ascii?Q?pcYYM0D1XaOf11aP6MHwsNF1G3kq0G58kXvmQyTBNXLUOksBYH6A2FTrkqDt?=
 =?us-ascii?Q?QrZvuASTXlH+vH1m97s4wjr1FJvYw97qWKZpsYyBJQL6U3WARRYgIcIsVoGo?=
 =?us-ascii?Q?lO5o4bc+o9HDZ43IInbMJwPFljMhW9BvJfrh9o9Ggqivt7KKhogw/ljU8QuN?=
 =?us-ascii?Q?OSG1ysqX+zejX3Dz8pBJLzo+ZNN4h27k8+LMJuwioL0mvpyIXoMUxSowla9+?=
 =?us-ascii?Q?vnNwd+B85NET0IrUJwa8n2Z2Bx/tbpGHpHP4ZDow7ZISM+PzxwMdyL8aDIFD?=
 =?us-ascii?Q?NMq0sbsGEc4ouhNg69E4hjsSslAS4DH/gVqkEi04gyjgD67+g3b95b3/Kkf/?=
 =?us-ascii?Q?z+d10ixkAVzCj9k1uyOrVfCADpxYQSK0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(1800799024)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y6nTEXamOmPM8F9RF94lNcdwsYwGyFAFk2y7BDGryEL0UF10UUxW4qNRnd7n?=
 =?us-ascii?Q?tarTjJpj64pc0xsUe7UlOrDeJZcckFbubrSb+Wz9nOjgF7ZAN0+tQyVHT+gg?=
 =?us-ascii?Q?qElmmLg7FyZVhX/fO6JC71RE3T1bLHz6UT2NNeUl3rWc40syk3GOS8m13DOx?=
 =?us-ascii?Q?I4yXPV2fpvO5Klmmfj0/99orkUmgC7496elahkVx2gdqBjPNLqeE7O73mayC?=
 =?us-ascii?Q?gL1/JWnU+HglBZ91J4UoAxN1nLBxpmbcq8CEmUT2VdPK5nGF91f+F5uJdjmo?=
 =?us-ascii?Q?G38UkAKfdQjOihX3m9eRft9KYhmhkE7fBCzkucCQKQ4J4xuPApHFxnNMSnMb?=
 =?us-ascii?Q?C4tYbIRe9+dMXSgw8rCqSbaFLfus3GqpwqVq94Vet+qA2X8J/doZe/Q9kmZl?=
 =?us-ascii?Q?FULZZxvwux9sVbUUkc10/Kg7YrMtxKgNXnz/g+m8IipOPPcSfADNuGNdmvu0?=
 =?us-ascii?Q?YkeYrKR0gibDaRIxBDafjB0P3PRWb9WkuxqYORmiHl7RPiGTHQNs5Ewj6Ilk?=
 =?us-ascii?Q?AKm1gWK36J2nIxjjCDlbY6495w4LP18zlBsIdy0UXxVxGDNjEdpUHtD1/rla?=
 =?us-ascii?Q?Nb2S0DMRyVq+TjLPWDbJXm+f3yaoE7zvgW3cEdevVOabvfL2Orbz00c5XbyM?=
 =?us-ascii?Q?27t6kOqzXUwmI4bxeII35zENLmhcRXEhYoeQtL+t7A8lcJaefbKAsHzWXWPW?=
 =?us-ascii?Q?Tvm0vPuP9bSX6FGGMmN/XsW7dkwIBZWW58wZq3d8IsfxKDW4mUds06X32mQd?=
 =?us-ascii?Q?KDZlQYjrvi87gilwW3odz81ijtn6b6r5548QtzsPjiJCMeencLwlR4Zgv0dl?=
 =?us-ascii?Q?rBGSc45mmlqayz1qqugtAlm1j3HZfz4RZkJ+KDTKX5s9h0zUlGa9g1nM1f3P?=
 =?us-ascii?Q?qPGOTHfx2hI20GZ3Hho2JSt2AhOCS/HFIhYayYgrfPQiK6Uf3ieG/wY/xYAi?=
 =?us-ascii?Q?6dyMrMJ5IIK7KOSJI4s1iNcdXl/I9L2QwIu5UMW9S/06Z+J4ryLMAELOF3OR?=
 =?us-ascii?Q?K61BPsC9nlOKqk1PBNM9r7csUaeLsphmbPQ32asqwPDS6F7BITvzo9naEqvS?=
 =?us-ascii?Q?IsUsJcTYYdXl22bJ9TN5PTmxcjJYV99TfYTLFHWfq5seKmJfMIZRNa7HjtmI?=
 =?us-ascii?Q?C28Ing07TzZaq2AKRep/7DsTmGfqR12RLTIn06k2IXPqun2EGEKTPAmV9K3s?=
 =?us-ascii?Q?YDgKB1Ey1wqGUq60VVjOBATzg3e0Mz/Te54Bj5NBDt7h8y3ZOSz6RnNx7ySD?=
 =?us-ascii?Q?HEWPGOavCqAavAAKbrw6wgb3e4T7F/3eiKZ66ozfXhKJKBnMTb/ewKMb8S4l?=
 =?us-ascii?Q?O7EwSKDW/XDbyHL1IaO4OKjCpzdXpZpSdM4dBG/tKuaGQZunonC803z6pCEZ?=
 =?us-ascii?Q?vbrkDO4NgMRU9tKSmEeJLqn+Wac2UBo3bc5os3/cgiShybr9EcnGjPxNtLOx?=
 =?us-ascii?Q?bVLRC3ZDdFyvBR3ff0p1uIPgcIHQAR4+9k8QsV7rWS/QprWEYLefb/Kk8Nlr?=
 =?us-ascii?Q?PxDb/VQ+yghOTv7AGZsGdo/FyRyE6cQ5BOdUlSOtjUzcaSrBVfVOX5XpSMQU?=
 =?us-ascii?Q?sDU1iggHcPBDll5KUeWHIbDeLHjvWaKJ/XXym4a6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a420c129-1346-4758-ce43-08dd57a46000
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:02:45.7534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXAa/4b9JliT3UVPq4iMf4yZluBMemm8THfCfSae22NQprg9pbmGeWqUAwddzv9NZEHt0BvNtxTksyqXoL9oUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7413
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

On Mon, Feb 17, 2025 at 04:36:03PM +0100, blemouzy.ml@gmail.com wrote:
>From: Benjamin Lemouzy <blemouzy@centralp.fr>
>
>Fix build error "undefined reference to `is_warm_boot'" when
>ls1021atsn and ls1021atwr boards are built with CONFIG_SPL=y and
>CONFIG_DEEP_SLEEP=n.
>
>Signed-off-by: Benjamin Lemouzy <blemouzy@centralp.fr>
>---
> board/freescale/ls1021atsn/ls1021atsn.c | 4 ++++
> board/freescale/ls1021atwr/ls1021atwr.c | 4 ++++
> 2 files changed, 8 insertions(+)
>
>diff --git a/board/freescale/ls1021atsn/ls1021atsn.c b/board/freescale/ls1021atsn/ls1021atsn.c
>index d1acccec11..6d64df7cc4 100644
>--- a/board/freescale/ls1021atsn/ls1021atsn.c
>+++ b/board/freescale/ls1021atsn/ls1021atsn.c
>@@ -159,7 +159,9 @@ int board_early_init_f(void)
> #ifdef CONFIG_XPL_BUILD
> void board_init_f(ulong dummy)
> {
>+#if defined(CONFIG_DEEP_SLEEP)
> 	void (*second_uboot)(void);
>+#endif
> 
> 	/* Clear the BSS */
> 	memset(__bss_start, 0, __bss_end - __bss_start);
>@@ -181,6 +183,7 @@ void board_init_f(ulong dummy)
> 	enable_layerscape_ns_access();
> #endif
> 
>+#if defined(CONFIG_DEEP_SLEEP)
> 	/*
> 	 * if it is woken up from deep sleep, then jump to second
> 	 * stage U-Boot and continue executing without recopying
>@@ -191,6 +194,7 @@ void board_init_f(ulong dummy)
> 		second_uboot = (void (*)(void))CONFIG_TEXT_BASE;
> 		second_uboot();
> 	}
>+#endif

Please use 'if (CONFIG_IS_ENABLED(DEEP_SLEEP) {}'
Then no need guard 'void (*second_uboot)(void)' with if defined.

> 
> 	board_init_r(NULL, 0);
> }
>diff --git a/board/freescale/ls1021atwr/ls1021atwr.c b/board/freescale/ls1021atwr/ls1021atwr.c
>index cc9665c041..937e766069 100644
>--- a/board/freescale/ls1021atwr/ls1021atwr.c
>+++ b/board/freescale/ls1021atwr/ls1021atwr.c
>@@ -410,7 +410,9 @@ int board_early_init_f(void)
> #ifdef CONFIG_XPL_BUILD
> void board_init_f(ulong dummy)
> {
>+#if defined(CONFIG_DEEP_SLEEP)
> 	void (*second_uboot)(void);
>+#endif
> 
> 	/* Clear the BSS */
> 	memset(__bss_start, 0, __bss_end - __bss_start);
>@@ -432,6 +434,7 @@ void board_init_f(ulong dummy)
> 	enable_layerscape_ns_access();
> #endif
> 
>+#if defined(CONFIG_DEEP_SLEEP)
> 	/*
> 	 * if it is woken up from deep sleep, then jump to second
> 	 * stage uboot and continue executing without recopying
>@@ -442,6 +445,7 @@ void board_init_f(ulong dummy)
> 		second_uboot = (void (*)(void))CONFIG_TEXT_BASE;
> 		second_uboot();
> 	}
>+#endif

Ditto.

Thanks,
Peng
> 
> 	board_init_r(NULL, 0);
> }
>-- 
>2.43.0
>
