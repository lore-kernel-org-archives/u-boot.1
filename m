Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0BECA0FFE
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 23:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE4BB83775;
	Sat, 30 Aug 2025 01:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XeaNJQTc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5998C83768; Sat, 30 Aug 2025 01:39:57 +0200 (CEST)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C8EA83106
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 01:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-5290c67854eso1322810137.3
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 16:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756510793; x=1757115593; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=dh09saUVzdFhGf62KuI7wkSH+Mj3Bbl+Q0ITEZagMhM=;
 b=XeaNJQTcpRi/7cKLMa1y7qqu5ComRRYJ2SQS+tHU1YKn2ow9NN8X+Blqb42RoPCp8x
 V71dhMSaHtWbAwEyKZ7DVqNlxnNXdLzvDNrgQ/bXrXKes7dQHDN+QCIAmINWahPWOq0e
 vvK/Da5RMjjFEyCHy8SNwmmYNjG0v2HslB1SJUSLojzQQn0qjzsiA0RHjz78EytZ8/N7
 kJOLyEY5bD3mLXoNLyn4bN+QfkOhHsQqhsx0gNgDrzytq1Dp8E6wgnCP/H4Q+IJJfVTm
 icmB0wP4l7LnFk4NbtrEtphkNOWzK3YcWmLupM+nuAbSmw+uZQ5z2bdahFKlPYdhnHDR
 sutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756510793; x=1757115593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dh09saUVzdFhGf62KuI7wkSH+Mj3Bbl+Q0ITEZagMhM=;
 b=o0ZhK0oLUvnJnzYAulriSmvfpIefon/p0fhutSTlewX5fqpk75YkBquTDC+xX2P79c
 1uPgdVvEBGKkulGeVj+5skx4FFNnmlPpU4GuEHlGh4qpxsgNSPGXMah5k8GVUADbtIST
 rq0Xzy7oPVj7sEFKT2Ucq0SPx9r6mkbKeyIcUhee0jKitFtHavZfz86hR693Csk+ecFC
 za8giBmnFql3JZg0Ro3ZlhSfl/+USaMare65+2e+pEwo/XU27V/MurwEdKZdb55bq9hM
 Wg/4ecns52nJ4G1axzl0PsvYEL2aP7RYSNOSTcmOqN/5Mbr+atsvXIbAoCdxXLHOKfNY
 sF1g==
X-Gm-Message-State: AOJu0Yy5fIahzCsGurt6GCjeUzOCrRiAqHRejlhSdssnf9fRMhfT1tua
 TsRCAO/bBOYmMtreq+kvVfsw3iQ+jKZOscdkVaAgyc+I5/AsUYP44eTttuUDl1zgYLEE7L7W8N9
 vgnfl
X-Gm-Gg: ASbGncvqY52OWid751qptqkdst+iIdMN61YUT2Bwiu3NAvYdPtRvYO4QB0Ae+qKIoCF
 mSBlvHDSHKyR8/CwURVArSgPnlxtFysZE+4RGklYLPUEEq7wmjrqsByF71B/MAZ1mXNeaG0I737
 5/1fmObYVrZg2no2YFH9Yc6wPpFvKX5A/H4po5Nm2eOWwW37VTbPBS658fAgNXhEPeI3unhxmAh
 cdTAxVq8b5cWCDZZ++lknlWckGwsJr3IRbIbY5WeDs3n5mJaoxLAqBYx/X6o4BBOtyDZC8duUZz
 w8UnLyO5tHNjnZAACmUX4glO6pI83knSfJGfVXKOv1hl7/2YHOyXp02U940fDsBBxlWhVayykfw
 uqkVr3t1YXNMklKi8OMPgq4iQrRnOF6QKEYRnuCbR5V7Fz1R0
X-Google-Smtp-Source: AGHT+IG7HLgDMgk60o2XTrMhzS0gElp3KAGLvTc1FecD8D8vUQGEJFtHPmlOc/5xRQJvQCXzEkiZhg==
X-Received: by 2002:a05:6102:3053:b0:525:9f17:9e55 with SMTP id
 ada2fe7eead31-52b1c558571mr106780137.32.1756510792851; 
 Fri, 29 Aug 2025 16:39:52 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-8943bb744fasm1360819241.15.2025.08.29.16.39.52
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 16:39:52 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de
Subject: [PATCH v1 0/4] Modernize U-Boot code formatting with clang-format
Date: Fri, 29 Aug 2025 17:39:45 -0600
Message-ID: <20250829233951.547352-1-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset="utf-8"
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

This patch series modernizes U-Boot's code formatting infrastructure by
transitioning from the legacy scripts/Lindent tool to clang-format, aligning
with current Linux kernel practices and providing a more robust and
comprehensive formatting solution.

Changes in v1:
- Removal of the obsolete scripts/Lindent wrapper
- Documentation updates for the coding style guide
- Migration of existing tools to use clang-format
- Copy .clang-format from Linux kernel v6.16 tag

v0 link: https://lore.kernel.org/u-boot/20250829190058.GY124814@bill-the-cat/

Javier Tia (4):
  clang-format: Add configuration file
  Lindent: Remove wrapper around indent tool
  doc: Update U-Boot coding style guide with clang-format usage
  tools: zynqmp_psu_init_minimize.sh: Switch to clang-format

 .clang-format                     | 804 ++++++++++++++++++++++++++++++
 .gitignore                        |   1 +
 doc/develop/codingstyle.rst       |  40 +-
 scripts/Lindent                   |  18 -
 tools/zynqmp_psu_init_minimize.sh |   2 +-
 5 files changed, 844 insertions(+), 21 deletions(-)
 create mode 100644 .clang-format
 delete mode 100755 scripts/Lindent

-- 
2.51.0

