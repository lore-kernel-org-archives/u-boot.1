Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F994606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jDu2SY9L;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=nYJdwaYK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50D80409BC;
	Fri, 23 Oct 2026 14:55:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oOMiIHw0HtV3; Fri, 23 Oct 2026 14:55:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 47D7A4096C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792767326;
	b=cp/YKBN2lLIqSGu3cQ2zOI4HBVzI5Vripyz641jgsjtriSxXghKTlBQaoVkyLhWDHgGy
	 GfHLxyhFFUJYGMzNVr2pk0K9McmJ1z110VHTypri4By5ekjWJ2XYKCb+winriRU/D6RMz
	 PvVd8z1LZU6m+OFjPml+tWfTpNSY3wt5OzyBkTW2DDwndmjeKTWAMw1Y7kqq6kMdNvPMy
	 V1gP/Fb+qZkKoDQGMKOOFvgjL/T5V1B6JY6LY1UgbXmV+N7HUiJohGX+WlENeFPk/5pbQ
	 pYGOAA9pVSoRsr4jgjNBnGlD/ftiIIZeuNFgtE4IVjugc9xT2rEcinP1VOgFIeivljQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792767326;
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
	bh=OhanT5ShDY4xKobVn7m+mUCnsnftaj6OemnGZzSDSdQ=;
	b=KQ6fYCyoB0Mwb60QccevYBuJEajZywvPrsH0CuD9grT0g+f15b9ONN0iZHNXH3V2tTeS
	 qSwmFiY+ga/YVr9GYjTnL+bsPKs2Iemt6ePqqc3GBjW2w934LIM2DtjNCVDd+Q0LLnXyX
	 9O1D3FpaAH637znwPP6epQ/ja14fxs67xL/F8VXB5dvBuavxp8nyumOMigm6szTHZUGSR
	 92rZ3GGNd00E95Y8LHcv0JT/5/EL1tY8s4u5/5LKXlfUC3eMnDEVks4ZRb8oXBQKlEsDC
	 HunAT+As+DjVOVPVFKikWxb+W5h/QrCAp/gfjxys1A11uOtwlEyFcBDERdBTBUFVtQg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792767326;
	bh=OhanT5ShDY4xKobVn7m+mUCnsnftaj6OemnGZzSDSdQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jDu2SY9L3bv0qLs81MXtex8DAYGfbVP8b9bR2dt9f+nWFw2DO1Mdj/a+NwJpzzewE
	 IGrR/g4eN5ESsvBAHA1AASrxsTcb/CcKHVt/0QgHcJ56dXiSIOTM/6ijrAhgAxevpq
	 2JtGrS60uPpjUeFkTw+zn00NLR+lK3NJzif/aJ37JZVTK2uiFw03n8Fv2rKXwoqIKW
	 GfXEBf1I8yG1P/HV7epAxccWpE3n4+LHw9ZZKYsTg+OtijGxYrQXUxR+YofrFz6+nV
	 scW8FOCG2qEmBJAMR78PvICxz28l9wDQXAk53hz1lybJWB2lEkOfzweg4RjzLF/tqW
	 mdN4X1YBoRprg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47D7A4096C;
	Fri, 23 Oct 2026 14:55:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 710A0235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:36:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 564FE606C4
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:36:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L5Y3YQ4oUwX2 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 14:36:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8E872605D8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792766178;
 b=Uz5uZy9eH/rjzIhEutp/SIPdHkgDeLZuGS78ex8pHLEIUtYDgUYHQDh3V0XKIwma8C6S
 SkRxJtHSRz5qiNzgeGXdftmz1t5kqTabRmlqhgcXFF2ueCnICdonjzDRjpgvzpmk+rnZb
 5sXzUCbDCYksCnwTqACddGar/8u2Chl9YhHe5RBBe/YcFHLk0VXGb9QGeyG7S4C+xo3gp
 KjUSGzDQANksf+MDCE6u57lbxbuMOMMS3OB71rX/438MbGZC1ysJjje486yQEAh9KLmb+
 +Fcnyej2N4E99fuAT0swKvCekmIrbxeTw6FWZmAljsmLggwG2u6Xp/nG2Al5nsLwBwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792766178;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=OhanT5ShDY4xKobVn7m+mUCnsnftaj6OemnGZzSDSdQ=;
 b=YxqLvuXnheVCfSnBYoU5+EqYmrx4QRUsGVH3LPLRly7NAWFRgF+gAzOz92rFi8huu4X/
 1TKO+r0YF32kbA+nCKHZkrVCyj9PUqOF1HLOE64SHJFgpG7RBgWJSMADHrKdnWLfWHHjb
 NFwhHv27aH474KzwFh3MRfl0zu9vUt/8Px0f/xvQZljRNbgLceKJZpVUWCwiv5tvSeAwa
 gT1g3SH63TDNYu/kog2+M7IiQNDj/U+LYFCpXKqA4jGNhbmMzKpiqD/GuD6IJC5mbY7iq
 J050erQtUySn3XncPGZaWQUh9tmFfhhK9RocWyygIqMkGFHtTasFPnwdsMwOeOhW0XQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=nYJdwaYK; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=nYJdwaYK
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E872605D8
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:36:17 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1dede3c2cso11191885e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792766175; x=1793370975;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OhanT5ShDY4xKobVn7m+mUCnsnftaj6OemnGZzSDSdQ=;
 b=nYJdwaYKFGOhRTkH++TlafC0wGXNAhcIFwjgRzH2bd1OuSJGBnFAPyYFsU+0GqclRj
 Noigp1Jj37Q6zJN0WRklx6kE3S9MwBJoSxS+Fx1Fmh2JarE64LFGSv3tEfdPJsQ9iDWU
 98uUQwBT+ptjtJ3RQjZTKtnZ6MK1ay8gegZ+FDEZrcPufoQnHc2BUHnEY9KDHTTw1V7n
 3tUXy/xhFSygPo9b6c4FyFOEyuc/qU7yxz+aO8NICF6XeFD8KhesNPPm4TVdyWbdoSXO
 T4Wmr3MlecBhXI49ajRsKKaBKXLuX0X9skApil5+zfX3KbRiib5f2uvLzAs1FvGGAG+D
 ch/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792766175; x=1793370975;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OhanT5ShDY4xKobVn7m+mUCnsnftaj6OemnGZzSDSdQ=;
 b=Z8Upzw44hyG5BYYJiq8FdoH80sTKUFsHOl/EcCzQDW+iC/gASPQtrZNrcQvemG4Jnl
 cQhFUX7wFND3Xbn+FUbmx+Qd2kiefJ2t/0UJpLe/1YJnRiiNUjMA7zbU29HYMPt7JZ2F
 13GqwNuxJVNrrDkLO7c2zPVmI1RdjtXf8A7KnVGYXBdDXq03ee+TGv7zCYVUMSdfZNgg
 ILzj0e5RA9gsrju9tk8BLd4o52I42F30Xi0cGwm6rFvXLUwKmRj/adOd0aesbPFjuklh
 vrKmbjV8VC09sqc/2pTiMo48r9NwcscMqsBCYhuwbUFgYZF7JsbCPTTeBIdErqYyr9pM
 8Ldw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCfejpyRK1jKT0Qr6p6wOFKsxuRz3JY+EuLd1TARtkOEwnhUldTjRpe0S06InU3MpFnkwgGvw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLKercILj7oPT2uLGeCUVjwLH053wzdppMFr4GlapjbKDyOE5Ib
 3chX5JO6c+cQnzAN1ZKQ3ru+B82BNFIbKyKyiKfxqPx9bLDtBoFQO2iOa5ynfh1WPZE=
