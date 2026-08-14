Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C4EC5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 21:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6832780F3A;
	Fri, 14 Aug 2026 21:16:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a_YjxrdXDXau; Fri, 14 Aug 2026 21:16:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB0C180EC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786742216;
	bh=tj23a3zvO+jR/vluDxkeKotIvbHh1xws+Anm1OuJQ8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bTuOMfkX7aatNsGtZv1v68rvomWcSlwHK0ZLUxVU9YEf/Mo1uJX7DQtkq5oNtJF1g
	 RbbylMuxiLfUQSSUFCq5toDlbKVSjDkiPBCOHFJnhiTJK3cQYMspBNIGQl4mpLBnTh
	 MwaV6mRS3Od0vibY88t7soVMbmXQhQyZXiQK3NYgH3HXn8+KFnJ6ZK8b2swGUx98bt
	 FIQMmGxYbsd/N7xSIOF9qTzEyFVKyFDnMGfBfqKQ5VJwiFvvS2oKVvaWXzFVXGcd3z
	 5nETtd9HDZTmofvMchWp6XxX8jdMpR/+0+0dh39PltlI9XVMD4teXYDJiHl2HZ9vrF
	 anYdpZMs5Yp8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB0C180EC6;
	Fri, 14 Aug 2026 21:16:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A4212B2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:16:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1C3B9606E1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:16:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B1WmFKsKegTF for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 21:16:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D7A0560685
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D7A0560685
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lVRPwnZq
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D7A0560685
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:16:53 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a10d02ff43so2613376a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786742211; cv=none;
 d=google.com; s=arc-20260327;
 b=hGBC7Zl1Li+QVsAK7osLHQDB32lVwLoxjhEVDaBuvEQPjvskccsm373pF6zsIglgo9
 T6FcfpYN7CMLSu/3Nn9Of8bcTyK5D+KmNQbHLObyfGIdEzpzcmjW3h/8NArIYrBLkrUh
 jUk7/kTfZROQkvOe0AordM0PlIW0QxfuYNjG03UhDjbzhrishQC85eqwJNr3Ckj4fk63
 qJvrGcwfoQrb+bpXpFVijuN9nZWkpXJao3One8/qqJ+jQESrIDVqIGUjH15FWMfq4Mdv
 J41K+fEv49DsX2fgl5/2ORbzaxqpByTjTFmfWyr3CJMRmHXj0jcIBnJ84OxrPeIK/50k
 UqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tj23a3zvO+jR/vluDxkeKotIvbHh1xws+Anm1OuJQ8k=;
 fh=oKuQMwzzx5PhyxqzXjrO9vkW2cwKpx1pa3eIywtw11c=;
 b=h7xIhUXfEsJbVNxBHmahUtEaTgRTwFrQwCd8v5sVpf+jijztUeGd2G3kiXgi+ABKYY
 BAsi8YMw1YIJ8f68UvsMbhAdLJdw4rEYtVJtVBD+5KHfkqn2Y75CPhtecFTzUWXu14Df
 /DLHA1jXKwnMllRVXWL39C2mZcSAr4Snc8HjJ1anXNI5y1kPn2SvAaLaAfhL+RUe4VIa
 4SjIOKNWDUL15qm5EscdbrUm9NSW1olAparQf/5sHcAQrWNkTPhEeseuY8MQ7XjJ7Ixn
 Qgzet18iwYvQeQJUyOTQXUl1CxOtNDNFpbKseglmkusb5nZZnS783gqYfkfRiB5C4R1y
 nyHw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786742211; x=1787347011;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tj23a3zvO+jR/vluDxkeKotIvbHh1xws+Anm1OuJQ8k=;
 b=lVRPwnZqC1bmdzKk0WqixEvZs3nSIztQEx141IwOHub54EWIu0ESikEJY/jhZKY4GJ
 IPTigfRxl+lRtUMt3Mmf5H3bIZxSyfiHGPPKYhP8Q2QD0Le83eH3WmWGMW6B8ZMRj1Fu
 h5RxsgTIvqvkngBGamIedY6THbMA+yzZlCHK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786742211; x=1787347011;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tj23a3zvO+jR/vluDxkeKotIvbHh1xws+Anm1OuJQ8k=;
 b=RNU7D4RThD008SfKpT/5LB+h4sGDfoW5eiAvczD3y+0J4eS2WYKGJ2P8GhmMhFZX73
 Hx/u953jPqP3X8FUvnjSCaAsxSDCOwP0lmaIJ4g9Qewuo4Aa0hi8k4I0LF7PAkLgJS23
 TmuymioteK2DgUNRATqvxgU2p80aVpUe9o4IUDfXYlLDqdJwhsgNqNhPGmIO+HqcPpL+
 UK4QfNGWXuJfOhnNkHV3iI1JOUykal5viu4taIeqs/VTpOwO48m/C/aA6osMnAh7i3CM
 DZHNf9twZjCq4JzHJVcsdMlANzHe7X04z49VjDasKsCHFvlQBRnEjvJemuyHXJye94wI
 wtvg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqw3oNsCoVSETDMd9n6t0aADg1XwPbuVWTWaF20Ij1OAV88WUXy+rLNDLUiIpA1UNcvTcPWdb4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyMQShk322jMJOCKNPxkVqNM6dIjtiWzOqu03jCR91aJmr2uUXh
 984c4G6fIs3BQuIiMcCo9Q2Eyfu31CrEP7yRbmtjstpUV973VRmr+wzYOSL7gpvohQeQ6VV8toq
 Om85C5ijcTHwgM5keyjhYWVont+SNVyfwem9Dd+cQ
