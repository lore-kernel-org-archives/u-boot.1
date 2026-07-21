Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F1BC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 08:36:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC3F980E13;
	Tue, 21 Jul 2026 08:36:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NHobzkQ7Z88Y; Tue, 21 Jul 2026 08:36:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06BB580E1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784622963;
	bh=4otHb8vjzqNnq2/Ws8YKn4PFY6sdyGzXjngaNajmH+0=;
	h=Date:Subject:Cc:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=dEO1PIynulLpoT8KPVq/FZYapMjYbjfZCNhZuUiQCvzKaxsuQ5KtX3Ov2GPQz3ZBZ
	 +qwkLwYA5+wYFcMjqQWPJiIUEqInzGSlYJpn1XIjcebwnyxzm1ZLiHqX6QXaPVTj/Y
	 FNPHUosNYGwOmq1lTUJai6rb9Ty8eLWc50UEplOWX2TjFR+2Qgl/i28vvMZxmiNKW6
	 EPNgf0bbdjmipsJeQ0VKF5vvrE31H5P7OtJkcqt1UWOI5LrskXKI8tTGhVlkR0jrK7
	 88GAuFyqyfgqNeqPAAs9irwdYrENUqWc87Zncw+46PtuXfM6fygjSj7azOXPw+HNi9
	 vAzg0MgQOIzjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06BB580E1B;
	Tue, 21 Jul 2026 08:36:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AFF88FCE
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95A1A4084A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:36:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f824wpxAOJeH for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 08:36:00 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C2E4740844
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2E4740844
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2E4740844
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:35:59 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFA9784659; Tue, 21 Jul 2026 10:35:57 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B1B803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 10:35:55 +0200 (CEST)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c160420289bso1558056066b.0
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 01:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784622955; x=1785227755;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4otHb8vjzqNnq2/Ws8YKn4PFY6sdyGzXjngaNajmH+0=;
 b=AZevpSxIqjesszZyHajUvSNNAemDSoh1t+jn1oYhEzEEzbDcISwXsjHUX4/ukRMVLc
 8yN97WjSNl07jxj9DNtbf+uEzGGvV1MY/T4smqsG4UAnQpIBDYCFFVvA1m1Bjt6Ig+MV
 ZZ0PJltrT8o/AALZYwYJbEqL338GzFED1sdcKNQuQ4cwjo1cruItBJ8+iS0HafkNs2pA
 Nx3t6gM2WVGKN2lmNrm0ZJCRfTp08mXr5qPy9cxmTRsykx1IfScWe0aXjJAYZ0ZDEHU/
 AwoRAx/M2C2eeOTwCtLBSbW8JxNu18JQxuFUrrr+Lw5Ur3t7jOJQjvJSVQiOqxbm5a/b
 ZCcA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJnd0AEvnpg/pP8eEzUL3sk4LQ/0ltdjYlJIJ30DULT28T/erqqtMqzPZwCkUl4ZJwUPN9cfg=@lists.denx.de
X-Gm-Message-State: AOJu0YxgkuXSTtNEtz8F4ACAeEC1L6d4tsJytjXlcOfzLjTT6mrtWxKE
 OxcO9wWNdFr9R/BU+Lhk04u6sazGJ74qcDJrdESHDyGFVn/1g+cs8isZ/gK1nboAePo=
X-Gm-Gg: AfdE7cnj2+bpxynnpXyx97X2SyZyvgofilMpkq2GSmQBz/3guW86iGhKuIXaZu+k8SR
 ++ER6TKiX70uF6oLMZGKIcgxmweKjYLQBykBCrQKYjz8yhGO37iyIQ8eYYnArUpJPDLtEbr5EGc
 byB2CNh/3/dpA+n3G5gSLMRIoCPyBV2UxA3RgFfFGKX7rtEpsA5uqBvpIYgjx21uM2kD5Fdpca5
 bwCPZO411fBnrTfNEpGsLVnAXnGl7j+/9DLqhpedcNpEYz21xM3PUcyZsoaQPcgnCdcUGkA2er6
 /HxkVEBdDH6DyOHQgzlW8gKKPP7/hyvZOdRdFdkUZ4xyc6pTIYf/pDJwLJvs2uXWiqjeUmsbV/x
 ycF7NG0zMUo4sYRDh90zyGwSQUX5vvNgD0AxT2zLCfiHKf+0NUjVL7N36lvFWMaGHjDrvNVwBkm
 sqM/iK8fcFYT7SADdjvdRn3C0hZp07gUlsUxPsLqS8BIE9NvDy/DzankBW7S5meR3Y7pE=
