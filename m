Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A714B606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JDQd/x9j;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QGGwylwZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82993405CF;
	Sun,  1 Nov 2026 17:12:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gOWxkJ_lrKqj; Sun,  1 Nov 2026 17:12:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D00C2405D0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793553129;
	b=kLb8JKCJNeCSeOYPKSWYJwfrb0SVB59+WhAfuq86aFW63C9ejJvS5uR1jUao9Ryh/RYK
	 zG7ynfu9yl8vC7TI609pS0tZmGoR51AX0BJ4Wl5jXHk5TNj2s7/EnlZnmJrWaq6zpt3OU
	 cOeJsyp0hjC6mqIBkGssUSAK9fvUjFIEdPtG16YxMwPNqxRk4xuHl7DtZvMvP/w1IURKl
	 4l3ETdCV3H1gcTrd3DN/G/anCDNrLTsJA/9BGGbQrlnorxKKCHO650nDYzQicVynySQcS
	 aDoCVsFY8P8yivqtIgqRq+c5AztSP4fEEDyJ72pYn2QENZf9Akz9xLkoAe2cEwUvGdg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793553129;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jxMbUWd3E3b/BAPkDFwX18VQcTmUkrojickDvQY3aa8=;
	b=GdMjn2yIDvhUGEv3n3gaDmg871yswop3X9Jh6yHOvIFOf/aIrEbZh9Eu5GTLzmskk6kO
	 h/+iaYRtpiF06iiG5+TIYJEls2m+t1PXBVNAO1U0PrAmYbQQRKhh8krblKwAQBG3/kHRp
	 PYA/IIwUj+NGrHjxnq+NPMHnDHfLEt8FDeYRxxRu8f3hBI94oQkXeAHDasTyOOwJ3/wkf
	 PXIzxqx13td+ELwHuKl8XnLe+OmMccjLu/W6RiEycptoHV2mxmwdw0KcLLlVtNO1lhmnn
	 6ogNXd0DehccLoGb1SD6rJGGEXFIMXv3+QWbr2VZY7JBqVaEEFIGGVrCW57u4GvO8wg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793553129;
	bh=jxMbUWd3E3b/BAPkDFwX18VQcTmUkrojickDvQY3aa8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JDQd/x9jU8CQvYM7VByBgsf+gA9Im4SmP0NZVOaaqHYFV7kql9mM+jAF+hwiA+hsM
	 JSNCm8BJEeQee6SVpGkcd8OI7kTP4nxmg5ICAeErFffNpOYn5kG2TUt0gTPIZjQE8L
	 IPC3WV0iOWYQ1rLo7zhp4vmL1OW3OFfQMCYtk1KDw43zZq3c6+J1Vmfy3cljHKB4/E
	 bwSioFwpzSpA1ADrWAiBNhfCANerZSfh7yUM1fJ78JM+2T/b/sYtJpU1345i++3sDd
	 C+clQWTRVYCFiRwRoSJI+4NkfX/5l7VvUSszS74FbN7jplus8NxMLzPCr05KoAiZ5p
	 snEqJIt/fPCeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D00C2405D0;
	Sun,  1 Nov 2026 17:12:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 11ADA323
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 17:12:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F3D940076
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 17:12:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nC4Xeqa66zsj for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 17:12:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0CF1F4004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793553126;
 b=o/kDucaU2CiX7fzi9J/BUefRMidE8c2TG8RBQkcLB2j874DhURjHpYTETBj6uEHSH76F
 KhlxCzvWrMmASijL5X4og7n7JC3Op2cR9O5edH0WNUHasipYm7vzpGw9mK7lMqhwwbsCH
 o/4uMqahQLTudj70cDiGNoP1XvsgJoULzDYnaJ62A7fnotOM8VzTKOL+c58tNfTCoFMmx
 zcwQo9Kr+OBkCFzFSirmF+ENry8/sfa7wS5zvgWkSWmaUpYQVfdh3358hhVaX9Wyg93lq
 AiL9Rbw95xpH0ONn1Bl3yzW+K05844s/6D/JJzoWre2KbuYZKGywFWiCbiFdb0HStaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793553126;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=jxMbUWd3E3b/BAPkDFwX18VQcTmUkrojickDvQY3aa8=;
 b=jnoXH7hq7xtwCUjOLRMvpq7S5OK5ksMuaZ+FDDLM52Pz0cqEsi8d0IkLf6db3gIsEjhv
 ELoepVaakDvHexSVpFaifv+ORTUQRes6o/6p3FH/7pA79wyckVyv0Ut+9mRYKLdlS721d
 zYbrkv15egDPEoItO5/SRrprevy6EBM0MV/t8SEpYbWPDkbRmg1o3Df/EP92gBi+scl2U
 0vSd05lvgWwUzagv/S2e69Qk5rQOBXc5jC9BKN5IHdVyPp3Fp5e0IIYZ6g64V6jkaJPDV
 R+kCHLUOWAiJsWHxKR6bfVmmNSZlcjSXtLiWUv3kYqCqu9iAzwOJpWO/4aUGVZoUs/Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=QGGwylwZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=QGGwylwZ
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CF1F4004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 17:12:05 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa2848d2so3165804a12.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 09:12:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793553124; cv=none;
 d=google.com; s=arc-20260327;
 b=iC6qDwaUuQVnlPLwSbQZmj2w9hbV+5XksviZsTwnfnEWL3UipB1TuFQ28VMYD8Ktyn
 h70qCEU5TP5GcU09GsMLdxSTWoLBIZh5fYQF+/l/dzi4YKJugzDWn7c0Wz/4ZXszPs/E
 xxrWZvse2xNPx3hXran/3Y+/sjzYP6aAR3L601vKgQ75Xa2mZQxrYM4XPPLGwIKJ4gU3
 r1wrhgHR9tPVGfhGUKudSaOWx4PTv5qCEoUT6uDNhiK4taCa2FHRxer7DXK6qALndDuj
 kzkoohdwXK0e0oNHKX99DwN1q/RFQ8k52BrBRL7GeinbKQ78aUrBVhRcSAQzu+RmMS2B
 1ygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=jxMbUWd3E3b/BAPkDFwX18VQcTmUkrojickDvQY3aa8=;
 fh=QSzH4sTEYdP6s+Y8d0W/L9iVUQ8HxPcqTL4heApnwjA=;
 b=mDDLKpEkps3hcn/HKmRAIAkvd5x/70WBJ4YWSBRTSbTzicuuR9roaSafCGuGGgg0Ep
 NDv2Jnc+NKcs8wtXOnbAMkWBahLDTKJwWxsRtxcN2tA9gUHhGCeqxbDyAYH9C1rvss+4
 PVe7MBjsEl//msnQDhOEXciDmWUSDcROX8al+qffjkBJHcpyFpoVUgmCWjYEk3sNIqeg
 W3ikg4UN8LVB/PoOThWloamLc1r5iOD2iiee22JXZ+3W6VADkcrFNSeq12qozPFSo/y0
 CkHcIXL3sZRqZvOksjmoWFATcrSPOQ9CTOGiep183ELlstUVzEkUgG/7Ly4T7RXohKp2
 7WRw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793553124; x=1794157924;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jxMbUWd3E3b/BAPkDFwX18VQcTmUkrojickDvQY3aa8=;
 b=QGGwylwZOmxDtpPjFzOyy9AVOmsw2JZvoT93evaUgtnoI5uXjbHbBEi2gPRsZ/JWJH
 S2Xd5iMm/ijOnH/Ky3v4bgf1cyAudZc50+iaL6ru25rIdnDiLlTfofAZRF9oz3yH6XO/
 4mvOsgrYp/QW5nklI0t9FEID35zB0zW6gsJRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793553124; x=1794157924;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jxMbUWd3E3b/BAPkDFwX18VQcTmUkrojickDvQY3aa8=;
 b=uwmUZ7XMy4HJXKKZtEhaXBgEQN+SoumL+4yxlV0mVePkGfzT0nvyLtt/x4ozXIeuoH
 xwyB6YHaBRW9tpK5GyV2v/hukRakuGxeEaVT/mSiLSI0rfi/r5v6TpFcBk1XpBkJE2MJ
 BDdHalR1bv8JFZ/Pz4aSZ4qOUNMv2TYitI4ebR02T8cglDHDeoH+UNlIiuwxJ7mjCgPY
 d2KnSRB6VM5/vGe5y3gK7Dh1mCqI52+s1jACWNbdOv8VrpeHUXv1l301JzvjEt685nxR
 I/cpCmlyQiP+fJw4YRi5W4k7jtHcJjw78UT/i32P3mEmUrYsADLETlIu/v3qz5Z0OX/C
 AZZw==
