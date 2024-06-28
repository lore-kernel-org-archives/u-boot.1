Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3C6C30658
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 19:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 087FD885D7;
	Fri, 28 Jun 2024 21:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XDdwFyKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DEC2885CC; Fri, 28 Jun 2024 21:49:31 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 351FA88168
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 21:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3d63332595cso341382b6e.3
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 12:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719604168; x=1720208968; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tnU/wpo+CTk7TlX1X7oRr3+ubP/Z6xnbR/bzwJcprKA=;
 b=XDdwFyKS4w/C/6tA0e2PXRUn4Nh8axf/naVDmZMD7tE+jL0rQGQpspcgXv3IbcZmDJ
 i4pLLZHZQpXbPv+VGoGIoSJERNhmr6Q51NAseFoxwKT73C4plPY1z6rArqcj/4HF7Jo3
 s+n0AZ4DzLTET4yi6FnHiDEjGbmEh2ERi9Prw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719604168; x=1720208968;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnU/wpo+CTk7TlX1X7oRr3+ubP/Z6xnbR/bzwJcprKA=;
 b=WObn9yXGEFqfhI1fviD3ucYGKbqc2hOwAkhl8OuYwT39C28l9nYVEWEEFCwi3LymQx
 dBCsvelzgYpbS/3CzAazYTUF95JSnI5PTzdF3OE5zbDUnsGXwGTnjqehSkOeMgZRkBoA
 w7VsvUg1UQuxI0jwf2QTHuWqZV4NFzKp8qoCklCuL4zP2fEU+fRoMWUER9emiqbfC+XN
 2UdQtaN1EO3SrT6z89GHccWSyKiIVbERkhhv7zzHx9ZyrdBW/c7GP25F1TY8D0GTiy0S
 vt6k0wGqPdC4ccIQQ5VPNWYCxIchiZqtPc8pRl8cN5b5/GYxN1571wLEf/y5lWg30u6H
 ZxFA==
X-Gm-Message-State: AOJu0YzjOw7Fp++SnrbUfwzm9H8C7MrAse6VUG0V8WPfDOuuYsxGlHLQ
 BOOrf3iRgm9tTzSkK7mfRT705crkSTqKyPwWo9weCYpu8cMNE3VjKcEdlMZgKyo=
X-Google-Smtp-Source: AGHT+IGtyVi9x7bMQN+HWJFbl+FolrY5Tseim8OaoalrIJ0xSmV4bjcezWKfETaUmEetGgP+kYNY6g==
X-Received: by 2002:a05:6808:3021:b0:3d5:5cd4:5a1e with SMTP id
 5614622812f47-3d55cd45b05mr12923350b6e.1.1719604167500; 
 Fri, 28 Jun 2024 12:49:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62f9e5fd5sm414579b6e.22.2024.06.28.12.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 12:49:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Alex Shumsky <alexthreed@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>, 
 linux-btrfs@vger.kernel.org
In-Reply-To: <20240618214138.3212175-1-alexthreed@gmail.com>
References: <20240618214138.3212175-1-alexthreed@gmail.com>
Subject: Re: [PATCH v2] fs: btrfs: fix out of bounds write
Message-Id: <171960416664.3614069.18406891022167257775.b4-ty@konsulko.com>
Date: Fri, 28 Jun 2024 13:49:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 19 Jun 2024 00:41:38 +0300, Alex Shumsky wrote:

> Fix btrfs_read/read_and_truncate_page write out of bounds of destination
> buffer. Old behavior break bootstd malloc'd buffers of exact file size.
> Previously this OOB write have not been noticed because distroboot usually
> read files into huge static memory areas.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


