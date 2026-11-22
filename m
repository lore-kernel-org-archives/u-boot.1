Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863C2606A32A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sCpse26Z;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Tb4ESndg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1402B40695;
	Sun, 22 Nov 2026 12:38:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kebsQiaXLnB0; Sun, 22 Nov 2026 12:38:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 580794052C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795351093;
	b=sajThDkKpm6eb840n3lSHAF5806f4M6iiT10GMJOU/nTWpi5PaZXj8J1rMGlHD2r5Uwz
	 u6U6GU9FirsF4vRQPgTfGGOhUZSPp5DeRC19FtL9eL+RW6dQSDuykf2L50qtDTKVUMIQu
	 BPnLtH7f5z9N5TR6r73Ur5mAYxs1Al7+aSqFdU+JLoqm6EhJARGxCS06N+jJsxUHFJ/Rm
	 gpSVI232aXTR5QYKtHkuEc2mRcDLDvfYqqRJG4nAuXUtJQkWa8QdREVe2BTmN0MQ1PSyI
	 6gIX+dlnoN/9RSShX4okk8GYvKsXBApfKEoOb74d0Eg/0EbZFRXy/KeTUCayrI4lOvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795351093;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=9BqbosxHTJhtrCSxOwTtnCX9/K5ZO6ffnQ7CTgh5KRs=;
	b=lgCbWe6eSE8vlebdmZzW+d6vXDJX9wb3jonVIQOaZ69vd1pHLNxsib63oRMdzlq8QaHh
	 F5qdMonusQWfGHgH4tQBNjiWjFG7gTly6Q4t05f6fs5TYKb8I26jNiZ/pW/Ci014kdr7T
	 PtpMyFkTM7GkWHSZ865vECQcmaL4+Kcd0pRm6vHHuMAXFFXgWbqIxVv4aELiPFjooRzwi
	 8QRzZ4RLAkxVUWzMr5M+xvB9oO+JoXuonNFItWuz6/f50d8XyiRZEdDTwKr3rNOlxiMPp
	 v0O2UyMU46zdmLZ2FfIYbfKr3WyNJVl9tqwLJMOf2XpW7R84pm2iPDXi86HX30vyWcw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Tb4ESndg;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795351093;
	bh=9BqbosxHTJhtrCSxOwTtnCX9/K5ZO6ffnQ7CTgh5KRs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sCpse26ZHWoEkJXyIGQ19Wq2QmXL/ere96bc1UhnIZDtX2dfKrXDeLe55NHDfcyEj
	 gFh4/enVU02dyFq/5OwwZFEp5OxC71jyqTFFM3sZAm3f63h6NLceMcJST4oqqzMQjj
	 DXuU8zRGUNqyIUuPfS36+ZkjtRQL+UFpJSxa3LXalprG/u8PhxmCRntMo04ncuKEX3
	 ouepepxomnaLs1hOHUSPtbiuGLR41MnD3JQ95oDp9Oh7fGPgSVL6yl+/dvP0WDlwVY
	 dn4dQLDhVEVCs91yhduhwNFQwGgcU/YMLUZx+a9/MYWoqHnpZn7gwvgF/WZCxsEnn5
	 7MyvyTgrPt+IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 580794052C;
	Sun, 22 Nov 2026 12:38:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E85A6465
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 12:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CDE5E4052C
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 12:38:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J8sEsHvZBLje for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 12:38:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7A88E40528
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::12f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12f; helo=mail-lf1-x12f.google.com;
 envelope-from=paul.liu@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Tb4ESndg
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7A88E40528
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 12:38:09 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5c1479be604so1749893e87.1
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 04:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795351087; x=1795955887;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9BqbosxHTJhtrCSxOwTtnCX9/K5ZO6ffnQ7CTgh5KRs=;
 b=Tb4ESndgNlhtJL6Y92Kp3eSNf3u5k+tDQzODZxcMZNl8RqP91XCj6TBRl4yEgf3YCy
 0FA83HvkKPebyoVYA7S7pNiNr3epXgC7Xq9s+hKTLg0j9hGy/GtT4wgGh1qGV1cLIAMv
 W1s8hXpZG/QgKNzXjxVeP43ucVbOkCaICFjKsvuw75ZA1lgrT0/gxKhy1mIXGYJp1XIz
 jlfedv6Txca26otib5JpIzhIBXCcXTeAyYz/VuI7OlnRdudmPWS8Vc0zGsLknijBYLfM
 QUXGltp/YQtLDb/X/jfUdpKj6NWmje7da71H/1cMV9noiuzGtx5H4i9SpCVna6TSNAag
 l5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795351087; x=1795955887;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9BqbosxHTJhtrCSxOwTtnCX9/K5ZO6ffnQ7CTgh5KRs=;
 b=VwhFznIhlibSrmw2Gl91DkZQHKbDTQIo/zXEBvBn4uQZhDmUve+o/Lct9SlxidUN9p
 +f0p7LIcW+ZJMijy+2EV9ccCvKFT1HxBQdGOwV+Or559umUEKM32+dwyePSZXF/LFjYT
 nCR8cZJ0kVfvFl7NKYYuN3zyPsHGBVT6pmDPcKrgp7ia1rhrP6vJlhho42hOSkWei81J
 WkkzQMVbGRVFvs6zhG2u6Fa5773hzxLGZQKdn9C8Ru3+gjgkDUxCXxIQbOWJWU2fxvzG
 LuJWLzZ89EL19LB1iQ82efaBBKnG9JZtpDrAUGfQrfVNpuTrC8SMwNkMlbTZ0ukFXdy1
 HKyw==
