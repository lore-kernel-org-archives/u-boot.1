Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B95CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 10:55:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C51B83655;
	Mon,  6 Oct 2025 12:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AGkdYqYd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B34C883695; Mon,  6 Oct 2025 12:55:00 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 952B0835D0
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 12:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so30230735e9.1
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 03:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759748098; x=1760352898; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XYu/Q/XinCQ/0h5Tc/XajlctkwT3+C39qfnDeK1J0pY=;
 b=AGkdYqYd7zxY9W11I2TfCZUkWp3XZGMZoXhuurijjH2tyogjWrjlkxj+WE5qrwJ6Sb
 GyBmUMyaejli/kEjMhKWDw/n27IFO61qvb66EJIPophj5ZEoQuVl4XvRcGNTfDpNddeW
 JhZyOyh9p1QjzWgOnQxEg5l04lHtgOV6TeVVjik5WBAyHzstAhyuahPfccUCRO6FF/CK
 Lkl0WDZkw2AlbVj3Etzz2v5Xd9O2j1xxELID1p604C6T3e7vgo0EVfYMO4omM9Vc//W2
 7t65diXAP9GmQLJy6DogTGiWM7tpn+CmXjztgsYDld2Go3qB6ll4tPfmpR3UJDYtRmf5
 LM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759748098; x=1760352898;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XYu/Q/XinCQ/0h5Tc/XajlctkwT3+C39qfnDeK1J0pY=;
 b=Rd1mU77hvfYVHOw7CiJgs40Kbz72kmM0sdYuxV5zzfbyVidtYOh0hH5KvpcCcQLvh3
 LgJuYpsWRVbrvTqLpLNgwbggV60xcF7YLMnrZJnU1VOWM7CliHIG5QSQqALyxYxGhVyP
 wYCXZ0JL0QqdqMwjrtYfnNrgoninP3xZSdiO7JLbDKxAaazk2tVFFew7nuPsYE+b0vQU
 0Ws2uDVmK788EbI709xG23x4rJUeen4uB6Ev5btNu8fYHEzpECksayX3GvnolBINSaKc
 aE0ky5flMEkMnvDh8u6OJn9eYXVdrJBPkC7D0V8wY6iT+bGicwAfv2sDhUZ5YL3tdpRJ
 CsdA==
X-Gm-Message-State: AOJu0YyDpyLeQB2yr7DJojYXCtnISgtUVD8hQRnBJEBNZur05vh/XiKp
 sZXVXt0Ea1k9RHAkDoE5pez3hxKMQ9QXoZfjJgJc481LBUwChcZKKlKcfFW8zSwPiNQ=
X-Gm-Gg: ASbGncugQ9d7KZ04/Q/b6ziI8N9F1BIBvmw7OuIBH5ZBo5AQluogH/reRHpdugA1sWR
 0VVDABn+mdYEUVPcnXroHrIw3b9PlBc25bY/zVVkvWNc9vhk0QutA3eyI+UxRh7GQFqchMD4c5f
 OAZ7Q9sC4WIFjLvGyGBcdiV3jkaQE0tQATPf5g9uifAeZi0S10eIfPTaGxXejkWKb2XdKkUmbnF
 YtUGltCmpsRa/X9A8GSRhHLHqIRUdU4kyteYzgBygzL+aAkS7O3NFFh34OxiXh3eBDhOxPbnqgk
 gEZDdKYhfee0AqVkjmnqZZ4XF6f8Npa4oysVrr27sZ6vh6CpvEfxXXA8LUqtwdckVIDGb8hqq/w
 1kNfoplUsqC4J3puWTOGiqZubRaSXyuKvQ8DpeQhiHqvMi+u/RCbx+EjeTI7Eb36Dg0FzReN8vG
 lU2A==
X-Google-Smtp-Source: AGHT+IGN+pczvt2YgWbFjh9KMK0PxwKySkVhW+vxgF48ZEq2w4Kmp/pLBZhlXfDS1ST8l0h/ZNzC6w==
X-Received: by 2002:a05:600c:8286:b0:46e:42fa:ffce with SMTP id
 5b1f17b1804b1-46e710ffbb6mr66364115e9.2.1759748097977; 
 Mon, 06 Oct 2025 03:54:57 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:d8c:ebdc:373e:b4a0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f4cc3sm20330061f8f.55.2025.10.06.03.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 03:54:57 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 06 Oct 2025 11:54:56 +0100
Subject: [PATCH] test: Remove not needed null check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-test_main-v1-1-51954a6e9ba6@linaro.org>
X-B4-Tracking: v=1; b=H4sIAP+f42gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwMz3ZLU4pL43MTMPF0Li6TEpNQ0S1Njg0QloPqCotS0zAqwWdGxtbU
 AgH4JPlsAAAA=
X-Change-ID: 20251006-test_main-88babef9530a
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

In ut_report() there is a null check for stats but stats was already
dereferenced on the line before and is again dereferenced later in the
same function. Also the two places where ut_report() is called from will
have initialised the parameter so there is no chance that stats will be
null. So to prevent static analysis complaining of a use before check
just remove the check.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 test/test-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/test-main.c b/test/test-main.c
index cabc736a524eefacba44cf6fb31bd481f50938c6..3254325e8b153de465e8aab65930220228f2aae6 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -687,7 +687,7 @@ void ut_report(struct ut_stats *stats, int run_count)
 	else
 		printf("Tests");
 	printf(" run: %d, ", stats->test_count);
-	if (stats && stats->test_count) {
+	if (stats->test_count) {
 		ulong dur = stats->duration_ms;
 
 		printf("%ld ms, average: %ld ms, ", dur,

---
base-commit: c280c4f7e52f08255f491783b3143a3be1fc08b0
change-id: 20251006-test_main-88babef9530a

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

