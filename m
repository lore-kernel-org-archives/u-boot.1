Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302DBCA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 12:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E3F780F67;
	Sat,  3 Oct 2026 12:23:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qSxda39ACVJP; Sat,  3 Oct 2026 12:23:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4C15A80F2C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791030224;
	b=cHzXPoCMCRCsteIBSehqDz7mRF4v3A1vPQ2QT+pehGaxitMuj2Q/QWVTSX4ZmQ6MFnyf
	 eTOu/xSXqmt7L23LPthv/6i9MhJzIqXRSKrrQz+669batd9GLE2lkGBBxUK2wL1jZRQnO
	 qy+jyS6+EjgsBqC2kw+7jzw4vEOlXv0Fu0kdM8xmbKQBnWZEaDKXHlhCg4APeDMRYsOAa
	 aCYG7IBygNZWCnyxNOh3NFrThBdoAA05y9+2QvWjSYEneqwJ0NqFhg7PoQXS9QrzqiaV9
	 uPhNpYUip+AjOE0YBuzvX9cT3Trj+Fyl9lIe0KMgYMYw5hz0lRi6Bi2oUHRJxe1liqA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791030224;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Amv8sKnXlemoX/ORKwfpZG4cnRU3MeEtcrc7RJbvg6U=;
	b=IZfPmslJZAwCpGUJWXvTWADp/jIXQi3Epfdj0Ipzfu3LSf28Z0Ywat0AowpdEi63xiO4
	 0eKAKy5kTdnecBan8lqNhOGkra+1c4cdPnVBStEivl8wxeUXLuaMzEvlcECEhkp26XUWu
	 VXFLoPVyJzSwcjcoo6Ye2NCbaqT5ZNKTl6fykCc9zAmK8oMPVBH3Q6hEsLFgUeQ678V8O
	 uTovgeh7LPXwCdvQ51ytLolkI1M2WQz/hBdkMmkCUNW2VC9KllzQAQPTfSZpcnciBYiQi
	 r46EpVMTinFoWfRMypS+aEXdySHSmTiN3VibMTpkTenjDSK5VgzR7ip+Ut+xpPq+0PA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iqM57lY2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791030224;
	bh=Amv8sKnXlemoX/ORKwfpZG4cnRU3MeEtcrc7RJbvg6U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QrbqfjVCI4Ev4ci3AinHJ76YgdZ8zf8LJ27BsMJ4eO5t4zW19dM10WgKN3A8w7Txq
	 Prrax+XSUmN74IP6wnNy64LnoE4e+h9TG/D2J2C/yVrhFvNmY2R3zgglDPxwTy9N4o
	 DdY5bRvrHovLQDsE5uCClrLZSmfWYsE/GkOBNtn6onpoUHV2tGQhTCK6SXQvvGOHZR
	 HLtvo/tgBsdIqOevZwIMjPs1gk42ljcG0W0Vbr2U8S4ZLghkcrtki33qPrbutKoZm4
	 t+dtNr1QceBNFaLnzWKQhry1i7Lky7ZWyKZjwS7xoRT4jr6IXrCptlJI8BB0naELA4
	 TlV5viZqan9Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C15A80F2C;
	Sat,  3 Oct 2026 12:23:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 89800179
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 12:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F49A80F2C
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 12:23:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8JksilViWEax for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 12:23:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1D4CF80F29
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791030221;
 b=pbhWfTopRJHLyDcBNy5GxnLiJRfJXSwargLObRBoyrUly93YfDlnr7vbHcrHWjWXWIAI
 77/k1zJKCUBY+EhR9pD5fKqpCJIPbnytrkptfAQd07w7dmNdf5WIwtatFkrurdVxFMkUY
 2q8//OvELdeOppJxn9KMg1dUBJbWimzEGOuFcMpThdE/Iy1b+n+E9ZSpsiIXWT18t/CI9
 vyzMwCodfdLhZy7Z8ur4U5VWMs1wuviyepB7wURv3DLZZlMAZFTTdPkKKEpwWbb+s07+h
 ycIFXgUvEAGuHrqJMDWh4dO64NdUGKr/KECS6Wtc7GRugEgQMBb+FAUzlK6HRxaYIUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791030221;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Amv8sKnXlemoX/ORKwfpZG4cnRU3MeEtcrc7RJbvg6U=;
 b=ZcHbW3CpEkmkhDlrEwJ+YhH7N7FgwhavXqL5e0SGndpobQq4D9/myAUkbeuUMIol4Dnd
 GS4dVhgj4m3q7CToAdQqm4WIL3IKy0kRY4LS2bjkuvb57CaD9osJ9dnCwhbExbtwWa3A1
 jAwqY3OPW64DfFfPpbP0DIBzJDbPU1orq2ZwodbpKqjV0nk1y4lyDBmKrXf7bWBDCMbTW
 2Sp/sy4T8HH9UC9sXFsYSG5I2iDW5+urEoI3CCJLWwQhu+z+iUpeSZQNt0MEaQrbfmduD
 BuE9uFaZU2M3wDmo030bTBtod9ioi0ntthbEDIdr3nO5kG46y3hOehdCnJYDKhz3ScA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iqM57lY2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iqM57lY2
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D4CF80F29
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 12:23:40 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac6fa788e6so358918a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 05:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791030218; cv=none;
 d=google.com; s=arc-20260327;
 b=JCXsDypHX/YwySk/IhGNX6pyv0Nw3IgBFiZ69tIRBPz7OU1I2ve04ChRm5APpksk1k
 bkx73k022kY7wkT6bdFKw1kUDdlFIpUp7V40V4PV7Atn39V+u8FMifXzwoDHIY5+IlDH
 PHsmT+Lpvx6RqWOp2ieJECul4yaFoU3Z18PULQx9xdvcKj3jTsD53Sx3vvFzmCsuvXH8
 UiVnaY04g0I/R/eSGD2rCTYMSwuiSjeEHiX0xiR+p9gorFBJQ/M7zyLAWU/OJZAnPI/+
 MeXgEJHWWL9zQBvhgOuNvhHEj/M1N6LyTzPpHsigT30jmGBoHJwAcxjGVO1ay6ZfgmHV
 TvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Amv8sKnXlemoX/ORKwfpZG4cnRU3MeEtcrc7RJbvg6U=;
 fh=WkYp0HmJYsK3d6m5m4yK35zBc0DS+WHQ5dzTgaDrtd4=;
 b=heWb1zIOUj5OLDbScTI1JWW2dEYO/HbTqLirkRDta+VnejsYaqN36S01QlVGi+kXqU
 q+zrFU5RFOcmZyU+0Me0QgRXUDsy32UqVaEddZQMBglGETEFz4ZMwGMoiQTCJCelyfKa
 039tRinuy5RkLXAGFO7lPXrC6lclV5yCVJnHJJ9pFfStfIAxAOqtreseTfzoPdI+D6hj
 38q95H5LDg4ULWx4lxyz96tzoGx/+yCPkfwGedip0xfyNmtaX0wr/sqpvO35G/dddE46
 XB/xNJUNLuIcJonMlSS6a+odlNifXzVy5Tx83wwzauLMf6EnU2NZ+uiQB7tUor1SguY2
 u61w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791030218; x=1791635018;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Amv8sKnXlemoX/ORKwfpZG4cnRU3MeEtcrc7RJbvg6U=;
 b=iqM57lY2+NrCldTLW/bgrCA5p3d+D48a//cQLOapiURQbKmldHZJZFTqbWLUi5IzPy
 uyrE4Yyiz9JUOGpGtj4CAds68nry5cUzejVZE7l44pAjAY/pB7vBxLH1DLey9yzp/hit
 UKPynqF0hfZodVAQ4F8FEXvSNplP9q1SwkzhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791030218; x=1791635018;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Amv8sKnXlemoX/ORKwfpZG4cnRU3MeEtcrc7RJbvg6U=;
 b=uS4O48f8oXppiNVm1P8QkrbpdXm9qF4gGQY2ct3/AjhL6GBoFiOBe0Ct8DVlwj9REa
 AUmFkHUGvae67iCstcqP3Plu9rTnH0jV5A54EeTgR30fL3y8dlh0lBpGswRBTNrleb0Q
 W4/jyV3tTPt+UGWLe7GEOvuYqbEsHZrQQTs1xX4CCZltpIrpcQTaT4fVD7fiWRuqNr3/
 ah410Dh9JRavQAN3mRweKfOAvI0yM2RDp9bzJ2AfmUv9UCRKFi0PN8LEnGt/QGjtfE7r
 gt94zaj/i4E9ssv6X9HqecOrQNeGsc147ieS+Lu9M8noei0NzJ/QtnY5kIuiC6ApFkET
 AOcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTWnjdxGdD+/+6BGWqQjSTlnIu6YPLeHy6fW6XP0dKhhvNNjn8cUwE0fppcTD8pZN2wGGEm44=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLoLto2RnPwebJGmC9ycX06qXncxkgLlu8XltrR7JLEYiUSzf+b
 C5uB9AcI28Xki20vS8nvfwGZdvaIDUffl/RZ2pXaRu+o3++rQKO2Sb4LOu0CiKSYJKSSpbVd8yI
 DN5u2EIJ+BSyghPjj81SAJt0eTBmY3CzOP2MGvJGh
