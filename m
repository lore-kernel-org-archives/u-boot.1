Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20201C624DE
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D972940B66;
	Thu,  3 Sep 2026 22:13:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TBIJm2_9sYlB; Thu,  3 Sep 2026 22:13:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E358D40B6A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788473620;
	b=nQcW3V+FlYRBimkTpugQWEGBq0/1iV+c1EzxvwHDp3hk09hvZe2meQcWJ/URN05T2nRj
	 KGYv3GQRILTmdB6edlco/eg6oqPmrLyYx8LPVBYwWxWk6HMW0iM9etBT7Ln7GkPdgdaH6
	 eD7wlkruWkL/N/FYpLrhvko+ZXKHhjxCuAfUeIXzbkPudEKEakr3DDeL8i6FB17EX+nZ1
	 eknnq1pFL0i2NuKmXRS8Yc6Q++2R9b+jUB5HQFxnMkO7Owyud3DVBpTVLJBPXsCIUyntl
	 TGjoq77zNzdonIzo7JbgCK2SNIgu2BOa52PU5Gistk1y4qmqR0H7imt8NyqiCYWYjqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473620;
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
	bh=2ymjrb5UROwAo3FJG9tAF3wAk6m/zFjPWiAANkCbZsA=;
	b=QE4It9BG8TpFopfRYrB18mOUM1PMwHM6VOf/JiF94ZsGNA0XGcvyaHzO4OR9Q00DMAoy
	 Ur2Q0mAoC1HuQ5P7gzHPPflKoTjWq8yBirMk+d4ORPdb3cLF/n91M1d3P8EgP0hsWgZiu
	 O7SiwadGawA5D8qE9n7InhqfiCTrR8b6NQ8yNkE9/MLEwLdcfEYR+juyGLWGNv94Nqkdl
	 Ct7Zt7r9cn+cP7e0QyVDgkr5c7FwySbjvWcwg4j1E48qR9F8wAOTbj+KHOitJJHYjpyt6
	 VyvTJ5rhkG2YaqRDTi/BPzVPSA05LyfiNVO2INbEvtT5R3hzRjm23pCmv5Yx7I60vZA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=U9fcX7H4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473620;
	bh=2ymjrb5UROwAo3FJG9tAF3wAk6m/zFjPWiAANkCbZsA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IBBVYi4krTLSh0VQft3xKSIY2r57PT7sYwVapgXDMV3vjtYbSQCYkujviRVEO9C2d
	 xISZZAZXlTvyBJHXInnMPM1ITXM5hy5BjG4Z7JwJxaQEuOMCC4asqP18XNJCTncmDV
	 +ozh3x5bUvqXyZYOIE3yeXe1GLcBtXbtvY3b74jCDqQAjsC7sE1L+wsciC4Ftwcey7
	 mcw1yzSl/bptWvc5OrpggN46068VIkHUKQf5eP3q8KfJoDIfhSB6JQ9sh15Ruf3nNP
	 FS2TaUg3s+B+7bE62NtqEJ7H9xQGkwSHPkkKxUzEPtrCsQzdJH/ya4JJ+Y1+T680ri
	 AV9whwzzVj2jA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E358D40B6A;
	Thu,  3 Sep 2026 22:13:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C1BEB2FE
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B386F40AE8
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TGtC2tLxy-g8 for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:38:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0C5CC40B00
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788471487;
 b=ZsKFlCDD40kgM5XPR7XOA3XpL2ShorFRaB19ZEOqz1KWm7M4HbFGC0x0YKBavdauOMGR
 REnyLBH2DSg6JCre8dlVmgqW05QT4wf36/cc6MXOpVmAqcdQNmmN4fLMavhlflog9GVXz
 EzhJ+wGsfwgtCrj8FoJMVv9gRBSRSe7TcaLoel3Pj9iSVYvzhstYxEfJImXSI3XaFRpW9
 jV/5wbl3GyjJUYt0/n+9pYYOU8yxZqLpPw+byI5PJXzCvCFcJRMThHPIhNKepjX0acaBX
 WDI6hJoQC/YJz48stDwp0A4qcNcBsEEU3xe5yBEoplHVGDtUjg5BCBXmoreX1yuZBrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788471487;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=2ymjrb5UROwAo3FJG9tAF3wAk6m/zFjPWiAANkCbZsA=;
 b=O4iiezm4JLSm0I79d9MKVrLPeEC29TCxdVFP1Qhl3AK2lgaOqHZraxpNNSYNM6uKaJHk
 Fu2vlmXdZiW/MBuZp2O7RFyDspj2lKMDsa/gkVU9/BygtfV6Rw8InBiWPqolUhks922Un
 frq+ZZOEMmRwz28SPif/IFhg11x1ez9p/c+Bu9n5GGRUbudw/O0HeokbBmxGCY6k+9gLU
 DynuW7eBxoktl+rCZ5iiX8QkhfOk3LSsA6TqWhpCmhIEAbLoFGC7JdzEV9/3QdEpLoUxD
 l58DkK+C/17qa8sXlsZutt7VQ2KJcW5hvAFvns61EnDuWt6I8muRbKz/vzpLS7pnfnw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=U9fcX7H4; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=U9fcX7H4
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C5CC40B00
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:06 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4563ac048f4so224379fac.0
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788471485; x=1789076285;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2ymjrb5UROwAo3FJG9tAF3wAk6m/zFjPWiAANkCbZsA=;
 b=U9fcX7H4bI+acY4dUyUEE9+lN9T9GrvBhGYAl9815FbVBgGuqwIQianOUY30oO0TBd
 5hZA8V96KH3lxUL6KCGk0mJo+66yE6inn0ig7gmxMOkjlIw0KWAEhSN13w5IQ+zr8ciP
 FZLXydSWQTg/3ZXT9Dr7iUPNjQbeXys95DovO6STzSRHAf+2rSj4mr4v5TBSG2+Gh20t
 hboLu/A7Ncj5p3VJqXP01o5WbyB8EfTTFI6+BlJU5oiH4cmle/ZXdj8HWSk9C+MbDTci
 F4/WAI8k6X8OwqVAZhKMcIvG1Aj1aCfq6Gua6CPIDPE5iDc2ecONMIq5QE6Uh+R7oRdv
 hukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788471485; x=1789076285;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2ymjrb5UROwAo3FJG9tAF3wAk6m/zFjPWiAANkCbZsA=;
 b=GClWYhQJVdkoZsSzOSQL5fN7ZdnAij3fpbqYxyuSznevYbpoOpxROXEcfJobjuv96o
 Mye5ka95eWAC42jpOHdpR6w+aD+IKGPafFQtqrlKWMgQLorEP2NTbPCPQZASiUt9Owgy
 33EVnTIQxtAL9KneeCJUfccUmbKc4nWkKq6JWsWX4NI4AkhBJj/bPZioMTzN5QIN1BFt
 VKyv2G9AymSGAmq1REHqS/D6LSm/Hl9W17FAKi1JIahd/RhjUBeFuDZjEphGAys8675H
 NqEnO83sdD3JFbRV9hn0eU6h9vXgCaH3OMPeuqR4uUM4MhvgmPnhGpujuE15fTw43ue9
 rumg==
