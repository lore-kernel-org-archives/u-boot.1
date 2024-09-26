Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F7FCDE03C
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DE1988F08;
	Fri, 27 Sep 2024 00:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TMOcdLae";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B40588F2C; Fri, 27 Sep 2024 00:07:20 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E935088E51
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e0afd945d4so650446a91.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388435; x=1727993235; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FGt2z2LUpLQdVaPSniBMAD4p0uqwNkPVuxz5+nKBgFU=;
 b=TMOcdLaetviLVz09ELbh5fTmluMOT/qubmu2Wyz3yHA5o1SCRfz59L97YE9H02s729
 VgIQkBGoGAXTT7LG9Vmn7QHcbT/U2djBZxT/q7mUCEaGdE+chExSSSBTjS+kaTUS+H4U
 A/P1xkgLHqnjegrByTAmU4M8sJTtEijF0nuhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388435; x=1727993235;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FGt2z2LUpLQdVaPSniBMAD4p0uqwNkPVuxz5+nKBgFU=;
 b=juEx0NkGdKm5fWtYCA3SErHWu3/DNfUKZqr13YhOSUORym1+1dXTVMFg0MZEuXE9Bz
 p8nWE8PCMBF4PKaxJW9uyHzDAnMKvvogtryChfp8xYsQwCD+100pkBGIXUD5NbXYctE2
 G9oXQauAU3WuT+QMq56n/GcWpEa7/9h9Hw8GmsSELamgUlNbsva9+G9DjdoUAGfiweCc
 v5s3EkKTAeLC6ymwiizhIeoepMglVkzLF+L+dg8cIZq4FIsLcmFLz/1C/Kwui8gxu5lK
 PlDnlLhMHQzW8bd0KXS6OeMiGOd+O4DByknkePHxR11zW5nowSVlHmNZvdA8sJ8JKrWS
 tGdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWFExOaeB3gex7Y43sjFXyK/qJbVONAMT4QOxXB3oHVD0oTxcQPF7HkCQhAhAAWSHkvBT65lQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyl6Dqc60n+YTJQlccE/xLszot6a6Tp/3zTcdvnGE676mNee8qw
 8kZuQMLv3zVEhWGAV+TzyrpkKyr9wLoCHlhL9Ie4EQ5vA37PVby9WUnYFMsimi2fccOjJ2JKQjH
 K+mfrNCClwM8+Q5+W4dlZ5f1ltEhKfEfNPffB
X-Google-Smtp-Source: AGHT+IGlKIDAfjI/wf8x1fEF/0yL59wqZtMpl2S2AFx7M9A9TAJc2EENUhanOunhzGlJ6mGWo1inp+JUipNrdE6S9/w=
X-Received: by 2002:a17:90a:ba95:b0:2e0:b6f5:1884 with SMTP id
 98e67ed59e1d1-2e0b7b83739mr1403176a91.0.1727388435494; Thu, 26 Sep 2024
 15:07:15 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Sep 2024 18:07:14 -0400
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240826191143.426387-16-sjg@chromium.org>
References: <20240826191143.426387-16-sjg@chromium.org>
 <20240826191143.426387-1-sjg@chromium.org>
Date: Thu, 26 Sep 2024 18:07:14 -0400
X-Google-Sender-Auth: R3GE9XrtOsHbXVQ3dJzPLmr4yN0
Message-ID: <CAFLszTg2s_4LKkJP-OAwjdSqpygwhggOmSAkY376UWTk2LGxzQ@mail.gmail.com>
Subject: Re: [PATCH 15/15] binman: Make a start on an iMX8 test
To: Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>, Marek Vasut <marex@denx.de>, 
 Neha Malcom Francis <n-francis@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

This patch is for Marek, to provide a starting point.

To try it, use 'binman test -T' and see the missing coverage.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/nxp_imx8mimage.py |  3 ++-
 tools/binman/ftest.py                |  4 ++++
 tools/binman/test/339_nxp_imx8.dts   | 17 +++++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 tools/binman/test/339_nxp_imx8.dts

Applied to u-boot-dm/next, thanks!