X-Gm-Gg: AYBFou05llI2jF+su9fMsOL27VsMnOlZFMNyjeMkLl5CHYzmTjzGRK59ihzBYWe1TMX
 v5ouJRTbykr0uLkZXfagRepv1rGlKrMhPLLClfY10Im5/IJqni/CM4LgJv6QFQaiGmCKjrORJmi
 +9tQUpHSnNpFDR1n7OHU3VD2Drl9ZArOxLUJtSFP+Uxf3WFjON9C4DZ5QqkZo+iG2kjEGdWYijU
 egnAhfZ6duF4McIzI9KGyPJC1alHVF8AC4wtbfo44OMKCdBXCDFmuE6hmKRDcjc2ECGkTn7XPv8
 kVIz8UTFI+VEinMyJPnzhpZXrx7x2TWGgTMs9NjufrCgMS2PsjJ8VueVtUShbhLvTeq87DfWv8R
 aeoItcbTORAncbAxRFlEI/eNgKitzF0UMw5IQyjw2Bs8tURX4wLy3AaC2//TWWkM//cSfZKo/Ab
 yXHOIBQ8BKCCtKjZkxeSv6T0VWkCzQO0YSOboMr49nM/w47vqsS7jVgRwD6/i7T5NCuxHZu+ngh
 VM10udpF0jtQHcM+Ejtt32u/BCHeZxpxw15AJvfvbulrcnHJh/YlOYHuBqR9OwApWqHvh4KaqOC
 nCTQU0qWy9KADh6iUnODWUPuu6SLBorEf4GV
X-Received: by 2002:a05:600c:1f88:b0:49f:bd3c:bc24 with SMTP id
 5b1f17b1804b1-4a211f03ac9mr41138115e9.31.1792766174856; 
 Fri, 23 Oct 2026 07:36:14 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a29cd9d0aasm9906875e9.3.2026.10.23.07.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:36:14 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 23 Oct 2026 18:35:54 +0400
Subject: [PATCH v2 1/3] rockchip: Use a common SYS_LOAD_ADDR clear of SPL
 and the RAM boot FIT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-rk3576-load-addr-v2-1-d2a42a1e90df@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=72104; i=alchark@flipper.net; 
 h=from:subject:message-id;
 bh=2VXBOdDnElcmKRNxM4ggHDatoQegxwsSARJmkRh7Wb0=; 
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTdLji7vYEp46r5s5wLb/8I2TZO0nXMeLWwcoLlQqvZm
 vsWXz5yp2MiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICpln7GyPDQ08y1JIr/DPMmIedFCk5XHnSdlZizUe6ggkwy00Xx0t2MDN97JA0
 TvddJSqc+OCOyzvzsry2HStRqOmboRTMVyHkf4QcA
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SPL stages the data of a GZIP or LZMA compressed FIT image at
SYS_LOAD_ADDR before unpacking it to its load address. Each board sets
its own value, and none of them suits the common memory layout:

- On PX30, RK3328 and RK3399 it is 0x800800, inside U-Boot proper since
  TEXT_BASE moved to 0x800000. With SPL_GZIP or SPL_LZMA enabled binman
  compresses U-Boot proper, and SPL then unpacks it over its own input.
- Elsewhere it is 0x800800 (RK3288) or 0xc00800 above the start of DRAM,
  which a RAM boot FIT at SPL_LOAD_FIT_ADDRESS reaches once it grows past
  some 6 or 10 MiB.

Default SYS_LOAD_ADDR to 64 MiB above the start of DRAM on every board
using the common layout, and drop the per-board values so that new
boards do not copy stale ones. This is the first round address above
SPL's own stack, heap and BSS, which already cap a RAM boot FIT at some
57 MiB, so neither of them can reach the staging buffer. It also clears
TF-A and U-Boot proper, and leaves 64 MiB to stage into on RK3506 boards
with only 128 MiB of DRAM.

Fixes: b57363a2b9b6 ("rockchip: Move TEXT_BASE to 8 MiB offset from start of DRAM")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/arm/mach-rockchip/Kconfig                | 5 +++++
 configs/9tripod-x3568-v4-rk3568_defconfig     | 1 -
 configs/anbernic-rg-ds-rk3568_defconfig       | 1 -
 configs/anbernic-rgxx3-rk3566_defconfig       | 1 -
 configs/bpi-r2-pro-rk3568_defconfig           | 1 -
 configs/chromebook_bob_defconfig              | 1 -
 configs/chromebook_kevin_defconfig            | 1 -
 configs/cm3588-nas-rk3588_defconfig           | 1 -
 configs/coolpi-4b-rk3588s_defconfig           | 1 -
 configs/coolpi-cm5-evb-rk3588_defconfig       | 1 -
 configs/coolpi-cm5-genbook-rk3588_defconfig   | 1 -
 configs/eaidk-610-rk3399_defconfig            | 1 -
 configs/easepi-r1-rk3568_defconfig            | 1 -
 configs/evb-px30_defconfig                    | 1 -
 configs/evb-rk3308_defconfig                  | 1 -
 configs/evb-rk3328_defconfig                  | 1 -
 configs/evb-rk3399_defconfig                  | 1 -
 configs/evb-rk3568_defconfig                  | 1 -
 configs/evb-rk3588_defconfig                  | 1 -
 configs/fastrhino-r66s-rk3568_defconfig       | 1 -
 configs/ficus-rk3399_defconfig                | 1 -
 configs/firefly-px30_defconfig                | 1 -
 configs/firefly-rk3288_defconfig              | 1 -
 configs/firefly-rk3399_defconfig              | 1 -
 configs/gameforce-ace-rk3588s_defconfig       | 1 -
 configs/generic-rk3328_defconfig              | 1 -
 configs/generic-rk3399_defconfig              | 1 -
 configs/generic-rk3528_defconfig              | 1 -
 configs/generic-rk3568_defconfig              | 1 -
 configs/generic-rk3576_defconfig              | 1 -
 configs/generic-rk3588_defconfig              | 1 -
 configs/hinlink-h28k-rk3528_defconfig         | 1 -
 configs/jaguar-rk3588_defconfig               | 1 -
 configs/khadas-edge-captain-rk3399_defconfig  | 1 -
 configs/khadas-edge-rk3399_defconfig          | 1 -
 configs/khadas-edge-v-rk3399_defconfig        | 1 -
 configs/khadas-edge2-rk3588s_defconfig        | 1 -
 configs/lckfb-tspi-rk3566_defconfig           | 1 -
 configs/leez-rk3399_defconfig                 | 1 -
 configs/lubancat-2-rk3568_defconfig           | 1 -
 configs/miqi-rk3288_defconfig                 | 1 -
 configs/mnt-reform2-rk3588_defconfig          | 1 -
 configs/nanopc-t4-rk3399_defconfig            | 1 -
 configs/nanopc-t6-rk3588_defconfig            | 1 -
 configs/nanopi-m4-2gb-rk3399_defconfig        | 1 -
 configs/nanopi-m4-rk3399_defconfig            | 1 -
 configs/nanopi-m4b-rk3399_defconfig           | 1 -
 configs/nanopi-m5-rk3576_defconfig            | 1 -
 configs/nanopi-neo4-rk3399_defconfig          | 1 -
 configs/nanopi-r2c-plus-rk3328_defconfig      | 1 -
 configs/nanopi-r2c-rk3328_defconfig           | 1 -
 configs/nanopi-r2s-plus-rk3328_defconfig      | 1 -
 configs/nanopi-r2s-rk3328_defconfig           | 1 -
 configs/nanopi-r3s-rk3566_defconfig           | 1 -
 configs/nanopi-r4s-rk3399_defconfig           | 1 -
 configs/nanopi-r5c-rk3568_defconfig           | 1 -
 configs/nanopi-r5s-rk3568_defconfig           | 1 -
 configs/nanopi-r6c-rk3588s_defconfig          | 1 -
 configs/nanopi-r6s-rk3588s_defconfig          | 1 -
 configs/nanopi-r76s-rk3576_defconfig          | 1 -
 configs/nanopi-zero2-rk3528_defconfig         | 1 -
 configs/neu6a-io-rk3588_defconfig             | 1 -
 configs/neu6b-io-rk3588_defconfig             | 1 -
 configs/nova-rk3588s_defconfig                | 1 -
 configs/odroid-go2_defconfig                  | 1 -
 configs/odroid-m1-rk3568_defconfig            | 1 -
 configs/odroid-m1s-rk3566_defconfig           | 1 -
 configs/odroid-m2-rk3588s_defconfig           | 1 -
 configs/omni3576-rk3576_defconfig             | 1 -
 configs/orangepi-3b-rk3566_defconfig          | 1 -
 configs/orangepi-5-max-rk3588_defconfig       | 1 -
 configs/orangepi-5-plus-rk3588_defconfig      | 1 -
 configs/orangepi-5-rk3588s_defconfig          | 1 -
 configs/orangepi-5-ultra-rk3588_defconfig     | 1 -
 configs/orangepi-r1-plus-lts-rk3328_defconfig | 1 -
 configs/orangepi-r1-plus-rk3328_defconfig     | 1 -
 configs/orangepi-rk3399_defconfig             | 1 -
 configs/pinebook-pro-rk3399_defconfig         | 1 -
 configs/pinephone-pro-rk3399_defconfig        | 1 -
 configs/pinetab2-rk3566_defconfig             | 1 -
 configs/powkiddy-x55-rk3566_defconfig         | 1 -
 configs/puma-rk3399_defconfig                 | 1 -
 configs/px30-core-ctouch2-of10-px30_defconfig | 1 -
 configs/px30-core-ctouch2-px30_defconfig      | 1 -
 configs/px30-core-edimm2.2-px30_defconfig     | 1 -
 configs/qnap-ts433-rk3568_defconfig           | 1 -
 configs/quartz64-a-rk3566_defconfig           | 1 -
 configs/quartz64-b-rk3566_defconfig           | 1 -
 configs/quartzpro64-rk3588_defconfig          | 1 -
 configs/radxa-cm3-io-rk3566_defconfig         | 1 -
 configs/radxa-e20c-rk3528_defconfig           | 1 -
 configs/radxa-e25-rk3568_defconfig            | 1 -
 configs/radxa-zero-3-rk3566_defconfig         | 1 -
 configs/ringneck-px30_defconfig               | 1 -
 configs/roc-cc-rk3308_defconfig               | 1 -
 configs/roc-cc-rk3328_defconfig               | 1 -
 configs/roc-pc-mezzanine-rk3399_defconfig     | 1 -
 configs/roc-pc-rk3399_defconfig               | 1 -
 configs/roc-pc-rk3576_defconfig               | 1 -
 configs/roc-pc-rk3588s_defconfig              | 1 -
 configs/rock-2-rk3528_defconfig               | 1 -
 configs/rock-3a-rk3568_defconfig              | 1 -
 configs/rock-3b-rk3568_defconfig              | 1 -
 configs/rock-3c-rk3566_defconfig              | 1 -
 configs/rock-4c-plus-rk3399_defconfig         | 1 -
 configs/rock-4d-rk3576_defconfig              | 1 -
 configs/rock-4se-rk3399_defconfig             | 1 -
 configs/rock-5-itx-rk3588_defconfig           | 1 -
 configs/rock-5c-rk3588s_defconfig             | 1 -
 configs/rock-pi-4-rk3399_defconfig            | 1 -
 configs/rock-pi-4c-rk3399_defconfig           | 1 -
 configs/rock-pi-e-rk3328_defconfig            | 1 -
 configs/rock-pi-e-v3-rk3328_defconfig         | 1 -
 configs/rock-pi-n10-rk3399pro_defconfig       | 1 -
 configs/rock-pi-s-rk3308_defconfig            | 1 -
 configs/rock-s0-rk3308_defconfig              | 1 -
 configs/rock5a-rk3588s_defconfig              | 1 -
 configs/rock5b-rk3588_defconfig               | 1 -
 configs/rock64-rk3328_defconfig               | 1 -
 configs/rock960-rk3399_defconfig              | 1 -
 configs/rockpro64-rk3399_defconfig            | 1 -
 configs/sige1-rk3528_defconfig                | 1 -
 configs/sige5-rk3576_defconfig                | 1 -
 configs/sige7-rk3588_defconfig                | 1 -
 configs/soquartz-blade-rk3566_defconfig       | 1 -
 configs/soquartz-cm4-rk3566_defconfig         | 1 -
 configs/soquartz-model-a-rk3566_defconfig     | 1 -
 configs/tiger-rk3588_defconfig                | 1 -
 configs/tinker-rk3288_defconfig               | 1 -
 configs/tinker-s-rk3288_defconfig             | 1 -
 configs/toybrick-rk3588_defconfig             | 1 -
 configs/turing-rk1-rk3588_defconfig           | 1 -
 132 files changed, 5 insertions(+), 131 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1a2e7847c9e7..5146713ae070 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -832,6 +832,11 @@ config SPL_TEXT_BASE
 	default 0x40000000 if ROCKCHIP_RK3576
 	default 0x00000000
 
