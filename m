Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3406C3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 08:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1310982991;
	Tue, 13 May 2025 10:40:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Xh+9scgz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6453882AF4; Tue, 13 May 2025 10:40:56 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB0DC82AA8
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 10:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTuo+vsPofpGVRMQqJ85Aji/aurjuMEdAOGLWQ8XYp1js0yUR77jKQaYNw8QVrltW12MseWvcT3Z0sWwkC+V0HZiorzhwIHS7kZgAMa6K0qg+uBh7aJ+bwwe/w1A270/UEhbcgWTrBRGywkLe93aEk62dMSeVROzKcqdDMFgDfBsY8qRdEWOBJiRt7e+4xYEIxr9Yfsio6vd1n64XaFefIGRy4zB6Wm5Iq7dH8Zt5sHTXHJXjT9oLuKEUdqsfldfsSHFF6raLPLWXBBg2oKVVZqKkU1K6bjFT+bMnLjQJayZizSQNWEH/w4hfwwxYU3uXC6J8NnW2azXutC0rrySCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esvLLeBoZ3B+8RQc4BLdOyq902bWxVaE4qI5/5fmDdw=;
 b=k+4eb7L9X9MybncE4erNZaC4J4NuDA54kRJzv4necLq3IVxmskHs40f5zg687pHapfAq9i0EN/LhFfvCEdlyjDhCa8Phv5r3Op2KfktiFTWZVXBPxK1t545ng0vGfRASqmOojUVlBxIMpfQNl3LjF2uwGk1PSwYk7diWkCBapQMue3e5+LVz0nIy1YsyfDZfBvxdXfarON9qMANAMvO1ql82sVEPa3C1e9FG7WqCyNS1UWOwLdRYvB72GmdabNLBI6RLdf+A+OKuaks0QNCdZOPBXdNNpa1mRvADv6o+wWC5zVH7JvDgDUYxIStvCh8X62kzl2h83kd+d/xp5k4bgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esvLLeBoZ3B+8RQc4BLdOyq902bWxVaE4qI5/5fmDdw=;
 b=Xh+9scgzifZ0WSLPdBa7K1U5iR7tyhep1AL/YjTJ8xcmA2PokWCkQ1VpehAqKwD7YCX1gLJoCP6MB2og070Tsc2Aox+8COeoGd+E5qr1zqlT4gXepnl7Kdd9n/ZOliSvWGJXZJU5DG5B5mAAZmNtt+qCXCUzmvXVCR1tiQjXbUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by VI1PR10MB3693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:131::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 08:40:49 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:40:49 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 09/12] test: slre: add test cases for escape char in
 character class
