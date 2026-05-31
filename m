Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33913CD6E52
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 14:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED369847C3;
	Sun, 31 May 2026 16:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="anZL3EtP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E7E58405A; Sun, 31 May 2026 12:06:36 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E4D8838D7
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 12:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raziebe@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4600cbb06deso163292f8f.1
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 03:06:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780221994; cv=none;
 d=google.com; s=arc-20240605;
 b=HmTK5Tcacp9+ufmOW6tsu6XcA1rZHZaCMpfRCEGeiKUi9H4DWu+cDmkq3SqdjK7/6b
 syVHAD5Lu1xXtpN6/7rlQ2+dQK0T8oIQJsg9xYwqmFdAPdAYgWEMEnCzaalnjZaFgODz
 ofC5wGDGOKRDaSS5j6DIe/2+vYClVE5jOeBERI0s1vwyqrHkCw/Mvy/q0d1yT2QeFIZa
 y7nDUSCqe4WNhsqjjyHbAHXtwFYW2P6zCa/RKWoC/sZI/jdxoCePC9QrTBwLyD4udSai
 +dXI+mB2j9kw8TWI/id0j6d8QVNlr7gsN960PTUwx5zq1TeAFYxxzTFrw4614akgwRKX
 2Z+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=xHh0bYqUvcvHNoGjwCZvI2EPlQXRGGzZcbFAW+3CF1o=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=daEnGdNo1cSdnJwirxRXE2IPO3jlJ9oXjC2Jbk+w5CsHha+uC47jHYjxztpGguFUmp
 7G5vj2EXj4YM0tQChfPMlGM5h6vECf/k8g0118yH5wJTs+9wqgeR4xwe4cnVD68PjYnT
 tZAWGimBz33Fam9SP0xF38ZFqxeZv8zv2HRsZHQFgwgaWpvGdzGSi1cWPrCM6ZadI1JQ
 WnVKSL8G+LEehlCgfydvDfRJC6GBdwLbWuUmwUuj7I8nqriGBMK3dMapvD0/FUiRkySW
 peCcwU7Dim6xYfdha2YFJM4Zj8M64xJe0JHT1rUybHmBIhpyyqhuIVIAbuky+hgw7w1h
 WGnw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780221994; x=1780826794; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xHh0bYqUvcvHNoGjwCZvI2EPlQXRGGzZcbFAW+3CF1o=;
 b=anZL3EtP+88oaN/BOVS/YiC6owkojrRv49ELVOYYq+evY9SrhE1r8bjjohG/g/leNS
 5FDeLlDgHwDjxtNSK6OWrBdtbZp3sIdeoloJR0i4g5fiqrjOwLcQIke06OLhng1Hx7MC
 WZEjrxXNmg+t1d334yr09NIId+CEkTVzbIQpZ3He7WscFJGqLUL6pHlYxspLQ2KMJHAk
 Nw5UQN0ea7okZlynEtIfc6oaTvn5RiTKIHZza2jDZRWY5sMIqCFZL/K8mog8eBK+at85
 28ruQ6RH45nocBm3CDdgZb/cs4WrLy6KbF6uhOKvzmptXuCA1qxPWvCkBCgwZ5GciTAe
 ow0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780221994; x=1780826794;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xHh0bYqUvcvHNoGjwCZvI2EPlQXRGGzZcbFAW+3CF1o=;
 b=TfVSqmkxEqCLqJVwqeDy8B9JrlKA5Sw5hqeIkOK6QHQN5+4e5yamxg+kqctwhSdgto
 w9Ss+BMfeXAXQ3iljYFDBA7TZ3hr1zA9zQN1Sy3gExjeyJZRGBpUFo80krAAXNSpmznp
 CWcaaRQ4KsEUMbnpz3J3cQ6OeeYHocRxpnDOU/oxcjGAmyvD+DBY1sLBkKPmezpeBgaP
 t1LQL4FAXosaV1jU2Z2nezoMFQ4T3OQ6nQ+jX24Wam51peBlRk8s1ZlXv8lWCXaeCQnj
 YHAJ6iK11DtG2BN9E2xyHpvH3m1WVwiXw1pg51I8C7tpreXx0JGKp/JExq75GbXHJsk7
 2EgA==
X-Gm-Message-State: AOJu0YxQ6ANO6J/dwXJ1S9xj9dlt1p/rmKubvCFxfEPM9bKQ/diTV2zS
 vPmsZaWpfjzWRVsUrJy+jcDzBz+kJc6gZeC6MPfm+cnc/pnlOmKfa+1xgjzaZK8HCyXSfDVEjVO
 aADp/sVecofCR9MRCqBS1cpEyhSwe2ewp0Xdz
