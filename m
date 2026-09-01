Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D463C624D4
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 13:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 758BA80B19;
	Tue,  1 Sep 2026 13:42:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZLxnptPuKXq2; Tue,  1 Sep 2026 13:42:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788270134;
	bh=nX2kCjpVO8CotH4e7MEUzkOqU4iHZCrHvlp5x6CBp+g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RiPAk/M9xjbkeWnXWK7T2ZY7kJc8sfv5YoAzCDWl3x2Lb3EvySpXIGtuall+YWtFL
	 dDrbFbtjWiE9Wu9Xf2i+d9jukDi4AWcj0XVO6mM92qXvdVwk6pVOvflceniizqP+YI
	 W4aMaZK6p3i0m+yrVjRg25T83Uq0Ufrv/oxgDxhvXXEXZtl9wV5SVJvOoiH2bDMkbd
	 wVlfZYV/nzvuvSIiNGB+hKWnVdoF9bq1gZ8DEdWzQae6FMGnrojGiZpN326xuiC+bj
	 bbT7884gf3xoZOJ99BvqC2rE87qnUKps53NpAc+/YB3Q1Bn8/a6flTmjp9gxyujrmX
	 Nd0cIt5z0pzzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D509E80A48;
	Tue,  1 Sep 2026 13:42:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BC22C265
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 13:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AEA8F80A48
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 13:42:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U8NNt8Ap8X1H for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 13:42:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Tg8kMxcp
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B8CE2809E9
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 13:42:11 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so172436866b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 06:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788270129; cv=none;
 d=google.com; s=arc-20260327;
 b=H9VB6f7DN1G9BLzsUVPG+hk/Jl2Ot0Ers3ALTtj7UZlAWoJVfG73Hvp5d2yDAW8Q0v
 nLPgcnS0hBDAlp077a2Mw5Ga47hUlkjOjIt/4TUnf4cMAyGpqMceSsjo2v2EdqFZ2JC8
 ac6jAU1DjspU/eNjEkkH97qhPNrsbxC7dMyJBYOeesLLd3zu5R/d34h5aMi/0iRd4uH1
 00GiSF1bsFOcQKZx5sv1TrQ4osg+j2PkLT1Ds5nL8YR7/A7RupJTNu5m7e3+1w77HjtI
 WbQj1Uw88sQps19nkHnBb5lVu9KXTuGcCXInJKSixgArthFYW5kfD6g1GrfLhg/FvxsV
 LBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nX2kCjpVO8CotH4e7MEUzkOqU4iHZCrHvlp5x6CBp+g=;
 fh=JNc73bNuWjuQX5QOm7FvD/UWaLhnQTVKINv3CTK9hHI=;
 b=GfRPLC073fYn9DtpTQgf7K3+HCVEBYRT0uHzwR96Usuu72xTAVVV++E4svzha9Cx/6
 YSe1PbUZ8iMXhVZG/o0NT/agoMSUcfxqw8pbuc7iUUEgeHYSUXKL3Gbr5oamq1yASivx
 mxlVkdmaR6y/PE+KniEdYnaZIbzb6uaxVw/JPywPPuiMNoRoEroi/X0LpO6H2Uqt4wKm
 HEenlZJDzy9+t4v2SjngC+QBgmI8B1v0iO8lhhsRJ/yRI8/RoWoQy/FaWwwXxraiaiFN
 3GtJm7Z22wQ4/7hVmoIXxIZ+wmAyFe+ylnfg2jHMWIxp6Fm90FtIvIB8Z9DfAgUfVy7S
 Kdhg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788270129; x=1788874929;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nX2kCjpVO8CotH4e7MEUzkOqU4iHZCrHvlp5x6CBp+g=;
 b=Tg8kMxcpSJGW7/73DHoYyqWqy52koA/Cs3eXC1FMaI5+ibBKJOpgHUrKx8AxP2Ymfs
 cQnviyydXiZ5Efati3oiytV4vQHGpzW7hV15jBuF+Z58WER6ZUKv4l8jaVvh8QD8VnCe
 YNi7j67JqA+2rw+QYgJ1uWgj3dWjKKCWUIofI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788270129; x=1788874929;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nX2kCjpVO8CotH4e7MEUzkOqU4iHZCrHvlp5x6CBp+g=;
 b=Buu9iG/Z9A6jQOZmDHT+pe/SPIfqmj3rLtlQqdrx/wu4BFyCe+tpxr2QiyMrjJ/0Ln
 xs4NgdHA7pBXho8LY5aipjgxHfoC+w2KKp7vQH0RlPC7bHsnf3QTVk9oc66nlDwd1s14
 js+zIp+wqCicC7FnkZwtYcSJvsWsTlKIinF99NPnLl5hK56HrcoK+91aZ4VC75a1zC3b
 IZssp9+isQgz7FRIL7rTBijmk1GARTcXfbeIutBruWyzUZr0u/yQiQ1MDk0QZ8h/kge3
 TuTW30qZaJKANhTBIykRubmUddI2AfBmUuzWECSGk33GNCIs+1SHTt3Ia/u33zGT1rd3
 AVEg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8MsLC4udFCrLcCUZkBu3Cy/0zY6PDtctS00CZDvpu9hkj1M092NDazX2Xw5yekee+xXEIER8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nuXI/vw+5zag0/7CHkG2TUCfnSxuChzsc60g5XXDMQrHlIJyUX
 fj0M7swEG8uT8RcZd/DrZ/GPIORUs+TiSHfbeDvXJyFNojv7Whsh7LJ8v6HMdXmpV4OSJV6Ag7s
 jlictb0xkD75t+X+hLEi8jxNW+dILZZkI7Ltz8/i8
