Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF651CCD1AA
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 20:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3A8D8334F;
	Tue, 21 Oct 2025 22:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XRNPtgLs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB05D832BC; Tue, 21 Oct 2025 22:28:29 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFA72802C1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 22:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c2917b92bcso280697a34.1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 13:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761078506; x=1761683306; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R265QFCfNPrbDDNK29JOj3mn972Ru5hRzt8lrPyzT0A=;
 b=XRNPtgLs86uDGNOtvcuQF2Q/ABWuqL3/F6fnDQuQ382bFpO/vwm2d8u67t9WLhAOhU
 NnWNOl4Qbdj8ickXEMM+eThnmmBn/7OOeUKIRmennKTJ7kZUg1pua7ssvVdhsm6L5h4e
 8I/ZkEbviWUHIFN2LNxxKdp00POlnIKpFwhdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761078506; x=1761683306;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R265QFCfNPrbDDNK29JOj3mn972Ru5hRzt8lrPyzT0A=;
 b=TIwBTmEcG4esNnRjHVULSe/S+vVk1rZ3F+mX5k86us1UJpox4vlTTDyMy0t8X6zCE8
 eN4RSFTut5qNbfvNTjOvDyhl1CFe1w/Y41B91tCqoOgoLGq5j+KZsbCT1vv6ECYOk9w/
 CTIBR3AB2QnuKFInafoqCmVJOdNajXEpPMgK4tr69Ny5QcfJxMnL5TMj57udhctvb5Ad
 GHzSRnLmJA3wgHqSoQFuDNAxFWXce9JgOTZZ2BLEMHPBiq6A6q6XQjgnx9wQgHxZi0M9
 3nP0C9L3tFYlo6R3KIpSJIbJsptQ9qVdSHsxH2bMk+FAZln4hMOj6RDc04ZlQkbR3dp/
 h0bw==
X-Gm-Message-State: AOJu0YxV5jHuCTrBtar7pgxdm0j0Xuw8K1YJYr6yhM4pdl8U160aF5iH
 0hAaU2EcAxCDOnYkWdqOPRTgh1+Y9b9tSms5DSFjSj3xPOv28J8IEOdj7exdw8vCrn9g9SYZmE3
 6zaWmMI7qZg==
X-Gm-Gg: ASbGncs090WqnZCA855u4TURMN8Or1ynY1RQhh9F/+Ex+6MSNVcOfiKaMuP8+TZhDj+
 OYfw0NA23YODOe35nPEGlvcmD/RiZdagpqFc0M3izgsxM6tSAnyxYcABSKFqmNlJMsFwlKO8noR
 6+y5csq1KWTzJ6FwXdciwFeeMrwZqfqFVJruApGJLoA7jvDduQTpA/6otjHUEsC29+H1DaHKHqB
 0B+z3rrgiSMknQcmYwA5XfIXp/muDWon0Tz2gVymwgL4szveBd8UOfUrl2gUx16BX4oX1TAYs2d
 aCZPirO8hVNuYuix8Y8FomfFH2WpsmKNptp/rZkNYBzMqSLy3uLUisnSrLeA2VCAioaWLnowDID
 0o73CtghSU5rPbUEY/MYsVG7Vk9M9EiavGXK1LxbGn47jMtKVmk1z2oiTgU+YiJ8L2Uqt6B4JlV
 mwz4ZPoDyuq+pGwsxJrhHLSFWBkNLGgj3Y2/XV+xWG36hs0yI9xMM9pFZq+hXimDY=
X-Google-Smtp-Source: AGHT+IHtm0ZexAK8RpWz+SqBNMpaFIKmSIl4lrhluWBvI2WPspdGCBcZeXuyKvfxmFyJjFpjxdBOQg==
X-Received: by 2002:a05:6830:67d9:b0:73e:a9f2:86f8 with SMTP id
 46e09a7af769-7c3e089dbfcmr595972a34.5.1761078506340; 
 Tue, 21 Oct 2025 13:28:26 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c2888ef0besm3930194a34.20.2025.10.21.13.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 13:28:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 0/3] doc: Add a general note about $?
Date: Tue, 21 Oct 2025 14:25:31 -0600
Message-ID: <20251021202820.1272414-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Hey all,

This is a small series to first add a general explanation for how $? is
set by commands to the cmdline documentation and second remove the
redundant information. The first patch adds this while removing the
identical (and sometimes slightly wrong or incomplete) information from
commands which had it. The last two patches remove the information from
cases that were not quite as clear, to make review easier. The commands
which either do something different or provided additional information
about what counts as success or failure have been retained.

-- 
Tom

