Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CD1CD5BBD
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 13:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 470CE86AB9;
	Tue, 19 Sep 2023 15:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="MRL/zV6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A59386A26; Tue, 19 Sep 2023 15:50:02 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0A8186B69
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 15:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GU23WWZjjWB1e2taMbC26Jtrwtuv/M5bZ2sBOdUMQ6me80PFZrpvMRq2n5J1Xy1BYYZvlJIYCZKex3aJlpoyGDgo9huo52aaflYCRNZoRaAbcYuvKl4rTs5pvyudR3kWxGnIw7oTtmipB8Ad6paS/90cFgLktc0BNVYBs1T8uwSMNTQIjmyIA6vnGltFMrN6cPKYifP+WxPXyw4a9/r8AHPeqNneuX9/rf+o/Q6RtnLyAi64qdhvGKXsLot0w/CqIIE95hC+RpvEFOiDBcsoJZktBvkiuRQ7Gx0Z6tpiDLAOne4ZJCCcEoTlqk6jfVmtTEdV+zSQeG7kmThXDPK9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=874lVGnup81rYbwzeN7x2QZUtt6nRdVdkioDyxXZefk=;
 b=GHpZJqqUKZemwlf3IxhTmMbAmszRmvlMDqir8NKbzWxvXPnhL447SNFUXeemZe1u6sYXi3xdL/gtzx98AkGKoILmiCrD9cRzOX0lQoZ5S4b7sllbICxa9SrfJutWOIwN1Eo9D3d6O0MHaU7YQ0/POWS6ClK0wxiVXhKEPyetq+cRpaKrewop+PubHW7UIZJhZAq5zYHHpy7f2dNwS/oQ8GF7nwdq2qJ6BHFBR/wwvuy0Z7ZKqWn5BNJfhwK7e/358B4VTUfiZyCfKHVy4n0Hu3hldT9usMJ+Qj0nDXPYhJIh/lXO1Ks+UxxiIBThvE4sLWyOb2XCACHoFw8zry80Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=874lVGnup81rYbwzeN7x2QZUtt6nRdVdkioDyxXZefk=;
 b=MRL/zV6UelpVquhmiW1qCMeDQo0Flet3yc597Kb4+xTpdzNm1MkdnJ/w88njQtkeh8iASi7RuUDiF6FVc6E3ujsQakt21Y/dPVaxaCGrNUlXl0XRI8+Vi8uo89TsJZc0MXV2dTPk3BCa1+lbZa/nubqDm/yuVLxF+8Z0ZWUiFKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV1PR10MB5938.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 13:49:57 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 13:49:57 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH resend 1/2] imx: spl_imx_romapi: avoid tricky use of
 spl_load_simple_fit() to get full FIT size
