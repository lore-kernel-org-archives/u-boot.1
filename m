Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9DEC98338
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 16:46:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBD5D406B3;
	Sun, 27 Sep 2026 16:46:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ev4UDwhPJ18; Sun, 27 Sep 2026 16:46:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 36DB9406BC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790527592;
	b=ggA/B2Q6FCHoIGJzJXBUZ/9FcP1dXS4c8vg0UMIVXXYoSyImqoeSjkz19dtExmZgh6KR
	 C5apKzeVo/SGM4gZLipDJymJZ3mh/3AaWS2Jjn34cZbves+gaL6RF/ZncgFA/nslawXsF
	 bYaXR3X9KyEpKqpPrnHllySrUPXDBtCCLMHhjdcSEg4/oxLIkJkTGPKJOaD2sl8TLUIrn
	 I8m2YoVshMP+kYEJR/mQFYrLb1XtGfCqIWQW2cc0UDalm3ZpWp+UyLVxmFRQgUM6OhumT
	 /ocZGe4HxbrJxwQKGLn3XoiBDj6R6BXzM+uOmxzSMq/yNHH9YWj+T3pxWi1KKHQaJ7g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790527592;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CzOk47k5+xjYP8202i+fwpLXY7a6n0uG08r5wviTnao=;
	b=jYfzd7Y1IYrNRHvUUJmyt/JxZrJ56JxVOBN/eZeqKJaLYMQ50FEdEzu7SwUllZdxWekJ
	 tQGTmuZcsZ2oud63QH4y05hMVzIzxFTKn+c+aU80a9+L/YmqXqOTEUjnKHK7TjTSr882u
	 L4btzGACEAgUM/CjNkfOLJF3ireGYkFP2zuqfwjSKk/3r4mtzmEoAoBF8kccAFfDUN86I
	 NTbhY3G8WZm6qdxFl2za9OnZVH13MHOtcotmpT3XkOXa3XB1+TYXBYgwKl+NcXKiftjk0
	 D2Tgh6QQKjfl6IYwXk7y9DuoUMkbuhryV0dx7XMRBthqijKTg+dz1Q3cLI/5GjOhZ3A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790527592;
	bh=CzOk47k5+xjYP8202i+fwpLXY7a6n0uG08r5wviTnao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a4DzIULKiOTgkaegVpsOKHdCVvVFAQjZHmUIzo8FytO+j8FNoSOy9xRtg29kGuvvv
	 bH8EF5X/Rv8gv0fQJmypr1TRhAUf1IdfLtJibaUp/JWnoFalx4Op57KQG15q1YANTZ
	 gVLlleaZWrxA6ouQfe8/G5H6c9JIg67ByCrXSg5Dm/e8jiUii/vj9iJbbWRvf0/Nh+
	 4X278WCYY2wp/GGkuwlpPBv+3fzDUel45MU7XuQwOfWFrLDFtco06pksiC9SgU7fJw
	 VGMatqYkfe2I4Nm2C8CC0RTxa2ks7jS3oD3ThQJuVZGJkvQl2rOMv3ahwMro/ja2q3
	 zXutvfxISasRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36DB9406BC;
	Sun, 27 Sep 2026 16:46:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E9A13D8
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:46:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 10A8C80E97
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:46:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Mygf0laLnJv for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 16:46:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 322EA80E09
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790527589;
 b=YEhNgTGr9Cg0mVMPo8OhI5ULWyLD8dsS6zTTpGAsST9bsIRPtlafaXCetW/d2xLL8Gtk
 B+I4BX2CL6i6eXzKminngoOdADXO/l8sWU6YHsrOqxxpco+lNFcoeLAtmymwkUejMIKPZ
 ZG8wZgXEXTeIOevwMZBh1IpA3m23n8zz3qsvmIYDXNwaSjgG8hsxQmRRYlnR+dYoVeRSf
 V2RVSNHkUHlhDv3LX8SsMpQnQ81mhWL5ffoqhvUQ45QdBHWWrfkklc5IbnfeQ7f/MKONo
 U3sK5yZYyzksK7tsbT+kxwp8TXEYTsL5Qkjrc2W9Gtv61qWXptEyB5GwcVTlFbbbV1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790527589;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=CzOk47k5+xjYP8202i+fwpLXY7a6n0uG08r5wviTnao=;
 b=IP3tLqcXtr68GosGw4iPNa7lvuI06kMMo9AOm1+TamGg76W2zNHfhA9bxpXG7DK4RkCh
 aTrCiIdpFkVyn57WZlLU1ATDhRLO8YVu5A/4Vwwd2SWYaHnktzWXH3bm+p+eIFwxTZzOY
 imPo0yCFLkXiSpKIB/m7JddcPDNt/YEXNfQv9IVlooS3FvdK3Ollq+q7x2pRm9BZe4jg9
 CISux9oXJL61Dnpsuss4JmdzfVq+dgasU3XfA1q9nvYrTMplQKOHYCBAV0dmxOqStnK+Z
 iKUUcj83nImPW+hGGhsyF9nfXFtY4X1PqZS90IIvvdl1fHqVlw0U2599dFqRz6Y3uSQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=StMhKTc0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=StMhKTc0
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 322EA80E09
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:46:28 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6aaf10bf094so2615549a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 09:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790527587; cv=none;
 d=google.com; s=arc-20260327;
 b=PsmlF8ZOn5zclmOvyuIZxWs2qUgctwAmWOWsCRWhy4TXZSnY4hD7VQQHUZxWpBR7qc
 WEEszACgULIj1vDU1yDGwe/RSQZm01ew9vYNh07ci+ebR6qrxi9wZtw5JrEdI9wTi73+
 70q6TaHE05GjiBy3H4TWM/H4SLM08e6ilo7yoORgoozLDb255kVP6ML8s75xkz6WCr8A
 Bid5ddtpUG6Y+D7CaWHKgl/63bSmU3oRTA6hh0+cMQj3xaRJP9obevvE/sYd17oZjBm4
 ctJOKxpp2VDMQ6hMOPf+JJIVVSvxtIpw/1mAv2nrR+HJ5WndbcallR7m5N17n+JicY1Y
 76rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CzOk47k5+xjYP8202i+fwpLXY7a6n0uG08r5wviTnao=;
 fh=o9oLmc4WpUnZo9TiIT+Y/xh2JVtZ16Yb+DyjmmCPICM=;
 b=B/x/afDkhVKI+t4ZkfVj31+ShkonMXicng5ALrplFyrvoYp9d+Q4ayeQ7GLS9Ob6HH
 LERN2Kd94S3lk7VYM4Myb16Df8zIy5nuYNoN3FT6HVSiNXy9pEUWKEMSSd+TUi3sKYbl
 pNMPiFlDUlP/j5iwHL/5GYTp+tDvB3G3rltROKg6BLtaW0kaQjMxkofdZ3tYfw0HVxNY
 M5nFlfgF8Kl9FDe2wMT6VW7qeo0zEv1qGChFHzMBNgB5kUuECgHLAlzWjmaCzJ2EmHH5
 STUGW37OAhlu5J64xb7KyW6PajHeo2fgtL9XCVAPKxz1AR6rrWd/VgkxRXSDNxUm7bNi
 ANyQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790527587; x=1791132387;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CzOk47k5+xjYP8202i+fwpLXY7a6n0uG08r5wviTnao=;
 b=StMhKTc0UWYKyf5TAjAE7qG5N0De1iH2kqZFi3aN3nUVzTiBGg7n+rLxkIcNhHnceM
 Vso9hI0s6WgXNcSxZi0eVfsiEcMa36lEY+MyUxmOZJ75aowpMBdZViH20Rn8QHldjJUJ
 x4zGg9Fbpjb01HYqrB3UhTL8L3t+iNFP0+VaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790527587; x=1791132387;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CzOk47k5+xjYP8202i+fwpLXY7a6n0uG08r5wviTnao=;
 b=AzeUjKh3nZ7TWIgc+Psdki8PXxhsP+P2sz+bWm4Ma4/OKdWw00HDQlZG/4F3CEW1xe
 7PdIMR6CAUxUTEyGRhzaGLJA6eH6QSmwiiFCXHwybuNlG9VY9yC2sDPAk/Xc1ggf4j6z
 JlyoOtLZFS6UsImaA4wkRMRWGgWgJz4IHHXPT58olJwJaPFgsj63nD4K50ryENWA/e8/
 6LR391twlaMPpHYM6h/XmMneosMl0mpsTSOttPooQtXCNWFedh1cX9bMgmQYklRb+e2A
 TVQ0uxIO8C+SZrtZYcs6oYAtd3qEsUbvVfkolf75S6Q8p5LNt7btPgtAYUr5gn9fI67M
 OT8w==
