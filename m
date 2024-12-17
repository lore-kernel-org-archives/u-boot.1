Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4F2E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 13:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B63838022E;
	Tue, 17 Dec 2024 14:29:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hyXZ5eiX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC7FF8022B; Tue, 17 Dec 2024 14:29:15 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A45801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 14:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nbelin@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso57818335e9.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 05:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734442153; x=1735046953;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8++5+VzIoYov+zNJ8v30ZKjDwKuygWjvoyFFwWjmyjM=;
 b=hyXZ5eiXQ74Up8Z0MOR+j072vBhZejQKbjlEPjdLpNYGO+2nZ7AbLX/FQhs0np8XJ9
 mN4JTtk1ekI5DkzIdeVA5h+2jkCtWV822deHHFjIawmlppONxfS74up22LMihOsXdYrS
 IivHmEtspx0voykBHc4ZBoEYVLEJjtWZn1mQE5rPHUvaHLcvY3dTN9Nh2CgJVTr2DlED
 WpiLBtN8UcgRwVxkpAlbbI79Fj30S0ZOMnzDK7c1Ly+Qouw9KhQOn+sVIDFcApuODmnF
 2rqrU/hrrODuYz06jXur00gVUkO+gRtAfojMHUKE2gddSyY0lJERKHNMuDgkp8BmUEX4
 KkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734442153; x=1735046953;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8++5+VzIoYov+zNJ8v30ZKjDwKuygWjvoyFFwWjmyjM=;
 b=vAB9hIAcyNn7H8W6GMsBxv8L8hA8IkAKOTEyPL991RrCxc3mGotLJ/zzAAlHRxlxwc
 JzR4XN768LWUTWooOJfNYFpn37VM0uBDx0RthS9YGF3G7Q9kJJpGczBfPcwW1ymj/lNd
 hRztvoZVIjq3fUUAqSgsIl2LxZRemhy/q0hJPEn2Ylqj5FX5PWEr0m8aojBTCSizxy+S
 d4DNX2pfHQnd8IX77bTMksOEXXgVVp8d6+gdoq7xFxP0ry8A5cREF+4FTM+lazysZdR5
 zBlWcbcva1ogcWqmaTlaH3Cw+NwBonlfdg1CeYZNPXO8ih6vGXLZPtBX1k9QJ4ma6Lq/
 rvjA==
X-Gm-Message-State: AOJu0YxqlSW6lxoGzzQ35HY74vn/fh/qyvyLuSA1ffwN/s+rpAH5DuVF
 jVLbZP4LcOGziKNiWX73E7kkXSx83PDtb74/mRlX1sUJ23QTmAmeEnHsXbedXDs=
X-Gm-Gg: ASbGnct5hRybO5UGY8iqqtJDyH1Tqwi+cpKghlOH9pIVKC00F1kyOkAkRpDxgwHpG/A
 REDuLlXw0CeDcbVryaHrDcnwwaEBRd8jQu8icUk1ztM7DAkG2qZKV8m/TYuVISfIkBVvN695muU
 adixyxBva/ozxl1sbpWAb1afwDy7+dWLspIhPTU4RMlR6RREq16oGvTYz8JlbihER0iUPzABeTz
 XfOlOWzvwcI6MJRhpZuBpvAuyWv0hwrqhoNlU1ExM5G5yHyXu9Y/BmY
X-Google-Smtp-Source: AGHT+IEj7aAOTDwpD24Qt+dlcNTT6+G6OB4WxcZpzzu8vBi1IIQGDRdhU4C/UrOaLY82Ucucvf0p6w==
X-Received: by 2002:a05:600c:cc9:b0:434:f9c4:a850 with SMTP id
 5b1f17b1804b1-4362aa27edbmr179298825e9.10.1734442152996; 
 Tue, 17 Dec 2024 05:29:12 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:6fb0:d0f1:bd21:f6c6:25a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362559ec08sm173605115e9.22.2024.12.17.05.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 05:29:12 -0800 (PST)
From: Nicolas Belin <nbelin@baylibre.com>
Subject: [PATCH v2 0/3] boot: android: rework the bootargs concatenation
Date: Tue, 17 Dec 2024 14:29:07 +0100
Message-Id: <20241217-fix-bootargs-concatenation-v2-0-b2fd7cf4e130@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKN8YWcC/42NSw7CMAxEr1J5jVEdIHxW3AN1EaemtQQJSqKKq
 urdCZyA5RvNvFkgS1LJcGkWSDJp1hgqmE0DfnRhENS+MpjW7MkQ4V3fyDEWl4aMPgbvigRX6gx
 PbMl6opbtDqrglaS2f/JbV3nUXGKaf18TfdO/tBNhi94eD4Y9n/teruzmh3KSrY9P6NZ1/QAtc
 25JxwAAAA==
X-Change-ID: 20241211-fix-bootargs-concatenation-8b616c110b63
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Safae Ouajih <souajih@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Ahmad Draidi <ar2000jp@gmail.com>
Cc: u-boot@lists.denx.de, Nicolas Belin <nbelin@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734442151; l=1243;
 i=nbelin@baylibre.com; s=20241211; h=from:subject:message-id;
 bh=IkCD9CKSh6+WjhiG257UX9zhwBCgpYEym7CM+sT6qqs=;
 b=w3bflscqevdjQwIMRSIBSX/k5I7mXo+A8qUm+o9qFVeuZ380xTx9ysfH/ngoir5kKzffnjSr2
 wwNZwHn55+TB1pxBzqMbunVloEUzea6ZAvsyS9XuP+dIgc0BNEy9l2B
X-Developer-Key: i=nbelin@baylibre.com; a=ed25519;
 pk=w8SrWXgXuIaN/RB7JHkKa2EKDC5nVxqVHI8XawK2M7I=
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

Rework the bootargs concatenation logic to make the logic clearer
and address several issues such as:
- checking the value at the address kcmdline_extra instead of
checking the address value itself
- freeing the string that was malloced for the concatenation
- making sure to malloc the right amount of bytes for the concatenated
string, not forgetting the byte for the NULL termination 

Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
---
Changes in v2:
- Improve the logic to avoid trailing whitespaces in the concatenated
  bootargs
- Drop the last patch reordering the length calculation as it is already
  done by the improved logic
- Link to v1: https://lore.kernel.org/r/20241211-fix-bootargs-concatenation-v1-0-c6752bcb9dde@baylibre.com

---
Nicolas Belin (3):
      boot: android: fix extra command line support
      boot: android: free newbootargs when done
      boot: android: rework bootargs concatenation

 boot/image-android.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)
---
base-commit: b841e559cd26ffcb20f22e8ee75debed9616c002
change-id: 20241211-fix-bootargs-concatenation-8b616c110b63

Best regards,
-- 
Nicolas Belin <nbelin@baylibre.com>