X-Gm-Gg: AR+sD10afmiGZUfj4kVARJb6f0BCGYPT/OYZt70JISiF7WObhmJNEm/9PIuRfG2BHiZ
 fUjp8UYxHHH3/yu9P5jIFMGOPOVQJRHlPMGSNjq2A0cAYutQ2xa2DmZ+b+4kbbC/PiS7A9+Lh2a
 Ff7DBy/Jzp7p1lf7mX+dO/2hTd2LFiJMuIB3aG9TnSFQqw6sGCEJIZva0YICnDPGsHp+eb9QlIN
 Z36JQu5o++LfwHGiKu8OZ3pr4T6i4B2J8dyrc/eqBZKfkCHQ/WZiTEC4vsvb9F12YBTn587lQlO
 QeTX1JL1zjKVROTRk4VIdf2N8IvBdiwn+iZZIqNzSbI=
X-Received: by 2002:a17:907:3d4b:b0:c25:35cd:fdb2 with SMTP id
 a640c23a62f3a-c25b919fe1bmr440664466b.7.1788270129036; Tue, 01 Sep 2026
 06:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <ya4gsjjicokwdqwvqwdoho6cf2iwo2ecrgvmfoappavszwml2l@tnxffaphc74s>
In-Reply-To: <ya4gsjjicokwdqwvqwdoho6cf2iwo2ecrgvmfoappavszwml2l@tnxffaphc74s>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 1 Sep 2026 07:41:56 -0600
X-Gm-Features: AcwNN1XJ2oc--iM5y99FM8Csw1zMQgtqSzp8r67GO84N6FLe6jqKeRQIrJ3NZnI
Message-ID: <CAFLszTg+M+Kf0f_6D_HoM7faWWD-5Rgerd=o2hRdB3GLf-SM1g@mail.gmail.com>
Subject: Re: [PATCH] avb: fix missing break in avb_set_state() switch
To: naveen.osdev@gmail.com
Cc: mkorpershoek@kernel.org, igor.opaniuk@gmail.com, trini@konsulko.com, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

On 2026-09-01T10:19:24, Naveen Kumar Chaudhary <naveen.osdev@gmail.com> wrote:
> avb: fix missing break in avb_set_state() switch
>
> The AVB_ORANGE case fell through into AVB_RED due to a missing break.
> It happened to be harmless since AVB_RED only breaks, but it trips
> -Wimplicit-fallthrough and is fragile against future changes. Add the
> missing break.
>
> Fixes: 5d4fd877733 ("avb2.0: add boot states and dm-verity support")
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
>
> common/avb_verify.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
