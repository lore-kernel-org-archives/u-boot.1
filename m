Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2768CC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2A6B40B78;
	Thu,  3 Sep 2026 22:13:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dCxeCsKkLxr8; Thu,  3 Sep 2026 22:13:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D81F140B85
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788473622;
	b=MfjgU4rOTAmrBNMUtXqyVVSXCS7W1m3rc0a55Pu0TQvLb6vWWPWKgrgwlI8IZp9izJkh
	 JqUrw9Z0FgciDT4ouGL7uD4mdcVVySS6ZSaW6A+/Epks+wtb1ryhhWjn9CBlC+LP7ZBEf
	 /RJ6l5YI4YojxsZe5vbq+B1QHjuIjdpxgSZCegE/Z0O+MK9l2AS8OUAV83dXzbr+nhCcO
	 kqE8N+wQZlVywOc9MBwziIVY/FWXHslOrJrboJEj2RA2YL4MegZcgYc+JKk4NxFeu+NNo
	 WS8HC/GWs+sehOArsld3WSOZooEJCfZ/RvRFyG4QZXEZyp9p7WxXypDiaIz5M3hJ1NA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473622;
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
	bh=3g9AbI4YbznhHGbQcaLs85QhXxmok8OjwxGipNtQHEo=;
	b=N+2GLqYLUSdDvcdeEYGWgAgGsCgTzHs+vX8wBsIOLSQyQAOXp3qe4Z05IIaxxElWqSLH
	 U1BUYJOduBdZvRZYNWDYVtno2x9ouIVDUOo0gQYX59aNuUsFrnPS/sdiJICXl++978zRq
	 sNk8ewd+Xo5/XeBVUVi3ELf8k6fE7Y+/+++Wl+XoTYfpPf+JVt6aoc69u0t7UGFfPy0iQ
	 U0B/C7MZIudffBcyB9zcAcq5kys6lP/uhWYjyE7y3ZUKFZAsmgcBg0eACX2cYb7+8YIFi
	 C0qN6zIrsGVL3DDRKU8HlkhQ5XCN/dW17aYSVpD4KpVxORlBkQGhvK16C6LpoOBUJAw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QSuObTHq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473622;
	bh=3g9AbI4YbznhHGbQcaLs85QhXxmok8OjwxGipNtQHEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UzWdAvQi4mo6iVdpqbYCUBXbb2wtKJm+/L9SY/3zz6coByu8ivKWgNnFfIJGdnT8h
	 FtiPkSp8nsLt6Od3WZfkB4ZYsdhsEYbFrP0H6Uwz3Ey0DKuTlmYi4FP7L3VecCS+BO
	 Z1XcmW9Fik/HB/c0K+4DThVycuWGv65uqSetK088EE0MTRTcqil7XMopCNOVvj4OEV
	 FQNpazPoX4+kuch8oK0gTqrqruvJ8J0pzOOws/kHuP8zqUH3JXe6sYULgzJsEKnzQH
	 XVuR0REMA5fNF03H1fYOhquWfZA+VyrXcSH8U+XbxuFHfAmXmrAa+lOeK153wqXt0T
	 Cse/qytAuvMJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D81F140B85;
	Thu,  3 Sep 2026 22:13:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EBD8F265
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1B6740B03
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1UReqClMo-YV for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:38:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C308B40AE8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788471491;
 b=KLi+tVArAJboqgp3NqM2SK8mXzCjSv5wnvGvVFRkzym/RJdQST9AZzYWl7qAjvr0KFy5
 5zmxdIPbSmCqIzJdvxDwfd25QFhs+kAuPxDpwzKHrzSqmVsWETWSKO0DsKu1OC+NmBxcB
 xXnLsSPeNyhVmaXWV2pkEfxq2qQoB1pJQ+K1imftZI90NP9GWM4uSzI8RD10PJn5uoYb6
 H6Jk9GhJFEFwYhmpecCJQz+DOimP8ZmS2F2YZYvIgLNcUh5KevjvtZRFs2Sy0cWY2AFtz
 4JiuXatOzbO/VWKbu26xItb/K11hddt8ZfXYm9zCCo7lMNSE8dglEsdUwxoPe7NeAfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788471491;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=3g9AbI4YbznhHGbQcaLs85QhXxmok8OjwxGipNtQHEo=;
 b=TYqM8IyIdDVRtsEvIuCLZrK+FPREvWLEMna4kWArHvXhmAHVR/N6I7AIV1SLP/uuQ4vB
 NaGMlLj6sbB6gnmgUOF2CxrejRDH6Mh0/V7ag5+pgvTub90VqHdRWfLmhoWxGKE9pXdJu
 XXmdqXnEUI9MVvkrrg4Wikc/tZninbya10KOCzBjtjGZ8+5moZaaUvFSZ0Ve6fYjUlRMQ
 f5HY6QzCJ5NanEN2qCqFaxaerdFr6bTHo6HQlCFg2pzf8AWDdJk6dmKf13o1d+52gr7fA
 wxq23/ab6hajeag7NjARFi3yYwlnCVI3DV2GtkCrZT4P+gsZazxk0hxQowsgdH4y5lQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=QSuObTHq; 
 arc=none smtp.remote-ip="2001:4860:4864:20::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=QSuObTHq
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C308B40AE8
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:10 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-469d76ce704so205847fac.2
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788471489; x=1789076289;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3g9AbI4YbznhHGbQcaLs85QhXxmok8OjwxGipNtQHEo=;
 b=QSuObTHqKGvMR3WxsZYJdOR/EXreFIn+lVcJgWIKMQE5gg68Oo9xFsqKAEgtxm+Mdq
 69Cf0WAN58poQU1bKZDFKwKknSAsn/VcOS82E2F6CWx4PPbDV/Gh0brh90F7TzHg2CKE
 LSWWD9X5z9fHYHX9nWF0pTvWOLPANPAHvyeG+A6f99/TDte2e9Bypl80+DPRTMTLmc7B
 1Q6r3TNeia01PjPTbPRrJVZmzOzlm/y/cH3Y4I1gzfuuXENpL4IpPisYn5wiBamsbP/0
 EK0FHNeFkCfOVBFwKRLmj2PogBZDMHWk6p+gxiJXI9wYsLEb0O+ej4vRLKfKSNVPznl8
 XB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788471489; x=1789076289;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3g9AbI4YbznhHGbQcaLs85QhXxmok8OjwxGipNtQHEo=;
 b=cOt9DSvBnf/KfScjYsJbSDjp3D8cfPuJLgw+QA4qguXaYPMwZuhCEvBHESVvgPKEXw
 PblNUMfpY7AiWBt4QqZjo3xYcY1I84h8fYpIp0DTEw7nYcJ5iAlIaceVcoisaaiCQBZo
 KlaYBW0heR8GRSiawmcdbiESyx/wY+9h4K82/9hJveuCZmileZRkRHz1HwOF2k8qRy7F
 iV67uy9EFn2OBixVIFDFZIHx/+LzFiYBKNwX9hzX8VxkiwZnocMQ3FhqqFYznStBVVs1
 Gwj5aQr+F3O2oLRyzPON8iD97fahBBsIgx59GgQ5LUJ+s+IRozp9CgadHGNJdTWy6/29
 0VzA==
