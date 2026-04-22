Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571E6FA1FD7
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 16:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04BAB8412A;
	Wed, 22 Apr 2026 18:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tltqUAm/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 663CF84333; Wed, 22 Apr 2026 18:39:17 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12D478412A
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 18:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dca4debedaso4364678a34.2
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 09:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776875954; x=1777480754; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GL7J/Ri3KmH6ZUp2cgZkJE8Kltj4hr3+XoM4gJPQCls=;
 b=tltqUAm/OdrAwV4bXK/FVcT2Rl3Mlb3D3GgjZ6AooZGpukQMwZ8rWDfrYq0Vewznwi
 CJ+d39ROkF5q1jTSTtXAtTsz4p5hlFJHDZbxor5gvfbxXhKfqEeBWYOFmiDsCZirotEl
 YwNQltyxklm8Dn3Up/cKko5LnxkEnPs5aZuhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776875954; x=1777480754;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GL7J/Ri3KmH6ZUp2cgZkJE8Kltj4hr3+XoM4gJPQCls=;
 b=Gb2c1ysTxNPSItvYCfnanIKTMyKp5oGFm2670qPT3UvhV4SA74MhxiNWjc+TmKY4PY
 oj0gaG0CyY0PVhakwz8sHwm7gVHMjDGhPidE17qieT0yz4LRiQVNoVy86muXGEl/PQC7
 3r+jG6oqm/pXZ/epDcqQXhTYfT/zJEoHkHiw36UbKdv3AAkYg39w7Pr4tMwGOcaF4xoA
 52nWhN5i5tQZHqEQzojlrEnNSm7HBqVwJO3/cWX1dTcnfYiVABgP+OnQ5BUZxkyIHD03
 +9nixlMJsL13Dm1N8vXBGdeE2JjvgN6kOUrbMp83Zsg8pnyp2FUbxfHxdnmSu4qZOgOR
 gaVA==
X-Gm-Message-State: AOJu0YzSa7w7v/K6lDfeFU84I4omN23J7WgGSMps6BiJUJwEnwhDcZto
 37mCQ90AOLOhlOUbJLjz2TIXzUzhiAIi7hWCE46e5cpCe5LvvRcqyyUSiXkJanoNRjs=
X-Gm-Gg: AeBDiet528USeuUQsUTffmLeC+/br4m4VtmQieTH/BlE7Ob+95cS+cgYMQc/d/J0Thj
 pLrXLMnzQsBMXFSe6APsA2+ljozTn102Tnupuk9pvKVf5pA8bY3A+wmJZ9uGeqCOo8wBQxJD3ip
 qnfr4vDQS/WnAOr97911FsK/+zvtcZfwXwOH7jjvlnpu4RPowQ+QVEvCwkBlBfKKPtCdo1S72ss
 3S8k5NQRjYsTJYV9dkzz2YprNHUq9HGcu47q06TVALapEK7Lo4iYqP4QlqKVtIBv6cgZWv5M5Wz
 kyKTbBx/LcDFxgNKw8+q2XHciPrMOJqF+9Re/WdZbgAH0D6576ABUnNIc4BCFhlXEdJmewBGHDB
 vm4R6pldZEdQGpB/P01e6+erUO5xFuVyta25yUYRdy5EN3p1yj8nfjaY+zyeP5FjHAC8uksyjlk
 +g93C7/qzF0IngXrR/FZW5GABELu/7yshM1I5rR6+zR3S9AvhkyHrE1gDeWQApfgxB+NvjTNHQH
 GWPYhf6FpDo1NWBQVzYdKcj97qCscIVZoA+HYCXJUjSLpLHmvwM5o8IiReu
X-Received: by 2002:a05:6830:912:b0:7dc:dd58:50a1 with SMTP id
 46e09a7af769-7dcdd585517mr5428553a34.15.1776875953722; 
 Wed, 22 Apr 2026 09:39:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc9759bfa3sm14380249a34.13.2026.04.22.09.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 09:39:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Rasmus Villemoes <ravi@prevas.dk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, Greg Malysa <malysagreg@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>
In-Reply-To: <20260413131541.2091541-1-sjg@chromium.org>
References: <20260413131541.2091541-1-sjg@chromium.org>
Subject: Re: [PATCH v4 1/2] kbuild: Move U-Boot .incbin rules to
 Makefile.lib-u-boot
Message-Id: <177687595266.1874069.3984865854550402584.b4-ty@konsulko.com>
Date: Wed, 22 Apr 2026 10:39:12 -0600
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

On Mon, 13 Apr 2026 07:15:37 -0600, Simon Glass wrote:

> The font, splash-screen and EFI .incbin wrapper rules are U-Boot
> additions that do not exist in the upstream Linux kbuild. Keeping them
> in scripts/Makefile.lib makes re-syncing with Linux harder than it needs
> to be, as every sync must manually preserve the U-Boot additions.
> 
> Move these rules into a new scripts/Makefile.lib-u-boot and include it
> from Makefile.build and Makefile.xpl, right after the existing
> Makefile.lib include.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] kbuild: Move U-Boot .incbin rules to Makefile.lib-u-boot
      commit: 24b99d293344d92d902cbc184e8d9665e6a437b2
[2/2] kbuild: Use if_changed for font and splash .incbin rules
      commit: 09297182ad79a4ea30fd6aa74d33646efc4eb12f
-- 
Tom


