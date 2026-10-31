Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770E1606A329
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=03D+p192;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Q4+sZpQp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E78840B09;
	Sat, 31 Oct 2026 09:44:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W-QcO8E3NASl; Sat, 31 Oct 2026 09:44:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6C0AB40B03
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439854;
	b=Nd2UdoZwFmLQGkLMtoD48x6ALYhajKuf3UuCd4HE8jwkhfpgw9Ra18ok0iV3628VhUhN
	 Ejdt5zTmqcext787L0Dp1g9cub9hbwNfeQE6pbY5AUaz2TIrX+G4Wzpr/glRGrSzoSDQ4
	 HugGvin/hLF891G5x3++nkxv7l6TEvDQgMSL64j1kPQbXEjznEWLJLomDcnDFrduo/6Iw
	 doP965oRGCPBBNIcK1dpVgO2qMaWTX0WD/GQTUEX9kcNi+hxyg57TqntrRQwz+O96QWGx
	 FOdUBJGvoGrhIflxN7Svc3/Sqbxy3xbYIdm/DXVfF51TrB208nCOwQLIiJJhBfRMeaQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439854;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vTwdIZIntRNuQBguxvUN3L6hZPJusa/iDg1nrMsiIuU=;
	b=bxlG475Xj8iGKmFU9NjCrPjF+JZ5cW4qPcR6p498ENOoFwbTzRP0NmzXL1y31Ep5fZWg
	 TT9aZFWhiN8fjGgPWx4rumJWp9lPQL9K3lpnj+gsxNEuXvtpIdqNElTXDzL13JAxB1FUX
	 jXMHx6n8EH1gxQI2nnIbTCSh3lBa6TOvO08YfG8ZfJ1ShV6vAfYOKc63itePgOGOmAc7F
	 bdnmhG0rWgh5RWkKhW0w0f8GcBETdktJLwJ3STx8v38VdHSs5+NH/sGbV9pE1tPZKJ7Lh
	 i4jGDXMOfO0mRbKVjMuAtZqpOr983W9ULE9jtFEFF6JfpWwbd+tL0K7gfC0f7OXae+g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439854;
	bh=vTwdIZIntRNuQBguxvUN3L6hZPJusa/iDg1nrMsiIuU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=03D+p1929MWthC9k6mT6K5uj872oKjkVRMPTTlh1TFUMpxi42oLho05oVl/vR9S9D
	 feiO6JmrO3MNTJ/PbfaUqMBXMhiiNtoUd1KJkdQMrZ7PQGNHhPKQ+9JW4TSfKzirSu
	 h3bvDSmUWzX4kvOVKo4T5myB6nw7+Wa7wAeTCRnYQOQ3fWbTUSutiaUII4yjS6xjaX
	 kXReUevxHSxx8IZzuMTEkZ1oFllYLy3m8M6H1CrndXwmK+3vAUZmkQjkDEOVQafaN4
	 fa9P1OQl/7MtmEUVJaIt+i4o1T9efdwHYMKZWG3wL74JJGm6ynpgcALJfJ72mH/XPY
	 yF5YTXwoPFHCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C0AB40B03;
	Sat, 31 Oct 2026 09:44:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 82C3832A
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:44:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70B7E606A9
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:44:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pQW9AxzALP3U for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:44:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 792AE607A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439850;
 b=TSMvsNapofB5kF4Nk09YODhxuEO92HGaxoGzGh0EpSwnanPup6g+T82zw8YHtyXWX9q3
 tryZEOZNRk4GEThYgAQXqAyFPqjZ5SrtqB/jEMO1oVTctLGSFjbIpxzouI+kcpECuJFTK
 /BWVPIqxzOnT6kLRZCSNuKo5E/GGQ0QQttswFZLnJh+SmZwCh92mz+gK4rwh+BJuPX1U4
 TYQLCbFLoI8f+/9lw2phByThesZ5LoR6NG+OGHYSkFPf6Au/npMn6l/N5k1xwxq6DUAe3
 Vk8xwi8sgOseC1ZNa4rK50JZk9uPkNJDCs/NupG89bz5hUc2BvAYnZUKvnUq2zg99vw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439850;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=vTwdIZIntRNuQBguxvUN3L6hZPJusa/iDg1nrMsiIuU=;
 b=qf7rPxMcIdSGBCZLGrocufQu96ltqWakQy1KmNMlLzJDIADY+1Zu65bRTWvQOiG5Sf37
 I2kQxGShUHOs5hzcOSF45GW1028C4YQfUBKEzDtdc/J4e+WwClRKAtMw5bu10MDxIGY4L
 u5Pm3DjkhNCykivcY69YY+pbgJUTf0F4JEMaiGsvlQo4M9Yq7zVl+VEtsIzZhddt56ykc
 h5dBVna7AaokYGpcmuc/dAXlRFiCSC9T7TjzsxYHq8BK/fTHsdTq1WIgAPpyNh+pwQtvL
 gUEL7TmzmyXG9VWMHx4XmDbcnxfTLEnXyxCDS3U3gSC4lU8afunxBtFKB69Rc7GJ6dQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Q4+sZpQp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Q4+sZpQp
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 792AE607A0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:44:09 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b203527bceso1915392a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439848; cv=none;
 d=google.com; s=arc-20260327;
 b=bnSsHcLo/1SSAXcR3AClqyvkeJSUM7z3eBt2h80fAOCiZ/NF9joCst7o14YQPiyMkU
 8PbUUrGKocoF0WnZ1QMhxbGw5wskAS0eXQVmYan5IuIF4w1MGvcobhpl6rKwTlr6IQJm
 LEmGlyjOUj1P4ri+sxsZEnKx0wLmg6Nmz6Bjbyc4t7iZT7urstTpb+ltjH56ySI8QqsH
 Lhj6XKMle9dE8/2ewuSuK2VebgYtQ3hr5KsKh0BWFKpfSK5Emnuv1CXBbC2VDZXJgAXj
 p1NXrBQMNR9G+jJH8N1tjrXPtPsy64KWImM3ojMs2+gsZCVggzbA2ShRPjPqs0JJxdrx
 I/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=vTwdIZIntRNuQBguxvUN3L6hZPJusa/iDg1nrMsiIuU=;
 fh=vAmY7hRBdMrkxhak4XNxRo2S+aXYqAOi9P6V2g3HEEg=;
 b=QvbRr/+0+uN7SibZPAWASa833+eR8y3ImlLXmrYQjsikUA6Yib3er/SfmvI/xqn9pF
 Ex8MQOiP68TBSDItmTcoMz8fM0yFyGbJ///3CHAjKw4zzaoT1llSgq/ojsBSRc2HoiEz
 YfuVeMU6D6p00DwfZIMNOZKYnd488GKJ+UwCD0fy5/GYJBNwrTOerhMWiwAZPBio6hIe
 TZnuWU1/0w7GaLNCyz6SCKkRTiNtjjLb1TtV0fRL3AKHPY+PcmAZG4HomvkxKCGEFAsJ
 p90xGjwvRyKXzz5uyUeOzly/PZyRab220/C/+btLdaEBnrydVAq+yZ6yQpxnanlHk7BE
 i/MA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439848; x=1794044648;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vTwdIZIntRNuQBguxvUN3L6hZPJusa/iDg1nrMsiIuU=;
 b=Q4+sZpQpdGig16/dqJnXG2pST7ePKYuBn207vvpPL4yO3lbc2u/xleSZzPtoFjvxLV
 zgwIeMFKF51eYcMo1QbImi6Xqyc2g37FobXj/AtHOLPd1mrFTjICFnslHYVYCkhEDYUv
 r9TwWz3185fVZ9r2l5+gmli1qnG45W8QpWEqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439848; x=1794044648;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vTwdIZIntRNuQBguxvUN3L6hZPJusa/iDg1nrMsiIuU=;
 b=0TF8cb9D6ywacy4KyahbW+nh4wFQmU7iWHo1OCuitmG1v0T+4rhhgja/LMkDVxDzdI
 UNmFuQiHINPLzBQ19pHduXVBmk7aTHZiAecZGbet5CYHajTw8y7gUIlH2EGUBQUirXJ5
 OcVe3I+hX9DBeDGYm081fVmdkRDx2u70BYnJsbVmWEldaLXlaU6tElV4VBGE/Boupyr7
 +Qj2x8NId3LCFCrDYJq8Rz7oN57l06X0kMrZBvwowQxx7fOuK6b+TxdBPf+DhnNX5I4g
 HIN1umJGfZmK0sxnokRS50Q3VeZ3TF85hgPjFtMFSVEPx74zaZ1c4rSFNRJEDkCyjNPo
 Wgrg==
