Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4882606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eUCjmL94;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gC/5mpoA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92E56409BA;
	Thu, 22 Oct 2026 19:45:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VMk-_Qq_MJNZ; Thu, 22 Oct 2026 19:45:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A1B454099B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792698326;
	b=RBWbOZkwhECX8iDhHmnbfL0Lna6NWHGBJma32Jh15ElX6cZiSuLClib7mI58fGNtmBOY
	 t2G4Gwo1n5nFtWyLlAEDhsnirM+ewhL412Rflmmfz8a9EuXBMoahFwr2fFNuPHXiazBgD
	 X3mCs1/VqV49/oeUdQJKmtKp2DOlVDfzV2cTEXUKDoQO9gwrLIU6/NbJuY8Kf9FeLJB4g
	 3VsUjFKYKntAIgl/h9oYB+fUgzjVi3Uqr7tuR1fVU1xfwJiDKHpq0wwrkFEnMP+Rz030Y
	 xXgKpD542UACm6IVijFhsG5Ckcp6JBPWr/+KRO4a26AQzebubm5XzVhyp78YrtXi96g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792698326;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=DDyOrYi1bFnjDYuWpSGASqMArOlNlFZD6lZ3gS/gfn0=;
	b=IZrxi+CDJrP3GrztLT6jJ74s7WA30Me4R+piW2QgfbBVjmvFfJ67R/KRaK/ZuhHZUVl9
	 UCxuWkuPwQwpmwX7yFhWlXnQ2S619mKSHLeU/+0tddRWgiTGN5EKk37TFCVdoZHkbDXsW
	 Amt2epPE3nUGFKcfPpGHJ6rRbRuO5L746FrVfTRiu5kKen05Hy9m2HwBz7v+UNbqHyfBX
	 Kryy1IKcQ88509RjfVXxlVMuHxmBzUUbQDy3Ps7U2HmTG9Yjfz4xJDa7wS4AFm4fyK4S7
	 zNi6E7lpVo2G/l/69lcPZW/DLxE2KTcpJAZLWo/SOwfZJ0YMtghs39yTZxAS2Z5F9Qg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792698326;
	bh=DDyOrYi1bFnjDYuWpSGASqMArOlNlFZD6lZ3gS/gfn0=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eUCjmL946ooh+vEKsnJBtWMXDTpLCLSS63aeZ5Daj0JVgyTC6r2VuBSYbzZp8+BCL
	 p18LPNNZmctOs8dIA5T4+KrrmSBQ17NZcwHbmMkRWTv7Xjt4DGy1cbvESUVP0BLOAF
	 DxmhXXynSDAIYFEshPzLjsZK/tBKAvgUx24BzIoyibVv03YllkuqlSaHyWQeChtObi
	 oAwMZopFfcnoWVaEYUW4QhgUMhg96zWORwwh5dqJetL9uopgm5hyn/GsM0J0ZUxLoG
	 GwOUa21nmHQVMr+VPVASSeuTVXbrZcm5XzuBk+5PgAePn7lP1JGc4gMhwN5PHjFvCI
	 Ky1sijJcFAtlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1B454099B;
	Thu, 22 Oct 2026 19:45:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 40A013C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 32AA6401A1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:45:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wKg5fR0suHvp for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:45:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1B45E400B1
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f2b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792698324;
 b=UyBvP1lBUXeo7mP41SHzjClqV3aXg+ME54BsUGQEr2Xg8vX2lR02xtvqtWYOL5FXg987
 dRkDKkeywnpuzQvG+DE9l/P5WynNau/xjM0yTCqx8WDV8480Iatf0TNXNfTyvb5a1rIvi
 SVh9dBxBmhTXo3jyf6yfMnQRjJF/IIC46OxGVri9jm7lzgIanznFcDN+PaOMmVf5J7gUa
 0YWaDTayVMH4a7Q6d+j32VKo7GwGHPTRaU2qqWEFKASpjaVXOe0qdP1rS7PWFK1rJ5WCU
 6/Rsq7GogkK1neFN8zkMXiBI6QAU5/wSJRlZ+P+B3SuuhtJ89tGULUU42ZvPd/sGbgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792698324;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Content-Type;
 bh=DDyOrYi1bFnjDYuWpSGASqMArOlNlFZD6lZ3gS/gfn0=;
 b=P3DhZ2p3xp4WPKGsd6EMNFEadnzZVfNmA8IfaeCJIXKG/kETl15+kVnjB2iUgGPDc5mL
 WkFJKS1ilGsPu9Fr4Zf4G0IskcWntowsldwOYhe9WnkiwNxZVQa4nk3BE3Do5IvmerTLx
 cRqVrq1UrYAcL3UkwXhVx1PrSGy59kXyOLD8cv19Omfv2x9Ge5bIP9HkTIWKlAR9HoCM4
 1LrBKBrM2AeBloObcB9OfumxaiMc1kVal5z8Dsmgq/rOHrHkw+iTW1Cd53ti0x3feQIic
 ZRkiK7eMpMnd7gveVj29GCOHBJ0LTpzL7XzES9J2gqbhj+29swqYDpESB6O3TaG3Txw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="gC/5mpoA"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::f2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=gC/5mpoA
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B45E400B1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:45:23 +0000 (UTC)
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-91befbcad6dso3391916d6.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792698322; cv=none;
 d=google.com; s=arc-20260327;
 b=qmhS2x2TQastpBF6B3sX2/LxdRWYgMbvEOLuLNWr/mliEZceOfIfPJFnzTTDN3jw82
 32ysEdMuFkhr60qV6g7+fjW6x1IyseKzSGYwieosblYt6Htq3ZtKznkW374JWVNdFZ+o
 F5IJw1Z3s1XgWw7oqXotepM1GF/IjTideVT8H/FpGmyq2Fni9Nvi6r4EcUEBszfOjYfy
 4rX57Szp7cRJUYT0hIR3WCLpI+xiWlbVneVuyF4P60H/nrlUyMWBluB76e6uZEDAnDkH
 tTKRSlE4WGE6kOvUv9G4guvSE3MllnaF2fo0k2YyaKjjrDqNn0qT1Cs+c+lx/PHVJ6xo
 PZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=DDyOrYi1bFnjDYuWpSGASqMArOlNlFZD6lZ3gS/gfn0=;
 fh=CypjphZz0uuYnxzP/+VDtahMJjRv2gRIFzffUTPCLdo=;
 b=Tag2ZyjYvIxiOBQlrQX5LTMopR/2pm5tF1O/wVeqFRx+/C2EMzDXi6RbPH+lOn0rld
 x/jr6quskITmAIqs6+DcMWUgGOG4sdPNUccRgT7cncooYs82srXdJfAORjJIIh2k+69v
 reul9c3IBZ/+j1z8hCnAF6I3Xwg0C9XJKt7QfYgJh7B/FUg+A39lq0InOeY2LTdAj3SY
 ooyEqcPczp69sD8RDHwrcucPmt9RHJ9Vq7PBTvyrLa1z3jCzmIr0aCiMBmJO664hVCGU
 Ora6cJGjS1HOMTyvTLt5Z9rYFmP1s8R3P3ZFXmZicNNSygisQCm0ZOvcnG/aykCIGjfC
 s+5g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792698322; x=1793303122;
 darn=lists.u-boot-project.org; 
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DDyOrYi1bFnjDYuWpSGASqMArOlNlFZD6lZ3gS/gfn0=;
 b=gC/5mpoA2PPNntH940YRRC/lcoxW1lYtuucabV5ZAcpUQ9a+R0WC+yA7tR2/o8oPPR
 GQdskwfh+CUanTBfpIMnMpRcP72zBFY4MEV5xALvo7cfIKeDWH/XUyuOZtD3OZE/umRy
 xb1peKGSIFcyPeOoTghvYG0xkKklIAhCK9xYVb0jNPdXQ9Ri85T7DebOAYE8qoBFRpzo
 CGZcN9BvnSjOCLR7/TPzG1AZqoNeEorH4VTHDEwEqosSrdbPLHD9v0PKH91n+wkHonQA
 TM8qqMmJaZgviGrwRTzfnJdXxlAVv16lsZQSn6U9Bh9IGBT1RQCa5vLHCOG+Nsw4o13i
 vrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792698322; x=1793303122;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DDyOrYi1bFnjDYuWpSGASqMArOlNlFZD6lZ3gS/gfn0=;
 b=AO3tncptcmEuVPTVFI60fTKDAQhy89o86dbh+Stst760P47GW4tGHK4LUruLRcAciy
 UJDdz6clwvO9VTH1sSUHKGkD7EKChZHt1FbnVPg7CIkOvmkF2V/9OU2gXzMy8Q5D9+b2
 ScqjftPu4nq1FPCB1+cYuX3arP4lzPv1U2guWv7o9kMivrGqu7rkqH9IaUqWPGnJQGls
 lsIPAjKhJfGEB47KEFX1+D4VOEHMFY6hfhfNqI/WdV3n8ACPGCMI09N8bG2SLuaLCrcD
 wNnrV9VxCh9GWjOVtD9rWbhLAQBGIk1U5AznoQSJWZUnkQhfZHbRzgw73TcgJaCi38hn
 nLVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfIvjrKQ7l+61GUSEp4F/jHkrVv2mrwgrKWxlL679ltl3dMuR5uSZNlyx4gpM2OvqtrQv45m4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKJXfEWpFZXL6SG69T+7TKKriyn4BdjJmbsPFV729WRMxAaMNkC
 xUjNFKRi4vv21qcyou1xxpMxclicAbp9dglKTSb+h46k+cdN46YplIJg8s5JhI90tVsaJPRdsYH
 M555/BxAatM4XGazlkB9jzrNmz5PlH9UvIeSk0IE=
