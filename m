Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE25C61DBE
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 10:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E896660745;
	Wed, 26 Aug 2026 10:56:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7OjaelgKWgpa; Wed, 26 Aug 2026 10:56:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787741806;
	bh=kACzQV5Og47cEOPCxUyhbTWJIyjkgTj7MOSraXCLawY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yXnMQ3P477E0ROj5VK+Qx/2ulDtAErkCXQTOyfpht8OZGjk+gcmpKOJmg2n1OM1So
	 8RZJpVA7M/K2dGIG/DMUMzfijNFVKyZboNgJKT4ezZyBQIv+xxuMV/zZGzE0QGZx2f
	 cmm8/LrC0FDqvoyma3V3JGotqKwBhI32UPtNtRgTCvaX69FZdfvdJz9d//OPtxLpRF
	 cxYCVuoq481BbAQmzr6xZDtiIXCP/BCeADtO8bdaGwxBWJfTp9N3LYUNIh9bn0aoCM
	 bBTmm9QccrOwskLg75mEfDwYXKJ+EcZp6PiVZM5MiROW1U2oWIvtC3VxuOkZqF35Hu
	 h5uiwycV4+98A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C27016062B;
	Wed, 26 Aug 2026 10:56:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 337C1323
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 10:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1952B80B97
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 10:56:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ef6vIVaxefhr for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 10:56:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b136; helo=mail-yx1-xb136.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zxdAIFEJ
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA0A080B93
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 10:56:43 +0000 (UTC)
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-66cf1f9965dso1077732d50.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 03:56:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787741802; cv=none;
 d=google.com; s=arc-20260327;
 b=TEN9jolKu5SWIOAfcedGL4bsXwycSFi/rzBhB4PqLRMZPy1BXM9QUc61WMrz2EbBRX
 d5EFSOKzNsMBEISyooWIa7g/hP8/JIx2bJVFbXQ8S9qNKby46t6FA9DsYsVrNIKhQ9jW
 T3zxv6vjMKnAvcbxGUN4TqIA0tWnCtG5n/izBHYM58ltCEnuqDdAsLMkq3DUlqZfrcHn
 IlUhikk4VpfnFbA6Xzw2ISktcxf60g8FGJEsYvn/SqPFgecrL8IMMVf6eQqfHLqRwNwg
 Ni2RFxxFV/NmQJoVni1Qccgdr0UnaHwV9Fu1MQMh1sb1d8oVPFlT74YsLB5aaJeE1bjQ
 kDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kACzQV5Og47cEOPCxUyhbTWJIyjkgTj7MOSraXCLawY=;
 fh=YtG6jr1/V4pUq4vFb+vuUrJkMsiN58ijRN7BUUR4j2M=;
 b=S1x9QPFlALN7GANrCytscIEXAryqYESfUcQDPOql4xjiK/d7NW2ENJPPkRH+uiK96K
 oOdJ/hZR+3hnCacQHjmlqtnfAJb4TCdt9QYFxEEvOuASNrwsB4FRaBSjNujKTULLqFqf
 2cOh+SECmp9rM+cT3TobCWQvFrX3C2pz7nuycBTfrFnI939qTQAyM+/2Kl9t4zJS6Dn3
 WHxVqSlydCJierMQOIoiIL9pp7s5qW73QI681cZjDp2f//i6Ke5ObozUbRcBp/PR2BfV
 MKG5+AcmrVYY0YQPOTXipm/gb4gZB8DKpyYY8sKHvPNB1oo8Y9GkzBhODlv8f0gswYl/
 XClg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787741802; x=1788346602;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kACzQV5Og47cEOPCxUyhbTWJIyjkgTj7MOSraXCLawY=;
 b=zxdAIFEJIzcYenI/5oCkPMVk86YA6xCy/POtd/YuhOUAOZvkVGdFWu1ZjjO2p33vUC
 sdk+8M7420Fy7wu6QkANr8+ZGOYL85lx1E9xrQAb4CIUEPDbK9CGP3GHvtqBb7UAm5Ej
 ic+YK5LxREoSG3VJMVoD/ZUxxePOdoCxABoYwzgyQgkpiLYP2Joi8uG11zyLstRae/BF
 wlmprTziJgeKhfj2ybmeUGuoZxh86GRkw4XlQSnAGQ7Sx2Zqm8h0WM/tybN6oaWnEMof
 QwAh0qJvEtDW62ZEpJX5KGlGjD/2PKqfo2BpHAo9sVKJV40yg0ReuRh1dzg3Fs4utkuY
 zMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787741802; x=1788346602;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kACzQV5Og47cEOPCxUyhbTWJIyjkgTj7MOSraXCLawY=;
 b=r6UM9G9HgGI0wFBQQyfhOBe3+3Nx/kayBTvOemKB5tDRSF2+roAO6On8yr7KdIJyMX
 wk/OXpzylsoarRyaROGF4IEkG7cvuLqyN3EE2P3bmgP1pf6wATN4p6BQJychd4tdglDI
 6K/RAuoQCJxCtMpruOW9wnczw/IJUw7w/oL38y2Nga766+lRvz1mud8gM52sCoaHJHt4
 gIiK62Y1c3hO3lSuxkPPM5Gt3kIg/NC7azTs30EzMwfI9nY6wU6fddIwjgooSbOTtDl+
 jvnAhnR1ihSnhfFrBZ45EUn/lg/zAzfCeL0RH5xJ7KqszaSGIL4qTZDK1keTdKQTuMi5
 hqyw==
