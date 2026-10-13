Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06ACCC6B09
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 03:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB9C740664;
	Tue, 13 Oct 2026 03:37:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F50as6F9fhTR; Tue, 13 Oct 2026 03:37:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ED06640634
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862630;
	b=b/rWDJBim6bbNS50SS0AUPaIPSLSZUUFMf/niRwi6af/jdu2HEwHQwDJrVRMggiSsrqe
	 qqbaCXp+WTMce5+65vypjHwrJtTG6zPO9MgQPjj6sGNrIqwhuG2m8JtAwmrFMyBaxUyff
	 GAoHLUVmRv7FTvMxgnDKuut0HzGZvnkBzl/xnpfo4TfBBr8hWHyFk+55FQIoYHVlVcE40
	 RfnmBigTU6YO/FQwld6C40gR3CeRBHM7Jh4q2GdNyw/rGZxCaR6gJr+vB30GB3TJpMBjT
	 zpw6DivMSHd7OErNZbTRU8uUoUvBstjuRssPtLWoU+ZXwQ4pC2pG3D1SEJPqPjReQKA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791862630;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=X3GG+uYhO4nEzSGQNAQJBdjtvebhRgodGTCjdtZrloI=;
	b=mePWIgJOcvkPTIGXQrdw0AHEYrXd9zuN0vGzJUe7dnPXaIKwrekv9345c2IhIsGNPqvt
	 mDkOllMirb+tKb0yzjZzfKmW+MiF718bQ8iRmb//oLL2rA8hlVivgWhbPqIufpgZxHgAT
	 TmICx/lR6e+yL/hI3dWijGddAT6xyYZ7LrJ0kyvSzOtXKKkO9jfeDzx0eD4xgHv7EGhAm
	 qAiredQRIha3dyaxuFua6fRJtznR9uS2LEKBKaryQkUQw/nDd9sPIMePqxS482R3dE5Ua
	 eGlJ5vh5FJL3VybEG88hfnwcStpAWjofb84aZLhN6ftpdf51/4nTo0ZiFi1k9YDyjrA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BbeDR1F8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791862630;
	bh=X3GG+uYhO4nEzSGQNAQJBdjtvebhRgodGTCjdtZrloI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t1ASQxYrakD8zyCduB557jjMC9lVXEX+ZabQY92VaUhcV/dSyqNRLGhdkLYzTV442
	 Ag9y2uqapm56LqMCHsi4n/BvvcklWzIocfM9NmDs4FJg4xt4gQKHL2ZcDhE6Y8Nra8
	 dl96YO8BgopnBwONPMkw7Rl8S6pxb/O3Xv5Z+XmEVJPmc/Q69xDeyOfGt8u80JSrrz
	 oafRPQMyiQxn8f1aXrR1ED5Fdo9WvtoHlPK3Rkz6V3Zi5+o24mdsMc6ABiGUrYajIi
	 xSdXsoBHRYVyB/38/QozsFUYdI5jafIN8p8GIllbGVO0L3gMCFvyA70Gg9ra5iPSYW
	 2WxoTK4jreO8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED06640634;
	Tue, 13 Oct 2026 03:37:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D51C2A8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8EE5B405E6
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:37:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RfEGYa4Ff2yc for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 03:37:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9959840634
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862628;
 b=bDkn/gtqRrcGdCIPeyazQmg8JoPOdNcDAFaHT+N2Oa7PuIuXgTulInnc7cPfd3EVXRI2
 K9wCLadO8BhOifsSyrB0VLfdG4JoY/3eDmtrZojvdC1EAX1R8ihYNPV61JB123t8Hv7vs
 J7cKXg5gYTVC9SQnqvLCRvvjqTzonuobNaEKAuFGJuQjj9S1zclJ48mBCuf/QWurU+iBc
 fZ7JUeieS8kPoSoNExlOlLLh6BuxCsFzskEQOmqkAuEAOjl8J2aHuXodPDWYQON5l+5YX
 g1w70NaQ+xoV2Ls2dLkFfd3NJTEoOkiFdL4dm7lj2kvKII4l2F5UazlJJJequ+ovlfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791862628;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=X3GG+uYhO4nEzSGQNAQJBdjtvebhRgodGTCjdtZrloI=;
 b=G+QoTS4Mjk6JiqQhfaQZAAdRj9l9gmdJSxuR2ixMo0ou7OW8h7PlDDuFNNakVmf8neKd
 zjadOjhicYkFIeSohR93iFLcr305/B+Ky+U15PfJ2kkD75rgpE9kX8ZJbyb33znZzS225
 PLCIdOK2muSDaiRPDVyOyJ1SlbjeKAKMEuOaGgWLDuRv+zWC34R+D5mryZdul9ktDn/En
 9/ucpuZn9TddnfYnkvep3jaaYMW2cL9S6vALFajZISBcQCWokj7Nb3Y5pnds5e3RWMHLK
 nvyYHPX9RMD9SM/9tWE00cSzIB6w1II7jln+sVOlLWbi+QkuqgalUlWtx1r4tmG6ngQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BbeDR1F8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=BbeDR1F8
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9959840634
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:37:07 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab2ad719so2595309a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:37:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862625; cv=none;
 d=google.com; s=arc-20260327;
 b=DYIxHTjWDeo+BwTWUyC5ls+32wR66VUqCkmsIDqcp76eWH16Ljgrz9QSzlS21EXtlv
 P5bfZZJSGCpa0EDIam0S12bYxWMHzm/C9czq6TSnpWwWSoKq/R3BKx0XoSvG3NIOyAO+
 twcBWCFVdzz9ukvHlyppsFukEkn0fdXRQrTmAl60Z2rCKkeelJic8+jBJFWft3NsSJ4/
 WZUSXZlWOh6jgMaF9hIGiU48AwgxKNLEnLNsB+wGsUP8QqQqr3vilNSzBwSEDr0oVNei
 hB5AC+MklRl399RvwaoZU2iVSQSHrMpvAddXUADxdH1Z3hmqCRmnYwet4OGQLPzIXt6Y
 YlTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=X3GG+uYhO4nEzSGQNAQJBdjtvebhRgodGTCjdtZrloI=;
 fh=hlVWpZ0SLMiUmq3vONc+k3LcBPJnR0ZOCy+C7xHsHP8=;
 b=G3AjJkD4v+GE7SSAMRdPn6ZZuylkK4YKMEaVceJ7/91IWNjAgwcurUbqW1Ouz5nb53
 OaoUyBjgbvTt839/nfve3LbPJ/X/PcbeJQycs75bBTFhlAQneAB21Z9h1usIiE1CR4sn
 iLYJUclNDXO92tm9S5yrlY/3RLm18qhM/cY93zEyA2A0zbKBJpCBY1S3OBzpJuUO5l6O
 aepGfuzOCqnxpPfQheG4VDV92WFQq+2EpnlZdw0pkABazxrJENci8xXVU3DCGrYvBI1N
 4YoG71CGvorDtvfbnOGtRsAQrm2YOFtF/ym3MZ9jBufZMLGskLSxSPA9xorMS0967Jcg
 WP1A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791862625; x=1792467425;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=X3GG+uYhO4nEzSGQNAQJBdjtvebhRgodGTCjdtZrloI=;
 b=BbeDR1F8CQZN3ohZtqvtwdc7ANNu8hei1i+QRwWq0G5L2v/FxNedQd+2CTB6LaMucm
 EaekoPD5iL37mdgp5OgnwpWOleNQDKdy5D/wqHlrSMef3UfQP2rkFkekOz3qvMiGQhJ8
 kETqjMdiWL1bEmmGRa75f8HcseEkXkHJOcVMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791862625; x=1792467425;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=X3GG+uYhO4nEzSGQNAQJBdjtvebhRgodGTCjdtZrloI=;
 b=0XLxZDoDQyz7ANME5l6GQfLh1ogNJJzhAA7T5AX83duKS6eLUxDoH2+MqPCMDn6FSj
 bq+F4N2Z7zDVnSDpZ0Yb07AAYiShWF3NDlF9OYjaDFF6sSMuG7LP9iDwES3WJXTN3vO2
 FfBk/Cf39MiRko5KWgAMEhZ+M/hWKWmD1QLDtXy4jZP1Y9RiuDkCL1df31pBDVXT1qmz
 nuMfg/pMJHbjOdSCRn7I8zkgw7OET+ceQqqPW6lRGqbsaTNMMhI8lkqI3K9gJURDZahg
 4ikqFH2B/p1ldiSffe/EIS+l6wNoFmOHxPKhm8+yTNaXl6n5ApgTL0oye89OJ6rWx2W+
 iDMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjIXaNTVfnqGu7apq33xN56INUMis67g+Kh6gB66XVrj2icNiypFPGwAHPFuG1vni5NOBLsew=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLxuqb7lHX6MIiFPx7LI6uv0kFytO3243I437qU0FKef76Izzqi
 9MM/QBJuw2w22LV99bJeUaCVhEA8COnwjdUNqEyQwDeCXPcx7mmsFsNlwfK43t4EpLY/TpYY2j/
 bn6pmgBuKSQ0r4tcQvkV7HS84Z08X6BIg8R9rFZfZ
