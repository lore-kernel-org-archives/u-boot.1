Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABF9606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s5x2/uBx;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JugSn8qy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4418D80E50;
	Wed, 28 Oct 2026 10:57:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6TYUf_9yu47N; Wed, 28 Oct 2026 10:57:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6591680E2C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793185074;
	b=dnBQFPfIqBPqQ3wJsnb0J79ji10AQuClQqOjr7PeS60Sl7xpxgvFZVAlNs+x3xEIvFxh
	 Fp51UKKoVbSa4uk7g3KDp6/B5o3dpla2HoisxytwxI90sSwtJfn2caGpIgl8874qfh3Hg
	 XeE58hXu+uaUg+KQXRiOtAazUGL0WjK0RojVDrgwzL7YtwcrYk+cGL6d6/ZC4a9+sP/SW
	 DTtbyZ3p2zKFcoAp6MsN69EYPz39/uQ9jGW67gVYl6/IfYAngQ7ozGF1DsO4cwjKFwyW7
	 acF47OqwmpD8NXyG3Tz5pYxpsShpmzltCb0vdqR89siPWVD/4QcqZZzvLIJiq0mJ7Fg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793185074;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=asS6ewfGcKNQgUoRk5fXpM+a7NJCn4S3W3xE3GjZ42U=;
	b=OdZxCNl34LLkCgQNq0XYk6RMyx1IB9JIHLFPeeyIor6Grm1dCcwEKqsbmJfqHzGlDnKj
	 MGcWYggCUaISye4lTWuYvszqchrq5H9H+IHJrSas/OKA5/dXclS1z+Pj1BFncUVAClb+r
	 mBAsQYoJ6VqeQ3nAHhhcnDv+RyrYESGKSmc0y5oPNsl95k89rBddT7iBMRTw+vHHyP1fd
	 O2nqAr9nv6JUkbOeDSikUHLABmKtnt8YrMFjI1reChJimYJR9URiXh03NAFe18STBDjot
	 VxS98biWjlzgPOkzsVtaPnpuHJ4pSmaJYDvKTKAO7wGkXzl0+Vt+MRos1XEEHGw2JMA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793185074;
	bh=asS6ewfGcKNQgUoRk5fXpM+a7NJCn4S3W3xE3GjZ42U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s5x2/uBxrqPyFXFocV7t/BrVChGvHcij1oZ8gGzuum5LklI0ARRhI8FxPC/r1Z/kK
	 FCvTMtg5zqv+zwgLJLckvQWN7JtmPqIsKM4KcFCyWpIhi+3+CGKVZ6ThjpaAl1nQ4w
	 1gsYxnjeanB6JBgiCbv7MBLL7zZRF/oikbXtTy956SMcRUaFz7wiCwFfMDvz3BkZRI
	 1+H1ede7VBUk3pKFKO2Zcfx7DouL6DlWot9tDmaCLac5cYhESyxxaI2YB828Pifhg/
	 d0W1obHk8Bsgfd8hazjpfdTlKlt2wzGL5OYItIC3iH6c1JyW4lekEpXbOcYoZHrRaA
	 HRV8l018/McZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6591680E2C;
	Wed, 28 Oct 2026 10:57:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FDC31DE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 46174605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:57:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tfATCLmnYsRj for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 10:57:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 018AF605DF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793185072;
 b=TNffZoszlc8qYV0/fkfpPImKQMg2KzEsKNuQ4fF6lX1qcpP6Q6wnIPs7aY98+m1L/G7d
 Bs6YvT6Wc+VegW9cAVUPGL3glT2+rvyv+nBWQH/pTtnT1vnKaJiQ5m3vea59pXWRfyuHM
 CbZ/ui6xei3/yAE40cwP4jAwa7KRxCVa5yBFSP78zj6mIyIOb/KgVt+mtma4mnlo76ztF
 qN2fJsYpuX3I/jOt7jPlQn5ToFyOMYFqSMwfJCXjkLL+sM+wke+3oNd1DhfXHHHHYxLEs
 wTBmmQPJv1zhuQwMV0HjFf3uxc7hCUAk5NFpfXTFiH1ZcA09ArROCXigIPsj/O47e/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793185072;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=asS6ewfGcKNQgUoRk5fXpM+a7NJCn4S3W3xE3GjZ42U=;
 b=bDaIdzHGso6n6x8GTQJlfa5z5OE4KcdFgQqDZkjFBCCs0oQw8IXPZPax9vf2h97rQlil
 KfMpsb7eDm4WHNg5NF6PE0C4W7WIkK9BQ6SesILhIlKM0htpt6EHc6k7EDJhU7//eEfQJ
 mNkb/TSZ9FyjCJSX7hDddpOnsZelFgKLWGQNRa6t1ScfpBAEs7VoFXOJ7h/hjT7BrRa3g
 SKGJsHxiYtImZsAKQDNDoxOy3uv9jDVcGS3y9AGFZE/T133xaZ42Tuf11mIc4DAnjfoSj
 ID0/dgd0TcbO7migv8uY40xq2GH6StnKt4gPa/jptKRumzjDGJyQAi2mFKNuSJCvgYQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=JugSn8qy; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=JugSn8qy
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 018AF605DF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:57:51 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so684090f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793185069; x=1793789869;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=asS6ewfGcKNQgUoRk5fXpM+a7NJCn4S3W3xE3GjZ42U=;
 b=JugSn8qyWlRqxYyoosQs+F7Q36eGRkX3/0r9fzDjqZlevqG1bRQ6Y0Q78cfalit62P
 7CumOgs+WmNR0t0n4DFQSpGssvbqUwmY5XWJtidhyklQ+Qs6AEvqjBJAqQ7EJo+R7kv6
 +pXe2TmY9vMQdqbFSL41O0ooKfFwz3C09pVpLlYdZZve5ZyjItRumhppazF67Bo2wfVS
 MsAZ0nm+AILsvEfPhFVEu9vlsD3VGeoALiQXh1SZyA1pp2UWCRp1EAcGvKEpgjWAD0uo
 tM384VYw/kQysWqJsS2j5McQr8Bved/1nTaqUzmimNzifzDmg9aazg0g5hS/adD0A3dQ
 A+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793185069; x=1793789869;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=asS6ewfGcKNQgUoRk5fXpM+a7NJCn4S3W3xE3GjZ42U=;
 b=KCqrac8EHAVfPoNw7cPsldTbwwDgrGqfRFARoC9sQ2Db0EW2P6i30CYD65VyhI6sc3
 KrA9syOQxohENYYMWmSLP73J2KFPSUR8gPdAvcq/MvWQF3EoHhvTVMiKx2vXUgTy+9s6
 Ig/yxv+1WNGCbZ4d6ZlwPGqZD9TJTXbyW2sIEi87jmUWNFpxe/SCknl5wCZIXth7HV6B
 bzka4NyIlwGdVEf77NsReAMPmp854uueFRPq0jiyEZ4dctjhoNBOCWKoLGyob549WLYZ
 TOBOobX8QkeyuSBb7QCJIfj5fOQwEUiPHr+H0WlzMcILQclGWG/cxATbj5ZzDC/Xedo9
 9Xdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOZdphM+7b2iHqI0CL3eLyJcMADSlDYz8i5FKN8Abv0ggQsbkrgctQAIA8A75lISYtj3TngQk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLYxGg+gMvrx0NLSMxw+Uq8J94eD7k0NJpMzoQb7rmRraASqXTR
 GZtyQRqYCPZ7HT/VJhA9t6mFtcgtJguLRrzn65KX/qmA0Ycc9xijXdUufv6+EuNhBwU=
