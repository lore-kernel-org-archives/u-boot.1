Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72149606A32D
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vAHogGzH;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=In8/nIml
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4039C812AC;
	Fri, 23 Oct 2026 14:55:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qXIURrOvWfzS; Fri, 23 Oct 2026 14:55:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BCBB8811F8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792767324;
	b=qOZztfGoHIu1rLn/tEHtm6F3Vga1LRB35N76uLh9OW+70INQ8C1nYfTQ8o8BUEMiBcNP
	 GTfchq513I128mylJE2wbXjg6krmIp+tVzRxLh/pBaqGKiTSOVui72LfE2kEaHO+yzGsB
	 kPiTO19V7acicdN9V+vzhIr7oZUngXIzmPAX1QdK4b96IHUuh289wADw2Yl5kyJIw9l5r
	 /kUQbPBym994/zfRBxGCIYksNRrKiUxp5/gCCtBxANTmZ9N0z4GwATU/5o7rDItQPszMo
	 KQap5av1IHw6l/i3RxkM4d4Alw1vXDqikDJHcB2HiWJN9AsZPzinUhIc6OLUY+r+zBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792767324;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HExTKVA+jtg7R2zxmuXPURj3v1r/Mqt2sjtbYfE7O2k=;
	b=Y6kx4LfC8+vlfXkbNBk6Ma8PY4JFmNC1UlE+OUXuGmAA6qhnFMDlsGdtv+oxhX/MXXHW
	 3q6VzsUrZw3Pi5igIlAvHjlBQ8V7h5gTvS/Xgq28eJO94Cgs/iQyLy0suNjyXEm+dK7OU
	 KNKila3OOPrOyaVEs/3mjmSLAgpa/BUXHbgu2tQMjfNiRmvDHbMrschC41m45MSQtFYre
	 yqnmd4EFyxpLQ0qFK8xk9UvNz74VHlmfikyLEmAAwng+C3nzq0nQT1xRWRpOvE2bc+r6v
	 1upXwcgsRBoRwu1ZRrgbUT19udIwQ2pf9kM1FptdiDk9FK2W78+WdhHbhrqe+TqVr6g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b="In8/nIml";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792767324;
	bh=HExTKVA+jtg7R2zxmuXPURj3v1r/Mqt2sjtbYfE7O2k=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vAHogGzHx5oTdCDtA0FFr/PHwWXipI2mGVxX01eL9DNKEJcSe9W2U26NSdu5ihOhk
	 uww9w4Tf3FgcMMjGU9uGjcCCQG48KY6o5w3oshV3JeVHoTvPXrLdF90/egYp3R9ceG
	 IileoJ9JEpaWEpo7HhXqku/+5IDYjLRQIjZ83551PRkmoeprVs/8hImOx9XltdF//7
	 aKNLnhPsJ0ORCfVvsv71GJgpN7xPGSN0Se8SG1Im+Bg7kh07hn9xHucqOXYkXMLZ/g
	 nRM7m6ukKVFqE7cMA3+PM0rPOV+Q+ByvKC37FLYhMROj7oa6b037sXmYyF5Su6MuRB
	 ZIyPrrXvyWK1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCBB8811F8;
	Fri, 23 Oct 2026 14:55:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D388049D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D136A813FB
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:36:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ccHqTpd83t9e for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 14:36:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2F62E812CE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792766169;
 b=oS3RzyNHoMk/b3BzfMgFPTLe/JsE3MHrQqjE717fKW/vvg3VtaqaZxi6W5aJ+mW2xMSU
 PNtQejczTBZPBPxyWYavjP8Yc3kUjp9gpWEBGSsgpwqovBCoqnGUIyWoDCga2g4bMNkLp
 hL7osDal3o4+wMaMhVextAC3qvhbipvYw4UWz4/BI9R8eQLQAzfsl39PPqOJ8I7KQV8YX
 jKmmqwxC5LrFkEXCQFj4foboWAw9eDRcAF4QB4ZzP21EBWwTDm3AsV6AtTBVo3yTOXZaP
 JGvl8JND8xPBt4Gd+26iA/7bvOBRXBPwszlgfX9SF77s2zocA3oCd/YHxNB7tOYX15Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792766169;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=HExTKVA+jtg7R2zxmuXPURj3v1r/Mqt2sjtbYfE7O2k=;
 b=Ehm7iOuhsStX1ZZy3XTtUBi93DTBCEFZ6+EoTrmxFE0NCHer9hSe1a1q1ERaE3rsTAQe
 10uQB98SmcmNKEUHEaqea024WnlQoQMxquMaHCLt8xSGvCVSCG3rTjbznAMFQIYLPsG7C
 FB6yEyi0ttMoQbKEHjUdu7fd6EOkSewR736kirbe0RyE8OrL4rxfK5EHhwBq/0xYFVwQr
 Jy/WLL66r6STHG1+Pef63Yzb/vdrHvoZ3+kZ4aN505XZPsxYVZoZHm2m1AxXZZJJhAipp
 nliwK+uGoI+DUtwCu6EzSaI1VivWofjMU10DqIstEeczRJY3c6S/tegVKqVQAjKo8Zw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b="In8/nIml"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=In8/nIml
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F62E812CE
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:36:07 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso12874915e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792766166; x=1793370966;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HExTKVA+jtg7R2zxmuXPURj3v1r/Mqt2sjtbYfE7O2k=;
 b=In8/nIml2kQ8f1mChHF+//xrUwCAOucjvQfbyvWbMG5TBuaLCvxjXkWnUNI9vzPWWX
 CjfSULWGVV5xQW5wPoVmHHWyuzuHqXvt8kABJQiMFV26ffiKLG8MM5kJdMwt0ijb7FoN
 txfOEPTfvW5yDzvKsrfGlzH8CP49ZB2ksmfQGBJzVDScx/FM5B+S/KK31KAxiyttKUL9
 3kSrfipMbN7beQNjuZrfZrYju55UVyztWn8u5XJ/JWqbTBd6VUq6jkO3UqJCsFpBkaGk
 BZbYEFR/BXtNFop1rLOLD/QQVMgnx23eKVa4tNCoI1xQnsjbcdDJAGV2hT0Mf/zSIHJZ
 E4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792766166; x=1793370966;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HExTKVA+jtg7R2zxmuXPURj3v1r/Mqt2sjtbYfE7O2k=;
 b=XhRem4xP6QYqOVyRawY1Ws0vF5Ovj44afBXcW/lqy2ikHWimp5UBlkBdlNkgIKeEn1
 Lqo7yc9vT74h9JZyhvPaanWzxHC/2XHMeHOd/SaVlKD910gsMf015+bHLXu+/E7jV0nt
 SUx6BhVxYw2wR/L9nHBbMXHEmBAUOgdxtZ84oCMK+9FbZmCVIEQVIMeK3UfHdCQDGtz9
 3QITPVSNlrpx33Rez4qMP/KMd9J9LJf/oUucutHgsWhByieW79uPA1qcMAtdUXTPHQvt
 2TryREmy9xVIYZRL07Gh+rmes9DkYcotOqeGu+Jx9KJQWZU21jiW9yJq+AaFxIQSr8xM
 dHWg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGQcvnS9rV0Qg8E4VRR418Z9tpCvu3FuFma2NJegNUHPk6DoaeooFXyh5tYEDftxXvZDOJTr4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKtd4I3W4joYctHZu/J8vgEMPrELtd8kjD0+IXIRmtUSxypBkZV
 QINRq9HvBQ2vgHzeuhiev8nV02d6/lpS87OFWoi+Nu/j8tmduId2BMZYE1c7HFJIeI8=
