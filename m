Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F964C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 00:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6338788840;
	Tue, 30 Jul 2024 02:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b/9ziykA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B5D1888B9; Tue, 30 Jul 2024 02:33:55 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA41E866EE
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 02:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7093f3a1af9so2296735a34.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722299632; x=1722904432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOm3yT5y+B/31guoWCxyDo7DvhCZyyfjDoT6b9ruHSo=;
 b=b/9ziykA+/sLyyN/2Ig4zS62cdrjpBZ9PH+bADa07uS47+1iXOsRYFl5dRodvNhEPL
 5W1nALWegY+lLjRSmxjFSBnojb3FS332/C4czKMic6iwNiyk0nV8caN3RcZ76nWmTDvw
 cg0nE7FQOCfLqS0h6RQz8a+59gRcIzuI/ykRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722299632; x=1722904432;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kOm3yT5y+B/31guoWCxyDo7DvhCZyyfjDoT6b9ruHSo=;
 b=D/cIldRnC7GZH+rTWC/gJRfusFQI21xQabEH0dVRRhVve9UMC3EN2GCYfU7WaDI6Yp
 ve0K6qAIOt5CMKUkD0avAEuraHCJB4nneeEUrkb5leEvD357HxPTICuOUDXXQPph1YeW
 kwsXNLVugUpeG2U9sLe19ighvobXXR5ccSgoAT7aBhNvVGGIxMzUVSGRregydn46rl6l
 TdAzbOAARFoulZ5Evro5+fGpmzYJl3Hq3Y2dAL5VVpjRXr8aM1A8E2WrJYPLns5S1ACK
 fbpp74r4WRM6OWsugDNcOtz7fPglgfKxIdSvjEhInd47zpHeQ4mcNKHJkED96QhceEYU
 aHEQ==
X-Gm-Message-State: AOJu0YzLJB0lhaa27wOGxWzLEsYQUNjFJPWNhmcN73LiTZl6Ri8A0WJI
 U6ozWpMNieSJO/jt3V2pZy+H3QmvGOdDkRUeQeGnrS0KiURqgAGiQDqW9MXqSbA=
X-Google-Smtp-Source: AGHT+IH6twi4LH4Z3iE+RgU306fBldSBpjiY7ACuOoNZi/qWMb1NQ81xvSSDNmSqERYEMroD+qnvmg==
X-Received: by 2002:a9d:7f99:0:b0:704:4995:3733 with SMTP id
 46e09a7af769-70940ca64e7mr9276950a34.31.1722299631745; 
 Mon, 29 Jul 2024 17:33:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7095ad813f8sm162420a34.36.2024.07.29.17.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 17:33:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org
In-Reply-To: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
References: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 01/15] include: asm-generic: Remove duplicate newlines
Message-Id: <172229963015.3742029.2582988147162745252.b4-ty@konsulko.com>
Date: Mon, 29 Jul 2024 18:33:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 23 Jul 2024 01:28:20 +0200, Marek Vasut wrote:

> Drop all duplicate newlines. No functional change.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


