Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACC6606A31C
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TaNHuzTk;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nvtq+JYb
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06B9C60674;
	Sat, 31 Oct 2026 09:44:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B0X7i8hZitxN; Sat, 31 Oct 2026 09:44:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 457BB607A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439864;
	b=OeKVQ5TWBLVc7Xu2aKPcT7G8pTdWa+9ptQv+tq0Sy2f15TwTpsNxIYryk3dXvgs4tk8o
	 g9LDi8g5bTgn5rb4BkrhOi7JqkG/mGCBf/Q6ka0+efAsBdueytcQsz9Cr0apcLuG1anYZ
	 7mpWkrhapyuXgqV7Juv4ZoFeFuBtIdl22J7W9W2ryP3E7agi6TnT8d46AW6K+sUMGTWQF
	 sJp8l5QIZLzB/ye6pEgUTahtx2ZRYo7Yo9XqsIptxu9E7SUq5deItzj01bTfXmW14l9gz
	 dY20N18d0GQQmyShH4skjEHZ/kM3BjMPk+/r43UOCEWg8DzD/ZFxTBZez92ZRXkmgCQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439864;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ACFRmvf+uA9yowtR1f3cQCV4dT/4HxiTbhJIais3FsE=;
	b=CNC0xipRDdGz/BK4kaokLMV64MNBfpuqKXzeaMoQNwHETjGI8UTsE6THHnP86LklYvas
	 8AKuiNj1RQmh8Lqwah9jhQn0P7oijauD5ntHYZlRMC88yEX2cGfiO3abx8NwF/7bbkVZ1
	 kdKAFq0S3r6CQcghQjoohVKMk8wWMhpaSHCwS2ti5AT98ZEsRCQRd3JsljRulY6FxG7O7
	 Q+Yt6/b7LMwe25KTgpmNZ1dDiAegis0Mu61sOprJRA60X6+LEuoBQSKt0pTII/8qamlrU
	 pns/ez30iFhxdBQv1pb73mgO2UPr1tOxAZ/0RSkHW99e/hlj6k//BhqIJZG+2866SCw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nvtq+JYb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439864;
	bh=ACFRmvf+uA9yowtR1f3cQCV4dT/4HxiTbhJIais3FsE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TaNHuzTkD7tVcRY4QNu23Dizu1IB5CjHam6jKkX9xZuPAUFWcQORF6EGrUD4Rcs1G
	 uSOnzkLTL42bWEdgQlKJeZIK8RvfISR7kwRMiSeb5KdaFS1l+Y4GCdV2e/FVP+6Ucg
	 VHy5cC/9ZsmnWooO6TpxgiG/0MKwUxYhzolb5s+ORvdI2ObE0yHZX4pmA2taOJs7OL
	 F2x7wnrcdoL8rjvDjD7oeC45tnQBC9x3nulMIiu5zzZIB0hQQ8VQHMmVejTL61toKa
	 31MQhj5j4GBuCOIaFGcVaf+9IJvZkUybyozTi+gxqjHi9hBjhh8iwOwkKbJ1tTNUPA
	 gcEnb2/IVbDdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 457BB607A0;
	Sat, 31 Oct 2026 09:44:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C3354BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E663960AEE
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:44:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EBnSripu3TQ6 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:44:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0F17F607A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439857;
 b=EQFSUt/xVTPuU3pV5BS9QhYRzsNXgvyljEGDfIAZOn7iGlr4tGYNhx+JKgs10HRmCNJj
 Ihg0evkaG64NEiqPE/oJrtguJfl5S0G7PAbK71X6sy3lF4gdpY7MysLCO0vs455NEf7ry
 jQnwd4YaURyI//FejrVvohUTL9tAKXoOd0t0mkVLHvjV8AJiUirBdIPGtmOHRE8d2X1L4
 1qhOBY3oT1aayJiw1S0v0+ccCvZzyrXldNaACo/LHhnKPPCk+i1pqGz4yJKmFUEkkjP1E
 TW7zObHuK9PQt4ipKO3XNO9POHsptpdWCZnutvIGPC11zRkKMTJpfRi1Qp2xQYDzJug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439857;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=ACFRmvf+uA9yowtR1f3cQCV4dT/4HxiTbhJIais3FsE=;
 b=aEhUbakivEXhnasjL4h0wxacHTJRSQDbj424W77MuWb3jQsQjv1ccJIy2uEHtBzhCL+g
 wirYXp8TQjNPmwzqgS/2Usna+Re+nj77BqtKpgGpfqGCoi32y1lC+JUtawWgZB75PNiT7
 6KwG3lQkLvB30PhQiPd+JHRnAD6k3wwBXCXBPVlAf56q0Njsvb1uhHJ6abQwGtMBLmmN0
 YJsLPXla4dMqwrok9ZReyexlcWWnIIfVeuATQqlhGJWtnOhYKN5n9tRUHXNhwgHp3XywA
 9KIT8ZXuYj7o8S//NHmM92SgeRb8TEAbwzpKKmQ/jVjMj47DkPHllpzrsoX2ftMdnCA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=nvtq+JYb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=nvtq+JYb
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F17F607A0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:44:16 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6acb9c018ffso2203480a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439855; cv=none;
 d=google.com; s=arc-20260327;
 b=G7wD01W8124tNPeIGKBE4ysdudwNRj0hDN+SwbBwmJEOL1Qg8NPnUb4udhq4FZCLTq
 BxVm/k4metpMC7IBHSiTM7VDxe1v0oSwOKrkTCHnxhmsl80W8bajlOz9Ui46emVN8Bcu
 xm2Bmi7nQ3CqfHCjzk+8xz0PmoU+yBSUpiXZs5fXDo5gDE21UtpBCTm1peH1/zzf/Wiz
 6VeTB+sujC747Bm3KBeK0YI8kst21XYP9HaBmnlRX258IOiBNrn3uweLrMPns6nvhFC/
 i+nDbBZDrmNaKtVIqRVdIiTE9kHUG6ZhggAfyvhuWkQsL1J3qZaTll0NSU3Yo17cDq3N
 QVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=ACFRmvf+uA9yowtR1f3cQCV4dT/4HxiTbhJIais3FsE=;
 fh=vAmY7hRBdMrkxhak4XNxRo2S+aXYqAOi9P6V2g3HEEg=;
 b=cYFr8k8UudHOVybgrfsj4ryZ+Tl2jy/Ksp4bkQaPU7UKx5iJN5c0zw/a9Itz0QrqVS
 SjoI5Ey8+nI9LCA6YtLJV+iTPt2hcrHsxzEKonSE9/WxgTrIqdD3hXshAJMj3z1tOEJ6
 ow+75IbyDwkZ+ZsVMVoP1STYt2XURGAVZo1TOamynD3o/mPZQ+etgje2NMFiPiRI32LP
 A3v31P0lKO49W8GIrBqxUfERAnphw3QcIfHAGcfHSYR+t0C/JuYYkfDxSl3wG8NWqu3V
 WhpSEwe/YOdhqjlhBldU8xjQG8CC1asJT2nXJ+4Ctz8/gbRd5KMk7NQtiKLxXOLGks25
 hxiw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439855; x=1794044655;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ACFRmvf+uA9yowtR1f3cQCV4dT/4HxiTbhJIais3FsE=;
 b=nvtq+JYbp91mqAJY1df7J+EojH0ILnFyeaN85vC/LM98JmFxqa5/XEXmQdxCm1MPrN
 SzNwNjm33mpHLshUGlWS5Xo3ohE+4lzBIzlXVPEsC6Djoj3bN4UODY4bp789uwEaqWh2
 3fIIVYgqEl2N60Nn5nmWuupCbM6uBP5ObvHhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439855; x=1794044655;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ACFRmvf+uA9yowtR1f3cQCV4dT/4HxiTbhJIais3FsE=;
 b=E7w4DaKaiIrLlC5TXZKboGM/z419uOdNNbJKxdDk0VfeqFKkyagg2hvdEWUnECHcdH
 rEEOk/wGid/BFdMf8f5UXF0QOPNKx/EIeoqjRwPnBW4uGIHUEYLRVrzhMzdQiWIMPtPL
 1PmGI9UAT4+ybHDvck7WHKKFshTMyJ+6HYDDxgSvL11ns6M2K+Y5XPxFezQIQXCkk5U6
 wWUGe5WvJ/TY/rXC+8oiK6LYT1TcQs8wBRwe9PwIwwbCq6/k+4F2Zmvcbq1sVgF3g3aQ
 QoOwqG6qxvMnuEHCd0MTRNYsptRkylfds5Eqn0z+arWFbJ7GSruC7OUPpf9Tp7B4Ji4v
 X/iQ==
