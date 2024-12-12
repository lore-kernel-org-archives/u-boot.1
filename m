Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C6AE77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A9C1801DB;
	Thu, 12 Dec 2024 11:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jbS6nafM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FFB0801FE; Thu, 12 Dec 2024 11:07:19 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DD49801DA
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:07:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d3e6274015so708285a12.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998036; x=1734602836; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UggzEcKsQGKXFZcJuCkK2YVw5DqRR7AUQX0sU4jsX3g=;
 b=jbS6nafMPvBmPnd7sA5SvKdasFqD/bNuRCYfzaczBzxwUyt+2DTny+9+qXJukPnZ1b
 x7TxbbM9RczDsoOC18V7o9zHmNGd5UOgzxHhHFVlKHlotqdgYQuMF/ksZTQusWWll6dI
 c5qRkvkDc0j37y8/DxA750xO5k7nhnjjHWx1We8lAWsfo2WAqoPOn9qvUa9S74JbOds6
 NnBCHB5Q/Uwe9g9Wm2jMReGpWeBCEm0VpstbwxNQG/cLb9jthdfM2PGAS08WXCfeSeDL
 HPXr/uW+lMwzHhxXeizQWKm1R/a9kMEU54q1SoXn37YIAnUYTTAJenGrqGDn8xg0cfjx
 o4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998036; x=1734602836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UggzEcKsQGKXFZcJuCkK2YVw5DqRR7AUQX0sU4jsX3g=;
 b=CD2DgKxMN5IflWo/QvN6fAd84WLpUNR9IcBe5nOmg5bvxtd3Tz+6lEpe5LDymmoD8n
 KJRXg8ECWnyuAeSOdiyuRUNFwC5JUcBVncK829G23XMwYp/kojnmyEpV3RxEhL9KVmkc
 Vtwoz0L1/hjhk8Ht/nMjdpfhrzjnkYiQIU1AU7vBoL2AbZXFR4bQUGnPPJNJmawPkGML
 DQV62LtH9emKK7MuZJQNU6hDQWkUivsL4oMFupiew83fpZZkoGH8zQ9FRQogghPqObRQ
 IYyBeIM0o05y2swAHLhhZe0IBlOJkPXPh8qZlDPepD3wcXihNuma0d7JDqJ+2+uBcJdR
 XsrA==
X-Gm-Message-State: AOJu0YzPmA9WHUEOY2Pi4GL+D9OBEG8Qdy9N7nzy5xadnJ38/2gVKL20
 ikB8Z2VYhTDdaYFnkl59xxf2jAssgdE53CFPqKkJUEjcgOLiLa2d
X-Gm-Gg: ASbGnctI8pbqkn1w/q3Gv4FOHSXBBoQZbx8W+KxlfqEMkR71I6xSpFF270dsSwGKRzM
 mbuNp9SF/icScobzgSpbwOOJZfn8dfUvyUgzHqyP4VbDks3LPAdIBMH2IHLH0sAiMcLeQgGEhjy
 bSyEA0CiwHmDkLKdp7u6IJrntM5y0RkWhHMwVS+KiZjDr4SAinjfTBmVzKrCIlLKjUZmb4VoZN1
 4O4HvBhsuvTJn8VYEngzze83UGIWhoFmhrwASFz+6UEoiZx
X-Google-Smtp-Source: AGHT+IHu9SBWwoTmVEp9wfwSiPdd5o5UBU4PkPvZ8OxUUJ/+0iKQEV1bq5OVhvvIYqOYbA9ZxaJfjQ==
X-Received: by 2002:a05:6402:34d6:b0:5d2:8f70:75f6 with SMTP id
 4fb4d7f45d1cf-5d4fa1b26demr469987a12.30.1733998036184; 
 Thu, 12 Dec 2024 02:07:16 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d149b4a049sm10167200a12.35.2024.12.12.02.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:07:15 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/2] Tegra: fix clock init
Date: Thu, 12 Dec 2024 12:06:44 +0200
Message-ID: <20241212100646.5646-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This should fix https://lore.kernel.org/all/20241201164810.GT3600562@bill-the-cat/T/#m2b62b471fd37e4c9725c98547e2a919cf11db5e5

---
Changes from v1
- added partially support PLL clocks commit
---

Svyatoslav Ryhel (2):
  driver: clk: tegra: partially support PLL clocks
  driver: clk: tegra: init basic clocks on probe

 drivers/clk/tegra/tegra-car-clk.c | 52 +++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 10 deletions(-)

-- 
2.43.0

