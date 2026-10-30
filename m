Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B828606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uPnpT+HY;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CBJOdtvH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FB6D81BB2;
	Fri, 30 Oct 2026 15:59:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YPhZaX9ouzj5; Fri, 30 Oct 2026 15:59:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 873D981B9D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793375979;
	b=c7GOthmgJIrkoTLKNzq7wuwiVjvYxMuujQjPElzne/zBPnOG9u/toEPTBR71acyW69fD
	 wXIK7FHfVIZ3SXYYz0KJm1PgQJZQZJZN4KtI+ydWeUAekDslDaPdk1bwDo5nsxGze6VCd
	 am8XExAZKMPEAj1bAUHISgAhquxj0TUgZ1OdDs8FsTwP7CtOpqbT9l5yHWgv4rOZgwIWV
	 riZ3K6TfgXUHHmldoPUHM0sL+yJ2j3FHdvu9zHvnKyjZw6HY7e02QF6TKl0cCe8rP5vzx
	 No6HzUU+OSCCBF7ov4zufiFs1bq0IBi+aA4apFNmp4O1q6VPGIQEeDdX7BHq4SyDy+w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793375979;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=L8ux5KWzXYmWGCyVK4rojODn+wKhZvGYe2n7C+XxJN4=;
	b=mzgJ1DAdXbiRav1TulMdafVzIvQQcxwx0Nb7if/znZk1yb/Fo3TQdCUVx2AUFtES2+qq
	 egWCaH8GfXaBqw1h1mupYxITrQ7fW34JrcZlGkK13WXBIb1/6DVZBu5W+DVNZkZIgJOEV
	 ISP7eNbCsRJdet/vWYpUG42vsMkvZZnborazLcNvcykadJb8WSxJV3c1Mm+27nwKz8tpt
	 MOZYtuSk4JAflgCS2hBDWQsI3eryM2ghjX7dum75jQWe5tsYvATjssdORR+zjVw1//GWW
	 jLMSu70y+HcbAl+rUlrI03luo9qDeurjuYJ328H9cxElcV3WD6J9oGflAwuKCEXj1ng==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793375979;
	bh=L8ux5KWzXYmWGCyVK4rojODn+wKhZvGYe2n7C+XxJN4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uPnpT+HYHhowZ30ZBM5Esw+bEpGh/3B5s4TXhlFfjlxwBhWcuUVaBxZ/ZOw3xe542
	 fo7ZoOol80aDK6DIEVgvI5nZOKrG6KuqSvjmhhQSOpvOhAPhvXgJaf1kLYGJCqWROj
	 VNmyiPDnXH7vCWEeR2+t0I1uJmiW1yebxBbrGck0Y6A5/tBb2OCpC+91dh8bRuawpQ
	 ibAmFs5ECED80g2fPFFX3bhrQjo9WTK7tHvjQtkeX0CnvF80OEJg+2zAnErYDuAzAU
	 egU7ZoFqYT77Hy6LhYrKPbG1LP1YXSa/FsqnQz3tUaFVvYC2e6StpNl1ScO07mTyko
	 VOM8hMpzTwYhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 873D981B9D;
	Fri, 30 Oct 2026 15:59:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 02977529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 15:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5091160AE2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 15:59:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k8ifgWZZ3WzZ for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 15:59:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 70B2360ADF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793375952;
 b=I0iGDLMIkq50RVj3debt+CaSJh4+atj5gs8kIsIzKKyXctoniE6jq1s5S6npqckT+wFV
 kGHicdUzcTSt/92jOOOizku1p2+RPF6oPFQ+0Bj99/GZB/5dPyCCkJ7OfKClg9Sl/YeFr
 Bumfbv0S8+FU2z2mql0ASrimshRf3Dy0H9Sg9To1Emf0l6jQsssj4DJLJsa7i2jn3PmsB
 LkSD+ti7N3nJgZ6459GTVOGIEfgde9Lkeb1CZadcfs7gMtdzk2hoFr8e1LSfyuobwUMtX
 bPCWP7U9WjZKuDeNJaO4ooZMu2t0xkl1RmU1TD0GvbKP7igz8eKd7piLNdCWw/Gzq6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793375952;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=L8ux5KWzXYmWGCyVK4rojODn+wKhZvGYe2n7C+XxJN4=;
 b=aERfHfzu/W6e2p6jhwIoi1L39v/Jp11ewkSf+2cYqCqOBdJ2hxHEVcie8yB7Pb16qacl
 lILzpQZHQtMeH8pc+qXC/u0f2Yk9PBJiqgu6l1J91MGQAb1kPMNKyG2DlH5X9Ck/7U56+
 SJJniaTQV13Oi3k6BGNbnvJlJf77NlDOxfCztHHBuoLmOzZknj/aG62iAZd0fy3dUvom0
 tDp68s4da+kf5Il8WEG8W49bZ/DgTPz9SSI9F69m0uES5m/DvkDFF5nueQAZQz5+qwWsn
 md28B2xmodXyFXZzaN6oVlRniaaOMnSTIhMo1D88D02QaKVCc62/opVt5c2L5Bmzk4Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=CBJOdtvH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com;
 envelope-from=maxin.john@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=CBJOdtvH
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com
 [IPv6:2607:f8b0:4864:20::1329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 70B2360ADF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 15:59:11 +0000 (UTC)
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-369f3e9e431so754489eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793375951; cv=none;
 d=google.com; s=arc-20260327;
 b=D3e+mNKnAbFi2M4f430/F1eGdMQ4AUfRBiOUgij4gLAHzhBEpyZuDJrN9MB7EABuM6
 AkzWtlMESUE7WGiMdChmql+3vKxxVmB+ecA1i1msFEH28/rTo6D0VJffMKcKOz49fKKU
 b09nxsM1MbcPLDeDN42U13XVD0iXwcssBUFP2jYWHX2XEpFjrrylBZXiANJ8Sc9+hsfY
 fFeluz+PzGACjdpy5ASklStkbAEwJm2Wfngm4zabivhjPi5M0SSV83ewHCITtrfV3kKW
 eD2c0D1KAV4dk2oQnJgaiRDKXjsvf/lodH+Y0EZKEeEGebztaYsbUyfR5+9lQj2Ub1OI
 4Mwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L8ux5KWzXYmWGCyVK4rojODn+wKhZvGYe2n7C+XxJN4=;
 fh=tsdScSh9aVXXWv70Dx2ARH6nH4njLXVwau7eIOzZceY=;
 b=gEhLI1zG/rXQ3HOs6OTVRx3dK53oJlsUfy0HSKOWKsHnhOcUv0ZXDEyXO4NFG4b49/
 N0zbHXY0hSQBYx7KwuinQzJy1obdrDzBM0nPoVa0gFolZH2xhOh0dQ+51b5J/CXMDehz
 ov0/ACjcxpRiMpB6Hgkvtc7E0VDZu+f3DjUod3rSq6hgX32cGlJKsYaJP9rJ8Z/Q6DcP
 97U26bUdObNGWTepazpHr7ipyUA+pBV1OFjj2Gy49TE8HbvBPLDcBydVZMyLE9SpL1Ku
 jgw/90dZCr+fon6NgRrH38s6HlwgFRkq9x5PaflENjODlibG26PQHOF4h+bupYcHy88x
 N6EA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793375951; x=1793980751;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L8ux5KWzXYmWGCyVK4rojODn+wKhZvGYe2n7C+XxJN4=;
 b=CBJOdtvHGnXlOSYa07xVv+cOr/BktTrMunLdkiceNLTRbF+/WSfs7Um2RRLXRSOvgE
 paKVUe4UrzbqCEDDYCBZ12nrucYpT7WJmZP4oMKEJVK3YVIk+JLDt9Jia5ek3fGhSwhz
 2BvX9u6k1WPObhimjXu+O8D9ikJF/5w66hiB9Vo//AVGu8J7GqreFFuo5Bbk61hB8aJu
 H6KAAo5e8doeynJSm/4O4QB3e7L8pIXnoTN99vEVQ99ZpcvRU7t9KW1uOx0O99HF1LfN
 +lZQUvVo11QSMAaDXI6MO3ZY8qJzagpSh9ukW5Ev28VVdaFSQ5GZOr9gmML3RWFWCfTJ
 VXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793375951; x=1793980751;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L8ux5KWzXYmWGCyVK4rojODn+wKhZvGYe2n7C+XxJN4=;
 b=lcr02kvP5Pj/y4Is6TttaAu+xhL79yRaL3uwY97T955CWt83gSJFQsB6igI0Kq80hf
 uKyM7vZSJO9uNOBg3n/ap89zEHgysektsyj1/HOcprHBX/5U3wpLgWBkYK3cCADTDLWO
 Hay7KGB8tt3I5/MGsfny6NuGEnzwY3mwDEyZ+8kDmOGZEhI9uy68A01iuh1sgNrNSscf
 DFkHBRYx2VaLHwAZslyGGPpGyBX0OYUteyJwcX/kHjwCu9gxF6JhwzbUczi2DiGL9q1w
 y5ap5pTXBSqE8rlaiNyU5aAhdEBjaI3U1docJDVpi1j4g/VnVlA6afFp7XPn32/2qqE6
 sq7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXjXNfifWdThk41unJo+/EB0Lkg1BXhBRJ6llH0FBMFtSKu1KvS6Xa4PqTWjhfixO5Zqh2KRI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKxQDq2Dyx+QF846paefS6b0M8DQy3Vgvxh1JMQoorx9yVAPuF1
 Kte611z9OgTH8lcaU20nM/gGF0bMw4we5lALoXNTLztLZLLv65no/T0DPFMW2W+KDJ83roo8tyz
 NJO9feuBk/dATiVV5KavlT2TOj5bAmEU=
X-Gm-Gg: AYBFou2faZUn5PwmvzOKi80LV8LNcCUScY+h1M4hwbPh6pUFV3AFpPrP55/cMcYipYs
 TFE+7+w1kYIJdfmAJIUv3JmqwcHcrGitkY+MXhxnhbGEz0FtrKTonVwMLh8ryQdcv2ZmMHGexRk
 9HNU2ndGYnc3MucLCoOkn89duxsvUzn0pNiDITASEn8JpTv7bXnX5W/2BcD8rW3T1+RAy6kwT64
 ZwczKQxvdyrs0m62WWe8kTy3vc9AGZFZh9MyY8AIwB070IRWYocLR1jESzRqSSmXZADyl+iB5Fd
 zDbnb1yKRrM8KvV72NU6y0KPLaL695aGJ7Bigbm+1AN4Uf3v0G9QeA18VVDG2o7oL+m5guQNhe/
 PQ0nNDJ5i7BJBr7AhbZPmrj7TO1wBgvgW9ZTkbdpe5FKI2+5BWm+mCNMhfxykc8jcsRX2
X-Received: by 2002:a05:7301:f8d:b0:369:f1ca:5b24 with SMTP id
 5a478bee46e88-36a42389011mr3524598eec.6.1793375950838; Fri, 30 Oct 2026
 08:59:10 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029173443.1495866-1-maxin.john@gmail.com>
 <20261029173443.1495866-2-maxin.john@gmail.com>
 <980bde4c-b077-4291-9cf9-30fe59526ff9@gmx.de>
In-Reply-To: <980bde4c-b077-4291-9cf9-30fe59526ff9@gmx.de>
From: Maxin John <maxin.john@gmail.com>
Date: Fri, 30 Oct 2026 17:58:58 +0200
X-Gm-Features: AclHuK9lghKry4al0oYQrj5Omm3RdpgsVXIgL-TYK0FNn4rpYhjGt_HpV0kBUT0
Message-ID: <CAMhs6Yxa0wdzkE3py=Ns5j+D8-8_+Z-ngnuxRKcTvQ+0qDpt-Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] configs: sandbox: Enable binop command
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Tom Rini <trini@konsulko.com>, 
 Daniel Golle <daniel@makrotopia.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heinrich,

