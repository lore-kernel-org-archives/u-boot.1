Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9B9C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 18:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFB4080E32;
	Wed,  5 Aug 2026 18:58:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W4MXWIvC1AnX; Wed,  5 Aug 2026 18:57:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A4D480E25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785956279;
	bh=hZiZOgWsQs7V2+55fGe9dEPoxfRXydiQsXHRIuARE8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rCeuRGBIjqizXuLaPdSrhvRTkam7WJeDVUzRk+fW1h5F244/HYTRlgryA+X/9o0G0
	 gYvaa+OwoobBk/ARlDcbvZDl75CIpzB98pZJnNpTzo9/eCIXwFarjvA1tRXJG5Rkhh
	 Od0k1Phap31M0RpGNRzVTwnRyBYZLQkgdk7E9ntwcrHETbQDFupc7J5seMWcKBA18K
	 AoUyOR03Eb7fonu7svkPTo9vtD7Gbn2WIGtA3YPrPUiJBeU5ElO0on1xbuSWCk0QB+
	 g57cxPFLMOgdg7I/8/+oh7WpO5xlmkylicY4+aVcr3NGqtL0nyq5XbuLQJPgfl9sVO
	 O5+I/+roTM0HA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A4D480E25;
	Wed,  5 Aug 2026 18:57:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 806F32A8
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 67A1660613
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:57:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Ow8yFEQlyTC for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 18:57:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 501F0605D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 501F0605D1
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 501F0605D1
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:57:56 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso1953880a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 11:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785956274; cv=none;
 d=google.com; s=arc-20260327;
 b=M3SC2UodCjJ+NDwMyXKLfIVh6svpjP0r8fsh5eMZc2YDlV7ql2mKhMoNmVE5313l+9
 l8smSuYPNDuSjkMKkEOt8uucdecGSkd2jdlfszQh7KqYIGpXp0Who0z9P40Sw/2tbOQS
 8Epfvziv2wPTp2o9tWunA0n2LJsomvCGi6DaA2NlRYRMhNFsBZuMKZ9nnBVxC1CeB9Qv
 BhQVOEHS65US3OXEb4LOakvEYpkfENMtWDJ8UVUoMhC9jXWwXHn1iZYguNYRQRHycX7t
 JpYY4VG433i6E5z6TtR1PANGrcueNv+fibdDJ/wYs+K9Zki3UsslDYLw7ZyjVtBOan6b
 6PwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hZiZOgWsQs7V2+55fGe9dEPoxfRXydiQsXHRIuARE8g=;
 fh=0AN8Jds8uRYfLwNFiIkzi6jOaSoTRPZt0eZc385BnGk=;
 b=IywS7O16oCSfMLwsEoabhP6cYSpdks8TuurYf7AZmp2DTNvAdR+nAmyzkCZFmvkmWi
 9VwFvk7qMdvT1Pq2JbkBtnSEiaaL4k9pO74qmct3ECcDDiCY1LdvxJOhFu3EtW24RVxa
 qUGUb8QlNE0JrCyiBags2OMxqLJHPCgevEYxEkmQz4yU1ETv3JlHRs2xO7AafMiYKzk+
 GTj5io3fKBOZw6Qc8lolUNesXYpGYDwBlAe6CGam5IPUJ29g+BJAksCvft6ZiWTT1f1p
 ZcdP40durgV5wMgXvw19MM/TjqIaZhD+Ekj7JXZrrI4MRHbFGsBog4ttb4vWmkJVr4gV
 FB+Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785956274; x=1786561074;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hZiZOgWsQs7V2+55fGe9dEPoxfRXydiQsXHRIuARE8g=;
 b=rS3Nv9z291VZKxnBdTbZAHsgJxxzizA0eORqH6ahHt6g5XjcJTE6vA7iE7ybFoBmym
 1XCoSgTpAROBfCAQ/s6ETfO0tI9wuzTyrjY05H9V+pOO6bLzv8M7ynyYg+IliibLYWVr
 leE/BMsOWQoiH624uxFHp4bjfdU5oEHnfc6XzQ0L6j7h15glXhb0XPZvkaPc5r0Pujeb
 V+CRL7v3jFhpGM6hq27afNVzoY2cqXd8UN/rC4kbPb9aKDt0eC97UHYVv74FFH8MLC2J
 jyss0IHZAqROCreB33JAgGrpr+m7gltFmnCkU35BtmAQ0lNSmBiG4g/9c6KqdjKXe+TG
 nXJA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpiOq/15l4I2rCqYWKmZM/06fjODXFH6bXi/zUjh5ejWbTlitj5hKSsM5tvjHyom3ZeGOr+SnM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwsmNhKZC7nZtlYnQ15pMelSKlQvlQ9yO5V+eDW5NkAHvZMd186
 O/FAXCGQLsJAkiYolzBjoorq62NmhrcE4zaiU/L9OYlAGfoq1sXqGmBnTIfraImMUO5+bNiQ7HM
 cFvnqeTJD3Qhe+mwNapSCWXf+qpo9nhJqUhFf4GIR
