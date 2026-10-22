Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95888606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kzAYbNF2;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iM3HeCOI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68A8B80BE8;
	Thu, 22 Oct 2026 08:59:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4gY0akjSg_Rr; Thu, 22 Oct 2026 08:59:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B2C498120E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792659585;
	b=nxqIksDFnNLWzd9AFORdouIwk2hTKEn6fs9Bt5D26dWXAQsPeblzw2WZYqV94mwN8x4u
	 lpjUrTr9cy/1fv/XleICftpDO1mK1DRnuRA34+Ek13zZZS7eCGP51xoswqYgPb6X6Faoy
	 DiwPff6KFDV0eJl9X8hjcbOJlAW3EwJ82j9KWNrqRrygpwXqtd3Fxn2Sz1Z2bVjc9RcAi
	 ncckiE6Zc0fgIjKpdWNJHUc2REjk2PIvy1GF0ITo+iFuORKjmbYL5uRwNU/eyXghR4A5J
	 DwXMJwurvBb9/S98xVz4T40RrBj8NgdWj6KB8f1NsqagcbFDb1S47rARR9lZGMYqW0w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792659585;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dJO34rwvflF6kmsfvoV1rjGoeGgMqG1tt7WnN4AmYlo=;
	b=bFGbfvDJLcR24eOp+QAV9abl4dAVpnTdPSjJaA5JChniK4Z+Ayqd9TsGIsfOSPtRElOH
	 BZsN+U+i0nrBLiyxaHPt1VK67Btm2aNgwD7XaVQgdmCuwAucDSO2WXVxnvfEdU2dEUCVV
	 UDyLs0+yWYUVo7QM4/pa3L8qPxSLLz9v3RJBhmvGeQWc4lD26V7RTMBUOpjy2TPGVQ0ov
	 tZ/+5TB+ap90v9vbEHy9MmD7tjc3CUUKZELfpZqskKCztIvdK0uk7bW2IG50iSylcM5lp
	 CSw/BG8OTiglimtQkrj1LLwWuXzqDTsUqar0W/cmIOcSWbe/w0xk0LbjUSmFG0KSKJg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792659585;
	bh=dJO34rwvflF6kmsfvoV1rjGoeGgMqG1tt7WnN4AmYlo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kzAYbNF26zKnO2xnstVWCwMS8cruu5PrNvxKN7pqUGNzv7DnqAs8P31CQMkOG2jQP
	 Br+XwnZynKvvSZlrprZeFKJRrtI1gV0Mp6VUejtCgf+4rD/egSd3Adqv15Z+beFbAe
	 21R88X1/ZQ2OIK8jx4xFCfQLpXXbPgeaffsIkyLW/ca27QMkFLSIxfQQZMysZqDEB3
	 Ihz6PPXBN4ot5EKZKFs6ya+2AqFa6LWpkXS+9U+S+hJq2e5KO0WfaY7OD0q4neOd69
	 DShaaNXQYYxuk0NvD1wiLDL7v63fHPRjFoq4chOwQWmfgXGFFd+M8kxOg8QI12+qUR
	 60z8WxZ24O97A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2C498120E;
	Thu, 22 Oct 2026 08:59:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FE7C769
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21EF660816
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:59:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FLVmNbwTdts0 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 08:59:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5BEEC60831
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792659583;
 b=qV942A2+tTvn74OKqJlmPNUjM3kETHGoZfhLHicfzh6SKz6eNLybiK8cTviD4fkSVJ1C
 +X0h3FlLO4Cgjg5eFHTXmto1yxYA/xv1grN4I/q6cpoeDQnBxtkqhW41c6JFU4192nXO3
 jDVlXjk1TmrmMka9Wlg1Ax0l5jc4lQndY1PPVeH2ekMb1uBEdEZKPtiux2IjMv3QM8Sft
 pcyIudzE3Et9x9KLqvp3vY0apFNROkdf2NPN3xV+Z7ihCqSCnOk3m6nkysY3iwB/Shmn2
 73Of5P1wnTbqo3C3hza0bhZ6nf+dxLanNG7Qg3E3DWduh2Q+oES5tw2eXohgtkECmyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792659583;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=dJO34rwvflF6kmsfvoV1rjGoeGgMqG1tt7WnN4AmYlo=;
 b=f4DhQiDRkZeEINPESDccqTzifsJLXTxRM5hbuK8Un6anq8S0Zs9yoSvMYmXApKaq972w
 z3qamok9UmqK6byNpSOq8L2SFKkjgCehvRjKFAJr3vehRTfjVneyEvsYP6g3p5oNjB5IG
 khbzMZThB50G6VVV882/+nhLsA6w8MPHHkxGZREdt8Bkr1EJxRJ8x6TUkfZLg8DQeE0cA
 moJD2nGdBiBLB++hf44SVaT/P2qCNlAacm5L1ZwZ4aRbwXrg0wCF9I24MEArue9DYTL6d
 bpbc0zSrb7NaMY1lRNduUAqWKJe9qdOfS5XPpEoSri28kFd5AlHDzmV4fQwUTiMVOMg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iM3HeCOI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iM3HeCOI
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5BEEC60831
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:59:42 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cd5cd8d89a7so562363a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792659582; cv=none;
 d=google.com; s=arc-20260327;
 b=B/4P4Um9WyaQyl6NWGjm4hauuvYPHz5Cr8OHK+wPE4PfBDZ4YvVGRsKnoQPLTsB4BR
 goXMFr/9r3gstwTosCpYXD9E5Dq7ZzxJz7AhfqN+AS91QFIAr/bTbaF9Zg8UUR/BSRCr
 Um1WpginMSqwPJ6sCFg0d289zYGfcRcuiKxCrE7FGC9YBZlD0HBovd+nUWsLZuCoFxxz
 qiHJJobM7wAlP4+eBsXQcAx0NJ9FTGYTYcU+1+h9ecnNjawoSJEFUIyuu6sUMhIAc9mC
 vy6GiidA2ytQhep9olNyx+5g6v1Spwcz9zCB+gESeq/5rhy+I5v4dU8LSVedqmHr8wPA
 ePMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=dJO34rwvflF6kmsfvoV1rjGoeGgMqG1tt7WnN4AmYlo=;
 fh=ZmxrbJlbxnkqDlmQ/oI50i23RAPabvxWwFt6Rx8E/b8=;
 b=Amon8QH2g6rz5afRihrp/ygQJzaQ2mFuo3r1XMIC+lPGIfg6PqGWGqLrqnBUR9giCu
 qS/us0xCfqwXJtpOkRAfhRSGIBotmSrTTtGENxDR1VUwOWNPPOyridMzLDdRTxeO0nGS
 qU51GGnuXSgDM6Yy8RncwMUcj1CJO/0xVHiGnTnAkTbabbq6c87bhWuxu6uuVeM77ODj
 rkwoW/YfsHtGqJFt4DivpSBP8TFR0K1KxyBODKByQsZbszhz0ifC8uHLfsUC8TVtqCC2
 f9Pz0qiLlSJCPJ9EmvJxrK49k4cJ5y9H6BIn6IqvIKia+vWOWJWozE8Pa1qxMPIL0F7U
 uvFw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792659582; x=1793264382;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dJO34rwvflF6kmsfvoV1rjGoeGgMqG1tt7WnN4AmYlo=;
 b=iM3HeCOIDSJbv5lfAHl4PxcIps4gQQlT5VS7W1SdIRWbPH7xvHuwKkz4ohHxvNuVCT
 cfQT0yTfTYLYEpGGna7ix71ziK6xrc7BD5RDUqGa3GwLF/cMv+77v0hUSpRDINXJ2lx4
 vv3ZsBw+9FsBNGsQvvmkFY+NHGs3oHjg+M2fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792659582; x=1793264382;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dJO34rwvflF6kmsfvoV1rjGoeGgMqG1tt7WnN4AmYlo=;
 b=R5ycCy4BIwVE/YyS6DlZzjCZ4vQ0EnC0q+MOFeINxY/IZ7dedwdUenUdpdJpVXrkL4
 wqx7vmA8gqujpZLDdiCAjuQ5GKgFdjk1BPXTKbwFTvKcE/CqWcoHbCegzcZerfO8ER8T
 oanksoal0YeuSrtvi8/2MEe9UOdqEZfYSyMGH1Na+d7Mn4iFV0TVPHbLSnZbjv3lANro
 KJl3zWHjWbKWEFew06sw7qgJ9F5mkPVVl5+G9Ez2/TN3MQmbvVEMRl5Uv+sWI30BoCsO
 GlHdiejOexEnWhGTSCGouulfo7YINgNUs87s9xZErOUakO03CsFNO9M5Lz1LUCYeQA96
 YKow==
