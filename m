Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C604BC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 14:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5053A80C9A;
	Mon, 24 Aug 2026 14:23:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u2hkuSM9lqP7; Mon, 24 Aug 2026 14:23:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787581409;
	bh=exU8SroTTt24qtdfJ9gJ3PqNbDyZv14pQvuuMu2rmjw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f1MapD/Yq4pnUcq8LvEYNRE+KdNPy+5HDf+UMUwRuebnqvSA8mbT0ATPFFgS/KbmT
	 UYFgOIB110+1bUtEGiSJPg4yu/FakBqM3RPNqpna3spbUy+AyMRs7KzKevWkrJoIJY
	 Pv7sGLmmo5HN/nKx6TxxVRm9PGoUOWht82YBuD7k5bLxoNGLSYJxfOQaXUWdL7506H
	 WFmrHO9MiNJGVQ/Om7IBgZin6x7PiWdFuKjcLFfAC7bcQfkVtveiCRZCKhEwD8s+VB
	 bqSI25EphpHk3q1I5TF4G58NKDBTU/FSMZIsVunjZDfOiNvW59EXj7k2etaSbh+dZd
	 xGbAcfvi/oseg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7639280AEC;
	Mon, 24 Aug 2026 14:23:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 64C533AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 567FE6060A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:34:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LUgvjlO_ceJO for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:33:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::731; helo=mail-qk1-x731.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=X1O2Xf20
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 68C3D60606
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:33:58 +0000 (UTC)
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-930f618435cso182231185a.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1787578438; x=1788183238;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=exU8SroTTt24qtdfJ9gJ3PqNbDyZv14pQvuuMu2rmjw=;
 b=X1O2Xf2014q9Bl+08oPJGkLHtbVTBHz/N826l0jrMVnI1ykJeqGfaJ0qsGFsUiA7tm
 xBFogwF4WZTLas+YIhk2s65Z5gNhqzWPbZl0wQzTSqfLhw4pH1CrECeKfw01JsCq/HnG
 XR0sOuOeALO+Up1IpnBRiyHdr1uJp5hGJoFyIHvF3e4BYpY4ddf74mHHMfyAKpRv6eGQ
 mr+Pc3ZYdWtcfn8UyKN9egKgalP0z6HYFNA7YY5YBc/Y6Bb0AX5fd8SQWqIyeVUF+xkd
 L6zS7wEpJsPutbZBWAWD2vW0XZ0x/9Yz4DJZn/wAoT5/+nM40QfVibZUGfkyinLDXCC9
 wnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787578438; x=1788183238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=exU8SroTTt24qtdfJ9gJ3PqNbDyZv14pQvuuMu2rmjw=;
 b=dlNXOlqlow+EyEIqqR4IWtEssGBVQ+yly3HMXQzUDtt7YjbYNlsIkA57zV8sm3YzON
 9cXfM7yRTavlCbBv+BP4m7f7zAU1ajbUpJkqBEmxgyxbUcbunuWwa/CkDLFkFFRXIkZ3
 i683MwOqhX/u0S5KuZjix/YEHe+xT1h5kd8b1/mQIhSmZO/vOls+HahPv7gYsdFuiBd5
 Z5B+Ow5egrnpxLy/+HdeowwZelDkh4TN6tR5a0DuDwk9jUIhSAdXFFOT19YWuu3N11tj
 c+kfGZCHvtwHkoA+taOVinJl5tKBPWYLAwoM3UDk1u+6JiSbtCaK/Wm2eECZuvRTCUk2
 d3Ng==
X-Forwarded-Encrypted: i=1;
 AHgh+RpT99v+6ApAUayaRiMXCGlogAhaOIsA3v/boDsXVO2TuWPYydE4C28PL0gdinJzJBMxeVBCuEE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ngPMc7p0ZW4vOL1HbnhmS8iMM96Gm/9TGengtRjCzal4t8ugQ+
 j4/9cMw+E+5UjHoj3YK9c0jFUZxsrDIOaWNE9Ra13HkZ/+HNdYOY9mP5obY7T3Mea7Xvn0HZJFR
 MajY7ojcNKXqTvSYISldgrVv2YBjwzISKbVBIoWNdYDLZkiLAPDY1ZGOMCmn/Xvw=
