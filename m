Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6762CCA9EDE
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 03:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33E7E405DD;
	Tue, 13 Oct 2026 03:32:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rAB8CanlhLmV; Tue, 13 Oct 2026 03:32:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 674E5405CE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862338;
	b=IHd0x4+d0KACnIc+LcV508LL48DOboSXEAV5nYUYV3XiL/PD3tIfUiwdeDl5hgSDn6lf
	 Tpkj4R4SQPsEwMH79lgZCqrgcq2wfl1KJDQp16OBxmvkagmxjRizgnOBCoDx2Rh4PNduL
	 OhB+fLDKwQcu0fti6QOWKAJdUTMNiHW6AdqHL44k/fsaPuyUK5SdTKx61lBav66UAn+65
	 9clM3mPR5VJvl1vFw4gxrsC65rS/3ss05mz3rNY3puwCj0Jl/b67itZoEcMf+7WGAJsCC
	 cX6E514DfSXxOjHc3KOpNaHzYadCYGZ+Sy9S3GSy0zMpMohL+EFQrdSaoWbDBMWRPGw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791862338;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=2KQDHCfiTa5yOkgSKwvOiFHnzolwRmM2y44yFsjU8To=;
	b=ZgnYSTaI6LpN+jctcDV3pM2f87Uaq3MU/Q8P92MsuQKcLfQKfOFuPTv18vvihMG6kplW
	 Tit5xbzmyb6v4M2Vp+1/s3we5WA++NVN8pPA+uTbDOhb6cQF7P4QNa170aBI6MqfT0U6G
	 piDkqO2WZRyGWsoZk0aUUpae5eBcgQrbQwyNz0BNPhirt3YphGuo5FkD63mWyFGwX9jGr
	 FOysGLAog7EZusHSukjaidpy8erP6T/raK/cka41rk1MfIh86Dwb9JLkwXnnd/1hIG8ko
	 NgxZuXVDHiuKCdfQM1OhDlrths2kt93v0A/SWxXkEANPEFpnRCxSxeY7bbawVXXbg8A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791862338;
	bh=2KQDHCfiTa5yOkgSKwvOiFHnzolwRmM2y44yFsjU8To=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J+I7fRKVv+QyYZB2tnPtkEF47YR6CRu6jtOClpjwbStLMsZyUEv1D4DZnn9z4ptJY
	 msIz8rpwCtzIjFZaXG3BIQfq0ZntpFFW9K4aX+YHNcyMn3JrDLaNHLZtyE4cL+eiMe
	 lQOYLugw9vKUEooUnE3yRvtNpUoSW7FXm9chMp39uiPps6C5gqd5XTttIyKaG3LpFo
	 XkuCPBO17N7XPAsEvQMj+UcP+1bkQcUu6RXc1pehl0T3H2nUF+TfbXavA9YU+jcRwL
	 Y/cfNmEl49HUUGK6vtcaZlspMl7nmQ7eIoW5iRyASfy1UszHTjLPXIfDrE0GGG2jfa
	 VTNGIiXAduxYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 674E5405CE;
	Tue, 13 Oct 2026 03:32:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FFB11E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:32:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 519A3807D5
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:32:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YMsZsFF6bkrV for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 03:32:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 64993806E7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862336;
 b=Dd4mMKNRsVSUAnL/Q/0ssIH1ZRtGU/YRXXak1d7miS4eDha0q5kzQQPf6lVUVosCC9fY
 ktbrpwV5VIelKxYK1Qghmb9HBLiiUvuC1AbG/e4gzPnPot+rGHuTIHCAtIn/PszzaZQxC
 3W8nWpjwCXB+hg0TVJ/K1FYJ7me8qBlUCy9PksZyM8SECagtQ/yD6BcaeDPRMy7OyZnkC
 In5y24vPyljRc2BadqbyyyrKTvir2CxHwh2mfX3/q5wRoH1VkJJ3BFOKihnSFm/N2JjVE
 JeuCf92Thn1FMyxKf0I3+D9AGVgWaIkrHOS+pgXjKFlPKgfVwtk0bl3r6+GwkPfJteA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791862336;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=2KQDHCfiTa5yOkgSKwvOiFHnzolwRmM2y44yFsjU8To=;
 b=p1QDjMR3CBW0OXE1LBQLPAEvxUP7sWTzNd/awDxFdmQ7tkVyNkineJ2zTGgLA8FG0sja
 CZuNmfwTGI5wSgQJN3EpM/PkA5CL7c6+U3NZTu5UNfwd9Csp0Zcv4WC5u4TBc1cyl7eS5
 zkdUF9izr3qeYJznMqqRxH+zMRurrU/Xvt8ryJUc1n6VW0QP+ThChihGjo7026ES6RNZl
 ooqKU6PhDK1BV6d5jsCHHrhzaDNIMSBWvCMm71NW3iymoFBUA1XJabdDrHawQ4ckJp9W8
 F68OJWUF1BxgycFoPI3urmyeMtqd1e8Z5x5b+4CIKxTQlVvGGsv5oQ1rrQqvDt0Mkhg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dZUr6APa; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=dZUr6APa
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 64993806E7
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:32:15 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so3251862a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862334; cv=none;
 d=google.com; s=arc-20260327;
 b=QFEhJ5fNx7DSZ/4kcXFxWD8NqKwzZ6IcnSrXr4y0iwlcR9qlz7yvW0IOZFNYJ2jUiB
 qSYaNlXKXYofrkcDHSEbnui0Mss1dE4ySgZIc/cB1tBb39W4+ALYmo/3C4yLUmpeGhAz
 1/ql/zUk4g0JaRNJOtxlLkvlg6w07DbeEDj2AuW5WZJZbxfkDpdmTLrA8JbhYqIBMUZ0
 zOnkK3WBGNfaJRpcToSqUU6bF7+8kvLNMNbiNqOQ8rSRpjflTeTYOHwDc7U+6kG9F2WX
 alMH4gWfHi9XIViNY60zpCQEsViRxiaWCid+tkBalnS/paYMx4A6gL4xEDfB5ZohjYee
 Jyig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2KQDHCfiTa5yOkgSKwvOiFHnzolwRmM2y44yFsjU8To=;
 fh=Myc2FLtbZjl/s7mQOep2V9nRRoN7WFcuTTB23nDoeDY=;
 b=g+Mb3cpWD1Aqq1ymODOw2eAESB3AWeUo/rwrG4bXPBvGiivtC4d/NUMg46OfkxUY8c
 t7yjTQySa7tRgSzLr/Uy0l118PJ9b8EV7buBRi9u5XM2WesLWMekFGyy2CUSgN2X7EHp
 Krywa3XkvB1kbJBZcIDb1QjYDSRx4iLW1Lt5ykfVkJBqClj1nFrq0oZyAwcfpy8lBU4/
 L5Vz3qaPiri5/JPupFYgKdpICAk+U/gb73CpKSObznBiIsfhVnLp3tJVI6lbTmaIyimd
 VtXQx96U7e+LbptGpkGpPxXpGZkKyUf2RqJwkMDVnxdw0p0lqmASs5+qAGoNCd/tVz1E
 MPGw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791862334; x=1792467134;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2KQDHCfiTa5yOkgSKwvOiFHnzolwRmM2y44yFsjU8To=;
 b=dZUr6APa1Pv35DQnpFc4NPGhQt2kTUctiaVBLB/gdZO5t7pb6j9brlK8X0lP9TXjda
 jQ9R7HZMtPdhPyjDmUXDuj9AGvwen8gVUecxOvmdE/kCinzcWxHArHjp4RxybJ5dQdXm
 6VExnY2eFoBh98Vbono1POqKbPUrI1QWtZjYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791862334; x=1792467134;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2KQDHCfiTa5yOkgSKwvOiFHnzolwRmM2y44yFsjU8To=;
 b=hXyITJ3je1jV7+x/hD2ERnl6XX1QgwfxeqSyfd7fvUbTbqe68l+RMDhQsygAxKfyCJ
 AheJ8GXZ5G1p/jnK73XdGm+2ZD8F+jdwWp5DO05HHDjAazDUyl9gs9soOV/n3ZHDYawi
 KmQLWl5Tw7w/H2FK0rF3Bcm+EVkuzv6iSjfiLIxvq+mahW4lTiT5r7lVkKb1yqnY2Zmw
 MfZv+feDBOthiPK871eMAFIAcbJZGhJhAbOlPXw10GBuoFZbP6Wudrz/StSVPH4J79mx
 MEIID4DheM0NlV3nzZLQT9xWAemMyEx/r+uNRgXNrc4Ap5bs+6qcSweEuwzsCCPP24zP
 m7aw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5HSyJb9hBlTi288twX02MMqKTnqaZZU/cnvBELV/ShaqT2NGJDG8/rD8iLUrLoPPwZcZDvrc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIMWYIUu9z5TyjuCdG/fXt42iT0q2K4h5DhZWPyRLKZo7ZB2MXV
 ixetk3F6QloEeSawZ06Hgcx13oNzvjk9jBVPW7+6P2BHjzuZc3nD4ofHHzAMFeFPILXTIpu5YBF
 GEgEnjK1TE+7xyEMLAvd47aba+Yp2D17En7BIsO3u
