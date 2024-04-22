Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC9CC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 11:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0959C88766;
	Mon, 22 Apr 2024 13:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="AoUtRO2L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C9A5883F7; Mon, 22 Apr 2024 13:44:07 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE07C883F7
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 13:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-346f4266e59so3149778f8f.3
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 04:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713786244; x=1714391044; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1J+tWc0KPV14hVyAhn5zDWs/dJemvZH7TSimHtD/SQ=;
 b=AoUtRO2LFQoWVlrR7ky6Hham6G9aUrF7PL+gUu5y4HA3NLGmhnoz/7l0TFJ7FZIg4Y
 JbNUYf7cJyA55GM3Fb9XVlbi6uhconnD4IYPWLdI2xhzxsvlaLNmd1Pr6860ZBpwEjzm
 je27GqaRuOjxEns+W5Wqq4SUxcYGvr8PvuxnknimE2zCdKwPRVoz4BKcpWQdQzUCqHZM
 6hzXCt222+wmaoos1KXd1Jb7ffCnKAkXu8cqvmoNSvJQlKcFXQczj+iWUvao3rYu3bxf
 lYi1wC1HgCJQgU5O4UnB1dRU6tw/p4zAclvE6fIdM+3sB//IPiJz8a8JVRh4yVhNiCB0
 L85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713786244; x=1714391044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1J+tWc0KPV14hVyAhn5zDWs/dJemvZH7TSimHtD/SQ=;
 b=VbGlPq3CLjLV3hbinoWV6fFIcFwE9K/bU3HGs6Oz6M4dRMzu+589s2uJJ74OzRP8bm
 J6V2ERAAMc3+eWuKw8abBbUo8+UtrDMWdhmLUwkFQuzwpHAazQ9TbKbsMvVW24T0kiqO
 31b8chj+xxzuigSy7sKEiC8vsY2JQDsnIOc/7OyIf/vJZtjgcbgoqmaBEuz9szv4Cnvs
 kJLN6oWA7FEDZ25Z9+EW+OdZ63q+gsoIj1cnNzWXrz1P0rkEKePTqonq+72/OdeT100U
 HNlBNjbU6bYVUIs3YN7/zIxAkbuReZ7O4sRqUpCZYXI5MylKHtFutdOS0u4xxR5HlHr0
 fs2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr+TQGn81gssuUlh6CNnwhTGIhcAv0eSPvII3QDvK0wUOHEUcUGUMjFDmG01QctosMXcnasZerARIhbxLzb0zkQbunaA==
X-Gm-Message-State: AOJu0YyF8dNeu94sgOkIHfnuuGehe+krNcY2EjZMKE+TQYJDtfIipU3E
 Obzq7gEeqqiKhQMdpk8boM0WDszQkQ2sV+3wp6O+xStq47BKkHskoZ+EYFDEQPk=
X-Google-Smtp-Source: AGHT+IHPLXa2qmqZK8OCUsZzqMAEKpvsPjqJfuJ3xASTWNfAoxy/zJRZc8IC9TbclAS1dsyliSaVFA==
X-Received: by 2002:adf:e30f:0:b0:34a:119b:aadc with SMTP id
 b15-20020adfe30f000000b0034a119baadcmr5497929wrj.6.1713786244065; 
 Mon, 22 Apr 2024 04:44:04 -0700 (PDT)
Received: from fedora.. (dh207-14-170.xnet.hr. [88.207.14.170])
 by smtp.googlemail.com with ESMTPSA id
 e5-20020adfe385000000b003455e5d2569sm12022977wrm.0.2024.04.22.04.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 04:44:03 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 3/5] pinctrl: qcom: ipq4019: adapt pin name lookup to
 upstream DTS
Date: Mon, 22 Apr 2024 13:43:26 +0200
Message-ID: <20240422114359.219762-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422114359.219762-1-robert.marko@sartura.hr>
References: <20240422114359.219762-1-robert.marko@sartura.hr>
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

We want to use OF_UPSTREAM on IPQ40XX as its well supported upstream, so
as a preparation update pinctrl driver to look for the upstream pin format.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-ipq4019.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-ipq4019.c b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
index 4479230313..4fcc4b1810 100644
--- a/drivers/pinctrl/qcom/pinctrl-ipq4019.c
+++ b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
@@ -36,7 +36,7 @@ static const char *ipq4019_get_function_name(struct udevice *dev,
 static const char *ipq4019_get_pin_name(struct udevice *dev,
 					unsigned int selector)
 {
-	snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
+	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
 	return pin_name;
 }
 
-- 
2.44.0