X-Forwarded-Encrypted: i=1;
 AKwUvByxJcTVKPAt0VnK1E3E9ZFgbswvA3CVa2nwfRX/y0/Te9q/3YkBFSctUC2S6TUqTpKKiw4j13Y=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nnM65W/3HZKzyxvKZNNARN9c5prQcdH2nj/qNaSUwdqJDiGby/
 NMNIc532GDPTozPVMZCeqh8eK2V6gKDWyYq79W1Auki4245sP/in/HKV6NsfhmOVGBA=
X-Gm-Gg: AYBFou1BIEzEmIQ1wUtC5SdV3Q7F0vTa+1Swt9sLI/Sf3Se8RFAA/6ZcxF832mm6/iC
 tTgaUHTK8476LrJwZwyEfVsah0pyH5WCGzxRDxX5OqIBZyKoC6ehBdDeHZZKhfOBissur6ApiaV
 zZTdl5bGYP08DVwv9vt4Qec9TNtOZAJF57azX0+r6KjZteFPIQc6alg1pQU3M7tgsvS5IrfDS4E
 VYDGNbNORcZ+7j5ZnUFM+pULIz14aqoJHqg7i9Beh8M7zc65sFyktBJIC3NIU+hq3Yxj27TJxqy
 a3H+ph4Cq53cbeLyeiHtVy8rJLA+5idnrW8IDa8ldSSAFBKOsB5VvqaDMhtc+P5dv/tBJw6yh2k
 B8/EG7yeuuXhnkVBHRebEA2Rp+bzRO+iMd7wK9tWw0JBtPqxEnFU18ZcwjpQsqdP5wkc3Yadjif
 H82TzSBmwGqtNacklr/VPjmWQ570bhIlOYrF+pAiZ4/3foeOX+b8DiiJZSPFvalTzWJg==
X-Received: by 2002:a05:6870:3210:b0:46a:6e07:28a1 with SMTP id
 586e51a60fabf-4755135293dmr1893357fac.12.1788471485482; 
 Thu, 03 Sep 2026 14:38:05 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm682930fac.6.2026.09.03.14.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 14:38:03 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 03 Sep 2026 16:35:52 -0500
Subject: [PATCH 08/14] timer: mchp-pit64b: check dev_read_addr_ptr() for NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-dm-addr-null-checks-v1-8-db945bd5e712@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=852; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=tewVu1ApX/CXFjFmB9gNGSzZ7N1/5C9ScPEwnrABg3Q=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmehsbIyRDj0Ff1kCvdrZSqOl19jsRsSnsx/11
 OQW2wrJPv6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapnobBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AaDoIAJo5ubpTsg3Wqqv58ResPjIdsjpsH7PiQV6RBKz
 N64oTMbzWY5iow48eVYZ0cK6V/QlAUIRz/WtmL3sUiHo/jt+npkC5tURRndDPWL9G99aQGFkcH6
 tXazTub+Mi0wHmGyGjqZbWrr+jliRE0Usm5ezjZlBipbaR3hke4gB3je9jjC9nGQHeK5FaQdp31
 r6FKfDS2T6GSsmKZpgklhF1g3OLS69MaoVwwwb1rYio1vpWAlyE+lU8IZTIhUkGuNA48M4NMpJT
 5Y4SebSfIYrWq8YfTsC6ujLUzqKQF2qUqqjJ/HJ3GOQH4U1VXiKX71iQi17/jSBfrkc6/N4CzpY
 5sYU=
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

Fixes: ed1b726683e7 ("timer: mchp-pit64b: add support for pit64b")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/timer/mchp-pit64b-timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/timer/mchp-pit64b-timer.c b/drivers/timer/mchp-pit64b-timer.c
index 1a5b2e6a0dc..117236d51e7 100644
--- a/drivers/timer/mchp-pit64b-timer.c
+++ b/drivers/timer/mchp-pit64b-timer.c
@@ -45,8 +45,8 @@ static int mchp_pit64b_probe(struct udevice *dev)
 	int ret;
 
 	priv->base = dev_read_addr_ptr(dev);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	if (!priv->base)
+		return -EINVAL;
 
 	ret = clk_get_by_index(dev, 0, &clk);
 	if (ret)

-- 
2.43.0

