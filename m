Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED321E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 04:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20CE6802A1;
	Tue, 17 Dec 2024 05:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TQaQ2ml6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 043EE80282; Tue, 17 Dec 2024 05:04:17 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCCF980250
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 05:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b6e8fe401eso412106385a.2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 20:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734408254; x=1735013054; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ayc0PcbpXUXSiDTfgPK53DKLf+IZ3d8vpArVOauvxQk=;
 b=TQaQ2ml6JyTG0sP7p7tuoTvzgpfR648sQEUz6bJHznJ64kgxCzxTurrlC1BaQOnTb5
 i4FSu+dd3chxb0fh+93a///0frHrwLgRWvs0ZBzTUedmwJ7CtOuWHYvfwcXYr/dbuD2C
 5k1BlG+MkTjBaJzQ22zhs80qRjNnh69aLxfH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734408254; x=1735013054;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ayc0PcbpXUXSiDTfgPK53DKLf+IZ3d8vpArVOauvxQk=;
 b=OpTFpCMdCZCZo0lt54G2oyShbf9TtLoKG+HbFg4NV9FWD4rPwrWQNfS11Zc696lxLO
 8v4tBN2ybuzAKrIl0k7OA9OvVCnnT0Ch7svAoQPQdgI/Z3q1fNdusuiGFLQQ3LGIwcUB
 rILzV3L7AhaYbF0BfBQF4m8+KGTO67kPEVb0NCAV5IrLRPVmegCfNgbCaAoEGXScnSQX
 otrIPFYb2N54e1dEMlLvRuqScwLV0iBL4wQGqOQUv4gSFTEUa0RRZ4/fXxHEDs8BSVv7
 67T8VekojfoiuJ5rQc6XshWmgZ/FKUIkOgN3mcPy/iiWiJN23hRjDeKSHPXeWhzvluZy
 mNJA==
X-Gm-Message-State: AOJu0YxB9nU78emHSrbdfdG1q85El1lxwy+281DtedCDuuUE9PI/6na1
 NuhpBmhRqZmeC19PQLwW2tBm0TZkRtkSJ7TYFRTbxB9rcqCN6TkAxljUNygsYcwXyg0YDU6nj9H
 8sII=
X-Gm-Gg: ASbGncs2jzPfXa2fTLHWBkoR1uZBAZOMYyWrgXMQtTgl0tgJ+71ExRejcYML5p9Ap7h
 8dOdui8X/NLOPuUwYzP5zS8L7aPhhm8DIpLNzUa6gNsBcv1KDyRWa51I3e763jZLpPM372cnOCJ
 AkoZE9tWYiwA+62fKkVG5/VQzSA1y8SSQR2xVUDMyIPU1mv1d6tHXIgrOpczelFONebTRL8Y/JY
 85U29N4OMbur1P48qoih/JB2+QKxToGjckslxvdqNQbtCJo5vpbFpE=
X-Google-Smtp-Source: AGHT+IFweLjP11gwGO7niXkQRaDvJI6pnpVcdMYV7jjjD7tQSY4RRKybDux0fFwfwPNmMrJxcXs+eA==
X-Received: by 2002:a05:6214:caa:b0:6d8:a8e1:b57b with SMTP id
 6a1803df08f44-6dc96850fa1mr294749816d6.36.1734408253659; 
 Mon, 16 Dec 2024 20:04:13 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd256fd9sm34358136d6.37.2024.12.16.20.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 20:04:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Yuri Zaporozhets <yuriz@qrv-systems.net>
In-Reply-To: <20241201222849.68852-1-yuriz@qrv-systems.net>
References: <20241201222849.68852-1-yuriz@qrv-systems.net>
Subject: Re: [PATCH] bios_emulator: fix incorrect printing of address in
 "jump near immediate"
Message-Id: <173440825188.3115242.11241404522319326730.b4-ty@konsulko.com>
Date: Mon, 16 Dec 2024 22:04:11 -0600
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

On Sun, 01 Dec 2024 23:28:49 +0100, Yuri Zaporozhets wrote:

> In the x86emuOp_jump_call_near_IMM() function the target address is
> printed incorrectly when jumping backwards. For example instead of
> "jmp 0xe8bc" the string "jmp ffffe8bc" is printed. That's because
> of the following macro:
> 
>     DECODE_PRINTF2("%04x\n", ip);
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