Date: Tue, 13 May 2025 10:40:31 +0200
Message-ID: <20250513084034.654865-10-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513084034.654865-1-ravi@prevas.dk>
References: <20250513084034.654865-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0012.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::31) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|VI1PR10MB3693:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0c2311-78dc-41cd-3ccf-08dd91f9dca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1P70CnBqvG4aHVoaOPZHPTK/+qQwu0lvQjGiPj4V+tlzrYgcrqsTSH1HDzra?=
 =?us-ascii?Q?zjdfjEtWIHVX/XIoXiFLfNm2iWDGi+dtOezbpXkfI+BIL8yngdt425LhKvOQ?=
 =?us-ascii?Q?49I2iwIZwSUxxsMxrZrGhqSvoq2Y/r29G0kNHufi8hyzHvgkVQBP82IjpFlE?=
 =?us-ascii?Q?Eg0EevrHOyT6RvMUdjzhFA1er1fLXN7SAmm0JG4tyH06XCG3dO3U2U744SnC?=
 =?us-ascii?Q?hgXUrqhiUXAE6Dpmv6GwuP/JAOlxM9PsNIjLpCUSg+kJ2OnEOZAK9toTrGJo?=
 =?us-ascii?Q?0szrVD17iEGV6RgCWqWLUKmbAMby8c92tILyTlawT71aVFkYD0XLNedYeJSp?=
 =?us-ascii?Q?LQQZSulDo23fP8zexTJjYY/xwwnrpV5ZXUiPCYk3BYC5Jg9lYlxETRA/+vCn?=
 =?us-ascii?Q?KUKlfk3782qCThULIU4I3Ys2aVGRXScROqv340eaokFNZNX1SylCMIksUYEv?=
 =?us-ascii?Q?avUcSq4MjlqkzbPV2mWWis/3IESxUxmIruz455LKNTux9puxl6t8Ne7DNXwf?=
 =?us-ascii?Q?lYUVBUVSzdT5SosomV2p9OgNgpMhn8v992kO+OAfhVx5jGmKn/mNNYtRmCs+?=
 =?us-ascii?Q?v1UFKc5/nSIUP6tbtOd94NLNtHLUpOyvzNkUOSyCBR0ysP43LOH6s/doDPi9?=
 =?us-ascii?Q?GXZVR0yFPmwaxIoTCiEzqKo4qTP7UZNxckCOWmy3YCa3rkkCRH/sXVYTsmRk?=
 =?us-ascii?Q?FvSrz1oM7c9aV/WFUrHozj5YlLviMzhoWQoPqkdqoeQguWRIL9FvvsYplbTa?=
 =?us-ascii?Q?OG+MsDXqmVnovihvGkDrXS8RDe2S4eg4vZQinsCS1pT0Q0kpvjmWfYhiI8Pc?=
 =?us-ascii?Q?2a6LGBo0ttSBvOwtD200T/oxcfcMdK6bbr3a5NWfc6Y0TJFgMsTfo+x2UDl+?=
 =?us-ascii?Q?4N/AXUgGglGfcwz4R6k9RulTFub+OOPyW5qQ7lVjmj2o5EEMSD3Edlh7TYRf?=
 =?us-ascii?Q?++ccnNrDnYaufS3bBbo0I1c+R7Pg/tsoCqE1WanT7I+bbgbx9lALco1caNve?=
 =?us-ascii?Q?BNHR2sYHP1KL0C/6UyfnJlVAvsemFWJhRXTEGLh+dozHAGCu17d3myQpSuCk?=
 =?us-ascii?Q?2AWDqLkDe+PGmoFBUlWx8nVDvViSwxP+oG9T8r2/N+isJNvgVDRHlJKvKSUs?=
 =?us-ascii?Q?iYel1R/j/8ifOXqY9n8iGreq6ZOsAHvi0goCe86+IPW5N1d4Mx6VXJtvY5ab?=
 =?us-ascii?Q?QDILlkRbL3EsMC9uq3b4oaQzMB8CwvqAH00l0kcYbUeCy+6eMO1PvBPnAUpw?=
 =?us-ascii?Q?9VqQ1A4pjWzhR4zCJArC4NkhIki9F7gNcJtwV/+bUGMh4Gqe0Zv74wgyuDLh?=
 =?us-ascii?Q?STu6fq1/VkcOTSHCNVhUdMqRvNN5Ce5qnaIqB0Fbt0vYFsKGPcQy+lQjrUQa?=
 =?us-ascii?Q?J5z33FqoGmhhpC5UhTM9Liz6HjqCgSk7Asb2WRd49fujYHZdDZg8e18bfHU6?=
 =?us-ascii?Q?41qaDHs4rpEYxqPS9Wncoh0bCYFnddpD+l0awHUgD3E86wtjbSrM/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OX/IyLW4W5ua6SoiO85aeH7rDlguTVgsxGfdjzRPWm82SRKiXNqCD++p5p1a?=
 =?us-ascii?Q?g1K/EqkzoW+JOcpIp4bW3hzWQs5tmG8lQrhWrTpcq36SHQ0Cv1cpwMooBEcA?=
 =?us-ascii?Q?O9R8qfIuOIIVRoARMIoV/5GkacvrUjeUkVjjBEZ7uGJ3/vcpBBdXrdzLuSPu?=
 =?us-ascii?Q?49ZJg4FkJhVpwCcA5u7MZLSBbtuxjrlVrCFN14QSrnMm9t82Yj4hVWYvbtf5?=
 =?us-ascii?Q?CQ37i58ekeD69bL4HNIjU7CCLvGBv8+wZsElnQgLt97tEC3Jvjb7QYZgVeRS?=
 =?us-ascii?Q?E89snYTJupqg2nDBVler5vb0uqV7r+Cv4LhAfirFjnKtJz9tfaQURlYqDzXq?=
 =?us-ascii?Q?vIQSjTygB1jcNXGCQjpCXPRhQTAJDfsXC1CV6dx409mF6xBIOVfsuLrIDQPF?=
 =?us-ascii?Q?XyBOn5n9myv/Huyl89i1PmO6I+ELTBOggKJFhSoFkxpvGWPbtqVfEMGbWGqX?=
 =?us-ascii?Q?btbhBN7+jUdjtpqrtaTaq8Y3dsW8I2Ttvmr63g5mXahCakuUZklaLD6Zp1It?=
 =?us-ascii?Q?XbggYe/hsXXLPkfJwQWw6KbAyoWKZMNwhJp3wXyJLQPljEYHVg86QNYsYrX5?=
 =?us-ascii?Q?2fzm92DeYheCS0AWxsVqX0UtvBhC8Q06rMNe25wyDkCfNG39qfk1LKaNdYoJ?=
 =?us-ascii?Q?JXj2vyrraRVxtpz9xp/xpIrmYTh+9a3EPKLcVdcBe8RVbTBQqe2qIS8Bm6uM?=
 =?us-ascii?Q?dsKttZSLRlhRKI70lGYYZuVvKwue2Zs7M3ZqizEqS3jhj7EufWERHi2jOuYc?=
 =?us-ascii?Q?p862hkKlSRvgilHFb4qR9q2QmtLh/uSKX3I+8MXIYPd+eJdGcBPfVRONIR4c?=
 =?us-ascii?Q?tJWkVPOkdozVPEcgMczPhkSvB9FVHqPtH2hwULT/QGfC99W55LMMkbxrQBe4?=
 =?us-ascii?Q?+CoffNFYUEGXTgLuajmyPm5ltqEUcLzijbvCgy3SVcO/IVRVprUCIv6a62M9?=
 =?us-ascii?Q?mFIKGc1oZP+JSEOAh699H9c+UiCiKFE8Dp2nmkD18NnJ9YtkOX3AUTKwJ32v?=
 =?us-ascii?Q?nIA6dkzM0eD6tFX8YXOpY3xWtnztdQpXcaqvXbYKZw72cNQxXcwZDyE0+c+R?=
 =?us-ascii?Q?OWF7zsiXtQEiAs/8PW/2404Aklna/m5vqoSYogZZycXQfieCprpYKknnuyTY?=
 =?us-ascii?Q?mffdjmMOkAigjuMLJxpf8TU5QnyxX55ZxbT+PZIJLpgsY1Q6JHW2P8Q5ya4S?=
 =?us-ascii?Q?O/rE0pn46/Cef09TiYK1sJh7EWh0CsAzrrBPVscNEB/d+9JED+sOUq6R44m7?=
 =?us-ascii?Q?iqCoiRrKg2ssL33Xuze3ntTE86mpRIiVO8E3MfT1RfYgORSqCMbaDEoy40XW?=
 =?us-ascii?Q?ptgiJAVDxTRHchmCD3gdwKNi4FP6Y1pw0emAj+sBlVeZWH5Zue2HjCCe/+44?=
 =?us-ascii?Q?/OF85hWDZbnuXqjgliX1xSAx45eEBKylUiSPIAuL1JyTzp9757oB2HgyEup7?=
 =?us-ascii?Q?LwOCYw3h71BKqgxO3BHIW6Kd48N52Hypn6BNHtTbGv6YuEbSgz+fQcpBYDJw?=
 =?us-ascii?Q?HPMREbOuoihhHO44XnBd1ct6ET5ZCaj97p2lF/2vxrA725rcJgoCXULjeM9h?=
 =?us-ascii?Q?/ymbLzntchRCNtLpuwkjcxZFMJVnIf0Pq+IHcCTcM9u/+rPLeQ3nTyMKwth9?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0c2311-78dc-41cd-3ccf-08dd91f9dca7
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:40:49.2576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECTTUjDj8PyNdeOWf7DCI3eCzjHXTD4rSsk++/m4y5w6Hiq0ZxEOuXpwSimST10cRU2OPOZeHwrn1qU7anZroRgFDjJt9eC+mKp0Oiy/qSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3693
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 test/lib/slre.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/lib/slre.c b/test/lib/slre.c
index 9b41ea92f38..053d046075e 100644
--- a/test/lib/slre.c
+++ b/test/lib/slre.c
@@ -26,6 +26,9 @@ static const struct re_test re_test[] = {
 	{ "Gadsby", "^[^eE]*$", 1},
 	{ "Ernest", "^[^eE]*$", 0},
 	{ "6d41f0a39d6", "^[0123456789abcdef]*$", 1 },
+	/* DIGIT is 17 */
+	{ "##\x11%%\x11", "^[#%\\d]*$", 0 },
+	{ "##23%%45", "^[#%\\d]*$", 1 },
 	{}
 };
 
-- 
2.49.0

