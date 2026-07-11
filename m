Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9209FC44501
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 00:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2849084B9A;
	Sat, 11 Jul 2026 02:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HfzhhL51";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D163884A92; Sat, 11 Jul 2026 02:17:28 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B82DC84A92
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 02:17:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7eb5bdb50fcso1198349a34.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783729045; x=1784333845; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LLOR27zoMoH6IKTHt2gvcBXDvejfC0Vj9RI0Uu5t5cU=;
 b=HfzhhL51ZTrWzj8SwiMinYbgk8o5wLNPgXKUrkld94Ce2zO/L6ZLt1OuoUBspxXXtC
 rVtcw64PYuwdO3c8xyDbqkQ4JVU2MRzEmauHR3QyTVgNKjSNHx+mcSikJpKKZUsvJ3mS
 fMXdR8C05a//fZAiN5dSMkQiV+fullWRXSCC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783729045; x=1784333845;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LLOR27zoMoH6IKTHt2gvcBXDvejfC0Vj9RI0Uu5t5cU=;
 b=s6sXTH5WGwWp+WpTxAYTtaoLvwpC+LiKWJOJzviUoNYhWYPeZVL20SRT6eqOIska8Z
 7AdaAnUERrdbCAhiTgw+uk5+/urhHg5/R7AotO7sJpuyRt23bYH0wSoWBGuSi9ufJSBa
 v3B31hz631zaPuxATu3bwdohFJXEFU6d1uqrMrlHCHKGAkQupgFma86eYvj2YfK4ge2d
 vZbzlJNw7By3Tn3BzCFDRrJmkyBrPzZ2ZvXzJQept88Ih2iBMbiSThwk10raq+lcJbe2
 QHw/n8Sh5z37U0K6udRPDqeZtSqTW+fasKTar9aqsY7XLxbeACI5+yb26xUVQQnRWH7s
 y2Hg==
X-Gm-Message-State: AOJu0YxAM84x9niMD2L0JbIi/YRBt4iknPa+hdsS8CDXWIpd8efy2pI4
 jznQHbTBl1KQqk5dbUBP/lhmYqs84JIan7GvNaWcC+pNP8Dhlqo88jAp94zw9k/HQos=
X-Gm-Gg: AfdE7cltD7qWiGwD6gXDX5e1FvSSV9o2gTiDJYuZezEOndwxal7mgh6G/IqOYeXkrnG
 g8SrurGYI3zueofyOvS/Q7/FiMd0gyhcxx8PPxszG8COGixlT3ucCTOlDTwOSpQ+FoQaJdld2W/
 jYMQh320Hsd2kxYvRtvRftd43BSvcgqnqHrcAVAAJ4oY/27kG2XP2jCj1VlJDZ0LOyNOfYLQWg9
 brm1wbvWac6v/1XwhyvaM/WTyQaM8GFUBnuLeFtX6Y0ipucCAb0paY7KaGh2Gz25IS6ZZl/Nj9/
 m0dqC5l5CGB2CpM6meBTYRK3SFRtgM4yrC4P9iWlf6zEgBaqCAa7fxOCkFrkUEwuQvOjvEQWljq
 YSbtsM5U5qqFb6xbJmMiWDdmVK5sjIMZ6R/VbjLNyM8hx09fnj7HOm3HM+EXuNXERNQPCZ+vpEn
 +qGAhsjuFZAQAgPYdn1teWxQm68YEHlFVrVHRve3z7/MLhdMNXPMuTOovUsQPhnADXAhtbD+SaR
 OBUxsvt+sT10ohkkoFLfG+c9UTFhxcHCNyb
X-Received: by 2002:a05:6820:4de9:b0:6a1:4f2f:dbc0 with SMTP id
 006d021491bc7-6a39a6b630bmr843389eaf.39.1783729045510; 
 Fri, 10 Jul 2026 17:17:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a39af0e953sm651312eaf.3.2026.07.10.17.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 17:17:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <du4aieuv6qxikfsii4jlactmin5verpehbdwrescc7xyx56736@lrv6wnhukn63>
References: <du4aieuv6qxikfsii4jlactmin5verpehbdwrescc7xyx56736@lrv6wnhukn63>
Subject: Re: [PATCH] cmd: upl: fix off-by-one argc check in do_upl_read
Message-Id: <178372904493.2905849.2505009312219925111.b4-ty@konsulko.com>
Date: Fri, 10 Jul 2026 18:17:24 -0600
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

On Fri, 26 Jun 2026 09:19:18 +0530, Naveen Kumar Chaudhary wrote:

> do_upl_read() guards against missing arguments with "argc < 1", but
> argc always counts argv[0] (the command name) so that condition is
> never true. The function then unconditionally dereferences argv[1],
> which is out of bounds when the user runs "upl read" with no address
> argument and feeds garbage into hextoul()/map_sysmem().
> 
> Use "argc < 2" so the address argument is actually required.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] cmd: upl: fix off-by-one argc check in do_upl_read
      commit: bd93d8ea10ec94183fece63fe18b9ead91b8ed67
-- 
Tom


