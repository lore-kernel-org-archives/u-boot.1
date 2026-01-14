Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F57D39003
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 18:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE0883015;
	Wed, 14 Jan 2026 19:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cSA2AYrh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 372CF8063E; Wed, 14 Jan 2026 17:11:00 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C28480325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 17:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3ec46e3c65bso6763789fac.0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 08:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768407056; x=1769011856;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x23s7Nrg5O/+BJ5N3xsSkIYVJzjBSMc96fEuFJsQriw=;
 b=cSA2AYrhryChgM1jmR/0CSrb4goAsO83iYWWLRTk8MUPqxGgaITcagQa2aYDhm1ADd
 tViFYKvuBKBygJPZ37OZIznAJNAbv7CXe5VBVrkysM9dmoToGTkJNdMNU5/0xNINVjx8
 GoTvw0oGDWO8Gjo5p4cFevLo7/ojuyRkesnRFrr/uwvG4QZdeTE7NMsFbgyjTrO3Wwt/
 /AKer3uHdLwdZhWzGE4JTvW7udJMqKnCJ3aKVVqo9QgicmkXWJG0WSv6Mk55noSPvFcG
 IQ8VEW72LDPoPIfcStIYZvHrAWv5NKgPEK5gHmWdjiv6+zQvrp75gsTNiOJ1uz/9dLvb
 Yr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768407056; x=1769011856;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x23s7Nrg5O/+BJ5N3xsSkIYVJzjBSMc96fEuFJsQriw=;
 b=dqc6FnhUJ2MSHG2kzGJolm1OBQ+uw76EOE2IB4NuDJhTbxbCzS1mWWeCqtvhqlbxIO
 LF5uV4LRcXaXlYLWJ1yk1oJCZ9+iOdLggqn6YFTwiOQjhFHmoCDkzPbtP91WWStVfMuF
 D3RQVE5xMhj8lkFfuuA9enTR16fAIiTi8pZZlFaoTDEnegG1GrOSbzJIxNdtDUWCQc8n
 imct++jqDduDIgQpsK2McJuxYwgVunOwPztT4SuqZrn8/OVGMoWEK+gYCOuUbxUfB2sT
 UqSOr7j9aCc9ofHw/BirKNQAJxvth1BnmajLgiHcy2dCPXNSVYMXCVufaSMX7S25GK5r
 Yprw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLgAxJZPlSfdoHzw8qckEwebBIQLp8gUCdqUtrfEtt11/KQw7L+d9x8iqOltCdaosA9Mdy+y4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6/4RFNVd/NlFF6CqYnad85tUlgSwa/eyiMmGjIuoogZ0ILNUo
 BiFWuEphxK2iOf9wYn5RLZWNalNq9UBWglqZSNZtqZ1kaEAlSCBKdecJr0t92v8oQsE=
X-Gm-Gg: AY/fxX5LwcErrPyymVBq6QcrR9jXO7quS8xppLNaeZtye4Qp+UjUNd9RPU7+IfDjcHg
 EJnCTg85JAVvMoXXiLdHriPY0AFrLoLQZSIjoAZMSSoYluiwRBCj2iV1qQYZVZU4M6cZZ4zf6cC
 XF/ZZQ/n0jUs1D+RA2m/rTKQ8rOugphhsrIULFNZSz+gaGmZAywD7XgbMy+t8LI2sWsACQCGqA7
 yJgUoNvxmcFeG6Nbcqlmb3cJKh5MuhYTN2MicpEENc0TRK64X/U1GJw1n7sD6NkDyw/Ix3XoqtK
 iq2hzaPISyx6Cbe1c3R7NYDEsnUmHiAHz2VO63mq7ZcfLQYreBUH+bbronJkEgXQIc50gUK81YG
 5c8tnoLkPxJ/qQZlj7nL8d33RbtxYDEFMO3gUhaICV9c77ikS0I6hEbXwk9h8R/73wFYL9ajNPC
 xwvVPBQk3KkZkg9YA=
X-Received: by 2002:a05:6870:d6a4:b0:3fa:a96:e280 with SMTP id
 586e51a60fabf-40406fb9e9fmr2393459fac.25.1768407056161; 
 Wed, 14 Jan 2026 08:10:56 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:3ff3:5a3e:f89a:1938])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa515f4dasm17026044fac.21.2026.01.14.08.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 08:10:55 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 14 Jan 2026 10:10:46 -0600
Subject: [PATCH v2] cmd/Kconfig: fix typo in CMD_PINMUX description
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-fix-typo-in-cmd-pinmux-desc-v2-1-a378150e4ad3@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQqDMBBFryKz7pQYMDVd9R7FRUzGOlATSawok
 rs39QTlr97n8/4BiSJTgnt1QKSVEwdfQF4qsKPxL0J2hUEKqUQtFA684bLPAdmjnRzO7KfPho6
 SxUaSUUoOLWkDxTBHKvPT/uwKj5yWEPfzbK1/7X/etcaSm24HpbRoWv3ozf7mPtLVhgm6nPMXg
 E9KYMkAAAA=
X-Change-ID: 20260106-fix-typo-in-cmd-pinmux-desc-52ea662f8e9a
To: Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Nj2dbAMZ7V1zman6WeM3gZSGTntxw74j3k6e+TKsymA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpZ8AIDWMoWzk622vWT+1ScYixHdxmZJjfvEmQe
 2OxAWe2HY2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaWfACBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AzNkH/jQGFq+2qSjaQj0hADCl+9mF7qD1z9E5nC7jmVz
 +aH/mhhxSfwPOtX+ADsJh93vBESfv0eHCh6sunNo/QpOJo0xGB0Xwsr3kT7bxkfjhQNJL8DCE+l
 KHW526WtzO5/bEam7+2FKxbK+d4PrIy6FPDMnO67vrwyNVy/tqXvjUmdY/GlqRS0Ni0GBGMOOAG
 PtvSO3pY5Q/6nZmD13B5gOV0KR70KbaZwNkc8DbAOOug50Ef++HKgUOjGUosDxUE+80V4xgh/9d
 2nlqA+zahiPH4CTDzrVqA0FoNHko1Tm5rj14nNCWMJeQquR/eiZ0zefRpemLIdckvNDdL0nMGY/
 RoyE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 14 Jan 2026 19:01:30 +0100
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

Fix typo with correct spelling of "purposes".

Also change "debug" to "debugging" while touching this since that is
the more common phrasing.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Fix typo in subject line.
- Change debug to debugging while we are at it.
- Link to v1: https://lore.kernel.org/r/20260106-fix-typo-in-cmd-pinmux-desc-v1-1-1798f6690589@baylibre.com
---
 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index b71ac554c0b..3138ffaa639 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1679,7 +1679,7 @@ config CMD_PINMUX
 	default y if PINCTRL
 	help
 	  Parse all available pin-controllers and show pins muxing. This
-	  is useful for debug purpoer to check the pin muxing and to know if
+	  is useful for debugging purposes to check the pin muxing and to know if
 	  a pin is configured as a GPIO or as an alternate function.
 
 config CMD_POWEROFF

---
base-commit: d503633a36767d756c7de28305cf0de79440cbc0
change-id: 20260106-fix-typo-in-cmd-pinmux-desc-52ea662f8e9a

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