X-Received: by 2002:a17:907:ca84:b0:c16:12ff:dc93 with SMTP id
 a640c23a62f3a-c16b46d8f5bmr625078666b.18.1784622955181; 
 Tue, 21 Jul 2026 01:35:55 -0700 (PDT)
Received: from localhost (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1712a62e79sm554414866b.30.2026.07.21.01.35.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 01:35:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 10:35:53 +0200
Message-Id: <DK441ES76TIG.3324NPEM0849L@baylibre.com>
Subject: Re: [PATCH 1/4] arm: dts: mediatek: prepare Genio 700 devices for SPL
Cc: "Ryder Lee" <ryder.lee@mediatek.com>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Chunfeng Yun" <chunfeng.yun@mediatek.com>,
 "Igor Belwon" <igor.belwon@mentallysanemainliners.org>, "Julien Stephan"
 <jstephan@baylibre.com>, "Macpaul Lin" <Macpaul.Lin@mediatek.com>, "Tom
 Rini" <trini@konsulko.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Julien Masson" <jmasson@baylibre.com>,
 "Johan Jonker" <jbx6244@gmail.com>, "Quentin Schulz" <u-boot@0leil.net>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>, "Vitor Sato Eschholz"
 <vsatoes@baylibre.com>
To: "David Lechner" <dlechner@baylibre.com>, "Carlo Caione"
 <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0
References: <20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com>
 <20260718-ccaione-upstream-mt8390-spl-v1-1-1256b6dfda3f@baylibre.com>
 <aad6a791-7884-4e58-9b27-80d643f9525a@baylibre.com>
In-Reply-To: <aad6a791-7884-4e58-9b27-80d643f9525a@baylibre.com>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784622955; x=1785227755; darn=lists.denx.de;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4otHb8vjzqNnq2/Ws8YKn4PFY6sdyGzXjngaNajmH+0=;
 b=Q6i2Z3CbHvam7sqL25B8SthQMzcPhaZ7tosCsyAKWxU6JqD7vUfiXd3X0N3VgU6rbw
 tJdA/1PEqEaZ4yFIGFMkQbrrSlakDOnpWCdi9OdhWH/SgfNohyBT5xC4/976D8K2wtGz
 eNf5raOXt8QvvNVbY+Z7UW0yvfY9zj3382eKxZgOuIG5uGxFmkPW7h37pHBCKQ/UAjpu
 jQ6zCw3Rm5KfthW/qU7h5518xPAX2FMbFTM/i11U3UQ4jK/4h6OgQ8snlFc1VP6niJZ0
 Yyo9wVvYe8n7cdxgIwlYEpPqqdxDjCdwsyJ4DqsXGzv9E2X8dYPf1kp38ErXQBbAMV7D
 AjxQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Q6i2Z3Cb
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ccaione@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="Q6i2Z3Cb"; 
 dkim-atps=neutral
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
From: Carlo Caione via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Carlo Caione <ccaione@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue Jul 21, 2026 at 2:01 AM CEST, David Lechner wrote:
> On 7/18/26 11:16 AM, Carlo Caione wrote:

>> +&uart0_pins {
>> +	bootph-pre-ram;
>> +
>> +	pins {
>> +		bootph-pre-ram;
>> +	};
>> +};
>
> Is there a plan to change these upstream so that we don't have to carry
> this forever?

Yes, I'll submit the linux patch after the V2 but for now I suggest to
keep this change here. We can remove from U-Boot once that lands in Linux.

cheers,

--
Carlo Caione
