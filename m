Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E25F9B5E0
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 08:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA36583936;
	Wed, 22 Apr 2026 10:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fv6phCc9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28D8B83E76; Wed, 22 Apr 2026 10:49:06 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C91048352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 10:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so16259235e9.0
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 01:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776847741; x=1777452541; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dAQM9W7MIYTk8loJB6VBHwgqVK0O5C+QfLuZ6li2CUI=;
 b=fv6phCc9qg860Bah81vAzbjqNJ9+NtCjT6DoBQv5wWC/yJlvDQcx7aENtFChblneBw
 20MxniQRU1JH658PCRex5NQAvFr99Sic4pFUEw9HclRSNr+GOZwUjGg+sbD8qZpatEQ2
 vZFmMd1lj5O2Pe32CQzGRRNDCtLtn6ZsTm6nJP/GCXZ6H/e5v/M5eWBy0yclTVEbLait
 n/eeet+ECSpxPi+uTnnv5B6FyeCzPoYdx+vyB7H4K83zy1PRpQ68ju0YEtbpmDYKZELq
 yVn4fQLvh/gnxuNGMCS5RJMfbC3pgjAPtSeUhqMxyVm31/PvR3AMvMy32wwwGPEmgUBa
 u+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776847741; x=1777452541;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAQM9W7MIYTk8loJB6VBHwgqVK0O5C+QfLuZ6li2CUI=;
 b=qCTw+hcIwmUDPgqY0GvBcNRwJa5UuPENxBSFNplQ4re6Qf4m8xAF21j1EqNbAUmKY3
 EGoUuMUO9mtH8ef0mDfsJuN9klkvJ3TUSZ/rQxkVM1ovGgNtdiiDheOn5IiX2gVvRHmo
 CcT7XjhHt2OhIgn64WHQfajuWlwgwjbOcMQHp64zze5vzZTnMZG0zKqygpJLaJyl3Iw8
 0nKkLf57hIyfiAgtlCZEKsnZU1uy1kB6zudw8+lwLA/tsXoZT6qzjA34CKJLHbMaBfU9
 f/FeM5r3KcdN8lvpt+m0WC/4usf8g6LDNigUQLj1mfNicGxfg5yBXeG4KbI97nhAtxUp
 2Rdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BZ0Q5SPdj+qXAA9jCIbp3CaUtNGr+zTTvYGGeeZ6RTiL/3jiRVafB3dY3tk5JhqznpCh76EY=@lists.denx.de
X-Gm-Message-State: AOJu0YwdpnRLIS0MVd12lKy04nCDKEfVdyu3D21cPorb59W8QHzz7kk1
 x7mY/7w2d/uJE2VPvJ+5AoDbEJezu+fwk1gQiuWy6tU3L9AZtDtfchi6kb8SOaUzXws=
X-Gm-Gg: AeBDievOd5EpM4NyRoN1sL5ipEY8gB2IDJMZjLCAEevlWt3LVi0uUA1MxtAlNbFKTc+
 a0Or0rzOeZwdcWsEx3fxcUTEU7+yhsumNYhf084A/AXF+nidaTjaqDwMrUNHr3Tj4nL/iiqLRx4
 ZvdXLuh5Zx+9W8sQjMsZxx1e6uFsYxxiPQw7K3B+MrMnMqxDtEUDeyc7TYsbWdn6+HiN/i0wlna
 3hdToIgKAmME49kWzSosgdBPWTpebYsoJX4oz2DrCw6xujgKZ2ZYyYq3ktHP91fdRGZMUU2QQMd
 vGYvupuVh19djxGGXpDarVNmy6Djywf2nj3GU30vaAjl1UVJ89cKguHFtm1xJcOE6fiuo67fBOu
 p7QvKnHWBy4CgMlYVbVVyLXeZjbkqKYT+VAayugF0aaaNHqozUV75id5c3SxJlQ6QghSwKJ6TFl
 nuNQjrfVrLoa/Okjx6ebiyUuJKBWw8W9n5qNc/gn9AkWcMGIAzR1ZT/eDacJB98I4zfw==
X-Received: by 2002:a05:600c:5297:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-488fb74a431mr350427545e9.8.1776847740911; 
 Wed, 22 Apr 2026 01:49:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb72d365sm211755165e9.1.2026.04.22.01.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 01:49:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 22 Apr 2026 10:48:58 +0200
