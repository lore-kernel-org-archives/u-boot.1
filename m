Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D231DC5CFDB
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 21:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3D9B60823;
	Wed, 12 Aug 2026 21:48:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6guG0GWFPB4k; Wed, 12 Aug 2026 21:48:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C992F607D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786571313;
	bh=ZapjrAOWYnw9Bd0xz09mqnWvIVgaeLnfpm8AW2p4WBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jgltqYKuR644m6cXst6ZK+b547UL2e9a82Urrgfs6h/U57TLOpsuU5MkAYajmzdrU
	 UHFeFCIP16nbl3PxLMS/6mitzWvRDcPm38EjALbPKcxfp40KPMTTB3lq5n03ZfSU0k
	 7g4mxxYgX4lVcpHmX8K1Co+UtoPNAxnqxVb7VEEx3CSs64tGIr4umMbQ4vl2i3lVaJ
	 oDymPd7LKIXTlaYkg/pP6oPKgJ7PmrMxcvnbWeXfFTpFWOr2U4vaPNCWqKYeMSAN9Y
	 2MQFSqLtz4D+vghhVor874dAxjNKC6dsLd1j8bFhya+3lKP+1NIVEInGxEtO/bmeg2
	 YiC4yYN9Eg5GQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C992F607D8;
	Wed, 12 Aug 2026 21:48:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E2951B8
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 21:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A23C40219
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 21:48:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OmRJXScKz57w for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 21:48:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::136; helo=mail-lf1-x136.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 59FD740233
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 59FD740233
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 59FD740233
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 21:48:32 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5b0f19bea2fso1851255e87.1
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 14:48:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786571310; cv=none;
 d=google.com; s=arc-20260327;
 b=ETrd1c2ZTAilWzw+NkREuH4vCQyZY0a/HdO2h4B3PfCJAI2QidylRnWPMX2Df0kx/K
 c3CqEJEWNSRVBSXMZ70isHk1BVzbAejwXitisFaD1751dfmwtnOOVOZUvwdDHAZLICIf
 LYG0kdhuF3wHJAs2xThoZZQuFsCQ9QiWLCIJ2ov3KLVAD3EAwyUQWFwGCpp8q44Quw9g
 FIkG4WuSweWWNHAPXn/gCPOz0m4aag8b7NzR32ytntqHoqlL+LgF+XyuHc15bUIkucWQ
 aWYGUjoE39i4HopxGTUe+ZNwF2p5TFA1oIC+47cN6YT/juQEZvc65MjJUXL2eq4Xw38I
 VK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZapjrAOWYnw9Bd0xz09mqnWvIVgaeLnfpm8AW2p4WBs=;
 fh=Es6pUU3EloXmgxMqCxy76fvANOefu6qke/GTLbG+KXQ=;
 b=pyFBE6qDbij9/8M8mDJ5cmD512MjQ0dPiKIqdn8qsFGlx1v+rZPkiNRnfoBzfDHQMq
 4maJfAQZsH91sB3o2mE1hj3h+nb2l+UxlqVmaxjPuImaxiX8m0ZVrfAHYDAduTdV50mO
 l80E4y3U2uTZ+9iKqVGI451ovXZ8blTSFBcZrjguDLx8QaO63vk1W6yny6iH+at8z7mN
 QxeruAc2fIFY/AJYXfvvTAjyOw3XQLHzXIpRK/ohs+kVqN0FZ5GBXnc3Nhi5yg9MrADK
 NlMXi4QEGY6zENQRm+/R1lGJHXPFmac/uDEhnRoYRvuaLrWLe+asoZznVh2KtCRBh/RT
 ViIA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786571310; x=1787176110;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZapjrAOWYnw9Bd0xz09mqnWvIVgaeLnfpm8AW2p4WBs=;
 b=cLxL5/pnQvLGnpKWu/N/IcRKSqXa14iQcO1eyJ5OLUilGNUgd3drHfJ3nmDpytezQx
 +8IfxJyVJnLYehxTj60Dm0fCLEmpXSAJ4LESmfcyhCiDOCpshv2oKj1TR0FVRdFpZAN1
 hdTASkhttgQZvJbNWsqae5f4q1zi0Tg+jj5ogZDWcpciMGZ5gHgqKkFOtPbxzF0j8Csi
 QQS0cDHj3ZfBcFjkLrJPrhTLTJunfrrZmcRsWcM0vUmkRsGR/hDDQoP0A4WV2JFtYrTD
 h5LlSvZHJ3kDjf34SkSzMemW82NTLKGICNWlyhOlG9FztHm2H3A3YbamzkwkBMGF0hRw
 uWrA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFFiaxcp4h9yZ9UoH2at/WVSLaZqgGG+HjQAjtywvsLwGUh+KEWQDcjtTVxDvlOmbpft8OTn0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyEgOwY88dwDUyni5MsIeWi/4gGv5ieru8Mgu0YugiRTSoGjGQe
 G0NBGEWAen2Vc6Rardp5C8fAL98u2K4jVCrRTO2pgqzHUuvezWYPQrez6pEpn0IN0IViJo+Fq9R
 oT+STaoStq473ATwMy0w4YKVES2r+iJqH2ACC
