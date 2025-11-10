Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E538DCCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 17:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C22683A5A;
	Mon, 10 Nov 2025 18:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="SHeQ7faK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0213883A83; Mon, 10 Nov 2025 18:37:55 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C199183A43
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 18:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t26PiIgKArCt0Oini19xnG8KQk4fDWKkfufGh9NDWmrYBugo+BWzErBx2QIq4dl1RPvpuB8uwahFFeYyPSxuaJeK0ezmma9Ez5YSpAZq8+uG387FXgq/h1mh9fNMU/bw3u2ph+480XR2V32neoONTsjfuxtTCb06s3V4Vy+qu3sDaEy6pWAu/vf3tNlJUGLVaoRFdbWCsxvGWRnJlItFOO5Ve3XIF4Fpq5vGSBoMYozrMpfe6XEGkHfGoxTtppuNPFr2XmPkMppo7r8F+TYF/BIbG28haic4nx6kn6um5L3hmDJycUwutloSZ1Z9P4cOBEwQrIlIZ62i/9p66/I2Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nh3KhuTncukVAPoBEYNoXWrB4/qIU4a58F2vbngUl7Y=;
 b=Qp0Fe3OU5pzajl8RUxnjlSe8dpYx0D2Yt42h4TYjuzDTuj0GjkDmNu8ANp4TpWRbCHCtsbKJYvw3h1/l5ef9133qvZR3FuA6diHBFqpvBkiGPdG92qo+PSyWetWVLdmt5EETglxZ2IomONVgQ1+/8fHBhbC1kN5K1zYFz6zieTJCIyCLR9eXOGboI1cj6IAX0mZoIdnkEYGyH7gFe1V+We8pFIa06ypqhc6plIVRHRPbSFGpD6q6R7E/cPhKCb7FMnoSvhWuHs+DLCOhni8o19TufMcQ6QrcwVCDgRl/sOSS5Euuau10a2GkQhYddjbtTy/FBdn0B7SDW2dsEhrbtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nh3KhuTncukVAPoBEYNoXWrB4/qIU4a58F2vbngUl7Y=;
 b=SHeQ7faKPWTyAm2/CqMcjvh+sJ4evtWDyYwHXgBBa8NoK7JE7jkHQbhGsrMEqZ9BRR5QrAl3cQms8zzj1aw5w+EdoAMefl6Wm5An4DW6/+E99HwsoCivFNJhNkkHRpniSRcwwkGB1tA1uup8/qf2HBiWvUtNudELeRuYcRZJUZwekWWGBOC8sgJBSOk64Y9cwyMrLXwRh6VKEJlNJ5am0pA7CTfsYHLSkXD++YXS0PdiRmLuh0Z6uhsWj/BRI5tuF0EFJemLUkH7cZnKIDA1rP3mGk2GYcDBIEcg2YM6+YgmBKU7Ni7gzIIoctyQ8ehb4nmE8TvBi5u26GGybi47Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BY1PR03MB7802.namprd03.prod.outlook.com (2603:10b6:a03:5b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:37:48 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 17:37:48 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com,
 balsundar.ponnusamy@altera.com
Subject: [PATCH 2/8] mmc: sdhci-cadence: Use max-frequency property from
 device tree
Date: Mon, 10 Nov 2025 09:37:31 -0800
Message-Id: <20251110173737.24545-3-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BY1PR03MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 406af7da-6f3f-48f6-2b0b-08de207fdda0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K/Z6I6J5JkBdPSndHR3d6pjsWG6nQsZzays+9adhbXlsRM+ZEy68MVfKE+RD?=
 =?us-ascii?Q?jqjFaTtX+fh8PxpccZkSDWsm8cy0CL0RdxIKoHGRls+4m3tL0RMEX4rozi+Y?=
 =?us-ascii?Q?GwqMiqcHf8bHyDx8MphrQ2mgk3964o+AOo2rnL9p86QkMAdcFVoze9yp+9Vv?=
 =?us-ascii?Q?scNzC8IycPrcAfKANYUppVgSGpUblilmWuPKjXMtr/nyTNUIPYFSBzYUVNFj?=
 =?us-ascii?Q?2wKuYa+ayn/AemL2R3FhDLGwdoEiuPDiPKFGdWczhvKW6lgX8R8en/4Ixn9h?=
 =?us-ascii?Q?v6cp2MdS0EDLAC7RxZwZaPJzEeXrwrR7zSvSa9agu95PNeHu+5QSzFKpRqii?=
 =?us-ascii?Q?PIJokBYJcH06H7qzh5hUMJVGl8j2ewO3QNl3yq6ojBj4Ewn0IJ534D+Rgd71?=
 =?us-ascii?Q?RVnc6p+uZrJdJwhGEyg7EBV67OYGavxFzSMXiYicArmD1gddwVHjf8Vo+OuS?=
 =?us-ascii?Q?NQ7xZSKYz0D3g27TQa5eaGduUkEXHPX/CHtaNT6nucm25EquUiIDwXpAVN29?=
 =?us-ascii?Q?dgwPk5U3yBx/0SQudq10ehg4IhGx6EhR3xGyyiNzk2EGYJNgPFQRZC3oeyO/?=
 =?us-ascii?Q?xQJjJ8kasu5ZigmFzXIiZWdPX2QOHcqpFxJvO0YihYe1kG1sbdkCNryZx7iK?=
 =?us-ascii?Q?gm+n6YUiD3LpyCCaWr7DWkT3hnTuU9O5fwslCR+LNsj3AMv4CeywvF0BcAgt?=
 =?us-ascii?Q?gK16ckGD/yy8HDmMuvPKnV+GWORAw23/k+Un4IEw/3FNNfLcH17RFSvrRhEN?=
 =?us-ascii?Q?0rRjsnFE1nv/cGPx9r4HSpNXj10+rm4YWPY3NdBsrKLEXDjTvmQ2gA4NafZP?=
 =?us-ascii?Q?9loJOznhRkwMPJ15bCs8nRoF//S0P8W9b5IA0bi762kmFEpAeQ/B8Td5eMqR?=
 =?us-ascii?Q?37h19wvV0kx/aMI/C1qrSe7PUyjRcFlOUzLDP53vx2RHk8ndJ09VbA4uM5xL?=
 =?us-ascii?Q?q/d9TkZret4hj42iphOeHZq0tT8AAminJYA5wy6Mop/cRoi7GRZVhlV5163+?=
 =?us-ascii?Q?dhJrYpNv/VmU/WDT+MRn6qrIxtkTBW/NtNkkHA169iP4+iEAelm3I1WmhGWm?=
 =?us-ascii?Q?yBJiPP/kw1QnONorAwvyoB+VPg+1nNSlhmIvk/MM+/EPg9ihxcawEO7ndqEz?=
 =?us-ascii?Q?sSCYMSo5VFpfIQMYD1qhj/3L1UkgbCNWz81kt5BvqcIFlfsjwQC3ee0Yj2WV?=
 =?us-ascii?Q?8rkmSqVh+TVtYBjv551zpZzdDAJ3DHkNjvrh0mflQwl73Qf8SXPhvkVpGOwR?=
 =?us-ascii?Q?s3MNOtl6rk7XNk5HD9rZ5njHEJ3GdSwtZjojBKlpYuLvAvwKaXogG0Q+z1mK?=
 =?us-ascii?Q?m9AyT6SK01edanq5Gmd0+b5bqPqaqbEvFSmCya8U+vD7BET2rrVK1Qbsdrdk?=
 =?us-ascii?Q?eioKdeMiOlhRpdajWSR9PKhkPGtlsOfQgEmYPBzDyEomYDs+RPwW9uLOA2+k?=
 =?us-ascii?Q?c/IApzeisx1A/77L0jQhIu8O7TpNYnua?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yqwUmgcliQCw3tsFIGjSyiG8X9ggdfLLpl17fG2ML/rEKC2DmR//b5oXHXtF?=
 =?us-ascii?Q?ms5yM9gK82Cl1CtLNRm7H6Bk28A78DpmTvDkNy8CJJCEccWdx1ADEB8/WF2r?=
 =?us-ascii?Q?9bMcRC1SGA60OjjW2MB0EMpYRLbYegEvK1uQ+yxvRO7gJeAIgSGkmSRZSz20?=
 =?us-ascii?Q?MQWjmwELhR5uVhKKLFP/Prr85KyaXSfc4e9Cl8DDLj61ScyoHZJMU7uOW64m?=
 =?us-ascii?Q?lRFjqrebN8gVZEWrm+x/8rezdqohFSYdH+rJKYVU8tneNknsVXSVHuwVZkMz?=
 =?us-ascii?Q?3ygW0K6N+DV55blEgiqJ+Lw+Vn5g6JUL06jcXg1DE/xkRJsW3SWeEZ987Jml?=
 =?us-ascii?Q?81FXSuMn6Eec1Kw1H97F3oNdNnpCEhxg0djNf0moXIvffdAQ8iWMOExYYDyi?=
 =?us-ascii?Q?N+H1GG5ii/LP9K6KXeUKY3NpfhwQ1UAkQ6xynedhg5KD4wlyImjn1dlS8ZWh?=
 =?us-ascii?Q?X6f3gS6jNe6pHf72FXNYNGFYi741TjV7QG9FrAQDhR82LmkHNltRUom/JIwA?=
 =?us-ascii?Q?+2d+hEQ18UwkeqclU0IVzUehvXACh0Q13GxZ8S44i7GU5QBGKnFgHuYFbDKb?=
 =?us-ascii?Q?DTy97w2fRZt3GJXnCjZ3TU/khjcu2QpZc6Td4DRJ0U3R/m/UrRUdBilDtpYx?=
 =?us-ascii?Q?xX+HGdDUVIhbfjnpyotImuyxELexAezDmZb3nufKbHo2vlrIQSW6lvKnGxFI?=
 =?us-ascii?Q?KHY4QwsXNdv17eWbN2G58+KzrSzZwcSHB3W3XesnahJOYt7CmfxX3EXS4II+?=
 =?us-ascii?Q?vxu+djo3NekR1RjW7ZsXB0nPVzUGqs1WpnsFZXJqLNf5Pc5ZeTsgbRu5TmGk?=
 =?us-ascii?Q?z5i4DOY0nQLWYIJ4OJSuCXzc/HmXrJ50oZ5vdF8g/mGBSLtVFUrZAQX3v+7B?=
 =?us-ascii?Q?7R4Zu8WR3E9/J5QdzU0nJiCo9UicH+Gka38NHJH9WMAsnW8jpO8Jw4lVIfIe?=
 =?us-ascii?Q?SkFl0A2ukNS5S9w8rPKClaqYsuUrn6HYZbRA1YI9VLmVMFvUQ8cHzYbIum56?=
 =?us-ascii?Q?OU/QtMDfTZpwcrlzHRomtZgiih2nsFEQpm6j/WdGXhR1ldagGpgM8s4oEsLJ?=
 =?us-ascii?Q?EBcb2eoVp1wCONbVAHm5X0YCk4WP89Ig/Ow+IkTS0EruXwku6YmJ77M9NSiY?=
 =?us-ascii?Q?AFfTiaoiWvD6/wWB5TBommnoNuD0HfdhixJTnSLggjrgx+Wcp0qdLwc9AR3P?=
 =?us-ascii?Q?u3ry62+WocWQCYXfJoVknL5QxvpGOk4AVhZgJGiYQwGLlnAbu7guI8z9N195?=
 =?us-ascii?Q?75IG/83JelWLz1mfMb6TkakXlXIyaoQU8myFfhJ4id/kq4delPaFRnp7YzpX?=
 =?us-ascii?Q?JXNTiYBG+JVY9o4+x0gOSD8WBGgr0Sr7IcUTvqok00SanDgHBbt/6JIZ1kaN?=
 =?us-ascii?Q?UnjNw19XAeYury5A4r528BJLO0RujsPZ9WaKSFVpr1RZFMfqZOx1xP8DYpg2?=
 =?us-ascii?Q?nVpeuU/RKAFbfW0wkbT1f0sfyXfedK4tDvHMhhVssMc396Vs2qzLjeRyoyyt?=
 =?us-ascii?Q?63/5+qhvmTKccUdpuSbhKES6hH/Mi3PCRn5uC1FiiibamJO6VFh/erkPcEPH?=
 =?us-ascii?Q?g9IjumW3YOEAnUv5XUJXnX7blKBi7rG61k6mCdMPSuxVCmZFy1oGmANzFJZz?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406af7da-6f3f-48f6-2b0b-08de207fdda0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:37:48.6988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjbC07uO147PRg5Fz7ItxxlP8XKSjg8H3C4Nl7a0TGD9pmqlKcKAE8Rvew2IPAtPljbELjn5eXcjkhWAkCLN1Yc8hVn4l0Wn27dELuFNzTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7802
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

When f_max parameter is 0 in sdhci_setup_cfg(), the function defaults
to using the maximum frequency from host controller capabilities register
instead of the max-frequency property parsed from device tree.

The max-frequency property from device tree is parsed by mmc_of_parse()
and stored in plat->cfg.f_max, but sdhci_setup_cfg() was being called
with f_max=0, causing it to ignore the device tree value and use the
host capabilities register value instead.

Fix this by passing plat->cfg.f_max to sdhci_setup_cfg() to ensure
the device tree specified maximum frequency is respected over the
hardware default.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
---
 drivers/mmc/sdhci-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
index d9fda902076..f31437e5eeb 100644
--- a/drivers/mmc/sdhci-cadence.c
+++ b/drivers/mmc/sdhci-cadence.c
@@ -255,7 +255,7 @@ static int sdhci_cdns_probe(struct udevice *dev)
 
 	host->mmc = &plat->mmc;
 	host->mmc->dev = dev;
-	ret = sdhci_setup_cfg(&plat->cfg, host, 0, 0);
+	ret = sdhci_setup_cfg(&plat->cfg, host, plat->cfg.f_max, 0);
 	if (ret)
 		return ret;
 
-- 
2.43.7

