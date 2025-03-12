Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7668CC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 16:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C4A6801BE;
	Wed, 12 Mar 2025 17:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="em78YMxT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA45680FB9; Wed, 12 Mar 2025 17:23:44 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DC36800B6
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 17:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6e86b92d3b0so500476d6.2
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 09:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741796621; x=1742401421; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jIQ11ZQn07I+iYdU3YvhQL5TO8HhtzQSlh2QoiuRfI=;
 b=em78YMxTondNbTpSgSteqzCRs9YHq9xXMRYe7qPARZRwM64TcfVlTTWD1/JCfkdLN8
 q5D6zR3FtLNHXF0B8oK02ONX9KxiuFoTNWrr8nkKpklaPW8pbh6+JgYxzVgu6+em36WV
 BbXWuv/QSx4xxfVFZeC1GMk4ouRn1zh35FH4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741796621; x=1742401421;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+jIQ11ZQn07I+iYdU3YvhQL5TO8HhtzQSlh2QoiuRfI=;
 b=udKP36je7Lo8jJ5eOtT/4xVeCGoYJ7a1GthbZz0b4+zde2QE3hMiqpAV/Y7YjCZ7++
 2nWW5uHqStOGKPCSoV/exbxO9b9RMiI/WTsjteBXur1i0W1/UX87obAs522r7miY1hEt
 +YfuY6k47eW7xXw56hA6QBhGiW9DGeJYtnRwy1yRSJb5PdNRi3YqHtnXNKyMp8gfxDlz
 A9C8ADG7Xkh2N1pq2QBOqk9aPhnw5xRQemu/XaiVeaKBSGkz8DjS4u3ujU7hF0DG15S9
 T58aYqo5vvu/fduy5X4OW31DoT+erPmhkbTG+ndoQqEbj0WWUHnHn7MuCuCFFGy1LE4V
 vlYg==
X-Gm-Message-State: AOJu0YxM/VrTyl+4N88OngYu3vWcvlDtI3+9dDUcOsOHJxPpMBNLgsyD
 Y0SqbfSWxJtrkIlm3iq2dm8zc2LTrErHuQN9m/ICLN2qF+w2d6Gy4wxB1kNDETo=
X-Gm-Gg: ASbGncsJELnRpRfCFPLzAznhqtEyiTOKQ0d4JGTkgf1N3jRvlFCp7w1OwhbdOE9Sc4J
 TjwJqn/yjY4BQHxY44b+77ndH+x3AIg0IIghvFhxxpdbr0J5uBeUYbOv2Sipsc/kFMQYBBguKhJ
 whzbf5e98wqaQWkPjIcOgs/RK7AgspQJd2/xt69E2HpBRedFGAiKm3xzR8I5wrLeKKs9iLw/CfD
 U2wSpA2mFI/kaC3FkHVFsBniXjswZdJDM1RHbCSw/cDgmQBQgaX9+jGYFDFgnmYIcuUl/wWxd+7
 cyVvHuodgLJGiBCPrfUtsiNYqbaptADqAyTe+mydHjepn50vJ0peL/M=
X-Google-Smtp-Source: AGHT+IFDuKX7qTe/EdrJ03IB+wOvvjPacsjGKZ1Cc21k68vTWECvwQBJeJqbfpgvwFCZJeOF10tT4g==
X-Received: by 2002:a05:6214:5188:b0:6d9:3016:d101 with SMTP id
 6a1803df08f44-6e9006d9003mr291650076d6.41.1741796621097; 
 Wed, 12 Mar 2025 09:23:41 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b6ebsm86448076d6.87.2025.03.12.09.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 09:23:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250312123918.52734-1-clamor95@gmail.com>
References: <20250312123918.52734-1-clamor95@gmail.com>
Subject: Re: Please pull u-boot-tegra graph
Message-Id: <174179661982.1743005.6492646443013109624.b4-ty@konsulko.com>
Date: Wed, 12 Mar 2025 10:23:39 -0600
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

On Wed, 12 Mar 2025 14:39:18 +0200, Svyatoslav Ryhel wrote:

> The following changes since commit 0fd7ee0306a88bd99d3820167fa45a7ee6fbc1e1:
> 
>   scripts/checkpatch.pl: Upgrade IS_ENABLED_CONFIG to error for U-Boot (2025-03-05 12:14:49 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git graph
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


