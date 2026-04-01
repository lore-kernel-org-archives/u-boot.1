Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7402107637D
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 14:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC4FF83F7D;
	Wed,  1 Apr 2026 16:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ORlFZvP5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3470084020; Wed,  1 Apr 2026 16:15:28 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA2D383CF5
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so83257915e9.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775052925; x=1775657725; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4ySESJfourxrh2m62qey3M/YF6AEV8fxCE1YjUIBwGs=;
 b=ORlFZvP591AmlXwa3mny7p3MGS8EAD5jokEYyr70675S3yBE509TT3KOc5N+pd5R7E
 tL9y6w4RUzUfxQmZ2icxMgDJx75XDC+keg2UE6DkVvDXGgYtk5V0jjXzBxEROtBSq+xc
 Or/CzWY6GTagQIxWsW6xf2SX8pjl+RN932Mdx1Y1smZ42w2wcHmEIorvadRH5ubgykKw
 nlUAOA1fXeTwE8rIvZSlyBlmPZWJqXwnxsAsjhnPF2SNoVeZ4KYPlf82Im7PleG5/VHZ
 ASk8XVpONTUQ+GqUX6bH9wgAhCre4XP9QpSnzMSlTBvz1NEkbsBvS13hazRjL6d51gFQ
 SHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775052925; x=1775657725;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4ySESJfourxrh2m62qey3M/YF6AEV8fxCE1YjUIBwGs=;
 b=gkS7ZlVsuIUmQALc2QlQHz/mBCWn/WwOfGFyvv2gJMhiuekPyfr4ZV+3CwW0Eymb7z
 U3y3Nuql+V4EGTGRD8hfZIl5kFkbSp7nRVGyh19Dm1N+N43Kt4CihdtnD1eTg9PA70qL
 s0N3FA8Aag7eQHdiGIt1fWZ6WsYDuwdpa2fQzUnJj35LoYmlS5V8eV7By58Pcu80+nTQ
 g2DVkwiObcJjKQnJduTeZ0F4oaQ6Kzf1w8LF0G9413XadUZMkk9VQ/pzzfBgRkY7D6tU
 tLfXU0qMmtZ61U6515+H4l8RY6zn6Sws+oKrt5clug0jFhrw196K5VB78FiyUZ+kTqTl
 JJ9w==
X-Gm-Message-State: AOJu0Ywkrizh9UFaHh0ncPOo5dGHtvHjmdE/iU22ub84eJZLnF5unoEx
 Dwgc2y41LzhortBEeZoNkxDjsqduVGE8+DtE33E/q9vAekH1GyyYzBR65e666+fK7Thr9p4JfKv
 BqFfwAOw=
X-Gm-Gg: ATEYQzww/rpctgE93KTqNiZq0JDRyNS1Xpgaa4wW//uzPVD/0YLYaw8lKXD6k0VoKOQ
 AzsxljPQTgJjUkTS9RCzSHqSxgiuYrHC3ctUXM3SGGtai5iY5uK7GWT8HWOIEw49HtzE+FoPEIK
 +yvXx1o9esj2630rKMtYRT4Fgaxq4QpLSOnBW4tjaF/pJDdtT9blEo6DIzOlWxLDRpTe0OXc7Va
 UJjNLyG6VlIc3pSnrxZGBgkbWFjNHvjUxeRDaWsNyCugxBIZhHAHr/3lNx4PAEOzNiCbmiW5h5Q
 9/EWaURX/Gh+liU4Z6T34bh/dCZuMkEIqRykLYJdgbOLJ4u8MF5/yKznvLGIYA9XtWTUPRvAK0J
 9w709xnsI//tnCNNdAMzaF7LDQPwUazBtOZUA61MjUYxb46K7HJ16tcKnyhCCpC1hyVPytt+z2G
 v8H3stZqCIyTFOe0p5llbF8EW1UDWf+6N7k+noqrftYE/q4qJ/TkE3I+myTdmxMU7yjB5I
X-Received: by 2002:a05:600c:828f:b0:485:4388:348b with SMTP id
 5b1f17b1804b1-48883310809mr71280885e9.0.1775052925032; 
 Wed, 01 Apr 2026 07:15:25 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8bcaf8sm43224135e9.27.2026.04.01.07.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:15:24 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:15:17 +0200
Subject: [PATCH v2 01/11] vsprintf: add %pOF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-casey-ccf-compat-v2-1-414d5b7f040b@linaro.org>
References: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
In-Reply-To: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2375;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=rEJNtXZP5+H5gwqn8qXTXflA9ZA9fkONh6/nGZHH35Y=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzGpVxwa9fczWeNl1+WmOZu/TN6pNn5bjirr7p/ZE7/
 +QJQanAjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRLF5Ghk7+EuftS68tDj2b
 su7rh9n7i/oc+LdWp0UmCGo/zRKav4Hhf3ym0tezc/vvXPzrMGXR1seaV+9fiwpj5yg61rUg8MV
 J1zgA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This prints a full ofnode path.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 lib/vsprintf.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index c7340a047b2e..49dc9c38c652 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -25,8 +25,13 @@
 #include <linux/err.h>
 #include <linux/types.h>
 #include <linux/string.h>
 
+/* For %pOF */
+#if CONFIG_IS_ENABLED(OF_CONTROL)
+#include <dm/ofnode.h>
+#endif
+
 /* we use this so that we can do without the ctype library */
 #define is_digit(c)	((c) >= '0' && (c) <= '9')
 
 static int skip_atoi(const char **s)
@@ -437,8 +442,32 @@ static char *uuid_string(char *buf, char *end, u8 *addr, int field_width,
 	return string(buf, end, uuid, field_width, precision, flags);
 }
 #endif
 
+#if CONFIG_IS_ENABLED(OF_CONTROL) && !defined(API_BUILD)
+static char *ofnode_string(char *buf, char *end, ofnode *dp, int field_width,
+				int precision, int flags)
+{
+#define NP_PATH_MAX 64
+	char str[NP_PATH_MAX] = { 0 };
+	const char *err = "...";
+
+	/* If dp == NULL output the string '<NULL>' */
+	if (!dp || !ofnode_valid(*dp))
+		return string(buf, end, NULL, field_width, precision, flags);
+
+	/* Get the path and indicate if it got cut off */
+	if (ofnode_get_path(*dp, str, NP_PATH_MAX)) {
+		str[NP_PATH_MAX - 1] = '\0';
+		char *p = str + min((NP_PATH_MAX - 2) - strlen(err), strlen(str));
+		memcpy(p, err, strlen(err) + 1);
+	}
+
+	return string(buf, end, str, field_width, precision, flags);
+#undef NP_PATH_MAX
+}
+#endif
+
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
  * by an extra set of alphanumeric characters that are extended format
  * specifiers.
@@ -472,8 +501,16 @@ static char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 #if CONFIG_IS_ENABLED(EFI_DEVICE_PATH_TO_TEXT) && !defined(API_BUILD)
 	case 'D':
 		return device_path_string(buf, end, ptr, field_width,
 					  precision, flags);
+#endif
+/* Device paths only exist in the EFI context. */
+#if CONFIG_IS_ENABLED(OF_CONTROL) && !defined(API_BUILD)
+	case 'O':
+		if (fmt[1] == 'F')
+			return ofnode_string(buf, end, ptr, field_width,
+					  precision, flags);
+		break;
 #endif
 	case 'a':
 		flags |= SPECIAL | ZEROPAD;
 

-- 
2.51.0

