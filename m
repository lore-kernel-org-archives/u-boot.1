Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C510C88E4C
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 11:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C03556069C;
	Fri, 11 Sep 2026 11:45:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6DuTRBkg4rqd; Fri, 11 Sep 2026 11:45:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1A0A460665
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789127101;
	b=XVCLie+LSWw8hcKCUVa2cnbguxqDSVS2xv8UXPXGRTXp8SSxAtbqY+OIDdEVtiEH1hW/
	 e439ftW/4qY2lSv913jKtcWe9zFSFk0lUoYD4BBestE/BYNc5vcz4WacWXmbq1KpqmulN
	 ni7h0WuEIGZVyUP3FZOxzpoP0hMDRNzh9hFv3zFLSp6Db4UIruY8JFp5ZLr2Lg0KkJlYF
	 vbftkTaf7dzCRIGAkPKjCc1PRTLqarOd4V7l1oN70ywYJOs/21QDZt9/Kp9UOJiHdMAiJ
	 wPmWFauVZgAQgOusoz23Foewjb/q3R1SNRa6ruakG3X71pIMf9J5dWEJIRYI5/ZVuNg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789127101;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wY/tU2kn8Pt2nj1Bhmqe8mXbOzMWucrEKaghy352HIw=;
	b=FB2qQZho/Vx2keTAd1c/KNYjul3ViUb/fITtf8+62wvuTjyKotrdKxoFytWY3l+P1LFx
	 wJDYksVt/pXyN0UkVdRNy8IZEQ3rCqKZK4ZdNuAclQ3VIcmyybPoEyq7ePJHW4rktVYEK
	 wTCa7G2/pvgre6f78Ivpw4sd0X9WL+8JLz64Ry48CuGvJEHcw6FGKt/uCc0GaO35b0j6v
	 A03v/4kVJT6zOy28Z5faflsCDYXFPPPJjZCXAP1ty8vwthwuRgE+dYMRMUhsRoMlCxClL
	 PGnuXBIodCgLx7PhsdnUpQz3q+z27qxivk9CB/mShIUtDlYHDryYhuwBK/ALF3ThtlQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789127101;
	bh=wY/tU2kn8Pt2nj1Bhmqe8mXbOzMWucrEKaghy352HIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uAa5b/mo/YXJntsAHH/ONVO8lADikNKn+NPoJBbWOgFuxrssJxi3DLTSSGuI0PDmx
	 lM2HIsDY06m+afx8BnVJJMOPnYnTHqk/D0qEafLwJNMyeJQIQX62LpxhOhej38IkUu
	 o8ANI0vZeRISCfzhtJoeQO7AVvwjDFvEodnZmBM8gn6Lph1OlcvR8S/l08ybGz6M3A
	 i+EWfh+oH9ZxQthKsZIVaVrzjaIFWDMfeN07pcuqx4+ifEI24Ak3aGvE4x/VZjk7/p
	 NU76aYpPXBh2T3t7qWWEPdT1+l5qlqrLKdsaBQc9Em2immYNgDWUFTc0PyLpEwKe9+
	 6UDhVtZuiB3vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A0A460665;
	Fri, 11 Sep 2026 11:45:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 350AF29B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 321B480D97
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:44:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hrFU9Ae-5G_4 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 11:44:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3EFB280D64
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789127098;
 b=FujBQQGY8w56K4z/SqvWpRL+Dop8tvCRyzxVoUH/E4mFinxmFvcSg2pgMXee1ot9lms6
 EmrPIgGI82BupEEayTaOaMK56Dc4z6nqIMdRF5Yq8ruArp81ZjPkB7fpHgN39lygC88+w
 oUUkbn9Io+vrl2sLCQYBJUM6pLkrypy6mrf2R+1Tfw9sGAkq5PkmJPD/s2Bdx7UvAjdYk
 ulQjwKwrG7ppJPEKWto3RrVKtOkgbYqUtzGihhNnmwJwpN3rjUuAl0md72ymhThAt50Ur
 /t3z5rn9D2HduzzprUB0NYgxwJvyQLBtI3lpoiVfGUDYv5jHzyl8y7twdjhpXMMed9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789127098;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=wY/tU2kn8Pt2nj1Bhmqe8mXbOzMWucrEKaghy352HIw=;
 b=VTuuFxsvJY0zcAUo27PDJEwiNnC6f48HMHLlgEzPWIVqAL8sepK18rRSBjMMPiljzEYE
 EAjJADnbYWF3tXYu6aSi9P5pQkxbPE/JWwJSQb56mf/YyqYSS9y2fpxGX31/HMMT1qikC
 KuLVCMME5Eqlz5qcy/azPJRabM7e1QxXls7uTrqHL7Spbesf+HthAAXfuqJqc1WuurWKV
 4dlPVf23J0orBhAbNJ0mu/6TtyaX72Rg45bcR0ZZbWw1r75noXFvToHSHd8eo1G1FA3tK
 ncgxHyz4z0Bkx5c+R7V3WEkv6Mxof+0dxyCalCgIj7HIXK1MYt2iVmKGn025jJOKvZg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iLwD6FDY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=iLwD6FDY
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EFB280D64
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:44:57 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a6063d7dc4so1124524a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 04:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789127095; cv=none;
 d=google.com; s=arc-20260327;
 b=CN9SyblGYinUNrbn5+oQY+grsiwjIpVuszfX0+IajpZwJJd5JdYOhsruLeYRgWZ3KZ
 uUvgcLiLHLFbmIRUvLdw6Z7OA3d2lgBb5u1+k14W7x/w17Fi/0wWXYAAEYKsKpqAYmKF
 n7n2PvVn+KHeNp5sRvppVItHWaI6+UQ85XFIpWoCwg3x0keguQKmQ9C5o738CgZzfu/B
 Zy3xyA+X09ca4Cr3emIBYkdWetTaUnVjM9c1LDpv6SorDWtM2qBWbuhsil4Pit/r7qzT
 SNsYZ2CJTnjSMv2i1BDEYLoUKC11QK4WSjOeBNyfXZ/fzjhEFGqBO0YUpjUdsZw0h1Yl
 YIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wY/tU2kn8Pt2nj1Bhmqe8mXbOzMWucrEKaghy352HIw=;
 fh=8bmHLu8nsr0Hxvf8/NNQZ1CDRdbHhJUuuzpZ5+cM6+8=;
 b=HjFDCu61YaXqghiMs0w3ktL+40ciksW1k8uRhHiKO0ECoiqhNkt519fqSHzE0Za6pV
 l4gvGOA0Pho7+XymXck6Grx92vgkxtxhROwCHjYNnTLtGUMtjngAw/kyNFsqkuCHSpiP
 qN38gwaHD1GqSWsYixPtP3mn6EJgzlz72xU6SB6NgyypGinv3lyYHJ1W1xG/PifhLngU
 DM9Aqoi1vs80J0Pl3IKn3Wh25BkM9qcofhGvGPn4/xG9MshFGmWZW2QGHSbOvnvRyXMM
 786JjYipq9rLQl+7aZKH+r/j4zNTlU+0hPERopXzN3dZP1GENLd/sbHH2wpZObfWeVXX
 jY+w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789127095; x=1789731895;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wY/tU2kn8Pt2nj1Bhmqe8mXbOzMWucrEKaghy352HIw=;
 b=iLwD6FDYprE5EDlH9KrZsNFv5tFgcNFjCJuXGRpEqEKlOK5HgRMNh//9gUjefX2WD0
 5ZwZvVvBdWUjutXVeAZmbtUShUZGIwY12KoRfRDBmKQjixl0t39CksuUPKTVGEwNS9YM
 slZI4HlnPgCETSTTKEKbBiO9e9isMUxbhYDAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789127095; x=1789731895;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wY/tU2kn8Pt2nj1Bhmqe8mXbOzMWucrEKaghy352HIw=;
 b=OyksFBWjq3r7nl3sH+XNvs0mbNOcs4gOO84UEzqMjgo7gLE3ZB/B4qiwemOsr2kPMi
 QMpKFZsLkpnunCOioB4Jqt/QAJclxnZ2qKBt2NiS5vdHiYwWzIwkelPgTW+gNVomOh38
 6e4DUbbSGKEpBMRqiCLqCl2OYy80tgyi3o5uv2DzsYaMeYUCHv7ub3zDlYEd24R+zOru
 1zGipvXhFtldUpkcEcSDDc2szV3hzBzG+Iy5YYDvoUFwfPkF97C59WPAjZ/4kITj9P+7
 umO7CV5qbV/F8nCYeXpbTtcn33hVazJw9icvo9dA/3vFE8RnSBZeKO4JF/EJ1gy81Z6+
 LJ9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSHKPHxoZFPqHK+2K6q+No9UgqZn88bH3SeHI5a4hZypeaN6nucvDJ+uPTUPKMqJXTrH7Ti7Y=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mg/Rn9x5oO1u7EPiLXijfNIbskDpOOeyKVM/Vmhz044ArlAwMQ
 ruStf/sjJa2lm1myJYmRdDywT1JuMeuYp6cqk0oVnq3mZBylNYSOPsLKeIqzGt62C1e4Qf9azAj
 iadUmDZGPQvQVHlM3PSHeM9/q2V9vjgPlbL9s4aSq
