Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0085C79F9F
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 15:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F3D5605DF;
	Sun,  6 Sep 2026 15:48:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nEbp_7GILGxR; Sun,  6 Sep 2026 15:48:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8DF6A60609
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788709722;
	b=RZYdCmIEGxMUvTAErDZPZX9fHCIpmjcbfYD01AjbyWCNULYXFV8NvncopigidSf6+56g
	 9Y0DV6a/OEsjue++Qu6rYjca73lgbnn1Ozxw4lS7G1RtiSvRE5cUG6kUWU0eyACHWRF5D
	 Ah3tKou+bvJ5CK6mh82I9ACUSu1toRxPmewZkBVd1YfMhiToAa226r5rhhIyGgsG2c4lL
	 yexhIZ4x0J3RJfQp4+CJarwxBd4Es9PXMof9f/uqQAxnYcRKA6c1nsllSsjJmicILUWtv
	 ITK0M0eS8TAiuAZHu4aOFpVfZNLZVMbU52eZghPtEzKl25CakrixHMJ7z7ZAcsTFYDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788709722;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4GsUvaPqmWTllp2egI4bSasrHdcdeyAcEHTkZ8rmP4I=;
	b=inR1zvuOB8RrAsCcmrQD1yPw+PrDNMF1iHItbzBtczZHuIuPoCnK186agromd29nWmCl
	 l2CXcL2+7JA+K4AxciypoNTbpIIyWlJZBo33z4P6077ieDy8AruG/errJIBUv2hAUvD6n
	 KIwMvuuqIXHESVLnwqYmfx8ziXnC9FdLW0gTu5nOPsQLUzF0xPO6H6vIG5hNwMsump2e+
	 CYYua0Ac8iyUxejkeNZIXaPExxhlkBGk5ULc8tMvfLMX2pwkrP9gxLk49fSD9rXCuHrIC
	 ivNzuGJt0+1evrMQD8toqADZ7lqTaz8SLKXR758csXIA6oTH1jrbh+q+MP6syXScCog==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788709722;
	bh=4GsUvaPqmWTllp2egI4bSasrHdcdeyAcEHTkZ8rmP4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RmP5IFWIwiCYMErCNtJtP2MvGju/PjOmGAybl0xxt6k7kUf9ZZmz02cqSFzQqE8iU
	 F8fiMUFPLfjZ5Z7r7gcKkOSX+/Xc2jTl2GOV7NtNjasEvve3VTFTrGc5q9Z29jD0JB
	 1mHqHOTORDIvGXbH9KNn4y3u14N3jXcAM6xKD9GYxu4fW58AsQ86jksaPmR5nCkcum
	 7ovFEBvOw5COH0manxetSUJkyDDkPMQYJ4bG9+61S7Tw/sqydRv9dApV5dF/2jzppI
	 +fl2C/65ZsJwXJqGqvUDF3/HzqjpsbPwe6JaMxUkiELDD1Q+p/c3Y48LotKnKrhv6o
	 kjnF7gnmgsfcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DF6A60609;
	Sun,  6 Sep 2026 15:48:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 08237970
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:48:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EDE1D80B79
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:48:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mX6S9SkeBmKr for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 15:48:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A8D0880B63
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788709720;
 b=FKE0yWgPmklx4OFm+bey+Z6P6R2Q5TgcdtQhe7ebSTDTqZJYjbIXrrgv6EnLIb2yYn6Q
 2o7UpuEmgD/8BCiGVgTZ03x4xP6yv/UxghjXE1UXAlZPWr8QmI9k9a79GubzSxzjJIQF8
 pdSUBz+Mz9FJ667T5vQT2gSAWg7nn7B1BrGQlravjNFw36wysOfnU6xgps3RzWfNqp17/
 Hk8/Tz8SBGTE3KiJphR6LApx84sZ2J1st3dWZrTj3CVsl3RhQ/RgzzgDoIG1ojk0ltPFa
 fhBYVnw2qgnRvDhUc1Kg5sHhVJksFjj3+MA7Kz3km/WsND9OWWhVdy+xyAo9YGANi9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788709720;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=4GsUvaPqmWTllp2egI4bSasrHdcdeyAcEHTkZ8rmP4I=;
 b=VmNVbLjRvGsIPPwAATa7L6cZj7d1emF/qvbQvmJJFzx4M5G90sR3k60m7sxgziD7Tbh7
 hytd488eJY+p7LKMJGJLf0U/CSDmM57fWMkujvh1Zgo7ajqFJMZTjhuIHtA+GnD0pngOM
 AH4y920wUS+AI84ord3SXeJ/DhtVrJ/2bPlt1xj0tHSRqxU8UOubAjHqFFqpA58/RNtZ0
 m2WQPbmVMbPK2X1w0Wk7kGqOdOrpeWqo/HFTc8ovQS49pJfmozJrFphR4TaiZ4Y7iG/Ik
 Y1CyY40bgosZLBNvazRAh1Oj8w9uh6N9nxJN300AcUNdGtyC7wcFO8pTzjHWx9wi9Sw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=plxsKa4j; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=plxsKa4j
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A8D0880B63
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:48:38 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso23720085e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 08:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788709717; x=1789314517;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4GsUvaPqmWTllp2egI4bSasrHdcdeyAcEHTkZ8rmP4I=;
 b=plxsKa4jHQLd4twCrOSwgHip+ASrXOMevpZRx2lw7t8hjTwNUVnKRjoHDGgDMMK78c
 iZ0MmT3vbMRRmIlXSF+5o53rZXiDu9HS9bXjiWbKGx4UJvXciU9B5lV6HXoNYWT6cpPx
 oieWxIfqg9/WEPs2HYSZN17/vNRgRRKS4AZNbXJswLhJwRg6eh8lilxFZUf7JFOlHSgv
 /9ji8f5D2PqJnNKwuoH7MCHkNq8uVGmjwfA+Ou589F2/v2+c+7Pz1NoP9IRZ/vH5C/vO
 5hMiJYDmON5K7AxbVAr3iMej+FtvLdG32CbaEhiSfJbYD5Gsva6xZuyhZQn/sLcaBKZe
 S7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788709717; x=1789314517;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4GsUvaPqmWTllp2egI4bSasrHdcdeyAcEHTkZ8rmP4I=;
 b=d3XogOeFrzJwoV7NZ3ZpwZoFcmsIPSO6527+Un4A+gfVeQshQTp5MsIatNYirZc38D
 B9a60o4okn8OT+tqlzLYx6jEqdfMWymWTK8S4Vnr4BDuOafx63u1fO2dWKsuO+oKmIeO
 AgHpfDtlAf3F9LxaHNbZn0tBxT4FqGtz7gM9J9l10DdO51ZK8DUNSytjRNpDHfc0c9pU
 Y9oAFwU3ASbUxeDnozVC4p99P6xOEvJ8N6GYKi7/aKD1V2O+QUl2XmohGuYFajdMJRr7
 /x/Tq7eRvIoNDLnjBxY4CEo3sMB2vZA0MD8OAvl5EBWpn1nypE8M4d6ITL75IrCARiWJ
 gzdQ==
