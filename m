Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEB6C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 241DA8118B;
	Thu, 27 Feb 2025 17:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KnvrVkBF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FFC081115; Thu, 27 Feb 2025 17:09:32 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9159810F5
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:09:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-439ac3216dcso8377945e9.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740672568; x=1741277368; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AUTFTMtQY5Y4pkpoYi9iWnyUxPpZ04akN1jjL4yxe9A=;
 b=KnvrVkBFMXlE/FykRU13IPXuxnnbmgsDMWJSWuKu4yBWZeRw7Q5CcNtRfL3g+TAn0t
 qxoH9Y2iCknK/aQhV7VqdHhrllgIoh+5VSQy3WSylGbf3V/a7dS+LlLptE3eIKbBCBMB
 8R7YJeZl7+5gM3gPvSHPBceE8NhPMfbeqnvmy0rDd4B1C2W7harB/f94u47mxBKlRVJS
 Atxm7P95W/u4Qbdrgc5C0EQia+IMyxtWWv+ipBbwJHq6uE8XQxTLwXwNKk423hp8SXu/
 gXHEdqy6cFfJwpeXYo4UtoibNL9o2Et3ElJzzO3bnS6i+r22mpLmFKRi4Y1eFGBJhhVJ
 NLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740672568; x=1741277368;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AUTFTMtQY5Y4pkpoYi9iWnyUxPpZ04akN1jjL4yxe9A=;
 b=UT9iCb0rLObnzI9z/fEfjo55VrMgO9krbgJ5yENbs+cPQ6b5s/LrP3iaLsSunoVKhs
 Jv/2I0aWRrZylAhxjUvXgZGnrV/i7GgANuoiiye4oPjmtqRJXHPvl0AfQqSGXMIlBk7w
 QKka+4wwiIJezS9DYsDK5DqKrdRLumiASSq4jx/zU0XzFp2Fa6T+teJSjAfpxHo8JDVb
 gTjiOcmUupwMFocUPgo11NcLJOXxhQ34XeEz6U2VeTUF+gcHhbx97g94hLaRv+ZcyL2N
 wBWp4iYP7o+365bBen/aypU5MFUbXkevonqvP8ScNvhcntIwf5OJcS5zGk68Gba5ARiY
 UyoA==
X-Gm-Message-State: AOJu0YweMPxyY5v5Giuq+mSOZ6d2fUocyFdm39Ceavw6rd4RRIFHWHk3
 J5TpeTcfU6p1xhMi6qAtPpkwoxUf7Xqh6Ea6j6MN2GNJNIzP6R9Kuj+ybb1aLhNKjZ0QkYFW2qy
 WKeg=
X-Gm-Gg: ASbGncslMSfPqhk8BcT8Clj+8iX3yt4ox/ud+taXkxV7nYwdQUQhe6kM1uwvlbsUT0X
 w6DxZpx06Eho093UcP6iCnCoOmDeiVcON9IPGjRPrTpEKQC98AzbDvX+isY6I/CNa98PPbjWZ75
 26Y2NvrIAqY0NHSyUiXCa2qXBQGr0zvtpKClCsuqQgeQGkuSevMMtixxJQhI09EgHpwfivq30ga
 lmlG6oTJntCCrFtIN7mLx58m5tfgvvGWA2naMDU1acJKO3dYc+iZ7LjxOEup8eUPpkxWu/xe3vi
 De0i6oO0oW9Xh4QRsBYijbbX8ARMQAw3Pe8=
X-Google-Smtp-Source: AGHT+IFQp71huDnDH7B1DINfZaLytrZjYItZwpN3idfIWOOACCo/jBCD3qs9jBmqK4dWN8oN0VM3nA==
X-Received: by 2002:a05:600c:4fcf:b0:439:5a37:8157 with SMTP id
 5b1f17b1804b1-439aebf3613mr259797175e9.30.1740672568016; 
 Thu, 27 Feb 2025 08:09:28 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba52b925sm59506795e9.7.2025.02.27.08.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 08:09:27 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH 0/5] net: lwip: root certificates
