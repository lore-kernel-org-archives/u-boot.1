Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B12CD0D78D
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 13:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC983892F8;
	Fri, 11 Oct 2024 15:18:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ASZaHJkk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BEF58929A; Fri, 11 Oct 2024 14:22:58 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18CA688C4A
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 14:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martinstolpe@gmail.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7ae3e3db294so98445485a.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 05:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728649375; x=1729254175; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4RV/5sPDP3tIjox9b6HNhmcg+fXPerQAy6L+QG+KPVc=;
 b=ASZaHJkk2PnmGKEKxgkTQTrbE1ApsLiYNbtZTc3aI9IQvogMABaB1+pdwhgrqdF7aD
 QmATfX0zubgKyjT8BjQ13KOtI1g7AoKgZUs2Zk1suV1ocCO0BtOC3SAmyJZRrG5SiJRo
 AMfaezM3++9B6lido2XR6hLVz3wpfzoCDIM/N30rSvXEABpxalCGhXToJucE6GEMlN5P
 IFBubnfUTbeyO2PGf2KhjrAqWwIhTsMnJkE2upvjG0adF/0gxXwS2lP+RQierOg9q7Xi
 rMPSWrtfOnDlFNtMw+o3MWkQB5imv6QEIKBMeaC0n7QQRpHrfCNDIVApXdMXbngi4p2U
 zGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728649375; x=1729254175;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4RV/5sPDP3tIjox9b6HNhmcg+fXPerQAy6L+QG+KPVc=;
 b=Ip+FFQAyp5C4ddI4hNZx6biJcn0FLNnYUDljrJlhpmkH6umk3Zqlc7b3WeneGe+OgU
 m8QHFoyycgTfLZ5iivodUDwZgOEwAQBgf8yDu02kIJ7AZbkl1pRVj6gnsAjGzjizchhq
 mE4LEndQKcQePERKNuYZ92vORZNdXWhUtPR2NJrAyujmSMj+fqgnIG3zcIJgtuJatWbG
 gL9wzuDVvRX4tXDryCMvhdSmKCwhTbwiXrAQjtL91Jcvym9TwU9s3fFj6oGOnMX+AxF4
 JcKcvgLkbb2VH3hvgM76uC/n6r5ZQjNDLLBKXiMJMu6wOYV8SF+SNfbswfoQSm279Lb2
 WlGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAMA78yawgDFgA9NUvEK8IgIW30xqdQRUDJEdqpWn3fv7pQ8NR+H0TfiJr8u0zy97aeM9LXLo=@lists.denx.de
X-Gm-Message-State: AOJu0Yzyq8qnA2PmdNISCeZbXeHa4N4A44uYw1FR88I6NZhjcb6RYqUS
 cRW6kauy3SDxCHLYSeEPnHrGptpmApr9IRt2DWmoJRH4kOBH0hT8+pBGkdXqHriXRkI5C5kXqC1
 2rP5eB/R1TXn7wkAP9FdH5CamTTs=
X-Google-Smtp-Source: AGHT+IG89y9jJasXMos20Lf431uDlWkJ0iEY1lCjzasrjgaIRIAi4hEwgZMhxSOcVukhkFilEFShbHocAkjjefjMC/o=
X-Received: by 2002:a05:620a:2990:b0:7ac:ae32:286a with SMTP id
 af79cd13be357-7b11a37ad30mr401609485a.34.1728649374791; Fri, 11 Oct 2024
 05:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240920063204.1049202-1-martin.stolpe@gmail.com>
 <20240920063204.1049202-2-martin.stolpe@gmail.com>
 <20240920081625.z3fwz6n7o2zxd4gf@localhost.localdomain>
 <CAPHZmLbcfMVOydp9jCY0mWKdKPePBp+3rfttMyKbHT-CbB7kjA@mail.gmail.com>
 <e27aef89-8038-9099-58ed-b927cce54579@ti.com>
 <CAPHZmLZopucK5uMwENuF83pRMLYR2A5sC7fes4-1JXE4jX7=rw@mail.gmail.com>
 <08a38499-c36d-4bf7-adcc-d3f547f3afc8@ti.com>
 <CAPHZmLaVVSckGeqU09WMy0s4rGA-w6pQ9ObPuh3SBf8uTBaD9Q@mail.gmail.com>
 <dadefe22-2662-ddd1-cace-15d70f632232@ti.com>
In-Reply-To: <dadefe22-2662-ddd1-cace-15d70f632232@ti.com>
From: Martin Stolpe <martinstolpe@gmail.com>
Date: Fri, 11 Oct 2024 14:22:46 +0200
Message-ID: <CAPHZmLY7UHGdsdKtEDCL2xRpBiPuDS8Hc-roGtt1+5F3zZnAnQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] rpi: Fix build error when CONFIG_VIDEO is disabled
 for Raspberry Pi
To: Devarsh Thakkar <devarsht@ti.com>
Cc: "Ivan T. Ivanov" <iivanov@suse.de>, u-boot@lists.denx.de, 
 Francois Berder <fberder@outlook.fr>, Matthias Brugger <mbrugger@suse.com>,
 Nikhil M Jain <n-jain1@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Tom Rini <trini@konsulko.com>
X-Mailman-Approved-At: Fri, 11 Oct 2024 15:18:19 +0200
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

Sorry if this is a stupid question but what do I have to do to add a "
Reviewed-by" from myself to this patch series?

BR
Martin
