Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B992CEC1116
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 458DB83C6E;
	Mon, 23 Feb 2026 18:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gCZcy3fs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58F2F83DAE; Mon, 23 Feb 2026 18:52:30 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 237C882BF2
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 18:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a7bced39cfso47870625ad.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 09:52:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869146; cv=none;
 d=google.com; s=arc-20240605;
 b=PJpYgCVswOUBJCyh2M/9cU/U3CnAjc254XLcBIaOMz71hc2k2LRYV59pEpiEWyjAge
 9kfPTHMqAHsNdfdX6OLZAg/J/Q5KQe4YpYAtQe8hKJ9MkplYVb/sPOt50mjmJh3sx24O
 8zOJhxmQU+uBz+hN7WbqLdBsAau9bXxmCuKRkxh5U70fPOX72H/KECuttZDn1T6bVcp8
 HRtRX1IOz2+2joco0jgxE6IutWNGBW6grdL5HRTujD/4iNO3bL1PrIaSGUhMS8TXsqPp
 92L3cFH5eKPpQb/mzBvngV40s1IU3b1DMVyWd5Cz9J+YvNPyxnueS0EYS3fCrGak2PsL
 XJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UpyhkSfCTzE9PK5w4H0+2NpS6k23wynLxqm9BYlRlSs=;
 fh=xffF1xVhex1l9BsdcRlyffcAM8fC4aHYk8ee0xWPSgw=;
 b=Sob2VeZ2H4Qi5k+vk7zp//4FSsTRxlaqDypQ0KDhP+frd9/aaAJPMyMRguAELq62+q
 5GKNZ075I7wn49+Xf2BTHnM51yVZnfR+kXizQ7Gq7wo/c0+nTMwe8RqwMRzSzBuwTjXb
 naDfX84Kiio/oVKHWXUD6u3jV0ea87sG2ogc9Uan9Lt7BASnrDcYeUqNnOZXoC9aeYKf
 JIa0lQAmQrM19VYCPwD05R+ymoaelrrL+20uW+Zwrglo3NTFHjuiFUcHNDj9oaxFpHFr
 i4ULyFIUaOes3Jk9IY/kW8owkwd8PTwcVjDzsMycwWQ8ioc549U4R28RHb7vdSFrDxkh
 kO8Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771869146; x=1772473946; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UpyhkSfCTzE9PK5w4H0+2NpS6k23wynLxqm9BYlRlSs=;
 b=gCZcy3fs8LERJUxhzNmVS7ihovNgG8fAAt6OlgL61C9pbTpwulryHzzLet2WkeajSb
 ZjdpmM5fGVyngY8AMmQOAr/IAw981lFpbGZ8tqwKDeA8eTZOpM2G+ZsWG5aYGXpXNwxR
 HXaMz3GkHOqVfkyqiVr/A8I8t5OespIRApm+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771869146; x=1772473946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpyhkSfCTzE9PK5w4H0+2NpS6k23wynLxqm9BYlRlSs=;
 b=XRv5yqutaj+5kt0jJa0ZC4UHoESSE69iB50qfeRdGDewOcJh9mJSa9rp6mpInCZjPa
 KZQw6VNKSWvA6jswST+ZDIlsQYjy5M54iSy6d2zcKoTnwdXby/T9gBQ0hldMy0FUIJMn
 mSlhfzNP7uS2vAMevBCw22htgsp3skxhRBkpJE2rgemUpIJb2L8t/2GAOKM4pwLZP/uo
 ksTJgLMSrZ7z8cjqyRLlfh/59bARvURYnXjeKOQmV5bydgF3U0HR401SJXWX4Kbu90Nm
 YrQDSI1zEmPFEWzS84AZCDnGzZMLgYmjrQi9NDnWkdieCv0Q0ysf0cL1OvPLonux4fLl
 jDCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmTALxzhXuXavdNt+UOna/BhqSDqbVp2NuPnHG87MQjo34HkSHjCGnvI2BQHlyHg5IYfATXTc=@lists.denx.de
X-Gm-Message-State: AOJu0Yze/HzlzjJOu93D2X4Acpekxv3v6w14ZnO04j8DvYzYAmwngcnJ
 rvHbkCeKRMygdRuC6TVMLBtZiWHWh2bLivfFQ9wEBoMu9yw5QRH0E2YOLr0/5krsb0h0c4ETKXd
 c+JFz+gEUJZCsQmByYgHhyQ/P0vyInIMt+Lp9s+Mt
X-Gm-Gg: ATEYQzz9taEyVQ7ncSylf0jhm4cN823fDUN94Xnc06aGnAGCkworIZ8v8VRo2a3M+1Q
 taX+HzLTEF8P0a1nnnfThQ1yz5UULmln3yLxRVM5/7xNCvesNLra0kzt8wRdsbMB+lVwgtWMaIU
 qCYHkvCCvY9wTnBaAnR8NWRh+EVkj45i24AgUBm2yMgGd467btApqvSJQCReb/R6bioeZUmyVTt
 YE+g9Iq8DROyB5pOBdR8utNQKbJ2PhrCMN4uYYEQtjHw2mPQB77CfBVpSrqRoHRrwMHozcUh0Mb
 M28Crg==
X-Received: by 2002:a17:903:4b30:b0:2a7:5171:9222 with SMTP id
 d9443c01a7336-2ad7454a2femr79180975ad.49.1771869146698; Mon, 23 Feb 2026
 09:52:26 -0800 (PST)
MIME-Version: 1.0
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
 <20260219132552.1499698-10-philippe.reynes@softathome.com>
In-Reply-To: <20260219132552.1499698-10-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Feb 2026 10:51:16 -0700
X-Gm-Features: AaiRm53_jAOC4aq1AxkvFszT6jGgTdAzKpFeaduFl8R8UMZvJ2kEDYJVAaYAUpU
Message-ID: <CAFLszTif6u_oqfpHYL+atOpjsU1UP8reMxOCc8vp4k1_4Y4P1w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 9/9] test: vboot: add test for ecdsa
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, u-boot@lists.denx.de
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

On Thu, 19 Feb 2026 at 06:26, Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> This commit adds test case for ecdsa on fit, but not (yet) for
> the global image signature (preload).
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - initial version
>
>  test/py/tests/test_vboot.py                   | 29 ++++++++++++
>  .../vboot/sign-configs-sha256-ecdsa256.its    | 45 +++++++++++++++++++
>  .../vboot/sign-configs-sha256-ecdsa384.its    | 45 +++++++++++++++++++
>  .../vboot/sign-configs-sha256-ecdsa521.its    | 45 +++++++++++++++++++
>  .../vboot/sign-images-sha256-ecdsa256.its     | 42 +++++++++++++++++
>  .../vboot/sign-images-sha256-ecdsa384.its     | 42 +++++++++++++++++
>  .../vboot/sign-images-sha256-ecdsa521.its     | 42 +++++++++++++++++
>  7 files changed, 290 insertions(+)
>  create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
>  create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
>  create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
>  create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa256.its
>  create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa384.its
>  create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa521.its
>

Nice!

Reviewed-by: Simon Glass <simon.glass@canonical.com>
