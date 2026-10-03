Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658DCCA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3254180EE3;
	Sat,  3 Oct 2026 13:42:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6NsEGcWOR6A7; Sat,  3 Oct 2026 13:42:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7043280F0B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034975;
	b=cIqvsWffRHacTXA1pZLCWBY7liaDi5heXKEYWpKHWwu5A2lqgb+IXxvdZ6gHe/LCuLjg
	 aUNxX0aH+Tnk8NhCVTFbvvew4abbQSdq7lvV7/ejASPr1oGL9v5uRdvORHi7aqud+lgrW
	 VfdF1b/4yIXu7axkl3pnHXcnfsiwforKaYIp/O7Eu99W7fbdGWCpET999cpjvdjQYM3XG
	 03sAcEnsJTrCImMg0H21NLDfWyAFGFszUte9aR4z0mI8vIKEmtPuQDEqx3PnYMroMgpcN
	 nM/2CLWHj8A3m44Dv83YCtpPGRFQqBLehIzngwisKPjrsrUX1fZ0JsbL6fLfFOL+vtQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791034975;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dl+cfdNK+8I6BsxJxMBDBwFdDt+tQ/1RUY/qT8kbuSY=;
	b=LivL1ht4gl87zt464x+CTELngMaPuujTA3xcgxLivprI1peSuhRWc5bR5JwdZTw0bBI+
	 6NBmNV7pWe01dfr4q1H7sarKIb7M9EVHTiYYeqFJZcdEEswJRYP8rO4tcU/2HdDJbPUWQ
	 msuyjwbhRpMcIVfrlPdTfInHT7OxkYMs5MrswkIlYrBq8Mz6S4SrgwRMkDVeMLuMjNd8c
	 APtF/76rHlzpg7i8+M9soUrp6jPnIUfWGzYjGJ83y5AhKPBK490zduvwKUNebJuAa2qBt
	 psfPPSEiFRpHZS+NnIVzA9AlgRXyq6e3/Zrb6xAVdIIkgURtB7SOGZ3sgNjOVzKaIOg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791034975;
	bh=dl+cfdNK+8I6BsxJxMBDBwFdDt+tQ/1RUY/qT8kbuSY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yU5VqR674ou5hUaXP4Z7y32oM8jf5VucZUU0HfTGvMDyfI2XbWk3BjyMCzSB/PUp/
	 4Jp4rAqOOPei8hSqIfrNs4WMKtIsIvh02NbsXXDnrM/rWoq6zrQhdSGdXmE77cq1+f
	 kDfRi/rnaP0dAqx3XQyNTpsPHQEA5AWJLlQuFJNf5FMW+VwMOjpycwXhp+Bk16AktE
	 6iMpG0vZesnYpHxcsUm8lmXLuCo4xL0HnrC0JrY95RhqxVjW4nTWF1KsA8J4c+ijnr
	 ifoQSEQjS8+taQZAW8fqCM4NoAXghiU1J48kxuTd5tiFNuAw0qfx8nY3kMOAAJtgju
	 XhOV4zgTMYlCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7043280F0B;
	Sat,  3 Oct 2026 13:42:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A787C335
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:42:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 990EB40F0A
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:42:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sYJ25KeDOxH9 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:42:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A826340A4D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034973;
 b=a86J9HyerKDru5vw4/Kxd82H+homaWyz9hZu9aoat7cfYLFjjDuE6sFvh2rR8Ne/4AHd
 OX+pojC4FX7OQHl4oKNKYEL0hn56eJ3sb1in5o9iIwsopvQfBJhR/VkB8tbze6R33wSNh
 ilkgZObO3yKPPUnYt9JOMEvKIZcCU5g4iAe3GcT6LXAcDdPOZxmzKdrtqSamPHaW42+Zp
 7uLCF5KSUeh3jsTIAoerbysNjZ+TIk6gEMc1Cng0GvHAH/qXi4N6bivh5qBj5MgZ2UR0A
 9tNoDOQwPJYQ3j5ZavimeOs1cTxeMWYZQiulUAgnAUFg5iZuIf11V1Zcp53gQnUoa2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791034973;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=dl+cfdNK+8I6BsxJxMBDBwFdDt+tQ/1RUY/qT8kbuSY=;
 b=n2EfnsmcDFDqqt+yeVWcEtd28daDUM9IRDefWQgqE/9wNPfIeLWlqZvjNAJYIKL0Zfw7
 PK8bU1Tp8YBamMnBmKu8lXno2oJm+iRbXMRq/HY1ks3IxdN8q3RWRlYbMlTb3u3VeW72O
 qpNSzU9ufZ7LqOZmRt+cLu+WouBkUSA3Vf1zx0gnuwC8/2tiVoL/wR0GAt9uSqZZ+YGj+
 iiAgR/KQKu465iseYk0CdFH1UIvmKlmaIotliXB98NlR+VdIP3OBu26JfL11SnuHSUMB3
 mw5GD3jJHPxBISv6FFl7pwjBa7xsSs1dFPspJfzAh7TpbESbT5HDhRwN1ObPpileacA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="RA6X/AES"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=RA6X/AES
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A826340A4D
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:42:52 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6acb9c018ffso432172a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:42:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034970; cv=none;
 d=google.com; s=arc-20260327;
 b=JxLAYAPFEOWJQ97Rvez7m2eHQrbpQQcn7XT0VPC8qtUV5CtoRusP/fgNpnOZHgZZf7
 75NG+IjjbkpvRkKckYKkR7wHe1DlS1/LdNcZDghfxOjFmNdb2oNT/2XNTl6ixm6YvUJT
 Pp0aCWf+MtxXmxgQpOKCw31qHKP0hxm4WT3yhhIIFDOBTq1p93x41zayvDRjZnZbKYFS
 T+7eR2QiKpaOGSyZX00blN4ov8AwWRC/lntecnHW+/QVTS8A0t/CTXxeGW+LQbw97rhB
 EM80po/N3DzS3T2fqtBD3Efe74hlL3wTwa7FaQ9tPj1DfosUsbwWTTLL7CG94yZsYy/n
 ET8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dl+cfdNK+8I6BsxJxMBDBwFdDt+tQ/1RUY/qT8kbuSY=;
 fh=DRMAGgHoPax3R1r6Pn28XA3dtWVqztZPwpEzfTF4Rao=;
 b=pGbvxm6Q3wdopJy6E7JyRd+Kyo5p1nUB4+XWO13onRWt+JSIouJInT0KnxH/4Scc8q
 tUhxbU9sTAjkxiJVDqpa5cH67CSaw6gdf4iOD1vYtTuaHhaHKz2f7Zy471X6E+O5nsh8
 y0vwdaeNRZB31KNI22xkBNLI/TE05RUOGmxYevgv/O/DjurA5FDy0euSfcfmdE4Ihs8J
 4QpH+NNUR73ayFLFgvLh+LWkv3CEVnsJqb1RIlC10MN9HvkoxBG30i/vyH2gRZzDZJyn
 mqmfkGt2n9o7mOy5sWhG9XD1oFbpv64fP6AQE0WLwy2eRGeoRXBxWNo1Pt7EGNV+T1cd
 nYAQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791034970; x=1791639770;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dl+cfdNK+8I6BsxJxMBDBwFdDt+tQ/1RUY/qT8kbuSY=;
 b=RA6X/AESe/DVTB7OkZ9/1Ur30jsFq5GOelAQw4p3qZcPYds+VdToajpS4j8lLxUTiE
 dKc3fi4yuFpyBRgxgt693A5PzSqyjhE2C6aTefMlvz22+o4mJKED8HzGJbsfScJmP7Np
 6ydHTtCpL8XuWNrLXRzZkaP2jRZ4vcWPbTUnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034970; x=1791639770;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dl+cfdNK+8I6BsxJxMBDBwFdDt+tQ/1RUY/qT8kbuSY=;
 b=rHhj+oV9+FkaYrfva8fZ9Udb5BEsZ7Juy8yfnm7hdQFWqjmsL+ijLl+uT4myLT15tJ
 TMP7Db1i734AzUyphREOfc0dfNCUv6W3EItORBZKhk99orNSNOLrYAEh9gAtnCh3xQMz
 X2QDhtTK7Ie4pfMj1wwI0U28VgdPhTxz3rZsCzYLCD1NS4GqitYrnV4D+pC9B7/uDvwW
 0jA3Nt5N+UG/dd+qwsdiFa30eMiY66PGO1QxwOm9uMzkxOvv4QEfTyi2jF5dxD3q56F4
 p/j4FTru4mjYDFEbJEZz2OrIWvpLuS09Oe8kt2P/dRlSSNlK4Xidou6VIn3Wz+fR9WKr
 hPTw==
