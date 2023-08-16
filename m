Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADFCC05052
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 18:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECBEB847D3;
	Wed, 16 Aug 2023 20:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="wVRSpqYB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5497284702; Wed, 16 Aug 2023 20:20:10 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A965D866D0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 20:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4195F3F0E1
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692210007;
 bh=iVvPSNZ1GNd+kiuiRBHa9Hhao9ouy36z59hvN4/obGI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=wVRSpqYBVkiAn32sbSA+CMQCgAWa7lWThnB2pAwWunUIVwWgTEolmA029yWzasxof
 tTeNkfdar//8IoQMWS/w3S9earC8FadTLbeLeMYXj6QCm/9QNYCQnrMxbdHlGyayUm
 p68lO7Fu1Lcmt6xs9GohTrGV38LXzoUhlKyXyypDU8ud+Ta9MXTwk0nz2RHLdis2VK
 Rwv653L5cDye7CdYtqX4Yg05CivbqAbiwBDzQfYwPpY7jBCsW12KBFyUfDV+rEgUbV
 XdnA0KtK5dW68v4zC/5mtKNtPAyCKEyiaw1dGgoBriivy7nXVrRMrx7EM3TqvMSQ9T
 Lt8Hh0zsyw6CQ==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe44619c97so648805e9.0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 11:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692210007; x=1692814807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iVvPSNZ1GNd+kiuiRBHa9Hhao9ouy36z59hvN4/obGI=;
 b=R8u9axJM5AJg25e/LN5GMfn2P8YlLr/LlQgsufrQrpqUjDqmOfZQTZ6D8QeploWYKD
 WLYNZnh1VwYJEcBFihV5w3cWtI8ZJ/ZqdOArjFUdO4B7BWlqEtLoIGVG/PnHgxA6keJb
 mp90HqUowK/RycMd/OvumnAQV61qcxP/54dtOagqVRseZU/dbInG5i6tG4QCsB84MzeU
 XH/SNZP6UDkaHnyFDB66uB3zAfhue+9XvLu8hoL50NPSoczKID/wBL1N6CQARuB2bIy8
 LIfXeq/OEpmOOVRVFx6JJHrx57kvPG84r4fzXvucivj8SFmOvJlbhZw5vnOcGk0iwjgr
 pHJw==
X-Gm-Message-State: AOJu0YyYhpR3Bu935DBFRjfwhdwSeJBmvG+R0ike5yds/uhB+GHvouBX
 pNaoLOLAxBjMLhT1iMgIZ2aCCOUH/5jmWqRiMmD0EdIjIEkkzPF7VHB/e3CXYyVUPlGj9Veyyi+
 vPFjsDxDTWJ4hej2qG691NLvjPrZYXkg=
X-Received: by 2002:adf:e78e:0:b0:314:314e:fdda with SMTP id
 n14-20020adfe78e000000b00314314efddamr323130wrm.23.1692210006942; 
 Wed, 16 Aug 2023 11:20:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER6S5jHIfLGbdRtWf7WYB0hv4pKZKtYpK7sLSV8y2y0HGOVN3kBys9CD9bHOEzedhWr03thg==
X-Received: by 2002:adf:e78e:0:b0:314:314e:fdda with SMTP id
 n14-20020adfe78e000000b00314314efddamr323110wrm.23.1692210006503; 
 Wed, 16 Aug 2023 11:20:06 -0700 (PDT)
Received: from [192.168.123.94] (ip-062-143-244-162.um16.pools.vodafone-ip.de.
 [62.143.244.162]) by smtp.gmail.com with ESMTPSA id
 d2-20020a5d6dc2000000b00317f70240afsm22095633wrz.27.2023.08.16.11.20.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 11:20:05 -0700 (PDT)
Message-ID: <8eb585d1-cea9-902a-86d2-54bcc439784c@canonical.com>
Date: Wed, 16 Aug 2023 20:20:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] doc: add partition API to HTML documentation
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Joshua Watt <jpewhacker@gmail.com>, u-boot@lists.denx.de
References: <20230815103259.17476-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ0BB90F4Zpq6AtyTPuME3XiJJYmYUOBhFCG9FujOq4wHw@mail.gmail.com>
 <d359a225-fbda-3bfd-ee5a-6cab8e011568@canonical.com>
 <CAPnjgZ3Ssh8=fvdRa+KM5h5BS9LQs1bTjdku=JqtqRA4rqLDFQ@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ3Ssh8=fvdRa+KM5h5BS9LQs1bTjdku=JqtqRA4rqLDFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

> 
> OK thank you, I will send an mail about it.
> 
> Do you think you could base your part on [1], since I changed the same
> file? It is available at u-boot-dm/methb-working

The patch is already merged:
commit 5aae021c30940a57862c1ea6a3cf8eeb88ca2c1c

Best regards

Heinrich
