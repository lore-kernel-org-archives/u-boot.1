Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DAA606A31C
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tTPavte6;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Vx83takM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6459F40AE5;
	Sat, 31 Oct 2026 09:35:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WcYm_kcqO3Ad; Sat, 31 Oct 2026 09:35:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B145540B2D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439299;
	b=BK2ageUdpqiU8q2d+Zj2iefw8V6wJZEd6VsxhtVhdaW+0qjRI26DoojvuiNrXuY2NsUP
	 mPidCYBu7g8jOGUNvXUbr4scgtsiHtJoqMYAb/1mvPsSpl+y655x3jBORWWQNxZoZ55Io
	 OXNXpmEW5KgRXcBL5IBN8U5k9mlfFik+lD9XdODTdcNLzEW2mSzH5fPjHutjhKcpLgSeX
	 aGUTWgGdHDTaPoluH+IZtHVYkcdTASMAYAe88KGIQORCugsrlsT3TQytlHMY6yQWhrn3z
	 oDE6kC/LargYl9KYFucaeamW/eeIWU/dEUHwRIzJVc1GMBQT9EGFhqFjJf7zdpeW3Ew==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439299;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=E9cxC33U8Majq3AEyiCi8quUu2KNGW2S8BwFn8KQYG4=;
	b=tShKs2EDozZiI+CjQgJoPd4AXe+3mODNgdZ8JIQrt53QC+VIbt2T5GCtmjkvncuKtk1B
	 033tO5o2YfOp4el0AyKR/KwyyztMSvAIW64p/GvNvpiP7ulJqQtWGeyWzMZAJyhM2X2nL
	 loYT4DatK7hSiFz7kPqRxgxNw1FHGldMCIlfU/qB/p0TqmVJY36MZwcUo2t1U70PmwxxN
	 ehqaRXDBT9YMPdbwEvvPGhbKRQ9SousDAqW70VDLWxDAnAHLyx09Ff/wBo984hHJfCYK2
	 WS8UCToETqckK09VsCifTJKhOsJ/6Jti6KfWsCkABYE7gWXZhGF73+5rnzMJHjeMfeg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439299;
	bh=E9cxC33U8Majq3AEyiCi8quUu2KNGW2S8BwFn8KQYG4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tTPavte6/3Y40EyV1eGIQagrJbJfqNa022LX328eW9W7odKMzKkC6Yd6sNdZyOi8a
	 JRhIpncGilMuj9sdjA/UHbxlJtHUBX4sJs3WwZPyNguo1eVipqEz8skkGRCIx+S7w6
	 ZVt2eAalwzh1yoEllnU1nVGxM/bnabW39wlLmPqId8zuaOJ1n7rgU6RMxCHqZQY/6n
	 5sPh5zzl27QFrOb9oecG5kb3Kp85GDpPQJoUG8F1nAC7eqIavEHhvHU2SivZdYNhyu
	 znx5xsUULE4t1MNRhEXF8x1+sUMP2w9AEXVyFL1rbLecYJ8kIec0A2tHDlEA1ypjFT
	 fZFiMWM8FBEcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B145540B2D;
	Sat, 31 Oct 2026 09:34:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B1CF8156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A351E60A88
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t8nWiT8p5BIA for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:34:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E4600607A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439296;
 b=iZUiyNHD9Z8uqfQivjLIN76o56WcjjxmTOrrq4LPK4dElmZoKL9gkLB/X8OejicpiXvc
 2v/y0ka/+XE1laxT1i8f1RwRXCfnA5IklTkFEijir+ijjWbr//yRYw7mxvCg9btSvkIU0
 vyhDrcZgMM7uv90OSUbUhlSWeo8tNC3AvpcDao0RTK9B/+ktqq9WDnuHP6Dw8iofJDOKi
 m2rfRwN+Lp9CyWnKpyz1DBD8L/cIuPxWvmWclpxtHQASVGNHSRLVAi1iXmzRRWMyraT88
 HGVwtVXy4OMzxczhD7q81QFNRBzeutpCbCRMibVeXEKG+h5QUrEDaPFpjTIF/LB9f3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439296;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=E9cxC33U8Majq3AEyiCi8quUu2KNGW2S8BwFn8KQYG4=;
 b=UD/knT7n6McVtCsus+mlzQWjoqjNMW7BtKIY8SriPH/7XGVhYowS4vxupPZiW2Up6Q7F
 skisE0imU0OzsxhgsAMFAwTf/FhcAUZ0UtUqNrokFI184HYmgNDoy7b15WWG+WN70vqEC
 pUgQ970ZFP8w7fUtHzBpOsClIFtVAThAUQn/VPZVMBa4zqiwcNkSJYy9zjioR29Qt4fUJ
 naNIeiNAJFuqk1tDJuBTRdQlaDaYdaEyPGy9K2JIkJ+8GXo/LLrkYoN0pP9XDXIPOo/Vb
 eIc3dR/XioHZFhtVL2SqYI6JV5RhV8nB8PJ6A5WsB9GTPe/vk+xKNyEAEsBQBF+RY9g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Vx83takM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1029"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Vx83takM
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4600607A0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:55 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3ada8bc2380so687269a91.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:34:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439295; cv=none;
 d=google.com; s=arc-20260327;
 b=Jp3eXiMyyqeE8YLnSCuHt9QdyDALly2/vBMOpw4UDRBU196qUAUxwj4CK9ZrtF3TBV
 pjfezlJWt6Dp87zBctNuGKob15kvC7cUMBYPIRW7TdCsVefpSUPdIxlEenVTfS3QU5Dw
 85F3DCtcumYnqYxKNGVFrYIgU4pvWD2rT/Ie/LJNaxtsitre5KyndAl8j7W3X7Cbz0FU
 lhO9gkzbB9ECBJndKBUbA5fiyXPHq77+j/hF02Rhm3lynsBKi+LPoOg0HgtyIrt+1jDc
 xQQxtgCCX4Db5zilmQi0Rfx8bEXvZ7JBLyq/Sm6uRz7Xbdmbk/yPFdOC25ziD0lFdIte
 Z2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=E9cxC33U8Majq3AEyiCi8quUu2KNGW2S8BwFn8KQYG4=;
 fh=w69LP6G+oepzdyrBLYxVUgU3dgDwM9LRmew5BQz4AJQ=;
 b=Uk5ERENJK8RbCarxm8nqxiGd8Ke8RRvFoOEA19V0Do+YJaWZSg6/hKeMduf2WKAkmM
 NHpARl5bsW54WXztXpSEdidL/RSZg4RTw7bFE2iFIBTt6lhcz0b5j6Udytp1nO4NOYtH
 kYAu4mrV4FN4ojgb0codiHBjOZ8tKmT66MYCxENgNj8z5J2EZlzzx63bebS/wYolx7bl
 N+uMuHlZSGeUxHGVNMLny3GfdlsqR/pQt1KRodIUO3S6yk+qBBYzcVdsexuT4wAazSm1
 gaZIX2uN1b022N3smeJ1aXNgciy7Foyj/01CHIBWxLAE+Q3noVDJanLze02DJchBwJKK
 TZeA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439295; x=1794044095;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E9cxC33U8Majq3AEyiCi8quUu2KNGW2S8BwFn8KQYG4=;
 b=Vx83takMHa/KRIR6ko2261HSaqjJXs/CGQN6PSMLqU/HtuzoX6rkghYTzVugmbbmlF
 72+lQs4oBIMemxYF46TAkRhoYR+s4TcC+RKRDACisKBjYTXC8SWSOh4/vNZDx7CKBvbu
 PvRwu+DcmwpbLmebm0gJVCczY+xnD4DmQ/WwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439295; x=1794044095;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=E9cxC33U8Majq3AEyiCi8quUu2KNGW2S8BwFn8KQYG4=;
 b=v1OMmtQJkCOQ98PbGqwRfqnryl/2yBwYHxXX+lPbOfr99NW5BWwJagPvq2gTIxvAJM
 vkO2awyfo6EPVblnqiWq2O1W2ARTQQbhjUCgnCUN5o3+ZL8SDWQKMpSaCfCwDv+xo4R3
 Y7qoN6PqgrNq6fEROSjLb2o1U+Y7uPovhGEDk68FJVDpFf0sKLcSqJ5OzqUc1Bc/3Z0L
 I3oJw7wrLuTF9BJUjAZ+XOYISebA+qNW0q+vzw+RJQr5eFdg15VInBpH1j7+AtYWErgm
 N/GbkUqUo829NXf9D93p348+2bViF+rJyVSWtZXRlR81Ho6LOdgJ1+mTcMhZ5/U6x9A8
 IT3g==