+config SYS_LOAD_ADDR
+	default 0x64000000 if SPL_TEXT_BASE = 0x60000000
+	default 0x44000000 if SPL_TEXT_BASE = 0x40000000
+	default 0x04000000 if SPL_TEXT_BASE = 0x00000000
+
 config SPL_HAS_BSS_LINKER_SECTION
 	default y if ARM64
 
diff --git a/configs/9tripod-x3568-v4-rk3568_defconfig b/configs/9tripod-x3568-v4-rk3568_defconfig
index c0e7a5653595..f6b73a29a1ff 100644
--- a/configs/9tripod-x3568-v4-rk3568_defconfig
+++ b/configs/9tripod-x3568-v4-rk3568_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-9tripod-x3568-v4"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/anbernic-rg-ds-rk3568_defconfig b/configs/anbernic-rg-ds-rk3568_defconfig
index 816f78da4a31..846c9970868c 100644
--- a/configs/anbernic-rg-ds-rk3568_defconfig
+++ b/configs/anbernic-rg-ds-rk3568_defconfig
@@ -8,7 +8,6 @@ CONFIG_ROCKCHIP_RK3568=y
 CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_ANBERNIC_RG_DS_RK3568=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index 854de8b00a4b..719f01175699 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -8,7 +8,6 @@ CONFIG_ROCKCHIP_RK3568=y
 CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_ANBERNIC_RGXX3_RK3566=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/bpi-r2-pro-rk3568_defconfig b/configs/bpi-r2-pro-rk3568_defconfig
index c5199a394489..481a8a113e46 100644
--- a/configs/bpi-r2-pro-rk3568_defconfig
+++ b/configs/bpi-r2-pro-rk3568_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-bpi-r2-pro"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index cbb8beb91c20..d29154a733d3 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -11,7 +11,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_BOOT_MODE_REG=0
 # CONFIG_SPL_MMC is not set
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xff1a0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index a9dbe33e3d64..efe676924d2d 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -12,7 +12,6 @@ CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_BOOT_MODE_REG=0
 # CONFIG_SPL_MMC is not set
 CONFIG_TARGET_CHROMEBOOK_KEVIN=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xff1a0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/cm3588-nas-rk3588_defconfig b/configs/cm3588-nas-rk3588_defconfig
index 5b5ef8d5ac13..1ad8ce2aec70 100644
--- a/configs/cm3588-nas-rk3588_defconfig
+++ b/configs/cm3588-nas-rk3588_defconfig
@@ -7,7 +7,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-friendlyelec-cm3588-nas"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_CM3588_NAS_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/coolpi-4b-rk3588s_defconfig b/configs/coolpi-4b-rk3588s_defconfig
index e67726224033..aa2e3a3676c3 100644
--- a/configs/coolpi-4b-rk3588s_defconfig
+++ b/configs/coolpi-4b-rk3588s_defconfig
@@ -9,7 +9,6 @@ CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_EVB_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=5
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/coolpi-cm5-evb-rk3588_defconfig b/configs/coolpi-cm5-evb-rk3588_defconfig
index 4326e1168499..35edf88f5839 100644
--- a/configs/coolpi-cm5-evb-rk3588_defconfig
+++ b/configs/coolpi-cm5-evb-rk3588_defconfig
@@ -9,7 +9,6 @@ CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_EVB_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=5
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/coolpi-cm5-genbook-rk3588_defconfig b/configs/coolpi-cm5-genbook-rk3588_defconfig
index 85fbde726469..d15d0680a9b8 100644
--- a/configs/coolpi-cm5-genbook-rk3588_defconfig
+++ b/configs/coolpi-cm5-genbook-rk3588_defconfig
@@ -9,7 +9,6 @@ CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_GENBOOK_CM5_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=5
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/eaidk-610-rk3399_defconfig b/configs/eaidk-610-rk3399_defconfig
index 39ba69318634..a21f066def42 100644
--- a/configs/eaidk-610-rk3399_defconfig
+++ b/configs/eaidk-610-rk3399_defconfig
@@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-eaidk-610"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_EVB_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/easepi-r1-rk3568_defconfig b/configs/easepi-r1-rk3568_defconfig
index fa400956b63e..04273b203720 100644
--- a/configs/easepi-r1-rk3568_defconfig
+++ b/configs/easepi-r1-rk3568_defconfig
@@ -6,7 +6,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-easepi-r1"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/evb-px30_defconfig b/configs/evb-px30_defconfig
index afc45308bee1..c8fbd9df7864 100644
--- a/configs/evb-px30_defconfig
+++ b/configs/evb-px30_defconfig
@@ -8,7 +8,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
 CONFIG_TARGET_EVB_PX30=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xff178000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
