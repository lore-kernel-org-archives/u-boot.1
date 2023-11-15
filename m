Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0131BC07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 12:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23FC587264;
	Wed, 15 Nov 2023 13:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="F4/n0JGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 045C6871C6; Wed, 15 Nov 2023 13:44:42 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BA59871FC
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 13:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaCHTdyaC/G1BO75mV6NJR0w+elF6+AqwDSnglwpImj+vN1zMU4uvkgSewY4yyJ+aLHSu1NdTw4VoRDytfnBCfEsiVqrM2PDq0PFKd1PL7YB3exgfn8XnIMj9iKAVEvfFQx+rp0oKmDcnjMh8VhXjPS7fr9bNOQp99oeIopOFBriZ5OenMn2nmJ32kCPV159RgFs0K53H2V0l7AZWtzrZxE/Z3VMNXQT0F+raxEXkeCKT8mD5mMmyzjvNMYOGGdXjbX1BRA840LmNKwsxphuHPfKf3DsuTIS0PXaAGrbsd42t8e2VnvIxariPbr2OC5Upp5/onacJt8/gOqOMbHTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pm1zTecHuxnHD5HMXDfQ3xetTe/diNo8JANxYsyKHqU=;
 b=YBdpNovEtVxAVTZTeYUMtuIGY8WS3mXRSX1u9jdq4h+MxpT+NqrOAnNX3alPYUIuKYa7rc5tciWqCVR3cCEE7DHJrOYl6k424apE0+iL36kCPKYQrMjlKMCoCvA/Uwk1WQBJUnrL5DrEm0WoB5PA92QmqYczb0EkMZeBCNjQ0dASgACSv82fDRHcqUe4chJHu2vZnfZrDDlZqXqsHez2uK6RbGtKrkvFwwSRnfcs6xSDZ2OGl2hmzIGbxm1QgMkvpO4W/MMdsCUH8TGfmIF9utuLTlaP9ye5AIekXL7M3FMlyV5Ye8rPGp+siUSEbxewYp07eguM4aPzJgFz5Yusyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm1zTecHuxnHD5HMXDfQ3xetTe/diNo8JANxYsyKHqU=;
 b=F4/n0JGCoAacFcSzVVsPWCBEunWmAyD51z0/L+NsbSIhIXUUVt3nMfW5/CVVIAeSrqgAdUxRqa/V1NcRX5fGE1PJkFKml92oWyog6oRHObxOIlviWT+kdHDQWYoamUWEqOF/40YnZLu0E2E5VcV9OI+A1AYRMeA3BgClQvRRnDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com (2603:10a6:208:165::13)
 by DU0PR08MB8614.eurprd08.prod.outlook.com (2603:10a6:10:402::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 12:44:37 +0000
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5]) by AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5%3]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 12:44:37 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>,
 Stefan Roese <sr@denx.de>
