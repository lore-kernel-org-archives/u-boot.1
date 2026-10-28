Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D249606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xBoGWGtt;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xMpuLD2j
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2837560773;
	Wed, 28 Oct 2026 05:52:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tdkWZ_lCCSah; Wed, 28 Oct 2026 05:52:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 65F4E60755
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166730;
	b=YPH3u+a4TYUVJUtLXEPNcl2T569ajRj+2B1RqiL4BV2jSEZVwEpYTetu1LUnCEToywG6
	 XQwWp1RiZua9K5dg6KXdtIlPzPYjRhGsakVI4yfk+aJizd/sgZRWwPWpO+MxdhPVJhoTj
	 IKddLYnAw0r9CT3J39bbr7TBo8u/4adO6bPxfZvU1HQqUCQ66lDUec2yHwGrL6ocCpDxR
	 i9DDMWtQOcd8aksr55OQU1R5igo+NiLO/6gqrg0o9bKX1BMRvZGLNG+yzXaCWjPO5+ZPC
	 GN2tb8/Hho59UYtdDnGTH5EugzDvOXBpv2KuAKKevi1fw4/cMj53AKLVY9aXaJyOWIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166730;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0Ai2JBk3kZH0doAyt7A1XLJy//FC92/zpCxqSze2jEs=;
	b=GeK8V8fXjSJiYq3pan5ZqIP1QX0rygrHmCxa6o7meStzlXL9rkyZXY2mtizrcNUxOd5F
	 whVQcw7GEUDtvF1XyUqbuptlSfq22Nb6BOULbKFdIAeYU51Hmqq/tVFilK1gw6cdzxoNj
	 dbPa3K7VySXSRbx5p9kQP2/T062iy8a3TF2jvCgKfUoHxpXGdzvxmkCMKk2hADue5j6cU
	 1HR91lgIFmlohA8S5cJeisVu0DrKOFOmhYPvGZ2RiQl1b4YgKqHkTUeoZOhtjJp6blyZ5
	 OAEFPo9d0R4wFSwmkyDgcA3fOfPpPVdZ5BB2yr2NLsUQXFQO+79EZHdQ4ANs7zDctrg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xMpuLD2j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166730;
	bh=0Ai2JBk3kZH0doAyt7A1XLJy//FC92/zpCxqSze2jEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xBoGWGtt5TdcIksvxonwt/38Mp1XAu3trAZh0Uro9dv72ugpmTs+9hdrNKZyLhv/K
	 iq9Eo/7upfoZghI51DUhmWDz9ghZVJNZf7YRQwJpxhG7FXelTSGT/hLLIbJ+mUZHvi
	 ZkC/5Xh4GdQSe8YqxBi9B+fwpo8OFohybHtMV04BxT0+onxdtIIkrkui2r1i2yw0SK
	 mMVBdLrhEo5VLZ8iIwUzwIHgcJO9ERyDMdAiLDEbPqYGPqk7O1IzrCx4xbDxenJV0J
	 +TE2sLbjERopmIHRbqBj+Hiqd9An/eUY0WgQUyEUYuHyi3cEYRMKyKhoYTF5h4sMsL
	 UK82FI+pD0WsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65F4E60755;
	Wed, 28 Oct 2026 05:52:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 760762E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65F5660755
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:52:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FzcAlsQ-ho2o for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:52:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 64CBF60706
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166727;
 b=fEATBLNi+cT1FOgPD1uH63ZcVFG5QjBm2jNVpDqw56old84k+vAYaHY+dwU2Vha1AgTl
 WTE0KyHf1LKkQr8Lb0RuuCdhl7pTOwqCu3ydReUSky2uQAwprwtw1AN5nTwQa/Uv4Sp7N
 0ittFIgUG7IIQLK/zQ7TsfYtlRONcWTVynKgGx0eMCOOHPtu9mNlGSo5LION9etIh3KP4
 swXlGOFQZbQIwaxAoHbP2heIcYP2A5z7cVr4H/uCYEgfzc5MVpq295OHIbHgrDy2Ibg0F
 2t2X3FjdfFO0Lns4BFLYVE/Z3QmJq//0LKFxi8erFl2+4dkKSzX2pYNpsagbRz/cXyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166727;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=0Ai2JBk3kZH0doAyt7A1XLJy//FC92/zpCxqSze2jEs=;
 b=aYkMjyyEF73k01itHZ9zG46oXj5hQBbBXECGEAs9+iU/b/ZFS2YlGYnZE1jkA919jmOR
 gSaOO0R9vBQuHFNTbPLqo8KDNkAOhx4YRkQPcHFZxHR/6+GPpzpsCagBbspzDoeYa/f5/
 69XAKpF9ZNsXZb+mR4Nb7ouc0rD+p1n2SzCZ4dewuuSB8/31kE1SLV2KNsPojtcVfRKCn
 lWsICFBha1GYn46xFiZ5SmFSAqh4E26XWFd9psB4/dDaH0OHqeCPm5MDieftRiNOtLaPv
 DHTAzMLSzmRzpcssnVn/W7e4U0ixxDuCvqFf9XDplS7xpn6pXIh7kKZ/Ije6DVqm1vw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=xMpuLD2j; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=xMpuLD2j
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 64CBF60706
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:52:06 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a7992e2f7dso4597155e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166725; x=1793771525;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0Ai2JBk3kZH0doAyt7A1XLJy//FC92/zpCxqSze2jEs=;
 b=xMpuLD2jlVDZYnGV/aodoP+tP2AIrb9BY7rAcCC78wl+PsP/syEQvPUdHCSgpo/sgg
 JIWtdOTEgSgd4TKpXoyTVzRM/F8FhozHkdtDB5VfUExnXywnN7S6AEkBuXGXGouSmrhH
 Gs9ENOmoZr91Z5GXy5mRxu5BNsdtSHcxtpDcJLVDYnKi63D5K9Lv5BUYpIYitWZnEf8o
 RfxeDzWF8udG0ggJVy1FLUyZxlg3aG4eD1sj424y/V1xMaNQTy+VpOI5ZavDywx4WjzU
 g+/wh4eY879+11c8+wABU7WccIT8Fzo9yKaCXgLVilTJzArSBzf+gQWUf2jA3LRzxBuk
 2/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166725; x=1793771525;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0Ai2JBk3kZH0doAyt7A1XLJy//FC92/zpCxqSze2jEs=;
 b=tslyX6wDDzFYnWCA5iCb1efRRr43fcmuDE/PKg9v2vBaTEGrO9QiTzStUyOX/2x8wy
 DxHf5hq8fKddAUw0OaVih41s5ZU8ZG6AdeYS8SHcmAM/pXimGe4twGbQkz+w/tv2vyoh
 EsAXEqFYdhCF81sV9PR/IChONFzPt/vchgjqaAOW2X4Xs/APh471DXLbjRlSJh2LlbUU
 QyZ/acLYrBBnbGkJLiZHkeKH4RwoKl9YnpHlFCWvy3YE7ZER7QJdcw9GOtK+hH1VKVnM
 SRbONQ6zybUXE95MU/rxiVd3qlu7ADIpZJk7qKdFmSQj/NljZzeHLb+sz7FvoYPIA+o+
 KcbA==
