Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C340D606A31E
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BA/K1mL7;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=4J/wFch0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78096813AC;
	Fri, 23 Oct 2026 14:55:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6CBBMhrAhxj3; Fri, 23 Oct 2026 14:55:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3B5C581303
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792767329;
	b=Q1R7x5GqzP9uVCC4dDlk0FkBA++NZ/sRyDqHWcutcTMLipdT+cn8Rj5EV/w7Z9g3ITrD
	 hB6pYs39MAGT4+dsnfOj48va/ktDnLWxEG/xe7IRWtgJbarP0IqvdxUp/isXC2mfh2w4b
	 JrOnxLQZ/fkGvmNFUNCpsC4BChnhcaSTvdVqOFkuOiMj/SIf5G+GgEZpysYXQCj6MTUM7
	 qX2y/m+4viMpvKNzYhYRhxtQNogWUI9XUTCDV+ypWpnxdGGd1rPxyh/FvkBNGIigWd+53
	 i5cBqzZor7rsf9z4XX83KQFQ0JJJ+z5tvgbYKrHr7PkekjACzAeOkoN+KvL5GQUoqOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792767329;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=twXp1QWFYRMiMNtTosMX6pmD+Wat58Nx5phZT/7Wyv8=;
	b=JDDj/4ODzLK+SWMZ3cnHaK159G1xqXIVhTrZ2bL7s0JJSEXSEKDL9mKyKmYKVrr/UpAa
	 8BCSivnjmEPkHPsik1Nr/qlsvXDDjdMBr3ojRdvTnUVAv06qgw8S7UTmv4thlPDSet6cs
	 5/rquYULSVcGRS1d/7OQFSPMblHvHwJ+HuTxb1o6Yf19j9uPhJ1NvOjoElK2M+TJ2MVnN
	 mFubaRUpqy4UlrvYxxXRmuECuZshGMfQeTPWzIVwB33ekKpFhQRlAOrgB2yWkRHsQUebW
	 gkRb6O38WQr1pybVectBFxpFUDpzoM9nn9F5cMM5GlUGYL/mMyImlpD/0WALAeNgBdA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792767329;
	bh=twXp1QWFYRMiMNtTosMX6pmD+Wat58Nx5phZT/7Wyv8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BA/K1mL7GcPGEVPsNQ5M23JisY5ncq6IqBPy51UTCwWX5XYUGWE5gAz7df84o83Y2
	 Ngf25qRZeiYax5HfjhckK+gTQ0Q/8Z3U7O9vGHd/xwRU6GzzJQq1m43Jx7tongNXZX
	 W7FFIul2uAmKxUG8XpfCW6e9yq2BNb7LpjWT7/xMSEsFjT90QM8vN0lXoeUCpfr/M4
	 TQzCmPfnfj+twIyijexwqlv9MDtd3vMXKDSb0gUdMebmfaA8K3BYFhw8CEcyR5LKLp
	 GRKYuYYiSVHe6LJG1gzW7nSu4PQUj8TQkus5XM9lLOYtTGsLi/4VvpNY6fCl+q8Hag
	 2L4Cf6IAKIs8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B5C581303;
	Fri, 23 Oct 2026 14:55:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B82C43C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9DDA5401F1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:36:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7jIahprXklZO for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 14:36:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4C0C5401DF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792766195;
 b=Fy16WDy0Ro9SIEXRo/6G9vY+jWwN22QxK5ikMLd/5MB4BPY9+h7EmQi1p9zEkpuvcF1h
 QAxFfgHQYKL+sq9FleuH7MS5J1v2yt62hyvFLtg/3G1/C9zMzWqff1zhOPdXtQoTbjupD
 Q4ATPw55P+kXjhIQk95k1xbxYP3iktyR6J/OK/3FcU54460ZB5goQ0Qlk/1cW+R3f30/v
 hxuQANTLqz8x5jzWZ5VTtdpYHCUSmbcyHS+EgrJtG5H15zXyL7W2dz3+0+CfYtV0S0uX6
 byZ2v9X4syyZk7lUdyLgaFNcWvdubcsthdypmSllCG10ajYFhCobxkUGypuhvE+5XHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792766195;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=twXp1QWFYRMiMNtTosMX6pmD+Wat58Nx5phZT/7Wyv8=;
 b=RiwjEiXTm40dV5ICODvNcxM+LXoRmn+0FIPx0iIo4XhOzO/cNztaRrdHOdegPAmbE1gb
 hOtKl2bHscgzsfugnrg9Wri6lcfqIrBNxoMeMHAC9oBI7gEYw/BvcrzxG3NZKaThd4SnF
 321AQXX5LG82YI2t01O0N552d0P9IlgIlqOpsAfy4LrPF8EijlIPSRhvzDnHbiHzMsag8
 PcEmQuRq1V78STJRw/l2YOTTAoYX/KMacoM4Ixo2wT/LzSQrrooSl7e9O4eReO8Do/ou+
 i1qyOlZTCg/hIk88F6GkBldsqjsnp3eDutKD35IvZCsaJwi9/9oHaAO50+F9sBFxvQA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b="4J/wFch0"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=4J/wFch0
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C0C5401DF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:36:34 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so6833035e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792766193; x=1793370993;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=twXp1QWFYRMiMNtTosMX6pmD+Wat58Nx5phZT/7Wyv8=;
 b=4J/wFch03fBO2utrjJz/iHhGwCtgaVkPr2iLJlbhpSptzKFbDwTzmZFJDPIRNPeCoS
 aQ2dWG/EPer84HuSK5hoAKqKr6E9H/YSZrzUupS+wTiYtFIwaWz6R/XJvdrPgIF98XIm
 d166FZYmxM+lhx3YVOKQaQ4GGQr5YwPlblSYH1PD/u1zwJRokIPkLtBpvRAJm65M2mQn
 gt05fz8IIRtlkV4Oahtp3cABHC2+TY1o3Mf0YYsCB2l8Rszbs3At3CEskecSe6KeLHYc
 ADOYIFVtwC77rH7axccldqrnv4HxL0C9fKoexQbJLkpNBFVzr1nC0K1NnRDnqZNKHxH8
 mLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792766193; x=1793370993;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=twXp1QWFYRMiMNtTosMX6pmD+Wat58Nx5phZT/7Wyv8=;
 b=cRVhOx9oZ17vL8PZqpcC+mPaTyehfzCNJrv6FRqWu0AdvAJ6fd9s/detJh0DEdSBvz
 E+WGu6JEYH4TrAf8u/9qk2JWdcyZZVtklibxkDhVRo5+bOdCofK4lP0CSvAhadLenBMu
 QJzLjoc5gLM2hzKr7jidNb2SaWAtNZitvtunV4rTWyPTdqcgKcyeuLh53uQeke1KgjRT
 r+l8gdk9jWvoOHJLqNJl12r487g5VSoX2R1X+22bX5ZliHCdvC1D//S4CZQVXSqdP3Bo
 LHboEGHzOpXZ2dmGs4iiAbbl7bPNz0tvXYOThJC1tc09rSjntdm60WKTSrDLtAslFpdk
 daCA==
