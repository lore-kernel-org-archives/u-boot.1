Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB22E7C4E7
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:05:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 870438766B;
	Wed,  4 Oct 2023 19:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gI/Ea10m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79A038764C; Wed,  4 Oct 2023 19:58:50 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE2738762F
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso22599966b.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442324; x=1697047124; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qMJLO/17PQ1kX5E7ZOwsb7eW5CTU09uTInZmz5giYz0=;
 b=gI/Ea10m70M4IlB0V062ZGrC83aLxBgKHhHmTYqbUju8Tzw02DG0bIOaQda5GtX+YW
 Kcxn3qrvbXZ9dXxKFNywO7CjYAWmhMmvL4b1A6T/Up4rdMOOE9JOBYbKXaenVjs3JMC3
 rKGEwikLOCHaJEEhGAM6HoO1nTBMKc82Mh0wM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442324; x=1697047124;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qMJLO/17PQ1kX5E7ZOwsb7eW5CTU09uTInZmz5giYz0=;
 b=QpAPjYO6R5Co6GWJ+cUYVCWYJv/5wAysiM0so/fEErhYyv5WqnnMKf0rwIvFF5AvQh
 6HWGh1b1UXqoCD3TbGl3egga/n4mZWXbSVNMG6HG+ZlhPdjpTPO5DhlJnN3m/M5ZK1Ez
 2kVzxmiyMlUZgJd+aQuESYl7qX1l8I3jvQYNEM7bds0o22BCME72e/ZUaycsOeyLYtY1
 RFAhJ7dRdMP/DbWLVVPj6RySFVxrchxc3n9hgPjTGD9e4gSWAuSLhx3VnrgTczr0AZdt
 RgVrzKufTrBCCSYK01O9ImDe1oZ5NjLjAi1KqZH5MQVqBDL7kCMv1bxkSjtCnT0AfzfU
 L2pg==
X-Gm-Message-State: AOJu0YycapR1W3bx48UDfVfoURVHp5h7dQ6rPKaDteVoCv/huGgd3ESY
 4fLcFfPM8+Fbyt4FmKFZFxK+1Hgl18U2Sr6lHJ146qOxhklkzaUrPA0=
X-Google-Smtp-Source: AGHT+IGUXki/o5e2wOLYSNjZFfyaCEYXjXUp8GZ5wO0yra0hUq9AhkkL6Ah/yJDX9feYg9bLOd/ztg9cCw7jz5aV+2o=
X-Received: by 2002:a17:906:1011:b0:9ae:577b:caed with SMTP id
 17-20020a170906101100b009ae577bcaedmr2937386ejm.26.1696442323968; Wed, 04 Oct
 2023 10:58:43 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:43 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-8-sjg@chromium.org>
References: <20230923194424.1739224-8-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:43 -0700
X-Google-Sender-Auth: rSo-pUD7VeklPuFfUASAeZEyB_8
Message-ID: <CAPnjgZ2YXc56LK_PUfm05jp1ysmrvDV7VZE=Y9RVPG_A5yy4eA@mail.gmail.com>
Subject: Re: [PATCH v3 07/27] moveconfig: Drop suspicious boards
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

This code isn't needed anymore. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 25 -------------------------
 1 file changed, 25 deletions(-)

Applied to u-boot-dm, thanks!
