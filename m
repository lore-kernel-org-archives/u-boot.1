Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019C606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zj31Ohs/;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yuXii9Y6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84C7C4095C;
	Thu, 26 Nov 2026 12:51:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FO7XlI1N5Lw6; Thu, 26 Nov 2026 12:51:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A036440934
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795697514;
	b=XsgJVUGqBi3I7k3vdF0rLlmcdP24G9emzBURyKzsF9PHsA2cXAEqZiRtDBW+jnSmcgUL
	 Oa/Yc/E3fEHJBWmMS4Tzq0F4HLbWKxUYB6beecvEgwAYgn1RgVS6P56wZuAV1cgK2+1n2
	 wnGM6S8VNk+29zyRjeDZiiihnzN3I59WbvqB30xpqnsY95VWLY5kcbsUpSZDdmug+UEDL
	 6pBBOx+M9AXThiDHiBOAvveWHom9dQeW7pc3PeJ/NlyaS6bB3HrVfh7UOrl0mtwrytymv
	 NDI8mPOmTKBtdVVmvefH0z4ToWENKjER64Ol8sTj5j9/Grs6HycPmZqkJdeviGNrRLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795697514;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=D5pJwGbniERC+jbN43E6LneWDRBelabaTVAElNSBCx0=;
	b=rSHjNnkSgx4JKG8pH+O3WPDvhcOECu2jK/W0GgFZYKtbTQKVGBQFN3fD4mZfSqaw6AwG
	 mkw5NVYe3DqYXi3zq8sTONI3spG43ry0JmlFmnqRzYvlXpusUxCyFVVu/MROWEjc57D/4
	 bP9p/7E+bCZmoa9QwkNiF9k2pCBSmHNP7CzBt4Y6EOOwPCNJRdd2xdNyruNogDesakhkz
	 /2SzW2GA+cxGVX7vi5EFsZRDfT5NwwQAL4AB5DiIxUWv7gr4ds1tpeH2pI3HN4yu4Gjc7
	 GHsCpA4fWSwgKdv06FRXSuWY4Z+L93DRB3sEfBM8BvwDeL4X4wLl1q5yC0eawez6Fpw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795697514;
	bh=D5pJwGbniERC+jbN43E6LneWDRBelabaTVAElNSBCx0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zj31Ohs/X7I3k4xqYSLTGGmE4Q4KbKTZXU51emEznPtEZaQWLmMk+4ZP2EKGmlwj0
	 UmN0twdjq2mKIwFg6mnfsmdKedS3EeKDAKmg6ul2JnG64KnG1oN/3FVymVZQA/DT1L
	 YDKDPAMfL5cQ3XZ4NF7FPlT7a7aTI42L053cBkHHlToq2qq57PDCwBKmBFh2i1uQQB
	 t859x8+3foCrU7MSD759TH5A2YJq8fahN0odeWEtL0xIODBYzwShjBf5i+2xaflill
	 uTmjGu3aZ5CMXzi9lNcL7/+P/BxhX7LZS2YAi2mAnuPeaWeUNIhn/mkZQU9BhC5MEM
	 2Og9Vc3VRSJZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A036440934;
	Thu, 26 Nov 2026 12:51:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D96D2DF
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5336981127
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:51:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HklxtQkRQMQP for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:51:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4C98281108
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::831"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=yuXii9Y6
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C98281108
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:51:52 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-5569551d19dso81471431cf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 04:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795697509; x=1796302309;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D5pJwGbniERC+jbN43E6LneWDRBelabaTVAElNSBCx0=;
 b=yuXii9Y60DL45RE4qKm6OvBxGxzC0a4Pe4knjutAGdBtE8SdwdbwhjO66qQBZrmZ6/
 xkzhKbQxLoz1fb/Vj4vgt7rOME3aEN+vu8tO0Q7pSh6Nn8HCt1GPoiqTsATA5mcBMFWO
 UMlq+RLvtiSsvwgGLDFNmiNXk66ScHh0OewABkcOCv+FPGyY9422+M0p9hs+I3Ygdns+
 hTQPk21sBdV/AGwaEDvPajZ0h0ZRPXg199hbrbQ5BcuVbDIQwmCjS62kEiAV7rbIm9FR
 s3kS8Eft3MMTfL5PI2qb28SkGxSjUdg3NXBUDoWZ92N00kSf4t3GDhy4j6GBXcs4Qm2X
 fZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795697509; x=1796302309;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=D5pJwGbniERC+jbN43E6LneWDRBelabaTVAElNSBCx0=;
 b=SwsafhUxYIdLOT4LTlgTWWA1HOUpJvNtrFUkhniknoJa+UH0yySt0I93MSlbl9Gf0S
 CoJAzm2aMVsdfUbt8aEUgzyrQvp/oUK/tZsqKySEr1JhPTkpOqOxWIxdwcCbhkHzFjX8
 kWScLwlyW/WJkYvQGZg8V1/QB9wqRYdur/U7wgbQQHsl8iFp+vKeaObRkiXiU+gF4Myp
 9Q34+9X+S6TXR4b78Y1mkBi9B/4aUiVsubphOpfsgezOe8WAPPxoMWQZW5QuS1kKreaK
 +iVgmE/MaQZEQmWS91og4NemUQL7VdR3MvWVck+ZY4/Tz7m0QgZGdSX4189JvZU2i6qQ
 +osA==
