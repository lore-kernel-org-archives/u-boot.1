Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C7EC87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 09:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7136E83CEA;
	Fri,  8 Aug 2025 11:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YrPJYVHa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80E1483CEA; Fri,  8 Aug 2025 11:34:47 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B6D683BE1
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 11:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-458b49c98a7so12275205e9.1
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 02:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754645685; x=1755250485; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aHZdllu1/8epQ/AqnTK/iH+No+R+8tN+24QaooJoVu8=;
 b=YrPJYVHaEJsS+f8AqLNLw0O++BrXiEdyK5BrT1KpXqiWojp+HjCKGOkjjsnMdXw5nH
 t5+a96dBqELCewt3ggFMjj9SNw7TJn3d4kUoEB3Yw9zes80RYzrRXv5gKLoDit7aSt+S
 vYFmrI31+ZnoA8SMOhi83BPRU7UY1upgyCGsFPt34mxUloHtSwV8BxLAsiMOHGU88mQt
 IxI+zoyBvQSFDSpwWe++3Y9Zb3GD6H8FCHslE9Rtp9O0tZ1X8ZMf/c/RHWg3+dpe4ZKF
 sgI/gteEItdC/7Obl4glxMPP45ztV+vPCmvNe9XTqEBcA39cX7GiJmhJKayxrquEHDlm
 Ha/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754645685; x=1755250485;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aHZdllu1/8epQ/AqnTK/iH+No+R+8tN+24QaooJoVu8=;
 b=SzSUJyW+BE2ECNSTnv9Nx3eolgWsBmge0d9+IePG3CyLglM/JTUdNajgC9mltCR3/3
 jhxltyEBEP6/XbhqmAoaSPKLcqMiiqF7EDGbhCtwaQjV5mb0rlfiKzBTHomN6o/WAFKW
 87NmrT3LYAY6HBdgUXPkKBPyVSlCTcMFwvpRQFsHxKJygLkEsc0NbPD1NUIrXGBNl5H9
 pt7+K74JpXN0+s3xvcWzFsFGC89BX5N4Pi4Cdj1GqsKFJvQOkQrjnI4AlXwxhoUNkE4i
 KydjJSsefAYpFMbhzI3JVexu/up52xV1RT+XDds+532I7Epd6PWhUgdzW9KKd51Tgu40
 XniA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUKIP3ePtkgpxz4UfRBzQT1BktJ1jFyOo+tUFkQ16xP9QzAexBPpYUhn8ZvHIVBai9/46y0hk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7Bm8I0eLKbPbZu1lylVsAm53+d36QMP7sJf6Zfkk7/b3nRozL
 7w9IMwghUlklfdflfms/usrMm/U490UVFDoCPZENvHVLyjYmVbkQLOz+nbCUrDXtnlE=
X-Gm-Gg: ASbGncuLpyX1PKxPqMMi5Ae5TJCtMJ/RO7q0Jl99zyeRGJ778p4+pJOXInDA4l2xVqU
 414OfYcUVcDReF1N+IAisYT2rnT8nXUF/Nf75BsyATZRFfJFe0e/bWdrcuupoSAVgm12HVHCpv3
 Xbu14e3t3pHtTWS+LKdPvTunEOwIEyoHvojEJ7ZvWuEXTxO/UODKp8TN3Z5iLz+UFbcm6cBId/q
 g11GYPgtDFx3jbdCjAwHPnXj1ayLL6WptXtw2VkZecf8AaP2s4vOnC30ZPPMibPZ4MQPPRB8WAj
 3o2VvPgcnUVtYEX33+QtTq1pSCsUklK0xuwigFR1aJYIlkt/6ReStuqLfe2OLwU6tAe+EFHYI2U
 x745fyneIO0QPJ3KTCvzvw7mM9qY2JatRIAaxyjtZsRg8ylX8uEY=
X-Google-Smtp-Source: AGHT+IE25h1Iy5OfzdsuVUh/G3b7rPeooK4yjmI/zyR/2PgT7WVdJkzPQ5pePNsQsHqInUB1nkCD/A==
X-Received: by 2002:a05:600c:b8d:b0:458:c094:8ba5 with SMTP id
 5b1f17b1804b1-459f4f3e76emr18961695e9.12.1754645684541; 
 Fri, 08 Aug 2025 02:34:44 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:e7fc:9a8d:4024:d186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e6867193sm124063005e9.6.2025.08.08.02.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 02:34:44 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 08 Aug 2025 10:34:43 +0100
Subject: [PATCH] pwm: meson: Stop premature exit from for loop
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-pwm_meson-v1-1-cddb7e5f76bd@linaro.org>
X-B4-Tracking: v=1; b=H4sIALLElWgC/x2N0QrCMBAEf6Xcs4EYGq3+iohc2tXeQ9JyV1Qo/
 XdTH4edZVYyqMDo2qykeIvJVCocDw31I5cXnAyVKfgQfec7N3/yI8Om4k4xthech9ByouonNri
 kXPpxf2S2BboPs+Ip33/kdt+2H6Q4V850AAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

In meson_pwm_probe the for loop attempts to get the name of a clock but
the following if..else statements only perform useful work if -ENODATA
is returned from clk_get_by_name. If clk_get_by_name simply succeeds
then this results in a premature exit from the for loop and the
following code can never be reached. Make the else clause only apply for
an error return from clk_get_by_name.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/pwm/pwm-meson.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index c2597d8b669..caa7af085fa 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -359,8 +359,9 @@ static int meson_pwm_probe(struct udevice *dev)
 
 			/* We have our source clock, do not alter HW clock mux */
 			continue;
-		} else
+		} else if (err) {
 			return err;
+		}
 
 		/* Get id in list */
 		for (p = 0 ; p < data->num_parents ; ++p) {

---
base-commit: 123cd77122a13288e1552b5d9b7c22a6f19e2e02
change-id: 20250808-pwm_meson-65549e7d24ab

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

