Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C860CA5FAB
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 06:05:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3B6E40852;
	Wed, 30 Sep 2026 06:05:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rh7k4vyUsuqE; Wed, 30 Sep 2026 06:05:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E681D4083E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790748348;
	b=fS0INcl0mT9ioRbtoNcPzQgUT5HK6yucheYquru94okE83XVvQX7HtV+uxdkjZevAl9J
	 Ds34M2u0xGNgxsz/j8AtvTZWk12SZA5mjDwkAs3AO6PSUpTh76uihG0KKo9ObH+rv0jBK
	 SyMe7tTEHMRmCyNq+ij+kxLq8l9MqpIZCuB3nsxTt6FYnDEVh+8bX9Eu20dqudhMjcXpD
	 MHHxOviNyNqEvy8Zp9PxdldXDRXiaCrMwWOPMV1tD5j5ZAD0VyvP3JjAW/dcGn1chAsTj
	 rYpZUa+SM08ic5XolMp4VeR9y+aypDv9HJLuFS08/c7HtOvOVTZQZnho4GCSQpzeafw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790748348;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YXCTJ4yLEw0djejreUyZwIzmX6pf+b9oT8pp6LkZRaA=;
	b=lBRoT/p6qUvf+s3i1lglgxGClbhot4E3blR3kgQAseUxiWypeZZ5K6kdrzQ0Za8EM7mM
	 iwgRvXE1pNQ9m/bT4R4KQAkjqrwHMn7Rh7WWGGpsGI4R9xpbhzxZBgb+M+puWehsonUn3
	 v35fqwq2IVwT5b09OWzMZZ5wdnDDsks9J5I8tloxgO58zlns50RMzUrG+KSfu7f58MEEQ
	 90re6Genvsz//N1OuexySJWGkN9QKCrqA34+pzVhsW2VPxR2zZ/exe75VlUxNUTNRGrG6
	 UxGi0A+yrO4JfnDIvr6Tth6aTdPPe44GMHRtWCnR3G7WYLFksDh2VRKXsv0za+NvYJA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790748348;
	bh=YXCTJ4yLEw0djejreUyZwIzmX6pf+b9oT8pp6LkZRaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TOcP+mNi7qP5ovmZyYDvqp3+ejaLR9Hthl9CwwqsXavHoIgfOuxo2AWWvA3coT+ce
	 zp8KBhiBY9QVdv121XDID0wqdmNWED8GSk/YzjLwTy1dbPMZOL1BC3QHAYawFC8SRE
	 vFii63pnKPvfnrf5j51vEPwtbtbe6avSi7aS7QTKfA1XTC4wCcHlTUhEX1g0D7nfr3
	 fjgomTjA+7+rjj9KAd3rGQF/2NCXJRXu6Lzi2sjxXU4b8qWJ+5R9sWIKsUCbcz6bhq
	 /juGC/SNELcWWJtxCvlg2QDcL7bHH2ViXT2KLkfKjceT+YnmhKWuRJz2CQFKknjZNO
	 Z61LRoyFYpa0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E681D4083E;
	Wed, 30 Sep 2026 06:05:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EEED432F
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:05:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D45E880FB9
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:05:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g0HDeJrdjrWN for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 06:05:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5CD1C80FB0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790748344;
 b=bu456Kj4U7eBFOzYCdLq9/UmXk9lV7kc/Kr+x9lsLJk8w+t29ac0r7Xw4gJzm1Kk4EPP
 qzAUfokxx37qG+aVBj3KstcFjMlZl2q5kqgsI3Xp8t+cHrBmMF8jucL+VN1r4E475ZyLU
 RMSDRKFi/bxFPmlIrbSnDCTburP6yc6stnwoDwnBaEqEnQr4LnloSHLGpC+fIIn6O5SHh
 dm1Uck4zsJ2ZjqB/E5UyFELeay5GE2JAcibRjS8IBxTkkTiok8YcacNObr3EKvlZJE9Hc
 +6P2ilQhBvKvBLIhMAQ6+nCfiNgF9IVHQg1n7H8VwfIfqHM4wPVkZCQSrB3Jgc5pBpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790748344;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=YXCTJ4yLEw0djejreUyZwIzmX6pf+b9oT8pp6LkZRaA=;
 b=T212Y1aOdyfC4tOCEZefUoa9pUYYMoOEwOPxOfvhynWPQi/1zqaRL55SZFyw8Tx4ySoW
 agkXgyBIPIcA8LKPWL6DwYGLUxuDV4rLagBwi/gSe+1MC1xsffQqsmbbv4tz7zbCuS9F0
 23FdxQ4KFAJAhJq/Hg6cAzXFoyGHNJWrjiSqiExtiAETuH126wOFQvDxykC3ayt5UGOk3
 Pdr4UzMd1o+mwefvNcZO3XHeWfeqF2rx5XeVxVhOF8zjXeVsFtJb/eKVQFuEOYsH7gmw0
 6G0ezSrRONJXdb/NMmAvD7nFIMpil4LirplQO2GVllYBizFrHwZPkUBs4anuIQozo+w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cDTIoqiW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::c;
 helo=mail-yx2-x0c.google.com; envelope-from=ilias.apalodimas@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cDTIoqiW