X-Forwarded-Encrypted: i=1;
 AL+hErEN9yYPgp6it16jfNZ8uHF1IShh+QzROLaYZhDSJOuplWieTlShgoYLqHc/BMpeBHyRL1VYpnA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z885L3uuqOHbPMHlSU9trv+6iHt3CPYrxFs9pBYfWFZRtjyD5kc
 G4NOaezAAxg12ze1fC/G006xDSNPzgP23T7xSddeVp0+KqivRZ0bI5psS0397utch1nW88vvnoP
 IkL4g0hFi9xZODUTq2CXpsLf0TzX60lKpMZvihzeQ0w==
X-Gm-Gg: AZFdTZdA3p+PsrS9XI51gzzuhsY+CMXL8jo+bP6Q3Rxdr34P/bN6Lo9NPrdGsTGbcsk
 HuKPUnkKOk64gy7lG+ylM5cPjq4ugM6dE23hB76S1p8mtdr1XrSw+oboUyiDmiPZaZFBvUU4QXZ
 scs55pBcN+mrpGX6DmMLY5aiRck1ayrJhRRQ2NUyWUfFCF03uIsFOV4A2EYqvYfyG0Pld+5kQAW
 sMQewfR7kCqc7uDrroO7F/Ah+G5a4ItqDhe2iFSpfrIFgXZDaDN6T+C1IvQ4fQG4Qe8dnk4s8Xb
 PHpnzpT8IizC04PXF9J0Bx/2g4lYe/mJcuVirvNxHrRPwxxa49XML7JZKSX2WaDCvUrIuvfTj4v
 qFKL1eaRXoJBHK2b98/4wZ5lwTz9wbDJlaeYhFBBPNQBNXsPgQElcWiGSAXDCZkAo0mMM
X-Received: by 2002:a05:6512:23aa:b0:5c0:a57:1d3b with SMTP id
 2adb3069b0e04-5c1bc84fcffmr2339007e87.43.1795351086963; Sun, 22 Nov 2026
 04:38:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122003312.134216-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261122003312.134216-1-heinrich.schuchardt@canonical.com>
From: Paul Liu <paul.liu@linaro.org>
Date: Sun, 22 Nov 2026 12:37:54 +0000
X-Gm-Features: Aa3M54qKxcVR6vaihpZ53o1W0Q3c1FnzHStORTH5wf0Nh61Zp2AGGEjzYwlkAB0
Message-ID: <CALG-KHxRgynXggzr36JRLRHC0H_c5fNDzTzCnn_J+WvLaF9tFw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: correct EFI_SYSTEM_TABLE_POINTER crc32
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="000000000000c930400660dcbf0a"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000c930400660dcbf0a
Content-Type: text/plain; charset="UTF-8"

Hi Heinrich,

