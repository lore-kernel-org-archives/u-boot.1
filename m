Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05970CD6E52
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 14:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 813EF84671;
	Sun, 31 May 2026 16:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AK0thesN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AB2A8405A; Sun, 31 May 2026 12:04:49 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96571838D7
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 12:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raziebe@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49039a8851fso94317495e9.2
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 03:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780221887; cv=none;
 d=google.com; s=arc-20240605;
 b=a/Iq1xnu9alz3gYkNgXGT28pRDZncixSTmKngy0fKXKWlppZKdOuI1kLteLiEqwHO7
 I0zb0AYeWZHGBdVAD5l2tz9at6YwL9EJsbge8VJuoj3hH/KeZuPl8e6sKWbbgRMwQDBX
 SCRkFqFisycbRdhAdYg7TjdSDRx5y2B4tvtE4TUrylX4H1OnLmrsTH2M2uyvJ6rq/4La
 zXy4DJvlb4cfvBsap1AH6B+lMjJf0JjHqW6uVzANEB6R8s9EIvnvvtQt17WwRSjMRmQj
 wrNjrMqxfeuL+nS07BY0bSHu1dTDDVKIBZwmJe6vBqq6Cqx62zHRmXbc6I0vtVKyQizf
 B9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=pef0Z/LpMHh2qOBIZBTXlXvt1oQYlNPgKQQJCET+WN8=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=IXeSRNoOZbXNpC/zmAOgOM3T5DolXOHvLbFwRDIr61v98SdiKX+F7QCUuQrY0PawH3
 DvCMS1kyf0shcew5ocyxIAxSrGDelLt/c3AqgBmHLMC5s05+XLiGPDpqhy5FZLZgRfd1
 c2IkpkgzKYvF49MvCcjQNLw94LT2OdPKHk6sZOzY8e0AQcgXqlgQojmbYnFwGnrWghRn
 VwcoGA/A1DjZ5ftPbkSL95YZVzpSQ/OX8oP44fv1JTMjQKA8bcRH4x8HHUkMJymc6jVN
 vBoIpA719or30zoQWPz30ko6nhRBU8GsVo2rRQoKTUI6+zvg9WboU9iDV/2n4+fOKoNz
 ib9A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780221887; x=1780826687; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pef0Z/LpMHh2qOBIZBTXlXvt1oQYlNPgKQQJCET+WN8=;
 b=AK0thesNREP1j53Ighmaakpzmg31jE9LNsK0dX36G0E6cfsMTZ7I09RKIKGB8Q9Joe
 w2++KHsGKZELrT3epQc9zYUdJSJ3aVOBNbZ8NF8JPFdCO2YHI2c28udkA4lfqYwFyKbC
 5lZJVFfC0Q02X5IYL23K1s1VwbJF7t5PNo1z4PLDLUqB36akHJv7QXF10XbrFvi9g0Do
 9YkAn8qpKF9H0Gl6c47YIwD6faKduwpdWArwWpVzRJBAhASNnpiQvxkSx6djKRCkEvyK
 7/3W+6/eDtbikYLwEitevyx9IXYCTtcEc65xawFY2ovvXxsiCZwp97gtIm9vp5rsgPpz
 9PnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780221887; x=1780826687;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pef0Z/LpMHh2qOBIZBTXlXvt1oQYlNPgKQQJCET+WN8=;
 b=s0T4BkKT0B6s8iRYGGC2ULMLRhFuYFtiEk1wki5eSOL1Qf71piVdKZqcDFTr2sjVvs
 u6IIa6peN8IBlMhsSGw7o9ufGt5bSKruvFWxp7iB+GcUQ2GX0dGdyXl8JzbwiqU6URWe
 GB/tRw2EDUlpvvwLV7OqHhBRz4NpfIEY9CWSpZrzTvhXRP2sgtf05w0V5LmR1128QEtX
 uCJB1IuGykI5UZUF3+MYVFxh2KFuF170UH+WgLkRt6IfnPAyZy6p6u19NAq9xKRu+RK+
 nm4iymTWmolqavDojrOklLGVw52NBsGQ3BZorxGrNHYNj7Tu/ZODR/Op5UXYlDucjRVX
 G1dw==
X-Gm-Message-State: AOJu0Yx+NyiuqKYDn28dia20afbzciRIVIrtUJXEERpXImOyrj6VNYqx
 R8EzEecV9il8J4AlcIaaIK3UyqB/g/8kJ2mOX7pwFxVmm2PgnIkzhCOULjxXUz13lt8KMDZpiqq
 SKxB34/w7/byFfsoPvLgqD6TqMsnkDoer6JpL
