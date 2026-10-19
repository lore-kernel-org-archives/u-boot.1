Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DC3CCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:47:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83DC360600;
	Mon, 19 Oct 2026 08:47:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TSlY_On4ZLwu; Mon, 19 Oct 2026 08:47:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D990E6072D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792399646;
	b=cqbqGTHiOdaqlurAsAeqU19ezmRAr0+j8ovPk+05x6L65m9jNo4yTeT8yqDnX1WnCL0N
	 B9MM/AtZF9eCyQvBtkn49ZmOJemN0hi1Zb8mRvYRdNi4rNaxtovLrVWRHq6sfjLsRbona
	 7zlc8B2KKGx0R6zp5d7ymjP2LiDEVbWrWd8Xk2XdvKWi7JlBUYZxAe8pJ0kRNUoO+wo6N
	 2zKeg0Xpg7Cl2JOKRtPHiMHR587k7xdU1TGdvVDomgrd/c2FEn4FCeHnSoaaH9uCWgbKh
	 7ilN+gTQM4X207jFkcJjQl9xoS3JHNXe2qX1pqph/jzMwm2FYjLQhluHMV+WUyoyDLw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792399646;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=56U/+XpL0PrbPfT7BBDYGlQc/1Zj1VLCiyu38mkoyo8=;
	b=VY8HZ1HSj2w3BCTchC8X4SuBverqswAsVjgfDSblybBwQu2dzP9cjgaCkVEAIoiOn98K
	 WpRI5uuSAXEFF7fYil0bVPsYQej9UFN0EyLcAlgkY5jB0tmJ7Reb5zVS/Bhvlv4RBfi5D
	 wcZw29qrn7z6FSpGudlWen1eUzHLfYZFyQpYy4B2vPaTMeyhn03tuhZLTd1iaRL32p5Jp
	 ypiqeasr46+2csnrOLgn1kUPL4JvfH/Uyws04bVPeGTX0LPucE34k+emO2pvz4nwiNv9E
	 lBc6XPIZ0PG+0nysakBwlndPLs1AccKg7em5CVQ0nl9KveNNimJSAOmCDavMBDTI6CA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792399646;
	bh=56U/+XpL0PrbPfT7BBDYGlQc/1Zj1VLCiyu38mkoyo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d6NlLK73ldFm0ZGyndoZ6eXSplCIWM8JmjPzLKO5H2Xq+eGqGusbGc7HUKJm0NwrZ
	 assP/BXwSbOR5cg/+OKK9BMPyYiDD+Av8vacUWXLJSFnHT2eKQtOXFcClFoM9ifNh9
	 GGa5mPpXIfNDvZgiKyPfStEHZnDeimPsxzlRq8gxZRsjFHgAyF001p6ck8PcVTxvhx
	 wR9vVqC5kvUWVq/9dfa9NWNM1jaa219yWE42QiCDiM0HOPMGaGVYoKpCPstS7A5SxS
	 52QTwYSSW4PdPQFWFUlAiY9Qftl4WR6170xV1v+clWZOVnws4X3AiGLiPONaHP2OP9
	 AUTVPIT/L8PTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D990E6072D;
	Mon, 19 Oct 2026 08:47:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D0681AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2EAA94070B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:47:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0_qzujYT3SrB for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:47:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2CC7D40708
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792399644;
 b=MUGdJuGANq3FGq+1ZnyI3h1zpleAhtk8Uq4CUtwc+a2Fc5Eso8D8YceSN75aX4r1TE04
 /TE8MLtRnzwQuakcfwfqQLdA/UhfsKBadr67KAedwNYyOZjiqLuQ1Y68mt51S8wlidUtM
 C35L1D8hsHta+JtdYNkLgZo+jukMJvQ5IKHsUopXTTJPu6MWCql+inNxCrYQg9wg9tjY/
 BVu8sHVxJvbW4dtwWEzohcW91ChO93ZGoDhLTNoztHxzZ3oVoJJkMMSkn1ghN63Y9QRrH
 cy7R1UoDURv46YWaQURXI4d1UgRbuk83Yo7mlqtRK+jKbJNOkdodzZlW8ieTzvYmkxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792399644;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=56U/+XpL0PrbPfT7BBDYGlQc/1Zj1VLCiyu38mkoyo8=;
 b=IDJCrIvIEv40PHjvYebjMY6OaXmMEVrjs1KkqWulbGpUyQYqKzd4ueryvtf3TogeQEVx
 ZbKKuzz4Q416Rs8o5CVgX5Yt2n3rMBlP0QRWPuf3mMxb+8K0W+g1q3JtWOa+Q63+u1I9X
 iCTOn2rQhl/OOkm1P4aMwGqdYnH5l3fObZaJUcwAyqxvLoBf1ED2Fj/e9lwpcZgubiHhV
 P2sMMpEUX6ZeuvER7mZycjEnxzwuHPFUHnzz6KFu1acE2PL+kipq8vWS4tH7FvT4qJy7h
 Y55DwXfiYhxvXn4izMEvGDaLqlPP5Nru4WBBqxIRKVpgME1gmksd4zeBxhoDK60C/9Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xqH6GiqE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xqH6GiqE
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2CC7D40708
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:47:23 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8b0cf2c0785so13380937b3.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:47:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792399642; cv=none;
 d=google.com; s=arc-20260327;
 b=GT7EYwc9dvE9e/FYgbtTxXVenXy3hVMMD0uAvqARvMNag20ZRrpomrdRqMEBbe18jI
 dV252d6AoyuJr3YCqic/O5yxDpFT7S/5R4UFmsKJqCmpsQeLqHgJ82wN7leapFVPM7u9
 RKAwdNm06/66fHvKG6LWV/Q0GKBHMV1YvvazUQpox6NQ1r6AnUVO9D7wV4SYBnG+keBv
 hLBe4uyGEAOQJKNFXmGaGnL/9VLLs102/zRSQf2LjTRkXVbRHlh8Ff2wDEGPlpdbjkSD
 mm6Aekq1c8lSdCv3JQn/Z6RtifO3XYlW46bdK7FmvGQf9x3INjalFr9SxayXDD7t4gY3
 f7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=56U/+XpL0PrbPfT7BBDYGlQc/1Zj1VLCiyu38mkoyo8=;
 fh=W8/f/M9jxjUraLqdVrNjjZeASRCwT0Jex7TG+FXiP8w=;
 b=Z9K5IMgiCLBeJDB4V8Q3sHw7pEjOF45rbcuM0QrD27igeGXD2LCpJ+Fr5vnvfY6Yda
 pLABhYsMJLvOfz/7VT9+odFNGIPvci4TXRF41kz/2d96Tnlw3Rpl60QY6V0owzpOumVw
 Ep3O/yTvhRSpPyljF8J1ocgIwLa2D/E9nsynSByHC2oW0PBuVtdFQzoI3os26aBaexXk
 Se0zxMT6GRPssd5lePn5NgYro2NTD45Q9XL70xRP+pkEotHhIFK+TGRSbl7bVxjPGhJ/
 VVHGt8adExgSHS2XxHzqC+nctOHfteyBYH982embpvDPjPuzV94z9UUxqVSR6Vy2iizX
 ZMDA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792399642; x=1793004442;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=56U/+XpL0PrbPfT7BBDYGlQc/1Zj1VLCiyu38mkoyo8=;
 b=xqH6GiqE2snbSJ+9Eumgk0kF3OAgkMZNy2ihtEtKVsSBflBb/O7cYUXsy5uo9lXHpC
 Xfqqg84LzJ3tgt3bUZaUn0lfEHk0bwf80sop8ZSBdcBoBDKuQLYx3ke/mxsOlYfNNsLD
 EOCEidx9AU+r+AyNzbWAc5t47AVOoo8alHauKdH9vBUYlhAVP3/v2uTHKv7EUyrx+Zsx
 uPd7/1lRLlH1dKdlHs0m3wCjmv15GoPmyRvsA8i5TTr+B19yybnfPTwlmEpUUwMNkEZC
 F0Wt4+yl2ddr+oI3ro3y8wBBgJR39u/dimngFGhfcVfQ9KKdqh9sPxF5yNZc8zi3WW9x
 NAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792399642; x=1793004442;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=56U/+XpL0PrbPfT7BBDYGlQc/1Zj1VLCiyu38mkoyo8=;
 b=saI/K7R+Er1HkwzQ5iZPgTP1eGDph1h6PQ/vM4dBOx0R9CuaJfDPoWaZlZmzSXw9jS
 B0W3wHaFtJx6ZsqIhkbC9BKTAtwBc+uquvb9KUfDxoPqicg7ZDg/19mGWdHsUVT6UBfT
 1qBc2YBbvIHxlSvnqRWFkWL5LUSUWcv3F+6ruPZIfNwB/nETEvl5YSVyVGgvGdg5h4L+
 TZy4HFkgYrWPTnThWPcCDTZqvpDDCZs15gD/6oZXa3e5dm3CRZ3sroun5YLmL6/NHDBx
 6wtRSsTHaM7fx8KcH2bN/dmD0oZvUsbILL2DP9dHRyMu+Rb9WQfn2IL3jo6U1RH6pxAg
 SGAA==
