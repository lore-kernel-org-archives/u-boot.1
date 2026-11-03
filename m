Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E16606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xRijsSoD;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mHBNdmXe
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7873B4060F;
	Tue,  3 Nov 2026 17:05:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BL1MP-FfWYuj; Tue,  3 Nov 2026 17:05:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AC3F84061E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793725534;
	b=c7LyI6EYkTE4TVuayrDQQmiPiCtNH2podnd072w7MwnyP/3qaKa257YXBeyzLUdeCrhR
	 uEUUap2pCvkiWcGPEbUApe9pMnjNQ8dnJ9Id5er1KIUILI38zqYJNoeG4FZiguNxeJfGK
	 Rk4sYXMthpykN6zQA1s9pGkvpv7SYkb2V1UMbSQxreCKB0N+XzSDhXDXpAD/ZE5vmStEf
	 HhBHooH6HtmeoG/PVlNWOiUEZvv6HQXbXv6YX3C3popYP105mrZkD9lyCc0i7/9gSZ/uT
	 L0kHYcLUUv1SSHkxRznOMSlD26qC5u9F9WYanbGeE2WK2qMZUvOrjhu0XneS6QaK+qA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793725534;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WR6EPFzLz4cuDFkoXto7Y4e3N3vv/T2v6P8ccYFkzCk=;
	b=SkU5RCzPzOZN5HAoZPCLcLX/Rdu4HYVwxMUXH4Osy3qeBiJgs+XO2Xa+LdnnvyqmWC+a
	 Ak56BhSSBnuGqSzW8lUa4etHu2yXXzjF2XyiCnfJMUXdBzoIYbVEKtDlNC+T8XNDeuJnH
	 RlXNdIJymFVWMoh7YGZ29xpGOM9fzvKhnte/+tojpVErHtjgptLHIxahjC7VQ9z/oB2ZU
	 2AA+ldbCbn44Iru8NEut1XloQbbo4i3hVfHAKHE7ddNLhPcExOlNVh8AgCR/UqbZ0jQxz
	 beGPBNTR4wJceuDhRFAOl7z6rv/n9Bd3r59aQE6mARPS7SYySTbNS7aKrcTvoH0io+Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793725534;
	bh=WR6EPFzLz4cuDFkoXto7Y4e3N3vv/T2v6P8ccYFkzCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xRijsSoDm4gb5gAYMV/k6kipA64Gi/POSp5DhAvGL3LBbCPTmb5iPyFoQ9le5pvfM
	 q4ZQ2qeUOlRjBa66izXiVukn9pnVI6ue+0oCyTgLRlCCKPIGjMIRjB3Em7YaLhRsKX
	 wYgYOpsKjcMgxvwT2icJOskz8qEnh7SXoq9eBYedcfxmAqvKmNgfwqzTLFp4ud6xxf
	 Fd0hDqJWD+SoZU9P3rZ/XrWJg407ryQrrIrvA125NBF47hwsIrpqzK/lIgZDsExS/+
	 hLWirl88J/qnoB4o7SObqO9IbB2WXnPJU9vkHS9kA8icssfxDERiAP6ySFmOxCkV7n
	 QGjnmfazY7sCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC3F84061E;
	Tue,  3 Nov 2026 17:05:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E2412A15
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 17:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D2F9080E27
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 17:05:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c9La_fC-lPiL for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 17:05:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CC2A080E12
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793725532;
 b=jf37OFPF31zlF/HvDLEWxhWmf0swVxQmQ9bj5ZG3qnRCP8p9sG1vb5t3UtXGufIZy4XP
 CjL/rk/iTNxBgLFwIgPX5sIy+l7palL6O+SUX9G7fu7Wc9f/5CzpITGmVWHPsYSTor+z4
 xLSyuhhW2YH7/Tz/Fvw8IBzo0f+CU1ERP7cODeGkbEs1XhgcU/MCW/sYjX99HFSwfJDg4
 nIfHpSSg+Txrm7SED9S/TKkKyr+5eH81gE/y0lNiTuRXSUoQ9gGb0q9kQT/84Cn4okdIQ
 6F/Ljl9R9lCzrVbHIqtc6JVlqyLY/x4VLBl6lFxf9u9Lko8XLjtM28q3BdVwBx+zUdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793725532;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=WR6EPFzLz4cuDFkoXto7Y4e3N3vv/T2v6P8ccYFkzCk=;
 b=sJGDFkETOk6+vDVSl2o59XSaKl4v6KiDnT29KP0Qh1wneVSUAzO+YDLhT+M2pY2dWZrk
 NfcgLwSoJ8PdrD1tAjym4iTEv/i/YtLt2V/2i5ctGOczgmf2+2bGLmNJfvzS2hzTkXdQm
 TqjCfgVK+EKguB9ekm7gjA5Ocph18/QBNbAgW/ZeWbw6SAe/sN4NOhU6/qIzGTQ0OlkN+
 LS0mqHK+gtc1NhVDAVFSRHi+TTfx6h8K5pxoTwguFfEi/rKb6WtstqQmNslqI43PGbBZh
 zkQPpoFcCI1aZ3CPYVe0KHI5B2qhEVQe/bom/rxxDhpT+Xy+SJ5HLI7f0p4FjzmcQSw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 spf=fail smtp.mailfrom=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=mHBNdmXe; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=wpopov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=mHBNdmXe
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC2A080E12
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 17:05:31 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA2584823; Tue,  3 Nov 2026 18:05:29 +0100 (CET)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90C068480F
 for <u-boot@lists.denx.de>; Tue,  3 Nov 2026 18:05:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wpopov@gmail.com
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-676804a3a22so3616592d50.1
 for <u-boot@lists.denx.de>; Tue, 03 Nov 2026 09:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793725521; x=1794330321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WR6EPFzLz4cuDFkoXto7Y4e3N3vv/T2v6P8ccYFkzCk=;
 b=mHBNdmXeVk0bTsN/WcC7B90uz5nyFfpRAhAnvmujQUuxxWsOX2flB8UheUmiPXf+iN
 TMFa1/XS2ViIeS2RQkSpd/FJUd3/mcbbl2DVQ/R0pu8wkUAm6NikbJ24IcKyh0T3EQlP
 xrhfm/W93PGst34+j35kS7JNwoYJ7skVjBFh3BmUVfgBx6dERMgt4Btoz0e5GKstA4n/
 F/OSqoT8CuHT7NanOqelUL0b2Vuxw5HZswHRaCgkPVf+gsetjGYy7Br9Fo6F+zEN2ZMd
 NAtpG72xcg+hKr6aIHLgWILcFDn1WYCZacLjCRn8COYFWL6z4hv5cRofrl4zakhqIDIH
 Bhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793725521; x=1794330321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WR6EPFzLz4cuDFkoXto7Y4e3N3vv/T2v6P8ccYFkzCk=;
 b=MN/VKjQzUnsDNiZcDgc+8AqGLCEx3R0kvjCnND9/eg9gD+HEBDsMvQc6gZRjOtB7zj
 As2utP+gGtJIR+Gkg3mIJnJLUK05H7pS3AhxF+odLwozWqrtTx3sA0vbFWQYN0/dbQzz
 s5EEhcXlMed+9QQbVGq9ERaaafisFo+pUatyLa7F0YdU6b+IEmC2ukkPSwG3Ag2wvtsP
 680tz/9PBIb0IsB7Tbz5OA6GAy58TsIVrYh6OxG/G7JA79OeruWz3xwk1/nwIAxR/7CS
 6hSzCJVZ5Y+DaTv9ekyh3koZ4fOX/fut5gU30FX8Arr6+cWY6IKp1sO8ivddLNacE2Bq
 mmHg==
