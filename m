Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7D9CD13DE
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 16:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C28888D8B;
	Sat, 31 Aug 2024 18:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X3oy8te8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC6F688D83; Sat, 31 Aug 2024 18:48:58 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C1188D6A
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 18:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42bac9469e8so23496625e9.3
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 09:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725122936; x=1725727736; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LrvnTQsxvFwoXqsZC/SfNcIrTWnVQoEbBzFM3YuH1Hg=;
 b=X3oy8te8ieOnLB/59ZDmTM2+gmIJJVfa1Wc4LKX7ZDgIcNaLROGY85eOZhbr5vihel
 OtZkUFakjepjftkIgzggT0H4gVNhgFsbnO3aVlckXtyiHljkTtIqULhvl3FRdXBmR8Mn
 hm1WzKmmw/wOz5vdKNhXR9CBjYDbbkfG18hBd6pa+tH/PalyfJ/7frUXzq/Bi5yIqhCX
 /TQSDT3FC363cslYurGz+saX19jii/asejGy/TaRs5zg7WPgYUEhdSDeFyF2lBYZTRBF
 4sO3bHuAkU9cHcFPi2NEflx1RRmhWarNI5dN2kBf72DWWD92uhsizO358jeaQUJXDVvT
 Wp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725122936; x=1725727736;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LrvnTQsxvFwoXqsZC/SfNcIrTWnVQoEbBzFM3YuH1Hg=;
 b=cGDtT62clwrYko53dzv+fS7cgdNFSArRRcXT95sgV8b+lk5hNhZdbb2OXOTebSAuMW
 nrzwxvjsGX537IFZB6eSgzbI2ac6jgXf+UTGN0YvmevsDo5MFw7udy2m3l+JGu2d0ctw
 jP1fyVpPFKqrySnx1B9GJC9Otp6xLrX+W1FrOfoRgn9CEvrIxR58bAuwi5wk0oUTq4Ym
 dJ3X0+EO9hK1M0+A5ybenvBzBfn87jzWELgNfPRfGlYpUej0bs39U16sm8QuG/sA94El
 7nKrBz6zI7ngfSxIhrF7LfdEJ3u0TKSujRajgXQl7uOM+2YId7Xw0ejV0fGgrCFRyzUb
 Ougw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX87dpI6aFRbsUglYl8tvSMEt7Hl6N/jjhDbK9LH24lrWMSLzrRuH8qQMvLXK+oUHcQCFu6EBU=@lists.denx.de
X-Gm-Message-State: AOJu0YzYn0t5e7V8Z4kCjH1nDmUELE1gQVI3vMokRAiou/0tuxp2CSbn
 c7lbSohhh1/wuqOBbLAuPI13RwRTzf4Fc2wyqSA7Br4obrH5iqVBoCdA03N5KVY=
X-Google-Smtp-Source: AGHT+IGiHRd4SLRG3pg7HsBmjuzAqLkY5thBhOcVScHWH31SS9w3hyhPG3LiwtHQpcbCxTLBn+wvhg==
X-Received: by 2002:a05:600c:3596:b0:426:629f:154e with SMTP id
 5b1f17b1804b1-42bb02d970dmr57173565e9.30.1725122936380; 
 Sat, 31 Aug 2024 09:48:56 -0700 (PDT)
Received: from [172.18.168.79] (ip-185-104-138-67.ptr.icomera.net.
 [185.104.138.67]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba6425a77sm116699105e9.45.2024.08.31.09.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Aug 2024 09:48:55 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sat, 31 Aug 2024 17:48:52 +0100
Subject: [PATCH 2/4] cli_hush: run bootmenu on retry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240831-qcom-phones-v1-2-08614edd8e35@linaro.org>
References: <20240831-qcom-phones-v1-0-08614edd8e35@linaro.org>
In-Reply-To: <20240831-qcom-phones-v1-0-08614edd8e35@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Tk/BYM4KIUxtJwibvCUVvpBmrYkey4gF7acrjTZP84E=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm00l0E7Y1YyMiF2zt6bIDY5oRdqSiG1e/YmjXx
 vz6JPjA9CWJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZtNJdAAKCRAFgzErGV9k
 toIVD/9D4vVJjM45g95hdiWIiNqgjmwprQQmdA5hbAUfqBhfgq4RimrwONllE7VHPay6jzfqP6a
 SBgPt9spHHf6cDlS3EOWTMd08u5+mf0GjwnOdQB153y0ptJruq9J+08FOzyl89cUG2vXihHSLqw
 FrmJqiQcrxaXHjmsIcWrHwRiEF9HCoWaeuLCtSAXcogNpKlTFZIu6h0X9CMrOtuFoz3ds887y7S
 Dhf3RJMwsUblYJ6I6maZOb9CpUoZEEwi+WIGae5fMdWCLFndV0NFdsezcYZ870UINOTn4DIhLM4
 /kZNIhAnY91kvt9qwdobph/j0cOHR20a1BJ0Zwglg5r+G7bkTnOEvPu/Iwrhqx4inGMiHXJHvRQ
 Avw4assGYyV7N0gHSZHdZvmiTKu1yYJS8YUho0vRCXh9J125pDXweSZSKIHsYVlUeT5LJGkoObg
 PYYmisSQtepWiqECw5j6EB5ykbYuC9+6zY7WOu90zAlTW4WX/zMPOSIzIa3tgN3kAPXudDAResJ
 UGS0iA9HDDureLqAWvzvZbTgJ+lHfY/gczy8qxpq0STd7fnGdURncjiO1J7vkUVlIbwN5AEauQd
 /9pj8cX1p1GFwXx0+3mgw8M2ZoFyC7WF4Ddt4UGqwxky4J/a9FfJHIQQQLoUczkrI4mW158AGFP
 lUWM5MpicY/ZGQw==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

When CONFIG_BOOT_RETRY is enabled, make hush shell always run the
bootcmd. This is an improvement over failing to build.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 common/cli_hush.c          | 2 +-
 common/cli_hush_upstream.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/cli_hush.c b/common/cli_hush.c
index a6a8edce1f43..3c6fd6f00a1d 100644
--- a/common/cli_hush.c
+++ b/common/cli_hush.c
@@ -1028,9 +1028,9 @@ static void get_user_input(struct in_str *i)
 	  puts("\nTimeout waiting for command\n");
 #  ifdef CONFIG_RESET_TO_RETRY
 	  do_reset(NULL, 0, 0, NULL);
 #  else
-#	error "This currently only works with CONFIG_RESET_TO_RETRY enabled"
+	strcpy(console_buffer, "run bootcmd\n");
 #  endif
 	}
 #endif
 	if (n == -1 ) {
diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index 7874b399d141..c28f4a92123d 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -2897,9 +2897,9 @@ static void get_user_input(struct in_str *i)
 		puts("\nTimeout waiting for command\n");
 #  ifdef CONFIG_RESET_TO_RETRY
 		do_reset(NULL, 0, 0, NULL);
 #  else
-#	error "This currently only works with CONFIG_RESET_TO_RETRY enabled"
+	strcpy(console_buffer, "run bootcmd\n");
 #  endif
 	}
 # endif
 	if (n == -1 ) {

-- 
2.46.0

