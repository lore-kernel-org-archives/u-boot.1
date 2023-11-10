Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2B5C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 09:43:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C76D87800;
	Fri, 10 Nov 2023 10:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="0ev7yMqg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF44F877FA; Fri, 10 Nov 2023 10:42:33 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D814387785
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 10:42:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyqD/Wf5JDYgHDcKEie9PFJ8d+kudmBb//uvlUrJlNjY0PPNw0lCicGvaCC45DqGqYi3l9XH3qFxuhJXhvod+rU0iXhHh4MdZRk9koMTvOLVsLpnuqEbHVQhihkEarsQLkdCKi6oey8EFPMPKkNqKAmPMj2769Kune2h8gJqGyc0NqwAklwFNAwgHF/LSff8BOEDry0bWesuWwqwvmAMHBRBOThbCuf/dgiQm+syRwHNE1jba65Fu46FuPvd9r15N63YtQSN9LakfzLGnZnMPBz2xSfkzj+8dwVI7sxoUtdP2XYt0TWmD8o0+zTnq0nejEfyZ3gPgmmNkcCreqHrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uru0ZieKDxaBTJIiOSFeduU52Rwx6MZ+xOX9tYN/pYI=;
 b=G4ISQAB+nRJa9ksCvX28Sb4tcjRRIPI13kJvenZGRGAOVsVCWujtNi+UhTaUGf3XVxgVCkv+eKcjd+9NL0NXkqU2vFgQa5zBiSpvjLO10CsJ64NWzZmtJdTKPw6AqxvhuBTLBJU0uXCrKskVFU0ktBUVXIdU9MrMtZaUsIGvzsqeOccS6kfZqHMEApmnrp+Pt9SrOf4KzBVVYrOY3ag//lmJyECI/yQ780qqGPZ7JgMTMwkVAI95J3pmq6FwDAA1s4/HVmxF16r2/t6WWgrKrGO6psHnOT7NElsCplbPDAYkwqCK/hfhgkpNM2t8Y9HNgyUqs4fC23Ymytm2dszoUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uru0ZieKDxaBTJIiOSFeduU52Rwx6MZ+xOX9tYN/pYI=;
 b=0ev7yMqg6txQQiI5IpKJ6YtEgYHBVi3OEKUUcd9lJf2xtpDRTAxX7xF/tfaGrS+SRQGqG8M8WbLXIJPNnjZUvzJtjYaWBbSXfuwhVvRn1jaxIPTf+F2PClvvd2wsiL+6v5KRx818SuNwAFWcQUWMQtV6XMkcnz+ulIriZzt+zvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from VE1PR08MB4959.eurprd08.prod.outlook.com (2603:10a6:803:110::20)
 by AS8PR08MB7910.eurprd08.prod.outlook.com (2603:10a6:20b:50b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 09:42:30 +0000
Received: from VE1PR08MB4959.eurprd08.prod.outlook.com
 ([fe80::b592:2cb1:64f4:bcb0]) by VE1PR08MB4959.eurprd08.prod.outlook.com
 ([fe80::b592:2cb1:64f4:bcb0%6]) with mapi id 15.20.6933.029; Fri, 10 Nov 2023
 09:42:30 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 4/5] fs: fat: simplify gotos from read_bootsectandvi
