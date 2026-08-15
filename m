Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7930C5DF6A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 13:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D89FD4086A;
	Sat, 15 Aug 2026 13:53:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mDQ1DwRi2mM5; Sat, 15 Aug 2026 13:53:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 44FEA40835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786802024;
	bh=gAsvWIc52iTIkA0AQB4qXpDAMfxv7YqLWNmDCyfs7dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IhKvQC3Iysh3/YWA4ioGeKHQNCEXk/+pJ/J1VAP6rQREGCs4LpI08O9lC/2OFC1la
	 u39jG/72vSlZUSOIyj20sztCsU+wsbb2/x62d5CRKjsVyL2XM/P1rT5EYX/e2PvE+9
	 J6MBBppXnHgqYangKAvPW2zkghCMMwU8C1JmAHKDSrSNhiNulRdI9C9lATxMg2ZxCr
	 yQikaa8WiasFYNi/9XoyfqpclHCmr9hY9zDakqLbtQYhdayIdFLdqpBxIrz9+gep1u
	 BNqeuY3UcziUdwUC4cRlQFgz4QupyLlbEfi+NcMgEzK+t8c/RkSaV4fGNw3a8RP3+y
	 hzgqWWjrN53vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44FEA40835;
	Sat, 15 Aug 2026 13:53:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F73423F
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5CEE980E2D
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:53:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6nNoTPXJAJJ4 for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 13:53:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6319280E2A
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6319280E2A
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=IwoDgKJY
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6319280E2A
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:53:42 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-527e352a167so13093521cf.1
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786802021; x=1787406821;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gAsvWIc52iTIkA0AQB4qXpDAMfxv7YqLWNmDCyfs7dw=;
 b=IwoDgKJYEBbL9iEuv5X+ww3XGFRaEolmTLFS/rtyvg9hXaCE+IkCXJcaBrtXsi0v+h
 TDTlzRDGzRr0ZCe66gjKMs3aFhZDVE+b46934G30PJQJ2XVn1PT85vMGs449k9lVXHun
 o7/nnQ9GO+QYijnb1VIU7O37KRSvKAa0M8hICbmXim+6hB+WU5NVLLXrspNYhjcj5UqI
 +6+I+P+wcCSjMbb4j3hWpCwym7g/YYC64Js0ObUvPAu0VZHIaP8s8O8km/3G6p3yY5SD
 0AedqoNqTEouOzJl+JhSgqCfhIE1au1pGryBnjlDu6CMfVvCxjJvpjKyX7n7fXFhHi4I
 oUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786802021; x=1787406821;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gAsvWIc52iTIkA0AQB4qXpDAMfxv7YqLWNmDCyfs7dw=;
 b=Tasdgos04IcRuRfhspacNLpS+Wq7iIvgR7p6csE/Nd/fWqyAqxGp65JrvA1BTG1Axz
 nDeIoAoBe6AsEWAOWZuoiJGh59FBOvjNA78//BmcbhaJL01uuBchna43guj4jGRHsgwg
 VGR7JDGhkxamCZQoosnq21OzJnCS1lYgwxKtUF891mqW/mw9/dIxF6v3at1xvGRJ/AwY
 83Tzjxo+OCwDxKLUl5oWWjmJMdcR5BRfawpv1sFOswRnyb13WhgdaRR8mGumwDAJI8Ih
 HiifJjpZs39yxK1H9MyF9roGvAFhlmn5Z+BlcIotIGY+V3fchGX4AlTKrZutvo8yYhbt
 uesw==
X-Gm-Message-State: AOJu0YyRJ9w1NUSKWLUeZw2Gm+qb0hZ2fyM65fVGnuLxyNm54yh+46uK
 0SM+OsOkA5kHeG1Qe88tnHsq4qfGXUzsLMa6E2Oy8aboXMQJcb7G4teISoLHptOSOHw=
