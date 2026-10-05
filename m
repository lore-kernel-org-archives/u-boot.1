Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505F8CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20527605EB;
	Mon,  5 Oct 2026 07:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eSjNWRjcxtne; Mon,  5 Oct 2026 07:16:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 617DE605F3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791184605;
	b=U5OuSanCL89e1lq2psLg3WUVgN6lP6tB3X6adNNKNtxtGL/SfWa/Qcp2MsXv+wqXESy7
	 mVAlu8yUNuZCa6ZETjn0lPfmofh7wrmb7klcltKj0vLkN0tg70vxRYp9q3H9MP5+UWYrB
	 ZJTxkZLbK5xaNYs6TLNcWv8OUX1/HhzR6ZBYk7NNR+nh/ei9ZinOe47ONLzdfiEMJkt/W
	 x8EZfzNNPwz0oDNyxLlCtUIpSHh99U4qQFAMoajMywD48pPbpgYDkDK8XTPk1Iv8ccXCf
	 Yd+y7G/6zu0nzCeMksvsk08F1arjjD+8DNA3kfEY8ZpqGeI4gx91Z5utkLCjgtoHh0w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791184605;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3VJ6rnESk6FHZ9KVqr00VBmFmXuqYRLf9/H28QmoSco=;
	b=UV7iTWzbRFgVOsrrdTDgctN/OghMuV3Mxs2fPw4Zx2pMnSIxFefFR3eO8qRNzcvFKKQZ
	 KkOV/FUuSmlAQtVcMb5yt7ukrbZpk1HxwNigIbxt5TI6arU5iHv9+Axgkv/WNErV6Ef6S
	 iHF/wIrb2yzf0tPmDPLSIa26wCSSE+u+62fLW319oYS3kIq221JtGnUbbAsMLSXjUt0jo
	 OhFMPAW1RMbYvenMALWwDcl5fp9jeij06/ofyLnCxHWyUh54x8rohJgEBKTzMUPApILzV
	 6f+vouUQzZhIrkZ1OhIrLO6q8MwL8JdRkooAEg7oVjhcEOWqxUBOV6j6WQ4r3No4UeQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791184605;
	bh=3VJ6rnESk6FHZ9KVqr00VBmFmXuqYRLf9/H28QmoSco=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xv4joiLtxXEmYqZJg5BL1P5uRc1UwKSnnRLhmaE/nP1WXnyxvEuf3ZBkZcn96iRCK
	 atrKR99VFvGRlTjK0nOIOBDK73DV2qILlz4jN5FhtwTsb4qquWDFkJcMskF+kJZ4zw
	 IgVthZhA9LC8Y7Sl8kMf9N8nNx2Hz3FmYbk7kqbbs4/dU0OiY3Ivp30DFrtWJc1Frt
	 iR3hVXQ5fKs6CseH/wGVftdjOQUU3W8zlIA0WM/WRyXeuaSvJnePBxFd0jDFL4PD7v
	 WA2CfJHHtoaoJ6vyB6xlCgRe4BgvWYTDIV2VK8NgLAWu2mCjo/umwbSYWcN5IkLGII
	 w2KbE9BifpRaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 617DE605F3;
	Mon,  5 Oct 2026 07:16:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 147A234D
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EEA49400AF
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:15:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0nPDgj9A8r-s for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:15:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DEABF400AE
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791184505;
 b=CG3tIuPtp5jMyj1+40mgpkDsn99knCAaxnLX18tHdXjaNz4bt3B11QP7UcYfnOk5Vsz5
 iR6D1GWi83n60cSl8OspGnhFA/ldNrlcJJ/cCzWy0pa75uaL3NGMitt1MHUBiEFVQ31tF
 7lcs1JqdH6dK9cYbwPzDH1BM36r1aaX9bcTO48eTAKjQ6IIVhAfg5CM1kXHw9GZFAzhA6
 h6LAk/cPaOFzz1gjdjEp3JovfqYAiESrg/KKMXz71+6GXj7k7NZ7YZxjKU2cl1aKmyCr/
 SuAu8vccRdMIcsqujaUowd530+kQ17JKxNBci+KC8LtViBa1Agq56JwRbqvVw8VY8/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791184505;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=3VJ6rnESk6FHZ9KVqr00VBmFmXuqYRLf9/H28QmoSco=;
 b=LRTVDByLguFZuBnJQLiCBQhFhjSxtEgdGaZ7ghWUOQKVaoHd2mKNJG41jGPpABNuxmKG
 X9lPgf9MfkCnhB3F7zPHceIg4D4sNcrqdnK+TdVjxacITEUhNmHDQNnvgu0D/xaAGiZ7C
 XOTNepnMD6XKzVCe4MeIDSpMuAAYqKguQjX4c5EZ7p3Wqgxd7v5RKzq42b3Xq15AalLg1
 AOkeGoMSDS0HHs6KKq6EkCdSCKxztLIT9DXtBUuViLkxOB0+0pLGqSTUJjCkZ5UFvY7z6
 JDwsr5a9rU6dD8GbQMVz01xTdvCk1qPtIB2YoFXshV0vCieRvsu54udl3p5OUC904kw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dFuun7rf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::c;
 helo=mail-yx2-x0c.google.com; envelope-from=ilias.apalodimas@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dFuun7rf
