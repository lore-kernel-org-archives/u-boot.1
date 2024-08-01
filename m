Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6CBC3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC74288B23;
	Thu,  1 Aug 2024 16:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="XrOY6C4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DB7B88ADB; Thu,  1 Aug 2024 11:59:59 +0200 (CEST)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch
 [185.70.40.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35C818851E
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 11:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=emil.kronborg@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1722506396; x=1722765596;
 bh=vDmmBxyQDuMRLEgOspQiZKXioWWua9u3AwUwwiJJtGc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=XrOY6C4FbwW72iYJ4Vw4yr8ZFq6mIGjmxL+PJjZC3d2sgVe0NXN6W6cKiLMT8EYVs
 +XyAZIhgjJDta7zAW4O+fkb6IxGIlHT+85rQ/lIYo+705WovU2u/WgOKqAzcqq04A5
 7fMRAi6PgHRE6pkFs0jYSKRCAd/2ZYwiORKWRZUujt/umq/4JICJ89gKn1tPFmhmYq
 bdl+AAUEbyV2Z34uLC6bQvNeDZotqyO9sATe9scqA0sEwZZ8/57fFQcnbDlc9DV2Q4
 62mJqL1roFqa0TBZd8/Ckpz66zdIIfvP0qCd13JFeYZU9f59mpgvzHKTUqfjpXIURA
 UTvmemGbMuvIw==
Date: Thu, 01 Aug 2024 09:59:51 +0000
To: Quentin Schulz <quentin.schulz@cherry.de>
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2] doc: document the pwm command
Message-ID: <j4q36ysesqxpc2l222m7s25fgcehneksqitv2p2hyjqubu7xec@ssrff2yzsdkf>
In-Reply-To: <a2fdc6b4-548b-4c66-aca7-3a5e8f29f0f9@cherry.de>
References: <20240731084809.30370-1-emil.kronborg@protonmail.com>
 <7208a42b-4309-4216-ab64-16a5a82eced8.a73bd9c8-8cbe-42e2-876b-4c548d837fba.6d214a3c-c188-466c-933f-ff863159d2d9@emailsignatures365.codetwo.com>
 <a2fdc6b4-548b-4c66-aca7-3a5e8f29f0f9@cherry.de>
Feedback-ID: 20949900:user:proton
X-Pm-Message-ID: e548edfc12543dc4208cdb0682ebd245a6c37810
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 01 Aug 2024 16:06:21 +0200
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

On Thu, Aug 01, 2024 at 11:16 GMT, Quentin Schulz wrote:
>=20
>    Did you test this? It doesn't match the synopsis section, the help tex=
t
>=20
>    of the command and the source code.
>=20
>    Reading the code, pwm enable only expects two arguments, same for pwm
>    disable, so I would assume that the following should be used instead:
>=20
>    pwm enable 0 0
>    pwm disable 0 0
>=20
>    Did we forget to fix the help text and I misread the code maybe?
>=20
>    Cheers,
>    Quentin
>=20

Hi Quentin,

I did indeed test it, and you are correct that pwm enable and disable
only expect two arguments. The additional two arguments (20000 14000)
were a leftover from copy-pasting that I forgot to delete.

You did not misread anything, but I sent out a v2 patch to address
another issue before I got your email.

I will send a v3 patch, which:

- Changes the help text to be explicit about 20 us and 14 us for the
  period and duty cycle, respectively.
- Fixes pwm enable and disable to only expect 2 arguments.

Thanks again.

--=20
Emil Kronborg

