Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D3606A334
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p+YyTWhU;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=I9uyt2EH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E88D40603;
	Tue, 24 Nov 2026 13:16:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iR_HW4Q-jkWQ; Tue, 24 Nov 2026 13:16:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DD4CA4064A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795526161;
	b=IVC335vWZf+6OyrllBpE228gXcGc0tZzbZwaug3+qTrLoDWo+5ONex8aCF/rNxWjVgkS
	 FPNQa7v1F1bnPfUD/vq/kx1Tq6QwuzipOYUZQLZ3LVwswienk0eUisRJkmNGXmfWEGq/W
	 aczFgcdWcW4UhgiEB48JRNwMpwno35/j/M6Cjuf3u9KjLsGvqnVgLV099eIXQ6NlWcRjX
	 S38b63iOJNyVYz2fg5FBEAVlCtRun/9Uz2IfIjWfokBffRa0Nbe244Q/cICtFk24AkVSK
	 a+xKBKaGvZFjWUy1pHJrnwJCpM9mb9z2uyTFSs7GUty2QlzNFoLs1W4L2Rj5jE8iJfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795526161;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZG/sa8kRA3AG1FniufvTB2fxPLwbcXaoPdMfnijz8vY=;
	b=rm3X4NOeREmWHpaNn71H9Z3z6WX9Gy6op4TQb7DyP6MXxiKxPqPSKPEHrYFx8l5Dsc7F
	 RsMvF69SLcZOyQnYpMfRp09e6Alj+l1dDiHFRCUaTvpTSo+4M7LuMR9hvArigQO5/tkiG
	 MizursdysPxpQvFq87GawvJEUZ9dLYhE4ZafKPumzp0Vr56eZLwvWWJiNLO+gi3Ef231l
	 jgAPxYJQDDOWN9W3zQnNUgTAToSkpEYmUNOK0Nd7GrpbA4z6MZ6ozSLwxLdtKwlNDNzZ+
	 N313bRS2D7FLHqU5huAbA6EXCodP3COi/If5cqIvnRGt4Pq8T2SL8z00hOZdFdLov4g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795526161;
	bh=ZG/sa8kRA3AG1FniufvTB2fxPLwbcXaoPdMfnijz8vY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p+YyTWhUta0lAAebh4Ka2/E0sSeCHmuRZtEYEGwGWJ2htawwS6HKbBhOcRfsWrudG
	 borfpWd8nEiJrk9OZAKqll0ry3kx7fkM5Su9E0ZEkh7URboZdZJSTlDFBvYoxA1gA3
	 JYfuryCMocLLuvyXd028ptFRuzN6dh6x5B3WBN4fnxv47M8+aIH+m42M5u/tG6zo+/
	 MxHoRtdypWOU+YYGHgm3n5KrDug2pO5RWDyZHr5zQGd0ZNgfBOn6mKFlQooYWsQev9
	 zHWMhVYbFrEUZ4eJKgtNX3IYe5X1Nv74tk5u0dKJIdS80fojl3zVLRENwFL4FL1VpU
	 rRi68pmbjuwOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD4CA4064A;
	Tue, 24 Nov 2026 13:16:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 22737371
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 13:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 145B180FF4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 13:16:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dUq1GY6F9YYM for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 13:15:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2DD1380FF3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=I9uyt2EH
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2DD1380FF3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 13:15:58 +0000 (UTC)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8b0ca1ebc8bso37836257b3.2
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795526157; x=1796130957;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZG/sa8kRA3AG1FniufvTB2fxPLwbcXaoPdMfnijz8vY=;
 b=I9uyt2EHf+Hjk2yt4ei8taJGzZl7HFoYZhcDRufYLXIvnXy4TDkDM076uw5+g7aI+u
 Etw+5CcCMuzOKgP5GW1eqXEwMcld/W9B/77T1P1XdAu7s5fTcR8oBeq+IzbWfVIKCklM
 0tChdbeTf+DiGROeu1WBJr8tlFLtQp//dcFivwFUjlXtiIHWVy7ETLkSv17Jh7f7hkWT
 b9c8zFPJY7AyWFWVtck+CpZFQmkr9nyNe6ecQWQwB1Q24OwJ90+6x9G8NUIO8I71NgTK
 /SsciNP9mwgr0GYldwxan5dcX6jB60MvRpnRtaJRPYAmAnO647Xc8BDYMbcA/3Yhz9Vn
 R4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795526157; x=1796130957;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZG/sa8kRA3AG1FniufvTB2fxPLwbcXaoPdMfnijz8vY=;
 b=hLjnHsQ85R7zvtQfsTeNaAJHfYrT+7t0mhOtU3IujUXoNyX9wrOCyqzPhdxxUXZzWF
 1FCU/sJmks52jhebvqfnqcejAL5jixl2F+AIZDgc6JlW8O0xSnLPPJvUy617goqeejdF
 sacfzQP+b/RGHtbuUD74Fnvfk0jo8qnopRuYFs3z/X8iPlWGJZO9FJoL2VYZiTsYiOQz
 +GseffDIhxbj73VCHUtuW/OWW+fQ/lrJCxi/YWYZQCyDM7tDZ+FVU3pLqfKnpucrwvVl
 yr5ydDVBUlqBVzNOWfDjPaxTbQbInpuDk8COt52d7AKAQURqOCn0tNo7Nrr61YxyWfme
 cl9Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGEDxgnAgVyuNBiuraPnFeanltLy0uIcrI92ESmtsJY1MJnMez9Jw9E7sEOPn1OVESYOyEIWHM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8uGrg9aiSZmT0YfZCuAmUebvQ5FZh2eftbGzh7Zcb8ioEIbM74
 /tlzH/VZfWccam2u3bPgyqcNtgsGNX1hWC3VaOiH4X/u2EsIAizY1JCq7eS6ewicAbeM9lQIvKF
 EQKZxwdh9Wrkx8LG+eWh2UJI4G9loNfWpd3UALK/2wmyniA2MB+yX2Ut1vg==
