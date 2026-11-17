Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878ED606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=byTBWSjr;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wp/lCnDO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C33160600;
	Tue, 17 Nov 2026 06:39:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lOYmv3R6vw23; Tue, 17 Nov 2026 06:39:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9F69C60828
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794897547;
	b=kydgUT+O87/rAk38ZXmsx6NVLUJO8tAsTlXYnB9FdbYOlhLoF5CN9bFcr+F5ICdxtIzr
	 nlVEoZ1TetyBdRVszWb86UwBhrNkj7f4Ci6E3UUfjzbZ1GAZ4gabt+ps1VvAI86HTk/a8
	 +msLH2Sjhm92nsabTmgKPDf422wi4IxNmIvOzfWySDO8ise5dBMN13nsR64tvLEv4a/2A
	 QBtzps/HfbSPdXLv5jaAW9WJIu/GFe/MoN/9HegGlAofOSb+CI6rytyflQD/53T5BkdOL
	 2zzN9J1AusAOehdlWik9I8qikIBT9O1wxzMRqsqT+/boMjfzIvb7sRT0UqTRI3aDtvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794897547;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=T0NjlcW6lV+a0ljfWd0qvX4UP7kAClrlcdITwN28jdc=;
	b=rM6ufjzAHj3YxbQjWsOReRnLv2aOdmmzNm0TQDXHQG4AEP5COXlhBBBhDA5QlqBiaWvu
	 sUZ4GTbjOYMKHzXLBCUANZYE1L/i0vL4ASLlPCs4ncmn3f1e/Mf0KpeEk1pPFXIL4eu9U
	 dADFf73hcYlZ+P7LE5Usiysd9rObMbl7uoRVgVHt+mrjhyhdXyBEGVGvG55eYaEAQB/7H
	 rTevU4aLiIC823A8Nz0ez1cFU/kpsxKHjgeK6NstHTDxEzyXlPtePvy7s8Q9UluEnXoRg
	 ExP+bXrXt9hmtRRNsO41mZydWis+uOwwDdZNxqF9n9Y1V80JQto6N7Sc8TjMYJ8BzQw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794897547;
	bh=T0NjlcW6lV+a0ljfWd0qvX4UP7kAClrlcdITwN28jdc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=byTBWSjrLh9SLct9fG1IG5yiOJRK5vnUfnMmPHvTDtsJEeUbnPX39NWEaESKtTXhv
	 NpjRbdSHRqtW8vx5D9u1aavm3AYhzZeuqESj/ngzPfW4OqJr+ultYLWHJlacn873Rc
	 G2H2xFHKWZEbeAr4uPGhz2QTgPTm6znwsHcbz1JqoEDcb6HVTz1GS9A8wARW7zpeBX
	 shxDXwZ+bQcn9Q5ZdOAmRHFC0I1gJF1QH9vY0/FZnpYyVVK3fsEB3kcbQmV0BkxVhB
	 5c2KhJm/DgrdnpLwQRHjEChAv3C8QABwg9L76Aal5jYMGW6Q3LsN0iDtd2hea1agV6
	 XZkvYWrgDGlRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F69C60828;
	Tue, 17 Nov 2026 06:39:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F80449B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EC85C80C55
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:39:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m8H4WFsmqSkS for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 06:39:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C60A980C0D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wp/lCnDO
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C60A980C0D
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:39:04 +0000 (UTC)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8b4cc793704so18783017b3.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794897544; x=1795502344;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=T0NjlcW6lV+a0ljfWd0qvX4UP7kAClrlcdITwN28jdc=;
 b=wp/lCnDODDWZ4sEaKLGsShdASD/mzTj8Sr2DRAfG6j3+FPyrnxhVmf7ZlBLtt441Pb
 I2BoDR7SElotEWxf5pK6P+1zoi1GUXTHQlDOlqJo0ByFmBJFvzvhyWQbIgatdCoVaixF
 cOoHJJs5xM2GFL4qKfIs4uIYpKJnmwjR17nIFqTZaAi/H1rYsmVA7goK2UA811X80CcL
 IrXaV+p0/RJ5pGf25pnWO7KocJ0pYG5CxqYABy4MzvAR8rUjL1b34uR1dfJxJpZdoRNe
 EzLaR1FCRz9BLcNs8V1KcYRj+6BNRXYNfFvy5Sb0qhtjnlUhTzS/84naTKskh95wQWqx
 FUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794897544; x=1795502344;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T0NjlcW6lV+a0ljfWd0qvX4UP7kAClrlcdITwN28jdc=;
 b=n2FGyF2gDGzihgPuPh3Si2UiaBh1uIwWX5Iti252wlQPWiT4YrGIAW7wJ0kv/06jHW
 yrpEzxZxFjhtJuD0WBhHD6bhAbKnnv2hJ3X73npc0E76w7TVcWTJUbBMl3bRm6cOGSNo
 u8zZzfB1MX9SyqkFidsrpuogRGrSskBBHXMeageBmS980UNsc9EJm+VQO1QzgE20VAC8
 7VL+M3I7ejyJxgLCpMMmhOJGry3eqBAl+VNPZUsO0eg3GRf/LR/qJ7a5ypyqDYhW0EAG
 bSG1qnZV39Fs+QynOHA6POqteJeAvch4wo2GwhAEtpiAGLiIPgcly984rhOCmtoo0w01
 piyg==
