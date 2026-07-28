Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323DAC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 15:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC37B608E4;
	Tue, 28 Jul 2026 15:43:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OAXM6u9Hl-Xe; Tue, 28 Jul 2026 15:43:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A88F260846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785253435;
	bh=Oo8WBbd6YJatcdYMg7sDl2RXjOzFbRb2IITHnyqx/70=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=g/oPv0VVh+I/tDELSPjzVU2wOXUsUm9P4CZGXVzjcpiWeakiGjBRANjFNVVQ45yYi
	 MfuhP56OSpF2DeSxIL+X0l7LPNzEXiRe75YnUeWL0RAdIqY3d+jncWOczcNqFCppnO
	 KpmIdt+92XqK4l4f+NG1QP1lBTsrbWOG+dcRRJ+4pISlXYDU3AdBTAexp/GUNvz7H4
	 0o3udWJF22ffyhcGMNj4zz7deykSyGkrbTBlb8meNCO2lJno6lK8wsqh2B5dJQRbM5
	 R9PEDKF2Nb2eHA9iuaZVas7RuIx2cKs3FPVBm/3nttLdBrG+FAHWYixpmVsIzwg0Uw
	 ua/VI+YRcZZuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A88F260846;
	Tue, 28 Jul 2026 15:43:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DC7726C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3BC894086E
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:42:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nsAs2xd0wmGg for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 14:42:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=miladh1539@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0BAF6406B3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0BAF6406B3
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0BAF6406B3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:42:20 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB5FE8493F; Tue, 28 Jul 2026 16:42:17 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57D9B8404D
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 16:42:15 +0200 (CEST)
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-84e84a6c4bfso1035072b3a.1
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 07:42:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785249733; cv=none;
 d=google.com; s=arc-20260327;
 b=h97XSgML/7AZ04Df8ep1hS+sI9ILak1rGP6/dy5jHQ+lhvUzWj2jDociOkVEpgl/uT
 6eG4Le2gJfw5gOh8pcWdughT7o4zb8gVmXgY1UnJHGDVwobiNKZzcb86jChK7v/k3Aeq
 iCh71gWGnOzPZ8ppmBJLgrUwnvBXUFvDRPmIYy6XmCmL8r47VTZbqu+ZZQ62tYzLKVZa
 jth0aU95MW3NT4GmH+CrTmMzvJW43+Mg3o2zdRIKI/YDlfiLj7lhX+9MOysFdLRy8rQv
 EnQBXT0R2BOHZZZxuuxPAML1i+scwg/+RwBZGbtouQsvJa3W3AKfBih5E3zAHw1cUwfl
 IwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Zc/OVwequKdmQRZ8LntDIRSyZLcErJnOlkfVL7Xlv80=;
 fh=syS2Yd5ajuvgKEBOOkfG4Ipgcs2emg7FyVbsiREjDMs=;
 b=osNdFQi0RUFxRCAHKi6SWeim/ms6eGUm/HcaQP+bucHNYTAHlG7hBGTe0PHuxIrT5C
 035vNl+BWpF6ZrXSDC6pGwGijoqlowxtV9VfIxcBeuHvoTK8z68YI1fFcSGtz5P1nqbd
 2f6WIysHdsjh1bxEFW2SrN4OR0ZftFA24A8maQHSbhum0pAiVORUk53nJk/ulrLMIntN
 ChALB0f74qEmymDcgdd81ONyYrd1Rd6cjHrLv+na3uY7ZoP2tn9TVdHy1zn4bOpONctS
 +77a/CoemyU6cSRk8ZcdNfuQoc9tdvNrXlGLst+fbIbfZoSO/r7kBcQf2sLGDHSBtJys
 zB5A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785249733; x=1785854533;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Zc/OVwequKdmQRZ8LntDIRSyZLcErJnOlkfVL7Xlv80=;
 b=ns6SGqZcAh58AQ0Ey7gjGFm0RGuR5Fgxs8j74FOUHZVbgZUPgW6M56R5jy+bAXZns6
 XylMIA707ajRsR7B36uR/YIXEhfIBhslH6AZu8bCv+C06knUveJ+iJUO38d1rzFNm3bh
 6yegPmSdWZBTdFLXxfuDkFpPU3e0Cp5f2DJBnHdRzOud2c/9QImInZ9kQHaMVRA0Bvlr
 WhEtSm04iz51QqqtvSOiVibqJeMrHY2e5qZzwNmqzmllG4hH7w9nzrka4VtJaFFePBKH
 XPZmNgGdcvtpuUFpGkHkWZ86npVeIRsW6p3R+GqRxHBzQxL5INZhdpfuu7+ZSszHsN7t
 Pr5w==