X-Gm-Message-State: AFq9FYLVm2qIHe1vnA+phyoSZVU+7+1YgAlKWzPrUlW1lbllxrEfkM+X
 TsYzBFzbhhnJRvo8mGC65J4FE1hQusJVllPyk5StRY5P3+DMcIaYJbXDXtkelge5BYYC7uEaomS
 tH3duMCJmeSSmbvgonrctRRm3CxqYyGaL1Q8jOTq5
X-Gm-Gg: AYBFou1fyWx/rO+KbNw3sq7cQp5IlAlvDLe8RTuAC5Rv91QBdR+W2PlG/cejXv+d7rG
 64F0cEWu1i+wA4JcGn5XCjwCgvhFVQI3WV5SFlQ7u2OWpS9RLewUmONQc0c8NyJxnyDuX6XMFcb
 fJF75ygJ41qIURFcyvpXlOHz8o922N2WN72WiNLddesbp/VZMP4n9l/ZwjkUuNqi69MzOO/My3A
 qnFfKK9HOL7Sda5RKEyT2q/MpW+606SRjL/Umb+fhpTv/At1096BJdWoaCsmXxtGbISV66tpMLF
 eBRCM1DEgpK3dpyeFT9CRZ9BrUlBP2IjbQDCn2tWriUxVbEvvxeQegg7Il+h7TRQUjzRd4X+QJB
 KDC3Y4qAzwRO9ovOda/UyzsFSzsKUTDIqy4dFFVWjI4i/UZ7zDm7M2Ml497auhyLhnViKKxw=
