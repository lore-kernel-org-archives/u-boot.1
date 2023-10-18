Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C435CCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 12:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88EDC86F72;
	Wed, 18 Oct 2023 14:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VtrEgbV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAE9480EEB; Wed, 18 Oct 2023 14:31:11 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C1486F8D
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 14:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d9a7a3e17d1so7911714276.2
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697632268; x=1698237068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTwhmNqMRKEzegnpA9G7MNpABd1t8puZJmAxA4sFt6w=;
 b=VtrEgbV0iIGrxIvwsINWCDq/s3ANlTVeRaOjS71POLUmOFG8uL2WpoG58n2pbcQKG0
 gZMV6+lES+Mp+GRM+/fQs0PfpxvT9jzT5f41e/mwqsTy1uBfaWis4ZDvKycX5uPNkcxH
 e0DYOPkO7f175VWcR8bNm4jufLtdvhWRq+iSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697632268; x=1698237068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iTwhmNqMRKEzegnpA9G7MNpABd1t8puZJmAxA4sFt6w=;
 b=iiy9zSAeK+Wug9jiUfgm1AjpovdisLt62vRdCLfOfH11e45OTTIOF0IYyRBerMB1A+
 /0bdz0Zd484eJbnmbRfH+WqdTzlYS7G+vVwKliKNuAqgsIdsRdZDB+/92O7DcfeWe9vv
 o9cE8S5pWBeUclc36pwybn6aqlGC3rv6qJioboC9twcWgPEeYdmoD6bZhXQbx1RWH/yf
 /y90W3YQZO3Qu3sg/vbLOkR5pYmEEa9ncy6vAQjzSUfrHadrwjpz423j8h3oPON1tjmp
 oszZCGzIsWHk6boHoVHtrcYaUJ+x56vByR7Ti57ewpvfqVEdWhWZdB5jim0SaOfOu8wF
 vZsg==
X-Gm-Message-State: AOJu0Yza5Oh6e6LuZFps4EC+6smr+jZih+ZXZ21tZj2l+q4AJ2zx7K40
 lTK3xwavd33Zp1D9aiJhhHzLFFraoNgkfZ4GexFT3w==
X-Google-Smtp-Source: AGHT+IG5xHm/sSIhk7qFKwmXC9LwbkH67HNQYjomEy+mfn5QyiC2rfeu3RjiI2F+FGHRfTtPjwb8UA==
X-Received: by 2002:a25:dbd4:0:b0:d9c:7d34:1d5e with SMTP id
 g203-20020a25dbd4000000b00d9c7d341d5emr1747128ybf.39.1697632267776; 
 Wed, 18 Oct 2023 05:31:07 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 a36-20020a25ae24000000b00babcd913630sm1266904ybj.3.2023.10.18.05.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 05:31:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>,
	Mikhail Ilin <ilin.mikhail.ol@gmail.com>
Subject: Re: [PATCH] Revert "fs: ext4: check the minimal partition size to
 mount"
Date: Wed, 18 Oct 2023 08:31:05 -0400
Message-Id: <169763217637.3660183.13019604012245649281.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930204246.515254-1-seanga2@gmail.com>
References: <20230930204246.515254-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Sat, 30 Sep 2023 16:42:46 -0400, Sean Anderson wrote:

> This check breaks small partitions (under 1024 blocks) because part_length
> is in units of part.blksz and not bytes. Given the purpose of this
> function, we really want to make sure the partition is SUPERBLOCK_START +
> SUPERBLOCK_SIZE (2048) bytes so we can call ext4_read_superblock without
> error.
> 
> The obvious solution is to convert callers from things like
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom

