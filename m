Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1625BC982E6
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 16:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C816E60749;
	Mon, 21 Sep 2026 16:58:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tQ_ZTNL1c7Wy; Mon, 21 Sep 2026 16:58:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F3BF160740
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790009917;
	b=AeUeDoAlwt+ElxaIxNLjNMzsgt+biMCI211OSLr3/LOKMe4775cEFXKJTbxCuvn4I0Gb
	 aYdBLoBy/MuXfUeeb/BTf/NE2BD/6ERzbFW00QSrqVT/E9CXFJuqAwxwalCOpwaJzYXUR
	 XmlCbwrKJ6ZSnWoTGCGd6Ec990tDVpzgziY+NWwakUr3nqo9oapzALvStqemk4nlfsb5R
	 RmUzLblA39anKOycV8J7794X/o888DDm+tE6OltxIJRS7Z0jbUxyauAzz/B4JdPPsI74K
	 +cNW7/ljCOkNaMRuwzntTj3Kd9H5KbctNmcVK69W9nDcNaZFZ+vKqTb/4sOkJTmBCEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790009917;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SIIx2uANHoK0o6SKlNGYLLdTfHAGwkXAlP74ryMG8Z0=;
	b=Z2teVTCo36/vXGOv5yQjUESeLQY1vkHtB27PfREQekuRaWUtWMHMxmUod6pak0X1uv48
	 WMDqAmPbh6aX3eQVQg25Dx2LMn0GPVwqXvkMc0Xpbp/E6vj2NvPPzJqo9C6WvigDpE4JZ
	 /q6mZppM/48TxtQEFE2evA/lGx7T0XA/ro/hnDHz4aB7HMCbpZ0Vnzc/3UzwvK0oFiNQ+
	 4staEKFb0SiXdy8GcdNBP+FkgoDXN3aKRKxFWbXXfO0sbrbxQ3Qn0tX6+XwzkMpLrur8L
	 v/UQ2apmwr895tmSZiayCfacqJ33iD3nyUdcmJVVhkpYR4jyrw77cEliqmQwWHUq8Lw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790009917;
	bh=SIIx2uANHoK0o6SKlNGYLLdTfHAGwkXAlP74ryMG8Z0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ducNHJT36AcPWzVZNEXFkS+MjkFWXqAl9XT2h2Lf7fu9lepWAiqf5Anxs0pGZoI+N
	 NK6YI9N+De+cfvV7VCoRGFpgzHsyJMYwqpR6NTsSXGvsJbpR73I/Rjqvcrelf+VUAx
	 EIObYqaHKKJnhVvdbnnwUIXqH6UwN01souO4rlZcwa6SJ9yn/T9iYEEWNkasHBEUDF
	 Q1LS1zqht7cBTuJxC04alp/yY2dMGF58Fk3HbaGv23GqllL5qy+//tij6BosAJq1qW
	 J3TbP2aT1Lb6WzVTHKmEh8e5mElW17foPKcMbN2vaD07ErtnMV+44NUCRnEgY9UnUQ
	 W2HywM04YrSQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3BF160740;
	Mon, 21 Sep 2026 16:58:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D4D6224
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:58:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4ABBA80CF2
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:58:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n9eFD2Vi85wr for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 16:58:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 70E3380CF0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::44"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790009914;
 b=ENi1Q6tKpG5eL+lTsX4jX6b3nrTUW1GlZT0VbXucumLhTxDxuE1szlN7aA6OhJCgajOG
 NSvo9v6/SRBPEilXk8+kJhWtRi0Kq4GfLfVptLsJu5KgdFaV3zSi0fZxR1yJGLo6PDOiL
 Avy2UijcxheEiX6bdQ3oSt5ob0Rw8Ii0hWTPQDj5ng+PF6WYhtXvhkWzdMfEoPSkx1+Ah
 QDYKKBqrqwbZqyVXWbHaHH+DUOc3d40JKuKUHJKb5AuBJ9Bv0kj0A+js/44GT3jPm+Syk
 OV77ZcdVPxslxp6HT9/WChrgg9qgJRBIjQ0H6HWzzbqtSVfbTj638CK2PeXNcz20S6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790009914;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=SIIx2uANHoK0o6SKlNGYLLdTfHAGwkXAlP74ryMG8Z0=;
 b=dXmq9HIAoh7nXPLx6H7YL50r3w4DCqICyBP9y1KwXrft7AvDpUCb29zIH9wH7K+fi7zo
 EGXuhujwe8sq7GVTWBTJkPeZ0qhZN7Utu93gPZDvQNcyE42ev1T5eI15x22x22ITtHpv6
 DWCgkLf2NwAboJr+svajsil+L7YYrdS8WifLwCk9T8cZ7rUm/lnSQhkvxIfH5hKWexndz
 cwXlQfNrxLQf0KyONVen0UJYFls4r5lb1/TGQjdfsOjW4aNFZyzb4EG2SQsybiXnG7Rkg
 MbqKnJC+OyByEN1i7i2Ynv3Y7NDcRUjSklwpp1lIhcamqvVT4q8/wsbhKBdkEgag9NA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VQHyOkc1; 
 arc=none smtp.remote-ip="2001:4860:4864:20::44"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::44; helo=mail-oa1-x44.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VQHyOkc1
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com
 [IPv6:2001:4860:4864:20::44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 70E3380CF0
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:58:34 +0000 (UTC)
Received: by mail-oa1-x44.google.com with SMTP id
 586e51a60fabf-46556b9e02cso57894fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 09:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790009913; x=1790614713;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SIIx2uANHoK0o6SKlNGYLLdTfHAGwkXAlP74ryMG8Z0=;
 b=VQHyOkc11gpYNSbEdKrhG3WW7qH/zxgHTfOG2Wh/ABwDzPtypU7Zeo2fE/Az1oPLHt
 reKUFe1D14QmJtsie5CNz9Ze/c+b74fXOBoGpykes33NLtz+JWjDzGqUQJpfcDjzVrld
 spsm+Bv8X1HNi31yQT4B4rBcq54k7mrvJv+2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790009913; x=1790614713;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SIIx2uANHoK0o6SKlNGYLLdTfHAGwkXAlP74ryMG8Z0=;
 b=b7I/AxOxLb1PfzlJ3esJK7tjGWJJBDx89XwseReAY+9c77oECe3ySngfo8RQFBGs/5
 bYUQu0xve5QPw7tDXAuy60J4UXYfRYZx/xupD6R/0DVerRn08EsgF24IfTYT7v9x0Dxt
 jXxZEFUrI1RcsN5CXLaJH0sBYah7FdT2JBnfnp5XGkuqRcLycOF2l4TWvDBwH5zk4TU1
 LeWBfdQdnZnLeFUYJMrFGCP2uOgVDVwILrJ28EYGlbVBDmBEGz7Lalx3v2CrFsEOm35T
 q86s6/M9oQABwHQmULmA1upiKPLaORppmbT0xFbexbBCxjbJv1bMiP9gdrxbx9lczLwx
 YXqA==
X-Gm-Message-State: AFuF++kuJ+pHehLSnfu8DQJMqsw/fjVIuxlzgvcqbbbzvbgFWdh3g9mk
 mU5g7KljdxVuNAAjMj5ZFzrkG+zugsute0aVxbeICNkHuupHKTGxLTVsdTy0vFQAAXw=
X-Gm-Gg: AYBFou3CoPVfRtJ8fx8Da9W8TXaCkcaIBnHpR0mEeBfwPb58rtoJl9+CtZvT+N34tvq
 cj5N1qN+MKUAvOLKbOEpRVhet0QA5YsheEqZRXkk6K2P5cn3rdxOq5az7NxNaC5xzqTo4lZ7X1r
 cMvkHGwLKnt7PiKxsEjvXSiJkkI9y/sy6tXeTir6gzcY9AfZZJR94lfLL6UWyHDMM03DQ3IzAJ2
 Ou6iJcTUt/iMwLjCgrGShByxsTtFzf1Ivwde8itNtpyWfwOB6wqIVfnAawJJ8o0dqFTvaS8/iZE
 kpzXElr9DDLzeoLNXrp1mMkKuQDYLAwzwXNjKEGQYoZEwyAV4u5WkXpLUjMsCygvA0MwisBBu7p
 4kLQ3lzzyFxkqZ+dlcZPowcy2ddek7qcEFwxnqWiirVV8N16ePiAar/6BNP7APzcRFtBQabgiC7
 Feb7WcgOj9Cq/sScx2hnJQ4JapAbuno+Hjj4LVJncX0DltfaF/W4l/nNT8fhFw4Y1DD7ITLV7+H
 /CtG7g0CpTsl1+Q1o6D63kcRHmtKjzutXpH1ivckhnawyqspTcSTxBGFDELVC7HgyO07oyCU8JA
 3IxBzoqBX3PAIyLQjw==
X-Received: by 2002:a05:6871:e0f5:b0:48d:eafb:22c7 with SMTP id
 586e51a60fabf-48f415effa8mr271327fac.9.1790009913047; 
 Mon, 21 Sep 2026 09:58:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4881f4d7861sm9261433fac.1.2026.09.21.09.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 09:58:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <d8668918-b2de-4f46-bf79-c492c47ea874@foss.st.com>
References: <d8668918-b2de-4f46-bf79-c492c47ea874@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot master / v2026.10 =
 u-boot-stm32-20260921
Message-Id: <179000991234.3174152.17818406904541849789.b4-ty@konsulko.com>
Date: Mon, 21 Sep 2026 10:58:32 -0600
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

On Mon, 21 Sep 2026 13:58:11 +0200, Patrice CHOTARD wrote:

> Please pull the STM32 related fixes for u-boot/master, v2026.10: u-boot-stm32_20260902
> 
> CI status: https://git.u-boot-project.org/u-boot/custodians/u-boot-stm/-/pipelines/1335
> 
> Thanks
> 
> The following changes since commit 211de43d0f954a00a490220c1aac9db298287c40:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


