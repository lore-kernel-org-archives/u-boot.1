Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C0DCD6E57
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 18:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B78584855;
	Tue,  2 Jun 2026 20:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KQqXnhit";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9654B84868; Tue,  2 Jun 2026 20:30:57 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 726B484852
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 20:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e6cee520ccso1024602a34.1
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780425054; x=1781029854; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IF1NMu5SQz77R/WrxU46V9rBmqclDMUC2lUqlWXIPTI=;
 b=KQqXnhitgSyoKaDSyldu2al6zoQ9eZ+kknDFVLaQM8iwRnf2/bjUeVeVKYzqjpliKL
 53Z1jP6eFhZdTH8lVwAtysKkRbvR91XqX/L10A7Uftc+p+WSsBObkJc457+CZg6vxSbD
 +sZ4UxxZHQOLeAD4NKpRJUzdDa7hwsP0jlKfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780425054; x=1781029854;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IF1NMu5SQz77R/WrxU46V9rBmqclDMUC2lUqlWXIPTI=;
 b=S60VU0gx3bR5kG0YJkHtO181eI7D8Lh2vagJXULL8CWjb+UFqEsNKcdoIjjTVM7QtF
 zB61Ktr5kiMKrRZnIS9BAzDhVz19sHhMUOAvjS9fBeImjz19cGMM/6oXYji8kRY3EKQQ
 OiNT7gBvV7HpoDO5Gho8wOwUvJmdipRxyK1Swv620S6zqBnEE3jT8y+sCpGxWDnfXwcK
 yCO2ZHJe7Ppc/xSdHDcG7HSzGID9ZfbgiOzv8pF9+Ikk3hKpyIg9BSkBKV/wQF1CacGc
 aY9IsdmnK52GeBCW4rTQ9mv+SoqXPlL6Wg4F6cNY66YrLQGP470P3EU6KYO9MiH9cu6m
 yTKw==
X-Gm-Message-State: AOJu0Yx43Uq/heoYewgosyjG0D6OSLOhzpJ0Znkirv83v6od8hH0vh2q
 8mdvG5hOunA/ZTRjpjd70njzzfF9rO8mYtA8Z50Nx3HgVCuWfUpgyE8aNHWhx40XcKOoTBifQwm
 DUP6498Y=
X-Gm-Gg: Acq92OGbP52GDwJm7vztVsRQyOUeHqZb38WEdB8NbpshuUuRgi/Y7TQtzUtNl6lu32m
 2QwLTPbKHXEgIc/9iGH6DdOaX5qkojEZJLrCIWsMawazuRIdx1NPjn8JYE+Eo+AiNHqmDewczjU
 2ejDROFlFQ4TSmIuuvF0tdUC9k/sl1pTGcpV/H38uYkVYG+kbJ8TGjorxqFdqXB5XG1IUhdiJvW
 cOzlVC8wqYoCfR38+MumrVw53aj841RK6V0LXomG4bXYwVa84EilAQcw4tZ5nd8sNObnjyWCbrT
 kyLwD/gD5K6SFH96L/sY55ohitcxo/fMcocAMuGh2ZAtmQwgCtDxr31h6I0s19XhLHKAjxADVEj
 wV88KpqHNcrVz/TYqUOtYnzrTe4QzoZ5n56RgfcrzUX9aH+S9uDpTRC+ZHBRkML4cOpQoUfcbUi
 2l9j3HgfPHolWVJs8sHuq8mhit9Pmz0oozYPs7lmhkc410yYSW43pEqEU3BHBLfiLQn94PhkLQb
 SH9XVWQJ7OGpUpd+jhr0D0ReiTL3m98AFKsLKfiDvlDCJvTZ+/pNw4yv07dPcJ7IEvuAOE=
X-Received: by 2002:a05:6830:6ed2:b0:7de:c870:46d4 with SMTP id
 46e09a7af769-7e6d21a2e4fmr2286599a34.1.1780425054174; 
 Tue, 02 Jun 2026 11:30:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75ef0e4sm98658a34.12.2026.06.02.11.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 11:30:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260519162225.770071-1-trini@konsulko.com>
References: <20260514175457.4047707-1-trini@konsulko.com>
 <20260519162225.770071-1-trini@konsulko.com>
Subject: Re: [PATCH v2 0/3] Clean up bloblist initialization
Message-Id: <178042505351.1921005.18026596286118454079.b4-ty@konsulko.com>
Date: Tue, 02 Jun 2026 12:30:53 -0600
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

On Tue, 19 May 2026 10:20:53 -0600, Tom Rini wrote:

> hEY ALL,
> 
> I've been sitting on this series for a bit (as the patch dates imply),
> and I'm ready to move forward now with it.
> 
> This series does a few small but important cleanups to how we check for,
> and initialize a bloblist. The first thing is that the way things are
> done today, our HANDOFF code can only work with a fixed bloblist
> location, so express that requirement in Kconfig. Next, we demote the
> scary message about "Bloblist at ... not found" to a debug because we
> most often see that because the bloblist doesn't (and can't) exist yet.
> Finally, we remove bloblist_maybe_init and split this in to an exists
> and a real init. This results in practically no growth (between 8 bytes
> growth to 12 bytes saved, with some outliers saving much more thanks to
> knowing it's impossible to have been passed a bloblist yet). This also
> cleans up some of the code around checking for / knowing about a
> bloblist existing.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] bloblist / handoff: Make this depend on BLOBLIST_FIXED
      commit: 679eb25fb8fd75bc6877e8c03f264bf80f71a4b9
[2/3] bloblist: Demote not finding a bloblist to a debug
      commit: b4858d2afcf7fc819ed33643370a2b3ccf7055ac
[3/3] bloblist: Rework bloblist_init and bloblist_maybe_init
      commit: 5ab1600213608129ea63fc3046f46349515821d6
-- 
Tom


