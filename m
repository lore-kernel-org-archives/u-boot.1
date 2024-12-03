Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197BCE74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EF2B89666;
	Tue,  3 Dec 2024 20:39:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OIsJicU7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8634E89185; Tue,  3 Dec 2024 20:39:21 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37D8C88E42
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa520699becso951259366b.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733254759; x=1733859559; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W3VQ/qQVivQQ5MqIoUl8jrxnJdmyxWnHQgwXzvp31NY=;
 b=OIsJicU7Ap7TDpJ02HHwOX68kCvs5PI/Gnu9bvTpRcSWP5+dOjtYYWTH6Icts4mIw/
 i/537978arMPXurWWuKU6DIOruHZrJG3aG59icXtHPTF5Bp0MIbxKsxySv6bRtcdCsTk
 +hFCCj7BBcEaCNvANMgJAnf6KPKhOdyjNjfZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733254759; x=1733859559;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W3VQ/qQVivQQ5MqIoUl8jrxnJdmyxWnHQgwXzvp31NY=;
 b=VWsqqhSOgTrAeNRtacOkXyuGyJdxUxbZmbasnegIBp/1z5fHdXx0WWwQmCVCA5Iz/4
 Cy/nUjsQyuhR++y7YmQklxhyetK4iQ73oFrdBkmsEEwtydFvPbO4wcB4g2QXAy08VtsC
 ovsXda8pPCdO5i5/uW96SX5P+hb9V2Pp4ME9gOYHVjZKy8WeOj2Xcr2io5bkF5JyH+ae
 yoElDvIE79figBQYVMtThEt133v9+YzBqqjj+ZRLOhCJsheBam5Fy5RcZdBf7unENIvr
 3SdCtF/DPbWjavujw2cROIJaR2yueT/t5da7cSyCseCKlMg3LOEI7X4/IJcWfrxFckSq
 a7qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEuogY3KEQ7+UvJqzWAr3huQzXkDRhnuJFu/KWjiSR9+xn9tyIYZPaw3t81o0cYxbUXbus8CU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzc4VwQlika+yvlLsTm7RNGcEonbQ/xQVXzbal2OABUrycoL1+6
 Tr/qg84WXOVshI0+eb7YaMsWpBI7hLd0BWgHmVdg8JydfuilYcrHy3nLE/cJ+xvMTp4Moq/zQse
 ELPfyD/20ipnEzIbIZTUqHePFhCRed/CJWnra
X-Gm-Gg: ASbGncv4jjIdy2SE7Tctz7qZnfh+/HN4ZRVFqCxPEKyk4FhMZxPOgiUJNo2jR4MYbG0
 0qn8Yhn9AOJqRZiRaK2L5dFhnyFUkcZKt
X-Google-Smtp-Source: AGHT+IFqlJ/26SO+idSBQ3NpZr/USh67qyGn4SHTr8kuoEpVdREpg7vyu0/agZOX/AJ5ILPR8+npMUtXzq57GFAILSg=
X-Received: by 2002:a17:906:ee89:b0:aa5:3ce5:1e2b with SMTP id
 a640c23a62f3a-aa5f7f2fb1cmr373962366b.60.1733254758615; Tue, 03 Dec 2024
 11:39:18 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Dec 2024 19:39:17 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241103003322.626036-26-sjg@chromium.org>
References: <20241103003322.626036-26-sjg@chromium.org>
 <20241103003322.626036-1-sjg@chromium.org>
Date: Tue, 3 Dec 2024 19:39:17 +0000
X-Google-Sender-Auth: S45jMxZ3WbjTVCsoisC44C2taMI
Message-ID: <CAFLszTgXmZwYnCsX4kp6TfAGFBxsg0JkJBZ9ZSBg_wi-RNzrKQ@mail.gmail.com>
Subject: Re: [PATCH v3 25/25] doc: Add devicetree bindings for options
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Some of U-Boot's options have made it upstream, so bring in the binding
file.

This is taken from dt-schema commit c9b4797

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Enable LED on the 5 affected platforms
- Reorder patches for bisectability
- Add dt-schema bindings for LED

 doc/device-tree-bindings/options.yaml        |  79 +++++++++++
 doc/device-tree-bindings/options/u-boot.yaml | 136 +++++++++++++++++++
 2 files changed, 215 insertions(+)
 create mode 100644 doc/device-tree-bindings/options.yaml
 create mode 100644 doc/device-tree-bindings/options/u-boot.yaml

Applied to ci/master, thanks!
