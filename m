Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AF1C79F82
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 00:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AD2240AFE;
	Sat,  5 Sep 2026 00:14:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Y9PdvFLMZfV; Sat,  5 Sep 2026 00:14:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A5DC440AD4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788567283;
	b=I112zcXr7myO1fzGA3cPQeFpIfMEZxJFYc7rDtqN1pRWu0VBlGZzzIxrBoyiWFnmnkfK
	 UzBeQkZP1SoBDv5S1FyZFBIrWJqlBCH+7ZVG7zYH/5nyu/ggj0nxrt0ocMn06zxGKv+lD
	 v7+gefJpQCP7OJeqMh3knCt3SPzpQzKqmlS3VKFgQINqRn0BjNcxIm7ReeLYWxxVvrFmC
	 zT73q9Ewb/XuUzIQRmBWog0adZl5+d6ouhFe48EXxeAdqk0gr4rbsoW9G0k2EyAHlBsZJ
	 gXuxYJVhTiF4dmHiNh3EkUJwwNRQ4Z4Yzzd2U8mNQpc5HMqTRWsoDzMvUAo09VJGT2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788567283;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=if2AvSx/+Z7hhu6h3q/FvD8APyMV4snZI2uzsmTjLME=;
	b=sFmRGYXcSjR8d05n2fDrzqZkMXaHX0hto7ojdRgVVNIP4NpUJ2n0EE91TaImjNerxNsr
	 WcZmQXLLHB+TcyPlmFEgW0Fnid+kKsBGU/CpZRh0IwFLPd/CWiNErxQTzlQYvq48nNoOT
	 MVGqsyPoqR8LsGeyWmeiOa+Sussp310ZCJLimznd0xdzehcNxMejGL+eED2QVR8PtrcGU
	 E9sXXjNzjDHIlu6RMF0UuFd3SyUTfNkUogCVq4btLyVN3xVB7+tp7G3blEbq5Iiwa/Ipt
	 ppdSNg526lT5SGp9KYKK+ssr581Fvi0Fp1mHOVjhkjZvropK9fRsAEe92ztpcNbVoJQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=i2BcgJWh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788567283;
	bh=if2AvSx/+Z7hhu6h3q/FvD8APyMV4snZI2uzsmTjLME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xA+6CaJVjt8DigewtxXzlolPufPL7cbjHckwFsMWTztQaTePDbD5m/h3sIPBsZoUS
	 t8gDOzkTARgU8T9EKhJB7rHlAuGYnpx22dmocOQ3yXvSvj6f3nxT+hRkrpgihj0K3Y
	 Ut+SjOPHD8Dz5e73HuZQobR1fYblPBRhb2i+QPh9iWVgn7FWS6xYO8gTCeClAzGgqI
	 22WYM8tP/SQr8dj/JPmalsKOw7Cnw40IGlpNBgOCAGmH3lPeB/XKiIGXo/+FBudSva
	 9dIKYAemCPn+FZDyiNkOrHRR15hOoe/2kjl56Pg7ySxjSZ7aIUJFrvQVsPD729Rt4I
	 kEEpA60UY8Tjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5DC440AD4;
	Sat,  5 Sep 2026 00:14:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BCFB82C7
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 00:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC37840711
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 00:14:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mmGSV1Vrpu9U for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 00:14:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 005854053E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788567279;
 b=LRxaSEUiV/OySI3TIJqiFltESCSa4rO9x7McrQef130V+RO2o+HqPkBMM8zM/eSN+mLi
 Y9r3h7lrF/jv7JjFl8Dt2CVzJyug34zhn6zMYfvpYgAakdD60cLwtqnyOm6lc0BXrBY8a
 8KdcRP2Hr8qKzptdS0mMmSVEae+ePxfMyqnGkkb70HDPwwXxxqRHDcxOvFBvy9QemCCNN
 RmoIbNBv7buFGhXmERrpGgramDEkOUVEUowY/+5+EgCnPYcQQoQIxJkLjCS6k+KO3gv9V
 JEGZDX0/XDXPNZ09QuI8kjG0OoZNe/xFyPrCujIBG53iA3t9G9hyX/SopQT3IArm1sQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788567279;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=if2AvSx/+Z7hhu6h3q/FvD8APyMV4snZI2uzsmTjLME=;
 b=Ilv+ldgTacI4BsIu808gakr4MLJIn5KkS7vunEK6JGwOogr84QzmyD2imndoLZfR4e7f
 8YilFQI2mm7SzEWRVke7v1A7DlP+Qilyhh1i8uuuPOr3nWsKAOejPrdRw3SUGRaSpvN8N
 jEM6m49Be8JU62emJTz7xKLDTrbYjVzJYO/wMZEgoefRw73kCKng3MeJb16zauSuU05pW
 ExM4J4x/RvjU3mZuGSZtzagyabOcPO3xuv7IYEQOHMzXS+yZsWC6nNtNYeyhECaLCSLek
 9POLjl9jzhrkoT60p4UmQYIRM/i9btSJuquDX6l/yYk0AIzHeQUPyR1TbiCtkA4CmoQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=i2BcgJWh; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=i2BcgJWh
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 005854053E
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 00:14:38 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-497e6956acfso1518874b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 17:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788567277; x=1789172077;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=if2AvSx/+Z7hhu6h3q/FvD8APyMV4snZI2uzsmTjLME=;
 b=i2BcgJWhSdB34hHaKOy3Zh1ecn7r8F24PPEjVJLw64z26ek+SfBdlJr59yGKWnGmOH
 lj/ksXmfM/jNNMl0GSHelBSeqFAS4wt1LezBDXbcaHIaeYDlDuANY9iSS6q8bvFXSEaT
 INT5GW+CEHU4x/i/FkfQPlMKjLmS6iyxND6uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788567277; x=1789172077;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=if2AvSx/+Z7hhu6h3q/FvD8APyMV4snZI2uzsmTjLME=;
 b=rlAwf14wcAYI6poyDngXH4bC+Gkp0d8o6lUoDQ8I3phcfyEgEeEW4X0pImwnXxeJuE
 d+7PSI5cJD5ZVJX7RfHBVV31AGRC9hSYRCBl2P/wdwFaxpznBfjyoO3rwKJMVSzukp65
 e26ZJsiVoADQNeNcXZW5wtEH2RWlIHpq40ytJqlRGweczQ+GdY7gGTHUfRjSl+XTO1fp
 U0fTZbJ2zHjSWtnEqD8nqGGQy8xxoyl4ET2NVLEeUKyT7rOSNROTI7JT6PVE38TVvOmv
 U4LrkMJuA3azmaCLqghJRBegc0cDJb8BI7GBIHJkue2dTH5tEtdyXSK5SsMqTQ1ly7MH
 Ws8A==