X-Gm-Gg: AR+sD12frTcI5J9GJWh4/JWqySO/Ubv1EWZHRUGPqF//tHoQnxwsuhhdgS9NdpHSVZH
 V5VlCAKT+2PEukn9b6WNFjM41qUPocbfwTehuSg2S0sESCyeQH2CmLbfhwRPOcbOHpp4fXrxzyF
 tfiIXU6IcAe2NtUPNdPC/QiTtXatZ4gHct9G9BN85w3WpzG03BhTIn6VbujolH+ztx+9oD+TFrb
 9SfyaT4MfVczjG1FINwYIs7QszcT31ddJqlabwKkRRsgctihSVYVfOdr2aT4g9vc7MwoovlXHPj
 Mfw3gy6BhvK2Ok5T+AZvoDFr8SCSnxpJPcNS6HNVTPuE97zwA5TzMQ==
X-Received: by 2002:a05:6402:a0d2:b0:6a1:f845:8039 with SMTP id
 4fb4d7f45d1cf-6a38a947f23mr3909125a12.11.1786742211620; Fri, 14 Aug 2026
 14:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <53b3903e-9413-4c96-ab45-4c34a2a6dca9@gmail.com>
 <becb8615-aa14-4dfa-b6eb-958abc535902@gmail.com>
In-Reply-To: <becb8615-aa14-4dfa-b6eb-958abc535902@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Aug 2026 15:16:39 -0600
X-Gm-Features: AUfX_mx8gmqyvvhYZ-QAaQYOYT8B9nlY9PKyRHewRIj7RjG64SN2uauH5wUewZM
Message-ID: <CAFLszTix9GcQqki543r8fiKyqCrjUFrMk2sm91gGLENcWWmYOA@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] rockchip: doc: add back to ROM section
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org, 
 eddie.cai.linux@gmail.com
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 2026-08-13T20:54:05, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: doc: add back to ROM section
>
> Add a back to ROM section to rockchip.rst
> Correct Kconfig text.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> arch/arm/mach-rockchip/Kconfig  | 16 ++++++++--------
>  doc/board/rockchip/rockchip.rst |  7 +++++++
>  2 files changed, 15 insertions(+), 8 deletions(-)

> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> @@ -214,6 +214,13 @@ For SoCs whose TF-A code is not available as open source, use BL31 binary provid
>
>          git clone --depth 1 https://github.com/rockchip-linux/rkbin
>
> +Back to ROM
> +^^^^^^^^^^^
> +
> +Some Rockchip SoCs have the ability to load a second loader binary.
> +If enabled, the TPL/SPL code will return to the boot ROM, which will then
> +load and execute a SPL or U-Boot binary.
> +

This ends up under 'Building', between TF-A and TPL, but it describes
runtime boot flow rather than a build step. Please can you move it to
its own top-level section, or under a 'Boot flow' heading.

With that:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
