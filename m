Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8128CC4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 23:07:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D81B40A5A;
	Tue, 21 Jul 2026 23:07:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KQfOX_eKXeIc; Tue, 21 Jul 2026 23:07:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5E9740A4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784675269;
	bh=ZHUUZsYaMPwheHwPGygHzZfyDYAnOSTHuvvrljKTRwk=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IBWirQIp0+xSTqFlwapmYcat6cReGLFkmHU8ngiHK3xxzu4Jp5GesPVW+ErjeVT1W
	 ch5oubfXPYEVB+44Qs0qZlJfYfnWhJ9QTDy309TDpLlYUG//dUAgfpoOW85u7kAUJM
	 TXy/xgNXq4VCFj3V+kodezcrRydOb/uFa8SU/0ngl0qeB46/slQ+rqwJADqzjMY2xK
	 pmAetX2O27cW7jNnGeyAWclT/IoMwGNTOMIWwcO30nksC3rY7Ka33fn5VSRII6JDGk
	 K6o3jrZadfQoAM+H6R/7VBM0aLwtThJgV0NNHBCYxdmafHvGjy4+yC6zQ1PlK5geic
	 5vbVkwU1Yk5oA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5E9740A4A;
	Tue, 21 Jul 2026 23:07:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 70F81109C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 23:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5805D606C9
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 23:07:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K9rqtfp9q3_9 for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 23:07:46 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 691AD6069C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 691AD6069C
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 691AD6069C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 23:07:46 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D696803F6; Wed, 22 Jul 2026 01:07:44 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E836848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 01:07:38 +0200 (CEST)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7eb68bdf53aso4778770a34.3
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 16:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784675257; x=1785280057;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZHUUZsYaMPwheHwPGygHzZfyDYAnOSTHuvvrljKTRwk=;
 b=TfWvUWsf7OUvRzLnwIhJr0JFJdRtBSbu62rtIJBdFJaPqus+s1a4JIT17DXDKPKsPW
 pTzn+y+5nO9GNJksXQ25IYeovx45ZP3abbxmylNtH3M/UqRYbB4TXSodCdcdqkqEa26l
 BOfeZckH9Dil1jciM1O5hfo427WLxBM7gsj5cpFRu6uHBUTwHnzPK5iIAu1GY5IF5Wuk
 DbnC581hMV1jry6eLMAOZ/j/6wcVZZOz+OJdPNyn3i5Nq+eY8vgn+3oH00h9UsGOkz5G
 iCvjNQUJAtbm8me75Em0OblPz5R2+k832O78cPWOFufGubtzOH2tG1xoL/jthXh6VIaK
 pSuQ==
X-Gm-Message-State: AOJu0YzmCLCzkdTULzaE8EWI33qxMpPzxsgZEpINk34Svr6U+B10/qf+
 0dtzS/L4uJB8kJbtOxLNNQTnO5jm3LV7qPqGM+pVEMxjJbZTX2Bn6tRUNHfUSQPoS84=
X-Gm-Gg: AfdE7cnSrhjTw0KtOnSrYHOhVydTpHeaKfzlOOqn0TI0oU7qbSJVdoRh5nvAE1ghJTC
 xMuOqTIcQ1hmOn477GTNjgwsOTbDy9EqtkC3P3hwB83vqr1fqbZhf+XdKPXWzGYCK9xJ2CB7G9V
 KW4DBjG+94IOG2fwzD1pX9V2xB5HNDJZCCek4mhYu0R6+9LapKhi/npvkdVBgqp3tEKTMtLC3FL
 /vAAbbRqOEoEy1OnPyvqPMjo2Mfn6dMisNJ7ZEh27mLfArUvdU3+803fWFojJLnquE4mb9L9+Pc
 k8ftmeGJge4ywvAFt6ynplWsj2E8rcyNkqFil+PbgaQ9Dg8WHPEuf4tI/HuTvc7VPYUM5xS1FQO
 Jo8VMU3fNIPupG0gerWn9MhHZKSXnRcTIzHVRudi3W4/YrO/jJAOtSJC9yXKyfUmQxs7ugATd39
 eo2c9L5CCmUZmeCW1/kLbNKDzI1yql9Zoq9M5arJDPFl++QLmcHhaposlceEEBmI1TMvSZNTsDp
 tOxLFZBCy7+NSgw2Edssts7CQ==
X-Received: by 2002:a05:6808:1b25:b0:496:fd1:567b with SMTP id
 5614622812f47-4a4d054c6a1mr11562830b6e.24.1784675257184; 
 Tue, 21 Jul 2026 16:07:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab0e9af0afsm76138b6e.12.2026.07.21.16.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 16:07:36 -0700 (PDT)
To: u-boot@lists.denx.de, Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20260708203711.849489-1-rv@rasmusvillemoes.dk>
References: <20260708203711.849489-1-rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 00/10] some string cleanup, and a tweak of the
 "config" command
Message-Id: <178467525599.2724617.537467506455721046.b4-ty@konsulko.com>
Date: Tue, 21 Jul 2026 17:07:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784675257; x=1785280057; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZHUUZsYaMPwheHwPGygHzZfyDYAnOSTHuvvrljKTRwk=;
 b=WTdUCTdvvieLL9QACqYIScY8A0TE7Eh8BHYA+G9+f9K+ymi1PGfujFlPxjA+hltBSH
 UP+FcOwSENMkRascW6SaIvzD2Eq7ILNy8PiTe9bs4qy47ZgkD/BS7Tu+oYpoFFQeDcp/
 TUgRGpTrGci/8CWd8hMxWyx5iWCVyRnmLPFRc=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WTdUCTdv
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WTdUCTdv";
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

On Wed, 08 Jul 2026 22:37:01 +0200, Rasmus Villemoes wrote:

> This started by me wanting something like what patch 8 does. That
> wasn't too hard, except we had no strcasestr(), and also our regex
> engine (which I didn't really want to pull into the mix anyway)
> doesn't have a flag that requests case-insensitive matching. So I
> wanted to add strcasestr(), but then I stumbled on a bunch of stuff
> that should be cleaned up in str-land.
> 
> [...]

Applied to u-boot/main, thanks!

[01/10] sh: clean up asm/string.h
        commit: dabdb361633d93fd753157273a605a44bd5db557
[02/10] string: correct prototype of strchrnul()
        commit: 210fedfcfc1a146faac67dddb3581c6b9dcd01b4
[03/10] string: correct documentation for strstr and strnstr
        commit: 6b58f877bdd70003b6c57b540693c2e188b8cc8a
[04/10] string: remove unused strswab() function
        commit: a31d9375dfbd7f0f4030c0b81f2030ff554529be
[05/10] string: remove more pointless __HAVE_ARCH_STR*
        commit: 07fcb18623b4d4ad604668cfccb63890ce300ce5
[06/10] string: add strcasestr()
        commit: 13822d7f42706da356368f1389f8de10ac9869a5
[07/10] test: string: add test of new strcasestr() function
        commit: d589aa4417c57b2f02f674ccd0ebe4f2ba9bb221
[08/10] cmd: config: allow simple filtering of output
        commit: 304e18c9437550096e667adaa60acb6c4423d1f8
[09/10] doc: document 'config' command
        commit: a2daa32913e6e96d47930e408d9b4f3b844bdfb7
[10/10] test: add test of 'config' command
        commit: d408eb2bc5a4675e11d7b77943553386d039bafc
-- 
Tom


