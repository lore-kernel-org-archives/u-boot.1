Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA12C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC0E388842;
	Mon, 15 Jul 2024 15:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k3RSPzFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B605F888A7; Mon, 15 Jul 2024 15:31:28 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A24FF88842
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6b6199ef089so26160826d6.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050285; x=1721655085; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T0FjbZWKacbYNGbj4haRNBYnz0+uhM5yr1nBXNBhXmc=;
 b=k3RSPzFTQqcoP5pMNQvJ9SHev9pnEj2IsDJyNjEOMxaVd7NnAVrRB6uwt19fhBgsaV
 Ew+juoU1Eqr/eLUBDa9OoyTLRb6WUKmGjwI4Vh1ddcSt7oPVk4TjOBR4zfK+0zjMMrB9
 I5NU+SlvgJqyv7BfJck08PaakHBrqyEoGXwbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050285; x=1721655085;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T0FjbZWKacbYNGbj4haRNBYnz0+uhM5yr1nBXNBhXmc=;
 b=r1XJt189aGyEVnNaO+Fzfeqshc8zn8EHzsXz+CnB1gI7+BmRS+p2P7b/xhSUHdeGvL
 oCB+Gr27UzbBvXRx8Gcx8lfNErC+ytP7FlzbbWRLd5ENxyzQ5Wdei5ML4iA05d0x74/r
 gaWOkZ/kB9+zgwNgjpSGY47oWzX+e5A9+ByVrLfoQJf2gXQN+hdQLGYNK3qRDtRRmWZJ
 O47jUlCdjzKD8ELuNJvnyCe0W7WTtbKvMBqOjQ/jxGAL7kNfZ0251w73eOGMfLtlsHn+
 pMaeMooyS8+rVSIyyB7Ng93GPa66eA2/PljZEsEZ0SwPrS3d06Eu/J18ngehNq7pQEfR
 YBOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp2U3iRYIAEfW3Ww1zQxqFe4nCKx6Kvdl1KE/OAP1hxVQxCc68AbDw72VbkWfYEUsnO6UNB73sK0fNCPxQOOaXNcmy+Q==
X-Gm-Message-State: AOJu0Yyp1LblCKct3KMP/V2+fxAHCPN++bPMR85fNDIM5QfiKB6CDYWi
 S0klSeLj5OuZ41qPbWQvT29yMvJPtg2bBNHffMPohl9V8TSfDLcrtsvtqQfWT3cgP83zjGHcHc4
 4Dy9LxkNH1s2Yo3jLY4sDswnWw0olqPwiaeWZG9FsugtWxGY=
X-Google-Smtp-Source: AGHT+IHycPISGSivOtY4SQTd/YfhivGy8PRgvA2duSuYphpVd623X18dFs6KfywDO4PZNlmcCu3e6vW2d3sS6Sh59tw=
X-Received: by 2002:ad4:5cc7:0:b0:6b5:e60c:770a with SMTP id
 6a1803df08f44-6b61bf5d589mr270935766d6.31.1721050285531; Mon, 15 Jul 2024
 06:31:25 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 09:31:25 -0400
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240623175622.1468600-2-sjg@chromium.org>
References: <20240623175622.1468600-2-sjg@chromium.org>
 <20240623175622.1468600-1-sjg@chromium.org>
Date: Mon, 15 Jul 2024 09:31:25 -0400
X-Google-Sender-Auth: Xp6C4lgMA8Fwz3wPoSzbO82VCvI
Message-ID: <CAFLszTjWj0E_sYpji_14jwvqEPA7jX2yOsUbfY28fOrfpOT7-Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] buildman: Add python3-coverage
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>, 
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

Add this package so we can run code-coverage tests for Binman.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

Changes in v2:
- Add to buildman requirements instead

 tools/buildman/requirements.txt | 1 +
 1 file changed, 1 insertion(+)

Applied to u-boot-dm, thanks!
