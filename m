Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607DAC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2F7981123;
	Thu,  3 Sep 2026 22:56:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wx31R7pMNwoY; Thu,  3 Sep 2026 22:56:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 81F3A8111E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788476189;
	b=DvSbfKcoVpPSe4N3QD3Brim8xMN+xRgaLauPhrnDW9jSgSFlSoC603CZu13QbKaWLXep
	 L85VRoMmsVDIuaEwtHBGqFsfJ9cWI9iXD/KT24BsRE05JdF0AL160hcRBzRoV5R9PbROx
	 Sa8FBH+lg5QWeY6oiFprVMf6/gVXg2zW9J4by8TMdHvs7wFhJH3Zq78THkXdQ2DIGS4Bc
	 paGMPOylLxowyNw5AyXeqBieFByguj40dgv8/EsJ9YowOk6HtZAh90kISWBHb4DqI1OJ4
	 /qD+CDl4DQRPDLtxAPXg68U+63lXFwDgHf8kAatoSCOzdtjYSIwEpIdUlpgfoVhkRaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788476189;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5M4gSZx2ZZQtBpKDP0qiYFvWziW12XCi7RL7ylQbYJ8=;
	b=JqpqF//xpxKLXClGkmKtvuugVcdl7P1yrxhkQdFv1D0T7HeEJLnnxU1LeZprFPu51uGy
	 Vfm/7pDAhdMros5kuH3aI1dh7hhAk3BG5ALrcMAMoWhoOsz7i6/CvdPp/WvqcuuQ+1O6O
	 gcqK/ahjB+hAA2qRCqIpjgiaAig5gOXEZZkWPeEvq7hL0DfgGbpE4WQpBY4IMfLIq8teD
	 AA1ffTdE5CuwQ8bc9Y5y2b4D5gbY579y1Vx+cZuEVjii3SlU5YIYoYpYd6/32FJbY80ug
	 /OXwLHKJ41L+oLHdCJIG1EbxG2a7YcFQ7Tun+h6t7kJfTOhDbZCxNQYnlMkRK4nbtYQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788476189;
	bh=5M4gSZx2ZZQtBpKDP0qiYFvWziW12XCi7RL7ylQbYJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kNYcdMMXjt7quebHzwGdQskNky8rliffm+vTwuAUrnIJGIYLR3oaaFBZxASkHS5qj
	 22Qg8sDD/uLquaeERDhQShnNvJrf7q85/nu6G0TnBaghpaB/sjS89X42wpIu45z+L1
	 sCIQSVN4Mng8LzSDRSKJX5xeXgIfVfM0xDNe9Gj5/qmx8K2e0HLMreznyMkUwdhGwT
	 3jKvMNRVDzAvbPeAJwXVKZjfn0GQbis7esS4e93Ykz5o6Q1bMKgG8lGy8Qmn9gwHsH
	 E0/fvmpnCr4sdF3yo83FgWLHJRjuH13yDL8D6ZG2uvIrEMtmEl0B/fJ1+EC0IhCiLQ
	 WMpDAKqbs/aFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81F3A8111E;
	Thu,  3 Sep 2026 22:56:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DE8B22FC
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 22:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D017E40808
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 22:56:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4AOCeD_f5T_y for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 22:56:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D562E40806
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788476187;
 b=MOlYJaPbmPfsOK4aWU7asbv/mv+bWjIdNeliOIkKz5wv09lQuwf3wJjBsxXZOAVFWw+I
 oAZxpv08/0lh27rZc0AwQtzYTk6ehwyGlRcs5Mts0VXcbg+3HrepCsJfZWBXe2Vm7Q/UJ
 O+gxub4R7cbnVrJ5LfgF8X0kBeOrwP3T78FLnbgucp8wDX0VupeRMB/AyiO8lK1htXTc8
 5KaXDdgvCqnAjUckkxodjRvgmscJYtLVrj3VI8c5QlY9PJ8Q2Hs8xg9Pc1e7OJhwFze0l
 lN8a1WCFJEec97OgHXcg8wSFP53K09cJ0V52GowAuVg3VsS+G1SBu3tY+uvqHOWdg9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788476187;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=5M4gSZx2ZZQtBpKDP0qiYFvWziW12XCi7RL7ylQbYJ8=;
 b=UFwFXk/kYNNi0huUEi0JyoKj7Lywa8mGJ3JlG7QSckRXPXTsz49XZ44rnoeVLtKVnemI
 DzpG2s6CgzjM5fZLPu5oVhdZY9bG6/hUjrnAOUYR+nr/zH+zkUV1YZHhus9nk830Q5Jiz
 WC08xE7+16OE89swE98O79c6bSUUsPqZkxGC9f9yarWxfCCC72S+vdhVaM3YbI2BlqNmw
 FanB0bt8vn7Bk+SY8d+78+JFUlrqzy8XJGji487Q/tAIcBvNZ76nJBJvq+l7d8LthIMoh
 qSOEa8ZUV5N3MYegDNKBD7+Uifjn4dkORPgn2AilNLdA3nGH5ESzR9hSilcziT7EFJA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=R2QwTSuf; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::6;
 helo=mail-oi2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=R2QwTSuf
