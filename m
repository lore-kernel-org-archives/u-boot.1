Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D6CC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 21:56:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18C2860A7D;
	Tue, 28 Jul 2026 21:56:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A8VKi54d35zl; Tue, 28 Jul 2026 21:56:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E65B260A74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785275813;
	bh=J+/mtLWnpvaKlgzTb9e8BfiXNckpJ/cvKs/+yTOPna4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZsYS4mVYLTJ182f/YF7FhIztzqSd5X8EM12RZ6fPTzBu3R+Fiz8cLJbdrKppjc1+b
	 yRmWhrkfvbEY7y3wXuozl+vG6KFTyJ67C2vYmwgBZu8gu1fZAuGdIf2n/ReywH67vK
	 0BFqKKd5aiO+Kwn4BdZ2BEAWJmiTCBRpwJmctVxMGVQ3qlRYIQvo/BJxQkL7U3fPnf
	 BE0DLufi+jjofdnBvfHOtLbJg0AUEQklU4jJq6xxw54DlSi8B6Nrqi83+TvvmaCPE+
	 W1FRRIZ/vL0kUf5Cnp4L1244FMUg0PV4Mbm724qvRwhodfC335meMM7FFv+ZjH4/3h
	 kI5q6fMqM7zYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E65B260A74;
	Tue, 28 Jul 2026 21:56:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AB0D22E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C77C8144E
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U2fIO-v_jAoH for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 21:56:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E930381290
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E930381290
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E930381290
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:46 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7ebd88be784so287113a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785275806; x=1785880606;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J+/mtLWnpvaKlgzTb9e8BfiXNckpJ/cvKs/+yTOPna4=;
 b=N8Sx08aULs7soOQAyH3/BGeRfgLwY4N0rQLXGagV+8dW6C7YLu+/9u6S+D55SkculO
 jGYn/4noAOnsuMN5giir1236Yetkl+IEv++uNSkzpC56XaUhliuknQxq/JgxPMVML9Je
 2rCuy8NtcDaLvHUVi4hOp4OI4sAt3JP6fJm9ScbBB+hsm8742+AToVdzFZIo2R/qkiDX
 vtORs2qI/jF8mIUUt5Zkb3NP9lMpv0KPr8Jcfws11sdphZ4IKzKdGsEwALW9bxqxmrGz
 G3zLFa/2jTohzaA47gydHmOC1cmVUhdlxxal1fwpjYr6Xfx5ylrJ/xptKxwjBii2hTHn
 cgzQ==
X-Gm-Message-State: AOJu0Yzd8SOY8rNSul4W+WySIzJQ/8LZH8C0hLZdRZ/igBrFP5LK5ZIa
 ayW3AfP+b+V9IR886akWwiImQFjILKgJloY3zV30bmVLTXIvS4M/oUEqvpBAuiJh9Y3CN3/jo07
 oLTpOk3o=
X-Gm-Gg: AR+sD10rSyuwncwRvnoPQ6Yu+SYuoqCCZiKxF5RQ5CS963Rh9mTBBr17i28Z+ZDTGE7
 mTyVqlhA+EjjYJc5umLbPJ4EP0hko7CgnzyWQ1BsDqeCKTTMazmWRQ17zHPXOm0duFkODkQUonZ
 +gULiEOVwjLr3einhRG89UUHLfQjM3moRSeiHiS8E0og+QsoSmLANO2mxQs7HQmbKrEDb1fxvxt
 utTSFeW7qM+OlqRjXgkPKqLYcmqL6q/UB4pFSKdbggoW1TTD8Y9fc6YJRXs7BvHWfLo0nzguSuA
 HK13how1ZQ2SoqlU/xlwvGqdmY8nDzPvkkVRQroUx5b6prkmOBQPrLgLQ2/DCosrA4KS0JA347H
 wtjdp1g5zGZRcZ+OYCo5HCzPSo0w/qBcNyNkB0ejJlbijV8OMIvuFdagFugRZYKas2jRLS1RRYH
 Pbmbe6I5+tqeLr42jXJc+E8AE0tGuk56LaJ2vrqMarvJ/4LJbxrxhg+wK4pv3pQDFvB9c9V2m5K
 jEuXioe/WcGQY31+1TRUHPtCPs0ZEiuPi4YuWPmoz2hE8n+t2LhCiYI/JGVo86vFTHpHXZkDtc+
 uUZGps57dQ==
X-Received: by 2002:a05:6830:2653:b0:7e6:e114:899b with SMTP id
 46e09a7af769-7efff26f0dbmr1970334a34.21.1785275805779; 
 Tue, 28 Jul 2026 14:56:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d2d8112sm780106a34.0.2026.07.28.14.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:56:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Caleb Ethridge <Caleb.Ethridge@analog.com>
Cc: malysagreg@gmail.com, linux@analog.com, philip@philipmolloy.com, 
 Caleb Ethridge <caleb.ethridge@analog.com>
In-Reply-To: <20260716122649.646-1-Caleb.Ethridge@analog.com>
References: <20260713174726.12157-1-Caleb.Ethridge@analog.com>
 <20260716122649.646-1-Caleb.Ethridge@analog.com>
Subject: Re: [PATCH v2] arm: dts: Add SD dts for the sc598 EZKIT
Message-Id: <178527580495.1742553.14428422549722679990.b4-ty@konsulko.com>
Date: Tue, 28 Jul 2026 15:56:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785275806; x=1785880606;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J+/mtLWnpvaKlgzTb9e8BfiXNckpJ/cvKs/+yTOPna4=;
 b=cfrl2YQQEZiz13vaNIEKHoehwfv5+uumjKHPa7d4MeRP2jw/6PfSC6ZePMrBM5UAx+
 9EfGoT9KfYK+kx/Bw29CJ+J8Hj1Cp4LGiwx2yPPgtqfMnPMN9rtHrWG6SmNjP0oZyXhS
 ShEM8Nzs3DUYtkYYp7bpFyPpVIyKtvzbBSePM=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cfrl2YQQ
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 16 Jul 2026 08:26:49 -0400, Caleb Ethridge wrote:

> The eMMC and SD card on the sc598 share pins, so they cannot be
> used at the same time. Previously, this was managed with a patch applied
> by the relevant build system, but patches are brittle and have to be
> maintained. Instead, they have been replaced with two separate device trees
> , one for eMMC and one for SD card, which inherit a shared base dtsi.
> The build system can then select between the default device tree which
> enabled eMMC or the other device tree which enables SD card support.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] arm: dts: Add SD dts for the sc598 EZKIT
      commit: 1a86b8764f8fc13599faf247b4d2f78b4fc6cd3d
-- 
Tom


