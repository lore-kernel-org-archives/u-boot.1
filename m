Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA78C5DF7D
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 06:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FDC14095A;
	Fri, 21 Aug 2026 06:31:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UqA21tcbpr80; Fri, 21 Aug 2026 06:31:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787293915;
	bh=bzLvLH0l5k2RuZTBSnlxIfzRS3hExiTrs89rzkF6/gk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T+tm2aJBfECxzRJxN53ilNuVDZS0oNhtq7yFNO1eTujexzB4SrL930mudhtpNpmYv
	 A0s/q+PmJqGOnQfsrwLyhxuqsUIskEheo+my1lVX4bLywtTC6nEKpdNUrNGsjh8LOF
	 OSHB5kQLJtiFsR6+ES625gtrFyVk1J3v4KIoNa4uLzdL46J5yhmt9k0EeBOOTCDtjh
	 tfp8u2F3/f8Zzoi+Xyts8ZYmUCBWMer+6hNf+geVLEEkS1cU6EIUHNy7oaQLX11vtE
	 WaNDAUOqs+mb1e3YsWxH6hBxHjJHOmrf9KecEp74cp9U1RVOieWVcGaOs9sTw5UkCE
	 16d/9oJ5h90Vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40EFD40896;
	Fri, 21 Aug 2026 06:31:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D60DFEA3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 06:31:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BBB2460810
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 06:31:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6F0INSP7jbvP for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 06:31:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=NYrPxlw2
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4BC6660649
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 06:31:50 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a374bea882so1473919a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 23:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787293909; x=1787898709;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bzLvLH0l5k2RuZTBSnlxIfzRS3hExiTrs89rzkF6/gk=;
 b=NYrPxlw21o/Od4Y4Th1Q8tqudSiAuv+tZdA0OJkGtPImCvWz4TvXoWlO9UCXXxj3Lt
 9n6wqSqUXF7dVK1/Bc1QBEsvKQWSjquvaF+MH/A6WNmChC4kTVwJoYkhfUPzDSZWRWCq
 F1nuswUaWxnUd5G2/FCYZvxfb2+0YQktU9McPEir7AOtbp7v0X3/C5wSr3WAyNvajfM2
 VzPY2atN9HeWbtwi0SvbVOfX/8+sT7nT4cs12VY90vMoTBuCj0lVvz4vxHaFu9ugo4an
 ecIeOo4tmW00C0E+f+D6rPvR9/zngVUnQjepomU+NDR4hCu4GSazfZG2TM+JOJzX5AUz
 d4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787293909; x=1787898709;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bzLvLH0l5k2RuZTBSnlxIfzRS3hExiTrs89rzkF6/gk=;
 b=jzcY5QXZQm+9QZtKS8lg8UIRQt1yRKlmVVVxbycVu+w/ZpXdu89vpcbKZYbzEo8TR9
 UesS1+JrbezPpZx0mGnRdGbaO8zQl8tb7YXurjBsuaEWHpPebeIeRTyQhTj2Z614v5RT
 0lFQBJP0Xcd6PxumWN0rOEio2rUVITiBIWlZpRduY1YLF4d3hiEe70q63NPhNnB5flBR
 k8vHRtKyvg8SDMfTr+Lumg77+YeqoVNEwgmXwl5VHhH/aLSkCWgMnM8gkFfl4XFopCT3
 EfOywM0m6ul2OPLI4lFvHrAyJtAtRaMGc44AT1LZino5jmbjQXVeZZ2RDFh8rzbT9CjF
 VK8g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rooznr/y/+yrxwMVBpFYnRzeRM4RnHQVYaz9cZ+luS3+wrO2SezUQveQRwY904cJYfqwJpeEqM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lQGua2DAzp7SNKFS8sqK1T3zpNQiXTzuU6nAeeLnXx7if67G5i
 lyKo4eBXvLX6uasQOKUQIKUZoYtbMgjbDSI060MZJgY1SyItC5kIieQZS5a/itd8b5k=
