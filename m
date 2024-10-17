Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18F5D2F7DE
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 02:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDE2B88E43;
	Thu, 17 Oct 2024 04:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PPjTSNqk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F10F88E3A; Thu, 17 Oct 2024 04:22:41 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FCD788C3D
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 04:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cbd12b38b4so3326456d6.2
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 19:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729131755; x=1729736555; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w9ckQL7yDRGJfEikVGLsriwID9gWl+eHX5nhDBUBl/Q=;
 b=PPjTSNqkHfQ6caF18gasygspCOMe8ak3o5oVC/IucKPapcsHdkLgi+w8mGxHH+mH88
 0WQtx+J+BQJAppoDr3oXENK6ZLZOKHVvxuoYFj5idR4nKYdND+ed6SuD6zEY/ntrmEeZ
 thmOHQTW14K03d9ocs5soAhCeuhjxAqICc3EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729131755; x=1729736555;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w9ckQL7yDRGJfEikVGLsriwID9gWl+eHX5nhDBUBl/Q=;
 b=cKv7zEO/rPiDOkOQu8J7KGYEOTh2Xho2yE6sQBW8YHuNBy70HvPdP+Y4HnMVy2bNC5
 3lP1IgXbSp5O71DCaBiHsROFMdWu/Kcwvv1Qk4kjtTJJx/3FdN+TcP1dKBatpjRmjKyZ
 0jXJaOiygvgEseZ9jHz7+YcEMd695en7K+ndO5t/Br9Bt7tFmVEVzU1wTtdoihr/37xS
 fqzn56738g10IdXwRYWW8xgYnGM9hs6TkOU6hOGdeuVp6zjdi/qFPLnLSqqf4oU+9jwj
 DpNa5tx5HIUvA1/FyDm2buRRYquXu3DtBD+uIr/25Jz5OCCgYNKEEr4TSfu+keWiuVwH
 ufcg==
X-Gm-Message-State: AOJu0Yy5W6/6mYu6rbJgrciHJbPNJGUjUvt0duWFth7cQKyCrjDGIjpJ
 IahfSRERMSnfVSAPOqvbfhX4pbpMp/M368vugVhqR67CNvvoelXirbMfURO8p+Wts0omy55l+7u
 vTU4=
X-Google-Smtp-Source: AGHT+IGUuLjSiYNBYLGVPd9gsahhLbmxrD0e1ZBXYg7oO3FjcUP/a56tJEon9xPmzS0vMNsfnCp8CA==
X-Received: by 2002:a05:6214:5b87:b0:6cb:e944:c1a9 with SMTP id
 6a1803df08f44-6cc2b8dcaeamr77122186d6.31.1729131755365; 
 Wed, 16 Oct 2024 19:22:35 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc22970aecsm23742846d6.132.2024.10.16.19.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 19:22:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: Stefan Roese <sr@denx.de>
In-Reply-To: <20241003141029.920035-1-ravi@prevas.dk>
References: <20241003141029.920035-1-ravi@prevas.dk>
Subject: Re: [PATCH 0/4] some serial rx buffer patches
Message-Id: <172913175288.51588.12683780767118459820.b4-ty@konsulko.com>
Date: Wed, 16 Oct 2024 20:22:32 -0600
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

On Thu, 03 Oct 2024 16:10:25 +0200, Rasmus Villemoes wrote:

> Some small improvements to the serial rx buffer feature.
> 
> CI seems happy: https://github.com/u-boot/u-boot/pull/674
> 
> Rasmus Villemoes (4):
>   serial: fix circular rx buffer edge case
>   serial: do not overwrite not-consumed characters in rx buffer
>   serial: add build-time sanity check of CONFIG_SERIAL_RX_BUFFER_SIZE
>   serial: embed the rx buffer in struct serial_dev_priv
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


