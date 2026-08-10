Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F24AC5AD7B
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 22:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1F0A40692;
	Mon, 10 Aug 2026 22:11:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IepHUi9k0euu; Mon, 10 Aug 2026 22:11:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 012C240527
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786399904;
	bh=LBqKjrLn1RGfxBdZarzkBKKyJHR98QuSrRtXTo53vY0=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=zh9TzNBiNWOkICvGQlMTQ2O+H/x1zE0gsn7Z3WIjIoOxjCmQxyN4oPAJUm0YGEpaW
	 b29ik3ScEF0JzsLyEtVSRg4i7CdyPm5rmia9Fs4kh2IkWwwftiuVU61YK1HfUZ9PHz
	 CRdqjyi5f9xNmJ6dIc5Sl6tPiKXCn6ELSRLHD6jXiQdEnZjLkTtW2roh7feoP89xoK
	 mN1wEdi+aSVfbI80I3uTuK8lvQ2gsDzRvdqFMlYU8J37ZnrgpJX18mRUABsjRa8rm9
	 yRB55V+QDC7tsVh9deJnmzoxFKxkTqPcT3cx5CBsvLMduiYRP/a79a066a4p19qR2t
	 aPeK53FeSK0UQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 012C240527;
	Mon, 10 Aug 2026 22:11:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 28C4F296
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1AB4B60790
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:10:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bajBIvdYH_7T for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 22:10:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com;
 envelope-from=anton@binarly.io; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F090760774
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F090760774
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F090760774
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:10:07 +0000 (UTC)
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-52b3934af3fso23340291cf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 15:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786399806; x=1787004606;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LBqKjrLn1RGfxBdZarzkBKKyJHR98QuSrRtXTo53vY0=;
 b=DH32FS3xe7uN2Z2inBeqNa+Qrp3d6OZawcKqybyIj7BVnXdRL1jPF6todB31z2FRan
 kmGhnpFrzw1EafQTlYSV6RUQ5H7BOK3qlPyAOVHFzkomQYjzAZif3cIjvWexlL4cGR3e
 ZhVXj3KJpQr6LNL+pqmsUwE5MGbdiaFV3z5zge4okPUoY2zYtnKbxtHm8BjOJoOygvrq
 4rJURTnQDHP4mLKNloTasT9A6zeuTKNKBxOhKrRfhnqC8V8sMnTfrFqrILgYq17mrc9w
 59cYPMIaSyApRynABvzNWLyLSH3yXKrdOSNiwOJmj5/8iSFMGbCum87ydHecJ6f/yCIk
 bkHg==
X-Gm-Message-State: AOJu0Yy3zih68sy7VnU/VXO97CrYn+/aqPzZuYp/SOSf62EuCDm97cy3
 SQvzJBBPEsLPzhuYtaqxAATyiMrif1PIgur4AonOIBYx19xQT5ummUy/pfFGt815N9FQpqNpv9D
 kOExl5o93C8jMmic=
X-Gm-Gg: AR+sD11BX02G0zvbSeRQR30u+qYtmCkW4g4EfFmLBXZsY/ZnIVWdU9KYL+OJBQRzmaj
 +cOXKDGtcQp/5bddmapTlH8nN+FkCqz6ldAWQFZ3waKx7jE5i2GNyK7OH01z9fW4ClAmLwPdOSG
 dHUzRxl+lQbVtWCV75vfq4IV2i5JUXjM1aSBc/juXn9Fqjt4xi4/0uyvA6HVCvzJDpFdZ5coDzk
 yVS+LsXaagYtjPYKMKdOFrIX2lgPC9k2/opM0w/8Yku8axQu1KWnOI87/e6m1V4R+FXgxBLjH9H
 az0v2M5k29/NT+PQvHtgPSV5K97s6JnhXV34I/1w96uG4PAY7HSFkUdOnYW0R1u8b8nKy4vYK3v
 0kAyvRa27S0ViC18xlpMmTdhzBz11oBwgkqHYT3mSQ19pmogAgF9XKjltP4iD9oKyuQoEwWuHGY
 VLJQxHVN97ut3tmiamGnyo1cR6ljZOx8IsdJe14RIZXOTcdTiWgTVCJvkuAWJR0LqA76FjK/5y/
 aIposILuPwRrutv
X-Received: by 2002:a05:622a:c83:b0:51c:22c5:daf5 with SMTP id
 d75a77b69052e-52d0b281f3cmr362851261cf.38.1786399806402; 
 Mon, 10 Aug 2026 15:10:06 -0700 (PDT)
Received: from Ivanovs-MacBook-Pro.local ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2080c90e87sm441651666b.34.2026.08.10.15.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 15:10:04 -0700 (PDT)
Subject: [PATCH v3 0/4] fit: Harden handling of external-data properties
Date: Mon, 10 Aug 2026 23:09:53 +0100
Message-Id: <20260810-b4-fit-ext-data-hardening-v3-0-17184cdb87fd@binarly.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Nyw6CMBBFf4V07Zg+eLryP4yLtgwwxhTTVgIh/
 LuAC+PGuDzJvefMLKAnDOyUzMzjQIF6t4I6JMx22rUIVK/MJJc5LxQHk0JDEXCMUOuoodO+Rke
 uBVGoVFeSqyJTbP0/PDY07u7L9c3haW5o4ybcFh2F2Ptpjw9i2/3TGQRwSHVuKoGqMJk4G3La3
 6cj9WwLDfKjKnn+SyVXlRGlsNqKzMrqS7UsywvicIleIAEAAA==
