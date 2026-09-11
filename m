Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EF0C88E53
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 21:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6884860623;
	Fri, 11 Sep 2026 21:06:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OMlnyFC8Aj_u; Fri, 11 Sep 2026 21:06:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B019260615
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789160816;
	b=GQmr4K3Z0BLuWWD8LbNKjm385jc76TVfpewKpAs934jcXopUPMNte/yPKoXvqYJA21EU
	 abnOnGl3LdhAzpssktAMZTivXdq6ORakHhvipFQ0bDeTQx0yUBXiaLRr3K3TEAd8WyytP
	 Jg340loc6Bvo6PzPxr58YGrRv+WWKegdXVCp4v8vX+EdQHws5LGRWpc+pSh+Dv4Kp+KYm
	 YMCCPdYfYG+v2jViMwC0Pr6M11hScZZEez1UYTTz6MLPQ2ZS3UF9RdQd12NXZ/uG/4NiO
	 pNeWUxPqy5jnhkQtukH1J4TLgxOrs+bSDh4YJiRuoDh+IfMqM2GgfhLQgfEiUxm9+hw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789160816;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=z7xByEG6wqymRp9PqtgO/KUotK/HfdXUFAl8nabn92k=;
	b=q71MdciV/mXgQ0FEzLTCLwn0n/c6kgv7HCbqD/yYMNvJApAJ3QKLxzA+X2SQLl4DsGJX
	 +ZpErz5pZKMwEdEanue7c34r5+f+HNUQLPWVjNEsv8CgRGxwwfQT0ShQpWnjBxH0juSid
	 XTYDC4XQxx3/QMcgkV6tB00HCIgZ55bkfp5N/Hq97uyr5ksoHidvrAUzyX8DBp/jL+c3e
	 CGvumiYtgzjBOvsGlASutKSkJlCeCxW5wXOz5gRqFrT/t5ufs7peXWPfyAZILvH0IiUHF
	 l/wZVoWY6dmtiNoi772qzpdxYcnIoO9nXW0UVOT4R1/kckRM6NGVMTHjYxhYPwfgcAQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789160816;
	bh=z7xByEG6wqymRp9PqtgO/KUotK/HfdXUFAl8nabn92k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jB/OftGuDUWZDmJoE9faj9n4yXjgbyn4D0zUOBoNAGFLBbDsVD9/nz/yRKJuIAq9a
	 fXfPEfoJmGvyLWZrB94XfByCv29tFn0cYq+l6bRFmbOYIuuUuqgjU+ndfgvBW4LfCa
	 CxyCxz8TXXnqoN8sCuCLpTg8GQSWd5rbTDTcrxb/Z4dUSF9o5ZcVvV9lHG4fvNWmYA
	 fEODXTdPBrkUYz+GrANT4uatAsOZ/vvHu5OKryLBtYEgCRGNk/MfXxqI2q0u9JDpRB
	 TFpMeXj1ez/8y0qB0v/Uq5BhFWh4brCixY9UAQZjauCaswpx+B6nPzG44Brkz8OsPC
	 CNg3VDN7kqzoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B019260615;
	Fri, 11 Sep 2026 21:06:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BF6AA49D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 21:06:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A192180F30
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 21:06:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D2Zdr2aAx6wk for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 21:06:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CFE3780F11
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789160815;
 b=aXuGbcIlkik03rKDcRBFq4UKuj1POdpZTs/b7M6rzBnv2kTFETytsyeADt2Ae7vATSZP
 Wi/V5KZo+S0Bq/9hN6fW/QMP6Oj5IVrOeNjvP/eqbHwdzomDqSu9rqgtaFmmUNuC1DdOo
 +ZFZNqXUB6YNu3hNy6nXM70ne2slf2AoBwMi6sojJi13f0roU2rJSO4/ZDufAiBRGzkv/
 rsjFDqTGOGTtTlPnuXeHzhmUJeoD2TmM5AHpF5sJ5JAqbk2/dH05pgX0mFbv8IcS98a06
 2/GcxMZTCx07iFC6lLdIibbj5jr+9bUW9YQMrqMncGLFzrtGmpWaDTRmoXfOS/xxagg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789160815;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=z7xByEG6wqymRp9PqtgO/KUotK/HfdXUFAl8nabn92k=;
 b=QmAU1BR8TEx2qOKkbzZoQpBkwZjXmzg4W05tkLa0+BzklSmp1aTlmogxNRKdm1nowG8Z
 tK4dxOeXULWqfkXUrBJ4aaIE0OI1ualEAb45WGMH0ZmA6bwRltrF6Ne0KtejKQ+IbuGn4
 vC5mB2udcjJEcoFzDynoSH+WlSg6da5ZM6fQkZ+KmeAdu2TO9tkVVr44kc9w4Dbo6fbxi
 Qwy5jb2VRJ1sqp9ZgrzJb0mYxqJexvOahjMBqusaGV9tGq1Df82ylTkkjsHrcsc6Qz4ll
 7ookNMGvvoLnHP+/aX95z9Hi83YNDDKtV5FFb22POkxuFXINEbkauIV/KRP7KrsxDdQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="NhukMW/1"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NhukMW/1
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CFE3780F11
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 21:06:54 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4bf948737e1so258590b6e.2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 14:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789160813; x=1789765613;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z7xByEG6wqymRp9PqtgO/KUotK/HfdXUFAl8nabn92k=;
 b=NhukMW/14Xo+MEJmcp5M5/h2iWvo19q5lOiNBXqgoDHyivuZyvJfGgynd0soAl/y9S
 yIJKEqxAmB77MHFR6+lfFDebkVZO+CGZblSOPM3ShJ0kNNrOHv1FN2gGK9uv4BHuK048
 8TRvYxBhrnqKskOct+8iPz1kukFlVk76hmOvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789160813; x=1789765613;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z7xByEG6wqymRp9PqtgO/KUotK/HfdXUFAl8nabn92k=;
 b=H+V5IYrhm/6BNqGsmJNIr4H6zQGOvHM9nhvrj5dUwyUsNX/W5qaRvFGyyLEUq9VfoH
 nJ6tOnGrhq6P0LgHSa6dLLWmgivz3/LEItgjd7pmg1W22vig03SD0qvx47kgMXxwY1dY
 tASpIs9IeG98prP/qvLh06E5H85RHeaGUdTJk/gk82jyFbxYOt+hlsSke49LF/BzuewT
 o/aOP0uThZor8Z3y4L3h5jGSeqwWAZqXtxyOqzODgEg2JXAnmDn11ZOglazcC2E0YDj+
 2hT1uk0K+6DzxRXfCsNeiqYq8VbHTqzUdvadzOuQKEf+9mqh/ISvLMjQS1zqOQ3IKQr6
 Wpsw==
