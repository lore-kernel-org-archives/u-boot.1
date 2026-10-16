Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC60CCA46C
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 14:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53CCF40A22;
	Fri, 16 Oct 2026 14:35:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id od_YyUvwVj2k; Fri, 16 Oct 2026 14:35:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 995E140A08
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792161300;
	b=aEA4Kn3xA4uougLYOJQwDkSt/BWcbU0UsAFhr48NEz4OvzfFV6GHXwoMYnJNJPY+yGu+
	 N7rVnHHQAX0a1TbFkyJo4mQQvA2W8TaoRDDVm5piGRzOjNL+JRK1/J9Vj8VpjjCMRiRH2
	 +mh72zbbQNZRzdYGTgJxTh5wIs0SH8gX8pCz0sid7JNJuMSMf4ncELCOGTFJsFxHOtcu9
	 HfodpfH6VgVtLax+vDk3i5G4L73ZSYN04G+FiI3Gif8J6lvSrb5AsfRaSrDxAkU0f0va7
	 xFAdF2lHZD/fYUVFAKEdwbjvadR8r3ewtl8kb8/GOcmZvQ4giDP40aERR9gSs7OlrYQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792161300;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=X4ShlqWzXWCIuOca62igyUPJq13DgrrADzeiJ6VDcOg=;
	b=WsWb/RnFtyudgtJUlf+xDwgPlJ9jSmhMPQidpCvlQzuv88a2h44tmJ2IkXfjbNMi9wNh
	 dQiJ79CIlxM0l4VurhGIOvIlQHV6HWoo+TbXIX+/9tnP/RthJHmL8yfeP6u9y+gu7JK/z
	 K+nVRyKpFV2LyLDUxnKuWRRr1I1H4bxcBQvX7Styca+v15CKFM8b2hkMmyTiU1D/XNywm
	 r8YZLmIJ47LSDzhhMhfIdMdpiuOFts+U0czV+1b/cLuNoP6K65EXjif5Y5vT9cl0U5EQ4
	 xw0pDdx6JZ6YsAVf1NUwh3U8ecCWU8kuxaYj3e2UHm2HWGj2No+SUpnCWkrGiNU5oJg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792161300;
	bh=X4ShlqWzXWCIuOca62igyUPJq13DgrrADzeiJ6VDcOg=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BhraqJK4SQxg1bgeCOQa6s7Z408y0hZk1LMfMAuGaFEHo9r4wMMk7/TPzoQiddqXa
	 He8W2SFB6PzTjngCXCLF4R1ahD7K5Bg2e4Z9azBumJ/YOG9BYo1a6TvHWzErCkRan8
	 SgCcm+4RzCohKUi8wIBObBQ4zOsHX9/JMsL9xU+S3tryneTsx80vUbKmOF8vNIMtsK
	 zAs+jXKuweLQdKYeABG4xiziXeCIZ9R3Lw86McBgIwDT4u7vN1oieNp+eL9WFdxXCs
	 BO9H+WWLdCRkWp5TW2Mu6DRMk44EbaGIqhZ/3DWU5aGgNwW+6nbYjSsVZi4rykEJfA
	 MYj5v90u8Dk+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 995E140A08;
	Fri, 16 Oct 2026 14:35:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 41E2B255
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33C094016D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CgkvAtcV6fX5 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 14:34:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A594140042
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792161298;
 b=c9RMEn6odlTGIN3wryH55+PM5ijrwu0MZQ8aOkWMuV9xKjjNc6+U8JuFR2afOizWqV4b
 xUcswSdpp3q7ZLT9Y3ILh7rA0qabVMlIwzc/1qQ0ruqzQ691ES9FdKqjTUNDE+IvgcsGl
 6it25hMY26DisW+JGuYhp0dmbd4/UEMeZwY3akIspD8sED4dSiviP1yWG5uDlglPrs/yW
 PKATlJj5rtJG+GMYik3v1whcyWvn9Y7Pbi5MeDZRM+EUsxpTeqJ51lEUPSwwxiSr1e6tz
 WB+f30L5OCHLZNzxEgL2BOQEcWlMt4i0/HnM/Wyw/DpSJgg+JxygwFXen4oF961qn/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792161298;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=X4ShlqWzXWCIuOca62igyUPJq13DgrrADzeiJ6VDcOg=;
 b=ErrCxQ6GuYkIfsUxm8+2Y/xDf/pkv4sOPC1gTiIiqWq1rdEcNhReMdA6XS3BuKIlCBty
 3aENQK4iwn/EsdcfnHUSk6/jFTwnQCly9nbk0bQjbrc3sBSQxrCCAZPjLYAL0eccQ+jKl
 A21VsHJKkr8E4U8Wy6ZzTm5dH6OtdRlUH+2t/SHHXTiG3NvIG7nDoQThf2QR8W14FqhvI
 +elGD7GF9qODnPagf3k4Ew2PKq5QSBJ1duBQ8clBcwqrpGl5Q5hIW4ckMxtOn9HEri0iM
 56w7o3rjF5V+H8vLVVowiACgrS1oP0h/LEWWDtBVg5vNY9sanBGWIovxSeun9+pUXYw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=aOvokoDc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=aOvokoDc
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A594140042
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:58 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cd60d155070so4671a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792161297; cv=none;
 d=google.com; s=arc-20260327;
 b=aJsyShMeUOedtgFSUYQfW/9yW3yfsYfVK0K29AZ3lm24tn6p/x1V0YUZ8Qred92OiZ
 VLw2sf+/zQFRCSqdm0L0cLpj/USzcJXQWxXymT1WVvb19u6iY/1zjAAxNkESchA9D3fS
 EBnHS7b4DFJP8eiKSwbwcsgNp56e4dsqmMBpBpMSHXn8ZBWJZ01QZarjRxDU97xSazim
 JTGttZ5TxhDDHP26PKyzgCX3gYiA6uktjrqpCpHJlZdxkUvnyedQmjpq5Gp6Np73+7hc
 cpDbxFL3ecb2eEgnD43GqxQNPRh8DiAq6rXksm8b5e++ge9d0HTFUdrPBfS9B5qg+Kyx
 alwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=X4ShlqWzXWCIuOca62igyUPJq13DgrrADzeiJ6VDcOg=;
 fh=gFiSENTxenWQwLiNwap3v3+krqEoYlPfJmgVdiElKVk=;
 b=A2O79k802uIfQbQfhg4iW84Qv6o+Q0wQEqrTVfJIFefZd3B5kHZcKnLJc9W0I+PwBh
 ip/95yrliT3UtYB0WEHiWFpnTJpj+35tZx6j9uvXpklUak1if1CQFJkCMRtVYj3EP4b3
 frkHSjhTJsXZBTOwU1OiWwRvxmlqcf3k2PAKGFur1v4FQPFi7m3NnXEsr28KD5XmK0tH
 jQEF3f72aOf4ib/TXDVOyglHElO05hUpuuXTsKmvhuGxmSNiGftYRJWJVDYagg6YONua
 eHTBs1nFeDwSRCuvEYsnrCb3n3XQkcslaBPco9TFC1eWzVCoOiPV/NuCpyAtp71f4VID
 xC4Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792161297; x=1792766097;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X4ShlqWzXWCIuOca62igyUPJq13DgrrADzeiJ6VDcOg=;
 b=aOvokoDccSCI4HnnT76WObX6lCf8b9d8xUBq1q6jCVNIw3yQRGmFpxccs5vcwffWTp
 JnxWQ8e1X5tWXMXGilhReBNoyM5J9ID3BHB3ip24DrN1ZgRgJ06JECwrElCzAz6znu2e
 OwDOO/LgW7RwYuBwnrFnK4hoEbdjh+1OxhEbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792161297; x=1792766097;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=X4ShlqWzXWCIuOca62igyUPJq13DgrrADzeiJ6VDcOg=;
 b=qTqajx+co8g6mpXEz4GXJzP0adxyIPKHIg1M85CFyOS8fMs4qiNbSfyLKfnBjQ0HRn
 jgZh7QEQV8CAMrDK1PvpvCc8ZlC54tmh63XD1Q480Z+JKmVn73mwz49xoBocBdzlzaOF
 8cpq1xtSIrDOOHyqQonRg+OOckF46axADDvUKaL2FDXMu38ViGWcAu5phd2y+ltUNVSi
 qp2YKmlleGe5y3mg0oT1pb5agQFtKTvstr7c1Xp0PiTXJqUIgToXQABxVePjTEU/+mVW
 ls8YfU/xAU4jDqlhIh6lInKx7f+8MmoH+SCSTT5maY+/ajg2lftga43GYvT1kgiksjyw
 jxSA==
