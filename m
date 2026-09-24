Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8352C98311
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 10:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A3A760BA2;
	Thu, 24 Sep 2026 10:37:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EXdjPXwqd8zz; Thu, 24 Sep 2026 10:37:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5040360B59
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790246234;
	b=Kj4w7kSAHNooMfcd+6fGD9D9Rx1spZrvQ4tmsHfgqur57mwa0/LrYceUphELomPu6Gti
	 lhcMnnGg6nrwVhS6a0qKqxsfOj0RAWWduTWqyrv8f8YnfPbkJHaEuzqPCGmYjtB/Z8TyR
	 PCO/Fs2qIguwPGsSmGE5rlpXxtbhf/q4k5Q7nxNoNpIXkpfGs9N9SxYN3bPCtiA4hRtFF
	 2LBSWA4SLPrsU/tFuPEce4ZOpXBHvp9h/PKueH2K7qruwJJ6lkSybz4JKoUpMXhT3nBaW
	 eaynxUY6f3zp3x1iVz5BSkFgUvWa+vwHIn4fVFjVuYNYIKDUM2lHZvq6iz6k7aHiXLQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790246234;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ahYi0fUkYCwgehSBfoaa2xKOXClPDu0sBYdJi66VXPk=;
	b=Hj5dLrUT673egKenfISKPKUrD58yu7kBkn2mex1iuLLgeThvgGNVvayHusW+9QBnH42t
	 8IymDamrLqjt1fnVYBAFhpijB0xkjT5T44HR4rPVodMuzZ4y1pFwzpvFticHJOse25YlY
	 Vjc6mN/I4PFRhsUWyeKwmyi8OhgzclwV0GttzWgvx3iYiOR34SRqKDEYzwOmrUK/RCQhz
	 Ul6JyxrlWz9Ver93pTuO3EfTjspTUAy479KYWGuu5vEho59vgJJfGBeSiYc8eQWR7iELx
	 CD4+nQIi3PnaQ2GuSiTs0NuPGxZvlf5Ljtj7S1HAkwFekbfHI8pKvWjVI4ZXqfyPiVA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CSridiY9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790246234;
	bh=ahYi0fUkYCwgehSBfoaa2xKOXClPDu0sBYdJi66VXPk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HCnsp/S7LyxJt5DFVNHfyVCHOYf1uUTpIz5du8yGO3WlNBtUVXEa49PyjI1XOSBo/
	 y6jdQiiViykm8C1nW7/gyQAPC+YHIzv5qA8LkcR5ICtILd2RNTC3aG9Tb7UXKHVOGe
	 ZL7MPfHCzkwUl1qvt7pLWiw0rGIGcS5BPFkuTdcduH27PLaAXzU+a+Cyr0GKNz2scW
	 MCaycrABRRpOnaggi+CL9XKe8otiIri4GoHrJ1ajiZCFJNOvKdpLOeAUzz4qvGJa/X
	 hDoZDkS3SK602mSKqhmekch6msOQf6ClrVqdI1aPuH1AKd7VI55/ZmjYZp63RvO1OL
	 BKhcMQQ/9jDjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5040360B59;
	Thu, 24 Sep 2026 10:37:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BA63F392
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:37:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F4D160B59
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:37:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aaLdBhqyrZiN for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 10:37:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 45666607EE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790246231;
 b=OU4NOkunHan03S56qi8B6+O0uPlzZRaAuhzkbfj70odx0p317l00MQRnFh/r8Iy8F5Ye
 0EH1xs1U0z4wJOwqFU3A3Z8Pov72WiMCdrqnn2Swptf0Ikl/D/hYDblEV2+NdNiMAhy00
 5z6tQVRQXJxpMn5VCW7spkTlWuDmb6MSiG5UBNXI2m5HNYb2PA1wC5L8GjEhBNSncJlDl
 xka4UWeBZ3dn1SxJRl5DEGqtygZ96h1Or8a/kRUAui8q48TYMbKupLxuI3MVtbtctdR8L
 cP+8uiU/PS3O0I+1jXs/jW05n+1uCE/29jkWzSair/l8NgH20nMxxdQAg1tsMsbAO3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790246231;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=ahYi0fUkYCwgehSBfoaa2xKOXClPDu0sBYdJi66VXPk=;
 b=pDsBzoQH005K7hHjRhi7AsYxiffw0TmAk+KYLkRt62falCQ4wz1jHHk4qlY+hA6Gu0pS
 CgCaly0s4dnh+9EkxU9TGMjNvPIFuW7D7rzX6efzM7TMeLORXlYpVvflgUNItu+ADfiak
 ewgqPUbiUyDXWf2V8H20FQC3CFObWfsjOrMHPifZ91yCkY2ziK/aWZgoHyOTr/qSE0ywx
 qSfDc3ETVZ2tDFrFjNxe1yetyG5fxA8wlVKT2yCe8Ne2johEecumGmK30/O8tOQ5ULbnF
 RemIMjHbDuQud05FaBVqp9p+JpviCMiDPOBOcqwZ8YrSaC+2XhKUP7SrcxV5wWZhlsg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=CSridiY9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::f;
 helo=mail-yx2-x0f.google.com; envelope-from=ilias.apalodimas@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=CSridiY9
