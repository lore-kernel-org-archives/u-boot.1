Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E19C87FD2
	for <u-boot@archiver.kernel.org>; Sat,  2 Aug 2025 13:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B04D283B5F;
	Sat,  2 Aug 2025 15:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kUIZA+4p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C47B83B5F; Sat,  2 Aug 2025 15:41:30 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FD2083B5F
 for <u-boot@lists.denx.de>; Sat,  2 Aug 2025 15:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3e40050551bso19825815ab.2
 for <u-boot@lists.denx.de>; Sat, 02 Aug 2025 06:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754142087; x=1754746887; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKwHoZCeazI2T35y16AJ2kc0ObqFjbYSM47MQxObHLk=;
 b=kUIZA+4pMGrXdGFjSC5PWuwsekc8mjf7KVwLdXPDFPOHx9eaO78gm8TWVG2au+95Oo
 hCDwLpZYtIvZ/bFDCD0x2KvwMbzoXvfzKXlGb35i+smXSZg2kcKhzVbXxDmlaMcpL7KF
 b5PP/bUSUaz3FI95NF7LmMTkZVb881Flz/DEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754142087; x=1754746887;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QKwHoZCeazI2T35y16AJ2kc0ObqFjbYSM47MQxObHLk=;
 b=DOXmTZ0I9tMpo2sRPLXh3iwa1zqkiv5wAgCrR24JZ90GiDBq7GsH+6HAkPr304tG2T
 m8WcZGz67GMOpjP1HI/MgW8f+Hw6XvnFL6XC8KHKFgpxZpaauwt1DkPraULi/lEnf5MH
 SNojyk1DNeh6rECm+P9gN/WuPlFaaq91xQ0BHYBWMyVOvQfRW2A9VXTjTiys43w56DIV
 BJFQyhoAqeB1ZH7I1Zm/D+hVmQOu/em1Mr8eh0fInTXP9E9bGsMEIbdH7q80x9LLMOWv
 OWlTJXx9M3GIbnAJIODvaX3t3/OZWB34daeWiZZ7txFEN69nH1XT4pS45lt/q2pAMjQM
 YBsw==
X-Gm-Message-State: AOJu0YwxsMA2+llE4m6fBC0Us5LCrmZnNzZfZjKj9kEA1aHIE+n9Aojb
 4LtTE2eqEIP1rCcrikT65UZvGANJSGRZyIxH/Acs3FHZpnnn6onGEspsyBOjaTg5FXQ=
X-Gm-Gg: ASbGnctHh3Ids9cEzTh7O/YMNz7eO+1uNkYZ40I/KCPdf03xjOM1sQ1C7Uv14vOeOR3
 n25euTuR2cAHMvM4Gyz0rDbgdDvHm0saIjG6Dqn4Ss6KjW410lIrhQtmaPYjUyqVlMENM9Z3jdn
 qYAvKv1QvOGaFy98CFrRchRV6slbSgyLqQkSF1Zdl7lOY1o4Y5EHaKrHsyWyv/xF2peqglergkR
 89wYAilGfCQdu1D/vYuCGrpX2NlCIb3sPZWkw+hIqC+eC78VDqAeLflE6BSb0wBE20xzJUFFW7D
 wjWzkG4WEb2B93sUBItxBxIN4m2BYCsieVHekcMzc+B+kOzqTwrulBvX+16tHZYWgGNcwYh0XNC
 KajKxwojjVgNR6rhJUH3gDYRbELKW6GGJOmA3Otw4Kw0ZcSzbQrFghn4=
X-Google-Smtp-Source: AGHT+IGSUkrJpVzV7D9J+MlK06Yrw8G0dxpo45MYW17yiuaaHFTR8FC9uPqz7rMJlOhzmsoSG1cMxw==
X-Received: by 2002:a05:6e02:2283:b0:3e2:a8e9:89cd with SMTP id
 e9e14a558f8ab-3e41618015amr55636605ab.13.1754142086908; 
 Sat, 02 Aug 2025 06:41:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50a55df2da7sm1909944173.111.2025.08.02.06.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 06:41:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Shiji Yang <yangshiji66@outlook.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>
In-Reply-To: <OSBPR01MB1670E56647F1F8B4BA66A931BC59A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670E56647F1F8B4BA66A931BC59A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Subject: Re: [PATCH 1/2] env: mtd: add the missing put_mtd_device()
Message-Id: <175414208585.4116791.8388766349488501472.b4-ty@konsulko.com>
Date: Sat, 02 Aug 2025 07:41:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 25 Jul 2025 08:20:44 +0800, Shiji Yang wrote:

> The mtd device is got in setup_mtd_device(), we must put the mtd
> device before exiting the function to update the mtd use count.
> This patch fixes the following env error:
> 
> > Removing MTD device #2 (u-boot-env) with use count 1
> > Error when deleting partition "u-boot-env" (-16)
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] env: mtd: add the missing put_mtd_device()
      commit: 39ae954b04ef2fc4a8c14410379b663deb391fde
[2/2] env: mtd: initialize saved_buf pointer
      commit: 7e842bd33154946052068195df3446635236d3d9
-- 
Tom