X-Gm-Gg: AYBFou03c+OUrege51OtoVINlJWZQ6YTqXa/KBSFrBNrCZ8VCx7UMC35+3g6pbbNFS7
 4tKgTmOz57IIWngwFnzWVyBZPjQai0Kub5vMroeWNbJzY7N3vDccYdD8Tfb4u73HevACBp2KUpm
 5ZqpUxAFEo+XDCIasCYFpxlCGxC/1gGUKkFB6/U+A2CbYg9kUpgDA6sPf0wB+vKhc6+X8d+s35k
 oN2fSSTktCgJXWZjN5rAxTeZ6tuh25a6EzYgDKXdOBWhzQ0vLI1Gu5DRNSNJvcPDkHuSf+ZnXZ9
 25S/yyHaTC96iej5Vxx/GOC5NrLK3ufwmZ5GL0fgOFZG8mZvnWyQXShH6Gov56g+Bnt3ojDtpQm
 eQ3PJk4qBTkHD1jm8io4EZy8MkqgMfaho8bTiJ0X53ckvXXHW0s/nq09KXTNvbEufXYw=
X-Received: by 2002:a05:6214:21ae:b0:915:bd52:6dd6 with SMTP id
 6a1803df08f44-91c12dfe83fmr109505416d6.4.1792698321668; Thu, 22 Oct 2026
 12:45:21 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022190206.666950-1-ansuelsmth@gmail.com>
