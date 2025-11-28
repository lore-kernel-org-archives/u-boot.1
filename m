Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93040D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 17:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD30083B05;
	Fri, 28 Nov 2025 18:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ESqggGLq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 492E983B8C; Fri, 28 Nov 2025 18:41:25 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30C6683AAC
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 18:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c765f41346so723711a34.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 09:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764351682; x=1764956482; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=neqHGi2Om5JTYYdyEaF8DIyo1DSLm3wwaILUJg360nc=;
 b=ESqggGLqvUBFu47ga/xW+sk79rxCncb0vVKN7CSAv17rx2Tpx2D9r19DvfzVnCw5vB
 3kNlWZF0mu8FXyxzsx46qNBkL6mik/dVNitlc6FF2rdqayHGc1l2PiWgAXYHIIFY/MrZ
 AhjSBUSQfq2JViO7nDKz7Z5rrq5epJh6AfciQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764351682; x=1764956482;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=neqHGi2Om5JTYYdyEaF8DIyo1DSLm3wwaILUJg360nc=;
 b=BtCowbkUu18ZZMskZnvkhHskLf9R+uSUO0zJqbMidlFCWdXmYufqaoBXks9EmnMyDf
 vsjucxq5ev9KgKMI9Rt3fhy5Gg5L7Ie5ei8u2PrRvipnxjifL6b38ii6Q0rUcEmq3jCE
 otECizB7/QyPBrTJ33p0kN8Gp3CFmN82XMoy+M90q8HSt0rQheVFpUHb4mX0rkOwR2BG
 ajlsKPAlE5Dk7lInTZEFt3N+a+q0XfOv1aYHL6FVX1vctKUZdD5j415uwRPH5TTOwwEX
 diPXzLhLBSsRpFZHM4hJ7XaCTrYGXmNQSHamRIfkv+UnoavqalFh3vmNRdvdSMQo0Q4p
 HI5g==
X-Gm-Message-State: AOJu0YyfXCmOeIatjG6gou03rUbng8n7UBCrOrB5tNAUqmNu1qTez9sn
 EY7dNN5Qr0H5ZTvV6pYwzyLjV42B+EPPRQVkmiD1mmFXWU+W4C0tOHHgaz38Or3KEAY=
X-Gm-Gg: ASbGncsf/dClmE7Jf/FlGyD+ao5Y/SBgIs5DU575ZxAsJp5FqdASdW1aKT9e2GcA6pZ
 sDtssBdzT70l/lAlCFd2p5JmGDzKPJzBnURZk1t2tKTcXr2NmBaJ2aGnBeAvkutOzqwp+tnpTgk
 JTM8AeqKuQ+kkexTrNUhlz+hQ/77tJs3kkOOndArwrTu1Pd9cEDMXCDHaXZ4NCw5rCi1B8IL/8V
 H9fl4MJ9c487FqzHgP3eH0n+1MMs4uvXZZGND82kmjT67US6E5Sl7sQwOUo1xtoDcpylYmTQil+
 vEKC+E4KnEqMWzalDDJ842kf3JVIwgOr1m/ql1WW3IT5836N3MmIQU5oT/krUZbqr6/A3vxhIZF
 58zfG+g7XGUolKf6ji5g97tQ61bbhXXEJjYAsdYmuuXADw3LFX6p+yqG7ee8PFgyhadMTxsZVqx
 BnhJjPuC0ZXDN+dy0q9kY1gkuVz5Ek4H2vUMq5qBU3CTxnpzcD
X-Google-Smtp-Source: AGHT+IH/05L0PQv8tDNYrkg96bp0bL2fdY5BjldXrmb+JVs200p0RP+cKtyOviNem9kUUL+nNg9SwA==
X-Received: by 2002:a05:6830:6309:b0:7c7:2df4:faa3 with SMTP id
 46e09a7af769-7c798cc1c64mr14037539a34.33.1764351681916; 
 Fri, 28 Nov 2025 09:41:21 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90fe0f650sm1771543a34.23.2025.11.28.09.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 09:41:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
In-Reply-To: <20251113115516.947835-1-marek.vasut+renesas@mailbox.org>
References: <20251113115516.947835-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] boot: Assure FDT is always at 8-byte aligned address
Message-Id: <176435168078.233357.200393600306508316.b4-ty@konsulko.com>
Date: Fri, 28 Nov 2025 11:41:20 -0600
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

On Thu, 13 Nov 2025 12:54:51 +0100, Marek Vasut wrote:

> The fitImage may contain FDT at 4-byte aligned address, because alignment
> of DT tags is 4 bytes. However, libfdt and also Linux expects DT to be at
> 8-byte aligned address. Make sure that the DTs embedded in fitImages are
> always used from 8-byte aligned addresses. In case the DT is decompressed,
> make sure the target buffer is 8-byte aligned. In case the DT is only
> loaded, make sure the target buffer is 8-byte aligned too.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] boot: Assure FDT is always at 8-byte aligned address
      commit: 8fbcc0e0e839a8e25f636c76e59311033d3817b5
-- 
Tom


