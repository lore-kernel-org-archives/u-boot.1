Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF81C36011
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 09:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 303428129B;
	Mon, 31 Mar 2025 11:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zcWuBsbJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECA82812BC; Mon, 31 Mar 2025 11:07:36 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 886688006D
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 11:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so3770645f8f.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 02:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743412054; x=1744016854; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJr25I38w2ZlLIw+QPrFtarFsfo9OJlnyknYwC2vYTA=;
 b=zcWuBsbJca2Z8xUz5xX/zpcnpUI+xHHgADkN2VR1q2qRtv3fGWLRrXeEvThlyIrQWI
 gxueoS89Jb/Ftwd5t4v5MPpKUADjaaS30UBkZmAZEDxsmeDgRH/fb48FT80JubeGl/Ux
 7ecIyb/FbQvUTyB2YWUE1LTO6XlCgLV1+n4jmN0kaTOM0T/+SxKEkUkWZJEChkUtYzRk
 JKkpvWMomtOsnpz31fYZ/TJemc7j3T3WXGVUtGJA48MNrIvJo8JyyHOm9qLsuyxEj98i
 zmukwqNemzHHQMhsTc6KOvGJHcnPUueehv+9Z+F9+8GKVY9q7B8Y7bXpuQ2jgh4mQBWB
 CJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743412054; x=1744016854;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bJr25I38w2ZlLIw+QPrFtarFsfo9OJlnyknYwC2vYTA=;
 b=WhTVfewl73QjzJHmgsWWx5wThyGq04mndfolmssWDdTe7QwS5cdj9jxGgD7+V1lKIp
 C8rc2lEntGzIF1KIe3URoHkXA4x4vd1xQaxCHgcfxn6Z4ih4DogbogmsllkQU7pWoV5b
 UUYkTMUDrCA9Y3opNCl9ZlDZPtSKnvP4jFOUG2gVpsdAkCkWKy+N/RyKyGidi48jxkye
 CdY7PX+6UzB7ZzYkHctE5L/tniRrzJQ+SthrdwD0lqKB1/UoNM/QhASvIZ74I0HqP7bA
 Q70gl9BDygQW5EmpjGzngaLTG0ZbYpuHWSFedlRF5d41pzssYGwSbblNPwdKHUPiBhQX
 J5xw==
X-Gm-Message-State: AOJu0YytdRNmoig76+tyZychReER/8mQ2HN3WZpKqKpaDzAYbE9L3GfT
 QkBvClrscoHqWWyxnbju9HaQZ/FlBu3euYAKddF4JfsqrA7+b2aolUvvz9mAAZJkZ8EVIzQ36Ev
 HHfsmSNKj
X-Gm-Gg: ASbGncunbgTCoXAnxON2ysrJdK38jcaeZIG/Da8VQhO2fuqA0a9ZyAENV+//eF8dfIk
 q6eng5aVq4rgNB/6NWjKQWhb+hDAkUb58IkHgGDOw/v7KK180YMpD1eqtRnGm1Rgpa9rUfe7OLr
 Ju5jUWPzZQv/79CehNn4+uMW3YL8dKctiXdF0mAAbFu4ohQ115xiYMyRCVx6zVu1Sfk0LWdyCHS
 oHxmuY8FPrGdYMXNfG7AcKrsDorVDRyzwM5kFKfHAprY0QjVN/Mtnz687cUVqQ5SEygSkO02frP
 F4cedUTJ+/V5YfZmDmWHW8bCxBWlZyp086VFQ4krmhQWxyydmL3nRWAsbk4usEcICXdcby6fgmR
 W78Wn4AWEW2PJEv8fZ5w1kzBd
X-Google-Smtp-Source: AGHT+IHPPRC7G43lyVBo10sa7Y0AYs2blFIJfxpGHLQhzFNPiq0e2U+k7Bane53DcAPP3Vn2/VWcvg==
X-Received: by 2002:a05:6000:402a:b0:390:ff25:79c8 with SMTP id
 ffacd0b85a97d-39c120def06mr4916747f8f.20.1743412053948; 
 Mon, 31 Mar 2025 02:07:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:26ff:1b86:d0f9:9aad?
 ([2a01:e0a:3cb:7bb0:26ff:1b86:d0f9:9aad])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d9142a5f0sm90811095e9.0.2025.03.31.02.07.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 02:07:33 -0700 (PDT)
Message-ID: <a26d240f-9730-4439-b62d-f254aee6642b@linaro.org>
Date: Mon, 31 Mar 2025 11:07:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Jerome Forissier <jerome.forissier@linaro.org>
Subject: Please pull net-20250314
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Tom,

The following changes since commit 5e74863ad6613df9c69c576910b536e885083d65:

  MAINTAINERS: Update email of Mattijs Korpershoek (2025-03-28 10:33:48 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20250314

for you to fetch changes up to 64b973fc78fdba18389d372d6af2af18ee79dd8c:

  cmd: Kconfig: Fix submenu for network commands (2025-03-31 09:46:25 +0200)

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/25410

Thanks,
-- 
Jerome

----------------------------------------------------------------
Pull request net-20250314.

kconfig:
* Fix submenu for network commands

net:
* Remove a useless (commented out) line in net-common.h

net-lwip:
* Remove error print on failed tx
* Fix return code of ping_loop() when no ethernet device is found
* Remove superfluous newline in help text for tftp

----------------------------------------------------------------
Ilias Apalodimas (1):
      net: lwip: Remove error print on failed tx

Jerome Forissier (2):
      net: lwip: do_ping() should return CMD_RET_FAILURE when no device
      net: remove commented out line

Michael Walle (1):
      net: lwip: remove superfluous newline at tftp help text

Paul Barker (1):
      cmd: Kconfig: Fix submenu for network commands

 cmd/Kconfig          | 15 ++++-----------
 cmd/net-lwip.c       |  2 +-
 include/net-common.h |  1 -
 net/lwip/net-lwip.c  |  2 +-
 net/lwip/ping.c      |  2 +-
 5 files changed, 7 insertions(+), 15 deletions(-)