X-Forwarded-Encrypted: i=1;
 AKwUvByfVFUMRxseiYDCrACJZpzHkuRrZth49riu2+APtTL7nl0Fm8r/3HKRXZEqyr7eJH+GplHe+BY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lSHsVFJ9RpnvOg0c+yN5Wd8zTLoxf5fFMLsZd5xTCavGaATDtx
 kczSRIgZXE3Ozv1y2zPDbW9AZ2kR+HS0TrqD7ZgixK/Iyes/PFaZyy10TDaDZ2u2uUU=
X-Gm-Gg: AYBFou2h89jrt5LZcYlGgSt7d98F1XTD+/lNueL87w6fBkIcM5vvUFjw4GYcFN0Sj5/
 9LDvq5XziUEK8vwuHlHUfUvscbH/uubgeV1jti8hfkXV4wcBxGwBiIkzhBxG9D2mX1ve5IqH/y6
 iSpCFubvEiISqH6VHP0yG5TbcpagGDN0/+FToAkXyax4bPCKJDp18TOehWmoKrYHIaus7HXUZi9
 NoSdT9GgPHK7zEZOKY2MLiOKDLdiUQrE+KQAC8w3YzK6ckx/Hy5BQQeEcfkhzzdaodUQ2PFl7u5
 sFBGY14efGhP2oehFXGx9uTJgFMh2D0k8B6SU1KDlZ+gc1Yx/zYGXKtOam5JwBnVOMutomhHque
 pV8B1c+D7JxGIAPJWyjLXdhkNBP9lTt0oVgCaUFnbCVcskFIdcRhK7v1qjCBj0zMOr9OuYC+9X+
 LCGzrV+QX+SnTQCaCg2e5pEXXkIjwLaRH1p7tIE2lCAVqtQ5XPw9OX8yUuxQCl3LrqqA==
