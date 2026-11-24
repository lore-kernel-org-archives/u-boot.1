Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A02606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bK35W+5H;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=BhSWdM8+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 569F8607CF;
	Tue, 24 Nov 2026 10:11:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6YfSAVkb5Q2V; Tue, 24 Nov 2026 10:11:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2DE586069B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795515063;
	b=h+ChbiK71TKibizNOQ94WbN4dlSqJqUApTog/S9sDmt6O2mAqhd39qGDYW5BWkWVvkh3
	 LK/kGLB/J03LL62CkqxfyamVsTgkoc7uUWj9FJY/duwajBy2h3S+lcQM4MSkC8itfIKnt
	 SIOKnV5TKMGFzSyYTp/lIouhBPU/NK3J8/9apG9OI4SzhYO4LcJ6ttyc8hBghmcLpBjJD
	 e56w7n0gUdlzTFm9INQgny/THvTpW4BmuA9RbEEmmcVtqvT/qvB2sncVEwDVE5VdHdB1z
	 IYaz35jnVHqmVI8GaiKTPNUPMruTF2jtt2zH06LSHijcJeQUwIPv1OGus2NrI6Of/Ww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795515063;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM2-Signature:Message-Instance:DKIM-Signature:X-UI-Sender-Class:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lnoyvH0VJln9KzH0R2hoeh3DRae1X70eH9PEB+1N1VU=;
	b=EmWyr9SUmdPmn8Hu2DJgNU768MJTo4tcWn2KZG45xQEcLp2+ZZABjfkCb+EFAQ9o9iAd
	 xrcNIj1p7F+n7RnjF/jfeZitK4yhxvr+3grLwB63zvK6Nsuo2/AFdOkEbKjQ+n19XGUHZ
	 zJLZTikDdWurz8EKn+66nisdYgoW2I8v8+m7f5o/UuOWX8Ij/oBzzNjEHXlQHK/Z37sWX
	 wvCpMvsvMfZJ/js9WhrFlgr76XRFvvYE8ciiix0wcWdJ/2yLn53mOwua1katzvR6KJzDe
	 sufbit61WmJl3cTrOgXTbFihbgHtKuhdoOi0cUogTgxtJlvHLEXQ2pqMy6w51v3Vt1Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795515063;
	bh=lnoyvH0VJln9KzH0R2hoeh3DRae1X70eH9PEB+1N1VU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bK35W+5HI6pC23y/FTIoN8Q9l8FXi2lecCI68gNzam3qE173JsI5iLOwlkOf+zYZG
	 NHMJIL0S/qMBF0aE9NSqzLr0hV3ioGcdo9zy8SSL10fCE2WmnETHTY8l5H0Ihtx2bd
	 iaaYHLJJ0KchprtaBc1QRXd4azRo2KaYrJFZ1OhN0bJqPmgLNK5Cqin5Oz6uI+HVKA
	 9btOLbsBQizMkQRz1+r68MO2TA1J9KX+UH6V2p8+crnEB2Xt8E9nodRXcHjxzG92pn
	 C1pn54WVXjVhzFiuTJ6rUZ2eLVP6ijTbySgS6ITIDgl0x7ApzHiGmvrPEutZW6Z4mX
	 9c70a+mtHI1Rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DE586069B;
	Tue, 24 Nov 2026 10:11:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 206201AB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 052FD80F52
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:11:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9JIlwkEqE0Bv for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 10:11:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 44B5880C2D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.15.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=BhSWdM8+
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44B5880C2D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:10:59 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795515057; mf=PHh5cHJvbi5nbHBrQGdteC5kZT4=;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:qBPsmmlJf+BDvc6rkj5Uf578bdxh
 /m8gWsKQ3BWi+DXRhEIg9VyOf+6Qb8ceXjRD5nGQsdrd2kO55agkBVaOe9z/A/ZRIxaZKHfAIXA
 NyXuNdKTwSFuN/4dimJ0kZ11dY2HJZhuBRsEakfQk4sWPH12s4z9anSVQioTKxy3aleEVnL/06L
 vXQQteE9HiIMFwtn6qY0c6A6IHbGxTSt0dnStbg0hZleD5fgJjFkS0uW2iLHdBeOx1fFygUVD0F
 HXgxxA5gaE5P0jAetkkHjWcYMZT+0oyvMhO9cgT4QaA966/YVwOg2knvec7zU1NX+LC4vbPtqoj
 9CDL+pSmZXKZTQ==;
