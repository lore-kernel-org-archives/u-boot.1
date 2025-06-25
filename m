Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20194C7EE30
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 11:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A8E082977;
	Wed, 25 Jun 2025 13:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xgvb0A21";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 413A682CBC; Wed, 25 Jun 2025 13:15:59 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7343C803CC
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 13:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45363645a8eso11888465e9.1
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 04:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750850156; x=1751454956; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mVVdMWIZpawabRPyJm4hMAruduoQzak93SCx41MHFv8=;
 b=Xgvb0A21KIW3gbZi1yreQdpz5ug1DGXQFZrW1jLhbLg3koa8CnIqQtUuDTc0h6cDaO
 Ox6OfgJushQX4KL2enmC5QsMtzNaR8sRwlBrLKTboqEoMzkhYKlAX588nQmMYL2ShgjU
 O6xmWjzzHoOSkIp/YF9HmarSSTLzvhYEC3yOHLh14/ORHLt9uezaceXGlZvjbdYnc+vi
 ILuCvNxBbk139O3j5yKMsS/lf73M8hnAXE6JI+Wdgdj+YLzdRgqTYww5gIjCbJRTBLcn
 3FygBRFUj97BnW8Ejjzg9XekRcNxV2t6BWulW75MmO7CLIilFJo45fFSoSvge76SV7Wj
 5+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750850156; x=1751454956;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mVVdMWIZpawabRPyJm4hMAruduoQzak93SCx41MHFv8=;
 b=EgWmvRRCl/muJGJxD2iAbiJ40CmZsc3zp2gBMF974Od6PwOku/1UJWU7QUoTlxYpVF
 HrU2ppS4ZeEtBFxfUEamVw2jJkm9tlmeYlHctNnBPSmK6Rct7t3svEoBomJCW5o1p6N/
 lRwfL0C26NQVFcXW8rqhat+02LOK2ngfq3/EjCjWfTzjd0p5ykw3sREWBWh+JfJglWka
 5MgFh6Qe/SpMEpuwHpHQUGEO0U5Y6FsM0b9CitNzXQp1Sak6H+3RCwF3STJ9WAlrBXir
 9xe12FVXB4CSc3F8pKFU9DHaozrdAoES/xgNOg1p0lSkS5xaQfLeM2vFz93delVgKx2s
 b3DA==
X-Gm-Message-State: AOJu0YzlSU3WfDddkMaXLww3BC5T8WauKcwUxpjIeWq3rxOAu0Pt4iUQ
 ThY/fX3lbAEWOi7Mq5QVhMEuVmjpQy+c+jVHQyxinudI7vcIMrSbG8auohEMTKUXKbQ=
X-Gm-Gg: ASbGncuIBQgNL9GfhDJg4bG78HDXAz6fWb7zfSEIa0jJLGYJISAVDLMiiP2MN48RaJR
 mWk0Ibhz/qjiJEJOB+cNi+6rMfz8DGUicTTPNIBhnm5SMQu/WQUNdHpKi/WOu493ukdrPWOdIgr
 4vO+v1nl/E2srREqQERni+om1313FPioXr8oT8WX9LBxD3NBCY5xCT0GHMNmVZPunfhQfyLGJmN
 Eax7xCwq/4DJJ98matLPjmOZXs/igeB3QryjnaCg7NckGqL+KJBUuY45o1fjglldarkaOOEqfWo
 FyuraHBLFmXNIH050yglI5+gnWkaedYTPqKn3+SGOBiF53KMetJyMjeyb810xQVhOjhHNrKHJ2R
 x5lzbNfsRqY/nf7vbL3W/1a4L
X-Google-Smtp-Source: AGHT+IG76SHE6qyiOWu4wkHTSncHt9/lZyIvr6NJjyVOc1UAJov+wdJGQYl5kJkszAw2u25cdvorXA==
X-Received: by 2002:a05:600c:4f85:b0:453:6150:de50 with SMTP id
 5b1f17b1804b1-45381b0589amr22430425e9.28.1750850155874; 
 Wed, 25 Jun 2025 04:15:55 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:8cc3:8d71:1fb:3fe5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45382373c86sm17261725e9.33.2025.06.25.04.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 04:15:55 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 25 Jun 2025 12:15:53 +0100
Subject: [PATCH] cmd: abootimg: Prevent use of unintialised variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-abootimg_fix-v1-1-ce1645ac9879@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGjaW2gC/x2NQQqEMAxFryJZT6FWWmSuMsiQ1qhZ2EoiIoh3n
 zrLx/uPf4GSMCm8mwuEDlYuuUL7aiAtmGcyPFYGZ523wXmDsZSd1/k78Wl8G6wdU9/5gFCTiEo
 mCua0PNGKupM8YhOq+//PZ7jvH+DLf5N3AAAA
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Safae Ouajih <souajih@baylibre.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

vhdr can be used when not initialised so detect this condition
and exit early to prevent the problem.

This issue was found with Smatch.

Fixes: 636da2039aea (android: boot: support boot image header version 3 and 4)
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 cmd/abootimg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index ae7a1a7c83b..6065be9de6a 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -100,16 +100,16 @@ static int abootimg_get_dtb_load_addr(int argc, char *const argv[])
 	hdr = map_sysmem(abootimg_addr(), sizeof(*hdr));
 	if (get_avendor_bootimg_addr() != -1)
 		vhdr = map_sysmem(get_avendor_bootimg_addr(), sizeof(*vhdr));
+	else
+		return CMD_RET_FAILURE;
 
 	if (!android_image_get_data(hdr, vhdr, &img_data)) {
-		if (get_avendor_bootimg_addr() != -1)
-			unmap_sysmem(vhdr);
+		unmap_sysmem(vhdr);
 		unmap_sysmem(hdr);
 		return CMD_RET_FAILURE;
 	}
 
-	if (get_avendor_bootimg_addr() != -1)
-		unmap_sysmem(vhdr);
+	unmap_sysmem(vhdr);
 	unmap_sysmem(hdr);
 
 	if (img_data.header_version < 2) {

---
base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
change-id: 20250625-abootimg_fix-51600dc8356a

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

