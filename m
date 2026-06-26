Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67F5C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 15:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C1F08460E;
	Fri, 26 Jun 2026 17:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ShIMJNjx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D11684894; Fri, 26 Jun 2026 17:24:21 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16D458460E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 17:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-915b5ce94c7so102687285a.2
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 08:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782487458; cv=none;
 d=google.com; s=arc-20260327;
 b=RvROqzKsgI4O+9Dx/aPLSYtGbjFmQz+SSeOmm2Raa2qYrCTYSjtZMUFPyu2ENPk3su
 RwvgVJNUIMMh+rusLtg/kxa7g7mz8eoZkjfvWciFILa919YZYdAhpyIYIQc1AtFr44IH
 OhGtEzTsdmnt4oEx9Z4j5J9Yi2DfVstjytdIvNDRaEfQg8o4l0h1FeUK0EzAwIS9qdwR
 CElYMmilFyeP9bhrh3+ldDDyulmPamlDwaKomAxKaPqIvD8Xi2gD+vuSQoIPgKE2KxBO
 8jzRtiwjSBy2rjOg1nAmvRI23JCcspBjnLB02gFuDEr6mPsfAjzGRkkSVI2ywPwxYc9y
 oNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=v9+thKP1BYrsZ4iOGX5FE7QxKy6KSjR9ISYVmy6jRl0=;
 fh=cz8TAL0JC20oFxAzbTLgPGWZOMYblLpb15aYsSxUNWw=;
 b=SUG3NopGXyh3+iASCnCy9YPViyTLt6TySVAL1YMh8xGG2b7jzpYpANuEPSsKBU/ik3
 +19+P9OF1Fe+4Hls4WDbuSpn/vwcq8hHDkfndjwyuZW/Rgq+jpNaQwmG446YzOrhb9Kt
 fBjgDUQYZwX/bdgnZYF873YX8lBlVEbkev3zJ+LGoCuSItevaUsM+IawosaVb28NRBDd
 IeSazkUx1drNxYzMMVDWUPBGN24x3RcTznk2el5lEQNEw+y951rQaDV/hDsmqKveSFPJ
 Nx+GqwSG3ZEwBX7mjfFnGEvCDWusGmSiJyUQ4j1ALRxLdIAAiyuzofILxhs1o6f7gNuf
 HR0w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782487458; x=1783092258; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v9+thKP1BYrsZ4iOGX5FE7QxKy6KSjR9ISYVmy6jRl0=;
 b=ShIMJNjxIheh1tuJmDgmnrseB4gvnkofKYQtebOurng7Pl7693sXIi/6zOlZmh7tJj
 +Mv3ef0dnbaMYagVMAz8sJPb8IkA+xQsAx29wAqfdxqrbfHfWCZ6yyYqxNiHztEjHfR2
 ucUOTfphCOFMrRe0P+us+n1ZgobxUrOxKmpatwOrflbNp0n5EuZoIijg9+KG8DoMCC2T
 Prc0jkrqk4aTSMc3UIfEHhx7rDJJ9PP1Y2GCuvDa30IUNh321um8EuouFOKfxNhQZkeL
 QebsKnpTBTmrOxx0DaJs0VmC6ZY/hxye3RtZmP2MdOWlK/yfcYaAwte1lthT6k74SZtB
 18Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782487458; x=1783092258;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v9+thKP1BYrsZ4iOGX5FE7QxKy6KSjR9ISYVmy6jRl0=;
 b=q2NJ9GIjun6gQddDae3eL7GeFDvC8nNuAgy49SXlcc7ZMTPMb8Gydj8R5cH2SjeRbH
 QC0OnbNO0PfqYLGCEZOELtRRENfBRDourqccjBgYkqz3L+/j0SHyjSkiBtBAzLc9C4zU
 hBHbCmIW3OOdcQWq3xbmM5vM7MZ2HtgkGyWeHd06xsWOgt0aOFHfn1MIU0idvifzsIXp
 KttjgbU6FB2iRDddpR653h7jX3yq7ROpliHyLk4quTmiD42y3RaMzqSgt0u+oeJ995Et
 fHZgwZxhbHiQasxS+SXEHJkqEUkTlT1d7dcmqRsSqjng8Vaepn0cbpMbEbMPQqj2/6vH
 USfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mMKY7P6RZWDjbaNKRPUSnHrD+WPMSiS1iEtEghwCFxnug4nYNslaQ6FL/zkvhTg7tq+MFnas=@lists.denx.de
X-Gm-Message-State: AOJu0Yyq2oxaSyuBoHevVgjmT3hGJLVwM90IOtX4lKkn88uHmBV8rhs4
 ppTaw1MRhnDXSv/fvEf+yuFlu2A8hbKq5QXVmbTfc5DDv0G/Gra/v9yTA2T1s+cyuOQirnan12X
 F4DvumhFCCnAA4LB0q00E+6WXnpq3lKs=
