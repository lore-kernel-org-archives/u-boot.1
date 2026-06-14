Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36422CD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 11:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E92CC83EEF;
	Sun, 14 Jun 2026 13:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UKsPqFK+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDBDC84704; Sun, 14 Jun 2026 13:53:00 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96B0F800AE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 13:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-69170548d0eso3359970a12.2
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 04:52:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781437978; cv=none;
 d=google.com; s=arc-20240605;
 b=VCs6A86/f6DtbxNXgNJiYCzm+e003DdeQnppsYDeRSv4saOHxuWk1N9Qu40Ia/gBTr
 PeF9gTDm7F09X0mtxDBMj6WivHMMXi0jXAdVGMDNnWgGLEbuOuavMmcYqd0DNLvmVV3Z
 s1NNQDgMzTz9gBs45sulmHGFw3fy1TkFPvLk6Jo8Vl/Vynjg07cxvi2jTPHN2c6zBw2X
 uxp6i9CLG5rit1L6AVLJesyX314yB8uupyHLV4H+bPr9z5V8k8G6gK7Lq/mzfTCBVsqp
 +qResG5rTCEC7ntkTYcgh7kISUX4PZ3ysDteYvbJ1IqLpJ+NsXO9HwP6goWkkPxFWBD4
 ViUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S9pa0OxYzrPE4UEBaXzw7N86DlI8Qag+gf7sA5XV42o=;
 fh=q0UJzdg/G+5ABDTXroBxmVMIOy+JiQr2hi4107g7Fr4=;
 b=WIQqBsCbpQBOLiU4iE6qB8kEigpxMHXPj1WSmr0lLwYg9e6QrMBw+to4M9eWvC82hZ
 sIWSPagVtKMkNtMC7BzJWfk1s/2UIeZ5oRjIhFLDDDmWqmGzH+gXWgK/QxJdTXWr2z17
 6Q7TbQDSEGVZxzNf904/9tdSBJzkxJDoF688n01atlg4reBgWInKb8+k9wJkn1UL2Nzn
 nzxIdSHc/rfZOY5bTEQzBc8nmWjU1XIbgFyfDtQdaXZZgCDQLtAxtIvPAZI12dobppp2
 MiT2vn6+i3z7EXijb03n1vnYUuwt1GKG7jMLD140b7zyTH72vsRfnxJPcTqYniWqh0aW
 Arvw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781437978; x=1782042778; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S9pa0OxYzrPE4UEBaXzw7N86DlI8Qag+gf7sA5XV42o=;
 b=UKsPqFK+C/hajvHM1800wtUDglsPlBEuDvwISEjJwdDr+OczyLJsvz1Dxl/fRN5Hg3
 AKsBKg/8/dHhxljHQl/KSzKvGxGi+zaX/O7v4nUFwm5Y7gJWkYqX49hcC5o9Mg6NdB4h
 Mr6NmOgPaCexjLdK6uNUEHXSwrjls8VCLc400=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781437978; x=1782042778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S9pa0OxYzrPE4UEBaXzw7N86DlI8Qag+gf7sA5XV42o=;
 b=P67CD/uoqtUfX3mEK790/pOPWKgQnDjF4NiEJyIL6NIwVEQt5BmTfPMRkXpCmsgGYd
 XaLTgteedp1YLcZLvlRlnhT8Rsr3+vQL9YA/TuJeLvYGkYHH4gZCEu0KcVP7F2EisXwA
 O5CNVmCzSpI6jaTc4+/0NYxy0SY7M5o7F1Kl1LK06GtTmcDNSv5c+FtypYSIty0X5rpY
 q6vswopDfv/waUdtgICLjY6BsXtRiR12B+q4W1c03HcDfqeyLa1Z64vh38iCzSwYiQxP
 QgxmYwGJ6vzlkThM+rvJLQRCwkXgTtlfJ4Y/Hqmsvy1W4yhPCi/rHkO8zaPqtPGfPkTa
 GKvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CUUosRJTaSX5luGgMJSZHrMtRnBJpEmKxw5L+cHPTLdn3yEcAZlUsbRVp64KbWWdRuBo0XfU=@lists.denx.de
X-Gm-Message-State: AOJu0YzN01SrIdwg4X7sN3DmyOu4/EkWlj4SmgesflcUVY8Vzj2gPcqd
 diwrRpwndU2HFe32aWFJDYZeJmFpIZjm8+4fVq3azEh8dQHp5IdeqQu8vAx6PKjBoRfIZx80Gru
 XkpNRS+fSfUYyovU+ujLJNl9VLGZKPkOQam/KUCWv
X-Gm-Gg: Acq92OH5jbn6EmwN8MW+UO/mbZiWQusqB9P6q2mZG6YqyjuaFiGa27+0+LZcqMxSSe7
 btTSjcYHBI7jlNrlxJVI4KqVJBmu/6DSv6oX57jE40DfUS5W0sitCca6koYxYwG8nOsOismt3Sz
 YQ8qOni+XPXRPIWSv1Cbnf7vgzdf2w3lqMSI+DS0iSiTs2F1I+hweyVJ7nVJ5Gf/480908FrcG0
 cKMurGaqO/SfdRaA/ZQvkRFdzqrl9G20RtIQTIqq2QFfzcUNReLyiOVIio3sMx0ACsRklssH+MU
 +Kdzwg==
X-Received: by 2002:a05:6402:2811:b0:68b:d82b:fc2 with SMTP id
 4fb4d7f45d1cf-693c6bbe62emr2627268a12.26.1781437978082; Sun, 14 Jun 2026
 04:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
 <20260601134310.2452454-2-philippe.reynes@softathome.com>
In-Reply-To: <20260601134310.2452454-2-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 05:52:45 -0600
X-Gm-Features: AVVi8CeF3NwwVhIZati3z2_LAHDTUiKxsjXhO_3WFE7lb7HfYOyvUtdb-axVQdk
Message-ID: <CAFLszThAfinyyitA6V2Oe_UxxOeTD=7cGN1dYGSKP2fVPaw2QA@mail.gmail.com>
Subject: Re: [PATCH v8 01/15] ecdsa: fix support of secp521r1
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

On 2026-06-01T13:42:58, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> ecdsa: fix support of secp521r1
>
> Current implementation of ecdsa only supports key len aligned on
> 8 bits. But the curve secp521r1 uses a key of 521 bits which is not
> aligned on 8 bits. In this commit, we update the keys management
> for ecdsa to support keys that are not aligned on 8 bits.
>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
>
> lib/ecdsa/ecdsa-libcrypto.c | 75 +++++++++++++++++++++++++++++++++++++++++++--
>  lib/ecdsa/ecdsa-verify.c    | 71 +++++++++++++++++++++++++++++++++++++++---
>  lib/fdt-libcrypto.c         |  2 +-
>  tools/image-sig-host.c      |  7 +++++
>  4 files changed, 148 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
