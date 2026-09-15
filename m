Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15380C88E77
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:35:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4F42406F2;
	Tue, 15 Sep 2026 20:35:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6eYYbHmLy5uQ; Tue, 15 Sep 2026 20:35:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D4B8740707
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789504538;
	b=Wp4zkhI1hG6vNNizu9nf6Ol6AyHXx2wLvecNQzxWzVFsZIX6XvvdGFzsHDF+3eQ9NlFI
	 +hu/AlyERofn66QYgBdzd5Iu64L1TbNB8kHO83rgxyjdv+kf1ck56ryacg5TdcleOqSH6
	 Z+esvD69It+npEWu3lbtG7bS+0lCK3wIqcRBE0qYapgzPc28J218ydPZK7dCTZa5yfQh4
	 gO82Hf8QvxhiIZ8WJ47nRN8lNI1jCEAf1It6S9T5MwN2sjic6EnjgH45uMR9f4Q5zEfBL
	 sFwQpMdvCfnHhxL/b9x1bMNse4916rTlIyzcEhbQGf93FxEHxtkAzNJ0WCIWzILqIfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789504538;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=eW+jOIWWf5/G6foyQ8IIUCwOOXjwaP6s/81yvjbxvt8=;
	b=GZNtm5O68ZiEreVWRhoTj5m1SQL8lbA0d3betveg2l6b+/NfSGU2QWkXH7hYF8dg2FV4
	 rW4HN7QadjbkbUBV+sEV0KOj0qaMMMEXpEfEeWk0Ouh22sXAWoWhVdIriAA6uoTuYhSBX
	 eWu2ml4MawomjjP1iculq81/vT6p/KcaDI5XfWHb9n5f+V1tCg0KTHdDS2y1bC4tL5i47
	 QFKt8cAJ3R4+9jOl6I2qbjhH0xb8CaR4cj6Segl6NhlvZ5DFqA+CCxzZmNxEjRePBkELU
	 Tg/aLPGIXMsADSH77qydFGowiHu3X3MyESVNfvruF+bYzdNPZxqGzh3dfTyiwzH8HHw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789504538;
	bh=eW+jOIWWf5/G6foyQ8IIUCwOOXjwaP6s/81yvjbxvt8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pk79OgLVoDwJk7cq83gEE4kJWCkP80xUYq0FTp3LsT9pgisS02nFnjB9SbdDFA4rm
	 /7uAGgqEIxMhIArdkZU6VENH5JCpkEgk6Eq3/88YFO+0uKpW76sW4RYHxhvlYEhxQn
	 afTxFg4EKCg3xFR0UmWgpC7d+u6oE1LM/24r5icWwqJd8WhdeOUtYoTXwdCm9mgwJd
	 RI+EzwkWat5vJ0iY2hror6gY5qarcv5XaujvnwgXxQJZwMEFygrxVKecjCqSpsjVx6
	 s/z3k0V9OrbnDK/XFY3I+80jOWjjqv/55bFj831uVYtP4yn7CHTCdMo5JYEgvugjKK
	 HsInIAblcK6iQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4B8740707;
	Tue, 15 Sep 2026 20:35:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A210B2E3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F75A60783
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id saOX1dmooqGC for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:35:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 06B806060D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789504528;
 b=Shv8ugnrEm9c0ZuS1Oemn48ieEk4Oi76TEmEL+Kf+BK/fuIxImA8K1w1coTdWgwBMUFA
 nIyIlFiex6Z/obzo03XgqhJiyrcclXPW7JZ3Mj7HugT20L/PKoLHDbHGvPY0oVKerQeEE
 kRuuaIA9BcetmvIkMlNDKVsPyldqN+Mw+9Mf2ZSqvFqYzULfL7P8YgcFb9O8oPuIirQu6
 PbJart9VW30nS2BXRIjDTBtDlBEUK8osh9J0Qj04mb9cutBIngi/VdaN1G4dZ19CLUrz1
 7IQRsDXeZg4X6ZtaOWgYiPd94BDwbZ+rbH+k5U+NqQlz+limuUjjOm5zqm5Dk/RffJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789504528;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=eW+jOIWWf5/G6foyQ8IIUCwOOXjwaP6s/81yvjbxvt8=;
 b=jjuN60p7kI7DTqiT1uJNdthR8qXYGKTw2p2zJqzRDUKORJBal5D5bI4XBCC/cZPsrnvl
 PPi5MqXVeM7fXFqZG1288a8P+MR/RleN9Kl/DQQ8LO0yrD+ls6SdRf8yDC9lD27kNMQ2k
 IvvQ3bLebMkvDDS/+D4WSUZ1Bx3MyVl4SHTKJfNtRlyNxjDA97SZQ4+9XlGqkLkaX1CZX
 TQZhSeJVGfzX7GZbJPFWRE1JsHO9pjKxEJ03gvJYqvsKsss7CxVaWkhoei20+nBvnyZOv
 Z1EJnxJHd8dx+Ds79ev+c/abPsvif4rUuYcwsuhQr2xY1zRugRwTWdIpZuZoyQ6LZbQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=kmmE7jk2; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::10; helo=mail-oi2-x10.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=kmmE7jk2
