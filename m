Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53496C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 12:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D94B88070C;
	Wed, 26 Mar 2025 13:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C9vb2f2/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76B7880BAA; Wed, 26 Mar 2025 13:24:15 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C62C806FC
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 13:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so70536795e9.3
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 05:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742991852; x=1743596652; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W8MMF45JRyDz3zkybfU3h5BnQB9InXzVQ/hfHAkcM7w=;
 b=C9vb2f2/Z9+ifXBzzv90w1pgKyBTnqSuF6dVMeNwPse4ybrZyXN0rvvUh2Xxa/CXu3
 YkP335aIGtHMPORNz5yh7qWWuuKkRvGnX4dSL4dHo9RJUHx9xLifW4IuUzebHL0PuBRt
 cWs5sMZNtNYTE1No25ncxD/f/HSggTTEut4usw+zYp+oqeNJR5Np4FwL3TT7G12R2eje
 7oZxD2krBxcbzfGvNOLy/4lmN7dX+YW60rCBsJPSjonHyK1zCeoTeJ1sElHSTb/4+EVn
 M0mTlHwvBfVlTM2mSDbFsX+M4v7xQTGu5zUhyRi6XCPQzyfYaRIkdaKiYXz33KXxJKIy
 2wEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742991852; x=1743596652;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W8MMF45JRyDz3zkybfU3h5BnQB9InXzVQ/hfHAkcM7w=;
 b=at0MCF8qoRjzzjGbZGG0+T7O0+mXAWd5KssrFTYsqVPCcsiEKU28xigs0AHv9InBp0
 Gj6sgtFKIAh/wqBQVk351u4Vz3zLYIaDHpVFjXHUVCV4C23DqT0UiQdjgAOSsoWOPm7u
 +9TkDD22gvdBCYR35H8BSA4MRHlG3a5rOQm2MJ/VDt+vpSWR3LfM86vH3/pQ+vkA7rUd
 I2zBaVtiWQoErlwLvu5FewUtSSfqIK8f2/sLKL28bS9+aHwllz5Fwf1KRhe7Qaq+Usvq
 dgGsmNEYUjw1uW/SZUPmvenARKd+bYEnvrJXrB2ujyr8JeNqaZvWMxV1Iej6x2UE0ijz
 Vtwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkPe0g6UFw/c/5e9HGJl7UehUz1CHFIIhHUxEKUQ2FMmZlJAnrJ5QUlATTTJI9LRPMafpLXE0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1sRVVsSCkUfoF9z7wrbuWXkux1Aq/YYOJRNJh4nEf5rqyUOy9
 6SfsVr+ZzD8y39PKB3CEfK/CF5mk4eNg7nK9ObQlZP1t6TLI4a8OsgJDe3qlTqE=
X-Gm-Gg: ASbGncsUJTKXe0nwjJQzxDvmVgAalwB1wr6NWay9id8MOIAO2N6dsiYJjoRnJEr81Vy
 E+0aHq2gvwd741+I9iKJkEVncnBhNWnWJrZ97T+8NGAXiVyt0fnWQ6VHmtjWN2tfoxDm8pbOLhh
 fU2iQ96QOpHZgTWNybW9kXhZbjbVYqUgaaPlc3jQz26mwYOL6ZzpY6l6fOLAnTeOBunAVRSjlxN
 AiVO0hRacKOe8oD5z9VjJ8k79809Rak7/P8cLFHMlb13p8RMNkqbfF50FX3A+0GN7cdJ1/G4wo5
 Xu8WkPCcw9Rff9pqNZN7XrlpfdPQdRl5CG+I367cHV/+i0hKmOS2u185Pak/wVUskVMv7rr7t4w
 uzthc7AgRNXbT
X-Google-Smtp-Source: AGHT+IEmQo1Y3sFTRPNv95NRUBuMp0/tYxm4AY/k2UvptOHGpR5SGatz3/7i2uJiU4DA0KUOURQ24A==
X-Received: by 2002:a05:600c:35ca:b0:43d:2230:300f with SMTP id
 5b1f17b1804b1-43d50870f21mr212761365e9.0.1742991852390; 
 Wed, 26 Mar 2025 05:24:12 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e65casm16923921f8f.69.2025.03.26.05.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 05:24:11 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 0/3] scsi: ensure writes are flushed to disk
