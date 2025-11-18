Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E77CEE351
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 20:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B55B83984;
	Tue, 18 Nov 2025 21:32:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cvZZ4NfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 963F983700; Tue, 18 Nov 2025 21:32:24 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 788DA83957
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 21:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c52fa75cd3so4523505a34.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 12:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763497941; x=1764102741; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWSO8TXcrOpA4iZRbXVeotQ4MgrhlrUQpVu97qw98uc=;
 b=cvZZ4NfM9wBmfjhtlcwAD6awtd/kNw79gLLMreJbvT8Zmi1aRHK0aw7q1g3XF/MlLr
 7DbM/Yk4gCoYIo+kM4pcEJwXlsHJiSBQ2l4q6KIKDGeMmwheRE/lifdrcu3V/W87XzZQ
 rmjwJMvDbn5+pje6q864Xqg1qrvsuaEkx1NlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763497941; x=1764102741;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IWSO8TXcrOpA4iZRbXVeotQ4MgrhlrUQpVu97qw98uc=;
 b=JQI2ycJIaCC/nfLQ4T1y3ceYeEjaZ+Nc7ZjefP/S1qpV+NQ4ToRPZXwHbXaHHuwRto
 AbEOXpm+lwCxHOlDVtdSucDQdQdl06Ybqgiggzq15MpRZ7EoZjx4pbk2qmyorVfGkDu1
 ec9FGQTsHqenB2P83U4IZrUMy8EJVFmHv0nd4DhxWzswLHSHrEkXPmFqLr1uYmwp8L3x
 EedWNOZdtQgMhPshqyL5FBlCAxCJjPKwIvj6GexBHGJZgv7hOPzb5ytKLmSnQRYbje43
 tt0RRsIxd6Gz80u0bi8zKEv7Mkz/SLWbmJbvxfOgSJJ3D8p4VMhx7eoKGwoRMk8eiS1w
 riBw==
X-Gm-Message-State: AOJu0YzzXHhrDEiJc3yjFUst8rxbdcsM/jh4Qw3ZFkMB3WsBE9LAuWSz
 R/L1Q700UKMuJZhJZUHt7zyvU+sF8c39UmsDdieNCbRMHNTJyOA/nYuFe6zP/uPq51Eon5IyDOz
 SjFgI8WHNUg==
X-Gm-Gg: ASbGnctA7cut5kIDmSEif6LvhceKe0D+pYhe/hhyf9vFunCCk/N87cxFe4jqXM1qc/f
 wLWsfyhZ3tyS1L3CN7yx0aGYqSUx5ssawB5W3zfIrMmJRI0ZjZxveXUUl8etziGt6LzU3HkegJS
 8Z08knkb/WdOiLziFiavftsmxMubZ3JQ7+fBe5BEPAQiEmkcOU8gP0XJzXid1bw7ANNGxcBm17/
 Bv29MRQXxeOk9R8EMk0aXT5fWPo8Se+KeAT6ow1FQzJ1fOnuy9awsmTw5Vh4QHLXw08IccGf62o
 YkxsxxHoOvQbCFfzkmjeR4tSl7/rRwrmQQXDNKOnzkddLqvlvDcT/jsX81Ch1kLuC7JSYMPtRw/
 bVjX2Uta4LWysydSXcqnS3MYRcfWgTUH9dfDSZXby3sMrhAGXilFUGP+VR8SqaNYM+26R44a5Kp
 k6pUA0GpyZgaaHKPYnjGcFxnibMTS6TE9Xvh3ABEO9XS1afKqIkbL9UCadTn8=
X-Google-Smtp-Source: AGHT+IFeaed6i4A4IYt2gxuzRM/WIEeL2DZbxj6ehBuC5A0aDilo5fGe5bP5ku0EUtXXGlpq1pT+3A==
X-Received: by 2002:a05:6830:7185:b0:7c7:526:b1fd with SMTP id
 46e09a7af769-7c7443682b3mr10766180a34.11.1763497941239; 
 Tue, 18 Nov 2025 12:32:21 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a283c36sm7036097a34.3.2025.11.18.12.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 12:32:20 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251110205411.4075351-1-ravi@prevas.dk>
References: <20251110205411.4075351-1-ravi@prevas.dk>
Subject: Re: [PATCH v3 0/2] 'part name' subcommand and some robustification
Message-Id: <176349794044.618903.18005151836737620888.b4-ty@konsulko.com>
Date: Tue, 18 Nov 2025 14:32:20 -0600
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

On Mon, 10 Nov 2025 21:54:09 +0100, Rasmus Villemoes wrote:

> Implement a "part name" subcommand, mirroring the existing "part
> number" subcommand.
> 
> In the discussion for v1 of that, it came up that there's a bit of
> inconsistency in how much and what one can assume to be initialized in
> 'struct disk_partition' after a successful call of one of the
> get_info* family of functions. Patch 1/2 tries to consolidate
> that by making sure all ->get_info invocations go through a common
> helper that at least always initializes the string members.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] disk/part.c: ensure strings in struct disk_partition are valid after successful get_info
      commit: 3c2a9475334ae32997b3bce8d24b39c8ffa9fc67
[2/2] cmd/part.c: implement "part name" subcommand
      commit: 30890051ab23a0293f6404c9a49e86f33e45df66
-- 
Tom


