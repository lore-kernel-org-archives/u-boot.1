Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9440D606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IwICmUHk;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZUinSVdi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 753AD40B5F;
	Sat, 31 Oct 2026 09:36:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3jKgw0yO8-g2; Sat, 31 Oct 2026 09:36:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C60A240B64
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439383;
	b=B4rKV/LgQR+DS9HyRKOOTvLTpii3AC04tTTkNtW5RA0OzJGYoYJANCuAxXrC+lZdN/2k
	 94iNDV8xjxOimhsAcVuoHFadQ35xHE7bxG9J/sSHoyaZNjL5ZwX7qnTSwGFXbA/aDXaxE
	 LERbnFNwhXRGBJN3z1MdZ3Ulxs5h+6RlzN/o6SqPK5IfcNZEZ43d9F4qTXko7WeJz+mT0
	 tRdUK2kQo/3fSr0QsW1pkN+UfUuMWUGijDuAyBbJVP6ukEUNpUdem1TIHWwxj32eByTKb
	 qz8ZtJ2LfZwf9Y3yPuZQ4yMqeK4HJ0NY3CYRFEo9JD42O8MXd2M9WV6VjeD3qUyETqA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439383;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+cZzzPaR5w3sDVwKDJVY+l0tnGg6sYs2oxxW0JVVjS0=;
	b=pRsp7MADkYH15xCLYmfzHAxyi6ASz5F1BiPCKRB/pvRbaHxN9O+AoMag35KySbnokyda
	 GLP+IJRxubf9UGZFVGjQRe1l4f7WPi41oXS/WygjCbUwrjuubgIbQLLoR2ywA8+1aMKPA
	 /H7GllpgW3Tto3pfmKYG6mdAfsXF6kC3NCU3TFqdnLkJLrOJbC1Wn8HScKJMKiwGc0xlJ
	 8eldwfMfSn0Ha4YESw3iVVBHZ5uD3ehhdd6rEoxfVXVJaXsgIhQiy+KIz0ftX6NuTjPnb
	 5p0kdQUMxgElYMLr/Z+RnUvLAHIlfTjD4QyVYU3NsCDh2DEuV7akWKdNjgEO4AyVdKA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439382;
	bh=+cZzzPaR5w3sDVwKDJVY+l0tnGg6sYs2oxxW0JVVjS0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IwICmUHkras1Z9uKLVgj4aTX6H+7kT1gUvZ4DJhaGxx2zsNBtcKlWqVcRCudaUQsW
	 uP7YarV3S6N9E1s5uo486ChLMSt5y+3V/gSfch88ZVGcCDtYBxcGHu/QJB3eGvql8d
	 U94SBX81A1A43m6kq1WCZ9qixSgOIlpWhCe+eI2ngAnoBQHTvZRULXKr3vs/zFWQIL
	 zYzPUnZZLT9oMIoI6hJQ4AvTRLYiY8Jobk2DgwhA90FTCLHUgTiSWkwwn1qdxcKVk9
	 yYjkttPudYjDj5C6+qBFzNpx4lzBe5jbIAszKJRJY0eg3p8XJoWJ+92MlZeFqJaeaL
	 QxaXy0VAlAaOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C60A240B64;
	Sat, 31 Oct 2026 09:36:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D0252C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 02E0260AFE
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cz45FXIcct6K for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:36:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3182B60AE5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439367;
 b=cMW//xSnVxCqZPe3TdCAsP/opKhW8ejxl8Lq6sdksfltPdaqYeGw+HgYI3zdl4CIxlwr
 RtWAQhD3FsQSRsEyyW9+rjL5cPh8+L9LG+0/SEtR4YelJ/U6lrOyKapT6ETgyydSHmmNH
 XJbDxHsJ3H65R6Qm8jhsF12o4j3Ihg3tLEBGY6LaqME6DdYgNges8BQlOzzdwvRwrBWbf
 w12BoPrVCDM441aTLZQRDue8AWi2LljXsRS8xrLZlp42vo/fwRMF/fmFjuFZcPj1nUkED
 Xak3lyJFRKvXQiWMTIh4cvb0lD3toe0mwI4j65Lx7OG1oGGvVvZ6MRH7xwng/3TuO7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439367;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=+cZzzPaR5w3sDVwKDJVY+l0tnGg6sYs2oxxW0JVVjS0=;
 b=GmM3bOeF0jcHcxWaK5BdwpmdegiRa/9bVsyH8MncWf/lACffkpUzF47S9OaBginWSyB6
 UADuDzOmenCgPJfrB+C0avyOrJRR7Ii1Nj6EqMF9htQMhpt8HgB5M15yw9+uNmRzDZ/4B
 abKAWgPej71F3f2ukNwd6prCsl18d2h5y07RISOo0hMQDVVbjOCTsh10ZZmXaY94JEGB7
 zBdmfHMf7DayzXk8drFGwkag78Ya4GPKdl2IRXSys+iWYmPWGVkrHLmZ34Rx25uPMjSBX
 TyyN/6rWmUCNa5m3zKQah4xLUXhpcFVOk9FQAT4TO1XgBxQHjJz2mwx6ro2ThtYyUlw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ZUinSVdi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=ZUinSVdi
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3182B60AE5
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:06 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b4b7dee316so1470140a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439365; cv=none;
 d=google.com; s=arc-20260327;
 b=TiPsloCvYfI9iqDF3RpeUNjHeTIZOMR16zNCHRdJZ9443W3j+1S3eSfot8cd1cSdmO
 JMjeW3yi0ADX+ZdTxPGFgCnQ3kS/0bJRsckb3AgM8SCZiYtsDJijbtKHRLCpHs6vxY6H
 A3ctGTvxaf0op0PqJKfuhbpeqb5vXGpWWA9Mu0Lf1mPajvtsTXVRn8B3bWFhV31jvxdI
 W+zQiC9Rm1gpRwcRJkNfGL/q4eMHqooYg9qcb8dmnKN+jiWVNCkFs0cmwIGoxo2MGwGz
 e6zEASDIGhX37xExieOsTnt/ok1irWId4NN2DduHW/iL3MDJLc30Qy4RqrGYuHB5OK3E
 3IXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=+cZzzPaR5w3sDVwKDJVY+l0tnGg6sYs2oxxW0JVVjS0=;
 fh=WQwIMGU0g2Tsxkn9yjobD2vu5+o8rQUtsuctR9q01ik=;
 b=sxgaCRcqVC6vCXCWhJMqoWrRKKqhxoQkUuGZjDD/dQmuKg/6WPaiB60/jj0O+N22ZS
 LLdOgUZlpVX6WegfI/1CFjfX/VgLMC7yMXRDuxQiLLymI/1mp94g83OlMTY48KMNPKTI
 BxEIfp6/WVHo/PuS6ziLlA1J2W0FfLsTSdcLrJV3egJy9izappvY0CNiSqFlZ01+DB09
 53N/GobdJ4Zh0YPqxBMOd4BmDrcm0rImX8uEK2P91X6JlX5hLBz1auI/Euvg2q4u6vup
 ckFDZWSpB7q9Vm5wkShnys8qJQ2M99ypbm9FqDDl4bmBEcyqz4gHhcb8m/WKv6wfqMbL
 ctSg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439365; x=1794044165;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+cZzzPaR5w3sDVwKDJVY+l0tnGg6sYs2oxxW0JVVjS0=;
 b=ZUinSVdiREqmD3TGd/eqYptNAduz82PDm8qEHiCfMiQxnO2lewbFnBhRMx196YTuVL
 pT3BXOsH6AZI6/QDssdNP2SK6fBtWQm8Vv+PcjNA77xAMR/2Nj2XobwmYfCPBWLR96JT
 InL8a2rcA3UZ58/etpR8NbJGcpEqaGCrYWT8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439365; x=1794044165;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+cZzzPaR5w3sDVwKDJVY+l0tnGg6sYs2oxxW0JVVjS0=;
 b=F389MwDMNEjLsV4NoQ+TcNi/xGGdqCdlKrXpHujQ5pUU4Ha9l45HLyM6Qq2GpnIFcS
 Is8ce54Wl9YKtVY2C8PqSUID7kUmwC989ALgy9oQe/RRAx86HYQgtNkZZ9mRU683KNrS
 mIiuigg3cpt5SxNc4CTYN6Pk3VWuAoEBF8WarPh8HondhiV9/xpfVkQWrckiTupa+HYf
 QUnM2gCGZMYiXULkVT/dmsD+swra2XIbZg76PQMi9pcER9eL1uc5g9BtLhH2gpdqHnxP
 k3+UXtV7C7SkFM3lDEbxY56lQCJhi1UaSFdbxjU2SsMF9AF8F1waiw285h2ei2Eqpjv7
 VWIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBym64V/5hPG4WOTUxboMg5wSuZ8YCcVOjNGDybqwLRNRo+zIlOLuou110uB3qLtHEE7D8Vl0TE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJVLIfyfKlPSQhMOStdNDWo/QsflpWS2IyRuiGMP3qenAfkOXXG
 g3YGQBgULQieyt0iqupLSfM9yfNtAxE/ekTaYpXHKjBhGXXuEHiaHcXMxpbhEzLtUvWOZ1diSt7
 KAbXdYwRBD8HHmzgJqJFiN3zNH8IxP0/B/9kkzC4O
