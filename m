Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384CD606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 23:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c6NmFFLa;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=OW+eL4Ld
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEC00407E8;
	Tue, 20 Oct 2026 23:07:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y1x2ah5l0Epe; Tue, 20 Oct 2026 23:07:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 49EB9407EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792537671;
	b=sS0sC1tdM6rplwuQvYBfmuu50H5sn0O9IEmGXi+PFg9SKp2/AWc3YsorGqzTlVLV1wQQ
	 6Jbo+qXm1LUZJ3kUnCr8offQh/RRcB/5yLngiXuHuLBxTkoEYX6t6s7f37D4c8OcHiTiE
	 RdaF5UXIna4fPqE960ai4PP8DR+8RuGYZEtL2qMXNmPwCyZ7eo8BFEKC33h5nc/B0MbDG
	 UGqfIDnmRrU0xXOjHHV3vXFzoT6eYz35bFyGfDNfrfd3+rZPLxpMbW8+yEkGMkh5dSaV0
	 eeZ11gPpz7JwEQ5Dn0R9DMad/8d0eakhXChDHQ2xPHJAbJUobNxVWpSoELbjDKrn78w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792537671;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kXLqPkmNxASOu1wCy8A0QmLQTmvFvGhybtsjn5btg1s=;
	b=d9oLejFDcy01RjxUBFOYxEkX4+2967u05eZnw6+4sqsEiA9Jk/nA96/GmjlLLqO7tNCr
	 awWQMeVnoJRhYONkOENEiG+x0z+GbNW7NezOXKkNT7+hFv46I4KJhoAE9M1cbBKIVgYvo
	 hCH1twgoAjYFN6l+iPrB6uEFWhhhgGO8txD56fPy4stiAPX0jE6h7D3PLCRqz/4uDTQqv
	 AsvUAV6rpNcKRwHS7jqsU+pBIm0NSa2ijh4gckTXJB3WyTAXDbwwoYK3RJlhTgd2Ue++k
	 cxlc2D7jd6NWkVa7XPz/1x005up6fS7Wt//wxnlMSXIhwM4BxKYXgARchx5CxFfBpbA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792537671;
	bh=kXLqPkmNxASOu1wCy8A0QmLQTmvFvGhybtsjn5btg1s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c6NmFFLanriW30F9tf7QUlg7z2Fu/epAvmkauvzXmH8qgUgIHPRSvnHyYPK3EURWi
	 NcS8bzvE9Jou1DxWwUftXrs1Js7wCXSYqa/QlmxtUisD0wblNM+vFIHbQ/Z+cXHo9u
	 t32PXK+lzNAdJfAUSo03X6mU0ORCWtf7z3wqLyAUXCy/u+dgSgHsOH5HudCh6wnhzr
	 KSu3V6aFlwj8ndw1aFbZhKgicaONsKkPULJDRb/QO/PMw1XWQ+WQfAnhWCtozFw19j
	 aEUoCK3CTxKbLYmy/rZ7FitosaHfE8KVDfIYZ3TJqKXcyFVNJP0XEdS/jhzDFTz2Xd
	 V1awKrBdRbUFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49EB9407EE;
	Tue, 20 Oct 2026 23:07:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 08FFD1AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:07:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF0D740112
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:07:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TP8wdWOEtO_e for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 23:07:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3DDE6400CB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792537669;
 b=CNP4QaYH02mC/IiHH8cuHLRPYDzPIqmvqOyiy4StR31H9Nl78pPuQ1jyLt39iuxXKIIK
 T3QPo2rlEgS2KW8++ltTdiUkGA7ezGKiapXW0wSajn1vEP/qB0cBbXz7xvsSlvLmu/H/Q
 HkJF5slU+jDmvCc4rWryNzmZFge29+JBhZQe5GC/kShx4h6ljG3Ft/rvoZSVaWxE1j06V
 5d/fy2O5nmYgynesY5Y2iagddD9cs8yzeagfCAhkET5hBHQVL1xLjaGGATBrcYr0IihL7
 88rnBs0rfKGNAHpSHPS2zGksYsEHXntNiI0sz7NxBX5T3vaXC9PkqIwjpvwf6elFuaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792537669;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=kXLqPkmNxASOu1wCy8A0QmLQTmvFvGhybtsjn5btg1s=;
 b=ROOMyQ+6R+aBu/q0mO5VVdRfVpJnH9ednz58LnLYrJ4sOy4lpvdwK+allscMmr6y0Bep
 k5kdJK7jOHOfAL7bLFJezOwBUXlaFJ/1gRAe1hChSWF2/DHevvSqhAWORljlUlSSN95Il
 gZ/dv9I42BAFuj1/BuQ7C6d7KLdx6pbG4hVTVN+x9sMCZRK3PupkHwLzvHTCO6uf2bXU8
 yJSHWBKGUmKMb0nx6BtPm21g9+7sZcEjC1H/+xtz57e6LR99aliZqEilDIT07ygk8mj4U
 CfwugsX24VTZaPzOOI5IqFALQmQW8AapusuQUJIhIpMXDReaRjHAPDO7JNOXzFnnFKA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=OW+eL4Ld; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=OW+eL4Ld
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3DDE6400CB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:07:47 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-843b6f8e2c7so129489a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792537666; x=1793142466;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kXLqPkmNxASOu1wCy8A0QmLQTmvFvGhybtsjn5btg1s=;
 b=OW+eL4Ldi1u55+2TyoFNyTVs754dlRe6sOTAxMUeoBRk6obSwDHLeER2uOv1U6Pmba
 /Mvz79fPY467jxkpclUFuEXjQL8yjcAhfazpy8Vz3lhkfj8uGlqlG9yk4xU+h9Eb9/Gx
 vkj4+pxLaR28TvD7Ctk0hlsAaOO97mOsv25U6X7d2yF38DB/3QpWJ6+1RArXQ1kJcTgd
 QCMSDf9VlsknGYu48EVELX/BNAV1TIn8QZ5Cqq84fi9s6lTRONgNfdxHn+oafxj86uVT
 XjVBaH17iOT29o4TsoxU9nfdQdEo3dAjj30mt4duqeskDZRh52Qqii8PIZ2iAZqHQuew
 t7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792537666; x=1793142466;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kXLqPkmNxASOu1wCy8A0QmLQTmvFvGhybtsjn5btg1s=;
 b=0RkjU3g8FP+N58JpND4FvWK7cSC2Rm1TM/7EvVaeje5CY1rDkVtTcPxo4UjNUC+Y31
 UmmsNxIqUxUYZduBJPHtph0Je0ptpZ5kXJH4LfES6l7vOnxlbNzRbvaq3if8VwmQbSva
 W5ym90BUsTYsMAJ4rjsUQj8GAbcSSKKIArv2Wyp79BYGORQBlbxd1Q9pX68hi+hePalp
 8x6dSVc/78irIsb4EU0DAxcDyYPGCeKKEPVPay1MuBh0ybMwujOTGlolLhaJtCtRvmhP
 a/yHbwehACJnqv2bXR6CLvL0U+9lWHeuZDhZg1iKKo11vBsJySFugFu+D2JtmGYtbwya
 5T0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEttbuds7zcrdWEWB0OtJOV0iirLzE1eyJzRiBz+U3C7h1OGaK38hbmkB9gxyvf8GohOObwWs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKjSwaWtie41Z0Hbj3/CDwN7GaLutzGwXXzkkSqLqCDjbXtHUYR
 zfDt9dBZgUJ9hxaDYxqn1kosdLKwZ6WdhJMjdOC5qpNpu4CbmcuQJb0BJLkpOtAGBrA=
