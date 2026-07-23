Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E55C531CA
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 12:25:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3718608FC;
	Thu, 23 Jul 2026 12:25:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1G6B7EWn3Z9H; Thu, 23 Jul 2026 12:25:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0246360792
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784809548;
	bh=AiZ/fLYJYlSg30aZmuEfrAaG27Ix0DbF8oWKkEvJMaE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jbmeNfANWZnwkMm/8pH4F7QQSusDo4X2BG9ziaJAOfQjuKNa8TFePxxGh542SzmJl
	 FsgHAy6aEWMOU/igbGU6JHwX2ATaQO6YdZtAVxWzIIqMRit6ffoL5FJR4lrUynlkrN
	 FJQ8XI43GLfR62YJ4I0XF+iLJ4AC6JU2mw97td9/rKkfp34ULgup2iwKSm98btCsLk
	 3Pbjv7wx/8K9ztWmqa8HS9b9gtSnuN4tR9Z9g35B2ScmCqF9cyKxsc/o3zS6olX4hT
	 wl3kcjSTX8BsV4UglGPcOjOXUNmVFtdYzcayXXWVGtlw9Aos9KkUS8405L5u438NOJ
	 zeXtHFuoDcjZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0246360792;
	Thu, 23 Jul 2026 12:25:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 77A223B1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6952D8100D
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:25:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zrxP-BL41W_6 for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 12:25:45 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 13C568102F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 13C568102F
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 13C568102F
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:25:44 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E11E7803F6; Thu, 23 Jul 2026 14:25:42 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9238680117
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:25:40 +0200 (CEST)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6984169c126so1106020a12.1
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 05:25:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784809540; cv=none;
 d=google.com; s=arc-20260327;
 b=SoRjlSN646+A7lLORlaOgMIS9UKI+fTpj+1t0w7jcYTaFW9AtMzHxU6aDcGne7jsh6
 TS587q5r62TwmJpdeLd423IlzsMV+fU+rnnppP23cNCKRJKccFvNULeOjLrhavKy1dFr
 BvZLxvaJCAGJMtP/RugHNLT8aS/x9YNTrKfWy+uCt5MhP5Yk1EbpKuNTHLvObMpfJvCD
 hdZJhP9ZzBA5dMtyU4zwGv0pgeeGRYczA3+STAjvsZK14CHh1AHnEwfPfjbwMvQGFSkY
 hA3svi4nzdorVOs7dEWN/yZ/HBlhwPjobm7d0KGNoiq/83AmNlF/Yz0RRuPatUptl3Ey
 dgmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AiZ/fLYJYlSg30aZmuEfrAaG27Ix0DbF8oWKkEvJMaE=;
 fh=OuowzhnSXj1Fq0buMNvfvwCFCBmsDZM9xd1zaiexQbw=;
 b=p95fbtkia1owMYTmXakY0kRiMPVi3tTC8Apx2SvVXigFSarr98BG1v2x82Szbywaez
 q5xMzBPg3YWCSsTY+s9igwZl+vAaMNZVRwd07Lyw5xgPA0OyRv/1PlYAptVeoLteeJTV
 scBZ1XltaKIpm2VTPb8yTJxzw30v0gP3gnFuqVQYyxmHa4s0Ov4C7ObOzV8njcWqvKog
 rfBneTXCpu+qw/IW158xDcJD4H+5d/RcmaKVeX3zFIRYi1RkleYmDqHy7LE6ZSzWvdb2
 4prXKrmG/NhN/To+R9UPthZQU6IJ/1msXDq1pgY/ZIzu5dLdU/C+43paJF5Z8oGUE0fO
 wxcg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784809540; x=1785414340;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AiZ/fLYJYlSg30aZmuEfrAaG27Ix0DbF8oWKkEvJMaE=;
 b=VyoFGgJhVfP2AaaofnVu7UBeARzrQI66M4MyXF8XkbB5PIwBjjNnTHh+fE6OjXaKK0
 FUtcsjELL8cUi6AaY2ZWtHk5x/x3mnAN0KqXPe1/wZ1vj7r8URMqSpLzxvJsLqyeIpna
 u7KFSjFBDUNiqZa3LxgtolUIzTxq82j0KvK0SXolOIrxXdTW+NHuqx/ImRdrbw7Dvh/N
 5eGg1O2S9H8T6g8X1b7gb1QLtIgkv05ZePHnl5yykkkFnA2dm7/Tx+WckSgl3jRyNKo8
 zbObJWzK9z3nnI1zSBfB1xIjqvlljj4FEIcutOshwh4oNPHcDtBoxgAXQH93/K867145
 0cfA==