X-Gm-Gg: AYBFou1SrxoQIRz7sxKLjjTg81g1JC99Roi97XrrbnrcXbhGWiHqmFi+27YCjlds60z
 pHArmDocH2m3rHXtfjiF9tefHJgFU2AzUoECQ+XKb4IGVCF4nmCOXffQ8vUUvjBe/1FGFgf05dG
 lTvdWZMXpE+cl61EIAGPsvqkgRCXElA6YIBv1Wrae7zz9EgsF/iD3hVQ5ABUaLDS2hZcgBAkWvb
 VJMwp3dw22hsruNw1iBhJg+cB4pqYJezvZZG715AkftL8wOFK+/lYcWUsxPt6YivhrBYOu+hxUB
 0PGH3CTcE3gMw+Mj8rAgebHhZbiFiPm4Tfig5WLOU/lLDUJLhezYw07S44dSzDYVtxmzmqPaa1N
 dKE/TNKI5cIgSRr+wssx1UxW0KFgxiIO+lxyQxWZ7WdeceoZerlodPYhcSBjH/8Md6YqTdtEwmC
 8grjM8FEZuKm4n+lIC97Qsj8aarT7Qib7gbC3Sok5ft8IWsvmAXMTkOSqgZ1P1Ak2yDKupdM4NY
 R5Xh3uCGsQTk/6tHwofsXk8laC9bfpY0j52FMk+Pn8gZSmY8v3EjqrsZ6BH1oox9kZUqxKmL0hC
 NhjYk+hgA5DxY2A0j6n+sayftn0DnRuTIUev
