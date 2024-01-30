Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F15C47DDF
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F97187DEE;
	Tue, 30 Jan 2024 15:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YBsrgVQS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 979E987E0C; Tue, 30 Jan 2024 15:16:56 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A3C287DE9
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m.othacehe@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40f021d3f00so5990945e9.0
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706624213; x=1707229013; darn=lists.denx.de;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CAaoJXhqrtMqqcnqLrQ7G7DkmZ1ZeYNeZBbsYTG1EMQ=;
 b=YBsrgVQS+TKmnl86lKpWdJXpYDjL8Ihoaw7NWQDxn1PnpVikveIglRj0thMWLiKQ/w
 30ioTD/o7O7SjBG7PTXBEGEj5UebBoCG3br955ViFoCEuh4osUU+HHWESz4WZNGYnbPC
 cJJbgeXIfwRF6itE+TYgd/Tz2+k3xQ5NrTmDKUxVHiGxad3olka81g478OhMU/Mc+Qjq
 0nkAeh0BGqRrwjolgcVFdJBw5EYtOQ+7zAlYpegNRM1oatapZJVOBhUhbPid8fnPAMRI
 Tm6HP9wUIgPzCzrdcOqBM1LKwMHUNoEIlhT7fiizZ27d6CuxOE2QnFzkR3Q6ywrYQaTM
 YKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706624213; x=1707229013;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAaoJXhqrtMqqcnqLrQ7G7DkmZ1ZeYNeZBbsYTG1EMQ=;
 b=n5RP9XVJ+Ybea8T/axMQZ6+AY6wszEpk2HdQ31GJ/s+hfgDeiinZSbXhFfWTk1QRXG
 jC9VUwtYN5dPXtsnewlJJnr6A17zvGY2UKDDYGqbhWd5ENu2NMkR3Ut2FwTtePJvxurh
 bx/2zcr7AQ+ik+9JaDuj9/10qiZJRIApjjnILZQA2mOHYnNez9CKf496QH5fZGZJUxfd
 tQsYUj21+f0l8CYyJDV/fswzCIaT2pSL3e1vtL5qqAITA4Vfl1vf+ljAgHk+sKMUQnAm
 sd6SD36BobLWIi2GCkE9Cf79gI1BzKpn7ej5jEnxYtwLg/a7XhACdmkPkzhO2BGj0K98
 JsGA==
X-Gm-Message-State: AOJu0Yymn/UtMki00QqSsCx2v95YlcjPnFYOR/OQc+qmWp5+lSUDY2gq
 CXugu1Ggg0Q1u8zvp4/GAyhEQQfKatFBsLBv96g7b+C8hnCVpsKW
X-Google-Smtp-Source: AGHT+IFVUEvfh9CN9CdWW/ZWL8Od2KhPxI8E+favoilO90n1z1sgIZJSejt3WS/EIV2HJGpDi94eyQ==
X-Received: by 2002:a05:600c:4fc9:b0:40f:cd:3885 with SMTP id
 o9-20020a05600c4fc900b0040f00cd3885mr1752098wmq.25.1706624212572; 
 Tue, 30 Jan 2024 06:16:52 -0800 (PST)
Received: from meije ([2a01:e0a:ab1:5c70:ddd3:fad7:e5a6:7e01])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a05600c350900b0040fa661ee82sm1171984wmq.44.2024.01.30.06.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:16:52 -0800 (PST)
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Peng Fan <peng.fan@nxp.com>,  Tom Rini <trini@konsulko.com>,  Stefano
 Babic <sbabic@denx.de>,  Fabio Estevam <festevam@gmail.com>,  "NXP i . MX
 U-Boot Team" <uboot-imx@nxp.com>,  Christoph Stoidner
 <c.stoidner@phytec.de>,  Wadim Egorov <w.egorov@phytec.de>,  Yannic Moog
 <Y.Moog@phytec.de>,  u-boot@lists.denx.de,  upstream@lists.phytec.de
Subject: Re: [PATCH v3] board: phytec: phycore-imx93: Add
 phyBOARD-Segin-i.MX93 support
In-Reply-To: <b0dfa219-7946-4328-9518-591f87f1dc3c@norik.com> (Primoz Fiser's
 message of "Tue, 30 Jan 2024 14:42:06 +0100")
References: <20240125164503.32097-1-othacehe@gnu.org>
 <9f20708a-eefb-4a27-a413-8a9f5a472788@norik.com>
 <878r472m2n.fsf@gmail.com>
 <99d704dc-8133-45e1-a346-ab1d05d5fb7b@norik.com>
 <874jev2dgp.fsf@gmail.com>
 <21b0d615-e5fd-4f44-aea3-ee4236ff9a0c@norik.com>
 <87h6iv3pta.fsf@gmail.com>
 <b0dfa219-7946-4328-9518-591f87f1dc3c@norik.com>
Date: Tue, 30 Jan 2024 15:16:50 +0100
Message-ID: <878r4652jx.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 30 Jan 2024 15:20:20 +0100
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


Hey,

> And see if it fixes Ethernet on the board?

Yes, it works! That allowed me to check that netboot was working as well
on my patch.

Thanks,

Mathieu