X-Gm-Message-State: APuU4Z//pQdViqVtUs07eLqJCs6q0fsjPLtv0uOVKI2fFwx7KnsBtkOm
 69FUc7XU5XvDfBLvxbH5tCBGJKO7hyqsZntQ9FPrHLQGIE0yPsvN0SdJcrHsukzlGvZZwl1mDDd
 m47gz34uZFTzfUSHe3EQvsceW3LE9som783pSNBgqNyzylpum6CfBClo=
X-Gm-Gg: AZFdTZcUSCtwuzj8dY437+xltCxaQoQd0X/6BsIq7O9NMeQeUROkv8oq/+nrZqsVi7m
 xyiNApAwKuEXeJhtdtBwGtnmKuuvhdvAoAq3T+7Xci2XfaFIPkgc/mRakmwDXHsFxDmK/OKkxzH
 aw8FmFqgJnJqtWdCdexEzIpP39qr1yf3Kju5jVyqX8wFnESuY09KYUOwbwUHfQbwxzeYsuYZlZE
 WEbBTlqmQygOQ2p49NPTKuGZMZ7bVQ/bfAdKc0rrS4+KKFn5yTFzcerPQQaEQ23s9HjxTGrB+rz
 ahA6o/agFy2EGHiWE2aJtH33l9jB6bGZZQB6KH6akcDgVCnY1jETHt5WJW808rnQwU0lHJlui4g
 26/3cys52E7niVBkRpPif05D6IMPUq3FB+UdPb/ObEWqWaqfc4huzMDE6bYKFU1eOr/BOhITlzL
 yUFk4n8hH7ucFpEeaLgLzW5JtNtFZuLaVEvBRIDeQFR+JtHfkAcVx/G5qO0G0+SXHBr+O67f4F6
 tG9eSJeyZxAHe/o2SPYu0OAQV5W/XU7EJBYvbd67MJkdlpxh1ZrfzS371kWrijZi2PpGsasqrYV
 4SDaynjQ9/g8a2BMuJLZwLT/jGpsPEKe1wKI7gdgRGLl+S3cdppKJEmHVdnkr+Z5N9YGX8oMAjy
 Zac4XinBeSgHe6MroKC6zLaKU3zM3q8xJ8/ILQK4s5ye+uxd2FQj8pu35QLddBmFzRad246tT9Y
 GrxAfc1tw4105KNZRkLtDKgYDzde5FnGlxoXa+srvwgUb8Fi3JnFaT3ylXRMwuGqRbY99q
X-Received: by 2002:a05:690e:1387:b0:67d:a676:262d with SMTP id
 956f58d0204a3-67da6762c02mr3525321d50.148.1794897543622; Mon, 16 Nov 2026
 22:39:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029-upstream-optee_rpmb_b4-v4-0-e2e4c5330d37@oss.qualcomm.com>
 <179486007040.2550799.14265493913048935825.b4-ty@konsulko.com>
