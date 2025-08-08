Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45577C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 17:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA6E9832E6;
	Fri,  8 Aug 2025 19:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="XZjwNZfK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E41E084777; Fri,  8 Aug 2025 19:10:19 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 989338211F
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 19:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom.rini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-741b49e4b28so453412a34.0
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 10:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754673015; x=1755277815;
 h=mime-version:content-language:accept-language:message-id:date
 :thread-index:thread-topic:subject:cc:to:dkim-signature:resent-to
 :resent-message-id:resent-date:resent-from:from:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QhL5h+dd4uAuCSs10aUVkRcIeYVijeXOnSWzODF7Y18=;
 b=YWO7bhfKu7HQd8LGPrxdPvx96RafylesIhNZPzveYd/flz7Vq8L172YxY6sOfkQ/qX
 5VqLpr0yDfikt8If2hJiyK3aR8DK24MGQKEERtyURuLySgRvQQdrwWKY5GSI3yNkM4fx
 um8KsfeJ3zuGKEoGJMjX9O7+/YyQqx3l4poOV6s74h6qEI+XlwNGv5Nj8dGgEm1zXwDU
 glnF7P99hMMqpsqwqpU90jwNidl3FHEt0bZyGq8I1jBtvYb4S2voyKU7pcRMpIakB/tu
 gDOH41gdI7+T3a2FXPhgHNIHWRc7yHVaN64DSmkJ3uIGFqB7lBUU5+m191FB0ndl723N
 1BLw==
X-Forwarded-Encrypted: i=3;
 AJvYcCXfVZN98lZjlz279lHRYiJ2J8nXxIOXacBApeJPDY3o5lO7apcKRu+E7X8Bpd20J+DKtaC2+Ks=@lists.denx.de
X-Gm-Message-State: AOJu0YxnnCxTLUrQFQjU0N2tIpjm2tOGKRZil3JfidbljiP7RT5/8l1T
 llDc0dwOcPQFawMogInzrTq1oW8Cmf0QptRUrfaJiK3oM1/RJKmgKuiXshHnKvzX8k2IsbjEDqS
 Fu6iLqNE=
X-Gm-Gg: ASbGncvKdum6PADWHA6BQHCVShANnPr/TOKTGd32qeRUoPbq5EOeDkjRlw29NnDhYbH
 j85bbn4lzMQFUjvi74JWLiQ8O5iQjxs+yXngua325/s4yRLFmBNdsXzLYOWm46Ywj+5S326zg4H
 Nw4OOoU16Yg1n5Ma4zJX4GI76l7IGuSVGpzrzAAlr6CyiH28fO9bwOpE8lVX5wf2Jj2+idO+FHp
 wuz86OYd1wzJE8C4FEjq1ekWYhFW/lZ0a/szz+YHkJeZJZbEmM63T3LpPfkYKX1+JLbRjJA2bPH
 S+MO8QjqoRJfwk9ZsRVYfwfAsejPpsP7gALx75HImnwWChyAetSQDhXnvPDAxBDjUqVsb6xGw6V
 Ysd632L+RtI8jpQc6JGNBQw7HNDb8YQFywsnvYb0ugldog+TGEb0LXIRe
X-Google-Smtp-Source: AGHT+IFCLP3di+bCVLDap5X8TIflUrqE3Voj87dyQYijaZf2v+++FtxFNaxxrNfP7TuMEA4Pn1ZbPQ==
X-Received: by 2002:a05:6830:60cd:20b0:73b:2617:87eb with SMTP id
 46e09a7af769-7432c7ed94amr1386581a34.17.1754673014776; 
 Fri, 08 Aug 2025 10:10:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7430fb5fae5sm1506056a34.25.2025.08.08.10.10.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 10:10:14 -0700 (PDT)
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
From: "Chee, Tien Fong" <trini@konsulko.com>
X-Google-Original-From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Resent-From: Tom Rini <trini@bill-the-cat>
Resent-Date: Fri, 8 Aug 2025 11:10:12 -0600
Resent-Message-ID: <20250808171012.GE124814@bill-the-cat>
Resent-To: u-boot@lists.denx.de
Received: by 2002:a05:7022:6082:b0:a6:f736:36be with SMTP id k2csp1695358dlk; 
 Fri, 8 Aug 2025 08:40:49 -0700 (PDT)
