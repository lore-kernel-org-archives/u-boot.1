Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E6FC5DF81
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 16:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B388F60740;
	Wed, 19 Aug 2026 16:43:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e6cXsDVFiUUp; Wed, 19 Aug 2026 16:43:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787157823;
	bh=04X4TkMmsER4MzBVUEavcyYnOvOzj7cXoPY0YSi3cOs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GjHdRmvfm+zSSaUI/PDQEjPoScssfokrSUMTwc4YWYUhPlXFYfk7c0yvREOSE4Fhf
	 CHFrbjsHVOG7His6zbNB4XgoEEZwqw2V08Qtz8cuEwntxPJjtVLHfbwL4/dYmyCcjz
	 QfYI2FRNGOgHltryKAxAceVdtF3iucrQ+AE3oAqSslEeOKsRy+W+yl6KmiP/s7ZFpf
	 uljaXaXKw9tXO+6LxN8cFxntAs2AbEzQjG8+vAFEzl0PEh8ymZZUVFrDXF/HdQrDyG
	 MWswPcRJCh7TDtphZUVB0ji/T+3mCQAm6wqSisX3RGJc+qzguTHEhf1Wox/5PoXx1z
	 kiH+AibRQed4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1710860718;
	Wed, 19 Aug 2026 16:43:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6361A230
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 16:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C22E80C16
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 16:43:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o4shfW1R6445 for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 16:43:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=szh4SLgB
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D38980C06
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 16:43:40 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5aeb8c19017so2037769e87.0
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 09:43:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787157818; cv=none;
 d=google.com; s=arc-20260327;
 b=VqxYwGtftG4HH7rnuYKA8HwmcxAR5H7uUhsWErJJ4IunR6LsBz9aVLllJwWxIP7Vmh
 HIxdCy+nMCqNXE4St7oTuKTgy3bAH5KdvIzKTpjpscPtQ8YO6JSTQIhmc7hsioz68EgC
 BMlcJmdQFZCSUaf8Pajmnp/Bvw9vEFCSFljfjIta/OokeOJTwFwWPL2lR9DY/iCGQ+z/
 Xt6PgNu6lYipGs+DpJRw4BP/t6ibDQ8dCEet6pMMpNwUSd/fhxIYsyrgsequI+GgJA3S
 0cWlSMhdz8mFJgStwfCWwrb4/E5HvNoivMF6orz72Xud/K8Yirk6HTjeTCv7MKSUd2H0
 TZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=04X4TkMmsER4MzBVUEavcyYnOvOzj7cXoPY0YSi3cOs=;
 fh=a18eQ1RVpL1aWxYl4TszqN0SID7gWhf6FQKUqgWycWs=;
 b=govuUtahRwsi/IgMrGhqRTGUjyRl0nsiAQfWm2hsaGZO27SeLacIZDFbqVmRYnQgu9
 uWP4ESR0nlcwDVGzjE/G3PQs3RCBUt8baVm0+QcbgeaMLOdHX3NxCIAiDguAE3tfz3BL
 j89J65No7DzEfA/swwv57ZEA9f9p9GiAjwsNvk50YX8Osf6GoUc+eGX0D2Q4eCr0fVju
 eUZbhAezYJebCSsSMZVn944f9DnhyEemOHVnHVgHSl+cmvKdE41AGbRTJ2bQefpbKBc9
 yNUV3WSWRtSnhiTxh+YS9UuOXRW1a6NS202D1YVRAfGv/oKE1II7fLFRCMhc335o90+7
 qjNA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787157818; x=1787762618;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=04X4TkMmsER4MzBVUEavcyYnOvOzj7cXoPY0YSi3cOs=;
 b=szh4SLgB79gY3gBLkz15VPwS7US28jr7Wv94e5q2p+Ui8Hi25VLJfa8v+7GB+1kuaT
 wQDUqc+mAFD68TnAL8N5YBmySSuyGDdsXu1KGFyuFp/HV3Eveik7p82XQJsS2xbcHPET
 wWhnwpz0vN5HoAYIh4pKqU4ibUVBWn/4X8dcyFtmpbxCd48UTKoZX2sddJ3bU8Q7shr5
 KfUkpo2TwW77vuFMgdytE+Xm050a/psQqpreIkM7FM9dfxuPWxt7XCuIMeCAdxhaEHtH
 Y8Ld+4PeNq4CCZERbYF7zLX9vckNPEtg4s7j+2XZR7VAU6EnHHDWGZe4Yij2A4LYrqZ8
 GR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787157818; x=1787762618;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=04X4TkMmsER4MzBVUEavcyYnOvOzj7cXoPY0YSi3cOs=;
 b=YM/PGBg37WgRyZZO+XqsQ6jbjAOYYyILTSrl2lZCPq3Dgw/GPB/B/6h0Gr0XjWVPnW
 Xjon+AsxLmC4l9YNdNlSa0tyu67JrVdHDnp6VP3gp7FKgsHVa0KN2yvLX+9aiGba2+NC
 iGX4gyiNSyUSZEzRPpOax+car9QyUg37uVeU/bEnUn/vuAbr1wIAowQy4JynAG8X2rqP
 XX4KwSV3hDVAxtrowxv01hkD2AJzSsIqbJbK922abWzd6VVMnCQKU1+PuaKh2M09t4lE
 O/shaFInG9Y5LVJQ5X/mWxWX5gqhNCCw+yhqUz2zArT3C8T7x9MemWLZNY2fe9gJEu5f
 lm6A==
