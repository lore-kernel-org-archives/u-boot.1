Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D176606A323
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y2Zg2Ls+;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T5G3XpAy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFE6B60883;
	Tue, 17 Nov 2026 12:58:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J3aJDunrkMB8; Tue, 17 Nov 2026 12:58:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C335960878
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794920279;
	b=X3M87kiiUNegdZKouKgqGwDtwkDfesGiMxJkFX4McHtM3yBRqrtzmTwRWNAD7h+9dvCm
	 Qn2U1iMwQv21+TabG/5KTjVi6MB60AabzORlY0/JXT6binBBykyuv8m9eVZz3Sx1Uw+MW
	 PypDTrEsnqvlGvsn+vLMSQhK+NzraiT+TWqWs8SlqfRvIFd2UeXMraYrdCdPgE8iw1EXa
	 KVJQkjgq1m2IDDykVs9EzhvryHQ1gDS2i2+M4CbmUFxLpUHWbNcpgsR/ADbYoWJsfl8Kn
	 w8KNrNDwBqA0Xcnp+S++4rGyICWycDLQzeof5WsCmGlsDgS59XKlHXRK81E6CIuN+vA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794920279;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+P+xLuZd0uSWl21q0CytwSizAOnMuyLB4KEvB1lkNQ0=;
	b=q91BtpYMMgCqy6uJdFgllwKZX10Yt+OX1b8AcVK9SstJCW8J8Jg1C2BvsDZFwAq8ImSn
	 Kr5xPIIUaW5BA2EYdGR4Ynqcg055x4n4WRrVNtqvJRzVwEvxTMWL/98Vcq6G0rCLpfcPK
	 8Rh6OsPu7G2jUt23tPfe2RcZUpmHmyfD5MmEYErcNIP+jJBv3RrdB9sqDNnBWbMe6VhZr
	 Q1lw4F+DGJPi9HMDSG08GceQggZDX9eFblQ7TCXUKzc0YKRHTsFP3L35gBhIt8Wm4FSD/
	 Cs7TyvdVO8/GICrmoWycT1+209BuJXLUT/fsGBYFaqAeXZNcMEm5GFe1bC/iOFJBE0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794920279;
	bh=+P+xLuZd0uSWl21q0CytwSizAOnMuyLB4KEvB1lkNQ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y2Zg2Ls+YkTYDUdnQlbSDdFtJvp1s9ADHPwuy39xeLuGL+BVRflmGBgI6J12T2zLs
	 9PZWboiEPB8M+fjFzInKnGqK2ZEInQEfZ0xG2NPRjGh78fefhzVyjqr3J3Uav9vPPU
	 XS4De4xClCcin6bFojBX+QBDQZKS4pDKLXIl1S9w3BNzZxZlbr0Mu6Vqc7PwOg4BBQ
	 X2TWljvAxEzSp8clkxShqwrs6fuKqa3Un9uh1sJLI680c0JSonFIPKvfayy3PguvVo
	 i4Z05geG3YrfzPAG7y4qFQcF4G3Jh5qHmOssmjCXB644ybHx2Od9/pV8Cw2Y1CI94h
	 4VTARBFE+io6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C335960878;
	Tue, 17 Nov 2026 12:57:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B973105
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4640D81102
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:57:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AuW5HZJkUAKv for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 12:57:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1EE4E81101
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2e; helo=mail-qv1-xf2e.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=T5G3XpAy
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1EE4E81101
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:57:56 +0000 (UTC)
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-91eb53957cbso85629056d6.3
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 04:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794920275; x=1795525075;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+P+xLuZd0uSWl21q0CytwSizAOnMuyLB4KEvB1lkNQ0=;
 b=T5G3XpAyOmNBHX7VYidpSHxlVgv7Qy1+gGFx+aTtIzxsGK+8Hm/242kKwQRhXv3baa
 /WeM0BqJjIWdMSvvCYQIvDxJOzzWD++eiHhOHwElo/0BN8scBDN+U5RankzWSGH2GLoY
 dENc1FeaIbFrV5GVmNpxQ3EAkO6Lw72zJy+CyQrWiG8aYtU4K+ycB5h8+SjRFCkOXWWu
 D9YzlGt0i004h7Q1bqskGzY2/WgXZnnQU4UKBBtPzsQGLymhcqzbjr6r6xnVzYKzO1wh
 Clliea/ZQZlsJoxqKSuX2l8O6E+3Iovg7rSQjVGqmQtvn7u25g1FxfAFpfKay+XYyRBm
 VFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794920275; x=1795525075;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+P+xLuZd0uSWl21q0CytwSizAOnMuyLB4KEvB1lkNQ0=;
 b=0T1OptnsEcNJkbLRijG9oP++3fbp+wEnLtXZvL0Q/uvQvATZgb2aYHzoGYLmgJdzbo
 Fd5hdi4EfDDX4FnLz+ImxJWItB4Xir0ykk332lZVo7DY5d7skXk8CkI6WghsLfONaVq4
 oqzj4iIgHTDR3Af5WlpHXNrr1epmu5tuhMsp6UzwowkQRmp8L97H8N5Hi72ZmHAndwAy
 Cpq7jBsEBgLBpJ3b1zOrM63Xck8WN/UQbXKRsQNM4U+1Fx5I2MR4sOHaFHH4vTa1St+W
 seImHjsaK6cTXlwqwJ9B1Y4NKoxKzLaXP6Tq4N36evFVDXrdy9FxhM0RFCdo7KqnVLOu
 5Eeg==
