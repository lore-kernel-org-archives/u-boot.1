Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3128DC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 17:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B36484409;
	Thu,  2 Jul 2026 19:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="EN7ViIWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53822846A4; Thu,  2 Jul 2026 19:02:43 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B4F484119
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 19:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-37fa06b39b4so1598119a91.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 10:02:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783011759; cv=none;
 d=google.com; s=arc-20260327;
 b=O6Tct/2dKKJz11+KMt2f0gTJ5tpVTUIEcr3vGJs6P7qemhxc5aET0xFscaO9mif+gx
 uJm8YoKrF/T2J3ea/zAnwGDOrMdzmzhllfmxRedQR3+8v2Nrh/feTXSagj1Djfk5Dh5U
 Q0cv6jWtWpPFgR3r6LqBu8azLpGXEw/trkFi8m29KO7bJJDBn2pnxwfaZ3W67fz3rBuY
 drxBs5EvhTyZKyAQJKEyXQOp0ujykfp0QTFW7H0ty/OajLHmHo8DBIbabY4kQAZUusLQ
 90FZF70CWKc4F9SvJ3cYUmQrkt8w3mE1DiOGGclAsZ15KDMHLXKGs/ek+hZtrBNWRAqz
 MtiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oyb4sT4+YtlZUncW5DpD2//RHVssTSdDBXVJXrdbBxA=;
 fh=XW75Vhft371F+di1QXPs6MccQxNY9hvRp/1HTm2IjA4=;
 b=j1cI1ObuhBZ1Vy2zcs9oeCnSKuLfSvyp7Rk805nkofUNhqzPsvFDWvp5GP1etNQBVc
 PvoFZ0PciuinhYgC9GelMsvLkRjYudpig3i5kbgO9VWfMsEH38g59KFsxRloEDDsBq6l
 q5rkznU2HCACJDc1rZmWkbPith327SIk5SshgOtSgDScaapbV14lPAt4OymkDMx6huaa
 pR8SZ7Dvdr8YDzlLEy0UsWUGTmhNin9pzLGRTqS1t0426gRHZnvoPbbOtMJFFbnWQoIX
 40O894ttY2WPw6pNYuVTbml0K+jJ6ScHcydDS51x8EidBDcpWbpS1G/OLZgTEo2swj2w
 2R6w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1783011759; x=1783616559;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oyb4sT4+YtlZUncW5DpD2//RHVssTSdDBXVJXrdbBxA=;
 b=EN7ViIWds9Nuh7K9lfOoAv6BGUcGlOzNBFQvaA60DJOakWfydpVIMEndRMmhgZZNU7
 bwAfQK/VG8GqrcK6eHoMc1jFhNXfVPO23f35tyr75zI2YM7uJffRpGEuOZSGm94G3ddg
 S5R/WgTw/U/H2l/oyqTXNoaFqWiLv+6hLpoiKm0Vg1XgTsWvtw8YVoY8J5xu/ByLEUqZ
 ThmrWTnGBj9fNMoe0OYDL+m1PI/4omnDCxpWk2ckvK09arsdIwNfkHAxHFXFHLKt/wer
 lO2D2JqEW+yvPOGFtWBnPJUtPPMjuuXKSdB3rrVpsG/47cAtmYCOBJOzUiB3YWnjafh1
 Tjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783011759; x=1783616559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyb4sT4+YtlZUncW5DpD2//RHVssTSdDBXVJXrdbBxA=;
 b=aalv39+BvA8KHiL1ps4gdvWZIVGXSj5HwBtnN1d0tHcglJFZ4eW0kdz4eMyoCZ+53A
 HuQ0ln9IPnuGXbnTKXNDv1dApz1EzJ2SSBtf9FWfWK7hxKqOWUD+rvMF9j7BAXisKYIa
 qrZJTXgITE/QUb4q8rwu4zTYMxTD3fOU5h2AP8K9zOmPYxeTAxK4bk55zWI6gP327ndY
 PKABilWteb99JNOU4lPXK3qHxOKrXLhmvAgO/s1WCjtKWUuvLlrT+6IzAuG5M6b6zvTz
 hLEAZdsYexO1MXzO4yn+s8gSX5ABBfze81Co/O/zM0HkWezjldu63ehGJWrHC5er5age
 Ef/Q==
X-Gm-Message-State: AOJu0YxK2Z4hqO8mBkndTX71xWqismqWmKhny8TrhJ0ZB6bRfHs5LgqQ
 5909kS94GTEF43kDzmwJyH+CitGFU/ku74DVL/5I5DNiWa8KMmgQytQRP2M7BCqTvVUdHa0OeLQ
 ANAnAh78rkuTIZuZATK+woFGc0HVmj23exXFAdx0FUg==
X-Gm-Gg: AfdE7cl4FFZHWVZlagMu2jNZW2qspge1ZOtBVx5Z/Q23X65IxOQ54pJAyzOq2ci1QZR
 RNpJWlSUrH+7qd26w8PPuCEBYJTvsCZbH/qUOlZmIgxEkdZdlCg3G3CADm8xZ9HAB+rurFZOrV0
 1+OWmSxSdchCPo+KK7BKnob/g7K570dfaI0dRMjM5ud8ZT+CGCXQD+Dbka2Csh4H/wG6nHneJI1
 RJgP+qT8jm8hVVfIFxNPsbCv4GlSncBDJPqbYRSVBQT57HX+XXrxXWMzx8wtOBDsumIqHOnzyDo
 QeCQzqCJj/inMI/iWGht1sd0eyg=
X-Received: by 2002:a17:90a:da8f:b0:380:7688:fbe9 with SMTP id
 98e67ed59e1d1-380aa09b81amr7461186a91.8.1783011758439; Thu, 02 Jul 2026
 10:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260525132828.3348679-1-sergio.prado@e-labworks.com>
 <20260525132828.3348679-3-sergio.prado@e-labworks.com>
 <cb1c95f6-bb58-45ec-a064-08422b7a8d72@cherry.de>
In-Reply-To: <cb1c95f6-bb58-45ec-a064-08422b7a8d72@cherry.de>
From: Sergio Prado <sergio.prado@e-labworks.com>
Date: Thu, 2 Jul 2026 14:02:20 -0300
X-Gm-Features: AVVi8CfzHIrEQBu0KLGkjOKSiJtMArzCgiIwHjnWElyjfq0BQUerTlO0pIrHy20
Message-ID: <CANu7NGv8VnT_ZhS2WoBYKvVEDpsu5FkVv+gxKeBk-fk9HOAo-Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] binman: x509_cert: support PKCS#11 URI in keyfile
 for HSM signing
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 alpernebiyasak@gmail.com, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, 
 wolfgang.wallner@at.abb.com, bb@ti.com, xypron.glpk@gmx.de, y.moog@phytec.de, 
 afd@ti.com, Wojciech.Dubowik@mt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Quentin,

Em qui., 18 de jun. de 2026 =C3=A0s 14:42, Quentin Schulz <
quentin.schulz@cherry.de> escreveu:
>
> I think this could be split in multiple commits. I could identify the
> following unrelated changes:
[...]
> Do you agree with this split?

Yes, that's a fair split, will do in v6. And you're right on 1): the plain
PKCS#11 URI case already works today without any code change, since binman
passes keyfile through to 'openssl -key' unchanged and the provider
configured via OPENSSL_CONF resolves it (with the PIN coming from
openssl.cnf or a pin-value attribute in the URI). So the first patch of the
split will be docs plus a test exercising exactly that.

> Should we rather move this logic to ReadNode() instead then? Hopefully
> that is run only once? What made you chose GetCertificate() for this
> logic? Maybe I'm missing some clue.

I wanted to avoid mutating entry state given the double GetCertificate()
call, hence the local variable. But ReadNode() runs once, so moving the
logic there is simpler; will do in v6. I'll also make the helper skip
appending when the URI already carries a pin-value attribute, so it becomes
idempotent either way.

> This isn't specific to HSMI/PKCS11 though, is it? So it's just a way to
> override the keyfile entry argument by an environment variable. Yes, the
> typical usecase is to use it for an HSM but nothing forces you to use it
> for an HSM?

