Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFDE606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fMjqhsXa;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ajixdejp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC3C980CA6;
	Wed,  4 Nov 2026 12:49:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5IqO1gtvl2gu; Wed,  4 Nov 2026 12:49:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0033380C53
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793796545;
	b=ODe7yM/EqcjbYWgXfnEBmgGOt6+yhgox9kvg3nrnaPqVdPeCQ3vbgeiHu05WAF0Tvk2d
	 eKAE3uj0Jobyda1hiQYdlgfWkRiX008KON/6K503enSmL0VGLCvhlfKnXiJd0dCFz9MSa
	 fkNgyd8QOXWfxC0kDH1YfMXvFxYXrK8t1dz9OnRF+l9XJ4uOg+nEwuMaIeWybDoNdVBJm
	 jlgc19Hav93Z10N6jFgrCMTEGFEC6KpN1vQY5hlfaos1R+CKO9AcjZ3nStQwKd3zHs15N
	 g3XtZjeefnmPHpOV02GcI049dnpTIXemmCPPa6acdRNGaQfotnFdIp2OZxKHXC71dPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796545;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OQw/PqtR56e4Z7mxt8ouc0Wkglrfhb6NnWunFIQD2Ow=;
	b=TDF6930bWcKHL0ukSkB8lQV/hQamAw+oQhBqnojm7/BjHFlj0eZ+z7i5HwlDMqJ66qY3
	 R41hPBIQvFMPo51SAs0hcXZ/LaNGyd1OWTq/F8PkD2upCg/u6XjDhPKUWQ6f9Sgwz7LTQ
	 TjgIwM1SUcppXSw4eqAklDQVfnfAYycRnUyswh9s700+6Ti084fTIkcR2YJaGFRHaNo37
	 m1haircQjbzLGO4g6qHlRSk/moS/k07DekaGLUmkF0Wg+yJwGa39Go2vI9Dv/ICBXftdP
	 bP1Lk9vDM+ABAC/gRXoncNQd6RYAyW71DR0VK1qRHZfb+XIWAx75dpP0zQzDiq2p/qg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793796545;
	bh=OQw/PqtR56e4Z7mxt8ouc0Wkglrfhb6NnWunFIQD2Ow=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fMjqhsXawXI9yPFZ0XUi0F3rHz9TC86M1Nqr2URj2+CCBrbgZ/85VzBpaWUYvMmyG
	 mjYMqXOviQqRh6gby/nQFJ8aYaEv6ZTnN18WqiwoOt18rDjA640AqPRYSHNQnpHXNj
	 DX9uJSTPRLNwrsyynKiEP5Q7uN3vTrbiIqXpVrP0hVtijzGvcgC3H5TAX1y5wxRtj1
	 16JaIN0kROzrKiVYZDuHZJ11fxPsos7WCZ/d0y1CBFGbAmUTtl9Bk6Brv/2XfCJ02D
	 ijptZYTgrawmQThYCfjTWpz4M6c43gBEOy+RkxO0MqtXuXoN5vtz5fPc11aFkVWXw6
	 hfx+W3KNADuag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0033380C53;
	Wed,  4 Nov 2026 12:49:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 878A634D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:49:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6CC924040C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:49:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AxfMTqAjTGRS for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:49:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 71DEF402D5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793796542;
 b=c8pyLWuGGu8wkm5BfByJ5vzFnkJpIWCHRaDNGRrFUpmyYw3ff4PuiKzFQOvgau6gUJwO
 QsT/4SAdi6ljMMFhsk7mFtkcwqKA0SphXWe+LMp8hEVg2zdm4djnRK0ONxrU5H03rNQPT
 58V4ENgLv2oyaWvIRch7r2dIQEHiE4o3s57jbbjmAuHILv44bQKe7LYinW7q65hX2LKbc
 rpls0NtLlWWMqgQWaRkpANAZU1Lwd7L09oAcK0ElbLBvlGNhEI67yIox0U4i3jEPbRPzB
 8JRGXZQpZ3XaGd1ehGx8/bOhnqxYL/rz2WULQTJsNNbs12tI9CZG2OE36kqqAgcK6DQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793796542;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=OQw/PqtR56e4Z7mxt8ouc0Wkglrfhb6NnWunFIQD2Ow=;
 b=ElJ48SljFBkEKZMJlUG/+iySq/XuGhZEODGmoKsY0MJzBv4erWaWOfGeoz+G4a4T34Ei
 i45u4/OB7iRppYG6yGXTEEsGOPgMEY3wU4oX9kAGGI+ZpJdh7Z5XbQOuHgsP3Ps/Bvxte
 6X5zQc+VI8w8KXRS9avprtUTayDic2l7OaP6zilAL+R9UYSanun/DqKqQ99lw81UOQSMK
 dFjXooFBbDA9/Om2yVZS3ubu8wDW1gd7QQUu3dQcm7BGKTQS+wFOSMEyI8ZAkp+kVawqK
 0LQX6SY4MUjkO3KUliWPyOZNjVKN0Y3SV4grVw7zCOrjlzeb8mfVTBACVb3xbUBdTGQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ajixdejp; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ajixdejp
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 71DEF402D5
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:49:00 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so6438005e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 04:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793796539; x=1794401339;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OQw/PqtR56e4Z7mxt8ouc0Wkglrfhb6NnWunFIQD2Ow=;
 b=ajixdejpqTUcpp1mL0njwpbmPlUR6pegozrybZyMAX2jIj8luOEf/lk0E7EKdK/hSX
 JvJPWmobU6y06bvsJRE6+2YpptO9x+MIjRpsmMP4XSPoCXymt7QfDE/QWCk5uU8dBgkS
 KeOjZW3Kv45uNUa5khOgMpT4HhyYQeIoy/QgxMHd/8A+Sksb7ISMjENXdV8V0hCMiKhZ
 F8uGzbKickHh7LCRa8nt3y0MqUnt2M22WjWe5uCiz+8lxUO4D999TzOHkVxTBUXrzePm
 HUPahgjPwbdTq3PqCSivZgzj9qKIDo62xhRZJuEsTKZQ8KlA4oMJoK9z2t2+TfTpnfJY
 S92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796539; x=1794401339;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OQw/PqtR56e4Z7mxt8ouc0Wkglrfhb6NnWunFIQD2Ow=;
 b=2HDhuuhnEQkFoRokmPu0PIKVak9vM0qZ5Wbbuk/iee4P2Ne8SO1WVpq6V92q/XZMgG
 7nF7ua9RGiWwakHCCxMxxEcNINrO7SRTUtMXk/ZvpHBbAJL2xX9HsM2Jr9lo8f4DcJZM
 Vww83vRQTD8nfnCpsrvF/PTcsQNaXBiDQBUsh+Ef815XWkl4XK3beNG96+J1TQeVd0FV
 dJ0DVAoQInZrlXj1l7S9asGaZ8m3T5ggkyAB9OSnq7KIvg7v6leNeuT4zmxuIKGW9Hph
 ueLhzss3k+RAM0m5n2msGtp43oHPk4m0fnv4opJzsUPxIvnmT/GmHLN6l4ZWawMg60Sr
 HaLA==
