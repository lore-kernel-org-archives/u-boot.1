Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B3FD2CDFD
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 16:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE7BD89049;
	Tue, 22 Oct 2024 18:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T9jmnjrC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38D3388D91; Tue, 22 Oct 2024 18:27:15 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35D6688FA5
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 18:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b15467f383so371994385a.3
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 09:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729614432; x=1730219232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5SzwnjZNuFB/1R2He3BQegZCdBHDuACBC8OUQkmqqjg=;
 b=T9jmnjrCq3Mue0qZXOopBXxItRlYO8jPsRzl5CWwR9pvhWl1LTJxQViIHt8TUG2e3z
 5SGfRBkaxChIJ74nqKNWiXZY/fHD3bvBv7I3KM9swN55vROrRHvBtdgCSq7v3p+nD0HB
 DnwinZTkPzJ+S9v5jSrBUNkYxpTpTuZFIrSAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729614432; x=1730219232;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5SzwnjZNuFB/1R2He3BQegZCdBHDuACBC8OUQkmqqjg=;
 b=qZM+WX1dxa8AkGYPL0ky1T/XnHbCIACTiX/nJpFlTMiayTKh3Ms4jSC2gKx4hqMTNv
 CCXkoSBZZz3TBiREFFMEIf6cv4OZ7JF6wivIFILhsXM5Rj9f9BzEGKoCwJ6ySRLB5EeV
 xMhZ7FFILvkqJVeERQrrF1JHgtG6ItFvBl/aeI8eiHdJdcj1RLDwxA3zgvt/0WqLBG4j
 5T5qeD0OG3YaKWnfIBhgc/IRMwlb/2LFxvF/40m9bcihm8/iphQSccND8HSopP4wAwzq
 RhsoCWNc+zsAKg8E0gSxCdYC1+uj50kSPUavEB7NVoOlquUtbafurtFRwEGxUDGM8hP4
 Xa6w==
X-Gm-Message-State: AOJu0YzsFxY9YRejLzSLiyQ4NzXZIVedwJIw9EgcE4bTykDo0skoPXZh
 hhUgpiV8GpWrgdrgLJDZkMaGsFyhDI6WYVhyueDAEf70CASkyLLLK+835JY7/ISzTvXISiqIIev
 tq7dNIg==
X-Google-Smtp-Source: AGHT+IElOS8nb2nXfYqL3hMx57R+fGH9T1AzNz0A35KQzY1xXWQU3/zc6IckgERyu7666pQ7m/p0Sg==
X-Received: by 2002:a05:6214:5542:b0:6ce:2fa1:842a with SMTP id
 6a1803df08f44-6ce2fa192e3mr14970616d6.15.1729614432098; 
 Tue, 22 Oct 2024 09:27:12 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008b2be4sm30344046d6.2.2024.10.22.09.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 09:27:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: emkan@prevas.dk, Joe Hershberger <joe.hershberger@ni.com>
In-Reply-To: <20241016151035.709351-1-ravi@prevas.dk>
References: <20241016151035.709351-1-ravi@prevas.dk>
Subject: Re: [PATCH] envtools: make them build again
Message-Id: <172961443103.3127138.18439537072758279434.b4-ty@konsulko.com>
Date: Tue, 22 Oct 2024 10:27:11 -0600
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

On Wed, 16 Oct 2024 17:10:35 +0200, Rasmus Villemoes wrote:

> In v2024.10, "make envtools" is broken for at least these defconfigs:
> 
>    am335x_evm_defconfig
>    rpi_3_defconfig
>    rpi_4_defconfig
>    mx7dsabresd_defconfig
>    wandboard_defconfig
>    imx8mp_evk_defconfig
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


