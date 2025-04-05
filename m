Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCE6C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 14:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4441182A7B;
	Sat,  5 Apr 2025 16:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XXfVMI8p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE82882A7B; Sat,  5 Apr 2025 16:28:13 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9766C82A53
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 16:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5fcd61e9bcdso1394833eaf.0
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 07:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743863290; x=1744468090; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZgmcP9vEmFoAYdU9gcnoxIjBSA/eV2oFdGWrwFdwi2A=;
 b=XXfVMI8pmQImZKHTyC6nzKuU5y4SFYjdmBbQP6QFMshtBrR7XlytiTi2/dJ2kzk23D
 luOksyVPiJuk1+no3eQ2Y7/k7deuCYOolxOowUf/L7vljyYQNx2AWXyiNHb9D6X6s98S
 iwvjjh8S0qjP423+9WmLdUbFqiy0pkS0/GrDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743863290; x=1744468090;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZgmcP9vEmFoAYdU9gcnoxIjBSA/eV2oFdGWrwFdwi2A=;
 b=g7eM5/x1og7xq+F9AUx7pnRn+A1wQkfMfahBLOvkyzMLb6nljFyzAyFaJJli3YIkzP
 t9C6NANPQYIuF6D4RhhBMDdONCHLTkKnEpMkzKPzJGZzLMNz0fnJvizk4LfSTRi2xvFH
 QI6E0GAHdst56p/eqH/sTW9wV6jZMqOt5qOfqmiM96yhsrCk/i1sZZRCH7qoLnjqEhez
 BzZ0QybNWY6TEufaguhnG5XTyBVEfQIG/ZinE0dlcTTNXHEkGBk0hx6oQrirnZ2MIDQt
 c91d3RCmaqaM8pEWA++Ln1shUh7mgDZlgrro6o1U9i7TwUlONWRZWhfAJcyE9C3sjOkN
 XOzA==
X-Gm-Message-State: AOJu0Yz/G3gt7zSymDhhMRlDk15lGn876+xraoXCTnlyrN5tPBpQ3oew
 0BcChtlUCuZj7LpVp18e2V377CIX5nXnpZ1V7zz7ZCNvxTm4Kbj+rUC3HXzxuVw=
X-Gm-Gg: ASbGncukO94Ftvu8o9/4rf7sipMwqxYMA984s+auUzVTLI+e18/XBhusa+2EmFop+A3
 bI9ijANhDAXEh9GxJDgw+VZFNrFDBPYHjKrIEicemUehGNy5RPBguLJKjWIqku/pIgw8x+h326d
 DSmqJsEzS8syRJRTvdL//5scjeXPNX4SyNCUOKWkceF3/aM9XIC2Po/RpHv+SZz8R0EgyC1DAkY
 xwarG5rNC1/GSqYKdNRs8JZXyy1yVlSjFQje4XwzMi1unrWAJSOaGTk4y1Ty1r9reWnlp6ShPWz
 2XahRoUjyNeJxj/opch0YrR7QbFHuirXz/GfvTPCtsQJrwGmplc7klykveqqmKsO37u8nkd8G5i
 w65uL
X-Google-Smtp-Source: AGHT+IHpocQAFKOt/uHSSNuw6x4KFdeoeW7m549SGIb3hd/JhbJh1i6Tf2jlYmOpLIKY45uEE1rkSg==
X-Received: by 2002:a05:6820:221d:b0:603:f9e1:1914 with SMTP id
 006d021491bc7-6041ff5b39bmr1695649eaf.3.1743863290194; 
 Sat, 05 Apr 2025 07:28:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6040c4aaa69sm1055979eaf.3.2025.04.05.07.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 07:28:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Harsha Vardhan V M <h-vm@ti.com>
Cc: vigneshr@ti.com, k-malarvizhi@ti.com, kamlesh@ti.com
In-Reply-To: <20250319084714.335777-1-h-vm@ti.com>
References: <20250319084714.335777-1-h-vm@ti.com>
Subject: Re: [PATCH 0/5] cmd: fuse: Introduce fuse writebuff sub-system and
 clean up
Message-Id: <174386328874.2689048.12289214275863558521.b4-ty@konsulko.com>
Date: Sat, 05 Apr 2025 08:28:08 -0600
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

On Wed, 19 Mar 2025 14:17:09 +0530, Harsha Vardhan V M wrote:

> This patch series introduces the fuse writebuff sub-system command and
> makes improvements to the existing fuse implementation by removing the
> custom string functions. The patches are required to be applied in
> sequence.
> 
> The series consists of the following changes:
> Patch 1 removes custom string functions and replaces them with standard
> string functions.
> Patch 2 introduces fuse.rst documentation for fuse commands.
> Patch 3 introduces the fuse writebuff sub-system command, allowing to
> write a structured buffer in memory to fuses, and implementing the
> necessary function calls.
> Patch 4 enables the fuse sub-system in the K3 platform.
> Patch 5 updates the fuse.rst documentation to include details about the
> new fuse writebuff command.
> 
> [...]

Applied to u-boot/next, thanks!

[1/5] cmd: fuse: Remove custom string functions
      commit: 005eeda378b4897577eb82b30e5c260014c5e727
[2/5] doc: cmd: Add documentation for fuse command
      commit: 833c05ea272a086b5428166552ceb021b50c4cda
[3/5] cmd: fuse: Add fuse writebuff sub-system command
      commit: 578e7882bfb79848ff91cd65a5ebf4e795d26bb5
[4/5] drivers: k3_fuse: Add fuse sub-system func calls
      commit: ed5f2e5bed91b6daa4f051b5e11efbaebfec9cb1
[5/5] doc: cmd: Add fuse writebuff cmd documentation
      commit: 9f6b1ff8d08a92bbddf3c6226b8c2fdaf8df9515
-- 
Tom