X-Gm-Message-State: APuU4Z+oautkT+uEA1YCPZQqC1kWHYZ6mLZGv9eHpQ0zgaJ2bg8VzHrV
 i0kwra8UlKNsGTuq2G5Cjc8WRSTxA8h3hRQaZhIhHKvL2/UawMMSCd+6Kaqdvl2Y
X-Gm-Gg: AYBFou1OCVvA6b8b9XueI96Qk+Z2Ul2n+ha1Sjn8FC8K5iKSJuTqZPkYPVwJL94ucWz
 AGiHMpi+sIWVD3vj1wzGq60ExBosDt9B0fZLcFgplqIpEor60xWrx+3PuV2zxK+yakidAwyjOdm
 f6LdoC7msSubw0jNRtd1EBOBWgyLKRaBiAgg5i6GWcdwj9PRSma4sLk0eV6dDbxoWWMuUw11rwf
 nAsMjjK/C4gtVuFn+trhE2k/+TVAdIWoG2M7yVPETdu8HIPzMKllwwEPTz5SFblFe/BO3FXaWd1
 kxCZeH+Q5crdIrwooBDupme9Dx1tjwi+9HTQRdjBUv7H2/DGwiUSrjqmZrZiIpo2rZsUkvsEPrA
 z6R1tMRYn0LHWmvgR851C8u3kI6C8PdYxAtg+OGxl7ziy6yFslOnOHZ7i7N2GAcOf0WRmbGnbLX
 HtaVHE75AqgHo7nOaMqsjlA+iO6TDw2njAypThihmIpSGzolIiPTLPLfyTtfBoM2ojkc0wAuCv1
 GFdMv2r/lmgwwHE5FH6JHiZCUg2ccpe2svhUjbjkDB63V1pVjo2specoJmh4/GvwwdUjQndxAsf
 uhgCwdeYeLVv8AKBEeb97RqLfTJY2cQZLml5FH4gtOJJpgRJ95UEj9UsQg==
