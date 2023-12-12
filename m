Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D85C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 08:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C7DB877D0;
	Tue, 12 Dec 2023 09:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="iv4Eom/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2847877CC; Tue, 12 Dec 2023 09:53:13 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A644877D0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 09:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vsp3fu+cIPZLNoGToVFCOR4ZVbuHwqlGCQZS2zuyT/dV0BM/UmJzYIrR80lS8QG9tSZ8IIzsqDAg8Pj1FGIMI81/SRXnU7f4//XDTMM/7ot0vYqPp2+NzHP8WgbRMf8NuSw5eaHIV7sM8S3PP0G/xgo/5YsEHbX+pjGlRi7rKa2IgLy8iurKSMpE7Jr5oPsZa2Ud9iv0a2vHbZ/x6pe5kGQqm6UFe8CnLyb7wroco2Dg54kolOy6wf9j/TgiwiPDf2bnQz/pn6YFrsEYvG2dUpkWYFsY14XIkdf7WpWwFFgpfbOsBjYx/6V8Kikm7bkzsNWlygoMKVAvWOYXjMo1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npjd/hxCW+9j/k6QNC+XilXr/Tk9y/S3s9LV953rvW0=;
 b=iWCPGATEvfoTGCmvHM3jnalCaMPAKgdfm0GHeLDJx2VWfzoQrWOPM4G7hhTAlN9wttUdH4h/mbxHwZ3NryApUNzrZdVzvos4wjFXkJ3Yerv0JlmwYF+h2yREoRAJz7g3avYX6I8BpEOzrWb/oMAkPKQYCZhm/B1W/5NUwLADYPj1LY3tFPYKC9jjSvD2/nhNc0JGQ5i3TgnpvZKzSGrxvytJuxRLYCWy65A525/ZT3Vk5+S1PqXk16WrnnMeZ6v4+/g1iILf2dJDH8Y4fCzpReZAr82oqoG+WIxdO6BI378bXwg+6EyyrL+DRWrDz2bGdcXZCdjJxgalpupVlPVfGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npjd/hxCW+9j/k6QNC+XilXr/Tk9y/S3s9LV953rvW0=;
 b=iv4Eom/WrF0m3Qoc+tWEKwkk1fxPf7GHKny/DWlOqirIUy5y86s5yuZRGgpf4kDaFWOehUlP3xw0MxHT+wQGGV13B5iq+COHLV8O7g9QeHkSC6XNaan1Zi0n5jKnmd00ZxkRtRD/aqxC+aX29rD294aZL9U6GeU1diyP4Bl5Ino=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM9PR08MB5940.eurprd08.prod.outlook.com (2603:10a6:20b:281::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 08:53:09 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7025.022; Tue, 12 Dec 2023
 08:53:09 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>
Subject: [PATCH v2 3/6] test: cmd: setexptr: Add tests for bitmap string format
Date: Tue, 12 Dec 2023 09:52:33 +0100
Message-Id: <20231212085236.2730768-4-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
References: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::6) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM9PR08MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 75978ace-51bb-47fd-bcbf-08dbfaefc3bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Df0HPeu0sAG7uWClHF8Ds6w+VNRzTVw0g+HN/EphjKSdt/J7m73Yyl5hbt3d0oqTvDz+2STQuO+NKRgEjIZpSRAlJUHM4eawsJWke0cK8ErhhFQEeaB8dhbKZ4wGnHKIc4fVEXiUL+aR9KqipUM5K2cwn8rLU8mGBEVsCvtVkTJ9wcRaijED9xiSXUpju0asdzVea0L1q5TFHzaBRQPqX5m2rM/khEucxw60ZBZOraUOB+azRkzkD+/3Zede1eQYPEP8DqtboX3vn7I1CaIoIpooqI2SogCeTab6A3VVRwUtDz4KkLV9xbCMDMGTM9vEfGk8rHHIWdxZPUzDaWQVjjHaxfSuXI7eniJaO6+5bDSKd81RaWwhL2z+dxYShrwhtjUFVK1d+j2/0eoN8G6fk9zsKm0uqaXHwXqsBgWq35GhZkh/mIObz5ooWO3b0nU3v8AIA29bnxc9ZPeQbyk4aiYfkNCzdNEAf6lLf1pZp+18boFMY5PuOwzXE8npRfdU1Irvogg/AIGR1hm/Pb0lSzM1FPn478pApMak0SyGAgXcHsXH9tONKFEpzT7mLQbH7OW5pF5me9N2JJzS2frhXxWWaJ5P+PzwVYV6FlJxDh7nAZ6n3bs9Wptp9sXhbL/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(107886003)(83380400001)(52116002)(6506007)(6512007)(2616005)(1076003)(9686003)(5660300002)(4326008)(8676002)(41300700001)(6486002)(2906002)(6666004)(8936002)(316002)(478600001)(6916009)(66476007)(66556008)(66946007)(38100700002)(36756003)(86362001)(54906003)(38350700005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FNlNOEfdzHAHLZ+wwxlvaXjxyxehTyINVTVqzAHerGBWS8yDFR2NOI0qYntW?=
 =?us-ascii?Q?FJ/pyG0VU2YAQ1k5zQSiRCKYDC/kbP6wl8m4shg4idRv6qW9MnsNxhS/7WTo?=
 =?us-ascii?Q?H0R2dLpdW7AbwmsRLa0YCtwvAS3oBGDCJfxWOMOrSdedsS0r9uj6KZXPcO3z?=
 =?us-ascii?Q?/x97B3LDkS20/59AS+gYguTb/ejRNjh9EVecrLYU8NKKTXKu3qq/8mwIHoex?=
 =?us-ascii?Q?alXI1ArFdgxcxfTUC4TFZ/KgxhTtPnBNDDOUy9w9dGLP8uDpM3GpkJL+5Jo8?=
 =?us-ascii?Q?fuAI7kgmEHL0CPrQdRKxUdrJ/LKZF+a4Thrni2jaVuReYo01JG4WEpVdyv9e?=
 =?us-ascii?Q?d64gsUV0BXCnLf1JzSFancReaTs261qaAMRZGPNvLNCfsuiaRFC2597A0V0W?=
 =?us-ascii?Q?1CgwSpAGiTDejMhImmBpEW1e2ZgESrJe229Tp+AvfSefn7lVDngv4Ny5Opu5?=
 =?us-ascii?Q?gLhc4bnR75r4rtVM1XEXyUa7hGWN5LZfQhBFLzvT7qgt3aiuEmqm0JpUUuAk?=
 =?us-ascii?Q?w44vQpLo+SHNCbh8J6jrINze5mJkr9YIteFUpi73pu1Uh+OsYR6E2PwfuDhy?=
 =?us-ascii?Q?cFsjyVRb8jrGMFYZFKSEMNWVU6sKN+oVOjqAJoc5ixV8vUDMxnsw14OpI8/H?=
 =?us-ascii?Q?16Z+2TzonVfOAOFGpI6e/jTzdmYGC4o6jncy+1/qPCgIuVoE3/oYOwfZWoXJ?=
 =?us-ascii?Q?Q+/oGz6oPWoTlmASi0nr8ETjDrldyGJWaGCUvRDc2NzO+Sd3KSFRdBql2QQL?=
 =?us-ascii?Q?Sz2D4HgzQSNPgvmF4O4kAKiVAwFyUzvUs+3DkPdZ8XvqlJXDeE3SHIKf/Prl?=
 =?us-ascii?Q?jscyjG109X0ncKEaPcrOXzFVkz0Qw38sc44f5679GenW+qfHvmFNRO3g4TIS?=
 =?us-ascii?Q?MC5AWYXI4aoVi4yFEm0u8m1nF2fCPYUC8xFeux9p6RUqzfMNZsSax49v/OTI?=
 =?us-ascii?Q?RhZVGCr5BJjVZTjFoM0TbY/33q/tyoEsqNXPl3GeRmgq7bu+ZXC9vvaW5Gwa?=
 =?us-ascii?Q?8bM3S+OjiMyCD9HsbmETmzqJMmPOo/wfzNna6ctV94P611RMWZK3szMIuYmO?=
 =?us-ascii?Q?yoQf2O7qzohdMS2sNrPxF62ZOmtmLepd17sw5fz08mD5Lud+hXj0hgF+mrOB?=
 =?us-ascii?Q?bumzUfocbM0PXiaaSnJa0Z/1w8dlDZ0/w7DzYQEByk3u9sHMx6S9v6WhZbst?=
 =?us-ascii?Q?oOok8csQ2MJtZnr0g7hHmIsLae/lvC33+WfxLGyjvmemDaSksYvzFXmiysFI?=
 =?us-ascii?Q?MyjrxaomjdfFcD2zgJvD+jUC0g+FzaxvU8o4ygPdHe5e51a3BL0oy33j2fwD?=
 =?us-ascii?Q?zVaJXAWL5DBGOV3h5IarJ20wR+RDaYOMr1WPjn+WG0fdZhvUV9Bwzo4PGoUy?=
 =?us-ascii?Q?ASVMPu+voHOaPj61GMyNpMFdDdpH7vkClhv4GayXAgS72Hr4Wrpik/+DewDO?=
 =?us-ascii?Q?AmRJy0xmeapesfyPVqe+aaiCNbnzGCpW+cqaQPhPCcVq3b+2O6LR4M6yzPaw?=
 =?us-ascii?Q?0Kc9azEGjegbygs3W18qRgV+MlqX2oPTzQ+TgWRO30rgp9VnCO2qdRlufdc6?=
 =?us-ascii?Q?D99vy4fnfKUDtzRyoCX//EMnEiBZR2GFDTrkwLlJtX3aCOnbsVdS9jThFZid?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75978ace-51bb-47fd-bcbf-08dbfaefc3bb
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:53:09.2169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vkNIVXL1F5+hEQzC6qonY4ylDgahWjj7qG0r+DHNID5xQDIdUNbs9OzcvdKihu0wUFWYFE2q5Cvw3RW+pnQ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5940
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

Add test to test the bitmap format specifier

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 test/cmd/setexpr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index 312593e1e3..4e1c9e983b 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -465,6 +465,15 @@ static int setexpr_test_fmt(struct unit_test_state *uts)
 	ut_asserteq(1, run_command("setexpr fred fmt hello% bf", 0));
 	/* Error exceeding maximum string length */
 	ut_asserteq(1, run_command("setexpr fred fmt \"%0128d\" 456", 0));
+	/* Test bitmask long string*/
+	ut_assertok(run_command("setexpr fred fmt isolcpu=%32pbl 0x1F1", 0));
+	ut_asserteq_str("isolcpu=0,4-8", env_get("fred"));
+	/* Test bitmask long string (more complicated) */
+	ut_assertok(run_command("setexpr fred fmt nohz_full=%32pbl 0x55555555", 0));
+	ut_asserteq_str("nohz_full=0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30", env_get("fred"));
+	/* Test bitmask short string*/
+	ut_assertok(run_command("setexpr fred fmt %32pb 0x55555555", 0));
+	ut_asserteq_str("55555555", env_get("fred"));
 
 	unmap_sysmem(buf);
 
-- 
2.30.2

