Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DEF606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=R+0B/wCh;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UYdtEATv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8426D6073D;
	Mon, 23 Nov 2026 11:09:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fwWviuBRENv6; Mon, 23 Nov 2026 11:09:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D66ED60651
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795432193;
	b=gtULvyo9P6O0pAdu4n2qMgUYcRDFwFfb3TxgzItlBj7Qq0WCN0r+KTF16PsWfBQffX8n
	 jprTUoIixfbGvlJ4rwH6nzO/BlEOppViW8NB137VoS6rHPLeyEU4UIhUI8vmMHrzPfWwT
	 7v2yCmNybqkNhWK92C5F4kMQc7OHgGKMAIGoP+G7peH12DHsylLLSSkS3Gn+vmcExyT+5
	 PMlpXJJ0PvfDyKYa1vHyNNwaodWdPbPMD3NaQhnexXI2G8K99S4+0un4aGS3u04RlpLbU
	 w62SqqJpkawI+wDiWdbgoKyyfv8zLmKrGAQNgFlzWqRU06Z+a1kF25Cu7MMQ+cP8FlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795432193;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+xtgh51cw908pcWTK2etHv0QRwwrPIHVOuOm6EiUnyo=;
	b=Y8Fv9168wCi2RJeeSnl4cWBlMhlpaQSQpdpUXBYRUYQvLVvG9FOwdr//8jl8LLbo8FSE
	 RXIBfe3GTe6/yzziXJ0bUEhd1Cq+d4RCNmsITzs689h9xQcESH1KO2nzCkD+eVYJZF5Kq
	 8V1jfdK0rUtUgqLGFdc3wPj7FoZxTxTgpjGPz7Crgk4stf6EgV21RzKjFzLLeisM29KNs
	 xNE9G8GZdQx1/vz01A4VVy5dVONDcSk8B7NMmkgZQL+IlX8d9p5ufoWWU0/bSEMV3YOzk
	 q8oZZ/YCb8OmQFfyL2g61WUkBfZ3JLpAl4Fl8MDd2npWi4rZ87NfJs+RGDZjKIhlBbA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795432193;
	bh=+xtgh51cw908pcWTK2etHv0QRwwrPIHVOuOm6EiUnyo=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R+0B/wChGjuN8Rm89dsSAKYxgvpku3pbtag+jPKNILDuKLz65cAFaSmxyK+LbmsUG
	 UNdBh1nwJqX6yHsnBHDoM11as5ZgklkICrbsY//u5Bu5hzNhrRN86V41YR2nL47mbI
	 LujGlcKUcWdQISlK0JbN3dDjl+pW/NMU1b6v+vVVuMW2QTY7MfJEv56R/6K0oCTR9c
	 WUBkoS8jSJ0E/NNNTH7IeLI6HS/CQt6IVckWX3xp03lPthc3v9BVfmV6uZMvIkPhrv
	 A7x6Lzznjy7X6xRH2OzrM3+NvzgyYDXje6i0QkJxW6zxh1L2+8IdM4MStOkAaUvfHW
	 dpjr3hNJNawrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D66ED60651;
	Mon, 23 Nov 2026 11:09:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A3EEF260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9581B40585
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:09:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id joUZGbvIFt_U for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 11:09:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9EE314057B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UYdtEATv
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9EE314057B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:09:49 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so2174808f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 03:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795432188; x=1796036988;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+xtgh51cw908pcWTK2etHv0QRwwrPIHVOuOm6EiUnyo=;
 b=UYdtEATvAKdKeF0dYBYKZAJfDzwjbtiM5gsky3MdKspTqtEdZM0zg/mn/62qHHHKnD
 Z+KCZ9thDdMM3SGUXhHYsrjQ+olZnfkm/S7HXs7+bLyZVnIyJDZkQKFslxTNf6LpqMXY
 REyEn6K0RADTe21o2JA+88mY5uCmh6+3nEv85HQ62WR1MFhz+OCGeO4be9kc0BFPBsvL
 YNQ6UN3QzI7HArNTvDnuxOr7o0bEgm2xyUCYzsFXTeDizkk8aIMbqYtNCiJ30XLtbE4O
 ml8mYu0PpdbsWJzJu03V7kKnI2GT/H08sW0t6czC5xOE2xAuG4AQspp2cPcxXVHkzh3B
 YnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795432188; x=1796036988;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+xtgh51cw908pcWTK2etHv0QRwwrPIHVOuOm6EiUnyo=;
 b=DsIXjG3uaBEHJ0b+/yKk5EIKCc/33Sb3fty5az8fwZ+tU/xUo+XT8wXkL17pyp/FHi
 5YsDbxXcTjLCgzwiFyurI5zar4kI/NUkL8Wtw/Tz0SlQZsWXwTfLxvXgLZRUjax2SemZ
 IbjL6v8KjV/7YZziWfVDAbnT07FRZToRLxsNnVIniXDPSvDhgKO/wlEBpyfyCK0Y6FXK
 6TBikGhYEcUbkTi1EagQVhuEEvCvKDIAyrGihD5lIt8AkyGIVC8TOV/U9rPT1IfXQAUW
 WtYPJDMPYmyoibyqbqnAj2pTPkL8h4Y3DFD7aBi/BXWUrBOCzHRdwH1e6sxH34eMGFOU
 7xmQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGHK+pVHPRz9bSeSC7Ho8psLBvYQf13MJ5gNgfGVvy7igku6MhZcmbv3S0xg/s5miSzNRZD6x0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9+9SryxTEjcOYVfmE3Jvy4DJOPwXJbJzGnccIKZAL0n9BCEz5p
 6UQDS+lhyYYAsH7SuiC/I35U8QTXd0jQ1j5ErHUlbDvCmmQ3eQpFgnQp+vuacwBvqpE=
