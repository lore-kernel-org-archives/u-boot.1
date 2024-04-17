Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E69C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 00:28:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB2B588442;
	Wed, 17 Apr 2024 02:28:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oi6Cnuvq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E9FA88458; Wed, 17 Apr 2024 02:28:36 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38DA98836E
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 02:28:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-78d68c08df7so388472185a.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 17:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713313713; x=1713918513; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+0ILMw2CxMoGiQyh+9dhBKk6nONBZ5F23Fli6rQcNU=;
 b=oi6CnuvqYqtjfoLloz6O3pxrVqEaSQXy8ivsvmqiywjfIm1cnmk+tHEQu40ioJdmxS
 NwkUIXoMs/fVpQhC4NDp0aGBjyqsFUldH/v8LzgU/W8/GIe8cxaCF2tLh4eqt5PxAN1S
 6T9fMj1j+9TwGrre5yWoOglqsi94PvYZKCamA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713313713; x=1713918513;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+0ILMw2CxMoGiQyh+9dhBKk6nONBZ5F23Fli6rQcNU=;
 b=NThWYrb9GnCKiHT/G1Gi823IvEOdSbiaMHuoekln9SGhLxL4Rf1wy/V1YF25M9tQMt
 JNGUh1s59vc4bdZpQsnG6La2bLIW+MYKhs3w4ifrPKC/1nbzIvqPsSNA9NQEyzv8SVTB
 gKqEsa7FBH9kJp+dKqdDdGejAw0N2VeriPBH/q3siSdR44PQHsqonoLU+GQFu7BLR/zf
 42W/QTGvpQWT1+jcwpqREktQWT0sMPTdYjS3PY5Egj6S4XIAnBe5Elxv8ki6rqI04opR
 Cja3D8tH6fRUBo3X6rs/38xXST8WhqZwv+P2I8/IjCvQi3MxIE5Ck0VCq0IT99ZIRXSD
 8FtA==
X-Gm-Message-State: AOJu0Yz8YVFVVNK0S42tMH3c7msmDs5tqDKLripGyyI3QgSYpFZDAQAO
 XfzN9dtJSiO3bVdvnJbjQtseykss+Sfwh7IpRrWw8n2pcAwkVlIHk5KxxFvUfg0=
X-Google-Smtp-Source: AGHT+IEofA5xTWUyT1drhhhPPE2F2z7kijb+7J6UYTagJSchei/7KYPwnfQ/HajcAFqlRvD5EJhMOQ==
X-Received: by 2002:a0c:fec6:0:b0:69b:7c49:1f92 with SMTP id
 z6-20020a0cfec6000000b0069b7c491f92mr6940330qvs.59.1713313713170; 
 Tue, 16 Apr 2024 17:28:33 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 ec7-20020ad44e67000000b0069b61f8c0a1sm5389607qvb.42.2024.04.16.17.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 17:28:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240414104607.5966-1-yasuharu.shibata@gmail.com>
References: <20240414104607.5966-1-yasuharu.shibata@gmail.com>
Subject: Re: [PATCH] net: wget: Support retransmission a dropped packet
Message-Id: <171331371210.1158061.11502677175905522903.b4-ty@konsulko.com>
Date: Tue, 16 Apr 2024 18:28:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sun, 14 Apr 2024 19:46:07 +0900, Yasuharu Shibata wrote:

> The server sends multiple packets without waiting for an ACK
> by window control and if some packets are dropped,
> wget will return an ACK including the dropped packets.
> 
> Following log indicates this issue.
> 
>   wget_handler() wget: Transferring, seq=97bbdd4a, ack=30,len=580
>   wget_handler() wget: Transferring, seq=97bbedca, ack=30,len=580
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


