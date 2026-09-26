Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75A5C98318
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 03:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42FEC40AF1;
	Sat, 26 Sep 2026 03:35:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rLYiMiEhoam4; Sat, 26 Sep 2026 03:35:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 524D540AF6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790393756;
	b=ejOHUIGkbcK6nl2nyesncIzpGQh0yLKkAvNuXvyfpODZ6pJ2fEkS82hdjUYb3KCbKU6J
	 e9SQVhbqEQPwY2T4pJafrLkNDjTFnoYVSnTnQXaE4T8Qk8UlUDQhloIyg3f0NrzwFCtkT
	 tLO+OOUldaIjOfA/WAJXti4rlSSSPxgFHwqvVTlO7oPZPtL5KmcM8WPoyqjaFIBtZIWMJ
	 E3b/dTbpfO1v1R7IAn19BiyfbiAuWsVBKdORvkMQxu4d8tGyggV9ZJGclp3PSoFJIFCum
	 Bbhm+0eYWMuhTC9K/lQl9Fp5PrjnYKmoTUV22Y0enCyrLJ/689ARpCHT3HsS0Q29/sA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790393756;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=T9t6pwl0kXomeGKsb5sSFMlBFmwiaBhf+2o3j+wFAFQ=;
	b=fR6B3zxk+q83fGuDAOkrlg+ATii6Kw4ySpGy4Rcnw1cnO6IV9IovZpjwdpYE6vAS8Y2x
	 oSLeqTw7u8CTc+cUSCkMp3pNgxt/YI7P4YUOQ8f3mktRF4aw7EBlV62sobIpimzcVK4zr
	 NM/1g+jaTFauuHX7x1xTVaB8pPtKAHIVYUUQFe8QmpXyfZDtDB05u3KKQAo+ADkVoQTSz
	 iK9677TBWpGHlm3QUN4MHi6s1zhQAIPGIyfK/zNIcfH56yNlaa8dz32cMND+mrRy2PCbg
	 a8EOTJTZyasAn0VePfljVngtTJ0++9hYV+V9m0FzwyDqTN91OWNuC92GlYJ7Vk0wl/Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OrLdMADc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790393756;
	bh=T9t6pwl0kXomeGKsb5sSFMlBFmwiaBhf+2o3j+wFAFQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JGiwDztZDIF1fVFrN5q9Go1O9HhwCKcZfyRGYgXzLSgf1suSsGQz835Z9QsKqzzYH
	 LkZnocp98med7XljAyPS35iFEz24jItHV13cwYneqSRie66740bfrxwjnTKPa7bR18
	 R/Uiy4W/xQ0Mejm5KTRPW2ZrlMIFxy5ehFpGkXq8qKNMNFKX5m8FNoZFI4G8abAfhR
	 NQB3JI7uHim+/ZNvvLfxxGJWehpT7qV6kCxfGnbea94vmx3eo+fV+6sXwaIaJtpIm5
	 NGbjGVYaJbg0nhDSCU8vslDnLqajYHbxvO/bwqaIwTfF3z1NwaKoVF2k3q9CosThp2
	 /vVTDzr4DU+6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 524D540AF6;
	Sat, 26 Sep 2026 03:35:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 47B514B8
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 03:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2434E40AF6
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 03:35:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DltAR6xj87x0 for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 03:35:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 08CB140AF1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790393753;
 b=ilBf70UsPVlZ3KfovzCma5ciaDRmHM3pMDurt4LBF7D+lkPRgktXAoQoVGGR3NC54nkl
 10ifCGNooMCTyqBg8ke4BLsar8m82xuFugOyD2ja5T45N5LegNJ5R9CVJhOtoWb+y/G8o
 z+t8x+gxztih+ohExyiAeQc8ugvSWg9EQTDPcULl12F0xfTbMZrdN/jRuSg7y4DEkPsGx
 T1WqmcmwfmSdAmgnpa3gi15kEuqWy9GQ4iejaOb2W2olG1dKuWqtmM2Hng04i9qsRs8Ym
 kUfL0s+EJNaGs4v+6cnH8lmyZqx7aPN8Eiw1q6cfuaPU1ZHzhD6vrxVwUP3T7jvsOSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790393753;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=T9t6pwl0kXomeGKsb5sSFMlBFmwiaBhf+2o3j+wFAFQ=;
 b=DWil7L2AqGVx36WC8dZiYt8lWKUEx/EYRt7JYnxUGs69KcleRlMjWhkPQbnJji5/KcjW
 f7sto/GADxKX+5nn5HeZffIn+Mb1X8xjZEVyXmXQNUFPsIUCY/ASnaCbdHLaQ6LJDN0e/
 qY7BQ4wWKN1Lnyt/xXuVbPbCSF+3xP3DJEchJsf1pqq5DYir0UsA7sWsxouKYjdUVLewe
 WE/4z4ubpwl261vPRAWY6Bw3JcY4nzYj58bpFd33gy8o2hJIdmGJbycg/ndrJj7rDZ8kw
 zddvjYYONa5r1WOJ+ANyGA/DEKOttxzlaLS9rH5JiXps8Q5ne6kJkvzsGa9YtzHCpdw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=OrLdMADc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=romain.beauxis@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=OrLdMADc
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 08CB140AF1
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 03:35:52 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ab4b93bbe9so123914a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 20:35:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790393751; cv=none;
 d=google.com; s=arc-20260327;
 b=GfvX5LWMCdKFobDUcFYYoFoznXpPK91tPx3XTVwqRy+YIMKnspVM2ieD9eUfM05fhC
 asl8Vk76xXbV8WUnOQttZnCFhruSDqNAjSaPdRJN4oMxekPF5o6U/oJImvrA40BZPqrr
 svCJ+rivMbkUwtj3FFd2H6XhcTPoLycGQiAOaEoVYxKFVTlUXqPdBeFfWf2mvFW5cf0A
 vBWB4Ko2vhmNpeuJZu4kUiX4kWYdjp5arje0oN8qDK81R1gmMlNJzyb7vzAUFctN3BOD
 pJB/FWr0KnkUWvIAcLMVecUxKBzorKSFUp7Vh6DgqUuINx4DY8CR59rzuMi7G9Kp5eUS
 SW3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T9t6pwl0kXomeGKsb5sSFMlBFmwiaBhf+2o3j+wFAFQ=;
 fh=yIE9CgBYLQ3ZvCeWV3cxEF+Jts3RFpCxY/ikp2tgAxI=;
 b=sL3kHTJN0qjKwBz1fOzkDFtaAFCNwaIcv+iFkR/LMlUro5p3YriRAtjXtKx4bX5drw
 cz4quWgbyjPNJuUKGiNxja8ryNEEnvBIsoGXzbUsEHveYv9mJPeZOVMLolMYttN4qNMR
 yMpyWkVm1Kps4MP1Who9qimN74EioISgiDICvAZCSPUfbFaKc7SvQ0QlafWdXzvqTjdh
 jAJZ15KrWkjgweRPV7wukV9DyGKPSsAYmHiAiZHH9wQSd3EkttXP/Ylmlz4EOoyn0eeT
 eXDyxZBvGrX4HCK5JcZjQ+SfQcqL//NEGnhwy/rCAOnl5j3l+w6cw8RIkE7gYcU0pEV5
 bU9A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790393751; x=1790998551;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=T9t6pwl0kXomeGKsb5sSFMlBFmwiaBhf+2o3j+wFAFQ=;
 b=OrLdMADcu6NKZQQna7eVobNDjXFVPb/oYe/h+jP9oZLsL2PrijVX6P0S/ysfUmF4X2
 3hI1gVR8r8l/jncUtCl1jU5qog38b36aSWjrLRmZYLWSnB42NDj9MI0KTqpNrjyaBqNt
 xAKSV4qbMm6IjdVvPDiIWIiC2kEAPPmTFxlUgyJfq1W374W91ojwcqA/iVP7OZVQoqtD
 P+O50fL7lC+yD3zMDntkT5azS5DpiUIZnD4X2jjKtAzAbhg/67vF2CALnVBDGEU0vuuj
 FOQyJbqmF3Th+3nE6GM7iW+FfhBxycD3j3k7ac1uc8KXasKLMoG6Y7/CTyFODaOeTIDs
 VUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790393751; x=1790998551;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T9t6pwl0kXomeGKsb5sSFMlBFmwiaBhf+2o3j+wFAFQ=;
 b=cdAkwUZU8U4MogGKNTnynG53n5GiN+ZNNcFRx6R/V/l07j9S41Lt8A9YhAcZxkmnwu
 1+tIklMfD2k+bDVjrdd+1wvwBd11XgYGFF8xB/aN1tSPdzH/WomWEMP6XoBNRiuYmb+o
 9IdzSWk92g7xzIj5Jpldpiwfk/MSAF5EMxmpBCrTNQmRvWL4+gaK1KwwHVujZztalZjg
 JyCzzBDIkkubwxDnsi9psQXkHfbAURQoF3Vxc4fYAC+8meuIot+jNnu5fqTfavnkZHJV
 NUJwLx00V+gnbiVTrkjo82AG25OomLqcqlBmwZIytyMk2t9SStdOXjfnzdR3/cpXKlmf
 EXUg==
X-Gm-Message-State: AFuF++mBP+2Bt53hKlpTsf7DA78GY8XX+ktIgnrsOlG2MTwktK51qG0W
 pUuFfBZgvtDY+WF2Vhw2sNi2nk2XdR95BQgxMgo5Lea54BBiMgXgix8UCfc671x1oyOxpSrZhqw
 qdhNAe22cpmdmUN0ynjbRC963p9Z4sj0=
X-Gm-Gg: AYBFou0Fn/38yfgnghFbx1qqdtGoyDXC37IDN3INpX89jZp4hHXfvScvN00RFk475na
 kRzNmgZlIc3W2pjQKJMm+e26uiGcRA3MpYTugpg616KRu0JMElfsEAgisRUJ0S9/tNWlq1Ptlx6
 WIelzOsaqexkBd5dnLZKqJV+Y3C3LzM6gbLIa+1PnAoskn+04MdbrEJ/r9foHKXrY8yDBic2pWK
 Dv/4SuhCEH1AUS1tLau/rKt+dqtqdve6kdejj+Em4uDTlaSgQm8rvnAT3ll2U5omGlUByxiiS3/
 AeJubV1vUl0Y36of61tmLxzzbSgSy+/h9Nl2myCerkPt+9oqyn3uyu10fpN+QovmG2wsC0uxeuz
 gEs/DhF5xHzudocVxlbgtzBvnvTh99cTQiNQ/7IcBU4Ryag/Ky3eIDPK5
