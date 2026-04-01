Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F7B10F6FDB
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 22:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BC5B83CE3;
	Thu,  2 Apr 2026 00:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oTqYwJz5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0806283CF5; Thu,  2 Apr 2026 00:07:47 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1481980517
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 00:07:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-66ba9dfe83bso330528a12.3
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 15:07:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775081264; cv=none;
 d=google.com; s=arc-20240605;
 b=NfIGfUwzo74yeXLrZqX9njdEOLfAcJg+lBDnGmBFARuRFDBSPIlGYbbLhhYNxver6M
 dqNncRaVHXO7sHQKPlRGqOxonoFPMFsjuGVJSmB1eiZS009xe8K3Jc0T8LlZCpvOYDYQ
 0Wm7GyQamh2bxZhvEGPMZ8QAtV3CGli6279+BRHwUJTtDPWnzZoN1LRsdNI0T7om2hRS
 0uDaFlbb0ELpR53O9HBjKqlR4PeRoUYr+8d671HCIx+E0GMUCCfvvxQiclWRQYEhvqwp
 HAPvWyDfmoKWOFkKyVdq+vf6C6vE6FWjuOewG1uaDVqFJfzzArCB/5hk1hH/DZ52ccDh
 NaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fvYu0PLWjH1fwRqNfvVKduTE66Z62bX2fNUWbaze164=;
 fh=mZrpf71SDXGn9fIeVFiNgdonkuPwb1Sy1rTdAgGdg4U=;
 b=F9Ynzik1cEb1YcVP2lvjNz5WI8UyRgxms0GljyJ1pJywJPR1451W1Gediwcu2Banxi
 Mb/E+tm1ClrDWyPdF7xZEY+BjEFXYOxGEsIDnoCPTqdonKJVcKAZsCymathwo2IyLJ9G
 fXW/m513hNJIAuQgWrgDFAlk9gFkev142sZYKxAiuzLlUQ+hsA5oxPCeFGzbr6jlr7jR
 3kPKYYvZFzd0uyKAVADP3vNGM8rjfPNPqWZ99TgzHCVd/nC0WIEfigwj+NbBwwMnOo3m
 zNjsL0MPf/W8Io4A2etPhyK7xwGzrRrgYKRx4vR7rOlu73cvx2urQtFvyJKDZ9z7jPEL
 8LTg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775081264; x=1775686064; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fvYu0PLWjH1fwRqNfvVKduTE66Z62bX2fNUWbaze164=;
 b=oTqYwJz51Co3+zW5HizLRdG3CxjZkf8aeDvXQcFNOlTEAziPonFpsTnUdhCLCqtkYG
 aJlwxiR4F7rsMGXmW1pcBYBqPFtROoS0gAgf9RZ/stz6PP/TyuyAZJ0rlQawxPbJzX/q
 9nG1I8Zithe7yQ3xlcimYFKhOWZgqft/CqSpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775081264; x=1775686064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvYu0PLWjH1fwRqNfvVKduTE66Z62bX2fNUWbaze164=;
 b=YvXdHbyfZ/ZSzMmD/p0Q4hpfY7f8zWaufMTZ65+6zT70p3bnUjT0aoUEQUKlQSTnHn
 oaa6JnS4VTrJGukqLY55fCdww2Wajz6sOHAm9MvZ9ecTKxIIMhbRTam+wYnTQYsje81s
 cUkyfe3BNfQZz2jPlYlrjtBPfL4dSoMMQK80af7Egn+kzYHjP0obkgsvXNilXiiIcsx/
 GhYZBOHaASoSfSYQDLt8uRMNep9Grkqgi0a7Htj3M6xWAkp1u4uor4lax1ahRbB2ui49
 A6qZHOF/VLoIzZptlgcj2GP/su9TlyCxO6sChVkMJGMTjfoHrYDbQ1NYQuDOTqRlRdf7
 MYAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWYoioRXrM8y69Qz98d+gZ3kIIGu4z9xFseznXW2KmN3Em8xGgkOTCNGEbW7M/nUHGIscxboY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/C6HaXphtN1c3fTRQ2m8AK5eX3iwA/jLYIXOswdN79ZgZOGQv
 LxFzk16xraNnMabgXGf19Z8FfKau7z1nu23o9ZbpL84rkxEEWYteV61LPX1BipLN4VuBkQtWgP0
 P/YYEpJuFGdsx9TOBkchDsKUstC4vJcJiTi/JOqKz
X-Gm-Gg: ATEYQzwu6PDhfZy1H+ohrDiVztgU7igpJe8qF6Y7ZPgn0yIVXI423p3VdtzA7BcA4sT
 Gn3bgo9LO2d9ygLKR53gkZ2MPJWmjS7mpfCa5zDz/Wab+IC0CFimHX2SBGkBrXLVA+7k8BtVm3Y
 1ubNUg2YI3KMhfu77cmIUcCuK7ygcranLLKqiUXA409TmtNMyeJLj6/iu/S0VsgRhEb+MF8dWAm
 egs2/2dL9C7RbmW2kDrTwaSYdHAmKSjuB1phHclJF7eqa//Jmykm7u4nNapRwMnWbpfunZYDr0s
 PXYPBg==
X-Received: by 2002:a17:906:f58a:b0:b97:bc6b:7f21 with SMTP id
 a640c23a62f3a-b9c1337b179mr326896866b.0.1775081264317; Wed, 01 Apr 2026
 15:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-6-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-6-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 18:07:31 -0400
X-Gm-Features: AQROBzCkdKL1v8J8voU9ZJOemW1eeqBbvJs3tbUO8bTtk8Yj5ot7Nhn-FjuKzfo
Message-ID: <CAFLszTgcZtL=mfCu7KnzznRLn3CnU0BTGcei_n_BXZ6MgG1YBw@mail.gmail.com>
Subject: Re: [v3,05/15] ecdsa: fix support of secp521r1
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

Hi Philippe,

On 2026-03-31T10:00:34, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
> @@ -84,7 +84,7 @@ struct crypto_algo crypto_algos[] = {
> -             .name = "secp521r1",
> +             .name = "ecdsa521",

Raymond already raised this - Changing this to ecdsa521 breaks
backwards compatibility - existing FIT images signed with algo =
"sha256,secp521r1" will no longer verify.

If consistency is desired, I suspect the better approach would be to
support both names during verification (the old name for
compatibility, the new name going forward). What do you think?

Regards,
Simon
