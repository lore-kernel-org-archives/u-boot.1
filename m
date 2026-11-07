Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBA4606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HD/HVodT;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lsXPeruO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74D486061C;
	Sat,  7 Nov 2026 23:47:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fdJYE6nA28Hr; Sat,  7 Nov 2026 23:47:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C20C960609
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794095240;
	b=VWjagZWihU9HeArtS9Sel+1tt5ZftiGoxKvD70Ty3EqWjnblCJ7V2x/aUNIoLuec53aO
	 iTdoPikZ0IfQUnaQd7Pbr9DC4egDO3TxNB14VLbMh5+lUpaAFZup+DHysBI93GPUC6JgE
	 KZRQtlAmQ1ObmFr1dWWmHWBskUVxUwxvt62LAMmRy7LdOnngZ0JWBTMP+r6ROWCV+H9FK
	 mL8R8fiyGA4vRJjBXm110Fx4GN0nLVKlMZupU9Cc8XTsnAeF/V5LodaFlWtVCsjfQdJA3
	 ab24KsyWuwkPvMU+o3Owz3irviRIfv1NTYL/r9TXxqBq9+DPuuSBX+XCpROImWMnReQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794095240;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NU3OSDVG4NDAxCB2dZsOSQEmmAfQVYyjmcAQogJ0SmM=;
	b=i1DiLomiQMYZ7gzFSX28PIidVdFV1nJGLjNWAuaw5XN6LZA51Ju/UFfZq/y0HB6ms822
	 FGIn1lPfNe/lGnUN9eVyJoMLZ2pIysOj6HQMFAKBk+g+AAxHmE57jIxlx8nkRfOcsCyEd
	 0DUQWBPXXOC+jNybVi04V4YZJTfvxLkby9VMtYSr9bECdwdrvROjKZA3G8VZNU79nyKt8
	 CKBSZLDbHSyMkEMW2JOq4lk58Yh0X+VMJNAmkqvEBkfwoPV1Y7S7QElZY5Ia075+5MqtR
	 e98/EeRPuICJYy96jVcG0lDypKqaAuc4CcMpqvQdW8QpAMYhE9vLXD+49mdj/VjGS6w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794095240;
	bh=NU3OSDVG4NDAxCB2dZsOSQEmmAfQVYyjmcAQogJ0SmM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HD/HVodTiwXtQWQkFP09d66s33H1DR1hi8yMyDU+IQn6pGgdKUA0kKRz9TMJCKw61
	 gqahwD9Tg+MA5F8rlzA7N9nxvJeJgrzj+4+eSGTtAd41PF6aEMLTXsfTZQ3bD+zNKH
	 ZahKzjxbKQoWX1LUBeJ5ohzb7inZRq923KHGb5bqPpK6U82aZjxrn+7x3UFXj0F+mc
	 Pe26zslmhtCeJH/M0opgeU243F+CiCk3JOwIwz4XL1ZD3Yb7mSpWJ3uJIJfwwOFQb2
	 YoEsOEH3VRIrvIEh2BOmyTmf8+CqY+1tpp6AAMNd37w9HZ+KPSc+t+C8NyIbavnLhB
	 odIRv0lN0HajQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C20C960609;
	Sat,  7 Nov 2026 23:47:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E114422
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 23:47:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3406A40699
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 23:47:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nMspirjsneFU for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 23:47:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 43DB140698
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=malysagreg@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=lsXPeruO
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 43DB140698
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 23:47:17 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-49318428d98so44338f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 15:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794095236; x=1794700036;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NU3OSDVG4NDAxCB2dZsOSQEmmAfQVYyjmcAQogJ0SmM=;
 b=lsXPeruOMEeMPmKuLGvgWcOnFGz/XuSoBStWreS+fSeQFrALeuB6IYtMpbE0pDx1YC
 qbXwImpERuJ83/WOFWRTe1l5233S56QdrIhjwyTbBeTHMwQTcioaEsV25dnPjDYtdynE
 S56Cuh4q4jDW91zEheNr23p5ND3qGrQ1IPIo/EXF7+iL3gPYITePsD1XQYE7jkXwd2tv
 CxGCuKS9azkuMAmMpXgXIzb3bU5V8PuYaJDnBrYgJ3KPQyIMt5j1DNPoSe2Pf4VwNvzT
 cU29arD5tvx+hih36y32HrxnjNMKNKMto1J/f35quveZMu36O9nRwvY0Nd4lYDcuyYjr
 Ykqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794095236; x=1794700036;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NU3OSDVG4NDAxCB2dZsOSQEmmAfQVYyjmcAQogJ0SmM=;
 b=PkgNxqjkCsa/ksj/Uwo64TY7OUXZ49USAWQoU1IUg5hwPAuC9uVypM2HfM4o9dipuK
 Sk6Q6oCeVqOlIlXcAv0/YYkuDqFq0FKJobgAWgTVYkuLHQMH+GNzhDMcQteroo8VPU4p
 XaScX1rR60bJp44i80azZs7ZgPE6DeaoYLjtRbfz4d0Yh4OaqcPIcLc2UWsavFtZ/vsU
 YtvMqKnpMYxONYLI0FmiglkgRegQQbPurV8lWRi1qSXriudr5llXO5VoUOEXnRGo0sNS
 qP1PINKJJceTG1M1xZcx6NN5Nm+mqOfbAa+hXBky2tD4R8vKZZ0+UMImbGYjzGSDAZdi
 B0rw==
