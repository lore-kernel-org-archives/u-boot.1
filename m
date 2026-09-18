Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B407C982D0
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 00:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE6AE81182;
	Fri, 18 Sep 2026 00:39:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ldgcwd77jISG; Fri, 18 Sep 2026 00:39:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DB5CE81177
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789691949;
	b=fYVb1sRU+cT6S18fNzVxeaDN7GJIkGfPIuU+b1eOIFLfwYJPyb3170BXniRs/STvB8js
	 0wSzYLUHT/7Tx35yjEHVC8MRij+ZOKy9ebfNl5ABdcub5TfdXldrUGhYgYWpUusTabvQQ
	 BxoJ3omZ4xqOsOdVcMWSP8gLOvNV5LvNwmlm8HSrOLtpSAW7FtMg2wnrjwFry+2IaAUE8
	 W4AyUFlBZE7hNTTthopm/dWF5giiY52uq4x4aO1tX7xTZytpmv0S7Y7H1V4xizeOtmOWu
	 +03sCyJX+BpOG8wZleJXNu1zzFmvxhnzcAZCccJPpxyvEwg9mmjFc4dt7dqCW7ExhSQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789691949;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zFkXcp0Qja8qgDNcOk1S4JnDJ/Q3aNUchboKsGgAKIY=;
	b=q6BSfswyQ7dA/SeQAUvBDlW6mdxJtIii7hcYPVHCBg32eig/6aFS/qRn5v0Hg6gNo83i
	 tpevbp2rS047ibOLrFiQ0oQfxp8ptyKw5x0bPGXt5rji9Ws2JvMbbVBnjOZ3/qtGtBAir
	 4kzraXPewJ9rJma6I5GHZErmDq7cQqbMMYQNCkkiqPcQWpZq5n0+wHOlU8SbOktAvm1WD
	 DwlLDWg7CcatEUSeELvOQ+MYIVdXt2mo7nMpkFpDzjEyDbXXB229FbBd6pmsJQ7SXiLHi
	 zliXj/O1hdU2KNBqZ8t79lcsVhW1BSAOW2kE39WhLEaO5sAFqBRxf3XfuJbH/if/1RQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789691949;
	bh=zFkXcp0Qja8qgDNcOk1S4JnDJ/Q3aNUchboKsGgAKIY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sx4hpMI/tjImXMSx0Loc0TimuGzybThCfdPzac5NkJwO1XtCAPYIWkQjJl3zASPUo
	 6SCBasPwjp38HyeNN2cj+bCdr2pXTI3IBwrj2KqFrilx6pedBCIIwV5bgv+Jg9Zul4
	 8hbDCOWvRQg1LlrGiwDjaqJVAFkhVcf9Wt/wKFeDPc0TliZ7eCKPXxbicBEuHvDDWW
	 p1WyjYHsxLmEG8FLFfyCWzzv2kodklsf7S4jtWpT4mlEdM3f9MpJhY7y5dAfEVOOsN
	 oCbD8IP265mC+hHdwueEGsZcgaEyfA0pBr2emnw7hagS/kG2x4WJst7xawMq0/SeBa
	 FitjYLLWwxbMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB5CE81177;
	Fri, 18 Sep 2026 00:39:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C3B823F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 00:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68D7A40A5B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 00:39:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PTxLINr7a1U9 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 00:39:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ACA7D407CC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789691946;
 b=SkoW7RKtogTV/McIaMQDR/m5K7iSEZVcCPmmoBSjO63LDk8MoaMWpYF4i614EYMYqvun
 3rEvkYy0wVn1AkCfqQKlR7oZOvaJIPOw8Ss2NWkKCU/2nCQT51hwYc3anMHAbMFFmhKww
 jjqq8uB65palC5X2HRPRazr33iYmTYdx44w12IropZG8geLYard2A5eykgWFhZZU5icU5
 ZeUkFKjp8GfiQRxiRBOqsEJafsOiBZHfEtklmX2UbRzwgfN/xl1j/IUKtMsttU+xxY5j5
 5GwWtLf8x9xH6w00MvVArNdBR+wUh4l5H8tKY70mP9edj+V+cWo3rdotULbsojLo+JA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789691946;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=zFkXcp0Qja8qgDNcOk1S4JnDJ/Q3aNUchboKsGgAKIY=;
 b=tYxNL57reA+a3SNAYilmTQ791OE0ODUTfrclPFtwzHlE4U85QVVxr7A970JbDNS1EeTF
 4d4dls44bucjYJso9g47u1JqdWCbnsS6bwi1cksYHUFkG2Bd2qh4GYdtEaOlfadGLvxGE
 ytTU+6n6qUymB1bzGjKxqxza67i08mhblYFMoS4KnyCrkVGGbhItEfs9LwprtF/o6pQ6L
 KJbljMbAo3IDBG7dGsvaxY+yBmX2LXEMlVbRYajHxkoA7p7IM4YU4rYIeNBauqOzyFUVa
 IDaQsMh9U/eTWlAd6pO9EkAvxkgBr0Ykhbl5MxgAYAHJ/AfZ4shnoJoJIxk7BToJzjA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=G9Rizt71; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2b; helo=mail-oo2-x2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=G9Rizt71
