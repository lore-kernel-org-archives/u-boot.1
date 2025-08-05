Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2960C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 140A683873;
	Tue,  5 Aug 2025 16:53:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uT0HHIHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4023A8388D; Tue,  5 Aug 2025 16:53:39 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E709D8386F
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 16:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3b78310b296so3449565f8f.2
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 07:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754405616; x=1755010416; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GsxpE6d0QVIeN/61m5J0GJmZd5ox9nHmgqwU/Z7tXg4=;
 b=uT0HHIHVWV25JlqJk2j0YcRE47k9PEYOq0/mOxes9Ss+cw8JBVCU2C2nP8N6y1E8Jo
 mUtkHOoXgd0eb+seIL7UAzuOvl2LSseU9yfOlReMn8eMe2DZOLkCn5xDP4zEeB8C+M6K
 8Coc+eY5Isj8qq5GvD04vBKFC0PiGPwYEJ8PSJfJ1VpUx+9Oopv72VvnZn/rqXvblcIh
 9F3R4SB1FYmFi6Yd8brCp4e9kQMOauUWabtVFwj/rQMqLQGASx6bYNkKFPLi1VG3PclX
 OrSMJDms5Nvwtq90XgEuUoI8jtd8WsTLH3rlXdYgMzuWI8hixfD72t0qzEjo2Hz5rrZV
 gElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754405616; x=1755010416;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GsxpE6d0QVIeN/61m5J0GJmZd5ox9nHmgqwU/Z7tXg4=;
 b=WnBh9Uyj3jM9S3hbm+du/ZyKWq/2Kmm6hARBrOiSk2z6DQBiBBzLyciwvYpMownQos
 kN8DUh9MWf07AjvYcfZ1woPI2VfIwRMMrZMEMrWt+5nJaSgsH0BsB7OfzfyMonXwEUVv
 sugUSSPTKKiOrr28M6MvFDLZRvNVG9yqwXxYr1jZElHLLibS3HI4mblp0xKzOZK14Vhs
 9Ed6jxmbkSk76Mv/E7nwMYR4mip7kjAzGics341flYbv0qLkDIckClYtBCQ4xdEGELaN
 +4knNcGhbNZs8XPYeRZzrw0MkNhtd4aY7WJR2NHYHDd8aYkduoucsN0eeOmGER6LfWA1
 IXcA==
X-Gm-Message-State: AOJu0Yx458OVWcgUpz6uYHRY5K1Z3JMg7+6QkcsBakAl39Xn4xlsFgFN
 s2QmXuEMhjJm9HXmN19BGX7lsmMKyAcCEmO38qufo0lazdpGpjvxUEo80+81127Moi8=
X-Gm-Gg: ASbGncvTjlHvcokcCjBRPRyP7e6pX2MT44DnoquiS4DtOLFKQ56fC+OmyUeZJrQNWlp
 pnFMYDohmHZ48jj2FycnddAcmv8TzLrOt0b7DXuTuFvYZq+mIKduCdTjQRH97VGozYtGzNjXdmk
 GaYKsom7pz3QsVYxCYLJtFXVXqhS6cpy0Taz49tdI65I7LrWMn9EVUvT4c2KblDmWdUrsSTKj6F
 CDQStJcTenW06+0QSzdXp84PR2mDW2F79YLvPT9I1CxtBphUUtziFFoSg2arMz2sYOfvPXsN/+c
 KGHfvZNWtXQ/bP0TvMewZp/h16y3TVHgLMK+N8g0yc5oxY/mdlBmwLVqpvoVkxWNABvfZOFR9uT
 GZVaG3fF+dcv3yuBkZIID/V48cYP3Jt8wh/0/QHcY47KjApiX3Uw=
X-Google-Smtp-Source: AGHT+IHPJtXoyC0hcDQG9kJrJKe+58suYy+o5IsTkcf/Ed9ZWFo1JdfTkh00g1/i9nqnENAxTfO3MQ==
X-Received: by 2002:a05:6000:2484:b0:3b8:d7fe:314d with SMTP id
 ffacd0b85a97d-3b8d94c13a6mr9883522f8f.36.1754405616328; 
 Tue, 05 Aug 2025 07:53:36 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459de0d4cf1sm66075875e9.13.2025.08.05.07.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 07:53:35 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/2] net: octeontx2: Fix two Smatch reports
Date: Tue, 05 Aug 2025 15:53:33 +0100
Message-Id: <20250805-octeontx2-v1-0-8b804a3760fb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO0akmgC/x2NQQqEMAxFryJZW6iVDs5cRVyknahZ2EpSRBDvP
 nWWj/8+7wIlYVL4NBcIHaycU4WubSCumBYy/K0MzjpvB+tNjoVyKqcz9B76LvTuhX6G6gdUMkE
 wxfV5bKiF5Bl2oZnPf2Sc7vsH+FQAnXQAAAA=
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
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

Smatch reported two issues with this driver, firstly an error code not
being set and secondly dereferencing a variable that could be NULL.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (2):
      net: octeontx2: Restore default value for err
      net: octeontx2: NULL check before dereference

 drivers/net/octeontx2/nix.c    | 2 ++
 drivers/net/octeontx2/rvu_af.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250805-octeontx2-e9831b326a5f

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

