Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C4BC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 09:13:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14F37849AC;
	Fri,  3 Jul 2026 11:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aVHJM9Of";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AA2C848EB; Fri,  3 Jul 2026 11:13:06 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC51484987
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 11:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wg1tcX3XU6h4vZALwt1Vf+7UdT6YkgeF353ujIQySNH8V57Crp5o/hrsNg/t2qeB36fcFKYwbznZGmAOVjtDK5kQN8CJtG3SCwWrBNDOVXvsQaB5GFbqw16Z5UagWd9eSBOe+3m/QXUCB8UngA3dDywRim13uWSL03Wp/hI/tW8XwwCMKIRd2+4EYRUNV7VF9k5pqiHiOs5KMThjVkVDX69TPHBz34USNT48ULE1o9CA/qAqImwLtx8JmyR4vuZRzAuSBvQvvOmJ+jLba9TGvBV343NT6FGbEpY/zakX9l7RpkCuh/ztTtqVPnmW+n8hGexCkNiRSDXxtr/nzwZaAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/TpZJ3luQntUUGoPOzbg7wRqRm3+onPQjU+t08sH9Y=;
 b=N7medAq6/cGt5urp4kWrqzdE6SbKtXZ3Gv7mWoS5+CiEMs3flm5SCggQx7vmgQkVtZ1tfBk9j05V6mn+kXNX/WFzcl0BLK09x1kiOZDNC+TDm8FLFIhAhW602BPO7lqnJ5zcPsbOU16ya0K97Gd4RQm56AiJ4ED2x6/0FiP49DCdkLT0GRbZ/b43ITZ8GdYXZsDV71UNDbaWBX4kw4hGLoBixo8ia/kksF1JwAioL60DyHwxBX0wxHlywLBiQ16Ov9Xo81ecLfAQJ04uVyXVGPrEI+F6hJoeNPdjm6ZASP8Y6ZBfiE/UqGoRwrBod7dUSIFZEJEZNvMSu4gQPUo7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/TpZJ3luQntUUGoPOzbg7wRqRm3+onPQjU+t08sH9Y=;
 b=aVHJM9Of9ZnqpVPIIGtSlE84UeOsvNLI7RRWkP5nxlv7XwJZzeeyecZGzA3B7qZFeV5nzg4T1KFGuv4M1Lq9DvCXX10Do4MJ5eoMJIeiDdhEa+Y0wxkt7KM3VdTb3i0X313+8qi7fqYwbB9wII6FRqaUMYETy4zDax0H3VEmJJ+x0KLha+whBucIGu23M7wzPC3noeIopvSy0WiJsgBmavx87Z+mmXbORRDuP/6UTXPzHDa1W+/HRG4xzNkgI8PKrbRaU5nC0JJzuxytvRUWLd83ZkCn+HH5WrbEDNdCsERqoz3mmkKiypIFENXbvbaCIhmDxRMBfIWAQenLdWLk1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA1PR04MB10817.eurprd04.prod.outlook.com (2603:10a6:102:485::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 09:13:00 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 09:13:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 03 Jul 2026 17:11:27 +0800
Subject: [PATCH 4/4] dm: core: free old name in device_set_name to prevent leak
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-dm-core-v1-4-076d395bded4@nxp.com>
References: <20260703-dm-core-v1-0-076d395bded4@nxp.com>
In-Reply-To: <20260703-dm-core-v1-0-076d395bded4@nxp.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA1PR04MB10817:EE_
X-MS-Office365-Filtering-Correlation-Id: 7052b906-d8a0-426d-b9a5-08ded8e34746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|19092799006|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: S1Hzc6lVItHZUYXAXddqQ75Vh6vgBFBnEE3mkpd4QwrzJElxesRDNpNP6aycO/zYOmymcBG/SWG48u16/31IkqZ1OiAp7QCutmi7F1gyNbrq8iYIlV2GVfF/LKKla/XTw8h5pwM6RCMViDkf2DmPBsdzf0u2eAzNJXx8OzxCUJgbQuQ0caGL7HL+qshVYhH8nl6SY6iT6FHQYM/glaGvTm2dFWMgUOqPiBRS1vOvXJy49yHNrJE3H9BTD6ovq7jig6HkY6ZUTsLqRm6z25gk/8zTB46ZOQKvUcteBt+eRBpFWM2DbM50rhuJu/rviHMJ6vPu8awjjZr3s70k9ASgTE0UUFGhO4da/Tb9UWn4/qqoUIaOcOs/eMfsQh1fLkQAsmWJbAGbUKkrb0/2ZSCUW3Yt/mq5/jF/5xUR2XByOHM+AwyTtvvpYxQA3oKiYVOnkb7VXCZSGRM7ucIniMXDMUCikIsYH8usjkSn4ounYttQabyngFEq592Xdr04Zk+teAxAA8bR8dT+MjYjYQ/RuVjaBTK5wTO2R0+Ps3EVpqjs2x4iQ8Ypf8vjkeE7D8uhVUA6fZbKrL/dpZcIdK1C8qgA8wiOFLF/5AznnrMEdHa2MTZ63Gycj6U7lBZ2q5X99SiQYLx6zpR18OOdk+CjMJsBFgP+kC4Jfzefa5ppQLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(19092799006)(366016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVo3ZDNOR1NlM0Y4dS9STW1sNFF0dkdQU2puTEF6TjBCWTZJVjMwRnkvbDZP?=
 =?utf-8?B?TytzcWhOMWxFd0FSVlF6eVVLcXNXalRHeG85N3o4eS9BS0VvREdjWlJVZ1RS?=
 =?utf-8?B?OFdyNDNqWEtkMWdYUHZLRjQrUzJoQTE2Sk1BcFJoMHd4eEIwWDhxcXI1K0Ry?=
 =?utf-8?B?ZDF3c3kvYWRGYzkycmk1WEFPWmFybmViaHl4TnZNUTFKTmJ2Nk0rMzBuSGw0?=
 =?utf-8?B?bXhKaDhaWUt1dzNyQVNWVWJ3MUdxc3JpUy9qckV5T3RRUUFiWWlyaW82RVJZ?=
 =?utf-8?B?QU8wYW4ybkg1S3RmSTZkT1d4NDc5c3kvQVVyd2F6M0xSdFUzaWNmZTczcmha?=
 =?utf-8?B?NVNHSUNZQVlnQkdxNE5nMXREVTF1MkJmZDVSN04vZWpFckQzM1ZjbklPakZZ?=
 =?utf-8?B?WGpHYXRnK2lmSTJmK0pWQ2Jac3BDMTg4QnIwVjVTSDdRamdaajcwOVdrTUkx?=
 =?utf-8?B?SkJ4aGlvS1ExL1N2ZXp3d0RIWFpuSzNJeE9lZXZLYXZJNTN2Zm1vcmlSQ2to?=
 =?utf-8?B?YXNTak85cFN2NlprRVIyZHVkQlVaZGsyU3hxdzBWaHVFTU5kMytJbVpTdlkv?=
 =?utf-8?B?ZzlmMTAvbE5PWUdJMjJvQzc0ZkhFN3JoMXVXNjIxdTZIcGJhK1Y1RTAwK05Q?=
 =?utf-8?B?dWtNUVl5SS9rOW1UZ3FTcklxcEFVVHNUZFBqMk5nL0lDa3lMakl0UzQxeVpy?=
 =?utf-8?B?WitKRStYS2Q5OGV5S2x3cEJMa3FzNWdxYnNuNG9yeStTYjZ6aWFNVDcyWDB4?=
 =?utf-8?B?WmJldFVYSGZ0dVl5YXQwbGZmRnp4Z0JtL1ZJcG9kRHFEVlFYb2gyUlYxVnhp?=
 =?utf-8?B?U2Vma3FVL285b1VrY3N5c2xHdnE1ejhsYUlDWjZsYmVCczZ5NFQ5NDh5YXJM?=
 =?utf-8?B?WWUydDhiMXNNZHJnL045bjhPdWU2ekpoT1YxK1NQcWQ3aDFXR3hBSi9pcEsv?=
 =?utf-8?B?WHUzWWJhOTJ4RXBHMWxHa1lJaUFSODV4Y1RTVk84ODFQOEk1NElvMHRxR2c1?=
 =?utf-8?B?ekU3aVVCOFdtb1FiTHVMaGUzNUVJT1RQb05CRTluektKNzVzVjR6QVV0UVd1?=
 =?utf-8?B?MGF3b2pXUjh3WnFjZnBaMmUyZCsycnBwWGNUZGZKdHFrVHZQc3c2V2Q3RjYv?=
 =?utf-8?B?WFBhQ2o4SjlVNjliOFhHVHpEY3pleS9GSVZHL1p6c3Y4N2JkUTB0NVlWZkZE?=
 =?utf-8?B?OVRMeU1sRFZucFVWajdZUThZYm5HT1RSYjdncUVDM0tUK05OS1hydVowS25Q?=
 =?utf-8?B?ZmNjQUhuTW13YzNNRVB5SzdiWkFzLzlSQmI0YU1lZ1RhQ1VVTHNDMnJaTXZo?=
 =?utf-8?B?MnZMZHV1ME83Y1hsSE1hUHNlcDNNdnppM250b0cvWWlWd1hZQWJHWXNKVkJv?=
 =?utf-8?B?cHZJL0JhaVNLZlFPOW1WeUdoR3paOTVSeVBRa2tRSHA3OG9zTXVmS2h4enM5?=
 =?utf-8?B?RjNCWGxFYnVLbS81aDRLcHFkbElzM09NcHJkTTFGQ1RwTEhpYlVCRnVabGZU?=
 =?utf-8?B?NU9mWEZiR2tLejdyeWhVOEQwQ3IvdTVYU2k5UXhCdmpTbURtVEtrMUJoL0VT?=
 =?utf-8?B?WlM4RU5vVDE0a3FYbDdpM0ljQmR6SWhtb244S21KR3c4K0lJajR4aVlIVTQ4?=
 =?utf-8?B?UnFmeitHNk15WGdpYXIydmloVzJwZmxla2JmM1oycjNtVUxCRDNOZzZ6TDBT?=
 =?utf-8?B?V3pLSGVYMUhWUXFOQ1F3ZGg1NHlseFpTWGU3c2tQTXZPbHNHd1hsTjdOQTR5?=
 =?utf-8?B?dGp4bk1kbVJNcXQrVHhyb3RXTnJSd3RIQXZGcDZaOVZVaWxCZGZpMjBSYTFu?=
 =?utf-8?B?ZGlhUHNicEtVVHg0QlNiZElERlpoRFY0Sk5jL2h3dVZPNElhc1phNHE1ckJm?=
 =?utf-8?B?QVJ3aTBlYzI2b2VyUkJaWDArbzVnekVRWEhTRTRzMXJNNDFGM3JvTHVocStt?=
 =?utf-8?B?N29uclNGR3NQL0RzYlJDYlR4UENyNWYxSmp4dkJFYXN2eEE2bjBaRC9OVzIy?=
 =?utf-8?B?R3ZoRkNkM2VPcVFJWTZYbHliSG1pUXJRYUJaaUhYQU54R2ExOHMyUjZ1ZXBW?=
 =?utf-8?B?Q0pKQTM2WnIrLy9hQ25mcWZNWWhJcStMcWszU09Zc0ZDOEdYam0vMHloNUlF?=
 =?utf-8?B?V0F2UVo5Lzl1c1RiaFJ4bjJtMm5ST0FOM3h3NVVBTHdKVHN6Y2l4ZkJzWjdx?=
 =?utf-8?B?Wm9ZVHdkRHp1LzNFSWRUaXBuT2p3dVFNZTBzV2hYNjV3dWY1cHNwSnJlc0Ro?=
 =?utf-8?B?blVmUHNCMGJLcmxtMDIvdm1Fdk43WUpaSndIVlNObFh1QU1mNXpkK0ljMStV?=
 =?utf-8?B?RjJtN2xpWW45cTZVMDFGSC9SSHQ4eEs3aWY5Wjc3cUtQUTJNc1grL2VKdUQz?=
 =?utf-8?Q?YbcIWS84iTPf2VTsXpDVCwF+bUa0ZuTz1rY43?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7052b906-d8a0-426d-b9a5-08ded8e34746
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:12:59.9347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Mkc3OB1IopEdVuQ5xHNeAyyRy8d4BytsD/vSDBekx9ETIbrYeZ4BQyX0gvJpukCU1ZXwKG82wv49c/Si+sZsg++iMa7JQ5nqjB+gkh7rYFEHjxmvT6f298GoOsHdNNO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10817
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

From: Peng Fan <peng.fan@nxp.com>

If device_set_name is called on a device that already has
DM_FLAG_NAME_ALLOCED set, the old dynamically-allocated name is leaked.
Free it before assigning the new name.

See: drivers/net/mdio_gpio.c:mdio_gpio_bind(). There is
device_set_name() here, however dm_mdio_post_bind() will also call
device_set_name() if "device-name" exists.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/core/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/core/device.c b/drivers/core/device.c
index d365204ba11..6024534ff93 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -1147,6 +1147,8 @@ int device_set_name(struct udevice *dev, const char *name)
 	name = strdup(name);
 	if (!name)
 		return -ENOMEM;
+	if (dev_get_flags(dev) & DM_FLAG_NAME_ALLOCED)
+		free((char *)dev->name);
 	dev->name = name;
 	device_set_name_alloced(dev);
 

-- 
2.51.0

