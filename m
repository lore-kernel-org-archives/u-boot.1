Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD574E7D26A
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58FEF86DA6;
	Tue, 26 Sep 2023 10:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 089D886DA6; Tue, 26 Sep 2023 10:54:43 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07DFE86D93
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp66t1695718470tk1c9fys
Received: from pek-vx-bsp2.wrs.com ( [60.247.85.88])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 26 Sep 2023 16:54:28 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: kUim6XnhvqV8FbEZO4aNq+pMdqoaTSg53pXciQntSMuKpmwS4ByH5b7YyeEyp
 r78+hikKTV5t3kotHCiPtYRwJLs5YemfH6rgE2DQAcJPnEqBnYlYtlYSB2m0VGfJKph/oT8
 ZTzwWEOg9sN94d331048Td3OHgWopfahoz8qP3ryW0X0Uf4Yfb587EJBS28TYC8MpQk1ptI
 8mg8rTzxW2Ezly95+8xmCP+2mGvNECZ1QCLa5SQy6T65Gt7UNiSSbz0/9oUEQBjKEuMOneL
 xX/v8cwFpzhbIDGwVvf56p1ZS125FFa6cNIkz4Mun3M56wGEn3lYdACGib+DPPdlhpfQfUl
 nNDYa5iQFUIAurq7+OXki4cWgh0DFdIoGejtLGL
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3349316448869738313
From: Bin Meng <bmeng@tinylab.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 10/15] cmd: blk_common: Use macros for the return values
Date: Tue, 26 Sep 2023 16:43:40 +0800
Message-Id: <20230926084346.2237483-11-bmeng@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926084346.2237483-1-bmeng@tinylab.org>
References: <20230926084346.2237483-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

Avoid using magic number 0/1 for the command result.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 cmd/blk_common.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/cmd/blk_common.c b/cmd/blk_common.c
index 9f9d4327a9..ad9b16dc09 100644
--- a/cmd/blk_common.c
+++ b/cmd/blk_common.c
@@ -25,18 +25,18 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
 	case 2:
 		if (strncmp(argv[1], "inf", 3) == 0) {
 			blk_list_devices(uclass_id);
-			return 0;
+			return CMD_RET_SUCCESS;
 		} else if (strncmp(argv[1], "dev", 3) == 0) {
 			if (blk_print_device_num(uclass_id, *cur_devnump)) {
 				printf("\nno %s devices available\n", if_name);
 				return CMD_RET_FAILURE;
 			}
-			return 0;
+			return CMD_RET_SUCCESS;
 		} else if (strncmp(argv[1], "part", 4) == 0) {
 			if (blk_list_part(uclass_id))
 				printf("\nno %s partition table available\n",
 				       if_name);
-			return 0;
+			return CMD_RET_SUCCESS;
 		}
 		return CMD_RET_USAGE;
 	case 3:
@@ -49,7 +49,7 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
 			} else {
 				return CMD_RET_FAILURE;
 			}
-			return 0;
+			return CMD_RET_SUCCESS;
 		} else if (strncmp(argv[1], "part", 4) == 0) {
 			int dev = (int)dectoul(argv[2], NULL);
 
@@ -58,7 +58,7 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
 				       if_name, dev);
 				return CMD_RET_FAILURE;
 			}
-			return 0;
+			return CMD_RET_SUCCESS;
 		}
 		return CMD_RET_USAGE;
 
@@ -80,7 +80,7 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
 
 			printf("%ld blocks read: %s\n", n,
 			       n == cnt ? "OK" : "ERROR");
-			return n == cnt ? 0 : 1;
+			return n == cnt ? CMD_RET_SUCCESS : CMD_RET_FAILURE;
 		} else if (strcmp(argv[1], "write") == 0) {
 			phys_addr_t paddr = hextoul(argv[2], NULL);
 			lbaint_t blk = hextoul(argv[3], NULL);
@@ -98,7 +98,7 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
 
 			printf("%ld blocks written: %s\n", n,
 			       n == cnt ? "OK" : "ERROR");
-			return n == cnt ? 0 : 1;
+			return n == cnt ? CMD_RET_SUCCESS : CMD_RET_FAILURE;
 		} else {
 			return CMD_RET_USAGE;
 		}
-- 
2.25.1

