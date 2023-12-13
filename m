Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45946C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:45:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 276428792C;
	Wed, 13 Dec 2023 21:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F3j+B+e0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A0D5878E2; Wed, 13 Dec 2023 21:39:45 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CC3287906
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40b5155e154so84518745e9.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499981; x=1703104781; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mw7ZVe+b+IT19JPXSwplprfgMFJvnQNKjHtQKzV8RtY=;
 b=F3j+B+e0VutmfSwDWB+CnfOwqpDVKQQuneyl0DkmhUj0u8f1XRiZQ+LKG9pGQCJGfW
 9QGdGg0H17BmUjFOVuQnFfrIW7IMNUbJxkL+VzFq+Q4VvlEXbVsgxWj/qWafKYCT0a3q
 3JReJ2ZPXHsjPRUgWP95NmCKDpA9ZrgQA4LTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499981; x=1703104781;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mw7ZVe+b+IT19JPXSwplprfgMFJvnQNKjHtQKzV8RtY=;
 b=aibqyTfRRzl40YhR+HR4zvWoMyAHww/ir19cCKnqyggdc38a7SMbATY75TlODO2pA9
 5Ze1Fid3MXStUpDlrNPEoKWFTLOyPPVj2P5TxIIL8MFcu9OmLzOTxNgAjKHetdG1xWE3
 Losm2BjnT4BPqGARktZmzyd6N2+fW6IxhgROWfRpe7CMb0ey1lkiSZ1nrKxm/XJ3y1im
 8lssmVZzoRMsfJ/NCG6iBZk06URlB3aLnagOM4/rdL1irQbIxlAemJhRas8+JjP9EViE
 ManTGTYXn3egG4xnMgc2YIRPi8blCHQpdjQ1b7XWW0YFGlYJi+FnifIrKZp4Mj/R/+O7
 Gd6g==
X-Gm-Message-State: AOJu0Yyk4kqfBXYSIdxHC7N8X7HikphCC4NGYvMJyHFS1dk6JvPBITGh
 fobOuiwgIFtKsTw/ME0nG2FURBHYyOyUus7I+6SjXQ==
X-Google-Smtp-Source: AGHT+IHEVSJkrHjonMRaQaB0HzvS4dVo97Z1BmR2qP3Vy2RNXPEK5KqKYJAfVBsr3b2OLzu7avD/QOW1zgSJRO/d0Co=
X-Received: by 2002:a05:600c:3b26:b0:40b:5e1f:6fe3 with SMTP id
 m38-20020a05600c3b2600b0040b5e1f6fe3mr4306069wms.56.1702499981533; Wed, 13
 Dec 2023 12:39:41 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:39 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231002011553.463514-5-sjg@chromium.org>
References: <20231002011553.463514-5-sjg@chromium.org>
 <20231002011553.463514-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:39 -0800
X-Google-Sender-Auth: datu_qS1WRzJQI7V_TAH5XI0kMY
Message-ID: <CAPnjgZ3DFqcyCouo-G054gTkQRtsufDwJdPmGrueRjiOsh9p8Q@mail.gmail.com>
Subject: Re: [PATCH 04/34] test: Make UT_LIB_ASN1 depend on sandbox
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>, Brandon Maier <brandon.maier@collins.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

This doesn't seem to work on a real board, so use the test on sandbox
only.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/Kconfig | 1 +
 1 file changed, 1 insertion(+)

Applied to u-boot-dm/next, thanks!