X-Gm-Gg: AYBFou1WIZTg0peJFea9iJhVssmQfoLx7KycOxLTbLOAiYfT8XLNRJG7eUgXfZwZQzF
 pLTlKpRdeA87BwA12hegt37eKa6IS8CUqocfRf9ULA1BUDOUkYZvFlIWcJHtxPF4ifrM8kjRFmN
 dMuRGaF6S4BzJoxEaAGra1s1KCuUL66N34cDYiZHSvWtasw79SNQ8GwARt6JxBaGw1xQxj2EZOG
 D3IxMopuMfVIpQ/33/iOgSEgQiGn0YrrsVrF4XVpViBoZT6oyf4DifOIomHkHVCIovx4uxVBoVB
 rRIUpJL6hzzavCc5hVxXv3mFvURcFjkWkP2RfkH6bBaQiWGuebxVLvY=
X-Received: by 2002:a05:6402:2186:b0:6a4:21c6:1d14 with SMTP id
 4fb4d7f45d1cf-6a9b55008dcmr3340054a12.0.1789127095293; Fri, 11 Sep 2026
 04:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260829192119.2658328-1-visitorckw@gmail.com>
 <20260829192119.2658328-3-visitorckw@gmail.com>
In-Reply-To: <20260829192119.2658328-3-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 11 Sep 2026 05:43:28 -0600
X-Gm-Features: AcwNN1Wl9v6vNBW7gvu1ozxkQ3LKHy7DYKWnx15tFxjaxRf8EDVaZ25Wtnwtkpc
Message-ID: <CAFLszTjmCuuL3QrOKUzR8iKPp9yWMzv1Od=8Mq6oSvuP5HTm3w@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] fs: 9p: Add 9P filesystem support
To: visitorckw@gmail.com
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, 
 sjg@chromium.org, jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw, 
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.u-boot-project.org
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

On 2026-08-29T19:21:13, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> fs: 9p: Add 9P filesystem support
>
> Implement the VFS interface for the 9P filesystem.
>
> Map VFS operations to the underlying 9P protocol client and register
> the 9P filesystem type, allowing access without traditional block
> device partition tables.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
> disk/part.c    |  16 +++++
>  fs/9p/9p.c     | 185 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/9p/Kconfig  |   8 +++
>  fs/9p/Makefile |   5 ++
>  fs/Kconfig     |   2 +
>  fs/Makefile    |   1 +
>  fs/fs.c        |  25 ++++++++
>  include/9pfs.h |  60 +++++++++++++++++++
>  include/fs.h   |   1 +
>  9 files changed, 303 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
