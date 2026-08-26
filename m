Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9A0C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 11:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C1F660736;
	Wed, 26 Aug 2026 11:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2bDN02AYfU68; Wed, 26 Aug 2026 11:17:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787743060;
	bh=vfDeWLphrjT/ppCvT3PXcTboGSitVS1sKgK/XOljsVU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vj0QsI/OFiC5UB5X/KfJEOmOrpqMdLLFzXfl416FhQyTe1ufk7LeJ+Cdmfyza+cD7
	 Z81Qw6lqJV9bOWrS9EeqSmF2oE9NuMXgDZVYnHI26HZMz+Jy6x54Iejk/O7mMUS0Hi
	 9hpd6HQpGFZro3awlFTuaajLHEkTrYuGkUUjes0+GLsbZy5bd0OfMWluIRFIEm8KIm
	 pMe9tJHAXpWUdw5l66iB3YN35IFus7sSpF3BZW7Y24fG4vmVm1PXeddyKh9g7DCAyQ
	 3Liq3IgBg771Y/JnLaTwoJEwN3MaOUxZLbwrULnj+BdPtHtFZRw4YeCQ1f+oZj00CZ
	 dNiM46BbNgkhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC2356067B;
	Wed, 26 Aug 2026 11:17:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 460F13C3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 11:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3853E40071
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 11:17:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jWwsJihx7ana for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 11:17:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b135; helo=mail-yx1-xb135.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=yRtVMRKY
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 60D6D4005F
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 11:17:36 +0000 (UTC)
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66d0743503aso1341264d50.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 04:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787743056; cv=none;
 d=google.com; s=arc-20260327;
 b=YJXYDhnUktyDfnYXoI4SN7dQmx1ZcObVINJCMbZ4eOQlu2EyFiKd8wyDMnncJHDnfy
 UUXRGqNNXuh9+y+dNMUTP1Zft9L+3woOfu5uiAmmElAL4mBOUcsuJHequHjwKZowFD0Q
 r1MTqQO+Q2jd4OzFyWZicPVTj8SAtp/6Yvv/6iEDRKVnARYeeG2C2G+jinn6VRR695D+
 UzLEfVVJbp8YhsYmZCSs2PyRIr/g1mClknuMF4+hs02OyTPQ9MiwAogO9HErRmCSzEMd
 oR/aErXN3ttTo6tvJTPHCH8JDU+ph63BcvwvzX9A0oihgNnog2/yemYd73XUw8O2I3hk
 XYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vfDeWLphrjT/ppCvT3PXcTboGSitVS1sKgK/XOljsVU=;
 fh=cDFQcSFjwK1spkQpwRhvx9QrJcp39J1K2A11Q4zJc/Q=;
 b=VC7eseZROsDOBem+xXZXdWaV4oZCth+xNKbWyhzSmfrddH/4QWB9YHCdyWGsd+nz0i
 FsNdgczpEx1G66zGopuIyqW7jqZpnmq/RGTTsfxW4n73YRboHlsjFRDpcPZNelicnqsG
 5bz5WO6ozFT33g/Mgko+x9nMr5EgLgmqGDOVHwS9znEaIRu+pwCJ72C5GTu5NIbVJADJ
 rHfXxdtJEp7S7wY/qBYF1E5dqt8dMQL27Z3otjQjaW9pqN55ltpEBklVX71qUuL/VmH9
 3ckHm5X/FYRypLZFmt1uFSgQ5VqshZg1aJc9Vq7HWJnYXiAZXLhXWRRaZnrMGPfEcL9c
 S3Ww==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787743056; x=1788347856;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vfDeWLphrjT/ppCvT3PXcTboGSitVS1sKgK/XOljsVU=;
 b=yRtVMRKYu3iDdbOpgKhgCvDAo5ve4lCaasI/PkgjAUdQhu3WO1Y5Ll9OIUDei9epOZ
 EKjFBrwyLozAtSdQvwCuLTgaaxPsLyxthPKdRE1RCNF3RjlYMl5N8nx7SJyu8FxS6yM0
 YQzX/xTb83xvB63bRHMTrq0dT2QjX1eVKmRAm1vAjOu5T+16XHn1vSFFuIfEYhF7ZTN5
 jlcjPqbo43Jw9gog8IUwhtmwTUHjAEU73Vtqucq2s0cJ9J7d3qQIia889lzxmT0jBJR8
 8FIEDt2RyHPWVOZPuQK0El2UBnKDbxyAKiGWSpPVb8dzGETBh/oGIoGw8f4C5JtfuxVC
 G0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743056; x=1788347856;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vfDeWLphrjT/ppCvT3PXcTboGSitVS1sKgK/XOljsVU=;
 b=dR2gho+fqXmscic86wpluF0YE9Eyqk8Im1BOmXACXtoDuQf0x53YAE9/uFMKOGHjoC
 KSUOxLXoGq47mIAVK2ov1SY84c/OjdcrCV118zLrQKrec6fzDdU7MUOk8VgOHuQjS1wc
 A9QqMy6QGb87t/f7TvNL9BBc93oF9tvM1MrStFgCbXdf7LICH+R7dyDUSCd4g4wrkWuG
 aCkjtcaKQSK2tWxz9cNAmcrJW9OuA4mH1XSUXGxCF+/ivHOmXb7I4jFyat9SgnjSejF7
 B6XkAtoEfOJGspWB7Id5x8cwRFpeLuPC7Xbaovox0KSmZIoBa4uvwrU+fSJo3Fn/OfuK
 OmzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwiKeRvwRajA8pnWdiirSn75MqSZUorpm+wT/56XgJR4d/QT8HfNBHld8Ps/VDxbOhUUMHylo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m24Vlvb7cyLOVHf8PI+pCwSEkytbH4AJxMkVXuZlxxFMA0Tbx2
 gTcXDfnmjF0xEhgeFoOJkKnZitZrZts6jwqdjvnPOyJGN89a5PBzeX5jHh417FeCr42eqsVb+sO
 rq4y0uLgQsD9zUsf4QbVOvYgW+DQEYYawaTst/CO4Xw==
