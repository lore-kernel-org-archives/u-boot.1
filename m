Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13881C9830E
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 23:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9896E6061A;
	Sun, 27 Sep 2026 23:06:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id suW1RpSpL3mw; Sun, 27 Sep 2026 23:06:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CFD7160613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790550399;
	b=a2s3Wo6qJgLpMODSEfTy0DL/YjYsIVlBntCNmiLm2cufQT+PCpKxBPI0IaM/F06x164p
	 Hjpioiaix5hMmqwoRrTjQa1fh00XPusJQz6k2x7S3bkfbbD0jd82NOfVp8XWzTu++CqJR
	 UMLH+JlKy1jzVGdKchIkjYnr73KCh7839tqA9FTiTN2nXlgmQ6afeSJm8xVKPkH3aXfCj
	 9qRUdvke6xUPLw4G7FvQ8CRoIIrAn1sJuqA8VIpE14b+imeJ9Q0FNVV5mIQLus2KPBI9J
	 wHj9eCAJoCkcwLXWnWCwFNZSELAEDIgI0ydl3MH3AzdfxilOSWyAPlW6niH/PySwL1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790550399;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nH3+/VXybg+wc4O2+O2mpnybt4i4agyvaKD9mrgnq7g=;
	b=Qah6Y4CREYQEbNl/cMo6vc3QvJryfK8diaQkfAkWxjGtce8eOqMnFmNnFYNInYgT4fFe
	 bZD4sXlmu2clJczq6tiufSZi29UEKmFpxjSK1D9IkrYeL8xje8zWSoHTPDcHhaPWkey/m
	 S+NEmIiWAzSHoPVxdApR/eiYjjguhtyRwfN0P196jGWR3IBQFaxFCwZpOFJb//RkHzMeK
	 iGdqnlyvHxDRz8epGE2Khr+RzwA9v4A4PR+lsvS/zuGi1IdK2dc65xqTk9aAJ4JU4WDtL
	 QzG8Evd/D4IyOA99Svyov5Q9UkLbTdi63ZYlAdGILVjz2BaneY3nVNvaTIwioHvLvxQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790550399;
	bh=nH3+/VXybg+wc4O2+O2mpnybt4i4agyvaKD9mrgnq7g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VnKDNBumvD3Ldw6KVGmRdPnTatJ2t1TTW2bTlQRr0yEss9yU+5Clmjhk/gPosBSBe
	 6orKrEBNEh4DFRRrPBdlQbQUxq0Svcf0mztjt6ig+F9yWhJZdTdzRaF77gJ0J/xu/m
	 +gxeQXWYCwQv4Jl/Y4H8+o2hIEQ2Hf08t9D6D8QUK5mqTlXaPVd7uIe1osf7EtljNA
	 Z9IVOknqjORUEo/fPfk30bIem/fWP+uHYgYdrIAVlHtsIKksQu2DA+MZfh0pcXuMpV
	 0vbZOECfMtH+HHsmAYQNVbrRpyJG2eiikwloq9r0XWt0sq1M464H0B1TzuQ9JIo1dJ
	 nMaMOiTtiy9gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFD7160613;
	Sun, 27 Sep 2026 23:06:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22708194
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 23:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F3A1A406F1
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 23:06:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6uzz5YG6zjz6 for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 23:06:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 475A34034F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790550395;
 b=YmwzIwZth3TDF1Vc14OaObvXMSmglVmE3rNNH+S2rzPfWzmoOVcoyyjfKrSp4v8dke09
 btcipfGkPYGd0hs2NKNcdX3x9mhl9oJTh0XNB45IJcCLVuFy9se8DrrASmADc16TrhEOz
 YHneq9CQxBKJ13h4+1ay9PBJeePXHz0FHpD/tdZZX3Eh/DKagIwfmfZbtESuDtoc2OXCF
 XWSYhHnpUlribFCjRNNAX7zNLp6hdlH7/BMKj2kLMUneNRiHa+j+mR9AAz9XF+h6Lng21
 ygdFiV4fjegBVf1KYRfsjjGEth+CSjRdx185XmcZ8RTMkktsSPnM264sIqV4twCaNUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790550395;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=nH3+/VXybg+wc4O2+O2mpnybt4i4agyvaKD9mrgnq7g=;
 b=Y45zp5QnEvXdsEQpdXRonSJWNYxdh0wVfJbOotHpvycZ4o/SUSQqwZUjGvI+JHvfSB3l
 ruc1GIEk/DiGBdxYhwBhMwdp7terCFVH0rqFBP/VKHWP6CbS6rW2wjWEWu+kVi1uyUPxj
 d+b9NkRBmAnrhJ9s5qzyjEaEiDWJb5gooBpGG43vkKXeSojEf4h29im5nM1Ej514Q0w25
 Kqpk8miFOdUYi6yDE8o2jkNHxLaZIkZDsIxPDTonTVdkC+pr/ogvNlR4X0I9rTgtzQp7V
 6+kaPCFLNkW2/S12c+xlDButL+G6e5AvP6pivuXSYij7E6yUobSdy0J2n/QEpoDXJaw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=b+tTC8bb; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=b+tTC8bb
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 475A34034F
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 23:06:34 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 46e09a7af769-7fcb425fb68so1534644a34.0
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790550394; x=1791155194;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nH3+/VXybg+wc4O2+O2mpnybt4i4agyvaKD9mrgnq7g=;
 b=b+tTC8bbrvaI2KgLaHsQT1x69Kvdkev51UlLmUynMnkosfGq60w/xhMYc0sKFXGM+3
 o/ZkSaLFaw19G1gBhksMF8eF/rwvW2OR8ez68O/WCR43NlR5bFaUVbhPCGRXtuJzfYSP
 38PNKOkGu7Rzljivvt6Eh8VJcyONLsAyGrev0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790550394; x=1791155194;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nH3+/VXybg+wc4O2+O2mpnybt4i4agyvaKD9mrgnq7g=;
 b=zs7YSb/CrMW26A4TgcVHW0f8vyJ5sHnkVBnxlTiXd1j9ucZPrjzivZQzxd4gbjrjc6
 sXFWhfEOeQgINrPlB09NvkLjHY4kWvt6Uaf0Hd+cX9MyxDG2lpWCRt1JUyHEQQarvdh/
 66hurmWbgNo4BRVYDuT8K2S6YVAODvAywzVJX8mqDsfgCep32PHRS000/9RqJx1ks1f1
 CjJYtlJUIwBArVU2ttKvbRBylzPne5V1Z75QUnqHLhSdTY1iU+50UeksMAofM7LlALi5
 EI0Ew+PAnrtF8b+dlBDu1i09pFmzbCQHUgXbAM1WbXohwGcFzZH0fmzsDBgfX/h8yN95
 p5Kg==