Date: Tue, 19 Sep 2023 15:49:31 +0200
Message-Id: <20230919134932.134678-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230919134932.134678-1-rasmus.villemoes@prevas.dk>
References: <20230919134932.134678-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::11) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV1PR10MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d04c6d-c8a8-4d11-1135-08dbb9174fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6v3TQduhGm+waEZkX7eT6csWcRA/h8Kr9AEgj6Fj2EKNLAIrzI8BfrX7jGeFHwrddMsy+WvyAKD+pt5JLa3vzKx62uSi4fnfocrrWXxfDbonW4NRX5/2X+Vs/7Kl167kL9Ep+TJdJ0ADFd4dxbamC8oWMO76TvcnAokt4oQfrgrzf8OV8FxJqHN++wirFZG8j1ctlG1co4+AvVdE23VpO3GWfgr7xQ9nTniutufTyVBohsYkykZbsuFXWCXxmKRG/+nU7NuqcQZcbnKmPad0z8tTiHRzxf4bVCWjgUDp3T1yiEwKShdzFn3534DNgGmM17EXl8FUbT9vFdacWq7jOw1qO16swjTsVYVO6E8ZpNvbMFRyM3iEdmwXM91MmrTKNNesbSXaty7rzxp/u3B8nuPQ/UE5U0kvHhDKoqVWkXZusRdXu9SQoW8MH0mqCb/f8kXP1KwPMbOeZkf23+Ur3zUPf702YXjjN9+xJ20jj+BUkaV9lTVKBVmXqCkcjirOsKwNLWKSu+3sc4cu66WnMY1qmFR3d5TOmfIe7yP/KX6ACLFqGchm2LREPtPf9IOgORnwN5vUWqRTQp+RPh6xXjpqBt2JuqFK+0lEKC58Y3o+5SQc1xV4ZVgPyizG1WuX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39850400004)(396003)(376002)(346002)(1800799009)(186009)(451199024)(26005)(2616005)(8976002)(8936002)(8676002)(107886003)(4326008)(1076003)(83380400001)(2906002)(36756003)(44832011)(86362001)(52116002)(6506007)(6486002)(478600001)(5660300002)(6666004)(6916009)(316002)(54906003)(6512007)(66946007)(66476007)(38100700002)(41300700001)(66556008)(38350700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iSV2MpO9PACKvqyWfE98NPa1UhCxvwzASug96UJ2zZ5kQt6F5RGisf1c8fUu?=
 =?us-ascii?Q?mPDUEpVGUJ9rEdZBxUbJZil3vIjLnVpLOEK8Qbxfj2YmsqlgtgtPLMlAfe6N?=
 =?us-ascii?Q?TgQFeCo9qutSPL2jPU/ooOEkNk5uqvJtEvc3usWzVLEhwMD/OYi4bBrBPRe2?=
 =?us-ascii?Q?2+6w/0fjfMojjfQQaW6+SAdKf9uzqSTnn74jIPPENuOfA5o4tdMzGI0chmce?=
 =?us-ascii?Q?alRYGjh934/OMSbxas7yIpnfW/A1eWlEWoKhTUlRngu5Qz4HqA4PqW1qKUeb?=
 =?us-ascii?Q?8MJa270vVCT3PnNDhIwGWZmEtaeLv3AGPRtK9dCpcOdSvUbBHf4bTOfMuRYx?=
 =?us-ascii?Q?a/LbmWV0bSKM+0BFLSt8fNeP+QxAVSo4OA4ACNhc22FShfNOLeUBBrmKmb0V?=
 =?us-ascii?Q?EU9fc2fV4AR6fsi9hA5Fmb9L0PdLlTl4VLp43cMZxn99FIHZyc6r01pPPNIE?=
 =?us-ascii?Q?Ynol8zatCbiIJU2Yd0dnAbbr4hER/CJSM0bceFQ6yclwQjR53imd9nd4vzoX?=
 =?us-ascii?Q?q7ttfrcu9Mt+Im4PPOPBn5PR2+gG0c4PrCJk7be+Sj+HGEujBK1w3UD8k//b?=
 =?us-ascii?Q?dbOXLP0Z+0tfOY1aFl7bkre+xwffXcaChTmpzezjqp10ZGhnrC0EgteOY247?=
 =?us-ascii?Q?3l23FkQnhiMkMAEPmvIqQsbgIsnwtdNA2SaLILD7hm4wVPIUUuQ5Ny0Fd5qQ?=
 =?us-ascii?Q?rGA5LYVjWYeFhJdAK2701LQwusrwGqIOrzLl1uEUz9vhYLiKsOk1ZRTBANwy?=
 =?us-ascii?Q?qhlpGf7chRY6OObLVB4c/vt66iMEtHOQY67ykERKScS/a63syPaoy/Ws4oXb?=
 =?us-ascii?Q?5apEKDkm34GLxBAin/9PmS8asyTORLG5Ef3OzAbQXZ5b8yevoXMhJeEQQZlW?=
 =?us-ascii?Q?e913o0+TTWvpuoHZvS3c19IiqpQqbDFwCmaZcp1TFkt/nhXPIXyyUMV5xsHQ?=
 =?us-ascii?Q?tV0if73p+GnjE+G4f9ybuigNvbCleCjH+15+eSg+GvR9ureuFKI2XpzeoVOe?=
 =?us-ascii?Q?AcTELgZTd0Fvwf2Yw5qFzNiS/HgxuSbZncpRQTwJFxVj/I9oxXlnq7rdQysa?=
 =?us-ascii?Q?HZ+eG4n2KnwTemnaLasaRI77qNeMsdcm1zKMTQeFC6YFZILgMkw89yBgozfK?=
 =?us-ascii?Q?69Xy6dMptelriI1HPbFH+E1T26CvMzko+jnwePMqAXmhO2i+VXjdlD4VAcfw?=
 =?us-ascii?Q?4lb0RaK2qd6jcz3XK8SrSqqwTVXPnO25tFlTwd68kf5Dkt7os3Q8UZchkYuH?=
 =?us-ascii?Q?j4vmD24dGQtyULVwfWeGaampv4xZKECln6jdy8/THyvimS6ZEp/d/+uveTW5?=
 =?us-ascii?Q?p1jvOU6qgNxdi6iz0rJuQ9LYyh3eDcP/eDSkh/an1lsgiDgsxncx42+csUkK?=
 =?us-ascii?Q?0d963XpjCCE3Z7K4iT+e5BRIwu/e8/RgBqb1rfYv5j105OBYhbhZmNXAvj93?=
 =?us-ascii?Q?Zqb26e4pUrjseyoaEzHkJfyWJvJvuRyRVgYB4sdANvX9Qnnhtax/Yc3lWvLe?=
 =?us-ascii?Q?9/hjcFLa4qd/AqcWagLBBVYxkeR/1kq5THR9k9tPtsjAFR8UNf/izsqgyYcp?=
 =?us-ascii?Q?QGIQbXa4ywt/yuqdvZREK+IiyRKn7loNt2RfImB6xiOnRjMCmwpk3idRQS35?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d04c6d-c8a8-4d11-1135-08dbb9174fc1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 13:49:57.7612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ue68PLdkTKXxpch7j/WYE8vxeVgPTuma19tszp7ooLlzuDBKxOPKr18hS1ulPaSqSApkh4fEErhsRrK5NuLJdF3nw+rl5TwHgCUVRM+axnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5938
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

Currently, spl_imx_romapi uses a somewhat tricky workaround for the
fact that a FIT image with external data doesn't directly allow one to
know the full size of the file: It does a dummy spl_load_simple_fit(),
having the ->read callback remember the largest offset requested, and
then does a last call to rom_api_download_image() to fetch the
remaining part of the full FIT image.

We can avoid that by just keeping track of how much we have downloaded
already, and if the ->read() requests something outside the current
valid buffer, fetch up to the end of the current request.

The current method also suffers from not working when CONFIG_IMX_HAB
is enabled: While in that case u-boot.itb is not built with external
data, so the fdt header does contain the full size of the dtb
structure. However, it does not account for the extra CONFIG_CSF_SIZE
added by board_spl_fit_size_align(). And also, the data it hands out
during the first dummy spl_load_simple_fit() is of course garbage, and
wouldn't pass the verification.

So we really need to call spl_load_simple_fit() only once, let that
figure out just how big the FIT image is (including whatever data, CSF
or "ordinary" external data, has been tacked on beyond the fdt
structure), and always provide valid data from the ->read callback.

This only affects the CONFIG_SPL_LOAD_FIT case - I don't have any
hardware or experience with the CONFIG_SPL_LOAD_IMX_CONTAINER case, so
I leave that alone for now.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 arch/arm/mach-imx/spl_imx_romapi.c | 50 ++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
index 4af4169967..b9dfb3d41d 100644
--- a/arch/arm/mach-imx/spl_imx_romapi.c
+++ b/arch/arm/mach-imx/spl_imx_romapi.c
@@ -133,6 +133,41 @@ err:
 	return -1;
 }
 