In-Reply-To: <20261022190206.666950-1-ansuelsmth@gmail.com>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Thu, 22 Oct 2026 21:45:05 +0200
X-Gm-Features: AclHuK80ICzEkwK4kKh8tXU9uiahRLsDPeSDNUOxuXGtImcmdtcjRnCe9hfvO74
Message-ID: <CA+_ehUwYhr48YB_MhN-yODqP4oW8_L0DpeLYEZEZM_s9VWtqWw@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] arm: airoha: add AN7583 SoC support
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Julien Stephan <jstephan@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Zhengping Zhang <zhengping.zhang@airoha.com>, 
 David Lechner <dlechner@baylibre.com>, Wayen Yan <win847@gmail.com>, 
 u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Il giorno gio 22 ott 2026 alle ore 21:02 Christian Marangi
<ansuelsmth@gmail.com> ha scritto:
>
> This patch series adds AN7583 SoC support. It is based on u-boot patches
> of Christian Marangi airoha openwrt branch
>
>   https://github.com/Ansuel/openwrt/commits/main-airoha-6.12/
>
> AN7583 is not included to upstream linux, but actively supported by
> upstream openwrt. The patches were adapted for latest U-Boot.
>
> Since I'm not seeing progress, I'm again taking over the series [1]
> from Mikhail.
>
> [1] https://lore.kernel.org/all/20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu/
>
> Changes v3:
> - Rebase on top of next
> - Fix MAINTAINERS spacing
> - Improve commit title and description
> - Don't pollute dts/upstream for clk but use dedicated header
> - Update 7583.dtsi for new scuclk node (reflect new upstream proposal)
> - Fix some minor checkpatch warning on reset header
> - Reorganize patch for better bisectability
>
> Changes v2: (from Mikhail)
> - fixed arch/arm/mach-airoha/an7583/init.c compilation issue
> - added an7583 specific helper needed for clk-airoha
> - patches for proper support of clk, reset, network
>
> Christian Marangi (13):
>   dt-bindings: clock: airoha: Document support for AN7583 clock
>   dt-bindings: reset: airoha: Document support for AN7583 reset
>   airoha: add support for Airoha AN7583 SoC
>   clk: airoha: add support for Airoha AN7583 SoC clock
>   reset: airoha: Add support for Airoha AN7583 reset
>   net: airoha: add support for Airoha AN7583
>   ARM: dts: an7583: add Ethernet node
>   ARM: dts: an7583: add MMC node
>   net: airoha: add support for Airoha AN7583 PCS driver
>   ARM: dts: an7583: add PCS nodes
>   configs: an7583: enable PCS for Airoha AN7583
>   net: Add support for Airoha AN7583 MDIO Controller
>   configs: an7583: enable MDIO_AIROHA by default
>
> Mikhail Kshevetskiy (3):
>   arm: airoha: introduce AN7583 helpers to get SCU and CHIP_SCU regmaps
>   configs: an7583: add mii/mdio support
>   ARM: dts: an7583: add mdio child node to switch node
>
>  arch/arm/dts/an7583-evb.dts                   |   85 +
>  arch/arm/dts/an7583.dtsi                      |  526 ++++
>  arch/arm/include/asm/arch-an7583              |    1 +
>  arch/arm/mach-airoha/Kconfig                  |   14 +
>  arch/arm/mach-airoha/Makefile                 |    1 +
>  arch/arm/mach-airoha/an7583/Makefile          |    4 +
>  arch/arm/mach-airoha/an7583/init.c            |   66 +
>  arch/arm/mach-airoha/an7583/scu-regmap.c      |   30 +
>  board/airoha/an7583/MAINTAINERS               |    5 +
>  board/airoha/an7583/Makefile                  |    3 +
>  board/airoha/an7583/an7583_rfb.c              |   16 +
>  configs/an7583_evb_defconfig                  |   83 +
>  drivers/clk/airoha/clk-airoha.c               |  159 ++
>  drivers/net/Kconfig                           |    7 +
>  drivers/net/Makefile                          |    1 +
>  drivers/net/airoha/Kconfig                    |    8 +
>  drivers/net/airoha/Makefile                   |    1 +
>  drivers/net/airoha/pcs-airoha-common.c        |   27 +
>  drivers/net/airoha/pcs-airoha.h               |   17 +
>  drivers/net/airoha/pcs-an7583.c               | 2202 +++++++++++++++++
>  drivers/net/airoha_eth.c                      |   94 +
>  drivers/net/mdio-airoha.c                     |  221 ++
>  drivers/reset/reset-airoha.c                  |   60 +
>  include/configs/an7583.h                      |   19 +
>  include/dt-bindings/clock/an7583-clk.h        |    9 +
>  .../dt-bindings/reset/airoha,an7583-reset.h   |   62 +
>  26 files changed, 3721 insertions(+)
>  create mode 100644 arch/arm/dts/an7583-evb.dts
>  create mode 100644 arch/arm/dts/an7583.dtsi
>  create mode 120000 arch/arm/include/asm/arch-an7583
>  create mode 100644 arch/arm/mach-airoha/an7583/Makefile
>  create mode 100644 arch/arm/mach-airoha/an7583/init.c
>  create mode 100644 arch/arm/mach-airoha/an7583/scu-regmap.c
>  create mode 100644 board/airoha/an7583/MAINTAINERS
>  create mode 100644 board/airoha/an7583/Makefile
>  create mode 100644 board/airoha/an7583/an7583_rfb.c
>  create mode 100644 configs/an7583_evb_defconfig
>  create mode 100644 drivers/net/airoha/pcs-an7583.c
>  create mode 100644 drivers/net/mdio-airoha.c
>  create mode 100644 include/configs/an7583.h
>  create mode 100644 include/dt-bindings/clock/an7583-clk.h
>  create mode 100644 include/dt-bindings/reset/airoha,an7583-reset.h
>

For Tom. Clarification on the status of dtsi and some dt-binding header.
I'm fighting upstream for the missing piece but it seems no maintainer
are picking clk changes. The DT patch already have review and ack tag
so they got approved. I would really like to clean all the pending
patch from OpenWrt for this target. The idea here is that we have these
temp header and they get dropped as soon as everything is up with
the target migrated to OF_UPSTREAM. I hope you understand the situation
with the A(I)pocalyps.

(forgot to include this in the cover letter)