X-Gm-Gg: AR+sD11WvPlKK/P73ZeDNWptPzzGV0DKjEGL3+Dz2EQ353aLl9vaBRvRrmV3gZI2tVH
 gwCmvnH9BxKseAZmO6bkRipFCnLiAtNaeubRTDRjcR7BntKLULYZPvRbq+dZGz2GIR4i4j0zsBX
 NAo9sN6JmesNd9A4TVQlLbMsT01zfncVw0eem07uGnXF/8yoTvUd5y6d6eJEmSytPMoBqV4Nt5S
 Cbg7llq25A0to3a8u3VqelZjLSnfw/j+T5gKqO/N8zys7g85md/poFGjlp59pkGod5b41AtuM1i
 P5AmNAMvDH+yfBKHO+HbV6yjXOmmdCdP31iHS8h0c3ZYPlJJDR69ugY1iTH4IdJDMwLEnXKhtsT
 Nhj1Z4qmr1iU3uP6Pc/s66FfitK2P1yXb
X-Received: by 2002:ac2:4464:0:b0:5ae:c8da:6254 with SMTP id
 2adb3069b0e04-5b453f519aamr69520e87.22.1786571309574; Wed, 12 Aug 2026
 14:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260722194638.1285159-1-festevam@gmail.com>
 <20260722194638.1285159-3-festevam@gmail.com>
 <d4d49e17-e125-4121-b0be-e486e1be5393@0leil.net>
 <CAOMZO5DULY0wE_U-4aX9sfrnum++J9iJ02_H8L+g3qdY156KCA@mail.gmail.com>
 <e5aaed12-ec8c-4c8b-8cf8-1c4f9bdc2174@0leil.net>
In-Reply-To: <e5aaed12-ec8c-4c8b-8cf8-1c4f9bdc2174@0leil.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 12 Aug 2026 18:48:17 -0300
X-Gm-Features: AUfX_mwal9RHOu8CrbwOs8lDGyXA4m5KAjUdq5RFJiNNOMFIpd9hNtfSks311GE
Message-ID: <CAOMZO5DHz4z+VmfjRyTxPsepXC7kFMPr+29F1yD-CZ5miwCUXg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] rockchip: rk3399: Add ROC-PC-PLUS board detection
To: Quentin Schulz <u-boot@0leil.net>
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com, 
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786571310; x=1787176110;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZapjrAOWYnw9Bd0xz09mqnWvIVgaeLnfpm8AW2p4WBs=;
 b=TS14NQ4heoOqCqmdRjXcSUkyYx4+KYdTymmaLrLQ/+pAvrzz4tvgLHfFmLsTSt9kr/
 leW5/4rG41wQOCy67GZ+Edn33fMi0Ul8wCEmKAInMk4CG6VmgPY5vExrAKMGHXkDwciK
 w3vI8eygCancY5uTOhyQCAKoJO0Ch98oUMuHNeaezjf/2QIG0J/8aF6nXy/kC2iT0uIZ
 8sQxS6SZ4opa/f8lKxJVGzBhfo8H0kltn5zm8X9HQlVcNGgpe53L7u4XybUNby/uGt/A
 Oi3CGk51HosH/sWk5ndvUlSN0u7GNV07H1rumt8KoVc4ug66AAV7BIKFXZjxCxeqMvgd
 wuuA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TS14NQ4h
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Quentin,

On Wed, Aug 12, 2026 at 5:05=E2=80=AFAM Quentin Schulz <u-boot@0leil.net> w=
rote:

> It should be !CONFIG_IS_ENABLED(DM_I2C) as CONFIG_IS_ENABLED is going to
> add the appropriate prefix based on the current stage being built (so
> definitely no SPL/TPL/VPL to be added manually) and CONFIG_SPL_I2C is
> not enough to build the dm_i2c_probe implementation, we need
> CONFIG_SPL_DM_I2C (well, and CONFIG_SPL_I2C because otherwise the
> drivers/i2c directory isn't traversed and because SPL_DM_I2C is missing
> a dependency on it).

I tested !CONFIG_IS_ENABLED(DM_I2C) alone, but the mezzanine SPL still
fails to link because SPL_DM_I2C is enabled while SPL_I2C is not.

Checking both works:

if (!(CONFIG_IS_ENABLED(I2C) && CONFIG_IS_ENABLED(DM_I2C)))
    return false;

I tested the mezzanine build successfully with this change.

I'll use this in v5 unless you see an issue.

Thanks,

Fabio Estevam