X-Received: by 2002:a05:600c:8712:b0:4a1:9c71:9f17 with SMTP id
 5b1f17b1804b1-4a211c65b4emr41821045e9.9.1792766165894; 
 Fri, 23 Oct 2026 07:36:05 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a29cd9d0aasm9906875e9.3.2026.10.23.07.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:36:05 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v2 0/3] rockchip: Use one memory layout for the default
 load addresses
Date: Fri, 23 Oct 2026 18:35:53 +0400
Message-Id: <20261023-rk3576-load-addr-v2-0-d2a42a1e90df@flipper.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0JmbQ2dAoor72FYlHaQUQJkikRDe
 ncB9y5f8v77CwQSpgCXZAGhmQMP/Qp4SMC1tr+TYr8yYIqFTlEreZr8VKhusF5Z70UhoTNkfF7
 aDNbZKNTwe0/eqh+HV/0gN22dzWg5TIN89s9Zb96f/KyVVlibc23KNMusuzYdjyPJsacJqhjjF
 9sAj0nEAAAA
X-Change-ID: 20261021-rk3576-load-addr-2e2c3e3d59a4
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12489; i=alchark@flipper.net; 
 h=from:subject:message-id;
 bh=GgWqq5/cEB8MjCv9nzSpewLX0AbNKZ6ILm9E51SEAX8=; 
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTdLjiz3O9MbpuqXLjgPO/dVQlvnY946Yswyy5ud2S/d
 fcUh8S/joksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKb6XSDDP1Umd625FSWOUpfTEy3kn9jsjWbwO/xgo2Syh6b+1DzNSIb/Dgl8h/5
 MvBzJdHnFq9QM0ULN8MdJRfskY4smC5kFfF/MDQA=
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v1 moved SYS_LOAD_ADDR on RK3576 only. As Jonas pointed out, the other
SoCs using ROCKCHIP_COMMON_STACK_ADDR share the same DRAM layout, so this
version gives all of them a common SYS_LOAD_ADDR default, and applies the
same treatment to the default environment, which so far came in three
different variants.

The resulting layout, as offsets from the start of DRAM:

  0x00000000  SPL, then TF-A from 0x40000 (first 2 MiB reserved)
  0x00200000  SPL: RAM boot FIT (SPL_LOAD_FIT_ADDRESS)
              U-Boot: scriptaddr, pxefile_addr_r, fdt_addr_r,
                      fdtoverlay_addr_r
  0x00600000  U-Boot: kernel_addr_r
  0x00800000  SPL: U-Boot proper (TEXT_BASE)
  0x03b00000  SPL: stack, heap and BSS, up to 0x03f88000
  0x04000000  SYS_LOAD_ADDR (SPL staging buffer, U-Boot loadaddr)
  0x05000000  U-Boot: ramdisk_addr_r
  0x0b000000  U-Boot: kernel_comp_addr_r

SPL stages the data of a GZIP or LZMA compressed FIT image at
SYS_LOAD_ADDR before unpacking it. On PX30, RK3328 and RK3399 the old
0x800800 has sat inside U-Boot proper since TEXT_BASE moved to 8 MiB, so
enabling SPL_GZIP or SPL_LZMA there makes SPL unpack U-Boot over its own
input. Elsewhere, the old values cap a RAM boot FIT at 6-10 MiB. 64 MiB
is the first round address above SPL's own memory, which already caps a
RAM boot FIT at some 57 MiB, and still leaves room to stage into on RK3506
boards with 128 MiB of DRAM.

