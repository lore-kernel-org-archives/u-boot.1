Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB432D46C06
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 21:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4510383DFF;
	Wed, 28 Jan 2026 22:54:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OY98XCuy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B5B83BFE; Wed, 28 Jan 2026 22:54:21 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89CE283D2E
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 22:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-662f65c7d8cso186655eaf.2
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 13:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769637258; x=1770242058; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37zOzTpqAP+DwXBvEpmGmTXEJ9rYAV//QXMm5JMj3OU=;
 b=OY98XCuya6+0nhe95DxYj5gK3DD0ezGI77NTRq37rYQUwCnrg+P+VUlzNfQpzx47t0
 D9zq+iJ2yAgnbJ2tpQpq7TTdQRH1VAhOM/F5OCsNhrY5EtGIMt+oR/L0D1Htz4piwrr2
 Pdvll3HP9U48o6eCLi9dnvRhB5y+39k0VCQDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769637258; x=1770242058;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=37zOzTpqAP+DwXBvEpmGmTXEJ9rYAV//QXMm5JMj3OU=;
 b=JZv0NpfbjTpMSmHLj7kKWt7oUNpd31c/Y2ebVhkncjMfwrmRAPI9etf/ll4o9pJSgU
 a8a9Jz+3fCJqd74Akxi8f1WUHvhH4MPWeNrZ8FigPv5u/8lEPCQ0fW5NYTuFnGRhaUzL
 Hewz9aObTcUwWFDHfvlaJDWqICZcDe0Op7CLyGf7hAdf1NbB/iquidlXZQsOZ4C2Wjpt
 Q99KLPfeNd4UVbvhpm2Fgoz+2n/pymUF3pzgMlxi9Qqr8c/2XKUE3il1e7mIpvxLC/1h
 hfmZCwlWNN9GvmnzyTxmYp8uD3CSSqdYYYDBLAnDTUuoZRBDMX4RQaw5cRTA4ALPVGdo
 +a8A==
X-Gm-Message-State: AOJu0Yyz203PHta/hYBpXfVp0f5tiliUEdSklOs3BPcPD48b/1E6x+Hj
 EvsXRgtJBcPLxCXh2K9OEN0bWk5aXzkKa84kBvdWVAK0EZAE6MJDwzyhm/atrkvhh2rfsgUVvjd
 Jb+7zZ6w=
X-Gm-Gg: AZuq6aJYaxNmH1/k7PlkLrfBd8TqhXa+yB6mlY7BMgImhTI0uAcu21/Qj9HqtHsygmH
 ROR73KjoqJ6ZEopSI00VxiDyRzOPbZcTrifOBNdoJ9G2HQOpl7zBhjFcK3Ri4+lH/ddEZrWzt7m
 0JKmCn/Uter8JzFQzKWLSUxNi3vBaFhxgVKAQbn5Krm/fyGrlD5A3yBJGq/qraVHssmVMHWKrGZ
 F6iJTMu7B5+jHw/FgMrhxdCeYx4tS3WV2+1lyr5cqJvXsQyMFRxaI4opB6UHJN3mnAY1A0Scyvz
 /gdegzxCr0LOlWEBzP1Nf+MB+Mv2xE3v9z+eETyufi5c4LQ+3eaaxHCcZuvf2VGTcKqWcjKWk4E
 XKKwT78J6qqN3ZjuSs27tYreb08F799Lsv54KTCKtysbtVRbp/y612iVm8JCDuOuJx9iQArIO7w
 dq0eRxJkRRcNPuArgtCm7dfyGOe7iSdxfRnrrrfPZ+si6fOZlCfctQLXAkchn33QkPozOtGFjSw
 0yXJdEcnZFAprxIXTPTCoPIiAR9W948sM/+zQ==
X-Received: by 2002:a05:6820:1693:b0:662:fc35:453b with SMTP id
 006d021491bc7-662fc35476emr1965628eaf.53.1769637258267; 
 Wed, 28 Jan 2026 13:54:18 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-409571ae8f5sm2570113fac.9.2026.01.28.13.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 13:54:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260122172057.3212673-1-jonas@kwiboo.se>
References: <20260122172057.3212673-1-jonas@kwiboo.se>
Subject: Re: [PATCH v2] armv8: u-boot-spl.lds: Place binman symbols at end
 of binary
Message-Id: <176963725770.1779019.9045396325515962115.b4-ty@konsulko.com>
Date: Wed, 28 Jan 2026 15:54:17 -0600
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

On Thu, 22 Jan 2026 17:20:54 +0000, Jonas Karlman wrote:

> It can be useful in xPL to access symbols from binman, such as the
> offset/position and size of a binman entry.
> 
> Place these binman symbols together at the end of the xPL binary for
> ARMv8, similar to ARM and RISC-V.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] armv8: u-boot-spl.lds: Place binman symbols at end of binary
      commit: b8a820ac98fda6005ae131d89026c60bf7c9c535
-- 
Tom


