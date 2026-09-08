Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FD8C79F99
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 14:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40C2A606E8;
	Tue,  8 Sep 2026 14:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6nfw5DHNLIZR; Tue,  8 Sep 2026 14:12:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 31B0A6070D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788876755;
	b=ph8BL/VaLfs8DTCJK5GPCoHyGW4xo9BwPmt+8NhJ31Z/uJGz/mXCGvIn8T5Z3rBKGza7
	 1ThuKX38TYjl5RqjOFl4rXzpvMtCANRLkmpmd1rcsjqp9qsnya84bC07dU/+0gFMZwsOC
	 JE8VnOJ3DnlJslpqIIHGF9cyP8RSTMek8fFcdAcNhBXWYU2+CvPAeNuzKNrVYvv5YD2DV
	 HyOafd0KdOqU+IpJ18qRs/pTVpabe3zbLPNcuRjDpxty3mEibCRXt2GONDbWxozct2kG6
	 RibSguvwSe6nSRZVEJ9QiJDzfTU9HbSyX6dd4hPK8M3kKRSqVa+DHrO3qaMvya3mAoA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788876755;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8xELttOT+vryfBH+zaDHqX5qd4D3oU7/ptja1NIt6+M=;
	b=HC9x0vfeLIW/ghGOSbzMmBn5WuzHVl0dv8Ftp6tz/9a4/7+rLt0dUmzdz4UxCYtcOtOs
	 ZQxO6TUXiC5GmJ89rdyI5DWH7bGcpW8BuUddlVGeQfdx+u0/O50zH1gTCOvgw+1XBKIAJ
	 AA8KaJ1FQn5nT72hTdi7Q6AbunKFtLu8JxUgAvD1iyBrKIENkHQPfn48OHAd/w5um+wIk
	 7IV6qH0r3FbL24ZYnbzfZ4UBon4en+D1OVaubFarECem2PWVaID77Ko2+xErzF0g8YhJQ
	 CGAc50ausgv67zU0//1CA991XuWlJtvRWtBMizO5ZROZNcI1uVbMFGQMXMKnpsut7cw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788876755;
	bh=8xELttOT+vryfBH+zaDHqX5qd4D3oU7/ptja1NIt6+M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TN97PDmOFGUnIKkd89o19VHFLaVN+tF7vOJPaS8XLS9Nl4IgzhSPgH7Pcgalex1QK
	 jakiNVTi/fpGQ55JYhd8CjX5vSfN48afHKwapUw4NnMLi6LfZ/3UBIwqKXj3DPSgAb
	 FMX02KHcRcDt+4P++h3KMWxkH26Ybunp6odDVioZV6r2tW28Kd3sRM2hg07WSNa7Sg
	 +se5KWaZTxYIV0vC0Qo74EruTC7cqnJZ9xQZzr/7oS5Y+KUToT9OFSiU984NvtmDBA
	 r+QyOtxTbXo372kwk76Cngct8QzEFO8yM0+mhqhuQPqPLdbRp9N+if3jFoScR5hyZ9
	 eIMlQWcwOLkEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31B0A6070D;
	Tue,  8 Sep 2026 14:12:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BBC572C
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 14:12:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F19BD40160
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 14:12:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EWXTGXe0WsJc for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 14:12:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6955040079
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1129"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788876752;
 b=slb232P15jvg1jJhUbQBTSCEJE831rpFfWOZ2NkGzTLqnaw20ttOOv338pYxf2fOaJc0
 c9jtx2JwFCR10iSjt6h1cEi1GioFPGeXYToggEyn8RsAaundO4+oGCYsaiuvUU+gQJ6JR
 4kIQ3h0WWTMonvh9xs6t1veU+yGyrTtEGjCCRcU0bK9hnYEZD4wBKcSzoEw9HHlzPGZRA
 wVQGICckyZD7XkpEibKDFmedwbxrszZKgW4YSVKBzn46oEVXDlxLsZDDZK/R6Dga71zwt
 HR7StrTcLKhuEwjcRFSJDjR3Q7DnxhSYqSBVRHhly99CUyPgiG09H2b+uHyHi7AqsVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788876752;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=8xELttOT+vryfBH+zaDHqX5qd4D3oU7/ptja1NIt6+M=;
 b=g2W1GIW/WxmnUatYi2X734DF+Y2xk4ss6VhnMNFmRRa+cYae84+QcnUW+5dbUL5nmCeo
 lE3WPyB4njJ7SN57l8luEWBzoJj/AKQc2ZKg0hBS/jhk91DIZh+xrcpzkyg6001hirDij
 jeRhyIkuT6LOPFa/9hhwKhT1EucwDDOXHrgvwXD8ZMIXxQC6jfDurmVBgXlctiU6oEgP0
 GPZaCycdkDu5YOcAMrQ/2psWLweTSbocCFBL2Cik4soMQ6L6EZRTjJuhWNP10FxZU/D8W
 RlEllBWRtV9VFs6Qb7cKpzEqL4p9OB6cbi2UmUC5w42nV2p00xlH5ZWpONCKlMC4YjA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=c90YY7aK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=c90YY7aK
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6955040079
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 14:12:31 +0000 (UTC)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-861feb6d61bso41624567b3.2
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 07:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788876751; cv=none;
 d=google.com; s=arc-20260327;
 b=Et1gg5KQTA3wb4kn3MfVGlw7q60Ov7Lu5ViAnXVEwOkb4VDvs9B+ErstnI6FrHBfkF
 PHOf4i8o1e73GREyEFCF4BL2X8WIKVomIdYR9tk6JmhZ8g5OkLK00H+HGDLWhqdbBZG5
 mjqpjFsrunmq63FbvN3ktnCO+7nxFSTMvKz9sXsauk1Us03V6Xibaoo4fPR4EzAjjYL0
 KluhdGdEjJIUWwHFXl7xtCGArUXY/uuYn+FcMCEiMLSsrn7MCWSUz5bzi2/tiDXNAAVs
 tPblTFMWu8KX3zjOyOTiqkl/5agj5sQU92Dy7Lr0s6+WcVVUWlmLEbLGKAL21Q+ZPKe9
 /IbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8xELttOT+vryfBH+zaDHqX5qd4D3oU7/ptja1NIt6+M=;
 fh=1ggRB3qRET86tU1nL08ueki8Lx6BIVnat9+e5lEUBPk=;
 b=NAHehB2x4G1YhnFczgoXit9fALyc4TCfkFKJZr5ki7XDmsLSU8fHy4ds6njLRqzhqi
 etEGVxC4x/W+QxQJd7zEF0l7zpEDcy38goF9ZdHv38a8JKgyFciwBk3Rmb7VQA8p1FO4
 SvUT/AxweNQeep5nR9Ryyz3Fl+IRO4W2aJf3ify+0cPuzkNg1x+gqxuM0NtCRy5J0Bgo
 npJ0rmnDPJo7+/Aly4Q++xopwEZu1hPgt1Oss9VPbh5D9JqrEukkrw8vlkoEWqCdP+Hz
 wjRIFP03wii3Thgjx9OsO2G5j/ABgxBMeAEbV1ZrrMQ84dJcddSLTBhKYhDfeTO3W6mv
 aAng==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788876751; x=1789481551;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8xELttOT+vryfBH+zaDHqX5qd4D3oU7/ptja1NIt6+M=;
 b=c90YY7aKeMyJEoTQdrCkwF2PZ81fOpwLZz7ggjS9nEovDl3G/s7TY59k1GuVU2pSre
 CWraK43iIP6gqXLtFOJa2lsbnrgwgCxbxDxiI/mRHIDjT+po6rZGd5zKXogTeCisypXh
 GfoggjZPX8ADuEIrUVNHNmZukhXiUCVj7EzFYU1jl/yr+KCVw96esYvh7R6ZGdtAVcyF
 gyj3shn/27hp20eDJiwLHjx+cQlPsjG+zAqlPOcwZ+L0oYe0FWMwlduWR6HMPnXPUouK
 QDyX3GSUzdOGZeD0bL4xN0ionPSX0o0xeRUh7aFLCKopQrJDPZEEc+uL67+9CG5Z9HZe
 eOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788876751; x=1789481551;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8xELttOT+vryfBH+zaDHqX5qd4D3oU7/ptja1NIt6+M=;
 b=ZBENC4EYN1VdGmJgw0hCqEjl1GN216/BvLU/vWJMrK16y7dciYp3ASyhLWyUDfMMzq
 Ec2M23TCdQeqUHUr6QfzyXQC5zMqGgVEfOmggmqTU+4/nus4YxL3DMtXGrQUEpcnBxD8
 dPsUJmTDiN5zo20lfmpHLVzKMakhOsBlcqJGjGepLdwSmf1to+uhvadapJSvOSKjt+of
 q8n1qIPnxU3MvZFiJ1xhIO1Gu+fb5n88p0McGPJ5vKc8aCFX6byW8JawprdQFY38hwIV
 /zr7l3DKCM7RP0u9eqT2kBpJDqKdxMKumhUUmlrVO6HaDLesBSVs8Tj47D1AqE+Lwo5r
 jhKg==