X-Forwarded-Encrypted: i=1;
 AKwUvByLhkprDbXzd9eS3DAD38nw2hxXuSzncosn/Jpl+AR9o3SOJTy1liCfvS5xUQBD8Pl4bnlhjz8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKxODRdyfngVAUyiznQXb+dKYCnwFes7UmWemwgiqHMj5T3phol
 6/3JQ0nxTA0ztOQNvBsJjmS/F3wTQejhjIDkYy4UX1k5deinUeKWgvs5uatV9tTSgpg=
X-Gm-Gg: AYBFou1Eep+Bo1rU3FlLbEqOG+mIOxdvMhnGE8pmQQI+cbJeTx4ae/AyScjCNxsKb0J
 NfmrKIzhDr+aWLjyfiieFjQkKn22hN/7rnzkVU7XkuKqFZ5pKipjyZoI9OSRx1WEdBW+3GdfaIx
 oZilA4mJfStArO2JxksCyTFYKZNnmN0fvWmAUKnpsNzkbjwyP+nYxHHvqvxSUWJi7l5E7rkS+E/
 Dla/DiyczgabsIVAME6HiXUw5Gnwogr2Efqzq9v033IKGGbYK55PmMQc3J3jTiOmyzthMdTASUL
 EHu/TJ7G5H/79U0WhaVnh7v81TERS1h08sIbAOsXEv7HzDbVr6fuDPCb9Np1+BnF2G2xmluuvqn
 dqmB7S4frn0geTTQcq3jZjLJokpPrPktUmA/j31hfvE5R/YbxFOxwZrk8VzcZeq5ZFMubSyo1XL
 C746poa5RNBVF3DlJtZsHydz2JgmlfMkPiSEBYz/p7kwUurS/W9mYvksDaw4e7Sn67G3V1EBDNQ
 vVocOKcboQ6dUNc5v6h/ZdQ5oDAU6HLiTaOp//YUGnh6uP5qrF3N/dM2rDJYwCurhoOP3E16zUR
 +gDjuYBVJC7CZsEJ10/0FKHbS4Hq580ZvIQ=
