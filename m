Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7291DC982D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 22:19:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F05A340A5B;
	Thu, 17 Sep 2026 22:19:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s25ePoh1KG7U; Thu, 17 Sep 2026 22:19:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 51EB24085C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789683540;
	b=n2G7PQhJd5O4HmrEarXIgIXfP+QyWz8KcjWpGbTD7GGOAWkqxa0SixEpKbc2WYap1Aot
	 NG0mDazDqnYPJ7mJZoSIDPABfhT0ClBbwduQcdQoD9w7KHicEJnAv1rR3C8JsPrut0laO
	 tnvmUNjBPzAylfT2EBmahQhwI2ypXtLE7uGeyHKYDYn2N8w+vq+M2snUj5lDN7/brgdWp
	 old5JBDJsznJO3jD56x+vuqnEqhe6+hVwKrvihA6XUBXmJPom5S12f7bZPTzi5En7cErr
	 TXFasJXCXWYaITcJ5xuvW2eOdUBhEKhhojTCz3vJX5fO8HDze+byxjmzunt91tNVl4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789683540;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/XVEI+R2UAw3jy7CpIrBmejZYSGiELQOf/q/K4bKdh4=;
	b=CVFWPqXmDX82V+DDvz9urVOLilEWycBgVQnUciExmudOffMEMPNAz9nlccWtQKr4gye5
	 jYXw18aNGqM2tVuVg10MmD3D+IGJdLa3neBP6FoL5OOo3gQQzmSp1/+rj8Ki8j+ahu0L9
	 0McKjeVS6DuC27MvHPdlhLtMlCDS0iybfTC+b0xcT3IuSHNKdPoLrlr/O8Nj3DJMCPD1R
	 KJqxHn8hT0Awyvl+Ka4oJ8HgyX5Hjo8Skl+AaOxqjXcq+V1w78xcbLoJykHxCrSa5RdJ8
	 cBLzHYiplKc5PkHBJcI+aShc5rY9nFINtuaxMe9lqDnL+ePhb30PwfhfMOqMqnIsk3A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789683540;
	bh=/XVEI+R2UAw3jy7CpIrBmejZYSGiELQOf/q/K4bKdh4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PcDo7VmadB9l6uEkMtA/ujrCNyNQNiT3RpsSOst9zN0dpGSBIYhnlbDkiohrOpdrW
	 Q38EmI0kJ0XTsxsXETDXZEVat12CWiaLg+lP9Tei1p9xheMtz9RqxfH4KCQOQDtgW4
	 nzMHBAHotPVndS3v1m7Pro2CoKQTJTg2YAd36YU3S7G/DPF2MYTnneASa1BtGEIz/n
	 ZGD0Y/84Q4+HZz1ZoQreN6zoKdc7sDkzYZvR5V85q2SUcexAwgXgU+cBm+WPwRftTT
	 WIR2824chP4uMZOct7DsYS5xbqyDg5jfEGGNPgZwO63xwQIEIHq8JYKK6sxBewcUyt
	 abR/TIJQIMFsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51EB24085C;
	Thu, 17 Sep 2026 22:19:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E4F323B6
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 22:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D6B6840460
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 22:18:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UMCuFsiYlzdw for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 22:18:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 365C14045B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789683538;
 b=OP4H5Twkt8rIQa9Qzpz62qDHG+qkQ+osRwD14j+yMSdURVRdMcjPHzfAc20o9tZDeLzr
 xIJzkyz1BWwWt9Y+kIsxCnQvclGDOHf69bBv4zDUQM7LgMqCNRZ9H4FfMfsk+Je8AtZM4
 oFf04uqk67TvUstjHJx1DazkoxTNSXF67sILszLwAhROWo8j92hvOS6YRGRSNp4YGVETI
 noEMTgMX9OczpqYWB+3JUPDAgcRi0I61k+LEgpbObzsHNBkohkS4IpnsmBctjhFX5fsvp
 cInqWMNUVqaHbljKu4fMkoFkCA8U+e4XI/6aS5MIIeB3St7wvsA6qUp6V5K6mzk7n1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789683538;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=/XVEI+R2UAw3jy7CpIrBmejZYSGiELQOf/q/K4bKdh4=;
 b=k3NyTAIdbKIBaMc1tpUkrPztCtCk7ZqBmNBvwsV4szckx/SPDggQWM6koWhc6H3QWpZT
 nXw2WuAE40G6FacGcRyDbrxXYiN6RpVN4o6SfvCcU02nVKEERIK8o+t8GsQix73cIfQDW
 S07853WK0CBRYeJXxYHqXto68t9Rc82gq/5CnuOugackZL8GNBn4syUPykMskpUwEXIUU
 gEoCJXUmfJleOHNGxx7MUQqlfmiDM01P4lq10mwWGvRElbpm+A4jPDAeedd3109j9pnGL
 NK11oWQwtOydvi2oUbx65HgI/RM3uG7nZP/XiJAafhj9n+m85Xlfi/bpm4DpzOZooog==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bjqYOvNP; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=bjqYOvNP
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 365C14045B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 22:18:57 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7f4df360cc9so64163a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 15:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789683537; x=1790288337;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/XVEI+R2UAw3jy7CpIrBmejZYSGiELQOf/q/K4bKdh4=;
 b=bjqYOvNPbQd5iFNFzcW1juqqZXml0ovtvUwrHlN58XlsXaMUSNAd4k+tvuiltonhl0
 cN3SdAITwXWWBXYU6TY0H5ZtLTqADsJO3E0xXYX42uH+wrydU1aNCXDWxAj970x7JItA
 QlU7tWkyZsaSYNurFaNZ72raSWeRPXhrdOWN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789683537; x=1790288337;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/XVEI+R2UAw3jy7CpIrBmejZYSGiELQOf/q/K4bKdh4=;
 b=aBSBx3DuktaGNTdHo+o5kG+CAigiDVnWWGmqAewtRwlTrIXoAGx7aFamTDs31VDVyz
 Y1TW5bOBFFcllorCztVR7bdX00Q0bJZoYVod4T4ciAYpTE20ntaXhUfTAhejez8os9MV
 vkApZ8s3jey6S3wpZ/luS4gki58dkZro4t4Asg1aKqNEdL7SzX+i8o5IvCXURhvy4YDB
 xEG/nY/0Ox5/ynmUcjSkvl1RwCuevd+3Ph1yR0kuMdvZFOi1AsIT0F1w875hHfkodbB8
 omMm/fla0+ZNvZ4DFWjo+E/BcCpD0inqreNELRMxiUGiLcbsfs3fTvfJGp11EbDUokZI
 DbQA==