Message-Instance: m=1; h=sha256: 0B0UimizbMEBJrya26vfkop8a+QURwZF3SUD2khfDHc=:
 OBDhxBCKU5QsaFd60bkwA50IJPsyi05i4Ihilnxp0JE=, sha512:
 JIF4C06HHaicPAx8rEGEhnfdfu5pX3aJKvtgQnZMDcTSkPXIs6YHI+7hGlDGh1ADwni3lwvNCBpE0ufCqb+/uw==:
 bjB4XwUL5+3dliXp/UBzKX/Wo1sEUgK6j2b+MHVSs23eEnvm2BknnrhQAE3VB2SOjP5szQocx27BjzJ5O5WfwQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795515056; x=1796119856; i=xypron.glpk@gmx.de;
 bh=lnoyvH0VJln9KzH0R2hoeh3DRae1X70eH9PEB+1N1VU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BhSWdM8+HEIF72x51PdTaIZrbYguXQxjMSHpI2NnXqkyNhoWoxhS023Yqq4cPY+a
 Xk6JD5PNKGdMN4MTH5I+V2cbfvL451C6Y8lEtilIrdzoxDHilhXP09V3+1Y4rfbiz
 aYmDC1AZFCFMdZ931l8tIzR1cxH9sMEZ99FUdoIN5pthiifmm8S8gwLNMG+1D5oju
 QLfcCcNpHQ1/iftrTMcaAc+lUtN8mILwzLGN/6kt3+urtPlKkrxEAY3WUBj5le08O
 r1VuoBbImq+hBIUXIzMzycG5rgzXTOBYAqiXTlc6OnFVgsoZ5mQ4Rafa8sVybR3g0
 lQFC6pKb4XU4zKFsTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYc0-1yFYcT3mOs-00n5MD; Tue, 24
 Nov 2026 11:10:56 +0100
Message-ID: <5bcb7614-2ffe-425d-8b68-ce001bec3ae9@gmx.de>
Date: Tue, 24 Nov 2026 11:10:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] efi_loader: prevent set_variable() to record
 append_write
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261113-append-v1-0-4cb63d522562@arm.com>
 <20261113-append-v1-1-4cb63d522562@arm.com>
 <6e9c726c-ef44-44ec-91c1-267273ca8f4c@gmx.de> <awVPT3B3aHx4Btsm@debian>
 <awVefiAgZsYR6fWU@debian>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <awVefiAgZsYR6fWU@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t4ksEABWSej8eOxAEJAS5ZOVmKLPvMGPLLyQ/FdFSHbCmkpO3i7
 svCTW8/W9vLYzM9XqzCSW1PApwlpqCC3/2JjOaMQ9Lurg1gYjfK2YSi+CC6UiRMvZPzm3xD
 QOMxt6SJXXJDrnJIEWL3ebNnNDsUZm1irxgub1f0w/PoW1lE4bp+6002JfGsV5HaJbJFOZz
 /avt1FYATHAyC61nFRnpw==
