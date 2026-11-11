Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08950606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Cj3AKwHS;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r4DH9BG5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D987D60D71;
	Wed, 11 Nov 2026 13:14:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cLmlx146w7y0; Wed, 11 Nov 2026 13:14:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D91CE606A2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794402874;
	b=lveCGk0Z0QXmLPcw1wCDtkj+n5+DfU28y9gMOKoYvfvyx1N/1rXKjMxBQVwpvSCEu4jc
	 8gZ4xmOGe8VAESEfdQ6ewVSO3EJnHPInTLJZJBhKXf7YAtWwEBS7BqzcNEnzlQz1CEIfC
	 EQPDVHyNfvGbHt3hPbhYhmO45rz30qy2PHMR0XaZKkY9hva/ctRiq1KBDHyi+SmxxONIK
	 WJ/QrV6RJpZLuuGXRe2HY9yvawrHTkMTU8Fvpok2+TTf18BYMIL9LgQI5xQhzisA5V+15
	 8echsfZw5t1UT+7ipwESgicvLFA4/xVUFlV3P+qh6kwHd5oFDW1McGGNx/nVKjI2UyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794402874;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1yYoVQpRfLw+CSFHLaeLsBZqhi2lidLOrXToZophJSQ=;
	b=EiQ0Lln3pM63GTcPdPcWbzUlP/PVTmAxVrmTsWcTLIs+j4L1eYOWXPmpIH/boVaXDymt
	 Lb7roPxreb7U6DJa9dYcLKQJhzKqI86TUC9+2PJOe2OS9sHrzjEl3sRfiyWoekLqWIPmm
	 /gx9AIInPR64ccXaHyuqGsi5GjDMC+MHl0mStWDYKSNeBWrt1v7RvcmTRA8S23eLE4PM3
	 GI72YwB1r+F1tjIcPBqh+c/odq7iQkMwQQIatMVnpZywQm3KYJYvM1RvvhfJB/SUiOgDS
	 mJdrKLQEgQ49fc0iTlA/juAnCAbyENKlcP2MXhhejXp0UUoCB9e883IDNBUMUKCh83w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r4DH9BG5;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794402874;
	bh=1yYoVQpRfLw+CSFHLaeLsBZqhi2lidLOrXToZophJSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cj3AKwHSe3L8/KZRjBO/tfyGQicGGZCb3ntSgFWRfgrZVGRRqmsOt/l20QWM5VqEK
	 SaNus9x64i4qeS8iec5HfE/CNjWudwi/xF4e4tSd1+H5y0jGwRkhyVnRJxUU7B6V1K
	 FwnEtN4Z2hx7mNrEuRRePdgv7u3IDOMf0qs7Wmbzkbs5LX4lEdQqEHeYBpHl54hauy
	 3QINZ2iQbYJP16OinGys3y8k41ujoOAw72B+Xq12gZTR20JG/hARPxa3wVHBXxmts4
	 8E7JeMsqTC1ExUVIUgYFSMA+bcgg+B54zjgcItvqZavnAgnSz4GLhO1vNYIzAX6TH/
	 dv/3Sif1zgQIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D91CE606A2;
	Wed, 11 Nov 2026 13:14:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FB4517CD
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:13:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 219F96071E
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:13:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZR0KZbS8GUCd for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 09:13:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C0FB060697
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=igor.opaniuk@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=r4DH9BG5
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C0FB060697
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:13:40 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so4656777a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 01:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794388418; x=1794993218;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1yYoVQpRfLw+CSFHLaeLsBZqhi2lidLOrXToZophJSQ=;
 b=r4DH9BG5qQyneZQExe99ZxvWV6DX8EY+cCHXa8aWl89O54NVeljz3wUXVKehcjcMT+
 Iqm5DJ1ki7fYajbh+OQnu/S5bqCyc3Vx+BIx/edpibbw5iFqBlFTbFeUrEuisVQarEft
 NXWsBU84EyBStPtmNz+ugdC+4DZb0j6LUcLN/xvtEnPg7ZSGEjdZmfYT5RlmxsU5xZDs
 74ao7CKAkKE8u0AhNJwZ2+zCZIeG6c1EQIBghh8AAHDMizX5sAADG9AwtN00YKyW6DEt
 ONgo9/zvoNZKvEuRShcEErgBgXboPyqIYu5AWC/XAhBx8wakd4J+Fjrv48+/MKVBfqKx
 3myA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794388418; x=1794993218;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1yYoVQpRfLw+CSFHLaeLsBZqhi2lidLOrXToZophJSQ=;
 b=irhJuE1dxdboxRgEs0fE48Xih1H4zU6WrR76VCAEAW22LX+3fDyVDXT2gB1i69ofmH
 zwv2IV7DclI9u9HFTeSJTf6SruFtUihFABfCAFR8ubkrI+j2TikDulGbVMLutYed7+aU
 YF8VDX49jXkvmmAo4KR9ZbCV+VMeW+voy1RwnJg/mRxqwbawWwJqdVL0pKVPLiF0sVjE
 IZ3XKWSxYIk+OttSRekOgVpos+rmS9tzYc3NnmGEW7Fe8ajgFnPkF+cUh5uogqeOs1Wt
 XgWQEq13Blt/pDZENHbD89VwPaAFL+BySJSDFCeKpvdyyXNOmtWmSiqQ4BSagDtoECvB
 dasg==
