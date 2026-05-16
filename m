Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F34CD343F
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 01:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4818884812;
	Sat, 16 May 2026 03:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SFMnBNPw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 264668488B; Sat, 16 May 2026 03:07:34 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5411846BD
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 03:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-393a49d2e5eso4901441fa.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 18:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778893651; cv=none;
 d=google.com; s=arc-20240605;
 b=bnagm8CRMwxxahZQJ+28p9mDhUksx+1unEEVetZ9tqr/7z7RHron2nhcNvnjJCkjjV
 8CIW+U4adJ4J7IqS8aTdcUi4yT+eogMN28MvaH47KiPa25yFKQXSRQW+nXDyhD1jIF7J
 Z/jxvDSIcvdD7MpC0iRgn0DotI0eT5i+Z85AqrIRqpqfA3C/2peDj0a7SKv1eBnzxhTj
 lxjdVgy05xCcykuIrwDHRf0QUVi6A4tcr7QFnC+xXjnqy/M9NsEUhNACr2bX+4HBasd+
 e/adEhA80+cTzOeckKd8fonwooVPlpc2L1bKUMnslfZYQSP9nOsA//zzafK1jIt5EUzH
 4XGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=g9SnNR782yIitoXxrLe+ptELopPvULj+ES3NahtZSIM=;
 fh=n9Ax14U1KpYhe5bb39S1ZN5MnbqZgmP6G3DTCAf5bI8=;
 b=ZBm71PLhhAhHzACZatKe2VOstk0LbNrQH20gFSAqBeQiBCN+ancCjBrSBL+jlM/tbf
 Txhuqo3Y5NS71XlAdT+BlkeacIQH5fT0KKtPnc7yidlyS+UhCD+2WO9iNR+ypF+Q8Y5m
 2k8mXLWZkedJAZOqK11HbmDJHfFnn/RpBubDeyG8A3/kj9X5dT0GUaF23aUKAuogk2by
 v16/J0sGMl4BolV9k56N4hOdHVVSvUb1TZD7M0dhVT0Q16ZA6esDQFDRiS7TYJkfaLxV
 gRySeD+YzDsX9rq1N8cMb+TGg5mRlI/Cdp5+6kHei/+PEBmi1Zi+vSEnGn/bOPDPw0Wm
 642A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778893651; x=1779498451; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9SnNR782yIitoXxrLe+ptELopPvULj+ES3NahtZSIM=;
 b=SFMnBNPwVK7A7FtiXHGw5IF0CPRxbUCgSu9Wdi7zUAYYPlW9IYGyMENeEKNct/lAxz
 5moo2xGbNU78vZAQCVlq9HCXaar0WAUWDiag34seag+ow0JRSFFQQwLGL2SiiitzMdXJ
 cbVOojI+OYb0OYgHWKqFmgIefG+ZU7YtYbz6SVNzi8M2L8DFZvsc6klg5z5uRvylm6Fn
 GZ2vaJ8RNDJTv17BoTc99bk6wi54UCL6p6x0wLFvEqBKYow7rqtEqZ98bfLaZ2CwZDJT
 3MV6mCFqJXBDijtxAysA1tpC6u5wCgldyCOrOwhwhSPWeXylmlNfzUlmgcprQfI6FwX6
 dr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778893651; x=1779498451;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g9SnNR782yIitoXxrLe+ptELopPvULj+ES3NahtZSIM=;
 b=O1gW7MjZGzImNcUgPDBuroDZOfmyAkzbU7hJiOjG5Ll52YNkWVlnjBRLsvRc56V92s
 J+gG2e0kzCB7W7d0nl0eFtt7zjbXbujY4K1GCQx+DQmCw0oqxn/qd99AkKdFFmlTfz1x
 VUWYWPWNt5S8l2CKI3QZp55RhoOgl768g3D7b8ramVAaQfrd6rvGFPblAlvVruzcHwqh
 U58zOAfKdcc5JNu5gNa5/+FSJ0FSNsccXvuTptEv+fq+GSxvhVKi4qk8F2Ev/wSf0zba
 bCMVsfiopa0O8KCTnuoEAdQ/WiaTS6CFYtRHb9y3gWVg4+VHjiSfI57eXKDbu7ZJukeU
 9H4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+t6cCYlQWJ722ECCTXdZmwIfL+6e9wSLCZzoUQkBFlwi1ZlIvpJHPzpnJbh5PiHtZDqRolFEE=@lists.denx.de
X-Gm-Message-State: AOJu0YwX/vSUa2xCLg8KzS5jzr2NJZVMrmAILaDuBr7ywWz6y+OCzx79
 9y9U7Y6SE0Qowi+ntL8NSxTkKK221LOCbKEMr8O9QETjUu5IUrFm2swhjg6fbxn6HzYJh4Heunx
 My5FXNW/N+suf4t17dDs6qk/6zmuQsuU=
