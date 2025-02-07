Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A080CC02199
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 14:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECF6580A2A;
	Fri,  7 Feb 2025 15:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="DFiL5lRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F72380737; Fri,  7 Feb 2025 14:07:07 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F7E780207
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 14:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Daniel.Venzin@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqHzadV2bqr6g7qmTz9uDL6c1flR9Yhz7Q1CLb/OvXYP6jOuRW/jxN16dow1o7EzqBs3iy41J9KodrNTy0+PLB3mVb9qCmyTyW5AbmbuiOU98vNygTMOPb8beFvrekLcuujPFv5Jd9M/lGW/pNTLX4F34NcPb9/sQqbs6tRSJlH/Br8Vz7doeh4ON7fnIfNJ0I0CxwjdDodGLb/QFzzd8AG9+UAyr2Yg9dEtT/bDIMx6IIg9Kb/zsN9SdOWakp90AqDysxZstR1iGx9VMfeX/ncpOnyRNRlURfbu8XyVVLpBwx3K99JrLgP09QG+GFUyNa0wzKLZqD2aeZDHpwdh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osus3f1LoiXLfLfsUHSxIRf5afuA0xG/bMMyGOjEcj8=;
 b=h50PCU6H87MU4iBTpj3PytC1AHjJo+pFwm9YtY60wNCy8wJKgQTpY7/qeFaBfDL7lwRnsM2qa5gkQJ8EhCYdQeE9ggE40Fkj0tNXvuAD3BWzuUHcQIaWHRCtmNT7tptIkvcGgExBxYwXR3TkhQOaDMMULIAERfL37qM5FaXXysssn+G/C+Xq1M5ryxAa708M9SkBhArZn0obREt2MFqOrWmHgyKgsojMTJWzeMtrhDAMKVt5HzoPuPtUyQz+T+tyAPUtydlOxiwLWbebj0VtXvvOoOX12uJ8PNuv0JQQ/A1psHp9tNFvzNL5Ox5EkU7JgrOXwd1wsJtHZ8xPwZDM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osus3f1LoiXLfLfsUHSxIRf5afuA0xG/bMMyGOjEcj8=;
 b=DFiL5lRRRjo9rwmHIU2kPsRmZypjTZRuRd+0Uy4V5QuN4yXbhKNVoRkwlPaVrIZGWKCXAlG/7l4eQ6Bg6OhDrWYBBhmUQUs2KRCPOnheSNT+lFc6ZMv4xmzOuvAjlKuGIo+mL7Uqhk3MWHV7cWC/AyBoOGEuRrGNg4lP/vEwPq8QR0BAFduwq7fQIIWkD1FlLx5BpPy8cotWr9A3w7sfwqKE3VxHhUuGnn6RK7x4+ZoqijZDkxgTe3YzCNIv8XCrKwpsfGFDjXqdii5U2flwZU7hHG94MlQqyjeVajLj7aGpdpNdkFW7IoCcov8k5MK5tbxCqJSlO4etLMfWY6Mk6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com (2603:10a6:10:d6::15)
 by DU0PR03MB8462.eurprd03.prod.outlook.com (2603:10a6:10:3b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Fri, 7 Feb
 2025 13:07:02 +0000
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4]) by DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4%4]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 13:07:01 +0000
From: Daniel Venzin <Daniel.Venzin@mt.com>
To: u-boot@lists.denx.de
Cc: burak@gerz.io, gabriel.dalimonte@gmail.com, Manuel.Traut@mt.com,
 Daniel Venzin <Daniel.Venzin@mt.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Richard Weinberger <richard@nod.at>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 6/6] test/py: fs: Add fstest/rnfile test
