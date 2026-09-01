Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54416C61DD6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 15:25:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF7F4605E3;
	Tue,  1 Sep 2026 15:25:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ccXyB1nZ3_3Q; Tue,  1 Sep 2026 15:25:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788276302;
	bh=vr27VVtHznrlkXXtH95MbGmwxSlnoPyi9XLHD+cY6T8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O9EEBusPCFgAu+FRX+DsuwK/gJesErNkJLP7uK3lqKUdA0MEYX6TC6uhbMuSFc9E0
	 Nerr/Uh7/BUTkHDZg9D3Movo68mlksVXQTHn9aOo1RzFSePiqn8sGDYSgE4DmJ1s54
	 evdMGCmEU5cejujuo3D/9Og7UFNrIFPaBBS40ze/UndLlUNqmuRuhM81xIEJnHyTHP
	 OJbL2ih1oxnObD6roPkniimVW+k/hoMygkoBe2WQ2Rlh3O33dsC0Fspo1n2NFwD71k
	 vv94etpqXabFIu0XYcE2rzfB9Udqm0cD7qKDVFkjHv4ob7syEqErEPPLd0r0OQDx6n
	 B7QCd3fT7r9Hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEEB8606E5;
	Tue,  1 Sep 2026 15:25:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BE1F8265
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 15:25:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF44F606F2
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 15:25:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZhrpLEmkl_Zu for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 15:25:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=airz2K34
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6FE95606E5
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 15:24:57 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49b8e527d63so11560705e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 08:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788276296; x=1788881096;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vr27VVtHznrlkXXtH95MbGmwxSlnoPyi9XLHD+cY6T8=;
 b=airz2K34SW6m25AX9BqL6JA1Y9s9UwvTJ+ZKuqaW8w3jmwV7Yho3KmCTHAMYwDVYsy
 0mGFEh1UQa7IboSzCW+s4a8kzJZ05UWSZOBT7wlcf2vz4GkzRuO5umpMBPEVgCf4TCtx
 6NcOCWIHSVJmQ1TVNdlm5FakEsofItKjcUn7ghFHWOL0Qb9jHPsC9YKYwv0NpvYqN23/
 2vKC12nmkX9Up1mj7Cn3t7iS+H9uCYGeHLWdyaDNSB1RZvvkGYFFCW3vBo8bPad19bQI
 jAtVzsuBkigZhYgal816acJD5H1C7mj/aNbl7ic9vX48p6dWFqhCXk/WQ2i08oSmh/HI
 IItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788276296; x=1788881096;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vr27VVtHznrlkXXtH95MbGmwxSlnoPyi9XLHD+cY6T8=;
 b=OpR/A1fNm9WY8nu3IdlSBG+COd8LtJ33xeiIDyk7LXmv0vXEpKypJ7SbMTp7WSvi6y
 Gh1vPk8dhzUa+6d+oVLKaqDhnSV6KDtexW24buJj4y5scTMm/+aDcWZZ+YMTRLEY4fTl
 4OG5bB5pjXTmFWCh9d6z3rK0yfODOOXQeQMEo0jFiiXuDasn2U1bxBtDaP28G65ABc9l
 a4eA5BqI5FkkOzhcTT1/BxVrGsKIs7vMQiY7sq0oKnIkue++ywc++SrkMOeb+mKAwmRN
 cpFlmoBd93IS35zGfrAK1RKrKz+VWawibpE3xrISFb76TIkRbDX9g3QZOCyLICp97+Pq
 ON8w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVUxnOmowuVBqsBjn5jIE8uKBVkFqacusH5NjyRV0YOqXtkyB8cyzCwtY3dILsRCm5IlODXAM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kYZKMwjsxi2PlHIk43yyYMpqjW0LDBdCHYuBIDCq69ZZdV44w8
 2gH4E239aZ5eZzJkjS5/hou322Cbeizo2ftw55NTqVDXAFJFWzfT26YH3OBbKYUG4e8=