X-Received: by 2002:a05:6902:6b0e:b0:e8e:24a7:7d0a with SMTP id
 3f1490d57ef6-e904b5bf8aemr3978238276.20.1754667649165; 
 Fri, 08 Aug 2025 08:40:49 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; t=1754667649; cv=pass;
 d=google.com; s=arc-20240605;
 b=UGUjExQK6S+NLgmqBPtOor8H5DzBX3k4A8QHLWOHIdO3qZWr8WXDZYCyCD6l1TlY9y
 1nRlhkGCOwgK80j7FUyBUjgQkM25nY0PPc0qak1SjerdmJymyG1nVfdx73NOr/+3EpuP
 z6fBP2TetJ4BEENmmcJgTPP/pargvvRYmJV8XLjbPNlg884P3cy3mvghZTaXI6YFCSyJ
 HdTzhhVkj92fXuWs6sgcdPc11AMRjawPav79CJqOcyOqobiPMtmUybqkD+gDo3UysjCE
 sP27Zl3pr8/bECD3HkYq/gOKndM6CPwLQQvkOdm49deQ6i3FFjp8/UmK8Q0gG1HC+sKB
 0pGQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=mime-version:content-language:accept-language:message-id:date
 :thread-index:thread-topic:subject:cc:to:from:dkim-signature;
 bh=QhL5h+dd4uAuCSs10aUVkRcIeYVijeXOnSWzODF7Y18=;
 fh=RHflAOz7rZWafvJOYdRm5r39MeoCXAV1Eh6y6+Ox89U=;
 b=draNOkEcveWqwvg43q4cuWeMru0KrEwhnQ9oRMJRD9muzJ0pGF6v62IQUS6C5UZvhR
 mImsrCwLQs5JDSe3E4PBYsvdyr6uYDYjy6A4UOz0jZk2vsccyCSUcZe8ib61lw3O67SY
 p0XK2MDgKdBC6jdpN4O98UTzNy61mA/lA17Mv3m2g35CvpJcPquNlimpDrIxbe6kV61J
 NwO+2vF651a4IS6aTzZ2TbCaUyNrI8J6iVjuTC3BGBxGCiM9FDMukIF9gtoTCAKbrXw8
 O0scV4gKZU+qY1yCeDq03blOMIk/DNJnWQJ8kah57OQ8sZktDeaY3n7i4pBq6HuuSqqa
 27FQ==; dara=google.com
ARC-Authentication-Results: i=2; mx.google.com;
 dkim=pass header.i=@altera.com header.s=selector2 header.b=XZjwNZfK;
 arc=pass (i=1 spf=pass spfdomain=altera.com dkim=pass dkdomain=altera.com
 dmarc=pass fromdomain=altera.com); 
 spf=pass (google.com: domain of tien.fong.chee@altera.com designates
 2a01:111:f403:2412::611 as permitted sender)
 smtp.mailfrom=tien.fong.chee@altera.com; 
 dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=altera.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20611.outbound.protection.outlook.com.
 [2a01:111:f403:2412::611]) by mx.google.com with ESMTPS id
 3f1490d57ef6-e8fd3864dddsi13472430276.178.2025.08.08.08.40.48
 for <trini@konsulko.com>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 08:40:49 -0700 (PDT)
