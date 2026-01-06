Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6F7CEFCE2
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 18:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C8083BC4;
	Tue,  6 Jan 2026 19:49:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W/GrZV/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 347AA83F01; Tue,  6 Jan 2026 19:49:16 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11A0B83B9B
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 19:49:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so913252a34.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 10:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767725353; x=1768330153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Oek7Jri71Mg9hZwt5nXqztP+4yG1LsGyGchHSnT1ZGU=;
 b=W/GrZV/kPQvOUsBrf7Ux+/2F5nl8JovQ9xZb8xuPydORFmtrZcjDSWKEd8p/t3dMiL
 ux6ouHVoEsSCUb0wYP4CF/fkpqdrzG9YXo5IKB0cySMBERghc+fdYKUnxZoePxWpOK0B
 UF1IoGbDApzxcvYK9Z/Gl7YXYgEv5qoaeru9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767725353; x=1768330153;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Oek7Jri71Mg9hZwt5nXqztP+4yG1LsGyGchHSnT1ZGU=;
 b=iLn+vkZivpnZrR8tv5h3C1CQioh8FJCAa1VcJ2xAXUMPwVS5/B6Pfd34lRxmwqKrUP
 iIKLhggKx1PAOPvVt+0N67J6IPPgmoT6gBo+xLBzdY9+KeAgwiUR40OmzsaeIc6Pkewj
 dv8gKKYpAbXjPs+S4nzAftDnO7aXOGYYw2PIE3XTN/UeAUgOZP1HzIZFIhjIiQ4LitZt
 EWhzFFwl5FYkQoOcDdmlkFbOUmPU7ckNFYTY3UMaWJa5m3UdU/Puo2Ij0Fb1ks8SZjmf
 lh/mO8GDndsdXIn7tBxwLSkKVtXFJm6w0yQuRAiumkL38nq2M/IXKvMucrfZR9WqtfIb
 G4/Q==
X-Gm-Message-State: AOJu0YzSy3V5WICgWEwEkz1mAvg18NiNx4MxDW5X7s5MjmQkYiKBkqA0
 0x/HBkAhqD3za0SNHCbl7BT+24GW/ENGnClV8jiows1C2pMKOvg6wCu7zepz6JMFIYIpaw+vbRc
 M8ZbErNI=
X-Gm-Gg: AY/fxX7ODYj9UoAYdCwEp4dn+J9GqQM2Y10M2ADHJqWzdSuiPIDTZl3A2rco4tPcqLd
 DcDtzTwOfHOszfWZxnhJgUGTPAPDP50Fer07MNdE0Ho2I+puAVRFGCIn3yeRec2CIc/QU/C0fE5
 O0f3HY8KHFOXczyz7ooDdqpmgc8s+qkcyqHbUwncG38GaryEQxyT0peivK8TGIINcRbSBKonLKc
 LLbRq1q1YUoHaXjZL9/8dRODUT/pcpGidAQBVRSJ6wXMKKqLfK5rUq5uDNLk1/+4iNKap1AaEvB
 w6nZ4bWxKc4QYMbnOHmrqyH4EBK2qeCoHagb1hCvTtdFpJUVXhxEPR3IeTHQW0xIfq/Xva4ITDz
 7GncukxrgNd7LWI44Oqoplo94QPnOR7TCEbaw2Kcrip4+fZJ9SXqY8jwfcnhNgQUFCtcYgizsW5
 Y7wZaL/QqQarDnsbKFZPKx2OGrVF4yrNu2AZQgWhYjALFQ+zdeJtZ4HChxLBOXhv8D8XuvXNeR3
 Zu9qO7HZHNvDzVLGKESy80pqVXMY+iTslDnMRUU0oX27bZ0
X-Google-Smtp-Source: AGHT+IG4GyCqNj/RSSPpET3Q1mv+T2yN5t1df5wk4N6I+gEQrUvpn3S9/spPZVKWx/orHW/XpZL6QQ==
X-Received: by 2002:a05:6830:1cc2:b0:7ca:e8bf:8c4d with SMTP id
 46e09a7af769-7ce508cf0dcmr111207a34.14.1767725352638; 
 Tue, 06 Jan 2026 10:49:12 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478af63bsm1833993a34.16.2026.01.06.10.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 10:49:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251230171038.4155709-1-trini@konsulko.com>
References: <20251230171038.4155709-1-trini@konsulko.com>
Subject: Re: [PATCH] spi: Correct dependencies on AIROHA_SNFI_SPI
Message-Id: <176772535166.3680613.10864461633123843168.b4-ty@konsulko.com>
Date: Tue, 06 Jan 2026 12:49:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 30 Dec 2025 11:10:38 -0600, Tom Rini wrote:

> This driver is only possible to build on ARCH_AIROHA, so update the
> dependencies.
> 
> 

Applied to u-boot/master, thanks!

[1/1] spi: Correct dependencies on AIROHA_SNFI_SPI
      commit: 03f2be416bbb8a360a2aa4ecbcfc89967944b51d
-- 
Tom


