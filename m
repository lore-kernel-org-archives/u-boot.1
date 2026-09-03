Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3927C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:37:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5181B80F48;
	Thu,  3 Sep 2026 14:37:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s57ZlfTrSkRH; Thu,  3 Sep 2026 14:37:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EEBB780F26
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446261;
	b=oEtX4qNT6nixEkcQ3MAUfVn4VHmvjEH31oqaj5cOoWi2yaXHC182dV3e9+xWlU2PDcSO
	 GKZVhzIbJ1jMdH6MDHUvfytJYzTCu/gxoD+2xXqsSL3Qy/AyfMlNdS0p6mLP3ayQfvmxv
	 GA2MgCq2DeJ0KIYw1n1SntrvqB4J2vsioQnP4J9Emn+T8X7DHTHDhRv+wTtSLmtx3nq8J
	 Ho16zM04gN/IDJIQm7KGYc6lJzVIBR0mr6QvjL1uXNu93rRLdrMA8ZuBV8xC6dYHYYJWc
	 qEtCFjQ7WPqlh3krTTM3aQSzWqj3hQsqnatUT98taYJqsopSC+Jc9Xe+wc+TkwxkLbQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788446261;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mE4uMcgKwQ9NcSAkjbg9IHEU2CxW+51N8uOn/Ypgf84=;
	b=UZB9FaVczDB+XUIUAO+PG/XX4QHCJlSlKUG1TFwWznMoLsAWZbsrCBfMhJwXegKc/cvU
	 YrCY78pLqHeKj10x6MtopLwVUjafmeRnUzhKAv0egur9pbjcTDA+voJolzjdhjp5+wRmn
	 mDW/MlF0gZjQLeLNcWQbHUR1t7FPuS1mDFA6UmyMHnA6ut7hjplKW+ft/sX1j9+si3ip8
	 bxosv3fzaaaigDlRjQbrmczsibIcpr9dEsSSAEqBcOyMTxzvPvG92e/TtyctIH9lDs1fx
	 V33uJcRCP1djPCjMzbKdYTxSDy5IYeWGjAJ3hCgbGU9nm+s4poOTvy+B8LqQZ2xb9mg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788446261;
	bh=mE4uMcgKwQ9NcSAkjbg9IHEU2CxW+51N8uOn/Ypgf84=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o9Lpq90ZD5dOjJOU9xVxn1X8OpcH64tYHtAAFmfJHGwbaSK4zn0jdXSllvwNeFyM0
	 BY5iQc9Acvk1wMnSqeUh42OYWL1zY6j/JmvJG+7NR5oCc+hMs6EhNeA0HZ9KGGwhUf
	 Q1foEaFd4m+D6VyhdyU0ql7L0Q9GPVtAanHrgzp7nmbJ9VN5Fzan1hqojL9zuOFIB5
	 sFTgDDvHapX4hOsd2Rtx96Peom/761WyXqNkO8aCkE7SuGSmdshzwPxF4RfiyptInV
	 92M0Nt6AV1kbEWGmuYIl8RkyvkWmDBRZwDtefCgmVdFDdEKQPzHWz/hbrCgtMxzsaP
	 M30ZMEpu9ab9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEBB780F26;
	Thu,  3 Sep 2026 14:37:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D4DC498
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:37:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2EA5060B8D
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:37:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KG96R95oyF2K for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:37:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 02EFB60B71
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::92b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446259;
 b=iq6loutdVmALy/f1vv+4NczPJ4N6PneVqVZaZtUwWzKsvRZpkDCNNRuixc54z/YwAAKy
 VnBUREBJ9qk5toQTy+TqJutESBOrUMPobUfUOXUyHQiaPI4z9sBmU5QcX5UcuWaxnT8sr
 MD5hgiDoI3TY3NndMvzyGcajNz79UW2VCBUxgSUot2Zpaj1RECUD7DBZIR9RCzY39A9T4
 aqFi9StOlJyst0GoMznIgu2404nPnmEG8yr83cfAFXLAliAmES1wsmiNT3bIpm5Es5lNd
 SoqyXaDGtqA6ZspTHCE+q9sX0lJceQcJBiIzoDnW0ngnj49KCMsYFXvk8Ixym+9MTZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788446259;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=mE4uMcgKwQ9NcSAkjbg9IHEU2CxW+51N8uOn/Ypgf84=;
 b=A+okfFpK8odTcQ6jgKLCFl+B2Xw60WWGdovETwBCL4y/g0+kY9QR7VCvv0u5nNqs8Y6T
 fgvpJ7B4OxReBerI+0La/aU9WgIJeglion9upugvDQrnNFFbCxGzDchSHhfCi4DilBxcC
 pAYBZovLRhm0GoCM9AN26pfnBCgjfFVZNS+DEVS2AZT/7RtNIXc0tubiRZgn5OOz5/gJH
 EP3tZBhozBb6MTDRuvG6Qq/yHJmj/GQngu+9zl2K8eqWNyeb8OA1GBOT9hWwmQmR/U9jw
 HACakgpns8t1u4lmf4FrVz4pxjrhoF/wX5XEw6/oPNDmrgzgyOrot+Oh7Z4no9nja7A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Ykf8Jz0q; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::92b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92b; helo=mail-ua1-x92b.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Ykf8Jz0q
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 02EFB60B71
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:37:38 +0000 (UTC)
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-97cbbdfc2e0so893582241.0
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788446257; cv=none;
 d=google.com; s=arc-20260327;
 b=btnpXmkN+WK81Ba65Zoh2TOvV2luXsAOYZNWZbjqb3ciUO+XkVCSTFQC371853DFU6
 TDHakd3wLCrXdDLCU7lkWmIYvWlXiUCy9NmDdWlju2pJf2pJPahrfjc/2ozxrE7TBR69
 DWoQvs++mEwAXNXioZRafeeHhppuDO3JC1IxKsf/VpfDdO7d34AHlNNmM+WOELYwK3Ej
 xbFxxx4PQbAj5ysqwA7PCS+0FwLNDmUatPAoBYUXcriNbL+CNQtcv7qNJduNcsG8R5yR
 iGZATkV/P/yPKSxS88WvDjHHftT6kxfsy5yCC/m+cz9E7ZMtp6F2505ezbpHg5YSVCvd
 B+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mE4uMcgKwQ9NcSAkjbg9IHEU2CxW+51N8uOn/Ypgf84=;
 fh=GKiQb09UDV0/BhVmtgY4Lx/iPF7Y98a9Upz2uCnkxWQ=;
 b=jPwfaVqvAnlAgH4kYIavcVhe8JTZliv4ShLBqNYF07XoPyf37zUx/4h7dMbMDsygc+
 QaRl570c3xUT9P4mlTnIoQHQH/uNhxR9ksdu2l/fxabdjEMdrccsPI7cKVyaVGAfk5Rs
 +bXu3OzBudjCkwZh6AVShyYEBQSHgo0JrQthoZKq1XiYDN2gJcZxNC9ZIkb03EmPyw1A
 PjJXxjI5TKPmypPTqcA6Qtt+SHX2cMaoW3tNPJ2h690zdNob4vHgmwP/EComLPhAmLj+
 UoD8xspkQfZA0iWl+7CAXa9kAamo8wG2vc3BRKVqOZTBOVlR8HSi+5yOkr2vTm9fmMHT
 hQKg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788446257; x=1789051057;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mE4uMcgKwQ9NcSAkjbg9IHEU2CxW+51N8uOn/Ypgf84=;
 b=Ykf8Jz0qZac4qKq8lmbRjurWWLigpL+JwL7xU7ldLDuLFJ0O1TJSAqLt70CX4GrErE
 oY9hri/LVOuJB/4K1bOXDmBt9bFFb3URZezF5gwiGb0nINgU6oja2hb4EF8SL85DWuN8
 aVi7401saSVvUs/PMP1joyCHslTU1RpI7lGqyiz5rmczRDNvrAY6hbmkfjD5RtYNHVZN
 CqL44zf/EE4ZWYSErtXBIpr1LBO9G+Lonu6Q07PQIzcB4q0CQ23l5wrdTG8FQ5iZ9pWD
 g+HfwuAWAA1a1cftY+2aTQMLbxysEi1S1L0l0MK3gAMLht/BH+HHwmWcaXq7C6YFBhvo
 SW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446257; x=1789051057;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mE4uMcgKwQ9NcSAkjbg9IHEU2CxW+51N8uOn/Ypgf84=;
 b=bGdrG/6Kvd9kO0MWTAzJ3ITBzKnYRxBef2JpAXeyMqeZiXcMdepvuWCZVS3YerUSXD
 IztS67skJOK9sA0/p1/gz2n9WzempEhIIRcFbemHmhxV8tZ1o4eQNEHDaD+YN+WoidJZ
 e0X/MbGZQev7iJpgTvgdJH1SW7eymM7YHyh2diZAxgZw+RrkiKn/0nK23WVjOG6QZI0c
 iZuhPqCLFgYF03yKNu1/pRq6aqoHDRBiQRSoSfjqJVItYw/KX6qQmEAe1Ly5ihrp1Mp/
 mgfa2vFb8/hPLaFOosnV3vu+ERWvF9SNtrHWgaT8zyKlDtJ5TP2iA6pLyfVnCs5lDuRJ
 /yig==