Received: from mail-yx2-x0c.google.com (mail-yx2-x0c.google.com
 [IPv6:2607:f8b0:4864:41::c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DEABF400AE
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:15:02 +0000 (UTC)
Received: by mail-yx2-x0c.google.com with SMTP id
 956f58d0204a3-6762de1c77eso846332d50.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791184501; cv=none;
 d=google.com; s=arc-20260327;
 b=O0Z58GNs5Up3i+dLRiPo8sOCAbto7R3NhQZmIJe8DaTvVlKl46YCYzrdRp5rVK54gM
 0UpeFG5Gykd30cZoSuN4gpANpb+ADSH2UDuDUbJIdoJgOQ05XCS47d+hvb7u07WYqjvj
 gJ3r63yTIHZPHwEpzNvDfzv3Xb9COcLlkkP4d4JA9N+kqgCKMpqtXffBGasaUDzcsl5v
 F4EiDUSDScetFQi7axBLzuasEGSkzAmhB9DTlmrFHwiEkawAInPp5/HFWhUbb7GAW//s
 Vx/UTY1oHzI5AcrlW3BCfLiTMF1fNGHdsiK0uixTcse52v88z68kOu97TrfWmGT5RqfM
 fiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3VJ6rnESk6FHZ9KVqr00VBmFmXuqYRLf9/H28QmoSco=;
 fh=f5wif7XUwXenZqiySIOW6rOnSIv8glAwX1qe7GMXpJc=;
 b=ow6OS69+1rOVpK2QCHhb0VbpFkdR3TBpL1/P3AENixMuwSHowwa2oRMA7uDEL5hyOl
 b4IZb5wqVUXSSun7bm8RVpTj7r0+Ae5xY6US/40y2z74pJJ+moGbV1raIL15V2ECpYO7
 g1nag2JbY0+XxZ1+i/M7TJGhP1ea5X1CZGbg/7r9WdxP0b4h1+JfcEA/1thA6u3FJebx
 VysG/wbsm0XbpXHbc/Y8UNOhm1tS8LxBR0SfpLhwEsRllwFxkfC+c0en+34zcmSy8iTs
 DE/KbrqQhxBvkEm8n664CKAHVGCHw54wh6tU+x4g1RQh8XEMdjuH3gbGPz5r/kmx7Pf4
 r2Qw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791184501; x=1791789301;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3VJ6rnESk6FHZ9KVqr00VBmFmXuqYRLf9/H28QmoSco=;
 b=dFuun7rfluMfb0tPU0URa3N8uSfTglizfakXyqmC2Y0To79pN1veY40UElOGLRHusc
 7OcHC0I+YoHPkOmLNWawifKmkNlEiGpYojbXI+W8qGUhB2omyJAox9DZng1aIOoN5/os
 wYvkOjdTOOpUGmf4m9SnkPZUk0GWibFpVifZ4MrC9NbzInbqDhXHg9bGnSv5TJ0f5LxJ
 sN+JeE2fN/vSV/vtfw7ETfnrmRX/WYpfgSdxm6h9EqzXLzwhkHfSKgAyIUHYRakeFyZA
 ljqmIWf0bjqWBSan3xUXMz2uqraUPnGk8rQ/7SRUPL/1syYk2EFIVLQObimjYCxdlQ3y
 fyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791184501; x=1791789301;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3VJ6rnESk6FHZ9KVqr00VBmFmXuqYRLf9/H28QmoSco=;
 b=lDGjkRdpQg5OuBZSD2erJBdQjcVaKKx3MOuHon0y1N+DmuY8v/XvXpfaW/RMf34CTw
 p9ep11ddUiWLEznQg+GYk/IKVkfU6GVmVUCjkdLfImf+bfUrwWN9TU4lYeZIpZCiavdL
 eVLNZ9Nbc2Y1wD6x8xX7GIhKx1uhBUH6b2F6GXAUXseUaPlFakkNKQzSCZEyzV0JDIWo
 gFm8NCOpqZ5/p9dnFqnVy89cQxwcEOmQabpCO3cpijiTnOOpuqRgC6SN0Nwcn1J1MH3C
 SJJgV6bocAcrQvGmw39uLetHhcXxVWya2p63CieJjHNainjxi/Ad2MT1IRpPYHaAeW69
 ikTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmBww91RpmRWSFTuosRyEeq/mYknis37dl3QKs1xmOelMA0ejhueFdgvo9CTkzSDg5EpoDK/8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLY3kjynGTRoOWahyxCaTmhIKbdq7cKDhaeZjI3KkmtQgnyq0GR
 Hh18kcas0+6QtNSmv4gjKja9O6M+DKHgb4Gw4O9W+jZU0UMfX0AOvzqh36tO/pIGiGPO3CRyULl
 6QVoaPoWlf4I+pSrhwG/vs7tBGADCdXlc4n0qN7yXTA==
X-Gm-Gg: AYBFou02/lFdGyIb7u8z01tdOAQZIe97wGSlZ4OlQkQBqi50fy3GarfKP/nGnbDogOW
 +jv1B4Ky0ASboPD0v8iUVeWDcddOPUamuAcGeSv+Qh2fuCAJ10AlhBbVkn4YLgH4CFLxTJR9//T
 lTIKqVwMBFQwvuZ1lARzB1PVwb3837cRr6Up+93TbQKaOMd/zkSUZoFIjSfB0XUGdBRzEEo8RMH
 EMf8K1cBskOk1xwHrSuykiEmZ+VkTip0D3HosJhwDvZbmZzK+0d6N7RMq67A+HBAHreKKoP5VOy
 26noGMpU9QNrj/y0RIn23POqFwkGti0krFUIVWmd0tSJgbGyXdxyv91Txc8op9p88QqRrms28Xp
 GB0RFvtVFHeq2iWPwVLJ1fRvVV54rMYrXK4lYzAiJBvUw+GAg3uAuIuXo7YsSAJrkskscFCj9uL
 EVnIq+PaG6bhEDvAy8FsxAPFWoQ1yhgBCQ0up9E4CrUve4JY2xHHH6mFS55oOodNgAa7Btb8rTt
 3ZfzP8gHKgdoh1AeIrcIRzLbVrUZ4ciabMu5tuXnaBcDzF+Iq6lSky0qIOqUHJaK/niRu2zl24T
 HCW7p3fRwbOkefx0Oxxe4GrTUKPFrGJGPQ60byUVd/BYj+aInseJFqFfHJgEUnAi1uPQ0UY9S+k
 mgkssJFajqYwEU2AYqPgTT7R0LaYesHE9FQxHbIjLrTE9sinfJPX41wg=
X-Received: by 2002:a05:690e:4299:20b0:677:2e27:e7e5 with SMTP id
 956f58d0204a3-677ac1aae74mr2274275d50.149.1791184501408; Mon, 05 Oct 2026
 00:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20261005060628.595146-1-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20261005060628.595146-1-aswin.murugan@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 5 Oct 2026 10:14:25 +0300
X-Gm-Features: AclHuK_BkHgQskeR9zWYiJG4RVeW-cncpQtPzDog__0lrQwII4TYbgTb44EtbBE
Message-ID: <CAC_iWjJb-eM8xRHHz+3kqO1xE10CP7ezoB6D-UbFjaaLjrtwRw@mail.gmail.com>
Subject: Re: [PATCH v1] mach-snapdragon: fix OP-TEE SPL link failure
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, balaji.selvanathan@oss.qualcomm.com, 
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
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

On Mon, 5 Oct 2026 at 09:06, Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> Use CONFIG_IS_ENABLED(OPTEE) instead of IS_ENABLED(CONFIG_OPTEE)
> to avoid calling OP-TEE APIs in SPL builds where the driver is
> not available, fixing the SPL link error.
>
> Fixes: undefined reference to `is_optee_smc_api' in spl/u-boot-spl
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  arch/arm/mach-snapdragon/of_fixup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index 374e6262db4..2d6446694d6 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -273,7 +273,7 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
>
>         time_call(fixup_usb_nodes, root);
>
> -       if (IS_ENABLED(CONFIG_OPTEE) && is_optee_smc_api())
> +       if (CONFIG_IS_ENABLED(OPTEE) && is_optee_smc_api())
>                 time_call(add_optee_node, root);
>
>         return 0;
> --
> 2.34.1
>
