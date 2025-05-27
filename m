Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCFEC54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:24:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3513A8381D;
	Tue, 27 May 2025 15:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="UuLZHoFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E3E1837F6; Tue, 27 May 2025 15:24:37 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::701])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84E128309C
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+cNX9sfOz11dpIuCwmbHQKykwj5ljJnIX9Dz9SphsT5KG3g/Juf+m+rHOd/jYsokAAJdYor56DQUReWbcmXSKQ1rpetFr/cI8lqaYL8ymwE4ieZEgVMEiCD7ikpbMEYVAtnajgMi23Q1Y2MCwGPyDgwb2rdbHrBl6bCWVvXDsWF8MUjRLWHFEAWdWIAtgfzthGb1hzfakCtsz7WVyWBU21rgJ6UHoRf0WEoV7+3CWAHL/Osv8f29HQbm41P0VLuLqDllUnCiTDEZYDStaBnsvCMc77lsxvoO/2JpAxwK3mq0txDHriyvQQJ+B5q6f1LJPRMCLTG7bX4M8Th8Gkobg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t24YWnHO6Ftbn4cv6fdrLH2lkxNY+JOU5xOWIhzv4XM=;
 b=TPGWaPBqmAnBdZUjMecngJllNhMsLlh30hTxKX0xtu1DipPJoBgb55RTP0TnOGBcJohVRzUnMenIeE5b0WY1Y4+HadFwPkvEfNGHcD0tng3P65bxo8MCoXMnkxecVsXD/wVs9/ac7S6Rhwoskbf5Ao9SSjDM6H3/H5KW+NVFlWDT29kc6TkPiDlB7mpzm3QzuPxiaXNYcKSrXH8NN7vAusyl3lcvs06ZPolu4+rPZeQ+aOV5187tQ/CjUI2MIGhaNRjtYZyfoGVxn4k4uMn+ekkAsUP7jTCEoLZlwx1vjnfMsdcgbW5lZihICisgeN6IShxpDgXvnNhyQOWDAVaOJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t24YWnHO6Ftbn4cv6fdrLH2lkxNY+JOU5xOWIhzv4XM=;
 b=UuLZHoFbwjZNnFbpsmZOqXXag+St29w9QE/T9MNpbS06mMUd5bmEIGSN+tzS5Ap9FiutRSI51KrYaGkIWcfeNdxkP9uNueBqY0ANEjyGDLRP1+CzON6afTqHWqfaLUTEHSOZA/6AD0nHDqZz1ICufNahTEX0QcLhDL3F6CiNnQv1jDXLAD0tq2AJ8ADcP+nxKPmbqXj89VUo2HixHFbtH6OtMaPWVEepNRwfmXDLgywiR0Y+jP1XDgpTk5FpDSfmuBVhuhE3LoCVSEvyR9P72uZRkuJ+sgEBAOXe7q1Pho3nSxCLUYr8PvuR0HwFmTEy142JlRQ4Ig02dzwDs9PA4w==
