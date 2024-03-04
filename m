Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA31C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 10:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06CB587EA3;
	Mon,  4 Mar 2024 11:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TofQ+eLP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B73E987F41; Mon,  4 Mar 2024 11:26:47 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E43B987E2C
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 11:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412e784060cso1694965e9.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 02:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709548003; x=1710152803; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G9wzfq7BBEKMdiZNvMLYL/6NRslxGTP7YmgHcziXlJE=;
 b=TofQ+eLPbOMp+GplUhfpmVdSUUOvB/X2caeN8moxEdOhZFcY55aQwJ3kVbvA5tphFO
 vtgkMvR/3A0x7sybNoKwXwuSsixBRM9xIIakusUuAukfy0ONDb64V7jqJTMadLZMmuCR
 tlK3kTZ/opwS9NSpCwvmQKjQHu1ELhKW1B+tHiKT5MgjXUFawya8pjM7+KNuY1gL1TU7
 0smSccHZN1JjwDlVnPIUuDbnZXHcqcGawSXPyo9yX2q1F6PFwO+AnTQtUkAaxIsf/j/b
 BHC8muRTX01yYdr/V0RW9+aADd6Fo19P02rb6zNjPHYYkpL9yO9kDJfTdtHBJGIhZF5T
 dwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709548003; x=1710152803;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G9wzfq7BBEKMdiZNvMLYL/6NRslxGTP7YmgHcziXlJE=;
 b=ofPQqzm0lcseKtNTcP5Mb4C4890sO/BixOCYFYpvItM0XHhoLmFkPp7nLuUyc0KSte
 RrXMWYfCwTHP7IWy0LcB+pQAu/fZb5kaxRvlNVe6fyNvj2W4fYH/bWMk9BvfSUATJVBM
 FB3EN4Z7FcdNC/UDJQ56uySugVUEXmkQ2CE/3pC9No5gGE457453Nd54EtEakkMZjqx+
 qkekml688t+8qNDuv1EbRm421RdoA1hXiPkiffoOHKmlOdCRctHLNsPKrCnMlH0hdYBv
 Sox5gNpIWAVy0Uyv1Q0q1xrmTZ9iKEVBy6+auHDvMGOTgPOlrbFysWsnXGGQRKhIMqBQ
 L7AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTDO323gHb32xGfHBf2bAOQmZ6oavAvT4Q4LrAEdf5eZn3IXCFJrqUVsoCRJb5Ez5v+T1H9+SimpzdV4ZV2NSKSMYmXA==
X-Gm-Message-State: AOJu0YxXvFl03h7mO2Z1iUdcGyiZeWNTGdTggC1mUlgFxnJWslDgZNer
 vnyx8g/JPMgu1a3qH0fxsognkGg1ExhY1kZI8UKlmvjVfOHGeiKbYWvi6z5hMsA=
X-Google-Smtp-Source: AGHT+IF5dONHFZx4eSNftqJMrBSCah0sgyp/g7bc1+s1JyyxlCGkjyABqMG3x6AcCTnEy8xORDDB6g==
X-Received: by 2002:adf:ca8a:0:b0:33e:1505:9463 with SMTP id
 r10-20020adfca8a000000b0033e15059463mr8553028wrh.13.1709548003060; 
 Mon, 04 Mar 2024 02:26:43 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 i6-20020adfb646000000b0033e033898c5sm11839340wre.20.2024.03.04.02.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 02:26:42 -0800 (PST)
Date: Mon, 4 Mar 2024 13:26:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "michal.simek@amd.com" <michal.simek@amd.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: RE: [PATCH] net: phy: ncsi: Correct the endian of the checksum
Message-ID: <053184ba-3e05-45ac-bb7f-45f590b2fb7f@moroto.mountain>
References: <20240205080228.140001-1-jacky_chou@aspeedtech.com>
 <da9231ac-1386-48fc-81b9-8e027cd5dff5@moroto.mountain>
 <SEYPR06MB513483FE06C897839C5E3E5E9D592@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <901d6849-2e8d-4876-95b6-afdb9696d862@moroto.mountain>
 <SEYPR06MB5134211DDFB9F9FDB0125F609D232@SEYPR06MB5134.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134211DDFB9F9FDB0125F609D232@SEYPR06MB5134.apcprd06.prod.outlook.com>
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

Anyway, looks good!  I already gave my reviewed by.  Thanks for your
work on this.

regards,
dan carpenter

