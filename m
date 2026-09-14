Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59A3C88E72
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 23:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C11740547;
	Mon, 14 Sep 2026 23:16:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1yP2DcVo9tUh; Mon, 14 Sep 2026 23:16:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B7229404F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789427771;
	b=bKzI00DCDGWBoM5l68LWZt66RVxkPdOr3gmdrYDF2SOkGYWgHIDzKxHXnglZdcf9pdk+
	 Ro9/zonalST62Rl5o6lMfRONgp76vMNY0SuAND1nW7xxozBK8uEA88nQhVUua82pt5qzm
	 dJPneXIq0tdtE7K16l9ZZUpwREOZuYzkAcrj+JJgHeKcUJxrPrp+QF37NtM5aJ245N8LL
	 djrvOILR8Rv+crijlKIG4Qgx5F4MI3zY5oP5LHTPRomyThaOTW8cF9nvwjdL4IXfdl8Ho
	 vaqJbPlHD2v+Fuubi82kbLlHDogSSUAoDyZuB6qH9Ecj5qdDuyoE5Nvte3ZEusKOSag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789427771;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Rpy/fOPgrrNjCaBt6wtuhKYqQeAq+nDuIe5nySOGmqA=;
	b=RKZrIUqdQDV7LgC+xTrQXiHaf9Jd626cM4Jy/3mFjgMds3FVB2X3sVrZAZs/GWVQ6c/c
	 Ps8JcMFrXgFtonjxjekYisEDivJ2xL5lyaTmas46aWg3MBnmR0ZQo/jIpPEJQ5HCmFmrx
	 gzbnhLCapqfyxJKFPzlqR2kan7t1+7Ub9Z8oGJ4DgdgO08eqC3IxNDaYG6LuSWcCiUFmj
	 6ZKAX+9NDfD8k0aQggj1A2XXdVQy4xzdoePq9GmlbHvChsuFroAPon2hccpxl3VIBrH1S
	 q4SQiklsS4GDLCkBzjFLCDmNe6oRFi4NzQbaA6OeeuJ4fTbkBq6KvZHwRl762z5f8kg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789427771;
	bh=Rpy/fOPgrrNjCaBt6wtuhKYqQeAq+nDuIe5nySOGmqA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PYGudHQEvpfBQjtyqXv3sgm+bnLtNcrBN3VGg0/7TwZHKxQ9RuTr+axLMMdGQEJCR
	 LjCTGSkAtmmiDgS9iji/HeV6EolquWUZRSi+56bVhcTy0J8C8WfYoCpfGSP1izT4jc
	 W2aM1dMT6R8bt+PAjX8lbQcZIZFzR64i7M5bXeuq5uZ4+kBLBF+vjqza4K9AfdRkm4
	 Idx61fUkXs/CHg6nhxTibUGHEAex/+50c89tN/nJJIxnyfyaYsJL5eyYN/tT4BYEpr
	 S9Kqyv7yjGIOjxF6aJCGqYoqhecXWylUJyDjM7bNjYfdBBAxvuIXXK/RFxjsuizYcH
	 0TcIRi0rPz15g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7229404F8;
	Mon, 14 Sep 2026 23:16:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 01E0D465
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 23:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DB87260611
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 23:16:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yw-eduXZruVi for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 23:16:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4395E605F7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789427769;
 b=IStaDu/Ca6i3nN+II6ecjYi4yGESrIXxnLM37nwhmKUaw+GXrMWjzk16TpY5HBcRocUd
 EpZ1P2mj1wqYhdL7N9Ip1QtUcC5jOXBV/G7afWlhSsLNOanJ35iGSB4Cjwr+TtIrPXfkR
 R3RUQ0nN9cB6ND3znusnjIhNtWrYtQLjncuOP67AsGM7F2fmpr5O2Py4LEvQuj8NBH4dO
 /WollGATKmUPqmYqVaihlNlOkCf/v/SRx7wTErBKomOeW/SkkJlQ57Ds6jg9butRQ2eez
 yDetMfFOuVm+FYMD4oPo9hvjBW6nQlW+Xa5xckNsyQPhLRBKGfN1ncr5ewKMS392zVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789427769;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=Rpy/fOPgrrNjCaBt6wtuhKYqQeAq+nDuIe5nySOGmqA=;
 b=N12NdjIJQPlnQrrVbX6N5WUixz6wPatzKQlRtmjIqppOjLIr3pfGqGvOA7k/T0WxKGGa
 kzygmIaxkW/Bq2EYbSpr5bZqApmNn5uUUTpdd3+nFGB+prQHcMC1lqgUSdIzwPdB2gI0W
 aBm4ux2ac4Vf/2sQ7AlD8v+MDSvuAgrb6ZdBk7JEb2XxCRhEYZ43A4qeiVjT19EAxjbyp
 RmF/HQJdftmsGhMVrz2NPneGQ9wjDnuj5QvLJVk0Y/dJkCDygRbMUpDb/WBV5rvDr16vF
 TkgrIsiH2ZVenWMz6D330fmsGlTDBx6hXoqxE1qwxcYZM4mNd84b1xkMFJntVF+f6vA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NsmrFbTV; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NsmrFbTV
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4395E605F7
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 23:16:08 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4be07e7c54dso310108b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 16:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789427768; x=1790032568;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rpy/fOPgrrNjCaBt6wtuhKYqQeAq+nDuIe5nySOGmqA=;
 b=NsmrFbTVLlOafn8GCjIwU6XY8bLv9jxb1dYT2RHM7fO6lN5dA8PfMvu+6Oi6qdGoqh
 mpFK21U5lvWuk3vUsJDM4tFA3c0R0F7j5VvlkMBIADfQAyjnTAyc1Gmw0ClS7NNdXLe2
 DELJGPzsSv6AWIJI0yNeHO7Y1+ELBmofLkqXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789427768; x=1790032568;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rpy/fOPgrrNjCaBt6wtuhKYqQeAq+nDuIe5nySOGmqA=;
 b=2rO3tUQWY/KiPV/ub/R4hfAh9mQ+YKzT9e86ZnxZ9nIa9/CO4UAPHYjmhabjt+R8W+
 kyJ/Y0l16CsqP5F6Aqb2bQK1d5NQGnya5e3bFHRClBqzLO4Hvhzl+K3hmhQO6cAoYqyA
 uD1jg9F+gVy5QEISmNmj5JlCGI/lZ1lCeaz6W/eXHu2em5g7wqOAA5MkNBhmJhJjUTWt
 tK5uZHwa+kHDXIIQOOTalcsXCXyebW+jzJNGnMgX5BYhp/hS4y28Oz8N2srWxQwfMd0j
 W9MaFRhTM9kvh2OifBdjR8zo8yvOd7SG6FFN9G6Ilr8x4KxdWwNu3I6gBkJwlvxk3xwP
 EiuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1LWKK13b5MTXBo7q2Mn7eR1th9qWxEacFjpRBp5EZmw7ha1uUDhMZivwAt/wBUNy7Hu6Z3LE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++khxfUiywv0TbqVzRFxVsWeBe/NdDQLV3R6z66XUF+F/W5AmOdx
 KwzR7P92jcvxmFbg2FkJNvG/a1LREg3dcBP9Lt3XjOmuuhYZehSKebndnkJiv6vuxL0=
