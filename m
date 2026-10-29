Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329C60A3822
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NoZyUKA9;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bvfK4Jxj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE1F080C86;
	Thu, 29 Oct 2026 13:36:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rnbEed71bJLk; Thu, 29 Oct 2026 13:36:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0168080D0B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793280993;
	b=XErmPnU2ajuAIYfTBOaHlBR8OnN5SHlmtZB/eVYuCRkM+QduCxcLkNVzJjXc/WqYSK6a
	 gvN8+6Oyt6W2emlXZAU+lZqfjxH70DbXgp6clrmGmfU6ZFP8cLhRq17Lk1GpQFGfcmuqx
	 ZVqwuDeid3JejsmfmbfIasEsWvem/MPvuVIUQ81ZHHGuK53JHf7Qt64LPjOFIzFozcoht
	 9k0NvPyyaGWj804JRCtOD6uzwpjQgY4doqdczQU7YZViTyyxFSAozitDHGT4jdNLQG2AY
	 LKTHbgTjVNuf16DBYoMZIF5Gqj0NwPyJqgq5kJH7XLNkK1S5ee3GcXEeEprEba7QP3w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793280993;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TrgweZmug+hmUGEqPFYQQeomr+5cOWe6LqEVmcBnwRM=;
	b=SQT3Ia9xKA6EjkZxyIEaJONwDAKk6/Hmfc4INvWgc5CDTXB8fV5L2QLSCTmtkIUiawzv
	 ajaCUa6qYHxtP44PdkeJX/+A7ZGD4guIOPaTAF3CSi1i3bCdrom2SR56D9u0vzyVWeRcz
	 S0VuXi+bjndRZGkRMSnlcz48g8fuJVW4dpcQL5NRtzKZloZzf+bu83dtCCic3iRT6DUNw
	 Xaf4DuLBqttP8ovp5OrLdkidD2qKxsp1ztGEO8JeEulQzak8Qyx5HXbWKYjWQCwifLMwa
	 it8jBy2u01G3Dan0GzKfO97QioxZCBlYDI3SZGDkwyMSuLqHeZbg9pQQmsBOVtFWRbQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793280993;
	bh=TrgweZmug+hmUGEqPFYQQeomr+5cOWe6LqEVmcBnwRM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NoZyUKA9kR2m4WOrdPxykqBM0nDK2kt5W5JfItk1nmmjatFIBNjN8Q41TKOcmqPmW
	 iowwphbEq5kqAAzKVbV7mJQdFjOm489QmJx6sFGpRy+Y0YQFFp6Dq6h0aT3Wzz3uKQ
	 Af3rrVr7cP9sY36XHzC6i838jSneaqjt9hx8y9iLAW4hM1n8MXKeRA42e5diDTgSKb
	 M/oy68ZhP++IMuvAAYzK/COBO4E3t0cjzEXtT6r8cyoFQFQpJsXcCI4Lj6LtszWBCy
	 Nym+LV9qI9CNEI7vtdjOu+yNsjmujbhJqIy7epvZlWmCTw5oTvj8GkFqySbLMndKJ/
	 E8JTxJJMALhkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0168080D0B;
	Thu, 29 Oct 2026 13:36:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 561EA380
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4685A606C2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:36:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6vyEOFq_aOez for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 13:36:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3962560677
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1134"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793280990;
 b=NShQk7PLkR0iy9ZmefRvgfz+cUK9WOBWtYJYdvr+FDCZ8aB8Wi7i6PSfvTgjCdK/oI0K
 0Khe9qTOSwOfId5i4KRS6RvLizwrHGKizgFUXUhlmVQMAm53nwBlkBwBpdTBF/yU84NbS
 IMYSbT1viGIpZAjAEF0sDbbwR+LzGgCH34eHxMVCKhvmoqT+Laz0Fsg1QJLv6TA81qMRM
 pLkMtDZrsTtKi6koWFTmy0CUeOaZVJsF95qfRNIMaAvTM1onMrTZGU/LRxJQspmpRO61S
 bfc0X2GXuUbcVTG1fQ9tZUPiO1wOMdU09GWC0PA4g23sqVPKwy0+hCTQMSGyhyxI9Gg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793280990;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=TrgweZmug+hmUGEqPFYQQeomr+5cOWe6LqEVmcBnwRM=;
 b=OJ/hj2rpJhrzuiw0lPTEspzvRmQERzVsrPLQWvzgHJU4DqQQD+8AU+J+ni69SRCLCMsk
 t1YxWo8uOEU0jHHhUlvKOUhAdAd7qOO6JlnwcFqvTe7RqfOBcZcNL+5bQc1u7BXTvEUHq
 U+gdJpBTlfvohKSufmOZ+ory39Ytvs/QKKrPyeGw4iiiej3LS8k9XVTchXAIqWPI12Zxr
 luGf6F74N7RNxHpA2pkX5lPtomwIuKsDOHkKcJ4Lj9R8Y8TEpXBqMAmY7QYkBrYBj9AVj
 HSABa0Ck7/T02D5DmUcPfYQs/4Sfd/mfL6NoyR7S3//+ZtbJpIVAA/z65CoS5EAYcFQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=bvfK4Jxj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=bvfK4Jxj
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3962560677
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:36:29 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8ac9d666d4eso19562287b3.3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793280988; cv=none;
 d=google.com; s=arc-20260327;
 b=VPgfu4jGqdjwkl/OitkohpD/PfL+A+t1PsrdtMqSYNWR8uiWno7EEw+/Vw2DjQeQ+7
 eRqpbD1E1tyrjKfAm0GXr/unyHq0KVwG+VqI/23p7sVGBo2jaJnGs0nsmUl2pavNQcPL
 x8mPoJZJDJhcpK6l4Zxv+f83B7cdadtYiKETunyz3rTtWao3GQ7SulsBGQw5qOqGK0Mu
 zZ3lsAKsodWoGBZSMr73IW6XTRh5cHBRD7PuQBm4bMVF4wbHUsoki0D/oxbCDML0rJ/W
 OmDpMMv+JqCscUT6qQkSFmN8IHsduShyEAXj1gSgiUiYpzxK/CMq/wDC7yRU+2nzZif9
 A5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TrgweZmug+hmUGEqPFYQQeomr+5cOWe6LqEVmcBnwRM=;
 fh=W8/f/M9jxjUraLqdVrNjjZeASRCwT0Jex7TG+FXiP8w=;
 b=bJy8hpsh7qdv1DShTRizVFTFaSevbEhozK3+FQSDxUkauB9ES9UBCVST3cs5rmVz56
 KuplmS9Z09AINQu0GZITib6rofw3EQdL8HwpaPgTB7eIiFdvq7NBc1OhwZfWOOE0g8dG
 6Uv5xNCXRaZMCFbwFwx50YKjXnMFexGEqvePUlS6N2V4eod26qjsLLmLv2cISAM+qlQo
 Yxksd16WXQwEK6qk4c5w8upUdAuzolirR1SGLBkYQgxEdwOy4fymIg5ne2CAo1NvwwHo
 b6MY7lQ22PhHqX8ZIGUa+UL2SN3tIRM96GmQgJpVsi65CD/pKz2THDt9pr0ezp/VZzM4
 EJSw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793280988; x=1793885788;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TrgweZmug+hmUGEqPFYQQeomr+5cOWe6LqEVmcBnwRM=;
 b=bvfK4JxjCAnhdkJpOWzP3YKCqhtSyRv8jMrTpmsqM2l7viChULtdt8heB8/m+9Ug8+
 rBakYk5hVhf2LQB5bEF0SrgDMddemiVkf8DF0/KggFWE0mhD+8yOtSUZzr+m3Sub+W2y
 tQSht5C9YOVo/cweICoY7F50eVvTHuI5Jp1o5e0mxzUH4E/Yefcar3XYI58DyIL/SWt3
 2g16grM3BUiPFBh8MPGwxvF2LuLGImS4VtrYnEARJmmk3jnQjW37bZTN2YYN8qzsjHXP
 8sRYQ+QXZhdK0CLEYN/fyfPa4Mbd/zDPbZ4Ba8KeCRm0cgxodAx4T+IgLckzNlL3A+MI
 xngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793280988; x=1793885788;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TrgweZmug+hmUGEqPFYQQeomr+5cOWe6LqEVmcBnwRM=;
 b=R9oUgZ8Ar/gIY2WUkC/IDd5RifQmkStvu1YViR96aOhCPBAahtvS9dRWKH8z2jmg61
 Xv4iEb+nHsORIJ7X6UlY+LdTJqESdiPLj5zCzJCgFvnubSPKkLrM/i3Dw1/Yvj9udxPq
 Tobera0JcaiGJLdVg0Dcq35+Vbmy1MonQRuw4dgDwWZQKiiZV+qKT/b7iFbe41MQfPRY
 wt9F3DVdE0T+KToKw3/r85+c4i6n7MsAEKMMdJYehuaANryo/1PKn2iHaj6//Qw9SIQw
 AMrUTS5rRbO/mtvkZPhc7j6ldBm1/1LSltyDTgUgop576PAw+btrXOShMNzNMy2gWC6n
 7nvg==
