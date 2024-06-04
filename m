Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F672C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 15:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B5C18849A;
	Tue,  4 Jun 2024 17:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l7HWAFhJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4E3C884BF; Tue,  4 Jun 2024 17:15:34 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8299888418
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 17:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-35dc1d8867eso4917588f8f.0
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 08:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717514132; x=1718118932;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rVre6IRaYxZIPxEsG5UTtZsMTnuNVxjYjMWqfEkQNRk=;
 b=l7HWAFhJ2t1zRawl/PQBg7YY62SWy9tVS8qPXK3OWaSt6gfoH72AUMtbWhqbNVBRcf
 M5ceq7O2XV/2qLa84lU1KAtE5wp8yL2bL6HLCQASLw05JoU2LTY0wEIZFAIrdIafAIFh
 y1OQTd0OhFTm1XD6JX/qTsJNr6uOGsYocDsPgxpc34+FNHHman+yB4dq2ObjLi5J/dC5
 eiCmaBQfGIfldMJu7xIsmTQfrwwKlUKmAmCxIw3pju230hyu6HHLqF3GpBmcSYtQ2uud
 yFvDsdVNzB+xEEn06EYVYgrIdAYBUOb/4VfU+Kp6qwUFt999DXdp9WCiSRga96bx0Qqs
 sYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717514132; x=1718118932;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rVre6IRaYxZIPxEsG5UTtZsMTnuNVxjYjMWqfEkQNRk=;
 b=ho1rWEHNJcgtBDC27jxMdZDUXdGtn2086uk2gxZZRqTSCr0fuwfOD3brH5ARcPLDjo
 iX4pJCy7d23nlamxj9Xshbu6oqHxfaYfn6Gto9yqFLL3bifRKCSi7ZACngXautqRNN2w
 qQ8Ah3JDy6qa9PglEuFMPRPKuU/rzEx2KA3jSLP/SIT9Il2rY+zlE4TwROOkb4SZsS/B
 wtT8v0v+L0Nm3t4Bx4lnWtICSEUr3gpAjmOIuaaGsUopNGPVrXoV36RUlje8aCLhmTmC
 9/QcH4ct+HOw/no8uSMfRqzlejPFc6EZhCYyqA4Dp+5cD38bviRi+fUAgG/lL90MfbnV
 G/Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcnKfzBt6IS48QAo/+OaoIK5kokfLMxKo9vRDPcVy2RBcYNkxfdwIKDYCV+2QbjdXkEjxWgXgsFKNIg99KBOhql+KClA==
X-Gm-Message-State: AOJu0YyKZkyZ5qmSMZPKK8nbrbwzXdQWuKeULeBlRYKfCPLXXFZGq6DO
 GjnVaXnM2ZpIbvPnmAZOLE4ltI3EubMCBYqt1YFuyRmGRb4mrsMCRCL91NBZpCQ=
X-Google-Smtp-Source: AGHT+IGsrVuzzazkszLk23ROkDdpCqgALL9fj2an+dAUv9tyPyd6oliI45/nck/sT+ZrCLocmQDaow==
X-Received: by 2002:a5d:6e5e:0:b0:354:faf4:fa87 with SMTP id
 ffacd0b85a97d-35e0f2590e5mr6840837f8f.3.1717514131806; 
 Tue, 04 Jun 2024 08:15:31 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c0e84sm11891775f8f.13.2024.06.04.08.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 08:15:31 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 0/2] bootstd: Fix a handful of doc typos in bootmeth
Date: Tue, 04 Jun 2024 17:15:20 +0200
Message-Id: <20240604-bootmeth-typos-v2-0-821683a95aaf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIgvX2YC/3XMQQ7CIBCF4as0sxYDFal25T1MFwWmMoktDRAia
 Xp3sXuX/0vet0HEQBihbzYImCmSX2q0pwaMG5cXMrK1oeWt5IpfmPY+zZgcS2X1kcnO3NQVO27
 MBPW0Bpzoc4DPobajmHwoh5/Fb/1LZcEEU2i11VLdp8489FjepAOejZ9h2Pf9C35TRUKvAAAA
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Mario Six <mario.six@gdsys.cc>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev-d4707
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

While working on bootflow, we noticed some wording inconsistencies with
bootmeth versus bootmethod.

According to [1], we should use bootmeth(s), not bootmethod(s):

"""
For version 2, a new naming scheme is used as above:

    - bootdev is used instead of bootdevice, because 'device' is overused,
        is everywhere in U-Boot, can be confused with udevice
    - bootmeth - because 'method' is too vanilla, appears 1300 times in
        U-Boot
"""

[1] c.f. https://lore.kernel.org/u-boot/20211023232635.9195-1-sjg@chromium.org/

First patch fixes some trivial typos, second patch replaces all
occurences of bootmethod(s) -> bootmeth(s).

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
Changes in v2:
- Made into a series
- New patch replaces all bootmethod(s) -> bootmeth(s)
- Link to v1: https://lore.kernel.org/r/20240603-bootmeth-typos-v1-1-6edbdb469f7c@baylibre.com

---
Mattijs Korpershoek (2):
      bootstd: Fix a handful of doc typos in bootmeth
      bootstd: Replace bootmethod(s) -> bootmeth(s)

 board/sandbox/sandbox.env |  2 +-
 boot/bootmeth-uclass.c    |  2 +-
 include/bootmeth.h        | 42 +++++++++++++++++++++---------------------
 include/extlinux.h        |  2 +-
 test/boot/bootflow.c      |  2 +-
 test/boot/bootmeth.c      |  6 +++---
 6 files changed, 28 insertions(+), 28 deletions(-)
---
base-commit: ea722aa5eb33740ae77e8816aeb72b385e621cd0
change-id: 20240603-bootmeth-typos-47c865e70ccf

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