Date: Wed, 26 Mar 2025 13:24:07 +0100
Message-Id: <20250326-scsi-sync-on-write-v2-0-12ab05bd464b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOfx42cC/32NQQ6CMBBFr2Jm7ZjSUjSuvIdhUeoAk5jWzBCUE
 O5u5QAu30v++ysoCZPC9bCC0MzKORWwxwPEMaSBkB+FwRrrjbMeNSqjLiliTvgWngjNpWticLa
 pux7K8CXU82eP3tvCI+uUZdk/5upn/+bmCg06f/YhVK62ZG5PTkHyKcsA7bZtX94PAW21AAAA
X-Change-ID: 20250325-scsi-sync-on-write-08b6ca3264bf
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1704;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=xZAYJJKgU1BtBP0ASl6mhmn++omHSOMkroXgqeJiA8A=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn4/HqkCGdIwIu+QK9Ye9sIeQORWsqt4F8zJPGQ
 CSbAPidlmmJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+Px6gAKCRAFgzErGV9k
 tn1wEACgM7cZ7OTQpTCMcwQef5XSbYwvW/29cydAY9WXT+AANBQQ2RDrXcPgVXTcZ/5qDW/muWT
 tjXRKGPJrUs5dzqL8hzlJobMO1VPaaiEIhs9S9bPnipMuHeQiixHGMfirUWGm0b7xegEymhhV5U
 CEt5FfKPMTzaOmzX2ic1G9YcHW2XKQz6DNeZuOqQ+bu4SzOAT6qYB07ivnmOoYIcLoNUuFS4yg+
 P1QgAycWm8mYqegKapnSvw1xZ1VdGD975S7Iy3W2ZVLzyD81DPwTYMHuu8erBPHqgWqlkzebBJY
 o9tEYU4xU71kdwGU3bnCLHbSf11nqKStSRpRdCVeotFxg4wZcJTHEtCJjaVC9Iv9HsjKPXlNa0A
 MhWHLfdB2myqTAnL95jnZGNloX4PrzEmwi/bwnnCsVsObbBN3aTr+EU+zGPlC+z2NmVP3v5fFRU
 ggcmwlYi10lbV9GefHobjYExtOp3TFpUMzOctfCRwnk6oWX3+0JJp84all4JI7X1HQc8r1DSWaP
 Cg2bcVRQ+mbHIF9P9kp6zbl3t6z3EzFqzAJNFlvdOxT+0juorCcnh6xP6VoNLd28d5bWG/4JtSr
 Uyx69BypfRuLmMJ3eueANmgcNfhOxhcwW38slZbvVxqJZDPkllgt7tXTxNxUL3vz+iuA9WbhK1r
 LADRX0DBgfTdBZg==
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

SCSI devices like UFS may maintain their own cache to speed up writes,
however this is lost on board reset (and may be lost on device removal
or reset by OS drivers).

Currently this can be worked around by "waiting for a while" after
writing data to disk, but of course this is not an acceptable solution.

Ideally U-Boot would have a mechanism to flush caches during board
reset, but until that logic is hooked up let's be sure that all writes
are actually propagated to the storage device so that we don't lose data
on board reset.

The same logic was already implemented just for the AHCI backend, this
duplicated logic has been removed and support for the SYNC_CACHE command
is added to AHCI.

This is particularly noticeable during capsule updates, since the update
file is deleted and the board is reset immediately afterwards which
resulted in the same capsule update being applied over and over again.

This specifically fixes Qualcomm SDM845 devices with UFS 2.1, but likely
all UFS devices that use a cache.

---
Changes in v2:
- Only issue the SYNC_CACHE command once for the whole write (thanks
  Neil)
- De-duplicate AHCI which also implemented the same logic.
- Link to v1: https://lore.kernel.org/r/20250325-scsi-sync-on-write-v1-0-3575aa1342e0@linaro.org

---
Caleb Connolly (3):
      scsi: fix typo in setup_read_ext()
      scsi: sync cache on write
      ata: ahci: implement SCSI_SYNC_CACHE

 drivers/ata/ahci.c  | 14 +++-----------
 drivers/scsi/scsi.c | 25 ++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 12 deletions(-)
---
base-commit: a383b9bd4d7e430fe7c254297540bae596649dba

Caleb Connolly <caleb.connolly@linaro.org>