X-Gm-Gg: AYBFou3q+Y+zMHCV6yA3y2sJW01afsvAIMIFDNlxqx0r/jA/NHdLMCotTCh2dmTszSJ
 XTheHUP4ebBWYvkSmK8lVWAN9MqORz8pRLDnr7b6OE22y2cvkBUClvU+Xm0/9ks5O5rFTHXYzht
 T2X5e3oacvjibw3qc6DcX1y0V8fPUZOzAwVtf/Sv7zVcO086bx4/t1OOt7RMUUYaC2u/BgNMAx7
 uwzwox7kgg9zFox94h1l0/ojLrZ7tjyN1ZP+IiuMTRk/5AC2yaSXmpK7blsP9gaWZ+AsJyD9wLQ
 zjtPDrpyjw66vgPNcMJDg0JN8vhVEOoo3y72P+6QCCPI8BJLVC9/TnOf
X-Received: by 2002:a05:6402:f0c:b0:6b1:b176:73a9 with SMTP id
 4fb4d7f45d1cf-6b1b1767781mr2921849a12.27.1791862334113; Mon, 12 Oct 2026
 20:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
 <20261012140048.214059-8-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261012140048.214059-8-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Oct 2026 04:31:24 +0100
X-Gm-Features: AclHuK93UsWnw4l4HsOSneU_57XzcJX_zrn3nf-lZKVCFlaWuIPVVyBuQKXXI5c
Message-ID: <CAFLszTij68+3FG0yp905MeNAio-MZYGdRt0aYzrP43vwX1BYSQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] test: fs: allow optional date field in ls output
 assertion
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
> test: fs: allow optional date field in ls output assertion
>
> fs_ls_generic() now prints a date between the file size and filename
> when the filesystem sets FS_CAP_DATE (currently FAT and ext4).  The
> two regex patterns in test_fs1 used ' *' (zero or more spaces) to
> match whitespace between the size and filename; this no longer matches
> when a date is present.
>
> Change ' *' to ' .*' so the pattern matches both the old format
> (size + spaces + name) and the new format (size + spaces + date + name).
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> test/py/tests/test_fs/test_basic.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/test/py/tests/test_fs/test_basic.py b/test/py/tests/test_fs/test_basic.py
> @@ -26,8 +26,8 @@ class TestFsBasic(object):
> -            assert(re.search('2621440000 *%s' % BIG_FILE, ''.join(output)))
> -            assert(re.search('1048576 *%s' % SMALL_FILE, ''.join(output)))
> +            assert(re.search('2621440000 .*%s' % BIG_FILE, ''.join(output)))
> +            assert(re.search('1048576 .*%s' % SMALL_FILE, ''.join(output)))

The subject says 'optional date field', but ' .*' accepts anything
between the size and the name. A broken date would still pass, e.g. an
off-by-one month or a year-1900 bug, both easy to hit with struct
rtc_time. Since you are touching this line, the test could also check
the date's format, e.g. (as a raw string):

    '2621440000 +(\d{4}-\d\d-\d\d \d\d:\d\d +)?%s'

This keeps both formats working. What do you think?

Regards,
Simon
