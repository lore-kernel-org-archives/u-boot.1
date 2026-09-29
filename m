Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088D1CA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 16:25:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A01F940755;
	Tue, 29 Sep 2026 16:25:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9u4xjx2_s8Im; Tue, 29 Sep 2026 16:25:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CFAE740758
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790699154;
	b=Lv3ANhNwpRbQ/uyPqziHklVmCo5OZplceRxwSPo+dFHpOG3iCDlMkBn8DYLDNOivd9l4
	 GVRLjPonWqAufCCuyUb9VgQSj6lhrTr7C6HJZ4sMvbNklKHHPcoBItkyFxv1qpbrWC2K4
	 k2iZ5KceN8p5UMMCcgL3AketgUVT489HZhdQZz1/+elwI75usEPPCJlGuHKszL0ap2B5N
	 rO5uPJBfHvRtIW9zFoXAQbNvtumgVa+bXV9+VCKu/sv/oayTwi2RWyAXNKE1tikklXnWk
	 J92jaEPTU1QhLnkg1TxUs5MFGOk/adGI1XxhOt6eLU4yDNzKs52Krr7fWBQvfuOhzkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790699154;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NcOlOVfJbrPhSxFO/6FOduig16epUDlrvFTc/EIOVJo=;
	b=kWrlBsUejOWhIGn3GADYsuWzXWMyo6AZwVuG3PMcBSpV4KDINYa7CW5J5+7YIp+ReCZl
	 jqGMr+4i/0eRrxX/4KHfgHapWbvGHPjxL+yFttVFa57EfJYxN7DQ5pcWsVfHxxnjEB7mf
	 RPENhALym8tnkL2roATzzAkAl1XoIl0UawPhwzGOmBHegRT65RUCBvWkqupESU61KX3qs
	 d0F/cM71qwGvxo1ULdsWPK9d5JQn6j1PWYyFmdVJrta6gJjAJ9f7djWsZW3/orGTXhH+d
	 yCWnkAvujsiN4G5O5aEbw8SHjzI+eK/e3Kb2uRq3HFQv1qLK0E/zsGV5W/pJLaaI7tw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790699153;
	bh=NcOlOVfJbrPhSxFO/6FOduig16epUDlrvFTc/EIOVJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gdclRsC45E2M8YeTwz1iK4bQzS3Z0ohrCJrC/TTckTx7gKRVGZoyXrmHUfS9XEnCO
	 2OTiztCqXU+TN7ZmKmpoUQhFjR2s/9nVP0ukFTaFf8qeH0wAcqzuzOWYHCKCV1i7qL
	 tY67Q5uNEibamECoPk46WP62nj4do4sznXssIguzeic912Np105avxJfil181gWwf2
	 o+6clgeUatYUMPrFsGhGBpKcZvL2vcgMA7ZW2EVuHOkpJ1nvsExpx326482UV+Prwi
	 DhguiD1ouYlJ0rT4MghS+l8FZVan72i21YI+BNjN0oCm8j4J1B8Wmqjal+w+Y6+bV+
	 emlfptVUP4a/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFAE740758;
	Tue, 29 Sep 2026 16:25:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A46372
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 16:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0FD484024D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 16:25:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q9OmueMwaCzy for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 16:25:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E801A40057
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790699151;
 b=sZTsBFhropmygzaK+Bosqpj0euJmzi5QKoLznGeL34Cv/nI5yKIlP09uzTrWi9knfof1
 s1bvejyfZsK0FvAUyOpghMND8muTVEPC3zLgr6J/Bt4t+ZHMPkxu6DRbxIJmdO48zOECX
 H6l3rJNwinzz0/GxK6qJXa94N1nVvf3F4DjltqynP8CLuHKe4qCM5Bz3BC2a8RR+BnKy7
 GCoa/dBoBNtN9DWZziI/Yd4ph0HyOCNcChLNX7rsNpD8AxY6jQQfTjblUISgr26z7lulJ
 pZghC4UtyPyveDdppN76Ikfc4vhATMPqIaqG3AD7/9b068/OH/4X1w+7xjNmeHYb0fw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790699151;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=NcOlOVfJbrPhSxFO/6FOduig16epUDlrvFTc/EIOVJo=;
 b=DvKCOnkNmZk4jZjzFNzbqtplLIJL31hIluTnj/i49AJRv1ut3+03O+FkrqUQJaR8z2Xi
 oXAZbwuYdXz7fERJ8YmDZDOeRDYOHkgf9K749Fs2Z951t5X9nFSdQrigrCxtxXHgVnhOF
 MvTN/sqC8pKHDxClA6dg7e8ma6zbWlKrLAZWgqpYMtPK7wEFdccKRqlajbHMoScce2BIP
 svgPKKRFcFeMzuvBYnHwqB9wQ8gzGjpZxiO4FxyOFh/pDMY0EJY5/RBrdj/kFkr9O4qg7
 tLt6FxwsZjUjuee1j4tSbWJsuEISJc3hEEO1OOINwfpV1QzVATyUHG+ABFaLrSUPk1g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NHfWuzBL; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::e;
 helo=mail-wr2-x0e.google.com; envelope-from=sochnev.v.74@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=NHfWuzBL
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com
 [IPv6:2a00:1450:4864:30::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E801A40057
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 16:25:50 +0000 (UTC)
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48af0707d41so544628f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790699148; x=1791303948;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NcOlOVfJbrPhSxFO/6FOduig16epUDlrvFTc/EIOVJo=;
 b=NHfWuzBLFIyoDCo1Z6MN49nmEvzfcNvuj4fR/jJg6kIngRUwodEerIvZ6stWthO7KK
 WFySe9xZ2gdYRzCNk826bi7hHr0M79aa1WuRWxWyhJJlT33pboauJgl51vcwR2cTqDz/
 9Cf3pY6cGxarriw81+No/p+WZJZc/jtyaYTE36+HtfDr4pihSMWAxJ871Pp0Fvn8pEEw
 SPB31C9TpnTkatc7oOq1tK1Mna+/Y5NsJHSMp1YE5iXoH0n36FjnN+T1wWauDB6kuPMk
 G3aprXuwRP4Bk/7SjzmPpIhQcb15M6XMfkH5E4dKU3goRnMe4kRwjE0c9UEIwHK64/nc
 7l9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699148; x=1791303948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NcOlOVfJbrPhSxFO/6FOduig16epUDlrvFTc/EIOVJo=;
 b=AiwD8ATh4Q67tCrnsvoHyge/OGmeORq22qe+0Hs2UG1ufs/vQiIKsnAopMWQgVCqFG
 YYrFFbrtK6AvYp5vRKyKlAgyHgzG+sRk/zI9vNDFHHsV/MvZyj5ND5CFdUbfpVTOCG/b
 iej4AVi0I0YN60Xfwdrj40PpihCzsslKt4oC95Ey3lGxxO8/r1/yqLw/3SRIdH3e7j4R
 IzNkXOPD5jS98C+6k06Xx1lJsk8XgXVFyb3mc2ClbVWcdGAWB1el3QZvZT77b1e7uvzC
 YJK1u1oD7IlZrEPK0wZJ56qT5WZsXHOQQri1i76j1jJk42Vdl5DZTGfJ5PAn5QiKit2X
 sE/g==
X-Gm-Message-State: AFq9FYKBPlZLdVRGUt/e0Do4IQORVkBYx0Lj/UVwFb1XmbURndzUWPbF
 42xOlXswNeU7Yeozf7RTKw7H/xINSTR6SjoJK9SAVlk75R59nSQRsYs=
X-Gm-Gg: AYBFou2M/EGFYLv6o2kb0oWIL0jo52MpuZnXyheaLu79pE0JGQoYRuk4yaOu9wecuRN
 3eDj7Ebxfxk8oBJ6T5V/FytOToXdzXcpZOJV/DnZNaUOrP4gY5Il/67d0wmoul5Tltqndw59U4d
 A5ACrmlmi0/4QeN7NgvKfOT6ymrIWYCQMzazSamxgtweKpFPytIxhh7pbs1ADJkex0MKIlPzKWn
 hRzFNtZ44FcyQ3NWYn4oM8Gg0dLQltzutHgY+3SxOwrLXcALkJRkSA7g79UqTWWA3ySBtAObStI
 eMIWJy2CvfnCLgpud8uiIwaaoOW0YEFGLStF4BXOj3s4u1Pn7VOvxZO5wWHktRqUMGmxOgrdfO3
 8PyOSlnrFgjpmwZpSRaH1v6b0O87aRcqxLufElcCi/VmSSTR1684t2/r+arAOGlmiQXVvMKKSiA
 ia1m4q0AW2q9a5FMzlpW4zWXa5ZEGRkmZMzpD2t3k1EJD6yBLP3uugo1GarpA8
X-Received: by 2002:a5d:5d04:0:b0:487:146f:7c88 with SMTP id
 ffacd0b85a97d-48af1a8f1afmr6025229f8f.4.1790699147927; 
 Tue, 29 Sep 2026 09:25:47 -0700 (PDT)
Received: from fedora ([46.8.219.5]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af5056a16sm4933366f8f.18.2026.09.29.09.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:25:47 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [RFC PATCH 1/4] net: lwip: add an httpd stop operation
Date: Tue, 29 Sep 2026 19:25:34 +0300
Message-ID: <20260929162535.56966-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928230004.GY858934@bill-the-cat>
References: <20260928223532.482192-1-sochnev.v.74@gmail.com>
 <20260928223532.482192-2-sochnev.v.74@gmail.com>
 <20260928230004.GY858934@bill-the-cat>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Mon, Sep 28, 2026 at 05:00:04PM -0600, Tom Rini wrote:
> I'm a little wary of adding code to upstream lwIP here. Have you
> submitted this there as well?

Not before sending this series. I have now submitted it to the lwIP
patch tracker:

https://savannah.nongnu.org/patch/?10636

It applies to lwIP master as is and builds there with the example_app
warning flags, with and without SO_REUSE and LWIP_ALTCP.
