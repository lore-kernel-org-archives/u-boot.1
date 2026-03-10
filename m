Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA0EFD4F3F
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 20:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B191840DF;
	Tue, 10 Mar 2026 21:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uOfacw+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7CAB84113; Tue, 10 Mar 2026 21:45:36 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D9768412A
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 21:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-46702742c99so1559893b6e.3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773175533; x=1773780333; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mq9QYc0yJFYscN1om/MHafeTnn0DATFJq8l2BmWUXWI=;
 b=uOfacw+tvc7slO4s/43H3YmSjZqqE+mewWObHeUosllURqoAG8ILJiOHdt59y+3+BI
 XXXMDFL0Og/Uo51Zjl9jGSWQLPPeuNDHKBIEatJMy4QIiLbk2kh0fvnCIOA9EkYxYwIt
 +SdPCDnX84I7Muikh+ZCq9WzisvSnjAhneH3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773175533; x=1773780333;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mq9QYc0yJFYscN1om/MHafeTnn0DATFJq8l2BmWUXWI=;
 b=v3VQnbj5H9V4wF5X+rWwXwDbdxZboIQ21NL5PHxzXeiXBt7CRKeUUSqAOndzIu1puy
 w5q11Fm2AUKkkEyCpaSNdX0heQKVvAzzgDI9+Dyb3GcnewKgyZw6Y706OZZZt85LadIQ
 ZVzy+T/awoaTg9A0vnWKv1Yvbipm/aak3b2nx0mMQy89Nq9B+nLOx1DmC/veWxvdVflw
 i+5Lh83CD8/C8/2ZPfTGsEEaWzhbtVY+Nl1XMGcb9MHTrdyxCvFl7Nn0KIP5mlFgWW+f
 qtGwwMe7MQbDuGDLDbRB0wHlaMT750J1xXLnIlFcgBIo1jyu0lIVfjIq+0jn4Bjgvx/4
 W23w==
X-Gm-Message-State: AOJu0YxJy8xbN6G5Apzdz84OeesxT2585fh7rWzpgStywbnC0HeOKc2y
 w83FpZ+xCW61W81T937e4J2X8AGZoV5dfp7S+V6xojvDtG1sN0rKqddECfyZfjVGEJx/qiwxTkq
 NP9eDNJ8=
X-Gm-Gg: ATEYQzx86fMeTctaQxhlrna229/sBb3S1oYcZRNQFbc3hNTa7Z9pBoU3Cufk3ZpuB+9
 KEyOQU5V2uqkdAFQvIErV3T3eSLHv8gj4C+2X6zpsr34xUkcGwkOgZI/7ktokVOvjN3M8uk7BJb
 km3t3TO8xC95jM5jCHoTU2IDIgxg/I4aziQTpa+0h24zpAdAFXc9jPfp7okcXy3ajG4gwpv/72f
 b+cbALnyM/VLdgqStK1DTUe8xb1K96YIBGb5WskaBYmNFoXfSl8nqk5cLMeLpxnpWGXsKIeCw1t
 xZ41kfbxGa3Qt7RXJ/GlunRBCZYI0wQTReIWccNuToKyCLBEMpQDWRIRuGmkiC1/56d7ldjVImi
 clEo1Z3ljiHKuSyjiKdqTMoLEuA/2kOhDIq04W3jrArFY2OaAP6lKX8IIASSa9XReNbKG/g2uew
 nyYL7cLjJsHqIkXshrOAUULnRrqEyh5TJo9PanGXtIz2G+eL3ygCJ68TzvfYclUoDIxRxDGec4S
 zhXngYh7unqNPa8pZ+LoMhGzjEZvebsNVRQQVjd3+Le
X-Received: by 2002:a05:6808:2225:b0:45e:f91f:9730 with SMTP id
 5614622812f47-467335cd9damr37178b6e.51.1773175533011; 
 Tue, 10 Mar 2026 13:45:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466dfac3acfsm8256086b6e.16.2026.03.10.13.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 13:45:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20260225131051.60535-1-heinrich.schuchardt@canonical.com>
References: <20260225131051.60535-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] scripts: add checkkconfigsymbols.py
Message-Id: <177317553177.23044.13934087148494771194.b4-ty@konsulko.com>
Date: Tue, 10 Mar 2026 14:45:31 -0600
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

On Wed, 25 Feb 2026 14:10:51 +0100, Heinrich Schuchardt wrote:

> Add checkkconfigsymbols.py from Linux 7.0-rc1 (unchanged since v6.2).
> This tool allows to identify the usage of symbols that are not defined
> in Kconfig.
> 
> 

Applied to u-boot/next, thanks!

[1/1] scripts: add checkkconfigsymbols.py
      commit: 5578bcebd7bd2408aa873a69c75a712d04d198e0
-- 
Tom


