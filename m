Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE4ACA5FCE
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 01:27:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 514DD6081E;
	Fri,  2 Oct 2026 01:27:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Esa7H57pHnU; Fri,  2 Oct 2026 01:27:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8663860C34
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790904469;
	b=l13p4gozoGsd96QfFrNdR0UfwSrtw4eOWk7DDEXgZc7+OJyhuNZQMjabxf2dYOdX3ZNQ
	 gc0zgvgOjUDj/HkfyCnIu2EjhQjvdcLgOXo7nUKGO6psLeO72uI2DHDsFwJJbLBDiAPoG
	 gc2vc6grDl0gdc0+MqQfIAArhcH5lncga9wCE0Kcb9xzt7lfE45W/euKkaY2YoyL49CNd
	 wcwh4f1gYwPDdr/F8pTBbTwMhj+XtTq169hj2Hib11bLLvbFMzDolV3RUMuiBhWtdCoMz
	 KvQWxg/QAUBeH1DwCTln9e8m0fVEbSSKVgAdUrsWLuhIGMwz5SBx4ejR09SPb8mDP8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790904469;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Xo/Bsh3/FH3F2aGxcq75VfbQiCEcZ+sAHDXvc4J7Wqc=;
	b=L+6beMuIqdwxYelFjuG/o8eoFLliGMPDxfAXaXwiYQrHHXmbOU1Awgon9lyc80xiULHC
	 Y3r+zwO3eg1tiQNvTbbxsok/CC9S+1dXCHTWGlD3EI4JUX4xfDjgEpUC4dswCmVM2kw5R
	 mkdZiW3DooZW+vJmhrBh7VNNXony6iAtuwnI6pSYQcI9wR12evV8cSi85GuOFyXCuF07/
	 ZSR/rxraALFQ5a9376CCa6XjHBwP3RQ5sgwM74ZAbMeF9eQvmLX/2V8XQ/5nc5LdlFZoS
	 s6DC5MQsK4i1Abz9qznQZ4nUNR7ZNwz8Fn4D/ws5dSXjILOb8kzPval2mF+AZuQHrhA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790904468;
	bh=Xo/Bsh3/FH3F2aGxcq75VfbQiCEcZ+sAHDXvc4J7Wqc=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ulw54AbC9k0E+fmAx0UlMTWjYHWR1SWZobf7AKqgUWSm2110xOzTUDjLKxbR+ZW2c
	 yDOcF18ypkXbv9wd827pt69wcKFMhwQCMMQMzDKSF/J8L6UNBxm5eGpQoTgyEM+PKH
	 RFdkD2SmB0dbdN74QzMUcz9p/MmVttQCWvkQu5owPmACflj/ySwoCIHxxZ+HTkavv1
	 23W+kz2pX9hNFyT0A0pGcvxR4wJ5fzELKbxDiqELHZD8GNtX4YzWL7cBiSXqQWCO0v
	 YYU3EjAqmiva4DNQgxpG1p9Ly7BHD5Mx1aSxAY4+XdScfNQmh0M0s6ib8VTlnyf7lt
	 heD22FlIzAvPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8663860C34;
	Fri,  2 Oct 2026 01:27:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BE3A432F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 01:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B032540062
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 01:24:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9-muDWG_Q0o9 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 01:24:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 33AF1400AE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.27
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790904253;
 b=F9k/ifue6L4jTeww0I0uSiE2kysrd55p37hTwfJRmb2vwFZWXJ9X7cACx+0M3J5Pambn
 biv7+bl9ZZ7+uOYznO69l5ibmZFNOm87uTnYO5cqmkXMC1CqvISVdYNRmrYpI3ZIedAPc
 ElooUiPf+8RPl4Uce8owebfUiqv87xLmlpl0yuwygbyPtsWUT/G/QGMY1Gt2yL66nkcrp
 K7XgDkFqRPF+otzP+zVwKiR6B6P4NevdVVj7p9hCOoUYIJuUWkIBDWCfQxqeSaE+8+DcX
 NmQgi40U7mFWF903XD+3sgTK7y3kF8sRRhlN/V3rc5ESqzbHcXAe7mMs8xc0HUIE3nA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790904253;
 h=X-Greylist:Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:
 Message-ID:In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=Xo/Bsh3/FH3F2aGxcq75VfbQiCEcZ+sAHDXvc4J7Wqc=;
 b=DDjRwEwdrFD6ROXalQfZz9vZH4fl/NczJLLN3DmY+/d37MqmZHFxROby9sTG/l7MdNZv
 L2Dk2+lfYwKBfsa0OrkEB16gfHRms5gTGkg6/KjMXHNFsMRXPfTMSssQWNXG2eucFAvKM
 KVevBKt3/FJ1FDqpi4I17htLp9R1NFC0dX4UGGTRP13UIDtwZkIC6LxPYy4y7ex6HoeL4
 gQddQ3RGVbJnGfPfoxf65Fc1/wrnaTPOzT3qT12pfQdFiiggZHXAkmG0c02IOQ1nT6Gmf
 qSQad1KqYJPesIH9qNj+z9CunhujqAt+FAdRQprBU0mZLnfFIlRmHgQZJn3Kxsw4tNA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=proton.me; 
 dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail2 header.b=JgwV3lZF; 
 arc=none smtp.remote-ip=109.224.244.27
