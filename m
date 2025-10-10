Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E3ECCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F5768404A;
	Fri, 10 Oct 2025 21:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JG0kIl28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2065383F8E; Fri, 10 Oct 2025 21:23:24 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20D8883F8E
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:23:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3b15f0027d9so1281053fac.2
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 12:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760124201; x=1760729001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKqvp5mbbsvPEIc+ieIjegQ91ChEJvj2QLiBc/tWajI=;
 b=JG0kIl28FqWzhCdTnN3EES+pFxk+dLJ6oQ96JMl2qUU0nKbUj7wwK+YZjyhpXxpBfO
 0mycGiZz/OzOPYKPMjjen7F9Gzy7Wonq6PcFIHjzWxfmEFEpSJCtRQy9zL+2iyo98zt8
 MbR5EqT1C834mB0J1WBJMqa/6zLbgrDPgt0N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760124201; x=1760729001;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PKqvp5mbbsvPEIc+ieIjegQ91ChEJvj2QLiBc/tWajI=;
 b=WZsUGSwHQURHqz3lsgc4b81mLC+tOa56/TMYooBoXQQi3ESn2k1c6ILlrr6UHQ+Zx8
 4rmaky6XvhhOpFaHoa0VCANAl7RPxBWMKc9uV25O7tQp97H5qfVKFOErwK8/EawgKe6E
 BUm+Jrnp3oJZMrq/Y3WGySTXJEvMKo+P8HICkPZ4g8/SF2pTGiNEbbxk/YzOkB4EwqGo
 Twki5iUzc2mdVPpMVanE59Ie7nqiYUOmvVlnzL2R9+OnJ85EgsUJee1z07swdHl69RDU
 hufpUx30IYvWU8w3kGq6nLBtaktkXAfQkiQvxEZI6KgKlO7pAG/D0O7PLvIfFHCcguHM
 4wew==
X-Gm-Message-State: AOJu0YwG1mGIGfyqaTVRBqmv2t4F1Ni9GFYtnog98beNyagmVEr4nzVG
 jooaLBifkC2dEBpr+Wrltt33pa7xOAHo5iXP2FhyU0rhlotOY1ziR7F1NXPkRrrkDZ24lQhwIIY
 /fNgcCAQ=
X-Gm-Gg: ASbGncvorrZNdKay+ilnTlAyDI/rTl+46ZVgds/EI7jIkJpeCKkXoXo4EY+TC4U7GdM
 DkNcTH7wm0sPlfF2uf+tQwsl5InVU34SvURvorgkrYVf6OJGSRqxOcw4Xxix72K5U8VBQw4FYSL
 CHVT71n7MSrDSFwoKM/cln4vae9xcZexz4Lqa5MBqZRfslqnLY21dKsJwKF3AyT/caUoBWr3/B1
 nFQjvqZ0/aCIynNnuPitH8E3y52LmIJKn4i16QcN4GLK3xFgf+ssHRSXiF35uU7Pn/12WR1KH7q
 1P1gx1HE6rJAtNtOCuryHgXf+Flya6Jafr3GOBHMjNF7P4WCjbEOS36YGdBuZrCHxZBM4bUPXYY
 vNdOO/82gAv7hDKQq++LSTki2tpWr1x9WJ8chmkCMQD7NnGKeBfmXSOpCy+WSTW0uPVkzwsM0yd
 p8o8M7xMwif9U2ng==
X-Google-Smtp-Source: AGHT+IG8U+AkXBLt3xBDj8im+cBk3PUimIuvZFFzmm3p+uTHlye4qm8tHAFsrRyBcWGCWKlMH2Ad9A==
X-Received: by 2002:a05:6870:9a1a:b0:344:a994:2ad4 with SMTP id
 586e51a60fabf-3c0f6af87e0mr5454771fac.20.1760124200509; 
 Fri, 10 Oct 2025 12:23:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8f581ecsm1155832fac.25.2025.10.10.12.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 12:23:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Sergei Antonov <saproj@gmail.com>
In-Reply-To: <20251001203029.2828194-1-trini@konsulko.com>
References: <20251001203029.2828194-1-trini@konsulko.com>
Subject: Re: [PATCH] gpio: Remove FTGPIO0010 driver
Message-Id: <176012419961.1180358.17278921883233092930.b4-ty@konsulko.com>
Date: Fri, 10 Oct 2025 13:23:19 -0600
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

On Wed, 01 Oct 2025 14:30:29 -0600, Tom Rini wrote:

> This driver has never been enabled and currently has build problems
> related in part to incorrect out_le32 calls. Remove it.
> 
> 

Applied to u-boot/master, thanks!

[1/1] gpio: Remove FTGPIO0010 driver
      commit: 0ceea8b72150bafc89684e895715c5846a74c254
-- 
Tom


