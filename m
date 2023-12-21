Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7ABC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F9FE878C9;
	Thu, 21 Dec 2023 17:51:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s5yJiz2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A5E1878BA; Thu, 21 Dec 2023 17:51:47 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 007BC878A7
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:51:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3bb766a7699so713692b6e.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703177503; x=1703782303; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kr7QjIWjMx68eJHAdFsMz10kan9cDaR+4zWdhh4goPo=;
 b=s5yJiz2FNR5NEtwacZ2NBQYXRYVOqjr4pCTe+i0nG1WSvzZppxanliFurQgS+ZpI+F
 47R3foW9fjrwrQrtlYJq4V9FXlLeNYFjdinLnkk2Rw+Ub7jb2nX/w2DLGlUdWfVhORBv
 lZBppbEFm7cTk9eM7dwp5V2+OMs03hLJhVaLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703177503; x=1703782303;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kr7QjIWjMx68eJHAdFsMz10kan9cDaR+4zWdhh4goPo=;
 b=bPP97bcjPErl9kqhOrB0W+X9hExfiezjbKv2Ky9LHkDcC0zYreqahlSwyaaQbvB2wO
 7bDn9tJZBJTvNRc4WoNiAWKIvwQrbdk9bjP38cjHiLnT+fxvJqAYEWqb2gWglJRuQlf0
 vYZ2v+Hc3NapyAwie9cJ25LkhyoFbzJbkIhN12ALYrQs1rLRDM+zl9dFsZdHGlqr+sQ2
 gYQkxWqSodS8Hj/H1Mk0xBbRnJAwOFe7BWE3pHvO4vU0Qm8mTLPH7pXxnWy+5gmztFoM
 YnDP5PHHTs3tX335d4pfpXv4+wu5tveXCJCsfpS+FM686U+6cKham/NoywkBCnZa7ts3
 SlSg==
X-Gm-Message-State: AOJu0YwgVNpXHsOpvqWH3G5rf0DsKXNSM85OOKiHocnb9mXwsKRhYO+E
 WeFdcBWklH7x6VWyQD2FAR5GTfydUoHlr17i6cA=
X-Google-Smtp-Source: AGHT+IFY0sry3xxeVbz76UYBzwjjG/q/YOPqTUQppJbMiNUhuuESr1ftzJCkHsd547fQxm3wf4ythA==
X-Received: by 2002:a05:6808:10d2:b0:3b8:b063:8243 with SMTP id
 s18-20020a05680810d200b003b8b0638243mr29181833ois.69.1703177503409; 
 Thu, 21 Dec 2023 08:51:43 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a0cf8c1000000b0067f07683decsm740393qvo.99.2023.12.21.08.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 08:51:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231214181658.3359902-1-trini@konsulko.com>
References: <20231214181658.3359902-1-trini@konsulko.com>
Subject: Re: [v2 01/16] qe: Add <config.h> to linux/immap_qe.h
Message-Id: <170317750246.1616014.4220347812974512287.b4-ty@konsulko.com>
Date: Thu, 21 Dec 2023 11:51:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Thu, 14 Dec 2023 13:16:43 -0500, Tom Rini wrote:

> Given how we define QE_MURAM_SIZE today, this header needs to have
> <config.h> added to it.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


