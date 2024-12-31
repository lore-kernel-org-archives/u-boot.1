Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7899DE77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 21:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B48148021A;
	Tue, 31 Dec 2024 22:17:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VKlbd85M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C525F8021D; Tue, 31 Dec 2024 22:17:36 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 449AE80196
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 22:17:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-467a17055e6so115603021cf.3
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 13:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735679853; x=1736284653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1liaqGc7eY5+FXVW1oSpiftBWZjOG6sgC8RV6uM9quM=;
 b=VKlbd85MqW6U6y0LMo+HtPq6cI9UT+BiXop6wfZfPl3VcB1Aq/3tkuo8vLJKtL9DCS
 NlEODAMHBFIMioqMX84gN/17C3ZQcG9BRRwvAx1akvUo3VQjHvZdcJW9UQsxspt/AYUM
 T9tihX9Ijwc73gwvLlLmkTG3VGxlNKFK3YNO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735679853; x=1736284653;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1liaqGc7eY5+FXVW1oSpiftBWZjOG6sgC8RV6uM9quM=;
 b=cJAW8ZUJ1ruML4LzgKU0DST4uWoZiM8Y7xOJZUTwFoA+Id0+EpZc2B7qJwzN5OzMDq
 BYrOi1a8hv+a8lsuDfg6VeD7SYFqM9zbSOYGgPM9FdLpmqZuDhw3sv4t9cE4cQjwuPR7
 fW5p+FneWLf25lZzwWM7k3AwJxNrMkfzvhynO+/uJM/cRjwqK3wZSrvc6b1+OKnogYMN
 z82tCeZvfVNjPxfqNipKQu1Y7IAiXtlrDUVce6w9wnSaZ4jJZU3zzkVrAcESaV2mGiI1
 4X3FzrhbhWUOTsTdWqeVzdhb5OXWOs3qkR9fKtz+7unhYThPfvOhFIR7vYFgJMX3TBYl
 ms9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUh1AkYxfA0cGLJ/dTpaPVPkHvNEcO3UrwDZjE4sXrkySG1S+5BT90RaZ7yV5wjQerv/eX3zc=@lists.denx.de
X-Gm-Message-State: AOJu0YxXwyX18E0xd8dcQmmQpFSeSZ4LHW6KBwtTwOnqaRenJcDjb6di
 Hyj7wlm/vytcibqFiIg3Pt0wKKUt4bJ47SxKh3ChBhAHD9ELk+61QqpjiGmPxqE5sYWvRtIm5Aj
 G6QE=
X-Gm-Gg: ASbGnct9k3Rl3iGl4PN2/Erhxe3wsYU+8bGPBI7r8vYvMZyM1NcsttvdXIjS6XZpOa9
 orbb3r2paNCGJdVw3cS3icS7ZXE2sSEM7wAvCEVLkpVIVURdBXIq8hLp/c02ogc3N0uVQ/JOAGo
 TrWblnexoGeGz48yP/dyVziJnNPrcAGF/HrH0W0YOSyeCv6CxL51T+22sjddL/0c0TM7LiPvRx+
 0/fVIexCwdXr6z4zl6jXbOOJObTgthQqYLE1K0lMzQlzwhwbQ/IHJOo
X-Google-Smtp-Source: AGHT+IGS8rBETuH3A0QBF8Hbb89RVCRbsvFruoaI4Vhp3icywsFL8WV1nT/SnGdslPgqegZQzBDmXw==
X-Received: by 2002:ac8:5245:0:b0:467:8628:a32c with SMTP id
 d75a77b69052e-46a4a8efcb6mr610329461cf.27.1735679853119; 
 Tue, 31 Dec 2024 13:17:33 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e67e280sm118864031cf.30.2024.12.31.13.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2024 13:17:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: kernel@salutedevices.com, evgen89bachinin@gmail.com, u-boot@lists.denx.de
In-Reply-To: <20241211-dtb_dt_embedded_within_fdtdec-v1-0-7840469f0084@salutedevices.com>
References: <20241211-dtb_dt_embedded_within_fdtdec-v1-0-7840469f0084@salutedevices.com>
Subject: Re: [PATCH 0/2] Keep the access to dtb_dt_embedded() within fdtdec
Message-Id: <173567985008.373695.12800569875737959359.b4-ty@konsulko.com>
Date: Tue, 31 Dec 2024 15:17:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 11 Dec 2024 01:39:56 +0300, Evgeny Bachinin wrote:

> The 1st patch addresses comments from the post-review, available by
> link [1].
> 
>   The 2nd patch fixes problems of dtb_dt_embedded() with checkpatch.
> 
> Links:
> [1] https://lore.kernel.org/u-boot/CAFLszTgEKamsa6FTnjzrEWQBLkqAR7EBbZqffx09AKgQ7ppuVA@mail.gmail.com/#t
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


