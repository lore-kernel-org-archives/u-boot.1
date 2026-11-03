Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C71606A336
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xBAOmqCx;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=M9PYU6hN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0778607C4;
	Tue,  3 Nov 2026 15:49:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LtyPGGB16RsX; Tue,  3 Nov 2026 15:49:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1D8AF606E6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720954;
	b=akzES+lRNM6UUrlv1tgSi9JNj4ePffrdS0kM8k2jP0A4kPKAqRthh2CxQ6jS6wu2aqMP
	 5UCLMCvNUMzu16OKOuh9xbE2SDt0fGTs2Q0MRCKUOKN2gtLvHCGQxf/WfvvXLwOBSN6xH
	 n/a4vdvJsThS3E+BINJnME2e2bg6Z6BrClrAl/o11acvwLmUuwW44iCEWoVMHG0XiLcRT
	 OTLCFvNsBFUhZz6UuZjd8bCR/6agXYoOVhLd3Mo1COueyRqX/UW7NI/S9dhoo/53Bn3R1
	 9LfeoEZ1ltJ5Vl61RD2SQrKRdCfQHUW9h3EGkFQ3MjgB4Tx8isQwYNqpCORgfoe4ZgA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793720954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=j5jKSkrirLOhhYkfWryDqQvN8z6tV6CtRU/4+qZBLK8=;
	b=DwTRwfTVVmZ8pieNMWxK0Kru+oiMPe08agjp0B+V9H29JFYsyzwy++Dsl2YNWc2hH8hT
	 9VLIlCrqiBRqYs5GM76XxR8rXwyeTXer8DhbYxoCUr5n5X1HQaTWzwA2oz/Dmj/7lXAdJ
	 SknUQgvhBGnNYNZfTREVqPR+RAMol0sMRmoXlNNCAz66ZUaBGybRIpxp+BxV+77qCyMdM
	 Z2j8dr69ibzaZax+oyOSUu3ldAqqVHDGuUdoxJV3pdbnXOXeGWh/Lu9y7A+CnOBnS4ri/
	 9z8gd7JKv1cHv88d2ndmEzTLt4yS0V+3O0/wztrCahaeL3Xb4Xl+TPU2V78En2SZ3aw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793720954;
	bh=j5jKSkrirLOhhYkfWryDqQvN8z6tV6CtRU/4+qZBLK8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xBAOmqCxXKzRIbE9w1YWZhQ1FlShoCjMxk5c88H6J2vP3i6Pun4igzWIVNabh6VG+
	 esS4rxdHUIJuzaEhEEn6sygCmfVnZHqiZd2MnGVibTmpz72wVX4jm6MA4Cly8kk/1N
	 NVGF1kwt1HhZZiktQHYZi/jmbMTbVhg/fPJGuOQDccbxts4rW/dBr3xaUfCM4grcqo
	 nSNIVZnn4aDjiSdTAXNxGiD4/oMRpC/srEyL3GaYuM441ousx9H6eAELwsPvfXc84m
	 zM6k8eD98Zu+4dwrOR07LHjtIPzmZka79nm3Gd7KiUdagQCeGbpS2OVf5Wryh5FxXx
	 5GPEWlATczlCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D8AF606E6;
	Tue,  3 Nov 2026 15:49:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 076152AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ECD86400BE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:49:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jv29NkhwTHpQ for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:49:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org ECB1C40068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720951;
 b=hxIo7ubmpLAQxWGOBFGHZ8jrUmvceuvsvSu4kpkpjP5pGyDjo41w+OkUmcgyXY2B8a63
 8CdAppsqID3+bZ71/rnDISiEbjeCRnhWA0jYqmBem0TadNe1nlk6/zxOs4/qmupvD9ibI
 srgKWq6br39+goCEJq0hcbvoRm1O/TIduBrNMZos90ukRyuqjWZTSW/XVrKBpP0k2yY7E
 WrS94pmTWhBvvUPDpoDZO6X0U9mrBiVFzV44Si6Imxi34PnFX9z1jakBukE56ZDPoQD8O
 c96ciiUiXlfeWlI3TGxrHo1L8CtJhGj7e2i6ITKUa2RZ37qwzvGIhlaHJ2fpkbUpQ9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793720951;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=j5jKSkrirLOhhYkfWryDqQvN8z6tV6CtRU/4+qZBLK8=;
 b=FXRO8r2RXo13mP8j0YvjFw+s75cIXjE89ZZ/I9MkQUeAlMDn8ge7et6ew8KZEieFIzhh
 YUF2pJ0jl1W7KQ+cliH54OzIx6je9zvBp3ZJ71OpNW2TdAzaCUGglHv6/Z1mCjhAlrRqB
 Qnzw3bhv6/1SYvVmLIKw+CV5L2uOi7esqjbIoqhrhtYT+QiPH7f/i2uY8QMnk17xOCVXB
 eS7apB7qj1sYbHwIRvmB155tw3fByJhCCxK5oXNFoST/4B5jnJ4I0kCx8J4xJMfomCb9h
 iGujwWgWs4sQeJWQeZmx4mn1yOiQ3lPjcwVfrEBG/MvqA9Xbodp2PQGw7td5VVtUROQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=M9PYU6hN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=M9PYU6hN
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ECB1C40068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:49:10 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b4f7d3cd98so3588418a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:49:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793720948; cv=none;
 d=google.com; s=arc-20260327;
 b=NRcHiyO/KeDkG6g8ltg7BOBPw0QgEFPV+1Wc1gQgMEiJM1cvxIpg8y8/xLhaDKJiQy
 eH5maEDfNK0nxmSx0kr3KZYslU7sVKdpGX4yFX4zGbQ/eJFhHEqRFtfk6+WIsrnnbmVA
 roFiLugbf6xY9txFZm4LCWQXAuaXQTfCQgIQCsB6HZKIgLEgx3/duQQWNP88zHxr8RJO
 0/PqIzkeWvD6/+fnEDObGq2XynrVY9jFuuCz4RAGel7jWe+VRIrWen00gO4WHWhquWZr
 SrHsv4EXQ1v6y1c27t36OhP9+x+q5umW6DYZUYPgpvwh5OIXvQ5K6zaMQqsmYPR6ou/b
 6+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=j5jKSkrirLOhhYkfWryDqQvN8z6tV6CtRU/4+qZBLK8=;
 fh=vAmY7hRBdMrkxhak4XNxRo2S+aXYqAOi9P6V2g3HEEg=;
 b=YLknHFXBRp0terNrstu2/3iS+37PGUkUNMGlMhnnJQprE5SlDj5Rm+LcHO5HGgmlOm
 72crIUN4ujkn9ip+3mYqucQgjErxqvI3DO5G/bAZjGUfMhpnWK+QlT5TIJNZGoHspQdC
 y6X3Dq0AqqC65V/Xu0Vk+ZtW8f0QCXpGGfEImu8nMtwLbUkb2seD57xypF3xgwL2ePLA
 9qQgtSdm2f9lRzFCQDSQVkCxK9iOIDskSyQUIhIv8NTDD7yl54Bnqz1KUrwp+X2DNfSy
 LfTHZ1hv4K2YFKTvG4Kod6LC92haccR7dzsS7a+HABzWgV3z4GwijUZ725my1xhINwEq
 /50Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793720948; x=1794325748;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j5jKSkrirLOhhYkfWryDqQvN8z6tV6CtRU/4+qZBLK8=;
 b=M9PYU6hN95FaghdAMgPBjFH1I+IIdwd8P7jmrC1PaCzdAsEDm5OnXsMPDbTM/jO7el
 diyyVBwWa56TmvsvJofF45iK96gOujNkpQVSE52jNxPqlMEyIAC6dHsOvrhuZXKM3Fwg
 fiAiWdPYmIvYryI15XRm2Laz8qxRxMSqlSlg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720948; x=1794325748;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=j5jKSkrirLOhhYkfWryDqQvN8z6tV6CtRU/4+qZBLK8=;
 b=pYY4MQ7OgffQHPWFO7ctno36Mxlypi+GfI/QlhbMvFsNlCkVraYkb52nVcNGsEwmJd
 chlceDoZISS1u8MSPrnN+uLE4ti2h1NsjLmNQ5KkBkkcOwSWKXAQohzvS+3U95QtN2hg
 aAGjOIJ64GENnhyW1xDrwdMfqp7z+z1N15AWGBe6HdsrOOPU7YM/+/XxDl9CcK9AaFbA
 upCXHAvRSCmvde7widYzmxMCHQpt99nQjNoLrZRyzmPPbXKpULyAHyLOJyJF/a8Q6UHF
 JbBzmGGTF6RTXW6dS84TwQ1lCkxtAENnaPcAFePWuOLtHn/L8saqGMx2Xu+tN9plGDZs
 qaYw==
