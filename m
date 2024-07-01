Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633E7C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 13:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E33DE886F0;
	Mon,  1 Jul 2024 15:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SfwGSX35";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8690886D2; Mon,  1 Jul 2024 15:58:10 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4075886DD
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 15:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-79c0bc8092dso269809185a.2
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 06:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719842286; x=1720447086; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dW+P11xzbDZ23FQ0/b4DksWiJTddlvgUeoQVl5tlaOo=;
 b=SfwGSX35BWJrbTXjVDzMnE94Cgn9XzBTCzCV33lvHcfIOv/eP7kT/l/+O4QAlUwwqp
 /LGkE01AsjU0euyIi9rBFbPuoCCXe2AKQocy4smDECugfngikYODA/nRQtILHLCz9s9q
 EFmI859+Cg+siGurWa8W99BOpnojExBXQPZIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719842286; x=1720447086;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dW+P11xzbDZ23FQ0/b4DksWiJTddlvgUeoQVl5tlaOo=;
 b=qgll5OHx85zki/Phvzl+HwiyvJc/R9u+gckVVWtK3uQkp9wINm+jS+q/QvMiRVAmI/
 CGc4AKODD2D3h8PQ1v5u7YVxaTdm5u297hnKmyycMxyjOfzxEo1oGKkuwEopJ6Lnvuvj
 A61LNMGVKQFilEKKK7R9VdzPEoXwUl4HN1zCxnAO+wojdA/qYi4vY4nqGrscVjk3tmfh
 vYX3O/AaIl3G8WTQ+aIYhS6AS/qU/YMWOglNdND8ElAbmM85jjvItcb6XNKARqq9RKJ1
 UsjXBCS4gMGMrSrfInFxnzPBaQVyBWs+cWS3MsSBKME6PuFAjbWAFrXwkF5OofX1HS1e
 MSqA==
X-Gm-Message-State: AOJu0YwG23M1zQpt+4ZXJQGFkJHbu2rO169s5WQC7lYg91mPP3MwDKdT
 gSdaFN6aHNqOQekAdz4sfZifzoEtoEBarPo5iT6J7PhhtWX5R5YxyA+hUR5VU/ijuToKUi9mWtW
 YnXPVqkzk4R5IXRpJg8GYbJd9kF1NlZD0+/bs35LlarpxC74=
X-Google-Smtp-Source: AGHT+IE2ry8NwX2YO2z2bN7pu9qqt82GXFD7XNyHgsJ9NtLug5xv88GaBkJMzR9NrRXXar/O55rSkWdnzeYQmJXL/xI=
X-Received: by 2002:a05:6214:1943:b0:6b5:8e02:834b with SMTP id
 6a1803df08f44-6b5b71ad227mr105799376d6.57.1719842285701; Mon, 01 Jul 2024
 06:58:05 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jul 2024 14:57:55 +0100
Message-ID: <CAFLszTjc9zvvLRAc__dNdvenFQfvr9mWvRHtsBPr1ffVi0js8w@mail.gmail.com>
Subject: Re: Allow encrypting data in FIT with binman
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Paul HENRYS <paul.henrys_ext@softathome.com>
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

Hi Paul,

Unfortunately I did not receive the email with your patch but I see it
in patchwork here:

https://patchwork.ozlabs.org/bundle/sjg/dm/?series=408037

I get this error:

binman test testSimpleFitEncryptedData
======================== Running binman tests ========================
E
======================================================================
ERROR: testSimpleFitEncryptedData (binman.ftest.TestFunctional)
Test an image with a FIT containing data to be encrypted
----------------------------------------------------------------------
ValueError: Error 1 running 'mkimage -t -k tools/binman/test -F
/tmp/binman.s_qv4_fc/fit.fit': File tools/binman/test/aes256.bin don't
have the expected size (size=0, expected=32)
mkimage Can't add hashes to FIT blob: -1
Error: Bad parameters for FIT image type
Usage: mkimage [-T type] -l image
...

The aes.bin file seems to be empty for me. Can you please check the patch?

Thank you for doing a proper test.  Can you also please update the
docs for Entry_fit to cover your new property, and regenerate
entries.rst ?

Note that there is a tools.readfile() helper which can read a binary/text file.

Regards,
Simon
