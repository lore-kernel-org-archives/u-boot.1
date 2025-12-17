Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583C6D66B85
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 20:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 965EB83B49;
	Wed, 17 Dec 2025 21:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E7OroHea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C7F083B32; Wed, 17 Dec 2025 19:43:14 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D85B883B32
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 19:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3ec41466a30so745167fac.0
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 10:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765996990; x=1766601790;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2zRcVIdAjmM1OMwBQpfFTd5lR9OLT8KR9SiBoP/V7LU=;
 b=E7OroHea2on+aCiKTFtgPZ3JQ2sQOUzqNXO22xdhi1SiZbWWkwC6gPZl79bCxVO4Pb
 G8KFV1rZADmNnIOq0FcHHBA4G5Q4Q6XZkfuFlEoB8Y4jAhg6WnxYNuC2kqQb6iKiibf8
 xurVb2jepxWg0vaiE1kPSXb4qKufZehmslmhpxkv6pHBwCMZgyV+Q5b7C33I3D8ZjOsD
 DZ/84KwzvOaH2GGyvQImzr1C/VhqZPohZrQmtITvpUqSuIsfir3JUaGwlKIWIi+eiQ2/
 qlFIkctdgWDntASZVrfuv3pNRqRiMuZEWlL6Rm03R8FxYY/VYug2SAIRro9IM2j9RAl7
 vDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765996990; x=1766601790;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2zRcVIdAjmM1OMwBQpfFTd5lR9OLT8KR9SiBoP/V7LU=;
 b=TQhRD68YDgc6gqdN62YJcE4jFkUvSeVVscCNsqKcB+I9bzw3R3es+HR/JOq7ZDQdHX
 xKnocQ4NRpmn2UuQ9u3xB4mSZoPuwZCv5X8QhMTyq1or3/zEU2HP3jmJt76UBjm7RFng
 6VfNBba+u/hHaQez1CFfta9oQbfKiDWzDEh3Tk20zZbz+JpKa07lcCt5pmZwhmK5bTwO
 njJyq2JnRkHXy6cAmX271Trspv9Gnjbf6sAEfW300aO1E+JrhVdvLuU47OdA9Y2+f8V8
 9UKDK6Dhtz0vNNlVRVcu2rO3ZU5DcScexa6H4GgT5VQaoWyQya2METVO6NCN1XvyeSsG
 rooQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtoE1Z48VvIKo5BuwrFjvYRvKLLBTeECtLCfUbHFa44oprBSy7lQrbtg+B8g35FufU/CwNKDk=@lists.denx.de
X-Gm-Message-State: AOJu0YyZQR0lgsUmAMMBCky69VGH+hwCUp7tCtZtnL6cqMqo9gcLQYwz
 KzeYjSf21NSt2BSOSod+q0HOlkzwBF8NRBELyZvT54gxy1g4lRVjJ87won9SVQXYVCpZt4XM9FC
 t4moC
X-Gm-Gg: AY/fxX7jOYrx5rZCKRA8SFj3Zj4FBQ+x+Li2KDDXSmRpvebdR/09KAeKdSRD/6eG4qW
 TCWCDs2rBG6KPY6esRlRfUWRh714zh0ccblbONio8wxFUxpLmslHEIaVo0Vn6+efHqDUmJGgns6
 2DtbKHSV1DnQJPHWPm5o3lOTi9h3xsOli1uDbtWvqF6JEvWHNHPKvBizjvQ5qwry/wGKnB0rdwP
 uTHND3TG7YPDpgxNfaImAbwqdKf15MwbP272JkjqUc84fmf8ffre35dowPb8PXldjPr5MrmkI+9
 V3P5HXQMIUlM+5vCOOeSamYk14jGo0eO2JAQhp8fvdVEZ5Q3aD9k8dWTYYL+fGsVd/8LdLHH2Uq
 NkLjtxWWQo8rejFEQ63lJ5k+HQZ6DlKHSkXrThm6xe9Mv1xUKwSST1gumTgEbiM818jeHXnXFTQ
 IpoEZxt4f+zCsaWA==
X-Google-Smtp-Source: AGHT+IHGTtS1Rt5VCWB4pztq/9L7SAXBsbATDnMqTmlTcfBOIW5gQGhurQGuUgIBaKAOeyaatqQUvg==
X-Received: by 2002:a05:6870:89a0:b0:3e8:8ab2:eca9 with SMTP id
 586e51a60fabf-3fa16962642mr231317fac.8.1765996990547; 
 Wed, 17 Dec 2025 10:43:10 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:11a:676d:852f:9349])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fa18021a81sm91782fac.20.2025.12.17.10.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 10:43:10 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/3] a few test.py improvements
Date: Wed, 17 Dec 2025 12:42:08 -0600
Message-Id: <20251217-a-few-test-py-improvements-v2-0-e1f91e3bf551@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NQQ6CMBCF4auYWTumrZCoK+9hWHTKVCYRStqmS
 gh3t3ICl99b/G+FxFE4we2wQuQiScJUYY4HcIOdnozSV4NRptXaaLTo+Y2ZU8Z5QRnnGAqPPOW
 EdNVkybszqxZqYI7s5bPHH131ICmHuOxfRf/Wv7JFo0KyjhrdXDyp/k52eQlFPrkwQrdt2xcw/
 ijExwAAAA==
X-Change-ID: 20251121-a-few-test-py-improvements-b91babfc3e05
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1089; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=wGUhYBTFbNHKr/OQMqSRtomcvHmPrydq2qq0rhvbMPQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpQvmgGXxZ1AbALjFtkua+XRnidJyMScPd4uKNl
 ihss4mdITqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUL5oBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AnjcH/0LkSgCbbEReVHRqi+6C2Mm/Kl2q7Qj16y7CYqC
 rumxsx6ulihW5FdVJIe6yz6wBteCD/+/SWfZlEgkzJfMOL+xWkk/jPO2ayMY+H/hx7Xbek/TuDd
 OCOOgFKDVI77uFkouZoRQ+iBsacvzREMLaChqHRgQcutM0hKl4tJduMQ6Tm9QkTGgseMaYV81Zg
 yfEZJkqkAX9Z9B3+j6ZV2G5k3Yb9NHL+zDWYBqHT1zxHxg3E31Li5wRSc36OFtAsx4myJfSjp6w
 Wq4o471a0R6lmPFCOpvDHXjwE1BC5OTXgneWkZqM1gpj0LLTeAhZVIOInlJVUB/EFCir69K/rT4
 xNXU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 17 Dec 2025 21:08:13 +0100
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

While trying to run the test suite for the first time, I encountered a
few minor issues. Here are a few patches to address them.

---
Changes in v2:
- Dropped patch adding setuptools to test/py/requirements.txt
- New patch to add setuptools to scripts/dtc/pylibfdt/requirements.txt
  instead.
- Changed test.py patch to set ubconfig to None rather than checking for
  its existence in globals().
- Link to v1: https://lore.kernel.org/r/20251121-a-few-test-py-improvements-v1-0-bacb4148fb0d@baylibre.com

---
David Lechner (3):
      test.py: check ubconfig exists before using it
      doc: pytest: mention additional requirements for venv
      pylibfdt: add requirements.txt for setuptools

 doc/develop/pytest/usage.rst          | 4 ++++
 scripts/dtc/pylibfdt/requirements.txt | 1 +
 test/py/conftest.py                   | 5 +++--
 3 files changed, 8 insertions(+), 2 deletions(-)
---
base-commit: a333d9e59f6675c9541c34643f334dbf50898647
change-id: 20251121-a-few-test-py-improvements-b91babfc3e05

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