Date: Thu, 27 Feb 2025 17:09:00 +0100
Message-ID: <cover.1740672437.git.jerome.forissier@linaro.org>
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

This series adds support for HTTP server authentication using root (CA)
certificates.

As a first step, the wget command is extended to support a sub-command:
cacert <addr> <size>. The memory region shall contain the CA
certificates. With this, it is possible to load the certificates from
storage or get them from the network for example, which is convenient
for testing at least. The Kconfig symbol for this feature is
WGET_CACERT=y.

Then new Kconfig symbols are added to support providing the certificates
at build time, as a DER or PEM encoded X509 collection:
WGET_BUILTIN_CACERT=y and WGET_BUILTIN_CACERT_PATH=<some path>.
Note that PEM support requires MBEDTLS_LIB_X509_PEM=y (for the cacert
command as well as for the builtin way).

Here is a complete example (showing only the relevant output from the
various commands):

 make qemu_arm64_lwip_defconfig
 wget https://curl.se/ca/cacert.pem
 echo CONFIG_WGET_BUILTIN_CACERT=y >>.config
 echo CONFIG_WGET_BUILTIN_CACERT_PATH=cacert.pem >>.config
 make olddefconfig
 make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
 qemu-system-aarch64 -M virt -nographic -cpu max \
        -object rng-random,id=rng0,filename=/dev/urandom \
        -device virtio-rng-pci,rng=rng0 -bios u-boot.bin
 => dhcp
 # HTTPS transfer using the builtin CA certificates
 => wget https://www.google.com/
 18724 bytes transferred in 15 ms (1.2 MiB/s)
 # Disable certificate validation
 => wget cacert 0 0
 # Unsafe HTTPS transfer
 => wget https://www.google.com/
 WARNING: no CA certificates, HTTPS connections not authenticated
 16570 bytes transferred in 15 ms (1.1 MiB/s)
 # Dowload and apply CA certificates from the net
 => wget https://curl.se/ca/cacert.pem
 WARNING: no CA certificates, HTTPS connections not authenticated
 ##
 233263 bytes transferred in 61 ms (3.6 MiB/s)
 => wget cacert $fileaddr $filesize
 # Now HTTPS is authenticated against the new CA
 => wget https://www.google.com/
 18743 bytes transferred in 14 ms (1.3 MiB/s)
 # Drop the certificates again...
 => wget cacert 0 0
 # Check that transfer is not secure
 => wget https://www.google.com/
 WARNING: no CA certificates, HTTPS connections not authenticated
 # Restore the builtin CA
 => wget cacert builtin
 # No more WARNING
 => wget https://www.google.com/
 18738 bytes transferred in 15 ms (1.2 MiB/s)

Jerome Forissier (5):
  net: lwip: extend wget to support CA (root) certificates
  lwip: tls: enforce checking of server certificates based on CA
    availability
  lwip: tls: warn when no CA exists amd log certificate validation
    errors
  net: lwip: add support for built-in root certificates
  configs: qemu_arm64_lwip_defconfig: enable WGET_CACERT and
    MBEDTLS_LIB_X509_PEM

 cmd/Kconfig                                   | 29 ++++++
 cmd/net-lwip.c                                | 19 +++-
 configs/qemu_arm64_lwip_defconfig             |  2 +
 .../src/apps/altcp_tls/altcp_tls_mbedtls.c    |  9 +-
 .../lwip/apps/altcp_tls_mbedtls_opts.h        |  6 --
 lib/mbedtls/Makefile                          |  3 +
 lib/mbedtls/mbedtls_def_config.h              |  5 ++
 net/lwip/Makefile                             |  6 ++
 net/lwip/wget.c                               | 90 ++++++++++++++++++-
 9 files changed, 158 insertions(+), 11 deletions(-)

-- 
2.43.0

