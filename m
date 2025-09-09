Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F81DCAC582
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 18:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4FD683236;
	Tue,  9 Sep 2025 20:31:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ElSgtSJJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CB1C83192; Tue,  9 Sep 2025 20:31:39 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59C278319C
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 20:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-411498d92deso9624815ab.1
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 11:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757442696; x=1758047496; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YjlVUAvEC8culBmw4V1BOQJ7XcGkxLFdHYVh9QfLK0M=;
 b=ElSgtSJJtJsJw0f5ioMi+1KHfSXT57bIuZUG0i5ugewiEsN47yXiDYMUnDHUBPd/rr
 RII+1BdM5ru6plFVA2E3gwo7q0zaWq/tcNzg5qLjS1LuVk+UQfILJMyHP3xz8ppphwsJ
 B+a0z3tp94rHvluqZ9TvI3sIYugFEaNvQvLRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757442696; x=1758047496;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YjlVUAvEC8culBmw4V1BOQJ7XcGkxLFdHYVh9QfLK0M=;
 b=QBLqDmgxFS398u3eQEuV10e5MU7YJ+yISiOd7TzZZI54fFxVhwNXC4Rg6BL9Qbgi+g
 8bE+wxwvOUZEwGW5ifGKstq0qimODjByhRECc92MjXV89GpR3e9ze0vgSW+Qey9AE/BG
 au0bsxkJVutyi6bP/aSN8D3PrIdtPBmfZYKCbxnnHeWiA7D8SnIvoExQ5b+pKwys21W+
 GogwxGW4iFs2RBiTesYvUNdUSFqT3BgNn/Zua0VWO1XljozP3kBf9hywobwCBXDNRH1/
 nWWpswPsxqbFU7YVgtPY3BCSETW5ukuqkaimLAs+2Ri/ORmxMp/13iMGtICJBnGM1WqI
 Bcxg==
X-Gm-Message-State: AOJu0YzGb8zbh4NkAmVeb0HpA7ETfIwSfAhw8vkmDJLpfZckesqm0uxz
 ms50YfzqRIqlqjeFJAYlSjjV0lIoerod7di4ekL0ImmIjReRb+kNf3VRe0+xBMxNDGI=
X-Gm-Gg: ASbGncs6xB6VxYbFu2XVHKaBn6JqKLma42mOtnndFXkniSPfc1+8icbBmBKPtgWFhcf
 7mOB9rDyXJ8NSfVxRyJYT6BgmUBig1abr6qp+W8V35ylhKk7qKdyB1iFVlHJ1isJ/A80MlEgo/r
 c8vMpR6Bw5jSE6eOuYWnTpVAbWnvQmOkuT3JCzx8rpXfCPEAefMnDhED2ro5boCzPq+c3IE0Sax
 UWhSTVmHOV5l2TDzI6jyC9ZKbkK5V8hF4iUy+QvkcFPZIYiYXMqJnJBSSS9EyfyB/AF7h5uuBRZ
 7kb9dEhowuf/1cMvbx+cGPo1ShstbSHtV/WO/cQI6OKDBh7a9Ypwg1c3ofDxuTityRWbqdtliXk
 4emS5+tilQAV6NXTV2wTxwO1AuQ6BMIKaUroFkriA1GEgky9kZuG1HE4ZxR0vY6L4gg==
X-Google-Smtp-Source: AGHT+IGk/MXZFBNY9a5R7LCuiGMWZyPq+Uo6C0U13muc+p6ZXht39/soWLZtY+LrD9UI9PNVSbQkAw==
X-Received: by 2002:a05:6e02:1a45:b0:3f3:3140:bd00 with SMTP id
 e9e14a558f8ab-3fd8e98d182mr197318555ab.11.1757442696043; 
 Tue, 09 Sep 2025 11:31:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-403c8eb8884sm32715295ab.33.2025.09.09.11.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 11:31:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, alif.zakuan.yuslaimi@altera.com
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>
In-Reply-To: <20250818025502.6830-1-alif.zakuan.yuslaimi@altera.com>
References: <20250818025502.6830-1-alif.zakuan.yuslaimi@altera.com>
Subject: Re: [PATCH v2] misc: fs_loader: Initialize actread variable
Message-Id: <175744269516.1809471.9709860995276554723.b4-ty@konsulko.com>
Date: Tue, 09 Sep 2025 12:31:35 -0600
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

On Sun, 17 Aug 2025 19:55:02 -0700, alif.zakuan.yuslaimi@altera.com wrote:

> Initialize the actread variable to prevent undefined behavior
> that can occur if the variable is used before being assigned a
> value.
> 
> This will help to prevent potential issues, especially if
> actread is used (e.g., read, incremented, or returned) before
> being explicitly set elsewhere in the code.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] misc: fs_loader: Initialize actread variable
      commit: a3f0a8e7a1be4843363967e63d8e5c7b725ce2fc
-- 
Tom


