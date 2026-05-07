Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184D9CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 17:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8608384B5D;
	Thu,  7 May 2026 19:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ThLlT1hu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oe3EGjQp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4718484B9D; Thu,  7 May 2026 19:26:04 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C911984B42
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 19:26:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gBK0T2JMNz9tyq;
 Thu,  7 May 2026 19:26:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778174761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AcogELaiuxo2zdTS54zw6+KqG7Pjxt4BMOz9JQNJn9o=;
 b=ThLlT1hu8cSljma6j1FX7nguCyx5n7A0LcFHiNkG+zVbiNwm0Giq7MaT+KUXqeBdCr83gd
 61evhXnsZOSOnhjfRx8yIQcDOWOi0VEZrIpx3/hQwoDWkVAWfi4deTKRmObYZrBozMqlFy
 EUP05jNjK7DCLc+Nywix+7MMnmE4w1ShKkP3sfyCTb3tydqS4HFQgMIgEb+s/5GirJByJu
 mV1njRr8uBDdTfXFS6z7Q3YTVR86bOg9dUT+9k/WXk6dns5GB76eoU6JkhwtQ1xyR6HaJe
 4SxBEHPuWsfWbLk0Ve/9jdCno2hgc0tdJNWam+p2cgitL+RFTrCJPe0H4QHV1A==
Message-ID: <fa4a37d3-1eaf-4fbb-adf3-034d2556d2db@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778174760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AcogELaiuxo2zdTS54zw6+KqG7Pjxt4BMOz9JQNJn9o=;
 b=oe3EGjQpK8nrsssFKuelDYLLNmDhomnZugJEd+nvRqkVSWo8I85MOHaQxCdQNeQMMa3twJ
 Jl/34mlGT3PzbYwx1TfynSuC0UapLorPMT6LWwVnPKGAhfvWqwox1lwNbaNah53PCvmbA+
 Vth0OhiOhNQH9Jn1cWNZrrUoIP/jv6C9SfqRxBdjdUFqrUhzegpyKotseqVLUiLbOwfJ0l
 KRJkonJssKWKREvzAnJqR9RDQH0/aHTvmPuETkIUa7zfGb6un18nSe59nYDzeH6XnYrJIr
 uDMASYwfsjTv9Qw6sU5mfZaZkSJInqrrbnH2xO2QLSAH5sLuTAYnWBe4l+JZ7w==
Date: Thu, 7 May 2026 19:25:56 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] usb: dwc3: Fix crash on fastboot exit due to incorrect
 memory free
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly
 <casey.connolly@linaro.org>, Chris Morgan <macromorgan@hotmail.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20260507-usb-v3-1-402b37fc2154@oss.qualcomm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260507-usb-v3-1-402b37fc2154@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: cefc67840f392ee3086
X-MBO-RS-META: 4595syuz841cughuxysnr5978hguu64i
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/7/26 5:20 PM, Balaji Selvanathan wrote:
> The dwc3_free_one_event_buffer() function incorrectly called free()
> on event buffer structures allocated with devm_kzalloc(). This
> caused heap corruption and a synchronous abort when exiting
> fastboot mode via "fastboot continue".
> 
> Device-managed memory is automatically freed when the device is
> removed, so manual deallocation causes the heap allocator to access
> corrupted metadata.
> 
> Fixes: 884b10e86a05 ("usb: dwc3: core: fix memory leaks in event buffer cleanup")
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>

Did Mattijs RB got dropped ?
