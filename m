Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E885EC54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 14:13:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F08F81312;
	Fri, 31 Jul 2026 14:13:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B8leSaS9PrsK; Fri, 31 Jul 2026 14:13:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB2A281090
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785507214;
	bh=XsY5WmtFcs++nuX9Mncq0Nwu0TiwZU4qITPSamFRYU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=khqFgMkAkPeMfoh0TbPWd9YT3Giap5PCBWHUZ4VHSqGqteZoRQCKgjDmXpCPVzO3M
	 hQyH7PMk6pZqBhUYkejI/QW9dcWA2eqBw5UYOaQhwKZ8v4kJ5qmTsSqg7fm2S3SANY
	 bEYAGZY9n3X0OwbfIBwIPAULFZgH6nP79hJXHtF8rkNDnhwHf/BLH17UGHwsnDs6Ms
	 jrBFiEY5Z6AjRWGAoLHwPqAN1AlBVIhQcGWnnHd13+5MZ1IYDR6mSUwr8eyuXibrvw
	 Opn4DOTK5cHjw70MXvAOkMEnl8uEzKJjtl4Gq/ER0kLrqdsDq5SFf0oobMI69+pFBf
	 K1nz1uHr6kcfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB2A281090;
	Fri, 31 Jul 2026 14:13:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4328D27C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 40CFC400C1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:13:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BxCptI8BGhRL for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 14:13:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::229; helo=mail-lj1-x229.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5F5D74004C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F5D74004C
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F5D74004C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:13:32 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-39da69c5ba3so7961011fa.1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785507210; cv=none;
 d=google.com; s=arc-20260327;
 b=G+bDmI08kLN/G8Vun9B68hHq/FntipIqVHFFMG2fbwx6mXFAt0yYOl24BxU7xme4rx
 Prpp6TXg3UoptOIqCqoQBy2+7U8mI8uXw0DPQYAxOXEpagQtlM65E15Rbid4URxu1x6w
 DQ7ms3szVquj0GC6hn8nZJtGQzWTHYHyxKUCgib+Jlyt2qBJ6KaIeENfoH8q7+noLNJn
 AEY+RkviPjT4KDSDW5UreHJ4UeMZWsISUluErLhGVUsL6FWxQVFVM9xhdx4ggq8vcs3G
 gifmJ9pQhbyNa8onCUQRrPd257R2/dMoOE0Ltw1Y1I7f22vxF+4kKUF+95M08YaV8AWn
 oprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XsY5WmtFcs++nuX9Mncq0Nwu0TiwZU4qITPSamFRYU4=;
 fh=pqERukVFhgCix4QlkrPM5PRvZIsDYU03htW8sDxa7hI=;
 b=awyyx0N11A3MjZ8aeghs8z6y8uGT96gGh68euVe30NurnGX5lVEquiA/MENULw0wcG
 23up7+v5vhIiTNWJbnjyVpcpIkYBt1GAWZXsjbW2Y1JUEePN/V4qnDSzXxv8GFSDCL5d
 +h+qKhFZemHJt3K9sIM0Y++8DPn4qMVep7+TvbY8lHfU5WHCi7+qTmMg4fQIUkXn80Po
 1fmK1RJiqS4u2tSx62AdV7Qs9OvUB7pWn065zo6sdkYLGMilyXb+WP4il7gm8Kr+gNxv
 M+I3NjSWkETE910L/KSZQQLRt8MCCIkFbQr6cDO7NxpU6IzEH8W5R9we5cCT3v04rtN9
 7ViA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785507210; x=1786112010;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XsY5WmtFcs++nuX9Mncq0Nwu0TiwZU4qITPSamFRYU4=;
 b=JYyv8j9gRPn3qhOXJ2gMH1e4IohYUUZPLX2oe7OGpv17kyNWNH652BETkxsEaqoKDU
 pX8Uoqjwzrr/Ybrnp0I4LjrlhJMY34/YHSn/CcL+yqPFB5yNtOpmiY8LPbNfKkKAGXbD
 De6Pezg6VL9/Xm2kcsNjqUbBdWvq0duzeTYhbyb6xxFvkSXNT3jcMng7MD/hpxPdAazQ
 e+sPpbWfle+EyuNEnb7EQKPqGD76GEL6ZunqV2rJA5LEXizQXvPs2070wTBAwWB81HwG
 M0Mup4UkPbyOuPT4DM/+Q30SJPN2NRV/lCaW0/RCasVzOVOpzbkMpd0tbuHwl3/LGBBS
 djQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWvqcWivjBLCfn0Jvconx2mW7BnTkeS8g2yMV+uI+Uk/qVtakVXUD52oPGUdJiEM7INh6ANi4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyOmWWlOVoaVqhLRLfLHYVufpg+3y4HJmA5CQR+biCPznUtYBjs
 wzL/xMfiWw+6R1vQbUQikTxqAWO2MsTU4wFjObVrlhJtHu/K5jzKgl6tJnaOhm6u0+IlCItBJeQ
 o5ZYVVTVpMinYQRsikzIev9jRpLfLgVM=