On Fri, Oct 30, 2026 at 1:26=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 10/29/26 18:34, Maxin B. John wrote:
> > Turn on CMD_BINOP for sandbox and sandbox64 so the binop tests are
> > built and run in CI on both 32-bit and 64-bit builds.
> >
> > Signed-off-by: Maxin B. John <maxin.john@gmail.com>
>
> Which tests? I could not find any depending on CONFIG_CMD_BINOP.

This change is a follow-up to my recently submitted binop clean-up patch:
https://lists.u-boot-project.org/pipermail/u-boot/2026-October/637804.html

Following the review comments on that patch, I have also submitted tests to
improve binop test coverage:
https://lists.u-boot-project.org/pipermail/u-boot/2026-October/637974.html

These tests depend on CONFIG_CMD_BINOP, which is why I enabled it in
sandbox and sandbox64.

> HTML documentation for the command does not exist.
> The online documentation leaves the user clueless:

Agreed. The documentation for binop is insufficient and could be improved.

> Usage:
> binop op count [*]src1 [*]src2 [[*]dest]
>      - compute binary operation of data at/in src1 and
>        src2 (either *memaddr, env var name or hex string)
>        and store result in/at dest, where op is one of
>        xor, or, and.
>
> What is count good for?
> What should a variable contain?
>
> Can we simply eliminate the command? It is only used by a single board.