Date: Fri,  7 Feb 2025 13:45:23 +0100
Message-Id: <20250207124523.85026-7-Daniel.Venzin@mt.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207124523.85026-1-Daniel.Venzin@mt.com>
References: <20250207124523.85026-1-Daniel.Venzin@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To DBBPR03MB5352.eurprd03.prod.outlook.com
 (2603:10a6:10:d6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR03MB5352:EE_|DU0PR03MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: e9afae8b-39d0-4b9e-48a4-08dd477849b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9k79kkAuBgmJrY1GkEMF1ez8Q2XIzVOIhvt9MyJ5bRZyFFJKvLCg3wbwgj92?=
 =?us-ascii?Q?VmdHXmPEU1j/WCYj0B1GFiSRPQkcNj6uF+Aca9lp1BsnFWtDRepwsEH/yXWJ?=
 =?us-ascii?Q?rFoLrxWx7mNpzA2JBlnWyOxB1RpIAvWfKu3nBAdB54mBQz8+Wbm49ETrPV/h?=
 =?us-ascii?Q?snNFBpGCgVt5jky1bKWJK2hh0eL8wVhWvA4ZXvG80usOHjZFyY0GhQK0WYZw?=
 =?us-ascii?Q?2rushA/eJIwfcM+olS733UYNXk65oux84l22gJ0NFr9uc2GwljK1ihHMapps?=
 =?us-ascii?Q?LCuX2lkNKllet+UpjBP90F10KHb4Z2QsBq9Y1BYzxDGC8KyvFs417O/QQiY2?=
 =?us-ascii?Q?ClN2HaBIkyhFj+Z3ji1yYjixFzQOA+3cPMrXW+2TM+sMJIQZq0Ss6C/FkOfY?=
 =?us-ascii?Q?4sioHJRNq09e3rD7+gxb3LVfw4h4dto6MXvP2liesusY8fcXd5XBTTCul69S?=
 =?us-ascii?Q?gbbiVcdby7ZuY1pceKl7ux+xsVCic3cUHAdz2adhKEef5ntlGZVxJFimBGgG?=
 =?us-ascii?Q?BJ1GTCU4JLuGkBjpYZPGBfRGrQZajet5K2FpCJZZ9Quxa2ojSIVUvV21+cTX?=
 =?us-ascii?Q?Zs95ZWccOSmbDy5Q8IH1rMqkNvn5w61Lfgaw9p5OTdlRrbzsPrWKAscwja74?=
 =?us-ascii?Q?Th77GSFufjSiwqml8XYfjvI79/ZmFoV0PwfaXfGlYEb3VdvD5+zEZXjjel7d?=
 =?us-ascii?Q?+gY8vKvWucceCVV2zoqbjxddyp4d1X/u+pqnF6umvBXfv6ugh4ocgTdlBhfL?=
 =?us-ascii?Q?wwExCu00bsx8sGc2qDiN+vdFZwGHZkpniS8TUVYik61BEOzjcyZpByBjQqL5?=
 =?us-ascii?Q?Vl4RNJfZ/czTYmVk2BAyxCY2E1VXNp8KTGSImM0/9rTJ8vCKiK16IMJULuMF?=
 =?us-ascii?Q?NoW5SGTQPn1Oj6H8PFUoSKxt2lTvHadAMmDSNLo3NFV/OcSAw0uJMnLFMlkb?=
 =?us-ascii?Q?+C07EF2W/Z+o2OruESRieaKVEfEz3MJsvpiqz8IgsWpSrcIa2Yjz2CPqnI1A?=
 =?us-ascii?Q?Z0HZ58112DpU9WFKHGrxHVKVcxTubVbbB4keqwcMaVOV1zvIOeUeppExWsyH?=
 =?us-ascii?Q?JjxoaJAZqKENYSP1KWjWScr+K3toPadMD0spGMjllw1xFU4kkwdDAdafY09J?=
 =?us-ascii?Q?I7PwXazj0dVk+t4MIWVsy+HN7hjtlSA1odSezeXn9z6vnuxSRZ7pcfowd2Mw?=
 =?us-ascii?Q?JrnPr/frQiALB/GvfcDpV6bkaYU3J/DcSMg+Q2lt7qibY7kfswY4rZfy6fVL?=
 =?us-ascii?Q?qXROsS61mlbI2F81jVSa1sUKe0S+w3ggt+03aifYulMU65ZwQHa5cNCY4RD6?=
 =?us-ascii?Q?Nsl9CUChlXTAKl1yBHUyiQF6ETRyshwe4TMZx1fGE8MzrvLjxm3d3w1aiuvk?=
 =?us-ascii?Q?+1wlg1xHwRBfntBVWzhj2PCrJ3DxC/Zat2FUBtJxI1nyD8Hm+4JKTl3CXQDt?=
 =?us-ascii?Q?sWIk8dIb+k/YVHDRMZIvmmE3eseN2VEA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR03MB5352.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Za6sBNAX/yIXLKsvm5rVETvOWnntWxBuQmkxqd7WHVFIXdIXI+bDbrfn3JRX?=
 =?us-ascii?Q?0x5Mmq/FOSPT4gzR35mN5fJwwCeBsRn8fuKJA+e0lVo5F3IY0dD1CDZ20qBA?=
 =?us-ascii?Q?JZhPOpq8C25p7ZxuCmMHi8Q8HfOzRlOqgEE4yX8yWTjkePM9m5bOdjWE1M5N?=
 =?us-ascii?Q?vLrnZh0zRbefvG3HFh0hNdFMXcQSrTqic8U3Q0uV8QIX223zgXfRKk2E2Ap3?=
 =?us-ascii?Q?9h/Wrml58WGRFwULrvW9PQOrpzBODWho9fz2imfkjbRrM68vT1kbnRzq0PbE?=
 =?us-ascii?Q?QCLe6RIP78/PdApTIeEK/blkc32bI9y1dZRW4C+rVTGCmy294r4hhTFlgbzj?=
 =?us-ascii?Q?aEY8Dabhz/AQlYAgp/BqR+aBsvrmKEPLkkA3KSimphnLp8GTu8+k+BExJdPB?=
 =?us-ascii?Q?y+1QWjIc4C6q2d+2+381yVMhhzF4trSNeYnZM1buKDPMQgb4IQCEQZHDkq2/?=
 =?us-ascii?Q?+sYx8yUJNS7AwpQMK36fZB/kP6vR7T2Iqi5EUbkOSYFR+eLpqAm/bm1BrnNZ?=
 =?us-ascii?Q?BSVnkc/RaWAKZGZQliTaG6s8FSkClY3DN9cVMKjSvVQ9XFRjUSE1eugwPGZH?=
 =?us-ascii?Q?79GPHHNEqENCqlhEew5qI74I967aXV8+rK3A/94tU5724UR1ID8Fzome9WBC?=
 =?us-ascii?Q?QlBoxPlIlSlTu1h+kviGjQcQ99OAiWgLUcyVfaA5LEuHXkLVEY33K7XXN/Rp?=
 =?us-ascii?Q?3B9po2Q0BlNVbYDHjlgUX+cFPipexwl60aYzwCZkWbXPqw5by33IvlVxE41C?=
 =?us-ascii?Q?+LywCRpyocFbiwj7Xk5DwIFOG1HVm5/ImIy9uZD0w81lTcH2xeZGXqm8U3ic?=
 =?us-ascii?Q?HYydDL8M/DjXbSE7jds1wDpZwAktS4rbFcKV+8bChirYeKLKQAMbWzqWQz+Q?=
 =?us-ascii?Q?k2WwfaihBp1qQ9Ohbwj/6vD/wHS3kVqe7egU9Fi/PhUZ86AJ5HVqtfmZEGzM?=
 =?us-ascii?Q?nhyUcNjujgPto0sax1CLrjePC9vk6Jz4Qo2mdDSEr96qjsfstp4Ww1xGvyz3?=
 =?us-ascii?Q?aK0jHWUkSWDcnniZVkLkYC0qKwYt9JUshXQbEtfct+3DWdoOx85SHxyMc/eE?=
 =?us-ascii?Q?c9uigI0HS7Vy/dlzrT7oXvzDNKrcUSblWg4EE0xGG4LvbWzadzHzqjYVNakE?=
 =?us-ascii?Q?bE/c/PIEt7hrmLc40U9DaJ0tAatNEtgKEEY3yLOExy3voOMpuEfN05LuEbaq?=
 =?us-ascii?Q?8ZCwjj1Cz3+eGTupxGNoOqbHApCqjNGVpwR2yJn/0dqopsewDmixipSlIWFC?=
 =?us-ascii?Q?4BBeJVXGYgPiJCjf2/camN3A1lqWwPtDvuOjVIn4emW+8s6A6rogVrO2R2MM?=
 =?us-ascii?Q?zLx6PD0n66jrlV+J5BRi48s+9JY450Qr9/yY6WdEi7TJuUOcR/w05oVZXyKg?=
 =?us-ascii?Q?E+gW6IagGnNEgSG1ke1OWS/hzn8xc0dkFd8eW8tunQs3lKAJWMtDKApe4IB6?=
 =?us-ascii?Q?KsL9G77T2o6ymrqrwCrXeEnEZyZzxso8+ZE+kfMpiYamEN9UaTWpEPecbKCn?=
 =?us-ascii?Q?OETib0WOvfV8blmNb3H/LfDQ3FaNaoIsiW49PgeWP+C7KeZp2IKQ8x1/WrQs?=
 =?us-ascii?Q?NEvmpXrhOev9DC7zmTCb6+38PehB135ouQKRy7zc?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9afae8b-39d0-4b9e-48a4-08dd477849b0
X-MS-Exchange-CrossTenant-AuthSource: DBBPR03MB5352.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 13:06:51.5387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6xE9gnhWQV1R4Y+UJ6haqhTOptftOiXIw6BJGZdLyqVUmC3mE8KkcX/db2EhS2AcrzTcu1h1BJXnZJTREIE6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8462
X-Mailman-Approved-At: Fri, 07 Feb 2025 15:27:24 +0100
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

Extend the test_fs test suite with tests to verify operations
related to FAT file renaming.

Signed-off-by: Daniel Venzin <Daniel.Venzin@mt.com>

---

Changes in v3:
- Verify FAT file rename functionality with unit tests

 test/py/tests/test_fs/conftest.py    | 75 ++++++++++++++++++++++
 test/py/tests/test_fs/test_rnfile.py | 93 ++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+)
 create mode 100644 test/py/tests/test_fs/test_rnfile.py

diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/conftest.py
index af2adaf1645..e9b08c693b2 100644
--- a/test/py/tests/test_fs/conftest.py
+++ b/test/py/tests/test_fs/conftest.py
@@ -16,6 +16,7 @@ supported_fs_basic = ['fat16', 'fat32', 'ext4']
 supported_fs_ext = ['fat12', 'fat16', 'fat32']
 supported_fs_fat = ['fat12', 'fat16']
 supported_fs_mkdir = ['fat12', 'fat16', 'fat32']
+supported_fs_rnfile = ['fat12', 'fat16', 'fat32']
 supported_fs_unlink = ['fat12', 'fat16', 'fat32']
 supported_fs_symlink = ['ext4']
 
@@ -53,6 +54,7 @@ def pytest_configure(config):
     global supported_fs_ext
     global supported_fs_fat
     global supported_fs_mkdir
+    global supported_fs_rnfile
     global supported_fs_unlink
     global supported_fs_symlink
 
@@ -66,6 +68,7 @@ def pytest_configure(config):
         supported_fs_ext =  intersect(supported_fs, supported_fs_ext)
         supported_fs_fat =  intersect(supported_fs, supported_fs_fat)
         supported_fs_mkdir =  intersect(supported_fs, supported_fs_mkdir)
+        supported_fs_rnfile = intersect(supported_fs, supported_fs_rnfile)
         supported_fs_unlink =  intersect(supported_fs, supported_fs_unlink)
         supported_fs_symlink =  intersect(supported_fs, supported_fs_symlink)
 
