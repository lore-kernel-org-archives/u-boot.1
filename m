Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C583CC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 13:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA4F4805D7;
	Wed, 12 Mar 2025 14:55:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XHuzTq2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC8EC80756; Wed, 12 Mar 2025 14:55:27 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8703F801FB
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 14:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7c081915cf3so884392185a.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741787723; x=1742392523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RI0/mJKEid/NN3zsKW8EUptsYxiv5u/OBUegELhr2hk=;
 b=XHuzTq2wYWG5WE7vJmKVO4sI7MWjq4VImxAvRbextAdQGOwpk6pjYwMEHVEubqx3cl
 8ehP8RNtqx3QNVk+OBXu3FN1Zg6ES/53rnkN8xbZbhdZlGLfY/NqOgP6zn8G9OtbQKgk
 JHV4PKRUd8oZV8JFSUWO5Bzgxi7JdUwAZM3R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741787723; x=1742392523;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RI0/mJKEid/NN3zsKW8EUptsYxiv5u/OBUegELhr2hk=;
 b=e6Y/8lirW2ETnlFwhB5VkX+TmK87HDJZYeQEIp22zOEUUiQ85TtRB7GG3LDKngX0xY
 3N/F5FcscetW65yFzNafT2GSNR2g+SvdIlps/WPFJvhwVyiIX0CaQatAiw0Zg+U7D2zV
 80rcWHHHllgzu1ZqPGqsd1QGfV7JGtHPlmp4B44fSLTXK5jfG89637/lUoHrWbJUUMok
 wKWtQZHF1NwZ49fAGDsV5y+nCGVfX/To+Cy+7ckaB7aNWjbjTg5merOl69FoXi0qaOWk
 lgHssBzhGy/Ord1H3zLrQsH6vhysX5hZ2FABucDGLTDzgEdV1qsPEzi0zKkbU7UPh10u
 leIg==
X-Gm-Message-State: AOJu0YwOs7lCmXShiKJUhJbJKrMBNxtHvZpYrYPB4jCHYXiVb+D0+pa+
 68HWXfA7HhVv/R6sSq+WA8nb6NGSzvxiAmzriHhyLmWMXu8qxTjX60d9QWIcZMQ=
X-Gm-Gg: ASbGncue8vEF485YXSHcfbJeduW23rNhgCP1fPXPWlMsuvyzA00lB+8WioWBF2+4sin
 rl+zrpfMzxDK/u42b0uYM9F7S3Z3oM3naKjdHpbtop2Z5E4phw7FC+V+p8rJeqFc7PQBAbZAOY1
 /vUWiYTxQtGnzLlvpyvoJrFgNpyrAO5tw+/YCPu/4q1q+hm4aCJwfk2rNMMC8xM5lwkCirO0fvt
 AcJgpXHkQBZwZZw5wcC1bjU5T7jD5f94YWIxf1kLorPULSp13IwcqsTM4pXWm4nWUAdOH+IwWmH
 pwfouIqRjPbuEX4GMcoFdGqBoUxGRXbs31iM5c/RkIs/Th7fSmmFnUQ=
X-Google-Smtp-Source: AGHT+IHVuZrBmHXPJiiJGARc6jjG7XddiBvs3/a5Dy8tMtbAbCwQEzMgSY9JDQeeInI3LoMH5YW1Zg==
X-Received: by 2002:a05:620a:2625:b0:7c5:6291:904d with SMTP id
 af79cd13be357-7c562919180mr807371785a.38.1741787723462; 
 Wed, 12 Mar 2025 06:55:23 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c559b27f01sm369924385a.78.2025.03.12.06.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 06:55:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20250311230656.91036-1-marek.vasut+renesas@mailbox.org>
References: <20250311230656.91036-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/next
Message-Id: <174178772209.1732220.10343167504856445197.b4-ty@konsulko.com>
Date: Wed, 12 Mar 2025 07:55:22 -0600
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

On Wed, 12 Mar 2025 00:05:56 +0100, Marek Vasut wrote:

> The following changes since commit 1b42f57ec82ceba4d5f08cfb359717232301cfa5:
> 
>   Merge tag 'v2025.04-rc4' into next (2025-03-10 20:18:51 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git next
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


