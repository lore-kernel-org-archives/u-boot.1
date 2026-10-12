Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DF4CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 15:44:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14A764064E;
	Mon, 12 Oct 2026 15:44:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EF_mAhB8sN02; Mon, 12 Oct 2026 15:44:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 19AE340624
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791819868;
	b=Hz8Sht8k9O46BTxT2zMsM6UPFwiZTbAybRey8kREs9YZYieQaKjjxNwbohcbqdHbYh7Q
	 yLQ8PAlQTBRs7zLmn+pH0KdMT2FaMKHQN/p0Smza8iHKGYtFnSU36pKzjgF5vP53Qw9sM
	 pykGKpBuYmgG9tEc5lN3XooF9z3WgclmbgycrXeWe+351E56trxZrezR6vhRjgGu3zU4s
	 2P/7H236xTIefMls5vXgN0/qtDAcxcTSDhGg+wTf9lxh/+L+7NagWMBZtAxkVfj+o/fJ6
	 TP9UjZqSmMV6ljeYK6ZuOuieGic0lgh5NlYFVZ3DJIX7YsW+DP78YigjQbEYdZcvmnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791819868;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:Content-Language:Autocrypt:
	 Organization:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=b/CwHOVBkeCOQ01mmPsOnT+9oefBtixE7b9i4h9AB18=;
	b=nuzOlPq1dw4attgOnjX4gJRDfOd5s7kPClGGGdPIxGXA/QsulYQ+wnQNYzFRYylDzHjK
	 JCIEkAu8kb1dAfZb+yBUnXI0EArzJLItjTIgRvx2J7lDbfpHxjb0fdZUIutgTxyC4Ccu0
	 wTTH+VgiejnV1R9RfjH/fNtR3b4qjoEp5PNSN8HdcQmKvUE4l4HaXkuiBu4gbP1LROvlO
	 c8UyPE2ES+2oCbCrQDu2NjUaGF/HqJ4c3aNabDqsxm2bZQfCEaX9DJg3xfygEEcdeA/is
	 Jxh/oufB1gWriME4pK+5zWeq3qORXz8KFF1gTy1j+4fhhT9J8McgCmLpVH80BL0gXow==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791819868;
	bh=b/CwHOVBkeCOQ01mmPsOnT+9oefBtixE7b9i4h9AB18=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=0REwJ20EQjNuybcbJwCswFzY4RVkOnIHDKw74X+nJK6oDhOxmxdztYl1eZo1f1Bt1
	 /OXaW0TUyvMsZlmsDeT+rgz6KmAbt0etQ4Eq2G015GvBxKwu9s8Hc9vqWcYZKRKvpC
	 lcOhBXnjiofB1W11YnbZB4XYgoViHnsVp49f9icYIbtRKF655OR9RcBD+nGDzlm2db
	 Hv53EJJzjAhu2Z2H2dtQrBZx2fc7k+OzO44SdHFUYDm1tr+EroBC9A61NpYwPL7s+u
	 oslAgZoLkiXb7PIQVmg9STPcEGldphtgfD0oMH1EXY/1Kjl2HbEe+8LLnhITX7VoxD
	 hlABPEkmjWr8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19AE340624;
	Mon, 12 Oct 2026 15:44:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F1A69380
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D6E7660672
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:44:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a-aNVBJ9PRPS for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 15:44:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7612C60643
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791819866;
 b=Wd0aw4ijYw5eHcl/v9SmtMKcj1/NjXK9JZtxHFv7kFwJFlpc9Fd6Vl2ZBEQ29H2yeKJ0
 ycx1Tvy5UvPZmj2HYghpkzFsHJuKarTibVNZXervrxAoLlcmRP+qzBcIDpr7SOAqQao4i
 7BBvdVVrcO/7OoROMFqdYo9suZ92jCAeGX4GS7v2/SRyCOtoZuC8Tg1DIp80B10s55nWq
 RSOitIM1mJEUmgYKxu9z99lTlpQAHHhjLvcfm26a39JTqCAc5YyPq18JmVhYEMsjsQ0ka
 /5GPK34NbWcRbarT7IwM1cNmIwg7KaCMU44n8mv8WTZSrBN0FMKRZ8hvtLm8eqjqIFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791819866;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Subject:Reply-To:To:Cc:
 Content-Language:Autocrypt:Organization:Content-Type:
 Content-Transfer-Encoding;
 bh=b/CwHOVBkeCOQ01mmPsOnT+9oefBtixE7b9i4h9AB18=;
 b=cCOvciESDCMEbUj2H6xEY38D4WIXRftDeE1qHMI4P5dH4ZtPkW4UFfTk5fBHfTO+z7ii
 rL2072BJPC2C0IPLMI+YusMQsPE796G7TTJ8dtS7PGITq8g/FaopoqsC5coqo4NYR+QwE
 m9GFUgCuOb4GZ7BH2OYCf7YrYPjNMbyU7RcIdJ89YGsjWD41HHAUm9krdVqKQTuUhW4g9
 B89K1HhvR7aUSfP5D3TsQLR/unCU4bLjBpbb1elxo4s2NpO7i1hlJqJ7kZB1CNHgl3zm8
 9hGYWZVG4fsKb4yRWpbLlubsgjrQ+EQ58J3mN0+nIWwjsTTspRkBoNwpDPY4SaoJ86Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=rqdaRpLP; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=rqdaRpLP
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7612C60643
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:44:24 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48b0946c2c2so1187441f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791819863; x=1792424663;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:organization:autocrypt
 :content-language:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b/CwHOVBkeCOQ01mmPsOnT+9oefBtixE7b9i4h9AB18=;
 b=rqdaRpLPk1jzntOg8Hd3THn/f+g4LiTe8jBJfTh10we5tOYKLTNvOXoHGjzmX5KP4k
 1e3zIXCRepbP3qoibpOEkW5WJMhCqaQNnAgFNrdErKXLTKrYPFI/rAGsPrcOtSdszG4i
 YXOyLdQ2opuGYwgvxfb4ciUJLvvTvzkcrfV2OkLZDxfuFm8NGI4AFfM9A5Udw86EWWxK
 ZTdjSp4vRumNjnYaWBKzjqN7TdXFj/O3AXnorY3XtgO64zB0PwofYnqjvoBGy6psBQZh
 TlpLrpUkbL+dJ0sAYF6q/BYQZVBQCaTYCxDcYaMlEzbO4sIKDhFWNN8RdglfzXyZFz25
 YeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791819863; x=1792424663;
 h=content-transfer-encoding:content-type:organization:autocrypt
 :content-language:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b/CwHOVBkeCOQ01mmPsOnT+9oefBtixE7b9i4h9AB18=;
 b=d4EnIWJJlbpEu2R+IGn0GIaqmxyohJSC7ZnBQmNzsGhA9zf/KORJXnB+kzmwhJ+HjT
 Hly+jV61YoF/bh2iOnyPU5hL5cNdnxh1qsJJ0blhsjigz4w8vVcJXS15nWyTPz3lSJlO
 dlNC6q3Ko2Ks3MTKRZO26bmSltVdpR1tFNkm5B4UDjZsyU1JJrp7nwsjV/949IxAjAVH
 +Wrkyo0Q4GZTh/VTCuDqlkK98iGYKMiXJ76pCo0Dc5LQ5fVOlwEd+b27PLMw+QijrZVI
 bOAScojHZXb3l+DFwX/UcxErr8ztCJH9ZCYWhvIQDCWeZMIVspsKd4JUZmI9Kb2lQrRC
 b1qg==
