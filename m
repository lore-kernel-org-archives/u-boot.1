Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDD7CD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 19:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D0F884CEF;
	Fri,  8 May 2026 21:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TMl/1dCs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7B5384DEC; Fri,  8 May 2026 21:56:36 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1A9884CC3
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 21:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-65c0891f4e9so3794918a12.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 12:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778270194; cv=none;
 d=google.com; s=arc-20240605;
 b=RbBAGaMm+HGMWx6bzlOja4NJxRPWrOwQVZHJ7CI8tcnYXv0eRWmZG01MCqbsRVIpUO
 76oXKGrx4BmA/Q9LLASq1gEEXi5/UWud/2oAeQ/hiVvmjCJKxho0QAvv2gnSEejywPRb
 X0YbvI5BQvcLweKVkVtiO8OVXitU8bcntHbLby6gccA4lZ2BSPYhYqkk6gKCDS6SVJ72
 s528EbfWDqOuX+qvJcz8VkO+cEvUnR+wNurljsTs9rMKZwYTe+evHib6y377bokso6Yx
 HEP7clmNs4iMaeKcMRoUG0ndoWpuDcQIFrK6mkhGU2anqwTfzHv0bDTKZyEzsYmE26W+
 cOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dYrKI0rFqUgCbENRdYxJsJm9B5HNIL6RD1gvc0661Xo=;
 fh=pJSPGvoqN3z3lvsc2kwD4R8eO5gBihxxllq7mPAiOaU=;
 b=S6+mWuXZCs6UxbLFisftyxuZIXNyDvyjGjxmVbl0qvs0cF6770SMwWNL5rhHPyYLPa
 DfYqr694DVj9M50sSIO1nWPkM35KlwLeTerMjE3Ei0SrfjQRAWIgfFbs+qyQqzyssbrT
 ZV1HPvZUCxJL/uth5+aXQWPTqTcJRkSqjKWgvOEnKSbpAx03te1L7Gq91pXKuVX81CX2
 a9sK0yN1VH2stuJ3d0chH4B5n7chHrFj2O4edGOJsZtY75vOswjZRlJGrCh0LsApE2nQ
 7peNHLymRZTO4N2jq8IT+eKug9EF1NqjIp1KGsonElqBIEFA62AzuY4vqcHRNE/zFTc6
 k4OA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778270194; x=1778874994; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dYrKI0rFqUgCbENRdYxJsJm9B5HNIL6RD1gvc0661Xo=;
 b=TMl/1dCsuBMkKqOEw0YPCaV01jILB9hCQXT4Ohgbtaetu+eg8ocelz4GadtafcdHAG
 pPsRQ7VeFqRa63g0VDEwA/XOkPOWCXsrvNrTlCcy9pC9B9D3F+Z9NUTDjIG6PfURt8yx
 FrU/yTDtD7kCBcQZO+L934X36YM50Da+pqLbZaJSox/BJvmK3BYr0bYAyrPSXjjDn6yz
 sJa2rGA8VNf4kwfeSISA1XQznK23HJAlD8ISRNVi1xgOcgG/8dCm9WR636v/ptFvF/fZ
 CSqPQviy5LNJdvzubBlYL4JqlbfUyh2+ubNV3fE0nYxwqT8W9ZLI+Rzi+AXry1ds+iXF
 Pn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778270194; x=1778874994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dYrKI0rFqUgCbENRdYxJsJm9B5HNIL6RD1gvc0661Xo=;
 b=rqSe/g/GvGgOvWiuDVpozZY5AumgIkIXFWU/B8CmvjPNSfeATlXgfI2h2QwG+snC7J
 HeqpJnkkkHSkD7nv7BFhFjd16TTd4iAR1aJGKtvxWVK6i69kBGZfh1sAlZw9Rxbp0oob
 nq2j4qM68wuO68HWOncHp/os9eASn6ItFwIrnS3ajDeU3cEWLjh5scbrEGwqJxF0lAaE
 eC50O6Dxr2iRNTN6+KyXOb+GNz99toXGFsJ+C7/yPQ5BoLcOUJCY8B5iKgaI++Kzu/Aj
 ltutaUGL5kOluvOKtsPZDCM7IVFlQuQOt5yh6CzDnT/q6PfzD1apFM0USMcChH8NH0iA
 +EdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pjgGXxrVFDCGk/9w7aJCWnYuSVGOk/5UOEXpNl99Ra+YMN4HykNSj8gHI5+LwWz+rkYJcs6c=@lists.denx.de