X-Gm-Gg: AYBFou3TO80sX95u7WI2N0tGoNUFVT/ENlRsxktpdrnpeaLmG7jjY4pPXg6hKvlp1v5
 FRPJ70wh0ZPxTCMqQp787tc+Zsk3ZuP96hiQcu2cfUP8PIlcf3PSWI0F9XDo7bJSjpcFXCdU4Pd
 YLmedDGqpO3NCb8mtgJsASI5Hu/N/lzq/s0PyyQVg+xxnFDbmc4eJjfkF6Dt6XiRu9sWZDSPVji
 xGk+uVQ2AlgT0tUg3BlwP1Zjbtm6aUHaZDWMwFbY6v48vf/crEJpN5unkT3CkGF4eguJf4W5Vje
 RqxlIESGEIWSkB9KU66uDUAqNmOYQyPUwo5Qw2Fqg67lOS83Sfd6u60er0iOGqsXhjlY
X-Received: by 2002:a05:6402:21ca:b0:6a9:9766:59ad with SMTP id
 4fb4d7f45d1cf-6af9e33b4e6mr3426407a12.43.1791030218249; Sat, 03 Oct 2026
 05:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260930090512.52342-1-michael.haener@siemens.com>
 <CAFLszThPOmn6Z3hA6H1r812kKdEWxtv_RV70BNW_w5U0M1TBDQ@mail.gmail.com>
 <CAC_iWjJqezM8j=5jcAA8w9ApNP5b+pqC=CkRxEA8mqdNCu1RFg@mail.gmail.com>
 <CAFLszTgXVSKxOhdmgGqUG=YEyekP=3jtz=AtHF4zD8Y_CKY50g@mail.gmail.com>
 <CAC_iWjJ+4G_u6sCPcM6HMhVRcnkmGLSaAYHkOScy5CVSDrpS_A@mail.gmail.com>
