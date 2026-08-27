Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB0AC61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 17:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D29BB80EB3;
	Thu, 27 Aug 2026 17:44:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rTZOetAG2r_O; Thu, 27 Aug 2026 17:44:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787852672;
	bh=AeU4YmKld+pXureVH1hCUu14M+sp+sO52UEHmNL3d6s=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ocpkkuvU8GmCx+GrLA5e0ayayH2CWlzGDbak2K7PouD3pI+gI4UM479Tk2lXYnrJL
	 zsX+M/uHcJYgFx05f8FyrRcjjcjjMu1/2tv+58msZwAerUU2+YmaQ4yE9lnQpehaOf
	 xZsfxJANkxk8tO9DD9TGjrI+CLXP2KqCs4i58xh9VBT+uf2RazVSixdw9qu7OEjiXZ
	 k4SLdQrgaSbOQfPHWoaANIe5XTyMfmRA4UAmDo5FHmfll7MEnicbZNexTtgcZxsKGF
	 Qbz8EOLpw3QYqfabEA3qVYdcAj2Y4BAo6mWvLAPkIDNdaRjFBIiXJpPNj2rv2SmQnf
	 LoTxJYqYVjTDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCED280EAC;
	Thu, 27 Aug 2026 17:44:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 171E2464
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 17:44:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0904880EAC
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 17:44:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o1DOJa4xOtww for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 17:44:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=z6FgW+k3
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8347D80EAB
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 17:44:28 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47f84023916so75518f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 10:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787852666; x=1788457466;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AeU4YmKld+pXureVH1hCUu14M+sp+sO52UEHmNL3d6s=;
 b=z6FgW+k3m8wm1hqXVyUsN509iSgkaVZ+21X9gNtwcAutr8KK3p1MjP6tCAPIyru4kW
 6sBLqYW4g+qPw0HpXUqrIykhpgcSoFtMX4+F8zFTMmz3oicR+qW/aRJh8d8f9dvgsus5
 N5ne/Wc12LUXXhgWXfFMbWB7meJkWmivjNtqArKgC8v++mAibg1jvE5mlCXhnY/ChCfi
 HRMShqpePqovgBWf0X3Jl0USyP/Aav9PCIDoi2kJ/5MA6izMIpTA865mAtiP/jtrowyQ
 23HukVVidHCAJtl9FbADP040pkjZfa5HQIm6uelwy98qypkX0wDb5rMEN6XbVuYfGBOd
 +WGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787852666; x=1788457466;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AeU4YmKld+pXureVH1hCUu14M+sp+sO52UEHmNL3d6s=;
 b=VXFUOCiLuhabYweUWW+ZLsIIdsq/jqV9DrjNRh/doMGzpg1vgqv/K20NSnYyDjTHGi
 33qkjgF/422URv/pxQ/g4WGT89xKjlALQnNvnZw6+Cxln3du/dZDuizUMXkB/eMqpcjh
 +7KGNdednFpGJIvzaGKoQ+2ah0SFGF+IsKoPdwozSvm8Kdk4tTtiNLiYvuK+cGQo11Ju
 aJdiju6idrZmjXAv8nQxXqKqX3n2sx6fa74MyNJJREUUn0/Q3NsL0kT6bSZP0nKtw5qI
 IKlYpDYNXDVx/0nDAGWXGSioyIvSCo4DxCqc7/jMrKgl6c/vrwsrZ3pEH7bspVkt3aQD
 aqHQ==
X-Gm-Message-State: AFuF++l1kDM+y+qwPH5E2VVQAq2h1ogC3nbHUGkse01awYLLW3Fw/W1I
 bmj8FkNhDhTTWR5tU/P8pO9r8pr8SB/y/in6D8BBMNl7ISejm5uev090HmOp9QTugfw=
X-Gm-Gg: AR+sD12G1UfG1Fp+R/OHn7VdRwfLLigGIpOWFLoOYiCry4dDu8osJx+AxaajLpkduv5
 C4ZzRXArTAeY2QOZEh8yXlBTy2ez8MAqeHPC2ZD1bSE/hHJXwgJYGDmj9TP0PKe3dbmR+QQdgsc
 5IDydNyK6KW3vLJpMdzehulGB2Lekyx5Bad+1AMoCEC6Tty7+JMVexBa4aK7SvIYCdcwJNnmjGJ
 0Q1AJ4bTF7uerNmjIuLMBZrXVvjVP5sq9VkwYKO0opVpoVAVsDMK7SZe6ljo1fgE/3mOVr5HH36
 BxUHRDIGXRySbSxBYp7Oz94KEmJoYd6XYDQR9cjUzFP4X71uVxNN3vkAqeOEhAlw/vVajQbb35o
 QWo0ZAfo3dPvwuG+oFSJUzUGHjGpUFO8SkbcgrYtyO/0XQoQnSWvb5uCLQSJhe+0ANk3gvNMYIl
 tOeukcrkqZ7HeskIj4mVdvdQlJ/OIVbuNT+5YPtJ0b5w9pMjxK1qvHFpTbl9uS11qpowM97yc4I
 bI0OwVS90YoASkxlYz7cYTALFdYAbnw5gXZLuRhig==
