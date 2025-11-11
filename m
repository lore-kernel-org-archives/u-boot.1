Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5ACCCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 03:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0B1283AB4;
	Tue, 11 Nov 2025 04:51:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WZK1SSol";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 661A283ABA; Tue, 11 Nov 2025 04:51:48 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3780E83A98
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 04:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-3d18422565eso2396539fac.1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 19:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762833105; x=1763437905; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HBsuvrXVreNID36MLzb2D6wIVGdPL0Pa1Qu5dcnNEi4=;
 b=WZK1SSolf5IwpjT412p1Ezn3ZRzQBPNDyNRGcp4TWuJlYx7GlXDN5EAtdTCjmIQ+kW
 Oh4FLghaAHxvZaqAQzj1iFwAcKPKArly/21ShzMYpsgFNjjFz52y9A1mtwpse4CG7Ivf
 NWonjEKcRBuxUWzg2cOR/mwDLKYPkvUtuku7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762833105; x=1763437905;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HBsuvrXVreNID36MLzb2D6wIVGdPL0Pa1Qu5dcnNEi4=;
 b=hpVV1aZuno599wRLZDCp4aB+kJLdqeEu/QqWZNq3BjlJLIwWW3VholcbjrlyDyZ/bm
 InkZ1aNRNyuXhNFgKjKJ/qxrB+kCZABxBWm+NbjvCzUD9ymOkY4gmNQEXqn5XcSj9bQ7
 /1N+K7Zmz7NNOszAxCf/XfPfNp2UfpX8a7AKy9r8IQbk7dpo5Dz++HMZ27GZzvCzO76v
 Lp1/6NYP/irLNw5boP67SGjFfrV4HFYu53+isIBF7bvGVabbLTShMtsu6cycpqGRvsma
 xdX+P3R6XJJqd+seGvlZaT9K4BZJ5lMwWgrleuRQKyO0dMKRO6hOH+TvChpjmgZX+Grh
 Hq3g==
X-Gm-Message-State: AOJu0YwseVjJNfv+JIrCKmD8fnwLPycDcwcFtEC/OpqXVheSTLyU/TTg
 /xaDO6mbQ3GZbxFg/8fg5qpnwDO9pQ3H8ZkWv+QJjUPI67zqDcONEh4aC0/3EwW4kP/D2lTjosX
 g/1/IgxUw8w==
X-Gm-Gg: ASbGncua+VrDYXPOout6pF7R8GBKm+OiFe7igNiIUgNxbl9OatymAFBRq2sQRqxYoW8
 nMp79h5f2XH5t9moZ/6lGyZQCAgbYRgMFtzx3F1ApISYifVk8tQHtO1Cr0iw0VidwlO1HzdAmxU
 d+7OvdM1fSeTPsPU+XSMp3b5NRycuVJsNd99itKBc5+ovscxlAX0sjL/XLq2F+OxmcgSLdsUxi5
 iKTF+tXLrtCaf4B0QJUuuKYgsRwckozq8Ryn/ND5Z2m874cvn5UlNCzwMO/+XPXAczF3YxytevJ
 uyXPNRMg2FoBMEN+OBt/73dEb42/KEZWXYJt6qMSzLcE6NwiRlC0yODFz2Kl96JWbdwqQrjR88C
 EF731KpJliuXtJbjEdJhskVT5fB/+qaAP2Nz6GtJzrPLIsJZnckPpOhrdRA1JqaWtRVP+GZtJlE
 7tj/82yvsNo8XFSjHmWHVC43DU4hdTDvKflt1t0M0ma+b6yM8/
X-Google-Smtp-Source: AGHT+IEQme8jDwiziQBtiPj1Ij/L0hHfdcRYki9cGiSXhQtDugbtfdHAeSHmmO5mXWnHEUJsZwxlSw==
X-Received: by 2002:a05:6871:286:b0:3d4:cea7:62b5 with SMTP id
 586e51a60fabf-3e7c2950ef5mr5553674fac.48.1762833104871; 
 Mon, 10 Nov 2025 19:51:44 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0f0a6dasm6559073a34.5.2025.11.10.19.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 19:51:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251101153201.830803-1-trini@konsulko.com>
References: <20251101153201.830803-1-trini@konsulko.com>
Subject: Re: [PATCH] CI: Move to Ubuntu 24.04 'Noble' as the base
Message-Id: <176283310376.3195048.9763662600156586743.b4-ty@konsulko.com>
Date: Mon, 10 Nov 2025 21:51:43 -0600
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

On Sat, 01 Nov 2025 09:32:01 -0600, Tom Rini wrote:

> The changes here are that we need to ensure python setuptools are
> in our build virtual environments as they will no longer come in via
> python even in a virtual environment. As part of this ensure setuptools
> is in our cache and also include pytest-azurepipelines as we should have
> been doing. Next, we move away from using apt-key directly and move that
> stanza towards the rest of the apt work.  This also lets us drop
> directly installing gnupg2. These steps are not strictly required for
> 24.04 but will be for later releases and are valid now. Finally, we drop
> the unused PTYHONPATH ENV line.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] CI: Move to Ubuntu 24.04 'Noble' as the base
      commit: 9420160a0d145be2e4b53742612fdf4fb43d11af
-- 
Tom


