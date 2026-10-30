Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3873606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GxiKJGdO;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KdnbLhr1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9841813F4;
	Fri, 30 Oct 2026 17:27:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SR7blyQMlp0r; Fri, 30 Oct 2026 17:27:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B4F4F81698
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793381271;
	b=EZxlw5strvBIqz2zfwv4L7vgWEhxhyKoII9sybTfri5wwYYaJGuwpjqcp+pJ86mpdvzJ
	 4C9rHzKrlZv+G02DfaWLGa9cNgyqjj9hcuCbQhhsDW1Mer+atSujwRWpTSQOUY5/Z5PTb
	 q1QuXYmzUGJFenJ1ghpAHsgrTF+ctTTnTP+GKBzxRyPhJ6MA51F6VqNjNMLVURWUSB3EQ
	 irRbPTJszMhfnz1qwtOdfiNURqEXGkFy3Cx3ztppDw/L79vvkkssl20nFMIP0wRdYjDp2
	 FIU2c/YLm3xXQHTEwo9KaWzuPOjtEP/4CcPxp2dgXtkWunc4AuNGGMjHOvJpNM2yoWg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793381271;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HKkpuMss/LYf72MUN7LyJQ5C0Jt9d4xBRxygY9btSCc=;
	b=X3yH52Ucv2FeyBFKshBISafCEYc/ytF9EgcLSIoYmkx7bONsfVsskpA1il+gT1KFzNzi
	 iOUy59o/bPsf7g++2ZW7sFrRwmafvD/IN6TK4+3/FFq1rLFEgKw93Nb6M+cdbZgOQDD5e
	 /zylFAlXl6yqehG0Dsz/UGTiM91eB0fe0AdHQQ6JfsfjSvLO3aanjjX79gC5h2+pUHWvc
	 0JEC2yYqnUffQtkVcbrWC7VwzWVPc6h8QLjw6qy2vLbjXI7WnyiG8YGs+xo5qoul+Tcjx
	 PbgPMhPnYoH7889nC2fqOzT8As//dvVjQiTMxMZPFefeh+f/m/7MkI70Ov6kvZCPkvQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KdnbLhr1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793381271;
	bh=HKkpuMss/LYf72MUN7LyJQ5C0Jt9d4xBRxygY9btSCc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GxiKJGdO117xatlEOgXa9MQViFKqwOsZyQLNaAxgZmqhMxYsIEsgEal50uIAx6xc4
	 PknlUOXoM8Zci5gU51SxiZ+YwYAxVpNH6ia2CiQadVYSRE26gZ6mOJcLZ7stzsXzd9
	 EYFAZ+wCnc8ue2dkBFyuqgLVkC/QV8Eftkle0GNn2scSqxIh4Yz2o1c5dapROx5rwq
	 CjVHRuH1eacEoqIFTLxvyWHHliypgvU+pNdqHQEoohr1kIRqR3GgPRPzZqRLdLm8tJ
	 R9XYgLyjBVvV7kUUDkxcK1CxLiKx8SppTLx4hbioiP7jB/GG7VJKLmgkWiX/M5tvCE
	 D+vpBNTd3iqhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4F4F81698;
	Fri, 30 Oct 2026 17:27:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 549D9362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:27:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3AB2D81698
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:27:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7-6JcXUY4WK7 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 17:27:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 00595813F4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793381269;
 b=bJ+hK9nRfM9gG5zKpAWNCjYMv/1p+P2h1L9Y7ChWJ0biDQs6fS7kKjfDzU4O/rLvwJ+N
 /7w7KVPYxpEqcb75ygg+0I/l2GmGriXdQgSCHrt06JQIu1vILEDvzinvUJJock6vzhZq1
 eq5bFFhMxzcAhADm+CKhdma9iHDmX2KJEYf7FURBN+hKghYE4AZ8bhoaPB8yWiwyunTTe
 wzIzqhg1mCkN26YwDwWJsL9qh4jPdz9hN8LZbcovnHAe7r/gtJAmPn4BKhYVMtsGgdwP6
 QlnHs38x+jz5Qfa0TP/LZCDjGeEokznG95/fE1F2co0qsQPxt1f6p9BYg/D3U5GExvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793381269;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=HKkpuMss/LYf72MUN7LyJQ5C0Jt9d4xBRxygY9btSCc=;
 b=OOv0IerbHImtHMKD6j5jlz0VripLwUgemd1tKBMtxGQ83xExvsfest+BTyy6C5kz8kB3
 0Q5v4wZ6tcGoGXIm/zPgW4x//z6wexWIN1/QwiKpDnCshZdz84QRIPJbKpj5MlY3bZwuq
 eHYRjr0pi/2iKXEgo2+FtM5wNHlPJGcrk7gh9iRHbx1rMpojcsFY1/tBqcHqM19YCsyEA
 2Mh9ebk0FPrWWuXhagNnxarao7QnZbJsea2v7994HU/XMRjHzWWyT7syQ36yRZ+SHNrl5
 +Yf+HIMtfEDZQGFCanKn5rXnYNqc2y7x8+MDri0vCalU4W3JndqHoJUkxt5rPPivQvA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KdnbLhr1; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KdnbLhr1
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 00595813F4
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:27:47 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b47c1a3c74so1240582a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:27:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793381265; cv=none;
 d=google.com; s=arc-20260327;
 b=DcQ5qSPQBrheEVVE12O5UCo6fVmTUjVMXp5jcfQ8KzElrw2sqto6ysd1BHCPSH04M/
 VtQxfM75HaFMYX0bVL/kGK0FxrwIwx7x0/Ose713KN5AeQ3q3xe1LFpYO/5j99h4YQg9
 SzzYvfiytgi/pkICrgFgDANRDCJ5y+R0sRTdz1bbJdcswkiiTkzqFMC0OCuBHEjNOYI9
 hwPNNw5500fyMRetnVL2aThCV3djLWI8kUaYMLwjwuLoBIzu6E4ydLgiELr7LwhrETck
 HK+wxPkjoOEE2j00+zECHaFJPXrOYXqEHW+ur4IpXuvhcdmcNK2nawDjEmaFucV7Ym4S
 48Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HKkpuMss/LYf72MUN7LyJQ5C0Jt9d4xBRxygY9btSCc=;
 fh=dTODIB8eOV8QmMXTO6NS9hJAq2JPVHLo51odT60wrm8=;
 b=OV4I9c1AlQs4U9RW3C/5CCD6hJK1FOrKySL7Zv1j+xs5g0MbNjYRnj229gvxXi+7TV
 WSl7NcncaVXrSZAMK+oYiJlkXss43/4zvieV3OsXiTWx/EsOI5w4c+jj+YY9jnFkYeR5
 ZN/raDWIjKJvi5G7djuuTSg7rLpUI3L3ylbaftYuZLkgKEhqhffmXCZyqzQfg20ztpya
 BLJD0kVw4eLO9M79H8AsbZMX300qo+eq4Rcg3sTpg6GnqzA7BT128zUd9IOiP1g2V99J
 VfA34JML0lcquODOXmK3W3DDF5dIOSl6VXTubNUe6wGhbBsesCGbrl6f+MAfRt9MheQr
 pjbA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793381265; x=1793986065;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HKkpuMss/LYf72MUN7LyJQ5C0Jt9d4xBRxygY9btSCc=;
 b=KdnbLhr1V3D5h9GZ95IIpOHcyVVZ7qpk/hh52DAjggJlM6HLyb2WUU7WwoW/vIsP5T
 jqAD25cxeKR7eOqkq2i3NsIzsGn5xtpHnSb7/tIm9w7s2c/SSdn7CnifpRIw7jRa7VHy
 R5Texrnx9PMdcWFJQS2aF82qMDsRluySN7rVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793381265; x=1793986065;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HKkpuMss/LYf72MUN7LyJQ5C0Jt9d4xBRxygY9btSCc=;
 b=zSqeiQUAoc7jYjdvv0JeRPgehWP4qD68kyzAeas5Jkq/NDaJgEFvHCMKpiwSIETK4H
 oZqqIEfs/st1uexNeGvC7L/7g6kKVB594nmsT4+4nwfsTQRIfBF8pVRtbCKwg24BRxwI
 bgNrG7bBuTNzk7pIvuClwj0SrlUVXDFI82tIeWMr9N4kjUuMSqMdmNyQtXAOUMYwGv9A
 IENr1eVBlvbcaDaym45LZ/duEwLSea9SsXbEG7rqT2wOPibHYQkfv+c58WnJw1+wINOE
 3o9VBP9J9556BJ1p4m14w16263vNB3uS+MXTf1YHrAY6hEPpd/gcGrpuNYXWOfzgctY4
 7cOA==
