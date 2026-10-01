Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EEACA5FCF
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 17:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFA2D81010;
	Thu,  1 Oct 2026 17:22:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 75wZP0mS9sG0; Thu,  1 Oct 2026 17:22:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E17F780E85
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790875362;
	b=VkLMBLLTY4Q/5sF0kUynAc97pgz6W705LbR2sEB45rWAJjuxNa+YyuySBnc9Mkhw+VSg
	 nz2pory+JXZPkDZjmaB4SM6aqvFu/yk5jGkJYBuQut4gnpAUA1kJqR8LND+ui7atWe4vL
	 E+qR8+25EE2GIhQELEO9WnteUhcIUv7Ry4WkBDKfXECaxZN5tq0tFfJi/9ABXq4Dds7nx
	 FWwjTDhvnRW8kYAEbRmP86IcvbtOVNXlG5EJvbj/Cu6jMfpvDvIdOaJvDhq0meQiThJKZ
	 qK/QqKl1XoaPTvckMrpHWKd0JreDuKw/e8csQ+lMaO8rmdQyamxLmDYTT4Iqth8yHbQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790875362;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sxuPQV2Rga1ZHsk+xHI0U7zFs6OjjUWeCvadwF1qCp8=;
	b=J7Xa8sKFrv0NYK3PeqAL3eHKbIkgSECWEhniW5A0OZaNy4XWiJjaqVoGTzfoyvtv3TIW
	 QkSLkdORtX5HXGOtBuAujldqnjxfFfm/6ddgHbqRaJ1196zQDZMH+bryRJ4WmLMhvPzgZ
	 tn14bqUO6vBTmchzkjw+SjfVInX1tnM9ih0B4rbRNEQke3bd/6LuqVz0yIQV0xiJ3g5rJ
	 W45FOKgClP3sy2mS2FDEFH/sgfA4at5jVzRDRSr/Xe5Aqp8OywsD85Ob7sYUaSfZs+jDG
	 G9ncA14YbaU74pAbSsebtX0atnSsJjXz80R8nMF198nPzXv1P+um9SxoaVPM52sditg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790875362;
	bh=sxuPQV2Rga1ZHsk+xHI0U7zFs6OjjUWeCvadwF1qCp8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P2HIjwIsYANSAiSCh5NZm+PZ3d2Wp5YdGaVv6Ac8PUehkEmdVvoUBNbyoEWgpjOEb
	 n1CnxXbRhCJZD6nZYDYbvPHzcGp2y5UTUsCL6cgjgl/wdaiCluBluZujhvXHVTIwkJ
	 np8bKm/Kq2wnaGHOZUoyOOROSu2uO5CjtlAbFGxL9IEI+ynHIejPeu8JeDEsjacyfB
	 OPbwLXy8Hd+ElceYurZHWRRgbVvmLuJEYSpAEEZ36gihN43nmHOjzy1x7XX7bNh3C+
	 LiAIqcNfnveso07WpxZjbSH+yhLskCoC5P+17RQx0gnu66Im7ssrknon5CluKp8iMf
	 gavCePrGbcmqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E17F780E85;
	Thu,  1 Oct 2026 17:22:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 99268282
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7F63040098
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:22:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ZR3Nq1rujqw for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 17:22:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A6FE340533
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790875360;
 b=tIJe6+bLFknp64/ETzjqqCoBNfZ+VdhtOGd1feAg3D8tiV68M0i2cd148klvSUMLxhcC
 wl+bnCjuW9s43cZWE/ZGKtHgrqXSm9D/qMxIqWfT86aKeoJCz0CtRuCcbwueLReQcxk8c
 iaWWpF3JTLgDAW8hgr2fC7XaaF7UrYENuztc9EDn64UuB/rx4C1GE/dWJ2Uv66BlYA0d0
 OsWVTED/u22acwt/f7wOfC/6FN7kGLdXBgO2LZqHUGDzwhEdKOCxRSDMOiuETs68sP6a+
 lVl5KuoVgHuXtx44F6F7kMs9NC0V/0kP89p4LqPw4UVY+fLQ0HgHULBWIS7pdUWEFTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790875360;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=sxuPQV2Rga1ZHsk+xHI0U7zFs6OjjUWeCvadwF1qCp8=;
 b=TD18F63AqNFqdJ8iQRUIyFqXs4iE5KAzSg8cf0D69Zg9+1CVS0xJ3f1zsscVu3oh733A
 JSH1VIr2lQ3v6yZm0W+fAG35qQOvQCcEpZuc9kHh4tI+fc0HkIPrXZX3H4bRABeSZT5BK
 euTaygTavU6zekJyaUW/7hkr/RybnAI+ZKEBNbmXbA771OXYHcCFRK8rSzujVWjCBrxHY
 WZnNzbjDuqoXPezqNdYhnr3g3qYjPKGAUbzlUdsBhcho6RpJYEbJdZO+Ul7Dsr9/6rRu0
 3/z4FIb+L3JiR8lZkmG0pTSuQi17Pu84g6lFekf2t0SFGEYQ6C6r/Y69sEyyB8viQtg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=g6AwIs+F; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=g6AwIs+F
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6FE340533
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:22:39 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac6fa788e6so7604768a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 10:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790875357; cv=none;
 d=google.com; s=arc-20260327;
 b=Epoev9uTyHQtsTF9cCsSdQYsH9abd8/dagwQw8sASJhhlFa8m0p0jB+CqMwYmIOwje
 OX1YQSkOaaa1rRXuOgQw/w6MQOj+bEIcSBjtlEKVCPu3S0iKDAquq652N/XvQCM6p4vo
 Kr4bDrsqrqOQypQ/Lv/o9ebCLHVMOHp3hBb1r/WBIW8qWCNUfOJdrzuFqD2KbQwclPmU
 /XlCMC/7hy9ldCVQmDqKjmGNsAp6ztdYqYLJx5xZCCU9GL5Q7Mi+C4doeBb5FqkyFDFI
 6lobzsI8nnLU+in+QBebud7MHVgUbE1UgpZ1PfF88oCfWhUDIWatmO280rznh77GkEIi
 g4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sxuPQV2Rga1ZHsk+xHI0U7zFs6OjjUWeCvadwF1qCp8=;
 fh=D5BJqmpwLQELIfcQv9T0VdgVWUFqFyx3o7YafvxTySA=;
 b=R7jHWJaeWF958FxxfX6+0jTWmPh+E5zIP7Zl9i7yvdjQMYiXFEjERjVYCF9KOD1E2P
 O3yePX6jOgp+b0imIIs/gVT9F19tMyyVlFN/RvdpokgCjHgFZb1ZX/JGXRmyIsd1PpM4
 qngJQpHJhyTiy4/MCoZBparjKH+PfhhQGpLN2OSfW3MDqdo3A8XR/caIZzdiC6KUZEbt
 G7QT+M9ZT5Wv5g/X15/mYUbEit/SshNHdw+15uWzLqNuHwbnfc0+U7F6wxXaJmFvAXFU
 FT3EE31mzE/vmDJTWXLeoJCd1ZKJobo6pD+T9G4OVA6b06kkhmg8xtL+H/gxdDAnI2RA
 CUJQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790875357; x=1791480157;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sxuPQV2Rga1ZHsk+xHI0U7zFs6OjjUWeCvadwF1qCp8=;
 b=g6AwIs+F6R3Rrs+kVdx6VoXqs3WtmcvJ20sl1LJQkzUMyHCCURBAyDZnVJ3lPhvl3K
 T9rSCxn3xgnjqbeTuNPIVQQMi2qOi/eo4HDVMS4X9Ys7CPjEl62TY5XDTEseeu8HyXo5
 fexiEyZ08OEyCux66fBDhTYdvgrMxV0jF5mh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790875357; x=1791480157;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sxuPQV2Rga1ZHsk+xHI0U7zFs6OjjUWeCvadwF1qCp8=;
 b=lsN0mMJiib78bQtrbdoNbJqdVoadZrObFTT1yF1ucsEdsViOiDWun4y0+fKb3ggPhM
 y7t7Mcp5VBT+ubeUukCbpDg/mg8lHlyPdeZ0erq9UHDrvVrTzlHxF5CagPtKBJp+ARh0
 71A8Gd9daiAipEQ2aq6lHWq+EjvKTbhnLAMOtyH7o/wX2CD+BigsiI5TIbLdQeh0vbMf
 nbs0ZZk5hAiAqlQ1OAt3g8l6T0JC4GCN9IZqCnSgtN3OynYnbr0ZUvr2M6omGnbYGnGH
 JdZtjPWpUkvcVpY8u9AO5nKQqo10dWoppVUbQH/Tr9fU0FrMbUlTxv7iMJ1ilFy7TfDK
 xwFw==
