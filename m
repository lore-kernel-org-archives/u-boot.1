Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B228BF3ED4F
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 14:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DA5D84154;
	Sat, 11 Apr 2026 16:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aaNm9ulF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5574584181; Sat, 11 Apr 2026 16:56:50 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 612CC84118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 16:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b9825ba7f9dso438723166b.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 07:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775919408; cv=none;
 d=google.com; s=arc-20240605;
 b=gqb24HMF6HEdlcA0T4T8ZGIv5GtEmY6jGW5a8WHpRsvnpl+nXyiAnWmgKoR5NJVONd
 gwh3tY+iBJ8WY61R6tWRHlTPM+Blq60N7aUUjWsnMqtUNVWMa4Ty0zgh3kNbKcw5r91h
 xpldRN6tW+1L9WFSzlmVTQyE+cKIov+U6fsv7qIzorvWad/t1I8HBkqdq8pK2MMqnPOx
 b3TxnuIkx401kvP6sILIg6ToVtuXk8sK6LMIT1NAbKWyThXWdVCLvEMBDRdciNFfWiH7
 5NJ+/vMy01+YmGERxDyYnwRWp64zTcl6YPo49skYGvl07zJGmu41/hzNy+O3sTiZLFBX
 wg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xR/RHJW2NThfAW/aI5Xof4rSS06S1hIUFqBBxu101j4=;
 fh=pb1V3rC/YOD1axA7yiOFKLmIQEYkcRc0AUeTYO1Qr4A=;
 b=J1QzUiayHjLjQtuoF6JFRzN+eo4Grr+GAYz96TMTz94r080Gnf4cAL5tMD8StE+mRU
 2V2C95wzRhZEbI5l7ZBixfZBWJ1LyCvl4w0ch6QwGRWs/jPf34XRORfBZGpa7cqvPV2v
 SNqQ/5UszGKvYVNJIdzTqIl9hZRivbP/c3J2rIjlEzc4YGQ7NMRF3EWgdmKxBbAryCdV
 p6wawjepOH6ZyYi6aFa/iuubU0AmXmciJkBXscO31SFUu7r4iuJlq/2J1NB8XCj05EPS
 CWpgSlfcY+4Rgj7CjzRX2DaXzsTUlbYdFwfdKnt1V3EDlI8FHXi8NwkyhKOfaBdYRhPA
 jOGQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775919408; x=1776524208; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xR/RHJW2NThfAW/aI5Xof4rSS06S1hIUFqBBxu101j4=;
 b=aaNm9ulF++nVUhwd//8FuqqYhHh6bdo62zZ4YqoXRKtL0bepl64tNK/oWD1oFeXaQE
 BmVDHn0fccVI5EBgDFGbQ2d8ckLag83Pgi5/6lHldxvUMTJ044UljF9oZbEbNh8tUnZT
 mO8L5S1R1nqraUb9pCfea3BHA9bI/dWGLvXBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775919408; x=1776524208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xR/RHJW2NThfAW/aI5Xof4rSS06S1hIUFqBBxu101j4=;
 b=Ab2imTgOjXE45rfgVHPESaGZ7AF0OWs6yHJo4zRt3UcCTZ+/tkHjXEOH2boML7QOA8
 PDzGQ2E9ZysR3B08pXx+b1qeQNLzYA6faPWK09Lk0x7/xCMbYqt1V7o1sPsxOU/L9cYQ
 e8W91SnNnuFD3sYtf9J4MwyZp/p6FF05wy1Lumy3UxnHjpvnpdIB2Pn3CC6ZJ19o0uii
 E13QMcD+Ps9CwtGaspGMalxAi2HMne24NvEf/ZggMb5S1NToHJPAog62m8NNoRpP/ptV
 cJPzmTuM1rrXT/mZV4XDaKPyh+lL6cn9q8VzQIylcCbGtb3hzVHl23S3ZHVRwWpbieyH
 aEaw==
X-Gm-Message-State: AOJu0YxDjzFs/PN30anPydQYJ8uVN4Y1wTcJY6/708dVYQO4nYFqPfJX
 o2OVm/ohAKgxz+yg/7C9H6h+uf9wFKr8cv6JS1KLsEsGT9HYaYqXzqFVqLut9iug7cNh2SV7EvP
 ULY/ws1+gBZYjHQULi1HCilbC1ioCnjmatDWDmruz
X-Gm-Gg: AeBDies7hNi1FRjcxxvnJqOta6dZ3UhTfx4VkVaJMOMKwLM0yWBoNS2V1zbOhTiT6EF
 iVzgFGet/8HOXJHTqN/AdSWSI0uyDpAGCSpzlMNvoit5e9EEVCKHKYTAZnnhuNUo7rVoJCt1djO
 CpUgomKFAgpDLrtbsqae5ZQyJ1OsQETDh8d9SNrxJPWixXfTZ3UHHzMlLzm01/wyES30VQWtoFI
 HqYfdxX5sy5kU1r7qFpsoiSuoofDHNJUn72RjUbmXoGL/fS/YNpFBQ1pn+n+zqq/OFZJZ1xN5QD
 /z+kYQ==
X-Received: by 2002:a17:907:26cb:b0:b9c:617b:4a36 with SMTP id
 a640c23a62f3a-b9d46227ffamr596838366b.21.1775919407635; Sat, 11 Apr 2026
 07:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260409133303.31875-1-ansuelsmth@gmail.com>
In-Reply-To: <20260409133303.31875-1-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 08:56:32 -0600
X-Gm-Features: AQROBzCob8eL_DgNQfdRzLdw7T3yuSaN47yDPpNuYj0a-3D1vzG_cXwbgEX8dBE
Message-ID: <CAFLszTi9tTgRYrfv3KYFFv9F9u8vpecoks0DomRnxioN19hsxg@mail.gmail.com>
Subject: Re: [v6,0/6] misc: fs_loader: reorg and split to FS and FW loader +
 FIP loader
To: ansuelsmth@gmail.com
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Christian,

On 2026-04-09T13:32:56, Christian Marangi <ansuelsmth@gmail.com> wrote:

> Rework the FS loader to permit reading firmware from container that
> are not exactly a readable filesystem.

The overall design looks reasonable. Splitting the generic firmware
loader infrastructure from the filesystem-specific code makes sense,
and the new FIP loader is a sensible addition for ARM platforms.

> Then the FIP loader as a basic parser of FIP.

Neither the existing FS loader nor the new FIP loader have any tests.
Since you are adding new API entry points like
get_fw_loader_from_node() please can you add a simple dm_test for the
firmware loader uclass. Even a basic sandbox test exercising the ops
callbacks would help catch regressions.

Regards,
Simon
