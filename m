Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA2DCA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 11:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 986D440BFD;
	Fri,  2 Oct 2026 11:24:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mjD0PvrtQPXf; Fri,  2 Oct 2026 11:24:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A8BDE40ADC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790940251;
	b=R0Pm4sZx+5o6XwDRDKeGfPGORZfpyaTcGnCD6gJuzFB6O14GyQOvQqFG0AJEp2L9qpVB
	 GlsryUlZ/5iZBdAhzJl2afpMW+9Ln78uUlbIUBfxEuHQcm3RELT0AH0GH+5kUm96iUsK7
	 xvUVMaY1Gy/LbW0b7v/QZGySwH5z80n74HHvartGYEGu3xxfaxeeSlVa3HtYeskzJ5gih
	 4Q1szvFiTvF23A66Lgsut2DADvJ2UbyRcjDG/38HvUN0xCpY3d2erU+WYIybJRYbWqVY7
	 arKD8GHfupxGUdkq46i+KAhJ1nWkorwLB00KicnHkETGkIsqPnZD6vag2pDA/D+VB5A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790940251;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LnodnsUMxuUm6OXxcAtiPLTFg58f8Ez9IzwGk1O6NIE=;
	b=JzDIUoieDaHQv99fRQ+HVZn8LRism7Ue4O90Z5FpuiA1P2Vfq1cbc9mELMZk0c3XxSu9
	 nPlhsqvnD1xVBNNLWlXnax3tKLXdngyboZEoPNe5tQ9k3wGXMdJtWRgcbyWBv30/Z3OcX
	 WqS0A4dshtMG1zWdrB0xv24mlKgd1ZzNpnwLLyIR5FxF9HR3eWrxLikpL384zjRQjfrN7
	 HNILmX8lQ57G+M63luY60Q8YNPAbEScVOdAUd9mohHnKwYZJUwMZxHvDl/HmKmUioidq8
	 cYRne1gGPKsttxmu4wvPreLjX6NQRUFdu3JQCGb06R8jOY7b+2BQBQn/h3V7LDDrNUQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790940251;
	bh=LnodnsUMxuUm6OXxcAtiPLTFg58f8Ez9IzwGk1O6NIE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lob7VY4qR0fQSVZf41tvmbWISZmCJYjRqdmr5U282XaogzDdyUkAfRwUkIRotFRoH
	 3nHkTPMfTpbS0tMIC3rV5WJ8g52rmYQYuhHzW1Zcr5xFqLBXjR44ZBjOA9o0vYobO6
	 S/HA6vqOzx4s5f6qjNIw9si5oeTSqpUQCLueBz6riiHQBZ3n7RoNbPntYSd1Q2Tjjj
	 +Ffjsm5QvmV2RO3ExBlzaPlEFA7oh8rjsMB5Ya0GNFR6eTeTZoJov9jZh1nYnz7oaT
	 MbbA1diJ4IqsuAK+8kJVkGZ+nxx6iB6UqtjSoZJM4/t9os6ulWRMPuqew81P4L9GlL
	 OO8bvW93zClfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8BDE40ADC;
	Fri,  2 Oct 2026 11:24:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DC6734D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F8B36071D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:24:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kcSZZj278-Zr for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 11:24:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3D0AC606FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::2a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790940249;
 b=ganIefATGQ2qhhFlfYO7IA5Kw33kvP5J77pIT25xCOQPlDy0vy/3mW5SgIHvZuAOqng4
 J1sxZ9iUq+FkFc0/C6AasqSaeXKrCiYTeElSejX6Jie6jFNeJsLghbp+EG6zLrHLIvcB0
 CEBwhfhFh1CK3drmRPPKLNFVBt8SExAjUG2FvgXXbzYhNGFMyc/vSUzxWAlYueFbxw7nE
 i+xHIV30sskmGB/uN+sS/EWUxd7HrzYSXefe3HAl1AwCK2AZjsNZ5H0ZOfKgTDDQXYSyo
 wlEeyEJd/hQ94DkiJzd07PEXRMlfsd9NXSJxjJfxg+trgWBlKAEJRtTQEE8PEm0mbsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790940249;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=LnodnsUMxuUm6OXxcAtiPLTFg58f8Ez9IzwGk1O6NIE=;
 b=AovIsr1Tyx3PZB1GCTMuRAf0YdSqnigrb/TT3+9BqChleQu0wRQHutKs2D4d9I6q1ej2
 AImprIq8fgQWSzHDeTFypWrE8A1vcG/6USB0cNOJ8Wwy6MgxsY5LXVlokhW4qUcyTurA7
 cpuutgW56O/zN0TylJLbDwsx0b6Iay+Cf1xY7UCsdiSOn3NIVZVQhAczcI3rC1kSN2drg
 xWkXc8OEvrzJ6IyK9AI3IKkKleh3lYedazuSKcKPQjcfj3u+oL3rV3ZSsoxFc6QoNsr99
 cqIxKYDRc7+tV3rq9Q4f/FwBQCUjfqVYb0e2+M1GFuL7eZYMh7i6/BKsTGaNYr0oFmQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ia2DX7iY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::2a; helo=mail-yx2-x2a.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ia2DX7iY
