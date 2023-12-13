Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29107C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BFCC87837;
	Wed, 13 Dec 2023 21:39:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gaBLj7zb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46D4087815; Wed, 13 Dec 2023 21:39:06 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C5087817
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dbcae1e53bcso3224501276.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499938; x=1703104738; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tuyBKCxx5cLKa18FbqS3xfJ8mC550ozA3sgv4IzgG7k=;
 b=gaBLj7zbIH5Es9GOXtJ9/dRUKrND5KNDqBRwJ+aPMl82OjibnmSnmBqnubZjhEh55Q
 /ADLFLRaMIFiN9/8IwiQnakFI8ZUJusYLsyydQWfKVw2rZroD70acOdJohoBVMndE7qb
 PtcQWzbA7vCbdRZrUay2VjMMklIEAG+0/qWHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499938; x=1703104738;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tuyBKCxx5cLKa18FbqS3xfJ8mC550ozA3sgv4IzgG7k=;
 b=lIUTwoNNORs7QcjLlyWdgahhiiUWZPKzQVL8uAKOGavrAInhq99b8bgrHolxUo6CNt
 0ji7Y2B++Oa5yxAbvO+USHobBLfAs63Q77Z4Mx1najn0558gmG2GSqu3JPZZN5LFvtom
 dCiB+H/bR2jTXOgTVRncqZZRfHkvSTmKhEqkc+LGnLMmMVcZu0FplU3qCCc01OyLPqGw
 tsJ3h1143EamU875lODjcEVzFUxMNFmJ7HBrMrRfgpVTFmJAtTtiEtpBwEx3ueEb551A
 j7nFbyB9C6+Ns6hkOQvMMhZ8fSRviCQDZ6zJ6OJhdoedx1pvmaF1b/dBa7mZ4ijSsjgW
 uciw==
X-Gm-Message-State: AOJu0YwFhqAW4crc9nf8tC9gCTLT2LS2fWu59/CrDTxu0quR5Z+zFClS
 GNu4a3mXE5omJnLI/LNNqBur0n5o8ydEinLz5GvPxg==
X-Google-Smtp-Source: AGHT+IFbzGtBCRDV+Kk3SVhxetqgcKNxZletBFQ0trLk0TRoTpKXVn0Tt9g00JBVwFo3XzNCv8vqGuEIDRkMc8r6608=
X-Received: by 2002:a25:abd1:0:b0:dbc:d1c1:faa3 with SMTP id
 v75-20020a25abd1000000b00dbcd1c1faa3mr1154427ybi.100.1702499938294; Wed, 13
 Dec 2023 12:38:58 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 14:38:51 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231211180733.86629-2-heinrich.schuchardt@canonical.com>
References: <20231211180733.86629-2-heinrich.schuchardt@canonical.com>
 <20231211180733.86629-1-heinrich.schuchardt@canonical.com>
Date: Wed, 13 Dec 2023 14:38:51 -0600
X-Google-Sender-Auth: 79tzB8Uq-EgCj-IX-X9UZo0WKB0
Message-ID: <CAPnjgZ1qLqAquXcbbE722-u+KsP92+wi-esAMG5rYkBq0pCOUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] test: fit: Using variable 'old_dtb' before
 assignment
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Roman Kopytin <Roman.Kopytin@kaspersky.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, 
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

old_dtb can only be assumed initialized in the finally block
if it is assigned a value before the try statement.

Avoid a pylint error reported by current pylint.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2:
	mention pylint in commit message
---
 test/py/tests/test_fit.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Applied to u-boot-dm/next, thanks!