X-Gm-Message-State: AFq9FYL0SvpN9TWJs4c6Efz5kCQ8/LtsTeLwcRwbuC8mAE1doDykEEGl
 SyJe/6xj/iVTmjinZRERqa3sWvo4dCHN6RNqm2lzTVhyoqkJH+XwlT3xx7eRlkaCNSCSE1eNi8W
 IgW02Eq89oHhf5fkgwCI02P1WlKDdzaOtnYnOFZfs
X-Gm-Gg: AYBFou233k/uolCwFlFRSVnXAHLEe6l6niTHP8IhLAUjwM6I9UUxIJqKc3dH9gs5WNr
 YY0sc0LPhFvC2ZWqIKeaZCCW6d0bIx5RBTPe6rCsV9fa4+OOsC0PIaBL0wDxjf14RIfor1POM7Y
 MQIUJYtRTprr5vTAyEMShXf5HCaMb0CiPxXN0vpGmcaB0LSUogEOS9ElxsZT0Nu0MBupW6HX2KY
 gOMo7uCaTSwYjHwFPkMggsyfmSQugwAKcieITA5F5uCrGdZc8nj2uLXQQ72e9Dh96XxAY/AsUAr
 WguYVOjzVkYiORpm3ca1t2RwVUrlV9TqoXUBAMcygVe4dSvIeSG2VB91l5IxdoAANTe+gljBPki
 qE1YGWeBlwN1Fc0IEhRnD550IVeenP1qDx9vD2/Sxl/htso68VjOaqZOE0ZbFDTBj962mvzs=
