Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25881C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 22:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6012584ABC;
	Tue, 30 Jun 2026 00:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RbeJcbZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 263EB84AB9; Tue, 30 Jun 2026 00:52:28 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 344B7849FB
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 00:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CAB373F5B1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 22:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782773545;
 bh=HFYL1/tPZ0jrE+6+lCoz9yXdNDL5WWsyxyV+absiiN8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=RbeJcbZIrPAQrE8Bl+3Mbn1h3YkEHTQJKnTaGdOYVsG0uMB4q5jd/53nPAJpO2fBY
 cOylBJpOd55ScXWEpSE8tScmN2aAtBi4NGdLPnORSF/UbWOAn/RUmOFie4eO+0xf/v
 czYlckTBeT+n/ZyUankP3suheWPyH2WXy0kBNHr/87BUeU1hmxOdlIdG7cdKWcFIHt
 HWgQq1vy3nvsJcb4vfRd5izboiWiHsNk7zc3R61G8/7//3S4dUehs44OybqLRLWTra
 3vLWEGomoXxhjMIlnODI7UeImRVWWRCC1p/GYbnYSgBqpw8p5IuDA/9guG0dQqr5BB
 qP7Ctt1a9ejD3WnCt010cSYBMQOJ1KXhS8F1Fnt+petlE4f0OkNuJlLwH77HUIVIGf
 h0bi02vTjCW9nptYkiuIkRhQebZjeu/XpwskMh1o+bJaRnqtPb72v5sVf/1GFaqspv
 GuRnhwzKtg0NSYuwlinSXjnFm/7U2jgNmTo8c4iyjpaSRC68ha3qDy3mvWuhQ4zMO6
 IsPmH1YcB23DXzqYxX6d+8r2NjT1cuaZsaaFtZ5CEaZAMJZ+1rwfS2POsOcx3qS/IV
 ke6JHLGUN6SkWlKwdpLHmeZwd3ZGjXGs9SrLBDh7ar+sSTQ7Jd41fvQIBsaw7sxDUU
 hT9swklyRa9YtImwAlQrAjk8=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47416fc1674so900506f8f.3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 15:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782773545; x=1783378345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFYL1/tPZ0jrE+6+lCoz9yXdNDL5WWsyxyV+absiiN8=;
 b=jjXIGPC2QwyCaNC9FlWvKqlik1lKxgV6NeRFjWWMA7674YoPcW3mwoWArM621QLmYA
 eMAzmc/iSvCDd9Omwwa1MZdOL4c4zH3WRpDfjoSsMIM7EfNzf8Fc+MG5AEsEDW2fQ8rP
 BoqzrLIAMyLa62rbvpxfWaM+gFiyDOzkJGawo7HzTFOXnKYAf0gvenwe+qhVTTcEwZXD
 NdIvEa9pyfA9nKg/1Pi80Kd8Fi0rFBryuqAoSJJdmdwmoryQXo1+G9DusL21brDXn3dy
 bVA5mtnDQnI+02oEPAeis5FqIjgshvcU9yF+FFSOJHCozfZ7YHW3r/gt78Sy+fhDsES7
 /Qkw==
X-Gm-Message-State: AOJu0Yx8fgH98haN1hdkWDCMYs9R4ElTcIo29RhjoHdt5ld8lIl9bSak
 gMlA1cOZxiS4QCp2LQBlfGRFI5NbzUMx+e+YTrYrZ7bht/rmQXwu8AA27YiJTtaZd04nPII/u0R
 oFu48H+hvL4eE/7b9CGZZo4pAGCdX2/fyRAW/GVrSSA9cFAnCURXgXSteijdligzv67Dasgw=
X-Gm-Gg: AfdE7ckOxqLByBnE3shGl7eIAhdNPchYZEaLISmFs7C3w1B4siQiFt4cjrgH4o0eXx/
 HzAWYqNXVptsI0a4pBMqvNDojMRmvJoODjUumsEFmt5FXx8WVxVIgegLCZDZIY8XB+ucxXQNwyM
 uplmRvED9LQrp0CI8bQhd8BbQ0zcrAJGOqOL+JL2sXHZSURMDlbUcvOHIH5QGx1Qaz3aH3f5wgx
 zwQPWBlzZZUYe9BcCdqwMEQhzvA0YdPOk40ZbvadAQmyXxeTo/Kgf0c1XlNG6kYFLOJRVN0+LLp
 2aFkVdnE2XuZu0E6Wizyz7u0S8q43ydXLH8CDNcOrvyQOt4a+yE6clMCYeX+RQy5wruJxquLMju
 fpF+/3TDwTLsxelU5KVt9J0mSBurmGB3Ddj9WklAJMdMfhQyB2RWeqSgeBjk4s1c+qQ==
X-Received: by 2002:a05:6000:4687:b0:475:2171:abe with SMTP id
 ffacd0b85a97d-47552a6917cmr1166977f8f.35.1782773544947; 
 Mon, 29 Jun 2026 15:52:24 -0700 (PDT)
X-Received: by 2002:a05:6000:4687:b0:475:2171:abe with SMTP id
 ffacd0b85a97d-47552a6917cmr1166964f8f.35.1782773544594; 
 Mon, 29 Jun 2026 15:52:24 -0700 (PDT)
Received: from workstation5 ([2a02:3035:626:ba8f:5998:4d02:a4c4:fa47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47563d194b0sm1965194f8f.1.2026.06.29.15.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 15:52:24 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] efi_loader: fix efi_sigstore_parse_siglist
Date: Tue, 30 Jun 2026 00:52:16 +0200
Message-ID: <20260629225218.209368-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In efi_sigstore_parse_siglist() sigdata is allocated. But instead of an
allocation matching the size of sigdata, tainted external data was used
to calculate the allocation size. This may lead to buffer overflows.

Correct the allocation.

When malloc() fails for sig_data->data, sig_data is leaked.

Free sig_data before jumping to the error path.

Heinrich Schuchardt (2):
  efi_loader: fix buffer overrun in efi_sigstore_parse_siglist
  efi_loader: fix memory lead in efi_sigstore_parse_siglist

 lib/efi_loader/efi_signature.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.53.0