Subject: [PATCH v3 9/9] test: fs: Add test to detect fat type
Date: Wed, 15 Nov 2023 13:44:24 +0100
Message-Id: <20231115124424.125823-10-christian.taedcke-oss@weidmueller.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115124424.125823-1-christian.taedcke-oss@weidmueller.com>
References: <20231115124424.125823-1-christian.taedcke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::11) To AM0PR08MB4946.eurprd08.prod.outlook.com
 (2603:10a6:208:165::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB4946:EE_|DU0PR08MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: 3222410a-2a34-4675-5dcc-08dbe5d8a0b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HpysBMNbFcbR7Za+uvIGCd14fwJ9/h/NurTBV++ilRXtoT+fCme22k+Vf8KODMSlHoqDtU5biGEUCETAJ4kCtLhHAW5UvHtbm6nZK3mUpJKbTHVil8kjCPuROVptDS2QXjWkWI2XkYANMbnzbOxUzb7Th/z0WlB9cJxfP0rgJQCf6aynegCnE/238HlF3WI5+BQEhyC8jip6q64Ha6Yc2klcxT2pANFlYJp2/bOcqlolULaqnWaH/HlK5Kbn1RGFKzf1DDWXxkPWi2Jga6G+MXMlgvMhyfTh+qVsG35ccnuyR58wxIxCOioHa4AZs5UDSC9yJdKQZAPbK+rcRTEu5r9Wojb/Ml8EsfM9fxXGGAzDxnsgdwyjZ4am6EgMZXCWFXhLeSh442Xp5B9/fRxqHQFhrUbUquSJ7BNKJQ5eGN127J8CblwmdzJ8TRaVYDLQjQkV2nwPXYrg8Ddm15QP0T34appfIEO47qBHO0sv4z78CQ17R7FWQQwNA53xZIxTa1Oz+0yJVp4BpeXbqWJ3h4lQqaCpPLO936bpAGn+653YgKSVIod7Xt/u0vmUrdFHX2hRACOraAstrs5KJx1H3cD1I8V8m2tgN9oyv2nZQZ0ZVKinLIofAAP2BdB5Fd/Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB4946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(2616005)(66556008)(54906003)(6916009)(38100700002)(26005)(36756003)(316002)(66946007)(66476007)(86362001)(83380400001)(6512007)(66574015)(52116002)(1076003)(6666004)(6506007)(9686003)(6486002)(2906002)(478600001)(8936002)(8676002)(5660300002)(4326008)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkgyV3ZiRlVNTWYrRHluNFN5SmE0eGpnOWRVOTd0M09KczB6LzR4a3p2N0ZF?=
 =?utf-8?B?QjRraHVwV01DdVRzMzZ4TXlVVkRzNU5jRGdzTlR1eXY5NXNuUUFSY2ovbmtZ?=
 =?utf-8?B?RUJpbEJVQ2N3QjFHR2VWSGJFU2dhODF0cWFLWXFLUEZNUHZlT2FHemRPY2pK?=
 =?utf-8?B?Q3VraWIrSXJhNFk1ZkV2RmF1Tm5iSkQ2bmFpZU44b0o0VExWVHFralVZK2Ev?=
 =?utf-8?B?TkJwS1hwOTNWSzBkcUhGcWQrY0ZnNEVLeUNQY0lSV2ZhbzlaaVd3TzBLYk9C?=
 =?utf-8?B?aTNkRmFSSlBnQkFsU09pMXR2WVRLcXg3b0Z6ei84cDFqa1N4WkRXNnIrZUtX?=
 =?utf-8?B?VFd5aDZOdC9EVVBFRU9QMVhmdy9Ra1NIZW9FcVJnT0tjVVMzOGNOTmNWK2pR?=
 =?utf-8?B?emNjMjJ1WWZaMjRqOVJrSDA0T2g2THl1My9yb3hrOXFQZG5zS2xTM0tSeG8x?=
 =?utf-8?B?OU1tdzZvZDdueDNWbEsxZ1N5L2lzUmhQcVFWRmpnTld6RnVJZXZZTGd5THBt?=
 =?utf-8?B?dGFIU2k4WTQzcG5adUZMelpGV2UyazF5OC9PU3pTS1hCNWlNNVRHak9QVzNp?=
 =?utf-8?B?T3QwQUM0MU5FelZFc1dwS1M2TndDK2pkb25FYWVOcFBvUmJlZWExcDE4L3Zj?=
 =?utf-8?B?b3BhTlNCdjQ0Q0F5OWdLRjRWMGtyWjgvTEdDNTAxVHE5QkZBc094NUxWQnd2?=
 =?utf-8?B?MU5QS254Wjd4VE9oOXcwOEZkTUVVK2NvZmVLZ1g0Nks4VDZVWXUxeE5jSzhQ?=
 =?utf-8?B?L2M2R29lUDBKT3hqU1BCd1pTa3ZPMkdMSVZid1ZJanFCYkdQWU1FM1pBRFFy?=
 =?utf-8?B?RXJCUEJDM1lZdXZaaGgzckNmaFp4YVpzcnU4N3J6cVNvbHFJb202dGJNN2Ru?=
 =?utf-8?B?L1A2Z01hVXNBOUhnNEdEMDB4SG45RzlMUVhTcFhOYm5wUFZXUWU4NFZIU2li?=
 =?utf-8?B?NjRUVjcvMEVTSWNUZTJYNzYzMDRZSW1BVjZ6dVAwYTVnM0pqSkZVdkNtd2E2?=
 =?utf-8?B?NEc2R29NY0tOQzMxTzZyRHlCN1NhdHZxRTNraVlvWGFoZ0U4ZmlUSWpOZElG?=
 =?utf-8?B?Ums5ZHhDQUxUZWVteWZNR3V3MWczSDJEUnh6RjU2K2swN2RDRVlzQWtnTVNx?=
 =?utf-8?B?WCs2NlI3VjdRUWZDZmxJRTN6VERqUTk2Q3kvS2lWTGNxalZIQmZoV3JuRFB5?=
 =?utf-8?B?Lyt5MWFhRlgyc0hwcDZrM1QyazVxNmkyeWhtSDRIZmdldEttYzVtenBPOGpv?=
 =?utf-8?B?cjJYaWtodmpSQ0xETzBmSHlleE9sc050NXNob01TWjBCOEZjcVB4Y3J6Sys4?=
 =?utf-8?B?RWFZSVJJTE43cXllZXBBMlQvUng1K29PcUlTUGFQejFwSlpRaGhQUkFUQ3Rz?=
 =?utf-8?B?cjJWOFExUzFjSzVzN0N0T3JNeVhWQ3Job2VvYWFDb2VndkcySXJ4UVR4RmU3?=
 =?utf-8?B?Rk5FanlpbENqL1l6ckd0K012Yk5vTmlJKzVWRkh3VllzM2wvampzU3E4aFM3?=
 =?utf-8?B?TU5vbjE0RTJMVkxWcnVyTnYvUFY2d1p3RUM0VFFlUGFrVC9vK2lYVmU1cmhx?=
 =?utf-8?B?YWxTTlFnUlRiTHBvY05qZ3lrb2xqYnpmZk16RFJUeWZGdU4zdjJHa0NzY1BL?=
 =?utf-8?B?azFHandRNk1KbmtyUG1EL1p1VlhOSlNTS3U3d1c1TS9yL3NoYTdmZ3Rka0pL?=
 =?utf-8?B?WmFkM0tIVXFIb1JrNGFKM2s2d1p2K1BVenV2WXNPMlBNdzEwOHRvSG9XNFZX?=
 =?utf-8?B?dkk4Kys4NzNQMDZiRzdaNGhOL3JBVE5TOUMwcCtQTFE1TDhESlRzNVFtTjkw?=
 =?utf-8?B?Nzd3WEhFaitEQ3A3ZTRZL3BSK3JwWkJlUGZyYXA1bDVURFU0ZHZvZW1HaGhv?=
 =?utf-8?B?ek1LMWdEc0t1UWFOYWVGODZTL3hhRi9WMWV3WSt6Tm9VMDZjV0xRejlxendp?=
 =?utf-8?B?NzJjeGQwWGx3VnBkOXRKc285ZHBNVXZva1ErK1MwaFdnNkU4dm1raGg1L2Zh?=
 =?utf-8?B?a3Z4dFhEdXFxQjRpR2g2TUFQQUxFUlcxMVYxSjNEWTJWTFRKZ1ZUMHJIMlNx?=
 =?utf-8?B?b0FZSE5lNHpwMnREbVUvcDBHL1dSY213K1NXbU9wL0oyeUxJYm5VM0RGMXEy?=
 =?utf-8?B?YjV2VG1aVkxyNHVUTWNpaEVCT2dxUjNIWWhLNHF5N1ZOWmc0SklsdWlvM243?=
 =?utf-8?Q?PVplEahT4WZSSGzOXZsM7eNfmxHu9Lmti9IqQOtC7Xgu?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3222410a-2a34-4675-5dcc-08dbe5d8a0b4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:44:37.6078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJMMWDaTmPMhRKRA06XVxzPDPictKkNqMP1MyIsLVwOENNvmyTgFM1fhp4/+ADuEkqvEryHWB+/fUq82FN1BFGaL5tut/WbwNTXpao0RBURspl+wVpHH+91TA9q6cCB9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8614
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

From: Christian Taedcke <christian.taedcke@weidmueller.com>

Ensure that a large FAT12 filesystem and a small FAT16 filesystem are
detected correctly.

Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
---

Changes in v3:
- Add test to detect fat fs type

 test/py/tests/test_fs/conftest.py    | 47 ++++++++++++++++++++++++++++
 test/py/tests/test_fs/test_fs_fat.py | 25 +++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 test/py/tests/test_fs/test_fs_fat.py

diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/conftest.py
index fa637a22a0..fdd138d6ee 100644
--- a/test/py/tests/test_fs/conftest.py
+++ b/test/py/tests/test_fs/conftest.py
@@ -13,6 +13,7 @@ from tests import fs_helper
 
 supported_fs_basic = ['fat16', 'fat32', 'ext4']
 supported_fs_ext = ['fat12', 'fat16', 'fat32']
+supported_fs_fat = ['fat12', 'fat16']
 supported_fs_mkdir = ['fat12', 'fat16', 'fat32']
 supported_fs_unlink = ['fat12', 'fat16', 'fat32']
 supported_fs_symlink = ['ext4']
@@ -49,6 +50,7 @@ def pytest_configure(config):
     """
     global supported_fs_basic
     global supported_fs_ext
+    global supported_fs_fat
     global supported_fs_mkdir
     global supported_fs_unlink
     global supported_fs_symlink
@@ -61,6 +63,7 @@ def pytest_configure(config):
         print('*** FS TYPE modified: %s' % supported_fs)
         supported_fs_basic =  intersect(supported_fs, supported_fs_basic)
         supported_fs_ext =  intersect(supported_fs, supported_fs_ext)
+        supported_fs_fat =  intersect(supported_fs, supported_fs_fat)
         supported_fs_mkdir =  intersect(supported_fs, supported_fs_mkdir)
         supported_fs_unlink =  intersect(supported_fs, supported_fs_unlink)
         supported_fs_symlink =  intersect(supported_fs, supported_fs_symlink)
@@ -83,6 +86,9 @@ def pytest_generate_tests(metafunc):
     if 'fs_obj_ext' in metafunc.fixturenames:
         metafunc.parametrize('fs_obj_ext', supported_fs_ext,
             indirect=True, scope='module')
+    if 'fs_obj_fat' in metafunc.fixturenames:
+        metafunc.parametrize('fs_obj_fat', supported_fs_fat,
+            indirect=True, scope='module')
     if 'fs_obj_mkdir' in metafunc.fixturenames:
         metafunc.parametrize('fs_obj_mkdir', supported_fs_mkdir,
             indirect=True, scope='module')
@@ -624,3 +630,44 @@ def fs_obj_symlink(request, u_boot_config):
     finally:
         call('rmdir %s' % mount_dir, shell=True)
         call('rm -f %s' % fs_img, shell=True)
+
+#
+# Fixture for fat test
+#
+@pytest.fixture()
+def fs_obj_fat(request, u_boot_config):
+    """Set up a file system to be used in fat test.
+
+    Args:
+        request: Pytest request object.
+        u_boot_config: U-Boot configuration.
+
+    Return:
+        A fixture for fat test, i.e. a duplet of file system type and
+        volume file name.
+    """
+
+    # the maximum size of a FAT12 filesystem resulting in 4084 clusters
+    MAX_FAT12_SIZE = 261695 * 1024
+
+    # the minimum size of a FAT16 filesystem that can be created with
+    # mkfs.vfat resulting in 4087 clusters
+    MIN_FAT16_SIZE = 8208 * 1024
+
+    fs_type = request.param
+    fs_img = ''
+
+    fs_ubtype = fstype_to_ubname(fs_type)
+    check_ubconfig(u_boot_config, fs_ubtype)
+
+    fs_size = MAX_FAT12_SIZE if fs_type == 'fat12' else MIN_FAT16_SIZE
+
+    try:
+        # the volume size depends on the filesystem
+        fs_img = fs_helper.mk_fs(u_boot_config, fs_type, fs_size, f'{fs_size}', 1024)
+    except:
+        pytest.skip('Setup failed for filesystem: ' + fs_type)
+        return
+    else:
+        yield [fs_ubtype, fs_img]
+    call('rm -f %s' % fs_img, shell=True)
diff --git a/test/py/tests/test_fs/test_fs_fat.py b/test/py/tests/test_fs/test_fs_fat.py
new file mode 100644
index 0000000000..4009d0b63a
--- /dev/null
+++ b/test/py/tests/test_fs/test_fs_fat.py
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier:      GPL-2.0+
+# Copyright (c) 2023 Weidmüller Interface GmbH & Co. KG
+# Author: Christian Taedcke <christian.taedcke@weidmueller.com>
+#
+# U-Boot File System: FAT Test
+
+"""
+This test verifies fat specific file system behaviour.
+"""
+
+import pytest
+import re
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.slow
+class TestFsFat(object):
+    def test_fs_fat1(self, u_boot_console, fs_obj_fat):
+        """Test that `fstypes` prints a result which includes `sandbox`."""
+        fs_type,fs_img = fs_obj_fat
+        with u_boot_console.log.section('Test Case 1 - fatinfo'):
+            # Test Case 1 - ls
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'fatinfo host 0:0'])
+            assert(re.search('Filesystem: %s' % fs_type.upper(), ''.join(output)))
-- 
2.34.1