Received: from PR1P264CA0020.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19f::7)
 by DB9P195MB1274.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:268::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 13:24:32 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:102:19f:cafe::e6) by PR1P264CA0020.outlook.office365.com
 (2603:10a6:102:19f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.24 via Frontend Transport; Tue,
 27 May 2025 13:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 13:24:32 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 15:24:30 +0200
Received: from llp-moog.phytec.de (172.25.32.70) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 15:24:30 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 27 May 2025 15:24:09 +0200
Subject: [PATCH RFC v2 1/8] tools: binman: ftest: pass allow_fake_blob to
 _DoReadFileDtb
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250527-binman_faked_optional-v2-1-3362ab897581@phytec.de>
References: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
In-Reply-To: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
To: Simon Glass <sjg@chromium.org>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748352270; l=2504;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=cXud26pCpz1PZ9P61VSYokdhvZyIxf9OYYuRHOFQRWU=;
 b=LB76WlDn+R2nFtJPdslG3rnJl1SWqpjpEIsXZDbFtmeIarPAOqz/+3ztLMRO3D9nGtLhKpWB9
 N/5+vsEdI1JDi3yRU9UKY8WtYYf7MesaVrbtGUwjNMdYItkjstsUiFO
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.70]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|DB9P195MB1274:EE_
X-MS-Office365-Filtering-Correlation-Id: 105a1c6c-7b9a-42ce-4576-08dd9d21d12f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STNMV000WWh6bmFnL2RRbXNacFg4dXh1YlV3K3BFbWg1d2t2QmtrcUYwV3dW?=
 =?utf-8?B?ZlBZT04xSDdWM3BwbENVdHVMWEpRVC9YdGpSWXo3bVB4RkM1akxpbDBodlBm?=
 =?utf-8?B?UjJRcFdSTjVZVy94SUNzREt0N1BsY3ZtUWNycVN2VGw3aittSGxrMTdhMFBK?=
 =?utf-8?B?alJBV3Z3aVVTOTJqK1hHcDVva3BiU056TnFkRERZdGVWTFBiUjhoRXVpVGpM?=
 =?utf-8?B?N3ZtWnU3TmVmcTRIbWlDRFJ1cUtpcnlYU1ExUFN2YlBLWHNGZ0sreC95aUpt?=
 =?utf-8?B?UzVmdlJGM0RCRmhjQ3RSMEo1RXJzZ2xvNS9xRFVuR2lPNFFBRkZYSDJuQWo4?=
 =?utf-8?B?cjVlYzhzVzJ1V0huMGFCRy8vUmNHOE13K3ZTMHFmNFhhWkZ6ek9PRjZYNm1K?=
 =?utf-8?B?RURBaXR3anNrVFVWc3p3SnlzUGlwZmNtZ1VPczRXRTkxNjlkcXVKQ2ZpTm1N?=
 =?utf-8?B?amYyVXJubHYzWWpEVHlUckh5ZkxSZ1ZCYUdhSmtlOUw4akcvNVJOT2JjMEJ2?=
 =?utf-8?B?Z3JYcUJ0dUhIOUR0ZkFBWk5HWmdEYjJaMmhpTXIwTk0vY09ZT3p2eE5jYy8w?=
 =?utf-8?B?L0UvWXpiQitXb3VmeTNIMU9uZXhFQzVINGdLRCtGcWMrNFA5K3o1b0NkL0hk?=
 =?utf-8?B?b2tYNUM3ZUM4WEVYRnQzaXNubHVsc0lqR1NvMkRvaWd6cUVlMGRmUzB2MWsy?=
 =?utf-8?B?anJyZm5ucnRoNWwyVkp4U2J4TVlYNmZyeW9tcm9FSEIrZDFmV0hJL0Z5cmh0?=
 =?utf-8?B?dE1xb0tmRVBBTzBEM0hzVmtDQ2pPdnRnekFxVGhYN3JCVWhpcjkxN1VWbGQw?=
 =?utf-8?B?SUJOTlIyN2UrcytWck9ZQ3dZNk9TTm1sTDVyMmFFaHNlM1dBOVFCb1hCSjlQ?=
 =?utf-8?B?OUp6ZlVETHM3eU1RYk52Y1RkUThpUU1MK291QmVxaDludGlaR0hKR1Z1bkJW?=
 =?utf-8?B?VVdHV1FBM05xTGxTdzZTTG8yWTlSS3J2MXRMb01RYnQ1cXdkM215MFFQTjky?=
 =?utf-8?B?U2RjZDdEMkE5RXV4L3RMai9rbFUxWk5sc1ByTEdwTmZXbU5JZUo5clp0MjJ6?=
 =?utf-8?B?KzNMTFBFdjUxaitxV3VPMVp3bXh3T2JIUG1UUkQ4emRCbTNKWC8xZVEzbjRk?=
 =?utf-8?B?a0lYTjdQdlZiamp1b1RHbTdJTHNwVmovM2dOY2JBSG5vN2p2M1dpNmU4dVNj?=
 =?utf-8?B?Ujd2VnpDeU1wbEFjYXdscFRoaXZZdWZZRnN6bk0vWURHS0tIQXNVZlpVdzRk?=
 =?utf-8?B?ZDd4R2RjMndhZDlRQWFRb1lMdGhjMzNONjJPZGRaVlY2aEtwM2I3aGMwbEdW?=
 =?utf-8?B?dUNBRGdpUGFrQkFiRWlRRW1HbDVSNSs4Y1RRTS8wdncvQ1NHWTNnZXBaVCtv?=
 =?utf-8?B?dDZpenExUXBWYTRuSGV0amFZckJ5bHl0eU16aWxYanRiMlh4MGNlMThUUTJN?=
 =?utf-8?B?TDdNQlh1VEQyV2x0S2tXZExDVFR4RERvZ2lwazVEdTVyVGkvQ1BJQzh2TThE?=
 =?utf-8?B?KzhZQ2V3NFdQVjAxSHJxRnpTK0QvcXlOejFjSmwwWkZnMFdQMkoxOHVpbWtN?=
 =?utf-8?B?dDRRbXptZDZPckNXYkY5RTh1Nm9FUDNGbE56L1NSNnJ5ekRGS3JXVTgzVWlt?=
 =?utf-8?B?SDJleXQzaHJlVXBqTUdMejdOMit4M2JHSzdlTzdQWkhXVEJwSE1zQnE2a3Jk?=
 =?utf-8?B?VjdnWmZJeXNRWVBqa2ZTdkEvVHByV0svN1B4QTBHdHN0ZjF6RWl6dzFNaDM1?=
 =?utf-8?B?VVhNM242VmhSM1pzZGRBY2ZhVXl0MlNzVTRJSEJtZGRvMm8xZGc2Y1NVczRB?=
 =?utf-8?B?NUlpUUdOdWlFVThyd1VaM0ZwRzVMTkxJWUtIb0xRREhMd0xreDhKUkM5TnZI?=
 =?utf-8?B?TVFjZCtLSHNsNkNxOXdRRkdIWFNlWmdQdFZoWGk3V3VTTnMzSXgwVjV4dGdw?=
 =?utf-8?B?OTVSTlAzdGNPVzNzSUxGZVV3K3BTQ1BqNHhrMVlJU1hBaXJjcGEwcENmNUtB?=
 =?utf-8?B?NHBWRVRQa29ZZUR6bDU3VmFaZ25kMEYvWU5rVEJjVFJkeXFKbDdGdjV5aWNa?=
 =?utf-8?Q?bhqxbP?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 13:24:32.5085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 105a1c6c-7b9a-42ce-4576-08dd9d21d12f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1274
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