X-Received: by 2002:a05:6402:52c9:b0:6aa:9dfd:fe63 with SMTP id
 4fb4d7f45d1cf-6aac90dd040mr6890417a12.31.1790393750612; Fri, 25 Sep 2026
 20:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260911203229.25414-1-romain.beauxis@gmail.com>
 <2b012875-7ac6-4c74-841e-b5da14391e3d@mailbox.org>
 <CABWZ6OQ8xqFUQDt8FyODZPzDC=SFOcxr7bDe0eAF5K0OpwTy4g@mail.gmail.com>
 <6c15d243-812c-4674-bee2-7d3fb5671beb@mailbox.org>
In-Reply-To: <6c15d243-812c-4674-bee2-7d3fb5671beb@mailbox.org>
From: Romain Beauxis <romain.beauxis@gmail.com>
Date: Fri, 25 Sep 2026 22:35:38 -0500
X-Gm-Features: AclHuK_4wPA0NcbFE6WQ3UTvI80FyCRobpRBYM33EOk5LPWk_017jnjv3mMnQgc
Message-ID: <CABWZ6OSpK+KA8VoQ_Y7nywXjeUzRLEnfTXa=RWdgKZ8RHwRw-g@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci-dwc3: Add DM_FLAG_OS_PREPARE flag
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <kettenis@openbsd.org>
Content-Type: multipart/alternative; boundary="000000000000836ea7065c5a87f3"
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

--000000000000836ea7065c5a87f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 16 sept. 2026 =C3=A0 23:47, Marek Vasut <marek.vasut@mailbox.org> a
=C3=A9crit :
>
> On 9/16/26 9:24 PM, Romain Beauxis wrote:
> > Le sam. 12 sept. 2026 =C3=A0 22:04, Marek Vasut <marek.vasut@mailbox.or=
g> a
> > =C3=A9crit :
> >>
> >> On 9/11/26 10:32 PM, Romain Beauxis wrote:
> >>> Neither bootm nor EFI ExitBootServices() stops USB controllers
> >>> explicitly. Both only remove devices whose driver sets
> >>> DM_FLAG_ACTIVE_DMA or DM_FLAG_OS_PREPARE. xhci-dwc3 sets neither, so =
a
> >>> controller brought up by "usb start", e.g. from preboot for a USB
> >>> keyboard, is handed to the OS still running.
> >>>
> >>> Set DM_FLAG_OS_PREPARE so that xhci_dwc3_remove() runs at handoff.
This
> >>> is the path "usb stop" already takes: the xHCI is reset, its PHYs are
> >>> shut down and its clocks and resets are released. Child devices such
as
> >>> hubs, storage and keyboards are removed first, and a controller
already
> >>> stopped by "usb stop" is skipped. xhci-pci has done the same since
> >>> commit e3bbc1f74e05 ("usb: xhci-pci: Add DM_FLAG_OS_PREPARE flag"), a=
s
> >>> have ohci-da8xx and the cdns3 wrappers.
> >>>
> >>> On Apple silicon machines the running controller is user visible:
Linux
> >>> does not enumerate a USB device attached to a Type-C port at boot
until
> >>> it is unplugged and plugged back in.
> >>
> >> boot/bootm.c bootm_final() does call dm_remove_devices_active() , is
> >> that not sufficient to tear the controllers down before booting Linux =
?
> >
> > Any idea how to test this?
>
> Add a printf() into the controller and uclass .remove/.unbind callbacks ?
:)