@@ -93,6 +96,9 @@ def pytest_generate_tests(metafunc):
     if 'fs_obj_mkdir' in metafunc.fixturenames:
         metafunc.parametrize('fs_obj_mkdir', supported_fs_mkdir,
             indirect=True, scope='module')
+    if 'fs_obj_rnfile' in metafunc.fixturenames:
+        metafunc.parametrize('fs_obj_rnfile', supported_fs_rnfile,
+            indirect=True, scope='module')
     if 'fs_obj_unlink' in metafunc.fixturenames:
         metafunc.parametrize('fs_obj_unlink', supported_fs_unlink,
             indirect=True, scope='module')
@@ -388,6 +394,75 @@ def fs_obj_mkdir(request, u_boot_config):
         yield [fs_ubtype, fs_img]
     call('rm -f %s' % fs_img, shell=True)
 
+#
+# Fixture for rnfile test
+#
+@pytest.fixture()
+def fs_obj_rnfile(request, u_boot_config):
+    """Set up a file system to be used in rnfile test.
+
+    Args:
+        request: Pytest request object.
+	u_boot_config: U-Boot configuration.
+
+    Return:
+        A fixture for rnfile test, i.e. a duplet of file system type and
+        volume file name.
+    """
+    fs_type = request.param
+    fs_img = ''
+
+    fs_ubtype = fstype_to_ubname(fs_type)
+    check_ubconfig(u_boot_config, fs_ubtype)
+
+    scratch_dir = u_boot_config.persistent_data_dir + '/scratch'
+
+    try:
+        check_call('mkdir -p %s' % scratch_dir, shell=True)
+    except CalledProcessError as err:
+        pytest.skip('Preparing mount folder failed for filesystem: ' + fs_type + '. {}'.format(err))
+        call('rm -f %s' % fs_img, shell=True)
+        return
+
+    try:
+        # Test Case 1
+        check_call('mkdir %s/dir1' % scratch_dir, shell=True)
+        check_call('dd if=/dev/urandom of=%s/dir1/destination bs=1K count=1'
+                                    % scratch_dir, shell=True)
+
+        # Test Case 2
+        check_call('mkdir %s/dir2' % scratch_dir, shell=True)
+        check_call('dd if=/dev/urandom of=%s/dir2/source bs=1K count=1'
+                                    % scratch_dir, shell=True)
+        check_call('dd if=/dev/urandom of=%s/dir2/destination bs=1K count=1'
+                                    % scratch_dir, shell=True)
+
+        # Test Case 3
+        check_call('mkdir %s/dir3' % scratch_dir, shell=True)
+        check_call('dd if=/dev/urandom of=%s/dir3/source bs=1K count=1'
+                                    % scratch_dir, shell=True)
+
+        # Test Case 4
+        check_call('mkdir %s/dir4' % scratch_dir, shell=True)
+        check_call('dd if=/dev/urandom of=%s/dir4/source bs=1K count=1'
+                                    % scratch_dir, shell=True)
+
+        try:
+            # 128MiB volume
+            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '128MB', scratch_dir)
+        except CalledProcessError as err:
+            pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
+            return
+
+    except CalledProcessError:
+        pytest.skip('Setup failed for filesystem: ' + fs_type)
+        return
+    else:
+        yield [fs_ubtype, fs_img]
+    finally:
+        call('rm -rf %s' % scratch_dir, shell=True)
+        call('rm -f %s' % fs_img, shell=True)
+
 #
 # Fixture for unlink test
 #
