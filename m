Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E99FCA9EDE
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 03:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8D414051C;
	Tue, 13 Oct 2026 03:29:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7wUQTrYh0YKW; Tue, 13 Oct 2026 03:29:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3935940545
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862182;
	b=c/Ib6/tsLHSJ9HTZ99+a/FbVv3yevKFGcH3kWia8//NTCCBifF+aVhma5BnVP4WkvyOP
	 8zZz6zYHEGOMy7gd2HnU5NE42SbPMP+qnPhslOafWRo6n0Q/em45/JIElliKvAvGnyaM7
	 smGRF8QTVhcB6KXeIETDLblCnZXCkE2/TJv/kLE644rsFUKx05EjTwKv7Kt1ndC306J5v
	 2NNuUNW77jds0IbhT2mVf6HIDx8tN+jc/Uf01Rz3Gxn/Ue9i3ESWk3gImUbFZ+XyVFYk4
	 YrwfAiRnesvdM4hV/I+8tHCKgFsjgsapk/cZNoxDJvuyaQ/fuVFoHCwEdvJj/8JRTzw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791862182;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Ov5sd7UEltON2XCXxeeAfnk+dnRFhC/otLkRbcqOuwQ=;
	b=DC5+mMjPpwMpsrF9V1RhFDjB0KwPCw0fIx1oVpRrFrVwvgYg7QcjiEuZ2KfpIU5XDKjF
	 xVs6Df0h7wNvAh6msf45+Ftz1AQN2GzPOQmV6E3ZIZ6fH0zBK3jX2dSgOtVMw1VphWEma
	 6x+OP2gm+jLuehjjZSnMnSpIC7vABrLQg1TTNVdsgj09+dRtBTb4LNWcB6bVu92wEVQfL
	 YD4FOacUpfz0jywdDOBeaOGOa8Mgq+yE5UkNNaobtQdjpLxBH1LB2pxaepE/w8S6g6uiX
	 NaJ+Qd/jrBRcp+BC2K1V2DBIAQbyWiV1lTBtcx4CTSNpp5wqW2qfBefaBx9aljaclbw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791862182;
	bh=Ov5sd7UEltON2XCXxeeAfnk+dnRFhC/otLkRbcqOuwQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fLF1zP7vvX1aLArlchw8a4/tO8YokTvElEuUbjlRnD+7u/fwqBnfIiQZQGtvXzwFi
	 3pM3UBfa7t7lkMcNq3GhwWbR5bGkVmrsikbsMmaf3u7Wm4znthyia7dmG6T0OF9yi1
	 bQ+8gKtaMIpV4Q5h9Np7TKRhRQqK3CxCIU2RMZQbG55WzduKhHjD6X8Mz0w1dEwxRb
	 w3P07lLjTs2OLSHcpzP0BOYn/nX/m78Y4thLDiqNR1TblU4kcBSokl5Ttr19gUXm1c
	 ud45LmIO8F+QzbUqqjP8R/zTVfvEo+SwkJcGdggGHDWgNX17ry9Ms1eUzCdk0C6Hi+
	 qE+F5hvvRkaEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3935940545;
	Tue, 13 Oct 2026 03:29:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 19A01362
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0AA4880AE6
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:29:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Izk-OEdkCuxR for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 03:29:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1055080A88
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862180;
 b=alK6vO75/iU+qjLP1QvHAGpm3gVuHqguwjVXLyjQ6ohTo+/fY/LJIgQ4ziv0gbndlUAb
 bGBsaL9O1Sj6iDkACtcIKJC1gPe64oBYxlaZQU9F2wcDVruvEcm+nrkTgd/64SXg1ja4H
 gswSy0zJ43L4uULQvL/rpmxdc90BwvVu/FlRlYMCcddYYhCKb2WO709c09dYzjgASiMk+
 eQoQElqfNMZqVk3Mks02xS/pN6FEZjjwTMhezSepg9/eQXDw4GR7l7xe97uzZkR7bbITH
 Hpnb2PS5sFUpXIxhSTXbDoAgnuiqar+B8577uJx788cv8Vn8tVEI/7wuk102/Vs4EVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791862180;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Ov5sd7UEltON2XCXxeeAfnk+dnRFhC/otLkRbcqOuwQ=;
 b=VtzOKLfxoh19P9rBVcKxn+M8nQLMJxqGd4syNqPfEejQGR/PfQ1KVIAi4A+nQo/d5dCD
 RgOU3UORZs0g8m/z0ECFuS/5bvzJITjVXgsj/yjwcMxAgB8HBcppnGCYnB+McAjw6EUfP
 u8hJVSb5DSoe98/GqEUiPz7r1/CSo3ZEtlR0QikYeg4u451piISls1tc+dJJUJvxBomB6
 fPUlf5CrQ3r8jWrFkfTOi16nCTlUliCUMjI68u7ZIAiEeAeA751QP9KgHMd57ey8tNvoa
 Dsd5D/NG8W/5yOWYcnqS6VX0rLBnQsWY+lez1D2WEf0xNYQB3dIq75rRLouCg0RUg4Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=gLzFoIe9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=gLzFoIe9
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1055080A88
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:29:39 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b1cc392d8bso1675567a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862177; cv=none;
 d=google.com; s=arc-20260327;
 b=P2Eud+1ZDx+mMzWiJYEhHubp6/XA/u58jlwXLgeT0Oq7ct86LwYUJED8PhI4YwHCVl
 2d+yZJDaVzNUc2HpVKZlt7mUf1CngLIctRJr82vP7VT6xmK5WOoDFEO4xamuE/yMCSkH
 eYIyTZYqWOsgb6HJTvCjtzJvkYGEg8IxMXg1V20/uj3Sdt/6W4cXiOX6ZEDY0VIVjSR5
 YfOzkIIHVFKetyKRsclgaBmmgEu4c2lOb4PrOCvrRutPqaf4UTGdEBQbmJS33/CvrA6i
 WGNmNXVnejunzd5HyWy4tX/B3QzB2jgPCJWsxzYvLvvPlNfdgmkNkKekdCKoU03Q4jz7
 P4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ov5sd7UEltON2XCXxeeAfnk+dnRFhC/otLkRbcqOuwQ=;
 fh=KsyWtsRjp4xNsGgkMl6DvvEj5tm+HE5cAVJK/QAJmKM=;
 b=OZtFn8FK18snOf7fhUnYG3CWdipC0yGuELxHErDDVw/WeZqMW/lwLpSl8U7AuuB7wV
 tVbS3NAwjNc+Di4piHkUrQ0i56cFP/8N/UOZ3HVALb4xvHexaXH4Tv8ABSAItln1lTnO
 PZc/PcZ68aYxyId5/BjRvpjqVJ470d3VJT/ayUj4kwtY94h1pLK6LYZbdYgdkGlHsiwt
 6eab12JBkR2TpE+Sn/bETtLOy+zYKfBx1VfrpSBcfdDFDvrQeHyeDg4gZmvcslfKCkHV
 h1WfkKuOzQdc5O6VkbkhXyj6qqpTwIKTUSlaR4xVjIaXcUFuSUG2Co1TAOfccp/tLdz4
 yHjA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791862177; x=1792466977;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ov5sd7UEltON2XCXxeeAfnk+dnRFhC/otLkRbcqOuwQ=;
 b=gLzFoIe9ZhUju+88cdMmy3VJZ3lU/Y4AGu9zzHC3U/IcvG+D+XA8mS/Q+puzxl6QoE
 MBxb754OePDm6aWTFSnP1mU4oMdSwDVmshHU3VtJmD+qIiO0dVCQU7cLUF+OLaxmbT7S
 bE0WW5v6pFQVkauQQyAeIdH7n2aBULRy46ikM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791862177; x=1792466977;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ov5sd7UEltON2XCXxeeAfnk+dnRFhC/otLkRbcqOuwQ=;
 b=R6vEiAzoRMFMHR/2ROgiV/c1kCkzseNbuCtqUk8yt5EheRSk0gcr3qtu0GY+04W9NN
 CPWiXggk6aK8JSYr9gvXcvJmAT9FTvFrtDRS04ybqTyWWcFnGa3vtw7E59mtzydMm4d7
 BNZHAWS8G6Pnk9/BZT+E5rCW2DewmEIfcVKOT3PtxvuOMTcY81o8Lz5g5xW1C7IVbDaH
 Yq60s4eIx8zLq7g5uw0pDBJT+FWlu8zFdRBJpvIWWC2ATI9V8ipOycq6WtFgkZlIetoF
 8BiRM1/Lk+t3P+FrYxGRUkpVDXAUCvs/mGK3JTTA4VRFh94cHe0Rke71Jkpwi3ihF1lO
 +yhg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4LAgsWoegA3pWesyt1xHfFhFD17HX0Audn0jUbOPhuBaDfFUaY45bOnhNzOPvnZ2XTGctx9s=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ2L9EGFRa8yvOlFTixn6edcd5cjtf2shT/TgbskBBVJeBobvKB
 18kDOx6qRZu2YMfIGc4DRSbe5Ksl26pAufqqwdyBcSX13VrMrEBoqCvSk0PeQ7Uc3sE8thDY8jH
 Y9/ENj2ocCxcMEaYCCFDlD+/sdWDmJY3XWo2MIJDC
