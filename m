Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E90C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 20:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B9588780A;
	Fri, 10 Nov 2023 21:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jnPj977B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78C7D87812; Fri, 10 Nov 2023 21:18:04 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19EB787750
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 21:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-41e1921da84so15750931cf.1
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 12:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699647480; x=1700252280; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJ8JCqzh7BjWx/l8yFYvsK+J0gD1qVjDGW93htBTFWo=;
 b=jnPj977BfLlVgv9NoDof99p2tvmFS+NXce6lpoEfe0l2WaZyRE5ouVbxC4Y5ImYSwh
 t7TbpVlg/Z3vFvL//LUZL8MtJrSf34xfbJazlgD2oq7G/QipFb08gVz+SFEKeM9yOg1b
 HCDsjheD9zbEDPjhTevBDMATGfAXx4XPFDenc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699647480; x=1700252280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJ8JCqzh7BjWx/l8yFYvsK+J0gD1qVjDGW93htBTFWo=;
 b=pFM0XgpRUZmGbb09KR4WQkVYz/7UvWnaA1tQYYL5trILQsH8gIY+sqZJdvo26NSkla
 t5gIjW7umajSgV9lL7VBrCuOFGn5yRab9iB4Wi4Oj6Je0oXDeuZoL9ZhlK1ydZAVJ8gM
 4HodkqKoNhjedxEv5bwV0l5b5cKfDXtdooT4xFhkOJY8CLuk5N7l7YuYWSUNery4XXLU
 KORpHvy1HpNh8UPpR4VaVG5Lt13Q8cgnI+3CBvKfqNvPHd2EoocFdpaZcYJRMt6fUmkO
 40awyeik9rk2/FkAlq2+8z+c5rRhPlyIcCh/+gbG4F2mygHX5pHTZ2ND5di66IESJCio
 pKmw==
X-Gm-Message-State: AOJu0Yzo0TUYU4eT3iCXOGGVfgARzIbhC09CgS6WRB6tH8RMxuvU0vk/
 mA3DKXKTatbTyPI2paNz/dfQC1wCJCYqmdqg/pOsBg==
X-Google-Smtp-Source: AGHT+IEVD3hAZrHH9qDmZxpR62vL57kHGFUrS+0IvkBz1XIhpTkz+lDia/a+p/z4Q1c15L6yXRGvxA==
X-Received: by 2002:a05:622a:20c:b0:420:5b48:4a54 with SMTP id
 b12-20020a05622a020c00b004205b484a54mr90447qtx.23.1699647479939; 
 Fri, 10 Nov 2023 12:17:59 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-046c-8850-3cc9-4453.res6.spectrum.com.
 [2603:6081:7b00:6400:46c:8850:3cc9:4453])
 by smtp.gmail.com with ESMTPSA id
 t23-20020ac87617000000b00418189b689csm68279qtq.10.2023.11.10.12.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 12:17:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Sean Anderson <sean.anderson@seco.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 0/3] arm: Semihosting fixes/improvements for ARMv6 and
 older
Date: Fri, 10 Nov 2023 15:17:58 -0500
Message-Id: <169964745343.4002337.13631888279754508356.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027204015.1547595-1-sean.anderson@seco.com>
References: <20231027204015.1547595-1-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 27 Oct 2023 16:40:12 -0400, Sean Anderson wrote:

> This series has a few fixes for semihosting on ARMv6 and older CPUs. The
> first two patches address problems regarding the stack pointer and link
> register. U-Boot runs in supervisor mode, so taking a software interrupt
> will clobber sp/lr. I think we really should run in system mode, since
> it has separate sp/lr registers. To quote ARM DDI 0100I:
> 
> > The remaining mode is System mode, which is not entered by any
> > exception and has exactly the same registers available as User mode.
> > However, it is a privileged mode and is therefore not subject to the
> > User mode restrictions. It is intended for use by operating system
> > tasks that need access to system resources, but wish to avoid using
> > the additional registers associated with the exception modes. Avoiding
> > such use ensures that the task state is not corrupted by the
> > occurrence of any exception.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom

