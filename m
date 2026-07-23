Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4A8C531D0
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 19:01:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42ABB60AD7;
	Thu, 23 Jul 2026 19:01:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8LxASs5qwFSx; Thu, 23 Jul 2026 19:01:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E244960A88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784833265;
	bh=kO9wukdGB0JJkZh6ppApthVQDD4S61FklWwj64N8aSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aJ+0Jm0zPZVBtI5oUvaCKulYjMX5NcguX3IhOq9xlIoSBWsx0LGiBiwzlTekyi9u3
	 coH6+uHwbdKmS/SA9fpoIIyGveoUnHRKhMzDFoZZn4A4///ve77X1igSr4AA9cLUuy
	 rOKMLMw7ONSw2avE1Yb9K5ZsJZzzDo1f2wAJrkeZMItrtcek3sCz3WTmfy9BePueEl
	 uFjyJMqnIfim1sa5HnHSPFxRw5UiHugyP70eiVh8kZW4xn95SDJyc1xJSU3/60i0cF
	 CT+nN92P6zsvVK+HK/Z/mWtlvYkmtqjip8rrhPtKykHDec/nAJ1di0OHjXqRK/60ez
	 hrGAc4KpZvfCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E244960A88;
	Thu, 23 Jul 2026 19:01:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CA3142A
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 19:01:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52913810EB
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 19:01:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mnINXiEB2r1c for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 19:01:02 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6C923810FC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C923810FC
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C923810FC
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 19:01:02 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84D7480287; Thu, 23 Jul 2026 21:01:00 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F9ED800AE
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 21:00:58 +0200 (CEST)
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-39c74722e27so9157881fa.0
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 12:00:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784833258; cv=none;
 d=google.com; s=arc-20260327;
 b=OvYq/iREqp2q/2uB9jmc3dViI02qx9Z+12OsL2zbyG5R0rRJRBEGOxH9OmRD8lb5do
 S/YyipE9mcAg0HSnqYVuQy/9BUhu5dcARbedj4xjAriCM8I1yNnGseEC89GmpqhMO+R1
 T9t4mo2Dnl+kHcetj5ba/KfQeR7YXVo56r28yJZBeP2qWp8I0AIpFT+SYQ+i0wav3keS
 tqN4bTPkI+9KB8MgrrfNe5N/e2AaaEzAddbaOf1EMu+nhGqSMVmTqQUu49zu1PVE1mKM
 o2JtKGAdttWH27qSOLSqr7zPvuQN0y74lrjMbdSJ8I4D6gxMNVbgKQoCeddQVrDWx1eB
 JmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kO9wukdGB0JJkZh6ppApthVQDD4S61FklWwj64N8aSo=;
 fh=xWra36DHek8Nsztc+OIW1/gtJuYmN7huODywrnc2mA8=;
 b=Sq5jBVFNAdyfOsjzHyo/Q34jye8nPwqWxIacs0HnBHonZKxfTQOqdEjmLB1fkNuncv
 QFLI4mzbc4vmSiKOO2NnP2uQQsZDdL4/fxvn2QsT0E2qGpFhVY2JAB8453p5e02c/Eyr
 9hCU1pxSkOBQatwVRC2Y4emg7ve7+0Rop0C3Ge+0BEkcG8t2Yd45dGTHuPJc2DQrdLUT
 9pgcd2cB/xLaaAd9Geg+D/Uzq4JM2XYLHMYIIWTDlIOXGlrf0yVAWAA8tLsNF2O0YoTW
 VBD/glUnHAae/JeTL3JSkYNo9fcMi5rfDff6GNbTAEEid4/4tWshdCXSmQdiTUZ/i+Ss
 sFXQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784833258; x=1785438058;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kO9wukdGB0JJkZh6ppApthVQDD4S61FklWwj64N8aSo=;
 b=SkpKtu3sljR9aXADi4UeO9LqoCpUrND7B4aTrmu9tyS6eS4zTIv2mLYEJAf2a1quvo
 ICRSB6NSQMaCSeV0lblYbmAXume4+1nVg+i5q6G2T73zByXG9HTR6QcyKSty0psbFiHn
 eqZ1zSQGXYeB56oM4DeIIlwzM+IyWisfIt9d76j+ZgerIkpM1AS1o3JQZLGwdh7omIty
 E8rxq3l3tjLF2hVfJSBklvzugS2lmfevwB/ca1Myxv3leS7adKsYGB4mwKHQF8ALVaUp
 gffUTy2xk4YkmWc1QefspF9bp/e7qi8CIb5SvkrBmPqli7H75v5qp7fhScsxqqxEKUlJ
 y+9g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXEu4O2PJkbIGsq56EZuvZkLd55h3Zb+6d7GAa5AoZEGx/OgWWTLqjiq62m5V+wZNiioHaPiY=@lists.denx.de
