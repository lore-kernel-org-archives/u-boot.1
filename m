Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0BCCD6E5D
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 14:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C586846FA;
	Sun, 31 May 2026 16:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kVZpdudN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6E698405A; Sun, 31 May 2026 12:05:48 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0DFB838D7
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 12:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raziebe@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45eea68dd6fso1544637f8f.2
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 03:05:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780221946; cv=none;
 d=google.com; s=arc-20240605;
 b=NaDAQoG4XHTach2OSylDIL6m5fSnCbg83ARFYAYet9Y3pq7qIvtTwOuzLl/QltJzEn
 zyDBYg+XgvzBTunb96f9qvnrWjlPJpZg+goQz70MfGgNYUvEpDw2pM1JVfBQIDTbjiM5
 /oVy1zb+jxxSC/cSPgY+J2AYluQUGrJkdQSEl27wphaWxrfpGNivbOOiSDfJ4LxffE8a
 O9iANC9RCVtbT1Xc3aBXBWNcRo9eujjhuBDBQCwq9afYjCcbaZaFEiAtTYLkxZPlD0oH
 wPqy+86Q3AQ8mJ+Kdlp+J/ltCsQYtTEMyVFHhuvSbmW+wgJzY6d7VXCbt/LTtBnrAqn6
 imQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=nK/cCPW6mi9Pq8W7Z7IMhwOPzCM/OcrE8UNNm4K5MmM=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=SzYKJZk6EAPiHooepxKCy0yYu+xCp1LiDm7lE3VrdxxZU49krYC3aZBoNrhfyGDbMe
 mO80mIJ90J1GGNkORVQSNeGUpfIZ5sRgCAQSyXkBr4ruiaOekccTUDmXiVEcJ06j9Ya8
 RYc5/oGFoJB38Nih7iJORSlrIspCZbIO1ghGIQZ8G41zgmk0evTGZu8UGgnNWQoY5Cwx
 otybQcsnNe+9BjGubpVEFgXCTPKwtoNMwjurXMx/VkcoB9aEmQffm4xwNnqncWMvlmmU
 oeD0+XgUWihxGe8Rqn6+9bqdrzHK83IP6ffiq9zbFkRngLxBiKFFWJCUCeMgALp8O8cr
 seIA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780221946; x=1780826746; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nK/cCPW6mi9Pq8W7Z7IMhwOPzCM/OcrE8UNNm4K5MmM=;
 b=kVZpdudNhQPl0Mm3qqyJT8OokL1XtRBKEXlnnCQhp4e589Z0QzZBUXAeVaM/G+Nwjf
 E8iUrxiREavRQ/qVLshLN5X8eLnT5ijkMH9AgQxs2YqXFQ++T/QVCdYJj7pt8QK5dK/g
 sPcfG3RGQwL8I7WOkUE9sWPBzQRgnkjbxfbFuVxLl6+B2LlhnYOpsz9HI5ZHdKmAagRV
 jIJuazk3ro9z6xsj2oCKXlvZT9UNs0mVToLa6RGYvvGKj2XqFF+vrmcDQER6WIoymxdM
 bq9gqX4Bc1LhtU7lhBb868SxfB3T63N6YccqDF/Ll/TsOLPQmWeC+qQlQdgwZEQ9HRTq
 w2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780221946; x=1780826746;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nK/cCPW6mi9Pq8W7Z7IMhwOPzCM/OcrE8UNNm4K5MmM=;
 b=MdUrnqiAzXzEHZ768UQJGnB37nuNyhXh5QCSjnhrtJwNZvHeptKRa0/aj6yVM9d3AR
 gNqJpdGlfSOuB8pout6VNtrScW2pJJnMmqQH3N5YW5EctjhZs4uC4NZ/cijIjcsE9Dio
 6C33WtMPAorHUS9DUCiXIsnNoQ0d9pwNG+9pLhRWi9/jpOa1E1cxY/43fOSqLgvBgSec
 yP8zpovfBWEIonVbL7UwJmwiyrSZjiyjs7R0yDQxN6Mcl/U/+/S6VanbrD8yZNe6QhS+
 vsf9+hFHJwDfhNncuWvXiMKUnGO3EJGvQZjne0FtAEVmKKSB4q3ZJaKsR3fHR1+l2w90
 v2uA==
