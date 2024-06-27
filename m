Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD50C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 09:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D44B8852C;
	Thu, 27 Jun 2024 11:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ldjbFs/B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53399884FD; Thu, 27 Jun 2024 11:19:34 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72841883E0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 11:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3651ee582cfso4156379f8f.2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 02:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719479972; x=1720084772; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DwbEmlb7j97i9Q+0Gkqlcn3kq0fvAKIR9SwwmRHzEg=;
 b=ldjbFs/BxoRESwS0/hmPtHXsHPJY1WpQEFkkS/G03Tei046F7fMr6l3c/u8iiu1BTG
 rdHALurys3rS7o9NmGUjsXD7EuET9fd5xZsNriYqeWzcCD1/WFK4eCQvEpWuRTLcWvLB
 XjdbN2lf+yZ7Y37i2tPcYu6RwBG1tJnkjIwdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719479972; x=1720084772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1DwbEmlb7j97i9Q+0Gkqlcn3kq0fvAKIR9SwwmRHzEg=;
 b=mLD6QvlPLYQ13YdIYXu4d/1PUv2ar6ZuS9JHnuoKFbC/PMGWAI1uZxc1pi1VCZf+vO
 oZMiI36/gql9nW40Ncx8x9Vrawr6gQvC2h7iXQmOPae4s93v2rwuBpKwd2GrQuPdoFF6
 +3+ZmVQnJ61AW8a2f59m/NHb8L0EO8W3RR5hKtvNiZ8QavJ7O1G7uSU9xEekTk7vmhp1
 ewrGSBEl1c6eCMxIqRSZ3OmhEYaTzuq7YdrFIzlvGjTrG3pi92Df8mdY0Mn+8B5EGsku
 362QeQ6Rhe+53QR3RHvrSXhU0d2JV7wRZ81W3PJldcdPcU6Ha5Ps1NSpn435T1yMi97R
 kpuw==
X-Gm-Message-State: AOJu0YxCeDny/IC8hGWGj78jrZICayOIfQK/j/0XWr+LX6AKOo6qG/s/
 pYj/uM7Ww/LePuEDNdTPjOj2wbUXeh8GTZxtVaD/Jhqesj9q2wYXQplK0W5+VfrAqLrEZ7cnNWB
 86Q==
X-Google-Smtp-Source: AGHT+IGdnjhSyjGrPE2gpPBpT5fmyt5KrE1ELAtYCGGrnA26f+XLBR+BjKYka0LH4OSPZ52RRa8HaQ==
X-Received: by 2002:a5d:4712:0:b0:362:6908:e2dc with SMTP id
 ffacd0b85a97d-366e94cbfa2mr8346164f8f.33.1719479971713; 
 Thu, 27 Jun 2024 02:19:31 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367436a28f7sm1199818f8f.117.2024.06.27.02.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 02:19:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 1/8] mkeficapsule: Add a --version argument
Date: Thu, 27 Jun 2024 10:19:19 +0100
Message-Id: <20240627091926.374633-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627091926.374633-1-sjg@chromium.org>
References: <20240627091926.374633-1-sjg@chromium.org>
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

Tools should have an option to obtain the version, so add this to the
mkeficapsule tool.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/mkeficapsule.1   | 4 ++++
 tools/mkeficapsule.c | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/doc/mkeficapsule.1 b/doc/mkeficapsule.1
index c4c2057d5c7..c3d0f21488a 100644
--- a/doc/mkeficapsule.1
+++ b/doc/mkeficapsule.1
@@ -87,6 +87,10 @@ Generate a firmware revert empty capsule
 .BI "-o\fR,\fB --capoemflag "
 Capsule OEM flag, value between 0x0000 to 0xffff
 
+.TP
+.BR -V ", " --version
+Print version information and exit.
+
 .TP
 .BR -h ", " --help
 Print a help message
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index 6a261ff549d..c112ae2de8d 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -21,6 +21,8 @@
 #include <gnutls/pkcs7.h>
 #include <gnutls/abstract.h>
 
+#include <version.h>
+
 #include "eficapsule.h"
 
 static const char *tool_name = "mkeficapsule";
@@ -28,7 +30,7 @@ static const char *tool_name = "mkeficapsule";
 efi_guid_t efi_guid_fm_capsule = EFI_FIRMWARE_MANAGEMENT_CAPSULE_ID_GUID;
 efi_guid_t efi_guid_cert_type_pkcs7 = EFI_CERT_TYPE_PKCS7_GUID;
 
-static const char *opts_short = "g:i:I:v:p:c:m:o:dhARD";
+static const char *opts_short = "g:i:I:v:p:c:m:o:dhARDV";
 
 enum {
 	CAPSULE_NORMAL_BLOB = 0,
@@ -70,6 +72,7 @@ static void print_usage(void)
 		"\t-R, --fw-revert  firmware revert capsule, takes no GUID, no image blob\n"
 		"\t-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff\n"
 		"\t-D, --dump-capsule          dump the contents of the capsule headers\n"
+		"\t-V, --version               show version number\n"
 		"\t-h, --help                  print a help message\n",
 		tool_name);
 }
@@ -969,6 +972,9 @@ int main(int argc, char **argv)
 		case 'D':
 			capsule_dump = true;
 			break;
+		case 'V':
+			printf("mkeficapsule version %s\n", PLAIN_VERSION);
+			exit(EXIT_SUCCESS);
 		default:
 			print_usage();
 			exit(EXIT_SUCCESS);
-- 
2.34.1

