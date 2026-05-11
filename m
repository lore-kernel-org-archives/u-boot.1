Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9739FCD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1C5784255;
	Mon, 11 May 2026 15:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SdNoMq1b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFC0484656; Mon, 11 May 2026 15:11:15 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19D228460B
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bd2087858c4so16018966b.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778505073; cv=none;
 d=google.com; s=arc-20240605;
 b=TPiQRtUTQYHz+rVytAudYNcqX18NnWAAU7dY0uCrDpqzAzuMgEB4v8+rKyseFc2wHk
 dZ5TBuhTFi/9F9uxVL12aFFi0eJGyy1sD6NE85bwy0P8BDIBkrR6wYV/njJmaWTNUZfb
 1MMTSPqJJkjhp8CV18K4EW4j6JCD2WXoTuxpaAg/LFm3vL8XVszpO1Mb3HwO2B81dFmu
 S8Py9P11n7u3eOs7nYJ3AhgcvrMoAfGHVKN6jJv3zfaDeo9gdsS42uUBml6Cke1SYJk9
 uq/lN+uhZovyNJL2X0eSPj0pbps2lbqwJuXd2TGj9fcHWWDZgU+Ri8TJnrC1tGblN0ob
 YjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=L2zA3xi5jriHNacmPpvkKD7XPmPISfhopRqQwZUpeWA=;
 fh=YDH4tYxYY/L18TkSaMEaPWRyobgWco5gBQA2N64+Pfk=;
 b=lVrcP7znyjW8or2mpJeuzBoejPDjJo3qX4LoMECv9jxX97yRTPwrcC7oy/Ki3dSzFx
 RqrwJrJF/+qnpFrVRP9MCuS5Z9sy4Bd9D756ZSn/f2ln1XCVFDTp2yHIKdEOG1SXDkVx
 mEZC5NOeil9ZY/jeTneOzdl9hij1Ci2X7DqmN35y6HiFU7rDO2CvHimFaWe4Gg0zkZBH
 N0qAeMAwsecqPWOFtEgCEJBBf6MaT2DO+PLecpexI4/CXbE+gwH/PIg2tKR/9VMq/jmM
 ifNiEJjha1816VpBQ6GWp0SYTbnkm/fV4GbSLMNwM9t+yQspGfymOmGUSF51/9oADIHK
 A6xA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778505073; x=1779109873; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L2zA3xi5jriHNacmPpvkKD7XPmPISfhopRqQwZUpeWA=;
 b=SdNoMq1b71mMMy9Ph21DVFmmwPjiENrfN3vdBHIpDVT8eQX8GD55nQFjTE7C0bW52m
 ul4zhIW+qQ7VOmoL5kf+N8qOkCqmg8H4cb6fzhZBwYtKEz1n06UhC1reeoGcWF1gFUUZ
 B+cfqLbKk4ImATQtKwyu+NJnJ5vzD8auxVWHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778505073; x=1779109873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2zA3xi5jriHNacmPpvkKD7XPmPISfhopRqQwZUpeWA=;
 b=S3L348gm67qJu7yRY25+gmlcvoq+vmQJGCAT4LJhzW5mNIiowwThDUX1DP+29bmss2
 51YGvOHt+HgJrysw44vUejA1i/vSSDSHCQcb0w0RshR/0XUAtNSwXLIJ2u9zcN5HgaeK
 2vpzFjSkwovBX1oWQiP7PH88JAUQPodNWI/wjYrVl5y8egrSJD8A/wpsEsRH+Np0B2ji
 Z1DMePokIVB3CVTCWoYEEFK+/RNmOoPBpEFzuOGG7fqKSzGfkFj7+xxM/t9bHdkoIJ7y
 CYAIOSOUijCzrpqbCxzylXBr4pDnqWXDC39CTgf2ZtnbeaBO6phMkIo36w6NGEC2ifIr
 fS/g==
X-Gm-Message-State: AOJu0Yy3HW0qeCLIwH3le3+z5kqqUyuatPGCuZq95Z+ksPnrfgJXOpdY
 jh/r/YTqI5ytA4svqIwVQlk83aMbD9qcot8/vI3rvDho3LVyyf7O3uQGkrWrKn70xhtDUEVu2Q9
 V8QKIebeIOS05RV6PSFJe0tqDDnj71T0ANFuUENkY
X-Gm-Gg: Acq92OE271B65xBHamnWV3Sseq88gN1HF+QWq928xI6vZTsTdUjwm0vh/DdbSIsD+ph
 ju3gJ+ZB7ILO/d6O8dWnQKNTq77oWrqZGwPRnwj5tjRc5rCjAicPLmxdG7vOwhOaOHFUXlIlUli
 fo0uCrd5RuL6nANQZE1cSO4PGQwVmzdep1S2hoLhOtMGScRe8px/swHH0FrMWn+mFYYPo6MV5PD
 MU9Q5dCbkvQmhglfx7nNuoPs8PHriMi3f43MDC6nOKCULYij/T51q1zScEvGLIwC/1PYewRdEHO
 j8oltA==
X-Received: by 2002:a17:906:478e:b0:ba5:885d:3280 with SMTP id
 a640c23a62f3a-bcaaa54ff6dmr778842966b.17.1778505073350; Mon, 11 May 2026
 06:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260510171604.56788-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171604.56788-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:10:55 -0600
X-Gm-Features: AVHnY4Lj2ZZiXYMMBBstieHHWEQNY7gOB9e4SmvQbJ-BmbjiRaFlwMoLjP9tpY4
Message-ID: <CAFLszTitpkTwc8vgmHd7jaK87QmWOMQP3LW9F=ZheOA6++3xXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] scsi: sandbox: Staticize and constify driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

On 2026-05-10T17:15:52, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> scsi: sandbox: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/scsi/sandbox_scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
