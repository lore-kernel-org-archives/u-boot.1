Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B99AD46C04
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 21:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9189083DEC;
	Wed, 28 Jan 2026 22:54:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C9l8510T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E92D083F26; Wed, 28 Jan 2026 22:54:22 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BCB783DEA
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 22:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-65e943048afso160846eaf.0
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 13:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769637259; x=1770242059; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sngh1UDruJ9mowIDFrZzYPTfwZeZ/Mu/iXrDf+21tGk=;
 b=C9l8510TPRAJYdhif0PTt0PUVZ2oYjBJWigJ1aUROOtkHwdusuVcRGmM1UIVQoqqr6
 xNmJhOqxbyJxbH+8/ap2j2xfIMQutjlCOn7XwUbbk9E99pUGdw0oyZD0bIxxM+BLTiEE
 nlctKQG54Tj+N/w5uWvR+MI6jOgN0+fwZ3NVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769637259; x=1770242059;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sngh1UDruJ9mowIDFrZzYPTfwZeZ/Mu/iXrDf+21tGk=;
 b=xUsUZjgKamv9Rmyghg4BzUg7qyylgiDTdEqVW57xJbAINbRNGEr2rZvkX5+wW7Ov3h
 52AjBmnhPn+ZHrAUE6qFL981ZBkNMhbCNpPfjQAXzxHL3czcDLwFuEj999rECpfLLkmA
 eN2IsvxlZnqQheFnFYShSDCdIKge6aqbFo6uELSQ8qu7+y7I+TXelaxb6dj6HaTsc7hR
 4cpODSzXr4jeSUHcv6sitsK9CCcK6SQ/GY4oQ5WNUHeAXQntJEnEFn8IMb1WYeEQyHzB
 KJuuzxoofYlbCzCQdWwgZB4APlqma21chc/lId3uPu9k7jokwqczoj4SUHcM4YI3VXjs
 tU+g==
X-Gm-Message-State: AOJu0YyllhlpCEWattKyIAsbTJI63NeIb3CYlam9ltz82FxhG/TUh0v6
 LOwcsA3Md7aciB8J2Y+xNkgyWlU33r4pkUPN060tMokjxiUni8if+UPfo140E3kko0QdRgWVHDP
 6q6SKNvM=
X-Gm-Gg: AZuq6aInFxVjXW4V+0ZEU0Tfjy0lPc61BX1hG/miCmqWca9c/Yqz7SHLgyjodnTteby
 3jpl4p7fM7ardyv7lloGXT66C+DIA2VEbH6wpKJfrHthRt8oEhYkgIZh4A7A3na+I32p3y258Iz
 JfYRii3BGEmx722+tCYNyRjNBizIHbY6cautdO5xfJ3n5jGhWgIpOuNLMdElt5xpFfmUy5nFjMJ
 izadQEgEyfECzH5WDoAu61nn7KXpGnR87tg4wQYjwhX/MzYFn3iUuc198XmjeQqPPLGoka9xfRa
 u75UxSCy0JGz5l1z1OYeOSvRglbUsfKsDKM7wkd4CMx7tzYst8J0daTv5920kSCwWnqAklZYlq7
 7e+JtjFiur6jmcoeYLwUQP4g2EJubFrZms6ALVBBHOTQKQWdkfaxV6QyL6/2R0oLiv3LV17our8
 fy9AHvgPz7YhDIWb0t6N9vE68NdI26dEuFrzW1Rm8AidBP0wlsgM/0ldEc1pUZdo2+bhzTAVc4e
 DRESJjbYtafmqPa1IC/MZaw632+XrD8Bor2oQ==
X-Received: by 2002:a05:6820:1f11:b0:65f:cda0:ed8f with SMTP id
 006d021491bc7-662f20603e8mr3599084eaf.35.1769637258979; 
 Wed, 28 Jan 2026 13:54:18 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-409571ae8f5sm2570113fac.9.2026.01.28.13.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 13:54:18 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>
In-Reply-To: <BESP194MB2805AC7C1861BF2283BA065FDA88A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB2805AC7C1861BF2283BA065FDA88A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] tools: Handle realloc failure in strlist_add
Message-Id: <176963725837.1779019.9200460876498498769.b4-ty@konsulko.com>
Date: Wed, 28 Jan 2026 15:54:18 -0600
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

On Mon, 19 Jan 2026 15:49:06 +0100, Francois Berder wrote:

> If realloc fails, list->strings was set to NULL and
> it would create a leak. This commit ensures that if we cannot
> add a string to the list, the list stays in a good state.
> 
> 

Applied to u-boot/master, thanks!

[1/1] tools: Handle realloc failure in strlist_add
      commit: 3a53a03f50118e329a0f38bd28ea5f7d8e22147a
-- 
Tom