X-Forwarded-Encrypted: i=1;
 AKwUvByjRfWmJG5tJQIRfbqhP1H0ZVkSuriIlCa0RccUHkmmCSNRO66EkK+N2sZd9vnfvz1iYECgAU4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKFr0Us6Fo71cMGzHTSo4p7IpUeKuVwkp7zpBnr+rJeKo6T3vmj
 TSQ3YMxWqOjy8iGA3ZYlO+BjFx+0lJJU1fm8pTwD9Ns68+E94ELop5/nJeWyIyHuhVk=
X-Gm-Gg: AYBFou0kDYk5Xm8CeHuoxQrwnn7QTvENMoPffCzlvT6twRUiNQ3CokKuORz2Nn/yHG/
 NfaANaf0BW8yA86GS5b0gvgJBpZwA/Yi214HvO/bwsbZat4o275q43TrgFgPhXoqgzfA9StMMsG
 zciL2JA9yEucURC/LbWJtbcQB+YuSrUjHaXrdK/l4sEl4nEdB8oZrd5dDfg3t+2jXaCneDKbOJL
 6o2lJgDAq0EiBkiSx+8GCtgm46EGEa0Mh84OQM3RoLrFJ2q9i9zXzzGLl7fQIQhqtM0wSH7ojLF
 6kYy7lGwJGHHb/5yvH5d/dKk+TDjCm4cmQoyew7yOZgmiUFjiGnMa/+r75cAD/gi780rDkgyweb
 BqnqczIcee3fpUHtFPG3NL/L4BBF3r5x1LAqIt3BaCVPS/s7R9phfP31J/dTZXWXifmY5MAGPGU
 kkcjMiZQ7Ds0COXmJpiSAXalhcGhEFE+t8q3sblzyxCBFlk2wVkoKRX/5u4KxAow+absqxcMppe
 6F5W9cj131FU2SO2v26qBEIpSBhl1NH0hoB
