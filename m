Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E08C43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 16:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0394484409;
	Thu,  2 Jul 2026 18:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="CLPtmIDA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E681F84671; Thu,  2 Jul 2026 18:47:06 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C9FB83FEE
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 18:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-37f7a5a217fso1766371a91.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 09:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783010823; cv=none;
 d=google.com; s=arc-20260327;
 b=R43ewEMHT6g1x9aoo2mkJpGbsIczLUVLUMkMydFeuxD0ji9LWdDht/tO+dIM0vuiIE
 j4/GxkoZdXZSaI6BCZgcHnFvs9RpiDbQuc3bTeTatXtq3YrxhPhMaFNA5m/0qUpcT3PD
 M50O2n0Y0a5NG9z7NPYtuwt5064ENnws/NKtxIA26xxmOcfXdSC9wsYiKH4zVeiit+oQ
 9G2G7dPesxgpQ8wThaklZdHC0CuK2Qa0HMffXYcmLOZWoumGyVUVXX1tmeWN+Le+SC4S
 l1LOwvjvjrccUs8q63EY6b6qG8pmDwPdfgUOtLOgRw9/59yKup5fxydtdgdNgo8OBywI
 Uypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vo9a9SNovMaWAefi2vM8TrH0PGKMzYLUJ3Gz4hOY/Z8=;
 fh=Clcr5shMxu0DXwHz9Up5uSrOFHc+ci/jwuRw35EL6Vw=;
 b=raqywpex7AGA/3C0ZAn0DEQ7faKX89nVniPn1zbOq5mJzetdh+F7K5BDsLQeTYvCwa
 Jb0HnvyqQjD0YvH/oo7W0OaEyvaBLCnHfiw9JT9CU+YJiwevvDvrddhtcVQtYjH7Wmjw
 JdKiqdjJGqDE9ynPOdwQHNogopZzKPXFKTOVZfR8yvjWMPNnPHZ3EVIjvBIrThqKle+y
 JArIedLHPvBlb0aoUguSIhspemGKqrWeH6RSiqWOL34MS4yF6WDBj2M6tcufUjtWliuz
 K1XB4vL3vhOsEptPJvqIX8Q3g71FR7oloqREx7Q7Iep5mGdQ0OSPs8VlTroTfFl2yXcR
 2MxA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1783010823; x=1783615623;
 darn=lists.denx.de; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vo9a9SNovMaWAefi2vM8TrH0PGKMzYLUJ3Gz4hOY/Z8=;
 b=CLPtmIDA+xP353VTgby+FUlRg/8NTF7t9KBLC2uj4uqLlK9XZ/K0l5GJrnYrl6eBgg
 wLqZIRebh7s4FYEIEzS88ARsqFT7Nd8SIAar3pr7DUjuCx1z/IxP39wC6p5MlV0pb90/
 91igymvf4quQdAME3tDEIoddfahEFXlZtp2mnLFbPuXWTYgp7MNzNPptmzg6yoYlrR+w
 zC93yot9z/Ky+gRn2tpXusRzR5viCfdHOstJA7tFnbY+x7ySq55RFmHqDm+xzNMMwNZD
 4GAuKqUGy9a3ZPtdc4re7UINvND9uGyKMI6pL0wedf/1otfnGHXK0RLZh51dOUn05Dm8
 5rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783010823; x=1783615623;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vo9a9SNovMaWAefi2vM8TrH0PGKMzYLUJ3Gz4hOY/Z8=;
 b=DMmBLlGNTCpzvps+8/rkrXjRluwqJyDsP1dd/CKC6aslPFuBMViOE+O+AjB5pzGlzf
 V5yeNfQZxanTFdvt7yQk3JZc7UILAxJL2NYXYMsAeIJ+AbLYGAadl6KJu805Q0pAve76
 YY2jeo01JvskOd2Fc9nbJ7Sox7v3kfPIvLzgXagbCuHcXL4mGUT2QwP0igwkz/0CEgCx
 uoYV4JfK4rLlu3xeCQS/K8VQPpnDwtyEecTq9+tWCsHxZtC+qvHxiT39XJBKSBSz0cLk
 1lw+G/sd26VA2rxWEPEqIpMDbJ1z5OvD0O6TOjX6/2ha7Fvxf4u16CnWrFQ34q9LI//a
 H9og==