In-Reply-To: <CAC_iWjJ+4G_u6sCPcM6HMhVRcnkmGLSaAYHkOScy5CVSDrpS_A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 13:23:23 +0100
X-Gm-Features: AclHuK8UkC6JOW9isBdO_sC0rJYN_MrWYD5DHSfxPiPOd9CnyyFNrMeglsKNDJw
Message-ID: <CAFLszThMBuKz_6PBdyriug6-2EEsV6EqKin79YQvLuX4Y8cyCA@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add an option to start the TPM during init
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: michael.haener@siemens.com, Tom Rini <trini@konsulko.com>, 
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

Hi Ilias,

On Thu, 1 Oct 2026 at 19:07, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon
>
> On Thu, 1 Oct 2026 at 19:03, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, 1 Oct 2026 at 09:41, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi all,
> > >
> > > Any reason why we can't add this directly to the uclass probe instead?
> > > According to our docs, the probe is supposed to 'make a device ready
> > > for use'.
> >
> > IIRC we talked about that a few years ago. Probing a device is
> > supposed to get ready for using the hardware, so we typically have a
> > separate operation to actually talk to it and get it into a particular
> > state - otherwise just probing the device would take quite a while (it
> > also means that TPM cannot be used for certain things after init()
> > unless the board is reset!). The same approach is used by the
> > keyboard, for example.
>
> I am not sure I follow this one. What do you mean after init? The TPM
> is only supposed to reset with the CPU.

Yes...TPM2_Startup can only be sent once per reset, and it determines
things which then cannot change until the next reset. For example, on
a resume from S3 we must send TPM2_SU_STATE rather than TPM2_SU_CLEAR
(see tpm_resume()), or the PCRs are reset and the OS can no longer
unseal its data. tpm_auto_start() always sends CLEAR.

If probe does the startup, then whatever happens to probe the TPM
first makes that choice, and nothing later can make a different one.

>
> >
> > But given that this keeps coming up, we could perhaps provide DM
> > support for this sort of thing - it's not obvious the best way to do
> > it in a generic way, though. We could have a DM flag and perhaps send
> > an event that the TPM uclass picks up on?
>
> What would we we gain from the event vs just initializing it on probe?

The event runs once, at a known point in U-Boot proper, and only on
boards which ask for it. A probe runs in every phase which touches the
TPM. tpm2_auto_start() starts with a full self-test even if the TPM is
already started, so a TPM which an earlier phase, or coreboot, has set
up would be self-tested again each time. Also, if the self-test fails,
e.g. in failure mode or lockout, the probe would fail and we can't
even talk to the chip to find out why, or to clear or update it.

On disabling the TPM in the DT for speed: U-Boot often passes its DT
on to Linux, so that would hide the TPM from the OS as well.

