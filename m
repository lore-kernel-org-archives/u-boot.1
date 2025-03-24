Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F36C3600B
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 15:11:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC82781E8C;
	Mon, 24 Mar 2025 16:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="TEdln5yI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 494FB81F28; Mon, 24 Mar 2025 09:41:13 +0100 (CET)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E9BF801CF
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 09:41:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yB8thRCeSnD+FcgtO/QTu8X1AO8So9+fhces/gYoulKR+3uamksLXnxjFdH4RV8VLMXxYFlcZZ1dNwkfrZZbqss/iNoRu27tiogH0iX5CoBfTr7hqe3P/e1WHKGpbDq1Qsxa6ajo1mIDS6LldYjiN2oZcqnid2j/yzIyCj6PcoxoW3oA5NA4hSEhqBGWMOoxHf29n2Qgq5xNQ3KgeYhwZ3pq8D/g64N5ZPnHkRqQsXdv+q+rZfTUH58yLk4Yx7AZW6Pdsk1GLYFIfDV1/0gb4NM/0x9wXYoknhnvpcJufOOtLQUQ23nTYPzwLLkKs2KGAmkEA8mWsdWJOCT2ezyMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a73NyAe9NrPJnHlqdqg9vp17fVDqky4fruwqhru+k+Y=;
 b=gzbET+doGAbY4y8GQaZPWp5zh04grnWsxnnVPaKQAfgZwVwXmit/DQP376/lWgQ0Gd4Q9o9f2XI9mra+QmlY4Vad5HZUVH6CAePfVj3VOYtsHaO0MFJQBkn8cFd1HMmN3eTLT+JASlNytklq8dM3QesxcBcFXgxVWA6MhiLaA+Yc98mwtZ5bUjNHxs96s5+rT1QTRCM71ejfICa0ijVyXjzIaw7ku31fwzZ4yIWZIMahJSeIeikhGXjlP996fHaOfSHZHIcvpSFvDfD28S/etTpULgG36oxCcHX7XSoJ8p1xYJPYl4SNEscxs13KUenPXl3S+3lli+txuNk4MsSelw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a73NyAe9NrPJnHlqdqg9vp17fVDqky4fruwqhru+k+Y=;
 b=TEdln5yINfsM6B+0uIiBmAg0NWbKdx+9/6NRMJ6AZwglyAqtEFueoUV2lZRQi7myoAxPHCwpLY95kwMWWurNnNXQqn+85AcZR8MZ2115xTYNosp8mTpv2eLy44sUfS1x8swDC67mVs4W0pWBE1tzVPikcEAJ8gZPf7+FimHk635SbA8JnkMjiN5jDxw/T323sno62FsdEaWbcPTeOGw1ed++TezDWGUs8TI45Ng96qunQUIy8LgfnHYLyUtmdiNu3CTgIUoXJBGlVxJS7o5NWuEp8IIvHpWh51veZDVpQKfrpKEly5QnMEq8FGhwpk534Dh0lRqXNGnlueB60Bjrhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by MW5PR03MB6958.namprd03.prod.outlook.com (2603:10b6:303:1a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:41:07 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:41:07 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v3 11/12] configs: sandbox_defconfig: Enable configs for
 sandbox i3c