X-Gm-Gg: AR+sD12NQoGe8tI/GqqH8XYPCBXz+RyZsPaZHpMtRtABX7qDVQlFuUvGsgouyb4+6VO
 p56maMBUnIZ1sr7hMYYUVn9FCJB/RcyPvsfYq90gPXpPUx7aINj0ZOrhbuTm8PpQr2N/2RMiS/u
 fw2b3mBgpD1lFnHHfOtCC+M5KLQLdXch45KJOXaeQ72Lctn6mciUEXFHx/dPxea+t9Zb/q/PGl0
 vaFz5Kvu43kGyltRcf3BkNrdtSaIVuMWoQLVyeq00ba3v3Bni6wRMHG2xAorejoE5wKyI4nDV6D
 hMFv2lIgfN2n10xHSPuGiQK/dFBi1TfmbO/jd9LuwJBNGwfB0AyHnQL7kfG/jF0gPDBR4VchsUd
 44Mh2RICZOYou3+yJrpUUOeEv04X81QoJdcbOY3gCGiJt+pfEiHVtbQHFQR7E2sBCI3D6YZBL8p
 uKHiiEkO+jsiAn8EviY1ac2vBPTDKF/iNu1xB1OdE8r5WYDf0KYqgP3v5cby88e/DYf4rh0foPO
 hOYQKxe/+UdAS4+EJNKjJ2fg0IQXfHfoukIKAIczhcRYhPLv3w=
X-Received: by 2002:a17:906:eeca:b0:c21:2218:5c7b with SMTP id
 a640c23a62f3a-c246a2ef56emr376532166b.1.1787293908806; 
 Thu, 20 Aug 2026 23:31:48 -0700 (PDT)
Received: from localhost (host-212-171-227-71.retail.telecomitalia.it.
 [212.171.227.71]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2459197ce1sm324812066b.37.2026.08.20.23.31.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 23:31:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 08:31:46 +0200
Message-Id: <DKUET9PH8G54.2AVJ0J96R18YN@baylibre.com>
Subject: Re: [PATCH v7 3/3] usb: mtu3: add SPL support
Cc: "Tom Rini" <trini@konsulko.com>, "Ryder Lee" <ryder.lee@mediatek.com>,
 "Weijie Gao" <weijie.gao@mediatek.com>, "Chunfeng Yun"
 <chunfeng.yun@mediatek.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "David Lechner"
 <dlechner@baylibre.com>, "Julien Stephan" <jstephan@baylibre.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Peng Fan" <peng.fan@nxp.com>,
 "Jaehoon Chung" <jh80.chung@samsung.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Julien Masson" <jmasson@baylibre.com>,
 "Alexey Charkov" <alchark@gmail.com>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Carlo Caione"
 <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, <u-boot@lists.u-boot-project.org>
From: "Carlo Caione" <ccaione@baylibre.com>
X-Mailer: aerc 0.22.0
References: <20260808-ccaione-upstream-mtu3-spl-gadget-v7-0-ed659a79a918@baylibre.com>
 <20260808-ccaione-upstream-mtu3-spl-gadget-v7-3-ed659a79a918@baylibre.com>
 <3c8bc13f-be4c-49d4-ba43-65f787d82796@mailbox.org>
 <DKTVUMXOM1PK.MIFZ75Z7BXI@baylibre.com>
 <a298f2a3-f9cf-47ee-8133-1d13ed4ea7d3@mailbox.org>
In-Reply-To: <a298f2a3-f9cf-47ee-8133-1d13ed4ea7d3@mailbox.org>
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

On Fri Aug 21, 2026 at 2:33 AM CEST, Marek Vasut wrote:
> On 8/20/26 5:40 PM, Carlo Caione wrote:
>> On Sun Aug 9, 2026 at 8:45 AM CEST, Marek Vasut wrote:

[...]=20

>> Thanks Marek. Just to confirm: this patchset should be picked up by you?
> Isn't this patchset already in u-boot/main branch ?
>
> 948c428ff7ea ("doc: usb: remove obsolete MediaTek MTU3 bindings")
> 0f8cbf3a0d6f ("usb: mtu3: support the upstream devicetree binding")
> 08b77aac333c ("usb: mtu3: add SPL support")

Oh yes, you are right. I must have missed the message saying that this
was picked up.

Thanks,

--
Carlo Caione

