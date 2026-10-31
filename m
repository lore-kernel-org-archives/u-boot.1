Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB6F606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nIy7R68h;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dmSPXz2P
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 564D440B47;
	Sat, 31 Oct 2026 09:34:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jVv856Z9LKG4; Sat, 31 Oct 2026 09:34:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F44C40B03
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439260;
	b=DDuutcT8Uqr+5/tf7hzvnYqmFxLfO8mPu5N4S6+l1WUmz0Zftz13E+vVvuYx5c8cxjQI
	 bfW1Hz+5WI3b5JdQzLQYbeD0YxR/xGKTsvSSHrkuovirvdIybXUubZBGIGtAfiunCDKlg
	 FvtZv5MXp0HXXHzaDji/2C/se2KkviAIWotu+PUI3a/I9dpWaKOsieigWnGfuar9Ala+e
	 2rwtKgb9Sch2JQFTUMQoNQOkaJ+0aCk7CQHsGd5vmWhnGdTNwwjmiDzxwpQtI3+W/r3Os
	 LNFfdV3oXG0Gv37aA0dUzgx7MS87PVbIf1kyqEnC8IlHo1XtesydKVDnuy7i0/G/IcA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439260;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Ffl5mR9BnMzz/NNo1G+8fvxqbiX/vY245eAhhlXn7tU=;
	b=BU+qtSYdc4atzRFkZCrui/HD+PPO3y8fwznFr0CtBDv7vyaPH2K6BcM8yducX4Ao2bgI
	 KwnV9TNbi0YYrYiQT+yL6XlmJkpKJTMWySXNfrdd16chxd78zBQCNHE8VlPxwNBEQ1FM4
	 FaaYL6kjM2ba00WpS/Y7NYQ2XLRvTJhs3r+i3FCHVjoildzbVO/lfSNucqcJPThl9h4XY
	 DywnolLNon9WKYASEplsOzd91hAg/N/0oQO/6n4ShXtOyWDB4dmPnP+JtUfxMur1NLSWE
	 NlS5xVkAdDX8aG1slkxZw9NrugCx1S8MV78+n0+t+TKgE+Z6lirUhJzl+3CXCqcE6fw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439260;
	bh=Ffl5mR9BnMzz/NNo1G+8fvxqbiX/vY245eAhhlXn7tU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nIy7R68h+fha5m97CiZzw4GX/uSZpgWq7UMFe+i3/6+xZi4Gt2sA7/S2xdaQFSkYL
	 aL+6HR4q/EtfZg2+NrIFPRT4QTFB/orLolt7u6KDEOlY/igGtHHeDOXxHtXqj0YZ9K
	 6WxkROemoyZrnDIdNXUAVNKSeSOBjWO6F7jYJl9pcwNMxmTB1VKI4ErzXCRrT/9eZ3
	 esVLzuHqYWmJVLog0lE7TSykkohYgwOWXzqnkvUR6p74IPL1HCclRs72nXnrm51umW
	 bSm1eMyn0qDGIV47Q5+rNvA0FOA+0WdVCDeqNPU2aqulOklHLcqftfPcD7yW+teb/H
	 bnsyCenTXgT5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F44C40B03;
	Sat, 31 Oct 2026 09:34:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FFAC156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1D933606A9
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D0MnEkA8B4qd for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:34:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D89F160A88
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439253;
 b=DGQT9rIvYPa78CuL3VaEzEcaw2fJsw1HCtdYHzOBRuySq67064r/tCHUHE1KGuEjH/K5
 jbQTUZ/I024EWMDcq1BMNQxl0WVeSY2fUJhw323LjBHHIIIkkaujascnkNsUUz00/lvkp
 Ev8tkioaBvnvvDNkh7w5rfaeMvfUir1s5MT5JX5+67eRj5zplCALtIV79enKiKjLS+iDw
 Yb86ooxYp90E1uiSIBLIW2tC6JnAjtoFkso92uS4bONhakePmgE7CeaAvKS68VIbKnJRX
 ZgN6o5LPvpV1iNMgDxRg53OCXqIHrs8RHonQSXLLG5vugMBGTP+Qy9g417POQdjo7GQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439253;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Ffl5mR9BnMzz/NNo1G+8fvxqbiX/vY245eAhhlXn7tU=;
 b=p/s2HWdYxGxR6s/OwnKzMJWAcsd8EFnCX2GKIPbRISdUvvPeGH4xjDIwSOEoRGv3qlvV
 0msgjP4yddIMXfQigEDpYgq59Sv/VXcCP2iokQaaVobXTTkxU3qfn8em3V4Qn4hSvb1Bb
 QshXrI68+tP1Ir0+cckQzMxJJtOOcuXiDqyBpW4W/uhIGd1J3Zt09QX5zMz/Yrtbjxc1w
 tZPGZYcrcKyItH1hNBlfI8oO7NblUZyirg6Posw766sjqCTgaxX2qjhBmlbrEobnSVj9j
 liFKm/LpJryQOAuEJDNM0ldOw3kvPEvFAZFKaflFL/TFWU7JKT721aLabUsNSAb9F6g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dmSPXz2P; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=dmSPXz2P
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D89F160A88
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:12 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cd6028ff33fso676930a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:34:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439252; cv=none;
 d=google.com; s=arc-20260327;
 b=JooqN7u5WhFeCWe62ZzygkeyMovsxh5vOEWL0LjdOksJbdarK/F5ZKp+yfjRfbD9Yt
 iYNBUkb3cfSw83iOPLIb6RpFD9zVBmIvBowPfmVieL14VPHfuG3BiQB1MR4PabcZSA4W
 bl4A4lfnXHqFtdwznCDm1+PdgWbdOj1MwqbEqnWGiUdUXOJmq+AGmVsigTdkTmrc6kBG
 Pt5BAycoZRmBBvJENKqlqZQZpmhAnhz8B+9CzjZBaC/rZk1/8IlsND6oihgEhQcUKO8J
 bF1Y1YHEf+Bhb/YvlWcM/iVf63ccZHWtEx1+PnWuyce8QWVggOf5xFi+My+1TMWFxVe0
 ZD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Ffl5mR9BnMzz/NNo1G+8fvxqbiX/vY245eAhhlXn7tU=;
 fh=5Y74j/tCIe6z7Uc3PXknhyiIUPV4Jn2k3O+xgi5ABGA=;
 b=POmztektRKfOrMO5lTRlYQCoK8X/lG3E4AD2mkAywpbLOcb4sRYC6KfnrztSOd3b5P
 8TiVxrORdI9HMQLXFbh6F7lSbY/KtwK7D6VQSJc6J7jGWuF38grCd9jHKWtmimw+uqHe
 p3VLFHkyoBk66XRzMTjNdLch9uTqliHVhunUyLfbUW1Ib1Qqiswcv6MQinCG0ENzg22v
 TJEKFeU42P29nEJoCo0KI1tesLEJStM6PqGaLSOj4YV1e6tjmp36TxLD724rebdoTrym
 Wnjda+VhNv+jF+DCywWts32LS6cL7aG52Hjfp6hxnKK7gNqmszIBQskBNc/fuzsIYnqA
 WZ3w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439252; x=1794044052;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ffl5mR9BnMzz/NNo1G+8fvxqbiX/vY245eAhhlXn7tU=;
 b=dmSPXz2PpYd++X60OGQ3wbu5Yu1GV3KWth4DjPU7KR0gwHiiI+EVD4+83rwZIY10Uu
 2tn02DdykKOsbd92TwuIT/GFsgFSW0VKUIl6v9zOnuUsnh0xo0T+E36lpcapddKlRgeT
 6yIwHJtEDFs5taUJ4+M/cUYtrdC9aw+30IOaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439252; x=1794044052;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ffl5mR9BnMzz/NNo1G+8fvxqbiX/vY245eAhhlXn7tU=;
 b=cQEqGB9PzyhE9YoVdFUREBEVIjcZHtTZLlHppnaQiygqdcyjGbQar7kkx6we3VelDV
 ipAws2C7Y4pQR+aF1Ta7d074+zxlV+6BJGd/6tMS79AFee7Y8EowhKMMyACKQqQGPMiZ
 E2kVLV/CE+MHSG9I+jG1H3pUDe1C0pvaith6wSvDarxpajX78+Z5xnAu/2Qa2F741btU
 Kb/bMWBgleUVeL+N9cJDGHUgYgAMvgvDyld//oxNHkSjZz356+mJ0lL53Pi8zl4qNLTY
 E8jwWySwNJOG/On5TKMZ1YDDUVxQgef7V+GzXNzH14DtxQSMQZ966R8Bli4m6oue1+M9
 LjVA==