X-Gm-Message-State: APuU4Z/a58SbbO7JNPUps4aM0+vH15I2S252OUOXOz/2UCBKpraDj6GT
 My3hNDKMvIrep0r6KSA3fg9CJeucHrS4V6/83pOsDr7WEBf4McSl68/9a0hbJR3Omm9JZX/oI08
 dKXOB
X-Gm-Gg: AYBFou0IXjiUVd5lNnqa6ilrkwDOnCAQLmWPpBvdFtmQd+jq5eNQed/SinoilCs7OOp
 27Tbc/BEMAAIpbxaj9mnFFEj89zLe40IEALgWVLp5GxVP+tubdrlAQqIhn6qt8tNgOnVxQXbZqc
 oQwfeLJnqxQxM+6mlCoek/qfKtfNMEYdP3JEp0+Dpf5w+SmS8RWAUW9G/NfjaT33j0FeNsoHFbU
 BKymo4bCLRvyzEZSUFoz6zCHXDW9E1ykGtDrZW3k2T72fpm6Lkuc3VE2fcaYxj/OGhF+k2u/2hN
 7XJewUmoO1JTYUyew+0s1XbCrHaAU1IOx1a4vSHVMJYAbpVhhVW4sHmrccrPv4QSAt5luwzOazu
 WZ19V+nPbNym48YjZb/dZ6Y3DO1YF8bEoMbEQG/Eb7LXDWSpqW6JgkDy2avQZW4mkuZyyb6GFY+
 mA7yOX+pyRMLaC5NTDEGoVM8vZAZ0f7JJoqRWqjTPVIo693ChDLvuiJIJ2NqNEDlsn8sns2pqV5
 0Pf3M4XZl8NfRzqqAzPEt76mupCCqlq4MdoH3JSn1D40rPvCy64Sj9ED2TQLuSQTl7Dk1tAyBYe
 y5U8sPxWjj4kot8WFFsb+FGhVKCGnikmJ2StV/FQS/0uNJCj/HA=
