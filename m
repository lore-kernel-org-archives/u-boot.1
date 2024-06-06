Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A7AC27C52
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 21:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 703B587DEA;
	Thu,  6 Jun 2024 23:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dx3n3WB2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B78C87D40; Thu,  6 Jun 2024 23:16:27 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37037883CE
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 23:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wjq.sec@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-794ab10d07aso77195885a.2
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 14:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717708584; x=1718313384; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ocKWclpimcqGpF4q8B0hgOcJ97NCqIdPHaLuETJP+Ns=;
 b=Dx3n3WB26pmMcgpgaoWXanYxyHWSigJoAjyUyfouflYSVJN89yxnVD/6l1StLg1Fdx
 q+OuimoS/5s6gJjymGQiMMW7c08N5i2gri5fb5prvAWxJOrF1cmykayhl8elf1/84OHf
 MC+zM/+OlCZoSz2gVl/JRQ66NxqDJ3w9lry+0Fu13e/GnlSAOK4T+v42ACyoq2eg+oTA
 JSTo/Q8Faae8UIA/uoC/+iV7359Vy2wIzDwoCgf6wCvdmW072EwUs+hTs4iAmzXPDpAF
 8yWZfcd8INa0ysZe7DcF+zk34JXpF1LOt3aiiHdZ9vvNhQEm/PQ+p+A9Sz4yyvyA1VC8
 APrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717708584; x=1718313384;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ocKWclpimcqGpF4q8B0hgOcJ97NCqIdPHaLuETJP+Ns=;
 b=IlSaj3ifc0YbUylMz/lWQX+DikMDUQnb3mxtVUJdbi7v60SdDitj3mTAUxAOGT/ZRM
 d9jUOHTLljOwjiqO4eltMWvJ7tYdNjGaiQBhPTqze516Jy0TtFzxgHUsf7/Rf5YFFCmB
 H2Dc6yLrpYXf8s4RkxGPE+2EnUMnAShvSGvF+6FmpNbgw/yHew7aGkQA7UhNIsgFBugJ
 DmHEVEJ8ZRDtb/65Q4S59Ttzglm2M5XsmtnwC1K4NnLLrIC0x5tDU5Q46nRcojHPsmkc
 3iC8LqgiLY06TgOb/6iglJa5e+EvZi+wzLetWum1FBVAc4hlfX9mWNE6ZGOKSjBggNsH
 aDQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqgQy/YPzmLQFqRcEkLDPVayk3Cl4emnFxxujgz5KBALSq/++tcxMG5QArInNH8RYVWbdhnfS4WFSk4WvPgoy0Sz57nQ==
X-Gm-Message-State: AOJu0YxLksMPVt6vGonOljjSUiOuyp6qlxkfZO7YhOLyzy8S2MIQ/IY6
 UWfd8103ONlGEj0C1juIzgd7yaU41XMDpauBIsWpEtyuDBe1f5no5Zs9ooJgoRE1FBbiUeFehRj
 FDmQ3YVbxAOvmCyBU3s/vyUYm4s/vug==
X-Google-Smtp-Source: AGHT+IGRrIuln/arXnLom7U9T4ahWYuBukvAJnH14zpqwxWbuDcHpkGPuabOp7+m+wf+dGM9piiU1rk33oFPJsW8WlI=
X-Received: by 2002:a05:620a:1a89:b0:794:eff8:7058 with SMTP id
 af79cd13be357-7953c45e8d7mr75546985a.33.1717708583833; Thu, 06 Jun 2024
 14:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAMn3X6ODsCzBdpJC-PYAA_Y9WrK4eN84KatHGe-aEQB0yG=fZg@mail.gmail.com>
 <CAFLszThz1m27488Mc9SVncfUoN4jS1Cr_sQTZchS6NrsL6vwsA@mail.gmail.com>
In-Reply-To: <CAFLszThz1m27488Mc9SVncfUoN4jS1Cr_sQTZchS6NrsL6vwsA@mail.gmail.com>
From: jianqiang wang <wjq.sec@gmail.com>
Date: Thu, 6 Jun 2024 23:16:13 +0200
Message-ID: <CAMn3X6Pm3jTFOLUAie8JL83pqvUvSkq6ninxByswoaRp2KaC8A@mail.gmail.com>
Subject: Re: Needs a check in the device tree
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

hi Simon,

yes, you are right, I forgot to call this checking function, thanks!

Best regards
Jianqiang

Simon Glass <sjg@chromium.org> =E4=BA=8E2024=E5=B9=B46=E6=9C=886=E6=97=A5=
=E5=91=A8=E5=9B=9B 17:04=E5=86=99=E9=81=93=EF=BC=9A

> Hi Jianqiang,
>
> On Wed, 5 Jun 2024 at 07:40, jianqiang wang <wjq.sec@gmail.com> wrote:
> >
> > Dear Das U-Boot developers,
> >
> > I found that the u-boot device tree implementation lacks a check for th=
e
> > off_dt_struct field in the device tree.
> >
> > In file scripts\dtc\libfdt\libfdt_internal.h, fdt_offset_ptr_ returns t=
he
> > dt struct address. It calculates the address by adding the header
> address,
> > fdt offset, and a specified offset. However, the fdt offset is read fro=
m
> > the device tree and lacks a proper check. The returned pointer can even
> > point to any address, leading to arbitrary read or write.
> >
> > Could you please confirm it is a vulnerability?
>
> Doesn't fdt_check_header() help here? Where are you calling the code from=
?
>
> Regards,
> Simon
>