Received: from mail-oi2-x06.google.com (mail-oi2-x06.google.com
 [IPv6:2607:f8b0:4864:32::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D562E40806
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 22:56:26 +0000 (UTC)
Received: by mail-oi2-x06.google.com with SMTP id
 5614622812f47-4b374c2cf2cso67048b6e.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 15:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788476185; x=1789080985;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5M4gSZx2ZZQtBpKDP0qiYFvWziW12XCi7RL7ylQbYJ8=;
 b=R2QwTSufnsJag0rNx79/9mncOsmLfgTbfJVCyarlauUBHp2fEzbAXqFqdj+WVtk9l6
 4r1cFrJYtq/g9NdNSrBWyWhKM/5ajaFoNteqDNL487stgvqqQre3wLCMNJrFRhXzECDR
 zMla7gxO4RFFys0Il990a3t/v1uF2sk7kaCbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788476185; x=1789080985;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5M4gSZx2ZZQtBpKDP0qiYFvWziW12XCi7RL7ylQbYJ8=;
 b=d4TeuwSB89T8o+fr2cIvhcTUqwatAVYJc6rEwwNB0Ti0C5AI5Zxli7AXX68kJG3rEa
 006iI5q7utk51llJuPHMhAPLgHDVkWu2pF8a0A7M3Ug0W4IdO/wrhn87HfQVdGDZY9cR
 e0vZH9PP/HuONP/4NRZcTd1I892mn7+JWi2c1z3pw4GnNq+x2xNH5o4GoAvcvfBDBmj+
 +zLAa6CZ4Q8CWmgMT4BmNHER7w/ib1ENdudAzTuWmF5iCc0ska66P/xnL5tLGC/vQWTx
 rBgzodlj7e4ud7rUM7M+nFmdnUFS5b/VUo4Z3UrzHh586RfzV/R9ArwH+7KYZKBT3+1t
 FWHQ==
X-Gm-Message-State: AFuF++kcL7dzCZcwPhwYADuEDE/kK/wVJnd1U90LSIedRWUPTFfPPyht
 UMnDic3TOIzKV7C7tIWkwg5U7Xp56x66KLW1VZsz0nbvLx+lS/Xk4vG9frJLyOcSJ44DdoeH3Kk
 aviMPIitNkH8DvO8=
X-Gm-Gg: AYBFou25IjVSlvA+MFAzfMeXADKZuTbj7ee+uBndDWmyc7/nxO3rH8X//aHlP3BRqz8
 8ioAlCdLyY1dcBbc8p8UDHZlqfliLKDONJR3GZXDOaTOMB2X9yfCaQpccdnHMSBcmnKs4zSIxY7
 QGGdHfN+vzTIm747Hk0yf7CCT0qibtNTyixxumyaf0WAimD3EhE9tBOuYafMuq4SumNvvS51LZu
 J2uUIIP+rv3pxT76m1C5BcgSfPPt/hB/7S8JX3ydNrPdZGufkz1zLz2UztDgkkofS0a9wdPF2ws
 oi8qjC0+67HP0pNy9+/nL5gCmHhFQCw6dIOG7UooLyVFbZ4m6W8bK7SbsQSMRs4am1qSCel78YL
 I8PrAFo/5RzDaQxjEEvfw2s4Knb2lQesiWDMh52IXkgJdCvk/lyP9kPfmW3p63pnFnDHuS3DXJf
 uJ3iUkQ0F+kawcQR+h/QKv5jdlWaPrq+FgWvOlwfiusSVTvpoMn4vo0lD2kg2XP/SHHpIJa/E/t
 coCTu3iprQUaQcV9lSMzml1F79+6tI93ooQV7Rjga9FkE51Uz36kpLODkmhAjC//EV+AxHvRYOh
 /ljD1rXQDXHCEqQOiyDkGeE=
X-Received: by 2002:a05:6808:4f0f:b0:4b9:a88b:8880 with SMTP id
 5614622812f47-4b9a88b9130mr120757b6e.22.1788476185468; 
 Thu, 03 Sep 2026 15:56:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b971b97c72sm667413b6e.15.2026.09.03.15.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 15:56:24 -0700 (PDT)
Date: Thu, 3 Sep 2026 16:56:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Simon Glass <sjg@chromium.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, dlechner@baylibre.com
Subject: Re: [PATCH v2 0/3] Improve logging on missing uclass
Message-ID: <20260903225622.GA2662603@bill-the-cat>
References: <20260824-improve-logging-on-missing-uclass-v2-0-4bee2cdff72b@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NQE+dtJRZjg2Ut6p"
Content-Disposition: inline
In-Reply-To: <20260824-improve-logging-on-missing-uclass-v2-0-4bee2cdff72b@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--NQE+dtJRZjg2Ut6p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 10:44:15AM +0200, Julien Stephan wrote:

> While writing a MISC driver, I forgot to enable CONFIG_MISC. The only thi=
ng
> I got at boot was the following obscure error, with no hint about the root
> cause:
>=20
>   initcall_run_r(): initcall initr_dm() failed
>   ### ERROR ### Please RESET the board ###
>=20
> Commit 3346c87625b8 ("dm: Improve handling of a missing uclass") already
> tried to improve this case by returning a strange error code and adding a
> debug message. But since neither the debug message nor the return code are
> displayed by default, it was not very helpful in practice.
>=20
> This series improves the situation in a few ways:
>  - a new dm_err() helper logs driver model errors at ERROR level, and the
>    boolean DM_WARN option becomes a per-stage log verbosity choice
>    (DM_NONE / DM_ERR / DM_WARN) with errors emitted by default. Note that
>    a disabled level is not removed entirely but degraded to DEBUG level,
>    which is compiled out by default, so even DM_NONE can still emit these
>    messages as debug output when debug logging is enabled;
>  - the missing-uclass message now uses dm_err(), so it shows up by defaul=
t,
>    with a shorter string to limit the code-size overhead;
>  - the initcall failure now prints the actual error code (and its string
>    when ERRNO_STR is enabled), for both INITCALL() and INITCALL_EVT().
>=20
> The existing DM_DEBUG option is left as-is for now: it works differently
> (it adds -DDEBUG to drivers/core/ via the Makefile and is not phase-aware=
).
> Unifying it into the new choice, along with converting the DM core debug()
> statements to log() as suggested in the "To Do" section of
> doc/develop/logging.rst, could be a follow-up series.

There are two issues here. One issue is that tests need to be adjusted,
as CI fails:
https://git.u-boot-project.org/u-boot/u-boot/-/jobs/83678
for example.
The second issue is that am335x_evm overflows in SPL due to size growth.
I am currently seeing if we can enable LTO on that family now, or if it
still has a run time problem. If the latter, then defaulting to
SPL_DM_ERR_NONE might be how that has to be handled.

For re-testing this in CI, please feel free to use a WIP branch or
something in the mediatek tree, or just a tree under your own username.
Thanks.

--=20
Tom

--NQE+dtJRZjg2Ut6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapn7EwAKCRAr4qD1Cr/k
CrMRAQDjDlIZcC2p6jGheK7xMeDuVreeqgeEYOou/PvM3A5LTQEAxxMicCxkkSb6
Ythm887+2gAIuCXBxcPpCv4bKj75wQc=
=Xi5j
-----END PGP SIGNATURE-----

--NQE+dtJRZjg2Ut6p--
