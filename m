Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7017ECE579
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 14:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34E7088DD8;
	Mon,  9 Sep 2024 16:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lnTHMSZ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49B3E88DFD; Mon,  9 Sep 2024 16:11:44 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16C9588DD8
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 16:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52f01b8738dso2938439e87.1
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725891100; x=1726495900; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wiifKrrO9Ik/P3NzWvAd9ea/jSnF6t3lUHHux08a2WA=;
 b=lnTHMSZ8obnnMnlKZ7VHeiY0CGlwahmN9/q46pGNKkzIaXyYCTHrguADf3z2WSD4Lz
 3/mkEUaFxGIeaJ8h2fQZ4jg1uw0erYvIeufVXcMl/Z/7avkiW1iJHt+NTl75PpN42/7P
 xnIz1rPK0RbjAh05Fr5PIxfzaqZaO6Hfxdfhzlc3+sfUP4Za3Bz62jUyDiMfURvYV8dT
 ZGSFoiBqj1MXU5jOrUoN1RQ/sIepIgq8SQ9luUUGMIMGnk7SwLxtoOzgz+jsuLSf3zRJ
 wpWvGk4zOHEOSabTP0lrD0VmDDdr18rVWsQcpccFkH7YPvNOoY7QXxN3CDtDCdTKB+h7
 lIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725891100; x=1726495900;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wiifKrrO9Ik/P3NzWvAd9ea/jSnF6t3lUHHux08a2WA=;
 b=mT2GZ0+uvmC+7ez+RwdMGQ93QwXWe/kTasMzORMDmf/ddyy4MfFBIe9fzFoYH3aFzu
 gW2xPtRO5srjsgWd2z7ZM84QbvLg6zGrDGdjO5PZBOWLh96VOPAzV/+pOuuT5WmjeENm
 jYXfyf8dlDruDu2h87J0VpszNonX/2/JLBV8LS/LmKhKOikWN5y4TEkNZuSZ/r8hFjbN
 oiQiYOulWNIVQejiek6u9wWCh5v4phfxzNSfQI3HyHER2hgGvwL5idunlwLrNvsQew9v
 xuTzcjn8IJ6myxNlcrmt8qmWF14CipqFtxgtL6maWECsyMAq7Bgj9r7X6erH0yKBVsaL
 odJg==
X-Gm-Message-State: AOJu0Yw2hCsCmK20mYwrKsJKlUKFvSA1MgG8+PTFZJz6AJmdu/0hzwmJ
 QzvipMJDeojlwjxNr+U7uda/qPnf14GRD48Oe0Vlk8jMjCCOxlWygRLfhknhvBaMiHWGwr2q0Hx
 utyaffw==
X-Google-Smtp-Source: AGHT+IHA8JN0Z+VO9fcsyYTwoqAKXzuecgZ4fgAG76ljv5lht3+GC1ZJqvHfZn73+lInr0o6sCSkXg==
X-Received: by 2002:a05:6512:3c98:b0:530:abec:9a1b with SMTP id
 2adb3069b0e04-536587aabdcmr8375431e87.13.1725891099957; 
 Mon, 09 Sep 2024 07:11:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:659a:bce2:fc2e:d886?
 ([2a01:e0a:3cb:7bb0:659a:bce2:fc2e:d886])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c80a24sm347587266b.137.2024.09.09.07.11.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 07:11:39 -0700 (PDT)
Message-ID: <4b66d045-5410-4991-96e5-1d9cd98cbdf9@linaro.org>
Date: Mon, 9 Sep 2024 16:11:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/25] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
 <20240906175433.GE3879073@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240906175433.GE3879073@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 9/6/24 19:54, Tom Rini wrote:
> On Fri, Sep 06, 2024 at 02:33:16PM +0200, Jerome Forissier wrote:
> 
>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>> stack [2] [3] as an alternative to the current implementation in net/,
>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>> reasons for doing so are:
>> - Make the support of HTTPS in the wget command easier. Javier T. and
>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
>> so. With that it becomes possible to fetch and launch a distro installer
>> such as Debian etc. using a secure, authenticated connection directly
>> from the U-Boot shell. Several use cases:
>>   * Authentication: prevent MITM attack (third party replacing the
>> binary with a different one)
>>   * Confidentiality: prevent third parties from grabbing a copy of the
>> image as it is being downloaded
>>   * Allow connection to servers that do not support plain HTTP anymore
>> (this is becoming more and more common on the Internet these days)
>> - Possibly benefit from additional features implemented in lwIP
>> - Less code to maintain in U-Boot
> 
> On am64x-sk (am64x_evm_a53_defconfig) I'm seeing:
> => tftpboot 80200000 EFI/arm64/grubaa64.efi
> Using ethernet@8000000port@1 device
> TFTP from server 192.168.116.10; our IP address is 192.168.116.23
> Filename 'EFI/arm64/grubaa64.efi'.
> Load address: 0x80200000
> Loading:
> ... silent hang ...
> 
> Which I didn't see with v9. I can test other TI K3 platforms if it would
> help.

Weird. I compared v9 and v10 (rebased onto the same commit as v9) but
I saw nothing obvious. Would you mind running the test again with these
traces added?

diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 1948fc1c309..9bbfd8ee5a7 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -35,6 +35,7 @@ static err_t linkoutput(struct netif *netif, struct pbuf *p)
 	void *pp = NULL;
 	int err;
 
+	printf("[OUT|%d]", p->len);
 	if ((unsigned long)p->payload % PKTALIGN) {
 		/*
 		 * Some net drivers have strict alignment requirements and may
@@ -252,12 +253,16 @@ int net_lwip_rx(struct udevice *udev, struct netif *netif)
 	int len;
 	int i;
 
-	if (!eth_is_active(udev))
+	printf("[IN]");
+	if (!eth_is_active(udev)) {
+		printf("ERR: !eth_is_active()\n");
 		return -EINVAL;
+	}
 
 	flags = ETH_RECV_CHECK_DEVICE;
 	for (i = 0; i < ETH_PACKETS_BATCH_RECV; i++) {
 		len = eth_get_ops(udev)->recv(udev, flags, &packet);
+		printf("[IN|%d]", len);
 		flags = 0;
 
 		if (len > 0) {

Thanks,
-- 
Jerome