Subject: [PATCH] clk: meson: do not fail when setting SD_EMMC_x_CLK0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-u-boot-amlogic-test-v1-1-b5790d3c04e0@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHmL6GkC/yXMQQqDMBBA0avIrB2IQVLSq4gLE8d0SjWSiSKId
 29sl2/x/wlCiUngWZ2QaGfhuBQ0dQX+NSyBkMdi0Eob1WqNG7oYMw7zJwb2mEkyGjeaZjIP662
 CUq6JJj5+167/Wzb3Jp/vFVzXF5tQyhh3AAAA
X-Change-ID: 20260422-u-boot-amlogic-test-6bd61f679c90
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1759;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xV2a21hKp5VhpsmUrUee1s0gQeQIm3eaRsuWK/Q6bcM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBp6It7lAy8JvM6kUYnXtUOwT8UkXgyeSXmUPb2+oga
 4Pi2PCuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaeiLewAKCRB33NvayMhJ0StQD/
 4vNa51gCs5StNa3oWuFA6JhdanyO/mKCan8OzJ/OpbHzTsCZEj/6ufhYkC8EUM1U9w4haO8HKLQHpw
 WxkjQF5l+JzEtWGEHqTiplkINCuKKXYqt33puzItjHMnWVHAUbjEVHhRmrDU8VSu1edQc04B8Y/SH+
 rELAKwElOxEHfUPgVT5bdZwkaJh/lEed/n2RaLNKSFEaExi1e4+gb9cpsuTAD9KXK+OMY3+izDpVxc
 1Yrt/jOD4QZypwkAzjNneUvn6TwkinWRO1S3CP0Ot/+IwoUbxcf1qydfz5LSNGtWW3SrWhsDB8HfGY
 ZVcYmk98b3CMO1RBg3bcXUJ83kSRrlNBtNMx3jn4wAtCd7QT52uSIeDvF0V7chMvfq49tWnozFSc4+
 SIpLsS/bCpBlOt2zVSsioKN04L2cr0mvyA3pyhKitltMgHRAoS0Ge5/DUp0DBdS2JOnEiGd2CBUVDu
 L2/uJINu/AGnGlHXlamnxfmMuyz0WMGhwpJA2Z9dI/trUyldLbR0ipj183eq/jTiKU4IUuQHBnmxm7
 RDTObq+Q07zP7TY5fb/L4qtPvS/+YDWHeXzl5Z5svPMgXiQ2JoXi91AkIvL+eGZsyBvCcgletSZ8no
 o4TQ0sBZFDTe436iUrOHlCuaJW45MEKiRprl9SO/q7ZyktIx1YwrJrf6+9bg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Since Linux v7.0, the MMC controllers has the following properties:
  assigned-clocks = <&clkc CLKID_SD_EMMC_x_CLK0>;
  assigned-clock-rates = <24000000>;
Which causes mmc controllers to fail in probe.

Make sure we do not fail until we properly implement rate setup.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/g12a.c | 5 +++++
 drivers/clk/meson/gxbb.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index a7a42b2edb6..f33938e1419 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -946,6 +946,11 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
 	case CLKID_HDMI:
 		return meson_clk_set_rate_by_id(clk, CLKID_HDMI_DIV,
 						rate, current_rate);
+	case CLKID_SD_EMMC_A_CLK0:
+	case CLKID_SD_EMMC_B_CLK0:
+	case CLKID_SD_EMMC_C_CLK0:
+		/* TOFIX: implement rate set for MMC clocks */
+		return 0;
 	default:
 		return -ENOENT;
 	}
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 218be45c2cb..bf46f4d50bc 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -900,6 +900,11 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
 	case CLKID_HDMI:
 		return meson_clk_set_rate_by_id(clk, CLKID_HDMI_DIV,
 						rate, current_rate);
+	case CLKID_SD_EMMC_A_CLK0:
+	case CLKID_SD_EMMC_B_CLK0:
+	case CLKID_SD_EMMC_C_CLK0:
+		/* TOFIX: implement rate set for MMC clocks */
+		return 0;
 	default:
 		return -ENOENT;
 	}

---
base-commit: 052988aa29bfd506d7ce207fbb3f5374a5dbecbb
change-id: 20260422-u-boot-amlogic-test-6bd61f679c90

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

