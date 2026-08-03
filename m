Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFB6C55175
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 10:09:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 467AD809B1;
	Mon,  3 Aug 2026 10:09:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gkAX3M7CoJek; Mon,  3 Aug 2026 10:09:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6797B808BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785751787;
	bh=3XrnfFAZYgciLVOI7K6mDWKYUDKRImPFtqiivGT0iuA=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SaQzdwgWP9zCFqMs6F0vjZpWYwWVjME434HfivvHhYD4SL/+8iiy3w8i/9KdBvPRX
	 NWle819DHTGl5oymEIvUU61cG+7ZWo8ZHWxN2l32RvfTKoAaVPhG+yVXx2HhxzXON6
	 W9PJut4el18xCYJHKG4hJUidTzd+yiBU0TWvFhnVHub4gPZtYRRaXJ5ozBPVPIuwn7
	 YFLAXntAA8BqmASk31W2A+zAOupe4Gji5PRrq/k5/d0gPcCgPc6KYsr0xA9SLsC3+3
	 xVdOiwxmFuGtUL/7O/ptnJ1OF/6/8xZ4WKryZXEAY2wXxKlZR5ajCpQAibRlWbFM6m
	 VziSy+/BOGXbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6797B808BB;
	Mon,  3 Aug 2026 10:09:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FF2B2AA
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 10:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1DC14405C9
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 10:09:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 60ePtfcljL4j for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 10:09:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BDAC6405B9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BDAC6405B9
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BDAC6405B9
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 10:09:44 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47fe377a217so385346f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 03:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785751782; x=1786356582;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3XrnfFAZYgciLVOI7K6mDWKYUDKRImPFtqiivGT0iuA=;
 b=jXVl8/6F62a+1YZkwDtfUOAHqOvgIaoXog6l9XBt6osB4BfasGShYby3FFDRKVQiJd
 aZDCFHGGRSm7Ji7A7app95D+TgTnYOSVWgRlDk7AX8/eGYlJIXFGjMYdmvRFcbYfqK2u
 3Xi6pHHmp8CgURqibrcIR3RFd9/Wn145wwePqktoGsv79aWOmB0k5S5wfvm86nYDj5sj
 v5gOUBhhqsMVhDo3Kh01Elck/T6Nzpjuyd9tT1D5EPuK7uSzEx4HMSPrkRIwJrbMZ35V
 Md6rSIleaurQw/HM5eMY49pdcKydfUp4eENBUe2aMSGD8R6OzT1HmZwG3o7szkxAQm04
 bqKw==
X-Gm-Message-State: AOJu0Yx5oklh19LaAS4hNa/5jcMm4xajP50ezQC+ZhuMQjsvH1Xs1Oyb
 QosFvPkMRFCr9YkQe7ye8jPEy+/ON65X5IK9HRw6PvULHFStaMcl5pv2I8xTGavqfKt7ODjvEIE
 TMwg3+mo=
X-Gm-Gg: AR+sD13ghjWIAgF6TCG2hlhnOPXjj0B3n7nDDkE11EWqBsJzoqeRlv2WzDEYVA7OyN3
 hjS0m6pUbGzp+Hc+VrsUF362BgZEnkJ35lSMB0vEJznn9yN7jVsXmEI9rWIROCVdav/riuzGEgl
 E87086Wkp51b0+nWmG7rRxs6xgDy6lK+gj5qfilTzexLC44fK3AA3wvm3VgDKYH0QMClvn33VMd
 +XDiBPV6xPHLNCras2aO5BDkpDxP9w0TGszX6eOV3LE5yQoDDtyV6gVsjJYjtBn1jaMdhLanAUp
 W9XgqJ8IP3Uug52q9+ZJwy1BHcuz99VhsMFoVnbnoujyqC9woHxaY9w69cHSp4fW1AHgLsDoIQ2
 7Df42V4PJxR5WH3PJJmpHz0alJ+GNEHJwhn2XYnRAjuS/SXK2aqTdvmLCMZApm5B8k4AaPOTsDM
 jhXFQ/BI5EcqPmoAAaSn6q+i1Mtk+kcW5dDYD21FxArX/N0jKl1ag1j20jPlzxqqrc5m52nPLOq
 yJlOjKlbvTJ9KAupQpk4J1v8fF8qh/QE9vF8IsXJ/QEnCFRziV6BnH+gRrlF+qlV1Ej+9P/BVmo
 3fdNjwESz7mDJcsQKhTWljk+aVqbDnkKAYI2K8cUzqDEf3yfiu4wUozUqeV4aN+2pll/q2ox6jw
 +GeHS1shhwujdxBxbv4Slo1ARwksYJwQ6EsWHHrXpGv6Mm+Z5qN8BywRv7RDuyfvJrXtVMDVJ2I
 +4guNQUiWI6+CZN9naebKPW3NF+N1CgKcLI6Tq5uZIMlXZ6v5IcGrytU2szb/AEzKmronAGHbAU
 C8p5hRUcxRP4GcsSmYSJ/9l6yYqlOyOnOTJatMWtvwDrRjjxpaXnjCYtEnIsUo=
X-Received: by 2002:a5d:64e1:0:b0:47f:8488:50f0 with SMTP id
 ffacd0b85a97d-47fd72ba756mr23224617f8f.4.1785751782146; 
 Mon, 03 Aug 2026 03:09:42 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd64eef60sm26763325f8f.16.2026.08.03.03.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 03:09:41 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.u-boot-project.org, trini@konsulko.com, michal.simek@amd.com
Subject: Pull request for fwu-main-03082026
Date: Mon,  3 Aug 2026 13:09:32 +0300
Message-ID: <20260803100932.64260-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785751782; x=1786356582;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3XrnfFAZYgciLVOI7K6mDWKYUDKRImPFtqiivGT0iuA=;
 b=nqngraO5lHw0RsmscykjxtK+SZgkRsi98wzO/SSoDNgboDVtMOrLmi3MnHehRUgld9
 4vaGn95HyvtVYU1i5FvDIS2vK2jd23w2NaszPascvbcOE050Hc5BeLnP7rP7YLnJbYjQ
 0fhrrit+WSnpkEimPJCziFGCRPwaFRDenIJMMvV5PqVtgd2rCEwTT66EmtYwKJMGV2S9
 Cur4mmUuI9pkXOY0mu952h3xU0WlKHrnisE/3LdaXzP/WA2vr+1qrKS2gbc48s7UTDU/
 Kxk/o37aIkFdVc1qwfj53xfDH7NbnXjhcGmfNye1AElv4qUw5uuWafEPhXChDZTt5IiG
 nDow==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=nqngraO5
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom

A small update from Michal enhancing FWU prints
The following changes since commit baa64b2f892890f00a377eac4a3e685472bb56b5:

  Merge tag 'efi-2026-10-rc2-2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-07-31 08:55:30 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm.git tags/fwu-main-03082026

for you to fetch changes up to cd6f2f451903559627f29c563887624f3f386770:

  fwu: Make boottime check failures visible (2026-08-03 13:05:21 +0300)

Please pull!
/Ilias

----------------------------------------------------------------
A single patch from Michal enhancing the failure
prints on fatal FWU errors

----------------------------------------------------------------
Michal Simek (1):
      fwu: Make boottime check failures visible

 lib/fwu_updates/fwu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