X-Gm-Gg: AYBFou32JKHWWAMdsHDpQSDJS5ZWYtwBbVyfHSDIdQ1LWiOmyRNW3I0Oix+Cp1RTUi3
 0xL+oNU005R29snGYyFi6v66Vz0weSAuTEN449e1mXJ2oGWH7Oa9kfo7D5wMP30DImsq+ZyUzuh
 apMK4WnpbCQk68b4T2ex56FF/9I/jtGwpwA/oSRoJHMhzwyJBsO3SydJt9PXxZNdoOhUXdJW6pu
 snfXIEpnbBYhOpIdHM5h3L33UBtpnjyuyY1Me3OGVDvyU3OTkkCJn1TSvZjkfiGhztUNXbLCwV+
 ovoCZRU2IN93AnUm3+ofyFaO3CazsTLHFyhRNOD3JpRYXqPwV9rXwK1jiyhDtSfUFbYa1t4QkQ9
 3vCtBzX2F+P5JZuEIExyxmEZ1/sqV1DOY88mS2tvfIq90SqINmfBpn2t7gNSrF0cfQMmgXY+TVK
 88lgCUsuTLUIBSIsrpmVq6Y5JSgQ96MEtZrGLvkXdCrS9fV3xOFg1EAyOUzFbtaxPEI5z90jy4b
 1o6UYlvpSVpuJDjLgzAesYXw1lV21UfLWI7V67kPZyFPHuVZw==
X-Received: by 2002:a05:6830:6b05:b0:801:21a3:f31b with SMTP id
 46e09a7af769-84d088032f6mr140456a34.23.1792537666207; 
 Tue, 20 Oct 2026 16:07:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a238:1d98:cbad:952a?
 ([2600:8803:e7e4:500:a238:1d98:cbad:952a])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cba7d4648sm767976a34.1.2026.10.20.16.07.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 16:07:45 -0700 (PDT)
Message-ID: <51d76f98-2955-4a27-b93e-7372c32dd7f9@baylibre.com>
Date: Tue, 20 Oct 2026 18:07:43 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add MediaTek MT8365 power domain support
To: Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Irving-ch Lin <irving-ch.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
References: <20261014-mt8365-add-power-domain-v2-0-dfc3e6eadfd5@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261014-mt8365-add-power-domain-v2-0-dfc3e6eadfd5@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/14/26 11:16 AM, Julien Stephan wrote:
> This series adds the power domain (scpsys) driver for the MediaTek
> MT8365 SoC.
> 
There are a couple of issues. Since there are a lot of other patches waiting
on this series to go in first, I can fix up while applying rather than going
through another cycle. I built and tested along with the Genio 350 DSI work
to confirm this with the fixes applied.