The environment layout keeps everything up to the ramdisk below U-Boot
proper relocated to the top of 128 MiB of DRAM, and keeps loadaddr out of
the windows the other addresses need. On larger boards that trades some
headroom: 74 MiB for the kernel in bootstd flows, which never use
loadaddr, and 96 MiB for the ramdisk, where most SoCs had 128 MiB and
unlimited respectively. As far as I can tell, this is the only way to
make the layout uniform across every board with the common memory
layout, the small RK3506 ones included. I'd like to follow up with an RFC
series that sizes the load windows at runtime from the available DRAM,
so that boards with more memory can again afford larger images.

OP-TEE, when present, is a FIT loadable that SPL places at its link
address: 768 MiB into DRAM for upstream OP-TEE, clear of everything above,
and 132 MiB for the rkbin binaries, which the default environment does not
account for, as before. The SPL staging buffer cannot reach either, since
in the FITs binman generates the only compressed image, U-Boot proper (or
the kernel, with the Falcon mode series [1]), loads before any TEE.

Tested with buildman on all 156 Rockchip boards, and on Flipper One rev.
F0B1C2 and F0B0C1 (RK3576), RAM booting from maskrom: BLS boot of a
compressed kernel through booti, a zstd compressed U-Boot proper, and
Falcon mode [1] with a zstd compressed kernel, both staged at
SYS_LOAD_ADDR.

CI for this series: https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1708

[1] https://patch.msgid.link/20260731-atf-falcon-v2-0-acb97c172993@flipper.net

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v2:
- Set SYS_LOAD_ADDR from a Kconfig default for every SoC with the common
  memory layout, instead of in each defconfig (Jonas)
- Move it to 64 MiB into DRAM (0x44000000 on RK3576, was 0x48000000)
- Add a shared default env memory layout for the same SoCs
- Link to v1: https://patch.msgid.link/20261021-rk3576-load-addr-v1-1-2b38b39044ac@flipper.net

