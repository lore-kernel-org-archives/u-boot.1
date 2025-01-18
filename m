Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01A2C02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 16:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 983C4807B4;
	Sat, 18 Jan 2025 17:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QNmMES7e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 803658078B; Sat, 18 Jan 2025 17:43:29 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 124EB8076E
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 17:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b6f1be1daeso312117985a.0
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 08:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737218606; x=1737823406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vFPW3QVwGn30DwoJjbn21gbMutXoPqrs6xXLMdoq5CI=;
 b=QNmMES7ekVw4lB/TxicUBZpNXlCNjvHwoIpPXWhzaGlEKTPo5lqK+cFE65rO9AtZIR
 EUl/ANirOUBp6n+LR3bAEW7i1HtucIThiGuRUaqEoUAhEgiwZp1eugsuEXggqYzlUdQJ
 N/KZ/wMLZ9vZhguqf+oWzVXecURXzUNfKQuvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737218606; x=1737823406;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vFPW3QVwGn30DwoJjbn21gbMutXoPqrs6xXLMdoq5CI=;
 b=kvt/gP7mEO9gBQIxqRW9+zbFwM46TxarwgcZAhKBEQf+UWkFX5EyANb+sSb82uDrkx
 iboVrUVWy1fho65VYSJY5k83Zr3HHlvhqg1+81HtDUtBmnZsLEgmv6QIqnct5ldqQRPE
 xBvbYcjAv7kjWEr5+cIAlz86DVzT9ptp3ZRimaBBSY1aooTBXFSiG+SG7+pDErjC92ig
 V3zxk6/evBsXWNNwd+lWSPuTDH9MO1UVhEeila6wLFyxXyrHTaBbEDwo0jk+zzXr11NC
 kh6P56oSwvuO392yn/XTW7PuRepiOjvB1mHvanckdY5MNhHwxKydhOcfYHsR5vKLJTvd
 ftnQ==
X-Gm-Message-State: AOJu0Yz6L4boRSpph3guhhCg9RAnc5m1MTr5FeymkFoQgnaDTcRXn4jh
 OMUlB8Tug5aq3TV7rXg4vgQplF75L7/QEdNb2/TkkhUk4omcEMDsyVFMyTMGp74=
X-Gm-Gg: ASbGncvwsSU1mVLbtZA5rc4h9pFfOsTFzsNh5SZQdsxVEwR+4DYvqg/hhLBrI6jXKvG
 fRjTSVrI6NcJC873M/bIxpBHwZu+5Fow7YRyW/mAszWKq0V6s4Jt1EJSXSALqAJJ/ItlUUOATBD
 IEMt2no4ZX3+tL6LKtObBZs/ukUD3AcXt6F6MECuBYR9gbQW2guSLEVlkiakQ1wZ/Ofy54amMcR
 boRsUsaysmyJRwOimii9QRZmQme0oRBXY6pFZGdlt5t1+7ZJ3+ScgNdh9QJQ2M+bg==
X-Google-Smtp-Source: AGHT+IFUUAEfbLA8z30f8oeZix06DkwnCRtfFmBXLBm5r5v7DFyOTgHI4utcE7yq1M2ivZrns1KuRQ==
X-Received: by 2002:a05:620a:1902:b0:7b1:51df:117f with SMTP id
 af79cd13be357-7be6325c411mr1328790885a.56.1737218605997; 
 Sat, 18 Jan 2025 08:43:25 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614f5b3bsm241061585a.115.2025.01.18.08.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 08:43:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, nvbolhuis@gmail.com
In-Reply-To: <20241224004925.468050-1-nvbolhuis@gmail.com>
References: <20241224004925.468050-1-nvbolhuis@gmail.com>
Subject: Re: [PATCH] squashfs: Fix sqfs_inode_size() for xattr related
 SQFS_LSYMLINK_TYPE
Message-Id: <173721860427.2563206.7584617950312920863.b4-ty@konsulko.com>
Date: Sat, 18 Jan 2025 10:43:24 -0600
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

On Tue, 24 Dec 2024 01:49:04 +0100, nvbolhuis@gmail.com wrote:

> A squashfs filesystem with extended attributes (xattrs) may have
> inodes of type SQFS_LSYMLINK_TYPE. This might cause u-boot to fail to
> handle the filesystem since it assumes a SYMLINK_TYPE and LSYMLINK_TYPE
> inode are the same size. This is wrong, see:
> https://github.com/plougher/squashfs-tools/blob/master/squashfs-tools/read_fs.c#L421
> 
> Using the mksquashfs '-no-xattrs' argument is probably best, but the
> mksquashfs '-xattrs' argument is the default.
> This patch fixes squashfs image handling by making sure parsing the
> uncompressed inode_table (with sqfs_find_inode) succeeeds. The only change
> needed is correctly determining the size of a SQFS_LSYMLINK_TYPE inode.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