X-Gm-Message-State: AFq9FYLrv10VgDAfCrbm5y+pyG9IEW0ns4Frs74cvSELql1tZt9niP7v
 jEXUCoFzXZmyWln1/fCd6MSUNBX+b+xHmPDFAvGbY3gvlERqGjamwxI++Se588Vr700up5Xthmw
 txOFkB+fBChmLrCSN6ZZe6vbI7/PtJXMUSSlJd35ZUQ==
X-Gm-Gg: AYBFou2E3wb32EP35zitgxOGLdaEFwJzP7F0vnLtRrjsXyJwEgGk8PyKojtRMordCcL
 8HDX4vGUsHFcI7pyDvvO2Y4AjxNKMYbt9YpFz+LphIwzJwjViRjFz5X/M5jk5Mf9zWS2f/dvqB1
 Zgm+7W3dRfUwWtxVJbiJcOZ3jM/IJ2LA12bJ3z602FrbHfj7BufMclGg6yrZ3QuWfLUQcUdMT5H
 LkRsxtcwSge3NyBGy8vmnOC2NJEg9NWlGEgGu2jTHgdCtZowKtsAIheXGlYINp9v93tPh2Kcx+k
 EtmPxEvhtyRVkyPuMahTMRjbXvCXE4GmYVXBn5A1JN/XIQh+8lbDavbtxf2kZOitJ3Z4aAgp3V0
 o2jzMSL+OHOUArtosjmCj1HK7sR+Z+Y15jDi7brf7AIuHjbJW9It1+T51ADFptf8ncjcxxvlmYI
 JN5t3BOLmNlSsZE9JjdMBT/QnB84OOHr8V8zBYfnbsUvJiQ1dj6ydPK6s6di/adxdqmU/09CdT+
 DT8OuWWVdisKgIZQ+8UmdrScuXXnQF5T5xVTae/Cbh9yqnwKQ9sLGkvTR8jBblL6VjYpZMUqD8I
 LQAA1ksX9F57JVWhltdDtFqyC6GZ0kTfE07Np1pj1ALD930SWA7RqMzmispCted3mANnlMW82S2
 aD+jWyee7yWf+TXrfO+HRk+/0qJhda5xtIzlLx5SLoZXWNAascVY+ag==
