Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E5606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oy3GhX6z;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=f1JwVNNd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E12180FAF;
	Mon,  9 Nov 2026 21:51:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZLy_Q6lkXCEJ; Mon,  9 Nov 2026 21:51:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8A4C780F8C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794261106;
	b=KrM5pyf05UXDQGI3dRBkVa2pKyh9eDG6R0IH0buhzXzb9TV6Ke4Yen5vdo2aoRbHPS+W
	 lSbqL37BbdEMisUmEJH/extL3lGEHKClKhWvidwewL2H1JwHUrloDmi0n40KkqHwXXcxQ
	 HF88lu0PvdM8NUAalPo55a8Icu/7GexcCeIP02sZEKx0sU3fFo/eQ0VqskRqSx4F7Gxb3
	 asZs7Of63bMSJBa+gCRrLpWEtJrVP21Co2jxwvfkMJfyjFyD/4k025J6mDSvWJljXKloJ
	 9QUX8swXipQHUIhhbauqMP10Mh3idTJxe/rHn+GQqu/f4k0Mj6Yac27MecS2reD1rWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794261106;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BKWATP9dQdfpHYxoF6j+0G6kRzwlj0VehALmmMgk6SA=;
	b=J+V1Iher4TjhEsdRVcAJqDuXA/w9JPrcvUWXGBzOVhO89PyukiQ8WP123eZjf8tVwC9+
	 qX3+Bulrun1fnhEWTlIFkPnAnwoWvY9c8xb/g4O31j+qVN+3kWtUoWHa4t6kVmM7TeWRD
	 iAFh/1fppnmBfS3zSH08XHwghsqZq1Wm3FbUM5dytFt+C+V6cE3JJ5rL05no35l8SBmTn
	 ToKA+4E6nIFZt1C8u71XYhGfBB6Bxgr2IKTbyQbPO0duJrv1Z9ls6r0jFxmgvSVSz7EHA
	 ZaL6nr2BtJKP1u96EZbrfMFTopWTRKoHIO8K9DM4qeBXjQ5i9ywzOYGoLj47YGqRLUQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=f1JwVNNd;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794261106;
	bh=BKWATP9dQdfpHYxoF6j+0G6kRzwlj0VehALmmMgk6SA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oy3GhX6zSbydjOcUWxhk2ZLGgyodlnMqv+LaOd//oHTn70gwYM9K+5JREtD0AQxhd
	 pxUNPkYr5gi5H3np4PMPnDtwx0BfQqAk6wvT+8FsqBREv2/DaNh0ZJTzt/s7KVxe+y
	 zCwY8rjmzrkuinBB+v+dhEeWTvS7U6RUmE3W3rB+6NjTI/fZaBiD/JkxLvYaf0Dvb4
	 lnm06vzxzOFJKn2n/0+js60Hjfi1gXyxiS8oXoeoubDwcP7uDCW3B+DtalGPGMSyD6
	 bSU/EYJSExv4x9DTaueVvWc1kqyz59S5VcWK4ziZ5fizU7SMLPB0pIqgkSOAc1Aw8e
	 v7eWqRcK1naIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A4C780F8C;
	Mon,  9 Nov 2026 21:51:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AB13EAF2
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:51:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A84E980F8C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:51:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WEwpGgQPxxOH for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:51:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7C0DE80F80
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=f1JwVNNd
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7C0DE80F80
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:51:44 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6b8e2d8df4fso793540eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794261103; x=1794865903;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BKWATP9dQdfpHYxoF6j+0G6kRzwlj0VehALmmMgk6SA=;
 b=f1JwVNNd+T+3FcgFRjfW9QHLm+8cTIdlf1mOfqCAEztit/ESoTWfu9hZ8KLXFpC0TV
 lvTkYA4laSneMSTKlnLvavTZOSToNriFWT01UCLUeXe2zkmS5kRPqEctZlotpeMxMI3y
 uyO7VwmQdo20lltCamIyv0aT6xSAAcpFkbyjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794261103; x=1794865903;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BKWATP9dQdfpHYxoF6j+0G6kRzwlj0VehALmmMgk6SA=;
 b=dVN0zqVNJQXES1KMYoTJFqXjr9VK9c5eNaX3dtKM2k+85krcuO8GF5frO4jze18uc+
 J2OVFL4gDdDnme4nvYvZzWGHKLlEXwCxGkU4bl5QtO0gdmBYe3BRIYyBsWBJcCMYYXZm
 vihVsAJDrjz9aC8hDTgbBf812QXNbyyoX6HZ1lVcXmSZKs/AHv80lulvl5M47iKy/kbg
 YC6Hiport3RO8EYh2sZ60ix+NjkPws/FzDvfoJv/vhrWYxZX7SQCp3hjxTfmYWUa2fTV
 kO1Hw3QvB3oo0X/09RYm2doQJSH+6ADy7idJmjEfqivPfvhdEvRZPsnLmVKrLvwcSMDe
 uEJA==