index c0eb5bbdcbd3..42e68f57dfba 100644
--- a/configs/evb-rk3308_defconfig
+++ b/configs/evb-rk3308_defconfig
@@ -6,7 +6,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-evb"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3308=y
 CONFIG_TARGET_EVB_RK3308=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFF0E0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 # CONFIG_DEBUG_UART_BOARD_INIT is not set
diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
index 5fb7b20ed956..540535a78070 100644
--- a/configs/evb-rk3328_defconfig
+++ b/configs/evb-rk3328_defconfig
@@ -8,7 +8,6 @@ CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-evb"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3328=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/evb-rk3399_defconfig b/configs/evb-rk3399_defconfig
index f282e77ac1e8..3fef982cd40e 100644
--- a/configs/evb-rk3399_defconfig
+++ b/configs/evb-rk3399_defconfig
@@ -9,7 +9,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-evb"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_EVB_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/evb-rk3568_defconfig b/configs/evb-rk3568_defconfig
index 4a5a7454e102..8f6c570c06b6 100644
--- a/configs/evb-rk3568_defconfig
+++ b/configs/evb-rk3568_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-evb1-v10"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
index c7f6256a6264..1336aac89db4 100644
--- a/configs/evb-rk3588_defconfig
+++ b/configs/evb-rk3588_defconfig
@@ -6,7 +6,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-evb1-v10"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_EVB_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/fastrhino-r66s-rk3568_defconfig b/configs/fastrhino-r66s-rk3568_defconfig
index fc753516d72a..6f0f3aa13bc9 100644
--- a/configs/fastrhino-r66s-rk3568_defconfig
+++ b/configs/fastrhino-r66s-rk3568_defconfig
@@ -6,7 +6,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-fastrhino-r66s"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defconfig
index 4352b947743e..57034c399668 100644
--- a/configs/ficus-rk3399_defconfig
+++ b/configs/ficus-rk3399_defconfig
@@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-ficus"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_ROCK960_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/firefly-px30_defconfig b/configs/firefly-px30_defconfig
index 316f960d32e7..818e76caae1a 100644
--- a/configs/firefly-px30_defconfig
+++ b/configs/firefly-px30_defconfig
@@ -9,7 +9,6 @@ CONFIG_ROCKCHIP_PX30=y
 CONFIG_TARGET_EVB_PX30=y
 CONFIG_DEBUG_UART_CHANNEL=1
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF160000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
index 58f26f1b1f3c..5f77e07a8183 100644
--- a/configs/firefly-rk3288_defconfig
+++ b/configs/firefly-rk3288_defconfig
@@ -12,7 +12,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_TARGET_FIREFLY_RK3288=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_DEBUG_UART_BASE=0xff690000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/firefly-rk3399_defconfig b/configs/firefly-rk3399_defconfig
index 83b9de5feb9f..3418993b2572 100644
--- a/configs/firefly-rk3399_defconfig
+++ b/configs/firefly-rk3399_defconfig
@@ -9,7 +9,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-firefly"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_EVB_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/gameforce-ace-rk3588s_defconfig b/configs/gameforce-ace-rk3588s_defconfig
index e4050bd77df1..4aeac4336b31 100644
--- a/configs/gameforce-ace-rk3588s_defconfig
+++ b/configs/gameforce-ace-rk3588s_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-gameforce-ace"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/generic-rk3328_defconfig b/configs/generic-rk3328_defconfig
index 77da0a341a81..f7c6e0b4c891 100644
--- a/configs/generic-rk3328_defconfig
+++ b/configs/generic-rk3328_defconfig
@@ -9,7 +9,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3328=y
 CONFIG_ROCKCHIP_EXTERNAL_TPL=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
diff --git a/configs/generic-rk3399_defconfig b/configs/generic-rk3399_defconfig
index 4a95379c931c..947c5caecc30 100644
--- a/configs/generic-rk3399_defconfig
+++ b/configs/generic-rk3399_defconfig
@@ -10,7 +10,6 @@ CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_EXTERNAL_TPL=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_EVB_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/generic-rk3528_defconfig b/configs/generic-rk3528_defconfig
index 130aa124298a..b28555c4e49a 100644
--- a/configs/generic-rk3528_defconfig
+++ b/configs/generic-rk3528_defconfig
@@ -4,7 +4,6 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rk3528-generic"
 CONFIG_ROCKCHIP_RK3528=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFF9F0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index a33c3af9255a..a890698963f0 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -7,7 +7,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3568-generic"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=4
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/generic-rk3576_defconfig b/configs/generic-rk3576_defconfig
index 5e25653820c2..06a29b5246cb 100644
--- a/configs/generic-rk3576_defconfig
+++ b/configs/generic-rk3576_defconfig
@@ -4,7 +4,6 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rk3576-generic"
 CONFIG_ROCKCHIP_RK3576=y
-CONFIG_SYS_LOAD_ADDR=0x40c00800
 CONFIG_DEBUG_UART_BASE=0x2AD40000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index ac450e6d7577..9781373a40d8 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -6,7 +6,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3588-generic"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_EVB_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/hinlink-h28k-rk3528_defconfig b/configs/hinlink-h28k-rk3528_defconfig
index 46d4c367f8cd..59d54d7e2cf8 100644
--- a/configs/hinlink-h28k-rk3528_defconfig
+++ b/configs/hinlink-h28k-rk3528_defconfig
@@ -4,7 +4,6 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-hinlink-h28k"
 CONFIG_ROCKCHIP_RK3528=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFF9F0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
index ed3883b4f9c6..d6a7f5bd92d3 100644
--- a/configs/jaguar-rk3588_defconfig
+++ b/configs/jaguar-rk3588_defconfig
@@ -10,7 +10,6 @@ CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_BOOT_MODE_REG=0x0
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_JAGUAR_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=5
 CONFIG_DEBUG_UART_BASE=0xfeb50000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/khadas-edge-captain-rk3399_defconfig b/configs/khadas-edge-captain-rk3399_defconfig
