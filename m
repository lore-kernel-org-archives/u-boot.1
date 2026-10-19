Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1896CCCF2D5
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:59:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0E1680DEC;
	Mon, 19 Oct 2026 10:59:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p77xWkCYIHtw; Mon, 19 Oct 2026 10:59:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DF3C480DC1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407546;
	b=Wun2N6w9g9KPo+uFq4Dj3AZ3iv6FVIl9cMdc8T38B7uXgTApoxehbtU+6eeTcAKZQPZV
	 CxYWPk41gYiaqVKj7wf0FZYdU65vlT3qX9C1yY4tGX9cntX2Ux54lZWWHCI8xTMCae0G3
	 AZQNaMEYpATWpDRkGuNW1OY0lOhKW8SGFpZajO0yVfYtV9ANdXwBDn1rkoGeS57vtRri4
	 5QC2tt0BH6U4RY1VMtkVFlusEdsiczOjcVwqDkvmbg9frQwLYtVKheNRlWIONJKn6m9F1
	 PxmiDFdiWLyBqpqtnO4QGUtB32iUQEKxJ9bkXbI+AhFeTzJpUGZwsiG7rmjDRe9e6tQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407546;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7BrVT7duzo1KFxCnxFWCQUrk/zvr4XLZbSlqgjJQQJA=;
	b=apGvkgxS8bNQCmnC/+8dJNTlRDfSAfvnWofpsFaayWofcGbrvQcP3PoqNnnBKKJx4V8Y
	 WbejejchQIXz1AkHUQdeBfKRibWLUb50uk42RBnnf/OJOkop9luHTHZsrRwcYx5Bfo1KP
	 f5L3npTHuF/rPcpMbYFHfoQX72OoBWOpQidy72rMtB3zhqmAcdKUttrlEgDp6fsradMHd
	 AyU6IEpXsAtKpM2fOrL6p8Z0L+kXO7WaAy07ligwayzs7f+8hZKlatP4iDgwI5XGfSONb
	 lNcoAtz7vOJTEQFt1qGPqEHfgMJtYELchHxuW3qxJzvAtqx44SF9+dm16B6WNQrq5fA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792407546;
	bh=7BrVT7duzo1KFxCnxFWCQUrk/zvr4XLZbSlqgjJQQJA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QxganieTglrRbAx9NXAOSqObLPEuw2ayfhnqX+Ks3isTr4qewj2EDRvRRQuD5qN7Y
	 7oOVi13bi8xmLPVIetl3njGaHW6AdLN1DpDUyapuh8NxpUrgt5oTMdddflbSbr5KHc
	 z83wbja454LF0P92IXCXhR7rBoD9m2Xp7r8Yk2qDvnIZCUhJS0n8MHpiCd3lVRy/dd
	 R8JtjlZkrQGiFX3k+ZkMg2jeATxkeQnKfbvmRvPnfEjQ5Rd+FT4VM6X5dm5xiRZd5O
	 iEF2LLE7u07TRSIPHq16kYCAxDjY04v4snKEchLtN9jxpZFONdBQoIj/57chLIMk+F
	 QsLTITyofNf6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF3C480DC1;
	Mon, 19 Oct 2026 10:59:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F3866769
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D7DC7405BF
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:59:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xMJT4zIyziuh for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:59:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D069E405BD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407544;
 b=nhI+88XKKjP8GufPmKGMllFDI5cwLDdX4UGQxy5vrrelwjU+jqErxJguQ2tNfP8kjGtE
 sYp00+ZmnejFKvzoOAKexRJrpcM4ZnPH23YSsQcYraSj+BargGt+jjrROCNHAN2TtF/uh
 Np/0QpyvDm3oZXf5/2it5sBEEVJkP7HNLJy0JRIjF7QsWjVcB3wB0dOPJg69kKJIgRd/p
 /KSjr8zpce1D32oEX8fKaJclBcTEB62Xzwug3Wph/NbPAUgKJngc6pPAk6tHHp1QBYlEP
 lhV5HAgSFCWuNy5bAQww1tmpF0xXzSeoCJ4MTirT4omXu5/LZ7x/e4PSLEYOYjjKJ/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407544;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=7BrVT7duzo1KFxCnxFWCQUrk/zvr4XLZbSlqgjJQQJA=;
 b=l+yCg0H8feZRG+gBl11aMXKr2GW/RvwG7nxqhqYXWQO371bnhYdtEdscLomxxBQezPSK
 bZxGrwlaUZXBVlsn/onsvmEKOJymDrOPVXwqvFA43EVyE+s4A/azjn93531jzieV0zcau
 iLaIyVbwv07GRzfTTecBRMTsDZinX+uFWoiyQX9GthgGA9nOvG1LQoeBGozlugy6moeVw
 ustOqEtdqinGOfAXHkTccsb/ZI/qaLGJPQju1H3hEJZAq6aDZUHV9XPfMshIFvlQFEr8Q
 AIjMLcabc69aN1PM99hiHsFDF636LLnLD7lZWycGoSNy2lbnW4QLHiA3WPxmvqm5QZQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=3OsKzbV9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=3OsKzbV9
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D069E405BD
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:59:03 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6afafc89b48so2841818a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:59:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792407541; cv=none;
 d=google.com; s=arc-20260327;
 b=fNaiwOF4mCDdYOlTneP8/43hmZ5I8vAdKhxMK6DHShY6keLwT8YKqgXrMVJEIjFhk3
 AmSxY9og0lqgVm0pzncaZ9SEMTrYrP3jxlePZ3kZ9iS2TcFkKwaG0C1B2VchruVZgg/Y
 Pz9LC0rKCYGa+6/8RpNZQXc68bm3/7emybe36H7vNtK/+P04w4P/T4KbcELJ7NrfX3vQ
 JTRqN9jv1Zkj6BAe7AyxgO2n01+SM7i64EQDY1oVieKuKf+VqvnMQjvLS1VgGCDbuX/u
 wJRb5SyrzvYI+StWR5RItwcnZGx/hm+2A474jr5X20FKm8uMNw2Db2xsDh65fkNEBT8i
 zQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7BrVT7duzo1KFxCnxFWCQUrk/zvr4XLZbSlqgjJQQJA=;
 fh=70uP5ukEvyBkS0ijz6Qh9Kg8amyxFNuS23iHsCXHzhY=;
 b=j51ljOSSfCVqIvtn8XNxlIbYFbw32WqHuDquNEhouU9e/TWGOJtyc/WDRpoCJQQKbq
 lVn3ZGZHeFx4DC2jNYFZNhlNEmKb6V/vcbEY8AFBDgqOBmD44x7/c5e30L+uIQtbfL8z
 EL1yrtKBG/SQl0aIrTa1Kh+v/8mVCcxxhNCnZ8UowqH/+i2u6Ox3+K/1HCRK4X6M8oTj
 zFhcbY9nKhSqq7f5YEHF67nvbpo9ALp+vyf82n1JNgpsjgrJlJ4nG+zGT+HKpB2L+zYK
 ad6xwfoMSHEiOHhmWMYuA0er1rHJVURn5xMozEFaYI60KJWZz+yXtG+Ch1RzCYMHIoij
 hEkA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792407541; x=1793012341;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7BrVT7duzo1KFxCnxFWCQUrk/zvr4XLZbSlqgjJQQJA=;
 b=3OsKzbV9VTLyNaanMJQwc4A9agB3krWfCjrEYiKyL1TbcNEjKsmMSFiN+l7Tj69dwM
 c5U7LhjHLtBoIojZyzg4VWskWI807+9mYvDHPgfnr96//L4wW1/jL96bE15dxO8R6gZk
 fQpxQp6tjNjXelYhiX46e/1pzlTKBkPhatf/7nCFINWDWJY8pYlI8mNUrL2ht3M9usYB
 J71ep7Mn6HPCGrHp+vzPWwCO57nJspGbN/uYlNKrbYOagcSmTGA/a40vsDl9b27/yRRD
 GGtz/f+h/wpBqXbyBMunkyEili5bUJExfa//39lZnPhz8Vq4D+Yv5qtxGprcsWn2WLJ1
 DQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407541; x=1793012341;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7BrVT7duzo1KFxCnxFWCQUrk/zvr4XLZbSlqgjJQQJA=;
 b=H1kPZEoappWaGu0476l/s7dZbxpEMB1ltpXv6kyh9tqBAtQL7w4+6Np6B2eNXezRtK
 hqzaI+4bYBO/szlLqcdbtEi2r0Zuzl01YtDpLm4fL34zNXyi8y7Nr4D6B6j6UdItPjja
 NUrDGsi17BCus/WzIDH7FA9EG/WW01/uKzN+va7miL2st5HHM2xxPuuzgwjaesXDsOtW
 ThqTuAzJ9c+mZe22HLWUsYqPLVgYnUj24FAXFFRkI+M/v4C7Fmo5coEKLgEHjQjQ3UOI
 aOnfRJDAjQpzHQe0vo9T49PYzDDxu5CYYc5qrRZUz+R8kWB8nZera75y+Nh3ryBfQJ9o
 Cx3A==