I am not aware of any other users of this command apart from the
gazerbeam board.
Personally, I can work around its removal if that is what the
maintainers decide.

> When I see comments like these in the code I am inclined to remove the
> board completely:
>
> drivers/sysinfo/sysinfo-uclass.c:21:
>       * There is some very dodgy error handling in gazerbeam,

I will leave that decision to the maintainers.

> Best regards
>
> Heinrich

Best Regards,
Maxin

> > ---
> >   configs/sandbox64_defconfig | 1 +
> >   configs/sandbox_defconfig   | 1 +
> >   2 files changed, 2 insertions(+)
> >
> > diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
> > index f861d3ef06db..c4ad63ce63be 100644
> > --- a/configs/sandbox64_defconfig
> > +++ b/configs/sandbox64_defconfig
> > @@ -43,6 +43,7 @@ CONFIG_CMD_NVEDIT_EFI=3Dy
> >   CONFIG_CMD_NVEDIT_INFO=3Dy
> >   CONFIG_CMD_NVEDIT_LOAD=3Dy
> >   CONFIG_CMD_NVEDIT_SELECT=3Dy
> > +CONFIG_CMD_BINOP=3Dy
> >   CONFIG_LOOPW=3Dy
> >   CONFIG_CMD_MD5SUM=3Dy
> >   CONFIG_CMD_MX_CYCLIC=3Dy
> > diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> > index a3fa52460827..c63a4df8befa 100644
> > --- a/configs/sandbox_defconfig
> > +++ b/configs/sandbox_defconfig
> > @@ -74,6 +74,7 @@ CONFIG_CMD_NVEDIT_EFI=3Dy
> >   CONFIG_CMD_NVEDIT_INFO=3Dy
> >   CONFIG_CMD_NVEDIT_LOAD=3Dy
> >   CONFIG_CMD_NVEDIT_SELECT=3Dy
> > +CONFIG_CMD_BINOP=3Dy
> >   CONFIG_LOOPW=3Dy
> >   CONFIG_CMD_MD5SUM=3Dy
> >   CONFIG_CMD_MEM_SEARCH=3Dy
>