X-Gm-Message-State: AFq9FYKF7SakEVh6MErRSwRckOaMI/JarIfuGzqK+RirjdDZDmyIkyHa
 yXADqBqBUtBcmcKutXNjglfogjpvGgrjudPcA8qxgvK47Jg9lGlIQAT6h5pgu7BHpPRH1rftxyO
 Ya2+AuOym8epyHTmLeHurJyi6sO3Qojf5dtL4u5/vffa9cXIIxENArDT1
X-Gm-Gg: AYBFou0rF+5fy4A6/VnN46s6rUKC+EBi0tfHxLxm9k0ecGL2QSrsmd6HICg8Io8O9wt
 lOvg3fCZDvr189vrl0Sfg4f7mxxuTMku9ysLcMv4SAb5WmBwm4ZuilfiMYRc72qUGbjrQdN9+Pt
 y1CrQsE42Q+hrzXq4IdwhtukjhKLUDVvWYd1cH6L1fboV3IC3z+vfPvvyq8E7b032pKTp4LFAWJ
 z0/T3LB6cuBoUsAdR38qvX2Vzxwmgpx0I2rHFZ2LaMtBFsoQHqkZgeTg0oNCC/C3Oq2/gTAKwHK
 ytQ7p07M1Vg6WcCNeLiqBVaUmw1J71hhTzThqlgaujqe2zmZ+piIqg==
