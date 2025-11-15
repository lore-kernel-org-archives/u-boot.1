Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA00CCEB2D8
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 13:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2611583A48;
	Sat, 15 Nov 2025 14:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cECN+GiT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D3C5840B3; Sat, 15 Nov 2025 08:02:36 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 112D483F4F
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 08:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=geraldogabriel@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7b8d99ad095so2204231b3a.0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 23:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763190152; x=1763794952; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IOYSOoZ7kZHsHMrtVsrNZvrMCn7UoqoHGgR3M03FgNs=;
 b=cECN+GiThMvyrLuiNrhAO680UvFePo5YUAvmzPoBkWd/TUQ9U+6YZZPZNpHOuOR1DO
 8i9sIQHzDBflTb5iQ6S2IRTiTQR99lQ3ccX+d14ukeD8XBn2G6DLoTVyTBp4kH3tp93I
 4YOVMi3g9eG5ca/gIyk9UHxrQCqeQzRW06oDc2j012gJ45/2SU3TcjHv7yXlPEKvJUlR
 9LD+19Jd75qvstl6yJSqerhKqOPmk0cuxOXUXdSXhQcjEMtY1Gh3OkBDXvcxuJXflAqa
 ZJGKcBfUXymjLpg9T3GycUSpJWzKa/6lcEvKQQTpesnsYlQVtNvqbV5PDRuKxlptXsSu
 zzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763190152; x=1763794952;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IOYSOoZ7kZHsHMrtVsrNZvrMCn7UoqoHGgR3M03FgNs=;
 b=EpCIsv8BFEcEDexw00/jWUvahskpU9TcEHZDGOtSAcLLIFOBllFPqVXkweNwIUIo0J
 H7zmQUDFHtrY4QqAfnjohbqjwj3YqRQhETv3En0zL2XbT24LKZiQasUsYiYkDmTg+Vul
 m5sDJYGOrNaV8+RelpJqN8I2v+7TnOFHPbOI+M8AQu8z497gzupJDWZODooHyXBpA4HY
 gXdVeEKiM3qZItNvsiavmdj/QvjLVxN5RfQRvC4RMOnEYhFIz0/UlkUpFISrBjAwr+/V
 ZxSe3HdPAVJILcYC/VnSGkW9VfhHwnrRNKwqjU4qWwuYJlxttUpaJxZP2jib4NU/POZx
 Fyyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMoNBlxyGh8/hzMefFkebQKP/yTCL4SqFjOP7UFVJvJDVxSfUwpN+1JWBxlxI7j1gIGXSXdos=@lists.denx.de
X-Gm-Message-State: AOJu0Yyr0M3oI05jW0n3hnCkFX5pMyOB6sYuCDrUzhTWpvS+1khpMRAr
 nDPthYf3znUuPakmnzQf0ZxUbJ/6pM3gX4IjQovQbMg6gmQYRQ+KaDoQ
X-Gm-Gg: ASbGncucNjzsGY8kMpqQp56CxdQSY+/+1AqoNk3lG2jzx9tTtRsxmgABPTYS/PI8Qqg
 6p/m36NN8TRlPycRsWbdg8sbrbu8/lDgZI+06oaKfPDxAXh8fa1BOotX7NLQyi0aQt4t6GfYwFi
 3dC3dIhFLEqR1Ny6FSWD2T9bA77nit9jKhfQqlayVIUkgNUdOvu79yWVfoPEMYTOZMT8V4XwJVz
 EJ68zF5mDWb0PvgmhaL7qhoJ4OpknozLq6RRL7Wmp3I8bjTliPr8H1Sp9oP3NM4RgneJqznxDPN
 WTLuwTCcGbpdewfPS3bWn9BwEtuLlPgcXY4tav8Y+r5q1EZKjxcEre2+XgPTk3cjeNTtlve6Rme
 AXmdzjybIrG1MP4sayVsH6TLwCpLxdLMNXtVfV30CCPfmBfsrG5HHwjJYQkFMT2zGrSNV5z7vfx
 gRUDYIJfsR
X-Google-Smtp-Source: AGHT+IF6Rm2Drf+1xlFmZRzPIXc1lSKc1tNyqq8bFT5+2d7X7z6WfhOem4D1nutU3J7fGxCS13ODNw==
X-Received: by 2002:a05:7022:b90c:b0:11a:4ffb:984f with SMTP id
 a92af1059eb24-11b411f05dcmr1444305c88.11.1763190151853; 
 Fri, 14 Nov 2025 23:02:31 -0800 (PST)
Received: from geday ([2804:7f2:800b:a008::dead:c001])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b80fd6790sm4677580c88.10.2025.11.14.23.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 23:02:31 -0800 (PST)
Date: Sat, 15 Nov 2025 04:02:24 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci <linux-pci@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>,
 Johan Jonker <jbx6244@gmail.com>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 =?utf-8?B?5byg54Oo?= <ye.zhang@rock-chips.com>
Subject: Re: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
Message-ID: <aRglgNL5eumu4XbS@geday>
References: <aQ1c7ZDycxiOIy8Y@geday>
 <d9e257bd-806c-48b4-bb22-f1342e9fc15a@rock-chips.com>
 <aRLEbfsmXnGwyigS@geday>
 <AGsAmwCFJj0ZQ4vKzrqC84rs.3.1762847224180.Hmail.ye.zhang@rock-chips.com>
 <aRQ_R90S8T82th45@geday> <aRUvr0UggTYkkCZ_@geday>
 <aRazCssWVdAOmy7D@geday>
 <e8524bf8-a90c-423f-8a58-9ef05a3db1dd@rock-chips.com>
 <aReSPbRxCgdNRI9y@geday>
 <ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com>
X-Mailman-Approved-At: Sat, 15 Nov 2025 14:11:30 +0100
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

On Sat, Nov 15, 2025 at 10:21:28AM +0800, Shawn Lin wrote:
> 
> 在 2025/11/15 星期六 4:34, Geraldo Nascimento 写道:
> >> Another thing I noticed is about one commit:
> >> 114b06ee108c ("PCI: rockchip: Set Target Link Speed to 5.0 GT/s before
> >> retraining")
> >>
> >> It said: "Rockchip controllers can support up to 5.0 GT/s link speed."
> >> But we issued an errata long time ago to announced it doesn't, you could
> >> also check the PCIe part of RK3399 datasheet:
> >> https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf
> > 
> > OK, I'm partly responsible for that as author of the commit in question.
> > 
> > First off let me say I do not intend to send any patches setting
> > max-link-speed to TWO for this platform.
> > 
> > I understand you issued an erratum, but are you absolutely sure about
> > that erratum? Because my testing shows otherwise:
> 
> Sure.
> 
> The reason is that Gen2 is merely functional, but this does not mean it 
> is 100% production-ready. It has some inherent issues that cannot be 
> resolved, which may lead to failures beyond imagination. Even if the 
> probability of occurrence is as low as 1 in 100,000. I cannot share 
> further details. Therefore, the official documentation should be your 
> primary reference, rather than relying solely on simple evaluations.

Hi Shawn,

indeed, the situation is not favorable and we should strive to make
amends. I'm sorry I based the commit on outdated information, I was
none the wiser.

What I propose is to add a comment to driver core saying that path
to 5.0 GT/s shouldn't be taken and users are strongly discouraged to
mess with the maximum link speed in DT.

We deal with corner case of helios64 in another patch and make sure
there are no DTs engaging 5.0 GT/s.

This should close the loop-hole.

Regards,
Geraldo Nascimento
