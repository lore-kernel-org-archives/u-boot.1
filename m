Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26ED7CD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65598846AA;
	Thu, 28 May 2026 19:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eqW4yutI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 356358469D; Thu, 28 May 2026 19:11:04 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AEC58341A
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e666292eb8so1533803a34.3
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988260; x=1780593060; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IxOKydC3HaK3zYXlSU2WNvY45eXxjc0aURnypr8JLnA=;
 b=eqW4yutIJ1aFYYSSNaGi/r6YEcG1LgjkTk+QWXgm8SlOwloXKivWNe7MY9pkzHNb+/
 0/u8WJpwK49kxPHOWLt7eZG3Z4MbuHoS1BNDoXROSoeWdrFMaoodSnqwQuVTuoDZVubj
 e1ZeSaK04cig0uPrbVSvnmQHD1dOuDRWzpFEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988260; x=1780593060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IxOKydC3HaK3zYXlSU2WNvY45eXxjc0aURnypr8JLnA=;
 b=ILiRVC//T1MoL+OFYs1tvtT7bnL4OH1BDO4u9WUzhZe0bADAvtCzST8WKPu+A40mxN
 iBHLprj7/tyRp8z6z7aR2Jgydizg0MrZxzYnPG3OmhG5qeBPAga/1AUnXOotWG58E7ZV
 y7WrOjYWBaYKk4kGRKb00heaKOaezLpOJJ7n06EtQ++o9CzbUJUzKrcH5Q9M0S6sJzVu
 jF/uflwvJY3fpSTgESjBqHjeCqeHykfFS55UIXVCyYr9hkBAwGEHiYP9yoQ5ajq0FoWY
 0kF2DibppoimgtPFmfZRN6kSyQxD09B8g3oko4VE/x1JOI0Eae2IoBeD8pwucgvv8mUv
 sRyg==
X-Gm-Message-State: AOJu0Ywp+XfoZA4Tt6So6YpjnkUoYsbyBPPII35t2qd73M49JV2+JhmG
 Ze7TuauLtw0/TuZ/xaMamQ6xVCpqbQQT5UAkcl83f8hTRQndHA+/F1OVxLlG9+7SwVQqd9Vs9us
 xY7vOXv1DB8w=
X-Gm-Gg: Acq92OHA/FMzCp97o6K8Gd79EoqheIAvIG9YKCWKdpVnD6+i/b41jlTp+fLD/hd9+4f
 PCXUzUvEObg/qs8Tq9enfyIStyRJb8HMXdLuDizQ6HZoCV+Hn8a3ETgWA5og/VEkG/W8YfdxAVg
 U/PtzrZTfJFyQLohAIO9ycXTc5gLlTA3fyHxpf1qOROzhKofIft8YDPjiMqFO5wavCrhqtu0ugt
 zYLslpQOGjis3vgnfwvOsKW0nfRJrnn6aVCg/eWa04fjELd0jQtjwI0rarxNc/UXpEIlL3WEZSg
 GOoz3bErB63X95UQrym1IPJFbENXpHkl1fsSEzHj3lYwaV2wUth2LGAvv8RIT77U9bup+Die1Sc
 MwrFjKbKOPu/hdE2nQF1NTB8cQ6wZUGqLJ7CI7sYcHjTpxhayHc6nAS9dmY5sr+LB95SgR5SBfz
 VCJaJMDuJZkDPb3R9iKJDjOY6lvkT+4LTo9Uc0d60=
X-Received: by 2002:a05:6830:6501:b0:7de:84b5:88e3 with SMTP id
 46e09a7af769-7e5feda4061mr17540188a34.8.1779988260289; 
 Thu, 28 May 2026 10:11:00 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:10:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ronald Wahl <ronald.wahl@legrand.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 02/22] spl: Allow VBE to handle xPL size
Date: Thu, 28 May 2026 11:10:09 -0600
Message-ID: <20260528171043.910264-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When VBE is in use, the size of each phase is obtained by reading it
from a FIT. Avoid using binman symbols unless necessary, i.e. in TPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 722b18c98ed..14fc5644663 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -205,6 +205,8 @@ ulong spl_get_image_size(void)
 #ifdef CONFIG_VPL
 	if (xpl_next_phase() == PHASE_VPL)
 		return binman_sym(ulong, u_boot_vpl_any, size);
+
+	return 0;	/* VBE handles this */
 #endif
 	return xpl_next_phase() == PHASE_SPL ?
 		binman_sym(ulong, u_boot_spl_any, size) :
-- 
2.43.0