X-Gm-Message-State: AFuF++mkq29VMwd11kXBjt5GDmMMPLjC5Gm2iru9lsPm0yPVmy5ZXl9X
 R0WCwxSRtCrsd3vEvT4AJzHn+1p2bAvxWV/MtsMmp+x9ybXNHg5b/Me/GHqDKkYf7Kz3kvjUAUx
 YRbBwzjRBNcS7mSeKfopkLPaNZQsR8Yzwddg1JCZHksDot86fvSAVMEIexg==
X-Gm-Gg: AYBFou3hMQiDxIadytiFMYsGF8Jkm+LPxEFGizc/IaS4BJVP2+KVzmjoHdANi0qFeVu
 cM0kCirFC1Iknn74pCYiK9kQHs2DHkPFHNtevZ0nC596wuvuzKX8SV9Gatd1p8Gx4CtwMGOsuQJ
 YiY7MOZW6yYATNmn7B/UF0A+tNtwOtrD2icIJDuyNEK9rZ3mS/Ff2tEEuCxHYWaPduvUlUMyBqv
 gWQ5Rxma5MNOyunVw75DcVmoD+nG67OlOjLdfe763IptH5ez3DWb5eCq34pmg7rs4fcFEHMaCHX
 gnmt9cH0qm/rkC3KUfDupmwnCf2UnWO7CI3UiFT9gDWvrNfRI0YTZtnRPKjPY0NEZH5urX4CZn5
 UMOz7szIitX039LPYvuTlns0LhLGiNBiiGgobFzb8oSlO9XHi2ebaIipS1jJdnK1RkO4zB/jvbl
 Gp6n5EVvJGghBgePh6dOWPwmPk052wUATu/r5W3IQFhJZ31uW/QrBlYSOtmHGeWvLkse+0uTkjS
 QxnpXaSg37CuGjInpGbptT2IiCY4SyFtBy24qDLDMhrLbp5yzmJcPeYGAfmIl0ngK8QNtnMyY8L
 AumMMIqHzFaDg3kgygVWeP5AbeOTPT5Cft7N2vDHCKU3VG0LATAXB4g8WOh5Oj2fLfzXC/WPVa9
 FNP3wJB7v2Ve2lSPiNEaI7MXR9bl5khO2p5EIeQ5Hp2g=
