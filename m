Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185CAC531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 19:58:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FFAB81203;
	Fri, 24 Jul 2026 19:58:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cNTY_zEPHazV; Fri, 24 Jul 2026 19:58:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4A0E811B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784923097;
	bh=jeNZQwWLtj1aayqjuqUMbIVlGyzps9AstQDzp57D1M0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eF9V/bNmbTS/ySr8+5REkN+bblL4RMEt0nnXx1EZuSDgyq9tEroc23nyVSjTHrLVS
	 spnNun44zX5pmRzc7ayZvxdRvZJ+5NyjIDhou2GSM7u7MilVEQbEu3wannZrW0r3Lu
	 CEErQ3rOXt9sHO9tHcDnCKr7p6GiH/55tKfG9uVzoPHGs4wHmWuqBsigyr417BQ74L
	 D/rr2jaietKKHyD3atts7laPPTlMXZn5nPPXowEaWYbNUZxEKROkkbHn8mZiAB3kmo
	 gbhC2VFZGN++6dsBHoB1WAT8lmDORNziOl/maJeZEn88DXaHaensd8eoWmimH4OaE8
	 Hr4QNk/XtM3PA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4A0E811B8;
	Fri, 24 Jul 2026 19:58:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 58263347
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 19:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 559AF60684
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 19:58:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CeqPzNDQdmhe for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 19:58:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 884F6605CA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 884F6605CA
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 884F6605CA
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 19:58:15 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6a397a0e5d8so454389eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784923094; x=1785527894;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jeNZQwWLtj1aayqjuqUMbIVlGyzps9AstQDzp57D1M0=;
 b=UFcQTabXAZhNWOkw5HofyeeBBtzJ5DKWHKk0XcSna0S7ZAiRZDw5zpH4TVi+38z5Nn
 gb6bT4cuN6QKeYX8yzBpDrSl+f0A1WQO6tqpXfdR33rvjG9FYJ/LB5wHqw2GccLAe5ap
 79T46CaW4nZxOWH5p19l0dJu3JbRDGwcdcYoLy9ifbfUkeYYEBR1QnhoRdT4zGi2PoP+
 88WvNxsm4BxCcZbhFkiji+YPKKAm14hgR4Qr7CkNzQAgE7Z8B4l5jM8wzYteLaPacFps
 PlXa4LMjADDFirlzY9yNVYCQs/vOn45gPq8psoJLyrHYFntQS201oT+lldp1K3gqU+zO
 9ipQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrt0DTTYD/b0bg0Tc/C5Y9liiVpkaVhz138NhKrnM/VHLR55pOdBDXDwmMheugrCXKWw5MzZtc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzMtSMpdJ/Lx8bi47thpTWkgBw8joG3iRj0lqSXWgircE+uxsMb
 8zaNGc4rLrUz30eWaaXVzVngeU+Z2fDf8wLHTd0LN+rtvgRbTSC8x9cMF8EGTE34hSM=
X-Gm-Gg: AR+sD13I5cez6kF6vScb3m5Roe0qeBMWCJfCTpxEbslU/xhSDghRkfS0I77JNwWQ3+L
 F0NPOozSMgf7Cp5sMfZMe5VP9/hUUIRDQvXDDGsqiq6VBOytCq+eKzgRBS3xKEE6+Y9mcZH39s/
 Lju8Iw+G0Q2T9jC0YKsaMZnqNmuFH2KHk/DSDlIz3FnFuZtovBDEpZIHw9RrN02/ja48VdXFtHg
 B34Yv+iynXmOFCgot3FICb6AocWxDjPeJujqFfR6Ltp4vqt93QUDlLpR13j7TgKUfwO2STrchdj
 vnUmWFoEV1KFtImG81a/TYCaILHLgxwQ3Vtetx/z/x//C8JU8VbqE1NblEuvmIburKU9bGAVbdZ
 KooCRXknqIdQ1owbv7bIRIFfGPiPJB1IJ6tD0lJ+5o/PpjcdqD96ssIxwgg+CTwRWgqBAxW++C8
 nSrOe5RnWW6VYjkl0RH0bYuvcUMgD1HTCJQW7cyxz2D1VLWGJn0XA3BQLdCoDzveUbNNhvmhOh2
 f+GirreFnMNAtIfC89P5h5SKQ==
X-Received: by 2002:a05:6820:c83:b0:6a3:8611:8ef5 with SMTP id
 006d021491bc7-6aad3f90d90mr5678266eaf.1.1784923094263; 
 Fri, 24 Jul 2026 12:58:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-457df637329sm1269065fac.5.2026.07.24.12.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 12:58:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, quentin.schulz@cherry.de, dlechner@baylibre.com, 
 jstephan@baylibre.com, GSS_MTK_Uboot_upstream@mediatek.com, 
 u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20260709104940.75514-1-ccaione@baylibre.com>
References: <20260709104940.75514-1-ccaione@baylibre.com>
Subject: Re: [PATCH v2] fit: prefer the default configuration on best-match
 ties
Message-Id: <178492309308.3440456.16808163993571673826.b4-ty@konsulko.com>
Date: Fri, 24 Jul 2026 13:58:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784923094; x=1785527894;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jeNZQwWLtj1aayqjuqUMbIVlGyzps9AstQDzp57D1M0=;
 b=A9u9dlrVxHAH8E0Z6HM1dtyQ8bV206I9TI0qSks6Jz8QVOnnya+v8K0DnjzKXyVqUn
 iK4O5EOCpVUWNt6Np1DOIl6IjZzpvjVi30oyz8pqrcgMA/eO9ov28hUEAe/khfHiLdlw
 j0vX0+lSVWuMUJfMoguNQ4iD0/pa7mxHdDFPQ=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=A9u9dlrV
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

On Thu, 09 Jul 2026 12:48:31 +0200, Carlo Caione wrote:

> With CONFIG_FIT_BEST_MATCH, fit_conf_find_compat() selects the
> configuration matching the most specific U-Boot compatible string; on
> equal matches the first listed configuration wins and the configurations
> node 'default' property is never consulted.
> 
> A FIT whose configurations all share the same base devicetree compatible
> (e.g. one manifest carrying a base tree plus overlay combinations for a
> single board) therefore always boots the first configuration, silently
> ignoring the default chosen by the manifest author.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] fit: prefer the default configuration on best-match ties
      commit: 574b1adad70a19d95c65e0f37f9c36d94fb5418f
-- 
Tom