X-Gm-Gg: AYBFou2Ybx/6VzQgwMTXSqM6FLi6ZbfD6qWNmKhar+h0BvqbIM5iFbHCAaG4V4qecL5
 yb91UYJmgkq09Cg6IfHQHPD+ED+9oVsOIGQL3QpLMWAeCQdAie+6xMRdTo4f7EIcUl6ABxORh+U
 XVJ/y4kaAsdVNG7RTt1xBw0YrBkjRMK76yn6IW7778X6GmHu9DgNCXUQPgcGkjXwDfkLWQYaYvU
 dzR43CPZfTqhbHH4bxG3mHMVafcSkialIkSZclvFCDTmANzPsPXHVefz1xyFCC4Lxy7HEldxYrz
 2fOBPOMaO729mBmqqKfoNaMmlXBhgcbq5svgTENYa54xr7Bpnl8+HdHfRlH8gm5j68/PzsQfihr
 mdToC9S2wOGce2tTXXvzQZ9ZVfdVCiWDUrhn+5Evssnl0v7zI36sXepaSL4pPV07P6g3TfH8=
X-Received: by 2002:a05:6402:5516:b0:6b4:62fb:82d5 with SMTP id
 4fb4d7f45d1cf-6b4d3288297mr3236320a12.0.1793439364920; Sat, 31 Oct 2026
 02:36:04 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:36:02 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:09:26 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-30-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-30-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:36:02 -0700
X-Gm-Features: AclHuK_djel57bFExphrfTw0xCfgfHd6nhrd_K_Fk6RextGHQOtnMGSUN00DFcI
Message-ID: <CAFLszTgbAO51=uEuLx+Hrtfjj57Uv3mm2+Jm2jH2KqsMeNOieA@mail.gmail.com>
Subject: Re: [PATCH v2 29/37] clk: rockchip: rk3576: Group LPLL register macro
 with CCI macros
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3576: Group LPLL register macro with CCI macros
>
> Move the RK3576_LPLL_CON macro alongside the other CCI CRU register
> macros for consistency.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  arch/arm/include/asm/arch-rockchip/cru_rk3576.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