X-Gm-Message-State: AOJu0YzKrO1qZ9X/OAQgcXiz1GZ7Q/ylEkII57cGN+L32pnkPbzsDyZY
 V3cikaA5Kmm0Ys6kv4OVR0RyLW7IYTnvmLsKeMXr0rbgpA1UiVh2p8OkEPnkAwuLvmpzqv1HhSP
 fA87peWu1tc75qWe9G/2hLMe/kQWGFM0=
X-Gm-Gg: AR+sD123TWq5XQxfZM/SC8RA5uI/+F2lltnps4KZKTqCGpf/JOUPayHWVXq5aSDPjHX
 GHa8dwQVdw8CwMXzUo65QARkmV6Mh/+FRkQ5iNCrPJeMY+OKBwoybT4peTNP1YcbM4Gpjnv6fs4
 V+QFckg6nj3CNtCxQBSvmfM1PZyg6EnBGtlBx2M7efiBBNboS7QTKCQo9HEMqN3xMnPoqisZ94Q
 5Vxctec3U3ez9d3Oh/k3ZYJhmFjFL6gQGCT2xNZHj6oH77UlYgNB++hcPXNcO0SRcqQpwKrwqhJ
 QNLYpoVKJNr7oFAA6dhcxVSOCmvNhcPId72VkX3FSbIpiDDlzi248+bGJgSoJTCExmGilHrZOKh
 TSVKc/na8yqO5Thz9ff6kAhv9/4T3opmF534qrUHqfBSbqQ==
X-Received: by 2002:a05:6512:1324:b0:5b0:1eed:f707 with SMTP id
 2adb3069b0e04-5b478be4749mr1848962e87.23.1787157817856; Wed, 19 Aug 2026
 09:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260819153014.834228-1-petko.manolov@konsulko.com>
 <20260819153014.834228-2-petko.manolov@konsulko.com>
In-Reply-To: <20260819153014.834228-2-petko.manolov@konsulko.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 19 Aug 2026 13:43:26 -0300
X-Gm-Features: AcwNN1VTBfoOV6ipsVMQeL9Fnl_xHI6_pzpHte-rvo0MSODCSYnytJnMfZH5idg
Message-ID: <CAOMZO5B-Q6R652_wp=AWXURBSP8Npr_AwJUvaw=CYSL7=bJKKg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v1_1=2F1=5D_arm=3A_draeger=3A_Dr=C3=A4ger_M48_on_NXP_?=
 =?UTF-8?Q?i=2EMX6=28Q=29_and_Intel=2FAltera_SoCFPGA_Cyclone_V_devicetree=2E?=
To: Petko Manolov <petko.manolov@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, uboot-imx@nxp.com
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

Hi Petko,

On Wed, Aug 19, 2026 at 12:30=E2=80=AFPM Petko Manolov
<petko.manolov@konsulko.com> wrote:
>
> Signed-off-by: Petko Manolov <petko.manolov@konsulko.com>
> ---
>  arch/arm/dts/Makefile                         |   3 +
>  arch/arm/dts/imx6dl-draeger-m48.dts           |  24 ++
>  arch/arm/dts/imx6q-draeger-m48.dts            |  24 ++
>  arch/arm/dts/imx6qdl-draeger-m48-u-boot.dtsi  |  20 +
>  arch/arm/dts/imx6qdl-draeger-m48.dtsi         | 369 ++++++++++++++++++
>  arch/arm/dts/imx6qp-draeger-m48.dts           |  78 ++++

Sorry if I wasn't clear, but what I meant in my previous comment is
that you need to upstream these DTS to Linux first.

That's where the real DTS review happens. Make sure the new devicetree
files pass dt-schema validation.

You should send the i.MX and SoCFPGA patches separately to the Linux
folks for review.

In U-Boot, we want to use the DTS directly from the upstream Linux repo.