X-Gm-Message-State: AFq9FYLfNLSHyGLb8V4FtKjsJ9rJiuK56YjLWnfCTOd4Z0JlC+gFcp+v
 5lYtI2nyJmV3lwvODB3A/jMLZtXn3cJJkF4AIyw0B0jgSYHTA7HAn7jlf/Kdl9jo5NMbwzLoANA
 hvoMk9svhrmRBIzfVVmDJ6AC+b5UOuXrikUj9fa058Q==
X-Gm-Gg: AYBFou0n2U18drlouMxO5+zkZ0EZXGrXNc0t+mf/vjXhRYg5ur7o9k8v17fcSxRV7XN
 3spsQ7ws29LSRQkWFy9oCthgLY10dlKXnBR7CKpX53vYSBmil5jzTaa6Pj9PGuhYnWwYMeLxPec
 H2Y+LNaEZYaiCIle1ODUclNSpo4xq6g8DBMwEXcmsf5sl5TDEseG/utzJ6kIQqmNSdpYCy9vJ/A
 Z0PQ2+gBr8CM2P8svNRzSoU73QKhgthz2leoSddFWoj1M+VggR7uc3sxMryj+7BjrUEdEX6zfPN
 GGw8dnTF+7y4XkJp2eX03dFOxHjVdvrGN05idQaGNWEcAP+PiNljdf3Dy31DFCs24A/vubDfgr6
 xPkxhnohT/88HNahWoMel6fNQTQyi7DC+GF5P5GvOL6e2jh0hfO0zksI42Q7zYo5A07ZzuFqH80
 7pb9rVTmP9B2I6/M6JEcekW42m1QdiamxOTErFIkN/LwDX4/AG9Ng4tga9B6m4W1OuYsht5dHW+
 mgFhKkBI9mIbx/0c3jQd8vJordXH5VttmYdaSyJU7l2JiUhw/1m7R9Rf3nwJ6Obh2yF9zp+wGhk
 W3vIrkuSObXT37TsJ06tYf/A4qX0yIgNagT1zFHEddPwlBtLTOwUvYETZ/xt9Wt5b9yp+HX254F
 BC+w2YOczj5ErEH9R6GWvGwkn5yNBMiRVuluif7R+SEVZUmLaK4MkNI0N/Mx6DgjX5se9Iah0fe
 tLhXU/7Bsp64AGMKlwvaur38VXsNPUQtG6LMFxKuq0EffYCWtn1oj04CNR
