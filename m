Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B65606A329
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QSH2H3Ee;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHlixl6A
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A36A81BCF;
	Sat, 14 Nov 2026 09:17:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id faT5_xIcRQKe; Sat, 14 Nov 2026 09:17:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E238081B7B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794647835;
	b=s6x4/fQBQGD8TAPkfJ3PsbSUyxnsO1xAKVi2XM3tuJilju/LczoGpxqgGf6OV5Kv2ZLM
	 VrPKPG/xIsta4OEo0YmvTE9dKg3LNyveEWTz2jRc2uFxW6TnIXJSqtLOxc1DrixN8EiAH
	 /jdqIk4jbyPB/1Q7vg/wEkomD3QbtxO2l76ZwQPhTa17RH5xmTL5PR6Z0SFRHApucW9MS
	 VKCMXj/md/oU21UJudRjRuH2/1ZO0AvD/wU3bU8YpvZZ3T5amvLtdC7V/hfQLRejlj7eo
	 4Xk7b+TiYRe+o9D/veFWGTYliXGDsIkdJqTs51ofGdmy/OGaSN6kv6Nu3hce9V4ISSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794647835;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=j1ScvyzLPby4kyd8795cRtPfJdcTNf8tqHR5qixbVtc=;
	b=syl8T9yKyUYAooCx9T5/C/AjYotznrFsUz+i/Tom/XnvSJJ+S3Z7jByf4IwFcZLwtWfh
	 l5ZtyMGsVP6yGfAiAGH3ILmO0MhCVVKk5L/30V63ff062RtBt11M/ZzmPIQYad/aXmdSt
	 et7tgJ79hM++eyq3YlFsTaGxM3bX/uQX44FN1ptqLGn7IZ/R1aGP3APmcn3Pcsz/t7y+U
	 vwBAdzeNUNC4gkU6Qbo+HERg1gV4YBiDj89Fw7yQ6VCoO9IkNxVPzkmsYNycde29asJu0
	 3X3V6QX5FIYH0/mTWP4anmtNpukESXvUNCANdSRjg12whz9knE2ag9gpFG7QxxfefBg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHlixl6A;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794647835;
	bh=j1ScvyzLPby4kyd8795cRtPfJdcTNf8tqHR5qixbVtc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QSH2H3EedVuCxiFjqycWxFny+tPR8gvoyT5635Tj/p78yLvYmR8EzOKPpY2NzP+4B
	 /EX00Se+ezV0z5qN2S6s1YR6kf9iZNNY88pakuyfkBnJhPfECiNOM7SLvrdZA8u2gB
	 gP3GRi7VmWPHIC6H980NcCPdialfoTKSzJJkxX7qs5pmAubr4vhNpYUEt5cSLc5Nb0
	 IGLbuPsSsVRZc3KQf8uH9iqo/r3U0ncY1KnQR8Hu88BSOTb3rEZlDdAHPZNDqVA987
	 X0rlJAX67yLexzl1XkNESM3UAZGsc5iA7mHDCQ10tlE1B+UdtM0B+vtyRGYy/l2xpQ
	 dtPgtsqq02GoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E238081B7B;
	Sat, 14 Nov 2026 09:17:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FA74169
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E0FE81B7B
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:17:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pPudycBDx_wV for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 09:17:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E00F681300
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f33; helo=mail-qv1-xf33.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=SHlixl6A
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E00F681300
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:17:12 +0000 (UTC)
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-91c847584b8so29955336d6.0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 01:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794647831; x=1795252631;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=j1ScvyzLPby4kyd8795cRtPfJdcTNf8tqHR5qixbVtc=;
 b=SHlixl6ASXSA5gSHWj6TRMbrvnkmwqA6DFvRGX1YcWQvRbnYSYl7E6MZZo7uodRN4Q
 pVrM3tGDuWynFrTNn16CwtX9saXVodB0x7HqBSOEn0yRuOM9s6k11bGCseeEXvmqxXTc
 IUI0g4suY4OC/4fS11/eHlq3lL+dy9KfBe+acZEqRD5ldJeDUvklecIZg92eM6D2EM8C
 iiKWEkpS70JbJHviaaR8rwHKpXqyLX3z5nEeylhxKKfaSiQE6u/ILkxUhLPyx8jy2TYb
 z+hdDECw7UWQ1drpMULNv8W8yevxKpOa9HSlsKO0ETimNjcv8kPGwqLB76eeCUrkVm5k
 kY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794647831; x=1795252631;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=j1ScvyzLPby4kyd8795cRtPfJdcTNf8tqHR5qixbVtc=;
 b=JKdTnyRWGnneOFgiIl/AFmlqYVeMEDTDHiqNOSphY6hmtLmIt7c8cVOo+5W+6cPY79
 ao7amfWTT9RXKxFKtmGhrsrMLbmQuGUpEh/zMCGnU3rbO/B4OFdROUua5AN3yWZ/9MZu
 HscGM1B4SxxrCb70bvdsUq4Kq1dwpFzo5vxRiPpDvu6bKZOUKHh6osph/y3yuvuCM388
 UWZJSx/qQ5w4P4tg7EFVp0PPA/7Mh+HS7XcfvK8VJlSyLvQpMVHBMmVqWvKzIDeKnOw6
 kXzz+iPCC9DYc7wz5mgdlkGOdxPI0sPyMkoSz1RoMYQmj8jxb1JvPKvlhNoKD5DnSxXm
 4Q3w==