+struct stream_state {
+	u8 *base;
+	u8 *end;
+	u32 pagesize;
+};
+
+static ulong spl_romapi_read_stream(struct spl_load_info *load, ulong sector,
+			       ulong count, void *buf)
+{
+	struct stream_state *ss = load->priv;
+	u8 *end = (u8*)(sector + count);
+	u32 bytes;
+	int ret;
+
+	if (end > ss->end) {
+		bytes = end - ss->end;
+		bytes += ss->pagesize - 1;
+		bytes /= ss->pagesize;
+		bytes *= ss->pagesize;
+
+		debug("downloading another 0x%x bytes\n", bytes);
+		ret = rom_api_download_image(ss->end, 0, bytes);
+
+		if (ret != ROM_API_OKAY) {
+			printf("Failure download %d\n", bytes);
+			return 0;
+		}
+
+		ss->end = end;
+	}
+
+	memcpy(buf, (void *)(sector), count);
+	return count;
+}
+
 static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
 			       ulong count, void *buf)
 {
@@ -316,6 +351,21 @@ static int spl_romapi_load_image_stream(struct spl_image_info *spl_image,
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
+		struct stream_state ss;
+
+		ss.base = phdr;
+		ss.end = p;
+		ss.pagesize = pagesize;
+
+		memset(&load, 0, sizeof(load));
+		load.bl_len = 1;
+		load.read = spl_romapi_read_stream;
+		load.priv = &ss;
+
+		return spl_load_simple_fit(spl_image, &load, (ulong)phdr, phdr);
+	}
+
 	total = img_total_size(phdr);
 	total += 3;
 	total &= ~0x3;
-- 
2.37.2

