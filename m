Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D588CF34BE
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 19:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A1AB88EAB;
	Thu,  3 Oct 2024 21:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LCFIB8HM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5F9588EAB; Thu,  3 Oct 2024 21:23:12 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A115B88E4A
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 21:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7ae6f8956baso5698985a.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 12:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727983389; x=1728588189; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6unekfRwTeGVEDdJILGWY7VI+r5jKqjIT1hvcpaQBU8=;
 b=LCFIB8HM2TjCpSeDvpXGfEgogBpn+f/Idahpl+n1pmCsMeNNKMXtMPv1uNEzmAwQUh
 C5wNv9cOxjNxAWrfUHL1+6EYfWgMm5+MafEH5+4a4Eu+64v/+NguBoANqDrLnDdTqCpk
 5RyMbdseeBE6BjXhaLYMV2OfD17AlUb90G6rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727983389; x=1728588189;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6unekfRwTeGVEDdJILGWY7VI+r5jKqjIT1hvcpaQBU8=;
 b=iCyLxmAryHOH+Uxnb16YtH+VLmx1u+xP8Nq0vy+dSEmeplVyxOTb8DOhxiKwFH/zvf
 mOTWjUZu/YQ/pZ2MNc5dKAWhBZ9RkUNlq6omqOAo7cX5LjZa0PvkRJT+4RNJsjgSrxm3
 Jq/cu5Bj2lbqLRH2nhjo3H6VCEkuFGBjALk+sYKlHFHgiiC3tXV5AIx3WNvU2ySZpchV
 eoTlq3BTCnqst/o80ZJ1/hdzc53f1QsutG68pt2u8xzlqN50Gz5lD9M1UMXrehexlYhd
 cWZArghSNgXM/4Ne9rMiw6hKaPZQnlTSWvVlOqAR2E+L3G9Byp6nqKigVx1RYtF27IEa
 hYBg==
X-Gm-Message-State: AOJu0YyfkylJyhJPR7d1wFu6AHZLujicI2QGzE0ojEPWx9WuPZhZdIyS
 TVtFzcGwzNHZyDSOLVzpprUg42x70c3g5L5DwZEFURDCygoW5kNB7yzRsFiGwCI=
X-Google-Smtp-Source: AGHT+IHQu12ClLuj1X8NAxFnypxijjIW2too1OEL6FXPGOcz3rd85ElewItdEUnR2/hLooQ1rfYPhw==
X-Received: by 2002:a05:620a:4491:b0:7ae:4b83:daf4 with SMTP id
 af79cd13be357-7ae6f4a5b04mr40708285a.62.1727983389415; 
 Thu, 03 Oct 2024 12:23:09 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae6b29e222sm74464185a.1.2024.10.03.12.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 12:22:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <20241002180853.227389-1-pbrobinson@gmail.com>
References: <20241002180853.227389-1-pbrobinson@gmail.com>
Subject: Re: [PATCH] Update the ARM trusted firmware git URL
Message-Id: <172798337106.1632163.8839902017357556484.b4-ty@konsulko.com>
Date: Thu, 03 Oct 2024 13:22:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 02 Oct 2024 19:08:49 +0100, Peter Robinson wrote:

> The primary upstream URL for tf-a has moved, in some cases
> things like tags are not always pushed to the old URL so
> update the URLs to the primary upstream project URL.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


