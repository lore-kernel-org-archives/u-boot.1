Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F44CD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 07:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6249D83EF9;
	Wed, 13 May 2026 09:40:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Gr9aX0R5";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Gr9aX0R5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5205583FB0; Wed, 13 May 2026 09:40:52 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0CAF836AC
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cjqr3fNwpRkJSAfcU9jF1aUmZ9GqdbTs4iyrzW78XF7pzC72+iAwYf9LBF4PkbtPPPueY1nHWJlTpkThGv+gkeu2mhNIrLr7Ao3P4aWm8DgbJgQQFTEb9TCBVx7W5vLwL/L9ARLoPSZjQfhXJjSmB58Iq1Bs0cLSFhsw7LJj6SSHdsv3UuDNbjw1JJEOZEXRHrxfHZrHypHWd3RWFUG7wlcmUg1QWYkEKXPmMiiLmMe8G5H2Py3+ziBCD+tSU60dPBxKEOuYI158/ieubTJGpG0LGtReBN4gXfBqKPDICUyXCEA5Qqw99ULppubHklIXa5IPG3vlm3QK6UHYB4KgQQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoCBGxUlnuhKZVY+/O19UvherVpyw6pXoMjnM25o/bs=;
 b=MPQ0CLlpHEMQA2NzUI8Ejgz0DNhqAy3bR3CyH3PtVF948qUlt/ZoewPK/lJ7rEJXgdKx4fAbE4cH3datpIHk+LsZjU9o1364ldIumE/9UBKUFwYwfx4Jzvdk4KLRFaINAGIOplNm7CjjbckwC3MwolmYmXDnmEvZrtrMe0px5M/cPJWG1waRfMI5UUvo7sS1oL83T/O1BdVPI6c1gr1Bj6SY3jeGXXT8gtjIqtwXrjKCV/NTAH1gDab9F/jXRRsy+eGOmqzqD26wZ3tuEQ7MNteNWG+/kB5xu9moj9/mcAL8shjcqFQSEWTcJbaBcLgmYnS9vkv5ms/6q4gcDwjHNA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=baylibre.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoCBGxUlnuhKZVY+/O19UvherVpyw6pXoMjnM25o/bs=;
 b=Gr9aX0R5Pih7IGID4q2z3mjv1aeL0mupIWJjK3naoDZd1NsF9Gn7cHbyTeu8SqTzaebObNmpLOq6tfKWH962X/JndJ/2q1pFhe72aYiOZTeTwGeLcogaPcF75Nz+Fe7Tt8eyrD6jhfJSsS7UWEsM/GU6O/nqgzKZ/blHHUDZ1W8=
