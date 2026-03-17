Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EABBFD877D
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCA6D843D6;
	Tue, 17 Mar 2026 15:24:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fK0YaHpI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6F2684353; Tue, 17 Mar 2026 15:24:33 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7324184332
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:24:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso51662955e9.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773757470; x=1774362270;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t6qT9gaiZn5CVuggR+Eyl/akd/+1nJS2JRBTC1Eo1eo=;
 b=fK0YaHpIFcuTn2gfBiio1+jMVUwwQaonmOsDpUq5vVXHNqmtQrq+BF5MDcZqjb3X83
 JPU7sy5Jr+9NiR5h5FL0gMTWAt//9ufU28QTMzssv6RotAUhdKhBg+waPLckK6A+darI
 g03CqI2Poabl3EfG9Ca0gCMad4dfA3B4GaaqHUKVYbg5GiIh/81tLDVqhLABqEgXmBDL
 i6TDFtQVVyglnjBtrIZk8wh9ZHC76BFS1OZJDSnKQFMlm8V73fL3wFdIuH/P9KFKM4Rz
 gcg7v8JJwkX+HvY8xgjjWd5oIHpidhHFswlHKmb+Tx72w2YJ0ndjo8qmz3DJYc0IRJxr
 TsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773757470; x=1774362270;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t6qT9gaiZn5CVuggR+Eyl/akd/+1nJS2JRBTC1Eo1eo=;
 b=Uhr6IiTDOZmNY0x4e9IkaIGsTOGQa9kfkL7XcNUs0m31lg7S8cpFSm+Lu5ZTJmWFNm
 374fJLOGwQk+TDdeTYu4pNtDtdbpLugZGEGp0fTlBc71Mf2hi5eIlnwBOxFmXtueXwYW
 nnoAgYNzEMDklWgZe6Ynuy8ajcodX0ajDh4olLEu747vs3zPkhlke6FBpPj94g5KCqsS
 IMwTq8VUCOjwlOuJRANLU3JSZsaF0hR7wYrLbvEcnEkcTkGY8FUaO25EZCfDTyxHV8rr
 R3GGi+71f4ghZulSSLkOvo3H12RtNkf+/pHZZecR1K2V49QzhM2LPcIuQ4O+KySZE30X
 UIXg==
X-Gm-Message-State: AOJu0YxriHgwhz/CsQxkCj6nzBHLjU9EGj5iA+5XDloAbSHitd/T58n/
 n4AGGZYwLiOuFKE0U6++Tp0gffNSg34ejQkIm0+FkAetTFCS8qMYRg/8aPl9ZAoMJdY=
X-Gm-Gg: ATEYQzwevgVW93dhrnlPZdQbdjtTPM6ChltmJseIO7Ae8+OnBgqRmejfna29cYd/GxZ
 UuLTB8bXO8a5cD7yKkaqZR49DCVb+BN9fwzQiD1hirMp8Yuc0Ot/zW8jfupuvWRpnqIWp4Hdfeo
 791uac81mKMngQnwJs5h0tOPiRakNlqu14hS3W5L7CWrikenoyaQNm1LWp5Ew4k61TT6DaJ4AKh
 hAk9MR9IBE9iuPmRchITKsGWQiXXCGLlp7E2apYCXMTuW6I5YflkahVODiQ6NbhZ2QoC0mVFdz2
 uZhR3p0w8qAcZnHft9xhUOeK/xAI/bWiNPGdUJfBKam2VmqOn69iAHMH3iMNq2kZqQZfU9iU4zR
 hUXmFQdrR/w8hq8XwNDOzWKFFMjRwEfBQ4picbyyP0VqRIQlUMKUujOZ8pqc27JQsU1KQedMoEH
 w4+vwkPm/Gs1OpqzLpkBRs5q3DClTgrTloKNvsZ7DYm0lqt7M5b/xYGZKdS/594/NI/HlYylV/C
 u4v8aVpYAUShpV9Q0UQFOqzkmMjPGERi17Wyga42TSSUDfT5bRLFwO0I8l91D5Wes0BYk9kXFdS
 jpWRNh5uHYmeW+/bJw==
X-Received: by 2002:a05:600c:1e8b:b0:483:b505:9db7 with SMTP id
 5b1f17b1804b1-4855672ada8mr288701465e9.32.1773757469742; 
 Tue, 17 Mar 2026 07:24:29 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48556400f76sm125425675e9.1.2026.03.17.07.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:24:29 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 17 Mar 2026 15:24:28 +0100
Subject: [PATCH 10/11] drivers: ufs: ufs-mediatek: add MT8195 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-mt8195-add-ufs-support-v1-10-7d731ec438ae@baylibre.com>
References: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Add MT8195 compatible string.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/ufs/ufs-mediatek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ufs/ufs-mediatek.c b/drivers/ufs/ufs-mediatek.c
index 31916f72c86..3380783e8b1 100644
--- a/drivers/ufs/ufs-mediatek.c
+++ b/drivers/ufs/ufs-mediatek.c
@@ -395,6 +395,8 @@ static int ufs_mtk_probe(struct udevice *dev)
 
 static const struct udevice_id ufs_mtk_ids[] = {
 	{ .compatible = "mediatek,mt6878-ufshci" },
+	{ .compatible = "mediatek,mt8195-ufshci" },
+
 	{},
 };
 

-- 
2.52.0

