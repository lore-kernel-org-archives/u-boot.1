Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9C9EDEBE6
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 18:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14C8A83F86;
	Tue,  3 Mar 2026 19:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HKDO2+k5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CA3783F80; Tue,  3 Mar 2026 19:50:59 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB6ED83F61
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 19:50:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-463a94f8475so4722432b6e.0
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 10:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772563855; x=1773168655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQVR8CJddUVey5/k7wIy4fR72eELUhT9sOesSF9OlWA=;
 b=HKDO2+k5tyLI2WI+lvhKl6TSl0iPJ5aRbnspM+SsvUMOoRQS7HhaABDkqaY4KtXIjr
 f98mrlIgCrDl1XBr7Zy4TTvdmmZ3HqXGPh5ck6c1sN1B9O7Fc31EqzMstknyszfAg3Ls
 +R+kuKv2ZANWTTEOXHitwGJI+cZdxyKqEd7gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772563855; x=1773168655;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RQVR8CJddUVey5/k7wIy4fR72eELUhT9sOesSF9OlWA=;
 b=YsFqKmQ8OKyLVxgLSeyKSC8nlYpp3WZH0Nqc2wpVPJ1vp1wLBK+tY5v4NLUxY0IvFS
 aLSTwYNTZEJD25mz3d0HuY6Nw+0NpKjkoGQOirK+tP5PxaChKkZiIescoDyyCYo+It8b
 nQyksEnn08U7U7Qp021KXg9D+efVjFWjC0eqHDDOWAM0iNg+wLgRLWfPQWEnDD3m+HUG
 ZKBg27sUhRGL4dpsnW+iCb0iHjJ0rPnzTDKn1xPVd/CCWXz9jgxhE/C/U6EaANf743aI
 nvTEZ0pM3FBHHmhD68osuPqsoehZfGAG66e6NlwEm1eCQ1XVBoVdeGI8602mNIP2lmin
 mMYA==
X-Gm-Message-State: AOJu0YzGRa3jMj1olU9KuixD1XtZf7eHwVCPqUsJOKCtGUAJbnVDZVZA
 V4/iKDr/vrD246x5YbB4x94FnO2sp3IRdWVqxSt8CN8DpOsVKzFwbkB5MTLW6yjM4tBdNCUENKB
 1H9dkk6Q=
X-Gm-Gg: ATEYQzyYzPqr/mekmdRciKrM87vbIa+hUWwuYvi0gYYGWfloN4knay9jJbqxWcmv52g
 jA+4GLT5Jd5pg6cIv/u4mzSz0XoOMhVIkPLmaNnV5nXivqpQgc03Gbtzbwe5QaaSH335m819Uz/
 eJsEw6TiBsIQV7bv0VHXvgwXGfgfLdfhoXlhCHdoUJKgv9llyYDLLT4xd7w6yPkqWwhQUJM5Voq
 CJBoauHB2AgJXAZDmZLHSHK0YIltjDRl5WeU1WmNBNZDAKdkIAw8S7DkTUc/hHt8k+dLxYoKJoa
 RF+pr8dGvMAEszmme77xTS7DAmNzQZFrdpnf5QTIdXk7ItmMdoo62RYMGhZprSbwwDB0g1ykdw4
 ug93wtpsrJWBNIE5Xvy0Xfi92ltGLTOrJsaXXqwoW7+8rxePWObp5fDBuGqRJMUXiS+dsMEJhf2
 oeQuigbIMDp085aFmaXhja6W0qtneQxokGw2sof/CViLKAbDzi5s+HefmcxqUjUcn5zwyYRD0my
 s1P1Cg+POW02ZBelLjvwX9Qf7gLqUgcfk00HguFYmLe/rzoPw==
X-Received: by 2002:a05:6808:158c:b0:44f:f5de:5519 with SMTP id
 5614622812f47-4650c70d89emr1481176b6e.18.1772563855358; 
 Tue, 03 Mar 2026 10:50:55 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb605f15sm10180475b6e.20.2026.03.03.10.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 10:50:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Simon Glass <simon.glass@canonical.com>
In-Reply-To: <20260213133922.1431006-1-simon.glass@canonical.com>
References: <20260213133922.1431006-1-simon.glass@canonical.com>
Subject: Re: [PATCH] menu: Move shortcut-key handling to bootmenu_loop()
Message-Id: <177256385471.3975993.16869255514921182272.b4-ty@konsulko.com>
Date: Tue, 03 Mar 2026 12:50:54 -0600
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

On Fri, 13 Feb 2026 06:39:09 -0700, Simon Glass wrote:

> The bootmenu_conv_key() function is shared with expo subsystem for key
> input. Adding alphanumeric-to-BKEY_SHORTCUT conversion there causes expo
> to swallow typed characters instead of inserting them as text, since
> BKEY_SHORTCUT falls in the range that expo treats as a command key
> rather than passing through.
> 
> Move the shortcut-key detection into bootmenu_loop() where it is
> only used in the bootmenu context.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] menu: Move shortcut-key handling to bootmenu_loop()
      commit: 8353239dabb8079a10fd34167922302288a6a1bd
-- 
Tom