X-Received: by 2002:a05:6000:468b:b0:482:ee80:d02b with SMTP id
 ffacd0b85a97d-482f79b1efcmr541932f8f.11.1787852666588; 
 Thu, 27 Aug 2026 10:44:26 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28dc10asm11075228f8f.19.2026.08.27.10.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 10:44:26 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 27 Aug 2026 21:44:15 +0400
Subject: [PATCH v2] test: lib/uuid: Fix endianness for dynamic GUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-uuid-be-v2-1-2f91c9289b18@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNwQ6DIBAFf8XsuTRAI2hP/Y/Gg8Jat2mUAJI2h
 n8v2mOPk8ybt0FATxjgWm3gMVGgZS4gTxWYqZ8fyMgWBsml4o3UbF3JsgFZrVStUfd9wxGK7Ty
 O9D5K9+7HYR2eaOI+342JQlz857hKYvf+q0kwwVprLoOQxqpW3MYXOYf+PGOELuf8BWF1lBmyA
 AAA
X-Change-ID: 20260827-uuid-be-56657e7aa80e
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6559; i=alchark@flipper.net;
 h=from:subject:message-id; bh=lTBgumrGCiIBTTn8a45KqYHr1xSWXQf2o9OlodH6qpw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRNKK+MvhtukOh0hMfLfF+/Mo/FVgXOizI/lY9OXvzaa
 4nHzj9RHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz1s3MMv9ncZyzUFkl7U7fMTFpgq3TDnas21tLpHzpkAhQPqt5R1WBkOJc5452
 V08G1t61vXVm6sLr2KdtR7ZD2Xy3Nal9fMElfZgIA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

If LIB_UUID is enabled on a big-endian board, such as when it is pulled
in by EFI_PARTITION, its tests will fail due to the dynamic capsule GUIDs
computed by lib_test_dynamic_uuid() using native endianness for the UTF-16
image name, instead of little-endian:

  malta # ut lib lib_test_dynamic_uuid
  Test: dynamic_uuid: uuid.c
  test/lib/uuid.c:114, lib_test_dynamic_uuid_case(): expected_uuid = uuid_str: Expected "985f2937-7c2e-5e9a-8a5e-8e063312964b", got "829f5cb0-1a07-5718-8774-4514bda82c39"
  Test 'dynamic_uuid' failed 1 times
  Tests run: 1, 2 ms, average: 2 ms, failures: 1
  exit not allowed from main input shell.
  malta #

The image names come from u"" literals, which the compiler lays out in
the endianness of the target, while the GUIDs they are checked against
were computed little-endian, as the UEFI specification requires.

Spell the names out as UTF-16LE byte strings instead, so that the test
data no longer depends on how the target stores a u16 and nothing has to
be converted at run time. Measure them by scanning for a pair of null
bytes: that comes out the same either way round, and unlike walking the
string as u16 it assumes nothing about the alignment of a string literal,
which m68k for one does not guarantee.

Other callers of gen_v5_guid() are EFI update capsule code, which only
ever runs on little endian systems (as UEFI is little endian), so keep
them as they are.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
This was uncovered [1] while adding tests for GPT partition labels on big
endian boards, which pulls in PARTITION_UUIDS, which in turn pulls in
LIB_UUID and its tests. Turns out no BE board in CI ever enabled LIB_UUID,
so this went unnoticed to date.

No functional change on little endian.

[1] https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1101
---
Changes in v2:
- Dropped the EFI changes, keeping only the test expectations update for
  big endian systems (thanks Heinrich). Keep the hunk updating the
  kerneldoc to help others avoid tripping over this in the future.
- Dropped the runtime endianness conversion loop and instead store the
  seed strings as explicitly spelled out UTF-16LE bytes in a plain char *
  string (thanks Heinrich). The length function also had to be replaced,
  because string literals are not guaranteed to be halfword aligned
- Link to v1: https://patch.msgid.link/20260827-uuid-be-v1-1-9dc3b12cd691@flipper.net

