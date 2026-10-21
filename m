Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B702606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iDRvQ5lb;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hNrzptLI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D815981080;
	Wed, 21 Oct 2026 11:59:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hzq2Xn2GQBKk; Wed, 21 Oct 2026 11:59:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 29F4E810DD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792583985;
	b=rfPIdnvzCR0V0PMLKJkhQf89kYif/RzQX9cFOW3tfVMgxMMpNlh9hTf9DhEB1QAM54m0
	 TWx6uYIUcC2nu603unohHiLdJZ5ruTE8l87Yp1d7bo6a1/hTSGVs2fQFq73WyygfqYjTZ
	 +xfVJL1ra3A2tHurjJivbj09waBO4UEbGmqN8qmZuPf9W+lOj/S585K99HPle9iYT6ZBH
	 5DV3NH65yWeO3zw2N8KiqlMW9cLCd5SjJA2HXOgS5G1Ceott5+LY2qg9v8bwjlkwahx/L
	 PlsF2vvqWUPbEWY24fDX4frgzzaYen8vPl3MQpOoKhXQ77X5YKhuEbJobmW3ttBUmyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792583985;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7UUzh6Tomf5eCqWwmwVl6mhW+GzBZRpSvZxxYCdLtN8=;
	b=oyIRh2tB3sjrIJT6z25TTW/kPRbHWG27Go02W0T8fVYQdSVQKyKF2ZHgiqEhI+QMXbwZ
	 NXwQGWOoHKeHEjOJVQWWw5cQAPiJ+3i2xSxhxPYBuD6pMosZ7Di1AEGpT4wpbgjJ6EqvD
	 oUdAAL+I9d34alF7kpC6bQI5bzz+ECwVw90qzKjhNE5TB7wkM+qedlY/p2+ULZHE6PiAg
	 EQWhFCcYpWlcbgKCcieJk4TSZ4YeZnJhmeF/Q0gfZdtKl5KuIhfV5EiHlFE3RRmaT7ntw
	 gyJGHDPYUOh3ZRwchevrhJ3D+zM/BQIZHBbTWyho+9WCuyWuMWZaj8pWiWECTBiSfkA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792583985;
	bh=7UUzh6Tomf5eCqWwmwVl6mhW+GzBZRpSvZxxYCdLtN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iDRvQ5lbrmkpgqbT/NHXelsZqk9mJjheGYzffvnFRrmuvQb2iveTU2RjO+vxIrVNJ
	 zmW1i+7j518jvsY0IaOjg7svXVvWbM8AYhTmPuRsEj11IeD5sDvGfYi/k8AtOAjgJI
	 To0KernPJ93ZTsEIYWRG65N7emvB85NyTGMepu+OF5UGhS01sO5JmmbjWaojZQrggY
	 03qaYqp3PAzX6TDXlYkZOxvRFuH6Af2tsegUreT5NU1e/wniuOu1u3VRt9ssQZLfsi
	 OqcwzgZ86hf/b8dV090uHvQxMxCV9WokeV1FbpNpTVVcYWp1LP2EjTKE/ONFuMSNQz
	 xeB9L+pfF9nBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29F4E810DD;
	Wed, 21 Oct 2026 11:59:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B178380
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:59:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D772407A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:59:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j6p8AhU1W3Jh for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 11:59:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 71F4C4066F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792583982;
 b=ot+8j/2x0dqEjRuXbkbCvzY1gqEcYLM1wQJOPyKjlUVuvONw/sYhnWvlIrxK+nCYxCc6
 miAoy/EnL2kQJH2DfzYFvekE86+m/LYiY9iDl8C3C2+jVHYy0Tt3eHKk7XjpkNbIUybiU
 bAIG2n1SERcehsfe9ELixgMImFN99v4nLTKDJlSlWJNEKJrMuAt0cYuFYswLH+tqZfepR
 HErFFlYJslFkBJ4jOuucowEGH2tduEKvkO+T8zmGSqdYi45jSHaevZ1Ts8RBAfHSRQ0I+
 a02MSvIs3YMboZjcdrgpYHBghkiFK5QBeRyIlgfC/QmZV3/X08uxbRhJKTSNsYB/ozw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792583982;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=7UUzh6Tomf5eCqWwmwVl6mhW+GzBZRpSvZxxYCdLtN8=;
 b=UwJzRY2z7IJ9RT0VB4fFxCNK14syn7MkCdF8R4PvITBHGU+0oYFuno+ztgRAg1h2un7E
 CxTnGnU5EnPUXtcnI4KhgoD1qmh9XpKEUHhjw8kIhlXqyfjPTn4nEFiCvVyx9lE6XjPPH
 XizH6t7Xk3rE/fpjxAErfWKEctjWUCicSHjGjOPQmdAibgAWpe8S/GIZnh2KP8SrxwsaD
 gXLslk7hQPLT6w+WlP/8NX2Pim5p25BqNLPZrmrWzYuQcCEghHdfz61h+tPuwPehdmdqJ
 L9fZnrHCOKtdUjDr50XKnr2DSLot0vUuc7DTkGYV/Uf2RFSEkD1r7zy5PqzTZwO4tqw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=hNrzptLI; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=hNrzptLI
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 71F4C4066F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:59:41 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a1dede3c2cso8219315e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792583980; x=1793188780;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7UUzh6Tomf5eCqWwmwVl6mhW+GzBZRpSvZxxYCdLtN8=;
 b=hNrzptLIfGyP+r6GOZFO3didqTGpBEcKAarP/DBGhtJtviUtRjFlfCInLpKwE1Wf54
 ZG1UjhYDc8KQeKd40srsNQm51HbPZ3pD8Gd4D7sylibZn8ESy4SiLDbyMBqztVaVrTKT
 SXfKJky6sbdQ6JxDgmTCfnRxEW52ASRPhzTMePx3VBi9aNL23hecj0U5q5ztAJAJwyPv
 7a/32sawBz5MyUSBY4IsPWuwKVPIjvxLtboLbheXgX2lul//nhZBjAu3IqT/6FS9rBBP
 0nEouzZ/KMwAMqsd2xBOcMXe+ji1XzfA53K1jOEgU3SSX7IK1q/+3eunHhvo5wvdw/74
 f77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792583980; x=1793188780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7UUzh6Tomf5eCqWwmwVl6mhW+GzBZRpSvZxxYCdLtN8=;
 b=LXyF0zi6jUWFgqETFGuvolyHoe3CPKoudEgI7qHS54JAXRfdfxHPxlkxe/0zIxYP/r
 kp2ksjbEFParbnnG6RmZp0LBfzCMwFJ2xA8Zwm10Secphdok9p9ZLd3WGdiNnqWrRNQs
 4BtK83ROg471DnSr58FltF0qA0dJ3dE+q0X6DSjLitrG8W/xqD+qeIFeJZlbBkX40lfX
 0Qy7+EcUFg7D3DxIQ3HF05oE0TKDKe3UfDJxGCM8mlnE4qjFYsENdg0bdBjWiiVZgAL7
 pQwUmFmCdvp4EyyTCzF0o4xIoWFBmy9TUJcMJyFr3ic2vRlC8qp3vpHWm+9GbpsjF+Yu
 L75g==
