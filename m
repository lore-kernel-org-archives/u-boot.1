Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F6B10A1E63
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 18:31:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 221BE81E18;
	Thu, 26 Mar 2026 19:31:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rVRj4o5s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 590D983EB3; Thu, 26 Mar 2026 19:31:17 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F57480517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 19:31:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d7ebe11bffso1011091a34.0
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774549874; x=1775154674; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QeJLREgq3+c39WL9HmmLvuF45Qelr1d+pKaOfC68wbI=;
 b=rVRj4o5skefP03we2ZI8EcWXJrjd0J5akxIaOBXpkED04/n9pZw+poGxsDFU9FHyVH
 5s+LHQJGJzIZCXzUZ3X3CfEjyfOD29cqHlrm3afQEUa7QIuD+hzN3CgHkxjRT35oq00C
 6mRZrXf/VGMLvzj5liBjR9Pz5LSn3T9JlYdi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774549874; x=1775154674;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QeJLREgq3+c39WL9HmmLvuF45Qelr1d+pKaOfC68wbI=;
 b=F/VN2jERIKwb9pBA7Y8mw8iqirpKFdxKBqIvaqjIiN07cYiXeQ8PuuHtxy7UMfEpSJ
 GSlgndmE9Og1H7AchlxSzPZu2ZRq/ETx80+sAjqsouWnOQ1WNtl+qbyecUOw0CCAPPXe
 B8RYKjnxnXzw4cGrimnm1BncY6k2egVJGdwmbAkJLIMz+eHC44Ss8OB6Bo1gf9melOlJ
 yXubfLfoAdZi84eIo0B5Q560z7ING9pbf6DGUXIzkxPwXKixEmksKdrrSJhBVz6P1OVb
 PTqTXIurwsNTfUD3pc2AnB9m4CdGCaJyqge5oAw3a8pUBxes/EYFBlhFCTf4+gzuc6L9
 D/Wg==
X-Gm-Message-State: AOJu0YyY7oReNw9fmzweoayFlZsru95oPzmbh9SHCmC/mJOpF8Plmu8/
 wnkOzYe1L7nSHQlmcIAIDwaMs9Dg6+i6/IiP8sjHUI+XhMn71Qj4ghJYInZ7QweylhbsxX2ABcZ
 JgAPktZ8=
X-Gm-Gg: ATEYQzxygo3E6xEtByEmm0YaJi3bmVYQYN4DxTDCx2q4U55UTKrVM/zFvDq4/opQXIH
 +sAeie6iXUq0VVzRThnZNfXm3qdlSpANpU7zyzBvEQWQFny9Quo+zcr5bRxO6hVwz5W0LiFh0+i
 +H9aYZbCa5cp8Zrk2zzAo6OuRIcFc2hk7dQEYp1FLdDGKDD+U2TI1Ra1bDahMLVjtCZ1+xFcnX/
 P+LtHlDesKc7HD9H69rzFDK5IdPGtxwabu6P3JbVL8mwW5+hK4o75v57CrSOAAHBOG0Wu7qnWqk
 gmIi5PdAk+5c/e1JoFZd64887JHBGb7Re4rJGbkzq/Sr7OrFrcNtvSPasQpp07fFic4ArvbZ9P6
 lcbPGRqrR4QUBdPcQh26zTepAQaaRkJ9rA3aiyd6InlTXwwMm4gYgVOfem7GOaWEQ+dSYL68UPo
 0vtjqMcjlZIr5z49ZqcID2JwCzr1hUMuUyaX622f/i9XulJWv5F4rNrDUGF8XDJVug6zkdm8xZO
 6Rdhwg4NafNKDry2NhleUWr4Y+3qoRP6hVIlzny/wf37og=
X-Received: by 2002:a05:6820:985:b0:67b:a8c3:6cae with SMTP id
 006d021491bc7-67dff421c4dmr4811019eaf.24.1774549873607; 
 Thu, 26 Mar 2026 11:31:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41cc7ad6c42sm2685784fac.10.2026.03.26.11.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:31:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: kory.maincent@bootlin.com
In-Reply-To: <20260326082346.1569343-1-ilias.apalodimas@linaro.org>
References: <20260326082346.1569343-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for fwu-next-26032026
Message-Id: <177454987287.3767000.16213021690563510493.b4-ty@konsulko.com>
Date: Thu, 26 Mar 2026 12:31:12 -0600
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

On Thu, 26 Mar 2026 10:23:46 +0200, Ilias Apalodimas wrote:

> Kory added a userspace tool to modify the fwu metadata from linux userspace.
> Although this was originally designed to work with UEFI, there are uses cases
> where people use it, but boot without EFI.
> 
> The following changes since commit 8813d74163e4d84dbd4fb30d9639f01c0acb6d39:
> 
>   Merge patch series "test/py: gpio: cleanups and improvement" (2026-03-25 14:38:28 -0600)
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