X-Gm-Gg: AR+sD11pXsP/W6Y+HLR1CoZCaWuW5VMG9hWmtkWI2swTyKvMdP5QFk3d4uPtOdqNGf0
 +D7IGr6/OCVyl0nr/NteBzNQVS4cc5iPc2WBzc5CoQdvQxmuDjSMc/feuA+7pyYaetV7ApolVkI
 yn9JO4HXqWAsFtF8BeJWl/KiTnHLiCg65KC0NjEJUaXmMoqxLA848+N7FyDWz0rg3bf3O2L8zh4
 hP31wbwRkLE3FVklbj/m/S1sorUC2NEPLlLlGj6LnTErMNnTa5m4jTGoZSaawO++qHo7O+oi4cR
 zCwo86w4EeMsA/7veYTLp8FTvEJNRdzlK17P+CDTq68a84HrrgrFGN6ekXd4KVZ6Flw7k7o9tLF
 6YIKWT8qhDSw5FXi55r90ojMJ6c24M7oCfCpLMC5boKMMcWd8GnFbfpwJ0Ji0jEj7NHqlIBxn1w
 BkUO0MnxUxmmj0eUuQeQ0y+L4s8ylEOkhWX0XlqhM2vTHaGfNoepoX9kwkGbvSL2bPc8JJIfx49
 +z7FEnX+TCfy62sUpVMUT6oA9h/A3seecRzRKyi2IjjTfl8eIeqpxjrqlkZnUE1QH8dn6LhPH/d
 jS65mDvhyEKD522dsq481bGmjl77b3sjk1nhz9wnqBuHOiHUU+V4hS7H5y8Bf5fQHSna41PRQzU
 xLNdS/azsmfJprTRuSxS+h9LwU39FVIJ7KdCvDpfrHQk=
