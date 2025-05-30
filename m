Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED67C5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 19:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E41E883423;
	Fri, 30 May 2025 21:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f0bCDbIU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09C4383416; Fri, 30 May 2025 21:39:19 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7727382B72
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 21:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7304efb4b3bso1485168a34.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 12:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748633955; x=1749238755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LlSpTWKsEx7ro5tgS7jOoMQ6ASw7SFj0fK3QzrKPcp8=;
 b=f0bCDbIUHbwV/PsWOhX2lkuPvXrZSa8xi7glBHNXPgS4kcNVSNmwfhAWnB/0C6a5/8
 bw5F04WEDtFvCueWu/R3RhBwGcmE3GTmG4lriZinGQd6UF65xo7XYLv5DT7OSISjYIyH
 yvEvJcKd7kMgtFS3ehXt5STw+aQvBZ8it6+oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748633955; x=1749238755;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LlSpTWKsEx7ro5tgS7jOoMQ6ASw7SFj0fK3QzrKPcp8=;
 b=YSKrNhnMTBALSWJxIsikJUeqAcpM51+quhhrRT8kLG2542Ey/tPdkH+aCEaLRr5QaF
 iC4VWWn2dLsjAxsAq8r8E9edje+O4lWy5WqdBoBeqyrKArxJkaDEaFnM4fck/PdEXFXv
 4QiQF+zsX2NSfv0rHXDAC2VMZQvFMlmiKKx+abs/X4Y7IXCCtmDWkkD93DT9YZ8rLoho
 0Q6q+FtdOM8NCAZNEzOFcSTnQmWBTMzHV7P2+Zo12fK3hHX0s/akJRfoEtkGqUb7jthz
 SOYic2iunZE5c1ryLw0QIXJImhyK6y2QwKQbzt4Ys+U3Zo6GnYHmtu8copRKFh/g3Odd
 wtUw==
X-Gm-Message-State: AOJu0YylY2bnGiR8KYib/yAypp48rAChYBvy8kym0LRoepr0PDWdQXD8
 Cm4Y1soB6iRdQk/AyqcVONwOCNzINjjjOLIORJSxJ9uk0WBVHZINfljWCOxUBQPVY1Q=
X-Gm-Gg: ASbGnctgpPpBGJqdvi8yFnWQTenOi12e0GiBVB9PyvcARxlUYUnDFC+m1g8JGpmn2m0
 9WeTCVa2VufQ5mwtAY4g4R7LaZAnw6EDh+Yb8jcTpGcJ8gcm6l0XhLA9e/INHXBnUTZ2OO1wfiX
 6WpN7/49isMsk+adTiXCE6YjQi2UJpa/j0P1IQGWxBYBVMDhT2M6ABlv3wdDWID1Cyu2wDrcxZI
 DPi3SU2Y8ZsATMUXObO0HHZTDS2BHt/QxdFx0rqtTtE7qzSEr3hmTzUtQpoiOc3MTYVciU3Ggm2
 Jrk2ER0ngu6ohqAfEiGSXhKJcssWVCiRkztUUpV+bnBwa9KdGqLeEhNeE3DIHTOZOTZY0ZRsi4c
 KCEYCBe5qYuk=
X-Google-Smtp-Source: AGHT+IGH/+8FZtqo/MgC0E5djCpgE9sDho3oWUOZYCUJssNH1o62UjIMQwVYnU0tyOLPHqiu5uW1xQ==
X-Received: by 2002:a05:6830:270d:b0:735:aca2:9bf6 with SMTP id
 46e09a7af769-73676b476femr3126219a34.22.1748633955209; 
 Fri, 30 May 2025 12:39:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678ce8267sm491805b6e.37.2025.05.30.12.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 12:39:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
In-Reply-To: <20250512155859.145717-1-marek.vasut@mailbox.org>
References: <20250512155859.145717-1-marek.vasut@mailbox.org>
Subject: Re: [PATCH] image: Fix FIT image loadable section custom
 processing
Message-Id: <174863395358.4062885.9394360068999344887.b4-ty@konsulko.com>
Date: Fri, 30 May 2025 13:39:13 -0600
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

On Mon, 12 May 2025 17:58:39 +0200, Marek Vasut wrote:

> The original commit always generated linker list entries with the same
> entry variable name, because _function passed to ll_entry_declare() is
> not a variable and therefore was interpreted as fixed string. Change it
> to _type which is a variable and which does allow generation of multiple
> unique linker list entries, one for each U_BOOT_FIT_LOADABLE_HANDLER().
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] image: Fix FIT image loadable section custom processing
      commit: e15282f943b42647478ec158011656df7cf12ec2
-- 
Tom