X-Gm-Gg: AYBFou2Dn/i8ZDO4NZwsOhzG6Bfz3JFerKLx/w7Ip2LpqRoiigqSkctgeiQckggE+f4
 yk7Ypos2mQoCVAqW96B+XKo/eZpCDtwo69aYs9Sgw63G2ibeMOEQHTe4DuzSon8+6WbXySdE9d0
 ygd5aKlz0zIPLzx65lHkZ3QGH/Jc8TuRR4o4Sh5/4a5iW6ECU0Ico2nUblSIfimiIGCs/WbpEwb
 T+TnBSQTeQQGYFEnf/PEBZUzMIXtboJvPLBPuqBLt+IFpTZPVoMUI+mb/vyeiGELawj7OffYwmW
 ppZT/dl4NECgP70WrNGHyXkO4ZZEOVTeYpRgv9+yejG/jAnVQ7GszgpfJZif3Ah1ogimRXDSIyW
 a3v6HaUUaYzxOwAfGQBHsoicLNXUrxf7HmH7IBzxqWetYMEznVp5Uo+0uF3B0JogI1BNAok0U1l
 a9ud303URMA2rHnxr44kS3kR1kvamut35Oa+41AZ4TxJT+lGRB209d/DaulzkKj5DN8B6EzyYOO
 Jmn3gLPjbs8FJXwbWyzMq0ReqINw2kiOzytMOPQeHkwRy9V/KHxhYyZ8+QNQlhDfpCLzMe3JPXw
 pnCLC5XJOvgAq+NAbkQlVV8LZC18GkvuxHyrv+2wHtlSlXVQxaevHb4YDGT6bw+zb0AFbos=
X-Received: by 2002:adf:e00f:0:20b0:48e:3db7:4dbd with SMTP id
 ffacd0b85a97d-48e5d564ef7mr3410378f8f.48.1793185069362; 
 Wed, 28 Oct 2026 03:57:49 -0700 (PDT)
Received: from lion.localdomain (p5b29ef1e.dip0.t-ipconnect.de. [91.41.239.30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdfd8dsm26254942f8f.56.2026.10.28.03.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 03:57:48 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20261021-qcom-env-drop-scsi-scan-v2-0-0880a06974c5@oss.qualcomm.com>
References: <20261021-qcom-env-drop-scsi-scan-v2-0-0880a06974c5@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/2] mach-snapdragon: move SCSI scan and usb start
 out of the preboot environment
Message-Id: <179318506758.1103007.8212595663730327319.b4-ty@b4>
Date: Wed, 28 Oct 2026 11:57:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Wed, 21 Oct 2026 21:27:18 +0530, Balaji Selvanathan wrote:
> The default Qualcomm environment runs 'scsi scan; usb start' as
> preboot. This prints an unknown command error on eMMC-only builds
> and spends boot time on USB enumeration that is not always needed.
> 
> So this series moves the SCSI scan into board_late_init() and removes
> 'scsi scan; usb start' from preboot default environment.
> 
> [...]

Applied, thanks!

[1/2] mach-snapdragon: scan SCSI devices in board_late_init()
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/0f03c9015428
[2/2] board: qualcomm: drop preboot from the default environment
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c62c1194bad3

Best regards,
-- 
// Casey (she/they)


