Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBA9F8FA93
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8BA6840A9;
	Tue, 21 Apr 2026 17:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AgbNvFNO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9DE4841C8; Tue, 21 Apr 2026 14:50:08 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 077DE83E76
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-8d7e7f48499so466105785a.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 05:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776775804; x=1777380604; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fITQELsvy9bXsJRewdREpmqsoq9vPvOTl9rYxckme2I=;
 b=AgbNvFNOIfORMRB08+QfHHvnIHi6UpIWymIoUafka1DVhDFxOtZZr006ZuUFu1j3ta
 QruWcwZB8DUDJ0G0kwr7QABbwBOS//qotC+Q9uLSRBLAIFkwmWS44p7uF623TNJvL3j7
 QKnk53Z+oPzoEFpROYE1S+97m1RsBRSvvzfA5kY6tkFv0r+Z781hpObkyYhwdzVAYR2b
 TKRx25zDDN0K6q1BrafZvL4kp3c6FM6VbQqQZ4vawmP6+jRm/4bIMC6OSQvviHNPFuvK
 GjGqszPI2XGxZxDH6GqSKHb1g73Y2bRNGTfXTknzFP6bf/ibU+bz7/kNLMMJL7zUTJSi
 EvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776775804; x=1777380604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fITQELsvy9bXsJRewdREpmqsoq9vPvOTl9rYxckme2I=;
 b=kCl4n1shi7BBQhogYnEMBL03XAQcIoPFTQERls5JFu7HjkNoyyiVHYf92XQmoNutk2
 tgyH/epwAtpBrv3XvRZ623fixlOc2+yn9gskDdy+urbm3BHxvo36wwSkNiwzuYKXgP96
 I09Q3mgtU0024+JVrMY6if1ML8Puqhq2mSYm3Gj6+NO6Go9QYmOF1kANLu/RdBmes4WG
 y2kZfdQtaJ7cXj6uFhZbwOcagICWcRuZ4IKodINfTB7lMueJISKKR/bikRqxUIG2vBag
 9UaRpBgNfba9WSPl2s6HnMS8GVe08UpZcMGsasMmAKXK5pUXr5Y2QVNGANeScPQemSUZ
 xYcQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ92cusTHJ+oARoU8u8+sYIrmt355NbL/sJhdGR+oyScN03/mF19q9QNgQnDSWUnxf14PjZAA0o=@lists.denx.de
X-Gm-Message-State: AOJu0YwxRxISqvtmjyYK+bYqgC6zkhNX+NBCLiE0Sxj4pQi8iilUCcmo
 tcVvDWEYZVLoqhfVjx6Y/wXN+ozShb7OjEcjNVPJW6d4I6CNhSQJuEAD
X-Gm-Gg: AeBDievdTM9w7BajZHTtaxmDB0012Uz4W6gTe4rmJbeYsXeDb2xp7WsoLlvbQv8ylj2
 HOHvc2IzBuajvcYrBf7NQM1wkLxHw+10GP7WkuKDqFARLg+2446K43aU6Oiyufx/pkkJ9hUXM+e
 nDjYusAHJsk8s9C+985CUvsz87s0eURu3K0PUFWyE21Eju59r0KhmhukZteiNF8RptJ96O8Ks19
 tDP+cQfghfa3Aw2b2jfLh0xoMVB54rgXOFktPXvV+grWFMWmIbm3P6+ivcptz6lSF2biNJDlMMC
 KAOdEd24yLEJvD4i89v5xQiD92toiScUQhsRpl+sMDlpI/SuqB+A8JGBNXhneEtgcMhIySOzMln
 K5RSQG6w2W0MhUweK4JJiL8/d1lO381gh/KjsJxL+Unxl3h6vpHX2DvQyiF1o5+Zeuwx2+IwKOk
 zCIQcsPwJlSrBdZyNPvzJCgnxF2WxvCTMCeSqFU7GydcQX
X-Received: by 2002:ad4:574b:0:b0:8b1:f8fe:507b with SMTP id
 6a1803df08f44-8b1f8fe54edmr20536876d6.19.1776775803739; 
 Tue, 21 Apr 2026 05:50:03 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac7834esm99919196d6.18.2026.04.21.05.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 05:50:01 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: sjg@chromium.org
Cc: caleb.ethridge@analog.com, jcethrid@gmail.com, linux@analog.com,
 malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: [RESEND v4 14/14] arm: sc5xx: Add fdt_addr_r, kernel_addr_r,
 and initrd_addr
Date: Tue, 21 Apr 2026 08:50:00 -0400
Message-Id: <20260421125000.5677-1-jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAFLszTj9nd+1N7U5DyQfmnx67F67OTdHFo0FSArpLMv0qSZgAg@mail.gmail.com>
References: <CAFLszTj9nd+1N7U5DyQfmnx67F67OTdHFo0FSArpLMv0qSZgAg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 17:12:16 +0200
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

Hi Simon,

> Similarly, initrd_addr=85000000 seems inconsistent when the load
> address is around Aa000000; sc594-som-ezkit uses A8000000. Please can
> you check?

That is correct, these should be A******* to match the sc594-ezkit. I will
fix this in the next version.

> The standard U-Boot naming convention is ramdisk_addr_r - would it
> make sense to use that name?

Yes, I will update from initrd_addr to ramdisk_addr_r.

> The commit message says these are for booti, but adi_boot.env uses
> bootm with fitImage and does not reference these variables. Is this
> preparatory work for a future patch? If so, please mention that in the
> commit message.

Yes, currently there are no boot commands that use the booti command
and its structure, but there will be in the future. This patch is just laying
the groundwork for this future work, I will update the commit message.

Thanks, 

Caleb Ethridge
