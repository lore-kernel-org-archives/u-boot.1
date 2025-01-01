Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01639E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 20:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5D8A803AC;
	Wed,  1 Jan 2025 21:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z99AsNno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81A4A800D7; Wed,  1 Jan 2025 21:41:40 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A8458031D
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 21:41:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6dcc42b5e30so33084496d6.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 12:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735764097; x=1736368897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JtslV1tm24DfcEbxZD33qc8EoYDD5pEDtDiKD455a80=;
 b=Z99AsNnoIfon7mV8gTj+YbTr1F14mBC9+f7lqxY9+sGJWFMy9zGg5QT1xEUDEyCOZ5
 HiC1Jp2qR94iVwikqRmnECFD7ovCdAi9cHXoIsivJ1tzdRunz4C27DXKw+053JQz6TOz
 AyODwnhUK7errXhNji848RN0quoH65tpGvW4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735764097; x=1736368897;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JtslV1tm24DfcEbxZD33qc8EoYDD5pEDtDiKD455a80=;
 b=rMjKJRAJgZahz+3RfIJxX1qOxOYr123SCId2WT3dqQ2KvozCPLBpqVc5ARDBXAh22e
 8kz+p70T4gt2QxuAUGGWpLNNt6FajnMAfYEZQKmUtQ0PecX4mwyNMvHaZ4VLqe0bGbYL
 s6TDw3p0vrNdZfSVOybbyhXQt+cySxYm7B3v5uf1/rwRoCzARtVzTqbVcAQbrLP+0lM+
 QlnPWmKwE38RRhTSP26q+/65qRcqvW+BJ+vPp+LMqKTT7Cx5dUcmrGSXLZGbJYgtd0/j
 0lOdEOqlMtyKvDYOLAm1LVJNb3dzTHANwRc6q/9zahInI8PcZhKgE2QAvDFvM0/Y6iii
 X0VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgXmtgkCL3dUHB4LmZafv1wXf0YlzecNfcBMxcKilMLLq6UKMnAw8STDlyIn/YGGgCA4qgi6o=@lists.denx.de
X-Gm-Message-State: AOJu0YxPwdvP2TXm/SGccQw3ElqjbVbPfKNh490schDczOJqkpW+6HOk
 slxl1o3p+CXKdCgH5uLMjqkMdHd68euvNQklrS+zwXUOLrQkelHQkmQZeXm3674=
X-Gm-Gg: ASbGnctXhhadTWus82DaqYBrpNXGqNeiJLl50fS+k+F7pg9e3inN6KEqwKhJD8tw/pg
 Wz7HZUtUG25jnKXTJGVrGHQxbTSA0og07y1EtURqsjV3VD/ql+7guJMCnNp/A4yIh+GRzFnpj3d
 +r2oSyIW1OTue0rl4kPtA2nGkPVKrOEkSSIk4n4rDOnR6LveMLi3WEmeVpSD9C7F35WvknRa+uP
 BpuD2aS4+q8Ekmh6kN0f0xK5v8hBnscemXIM9w5z8vmTxy7hfk5pqhx
X-Google-Smtp-Source: AGHT+IHN59OcFFvc28ijQFbd3fuUZis6ppW9Gw/IKa8gZF89tdudvnDU4f7T4b8vogruYUnVBg4XRw==
X-Received: by 2002:a05:6214:3001:b0:6d8:8e16:7c29 with SMTP id
 6a1803df08f44-6dd2334ae65mr766859576d6.14.1735764097283; 
 Wed, 01 Jan 2025 12:41:37 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd182070ecsm124054636d6.124.2025.01.01.12.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 12:41:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20250101032016.438176-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250101032016.438176-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH v2] net: tftpboot: clear timeout_count on every
 successful block
Message-Id: <173576409528.1694690.15525392888832057779.b4-ty@konsulko.com>
Date: Wed, 01 Jan 2025 14:41:35 -0600
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

On Wed, 01 Jan 2025 06:20:16 +0300, Mikhail Kshevetskiy wrote:

> We have a some boards that rarely starts networking abnormally, so there are
> many timeouts during file transfer. In the same time there is a normal transfer
> between timeouts. In this case we can continue transfer (instead of connection
> aborting) by just clearing timeout counter on every successfull block.
> 
> This patch does not affect the case when several timeouts happen one after
> another. The transfer will be aborted. Thus the transfer will be
> continued in the case of unstable link, but will be aborted in the case
> of inaccessible server.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


