Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9E1CC6B1E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 20:19:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5ADA96081A;
	Tue, 13 Oct 2026 20:19:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fKABs_sd9WxX; Tue, 13 Oct 2026 20:19:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 50894607EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791922785;
	b=X0U9831GJ8GqwwGayTjz7eCle04ftsHZgk3Ne7m08EImsXqQMeDTp17SxUrqp4lmIGoN
	 qN5UU0t2L+oiH6ViFw+6Kj1OHO6xDsLgYC0MaLTD2IBQdwDMvfZDLHyqFhAkffsft6ADm
	 qO5m+a3ZpnXUsrN2Je3ZprQHKfVOk9Z+zpOSjTjx/S0+6vkx8zI5BozQ/Y1nwrc1Xs2Vf
	 GtuxES95bcZfOiE9irK/CDGiayXkms3grBT2OxpO/dZBV1iP2BU+jCYELeuz9njLM59gS
	 7Gh/79inZS1yIi+VhuKHBwt+zkyoTYEQKcooDlkiW0hDJ89JFrY0WWpO3GUhKmvCcMg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791922785;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0mLVyNpWig9ZD1JBSegaelwLj2Y2eNb1IiWUw/s4QqY=;
	b=cVfdnm/oe5XPyH/0QaMdlW2VnprcrUO3/HIaBV2DGIcVXnI+4nJjwuB+gRcPU+5zDA8J
	 /FRXdLlQAkPU/+vyp75D6IJr7702o42s2Y42tK8cx6DZI0S6onHOYuHcdPA+pDNb/DK0v
	 VMVHeXTai1VHm6DD5xbwz7N2KSDPNm5Ep+ut4EOyvpYlFQWXdk+0esIj3Saa3jijoM7sE
	 pD1kY7xgpYjByO4Oi6eBeA0uMOZPH9BBGRV2ZwpvbS8I+RLCsRDs+1/FVl5NyidNQO/Vf
	 xQ68k/vjDQ9tM3jkddnwthpgJrXT7HBPXfIkACjUIAv8hzfEVQY+NTRVRkM6q/VA10w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791922785;
	bh=0mLVyNpWig9ZD1JBSegaelwLj2Y2eNb1IiWUw/s4QqY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rAdpN81t2eUTqR5t4EU3Q3F3GZZdOuC3DcrdZjG76UovJChFGso9lilbVGD3r4bt1
	 KNx/TXVN4SZ6EIYpNY/XwW/b/WSxe2bD3POIuhmXtnYgRcjBT6HPCRXa8nIFUvbIPH
	 ObPDqwLKNgEK3BHDtujiu0ffi9pFQsGP5Dpqy/lRxDV322u/1Ki+QoulEYmksVoFg8
	 OVWCj4sZ0I8v7DhGUMZUi9FQG2esCCe6wZ+4BqXvhX4qjE0cD5kHCjHpdCQuxz5jzk
	 Nh04A1ykpnoqAJgTBKHtwHSvrLCTlW7mKhnzujFH5Y4AQedN9CzlZk3AqaRboTpZHx
	 kPPSYephrT5NA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50894607EF;
	Tue, 13 Oct 2026 20:19:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E65C743F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:19:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C8F33402AA
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:19:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c2XCPO4RPAkO for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 20:19:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1E3A3402DA
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::233"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791922783;
 b=kJZVZIvfHlvs2QnXs0d8OesFdM7hNnb8UiE7aZC4Xppn5R67t/zDxsWo+k8e+NuG0EMj
 +PEOjkm/J0gz3iLPoZlwefBnDqdsieFgHlljZrqgMO5mX7hCW0yhcnYYKOtYNhCn/HKRN
 B2vGKJYlHrYejoKChYRwC6ffO3RB99G4UoCJBtbGByU73jGD0hdgUzkZfLpxuV1lu0b1w
 PCTQ+L6JALkn88toFS/j4Igwl591F+FKGy9ZmE2QgSZsQVnrhd8nchlvTNuTGR7Bh5IAu
 PZMFXtFd7/USXZ6yFICkETv8XzPoppNn39AcOpwDwQyrNJ4Qx+wh+mYHSZdzSSaCG0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791922783;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=0mLVyNpWig9ZD1JBSegaelwLj2Y2eNb1IiWUw/s4QqY=;
 b=q8edqm45TL1HlL7/K00n7FjSU5SO5BBpYnlULi4+UICp5Fmp+jmHyw9lakgHFCCZ6nHc
 h/nNHvhy0UzyYQ2Kwpky5efPx0mCrvhizrp21eBMGQr9JMZd5OTeposXP+iK6bf6YFsTz
 iswPH3iLhLk4R2rHdyi328RHxwVBdBZugmahQXqIyiYMimeBAO5H7M8PmYwj8ksNTCcZ+
 5C0McdDg1twsjrpiFTvJbNoYsfMxcCfUFfBKF6zSrAbjc0Oya+L57F/W3J6mAdY0bpibD
 YSfZhqZzKc51wEfhf8g6baXKrvI2RcZ1fNGrSINwhlEVji20eMCeE4qAV8NVLnYh0jw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OgMO230t; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::233"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OgMO230t
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E3A3402DA
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:19:42 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4ed6d69bdfaso1769743b6e.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791922781; x=1792527581;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0mLVyNpWig9ZD1JBSegaelwLj2Y2eNb1IiWUw/s4QqY=;
 b=OgMO230tBIP5ioYNqsecawryIsp5NcQQE78qHOizzY0tIjhg+EJS9B2dpnQUjGW/fh
 uUA8O65utuIyJgqCO5DELcrLoXe8H+LlNtFOQyLztdh+YYTgxr9rjVhUs1IHQYeAzrfJ
 OyEFd76SxbakfycZEC3d/dcMjFs5bWKlmENpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791922781; x=1792527581;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0mLVyNpWig9ZD1JBSegaelwLj2Y2eNb1IiWUw/s4QqY=;
 b=PfyfVXO7/bghIR5MIGufmhyAtVDNtDVoV3BM1Q84KM58G+9q+12g9ifPj6RvQfMTfQ
 TjNgyvQ6q5uv8ftfNO9Q7d+9jVwN+9jkQB814MONQSNgSdd8hJMuDbe3lcikavnQE+HI
 1q0zU99e7kUEOSqt1x+PvnLypmrN1lMjJAmmOmJ0gxo2DgJ1NIBuX8/ydUYC11Brq4H1
 qGtwiubWkxvvcEn8xm3nU0ABVCR2ioBP0ViR3iymQKKHrWXERPhI3uZKvR6KHVw4fCwX
 J9GpvV+UI3833xrm23q1+Gul2JIvV+Bxg4lEIgJG6G8JER8gshUdf4soFu5kkYNC4z9j
 RFTA==