X-Gm-Message-State: APuU4Z/ffWNOd0hFOz6PNtNNb9B8Bc8jYhJ5F3hZHEwLU4KCEQlmSXHq
 MhrJG4uuU0SwuZJ0FIp7Rgi4lzLRldOdcMYdGDj4x/QqRyNKCunIlxXiiajjdhJeHbOmZTTr+dx
 Uvq/Ogqe3hQ5RRB8u6oZ5olxUY6ZjOQR3ki9Pqvm1imOTvslCMAoDotzI
X-Gm-Gg: AYBFou3VLg6i/PDb/I0L5kWxzBsACAT3RGyeBztwEYQsaKe6hdQfc1L8zF44U4foCn0
 9GB9/vRnSCPV7a5I0n+KGIKguZBxBZkaIF/0HCaomuG1vFSlLGiUHnFfdcL6N6O0sAf7yGzZ33G
 qilZkVTT6PWk9wBHxcdFRzu86hiNeYL4t4IuRSj1ZCPHRn0BXe1LmguQ9Ilcjq0HawqlAWFaPJd
 oaZTDXOuOAmjqpaTlgCqbxKc6j7ij/nTKDnGFFn1YSyno2FXBWHXB9o5T86uvWUdLvEho1aGkMq
 OGFYp4xAba+WtlX9rIRTE2NTWAHvVgEJtbsw5TBz4+KT3PuR9so/rfhwVz5ct5eA2Gba84y/FwZ
 9Dzpc+kjjVRCjjmsIziWgbITIVLYP0+AnxMvbuet6Xq+hX5Pb21/WWztvFqL9HJqqVOyjeMk=