So I'd prefer to keep probe as it is and take Michael's option, which
gives boards that want it a started TPM, before the OS boots, without
relying on the environment.

BTW, by design, driver model aims to do the least work possible in
probing a device - actually communcating with it is supposed to be
done only when needed. That is mostly about speed and simplicity, but
it is particularly important for devices which have state, such as the
TPM.

Regards,
Simon

> > > On Thu, 1 Oct 2026 at 11:20, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Michael,
> > > >
> > > > On 2026-09-30T09:05:12, Michael Haener <michael.haener@siemens.com> wrote:
> > > > > tpm: Add an option to start the TPM during init
> > > > >
> > > > > Add CONFIG_TPM_AUTOSTART, which runs the TPM startup and self-test
> > > > > sequence from an EVT_LAST_STAGE_INIT handler. This is the same thing the
> > > > > 'tpm autostart' command does, but it does not depend on a boot script or
> > > > > on the environment, so it cannot be skipped by a stale or edited env.
> > > > >
> > > > > Today a TPM is only started automatically when either CONFIG_MEASURED_BOOT
> > > > > is used (and then only from bootm) or when booting via EFI with
> > > > > CONFIG_EFI_TCG2_PROTOCOL. A plain booti/bootm therefore leaves the chip
> > > > > uninitialised and the OS has to start it itself, which Linux reports as
> > > > > "A TPM error (256) occurred attempting the self test". Boards have worked
> > > > > around this by putting 'tpm autostart' into their environment, see
> > > > > board/xilinx/zynqmp/zynqmp_kria.env.
> > > > >
> > > > > Boards that share one binary between variants with and without a TPM
> > > > > fitted can enable this safely: when no TPM device is found the startup is
> > > > > skipped silently.
> > > > >
> > > > > Signed-off-by: Michael Haener <michael.haener@siemens.com>
> > > > >
> > > > > drivers/tpm/Kconfig         | 15 +++++++++++++++
> > > > >  drivers/tpm/Makefile        |  1 +
> > > > >  drivers/tpm/tpm_autostart.c | 33 +++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 49 insertions(+)
> > > >
> > > > This seems like a good way to enable the TPM for boards that want it.
> > > > It would be good to document this somewhere, e.g. where we mention
> > > > MEASURED_BOOT
> > > >
> > > > > diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
> > > > > @@ -0,0 +1,33 @@
> > > > > +     /* A board may share one binary between variants without a TPM. */
> > > > > +     ret = uclass_first_device_err(UCLASS_TPM, &dev);
> > > > > +     if (ret) {
> > > > > +             log_debug("No TPM found (err=%d)\n", ret);
> > > > > +             return 0;
> > > > > +     }
> > > >
> > > > It seems odd to ignore an error in this case - if the board maintainer
> > > > says that a TPM must be present, then I would expect U-Boot to fail if
> > > > it is not.
> > > >
> > > > In any case, uclass_first_device_err() also fails when the TPM is in
> > > > the devicetree but fails to probe, e.g. because of a bus or GPIO-reset
> > > > problem on a board that has the chip fitted. That is a real fault, but
> > > > log_debug() hides it. Please can you stay silent only for -ENODEV and
> > > > use log_warning() for anything else?
> > > >
> > > > > diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
> > > > > @@ -0,0 +1,33 @@
> > > > > +     ret = tpm_auto_start(dev);
> > > > > +     if (ret)
> > > > > +             log_warning("TPM startup failed (err=%d)\n", ret);
> > > >
> > > > tpm_auto_start() returns a u32, which may be a negative errno or a TPM
> > > > response code (e.g. TPM2_RC_INITIALIZE). A response code printed in
> > > > decimal from an int is hard to match against the spec, so please use a
> > > > u32 and %#x here, as report_return_code() does for the tpm command.
> > > >
> > > > > diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
> > > > > @@ -0,0 +1,33 @@
> > > > > +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, tpm_evt_autostart);
> > > >
> > > > This is not really a driver, so lib/ (next to tpm_api.c) may be a
> > > > better home than drivers/tpm. What do you think?
> > > >
> > > > Please can you enable this on sandbox and it would be nice to have a
> > > > test in test/dm/tpm.c, checking that the TPM is started after init and
> > > > that a missing TPM is handled. Your test could send the event.
> > > >
> > > > A full self-test on a TPMv2 can take a noticeable time, so the help
> > > > should mention that this adds to the boot time on every boot, even
> > > > when the TPM is not used.
> > > >
> > > > BTW, since the commit message mentions
> > > > board/xilinx/zynqmp/zynqmp_kria.env, you could convert that board in a
> > > > follow-up patch to show how the option is used.
> > > >
> > > > Regards,
> > > > Simon
