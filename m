Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A7CCAC5A7
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 07:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82C15834D4;
	Wed, 24 Sep 2025 09:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="A0pRBQ6n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE10800D7; Wed, 24 Sep 2025 09:50:18 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53B2F833ED
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 09:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAQpM2JU66CBunWr9FLRkKx4v1xIftlcBrwP6p20WDJBq6f9DR7IpLCvqvop+x52GYHmMvoPjpfGLabwl7BPTHiimsVpWzDMD5yta2DIsYmo0UX9YPJK/Ao/33yt+D75SD8IFF95HFOldgW4O6HyJnCu0f3yOl14W8Hf9oGpAVMiFAnIsfJFRX5tlA+1ofwIFp3EmtjR8e0iU1aTA401S+wuAII4+PNpHQcL7eH6UGRpErg3WdC+ULskiN3vpX1hRnEGNL/g+Paoq6660MXxbJ+fb7FC+tA8N+ThRU1fmhuxJNxmS+yp/VrPYIwcDkFrSdgYdoGMCe+pXydMXAz+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfJSrP9nII+6Wx440j4UUG+37ijVTlJJTF4ejuQsQKU=;
 b=xi5DgJ2/yzaspjjRmBqKUPENf8QVbWVn5GT7LJ8vs7Znvgitg2SJgvS34uUXcca71MBevKRwYnqcHen3WfroKh9OvC0v7vg1JHqzQk/3X3S9gKyinxzTnwrB9W3XZaOJkCnizfiuqm7Rqbd84e/drbrap2KRx1G0m2+qOe0Qr71GeK3EgJ4Ge6L5wg3wyJsC7+kx6xrWdyRwYe1B/qqJn3KsnHC63luyFhyFICePkDvD8UBHnJWmkPxG24l2XrCP5TZGOBRx9EzPzz/5FokE0YwYEXh6hTxq6K4jKfhKnfNTES2O2uZX483yIMMXdbxxHQp4ZuKI9peFJ7GHzn4QnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfJSrP9nII+6Wx440j4UUG+37ijVTlJJTF4ejuQsQKU=;
 b=A0pRBQ6nyK7NmM3Non8Q1PRtOcOuvZKGi8gpK9Y7nAXaK5vL3lb8TOzXGsyZLModeEJIQa7b+p4pW4WqmCBQ0eyWe0AJLCa3SA8okLmBTY6jQaNPkv0eBluiS71FTLMvd8yC6m95fWnYzq2QuzQzU+JwgYj3AKzRhM/mSr7EWyLt6jmfsX1tAFg9bAalsb8cPltoqTONbbJiiyuTdoIX5vbvzGkhzAeI9jNdEJbEgVnkBf1fNwHqzYp7xYr7JC/IJpiC5LXn1kRE5tewEi2IPmTdJSTGhoL0WiidIO+PcgsBCJ9u1X2EdsHbeVtnTh8RH6Hkta2HE1MVB8f8iUcW1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by PH0PR03MB5847.namprd03.prod.outlook.com (2603:10b6:510:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 24 Sep
 2025 07:50:06 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13%5]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 07:50:06 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v4 1/4] arch: arm: dts: Enable USB3.1 for Agilex5
