Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DC9C83F04
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 14:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93E7980E9A;
	Wed,  2 Jul 2025 16:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC7980E9A; Wed,  2 Jul 2025 15:34:12 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEC5F800D7
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 15:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-6fafdd322d3so49681776d6.3
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 06:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751463249; x=1752068049;
 h=subject:message-id:date:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nAWL3JH4oPpqkfD3pM01gIvNSHpOUJtpOSSC9bR/Yfw=;
 b=QxIAhCVFwWu1+QEvDl87qKKHS4XBnGQQY1T9IGEJ5/O3k4WWPR9Q+MKG4k/fO5sF9g
 MTrjzqdlpqzN2hTf98RsS5t/L1HUKM4L4+gvLqX95fFmiOfigkzwMEvlpBcdjm9y063t
 fJ6SJNq9P/5d34dTIYVeX4gAK2UbwBoh9cSUcIdEl0bZDrK12TgAqzN7+U92oHa8J+Ne
 F+U2nhZR13ZENrsd8c61QCbXajOjbtFkgSovLLR1mrCy4e0Km6EC0warDT57zc1uThRj
 nts1KXlhdCokPbCSZZCqSA+qFiKGYKH5UHyUvYGyRsE9l8lxELOgUtjt37mt0vxk4ABf
 iCjQ==
X-Gm-Message-State: AOJu0Yx9wkUMrbYf/5ibXltghvkANjQQJHxoN8s/nrSztUbYiA5vXn5P
 kbFr4ikGPdkoLynuUF5qRyo66zY3cot+iYlrZsar5JDydOtNUnh5XJwFF+QPWN9Z
X-Gm-Gg: ASbGncteJUu1dTCZt521D+L6shcn7EON7cVzBIQ56Q1FX2Ioso9/dQ3tOY0aq+hM2M+
 3oazLwtEWUlZiLeAWVS3ZDXyk+5vNURHjdPqg1E4cydovm4mraecoWsZgtTWiuSLqYesTwbS9z0
 PVgrfr2U4IMJUqCRxZh3rCE/A3Iu+6e2Eo0N0AQAtHTcA5my6xBwSdo8PW6tPaaiXQXizQIP0ry
 YR8AnSveY3ng1qbOwrYU1NCwPhcr9fujCGKjQH83zf7YC3rtgpwXhaq/wsatHPxjNaxiONHgnNt
 31oIQZo3TX0/fg1ZqD6zshIDN+r0LY11q5UCgdjuRSxHXgxRbS9fNK8Qr/K/6kyoMO4uZXRNwSX
 ygAaLSBak3S7C
X-Google-Smtp-Source: AGHT+IFuE4Yy12E0xiH5GQZQ0/SKgiICvsxiq+4H/h1w590lvFXYACaPWYLhn+2K2oZgpXxg5r2/ow==
X-Received: by 2002:a05:6214:1c85:b0:6f8:b73e:8ea5 with SMTP id
 6a1803df08f44-702b1bab444mr34485346d6.26.1751463248407; 
 Wed, 02 Jul 2025 06:34:08 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd7718d34csm100586256d6.19.2025.07.02.06.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 06:34:07 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Magnus Damm <damm@opensource.se>,marek.vasut+renesas@mailbox.org
Date: Wed, 02 Jul 2025 15:34:05 +0200
Message-Id: <175146324587.68406.3781314116200023930.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH] makefile: Adjust distclean to remove .binman_stamp file
X-Mailman-Approved-At: Wed, 02 Jul 2025 16:06:50 +0200
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

From: Magnus Damm <damm@opensource.se>

Remove the .binman_stamp file during distclean

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 On top of cbb5672790d400e9ec6e9fceaf89ece2660c0117 (origin/next)

 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/Makefile
+++ work/Makefile	2025-07-02 22:18:46.615791336 +0900
@@ -2309,7 +2309,7 @@ distclean: mrproper
 		-o -name '.*.rej' -o -name '*%' -o -name 'core' \
 		-o -name '*.pyc' \) \
 		-type f -print | xargs rm -f
-	@rm -f boards.cfg CHANGELOG
+	@rm -f boards.cfg CHANGELOG .binman_stamp
 
 # See doc/develop/python_cq.rst
 PHONY += pylint pylint_err