diff --git a/test/py/tests/test_fs/test_rnfile.py b/test/py/tests/test_fs/test_rnfile.py
new file mode 100644
index 00000000000..dac4d0e3526
--- /dev/null
+++ b/test/py/tests/test_fs/test_rnfile.py
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier:      GPL-2.0+
+# Copyright (c) 2025, Mettler-Toledo
+# Author: Daniel Venzin <Daniel.Venzin@mt.com>
+#
+# U-Boot File System:rnfile Test
+
+"""
+This test verifies rename file operation on file system.
+"""
+
+import pytest
+from fstest_helpers import assert_fs_integrity
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.slow
+class TestRnfile(object):
+    def test_rnfile1(self, u_boot_console, fs_obj_rnfile):
+        """
+        Test Case 1 - abort if source file does not exist
+        """
+        fs_type,fs_img = fs_obj_rnfile
+        with u_boot_console.log.section('Test Case 1 - rnfile (non-existing source)'):
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                '%sls host 0:0 dir1' % fs_type])
+            assert('1 file(s), 2 dir(s)' in ''.join(output))
+            assert ('destination' in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                '%srnfile host 0:0 dir1/source destination' % fs_type,
+                '%sls host 0:0 dir1' % fs_type])
+            assert('1 file(s), 2 dir(s)' in ''.join(output))
+            assert ('destination' in ''.join(output))
+            assert('Unable to rename file' in ''.join(output))
+            assert_fs_integrity(fs_type, fs_img)
+
+    def test_rnfile2(self, u_boot_console, fs_obj_rnfile):
+        """
+        Test Case 2 - abort if destination file exist
+        """
+        fs_type,fs_img = fs_obj_rnfile
+        with u_boot_console.log.section('Test Case 2 - rnfile (existing destination)'):
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                '%sls host 0:0 dir2' % fs_type])
+            assert('2 file(s), 2 dir(s)' in ''.join(output))
+            assert('source' in ''.join(output))
+            assert('destination' in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                '%srnfile host 0:0 dir2/source destination' % fs_type,
+                '%sls host 0:0 dir2' % fs_type])
+            assert('2 file(s), 2 dir(s)' in ''.join(output))
+            assert('source' in ''.join(output))
+            assert('destination' in ''.join(output))
+            assert('Unable to rename file' in ''.join(output))
+            assert_fs_integrity(fs_type, fs_img)
+
+    def test_rnfile3(self, u_boot_console, fs_obj_rnfile):
+        """
+        Test Case 3 - abort on move operation (destination at new path)
+        """
+        fs_type,fs_img = fs_obj_rnfile
+        with u_boot_console.log.section('Test Case 3 - rnfile (abort on move)'):
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                '%sls host 0:0 dir3' % fs_type])
+            assert('1 file(s), 2 dir(s)' in ''.join(output))
+            assert('source' in ''.join(output))
+
+            output = u_boot_console.run_command(
+                '%srnfile host 0:0 dir3/source dir3/destination' % fs_type)
+            assert('Unable to rename file' in output)
+            assert_fs_integrity(fs_type, fs_img)
+
+    def test_rnfile4(self, u_boot_console, fs_obj_rnfile):
+        """
+        Test Case 4 - rnfile
+        """
+        fs_type,fs_img = fs_obj_rnfile
+        with u_boot_console.log.section('Test Case 4 - rnfile'):
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                '%sls host 0:0 dir4' % fs_type])
+            assert('1 file(s), 2 dir(s)' in ''.join(output))
+            assert('source' in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                '%srnfile host 0:0 dir4/source destination' % fs_type,
+                '%sls host 0:0 dir4' % fs_type])
+            assert('1 file(s), 2 dir(s)' in ''.join(output))
+            assert('destination' in ''.join(output))
+            assert_fs_integrity(fs_type, fs_img)
-- 
2.39.5

