Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46343CFC539
	for <u-boot@archiver.kernel.org>; Sat, 22 Nov 2025 16:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E06A683B27;
	Sat, 22 Nov 2025 17:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uPxCA4sI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16BA283B24; Sat, 22 Nov 2025 17:23:31 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00E6E83B21
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 17:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-65727896f35so1550493eaf.2
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 08:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763828607; x=1764433407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hMC9UoXzkSRJn2j7dkecUW+jGS1qFVOII63z7F5/wTU=;
 b=uPxCA4sIG1trcQCQ77HB6jE4BHLucz8/6ILGKWQgfboAx0lWNELl7odqSEmz/djsHl
 mTA6l7MWFKQChXinueEzDGkGS1/dWhxlULsMTkLKHn9HTaafL6/Coc61qlqkBSY9kkLo
 KV2hJ2u7dHidfDYQqqEbckbnDzh+1A6sKJ1u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763828607; x=1764433407;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hMC9UoXzkSRJn2j7dkecUW+jGS1qFVOII63z7F5/wTU=;
 b=ICcfLGg7KngB+I+K3yRa17HemYaQNWA+TqzuxyRzdrVE9nZOJw/h8DPMuGlYoEgT2q
 kmkcCkd5BYiTMAoSn+r/e75lewHIIbuIIbjSwfujqnpIrrnzXfdf/CYA0j1EL8g6CBU2
 ZpQUX+BNCZrAq/vPZC5+FOFXpsW4EtKwcUIR1erVtULDM3mJrObhO6RRhsW9zUYsZBRA
 34aZhYzESgAbUR7/yigQ5h3/OBXzzU8D9h35jkxxM2hhzOUSfklsvX2xyd1Z+4tsXKvJ
 V+u+uLh+ek0Ns4BYtJ8aoQkrakbHGdq/j7Umspb5Q4OZ1tuL/yzxbCRN+wC+ZjMogpvT
 wluQ==
X-Gm-Message-State: AOJu0Yzg2KpnBNBQJ1KhP67UPQt2t1pJN9xMqckjtTH+KUwZ9Uw/ZpiT
 E3ZOps8QU+hy20zj1XPuVSHlBjIAgiCSk3jI4gShvueE7GhvMwef9Sj0ViM7rRqxfuqnQRbfikB
 W/30IGSU=
X-Gm-Gg: ASbGncvfkKhwO5AFxHVPFcupLZ+AB7LieOUTQPclVA/3AYz6yZjEOsHEsuB8CsAjSiX
 VqtXlFzEIUZwLjYe+i/DtVxw2d4K9amHYq6s13oTuP4srrmWnPg3ZSF9QgEIobrcqgwgO0+cAgG
 22/Oy3/2xL7y1Vs+TuFcVnVsJV9zOAmkUygbcRWL2SUYTNbwp9LINb12FCOs5jV3+SlrC/rI0T4
 +WxHNsjTxwkI3bS/3t4CeAtMiWGKyWjJSHnxEqn6+Olq880ewJ6y6xJAeU5l/SeKdez8pLbxuf/
 rUklQrb3UbNX5k6H9DPLQTs6fsdgqw6i/shLQdGHCqPw5u134Qi3MG2cB+pBpOW/BwB6JaQWXG8
 CL/Ac4yuD+FAA2Kpu6GzLxQgJxW7fguc52vkL1X7DDIT9qOgtH5WmH6nXoBzbQeEzVeIZJLOERS
 qqk+SNNdmBwx4TCramoHTrYIBygaeBS5i6M8ZCok9AxSffkrTw
X-Google-Smtp-Source: AGHT+IEO1oHQg95mUx7cI9vhYxvi7WAiJhCA+Iwjp/n021x9NgibMQOvcwNDVaA5CFii8lU7d6uQbg==
X-Received: by 2002:a05:6808:3507:b0:44d:ae36:dd7a with SMTP id
 5614622812f47-45115cb85dcmr2017095b6e.66.1763828607592; 
 Sat, 22 Nov 2025 08:23:27 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65782a359efsm2488378eaf.4.2025.11.22.08.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Nov 2025 08:23:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <BESP194MB2805EAEA32CBD02FF8F2E7BFDACFA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB2805EAEA32CBD02FF8F2E7BFDACFA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] upl: Fix buf array size
Message-Id: <176382860647.3054897.11524464026297414305.b4-ty@konsulko.com>
Date: Sat, 22 Nov 2025 10:23:26 -0600
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

On Tue, 11 Nov 2025 11:37:35 +0100, Francois Berder wrote:

> Size of array buf was incorrect due to sizeof returning the
> size of an integer (typically 32 bits) instead of a u64 type
> (64 bits). Hence, buf array was shorter than expected.
> 
> 

Applied to u-boot/master, thanks!

[1/1] upl: Fix buf array size
      commit: 8385ecc8eff91c45700040efbb08cba2ce6d3659
-- 
Tom


