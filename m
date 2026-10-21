Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710F0606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pwRVefzl;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PrNUReJJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CD79608B4;
	Wed, 21 Oct 2026 13:08:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MEzmSzew8are; Wed, 21 Oct 2026 13:08:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8DDAC608B6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588103;
	b=BdXgPYwx01QsvAMpybrRg/BuREjM28BxvWd/xz6A6IkOUTyeMKDXfhZlP+qM1bHDsbyb
	 D91HRlRtz3Utu0Vgz4q8JkisewZmyE0GskYtE7v5Jvxh6Ktsfo/K7Z4VQ7KaciRJx2iYE
	 xS5WEW8GMkxd44y/xGwwgM6FwFubG4GA/CK6S3yvJsazveYrRRuJMuBu/Xi9B9o1nV1aS
	 ba1trR0ap5r2nq3GncrRsoC5rmh5PgmCqqpcEhUs67u5csSPF6tLkDIBcIt2XeOxbcsEz
	 SYgAjqr4naIKA6DVVU9rBs+ConLPfitFc3gCc9ZA+CofLl5U/cCNDokt+B90vgbhXWA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792588103;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d8bHCYu8MyWplFuXQEoJiIgsv/AeRkJIUvIrC5QjpIE=;
	b=UB2QvbBhW7OaPVCcwAdoFoKb/csW7Zsw52jkyoBwpPpurwxmWUHcgjfc2VREjmfPe/Kd
	 65p4igP1xuuiqhFXTxnjwARDxiVgSXk/elbltYK6ZFe6zfQuIRjnnP6RBMXV+X5ZJsLj2
	 D2M7a0m4nuSUNaI+wYKlPcTyeVuJtA6xLhkwIdQh9rk7ZlxAQbKw/OvQqMI1UdOv+yyC1
	 eqCg9b6b5c3FsVS40QmdwlewgFwIjC7jgnxrA11ck13cjielv/C+XMM6sfsXHHAls2/l2
	 MqUL16UesWlc+TEoAelYybudUNVlWbcnHMChqUQb1CZSyXNrXj4rFWxNylatdIsN3mQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792588103;
	bh=d8bHCYu8MyWplFuXQEoJiIgsv/AeRkJIUvIrC5QjpIE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pwRVefzlxl1qRTM1MAD2bcHNpc6sT8queeNUbCwsTWxaHw94CWhHZCfOkxtc8sA3m
	 abkSezOXLfPEqXVceCcFuqg0qqHO9zWnVuDpt5aZLwEUz4CrjhLlDLsXhVM3pW+FEl
	 Unjo8rMxoO+qRnFvKCTAbsRTW3cIVRqPw32ZEj4UnITsEDEmCU0GBUSFSl3eCyh4vR
	 WIGUYohwb3LjqYT7++l1iMohkiuXCCKhuiqxaiumqqmPWg6csm7nvuHskI4ckYOdw9
	 D9PK5bRMh6/2+cBcT1KIos23hmQ/y95Ntkbzqv/19yQcHxES7prTA2q7c67EbkrUvF
	 S5tAfqzJOJj6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DDAC608B6;
	Wed, 21 Oct 2026 13:08:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E92FF3A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:08:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF2DB403AF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:08:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nhG4eZGy-i3R for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:08:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 28A40403AD
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588102;
 b=UCHB3oIfDSS776I1Lc3sCKg5r/e+z+XmOy+8PMTDsupLm215IJX1+Icc6rXGvmIzw5oN
 k0BxjUdMNJGToMtVSbnGRWxWEYcD0rkPZwonMEGmM1ux4Hzovxquc/grE7ZjXnJDFJQTm
 xjtHNPjmjSM6Y4A3hHi/0etbjZ952ZylmDMpCQEE0FcugImRLz0embWwsEyzkq4Cg3bJ8
 q+kbRtsO0FWGQpw/4rOAdzEFMAJgqRnbUJbXptw95p4f7ndvNa0CIch8ObIw2JpTWPu99
 6fcJymcXdnOKuDpdscmCWJARJxG2T7F7Us00OV/DCt0dcfXXr00J9A7duhzIs9ComPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792588102;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=d8bHCYu8MyWplFuXQEoJiIgsv/AeRkJIUvIrC5QjpIE=;
 b=ok3+vt1n4SZwSvRZyQ70kuCOkXihCiDmYO29n+kGZdKziUsEzYTo77T+rYLK91W59Zrh
 EuKWdEdEV808eIZePMgVwuzujXnvuvPKx1mVZC95byyaRDfAEXVYwy90wbrU/2lQudBEr
 XY0i3y5fP5L5cTON+7GxMSfx0Cy/jAtxCRjxUi6h2EIpubKGmG3m0Xl86SqvS/+GkBEbT
 C5dWS26J38oFfRRPIKEbVXBxIbt6c2hSHoAXWq9uli/l0OXUdsBKwT9tUfwLQFdRNMM1l
 mSDxXnzp4wqazO5ZrMzGaH430gBPE6Z6mlQ5z7tf2QFjZc7dITP77d/GQzD1ob4Uteg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PrNUReJJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=PrNUReJJ
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28A40403AD
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:08:21 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2e9995ce866so5389975ad.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588101; cv=none;
 d=google.com; s=arc-20260327;
 b=TEw9BGzvhYBwe0GxdpgKUJ0ZPaxEnPaU9q05MUVjj0NBUEIbVCxQpfOxesibV+TTjR
 4FNb29Ja67kwK02nfu8vakjvrGf4HJbz5JyUEa5N1tCW6WkQxQkT87vGW6DPfU/oP8DJ
 yPVSvpNh3u+DkM1wxbKVuB4ggdLdQt9rrfqZsRU5zN0BVqp2sWI0BBToToaNDa4KdCMY
 UDPbrimCYXoaVz+nZ9ep3ls2TFrCNY+u/jfyOpHmukJJTwEHXtT/+NvRQRHnunTALrxg
 JA7rWItn+NLoavrWpiXm4W8JJ746dS89ia9043RGKvXODiNHg9/Gm0U2smuB9HrYFTxA
 +2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=d8bHCYu8MyWplFuXQEoJiIgsv/AeRkJIUvIrC5QjpIE=;
 fh=rDOkmCQJ9cozxuZkgmyNWj5k0ThXnY0U4gnSEgE31/k=;
 b=So5luSP+R2Llw2iplAP5k5nGu36U91LenkZdWZ61X3ugnc7ktemtviC5GDe3pW7Cyg
 rUpilnScMIR/GWX7fYNVTSwJnqWwHRw+SMN+CeyzduC6K4pUVgwl5FfHO4r2zKKZLi/m
 8QNKvf8TzkWpSQ86tu1fSGvJSHEsFO1atY6mcDt4BrD9MrXAHlx8ygvf0Z/9UqRRrnWe
 Q5R3xYA59KIXZKKDTNa+mHlRQ+3fKHI/+ZYqy17J57z6RfrSDZMojtD6rIjW+5OZ5WmN
 Q1SG09rpujCLuiP0zcbsJdqI4JbN4livl9m7fhjEemSVGAnLDVsDybRze4eThhl/2Bxz
 nZwQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792588101; x=1793192901;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=d8bHCYu8MyWplFuXQEoJiIgsv/AeRkJIUvIrC5QjpIE=;
 b=PrNUReJJlG4Kq4P1eat1SeVD5vDQxrMi0JtWOd13to/Fa6xyJ4xNWOI4J0ALKTNj0p
 ySHbDbtpzXq6dA2lwefnE2FgOTvfuQyPQw+zWEbXAdpV+mAkvGeChXFhXQBi7NkTMSAg
 51zOYjOlG8ZuFNBuJdN8rKPmIGh/c8BvPaToo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588101; x=1793192901;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d8bHCYu8MyWplFuXQEoJiIgsv/AeRkJIUvIrC5QjpIE=;
 b=zNqgYkJDDYpHzu40ZX68MbIPc/Ys4c+IwJHeqON22wogy0zNowSTwjLeqUrQwOMTpJ
 Blt2cZuozDeuVCA9fbPtPCbuCSoiCq+skTixhR0e3UV8vjL+565iPw+D16ARIffNiyXf
 kr55X6fn4MN3jMkxM4jNyEscc9xWKtwxeqdBdPpqPCLD6remWBS/cAfAikYWd2GgEUjt
 XPh/PuyOQh1j4YhOsOMPyZuEmgRbWuX4m2k79KSs7/BzLahuZnfpi+SCfKwv6nHceWRE
 lJJfWh8+YnSFVN+bG1117u88NMNiWGtOzsQ0whC2SLlKs+w1UcUNG9z8cEdgApW+RqxF
 /oOQ==