X-Received: by 2002:a05:690c:e3e8:b0:870:f53:4ff5 with SMTP id
 00721157ae682-8712a7079e7mr118785477b3.23.1788876750451; Tue, 08 Sep 2026
 07:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260908125438.2720215-1-jens.wiklander@linaro.org>
In-Reply-To: <20260908125438.2720215-1-jens.wiklander@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Sep 2026 17:11:53 +0300
X-Gm-Features: AcwNN1ULhKswHbZml6Aap4eNLs3LFLsi6a6DTrVYl8_O-wmijbqxt1pgupxtKz4
Message-ID: <CAC_iWjJjBKka8b9EXC=gdAVsFo2m1xY5JVBJ6tgGM8T4urtZPQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: tee: update Jens Wiklander's email address
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: multipart/alternative; boundary="000000000000420c83065af9536e"
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

--000000000000420c83065af9536e
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Sept 2026 at 15:54, Jens Wiklander <
jens.wiklander@oss.qualcomm.com> wrote:

> From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
>
> Switch to my kernel.org address in the maintainers file.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
> ---
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  .mailmap    | 2 ++
>  MAINTAINERS | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index 76ba0a7fea30..f7bdfe53f4d6 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -72,6 +72,8 @@ Jagan Teki <jagannadha.sutradharudu-teki@xilinx.com>
>  Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de> <
> jakob.unterwurzacher@theobroma-systems.com>
>  Javier Tia <floss@jetm.me> <javier.tia@linaro.org>
>  Jay Buddhabhatti <jay.buddhabhatti@amd.com> <jay.buddhabhatti@xilinx.com>
> +Jens Wiklander <jenswi@kernel.org> <jens.wiklander@linaro.org>
> +Jens Wiklander <jenswi@kernel.org> <jens.wiklander@oss.qualcomm.com>
>  Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
>  Jerome Forissier <jerome.forissier@arm.com> <jerome.forissier@linaro.org>
>  Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 45e9076de671..125a610a384d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1883,7 +1883,7 @@ F:        include/configs/tq*.h
>  F:     include/env/tq/*
>
>  TEE
> -M:     Jens Wiklander <jens.wiklander@linaro.org>
> +M:     Jens Wiklander <jenswi@kernel.org>
>  M:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  T:     git https://source.denx.de/u-boot/custodians/u-boot-tpm.git
>  S:     Maintained
> --
> 2.43.0
>
>

--000000000000420c83065af9536e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,sans-serif"><br></div></div><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 8 Sept 2=
026 at 15:54, Jens Wiklander &lt;<a href=3D"mailto:jens.wiklander@oss.qualc=
omm.com">jens.wiklander@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">From: Jens Wiklander &lt;<a href=3D=
"mailto:jens.wiklander@oss.qualcomm.com" target=3D"_blank">jens.wiklander@o=
ss.qualcomm.com</a>&gt;<br>
<br>
Switch to my <a href=3D"http://kernel.org" rel=3D"noreferrer" target=3D"_bl=
ank">kernel.org</a> address in the maintainers file.<br>
<br>
Signed-off-by: Jens Wiklander &lt;<a href=3D"mailto:jens.wiklander@oss.qual=
comm.com" target=3D"_blank">jens.wiklander@oss.qualcomm.com</a>&gt;<br>
---<br></blockquote><div><br></div><div><span style=3D"font-family:monospac=
e;white-space:pre;background-color:transparent">Acked-by: Ilias Apalodimas =
&lt;<a href=3D"mailto:ilias.apalodimas@linaro.org">ilias.apalodimas@linaro.=
org</a>&gt;</span>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
=C2=A0.mailmap=C2=A0 =C2=A0 | 2 ++<br>
=C2=A0MAINTAINERS | 2 +-<br>
=C2=A02 files changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/.mailmap b/.mailmap<br>
index 76ba0a7fea30..f7bdfe53f4d6 100644<br>
--- a/.mailmap<br>
+++ b/.mailmap<br>
@@ -72,6 +72,8 @@ Jagan Teki &lt;<a href=3D"mailto:jagannadha.sutradharudu-=
teki@xilinx.com" target=3D"_blank">jagannadha.sutradharudu-teki@xilinx.com<=
/a>&gt;<br>
=C2=A0Jakob Unterwurzacher &lt;<a href=3D"mailto:jakob.unterwurzacher@cherr=
y.de" target=3D"_blank">jakob.unterwurzacher@cherry.de</a>&gt; &lt;<a href=
=3D"mailto:jakob.unterwurzacher@theobroma-systems.com" target=3D"_blank">ja=
kob.unterwurzacher@theobroma-systems.com</a>&gt;<br>
=C2=A0Javier Tia &lt;<a href=3D"mailto:floss@jetm.me" target=3D"_blank">flo=
ss@jetm.me</a>&gt; &lt;<a href=3D"mailto:javier.tia@linaro.org" target=3D"_=
blank">javier.tia@linaro.org</a>&gt;<br>
=C2=A0Jay Buddhabhatti &lt;<a href=3D"mailto:jay.buddhabhatti@amd.com" targ=
et=3D"_blank">jay.buddhabhatti@amd.com</a>&gt; &lt;<a href=3D"mailto:jay.bu=
ddhabhatti@xilinx.com" target=3D"_blank">jay.buddhabhatti@xilinx.com</a>&gt=
;<br>
+Jens Wiklander &lt;<a href=3D"mailto:jenswi@kernel.org" target=3D"_blank">=
jenswi@kernel.org</a>&gt; &lt;<a href=3D"mailto:jens.wiklander@linaro.org" =
target=3D"_blank">jens.wiklander@linaro.org</a>&gt;<br>
+Jens Wiklander &lt;<a href=3D"mailto:jenswi@kernel.org" target=3D"_blank">=
jenswi@kernel.org</a>&gt; &lt;<a href=3D"mailto:jens.wiklander@oss.qualcomm=
.com" target=3D"_blank">jens.wiklander@oss.qualcomm.com</a>&gt;<br>
=C2=A0Jernej Skrabec &lt;<a href=3D"mailto:jernej.skrabec@gmail.com" target=
=3D"_blank">jernej.skrabec@gmail.com</a>&gt; &lt;<a href=3D"mailto:jernej.s=
krabec@siol.net" target=3D"_blank">jernej.skrabec@siol.net</a>&gt;<br>
=C2=A0Jerome Forissier &lt;<a href=3D"mailto:jerome.forissier@arm.com" targ=
et=3D"_blank">jerome.forissier@arm.com</a>&gt; &lt;<a href=3D"mailto:jerome=
.forissier@linaro.org" target=3D"_blank">jerome.forissier@linaro.org</a>&gt=
;<br>
=C2=A0Jerome Forissier &lt;<a href=3D"mailto:jerome.forissier@arm.com" targ=
et=3D"_blank">jerome.forissier@arm.com</a>&gt; &lt;<a href=3D"mailto:jerome=
@forissier.org" target=3D"_blank">jerome@forissier.org</a>&gt;<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 45e9076de671..125a610a384d 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -1883,7 +1883,7 @@ F:=C2=A0 =C2=A0 =C2=A0 =C2=A0 include/configs/tq*.h<b=
r>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0include/env/tq/*<br>
<br>
=C2=A0TEE<br>
-M:=C2=A0 =C2=A0 =C2=A0Jens Wiklander &lt;<a href=3D"mailto:jens.wiklander@=
linaro.org" target=3D"_blank">jens.wiklander@linaro.org</a>&gt;<br>
+M:=C2=A0 =C2=A0 =C2=A0Jens Wiklander &lt;<a href=3D"mailto:jenswi@kernel.o=
rg" target=3D"_blank">jenswi@kernel.org</a>&gt;<br>
=C2=A0M:=C2=A0 =C2=A0 =C2=A0Ilias Apalodimas &lt;<a href=3D"mailto:ilias.ap=
alodimas@linaro.org" target=3D"_blank">ilias.apalodimas@linaro.org</a>&gt;<=
br>
=C2=A0T:=C2=A0 =C2=A0 =C2=A0git <a href=3D"https://source.denx.de/u-boot/cu=
stodians/u-boot-tpm.git" rel=3D"noreferrer" target=3D"_blank">https://sourc=
e.denx.de/u-boot/custodians/u-boot-tpm.git</a><br>
=C2=A0S:=C2=A0 =C2=A0 =C2=A0Maintained<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000420c83065af9536e--