X-Received: by 2002:aa7:d447:0:b0:6b1:82e4:b2c7 with SMTP id
 4fb4d7f45d1cf-6b4d4d7fb3bmr2546638a12.27.1793439848097; Sat, 31 Oct 2026
 02:44:08 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:44:05 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 00:59:31 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260902-riscv-full-fit-support-v2-4-493e904a129e@maquefel.me>
References: <20260902-riscv-full-fit-support-v2-0-493e904a129e@maquefel.me>
 <20260902-riscv-full-fit-support-v2-4-493e904a129e@maquefel.me>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:44:05 -0700
X-Gm-Features: AclHuK-N5h58WBH2hLZdm-OQqg3AmarMXN8uFjhhHfn2jhp11aXKNI3zGZ_9-7o
Message-ID: <CAFLszThO+bpdOhnvmv1GsTLZEMaWSXbxBsEjqDNKKiyKajqfHw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] test: spl: Zero spl_image_info
To: nikita.shubin@maquefel.me
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Nikita,

On 2026-09-02T06:31:15, Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> test: spl: Zero spl_image_info
>
> Make sure spl_image_info is inited before passing it.

Please can you give the reason in the commit message? The next patch
makes spl_load_fit_image() check spl_image->fdt_addr, so if these
tests leave the struct uninitialised it may write loadables to a
random stack address. The normal SPL path in board_init_r() already
does a memset(), so the tests should do the same. Also, please use
'initialised' rather than 'inited'.

>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>
>  test/image/spl_load_os.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Regards,
Simon