Thanks for the patch. But I can only see the UEFI spec 2.11 right now. I
cannot access spec 2.12 yet.
But the patch seems ok to me.
And I think we also need to change EDK2 right? Not only the way to
calculate the CRC32 in MdeModulePkg/Core/Dxe/Misc/DebugImageInfo.c, but
also the gdb plugin BaseTools/Scripts/efi_debugging.py
.

Yours,
Paul

On Sun, 22 Nov 2026 at 00:33, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> The UEFI specification 2.12 draft clarifies that the crc32 value
> must not include padding bytes at the end of the structure but
> instead should only be calculated over the exactly 20 bytes of
> the fields defining the structure (Mantis 2521).
>
> Fixes: aaf7be96c2c1 ("efi: add EFI_SYSTEM_TABLE_POINTER for debug")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_debug_support.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_debug_support.c
> b/lib/efi_loader/efi_debug_support.c
> index 8d0c133871e..e191e5121e3 100644
> --- a/lib/efi_loader/efi_debug_support.c
> +++ b/lib/efi_loader/efi_debug_support.c
> @@ -45,9 +45,12 @@ efi_status_t efi_initialize_system_table_pointer(void)
>
>         systab_pointer->signature = EFI_SYSTEM_TABLE_SIGNATURE;
>         systab_pointer->efi_system_table_base = (uintptr_t)&systab;
> +       /* Don't include trailing padding bytes in CRC32. */
>         systab_pointer->crc32 = crc32(0,
>                                       (const unsigned char
> *)systab_pointer,
> -                                     sizeof(struct
> efi_system_table_pointer));
> +                                     offsetof(struct
> efi_system_table_pointer,
> +                                              crc32) +
> +                                     sizeof(systab_pointer->crc32));
>
>         return EFI_SUCCESS;
>  }
> --
> 2.53.0
>
>

--000000000000c930400660dcbf0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Heinrich,<br><br>Thanks for the patch. But I can only s=
ee the UEFI spec 2.11 right now. I cannot access spec 2.12 yet.=C2=A0<br>Bu=
t the patch seems ok to me.=C2=A0<br>And I think we also need to change EDK=
2 right? Not only the way to calculate the CRC32 in=C2=A0MdeModulePkg/Core/=
Dxe/Misc/DebugImageInfo.c, but also the gdb plugin BaseTools/Scripts/efi_de=
bugging.py<br>.<br><br>Yours,<br>Paul</div><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, 22 Nov 2=
026 at 00:33, Heinrich Schuchardt &lt;<a href=3D"mailto:heinrich.schuchardt=
@canonical.com">heinrich.schuchardt@canonical.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">The UEFI specification 2.1=
2 draft clarifies that the crc32 value<br>
must not include padding bytes at the end of the structure but<br>
instead should only be calculated over the exactly 20 bytes of<br>
the fields defining the structure (Mantis 2521).<br>
<br>
Fixes: aaf7be96c2c1 (&quot;efi: add EFI_SYSTEM_TABLE_POINTER for debug&quot=
;)<br>
Signed-off-by: Heinrich Schuchardt &lt;<a href=3D"mailto:heinrich.schuchard=
t@canonical.com" target=3D"_blank">heinrich.schuchardt@canonical.com</a>&gt=
;<br>
---<br>
=C2=A0lib/efi_loader/efi_debug_support.c | 5 ++++-<br>
=C2=A01 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_debug_=
support.c<br>
index 8d0c133871e..e191e5121e3 100644<br>
--- a/lib/efi_loader/efi_debug_support.c<br>
+++ b/lib/efi_loader/efi_debug_support.c<br>
@@ -45,9 +45,12 @@ efi_status_t efi_initialize_system_table_pointer(void)<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 systab_pointer-&gt;signature =3D EFI_SYSTEM_TAB=
LE_SIGNATURE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 systab_pointer-&gt;efi_system_table_base =3D (u=
intptr_t)&amp;systab;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Don&#39;t include trailing padding bytes in =
CRC32. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 systab_pointer-&gt;crc32 =3D crc32(0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (const unsigned=
 char *)systab_pointer,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(struct ef=
i_system_table_pointer));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offsetof(struct =
efi_system_table_pointer,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 crc32) +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(systab_po=
inter-&gt;crc32));<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return EFI_SUCCESS;<br>
=C2=A0}<br>
-- <br>
2.53.0<br>
<br>
</blockquote></div>

--000000000000c930400660dcbf0a--