X-Gm-Message-State: AFq9FYLUk5C2boN2MRJvm4ptGbpxsjlYxSymg36GBq+bGH95lYrslGWZ
 g9g//Gh99y21yI9zFgjuVhFjZOTZbpNyAdwJdeftZ4Kp97f1LMzID1PESpKluUtfbSL+EojhnbQ
 7K8kmSuzZCbH6fX/MakriNkKdekE7VFhUo9IqwxuOdIMIX0hEKVouSQ==
X-Gm-Gg: AYBFou1axQaPb3yAom/BsuBe5GBXbTLvtgTORz3wD9M7dZkPSQtPIVUzkgBsbopdsOj
 Zk0x93cwgQWabyJpHUjOm+8K7kJktXI4yczLfcsaiy4Q5DBecYsMoufvYfNH3Rh6RFkMB8jg1Rx
 bz4HUUYHuWlcVY4MAruzWuVSJOHFQIOgTwdtr70uOZ1cDWVSyum7G6nQKXoFYYf6ndvTilD/B3s
 JTr+q1Age/8mefkR7puFeMbRRimSPXavVDgME18SgBPYOb28rhNCnVwVyRCfqdimSd7NXsGHyxV
 XMGJk7oGtIS/I3vmBE9Z0IDyb2hLeLh+uxE7vg2jGIh5p5coUlev2iyYpzjKvuJk67Bz0do57Xf
 03dyvCSH6rlJqBFY/Xiy9T16OmqUyBgSTfLfq61XA0P5CCjmWquMkmbr2uWtTBvIc8wNKWh8=