Date: Wed, 24 Sep 2025 00:49:08 -0700
Message-Id: <20250924074911.15538-2-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250924074911.15538-1-nareshkumar.ravulapalli@altera.com>
References: <20250924074911.15538-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::27) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|PH0PR03MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 85060242-3689-44dc-8833-08ddfb3ef87d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fyPzTcBp+qAXpHZVnDvE/oMMAmsEYBw6oO8FXOtUFlhRNMjvREpvt2O0SiiE?=
 =?us-ascii?Q?7MwLV2rbaTtonalbIuIk08+YRcVzK6HzMUeotv7+NXAFdAM8AZdPSLC3tJnS?=
 =?us-ascii?Q?n9vcRiHHJQZPxm+JQbDpknuvvzJqyroO/r/+B9s+pWuoNF58WRjGqtIMkAUQ?=
 =?us-ascii?Q?pYolBhMyfgiRTadW8ezwZnuI3n27iRvcAzm+A2uN08pNSXLAAQ2oatgyxSyV?=
 =?us-ascii?Q?OHt+45aSaYqJnhz91ZVIz+Zlz0O8+dFlHGls6/dMEJFSpuVgJkjG1maFV7VO?=
 =?us-ascii?Q?NZRl39RWf80B6crmcCw4LbLO5Mu3i6/rv80M8uI5RT7ajmGDs1O5bDRB8MIE?=
 =?us-ascii?Q?1aXT8aJPWAUjY9uvDXf0ofhw/ra9s6ZzdSL2xqbwAmA9mpT/nHHAI5WCilKz?=
 =?us-ascii?Q?qXC1HTx8RvSz76YhLKNDyF6WrRE8Ks0JBleo6y97UyptGHATmUgTqgsyZvUn?=
 =?us-ascii?Q?Norwiklwkdu7jshfjfoXPid4P47CvCK7+6gyk9GBSlyUgN4X6bdiLy2KKc98?=
 =?us-ascii?Q?gdqTF8/Rm6bf1Udm3cVh1MMrS0GPeWndfcjTpOgy5fIrI47asjdrddPfZx2J?=
 =?us-ascii?Q?PZGgENzXpRwr8Iugq3rbv3YHLtqwdXOcg4MX33b+dbLZ/k4bKWPPuCJsT7Xh?=
 =?us-ascii?Q?Ow0SLEB29EGXHCQmxFR8AzefdxgpX34to6uIZY7bQEAGlsMLOjHRp6FyCheU?=
 =?us-ascii?Q?sqHkJYSbInpkcVwpg9ohhHFgtuGPPHt/NsSEXwkpFg+ma5KHpVx5NNatFdTd?=
 =?us-ascii?Q?9N6zQx4huxRR0oF6vE3YvVl5eCapMv+rmbv5B6oJUyXy1oYVgRxjLXDeH5ok?=
 =?us-ascii?Q?DADaX8SXMBKhY4TozRuTwZRMDimuL/g+YEaGmYOdIRki69yoCdUL4ro6mZpJ?=
 =?us-ascii?Q?wk/ZpMFnh8nuGIOkxxHKqE7wgl+FEnn50sF/RiI+f2tWlyiPShz9jI8QbN5L?=
 =?us-ascii?Q?nFBejpfJ6D+N9SODGjXOeQWkVxDysjGv2ynWXVV2PNjFWx1H0V4kp+KyxqrT?=
 =?us-ascii?Q?x4GqThJR9h3eJT3ScDVU0GACZL2ywzcIHcnHgCHq8yMvljBA35UeY0ew+X+d?=
 =?us-ascii?Q?urdtPLenYbsPa5hb+n04aFzFk9geuhENby7JkWE+9O9eOGr4q9WTfeUIbL+A?=
 =?us-ascii?Q?ty/+U9gvkbAp+yoJpwZYn6PxFeUWyuf1oq4MaId84HhbTRqy2bd1inDYj/b0?=
 =?us-ascii?Q?jfAaNmDxzdO3yAX/mhKwyUjg+rdB2So6zY9JI8VQq0cavMK63Tg9jska1VrA?=
 =?us-ascii?Q?fuOgXHhjRCAaU46iQNWng42lfNv5MKdV55CjffucyeinDnOo+i7QZj0jk0MU?=
 =?us-ascii?Q?xHlcf1SU5CPPc/ICXiQ4Nw1J7M+j537a8OX6A5d60Bi5cVZNeNZqgIHGzB23?=
 =?us-ascii?Q?evWvJZWrsdKgfQWQC02of5TnwZAUwBHVrswcZkZdt7SkOyYDZ1Bwkxhek5cX?=
 =?us-ascii?Q?cJ4cTt/hTJg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ODN6QGdIbNHEZrjNrssHa3p85iXLQNlelQiRoO/rA077ScNHJ1iBms6LgRT?=
 =?us-ascii?Q?DiBdGmddL+AtemG9z48DJwB6gUL1nu2vpkmRWP6CL+z2M5nbct20WKVnjG6m?=
 =?us-ascii?Q?Q5S8075pcyZ7uioREz8ESaY5pPdNUA7pkaED1VT8j4stEm+RvrJL3cOC08eE?=
 =?us-ascii?Q?9UrGSMEvg/ejJuVnXM2QMMHr/RJ/WL7VChqX98BQrnJgcsTikZTr/0d5Ke9O?=
 =?us-ascii?Q?7xFKhQsxMpsTCV5YPV4wwPB7n+5UlI6lqK25YO8/Ou0EuO47yv+m496zxG0R?=
 =?us-ascii?Q?rThUvRT2FN2pjwDu6mhIrH7sMFZwzjx2kmcq2oTMtz0WcZVf7sBIBEA9+pRI?=
 =?us-ascii?Q?PMyHre7vTh70xgXkIRQo2TE9ZiJhT+7rX2f6Rl5WnludN9Ob8H+kpN9tgq0E?=
 =?us-ascii?Q?IVnLhw+DvNH0Bqor9GIvmTf9Ij92GH+WU9mcZQG9/Fqv3wHgQKEWQCsxIpiV?=
 =?us-ascii?Q?zjg1mVKE0LWVjQ1ZIyRSz/r6rXVzgzmxKbQ17ULG51dR8lDf52Vkiyfk4B7T?=
 =?us-ascii?Q?bpv98GdvzEcJQDn+1Yg8ARXpTP4hbxZzqmt7COVNhytaVmdllDqXjsloyVH9?=
 =?us-ascii?Q?HyZUFE7AaWNTRgMsDeBHJltSNBn7kirrt9PPNXAjiS292SJfgiJCaZU6vEHP?=
 =?us-ascii?Q?/z+8CdAZy6mxS/zoJvBBMcU76AV9CNtZFXNHwwna7zFVXrK1+3egJliYewx6?=
 =?us-ascii?Q?hjcTkZ6fFCKVW+HD3T9jpoBH/jfQ31dHZ3JVS7+/UQYUhvsrwKI86teXjPRB?=
 =?us-ascii?Q?VpkPxlrqk5BAF4OEk79s0CwEVqyW0XFdixV2ftVF/pmUpOAXXlix7TlXbESP?=
 =?us-ascii?Q?KkLetS13daIsZTbr7oex0978qvQ8ozq8ScjtM7q/faw2cZfmGYaCFiQzCktj?=
 =?us-ascii?Q?iZLjmOTDml8rXtFtArk79AszeBG/tqWvnoc66O+FobgbcPiiwcUjwbJ+BN41?=
 =?us-ascii?Q?QAUJnuHrCvBgdPQlkjI+aoaS1o+r1xuIzgaIXxmaWNTYZPyKEMQNGM9pM+JU?=
 =?us-ascii?Q?pHEP9UeJzkdL7R8jSs5uTh2dSAJQJ+0x5XwTI8y4wZ23v4NURdSTootImxeK?=
 =?us-ascii?Q?P07EV7FY/kYIdo9qDQ9BGwZGTfDaqbVxQ8FZkG+tD8tGKDM6gzdsxc+Lqjnq?=
 =?us-ascii?Q?0is5gBEnFzWlLdZEf+jC9V96FXw7lLTRGchZI0tuNowqr4BBIJmn1gYMe0CM?=
 =?us-ascii?Q?XyOiZMmbW+WZpDroqjxdfPw4dmjfk/NfKy8rqZN9oN+8rm0rnE810oAPoeTn?=
 =?us-ascii?Q?WVJT/mx7gziAplHSAay+C9OcrFFaKfI8kMU9QMON6MYX5TK+5wZvF19Y7daw?=
 =?us-ascii?Q?nmy7+AJYhhru11PR5lqBpLB2w3gSEQu8B1zRg/1jPW9CP3RTpqbAaOb7COWX?=
 =?us-ascii?Q?oCy+8W3AjRMRI3W0SJRMAm7s9aokhLLHyhq3HmVOpc8vfbhZqZKxqsrbzCx3?=
 =?us-ascii?Q?IhLuUv1rbqDnfJpqV+rPCRU3tYWIHiyYooH8CZz6fxThppo64qY/ZXjLY+MJ?=
 =?us-ascii?Q?8qmtQ8xfDc3Khr1Xc+vkErq+G5R2N1hbJ5ZGdqICZEj7ppEaWXivFEBmbTiI?=
 =?us-ascii?Q?YhtMVpHqJgHtJI2LTZdI7JuQpxjwIPWBZWC96dWrZM8DhrWCIOUuT9BW0yrP?=
 =?us-ascii?Q?a8qOPgTBYjdXtH9pdCw/slg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85060242-3689-44dc-8833-08ddfb3ef87d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 07:50:06.5843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2vqPO107KNGt8ILsRAf1yPg6GZ9wz5nM7Vwq3T7u/UOKaDM0KX6YfsQ4MT0GPiZR45YZeZn2xEZZbX1gNUXmSWh0ENgcfAh/QROs+cLKkUIGrtpMY0hQ+tq9fHSrDsf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5847
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

USB 3.1 node is enabled for Agilex5.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/dts/socfpga_agilex5_socdk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk.dts b/arch/arm/dts/socfpga_agilex5_socdk.dts
index 2ab143e38f8..886cc89fdb6 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk.dts
@@ -87,6 +87,10 @@
 	disable-over-current;
 };
 
+&usb31 {
+	status = "okay";
+};
+
 &watchdog0 {
 	status = "okay";
 };
-- 
2.35.3