X-Gm-Message-State: AFq9FYKEM7O3cMVDT+3uHd1EIE+WFSeE6ttrJ/x9wZNH8KBMc8xy+FxZ
 EkksVTmsoGm5uz3Tp6UNtygivjzkAJFrM0SsuRlARgX4b9VSrW4Y5Pg0
X-Gm-Gg: AYBFou1S9lYJ6EitatXvPwhgu3adoBoU3xyUbo7JKUyL+ZN2jActRzVkQ9fcRErL8F5
 jIFBOQNmvwyqflTwGmh7FWiPE9jd6u3RarFkSWH8xve5v/Npo5bfgT4L3GyS4NtZyzCYMBnAFcf
 H461soHZa8DIQu0mdmqnYINmM+hWtQANE60ioNQVSar2lYY/RBUu3MRvsVRXbs3iZj6z+kfQpg6
 17T++tFC8ZBKoRZw795vi8C9tRkdXL4aDmT/8NRskeSk43yOz/TwS2e24OLHCOYup+ABrihUWBi
 u5uEBM/c0FAzupAioBgIGRTczTwTlbwtN9ozrvWhUlq5c50g5a7TohQX41p9nVyeOyOsh00ezE6
 mOnzhZVMuanlNivV3NqTyOgsJH3P3bbZddE+Dn2fYrulFdIgFQTIscRQIVvpVvFrowW/wVU2mu0
 TvlNdpObkJFxQ4I3vryjjjnMsSXHAIMVQQRRRyl/rp9jq0XrOOP81vbzwr6bRwEV1/GNCE4rGxl
 CAhZ0h99uDOLMf32njqjNQxv189zo7fQRWetF9FtQGBOaOETaeTeK7a6n5s4nhb+RI6mZFqC0Qb
 0Iv2GcM/MFi+Fb4gsWx25aTlHT1RW+4uGwgvihw86Q26MUDP07AN