X-Gm-Gg: AR+sD13XK9SUwP/sFjbePRovdsPha/biSYngRQEs7CVWS1He3OMh2SFguUC2/U2Ppdp
 b+s5sqITzwlu4XnPKWXU4xhUJIYOKbYbRWVLWrU/Tux/N1ecMUUnH3LmQYdEItO5AXbn+vOP74Z
 81jox78e6ZzRJZ7vMGkFqPIgrIhtLACSfovastrOXnZ1T7MGZI4voVr/XuZE1TsBVO6vXKq6qfH
 269mxS+uWn/OlkJdBDPCUi8b06o2NoNoXaQFijXc+SGD48fbp9VUL8XCjFK1ObbGW/tI0glstjx
 ORnxL8h9b/cKpdIsBtbgiPfwfkxjhWvw4TdC0Ouc5Nk=
X-Received: by 2002:a05:6402:a6d0:10b0:6a1:8d3f:a185 with SMTP id
 4fb4d7f45d1cf-6a18d3fa2f6mr1078124a12.6.1785956274268; Wed, 05 Aug 2026
 11:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260728113535.128601-1-sergio.prado@e-labworks.com>
 <20260728113535.128601-3-sergio.prado@e-labworks.com>
In-Reply-To: <20260728113535.128601-3-sergio.prado@e-labworks.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 12:57:41 -0600
X-Gm-Features: AUfX_mw5cJKQ8B5YA-bU1ey-ZJ_4KIx4Gtu1LA3z0QApLeGg1fQrYQtjM2_lM7s
Message-ID: <CAFLszThsRBUpipuRoR-Dq8CFz3T16wOg+Vj=rK9-2O+T2=UmNQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] binman: x509_cert: document PKCS#11 URI support in
 keyfile
To: sergio.prado@e-labworks.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 alpernebiyasak@gmail.com, marek.vasut+renesas@mailbox.org, 
 ilias.apalodimas@linaro.org, pbrobinson@gmail.com, sughosh.ganu@arm.com, 
 wolfgang.wallner@at.abb.com, xypron.glpk@gmx.de, quentin.schulz@cherry.de, 
 jj251510319013@gmail.com, Wojciech.Dubowik@mt.com, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785956274; x=1786561074;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hZiZOgWsQs7V2+55fGe9dEPoxfRXydiQsXHRIuARE8g=;
 b=XjqHW6KCV1DGxFkkyYH1GqxMtgMVLgm/TIkf1o8SWf3bGYuVAS9C4R7Fc9x54xoXwg
 twrW1ui8KuqYMIelxZJlVuJizWsVJ1GHOtts1P9XJYUlgMkXpKPlwiOu5vYPcHRBFejK
 /Gvr8kN13BL+jqu6Dr3ZrZ2jezmD20Tu9/A9o=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XjqHW6KC
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

On 2026-07-28T11:35:30, Sergio Prado <sergio.prado@e-labworks.com> wrote:
> binman: x509_cert: document PKCS#11 URI support in keyfile
>
> The 'keyfile' entry argument of an x509 certificate entry is passed
> straight to 'openssl -key', which on OpenSSL 3.x resolves it through the
> STORE API. Any URI the STORE API understands therefore already works,
> including a PKCS#11 URI (RFC 7512) naming a key held in a hardware
> security module.
>
> Nothing in binman had to change for that, but nothing said so either.
> Document the forms 'keyfile' accepts - a PEM key file on disk, a PKCS#11
> URI, or a PKCS#11 URI prefixed with 'org.openssl.engine:<engine>:' for
> setups which only have the older pkcs11 engine - along with the OpenSSL
> configuration they need and the two ways of supplying the token PIN for
> unattended signing.
>
> PKCS#11 signing needs OpenSSL 3.x. The provider API and the
> 'org.openssl.engine:' STORE scheme both appeared in 3.0, and OpenSSL 4.0
> removed the ENGINE API altogether [1], so the engine form is specific to
> 3.x while the provider form is the one to build on. OpenSSL 1.x is not
> supported.
>
> When a PIN is given both in openssl.cnf via pkcs11-module-token-pin and
> as a pin-value attribute in the URI, the URI wins. This was measured
> with SoftHSM2 and the pkcs11 provider on OpenSSL 3.4.1.
>
> Add testX509CertPkcs11, which signs against a SoftHSM2 token with the
> PIN carried in the URI and skips cleanly when the OpenSSL pkcs11
> provider is not installed. Add testX509CertKeyfile too, which checks
> that the 'keyfile' property is read and that the entry argument
> overrides it; it uses an image description of its own rather than
> x509_cert.dts, so that the file naming a nonexistent key cannot trip up
> tests which just want a signed certificate.
>
> [1] https://openssl-library.org/post/2025-12-18-remove-engines/
>
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
>
> tools/binman/binman.rst                          | 52 +++++++++++++
>  tools/binman/etype/x509_cert.py                  |  4 +-
>  tools/binman/ftest.py                            | 96 ++++++++++++++++++++++++
>  tools/binman/test/fit/openssl_provider.conf      | 14 ++++
>  tools/binman/test/security/x509_cert_keyfile.dts | 25 ++++++
>  5 files changed, 190 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