UI-OutboundReport: notjunk:1;M01:P0:W4Ea0ZPcbjk=;ilgUuL7YIUOwOW0z4kgcsyge7zu
 zy+9TR6rdbNtgtLBWblFUqWh5TvU3bCVE9BAfqvnzBqLd8M/hiETB/BRdd2mVVRaKpwFJ1DN7
 0Pq5DlnYs7YUt+dIU48T2fnCpvLmIJqc5OMaE0yG272XxizDAjiCg3NU+UF2Y4GAb8bGFgkNf
 9wVnz0u6yo9KREVwb4MlCCxnNg9xjNn8eLFBh5E9dxGuSYS2MUHTtWUnA/VTeVC1B6pxvxTZf
 jmZWiNcJqZuhQ8rTqpeI4oSte/uArOzA8iGmYZhgYBkij8EstinnbD3JiVprywM/dHTrP52ig
 pcEmb5JuPswpHOd500NTl1rySjkx97CoKBwRuyb5DWPZVyt8EgkZ/hcMcJeg/33QmDc/X6jTn
 TPUAefJ7Y0meJK75VJi1Ign3IaHBfg4n8jjxHHl4yFQNMJtBXd31tWwsjuZ2l4ad+pbz5wUIk
 OGO6jyIRjpO3BpVzUF0/l+lK6mFIZkSKjk4YYnq9Aco+YFnkgnyf7I1U+NUuzy0VyC7X5zmkI
 feXKoYwhTXUiWdTGlRRC49wItgJlA/Fjs2Xg/IQ4oXHDgUM0TsJd4rWJmVwLWNjaPNwywMSeg
 Ug7gdySxSK3P2k62SqyuLgD2PIH617ESOffqAtXgmL9VZh+Z6CyvErzNnhIhUHmGQMl6lxt5D
 XipuQ4EjnWdWxZ9majisqMo1VbYC77vXZVvcRbKHKP7Gs/1Pr1bqd+9m3rd62V6P1HxKaNi3x
 3xjtQYuARY9vUKa9njZqCGFsSEeVOe8bSOsbCKGN6vZ++L1kok7Ul3/NYEfTgnZcB1FgefIta
 mqS5QliCB3jLTnK2UDuRWTqwY5Riylo8kuTp+MHgJmWEGOOB1uPJWStbSZXSwlmrMGren50oU
 q7xsdXgpvbhtNvwQfDnqu5pE3vvVvGib8najrIMZm9+e6rcKP3FPogk7CE738Pk4YAyJ+c+NG
 UFAztQnSY+E6QKrZn3h0tIvRZvCOZX2zWuYCst8iuv0JxhTjeY7b3/6SkgMWFLWR+qlL2xsyh
 Z13o17GZ2JL+dIkvrm4hdbAQXDSymEwAZtAYWNHTQiY0q22x8eEQtDh0+WHOF/3VCbWEQN9bU
 +kdQzylcjUnEC4xryueorODiKcsRaszMOrB36KfOKdqBFs9jO2SLb8GzaocVoVr4LkAZ8+pNo
 qVDqYFyGMfHZIrwzeZkcP667EZLuMemu7QPjunkrdLWVs7mJmQesOu9h1H74XXRwCi9shoLC8
 5ANgdh1b8bvsky6RVLEh9DQiiF8h/3LZ2oRyEGUB8tw7TTvBzVXefxQKelpoKOD+I5nKCRlk0
 cMBp8qmwDY+S7o6V4c8u7odgOJnlbk8CWg306mCdyqnOHfNY1lvsuDmySVp/yni6bFz5tyXIK
 driUxkx8nXMGS0foARWFcSGAwxn9cry8kMkMp2W0juv73GQB8E+oVt+m8Xdj0O1rBOX7myJt3
 D+AST3Zi+lSTbVMmKDxEAw1kzljmuGLR7zcAi3QleRUoPCtOy37t2X0TkVk/8EcvwhDIMPqrX
 zUCxorJLS43wehGddIgxeUY/9MvpBSMcboxOFW2LDACoRZUq9Qxo1p2svhDAZZc1Zd6S8Vm96
 tR48NFxcFz9JkR1OexKDlt9JjeTQR8Ty2W3tiYwA8CEYrp04PEmaL75mIWO8/S5/rgBAGnbU/
 kW2d6lQ/gPyT/MebziVfq2sGlMzxazlqNm2jDXuHciMzRIpbfiqgtxRC8s9prs/xBlNbIrEbS
 fA6u1AM2FaM1rYCWI7hrW6Xp2JEqYuvgp6YXKiox2zwOqwr4v/Oye895La1Gbdq+34hJo/jGK
 NXBbC20ATJcNE0g7nAxOGwee7byKioDlSgI7lOfTI6Yc8puLe2v/Yu9d3R5oW75NEXOQ8kMS5
 z34yZitK+Ioxua2XwYDbMHI4f7n5nlFOZ1TLMnkeTn3abeAQyJZ/EWFzJCtge73pMuJkd5ENq
 ey1uq6EGvCfXdE4H2om7wh9PuKvJnL6q+XiBs6zNvGf24bRWWtHpiics3qD28jsZCaMdjYHFf
 0j6oAMaSd3KzZFCICqKoZvRcqq55nO7PLslSyXuqsknQCRX/+d25j91HuG1tPgaWWPBvPKz4b
 YDgDErYi7g6ximRCSi3epPMr+tNMJB5bpBHxQ4oZmSWHah61ggvu9E9eZhbsTHIqylWiaG6WR
 0VR/SIipQGrVw202Z3Pu8/V6B1cZsUeQZYpjBH80o8AfWfZq3dWeKfAsJw3A2+rEPgPSK6T2+
 UMan9+BVxI2zD/y+vqen3puOP7ehLzEruakpshJB+r5ICRb8xExfCN96+QwXViuZ4C5ydDrxz
 XD10b0358MTqlhnr0aSUOTQVHopUUXxvPYeJ4GU4ncawWPWVGiYehRHSLGKQeMLqvhKiN/3FM
 Aq8zkVybs9ATbpIpT5IjfImaYFdCR70fO2EJEQ25jcoGqn9FnfWvfI+TgAI5VZ9T6jtiVheP1
 1pp2Wt9q4B/H8a0lsLtt+vBtvuTBJQl+Z7p8txky4Us26NONBC0QNblgXUzPY6MweH0HUL5aJ
 M5vFfNytn06+KrlFtV93da3LCaM4+KfVTzC9di9Zb5YipYBGrbXsVYb7k9DmNkSvEVe3ma5+C
 CXOvKzhY1mK5s5bv3IrbvIwMAe1EqyhhMGyY4CIENwzbqXdE+QY5pNLgDvENLyNehTnFv3BfW
 k/TqmQBFP0VszvjjSb4I3Mx2eSMCTgt6bMOlTkEk5AJX3HIFTwtyX0Cvo/XTrE3TD+Oeq7ipV
 emvc3xVQ+Ycrhw7nyu9f4+YE4zQiVaDoNUUxFk9hLIKOySjY4d8MPcxqNPVj2q10N7091fL8V
 ktj14RMlFQS90+HzNsNMFoYtlhWQpvQL8fKJxrrLBdu3QTbaLJF/ObDKc85/+EtkdcXhDoFG+
 5bY7qpGofMpcsmqFt7Govd+FjypsR5woAKTAsRtjYZkbyCPSk3NPKEZqP6Ys6eiJDYTE65R2q
 BQ9mZTBzDYpaskT/8Gc+W6duSDdQHbthdEt/RkO/O5xoLMBhfmtM5rc8lyNpd/PgoLG89Yz7b
 eQRuiqFo3EOIpgYoYhnOLHlr4ldkl1dZqp/yIuwjUP4QZ9dj6WnQeI/xVrXcf5z17RgVSOC9v
 KeQ5C4YZ5L+/m68FoOILNStyoRqcCrhO8JBQi4uvJpI6CFJtPuZHDHczj7dN/YXyM2RuM7Yll
 nIKqDy38W5+Ni1LrRWEZwCMHIfaUo84FHVz0+PreIcRWFaGQvII/FOWCE584963bizM7WMuHQ
 2Mloip3NSwcZKP6XyC5+FXaXdLiy0LqnfqJuWNBOm72IcOyJeYl3MslUrXAmwlkJu/EyEVwnl
 7A/6I6cFeba2VU0lWomeq9ZtQ3W3/JR2NYGQWVqVUh3kEeSluxSLhVUEagPDooxHrdulrnb76
 Qmr7/rmxLx6Jtt3kr4FZgqK1xbb1bQws7OPUu68Z5xOWVgmlph3dgqlmt/OKhu4u+Ge8n+cHY
 auIiVASsC8mrhc547qnMM3uhifPm55IGdMcuxR2BJ9vh09Ao40+MMKI0p4ENUJtiiypcXsWkb
 r+MuhtqTqNB2qboeTLakjm4gbxr2ItFZxRCQXqCIOI79vgcEqsk5ltgfIwzroCYBgnNE+XcQY
 7fXxdzxksirwsYvm7A1c1ha22zDQMeyI8Y2hUXMVlH4Qj0skoveA/0O8BQLYCyU+TC9ZgJal5
 R61LcdAmVaI9a7CwM5SnefBF1XspvKYHndxZUn/uyrR6tDVh4EAF4DSkhl5Ltnhm7dx6gtIIs
 V4wU+nN+LpgRvSvF9rmdlyzV37mCpvntkryb1hzJoKzaE4aKu/pz2/y5Qi2hAE5sLpzUoMiTn
 OLzbcortev1ZGiGP0kZdXH1Rn/csTOE8rCMUW5jBsjKsB6XJ6qLrmGzTHclAWE4F66dpiGdQn
 SrrCjypaiqkN9eqlm8HUGdPdkq4qNyIef1ez4NAzyB3KByFTPH0T8Kh8po0HzlaFzhHEjmYml
 Fnyk/yWr8c6IZ1H598vbB6ZwPd81M7qIMSSXBX5hwdiq+Z7rLwzGVP8q9w95FvLe/GgOKmX5j
 vu0QwyicFGQgKv6ku9S0Vm7Yo2wtdUAsj7y674ARdInMpVePVS6NZv7Rb+W6Rr90qKQA0csnc
 4UC0f1aRiCgF8KQzUy72yJRvkw/bGlGQCBiBI9TjNePBvN/GcayNi05PTKPVvHWYlIv5U+bsb
 wPp8O21bQFf0dKcT2NzSoD554R5Jx/tzOzCW+yjsD3q8XoCwsd1r/9XNKNUkHdj8PjVnSuOt0
 vQGbwdAGjRtgl4TFf2vT+THfWOxxj+32aE/cgMT0CnGeINHUb1Bavnwj0CUfOTdu1Aq8ozFrd
 e60kq3+gf34p2KSIal8qYEK/BB3e0/H45H+kjOQYLWTRQr51EAjxv60C9vYdyghwPwVOJYSIx
 SxWjFjqndJyQRx8GkJQ98wHiedU519sVjcnJQoS/7wkSWbOSr0BA5WTj9axKpyTXx+a+PVhfs
 cYyU0Es1LXOa6PgqUWsh5bOLoZCc5N5xZRqrsq0VlUmfKSUeqfAczyN4kY+nDws/8NQZbtQJF
 +stN++JTtTE8hyDYHe2KcshQgf/BnSS6SUGNX6xgc9UPV1tbuUDPKAuHvgQbq0D5kn2NoftNp
 3mwY71fSbIujp1xntxm/3h8AEaXX4SiwOe/OBSqYMlpOHAqh0QgHL26X9AqNlU6lTPK75UH74
 W9W3EXJYeF2yDf8UxCvjdgXis7lN1DhXUr34n7bqzsjT0HmuBqYWuCQGeQ/D3GxH2Gojhmw+6
 6+OJcN2BkQ8OIMy0rdlfsYGoX4dclLk5prhnkmNijRp/sut7BoxezczvrL/x9pPHcf4L/KgRT
 hgzckQOFBujPX4yt/1IAd0dVXM0sSmDaSe0nV2i0p49FAdbRsVZ18/VsjxwVzw9F4pZmmoxvI
 ae/F1vcDllDayO3cBrGGKLha01mXH92+BIM2NDcWlsXsVmvIvO+GSa/bNWdbVfxo6Nb3ktCVX
 1uNp29GwYFjSbXqmDAiQEO+FBoBMnD9mIwaCnYZEeZ0eOQRbFsVrXyZpg6xiR9PWpxhgAbZpc
 RLRc7c8EfWoTVlCDGNkYEajDCWCBf1MD3R82H8cVyJvjTQ+yKBEagDf92wWO4rhLRai5E4Mcv
 3+h/x2QoEh4x0eQwKy3qnnEK93B/JiWNj+NxIq3Qzbt9HYETrqVQAPaz97551wh4br4FfxI2M
 4YfKusRK8RIhyXLNbx656M+IZoXCL1xG60ZQ2Pu/v5kmvcX+WnyY+GOhY/ayVULULNLfUFxUV
 /JXKNMwHdzCSvgLnF0H0MVrAerxFfCkil8O/KS08ICXf2OEsh7sAn3ZBM+bRIm8UFgvl0mLYr
 dMVsooS0DSU7VIseTM5HJvgmqtyn3XJEsF9veMwlH+4sWnEbIqWbVqNNkvRYRQTKn5bh0+5UK
 EKYX1TIaaVYAJkEwdplRltXQaz6xld+zxaMjvRZPM7Yy9XW8bQknx5G7hIXsQakFDy9GBffLA
 MQlAp0VkolQW5xA9gM8PmyTkfngb8wvIlTkvhN8IueYDIRXu5ROuhnCqtg25l1QxQ0Rz/PvGw
 qaGuogqYbvNofs6lbVXjx7HvQOMF5AdeQ7TCPkOXJTHrIiwEk/mEP1u8wGNzlsAUOn7pzCRNZ
 gy+wrSDdYIzDFLXEpFgQPvNMaYvfxbF0wneZHVrWnQFrKzzFVuFkYg0c9y6RsXn1jpPfpCfHM
 Vdue1zOGsEjuqQfblwOFEVSYoaRuEzWYmuhKiU/c24s8VidxLR5bCSwVkYHAXoDUExd2JptoF
 VzoEMsOg0GfMojo1qmrylg0H3/bnNIdvjh5a1dUlAnANLC71XXawRXJW8MxI14EpoAf6ooxmf
 zlXZUqD/JEkdckWRown7yl/7cDTU8fA3LHXq3zdlJt4KP1nLsPce7OxfSGmRIcuW2KSvCgiJs
 6gVtjAHw9lKpWiq8AAmmCA2Leajfl+Gdo5gu+3NiaAtaBmKDi3I979KDqiTCxK7CZVXo4nXkC
 ksTzWuJp2z0idnbiYF5S2qm9nVXRDqe4RbPYnX6u2pi6tqtQAcXMuRKNjT9ETCFuuN88dpmRe
 HFVJetD/pxrzlgo84Z+UmkQKKs+eJi3iFmB9FIJR72UUrQe6WcpOOLlhSQI6xE/NlT80wzmhQ
 XTLhap/XvT44ynjf3VCzXDC6WNtYH/P7WIyXiy1OyjNl/cpiLOIapMgtRAy+KS8tAZFkadDxl
 hmVxKiVNMsp1axtL0ppxJd+dDKWVRf+RpLfLERZVoc48N6nR9h+qyZL/xAyPHk81LeBOPQZvd
 n7zLG2VAeDGgqnt+oNRE5dI9SZplh3f5B8zmK9odG5XMk4iizCEmUyC+Zx4h3vfOdn9ZipnY8
 92a/IBDagJ+ussmK3yMDKcpYCgDRZM5Y/NdiCeN6FOqoDIL23ukLXGXLuF/zR25of3oPAYbcX
 LUPCKPPUt/NhdelqMbwnFYt2VJyd+NByfp2oSZEK/oR9+y6oborn73vrppyb4WbidTtjQZga7
 S1KEfBdlkhPVxImbd6wuHJW5zksKylHoHAJNRmqdkUI67NDlsGaXkuJ0tPcbZNnFcOM/5H3Lq
 LWXL0IMckeR4AV/IEXm18CdiaKQBOG49atnDmm3FKMVPTVdtPV9lbnSPpxyoDjuJ+/4M+GzoG
 +kN/5lITHlxiSMjGKwobjZZTqXgnpsKoXBpUdC1GTol/2FiAxNmqjlXnn5ctz7Sh1RmOq9iZU
 mVxMgZFKXAhDf3uJ18GXJ+Pt+P+BADmtB2rv3FgZiLtYbaLnBV2rY8vsNMy8ej5PHFKwZg7T2
 dgskxCgko3LzwYeKfEDU1drUzDHk6T+b2l0KMCYuizS8LbR/lCtbAI5pxa4OmaxQ9RdPp/6as
 raWwp6PRZETJCT3PyV7yZ4eiFqwFzHffvqBFeEC5jl+g1sRoYKjpsUg19twK6c/HDNP5Idtb6
 yK/7wf6P1sPI2EcGL9+beb/a5TmXC82YjeadhO+bpU0WQwk7ljI6c0j95vK6HvUrBG0Upe5Ck
 6X3snpmgiA12PUNpNpovaocir76y7sSAQFp+xcECTJbR29kP6ChR0RByRpCART34P758BS0D/
 +nHlFkW9R5b2X0DxRnENjKXn9MOLfaJqWtKaUdWWhiVpIGCQjVDLuyZJ1RVaLKTIJGeL5ga3i
 na6n9RYk/R/1zImkC8C0g7g2QmIO/QfZiuEB4sreigZTTYTAwM4VBhkibb2Vv5Ig1AwmpHHys
 y+d3enqU3oOijjPobAfCmXZwMZh1nzJtaVEBHRZTpXQcc3TydcHbLFH7Aig7Na7WQAWbYOAJS
 F7kABKeqJAr8J7X5RBGTLxqNN5a0S1NXuqZw58OcSsoQNceOYoDi7vUgbO3oTPuJueYDbRqWW
 G2PN4EtWFHPsCDtidxC4n02soZSlfCcrCummHz5CPkL8R6gN7w1ooUq3qw0gg3LS0rUbdkp8T
 mZAWxLjKh93gdOzNBcOI4DDj6TrK7sf3ELfAtG7NSiMiG5ZaFHESYFmD0ql11BZasBMwf5+rI
 R39JaJRLYsc5TUByu9aM6Ds2b/s3GJmpUNhjj/t4Wsr34Mnu54rsP8aKsnuANN/Zo3bA+ssV3
 HoVC82azh79YNTlrq1bC0BUutr1G3scbAgmR4v6qbzTSGsbFDOW4/lcp/K9SpTFNWY9BuUv31
 A==
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 10:53, Vincent Stehl=C3=A9 wrote:
> On Tue, Nov 24, 2026 at 09:48:21AM +0100, Vincent Stehl=C3=A9 wrote:
>> On Sun, Nov 22, 2026 at 12:55:09PM +0100, Heinrich Schuchardt wrote:
>>
>> Hi Heinrich,
>>
>> Thanks for reviewing. My comments below; I will send a v2.
>=20
> On second thought: we do in fact need to pass all the attributes to
> efi_variable_authenticate(), including 'APPEND. We can thus not remove
> 'APPEND early in efi_set_variable_int().
>=20
> I think you need to take the v1 as it is, please.
>=20
> (FWIW this is exercised by the python tests test_efi_var_auth3,
> test_efi_signed_image_auth5 and test_efi_signed_image_auth7.)