X-Gm-Message-State: AFq9FYJuc9ehlb/kGemOo34AxlpLMWPKSGPioW08TxdsppaNr0+K3W2+
 zwA/rabKDq/VxvWewKn1xy030LsR1JRUDqhwYFiBGvqZkBvNqrIpQM0RUsGi/uNalZY+7ocrsUi
 SIu/+FL8MvXVJ6CNpZXRvkqOFJwPcsH+33Tu8g/KPOYzhLpKXZJyS9w==
X-Gm-Gg: AYBFou3zTPu9ktHlirdl/sWUGBWqa7V10phktGblJTccRbVjKw1hImgF/UQLhDnN5Rp
 4yZqXlxdEe07JL//f63SvKtkFg0BBdgq3RxSC3HWy7ngxjv7x4GHRh2/waMk+aT/SX3xjP00dPL
 I5btGvbZRVoyyxK8eZ/ftaM3huhg4NEASe5Ok+qHUxedLRiV5KcD+8MejiSGzDjYyWOz4Xw0pls
 gd+uE8Byuybi1jYYHT1jvQAMKypJob8DRzhDxGrWQN7ZxxPyBZOPO+Q5b001E7PqTskHfP3bWPK
 jL5tidfcWM9gQYsr4w0mqeBbeVXOlOPSvuC9hJG6VEfc8Cdd3qILYj0DHJET/DvDmmL9ToKbbVC
 XGffnZnGSGptvkxxw5TWvTHiMlXyszsqxTAM=