X-Gm-Message-State: AFuF++kwfVnmu4dbCUkK8ep8a6p4bvLpsnSW8ZlHMR3zuhzrMME52zVH
 WqpedH18I8Xt5SP23xM4BrcREivTsZx6AtJyVuD/ZdAOJBHrbHiFG6BPZx+mCw42SrpJquGLu60
 tegIOQSoNmBkNG/HKZE/fF36wqZYV29/glD2il9eWIg==
X-Gm-Gg: AR+sD117xK3JL9Wq0U2VuNP7CC9wvORzYwRwefLPwfd6Rtz4UEMvou0Vl8K4NVKGhDc
 KHhzli++ew/SZrpzu86FZmoDm1ykm21lerszn6ShYX4dr+XvPo9PgLYoRYVeUzmyHBtfDNiLPAb
 QjIlY92NB972CimqHYJY7P2Ax0NVC8ciDnP4n8LBu0k/aBrUrnVmFlNG0wnL7J5zRTMwXrLGwwY
 CPc6/is68/1iZsYlUwsWyhS4hmhPfTF+IWcboLIRYe38GXIK8hcAv9i+5sEODYtGP0UvOyBDPTi
 mDio91vcIumTuIUi9aydKyjdynNyCM3HCdjYVaVsZgFTdPn03XZwyfsJnZfwJMSl0ZSkwqkVp7r
 D2wFfYZQ/FL8KJsz61YLyr2GzMKlSVDe8ft6BCZV6ZFRGZOOHA7w/rXun6OvPFJdHIbi3dQeTC0
 m4JbSLNmVhGmFXF4YnF/VOqv0qbeUTK2hnitznEVt0pXkVIMUfa/U4n8Ve4Ipki0v4r/1hwlzqM
 6Eug7i+C/nLcoNFbTge52qMBo29JEOWITZpoCBreR8HnpHS0dS8tNz201MoKD22YAD7eTsyaCoa
 48Zq3sOZ2PrTGsB2eD83phcLGMvhvgOS9QG2xO23+m7axs36C5ZXiUG04qGmHRyQSf4GPdKbvQm
 YnCugYtEN3mQbPfRM6WBAmxhWH22Svk870k+0PU1w1lw=
X-Received: by 2002:a05:690e:1443:b0:66d:1a5a:1d27 with SMTP id
 956f58d0204a3-66d2568aa90mr2158151d50.12.1787741802016; Wed, 26 Aug 2026
 03:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
 <20260825-linkcheck-v1-11-ee7573fe3a4a@cherry.de>