Received: from mail-yx2-x2a.google.com (mail-yx2-x2a.google.com
 [IPv6:2607:f8b0:4864:41::2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D0AC606FD
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:24:07 +0000 (UTC)
Received: by mail-yx2-x2a.google.com with SMTP id
 00721157ae682-8ab402b4716so33322337b3.2
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 04:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790940247; cv=none;
 d=google.com; s=arc-20260327;
 b=a9+Gd3NO35P1iuLu6VkN0N9Wv/5gLAMbrvcf6O9xC08/f8/4RKmEFpkwz5FmboRPWp
 iZcUPK7UZH79EqF+FtT2fEpQSxQqugWn1c/SlutHhknY+kPL+vzGeX2MFmG4ggA1VXQ1
 ZpFyeCjijRzmpNK7uHDqnYPAfOrUYeXsGWtVakbm4K07lmatpB37D4F6HtamM0NZtMRU
 73INYPTKEy4f1YaVZ8pj3JKHd4yNhVbMbEZXxET9HP0wa/fH27co9YrVNYtxpM8HP5wx
 TIDfbEnhzzhQIuaodHzOonQyLEh2BJIMG6px9EPXXtOodpLaBgkKqnqw2yRDxmGRS7OG
 uYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LnodnsUMxuUm6OXxcAtiPLTFg58f8Ez9IzwGk1O6NIE=;
 fh=nuBf3wKo1f6h1jUIZsacuBBNlSv8DnOg+7qF0rK2IQQ=;
 b=hWMIFuiGl6/9KpmldvhX9WJwIXGGh4jRsCnIcUXDvODUQVZolfg9YdqFZZTBtnruJn
 UDXShhtF/DA/TsqGGWHx8cJM+LTQDB5BB9Z/sx3YHLIg4F4iTOVy8V/BrYZ+Dy8c6MUN
 d7t9gxmrh6hSiPBMrW3JTeXKuihXn/rj10P1Slyfq5xL+O8WTeMglxHUvoHWFTTVLOz4
 SCG8bBqhgOHjJzGprJLy1Ud/WuHh7IGQqckePJFmElxWxNdPLd8Yy5gItpeN3Dy43usp
 UNhqQfMWy2lp3TElH4CCUyT6gyxr9qGbI/8rxx3HqDX6/Wk5GWAHzfrHtXbCxQNJenI9
 62PA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790940247; x=1791545047;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LnodnsUMxuUm6OXxcAtiPLTFg58f8Ez9IzwGk1O6NIE=;
 b=ia2DX7iYmbxX+4mYwF8bv5sAIlMPkjQlhpgtAraI3baAOpuCEI2GAFxiBTCWRGI1sU
 3fB/ezru5DEMOysSNrZXSEXEnPPYCvmAswvazIAFTbq1ySqzaTf0bF0fGCmyxsVPsriG
 Nkj1OZRRpSAJBHofcmWUoal9zj666vxnXxdcXF0Rm6C0/u/ZNFssY1SC5wEARSrZqg9K
 2w6l1W+D0LERvO/aSpVIAvxwf9BWbrn/FmjVXN8Z/I4ySvZy0+0oNEt4dOetKXjwjlqW
 youZq5wKvpFa94p1tvYx4Y7svscxHydxUUKBck312KWGv5njZ9+4Eo91FVQ2d9kb6Bcz
 q8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790940247; x=1791545047;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LnodnsUMxuUm6OXxcAtiPLTFg58f8Ez9IzwGk1O6NIE=;
 b=g2F4YMnFuEa5ytTpFIeDncv4pWUsmjgh/GIogfVhgtfwMFEgvrbQ5vTg2jrL0Yg5hc
 Kp2aNde+vw0taKzrBIg7AxO/SKeV4Upq0Bjcyrwk3mfwFdk3YjH37GV2xLhYoaQvtFq3
 OMlYOjd2H7UtUx2rebDL16asAqV2f2jIXI9JJ08A+14uicpY9h75cJQZh79xFi8CrSJT
 3q4XbXCw4Htsx16cdF6MUaYM0dOBxj0SYl/54rWIUiZNC3IBbDqan7fXf4LA4kYe2Ukx
 1ILS79C9SQzobNN8Mn7VQKPsAlyTVRCGbGiBDJypd4dU3HDRsqhPO8Kz0YWKM7+ydGTN
 fWUQ==
X-Gm-Message-State: AFq9FYI1/9e4v8lvaspcJ7J4hSjc7xCDTwv6QyIjpOTIEPv9bppN0TzU
 g+ay3ThfSKGv0MeNydJo6kiro7jqrUDZRut4Wb70z8X+t/v7QysjmuyXeVXb2G3OXdizUVdXjX8
 1nrGG//6aUuqsmc05hShtGgnFgvLO0hSaVZ4a1rw1Xw==
X-Gm-Gg: AYBFou17VgbjppMAY2K7E+HsZ3EujLWNIE62k6FxtMxVZn6zMjZVsqFj32Pu/AOJ/Zg
 Iw4FSL2XADEL2/Mp0eosiIXrSeUKJnwOrqhI6KQ2mnEWQNFQbGumWQRhkhz3rKtyYcKznUzwg9U
 OM2CmlGRZiQ6TfoarLDtyt5j1Yrbb22nlb88n20Gds11WbxLJYO0tOFH3bQpobk0sA+Yr6tkLI7
 DLE14Te+KCJt/TYVF1N8OENEzXznOdmu6BnVMhAdBI6oEf9v90/dXFLCd60yXB6OmXcxCX3/4H/
 PE7DXjT8IcsLDVtq94w61cSIgnJi4pGKeDTCQfrPqBOBHrw8GE0dY+O2r11bxiadySOFodwyZ2F
 kUmmyLShk2Z36x1bSnOdKceYSzmz2aBbOypOQW7GMyAEq0qqWiE0421rpa0yxIVPlFTYpSOrYxV
 wggf2HURvcsKd5rjy+vN8JK/0FLgWYczqhhggPzWtA5kOH/3yYVe/ufRnWDQTxKC+Q0jJGE9tZv
 MTuixQK/VAgU74vtqziBUs75piy8P25MehZ25RVCpZ9Y9WTBa0VaiGz5cnwR0r1+ec8F474cGu6
 Ku1JPzuJdeK/REZmcD2XC4cZRq5oFUtuA71/5csCJIus5LPaZEwhZp2Tu2dz6642T3SJEglP6JJ
 r0pFDMfkSMeKbnACRcExTQFKFuyzX13KntkZBIs4KyBEBJZK+ctOv/VEbj1gQWheH
X-Received: by 2002:a05:690c:91:b0:886:550b:c14f with SMTP id
 00721157ae682-8ae39bb29f3mr7107137b3.32.1790940246740; Fri, 02 Oct 2026
 04:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-conform-v2-0-daeb00359af9@arm.com>
 <20260921-conform-v2-1-daeb00359af9@arm.com>
In-Reply-To: <20260921-conform-v2-1-daeb00359af9@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 2 Oct 2026 14:23:30 +0300
X-Gm-Features: AclHuK8NCGE_6EnxXNK9qcmKL2ifyrJUkqMixGfcv3UClJl1hwtxEx2KOjbFxdw
Message-ID: <CAC_iWjJ6CcEm+2yDfHKFPP+QD8877shQAPWHhN9OVitwKzzWoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] efi_loader: adjust EBBR 2.1 ECPT entry
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

Hi Vincent,


On Mon, 21 Sept 2026 at 16:12, Vincent Stehl=C3=A9 <vincent.stehle@arm.com>=
 wrote:
>
> Adjust the EBBR 2.1 conformance profile ECPT entry configuration, and
> prepare to add more:
> - Introduce the HAVE_EFI_EBBR_2_1 non-visible configuration symbol to
>   compute the actual system conformance status with the dependencies.
>   This will make it easier to add more versions with a chain of
>   dependencies, while avoiding a chain of nested submenus.
> - Adjust version 2.1 dependencies to better match the specification.
>   Relax the dependency on the boot manager, which was introduced in
>   version 2.3, and make the list of required UEFI protocols and services
>   more complete.
> - Reword the EFI_EBBR_2_1_CONFORMANCE configuration entry title and help
>   text, mostly to separate "EBBR" from "v2.1" and to attenuate the
>   redundant "table" mention.
>
> We do the following additional configurations dependencies
> approximations:
>
>       Configuration symbol  Used to approximate
>   ------------------------  ------------------------------------
>   EFI_HAVE_CAPSULE_SUPPORT  Firmware update is performed in-band
>                     DM_RTC  An RTC is present
>
> While at it, refine the ECPT help text to attenuate the redundant
> "table" mention there as well.
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  lib/efi_loader/Kconfig | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 4cb13ae7c8a..aad8f860868 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -557,23 +557,40 @@ config EFI_ESRT
>         help
>           Enabling this option creates the ESRT UEFI system table.
>
> +config HAVE_EFI_EBBR_2_1
> +       bool
> +       depends on EFI_LOADER_HII
> +       depends on EFI_RISCV_BOOT_PROTOCOL || !RISCV
> +       depends on EFI_RNG_PROTOCOL || !DM_RNG
> +       depends on EFI_UNICODE_COLLATION_PROTOCOL2
> +       depends on !EFI_VARIABLE_NO_STORE
> +       depends on BOOTM_EFI

This is for booting EFI images that are ina  FIT image. Is this needed
for conformance?


[...]

Thanks
/Ilias