X-Received: by 2002:aa7:d356:0:b0:6b3:d0a0:39c9 with SMTP id
 4fb4d7f45d1cf-6b4d4a7b988mr2412592a12.6.1793439854715; Sat, 31 Oct 2026
 02:44:14 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:44:11 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 03:59:34 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260902-riscv-full-fit-support-v2-6-493e904a129e@maquefel.me>
References: <20260902-riscv-full-fit-support-v2-0-493e904a129e@maquefel.me>
 <20260902-riscv-full-fit-support-v2-6-493e904a129e@maquefel.me>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:44:11 -0700
X-Gm-Features: AclHuK_u286wEjV-b_FmVnH2PJV8XcqMYic-Aq8pdzl3KccO4x4cwprLEgv_Cpc
Message-ID: <CAFLszTihZ8dVPe-1fAeQhSD2FAixgOPg8NOk_fJgULprxRPFdQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] spl: fit: Add test to check loadables
To: nikita.shubin@maquefel.me
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-09-02T06:31:15, Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> spl: fit: Add test to check loadables
>
> Add spl_test_firmware_image() to check loadables correctly provided by
> spl_load_fit_image().
>
> We create special image with U-Boot, firmware and empty dtb. Then invoke
> spl_load_fit_image(), check everything (including dtb) loaded correctly
> and then check if loaded dtb contains "/fit-images/u-boot".
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>
>  test/image/spl_load.c | 184 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 184 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
