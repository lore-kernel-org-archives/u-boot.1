Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA247C88E77
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 22:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FC2A4067A;
	Tue, 15 Sep 2026 22:41:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LN5c3hATeKC3; Tue, 15 Sep 2026 22:41:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E903E405DD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789512109;
	b=jeQ23EWd+4s5OsC7eOqAdelYWS06hmmtC7k62orFo0kg13lJdc4iSGnePj3M82FRH87u
	 9QHM2YGsEpM0YaqjO+Z6uoY7eZaWBO+60cYqq/U2SG6x64BxQA36Tc40XS35qDe5zqRXe
	 HXNaKWMpf/FGCll0FYK9nNq1ZAbPGjyv4ABK442Z+oauVcAUoGnm3Wi62kEwxdJ9poTsn
	 OctH5lxNS6Ems6YvozWbNp8FO4itsJuQr/WjbAB/adktSKRfc/DsaEBjFz2XK36kCDFEg
	 7osIbjMJ4RdUvXewQ2EFhDX2r6u6ZjZoS24gzb+snb4p7Afl1XcCU0ranbqGO7DKhZA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789512109;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1J6SGjaL/d4hcOGeL/J0zRxlbuss94qadPRVEwmobQc=;
	b=qcnOwyRwAbYv0om/reYJoAUejspIbvja1s9+atYu6NF1eOyhWqPc1j/9e+x7RxoD9RCJ
	 Phnh04skVChDrfZ/KMp05wLsC0zSfJmUmlUTktyKi21R00fcvOKAjkYxzZeenwnBGwRSB
	 ZgNvsHCtXmivD8YC1eQFSyaKp0mNTVgET2m+WBBW2IlKqeBvj9fcZ5tZwfZHKMrVAMfUQ
	 7W1Un8jp/9IKhg/9Mqt51uh6ELbikLJ1UM4kmWfr66JJkgeU3UxTWxVK05wdWBgzBGkDy
	 4rnbbp3cWsIfLZlx+ZD7UdQ9cFXeIBne5PUIuRzZ1THdvIVXQDcEANdD3trJUN39oog==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789512109;
	bh=1J6SGjaL/d4hcOGeL/J0zRxlbuss94qadPRVEwmobQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xLZoZvLFHAWO+vfCscUJcao+P5RtarDP5GHVUByxacziOM1n77qqHTXdqb6/u85Ol
	 0RRpBDyepudDNsujj/jtaFxO9sSUo5azzvjzjNOLNMJSB+tpJRPHinMw65fZiEXLb7
	 /Va+CXt/PMHHYp1eHBRmJy5FHrymfDMTtquyR1l9lMFCIj/TC8loAP2sAF0XfPIhUI
	 LIaXpL+RFIO8jEB1PFnCJaq9B02A62Nk29gkhbg9myahrWJPlMkqfF+t02wdfmPFXT
	 gndbLGt6aSFcJ1jjP3GALVgWvfVw2RYz9w5NfSfvU/AzXvFvQhqWXY0Ksde9Xkct9t
	 /Z8FxyVFzRIjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E903E405DD;
	Tue, 15 Sep 2026 22:41:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F76B388
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 22:41:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5CE3280C06
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 22:41:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZY5AIXtqOc4F for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 22:41:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 31DC180843
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789512106;
 b=M3bo6c6pISQTk14itzZXrnI31uLqlCZxkwJgBh2rXE0JMPXb/Xz7QQyhZmXY9wqgy/o8
 IwSKmlvOC3DThLH3VzkxvYBe+wQvNrujWVb1+rtCmv8BPapJEhhy5oH2xzLKiJXlB/lvs
 XR7S/D2K/J0xrjvWBQKs6up33aIsJQ4K4n3+56SUFStLQVbmOv8OHd8Cx36209I5vmTTw
 eEeFSY3PbipnusCprW3Pq/Oo+olDZUN5AtjKgrwELobz5SY0x0VH+B3pC2SPPehKeSoXP
 hayNZ+Kn4eQk+ffLzTsVC8E3sHjdEV6UQkndNPHJ8HVrHWqAaf58gUZzhA1wAKBEX3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789512106;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=1J6SGjaL/d4hcOGeL/J0zRxlbuss94qadPRVEwmobQc=;
 b=OMVCsJSpzjTzp35Iuu/F4OfIaEGkM/zzz74M6TlusskM8sMz1nrfJ8Luozt0pfPlC6Zg
 S3sgcPCj0K6YfNtL9CrndxBtleKAy3TaHVuANBrmaA0mlTaNatkxSCz1MlFGwjn9qrbCX
 FMFKwlQq4eJ+z+pJeYVDIQX+agI8M4YQY8y/n0Irn4R6IhuVGgWPpMvtnLVy0VeChdWge
 OSg0nU4/1/GGMqXLs1e8b0gerFIHcBrK7iEjjt8yMt8HkXi80MUzMMWbnfHf0sVXmPUHH
 7vdx1yn2XR10owskO3rQSwonC7+qNnahV/scVSvRq9ocGAfozmluQQWbPI36b6KOVjA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QlgdNR8X; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com;
 envelope-from=mibodhi@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QlgdNR8X
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com
 [IPv6:2607:f8b0:4864:41::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 31DC180843
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 22:41:45 +0000 (UTC)
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d45ae011aso2907757b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789512104; cv=none;
 d=google.com; s=arc-20260327;
 b=p9sasF3VHhhxlwJ2PZAKhcyDbcYJNSQNWy50GrymgMP7S1gL+QbwaOidHztlaS7Yh1
 ray9oGWUZ+WCpqRWJdlOjcDqP+i+pJavUvqLYP18JNOpnlXkOxq9FmaVD3C2bcStIXEp
 jrCWBl3uag5pp5MqAjRkwTd64Dd4Sw2nw53IXeHVgk/CIX/dKoy9eVBtTyfrNbExupwO
 AdXCT7dyAJNueB6zA8WdCme7BfgQRSUBuKgPMO2W5uHJkuVnkW+7S36EqZhT5j6uU6NA
 iNQKkfNt3fe4jmi72THZvuRjfB+btlx7PmjjgkrFpVuKhO/h0/f0f1PTcn4S7MwuuLWi
 90zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1J6SGjaL/d4hcOGeL/J0zRxlbuss94qadPRVEwmobQc=;
 fh=+GDZ8QfNoldR/Ju1heMTpoIS6nij8mB2PIP/mD3NpCo=;
 b=K2mOy5qeymEBk1lZuCEKG0hwDwoB57Z2o+gZbqbKd17V3uvZro7f+sESqNwxSxmbzm
 1kQR2hKbvXJVYR9azVpeKwActKBlc1+oG0wsqLDp8WB4tM4mMdsp3CW+3eGd5dOFpnTD
 Ia0mrwgx5Rflv9oUS8N/lToASshkzhelAA1sCS44w4J8A87Fz5Ee9is0aV8M4h72LO5Z
 /zvsU1KvbJwX1mI/Dn7UpVtJnyocsYclZ0pzVlnubmtDHeDmyTXV2TGMTA7UzQMN/nJJ
 e+8ekN1uoAYlrE3jGTtLgOftwd06zPVUaJl/UpTWLoIOKEjhIlpeZ+OX3/2VhY0n75fP
 FOTg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789512104; x=1790116904;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1J6SGjaL/d4hcOGeL/J0zRxlbuss94qadPRVEwmobQc=;
 b=QlgdNR8XZm/5+SSpic2ZKIE19Brs3tCbpzH468oT7F4PzCr3vihsWQ79Ib/OuFrbb4
 DndLstrtGlVJSu89JpKRviSVp9ANwG0v6VY3DmPz4qX36VqB5PIBRaIV+2iHl7gCaV3Q
 M3eSm8oBZDlU7VI8Mani0dSqBZ4J4aeEkoq/czJUApvV3yrExT3qMFhijNOJq1y22MEu
 0ytiSGdjDeGnyxeAc6qHRqYSVAHVRkikrOOt7qaI7wE/ix0oa7Sl9SWmUbQ4JVrhDlTW
 vHf8hXGIdQwg+rwIpzHIlgpmX4GZlkrSrnxTDsj5Z8hzrSSdjQEYfkmiD+G3sHvjY1OF
 nQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789512104; x=1790116904;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1J6SGjaL/d4hcOGeL/J0zRxlbuss94qadPRVEwmobQc=;
 b=qiRdPNdoW8GIbRqH00M5JtbEuCrzsEh+Ey8pInCx3BZq+mqBvH25HhCEVq46fFdRh6
 HfhVfvbw/qMdnkN8HNH7NMxaipj6hvLxF98l7QMbf12goNhDavJ+oIZznP20z/Y09lKK
 CYEN6QQ0GhjTJ+Xv7IjrzRVmSroqTosr4Ao2dxsozJBep8wn9BIa8aOjqDNb20ILjhqz
 ad5YsKm1sDJc+pEjyHYMTisdb8Ppm++Fl+kNKRmK9J4tNq7WtWpKV5gCpiQlFqhjzXQ7
 qOqczg0zi45dnS3dZAK2TLXBb2M3pF3xhEeSqJmRJVfF6uXZnjr2+0clwLQyR1l6KFlh
 1xGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFig7NSO4CyCnIyW2AG19+WL+o1IgkcGsES1bOZz2/iwcmy50BgrgbHWJBp0G3ydHjeP7n6ic=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lYKFSi/duw221qQmPlx4L3j1AQH339BetGTrrZgqH4YSf+A2An
 Sg/AP3+nwwPxb6sitfXbUOBgKlU/+usiYo3CcsxFV7WD1F3f+DCq/w+ZV1627kVd3hda2Zeh+nK
 dzNszrGIe5S4iMW743ZgZGqGQEf7GZyk=
X-Gm-Gg: AYBFou3BWBEIALWoYEn+/77QhYYtsNR0v1yCuoiV45+iicYCx1cuf+1xtli6eHclcJz
 9uuqHBL4Zo+eqF4fkmhrDD3DNW4wL4F/BK+IRG+1RXGyv491Z45+ZaAqn82XYDi9xnPNGO5lABZ
 VlyhB1a08KqWjcrUbeP3mjz9UXAtOXqt1w6DRLkARH+c/r+s+p8lXBpODJRopdDbS8kfu67OKXJ
 5a6GTPXam1dx6B3NILsEjb5sysDi2zhQIOp6VriCv/F0R50hrTLy/wfIYrdtTR3DlZiODaRRkls
 zZ9nn1QMaok3k7A5Av4w3kqUJw1wzg/6mPIMvN+AEf0HJTnsWTDK2Jfu
X-Received: by 2002:a05:690c:dc9:b0:873:5bb2:6c29 with SMTP id
 00721157ae682-89228ae59b7mr1689847b3.48.1789512104277; Tue, 15 Sep 2026
 15:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <aqm9WMSA/H8sJzhT@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260915221246.GF858934@bill-the-cat>
 <aqnDxAE7vFfSm1M+@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <aqnDxAE7vFfSm1M+@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Tony Dinh <mibodhi@gmail.com>
Date: Tue, 15 Sep 2026 15:41:32 -0700
X-Gm-Features: AcwNN1XqVIJQPEjpLdhCiUgPxAKOJuzhyWDVRZKHHMfnviO16wjueCiBzpryd0U
Message-ID: <CAJaLiFxTXB_nTR1nd5xFn5ttQx7TBPF-Lpgdk3CuwzxWY7UGig@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fs: ext4: widen ext4fs_update() block-group loop
 counter
To: Sriram Sriram <sriramsriram@linux.microsoft.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 ankluemk@microsoft.com, v-dmunic@microsoft.com, jerome.forissier@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Sriram,

On Tue, Sep 15, 2026 at 3:17=E2=80=AFPM Sriram Sriram
<sriramsriram@linux.microsoft.com> wrote:
>
> On Tue, Sep 15, 2026 at 04:12:46PM -0600, Tom Rini wrote:
> > On Tue, Sep 15, 2026 at 02:49:12PM -0700, Sriram Sriram wrote:
> > > jerome.forissier@arm.com; ankluemk@microsoft.com; v-dmunic@microsoft.=
com
> > > Bcc:
> > > Subject: Re: [PATCH v2 3/3] fs: ext4: widen ext4fs_update() block-gro=
up loop
> > >  counter
> > > Reply-To:
> > > In-Reply-To: <CAJaLiFxMbEO1hk0o6ja6w1SKN-hVK4tGkvUo90uO+eFgAc631Q@mai=
l.gmail.com>
> > >
> > > On Tue, Sep 15, 2026 at 02:23:12PM -0700, Tony Dinh wrote:
> > > > Hi Sriram and Daniel,
> > > >
> > > > On Tue, Sep 15, 2026 at 1:52=E2=80=AFPM Sriram Sriram
> > > > <sriramsriram@linux.microsoft.com> wrote:
> > > > >
> > > > > From: Daniel Munic <v-dmunic@microsoft.com>
> > > > >
> > > > > ext4fs_update() iterates over all block groups with a signed 16-b=
it
> > > > > loop counter:
> > > > >
> > > > >         short i;
> > > > >         ...
> > > > >         for (i =3D 0; i < fs->no_blkgrp; i++)
> > > > >
> > > > > fs->no_blkgrp is a uint32_t. On a filesystem with more than 32767
> > > > > block groups the counter cannot represent every index: incrementi=
ng
> > > > > past SHRT_MAX is signed overflow (undefined behaviour) and the
> > > > > comparison against the unsigned no_blkgrp never terminates correc=
tly,
> > > > > so the bitmap/group-descriptor write-back loops misbehave. The mi=
xed
> > > > > signed/unsigned comparison is also flagged by static analysis.
> > > > >
> > > > > Use u32 for the loop counter, matching the width of no_blkgrp.
> > > > >
> > > > > Signed-off-by: Daniel Munic <v-dmunic@microsoft.com>
> > > > > Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
> > > > Reviewed-by: Tony Dinh <mibodhi@gmail.com>
> > > >
> > > > BTW, since you are testing this ext4_write, it might be worthwhile =
to
> > > > see this commit:
> > > > https://github.com/u-boot/u-boot/commit/53cc4332b3b37218a7cdab8bdb9=
53da57eec2668
> > > >
> > > > Thanks,
> > > > Tony
> > > >
> > > > > ---
> > > > > Changes in v2:
> > > > >  - No change, rebased onto current master.
> > > > >
> > > > >  fs/ext4/ext4_write.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> > > > > index 1abedcede72..2fba2197c19 100644
> > > > > --- a/fs/ext4/ext4_write.c
> > > > > +++ b/fs/ext4/ext4_write.c
> > > > > @@ -67,7 +67,7 @@ static inline void ext4fs_bg_free_blocks_inc
> > > > >
> > > > >  static void ext4fs_update(void)
> > > > >  {
> > > > > -       short i;
> > > > > +       u32 i;
> > > > >         ext4fs_update_journal();
> > > > >         struct ext_filesystem *fs =3D get_fs();
> > > > >         struct ext2_block_group *bgd =3D NULL;
> > > > > --
> > > > > 2.49.0
> > > > >
> > >
> > >
> > > > Reviewed-by: Tony Dinh <mibodhi@gmail.com>
> > >
> > > Hi Tony,
> > >
> > > Thanks for the review.
> > >
> > > > BTW, since you are testing this ext4_write, it might be worthwhile =
to
> > > > see this commit:
> > > > ext4fs: Fix: Read outside partition error (take 2)
> > >
> > > Thanks for the pointer. 53cc4332b3b is already in the tree this serie=
s
> > > is based on, so the read path is covered here.
> > >
> > > What caught my eye is the note in that commit message:
> > >
> > >     Looks like we also have this overflown problem in
> > >     ext4_write.c that needs to be addressed.
> > >
> > > As far as I can tell that is still unaddressed. ext4fs_write_file()
> > > has the same wrap you fixed in ext4fs_read_file():
> > >
> > >     long int blknr;
> > >     ...
> > >     blknr =3D blknr << log2_fs_blocksize;
> > >
> > > and on top of that delayed_start, delayed_next and
> > > previous_block_number are all plain int:
> > >
> > >     int previous_block_number =3D -1;
> > >     int delayed_start =3D 0;
> > >     int delayed_next =3D 0;
> > >
> > > which makes the casts at the put_ext4() call sites
> > >
> > >     put_ext4((uint64_t)((uint64_t)delayed_start << log2blksz),
> > >              delayed_buf, (uint32_t)delayed_extent);
> > >
> > > ineffective, since the value has already been truncated on its way
> > > into delayed_start. The fix would mirror 53cc4332b3b: lbaint_t blknr
> > > plus a separate long for the read_allocated_block() return and error
> > > check, and widening delayed_start/delayed_next to lbaint_t.
> > >
> > > I am happy to write that up, but I should be up front that I cannot
> > > test it. The largest medium I can reach here is well below the 2^31
> > > sector point, and since this is the write path an untested patch
> > > risks writing to the wrong LBA.
> > >
> > > Would you rather take it yourself, given you already have the DS116
> > > and the 4TB disk set up from the read-side reproducer? If you would
> > > prefer that I send it, I can post it with you on Cc and leave it
> > > pending your Tested-by.

Unfortunately, I don't have any free 4TB HDD left to test with at the
moment either! That 4TB HDD is no longer available.

All the best,
Tony

> >
> > Hi Sriram, your emails keep having some header looking content at the
> > start of them, what are you using for an email client? Thanks.
> >
> > --
> > Tom
> I use mutt. Sorry, I am new to this. I will be careful next time.
>
> Thanks,
> Sriram
