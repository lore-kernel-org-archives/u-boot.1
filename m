Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36179D11193
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 19:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EA3F83A7A;
	Wed, 26 Nov 2025 20:10:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kEGJY5SM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BBE683A94; Wed, 26 Nov 2025 20:10:30 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 123FE839E4
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 20:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6574d7e451dso49446eaf.0
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 11:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764184227; x=1764789027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uTk/EFXmPpVhT9eSWj6v3inBDErcETniQgKSHis4EtM=;
 b=kEGJY5SMjUZPxn/5B+5Kb7sfsHMcBMOxOf3Fz/kFiroDL9TExPzFoEV9POCCgcJlNk
 NaQJ4Sjm0gowT7c1PSWd7iu6a6JPbwDUk/pmS+oScv60a+jmnZE1DC4FSkB7pK9vmfvL
 G+UG1h839MrQ7bjGvdOfRNE+9oZ+jzae2D95k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764184227; x=1764789027;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uTk/EFXmPpVhT9eSWj6v3inBDErcETniQgKSHis4EtM=;
 b=NB04tay2oYRACdEeGkH/uIt7cUc9lgKpBnOq2NIWHAjSgo4DnR0SeexetrlZyyRrq4
 uAXabNkm5llGLuMRUU8YfHnjjpftXLMwErRxy2pknOibW6bAdFLCqx8xio3LTty89+Xw
 BPOLILDG11iDVUB86MRSP70tynRCE+R2WlCqS85ALUcqN+A8gN0aslskpYRpZdTDbrSP
 zn57L7I4IHGisNkeDaeD/vDXIYv492OSu+Tsr9nv26hC4M3jnzBBfw55e465wfG2eoUF
 RdHDRKd5i5wt788l7E7dwDwVKVccU0uV2VS5WPcvO982c+v9oedlKbyJllJjtJpENBWd
 OLmg==
X-Gm-Message-State: AOJu0YzRToWzQ9k9ur6Twc0fyGdDv+fdAVpdfTDf6gDPXiN2fIfGIw/Z
 By6+8B+fK3+QiENKV+76PAZm5CpyJE8bxDIc3Xlt/e0YW9d08gs+KkXiV0RqvZO5FqTu3CLQa8e
 yPuyI4qU=
X-Gm-Gg: ASbGncsm6RRhK5fdt5t7exnXmNyqSFZMachiAFNb4HYtNawFZ+soxGuLwAExasZIYAG
 v2K5ebM9kCrIWYVqravVEpK7Ra2Cq95nw/NSN5r5oIQqtYtb/AXj0aTV9gLR50DJ2vi4DvtA/Qw
 E3h7zLjLxV47AVNB8RIBktdDoAXzpGhOlqNj+St9P6Os+bUXvoPYmfNE2y6GTUSm/moe2WQzBxG
 loBJ3nJ+6fsTo9SrUVsCGGqpqy4vNFzRTE8rNzFpbHAcJv0f7UJVyWV4JIXUEE/z+zpUB3Uugf3
 XsNKj3Y+hV2hJHeUVpfCFmx/WIDhsjJrHXtLk0UQejcsaof86dx5EcXBCtWfzhtKT9btzMdxnCM
 Huebz8B0q1gjB5CCVox69/ns7o3q9/wT2cD7dzs2fiikaNZOw96u9J87z0MZcZEfAVCBzk7P2on
 GDrXyz5ut6I4/PiKcWmJIN1zRBn/lEe1gwRu60L1RLqnNM/gKI
X-Google-Smtp-Source: AGHT+IHX4iA8RvgNNnkRL8TmtrDu/CQ8qMzjdqanK/NeqdUnH2iZeYwul548ehDiop7wawJVBRAH5A==
X-Received: by 2002:a05:6820:989:b0:657:5ed8:c6ba with SMTP id
 006d021491bc7-65790a0915bmr7430922eaf.1.1764184226795; 
 Wed, 26 Nov 2025 11:10:26 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65782bacf02sm5227803eaf.15.2025.11.26.11.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 11:10:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251119143258.838466-1-trini@konsulko.com>
References: <20251119143258.838466-1-trini@konsulko.com>
Subject: Re: [PATCH for v2026.10] Docker: Update QEMU to 10.0.6
Message-Id: <176418422604.3800471.316721811218848122.b4-ty@konsulko.com>
Date: Wed, 26 Nov 2025 13:10:26 -0600
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

On Wed, 19 Nov 2025 08:32:58 -0600, Tom Rini wrote:

> The QEMU project has the 10.0.x series as an LTS release. While we are
> not doing an LTS ourselves, we can be confident in the changes between
> 10.0.2 and 10.0.6, so update ourselves.
> 
> 

Applied to u-boot/master, thanks!

[1/1] Docker: Update QEMU to 10.0.6
      commit: bd19527c755963de9c1d231fdacd112e54f33480
-- 
Tom