X-Forwarded-Encrypted: i=1;
 AKwUvByTPOmxfK7ynxOAMFAUaGug01w143dUCU+m5ugC0wdZ4qVzzUYR3B/Oq7AndC34mmcXHssdB8I=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK1RGFH7Hc7/WKtz99bFeUncvMMTYhmKavefJf33VX3OIp49sSq
 71/NRwR+yj08jtL74YovfZU8ll8WgqI9EOnaSOsbog6V/2XEwEectH68
X-Gm-Gg: AYBFou1tKhqkxDN4yi9VjVUh8rMinJkpb9xYNkD2FLnlw/TirdmWDNzIQh9H3GAiMre
 KL+h2PsvKlBZWbmVTWnRsZCtvpVxJdVomq6KRMCe6ap2t8G8Wzkz45G79BtdK5HQawpXizkFTyw
 Yw82gbOPZWjwV7tgrsyg49KjdOnQSxSq9rY2ZorLfNFgB2zadtwFAhVZyu+D55zqwW8xe0MBGHo
 ZdypVLm0/a9JE/VjdCemj7ZVo7lnh/hhcpTU+vAWrTkaGDyU6Otv3rMjrooPHMZ0TTtkkjmqbn0
 53HMw6iLgJugQZQ1dgZiUZsYbqa9HhNnpuS3lx+VWfvbwcZ/0MYVZQc63SYUvpo4ADN76c2EV33
 Vt9KlH2buYyxCsrFF1VZtvj3xFHOu/lR9KMXu+LRT3qMxd8o77qv78BNa+OyNhRrFWyHwEp5Gc7
 qmcT+ybv+lWej+VILKDzOzOOfp6pYd6mBmuFCL9xI46Xj0DBt1s72b+yTNTcbcSZKgc4EfDXZPC
 mLiWP9FFjtdEylBUO9oAyYiSZqkU1a+YnuZVHWMSlrNmYIcVSEqxwc9/G4wEg==
X-Received: by 2002:a05:600c:4fd4:b0:4a1:7ba9:da2c with SMTP id
 5b1f17b1804b1-4a1fdd4d220mr35815685e9.25.1792583979752; 
 Wed, 21 Oct 2026 04:59:39 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d6e2dbsm157850365e9.13.2026.10.21.04.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 04:59:38 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: Re: [PATCH v7 9/9] usb: ehci-vf: enable the vbus supply of the port
Date: Wed, 21 Oct 2026 13:59:37 +0200
Message-ID: <20261021115937.4137154-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <38372dc0-845b-428e-b26d-91c080ad6dc2@mailbox.org>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 2026-10-21, Marek Vasut wrote:
>> +#include <power/regulator.h>
>>   #include <linux/usb/otg.h>
>> +#include <dm/device_compat.h>
>
> Keep the list sorted.

Will do in v8.

>> -static int vf_init_after_reset(struct ehci_ctrl *dev)
>> +static int vf_init_after_reset(struct ehci_ctrl *ctrl)
>
> Is this rename necessary ?

No, v8 drops it.

Thanks,
Mehmet