X-Received: by 2002:a05:690e:1186:b0:668:8b09:bd13 with SMTP id
 956f58d0204a3-66d25703226mr1801396d50.18.1787743055549; Wed, 26 Aug 2026
 04:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260820130746.164424-1-heinrich.schuchardt@canonical.com>
 <20260820130746.164424-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260820130746.164424-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Aug 2026 14:16:59 +0300
X-Gm-Features: AcwNN1WQK5x9QR2qN1SQTVU2G6TO3F3c860rN_Sjp2DbN-HsEoGsXElOjcKw57A
Message-ID: <CAC_iWj+HxQ4HK5_X1qKJT3NNqJbcPq6sQD=PLM8hkT-5k6vdbg@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi_loader: in platform_get_rng_device() use
 EFI_PRINT()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="000000000000c6b0630659f15d98"
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

--000000000000c6b0630659f15d98
Content-Type: text/plain; charset="UTF-8"

Hi Heinrich,


On Thu, 20 Aug 2026 at 16:08, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> Use EFI_PRINT() instead of debug() to correctly indent the message.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_rng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c
> index 7810b4e47ea..9c5a60ea963 100644
> --- a/lib/efi_loader/efi_rng.c
> +++ b/lib/efi_loader/efi_rng.c
> @@ -31,7 +31,7 @@ __weak efi_status_t platform_get_rng_device(struct
> udevice **dev)
>
>         ret = uclass_get_device(UCLASS_RNG, 0, &devp);
>         if (ret) {
> -               debug("Unable to get rng device\n");
> +               EFI_PRINT("Unable to get rng device\n");
>

All the users of that function print a similar message on failure. IMHO
just remove the print completely

Cheers
/Ilias

>                 return EFI_DEVICE_ERROR;
>         }
>
> --
> 2.53.0
>
>

--000000000000c6b0630659f15d98
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,sans-serif">Hi Heinrich,=C2=A0</div><div class=3D"gmail_defa=
ult" style=3D"font-family:arial,sans-serif"><br></div></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Thu, 20 Aug 2026 at 16:08, Heinrich Schuchardt &lt;<a href=3D"mailto:h=
einrich.schuchardt@canonical.com">heinrich.schuchardt@canonical.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Use EFI_=
PRINT() instead of debug() to correctly indent the message.<br>
<br>
Signed-off-by: Heinrich Schuchardt &lt;<a href=3D"mailto:heinrich.schuchard=
t@canonical.com" target=3D"_blank">heinrich.schuchardt@canonical.com</a>&gt=
;<br>
---<br>
=C2=A0lib/efi_loader/efi_rng.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c<br>
index 7810b4e47ea..9c5a60ea963 100644<br>
--- a/lib/efi_loader/efi_rng.c<br>
+++ b/lib/efi_loader/efi_rng.c<br>
@@ -31,7 +31,7 @@ __weak efi_status_t platform_get_rng_device(struct udevic=
e **dev)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D uclass_get_device(UCLASS_RNG, 0, &amp;d=
evp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0debug(&quot;Unable =
to get rng device\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EFI_PRINT(&quot;Una=
ble to get rng device\n&quot;);<br></blockquote><div><br></div><div class=
=3D"gmail_default" style=3D"font-family:arial,sans-serif">All the users of =
that function print a similar message on failure. IMHO just remove the prin=
t completely</div><div class=3D"gmail_default" style=3D"font-family:arial,s=
ans-serif"><br></div><div class=3D"gmail_default" style=3D"font-family:aria=
l,sans-serif">Cheers</div><div class=3D"gmail_default" style=3D"font-family=
:arial,sans-serif">/Ilias</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return EFI_DEVICE_E=
RROR;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-- <br>
2.53.0<br>
<br>
</blockquote></div></div>

--000000000000c6b0630659f15d98--
