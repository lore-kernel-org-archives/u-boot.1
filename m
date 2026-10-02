Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F621CA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 11:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B0C160851;
	Fri,  2 Oct 2026 11:22:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rNgweBhfxiOl; Fri,  2 Oct 2026 11:22:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9AC43606F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790940158;
	b=kBGbcSOOimd3xkL4prosDquak6WmSdapuz+wlGtXZb8oNu7E8SLAzmuAodNpMG0jRQdV
	 fQVLOG+RA6TuR4ItgOVEPZzNtoUb0hD3r0vGy35A8ZcRIxn1HtSEeiNOtNlbP7KrarYZi
	 TnTYEyPYfzZpdtxa4S8QZOtFpvuRfvjuaLSnTxcLzzJCblkZhZYDLI8LEudmdCVLxKm1O
	 jZWkKdLFOOZQp0bckr0AirF7OW++9Ex5Cf7CY+1WoJ/M07QbGAc6TFCXiPtDPobnHQQFX
	 A12Fk06Ka4L2s8yPVe5rHzZrSGj3nrY8da6o8w75urCcxGir9MOzf4OYcAKVHNf/7wA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790940158;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wFa+AMbz6MjlBzRD3/u8WP8OJ85C4uc9jwnrWsRke1Q=;
	b=FSYKJ0EusTzvkUsAIQz3/l5eX35RzRnfA9lKDFUAILKqKSaK3ToNy5cbWuKDclZWI8+X
	 gRYc4/VZWvhCOErUGNczkyrrqd+QPrmY2VPtlNgGHVoQKpMm9VEBOhYLBQH6ziikGfSNe
	 9ZlwhZf1Alc6hFjPoxnpFPDX2B6DoG4c7QFMe42rUob7QNIxqK7JzzzeLPgJ19jEfeZvF
	 OeN4WAJR17+bYn0bElgXGx4XTnjCMDwvTqh2JudwtxzxJJFFEM81sJG23trX4FmIuAwQX
	 1hCjWcVESzJPYAYF37rvb2CUlMAPi31EoBHV9PO3EAwX5Uek1+XtH9jvlnLWfjOlfgg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790940158;
	bh=wFa+AMbz6MjlBzRD3/u8WP8OJ85C4uc9jwnrWsRke1Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LMs/egZSKWPO5vxQ+pVnj8COfdJCWZKJp/Di5Xy5Ft2FqBnekOhhB+QtzhQuzbboV
	 Z01719xLjYko3fdtW/wRMgtbURjHge/skIwE0CYM01dPuI9RQaWBseJGzHq4k03UMK
	 x/MErXEducwhyN8tK3yfQ9p594l2PK5a8Apt8kFU1B8eEvKm1mgi/T07pbn86HSXTi
	 qOOoS7cGxBddmLyPmOmrSl1WwJ3/oEPs12oHOoEVIYJoYCYzcTPT3W9fpA/mmm2ZfQ
	 TFBocVBK59JGcFWAlXOKVnEJRsei4FpuH60QbTo0RWGrRFAaA1RAAuoiHLoPRWhozg
	 FqoVrjzh8wvYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AC43606F5;
	Fri,  2 Oct 2026 11:22:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CA64D3AC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C762080EA1
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:22:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vNgxFnw2qY0C for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 11:22:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F081280C5D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::11"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790940157;
 b=XGb0xWr0f+ua07IzKHPacKuuD8r7XUplsd333dCKoClA5Vgw7ji14DfsphtfMEhrV7Wl
 XeHn1fTW+whCxMgoy8VpyI4jLLYNgWjL9HGusmUqhCv9QA5duPeCS5HI8vqBQIjQBsoyS
 TygE3iDjJI00MECXhby+TjAF0r27usesSn6E3qJPjJ8mp0/fF0k2l6shKvNT7VO9KpsiP
 E7ODRbDIH+UewRSEZJi34sAXrQyaoDna0Xogfuph6pM8AA7McSKVMUDnaS8Fqh4PprrJe
 Nj6MAJpsWE0WpMJfFaqJm8ym3Wo4MfVXT7JoT5dtfMQd2AkzCglgrvD1r/cevb02Qhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790940157;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=wFa+AMbz6MjlBzRD3/u8WP8OJ85C4uc9jwnrWsRke1Q=;
 b=mbW1765G6CG8SQzchlf6pPsDJ8LJwKRILi805WdXizJyc6+KXPZD212E6IRxDqgkVNvw
 9IVT80SWuTAroSjsdmG8cIFZpZfIwO26ukGb4G9QDDVFWCIvtTIqxr8CzdsAzLdKgMCPs
 en/vj+lVcVL8Ye25+RvbwI1oBBRN8rEymmY+HaQ9CGWuVYNwrRHzNkANBRWUcAeKUgZnq
 QuwiG5PIjs8ms/s2JJR7RWomPudyk+5WemFvdFl+MMAh/pkd3ycaW7wLC7yuPh2VJyCnc
 pdj8PXdLEgy4nhFU4eqYQ/XyOmyEdnZEWuBV+eMH8CoCVI2iGny+jjTDEVGU0z7tD9w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=PQ0itv9J; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::11; helo=mail-yx2-x11.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=PQ0itv9J