X-Gm-Message-State: AFq9FYJHU2gfzG1RqwKuli/yzvr19pCaPqPFqCyAh0QvkKsmjqbx5mdB
 qG76aZajRdOJLKiU8MjqsO+bNPcGIVE+cbSJifyJDKz1HklENVpJuYLkuchdKTyzcSw1UmbaZfg
 Wt70FNxLifbeT4f0suhsvZM74jOD2xtxbrp5QeTa3
X-Gm-Gg: AYBFou1mQqRdqObRwxSesmZiK/XCVwpm0XsoENlJ7xX4DtejjUSW4j/fJ8Sx6IhGkyp
 yb2IdTMS6WY8mBTmp3FsMZuuSjjq2tXv0UM4mnpYqZ1+/SYtahF9k/kre47ujMEavCWBrCZic2i
 BMBpPRjCN7c1KG5RXqZMLE4D/EPDjjEoAiL/Dhb4OePccl7iy8+M0vMZQHtpDC5EsfF++HH5G/6
 dXLtBGVpE15O/8yIhjeEhSGeQqPKQHMl+RwP0jqSs73E78bgsmIW/fJXsVukO/A//Qg58Z0eba3
 59GBhEiPqnroee7RqyXpXS7fjqomgplEvoxvduxSih0iuoWKo4pgrUc=