X-Received: by 2002:a05:690e:1206:b0:679:ad95:8eea with SMTP id
 956f58d0204a3-67ba4c81ed3mr10817417d50.2.1793725521141; 
 Tue, 03 Nov 2026 09:05:21 -0800 (PST)
Received: from ABELHA2618-VM-UBUNTU.autotrac.corp ([177.174.221.194])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67baf344b20sm7404977d50.20.2026.11.03.09.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:05:20 -0800 (PST)
From: Wagner Popov dos Santos <wpopov@gmail.com>
To: u-boot@lists.denx.de
Cc: wpopov@gmail.com
Subject: [PATCH 7/7] fs: jffs2: document post-scan merge sort
Date: Tue,  3 Nov 2026 14:05:15 -0300
Message-ID: <99a4519a2a1314dbde5cf0270935e5e97c48a5c9.1793724561.git.wpopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793724561.git.wpopov@gmail.com>
References: <cover.1793724561.git.wpopov@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Describe the existing merge sort performed after scanning, with O(n log
n) comparisons, instead of insertion-time bubble sort. Update both
Kconfig help and the related source comment, and explain how name
caching reduces directory entry reads during sorting.

Signed-off-by: Wagner Popov dos Santos <wpopov@gmail.com>
---
 fs/jffs2/Kconfig       | 8 ++++----
 fs/jffs2/jffs2_1pass.c | 5 ++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/jffs2/Kconfig b/fs/jffs2/Kconfig
index 2fe2ce96eae..6ee29af2aeb 100644
--- a/fs/jffs2/Kconfig
+++ b/fs/jffs2/Kconfig
@@ -26,10 +26,10 @@ config SYS_JFFS2_SORT_FRAGMENTS
 	  If you boot from a partition which is mounted writable, and you
 	  update your boot environment by replacing single files on that
 	  partition, you should also define CONFIG_SYS_JFFS2_SORT_FRAGMENTS.
-	  Scanning the JFFS2 filesystem takes *much* longer with this feature,
-	  though.  Sorting is done while inserting into the fragment list,
-	  which is more or less a bubble sort. That algorithm is known to be
-	  O(n^2), thus you should really consider if you can avoid it!
+	  Fragment and directory entry lists are sorted after scanning using
+	  merge sort, with O(n log n) comparisons. Sorting directory entries
+	  can require repeated flash reads. Enable JFFS2_CACHE_TO_SPEED_UP to
+	  reduce these reads.
 
 config JFFS2_CACHE_TO_SPEED_UP
 	bool "Enable JFFS2 extra cache to speed up sort, list and load"
diff --git a/fs/jffs2/jffs2_1pass.c b/fs/jffs2/jffs2_1pass.c
index 021c524f444..e66cd0a571e 100644
--- a/fs/jffs2/jffs2_1pass.c
+++ b/fs/jffs2/jffs2_1pass.c
@@ -93,9 +93,8 @@
  *   if there are multiple copies of fragments for a certain file offset.
  *
  * The fragment sorting feature must be enabled by CONFIG_SYS_JFFS2_SORT_FRAGMENTS.
- * Sorting is done while adding fragments to the lists, which is more or less a
- * bubble sort. This takes a lot of time, and is most probably not an issue if
- * the boot filesystem is always mounted readonly.
+ * Sorting is done after scanning using merge sort. Directory entry comparisons
+ * may require repeated flash reads unless name caching is enabled.
  *
  * You should define it if the boot filesystem is mounted writable, and updates
  * to the boot files are done by copying files to that filesystem.
-- 
2.43.0

