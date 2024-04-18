Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9D7C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 12:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ED7A88553;
	Thu, 18 Apr 2024 14:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BHEfaUgV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B7D58831A; Thu, 18 Apr 2024 14:55:04 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EEFD88609
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 14:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a5224dfa9adso153007666b.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 05:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713444901; x=1714049701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/i5Gmnyf6MEJMGR4G17Ai/gv4bXGzU/rZcS3d6SytfQ=;
 b=BHEfaUgVo2rvSxiMpGInvZJ65q18cOtoNJq0Cq0mgy/sLSOfptiBuEX5XFcTEJyBHR
 4VcJREWVtJ5oJZmiA9KuVtOsCS5uMB2w9dyuIGNdMZi6X5y2FRmUpiXELyIdb1iJtGu8
 5nie8rSJqZ6qEpZkZOv2jVDDFRHA4XOFsK+hB8HZJ5NlW5L/qhIuyCQBZQIDK7o8Kcfb
 pRCB7NU/M6f88Z03sMOMH/kgMbPcxW1CKx8Lq+qpjDN1nCQERkcCC2OQsnZM50O83J8o
 kF8BCwkxTgsQTAxh5xIgmi8zDunEk+sbq+dzoYGPWJz0aMxmpPmZ6QyvqvM1FWX+z6ot
 2opA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713444901; x=1714049701;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/i5Gmnyf6MEJMGR4G17Ai/gv4bXGzU/rZcS3d6SytfQ=;
 b=sCYvdqkAtT5rWSRimqnD4D9JOVcfiLEmMHPGKO8FdLrSYCYn1HK2aiWW2fqNUOVobT
 YvaSCcEShPG7xTwPZgYYqEkOt6wSnd4sVUAiHF+PsgwMuI6cKazA8QmyY8OPpK/urwqe
 FZHxQ8z566h5Im+xk47LHN+epjVRWPtvBgZp7n/nXGiLUj7pv/e5t+BQvqnqitanZ/E5
 /o/FlLWtv3218F16lBZsLFLW/3tqh3s/+ZqOga40O7hmz3tfdV/fAlLcUXyzvKcSlWRr
 0pO63X0CN3AIWPSUsiPWawexRb78Ggs8kLRK9YPvUUhp9+sp51WvRLmPxvurMc6vtkMG
 TYEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrINKxEeZ+D5nzvs0Ng3PoEUE+efr9hlQLyoRY+8cSMqb6eSym1wcPQpJ1ZQV7i9rEoy/9dCmUWWYXuldVvxyfwSGGnw==
X-Gm-Message-State: AOJu0YwbRVUkQEqaWcW/IzIYfGidHOgNh4s7cfGjb6r1CX2l2Eygq0Vr
 N5KITnJXNXis4cyx8ejvRc6gg+8ZZJ0kYwPCzRBZ5hSdIkgfIzL7dZnIQz4Ek68=
X-Google-Smtp-Source: AGHT+IFgeAUqw+UehhGAsGQ70KLIwok2R6mHyXdEOXFk6nN8ceyIV22E8YmBa8v5W+u7RaVF1hDVfg==
X-Received: by 2002:a17:906:d8d7:b0:a55:75ff:ea12 with SMTP id
 re23-20020a170906d8d700b00a5575ffea12mr1153191ejb.4.1713444900999; 
 Thu, 18 Apr 2024 05:55:00 -0700 (PDT)
Received: from hades.. (ppp176092141112.access.hol.gr. [176.92.141.112])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a1709060d8b00b00a525a18f748sm847002eji.165.2024.04.18.05.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 05:55:00 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	kettenis@openbsd.org
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Simon Glass <sjg@chromium.org>, Janne Grunau <j@jannau.net>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v3 0/4]
Date: Thu, 18 Apr 2024 15:54:49 +0300
Message-Id: <20240418125456.50944-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
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

Hi!
This is v3 of SetVariable at runtime [0]

Nothing changed drastically from v2.
A few more test cases have been added, comments/suggestions have been
addressed and a bug where deleting a variable by setting 'attributes' to
0 has been fixed.

Changes since v2:
- Add more selftests checking for variable deletion as well as the
  VarToFile header format
- Use unaligned sized variables on tests
- Add a new function to get the variable entry length instead of
  repurposing efi_var_mem_compare()
- Converted VarToFile to RO
- Added a few comments requested by Heinrich
- Fixed a bug where SetVariable with attributes set to 0 did not delete
  the variable but returned EFI_INVALID_PARAMETER instead
- Run FWTS 'uefitests' and attach the log in patch #1
- Added r-b tags from Heinrich

Changes since v1:
- Instead of Creating VarToFile at SetVariable, create it on GetVariable.
  This allows us to get rid of the preallocated RT buffer, since the
  address is user provided
- convert Set/GetVariableRT -> Set/GetVariable at runtime
- return EFI_INVALID_PARAM is NV is not set at runtime
- Heinrich sent me the efi_var_collect_mem() variant

Changes since the RFC:
- Return EFI_INVALID_PARAM if attributes are not volatile
- Add EFI_WRITE_PROTECTED checks for BS, RT *only* variables
- Add 2 EFI variables and allow userspace to write the file
- Add selftests

I also have a patch enable QueryVariableInfo [1], but I don't want to
introduce new patches now. This also needs a few more testcases of its
own so I'll send it once we finalize this one.

[0] https://lore.kernel.org/u-boot/20240417101928.119115-1-ilias.apalodimas@linaro.org/T/
[1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/commit/ce35270aaeb93686d7e013f3b028808e8af88cc0

Regards
/Ilias

Ilias Apalodimas (4):
  efi_loader: conditionally enable SetvariableRT
  efi_loader: Add OS notifications for SetVariable at runtime
  efi_loader: add an EFI variable with the file contents
  efi_selftest: add tests for setvariableRT

 include/efi_loader.h                          |   4 +
 include/efi_variable.h                        |  16 +-
 lib/charset.c                                 |   2 +-
 lib/efi_loader/Kconfig                        |  16 ++
 lib/efi_loader/efi_runtime.c                  |  42 ++++
 lib/efi_loader/efi_var_common.c               |   6 +-
 lib/efi_loader/efi_var_mem.c                  | 151 ++++++++-----
 lib/efi_loader/efi_variable.c                 | 122 ++++++++--
 lib/efi_loader/efi_variable_tee.c             |   5 -
 .../efi_selftest_variables_runtime.c          | 211 +++++++++++++++++-
 10 files changed, 495 insertions(+), 80 deletions(-)

--
2.40.1