Received: from mail-yx2-x0c.google.com (mail-yx2-x0c.google.com
 [IPv6:2607:f8b0:4864:41::c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5CD1C80FB0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:05:43 +0000 (UTC)
Received: by mail-yx2-x0c.google.com with SMTP id
 00721157ae682-8ab4620ecf9so11319827b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790748342; cv=none;
 d=google.com; s=arc-20260327;
 b=nLe1uiTq+Aly9tqsh/nkdChwqyuiNH5bXi2OLhsvgxn00BDhTtNJcoyLJ0H5wK4KgP
 /O2woBpr0O6vSpT0UlqNhWroW5ZyYR4lWfZFCbqix5+JGsITpEQYd0Zg3wUy1q8rRN4e
 Ivx70SZn0lDkN1BHwFpBnjcUO49Cc2ePH1Y8lSCy1DnCtZse64eMuJm3C/7NyjHkHybz
 ltkbjS9+5I6ggntEoUmyfWbEB7TeTCMfPxc28kdClgGJnpQSGLJZKhkIcNyXznaulrE+
 eFjE0a31DtQJPpbkqDziLDiFePJwGTgCR7kPlN9+j7cCb9AWCX13VYLrKMTaTabmUWbC
 zdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YXCTJ4yLEw0djejreUyZwIzmX6pf+b9oT8pp6LkZRaA=;
 fh=GBlhP3no6maTQle4kVq0/r0Y7Myqkhx646Kb7YfZsOA=;
 b=Wzo+MOzsNvt1N/RFrg/QZ60hk0LAj7aIaukuaxn8dB6ZClQerYlnM2mjAS0xVcjPu/
 N3FbNp8vivk2RH5sHayg8nbB68rrkI9OJOguKC6S1RTbDmKZ5jXracnD+IQ6MMXRCxbE
 IdXGp6FtmpTuwyQu2yLoDBGxUBiQyg36HwPzH1APmmR3bcwWT3WF83h344weSo6ifL+D
 BnAFoHM9TVucKAcOxg6IvfYTHkaBNosx2L1GSdgUWR+YIcliqJxLZ1zxC13DRNzbfMZ+
 btOUgK5j3tdxkAmvSYIZDDhoFo62gk8eEZIM/65KKCWzmu6bBl+WWC6NsQZ5Osgq4Kv9
 6Euw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790748342; x=1791353142;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YXCTJ4yLEw0djejreUyZwIzmX6pf+b9oT8pp6LkZRaA=;
 b=cDTIoqiW7X/jzTzJKz3wd0GUvm2yk8/Gcm7p0R2fN1jA1NZQoK40/D5VWzvFTQr1eC
 BaT1Lb6i7ZDTEbvt4VTZKfAS68nFOAio1aNoKtvGixEi/kVZz+HC2xn7RbfqO/6zAtV6
 WgqKK2agV9tYdDPL/4OCm6EWRAaG8PNhiHBDbbUlYLPvFTXoMsBiFHEwpY3XVdWcNVPD
 aGXOy/4ASAP5mey5Wadcnk8NxN7ex2ivWvEyonIPtVVJB2+xU+MsDL42Ce2Tt/M9//2L
 B9mtgPaKEKgRXC2ril6QYCSvdp7AIUy3IMrtSHWKHdKfL8QMtNfDl90b/9GMGEklZpBI
 VWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790748342; x=1791353142;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YXCTJ4yLEw0djejreUyZwIzmX6pf+b9oT8pp6LkZRaA=;
 b=eCtEJjCmP+ZLK7WDN7+kfh9EdDIzi/LB/roDHnJBgqdebyi3SC0OZt6V19zeQn15LK
 ZcwMkVfpHjCo1o6DFPCWEl0gFYuhzBNqyL/PYZ+EP6XxlxjMC4qC++62hKnkvpmCgavk
 t9YTBGDxx5ITN/LFE3syPwOYKMJSWKVGbK/XOnS09DT2LBtjN5TV0Y0SNjC/HyKJQajf
 NfXSyr41oru9yIxVRolfiqOGp+WnuSCEmJ2AxrHWSFtvEi+f7pjWMqIRAu6CGcF0zA2x
 nN7ylINKa7NXXE8O8+vFqKcssvwxqGviW08UldJ/p9ATKYPNxHZ0tXtyJ0FIWWS++Zsv
 No5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzT4MAB4w8ESVdYWX491u9C+8Hh2jumUhJNEFRH7mRMPBH4YZ/SA+zXodHKLrHk6mFjRJ7D4QQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKmoA9kmK8cPcspzQjlUuAgg5omv+Xb9MEbXVTIClSjtAU1fENX
 6GHarha3IUTTOzbFq8ezSKDHqlKyLNL4HuFbdyxrNN0FvYNIhhVleOZI4qZbe1qi2m1cJWkcv6q
 TEQcdexEj2eFwqqcScODHL/xRRjvmdg2kSelK1Q483w==
X-Gm-Gg: AYBFou10H4ZX1T26vnpcURF9rKDKfiZPDmCgxh5N+WHONES1kNiu2h46JKI1FahIFB5
 yskAxNMzdxrFgUyacKQRfal7D02YpiYLCi6TEdDREID3sDYGwLcPpxeg+rYRdOCDQlZgUEnc1TT
 eowSjIf5gE9AcgjdJ4YpNNlWVVpvDvMRPyqW4Vsb+zsHgOtYk1BpAcIvr2lZPQbOf+oIZC/lbRf
 vTZdGRkv5qTx3DcmEbX/5dKzrcSWhDdIfoIjJ5mB4H9OKOy0Y4vyevjgZs7PSL1fA8h3cJc2o6h
 N1fiwX7P8wVTm4bLB/TSaEP4m9VhL4RRURCVtjuwTXLO1QhF9VjykxwQNkHPKNPNYEuNhVjFmJp
 HKiSOS6UTu77fS/Q2503+kPVVXRJJ5P4lkJHQ+tpNwAkwnsNWc85XUA+PetEA3HdH4wNDCmtzIb
 +kCiap447a1tYw7GU0wMcZ9zGICPNzy3xqwKvhSJmgGO5NPDFi01JtmYwGulKELgsflEQ7LYDuo
 vm8mkubM4MaDHmFY595S5gppSGXxPVR+WZyxwrP6eAQMfCn9ZqKgmX2TTPS6gbnf44suxlVw8t8
 ofw3VCJbN9/ljksPY6Z+CClkDjVTLErxfmHiros/Yvx86NK9Q/T/AnYu981Uzea6zejdfcr14LE
 jWMfznNu/yJYQfGLTAwQlZbrcRGPJsGG0XAzzGJFqTvXsDOSOw/MrlQ==
X-Received: by 2002:a05:690c:6987:b0:89f:4c20:73ca with SMTP id
 00721157ae682-8ac92949811mr422367b3.46.1790748342243; Tue, 29 Sep 2026
 23:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1789023381.git.jan.kiszka@siemens.com>
 <1a6e9dffe86b43d3c62ba185859d30a376fb61cf.1789023381.git.jan.kiszka@siemens.com>
 <CAC_iWjJ7b=Dh+8k49Mq7W5=-b1dZV=L7Z_E6epeOCoej65unyA@mail.gmail.com>
 <5d4aff06-f1a6-4634-b7e3-4e054d5117d3@siemens.com>
 <CAC_iWjKnBrDYErLbDkQyv5tp545-_pfFJA6z1kmGcXvCPt3JBg@mail.gmail.com>
 <abb5973b-b417-4ab0-92e3-d3117ef68bf7@siemens.com>
 <CAC_iWjJaBtq5r=DJtdf_UWUxv0Hn6PrUFXi9xxDT86BdHibtFw@mail.gmail.com>
 <CAC_iWjJmRWZGO4zOOp=s2L91MLwJjMamHmP4jzXkVNOWNXyFRA@mail.gmail.com>
 <fb2d95b2-623e-4235-bb5d-bd57f440020e@siemens.com>
In-Reply-To: <fb2d95b2-623e-4235-bb5d-bd57f440020e@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 30 Sep 2026 09:05:06 +0300
X-Gm-Features: AclHuK-G_2r8j1V-ixqdaPVdjcTnkgL9ZCd_JdWy1PGG1KTi7jAuyJhwe7-6Tw0
Message-ID: <CAC_iWjLCZaH7FC5t-Bkti71FewcEtWCSmaaSi+jn1JjDmdhnXg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] tee: optee: Add support for enumerating services
 that only need RPMB
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, 
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>, 
 Alexander Heinisch <alexander.heinisch@siemens.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
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

On Tue, 29 Sept 2026 at 19:44, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 18.09.26 14:36, Ilias Apalodimas wrote:
> > Hi Jan
> >
> > The CI seems to complain again unfortunately.
> > https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm/-/jobs/96289#L2649
> >
> > I didnt check yet, but it seems like a missing header somewhere!
> >
>
> Where you able to find the reason, or do you need support? I tried to
> read the CI log, but it is very hard for me to correlate the output with
> the configuration that might have been involved.

It blows up in SPL, so I probably triggered that from switching
CONFIG_IS_ENABLED to IS_ENABLED. I'll requeue it on the CI with that
change

Cheers
/Ilias
>
> Jan
>
> > Cheers
> > /Ilias
> >
> > On Fri, 18 Sept 2026 at 10:11, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi Jan,
> >>
> >>
> >> On Thu, 17 Sept 2026 at 18:24, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>>
> >>> On 17.09.26 16:57, Ilias Apalodimas wrote:
> >>>> On Thu, Sep 17, 2026, 15:04 Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>>>>
> >>>>> On 17.09.26 15:01, Ilias Apalodimas wrote:
> >>>>>> Hi Jan
> >>>>>>
> >>>>>> I pinged Jens for some help with the OP-TEE path.
> >>>>>>
> >>>>>> [...]
> >>>>>>
> >>>>>>> --- a/drivers/tee/optee/rpmb.c
> >>>>>>> +++ b/drivers/tee/optee/rpmb.c
> >>>>>>> @@ -191,3 +191,23 @@ void optee_suppl_rpmb_release(struct udevice *dev)
> >>>>>>>  {
> >>>>>>>         release_mmc(dev_get_priv(dev));
> >>>>>>>  }
> >>>>>>> +
> >>>>>>> +void optee_rpmb_available(void)
> >>>>>>> +{
> >>>>>>> +       struct udevice *dev;
> >>>>>>> +       struct uclass *uc;
> >>>>>>> +       u32 tee_sess;
> >>>>>>> +
> >>>>>>> +       uclass_id_foreach_dev(UCLASS_TEE, dev, uc) {
> >>>>>>> +               if (strcmp(dev->driver->name, "optee") != 0 ||
> >>>>>>> +                   !device_active(dev))
> >>>>>>> +                       continue;
> >>>>>>> +
> >>>>>>> +               if (optee_open_enum_session(dev, &tee_sess) != 0)
> >>>>>>> +                       continue;
> >>>>>>> +
> >>>>>>> +               optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);
> >>>>>>
> >>>>>> so both optee_probe() and this function will now call
> >>>>>> optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);.
> >>>>>> In OP-TEE that ends up holding a mutex in tee_rpmb_reinit(), but I
> >>>>>> don't know OP-TEE that well to figure out if this can deadlock.
> >>>>>>
> >>>>>
> >>>>> I was developing this under the assumption that probing and init paths
> >>>>> are single-threaded in U-Boot - aren't they?
> >>>>
> >>>>
> >>>> They are but iirc the responses from OP-TEE are RPC calls in the RPMB
> >>>> case, they aren't guaranteed to run to completion.
> >>>>
> >>>
> >>> Maybe it would help (at least me) if you can sketch a control flow you
> >>> are concerned about.
> >>
> >> I didn't have a specific sequence in mind. I just noticed the mutex
> >> locks in op-tee and was wondering if there's a chance we can re-enter
> >> on a different OP-TEE thread while holding the mutex. But I can't
> >> reprocude it locally with or without CONFIG_OPTEE_SERVICE_DISCOVERY
> >> (which changes how the device is bound).
> >>
> >> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>
> >> P.S: I'll fixup is IS_ENABLED() during merge
> >>
> >> Thanks!
> >> /Ilias
> >>>
> >>> Jan
> >>>
> >>> --
> >>> Siemens AG, Foundational Technologies
> >>> Linux Expert Center
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