X-Gm-Gg: Acq92OGnVMqp+2RMW0Afjfx1uPR1qx1WEJgcP/vmYFCFFCoBAti1CfWPQp5YU9DXSmZ
 t59F3eTTT+REQP4lCFobvQSehZwPBauTsP3S/wQ/uqEFfc9ufYdfkI8+AXb8ab0ei7kWksV4aMY
 3TZXvRJixeC3p+PWAESDXi0ueo84L3QI2YsSNwHB/OQNFZSHjKWdrIvK10NWlF47O2s0LHmg5AP
 JZc4kFw3pxWhD8ekVIn4w5D0j8MiAWaBzKL3AHWMBp71hlohIkiDDlDh1peBxvWRZZfh/a0yFuu
 ltQ64/jPtrhbwceMefTYyZ2lT2UGMYeHHX0mV4od70mRhFu8aA==
X-Received: by 2002:a05:6000:25ee:b0:44f:69f4:39b5 with SMTP id
 ffacd0b85a97d-45ef139b5camr13743745f8f.29.1780221993831; Sun, 31 May 2026
 03:06:33 -0700 (PDT)
MIME-Version: 1.0
From: Raz <raziebe@gmail.com>
Date: Sun, 31 May 2026 13:06:21 +0300
X-Gm-Features: AVHnY4Jc_daci2aVnNJPJaL11F6t0emLDyqFEfbsiE1JzLKXmCKeQecfRgjYtOY
Message-ID: <CAPB=Z-rJH2DGeMfRWovW3sXdCs9U8xWrTORdE+d6Jkk4-Fn-Hw@mail.gmail.com>
Subject: UFS:PATCH[4/4]
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="00000000000090763806531a3b27"
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

--00000000000090763806531a3b27
Content-Type: text/plain; charset="UTF-8"

From 41b2b47a9136b182201609f8361dbe43fc5554e2 Mon Sep 17 00:00:00 2001
From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
Date: Thu, 28 May 2026 15:08:41 +0300
Subject: [PATCH 4/4] ufs: add ufs tool the configuration

Add the ufs tool to the Kconfig and Makefile
Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 drivers/ufs/Kconfig  | 48 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/Makefile |  1 +
 2 files changed, 49 insertions(+)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 49472933de3..35ef6bb3860 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -8,6 +8,54 @@ config UFS
    This selects support for Universal Flash Subsystem (UFS).
    Say Y here if you want UFS Support.

+config UFS_TOOL
+ bool "ufs tool"
+ depends on UFS
+ help
+ query [lun] [idn]:
+ (0h) Device desc
+ (7h) Geometry desc
+ (8h) Power desc
+ (2h) Unit desc
+ (1h) Config desc
+
+ set_lun [LUN] [parm]
+ lu_enable, boot_lun_id, lu_write_protect memory_type
+ data_reliability num_allocunits logical_block_size
+ provisioning_type context_capabilities
+ lu_num_write_booster_buffer_allocunits
+
+ set_dev_desc [parm] [value]
+ descriptor_idn, device, device_class
+ device_sub_class, number_lu, boot_enable
+ descr_access_en, init_power_mode, high_priority_lun
+ secure_removal_type, initactive_icc_level
+ queue_depth, write_booster_buffer_preserve_user_space_en
+ write_booster_buffer_type, spec_version, manufacturer_id
+ periodic_rtc_update, device_version, psa_max_data_size
+ extended_ufs_features_support,
+ num_shared_write_booster_buffer_allocunits
+ write_booster_buffer_preserve_user_space_en
+
+ set_cfg_desc [parm] [value]
+ length, descriptor_idn, conf_desc_continue
+ boot_enable, descr_access_en, initpower_mode
+ high_priority_lun, secure_removal_type, init_active_icc_level
+ periodic_rtc_update, reserved_HPB, rpmb_region_enable
+ rpmb_region1_size, rpmb_region2_size, rpmb_region3_size
+ write_booster_buffer_preserve_user_space_en
+ write_booster_buffer_type
+ num_shared_write_booster_buffer_allocunits
+
+ flag [flag name]
+ deviceinit, permanent_wpe, pwr_on_wpe, bkops_en, life_span_mode
+ purge_enable, fphy_resource_removal, busy_rtc
+ permanently_disable_fw_update, write_booster_en
+ wb_buf_flush_en, wb_buf_flush_h8
+
+ luns
+ list the current luns
+
 config UFS_AMD_VERSAL2
  bool "AMD Versal Gen 2 UFS controller platform driver"
  depends on UFS && ZYNQMP_FIRMWARE
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index e7f3c1d30c4..0e472782261 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -4,6 +4,7 @@
 #

 obj-$(CONFIG_UFS) += ufs-uclass.o
+obj-$(CONFIG_UFS_TOOL) += ufs_tool.o
 obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
 obj-$(CONFIG_UFS_CADENCE) += cdns-platform.o
 obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o