X-Gm-Message-State: AFq9FYL76BZvepqiI3GyLJqxqnxUZwuAdsdd0M4feEsLeow94ExKtN3k
 nMpXIdU47yRqcfsa7TaHDUs08i7zLpiuMrXu7TPXmS1hxPOORd+ALX2Sf15U1l5r/cZwt1u1ZO4
 92mYy52j/dBjIBa1assWMBq+kRaTOT+ZfrLsuuouIuA==
X-Gm-Gg: AYBFou3Wg944WOXVC6j90JxgsgGjpb+nXW0dY6RbirDb0HNT3hlCqaIh4qcgfnfV1+2
 zl5Oh8FkkiY9Vt8tUiavakHtFFZ1Wef5JbPzzRPydwi07HMJTJlzzjRYmQwNwbgjEN11mQktsX3
 llw/wAK9jb6OgOiTMtnm2di2yRhbHWFTy9lP9B53J5NZIhfmte+IkBSU75sAjWyOLOWtjx0DU5f
 ebW278mJUEqleB8LGzIgbtC48FtyfFhm5omHGrhCwj+gYvv28l03o1wyO9LzXWtGo/DIOdm4t7m
 7wG1ixZFSNlpwceL4tFKduTNzrlHdLuT5yYwo60TBKJKStBsL2mF0uv9lP0YNSAa6bGXDS8HGEP
 +cl8kXxWVvSJZ