X-Received: by 2002:a05:6000:989:b0:48d:b650:69aa with SMTP id
 ffacd0b85a97d-48dbacf596fmr17396840f8f.50.1791819862371; 
 Mon, 12 Oct 2026 08:44:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:417e:f4c4:5b8:8c48?
 ([2a01:e0a:106d:1080:417e:f4c4:5b8:8c48])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bd777fsm81885f8f.57.2026.10.12.08.44.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 08:44:22 -0700 (PDT)
Message-ID: <eb8bab99-2d96-4089-b2ae-4492e763203d@linaro.org>
Date: Mon, 12 Oct 2026 17:44:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-next-20261012
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Tom,

Here's a set of Amlogic changes which enabled basic Amlogic S4 support for Khadas VIM1S,
plus cleanup & update for Android support.

Thanks,
Neil

The following changes since commit e1dcad5512b81009eaf7e472c20a8a15db8c4a0e:

   Azure: Switch u-boot-test-hooks to git.u-boot-project.org (2026-10-07 19:35:44 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-amlogic.git tags/u-boot-amlogic-next-20261012

for you to fetch changes up to 9c048da44bed99311355450d70840bb0795e21f8:

   meson: Add Khadas VIM1S support (2026-10-08 10:45:27 +0200)

----------------------------------------------------------------
- Support watchdog for S4/T7
- Add S4 support:
  - reset
  - serial
  - clock
  - mmc
  - SoC support
  - Khadas VIM1S
- Remove Android support for SEI510/SEI610
- Fix Android support for Khadas VIM3

----------------------------------------------------------------
Guillaume La Roque (7):
       configs: sei510: drop Android support
       configs: sei610: drop Android support
       configs: remove unused meson64_android.h
       configs: khadas-vim3: drop non-A/B Android defconfigs
       configs: khadas-vim3: enlarge the fastboot buffer
       configs: khadas-vim3: update the Android partition layout
       configs: khadas-vim3: fix the Android DTB index

Sean Anderson (13):
       watchdog: meson_gxbb: Add support for s4/t7 SoCs
       reset: meson: Add s4 support
       serial: meson: Add s4 support
       mmc: meson: Parse devicetree properties
       arm64: meson: Add s4 SoC support
       clk: meson: a1: Eliminate separate id parameter
       clk: meson: a1: Use clk_set_rate from meson_mux_set_rate
       clk: meson: Use soc-specific naming for common functions
       clk: meson: Export a1 functions to common file
       clk: meson: Support fractional fixed-factor clocks
       clk: meson: Support power-of-two dividers
       clk: meson: Add s4 clock driver
       meson: Add Khadas VIM1S support

  MAINTAINERS                                        |   1 -
  .../dts/meson-s4-s905y4-khadas-vim1s-u-boot.dtsi   |   5 +
  arch/arm/include/asm/arch-meson/boot0.h            |  12 +
  arch/arm/mach-meson/Kconfig                        |   7 +
  arch/arm/mach-meson/Makefile                       |   1 +
  arch/arm/mach-meson/board-info.c                   |   2 +
  arch/arm/mach-meson/board-s4.c                     |  50 ++
  board/amlogic/sei510/MAINTAINERS                   |   1 -
  board/amlogic/sei610/MAINTAINERS                   |   1 -
  board/amlogic/vim1s/MAINTAINERS                    |   7 +
  board/amlogic/vim1s/Makefile                       |   1 +
  board/amlogic/vim1s/vim1s.c                        |  26 +
  board/amlogic/vim3/MAINTAINERS                     |   2 -
  configs/khadas-vim1s_defconfig                     |  66 +++
  configs/khadas-vim3_android_ab_defconfig           |   1 +
  configs/khadas-vim3_android_defconfig              | 122 -----
  configs/khadas-vim3l_android_ab_defconfig          |   1 +
  configs/khadas-vim3l_android_defconfig             | 122 -----
  configs/sei510_defconfig                           |  10 -
  configs/sei610_defconfig                           |  10 -
  drivers/clk/meson/Kconfig                          |   8 +
  drivers/clk/meson/Makefile                         |   2 +
  drivers/clk/meson/a1.c                             | 495 +----------------
  drivers/clk/meson/axg-ao.c                         |  12 +-
  drivers/clk/meson/axg.c                            |  16 +-
  drivers/clk/meson/clk_meson.c                      | 376 +++++++++++++
  drivers/clk/meson/clk_meson.h                      | 149 +++++
  drivers/clk/meson/g12a-ao.c                        |  12 +-
  drivers/clk/meson/g12a.c                           |  24 +-
  drivers/clk/meson/gxbb.c                           |  24 +-
  drivers/clk/meson/s4.c                             | 601 +++++++++++++++++++++
  drivers/mmc/meson_gx_mmc.c                         |   3 +
  drivers/reset/reset-meson.c                        |   9 +
  drivers/serial/Kconfig                             |   2 +
  drivers/serial/serial_meson.c                      |   1 +
  drivers/watchdog/meson_gxbb_wdt.c                  |  22 +-
  include/configs/khadas-vim3_android.h              |  36 +-
  include/configs/khadas-vim3l_android.h             |  36 +-
  include/configs/meson64_android.h                  | 279 ----------
  include/configs/sei510.h                           |  30 -
  include/configs/sei610.h                           |  30 -
  41 files changed, 1422 insertions(+), 1193 deletions(-)
  create mode 100644 arch/arm/dts/meson-s4-s905y4-khadas-vim1s-u-boot.dtsi
  create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
  create mode 100644 arch/arm/mach-meson/board-s4.c
  create mode 100644 board/amlogic/vim1s/MAINTAINERS
  create mode 100644 board/amlogic/vim1s/Makefile
  create mode 100644 board/amlogic/vim1s/vim1s.c
  create mode 100644 configs/khadas-vim1s_defconfig
  delete mode 100644 configs/khadas-vim3_android_defconfig
  delete mode 100644 configs/khadas-vim3l_android_defconfig
  create mode 100644 drivers/clk/meson/clk_meson.c
  create mode 100644 drivers/clk/meson/s4.c
  delete mode 100644 include/configs/meson64_android.h
  delete mode 100644 include/configs/sei510.h
  delete mode 100644 include/configs/sei610.h