index 753fc165d896..4a9e88338376 100644
--- a/configs/khadas-edge-captain-rk3399_defconfig
+++ b/configs/khadas-edge-captain-rk3399_defconfig
@@ -10,7 +10,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_EVB_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/khadas-edge-rk3399_defconfig b/configs/khadas-edge-rk3399_defconfig
index ec3428d34c39..090059df55f2 100644
--- a/configs/khadas-edge-rk3399_defconfig
+++ b/configs/khadas-edge-rk3399_defconfig
@@ -10,7 +10,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_EVB_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/khadas-edge-v-rk3399_defconfig b/configs/khadas-edge-v-rk3399_defconfig
index 282ed561560e..59f2f817bc86 100644
--- a/configs/khadas-edge-v-rk3399_defconfig
+++ b/configs/khadas-edge-v-rk3399_defconfig
@@ -10,7 +10,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_EVB_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/khadas-edge2-rk3588s_defconfig b/configs/khadas-edge2-rk3588s_defconfig
index 5fc7ce702ec5..dd94bd6627be 100644
--- a/configs/khadas-edge2-rk3588s_defconfig
+++ b/configs/khadas-edge2-rk3588s_defconfig
@@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-khadas-edge2"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_KHADAS_EDGE2_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/lckfb-tspi-rk3566_defconfig b/configs/lckfb-tspi-rk3566_defconfig
index 7aa218345b74..a88c0d2f7d66 100644
--- a/configs/lckfb-tspi-rk3566_defconfig
+++ b/configs/lckfb-tspi-rk3566_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-lckfb-tspi"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/leez-rk3399_defconfig b/configs/leez-rk3399_defconfig
index 30e3aeedba04..86a1dbfdb0c6 100644
--- a/configs/leez-rk3399_defconfig
+++ b/configs/leez-rk3399_defconfig
@@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-leez-p710"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_EVB_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/lubancat-2-rk3568_defconfig b/configs/lubancat-2-rk3568_defconfig
index 7548bf60b06d..4e76b58eed06 100644
--- a/configs/lubancat-2-rk3568_defconfig
+++ b/configs/lubancat-2-rk3568_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-lubancat-2"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
index 1c03bd14b629..170f10d8b891 100644
--- a/configs/miqi-rk3288_defconfig
+++ b/configs/miqi-rk3288_defconfig
@@ -12,7 +12,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_TARGET_MIQI_RK3288=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xff690000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/mnt-reform2-rk3588_defconfig b/configs/mnt-reform2-rk3588_defconfig
index a6ba0aa5178b..408056db21c3 100644
--- a/configs/mnt-reform2-rk3588_defconfig
+++ b/configs/mnt-reform2-rk3588_defconfig
@@ -6,7 +6,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-mnt-reform2"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_EVB_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/nanopc-t4-rk3399_defconfig b/configs/nanopc-t4-rk3399_defconfig
index f8ae436a1ee2..592bb0445b50 100644
--- a/configs/nanopc-t4-rk3399_defconfig
+++ b/configs/nanopc-t4-rk3399_defconfig
@@ -10,7 +10,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_TARGET_EVB_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/nanopc-t6-rk3588_defconfig b/configs/nanopc-t6-rk3588_defconfig
index ba9a5adece7c..fdce0af3e14a 100644
--- a/configs/nanopc-t6-rk3588_defconfig
+++ b/configs/nanopc-t6-rk3588_defconfig
@@ -10,7 +10,6 @@ CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_NANOPCT6_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=5
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/nanopi-m4-2gb-rk3399_defconfig b/configs/nanopi-m4-2gb-rk3399_defconfig
index 96a76a5280b5..a717f6e91b59 100644
--- a/configs/nanopi-m4-2gb-rk3399_defconfig
+++ b/configs/nanopi-m4-2gb-rk3399_defconfig
@@ -10,7 +10,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_TARGET_EVB_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/nanopi-m4-rk3399_defconfig b/configs/nanopi-m4-rk3399_defconfig
index e316371e005c..79d45f49c691 100644
--- a/configs/nanopi-m4-rk3399_defconfig
+++ b/configs/nanopi-m4-rk3399_defconfig
@@ -10,7 +10,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_TARGET_EVB_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/nanopi-m4b-rk3399_defconfig b/configs/nanopi-m4b-rk3399_defconfig
index 9c503c586eb0..eb7ee707bd61 100644
--- a/configs/nanopi-m4b-rk3399_defconfig
+++ b/configs/nanopi-m4b-rk3399_defconfig
@@ -10,7 +10,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_TARGET_EVB_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/nanopi-m5-rk3576_defconfig b/configs/nanopi-m5-rk3576_defconfig
index 88b6d0f9e868..fc0765165dbb 100644
--- a/configs/nanopi-m5-rk3576_defconfig
+++ b/configs/nanopi-m5-rk3576_defconfig
@@ -8,7 +8,6 @@ CONFIG_SF_DEFAULT_MODE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-nanopi-m5"
 CONFIG_ROCKCHIP_RK3576=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
-CONFIG_SYS_LOAD_ADDR=0x40c00800
 CONFIG_SF_DEFAULT_BUS=6
 CONFIG_DEBUG_UART_BASE=0x2AD40000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/nanopi-neo4-rk3399_defconfig b/configs/nanopi-neo4-rk3399_defconfig
index 29b5cb47b814..23e48166dd26 100644
--- a/configs/nanopi-neo4-rk3399_defconfig
+++ b/configs/nanopi-neo4-rk3399_defconfig
@@ -10,7 +10,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_TARGET_EVB_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2c-plus-rk3328_defconfig
index f46636cf3456..cda0b350f606 100644
--- a/configs/nanopi-r2c-plus-rk3328_defconfig
+++ b/configs/nanopi-r2c-plus-rk3328_defconfig
@@ -9,7 +9,6 @@ CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-nanopi-r2c-plus"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3328=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/nanopi-r2c-rk3328_defconfig b/configs/nanopi-r2c-rk3328_defconfig
index 18624ee0c30e..06de9f28444b 100644
--- a/configs/nanopi-r2c-rk3328_defconfig
+++ b/configs/nanopi-r2c-rk3328_defconfig
@@ -9,7 +9,6 @@ CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-nanopi-r2c"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3328=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/nanopi-r2s-plus-rk3328_defconfig b/configs/nanopi-r2s-plus-rk3328_defconfig
index f2396d266888..6f12c5614f85 100644
--- a/configs/nanopi-r2s-plus-rk3328_defconfig
+++ b/configs/nanopi-r2s-plus-rk3328_defconfig
@@ -9,7 +9,6 @@ CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-nanopi-r2s-plus"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3328=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3328_defconfig
index 7d17b24cb0c0..4c81c34dbd7a 100644
--- a/configs/nanopi-r2s-rk3328_defconfig
+++ b/configs/nanopi-r2s-rk3328_defconfig
@@ -9,7 +9,6 @@ CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-nanopi-r2s"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3328=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/nanopi-r3s-rk3566_defconfig b/configs/nanopi-r3s-rk3566_defconfig
index 2424c7477c09..611fabdcd317 100644
--- a/configs/nanopi-r3s-rk3566_defconfig
+++ b/configs/nanopi-r3s-rk3566_defconfig
@@ -6,7 +6,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-nanopi-r3s"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
index 3a2d24d29c2b..46390172994b 100644
--- a/configs/nanopi-r4s-rk3399_defconfig
+++ b/configs/nanopi-r4s-rk3399_defconfig
@@ -10,7 +10,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_TARGET_EVB_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/nanopi-r5c-rk3568_defconfig b/configs/nanopi-r5c-rk3568_defconfig
index e75a24dadc85..87882cb150cc 100644
--- a/configs/nanopi-r5c-rk3568_defconfig
+++ b/configs/nanopi-r5c-rk3568_defconfig
@@ -6,7 +6,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-nanopi-r5c"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
index c971f376b384..a6e75de47094 100644
--- a/configs/nanopi-r5s-rk3568_defconfig
+++ b/configs/nanopi-r5s-rk3568_defconfig
@@ -6,7 +6,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-nanopi-r5s"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/nanopi-r6c-rk3588s_defconfig b/configs/nanopi-r6c-rk3588s_defconfig
index 861e3234d295..d5247fdac47b 100644
--- a/configs/nanopi-r6c-rk3588s_defconfig
+++ b/configs/nanopi-r6c-rk3588s_defconfig
@@ -7,7 +7,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-nanopi-r6c"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_NANOPI_R6C_RK3588S=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/nanopi-r6s-rk3588s_defconfig b/configs/nanopi-r6s-rk3588s_defconfig
index 743dfca441b6..d2997cb4296d 100644
--- a/configs/nanopi-r6s-rk3588s_defconfig
+++ b/configs/nanopi-r6s-rk3588s_defconfig
@@ -7,7 +7,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-nanopi-r6s"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_NANOPI_R6S_RK3588S=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/nanopi-r76s-rk3576_defconfig b/configs/nanopi-r76s-rk3576_defconfig
index af149dc4ba56..891c62e56e78 100644
--- a/configs/nanopi-r76s-rk3576_defconfig
+++ b/configs/nanopi-r76s-rk3576_defconfig
@@ -5,7 +5,6 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-nanopi-r76s"
 CONFIG_ROCKCHIP_RK3576=y
