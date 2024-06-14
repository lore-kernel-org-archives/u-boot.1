Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2D9C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 16:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56324889F6;
	Fri, 14 Jun 2024 18:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QZMpTndv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53C6188A11; Fri, 14 Jun 2024 18:04:32 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3734A889F6
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 18:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f6f23e9377so2019245ad.3
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 09:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718381069; x=1718985869; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RE16116MpUtQmd2l2W0OjZYSKoU3LIFPTf8RmOZ/eTc=;
 b=QZMpTndvz9C1n2R7FhUHKRXBHuCoW8UALiFKvyxm9ugoeg3mlus3PfbiN/qIkmIDUC
 /FrnftJWs3/wa7V1q9KxD+fJ7AqgzVo2zUW7BfnK7NojcFojxcT1kTX5OMxRP0ldF9IK
 MNX8clhA1hyPoAO1sXiqRyLQGkWpsSWYYZ5m7pRxL37kBzDXefZw8U00DwibAqucPJTp
 KJLwsP0gQhJMdqehOKyRfPWib9jNzNZKVBba8neorIeVAJ8O7KS/+qgEO08qV10GQQ8c
 bMFgt4s3a7Ia8C0NcHWeOVbwMbyd+7ngD6FtOjzStPbCxO+ySxsZU+WZFA6PwdbOR3zj
 D7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718381069; x=1718985869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RE16116MpUtQmd2l2W0OjZYSKoU3LIFPTf8RmOZ/eTc=;
 b=FRy4Q2AWZH7pXb8VBQqAXd34Fw3RaLM+B0edXANNBfSJGIlFbf1c9eMKxuxPM4j2Kh
 D5KLH5095k5XzpoL4Z+T52tfhdl5NwnIJ9XflcZ0BA13lO+kyeS0gQjhGkBS9Sdlq6Uf
 veQxxq9GouTmwZvQYDeZbDg2P+IIEerMBPE2nObcysFWYPE1t4sSt6szuDLT0TOUs69+
 PGEEcMccEsRwjAWw9+gn23fIbaJWrtbphiQcvxFeVqQorcZRbyBUwFp/58EQsMghwKDr
 W+B+mo4IKdFq8UkJ9G4AbyFt9nnp4ABwxjlr9j8rgy6Cj3MsBd+xeCgbeBjXK7jIKcZo
 em2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC8QBTfBh+PTBkZ+nl7Hlskf8RVMDvEELtnCo6Y55hpXxAN5hxXiphGljg+k2Mtz5ow3cMmRfjiHEk/6AZqPaj3gGnDA==
X-Gm-Message-State: AOJu0YyZfBDYrA/hlHupnIa5WO31VbDn6JUKgm9zV/zETHjMgF1LvkB2
 +WYotcEU+g20yh72X+uGvVpR8c0ogU96siKf3kDKfybbvzIjw6pQP3I1Hgeq+NvOBUmnL3YyGc7
 9DZsZcYe9VKO17m8O3Pd8Cub6lDwafg==
X-Google-Smtp-Source: AGHT+IFH6E+nAORqFyOoV0TwpJq7eS4qqkKRjbBNJ4mKayVIq27ti6Y2GSkW8ql8CmJgKuDKJlv3pl3MqlNREIaCR+Q=
X-Received: by 2002:a17:903:2283:b0:1f7:2576:7fbe with SMTP id
 d9443c01a7336-1f862c39e88mr32174015ad.5.1718381068654; Fri, 14 Jun 2024
 09:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240610063842.192786-1-michael@amarulasolutions.com>
In-Reply-To: <20240610063842.192786-1-michael@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 14 Jun 2024 13:04:16 -0300
Message-ID: <CAOMZO5CaaBBdzYw3vvuSHA4iiSdf7o-V5KSBExomVJf5miim2A@mail.gmail.com>
Subject: Re: [PATCH] board: imx8mn_s2: Update timing with production one
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 linux-amarula@amarulasolutions.com, dario.binacchi@amarulasolutions.com, 
 patrick.barsanti@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jun 10, 2024 at 3:38=E2=80=AFAM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> The timing upstream was wrong corresponding to the production.
> This come evident after commit b614ddb5d33
> (ddr: imx: Save the FW loading if it hasn't changed). This
> change fix booting from usb
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

Applied to u-boot-imx/master, thanks.
