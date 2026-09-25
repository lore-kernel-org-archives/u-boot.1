Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FC4C9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3981C81309;
	Fri, 25 Sep 2026 13:58:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cObC3DtNo3wO; Fri, 25 Sep 2026 13:58:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3937081266
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790344703;
	b=JlBGnPZCzyGfcywBA22WQynVjaunlXEEEuONo9YRIO/6bz9pHbat8/gQouT/GpzGw3wG
	 H20lCpKBHBAqOurk6Bdq9whu9j82tW4C+y6jCDsh9Z9VXGWmL5USn0XVrPhAhVrGe0wlJ
	 qzCG3K8tqcsNTrsjfuImK5dvOScu5stV/j+bqaM/IJK0t1dxrP4XKIo4C7HHTQcIIDz86
	 EYqjElzYAHslTVVbLNbehoEF0PcB5vkbAWBrRTTT5DhHgO1PdFzOMpVziN9rx0VcIlgL/
	 RI7W3Km/SlUC8eXI/RxEyoz/yoR/4ZKZ4+PxBnc+SBgrffP+OXWCqm/aDNPajB6F4Ww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790344703;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=mbtItvYglE1DUnKRXXZj9p7bCuwZ3RNAuLTDep2rGag=;
	b=cQGdLBj466hbXJZDOmo1KNn/xXVFTT6hH8jV+z5hIKSMoi6ClptzpTdygj7R9GqvIOBC
	 Gl8LyjYVtb+sPZfrXqH5KUOVKlvOfaOWbBsGk4VmQ6RfDYCuRrDJAgJMZ+zLlILo6t3yr
	 l7+Z6W+mSNjLfOJ5fNHeJISouEkdrdhp5hEatg4LqMRKJBO7zIrvIjX8o581FtRzWop5q
	 vjNV8D+V1zjm6UpuLVHadI9uVJqfu1Zaoz2rijHe9WXtn4ccLC/p4G9sE3wJe5mRnLrNp
	 ZnTcKro49DdLfLfyb0q9kOEO1Pe4bC+o1845eSRitDA/rXi8ILtcAiTzwlHPpox8nuw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790344703;
	bh=mbtItvYglE1DUnKRXXZj9p7bCuwZ3RNAuLTDep2rGag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CDtjTdKm6hcEMFxyy6hzvm2id4ndIK/PCfvgbFNil76sL0/9qtapUIVxEWnuxWGFS
	 itofYDuMaUvPeT4moZjX72GGLPB51o2pFjybDIcVuvohPEWR93WBFUYxArbVHuk9LB
	 28JEJoW9k/9RjAgTW/oC9ZHZajQs1XTRFhDuWdjg0rqprx8qS1cNThPsyLftomX6B2
	 f7hyPN81Thv+mxNLSHbspNk251EBlxaKQQ0YP31OIvFnujmzqfjKDzMOSfWve0Y41q
	 muZubUz3wkUe9AS7d8a1aSGyL5b9tBnRzsF4/WoaXZ1VE12kj3tE1q4npSw9Lufq9b
	 QspWLFScOmRew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3937081266;
	Fri, 25 Sep 2026 13:58:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DB0E7332
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C153540CC3
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:58:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CcLN3raf2ZnO for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:58:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E7A7140CBA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790344701;
 b=BIWUi45AF9k903ek7p41cwFrxTnob4V+lb9WUTawn9KrQg0PDMh37QdIhh1gE34YU40D
 XcG+2Q+kmCTid46sPHpO73QFsrV9rGGEJAiIOgfWCEzlQxO75w0iVCq0iipf7FfyLRDFL
 QXxA0sgF81bZHpKEL6e44Jy1utykNnz4ucmGsV0fsCF2qjmRMBFq3sz73nXDYOsc27P3Z
 BWQaca335HBKuyQ+oDf+gkuyxK2uRV8cjYH1NwlT9ooFuBjGUy67ZJaZWIBuJBR1TfE8R
 QHgruJP/G+ownWmioTfehEmsU1v8HjrFZkOuFzoqdZkrGpteMIML9+nNjJojncCRsKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790344701;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=mbtItvYglE1DUnKRXXZj9p7bCuwZ3RNAuLTDep2rGag=;
 b=iCSroAsCDyACk4xdE+pX/74oW4fSc5+JugfN4a4oj7pOGglyyvhdAhuJSJmzPDz8axH5
 u9kvFg1oh3uB7YvSbhQMQYlwFsHNgV1IeLpypfS+wYoRAFyopRxD5xJadn+pvdhQfOAj7
 HRNfdGM7B/PuRtwGJ2c9lEnZQTEj4aMpTn4DHRR2cg/S6+j5A6dqZp1SSXHvxohY+60FK
 wLxXhwHkTzGaPWb6q/y/amjJLUds2oySXRc4WwEVtPQV3yXM7L5OuIkKP123ze7IrOwSC
 cI68qFX60q0c5Q7WF1N5v7tVtlP+CgB0srncTYZEEdaQmkl47SyVwBSiaQKNi5HRhTA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TVtWKKQh; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TVtWKKQh
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E7A7140CBA
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:58:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 777EC4177D;
 Fri, 25 Sep 2026 13:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB70C1F000FF;
 Fri, 25 Sep 2026 13:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790344699;
 bh=mbtItvYglE1DUnKRXXZj9p7bCuwZ3RNAuLTDep2rGag=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=TVtWKKQhJSEV0XHlTDMv9WtO3s0YVWnny1QS0MxLFJURpHCUgRmBiWeZYl6ZU3Ykz
 WbZUtp3vbV5yGi7ylM20oePixZkPui4LugbIQaO9HlDumVt2nQZYTcmH3vubYGJbZT
 +n4G+mFVwr+9lGyUmjL/m63qSWlh0U8vg2pahDwDLetH4OMlR4gGNMPm518Dzgg224
 P41MEs2WvjsHer2lv27wkmWhF8lTcmHKie57Ci69Qso6UonrJPZvm4Q0Ic9u/CkUMK
 sZEpPgVQ7FiMvlrtfGffr/rKm/zZJxTZhZnh824bdP3TdSkLejZO2UHywtUEph1igt
 FLXRUMEqYRt3Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, Eddie Cai <eddie.cai.linux@gmail.com>, 
 u-boot@lists.u-boot-project.org, Shuqiao Zhang <stevenjoezhang@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260918-rockusb-fs-descriptor-terminator-v1-1-144ffc0f3d33@gmail.com>
References: <20260918-rockusb-fs-descriptor-terminator-v1-1-144ffc0f3d33@gmail.com>
Subject: Re: [PATCH] usb: gadget: rockusb: terminate full-speed descriptors
Message-Id: <179034469705.469265.3271151186652933748.b4-ty@kernel.org>
Date: Fri, 25 Sep 2026 15:58:17 +0200
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

Hi,

On Fri, 18 Sep 2026 18:11:43 +0800, Shuqiao Zhang wrote:
> usb_descriptor_fillbuf() expects descriptor arrays to end with NULL.
> The high-speed RockUSB array does, but the full-speed array does not.
> Full-speed enumeration therefore reads beyond the array and treats
> adjacent data as another descriptor pointer.
> 
> On a Luckfox Lyra Ultra (RK3506B), the adjacent interface descriptor
> started with bytes 09 04 00 00. They were interpreted as pointer
> 0x00000409, causing a data abort in usb_descriptor_fillbuf().
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: gadget: rockusb: terminate full-speed descriptors
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/8caa41dc679055819051aae25135ef060399ed58

--
Mattijs
