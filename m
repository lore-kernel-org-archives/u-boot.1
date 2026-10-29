Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9673460A2634
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0ahJrT18;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=k3aM0gry
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65E7D40763;
	Thu, 29 Oct 2026 08:51:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uxhoRVA8iL6D; Thu, 29 Oct 2026 08:51:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 974EC40754
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793263901;
	b=LxXu1pa3Q/NINl74JKmM9FKGqpJYp8o6rTeeKxQgKunzH+ffI5EE2H6HXQG5q1XYtLm3
	 z0rnvF9xrcPF3kLM3HUTkhdy+H+DSphPFUNxB5xzysvd2VqXxVbXj5scH0pk31WJIxg+K
	 3DFAF2W7u9LHTDXqgY52rr6744IAaoKQ3RB+uzSpLfUtDFzZUhHVUQcHjVuffXA7vEy7+
	 PvzLDri0Yz+xOtvFQpjj7U/iifrqy9u/Ww9XRvyJzjdQLJs3E1ZC6BjCyTb1xTbFsyZQv
	 M/5qtB4JQFQxhNI9mt1MLwnSSGA5uXCnQ0AZUX2neW3oEjUpO3/80F1zZgHm91rYXgg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793263901;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 from:In-Reply-To:References:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gOXPirzfFR5bxSA/s/sn3mSzN0LC82Pd5aNyrChNPcQ=;
	b=lNP/iJ4FhSy24WoJrS365gCQYcdq9fnIP7sUWTFRz6TbVCMebj2SPpAw+m4Kbc+KHFl5
	 xZ56/SNxW+mvYp5rHWnKwiFa5eDRpDW8jTsOo8XHABagT3la9QpJGI0mJ52FZyEHC9gTl
	 Qc7OzQZgTMnd/js1NxLo9OiRy9pgfsjBzyYTvTsMrsKTVQAccPICD/06NN6Uk5+ijxc/Q
	 2bheoFMJYT6If8yUH9SsctggQpbQskEqN+CdR8YopfuKcrnFHR7XLbRNXIq8vdXv3Eq0U
	 IgLAD2E02XiInJVj7WqxZPzsqWWLwA0TOzsI2U/9s6lkMjNy2R6CgrMeiOcRTBUoOUA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793263901;
	bh=gOXPirzfFR5bxSA/s/sn3mSzN0LC82Pd5aNyrChNPcQ=;
	h=from:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0ahJrT185Pb/ad56Q5w1LYfTDZA4KyBoCapMiUN5h7dUDT8KmFKgzCnLpY2bSMl18
	 qFaJHx+aY0MU3BN0Vod2QzyuXtoLX8rUI7uge7grzgWJdzZs+IpzZKneXXCtAe74KH
	 NcZkXiVmzBY+PufPDwz+3DZOSkrAwoKcTAO9n0wKV8JEKN96v4kIaj6zl2hYMMfk22
	 +3faoTyM5VflDN6Y6M3JdFxCxVOt6RAe8BMyZt8rrmv2NK21SIGKRkxFkL1qZQK0nF
	 yyPswUPR4q8OeC0eRRCXP0VmWtCvw1xPLhVdod8kQGsZMZg+56IeOd4jvo3CeZuK2D
	 0zCMNcKvt7HBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 974EC40754;
	Thu, 29 Oct 2026 08:51:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B3F77235
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:51:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 99F8380F6E
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:51:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QN950sbK-eBF for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 08:51:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8AD5E80F6B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793263899;
 b=HswRpxEOQVpMQuem+Mu6jQv/6HxjEz8N7GHzqs0V169AvXQhEtc+y9vlQwyeuRrQQT8W
 8/UMsvgR/7F6tYjRJcNOth2uDeFHUmRc8gTxtnI5jFjovVnh6Y8qvWr9gwTyEI+slCDnX
 ZhwJg5WTCZY50DE8nQ1ChzOiS8ZVfeEEqXajOIKzFTUeCpIumXUMfvgqomXEaZb4XLkd+
 ClR/sKMyZ/pNaj04OuIZQ1E/QpuyYn4uQc4GN4KZx0WTw7B8qAp/xwfPYKPoQE54T/pkh
 McZG3/7TIp3zoXv8PzqHzmX2wtdfxn690RhXc/qOynmnN1h59lDIZk/eFIKVLUfk8fQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793263899;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:from:In-Reply-To:References:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=gOXPirzfFR5bxSA/s/sn3mSzN0LC82Pd5aNyrChNPcQ=;
 b=LHgr8/W2XODO/XjLX4ATLfr/qP6+0y9xss06tuWM4geFfr2ktbx09IIQJL2Yyl6yv9Jc
 /9GnbO5dtcFau+G3EFLZmrEn1jAYz+9Qd1HLhxZWSdeOYoRJg0qFmX+k7pfvdmFYvOCsH
 BXWUwBj3oXlaFMGU+Ss6n+vlshgXAAraL2YsjfYFEYTY464U2/sYipWqhZXEhQNKNUvpC
 9z2VeB1zaJzO0fnmG4Z1VOk9tTPvohdRtJsF/gGW4oHqCe4uwoRYFLjpEW3GPGkFl4ZVI
 GtJrEKXsUCMkkzvKP0JXawB0pmTD/eLGSS5FrWPXhH/gwAmBWqKpmx97s+d9S6iuFzg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=k3aM0gry; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=k3aM0gry
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8AD5E80F6B
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:51:38 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b486e1d02eso2569390a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 01:51:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793263896; cv=none;
 d=google.com; s=arc-20260327;
 b=PghPBJedNlJYWxR/TZhy61ZXGUNWSg7PnrCsPZpySqFsEJHCrFrvEfude6Fled9PfD
 GNFWw4ynKq0LhO3jbI/Ap3GmSHV1T6EO693WQE7WeOvc1bep3S2K8lVh8WhlpKgerNR3
 uDAdKQXXWKnMG0dNeKLcQFFEdVrAqLflL9sTFSMv44/APW/Z5RyYNGAQCbJzC1N5uTbd
 1WAalEIufDbJ2lvwKXR0PNL1/U13Gzp4jfVSQ9/kb2zihZtv2BI6L0G898dp5ewvDbD2
 9EoD9ruBZ9jJSodrLNFoMY64BfEX90w5zV6P1cW/aTgOQhjjSaLNnMv3FvcNU2Ngn/Ux
 sMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=gOXPirzfFR5bxSA/s/sn3mSzN0LC82Pd5aNyrChNPcQ=;
 fh=P+zTqIRcMpo0tFG7TMkkIHv0JvZ0Hs8nALUwFRzWjI8=;
 b=L6EeNwJb97PwSETriQOpsq4wHSsqN+C6saPYXd8/rrb48n23pyX5RLmG4R3penZLxg
 ppjVC127dYXvTOlZFO+oUgcTlAk19esmJBA1NXjteEggh09b09/cuM7xCkOq7PuQjW2q
 SGmss0+GAspzCnRmIhUDBAOVuQ/a5WUvTfts8JuIl6bR2OsDXnJfoEnAgG7tc5Mrvi8P
 j6VCF4fFGhkysBRjKRBwkBFRZIpNQkQNsOIpvYvZxBNzhNofrJ1Jh/NGOMxus8RBG7Ti
 /2jsdT5mHzzSi0DhxEBg4wrNCngE8RcS/RWFv6C1ioI4B9J40+Y9UDl/RHzhq5pAr44Z
 XadA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793263896; x=1793868696;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gOXPirzfFR5bxSA/s/sn3mSzN0LC82Pd5aNyrChNPcQ=;
 b=k3aM0gryrL0xdRZONI82GMGmCRStSSRIKzPZPr8BHsOOyNMhnwrjZ2M83COICl8kzo
 X1GXjwD17F1fna0IKYZG2YVehjAbcAhE40lcP7itL0c3efqfTwPjJrPcVp3Pa/p6v1Xd
 YyN8LDu1s8DFOmSE3/mRHuWQ06Jhcj0nXBdNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793263896; x=1793868696;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gOXPirzfFR5bxSA/s/sn3mSzN0LC82Pd5aNyrChNPcQ=;
 b=TM3fvd630W7PqB+pAGPcvlKnEKo06/tfTYVov9puK7VqwJwzfOYuH4igrxUkFLF2Ng
 1G+N02uswa5tGyo5ur9MXpIdfx7f4U0FQooga6WP7Rrt5JCszfUX7qTSRh6K8fghd5fa
 ycGlKxsSfPi7YeCjyOycdvkDsl5yo388Qk8NJ0xzgvaB6091G9AB67T3jIocUBtblmqs
 siFRD1EgvfDn7hCMZ/YcuzP4ap9TNypHyDnfMSIVpyf6raWDUgWfu3sHe53SYMQTnl9v
 +tRQqZjtaLkbqAPMOehR1ZeycXLWIUdIcErpE4zQ8U658feiqmLy/xEPpTf9ADxQh/o6
 /UJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaJK+GJ3NN7PDgRRVvwYUbmRTjcCzGQdzXf098yaFLy0o3yE1uvnQvC0JRQN7oc427tbkUP60=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJkkAoIq8paEQKS1YngieZb0eSLWGUdKlA2DlXFZ7dkQlfMDOes
 9Orb8Jw8aTZt6mZY+cNTrhDbQ8l410mGEeg7oMbW3qZLoBAOQ4mlhNT5FkyzJZlfbkI2b8BofzO
 ytlFOpB5XF4DLUgQNWS15dsQbbwRUA4bO4dvriqOs
