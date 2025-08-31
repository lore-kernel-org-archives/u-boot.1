Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DFFCA0EFF
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 12:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE18983443;
	Sun, 31 Aug 2025 14:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UokyGpfc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C5D4838AA; Sun, 31 Aug 2025 14:20:33 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A34C83327
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 14:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-61e3b74672cso594545a12.0
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 05:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756642831; x=1757247631; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lMw5CUfTTgCwtztvfiFLbmdcXwpk6RXcU9Pcuu9HHp4=;
 b=UokyGpfcqe6Imw7OACQ9dPQ8ae/52stXi1Agf/m+SEpXD/2yMn5QRZ5UZPLn/q4Pqe
 bXaiR/chEjTm7Sf35p1sju+rgKUIjDdlg9M3pnUS3XFQi6Kr6r1gN5JJasX/yeYTPWSZ
 T55B6g3P7CJHbHoa2F/kRZtcro+pETN6mmLbUjBzoxuGZY15bfRat/TIozxzzhtqlPWh
 C5k0XWDi7rwOTnE98m48pnjM2TK6E2Sq3us9QrtAHuCQL9EXQ5z2VGyx1DZJ4kOGxct/
 am1UqAMEX5eK+l2fniQpinGr9R5rEKaoPYXLcqOBuLg3nZ8cFDBSoyZgWbQBVToPBG2H
 2n5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756642831; x=1757247631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lMw5CUfTTgCwtztvfiFLbmdcXwpk6RXcU9Pcuu9HHp4=;
 b=jaKYHVMhm33tz7XCe2yi6OB7ZPPCDw0JTThPbqEUJCJceG6cNjOif66QBmh+2CCpcP
 2xgtZRtmCgk9kiV7/Efa3oQennrgU3XCu0ZFkGMWs+VA70Oq1MMWUlbnPwxR/ROhAXH/
 rTcrGdA/joGdpAvJQooIC80x8pehGcU5VGLlyYaNaFFlX1O15L/BmI8gJI7m6ScNuUIQ
 vQo/Sq3GFfRi3X566vBAvGVQIwNtI7kEbvBb7+Ke3+GIxFXxV6UE8yPb3aiArLF5itau
 JiqUN2JxPNXThSK6hCjuXCBD1mVTOy0jxUizF7dI/DFcQ06eW5hQ8cJmMyKbMezUgnrd
 WN+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAntpSCZEeavMqSbnPmPRaY/xACtp2bONKcfBiauahgFeBd6KuSlpcW0FeqkjXKThiC3fVVV0=@lists.denx.de
X-Gm-Message-State: AOJu0YzPFxklNq2XJWfuid0LivLOBPHPJs82dFI/vinD7dHgr/OmI2t3
 Eq0CVT7Don0GxAtCulTeP9MhmzXWsD6MDzApwqwdPCCrP/lEG07d64/txkZuk+lY7LFt79lhAgH
 BxqIxQ997qF94Hyg7ZtDp32QKdqFGD18=
X-Gm-Gg: ASbGncuVkBeHSmIu7I0mvFK8TO5bL1Xl81u0ApmoBJq4UYY5CRlRaN/pLwe6zejjmI1
 /bVBah5j2bfyyd2mCUDdsmOrGHMn/+edPYXg0odNuaGxEhq6Svt0ypHoJ0ZIDY0H/jml8Y2AfsC
 /MaunrffY4jXzggVKY2ubxnxAjOjzJGt+vUg8QG6vNU6swsyMcYggSGknAuGFyVmXnfZa/xiUW1
 oRvPcrDynUauBEjT5xBIgCJFaiT+dzjyq8teNc=
X-Google-Smtp-Source: AGHT+IFHS1wpRE/FxPYeOVcVN7UK8x69mIiUILpBtets5xX2q5tZT3wqW2WAJwB5oP7cRuXHtH/UTcdO1GeS2M6uHbg=
X-Received: by 2002:a05:6402:2681:b0:61c:d3f1:9b02 with SMTP id
 4fb4d7f45d1cf-61d22f522f3mr4463261a12.14.1756642830369; Sun, 31 Aug 2025
 05:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
 <20250825223251.674591-11-adrianocarvalho.pt@gmail.com>
 <4605b3ff-6499-4233-be0c-bd3a0898b1c9@gmx.de>
In-Reply-To: <4605b3ff-6499-4233-be0c-bd3a0898b1c9@gmx.de>
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Date: Sun, 31 Aug 2025 13:20:19 +0100
X-Gm-Features: Ac12FXyuWDql8DddkHMsSCCNURAUAHvS-AHgDSH2oBDR5TWpdUcJg3IcCZE7MkI
Message-ID: <CACAHuLB=Dw9RdQ5d_WGkyJUhWLkES77anXj7j1kefZUw-_0dQQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] doc: Use a em-dash instead
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On Sat, 30 Aug 2025 at 16:22, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> [...]
> This file is also used as output of buildman -H on the command line.
> Unicode does not work if the console is using an 8-bit codepage.
>
> With the patch an error in the CI occurs:
> testtools.testresult.real._StringException: AssertionError: 67348 != 67350
>
> For details see:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/1234573
>
> Dropping the patch.
>
> Best regards
>
> Heinrich

Should I use "--" instead?

After using "--" or dropping this commit altogether I should resubmit
the complete patch series (not only this commit,) right?

Com os melhores cumprimentos. / Best regards.
Adriano Carvalho