X-Gm-Gg: Acq92OEZ82Ahv1c1Io7vXhrULYMkW1c1S6TU8P1qUlKHacavnYDy2nf793d1ZZAlAvr
 UCjRq5powQtj0Qaye1KQ/7TrYliVkRVuJ+7TzMBw+uouoOcfvyEqCt2Xv+jKU7KoVoLSslWSAkT
 NgJ2zRrBIcwkwTIKBro+b3+igZqHN9IOxd2kW/8EXZe9WTZjQ+bemA2xBPq+EYG5xVEaUiEqQMz
 Hb4n5I+B5OKBrun1KXsRFlNBCCarCTSYUhvjqcklMe+n47Emsbnk0jYVQ5SWNuDhpyz2o0gr+25
 b+nesxIjuBuZieGHThI+6CKLrU6BvByRHiJCshRIFFUO0bdF5A==
X-Received: by 2002:a05:600c:400f:b0:48a:5821:5ff2 with SMTP id
 5b1f17b1804b1-490a2919a2emr85844235e9.8.1780221886860; Sun, 31 May 2026
 03:04:46 -0700 (PDT)
MIME-Version: 1.0
From: Raz <raziebe@gmail.com>
Date: Sun, 31 May 2026 13:04:33 +0300
X-Gm-Features: AVHnY4L-Fx5mggLljh_vNPR9ZcBTWFFXVzvQmR3HphSW_hcTKwKG6tqvejUI8Lg
Message-ID: <CAPB=Z-rE1S+C4RrM4nOrL9VL8VRRgWvUxbNcagZLf-r=dZiRFg@mail.gmail.com>
Subject: UFS: PATCH [2/4]
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="000000000000302ba906531a3563"
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

--000000000000302ba906531a3563
Content-Type: text/plain; charset="UTF-8"

From 3ccb178242d15b2a8ac4122c7238eb1ddc51adf2 Mon Sep 17 00:00:00 2001
From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
Date: Thu, 28 May 2026 15:08:14 +0300
Subject: [PATCH 2/4] ufs: Expose selected UFS functions

Remove the static qualifier from selected functions to allow
future reuse.

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 drivers/ufs/ufs-uclass.c | 18 +++++++++---------
 drivers/ufs/ufs.h        | 16 ++++++++++++++++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 6a51f337e47..78f6064ddea 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -757,7 +757,7 @@ static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hba)
  *
  * Flush cache in aligned address..address+size range.
  */
-static void ufshcd_cache_flush(void *addr, unsigned long size)
+void ufshcd_cache_flush(void *addr, unsigned long size)
 {
  uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
  uintptr_t end_addr = ALIGN((uintptr_t)addr + size, ARCH_DMA_MINALIGN);
@@ -1089,8 +1089,8 @@ static inline void ufshcd_init_query(struct ufs_hba *hba,
 /**
  * ufshcd_query_flag() - API function for sending flag query requests
  */
-static int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
-      enum flag_idn idn, bool *flag_res)
+int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
+       enum flag_idn idn, bool *flag_res)
 {
  struct ufs_query_req *request = NULL;
  struct ufs_query_res *response = NULL;
@@ -1320,9 +1320,9 @@ out:
 /**
  * ufshcd_query_descriptor_retry - API function for sending descriptor requests
  */
-static int ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum
query_opcode opcode,
- enum desc_idn idn, u8 index, u8 selector,
- u8 *desc_buf, int *buf_len)
+int  ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum
query_opcode opcode,
+    enum desc_idn idn, u8 index, u8 selector,
+    u8 *desc_buf, int *buf_len)
 {
  int err;
  int retries;
@@ -1457,9 +1457,9 @@ static int ufshcd_map_desc_id_to_length(struct
ufs_hba *hba, enum desc_idn desc_
  * ufshcd_read_desc_param - read the specified descriptor parameter
  *
  */
-static int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
-   int desc_index, u8 param_offset,
-   u8 *param_read_buf, u8 param_size)
+int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
+    int desc_index, u8 param_offset,
+    u8 *param_read_buf, u8 param_size)
 {
  int ret;
  u8 *desc_buf;
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 0f6c93fbce7..75b7ff83155 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -218,6 +218,9 @@ enum flag_idn {
  QUERY_FLAG_IDN_BUSY_RTC = 0x09,
  QUERY_FLAG_IDN_RESERVED3 = 0x0A,
  QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE = 0x0B,
+ QUERY_FLAG_IDN_F_WRITE_BOOSTER_EN               = 0x0E,
+ QUERY_FLAG_IDN_F_WB_BUF_FLUSH_EN                = 0x0F,
+ QUERY_FLAG_IDN_F_WB_BUF_FLUSH_HIBERN8           = 0x10
 };

 /* Attribute idn for Query requests */
@@ -809,4 +812,17 @@ static inline void ufshcd_rmwl(struct ufs_hba
*hba, u32 mask, u32 val, u32 reg)

 int ufshcd_probe(struct udevice *dev, struct ufs_hba_ops *hba_ops);

+int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
+    int desc_index, u8 param_offset, u8 *param_read_buf,
+    u8 param_size);
+
+void ufshcd_cache_flush(void *addr, unsigned long size);
+
+int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
+       enum flag_idn idn, bool *flag_res);
+
+int ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum
query_opcode opcode,
+   enum desc_idn idn, u8 index, u8 selector,
+   u8 *desc_buf, int *buf_len);
+
 #endif
