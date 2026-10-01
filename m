Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFA6CA5FCE
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 08:42:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1FC76081D;
	Thu,  1 Oct 2026 08:42:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ekhcNhvGGIFA; Thu,  1 Oct 2026 08:42:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 103C660BFD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790844123;
	b=pJVhnAFnqW80WU34aLSg1fK3xSFcVDoQ2Jn09AwJ6OMb+ZTs6kJplAis8CiiAAJdu12K
	 yrAukBwKssHaR8KUTVlAoZENRWx6BxjHCucIhDwgqSSzQJeC4SuEVrVB8qvqu7JZ9y7ZA
	 TgLuwmmQJus4Y32QJvTwk2x+0uhcXCvFZrm2pU+6FkxEm71+rrIm33YDj8zPa7YNmH48N
	 t7oXvp+0jf7I3+6U1+1FH6E24VZ6kvSJDTaHuMlZTg2eXxj3JyZxOR2/Eo5zoGIr/T4DH
	 dZXZsTSVFFyL3lqyxjHv6rz98oP7p8VqCajVX8GwLJIm2EVgqpGSw7mbXLQrT4gIR0A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790844123;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZUYAI50OLfvCMpw2fzknH9SlKzGxxFMOJo0ao+/XSVQ=;
	b=nVQEMOLgHZRSbi0nZeZ7TT6EwJqTo1l7K8CGIAEf9AUzyDpp2ao3DzSLTuucAjfQKHrG
	 XQYM65tR3imIer7ESuhr95TNGCTC8bsUqDvEvgiC3BzNbIGufoaUdR2a2+BjyeH+GxKsh
	 twFRsW2pNiozZNfeqpR8U3rZHH/+8dDQt6TtAKKfriM9+xrY6SvFeSBhAtmxx5Xwgncwr
	 fGx3F7eckdBfEfIqXGq2Gt6/RIDXXxuids9grIJFmpwj8QbGhlPf6KfeaenEzgxa4JfZq
	 awrzNKI0UKZ/c94ddxxZXUl+/Rj9HGgK0bIW0hsWLRYJrifIDCPuVGJXLMOIDA+m1qw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790844123;
	bh=ZUYAI50OLfvCMpw2fzknH9SlKzGxxFMOJo0ao+/XSVQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jv5xtqzHNq+VfUCKk5OX7bDdfGKEjBlKIWQJ+Xs1v8SIquqaO75Z1G/RwoJAW4Jws
	 yU5d/T7F/4f8N75rDryk2MbujT5yNxVJa8fYoSX+Hp6yTj+vEmbmUfiujjPDq32FJy
	 PyFp0teUA8SaDTCPqMlqvLZ3RwLn7jo9MglSR/IwSQE2FBBuKjw8szlrM8t2Z7qL+m
	 Vd7Pkk2l+QCfrEB+Q7zKzywwaYSlM82UgCV4XmiBHzTg80Ixg8YGUJpHWqVYsJr1zZ
	 yBiM6Bm0XeM+xR54f3eA6bFxkkyg4j5AjP+TKR9kKfEZHOJ2NEm3W4PtJY/olsHKga
	 wB3pfo0NQYQoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 103C660BFD;
	Thu,  1 Oct 2026 08:42:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FA8634D
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 08:42:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8592A40D47
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 08:42:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0HDpVBtE-jl2 for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 08:42:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 82C0740D36
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790844120;
 b=B+q8Hjay7wEX3hQ4ob+DPTi0t23plvVZOW1AK0m/9q01a+JedKVCVTYjxRd0jY7sLzlQ
 bvE8DI4UHXT/Kk6NrUMM0DtVyfQEQaVUdL3mgnyAowKxwSmSKtZFMkjYi2JHfvzaUMZwL
 YsyBVwhYbGpl0PDlCJy40DpgS4ljF0pIyEPNhIBRMoT+xN387XAMYpOr8tTPshxBygE99
 spUS54qjSAZDjd02XLgCrwWrSdw7HlMym5o2UcFflmOiJHh8pc7lDOauKqX9jULGQizCd
 1vVCscB71fuDA+jQ5W3LZN3EF+j9588U/hfwAVDWSWUDgtwXckoqNaVK6TaSe+aI3KA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790844120;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=ZUYAI50OLfvCMpw2fzknH9SlKzGxxFMOJo0ao+/XSVQ=;
 b=J/MyumvstrI866Q8r0AUd9tVHq0TFUZPaT4n23KnuJt1wntp+rbJvW60eRtTcDMSmHfW
 LchNnS0UjGmJZ3vOM0KAktlErXkxRe1L+dvEuG3ixUDjfo0nrlepOIMx1aGhB/e6K/ass
 JCceuADXm0gLkweSYi/+G2GqsyC73hudtXlhi60mz7Do4XtducaLRw1ifg02sdDGddVf5
 i53DyrSnIMNRygnr+l8ptH0FR4hkxY+Ld9bxQ1LqVVlSgz0vvfVmLVYMtBlA5iicTktuq
 NGdKH6Rnsp776gc/SKo8MXUkFqLF0LSEXNUN+l7EfgPu38Yaj0/c+TkC7YKu906ZjZQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wrd46SYc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::f;
 helo=mail-yx2-x0f.google.com; envelope-from=ilias.apalodimas@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wrd46SYc