-- 
2.43.0

--00000000000090763806531a3b27
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0004-ufs-add-ufs-tool-the-configuration.patch"
Content-Disposition: attachment; 
	filename="0004-ufs-add-ufs-tool-the-configuration.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mptm781h0>
X-Attachment-Id: f_mptm781h0

RnJvbSA0MWIyYjQ3YTkxMzZiMTgyMjAxNjA5ZjgzNjFkYmU0M2ZjNTU1NGUyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXogQmVuIFllaHVkYSA8cmF6LmJlbnllaHVkYUBtb2JpbGV5
ZS5jb20+CkRhdGU6IFRodSwgMjggTWF5IDIwMjYgMTU6MDg6NDEgKzAzMDAKU3ViamVjdDogW1BB
VENIIDQvNF0gdWZzOiBhZGQgdWZzIHRvb2wgdGhlIGNvbmZpZ3VyYXRpb24KCkFkZCB0aGUgdWZz
IHRvb2wgdG8gdGhlIEtjb25maWcgYW5kIE1ha2VmaWxlClNpZ25lZC1vZmYtYnk6IFJheiBCZW4g
WWVodWRhIDxyYXouYmVueWVodWRhQG1vYmlsZXllLmNvbT4KLS0tCiBkcml2ZXJzL3Vmcy9LY29u
ZmlnICB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBk
cml2ZXJzL3Vmcy9NYWtlZmlsZSB8ICAxICsKIDIgZmlsZXMgY2hhbmdlZCwgNDkgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdWZzL0tjb25maWcgYi9kcml2ZXJzL3Vmcy9LY29u
ZmlnCmluZGV4IDQ5NDcyOTMzZGUzLi4zNWVmNmJiMzg2MCAxMDA2NDQKLS0tIGEvZHJpdmVycy91
ZnMvS2NvbmZpZworKysgYi9kcml2ZXJzL3Vmcy9LY29uZmlnCkBAIC04LDYgKzgsNTQgQEAgY29u
ZmlnIFVGUwogCSAgVGhpcyBzZWxlY3RzIHN1cHBvcnQgZm9yIFVuaXZlcnNhbCBGbGFzaCBTdWJz
eXN0ZW0gKFVGUykuCiAJICBTYXkgWSBoZXJlIGlmIHlvdSB3YW50IFVGUyBTdXBwb3J0LgogCitj
b25maWcgVUZTX1RPT0wKKwlib29sICJ1ZnMgdG9vbCIKKwlkZXBlbmRzIG9uIFVGUworCWhlbHAK
KwlxdWVyeSBbbHVuXSBbaWRuXToKKwkJKDBoKSBEZXZpY2UgZGVzYworCQkoN2gpIEdlb21ldHJ5
IGRlc2MKKwkJKDhoKSBQb3dlciBkZXNjCisJCSgyaCkgVW5pdCBkZXNjCisJCSgxaCkgQ29uZmln
IGRlc2MKKworCQlzZXRfbHVuIFtMVU5dIFtwYXJtXQorCQkJbHVfZW5hYmxlLCBib290X2x1bl9p
ZCwgbHVfd3JpdGVfcHJvdGVjdCBtZW1vcnlfdHlwZQorCQkJZGF0YV9yZWxpYWJpbGl0eSBudW1f
YWxsb2N1bml0cyBsb2dpY2FsX2Jsb2NrX3NpemUKKwkJCXByb3Zpc2lvbmluZ190eXBlIGNvbnRl
eHRfY2FwYWJpbGl0aWVzCisJCQlsdV9udW1fd3JpdGVfYm9vc3Rlcl9idWZmZXJfYWxsb2N1bml0
cworCisJCXNldF9kZXZfZGVzYyBbcGFybV0gW3ZhbHVlXQorCQkJZGVzY3JpcHRvcl9pZG4sIGRl
dmljZSwgZGV2aWNlX2NsYXNzCisJCQlkZXZpY2Vfc3ViX2NsYXNzLCBudW1iZXJfbHUsIGJvb3Rf
ZW5hYmxlCisJCQlkZXNjcl9hY2Nlc3NfZW4sIGluaXRfcG93ZXJfbW9kZSwgaGlnaF9wcmlvcml0
eV9sdW4KKwkJCXNlY3VyZV9yZW1vdmFsX3R5cGUsIGluaXRhY3RpdmVfaWNjX2xldmVsCisJCQlx
dWV1ZV9kZXB0aCwgd3JpdGVfYm9vc3Rlcl9idWZmZXJfcHJlc2VydmVfdXNlcl9zcGFjZV9lbgor
CQkJd3JpdGVfYm9vc3Rlcl9idWZmZXJfdHlwZSwgc3BlY192ZXJzaW9uLCBtYW51ZmFjdHVyZXJf
aWQKKwkJCXBlcmlvZGljX3J0Y191cGRhdGUsIGRldmljZV92ZXJzaW9uLCBwc2FfbWF4X2RhdGFf
c2l6ZQorCQkJZXh0ZW5kZWRfdWZzX2ZlYXR1cmVzX3N1cHBvcnQsCisJCQludW1fc2hhcmVkX3dy
aXRlX2Jvb3N0ZXJfYnVmZmVyX2FsbG9jdW5pdHMKKwkJCXdyaXRlX2Jvb3N0ZXJfYnVmZmVyX3By
ZXNlcnZlX3VzZXJfc3BhY2VfZW4KKworCQlzZXRfY2ZnX2Rlc2MgW3Bhcm1dIFt2YWx1ZV0KKwkJ
CWxlbmd0aCwgZGVzY3JpcHRvcl9pZG4sIGNvbmZfZGVzY19jb250aW51ZQorCQkJYm9vdF9lbmFi
bGUsIGRlc2NyX2FjY2Vzc19lbiwgaW5pdHBvd2VyX21vZGUKKwkJCWhpZ2hfcHJpb3JpdHlfbHVu
LCBzZWN1cmVfcmVtb3ZhbF90eXBlLCBpbml0X2FjdGl2ZV9pY2NfbGV2ZWwKKwkJCXBlcmlvZGlj
X3J0Y191cGRhdGUsIHJlc2VydmVkX0hQQiwgcnBtYl9yZWdpb25fZW5hYmxlCisJCQlycG1iX3Jl
Z2lvbjFfc2l6ZSwgcnBtYl9yZWdpb24yX3NpemUsIHJwbWJfcmVnaW9uM19zaXplCisJCQl3cml0
ZV9ib29zdGVyX2J1ZmZlcl9wcmVzZXJ2ZV91c2VyX3NwYWNlX2VuCisJCQl3cml0ZV9ib29zdGVy
X2J1ZmZlcl90eXBlCisJCQludW1fc2hhcmVkX3dyaXRlX2Jvb3N0ZXJfYnVmZmVyX2FsbG9jdW5p
dHMKKworCQlmbGFnIFtmbGFnIG5hbWVdCisJCQlkZXZpY2Vpbml0LCBwZXJtYW5lbnRfd3BlLCBw
d3Jfb25fd3BlLCBia29wc19lbiwgbGlmZV9zcGFuX21vZGUKKwkJCXB1cmdlX2VuYWJsZSwgZnBo
eV9yZXNvdXJjZV9yZW1vdmFsLCBidXN5X3J0YworCQkJcGVybWFuZW50bHlfZGlzYWJsZV9md191
cGRhdGUsIHdyaXRlX2Jvb3N0ZXJfZW4KKwkJCXdiX2J1Zl9mbHVzaF9lbiwgd2JfYnVmX2ZsdXNo
X2g4CisKKwkJbHVucworCQkJbGlzdCB0aGUgY3VycmVudCBsdW5zCisKIGNvbmZpZyBVRlNfQU1E
X1ZFUlNBTDIKIAlib29sICJBTUQgVmVyc2FsIEdlbiAyIFVGUyBjb250cm9sbGVyIHBsYXRmb3Jt
IGRyaXZlciIKIAlkZXBlbmRzIG9uIFVGUyAmJiBaWU5RTVBfRklSTVdBUkUKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdWZzL01ha2VmaWxlIGIvZHJpdmVycy91ZnMvTWFrZWZpbGUKaW5kZXggZTdmM2Mx
ZDMwYzQuLjBlNDcyNzgyMjYxIDEwMDY0NAotLS0gYS9kcml2ZXJzL3Vmcy9NYWtlZmlsZQorKysg
Yi9kcml2ZXJzL3Vmcy9NYWtlZmlsZQpAQCAtNCw2ICs0LDcgQEAKICMKIAogb2JqLSQoQ09ORklH
X1VGUykgKz0gdWZzLXVjbGFzcy5vCitvYmotJChDT05GSUdfVUZTX1RPT0wpICs9IHVmc190b29s
Lm8KIG9iai0kKENPTkZJR19VRlNfQU1EX1ZFUlNBTDIpICs9IHVmcy1hbWQtdmVyc2FsMi5vIHVm
c2hjZC1kd2Mubwogb2JqLSQoQ09ORklHX1VGU19DQURFTkNFKSArPSBjZG5zLXBsYXRmb3JtLm8K
IG9iai0kKENPTkZJR19VRlNfTUVESUFURUspICs9IHVmcy1tZWRpYXRlay5vCi0tIAoyLjQzLjAK
Cg==
--00000000000090763806531a3b27--