X-Gm-Message-State: AFuF++kuB0FFEwLuNyDtvAidmncbiJPTYysRCDpNcTXxYs7cgfqHHmoL
 kEz9Tzv+wLzmMb3Y0wfuRqfqvZSg2oGG5C0QcLpPODmdIxd1KPLqng3cRT0fE8ty/7E=
X-Gm-Gg: AYBFou0KyCNKj4BJuKINRWDqgw2PPvJHCSDmuARnF9p4+Z1jH5/DQzrbNozErYijCJc
 j0kuSiEHm49lEes9BT3jwLAZacNqtTd6Ahiyp/AikWvjzboaOdzDXcmQti+7uhSwnlV4Fa/xiYO
 kFN9r0NDRnMRSsoXCTu4VK4cd4di/S/NdMxn6ceQxDbo5XsopZr0OmAJbiKMbmPwCUHIN75HnKg
 Y4m++8/YvDhFWm+6yDUAyzuckN8Gxa5e0KVP0Z2/pEmCphqr2YGySwRnPy4ujeY2zKgvdWmi2gs
 kWOk4sSYh7OywDCJtzqbqSugNuXKK2/K4tjAWJz8eKEAH4v4pI4P0bqXbrabx1J3vO97w8J7m6O
 Ro77IO9QKIB6wStDL3GxzUaGy8nDUd0IG0Hwb/ka9Vs108FErUHtB0YE/1WKCr8aCD+5b/sgWA0
 iZBl5e585mueleSF54wrcWfJdXyicltUXhsaccxlj6ZZEQkCs4xDH2zHUFuM91ybC+X/oqBGOo6
 e1lRYA272nADnmbEFWSyvh3zx28Lq8ykkMBhUnm9Pz/qzon3GAOZV2/pvRBkhgFTnnr5wHDUGyn
 F9wkotNFidm0u+Auow2G0Krod3FIww==
X-Received: by 2002:a05:6830:6798:b0:808:da23:ebdc with SMTP id
 46e09a7af769-80c4dca2a9amr3440550a34.19.1789683536732; 
 Thu, 17 Sep 2026 15:18:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80c46dbaa98sm4416077a34.18.2026.09.17.15.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 15:18:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, git@amd.com, 
 Michal Simek <michal.simek@amd.com>
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Hans de Goede <hdegoede@redhat.com>, Heiko Schocher <hs@nabladev.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "moderated list:ARM STM STM32MP" <uboot-stm32@st-md-mailman.stormreply.com>
In-Reply-To: <31bafc6498b143285f2afe542d0251a896c8fafa.1789477136.git.michal.simek@amd.com>
References: <31bafc6498b143285f2afe542d0251a896c8fafa.1789477136.git.michal.simek@amd.com>
Subject: Re: [PATCH v2] Clean up emails from non-existing domains
Message-Id: <178968353512.1566609.2601549674294291756.b4-ty@konsulko.com>
Date: Thu, 17 Sep 2026 16:18:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 15 Sep 2026 14:59:01 +0200, Michal Simek wrote:

> There are 5 domains which no longer exist. Remove all email addresses that
> reference them. Where such an address was the board's only maintainer, mark
> the board as Orphan.
> 
> 

Applied to u-boot/main, thanks!

[1/1] Clean up emails from non-existing domains
      commit: 7dd0d23b9c27605198ac9aaac5b62a3a352bf5eb
-- 
Tom