X-Received: by 2002:a05:6402:a5c2:10b0:6a6:92d6:daad with SMTP id
 4fb4d7f45d1cf-6ae307fc653mr4819334a12.10.1791034970144; Sat, 03 Oct 2026
 06:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:42:38 +0100
X-Gm-Features: AclHuK9nofUY84jQi27HATsCAgjjm3rKW6AICpDOyHXbSP03WFfkUppwAAWgcvY
Message-ID: <CAFLszTgBoS+LRFZ0TZ=SOkM-nW=Pa+jBt5rrts8A3nq1ufa=0A@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] spl: fit: Generalize compression support
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
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

Hi Alexey,

On 2026-09-18T10:52:27, Alexey Charkov <alchark@flipper.net> wrote:

> SPL knows about multiple compression algorithms, but only two are
> hand-rolled into the simple FIT loading code, in spite of a nice ready
> made helper already being available right there.

The approach looks right to me. Do you have buildman size numbers for
a board which enables only SPL_GZIP with SPL_LOAD_FIT? Until now the
image_decomp() call was dropped at compile time on those boards, so
they pick up that function and its messages for the first time. I
suspect the growth is small, with the first patch helping, but please
can you put the numbers in the cover letter?

> Generalize the compressed FIT handling code to accept any compression
> algorithm compiled into the SPL, and fix up the SPL_ZSTD linkage which
> requires xxhash in the SPL but which was absent to date.

The tests don't quite match this. Nothing in the series actually runs
zstd_decompress() in SPL, so the green CI run cannot tell us whether
the heap is big enough there. See my comments on patches 8 and 9.

A gzip case would be worthwhile too, since that path changes from
calling gunzip() directly to going through image_decomp() with a
different output limit.

> This is done with Rockchip RK3576 in mind, so a small Rockchip image
> template refactor is included.

Quentin's failures on PX30 and RK3399 come from the staging buffer at
CONFIG_SYS_LOAD_ADDR overlapping the load address of U-Boot proper,
e.g. ringneck-px30 has it only 0x800 above the text base (as you say
below). That predates your series, but the last patch now offers the
choice on every Rockchip board, and on quite a few of them the result
is an inflate error with no hint as to the cause.

I think the series should include a patch which makes the loader
detect that the staging region overlaps the destination and report it
clearly, even if that can only be done once the decompressed size is
known. What do you think?

Regards,
Simon
