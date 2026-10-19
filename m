Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96470CCF2E3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FA2D80F7D;
	Mon, 19 Oct 2026 13:16:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6eCof_C6lY1k; Mon, 19 Oct 2026 13:16:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8324D80FB7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415818;
	b=J84QqLwEJBc+k1FiKrzeqt5GZ0vmus8Xd9szddeb8drw5zQyzwUwjxkkjC1Rh5eZshTm
	 4oTSMf3kqiDefmOSMnVUqUGPrTSO3ma5vuvV1UUsRCBK+tosLk8ksdkrfQ1ulcTBg5D5+
	 VH5k+LQum4ANNdw7xJRdP892nd/TsK8l1+APvDgb+sum6ID7Az5wzIsaOUN4/1minxq63
	 XJrdNHnQHRaVbihzy2rCLsD7kaCbSgFjdOFNdRP5PRoEgQtWihxVoFzhEczBvRXg5YSmE
	 JmcMyN4X1Z3VyndDiZJOUPr4GtlAqy2exlDGolnCp626uk8mEsq90eXYQ4XXUoXeqyA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792415818;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=et0sfUWf7CFfnje3j9ITEl/iW2Kmaq9iuZd7oDlSTBM=;
	b=M8wDzQDEz20MKFqZcTddlmBjQl1ATZcZRmha4DPtrnoUwe7bJlnPRUXiDsQFS+o/TA47
	 VgSR4x7See+/0yMQZM/4rGRNm7VTETtCBGz3FgTn+W4BuUFVEzIJx9TBYDRq/RcnshG4f
	 LHq2V+XFdNn9Vp+OyPrQPvTxfK7yyK8X2xvuCRrpFt+KVHR/ckL2E5z/9MucfiNHDrkLf
	 XgeVTR3dWwpyNXUhGdwrVqYTBgkYB0tWvPGlIYVMlpfWYqy2zPQooxq98CQVMUguk2B+W
	 GFCjZiW9JVVPeWeMnJfOYojhJrn0Cn1Q0gIFK7hPJhS9LBqIRcodQlFy8RN9PlTG9bA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hQmkdHbd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792415818;
	bh=et0sfUWf7CFfnje3j9ITEl/iW2Kmaq9iuZd7oDlSTBM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eNHm4jIS+qG+P3agq2zQf2mJJFShvUDuK8mchoMXJKOn3tOEP0mO5Fln4nJIx5L12
	 zJ+aaCERHRpflpJ/PKvr33wKAFqHpuMl/dRQAOEokC/53vfl+d72JBAHjv/Hw/DBt1
	 jFAySHbYMyiHtZJyYyKyqm5YNWxao2uNAXacBLEEMrnx6FNmFrD4Nq6EixngnVNdwF
	 JAiBoPUUO21bv2RoV9oXqojDhvqjG+CppkaZUVQW+nOG7huYdeapXTps8JQhUlhXtH
	 zDyQACnizKal7eS33DA6Bbl8GzthuvJrYa0+P+duIfC4E/iVxRbNHhyMxEwQztdcXC
	 d5NrwLux5iH8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8324D80FB7;
	Mon, 19 Oct 2026 13:16:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A28B1263
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:16:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A04AF80FA2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:16:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oxYfhU77lMfr for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:16:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C0E1980EED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415814;
 b=fGSjBpHyAA3CeWxseh2mkDmd7ncGAcQcfIPwJunsO2uFdVLWtT5NNS0Nq82D4Deni8wD
 t15D/oFJ/PC59rai1eU8TAVotU8wq5R8O6me4xNDyI0K94D1SxzMLGA9YKjHwGPNQie7h
 LK9ljElt+WMHs0rEASvYKX+spekQ4Jd2N2B4PVZE7dzYGbw8fMQ4MXqX2kYh8a29w8HUy
 tyHDB53oJmDuPIgoytyKzaohxvybSWrozsChncStINp/fu/egoU2q5G7fX27zZ7BwUGYF
 guNr/F11GUjMDZAFktpy87R1djZ/ox2EXXgFuZPB1tv5n7vfK6ALsBDUE9M7mNxxWhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792415814;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=et0sfUWf7CFfnje3j9ITEl/iW2Kmaq9iuZd7oDlSTBM=;
 b=jQDFR6pXdnokh+wPJQSzqDO1Rj8jZaPIPqAZzguzyoGTJ5nP6WeFd4Txyffs9AaLV7rq
 ZI6bAXJJXop4q6hJh46b17BxxroMja+0NMRLmBHoNcFhoZVYwR+O2EanjofAH5bSbZksI
 0pkw+nz/WnZdeowQiwhX/hFSuSGFvYIgpNtMIF1Nkcurgew/Yu98x+rp4VCZHgNV5wcNW
 ZjPUTQXUqLP1hq4h4Cywk8fk7jRpUXnfi7BciHtgZrWJG5vP8SF6hXZo2ypltV5ACt27Q
 nMD6hnNSrwOaOYXoYB+gAMzMoN7p9jq0MF6sh/MqW4/gyvhyu9BX9yallTzA5jci/gw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hQmkdHbd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=hQmkdHbd
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C0E1980EED
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:16:53 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so2792849a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792415811; cv=none;
 d=google.com; s=arc-20260327;
 b=RZqJt6okAmHkxvpmnk6jY9F1T2hOTAwtPJ98AtadSBxLQxyaQuv5kBAK5iHsQR0dvr
 /vimAHDePNYpzHk1dehGyZAF6wVhK3MVXTjLe+OcsaGLgmkDLwoo3gJsGp8T64G1zmgh
 WNib7sN5G5hCZfoQlp2HRbTnjTHwueWnX8w76j6wVcoDRjZDd1oMjGDpf4JWxpfY0QJ4
 f0IEO00X8FEjA/cymlPuAAbauYxZbCh/a3jCxLGFZqzlpPZjinCvpoy3af1KIqv7clFU
 ObEZJcp1IL03PDuJ7pnqfyRsnmkoMfehvpN0xmImjMlu04HOFdiRbdJ/Z1NjKXK+XXqf
 hFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=et0sfUWf7CFfnje3j9ITEl/iW2Kmaq9iuZd7oDlSTBM=;
 fh=Kd5Z6/8IXVO0rzYAW8aLujpMoYMccPnQH02Ith5eVUg=;
 b=r3Nv0u4ISjKXk9E9E+93DL5vCKt5gGGm4MTM5ZLc1KbRcV/3kVtmsvtBcKmOU3O+NK
 YBRRHlNYCCTbrHrMFTFnZeXchceUwPveuuQlaIhxtAh7MTgMo9125jNXiQJRKU+xhNjU
 6JmA/v1zAC/TaX7+goKI0u7Lrt6i50Nqqln1nr7N2B3Z0rmfEzMjOr3z+QOzGCInpd09
 Hmd5e24HOMfc4eKdSRLW8Aul7cTtTG7DM0zXAcBpHYLzqf14CPosa7AL9CoE8I3mALcv
 UZDbC4qHjPsNY3o8fuzr6sFqt2ym9pOvxYsxplcq7JwE6rfPmFEugrnUIcOsBoeCiNHD
 XDWg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792415811; x=1793020611;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=et0sfUWf7CFfnje3j9ITEl/iW2Kmaq9iuZd7oDlSTBM=;
 b=hQmkdHbdC4/TVzIYEgk4kL6N/x8m26nSZ1g4pi7KcSNgusiUBsWTSDKkFPQfY8QQsx
 vMsN42IC8EKIaFcIj06xalfZTYooShRcBwZieuBtqYa6EqgvtQPJ0DnE2EgkjMfgXJim
 xC1dB8VK0HDqygIIe87IijICoIHWHDKD8DUC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415811; x=1793020611;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=et0sfUWf7CFfnje3j9ITEl/iW2Kmaq9iuZd7oDlSTBM=;
 b=kY4nZ40HGny5xS5KsEJ+E1y+56zQ+IGG1jEmWGbE4k3VwatAlkA3Bj9tsG0L9MtEJH
 /JOK3mSu5P86SCpRsllHgo2mFXghjI+4v6NG60Q5np0aRKOVJKbEzqKtLz0A8Z3YVRqw
 2K4AmqkA7yXA7JWvveVOKgX0/V1+PSvn94ZT1vSZHaa6yT7xQTQUrnWNVtClZCV4Sbel
 cAdd6AYproCFXSEHti7pWYnlq6PPbTmyeJlq4xNPyVarTFAQ7y1ryh3G6BsK27bVMsDn
 A8ZntKTeCqw2M8vpOUu5vr9GTkU+/yaiLT5M9EKiq2HgOdRguQQOwB3y21eh9pyexyVg
 miEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByQ73OL22/pSQrGxL2aiYooz6HUYu8u0F51RCos6DApOyP4lkNe83WS1nbtM044PHvs+cNAUVI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLslwmGMNcgfvcN4V3wNeCaXS0bjxg7V14ZlUG6TRbyWgwrTu6z
 Dup2Hu32iEdQrxJEJMDtLvIdzKibC7JUTCtofXXY+O6wmz5MWrTv8CeKeRsKXFci+O2Fu/FmUse
 TNqxAJDchbT0xZudKmyYR72sFS4wC7KqsbRQgxD+M