Received: from mail-yx2-x0f.google.com (mail-yx2-x0f.google.com
 [IPv6:2607:f8b0:4864:41::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 82C0740D36
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 08:42:00 +0000 (UTC)
Received: by mail-yx2-x0f.google.com with SMTP id
 00721157ae682-895eaf31683so63405527b3.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 01:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790844119; cv=none;
 d=google.com; s=arc-20260327;
 b=NMwek5mgqlpReD53dBKw4Riuuw4uRSfurFculMT34N3RO3n9FwtSPguJKg3OBKUhsg
 X+bkzUDXdpHBUiJFQDttRSl/J1cvzM6HQngpCsNrcpKhPt2uyw1/iWIGh45qzudjefTo
 8cECyApNG1lqmdflzbQFTyYBFuMaIjeODUtJNkR7t0gcNQ1fVEI0k5x0+EfGrhi/qYZa
 gzY9EDcq85VkPt5o3btloUmi4OjpYe4sfq/3JNEUer3cfPy9t98f7t9sDuJqsHs0b/LA
 gd0aa8dteLbzzHBS3BOuqVOARbbuP22pnUP1du+YrW8BdiYOaTe9OOb1jwXczRhZLiYy
 Hhyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZUYAI50OLfvCMpw2fzknH9SlKzGxxFMOJo0ao+/XSVQ=;
 fh=xeqxZp2m2VSfYhur8PGTAfGKNBWd/1irBY2HRMuSqYA=;
 b=Q4GUBfJ38RKLLC8ZUGYUAYGy+1n62sWYSvkzyWBiXjHV0US/9TAXuvClZErk9jLvoN
 G5+Q+dR4VMY1tQGquabCWsyIP5/1ePCdRXlj/dV2d3dDUh3TAiCqJz42gGl7JijAHgFj
 HNJc3sdmzoWQ6eYR1GGUo0+VJ/EOWQ7EeR/+Eipy3iCml1k+zcupHXVa7RkXYyZvNTit
 YYjM9KKkf19vdVQBmEbGwMPDCmG323LjzFWFMrYZxL1+DVPE+penoKSny9ROkBOu8hvU
 UQ8A3cSLVJPModTgn8Y34/hPxVF7VwX4z9dZrNXh73Wfsbc2ztRmV35/7yVm7t/uZYQ7
 I2og==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790844119; x=1791448919;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZUYAI50OLfvCMpw2fzknH9SlKzGxxFMOJo0ao+/XSVQ=;
 b=wrd46SYckf3WZCwoOHaKiOhvML4X23A0/4wgAH1xBjM/VSKuDbSS7tqma9gl/3R114
 W4i6DbzLEtzBlIALALThvSaJhGtCiedLXp3JoVNYatlwZEfpPwfK2J66KVnKJY5C9eKY
 WDaVAwhe7kCCYGcIJBcsZP2ZtEIc3nVfNulNyynfya2jmVyEVKMx37q/YQCCo8DFqxbw
 3PIrbA+Z67RPxs4yedifUA0sefdqaOhLvY3ViOYnFYLFCHWPWoddODO5GYty0+MKBluR
 NKrLqPTpNA533blLCjq4hEBlFKHVMM2U2evaktnOBNl3qIeua+qqbox/W4cr6DtJcwkH
 Ivew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790844119; x=1791448919;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZUYAI50OLfvCMpw2fzknH9SlKzGxxFMOJo0ao+/XSVQ=;
 b=yBDLD7jR1e1VCigbt5Sjaj6wuuY/kKYDmRkZnB85cshHKm8MVk5y+4vICzZmIewokL
 mWaQWVlsQKcRRfCvV5pJzXVGAmix0DPoxPBxJXEN0EHL7I92L0GMI1KQNu911k28/3El
 CTy+uzlJd+PirWj8jnxAH+l+vwmAUwciE13Rc4tHOAIDmtTceq4MKZqGurkdVWcojHp9
 MzpisnNVn0xVqvtMYGFcreyNhNgCPcs3ynhrK5+aAOdYAnoIo7kVR7f5EAFTy/eXltlo
 3bPnLTvdN5ZMNEx+MTROwD6Zf427m9F8uk/JwYBXAV4oMuRB94O/QACVjRjYa8g1Zc2N
 cdHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtF9g4dUo4gYp3IjEXVig8cJdS1lBSrUMzDjNiLttF4J+6xm8PiMFDQOJSkp5VEPTwOHnbwng=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLhBmqimRPptMqYpZDdY9qAHruQx4ozNJOcS+e1NrJTbeUmgPBo
 X1k1I6TQZXLuuj4OOkg1UWyj1GcIcDIP1Rak9dVfo3geWWlaY5rj05LFt+0g38yqFOU8tMoYpga
 X95TrODrV2Aeb0YVlf1Thw6E1Lf5+SYuz25Q9RhFoMg==
X-Gm-Gg: AYBFou1lYGQp6aekBmuoxTu4aknB1Ak6Qg0RYR6AoUUmX79zce1eTAzAZw590MAtASC
 wIlK7HqQstXV6CXNV8DcDmkTw2zK6y/EF4K9RaC0VonYzbDcXT8YIFEdhw+3LsgVKglQCbrohrC
 BFxClXZxgRCQL1TBO0tl0w0K1NEdht3m1muMcckfoZc49WHecdcRdG5zvMgDKYPM2+/RboRW4Wz
 /IHyJpe3yyBzSuRo6uxu68Q37s9nWY0n7KQBd5LJDtdt3WJNJF6jYTbtA+KFSWC80fr0dWd48C5
 rmCAR7ysNJyyZhyiCD2rdf+SX35Vb8Xz5xHd/qZ8+kYGLgH2ylUdSZ/bhHiPxTUJ9dmWjhH/5wD
 Cp7aiVpQb7zaCB+7LHsmVWwLp5Gc9Q3F9jbKf8X7ifspX97Oq8wz/appPWlTNfPcudTER1OiPPa
 X8Dz3xuyyga9yuxW16cKDKdCGbWOVopPvTtR421IPHWahyvyqUbW9aY0+XatwZM29kTADYOUhaU
 fdQAs6Y1mb12rK9xpdA5yKXa0QzsGQarLA2aMJYfODToDkGaKS9zPOAWtDFFz9XGjEGl7zdBb9q
 rwGLhJJO6dbg6gnLpHuXpjzpg/spFDkGfvbQx28MoHkKEOdTNbbR12bqi5twCV2L4oXFCNjMtMM
 uROWXIsTwrDHTpdbdkPpo745xpHK2eLTJ/mUZUu8SZFA+OWDlR2oimg==
X-Received: by 2002:a05:690c:4907:b0:873:5c6b:a303 with SMTP id
 00721157ae682-8ac943cc036mr14614377b3.49.1790844118865; Thu, 01 Oct 2026
 01:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260930090512.52342-1-michael.haener@siemens.com>
 <CAFLszThPOmn6Z3hA6H1r812kKdEWxtv_RV70BNW_w5U0M1TBDQ@mail.gmail.com>
In-Reply-To: <CAFLszThPOmn6Z3hA6H1r812kKdEWxtv_RV70BNW_w5U0M1TBDQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 1 Oct 2026 11:41:23 +0300
X-Gm-Features: AclHuK8VQd77VvKc_--j_24IQEheqDFyNw8SQ0wHSyTwypcmGOKjOJ-LF9VLXMM
Message-ID: <CAC_iWjJqezM8j=5jcAA8w9ApNP5b+pqC=CkRxEA8mqdNCu1RFg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add an option to start the TPM during init
To: Simon Glass <sjg@chromium.org>, michael.haener@siemens.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
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

Hi all,

Any reason why we can't add this directly to the uclass probe instead?
According to our docs, the probe is supposed to 'make a device ready
for use'.

Cheers
/Ilias

On Thu, 1 Oct 2026 at 11:20, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Michael,
>
> On 2026-09-30T09:05:12, Michael Haener <michael.haener@siemens.com> wrote:
> > tpm: Add an option to start the TPM during init
> >
> > Add CONFIG_TPM_AUTOSTART, which runs the TPM startup and self-test
> > sequence from an EVT_LAST_STAGE_INIT handler. This is the same thing the
> > 'tpm autostart' command does, but it does not depend on a boot script or
> > on the environment, so it cannot be skipped by a stale or edited env.
> >
> > Today a TPM is only started automatically when either CONFIG_MEASURED_BOOT
> > is used (and then only from bootm) or when booting via EFI with
> > CONFIG_EFI_TCG2_PROTOCOL. A plain booti/bootm therefore leaves the chip
> > uninitialised and the OS has to start it itself, which Linux reports as
> > "A TPM error (256) occurred attempting the self test". Boards have worked
> > around this by putting 'tpm autostart' into their environment, see
> > board/xilinx/zynqmp/zynqmp_kria.env.
> >
> > Boards that share one binary between variants with and without a TPM
> > fitted can enable this safely: when no TPM device is found the startup is
> > skipped silently.
> >
> > Signed-off-by: Michael Haener <michael.haener@siemens.com>
> >
> > drivers/tpm/Kconfig         | 15 +++++++++++++++
> >  drivers/tpm/Makefile        |  1 +
> >  drivers/tpm/tpm_autostart.c | 33 +++++++++++++++++++++++++++++++++
> >  3 files changed, 49 insertions(+)
>
> This seems like a good way to enable the TPM for boards that want it.
> It would be good to document this somewhere, e.g. where we mention
> MEASURED_BOOT
>
> > diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
> > @@ -0,0 +1,33 @@
> > +     /* A board may share one binary between variants without a TPM. */
> > +     ret = uclass_first_device_err(UCLASS_TPM, &dev);
> > +     if (ret) {
> > +             log_debug("No TPM found (err=%d)\n", ret);
> > +             return 0;
> > +     }
>
> It seems odd to ignore an error in this case - if the board maintainer
> says that a TPM must be present, then I would expect U-Boot to fail if
> it is not.
>
> In any case, uclass_first_device_err() also fails when the TPM is in
> the devicetree but fails to probe, e.g. because of a bus or GPIO-reset
> problem on a board that has the chip fitted. That is a real fault, but
> log_debug() hides it. Please can you stay silent only for -ENODEV and
> use log_warning() for anything else?
>
> > diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
> > @@ -0,0 +1,33 @@
> > +     ret = tpm_auto_start(dev);
> > +     if (ret)
> > +             log_warning("TPM startup failed (err=%d)\n", ret);
>
> tpm_auto_start() returns a u32, which may be a negative errno or a TPM
> response code (e.g. TPM2_RC_INITIALIZE). A response code printed in
> decimal from an int is hard to match against the spec, so please use a
> u32 and %#x here, as report_return_code() does for the tpm command.
>
> > diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
> > @@ -0,0 +1,33 @@
> > +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, tpm_evt_autostart);
>
> This is not really a driver, so lib/ (next to tpm_api.c) may be a
> better home than drivers/tpm. What do you think?
>
> Please can you enable this on sandbox and it would be nice to have a
> test in test/dm/tpm.c, checking that the TPM is started after init and
> that a missing TPM is handled. Your test could send the event.
>
> A full self-test on a TPMv2 can take a noticeable time, so the help
> should mention that this adds to the boot time on every boot, even
> when the TPM is not used.
>
> BTW, since the commit message mentions
> board/xilinx/zynqmp/zynqmp_kria.env, you could convert that board in a
> follow-up patch to show how the option is used.
>
> Regards,
> Simon