X-Received: by 2002:a05:600c:4f8b:b0:4a3:5a98:c279 with SMTP id
 5b1f17b1804b1-4ac17ffb07cmr358584625e9.8.1793796538701; 
 Wed, 04 Nov 2026 04:48:58 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab010a66sm187260275e9.13.2026.11.04.04.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:48:58 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Wed, 04 Nov 2026 13:48:51 +0100
Subject: [PATCH] MAINTAINERS: android: add myself as a reviewer
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-maintainers-android-reviewer-v1-1-a239c7926351@baylibre.com>
X-B4-Tracking: v=1; b=H4sIALIp62oC/yXMwQ6CMBCE4Vche3aTliCCr2I4VDromljMLgoJ4
 d0tepjDd5h/JYMKjM7FSoqPmIwpwx8K6u8h3cASs6l0Ze29q/gZJE15UOOQoo4SeT9ihrJrQnu
 qhmPT+ppy4qUYZPnlL93f9r4+0E97k7btCwrnNSiAAAAA
X-Change-ID: 20261104-maintainers-android-reviewer-08a974f58916
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793796537; l=1771;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=Jy4Ywp5uBCPfcArXJKYfkx9nocW11zWdzdc+VzLz1pM=;
 b=7p1+jI3NWcNHczXrsfufWmpNbXdD5xN2W700oQgnr48udynwts0c6yuXjDAcqj3M41XyNk3cw
 JgASm0wHE9HD5w7JFcw98xHlE7lE0gHjXj4qbXfS39UzGNLm7X03Yzk
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I review Android boot, AVB and fastboot patches on the list, so add
myself as a reviewer for these entries to get Cc'ed on them.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ae3e9819d450..3909a2896c7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -102,6 +102,7 @@ ANDROID AB
 M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
 R:	Igor Opaniuk <igor.opaniuk@gmail.com>
 R:	Sam Protsenko <semen.protsenko@linaro.org>
+R:	Guillaume La Roque <glaroque@baylibre.com>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
 F:	boot/android_ab.c
@@ -112,6 +113,7 @@ F:	test/py/tests/test_android/test_ab.py
 ANDROID AVB
 M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
 R:	Igor Opaniuk <igor.opaniuk@gmail.com>
+R:	Guillaume La Roque <glaroque@baylibre.com>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
 F:	cmd/avb.c
@@ -851,6 +853,7 @@ F:	test/boot/
 
 BOOTMETH_ANDROID
 M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
+R:	Guillaume La Roque <glaroque@baylibre.com>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
 F:	boot/bootmeth_android.c
@@ -1037,6 +1040,7 @@ F:	include/extension_board.h
 
 FASTBOOT
 M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
+R:	Guillaume La Roque <glaroque@baylibre.com>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
 F:	cmd/fastboot.c

---
base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
change-id: 20261104-maintainers-android-reviewer-08a974f58916

Best regards,
--  
Guillaume La Roque <glaroque@baylibre.com>

