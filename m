Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB99C47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 15:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6099E87C17;
	Mon, 29 Jan 2024 16:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X1YQeMmJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7B3687C17; Mon, 29 Jan 2024 15:57:33 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DA3687BDB
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 15:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=darko.alavanja@konsulko.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33aef64f702so537829f8f.3
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 06:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706540251; x=1707145051; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvxPAtgzmB3FPqY06g46XG9jICgijFzmQQw94M4Y32o=;
 b=X1YQeMmJfqZd2qugHmJKmgQRq7TUZvJeAov/gd4X17LSGdPB3WcXTyVNBHulqwOq6t
 j/SqMTyA7oPQa9VF0asXQ/qiQP3VhQgoMBRGuHlHyoVW7pZL4/KlNGq/f7EXKKl/saUp
 xBSReM9oUu+9q9xpqtPpvIJHFhYv0Nu9I4sD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706540251; x=1707145051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bvxPAtgzmB3FPqY06g46XG9jICgijFzmQQw94M4Y32o=;
 b=LTxNJt1nZLJPwtJMCEYvLXRx9Sp/69KyNcXnuc6DQVTNspvKQpucr5bpRiXWZmYr0f
 rEOh94QqV2PMR+uJYEIU1LfYpWRQYfTxQ2uT8l4hzh8DYpbnjpBOQnqJM28++zbUcO8w
 6Rm29ba7zTV4qYJpuz6MaZrlhrNuQpFED48IN4j3xKNUGJz7b4bzyaPpqsTSnW5ehUZY
 AFYBZMtd4lE/ZjG9yS3qN/6iiPdgOIeVfhKLT22/uvz9zXfvgGJ49+1MBdxNrM+lBlAt
 swsBjyg8kZlYkHDd6SX+5MTc1J0URiX0O0quT0mapuCjqbwOGQPXbeomLo3pAeGXsrwD
 Lc9g==
X-Gm-Message-State: AOJu0Yy9mpre0a5nLAGADsmbdkpQOekFCRUyvgndowKG24B0y9bVor9E
 2I3JTGWcgmwVcYp2j68pTi/Pd4C0JlGe+MrUz3j3tO4hlwRIhjujrKCJZEvLec0=
X-Google-Smtp-Source: AGHT+IHDFBQfDHV/Z/47Ldy0J25dKojPPvyvCsOyIZib5WTS+Mm9ZY/kDUS/evVyhACetcyHZIPgug==
X-Received: by 2002:adf:ca84:0:b0:337:c4b3:e03e with SMTP id
 r4-20020adfca84000000b00337c4b3e03emr4009843wrh.1.1706540250901; 
 Mon, 29 Jan 2024 06:57:30 -0800 (PST)
Received: from darko-X470GTN.. ([109.245.193.195])
 by smtp.gmail.com with ESMTPSA id
 ay13-20020a5d6f0d000000b00337d6aa3912sm8303868wrb.10.2024.01.29.06.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 06:57:30 -0800 (PST)
From: Darko Alavanja <darko.alavanja@konsulko.com>
To: mail@jens-maus.de
Cc: agust@denx.de, dmitry@bedrocksystems.com, fitzsim@fitzsim.org,
 florian.fainelli@broadcom.com, iivanov@suse.de, jh80.chung@samsung.com,
 mbrugger@suse.com, pbrobinson@gmail.com, peng.fan@nxp.com,
 u-boot@lists.denx.de, wahrenst@gmx.net
Subject: Re: [PATCH v5 0/7] rpi5: initial support
Date: Mon, 29 Jan 2024 15:57:29 +0100
Message-Id: <20240129145729.3112809-1-darko.alavanja@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <68A667BF-F7BC-4ED8-919E-16B2CB406369@jens-maus.de>
References: <68A667BF-F7BC-4ED8-919E-16B2CB406369@jens-maus.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Jan 2024 16:00:50 +0100
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

Tested by: Darko Alavanja <darko.alavanja@konsulko.com>
