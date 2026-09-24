Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AF0C98324
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 17:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CD0460B9B;
	Thu, 24 Sep 2026 17:45:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bXKqvKZaCpV1; Thu, 24 Sep 2026 17:45:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2502560890
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790271908;
	b=CVS7IjzvhUEdRofvxYNdI9uTc61TFEM/iy8q8zy4bY0ayc/iduWO3BAMKX/9APVJy2Gt
	 /GXEqbdZqY4CHaC40MNLgXTBLHz79DrjRdXqb+pdXm4CPhp4mWJY2+I/WCr/X5MQos7XJ
	 9Ex6GqRtiPDbxONNLLY5giMh/E5lnJeujfHXnMXPWPXCXCwCeAru0s+2XhqjeTgWzjmgj
	 qzYRQ1Xs4ITjjqxOxrlqLwDxbOrnLerz1O8v/Z8EYHhDdcPusboHgWLop2itj6M/7JMOw
	 dl9CBRKR0i/RPm11+KdGL48A2fEepKh56TIb4IudTs2E/ioK5sqcFvbZjeXDI+zIs8Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790271908;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7lZIZSx+QlsJV/18AL8WXIMywiaG9rR1zUgH+xCFslE=;
	b=HJrVKa66/iznleev3FYQ38bBt9Zb/SoVDUejKqsGJhLlMHc2J9IlFZfvD9LT+Nwh6Mr+
	 m4qo0/cgc9SWBSHm/xh5g6HxrUsUyJ6/gkTpiNNt7auqo6bSfHNxArF5IOj5e9cO7QWEM
	 6Oyr9rol/PtdNRCZMAquyRuXXK+Xxaj49qds6dT+a1LghYNs5+J/yxGlsNRMD+Z+38KpY
	 HZ/d9OdI4MSnCbylp+qnBQeUMyORffLkPyQZzzd1ibfo9fy5VgvE5h6vbyzWWmFclVHjU
	 WU0HXXuAHz0+QfGfu3ZzvOez+G9JKRqsApsE6c8AR8+zD229WOaZGv2am1W+eiQMXLw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790271908;
	bh=7lZIZSx+QlsJV/18AL8WXIMywiaG9rR1zUgH+xCFslE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bglJaOslF/US8lp7rWe4sxwo6pOZ4ya2A1UnnRkoKjKbafdypYexBMyOZnFlrDmUe
	 5U4EY7+sQyaFJ/8VJXE0bo/STc+Eyfgtb7jVwUZmtBtIU/fgt5JOAJsYSV4PwyaYH2
	 o+Eo40wG+7NgMbVqxapgwrnq7LXRWc1AvmngO9Z9WByOOBbp6U+b2cKfQd9J1ICxPK
	 LNfG+t6mhwwAHNagls4/aXS7cTMK0fafmM24siSqvwcHviRlTXwL2A3wjfHCNKzGGH
	 rD5RbgR5HF0xH0T5buY9+r81YbqPkde4+lJ+IiX+l/g8Yi+8Bqipw4232a4FK3K/9r
	 G3nBKzQpdPpnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2502560890;
	Thu, 24 Sep 2026 17:45:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CACB735A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 14:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BC49840484
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 14:48:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tuBVyUIhjAMA for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 14:48:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E40C740386
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790261317;
 b=Hraxmnludv5SpR2NLYQsV74xPMJ3uTmYcJ9/LWUwpch9sBGxwA7zDQn99sBK+Kn/kOvM
 H47H+OJZdY0ORzUuJxy9QJPWJFwe6uGcwPO/HqSP6UHqpQtJpkLD9rAFo9COvO5461FV5
 nFYBRirtEueUHuQSBsAG1/8hmPhcRISwYin0bBNijddPi/ju2pS9GdaUTQ4syPM6X3OYT
 uGj9Pw7G0xy23f0I9Qn3NU0ItzbZIcwXZ2NTwma48fvLCnQ25lJgHFFi/B5w92uOjzIO0
 VZCpsQcXroLcZfqc7p1Jq8bAWAjoIskusKw9e2loY6FGT8IZE1KQJWuyJGw4zJK+WqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790261317;
 h=Received-SPF:DKIM-Signature:Received:Mime-Version:
 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
 From:To:X-Mailer:References:In-Reply-To:Feedback-ID:
 X-Zoho-CM-AccountID:X-ZohoMailClient;
 bh=7lZIZSx+QlsJV/18AL8WXIMywiaG9rR1zUgH+xCFslE=;
 b=n9aajKo1jJahOMWhl7yHIjUpqv03PjAW5urAsSJofTXEbehF0y6jJX3J3Ic6asVBgP1c
 1I8yvNbjmhyVdijdkDPnBbfGSToyI3UYJqX5U3foBL/TaVGJ5rn11kknJzA/uOI5lQLcj
 CEhqCjOAfG/Pr8/ZDFI391sGqiOnEOuvv1XT3zUqoJLExCFOs4OCFbjMLNW4RFNI7Cgaa
 S/OcUCNyx9cCrABTh5Y25VWGGE8boroKQik4yPJ1q/4w5lXW04Ihrac5raAEP7akfs3nS
 I9olRHDMyjBM384H2QH8cO6wVjXud0dnplMBadNHHW3NmUN9iorIl9CWhSFRoQK4BKg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=O0QhDiaA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=O0QhDiaA
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E40C740386
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 14:48:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790261270; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jrvjaw5QOHyjobfMgXSxaZaILFYVNQcQGH9n/uJVBu9qsXP/bc5bdap5U8s5q8G0+fH0zeP22xplWq+bY92Dk3CCn6FHyqRr3LjmfqHjp1Pot/edFrzK6fo65wiJSte4ckfc71nhxsAQPx+xhVIAGX5ULNWF3/2m7isZdygXsRg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790261270;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7lZIZSx+QlsJV/18AL8WXIMywiaG9rR1zUgH+xCFslE=; 
 b=JeFmKzCLpfntsGl0mLvw/OHowLDB+SAQX9ton60n8K+c/YdLTB4lnegot+46+b420HvS8az9mSMmOzspZ73bDzzP+aKX6PraJc8QgTDl+mvQaOJNan/AXS/MGXwvMCb+or7FZ3x6g+ADIsT2a3qzDLgvE+PTT8px4fL7OMPRmkA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790261270; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:In-Reply-To:Feedback-ID:Reply-To;
 bh=7lZIZSx+QlsJV/18AL8WXIMywiaG9rR1zUgH+xCFslE=;
 b=O0QhDiaAD59KLNdfquekOgthVgtei5XCkkztn3CxnGzG/th56poJhBZgOzrnL6Uw
 1WWj9fLKn/w9nJxEdgDgkjTC/fqFGS8Hnb8I88HRiyzRNo5EkaLiG5ytbkb7C4N4F4A
 VIuCLsk/6DS7PTkEHsb6RfDmSFq80ALr8BIiF7VM=