X-Gm-Message-State: AFq9FYJybtJuwG4nwyqcphXFavQUMT9B4cw8Zvado1IkR0sNfidcUtzA
 twQ6XTMWS/ZxKpfqoEPje5EjHaclOSn2CJqJsN1UAS222ghNKABqabsNvoGeSYALX0+8dNqLhQ5
 2RqZN7HEeuJsSRu420wTTpAy8GoruFLuLOyhiYAfsS7CoKws0duhzKA==
X-Gm-Gg: AYBFou20oK7VPb7MO/+vO1rtk6nK3/7MpNyBlJpuD4OVYP61d6Ue7AW7fcAzuYFLXGy
 4WdfNv4M/eIi4WhlnP5iTbOf/Ds8v4bvyxAl3kGq12pksKfmjG7/h7HAfTRtRAylTcJA1HJfZJy
 91X14p3EZGuuDZryH90O4DEpZ13Saz79uSDEbuTplaT6PH0GNG3qaO6qJiz+mFY8pYaKDgvQ2Jy
 m2cS5YDMTe6ncGQwerHx5Bxz+LzoQ4qyPEDHwdLzsZZ8gV0wjB5v4Lck2R8iIicq4YrVZa2DYbD
 hqob4+eZLR/l30Am3J52I1YiwxWcF5YCPfK1FGP69n/QOlXJ1aWbv6lv
