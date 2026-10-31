Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907DE606A31C
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ErrJjE7f;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UWIX0u6B
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68B6860AF3;
	Sat, 31 Oct 2026 09:35:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oRoVSmtlIOpg; Sat, 31 Oct 2026 09:35:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9D10860AFC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439337;
	b=OQaaQs9jkrME1k3yBTIxSMNBZjKchTcN9Ybw89JNBND61KuOnE2bU4HrWtIezKvOqZRC
	 1kpXjKGDeEVkDOwuiE+tR5Kq0XfbtPoheeUb4RTGH5rTICax5iLx6AfhudXQvDZoqKHNy
	 /ieJopeUR3dYykeJPq5ZbYchRZqm2Z1scGHAZxcFISb4PiC6I1qdKJY+7dncbRJltq+fj
	 IfN3MW7pNbVqGZhP9GfH1xuVHfQWmp6H0L93CiK9TSRsWgZ4+kqwmRej8rq/GNIEYsyLM
	 GSQjT1zRWLu8/Bw7GCUVw0YEGL9ZStt8WJVE2GucZmGn5tdMJPpq9fm20YjWrVJyZ6g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439337;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=EESEx9dDNx/nLQ2DL4LwJRWDGKP8lWLfhMwWUdluE0M=;
	b=InxC3rHDolV3kuw5KwFVTMCVIZ2wRVuYEPKNa2EuhRfQ1moF3AQwRbiQiK78T+gFiyxw
	 KdDgvsclxTjpiAnLlwfj+olq4KRayBEMT4mCsLfy5k7yimp7XSVZrdMZnETdiK+7k95js
	 +BIaCOy55M/csp+GAMo3HQ9Iq0euNpRG4PN1BmwPpKgxp+IAf10o9vq8eiAZ1MZmoy7AV
	 rEZel3KWzg0p1XOgF3UEXDMpyaEQAFOUBbBZmjgUZdg69uSgPZfBAtSUs8k5lBXfRGRlp
	 fAWi2isa0O/BodS8oRZMlQHKXpF3ZDwvzY4D8aUDZ7A3hOfLSP2yvloiICHGFa8u1iA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439337;
	bh=EESEx9dDNx/nLQ2DL4LwJRWDGKP8lWLfhMwWUdluE0M=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ErrJjE7fNdWkI0quRQa8q8kFGoqfhihz3bq4EW69p60uiC84SybXPIhwTkPEwYuhf
	 dzWsSpeZEIj9xWlifIcXcVt3wm2dOdAhH4Dp1eEfiR8+523Z6aPcqCKzIry+1dE9tC
	 IkI2It6I2icghtuIhmqBwMoK5VC8USoSIEjXqtHIkpW0WOEK8SON2XOwMorJbY7pYi
	 asxKaFFTnMU/QzdFIf8h30wMt97dYUDUsvLxWoM3jYzpKVX4Uf//5oAobDFruj4f2O
	 6/QgRPd9uyR3Nm+7RQEfdahInCMeXXnlOG15DJv9HfW+si8Ocu8t7o9JR1HyNas7pJ
	 vzXGizuFiMemw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D10860AFC;
	Sat, 31 Oct 2026 09:35:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 70AEAD44
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E37140B43
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id noisFdzkGTeM for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:35:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CC42040B88
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439329;
 b=aEagVBpg7ForY89jydO32PSqjvhNngFcQNHTz4fFlUA7XoKGaUlGSXtVTKq+Zo4unO4E
 bphdWF9T40pRPHdYUCdgNUuhpvsnTqkps5CFKyb5NkJZclQ/XRaoRL8El+sIRZGjylGIX
 AA95E305VBNDO0RiBjnZVviqAPqdKE1xCMtovwf1fF+vS5ssFbEr2Oz0SyDBHVbeB1saA
 y8FXDpm/NpqOQo3H+s6ZU9zD/UdSulrD0TraQwqd1Da/lVC9gL0Unqqc+ycsEAxXDuIwm
 2GB2aY1D4vK2ctdCrMRPImHHEHzUkRqYz50FoSSk+mW1XsMf0rHr0Q1RtX8N2WXT7uA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439329;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=EESEx9dDNx/nLQ2DL4LwJRWDGKP8lWLfhMwWUdluE0M=;
 b=a4PKow08uhaZ1yb8pBUa3obCapEW6/8l2p4Ae0Fyqs++PLWvRrgdGyhzst6Ed0OZDiaZ
 b0xyt2MF2Gck7udBUk0shg9FvehvLI1QQkSwraV1F0BmXqsoZo34VxnoWgdalVSB7EcVu
 il8R67SrnuTW0GBToJhKTlWTPuq9cT1HGNdb9UyIdxLTR7m0wpxiYPmNUdnhXTQz4uNin
 uoZ+lmX8uZAtP2pmkOUF0d2yd8MxyE4kYnAr+9IQbAnfq2SV/QeLi6t6YJwQSMOuyils8
 CMLP7cdWczXnZC9u8v4eAZtOI+My2xbz4ZAsxFRDX6/WmkJLJ76lOi+UA9ojXkjTLyA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UWIX0u6B; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1033"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UWIX0u6B
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC42040B88
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:28 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3ad787e0593so723337a91.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439328; cv=none;
 d=google.com; s=arc-20260327;
 b=D0wiXU6TqNkS4RDL5Izkg0FFsNok5XZ0lZgi/e5TyL0mamliPiMmfupkox8E55zq3F
 YMRiVbCQ0Sg4m4Y9W9pcU+jMySsT2+U/6Wu5xYej5g62YmcpfuP9OKdxlTiGYqlwduy6
 p18FUtr2s8mYNUcPVYqogzd+EZDPgdmKkxbQIr+rF3uIHEPfK0HuNr9ZY71MxJ2JHdYj
 lRgxsDSalfwRlerqT4NdpGrQLL5nPeFEXhy1bI/q0JpUnkhARTqyOcgRnBQwD6j/AtfE
 xn3Qv3sjkzejb5jcPc5Hw6z/PLf/1yK6QmRYsJS1kR5ULjEeZaFKxqqNJaQvV6Iin6d3
 m60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=EESEx9dDNx/nLQ2DL4LwJRWDGKP8lWLfhMwWUdluE0M=;
 fh=9CUsc/vT/lmHP0XsSntQq5sTIM6j6Yyvv0Ekmao1b0M=;
 b=L5pOfNijFVZDybBmOSTMmCHzqUk4XmzaQJWfeR59Nh7jbPMh0zZqqXEFeZ6swnQWc5
 fLrwNuAQFYo/1psWXQGGxVOrN9nwkwbnwh2Ik8VlUyzW8+Sg7a+wZZZnRqtwOMWGw3L3
 C9OUiairn47qRu18Ujb4uSsiBDVsbI+qbgBWW93BMB/8PASZPskHUx3MQHCLQN+FuEWH
 7bJ1+s79fX5zivBlFUkKvLDBpontFaIoR9SgF0MDHSopJSFChxevtqw9tTk7+4l2sUgd
 XnEtOrEgle8m1/IuX6Jlsn1LAXQqM3RvcGljJbuLyHrcGTA+hpBdsQ03DbHBHOg0i+IA
 452w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439328; x=1794044128;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EESEx9dDNx/nLQ2DL4LwJRWDGKP8lWLfhMwWUdluE0M=;
 b=UWIX0u6B2c909t+dZ+BmW5TIpqqNARGKTnPBeLzzVCiIxpWCsbQcrlDSmT6tbwMYeH
 s+prlNaYOJJBjLKPnp0Hgs8AUCHoTpCWDA6yXPh+K8Nt/PVF4Qo69ApX0bKakg7c+cBX
 HH+lBNTDGfMLPymASxjMfI3pY1SgXRcEwn70I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439328; x=1794044128;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EESEx9dDNx/nLQ2DL4LwJRWDGKP8lWLfhMwWUdluE0M=;
 b=JP0e0eXeBnFdmbvGdVCNrXmgIctrDlenPSgd5yryvQFyp7zB+uckib2rVwW0Y8UbgG
 BcD7ssMmu39RHYJ33aNKJnNQVIaIA78wUClWKpkVe6qTEVwYN+C1aAjq4kGSejZo5Lu3
 T9K8eXtMLmGf+gjF9K6EKiUh3bn7gpsxW1WIghHOHNszm5mOe6RkTFgjz72WRaJ/0Jw7
 pd5UPgv6DQXls46Cwg2Z8ldixih4SnJhIoNbRSflDZlg+3zdUIXaRH/CaZWfaIH3wkh7
 yxYeIzCqf2+pZbeXU1XWP3VAalq57/boohsEkFOQNa+boSjk7S4T5c/ArK11TTTXVp8Q
 hdmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwygErtLGAFacq30lSMKm0kByaiH90+VdLcFNnrSXRhBYEPB/27fKfhqwcw2eSLq5wma9k3uUM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIrJmoAe0BeNWRmW7S5WIMBxjoFio6efzL1bJqo5tbbIvRsF+PZ
 T/S8AnpNj681EoTOe96IynbQ0UCl7eduyv5Or/8WXmnei5ucmYMJe9k/i2GFEujmmBtTRZ7dWnK
 OPNR/NNcQmyQzw6d6YU7vzXPdxdzQYGWg4umr1hysEpxOsbIba/Y=