Received: by smtp.zohomail.com with SMTPS id 1790261268074585.5909210104984;
 Thu, 24 Sep 2026 07:47:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 22:47:32 +0800
Message-Id: <DLNMNDIIOCZK.3VA1P2AAK5ACA@zohomail.com>
Cc: <u-boot@lists.u-boot-project.org>, "Chao Wei" <chao.wei@sophgo.com>,
 "Chen Wang" <unicorn_wang@outlook.com>, "Yao Zi" <me@ziyao.cc>, "Lukasz
 Majewski" <lukma@denx.de>, "Tom Rini" <trini@konsulko.com>, "Peng Fan"
 <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>, "Stefan
 Roese" <stefan.roese@mailbox.org>, "Sumit Garg" <sumit.garg@kernel.org>,
 "Inochi Amaoto" <inochiama@gmail.com>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Chen-Yu Yeh" <chenyou910331@gmail.com>,
 "Chen Wang" <chen.wang@linux.dev>, "Kongyang Liu"
 <seashell11234455@gmail.com>, "Leo Liang" <leo.liang@sifive.com>, "Thomas
 Bonnefille" <thomas.bonnefille@bootlin.com>, "Quentin Schulz"
 <quentin.schulz@cherry.de>, "Johan Jonker" <jbx6244@gmail.com>, "Casey
 Connolly" <casey.connolly@linaro.org>, "Varadarajan Narayanan"
 <varadarajan.narayanan@oss.qualcomm.com>, "Alexander Koch"
 <akoch@initse.com>, "Andreas Schwab" <schwab@suse.de>, "Junhui Liu"
 <junhui.liu@pigmoral.tech>, "Marek Vasut" <marex@nabladev.com>, "Sumit
 Garg" <sumit.garg@oss.qualcomm.com>, "Peter Robinson"
 <pbrobinson@gmail.com>, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v4 08/11] riscv: milkv_duo_256m: Use upstream devicetree
From: "Zhuxu Ran" <zhuxu_ran@zohomail.com>
To: "Hiago De Franco" <hfranco@baylibre.com>, "Zhuxu Ran"
 <zhuxu_ran@zohomail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com>
 <20260922-milkv-duo-upstream-dts-v4-8-d45b74dfad36@zohomail.com>
 <arUZwbtnDO9g3cUZ@hiagonb>
In-Reply-To: <arUZwbtnDO9g3cUZ@hiagonb>
Feedback-ID: zu08011227a26ff9d3cb01405d36244a800000397c742e56ee8b6bd804c4cdbab5325317c398ab013e97a0f8:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 24 Sep 2026 17:45:05 +0000
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

> I see that milkv_duo_256m_defconfig doesn't enable DM_MDIO, DM_MDIO_MUX
> or MDIO_MUX_MMIOREG, so nothing binds to the mdio-mux node.
>
> Note that the upstream gmac0 node uses phy-mode =3D "internal" and a
> phy-handle into the mdio mux, while the old local DT used phy-mode =3D
> "rmii".
>
> Can you check this? Have you tested the ethernet port on Duo 256M?

Hi Hiago,

Thanks for catching this. You are right that the upstream devicetree
requires the DM MDIO mux support.

My earlier Ethernet test passed, but the mdio-mux node was not bound,
so it did not verify the MDIO topology described by the upstream
devicetree.

After enabling CONFIG_DM_MDIO, CONFIG_DM_MDIO_MUX, and
CONFIG_MDIO_MUX_MMIOREG, the MMIO mux, the internal MDIO bus, and the
DesignWare MDIO bus are all probed. I tested this on the Milk-V Duo 256M
after a cold boot; the link negotiated at 100 Mbps full duplex, and both
DHCP and TFTP worked.

I will add these options to milkv_duo_256m_defconfig in the next revision.

--=20
Best regards,
Zhuxu Ran

