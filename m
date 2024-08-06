Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCD4C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F2B588AEA;
	Tue,  6 Aug 2024 14:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NlroBMLn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B815087EED; Tue,  6 Aug 2024 14:59:48 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D1BF88A9E
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3992195d08aso2351385ab.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949180; x=1723553980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZR7UgX2qt8ST4Z4LCV1N3X3ar35RmPZvU0cc3Le3PQk=;
 b=NlroBMLn+/M+SrgYNJ18kdOMtvVOVspTGET0IXJZuJOpLzcTaSCzTZxj9WTc6RDpuO
 7rlPOabKbyfk7fwj9OyGrANnYWYwf5KWYqwJxRUWOdo9tnrJqnikOmNsQlGwBHqI0TjQ
 kNtYEklBisGgmpu58E3txJdL7B6oZNyg47suo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949180; x=1723553980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZR7UgX2qt8ST4Z4LCV1N3X3ar35RmPZvU0cc3Le3PQk=;
 b=WQeEs8xBoEG7n4KW07KcGHovfe9+Wz6Rd/szroGygjTv7/sTD08yqfo4VmU3LlzIUJ
 BOBKyzxNvINHL0Oe2NRejS1cjRJQJBsGVqI1vsMrD/o3hnWuVbz5IcAdzO19DEe1BK2D
 c+8bJpJKQB8oL3/69lr37e+sY33X9EvGgnYCtkhM+bZhypj3GGvo64uz3IGUHdCV4Yh6
 K4zKE14R88lQXsvUBDIJDzh8Qb5Zm/6bCfJKfHB0vozYGnuP7alIdRAnJ6U70/Q+TStB
 9jsrlMJ6JB8Sx/pRC0dx0PMaixStSXrU42b3SbUnnvIyab7+coHjrx31KlNEoARlHR3V
 NaZw==
X-Gm-Message-State: AOJu0YymiihT92Jjq3uZFfrOYPok2fs9/rWceowWd4RvqPdzEhKY5g3J
 bWLFlfQDYfedlOLTBLw70pWuS1M+ry6DbXyPNI4Z7UdkcWKLacBzPWJoRFdpbtn5y28lBQHSeLY
 =
X-Google-Smtp-Source: AGHT+IEjvJfK1fV2oV66Z1AauMCC5N2E9CWFZJII3iSEBOvcCVD+YjWXTecLzg0UUPNt9yLVj4zNyg==
X-Received: by 2002:a05:6e02:3b04:b0:39b:34dd:43d1 with SMTP id
 e9e14a558f8ab-39b34dd4523mr107512275ab.22.1722949180483; 
 Tue, 06 Aug 2024 05:59:40 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 25/39] efi: Use puts() in cout so that console recording
 works
Date: Tue,  6 Aug 2024 06:58:36 -0600
Message-Id: <20240806125850.2316956-26-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

At present EFI output to the console uses fputs() which bypasses the
console-recording feature. This makes it impossible for tests to check
the output of an EFI app.

There doesn't seem to be any need to do this bypass, so adjust it to
simply use the puts() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes in v2:
- Fix 'use' typo

 lib/efi_loader/efi_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index c944c10b216..cea50c748aa 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -181,7 +181,7 @@ static efi_status_t EFIAPI efi_cout_output_string(
 	}
 	pos = buf;
 	utf16_utf8_strcpy(&pos, string);
-	fputs(stdout, buf);
+	puts(buf);
 	free(buf);
 
 	/*
-- 
2.34.1

