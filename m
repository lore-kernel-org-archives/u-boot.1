Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C8DC624DE
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF60D40B67;
	Thu,  3 Sep 2026 22:13:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kdrbaoh3ZXr6; Thu,  3 Sep 2026 22:13:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A477040B5C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788473605;
	b=kLo+979tXEmrguqJdc3pihGUwN99A3alMcAHzZPSCywUX8dSNiRGJcZaW0Loo7n80cuf
	 5cWl/b6m39O+mTfeSg01m3yGUMLciTfP0vsTCJsx90DKcY5tAoooFrh1ZwNV4QMKWUJOh
	 QuPxEocLiCqr4HoFcoNn8505ARGj3pFSDQcQrWxiB8t1Cq8qr290Sy9bVHCfJ2fd/8myh
	 1DCEEG0FrUN+AbE3PNGcQ3fk+pClNSj3Xu2qoYaNXEhii9Z/qaImbOTlYlJFf7l8WkF8J
	 Ad7WTnbUm5/8RhHuK4uIpIOym9FQQjVB7nHwGSKoi+vOzvdx7TjfCVyK/4eH04QVaZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473605;
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
	bh=aPs57XY6Bo4P53s6+KGRC0y8BN6GTRin6+TOXijGBUM=;
	b=eIh1l9791NY4bx/chVWCz/jVOBj+N3gnNfhqw4khTSosJAYuVJYEvMWRQRw0IxD8XdLO
	 CiyMD1Ix23FwhdGzuN/9CY+v0XvQTaqmvOEmxb0jLOXkW9uBnDnjfb4pv7CFzgMiJy1+a
	 nQG+oao9g9KPJXIphCmUC8urjCgNpoNJ5gUB6aKSfi8zCtHvWxmP4BYKFvBBp6uwv+OSh
	 H3yrn6omOXAWIzhSuAen9FfprkJ5d8HfApKOEmz5E7AT0o0jVYLhWIneilgHcVe1TVJFg
	 Mrj5iCXVFmicmQEf1ZdwTVT0mWprUwNF18OkoW6yAAVVoUL/HQ1LIMCW0cvj/cw3UyA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473605;
	bh=aPs57XY6Bo4P53s6+KGRC0y8BN6GTRin6+TOXijGBUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WP6opSMvaBuPgOYHIPJFcjDherqw2+JSVt1fAb3UTyY1MVwYDXj4wromJUCLw8EGc
	 HM5NlK+EFqz4lWAoOlC0utR93YWpdkqveeb36NZ9mN4bm0In4UJnZkOPlX2KYqKatK
	 oMBk9J9rnOITeEHjq0owixXuEaFzxtp3n085G0gPOEBuHBFIB0ucr5aU1RvS6jp58+
	 Si0rX+v5/A/CDorDTxk3ivspK4aKiEp0z+GNNI7zB/HwAtCAjOzZIa5tu1EbZ3KT6w
	 znz6rX78lfndqQm0LIraY6eHLTmPdb+67oSUkVIS5Xs9AysmMyT2H4XgUxOnQOpxZy
	 kULCzHJp6o65A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A477040B5C;
	Thu,  3 Sep 2026 22:13:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 456F92FE
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B9F7400D3
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ca9w-rqcGkrU for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:38:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 77A10400D0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788471480;
 b=beyzLAbdKNfJ9qb/4C3syRUgbOF1Gl6nKNmCB3Nsp8W8HMjofwRqHQxeldv0SxBx4eJ4
 M5c2xiG+bbZof0u6lpfVld6CvUmS+m11T1+i4VZ9xfVomY68Uzp3jQCQLOx4AsfOyvuIh
 3FehRKX8Wpr1ByOTQAwdeFqO319UawO8651erZ421cCfVY8du8TejKo3sce4eyITkW/Ff
 YqUt/WYDU1TGTg+V8aIMjNgwmJ1OtK94NR1SFZLwHU4mnS/KOFHDv+v85IOlkg6uXaHm9
 4xjN4cks9SUl2NfzjmwP30EBPqrP/9a/pgyGOrf331ErxWrKMTR5DGyJ5a+CFSUTjyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788471480;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=aPs57XY6Bo4P53s6+KGRC0y8BN6GTRin6+TOXijGBUM=;
 b=fo+2gaNrTzSlRjoI9cuKZ1Kp/d5SWZySIL2vpXZ3MucvyMwygSqeOrvDvUPcVmoYKdVu
 UKfI9DoFberrb52lDqe0HfE1jbw4tz5b+X3GP7m+PnEIVxSiJuAkHAekfphihoFSEbc9s
 Pwpaij7xwfdJ2sWTqSg2TdavniqOF4F233F4ZZTJPlD+izDS1Py6ya9OhlqBgTuIKrKbd
 NoS8rSG4bWjeoyj+nExyGHpNElFPuDqXQr9O5HB1L7l7fq0u+/UdJ1S6t+vFka9E3/L/Z
 6OddshKqRO7JFgDaLZsQtMN+mlwj4gLrKlAhojRO8/wTYICQ8k5hvGp0RG/KiSwa7bw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="el5VvD/w"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=el5VvD/w
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 77A10400D0
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:59 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6b1497f0453so230010eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 14:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788471479; x=1789076279;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aPs57XY6Bo4P53s6+KGRC0y8BN6GTRin6+TOXijGBUM=;
 b=el5VvD/w5jaDZpFwyKs9l5EFgZlxsqLlJlx8C+L3FmCJFboUKONkRVjL/vSgBFkW1+
 KLCKT+NhFrxOv1Inv+yIHCBFSh4ay3qFokNqfuPruwsj8FaxfEBCa/lG98TiEiilW3p6
 l/NlGcROcEOHxPY1w3ojpUO803B+ZQ4gSQ2pXW1gPVCzX5JpCgxYXXM2x3+JP3USkfv+
 ql/Ef+fj9PISIPY4eaKeeKboAHEO7kR0YnL9ZRwYeys+mGAACswqzdtJDEJBHhvx4qK+
 dnOrAxlgA64V8E/W9fciHjn1BQiXf0YkxwDWvMBr5mITCYLlNw6mmaX6uNn65TyVPZlT
 29fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788471479; x=1789076279;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aPs57XY6Bo4P53s6+KGRC0y8BN6GTRin6+TOXijGBUM=;
 b=b3XUSHfyc5pIGGZCuyPjhoG8GUCnOshqhIdprKwin9chqyg1o7Z3zWo0gjPpLrNHKa
 P3Wxy+wt6TNfVOuxrdM6I62PuxYxJDbaIAUULmN3+hwnQyxLZBEfjgumTfqYduNppapS
 eLe05FmvZghuVhy4AFokyOfwfqYmy69D6i+m84HQml1kZARUzk1IpdQGWYnhvvBVwrEc
 ZS+6XUjHfzL7Clal+VVNSug2m8Yos54WWi7LPd5vUccryB7tN1e6jIu954DPso4cy26a
 HkhBqU7boKBc5j83pJyVKeSJkolPUylod0+j6TAzJakqbZe3zOVvZCE3nL7hggbcHARl
 NwAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/W5xkYxcv69R1BrEQ1flqBTBjBXnptmGwj6DanoKTSQtPpyFeiAGmUEaWgzyKquDlgs2B0Mo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m0bIYWIgOqwzAI9jntChKBcNiPb3nEre9Y3L+rmMyuhdJq0Rfq
 JpLAQsq3T4ZZG3WZnEiYPVZOvzZJNCXeTiEYtxgIZWC5HUcDxKLyBazXyHluyloTfQg=