X-Gm-Message-State: AFq9FYLtNHbUHfRwP6sQjFSMqpJJtjCM6Nryk9mivNdRyaTcbkR+Mt84
 w47N0lcHgjpVcEqtbLH0I24TZjvu7B3MyqnoZg98ZJHyNQ0elq1L+WKxsCr6nyvac/zFW5vDbR5
 osThi9oyp9kUDZhF5/ntFq14VMYGujOU3bR39iSlp
X-Gm-Gg: AYBFou2Ay2+iq7R/vlsYlEJv/XRSOL1l8/EQXLWRn2/Z6To+9fXPF8xCwfDHhgJl7fF
 wOJtYRYJhfqdcLoi94YvNhgGTkG++kuQ0gOvvZt2cho5Qbf/61Z4F8HCGh7s55jgAd0JjO2JBIj
 oiv+mRyZ+TVjGIX8ZNYs/+xbHP8eE9UswDklNJTtG/TY9rTgXJvz3nRTE3bPj+ljhfl25bBdD/7
 yZperE6zMaUyr3FrZEWiBr9qfAOe0ZLuiBH4S1AlMfI7GOTzjStfFPIBDFeGKxR69x5YVG7JqP0
 9yC/NMRXTsMhR4NI+le6WPCTMGbCevmeNiUJofQfyKNmk2HAs1nllg==