To: Casey Connolly <casey.connolly@linaro.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Alexey Charkov <alchark@flipper.net>
---
 include/u-boot/uuid.h |  5 +++++
 test/lib/uuid.c       | 37 +++++++++++++++++++++++++++++--------
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/include/u-boot/uuid.h b/include/u-boot/uuid.h
index 7f8414dc906c..acdf3a85a6cb 100644
--- a/include/u-boot/uuid.h
+++ b/include/u-boot/uuid.h
@@ -149,6 +149,11 @@ struct efi_guid;
 /**
  * gen_v5_guid() - generate little endian v5 GUID from namespace and other seed data.
  *
+ * The seed data is hashed as raw bytes, so any of it that is not a byte string
+ * has to be supplied in a fixed byte order for the result to be reproducible.
+ * UTF-16 seed data, such as a firmware image name, must therefore be passed
+ * little-endian, which is the byte order the UEFI specification uses for it.
+ *
  * @namespace:   pointer to UUID namespace salt
  * @guid:        pointer to allocated GUID output
  * @...:         NULL terminated list of seed data as pairs of pointers
diff --git a/test/lib/uuid.c b/test/lib/uuid.c
index d00e9563a472..f958897dd7b5 100644
--- a/test/lib/uuid.c
+++ b/test/lib/uuid.c
@@ -8,7 +8,6 @@
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 
-#include <charset.h>
 #include <u-boot/uuid.h>
 #include <test/lib.h>
 #include <test/test.h>
@@ -86,10 +85,31 @@ LIB_TEST(lib_test_uuid_bits, 0);
 
 struct dynamic_uuid_test_data {
 	const char *compatible;
-	const u16 *images[4];
+	const char *images[4];
 	const char *expected_uuids[4];
 };
 
+/**
+ * bytes_to_null_pair() - offset of a pair of null bytes within a string
+ *
+ * Steps through the string two bytes at a time, looking for a null character,
+ * which in UTF-16 is a pair of null bytes. The string is walked byte-wise
+ * rather than as u16, since a string literal carries no alignment guarantee
+ * and some architectures cannot load a halfword from an odd address.
+ *
+ * @str:	UTF-16LE string, terminated by a null character
+ * Return:	number of bytes preceding the terminator
+ */
+static size_t bytes_to_null_pair(const char *str)
+{
+	size_t len = 0;
+
+	while (str[len] || str[len + 1])
+		len += 2;
+
+	return len;
+}
+
 static int lib_test_dynamic_uuid_case(struct unit_test_state *uts,
 				      const struct dynamic_uuid_test_data *data)
 {
@@ -101,13 +121,13 @@ static int lib_test_dynamic_uuid_case(struct unit_test_state *uts,
 
 	for (j = 0; data->images[j]; j++) {
 		const char *expected_uuid = data->expected_uuids[j];
-		const u16 *image = data->images[j];
+		const char *image = data->images[j];
 		efi_guid_t uuid;
 		char uuid_str[37];
 
 		gen_v5_guid(&namespace, &uuid,
 			    data->compatible, strlen(data->compatible),
-			    image, u16_strlen(image) * sizeof(uint16_t),
+			    image, bytes_to_null_pair(image),
 			    NULL);
 		uuid_bin_to_str((unsigned char *)&uuid, uuid_str, UUID_STR_FORMAT_GUID);
 
@@ -124,9 +144,10 @@ static int lib_test_dynamic_uuid(struct unit_test_state *uts)
 		{
 			.compatible = "sandbox",
 			.images = {
-				u"SANDBOX-UBOOT",
-				u"SANDBOX-UBOOT-ENV",
-				u"SANDBOX-FIT",
+				/* Forced UTF-16LE to keep these endianness agnostic */
+				"S\0A\0N\0D\0B\0O\0X\0-\0U\0B\0O\0O\0T\0\0",
+				"S\0A\0N\0D\0B\0O\0X\0-\0U\0B\0O\0O\0T\0-\0E\0N\0V\0\0",
+				"S\0A\0N\0D\0B\0O\0X\0-\0F\0I\0T\0\0",
 				NULL,
 			},
 			.expected_uuids = {
@@ -139,7 +160,7 @@ static int lib_test_dynamic_uuid(struct unit_test_state *uts)
 		{
 			.compatible = "qcom,qrb4210-rb2",
 			.images = {
-				u"QUALCOMM-UBOOT",
+				"Q\0U\0A\0L\0C\0O\0M\0M\0-\0U\0B\0O\0O\0T\0\0",
 				NULL,
 			},
 			.expected_uuids = {

---
base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
change-id: 20260827-uuid-be-56657e7aa80e

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