X-Gm-Message-State: APuU4Z8ILRo6WHgLgXJzXqZli5ZmszS0OE6SPi0mwu/hjWOOIRKvmEuV
 ZGQQ+TuH02ZnOiyjMkA8R+hdGrGqfQmKYYbaGlivfEBrLcWWombSh3g9/jRnzF2WQnr98nTon9h
 MTaM/PNI9GWEX
X-Gm-Gg: AYBFou2RewARkp0IGz1xluD37BZzpz8xVEtEll2GNJZ4eDEylF9Jl9IBBBh6MhHLZju
 AZx6fWwNXhFR1UOcThDvI7A8JWoqGsKOaY+o2xxuErl/6+/7MvETzqSr9Kk4Z4qXvNLTQXwKWbf
 56cU0ItDhEFly/IJRm0XMlsuezTDCOMX3eQO3deaBtrhb1m4HctC94X/En0r0jPv6yIb6m1ymN4
 t3r92X9ssqqtbdJi6UOj/n4B9thFO8bqi6JpziDO2bg0HbxoAGXzNnnS4aPsBPTXBvKYti8pWxM
 /NBFGBLjJ2ciMcegkG4oOuIAi3AjY4AkxtHIwOAil1TFUhMxYeTpyxbKA+rH68XENec4Pr3J+Zk
 e0PLT1u3tNUth8Fa9bRLVdy9kFwvA2rEs4JSF22jVoIb+2HijnI80XlOkhL1f6k2iKQvTCXOCzx
 WZJvnIjaNZ1Sd5D59AwpF1VwDam8GFa0ag0wg9NgS0/YVNGSIGj9s3j9BRr5dYQwso7D0XIIIyH
 x8lT5hFxNx4tPC12LazSOsDtQsXvroVFNkXkR40GVyyUQWEjqUjbllGxVGWQfdB9aDCHShgpqce
 IXTQzhsl9KqLGJE2YC+caCqczLiOdukb8zo+X3YOsR0Q+jk8ICHxxhNZOUvlL23BTh3ejvD5OJb
 UZLENPMnSKs33rAzByaQi7w/BOacFbeaZPPdBwVGfxts9LpaQXsijkicR1tQsWc0TFPk1yEjsAH
 O3+CwB6Uc4W+5/0nJkYaLYyErJ3ZZDAw==
X-Received: by 2002:a05:6820:3412:20b0:717:da:ba23 with SMTP id
 006d021491bc7-718a6c30363mr182030eaf.60.1794261103141; 
 Mon, 09 Nov 2026 13:51:43 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ae22f6b225sm251507fac.3.2026.11.09.13.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:51:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Bradley Morgan <bradley.morgan@linux.dev>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20261109194726.3227855-1-bradley.morgan@linux.dev>
References: <20261109194726.3227855-1-bradley.morgan@linux.dev>
Subject: Re: [PULL] u-boot-ppc: PowerPC maintainer updates for main
Message-Id: <179426110151.2469268.17374278066374035938.b4-ty@konsulko.com>
Date: Mon, 09 Nov 2026 15:51:41 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 19:47:25 +0000, Bradley Morgan wrote:

> Please pull the following changes for PowerPC.
> 
> The following changes since commit 30524290ed7a2f6bdeca423b329790158dc9af2c:
> 
>   configs: Resync with savedefconfig (2026-11-09 08:30:58 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