X-Gm-Gg: AYBFou2pilSNKjw5yZUfWd49hSt8q+5a9K5lPEMbwd7R/VDcQMhxyYVRizANMF6LlUV
 27qYyVoEN8ntnYmRv5YYVgVS38YZZC0DqHLBNA/nEpyNj4QSGyqqdljMwcsnQiHDWedpDOAyh3t
 fwwaoU1n7K2qIsPuRAG0zbBcRzFhlASovkZiORP5SRFWdbxylCdboNX2SeFOIQj9DZ8sNFqROZd
 B0rMsWe+uK0yxbSGZjU2WHGn97GaJafn/ndnJtn5hQAfSq61Vx/nvgFZNCvW+VWkRsGgDwddkVY
 J2G5EnDJACML7q/jqEZa3LPaTbOte51aoBhZ2JHvvHMLaCnXgw99aWKb
X-Received: by 2002:a05:6402:c522:20b0:6b1:abe7:825c with SMTP id
 4fb4d7f45d1cf-6b1abe7834bmr3415593a12.8.1791862625230; Mon, 12 Oct 2026
 20:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
 <20261012140048.214059-10-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261012140048.214059-10-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Oct 2026 04:36:49 +0100
X-Gm-Features: AclHuK99AxcR0B1aScRxiT6aFvpeO-qx10XUUW3g28qxq8QcOHLfMbNoi2UR99Q
Message-ID: <CAFLszThhOee8bQav3hyeyCL+mhNz+bC_+Yb9pOvKSea3rrF9eQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] test: test_erofs: adjust expected ls output
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Huang Jianan <jnhuang95@gmail.com>, Daniel Munic <v-dmunic@microsoft.com>, 
 Tony Dinh <mibodhi@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Vincent Jardin <vjardin@free.fr>, joaomarcos.costa@bootlin.com, 
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org, 
 linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On 2026-10-12T14:00:39, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> test: test_erofs: adjust expected ls output