X-Gm-Message-State: AFq9FYLviDrrTZZK/xTdvQPTHtSaBa8PAdVzQp8ZwslwF/p8YxQmQc7I
 9VBgmTGfsy+Id9IH/VNxuas4wdYna5B04eS/fQn+GzEwBq8uOwHxkd7ifp6CC0XGsPc=
X-Gm-Gg: AYBFou1St428xxdpDWuPwiydVBRRRlyEw28Q44h3CFZmMwYefs66UudsqgYgDWg+2v6
 1Ns0nwZj89Do80Wehsz2Hae9xB1dTQbiw6Rmr7r2mXpCdWKlDSerWeaCyk7hBqW4pQnBYtpnhrt
 Aig0sLYph/HA/1JLPZKlXzfOlAhM3YYFnhC3iTNRYx/bPIJAwMGPkvGPa33jZNh/V7g1PZ7xgyr
 EGQpCH7H1n1AnnBpq+F2XHTrCKhu+Y8riKutPvgOiIKBDykRUhPDfQRevn4hOgQoADIUj63Astj
 Ic0pm9suuIXDH0GspvcP1IfKXKuw8epXvsVARFYjrbGeq8gWec/Pwtd0LYfI/JUuk6DBz5k2ubP
 3HSYSkVkwkYxaiUgs8XYA6JKM1K4wrtYyLgtfwvp1Zev7MvYooFm3jBoe3FERJN+Eh2aw6jd+pL
 m3yI5yhBDVWYGXc0gNqm2gxga2Wz6dXI3tj3+awL+klF/2h0Z5+6PJoO+uVDDLaJlTdsJB1Zf34
 qFUD1PY9/JByxATqt8HbHZAJlfxQ8GkP4fdNZLciii2fgaH3IKPUTvJJVo+voQOYQ+q8D+iu8yM
 f0LzD/JJ3+5ErSvvVg==
X-Received: by 2002:a05:6808:13c4:b0:4b3:8d45:aa2b with SMTP id
 5614622812f47-50c4e67c83amr13210567b6e.16.1791922781588; 
 Tue, 13 Oct 2026 13:19:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c1c120ae6sm15016505b6e.17.2026.10.13.13.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 13:19:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Lee Yongjun <jun85566@gmail.com>
Cc: ilias.apalodimas@linaro.org
In-Reply-To: <20260929020333.123572-1-jun85566@gmail.com>
References: <20260929020333.123572-1-jun85566@gmail.com>
Subject: Re: [PATCH] arm: arch_timer: prevent recursive function tracing
Message-Id: <179192277984.4115168.1574103490927637889.b4-ty@konsulko.com>
Date: Tue, 13 Oct 2026 14:19:39 -0600
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

On Tue, 29 Sep 2026 11:03:33 +0900, Lee Yongjun wrote:

> Function tracing uses timer_get_us() to obtain timestamps for trace
> records. On ARMv7 systems using the architectural timer, the
> timer_get_us() call path reaches get_ticks() and get_tbclk().
> 
> When built with FTRACE=1, both functions are instrumented with
> __cyg_profile_func_enter() and __cyg_profile_func_exit(). This causes
> the tracing code to be re-entered while obtaining a timestamp and
> results in:
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] arm: arch_timer: prevent recursive function tracing
      commit: 7b1b8fc581a9d4907968cdbf8fb6296f616d56f0
-- 
Tom