X-Gm-Gg: AZFdTZcisUejMFVjRdAhN7mFHq1aFFRnlkzshuyCRElbFP3yLa9MQwEov+c+y7R3oc0
 SFSk81d8B3L6lCTSmlKun32bfABekFzjoXg9Ul79Jf5gzmZfNoclePMqKrli/NNWbD4hpxkNcd4
 8JlWOwz8t60WQU5U9D1QjPdzgtWVRdHK5LrCiy1tjaeZ72tSP3ubrrYnlD82GRH5uBq3yMIyi+J
 M0uES1n0DeNhHF7tjPGHayXR1HrFWvSkO9vwUFFMAKzRsPxW3YAcztl8YlQEEapdyQVPzKRYd51
 zZjB4S5a5Cy/Jmq4++QXib1NkcRLXEXWuneE9Jd0qCLcJwTH4oetmCsfl4msmLsnMQI9heb68m1
 O/MiOvZEXQriAo5oOWHScdbbu6SOWztLCwWCULGt4KFBS/rvgsu5bfauawYCoA7/dvQpmCAFhGp
 8fzGlIEnti6MbEk0Km5exeJ4l0OFrDeUuSPYXRRLQy4eoH7Z37o25bjJLtBZCaLdHJnKJN7ETrZ
 fk5W7apI/0WT1sGIB73g6FRe+pq8EKnsBpx9oMGY0t4D1MBUQS2lHSztNMsWrfrPLnCbuVLrzob
 qyWsH75jvZ5kYvxdA1/r8TJP7OlFQFYYD5Q4JOFhmHSLgHTkq3ucfqe02mj/t8+65U9CTYNf93d
 Du0yGpwTdnSlK8rcEBdfYlxDxWMq8u+A2+q49ByVP5aROefOF6V5bWsQatmshBILCQnu8F+riVl
 36XAqfFeSwQCF/MGFdYs3V/PIxVj2ZWH5twEWv6be0hF+pXi2iGHkhmb2pupo7lQm+Yz1O4Zw=
