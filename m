Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035D8C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08AAB84AC5;
	Fri, 10 Jul 2026 14:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="RrMr+B5B";
	dkim=pass (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Nem8QQUF";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="eAmWkskB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E266084BFB; Thu,  9 Jul 2026 20:19:51 +0200 (CEST)
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com
 [148.163.158.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93EF583FF5
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 20:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Thinh.Nguyen@synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
 by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HnAQt2532282; Thu, 9 Jul 2026 11:19:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfptdkimsnps; bh=tEI9BzKlFPC3UGVqpUT
 rsF68vchQTQetFFPPaomQQKQ=; b=RrMr+B5B8kxQGTbrl/VyGensA1xc2T6Geq+
 e5yxk9xr30deD+ldtyNhQ6bu8jJEhLbDqozCRdx0myh0GcM4nG/Mz1bDBVlwzDDF
 /NZinKT/IMx/A/aRH1whyffAVhwYzIEf2HiNO12YY/TcJOz3+7BRUeKN0+glEBen
 Xa9OTHMoAhqGTQGzdFmzqZd4RsW8FygXsvv8NTn2kfTYe6G6H+D50KQpk11RSF6z
 d5CFIbfgfV8QrOjBdQp7E8THl0lv36yNE0uQg8aEbl30LGIrguhFgMTPbCT0sn8u
 LYZIERzV+n0Jd/MThc51GSuJRM/Cl6mgWEqmXUy4wqLLu3W6JSA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
 [149.117.73.133])
 by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4fagcfg700-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 11:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1783621174; bh=Ec3NOpozE8/M+GdZE+BeatPb5iNSTZFKk/H1eevHnyI=;
 h=From:To:CC:Subject:Date:From;
 b=Nem8QQUFwyHpjRwVuWq/l+W03gI+9pwQNqU7kO/in7U6sD5of0Ruz6nJREML9fpA6
 g4WQ9Z1Lj0BUXdWVeoFXCCSdmgDSz9PS20FGiOxjhbzEK/sLSlHrGt+rd5utyRAzA2
 aR+qXg5kjDAH3qszH9WMjFoz+xkgNlJw+cRuTujM5BhI+0cjKJ1v7LdnVgSD21pwVI
 EvI9ZFke2pnPmQZT/DnA1b5oFmNo4+YVoTINF7v33Bb1uogLSZO95g5xcxIa3aXP1Y
 QmzVcktrfKP0d0TNyrPZF0H0u5CXYPMxYIEaoiq91PCGmDYn7YxdTY5u5B43+mDP/h
 mN/ebCzrULYfw==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com
 [10.205.2.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E6D204011A;
 Thu,  9 Jul 2026 18:19:33 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay5.synopsys.com
 [10.202.1.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "o365relay-in.synopsys.com",
 Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
 by mailhost.synopsys.com (Postfix) with ESMTPS id 9464CA04FD;
 Thu,  9 Jul 2026 18:19:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com;
 dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
 spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; dkim=pass (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=eAmWkskB; 
 dkim-atps=neutral
Received: from SJ0PR08CU001.outbound.protection.outlook.com
 (mail-sj0pr08cu00104.outbound.protection.outlook.com [40.93.1.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.protection.outlook.com",
 Issuer "DigiCert Cloud Services CA-1" (verified OK))
 by o365relay-in.synopsys.com (Postfix) with ESMTPS id B6A37220198;
 Thu,  9 Jul 2026 18:19:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAbKxrFZ01CLKvtlMM5D32Knox5mxSJeA0phy0FXBZ6klneVEeayyU0Vvz3DgluS/N/KX6ZZRlEi5V7hubbJKo2fDKPsmGDlLirQb2wEEmLwjp4Ug+xU5f7iuEo15SFjgnFcUHqSI07q3fDYGlP/fzhnOpfWw987UAw2nD/cFzs9bwLmoRjoIJow/UNgFNa1MXgAWqb8ZkM70Ds/qnjpa+GE48Pzr2sjdzi8dG+C9CH2WfKU2szDXcbr7Lu+pwnT/zs8xFmbLT+i3pvyeHFG7Mh7UGxvg2FC1wImsDnT9lTbVpfMpWc0o64sZAjPd9UpF2rWxZZ0SXh/T94X3j7YMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEI9BzKlFPC3UGVqpUTrsF68vchQTQetFFPPaomQQKQ=;
 b=KteqJMS5P20+J7kjUZFmMoZdy+03WlCmITyDq6NyWBARdbAF4tHWgD1RHnXvc46wjSAQunvgqBqf5zDDaqykmmqgevTQZuBvtR7KYLCQn+0bUg7QyBpHvElfk0K9AZk4Pyj3fT3GOyBjKEntrdxV959ha0X4SngJe1Pbueng5ICjsVsOei5Cv1IGp+TaXEOZxP/q1fs/r3l8Pc2laz38lMgAqRFQ4z5HkhnaD2vhG1dx44w9MoWlyQw06jD7Sae7i2mm53XXT7fNlUA5hvyRppjKHOAZxy+1IMK4GcIipTVQlEef5cdfly4NFlwoceWXRDS/9Tku13Vn1RzoB9sroA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEI9BzKlFPC3UGVqpUTrsF68vchQTQetFFPPaomQQKQ=;
 b=eAmWkskBmhrCEmV7TK+LVbQgQgWo9A7yjhU2xV8freTFhba0QjdH2Gz1yzcQIyyl/tOWvTTQacwztNAEMXttiR7pu4PEkvNy9oFRumY54yuuVyVCrvgP73tb6ejJL+r4WELbuBeGKM9FalsPlvwk7Wv4YXYWHLgWF+e60NgHrSg=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 18:19:26 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 18:19:25 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Dan Tran <Dan.Tran1@synopsys.com>, Marek Vasut <marex@denx.de>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
CC: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [PATCH v2 0/2] usb: gadget: add SuperSpeed descriptor support
Thread-Topic: [PATCH v2 0/2] usb: gadget: add SuperSpeed descriptor support
Thread-Index: AQHdD894Sc7UjIZSWEm5QiWEK2xczQ==
Date: Thu, 9 Jul 2026 18:19:24 +0000
Message-ID: <cover.1783620779.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|DM6PR12MB4418:EE_
x-ms-office365-filtering-correlation-id: 022bb806-81d7-4eec-6841-08dedde69b42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: BrtlVt/YdGm1+lterFe9vENKx7NjqK0WeBvuBRVGGWIXHy+hS/RB2fW3ZwuYbIZwGH+RKWxvqKoUB7Tc4wGgCUfUEMHnj9YbRbBeUfaF6Nc1IF2Tvq7q/K5ZdHogmYjHzv74spYbBx8aUX3D56E1OPzApPGnhDb/ub/iTO8FJRmD+Tsc4/A0qbm2E+FGlQa4IrwyhczLQqI0TVkq7TO1NQL90aMIp+zNdj4XpjIRUBHel4UTwXGvep5wBcpPWxm56x0U7h8I5R2n6YpxAVTSuFqdxs3IjgpoqKszWpZ1HTM+zo98HKT0leA+3HPs093AOIqLa+1COqpYGdFnWTbi5Jqmdtq/KS7M5tMC3FqAz5OHajQi/B8j6JA8OzbJ9Djx7rRjxzvxS4PLPZ98SC6okfw2m0cf05h3st26DXhFcm+UnziRZjGI55UvRCvWKLtih4O3sE71Y/djf2Z1ACe8J0O+uu8dDtAZhQxj+6nD3oLEAsSln9YxhZE3jaf/F/UUv71avfqblkQbX4auzmTpugxmL0In3dhyzaoOHvGdvshRacydsoOZwmY+NhGBvnogqDppJlFS8YLmkZ3gGSnePuhg6OaA0OL2BGVn/qInWwxllh1hAewOKoieVt8zi3TOiedknD7ceCDaVlFyrfPAa0FL9itwE9XuLNydy77os6zNwdktM8yoUeQV/CMCJ9OXemNiT2k5/WzI9NC6ns5EumgI3SLQsxvKFsvsP96gD8Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1g8qFXzq6BQMvbcyIm9FUIy+dHCL7jRJTs0D5fvpjfvAUiylylqHfT+wwI?=
 =?iso-8859-1?Q?DbOZIeKDrctQK4Nvn3zP8cQz3ilbKwNANULMawlubLQ/KmYZVkreK02BHV?=
 =?iso-8859-1?Q?jO/jva/30s2rRRol2UdhuwJtKAYhGQLOqjli1TB5vKjP+2MEn2neWO52v8?=
 =?iso-8859-1?Q?26syR0+DOQYU8WkriKU4FLswek8ZTPHdFOuntTAND2mwPp4ufPaXyBSRo7?=
 =?iso-8859-1?Q?iUv9DPSUogvqpJv2oHxJHhs9+1T39TKu//nMuXBx++1A+g6YQ3auCRM83f?=
 =?iso-8859-1?Q?BImv3LE7DD8tYHLNEbgQz/jy4nNr4es0q614I6OSW5cWFfNF/6CpyMlpsX?=
 =?iso-8859-1?Q?+tWMZMEclt05sU7yTljovqg/Qfll6CvLAwmudBrJiHYIeU5Bs88B/IclyU?=
 =?iso-8859-1?Q?T87kVX45Kiz663DvtR21e56YCe38YHYEGVMg4rfBddWUQizFA0hyJA34Pl?=
 =?iso-8859-1?Q?8lcY6zakbvHBvdLRLBXVHqExWlz/GZil9HCN4scovqhRNxfrf9bnPvqWrT?=
 =?iso-8859-1?Q?I7oENUyy1gQmFaXLoGmlU6PGtMqMeeSMO1q4R9/9DK0MuEetwcLYWeG5Dj?=
 =?iso-8859-1?Q?gqWOrm/+N4a8JBXVKfNyw0r/WPgZVYZxlmJ3c6J735Gv9FAHygGtZKcoZ9?=
 =?iso-8859-1?Q?9siAYxtka9R8lzNdSxStE6OtiQcLyzf4CBMQfIqNNivMybh1pxkZHGgdM8?=
 =?iso-8859-1?Q?Sxm5n5M4VZs6w/rDPDWCGSb/URchOte2KgrdH/jGJfY+eSfzzvjQ4BaeEn?=
 =?iso-8859-1?Q?1YX/5eRf2Lfuk106Uf3s37tZPzGZ5MJApOvD3aXi8Bxf5wsBAxzcp43hgi?=
 =?iso-8859-1?Q?GDGKxY8r5lq9rMO6HOAHeNNVeu6wcviewre2qYzCqSorNihPttX505G25q?=
 =?iso-8859-1?Q?WTLZW4c0bsySl+39o7vhEhX+xfWLp9mvMh/As0y8G3otApypSgF0Iwp8Ts?=
 =?iso-8859-1?Q?BPr+EDrNGIMXxl3/uTn15rsRAwyd0k3OBj0/JGx5WwCki24Na4wBPQudmE?=
 =?iso-8859-1?Q?raGMaZ2yL2S+vgB4RZG9gMpYQ9e1E1vb+c4pGE09uTfRjuCUj2emK6BqZq?=
 =?iso-8859-1?Q?/QEkHHo1cDlcOlPirjKIBpUUu0XNLIt4NGqri7cMgwenripXp7iA3LGEia?=
 =?iso-8859-1?Q?37GkMLWRKujvq/horeCbOg3ToWAsxbbtBt6UTN9D514Zfc+Y6FC4K6Yq/e?=
 =?iso-8859-1?Q?Nc37K4YiiUPuSxFAwrYWhYcA/7fUj+a0x3Dd8Y4DbW6Ts+q4g8N5513c1T?=
 =?iso-8859-1?Q?t+/Wix6Mw9nJNNREX1n4LCiqRKszRjNrDlHBmxEyvgWCQrTl1X9BIbKKdo?=
 =?iso-8859-1?Q?QGbWfb9N5ztAUzKDtaIrWkRbX8oIT4L6Oesf6Op1WPmN65MfFj9egVNvcb?=
 =?iso-8859-1?Q?gOnO7jJZHD3qDEbUqCS19FGTthVCmhTF1GrjHXxPXOlEyP1S45IIPdoYm5?=
 =?iso-8859-1?Q?6a1T9pCVtBSH2oXvY2rBWwZSOeQuLoNMQgmrIfKZT2vbygvB1qe3L5aoYi?=
 =?iso-8859-1?Q?ELRgdQ6eDw7o0RYFxcYDddXumECKD2KtLFV9hQlY2GFZJvTx9CqvsNvgzD?=
 =?iso-8859-1?Q?Hbb9j2h4pZaF7owDwqK7zMxTf6mQkEGEsbbPf1Q8d1f7B5JGbOkIAuqDfO?=
 =?iso-8859-1?Q?quj/p1+t3ggovZe9IxuBSnfuE2w6BEVkJ6o7CLj9/3UCda3Qz9p1u+/zFp?=
 =?iso-8859-1?Q?Ld8eP9P8d8rMUxNoIZG87fkXmQa4wJlhottIApNtnFqtnP1kxghjYrHJlv?=
 =?iso-8859-1?Q?cMEmHrNwfkDXMEsiOwI8EyMeGmnUrqNjrGSzL+amNtTNF7Cetj5eqINr7F?=
 =?iso-8859-1?Q?Mt8+qC3v7g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tK8yE33jw/1ikWAcpvexmR2xjHpgrZh7yROVTQkLwIzQpvUASaqiKuj0Uz8o0tJ1hxk5TR0HadElgzjDkL1W6eMyikADix2J+ch4pnlwao+CgthzGqUkOOjDJIDEOCzqm2eq7DRI6fspBgRectO44BUbc0IXkaDd3tKbXkbiXd8HKw3DCGvHnHMWWeM/jUXDmXhF9YEJzUmj4ov5CtVpq7OavDHdRANvxfqC/uTyXebyrmCGRcN5zKFHmeTjBTA8gwUzXscoslkTOLNrfWh29WBPz0NpEY5Uhn561dqqBMsTPsPb19RfvwAt5OQDFO+zjcVj5weYTDz0dX7agOjFGA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ozHtks8pUysLQWFbpQgkAUPd08b1Y43SHjRogm0TUVlAE7sS/0x9jcr3waqYGl12kKhhb77T1R+Uhz2LuJX3fJVVQfga/WGzXjGxA1KjA9BfW8K+J3gflLRBOCnPodwmWxBhxwXg6KuQwHbWanmycxxPQw7aJKpqJqlfTXI9B7gM5kH+VjdG1ZD3dRgvdhu7zTfXg0VMeSwH88xwwGfHpJCQEJijdS32NQTAvuG7Tnu6IbBc2NnPDy3R0M2XW+2e2sIe5469icowKeJCWdvenWu5qMRr40nvTdQph/bdgGcPg7fd7LTi0jHJE9KdSkP38hJaCbXAXnI2jZ8AFR8A+Rc63OigFGKAuPt3S+Hcs2B2DYnhe5lx0KVad1RL4ufrYTw+Ia9OyTuUZqkXGJk6SJwHL6oSyP+1I9QOXwE/vDMZotT42AlEiD0xugdFyUJFWt5JLCdHv/g2T/I6prlQsYoHSl3ZWbnHS1w1Kv8M+xAMCfSBAuZveeIW3vZbUtHDRazVmBDS12MJLXXboSQQT1yrV8P7rw0yAfbS+1+E/9f/ct1UhqdBJU2crVheCwDGhjnL4xBS0X9mxQVkm3x4t9RJZA8kkArH5lmPWPGfBSElzD3jgCzHUOvWbfgxRyJ9DjzyWzctQlz6VRmiX78lvw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022bb806-81d7-4eec-6841-08dedde69b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 18:19:24.9670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 84Z+AIsgto4CEr6ASpSjZKePubaS2Jpusotwru1N21tg9wivOxbBh9CllsW/Apbuo+jvBWJoj7fHSUea9JJQwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
X-Authority-Analysis: v=2.4 cv=NcnWEWD4 c=1 sm=1 tr=0 ts=6a4fe637 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=3FhGs3WUeaINx9rcAAoA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: Uh84OqUy5nGlkPNZKwbyuAC45SvKKdR2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4MSBTYWx0ZWRfX+K2hg0hhvJ/w
 51qRHmlQ+AaAqySPzRp+qwrUEh2xw1iAX3ssp5ftLXaYortWRn5xvBZyC7eeWC9aQfjSTXphQet
 CAANJtonJOZcRawquJVFTIQJxSfG4ro=
X-Proofpoint-GUID: Uh84OqUy5nGlkPNZKwbyuAC45SvKKdR2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4MSBTYWx0ZWRfXw9TCmzgdrtXw
 XQZ953pQqf6MlH3Htisf3T+HhS9lQY2DRcQRf+6B4wndLxHfi1BhdMdZm6/Hd9OxKgXk/0K5zkd
 IyYBhRdt0vx4rS+vq1XTivHkQofwlYGQWFZ/rKFt9OcABUerRQc3990kvU/4Rg1AoKcqCI7LJoQ
 qt4d90c/jqS3E7XjKzLyvJHpRDox6GWFFIeqK2f/3KllE67O3rR3dfrFheJCLC7kI6OQ30jlXeu
 rQoto3G04AQpJEafOUl6kOMgFO+EnN1pmjuq1HCa0JnpTVPXEzTfHoBZpw+JosDxlfRSuXjoumx
 8q4n4sv16MnQ0lixznlrD/samnNLYppDC7kkKJXfS/SkC5rxSbyH3fPbG49TXrloXCgONQE73/6
 UlI9zjq7hKWOesoAc4KbO8pjXH58euw1oancO/83I6JajY0bfBbmhnTaV1/MwfIONfSJ7VzFzyI
 yOrgvLdZ4wvg3lCetfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2607090181
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
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

This series adds SuperSpeed descriptor support for the mass_storage and DFU
gadget functions so they can operate correctly at SuperSpeed.


Dan Tran (2):
  usb: gadget: mass_storage: add SuperSpeed descriptor support
  usb: gadget: dfu: add SuperSpeed descriptor support

 drivers/usb/gadget/f_dfu.c          |  6 ++++
 drivers/usb/gadget/f_mass_storage.c | 25 ++++++++++++--
 drivers/usb/gadget/storage_common.c | 52 ++++++++++++++++++++++++++++-
 3 files changed, 80 insertions(+), 3 deletions(-)

 Changes in v2:
 - Removed internal Reviewed-by tags

base-commit: 964a26cc6d1002343ceba393d86ee4a0cd447385
--=20
2.53.0