X-Gm-Message-State: AFuF++kPzM7jBtfTW7r6XFcI7do8isLmh6qq/ND6Pbq0qJJN2l3oYjeo
 6MQX3FE4WFTqHulyBWtdtxCiRk5dRwqek8NMonEtlDjAhI4NT7GbjHmuZsaINiPrHog=
X-Gm-Gg: AYBFou1470EQB09ywXE+iXMDyNKfPUO/U0FKn8CRSOQiCs6xZdsgO7S0Z7rssDPDYwX
 lvL229yB33bM9rkr4+c6ZmFRj3fUly133ZL3fNptjmuCwaTi8/C5Cg5bgrgHoT8956WiQjuNfiT
 w5ISzR1P2ul0wC7lxFvB2lrQ/7pPZYKieZd1aUFu8u8Fq1ez01mjwgDfok+UUj59nbFl3c+/hum
 kzIrl2w54TU2sGaV+qxv5LmUixmclinqT4q+zkQuxCavGAz/ym+DAMVIQZcySE8kUSRVQMTjc73
 +oMjj1zBQnl8DPSRQMka3wbXTjDF0O++lk67pkSZhWlKrv9u0rzHFWcXDdILyKmvBzLyrzVwCEe
 nSyYFmAISJZlLc361Ts1r+SNukIrvLY0KzopL/OWP2w562FaIL6jYFPbtXegA/qPXfM3oKjs2Wg
 a54YpXYGja0MG3W8kLLu3FCxolgzpxtQpcZr5JDcY5j7rDA8mwnbZwEnh7TVbFjCxAG6AggzNOa
 L4oC7GBzwqL7Dk+XTCN2XoK30DTEBDdD0iOHPWUeXIJbKDyUxjIr+5WUZ3XkW25TO+OXk5YynPu
 a9w0BTAn733UOm1C3g==
X-Received: by 2002:a05:6830:6b07:b0:811:72c5:bd19 with SMTP id
 46e09a7af769-81783684b1bmr12402584a34.25.1790550393832; 
 Sun, 27 Sep 2026 16:06:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81d57ef33b1sm122578a34.5.2026.09.27.16.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 16:06:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>
In-Reply-To: <20260927031401.162410-1-marek.vasut+usb@mailbox.org>
References: <20260927031401.162410-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/main
Message-Id: <179055039263.2255025.10170653037353490439.b4-ty@konsulko.com>
Date: Sun, 27 Sep 2026 17:06:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sun, 27 Sep 2026 05:13:23 +0200, Marek Vasut wrote:

> clk_bulk look up fix for DWC3 controller for iMX95
> 
> The following changes since commit a06e89ab05eaa2b8344d521319399333cd760ae5:
> 
>   Prepare v2026.10-rc5 (2026-09-21 16:12:01 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


