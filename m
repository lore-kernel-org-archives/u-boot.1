Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6D9CFC28C
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 16:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE88583A2B;
	Fri, 21 Nov 2025 17:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QUnHM21D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C42783959; Fri, 21 Nov 2025 15:36:50 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0A298394E
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 15:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4510974a8cdso604804b6e.0
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 06:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763735806; x=1764340606;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3xQT23tBoEDN9v8uE/iUPmcJ4LFREF20O3F6ymRlBio=;
 b=QUnHM21DfKGy4LvDNVDVcGlaaHJxXkN+geKB0J3D4bhTqzHVObsq+MAJ05I5MFZR0+
 FUVCMgip3OImdpKp1Np6jVd8nbC9GgUw2c9srnEZBTssceHoGRsBsu+LUldHkwqr4AT4
 dGv1mO1alLd3WAlxReEjnl2n86eZzpEU5hyPU97ltXrgQdXaKutF5iRAxOvJDjf5Ynq1
 zD2aL3HgW+l8WVZbobcv8iyPvATq/ygMObhPi5Gtca2ktiTBhadNe8wMaia1dnhtMmJ+
 rgfZIPj+Z2adlLRCR6n2zJN0FshJO1SWBddEQ8pgDaVgr/3qlfqBkN0mZXnb8PfeUpip
 It8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763735806; x=1764340606;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3xQT23tBoEDN9v8uE/iUPmcJ4LFREF20O3F6ymRlBio=;
 b=wc/LByI9yU95zObz6fWUIZE+Og35V48U0x6rIyDa6nZET0ycjZ7yMhIZXsXGC7sOGz
 Ozz1f362ZF33ThKq6/YV6To10CFsLoeXByxat6qA/E/ilhnAtZwyusO042u7u1WGnF6A
 Q/Ik8gCVZmf3yx9viniV7PJd4Fjh8LaQq2vKfLI1lbvk/0bRUil1DNtNeRaq3rpcNJ//
 mFr9uuoOMZuULC8Jq/P9ZDX4FcILKxj78euBOlmuenlwJoH3tslh8D+l/1TNspAwnsQY
 Jaj64PdTGV950kX7mDVwdNohrvKVOkPLW2mb0kFucO64EhKIN1ioXTg+L9Eg7jovUwM5
 8Fjg==
X-Gm-Message-State: AOJu0Yxxwif4DyvTlvHNYDh6S7I54rWihhIoZ6AM43Zb2b0fjNz74oll
 DEa+E1tf3kZ091PhwNj++CZ7bULYO17A+GxkG9RnZsfsZ0DJ333x7AKP3p5szdBhh5oI4NreOsh
 4c3IV
X-Gm-Gg: ASbGncsoLRmZblkuDMDBMOv27xiZrFGEFdDGNmWfPs3phGL+cQZxImE0lkKkXT3ZWvM
 aQpB5UImh6MftRVOVOSI9Sra+wGfLoIbQRAGcxExJP+C5UrAEPfqc8FEYuZa7QdsGA3wZMU3J/d
 yQDFC8Ehg+bI/D0vt0LXgNRDw4v2JcIkfS/lrj62/AiO9IVRcDI0Mb5+MAgZtaxJojR8xhRmX4O
 YX1jJSbziBEe4GUn+SjH8/+of9jTkoEn9U34khzJvPSG9jDPaZynI6pgZe1uWkPGv5Q0BAszPHA
 tRtZZN3+EN4pNV+HxcE9i9C1ngf7mB8OAS8x0RSA06Unpo54TBdS7JqkZaFgPiNZtAZdxK9t67m
 ilmvu8IqSj2bxa/76foMgXBqFRrcYFzLYIArXBw+lwFqxEY+sj0w4+EXfI6WUCmWJoieQgaW+9G
 xdHDC17LeKaaCL/Z+nnobtCdds
X-Google-Smtp-Source: AGHT+IHUqOYkdhz6IgGlV47a0a4mt2JaP/WXMozFWVhnOuqcMFsP4RR9OZwfJ0JBTvTyxRYjiCRd2w==
X-Received: by 2002:a05:6808:14d6:b0:441:8f74:fce with SMTP id
 5614622812f47-45112d0758emr919538b6e.59.1763735806589; 
 Fri, 21 Nov 2025 06:36:46 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d761:af7:26f5:f16e])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9dc2171csm2730064fac.10.2025.11.21.06.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 06:36:46 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 21 Nov 2025 08:36:15 -0600
Subject: [PATCH 2/2] test.py: check ubconfig exists before using it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-a-few-test-py-improvements-v1-2-bacb4148fb0d@baylibre.com>
References: <20251121-a-few-test-py-improvements-v1-0-bacb4148fb0d@baylibre.com>
In-Reply-To: <20251121-a-few-test-py-improvements-v1-0-bacb4148fb0d@baylibre.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1390; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=paRKlr1ocfHYx1kege6AcI9uSbCLfO7bNSq7JCETlOE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpIHjxkkeyFpUr4DNYWl2JSNShqZQxTK8/z0ONC
 6BJn1dOiVSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaSB48RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AwiIH/2t+RlKDTKW1gFGSjZXddyqI2ImQVn6iemP5XMH
 5LDMd7LPk1LJ/lRcg9vMX4vjlv07B6grcnoKj4g5RB4OtBNC5bIPU2k7SuAuhIEha6H7vfWnetV
 FwRmVF1vANv3PkuV/FWaLye1L0u5pUvRb8x6pUdL/BoOY0iwUOOyGpHkRskxymVgEr0dvSSTkeN
 yWVl6c6h+hYRIP36PdIZ0tvm6UVnA2wBBw+GtHfrzUpFpgZYqBK/x03AuwddbZ6NLYicxhhvYpk
 W7j14aSFsU6yQ7zGi+DtE1L96xC0LKpbs9sdCiL3j7blQVLnzZzt6qRoDoBHomkfLzSjkLxeHti
 2syw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 21 Nov 2025 17:59:15 +0100
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

Add a check in the show_timings() function of test/py/test.py to ensure
that the global `ubconfig` variable was actually created before trying
use it.

If tests fail early, e.g. because --build failed, ubconfig may not have
been created yet and results in an exception in an atexit handler.
Adding this check avoids unnecessary noise in the output.

    Exception ignored in atexit callback: <function cleanup at 0x7de475ea6b60>
    Traceback (most recent call last):
    File "u-boot/test/py/conftest.py", line 669, in cleanup
        show_timings()
    File "u-boot/test/py/conftest.py", line 616, in show_timings
        if ubconfig.timing:
        ^^^^^^^^
    NameError: name 'ubconfig' is not defined

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 test/py/conftest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index 8ce680a92a0c37f36489b0782921d6cf4078850d..f889e3d3ae26db3ae19f79e236a281471d4b6de9 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -613,7 +613,7 @@ def show_timings():
         if too_long:
             show_bar(f'>{get_time_delta(max_dur)}', too_long_msecs, too_long)
         log.info(buf.getvalue())
-    if ubconfig.timing:
+    if "ubconfig" in globals() and ubconfig.timing:
         print(buf.getvalue(), end='')
 
 

-- 
2.43.0