X-Received: by 2002:a05:600d:82e4:b0:4a2:1655:87e2 with SMTP id
 5b1f17b1804b1-4a21655890cmr32981745e9.19.1792766192613; 
 Fri, 23 Oct 2026 07:36:32 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a29cd9d0aasm9906875e9.3.2026.10.23.07.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:36:31 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 23 Oct 2026 18:35:56 +0400
Subject: [PATCH v2 3/3] rockchip: Share one default env memory layout
 between common-stack SoCs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-rk3576-load-addr-v2-3-d2a42a1e90df@flipper.net>
References: <20261023-rk3576-load-addr-v2-0-d2a42a1e90df@flipper.net>
In-Reply-To: <20261023-rk3576-load-addr-v2-0-d2a42a1e90df@flipper.net>
To: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Coia Prant <coiaprant@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andy Yan <andyshrk@163.com>, 
 Liangbin Lian <jjm2473@gmail.com>, Joseph Chen <chenjh@rock-chips.com>, 
 Tianling Shen <cnsztl@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Chukun Pan <amadeus@jmu.edu.cn>, Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Nick Xie <nick@khadas.com>, 
 Jiehui He <jiehui.he@foxmail.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, John Clark <inindev@gmail.com>, 
 Deepak Das <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>, 
 David Bauer <mail@david-bauer.net>, Xiaobo Tian <peterwillcn@gmail.com>, 
 Sebastian Kropatsch <seb-dev@mail.de>, Ilya Katsnelson <me@0upti.me>, 
 Niu Zhihong <zhihong@nzhnb.com>, Suniel Mahesh <sunil@amarulasolutions.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Loic Devulder <ldevulder@suse.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Levin Du <djw@t-chip.com.cn>, 
 Fabio Estevam <festevam@nabladev.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>, 
 Banglang Huang <banglang.huang@foxmail.com>, 
 Eugen Hristev <ehristev@kernel.org>, 
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, 
 Jianfeng Liu <liujianfeng1994@gmail.com>, Lin Huang <hl@rock-chips.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>, 
 Johan Jonker <jbx6244@gmail.com>, Torsten Duwe <duwe@lst.de>, 
 Heiko Stuebner <heiko@sntech.de>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11258; i=alchark@flipper.net; 
 h=from:subject:message-id;
 bh=W/WeihNP8DLQpmg5sFWxX9/QT4iV9A0TtmLjlVkfaSY=; 
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTdLji7Yo9JS/vp5AKVTyHPLZ2t/b1qV3rOLp3lmzwxb
 vpG9dbZHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz1l6uMDIdl1Gr3PF4irV/a6n/NNIpzQlJu7UKdkoUvtGemL1pu4cLwPzy/4R/
 T1v237F4uSJj7Xfp7Tsb3Bu/t0soH//HMFN93hxkA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Fri, 23 Oct 2026 14:55:23 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Each SoC with the common memory layout carries its own default load
