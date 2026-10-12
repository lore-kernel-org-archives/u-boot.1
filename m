Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C653CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 08:49:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A98B580CC5;
	Mon, 12 Oct 2026 08:49:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7z_ZCZsmdz9V; Mon, 12 Oct 2026 08:49:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E625C80CBA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791794978;
	b=GpRDl6bqoEAj82gdSs0jqFgMgfQLiZGz2+hmnmUX13nyYLSjgQILq/EyDzG3Cq6LXwDa
	 aYVznun/j2TZmrSFm+6wWg5/Xc16k6r+tweQvL14wj4n83wmB6mYpSatxGewyYhPFvj/c
	 ZG1vhw5DdXG6dD2+6BgdXe3GaNAC+TmHfqa8p+0k0MtDCJowbpo1MiKp9oynFIvUlOx9y
	 U5rHYB56BhZHm8l2Ka3uf3JNESR6wNiz4WQqV7Bj+oaUvrNuIAdeSDuBJpqtCs3Ijfp52
	 vHx7/MhMEXe7SNhe1TGU3XVUtLt3ltZG5n8+m3ztNS5kPZsrj6Gy6+b5xJo11g0/tTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791794978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dqZhf+nMoUS9DdCxXM7ZM0/9UyQFiOw2TUPdeG9x1DE=;
	b=GfTlqxWQML37B2yuowgFnP3jcO9GCYJpOsjegWESrP3Y6O0YAP7cncviAByA6pnM9Cs7
	 f3KFkChl2h2ytQxaQq2mWfI5CSdNNKRhD8zYDi8YWa/nFnfsuQsEt0f7LOsbf9FADC6aA
	 HT119JpSBfE9wuh8y27jk7aWVZvApGx1BDlJC9seK4DaPW/OS6O0tHzJ8wt8JYNmfrR+o
	 ccIVTS3qOf3ZPMmWRoXIxYpF7JltnmH9O4vkWfh45j9qp+6BnaNBLZXZXgukifmtdOEbb
	 LcrvFU0DtB7FzqrxyF/nRRINcuPFJj+grYMPIFVLIVQ/j77FA4jNZukElHd0uozzF1Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791794978;
	bh=dqZhf+nMoUS9DdCxXM7ZM0/9UyQFiOw2TUPdeG9x1DE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aTw4u7nMhT5xH1uebz4JN8g4cWl4SjyQHjQ8122C2dLvFkXQrcaX5PI03KZ1s3bXI
	 OBwexmpah7vKk8NL+T0RZhd7h2A2vvS2Ufrw2C5BsxiMwaO9LOc/4pRp61t7zBetN3
	 7OGM4EQAlNc2LErmo8bBXr7ZRDPzKPlrfQym3DNsmnCkhq7UlC52iTpMVzHFuCn2Ro
	 cczo81xw1D/Q4dD4LoWUe9O8Qn5SRBazwSl7/JikVbP5J5zStjri2Ktm9d8AilXAjY
	 6GHeE118QzBt/feXcUg9L2haG50a1D9gM8p+99Kb0liIjONggvn0KpcROtGgkvNqdb
	 l6do5HM45LC4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E625C80CBA;
	Mon, 12 Oct 2026 08:49:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D2FF1DE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 08:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3EB696061A
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 08:49:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KGIyG_7odwGV for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 08:49:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 000BD605F9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791794975;
 b=V6m5s7NGC1b53rBQQ4n60Y4wLVpg4P2jrwpNN14fE06N1r9NOH4tA+NRCEbDyZNwm0/g
 n75Rjym///1CDHEDBcg5AOHW/VhYYxLE5e5OMZEW9HHtQEez3cIrwDc08/DIDqlnXcGzM
 q8opSdu/0CDRHBVZ4kQcfeuIsUt5kSXIRwzf9iovhNz37qRJMKlzSmQTk1/KBr0K9yNwV
 Y2hG7rzK0SIUwhWaHHng82ulYkG+4L2iQWBHEBPZd0C/1aakN/zABPqXNaUtIVFjkMT1y
 9gJ2cH954cBmHGlJXu0V1ZvNXbXHjVo3A9+E0eU4uc9Nty3aOujqbGjyezonftF7qzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791794975;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=dqZhf+nMoUS9DdCxXM7ZM0/9UyQFiOw2TUPdeG9x1DE=;
 b=n0UR2skC3z2w3MN1XHrD+NqrWhMQbPWqYtEtn7ml/aDEIQ7zQCqi42WxStDVL6RA6cYc
 n9XVdlljI0SEXzhjT3gDvuJXNvjOUZW0lRLzKl+W6g1STOff5dc3KIZNt3XkYpFu/s+zl
 dKGwChcLqHtMHd4N4rJS3otIM2rInvXMKUg70/q9P0vAXh2/88GWx8aVkaUYI3wAaNkqW
 BOE0RK4QcuxJbKhhojWGusKInQBBTeYPJ2ZlWHA7APLnZwkNnUqLP9u8oY9AMAvw4TZi0
 5G8aB0omVxy2uJfvyFccoN+txut8nXhZe4ru+yrxWN2WVW7YnbgJTI1n8fpZEUygKYg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="N/YIgzlj"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=N/YIgzlj
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 000BD605F9
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 08:49:33 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a0213948d3so9805455e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 01:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791794971; x=1792399771;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dqZhf+nMoUS9DdCxXM7ZM0/9UyQFiOw2TUPdeG9x1DE=;
 b=N/YIgzljVeytRrn7qs6Vexy5pSfw310IfuZMoowLBUWgFVlt138NyNmPZkCj4l+Vhv
 7ewx7ce87hVPHIwO7NudSRBdfejVN7F+nZ5SutcRVJJh7twsiq9spE2wUJ7ddjR8dJU8
 sZnOEtybK5y1lF3U8rq3v2kIr06CFpm6ql0Z0TjukVbVRw0YK8Ud8bP2vbA8NoSopkB/
 SY10z10NTm7Po9ssyuxV1x62iA8Fd8/3qe5wXWfC9QIIZPeVcBEq5Bxg6OBJfUCIzDTf
 Vw+XCSMuoaXXyaXwpRSsTAzXsNu7YzrvTR3IVCYi+U+gylvIm4wZRUFaxAwX8l2dLNuw
 2DFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791794971; x=1792399771;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dqZhf+nMoUS9DdCxXM7ZM0/9UyQFiOw2TUPdeG9x1DE=;
 b=aULdAE3GEcg+nFb/dCKSVR6aP7am4VkQ01pd/ED4aDTauZVKRK93QuyrVVaKuBuiNI
 jTaui71NTSKRmvzF1Ae+ufZZnMxzi0Bi+kYUL0Cqox37AdfsI44teXfNmVT+BKw0i4Ut
 NxVzCcKec0l3sFYqz9UYya8M7ijY68GcF8cCFeXj3rkUU+LOqJOpUP0Jb8F9xCZKiyG4
 DTin75j3zgKQ0idIvuPxze20ou7GKoX3tCv7wHmAakpiNEAiE21vzikBOTgL8BkglM+3
 sAqedvlaKuRhqu6pH2OveHU7LeUS223UmbghWXa/GBftizzkKCOYlO/SJfhUiKn3vzew
 G1jA==