X-Forwarded-Encrypted: i=1;
 AL+hErEKx5bIBia+nMuk/6u40M8oXXUGt83PlMa6ojaR5Ge7QMSLFCDXyxOPee1ZsoKvEHPL3+76Qxw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9ewXj+yB7IffCJpCu9oYoscPuUCOzIk9EhpyT1BiQiBCSOvD3h
 tt1OWB2w2yI+7Iz0lot5c7F4qGt9wqY+jPRVARD9JxZuVma3N/sfbbm5
X-Gm-Gg: AYBFou0bR/s+hacFPz6TYYgy/0DKLET3EeAQz4HoLtALgES4LpZj5819GGw0z0y9AGh
 xOts7AG4gVbXpjdCUalo4g23+U9LnzfrzJ5U4kvPLmVZQJ1sboLQ1MdYU7D6R+fJBi9r1wq4CLz
 6l9ArMlme1Ys7Dh/TDi6FKyKZ+V7uBaP7FK94NXcdRfY1099pYKIwHjZv+sJr6P0scvvTS0/jWf
 6TVZGOppE8/cUIWV1eI169hj8pn1g47B6aKctNu+IY0R2bLiSHl7RCGOcoC1PblAMPmvRksXzSA
 2MFJaCs1fNlcceRaGT0zAoPeF6kOes/RsllrUM/yNgWem6FIxxJ3EiKlzVX78T4fhOhGfgdwMj2
 /XJSxNzPcR8cPCZZJctlcqbFz9M9J2XfP8Kxc47xiJCm5x4TV6a2+Wl+5pOl+7z0F4WKH/g6dKG
 usIyoozm3tozy6aY//lsaMWklXmBZv6aj12OJvZBvkWG6JrXm1v6QMUDbeHXrb5UL9wRwqu2kT7
 VhNI13aihqVqS1wFcksUnhwi4MfP5wrKCsht+qOEu+06jf4oDvWk6UMHuATez/27T3ON8M/8L45
 99TCNCbl0qB91f3wGS/2KMMz4qXGBObTxk8p8THBAunQiZIH36zQ5RltyZt2EoBYybrkW7CTYv3
 JxdUzSCuuTQyFs9Q=
X-Received: by 2002:a05:6402:5004:b0:6b7:7785:e390 with SMTP id
 4fb4d7f45d1cf-6b77785e9a4mr1429425a12.39.1794388418244; 
 Wed, 11 Nov 2026 01:13:38 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7579047c9sm2155257a12.33.2026.11.11.01.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:13:37 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Wed, 11 Nov 2026 10:13:33 +0100
Subject: [PATCH 2/3] android: sync bootloader_message.h with AOSP (misc
 system space)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-upstream-android_rollback_misc_b4-v1-2-47d17e8a5d92@gmail.com>
References: <20261111-upstream-android_rollback_misc_b4-v1-0-47d17e8a5d92@gmail.com>
In-Reply-To: <20261111-upstream-android_rollback_misc_b4-v1-0-47d17e8a5d92@gmail.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:14:06 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Android uses the "system space" of the misc partition (32 KiB in) to
pass messages to the bootloader: the Virtual A/B merge status, the Arm
MTE mode and kernel command line flags. Add their definitions from
bootloader_message_core.h at android-17.0.0_r1 [1], copied verbatim like
the rest of the file so that later syncs stay a plain diff.

[1] https://android.googlesource.com/platform/bootable/recovery/+/refs/tags/android-17.0.0_r1/bootloader_message/include/bootloader_message/bootloader_message_core.h

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---
 include/android_bootloader_message.h | 92 +++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/include/android_bootloader_message.h b/include/android_bootloader_message.h
index 286d7ab0f31..9092f74c4db 100644
--- a/include/android_bootloader_message.h
+++ b/include/android_bootloader_message.h
@@ -27,11 +27,15 @@
 // 0   - 2K     For bootloader_message
 // 2K  - 16K    Used by Vendor's bootloader (the 2K - 4K range may be optionally used
 //              as bootloader_message_ab struct)
-// 16K - 64K    Used by uncrypt and recovery to store wipe_package for A/B devices
+// 16K - 32K    Used by uncrypt and recovery to store wipe_package for A/B devices
+// 32K - 64K    System space, used for miscellanious AOSP features. See below.
 // Note that these offsets are admitted by bootloader,recovery and uncrypt, so they
 // are not configurable without changing all of them.
 static const size_t BOOTLOADER_MESSAGE_OFFSET_IN_MISC = 0;
