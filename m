Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68572C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 17:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4D7F88ABA;
	Mon, 26 Aug 2024 19:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gEynaJIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA4C88641A; Mon, 26 Aug 2024 19:01:46 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7690688ABA
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 19:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4503ccbc218so44298251cf.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 10:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724691703; x=1725296503; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4IWNjvE+mm0hyeVBSYZi1ZSLZbQdeoQhsnG6ae67r4=;
 b=gEynaJIVAHDzsHCAdpLBGiCoKtIoSCU9V6j+sVzEa9ixd5WPUKn2pyvc8YnVyKs+EX
 7JyIg+2Tl0fqrm2Pto/dZgzImHKoxp7gzXLO5bKdL+6fG6KEaYP4V2ZlnY8rkLKGsdI6
 g0y5lBCgEWCORYuy896r2h2otegVMhZM/va7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724691703; x=1725296503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p4IWNjvE+mm0hyeVBSYZi1ZSLZbQdeoQhsnG6ae67r4=;
 b=S7F8345mTpu8GrKYgnIytS7kaCJB/EKzwhSF3sfOmV6POEF9FbWcQvxv30uDoXubzE
 hqSqsVYpZZXPXEgnIpgDRbRsVwKYOTMuOOOx+Ffx67ZlJH26J3kU7x9xceFnFaCdxX8H
 AZ9tPTfbdjVqOcGAQlWuGh6j+zazw29M/XbFTGrYKBc8ZGBMQaQ9s7NieuKPYCglhzSK
 4e6m4IS+750CPexiWKYRhzUSITZLCdD6ZMfA1fgx/i8yqiHUJJtge8i643OcPBUhu5Cu
 LGJdQBfUClL45e7a7Gs6Cd4IA01punlu32UsAtkx4CDd589PctwdpGIN0hVd9LIhnLsg
 8Upw==
X-Gm-Message-State: AOJu0YyTjzNr88lECMwY3kCiDiqP+7O6XSKDMnVWyQWqSaf94CIBBsXX
 8X8Wp2nbMGyDNPFnb3JeZ11VoAY2t+E3ywr1U/ewukYQJexyFEEDwLv4tGbk8911ZOFcei7VzKS
 x
X-Google-Smtp-Source: AGHT+IGgs5a3IBn9TdNfEhyfO+Gjmy4rJXsLs4lfXNLG/v6U80juMFC5a8OgOud9nHlEEv3oyKZHjg==
X-Received: by 2002:a05:622a:53ca:b0:456:45cc:2b5a with SMTP id
 d75a77b69052e-456600b8154mr4190221cf.25.1724691703036; 
 Mon, 26 Aug 2024 10:01:43 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe0e5508sm45223301cf.39.2024.08.26.10.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 10:01:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH] doc/develop/sending_patches.rst: Reword where our git tree is
 slightly
Date: Mon, 26 Aug 2024 11:01:40 -0600
Message-Id: <20240826170140.2791128-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826163917.2786791-1-trini@konsulko.com>
References: <20240826163917.2786791-1-trini@konsulko.com>
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

We shouldn't have had the link to our git tree be contained within "``"
as that meant that it did not work as a link, so remove those. And
rather than make this a link plus text, keep this as a link within the
text for overall clarity.

Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/develop/sending_patches.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index 82efb717b179..990cb9912a92 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -76,11 +76,10 @@ General Patch Submission Rules
   compression, no attachments. Just plain text. The best way the generate
   patches is by using the ``git format-patch`` command. For a patch that is
   fixing a bug or regression of some sort, please use the ``master`` branch of
-  the mainline U-Boot git repository
-  (``https://source.denx.de/u-boot/u-boot.git``) as reference. For new
-  features, if the ``next`` branch has been opened (which happens with the
-  release of ``-rc2``) that branch should be used, otherwise ``master`` is
-  acceptable.
+  the mainline U-Boot git repository located at
+  https://source.denx.de/u-boot/u-boot.git as reference. For new features, if
+  the ``next`` branch has been opened (which happens with the release of
+  ``-rc2``) that branch should be used, otherwise ``master`` is acceptable.
 
 * Make sure that your mailer does not mangle the patch by automatic changes
   like wrapping of longer lines etc.
-- 
2.34.1

