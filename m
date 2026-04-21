Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F979F8FA80
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 14:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41456842C7;
	Tue, 21 Apr 2026 16:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="EnLtEic8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A332B83693; Tue, 21 Apr 2026 16:10:24 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82E99840A9
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6949192b840so603834eaf.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776780621; x=1777385421;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8t6/uBcnyhYYuN4I8RfFgQI6/SJbTzJRxYhiLzZ4fOc=;
 b=EnLtEic8XEahCKe9M2wB/R3W4kSyZ13ppq39R78vatC/0Iivs5BXA6U427SmO/wFY+
 7RGx9VLTziMwytUg6MmyKaMzSdn5rf1uphR3f5iRhMK7COR/D6BcvkJ+lmxvjOXTb2/5
 8AQJVs9YHpsXMXpN0mSRtofaFghraafWmU4l1dPmYhwEkGvcRaxwvE3Isao39U+t99ez
 xNWXaeIOMY+xOWKcrIcpgsGiIsTTB1R9WeeIBDF8fOgYbhBk02mYiWwVrGB3PtihhmDZ
 nas+tOKw0hkqhXJzJJJ+I7vMdYHEhu2323bBFdEGSiL29nHRJ62ruu0TBtDkdREBry6k
 nKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776780621; x=1777385421;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8t6/uBcnyhYYuN4I8RfFgQI6/SJbTzJRxYhiLzZ4fOc=;
 b=khRT/flGipOTHm1Isb2Oqh3134Z5k/2yDe8zoA305OLxoy9fSSHBGkmfS7krl8mXEe
 uruQgy6X05WMaOxK+0tw3K8xnLu0P/CHXMKQAg1ker0raNNLNndXSloE3dOGFv+Nwm/X
 4FalZecXW4oh1K4VGARUou5tKMwOAHTsoNi4U57LVKUYcgw4vRqgkbsqPREf47LysfhC
 A6l7O20PW92r1iPvnWLIdQeGU4X5011nRN0PYVDOC+Cin+goSvGtOyZHfkAYR1WDJE8m
 zPFyvmvX3u1oihU/Fbh7X78Aots9Sj7viJ8s0du3YiCsFBSmOTJowJ8SWb6rE+oiDsIG
 ivHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9FjjuqUrulw4YoVWDsMe+UfNhSBCc73dObR4CzpJnmg4VB8NR60lnhitkkza2fNyjGg3FCF40=@lists.denx.de
X-Gm-Message-State: AOJu0YzkfFCBRDsKPPmJIjEUAdxzhYd9rlJOvRf6nJGm0LqImeePhgYF
 mzauw1M3BZEgerWXcWekO258wYeEh7cCXn/Yp4QL3aY5Ukl9JSR01PqJS7ZQwwHalcY=
X-Gm-Gg: AeBDiesMMTHKmD5baygp+cM7GZjn0U4sr8YpU03HQJ+3RFVzB4jhMXbprCzt+nqu0jk
 kb/XgXSxMZuQWP0+4HjljdqhrlzO4rtH9ovrWZK/Vu7JxfBJHebMlHEamZJlUrJiXE4tejWtm0H
 0U2Kezbg2ah/2lIo6YMAVg5EpXIKZUOpAGduUdcBUwnXGgwkGnY4d40aQ2g5/NImsAYw/xnb6F/
 w6Ip18iK7Lr26vLPg8EFTzEt+yl+Mu754OSRdFUx+6D5BXUIxttakQgo/BhoT5Vj1g7KJ+RpgOG
 A6j0Zmbq6F11IV5HpAdLAnGrlbGvLUo9bg/Y72vgKYeVup40SEASW2+saVwf5TGrLquiTzM0fhk
 9cBv7BAWgOBGu4TWgQnhT33urmB1rIfGy1oFkMTpBbcDIR6WKALteeSMvCHWw2i6pyaXApJRbo5
 O8a/2+LSn/TAT9FGn//SYHsK4CH5Zh/WSI7/E3sAY=
X-Received: by 2002:a05:6820:2019:b0:694:974f:21d1 with SMTP id
 006d021491bc7-694974f33d9mr1875106eaf.20.1776780621184; 
 Tue, 21 Apr 2026 07:10:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:dc5a:64e5:1cd3:94d5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-694984114f5sm1248515eaf.7.2026.04.21.07.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:10:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 21 Apr 2026 09:09:37 -0500
Subject: [PATCH 4/5] configs: mediatek: mt8395_genio_1200_evk: remove
 CONFIG_IDENT_STRING
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-mtk-configs-remove-ident-string-v1-4-66d5fc3d67be@baylibre.com>
References: <20260421-mtk-configs-remove-ident-string-v1-0-66d5fc3d67be@baylibre.com>
In-Reply-To: <20260421-mtk-configs-remove-ident-string-v1-0-66d5fc3d67be@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=827; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=03E7f7D5IiSqQeQUC1ekalL+zQQ86c5JYq1Pv2Wg+Fk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp54U7K5ji4mMqsLlMaYAcCg8r94ONb0g8laPVJ
 iCml2IrdnuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaeeFOxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AppIH/RM0ru/nNSUu+SLkv4bv4hGZdt/XGQYXxORyMCb
 za23DSEQAEteFgn1f0n9ydAjLwpUPoQZxLcCBGa6oLcBdiU7ghRGLRl7Xd++VD4E2ZihOnSM0fb
 uSrqKTLm8QNTJ+WjeZefGy71XGG9a+jMJozbM5Sj5Z/snDh8ez32Z6aQOKpSEMxyj5qepJfkKmZ
 OOcJgfQrKS3FcQHJIMR2dVao6dBQKcOn+dcZKV4gA2cY14AKQQzW6I23zs2X/wa466jWdMRWWJc
 9VObpfmRpv5Lhtfm+qh4xF/MHtyNeU/1gc+GnTXYKyqc2nbT3kgr1ZfAAx7KNCmY453wp0RAnAv
 +O9M=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Remove CONFIG_IDENT_STRING from the mt8395_genio_1200_evk defconfig.
This makes it consistent with other mediatek defconfigs and frees the
option for use by downstream users. This only affects the version string
printed by U-Boot, so it doesn't have any functional impact.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8395_genio_1200_evk_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/mt8395_genio_1200_evk_defconfig b/configs/mt8395_genio_1200_evk_defconfig
index 47c10757c52..e2e5480f55c 100644
--- a/configs/mt8395_genio_1200_evk_defconfig
+++ b/configs/mt8395_genio_1200_evk_defconfig
@@ -1,4 +1,3 @@
 #include <configs/mt8195.config>
 
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8395-genio-1200-evk"
-CONFIG_IDENT_STRING="mt8395-genio-1200-evk"

-- 
2.43.0

