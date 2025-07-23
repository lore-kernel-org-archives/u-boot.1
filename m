Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BB3C83F1A
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 23:09:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B73C4835C6;
	Thu, 24 Jul 2025 01:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U+EuQTPO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3528C835B9; Thu, 24 Jul 2025 01:09:29 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 225A38353A
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 01:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-73e5792cb9dso190741a34.2
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 16:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753312166; x=1753916966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gm+0jQNXuEPbwuamMA06yZDxf86IWISqVDeBun6b+0k=;
 b=U+EuQTPOLt3NKndmm0F2yFzCq08+pOZckjsyKBeOiTReIRBP5QqHLFgO6Cb2kVg/4D
 Qizjm16PMNDECtKiLESaSBIiQ9cVxc3GzBPo+rA+QuOX+L99zN55MptZ2OpNDEBx4Uk3
 c0XRVS+5Jnn756dU4LLTDm3riuf6UED/nFLJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753312166; x=1753916966;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gm+0jQNXuEPbwuamMA06yZDxf86IWISqVDeBun6b+0k=;
 b=DYa8LIhbb4DdnAS6XP3eSpzRSSeNtbcf+Vl1WZOFEx2H/ykuwJy6tasUGcdzg4ZbLu
 vImK/i1ngu/yrLRKKZAKqoWLn6v08OzljuBr5QRyzfVyq/jusUE+6nJjS54ji48tSKR3
 Omez6ko7sMWQWJRegFXbRkfky4n3NQKpi9HxbOu5gTJalBf3K9mbQMuFBTFz4xZmVmaT
 kUCdHv1v9E7g62DpuVW3p+4soljOPgzKJLFa6vfn590jQl2vgtDnQ5BRoc6cYLg5rRnG
 57ksFt/u+ZZGVWtG0Zq3Dvh+M9bqZS5+7DnqUd2QIbLTFVrZUHPBsLGckRLJjfn58gHL
 kKUw==
X-Gm-Message-State: AOJu0YxrFgIO4aDehrZd6mH+Y8NX015i2AMpjUA8Ku9JNJrN31jgwtRa
 MrxBKW3hk6tDArMj0tQVvIVI3NwpfXwBwhgG/qwWEtUX3Kmw6Dz3mnCALw6YyU76jop7PBhFFuK
 R7cLlSS4=
X-Gm-Gg: ASbGncsWGv9fw30Z7FJrChYiN4a7MQF9PgUJYxcni3E20w5SASdtuYB/DE4Obuh71YX
 se84OdpVtM1s5MZACcLi4gaHlpP15RgMPCefW+jGzjnJetjzCTuVTVLgQqdBgWLcrL2OwWyPV+R
 7a4KMAs3YR0IX4KX6B0iQFYJvJdc+p1a4Pu7bxa99YT6uXH9rRD2ahhIPY45hxyUkrmlopJrjFO
 r3zbWl46JrcoK0YhSs97wXQ8I59KheSWf+/5lbApMmX6HvlqN9KawHReu3PTrbTQLI+EsmrY4oA
 ZM0Z9r1CjUqrTAzfJs2QBYV5oSWUTBKN+XhgpCYLPFu4Az5gX8kH6dXh6hU6HjWc3scFkKY/1de
 iwqWKZk50xj+xE4xbcsAOShqW+Cw4jrVuvW0mRFpWDoEaNNBxzxlhWww=
X-Google-Smtp-Source: AGHT+IGjX+/pdl8nGeTOgj0iqVqw6r1FdUz0yLVMysx9BIrHcEVfipemO+zltkm8fbze4gFKzjG3QA==
X-Received: by 2002:a05:6830:7104:b0:73e:93dd:1f56 with SMTP id
 46e09a7af769-740889b3519mr4168760a34.13.1753312165791; 
 Wed, 23 Jul 2025 16:09:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7412d0fa63csm52693a34.10.2025.07.23.16.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 16:09:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250723202724.228868-1-trini@konsulko.com>
References: <20250723202724.228868-1-trini@konsulko.com>
Subject: Re: [PATCH] Azure: Temporarily switch to GitHub mirror of
 u-boot-test-hooks
Message-Id: <175331216444.248145.5744635768526280815.b4-ty@konsulko.com>
Date: Wed, 23 Jul 2025 17:09:24 -0600
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

On Wed, 23 Jul 2025 14:27:24 -0600, Tom Rini wrote:

> In order to unblock this CI workflow for the moment, switch to using a
> mirror of u-boot-test-hooks on GitHub rather than source.denx.de.
> 
> 

Applied to u-boot/master, thanks!

[1/1] Azure: Temporarily switch to GitHub mirror of u-boot-test-hooks
      commit: 71c96a8b2ab0fbaf49e7e3fe0623e5065bb3400a
-- 
Tom


