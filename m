Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5C606A31F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KQd0w0ey;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eB6aZ4Ws
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29A2360672;
	Sun, 15 Nov 2026 20:52:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QQAOwrpv3diL; Sun, 15 Nov 2026 20:52:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2602360632
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794775927;
	b=Zl6idCzaoQMscUNbG6fPUdA2hkVe9hdYB1vS6Dyt9u2wAtpfIRUUpXCmXN5mcaMCaFM7
	 xH5slR4UiB80RqxeJrT48r0Zv7KqggPyN9e3Q+ABvQBd786GCqBPCn+MUkod3JIbOlU2W
	 F+Ml8CrSGTmBWfk1vl4dcvhDNT9BfGVsCMN9iB/gZwODgOAFIKfNMxK1Af80zvQXtRaGW
	 O1yAfw7Z3r0aqA8RIEjsxflE6uhz2EvJkL76vFiEt4e0x26x6059CKpFbXQSZcdshF/gN
	 iYtZgG/S5cnJmq1gg2uSa6kSiT+WTL/yPWsym8ANTBmgw2JoV5oN94EppIfii34Zp0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794775927;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wAyDshsu6SAFAybc6wnt94GtNmhqoMKWj93uS9n8Uwc=;
	b=s0s2/pAqgMmjldJE5kbQyrD3S6nxV47rc2ezEXV8ucRvpZF2GVl2UUJKvcqr3lO5+XkJ
	 v408FSUaYsvHuWqKcQ7mQXVoGoY50mv6+HF3Z/FH0PrD8FKzh/txI1UZlyA4GSH2ckdL6
	 iZPNY2REZh52a7lEWov2aEnBdWnOeZVLQ7dgeGrqvgjsrBE+GXXi1OmvsqRzgyLqYzRXE
	 rA0HTYtVH8noPnGa1GLDVimSr3oE9NMsXA3RcMI9riG/2MG9Dd9E7FXXF6UlVikOTyRIT
	 SRgDjZLX5P56VlDjbDVDcHWL6ee3PXmAcWdYBQ88FqFRT1VLvOtcmqNJajYAGs0+CAg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eB6aZ4Ws;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794775927;
	bh=wAyDshsu6SAFAybc6wnt94GtNmhqoMKWj93uS9n8Uwc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KQd0w0eyQbGrKe51o+K8md3RmPNddXA/3Csja6cmYYB8uw5vvqJLqX9PJoTrDwfzL
	 mtrqiTqXas8JBSgIkvzyKFwfI+G1qifcRBJ2pYdYGzS8RDs/wsJV8slkzypAUI+ue/
	 Nf6E9UFGfTyVc9kV0hgOwpDEQ9lIWk4kctZZUmM66iRo5dvcfUWAcIN8kwuhdTz5X9
	 7ej9ntUJdNWg+66eDmoMLeyrM+nlHXh7TXJsnYKVkeeJgR23Lt2CMiB/2518fC2ded
	 Wx9JIg5z7lq3PuQ7O5X3RXtNQWWJ9fa2teqEM7t0sBVF/JwbK0RcpDtqdvmRggwQMm
	 /V3McmxSkRnfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2602360632;
	Sun, 15 Nov 2026 20:52:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 896B928C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 20:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 67C05605EB
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 20:39:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1CstvzltZ-wL for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 20:39:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 39D8F60607
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::92b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92b; helo=mail-ua1-x92b.google.com;
 envelope-from=georgekola@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20260707 header.b=eB6aZ4Ws
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39D8F60607
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 20:39:25 +0000 (UTC)
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-99071945aa7so2420990241.3
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 12:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794775164; x=1795379964;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wAyDshsu6SAFAybc6wnt94GtNmhqoMKWj93uS9n8Uwc=;
 b=eB6aZ4WsvIH6s5qOoks8LVNgWFyI8VRu5dqBWKFEjqip9AmGFun3zpYM3UYe84ub9I
 tPfweQRwwVDps4002fZ917nBukmE3PXRADPBuaszECgVRB5DXstwnZeJCIzCAOxkzbIE
 P/3v8J1mmJ2Q01Wc1nUn5tQ0h5fu6NVZIKk1yJWANN8uKlQsiZO1d0WKrdi4apKHjEWr
 8YnsbfQN5bpyOFwqgUQ9j1/to8GIGPRiPbERKzEuKV5+QYf2MRsYz0UteAkeLeoDNVUD
 5PRTj05p11NE4rS0nwqa/CEezCjI1yvZwpd4YnXFc8YtOyUv28WVgT/pZyqvuYEfU8r3
 Y7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794775164; x=1795379964;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wAyDshsu6SAFAybc6wnt94GtNmhqoMKWj93uS9n8Uwc=;
 b=2WPSTfHAiDFin1+fXYXcbmbQ7kCQFIs6amYWZVJSLzcp+AbqgwrCuXWUzrYyXtQ5j7
 cT58fKPA8U7OBvGXpU1BUgt5BSYKPrvU+QqhDIBasqt9HQGkh2rq4lIhDVXjXscj/4YF
 qZ2gl65eygtNoYtYvZ22MOsJrC9P0g8P4p8f1Bef5EQRo8QChOSyGJz/9TMeIJxzSQfB
 qhO63xpuGXJyEnOSPsdTmAaj4rdcc54gy3YmlmXir14DF3MCa+jzJ51m4gbE1gMatIje
 lDAJML764bPXKwvzRbmy31iO1mgReSD91SjRhK20ZonRequ0ANSo6jtOr/0I8wPa6cNV
 Rt2w==