X-Received: by 2002:a05:690e:1508:b0:67d:a57b:aa93 with SMTP id
 956f58d0204a3-67df448b47bmr4748187d50.97.1795526157445; Tue, 24 Nov 2026
 05:15:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103-spl-bloblist-pass-regs-v1-0-bbbbb7e65fdd@baylibre.com>
 <20261103-spl-bloblist-pass-regs-v1-2-bbbbb7e65fdd@baylibre.com>
In-Reply-To: <20261103-spl-bloblist-pass-regs-v1-2-bbbbb7e65fdd@baylibre.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Nov 2026 15:15:18 +0200
X-Gm-Features: Aa3M54oNNDBMIaHU4vpriS7qe6RCNHqKmGhs47VTYXOOlgGO53LCBFiLK8vx81w
Message-ID: <CAC_iWj+VruqvoCCHqtHDZpZdPsMuJGEF+niqv3e_oXBWPN_E_A@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm: add xferlist_to_boot_arg()
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 23:26, David Lechner <dlechner@baylibre.com> wrote:
>
> Add xferlist_to_boot_arg() to fill in the arguments for the first four
> registers of the next stage, so that the bloblist can be passed on with
> the register conventions of the Firmware Handoff spec. It is the
> counterpart of xferlist_from_boot_arg().
>
> Add a weak default in common/bloblist.c, which returns -ENOSYS, and the
> ARM version in arch/arm/lib/xferlist.c, so that other architectures can
> add their own later. The ARM version uses the AArch64 or AArch32 register
> layout from the spec.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  arch/arm/lib/xferlist.c | 23 +++++++++++++++++++++++
>  common/bloblist.c       |  8 ++++++++
>  include/bloblist.h      | 11 +++++++++++
>  3 files changed, 42 insertions(+)
>
> diff --git a/arch/arm/lib/xferlist.c b/arch/arm/lib/xferlist.c
> index 6425936d354..260e7f14dda 100644
> --- a/arch/arm/lib/xferlist.c
> +++ b/arch/arm/lib/xferlist.c
> @@ -21,3 +21,26 @@ int xferlist_from_boot_arg(ulong *addr)
>
>         return 0;
>  }
> +
> +int xferlist_to_boot_arg(ulong *args)
> +{
> +       ulong fdt, sig, xlist;
> +       int ret;
> +
> +       ret = bloblist_get_reg_conv(&fdt, &sig, &xlist);
> +       if (ret)
> +               return ret;
> +
> +       if (IS_ENABLED(CONFIG_ARM64)) {
> +               args[0] = fdt;
> +               args[1] = sig;
> +               args[2] = 0;
> +       } else {
> +               args[0] = 0;
> +               args[1] = sig;
> +               args[2] = fdt;
> +       }
> +       args[3] = xlist;
> +
> +       return 0;
> +}
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 4269a49ef99..d649311ed74 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -578,6 +578,14 @@ int __weak xferlist_from_boot_arg(ulong __always_unused *addr)
>         return -ENOENT;
>  }
>
> +/*
> + * Weak default function for passing the bloblist in the boot args.
> + */
> +int __weak xferlist_to_boot_arg(ulong __always_unused *args)
> +{
> +       return -ENOSYS;
> +}
> +
>  bool bloblist_exists(void)
>  {
>         int ret;
> diff --git a/include/bloblist.h b/include/bloblist.h
> index cdb5764cf55..f143c7cf03c 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -560,4 +560,15 @@ int bloblist_get_reg_conv(ulong *rfdt, ulong *rsig, ulong *xlist);
>   */
>  int xferlist_from_boot_arg(ulong *addr);
>
> +/**
> + * xferlist_to_boot_arg() - Get the boot args for passing on the bloblist
> + *
> + * Fills in the arguments for the first four registers of the next stage
> + * according to the register conventions of the Firmware Handoff spec.
> + *
> + * @args: Returns the four register values, in register order
> + * Return: 0 if OK, -ENOSYS if not supported, else on error
> + */
> +int xferlist_to_boot_arg(ulong *args);
> +
>  #endif /* __BLOBLIST_H */
>
> --
> 2.53.0
>