Your are right in that efi_variable_authenticate() considers attributes=20
in the signature check.

How about EFI_VARIABLE_APPEND_WRITE in efi_set_variable_runtime()?

Furthermore efi_set_variable_runtime() returns EFI_INVALID_PARAMETER for=
=20
authenticated variables. I wonder if that is the correct value. Would=20
EFI_SECURITY_VIOLATION be more adequate as we don't accept the variable=20
for missing capability to check the signature?

Best regards

Heinrich

>=20
> Best regards,
> Vincent.
>=20
>>
>> Best regards,
>> Vincent.
>>
>>> On 11/13/26 16:07, Vincent Stehl=C3=A9 wrote:
>>>> If SetVariable() records the Attributes bitmask with the
>>>> EFI_VARIABLE_APPEND_WRITE attribute set, this attribute can be return=
ed
>>>> later on by GetVariable(), while this is forbidden by the UEFI
>>>> specification. [1]
>>>>
>>>> While the non-TEE SetVariable() already makes sure not to record the
>>>> attribute when appending to an existing variable, it forgets to do so=
 when
>>>> appending to a non-existing variable; fix it.
>>>>
>>>> Link: https://uefi.org/specs/UEFI/2.11/08_Services_Runtime_Services.h=
tml#getvariable [1]
>>>> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
>>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>> Cc: Tom Rini <trini@konsulko.com>
>>>> ---
>>>>    lib/efi_loader/efi_variable.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_varia=
ble.c
>>>> index 9923936c1b5..8bf2c91f3f9 100644
>>>> --- a/lib/efi_loader/efi_variable.c
>>>> +++ b/lib/efi_loader/efi_variable.c
>>>> @@ -384,7 +384,8 @@ efi_status_t efi_set_variable_int(const u16 *vari=
able_name,
>>>>    				      var->length, old_data, data_size, data,
>>>>    				      time, &changed);
>>>>    	} else {
>>>> -		ret =3D efi_var_mem_ins(variable_name, vendor, attributes,
>>>> +		ret =3D efi_var_mem_ins(variable_name, vendor,
>>>> +				      attributes & ~EFI_VARIABLE_APPEND_WRITE,
>>>
>>> Hello Vincent,
>>>
>>> Thank you for detecting this bug.
>>>
>>> If the variable does not exists yet (var =3D=3D NULL) and data is prov=
ided
>>> (data_size > 0), you still end up passing around EFI_VARIABLE_APPEND_W=
RITE
>>> in unsolicited ways.
>>
>> At least we are sure now that the 'APPEND attribute does not re-surface
>> from GetVariable() in this specific case.
>> Is your concern that we risk passing the attribute to other internal
>> functions, such as efi_variable_authenticate() maybe?
>>
>>> Should we remove the flag from `attributes` directly after setting var=
iable
>>> `append`?
>>
>> You are right, this is a better solution overall; I will send a v2.
>>
>>>
>>> Best regards
>>>
>>> Heinrich
>>>
>>>>    				      data_size, data, 0, NULL, time,
>>>>    				      &changed);
>>>>    	}
>>>>
>>>
>=20