X-Forwarded-Encrypted: i=1;
 AL+hErGiNkHxmrrteoOxmvGCN7+ew3SHrkby4RJ4rkxH0fIr7Id0ogNPA3xcJ8nm0E4mkuw7zSH1j2M=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9D9vwSvMvmVX5e99Oif3dx8vgx1M4vPQlDX1fzrTjbSx7XlmRI
 UF00xdSNqNC/vaIw5ND+40kEKQ8MvzJzV8fZR42GET90Q3MXgX5UgutD4reYun1TvtIayMjT5jl
 9XZ5d6x+wA5NVlTbaxrHEX9HwEAWv/LPsI3h0sDcb
X-Gm-Gg: AYBFou0woARG+HF/9sqZcjlWOFuzVABXOFIw0+8s/vGwmgaW3qAVdp38wZ56oxZBMit
 TgMn4ZWPgAh28OyRu61zkgYKl9F26WLU5oUBTK7aR2stx4C54U1c8MyWihSC2Ub5kBg35MZdvHz
 jXFcgUHcWaxWHzKPpdkDKelIhKVRbo2MtOWp7A+rwLLBOejOp267J3f53LhljM+PTRhamtC0GFA
 PCXAnZri3BPfwgBznXEMHF8tkyy2xhGIv7vP8f5QNR0v8zyDS5rRIw66bCmXGqcbI7d13R/2wYh
 lklpQIW9p2BUx3iI2V0GheQBYFQTnARvUtIfMVDJ/z383heyjvKF7IGntu96l+vKD4z5mqGjjPK
 n9PKb78BWAprX0jksd2KoSt8Cdm7TTzrXT1rLrcnHn0ENnuBBIlDT694a/jjb439lB/Va5g==
X-Received: by 2002:a05:6102:510f:b0:7cc:3246:3095 with SMTP id
 ada2fe7eead31-7d64d8b73cbmr3292415137.34.1794775163803; Sun, 15 Nov 2026
 12:39:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAOTQ16+AbF9iURWBrU6_NOM14KCq5-s1YFbbP9ULe0Ch0hhAZQ@mail.gmail.com>
 <20261115180628.GV554944@bill-the-cat> <avn83NoJA8ZKi1q7@localhost>
 <20261115190204.GW554944@bill-the-cat>
In-Reply-To: <20261115190204.GW554944@bill-the-cat>
From: George Kola <georgekola@google.com>
Date: Sun, 15 Nov 2026 12:39:12 -0800
X-Gm-Features: AclHuK8JQd4fiWmlMEQkAiUdDJtKC7CYQK6FomOcOpy_YdcC9Par3cvOpeRT97U
Message-ID: <CAOTQ16JK6uKASoNGK1XFXuw-W+dc9ofZRJEV_ZqHMVbAjXhPPA@mail.gmail.com>
Subject: Re: [PATCH] configs: netspace_mini_v2: disable default netconsole
To: Tom Rini <trini@konsulko.com>
Cc: Simon Guinot <simon.guinot@sequanux.org>, u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="00000000000018541b066056a8ec"
X-Mailman-Approved-At: Sun, 15 Nov 2026 20:52:05 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000018541b066056a8ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for confirming. I was trying to secure our setup where we do not
need this and  I will move this into our repo.

On Sun, Nov 15, 2026 at 11:02=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:

> On Sun, Nov 15, 2026 at 07:41:32PM +0100, Simon Guinot wrote:
> > On Sun, Nov 15, 2026 at 12:06:28PM -0600, Tom Rini wrote:
> > > On Sun, Nov 15, 2026 at 09:12:23AM -0800, George Kola wrote:
> > >
> > > > netspace_mini_v2_defconfig runs dhcp and activates netconsole in
> > > > CONFIG_BOOTCOMMAND without setting ncip, exposing an unauthenticate=
d
> > > > UDP port 6666 console that accepts broadcast packets and drops to a=
n
> > > > interactive U-Boot shell over the local network.
> > > >
> > > > Remove dhcp and netconsole activation from CONFIG_BOOTCOMMAND and
> drop
> > > > CONFIG_NETCONSOLE=3Dy so the board boots directly from local USB or
> SATA
> > > > storage by default.
> > > >
> > > > Fixes: 970bf8603b87 ("Convert CONFIG_USE_BOOTCOMMAND et al to
> Kconfig")
> > > > Signed-off-by: George Kola <georgekola@google.com>
> > >
> > > This is feature working as intended, presumably.
> >
> > Yes, netconsole is enabled by default on purpose on the LaCie
> > Kirkwood-based devices.
> >
> > When installing mainline U-Boot, you need a way to access the U-Boot
> > console in order to configure the environment for booting the OS you
> > are installing. The serial port is not always an option, since it
> > requires opening the case and using a serial adapter (that you may not
> > have).
> >
> > Here is a guide describing how to install and configure mainline U-Boot
> > on these devices: https://lacie-nas.org/doku.php?id=3Duboot. Much of th=
e
> > procedure relies on netconsole being available.
> >
> > Note that you can disable netconsole support either at build time or at
> > run time if/when you don't need it. But I think it is better to keep it
> > enabled by default.
>
> Thanks for confirming.
>
> --
> Tom
>

--00000000000018541b066056a8ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks for confirming. I was trying to secure our setup w=
here we do not need this and =C2=A0I will move this into our repo.</div><di=
v><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Sun, Nov 15, 2026 at 11:02=E2=80=AFAM Tom Rini &lt;<a =
href=3D"mailto:trini@konsulko.com">trini@konsulko.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">On Sun, Nov 15, 2026 at 07:41:32PM +0100,=
 Simon Guinot wrote:<br>
&gt; On Sun, Nov 15, 2026 at 12:06:28PM -0600, Tom Rini wrote:<br>
&gt; &gt; On Sun, Nov 15, 2026 at 09:12:23AM -0800, George Kola wrote:<br>
&gt; &gt; <br>
&gt; &gt; &gt; netspace_mini_v2_defconfig runs dhcp and activates netconsol=
e in<br>
&gt; &gt; &gt; CONFIG_BOOTCOMMAND without setting ncip, exposing an unauthe=
nticated<br>
&gt; &gt; &gt; UDP port 6666 console that accepts broadcast packets and dro=
ps to an<br>
&gt; &gt; &gt; interactive U-Boot shell over the local network.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Remove dhcp and netconsole activation from CONFIG_BOOTCOMMAN=
D and drop<br>
&gt; &gt; &gt; CONFIG_NETCONSOLE=3Dy so the board boots directly from local=
 USB or SATA<br>
&gt; &gt; &gt; storage by default.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Fixes: 970bf8603b87 (&quot;Convert CONFIG_USE_BOOTCOMMAND et=
 al to Kconfig&quot;)<br>
&gt; &gt; &gt; Signed-off-by: George Kola &lt;<a href=3D"mailto:georgekola@=
google.com" target=3D"_blank">georgekola@google.com</a>&gt;<br>
&gt; &gt; <br>
&gt; &gt; This is feature working as intended, presumably.<br>
&gt; <br>
&gt; Yes, netconsole is enabled by default on purpose on the LaCie<br>
&gt; Kirkwood-based devices.<br>
&gt; <br>
&gt; When installing mainline U-Boot, you need a way to access the U-Boot<b=
r>
&gt; console in order to configure the environment for booting the OS you<b=
r>
&gt; are installing. The serial port is not always an option, since it<br>
&gt; requires opening the case and using a serial adapter (that you may not=
<br>
&gt; have).<br>
&gt; <br>
&gt; Here is a guide describing how to install and configure mainline U-Boo=
t<br>
&gt; on these devices: <a href=3D"https://lacie-nas.org/doku.php?id=3Duboot=
" rel=3D"noreferrer" target=3D"_blank">https://lacie-nas.org/doku.php?id=3D=
uboot</a>. Much of the<br>
&gt; procedure relies on netconsole being available.<br>
&gt; <br>
&gt; Note that you can disable netconsole support either at build time or a=
t<br>
&gt; run time if/when you don&#39;t need it. But I think it is better to ke=
ep it<br>
&gt; enabled by default.<br>
<br>
Thanks for confirming.<br>
<br>
-- <br>
Tom<br>
</blockquote></div></div>

--00000000000018541b066056a8ec--