X-Received: by 2002:a05:690c:a412:20b0:8b0:e7df:dd3d with SMTP id
 00721157ae682-8b1b5c30661mr23363187b3.57.1793280988343; Thu, 29 Oct 2026
 06:36:28 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019-upstream-optee_rpmb_b4-v3-0-c97cf24fc56f@oss.qualcomm.com>
 <20261019-upstream-optee_rpmb_b4-v3-2-c97cf24fc56f@oss.qualcomm.com>
In-Reply-To: <20261019-upstream-optee_rpmb_b4-v3-2-c97cf24fc56f@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 29 Oct 2026 15:35:52 +0200
X-Gm-Features: AclHuK_f7xc7KSso5eNvzf5No2q2rs2xzgBmLsKz_U3z2izQwGT36anSinGdFuQ
Message-ID: <CAC_iWjL5V9q=4aJF-T_FXjTTevy6ix2L-PEfE8UcP8riR-duAQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] optee: do not announce RPMB from within a
 supplicant RPC
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Jens Wiklander <jenswi@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On Mon, 19 Oct 2026 at 15:10, Igor Opaniuk
<igor.opaniuk@oss.qualcomm.com> wrote:

[...]

>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>  drivers/tee/optee/core.c          |  7 +++++++
>  drivers/tee/optee/optee_private.h |  2 ++
>  drivers/tee/optee/rpmb.c          | 11 +++++++++++
>  3 files changed, 20 insertions(+)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index a47c76811cd..f7670096b61 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -424,6 +424,7 @@ static int from_msg_param(struct tee_param *params, uint num_params,
>  static void handle_rpc(struct udevice *dev, struct rpc_param *param,
>                        void *page_list)
>  {
> +       struct optee_private *priv = dev_get_priv(dev);
>         struct tee_shm *shm;
>
>         switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
> @@ -450,7 +451,13 @@ static void handle_rpc(struct udevice *dev, struct rpc_param *param,
>                 break;
>         case OPTEE_SMC_RPC_FUNC_CMD:
>                 shm = reg_pair_to_ptr(param->a1, param->a2);
> +               /*
> +                * Tracked here rather than in optee_suppl_cmd(), which the
> +                * sandbox TEE driver shares with its own private data.
> +                */
> +               priv->in_supplicant++;
>                 optee_suppl_cmd(dev, shm, page_list);
> +               priv->in_supplicant--;
>                 break;
>         default:
>                 break;
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

I am not sure what was fixed since the last version.
This is only defined on private data  for !sandbox right?
Then it's used unconditionally in handle_rpc(). Won't that break builds?

>
>  struct optee_msg_arg;
> diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
> index d4abc48f764..a40573c9281 100644
> --- a/drivers/tee/optee/rpmb.c
> +++ b/drivers/tee/optee/rpmb.c
> @@ -210,6 +210,7 @@ void optee_suppl_rpmb_release(struct udevice *dev)
>
>  void optee_rpmb_available(void)
>  {
> +       struct optee_private *priv;
>         struct udevice *dev;
>         struct uclass *uc;
>         u32 tee_sess;
> @@ -219,6 +220,16 @@ void optee_rpmb_available(void)
>                     !device_active(dev))
>                         continue;
>
> +               /*
> +                * mmc_init() may run from the RPMB supplicant itself, while
> +                * OP-TEE is blocked in that RPC and holds its RPMB lock. A
> +                * nested call would then deadlock, and OP-TEE is about to use
> +                * the device anyway.
> +                */
> +               priv = dev_get_priv(dev);
> +               if (priv->in_supplicant)
> +                       continue;
> +
>                 if (optee_open_enum_session(dev, &tee_sess) != 0)
>                         continue;
>
>
> --
> 2.53.0
>
