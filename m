Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D263AD6DDFA
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 13:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B6AA895E0;
	Fri, 15 Nov 2024 14:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OakAs9D6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 220B889348; Fri, 15 Nov 2024 14:48:23 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B32C988B6D
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 14:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3a745f6154bso3672095ab.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731678499; x=1732283299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3V2jkm3NxepBUZO8EC1kE96NHm/bQ8MEjkofeXXqXII=;
 b=OakAs9D6mMwM4ilRQCLj0K/3e4tUfP5j6AEcIg+gb632aBOb5iZF19wwh7p7CMWr0F
 AHXsrlJTTjZzV/+9EuzJ0YEufM9hVXIb5C3OGPQAI9KHfsRQhLeyvL6zVtV9CPyLcXJD
 F6DTOJd7FvPpWEXPit0np8tqQxuka0TxmP8sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731678499; x=1732283299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3V2jkm3NxepBUZO8EC1kE96NHm/bQ8MEjkofeXXqXII=;
 b=UKWzLb+rmJpnWubnjezPje/Mi857y1Ta2kMeyzSvhMB4Zq2XkrLhUmsa0mjX6gt2sf
 M0y5Arsgo6K3Hq3ibZB+dgdZH/2oXrMZpJP1BQGndYAe4bvK4kra4Kj/Rb5D+5PJRKMs
 rQfoPksc+UKVtsvBRlUD4p7sV357R9tR0RKJ8N4p9jojZNQcrbhGc7JDWEUZJZ7eOQfI
 9jqChIRH7zZxmJPYqKbUkfOLfSfbZojvIgO014lS4TOiBV6LPSkhKrTN0hl2z3uRCX0/
 NCyFxfKiDuJww8FOyseqpLPjBBDZN/IGF4UJLRCWWffd+Wts5du8CAIHwzb78tLDCtlJ
 qmBA==
X-Gm-Message-State: AOJu0YwFecAdTS0hFQjYwpksjX8QHBUgxg1a2PZNPoZSg7HegRTYnXcI
 KlHit2gbwYqrF18YiHMfoXdlK6bgpjECyJqgYuy/u2MoBl7t4UGRrwL3fuFDYHkfn2MUp+WF8Sk
 =
X-Google-Smtp-Source: AGHT+IGYmbPrR7rwtvFiqu7bnqvIdtMsgNUJfAcKBY+yibMMdl5liEhEWY+KDvCkTDg0jJ7CenFkZg==
X-Received: by 2002:a05:6602:13c1:b0:83a:a82b:f856 with SMTP id
 ca18e2360f4ac-83e6c0a935emr337818739f.3.1731678498946; 
 Fri, 15 Nov 2024 05:48:18 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e6df91554sm34118439f.9.2024.11.15.05.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 05:48:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 2/6] docker: Adjust packages for arm64
Date: Fri, 15 Nov 2024 06:48:03 -0700
Message-Id: <20241115134807.3068947-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115134807.3068947-1-sjg@chromium.org>
References: <20241115134807.3068947-1-sjg@chromium.org>
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

The package names are slightly different for arm64 and we don't seem to
have a linux-image-kvm package. Provide some extra ones for x86

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v3)

Changes in v3:
- Use grub-efi and linux-image-generic for both archs

Changes in v2:
- Swap order so that amd64 is the exception

 tools/docker/Dockerfile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 15e2a5c98d6..7389661c4c5 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -41,7 +41,10 @@ RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_
 RUN wget -O - https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz
 
 # Update and install things from apt now
-RUN apt-get update && apt-get install -y \
+RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
+		EXTRA_PACKAGES="grub-efi-ia32-bin libc6-i386"; \
+	fi; \
+	apt-get update && apt-get install -y \
 	automake \
 	autopoint \
 	bc \
@@ -67,13 +70,11 @@ RUN apt-get update && apt-get install -y \
 	gnu-efi \
 	gnutls-dev \
 	graphviz \
-	grub-efi-amd64-bin \
-	grub-efi-ia32-bin \
+	grub-efi \
 	help2man \
 	iasl \
 	imagemagick \
 	iputils-ping \
-	libc6-i386 \
 	libconfuse-dev \
 	libgit2-dev \
 	libjson-glib-dev \
@@ -91,7 +92,7 @@ RUN apt-get update && apt-get install -y \
 	libtool \
 	libudev-dev \
 	libusb-1.0-0-dev \
-	linux-image-kvm \
+	linux-image-generic \
 	lzma-alone \
 	lzop \
 	mount \
@@ -128,6 +129,7 @@ RUN apt-get update && apt-get install -y \
 	xilinx-bootgen \
 	xxd \
 	zip \
+	${EXTRA_PACKAGES} \
 	&& rm -rf /var/lib/apt/lists/*
 
 # Make kernels readable for libguestfs tools to work correctly
-- 
2.34.1