X-Gm-Gg: AYBFou0TaQIXJYYe4nUaLgqQaF2YJkazrfihpiWwbmKVlYr5OaH1jhVHeXmkyjSoloq
 S0HjXmDfH6BKC3j8Jn4TABKt0Y1bHTnmneDsq1YSBJbBfU/t6/Sc3lE0Lugvd6AIDE1tnGMnPXm
 dNtmJgWZLxO63bkx53OgfUCvegtRIl+h3NeNWNG9YtjiaeeJhqt9KdWQyru1A+o83Jr8wKZIR+H
 0OE+QvEZKTd70pmxbiK146QX8GICvcsMTaY25JFHck0QeQ0rPIuggItq+N5VuKLhQLAjnB5/ouA
 7KgNWI2gPLIam8uRtdPTw2+etzF4knGcRM0JQD91WLTqKD1dyzmLpA==
X-Received: by 2002:a05:6402:4414:b0:6b1:bcb9:15a with SMTP id
 4fb4d7f45d1cf-6b3a818f957mr4906080a12.20.1792415811519; Mon, 19 Oct 2026
 06:16:51 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:16:50 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 11:54:50 +0000
MIME-Version: 1.0
In-Reply-To: <20261016065500.137544-19-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
 <20261016065500.137544-19-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:16:50 -0700
X-Gm-Features: AclHuK-NS_GUvX_qw4oFHTmZ4eVex49Xmp4V5se4dtBq9O3muMnQS5uSfkilkn4
Message-ID: <CAFLszThZznbcjcwOhhNi1mT8PW3kg-mP+9hE=OVwvpm=xQhLqg@mail.gmail.com>
Subject: Re: [PATCH v5 18/20] doc: arch: Add documentation for LoongArch
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
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

On 2026-10-16T06:54:41, Yao Zi <me@ziyao.cc> wrote:
> doc: arch: Add documentation for LoongArch
>
> Add a brief introduction to LoongArch architecture, some notes on the
> implementation, and the toolchain supporting status.
>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
>  doc/arch/index.rst     |  1 +
>  doc/arch/loongarch.rst | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