-- 
2.43.0

--000000000000302ba906531a3563
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-ufs-Expose-selected-UFS-functions.patch"
Content-Disposition: attachment; 
	filename="0002-ufs-Expose-selected-UFS-functions.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mptm4lc30>
X-Attachment-Id: f_mptm4lc30

RnJvbSAzY2NiMTc4MjQyZDE1YjJhOGFjNDEyMmM3MjM4ZWIxZGRjNTFhZGYyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXogQmVuIFllaHVkYSA8cmF6LmJlbnllaHVkYUBtb2JpbGV5
ZS5jb20+CkRhdGU6IFRodSwgMjggTWF5IDIwMjYgMTU6MDg6MTQgKzAzMDAKU3ViamVjdDogW1BB
VENIIDIvNF0gdWZzOiBFeHBvc2Ugc2VsZWN0ZWQgVUZTIGZ1bmN0aW9ucwoKUmVtb3ZlIHRoZSBz
dGF0aWMgcXVhbGlmaWVyIGZyb20gc2VsZWN0ZWQgZnVuY3Rpb25zIHRvIGFsbG93CmZ1dHVyZSBy
ZXVzZS4KClNpZ25lZC1vZmYtYnk6IFJheiBCZW4gWWVodWRhIDxyYXouYmVueWVodWRhQG1vYmls
ZXllLmNvbT4KLS0tCiBkcml2ZXJzL3Vmcy91ZnMtdWNsYXNzLmMgfCAxOCArKysrKysrKystLS0t
LS0tLS0KIGRyaXZlcnMvdWZzL3Vmcy5oICAgICAgICB8IDE2ICsrKysrKysrKysrKysrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3Vmcy91ZnMtdWNsYXNzLmMgYi9kcml2ZXJzL3Vmcy91ZnMtdWNsYXNzLmMK
aW5kZXggNmE1MWYzMzdlNDcuLjc4ZjYwNjRkZGVhIDEwMDY0NAotLS0gYS9kcml2ZXJzL3Vmcy91
ZnMtdWNsYXNzLmMKKysrIGIvZHJpdmVycy91ZnMvdWZzLXVjbGFzcy5jCkBAIC03NTcsNyArNzU3
LDcgQEAgc3RhdGljIGlubGluZSB1OCB1ZnNoY2RfZ2V0X3VwbWNycyhzdHJ1Y3QgdWZzX2hiYSAq
aGJhKQogICoKICAqIEZsdXNoIGNhY2hlIGluIGFsaWduZWQgYWRkcmVzcy4uYWRkcmVzcytzaXpl
IHJhbmdlLgogICovCi1zdGF0aWMgdm9pZCB1ZnNoY2RfY2FjaGVfZmx1c2godm9pZCAqYWRkciwg
dW5zaWduZWQgbG9uZyBzaXplKQordm9pZCB1ZnNoY2RfY2FjaGVfZmx1c2godm9pZCAqYWRkciwg
dW5zaWduZWQgbG9uZyBzaXplKQogewogCXVpbnRwdHJfdCBzdGFydF9hZGRyID0gKHVpbnRwdHJf
dClhZGRyICYgfihBUkNIX0RNQV9NSU5BTElHTiAtIDEpOwogCXVpbnRwdHJfdCBlbmRfYWRkciA9
IEFMSUdOKCh1aW50cHRyX3QpYWRkciArIHNpemUsIEFSQ0hfRE1BX01JTkFMSUdOKTsKQEAgLTEw
ODksOCArMTA4OSw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB1ZnNoY2RfaW5pdF9xdWVyeShzdHJ1
Y3QgdWZzX2hiYSAqaGJhLAogLyoqCiAgKiB1ZnNoY2RfcXVlcnlfZmxhZygpIC0gQVBJIGZ1bmN0
aW9uIGZvciBzZW5kaW5nIGZsYWcgcXVlcnkgcmVxdWVzdHMKICAqLwotc3RhdGljIGludCB1ZnNo
Y2RfcXVlcnlfZmxhZyhzdHJ1Y3QgdWZzX2hiYSAqaGJhLCBlbnVtIHF1ZXJ5X29wY29kZSBvcGNv
ZGUsCi0JCQkgICAgIGVudW0gZmxhZ19pZG4gaWRuLCBib29sICpmbGFnX3JlcykKK2ludCB1ZnNo
Y2RfcXVlcnlfZmxhZyhzdHJ1Y3QgdWZzX2hiYSAqaGJhLCBlbnVtIHF1ZXJ5X29wY29kZSBvcGNv
ZGUsCisJCSAgICAgIGVudW0gZmxhZ19pZG4gaWRuLCBib29sICpmbGFnX3JlcykKIHsKIAlzdHJ1
Y3QgdWZzX3F1ZXJ5X3JlcSAqcmVxdWVzdCA9IE5VTEw7CiAJc3RydWN0IHVmc19xdWVyeV9yZXMg
KnJlc3BvbnNlID0gTlVMTDsKQEAgLTEzMjAsOSArMTMyMCw5IEBAIG91dDoKIC8qKgogICogdWZz
aGNkX3F1ZXJ5X2Rlc2NyaXB0b3JfcmV0cnkgLSBBUEkgZnVuY3Rpb24gZm9yIHNlbmRpbmcgZGVz
Y3JpcHRvciByZXF1ZXN0cwogICovCi1zdGF0aWMgaW50IHVmc2hjZF9xdWVyeV9kZXNjcmlwdG9y
X3JldHJ5KHN0cnVjdCB1ZnNfaGJhICpoYmEsIGVudW0gcXVlcnlfb3Bjb2RlIG9wY29kZSwKLQkJ
CQkJIGVudW0gZGVzY19pZG4gaWRuLCB1OCBpbmRleCwgdTggc2VsZWN0b3IsCi0JCQkJCSB1OCAq
ZGVzY19idWYsIGludCAqYnVmX2xlbikKK2ludCAgdWZzaGNkX3F1ZXJ5X2Rlc2NyaXB0b3JfcmV0
cnkoc3RydWN0IHVmc19oYmEgKmhiYSwgZW51bSBxdWVyeV9vcGNvZGUgb3Bjb2RlLAorCQkJCSAg
IGVudW0gZGVzY19pZG4gaWRuLCB1OCBpbmRleCwgdTggc2VsZWN0b3IsCisJCQkJICAgdTggKmRl
c2NfYnVmLCBpbnQgKmJ1Zl9sZW4pCiB7CiAJaW50IGVycjsKIAlpbnQgcmV0cmllczsKQEAgLTE0
NTcsOSArMTQ1Nyw5IEBAIHN0YXRpYyBpbnQgdWZzaGNkX21hcF9kZXNjX2lkX3RvX2xlbmd0aChz
dHJ1Y3QgdWZzX2hiYSAqaGJhLCBlbnVtIGRlc2NfaWRuIGRlc2NfCiAgKiB1ZnNoY2RfcmVhZF9k
ZXNjX3BhcmFtIC0gcmVhZCB0aGUgc3BlY2lmaWVkIGRlc2NyaXB0b3IgcGFyYW1ldGVyCiAgKgog
ICovCi1zdGF0aWMgaW50IHVmc2hjZF9yZWFkX2Rlc2NfcGFyYW0oc3RydWN0IHVmc19oYmEgKmhi
YSwgZW51bSBkZXNjX2lkbiBkZXNjX2lkLAotCQkJCSAgaW50IGRlc2NfaW5kZXgsIHU4IHBhcmFt
X29mZnNldCwKLQkJCQkgIHU4ICpwYXJhbV9yZWFkX2J1ZiwgdTggcGFyYW1fc2l6ZSkKK2ludCB1
ZnNoY2RfcmVhZF9kZXNjX3BhcmFtKHN0cnVjdCB1ZnNfaGJhICpoYmEsIGVudW0gZGVzY19pZG4g
ZGVzY19pZCwKKwkJCSAgIGludCBkZXNjX2luZGV4LCB1OCBwYXJhbV9vZmZzZXQsCisJCQkgICB1
OCAqcGFyYW1fcmVhZF9idWYsIHU4IHBhcmFtX3NpemUpCiB7CiAJaW50IHJldDsKIAl1OCAqZGVz
Y19idWY7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3Vmcy91ZnMuaCBiL2RyaXZlcnMvdWZzL3Vmcy5o
CmluZGV4IDBmNmM5M2ZiY2U3Li43NWI3ZmY4MzE1NSAxMDA2NDQKLS0tIGEvZHJpdmVycy91ZnMv
dWZzLmgKKysrIGIvZHJpdmVycy91ZnMvdWZzLmgKQEAgLTIxOCw2ICsyMTgsOSBAQCBlbnVtIGZs
YWdfaWRuIHsKIAlRVUVSWV9GTEFHX0lETl9CVVNZX1JUQwkJCQk9IDB4MDksCiAJUVVFUllfRkxB
R19JRE5fUkVTRVJWRUQzCQkJPSAweDBBLAogCVFVRVJZX0ZMQUdfSUROX1BFUk1BTkVOVExZX0RJ
U0FCTEVfRldfVVBEQVRFCT0gMHgwQiwKKwlRVUVSWV9GTEFHX0lETl9GX1dSSVRFX0JPT1NURVJf
RU4gICAgICAgICAgICAgICA9IDB4MEUsCisJUVVFUllfRkxBR19JRE5fRl9XQl9CVUZfRkxVU0hf
RU4gICAgICAgICAgICAgICAgPSAweDBGLAorCVFVRVJZX0ZMQUdfSUROX0ZfV0JfQlVGX0ZMVVNI
X0hJQkVSTjggICAgICAgICAgID0gMHgxMAogfTsKIAogLyogQXR0cmlidXRlIGlkbiBmb3IgUXVl
cnkgcmVxdWVzdHMgKi8KQEAgLTgwOSw0ICs4MTIsMTcgQEAgc3RhdGljIGlubGluZSB2b2lkIHVm
c2hjZF9ybXdsKHN0cnVjdCB1ZnNfaGJhICpoYmEsIHUzMiBtYXNrLCB1MzIgdmFsLCB1MzIgcmVn
KQogCiBpbnQgdWZzaGNkX3Byb2JlKHN0cnVjdCB1ZGV2aWNlICpkZXYsIHN0cnVjdCB1ZnNfaGJh
X29wcyAqaGJhX29wcyk7CiAKK2ludCB1ZnNoY2RfcmVhZF9kZXNjX3BhcmFtKHN0cnVjdCB1ZnNf
aGJhICpoYmEsIGVudW0gZGVzY19pZG4gZGVzY19pZCwKKwkJCSAgIGludCBkZXNjX2luZGV4LCB1
OCBwYXJhbV9vZmZzZXQsIHU4ICpwYXJhbV9yZWFkX2J1ZiwKKwkJCSAgIHU4IHBhcmFtX3NpemUp
OworCit2b2lkIHVmc2hjZF9jYWNoZV9mbHVzaCh2b2lkICphZGRyLCB1bnNpZ25lZCBsb25nIHNp
emUpOworCitpbnQgdWZzaGNkX3F1ZXJ5X2ZsYWcoc3RydWN0IHVmc19oYmEgKmhiYSwgZW51bSBx
dWVyeV9vcGNvZGUgb3Bjb2RlLAorCQkgICAgICBlbnVtIGZsYWdfaWRuIGlkbiwgYm9vbCAqZmxh
Z19yZXMpOworCitpbnQgdWZzaGNkX3F1ZXJ5X2Rlc2NyaXB0b3JfcmV0cnkoc3RydWN0IHVmc19o
YmEgKmhiYSwgZW51bSBxdWVyeV9vcGNvZGUgb3Bjb2RlLAorCQkJCSAgZW51bSBkZXNjX2lkbiBp
ZG4sIHU4IGluZGV4LCB1OCBzZWxlY3RvciwKKwkJCQkgIHU4ICpkZXNjX2J1ZiwgaW50ICpidWZf
bGVuKTsKKwogI2VuZGlmCi0tIAoyLjQzLjAKCg==
--000000000000302ba906531a3563--
