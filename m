Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4E4C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 09:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DC5B83764;
	Thu, 24 Jul 2025 11:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I89Vb94q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E38883877; Thu, 24 Jul 2025 11:14:04 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 779F882B20
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 11:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so580853f8f.2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 02:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753348442; x=1753953242; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FjYbgNiRe9bC66Y1BF3TMNLyXsfXvVt8g1npUWHR+XQ=;
 b=I89Vb94qm0dRQc/myeBp1WFkxoDFxPygMxkUv4WmveJDv8ljgpEUvlRqCOMi59WLt9
 OsTte8cz/j5blu2SnxnKzTwWomFF2glxx+WjOabTqr3kE+6i7gFV3RyqksRUlROM1C6T
 rkYx3YDfhi2shYQlToiD2l1q7/WNGO3B2UhfkcjUCl6oxtR26wElEsiWnjgxba4mpfst
 n+WQkhQnmjRx77kZAxtSswLtNPVGMZUv6a3x527dudumkvY6PB3hJcH0+oQ4QRKQIAu4
 KIth9mz0pCtK47p39PB9mPVsZF9geo6BrMpzqZyY9jmGqaRafWwd0o9EnS8GrGIh9bew
 Gb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753348442; x=1753953242;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FjYbgNiRe9bC66Y1BF3TMNLyXsfXvVt8g1npUWHR+XQ=;
 b=iRnuIGNL/BlK1XFwa6EVScCx+5cR8i7jwVAarl4UbtX/QISEwIljqq633x5OnYd8ze
 NJW9L4KoGEA2I1omHviLpEEiOff63fhWKTFYM9tuKCbPZQgvmoBscHbXB2qcliBHRGJZ
 cnB0oImDh3QBb+FQkcHF8PP0pO84pMsUUoaT4IMVGruR03HGVKo0OV3OEuOuPPszanzN
 lWl/5l57mt/Kej86SzMgStvj3P5SvnEpjmTosa/kNmMuB7D5EwkhecVF46DYNHMRaOlS
 klp/gzD2Fq3+Keg9rVR8FJ4IENRBKvsVPTHyjza+LU1Iq1ymcO1ei/EJLyHPpAdOhTWu
 FwNA==
X-Gm-Message-State: AOJu0YyUrmeUmjZGjfyHAlX2z/wYO4iaBKi7EXYn+jr9fRQb3hHQuZN3
 kQWdEUbCWHlyTaXLqyT0Tdc+iacorXZ9oWwty8OI1qxTywBnoY9on+kreLdVeNSsSz+4Dkn9b+0
 +GBTsxsghyQ==
X-Gm-Gg: ASbGnctyyT7C7ZWKPUmrd5WWXea4yQyujN4yhpwugNt4dfcnzIoRjLZblhsmjQfaKxC
 8ADkrIWzMn0JIz2GHw4IAqfmjhCeQuTnN2DtVXceMViTET4mhD+c80LR7fQTso3a5k+416NGqVd
 3zwhTfWV6eMiS/ESYmw3xdmtWFTDcUYieWgcXQprEAUlMimhdDuyQUbyXUj8LyRPXX0SE7JM6bG
 KR+mLbk0xqqjmNeK+QwdP7tfGMFeTpDKJUd0QSIHZDdGhOIJUeQjdU0XlSm3RMW4Tdi5hTyyr5a
 IMDvFdrflnIBEHrJUw9cYGhDHke9XXjWLdRxcBeWiWSqgmSPHIvS9ea9Tzl9qF05lFweMxP/YnX
 8vyQ40+dW0dEyICV4+LMJKlhsTE8HcQ==
X-Google-Smtp-Source: AGHT+IE+lJqtri2hkUwRTBcp2kjffCWS54Cvu63lsW9oPRAMbxjqrT7NK9LTlKdbfUUOOCo8iUAsQg==
X-Received: by 2002:a05:6000:4211:b0:3a4:f7e3:c63c with SMTP id
 ffacd0b85a97d-3b768c57b33mr3953409f8f.0.1753348441570; 
 Thu, 24 Jul 2025 02:14:01 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bcf7:2df7:a82:bef9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586ec63d29sm15522595e9.1.2025.07.24.02.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 02:14:01 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Leonard Anderweit <l.anderweit@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 0/2] bintool fixes
Date: Thu, 24 Jul 2025 11:12:39 +0200
Message-ID: <20250724091342.59902-1-jerome.forissier@linaro.org>
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

Two small fixes for binman (bintool). The first patch avoids a warning,
the second one makes sure the APT package list is up-to-date when
running apt_install(). That one fixes a CI issue I encountered.

Changes in v3:
- Really use apt-get instead of apt

Changes in v2:
- Use apt-get instead of apt

Jerome Forissier (2):
  binman: bintool: use apt-get instead of apt
  binman: bintool: run 'apt-get update -y' on first invocation of
    apt_install()

 tools/binman/bintool.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.43.0

base-commit: 3532f1f5edfc97c9dcea723cdeb732eda44bc669
branch: bintool-apt-fixes