X-Gm-Message-State: AOJu0YxF4lZ5C3MJ0ErvaIeb7Y/ZdqWwESTT8lF3iQLp4fn7WitfwSN2
 ORi8YrwTbdMaH8HmvRqxksVFciyF3ZcqFqt8sB+r8vwLF4tMoGLUEgOyGoeBt3vHDroPpErqPmf
 +/hzqCYyUFcC1pxbS6aLFsjcLSZpQrMaK/cJI
X-Gm-Gg: Acq92OGgEcHLos4kvir+6PRTUWP1LFgYRYGEqlrRoo0OdvHJqrk6b6nHaG5fTpwqpdT
 y0ZhzoLAkbeiQyoKutVtW9xqSwYTrPudHLnw9kkWDVI3zC+Rlj4Pv6Vhqsd6Bd+5qHw+blDTJIx
 cau+dpqulDGtZmzMiD1aqAMscnqQk9+c1Ujoqg8jk/Bjcp3P0A+qFAdA5B9EAgG4atanG3yEp2S
 A5Jl5jLF8QUKFTV1uLuoyi9i6mMKEB3nYBZFVlAI7n8ZsJsjqBe9hhuo8hxGKsf8CubEn5YEMpG
 8EGBsINJYRR5xilwfyZ80MKG482GVyXzZ7B1n95Hq0SXFV1HfA==
X-Received: by 2002:a05:6000:23c3:b0:45e:eae7:7f4 with SMTP id
 ffacd0b85a97d-45ef6b25811mr7984301f8f.11.1780221946132; Sun, 31 May 2026
 03:05:46 -0700 (PDT)
MIME-Version: 1.0
From: Raz <raziebe@gmail.com>
Date: Sun, 31 May 2026 13:05:34 +0300
X-Gm-Features: AVHnY4I3oceOIzjh7wJDwl5NBS3V2-tqly2H39jPhtvz4SrZAEYTiZCnDgstOpE
Message-ID: <CAPB=Z-p05pqcWKOT-RQBWtLK9gAAtakxb2MUb=bnDtpkRS15yA@mail.gmail.com>
Subject: UFS: PATCH [3/4]
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="000000000000b8b65206531a3861"
X-Mailman-Approved-At: Sun, 31 May 2026 16:30:00 +0200
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

--000000000000b8b65206531a3861
Content-Type: text/plain; charset="UTF-8"

From cfc26be794ba0c6558a1fcabe54be74f013e3ec0 Mon Sep 17 00:00:00 2001
From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
Date: Thu, 28 May 2026 15:08:28 +0300
Subject: [PATCH 3/4] ufs: Extend the ufs user interface

Provide a user interface and help to ufs tool.
query [lun] [idn]:
(0h) Device desc
        (7h) Geometry desc
(8h) Power desc
(2h) Unit desc
(1h) Config desc

        set_lun [LUN] [parm]
                lu_enable
                boot_lun_id
                lu_write_protect
                memory_type
                data_reliability
                num_allocunits
                logical_block_size
                provisioning_type
                context_capabilities
                lu_num_write_booster_buffer_allocunits

set_dev_desc [parm] [value]
descriptor_idn, device, device_class
device_sub_class, number_lu, boot_enable
descr_access_en, init_power_mode, high_priority_lun
secure_removal_type, initactive_icc_level
queue_depth, write_booster_buffer_preserve_user_space_en
write_booster_buffer_type, spec_version, manufacturer_id
periodic_rtc_update, device_version, psa_max_data_size
extended_ufs_features_support,
num_shared_write_booster_buffer_allocunits
write_booster_buffer_preserve_user_space_en

set_cfg_desc [parm] [value]
length, descriptor_idn, conf_desc_continue
boot_enable, descr_access_en, initpower_mode
high_priority_lun, secure_removal_type, init_active_icc_level
periodic_rtc_update, reserved_HPB, rpmb_region_enable
rpmb_region1_size, rpmb_region2_size, rpmb_region3_size
write_booster_buffer_preserve_user_space_en
write_booster_buffer_type
num_shared_write_booster_buffer_allocunits