X-Gm-Gg: AR+sD11QA5zJM9nrBSPR+xHGHF7jjjS5L3Q6pzZtbKxoX8FH0L1vPJg6o2cKkn9GtxA
 9RJyEG05p8AfDxLUFKniNcDgBm1P1UXP6iwxPFEOhH9bM8q4Ab+XknhtjlJ7/TFrM+oC5Tjzg6p
 NYB7rbQ0SKRkNMtabIu96BXoZwvKdTcL/sP98XXfzSm/oZKW8vr8a4O4hnd77LwsuwXKG+1ru+p
 szubrgeNMkAZl1ZRjeYsZaZfJV0FxgEu3N3tBVEpqhn3CuF2wOXnSL97GM/lfc6B6f9wcVildR5
 06qHS0RML4p4z2P+lvdPmHqIam6L5Y2zl4YLhVEAXKp9Tw9/3RJ/QBT2myhknmdLGJT8FKo0bfS
 A/HIvyK55eajqGLFv9FZIYG4EZKMKhBwagKpLCwHDOTx9qWlo2rDOXEHxU+isLme7IDYnUgayJZ
 Ce/MFgo/hUKkZOVW1GOMiMtcxLS84ph2wEcPQrmUzt54HQV8ha6mYb3gfD4s+7A7MC2UKU0jxlR
 kEjrQcBugMy/8bxhdWMx+t73D/zLrBbOnszPSSs6otH1jPxhrYNDAWFsGGtrCWCxuwlOO+ra+Nu
 YcftjtOyWXKM7bljNx8OctMklcJMtkPQz4Yj5eEaWgpW
X-Received: by 2002:a05:600c:1393:b0:49b:12c2:104f with SMTP id
 5b1f17b1804b1-49b91c2660amr497241835e9.1.1788276295932; 
 Tue, 01 Sep 2026 08:24:55 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce089c2sm74487405e9.2.2026.09.01.08.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 08:24:55 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 01 Sep 2026 17:24:51 +0200
Subject: [PATCH] stdio: gate splash_display() on CONFIG_BMP instead of
 CONFIG_CMD_BMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-stdio-splash-fix-bmp-guard-v1-1-78e2e75ae441@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDuQxKq0VykuojPqSKsho6Ug3
 r1Rlw8+fwPlKKzwzDaI/BWVeUqwtwzawU89o1AyOONK8zAWdSGZUcPb64Cd/LD5BOxXHwnzwpJ
 xVOX3ooI0CJFTcM5f9WVdm5Hb5TjCvv8BJqjAW34AAAA=
X-Change-ID: 20260901-stdio-splash-fix-bmp-guard-351d02d73457
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, dlechner@baylibre.com, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

stdio_add_devices() calls splash_display() only when CONFIG_CMD_BMP is
enabled. However splash_display() depends on the BMP display support
selected by CONFIG_BMP, not on the "bmp" command (CONFIG_CMD_BMP).

As a result the boot splash is not shown when BMP display support is
enabled without the bmp command. Gate the call on CONFIG_BMP instead.

Fixes: 5eb83c0ac114 ("splash: display splash in DM_VIDEO configurations")
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 common/stdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/stdio.c b/common/stdio.c
index 038e576147b..271a37e959c 100644
--- a/common/stdio.c
+++ b/common/stdio.c
@@ -332,7 +332,7 @@ int stdio_add_devices(void)
 			}
 		}
 		if (IS_ENABLED(CONFIG_SPLASH_SCREEN) &&
-		    IS_ENABLED(CONFIG_CMD_BMP))
+		    IS_ENABLED(CONFIG_BMP))
 			splash_display();
 	}
 

---
base-commit: cd5bd0cb98ececd1e2eb69d0093e4940b25c9941
change-id: 20260901-stdio-splash-fix-bmp-guard-351d02d73457

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

