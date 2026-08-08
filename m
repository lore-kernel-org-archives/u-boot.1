Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A6FC55174
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 13:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD52780E30;
	Sat,  8 Aug 2026 13:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r6PpPCZuhCCK; Sat,  8 Aug 2026 13:48:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C22980DE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786196918;
	bh=zB2pDY3E/9NSov08Dt+mS77/OlSosARqtXcWvX1Qwu0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A0BfmdEpaQ8CibAgN8d0ZkIkvAQ3uZZ1TyBcOE/D70E0mUc60Lu8FFThJLv1seJzy
	 +ZG9gdAT6S4+UFXChQy2gZ4mxg66mm+QsbKrT8v/g8FY0uXZOY/4DEutdgzB0KUt8E
	 USha0mnkc6Ss4p6Fg+If7/3Yg8NiVjfnZxGwoVtkux/nNXVSzyvGUCRwbPVbwA9Nke
	 CZoJM48kgy/apAJllPXzb9T1F4HBfXSj4H3ypn8VI5urrwYX0OZHhyW4CaUvDWNe78
	 yAhOKutDik3jcCwPnPacPgJLCuuoYyU/o6o+Fq4st7Nlgg3HrFFpmvlTRn5kgMX+0/
	 KT9nMRBI3QErA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C22980DE9;
	Sat,  8 Aug 2026 13:48:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 175E6296
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0968260677
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:48:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XmYdw6sFMvQG for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 13:48:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1B4806067D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B4806067D
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1B4806067D
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:48:35 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a082b3671fso410869a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 06:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786196914; cv=none;
 d=google.com; s=arc-20260327;
 b=EiSWl7NDO0s6z7Smxm3FjiZO3CEzw5fU4DLdWjANX1Wnea408LMWONCYZtiNHkDpfB
 F58OpYhB0QHu+fodiFGzD6WqLKxHWXNw4hInrGPPMg6njD7rJzvhfkw1dDQd/mV3ychx
 scIyBJm02QZa8Iw2iyci5fENbpbfyJrzNT8LXhILVPh3c368HU1SBokK2o0h5JEM076v
 0iCZxISgKf81T0S5biV4nxeLgr8tx1yxBdtp6pvyS+vfHfTHx7cJDU5m+rUZUnzg77yM
 1fTm2SeUQQF7G1nSFAfz2WH6BNuv3BbxQ2Yoihn3oXOitC9+RSIcvaokhp3cidKR33XY
 sP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zB2pDY3E/9NSov08Dt+mS77/OlSosARqtXcWvX1Qwu0=;
 fh=03xFhLQz88vGk+OxVx1sK/8GEjp+FklHyDiE0dRxSI8=;
 b=SvmY7MpIeeyMnA73Ix/wMSDr21J9VcSG9tvXOiDgxoGQRV42rNewEst5pq+Hr1qBcj
 38OE9HT0mPUuUzuSDNBla5+bFPeitS17UPBj5nfC6K75NLyS61SlSIVt2KxMOkB8/jzb
 2wVHfqN/bwqsXYzZ/AcVky/prIu3+hX8ng0Kq500TZ6gUebLiCrybrywf1M0jBJrWVS7
 FvOLtETuRskhKYQj2JP2qDs+ZWARIu5Vgjkp+bq658Af6BNTPg7wuf5zKpXYZb4rpoKR
 U01FFUl5rj9j6PwJk3yVpF5PTjeqTxapfk0eqOdkeCbsf+CjbOu5tcbshtQIcNlShRGs
 3h6A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786196914; x=1786801714;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zB2pDY3E/9NSov08Dt+mS77/OlSosARqtXcWvX1Qwu0=;
 b=Sfh903PxtQtLSdptTYvLtU/o+sW0f9Tj692wob6T8fYTSMfBts5/1PVl1F6cgKf3ar
 sIZ8IlWM8gaPWlzWftgILRrEVPP5qwbQwtU8dLjXb9AD0gsMxZrb+pF3fayUZFqAfz/D
 0MDeyyccRycdYvGO/fzkDlcrY9f8PP8ClIm5ldOSOCliFN3S5curEJsGkP3llBlqrAJT
 2VSJ+A/umzz0m826r0jnHtwwx3gM+TVm4NPoapGJ3ShHd/KyOu/joaij9TYRa9KWIokS
 cF8lmlIjPyuRfW31aez1kPHkTnwskDbkneSoKSOGs2uvsMQELILpI+JveAy03oujpkN6
 xtWQ==