X-Received: by 2002:a05:6870:d202:b0:469:598f:8380 with SMTP id
 586e51a60fabf-475516e1b51mr1774225fac.15.1788471489301; 
 Thu, 03 Sep 2026 14:38:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm682930fac.6.2026.09.03.14.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 14:38:07 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 03 Sep 2026 16:35:53 -0500
Subject: [PATCH 09/14] phy: qcom: snps-femto-v2: check dev_read_addr_ptr()
 for NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-dm-addr-null-checks-v1-9-db945bd5e712@baylibre.com>
References: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
In-Reply-To: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sjoerd Simons <sjoerd@collabora.com>, Eugen Hristev <ehristev@kernel.org>, 
 Claudiu Beznea <claudiu.beznea@microchip.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Dylan Hung <dylan_hung@aspeedtech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org, 
 Stefan Roese <sr@denx.de>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 u-boot-qcom@groups.io, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1175; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=fB3Yg8v3niJtHMw5Bsb9tur535rrBCKcL4KOnIlSKpY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmehz1mzfqXPdZfJ5QhMC81g4+vFKQIhy2cGJG
 rKoTEItkquJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapnocxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AHHIH/jss1xgUm/LCBOM4QLSQr5CpRJMm7et0T/mjQGc
 foVqbC7sO/eWNWXOeh4ItF/t7/RLNN1VM0Yz25TX8iv6sPniToVTm6EU9nIu4f53fGDmA9asMbz
 2x5dptLxtKrVctaQITz2gXw2GAw1B28ESoCunoq1rWMytrWdh9HKZD9x/xNFr0S+ECqT0kohw/s
 0+2Pf+AZHAyrqG2B1BF3YIkmJ5XmN4QpdFj4NxrOc+9ASCjtL4TX+De+BmEaPUPicfuKvH2tBsL
 nHp8C02/ZfbcqqKODr5mlBX8Ky8DPtGQHfhyC8h6SB6l3hlrA7/Smgq2M11HovLYuATZJttZKGk
 +kcM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 03 Sep 2026 22:13:11 +0000
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

Check the return value of dev_read_addr_ptr() for NULL instead of
IS_ERR(). This function only ever returns NULL on failure.

Add <errno.h>, since this is the first error code used directly
in this file.

Fixes: 968f512e6c9f ("phy: qcom: Add SNPS femto v2 USB HS phy")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/phy/qcom/phy-qcom-snps-femto-v2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qcom/phy-qcom-snps-femto-v2.c b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
index e782de07ebc..bf1f16e4a22 100644
--- a/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
@@ -9,6 +9,7 @@
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
+#include <errno.h>
 #include <generic-phy.h>
 #include <malloc.h>
 #include <reset.h>
@@ -165,8 +166,8 @@ static int qcom_snps_hsphy_phy_probe(struct udevice *dev)
 	int ret;
 
 	priv->base = dev_read_addr_ptr(dev);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	if (!priv->base)
+		return -EINVAL;
 
 	ret = reset_get_bulk(dev, &priv->resets);
 	if (ret < 0) {

-- 
2.43.0