X-Forwarded-Encrypted: i=1;
 AKwUvByaOqq2niESDU3mpPhmixOnqmCpIISHHY3CbYS9S8fSi5ALbcg/X5EZtYpt3o01ChW6ZYKiEjE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKicFvWvgf7A1pDWH7W28GGqgwrilT+mDu25aLDilRAu/7k8VAv
 k19F+2fVkn2oqV+4nIWeVqp4/Wkgx1z3xCn9W4NTM6OhnwYT+UYZI6mAkNB1KxgpVzM=
X-Gm-Gg: AYBFou0//7M7vEd+jea1i+GH0p9NJAi3X+E4xP5HoMjh6SrH+nLE9kX1kQx/gmlWWLG
 0YgLzOVzAPGGKxpfhhBPWB239yNNleVuT01jTqogHYXwpgbsD47qYxKMJrCTI6v5LfM1e7H3Xmu
 iz+8ej/88RAQj9i6w4K3KJnBvbB2C8VMdpHpUK5ETU7SC3b04Zr+QRTCFAxkR+4Ft471ucfLbnT
 cuo+lD0LhWBe7M2Mn7+tHrwHroHmFhpFlRxJTPUlcbVmdmLgxkU7OaZZP4X3QZkbaLQPMBhoEyd
 7PoZtbL+QE2duiAK/SF1ul9Ht5A3p5c39/jUpaZy14Fu99cxKoa/hF/dv1WgKZfYUx3y6dZC+FH
 jfDel84Cx4vndrhNucgRt35UVXGOOSKCsj6/CGAsCRyraCn3TS9A+IV1PVYkEyeOOUDqVQfZTpm
 fZ+X11X496j0hmMKvqn3t+i/mwOCLNt5rRlPlltCEOrHDvAVKF/0lZx+cdO12de/vh3om3JH8wP
 rRIdTJK6CBUvONwCIPP0SyAF9QUnStbECWofWYOs8G2sjOeWuz3HgVremA5N195mdMNTiQ=
X-Received: by 2002:a05:600c:3554:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4a18e43a1cemr164145265e9.1.1791794971249; 
 Mon, 12 Oct 2026 01:49:31 -0700 (PDT)
Received: from [192.168.1.100] ([2a02:8434:7c41:c701:f269:609e:a542:3b36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bb68abfsm302752535e9.0.2026.10.12.01.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 01:49:30 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/4] clk: mediatek: propagate rate requests
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261005-clk-mtk-propagate-rate-v2-0-b823df57e4c8@baylibre.com>
References: <20261005-clk-mtk-propagate-rate-v2-0-b823df57e4c8@baylibre.com>
Date: Mon, 12 Oct 2026 10:49:40 +0200
Message-Id: <179179498021.53105.2622665206602410265.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1791794990; l=659;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=yQh33jWQ+DgCusoc6ohMBhZa+Ctjbi0z2S9VRUlRV0c=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDYii63Sxavbu0GWEzzfcYazutgkMzd71xGbg/pGP0U0z7CLl/OD6f2I5w7al2DokedYXhZkqPC
 AalbWNOf1TAo=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

On Mon, 05 Oct 2026 17:42:46 -0500, David Lechner <dlechner@baylibre.com> wrote:
> clk: mediatek: propagate rate requests
> 
> We will need to be able to set the pixel clock rate for the eDP panel
> on Genio 720, so as a prerequisite we need to implement a bit more of
> the set_rate functionality for the clock tree. The way the eDP driver
> will work is that it sets the PLL rate first, then sets the rate of a
> gate clock to get it to select the correct parent, which is the PLL that
> was just set to the exact rate that we need.
> 
> [...]

Reviewed-by: Julien Stephan <jstephan@baylibre.com>

-- 
Julien Stephan <jstephan@baylibre.com>