X-Received: by 2002:a05:6402:1484:b0:6b4:878e:64a3 with SMTP id
 4fb4d7f45d1cf-6b4d543fe61mr1620211a12.45.1793381265431; Fri, 30 Oct 2026
 10:27:45 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <CAFLszTjBiTtKmjgknvXGFBrphh6kpBzRg8iroWjFQ0EDvuXTyQ@mail.gmail.com>
 <c00fd65c-338a-428f-bf4e-eb28e463d914@kwiboo.se>
 <CAFLszTjKMRjF7hmEt6_bbnsRpi9Q=NHidRQC8zv4ToUEpqBarA@mail.gmail.com>
 <582f30f6-7d5f-4dd5-a8c6-60d027806786@0leil.net>
 <CAFLszTj=yHHYYojiX7TGAiFZun7qWsu7zO6awfLdWwYF8HkQmg@mail.gmail.com>
 <20261027162712.GD2177077@bill-the-cat>
In-Reply-To: <20261027162712.GD2177077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 30 Oct 2026 17:27:33 +0000
X-Gm-Features: AclHuK8QjoWdPAW3bvJ4BjPw_zcd8d0h0yqYEYbmybocVMrcN_RU1sTVWtmZdCM
Message-ID: <CAFLszTgng+4ERbALFKRkXRoT+q=GLJthX6B7+bvq2F0ehWNO+Q@mail.gmail.com>
Subject: Re: [PATCH 0/9] rockchip: Remove unneeded syscon driver for RK35xx
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
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