flag [flag name]
deviceinit, permanent_wpe, pwr_on_wpe, bkops_en, life_span_mode
purge_enable, fphy_resource_removal, busy_rtc
permanently_disable_fw_update, write_booster_en
wb_buf_flush_en, wb_buf_flush_h8

Examples:

To create lun 4 please:
use ufs set_lun 4 num_allocunits xxx to set size
ufs commit
scsi scan

To change some value in the configuration descriptor
ufs set_cfg_desc num_shared_write_booster_buffer_allocunits 100000
ufs set_cfg_desc write_booster_buffer_type 1
ufs commit

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 cmd/ufs.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 86 insertions(+), 8 deletions(-)

diff --git a/cmd/ufs.c b/cmd/ufs.c
index 790dab50f18..bb0e2fd3a67 100644
--- a/cmd/ufs.c
+++ b/cmd/ufs.c
@@ -8,31 +8,109 @@
 #include <command.h>
 #include <ufs.h>
 #include <vsprintf.h>
-#include <linux/string.h>

 static int do_ufs(struct cmd_tbl *cmdtp, int flag, int argc, char
*const argv[])
 {
- int dev, ret;
+ int dev;

  if (argc >= 2) {
  if (!strcmp(argv[1], "init")) {
  if (argc == 3) {
  dev = dectoul(argv[2], NULL);
- ret = ufs_probe_dev(dev);
- if (ret)
+ if (!ufs_probe_dev(dev))
  return CMD_RET_FAILURE;
  } else {
  ufs_probe();
  }
-
  return CMD_RET_SUCCESS;
  }
- }
+#if IS_ENABLED(CONFIG_UFS_TOOL)
+ if (!strcmp(argv[1], "query")) {
+ int lun = -1;
+ int idn = -1;
+
+ if (argc <= 3) {
+ printf("usage: lun idn");
+ return CMD_RET_FAILURE;
+ }
+
+ lun  = dectoul(argv[2], NULL);
+ idn  = dectoul(argv[3], NULL);
+
+ return ufs_tool_query(lun, idn);
+ }
+
+ if (!strcmp(argv[1], "set_lun")) {
+ int lun;
+ u32 val;
+
+ if (argc <= 4) {
+ ufs_tool_help();
+ return CMD_RET_FAILURE;
+ }
+ lun  = dectoul(argv[2], NULL);
+ val  = dectoul(argv[4], NULL);
+ return ufs_tool_set_lun(lun, argv[3], val);
+ }
+ if (!strcmp(argv[1], "set_dev_desc")) {
+ const char *name;
+ u32 val;

- return CMD_RET_USAGE;
+ if (argc <= 3) {
+ ufs_tool_help();
+ return CMD_RET_FAILURE;
+ }
+ name = argv[2];
+ val  = dectoul(argv[3], NULL);
+ return ufs_tool_set_device_desc(name, val);
+ }
+ if (!strcmp(argv[1], "set_cfg_desc")) {
+ const char *name;
+ u32 val;
+
+ if (argc <= 3) {
+ ufs_tool_help();
+ return CMD_RET_FAILURE;
+ }
+ name = argv[2];
+ val  = dectoul(argv[3], NULL);
+ return ufs_tool_set_config_desc(name, val);
+ }
+
+ if (!strcmp(argv[1], "flag")) {
+ if (argc == 2) {
+ printf("usage: flag [flag name]");
+ ufs_tool_help();
+ return CMD_RET_FAILURE;
+ }
+ return ufs_tool_query_flag(argv[2]);
+ }
+
+ if (!strcmp(argv[1], "commit"))
+ return ufs_tool_commit();
+
+ if (!strcmp(argv[1], "clearall"))
+ return ufs_tool_clearall();
+ if (!strcmp(argv[1], "luns")) {
+ ufs_tool_print_luns();
+ return 0;
+ }
+ }
+ ufs_tool_help();
+#endif
+ return CMD_RET_FAILURE;
 }