Date: Mon, 24 Mar 2025 16:37:03 +0800
Message-Id: <20250324083704.26259-12-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250324083704.26259-1-dinesh.maniyam@altera.com>
References: <20250324083704.26259-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::47) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|MW5PR03MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: d6784625-36fc-4afd-f2aa-08dd6aaf9ec8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mKHZgwa97MJRox53McVYK+lkstXYqNDxAivOJuX/X+UrzTIaNb+quzfy1C6Z?=
 =?us-ascii?Q?zUQ+0Vvr8+fpILYsFQCYR1Zq8xv8IFRVdkQA7psOf6/EARvr6PblblX1zbqM?=
 =?us-ascii?Q?OxNvQKpkKPns4bSzxaM8PY2VrznqPr3syDKAcV0PYj1J7OKvX20ls1ta76Sd?=
 =?us-ascii?Q?425tNdrolSodqiebVjxjXwbmo/2SasnRRdustLBPEVmNV3AuQGnUGR1pU4Up?=
 =?us-ascii?Q?uWBQoOig8emZu4Oj5JspHboij19fxvv42Y7zjjEdcKbyENQzYtx/N/BJ/8iH?=
 =?us-ascii?Q?QnI0NEwjXontC1gXQvApgAGF6ZV2rlacMVjhPVT4TEJpDAKLAKuA5cfpndDJ?=
 =?us-ascii?Q?eIe1jIBNQhx/PZfcgPsyPP8BlhEyPPxfMAnJtxLm3U5RtTzNUxzjK02IZ2Kw?=
 =?us-ascii?Q?85OI+unFCfEINZZ5RcIlFBQz5uYCT+TRg5YmYaMBXQ1HMDW3VrQNIYqcZlVc?=
 =?us-ascii?Q?2A8IONoog8tbfCsswLhM8DCWsAwW8e+oD0iPJDM0u5Lh8VdgfuSj2oMrjOnF?=
 =?us-ascii?Q?Xj2xH1qu7qcVlGpVj+SKa2huxxAhlVMyRqtSvXbPkLqCp9fXzKkbM9WUg5fC?=
 =?us-ascii?Q?HpDZt64xUBlZw4gwvqVmWUBw2l0uLStiL8SJn2NSYSea6gKTSw0yzfzmlmmo?=
 =?us-ascii?Q?5pmuN/IdBxGMHMXBZAOmFNdUgo+85js4Rt2GrBK3gYDd7ZWClGA63rKGJrEf?=
 =?us-ascii?Q?dY7JV6I7kXmYd0qp2Ybw+VOYzFQPkz+ru0fvA0HvgzO+kuBBvbC+6gGf1qq+?=
 =?us-ascii?Q?EcwMg8y8xcr4V/kiQkVw0o6/dE5ZjcRprqYzcK7zdRCXXw37JeW1HKATR/EX?=
 =?us-ascii?Q?kaDbRKchycbzGXrK3i2exBbk0V7yeLTwIX2jcHwJfRVQDP3ZX/kxDKAX/Bk5?=
 =?us-ascii?Q?TWKwfnsJUwZ2kZHsdX75/FyhpT5qWFifm68w3yUawjjGtVMPNvxAo5nLCdhC?=
 =?us-ascii?Q?a9BcjwHjgHLJP/KOWjM2AiCeZY9zb91VNvEm/sKr1UAHEGd25Arg95nTU6R6?=
 =?us-ascii?Q?d77EOlRIcMi+wzCCxKx+WckBQpnpoFKz/QSxLSJh+LfqL+ReZcM7lPfq4h1h?=
 =?us-ascii?Q?X4YNXAIwvrjEpIopZou5SbcgJ8jiBAQwSDznMivc/p91GHOzJbEnLEjndMkT?=
 =?us-ascii?Q?SsyKh10rTSBShE9NQGJUx/9DUzC/cWnFxl6MexA0t0nXH6eQux2f8RIoZkxI?=
 =?us-ascii?Q?0eLfISc8JPnA2J/+3HzTDasoUDTPZLcoF2Ga4azhRhAe9jKUPT2OmGGyHeHE?=
 =?us-ascii?Q?1QhBIvQ1o2k4t4jkHQOBNapTZsXD33iWJqoO6TMvxPATcO7FOONdzs2wJLqX?=
 =?us-ascii?Q?cvUQTCNkgvltaAph5vOCX/nf47n7KKPcYv6MosQ1wz4pgizwgunSugmsCZ0M?=
 =?us-ascii?Q?OcrhzPnaq/p1SgQOtTgpcs8wvjER?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zX/vKWzfVv81OS/ZRlFptfixcnm20nqhGLJ3vGJ2jx98B61ecVn8B4futH6p?=
 =?us-ascii?Q?HMDKQsO8QOggQacchb6r4lQmoqCjbYG8T6XWR667BQ/2EqFwBwndkhhlfIog?=
 =?us-ascii?Q?2MkVIXyJiTNR9qdllRmiD21MBw7EaOcVN0yMXuK0ro4xc3qKoTDrvDj5og+4?=
 =?us-ascii?Q?djf+VjjdUGrw1nDZSHnWAeYrY8gZBOcDuOi9qHUwErFwVU9MkgKjTOTg4+Di?=
 =?us-ascii?Q?qG3O/wUCgDjxIgQYqEijmQDOTRbyTzm83vFQrsqf8WwA753FF0NsDcP8+hxQ?=
 =?us-ascii?Q?t17W3YJXO7vp76o0j8GFGtVRkcntdjlRkVQOtMT7+vWIy6MJC5oteKkQ3w0x?=
 =?us-ascii?Q?E/jIFiU96saZarQBAAEQgJ9x6v+8utPcE7PskTMAJrNO4m4QZA18aaKbRSBd?=
 =?us-ascii?Q?H68Jft+zenfC/h/Id1EzqgBm2wJ4P52QqE7paV8UdE8yJEXRGja39OLkTDlc?=
 =?us-ascii?Q?OdHA8JztCFBeliUipHAPw1DTHs+Kcrwo6wOQ2oYKBHtmoZQFwSu+VrCuAIKJ?=
 =?us-ascii?Q?r5xoOGm5NOv/e73NSDO29GjmCZPAe++ugXwtmXf3FsJd1o2RYExyp1bUG1OV?=
 =?us-ascii?Q?MLWoNk7Rx3yIiCIubs+i5rT+GJZ0VxwIy+d7UPOb9q1/smLXnw30k3oqgJhC?=
 =?us-ascii?Q?GSkFjdiUrPz4TRJKAXWQzY2vV5KAPOQhBOx6nCkYVgewR7z5MfLQqdHZaeBQ?=
 =?us-ascii?Q?V9p3co80xCMOsqdV3z/TaCC6o9GVFXzj+2tE948+Swe95JJZbyNbRPf4UqBK?=
 =?us-ascii?Q?Ctkif3XmmJ3b48clQma5Qf5zr8RjZqbeZdonDT8NT6nffNHIRiWCPyXEMfZ5?=
 =?us-ascii?Q?J7XuhrZgbR9X6sWudCDJymJqmtHG1XO1JNUnafJ0nUb31ItvlcxHQf3khHEg?=
 =?us-ascii?Q?OCkudTcebY5T4g/26uDyF/CGkEt3bczDPTa0hVLsPW6idSE38PIY7mNmw96u?=
 =?us-ascii?Q?irzNc8nzaZTKtjih5pFLNoME/9H3gPg4BGoqev88sx818BJIJHJkvUUaQo+W?=
 =?us-ascii?Q?e8VvJi4Nts4x3xRfIjAx5O7fyc9xggTDcE6fEWHEe57xrdgihCSkS6FRItcb?=
 =?us-ascii?Q?AmsFpIO7iyC+4qtnP3P90GE6AzzDJZNRotpWiuE3yXYUiMov4R8fsTkKFsva?=
 =?us-ascii?Q?0s9atUicGw/KDcXl+0Vq9g37VOZvp/PxrkdR5kx9pGJ81+oGQL85Zd2DZKu4?=
 =?us-ascii?Q?e1BVrha8/cRf2/llMBq5x0L94m3lroAMMhoJ13kGtAWdQ/gH2Xf+YZu/F+df?=
 =?us-ascii?Q?81EKGLQKcG04TRbglhZ5ldUUbDAXXAQ5JmOv4U+kovWu8dGCiKjuSQOXDELs?=
 =?us-ascii?Q?JIUeJLn2088WJY5PwX8WtP0NtBVUN0j5hGzReFANzi8ROc2+L2SKV4Vzw63v?=
 =?us-ascii?Q?FtYUAWIZjB8ewU/tJQ1Iyj7BxmJaL9TIBA56icKJi5eEV66Zt8qUkN2a9RGa?=
 =?us-ascii?Q?0y5mpQoK+rK8t7Voadf52QT11/rqDBR7dleR2HaOQHKn5pCzP28mKRviun9P?=
 =?us-ascii?Q?PGsKEedg0YzaFnSS4HhqXkXlNZzmCxa5kY4aKRlHgL8kDZpBy3MDBXewCVgh?=
 =?us-ascii?Q?AtZ7YmfT/nUzItikfF3XtTiUX0lgh5LWnTdRlIoZ/GZoff/A2+KBi7b5xmXB?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6784625-36fc-4afd-f2aa-08dd6aaf9ec8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:41:07.5003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLZSUGXmbIxLhrgmXRBYbedL1itzLEIS565FNi/v6rp4w1QpE/d+yAWwi1sW64w8O/8iMUssUwGaORBgFtFLAUDb9JYcYfQm4LqrCFwxlfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6958
X-Mailman-Approved-At: Mon, 24 Mar 2025 16:09:48 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Enable configs for sandbox i3c.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 configs/sandbox_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 861a1f4cd90..ba98cb0ae99 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -85,6 +85,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_GPT_RENAME=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_I3C=y
 CONFIG_CMD_LOADM=y
 CONFIG_CMD_LSBLK=y
 CONFIG_CMD_MTD=y
@@ -206,6 +207,9 @@ CONFIG_I2C_CROS_EC_LDO=y
 CONFIG_DM_I2C_GPIO=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_ARB_GPIO_CHALLENGE=y
+CONFIG_I3C=y
+CONFIG_I3C_SANDBOX=y
+CONFIG_DW_I3C_MASTER=y
 CONFIG_CROS_EC_KEYB=y
 CONFIG_I8042_KEYB=y
 CONFIG_IOMMU=y
-- 
2.26.2