X-Gm-Message-State: AOJu0YyO283oI6vSvI/EHLv/3DDjU893f7CyBWN0zIK6ZNDtshc+zlr6
 /TrsyNL9OO7oYRCQzjn/0F6iPsst0bZlht1sDHV1YbvahyLGsIzyAtjlJgqr9a83c+qvPSC9/LH
 QR8iuWWBkGqKIQwXE/vyc7VeHGKL+N+go/SvmBD13Ng==
X-Gm-Gg: AR+sD10cP/7qGWzF0cqgpNsvYhr57OTNKHhria3/bAEWDYR0s3Hd9F7KWMvRbnA1WMq
 QoVjAv+knpmdAB5GhBRhQqm0pMzWDngWyV3GHmbUIMe5hK9i+ElQsyXFP94i6AQGk1/X4pCjPsY
 Ae0BVbwOfsqblVUhny1hAtDgsFafxeims2i04S3F/37LhgMh95Q8kl9O6YfFjcvZ4s3G01JIUQ2
 O8AeU4CCowy+EuJZcmqivOylXBZpnaT86x5zxcUth8Iwzba4Yb+UpY3DfWOMms=
X-Received: by 2002:a17:907:3ea3:b0:c16:72ba:d352 with SMTP id
 a640c23a62f3a-c1c50c2951fmr139996966b.31.1784809539869; Thu, 23 Jul 2026
 05:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
 <20260713-rk3588-fracpll-v1-6-cdf47f2ca0b8@flipper.net>
 <88436f3c-079d-40b9-99f4-791ee3adb192@cherry.de>
In-Reply-To: <88436f3c-079d-40b9-99f4-791ee3adb192@cherry.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 23 Jul 2026 16:25:23 +0400
X-Gm-Features: AUfX_mzTfYjURAp5W3rTRbqH1AGSKuuNbwBN39PbPyEspjrTQIbrDCE-uS4e9cg
Message-ID: <CAKTNdwG-yKiDeh8qH0pQgfyWHwkDT8+1jTR_8soOU0Ffc23OWw@mail.gmail.com>
Subject: Re: [PATCH 6/6] clk: rockchip: pll: fix overflow and drop manual
 two's complement in rk3588_pll_get_rate
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Elaine Zhang <zhangqing@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1784809540; x=1785414340; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AiZ/fLYJYlSg30aZmuEfrAaG27Ix0DbF8oWKkEvJMaE=;
 b=1n25XHOG+52R+XjcG1gt7hYYg7Q9o3D6PujfUx5OOMHZug9wzqlTjGgkp9ukS1mEHr
 BmSvb567u0BWJ99b7pFuhJ55lA9f1dT+VZF4j95+p5tv7slKwmnTshywUsucb3ROVPX/
 L+QH0ELwdtt9xgPGb2bnIHXaVZy4tvMWUC5KBIQgapNwMTnynq3H0yzvRxJ6M0RfROey
 WbzCDdBbunT/8ZOmfI/ZWYJTW2wC/RgugEOPnL7i0mnd9XaC1kWeQRwSKLZRmtkttuhc
 cNPaHgLB4LDcUfC+8ujV7S1u15vwh+ZASEYrfH6c0XHxIJuwUxLhdxCOOzpLsAf/vMoZ
 vy6Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=1n25XHOG
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alchark@flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=flipper.net header.i=@flipper.net header.b="1n25XHOG"; 
 dkim-atps=neutral
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

On Thu, Jul 23, 2026 at 1:23=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 7/13/26 8:35 PM, Alexey Charkov wrote:
> > Current code calculates the fractional component in 32 bits before
> > assigning it to a 64-bit holding variable, causing overflow for real-wo=
rld
> > values of k, given that OSC_HZ is 24000000U. It also does bitwise manua=
l
> > massaging of an unsigned representation of what is actually a two's
> > complement signed value, which is confusing and makes the code harder t=
o
> > read.
> >
> > Read k into a properly signed type and promote operands to avoid overfl=
ow,
> > which also enables the use of div_s64() to express the math more clearl=
y.
> >
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> I've quickly looked at the rest of the threads in this series and I
> think there's no open questions left for me? You sent patches to the
> kernel for making k an s16 so I'm assuming we'll go for that in U-Boot
> as well. The PLLCON(2) thing for integer PLLs will need to be fixed one
> way or another, but I'm assuming this is also something we need to fix
> in the kernel so a similar approach would be nice. I don't think we need
> to make this a big series fixing everything in one go, so feel free to
> send smallish series whenever you're ready. Anything I'm missing?

Thanks Quentin!

I'll rework the helper to take a pointer to the table entry instead,
as we've discussed in the other sub-thread, and update the whole thing
to match the types etc. of what I submitted to Linux. Hopefully the
unsigned->signed conversion will then get localized in a single
commit.

Looks like https://lore.kernel.org/u-boot/ doesn't pick up new emails
from the list since July 20, so `b4 trailers -u` doesn't work either.
I've picked up your review tags manually, hope I haven't missed
anything in process.

Best regards,
Alexey