X-Gm-Gg: AR+sD10JVqOXWU1aMDWmsamPOjPK+Enr/7zP4+fp6WDpd2ZaBJarHd+J0JUhARPf8vw
 7eOYK6qgspJHVrjPENHGEo6KVsoy4aTOZfHbeDJ1m94QWz7Xxt5+6xhNbL0vB3XKvZEI8tt3Bky
 +mRzvSB2HEVykg2bB/HmCXIzzLUeOZgIb9Tg9uAzCgNa8z/du6oSRJVhgxJIK+nzBwwZkL5a48o
 Uc8C3FN2UeBdRf33zVUU6GZAFJBc6cF7L/edTmqaArJmWXxFfoe+2azRBtIzJ2t24BxaYHJzzAk
 o1LDyXcaSjUIiqUO5SoUhGbasE8dhs0kSqiIof6nO0oiboBNXx2p7qqLqzWo8xIDqY+BOjILtZU
 MXxAZY3Un1/7/AyDGkVD0uwXBa6Xt0fmeWwJ28Rscpn5RTtMEHw/uzu7aqmM3MWLjK9XHNtTOYa
 xPSl3MI7jhCY+YoVLtem9PKbH8mnrNV9nj3159F1WFI3r68QA2f2Y4
X-Received: by 2002:a05:620a:3729:b0:934:ab73:ac53 with SMTP id
 af79cd13be357-937466c84bbmr1751741285a.0.1787578437557; 
 Mon, 24 Aug 2026 06:33:57 -0700 (PDT)
Received: from strozzi ([66.193.28.125]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93749eb4240sm500319685a.47.2026.08.24.06.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:33:57 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>
Subject: [PATCH v2 1/2] pinctrl: meson: a1: Use gpio regs for ds
Date: Mon, 24 Aug 2026 09:33:49 -0400
Message-ID: <20260824133355.524575-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 14:23:26 +0000
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

On newer SoCs, the drivestrength registers are included with the rest of
the GPIO registers. Linux has a rather complex system that uses a helper
function to fix up the registers for each SoC before registering the
pinctrl. Instead of that, just fix things up in probe.

This silences warnings like

meson-s4-pinctrl pinctrl@4000: drive-strength-microamp not supported

which I encountered on s4 and which I assume affects a1 as well.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

Changes in v2:
- Add comment to probe on why we're overriding reg_ds

 drivers/pinctrl/meson/pinctrl-meson-a1.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-a1.c b/drivers/pinctrl/meson/pinctrl-meson-a1.c
index 7e9ac6390b1..f736e9017c0 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-a1.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-a1.c
@@ -856,11 +856,22 @@ static const struct udevice_id meson_a1_pinctrl_match[] = {
 	{ },
 };
 
+static int meson_a1_pinctrl_probe(struct udevice *dev)
+{
+	struct meson_pinctrl *priv = dev_get_priv(dev);
+	int ret = meson_pinctrl_probe(dev);
+
+	/* Drive-strength registers are combined with GPIO registers */
+	if (!ret)
+		priv->reg_ds = priv->reg_gpio;
+	return ret;
+}
+
 U_BOOT_DRIVER(meson_a1_pinctrl) = {
 	.name	= "meson-a1-pinctrl",
 	.id	= UCLASS_PINCTRL,
 	.of_match = of_match_ptr(meson_a1_pinctrl_match),
-	.probe = meson_pinctrl_probe,
+	.probe = meson_a1_pinctrl_probe,
 	.priv_auto = sizeof(struct meson_pinctrl),
 	.ops = &meson_axg_pinctrl_ops,
 };
---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
branch: s4_pinctrl

-- 
2.53.0

