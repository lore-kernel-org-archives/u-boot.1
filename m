Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1F8CCD1BE
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 14:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59A11835FD;
	Thu, 23 Oct 2025 16:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cH7XvTJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96E278363D; Thu, 23 Oct 2025 16:26:51 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A21C98006D
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 16:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-475ca9237c2so5176755e9.3
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761229609; x=1761834409; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/bZn1/iYrdYeTNoCp6HxujwB+SeoQG5ZfXoqB3exzRg=;
 b=cH7XvTJz3JGXyzD0QQ/rPY96HlTeVR6viiJKUIBVStkA6fLSSmBpjK2y5unosGWwXn
 8ERlWBkjKa4+ronOpGpB0gBTTZNxCMnkGQ8nUhHXmE4fMA44f3vmBiA7n/5MHAZjCC6A
 wCakymGeNcw0zMxuCFEnSUawlXZpL6+64v2b2ukZA3AxHhTbbcRaAXDHiUsdoKmsD+tP
 0eLh3xKqAfdmeVyhkPYzHdpTHz0OQz7Pf3W31E9YHLE53lq7+xttPYgN1f6YVfuTR80d
 XrXXwCj8Yzpab8CCmhtWqmeUUPp5CxP4ju3Opb1x509CLBgi1YvkYRvpDHcVwNWEqJix
 JoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761229609; x=1761834409;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/bZn1/iYrdYeTNoCp6HxujwB+SeoQG5ZfXoqB3exzRg=;
 b=P+/dGhIQafKljz0gWhlGqan+Oa1c3p2KQXsWdRuf2W7Y/2VtQ6g/Hh7BMAfANev6RH
 /87XxRyefk0MJqJ/Cx5dsI8PS2NHQ0vWfT/6/yQ8ldut2Ak6tGTx1pcE1DrZt5JJWvur
 e0ijJAQOE6jF2F2zqIvRGqZFvByEUew2C3/ptopQst8S+81DR8V06+tkgucqKpfEC5sO
 15ylVpb3ITtrTKS5rqVQxfFbEUiNFLA7qs6R2EJEXttXc6kYoJb6GNIICvEtYTRL30Ht
 +6UUapbbwwg2GqzxwDjZ/NeSFI2xAn0Gsfex5kvejKdY1BAQL+Fr2T64MxZVW4H3Mtbo
 2E4Q==
X-Gm-Message-State: AOJu0Yx4yxnckbg900wnv2esETckHujl4QRfR+SdWZ1IVIDZEITk96Mn
 1juI2+t6qF6dYMDa57PjkfbAUjayw88QUQkaCUiN+C4RutDZ08VVS0gmZ477p9oxQKc=
X-Gm-Gg: ASbGncsiwntYczgZ9Ez/MEaqtDU7fU1ElQA1o0ODWqhQQ86JJm5d6VncoI3ceThZk54
 885ZEWBWmE9PAhI0kLp0ZZGJOt8YSTinrZG/SSXVj/NsVgpnFdPfU1sVknez0NFHceQBgnli9oB
 xz/EyRA+0ydvBQCDMqZSJrCUi+0e1jRT85I4a5zpeBjM43DWLpPPA+OuZ+3Nfn+xx/0Vi6zoMXt
 0Rvgu0jGuxk3Z0OCr3oapeh1D5AqCF0C6KLWayltHA7yXjGepdrt2U8UjqteRsGxBcJymeFUnOH
 U0/8EIAJnzLnxdtHb6GiX0QSB4IUWPC/dUY7aMeQs08OndlRSYikxl70YfA02iT4S/HfXOWdUMh
 DeZHn0HXY1NcLTY2cRntkj2z0V4xWUMwGGSwOHOM161oYhaibRJfWm6+e4gnW9AHHkJaCHDlz08
 Rv5oUIy0B5G7tnlDAQpqt+XoSKheXmtKnM6QItgyFFQSuT
X-Google-Smtp-Source: AGHT+IGIpJjkxznCMCDNRH+T3ky/vLLzodjDihrQgBsIQt2ehBwsqu2U/F4K94AkWGnU/VEQevdBpA==
X-Received: by 2002:a05:600c:3541:b0:46d:a04:50c6 with SMTP id
 5b1f17b1804b1-4711791934dmr186778595e9.30.1761229609036; 
 Thu, 23 Oct 2025 07:26:49 -0700 (PDT)
Received: from lion.localdomain (p4fc3da2c.dip0.t-ipconnect.de.
 [79.195.218.44]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475cae9f292sm38585445e9.5.2025.10.23.07.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:26:48 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH 0/2] eficonfig: improve handling boot entry optional data
Date: Thu, 23 Oct 2025 16:26:45 +0200
Message-Id: <20251023-eficonfig-ux-improvements-v1-0-f5fc93b126ed@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACY7+mgC/x2MywqAIBAAf0X23IIaFfQr0cFsrT34QCuC6N+Tj
 gMz80ChzFRgFA9kurhwDBVUI8DuJmyEvFYGLXWnpG6RHNsYHG943sg+5XiRp3AUHLrFWOfkYFU
 PtU+5uvf/nub3/QCmLLitawAAAA==
X-Change-ID: 20251023-eficonfig-ux-improvements-75bacff07c16
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15-dev-52d38
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=wweWagSfNccijySb1zMIG1eoklY9nQVqs9QQg8djtks=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhoxf1up3z3RpezGcylPq6kq4vnD9zPY/E+6YRaq/Scs63
 d1RkJnZUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACZS9JPhn6bFe3EppbXz2h1X
 7WnrWKduER3Uli3yZVfI8US5lTMuzmP4Z5pYYOgnPbd2wwa2hxvO606eVt/35N/36rQ/JQqbahe
 p3AQA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

When booting Linux with EFISTUB or via a UKI the kernel cmdline
arguments are passed in via the boot entry "optional data" field.
Currently this field has a limited size and on editing the enter
contents are replaced which can get quite frustrating even when there
are only a handful of cmdline arguments.

Let's improve this by expanding the maximum size and teaching the text
entry field to be editable if the buffer already contains data, as well
as adding cursor navigation with the arrow keys and End key.

Additionally, implement support for ctrl+left/right to jump left/right
by word as well for quick navigation of long argument lists.

---
Casey Connolly (2):
      efi_loader: efi_console: support editable input fields
      efi_loader: efi_console: jump to prev/next word with ctrl+arrow

 cmd/eficonfig.c              |  2 ++
 lib/efi_loader/efi_console.c | 69 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 61 insertions(+), 10 deletions(-)
---
base-commit: abfb7f3a64c32c88da007e775cd8f27d4a427231

// Caleb (they/them)