addresses, in one of three variants. None of them suits every board:
the PX30/RK3308/RK3328/RK3506 one puts ramdisk_addr_r and
kernel_comp_addr_r in or beyond U-Boot proper relocated to the top of
128 MiB of DRAM, all of them overlap the new SYS_LOAD_ADDR, and the
RK3288 one uses that very address as ramdisk_addr_r.

Define a single layout in rockchip-common.h as offsets from the start of
DRAM, and drop the per-SoC copies. Keep everything up to the ramdisk
below 96 MiB so that it fits boards with 128 MiB, and stack the windows
so that loadaddr overlaps none of them:

  0x00200000  scriptaddr, pxefile_addr_r, fdt_addr_r, fdtoverlay_addr_r
  0x00600000  kernel_addr_r
  0x04000000  loadaddr
  0x05000000  ramdisk_addr_r
  0x0b000000  kernel_comp_addr_r

This trades some headroom on larger boards: the kernel gets 58 MiB, or
74 MiB with bootstd, which never uses loadaddr, instead of 128 MiB, and
the ramdisk 96 MiB instead of everything up to the end of DRAM. A 32-bit
zImage, loaded below 32 MiB, also relocates itself before decompressing.

Require a layout from every SoC header including rockchip-common.h, so
that a board disabling ROCKCHIP_COMMON_STACK_ADDR fails to build rather
than coming up without load addresses.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 include/configs/px30_common.h     | 12 ------------
 include/configs/rk3288_common.h   |  2 ++
 include/configs/rk3308_common.h   | 12 ------------
 include/configs/rk3328_common.h   | 12 ------------
 include/configs/rk3399_common.h   | 12 ------------
 include/configs/rk3506_common.h   | 12 ------------
 include/configs/rk3528_common.h   | 12 ------------
 include/configs/rk3568_common.h   | 12 ------------
 include/configs/rk3576_common.h   | 12 ------------
 include/configs/rk3588_common.h   | 12 ------------
 include/configs/rockchip-common.h | 34 ++++++++++++++++++++++++++++++++++
 11 files changed, 36 insertions(+), 108 deletions(-)

diff --git a/include/configs/px30_common.h b/include/configs/px30_common.h
index 2a3dc362f98d..5698e6a91b1a 100644
--- a/include/configs/px30_common.h
+++ b/include/configs/px30_common.h
@@ -16,18 +16,6 @@
 #define CFG_SYS_SDRAM_BASE		0
 #define SDRAM_MAX_SIZE			0xff000000
 
-#define ENV_MEM_LAYOUT_SETTINGS \
-	"scriptaddr=0x00500000\0" \
-	"script_offset_f=0xffe000\0" \
-	"script_size_f=0x2000\0" \
-	"pxefile_addr_r=0x00600000\0" \
-	"fdt_addr_r=0x01e00000\0" \
-	"fdtoverlay_addr_r=0x01f00000\0" \
-	"kernel_addr_r=0x02080000\0" \
-	"ramdisk_addr_r=0x06000000\0" \
-	"kernel_comp_addr_r=0x08000000\0" \
-	"kernel_comp_size=0x2000000\0"
-
 #define CFG_EXTRA_ENV_SETTINGS \
 	ENV_MEM_LAYOUT_SETTINGS \
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
diff --git a/include/configs/rk3288_common.h b/include/configs/rk3288_common.h
index 327e32b66566..0b7daac20b55 100644
--- a/include/configs/rk3288_common.h
+++ b/include/configs/rk3288_common.h
@@ -6,6 +6,7 @@
 #ifndef __CONFIG_RK3288_COMMON_H
 #define __CONFIG_RK3288_COMMON_H
 
+#ifndef CONFIG_ROCKCHIP_COMMON_STACK_ADDR
 #define ENV_MEM_LAYOUT_SETTINGS \
 	"scriptaddr=0x00000000\0" \
 	"pxefile_addr_r=0x00100000\0" \
