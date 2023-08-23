Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68654EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 13:45:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23173864CA;
	Wed, 23 Aug 2023 15:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="p8AX6Dn4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46B7B86422; Wed, 23 Aug 2023 14:15:01 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9629862B6
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=roman.azarenko@iopsys.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjFgA5/+gwJJtU24X2qOTBYjzCXwvkRAm7oNYTQ6Mj5yBDuqdGlPo/NYpCEeg8+L7EHzmKy7hdsZpZrt32XOpf0cKx9DtoU1a5SA5DkmbYIP6emUfLSv2JBr416BfqCfciBJDRzsjd16mfa6FefPibpYhPWCCTHwXboyv4/gpnLJgL0hKlW+nMuStE5mfzca4QCSC3U3OAxim+v8mlNAEo3RtZsYu95/wFIAzmMT1Wm6OcDLUSzgcewoON8kZwtK1uNaFL85rlJxHVhMwi7K4D7xq3bVGy6yMtBAcMTPes//Wv7Op1ZfKCtPDmaDYhShe/Ut1PtJVO4rOv8lcxCgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vULBuE5SZTECfsZZkeQjemOsEnGw0BX4oO/n1RDbLos=;
 b=NjhOBHrmNU8Df/0Ffwg68R+yqkxLLWDlCXQaMyfjc4r6zGHvUOvE+X9OzOG8jtecqpU2OrALrVAGIhD+6ft165ezeHyEZDCV4tuHJRSrybecaL3SqINyN1d0ZlKoyjcyetGNNKAjlcKuqh76A8PyO5H6TIjVyia9j0dNKT5WrMds+Amrx5AocaUsnxDp7GnZmk/xNE5cPJBz0fB4ha97mhMPjzCnDfTcTd/GknhPXlis7J0qqXi2UdsBJm6MFY93hOKnNnZdHUbpan0ed8z+T2RmTS05+fCybYUFQfAxOOB229nLgUlC8CHpaYDzyXG/kL+Ao5OG943WX7zUOzSRGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iopsys.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vULBuE5SZTECfsZZkeQjemOsEnGw0BX4oO/n1RDbLos=;
 b=p8AX6Dn4qCjfkpCp+bPfuVs7S36gIRx4vBfyAzv7p/zZ1AKjK9kEIwyPjRyPpIxI88B3XS7UfEKffCN9FkLr1YtK/Ki79KhhgiOXgibZUtnCmEa1LlEt9ubzd/DNs8SOenzV6Cb7mW34t9KclapPPPqHf29oOm9Ly+AHBh+npaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from PAVPR08MB9819.eurprd08.prod.outlook.com (2603:10a6:102:31f::20)
 by AS1PR08MB7586.eurprd08.prod.outlook.com (2603:10a6:20b:472::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 12:14:57 +0000
Received: from PAVPR08MB9819.eurprd08.prod.outlook.com
 ([fe80::5586:29c1:1bd3:dadd]) by PAVPR08MB9819.eurprd08.prod.outlook.com
 ([fe80::5586:29c1:1bd3:dadd%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 12:14:57 +0000
From: Roman Azarenko <roman.azarenko@iopsys.eu>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Massimo Pegorer <massimo.pegorer@vimar.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Roman Azarenko <roman.azarenko@iopsys.eu>
Subject: [PATCH] tools: ensure zeroed padding in external FIT images
Date: Wed, 23 Aug 2023 14:14:17 +0200
Message-ID: <20230823121417.270511-1-roman.azarenko@iopsys.eu>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::28) To PAVPR08MB9819.eurprd08.prod.outlook.com
 (2603:10a6:102:31f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR08MB9819:EE_|AS1PR08MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc9e9ac-3ea0-43ba-e1ec-08dba3d290d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V8kIFI3GjA12KkKirOWa1MsHmWbfZeV7vH6e90rvOJ0+sszI0EZldkC+IC4HqQEMPbDqTUoRTeZoM1WYRkZNhwkZVxk9n08HL8Ah11lqsDuoadPHEF1NRBWDg9DHNQYmriGHxweoxMap/njPq3Dw+PNNm7HuYbcoasHReY/cTx8tYAFh1KaMm4zHesXiEZ5TnLRv2BjiVJq8prMhB3/vWA6AoOU9PPEk8n9lqxD9Iz3qmoOqHBRy/K+emrHlEixfQrRNg/EgHvkfvp0kC8MEhtsP1zEeCcD6CeEmZ2DqtlC5ITPramxmTmvhF/Foxq6r220nD6lCCJtJruM63eR2obiQEGbfBZ0qCRHY1nJIG43zB/BLU4mrn33xN5FW5l7igxTRPkYNUZD18dFCL6szGfqu+zdApvE0OVjEDQLIdSfIQPzdDlTZ4IJYUpLxLHcmdF19zwmP1BiWlm37Hz4dCnUlj6gL7gX8oYrSuo9LFWFuX5eBNsGjvsuPvDJXsDim/CEjUD+3uDQ0ZPM+bWFVzNELC0OJAl28xnZ+Fc6mWshDxEy/Y78VOsuLWz4nwYIP8Yh4Adm8kd25XuPX7OeI6T00t64U5geNKCZ7bceJvCNokjf39l/TR0kSrGjJDqQD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR08MB9819.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(376002)(39850400004)(346002)(1800799009)(186009)(451199024)(54906003)(6916009)(66476007)(66946007)(6512007)(316002)(66556008)(8676002)(8936002)(107886003)(2616005)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(6506007)(38350700002)(52116002)(6486002)(83380400001)(2906002)(86362001)(44832011)(5660300002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TTAlJtbYoYf9aoC16PtWdpJYbzLc5emmOV/0R6L2yUiJ5YQC4EUIjRqXfgsJ?=
 =?us-ascii?Q?GNYM6Z9VA9fCNEfbn0nPbFuCz7o4G24qzpkksbZ2kKGPiFVlGnCrbgcuUCNx?=
 =?us-ascii?Q?JPxJZEh+0y5HPLR21dFbZoZhFbFkHovs4VKbCz7vx9Fx36enUswg5wb3CD/t?=
 =?us-ascii?Q?YZ9fLlP++tM70iMQjzBzecLLknTHlLS3093mST5GR0T10tCvIbuUwrTPz9OR?=
 =?us-ascii?Q?BLx+aw7o6Ys+cMczJwPtZRKLF1XoE1EQk8gbw//l4fs2jhE7ATeRGcZwIbCS?=
 =?us-ascii?Q?snczaeUWFzJI2QzqMDPPOaOl3nApsEIIInnRB+dYnTIv/FkYnnOKMuT7t0s0?=
 =?us-ascii?Q?w4LsTwFen7U5JXxOnFZBoMq0SslxD4nfT1cERRlinyyq/maz4pD76RUJbndB?=
 =?us-ascii?Q?qoUSvyN92dNlSIIscNL9/OzGYbF7Z6V9M7By8N2D8EGk4VP0qq5CGCtOVgT6?=
 =?us-ascii?Q?MCj+fKKZA7p7r3z1PaOX1W9OQfecqaSaPSK7E2zjjMR47hk2ILk3dYGjHzGS?=
 =?us-ascii?Q?NI0xyz0bzzFTWYJ90bJyEI+GqQt91QiMjbXEOmfs5fgPUXCBiBRSVD/llwU2?=
 =?us-ascii?Q?6g/3aj5a7QQ4qae9DPSWl2gteeZweIix6Li6cML0VmyCRqsez5fv9Dd2sz7y?=
 =?us-ascii?Q?QR6qT5OXQky8vIE9iDpVBOH+sWoed1hU98dg6jMH8efvUaK7tI4iv07ndK1o?=
 =?us-ascii?Q?zILvHue1/x6+B2e1/mytobqquJhEuUCvdsJ2b1BAHN5tXDLBwHtfBAhoHc8q?=
 =?us-ascii?Q?Ud5i/R6ZCFb8yxAJMDJTZXPT4FQeqR4zYB8ipWlSPS0U8lh/s6uN5KI1ffhd?=
 =?us-ascii?Q?yo2g4NyYPXpxvNXixcNDgp6rFFIhOSQk5UbmzjOaXbRLA/mQtypECOfOc226?=
 =?us-ascii?Q?tPw5CJAKrb3SAHrOTCtbZJsNNdjKsDEVxGACNcWw/7adpvcNo21y8g6joTy7?=
 =?us-ascii?Q?6hnorWhBbcp44OSZX2l+6lAuDmGlq0YMr+4/MvDV7jEf1t+cOKDQhYMRyIT2?=
 =?us-ascii?Q?t5ApupmZ71n6JNpNO6d518EnyGbT9DiYaBE2BbXH0K8lj3VYzFyrGRc8mkn2?=
 =?us-ascii?Q?G3uj2ynRf86TP8qHmYpzOltHgpcF3fpIAfWHnOhhNYxgOd3ikRnOueIHyMMp?=
 =?us-ascii?Q?HybXK5W4fY733DS1OoAmB2w4ihxVEYePsr2L8MXEjo3Amp9buuNfc5HyaMIs?=
 =?us-ascii?Q?0BRDichfYbLGXo310VoaPvKrcNbbXZ1skEAQDwb1HrglCeiARNthfF8eHo58?=
 =?us-ascii?Q?ewa/GtifHXl2Ee2lspl+hrg7ckA5hByFT7HddR6Wj7ojtJTa5C5PhtDfzHnr?=
 =?us-ascii?Q?mMKq5mi3kyd0peSola/GoP1VzMUSULe1T07LFkeL84O1ce3gsmAz5gnOOmwh?=
 =?us-ascii?Q?ltwF8qQubWtu6SzSNTzlczwBdrtLRHxInKNh/8aafnzv2FIypbI8Yepu1mYr?=
 =?us-ascii?Q?tfL75iTr3bIxtEWvlg0COfhHOFfkud4IHnaBVKnC+OUWOG9UozQ4BMWHLQ8C?=
 =?us-ascii?Q?P/RCPGkcjP5QEfhwb4DXCEkP6kiq+ptzMvLKKaGRYxK0FQkGPK2+fyfBq6ij?=
 =?us-ascii?Q?nmROS3cZhz0OXjyM4gBH/fDMsXUM/dnHam4+hxAJE5mtIb0a60gKy4OqQIYO?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc9e9ac-3ea0-43ba-e1ec-08dba3d290d9
X-MS-Exchange-CrossTenant-AuthSource: PAVPR08MB9819.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 12:14:57.3262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ff78d65-2de4-40f5-8675-0569e5c7a65d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2q3N2UUM4U3jkfy3xSQcTSI3fydmtcd+fDT6GKSr0YcVEtid5ocuVN64EJVNf2nWkrhDX+/mSRDdL8tbF69Bk5DYzFo7muerxaQRirz0sbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7586
X-Mailman-Approved-At: Wed, 23 Aug 2023 15:45:21 +0200
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

Padding the header of an external FIT image is achieved by growing the
existing temporary FIT file to match the given alignment requirement
before appending image data. Reusing an existing file this way means
that the padding will likely contain a portion of the original data not
overwritten by the new header.

Truncate the temporary FIT file to unpadded header length first, so
that the subsequent truncate operation extends the file with null
bytes, making padding predictably zeroed.

Fixes: 7946a814a319 ("Revert "mkimage: fit: Do not tail-pad fitImage with external data"")
Signed-off-by: Roman Azarenko <roman.azarenko@iopsys.eu>
---
This fix was prompted by an observation that there is unexpected data
in the padding between the FIT header and the first image in a
generated external FIT file.

Having non-zero data in padding doesn't have any negative practical
consequences, these FIT files work fine just like any other. However
I'm not aware of any reason of making the padding depend on the
contents of an internal/intermediate FIT file. In my opinion, padding
should be predictably zeroed.

Steps to reproduce:

1. Generate a random binary blob representing a fake rootfs image:

	$ dd if=/dev/urandom of=rootfs bs=1M count=1

2. Define a minimalistic FIT source file:

	/dts-v1/;
	/ {
		description = "Padding demo";
		#address-cells = <0x01>;
		images {
			rootfs {
				data = /incbin/("rootfs");
				type = "filesystem";
				compression = "none";
				hash-1 {
					algo = "sha256";
				};
			};
		};

		configurations {
			default = "config";

			config {
				rootfs = "rootfs";
			};
		};
	};

3. Build an external FIT image with 4096 bytes of padding:

	$ mkimage -f source.dts -E -B 1000 output.dtb

Observe how the header is padded to 4096 bytes (0x1000) with a part of
an existing dummy rootfs image, which happened to be in that place in
the internal/intermediate FIT file.
---
 tools/fit_image.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 9fe69ea0d9f8..7a7b68f96ed8 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -497,7 +497,7 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
 {
 	void *buf = NULL;
 	int buf_ptr;
-	int fit_size, new_size;
+	int fit_size, unpadded_size, new_size;
 	int fd;
 	struct stat sbuf;
 	void *fdt;
@@ -564,14 +564,15 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
 	/* Pack the FDT and place the data after it */
 	fdt_pack(fdt);
 
-	new_size = fdt_totalsize(fdt);
-	new_size = ALIGN(new_size, align_size);
+	unpadded_size = fdt_totalsize(fdt);
+	new_size = ALIGN(unpadded_size, align_size);
 	fdt_set_totalsize(fdt, new_size);
 	debug("Size reduced from %x to %x\n", fit_size, fdt_totalsize(fdt));
 	debug("External data size %x\n", buf_ptr);
 	munmap(fdt, sbuf.st_size);
 
-	if (ftruncate(fd, new_size)) {
+	/* Truncate to unpadded size first to ensure zero-filled padding */
+	if (ftruncate(fd, unpadded_size) || ftruncate(fd, new_size)) {
 		debug("%s: Failed to truncate file: %s\n", __func__,
 		      strerror(errno));
 		ret = -EIO;
-- 
2.42.0