-U_BOOT_CMD(ufs, 3, 1, do_ufs,
+U_BOOT_CMD(ufs, 5, 1, do_ufs,
     "UFS sub-system",
     "init [dev] - init UFS subsystem\n"
+#if IS_ENABLED(CONFIG_UFS_TOOL)
+    "query [LUN] [IDN]\n"
+    "set_lun [LUN] [parm name] [value]\n"
+    "set_cfg_des   [parm name] [value]\n"
+    "set_dev_desc  [parm name] [value]\n"
+    "luns - prints luns\n"
+    "flag [flag name] Query Flags\n"
+    "commit - writes luns configuration\n"
+#endif
 );
-- 
2.43.0

--000000000000b8b65206531a3861
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0003-ufs-Extend-the-ufs-user-interface.patch"
Content-Disposition: attachment; 
	filename="0003-ufs-Extend-the-ufs-user-interface.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mptm6a220>
X-Attachment-Id: f_mptm6a220

RnJvbSBjZmMyNmJlNzk0YmEwYzY1NThhMWZjYWJlNTRiZTc0ZjAxM2UzZWMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXogQmVuIFllaHVkYSA8cmF6LmJlbnllaHVkYUBtb2JpbGV5
ZS5jb20+CkRhdGU6IFRodSwgMjggTWF5IDIwMjYgMTU6MDg6MjggKzAzMDAKU3ViamVjdDogW1BB
VENIIDMvNF0gdWZzOiBFeHRlbmQgdGhlIHVmcyB1c2VyIGludGVyZmFjZQoKUHJvdmlkZSBhIHVz
ZXIgaW50ZXJmYWNlIGFuZCBoZWxwIHRvIHVmcyB0b29sLgoJcXVlcnkgW2x1bl0gW2lkbl06CgkJ
KDBoKSBEZXZpY2UgZGVzYwogICAgICAgIAkoN2gpIEdlb21ldHJ5IGRlc2MKCQkoOGgpIFBvd2Vy
IGRlc2MKCQkoMmgpIFVuaXQgZGVzYwoJCSgxaCkgQ29uZmlnIGRlc2MKCiAgICAgICAgc2V0X2x1
biBbTFVOXSBbcGFybV0KICAgICAgICAgICAgICAgIGx1X2VuYWJsZQogICAgICAgICAgICAgICAg
Ym9vdF9sdW5faWQKICAgICAgICAgICAgICAgIGx1X3dyaXRlX3Byb3RlY3QKICAgICAgICAgICAg
ICAgIG1lbW9yeV90eXBlCiAgICAgICAgICAgICAgICBkYXRhX3JlbGlhYmlsaXR5CiAgICAgICAg
ICAgICAgICBudW1fYWxsb2N1bml0cwogICAgICAgICAgICAgICAgbG9naWNhbF9ibG9ja19zaXpl
CiAgICAgICAgICAgICAgICBwcm92aXNpb25pbmdfdHlwZQogICAgICAgICAgICAgICAgY29udGV4
dF9jYXBhYmlsaXRpZXMKICAgICAgICAgICAgICAgIGx1X251bV93cml0ZV9ib29zdGVyX2J1ZmZl
cl9hbGxvY3VuaXRzCgoJc2V0X2Rldl9kZXNjIFtwYXJtXSBbdmFsdWVdCgkJZGVzY3JpcHRvcl9p
ZG4sIGRldmljZSwgZGV2aWNlX2NsYXNzCgkJZGV2aWNlX3N1Yl9jbGFzcywgbnVtYmVyX2x1LCBi
b290X2VuYWJsZQoJCWRlc2NyX2FjY2Vzc19lbiwgaW5pdF9wb3dlcl9tb2RlLCBoaWdoX3ByaW9y
aXR5X2x1bgoJCXNlY3VyZV9yZW1vdmFsX3R5cGUsIGluaXRhY3RpdmVfaWNjX2xldmVsCgkJcXVl
dWVfZGVwdGgsIHdyaXRlX2Jvb3N0ZXJfYnVmZmVyX3ByZXNlcnZlX3VzZXJfc3BhY2VfZW4KCQl3
cml0ZV9ib29zdGVyX2J1ZmZlcl90eXBlLCBzcGVjX3ZlcnNpb24sIG1hbnVmYWN0dXJlcl9pZAoJ
CXBlcmlvZGljX3J0Y191cGRhdGUsIGRldmljZV92ZXJzaW9uLCBwc2FfbWF4X2RhdGFfc2l6ZQoJ
CWV4dGVuZGVkX3Vmc19mZWF0dXJlc19zdXBwb3J0LAoJCW51bV9zaGFyZWRfd3JpdGVfYm9vc3Rl
cl9idWZmZXJfYWxsb2N1bml0cwoJCXdyaXRlX2Jvb3N0ZXJfYnVmZmVyX3ByZXNlcnZlX3VzZXJf
c3BhY2VfZW4KCglzZXRfY2ZnX2Rlc2MgW3Bhcm1dIFt2YWx1ZV0KCQlsZW5ndGgsIGRlc2NyaXB0
b3JfaWRuLCBjb25mX2Rlc2NfY29udGludWUKCQlib290X2VuYWJsZSwgZGVzY3JfYWNjZXNzX2Vu
LCBpbml0cG93ZXJfbW9kZQoJCWhpZ2hfcHJpb3JpdHlfbHVuLCBzZWN1cmVfcmVtb3ZhbF90eXBl
LCBpbml0X2FjdGl2ZV9pY2NfbGV2ZWwKCQlwZXJpb2RpY19ydGNfdXBkYXRlLCByZXNlcnZlZF9I
UEIsIHJwbWJfcmVnaW9uX2VuYWJsZQoJCXJwbWJfcmVnaW9uMV9zaXplLCBycG1iX3JlZ2lvbjJf
c2l6ZSwgcnBtYl9yZWdpb24zX3NpemUKCQl3cml0ZV9ib29zdGVyX2J1ZmZlcl9wcmVzZXJ2ZV91
c2VyX3NwYWNlX2VuCgkJd3JpdGVfYm9vc3Rlcl9idWZmZXJfdHlwZQoJCW51bV9zaGFyZWRfd3Jp
dGVfYm9vc3Rlcl9idWZmZXJfYWxsb2N1bml0cwoKCWZsYWcgW2ZsYWcgbmFtZV0KCQlkZXZpY2Vp
bml0LCBwZXJtYW5lbnRfd3BlLCBwd3Jfb25fd3BlLCBia29wc19lbiwgbGlmZV9zcGFuX21vZGUK
CQlwdXJnZV9lbmFibGUsIGZwaHlfcmVzb3VyY2VfcmVtb3ZhbCwgYnVzeV9ydGMKCQlwZXJtYW5l
bnRseV9kaXNhYmxlX2Z3X3VwZGF0ZSwgd3JpdGVfYm9vc3Rlcl9lbgoJCXdiX2J1Zl9mbHVzaF9l
biwgd2JfYnVmX2ZsdXNoX2g4CgpFeGFtcGxlczoKClRvIGNyZWF0ZSBsdW4gNCBwbGVhc2U6Cgl1
c2UgdWZzIHNldF9sdW4gNCBudW1fYWxsb2N1bml0cyB4eHggdG8gc2V0IHNpemUKCXVmcyBjb21t
aXQKCXNjc2kgc2NhbgoKVG8gY2hhbmdlIHNvbWUgdmFsdWUgaW4gdGhlIGNvbmZpZ3VyYXRpb24g
ZGVzY3JpcHRvcgoJdWZzIHNldF9jZmdfZGVzYyBudW1fc2hhcmVkX3dyaXRlX2Jvb3N0ZXJfYnVm
ZmVyX2FsbG9jdW5pdHMgMTAwMDAwCgl1ZnMgc2V0X2NmZ19kZXNjIHdyaXRlX2Jvb3N0ZXJfYnVm
ZmVyX3R5cGUgMQoJdWZzIGNvbW1pdAoKU2lnbmVkLW9mZi1ieTogUmF6IEJlbiBZZWh1ZGEgPHJh
ei5iZW55ZWh1ZGFAbW9iaWxleWUuY29tPgotLS0KIGNtZC91ZnMuYyB8IDk0ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA4NiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2NtZC91
ZnMuYyBiL2NtZC91ZnMuYwppbmRleCA3OTBkYWI1MGYxOC4uYmIwZTJmZDNhNjcgMTAwNjQ0Ci0t
LSBhL2NtZC91ZnMuYworKysgYi9jbWQvdWZzLmMKQEAgLTgsMzEgKzgsMTA5IEBACiAjaW5jbHVk
ZSA8Y29tbWFuZC5oPgogI2luY2x1ZGUgPHVmcy5oPgogI2luY2x1ZGUgPHZzcHJpbnRmLmg+Ci0j
aW5jbHVkZSA8bGludXgvc3RyaW5nLmg+CiAKIHN0YXRpYyBpbnQgZG9fdWZzKHN0cnVjdCBjbWRf
dGJsICpjbWR0cCwgaW50IGZsYWcsIGludCBhcmdjLCBjaGFyICpjb25zdCBhcmd2W10pCiB7Ci0J
aW50IGRldiwgcmV0OworCWludCBkZXY7CiAKIAlpZiAoYXJnYyA+PSAyKSB7CiAJCWlmICghc3Ry
Y21wKGFyZ3ZbMV0sICJpbml0IikpIHsKIAkJCWlmIChhcmdjID09IDMpIHsKIAkJCQlkZXYgPSBk
ZWN0b3VsKGFyZ3ZbMl0sIE5VTEwpOwotCQkJCXJldCA9IHVmc19wcm9iZV9kZXYoZGV2KTsKLQkJ
CQlpZiAocmV0KQorCQkJCWlmICghdWZzX3Byb2JlX2RldihkZXYpKQogCQkJCQlyZXR1cm4gQ01E
X1JFVF9GQUlMVVJFOwogCQkJfSBlbHNlIHsKIAkJCQl1ZnNfcHJvYmUoKTsKIAkJCX0KLQogCQkJ
cmV0dXJuIENNRF9SRVRfU1VDQ0VTUzsKIAkJfQotCX0KKyNpZiBJU19FTkFCTEVEKENPTkZJR19V
RlNfVE9PTCkKKwkJaWYgKCFzdHJjbXAoYXJndlsxXSwgInF1ZXJ5IikpIHsKKwkJCWludCBsdW4g
PSAtMTsKKwkJCWludCBpZG4gPSAtMTsKKworCQkJaWYgKGFyZ2MgPD0gMykgeworCQkJCXByaW50
ZigidXNhZ2U6IGx1biBpZG4iKTsKKwkJCQlyZXR1cm4gQ01EX1JFVF9GQUlMVVJFOworCQkJfQor
CisJCQlsdW4gID0gZGVjdG91bChhcmd2WzJdLCBOVUxMKTsKKwkJCWlkbiAgPSBkZWN0b3VsKGFy
Z3ZbM10sIE5VTEwpOworCisJCQlyZXR1cm4gdWZzX3Rvb2xfcXVlcnkobHVuLCBpZG4pOworCQl9
CisKKwkJaWYgKCFzdHJjbXAoYXJndlsxXSwgInNldF9sdW4iKSkgeworCQkJaW50IGx1bjsKKwkJ
CXUzMiB2YWw7CisKKwkJCWlmIChhcmdjIDw9IDQpIHsKKwkJCQl1ZnNfdG9vbF9oZWxwKCk7CisJ
CQkJcmV0dXJuIENNRF9SRVRfRkFJTFVSRTsKKwkJCX0KKwkJCWx1biAgPSBkZWN0b3VsKGFyZ3Zb
Ml0sIE5VTEwpOworCQkJdmFsICA9IGRlY3RvdWwoYXJndls0XSwgTlVMTCk7CisJCQlyZXR1cm4g
dWZzX3Rvb2xfc2V0X2x1bihsdW4sIGFyZ3ZbM10sIHZhbCk7CisJCX0KKwkJaWYgKCFzdHJjbXAo
YXJndlsxXSwgInNldF9kZXZfZGVzYyIpKSB7CisJCQljb25zdCBjaGFyICpuYW1lOworCQkJdTMy
IHZhbDsKIAotCXJldHVybiBDTURfUkVUX1VTQUdFOworCQkJaWYgKGFyZ2MgPD0gMykgeworCQkJ
CXVmc190b29sX2hlbHAoKTsKKwkJCQlyZXR1cm4gQ01EX1JFVF9GQUlMVVJFOworCQkJfQorCQkJ
bmFtZSA9IGFyZ3ZbMl07CisJCQl2YWwgID0gZGVjdG91bChhcmd2WzNdLCBOVUxMKTsKKwkJCXJl
dHVybiB1ZnNfdG9vbF9zZXRfZGV2aWNlX2Rlc2MobmFtZSwgdmFsKTsKKwkJfQorCQlpZiAoIXN0
cmNtcChhcmd2WzFdLCAic2V0X2NmZ19kZXNjIikpIHsKKwkJCWNvbnN0IGNoYXIgKm5hbWU7CisJ
CQl1MzIgdmFsOworCisJCQlpZiAoYXJnYyA8PSAzKSB7CisJCQkJdWZzX3Rvb2xfaGVscCgpOwor
CQkJCXJldHVybiBDTURfUkVUX0ZBSUxVUkU7CisJCQl9CisJCQluYW1lID0gYXJndlsyXTsKKwkJ
CXZhbCAgPSBkZWN0b3VsKGFyZ3ZbM10sIE5VTEwpOworCQkJcmV0dXJuIHVmc190b29sX3NldF9j
b25maWdfZGVzYyhuYW1lLCB2YWwpOworCQl9CisKKwkJaWYgKCFzdHJjbXAoYXJndlsxXSwgImZs
YWciKSkgeworCQkJaWYgKGFyZ2MgPT0gMikgeworCQkJCXByaW50ZigidXNhZ2U6IGZsYWcgW2Zs
YWcgbmFtZV0iKTsKKwkJCQl1ZnNfdG9vbF9oZWxwKCk7CisJCQkJcmV0dXJuIENNRF9SRVRfRkFJ
TFVSRTsKKwkJCX0KKwkJCXJldHVybiB1ZnNfdG9vbF9xdWVyeV9mbGFnKGFyZ3ZbMl0pOworCQl9
CisKKwkJaWYgKCFzdHJjbXAoYXJndlsxXSwgImNvbW1pdCIpKQorCQkJcmV0dXJuIHVmc190b29s
X2NvbW1pdCgpOworCisJCWlmICghc3RyY21wKGFyZ3ZbMV0sICJjbGVhcmFsbCIpKQorCQkJcmV0
dXJuIHVmc190b29sX2NsZWFyYWxsKCk7CisJCWlmICghc3RyY21wKGFyZ3ZbMV0sICJsdW5zIikp
IHsKKwkJCXVmc190b29sX3ByaW50X2x1bnMoKTsKKwkJCXJldHVybiAwOworCQl9CisJfQorCXVm
c190b29sX2hlbHAoKTsKKyNlbmRpZgorCXJldHVybiBDTURfUkVUX0ZBSUxVUkU7CiB9CiAKLVVf
Qk9PVF9DTUQodWZzLCAzLCAxLCBkb191ZnMsCitVX0JPT1RfQ01EKHVmcywgNSwgMSwgZG9fdWZz
LAogCSAgICJVRlMgc3ViLXN5c3RlbSIsCiAJICAgImluaXQgW2Rldl0gLSBpbml0IFVGUyBzdWJz
eXN0ZW1cbiIKKyNpZiBJU19FTkFCTEVEKENPTkZJR19VRlNfVE9PTCkKKwkgICAicXVlcnkgW0xV
Tl0gW0lETl1cbiIKKwkgICAic2V0X2x1biBbTFVOXSBbcGFybSBuYW1lXSBbdmFsdWVdXG4iCisJ
ICAgInNldF9jZmdfZGVzICAgW3Bhcm0gbmFtZV0gW3ZhbHVlXVxuIgorCSAgICJzZXRfZGV2X2Rl
c2MgIFtwYXJtIG5hbWVdIFt2YWx1ZV1cbiIKKwkgICAibHVucyAtIHByaW50cyBsdW5zXG4iCisJ
ICAgImZsYWcgW2ZsYWcgbmFtZV0gUXVlcnkgRmxhZ3NcbiIKKwkgICAiY29tbWl0IC0gd3JpdGVz
IGx1bnMgY29uZmlndXJhdGlvblxuIgorI2VuZGlmCiApOwotLSAKMi40My4wCgo=
--000000000000b8b65206531a3861--