@@ -13,6 +14,7 @@
 	"fdtoverlay_addr_r=0x01f00000\0" \
 	"kernel_addr_r=0x02000000\0" \
 	"ramdisk_addr_r=0x04000000\0"
+#endif
 
 #include "rockchip-common.h"
 
diff --git a/include/configs/rk3308_common.h b/include/configs/rk3308_common.h
index 2de55538fdf1..f32ff7952591 100644
--- a/include/configs/rk3308_common.h
+++ b/include/configs/rk3308_common.h
@@ -13,18 +13,6 @@
 #define CFG_SYS_SDRAM_BASE		0
 #define SDRAM_MAX_SIZE			0xff000000
 
-#define ENV_MEM_LAYOUT_SETTINGS		\
-	"scriptaddr=0x00500000\0"	\
-	"script_offset_f=0xffe000\0"	\
-	"script_size_f=0x2000\0"	\
-	"pxefile_addr_r=0x00600000\0"	\
-	"fdt_addr_r=0x01e00000\0"	\
-	"fdtoverlay_addr_r=0x01f00000\0"	\
-	"kernel_addr_r=0x02080000\0"	\
-	"ramdisk_addr_r=0x06000000\0"	\
-	"kernel_comp_addr_r=0x08000000\0"	\
-	"kernel_comp_size=0x2000000\0"
-
 #define CFG_EXTRA_ENV_SETTINGS		\
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
 	"partitions=" PARTS_DEFAULT	\
diff --git a/include/configs/rk3328_common.h b/include/configs/rk3328_common.h
index bd2bfe291033..28e190e2ea2c 100644
--- a/include/configs/rk3328_common.h
+++ b/include/configs/rk3328_common.h
@@ -13,18 +13,6 @@
 #define CFG_SYS_SDRAM_BASE		0
 #define SDRAM_MAX_SIZE			0xff000000
 
-#define ENV_MEM_LAYOUT_SETTINGS		\
-	"scriptaddr=0x00500000\0"	\
-	"script_offset_f=0xffe000\0"	\
-	"script_size_f=0x2000\0"	\
-	"pxefile_addr_r=0x00600000\0"	\
-	"fdt_addr_r=0x01e00000\0"	\
-	"fdtoverlay_addr_r=0x01f00000\0"	\
-	"kernel_addr_r=0x02080000\0"	\
-	"ramdisk_addr_r=0x06000000\0"	\
-	"kernel_comp_addr_r=0x08000000\0"	\
-	"kernel_comp_size=0x2000000\0"
-
 #define CFG_EXTRA_ENV_SETTINGS		\
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
 	"partitions=" PARTS_DEFAULT	\
diff --git a/include/configs/rk3399_common.h b/include/configs/rk3399_common.h
index 76f40e7cd5f8..50d63ed6bc34 100644
--- a/include/configs/rk3399_common.h
+++ b/include/configs/rk3399_common.h
@@ -19,18 +19,6 @@
 #define ROCKCHIP_DEVICE_SETTINGS
 #endif
 
-#define ENV_MEM_LAYOUT_SETTINGS		\
-	"scriptaddr=0x00c00000\0"	\
-	"script_offset_f=0xffe000\0"	\
-	"script_size_f=0x2000\0"	\
-	"pxefile_addr_r=0x00e00000\0"	\
-	"kernel_addr_r=0x02000000\0"	\
-	"kernel_comp_addr_r=0x0a000000\0"	\
-	"fdt_addr_r=0x12000000\0"	\
-	"fdtoverlay_addr_r=0x12100000\0"	\
-	"ramdisk_addr_r=0x12180000\0"	\
-	"kernel_comp_size=0x8000000\0"
-
 #define CFG_EXTRA_ENV_SETTINGS		\
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
 	"partitions=" PARTS_DEFAULT	\
diff --git a/include/configs/rk3506_common.h b/include/configs/rk3506_common.h
index 5e4ef67289f0..075ce2edd64b 100644
--- a/include/configs/rk3506_common.h
+++ b/include/configs/rk3506_common.h
@@ -17,18 +17,6 @@
 #define ROCKCHIP_DEVICE_SETTINGS
 #endif
 
