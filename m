Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B758C4167B
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 21:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC2A6864E7;
	Fri,  3 Nov 2023 22:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UTSm4DLm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1406E86863; Fri,  3 Nov 2023 22:27:08 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C190386489
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 22:27:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-280cd4e6f47so572715a91.1
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 14:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699046823; x=1699651623; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxBfSa48xVGiWbmfdEVuAKoo835CquNSNmhGGs4wjo4=;
 b=UTSm4DLmqz66WkhbEcSCvc85oM19RQ8c8aPra66HJSogGDx0hS/iEBFRKclJMehBhS
 T4TUo8mVhn1gBVW1CUAcg/SXS3wy7thiJ0lP+AgxT6BWQQhgrTHdL5hTsptBNx0v0vYK
 PUPdAKjxNmMQ/Pv+e+hOG3xprJ40z444nhoExXEmJBggrRQeYXw5z3vBVnK7LLynwaA2
 M0q2kcaeTVfgpoRr/5cQgyz5ANro2og74QkQPa/SUfcjrzMto12WjQ0OK2aDW2AmwtCx
 mxrBw93KfU9rKGlJqhnAtVPZlYhpjx/qZ2zxGVmF2fvuU1BQyT5JoDMsoad/rdNqrTTi
 muUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699046823; x=1699651623;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxBfSa48xVGiWbmfdEVuAKoo835CquNSNmhGGs4wjo4=;
 b=YS+lTPdhamR3ramVUt8JIWOofFsgPAqobo3RicTZmN3xymJnJOxVpWRi0eTs155/9g
 vvlTLNfbbSiQb0eMkxvb+h4iGqBFHEI6PeUECLCc/jfznWQegnpan+byDbNzkNtSAgdd
 JaKXS9YQtXhxZYhNz7Ct+BqAI3q3TA4q0zwtftLsJZkuMLeb0ebXmXeQ1FSmE0flZXEb
 5B4zjrQzZY+F2a7+QOt0E1zm+e73K8qHnsc9Lbcsc0CbbO528joqEh4PjbjwZtL5hA1H
 NSge3rDd4Lvy7zAWWJaXwsDbq/LuxIH+lZT6geU5pvCYnX0P8MgWLtTWGytNZsSbPINR
 u1Yw==
X-Gm-Message-State: AOJu0YznMNl+QBRrINUpBGlUMGdogU79uJpRPjbsHRcaUjUXMdVbn0+G
 t9FfPGCYRNB1oHJ6Ipy1C2IH/bK7zfXKFV4X3a8=
X-Google-Smtp-Source: AGHT+IEPrhYBThIOheuJUuY2VpP9F54n2n4dZVL9SBiI18QRo+SsleiHFcFrt67YH3Ie+4pKGiO6ar2ahyBZCKsG18A=
X-Received: by 2002:a17:90b:812:b0:280:1d2a:acc9 with SMTP id
 bk18-20020a17090b081200b002801d2aacc9mr19313657pjb.4.1699046822794; Fri, 03
 Nov 2023 14:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231103211640.423-1-egyszeregy@freemail.hu>
In-Reply-To: <20231103211640.423-1-egyszeregy@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 3 Nov 2023 18:26:50 -0300
Message-ID: <CAOMZO5AeBwBrJcbU1c2F9pgHYjj4xGpHmxYn6wR+q1m6LBmdHg@mail.gmail.com>
Subject: Re: [PATCH 1/1] pico-imx7d: fix typo in AR8035 comment
To: egyszeregy@freemail.hu
Cc: u-boot@lists.denx.de, otavio@ossystems.com.br
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

On Fri, Nov 3, 2023 at 6:16=E2=80=AFPM <egyszeregy@freemail.hu> wrote:
>
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>
> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

Please make sure to run checkpatch and make it happy:

./scripts/checkpatch.pl 0001-pico-imx7d-fix-typo-in-AR8035-comment.patch
WARNING: Missing commit description - Add an appropriate one

total: 0 errors, 1 warnings, 0 checks, 8 lines checked

Also, it would be better to submit this patch as part of a series.