Received: from mail-yx2-x11.google.com (mail-yx2-x11.google.com
 [IPv6:2607:f8b0:4864:41::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F081280C5D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:22:36 +0000 (UTC)
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-67109935888so7481694d50.3
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 04:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790940155; cv=none;
 d=google.com; s=arc-20260327;
 b=DreYUY2123S40Jh5cmbKBKH/UDwEt8PoSb2gl0ziTertjwPX73S0nqVVnWcwjbQMa7
 pRqJuWIU4eCiQ4ZE9xj0Nh3JFu2Z6n+zubAVZxMLnoU2BWx+H5Jy0VOImKO1ONF6cmgG
 U7OXshaviNQjeaH8Z47kJ+etmtnt0pO1HinRbrc+O43j2nwMtKWL93SwUqmoiOEAymKp
 wtD7pOBFddE1SVKrgfOOxnn871lbd0Di/an7+4Qf1YbKcFiCWXdEfKeiLrVCD6ibYXeP
 X4YDjQki8q7h6Omw1AnnlHnyVrZNPke7NxRl34c1u8JatHpMZJDqUt3EB1jT7Up8rZH+
 z+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wFa+AMbz6MjlBzRD3/u8WP8OJ85C4uc9jwnrWsRke1Q=;
 fh=nuBf3wKo1f6h1jUIZsacuBBNlSv8DnOg+7qF0rK2IQQ=;
 b=SouVst9auR5i8mNHAWTPQOGp/xQrsdYpQmYUHPX5bhHTmWkOCvTA8By8d0IZm1bPqa
 q+aP0tBHT5ZcyG85bviWNWCR/sCJv7Mn6twEQYEbiTkqNTpEmRF7HqtkM/+pI70rsYfd
 r1/8VqxccfERRJELX5mr++ReNoWrwD0FeM6OXOSeVC1QlSzy4GFcUqIkXmFhvqMChkDc
 eNFA6gwocm+oYVmn7c17TxPgRNjgF83inRsAUFM3GrsOWZ0TFu6cRttvl70asWJnfLQK
 UxyDV3PLXYDa3Oats6kMFo8Dzf4kpoMP2z1B8f3BG0o2vkmcKVrT7KJVjsZ44GNdnmtK
 KBRg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790940155; x=1791544955;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wFa+AMbz6MjlBzRD3/u8WP8OJ85C4uc9jwnrWsRke1Q=;
 b=PQ0itv9JodbLUfwKwEpTbRKpfigqjhC8SB4CLSiUBI3Ltgc2qPEA8yUGUmWeu+iims
 KLqa6UJCeMa9NUBBit66o3s5J/28v7UQrjQODehkxTbgfKr/chJQXPMFsApHOQ2ZDC+h
 nu9NbPfHP6Ak8XSPZZEC/mPDuYE3yBVaRHmfuEEowTI+sbn+0nS6cdWdYMJg56uXV5Du
 WrF6i1ZyGr65hnN0/DX5oCZ8EiusNJYg6XzJCuZ+krc+evnDxPstUTBNfMx1thJfgFxr
 Nw+Urv+CsMVRjXp3h+b++FgU1MWTXXBV7NNcF2flervmX/pVydYAvsc5ryyAdmtaqRxZ
 z0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790940155; x=1791544955;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wFa+AMbz6MjlBzRD3/u8WP8OJ85C4uc9jwnrWsRke1Q=;
 b=QZGVm1WtmYIZJzlGECwDC7IhgttOcwu5JSgDBCawD2rvKkJPu1zkIKLg6XYlV7u7Q3
 tCNqHk/4tC7whfMZw4PcpLoiFM2lTfb30A7eTk5W758iGKQgcO3k1Gf3sdfuM+mAw0va
 eP8byr6jvXFejSqZXntwBZxi8ACxo0hB0EH+zTRE8hHcU5PCdoVoXXpuLXxhho4ArgXL
 6f+rZlygKH9LMaYwSbqCieWcf18iG9wr+kZBpbaSUcyDHI3EINM9/U7xHWJdCSbi//Nl
 cYKLaGIJ6U72u4UWqrIA2cak5lCmUezP8EYXd8w1gDbIHI2dypSnd9Ueme7tMSCCuREl
 +svQ==
X-Gm-Message-State: AFq9FYKJdNdpLTpo0XCKh8jrxjnhLgQhtxNKKElyKZBZaMuaSwQr4EGj
 IuhfYoOOL6PngyuWyqvjUllH5/qYYL0ebi50yyGfSQQeQ0Yur6Mk2GHH6zz24QLgsUtigvxb+Sn
 rCrUwJxllIkhAOxUg5JNk3ngqd67rZ58RRjZr2oOLdA==
X-Gm-Gg: AYBFou0t96FxoM8w6E8JQodciGiTC22U5wz9Ht7ckhljdhU1u1ZEA90BKKiTpFShAJr
 PvktwFKyNMZxp38cInp7jPXhd2n1bQv9pfselhRnBSTiMix1kVHq8qngpMweYE+fZGXNUX8ueUL
 MaZXE+CPL9rfwlhdvimOmpg641X7QoMPJfmaWbrI02qB1bayVRLyZUt+dKQSzNmX/FbmvnA70MC
 rYSwylPCQiWaB5luJhNjMbRL2NWlUQb1uF1OXDzoX+oIXQdB69PkhHsoeDr81KG896g6wdfUjT1
 /07qLqYHSgPyFmMDnPnUPtpOi4d2iHp9yB+af9jWGSk5Innxi2At7n8TdTMCUPl6XqQxBUZrB4e
 1sq2sN7U2patTyEpcZV+rFvSEKvQsVeZqPO94HDSao5L7UjsW3av6STBCiX6Dif/tG/7Zs0W9iD
 iTJO7NwnM0iEn09kQbWEZfczsUWLKofnS871Qg4G4FSZJDlPdfa9ZtBCW+1qY2mwUyR6XdNxpx9
 yfZMpqjT+U9CU0VhG+3fMaiVrLAMmdLwrbsHxssT+2m22NATf59+uC2JEKz17xPmCG2JHmzkPM3
 YNSVXOQbVgQkp0jfYAk+4CqOj3yI5niNNNuC4Qf8FQD6TMdPhZY91wzyG0jIaacVbC4wM3+m14t
 csFx39OxZJ4plQVCcvbJORtLqyoXxgSiMATRvVrdm9YeKVP4MwvDA8A==
X-Received: by 2002:a05:690e:488f:10b0:671:3add:3af8 with SMTP id
 956f58d0204a3-677abde2d8amr782824d50.3.1790940155232; Fri, 02 Oct 2026
 04:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-conform-v2-0-daeb00359af9@arm.com>
 <20260921-conform-v2-3-daeb00359af9@arm.com>
In-Reply-To: <20260921-conform-v2-3-daeb00359af9@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 2 Oct 2026 14:21:59 +0300
X-Gm-Features: AclHuK-vaAzASharntzhg5eMT07k49kvinSbBZrc8PNf9Jq84Id-TEhzqvmY5Q4
Message-ID: <CAC_iWjLn09KXKv4n+XOQXRk_gMiwx2oJMvqWHcW--vLZVSmB7Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] lib: uuid: add EBBR 2.2-2.4 conformance profile
 GUIDs
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Mon, 21 Sept 2026 at 16:12, Vincent Stehl=C3=A9 <vincent.stehle@arm.com>=
 wrote:
>
> Add support for printing the EFI_CONFORMANCE_PROFILE_EBBR_2_[234]_GUIDs
> as human readable text.
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/uuid.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 16ca8f37751..18fe2a8a8f3 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -261,6 +261,18 @@ static const struct {
>                 NULL, "EFI EBBR 2.1 Conformance Profile",
>                 EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
>         },
> +       {
> +               NULL, "EFI EBBR 2.2 Conformance Profile",
> +               EFI_CONFORMANCE_PROFILE_EBBR_2_2_GUID,
> +       },
> +       {
> +               NULL, "EFI EBBR 2.3 Conformance Profile",
> +               EFI_CONFORMANCE_PROFILE_EBBR_2_3_GUID,
> +       },
> +       {
> +               NULL, "EFI EBBR 2.4 Conformance Profile",
> +               EFI_CONFORMANCE_PROFILE_EBBR_2_4_GUID,
> +       },
>  #endif
>  #ifdef CONFIG_EFI_RISCV_BOOT_PROTOCOL
>         {
>
> --
> 2.53.0
>