X-Gm-Message-State: AOJu0Yxy9Fk+P7arshWlyltybLCKqp9Qgjd2J5LT83lvwIeDmC0Svn2j
 RxQsuoTk1EVu1lqzxZF57DKrw1K4v0ZjpNtEgosz4OWaUyCXBPfH9R42rZjE8dgf/4FRhlP2e4y
 Rrcm4iofMt4tRQ66g/GL2joz3PmezTXM=
X-Gm-Gg: Acq92OHe+AlmdiaQsbZFuOkfo1cuQEj7e/VMiRe1dtU2qd31p8meWK9iwgxmqxdWMOY
 9Fm2BB/XH6QDKg3lUzFUdleiqhGqv5UwzaL+PfDwzA3JrV3MdK89TCB/f+aiswNGgPHOowxW54Y
 wKm+8f2V0i8cSIEPd16TekKn75dzGvSU/cDLzpVgGSaTYFvNNaqgU7Gu8zjDlGU1m1n8htVjI9H
 JIG5vcbG5f3e0rAVksR51gAvSdPfJgYgjj7ABgkCpjy+K0m4mNK/cu1z1ewPNmp2YkfndWCMKCU
 APn9jkJvZuZI6FvUyu7yP0geJ8gu6N4IJDArG6e8nxvaqvWDhOAuSHa/fDMXwU2wZd8QW+29hNo
 AeAGYglDj1xubQAHRUk6hOfDuh1vEWKVkRlDFpbJzgNLzWxflOQKqjc2ik9c/tPvhgv8HOA+AUh
 l+MdfGRLav8IE=
X-Received: by 2002:a05:6402:29a:b0:66e:378d:2e56 with SMTP id
 4fb4d7f45d1cf-67d63d8dc10mr5259407a12.6.1778270194005; Fri, 08 May 2026
 12:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260508154108.336B968BEB@verein.lst.de>
 <20260508154239.1E16368BFE@verein.lst.de>
 <CAFLszTgaG8RV=kWgr7Gu3tkVniq5pNVQ7RSUEv2EMyyQ4ALO6Q@mail.gmail.com>
 <20260508214222.642b15cb@lst.de>
In-Reply-To: <20260508214222.642b15cb@lst.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 8 May 2026 20:56:22 +0100
X-Gm-Features: AVHnY4JGX7S_xS7yrOzb2DDt6bQVna__diWMp36Y3wQ4NhjM03RFCjZ8knFibPk
Message-ID: <CALeDE9NQKk8Cd3bAUqM6Rpf2ZDtTUkRSKnzsG+p7ycCihNvHYA@mail.gmail.com>
Subject: Re: [PATCH 1/3] core: Skip parent device nodes without a DT reference
 when looking for dma-ranges
To: Torsten Duwe <duwe@lst.de>
Cc: Simon Glass <sjg@chromium.org>, Matthias Brugger <mbrugger@suse.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Andrea della Porta <andrea.porta@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 8 May 2026 at 20:42, Torsten Duwe <duwe@lst.de> wrote:
>
> On Fri, 8 May 2026 12:47:45 -0600
> Simon Glass <sjg@chromium.org> wrote:
> [...]
> > There's already a unit test for device_get_dma_constraints() in
> > test/dm/read.c (dm_test_dma_ranges). Since you are extending it to
> > walk past nodes without an ofnode, please can you add a case
> > exercising the new path - a sandbox device whose immediate parent has
> > no DT reference should do it.
>
> I'll have a look.
>
> Talking unit tests, is it just me who experiences reproducible crashes
> on RPi5 with today's master branch?

Not just you, I saw crashes when I tested rc1 but I've not had time to
bisect it and see what other platforms are affected.