+static const size_t VENDOR_SPACE_OFFSET_IN_MISC = 2 * 1024;
 static const size_t WIPE_PACKAGE_OFFSET_IN_MISC = 16 * 1024;
+static const size_t SYSTEM_SPACE_OFFSET_IN_MISC = 32 * 1024;
+static const size_t SYSTEM_SPACE_SIZE_IN_MISC = 32 * 1024;
 
 /* Bootloader Message (2-KiB)
  *
@@ -81,6 +85,92 @@ struct bootloader_message {
     char reserved[1184];
 };
 
+// Holds Virtual A/B merge status information. Current version is 1. New fields
+// must be added to the end.
+struct misc_virtual_ab_message {
+  uint8_t version;
+  uint32_t magic;
+  uint8_t merge_status;  // IBootControl 1.1, MergeStatus enum.
+  uint8_t source_slot;   // Slot number when merge_status was written.
+  uint8_t reserved[57];
+} __attribute__((packed));
+
+struct misc_memtag_message {
+  uint8_t version;
+  uint32_t magic; // magic string for treble compat
+  uint32_t memtag_mode;
+  uint8_t reserved[55];
+} __attribute__((packed));
+
+struct misc_kcmdline_message {
+  uint8_t version;
+  uint32_t magic;
+  uint64_t kcmdline_flags;
+  uint8_t reserved[51];
+} __attribute__((packed));
+
+// holds generic platform info, managed by misctrl
+struct misc_control_message {
+  uint8_t version;
+  uint32_t magic;
+  uint64_t misctrl_flags;
+  uint8_t reserved[51];
+} __attribute__((packed));
+
+#define MISC_VIRTUAL_AB_MESSAGE_VERSION 2
+#define MISC_VIRTUAL_AB_MAGIC_HEADER 0x56740AB0
+
+#define MISC_MEMTAG_MESSAGE_VERSION 1
+#define MISC_MEMTAG_MAGIC_HEADER 0x5afefe5a
+#define MISC_MEMTAG_MODE_MEMTAG 0x1
+#define MISC_MEMTAG_MODE_MEMTAG_ONCE 0x2
+#define MISC_MEMTAG_MODE_MEMTAG_KERNEL 0x4
+#define MISC_MEMTAG_MODE_MEMTAG_KERNEL_ONCE 0x8
+#define MISC_MEMTAG_MODE_MEMTAG_OFF 0x10
+// This is set when the state was overridden forcibly. This does not need to be
+// interpreted by the bootloader but is only for bookkeeping purposes so
+// userspace knows what to do when the override is undone.
+// See system/extras/mtectrl in AOSP for more information.
+#define MISC_MEMTAG_MODE_FORCED 0x20
+
+#define MISC_KCMDLINE_MESSAGE_VERSION 1
+#define MISC_KCMDLINE_MAGIC_HEADER 0x6ab5110c
+#define MISC_KCMDLINE_BINDER_FORCE_RUST 0x1
+#define MISC_KCMDLINE_BINDER_FORCE_C 0x2
+
+#define MISC_CONTROL_MESSAGE_VERSION 1
+#define MISC_CONTROL_MAGIC_HEADER 0x736d6f72
+#define MISC_CONTROL_16KB_BEFORE 0x1
+
+#ifndef __UBOOT__
+#if (__STDC_VERSION__ >= 201112L) || defined(__cplusplus)
+static_assert(sizeof(struct misc_virtual_ab_message) == 64,
+              "struct misc_virtual_ab_message has wrong size");
+static_assert(sizeof(struct misc_memtag_message) == 64,
+              "struct misc_memtag_message has wrong size");
+static_assert(sizeof(struct misc_kcmdline_message) == 64,
+              "struct misc_kcmdline_message has wrong size");
+static_assert(sizeof(struct misc_control_message) == 64,
+              "struct misc_control_message has wrong size");
+#endif
+#endif /* __UBOOT__ */
+
+// This struct is not meant to be used directly, rather, it is to make
+// computation of offsets easier. New fields must be added to the end.
+struct misc_system_space_layout {
+  struct misc_virtual_ab_message virtual_ab_message;
+  struct misc_memtag_message memtag_message;
+  struct misc_kcmdline_message kcmdline_message;
+  struct misc_control_message control_message;
+} __attribute__((packed));
+
+#ifndef __UBOOT__
+#if (__STDC_VERSION__ >= 201112L) || defined(__cplusplus)
+static_assert(sizeof(struct misc_system_space_layout) % 64 == 0,
+              "prefer to extend by 64 byte chunks, for consistency");
+#endif
+#endif /* __UBOOT__ */
+
 /**
  * We must be cautious when changing the bootloader_message struct size,
  * because A/B-specific fields may end up with different offsets.

-- 
2.53.0

