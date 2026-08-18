Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DA2C5DF7E
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:07:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DF2380FD7;
	Tue, 18 Aug 2026 13:07:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1SWIfdwRaKKP; Tue, 18 Aug 2026 13:07:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6D0680FF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787058476;
	bh=EzGeaPztlN/E9oynWeioTqezp2A359eDtMIsCAx2FkM=;
	h=From:Date:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=V40L00QnI0ibeJ7uZMM+V6gBQB3iilJ6xCXMNlS979UKWUSD72ZNiOnlkeIBR/S+M
	 FAtwU7k3HUzw9v1Kq9qGTeTpvI4uZwOZW4nu54QZf/KpJ66LOCirg/GG7P/YLJL2qz
	 ZkZX6iFixPZK9Jdp+sy48MniaUna6YAFoMvy8/nA6ln71Zi+IONSDxe9BLVOB5zrk/
	 HuGQ1SGCK9W1x527NPq4RuMpRop96gGofvxcGi3k1H2ufY40h1e6KyobW1PPUTDoab
	 HZeHYewA5ImBmMps369Majl6WiWDi4vGo+BQ0ytQJi3m9sP7z+J8nQ5lJ/Kwx/JmdC
	 JKirD9U1zYmfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6D0680FF4;
	Tue, 18 Aug 2026 13:07:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2833F336
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:07:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 19053407D8
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:07:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1dstnidI30Ds for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 13:07:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A522040750
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A522040750
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=nHHM/14/
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A522040750
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:07:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P18SulIMntypHho7Z94qXplUNNSZalde4RGIo/ru0SqmLmuAZ97rC7RiPB6tBrrYWpb6QRe6jt51IKraTfUdyt7kZCFSgNJloPPXxfcFxD5P+uhCn/YFO/nftHpE0z7RrLUfxb9NiegS7qTl/5DZEtKG7+9zayPXBEf7nWBm70E+reUAwaPzS3nuw/TQ6B9ZEdE51845xv57j/Qky1Clpit7kDn7zThSJLMFsrDy80hCuK6qol+oZCwNvX9Tn0o12qUR5nFiqn6RHQkBHQEHkBgP4o0M3q6OgtpzdUpk+0QC+IfkIQ+HJe570PXh7WaLQXFd3DPDgz5E7+kUpa78MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzGeaPztlN/E9oynWeioTqezp2A359eDtMIsCAx2FkM=;
 b=PFnzzWhKhq9c4tSThI0ruaTGrfixy8SR0EPyPJRbDJ1rx2dawh2dv0xt8nUsjiAQFLa6NG2EeO4HrZAygajHSKMAnzD9296rcM5BqQND6sf0cmwFxVNv8O1vuT4dllpqjsw5+W5NBaDbvrsTyvlK9GcXZKDV5TknVfI/swkgVYf9R8cdno4YgJI7ubFuqXNNjmPlEWx6R1Jt20lJu5Lw2j7G1t4906yiIyUujeTgGm2HqRioaaAI53r6czq1snYEAy1AEMl/cMCg0LlkAn0nDOM3b4F+FyJDtk7CcrzILsPqVzRtJdu//f1ZzVaxwDK3QQOwHQyhGoV5nliGc7C+rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=linaro.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzGeaPztlN/E9oynWeioTqezp2A359eDtMIsCAx2FkM=;
 b=nHHM/14/e9ZFEuROaASOmSPsy/zGL2Sy6FQ7dJ8Zntlo4mNHWQDp35P6ipATP5Dj6Rxq+ludEb7PkaWute/MlGVrVz0CyX0h2eYpcL3DdFkVePUMrB8WHWJDNqbECbKvaEtKiZCvpv96EQpKmptZqX7zwATQa69m7cASP4tE0kKM6cY9yH05cmHAo0craC4w3IbmvvfSkdgfhtYNb7MfBMPQkY8f2T4Oj8kv3v1oSv502KpLyDjYbeOG49WxooOU6nDqbJADIR6FVDp0nLvyEeCSTsHnitMBeOK0JPFb4xVifAWPCUKnWZaofwRrLI1oHsnNYldj8Qczm/dT64UrtA==