X-Received: by 2002:a17:907:3f1f:b0:c41:23bf:18af with SMTP id
 a640c23a62f3a-c4199e5dde5mr511876066b.5.1792407539194; Mon, 19 Oct 2026
 03:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
 <20261019-spl_ufs-v4-2-61432d0b258c@oss.qualcomm.com>
In-Reply-To: <20261019-spl_ufs-v4-2-61432d0b258c@oss.qualcomm.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 19 Oct 2026 14:58:50 +0400
X-Gm-Features: AclHuK8Fc4hvT4_oYfBaXd2yXALpC-3Z2YT-RmUoRsmpjE5Y27tfgbpSi0Th0-s
Message-ID: <CAKTNdwH5XLcCdyA-QuTVrPcZxSoeVYbjtXxEnmWcMTG-YMwwcA@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] lib: update charset.o build rule to use SPL_UFS
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Anshul Dalal <anshuld@ti.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 David Lechner <dlechner@baylibre.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peng Fan <peng.fan@nxp.com>, Daniel Golle <daniel@makrotopia.org>
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

Hi Balaji,

On Mon, Oct 19, 2026 at 2:50=E2=80=AFPM Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> Update lib/Makefile to reference CONFIG_$(PHASE_)UFS instead of
> CONFIG_$(PHASE_)UFS_SUPPORT for the charset.o build rule, following
> the rename of SPL_UFS_SUPPORT to SPL_UFS.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v4:
> - No code changes, order of this commit is changed
>
> Changes in v3:
> - No changes in v3
> ---
>  lib/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/Makefile b/lib/Makefile
> index 30092dd4a04..0901804323a 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -150,7 +150,7 @@ else
>  obj-$(CONFIG_$(PHASE_)SPRINTF) +=3D vsprintf.o
>  endif
>  obj-$(CONFIG_$(PHASE_)STRTO) +=3D strto.o
> -obj-$(CONFIG_$(PHASE_)UFS_SUPPORT) +=3D charset.o
> +obj-$(CONFIG_$(PHASE_)UFS) +=3D charset.o

This will probably break bisection - is there any downside to
squashing this patch with the one that drops the *UFS_SUPPORT symbol?
Existing board defconfigs will also change behavior across your three
patches until all are applied, which is probably a bisection problem,
too.

Alternatively you'd probably need to do it in two passes: e.g. first
add a new phase-aware UFS symbol, make UFS_SUPPORT default on it,
switch over the defconfigs, then drop UFS_SUPPORT (or something along
those lines).

Best regards,
Alexey