-CONFIG_SYS_LOAD_ADDR=0x40c00800
 CONFIG_DEBUG_UART_BASE=0x2AD40000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/nanopi-zero2-rk3528_defconfig b/configs/nanopi-zero2-rk3528_defconfig
index 2c725380ef4c..a46c48afe339 100644
--- a/configs/nanopi-zero2-rk3528_defconfig
+++ b/configs/nanopi-zero2-rk3528_defconfig
@@ -4,7 +4,6 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-nanopi-zero2"
 CONFIG_ROCKCHIP_RK3528=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFF9F0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/neu6a-io-rk3588_defconfig b/configs/neu6a-io-rk3588_defconfig
index 19f129e96f00..d3a40136147f 100644
--- a/configs/neu6a-io-rk3588_defconfig
+++ b/configs/neu6a-io-rk3588_defconfig
@@ -6,7 +6,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-edgeble-neu6a-io"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_RK3588_NEU6=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/neu6b-io-rk3588_defconfig b/configs/neu6b-io-rk3588_defconfig
index 2cf5aeccf519..643e621b0a8a 100644
--- a/configs/neu6b-io-rk3588_defconfig
+++ b/configs/neu6b-io-rk3588_defconfig
@@ -6,7 +6,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-edgeble-neu6b-io"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_RK3588_NEU6=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/nova-rk3588s_defconfig b/configs/nova-rk3588s_defconfig
index f7d7492ff466..11026d10f0c1 100644
--- a/configs/nova-rk3588s_defconfig
+++ b/configs/nova-rk3588s_defconfig
@@ -6,7 +6,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-indiedroid-nova"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_NOVA_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
index dfdea66cd70c..f6e5e4d21f93 100644
--- a/configs/odroid-go2_defconfig
+++ b/configs/odroid-go2_defconfig
@@ -15,7 +15,6 @@ CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_ODROID_GO2=y
 CONFIG_DEBUG_UART_CHANNEL=1
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=2
 CONFIG_DEBUG_UART_BASE=0xFF160000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/odroid-m1-rk3568_defconfig b/configs/odroid-m1-rk3568_defconfig
index b00985b04056..e72ea5db7846 100644
--- a/configs/odroid-m1-rk3568_defconfig
+++ b/configs/odroid-m1-rk3568_defconfig
@@ -9,7 +9,6 @@ CONFIG_ROCKCHIP_RK3568=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_ODROID_M1_RK3568=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=4
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/odroid-m1s-rk3566_defconfig b/configs/odroid-m1s-rk3566_defconfig
index d59882a2a590..9f636a05d977 100644
--- a/configs/odroid-m1s-rk3566_defconfig
+++ b/configs/odroid-m1s-rk3566_defconfig
@@ -6,7 +6,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-odroid-m1s"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_ODROID_M1S_RK3566=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/odroid-m2-rk3588s_defconfig b/configs/odroid-m2-rk3588s_defconfig
index e71e61ddb0ba..abd827921324 100644
--- a/configs/odroid-m2-rk3588s_defconfig
+++ b/configs/odroid-m2-rk3588s_defconfig
@@ -6,7 +6,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-odroid-m2"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_ODROID_M2_RK3588S=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/omni3576-rk3576_defconfig b/configs/omni3576-rk3576_defconfig
index 13ef3112f1b8..f6f4950d084e 100644
--- a/configs/omni3576-rk3576_defconfig
+++ b/configs/omni3576-rk3576_defconfig
@@ -4,7 +4,6 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-luckfox-omni3576"
 CONFIG_ROCKCHIP_RK3576=y
-CONFIG_SYS_LOAD_ADDR=0x40c00800
 CONFIG_DEBUG_UART_BASE=0x2AD40000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/orangepi-3b-rk3566_defconfig b/configs/orangepi-3b-rk3566_defconfig
index 1cd78789fa1c..d292c31ccc72 100644
--- a/configs/orangepi-3b-rk3566_defconfig
+++ b/configs/orangepi-3b-rk3566_defconfig
@@ -10,7 +10,6 @@ CONFIG_ROCKCHIP_RK3568=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_ORANGEPI_3B_RK3566=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=4
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/orangepi-5-max-rk3588_defconfig b/configs/orangepi-5-max-rk3588_defconfig
index 0861df962cf6..9c5668e7b768 100644
--- a/configs/orangepi-5-max-rk3588_defconfig
+++ b/configs/orangepi-5-max-rk3588_defconfig
@@ -10,7 +10,6 @@ CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_EVB_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=5
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/orangepi-5-plus-rk3588_defconfig b/configs/orangepi-5-plus-rk3588_defconfig
index 52523f87aec4..256e49a35b22 100644
--- a/configs/orangepi-5-plus-rk3588_defconfig
+++ b/configs/orangepi-5-plus-rk3588_defconfig
@@ -10,7 +10,6 @@ CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_EVB_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=5
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/orangepi-5-rk3588s_defconfig b/configs/orangepi-5-rk3588s_defconfig
index e0eba389289d..2660edb22524 100644
--- a/configs/orangepi-5-rk3588s_defconfig
+++ b/configs/orangepi-5-rk3588s_defconfig
@@ -9,7 +9,6 @@ CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_EVB_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=5
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/orangepi-5-ultra-rk3588_defconfig b/configs/orangepi-5-ultra-rk3588_defconfig
index fb7f44329836..c7180020e2e8 100644
--- a/configs/orangepi-5-ultra-rk3588_defconfig
+++ b/configs/orangepi-5-ultra-rk3588_defconfig
@@ -10,7 +10,6 @@ CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_EVB_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=5
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
index a70a96287a10..6a6fd5e1206d 100644
--- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
@@ -10,7 +10,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-orangepi-r1-plus-lts"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3328=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
index 40e79d52535a..ed8dad4f232f 100644
--- a/configs/orangepi-r1-plus-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-rk3328_defconfig
@@ -10,7 +10,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-orangepi-r1-plus"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3328=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
diff --git a/configs/orangepi-rk3399_defconfig b/configs/orangepi-rk3399_defconfig
index 8313c7c06362..ecc038e12e17 100644
--- a/configs/orangepi-rk3399_defconfig
+++ b/configs/orangepi-rk3399_defconfig
@@ -9,7 +9,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-orangepi"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_EVB_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
index cbf95b4692f0..555380126bee 100644
--- a/configs/pinebook-pro-rk3399_defconfig
+++ b/configs/pinebook-pro-rk3399_defconfig
@@ -12,7 +12,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_PINEBOOK_PRO_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
index 81bc6d5400db..6e23821813a5 100644
--- a/configs/pinephone-pro-rk3399_defconfig
+++ b/configs/pinephone-pro-rk3399_defconfig
@@ -11,7 +11,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_PINEPHONE_PRO_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/pinetab2-rk3566_defconfig b/configs/pinetab2-rk3566_defconfig
index f284dadb99d6..c74de46645ba 100644
--- a/configs/pinetab2-rk3566_defconfig
+++ b/configs/pinetab2-rk3566_defconfig
@@ -11,7 +11,6 @@ CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_QUARTZ64_RK3566=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=4
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/powkiddy-x55-rk3566_defconfig b/configs/powkiddy-x55-rk3566_defconfig
index 37a359c91a90..d317389fe1d6 100644
--- a/configs/powkiddy-x55-rk3566_defconfig
+++ b/configs/powkiddy-x55-rk3566_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-powkiddy-x55"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index 09b965d46374..a827716129e6 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -12,7 +12,6 @@ CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_BOOT_MODE_REG=0x0
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_PUMA_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF180000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/px30-core-ctouch2-of10-px30_defconfig b/configs/px30-core-ctouch2-of10-px30_defconfig
index 06b60483841d..819c6e226b16 100644
--- a/configs/px30-core-ctouch2-of10-px30_defconfig
+++ b/configs/px30-core-ctouch2-of10-px30_defconfig
@@ -9,7 +9,6 @@ CONFIG_ROCKCHIP_PX30=y
 CONFIG_TARGET_PX30_CORE=y
 CONFIG_DEBUG_UART_CHANNEL=1
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF160000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/px30-core-ctouch2-px30_defconfig b/configs/px30-core-ctouch2-px30_defconfig
index aa6e44f5348b..94eb896e10db 100644
--- a/configs/px30-core-ctouch2-px30_defconfig
+++ b/configs/px30-core-ctouch2-px30_defconfig
@@ -9,7 +9,6 @@ CONFIG_ROCKCHIP_PX30=y
 CONFIG_TARGET_PX30_CORE=y
 CONFIG_DEBUG_UART_CHANNEL=1
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF160000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/px30-core-edimm2.2-px30_defconfig b/configs/px30-core-edimm2.2-px30_defconfig
index fcc27ce8761d..2f61dfe85665 100644
--- a/configs/px30-core-edimm2.2-px30_defconfig
+++ b/configs/px30-core-edimm2.2-px30_defconfig
@@ -9,7 +9,6 @@ CONFIG_ROCKCHIP_PX30=y
 CONFIG_TARGET_PX30_CORE=y
 CONFIG_DEBUG_UART_CHANNEL=1
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF160000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/qnap-ts433-rk3568_defconfig b/configs/qnap-ts433-rk3568_defconfig
index 638331966755..f7d6427e750d 100644
--- a/configs/qnap-ts433-rk3568_defconfig
+++ b/configs/qnap-ts433-rk3568_defconfig
@@ -7,7 +7,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-qnap-ts433"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_QNAP_TS433_RK3568=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-rk3566_defconfig
index 780fd581f0aa..332f5487e196 100644
--- a/configs/quartz64-a-rk3566_defconfig
+++ b/configs/quartz64-a-rk3566_defconfig
@@ -10,7 +10,6 @@ CONFIG_ROCKCHIP_RK3568=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_QUARTZ64_RK3566=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=4
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-rk3566_defconfig
index 4d92a67cd73d..b24bd613bc01 100644
--- a/configs/quartz64-b-rk3566_defconfig
+++ b/configs/quartz64-b-rk3566_defconfig
@@ -9,7 +9,6 @@ CONFIG_ROCKCHIP_RK3568=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_QUARTZ64_RK3566=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=4
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/quartzpro64-rk3588_defconfig b/configs/quartzpro64-rk3588_defconfig
index 0ad74e8bbef4..3bb4f6109377 100644
--- a/configs/quartzpro64-rk3588_defconfig
+++ b/configs/quartzpro64-rk3588_defconfig
@@ -7,7 +7,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-quartzpro64"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_QUARTZPRO64_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/radxa-cm3-io-rk3566_defconfig b/configs/radxa-cm3-io-rk3566_defconfig
index 875f0b76fa5f..54f223561b7f 100644
--- a/configs/radxa-cm3-io-rk3566_defconfig
+++ b/configs/radxa-cm3-io-rk3566_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-radxa-cm3-io"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/radxa-e20c-rk3528_defconfig b/configs/radxa-e20c-rk3528_defconfig
index 3d86ac51c9b5..ccef7d40c887 100644
--- a/configs/radxa-e20c-rk3528_defconfig
+++ b/configs/radxa-e20c-rk3528_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-radxa-e20c"
 CONFIG_ROCKCHIP_RK3528=y
 CONFIG_TARGET_RADXA_ROCK_2_RK3528=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFF9F0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/radxa-e25-rk3568_defconfig b/configs/radxa-e25-rk3568_defconfig