X-Forwarded-Encrypted: i=1;
 AKwUvByX4j6wXa/X5NN71j5kq6rYAQJj8he1zZAsL8gtFiBTChL6EzVtWrYNt2Hmtt6Z1ds5lgK9HWU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKygG1trm0p8TTVqGEA/62JOUJ5bRAU52llTFzslPhr3ut8Gjho
 TgD2TdGU8raHKJwwQviIBmwi5yiH/f6CNeJTnX2qR4OF/+hfg7Pul85RMYCHRaoeZ4QP59BnQe+
 RPytVgoqULSUlcwgGrPrdi0hvxF9XmElhsegmiSYA
X-Gm-Gg: AYBFou0W6/AWQU28qOnykjF15gChxYbBuzUj/obX9VN62zSpukNVCzh+tK0LNjJ3IeA
 qLEDofqvVodjixo7rrzVfgurtNYWmg6qfd5h7aALhD1UsPoQC5KBE8iC2yExw1FSrML+HDFIa65
 +rnA4OOYeOIgX331bBMaNxMaYPV3kKuVn6j4tuXE1x7gVGKuM4iRqHzj6w1oOO7P+440O6jVQNr
 JR9WJ/klBI/19hizmSka9vRZTSm+KZ2I6kvfFWJBI1OOtb0CdkaQcJk+T/mA7QuieP56PkLI9Mm
 Jglj8gqsyaM7lfIIKcGQ43y2ZrNrO1Oejgvmu9qi16LgrYVk+Sok1EsFBnH3aYPON4kyHHJeDxk
 9fLxsOJcaBxZn+h8+4oFyu614X2JN48v+XF4=