-#define ENV_MEM_LAYOUT_SETTINGS			\
-	"scriptaddr=0x00500000\0"		\
-	"script_offset_f=0xffe000\0"		\
-	"script_size_f=0x2000\0"		\
-	"pxefile_addr_r=0x00600000\0"		\
-	"kernel_addr_r=0x02080000\0"		\
-	"kernel_comp_addr_r=0x08000000\0"	\
-	"fdt_addr_r=0x01e00000\0"		\
-	"fdtoverlay_addr_r=0x01f00000\0"	\
-	"ramdisk_addr_r=0x06000000\0"		\
-	"kernel_comp_size=0x2000000\0"
-
 #define CFG_EXTRA_ENV_SETTINGS			\
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
 	ENV_MEM_LAYOUT_SETTINGS			\
diff --git a/include/configs/rk3528_common.h b/include/configs/rk3528_common.h
index f7dc6ecd5944..08ed6643369d 100644
--- a/include/configs/rk3528_common.h
+++ b/include/configs/rk3528_common.h
@@ -17,18 +17,6 @@
 #define ROCKCHIP_DEVICE_SETTINGS
 #endif
 
-#define ENV_MEM_LAYOUT_SETTINGS			\
-	"scriptaddr=0x00c00000\0"		\
-	"script_offset_f=0xffe000\0"		\
-	"script_size_f=0x2000\0"		\
-	"pxefile_addr_r=0x00e00000\0"		\
-	"kernel_addr_r=0x02000000\0"		\
-	"kernel_comp_addr_r=0x0a000000\0"	\
-	"fdt_addr_r=0x12000000\0"		\
-	"fdtoverlay_addr_r=0x12100000\0"	\
-	"ramdisk_addr_r=0x12180000\0"		\
-	"kernel_comp_size=0x8000000\0"
-
 #define CFG_EXTRA_ENV_SETTINGS			\
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
 	ENV_MEM_LAYOUT_SETTINGS			\
diff --git a/include/configs/rk3568_common.h b/include/configs/rk3568_common.h
index b2a35db0b949..0a6498606b65 100644
--- a/include/configs/rk3568_common.h
+++ b/include/configs/rk3568_common.h
@@ -19,18 +19,6 @@
 #define ROCKCHIP_DEVICE_SETTINGS
 #endif
 
-#define ENV_MEM_LAYOUT_SETTINGS		\
-	"scriptaddr=0x00c00000\0"	\
-	"script_offset_f=0xffe000\0"	\
-	"script_size_f=0x2000\0"	\
-	"pxefile_addr_r=0x00e00000\0"	\
-	"kernel_addr_r=0x02000000\0"	\
-	"kernel_comp_addr_r=0x0a000000\0"	\
-	"fdt_addr_r=0x12000000\0"	\
-	"fdtoverlay_addr_r=0x12100000\0"	\
-	"ramdisk_addr_r=0x12180000\0"	\
-	"kernel_comp_size=0x8000000\0"
-
 #define CFG_EXTRA_ENV_SETTINGS		\
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
 	ENV_MEM_LAYOUT_SETTINGS		\
diff --git a/include/configs/rk3576_common.h b/include/configs/rk3576_common.h
index 14d1d8636093..5568ac767415 100644
--- a/include/configs/rk3576_common.h
+++ b/include/configs/rk3576_common.h
@@ -20,18 +20,6 @@
 #define ROCKCHIP_DEVICE_SETTINGS
 #endif
 
-#define ENV_MEM_LAYOUT_SETTINGS		\
-	"scriptaddr=0x40c00000\0" \
-	"script_offset_f=0xffe000\0"	\
-	"script_size_f=0x2000\0"	\
-	"pxefile_addr_r=0x40e00000\0" \
-	"kernel_addr_r=0x42000000\0" \
-	"kernel_comp_addr_r=0x4a000000\0"	\
-	"fdt_addr_r=0x52000000\0"	\
-	"fdtoverlay_addr_r=0x52100000\0"	\
-	"ramdisk_addr_r=0x52180000\0"	\
-	"kernel_comp_size=0x8000000\0"
-
 #define CFG_EXTRA_ENV_SETTINGS		\
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
 	ENV_MEM_LAYOUT_SETTINGS		\