Received: from DU2PR04CA0158.eurprd04.prod.outlook.com (2603:10a6:10:2b0::13)
 by AS8PR08MB7909.eurprd08.prod.outlook.com (2603:10a6:20b:52a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:40:45 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:2b0:cafe::2b) by DU2PR04CA0158.outlook.office365.com
 (2603:10a6:10:2b0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 07:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13 via
 Frontend Transport; Wed, 13 May 2026 07:40:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdbdo3aeg2lZ2MlgUSnjLJ0afxGeM2hcyfiXU9aA8/GqN4TUpeySrswlwh270Fe4zzysnBdShw2RbxxI90a//esIOazviz5FrQku0kH8jQhnIqu8jsWDzm30KOTV+mQWf1wFZDwTQsvHqPrVi5XgU6QbBDlHR4SMEKKY+3b0VgqCU9I2/NYK3DE9DaW6FjlhnHzKF6sZgzrnbwb4j9aLuzQmNsDJ9zpwAg3XmNrZzyp1ze3jf0c6lri80Dm0kBa3SlL0Kl1KbywJPqFAQHvGWgnBaOlfxGJQYrH8nh1BsiOSaTAybEYZuTN/9V9q/yhsUpFohPMRXglyUdcV+Wmwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoCBGxUlnuhKZVY+/O19UvherVpyw6pXoMjnM25o/bs=;
 b=yeoh5s/BwRHIgP4SsNuKuFUgXS1oMjwgKT78zPTV9Cy8ne9FvSJv2Q9PgLJ0jrNceIXfuKtSOlwtzZUfFXvHxLfj6Ibzeyi3qaPeSgyCmoV6wVl1kuh8VtIqflhloVLZBdj8Vwelnh6YeFS+I09nel3WyfAyTc4YTZJHKPPk78NKIieGZpm/f6y7qURpZ9YPYeOkhMF6easeSzuV3c09rpS52EBp7qPM9+nSpM/eo4BF4TI0S3vy2teKt4e0sxbAZ/cOfRDNGYt1ONTTNPxikcda4hG/wsRSGV3v6SO8pQQXcuXowq0oMrJNfvsngx6XHdK81sGWLzXDhAaanyUm4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoCBGxUlnuhKZVY+/O19UvherVpyw6pXoMjnM25o/bs=;
 b=Gr9aX0R5Pih7IGID4q2z3mjv1aeL0mupIWJjK3naoDZd1NsF9Gn7cHbyTeu8SqTzaebObNmpLOq6tfKWH962X/JndJ/2q1pFhe72aYiOZTeTwGeLcogaPcF75Nz+Fe7Tt8eyrD6jhfJSsS7UWEsM/GU6O/nqgzKZ/blHHUDZ1W8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by FRZPR08MB11217.eurprd08.prod.outlook.com
 (2603:10a6:d10:138::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:39:41 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 07:39:41 +0000
Message-ID: <f33656e8-0fec-4678-8332-0752a499e9fb@arm.com>
Date: Wed, 13 May 2026 09:39:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] net: lwip: wget: fix error handling in
 wget_do_request()
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
References: <20260512-net-lwip-add-stop-function-v2-0-85146da317dd@baylibre.com>
 <20260512-net-lwip-add-stop-function-v2-1-85146da317dd@baylibre.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260512-net-lwip-add-stop-function-v2-1-85146da317dd@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO0P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::11) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|FRZPR08MB11217:EE_|DU6PEPF0000A7DD:EE_|AS8PR08MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b54402f-6362-4b9a-e72f-08deb0c2f193
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info-Original: +tgyhZCYO38IYcDOttsZnvthd3y+K7LC/K01Daur71AU8DxNq3ty+tJJHoEPQuBE4AlVYVDZFBZqZhKsHS3JnZCVgXU03eo9Bd55piI3UWH2Ud/yzaDVfgCGkUxOzzCjDkqlKNCFSMjBt6UetuDBeGuNrsk6Sgcxt7bFgTnicuwt52rZK3fZz6TadjtWXVYchImEjY4fK4fh1FIIBU7wI2lzX7G2V86cD3ei+2sOCsWAyyEn5Pn+KSF8KEbb5NTtgJCTbW+aSc0W53Bn3FlHC5fV9Hee7zUOpWQKXHU2Y0vHf777NcBi1yvrjBpvZe9ZCo1wMqJ6ADrAgN0tZtAcEl6ubIiQS7xgHyLMP7ydorZ/BiMIz67M3hk8HBRN2+yr3KgeBZVW6JX2HL1I5Ckt7BeH/tSxs4EYxzczTEE0wRIyJRHFapHUEm4W2MaeIe85B/lSLoAhxX8S1zSG+S5ddOsQtM9vUcyeEHeB0/UjtGOpO5Vc/mnNUIAHzzkDKyIrOVmS2LKZk8Hyf3DGsaewO7OOexIkD5i5Nc6Mp/QsOlSlZdLTz6BLLae+JCc29I+gQEKcYDjUQq8Sz/8bcWsC3RC9yntvfxtAaKd2T2ZG/I2rOu+lWhTU+GwwsMa+ZnhrJpNKz+1tDAyarHQTUyoELqvCWKxyFwE6lcAGyZbnPGeQZc5lh2Phh9ydUMz5+ps9
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: P1che0wE/6dgPJmoCVfwiPFuOZNTidKYCr9jAZAzsjluwJ9j71kgEBH41si8W/kesMSuQFsWO1QTgyi7kPIwE/jS21tiQ7vluKoC9i1/a77FeJg5tCihw+kXZyevJOMl1bZYBbsjkOIHRfW0HCVOSPFfwGA6WZffNfk8qAN3HZNReHL5jiNQvZbAu7EnO8Feg7S3WmTPlDZBFz5Pn+EKYVpzKeM/F0C1BUyWWQprXu2u1u6itzDtliOEHdLp2rEfZdeJS8bNPOWjs4Vj2n4zs17Af2S6uViw+oMSy0wgmB+o/ta/wYaiiZDgwSC6q9u8GS+qWF6HCJyk63sxP88BNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11217
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c29bcf0d-bc4f-4d7b-a54b-08deb0c2cb2f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|376014|1800799024|36860700016|35042699022|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: BXjLRkujJMv+Mr/cGh1wtD0WeQfp9WUyyQlzhVyMqrx9icViYoe21tKelaHAUISwexzzamWrBRRJG4ty7PBUPVJM0hAZPPOTmnnMk+7pRIrb6jE4VZjiNqhVJLDIkK6RiSCC6VgPjJuGYtz4wGMpvZ5+FfXe/e3d95SeaEC5KVEY3RMZMT5ILkqVGrKHrvP8cqWKwowiA032tubpitOyBNdQLswQN+xC6UsMAVgC4kHxzVq/k1dQqC54J9mQoQDglJrIPXsQ6OHPlSD6D+YTdWs5GXjwyVV+HR1gwIxDhPTBfp6xp7EeP7DtYYLGfML3IkLkxqOFPoO4e7/ADIuyG5a02rrurJcI1mpSfNPKwKfXTFKkdD/5D2ssceRiMkdR74BtSDhKBPzW6LfrvgNOYexAM1ZQ4rhO6EQ8Pas50IlPWOKvzY5SNNlsDhOV04FnwSiQT26MPGfUjviYy39i6vuwepkuJdBfIno/RaCY2hRrJgehmsqLPukTLba5AUVhkz9eOHzFj5vPZ8mrYgXAFQNa7QPffP6/i/M5GCmaygdStwkp0mEIIvQdwMVOb2oc6w36lWBoznrqEpqVuCFOeZ0awHTgWvLLGy9S0qc9gP5ubXylhMTIjZNLEv6fHpLyVq2cv6VUy50L8BSdzQEW2y6KA+BpU+q01Hv8zUuoznU+va7ASlgLeZD7Up7yb9ikbkHqYMfVu4dCOU4beP87Oe8/jrHByoviwk1Bq5zPMPw=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(376014)(1800799024)(36860700016)(35042699022)(11063799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3pexKcJl3kMut/a21CtYe9pQQhlw3OeqdwMx1pxr9qYX3WPUYn8H0pMq0ehSLlCDjo091kjCd21+/Du56btYOoZ/DI1Ypu4y7TdgY0HLi8eymcXabb1Nxt0ltB1x3BwlGDWSNjd0YygJn1kc8HZvg9nvvxaDQEXDrZcRWv3sa5Oa+sdxSGPf81o/9pCbCB0ptM/SneDKXyB3ccf+Rw+jcgNSw4lF7W39vR2ai2tNf/rMkYOOcp3SmTG7mLFs3kqW6iB2l1PJbVduO2IYjIRpH/btowskWn2497agTMeO6u5iymrH9iCGM8RM421ux6p0ZhTtjxOVr2fPMTXHjAqrYfsakyEVWEDhJKNhG1Wzh1eHrkXtcreLgYSKOakkVrdchtClmWndNdkTPAX8/Y4fx8+vY5LSegSDtjvsjQwyde62OqbLMKCKtmU2ySdi0pFg
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 07:40:45.5212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b54402f-6362-4b9a-e72f-08deb0c2f193
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7909
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

On 12/05/2026 23:48, David Lechner wrote:
> Split wget_do_request() into two functions to make error handling less
> error-prone.
>
> After a successful call to net_lwip_new_netif(), net_lwip_remove_netif()
> must always be called to leaks. This was missed in the HTTPS section of
> the code where we returned on error without cleaning up.
>
> Instead of adding more calls to net_lwip_remove_netif(), refactor the
> code into two functions. The outer function handles managing the netif
> lifecycle. The inner function no longer has to worry about cleaning up
> before returning on error.
>
> To keep things simple, the `path` local variable is removed during the
> refactoring. Instead, ctx.path is used directly everywhere.
>
> Fixes: 3c656c928bd7 ("net: lwip: add wget command")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  net/lwip/wget.c | 88 ++++++++++++++++++++++++++++++---------------------=
------
>  1 file changed, 47 insertions(+), 41 deletions(-)
>
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 502c0faebb2..f89a6580b41 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -292,45 +292,17 @@ static err_t httpc_headers_done_cb(httpc_state_t *c=
onnection, void *arg, struct
>  #if CONFIG_IS_ENABLED(WGET_CACERT)
>  #endif
>
> -int wget_do_request(ulong dst_addr, char *uri)
> +static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
> +                            struct udevice *udev, struct netif *netif)
>  {
>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
>       altcp_allocator_t tls_allocator;
>  #endif
>       httpc_connection_t conn;
>       httpc_state_t *state;
> -     struct udevice *udev;
> -     struct netif *netif;
> -     struct wget_ctx ctx;
> -     char *path;
> -     bool is_https;
> -
> -     ctx.daddr =3D dst_addr;
> -     ctx.saved_daddr =3D dst_addr;
> -     ctx.done =3D NOT_DONE;
> -     ctx.size =3D 0;
> -     ctx.prevsize =3D 0;
> -     ctx.start_time =3D 0;
> -     ctx.content_len =3D 0;
> -     ctx.hash_count =3D 0;
> -
> -     if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
> -             return CMD_RET_USAGE;
> -
> -     if (net_lwip_eth_start() < 0)
> -             return CMD_RET_FAILURE;
> -
> -     if (!wget_info)
> -             wget_info =3D &default_wget_info;
> -
> -     udev =3D eth_get_dev();
> -
> -     netif =3D net_lwip_new_netif(udev);
> -     if (!netif)
> -             return -1;
>
>       /* if URL with hostname init dns */
> -     if (!ipaddr_aton(ctx.server_name, NULL) && net_lwip_dns_init())
> +     if (!ipaddr_aton(ctx->server_name, NULL) && net_lwip_dns_init())
>               return CMD_RET_FAILURE;
>
>       memset(&conn, 0, sizeof(conn));
> @@ -374,11 +346,10 @@ int wget_do_request(ulong dst_addr, char *uri)
>               tls_allocator.alloc =3D &altcp_tls_alloc;
>               tls_allocator.arg =3D
>                       altcp_tls_create_config_client(ca, ca_sz,
> -                                                    ctx.server_name);
> +                                                    ctx->server_name);
>
>               if (!tls_allocator.arg) {
>                       log_err("error: Cannot create a TLS connection\n");
> -                     net_lwip_remove_netif(netif);
>                       return -1;
>               }
>
> @@ -388,24 +359,20 @@ int wget_do_request(ulong dst_addr, char *uri)
>
>       conn.result_fn =3D httpc_result_cb;
>       conn.headers_done_fn =3D httpc_headers_done_cb;
> -     ctx.path =3D path;
> -     if (httpc_get_file_dns(ctx.server_name, ctx.port, path, &conn, http=
c_recv_cb,
> -                            &ctx, &state)) {
> -             net_lwip_remove_netif(netif);
> +     if (httpc_get_file_dns(ctx->server_name, ctx->port, ctx->path, &con=
n,
> +                            httpc_recv_cb, ctx, &state)) {
>               return CMD_RET_FAILURE;
>       }
>
>       errno =3D 0;
>
> -     while (!ctx.done) {
> +     while (!ctx->done) {
>               net_lwip_rx(udev, netif);
>               if (ctrlc())
>                       break;
>       }
>
> -     net_lwip_remove_netif(netif);
> -
> -     if (ctx.done =3D=3D SUCCESS)
> +     if (ctx->done =3D=3D SUCCESS)
>               return 0;
>
>       if (errno =3D=3D EPERM && !wget_info->silent)
> @@ -414,6 +381,45 @@ int wget_do_request(ulong dst_addr, char *uri)
>       return -1;
>  }
>
> +int wget_do_request(ulong dst_addr, char *uri)
> +{
> +     struct udevice *udev;
> +     struct wget_ctx ctx;
> +     struct netif *netif;
> +     bool is_https;
> +     int ret;
> +
> +     ctx.daddr =3D dst_addr;
> +     ctx.saved_daddr =3D dst_addr;
> +     ctx.done =3D NOT_DONE;
> +     ctx.size =3D 0;
> +     ctx.prevsize =3D 0;
> +     ctx.start_time =3D 0;
> +     ctx.content_len =3D 0;
> +     ctx.hash_count =3D 0;
> +
> +     if (parse_url(uri, ctx.server_name, &ctx.port, &ctx.path, &is_https=
))
> +             return CMD_RET_USAGE;
> +
> +     if (net_lwip_eth_start() < 0)
> +             return CMD_RET_FAILURE;
> +
> +     if (!wget_info)
> +             wget_info =3D &default_wget_info;
> +
> +     udev =3D eth_get_dev();
> +
> +     netif =3D net_lwip_new_netif(udev);
> +     if (!netif)
> +             return -1;
> +
> +     ret =3D wget_handle_request(&ctx, is_https, udev, netif);
> +
> +     net_lwip_remove_netif(netif);
> +
> +     return ret;
> +}
> +
>  /**
>   * wget_validate_uri() - validate the uri for wget
>   *
>

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
--
Jerome
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