X-Gm-Gg: AR+sD12/ywn+0h7POznbUbmuQZKfMAPywsCotRyVvpirtwPK/hEOP2tanYbjUPM4khj
 L2NXf/OEYyaF5DvDJ+m1KqWslKfUEDjJ1SPHrzKcUo1zSxQ1iqIJErWRjcQnh9x1pi38a1F9UkZ
 2G/m7f4aZGzaS8BBSQ/r4g6/ZbpeD+YR1/9i4ty/hZ+zKQjkYJs3j/sLAuPW1AK8CH4d2YaJpNI
 K/37Uqn6F+/MXKbzG9Zw6LfXUaCE3njgLP1S1FTWRAXpJvQxYW/jp8BkBYVdpCnEz1ODeDbnlSt
 tEnMw8vcgoZIMu1Z9kRaMuFK4UYtA/G19vl/0yuGCLFZKZ3zD5H3SFL7/D8NYqD4Z7noOnLKTlS
 mes6RCwToNh5Wh57XX9D7IVaN1l4x7mQV2Q==
X-Received: by 2002:a2e:90c9:0:b0:393:4e44:63ba with SMTP id
 38308e7fff4ca-39f7e421f58mr3601701fa.29.1785507209549; Fri, 31 Jul 2026
 07:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-93w1-v1-0-62d8459143e1@nxp.com>
 <20260731-93w1-v1-4-62d8459143e1@nxp.com>
In-Reply-To: <20260731-93w1-v1-4-62d8459143e1@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 31 Jul 2026 11:13:18 -0300
X-Gm-Features: AUfX_myjh8CGjQ0n5vKJVHdmuL9GeSbJd8_hGtK6a_sA8lhs_SctDV4uJ3iqg7U
Message-ID: <CAOMZO5AUY3ZT5N8tCa_ZZ+kXxojqs+Z14Nq4R5H0N4cfFg1u2g@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] board: imx93w_evk: add board support for i.MX93W
 EVK
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Johan Jonker <jbx6244@gmail.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785507210; x=1786112010;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XsY5WmtFcs++nuX9Mncq0Nwu0TiwZU4qITPSamFRYU4=;
 b=AhLulPtwOjfPpJfjj53rYNF0HezqLxIRXODlHEM2CLlAc2HGJMIRZmJFC5jNFgonFw
 6WEkgv9r5mdPKWKoiuJP/yych4KSsSaV0h6QU7wXG3VfPVAcejqgNAOuTObgNz7s9V0g
 heraWEKcrN8Qlqg5K8gC2vikxSfI892EiXtIL8ddBobji3Tbc2NhW6fZ1agNxwUX745D
 7iRX0aPpSrnJgLFmh6mD1KMWa4+uJEN51HxsNnoaJGDIBCdFbFrnIoxI7irNieOiwcmf
 ALEVpSeA8f+gRCXv6GtQOuh9qbXbMsNm9XBKYW/KYV8nCx4Bjh9ntuvtlh745/kbiW1z
 vXTw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=AhLulPtw
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

Hi Alice,

On Fri, Jul 31, 2026 at 4:53=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:

>  configs/imx93w_evk_defconfig            | 172 ++++++++++++++++++++++++++=
+++++
>  configs/imx93w_evk_inline_ecc_defconfig | 173 ++++++++++++++++++++++++++=
++++++

Please avoid this defconfig duplication by using the same technique as
in configs/imx91_11x11_frdm_inline_ecc_defconfig
