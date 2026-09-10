Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274C0C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 14:10:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E315381080;
	Thu, 10 Sep 2026 14:10:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BjcjjPewB0kH; Thu, 10 Sep 2026 14:10:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 365148104B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789049436;
	b=ZVSvbunAE1pdAHqtKr6DWlba59oJ7Xs4eWL6Gwazlzv15c5cS4ZGJjxpA0xdgLnl9iHR
	 gRqAbuNSGst1nBTo5kol4SuimjTwmzUogvdzwGpqfoCFfjWNbsW22fY/S/MAUCP6kdrkJ
	 hd8hOkaPinYVCOlRwPOox/j+f0sqEiAVnIo+KcloasweZcynADM1fDPta9/b+4WCaEOht
	 nGqUtzHoubD0VXCyvl9GWtM1dUrIJvc4Rfd9r0NlgiH5WXc8oPYlfDSrA9ym7xrcQfWaM
	 XnIljenbKEbA13/yEOcKy8qx95Aa4VB4S9q4+jblY49s6eIwGunHRQzC1nWgTGfDI+w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789049436;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PXfibcZtcu/3Ywlqsq8OEXHR7021SYJz1UAtQqjz72c=;
	b=pJ8Bg3+1DDNHHRXrOtv7pG9Kz00dl2ldLKlqrImgbYAnbpmvvyLXg7HFaMcmu5TJ77/P
	 XwGdkQjhP71on2y7BmcC7Cl2IWNUFiD2pSQdZz7qcCg8cnyZ+HiMzP17w3RLrRcSyXTum
	 uXEo3O9VBQ4qJHhGC0qFfLznRW2ViK1ipib/5vGONmTvlhfklXVTmlq46ti3mK7MQqYx3
	 fsgtz9jNrD63ef/R2caee89661MNAJFQYHzpraKV5ks9yN6v/IITtk+clYErkvgFvLfYl
	 Q4t6i0QoIf9xY79ZBnBHhUhBUScTyzSm2IJAlqOntFDcMAsP4JvjWxay9gEURQ9BxDw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fQ4oKRqG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789049436;
	bh=PXfibcZtcu/3Ywlqsq8OEXHR7021SYJz1UAtQqjz72c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QmmelQWus7P27AYWUWgT4IrsgXPhpM0liVVPsbmKUG2Vwls/A7UsbYuMzWtvJC77T
	 phRzaBRfglkbJ7fIHrMSuj3ZYp3vsmoJNgznbdsnSJ7mM5O8QcNSzR5XkgXEymo9yp
	 8OAhG/OCC81WqMUf6D+6GJdq6J/vs5OCzDUwqWmMVyqQCV1J0/ovMEEjue4Igvm94J
	 OALEPIkkKefUKLLOteenZovlHqtdML1AnMp1MOWRHETx57QevHD59kZpFuENl8tpz2
	 Jq5R4g8XMMjDqxkzNe+/P35FU/6FW2TPUiHMPb54QjDrSygp5vQBpg8i0kq8E+JEXP
	 uUItqgX1iw3Uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 365148104B;
	Thu, 10 Sep 2026 14:10:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 31C0AE11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:10:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1771F8104B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:10:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k_iFk59KMHUq for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 14:10:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AB10E8100B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789049433;
 b=EnMCL+geXBr7dnHcYtt7MbhjxnnrWZffn4cZjxfd7Qp/mO69Cem1fvMLn9iKZPRGlbcU
 SWjkbHZnKDtE6zl/yd0pLDWW6ySaJnMqdABTI+iO1iNlT0Mk/JPHFkerLkUaYzpxaHmIx
 Ln75kqQLkmsxYg9AxgnVrgZZks1zrJhqyVJHcB6rFshRpXJvo7HNjTRLyO3QwcYtKLpj1
 UK+RRkJuStu1nET4q0FwLgeQqw7XPRWWyiafRkpMEyKRUrB7QZJXZ8QARlLw4Tuuu2CTq
 nbNSPk2Hxpl51CTyPlxQBJH+DGDAfSQ7PNB1Bx1tuYTdwXYaLNdJCMjsPDuaiycZqyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789049433;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=PXfibcZtcu/3Ywlqsq8OEXHR7021SYJz1UAtQqjz72c=;
 b=YKUWUqrqrT11f3HD0r78mQkR786FU8ty7CMC+eT1Qt+cpUlKxMSKBH22USIByqCrRdOP
 BVpbtptaDLapXgH/EplgH13eg3xVVv+/EZL8Q5iv/wHhHp6GsB5FVB/Ds170eK+vUkOzV
 rOtccBPgEowBF/CnOOmTuGoUQSf4WkW8ywmxAy37xlOnXo5i28sbfi4ybgI56aHrb//3B
 /9rj5e6JWwmQ5Ugx8IK51tSiqrAmrvZl6cLxPDh+KhFDJnLEtvAJm9xgeZGNBEg6KNJ8r
 0kuBw2L8JBa8otaeTZZkXQQVNyt5j/eul0JWw7CWeETb4SKqRkx6Lx3J5QnBhn3chxw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=fQ4oKRqG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=fQ4oKRqG
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB10E8100B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:10:32 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a60591ae45so4063055a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789049430; cv=none;
 d=google.com; s=arc-20260327;
 b=R4lZXm0aFBtRhu/m7MmLXGj/s2/EqCJJIOTOYl+lTc3WOw3jYpRelsdZ48bFph2zcu
 P/SLi+AuAU3Dnze+gTXAJPptdADe6BApicRhXFmzY3pmlm6P0+XLvIUQnze61Zr8uauf
 zRuNbH1E4LaxVQfh59wWY45WTbjxBEctwQUQtpBPgzyXdEZMHprzAc4a4DIMM97414Qs
 2xtlEya41gYmwV7NUMOZt2eaWK9dI7WvJ53cSYpKQEGpQu2qEeePJ+cCaJsXlJAHgpz7
 /aaOGR5vRFA5QYdklhCbCe4qHkSlmSPKsLf0xRk3rkVkukiRIt51dxUroE2s+wB8Ar4H
 Zi6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PXfibcZtcu/3Ywlqsq8OEXHR7021SYJz1UAtQqjz72c=;
 fh=SGPXt3iAYo0Ycvs+S32XbBpQSs3cwFwtnfFtyhle8Qk=;
 b=H/HQUz4Iz/oUkbaIAlN09pQ2b+jqP9rPw7D5xDuLkVvNoQZQNMfz8DuSKMyEV6+rOb
 Ge5kZdLCMLJ7NuyNGeu3A9nO6ko/byT0CFPRg2Guz06aOT6vH9NaXq6V2RgUk9y4hocd
 y+F/UsNS4/c5V6/VdgftlHegciuxJndCedFieZEzzk7wZGHADVzgbrNichtRQIs5VC9N
 +OekR38oP8rWCF4Z4NnWy+b9y+3gaOw4noKDtMZaXYq6JAl4aG7Y+bdBgW2xxYjW8Bdp
 mSUOvCv4TdMvC4hLlaMzvmo+HacdB6NrO6CndVvUdso2NQn4vWabEtB3fmeOYEg1tDXG
 Rodg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789049430; x=1789654230;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PXfibcZtcu/3Ywlqsq8OEXHR7021SYJz1UAtQqjz72c=;
 b=fQ4oKRqGdDhGlqNuMiMlhxjPsETG2+ylOELqVgnzAhAT9BBXE2G7HXhcJ/lQIM2vKZ
 64arukFeFcpcgy1b5s1zkC3flDk36GSeiJscyixu2bUDLItDmoNVoacaHWniG1NvVpwu
 DjQyH+z6F3Nz/Uk6qwGEosGM0vWzKXsv4Q7zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789049430; x=1789654230;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PXfibcZtcu/3Ywlqsq8OEXHR7021SYJz1UAtQqjz72c=;
 b=ZCXvYKvaQYXpbLbZRrB3FBlea9FqfmtqH7hYro2ZmoGVM+Nzx+nnG8wCfIckfRD+xJ
 ZIuZzlFpfwPlpWghitjxqMIgZnJNH7z7ur/xOJWKwLjax+w+F9wanNGepaHeZDGJh32Y
 i5cnocJpbrQxKPB56gYr/gfViwNfl/xE07jZeyQxHY/q0ajn5VEaeBmrhCVwb/vE5Ztg
 MOBJDvXqcMlUjw2YgBv+ZVb12lX/3HeBSf0WINFdYhjtebDfuKAgZ3vTeDkIDk6OUpGr
 23cBdHUibXQaFhFON5b6oQoFE9e8iePQesfbBkozS9l3v+lWIjlej4/7Y/Z1n/sSTlci
 +7xA==
