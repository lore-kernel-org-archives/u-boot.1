Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D054E95A62
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:41:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB47586EDA;
	Sat,  7 Oct 2023 22:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mBXiLrFC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3BA286EA6; Sat,  7 Oct 2023 22:37:57 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0B6B86DDC
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40572aeb6d0so30573405e9.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711065; x=1697315865; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YqgIJtTkTxer9+G+kmaj5ygv/EvgmPlleOpVSUx+i28=;
 b=mBXiLrFC7XStjOpg89S/lhxswajuBls3nMhWaO16kXqX2n3xyNNCGvMZWAH2+0TgqX
 4VUSDctEOD/JAg9sJ9JmfAcCJT9suvCvtBeF1X8MKHAOcUeZ9VXhma50F8YSfvxf1f1Q
 ljlEh2gOMIZZH3qryJNcAStPlu5KMo5ZhppLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711065; x=1697315865;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YqgIJtTkTxer9+G+kmaj5ygv/EvgmPlleOpVSUx+i28=;
 b=dR3LBxrqNGaXSOwPYhPO3Qcz8jEELwYE/9cnnnd++pK4FIqEmdo+gm2x8nmIKXMef4
 JTGQq10Q0/7Xoq68dQsKn+us1ZqH4uXAYUrbaND1zgzZCIP6Qpjbrtqt2mlRTDbf7zAy
 ugv1RizV2hI6gPod3s+yUWI3477ZYLFO/OtZH3TplChfnMwky1H1+MONKzHvmcypW0pd
 35yNCuZ3qB9wSsgxIM2QtRahBXvsoBSXg0bJN9t+DNoGbqopOh/RjGFXLthzz1cjpQZJ
 8xGABZNEXO0//gKTUTMHjnpyUAStN7KVPNJY6/iPJmvadwWtmxQ1VhpP4wVKyHZTnTNO
 KdMA==
X-Gm-Message-State: AOJu0Yw/j3yjRpTC/oSnsb1HUun9da4c9uxlwyeKS9zPd2Lb6olEjoeq
 AysipH1oPSeVbEe5fOJSrK7Tst8LSiybRJTk/ejBdA==
X-Google-Smtp-Source: AGHT+IFyE9sPxItvv04r0dG9QLkoWt9GvpVzs3aANlVGv1Q/G0htuQOPVCoqrK/846Bo+GMjHWgobif9M/zk6vADVg8=
X-Received: by 2002:a7b:c393:0:b0:401:bd2e:49fc with SMTP id
 s19-20020a7bc393000000b00401bd2e49fcmr10778397wmj.24.1696711064920; Sat, 07
 Oct 2023 13:37:44 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:44 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2VVry=4tUo=qeTOcMuCkkwfgB4jX3=7c6qhWqJ0v5jMA@mail.gmail.com>
References: <CAPnjgZ2VVry=4tUo=qeTOcMuCkkwfgB4jX3=7c6qhWqJ0v5jMA@mail.gmail.com>
 <20230923194424.1739224-21-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:44 -0700
X-Google-Sender-Auth: r0T6GLz8aojqnxlp_8X0DtVGMvU
Message-ID: <CAPnjgZ0DoHV6GRthz-smQ7wK1axDXoUZYgZpSSR-GxHTuV_+-w@mail.gmail.com>
Subject: Re: [PATCH v3 20/27] moveconfig: Use u_boot_pylib for terminal colour
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

Use the existing terminal code to handle ANSI colours. Enable colour by
default if the output is going to a terminal.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 92 +++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 54 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
