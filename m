Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51073F53D6E
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 16:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8514A84101;
	Mon, 16 Mar 2026 17:34:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nd7V3tK1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 083B984106; Mon, 16 Mar 2026 17:34:49 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D80ED840E0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 17:34:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d4be94eeacso5462839a34.2
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773678885; x=1774283685; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jKhI39F8S/GdL3ufjBgmi8P+tsWheis3vb/K1YyrpU=;
 b=nd7V3tK1cY4iCtJACWGcDFWNAOu4as+gVSOSBBH5uSXfIvHNMuXnc0YtNMK3bK6rBc
 qji67KVWSdn6yLQNBc+Q57zOo62ACB04KFMorPquyg0qxYvQwzZpDPIPrwQwQ2DVCeIY
 QLU/C0Z7IG+fHK3Ej0phslmZLq57UGA+ClxYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773678885; x=1774283685;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3jKhI39F8S/GdL3ufjBgmi8P+tsWheis3vb/K1YyrpU=;
 b=kctSawkOjD4o8GlYOAN13+iBPf5w42yRPFT1oxhCdjKaC6JClBt+N5KDoMBmxfhNGD
 Emu73fNYpF3nRrKSeXglkRECezeiXa2SI/3LnGzHXheZ9P/FbTtDGU11qrSpufp2FoLP
 EX7FzxD1adRSpNg3/sbOI23dWJ+AuDF1Cf4lo/RbVCNfmXSHwMH+cMZb8pdgi8pMk9Li
 OqNYWsZ6zjMCgg/r+D9c+1+0TQtZHL7fbH8BnmEEjMs45xIwtUtsDxuH71LG4tMy7a0X
 PmrafStAnF0ueSbrpY75Zoy+SymtXhLxhefkHD+/L9YyCQx8Yn6KWA99+A3U6aqKCH4U
 vYRw==
X-Gm-Message-State: AOJu0YwuyXVtYKghwhcnaOcnBFXYofnmnrwzsq9C/aRXQdo/qwrqNgBq
 hdsCyPP6XwYtgpfeeZh4RrfxM8n8UkP3Cyv+FS5zZvqG1xhc8LCwwJaZWXMExFqNVwE=
X-Gm-Gg: ATEYQzxjV/FWbYxA/72NMFQ6fDzd5JEbcJ01R+9sGzQNYfC2TRhXm0Wx7j41/qrlqSV
 slw5b6IFVQ/FPbnKXGOAa+Ub+dH/+PwoaaavhP6IJkOcq7HRsd77JhaGUMUORaoYJRAplSIPvJi
 SibTZN6CGZ0QKAqu2y1C1Z605QGy40X/aR0npOS9HfLn+pWErek9k/BbEGVx6M0B6fal/dMuyZX
 rXfj1atP/A5AmpCDM00fn4bHPuY0fUpjkq9/K4c3HRrRUvPNws+aCDxMKUXzKGRpTtB/xsw1Zvo
 VuHwt+u7/zeetdcVennN0NlOW69+LOEjLlXoC+YAfuYVxpGZbYRuVRvDADUENXeBlXQmEE5PUo+
 ioMlaEFF0QXOR0SdNVCxlgx28fFHrYcYCCahtQ1cREdPjA9dqrXrEW3r4mG5oajsdz7+v9fiUyy
 ++5oiUudDqFD/kjQakfY5bWIywt6AT/E9zhcAgjVFU96wtPvlPrkjj5h2wLV7ul7a638loy4lE9
 wEI5n7LP7U6zH2T4+msZntFSUveiwsUIb/0Fv2lkWVNiI6cskyK2ZErnA==
X-Received: by 2002:a05:6820:1ca1:b0:67b:f209:d9a9 with SMTP id
 006d021491bc7-67bf209db2dmr5359815eaf.26.1773678885506; 
 Mon, 16 Mar 2026 09:34:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc91174fbsm9660143eaf.4.2026.03.16.09.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 09:34:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <87y0jsrlty.fsf@kernel.org>
References: <87y0jsrlty.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20260316 into master
Message-Id: <177367888472.2244648.10307734617013543702.b4-ty@konsulko.com>
Date: Mon, 16 Mar 2026 10:34:44 -0600
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

On Mon, 16 Mar 2026 13:38:17 +0100, Mattijs Korpershoek wrote:

> Here is a PR for master.
> 
> It contains a couple of very small changes. I don't think that they are
> particularly urgent so if you prefer I can also resend them for next
> instead.
> 
> DFU:
> * Make DFU_WRITE_ALT symbol available outside of DFU
> * Fix PCI subclass_code warning in spl_dfu
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