X-Gm-Message-State: AFuF++mYkJQvm0kiAnTte8nOaJaGHXwSRGb7WnZ0I7NaJMaVojlzu3LW
 cwFdEbJYw/D901c5ClZSDy4ZE8qndgtcwX6UDON0UfTL+NfFMdHP3Y/nMg+hTrO2gZEnflfObIF
 FSCih+4LQi7UKTAUai1BZxpcqqIYJt6oTPho9Y8S0
X-Gm-Gg: AYBFou29VkmaZ9CiRX3wrM1y9ODjkbM3PXQSmT/Z8+99DjMlhyE+97dGYkYJp1Xhe0H
 hjXhASBTsFXSG03B7eySh5S8eOnjpMllX8SyIbNG7j05xXG1ye/wxbImb4xEkvmEK0OJZpWPrEK
 +is364NGs+yWnnBAKkAUwFPZZKSahBSzTjyk7zi2kv7BhIWPTtt8lV3NCQOJjZcydkQKq81Dwhe
 92Q19+m8zpV68ZlAE02bIm9zcMMF9U+iOvctXX+QlU2yrWmt+2SHV77CLFnt12t9ZGeHWb9h/fl
 xyxcJHO8f++qUE7XgrIoZdAuhbPny3ZKUT/QEGmqRkeGehz3AVX/CQ==
X-Received: by 2002:a05:6402:325c:b0:6a0:9776:cb5b with SMTP id
 4fb4d7f45d1cf-6a98e010335mr7779824a12.13.1789049429743; Thu, 10 Sep 2026
 07:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260828105210.32664-1-mehmet.fide@gmail.com>
In-Reply-To: <20260828105210.32664-1-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 10 Sep 2026 08:10:18 -0600
X-Gm-Features: AcwNN1UDzXmIHGMRuQ5h9kEgfVsMGxxP2jB0GUQ0U84-EZ7JzXQ7_tFil3rwxx0
Message-ID: <CAFLszTi0TpqNDeh5FuB9966FRRLqChr3ffhvS7cCzKfaSufLPA@mail.gmail.com>
Subject: Re: [0/4] dm: gpio: read GPIOs in of_to_plat(),
 request them in probe()
To: mehmet.fide@gmail.com
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

Hi Mehmet,

On 2026-08-28T10:52:07, Mehmet Fide <mehmet.fide@gmail.com> wrote:

> This is the rework Simon asked for on "dm: core: read the device tree
> into plat data after pinctrl" [1], which is withdrawn: moving the
> of_to_plat() call around was the wrong fix, the real offender is
> claiming GPIOs while platform data is being read.

Thanks for taking this on!

I wonder how many other drivers probe in of_to_plat() ? It would be
interested to get the scale of the problem, if you can.

Regards,
Simon