X-Forwarded-Encrypted: i=1;
 AL+hErEmUk+K8DgMKPvwUjcSSCbPHbTgEjFEec9xTjjvPgEBvu1u4yIjMbBYaqlE6Ww6KH4dyeH0dc0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9gPqTB7p2veIzK7s4xe3FF/8DcAB+bKeIr7bmgQPBM2sS608GD
 T7PcTKtgVboPfgyOPTzyVPn/S+MpzvkzNS//qHq3PPBH7KXZ+i+G70O2FsyYrnzQlSdVDdVFI6n
 MP4pL5TQkPVXkWKHF8b2nsPPT+CSgeUA=
X-Gm-Gg: AYBFou2dm8SkaBnIOH+jiKJjKVOX2ZJAkDKYvPX2UEQ/Qtuo5NbvkqmbBIao9V9ytWN
 FwN9R65+50BK1Zy8sZrHCUUdc12iBV75ratsW6VgyFNdpUrvV/324qNRNQT0XJWARmJE6ny+wr8
 gMw2KiicL32mwh9OnHqhbuXQaI23/5/rVJft33IYDaZ6QK4NYHpgSqHN98LI9S4fsczGbqkXlY5
 00jktNNjZfh3U3RzRimvl4AIPIac51d0JWh9MhyOIGcar6mtnbbXIAtOz8A1eP1TK4vOi9a9c2E
 8NHANKvpDYniEfPKIdK/Wp8U3mn5z7JdKfizmKSAEu/DvspKi5coKF3oU9ot2QPM6qhXzQcqaUT
 ZiiIBwkZ713FHYJiafTSv2AXpOTBhht31JIOds0H9QPch2uXZKEHPg7PmRXIaCOxk3ojL/7fJ51
 3Z6UfuC/56ma9Q0xuGp2zojvn9k4uuVdfLnzZ7z9cfKtFpuERjLL0VOq8CFX/kBJYK5aXpaD1vV
 kXBAQ56vH2zGZX9VOgLOC2xOK0ATfJQfCmfWNKEiKaxDkOwvt5lF69p
X-Received: by 2002:ad4:5aac:0:b0:91c:6cca:8268 with SMTP id
 6a1803df08f44-91f13a73003mr135025526d6.33.1794647831245; Sat, 14 Nov 2026
 01:17:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
 <20261113174852.GN554944@bill-the-cat>
In-Reply-To: <20261113174852.GN554944@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 14 Nov 2026 09:16:59 +0000
X-Gm-Features: AclHuK-9WeKtgd4RM5n3lWpARBUKpeh6DcCKUSTfJfudlxPH5YcWFi6jQEz0EQM
Message-ID: <CALeDE9PvZgwiAUxdX=-tN1fgDveNOkeM__xCCJeZrK3Di0WxjA@mail.gmail.com>
Subject: Re: [PATCH 00/10] binman: support separate binman devicetree from
 control devicetree
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Carlo Caione <ccaione@baylibre.com>
Content-Type: multipart/alternative; boundary="0000000000007a786b06603902de"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000007a786b06603902de
Content-Type: text/plain; charset="UTF-8"

Hi David,

> Anyone who has worked on hardware that uses a devicetree for the
> > hardware description should know the mantra "the devicetree describes
> > the hardware, not the configuration"
>

Thank you for this, I never agreed with describing these in the DT at all.


> > Binman is describing configuration and not the hardware itself,
> > therefore it doesn't belong in the control devicetree that describes
> > the hardware. So we propose encouraging the separation of these two
> > descriptions into separate devicetree files. In most cases, binman
> > info is not needed at runtime anyway, so combining it with the control
> > devicetree is unnecessary, takes up space, and causes DTS validation
> > to fail because binman is not part of any standard devicetree schema.
>