index 779d540e22dc..ee03b9386b14 100644
--- a/configs/radxa-e25-rk3568_defconfig
+++ b/configs/radxa-e25-rk3568_defconfig
@@ -6,7 +6,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-radxa-e25"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/radxa-zero-3-rk3566_defconfig b/configs/radxa-zero-3-rk3566_defconfig
index f5cf09a5e4af..a88d90ea83a9 100644
--- a/configs/radxa-zero-3-rk3566_defconfig
+++ b/configs/radxa-zero-3-rk3566_defconfig
@@ -7,7 +7,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-radxa-zero-3w"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_RADXA_ZERO_3_RK3566=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
index 756469351058..8ea12f3f5eca 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -10,7 +10,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
 CONFIG_TARGET_RINGNECK_PX30=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF030000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
index b775a6e13522..a31e6a36e20d 100644
--- a/configs/roc-cc-rk3308_defconfig
+++ b/configs/roc-cc-rk3308_defconfig
@@ -7,7 +7,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-roc-cc"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3308=y
 CONFIG_TARGET_ROC_RK3308_CC=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFF0C0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/roc-cc-rk3328_defconfig b/configs/roc-cc-rk3328_defconfig
index 7e114908fe23..c2befc4fbf2b 100644
--- a/configs/roc-cc-rk3328_defconfig
+++ b/configs/roc-cc-rk3328_defconfig
@@ -9,7 +9,6 @@ CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-roc-cc"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3328=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-mezzanine-rk3399_defconfig
index 8b4d8c1b0aae..9f94f97d5bda 100644
--- a/configs/roc-pc-mezzanine-rk3399_defconfig
+++ b/configs/roc-pc-mezzanine-rk3399_defconfig
@@ -13,7 +13,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_ROC_PC_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 4347bab598ab..7e67f8a12452 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -13,7 +13,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_ROC_PC_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/roc-pc-rk3576_defconfig b/configs/roc-pc-rk3576_defconfig
index 53491efcec25..0af9f2cebfd5 100644
--- a/configs/roc-pc-rk3576_defconfig
+++ b/configs/roc-pc-rk3576_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-roc-pc"
 CONFIG_ROCKCHIP_RK3576=y
 CONFIG_TARGET_ROC_PC_RK3576=y
-CONFIG_SYS_LOAD_ADDR=0x40c00800
 CONFIG_DEBUG_UART_BASE=0x2AD40000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/roc-pc-rk3588s_defconfig b/configs/roc-pc-rk3588s_defconfig
index 226243d79772..ae8364d98b5f 100644
--- a/configs/roc-pc-rk3588s_defconfig
+++ b/configs/roc-pc-rk3588s_defconfig
@@ -6,7 +6,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-roc-pc"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_ROC_PC_RK3588S=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_ENV_OFFSET_REDUND=0x400000
diff --git a/configs/rock-2-rk3528_defconfig b/configs/rock-2-rk3528_defconfig
index 2219bc9de561..aa78ddbc0ea4 100644
--- a/configs/rock-2-rk3528_defconfig
+++ b/configs/rock-2-rk3528_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-rock-2a"
 CONFIG_ROCKCHIP_RK3528=y
 CONFIG_TARGET_RADXA_ROCK_2_RK3528=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFF9F0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
index e753185610f2..4a0ffa654d0a 100644
--- a/configs/rock-3a-rk3568_defconfig
+++ b/configs/rock-3a-rk3568_defconfig
@@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-rock-3a"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=4
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/rock-3b-rk3568_defconfig b/configs/rock-3b-rk3568_defconfig
index c3bf48b9e34c..3e39024c24ca 100644
--- a/configs/rock-3b-rk3568_defconfig
+++ b/configs/rock-3b-rk3568_defconfig
@@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-rock-3b"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=4
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/rock-3c-rk3566_defconfig b/configs/rock-3c-rk3566_defconfig
index 417aa33a6637..8e9ca60dd218 100644
--- a/configs/rock-3c-rk3566_defconfig
+++ b/configs/rock-3c-rk3566_defconfig
@@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-rock-3c"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=4
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
index 0f6bdfdfb06a..2557d28b2ab9 100644
--- a/configs/rock-4c-plus-rk3399_defconfig
+++ b/configs/rock-4c-plus-rk3399_defconfig
@@ -10,7 +10,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_ROCKPI4_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/rock-4d-rk3576_defconfig b/configs/rock-4d-rk3576_defconfig
index 93faf09962cf..ffd13a87d949 100644
--- a/configs/rock-4d-rk3576_defconfig
+++ b/configs/rock-4d-rk3576_defconfig
@@ -8,7 +8,6 @@ CONFIG_SF_DEFAULT_MODE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-rock-4d"
 CONFIG_ROCKCHIP_RK3576=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
-CONFIG_SYS_LOAD_ADDR=0x40c00800
 CONFIG_SF_DEFAULT_BUS=5
 CONFIG_DEBUG_UART_BASE=0x2AD40000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
