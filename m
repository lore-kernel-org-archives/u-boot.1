Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C0FCD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 22:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA89384987;
	Wed, 10 Jun 2026 00:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ugqZtMcd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85736849E0; Wed, 10 Jun 2026 00:28:30 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72F13849C9
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 00:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-486d0e175e9so1757123b6e.3
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 15:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781044107; x=1781648907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R1LMlwMqevi2AhAeClzMtY3o6aAnAk3fMZzZQVcVudQ=;
 b=ugqZtMcdxCMHp3hzUfDKr0ocpHvKcguCtXJfeTfhemNAwKsLs05tDih6Y4Ql+ujQ2f
 QzxFz8NhbDYckB9ts8zSHUVDhuVaxI4groLFS8WAj3ZFmnDpD8w2jYfCpyf4edTgyXAx
 erwfcKsBbpK0Iwqf8zMO2E0XqQm9/yE9wert8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781044107; x=1781648907;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R1LMlwMqevi2AhAeClzMtY3o6aAnAk3fMZzZQVcVudQ=;
 b=pYqfId1OZ4UuSRB0ACGY+T9qgkiU1xnFQOI4yEGRcDWFIES4eeAklzf9BVkQsQY1GI
 kEtwiNB9cNsK48JJ91rIS9i2foAJ+/uw+QfbwitER5fk5eTuD0w0eoD77r/UvZ6e5t9E
 3NOBzxIxv9jHr723sKCSlFoSmOpSrp5OhXeM7Ifkyf2qEoeo+5fi33NaIxcT1liRXLTV
 71hdA3zAQyLiTFydlZnf3ySXsTA2yH4VkaUuft7kvN9qQXCtjxtWnw1D0AH+YwImnbV2
 L9PJ5nVShWfh+Q6DH7DXvuhPhF76XyzgkCtdSJ66pxrZWOEqGnZIHU6lNttfSCLDaJw/
 4C9A==
X-Gm-Message-State: AOJu0YxVGC0GREO3cEJvBJqtLYDsUGRw24ZUnKVEfBJa5mhxrsyEQpvP
 zxDULK+TjO+7aBuEHbh/Y10wHBgfSNrev5lh8EGWWT/m0MTKhjDxNYq5s8/qXLvOrH8=
X-Gm-Gg: Acq92OFfr/oysrR0p4zQrmAwlYsJMW/T+5vo8rH+7HleW6gyTKB2lFrsdMo036qfxk5
 HoUlZrvJZa3CBVPLivshkKM3c1W549AuMeF+17Z9A6c/dEOfGEF9fpfsPBNjacf0iyo9p2UOenP
 p4aVEhD44KEtRz0Ku7gWmLt0vPw1nMJbjd34rT2RcTdrpf5ytYI9fj/q8d4FjPsyVVipzdKlT7C
 C8CFarDDfTuuKtUVctpzwrttEyaXiFfL/TahMHFS+BbRSwHd4O18iL/mixB3jKSlNc+20ssOByY
 IKVsfxMmL+Pimda281xor1kLbsBaobGP/3rqLFfyveg1Ze3toDAo3wR8drGNHjjch0Ekd/Ji23m
 REw2jUMDlL67ExcUENeljFr6EpOjVKMFYShOzfwcySe31n/R5NF8DDwTZ5UxrhUlJRf9UJUveCY
 OeFzXtJkW4y9YwyXvGAZqsC1e7AwjThWUxySxauEvI5yPagc0GH29oqUFrsG3cUU3F24M/27kbr
 Yi6vIFoNP4W+ExN3N/j+MBB8Z8zE7ZMpgt+fEFDophcu/fyKZXP6DdCb7PM+ObA/lI7uD8=
X-Received: by 2002:a05:6808:2388:b0:486:39db:ebfd with SMTP id
 5614622812f47-4868defdf50mr13356342b6e.33.1781044107172; 
 Tue, 09 Jun 2026 15:28:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b7ad946sm16790962b6e.8.2026.06.09.15.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 15:28:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sughosh.ganu@arm.com, xypron.glpk@gmx.de, peng.fan@nxp.com
Cc: u-boot@lists.denx.de
In-Reply-To: <20260526075218.2801329-1-peng.fan@nxp.com>
References: <20260526075218.2801329-1-peng.fan@nxp.com>
Subject: Re: [PATCH] rng: rproc_rng200: Use dev_remap_addr()
Message-Id: <178104410623.79918.11728726934755506979.b4-ty@konsulko.com>
Date: Tue, 09 Jun 2026 16:28:26 -0600
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

On Tue, 26 May 2026 15:52:18 +0800, peng.fan@nxp.com wrote:

> Use dev_remap_addr() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
> 
> And only mapping sizeof(void *) is wrong, RNG_FIFO_COUNT_OFFSET(0x24) is
> accessed in this driver. So dev_remap_addr() could also fix the mapping
> size.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] rng: rproc_rng200: Use dev_remap_addr()
      commit: ebb9ee6ef48015d58a08ed8c8e21ad4cd4041e2b
-- 
Tom


