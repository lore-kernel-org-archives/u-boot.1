Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DCFC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:58:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 353F588005;
	Thu, 25 Jul 2024 15:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DcxfwjTd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6E3B880A7; Thu, 25 Jul 2024 15:58:46 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C082787E64
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 15:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-396ce435923so1775735ab.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721915923; x=1722520723; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMdTt56qvbA9ZfN/+kEWtlC9UyqBy5KqzuRja3qeRxs=;
 b=DcxfwjTdbVTaYu02cb3ZlD2cVgazKNQObLNH0vOqDlkvDS7lpJx8IyBoORzW7giWi6
 b7baCCPDahpEoiiusC2m4QNsRs7O/qQa+Ncz1nfx7gT+aD1h/suhjb9y7B1v/Jb5fdQL
 bQNAvxXxfm//zvHxNed4bME4VvR8/jfdlfZw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721915923; x=1722520723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FMdTt56qvbA9ZfN/+kEWtlC9UyqBy5KqzuRja3qeRxs=;
 b=XVzZjNL2nLnneOoatei1ph4RJDhk1mRhcflixeXoW0Oqg8KMleuFhh55wJXjlcSQ/A
 CNOeZb/3kxwXrDi3TFXEiBo3G65MXD4xGpAfWriGn7s5Kh8qQQbZNDZQKj0NABYxuiOy
 STgcgV0HZK4Qqi+pVyqFNWOd6fPgwwNhJKAHzK14Qjq4lkhYsPEpUYvkMkre8sSh6ucU
 uiwih/elYgxVYtmjdJF1V0RfHQtTrgxyBKmqlsspGFf8bBfu9xuCq9ocJKyeVKTQE8ML
 GgEGaXS05wiJn3aQZxM0v9rE8wWjIYKFKwsJ+OVFuNMzxGYideekofPAgQqLkoielisr
 WLtQ==
X-Gm-Message-State: AOJu0YyAughXWydKC48QN3IzoZiPLYt/MczqEFNJAh31hHO9ErmDbMW1
 4HdXDUqo9ft2a+2Egj5XJ7domVG2Nb4wCou05kp/AgLrvf3C5Ve9YLIlqFukJDStziNBZf+Smi8
 =
X-Google-Smtp-Source: AGHT+IFLMp0gKqa7BJUGNCxPyASL4xUOW19O/XdIXQ1CtPeX1lbYG++2IEvMKEuo+oXkCldmLEv4pg==
X-Received: by 2002:a05:6e02:12e6:b0:398:a9b3:d6b1 with SMTP id
 e9e14a558f8ab-39a2197a944mr23734655ab.12.1721915923422; 
 Thu, 25 Jul 2024 06:58:43 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a23105f6bsm6015445ab.76.2024.07.25.06.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 06:58:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/6] doc: Show more information in efi index
Date: Thu, 25 Jul 2024 07:56:24 -0600
Message-Id: <20240725135629.3505072-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725135629.3505072-1-sjg@chromium.org>
References: <20240725135629.3505072-1-sjg@chromium.org>
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

The index is much more helpful if it shows the next level of headings.
Update tt.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/uefi/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/uefi/index.rst b/doc/develop/uefi/index.rst
index e26b1fbe05c..44540e8a537 100644
--- a/doc/develop/uefi/index.rst
+++ b/doc/develop/uefi/index.rst
@@ -8,7 +8,7 @@ compliant software like Linux, GRUB, and iPXE. Furthermore U-Boot itself
 can be run an UEFI payload.
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 3
 
    uefi.rst
    u-boot_on_efi.rst
-- 
2.34.1