X-Received: by 2002:a17:90b:3143:b0:3a8:c0cd:57f3 with SMTP id
 98e67ed59e1d1-3ad86cd5dadmr3616065a91.18.1792659582297; Thu, 22 Oct 2026
 01:59:42 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 01:59:38 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 09:09:09 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-test-avb-fixes-v2-7-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
 <20261020-test-avb-fixes-v2-7-997f8f04fd3f@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 22 Oct 2026 01:59:38 -0700
X-Gm-Features: AclHuK-2TIK9zAMiiAeENAhDJIEdhbABRcYt5TznNs_VXM17sXW4EBFL1IdFuVo
Message-ID: <CAFLszTgJVvHn8kbcavS35ojqPAVPDprcrANZUQYf3epjYT5zvg@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] test/py: avb: Use format specifiers instead of
 str() for mmc_dev
To: mkorpershoek@kernel.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20T09:25:49, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> test/py: avb: Use format specifiers instead of str() for mmc_dev
>
> The tests format mmc_dev using str() conversion, which produces a
> decimal string. This works when mmc_dev is 1, since "1" is valid in
> both decimal and hex, but breaks for other device numbers like 12
> (0xc): str(12) produces "12", which avb init would interpret as 0x12.
>
> Use %x for commands that parse hex (avb init) and %d for commands that
> parse decimal (mmc dev) to format device numbers correctly regardless
> of their value.
>
> Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
> Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>
>  test/py/tests/test_android/test_avb.py | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