X-Received: by 2002:a05:690c:883:b0:8b0:dc77:6b49 with SMTP id
 00721157ae682-8b0f21d02damr20562807b3.40.1792399642457; Mon, 19 Oct 2026
 01:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20261012-upstream-optee_rpmb_b4-v2-0-85d76a54273b@oss.qualcomm.com>
 <20261012-upstream-optee_rpmb_b4-v2-2-85d76a54273b@oss.qualcomm.com>
In-Reply-To: <20261012-upstream-optee_rpmb_b4-v2-2-85d76a54273b@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 19 Oct 2026 11:46:46 +0300
X-Gm-Features: AclHuK9OTqHaWXNn2gJgQ5nCUjYlz1HXgnjzuejJuUiP8Lwt6E1hw6EyidtzIAA
Message-ID: <CAC_iWjLJ6_mVq6F1dizbJ7ouMeuhKBg1mEX1q3XpJvyeLjWK5Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] optee: do not announce RPMB from within a
 supplicant RPC
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Jens Wiklander <jenswi@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
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

[...]

> ---
>  drivers/tee/optee/optee_private.h |  2 ++
>  drivers/tee/optee/rpmb.c          | 11 +++++++++++
>  drivers/tee/optee/supplicant.c    |  4 ++++
>  3 files changed, 17 insertions(+)
>
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index daff3e04493..92e3b3bea10 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -42,6 +42,8 @@ struct optee_private {
>         struct mmc *rpmb_mmc;
>         int rpmb_dev_id;
>         int rpmb_original_part;
> +       /* Non-zero while a supplicant RPC from OP-TEE is being serviced */
> +       int in_supplicant;
>  };

sandbox uses a different private (drivers/tee/sandbox.c). So you are
overwriting ta_avb_rollback_indexes in that code.

[...]


Thanks
/Ilias