Received: from AM0PR02CA0149.eurprd02.prod.outlook.com (2603:10a6:20b:28d::16)
 by DU0PR10MB6536.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:403::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 13:07:46 +0000
Received: from AM3PEPF0000A796.eurprd04.prod.outlook.com
 (2603:10a6:20b:28d:cafe::3b) by AM0PR02CA0149.outlook.office365.com
 (2603:10a6:20b:28d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 13:07:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM3PEPF0000A796.mail.protection.outlook.com (10.167.16.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 13:07:45 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 18 Aug
 2026 15:12:41 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 18 Aug
 2026 15:07:42 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Tue, 18 Aug 2026 15:07:36 +0200
Subject: [PATCH] tools: fwumdata: fix redundant metadata buffer overlap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260818-fix_tools_fwumdata-v1-1-816acb404c13@foss.st.com>
X-B4-Tracking: v=1; b=H4sIABdZhGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0ML3bTMiviS/Pyc4vi08tLclMSSRN3kpNQ0QwNLi7Q081QloMaColS
 gKrCh0bEQfnFpUlZqcgnIJKXaWgDgmjjfdgAAAA==
X-Change-ID: 20260818-fix_tools_fwumdata-cbef1098ff7e
To: <u-boot@lists.u-boot-project.org>
CC: Sughosh Ganu <sughosh.ganu@arm.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A796:EE_|DU0PR10MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: ce69a204-f48b-47ee-c826-08defd29b249
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 2gx/PDzE4rV4/06egzRyRQLGXdiQdjUoKdL+Gy5ZReC6bJgWFVIYqdK0bkVeKCe29dJdIwWm2wcmne2Zq/wkXL9c9j9IFRu3UUk+SZrRGXbQFwm9hzikuyYc0Sv7oxitAPZCholhu1VbSN4wbvH3wPpMtTXfi9ZQ80a6w5FDUPJontCAHaksaikZVGFeFJaa7Wi9/LIFLrmmrNI3MoUo7ONQP6rd2ahdvOtuGnU+Sivf+eTwp2qF5IKu7BtBGb0cl3PwkpUQ4mBoOI92F4FSAHiBTwmAA3Hu1CmnZdVqtYEso1cYhFHmp8TjV4NlfUBfqtskFGMQDkrDiquRlp1AMoVrq2KW9FwkxfbNwbgYJrxztrWsCYdk6DCYSIEBeMkk65u+8JFmhnIpzB3PX3tRb4JxinSbj46TPkfXy200KJ/N+3kLPxmuZcqqo8jrG0hiRmiIWYd9PUGLrkQtfasnJHwXjwNcy0SKGpCutQRkmb49NLTWAP2tk/Ew4WS8Xc+MCiKKRQeK9DzmCh9+Vdn0wxRNUWTWS7MIXyJS1RkSiwnIo+7uvaaKemdzG5DX46D2zng96hfEVtOKFOQ41AkIhRH7L+i4aJI1QeEIEkPza5EdD2eu2zMXVR4zANtd/6t3EWp468cGxb2b3Lku8/CNf1ndS1nqAoeh2uT3vskQzLo8tMMTRsqqXYVjfKC63z/EMvIRLqJRTltx2relhp4DXA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7LEutvTSy12PGJ24YlkaPBN34pUY7jP8p5m01JVHptSoN/Dq1Xkn5NOfrlu0INbaZv/diNnPsuy0yTY0OnsnSHVs+KRplwykHW3brOffs42P6PAvSZaFXKKl2bjVpjFIVZU3xgeoP7v1ib7xfg2ccCamNDSDVVl6nEraSPgVjzbH8/KOmv87c/GsWPaZYtuGrcAfVmGnUqVFIVssok4SNd8GFJR0wiRZkl2sxZtcTS/vubhTRLvWyddAcd/j3C9pIxRjBGE5KQoLrNxkfzQnPT2D3MobnANhiaMiWwEDiaUXaWcfh8jl5el9he5jO4PY2aUwnuwBKN5UuvkjOuL9W0KlRhtJ973zyB4ZU1ex3iXwHfmczdvT6gjZhI7TOgOKTCM1pV8SGsKwPAUoGRw5KDIqT4rTQSyIKCldDq18hc76xNJ5/Fql/QybZlorhs5s
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 13:07:45.8957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce69a204-f48b-47ee-c826-08defd29b249
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6536
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

read_metadata() allocates a single buffer holding both metadata copies
(calloc(2, mdata_size)) but accesses each copy through &mdata[id], where
mdata is a "struct fwu_mdata *". That stride is sizeof(struct fwu_mdata),
i.e. the 16-byte common header only, not mdata_size, so reading the
second copy overwrites the body of the first and the two copies overlap.

When both copies are identical the overlap is harmless, but as soon as
they differ (e.g. after an interrupted update, the exact case the tool is
meant to recover) the primary is corrupted: for V2 the metadata_size
check then reads garbage and the tool aborts with a bogus size mismatch,
for V1 it silently operates on a mixed view and can write it back to both
copies.

Index the copies by byte offset (mdata_size) through a small mdata_copy()
helper instead of struct-typed pointer arithmetic. Both copies are
guaranteed to share the same size (checked in parse_config()).

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Way to reproduce/check the issue is fixed :

cd /tmp
cat > gen_mdata.py <<'PY'
import struct, zlib
def build(active, prev, bank_state, img_guid_byte):
    version=2; num_banks=2; num_images=1
    sz_mdata=16; sz_ext=16; sz_desc=8; sz_img_entry=32; sz_bank_info=24
    per_image=sz_img_entry+sz_bank_info*num_banks
    total=sz_mdata+sz_ext+sz_desc+per_image*num_images
    ext=struct.pack('<IHH4BI', total, sz_mdata+sz_ext, 0, *bank_state, 0)
    img_entry_size=sz_img_entry+sz_bank_info*num_banks
    desc=struct.pack('<BBHHH', num_banks, 0, num_images, img_entry_size, sz_bank_info)
    body=bytes([0x11]*16)+bytes([0x22]*16)
    for b in range(num_banks):
        body+=bytes([img_guid_byte+b]*16)+struct.pack('<II',1,0)
    payload=struct.pack('<I',version)+struct.pack('<II',active,prev)+ext+desc+body
    crc=zlib.crc32(payload)&0xffffffff
    return struct.pack('<I',crc)+payload
open('mdA.bin','wb').write(build(0,1,[0xFC,0xFE,0,0],0x30))  # active=0
open('mdB.bin','wb').write(build(1,0,[0xFE,0xFF,0,0],0x50))  # active=1
PY
python3 gen_mdata.py; cp mdA.bin mdA2.bin
printf '/tmp/mdA.bin 0x0 0x78 0x78\n/tmp/mdB.bin 0x0 0x78 0x78\n' > cfg_diff.config
printf '/tmp/mdA.bin 0x0 0x78 0x78\n/tmp/mdA2.bin 0x0 0x78 0x78\n' > cfg_same.config
printf '/tmp/mdA.bin 0x0 0x78 0x78\n' > cfg_single.config

echo "===== FIXED: differing redundant copies (previously: 'Cannot read metadata', rc=234) ====="
/tmp/fwumdata_fixed -c cfg_diff.config 2>&1 | head -8; echo "rc=${PIPESTATUS[0]:-$?}"
echo; echo "===== FIXED: identical redundant copies (regression check) ====="
/tmp/fwumdata_fixed -c cfg_same.config 2>&1 | head -6; echo "rc=$?"
echo; echo "===== FIXED: single copy (regression check) ====="
/tmp/fwumdata_fixed -c cfg_single.config 2>&1 | head -6; echo "rc=$?"
rm -f /tmp/gen_mdata.py /tmp/md*.bin /tmp/cfg_*.config /tmp/fwumdata_fixed

    ===== FIXED: differing redundant copies (previously: 'Cannot read metadata', rc=234) =====
    Metadatas valid but not equal, use first one as default
    FWU Metadata:
            Version:            2
            Active Index:       0
            Previous Index:     1
            CRC32:              0x38e2fed9
            Metadata Size:      120 bytes
            Descriptor Offset:  32
    rc=0

    ===== FIXED: identical redundant copies (regression check) =====
    FWU Metadata:
            Version:            2
            Active Index:       0
            Previous Index:     1
            CRC32:              0x38e2fed9
            Metadata Size:      120 bytes
    rc=0

    ===== FIXED: single copy (regression check) =====
    FWU Metadata:
            Version:            2
            Active Index:       0
            Previous Index:     1
            CRC32:              0x38e2fed9
            Metadata Size:      120 bytes
    rc=0
---
 tools/fwumdata_src/fwumdata.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/tools/fwumdata_src/fwumdata.c b/tools/fwumdata_src/fwumdata.c
index 44195ce2bf2..f54a3b78d08 100644
--- a/tools/fwumdata_src/fwumdata.c
+++ b/tools/fwumdata_src/fwumdata.c
@@ -246,21 +246,35 @@ static void update_crc(struct fwu_mdata *mdata, size_t size)
 	mdata->crc32 = crc32(0, (const u8 *)&mdata->version, size - sizeof(u32));
 }
 
+/*
+ * Return a pointer to metadata copy @id inside the contiguous buffer.
+ * Copies are laid out mdata_size bytes apart, which is not the same as
+ * sizeof(struct fwu_mdata): the latter only covers the common header, so
+ * indexing mdata as an array of struct fwu_mdata would make the copies
+ * overlap. Both copies are guaranteed to share the same size (checked in
+ * parse_config()).
+ */
+static struct fwu_mdata *mdata_copy(int id)
+{
+	return (struct fwu_mdata *)((u8 *)mdata + id * devices[0].mdata_size);
+}
+
 static int read_one_metadata(int mdata_id, size_t size)
 {
+	struct fwu_mdata *md = mdata_copy(mdata_id);
 	int ret;
 
 	ret = open_device(&devices[mdata_id]);
 	if (ret)
 		return ret;
 
-	ret = read_device(&devices[mdata_id], &mdata[mdata_id], size);
+	ret = read_device(&devices[mdata_id], md, size);
 	if (ret)
 		return ret;
 
-	if (mdata[mdata_id].version != 1 && mdata[mdata_id].version != 2) {
+	if (md->version != 1 && md->version != 2) {
 		fprintf(stderr, "Invalid metadata %d version: %u\n",
-			mdata_id, mdata[mdata_id].version);
+			mdata_id, md->version);
 	}
 
 	return 0;
@@ -283,12 +297,12 @@ static int read_metadata(bool update)
 	if (ret)
 		return ret;
 
-	if (validate_crc(&mdata[0], alloc_size) < 0) {
+	if (validate_crc(mdata_copy(0), alloc_size) < 0) {
 		fprintf(stderr,
 			"Warning: Primary metadata CRC validation failed\n");
 		mdata_mod = update;
 	} else {
-		valid_mdata = &mdata[0];
+		valid_mdata = mdata_copy(0);
 	}
 
 	if (have_redundant) {
@@ -296,16 +310,17 @@ static int read_metadata(bool update)
 		if (ret)
 			return ret;
 
-		if (validate_crc(&mdata[1], alloc_size) < 0) {
+		if (validate_crc(mdata_copy(1), alloc_size) < 0) {
 			fprintf(stderr,
 				"Warning: Secondary metadata CRC validation failed\n");
 			mdata_mod = update;
-		} else if (valid_mdata && mdata[0].crc32 != mdata[1].crc32) {
+		} else if (valid_mdata &&
+			   mdata_copy(0)->crc32 != mdata_copy(1)->crc32) {
 			fprintf(stderr,
 				"Metadatas valid but not equal, use first one as default\n");
 			mdata_mod = update;
 		} else {
-			valid_mdata = &mdata[1];
+			valid_mdata = mdata_copy(1);
 		}
 	}
 
@@ -313,7 +328,7 @@ static int read_metadata(bool update)
 		fprintf(stderr,
 			"No metadata valid, use first one as default\n");
 		mdata_mod = update;
-		valid_mdata = &mdata[0];
+		valid_mdata = mdata_copy(0);
 	}
 
 	if (valid_mdata->version == 2) {

---
base-commit: 768a9cfb7e4f072b683ef6fd621a6f463168e952
change-id: 20260818-fix_tools_fwumdata-cbef1098ff7e

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>

