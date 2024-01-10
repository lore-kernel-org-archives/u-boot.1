Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F641C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 09:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D320287A88;
	Wed, 10 Jan 2024 10:10:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="DNz08rcD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 634DB8792C; Wed, 10 Jan 2024 10:10:53 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D09728795F
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWlu2bdR+3iBKYUYvu1wLgdoh0IK3Mf92cOuwkLoKvvXvEUgTtW8IqJQRb2UtPjd1NPtXmyUxIfkXYTqJufLb+SVDB/HrwzOOAl921f3d9wKDVI6oJVZJfnuRrUInVr6czqAu4RDnlI17RVJUwJvPqvQvV+SI/ccFzj2g8YDi0wBXGQFMeS5yjbKFXJ+XdA5gf59kq9ahlkVyiXf3/tdxxuWDzmLB6K3rp3BmNllDR3pdhbyz+FLd1/L3x2tulIxS6HqWLN6TJVv827YFU8txqvuVcZgHJq2aaoR5AfMiwX6aGZDwDAFYptHHTinMt4yi37nsTa9ziBz7o5W6h1aAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxvpX2OYXh1p3zBUA3UzGAdQVtYNNehpr3SSRWNlA+M=;
 b=LQRMKyu+UccfHzhkJjrTLrHWeNhltqD++IM0bRfR5FeXQVuA4/otgMBG85QcAsh3cdS8yxYbXhjfw/iaqvgLb5CChEFEYULkMYdoIB8eZSONjl33E7kmOQ0Iv1Wr+zmVpq2lebBRkMm+L/ubwyCGbzUnbxTqPUoXSeYaIsaHVS+zOSQpdM66PEoCb5Vt5AbMiRIT7NNaA8IzNEUIPN4HgFjE2CHxMA1a/U5OwqhOsPVzALjVOBglvjb6all/lx9NlN8IuIaEG+xMs36GuTOTYAo6HWEaQ0ahLQPoVWfcXyd+h5TJvC05eqMNA2/KpJvpkWEbAvYeMOk86GBIMY905Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxvpX2OYXh1p3zBUA3UzGAdQVtYNNehpr3SSRWNlA+M=;
 b=DNz08rcDfFv7rK6etOPjsxqgWivCn8Pfs7osMO+NGgOzWvU9AGRF5z55piVG3PhGyWSaMxFQje9wLvTmBJf16NejskoJ6BIDW10CcV4qJ2fAkK9DXfJEk+18rg0A3nB+T4VmwMC9KwjhcVhtSTzmzc2D7fGwx0vlwmEFCx8tkOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GV1PR08MB8641.eurprd08.prod.outlook.com (2603:10a6:150:82::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 09:10:48 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 09:10:48 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>
Subject: [PATCH v3 03/11] test: cmd: setexpr: Add tests for bitmap string
 format
Date: Wed, 10 Jan 2024 10:10:29 +0100
Message-Id: <20240110091037.392520-4-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
References: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::11) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|GV1PR08MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: abfabe86-28fc-4c6f-6ec3-08dc11bc0902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vO/V2fZ7nX4baGoB2i6T13/hpHMxihdkEZytPYu+7bAHpp4Acw4n3rz+ScdJl1iOzuFBRvj33xBm1V/r1QGmczl5T7InAM8No67qixTVLMGH9trfZoC1RNRckqU2Fvr4CvImWsKdKm3oTAydzHveVMv2D+vqzUT9HJ2dkH/Mnc5Z7Geq7/bbNfQR5FNKbcPVA12UxkdG5EHhjxNMTZFdzH6QVh+wRxmDZ3r/CScZbS267Y78M3202HX3GzaIleD49tBoR/snDZ6GgvYQ54heliAlvb7+l8saQWqkzRMxQcVvqb9aFQZR+Ov5b+Cmri0cKVNLzurfGz/HDf4MwMcUuTXy10gJ3slY0Z1j4T57p/ekrNEFsqK9lUoiKX84fwQhYmXJFjHN9Sz7dt+wQyMQsIp6wJUChPz21s1q0y3YKN9Zi9vzKhdy+VCnzyy+RehFC+mymFMl6slVsciQua+K9MKOd9PgUTiZvLI8MQ6zjiRA5BWP//67/Mqidx7YRC9AQLY5VFy2f2EFGlOpANhARLblk8cDd0cX25yrUL1I1HOkzIB49vYHixUiQW9yG3IqF+T+sqtJMZsXyN+mdJQ/XkaUMOBhAlJlp7FZa6GPIgRwbuLf8etYjJKvExnT7FFj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(86362001)(107886003)(26005)(1076003)(2616005)(6666004)(478600001)(6506007)(9686003)(6512007)(52116002)(83380400001)(5660300002)(4326008)(2906002)(41300700001)(6486002)(8676002)(8936002)(6916009)(66556008)(66946007)(66476007)(54906003)(316002)(38100700002)(38350700005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EyT+7LGzfJxAf/7zS2ZFJKWWZN+Oc5FdfMHGpAugZ6kY1HiibDHq6/6axbzn?=
 =?us-ascii?Q?NytOUiIVoY4K4z3npvXGiAFz599DwnYA35Yr2bqMwE2Qei3EoKmyQvkl7uXx?=
 =?us-ascii?Q?R+73n10t9Lb70AlypLOUSFx4dknFb/PtJmLyBUF+kUvM1lUDgjTIioZYXDj8?=
 =?us-ascii?Q?vIgSqgSQMtzda0sIr7aOBQ/knC4URe8BPcSI70qAousuq4fNO6E8nEVQcYdZ?=
 =?us-ascii?Q?i9q/Wyr+FmFEtBKRJQyomFOFt0tIizy9QzEYjXUC3/xQtN1eMNo4sOfGKybT?=
 =?us-ascii?Q?3cmASc0c4UDMzvochPVHkQdnsZFeesLSPL7oA4DQ9YERTlJoaoekQfwwIZtH?=
 =?us-ascii?Q?JvaAjZGpSMGxC5LSreSqCoIxfsCACY/V8e1LEv5p14vqha/585WNeQ2Egz12?=
 =?us-ascii?Q?Nzq5B22cyJD0D4e5jb87PW4uISfYPrIB9gya3GNqaO2PsBxwIH9o6pSpDu3E?=
 =?us-ascii?Q?c8m+xKP6CobwVD1Ri1+Dz8DhhiGv/CMiSmofpdXpMa+HjHjvcaGo52mmeuO1?=
 =?us-ascii?Q?5dVtehl+HoH6OtjcdhFwjlsHoYv0C73wY6SyKbQVrvIezHQt+WopVJwqlaR5?=
 =?us-ascii?Q?T23JD5XOZTRru2hy3I/aDRnv/V5SGPYjq+VnijlO+DpidYjoyOKEiIAXDsaK?=
 =?us-ascii?Q?t6eKouTcponMIId2H79qag1UeHwnkP9PcMPu5HmjXUtms4YP9HhDwLf8fjiJ?=
 =?us-ascii?Q?/1ziQtkOk62tTOobmPa8SkjU5Wf+NNu/41fwZWb0f/UbP5OxInOf+gInbhHH?=
 =?us-ascii?Q?vESttgqufCA6lKiqSXEuo4JiGa+gy4bfMWu32papQG7u7oVHYKKBfIFmt9WP?=
 =?us-ascii?Q?BZM117EOCvm7Jkgbpyck6/epEXVy6do6cVf5/Xo2rrwnXKFx3dHtHdt1rfca?=
 =?us-ascii?Q?aboqLGICmxSIHaLScVwA47GwQisdhsz1kFvRzuAHiB9IBpPuIctgxlbRLzlL?=
 =?us-ascii?Q?0w67RnH0E/lduJotrsKCruRpW/TjWu2e4PRQ9Flch7WCK3moTWH5NlI/iQyU?=
 =?us-ascii?Q?4RWsnDvonF0xBGblxp7iichkd/9HfmDTpL/oPiKYkcx3VNSOPYMjsSwAT1QQ?=
 =?us-ascii?Q?Xv/6zXoUnMqWeg+Pjtu2UQOqZVkNhQDydYyJrO8aDZp2JZ3QD3VErfE5oyYs?=
 =?us-ascii?Q?2fsFShbi0Cs8nNRKLAzzWQAlmeUVT1IxSAzr9gceTSk9VaoTbIDwHh4VI89F?=
 =?us-ascii?Q?RVNW6LpdoxUelddWV6MnNXId3ZMxPj44rnPz+h+PziuxO7sA2lRGHFijHzvg?=
 =?us-ascii?Q?Xj5zMJIS3FaGz9eD6tdmgXvjbWd1YooYI0Rof8Ru2UHSkZQ/PPAaidcFgtE3?=
 =?us-ascii?Q?IAF0ydUhjzZK8sdLFYDqY/8fybeVGIHfEFy618pMtcmk6Vd2qcAIjNCE0NhM?=
 =?us-ascii?Q?KOdK5MEfmz7UeVWj5vFnV3rmmQ/Swv0+KrNaShi8g9tkcRyV31z2aeM2tTT0?=
 =?us-ascii?Q?ZqJ41reLBMnpfmMJqtcP4p1cuH7tf9qWNz8yHarYXSopqP0qptQhVridjmJ3?=
 =?us-ascii?Q?yuSMuxjk4IR6/bUJrdppLnVflcefg7Zd2pK/l5/1rEk7ShVl6kqKKYHrPz12?=
 =?us-ascii?Q?PGZ6zqdMEV/RqEkqO484Im+DeF6aVE5H5lTeeNyVBZqN5RIxgnmqtJ0VtM7d?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abfabe86-28fc-4c6f-6ec3-08dc11bc0902
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:10:48.3407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XV6+/jyrz0gvqzyVGLWWXSqdBmVOKCOQOtM9AJvqQAWtrylr34PKtF9UV0IS9o2xFzlR835hItRSsFyHyy8ORQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8641
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Add tests to test the bitmap format specifier. Test different bit
widths and access to memory by pointer.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 test/cmd/setexpr.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index 312593e1e3..c536c9e963 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -465,6 +465,28 @@ static int setexpr_test_fmt(struct unit_test_state *uts)
 	ut_asserteq(1, run_command("setexpr fred fmt hello% bf", 0));
 	/* Error exceeding maximum string length */
 	ut_asserteq(1, run_command("setexpr fred fmt \"%0128d\" 456", 0));