X-Greylist: delayed 68954 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 02 Oct 2026 01:24:12 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail2 header.b=JgwV3lZF
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.27;
 helo=mail-24427.protonmail.ch; envelope-from=hystericaldragons@proton.me;
 receiver=<UNKNOWN> 
Received: from mail-24427.protonmail.ch (mail-24427.protonmail.ch
 [109.224.244.27])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 33AF1400AE
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 01:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1790904248; x=1791163448;
 bh=Xo/Bsh3/FH3F2aGxcq75VfbQiCEcZ+sAHDXvc4J7Wqc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=JgwV3lZF+k3u+HWWXoN/Qj++kwFuu5sWtM2a28qAWLr8j+FG/RLcByjVyCyhR94LE
 EyKiBaXx4xLdc6keSHQpWcgL94GpWiRHDDXO6gQLunq+HIGh+UZay5qEySiFwBtZme
 6dTf/QMZTqUhdCHrTNq+kSHvCeYb2F+6ZnBsi3o0AcX7L4gPUa7RLS3jIgvo+QpVAR
 pxgDm0eUihK6buV7DRC7HIdCaKEZ/l0hgj6ksOuyyRNe0lQ2AvAeaNDMQ/1MbUBN4d
 mYcDd9wqyt2E3DJIGKpzzTaA9FuLpkkphqCu/Gafmf6ItpQJlxukjKRPlzN+prwrVU
 wPsDEyb5DqjlA==
Date: Fri, 02 Oct 2026 01:24:06 +0000
To: Quentin Schulz <u-boot@0leil.net>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
From: =?utf-8?B?5a6J5a65?= <HystericalDragons@proton.me>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [RFC] rockchip: rk3528: NanoPi R28S support before dts/upstream
 sync
Message-ID: <wZ90PLwVcDDHWjgk7robBmaw1YmdSxF2l4qP0CirT50SG0pcnFMha3Ahz00Hzo_ZyZd5DGXiVDruI_ic8UhKYUIlRcDyCCy8LrH0ZtulEnY=@proton.me>
In-Reply-To: <be3cd318-cba7-4c04-914b-e859c222ddaf@0leil.net>
References: <OjXy0xMi4UhaNlSDbglwvkf_FXX3Kg2TzBsaucWmd7YnY4tVJXGpdp-sUp-mApm8Zh9935uuKq1jhneCiItNCisIRiN66zEG8zl1jiGBFMI=@proton.me>
 <be3cd318-cba7-4c04-914b-e859c222ddaf@0leil.net>
Feedback-ID: 91982645:user:proton
X-Pm-Message-ID: abfb9da65507d34aad2e6d367e630f8efa26c9cf
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 01:27:44 +0000
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

Hi Quentin,


On Thursday, October 1st, 2026 at 5:18 PM, Quentin Schulz <u-boot@0leil.net=
> wrote:

Thanks for the detailed explanation, that makes the process clear.

I'll prepare the series and send it for review, with a note in the
cover letter about the dependency on the two devicetree commits. Once
they are available in devicetree-rebasing, I'll pick them with
tools/update-subtree.sh and include them in the next version.

> https://b4.docs.kernel.org/en/latest/contributor/send.html#authenticating=
-with-the-web-submission-endpoint
> should allow you to send patches with b4 without your own SMTP server.

I actually used the web submission endpoint for the devicetree patches
on linux-rockchip. As far as I understand, though, it only delivers to
kernel.org addresses, so it can't be used for the U-Boot list.

  https://kernel.googlesource.com/pub/scm/utils/b4/b4/+/9186f8a042abb29c90d=
b79fc70967d0d88236d10/misc/default.conf#27

> I have seen some proton.me senders for patches, are you implying they
> are all paying to be able to send patches?

Yes, I believe so. Proton Mail Bridge, which provides local SMTP
access, is only available on paid plans. I'll subscribe so that I can
send the patches myself.

Thanks,
Rong An