X-Gm-Gg: AYBFou0aCAlguK5EXGD+De2zOFHoZfs9/Gupv+bO7iXT8u8s5SGxvYuSG0jsFOVojB/
 GS6HKvfOOp48YJe3wStR2+UpNNixQTBsi7dUqc5XpcNdDbVd/TwnrxIIqDxSXUGsAFrsySLMmJi
 Vlf7mVknnUQJcRT7FlTN9b3hFovgY/nPTgw+u41SVEdTqVx7W6KtYxNkqfxWAmpjDRyVO5WzAQb
 zh+Q+L2e3qAjhLqY2Gvl9DVEy0qyTINBVRxAUQjx6QIWNfy/aIJROrdmeAMFDgeqLGWLIpu3pW8
 aliGINhtzXuCTl20uxLfqkcJfq12gW/QZ9l6IoeRH2Q3sVBVNarP/B4S1hZ0RNsdIBARbWjD0ts
 40EPGsxmKfjF+AGU9o/xm9YvyM/OkDAEkRQZqo3azB8cWiuE5mxe+H95dAnxLY3nOMgZvqYhzrk
 N46haZ10jotivpyKMaMvR8xZw4etd27gs276nQTAFYGJkrFxJSUbIJHSq4NcWoNdetRa9slXODk
 90gh4TFZNCy5qv5WzZIEvZgHTkGG2PIiICzRrBgXTPm+ZaF7GztvdKI/qu9H/kbNvinW/MUTJvP
 5rdSd+oyuVdTCZ1oMG4=
X-Received: by 2002:a05:6808:50a6:b0:4b8:4703:db98 with SMTP id
 5614622812f47-4c8a26103d5mr911603b6e.33.1789427767794; 
 Mon, 14 Sep 2026 16:16:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c3314b17d0sm11811299b6e.8.2026.09.14.16.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 16:16:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20260825213428.123317-1-heinrich.schuchardt@canonical.com>
References: <20260825213428.123317-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] cmd/host: allow to retrieve sequence number for label
Message-Id: <178942776663.665895.15439774473088857560.b4-ty@konsulko.com>
Date: Mon, 14 Sep 2026 17:16:06 -0600
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

On Tue, 25 Aug 2026 23:34:28 +0200, Heinrich Schuchardt wrote:

> When binding a host device the assigned sequence number depends on which
> host device sequence numbers or unused. Only the label is well known.
> 
> This sequence number is used in most other commands. For reliable
> scripting and testing it is therefore necessary to retrieve the sequence
> number for the label.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] cmd/host: allow to retrieve sequence number for label
      commit: db02988d74d4b53ad96c5f6a857f5e26adfd28a6
-- 
Tom