X-Forwarded-Encrypted: i=1;
 AKwUvBwn8DDbY5oTjZPmzEuEZcIuzePBkOJhcOT56nXa8PUlGyX7TXBXchlrREIfFBgwWauOqWCrkrI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mj069kdjklSMPiC1j/kTTGWD30K5yriwfJZgH0BsQnDoCk5Uma
 CQvc62g7kZUBfuMkKP0HBlCisegZnhsCNlzfKd0eDanx+gnXbsHxzzBuhKOPTpalRw5hLNzNXRk
 irJ+v9JoiOc7z0urbCg/U1ST8A86T2MM=
X-Gm-Gg: AYBFou2ZAf8GmvkFLfrxAVk5B3cHFNIQMg6FiJ7kPy2pxnFBuL6NnNMEttIdNrVRYJK
 G1oka6BjKYV8T0MvSII6/qtBOxQu9yTi2QUuLypu6hrvpptSKTDUI4lqm0iHmo5u5NSz/qYoF1c
 TExf3hjp6GiowpWrVl3yVhS+0LcFvcCazLTlZET2TWugSGtsO51q2tdSdulC+kGj0FMQXmqmy9a
 uGqnisi96wx7rxcH0BW3FFUuBlZAQg5ya49pZ9sDU+wUlpfTRK616KH76Gtpq7gm6vWOs2g0Sw3
 3Uwk+k9yBmhbQ+TpL/MU3PQ+4VVog3q2gmRX6UZ0BcUZorg56KomqtYXfQ==