X-Forwarded-Encrypted: i=1;
 AKwUvByfxhiNC7Yy+P4AHSN5GS2XZRnEFnfzVkSCNqNlJJBI7XUdt+tU7AYZRNSTk1FivZc0oSM2MEA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJGPrn+SQbxv7qG3Nv29OciKG4EbY26F7eMmsKdq5BycsbU/dKT
 jbOVROkneqHEU3TKaQMpjsQonbW0lnWs50YqG6Om4Cu/28AG5e9PSrMBRKX+zaSx140s7H7v/0d
 e2mRK32lJGwMOg5iBsJChtjn/v4LWxFkWZmRNKSwEHdUArzL2Qo+fqg==
X-Gm-Gg: AYBFou2AiMQPmhVhXZbYe8J4IAMCCy5h00K+InThzF48g+LrriUuirWnjJbVD+j5tl6
 ZRUhwWFowBYRP+BP3Avz20tnD9vG4XaeSGAFaQl4DSL6PLvw2Ky3Y10JpKVjsQlwB/YSOeu7dub
 vrFr0HUs5jM/P3iCtVPWRUCkG9jNXxTXpv5mYcUD4XFlpr1ZC32xEzIf26cf/iHGawYKaErBpgP
 a9GjYSjrfQVDm+TQKZquMHiTplkoqo+zbaE2EAMEswrMXsvff+qtKdenHIqWnCaZEsdP/ohp26u
 tzCRl/p/+Evqk645944P81LguIBkX8uCTpxO18cZAxkUyf1ILoFutXl5e/MSItyltESpGf5tca1
 pjyFPfiffs/6ZrIPto3sp2tJp9LB0hSzgwoYACpciG3ST3/gN3umERVnsGpP2qGsRbys0EHw=
X-Received: by 2002:a17:90b:33cb:b0:3a0:ace4:d2b4 with SMTP id
 98e67ed59e1d1-3ae8973643cmr3332154a91.23.1793439294945; Sat, 31 Oct 2026
 02:34:54 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:34:52 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:09:13 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-17-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-17-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:34:52 -0700
X-Gm-Features: AclHuK9hELmvJrSUnh80sZ89bL9K4Wt40luhDA4oqCrM3aTMxDT1ydFyuRAici8
Message-ID: <CAFLszTjMOz1D921ZhBxVqWfko1NYFgWBdfR5iM2+TSAm8=vd8w@mail.gmail.com>
Subject: Re: [PATCH v2 16/37] clk: rockchip: rk3588: Rename PPLL register macro
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, u-boot@lists.u-boot-project.org
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

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3588: Rename PPLL register macro
>
> The PPLL registers belong to the PHP CRU, rather than the PMU CRU.
> Rename the register macro and update the PPLL entry to reflect this.
>
> Fixes: 165d258386a7 ("arm: rockchip: Add cru header for rk3588")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 2 +-
>  drivers/clk/rockchip/clk_rk3588.c               | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