X-Gm-Gg: AYBFou1xwL96aHbEwj9nyG80lhMcKFia7z2EXrIOUodT9vX2Aj2rC0Es+LlxBoPA/Wm
 qrVVy+pEEHv6s4ntdW2OPZH4CevWBwz7uUMssljgtjmsqA19T4ubwgX0TzNQCptILbprnQ1zahc
 rV7ZhExVeuN/5X5jlfMiL+Lp1doDkusBiCpcCUKYnz9fba4VwsUDXlOjnKe5MDn+licd9SK7uuu
 iUVUHQp6bALWW+zzfbEBv6rCsp14tV/8VnYsbwCLAkPLsiNIemi7LdmDaliIrOci/x/0QN2WJIp
 BjDCpEwVo601n8sBrSivA2sUHGgHAs5lOEtT27So3V+HGntkI4fGW3KVm+N3Ga9Y35d5PQM2KFe
 EmHj7Kp1QFRBVcEMUDlxeheR+/eHmXyMd3mk+l50JJ7vw9HA0748ZtjipFXLvZqTU/3R5Ly+wg6
 qNa8x+gDWbpiCAP0lmfWFFu2LE+b5ylDuEpbdwg1xfFnbjGrdHQIV3cbLTOv7wlKhLvw==
X-Received: by 2002:a05:6820:4dcd:b0:6b1:29c1:3f37 with SMTP id
 006d021491bc7-6b6fcfdc537mr1750744eaf.23.1788471478923; 
 Thu, 03 Sep 2026 14:37:58 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm682930fac.6.2026.09.03.14.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 14:37:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 03 Sep 2026 16:35:50 -0500