X-Gm-Gg: AYBFou1zrEf7zTOIP5w5jyzrn5ZdCg9NcA8heLzZTVM/KM9IVU0JSx1XsfLnPAZvK6O
 ob1XinB+0Pult6/sSA89nFlWMaAP5WFUHM1hww0yC6yomooxFXkj+1z9ICp3xBYu7Y+eK70k1ZY
 3XYnVdJR77rKR+kow/RK2mZHcaULMm9GBDc/mXyWODT4PGQhqe2AQql/UUs3JTUIUjKCoEGGpP9
 NTdwLLhOELP4+7UwOFnbrDuepziWg02I7uhYIOo7QyoWxHMevkFrJB+4u/4uwFmUZaG+Kwq9iGz
 BviX0tU+QkrvrlTWEzAetJw3GLVtXvHR1HH3Bvj3EtrgHijHoyWNEteI8a2sNowA7gU=
X-Received: by 2002:a05:6402:46c5:b0:6aa:9fd4:35fb with SMTP id
 4fb4d7f45d1cf-6b17c2a3a96mr7674418a12.8.1791862177462; Mon, 12 Oct 2026
 20:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
 <20261012140048.214059-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261012140048.214059-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Oct 2026 04:29:24 +0100
X-Gm-Features: AclHuK9Enk1cPH-G0431jhOG7sJwzObWyvpg0E85X-2iTH5dV_xuQDuOrQtlEKM
Message-ID: <CAFLszTgOVwBQ3JYeahw8jXw1_+Ng3N-sLCY9ELtpGMJuodXhxg@mail.gmail.com>
Subject: Re: [PATCH 1/9] fs: move struct fstype_info definition to top of file
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Huang Jianan <jnhuang95@gmail.com>, Daniel Munic <v-dmunic@microsoft.com>, 
 Tony Dinh <mibodhi@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Vincent Jardin <vjardin@free.fr>, joaomarcos.costa@bootlin.com, 
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org, 
 linux-erofs@lists.ozlabs.org
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

On 2026-10-12T14:00:39, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> fs: move struct fstype_info definition to top of file
>
> Structure definitions should precede code using them.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> fs/fs.c | 86 ++++++++++++++++++++++++++++++++---------------------------------
>  1 file changed, 43 insertions(+), 43 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
