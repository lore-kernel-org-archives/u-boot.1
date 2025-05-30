Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DACC5B549
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 11:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79AE482D2B;
	Fri, 30 May 2025 13:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R084VeX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8312F82E0A; Fri, 30 May 2025 13:18:16 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 828C682B8E
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 13:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-60461fc88d7so3714348a12.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 04:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748603894; x=1749208694; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+6+cjXuInXhum2Y3c9zwwy6V3uYcejxsijaHGZTBP1E=;
 b=R084VeX1NtNX25Ev7AsJD9yWcxKkJEYqvO6JNzivHgDnCAvzWcA16a+vWLLFdxwYjh
 fG86giwl02/STyRSqI8NXYZs3cJCzbJ5GEIXFPwkPngPm+2aHxSgYkU0f+VwGbWbx+sF
 XOGFExgBmgnD/34RJ7LxDyi4QXAF6Ra3kU8ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748603894; x=1749208694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+6+cjXuInXhum2Y3c9zwwy6V3uYcejxsijaHGZTBP1E=;
 b=Cmly+fkjhNmZ7ZlGsX8NrQex5yEaIqZ6eROK3Q2cNrlvfUOjJdecU8uKYEcHD9NjI3
 9IzrW9AagNrAfD6u+Zw9DNQnhblN5aWbfVPe5R5qDVKnbHSG+1t4jNZohxZ0rn8VpVIg
 gJB3bZUePvZEfib9beAT1etvrm5ABteh81rCgvA9oo+3vJbStR3X0uqlS9Z0U2m88qQW
 GRnfLrICsXtFfnCPA/CsyeC/TCSV8NIuuk4IwaWFBv9i9P23PY2aJgVjS6Uynq32CyLC
 yAcrawSPXUa3UuBVk63CR/SA/mPPtXkCEXjY+v8qZsRi16vC/PRk5JvML0P0E6yOlVB1
 yTTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1sTDbaGDbCSnl6yV5vcZLRRQOQLKOdPZzunHESf+JStjd/8rQ1OSfMWP4w2DPVVtn6rp006w=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2gfstZbQ5XqunXuC1S9US4zfyxQhp+8EC9ar/6ahrVZka/45f
 7V+HDIgd5NkPyMsoCXG1J6QTessw5tYdn1x2f9Ekz0N6oPsFuLmN1L2OvSQdBYbPAgYutHl4aVp
 awO96RgKa5KOTd2pUxaUZAg1pKQ59BGL2zO6iPu2p
X-Gm-Gg: ASbGnct3x5wp799nekpPPviM5CNeI7W4htUypdd0LJZAc4deoHscfiUu7nMeeg8F7kC
 I2T1ySdPN3gIMspu5XV4FZ5dSRPkPfLMJrqXtWhSiwwm9SAbttQI5/t9y5Fd1X2KxZFPzYoE96A
 F8kU/mxS2uO7LkRrdxu1WUCa7fcZEQ7Wq+6NBC2GzFfw==
X-Google-Smtp-Source: AGHT+IGreT8QkGLkjwE0Jx4jQ64ftqSnmVKUuAZQogliPHYVPQQbg0kSn0jdHLjME/J1CahoDmyiAFMBlWf1xkw0oyQ=
X-Received: by 2002:aa7:d155:0:b0:604:7931:90a1 with SMTP id
 4fb4d7f45d1cf-6056f4cc460mr1879628a12.30.1748603893840; Fri, 30 May 2025
 04:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
 <20250527-binman_faked_optional-v2-2-3362ab897581@phytec.de>
In-Reply-To: <20250527-binman_faked_optional-v2-2-3362ab897581@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 30 May 2025 12:18:01 +0100
X-Gm-Features: AX0GCFuh4gb8JHLizQm1wHv5hcI-WbWk8RxynGCLS3NE8AeRRzKSskjLqBueoUY
Message-ID: <CAFLszTitvF-3Cc2qSLATsJU9sG3LshNEPQvEgqGFbBtsT-m38A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/8] tools: binman: drop "faked" return value from
 check_fake_fname
To: Yannic Moog <y.moog@phytec.de>
Cc: upstream@lists.phytec.de, u-boot@lists.denx.de
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

Hi Yannic,

On Tue, 27 May 2025 at 14:24, Yannic Moog <y.moog@phytec.de> wrote:
>
> check_fake_fname sets the faked member of the entry. Use that member
> to get the faked status instead of a returned value indicating the same.
> Add type annotations to the modified functions while at it.
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  tools/binman/entry.py               | 11 +++++------
>  tools/binman/etype/blob.py          |  7 +++----
>  tools/binman/etype/blob_ext_list.py |  4 ++--
>  3 files changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

For the commit message, single quotes and <=60 chars are preferred. How about:

tools: binman: Don't return 'faked' from check_fake_fname()