Received: from mail-oo2-x2b.google.com (mail-oo2-x2b.google.com
 [IPv6:2607:f8b0:4864:31::2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ACA7D407CC
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 00:39:05 +0000 (UTC)
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6b1ae6b1b26so81122eaf.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789691944; x=1790296744;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zFkXcp0Qja8qgDNcOk1S4JnDJ/Q3aNUchboKsGgAKIY=;
 b=G9Rizt71Ou1vaZPsml/UOb1SHanK070pZPLWk+qNgz5a7gt4tIsdMRJeoW8KWzSnld
 0GP4hsqbE57nsXcZ3FN6e/2CH9Bm1gEZucPDxkpPlZ7PqgkB5TfJyHR/oOHepG1PPQep
 p20kaP1kAOf/jyN/WtNgM2G1Oaq+TaOH7yNik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789691944; x=1790296744;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zFkXcp0Qja8qgDNcOk1S4JnDJ/Q3aNUchboKsGgAKIY=;
 b=EPr46O1YB3hk2KYAsKLRwZ8e+ca9WywcLpMNxwTCQ5EJlZ5vklgwpM+PHTo1yyPZaF
 KeCBQ23yDML0rWkFRME/nQo5SU/P5Jx/ruZQ1T9H1d/WE6qwz2h3Ln0Jh3S/UkgnlpTV
 rzsS3qT7qA0D1QSPoh5XEuAfXqzxJ9uAn1tfFmf9RY/aD3O4ZYxXeU04VbbT9REc+V8d
 MYpx7PWL9n089UEymEXMIFZa+5p2ghD6j7f4AxCT9tTf7/jWoS0jFVe3NROLNt//LXXj
 6LSB3VRYrfcmYUlmNoA3Xh3vdcZ7a+UP8x6bt+6/Eb33ZhhxbnjEZGVqo8Iy9gm2VmJy
 ofkw==
X-Gm-Message-State: AFuF++kZTRxdUk5WixC5ESQv1wuuq3b22/M/cOt4ajJdun5go1MufS78
 Sur5CXRsiW16k6Wi/UCdgZ7O/PE+9DEkG8HN9B1qb1+EehCSChqdS7TD4HKuWdqFMkQaHnRFN+q
 8QweKijGrYIos
X-Gm-Gg: AYBFou1W5/mUuqGEYgCQB6cG0rdO6H27ibvypm6s401BPY7D6cPRzDo3F9SDLD70Ka8
 z7vwvzXjVSjIJOG7hMVLPGgvfaHRzmsoqWlpaU3M0PRcWacyUXTdZlqQIUk87WzlJ3AGUFcKXuc
 dqOs/QVTuO5PecyBFsYpDxjz1giqWD1P3p+IJgiTypXZo46ipkte9KMfFEkP9BIsvf5Tz4T3tDd
 4slJf0qTIWY+yOF3xdO6GWl6gBTt/Lo7x7EVKX2ASS0ZQwdMYtYo3beLFbC8XLJnyEEe4+EYL87
 GW8KHOO+BNxnD+kR3sT/x1/0VrDumCDPl+3fOyryRqa0eJ7eizEtXE3OroHdrlyUHRhxIw2r+TM
 2W+fP1KdAxzxMMOaTNzIF5XyTHx1oTdGCBZ0oRVUJs6jB4K7dnX1DyN0JqzQUCS+9RhTNLg2nY9
 HEtTLm0/TY1o4+VHFdqCh718sH5cSFTfKJx0WiYBj3dyucBM8zDYCdf1Is9KU1u5BY2QSp63qFe
 iWWRrd4ea+V8Iw/QD7f2cd+90Wg+FSoEu4bfQA2UxW0H/T5glzIvWPSLlUSI2qHBWWEz7tasjxv
 d51qBZDpHCxe2Dqli4A=
X-Received: by 2002:a05:6820:16a6:b0:6bd:af9e:a7f8 with SMTP id
 006d021491bc7-6ca9a130336mr851114eaf.10.1789691944259; 
 Thu, 17 Sep 2026 17:39:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4870b7dc340sm297370fac.15.2026.09.17.17.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:39:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260910200310.3503830-1-trini@konsulko.com>
References: <20260910200310.3503830-1-trini@konsulko.com>
Subject: Re: [PATCH v3 0/7] Cleanup MAINTAINERS entries
Message-Id: <178969194294.1596119.2607391787438493301.b4-ty@konsulko.com>
Date: Thu, 17 Sep 2026 18:39:02 -0600
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

On Thu, 10 Sep 2026 14:03:02 -0600, Tom Rini wrote:

> Hey all,
> 
> This is a v3 of the series Michal posted here[1] and v2 is here[2].
> 
> As the diffstat and previous versions show, we end up touching a lot of
> files. To avoid having a huge series, and also to avoid unmanagable CC
> lists, I've broken this up in to 5 patches. In the case of updating all
> of the Tegra entries, a little more work was required to ensure
> consitent coverage, so it's a separate patch. Also, as there was a
> question of ensuring that new -u-boot.dtsi files would be caught in one
> case, that is also a separate patch. The final 3 patches try and group
> together the cases of:
> - We know what file or directory should have been used, correct the
>   entry, it was never in-tree to start with
> - The above, but MAINTAINERS was missed in a rename, so fix it now.
> - The files have been removed.
> 
> [...]

Applied to u-boot/next, thanks!

[1/7] scripts: Check F: entries in all MAINTAINERS files
      commit: 7f4b730691d21197693a561b1c0709479d4fb7ba
[2/7] MAINTAINERS: tegra: Update and correct entries
      commit: 87d8cb4abc625693b2b3eeb7b697b7b1e8d95c24
[3/7] MAINTAINERS: rockchip: Use N for rk3576-nanopi-r76s
      commit: e315cf608bb346664c01fc1306d842d55d04469d
[4/7] MAINTAINERS: Fix "typo" and similar incorrect entries
      commit: 885803b47cc5e65585701a021fa40d5e9887e093
[5/7] MAINTAINERS: Correct entries missed during renames
      commit: 9c9a2adf2db2d5f2c176dded2962ba121448c47b
[6/7] MAINTAINERS: Removed files
      commit: c062373ee7733209454d0e243696a439672c04e4
[7/7] CI: Run scripts/check_maintainers_files.sh in the existing MAINTAINERS job
      commit: 2ecc661447f9afed36de743195f4d3cea51f4a42
-- 
Tom