X-Received: by 2002:aa7:d511:0:b0:6b4:29f9:1e72 with SMTP id
 4fb4d7f45d1cf-6b4d33765admr3864909a12.5.1793553123707; Sun, 01 Nov 2026
 09:12:03 -0800 (PST)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Nov 2026 09:12:01 -0800
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Nov 2026 12:11:53 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261028054141.2933271-2-bin.meng@processmission.com>
References: <20261028054141.2933271-2-bin.meng@processmission.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Nov 2026 09:12:01 -0800
X-Gm-Features: AclHuK_pBJpEjm6OUmRKnRUF14DI1_WUhed_UG5zgu6kV8Ae7IP6OENoywWxO0I
Message-ID: <CAFLszTjfx-te2tSUn64AOB-LC8kisXrZ+3D5=X4vufsO35ffwg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] qemu: arm: sbsa: Rename sbsa defconfig to arm64
To: bin.meng@processmission.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, QEMU <qemu-devel@nongnu.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bin,

On 2026-10-28T05:41:38+11:00, Bin Meng <bin.meng@processmission.com> wrote:
> diff --git a/board/emulation/qemu-arm/MAINTAINERS b/board/emulation/qemu-arm/MAINTAINERS
> @@ -6,4 +6,4 @@ F:	board/emulation/common/
>  F:	configs/qemu-arm*
> -F:	configs/qemu-arm-sbsa_defconfig
> +F:	configs/qemu-arm64-sbsa_defconfig

I suppose the configs/qemu-arm* line above already covers this file,
so you could drop this line, but anyway:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