X-Gm-Message-State: AOJu0Yx4Qm6RIits/gtGKzXMCbFHq6imlYSluJfi+JVyQvGq5juoc11F
 1w+2Wenla9tQuwGP7lMuOcXU9RhUJAeYmIW7GGxY70SnxikzqT1mtmPwnluBlfgN91yA+8IRdjh
 nSsmsZRjAW54v5gr5dI/U1BlExoE+c3kUfBFB
X-Gm-Gg: AR+sD1398oiKm+gT01fLmhzZ/c1u55J15x5AFDxpBCyBIs6FpTn/azcmaGGcuXi3xvv
 1rfTakbuylApkAHAn0K2xz1yDI37XcF2EmL9oBaN+7TiCdO3TdvJZoYqIBmjsjC5/pxiECKs6lj
 0t0wUlTQ9SHkV596oozSgIssC7//IJg+LgrrmuzzatnqEGMrThNNzz8C7dlpbAHfJVUIVIAN3c/
 4c25QwXj93CmuSU/JFizf0P99rbgdn9TYAnHls/wcah8B9g3dmJuXXQtLDZbZlT4xNbwJ9J7peR
 miHBovN94DJDxJ9k
X-Received: by 2002:a05:6a00:1d26:b0:842:6259:5e2b with SMTP id
 d2e1a72fcca58-84e9326d23dmr2948416b3a.33.1785249733191; Tue, 28 Jul 2026
 07:42:13 -0700 (PDT)
MIME-Version: 1.0
From: Milad <miladh1539@gmail.com>
Date: Tue, 28 Jul 2026 16:42:03 +0200
X-Gm-Features: AUfX_mwMn-4x6pSyLv4Hz8Vejpv97ft5NQTP0AoT7FF0jc3k_-58ENVXFjP9VLk
Message-ID: <CA+H9utw63z8x2Q+AhjWoq5O+aVW2FKEBCgvVtSzX--HJSJHAVA@mail.gmail.com>
Subject: VisionFive 2 eMMC boot issues.
To: u-boot@lists.denx.de
Cc: minda.chen@starfivetech.com, rick@andestech.com, 
 yunhui.liang@starfivetech.com
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 28 Jul 2026 15:43:55 +0000
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785249733; x=1785854533; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zc/OVwequKdmQRZ8LntDIRSyZLcErJnOlkfVL7Xlv80=;
 b=UcbZAYtVreWQtaoS4EL27RqhpQp6e3AMp3Mjv+AMF2R7noiIlD5MTA4XIe8LVGxL6d
 qnieCa/BmDTW18lJs1jBVDKMWGz+z8yaBK1R4/hKhvthabwuZoDqg0SM0qmHA6vwpiCT
 RsaLKBW7RxSEnTbW/PqKdErb08sVpe00Wk6U1DvizNTZxuFNeJeLykEIOodp4qZzPT/w
 lbpFu3/yA1VOXtf6ayHbeVapcitRixgul2/anRa34DSM+IvQNGfmswYeZNXNgMPABaBG
 s+iUsJ8QTjIzn2CCRGLk2foB/Bdysb9X8BV5IRLLxrT/n8edRheu9QiRjI05Rahxwkgh
 U/jQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=UcbZAYtV
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=miladh1539@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="UcbZAYtV"; 
 dkim-atps=neutral
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

Hello everyone,

Little reminder on this thread regarding my VisionFive 2 MMC boot issue.

Archive link:
https://lists.u-boot-project.org/pipermail/u-boot/2026-July/624724.html

Just following up to see if anyone has had a chance to look at the details
in my original message on the link.

Thanks!