X-Gm-Gg: AYBFou18Wki2mLfagOi0gJnsDJGewbHdNbkQrDYLztiLGOlHCawuiG7xXfDmSg1z/Qp
 7MDwtdoZDMTm3LaFdu7XNZ1LyBHonjkrm21l3Mijevc726b9hJK98nrS6kh5OO+XLDY1eIvvPal
 4ltJlDrJEsp7LOSSXnVQs3m6AlOx07yh8VsAK+islU65u0eUU/zf0mE3js/ZIqsaS/bUN7bos5m
 dLmzh7sHh/5BvWjNGtX5inm/MoF/g+/KOee0jvUa8qzo+JNk9dZa6UNnkWb1rvHHnnAgkaQNCiq
 wvDALl1K9uWSE1icNVcFdhzz0gKGSB9j+TgD1l6ustXJGxoWovfk1I6umNeKkBwijQHA9Rr5O1x
 HG3ox0fgyTUJdAQ1rzlZGiISuvUujK2b/OtY=
X-Received: by 2002:a05:6402:240c:b0:6b3:fc9c:6343 with SMTP id
 4fb4d7f45d1cf-6b49cab943amr3724761a12.0.1793263896306; Thu, 29 Oct 2026
 01:51:36 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 01:51:34 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 01:51:33 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