In-Reply-To: <179486007040.2550799.14265493913048935825.b4-ty@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Nov 2026 08:38:27 +0200
X-Gm-Features: AclHuK-V0a7Qx4Uwsfb-KH2zU2S1Y0wsGBdQmYFBd6cW6XoESbUMqh-jKbRG1yQ
Message-ID: <CAC_iWj+0wVosYVrq3pAyDF+ekjf=sq7oOnRZfb_CfddDZq4c-Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] optee: two RPMB fixes for RPMB requests served by
 U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Jens Wiklander <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: multipart/alternative; boundary="0000000000007f013c06607326b2"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000007f013c06607326b2
Content-Type: text/plain; charset="UTF-8"

Hi Tom

That's partially my bad, but we only had to apply patch #2. I'll send a
revert for patch #1

Cheers
/Ilias


On Mon, Nov 16, 2026, 22:14 Tom Rini <trini@konsulko.com> wrote:

> On Thu, 29 Oct 2026 16:44:49 +0100, Igor Opaniuk wrote:
>
> > When U-Boot serves OP-TEE's RPMB requests itself
> > (CONFIG_SUPPORT_EMMC_RPMB, drivers/tee/optee/rpmb_emmc.c), two problems
> > show up as soon as a TA uses RPMB secure storage while other code is
> > using the same eMMC. Both were found running the OP-TEE AVB TA from the
> > Android bootmeth on QEMU virt with QEMU's eMMC/RPMB model, but neither
> > is specific to QEMU.
> >
> > [...]
>
> Applied to u-boot/main, thanks!
>
> [1/2] optee: rpmb: select the RPMB partition per request
>       commit: f473480c43a85961b62a45436a7e095e16c2cdab
> [2/2] optee: do not announce RPMB from within a supplicant RPC
>       commit: 35c7097a69f64daa4571216bd45b341ca09044c6
> --
> Tom
>
>
>

--0000000000007f013c06607326b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto">Hi Tom=C2=A0<div dir=3D"auto"><br></div>=
<div dir=3D"auto"><div class=3D"gmail_default" style=3D"font-family:arial,s=
ans-serif">That&#39;s partially my bad, but we only had to apply patch #2. =
I&#39;ll send a revert for patch #1</div><div class=3D"gmail_default" style=
=3D"font-family:arial,sans-serif"><br></div><div class=3D"gmail_default" st=
yle=3D"font-family:arial,sans-serif">Cheers</div><div class=3D"gmail_defaul=
t" style=3D"font-family:arial,sans-serif">/Ilias</div><br></div></div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mo=
n, Nov 16, 2026, 22:14 Tom Rini &lt;<a href=3D"mailto:trini@konsulko.com" t=
arget=3D"_blank">trini@konsulko.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Thu, 29 Oct 2026 16:44:49 +0100, Igor=
 Opaniuk wrote:<br>
<br>
&gt; When U-Boot serves OP-TEE&#39;s RPMB requests itself<br>
&gt; (CONFIG_SUPPORT_EMMC_RPMB, drivers/tee/optee/rpmb_emmc.c), two problem=
s<br>
&gt; show up as soon as a TA uses RPMB secure storage while other code is<b=
r>
&gt; using the same eMMC. Both were found running the OP-TEE AVB TA from th=
e<br>
&gt; Android bootmeth on QEMU virt with QEMU&#39;s eMMC/RPMB model, but nei=
ther<br>
&gt; is specific to QEMU.<br>
&gt; <br>
&gt; [...]<br>
<br>
Applied to u-boot/main, thanks!<br>
<br>
[1/2] optee: rpmb: select the RPMB partition per request<br>
=C2=A0 =C2=A0 =C2=A0 commit: f473480c43a85961b62a45436a7e095e16c2cdab<br>
[2/2] optee: do not announce RPMB from within a supplicant RPC<br>
=C2=A0 =C2=A0 =C2=A0 commit: 35c7097a69f64daa4571216bd45b341ca09044c6<br>
-- <br>
Tom<br>
<br>
<br>
</blockquote></div>

--0000000000007f013c06607326b2--