X-Received: by 2002:a05:600c:3541:b0:4a1:f68a:9736 with SMTP id
 5b1f17b1804b1-4a9672014d4mr23222955e9.26.1793166724980; 
 Tue, 27 Oct 2026 22:52:04 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a977edc08fsm18757025e9.4.2026.10.27.22.52.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:52:04 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 11/12] disk: part_dos: Make room for a three-digit
 partition number in the UUID
Date: Wed, 28 Oct 2026 05:52:03 +0000
Message-ID: <36ae5af0-3845-4794-9361-3253883279d8@gmail.com>
In-Reply-To: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
References: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

part_get_info_extended() makes up the UUID of a DOS partition as
"%08x-%02x" from the disk signature and the partition number, into a
buffer of 12 bytes. That is enough up to partition 255, but
MAX_EXT_PARTS lets the number reach 256, whose three digits make
sprintf() write the terminating NUL past the end of the buffer.

Size the buffer like the UUID it is copied into, and use snprintf().

Add a test with 256 partitions, which catches the overflow on sandbox
with CONFIG_ASAN.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v1)

 disk/part_dos.c |  6 ++++--
 test/dm/part.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/disk/part_dos.c b/disk/part_dos.c
index bc40d9d2829..3029ee0c31a 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -325,9 +325,11 @@ static int part_get_info_extended(struct blk_desc *desc,
 						 "0x%x", pt->sys_ind);
 					info->bootable = get_bootable(pt);
 					if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
-						char str[12];
+						/* part_num may take three digits */
+						char str[UUID_STR_LEN + 1];
 
-						sprintf(str, "%08x-%02x", disksig, part_num);
+						snprintf(str, sizeof(str), "%08x-%02x",
+							 disksig, part_num);
 						disk_partition_set_uuid(info, str);
 					}
 					info->sys_ind = pt->sys_ind;
diff --git a/test/dm/part.c b/test/dm/part.c
index 4938d962144..f8a0fa974c1 100644
--- a/test/dm/part.c
+++ b/test/dm/part.c
@@ -423,3 +423,49 @@ static int dm_test_part_dos_ext_empty(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_part_dos_ext_empty, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
+
+/*
+ * Partition numbers above 255 take three digits in the UUID made up for a
+ * DOS partition, from the disk signature and the partition number
+ */
+static int dm_test_part_dos_uuid(struct unit_test_state *uts)
+{
+	struct disk_partition info;
+	dos_partition_t pt[4];
+	struct blk_desc *desc;
+	int part;
+
+	if (!CONFIG_IS_ENABLED(PARTITION_UUIDS))
+		return -EAGAIN;
+
+	ut_asserteq(2, blk_get_device_by_str("mmc", "2", &desc));
+	ut_asserteq(512, desc->blksz);
+
+	/* an extended partition from sector 2 */
+	memset(pt, '\0', sizeof(pt));
+	dos_set_entry(&pt[0], DOS_PART_TYPE_EXTENDED, 2, 512);
+	ut_assertok(dos_write_table(desc, 0, pt));
+
+	/*
+	 * holding logical partitions 5 to 256, each of one sector after its
+	 * table, with the tables two sectors apart from sector 2 on
+	 */
+	for (part = 5; part <= 256; part++) {
+		memset(pt, '\0', sizeof(pt));
+		dos_set_entry(&pt[0], 0x83, 1, 1);
+		if (part < 256)
+			dos_set_entry(&pt[1], DOS_PART_TYPE_EXTENDED,
+				      (part - 4) * 2, 2);
+		ut_assertok(dos_write_table(desc, 2 + (part - 5) * 2, pt));
+	}
+
+	ut_assertok(part_get_info_by_type(desc, 255, PART_TYPE_DOS, &info));
+	ut_asserteq(2 + 250 * 2 + 1, info.start);
+	ut_asserteq_str("00000000-ff", disk_partition_uuid(&info));
+	ut_assertok(part_get_info_by_type(desc, 256, PART_TYPE_DOS, &info));
+	ut_asserteq(2 + 251 * 2 + 1, info.start);
+	ut_asserteq_str("00000000-100", disk_partition_uuid(&info));
+
+	return 0;
+}
+DM_TEST(dm_test_part_dos_uuid, UTF_SCAN_PDATA | UTF_SCAN_FDT);
