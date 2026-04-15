Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854BDF9D0FB
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 00:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A91DC838BB;
	Wed, 15 Apr 2026 02:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ll3xVJGn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B63483BC4; Wed, 15 Apr 2026 02:40:10 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84B47838BB
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 02:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-40f1a1f77a6so4337718fac.2
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 17:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776213605; x=1776818405; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SdaEhsLyGP0Qf6blD8i19qhsXjlmnqUW4mFgGZ8lPg=;
 b=ll3xVJGnnPsnX0T+v8gVFTMZyjddmqJFimkXq0ocJiY2AFiaicNe7gan5GPWwSL2ar
 G1IaHbqwI5HGQaa6MnLHnSN+pwca32yj5A5UGxW4MsVyYcFfL93uZ3oHniZNg/Va360L
 35a09bjJ3vPe4SqRd43PMP3pXPe3TcwosPMQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776213605; x=1776818405;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+SdaEhsLyGP0Qf6blD8i19qhsXjlmnqUW4mFgGZ8lPg=;
 b=r3gX/sp17ZtoD04JyU6k40LZD12a0g52dyYygX0GaXQZB5dxnmYVcXK6a+hv5M9dPZ
 ThWjITdKicdupAZojKYOM9DoqrhGIYbgoUk+Xk+osruFzmF6rn6ZdAu4iVkCi8/PKOAu
 oxny+wKOg5U3hZZJ1CT+SvF2RI+bqoq+jk9aCx18eyL5jxEOlqcyO7m+Z6UyS9AFANwy
 UYrStn2qE8mjjoBcNaWIIKq0oTm994vQ0BwWu71QacUk1vim58XynkgnVl2tUAQ9y8gj
 OvSJoFhOoSaZJ6JIwugizeI/PCb7yGqwphMjLbzHsGRD7jhCOtmI8exXkOXeZKN5VLXr
 O7Jw==
X-Gm-Message-State: AOJu0YwUABjzExqePyIY+9b9o6LxWpwFCFnP2LilGY3HVWgDMXrD8WoW
 hIp2ARGh5MV5DCFgfKIS7GFdJ3lMjdvbBoqUVDhJwJjMuLgSTkuYKloERDjIID7khew=
X-Gm-Gg: AeBDievOcTqkK629oYgzQMTLEffc7bYT/SZmkZh8Ufs/GbRJ06TG9HBDKEExBRoz2ki
 DP0D61pk+fP4d/EeH28V0kiAK788u34gleC/6LyFVtHuqS+hCRAEBpQYQeTQ2MO7GWDgNCJzmMj
 e5l8GDeS3UjfqvxdJwcfRPWkwhfLDq5p6ebL13KmmjeIIUCaCvA51643+Q4hwTufh4MSJn3v0Jg
 TD5rcxCKrhHJ3daqgv8v7jOwAFHuuCW8nCuCzD+4EkeeSLrPazZ9NK+SUpZubB9aC6zkKQlBUr4
 bRKyQO0xwR0f6OFhYD+EVUNP51QwSohzdp6KaNiY/qfXK5NQ6CmT+MiNlf0dltWX1qU+PIygvcJ
 N1jshNScDAW7+QrdolAO6WKW+7HooK4FPvAcsK8fE0D6YYE7GxBh1zqVexUONo2xG8VdvohEVNV
 W/svZyaOjOXU6j6W3PZ9u1XyrjWkQOSSlaKABEm5kwI0PTxWKNZ8VogLKvmoDX3ZZc7W69QxGH/
 89sC1XXKBhUmSgrC0/+p2r8IqdA1TRWdulBFSyTMrNPsYzqYQKbQoBCvEfh
X-Received: by 2002:a05:6870:50a:b0:417:c116:ea79 with SMTP id
 586e51a60fabf-423e0e17e73mr11857525fac.12.1776213605187; 
 Tue, 14 Apr 2026 17:40:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42666bcb977sm193085fac.6.2026.04.14.17.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 17:40:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: visitorckw@gmail.com, Daniel Palmer <daniel@0x0f.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260309105110.672832-1-daniel@0x0f.com>
References: <20260309105110.672832-1-daniel@0x0f.com>
Subject: Re: [PATCH v2 1/3] serial: goldfish: Add debug uart support
Message-Id: <177621360411.2899116.14980958391713330630.b4-ty@konsulko.com>
Date: Tue, 14 Apr 2026 18:40:04 -0600
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

On Mon, 09 Mar 2026 19:51:08 +0900, Daniel Palmer wrote:

> Add debug support for the goldfish tty so it can be used for
> early debugging. This will be really useful when adding support
> for relocation to the m68k qemu virt machine.
> 
> 

Applied to u-boot/master, thanks!

[1/3] serial: goldfish: Add debug uart support
      commit: cbfb9b3f2248ff30724a12583981e3e7523272d6
[2/3] m68k: m680x0: Initialise the debug uart
      commit: 2df4926ca4f215d9b1a91d0c02c6fef49c845837
[3/3] doc: board: virt: m68k: Detail how to use debug uart
      commit: c15a08b730e3399c26622c8cb083bf521039606a
-- 
Tom