Received-SPF: pass (google.com: domain of tien.fong.chee@altera.com designates
 2a01:111:f403:2412::611 as permitted sender)
 client-ip=2a01:111:f403:2412::611; 
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OP8ou+PfWJw5f/VuW/IJP3eX5arZysoCKyEnfzktMJytHlViWta8q8UXKqfm6fEJ17PwkXXpLHLkVoKU9OrAaux+Hwz3pkXPjgMS/1kgQrAZzk5QE3Be9RgRxQaRlxykHQJDPTls3D/0mQQ9j6CJCApA2p85o3nOLDv0EpGD6LlM7Ll8yLc3ADouztEE6ijEgTw3rAlE24utUzj/RlKqzvvoUN06cSru0Q/s59SXNUHp2JKLoQnPmR8iajhyV9u/oR6XQdEQZsGLRxth8SbE+orCTc5mufGAIQrrI1IRTLuInHA4aWVO3Y5ZaGWoVp52dxFCIH8LGv47z29hx9AyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhL5h+dd4uAuCSs10aUVkRcIeYVijeXOnSWzODF7Y18=;
 b=gU2PoZmwvqi+uX2swR3OL5Xw4DoF2aGlQEPoy1ec9h6RTuUhu28WPO+dg7TgUcAKpHxZhrXGLEytli7wMK8cqo9YqYd3Y/vQHS/nEV5f7RyXxgB6dIp7tp3PNTRlWbrBUo/+X5nuq6SBSv1QltDD9qhuOePVRoafMzayhdHYQAxwQ2gjqg52mgOQeE+dBacGZS5yXrGC4kc5SIO4Lg7HhzAnvMucHrt0DIfEbSjxZ8Q/UgbkA+UaIRK3v1Ino+MAGv198Y01cj61vu9jJeovBpAlAq/WF1RPlbxSvhvGxmBuhR0rXPozjpR5LqAv8+bk67dF19qOOkBjP73GCwckQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhL5h+dd4uAuCSs10aUVkRcIeYVijeXOnSWzODF7Y18=;
 b=XZjwNZfKTtIDb0/btfM9eM04vuPgazLlu1rR8x+iOb1Niepu0eCEGnqRKajJ337lrcn1D23J1MdVTCs7ZBvYnR+lqgrlPPTi1UJ53RBMmuIqq+4Csqwy7w2xN14GmO3TzLqHkejisei85KqvvVzcJDifXo+NdGuD/3Y0Zl99eXrUx8cxFVlM7WkX0QIzMBOzpn4DBHuQxUysNnFO93YTrv+eyctGrxjbXrdS2f+DKykQp7WawyKIDesx1d+4eiDXNBZZAur69PfIcw1r8WB3DP1eS+6h4KdTe8eBBPb5b0Edvcjfq/RCn4b1vORgdxOtUXqDXZwSmNXwBuvxwJ9qoA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by MN2PR03MB5055.namprd03.prod.outlook.com (2603:10b6:208:1aa::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 15:40:45 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 15:40:45 +0000
To: Tom Rini <trini@konsulko.com>
CC: "u-boot-request@lists.denx.de" <u-boot-request@lists.denx.de>, "Yuslaimi, 
 Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "andrew.goodbody@linaro.org"
 <andrew.goodbody@linaro.org>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Pull request: SoCFPGA changes for u-boot-socfpga-next-20250808
Thread-Topic: Pull request: SoCFPGA changes for u-boot-socfpga-next-20250808
Thread-Index: AdwIS9tJSaw22f8EQzuIp4D0VZ/rvA==
Date: Fri, 8 Aug 2025 15:40:45 +0000
Message-ID: <LV8PR03MB81379E5E85D3DD50DC945A5EA72FA@LV8PR03MB8137.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|MN2PR03MB5055:EE_
x-ms-office365-filtering-correlation-id: 5d7e78fb-468d-41d1-51d0-08ddd691f094
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|13003099007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bdQ26HBu5bBSjT2GQ1+TOgOLRD6EofUJM5zLAgIWLPN/rEwZg+BFsnB9NTHn?=
 =?us-ascii?Q?Z20b7Xqm3L5Oovo/stsFm2NzWBz/Oc/kGK7Z66JJYQD9T8j3QNfIxmlOi3CL?=
 =?us-ascii?Q?6YluPOOt2dAg/BxGnjf08bo4l+dPDaGxb/I2hQ+RxF61GDF33yKLvIY5cJRY?=
 =?us-ascii?Q?Kd/mp4cXsrbN91DhQ/wycqqdMtizrC6czz8knRL0ufkhevyQYveFxswoAXIa?=
 =?us-ascii?Q?AGUpppoz2IBP3PsIpbvBMvr6n/fudjPR/bGxXmLPUCSz8Pto69BC3l9VM3oo?=
 =?us-ascii?Q?HUEQBS0eoIQDSq3641lLyO1jgYu55DRrwSfx26Q4MZFllFMF+sUHXBDMOp4f?=
 =?us-ascii?Q?7kTVX+5pcas06xf422brFd6XnSmhdoR0q2TCjJfegZZ1ULxIOpJU2RwtgdPw?=
 =?us-ascii?Q?1a7W9PShNlifK6oBHkTBxA+Hi42Ezl98p9f0TS0CvgxQAJtjKqGGpo4iJgQu?=
 =?us-ascii?Q?fZcaETGWoRQyTa9VsihBkoDudqfhJ0RveE7BabyaXK73BWcOfvCO2MOA4ijj?=
 =?us-ascii?Q?ROtP7E2T25dzm6p0uir/8/7aDhW0/tel4NvFC/gHOx6OiOOdBJ22Yw9NBt+C?=
 =?us-ascii?Q?EH0Nt6ahwl3QAQfGUDsMsdYxLLyAXvyEPfcD6kQtao7/kd/QNx1z0YxCP3Iw?=
 =?us-ascii?Q?+5M/qmuNfzJbEaeni9z/HQrrYhYElMxZloPB53Xofe7xl9ayr4PIx2S3ohb2?=
 =?us-ascii?Q?tRUSLqoE/1J5gzxuxmYkFs//gdb+HxxvK8U0PqlYrZ+PURdUMQcYb9/Xqr7Y?=
 =?us-ascii?Q?xnIBINm1jCs0WFcgiBydcKnxPAVadYczj+JvVnuEvQKfs2M5iVhWQzLGQAvJ?=
 =?us-ascii?Q?5ILh1GVmIzdXNQhHL0Njn+4RZvMtDXZc8wdt8PTWUvpnZChE9lNRWrYG28mF?=
 =?us-ascii?Q?0aCG3q6ZCp+toxrfht+CTdB0D96I9UgXfV9KwePZTNb1mGkgg/hQKZl43x+5?=
 =?us-ascii?Q?VXxvOVx+TRLlg9pD3tUtj1lEWMKg/uo9GCrE8KDqlUs9gII3R+4rQ58+xntJ?=
 =?us-ascii?Q?4cpELziwDj80BUk8JuM7G9F7E4/ttmI+ZdRg/MjiKsh7kGsmtVh/2kt2hjL9?=
 =?us-ascii?Q?WmzFcUHfNbO4mzKcOZv9qWSvWvaI62+/k84Dqowmt6g34uB/1dcJKFRkIVow?=
 =?us-ascii?Q?13h/6TlkrfHWcQnJmiOVc8WKWVFN+khO56xnG9QqX+C+tQog0j0KtvrS+wM1?=
 =?us-ascii?Q?W/CwsCFcCt6d6YbN+mJUqIKHddTwhoXB+aAjG5FmH0Y91Q5dKgzwDMFfK66M?=
 =?us-ascii?Q?gG5PYsYQehgaJ/NACQ79Az18vAfDcTzwAKfPaD9ktxzOA27Z7OjyfVjvX3p7?=
 =?us-ascii?Q?hSXS1B4LKRiDx76cas8c20Qt2AOsmopXv54n0tqroK28gFtFyWIAULzX+D3d?=
 =?us-ascii?Q?EKAvtjxoDFKSQQE3QDpSqnwos8U2Zkj4jSBpvqHUH0nlFdWh8kjYPePFSDEW?=
 =?us-ascii?Q?TarSlF1UQYE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BUGe6LgXsVYOrB9tbrRT9QSpHXLPUg4iIFHbxVbTWs2pxTGXJe2Q9akV+Khy?=
 =?us-ascii?Q?QSVCxI740c/g66hJYCf1fl7/7gclUpqZgnkgv9gKQwyDRk1BCof8mHGVHEO3?=
 =?us-ascii?Q?UIY8ugZfHuTmXiA2mc+FddDHDCBlOgw2bnTZznMLk4CgiLYDOY2VKHY1Kc/S?=
 =?us-ascii?Q?h1RiPXN3pKdtJqsxMMzmZ5vsRYXoGfBFfXPOHySgMvcVNU4/fzP1S40OwiIE?=
 =?us-ascii?Q?POinza2Izpk4plO20JXf0a1DZcBEgcMO/GkubCmxATyhSCtkDSeG26gz/Txa?=
 =?us-ascii?Q?FoQuxidKfZqmCBSe0fhBeWf2DRocZ5+Z2zGj91qo9ejytjxDAKw8dOissMdt?=
 =?us-ascii?Q?Hu2JJgxUwTBDHHWaIMuKY27mDlmmY2UZSdSA+JD/tAbdYYB/y/1UCvKNJK3r?=
 =?us-ascii?Q?oNJxFJ2ONBi1lqd6MfjurSXH3hEiWOHi4amh1DaQ0vQcpD6p4xhcxYeNPk45?=
 =?us-ascii?Q?MqPOF5uOBw02kRcEOIookdeJwltXlIT1018goza+U5/bRyL3ROliFICQIiSk?=
 =?us-ascii?Q?3YF39P3XYJlSpJkXLzkevVfQSbH68PX27cpRbZ0TQhfI4pb2f0aQJ7of8FOy?=
 =?us-ascii?Q?FEe02BuHACOQgG7zR/94MV4BkcuBaUdF3jD3bDwVGBhWQabcb2Wv092zC+DD?=
 =?us-ascii?Q?m7DV3/bCwaP3cuGhZKNOJtyXOR8Ns09j1dy/eyxSByAxeOrL7plqFzjnCJ23?=
 =?us-ascii?Q?4ZWFWE+Mbv2le1Nbzm9N9KtS4UajJxbaod4nS4K7LrUfl+GAt52OhDdJG/J8?=
 =?us-ascii?Q?RGF9QsuXDsBfItC3LQfiT7BQFYoEWhxkEh3B1GTSL40WgXtaXnSTjKH045Lk?=
 =?us-ascii?Q?y7OZ6dKyk9HYaH+0+6tJGEdo8/SxmV+0TrmeKEEMnnzABQ6E60ZqcTk7pf4e?=
 =?us-ascii?Q?0tE09DcYqE4/bOF9ExH3X5Ftg5EwHbvqvvA2qPsPGJ85uw8ZIN8OWS7QaQH9?=
 =?us-ascii?Q?CstFdOI/5379FA+UnwvB/e1urqQu9YHQCuWgKVdpTIEjl3XwLYbKeqhaLZTc?=
 =?us-ascii?Q?ygMjGVquiEuKLKc96MmJrmNtwau2LTO87AmsI53izGaTfXqi3q4TxEb+i3OJ?=
 =?us-ascii?Q?NJUHZSrpFDQkEA4q12JgIUubwfrwDsuGcjNc35YdemqdTNTgC8BuiByUpSB0?=
 =?us-ascii?Q?sM8qFNrMqmcpKOxi+px/yGGjuAfeKooqC0KyjbyQjxV7j/yn4cHDlVqIR2WJ?=
 =?us-ascii?Q?/5KB/aBB3CxASFg+RlNWn7VkroVCvhPxPX4ZeejI10416Q+An4shB8757Io2?=
 =?us-ascii?Q?gt5CqxTwmHI7+vTYfJzBtrTu23YLxNZmRVDFKk2w47sgRCqBybpbOwqXsI8C?=
 =?us-ascii?Q?1mEsG66wIK+/CziNIarQiuQSOxQkCND2bv1XCKIvHVUAavWo+MP4yIcyCqQh?=
 =?us-ascii?Q?2875Mn2nfXehHZ0shWWTCtTGA8o4M5J1OoY4avbcAG21sS953qrH70bee2tA?=
 =?us-ascii?Q?U4SlOFx26JWXKtfoVQi86BwfpOrP6JJhAkcY+nSQgwtgCnveqZrEOijrjDS0?=
 =?us-ascii?Q?DkKZogihP+C9MRsqan2ioUUccnRBqYM+nii4kqLlAdJTpaInXF+1Y0YKFFA5?=
 =?us-ascii?Q?ApSukq2OXiDsZ4h32qKH8KqOYhSoFWWFoheVeoFo?=
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7e78fb-468d-41d1-51d0-08ddd691f094
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 15:40:45.0753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+tVQHgN8IehgjwnJJAgpHuWezkvyWoEyN3AcgMsYcps7H2eP+JnvbtsSe8BmjAasc1p9VGkUSScsONyg3ON7yUnTkgKUG+FwAB+dd5erdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5055
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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

Dear Tom,

This pull request introduces initial U-Boot support for Agilex7 M-series, a=
long with several enhancements and cleanups across existing Agilex platform=
s. Key changes include new board support, DDR driver additions, updated dev=
ice trees, and broader SoCFPGA SPL improvements.
Highlights:

  *   Agilex7 M-series bring-up:
     *   Basic DT support and board initialization for Agilex7 M-series SoC=
 and SoCDK.
     *   New sdram_agilex7m DDR driver with UIBSSM mailbox support and HBM =
support.
     *   Clock driver support for Agilex7 M-series.
     *   New defconfig: socfpga_agilex7m_defconfig.
  *   Agilex and Agilex5 enhancements:
     *   Improved SPL support: ASYNC interrupt enabling, system manager ini=
t refactor, and cold scratch register usage.
     *   Updated firewall probing and watchdog support in SPL.
     *   Cleaned up DDR code, added secure region support for ATF, and impr=
oved warm reset handling.
  *   Device Tree and config updates:
     *   Migration to upstream Linux DT layout for Agilex platforms.
     *   Consolidated socfpga_agilex_defconfig and removed deprecated confi=
gs.
     *   Platform-specific environment variables for Distro Boot added.
  *   Driver fixes and cleanups:
     *   dwc_eth_xgmac and clk-agilex cleanup and improvements.
     *   Several coverity and style fixes.
Contributions in this PR are from Alif Zakuan Yuslaimi, Tingting Meng, and =
Andrew Goodbody.
This patch set has been tested on Agilex 5 devkit, Agilex devkit and Agilex=
7m devkit.

Passing all pipeline tests at SoCFPGA U-boot custodian https://source.denx.=
de/u-boot/custodians/u-boot-socfpga/-/pipelines/27318

Thanks.

Best regards,
Tien Fong

The following changes since commit 3526f990b77fca1c933f1d8b24eb9385010a05bf=
:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-=
sh (2025-08-06 16:07:17 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-socfpga.git tags/u-boot-s=
ocfpga-next-20250808

for you to fetch changes up to 8eecbaf957191b159176e92175121db907c480b2:

  configs: Add defconfig for Agilex7 M-series (2025-08-08 22:20:55 +0800)

----------------------------------------------------------------
Alif Zakuan Yuslaimi (17):
      drivers: clk: agilex: Use real clock source frequency
      configs: agilex: Combine defconfig for all boot flashes
      arch: arm: dts: agilex: Update Agilex device tree
      arm: socfpga: agilex: Probe DT for firewall setup
      arm: socfpga: Update Agilex SPL data save and restore implementation
      drivers: watchdog: Enable watchdog support in SPL for Agilex
      drivers: clk: agilex: Replace status polling with wait_for_bit_le32()
      arm: socfpga: agilex5: Refactor system manager driver initialization
      arm: socfpga: agilex: Enable system manager driver for Agilex
      ddr: altera: soc64: Add secure region support for ATF flow
      ddr: altera: agilex: Remove code redundancy
      arm: socfpga: Define the usage of boot scratch cold reg 8
      ddr: altera: agilex: Get ACF from boot scratch register
      include: configs: socfpga: Add environment variables for distro boot
      arm: socfpga: misc: Exclude Agilex from clock manager base address re=
trieval
      sysreset: socfpga: soc64: Enable L2 reset
      arm: socfpga: soc64: Perform warm reset after L2 reset in SPL

Andrew Goodbody (2):
      net: dwc_eth_xgmac: Use unwind goto on error
      net: dwc_eth_xgmac_socfpga: Remove always true test

Tien Fong Chee (1):
      arm: socfpga: Enable ASYNC interrupts in Agilex SPL

Tingting Meng (16):
      arch: arm: agilex: Clean up DT settings in U-Boot dtsi files
      arch: arm: dts: agilex: Switch to using upstream Linux DT config
      arch: arm: dts: Basic device tree support added for Agilex7 M-series
      arch: arm: mach-socfpga: Add Agilex7 M-series mach-socfgpa enablement
      arch: arm: mach-socfpga: Improve help info.
      arch: arm: mach-socfpga: Update handoff settings for Agilex7 M-series
      include: configs: Add config header file for Agilex7 M-series
      include: configs: soc64: Use CONFIG_SPL_ATF to differentiate bootfile
      clk: altera: Add clock support for Agilex7 M-series
      ddr: altera: Add uibssm mailbox support for Agilex7 M-series with HBM
      ddr: altera: Add DDR driver for Agilex7 M-series
      ddr: altera: soc64: Clean up bit-shift by zero bit
      ddr: altera: soc64: Fix dram size calculation in clamshell mode
      arch: arm: mach-socfpga: Update kconfig for new platform Agilex7 M-se=
ries
      arch: arm: dts: Update Makefile for new platform Agilex7 M-series
      configs: Add defconfig for Agilex7 M-series

MAINTAINERS                                               |   7 +-
arch/arm/Kconfig                                          |   7 +-
arch/arm/dts/Makefile                                     |   1 -
arch/arm/dts/socfpga_agilex-u-boot.dtsi                   | 178 +++++++++-
arch/arm/dts/socfpga_agilex.dtsi                          | 624 -----------=
-----------------------
arch/arm/dts/socfpga_agilex5.dtsi                         |   4 +
arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi             | 170 +++++++--
arch/arm/dts/socfpga_agilex_socdk.dts                     | 141 --------
arch/arm/dts/socfpga_soc64_u-boot.dtsi                    | 163 +++++++++
arch/arm/mach-socfpga/Kconfig                             |  19 ++
arch/arm/mach-socfpga/Makefile                            |  20 ++
arch/arm/mach-socfpga/include/mach/base_addr_soc64.h      |   6 +-
arch/arm/mach-socfpga/include/mach/clock_manager.h        |   4 +-
arch/arm/mach-socfpga/include/mach/handoff_soc64.h        |  14 +-
arch/arm/mach-socfpga/include/mach/misc.h                 |   5 +-
arch/arm/mach-socfpga/include/mach/system_manager_soc64.h |  21 ++
arch/arm/mach-socfpga/lowlevel_init_soc64.S               |  95 ++++++
arch/arm/mach-socfpga/misc.c                              |  27 +-
arch/arm/mach-socfpga/spl_agilex.c                        |  46 ++-
arch/arm/mach-socfpga/spl_agilex5.c                       |   2 +-
arch/arm/mach-socfpga/spl_agilex7m.c                      | 106 ++++++
board/intel/agilex-socdk/Makefile                         |   7 +
board/intel/agilex-socdk/socfpga.c                        |  12 +
board/intel/agilex5-socdk/socfpga.c                       |   2 +-
board/intel/agilex7m-socdk/MAINTAINERS                    |  10 +
board/intel/agilex7m-socdk/Makefile                       |   7 +
board/intel/agilex7m-socdk/socfpga.c                      |  12 +
configs/socfpga_agilex7m_defconfig                        |  19 ++
configs/socfpga_agilex_atf_defconfig                      |  93 -----
configs/socfpga_agilex_defconfig                          |  68 ++--
configs/socfpga_agilex_vab_defconfig                      |   3 +-
drivers/clk/altera/Makefile                               |   1 +
drivers/clk/altera/clk-agilex.c                           |  37 +-
drivers/clk/altera/clk-agilex.h                           |   2 +
drivers/ddr/altera/Makefile                               |   1 +
drivers/ddr/altera/sdram_agilex.c                         |  34 +-
drivers/ddr/altera/sdram_agilex7m.c                       | 500 +++++++++++=
++++++++++++++++
drivers/ddr/altera/sdram_soc64.c                          |  21 +-
drivers/ddr/altera/sdram_soc64.h                          |  82 +++--
drivers/ddr/altera/uibssm_mailbox.c                       | 321 +++++++++++=
++++++
drivers/ddr/altera/uibssm_mailbox.h                       | 116 +++++++
drivers/net/dwc_eth_xgmac.c                               |   2 +-
drivers/net/dwc_eth_xgmac_socfpga.c                       |   8 +-
drivers/sysreset/sysreset_socfpga_soc64.c                 |  63 +++-
drivers/watchdog/Kconfig                                  |   2 +-
include/configs/socfpga_agilex7m_socdk.h                  |  12 +
include/configs/socfpga_soc64_common.h                    |  22 ++
47 files changed, 2113 insertions(+), 1004 deletions(-)
delete mode 100644 arch/arm/dts/socfpga_agilex.dtsi
delete mode 100644 arch/arm/dts/socfpga_agilex_socdk.dts
create mode 100644 arch/arm/dts/socfpga_soc64_u-boot.dtsi
create mode 100644 arch/arm/mach-socfpga/spl_agilex7m.c
create mode 100644 board/intel/agilex-socdk/Makefile
create mode 100644 board/intel/agilex-socdk/socfpga.c
create mode 100644 board/intel/agilex7m-socdk/MAINTAINERS
create mode 100644 board/intel/agilex7m-socdk/Makefile
create mode 100644 board/intel/agilex7m-socdk/socfpga.c
create mode 100644 configs/socfpga_agilex7m_defconfig
delete mode 100644 configs/socfpga_agilex_atf_defconfig
create mode 100644 drivers/ddr/altera/sdram_agilex7m.c
create mode 100644 drivers/ddr/altera/uibssm_mailbox.c
create mode 100644 drivers/ddr/altera/uibssm_mailbox.h
create mode 100644 include/configs/socfpga_agilex7m_socdk.h