Date: Fri, 10 Nov 2023 10:42:14 +0100
Message-Id: <20231110094216.50696-5-christian.taedcke-oss@weidmueller.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110094216.50696-1-christian.taedcke-oss@weidmueller.com>
References: <20231110094216.50696-1-christian.taedcke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::8) To VE1PR08MB4959.eurprd08.prod.outlook.com
 (2603:10a6:803:110::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4959:EE_|AS8PR08MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: ab31e573-8b5a-4aa0-72fa-08dbe1d15b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWUn4jXvyE1enZQvMcieKI3Rb4iGYCBZfXR53zHasQ3gfr8SLIXmf5S7LlF8OZqNxHGRV2CclGCstPIJx0/kodyCbGk1tljSEZhxZeC/8L1BmW2LQNvMUsXx5dEQoJNmxPUdV9ZMXofnUq8YLKBTB7vhMjSpSF3JWN3vUI5zknX1jtkq05T7HfIEnr+Jk6/feuIYlEqev7vQNUM1+TiJsYW65J8Y0+vk+0GXGbQ2ok5yP+JHXxiMzrs5sVy1xhiEtWzTMV0IJIloUKUVgAsYoP53L35LfwD25R7YKG5GngySbLiRSkGQY4SfUkClfDxQWr8bQs/Rgnc/BtbRjplw2TgMgqeSwVlyr4hZm2cYBQOlG+VbKqTEcmwhC377sN7n2v+sYxp7AgegjNK1loQG7ftdZ4FyrSk94kyhpHDQKZvSbKpJ38vXAqPYcCzDdKj0A1Fqv23MFF2MFInIL6r5oCjT/WZW5gk3u3sKAGJm6pOYoeENnOLxWpLd91jW4M40d4phLv4o/3vclohEj3wJ+b1anEf7Nhwn/pNc34CrACDLcCA0byBFa2vtIhJyHA9vdFdrop9+BcAPlimtYg7ztjMrXkT3XSqUTQUk7Fn2OCpcL+0MVsV/9B9ajwrQJHHS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR08MB4959.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(26005)(2616005)(9686003)(1076003)(6486002)(478600001)(36756003)(54906003)(66556008)(66946007)(6916009)(316002)(66476007)(6506007)(38350700005)(6666004)(52116002)(8676002)(2906002)(38100700002)(4326008)(8936002)(83380400001)(41300700001)(86362001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7xkSC4wsqgPWImgOqwxX8ERKgnLHQLMB4WVwolzcpNSmaXbn69F3J7ObqSnh?=
 =?us-ascii?Q?eP3fr1xEIls13YHasSfkTqqkvuHIU01eVYKwq+qn4+h5QImIXD8SYzjea0zK?=
 =?us-ascii?Q?7Pghb3B0hItpafHV2q5d0vsdEzOukBK+z+5bC7wZKy6UQ3MaU8akUJQECfBw?=
 =?us-ascii?Q?kFD6QiLcwh5MxCjfR3/AjhggYSXUlRfcDKiz29jvK80faAwrrGjgB/6O3gGP?=
 =?us-ascii?Q?navSgbX24l6dXmneVhIaZZB6CsAyK5SShgZu9yyLQF0PxCkvjqL0/17s63o7?=
 =?us-ascii?Q?WMZ3oiIWO+yfzwdGB5GO+NrlXGw4M97WrNwK0d6mzR0hHSYa6c0tYgnpffpg?=
 =?us-ascii?Q?RilM3PtuCS6w0bm4F++YQIqqwsifBGN+4GAixafQoHmdUJej9D9QNzPtvLf6?=
 =?us-ascii?Q?X0W/yMaX3CDbZue64pVVsquV04oavT3X/A6FM/AlEk+likqBy/LUys3t5sTi?=
 =?us-ascii?Q?4sj7bOe9LN1Splee4WtOn0Ts+zhT+hCXNbBtslLN+5qxnMM9lsOXvqO9YcHf?=
 =?us-ascii?Q?5Vk/Qwwx1I0P19A34DB+9iNTKHtZ9f/2UFJtccA/j/gz+xyfeC35WufdWeip?=
 =?us-ascii?Q?oYYAuZy4wvOe+uymX+27OtkJoeFxmXlWoD/byh48N9zGHJCvSTU1EjTgr0h7?=
 =?us-ascii?Q?91UjUA3f7f+7hmm0Bl64/A4O629TLUT2g0Mb46vdvbdRcn7XeESlpcIIaPeU?=
 =?us-ascii?Q?F5hKknzB2Nyi9dcwEUHHIV3GUSBiCz6Ni32xzaaC8Q87eTMMb277d0psGM5/?=
 =?us-ascii?Q?5HmR1439k9bClRG31Nwy0u42yyuHLwC03MjH02HkSHrDnvjXZ0wQjLuxvAOs?=
 =?us-ascii?Q?Q7+oTRo0PLh22TPHj1HRUOVupNcTfEIhkINyrIZ5DHm1zgbFO0+sESxkzU9Q?=
 =?us-ascii?Q?Rxtm55ncMp6RFPlJk+FimwLJZ9Feop1orsUGRDWqv9vpgVxPSeZvmhDU/sKX?=
 =?us-ascii?Q?40QPbxZz7bw41cx33ZWGiWAKbpp1fbv4oAbiEThX1ivc+cIIP9OIhWEJ0XUf?=
 =?us-ascii?Q?TJqGrIed7Do3zuxKdGsPO23cF8GFYACeLw1YqZRy5oae9k00R1d/TCkZVYQo?=
 =?us-ascii?Q?o6nsXpaCepbmY4LrIk3kdcPrZStc7ha80mh1ER9/pI8K8S+z5Scl7mgDnpXf?=
 =?us-ascii?Q?C81QJUT7N1hfZFd33+wfll0V5eshbCRKPKR58MhibQMmuJv332GKq+UDMTj+?=
 =?us-ascii?Q?uh0sm3/9WuRH6Bxw+GZIcksiAHJPTZnoG/IyO3XPpQKZzMOeA0dchjPlOxrO?=
 =?us-ascii?Q?w8FuFJa8yEPhETLGbTSTGG2Ydm2lGflpd9cAyYptJkvtDkqfF/dgcRm/Snwh?=
 =?us-ascii?Q?L88PBQQoMYuHLXhOMHTHNdwFaiibpORs4AWJ1nvc8BN7sYgGs3fFd3m91U4s?=
 =?us-ascii?Q?F5i53ANB8FpzYIXv/anjU78P2n2rT2FhywRxV8WYdSeIu3hEd9nnmh4v4Vbz?=
 =?us-ascii?Q?oPw+4PLvk4U05oSJUDNttd2DujEih+jZM4Gm1V5MDMIorDXy+Z4HkNUP+Jdu?=
 =?us-ascii?Q?XO1HoEKlXhhZD0IekIi9pKq3lsi8dxAT8wGwF4BunwUcoJzGx+WJt1UGjIGN?=
 =?us-ascii?Q?y7hYc1PeQYmQ+wz7SPO/lQeLcRcy6RSCU5O//9Q+VFCMxdqnWFD+X7Bh6dm1?=
 =?us-ascii?Q?eU814EOoizfQwSz7VADUwzP+tPn89jemS6dzbqQhUGNy?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab31e573-8b5a-4aa0-72fa-08dbe1d15b67
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4959.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 09:42:30.3670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDgBWPkz59wNKcYMZ9lD8JMTRWXZAHGNRsHWmTSE3TsTQOkVJQwB+hikjtUTUJcwFuRGQoRKU3wympxG+3KN/uVmxJRi2HdV14t9s+YX1WDKvFkU5CWIErVhp6r/KZt9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7910
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

From: Christian Taedcke <christian.taedcke@weidmueller.com>

This simplifies the code a little bit.

Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
---

Changes in v2:
- Keep one goto label instead of removing both
- Move changing gotos from read_bootsectandvi() into separate commit

 fs/fat/fat.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index c368c3b076..77f225ccd8 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -531,7 +531,8 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
 
 	if (disk_read(0, 1, block) < 0) {
 		debug("Error: reading block\n");
-		goto fail;
+		ret = -1;
+		goto out_free;
 	}
 
 	memcpy(bs, block, sizeof(boot_sector));
@@ -556,10 +557,8 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
 		*fatsize = determine_legacy_fat_bits(bs);
 	}
 	memcpy(volinfo, vistart, sizeof(volume_info));
-	goto exit;
-fail:
-	ret = -1;
-exit:
+
+out_free:
 	free(block);
 	return ret;
 }
-- 
2.34.1