X-Gm-Gg: AfdE7ckono67Yy+2AO68IFCPser5OPyq66ydECwHwzdHdyt7b0eftWLSJYu05pZNOYQ
 2ooECLFLdOSgOrdDEuNKQuO2KMbxPVFz1CRMHTYMMrFCNwcKCDltbnFJfXFkA60im36cNHkmcol
 pWuRsRIpE0mmTX3vCa6D1FLT/5ziM2U1lwOO/g0uy3MGPfQIOgn507jVZw/Vry+lAwsHF4j1jLS
 0IYzyjynjBptgWoLww2VT+pyDxup2L/hvhGoZDLU5k1xRYLKVbaX5KKWVU/+S/bOHO6cL/zzOlu
 WTmH4TPZ7GmJ8UZW7s/LvIau07MeXbBeekZoA95duYZdtlPL7c3mqZ1ecn22imREuXZbezmwM+u
 IR+qsqol4f740xfPRYMv3khpAFHaUBQtAI0gIKlCG0xTDeSfloGR7QEFiBZJNx2V5nPg=
X-Received: by 2002:a05:620a:258b:b0:92b:6805:eae0 with SMTP id
 af79cd13be357-92b6805ee2dmr63521285a.61.1782487457718; Fri, 26 Jun 2026
 08:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <a5255761-9407-4c06-bbb8-ecee07e67292@syss.de>
 <103cb2c9-fd0d-4531-9e73-d1ba7d61a831@syss.de>
In-Reply-To: <103cb2c9-fd0d-4531-9e73-d1ba7d61a831@syss.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 26 Jun 2026 16:24:05 +0100
X-Gm-Features: AVVi8CfPyouJrs8JitMwaMtnNP5BjjJ_ykmdykMt10toZdTKIq8rvmztE8M_iuM
Message-ID: <CALeDE9P42BJa7cV5mDAPUPVQS8rmcsvaz-vOE+iEoXpVi11wcA@mail.gmail.com>
Subject: Re: Fwd: SySS Responsible Disclosure Policy
To: Robin Trost <Robin.Trost@syss.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Robin,

> any updates on this issue?

The disclosure policy [1] is to just post the details, including any
possible patches to resolve the issue, to the mailing list and copy
the maintainers. Please follow the policy.

Peter

[1] https://docs.u-boot-project.org/en/latest/develop/security.html

> Kind regards,
> Robin
>
>
> -------- Forwarded Message --------
> Subject: Fwd: SySS Responsible Disclosure Policy
> Date: Fri, 12 Jun 2026 22:47:14 +0200
> From: Robin Trost <Robin.Trost@syss.de>
> To: Tom Rini <trini@konsulko.com>
> CC: u-boot@lists.denx.de
>
> Hi Tom,
>
> for the advisory (SYSS-2026-039: Arbitrary OOB Heap Write / Integer
> Underflow during RSA Public Key Parsing) only you showed up as a
> maintainer ("THE REST"). Therefore I've resend you the advisory.
>
> As my last mail was already flaged by your mail provider, I've included
> only the advisory (including a PoC and a "optional" fix). If necessary,
> I can provide you a reproducer script, which illustrates arbitrary code
> execution in the sandbox (including a python script which can be used to
> build a malicious RSA public key).
>
> If you have furhter questions, just let me know.
>
> Kind regards,
> Robin
>
>
> -------- Forwarded Message --------
> Subject: SySS Responsible Disclosure Policy
> Date: Wed, 10 Jun 2026 15:46:26 +0200
> From: Robin Trost <Robin.Trost@syss.de>
> To: u-boot@lists.denx.de <u-boot@lists.denx.de>
> CC: trini@konsulko.com <trini@konsulko.com>, p_mailqueue_disclosure
> <disclosure@syss.de>
>
> Hi all,
>
> The SySS GmbH deals with security issues in a responsible way. In the
> form of a security advisory we report security vulnerabilities which are
> not in products of our customers and which are not excluded from public
> disclosure due to contractual agreements with vendors.
>
> The attached security advisories contain detailed information about the
> found vulnerabilities that allows the vendor to reproduce and further
> investigate the reported security issue. Vulnerabilities will be
> disclosed to the public if a solution was published by the vendor or 45
> days after the initial report by the SySS GmbH, regardless of the
> vulnerability status, for example if there is a patch or workaround from
> the affected vendor. In well-founded exceptional cases, this standard
> procedure may not be followed and an alternative, adjusted publication
> schedule will be negotiated with the vendor.
>
> The goal of our Responsible Disclosure Policy is, to weigh up the need
> of the public to know of security vulnerabilities against the vendor=E2=
=80=99s
> time to remedy all security issues effectively. The final publication
> schedule will be based on the best interests of the community overall,
> considering both positions. Before the responsible disclosure of a
> security vulnerability, the SySS GmbH allows vendors the opportunity to
> analyze reported security issues, to develop effective countermeasures,
> and to test them thoroughly.
>
> If there are any further questions regarding the identified
> vulnerabilities do not hesitate to contact me.
>
> Kind regards,
> --
> Robin Trost
> Senior IT-Security Consultant
> ______________________________________________________________
>
> SySS GmbH
> Schaffhausenstra=C3=9Fe 77, 72072 T=C3=BCbingen, Germany
> Tel: +49 (0)7071 - 40 78 56-6169
> Mobil: +49 (0)151 - 42209330
> E-Mail: Robin.Trost@syss.de
> Conf. Calls: https://syss.zoom.us/my/robin.trost
> Web: https://syss.de
>
> PGP-Fingerprint: 85FE 80E2 04F3 6177 C61A 4618 61DE F14F 698E 6EB3
>
> Gesch=C3=A4ftsf=C3=BChrer: Sebastian Schreiber
> Registergericht: Amtsgericht Stuttgart / HRB 382420
> Steuernummer: 86118 / 55809