Ok I can try that but I'm not sure if your question covers a part that's
been untested. What I did confirm:
* Stock u-boot: kernel does not pick up the USB device on boot
* With explicit usb stop: kernel does pick up the USB device on boot
* With proposed patch: kernel does pick up the USB device on boot

Is your question related to a different scenario that has not been covered
yet?

> > I can confirm that normal boot does not work without the patch and work=
s
> > with it, that's about as far as I've been
> >
> > Also tested passing an explicit usb stop without the patch and it also
> > works.

--000000000000836ea7065c5a87f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>Le mer. 16 sept. 2026 =C3=A0 23:47, Marek Vasut &l=
t;<a href=3D"mailto:marek.vasut@mailbox.org">marek.vasut@mailbox.org</a>&gt=
; a =C3=A9crit :<br>&gt;<br>&gt; On 9/16/26 9:24 PM, Romain Beauxis wrote:<=
br>&gt; &gt; Le sam. 12 sept. 2026 =C3=A0 22:04, Marek Vasut &lt;<a href=3D=
"mailto:marek.vasut@mailbox.org">marek.vasut@mailbox.org</a>&gt; a<br>&gt; =
&gt; =C3=A9crit :<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; On 9/11/26 10:32 PM, Ro=
main Beauxis wrote:<br>&gt; &gt;&gt;&gt; Neither bootm nor EFI ExitBootServ=
ices() stops USB controllers<br>&gt; &gt;&gt;&gt; explicitly. Both only rem=
ove devices whose driver sets<br>&gt; &gt;&gt;&gt; DM_FLAG_ACTIVE_DMA or DM=
_FLAG_OS_PREPARE. xhci-dwc3 sets neither, so a<br>&gt; &gt;&gt;&gt; control=
ler brought up by &quot;usb start&quot;, e.g. from preboot for a USB<br>&gt=
; &gt;&gt;&gt; keyboard, is handed to the OS still running.<br>&gt; &gt;&gt=
;&gt;<br>&gt; &gt;&gt;&gt; Set DM_FLAG_OS_PREPARE so that xhci_dwc3_remove(=
) runs at handoff. This<br>&gt; &gt;&gt;&gt; is the path &quot;usb stop&quo=
t; already takes: the xHCI is reset, its PHYs are<br>&gt; &gt;&gt;&gt; shut=
 down and its clocks and resets are released. Child devices such as<br>&gt;=
 &gt;&gt;&gt; hubs, storage and keyboards are removed first, and a controll=
er already<br>&gt; &gt;&gt;&gt; stopped by &quot;usb stop&quot; is skipped.=
 xhci-pci has done the same since<br>&gt; &gt;&gt;&gt; commit e3bbc1f74e05 =
(&quot;usb: xhci-pci: Add DM_FLAG_OS_PREPARE flag&quot;), as<br>&gt; &gt;&g=
t;&gt; have ohci-da8xx and the cdns3 wrappers.<br>&gt; &gt;&gt;&gt;<br>&gt;=
 &gt;&gt;&gt; On Apple silicon machines the running controller is user visi=
ble: Linux<br>&gt; &gt;&gt;&gt; does not enumerate a USB device attached to=
 a Type-C port at boot until<br>&gt; &gt;&gt;&gt; it is unplugged and plugg=
ed back in.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; boot/bootm.c bootm_final() do=
es call dm_remove_devices_active() , is<br>&gt; &gt;&gt; that not sufficien=
t to tear the controllers down before booting Linux ?<br>&gt; &gt;<br>&gt; =
&gt; Any idea how to test this?<br>&gt;<br>&gt; Add a printf() into the con=
troller and uclass .remove/.unbind callbacks ? :)<br><br>Ok I can try that =
but I&#39;m not sure if your question covers a part that&#39;s been unteste=
d. What I did confirm:<br>* Stock u-boot: kernel does not pick up the USB d=
evice on boot<div>* With explicit usb stop: kernel does pick up the USB dev=
ice on boot</div><div>* With proposed patch: kernel does pick up the USB de=
vice on boot</div><div><br></div><div>Is your question related to a differe=
nt scenario that has not been covered yet?<br><br>&gt; &gt; I can confirm t=
hat normal boot does not work without the patch and works<br>&gt; &gt; with=
 it, that&#39;s about as far as I&#39;ve been<br>&gt; &gt;<br>&gt; &gt; Als=
o tested passing an explicit usb stop without the patch and it also<br>&gt;=
 &gt; works.<br><br></div></div>

--000000000000836ea7065c5a87f3--
