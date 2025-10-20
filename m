Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350BBCCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 13:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD65C82C84;
	Mon, 20 Oct 2025 15:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eOhhA5EA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C0DC831D5; Mon, 20 Oct 2025 15:33:19 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90394807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 15:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-58afb2f42e3so4994101e87.2
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 06:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760967197; x=1761571997; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6AUtzWum8J8Pz08wdw5bSPPgMqhd5RCj2y3XowIsp9o=;
 b=eOhhA5EAjVZtinVODFIxRnlmnpJ/Z/IzXCEAPjhBiVz4WAxxO8zDJEbzAZHFyN4/oU
 G6d5+uUwRDr6VRKDPELZPb0GXIfr+ARNfgN4AMH8R2mhlIAVWHmX1HL1Mg+9k+ibfPaY
 DoOqkk7lXNgQrO5xp7sQwNylzdT6+gJyNY7ifNm4J075HQk1uyvKTOeXwfTmoFvJTHrC
 6bZPpxbG4N8vzx7FbZvlvIz/Yj6R3cYTrkUrZUmn7VAJQHdP26/4tXnYozJ2E+UYVjUA
 Hm5BliPPDmW7xcq0rbxeIbhiD7J3aH+AtP1qjl7NHKd4FSHaXgjpwiIihTr32NogbjIA
 vpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760967197; x=1761571997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6AUtzWum8J8Pz08wdw5bSPPgMqhd5RCj2y3XowIsp9o=;
 b=JvUSABVrj0lbL0L/kkK4ub2aQ0ENQO1jh3P20KDgJRV+jR6hzfZgT2hpNNbTA9rZZt
 4je0gxuDVmh/NQyXstmtWv9XmtDO71PbB27he1y8+lAmxGalEhLmwxV9Mzeq+y0Qcduv
 mhxtF4A3u3TkZytVahREq+AsSAPiPDHm6/jXwJFsZv974dDIYmtdCTdLyGHDZyvXQox1
 stC6bftT/fyKkeVJw4z8ENPw98+hBX3thwdQhxWAoq+ESu5Y018UbC9uMVo8E49NCs9P
 Kezhwg/TtdnhbSFFiUmx2NsCVjueNJGI1a/NrWj6X8z1kGY+YAV9CY40P1qkauDuh+zA
 adDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxRSwh/Nqpz+mGweUn67aLikIfEpmobw7b1iWRl+qOJMv1k3mxKIydCPgA9jEAiCUuJzJQRQE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4RZ4EByrwK158/pIdUw+GjbSff8OT0a+R1QEy3rkM9+fLu0Ew
 xABJvqdZ8PT/btOePNumdWs4r0cdgen6VwZ8V3BZq3Ag7maTv/rJLLtOjaAgJPo5AyNAiVLEIyR
 xGkX6YULRKUFL6nfo+q44iJMl/Puu6T6jfQ==
X-Gm-Gg: ASbGncucQ0LD0jg4C0YXpqqTZwR98J3x7aQjxwR+z4CXPBIg2kbq80hK/0LhyOJuR3I
 264pRJZ/cl5KnKbY9Ll0JdXSjCK/ExAYZllgUu+PF3TzqkUJmj9FnqUtuQaUvk5LIrQjSCO+D0s
 KEDA5RretCCBKI51eqHNEJIelDmrBQltn1JD51pH7wAnKPn4/sQ8u1qoqz45/FVpAaXGsjTcuL9
 5L2Fm0MXpnSdQQlfdWpidbkZYDA6bYyXcAqUCje0WGDHiDpZkS2iquujL1hhTr+bhN07+BEmFCI
 VNynbGg23Iy79SK728WQsijllKUQrEMFF9oJig==
X-Google-Smtp-Source: AGHT+IHtSwxhaFjpUV9Qz+5kC++6pcFGt7tOhEeM/PwU35nbPSWsCGsA4XbfvSVXxbK0HSQnc0UzFUSunb4gru/8fM0=
X-Received: by 2002:a05:6512:61a:b0:591:d903:4381 with SMTP id
 2adb3069b0e04-591d9034751mr2686834e87.33.1760967196537; Mon, 20 Oct 2025
 06:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20251020133100.1837-1-briansune@gmail.com>
In-Reply-To: <20251020133100.1837-1-briansune@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 20 Oct 2025 10:33:04 -0300
X-Gm-Features: AS18NWAH63L7LRsXS6O5zCSwNBc02zsxjdPlXljRDJ4yUNQ8tAynte4rg_La_ys
Message-ID: <CAOMZO5A12FSgx3XoxZQBmtdqLxxZ9CbEDz4p6Ar6gcRqH6Uhhg@mail.gmail.com>
Subject: Re: [PATCH v3] Altera SoCFpga Boot Stall Fix
To: Brian Sune <briansune@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Oct 20, 2025 at 10:31=E2=80=AFAM Brian Sune <briansune@gmail.com> w=
rote:
>
> From: tg5 <briansune@gmail.com>

From and Signed-off-by lines should match.

./scrpts/checkpatch.pl catches this mismatch.
