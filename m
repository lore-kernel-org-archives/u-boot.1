Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EBA106ACE4
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 20:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FCD784166;
	Thu, 12 Mar 2026 21:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k7Tfmy5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4AF984181; Thu, 12 Mar 2026 21:34:16 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6629F83F00
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 21:34:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-467161c4b7aso756848b6e.1
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 13:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773347653; x=1773952453;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UC/6pm7QxgMyHYNWpJUmaL+2+BISsz6OstPQFwk0DFg=;
 b=k7Tfmy5zL5aE3BETYa+4iChAuZIMrmAIe0+fFwCPPo2TKSTq0u5CT3yUhqsavnIDLv
 7wh8IbeiAfjxeL0wu+AArNJR2SfQTrpWjubMvbyIV1pKUoJbGD/9AL/ZR5DRCkRtT7sK
 jUiiwH0xkhBFaaJ1t1uI+dkiE8H4IpUFM2yeTi00fZC35nS7AjpqjIJAyh4ga4LFZVpi
 Z5dpokBAaSTWUo8dDLPcrIOTZZFRp9GFj1WWmY2ibfeuAKt7ubP7A8aZZRryt5TkghNK
 JsLoImDlSRXsjrpu4RoovScoMRofio4YDZSPMDjf+DTJKR5xK6URbEjaSb9Hl7lKc+WS
 P21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773347653; x=1773952453;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UC/6pm7QxgMyHYNWpJUmaL+2+BISsz6OstPQFwk0DFg=;
 b=igtuZnUPsRr9+zqLqfH+S0SItvhIk5yyYzschx/raXdljhNHe5CmZOS3q80j1Q8bbt
 wMW6tsBImrjq4iOkEhddUONgARa6ws08J1J8rcPG8rKj4VRCEz2WZ1mIippUm07j9jue
 VuuqeIsqCJovx49ULCAzfjMe4CO9xqPR+pxNDgsdwejNC7aIF9yt+31ai1SD4Xfx67GM
 2dBJWE1sgxSxoxgOcYuf/cFpsigPoqT09iE2MKliUgUeaqpuOsCz0LTsE6zNnvhPxmwq
 NdEryG1upqKSEPbXI8D5VYz6ZDKAh4xwJrReNArxVIYGGpyiIiSIU1j9i6BfMItedLFV
 /plw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoQE/xSerehlUPR2axFcbaubAIFlqJcdCwG3OL10OHEEueVJY28qY3ZbCCZgM6arVdtZfDqlc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7VROIoe5lCerxCWqRmeeqwdmMaGCuq5eR0IR1BlqKfFTvKLnL
 Yf+MCw2z2i/xzxl8Fr4hZY5Onmw9E68TqrkmWUtrrVhCno+neBMIWWinLqKQieXAtRyOdx3v1jT
 qwdLB
X-Gm-Gg: ATEYQzyTpqtCzA833obW4blaU3AmZQf6UIQRXJtdko60fg2blvJtnQP7i0Ic7faBLOF
 Ld7s6k2r33vPUOlQuN2BDn9ioVyFOCUfTvdJyAq8jAtxFweecqohj5sWfGHOVrvCXYiShUAAz3m
 psO/z6sF652EdrOrbrCvswuMdo3w9s6rZ7bx8RQreDHcCpItZtD5FJZ546ykzM0k2Xvto8fpPm+
 63HmwxquATjhl5sbmQsign2TOtinclDpfCR1pXDGbVCNyrz7EcZFXIcpnoeTG3uUUcNB26RHyy4
 O/8tvazJtPaBpxqrUtyr8GpU0Z2u/WjojACjzRQH8a4LOpnla9Kpb11UjhuyJq8Edn97MFbdWzv
 WZc1Mji1NbYfMyNLSZI4JuIpExUUEpk4Uo/O1d1nlMrx3rJYsGD8kTUM1zAzJj388lMhljBm9pA
 82CGQz1gdDD7vS+z5/Zn9McwwWBbYe
X-Received: by 2002:a05:6808:5193:b0:467:1f6:4ace with SMTP id
 5614622812f47-46757094efdmr421469b6e.12.1773347653013; 
 Thu, 12 Mar 2026 13:34:13 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1f95:f82e:8747:8137])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5e8185sm6276286fac.12.2026.03.12.13.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 13:34:11 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/3] test/py: gpio: cleanups and improvement
Date: Thu, 12 Mar 2026 15:33:38 -0500
Message-Id: <20260312-test-gpio-cleanup-v1-0-bcf549671eb1@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQQ6CMBREr0L+2kYoyoKrGBaljPiNtNj+EhLC3
 a3i8iVv3mwUERiR2mKjgIUje5ehOhVkH8aNUDxkJl3qpqwrrQRR1DizV/YF49KsbI3rBfVgdTN
 Q3s0Bd15/zVt3cEz9E1a+ob8R8E75TA6NehOhrJ8mlrbwgUd2Z4dVqNv3D6SjFwqkAAAA
X-Change-ID: 20260312-test-gpio-cleanup-c3e54e3dc26d
To: Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1070; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=fsuHhCIvlHGj+9EYXCXoHub9573br2L8KLXlQ+ON74o=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsyMo/GqCHTVfW4vddOgavmA/lHzP2Ss2XaxQo
 AYfU8FIj5eJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabMjKBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AtisH/j5mcbuS1HAkhfKIEp0foMi/jLV0OTsh+J9HQQY
 LauG1wjrWNQ1Q/L2xz1MZd7PWkEdH9nEpaikr5+WCJJMLaUFkJs5yXJhtwBPkZBT0CcT8CVV6Dd
 TgUzukVChUnlKnydqMZLitTRHZx24FQ21y0fl9Oj4Ri/GuvWUw71ba9y6uZdYEuB4yxKOMT5Pp7
 AHEzUSbCm9nj+aiuLKKxwihm7Sml6EHm1srdxKavUjSnIvKZXFc6unNjzseVUJM8ME8I36caZKN
 tEFwCiMAwBwxrJbTiwsewDPuNVc9bxACpfll+38LKr2vx8+noaSZf7dGXzqnhFJTL9sJdQCX0ZH
 AhC0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

I wanted to do some quick tests to make sure gpios were working without
having to dig out a schematic. Which means I didn't want to set any GPIO
as an output first without checking. So the main point here is the last
patch which allows gpio_op_pin to be optional and skip the test instead
of failing with exception. This works similar to several other config
options that are already optional in this module.

I also noticed a few easy things to clean up while I was looking at the
file, so there are a couple of extra patches for that.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (3):
      test/py: gpio: remove unused imports
      test/py: gpio: removing trailing semicolons
      test/py: gpio: allow omitting gpio_op_pin

 test/py/tests/test_gpio.py | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)
---
base-commit: 8bc2a5196c1c0bb5dbdaca073323da0015a0de37
change-id: 20260312-test-gpio-cleanup-c3e54e3dc26d

Best regards,
--  
David Lechner <dlechner@baylibre.com>