This is great, and I look forward to this landing.

Forward looking and just a little thinking out loud here, forward looking
is the device tree format the most straight forward way to describe the
requirements for this? I wonder whether something like toml or even the in
tree env format [1] might be better suited?

To be absolutely clear here, I think this series should proceed and I'm not
necessarily asking you to do it, more just gathering ideas/opinions.

Peter

[1]
https://git.u-boot-project.org/u-boot/u-boot/-/blob/main/board/raspberrypi/rpi/rpi.env?ref_type=heads


> > Currently, only Xilinx is doing this kind of separation. This series
> > makes it possible for more platforms to adopt this separation. The first
> > patches fix binman so that the image gets the U-Boot control devicetree
> > rather than the binman one when the two are separate binaries. And they
> > make BINMAN_DTB work with OF_UPSTREAM, and document the recommendation.
> > The remaining patches update the MediaTek Genio targets to make use of
> > all of this.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> My more direct concern with this series is, who has some review cycles
> to step up and co-maintain this tool? It's already been privately
> suggested to me that we could drop the lofty "one tool for every project
> to rely on" goal since most projects continued to develop their own tool
> for assembling binaries anyhow. And that in turn reduces the scope. But
> it's still an important part of the project and so needs some people
> looking after it with a more global eye.
>
> --
> Tom
>

--0000000000007a786b06603902de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi David,</div><div><br></div><div class=3D"gmail_quo=
te gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
&gt; Anyone who has worked on hardware that uses a devicetree for the<br>
&gt; hardware description should know the mantra &quot;the devicetree descr=
ibes<br>
&gt; the hardware, not the configuration&quot;<br></blockquote><div><br></d=
iv><div>Thank you for this, I never agreed with describing these in the DT =
at all.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
&gt; Binman is describing configuration and not the hardware itself,<br>
&gt; therefore it doesn&#39;t belong in the control devicetree that describ=
es<br>
&gt; the hardware. So we propose encouraging the separation of these two<br=
>
&gt; descriptions into separate devicetree files. In most cases, binman<br>
&gt; info is not needed at runtime anyway, so combining it with the control=
<br>
&gt; devicetree is unnecessary, takes up space, and causes DTS validation<b=
r>
&gt; to fail because binman is not part of any standard devicetree schema.<=
br></blockquote><div><br></div><div>This is great, and I look forward to th=
is landing.</div><div><br></div><div>Forward looking and just a little thin=
king out loud here, forward looking is the device tree format the most stra=
ight forward way to describe the requirements for this? I wonder whether so=
mething like toml or even the in tree env format [1] might be better suited=
?</div><div><br></div><div>To be absolutely clear here, I think this series=
 should proceed and I&#39;m not necessarily asking you to do it, more just =
gathering ideas/opinions.</div><div><br></div><div>Peter</div><div><br></di=
v><div>[1]=C2=A0<a href=3D"https://git.u-boot-project.org/u-boot/u-boot/-/b=
lob/main/board/raspberrypi/rpi/rpi.env?ref_type=3Dheads">https://git.u-boot=
-project.org/u-boot/u-boot/-/blob/main/board/raspberrypi/rpi/rpi.env?ref_ty=
pe=3Dheads</a></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
&gt; Currently, only Xilinx is doing this kind of separation. This series<b=
r>
&gt; makes it possible for more platforms to adopt this separation. The fir=
st<br>
&gt; patches fix binman so that the image gets the U-Boot control devicetre=
e<br>
&gt; rather than the binman one when the two are separate binaries. And the=
y<br>
&gt; make BINMAN_DTB work with OF_UPSTREAM, and document the recommendation=
.<br>
&gt; The remaining patches update the MediaTek Genio targets to make use of=
<br>
&gt; all of this.<br>
&gt; <br>
&gt; Signed-off-by: David Lechner &lt;<a href=3D"mailto:dlechner@baylibre.c=
om" target=3D"_blank">dlechner@baylibre.com</a>&gt;<br>
<br>
My more direct concern with this series is, who has some review cycles<br>
to step up and co-maintain this tool? It&#39;s already been privately<br>
suggested to me that we could drop the lofty &quot;one tool for every proje=
ct<br>
to rely on&quot; goal since most projects continued to develop their own to=
ol<br>
for assembling binaries anyhow. And that in turn reduces the scope. But<br>
it&#39;s still an important part of the project and so needs some people<br=
>
looking after it with a more global eye.<br>
<br>
-- <br>
Tom<br>
</blockquote></div></div>

--0000000000007a786b06603902de--