On Tue, 27 Oct 2026 at 16:27, Tom Rini <trini@konsulko.com> wrote:
>
> [Big trim of the CC list]
>
> On Tue, Oct 27, 2026 at 09:06:00AM +0000, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Thu, 8 Oct 2026 at 23:53, Quentin Schulz <u-boot@0leil.net> wrote:
> > >
> > > Hi Simon,
> > >
> > > On 8/7/26 9:46 PM, Simon Glass wrote:
> > > > Hi Jonas,
> > > >
> > > > On Tue, 4 Aug 2026 at 13:57, Jonas Karlman <jonas@kwiboo.se> wrote:
> > > >>
> > > >> Hi Simon,
> > > >>
> > > >> On 8/4/2026 9:19 PM, Simon Glass wrote:
> > > >>> Hi Jonas,
> > > >>>
> > > >>> On Tue, 4 Aug 2026 at 04:57, Jonas Karlman <jonas@kwiboo.se> wrote:
> > > >>>>
> > > >>>> This series takes the initial steps required to try and remove use of
> > > >>>> syscon_get_first_range() or syscon_get_regmap_by_driver_data() to get
> > > >>>> GRF base addresses at runtime for the Rockchip platform.
> > > >>>>
> > > >>>> The GRF base addresses are fixed and known at compile time, yet drivers
> > > >>>> keep trying to resolve them at runtime delaying some operations by
> > > >>>> several ms.
> > > >>>
> > > >>> I suppose all addresses are known at compile-time, if you have a
> > > >>> single device tree. I have always hoped that we might end up with a
> > > >>> generic U-Boot for rockchip.
> > > >>
> > > >> I do not understand how removing these unneeded syscon drivers and
> > > >> helpers would stop such goals or make that any harder. From my point of
> > > >> view, they are currently making such things harder and only adds extra
> > > >> code, runtime and energy waste. E.g. around 227 ms was wasted resolving
> > > >> fixed known base addresses for RK3399 last time I measured it, see [1].
> > > >>
> > > >> Most drivers or any SoC specific code is already identified using a
> > > >> compatible that is SoC specific, i.e. the RAM or CLK drivers are matched
> > > >> using a SoC specific compatible and seeing how all GRF variants are
> > > >> unique there will always need to be SoC specific code to handle the GRFs
> > > >> base address and reg offsets.
> > > >>
> > > >> And for drivers that are more dynamic in nature the DT typically have a
> > > >> phandle to the GRF syscon node anyway, so getting it from the phandle
> > > >> will be a better option and closer matches how Linux handles similar
> > > >> references.
> > > >>
> > > >> The biggest current blocker for a more generic U-Boot proper on Rockchip
> > > >> platform is rockchip_get_cru() and how it currently makes it impossible
> > > >> to support multiple SoCs in one build due to how it is used in the
> > > >> sysreset driver. Fortunately, I have a pending series that also cleans
> > > >> up the unneeded rockchip_get_cru/clk() related helpers.
> > > >>
> > > >>>
> > > >>> I wonder if there is another way to do this, perhaps reading the
> > > >>> address once and caching it?
> > > >>
> > > >> I really do not see the need for that; it would only make things more
> > > >> complex than it really needs to be. We should use constants where
> > > >> appropriate, e.g. soc specific drivers/code and use generic phandle
> > > >> lookups elsewhere.
> > > >>
> > > >> At least that is my end goal with this and pending follow-up series.
> > > >
> > > > Long delay while I took some time to look at this area in detail.
> > > >
> > > > Pre-relocation is an area which I sort-of glossed over with the driver
> > > > model implementation. There was talk about keeping the pre-relocation
> > > > devices around rather than recreating them. We also looked at
> > > > providing post-relocation devices access to the pre-relocation info.
> > > > Over the years we have had discussions about having 'simple' versions
> > > > of drivers (that don't go through driver model and perhaps don't use
> > > > device tree) but no one has made the effort to implement this.
> > > >
> > > > Anyway, after a few days of hacking I've come up with some
> > > > improvements to the existing code, at the cost of about 500 bytes of
> > > > size increase. It works by using slightly better algorithms for four
> > > > key functions - fdt_parent_offset(), __of_translate_address(),
> > > > ofnode_pre_reloc() and lists_bind_fdt(). The result is saving on
> > > > firefly-rk3399 of 230ms, about what you are getting. Note that I have
> > > > made no attempt to enable the relevant options in TPL/SPL (it only
> > > > saves another 13ms), so your work is mostly complimentary.
> > > >
> > > > The key difference is that this should help all boards, not just
> > > > Rockchip, plus it still uses DT for everything. Tom doesn't want me to
> > > > send patches at present but I did write up a post about it as a way of
> > > > providing the comparison. [2]
> > > >
> > >
> > > Please refrain from pointing contributors to patches that are
> > > written/assisted by AI/LLMs as those aren't currently welcome in the
> > > project.
> >
> > Do you have any update on the VBE series I sent? [3] It was written
> > before the AI era. I believe it was originally sent 18 months ago. It
> > is the final thing to get VBE running on a real board in mainline.
>
> Your use of AI is not the reason your patches haven't been welcome.

OK good, that's progress and I've noticed you have been softer on
AI-assisted contribution on the list recently.

- Simon