X-Gm-Message-State: APuU4Z/1u+DygHZAVDsjL6Ey16t2dxBO1Wf5rOMgaBJ4KdngKv3WAPM7
 yhb+wun/I2EetS7TgYT3454f8KylPl1EApxXhkZz/ZbY8Y5JU2BNmrS8zODca8x+L3HJif8/qTW
 MVUC6LhuFuHYCjgMLPRCiDhLHbfq4pGg/wg==
X-Gm-Gg: AZFdTZchFhByloZdl1IajTHWs4WKnw0fvgXK0gl4kTnfr9Q+TNuMfh/6lmD8uVj/MvR
 Ox2BoNfmpm7j0G6kMwTHqUFgGjYnUqqwKSSG3WSi6bZG5atzzrWoPCf0qoC+AGtSPaYCk0DHAAW
 b93A5ywzRdK//c6Sl6bpEiHttuwOxirS5Tsf9C3hgg9/uGJJ8e7zZz63XSESYwLqM6Bvamsi2al
 9l/gaoit/r+S3X2kXz4JO2M7lOkLtliQmzd/QdCU4NnpjGvman0fcgzR4S95OecF3SzEoz399i0
 ObTO/lpaFB5oSLvmMVW3naQGJUjHL17l89TqQpXZdcZbcZk0OEDbSQ9w2Jn1HGhx+vyau5msDzN
 YX2VcebgFHMaUXV6fOpfgpZunsvcjCV02ifoAucerUvvuVq079AT2v1UUH8kNuxIFaMFT1R5u8I
 c//RIHwbSprrRyvGnb83vpkhn0q15mcFspQ1/x2QED782yT68qacsYJtdI3SaWIaaRtDC4/5gBA
 KRtXepZpW3iOS5SPFvORaGcKVL2ZHJ9qMU=
X-Received: by 2002:ac8:5a0f:0:b0:531:2eb:be76 with SMTP id
 d75a77b69052e-55d6fcf94aamr395045361cf.22.1795697508822; Thu, 26 Nov 2026
 04:51:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261125134317.2479815-1-trini@konsulko.com>
In-Reply-To: <20261125134317.2479815-1-trini@konsulko.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 26 Nov 2026 12:51:36 +0000
X-Gm-Features: Aa3M54pjQx6vTfgbIasi8OYRPyQhqQTPN3QXH-W7V27meEK5TU7j1F9kboCEZFA
Message-ID: <CALeDE9MvMg0o2jJUhMQjfej+J85n-tiMecHLo56WX83DJi09rQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Dockerfile: Minor robustness updates
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="0000000000002336b106612d68e1"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000002336b106612d68e1
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Nov 2026 at 13:43, Tom Rini <trini@konsulko.com> wrote:

> Hey all,
>
> As part of rebuilding our containers for CI again, I found two types of
> problems we need to solve, to make building them more robust. First, it
> is possible that our toolchain downloads from kernel.org mirrors can
> fail and we weren't catching that. Add both retries and an explicit
>

What's the advantage of using toolchains from kernel.org vs just the
default distro toolchains?


> failure for that. Second, we should be cloning only exactly what we need
> when building qemu and grub as they are big repositories and doing a
> full clone and checkout is both wasteful and can timeout. While doing
> this type of change I also updated mkbootimg the same way.


Similar question, is there distro qemu options we could use that provide
the functionality so we don't need to build at all?

--0000000000002336b106612d68e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 25 Nov =
2026 at 13:43, Tom Rini &lt;<a href=3D"mailto:trini@konsulko.com">trini@kon=
sulko.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hey all,<br>
<br>
As part of rebuilding our containers for CI again, I found two types of<br>
problems we need to solve, to make building them more robust. First, it<br>
is possible that our toolchain downloads from <a href=3D"http://kernel.org"=
 rel=3D"noreferrer" target=3D"_blank">kernel.org</a> mirrors can<br>
fail and we weren&#39;t catching that. Add both retries and an explicit<br>=
</blockquote><div><br></div><div>What&#39;s the advantage of using toolchai=
ns from <a href=3D"http://kernel.org">kernel.org</a> vs just the default di=
stro toolchains?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
failure for that. Second, we should be cloning only exactly what we need<br=
>
when building qemu and grub as they are big repositories and doing a<br>
full clone and checkout is both wasteful and can timeout. While doing<br>
this type of change I also updated mkbootimg the same way.</blockquote><div=
><br></div><div>Similar question, is there distro qemu options we could use=
 that provide the functionality so we don&#39;t need to build at all?=C2=A0=
</div></div></div>

--0000000000002336b106612d68e1--
