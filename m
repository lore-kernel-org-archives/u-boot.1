Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BB3CDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 20:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73059847C8;
	Wed, 24 Jun 2026 22:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="grJsgtNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8101A849D2; Wed, 24 Jun 2026 22:49:25 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AC92800AE
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 22:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-486560db81cso1010202b6e.0
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 13:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782334161; x=1782938961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SkvDVY1jv3av4GX4LLuR9ZAaTPP0ZLn3yBtW8yVeMao=;
 b=grJsgtNh3Yf207obexXjP2EA5SPDjta1hJzCUo+nqwGn6XdJjDI8cQpZmIWK+kLDTw
 ygdswlbze7cpGJXVvTYF+otaqFPvpw4iAON37aXMTlqd/fDuopyY5y7O6eq9cEO+TEGS
 BWzRa7n+ae477JvINRm/3WcEaOmuD6XP7T8Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782334161; x=1782938961;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SkvDVY1jv3av4GX4LLuR9ZAaTPP0ZLn3yBtW8yVeMao=;
 b=ESUfdTgQbxndn/XHIKPT6M7Mtcqb1kNtLisW1p/Ikp3cTrKMc8L5NWisj1Lr95IBf/
 XINtQWSYRHpA2/YqWdU9P6rDrCFYwBYwAS7udyjno0lc8RSRyulVhD316u+GU7PkE7Ud
 XOcIDBhefRLG+ALEXuwti5MoyEGORk8lOHgcW1XpPtN+xKI6ANtnaetIeIkQ8T7UCbNT
 YFZ8wSj0RhbRrxfNhMmTN91UhOsEfi1rzlE7MywkE3hAj1pOQLtR66CdlGfZ63d8WSBc
 qx/yNvzAOhQ4m2JVYa0jrYPjvPtnGmagm6/68m7sB4uBQWJiQt1bjmYvJF+AOmyuqeAA
 PEuw==
X-Gm-Message-State: AOJu0YwiwoZ93HQSRt1affRuTmWYbmoYP5LJTBzaISzkFc8XoctrPO4m
 ZE4AgyPg1VfHmBiIyrqkr08+eLlN3QiekgBbqXIQarRcuZjq2hHn9Pxgms7DB+v70wQ=
X-Gm-Gg: AfdE7cmYLzKSiA+3/Cnt7xytQ4GSbDnwY11cCtKS7If9bisIAhYlQ2GsJ1H/cMWSXzc
 FHHOtHcxOJZPLweUK5LYS/VI1BOk2Ye0Ck9IMlDo1y+bCllaiK6M+e6j9MO3Nsijhs0Mn4P4XIE
 8JAYChlVXSlroGiHq/M7gIKINj0/XkUuV364AmgodlmLb+6WkvgJEl7P78ClBe/zeF+aNrNFuCV
 GfUK8cZTNbQvWDTiL6pGTWYR9XUe8W03CDXcfmRcvu2m+dU6J6duRhPjX59+i79mSzq/oYzSl8p
 WI2TIzmJ2MHOhl3XR4vZLWkHmXPoErYhUVyg8tLn1/AI5c1T4rjvX7QVEZIrj4YH9itwJijhpuZ
 W9wKqrVTFFdm2w32iMyxvF6X0+Mxnw9JWjKgSrSjn3NvP43UfQf0MOWR3zW0QEz5lmxqEuFzoKT
 BOn/CWtx+AOQsYac4PoJqN0bGxLPmdpgQ8JmQ1GmoKYdyNbiQKqszWiFcOwP7jveijvJNQRnI26
 ivjop+I4g==
X-Received: by 2002:a05:6808:3a1b:b0:489:352c:5153 with SMTP id
 5614622812f47-48ac065db9cmr17913339b6e.21.1782334161172; 
 Wed, 24 Jun 2026 13:49:21 -0700 (PDT)
Received: from [127.0.1.1] ([145.14.135.239]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-48aec0e5e53sm9020733b6e.8.2026.06.24.13.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 13:49:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260605134446.825678-1-alexander.stein@ew.tq-group.com>
References: <20260605134446.825678-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/1] global_data: fix type for gd_malloc_ptr()
Message-Id: <178233416021.3662130.15349189030828837592.b4-ty@konsulko.com>
Date: Wed, 24 Jun 2026 14:49:20 -0600
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

On Fri, 05 Jun 2026 15:44:46 +0200, Alexander Stein wrote:

> With commit 92aa3ec321b5 ("global_data: Reduce size of early-malloc vars")
> the type changes from (unsigned) long to int. But the type for default
> if SYS_MALLOC_F_LEN is unset was not changed. Remove the suffix.
> Fixes the warning:
>  common/spl/spl.c:800:23: warning: format '%x' expects argument of type
>  'unsigned int', but argument 2 has type 'long int' [-Wformat=]
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] global_data: fix type for gd_malloc_ptr()
      commit: 157186fbfc24c54117b41e292a35809a0560b9c0
-- 
Tom