Received: from mail-yx2-x0f.google.com (mail-yx2-x0f.google.com
 [IPv6:2607:f8b0:4864:41::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 45666607EE
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:37:10 +0000 (UTC)
Received: by mail-yx2-x0f.google.com with SMTP id
 956f58d0204a3-67109935888so1794035d50.3
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 03:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790246229; cv=none;
 d=google.com; s=arc-20260327;
 b=Y5dPGy/5u6cx5q3KY3+WfpTQ8wLhVLLZnhiyXYXJZeFa7y+BSb6j0ihybq7FcUqjub
 sJp58Lp0HQzUUZ+MQAhw7lsOiFq2SoIcbuQ1pr6ZzM/OPDEQbeMknZQdFUItPw/pCswi
 nCRowzLICWrE0c4sbjc5ANJA6m8SDc/fe9A16s0jDOr828GUQHH3SsOng8j1QT0wnjNB
 tCMyI7xw38L6sWKHY8qBN+9BCpN3YofNB4q9VGTrcewjFaLOd+d3z9vADm4aoMLLUacQ
 uoeSnpyL4fk5Iadxj9pJbwdy/0Gh1bQNhPudZILuaZq7+PsFOMMibfiybBFu5GtQk0+H
 hTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ahYi0fUkYCwgehSBfoaa2xKOXClPDu0sBYdJi66VXPk=;
 fh=h+rwGXxvSE6GO9bg3L7pVPZcagW+KcwIGT3q/VkS6rY=;
 b=qF/KBb8F/cR4zvHYmh0eLIY6MJ15w4dghtx6izWDuJhh+tnngU+/zRkEWvXSdMi3U/
 8l1DI6VG56ZJxAA1BcUyPMpunNrHqgEFl12naojy/VJJWsb+pV1CuC/E3y1H7H0jS5/R
 0AM3X5esOy2XJyrkyWtaWTh1IpPvftR069mR1YjXydhRd3HCrLmN+dPD9tBm09KC/zbk
 JEW/EvBUBV5CR5Wph2ylcnTxdRsDZwCnD+hfJYkcGkUUxroEmA89o6EplXq+g49oSzck
 j1VlgAKQjq2bpzIzZF3VguM9CqNVxqNZc0GTuUmqGrlamMrxsth/9NulRosxu70naJ7U
 BaOw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790246229; x=1790851029;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ahYi0fUkYCwgehSBfoaa2xKOXClPDu0sBYdJi66VXPk=;
 b=CSridiY9Y2goaEZEAh9niN1KdckKLJMiEwY6XTmv51OPwlDLw35udrzvIFiYyASjRR
 PctEBD5R2zB+hMWjhIvo5NN6wSvhLFv7DwuWQ02O/v7N/bZviERF+QciEYOYczvEp5nC
 E22nua4Hpc1Gjr8O3tpHNLq0x2hr5oQiYz8tknthCS+PgD7E2rtyyYwPiFEFIQ3hnxAw
 Ot83+uryfjNH4COD62Cv9f7Zmk8HmnI+Hl3G0CD3Vf36T7jK3lT32/Ozr3ehMWBviL9i
 zUh64h/sXwiPORWSlnK3m+/XzuRU4dCvZxWbIJSv+J4qC4Rfqlb5EJC2lXyoKszbt1SK
 4g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790246229; x=1790851029;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ahYi0fUkYCwgehSBfoaa2xKOXClPDu0sBYdJi66VXPk=;
 b=rZcJhC8d6QAuNUU0Je1jTGOPeQV4sxJTsetxJxG6XMiW4FtLRSGErPMlGxYjqNbzrD
 EdustR5yiMe6uBn+yUFbBZ9ovmAEsVqHn/Oqq//RVGgRXL9gm6I4EEmBxwrY9rAn3+A2
 QhsZPIm/AVN0LpOkkpfOK4GXo8BKVANYII8zWGMkBvjQnKaACBunc69Zqb/Bo52wPcKM
 hb2HXhAO6p7AO7lKuGpiBcsHfcQMZWcT4u2ao3zKsbc0+IcHvqPTcUchmL2faD3ZLqBK
 iYgAbdlSeJlBU7qwwHaTYdNx21MFNYp3g33rw3IdEHReFoDzRdwL/5JS4n2lHCTjTKSs
 8QbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwObHRWI8vk9IpN7rtyceedcdha9t+Y1e5IzIwtaYEJVm0hog1TalLnV34s8KjM0Cuvk/sKEFk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mLKTX4BmbFSQRljq44GUYIvanUoHYy1Hxlc9wM1GuZ63qZNzNE
 No8YsLb7JIl525cY2dtLc9YLVon5WVNsWnfLn+edP9MDc5Tg8SMJPXesTU4Z5MbVLW6ezBhCmBf
 E5G356QWpTJPcuprlaB5yotwritYRT+4Y8X1B45D5Lw==
X-Gm-Gg: AYBFou0BvFJFtIh77VN1AkrursoBk/ktHyg39Op77RJskuAabO7v4d7m023V6vsImBG
 lahZPueXSapmEh57EhHOLSP1rvgdXf/0w+wf6wjC/tlAg9HeMbhX9GJtgGxkMBojwDTiT4mjLYR
 sKYTXJl4xlcw78P4NGyhbjpyYZXPqPPTjaWf0AuUbXZbUSqv49jqFxVYGQIkEnN0zVZnsR3z0Zt
 lsL5yPtXiJYYWmVnr3IM1LX61bK1rVGdb5b1tby+ISFBYlHre9C7/5T8L6XmMn4l52OqpVqsFf8
 7xsHII7iCI8uu+TjuWtBmxXM6NieW2YGUza4oTujC2ZW6xqrkMTP+Khtw/pacDunGGk3hmQWAKI
 NMOsW7eNjULyJcOPUoCqbo5JViWWcwISKZeAjKAdBpR6ZsdGHWPe9h0KZ991ei0kZFsWinHVrTl
 J1JMEJBFRN/xAo5UjKINY+Ed+VwN6t/br+4ei8djysUeBbQGVYxlzdsYoyMtg/qmya3xKZn+NG9
 9EFF4Jbcyj7Fh+1ehqTJUx6sB/+GTRCmJ4BcRvlpGirdwuVcNYPMDBHmfkBrE5T7eyPtxbrBWg/
 hfC8pfdLzhrETyvv5PPiedqVDMCw5mDAMjA7GMBQhXJ2XTFB8nGcWwKtB56oWkJGOnaih1Kvbnc
 Xamvvmc0S1ViRnCw64Nb2gxlOT0bYfsrFiavCIjYQsn/FTz7aWBgLT6XenGMikfaC
X-Received: by 2002:a05:690e:11cd:b0:672:b91a:ded with SMTP id
 956f58d0204a3-672ed1e41b6mr1252349d50.33.1790246228852; Thu, 24 Sep 2026
 03:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
 <20260918175345.GT858934@bill-the-cat>
 <f550f27d-55ba-4d10-9b1f-d3712b6967ab@embetrix.com>
 <20260921202435.GC858934@bill-the-cat>
 <8953c3f1-929a-43ca-8708-712a45db9c77@embetrix.com>
 <CAC_iWjKDX2FdzrpW0JxJ-tpj2PksNY0gDyoXz3_T_QRrjaoyRQ@mail.gmail.com>
 <40b6ce4f-ac70-4d37-a3b7-c784c9c75471@embetrix.com>
In-Reply-To: <40b6ce4f-ac70-4d37-a3b7-c784c9c75471@embetrix.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 24 Sep 2026 13:36:30 +0300
X-Gm-Features: AclHuK9t-aLVUcRPHc6SvTSQupvDNVdgEInZRosIz3e5-ungQAckOiHSHY2Xv50
Message-ID: <CAC_iWj+ofe4fbY2yVc3qzZmxwBprLem-urjepKtVg8ORtiT2Fg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] crypto: add FIPS 204 ML-DSA verification
To: Ayoub Zaki <ayoub.zaki@embetrix.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 mkorpershoek@kernel.org, sjg@chromium.org, marek.vasut+renesas@mailbox.org, 
 pbrobinson@gmail.com, dlechner@baylibre.com, hs@nabladev.com, 
 xypron.glpk@gmx.de, heiko@sntech.de, raymondmaoca@gmail.com
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

[...]

> >>>
> >>> Well, a problem I see is that this is something that needs active
> >>> maintenance to stay in sync as we don't want to miss important fixes
> >>> here. In theory, we get that with mbedtls (even if we're behind atm..=
.).
> >>>
> >>
> >> Agreed. Importing the Linux implementation means taking responsibility
> >> for tracking upstream fixes. I=E2=80=99m willing to maintain this code=
, track
> >> changes to the Linux implementations and bring relevant fixes into
> >> U-Boot. I can also add a MAINTAINERS entry to make that responsibility
> >> explicit.
> >> The goal is to prepare U-Boot for early adoption of post-quantum
> >> cryptography in secure boot, particularly FIT image signing and
> >> signature verification as some hardware already ships with PQC
> >> capabilities.
> >
> > There are zero doubts that this is necessary; in fact we are already la=
te.
> >
> >> The intention is to switch to Mbed TLS as soon as it provides producti=
on
> >> ready ML-DSA support and the required SHAKE functionality. That timeli=
ne
> >> is not clear to me yet so I=E2=80=99d like to prepare U-Boot in the me=
antime.
> >> Would this address your maintenance concern sufficiently to proceed wi=
th
> >> this approach?
> >>
> >
> > I can try to find out more about the mbedTLS roadmap if you are still
> > interested in going down that path. Arguably most country legislation
> > is looking to enforce PQC by 2030 so a month or two won't kill us.
> > There's another benefit apart from the 'less maintenance' when using
> > the external library path. IIRC, there isn't a single algorithm
> > acceptable to all legislative bodies.E.g, CNSA 2.0 does not adopt
> > SLH-DSA while most of Europe does. It would be much easier to use a
> > library and select the desired implementation (even stateful vs
> > stateless) instead of importing and maintaining everything.
>
>
> Thanks, any clarification you can get on the mbedTLS roadmap and the
> expected timeline for production-ready PQC support would be helpful.

Will do

> Separately from that U-Boot currently uses mbedTLS 3.6.x and moving to
> newer 4.x involves the split into TF-PSA-Crypto as a separate submodule
> and incompatible API changes. That migration is work to consider
> independently of PQC support.

Yes last time I looked the gap wasn't massive, but it's there and
indeed frustrating.

> Let=E2=80=99s revisit the PQC approach once we have more information on t=
he roadmap.

Will do get back to you!

Thanks
/Ilias

>
>
> Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards
>
> --
> Ayoub Zaki
> Embedded Systems Consultant
>
> Vaihinger Stra=C3=9Fe 2/1
> D-71634 Ludwigsburg
>
> Email    : ayoub.zaki@embetrix.com
> Homepage : https://embetrix.com
> VAT No.  : DE313902634
>