X-Gm-Message-State: AOJu0YzQ9sJKK3jZlpAwR00C5D/ZIG/KelvM2xCidEgOG+qcilWH2hKn
 GhClkX0YAN9Su4lDz9ObaAdua0dHeTsV8Ku1K9Wd+k0LG1zarsqXOkj6SqB95fqiMYvZcISae5W
 /SAJ9Os0W0TSW8pIQOQdz6GLD26Zg0xQ3I1HkM/ifMQ==
X-Gm-Gg: AfdE7cnNyVKkil8bTqqhs7jLzWgtB88G6ZEDkrxIyzg3tLxsrD7XXfgSyv3nxCyn3u3
 Dhztw6UXnL8MbaDajy9XG8THZIPCmsIiysNrMwAtgtvpZRFb3B9ZXgDSAc/+XYBSogltVTkU1fs
 MTxWJDJ5htSQPl6x5/VpfaaAWS6xORtqcktYX3NCqxK9ykLNNbU/HalYaeyJSIUcdEu7NXPRNmd
 TRTmYmDKlt/E0xvtOv7QO4ti1bQkYuR+0ObhC/lZfEsFfCAvi/TO3nT63yg29+MKScHRK0M2DpD
 VnQQqA2MbLFuAX2RGfFATUI+/EE=
X-Received: by 2002:a17:90b:570e:b0:380:f389:447b with SMTP id
 98e67ed59e1d1-380f38945eamr2483278a91.11.1783010822994; Thu, 02 Jul 2026
 09:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260525132828.3348679-1-sergio.prado@e-labworks.com>
 <20260525132828.3348679-3-sergio.prado@e-labworks.com>
 <CAFLszTiWwxiP3BOrAQ61QHr8X6WYbxWsQp5KqFKSBvLxzsoq6w@mail.gmail.com>
In-Reply-To: <CAFLszTiWwxiP3BOrAQ61QHr8X6WYbxWsQp5KqFKSBvLxzsoq6w@mail.gmail.com>
From: Sergio Prado <sergio.prado@e-labworks.com>
Date: Thu, 2 Jul 2026 13:46:46 -0300
X-Gm-Features: AVVi8CdZialb7eeVrqr-OseM7ng7jWlMXR8-YJKOjfvxNdXcoKgNgRdQlAU8CHU
Message-ID: <CANu7NGuJOOoquPjVfZ6B249AkSHD1NVBuqpDoVinvFYz9f=3Wg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] binman: x509_cert: support PKCS#11 URI in keyfile
 for HSM signing
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, alpernebiyasak@gmail.com, 
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org, 
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com, 
 xypron.glpk@gmx.de, y.moog@phytec.de, afd@ti.com, quentin.schulz@cherry.de, 
 Wojciech.Dubowik@mt.com
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

Hi Simon,

Em dom., 14 de jun. de 2026 =C3=A0s 13:01, Simon Glass <sjg@chromium.org>
escreveu:
[...]
> nit: the 'pkcs11:' substring test is loose - a filesystem path
> containing that token would be treated as a URI. Please use
> key_fname.startswith(('pkcs11:', 'org.openssl.engine:')) instead.

Will fix it in v6. I'll make it slightly stricter than suggested,
startswith(('pkcs11:',
'org.openssl.engine:pkcs11:')), so that a non-pkcs11 engine key (e.g.
org.openssl.engine:tpm2tss:...) doesn't get a pin-value attribute appended
to it.

> Also, the commit message says the URI is forwarded as-is to openssl
> -key, which isn't quite true once PKCS11_PIN is appended. Please
> reword to match the code.

Will reword in v6.

> The test only exercises the provider form; the engine prefix is
> documented as supported but not covered. A small extra case in
> testX509CertBuildPkcs11Key for an engine-prefixed URI would catch
> regressions in the combiner without needing libengine-pkcs11-openssl
> installed.

Good idea, will add it in v6.

Thanks for the review!

Sergio Prado
