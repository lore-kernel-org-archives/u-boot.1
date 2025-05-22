Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9123FC54ED1
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 22:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DDF7831D7;
	Fri, 23 May 2025 00:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rGgbDFTm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BA868319C; Fri, 23 May 2025 00:48:43 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04E5C830EB
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 00:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72bd5f25ea6so2358133a34.1
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 15:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747954120; x=1748558920; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/059okwxo/kzLTz9XUBxB0P0OEh8VhvnfahRaYwp6g=;
 b=rGgbDFTmVKzKVRBiHmGkbmr+VzwFaGXo32GeqktvTR02TBsA+IX73UQftdLJpJRVRM
 BOYRB6WkPn5D6M43Jm0mBxYEb2WaIBHqS1oE/PU3LGV2KcqzQqNOyiNR2LqKUiDM5jrv
 n7jVuEU3zN5DghHT+7c7A1urJK9IjQQmq6ft0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747954120; x=1748558920;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/059okwxo/kzLTz9XUBxB0P0OEh8VhvnfahRaYwp6g=;
 b=RdFbb24uDmBfBAmY2qTTW6ACP7WjAoCW7zRHhfNl/UJX2UGluTLZsb9CBW5ifzI8pL
 Nx5sCZf/cIW1OBb8oVwRuUHlJyO4v9OkshTxFKrtFIxbyd/IlWmN6yX/L8Pdu/wFiB9X
 NTsRTFYiZlNCm9lUMCpqaRuKqqvdyjQMeoTEN8rFy/Bwr66FsvUOboucKdfh0gLbuNih
 nyO3U+z2bi23oKM5I9l1fpR+XBecS3QCoh3e49DIkpFtH6k9wBhFKn3LJzqaagtoEJJN
 uX5kcCwBQrwdPzq0IylIFn02TfK4eoJTYLS/pM/OZqMsSCWVS1u/uUQwNgF4QpWMdg7z
 kILQ==
X-Gm-Message-State: AOJu0YxlEN/wI9ezT8EtWRPXJ+ylmtrL7x9iKWLojcBa2BsOVpyhTH1e
 vnN8lmzQu1E+VLgaHGe9lXO+JIu9FhzX5VAvIlcsC5q6oQHizGbzDaHNzWUo8F5H9Fs=
X-Gm-Gg: ASbGncttqKmG4Em/VndTAedSTWDnqwGzlObh8GUOQkJp9zIyDnKeLm/qfrCbt/WSF3G
 jH9W9S6+vvPaWkIhE/IR4XoZBp60tHarelXyzjwfCHBjh3rq2nyErtsvzbQj3RRPnNQ/Isx30sx
 3ghnZ1bRLo8QWMT8Ia93dPHxedzPaAqg2x+t+nc6xx3s4FG9qzI7DMtPqijSyqEFc0KoDndhpRm
 Rr15lIvHDUqXFz1aRA+JELHTYPkZskRW42RULbJH8VZKdA7BzHz/PuW0ehFP1JS0vyVgA3H1T/B
 OiRjIGbtwr89HGNVmCqmIPhFVyRq0QD0iGYxAQv5LMg6hjgmzZpTXLR/Zyv+YP4j8in1Gbbu8K7
 A5q3gtvY6oQrOM+XqlUa18Q==
X-Google-Smtp-Source: AGHT+IHoea/PjU3T1vAkQFJ4tx1V9VShMCxx7Y7z2As7ZxXO8G04+InykH1Or6b8HjhoRDU0tDCeOg==
X-Received: by 2002:a05:6871:d306:b0:29e:503a:7ea3 with SMTP id
 586e51a60fabf-2e3c8569ea5mr16138945fac.36.1747954119751; 
 Thu, 22 May 2025 15:48:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c060af78sm3258534fac.5.2025.05.22.15.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 15:48:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <jj251510319013@gmail.com>
Cc: sjg@chromium.org, carlos.lopezr4096@gmail.com, 
 aristo.chen@canonical.com, di.gerasimov@gmail.com, 
 marek.vasut+renesas@mailbox.org
In-Reply-To: <20250508193724.4269-1-aristo.chen@canonical.com>
References: <20250508193724.4269-1-aristo.chen@canonical.com>
Subject: Re: [PATCH 1/1] cmd: ximg: handle Z_BUF_ERROR explicitly in GZIP
 decompression
Message-Id: <174795411851.2210140.17838424441427883299.b4-ty@konsulko.com>
Date: Thu, 22 May 2025 16:48:38 -0600
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

On Thu, 08 May 2025 19:37:24 +0000, Aristo Chen wrote:

> When decompressing GZIP-compressed image parts via the `imxtract` command,
> explicitly handle the `Z_BUF_ERROR` return value from `gunzip()` to provide
> a clearer diagnostic. This error typically indicates that the destination
> buffer is too small to hold the uncompressed data.
> 
> 

Applied to u-boot/next, thanks!

[1/1] cmd: ximg: handle Z_BUF_ERROR explicitly in GZIP decompression
      commit: ef305ceff9c875a7c16fdffc5e120d8ddf6243b7
-- 
Tom