X-Received: by 2002:a17:902:f60d:b0:2cc:6018:f030 with SMTP id
 d9443c01a7336-2ea43d459b1mr17501815ad.14.1792588100183; Wed, 21 Oct 2026
 06:08:20 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 08:08:16 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 13:41:49 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261013-b4-button-live-monitor-v3-4-3563b4d3ccdf@protonmail.com>
References: <20261013-b4-button-live-monitor-v3-0-3563b4d3ccdf@protonmail.com>
 <20261013-b4-button-live-monitor-v3-4-3563b4d3ccdf@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 08:08:16 -0500
X-Gm-Features: AclHuK-_2ApFVB-uUHfPCztmvUpRlACj21cHIKQ-pMrewV5JIckokl_K--fRfWw
Message-ID: <CAFLszTjo=Q2Zx5cS+WoQPDk0seJABtpYkJyKARdP5EvCjYMAsA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] test: button: add test for monitor subcommand
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 David Heidelberg <david@ixit.cz>, Simon Glass <sjg@chromium.org>
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Petr,

On 2026-10-13T16:33:33, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> test: button: add test for monitor subcommand
>
> Run 'button monitor 200' on sandbox and check that the output lists
> button1 and button2 and that the command returns 0 after the timeout.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
>  test/py/tests/test_button.py | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

> diff --git a/test/py/tests/test_button.py b/test/py/tests/test_button.py
> @@ -37,3 +37,23 @@ def test_button_return_code(ubman):
> +    response = ubman.run_command('button monitor 200; echo rc:$?')
> +    assert('Button monitor' in response)
> +    assert('button1' in response)
> +    assert('button2' in response)
> +    assert('rc:0' in response)

This only checks that the labels are printed. It doesn't check the
state shown next to each one, which is the point of the command.
Please can you set the state first with 'gpio set a3; gpio input a3',
as test_button_return_code() does, and check that button1 shows 'on'?
Checking for 'off' after 'gpio clear a3' would also be worthwhile.
Note that button3-5 in test.dts are listed too, so it may be easier to
match the whole line for button1 (label padded to 15 characters, then
the state).

The Ctrl-C path is the main new behaviour in v2/v3 and has no test.
You could run 'button monitor 0' with run_command(...,
wait_for_prompt=False), then call ubman.ctrlc() and check that the
prompt comes back, as test_ums.py does. This would also cover the 'run
forever' case.

Regards,
Simon
