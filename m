Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88039C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 13:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E7F87BC4;
	Fri, 15 Dec 2023 14:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=longervision.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=longervision.com header.i=@longervision.com header.b="RUi4V6Gz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B00887B60; Fri, 15 Dec 2023 11:46:26 +0100 (CET)
Received: from mail.longervision.com (longervision.com [159.65.68.90])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E36487695
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 11:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=longervision.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiapei@longervision.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A8FC38731D5
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 02:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=longervision.com;
 s=dkim; t=1702637175;
 h=from:reply-to:subject:date:message-id:to:mime-version:content-type:
 content-language; bh=IX0GRgVpInyBvy6xDsvH8ZU97tEKd1DqwKDcIwdQIR4=;
 b=RUi4V6Gzsfqb62S/VeMrcw/CVf1miWetw5WW67VvhDcrKefLEO23slOg/5iuSFY4pA19U+
 Fnlgg6jLhh7cmzK/AaqSsADDWkeNEeinFmr0CCqvQHuNQ0J55IXqiIbtyr/RpU9b/hNke5
 1VU5GhuaYde0uYTK3xVugDSzS/NqrviTc3CTJQFNKHoJ1F8TwGOPB+cg6Dz3CoE3/ZmwHR
 Pf9rZXqyuBCJr5myVwqSh+Xy4i7RdHnYYOEdPhI920bbFOAF6rVNGOIlSe9rBomkv2mEzi
 nI8RTZCXP26IAEh43iCta1UIfBhEeqjzoXHaDsNiywXmvKHX7gcxftxw8USvYw==
Message-ID: <5d800e23-e427-4198-ab24-f2e1fe595c4f@longervision.com>
Date: Fri, 15 Dec 2023 02:46:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
From: Pei Jia <jiapei@longervision.com>
Subject: Where is the u-boot for BeagleV-Fire?
Organization: Longer Vision Technology (Canada) Ltd.
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 15 Dec 2023 14:15:15 +0100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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
Reply-To: jiapei@longervision.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


Where can I find the u-boot defconfig file for BeagleV-Fire?

I've got an issue posted at 
https://forum.beagleboard.org/t/error-illegal-operands-li-t1/36823 .


Thank you...


-- 
Dr. Pei Jia
Email: jiapei@longervision.com
Cell: +1 778-863-5816 <tel:+17788635816>
Website: https://www.longervision.ca