X-Change-ID: 20260730-b4-fit-ext-data-hardening-1734a9203753
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, 
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1786399803; l=2531;
 i=anton@binarly.io; s=default; h=from:subject:message-id;
 bh=OYAYl80fRq/2+wAg8ASc97DqYNll629ItNz6aaB1YSs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgLlci93RPwSlisH3PzSX3+CiC/xruz
 nbNSGHIKfmW2YQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJdMouenrxUybK523PbuGbWa0lrCDdPAPkDTwnYV+UcQaO4UToQJNG9DIv59DxhtDz6TPyfWLbe
 KooHs5ziDLAA=
X-Developer-Key: i=anton@binarly.io; a=openssh;
 fpr=SHA256:OWnvXkgcqeWMXacIaCJR2oikuTmVTaSodreIHEJTWEc
X-Mailman-Approved-At: Mon, 10 Aug 2026 22:11:43 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1786399806; x=1787004606;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LBqKjrLn1RGfxBdZarzkBKKyJHR98QuSrRtXTo53vY0=;
 b=GJ5E6BnyyQDCWRQp+ULD0JTstM9/cvxlUKyqK2tJu16N2lp+St0ohN/iFTPx/GKo/t
 WjsbcoinFI1IoZ1jrlCtBDOLzlI1A/oHmqiZdmLv/3iSrMQCq7PCMn4mG5t3QHKMNBVT
 wDVx19shJhs0ieVcraXkuIIPcB5hdDDe2FLrepJ2TzAXUOlfzh5BJru+VbdHJzVfdg48
 mS+gXLXKjKnKfO//pyZ3atnabSo2QB8FWZdm04E5tU/uAq+FsO9BcaTh3BJvKibRT9nj
 LejAHdzY4Qasyw97p+xBAAyoG2l2BrYwWCowxJcQFJESRCZX7pU8B+A65oh7gKo+dICw
 cXjQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=binarly.io
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=GJ5E6Bny
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Anton Ivanov via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Anton Ivanov <anton@binarly.io>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The data-offset, data-position and data-size FIT properties are 32-bit
unsigned values, but were read through signed int. Also, they are
excluded from the configuration signature, so they are attacker
controlled.

Patch 1 switches the accessors and their callers to u32, removing
the ad-hoc handling of "negative" values in U-Boot proper. This
transition was discussed and agreed on in [1].

The SPL loader has its own copy of this logic with the same problems
and fewer checks. Patch 2 factors out a test helper, patch 3 makes the
SPL offset/size arithmetic overflow-safe, and patch 4 adds the
addressable-range and FIT_SIGNATURE_MAX_SIZE bounds check that U-Boot
proper already performs in fit_image_get_data().

Patches 3 and 4 build on each other and on patch 1, so they are not
intended to be cherry-picked individually.

[1] https://lore.kernel.org/u-boot/CAPWaX55XWFLcMGRuaUuXXn__MX_UG4J8QTd6rvXZmJ4WSOCy9w@mail.gmail.com/

---
Changes in v3:
- No code changes.
- Patches 1, 2 and 4: added Simon's Reviewed-by tags, which were
  missing from the v2 patches.
- Link to v2: https://lore.kernel.org/all/20260806-b4-fit-ext-data-hardening-v2-0-b181cac15c29@binarly.io/

Changes in v2:
- Patch 1: keep the 0xffffffff data-position and data-size test cases
  instead of dropping them; they are renamed and repointed at the
  "FIT external data is out of bounds" message they now hit.
- Patches 3 and 4: no code changes, added SPL code-size figures
- Link to v1: https://lore.kernel.org/all/20260730-b4-fit-ext-data-hardening-v1-0-4a6b91e37b51@binarly.io/

Patches 1, 2 and 4 carry Reviewed-by: Simon Glass.

---
Anton Ivanov (4):
      image-fit: Use unsigned types for external data properties
      test: spl: Factor out external-data FIT property checks
      spl: fit: Harden external-data offset and size arithmetic
      spl: fit: Bound external data like U-Boot proper

 boot/image-fit.c               |  29 ++++------
 common/spl/spl_fit.c           | 122 +++++++++++++++++++++++++--------------
 common/splash_source.c         |   2 +-
 drivers/fpga/socfpga_arria10.c |   3 +-
 include/image.h                |   6 +-
 test/image/spl_load.c          | 128 +++++++++++++++++++++++++++++++++++------
 test/py/tests/test_vboot.py    |  10 ++--
 7 files changed, 210 insertions(+), 90 deletions(-)
---
base-commit: 94b349bd902d9e38e1846c157fadd9054c34680a
change-id: 20260730-b4-fit-ext-data-hardening-1734a9203753

Best regards,
--  
Anton Ivanov <anton@binarly.io>