X-Gm-Message-State: AOJu0YwSf5PyPsL254Wr7XG1WiZ+EzFkvukS55UOvuvohfwhKNa9hR3H
 sqruDw71ccodHuUbuI/6/bRltOmPfG3JKQ842rOZT7wjHmLQ8EgEc1IyUJ/x+hZSZ8Cj1zw0Gcg
 nrKV5LTQCv6g/XYSBGsmqSX98VA2TWOM=
X-Gm-Gg: AR+sD116ijmK/eXj8jUqMUTPGLeVj0KycbIKHDS7UiMwgK27INVTHMvFe7B6NqQB2jx
 8Gk3zPZm++fylfMaP1NqtC6zMk5vTC1OkPKj0NPhrYTwuKjOvUDBHe0NBMYxsDmUm9hJXq1J8Cm
 hLh428RkMnJZSowCxz15GhZM8NrzYeUGvh5wKpJlbp7P6McO0INJIvnWbEYTQTQVJ6iqytqP21f
 qoovLU7RM9gSONjWcIV0IuOEZnMn34BD1oa3Y5Xwnem9AB3rizbljveH2iWXSHaKQN/sE6iEQ0l
 tim8Pk0tFVu27SP855ko3THuQSK0nQrL/D8DWz88UqgmCA1zVUyuFOdO+DHM
X-Received: by 2002:a2e:a542:0:b0:39b:439b:625d with SMTP id
 38308e7fff4ca-39f0988a216mr7325711fa.14.1784833257448; Thu, 23 Jul 2026
 12:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <xh7ydtfvepgceyyzmqzq2bzv7allmqt25brtdhnpl27muyap7h@v5tqjilbwfav>
In-Reply-To: <xh7ydtfvepgceyyzmqzq2bzv7allmqt25brtdhnpl27muyap7h@v5tqjilbwfav>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 23 Jul 2026 16:00:45 -0300
X-Gm-Features: AUfX_mxR7pVgqY4MqZDka7_UL3Z2ZkTUXWu_-WA-EeVnakW2GaSPHq5NhpaHzs4
Message-ID: <CAOMZO5AwOBTO8tVQkazimEfUmysZwHs4hRwY4SzZK0OvQnzpzw@mail.gmail.com>
Subject: Re: [PATCH] serial: lpuart: guard against division-by-zero in setbrg
 functions
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784833258; x=1785438058; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kO9wukdGB0JJkZh6ppApthVQDD4S61FklWwj64N8aSo=;
 b=TN3AYthvLi74XRYPcXVkIXZdlzI6eHS5+Hud2MnL/bR2ajbcyI1/TB6e9xvOPNgi1Q
 hd+Z8F9TiD+vwuSn3zRnWMN2vwHsDk3xYgp2wHWBivgTy/qVcWd0Yq+Ccp9fBKk8+6qh
 hrNn80bJ1iK6ecQwWo1toLaXmw1okJx9BOLDQrKWFxPVxtxcQsT2uto23dOiiTaYtyVd
 qU172nS387KoMHTdW48SGufbd17KGmx//MxsXuHj8smmEtxLE/YWGUvEw5r+8wohM1Cl
 tqPh+VxMXAhvpvcVyxPodAYQIqfU2GYm1/6R01AQhPdjZVu1WrQt4cAdRyvITo0KFb1V
 iEqw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=TN3AYthv
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=festevam@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="TN3AYthv"; 
 dkim-atps=neutral
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

Hi Naveen,

On Sun, Jun 7, 2026 at 4:53=E2=80=AFPM Naveen Kumar Chaudhary
<naveen.osdev@gmail.com> wrote:
>
> _lpuart_serial_setbrg(), _lpuart32_serial_setbrg_7ulp(), and
> _lpuart32_serial_setbrg() all divide by baudrate without validating
> it first. If baudrate is zero due to misconfiguration or an
> uninitialized value, this can cause a division-by-zero.
>
> As a safety measure, add an early return when baudrate is zero in
> all three functions.

This looks like a theoretical problem. I'm not convinced this is the
proper solution.

Thanks