X-Gm-Message-State: AFuF++lRlKdy6Qptyr+U6dD5x+I3WhecaZfev4izTGz1e+8g4abni/6C
 04+hXyB++at1NwSTnAXbT3fgJTxu6914NE2m3XyPtctZJX+uK0Z7AjzRcBqWb/8U019HOj7b7F1
 hJdYb1ZGNrx4Q
X-Gm-Gg: AYBFou3jShqe89maeujcg7Rl4OkVFqp/clckjBZIyCohInFmEhtYV4u3UF0duQhHFND
 Fn/2FYX3p/cxiEwYY2sWjWkXnCQocBcfD4Czd2sCy9sV7gq/TYQx1L5u8TrTT5dJA3NlMvtDjr6
 06cto/LKZiRzESSEVnNryaiLoGLrHzR2ZiplpwdAnrAKfmI7XAQme4Op4Q6SXmu+BJe2hcliXNh
 rzdIoIzBF8UZFWF+63M5IO3+sTCcrQF92yZvkgqzpghShJXjQr1hNOM5lksi12GSDuU7IyuiV4e
 wlO57tuHgxpW4K6qSXCBTbB4ME3g4ju9RyBLe7h7vYhSb5uhS1Id0iXFGPixwfcBbmmDJGe5tJ3
 NkbVujZ+Xb6Cdjx3FHbPMbPm0mOtfSlISckorkkztr91e22iii9ErWRQdMAviwcMuuwehMCoe9z
 NSMTANCQ8OpiOXb+aj7UDo9GIH70RfmVmnKof0LDYOd4Ouo29CxWQTdeHssGKJaQa1R69AFqziy
 rNphxMCn1hMHTeQBxxYGsVLkVwLpsnACr/pCVpf1W7ZrFe5pbijoAPezWMSoeGGuiefhBuOJ7di
 tC0weRcVtpWeQg18242c
X-Received: by 2002:a05:6808:5086:b0:4c4:b6ec:d737 with SMTP id
 5614622812f47-4c4b6ece025mr186974b6e.10.1789160813437; 
 Fri, 11 Sep 2026 14:06:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c32bde3858sm3197723b6e.0.2026.09.11.14.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 14:06:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Bin Meng <bmeng.cn@gmail.com>
In-Reply-To: <6a802e6a-5c25-4c07-a33e-d2043e3eac4e@linaro.org>
References: <6a802e6a-5c25-4c07-a33e-d2043e3eac4e@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-nvme-fixes-20260911
Message-Id: <178916081273.3818440.16470101697868010256.b4-ty@konsulko.com>
Date: Fri, 11 Sep 2026 15:06:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 11 Sep 2026 15:57:22 +0200, Neil Armstrong wrote:

> This a set of fixes to support NVMe on Apple M series with macOS 15+ firmware & M4 support.
> 
> Thanks,
> Neil
> 
> The following changes since commit b4ac71db13a33c4e6532c60a781ddf34b7f4375a:
> 
>    Prepare v2026.10-rc4 (2026-09-07 14:08:25 -0600)
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