X-Received: by 2002:a05:6102:6441:b0:783:f3bf:f9aa with SMTP id
 ada2fe7eead31-78a1f2e063amr3936462137.8.1788446256809; Thu, 03 Sep 2026
 07:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903081705.12894-12-philippe.reynes@softathome.com>
In-Reply-To: <20260903081705.12894-12-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 3 Sep 2026 10:37:24 -0400
X-Gm-Features: AcwNN1VgFnNpGirSwKb5WcjWSoBjF1zEkwD-FmwwdBsLgEpOUKT_H8IMmhKgDx0
Message-ID: <CAMDkj5xoSKAGFwhQBN02eTTwZNN0XCwj1fKO7kxmtE_mnNXjiA@mail.gmail.com>
Subject: Re: [PATCH v9 11/15] tools: binman: pre-load: add support of ecdsa
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>
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

Hi Philippe,

On Thu, Sep 3, 2026 at 4:17=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Right now, binman can only create pre-load header
> using rsa. We add the support of ecdsa.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v3:
> - initial version
> v4:
> - merge patch 11 that was adding test for ecdsa pre-load
> - add key size check
> - use exc instead of simply e
> - rename dts filaneme
> - add a test to check key size
> v5:
> - compute ecdsa521 sig instead of using hardcoded value 132
> - fix english: don't -> doesn't
> - avoid line too long
> v6:
> - no change
> v7:
> - no change
> v8:
> - no change
> v9:
> - no change
>
>  tools/binman/etype/pre_load.py                | 78 ++++++++++++++++---
>  tools/binman/ftest.py                         | 50 ++++++++++++
>  tools/binman/test/ecdsa521.pem                |  7 ++
>  tools/binman/test/security/pre_load_ecdsa.dts | 22 ++++++
>  .../security/pre_load_ecdsa_invalid_algo.dts  | 22 ++++++
>  .../security/pre_load_ecdsa_invalid_key.dts   | 22 ++++++
>  .../security/pre_load_ecdsa_invalid_sha.dts   | 22 ++++++
>  7 files changed, 214 insertions(+), 9 deletions(-)
>  create mode 100644 tools/binman/test/ecdsa521.pem
>  create mode 100644 tools/binman/test/security/pre_load_ecdsa.dts
>  create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_alg=
o.dts
>  create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_key=
.dts
>  create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_sha=
.dts
>

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks!
Regards,
Raymond

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load=
.py
> index 0d953cb258e..7890c1c62a8 100644
> --- a/tools/binman/etype/pre_load.py
> +++ b/tools/binman/etype/pre_load.py
> @@ -16,8 +16,10 @@ from binman.entry import EntryArg
>
>  from Cryptodome.Hash import SHA256, SHA384, SHA512
>  from Cryptodome.PublicKey import RSA
> +from Cryptodome.PublicKey import ECC
>  from Cryptodome.Signature import pkcs1_15
>  from Cryptodome.Signature import pss
> +from Cryptodome.Signature import DSS
>
>  PRE_LOAD_MAGIC =3D b'UBSH'
>
> @@ -27,6 +29,12 @@ RSAS =3D {
>      'rsa4096': 4096 / 8
>  }
>
> +ECDSAS =3D {
> +    'ecdsa256': 256 / 8 * 2,
> +    'ecdsa384': 384 / 8 * 2,
> +    'ecdsa521': (521 + 7) / 8 * 2
> +}
> +
>  SHAS =3D {
>      'sha256': SHA256,
>      'sha384': SHA384,
> @@ -86,24 +94,17 @@ class Entry_pre_load(Entry_collection):
>          if self.key_path is None:
>              self.key_path =3D ''
>
> -    def _CreateHeader(self):
> -        """Create a pre load header"""
> -        hash_name, sign_name =3D self.algo_name.split(',')
> -        padding_name =3D self.padding_name
> -        key_name =3D os.path.join(self.key_path, self.key_name)
> -
> +    def _CreateHeaderRsa(self, hash_name, sign_name, padding_name, key_n=
ame):
>          # Check hash and signature name/type
>          if hash_name not in SHAS:
>              self.Raise(hash_name + " is not supported")
> -        if sign_name not in RSAS:
> -            self.Raise(sign_name + " is not supported")
>
>          # Read the key
>          key =3D RSA.import_key(tools.read_file(key_name))
>
>          # Check if the key has the expected size
>          if key.size_in_bytes() !=3D RSAS[sign_name]:
> -            self.Raise("The key " + self.key_name + " don't have the exp=
ected size")
> +            self.Raise("The key " + self.key_name + " doesn't have the e=
xpected size")
>
>          # Compute the hash
>          hash_image =3D SHAS[hash_name].new()
> @@ -151,6 +152,65 @@ class Entry_pre_load(Entry_collection):
>
>          return data + pad
>
> +    def _CreateHeaderEcdsa(self, hash_name, sign_name, key_name):
> +        # Check hash and signature name/type
> +        if hash_name not in SHAS:
> +            self.Raise(hash_name + " is not supported")
> +
> +        # Read the key
> +        key =3D ECC.import_key(tools.read_file(key_name))
> +
> +        # Check if the key has the expected size
> +        if key.pointQ.size_in_bytes() * 2 !=3D ECDSAS[sign_name]:
> +            self.Raise("The key " + self.key_name + " doesn't have the e=
xpected size")
> +
> +        # Compute the hash
> +        hash_image =3D SHAS[hash_name].new()
> +        hash_image.update(self.image)
> +
> +        # Compute the signature
> +        signer =3D DSS.new(key, 'fips-186-3')
> +        sig =3D signer.sign(hash_image)
> +
> +        hash_sig =3D SHA256.new()
> +        hash_sig.update(sig)
> +
> +        version =3D self.version
> +        header_size =3D self.header_size
> +        image_size =3D len(self.image)
> +        ofs_img_sig =3D 64 + len(sig)
> +        flags =3D 0
> +        reserved0 =3D 0
> +        reserved1 =3D 0
> +
> +        first_header =3D struct.pack('>4sIIIIIII32s', PRE_LOAD_MAGIC,
> +                                   version, header_size, image_size,
> +                                   ofs_img_sig, flags, reserved0,
> +                                   reserved1, hash_sig.digest())
> +
> +        hash_first_header =3D SHAS[hash_name].new()
> +        hash_first_header.update(first_header)
> +        sig_first_header =3D signer.sign(hash_first_header)
> +
> +        data =3D first_header + sig_first_header + sig
> +        pad  =3D bytearray(self.header_size - len(data))
> +
> +        return data + pad
> +
> +    def _CreateHeader(self):
> +        """Create a pre load header"""
> +        hash_name, sign_name =3D self.algo_name.split(',')
> +        padding_name =3D self.padding_name
> +        key_name =3D os.path.join(self.key_path, self.key_name)
> +
> +        if sign_name in RSAS:
> +            return self._CreateHeaderRsa(hash_name, sign_name, padding_n=
ame, key_name)
> +
> +        if sign_name in ECDSAS:
> +            return self._CreateHeaderEcdsa(hash_name, sign_name, key_nam=
e)
> +
> +        self.Raise(sign_name + " is not supported")
> +
>      def ObtainContents(self):
>          """Create a placeholder for the header"""
>          self.SetContents(tools.get_bytes(0, self.header_size))
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 5f0de4c74a7..a3209bb1595 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -5925,12 +5925,62 @@ fdt         fdtmap                Extract the dev=
icetree blob from the fdtmap
>
>          image_fname =3D tools.get_output_filename('image.bin')
>          is_signed =3D self._CheckPreload(image_fname, self.TestFile("dev=
.key"))
> +        self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
> +        self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSI=
ON)])
> +        self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_=
SIZE)])
> +        self.assertEqual(is_signed, True)
>
> +    def testPreLoadEcdsa(self):
> +        """Test an image with a pre-load header using ecdsa key"""
> +        entry_args =3D {
> +            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
> +        }
> +        data =3D self._DoReadFileDtb(
> +            'security/pre_load_ecdsa.dts', entry_args=3Dentry_args,
> +            extra_indirs=3D[os.path.join(self._binman_dir, 'test')])[0]
> +
> +        image_fname =3D tools.get_output_filename('image.bin')
> +        is_signed =3D self._CheckPreload(image_fname,
> +                                       self.TestFile('ecdsa521.pem'),
> +                                       'sha256,ecdsa521')
>          self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
>          self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSI=
ON)])
>          self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_=
SIZE)])
>          self.assertEqual(is_signed, True)
>
> +    def testPreLoadEcdsaInvalidSha(self):
> +        """Test an image with a pre-load ecdsa header with an invalid ha=
sh"""
> +        entry_args =3D {
> +            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
> +        }
> +        with self.assertRaises(ValueError) as exc:
> +            self._DoReadFileDtb('security/pre_load_ecdsa_invalid_sha.dts=
',
> +                                entry_args=3Dentry_args)
> +        self.assertIn("Node '/binman/pre-load': sha2560 is not supported=
",
> +                      str(exc.exception))
> +
> +    def testPreLoadEcdsaInvalidAlgo(self):
> +        """Test an image with a pre-load header with an invalid algo"""
> +        entry_args =3D {
> +            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
> +        }
> +        with self.assertRaises(ValueError) as exc:
> +            data =3D self._DoReadFileDtb('security/pre_load_ecdsa_invali=
d_algo.dts',
> +                                       entry_args=3Dentry_args)
> +        self.assertIn("Node '/binman/pre-load': ecdsa5210 is not support=
ed",
> +                      str(exc.exception))
> +
> +    def testPreLoadEcdsaInvalidKey(self):
> +        """Test an image with a pre-load header with an invalid key size=
"""
> +        entry_args =3D {
> +            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
> +        }
> +        with self.assertRaises(ValueError) as exc:
> +            data =3D self._DoReadFileDtb('security/pre_load_ecdsa_invali=
d_key.dts',
> +                                       entry_args=3Dentry_args)
> +        self.assertIn("Node '/binman/pre-load': The key ecdsa521.pem doe=
sn't have the expected size",
> +                      str(exc.exception))
> +
>      def _CheckSafeUniqueNames(self, *images):
>          """Check all entries of given images for unsafe unique names"""
>          for image in images:
> diff --git a/tools/binman/test/ecdsa521.pem b/tools/binman/test/ecdsa521.=
pem
> new file mode 100644
> index 00000000000..ac1904d3955
> --- /dev/null
> +++ b/tools/binman/test/ecdsa521.pem
> @@ -0,0 +1,7 @@
> +-----BEGIN EC PRIVATE KEY-----
> +MIHcAgEBBEIBM+CNnraGci2/mw1wPq44l2HccHnoBbdP3DiU6zqsBOq8IR8uegz2
> +FLzWsjxcW7hwROCdEm6tW99wqsyPE25RZ3egBwYFK4EEACOhgYkDgYYABABu5bWV
> +aQ4EgnXFjojX9df3gBEBipphEEFAoG87GuoWBdlimFC8UEEXiKNU37w0wlJn4bG0
> +8uOKwDqBk3uF+DrmZwB45lCSKkjdRWsJeDt+iEuFe2O/mbXoL4p5D8MM2OsDV5GT
> +srUbxhXq+T/i5lV7XXm2+tT/7zU8ZQce6WRufbd9KQ=3D=3D
> +-----END EC PRIVATE KEY-----
> diff --git a/tools/binman/test/security/pre_load_ecdsa.dts b/tools/binman=
/test/security/pre_load_ecdsa.dts
> new file mode 100644
> index 00000000000..247b85aad4c
> --- /dev/null
> +++ b/tools/binman/test/security/pre_load_ecdsa.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       binman {
> +               pre-load {
> +                       content =3D <&image>;
> +                       algo-name =3D "sha256,ecdsa521";
> +                       key-name =3D "ecdsa521.pem";
> +                       header-size =3D <4096>;
> +                       version =3D <0x11223344>;
> +               };
> +
> +               image: blob-ext {
> +                       filename =3D "refcode.bin";
> +               };
> +       };
> +};
> diff --git a/tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts b=
/tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
> new file mode 100644
> index 00000000000..be71edbbdcd
> --- /dev/null
> +++ b/tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       binman {
> +               pre-load {
> +                       content =3D <&image>;
> +                       algo-name =3D "sha256,ecdsa5210";
> +                       key-name =3D "ecdsa521.pem";
> +                       header-size =3D <4096>;
> +                       version =3D <0x11223344>;
> +               };
> +
> +               image: blob-ext {
> +                       filename =3D "refcode.bin";
> +               };
> +       };
> +};
> diff --git a/tools/binman/test/security/pre_load_ecdsa_invalid_key.dts b/=
tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
> new file mode 100644
> index 00000000000..15d71cf0324
> --- /dev/null
> +++ b/tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       binman {
> +               pre-load {
> +                       content =3D <&image>;
> +                       algo-name =3D "sha256,ecdsa384";
> +                       key-name =3D "ecdsa521.pem";
> +                       header-size =3D <4096>;
> +                       version =3D <0x11223344>;
> +               };
> +
> +               image: blob-ext {
> +                       filename =3D "refcode.bin";
> +               };
> +       };
> +};
> diff --git a/tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts b/=
tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts
> new file mode 100644
> index 00000000000..1017707375e
> --- /dev/null
> +++ b/tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       binman {
> +               pre-load {
> +                       content =3D <&image>;
> +                       algo-name =3D "sha2560,ecdsa521";
> +                       key-name =3D "ecdsa521.pem";
> +                       header-size =3D <4096>;
> +                       version =3D <0x11223344>;
> +               };
> +
> +               image: blob-ext {
> +                       filename =3D "refcode.bin";
> +               };
> +       };
> +};
> --
> 2.43.0
>
