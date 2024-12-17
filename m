Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF90E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 281B880296;
	Tue, 17 Dec 2024 20:48:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QmetAgyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 384A180369; Tue, 17 Dec 2024 20:48:36 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEEB88022F
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-725ee27e905so7284920b3a.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464912; x=1735069712; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tq9u/YBURT+SIDTyCuMOcT2tH8cf4JXbtu4E6Kx9pVA=;
 b=QmetAgyqOZpJQr/NyA+HQx79iWRhhNLqGYnEKXlOEe7bwmjeCPBYSg5MPV7gCFFG2U
 QF7NXq1U+pg/bSR7IxuPpxpEdMRap5+6iNgOhP9gHeMIR2XRSixVOmwpjOMeomcE/ZyG
 8DhoTV+gQKZAUyXLLAOHik+jLLv7wrkJLLDHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464912; x=1735069712;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tq9u/YBURT+SIDTyCuMOcT2tH8cf4JXbtu4E6Kx9pVA=;
 b=UHYzPTHzGl5jkIXNgnSU2EXs25aFF/m7KYjeImtEkis0AoNKnQUfCH+Vc+VNwkzs7/
 KE0bGoaA5e5bAiyeyUkit9fKzbpndC5WtGtwOoT15hRuNBGNCqawG6C6zryKD8PQIR9J
 kqQu85HN97GCX6DLBi20DWyw4VkNNleQjPXkB8e0wWhPXRfomWd0HkcSmANCCT6JzqkU
 H+WnJPRJc2YQmYnMkTLu0qs4DJxI17+FLVMW3Z3CUap/Uv5YN4avmGjHj5/LR323OmxT
 flJMe9pX+T7tgwNXLJQk3QPNvK7QI4DPgpiqnoo4Ajbx/32Lmls+lmza2GHoEcQBQhgd
 o3Bw==
X-Gm-Message-State: AOJu0YzN6kOy4IhDzpREJ7XYk0QsSQgZe2IbFvMPwdImc4IVEHFBFa7V
 geGYE9+3yFH3qeD9Vfv+49qw77oYuZvg2jWMKiFNrycyAK9CTS7ahBPkpTozRlAfZhCkuM203s/
 moBalD5JX1mQODQhiBBhxCz7C8ilIMTJppRv3
X-Gm-Gg: ASbGncvXZ51xtS6+hZDoNhg7h2UnbhCC8b8zF5slPs5Xi7wwYqZEJiezV/tP7SJ1fn2
 0g7eTNIjK3Qma0DFj0TNQM4NEcTicT1UrO1+yZeM=
X-Google-Smtp-Source: AGHT+IGLB7k1mZln05gfYguKMM9KAJN3J3+xf5sNpBZxJvFVcMJ6QDE7wGmsygRNjnxVag57Z425PmoOAWvrw/3SeEI=
X-Received: by 2002:a05:6a00:1311:b0:726:41e:b32e with SMTP id
 d2e1a72fcca58-72a8d01fb20mr384268b3a.4.1734464912372; Tue, 17 Dec 2024
 11:48:32 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 11:48:16 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAC_iWjLW2bjggoXHaWEYSv-eLQAg-W3Zg+MVtCQuFF6JhXbiPg@mail.gmail.com>
References: <CAC_iWjLW2bjggoXHaWEYSv-eLQAg-W3Zg+MVtCQuFF6JhXbiPg@mail.gmail.com>
 <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-3-sjg@chromium.org>
Date: Tue, 17 Dec 2024 11:48:16 -0800
X-Google-Sender-Auth: t5B42jGSrBreypc2w8JBQLlWHWs
Message-ID: <CAFLszTgB-Sznk=4vEz8PCrcYPxdGdoTvz2w_SoOdNjoTf3GAUg@mail.gmail.com>
Subject: Re: [PATCH v5 02/23] efi_loader: Fix typos in enum efi_allocate_type
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Simon Glass <sjg@chromium.org>
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

On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
>
> Fix 'indicatged' and 'adress' typos.

I don't really like patches that changes typos. Personally it only
makes my life bisecting harder. Since Tom and Heinrich already
reviewed it, I don't mind, but this really has no place in this
patchset.

Thanks
/Ilias
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>
> (no changes since v1)
>
>  include/efi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Applied to sjg/master, thanks!