X-Gm-Message-State: AOJu0YzN9cBynYwreldu7mDMkFc2+urTV5grYMEYARMUkF/de4azLuI7
 KxKxKLzKPbFkJ0FTgx36Z/EjYgGcLfPYybYEy2XNqJRJzAlScb2jhNHrv92wHa1RUcCmmHGi+JA
 0R+Fbhux3ym+Xk8s8ZnI6hKooI95PAVe28A6Jg2cA
X-Gm-Gg: AR+sD11Tg9miG3SI9O/RNrH6t66Bc1RIx6OC3z9u8Rm/wbJ/nVQCCRofhzewwfUo/+u
 kcv758pSyalXM0BZjYTpC27X3lTERVqCVmq78JmlQrvIUqe0EFe9ItTWf0bvPycXouTpbKJ6cI8
 7vmiCDyASinZV3O9QSg0bEamCVBKL61CWg4zevxg4rq7YHWcIJRxqoA40N5G8KteauPoTFNLqhC
 VQj0wri4Yj/a+F1zN6WvgyvQxWbfZNe2ZR1Nf48JXaMQHM2kRlFU8MPZNxHGgKieZIn3wVFg9ua
 /L32LuPB0BX2nPv9Ontj9Btr8Utt0ImaWFc1rJoV/Hc=
X-Received: by 2002:a05:6402:320e:b0:6a1:f95b:8cff with SMTP id
 4fb4d7f45d1cf-6a1f95b8f45mr1716610a12.1.1786196913883; Sat, 08 Aug 2026
 06:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260808004437.4367-1-aristo.chen@canonical.com>
 <20260808004437.4367-3-aristo.chen@canonical.com>
In-Reply-To: <20260808004437.4367-3-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 07:48:22 -0600
X-Gm-Features: AUfX_my_tUaU2jL0620iT6cI9Q75y22UWjxGv0qcFcKq-V6mWupJvBLbAHxCa-U
Message-ID: <CAFLszThpVMGU3q6oRdDOn0KJaRAha1cuUdmh3wfts8Rn+mZecw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] test: cmd: Add gzwrite chunk boundary regression
 test
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786196914; x=1786801714;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zB2pDY3E/9NSov08Dt+mS77/OlSosARqtXcWvX1Qwu0=;
 b=FGg74JYLOrneSk87U4pSK/kVOxXkRJkuJOMs9avPpq9/ct1gpsBQuQZq9i3OvjAh8l
 Gzc/ZRJPBmF74TmeZkGQlQVbfY0s6qGtt30FoGzcNKT8bho1HOzV6Z+dp6Y2XPbkZuDS
 jbO2ShaFtX10uHxiRObCh7nLP3l9boM53vc9k=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=FGg74JYL
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-08-08T00:44:32, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: cmd: Add gzwrite chunk boundary regression test
>
> Add a deterministic regression test for the gzwrite() case where a
> decompression input chunk is exhausted at exactly the same time as
> the write buffer fills up. Build a gzip file by hand from two 1 KiB
> stored deflate blocks and pick a chunk size that covers exactly the
> first block header plus its payload, so that with a 1 KiB write
> buffer the first input chunk runs out precisely when the write buffer
> is full.
>
> Unlike the existing random data test, which only hits this corner
> case for rare byte patterns (about 1 percent of runs on sandbox64),
> this test fails 20 out of 20 runs without the preceding gunzip fix:
>
>   Error: inflate() returned -5
>
> and passed 100 out of 100 runs with it.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/cmd/unzip.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 116 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