from: Simon Glass <sjg@chromium.org>
In-Reply-To: <20261026180534.GH646438@bill-the-cat>
References: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
 <20261023-mtk-mt8189-tfa-fdt-v1-1-f86616860bcb@baylibre.com>
 <CAFLszTh8aCgwOdA6v0O7k4-B_7pSBS1HYs6vBqCvwCtDXGn80A@mail.gmail.com>
 <20261026180534.GH646438@bill-the-cat>
Date: Thu, 29 Oct 2026 01:51:34 -0700
X-Gm-Features: AclHuK9-QsrPLCIpKxjNAkut977_gNUmynwP_80_T0LJ5XMRy_92pCAPhBlVqUI
Message-ID: <CAFLszTg3_uuLH1DMOQHT=NDNwXrhTq5n6T2b8pPvT0Bs_fOinQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fdtdec: apply bloblist DT overlays to the built-in
 devicetree
To: Tom Rini <trini@konsulko.com>
Cc: dlechner@baylibre.com, Macpaul Lin <macpaul.lin@mediatek.com>, 
 u-boot@lists.u-boot-project.org, 
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

Tom Rini <trini@konsulko.com> wrote:

> We don't support overlays in SPL at this time (and per the other
> mediatek thread, I have some questions about what handoff we do support
> today), and there's some level of complexity and use-case-understanding
> to do before we could. Lets not start digging in to that just yet.

Yes, you're right. There is no SPL_OF_LIBFDT_OVERLAY, so
CONFIG_IS_ENABLED(OF_LIBFDT_OVERLAY) is already false in xPL and this
path cannot run there. David, please ignore that part of my review.

Regards,
Simon
