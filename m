Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDABEE6457
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 12:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F30C86785;
	Fri, 15 Sep 2023 14:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pioCMdrh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CA1C868D8; Fri, 15 Sep 2023 14:12:24 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACCE686824
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 14:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8Y247Ch2NRIQ3xm8CRT1xMDRIRcVOvhT+pFG/YWHe454Wz+T4b7QxLJ3zyP6Xu8viIszd46icPN47FIjreSWH0heUBtqpsJGc0QqF7eJafUUw4lT5WXPFv4kGdnZKj4KLM1cowv854b9z6eikDfMH9LICnj0qNAaQIOurKcvSpwUamY17eoH/WKPffTu752tnvTpxANDO2vkZen8cZsZYJFiUQP2vn7QqPnwo1WPGzM9zS3d44JLocKmc4a+vFKpdU/bcNKdnIiqqPSe26zHmYmLzc42cRed5kdGNCvZyTmh/7ORDPYFnZRBGucB9WExME+QSlI8B11PzWItiILBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qSnWD/Putgu8hsN4mdlutawpbvhZq4QKyVDRxzs1ZA=;
 b=BayUOol/4w9lJhNH/UYp/pDyeQquJPQD7q6AmUjHsK7djLRj5WlGhhMfM1FAMM1JPypZchAGlRUPdmMxHtepo1psU+FCWcbU0b3QrVf4/01hq2C2R/m4WsNGzbnIQifdDyO7HoqmUEjXCpm7bfv8Mejs10sStl2PSiD/DNMJOETBPX0yjU1ZJtsCnioqi7qiutTwvYimpkh60OyyP+eudd4mBUUdQfzCxjwPolZ1dYNynljxJ/cvzv7iOZIbQfZKFW8Vd5V1yPaUGih32DzXk4lR/x1FcWNIwxQ1J3UVGfWAy8cdxU+BURUxxhRphC9NdavoY7pV+YDXuWxICO/PiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qSnWD/Putgu8hsN4mdlutawpbvhZq4QKyVDRxzs1ZA=;
 b=pioCMdrheMmkVH5r8WW03zoHBTZfrD8BqbgVhBrqRM4ydGrvvdyGRFheP5JTYHwZ1Yas7gtMCXgQxf5FAirp+WxseD+6ycL3uP3wz8IUu3mxkX2AMTibqh4svfOo65n5xyCO1alOz9FEnP61pA6/tQUxBKiKv1XOl+CuQO21yFM=
Received: from SN7PR04CA0016.namprd04.prod.outlook.com (2603:10b6:806:f2::21)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 12:12:18 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::e1) by SN7PR04CA0016.outlook.office365.com
 (2603:10b6:806:f2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 12:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 12:12:17 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 07:12:12 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/3] trace: Move trace_clocks description above record
 offset calculation
Date: Fri, 15 Sep 2023 14:12:04 +0200
Message-ID: <d3853d91b6fa7e3a1e5c24dd3c17335cf0041b5b.1694779918.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1694779918.git.michal.simek@amd.com>
References: <cover.1694779918.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=2zAte8RzgGVXGkr3xPZeWkakmw7ahsNGPJ/xxp9qP90=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQWL+Gyes4nKkYHVNY7MFcfK6vKFq6/5vgxlCdp9r2H8
 x+3SVl1xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgIn8X8UwPy1n+e1GHgf+7cw6
 cxMfVoskRXyfzjBXgO3J+gyZ1uBQpsd7J0+6L7n9wPwtAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ccaac6b-8464-4470-fe46-08dbb5e5016b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMK9phhj3Vkm1/DJed5WaxfqGy2Og8T6U6mmzjHkcTNkh8xSXbvBfA3+vBOdWocSp7B2UrCQZpGH586y8SJehy7M2DNSKu8fJMGajcyzjOSD1T4w16A5G5pcbr5EYJv0e/m0mRf4x9xz/R0AsU50ATYMe59ToADwyeU7cf/3cQIeXYgOaOmmGQtstg+5J0ZLq8eEajkQpOO4dIfcaApsEkZ8VH6bM0LDpUQl9ikwG9/d3qspPMQMZH4CvL28wQdI7z7OLSLwNpzS1uB2wBqYrpUDnrguwMrfJlxtH8FkAc+LeqNAOIN85JfNPaADqDB0kr3AqA2M9uLc76lW7375FBJu1Lur7MLwKxQ/uEpxeBxbd9TNsE5ok2LX0IcpyLjSWK8SU8iSgv1kyfO87y5e512t61THB1iHv4bvZ0GrO3tYggCTzSLHlV6t8mZZQDP5dCwCQcaKXvVqOxjgQM4k86CdzMjnbkPsCx3nd4qzDf42F/j7bmOSwv6YstVM1Tv9JTH5bSzGBQSpu9VWRryqtVt0tgHbTvV2OYZEwxZWll4q1M9srDYVZu4qI5+p0fI5J1XZdSTqTrTyH6V4nNZ69vur1D+jfp3F3OFoBUrGMCMlsCQdS/t2yCtCicP3qGJAxYo3ENP40TZGk2ayI//UMuyRiyXMLNhrmOPqem05de54kZQ+1c0nId9ZQQBraWpvI5degecVwKMgP6S+e6lCi7KtnmcQkAQIKL5RcosO51qx/YPs3oiBDxxRliAe3xGj1F3Yrvtyiy92v4mUqyhlFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(6666004)(70206006)(478600001)(26005)(336012)(83380400001)(2906002)(8936002)(16526019)(8676002)(44832011)(70586007)(316002)(110136005)(5660300002)(36756003)(47076005)(40460700003)(426003)(86362001)(36860700001)(40480700001)(82740400003)(41300700001)(2616005)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 12:12:17.8425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccaac6b-8464-4470-fe46-08dbb5e5016b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
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

Flyrecord tracing data are page aligned that's why it is necessary to
calculate alignment properly. Because trace_clocks description is the part
of record length it is necessary to have information about length earlier.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/proftool.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/proftool.c b/tools/proftool.c
index 869a2a32c510..7c95a94482fc 100644
--- a/tools/proftool.c
+++ b/tools/proftool.c
@@ -1500,6 +1500,10 @@ static int write_flyrecord(struct twriter *tw, enum out_format_t out_format,
 
 	tw->ptr += fprintf(fout, "flyrecord%c", 0);
 
+	snprintf(str, sizeof(str),
+		 "[local] global counter uptime perf mono mono_raw boot x86-tsc\n");
+	len = strlen(str);
+
 	/* trace data */
 	start = ALIGN(tw->ptr + 16, TRACE_PAGE_SIZE);
 	tw->ptr += tputq(fout, start);
@@ -1510,9 +1514,6 @@ static int write_flyrecord(struct twriter *tw, enum out_format_t out_format,
 		return -1;
 	tw->ptr += ret;
 
-	snprintf(str, sizeof(str),
-		 "[local] global counter uptime perf mono mono_raw boot x86-tsc\n");
-	len = strlen(str);
 	tw->ptr += tputq(fout, len);
 	tw->ptr += tputs(fout, str);
 
-- 
2.36.1