X-Gm-Message-State: AFuF++lSzNOl1faIkr5qlZAHdH4rWQ6Q1zD5DYEZwKWjCJ/Wt6I+rCIo
 2hGZKBNgAbyw/7BdxhRqZ6xSqg4awGK3t9yM/RGp8hQQeJV+IYdj4o1nDNe05SzDl6RaPQ8l2Kg
 cQVX84Fo=
X-Gm-Gg: AYBFou3cSCKv4y026vnaiNC/niGZaaV3DNwfQrPFzhCV6hK9xTwOPY9VYEvNUj5n1b/
 Fijz73H7nb/YSnvWHumc+hQMnWl36ux42hW6HV8EGkcw3Y6/MpxaMPqICGHBmWiJPNzKkfklj2N
 BLyJKXdRe35UyGcYV3DYF/186Lr4G3+xmnLlecmgs0azyVDiRlSyib6nfWdHilNBBIBJU4J0Pa/
 2H+06XN5XES3M8tNSWRGU24uSZ08drIRuQdKZYAKXAEsth0YTYVy3/6VCG9LL594ilcEo0953Ef
 8INxuKos4g2JTqhLwP6j4f7HKL7nhOctXj2uwo2OrQIZHDQd6/g476RQK73WfW20so/Z4yfLo6e
 rAaLUayVBae5bAslRS6t2MiJhdrrf9Df5aUTZORp3tyVnohXZuouPzPpt0sPkOfKQIA3jW6lFsj
 ITYiCElvpCLXJgOVCN9LdiO1Kmhj5fMOdKE38aPROmz93awmVf7aWidn0+uipct9tE2UXbhelft
 iGaf2zTOTtFitgKOwLcFu8mTxXaT/npkRHcPUMH1RUd2C8=
X-Received: by 2002:a05:600c:8b66:b0:49c:fa20:cbfe with SMTP id
 5b1f17b1804b1-49cfa20cd6emr162875085e9.21.1788709716958; 
 Sun, 06 Sep 2026 08:48:36 -0700 (PDT)
Received: from macbook (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf772692dsm292977355e9.10.2026.09.06.08.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 08:48:36 -0700 (PDT)
Date: Sun, 6 Sep 2026 17:48:34 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Macpaul Lin =?utf-8?B?KOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v4 0/5] Add fastboot to SPL
Message-ID: <ap2LMlIywWYG9f20@macbook>
References: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d@baylibre.com>
 <apptlqfQNXrfESch@macbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apptlqfQNXrfESch@macbook>
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

On Fri, Sep 04, 2026 at 09:06:39 +0100, Carlo Caione wrote:
> On Thu, Aug 20, 2026 at 20:08:24 +0100, Carlo Caione wrote:
> > Some recovery and initial-provisioning flows need a standard host protocol
> > before usable firmware is available in persistent storage. U-Boot already
> > provides fastboot, but the implementation can currently be started only
> > from the U-Boot-proper command line.
> 
> Hey Mattijs (and all), could you please take a look at this again?

Actually I got an off-list review so I'm preparing a V5.

Thanks,

--
Carlo Caione
