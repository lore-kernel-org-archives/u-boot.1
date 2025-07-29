Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F67C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 00:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19E0B82E52;
	Tue, 29 Jul 2025 02:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EcT9iOFc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0E2B83020; Tue, 29 Jul 2025 02:20:44 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62C882D21
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 02:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-615a256240bso2267851eaf.3
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 17:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753748440; x=1754353240; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vDeTS3F7bgxM7mmmIZOVMrxk7d0yCAlXcTQmkWZTknU=;
 b=EcT9iOFcoSRNdy5EXqOfqF0ypuZX+7FCVUGCYJdWJyX+WxTEtMwBo/cZBOZhMUaxie
 hatx8/T8ugySbRZPbFgwy2qVpLFxkPZlwXkZZRYRHk9EQ4Nn4FEp1BDO5A8ftQKtKwA8
 yIyy++FPlzzbr6IxIZY1yvnVLa4gMOggaabqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753748440; x=1754353240;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vDeTS3F7bgxM7mmmIZOVMrxk7d0yCAlXcTQmkWZTknU=;
 b=LyyYrOZqrLuzRM/CvCqhsfcn0yXAsXGm/pWGxGlCo+Gybz8KHzVYkThrWAfT8xzspR
 1cWbC4SzYDwL8Mkp4U7wcxrdLLiJf/V8mlOOqGygnF7zsdjRDm+YBb8DVnD85McMNGRM
 A5XRG6S2VcrVoLdOpRsGwjkby3L3F6U0yqHR8DdVjYNOTHZyHWCi8BlZQ9AowyAkB6Rl
 BKsHHuDDLpKNsQ8DkQ+h7HgvPQl32ty6556q19yMBqzlFxmAsJaIJPeZM5hwpviE+ZHC
 luiQp4LDrbo7nqxKT8ET1PzKR3ZuPYotzhDD1FFWstVLkZws01t/yuGTq8tCp++wNh0r
 d9Aw==
X-Gm-Message-State: AOJu0YwypRRwk1Cm3q8lC4ybUZzk8SEuNqTKaCBCfmVgpMXcVbz/ual2
 QMBEQlbzRXtNhG6UtSgdBGokLsThlKNx6QkLh8KdP1SuI8Z2Aw+ooMz2plUKVgh6REmpMw8e+IP
 ZSUD8fTg=
X-Gm-Gg: ASbGncvHUra+fJHeY6Woebv6m57HzYmuVq9UcCRFTVyE9fNhKGyUaoq1lm2vtFnuETm
 QDKVBI4oFdTJcpIgqMh8DRp05SrAw9xdX6fTvxgZANLtqgZvz4HfUrrjha8rujWZUtQ6YrAq/6F
 VKNxzNZmbLhWOexcHceNXYtBaK+tcsBVuWHEiKMpn+qMi1Js/HjW4AyDL4xZXFzJwNpqp+FYneG
 mOHXj60M9ZfIO86KiwjoeoDMADEOHQ4kbWrxNft6Ay/mIeizSAXG2jnKERvB25CMtMqdsyEhPI3
 RSs264FWfAGx/EZMGtZr2IIzrsaa2Bzdxe/5QPdv5kl5b6CXKgTBKBBMRPj6Eh10WZZiLbuB2O7
 Mu9k8Gx/BqwAMNhR0hgUzYge+YStmZt5K/eUK0d7Wg8wls9k5tqXkpAM=
X-Google-Smtp-Source: AGHT+IHq6rRRLzOYts6cvMIry1uHKboR5SAwQby5BcDJHzE+1vg8FN0kHPUuO4+7grOato7/I0vzrg==
X-Received: by 2002:a05:6871:eb0b:b0:2ef:3e4f:de9d with SMTP id
 586e51a60fabf-30701d83b6fmr7344460fac.17.1753748440458; 
 Mon, 28 Jul 2025 17:20:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30713239f12sm1907491fac.11.2025.07.28.17.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 17:20:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
In-Reply-To: <20250718085634.13542-1-ravi@prevas.dk>
References: <20250718085634.13542-1-ravi@prevas.dk>
Subject: Re: [PATCH] .gitignore: don't ignore .gitattributes files
Message-Id: <175374843962.1767077.9413489831358463728.b4-ty@konsulko.com>
Date: Mon, 28 Jul 2025 18:20:39 -0600
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

On Fri, 18 Jul 2025 10:56:34 +0200, Rasmus Villemoes wrote:

> In a private fork, it's not unreasonable to commit various binary
> files associated to one's project, and thus put a suitable
> .gitattributes file next to it to force git to treat that file as
> binary. In my case, I have a .xslx spreadsheet used for computing
> suitable RAM timing tables, which I wanted to put in
> board/<vendor>/<project>. Git duly warned me that it would do LF/CRLF
> mangling, so I also added a .gitattributes file next to it with
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] .gitignore: don't ignore .gitattributes files
      commit: 51013e7bfb3697f2ac1dd82843a67ebd76925450
-- 
Tom