Some test cases don't use _DoTestFile directly which accepts
allow_fake_blobs. However, they specifically test functionality that
requires external blobs not to be faked. Extend the _DoReadFileDtb
signature to allow passing that option to _DoTestFile.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/ftest.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index fa17490001488a297090a65c0c099ecc9a40e0f8..52f0a729bdab0a0bd00f798bbc07d678dd4513de 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -510,9 +510,9 @@ class TestFunctional(unittest.TestCase):
         return dtb.GetContents()
 
     def _DoReadFileDtb(self, fname, use_real_dtb=False, use_expanded=False,
-                       verbosity=None, map=False, update_dtb=False,
-                       entry_args=None, reset_dtbs=True, extra_indirs=None,
-                       threads=None):
+                       verbosity=None, allow_fake_blobs=True, map=False,
+                       update_dtb=False, entry_args=None, reset_dtbs=True,
+                       extra_indirs=None, threads=None):
         """Run binman and return the resulting image
 
         This runs binman with a given test file and then reads the resulting
@@ -530,6 +530,7 @@ class TestFunctional(unittest.TestCase):
             use_expanded: True to use expanded entries where available, e.g.
                 'u-boot-expanded' instead of 'u-boot'
             verbosity: Verbosity level to use (0-3, None=don't set it)
+            allow_fake_blob: whether binman should fake missing ext blobs
             map: True to output map files for the images
             update_dtb: Update the offset and size of each entry in the device
                 tree before packing it into the image
@@ -567,7 +568,7 @@ class TestFunctional(unittest.TestCase):
             retcode = self._DoTestFile(fname, map=map, update_dtb=update_dtb,
                     entry_args=entry_args, use_real_dtb=use_real_dtb,
                     use_expanded=use_expanded, verbosity=verbosity,
-                    extra_indirs=extra_indirs,
+                    allow_fake_blobs=allow_fake_blobs, extra_indirs=extra_indirs,
                     threads=threads)
             self.assertEqual(0, retcode)
             out_dtb_fname = tools.get_output_filename('u-boot.dtb.out')

-- 
2.43.0