X-Received: by 2002:a17:90b:35cb:b0:3aa:fc22:8aa7 with SMTP id
 98e67ed59e1d1-3acef5c49eemr8275a91.53.1792161297157; Fri, 16 Oct 2026
 07:34:57 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 07:34:53 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 05:59:31 -0700
MIME-Version: 1.0
In-Reply-To: <20261015111328.1269775-9-bin.meng@processmission.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
 <20261015111328.1269775-9-bin.meng@processmission.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 Oct 2026 07:34:53 -0700
X-Gm-Features: AclHuK_NpwhjnXlQlmmjouayy4bgHc9sxSs_GLQF0uPWH3R_8mWTKfgIzsVOLQ4
Message-ID: <CAFLszTiiOhLrG0MpzM4qKGN0pDdzM3Ri2HN9k-X0hkBjkx-Jaw@mail.gmail.com>
Subject: Re: [PATCH 8/8] test: dm: Check virtio queue cleanup on device removal
To: bin.meng@processmission.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On 2026-10-15T11:13:15, Bin Meng <bin.meng@processmission.com> wrote:
> test: dm: Check virtio queue cleanup on device removal
>
> Checking device status alone does not detect queues left allocated when
> a virtio device is removed.
>
> Probe the virtio child before removal so that it owns a real queue.
> Verify that removal for DMA shutdown resets the child and releases its
> queue. Reprobe it and check that the old queue is not retained, then
> verify cleanup on normal removal.
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>
> test/dm/virtio_device.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