diff --git a/include/configs/rk3588_common.h b/include/configs/rk3588_common.h
index 2f0d40deb640..a6bba445f401 100644
--- a/include/configs/rk3588_common.h
+++ b/include/configs/rk3588_common.h
@@ -18,18 +18,6 @@
 #define ROCKCHIP_DEVICE_SETTINGS
 #endif
 
-#define ENV_MEM_LAYOUT_SETTINGS		\
-	"scriptaddr=0x00c00000\0"	\
-	"script_offset_f=0xffe000\0"	\
-	"script_size_f=0x2000\0"	\
-	"pxefile_addr_r=0x00e00000\0"	\
-	"kernel_addr_r=0x02000000\0"	\
-	"kernel_comp_addr_r=0x0a000000\0"	\
-	"fdt_addr_r=0x12000000\0"	\
-	"fdtoverlay_addr_r=0x12100000\0"	\
-	"ramdisk_addr_r=0x12180000\0"	\
-	"kernel_comp_size=0x8000000\0"
-
 #define CFG_EXTRA_ENV_SETTINGS		\
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
 	ENV_MEM_LAYOUT_SETTINGS		\
diff --git a/include/configs/rockchip-common.h b/include/configs/rockchip-common.h
index d5550a46575a..ed2a026bcefb 100644
--- a/include/configs/rockchip-common.h
+++ b/include/configs/rockchip-common.h
@@ -30,6 +30,40 @@
 	"name=boot,size=112M,bootable,uuid=${uuid_gpt_boot};" \
 	"name=rootfs,size=-,uuid="ROOT_UUID
 
+#ifdef CONFIG_ROCKCHIP_COMMON_STACK_ADDR
+/*
+ * Default load addresses as offsets from the start of DRAM, the same on
+ * every SoC with the common memory layout. Everything up to the ramdisk
+ * fits below U-Boot proper relocated to the top of 128 MiB of DRAM, and
+ * loadaddr (SYS_LOAD_ADDR) sits just above SPL's own stack, heap and BSS.
+ * Offsets are pasted after the DRAM base nibble, so they must stay below
+ * 0x10000000.
+ */
+#if CONFIG_SPL_TEXT_BASE == 0x60000000
+#define ROCKCHIP_DRAM_HI	"0x6"
+#elif CONFIG_SPL_TEXT_BASE == 0x40000000
+#define ROCKCHIP_DRAM_HI	"0x4"
+#else
+#define ROCKCHIP_DRAM_HI	"0x0"
+#endif
+
+#define ENV_MEM_LAYOUT_SETTINGS \
+	"scriptaddr="		ROCKCHIP_DRAM_HI "0200000\0" \
+	"script_offset_f=0xffe000\0" \
+	"script_size_f=0x2000\0" \
+	"pxefile_addr_r="	ROCKCHIP_DRAM_HI "0300000\0" \
+	"fdt_addr_r="		ROCKCHIP_DRAM_HI "0400000\0" \
+	"fdtoverlay_addr_r="	ROCKCHIP_DRAM_HI "0500000\0" \
+	"kernel_addr_r="	ROCKCHIP_DRAM_HI "0600000\0" \
+	"ramdisk_addr_r="	ROCKCHIP_DRAM_HI "5000000\0" \
+	"kernel_comp_addr_r="	ROCKCHIP_DRAM_HI "b000000\0" \
+	"kernel_comp_size=0x2000000\0"
+#endif
+
+#ifndef ENV_MEM_LAYOUT_SETTINGS
+#error "Define ENV_MEM_LAYOUT_SETTINGS for boards without ROCKCHIP_COMMON_STACK_ADDR"
+#endif
+
 #endif
 
 #endif /* _ROCKCHIP_COMMON_H_ */

-- 
2.55.0