>
> With the addition of the date field the space between columns in the ls
> output has been reduced. Reflect this in the expected lines of the erofs
> test.

erofs never prints a date, so the date field is not what changes this
output. Patch 2 changes the separator after the size and '<SYM>' from
three spaces to one for every filesystem that uses fs_ls_generic(),
whether or not FS_CAP_DATE is set. Please can you reword this to say
that?

> diff --git a/test/py/tests/test_fs/test_erofs.py b/test/py/tests/test_fs/test_erofs.py
> @@ -65,8 +65,8 @@ def erofs_ls_at_root(ubman):
> -    expected_lines = ['./', '../', '4096   f4096', '7812   f7812', 'subdir/',
> -                      '<SYM>   symdir', '<SYM>   symfile', '4 file(s), 3 dir(s)']
> +    expected_lines = ['./', '../', '4096 f4096', '7812 f7812', 'subdir/',
> +                      '<SYM> symdir', '<SYM> symfile', '4 file(s), 3 dir(s)']

squashfs needs the same fix. sqfsls also uses fs_ls_generic() and
CONFIG_CMD_SQUASHFS is enabled in sandbox_defconfig. Can you check
that test_sqfs_ls() passes with this series applied?

>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> test/py/tests/test_fs/test_erofs.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Regards,
Simon