X-Gm-Gg: AZFdTZcYvl0JdHaaNjFcmVIw79gsU2jXFFo1cnY0jCxiVIFnq0a/vM+74Tnigt6Ftjh
 1t858MMmPR4+F35yEMQotI0yrHQUl/gHl1NavNdDyrm3VGePUL8TJL7LVWJ5Zwxv7FctJYulyu5
 U1WmMtuJq8Bgz158Vn3vVB8JUyKovKplelpZAjtrzSaOGdN9HyhXbUUw2qPA3Mxgj8239lp6JJI
 jgZYUFO11Fs0WNupDC7FQzLpZeQsXD4hX5gMvAshgcGMSr1M3aGXs0NaTFzY6jBPd/PTtex1jFF
 dOzvakRRRafhNIiW/6/1wLkO5QZWepYAgX9iEpDSSojpvfwe34qxK1nMxgMfPn8LDqYQw8w9fF/
 rXDOK7o7hayyOjouBjeCLSl6hyyHHBoCxhZjlV4dTrorFbkIof13gFulYTWptKl+8k8CM8/dk7v
 9V7oRfnUVTDf1J0FqZYCFj6mRA2O3tp9wG93dsNxQEBav43K97nfUQFWw8M2pKRnkRuH6smFo0z
 xKYZTYEsaNRKLQdnNQcpO4nTWph0etmlmvHcL6q7zzfvyXkfZqg4cUPfsyv5HjSC5iJTbGezt77
 VSkHIm7a2JvOM4m6+kA4J0cXblvZfyIt3HXGIqMzrzxGyQm8JsVRmlxWSDpZrDX2vzd9vsueCKj
 mx+0fid3jXOmVqFoKCWI6jIkr10i2+4Xu0ztp70jM68r3I2M=
X-Received: by 2002:a05:600c:1c1f:b0:4bb:6847:7943 with SMTP id
 5b1f17b1804b1-4bb88814510mr279758635e9.26.1795432188119; 
 Mon, 23 Nov 2026 03:09:48 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884ab091sm491677485e9.11.2026.11.23.03.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 03:09:47 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 23 Nov 2026 12:09:40 +0100
Subject: [PATCH] spl: mmc: restore partition lookup in dynamic mode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-ccaione-upstream-spl-mmc-dynamic-get-info-v1-1-ed7cba0804c7@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXNUQrCMBCE4auUfXbBRCrFq4gPcTOtKyYNSSpK6
 d2N+vjBMP9KBVlR6NStlPHUonNsMLuO5ObiBFbfTHZvj8bYA4u4NgEvqdQMF7ikB4cg7N/RBRW
 eUFnjODNkGFzve8AKtb+UMerr1zpf/i7L9Q6p3wBt2wd9Fei1jQAAAA==
X-Change-ID: 20261123-ccaione-upstream-spl-mmc-dynamic-get-info-ec88a5d5ee2c
To: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 u-boot@lists.u-boot-project.org
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Carlo Caione <ccaione@baylibre.com>, Johan Jonker <jbx6244@gmail.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The introduction of SPL_PARTITION_GET_INFO left dynamic MMC mode without
partition lookup support. The partition drivers' get_info callbacks are
NULL, so lookups fail with -ENOSYS and prevent booting, including the
Genio 700 firmware A/B flow.

Fixes: 8b5070034da4 ("part: introduce SPL_PARTITION_GET_INFO and select it from consumers")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 common/spl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index ef70e96ad83..05a253c9528 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -593,6 +593,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC
 	bool "MMC raw mode: by board-selected partition"
 	select SPL_LOAD_BLOCK
 	select SPL_PARTITIONS
+	select SPL_PARTITION_GET_INFO
 	help
 	  Select the partition at runtime instead of using a fixed number.
 	  The board must implement spl_mmc_boot_partition().

---
base-commit: 0b3875426f261150e6cf9ee14aacad9b76c07937
change-id: 20261123-ccaione-upstream-spl-mmc-dynamic-get-info-ec88a5d5ee2c

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

