Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B108CC4452D
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 23:07:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 334936073B;
	Tue, 21 Jul 2026 23:07:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w3u5SbdWYcBT; Tue, 21 Jul 2026 23:07:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B555606C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784675268;
	bh=TpLbBUtirOmCGTuOW747mxWUqjnfM/4ZoTXsggF7t6M=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=PzvbDIIIuAdak8dDmKOWyeEz0lNNsLsor0rK4rZtWg6VwsKiRXjoDJYiM1RdkohWv
	 k8zu9k3V13fT5XjCJMI9fj0zEJ51CEjWX4c8WKaBCzMd28yqexFMu7fe0BCsQkDTj/
	 QEkj54y17GYt+qk0YDEnSGWKHCU1tEH4cS+iWUlubBv+tAqC1y5NBpPBzeHITi05pR
	 2wT4acZfWGswJ38vxmdpGHI8W7h4Elwh4yma3NtRxrjKdYV4/+D9rWHDZ4K6zLdgrD
	 Xhn9hAvT2a5ljO4FrGu/wdWyzd3AsusMc9pnw28FXmCuSp71S/QvIM1vdftUe0hNgB
	 YghKq2S7rlCOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B555606C9;
	Tue, 21 Jul 2026 23:07:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DA5F1109C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 23:07:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C123440162
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 23:07:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3N4ZJ88VhTzY for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 23:07:46 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C5DC440089
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5DC440089
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5DC440089
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 23:07:44 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF8CE8494B; Wed, 22 Jul 2026 01:07:42 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4E75803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 01:07:39 +0200 (CEST)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7eb64371a2aso5203416a34.0
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 16:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784675258; x=1785280058;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TpLbBUtirOmCGTuOW747mxWUqjnfM/4ZoTXsggF7t6M=;
 b=GELHs0M7Mcpvq5LFB/ACAcnJ4T8BKoCuFsZ1yF+0HxjKR2LBSetB3b0FS2+loVZmfu
 Sfk1bsPNQw0ngNziCtoH5a0FnBx0K5e208coEVzw2mGtutW3EfHNFKGI+MpAI8bl/+kl
 tc0uNk5B3mmGIxJxgH1o0Xqai3WLIc61MFdHxksGv3jj0JlDdK9vMK3vLUr2yHPVrLgP
 rXGfDCehznN6J3XYoAdQvV5ABcnJAPZmlJgT3GjBQedMD5+5zcPVX6xJb6BnKUzw/DeP
 H+uJDCGNEeg9WQIDtyTY9yTHDQ3jTdTR6wIHIlyDgL1ZBzU8EzqgeIr1BlT6SyY7n707
 e5OQ==
X-Gm-Message-State: AOJu0Ywl2uZQvRf4PMeuNWP8Il5rTTW35KNaWvqKLWWSpwoClAInn49h
 J1XyPbkqaBwZGgyrnx9ww3OBP2b1EMESPtU9oqDfJFC4XoYLBUIFiQFAEsThSoL508zal1PiJsZ
 ahev5k+Y=
X-Gm-Gg: AfdE7cnSSsrHuRCJdSoT8sN267SKQs2sCxd8WPP5w7LZ5kTTvpSAMZ/s2033N8fMvA3
 WybxkjrUViNqIs1WJNctwE5Vy83xpN863wbiAdIY8qnbjYefNBASGLQbz0r2z0f7Uug0ldSjlRb
 3KaExz+HiIZMHo9mntIAFLkN04TwFJaLNug8OTw8U0HvWlP9EeqVeqqKzoirhcyAVDVG31dx5yn
 RWFuCPwkOBIzrG2jAcGZwOHnC411aRxndLajDSbNry634W8swKP6fK4GZsBYNfZkzjZdvLBzTaV
 J51OvtBSGKhCEuFOj1GxWyVl7Ma23e9gJdi2Qsu36vDmOai6swUX5g6d52IvuWJy7bHXCQQzN+d
 MI6EmMp8kwZBYQByUJ0t48HRzef530zjM9c2Jpl6ypDjGoytmcOE1ev3mGyYJRALgMcRZQR8tD3
 8H3WqlqDUF3yMNEiMqolOKaeKB3wzwfPb2A5m+9VWBBvWvdzF53MQiVP0cGvjBc8r5d5kOnQMWn
 Mael+QUyWIaGXAho1aw6d3wA2pRj3GakDxr
X-Received: by 2002:a05:6808:1529:b0:4a4:c73:9f3 with SMTP id
 5614622812f47-4a4d03219efmr12144822b6e.3.1784675258466; 
 Tue, 21 Jul 2026 16:07:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab0e9af0afsm76138b6e.12.2026.07.21.16.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 16:07:37 -0700 (PDT)
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <ex5nk6rhdq2xmoebwmbxtc3xxepoq42qlqb3u6ve3rd4inpxul@tuqk6be3rl22>
References: <ex5nk6rhdq2xmoebwmbxtc3xxepoq42qlqb3u6ve3rd4inpxul@tuqk6be3rl22>
Subject: Re: [PATCH] cmd: read: fix unsigned overflow bypassing range check
Message-Id: <178467525729.2724617.57564639740669655.b4-ty@konsulko.com>
Date: Tue, 21 Jul 2026 17:07:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784675258; x=1785280058; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TpLbBUtirOmCGTuOW747mxWUqjnfM/4ZoTXsggF7t6M=;
 b=Nat51tftNX7Z6hHFQS5x5Nm3TsDMEIoAYUDkMOxYK6vUcHFPp62fAnvg/kirqm++28
 VSZ2kID/4lOVEgnhOsfahOnAYz3AxHpqIhYJ++TiMlmu+7v4/dg6chx2Z7ZhaDQ2ddo3
 bC08j73P0xqnwdV44Dkx1ApTJ6n7qCDd1Tt5E=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Nat51tft
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nat51tft";
 dkim-atps=neutral
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
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 08 Jul 2026 20:03:04 +0530, Naveen Kumar Chaudhary wrote:

> The bounds check in do_rw() was written as:
> 
>     if (cnt + blk > limit)
> 
> with cnt and blk declared as uint (unsigned int) and limit as ulong.
> C's usual arithmetic conversions are applied per binary operator, so
> "cnt + blk" is evaluated entirely in unsigned int and wraps modulo
> 2^32 before the result is widened for the comparison against limit.
> With cnt = 0xFFFFFFFF and blk = 1 the sum wraps to 0 and the guard
> passes, allowing blk_dread()/blk_dwrite() to be issued with a 4 GiB
> transfer count that runs past the partition (or, when no partition
> is selected, the entire device).
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] cmd: read: fix unsigned overflow bypassing range check
      commit: 1b8283bd3220e898d338fb98929f0b06ed63da84
-- 
Tom