Subject: [PATCH 06/14] usb: dwc3-octeon-glue: check dev_remap_addr() for NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-dm-addr-null-checks-v1-6-db945bd5e712@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QY53MBGLbzSwlJvtTzDTSYz8INBtUJ9OKKzS0MKr5SM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmehd9vATCDYwp5WcIrD4gcs4aViCE69j/V+WP
 mOjT6vtiSOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapnoXRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ANuUH/0Jb1uHEnr+1ANGR06B/dFKGhAiNicTMCMTqgy5
 yvYo7uBeVas5Xfq4+1j9NRJMSoKjBvGTdjZo0IT0O/du6OxKkcxAfAsFf6JjPRA7/3xKHSVukNZ
 pdU/V7jZL3iRM86RVt7kZDqCSRruIsJIoRqhbQwPOvsd2EgsfpPok6qB+4DwkCQShUGMPaWoBtc
 qJM9sHOT8qAazhC6ojVI0RHFSmGuvVaccdBRiMQomTVX9gWQYonK6+KjPMirfGjr03ksp5awC+E
 qk1uYuOr6dwe8XAhLL+Q/ejyJ7cHH4EHhGN7bWXKy/92h2dN5vnmyLv7jSTjCz8oLOD0HBR5WgQ
 e2hg=
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

Check the return value of dev_remap_addr() for NULL instead of
IS_ERR(). This function only ever returns NULL on failure.

Drop the now-unused <linux/err.h> include.

Fixes: 92ca2fee08d5 ("usb: xhci: octeon: Add DWC3 glue layer for Octeon")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/usb/host/dwc3-octeon-glue.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/dwc3-octeon-glue.c b/drivers/usb/host/dwc3-octeon-glue.c
index 975f375e15a..39f2e70e47d 100644
--- a/drivers/usb/host/dwc3-octeon-glue.c
+++ b/drivers/usb/host/dwc3-octeon-glue.c
@@ -19,7 +19,6 @@
 #include <dm/of_access.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
-#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/usb/dwc3.h>
 #include <linux/usb/otg.h>
@@ -351,8 +350,8 @@ static int octeon_dwc3_glue_probe(struct udevice *dev)
 	void __iomem *base;
 
 	base = dev_remap_addr(dev);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (!base)
+		return -EINVAL;
 
 	dwc3_octeon_clocks_start(dev, base);
 	dwc3_octeon_set_endian_mode(base);

-- 
2.43.0