X-Received: by 2002:a05:6402:42c5:b0:6aa:96b3:9d7b with SMTP id
 4fb4d7f45d1cf-6ae1995325cmr4312102a12.45.1790875357165; Thu, 01 Oct 2026
 10:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
In-Reply-To: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 18:22:25 +0100
X-Gm-Features: AclHuK-tSmmOUnPGc4cOcQyDfNhkFmIZyRbojBcpz8GFtYeFnCh1VkZnvoEK--o
Message-ID: <CAFLszTgB9bqA--8jGzsXoVYtWTAObSeEkb-1wNJKNDUJS9OA4w@mail.gmail.com>
Subject: Re: [RFC,0/4] crypto: add FIPS 204 ML-DSA verification
To: ayoub.zaki@embetrix.com
Cc: u-boot@lists.u-boot-project.org
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

Hi Ayoub,

On 2026-09-18T17:21:23, Ayoub Zaki <ayoub.zaki@embetrix.com> wrote:

> ML-DSA requires SHAKE128 and SHAKE256. The series adds generic one-shot
> and incremental SHAKE interfaces backed by Keccak-f[1600]. This code can
> be used by consumers other than ML-DSA.

The split needs some adjustment so that each patch builds and tests
what it adds. See my comments on patches 1 and 3.

> Feedback is welcome on the public API and Kconfig placement.

For Kconfig, see my comment on patch 2.

On the API, it is hard to judge without a caller. The cover letter
already says FIT will need an incremental transcript over the signed
regions, so the single-contiguous-message API will most likely change
once FIT support lands. Since FIT is the main motivation, I suggest
including at least a minimal FIT crypto_algo hook-up in the series,
even as RFC. That would show the API works with the existing
region-based verify() path and give us a real consumer to test in CI,
not just unit tests. What do you think?

On the mbedTLS discussion with Tom and Ilias: whichever backend we
use, the public header should be independent of the implementation, so
that a later move to mbedTLS / TF-PSA-Crypto does not affect callers.
Please keep that in mind as you shape the API.

You offered a MAINTAINERS entry in your reply to Tom. Please can you
add one in v2 covering lib/crypto/sha3.c, lib/crypto/mldsa.c, the
headers, the tests and the doc? That records who is responsible for
tracking Linux upstream.

Regards,
Simon