X-Received: by 2002:a05:6402:3808:b0:6ac:7d58:dbd3 with SMTP id
 4fb4d7f45d1cf-6ac7d58e155mr473138a12.22.1790527586839; Sun, 27 Sep 2026
 09:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260923154610.339153-1-aristo.chen@canonical.com>
 <20260924055459.125648-1-aristo.chen@canonical.com>
 <20260924055459.125648-5-aristo.chen@canonical.com>
In-Reply-To: <20260924055459.125648-5-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 10:45:59 -0600
X-Gm-Features: AclHuK8clm3zvar4YPAH4g65y29CrpaNrzzR5nuGbVR7wNM9bgLsUawCacgihJU
Message-ID: <CAFLszTjC7d5r0UU_B4Cmw0qxUVcyKa2Hw+L0PhqF9Q8HyAZKhw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] spl: fit: use constants for FIT property names
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org, 
 quentin.schulz@cherry.de, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>
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

On 2026-09-24T05:54:48, Aristo Chen <aristo.chen@canonical.com> wrote:
> spl: fit: use constants for FIT property names
>
> spl_fit.c mostly uses the property name constants from include/image.h,
> including FIT_LOADABLE_PROP in spl_load_fit_image(), but still spells
> out a few names as literals:
>
> - "loadables" in spl_fit_record_loadable() and spl_load_simple_fit();
>   use FIT_LOADABLE_PROP.
> - "fpga" in spl_fit_load_fpga(); use FIT_FPGA_PROP.
> - "compatible" of the FPGA image node in spl_fit_upload_fpga(); use
>   FIT_COMPAT_PROP, as boot_get_fpga() does in U-Boot proper.
>
> No functional change.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> common/spl/spl_fit.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