X-Forwarded-Encrypted: i=1;
 AL+hErGqObwBO+uCvuscwnGTqCgExJxLT2PMPQj7ahvLoD6pC/ZJrATQASRgiMsSw/RBUPocz5Gn3rM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z88/8G8S7yZYuhE68v6UNcSdBnBtlovoLbhlmDhOXX90IISu7ft
 Yoa4Y7od4DR0pdFti4yaJkcf0AqTg9JXb07nU29hL1xgeiuBGiFj2mnvgwTXsFbvCRB22SEWMbr
 qP69houqtqrrpwc8VQNXwwiLhODkzbA==
X-Gm-Gg: AYBFou2AuPvGgfayQVxYyMxEvnobbmZwL3wNJA4Pnbu79eulDMsFiVQJqbYw4+R/iYy
 EGzn6CBdZg4bLn7g4C0TLNaX7pBt4aPpVt5d2YQeB2CCToWRYZ+BWkPeXImgrzeKIDkG1pY5PpT
 sdw+jcRJt9wStHyNd0XBQQZzjgxZKWCNRG/iTAIs1bwaE93qaYnWTD7NSTaEvKpzNRb99Xm5/0Z
 iOyKPowmqYvdOhFQ1WBY+AgqciLKCH0xHjZ9rWvsIWe9kc8Gi8ug1Hpg/MA6q8Mcx3Tl3bj9h8N
 +8ERNHGLvO5qoKJzZh5MoOc8os1uFIqb8H6qtI1JrA/ojignoAfcvdbpLfOtOnLqiniWgoBA3C5
 NPAbHdpq2KTk6TMuPoBRqjYkBukq4wrH1pE0p5fEJYCkKsu8mHm77LJ8FEtWadmjp3I4at7SLPF
 K5hRE/mIyuax0zrw==
X-Received: by 2002:a05:6000:250c:b0:48e:6f84:2e8e with SMTP id
 ffacd0b85a97d-49589c3f455mr570486f8f.39.1794095235672; Sat, 07 Nov 2026
 15:47:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106194621.510146-1-oss.patchbox@gmail.com>
 <20261106194621.510146-3-oss.patchbox@gmail.com>
 <CABdDSeVYBMhFXb0gL6LeSysr56is2e4+jhkeVdimwZNgy9Y4Pg@mail.gmail.com>
In-Reply-To: <CABdDSeVYBMhFXb0gL6LeSysr56is2e4+jhkeVdimwZNgy9Y4Pg@mail.gmail.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Sat, 7 Nov 2026 18:46:51 -0500
X-Gm-Features: AclHuK8D58Hi5B68r4tQzlinYlNQ7fxba7C5bk63UhxN8S8XuJmLKk3u-d8oFL8
Message-ID: <CABdDSeW77pQ46JB09Uzrf+tDfMfxJWx6pCNj2tMdjB5WbH4tfg@mail.gmail.com>
Subject: Re: [PATCH 2/6] usb: musb-new: sc5xx: Free the controller if the host
 probe fails
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Stephan Gerhold <stephan@gerhold.net>, Linus Walleij <linusw@kernel.org>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, linux@analog.com, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 7, 2026 at 6:18=E2=80=AFPM Greg Malysa <malysagreg@gmail.com> w=
rote:
>
> Taking an even further step back, musb_lowlevel_init fails under two
> circumstances: host->host is not set (impossible due to the earlier
> check) or musb_start fails which only happens when the
> musb_usb_ops->enable() function is present and fails (via
> musb_platform_enable) which is not part of the default musb_ops that
> we are using. It is therefore impossible for musb_lowlevel_init to set
> ret to a nonzero value in a way that leaks resources on this platform.
> I have not checked the other drivers referenced in this series, but I
> honestly assume we all copied the same driver and behave in basically
> the same way, including default musb_ops.

I think I was off here (sorry I didn't write this driver initially and
musb is a bit of a labyrinth), so it probably actually calls
sc5xx_musb_enable through the sc5xx_musb_ops struct, but that function
also cannot fail and always returns zero, so musb_start() will not
fail either way.