X-Forwarded-Encrypted: i=1;
 AKwUvByiW3WwcQ0eScFD66oACrQHvoMtD4THaESO+Qhe58pJkCUeFyS0G0OhfMg8iMAR3yF923Un1sc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKayv9PrD0ARmkpaUiV2vwWceu6EeNhqry1zJN/Jq4R5bBZ2HJJ
 8Wnvl8NCiOXIeobDdIC4FnvN+a2BXNLXdtJMue7VR5lLJx7JsbqFGKz8qJ9v9rC7TEXXdIsn09p
 9QPkW38vLqRMRw1J8YyFXT5gFDZnNmzmXrwiTssp6rEwhlFmte3U=
X-Gm-Gg: AYBFou0INN0/6JUo5M6jszStfPh/nFTB05CEMikx8vXRxu2hDVOBnSx9+A5ntO++IXU
 sIZWccMjsN45POzDjSGI1GZV1NkbsOlrQtjxNLRCJEH5+KBBmDYIUDp37bD6vSZ1MGXMw+eK4Yj
 LjV5xCpAp1x38cym2Di3pMDN6M7ppnpihXA9E7I98HCzlo0tjFyfHdzfuYGLIkt+6F0xZKSJBjC
 sfXD0SD/41Cce1rt4mX2PomwVAQp9JzfTrHQMFcgEuQWnogZr552XzGStLUL1kMuw7CFVBTGg9k
 rf06Xg48v/uuKV6QsOFQH06a0TCdN4OHWb+wd2ica+dDG7Mu2pjmBscu1+1ZMmAjze4iSuCP4px
 oa12jhSc6Wam5Ub298RRQoLHreUt+mnrmB50wplINU4t7MJZ0Eqey1RJeC3kwegessnaS20s=
X-Received: by 2002:a17:90b:4d01:b0:3a7:cffb:8b96 with SMTP id
 98e67ed59e1d1-3ae8970ef3fmr3817671a91.18.1793439251808; Sat, 31 Oct 2026
 02:34:11 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:34:07 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:09:07 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-11-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-11-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:34:07 -0700
X-Gm-Features: AclHuK81wZCwnrypnQY4LtLybKz8C-tv_fzNXereDlKjbS4VserLDSR-thJoeD0
Message-ID: <CAFLszTh7ziUm9GW7FFgPYr9c5y12Ns6WESW_5C5rS_nmghU2eA@mail.gmail.com>
Subject: Re: [PATCH v2 10/37] clk: rockchip: rk3568: Use correct PLL rate for
 CLK_MAC0_2TOP
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3568: Use correct PLL rate for CLK_MAC0_2TOP
>
> Use the PPLL rate instead of HPLL rate when the PPLL is parent of the
> CLK_MAC0_2TOP clock.
>
> Fixes: 4a262feba3a5 ("rockchip: rk3568: add clock driver")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
>  drivers/clk/rockchip/clk_rk3568.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