index 7f22aede912c..b46e4db5b084 100644
--- a/configs/rock-4se-rk3399_defconfig
+++ b/configs/rock-4se-rk3399_defconfig
@@ -10,7 +10,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_ROCKPI4_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/rock-5-itx-rk3588_defconfig b/configs/rock-5-itx-rk3588_defconfig
index cb014de41883..77c4fe4b4dc5 100644
--- a/configs/rock-5-itx-rk3588_defconfig
+++ b/configs/rock-5-itx-rk3588_defconfig
@@ -10,7 +10,6 @@ CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_ROCK5B_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=5
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/rock-5c-rk3588s_defconfig b/configs/rock-5c-rk3588s_defconfig
index 3d044a814980..95022659232a 100644
--- a/configs/rock-5c-rk3588s_defconfig
+++ b/configs/rock-5c-rk3588s_defconfig
@@ -7,7 +7,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-rock-5c"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_ROCK_5C_RK3588S=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
index e5c9072c27fe..3410727bead7 100644
--- a/configs/rock-pi-4-rk3399_defconfig
+++ b/configs/rock-pi-4-rk3399_defconfig
@@ -10,7 +10,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_ROCKPI4_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
index 4be7b0f8130e..0f6b819a2b66 100644
--- a/configs/rock-pi-4c-rk3399_defconfig
+++ b/configs/rock-pi-4c-rk3399_defconfig
@@ -10,7 +10,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_ROCKPI4_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
index 662c71c9dd93..30cf1710ee52 100644
--- a/configs/rock-pi-e-rk3328_defconfig
+++ b/configs/rock-pi-e-rk3328_defconfig
@@ -9,7 +9,6 @@ CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-rock-pi-e"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3328=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/rock-pi-e-v3-rk3328_defconfig b/configs/rock-pi-e-v3-rk3328_defconfig
index c344081eb77e..518a3822b93d 100644
--- a/configs/rock-pi-e-v3-rk3328_defconfig
+++ b/configs/rock-pi-e-v3-rk3328_defconfig
@@ -9,7 +9,6 @@ CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3328-rock-pi-e-v3"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3328=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n10-rk3399pro_defconfig
index 602a723ea7d9..031cfb633769 100644
--- a/configs/rock-pi-n10-rk3399pro_defconfig
+++ b/configs/rock-pi-n10-rk3399pro_defconfig
@@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399pro-rock-pi-n10"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_EVB_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index a62afd05c4cb..db1b73fb64ef 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -6,7 +6,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-rock-pi-s"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3308=y
 CONFIG_TARGET_EVB_RK3308=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFF0A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 # CONFIG_DEBUG_UART_BOARD_INIT is not set
diff --git a/configs/rock-s0-rk3308_defconfig b/configs/rock-s0-rk3308_defconfig
index f8633961495b..fbdfff0dcb16 100644
--- a/configs/rock-s0-rk3308_defconfig
+++ b/configs/rock-s0-rk3308_defconfig
@@ -7,7 +7,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-rock-s0"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3308=y
 CONFIG_TARGET_EVB_RK3308=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFF0A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 # CONFIG_DEBUG_UART_BOARD_INIT is not set
diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
index 24b2eef35f24..f9bbde7243e9 100644
--- a/configs/rock5a-rk3588s_defconfig
+++ b/configs/rock5a-rk3588s_defconfig
@@ -6,7 +6,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-rock-5a"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_ROCK5A_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index da5fb3a2c302..484fbc5c8f5e 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -10,7 +10,6 @@ CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_ROCK5B_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=5
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
index f32037e03150..35a95c92edda 100644
--- a/configs/rock64-rk3328_defconfig
+++ b/configs/rock64-rk3328_defconfig
@@ -10,7 +10,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-rock64"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3328=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
index db121f03ae6c..9595de694bcf 100644
--- a/configs/rock960-rk3399_defconfig
+++ b/configs/rock960-rk3399_defconfig
@@ -7,7 +7,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-rock960"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_ROCK960_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index 1d2bff35fc02..0791620cefd8 100644
--- a/configs/rockpro64-rk3399_defconfig
+++ b/configs/rockpro64-rk3399_defconfig
@@ -12,7 +12,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_ROCKPRO64_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/sige1-rk3528_defconfig b/configs/sige1-rk3528_defconfig
index 150e0fcc7188..413fa68c9f66 100644
--- a/configs/sige1-rk3528_defconfig
+++ b/configs/sige1-rk3528_defconfig
@@ -4,7 +4,6 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-armsom-sige1"
 CONFIG_ROCKCHIP_RK3528=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFF9F0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/sige5-rk3576_defconfig b/configs/sige5-rk3576_defconfig
index be46f63798b5..c5945966f7e5 100644
--- a/configs/sige5-rk3576_defconfig
+++ b/configs/sige5-rk3576_defconfig
@@ -4,7 +4,6 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-armsom-sige5"
 CONFIG_ROCKCHIP_RK3576=y
-CONFIG_SYS_LOAD_ADDR=0x40c00800
 CONFIG_DEBUG_UART_BASE=0x2AD40000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/sige7-rk3588_defconfig b/configs/sige7-rk3588_defconfig
index 00b9759715b4..8de2792d5ff2 100644
--- a/configs/sige7-rk3588_defconfig
+++ b/configs/sige7-rk3588_defconfig
@@ -7,7 +7,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-armsom-sige7"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_SIGE7_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SPL_SPI=y
diff --git a/configs/soquartz-blade-rk3566_defconfig b/configs/soquartz-blade-rk3566_defconfig
index 7de159a88819..f3c6c131cb40 100644
--- a/configs/soquartz-blade-rk3566_defconfig
+++ b/configs/soquartz-blade-rk3566_defconfig
@@ -6,7 +6,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-soquartz-blade"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_QUARTZ64_RK3566=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/soquartz-cm4-rk3566_defconfig b/configs/soquartz-cm4-rk3566_defconfig
index 4455ee5b5aa0..b1f6870a4846 100644
--- a/configs/soquartz-cm4-rk3566_defconfig
+++ b/configs/soquartz-cm4-rk3566_defconfig
@@ -6,7 +6,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-soquartz-cm4"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_QUARTZ64_RK3566=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/soquartz-model-a-rk3566_defconfig b/configs/soquartz-model-a-rk3566_defconfig
index abdab5144963..518b53e598ce 100644
--- a/configs/soquartz-model-a-rk3566_defconfig
+++ b/configs/soquartz-model-a-rk3566_defconfig
@@ -6,7 +6,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-soquartz-model-a"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_QUARTZ64_RK3566=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/tiger-rk3588_defconfig b/configs/tiger-rk3588_defconfig
index 105e8e10e0b8..22a2554a934e 100644
--- a/configs/tiger-rk3588_defconfig
+++ b/configs/tiger-rk3588_defconfig
@@ -10,7 +10,6 @@ CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_BOOT_MODE_REG=0x0
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_TIGER_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_SF_DEFAULT_BUS=5
 CONFIG_DEBUG_UART_BASE=0xfeb50000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index b22962786b24..44edf9f1d6f2 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -11,7 +11,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_TARGET_TINKER_RK3288=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SPL_SIZE_LIMIT=0x4b000
 CONFIG_DEBUG_UART_BASE=0xff690000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
index 93057cd991b1..9ec15e85ef1d 100644
--- a/configs/tinker-s-rk3288_defconfig
+++ b/configs/tinker-s-rk3288_defconfig
@@ -11,7 +11,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_TARGET_TINKER_RK3288=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
-CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SPL_SIZE_LIMIT=0x4b000
 CONFIG_DEBUG_UART_BASE=0xff690000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/toybrick-rk3588_defconfig b/configs/toybrick-rk3588_defconfig
index 14b231ae3e28..f40f0c555cda 100644
--- a/configs/toybrick-rk3588_defconfig
+++ b/configs/toybrick-rk3588_defconfig
@@ -6,7 +6,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-toybrick-x0"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_TOYBRICK_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEB50000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
index 0b3efec23e60..82ed697964ca 100644
--- a/configs/turing-rk1-rk3588_defconfig
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -7,7 +7,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-turing-rk1"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_TURINGRK1_RK3588=y
-CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFEBC0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y

-- 
2.55.0