X-Gm-Message-State: AFuF++kxA/WqJ8dWAGSDp4j1oYjA/C6HpyOo+ObW4UQ+MpCL82BDLqye
 FclBnS8zFzeMqRvXYxrxrttB0/7KO2/uPAf4oRItlDkwPKBTeA3TbibxRnOdL/Z4Qi2JMTizLxf
 5I55CrrAY6LaP
X-Gm-Gg: AYBFou1Vf2vAG4/hAseM2bhy0QomM2+Vrth2rSfeFTgLmXIG1ocWujWpFVnM3LbLmof
 KixbWMxgitqk/kvQEUE2byqrx11EKX0VdPFMpB3Nc2BpfDxfIgjHfH5gL0ArjRv8j1ELaobs+Bd
 cS1J8N8US4hHgWOdRa50aAaW6KfS7FvTlWtugkVk+sijNFM/eG8o7OGzUwv6+hmsiyTsoC/z9pQ
 G9DqhLLFOu7GNltv0dSqbRY3aiTA/b+7C5NmaGeLevNLir3z33lXe7X4vpc51EerQTrcd8vF5Zh
 RHrV0MO7a7MMecJLgNGRaIZyjLfuDrP4mA27EkQqTONUWUuvyZnERDmBMopYVbVm/5qU2bv7koj
 K4n8s3Fu5Jz+QchEt4iyJhn+miwVS1EHIn14dHTsna4/wDE8A/3yf0kn6pHzgauJ7aNyvQuh33n
 afN4T3qcu7tBEwbBKJmFBduKdQ2TX64zKMrE2ZhsnXkyCCkRH+4DuIFHudAIYzNK2N5lVZcOxDf
 kZhBLlSEXEujDwJBLOTjzW/c3Z9Gq+oYaMfPj/UjO2KHe0wep0k0DerX6r8tbPzf7nMQJs8z9Vv
 E+Lr2cBN
X-Received: by 2002:a05:6808:f8d:b0:4b8:46e3:e229 with SMTP id
 5614622812f47-4b97cde490bmr3752325b6e.21.1788567277458; 
 Fri, 04 Sep 2026 17:14:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b971b97c72sm4027463b6e.15.2026.09.04.17.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 17:14:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Rasmus Villemoes <ravi@prevas.dk>
Cc: Jacky Cao <Jacky.Cao@sony.com>, nora.schiffer@ew.tq-group.com, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
In-Reply-To: <20260828150600.918158-1-ravi@prevas.dk>
References: <20260828150600.918158-1-ravi@prevas.dk>
Subject: Re: [PATCH] include/env.h: use plain old #ifdef
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
Message-Id: <178856727570.3086907.15885557096110860522.b4-ty@konsulko.com>
Date: Fri, 04 Sep 2026 18:14:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 28 Aug 2026 17:06:00 +0200, Rasmus Villemoes wrote:

> Commit 9f1807e57cb ("env: add env_set_runtime() helper") broke the use
> of "make envtools" to create the target fw_setenv/fw_printenv
> binaries. The problem is that the #include <config.h>, in addition to
> pulling in linux/kconfig.h to get the IS_ENABLED() helper, also ends
> up pulling in lots of architecture/board specific headers.
> 
> Fix it by simply using an #ifdef.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] include/env.h: use plain old #ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
      commit: c46bd5b2136158d3380d626d79c96827818226c5
-- 
Tom