X-Gm-Message-State: APuU4Z9VDrVA9OLP9TJWL37PmISTb3+i8HEYSylcq+HMNM6jRedtZtcI
 /XHXukEut+CGNzWRu3/maXCbZWqMpxpr7ERPyf5PuEWNEmaV7C2A16d9HQKidY5KaJGufMsbE8k
 m8XcDapbzp6IUJiTLMhPCLvAiSsWWoIcCU5hILrVf
X-Gm-Gg: AYBFou2Ti5zWOE5guaSnhEfhSaAxbTmLpOFu//CjT6DJ4giz2389/uyULWYU/SVClSG
 JifLws+I9xEwmEldZLosVpujjXg1kx/XX/F3SZ6nQg55uS1zO7m7dRJIRypmWMzviAEYkO72TvZ
 oOZ+VHpQVUOPbdwfI0cfTW3UPDb748JO9PMj/XgQxHZtN/R8FVLIid2n4UG++3tcpiNFk4xoal5
 c9ulgqJkoFTk1W9vZoxGZ+ex7VbIT7c4GIr4FmlV8PL24SKmlJwqKaVk93Y2cgzW+2CspJDkiY+
 ZzD5Us7EIBs3y0sR0JpG1lk4Sf5KfzuD+Z3sZEQHqCqJ4UgMOQgaVEjMYJqV8BKv5jlxyk9mjUT
 5nQYUH5Ay3C3O6mcyAd8741mtQfiN7qQiU6CVxQEPa2NS2xHnknDfUaDd7XglcVJM7GJAdwY=
