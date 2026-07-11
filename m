Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC89C43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 00:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E7F384AD9;
	Sat, 11 Jul 2026 02:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A7iYkklk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E18B84B59; Sat, 11 Jul 2026 02:17:26 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E50F84A92
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 02:17:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-45171f2f608so833374fac.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783729043; x=1784333843; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MfZMgmpagudzbZPZ7DIeKFCNtJ+ySJpzNg2zR5Nwsms=;
 b=A7iYkklk/e2uus5IGKqgsdTiINwQlyVC5D1REY3+rdmohdOy6/+TWcQ18T1wQdgK7v
 oEfa2f6LxVk/V/v69zFrI8IAyRWPO29t4uIJZHiqB6exmbvjM+DjUx/pXm+Dre/7ZlY+
 pAp+GpNobHT+clT4QOfauxXxFkkDMyqFCxn4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783729043; x=1784333843;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MfZMgmpagudzbZPZ7DIeKFCNtJ+ySJpzNg2zR5Nwsms=;
 b=lhwD/f0MO/1/keOBAk4fCMqUpVpFjF/ifoLm44kdbY5XYNxGaGTCVU5NhoJBsOhrfS
 CA+cdS4cxV1vTbXvIK5OfrQT9DHBK+X9CnEDBEL2Z62MnTOgRPxinZFc7WWx8vZmL91e
 5mo85BjaYtkrwK5jkZXCFcZrHKYNDgbgjLCnTb9CkyF+nSXE+hRb2lO3kzOcc22xneBO
 0cnqcUJFle9DNNYgSNDpxtbY+nucWRGdvcyzxao/PbgBMJxulXz/uMa3w+494OGhxUc1
 2ODVmyzM6eOutlfncm2PjUzAFm9KrqH4rN8xElpH7qWmA2ehUks1V9ZvvmyCIaTO/aQw
 /zrg==
X-Gm-Message-State: AOJu0Yz0culeZUaTBYGHmJ0sQwZzHq07olxIc/sRACjhCxeRpFVtvHcr
 x1cOLnHwL2OcZIyR0IVUUj6UHWdjp2iUQKBpdmk1Q4e9ov70zevfRomV6Odtsr14HLs=
X-Gm-Gg: AfdE7ckMtjrFLKk35UG0mnMfK/7tH7oMCOfNlfG9z+u0JMMVNTybfqdXizjKKZPqpTK
 xNhEtz8JJ81ohHmhdyDFDZZLoswWoimU4J0QUGkQKmEr5erMuyNxRBNJaUQ+wY2rjTtzB+s4MkI
 yEbLhnr+z2v1TqVMnlJvyYJtHh5ofXE0NjV+gaLdB5RLATDrqbUMZsWww4+IzPg2vqYNG/GzmAu
 CjKjcl98cnsyBjVL66Ne1N3g44dCRp2u3B2IogRjyTUTkuRLpVXVLc6YgGEtnkgnbOUQZtwEK1L
 BgKflcP3MlmdsGxedCjbpbiIh7S0QdmcjMkxWTwtw4NaKlF9fojqL7I4ECmhEslVw9To+7vo9An
 cWICzw7z1SMK6wsv0Eh9I+YoupJWjpq4RPQ6rULudjezXJGcI6O0nebgORcuvjACnu/28Sx+bxC
 VVow4tr3e0wu+DsN3++ObqHVcrrY21nNS5CSmyia5sSeCfZbA1vy7uB28d30h/OLOO6MsGLIP2p
 fVv33u1SGihqm/gGMZcyLvVvmNQ9NhmQIR1
X-Received: by 2002:a4a:e913:0:b0:6a3:77b8:7115 with SMTP id
 006d021491bc7-6a39a709eedmr834774eaf.53.1783729043076; 
 Fri, 10 Jul 2026 17:17:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a39af0e953sm651312eaf.3.2026.07.10.17.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 17:17:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: john@harmon.hk, Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <mpptnmlat2m7k64ny3sxdv3uw7rjysmn6bh5e4f24rut4g4maz@w2jsuzudjwev>
References: <mpptnmlat2m7k64ny3sxdv3uw7rjysmn6bh5e4f24rut4g4maz@w2jsuzudjwev>
Subject: Re: [PATCH] cmd: clone: report destination block number on dest
 write error
Message-Id: <178372904205.2905849.8779013019773395279.b4-ty@konsulko.com>
Date: Fri, 10 Jul 2026 18:17:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 26 Jun 2026 09:15:42 +0530, Naveen Kumar Chaudhary wrote:

> The error path of the destination blk_dwrite() prints srcblk, which
> refers to the source device's block counter and is unrelated to the
> write that just failed. This produces misleading diagnostics that
> point at the wrong block on the wrong device when a clone aborts on
> a write error.
> 
> Print destblk so the message identifies the block that actually
> failed, mirroring the existing "Src read error @blk %ld" message
> above which correctly uses srcblk.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] cmd: clone: report destination block number on dest write error
      commit: dc3606a961fae711e51d0ec9e0cff7999b62ab2b
-- 
Tom


