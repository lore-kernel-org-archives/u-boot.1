Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98789606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 00:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j/05u+Gs;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=YM7jwB0D
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D69F840A30;
	Sat, 28 Nov 2026 00:03:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IiTZpsM7-Eg8; Sat, 28 Nov 2026 00:03:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2BC8240A06
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795824233;
	b=Y7eK1LtGB9N9nSbDTj4IWeZkRl0W4DagmKBKAmAp16SOwL6G7//qpnhk9QRtQUL3U1oE
	 tpiJ+qUrpqSf5OhuHpq/+bRNTuOEOQXZl9RSecQGtJQA+DSSaELxIjAJOFIGSDld27Bcy
	 3PG7UkMkxyY/xAtoAEe/fv5/g+IZLaZft7sG7bl9Q/erbe6Hd6bTNdI4u1Btw3lRNu5NX
	 JURqRGJCYf7kDoGyxVyePJ9lkCn6eMFK+NXjU/1P1QR1GCGIT/NiSqxDApLL6i0klkYil
	 fQw51uFdwcugWzVUKv3cS8JzlY2uhhXg+uo90w6bQ3FAOO4tEQiTDqYMOIvvFWW9lWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795824233;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vsaIBZYRkuqTZ3zQ5XC5kEzbn8zIAQGhf3N47VflCwY=;
	b=fy879J62mmwu+BdWU1rOlNAcCAAk7eNjM41OU6ak9WurKwG5ncg+xxkkEcih0Oeo/b2R
	 fAaMHZEISh48pNP0eHW3/KJ0c4U4ejUt5ApD5U6c4vZm4WmysIm2hy206EedcoqyzHvtc
	 Ij3QcRyB9uLtroxIfouZPLrlT+bPQBaNG7P4e3JeGTJHp2oegKeTV00fPTW/Opd6JJzKD
	 lJvdkWuojdkfe3FFyJ7cO1K0xsupbZ1229quIPWYucwD+F+g7JfowFCXkCCqBIc5stalv
	 YdfdNx3Wkam4NdNK3Z9FHLnsbkzJsHayVyjLCsHj5DyOsDE4X6FP6IytwEb1LdGgx8A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=YM7jwB0D;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795824233;
	bh=vsaIBZYRkuqTZ3zQ5XC5kEzbn8zIAQGhf3N47VflCwY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j/05u+GsvO5kf6iK6oQyrmRvmXQEqCXhPe5lPTf31VrqIvwUeLRayNKmlyIFUXD69
	 WA7WNVZfXb30j4+nXSq5bidXrzV5sug+uPsruM0lZA5mu14ch0UjGephSvdoF4G1/K
	 qUX72B4cpWVNKoWnBMa5VgmoImEkfQYJFG4fvJmrcIqNHPkY3R3P3HAUfYc3WEVpEx
	 JwpaJ2o4prtiQzqVrjvdnPX8X/kmdEn8//1L0kLYyqkZtRUcD2NV38VssM4FMea7yP
	 oG3aXhMEK6JPfJhXB+/aZEenkU/dYJ17m4Gp3Jzn8T1v97+9xOWINnvyi8cIQsudPN
	 hL9GEZYhwYsLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BC8240A06;
	Sat, 28 Nov 2026 00:03:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 85D4C3D9
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 00:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A80540A06
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 00:03:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eooEOIJY5_Oe for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 00:03:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9B0CE409E4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=YM7jwB0D
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B0CE409E4
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 00:03:48 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jbr9D5NQMz8vQb;
 Sat, 28 Nov 2026 01:03:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795824224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vsaIBZYRkuqTZ3zQ5XC5kEzbn8zIAQGhf3N47VflCwY=;
 b=YM7jwB0Dt0HN0z7+ElivV6a5G2lj9J8+e6MNl+xAbdWfvJh17+zSkKyRmVWmFh00A8jkeO
 ofMBkjxnKoSvPfFtaIP6Q2Cp7wXOD8WQXA62PiavDC73rBx9dA5NbXB6DiemTwxYTWMyxb
 Uhs3rqpxSmGWim49UAdM3zOTQDh00VszqZFes30h3Auw9Kcbvzl0yX8hwNXT6er0eI+QEk
 opAF+oHPwPpHZDDwaBR0pkJVJzNo8eAuwavPbencDUKwVB05gv2xImZ8o2avdEaGY/M2qM
 igDyzGn7xY8MbPrWoRdM5mar+XlUZ8wocMkDLCyBIexau7OSmJe9HWuHWh9/xA==
Message-ID: <a2d7d27b-5b47-4d7f-8739-03b1ece9018b@mailbox.org>
Date: Fri, 27 Nov 2026 22:43:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] usb: ehci-vf: drop the port number
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
References: <20261127182905.2836449-1-mehmet.fide@gmail.com>
 <20261127182905.2836449-7-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261127182905.2836449-7-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 21fbe880cd02a3952cc
X-MBO-RS-META: gejaxwn8jewumd5swx3ktzxx4ownptcn
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/27/26 7:29 PM, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> The port number is left only to pass to board_ehci_hcd_init(), which no
> Vybrid board implements. Drop both, along with the switch that took the
> number from the clock of the PHY.
> 
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