X-Received: by 2002:a05:6402:11d3:b0:6b5:4872:7207 with SMTP id
 4fb4d7f45d1cf-6b5487282c0mr1396465a12.37.1793720948522; Tue, 03 Nov 2026
 07:49:08 -0800 (PST)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 07:49:05 -0800
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 06:53:58 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
References: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Nov 2026 07:49:05 -0800
X-Gm-Features: AclHuK8MhoeLNGdBt9Mxj5CwimhJFZJ-6XNOF71KAAQMZmnn27glWtOFLbzkPek
Message-ID: <CAFLszTgi+QPnkB8i8eL1x7FY57TvD799RcL+kZdiwN38QSrJzA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] RISC-V SPL: fix OpenSBI FULL FIT loading
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Nikita,

On 2026-11-03T09:53:01+11:00, Nikita Shubin <nikita.shubin@maquefel.me> wrote:

> Tested with provided sandbox test with a grafted FIT image containing OpenSBI (firmware), U-Boot (loadable) and a DTB.

One thing I'd like to check.. the new test gives the FDT image a load
address, but the in-tree RISC-V FIT in arch/riscv/dts/binman.dtsi does
not, so the test misses the layout this series is aimed at.

Without a load address, fit_image_load() leaves the FDT inside the
FIT, or copies it to a buffer of exactly its own length if it is not
8-byte aligned. Patch 5 then adds 8K to the FDT's total size and
writes the fit-images nodes into it.

I tried both cases by dropping the load address from a scratch copy of
your test, with two loadables. With an aligned FDT, the nodes
overwrite the FIT that follows, so fit_conf_get_node() on 'config-1'
fails after the load. With a misaligned FDT, the total size ends up at
about 10K and the nodes go past the end of the small buffer. The test
still passes as is, since neither problem shows up when the FDT has
its own load address.

Really you should copy the FDT somewhere with enough space before
recording the loadables, and add this case to the test.
spl_load_simple_fit() avoids this by loading the FDT to its own area.
Perhap a follow-up?

> This series improves CONFIG_SPL_LOAD_FIT_FULL support on RISC-V, primarily to enable loading OpenSBI as firmware and recording loadable images (e.g., U-Boot) into the FDT passed to the next boot stage.

Just to note that this still reads as though the aim is OpenSBI and
loadables, which the simple path already handles. Patch 2 now gives
the real reason (CONFIG_SPL_FIT_FULL_CHECK) but this isn't worth a new
version.

Regards,
Simon