Received: from mail-oi2-x10.google.com (mail-oi2-x10.google.com
 [IPv6:2607:f8b0:4864:32::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 06B806060D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:27 +0000 (UTC)
Received: by mail-oi2-x10.google.com with SMTP id
 5614622812f47-4b37a3a9768so243648b6e.0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789504526; x=1790109326;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eW+jOIWWf5/G6foyQ8IIUCwOOXjwaP6s/81yvjbxvt8=;
 b=kmmE7jk2yUnhynyPeHJDxmSc7oyesjpXJzyYMLU9lsJ9mut4+IFrxkgsFDRF2jlYaC
 pForLlVK24P0U7IYQ42ZPJHoJ7Rhz/QDay5XiX3huOs30m1h5slMfWwm62BaBgmxgWkD
 eit9MO5se6Kb7QLPyRFH12zMMsaBEX/8tPi78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504526; x=1790109326;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eW+jOIWWf5/G6foyQ8IIUCwOOXjwaP6s/81yvjbxvt8=;
 b=jVinDQHyUzwaNyjdP6isWB0x1skY35c5VlPT5JQODdgkWWpMYoty4n4wW9fy6j8ESI
 yM7E5oRMHYlZh9td9s+0K4WhpdGNTBMCFsRKptwiNZOOQEvQlYnt0nSpl0x46nbFsOxM
 vE01tchGdkbswLb1Ar5RkgwiIdBFCTxfE/+wUf0veH9gH1tOdlJKB97M4QqwJerT1eer
 d61PCC1BQR+JbggEq6smBajnaOZWFptPIjyr5oTeDKWdUa2lBpMeHY5g6oEPnKkIDZbe
 +Pdvy6CbwbnACJNnP7FPNIChLMD8RK5E06CakPAwTkfa3xAGW+hJFiEiQkvxWXx8QMV/
 /vJg==
X-Gm-Message-State: AFuF++lbprJXYFbfyU/Y0YyBzCfhUSIVkjNDdc7ENCpAR6XBtA2P4w9P
 1q8CMadA6N8+jggLX+SwFZYIe6PYflrplpDAh3H8V0jY0h3goq01S+hWe/N8QCd4KiGJYYsA+oX
 0x5FwpCC9fTz6
X-Gm-Gg: AYBFou3imTfJZHafgUK9LjihMWm+9Z7OQV0Xp2VcOr9nTJdNQShE34aTN5bHZF9f9Oy
 a8LRh/2kqEnlqCJ2img9miIeZDdyQUm7grjkqz+SvHo/fXBMb7Gsq8yYPrVJes6HaDzCHpRkZu5
 UCadoCeC1Lzvn4PlkL9Fa/A9PLuKiwoNQtsimU/g1LGNle6sujR13wOHksJkrkwuk3nGMk7/oJO
 b7DGYBoekYhyfC4REQtt/N/344AKq+hp1lpEf7PzX+yxiz42CkCEAtqjM6VYwOb9VJhip9QyT4J
 XbYBudTIUYiZed4tnnypSIMJearr8rE6XZTX/cENGxepP6wB2r/SC62e9uxQ+j2v1omzwjZG0io
 TyqQTDG5nTgPSBASkwMS7nRTLd1vyaLqeInTON9+uZbKAaIBS9QjzCkA8L4MQ9nos5r5d0fnheS
 AxPhTT9YypWDWuyvK0diXmywxsmdOOZDDD4v+uwt/VXpNMH0aO4HaNrQEfG0FK39HFTnamUzMUF
 1dts8Ur9X721aEGWnUOmaI2xr7eGl35yJkKCLK3ZWURwL3LxH0SDS5wk1scQ9sFxOH8nghl5cmv
 KxfGpN18eh19dzLDZWs=
X-Received: by 2002:a05:6808:1307:b0:4b9:e5fa:8910 with SMTP id
 5614622812f47-4ca4c185ac1mr37316b6e.35.1789504526231; 
 Tue, 15 Sep 2026 13:35:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ca20e54317sm486511b6e.2.2026.09.15.13.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <beqmeygt36o4pcvilrea27o6a4vwjdslo2wiz2ubzq5thupyd3@75i6ozh5sj5k>
References: <beqmeygt36o4pcvilrea27o6a4vwjdslo2wiz2ubzq5thupyd3@75i6ozh5sj5k>
Subject: Re: [PATCH] bootstage: guard against NULL record names during
 relocation/sizing
Message-Id: <178950452541.931545.15877079500848343869.b4-ty@konsulko.com>
Date: Tue, 15 Sep 2026 14:35:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, 01 Sep 2026 15:54:03 +0530, Naveen Kumar Chaudhary wrote:

> Bootstage records may legitimately have a NULL name (for example an id
> turned into an accumulator via bootstage_accum() without a preceding
> bootstage_start(), whose record is zero-initialised). bootstage_relocate()
> called strcpy() on rec->name and bootstage_get_size() called strlen() on
> it directly, both dereferencing NULL and crashing during relocation.
> 
> Skip records with no name in both functions. They are handled identically
> so the size reported by bootstage_get_size(true) still matches the bytes
> written by bootstage_relocate().
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] bootstage: guard against NULL record names during relocation/sizing
      commit: d00b3813405184f30432720733bff9728759cf01
-- 
Tom