X-Gm-Gg: Acq92OHqPupiWFiZwqdXBJL+GXEdWAwy6TgYt54EpA1O7MDWoE7A8oN7eWbNtF2DAAM
 DpZl40OwMN4dMmPErHzcDz+YLfq2aGRmyYFjsxkR5nnu3OdDAQ4rgImkk8ByeoVhHny4V2KsOtU
 yekv8wj+Gv4WRBJ0VPbwg1ZFduq3OdmX60uTaMD2zsE9iKWIrJWokVnmTvrieeU7VWfvLItZR7k
 ovVerInpjwBR6LxKMILYZeH1Uh+tWs8fR7DSUykkLV7s/81LWLoPu0X/IeP68wvn3ot/suiCDol
 kmmk+d2/lrSSy+IFG0biTje3owiyRbEqNlVpVoqcw+tSwl36hNbqOOYRZyjk5A6AC3Zprdl/hoa
 nVHUIuHM=
X-Received: by 2002:a2e:a813:0:b0:38c:de21:3e14 with SMTP id
 38308e7fff4ca-39561f18256mr17642861fa.19.1778893650590; Fri, 15 May 2026
 18:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260508115315.252623-1-Max.Merchel@ew.tq-group.com>
In-Reply-To: <20260508115315.252623-1-Max.Merchel@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 May 2026 22:07:18 -0300
X-Gm-Features: AVHnY4J3uEtF48Ha-DkWleq1CUjchDUgNmv5l5FcUCkPTK_h72CnvX3SmEDDxpc
Message-ID: <CAOMZO5DruUe7YY0+HiviP2OgsdBPgvJrhEBf0d0kt=J1K_Jbdw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add support for TQMa6UL[L]x on MBA6ULx
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
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

On Fri, May 8, 2026 at 8:53=E2=80=AFAM Max Merchel <Max.Merchel@ew.tq-group=
.com> wrote:
>
> Adds support for TQMa6UL[L]x. It has 256M and 512M RAM variants which
> are detected by the SPL by initializing them in descending order.
> It can boot from SD, MMC, SPI and USB (SDP). SPI however requires an
> additional prepended NXP header image which is currently unsupported
> in u-boot.
>
> Pipeline: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D13=
172&view=3Dresults

Interesting that it passed Azure's pipeline. It failed on Gitlab's CI:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1451666

The trick is that the error is not explicit. Tom helped me to debug
this error offline.

From Tom:

"And so in another terminal:
$ ps uxwww | grep O=3D
trini     834394  0.0  0.0   3068  2176 pts/1    S+   14:07   0:00
make O=3D/tmp/tmptj4mqomn KCONFIG_IGNORE_DUPLICATES=3D1
include/config/auto.conf
trini    1069113  0.0  0.0   3068  2176 pts/1    S+   14:08   0:00
make O=3D/tmp/tmpqg2bkydk KCONFIG_IGNORE_DUPLICATES=3D1
include/config/auto.conf
trini    1481999  0.0  0.0   3068  2176 pts/1    S+   14:10   0:00
make O=3D/tmp/tmpwgav3dki KCONFIG_IGNORE_DUPLICATES=3D1
include/config/auto.conf
trini    1879754  0.0  0.0   3068  2176 pts/1    S+   14:11   0:00
make O=3D/tmp/tmp7xt1epoi KCONFIG_IGNORE_DUPLICATES=3D1
include/config/auto.conf
trini    2190009  0.0  0.0   9148  2176 pts/3    S+   14:18   0:00
grep --color=3Dauto O=3D
And so:
$ grep SYS_CONFIG_NAME /tmp/tmptj4mqomn/.config
/tmp/tmpqg2bkydk/.config /tmp/tmpwgav3dki/.config
/tmp/tmp7xt1epoi/.config
/tmp/tmptj4mqomn/.config:CONFIG_SYS_CONFIG_NAME=3D"tqma6ul_mba6ul"
/tmp/tmpqg2bkydk/.config:CONFIG_SYS_CONFIG_NAME=3D"tqma6ul_mba6ul"
/tmp/tmpwgav3dki/.config:CONFIG_SYS_CONFIG_NAME=3D"tqma6ul_mba6ul"
/tmp/tmp7xt1epoi/.config:CONFIG_SYS_CONFIG_NAME=3D"tqma6ul_mba6ul"
And that is set in board/tq/tqma6ul/Kconfig and so that leads me to:
configs/tqma6ulx_mba6ul_qspi_defconfig
configs/tqma6ulxl_mba6ul_qspi_defconfig
configs/tqma6ullxl_mba6ul_qspi_defconfig
configs/tqma6ullx_mba6ul_qspi_defconfig

And I see at least the first two don't define ENV_SECT_SIZE which is
probably a migration error on their part. Which also means these weren't
build tested by them before posting."
