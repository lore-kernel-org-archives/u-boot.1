Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17007C5B561
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 20:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F0783CEE;
	Fri, 20 Feb 2026 21:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UZqyNR6W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4369183D8A; Fri, 20 Feb 2026 21:51:22 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3045483CEE
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 21:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-45effa36240so1512953b6e.1
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 12:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771620679; x=1772225479; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BlTzpqsFZYy6ko2byH76fY0FhSmmSbxl98Toi371gQw=;
 b=UZqyNR6WKhQk1ZoIbuPN/SAQS91Qt0L4LkZM8tjWN31gQpRDT6vHoQ+Jhi2u4pjCUP
 9+B7XJzZrxYQ5YB84EhxwbDKMn4m0+QPFCzQy8WtuLpmSyro0l/pWaQy/jvnGVxQRKcd
 2T2Ei+e4mxmyBSc3Jow6pw3Go3tZLGQht3jUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771620679; x=1772225479;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BlTzpqsFZYy6ko2byH76fY0FhSmmSbxl98Toi371gQw=;
 b=d8IAmCxhZLpjVBfq0U35kvihn1mm6RkESs5O/h2wiYQq/WiRGsZvoHKFkpaEtrfRj5
 18nSz43onmeE1ed3MQxyoqxRyjCeGURCqahCGbk7ySWulTeTv+qho7E6uK34qDByKjC4
 1Kaviyl/wVfYhtGLdzVPTR6MzRZZ4Ohjkx5ffXxKC8b2uLDhFXaS1iAaLDmciyqCzZMP
 JPKT8Dei0vw5DDwm8B8/0VGN/ikPVBkYjNAxeQHoXrG/X9EnkAYcvnfPbEkQG/mVd/jY
 AKNsRoUodUt/mtrCX6iR2CoggTAFDS06trEFuN2ruq+Bauvs0F3vSiSAUfwpKQyBYYLq
 dLew==
X-Gm-Message-State: AOJu0Yz6kFWpZEoe+e3qz3venpCIjhwdPQZXZHndMhHmj0E8KZkK2IUb
 POzVvcUNxPz8hMjGHn2cig9rzLS/RPXwZDHiFVbjzIpd7F/v6BQ1O1ahBCaQO/Q9p98=
X-Gm-Gg: AZuq6aIm1iqp3DvVLkSY+Qd5zPmg7Hw8yVXejGA8p/2kuE9oOyyatlkug6Xl5myKZfa
 opCpgCACLbYrZxT0H0ut80BO+eQ0bBUbzybwyGMqU6WbUQUqsbrOjc2siEpsK0zSbXG1dfkS93r
 W8iaSwFwS+fnqnxdTIS1YaaC9OrSTSRj6N6yTYRYoIFeoOpzujfnTU6XxgSZFq4aOHA7CiZgRkd
 Y7x0R2vFX4FDg3Ss1TbQ6gnWcPDRS8ilV+5mo5GN2RyseJn1nEdov4Gdub6P44JjqkM7cksDKyJ
 +WVwEMWxZvF2tT2SdorBI8dAZsRd/Xo7DmV2XXeKSqAXSRcEuRfa7K/st3+R7WXslnVJgUeenHt
 fqr7HG9wd+XhcDuUfE5EFiC9cvApdyyt8sUK7NllYOerZbhkfHCsCk/aYWvoiP/WDBelb9pUZ4b
 G9sIJH49CcwPCMXD9J7eLR2miJ6C3jCI8HX9RbM+BCbnQL/88wSeGuHEXBUw6UGNZ8GOGoOJplX
 H5pD1ovlLiskMgkp+DhDy36UyApIlZtVxcEMSCV9teklCsh+Q==
X-Received: by 2002:a05:6808:170c:b0:463:f9ad:a4cf with SMTP id
 5614622812f47-46446226ac4mr802320b6e.23.1771620678834; 
 Fri, 20 Feb 2026 12:51:18 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cfed28esm525818fac.9.2026.02.20.12.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 12:51:18 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Heiko Schocher <hs@nabladev.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
In-Reply-To: <20260205191631.3488262-1-trini@konsulko.com>
References: <20260205191631.3488262-1-trini@konsulko.com>
Subject: Re: [PATCH] defconfigs: Remove default COFNIG_SPL_LDSCRIPT value
Message-Id: <177162067792.148229.5497627872897790014.b4-ty@konsulko.com>
Date: Fri, 20 Feb 2026 14:51:17 -0600
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

On Thu, 05 Feb 2026 13:16:31 -0600, Tom Rini wrote:

> These three platforms set CONFIG_SPL_LDSCRIPT value to what the default
> value for the question is, once evaluated. Remove this unnecessary line.
> 
> 

Applied to u-boot/next, thanks!

[1/1] defconfigs: Remove default COFNIG_SPL_LDSCRIPT value
      commit: 2a86d872ecd85022dd43880bd7f30d547cfb35a0
-- 
Tom


