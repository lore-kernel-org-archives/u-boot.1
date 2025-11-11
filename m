Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ED7CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 12:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D40B83F80;
	Tue, 11 Nov 2025 13:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lpVlFs2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1C4883F80; Tue, 11 Nov 2025 13:38:45 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68BE8835B3
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 13:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b70bee93dc4so567257366b.3
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 04:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762864723; x=1763469523; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FIQ3I0TdW5h00xvYsc9D7xFYagaLJjizcASGhO3Y/wA=;
 b=lpVlFs2C5JqusLAOnwg+koOdYvvKyLAC++XabAjthGA+8b/2Fl0/hcT7DFmB+F6CNB
 NkOvyZJ5BTc9qWn0mQdWUEC0HT2UyKk5xjnjZIQto9U9/q4Q3SUyp+fuGEugSEfCJJOj
 eBOmNqmjh24FpUbyH1QGeVcfE9NKwIkovZbeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762864723; x=1763469523;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIQ3I0TdW5h00xvYsc9D7xFYagaLJjizcASGhO3Y/wA=;
 b=BqMB8UMDa/KvnXdI7A4Te8t3jkR49dxS5jc0b1aSE/4zk/yCSmKrPZBSSMTENpfEof
 Bb6v2eQSpryD1Lk+rHmLZpDLJi3O6tdxwR6vN0Hn4PN6TJM08fvgb4A2jau3cJduM6yp
 7kkwIzrBDtdLES+E+V/FyDVsi1RitDm3P3orBspJIkBV6mG7PHCGjDC3ilJheED8SdOy
 2ep1D9lYjX4nSCA2zzjQIMQCAW+d+WJ7sZq/C0nU2hzRWL7MgGEvbPHQIIXUM9kxJM/5
 4vFRdsOfCFtPtvIb8eMzubgp3PJyaFIOMWTl/MrsFWO9vchCEgPpbToi2LY10/rQb2rj
 iM8A==
X-Gm-Message-State: AOJu0YxxjrBhk7OmDKy56v/DB6GLwFRiuj5x5oxSxYc1KkQ6dRfvNhSz
 jbm0CCyTM5a8NyiqrvYObBkyK3kcXYrmLPE+9LwHecxqcARcwBbOGfP/vbw3BFK7UW914DfOk/H
 nLeQtawzyK0b4PZzIE226Qf3pfEEG+Sxze742O+5eeCSTh6H+6AM=
X-Gm-Gg: ASbGncu8YUWv4C76FGjfqLKEQeP12SwiXwttqFzw6AM0xgIOtnuqvceTBwk7wgsrldp
 RERQA5D2m4ZQu8prcObJaSiAfbkm1EoiNhHJwo+KQRaHcVs5uaKKFj/RDwgZljkqc2quRGqewz6
 CzPytcpBjZqOew1eP91HGqnVjTQlbFzNIXlzwp4aIVXpKyGsD/fZnuwUw5qTJkEgbIQcUXRMhZP
 U3NLv1W+MhMddbt1aobj6v2To2NNZ1GapWzQP4jYniDvBewNf7A05gyUeNCpFzH0Uckrg==
X-Google-Smtp-Source: AGHT+IFtOjF5mFceJ3SDBgyZx1ERfkaDaq3vJ1ZqJmt0SRnF6QMTLCh6+gj75HbYbl4i/sg1XQQfRgJ5pOnrEFYnG2Y=
X-Received: by 2002:a17:906:ef02:b0:b6d:5363:88a9 with SMTP id
 a640c23a62f3a-b72e028a43bmr1079275866b.9.1762864722812; Tue, 11 Nov 2025
 04:38:42 -0800 (PST)
MIME-Version: 1.0
References: <04fd00f4-1bb6-4a29-8e1e-83cdc1b03b74@cherry.de>
In-Reply-To: <04fd00f4-1bb6-4a29-8e1e-83cdc1b03b74@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Nov 2025 05:38:31 -0700
X-Gm-Features: AWmQ_bkS3cq-_FPj8tomsVK6IRboKWJOkkaWM174kVoF-eAZhYIMRMlIClIqIhU
Message-ID: <CAFLszTipN4UfvcY_p3DLUfKrVbzhBbYxqQ+GZ5qwgmRdLEX=UQ@mail.gmail.com>
Subject: Re: Binman creates a single image 4 times
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Quentin,

On Fri, 7 Nov 2025 at 16:07, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi all,
>
> I'm signing U-Boot FIT images with binman and that takes some time. If I
> build twice in a row without any change, the build process takes about
> 15 seconds, most of it spent in pselect6() according to strace. I have
> yet to discover if it's related to the engine or mkimage or even OpenSSL
> itself. Anyway, nobody likes waiting and it differed from my pre-binman
> U-Boot enough that I "dug" a bit.
>
> Even when not signing, with
> https://elixir.bootlin.com/u-boot/v2025.10/source/tools/binman/bintool.py#L294
> used to report all calls to bintools made by Binman while building the
> image, the expected bintool calls are all unexpectedly (to me) made 4 times:
>
> bintool: mkimage -d
> ./mkimage-in-simple-bin.mkimage-u-boot-tpl:./mkimage-in-simple-bin.mkimage-section
> -n px30 -T rksd ./idbloader.img
> bintool: mkimage -E -B 200 -t -F ./simple-bin.fit.fit
> bintool: mkimage -d
> ./mkimage-in-simple-bin.mkimage-u-boot-tpl:./mkimage-in-simple-bin.mkimage-section
> -n px30 -T rksd ./idbloader.img
> bintool: mkimage -E -B 200 -t -F ./simple-bin.fit.fit
> bintool: mkimage -E -B 200 -t -F ./simple-bin.fit.fit
> bintool: mkimage -d
> ./mkimage-in-simple-bin.mkimage-u-boot-tpl:./mkimage-in-simple-bin.mkimage-section
> -n px30 -T rksd ./idbloader.img
> bintool: mkimage -d
> ./mkimage-in-simple-bin.mkimage-u-boot-tpl:./mkimage-in-simple-bin.mkimage-section
> -n px30 -T rksd ./idbloader.img
> bintool: mkimage -E -B 200 -t -F ./simple-bin.fit.fit
>
> (in that order).
>
> Printing the stack, it seems like:
> - 2 calls are made from
> https://elixir.bootlin.com/u-boot/v2025.10/source/tools/binman/control.py#L789
> - 1 call from
> https://elixir.bootlin.com/u-boot/v2025.10/source/tools/binman/control.py#L802
> - 1 call from
> https://elixir.bootlin.com/u-boot/v2025.10/source/tools/binman/control.py#L813
>
> Is that intended/expected?
>
> Can be easily reproduced by building ringneck-px30_defconfig for example.

This isn't good, but I was sort-of aware of it. We actually don't have
tests for the number of passes needed to produce an image.

Certainly the contents of a section don't need to be regenerated
unless something changed. To a certain extent some changes are
tracked, but I think the original intent has been lost over time. If
you'd like to give it a try, the first thing might be a way to track
calls to BuildSectionData() and then adding a check that the count is
1 (or whatever) in a few tests in ftest.py

Regards,
Simon