X-Gm-Message-State: APuU4Z+SiYBkhots3DNjMrmpQhIk+PElO7ppRdIxisL3ml2QQGb0RsB9
 Fi3yFckfPhgnGkpam5Wsyd311cfjL3Hx82cgJKoI/LyssYTlbgDGqxEHJ8fdZxWyDMhpaFcqo5h
 ZUahHgqvdLwBAtAhZCKN3dInvo5bV+rpMiA==
X-Gm-Gg: AYBFou2ubIhtm/s36hDmE9puiGvFctOurz+s2zDQcBLMgcPcG0N5XN11R/9g0J2JuDx
 7fjp757v9nRe0OcrKxBJxkmHok4zofFvPqeRFYiaxtwEyXiqeM0WNsly3Ea26ZP9ODqxWDdsfrn
 JgRq2hWrZakZGm3vlBBcce8dQtsSNWm8Rfm8/qoITR6wc8wIP1sI47/URDinlC811avH+gD17Ed
 q9Xvpc8LKWyjLU8CCqyoOyR9+/XZ4IneRKSowgmIOLA4fJiVi+WQAgGOcqusmb5jajRpqYmu/Yw
 ENgXafRyA9oI3gZ64/ARZeBTF21AqdWQr01vdobXtOoWr24rtKQM3UmkFcshRijt6YChjDo5Aj4
 pBaHEhTE2K5J11kZTXVkg7Fla1J0U8gs52dOu4GEG+3C7q5mLO1B2C+INgzbT5u705LNPYlpQmX
 ybV3LDbNUbfzj2IjWcdspis7cA9kMMo3zbAvo22iIkswmCftjjocEsvGLUkyA622bEVoy1bpXZH
 trNIpmgCHwswdI0tmWXyZ1EXD2yOAiWlSE=
X-Received: by 2002:a05:620a:2903:b0:93c:a40d:e3cf with SMTP id
 af79cd13be357-9494b9c78a6mr2306383185a.1.1794920275102; Tue, 17 Nov 2026
 04:57:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117-tryboot2-v4-0-d59fa66de789@linutronix.de>
In-Reply-To: <20261117-tryboot2-v4-0-d59fa66de789@linutronix.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 17 Nov 2026 12:57:43 +0000
X-Gm-Features: Aa3M54o1JcEt8kjcjLxXKYDxNLJQ5BbirndnAi6ZOJAdQb_FA7Ep7qcmOBM7DZ0
Message-ID: <CALeDE9Pay-8Szx_kxFBx5de08BNOZrxvELtthjECij7UvuUr-w@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 0/2] rpi: copy /chosen/bootloader node with
 properties and set boot_partition
To: Gregor Herburger <gregor.herburger@linutronix.de>
Cc: u-boot@lists.u-boot-project.org, Matthias Brugger <mbrugger@suse.com>, 
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000065d50206607871b8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000065d50206607871b8
Content-Type: text/plain; charset="UTF-8"

Gregor,

I have your series in patchwork, doing multiple "resends" doesn't put it
any higher in my review and testing queue. I am sorry, it's on my list, I
am in the process of getting to it but unless there's any changes needed
this doesn't make any difference.

Peter

On Tue, 17 Nov 2026 at 09:59, Gregor Herburger <
gregor.herburger@linutronix.de> wrote:

> The Raspberry Pi has the "tryboot" feature where it can boot from a
> different partition enabling failsafe A/B updates. After boot the
> firmware adds some properties in /chosen/bootloader, e.g. partition.
>
> Pass this node through to the OS devicetree and use partition to set the
> environment variable boot_partition.
>
> Changes in v4:
> - Split into two patches
> - update commit messages
> - Drop Reviewed-by-tag again
> - Link to v3:
> https://patch.msgid.link/20260804-tryboot2-v3-1-b0bc282a923b@linutronix.de
>
> Changes in v3:
> - Copy the complete '/chosen/bootloader' node instead of only the
>   partition property
> - Link to v2:
> https://patch.msgid.link/20260803-tryboot2-v2-1-30c071f2ee15@linutronix.de
>
> Changes in v2:
> - update Reviewed-by tag
>
> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
> ---
> Gregor Herburger (2):
>       rpi: set boot partition from devicetree
>       rpi: pass the bootloader node through to the OS devicetree
>
>  board/raspberrypi/rpi/rpi.c | 51
> +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> ---
> base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
> change-id: 20260803-tryboot2-8c5221376e5a
>
> Best regards,
> --
> Gregor Herburger <gregor.herburger@linutronix.de>
> --
> Gregor Herburger <gregor.herburger@linutronix.de>
>
>

--00000000000065d50206607871b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Gregor,</div><div><br></div><div>I have your series i=
n patchwork, doing multiple &quot;resends&quot; doesn&#39;t put it any high=
er in my review and testing queue. I am sorry, it&#39;s on my list, I am in=
 the process of getting to it but unless there&#39;s any changes needed thi=
s doesn&#39;t make any difference.</div><div><br></div><div>Peter</div><br>=
<div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"=
gmail_attr">On Tue, 17 Nov 2026 at 09:59, Gregor Herburger &lt;<a href=3D"m=
ailto:gregor.herburger@linutronix.de">gregor.herburger@linutronix.de</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The Ras=
pberry Pi has the &quot;tryboot&quot; feature where it can boot from a<br>
different partition enabling failsafe A/B updates. After boot the<br>
firmware adds some properties in /chosen/bootloader, e.g. partition.<br>
<br>
Pass this node through to the OS devicetree and use partition to set the<br=
>
environment variable boot_partition.<br>
<br>
Changes in v4:<br>
- Split into two patches<br>
- update commit messages<br>
- Drop Reviewed-by-tag again<br>
- Link to v3: <a href=3D"https://patch.msgid.link/20260804-tryboot2-v3-1-b0=
bc282a923b@linutronix.de" rel=3D"noreferrer" target=3D"_blank">https://patc=
h.msgid.link/20260804-tryboot2-v3-1-b0bc282a923b@linutronix.de</a><br>
<br>
Changes in v3:<br>
- Copy the complete &#39;/chosen/bootloader&#39; node instead of only the<b=
r>
=C2=A0 partition property<br>
- Link to v2: <a href=3D"https://patch.msgid.link/20260803-tryboot2-v2-1-30=
c071f2ee15@linutronix.de" rel=3D"noreferrer" target=3D"_blank">https://patc=
h.msgid.link/20260803-tryboot2-v2-1-30c071f2ee15@linutronix.de</a><br>
<br>
Changes in v2:<br>
- update Reviewed-by tag<br>
<br>
Signed-off-by: Gregor Herburger &lt;<a href=3D"mailto:gregor.herburger@linu=
tronix.de" target=3D"_blank">gregor.herburger@linutronix.de</a>&gt;<br>
---<br>
Gregor Herburger (2):<br>
=C2=A0 =C2=A0 =C2=A0 rpi: set boot partition from devicetree<br>
=C2=A0 =C2=A0 =C2=A0 rpi: pass the bootloader node through to the OS device=
tree<br>
<br>
=C2=A0board/raspberrypi/rpi/rpi.c | 51 ++++++++++++++++++++++++++++++++++++=
+++++++++<br>
=C2=A01 file changed, 51 insertions(+)<br>
---<br>
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5<br>
change-id: 20260803-tryboot2-8c5221376e5a<br>
<br>
Best regards,<br>
--<br>
Gregor Herburger &lt;<a href=3D"mailto:gregor.herburger@linutronix.de" targ=
et=3D"_blank">gregor.herburger@linutronix.de</a>&gt;<br>
-- <br>
Gregor Herburger &lt;<a href=3D"mailto:gregor.herburger@linutronix.de" targ=
et=3D"_blank">gregor.herburger@linutronix.de</a>&gt;<br>
<br>
</blockquote></div></div>

--00000000000065d50206607871b8--