In-Reply-To: <20260825-linkcheck-v1-11-ee7573fe3a4a@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Aug 2026 13:56:06 +0300
X-Gm-Features: AcwNN1VLYZ59-WL-ME7Hj9H5ELhHNRUHxsSBI62voLrBlDZWOaxOrEVzQ-1jG4A
Message-ID: <CAC_iWj+rpZ3ceNVbX3iKpEvci0Nddk99hvnGCLA_5jDhmsU2EA@mail.gmail.com>
Subject: Re: [PATCH next 11/45] doc: develop: uefi: update link to ipxe git
 repo
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Viacheslav Bocharov <adeep@lexina.in>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Soeren Moch <smoch@web.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: multipart/alternative; boundary="0000000000000f447e0659f113d1"
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

--0000000000000f447e0659f113d1
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Aug 2026 at 19:50, Quentin Schulz <foss+uboot@0leil.net> wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> http://git.ipxe.org/ipxe.git redirects to https://github.com/ipxe/ipxe
> so let's use the proper link without a redirect in-between.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> ---
>  doc/develop/uefi/iscsi.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/develop/uefi/iscsi.rst b/doc/develop/uefi/iscsi.rst
> index 51d38cde2438..52fa79f35620 100644
> --- a/doc/develop/uefi/iscsi.rst
> +++ b/doc/develop/uefi/iscsi.rst
> @@ -125,7 +125,7 @@ iPXE
>
>  For running iPXE on arm64 the bin-arm64-efi/snp.efi build target is
> needed::
>
> -    git clone http://git.ipxe.org/ipxe.git
> +    git clone https://github.com/ipxe/ipxe
>      cd ipxe/src
>      make bin-arm64-efi/snp.efi -j6 EMBED=myscript.ipxe
>
>
> --
> 2.55.0
>
>

--0000000000000f447e0659f113d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,sans-serif"><br></div></div><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 25 Aug 2=
026 at 19:50, Quentin Schulz &lt;<a href=3D"mailto:foss%2Buboot@0leil.net">=
foss+uboot@0leil.net</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">From: Quentin Schulz &lt;<a href=3D"mailto:quentin.schu=
lz@cherry.de" target=3D"_blank">quentin.schulz@cherry.de</a>&gt;<br>
<br>
<a href=3D"http://git.ipxe.org/ipxe.git" rel=3D"noreferrer" target=3D"_blan=
k">http://git.ipxe.org/ipxe.git</a> redirects to <a href=3D"https://github.=
com/ipxe/ipxe" rel=3D"noreferrer" target=3D"_blank">https://github.com/ipxe=
/ipxe</a><br>
so let&#39;s use the proper link without a redirect in-between.<br>
<br>
Signed-off-by: Quentin Schulz &lt;<a href=3D"mailto:quentin.schulz@cherry.d=
e" target=3D"_blank">quentin.schulz@cherry.de</a>&gt;<br></blockquote><div>=
<br></div>Reviewed-by: Ilias Apalodimas &lt;<a href=3D"mailto:ilias.apalodi=
mas@linaro.org">ilias.apalodimas@linaro.org</a>&gt;<br><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0doc/develop/uefi/iscsi.rst | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/doc/develop/uefi/iscsi.rst b/doc/develop/uefi/iscsi.rst<br>
index 51d38cde2438..52fa79f35620 100644<br>
--- a/doc/develop/uefi/iscsi.rst<br>
+++ b/doc/develop/uefi/iscsi.rst<br>
@@ -125,7 +125,7 @@ iPXE<br>
<br>
=C2=A0For running iPXE on arm64 the bin-arm64-efi/snp.efi build target is n=
eeded::<br>
<br>
-=C2=A0 =C2=A0 git clone <a href=3D"http://git.ipxe.org/ipxe.git" rel=3D"no=
referrer" target=3D"_blank">http://git.ipxe.org/ipxe.git</a><br>
+=C2=A0 =C2=A0 git clone <a href=3D"https://github.com/ipxe/ipxe" rel=3D"no=
referrer" target=3D"_blank">https://github.com/ipxe/ipxe</a><br>
=C2=A0 =C2=A0 =C2=A0cd ipxe/src<br>
=C2=A0 =C2=A0 =C2=A0make bin-arm64-efi/snp.efi -j6 EMBED=3Dmyscript.ipxe<br=
>
<br>
<br>
-- <br>
2.55.0<br>
<br>
</blockquote></div></div>

--0000000000000f447e0659f113d1--
