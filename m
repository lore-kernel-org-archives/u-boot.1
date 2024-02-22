Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72422C5478C
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 19:36:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CDE187BF0;
	Thu, 22 Feb 2024 20:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GsC23vB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2D0B87BAF; Thu, 22 Feb 2024 20:36:46 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065A287BAE
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 20:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dbd81000b6so428005ad.0
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 11:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708630602; x=1709235402; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6AssWQ7g2aU8iuEe3rDYUtAY9Y0PUKYEMR/HeYcQiHM=;
 b=GsC23vB4U8W/ANt6Fl21sF5CwxwuNLS/5UzJ1HT0Raxi5dztzraBwt+6DNWGQDyUtG
 e2cPlD4rWp1++XPWymVB+ISXMrzJFfvjvgYu7OjW74szR/tLcO8inSafwt7dZ72UnmTo
 Ej25Xp272vHuTaws3cqpa+xqE8NrH6T+7ZZFr5sjL51HZMmHo3+Te1bztNvVWkriu/gn
 FKwxCvCYz68RQmHry+jF8Ps6+26VMRzUg1dh4bafXr3nlBq9pPb7PyOlz1JJC0vpVKWo
 hn84vxpBPUQqudSZbyb3ddm0ORk/h5OungRvVg9pSRbLy0GgcwflWc3DdlYk4a3NcLrw
 /CuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708630602; x=1709235402;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6AssWQ7g2aU8iuEe3rDYUtAY9Y0PUKYEMR/HeYcQiHM=;
 b=w2rfWI1YjPTi+xRaWPmuw6ES2CiFwBiSMsbJ6vghl+Ut8kHDwwjrYxUxgi/uExx/En
 vvcwp326Kf7OtTwtTcbDI8hy5l3Qw8+b5TlwDJ8DJohjWt5+vDdFam4P8otQN/dv0jB4
 bWgErrZp4/QW4yBtpCdPMDHjT/xLjXrJm55udNFSuIbkW/h8xrpXrV49EZp7W8IA4tdc
 yJRM2OEA/0+vWx8vB3e6YGZSYel6r+gLGM1tbX3n/z87CmzSrk6KpEgwB1BqdPJf3a2R
 7LkYmbovXgXjovghLwOPMFXbL9wnX1b5dOwubUWjQgM/+2KtESCyyDQ/XxSn58j9VSBk
 bylg==
X-Gm-Message-State: AOJu0Yx6zhxq1QTW45IB3wEqVZb3YcJV1BW9zW5cNKL1kS/5ZLS+3PdP
 34lGQ5NNLUGgcB6jXV933cDwQlcrAYBAHUqH/yqVNrC+BxEf/bMwcqv0Ykgfm0yU9SbmLlEk/PL
 dB/iAqgtKhZVgqzudWW0yfPzjEk4=
X-Google-Smtp-Source: AGHT+IEVU6zgMOEF/cH0PQW+8l3NkC7AX8GM11SyzLrYE5+I+8UxlS2JGELeZpJ/ovqo2w0P5ZULGs366jQSebBrME0=
X-Received: by 2002:a17:902:e54a:b0:1dc:282b:1bd8 with SMTP id
 n10-20020a170902e54a00b001dc282b1bd8mr6850563plf.2.1708630602179; Thu, 22 Feb
 2024 11:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20240222165230.2600974-1-sean.anderson@linux.dev>
In-Reply-To: <20240222165230.2600974-1-sean.anderson@linux.dev>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 Feb 2024 16:36:31 -0300
Message-ID: <CAOMZO5BDMqBZddF1S6mG4cNXxheXvSe59DfEmUQW_ECbKB5CHw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: zynqmp: Support semihosting boot method
To: Sean Anderson <sean.anderson@linux.dev>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>, 
 Sean Anderson <sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Feb 22, 2024 at 1:53=E2=80=AFPM Sean Anderson <sean.anderson@linux.=
dev> wrote:
>
> From: Sean Anderson <sean.anderson@seco.com>
...
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> I'm resending this from my linux.dev email as my regular email is
> mangling my patches.

That's OK, but you need to make sure that the From and Signed-off-by
fields match.

Otherwise, checkpatch complains.