X-Gm-Gg: AR+sD11YQ/vMcPboF9Wwa7ou6naayC5rE9ewqSZqVn63yRB8OwQ4FQ3xLy0XbjCdwJo
 FLeL83kCllzij0dDymVuIR758YA7XvpiE+3vJqHzGZg8w5Jho89coydJhhZbowxKLtqFHqck0+9
 rZWmuYH6K/ROutIxu5+dCoZvQMe2FCW7H1h3OPSYFLGLM+l7mQIbDiD/hKqX/ybfYtfpf/iij+P
 apCVB9BhlFMBba9Wlcg101vkb4WNklFGwNwQfM9E07EOO5itoq/L8xy4ublB86yHpA7VJpqnG8j
 FwFGP3vN5jvCgGKm/lg5f8pOiCsrdwILecxtfWaO/WbzbNXnguzqQP0yALlyiTUBy/2Za2cnbN+
 AAGUbPzd4Wsg+M0r6fnGqvQTftvHPBPXdUf2YhtZevxWqiYApn5j0am/1zO/NMyxrZv5riMDbew
 dOcJLmAoQOinKhDzgGv9iNuWET3d1kgrOZu44OtSvTwqte5Tk3mSzK+cQLy/2NfuuTuxqFtRVQA
 phAFtq+/VQxTe45UBw1RBoecdwd003+yC76M2qho+U=
X-Received: by 2002:a05:622a:17c5:b0:52d:7c2f:7561 with SMTP id
 d75a77b69052e-52d855887fcmr148996591cf.41.1786802020879; 
 Sat, 15 Aug 2026 06:53:40 -0700 (PDT)
Received: from localhost ([66.129.139.8]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d840f62a9sm45245701cf.31.2026.08.15.06.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 06:53:40 -0700 (PDT)
Date: Sat, 15 Aug 2026 09:53:39 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] pinctrl: renesas: r906g032: handle pin subgroups
Message-ID: <aoBvY59NI-gp7lpk@maple.netwinder.org>
References: <20260814-rzn1-2026-10-pinctrl-v2-1-95dec872b1ca@linaro.org>
 <68bf41a9-8b6f-4d55-a0d4-9b999022b06a@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <68bf41a9-8b6f-4d55-a0d4-9b999022b06a@mailbox.org>
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Sat, Aug 15, 2026 at 12:00:23AM +0200, Marek Vasut wrote:
>>diff --git a/drivers/pinctrl/renesas/pinctrl-rzn1.c 
>>b/drivers/pinctrl/renesas/pinctrl-rzn1.c
>>index fdc43c8e714..6c8d40e9639 100644
>>--- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
>>+++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
>>@@ -298,11 +298,24 @@ static int rzn1_pinconf_set(struct rzn1_pinctrl_priv *priv, unsigned int pin,
>>  static int rzn1_pinctrl_set_state(struct udevice *dev, struct udevice *config)
>>  {
>>  	struct rzn1_pinctrl_priv *priv = dev_get_priv(dev);
>>+	struct udevice *child;
>>  	int size;
>>  	int ret;
>>  	u32 val;
>>  	u32 bias;
>>+	/*
>>+	 * Handle subnodes recursively, so that pin groups work.
>>+	 * Note that properties are *NOT* inherited from parent.
>>+	 */
>>+	device_foreach_child(child, config) {
>>+		ret = rzn1_pinctrl_set_state(dev, child);

>Can there really be infinite nested subgroups , or are there always 
>only groups with subgroups and that is where it ends ? Linux 
>Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml 
>makes it look like the later, so maybe the recursion is not necessary 
>here, instead call device_foreach_child() { device_foreach_child() { .. 
>} } to prevent the possibility of infinite recursion ?

Realistically there will only be groups with one level of subgroups.
Perhaps if there was a phandle it could go a few levels deeper.

Unbounded recursion is not really possible here unless:
- the device tree is infinitely deep, or
- there is a very serious bug in device_foreach_child()

As these both seem unlikely, I opted for the simple recursive call, but 
I am happy to change it if you feel it is better.

Ralph
