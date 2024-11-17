Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5398CD10F22
	for <u-boot@archiver.kernel.org>; Sun, 17 Nov 2024 16:47:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43637893AE;
	Sun, 17 Nov 2024 17:46:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fuJWOIHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B80FA893AA; Sun, 17 Nov 2024 17:46:46 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C024893A0
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 17:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b13bf566c0so224025185a.3
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 08:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731862003; x=1732466803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oRj6fmIyo3dsuf6CR3wk5usvM0QlP7meVYABZqWRHs4=;
 b=fuJWOIHDypX2hIUTKpxZ1019csGN9eqhLw6CU2Tz56UnDBf7b4DwAO6ArKISoH0sig
 R94H6UPWtXaOqZmbfpHMs8LFTkwSgTQsQIXvOd4GqspwLsP8wsqkZC7HrfjoKlA3eyru
 HEh/lW4xX+8Lvt4H2a4sK1q7gUWLhrz13PaZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731862003; x=1732466803;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oRj6fmIyo3dsuf6CR3wk5usvM0QlP7meVYABZqWRHs4=;
 b=Y5J7Pvjr3qxXpRUVZiSAOoYjQWmJAMcrDaa1t7JNMQo1UPceQuDFqiwOCNSUYQm9lm
 N+4crYtYEvf67M7+vuhFvDf8fbVgraLsgVV87fJajpbbA55dSIPetcQUIB/dz/W2xt4o
 3nlbdrOP0PhedfYtQ1JMV7vtJbd6urlpIMZ/M2aPxdVs/pyNgSfrt89XgWLVUqYyjURe
 B4oN1KMmIOuc0adFU/eGka5Oh2XGDuGUPt4ffUhkXXxLYbkVpN3213GO6AQU5eVXS06C
 a8I+H9TF7Tc0enkn9KtSx4TzZT6RUciF/v7SVimbcyuZAhu58sONuVUg1ZjCyeEynuZ6
 xhuw==
X-Gm-Message-State: AOJu0Yx2U3pFRctPLmYgGXv9D/Pt9Nqk2RbmmJJ9tkS5lgk1WaluYzR1
 VaP/uGxKiGHQGbWtUxeCPHWh+4V7W2+yn4e+Oj5Dmu+nODEO0MYF24BzDPPYwy0AzP+3okrE5g4
 qc3g=
X-Google-Smtp-Source: AGHT+IF9de3TugWiTT8xOz7tI0ZeGRmDhYthoeoevM/KjmqGJ5U2kuVn2Q3aY+07eSBGhHxu9KCxrQ==
X-Received: by 2002:a05:620a:4588:b0:79d:759d:4016 with SMTP id
 af79cd13be357-7b3622951abmr1294798185a.11.1731862003526; 
 Sun, 17 Nov 2024 08:46:43 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca4dcdcsm375768885a.102.2024.11.17.08.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 08:46:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Yuri Zaporozhets <yuriz@qrv-systems.net>
In-Reply-To: <20241105213049.42423-1-yuriz@qrv-systems.net>
References: <20241105213049.42423-1-yuriz@qrv-systems.net>
Subject: Re: [PATCH] bios_emulator: for non-x86, print warnings if PM_{inp,
 outp}* access is attempted
Message-Id: <173186200169.3244505.13965705496479522726.b4-ty@konsulko.com>
Date: Sun, 17 Nov 2024 10:46:41 -0600
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

On Tue, 05 Nov 2024 22:30:49 +0100, Yuri Zaporozhets wrote:

> Currently the PM_{inp,outp}* macros are completely broken on non-x86 architectures,
> because they will essentially access random memory locations if called (and produce
> a lot of rightful compilation warnings too). For now, replace those macros with
> warnings (until the code is fixed), so the user at least knows that the emulator
> attempted to access some x86 I/O port.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


