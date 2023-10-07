Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD90E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:44:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82A2586EE0;
	Sat,  7 Oct 2023 22:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VJtBi5BQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17ED586ED6; Sat,  7 Oct 2023 22:38:20 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BC3786E11
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a505762c9dso39844887b3.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711091; x=1697315891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J3wYSca7tYiSE0HRwFjedSqBxVXXJ/KB779stcQwcM0=;
 b=VJtBi5BQB2MP0zZ+XGqULOSEz3/pSr8OJ5b4TaaVEOpYYSc/zBh6IWFW9cfZ6ne4aT
 w6kJNYRkU7XR5JMP6CHpjWP9UAcSJLSLLnWAa6Aw01jPy0bpOxKkNIpG0K8SsKbtZw/r
 oQPTVtaz4qrJFNBGYT0/g8dzfO1hPYyyWeMTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711091; x=1697315891;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J3wYSca7tYiSE0HRwFjedSqBxVXXJ/KB779stcQwcM0=;
 b=o2cGGeiE4ml9BfC6KKkfL0NhewX7ctOhDpH8YYLnBQUhjqw/MAPMbJnIdToyPYWE6K
 zKwqOQavqYbTehfVbd3s7/LraaC7pEyDuU7bDj9M7fU4cYos0EZ5Q2Qd/S4Oj6pRciqa
 x3v6aTOmEvfQrx10cSvaeqigrXdnkkRLSEkvKHjJCzVMVzND0RE6PE+kg5XaUQNaHYrm
 vrfAhDw5a+M3EKT0oQgAg5Wy7+L+KwrrqEiNmf44H9QK+noE6HV6HukJNZhSZxCe5a9k
 woypKBjsC3t0Bl8RMPcQB+rbayeyY0CQhw6Q2kv91RCBDGcCzeq63yITxhOeco71fn+T
 RZKA==
X-Gm-Message-State: AOJu0Yz3vdPyB59UaIgi0okhhj9zExj3coxRVv96KY0EpmHbTabwBOam
 cdeH4ZWyfyLoU/p0YTxidM6HX2aQAQ85IL3NViFB9w==
X-Google-Smtp-Source: AGHT+IEwOMQ/cZnbbHKlntYcUCqKeGWbPC/hCpAQxDVSJykH4QD+DNK+ehI8ftSHv73WYG0QvwKi2/XumqMIHODLat0=
X-Received: by 2002:a0d:ca06:0:b0:59f:5b6d:c9ba with SMTP id
 m6-20020a0dca06000000b0059f5b6dc9bamr11560634ywd.20.1696711090964; Sat, 07
 Oct 2023 13:38:10 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 15:38:03 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2YXc56LK_PUfm05jp1ysmrvDV7VZE=Y9RVPG_A5yy4eA@mail.gmail.com>
References: <CAPnjgZ2YXc56LK_PUfm05jp1ysmrvDV7VZE=Y9RVPG_A5yy4eA@mail.gmail.com>
 <20230923194424.1739224-8-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 15:38:03 -0500
X-Google-Sender-Auth: 93wepWYzEM2rVcVTiI9ymXrM40Q
Message-ID: <CAPnjgZ0URKUcivdrYtd_CLf0=zAQK=sEk=La8o-4_faG4pDdwQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/27] moveconfig: Drop suspicious boards
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

This code isn't needed anymore. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 25 -------------------------
 1 file changed, 25 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
