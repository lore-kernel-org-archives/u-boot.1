Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BD0C021A1
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 13:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64C2280C83;
	Wed, 12 Feb 2025 14:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V//GUgrv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12E7680C69; Wed, 12 Feb 2025 14:38:08 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1603780C6F
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 14:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ab2b29dfc65so1034125466b.1
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 05:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739367485; x=1739972285; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EEsuP5AFtZQm7r9qh2B0wR9ITZnGiqwbZIriiyoYAG8=;
 b=V//GUgrvq/IQYghLNAPfpMov03LeCL5mHQ9ob4zLImaqkgPnDGkRhgwMZyCzePLGAG
 9HAQ/tbWz/fDQ8U2fTtLKo8YiFUzUmI3Z1FRLI3FlbHqRmPEFMSpaSXLbpj3nncbGMjT
 t4UM54RFZGve5HuBc8T+Rhzo3xwW/yaeM+jjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739367485; x=1739972285;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EEsuP5AFtZQm7r9qh2B0wR9ITZnGiqwbZIriiyoYAG8=;
 b=JKKXKSVcHSrPswjhTG6vGdMHDMATk4R5j4ZETXWoDXpLbwxkGgZa5QrpYH38bE5LZ1
 xozBdkUi7iM9snXDbR6RjXLtmnO1/jbrYzUcz9p61CMgjmVAq70bGT3TeMtv/a+5MK3G
 fCqZdKQH3QLpvotnY3WUxRQurm3s1AvAmZVZa5EmXH0PMHceuqTb8mPRCKaAjb3Y3MeF
 NZj0SGzEEu4z1tUpFF/PYg39Y7/Q1YBnXPUNX5kfvQvhg1AqCcKNnfGTFiGagzRl0cJY
 5XVNJTc/JHOJKBIepq5cqr7aYYyeLOn62v4ki0ErmkEeJKhX6GrQolTmm75IAk3sNhgO
 lqLQ==
X-Gm-Message-State: AOJu0YxkKQ2pkwecxBqaH/mYVjkI6SRYj6ugSNoGzaM1RjNHQgfwJmLb
 aoKwY5BCE8PXKEybF94pbW8f+QlPToBkHoWJIfMRJ7paEokNcD+HpdZr20hTwYJ9EewYo36t1AG
 uz8BoiDmyDcM78pNnG1++X+1BXEZc1UK1olmA
X-Gm-Gg: ASbGncuWQ4O0F/+8ikiEr4vM6B7AepKHbPbe96zeQl9QAJ+Z+pgi+ZyHvNkYXvgPCnt
 mQ2PHa1IiYXAjHtrWjx4j6VYt2CLesVxGPKd+C/B7rKPCwwAuGJmRRfEeDf8roikz2TNKc0Kghi
 VbyrAMDULJYKqy+jXfXVdiJwPj+AmheA==
X-Google-Smtp-Source: AGHT+IHf8b1IMYx9ZWI38pkO4TEhQmJ26A0xbqsgnkF8DGSgE3pWwlO4tuUWSJxfgTcZRhuXUmcmIo5rnvinsZ/JqC4=
X-Received: by 2002:a17:907:7f27:b0:aa6:a7ef:7f1f with SMTP id
 a640c23a62f3a-ab7f3325255mr289909466b.11.1739367485483; Wed, 12 Feb 2025
 05:38:05 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <1190ecc2-14c7-4680-8302-b4902f487156@denx.de>
In-Reply-To: <1190ecc2-14c7-4680-8302-b4902f487156@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 12 Feb 2025 06:37:52 -0700
X-Gm-Features: AWEUYZmvXH0iV_sNwRwY_uiUCVEVNcJ_7DJGpi7Kh2GrtdH30g8LY2EEX2i9rNU
Message-ID: <CAFLszTjd9wdc3veAu-byhBKgDQhG7grVYJ03Fj4+sAPo_qaCgA@mail.gmail.com>
Subject: Re: xPL Proposal
To: Marek Vasut <marex@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

Hi Marek,

On Tue, 11 Feb 2025 at 19:13, Marek Vasut <marex@denx.de> wrote:
>
> On 2/11/25 4:03 PM, Simon Glass wrote:
> > Hi,
>
> Hi,
>
> > I just wanted to send a note to (re-)introduce my ideas[1] for the
> > next iteration of xPL.
> >
> > A recent series introduced 'xPL' as the name for the various
> > pre-U-Boot phases
>
> Can xPL build also U-Boot "side-stages" , like for example
> self-contained blob which contains all the __secure material currently
> placed in separate linker section of U-Boot? It could be used to produce
> e.g. self-standing PSCI provider built from U-Boot code base.

Not yet, but with the work described here, yes. Ideally you would just
add a new phase to the Kconfig and everything would magically work.
I'd like to do the same for EFI runtime code.

>
> [...]

Regards,
Simon