+	/* Test bitmask long string */
+	ut_assertok(run_command("setexpr fred fmt isolcpu=%64pbl 0x1F1", 0));
+	ut_asserteq_str("isolcpu=0,4-8", env_get("fred"));
+	/* Test bitmask long string (more complicated) */
+	ut_assertok(run_command("setexpr fred fmt nohz_full=%32pbl 0x55555555", 0));
+	ut_asserteq_str("nohz_full=0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30", env_get("fred"));
+	ut_assertok(run_command("setexpr fred fmt %64pbl 0xdeadbeef", 0));
+	ut_asserteq_str("0-3,5-7,9-13,15-16,18-19,21,23,25-28,30-31", env_get("fred"));
+	/* Test bitmask on 64...256 */
+	ut_assertok(run_command("setexpr fred fmt %64pbl 0xf0f0f0f0f0f0f0f0", 0));
+	ut_asserteq_str("4-7,12-15,20-23,28-31,36-39,44-47,52-55,60-63", env_get("fred"));
+	ut_assertok(run_command("setexpr fred fmt %128pbl 0xf0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0", 0));
+	ut_asserteq_str("4-7,12-15,20-23,28-31,36-39,44-47,52-55,60-63,68-71,76-79,84-87,92-95,100-103,108-111,116-119,124-127", env_get("fred"));
+	/* clear lower bitmask, otherwise output gets truncated */
+	ut_assertok(run_command("setexpr fred fmt %256pbl 0xf0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f000000000000000000000000000000000", 0));
+	ut_asserteq_str("132-135,140-143,148-151,156-159,164-167,172-175,180-183,188-191,196-199,204-207,212-215,220-223,228-231,236-239,244-247,252-255", env_get("fred"));
+	/* Test memory access */
+	memset(buf, 0, BUF_SIZE);
+	ut_assertok(run_command("env set myaddr 0x0;"
+							"mw.l $myaddr 0xdeadbeef 1;"
+							"setexpr fred fmt %64pbl *$myaddr", 0));
+	ut_asserteq_str("0-3,5-7,9-13,15-16,18-19,21,23,25-28,30-31", env_get("fred"));
 
 	unmap_sysmem(buf);
 
-- 
2.30.2