Correct, it's a generic override. I'll reword the documentation and rename
the variable to BINMAN_X509_KEYFILE in v6 so the name matches the entry
argument it overrides (it can carry a plain key file path just as well as a
URI). Shout if you prefer the old name or a different one.

> Aren't we missing "local PEM key file" here?

Indeed, will restructure the list as the accepted forms of 'keyfile': local
key file (default), PKCS#11 URI via provider, engine-prefixed URI.

> Is it requiring OpenSSL 3.x though or did you only test on OpenSSL 3.x?
> Since engines were supported in OpenSSL 1.x, I would assume PKCS11
> signing also worked back then? Are you aware of a limitation? Also, does
> it NOT work with OpenSSL 4.x (which distro will slowly start to migrate
to)?

It is a hard requirement, and it follows from the design we settled on in
the v3 review: binman never passes -engine/-keyform itself (the v3
auto-detection
machinery that could have done so was dropped on your suggestion), so the
key must be resolvable through a bare 'openssl -key <uri>'. That only works
with the provider API or the org.openssl.engine: STORE scheme, both
introduced in OpenSSL 3.0. On 1.x there is no transparent path, hence
"OpenSSL 1.x is not supported."

As for OpenSSL 4.x: the ENGINE API was removed entirely in OpenSSL 4.0 [1],
so the engine-prefixed form is OpenSSL 3.x only; the provider path is the
way forward and expected to work unchanged on 4.x. I'll reword the docs to
state all of this explicitly.

[1] https://openssl-library.org/post/2025-12-18-remove-engines/
> Yeah, or just say "OpenSSL 1.x is not supported." and be done with it :)

Will do :)

> question: why suddenly the variable before `make`? All the others are
> after so it seems like an odd choice to me.

It was deliberate: PKCS11_PIN is an environment variable read by binman its=
elf
(via os.environ), not a make variable interpreted by the build system. In
practice `make PKCS11_PIN=3D1234` also works since make exports command-lin=
e
variables to recipes. I'll add a sentence making that explicit.

> The third option is to have the pin in the URI directly (which is
> equally bad, but is possible no?).

Yes, that works today (it's the "no code change" case above); I'll document
it.

> I'm wondering if we should support replacing the PIN inside the URI if
> there's one in it and we also have PKCS11_PIN.

I'd rather define PKCS11_PIN strictly as a fallback: if the URI
already contains
a pin-value attribute, the URI wins and PKCS11_PIN is ignored (right now
the code would blindly append a second pin-value, which RFC 7512 doesn't
allow). Will implement, document and unit-test that precedence in v6.
Silently replacing would be surprising, IMO.

> Side question, what happens if we have a pin set in openssl.cnf and also
> via PKCS11_PIN/pin in the URI?

I'll test this with softhsm2 and document the observed precedence in v6. I
expect the URI pin-value to take precedence over pkcs11-module-token-pin,
but I want to confirm before writing it down.

> Idly wondering if we shouldn't do a simple try:except and let
> raise_on_error to True and skip in the except.

I have a mild preference for the explicit return-code check, since a missin=
g
provider is an expected outcome rather than an error. But I don't feel
strongly, happy to change it if you do.

> Please add a test for when the pin is passed via the URI directly (as I
> assume this is supported) and not through the env variable.

Will do.

> We should add a keyfile property in the test device tree to make sure we
> override it with the entryarg.

Will do. I confirmed entry arguments take precedence over the device tree
property (Entry.GetArg() checks entry args first).

> It'd be nice to check the engine works as well with the prefix. [...]

Simon suggested the same compromise; I'll add a unit test that the PIN comb=
iner
leaves the org.openssl.engine:pkcs11: prefix intact, plus a check that the
prefixed URI reaches the openssl invocation unchanged.

I am going on vacation and will be back in a few weeks, so I'll address all
of the above and send v6 once I return. In the meantime, if you have any
additional comments before I prepare v6, please let me know.

Thanks a lot for the thorough review!

Sergio Prado