---
Alexey Charkov (3):
      rockchip: Use a common SYS_LOAD_ADDR clear of SPL and the RAM boot FIT
      rockchip: Define the env memory layout before rockchip-common.h
      rockchip: Share one default env memory layout between common-stack SoCs

 arch/arm/mach-rockchip/Kconfig                |  5 ++++
 configs/9tripod-x3568-v4-rk3568_defconfig     |  1 -
 configs/anbernic-rg-ds-rk3568_defconfig       |  1 -
 configs/anbernic-rgxx3-rk3566_defconfig       |  1 -
 configs/bpi-r2-pro-rk3568_defconfig           |  1 -
 configs/chromebook_bob_defconfig              |  1 -
 configs/chromebook_kevin_defconfig            |  1 -
 configs/cm3588-nas-rk3588_defconfig           |  1 -
 configs/coolpi-4b-rk3588s_defconfig           |  1 -
 configs/coolpi-cm5-evb-rk3588_defconfig       |  1 -
 configs/coolpi-cm5-genbook-rk3588_defconfig   |  1 -
 configs/eaidk-610-rk3399_defconfig            |  1 -
 configs/easepi-r1-rk3568_defconfig            |  1 -
 configs/evb-px30_defconfig                    |  1 -
 configs/evb-rk3308_defconfig                  |  1 -
 configs/evb-rk3328_defconfig                  |  1 -
 configs/evb-rk3399_defconfig                  |  1 -
 configs/evb-rk3568_defconfig                  |  1 -
 configs/evb-rk3588_defconfig                  |  1 -
 configs/fastrhino-r66s-rk3568_defconfig       |  1 -
 configs/ficus-rk3399_defconfig                |  1 -
 configs/firefly-px30_defconfig                |  1 -
 configs/firefly-rk3288_defconfig              |  1 -
 configs/firefly-rk3399_defconfig              |  1 -
 configs/gameforce-ace-rk3588s_defconfig       |  1 -
 configs/generic-rk3328_defconfig              |  1 -
 configs/generic-rk3399_defconfig              |  1 -
 configs/generic-rk3528_defconfig              |  1 -
 configs/generic-rk3568_defconfig              |  1 -
 configs/generic-rk3576_defconfig              |  1 -
 configs/generic-rk3588_defconfig              |  1 -
 configs/hinlink-h28k-rk3528_defconfig         |  1 -
 configs/jaguar-rk3588_defconfig               |  1 -
 configs/khadas-edge-captain-rk3399_defconfig  |  1 -
 configs/khadas-edge-rk3399_defconfig          |  1 -
 configs/khadas-edge-v-rk3399_defconfig        |  1 -
 configs/khadas-edge2-rk3588s_defconfig        |  1 -
 configs/lckfb-tspi-rk3566_defconfig           |  1 -
 configs/leez-rk3399_defconfig                 |  1 -
 configs/lubancat-2-rk3568_defconfig           |  1 -
 configs/miqi-rk3288_defconfig                 |  1 -
 configs/mnt-reform2-rk3588_defconfig          |  1 -
 configs/nanopc-t4-rk3399_defconfig            |  1 -
 configs/nanopc-t6-rk3588_defconfig            |  1 -
 configs/nanopi-m4-2gb-rk3399_defconfig        |  1 -
 configs/nanopi-m4-rk3399_defconfig            |  1 -
 configs/nanopi-m4b-rk3399_defconfig           |  1 -
 configs/nanopi-m5-rk3576_defconfig            |  1 -
 configs/nanopi-neo4-rk3399_defconfig          |  1 -
 configs/nanopi-r2c-plus-rk3328_defconfig      |  1 -
 configs/nanopi-r2c-rk3328_defconfig           |  1 -
 configs/nanopi-r2s-plus-rk3328_defconfig      |  1 -
 configs/nanopi-r2s-rk3328_defconfig           |  1 -
 configs/nanopi-r3s-rk3566_defconfig           |  1 -
 configs/nanopi-r4s-rk3399_defconfig           |  1 -
 configs/nanopi-r5c-rk3568_defconfig           |  1 -
 configs/nanopi-r5s-rk3568_defconfig           |  1 -
 configs/nanopi-r6c-rk3588s_defconfig          |  1 -
 configs/nanopi-r6s-rk3588s_defconfig          |  1 -
 configs/nanopi-r76s-rk3576_defconfig          |  1 -
 configs/nanopi-zero2-rk3528_defconfig         |  1 -
 configs/neu6a-io-rk3588_defconfig             |  1 -
 configs/neu6b-io-rk3588_defconfig             |  1 -
 configs/nova-rk3588s_defconfig                |  1 -
 configs/odroid-go2_defconfig                  |  1 -
 configs/odroid-m1-rk3568_defconfig            |  1 -
 configs/odroid-m1s-rk3566_defconfig           |  1 -
 configs/odroid-m2-rk3588s_defconfig           |  1 -
 configs/omni3576-rk3576_defconfig             |  1 -
 configs/orangepi-3b-rk3566_defconfig          |  1 -
 configs/orangepi-5-max-rk3588_defconfig       |  1 -
 configs/orangepi-5-plus-rk3588_defconfig      |  1 -
 configs/orangepi-5-rk3588s_defconfig          |  1 -
 configs/orangepi-5-ultra-rk3588_defconfig     |  1 -
 configs/orangepi-r1-plus-lts-rk3328_defconfig |  1 -
 configs/orangepi-r1-plus-rk3328_defconfig     |  1 -
 configs/orangepi-rk3399_defconfig             |  1 -
 configs/pinebook-pro-rk3399_defconfig         |  1 -
 configs/pinephone-pro-rk3399_defconfig        |  1 -
 configs/pinetab2-rk3566_defconfig             |  1 -
 configs/powkiddy-x55-rk3566_defconfig         |  1 -
 configs/puma-rk3399_defconfig                 |  1 -
 configs/px30-core-ctouch2-of10-px30_defconfig |  1 -
 configs/px30-core-ctouch2-px30_defconfig      |  1 -
 configs/px30-core-edimm2.2-px30_defconfig     |  1 -
 configs/qnap-ts433-rk3568_defconfig           |  1 -
 configs/quartz64-a-rk3566_defconfig           |  1 -
 configs/quartz64-b-rk3566_defconfig           |  1 -
 configs/quartzpro64-rk3588_defconfig          |  1 -
 configs/radxa-cm3-io-rk3566_defconfig         |  1 -
 configs/radxa-e20c-rk3528_defconfig           |  1 -
 configs/radxa-e25-rk3568_defconfig            |  1 -
 configs/radxa-zero-3-rk3566_defconfig         |  1 -
 configs/ringneck-px30_defconfig               |  1 -
 configs/roc-cc-rk3308_defconfig               |  1 -
 configs/roc-cc-rk3328_defconfig               |  1 -
 configs/roc-pc-mezzanine-rk3399_defconfig     |  1 -
 configs/roc-pc-rk3399_defconfig               |  1 -
 configs/roc-pc-rk3576_defconfig               |  1 -
 configs/roc-pc-rk3588s_defconfig              |  1 -
 configs/rock-2-rk3528_defconfig               |  1 -
 configs/rock-3a-rk3568_defconfig              |  1 -
 configs/rock-3b-rk3568_defconfig              |  1 -
 configs/rock-3c-rk3566_defconfig              |  1 -
 configs/rock-4c-plus-rk3399_defconfig         |  1 -
 configs/rock-4d-rk3576_defconfig              |  1 -
 configs/rock-4se-rk3399_defconfig             |  1 -
 configs/rock-5-itx-rk3588_defconfig           |  1 -
 configs/rock-5c-rk3588s_defconfig             |  1 -
 configs/rock-pi-4-rk3399_defconfig            |  1 -
 configs/rock-pi-4c-rk3399_defconfig           |  1 -
 configs/rock-pi-e-rk3328_defconfig            |  1 -
 configs/rock-pi-e-v3-rk3328_defconfig         |  1 -
 configs/rock-pi-n10-rk3399pro_defconfig       |  1 -
 configs/rock-pi-s-rk3308_defconfig            |  1 -
 configs/rock-s0-rk3308_defconfig              |  1 -
 configs/rock5a-rk3588s_defconfig              |  1 -
 configs/rock5b-rk3588_defconfig               |  1 -
 configs/rock64-rk3328_defconfig               |  1 -
 configs/rock960-rk3399_defconfig              |  1 -
 configs/rockpro64-rk3399_defconfig            |  1 -
 configs/sige1-rk3528_defconfig                |  1 -
 configs/sige5-rk3576_defconfig                |  1 -
 configs/sige7-rk3588_defconfig                |  1 -
 configs/soquartz-blade-rk3566_defconfig       |  1 -
 configs/soquartz-cm4-rk3566_defconfig         |  1 -
 configs/soquartz-model-a-rk3566_defconfig     |  1 -
 configs/tiger-rk3588_defconfig                |  1 -
 configs/tinker-rk3288_defconfig               |  1 -
 configs/tinker-s-rk3288_defconfig             |  1 -
 configs/toybrick-rk3588_defconfig             |  1 -
 configs/turing-rk1-rk3588_defconfig           |  1 -
 include/configs/px30_common.h                 | 12 ----------
 include/configs/rk3036_common.h               | 14 +++++------
 include/configs/rk3066_common.h               | 14 +++++------
 include/configs/rk3128_common.h               | 14 +++++------
 include/configs/rk3188_common.h               | 14 +++++------
 include/configs/rk322x_common.h               | 14 +++++------
 include/configs/rk3288_common.h               | 18 +++++++-------
 include/configs/rk3308_common.h               | 12 ----------
 include/configs/rk3328_common.h               | 12 ----------
 include/configs/rk3368_common.h               | 14 +++++------
 include/configs/rk3399_common.h               | 12 ----------
 include/configs/rk3506_common.h               | 12 ----------
 include/configs/rk3528_common.h               | 12 ----------
 include/configs/rk3568_common.h               | 12 ----------
 include/configs/rk3576_common.h               | 12 ----------
 include/configs/rk3588_common.h               | 12 ----------
 include/configs/rockchip-common.h             | 34 +++++++++++++++++++++++++++
 include/configs/rv1108_common.h               | 12 +++++-----
 include/configs/rv1126_common.h               | 18 +++++++-------
 151 files changed, 106 insertions(+), 304 deletions(-)
---
base-commit: 870b5d5a21fb6494e82cd9cc1a3dfc8e244d4c20
change-id: 20261021-rk3576-load-addr-2e2c3e3d59a4

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

