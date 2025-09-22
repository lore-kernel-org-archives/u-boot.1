Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78533CAC5A7
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 09:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B84D583335;
	Mon, 22 Sep 2025 11:36:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vFIWyWEU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6105833ED; Mon, 22 Sep 2025 11:36:52 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38EB983211
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 11:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so1437725f8f.1
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 02:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758533809; x=1759138609; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eyJtNHuyh4oM3XxD/YShrleduhb0fthKgdibDlJVaZo=;
 b=vFIWyWEUYRtIN++5jAoDrXeUYVOEeAqFO+mr2+5M6lR0Q9K992p+JcM0AEW9hXr66O
 mrb8QfUQsgbOzfY35Cr+7lkuAzsQJHlrqiOTIR9YzxnMPi8MlgjkFrxI6le9jNvTx1lW
 NSCTENuzwEpyzkXRpHyvRhkr7tC8U1xucyj8LOIyYhwdCXMxckk6b57Rae+PAzEUc+Ou
 fcuoES0R00A5tVp8RNSx643TZNfZdaA1kcRZmZWIfBMWCVNdKaReXItp6EivUL3+ZNkb
 rONP0KCW0KB6SfnbQNK+iDCZjI41jkBF3dq76vVc2JWMQiWv8dSi1PRyTBS46IpShD03
 Xihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758533809; x=1759138609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eyJtNHuyh4oM3XxD/YShrleduhb0fthKgdibDlJVaZo=;
 b=a+cCoI+vLU8ZH6j9x0t1OEE0X+UfXNlJ4+xyjC9XUVjd+VCPC7aDgxCNbMxSWMkeAh
 xTqlBEffaUQ31slqbG9i7MPsBJv5v1dDQca2k2/ppBwgyfCa99JgvzwW/OXf4CacdDu6
 UHd8WyUj5vUw5vVfvJbQGyMQJP4HhZwMMtS3UF2mGf70q+z9ApnI7MAc97ZHrFHCIyUn
 zrH8kEFizl9hYdQ7UBO73MYqfIm55KouFB2rwxVnB/bKLFXkpsz/ITM3p5CO8m0O3csV
 Sj9kcYj5hv0OGWoc4kP1hUYYkhras14C6otagYjIANdIor0690jXem9GKBh0N51bcUHp
 K4ew==
X-Gm-Message-State: AOJu0YxGIKaRxeDFn6cp6BmxXhCiuDqM3Ub92iZj+qtDmQsaXYkBtib6
 HD6uyHJ6bzMxxT55JB9Fq7+YS66WQr8wFowLS2ISxKF9FjHhT26k+cgIq9rQurBKeDHlj1At38G
 34tULehE=
X-Gm-Gg: ASbGncu4Rc7iTa3cfJBIqhsXs7cidhkbi2zZPnGFOcbD13y2riwi+3/gFOJcsTjuCBN
 9ApuXkTYsFiT89qtOC8x/UqKXGdo0OMXfSCnCUs0Gf0RHH7ExLm3O/gSYoBlPMtZrHeWzqGvSXM
 XQJIwByR8fFdRzdq6JPJXFVCJZZDGrQkYbBguHiCl3g5l5WcdaL7JPq0p77M9d9EKoQZAGkYzRG
 0qa25J5JQ8tCjCu8AJAqQwMmurR55VsZmL7oMWpuhAsQeK5RSwDqwuC7Mi55PA7ygm1fbtKPOcP
 ghtApQL7X69J1JFti1tJTn9Gwa2gHKXgDVbiHY9KV0aeE3O5Oc2q2k7wIVlDngHb+dr6ZTPlUC3
 VHkoIQAC39o1TBXk9kIflbKuLea/UkZg=
X-Google-Smtp-Source: AGHT+IFXQ+AJL44JQUHVZN9t3qW/+YFkbGwB33W/ge3xfy5tTehxU0RVSl6zjnmsNCwjo/du+fT8mQ==
X-Received: by 2002:a05:6000:381:b0:400:1bbb:d279 with SMTP id
 ffacd0b85a97d-4001bbbd375mr1644277f8f.39.1758533809226; 
 Mon, 22 Sep 2025 02:36:49 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:fe8b:a136:2e69:4bd1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07407d0asm19177840f8f.17.2025.09.22.02.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:36:48 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Subject: [PATCH 0/3] lwIP fixes (SNTP with DHCP)
Date: Mon, 22 Sep 2025 11:35:40 +0200
Message-ID: <20250922093629.2547703-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.48.1
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

Michal S. has reported (privately) an issue with NET_LWIP when both
CMD_DHCP and CMD_SNTP are enabled. In such a case, one would expect the
sntp command to be able to use the NTP server(s) advertised during the
DHCP exchange, but this does not work. This series fixes the problem,
improves LWIP_DEBUG by also tracing NTP-related actions, and sets the
ntpserverip variable to be in line with the legacy NET stack.


Jerome Forissier (3):
  net: lwip: enable debug traces for SNTP when CONFIG_LWIP_DEBUG is set
  net: lwip: dhcp: make NTP servers usable by the sntp command
  net: lwip: dhcp: set ntpserverip environment variable

 lib/lwip/u-boot/lwipopts.h |  1 +
 net/lwip/dhcp.c            | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

-- 
2.48.1

base-commit: f28891d444631c91a6e090927486a2169b51b20f
branch: lwip-dhcp-sntp