X-Gm-Gg: AYBFou2tsijGW8iAlpUriSLhxsW5PhIrDG/sjc3rjO6OYPhJI6bKyXTFBCmlmjU6QBg
 QmdX8oS0sWHRQtY6QN+uqBBUI+F23A90upYtcEy2GWNi2qfWB85I12LchCLPJ/zX6fJaIlU31Dd
 I4vTm7hL3GsXatDvN03XFJG6CPILXlp5gLc1BuNsCmUIH/1ArwEeDJrcYjAVXi4CLuZye4NuF+E
 avTJclav5SOAGnvmGRD6lt5ZYtJgdrWXF9KZa8iy0QkKdyKRP6f1AvTZ59hzZdr42EafZKLEdRu
 SQSEFvaD9kKkrfIqKNygQF9mEGO+qJdr0w9EuG+1RRd/QWCjPdIGadSC0zAgIdT64vJFV5pdjXZ
 52bIuuhZcVDGGty24hTg1oL37FGRpAmUJnG67WyxFtraSDdLKFFdSV4dc016NuJ0FU43/1pE=
X-Received: by 2002:a17:90b:4f8e:b0:3ac:7f4c:a690 with SMTP id
 98e67ed59e1d1-3ae897dfcdemr3455045a91.35.1793439327849; Sat, 31 Oct 2026
 02:35:27 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:35:24 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:09:18 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-22-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-22-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:35:24 -0700
X-Gm-Features: AclHuK8NUwFKePDN4QJW2l1Q-_pAO9MGs091PnsvX2S-2lrJOWFPnvANIhd9_eo
Message-ID: <CAFLszTgOti2TdZ1wL_RFvDxE8vVxR=1-jELV9+WtWEApYaDrqQ@mail.gmail.com>
Subject: Re: [PATCH v2 21/37] clk: rockchip: rk3576: Fix I2C rate selection
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org,
 Elaine Zhang <zhangqing@rock-chips.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3576: Fix I2C rate selection
>
> The I2C clocks supports use of source clocks with 200, 100, 50 or 24 MHz
> rates. However, the driver fails to select any source other than the 50
> or 24 MHz source clocks.
>
> Fix code logic to allow selection of all four supported source clocks.
>
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  drivers/clk/rockchip/clk_rk3576.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
