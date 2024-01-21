Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4241C47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 14:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 208CF86E05;
	Sun, 21 Jan 2024 15:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CIUluftr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD25787716; Sun, 21 Jan 2024 15:42:19 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77F4886940
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 15:42:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6B3A93FDA2
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 14:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705848136;
 bh=NCBstZLTAEDGnikKf2UAdiLzM+Xpsdo+ICXpBqsYEp0=;
 h=Message-ID:Date:MIME-Version:To:Subject:Cc:From:Content-Type;
 b=CIUluftrDidq2DUh83nTLGWZ+/CumeqpbjptJikLFQX/V54GT97cY8E5Rd9q1z8ww
 uWLEHWKe1/SMLW0ofCDglYiFh6qrpgfI/JxYjiqJUdRe7begTddp4WnN7saVjECaZW
 2NzkEGlk/HCpg64He79dvIF5SNWijDJRE0Q/WNQN2UzU5xQS5Jv7bITCqMnVESrdI0
 o1WtptED1u9eJpFHU0Mn4lTqzhpv6Z2eeoP/FUgQXMDwNC66A6+dhpTb/PKmYdpKYl
 dc7Wf3FvoNHmzdnSNJYi9ywvrNOZyh6pSaGy/2ORDagiTF2ouOahayDET7WNQqt+pO
 Tm3xJIxmla/9g==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40e9d8e9a39so20487015e9.0
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 06:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705848136; x=1706452936;
 h=content-transfer-encoding:from:cc:content-language:subject:to
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NCBstZLTAEDGnikKf2UAdiLzM+Xpsdo+ICXpBqsYEp0=;
 b=aZhMxNTf2pxLm0u1Zuj8a9I7NIiYWkSA2BsFDUtGVsInDTji3hrDlq/b3IwqMkFtAW
 TWJJihJt21Oi0+PRwPr+59PHjbektVOHC8CnKkm9a8JitYFvVYk2Sde5spGFkK0I1OPw
 FDdDTquX7CjB3aLl21eq8dJ63hwD2vWYqqZezJoFzcgfAkk9O76E+jMr8QrG9uY+6SV3
 yL9C2mbusiLfpYJmWj3V++6zpcr7JLGQGGAn2lVE1ZOzETl1I55oFpfojYWopIhuCPcx
 M7oYPsgtUrzFQbVW48nbCgqxA1db/y9yw9p7h1i642ftYn/Icr2i8WSDlg7NWkxbJ6ka
 cJrQ==
X-Gm-Message-State: AOJu0YwxJssSHlBPMLdrbjzAI4tuv/z4HI7sbqXMBrd94mo9bFKu1+Wb
 J327ZiAbSz769bgIjWRHjHCBtpDHOLF55YzvNJ2VuFRZKqNS8W+xkf/iyG7+O6vNNnanIDrT8b+
 PP6nDQKsFWK28BSWGAElRRkRCIVL1e9Eqerm4bPkOxAP7Oszhdo7rJyjWvMJBYqPpQf8=
X-Received: by 2002:a05:600c:5007:b0:40e:6cae:479d with SMTP id
 n7-20020a05600c500700b0040e6cae479dmr1634663wmr.26.1705848136017; 
 Sun, 21 Jan 2024 06:42:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEP8Hk9ugcMX01t2rUGgwGn0IolE3lzYp7wJ0sTjjicvUT0zIs3t5ThlwSbNn/tCqp60cminA==
X-Received: by 2002:a05:600c:5007:b0:40e:6cae:479d with SMTP id
 n7-20020a05600c500700b0040e6cae479dmr1634658wmr.26.1705848135647; 
 Sun, 21 Jan 2024 06:42:15 -0800 (PST)
Received: from [192.168.123.161]
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a5d6a8f000000b00336898daceasm9117258wru.96.2024.01.21.06.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jan 2024 06:42:15 -0800 (PST)
Message-ID: <e72c7ad5-e1db-4065-99f6-326b55e7556e@canonical.com>
Date: Sun, 21 Jan 2024 15:42:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tom Rini <trini@konsulko.com>
Subject: ACPI Vendor ID Request
Content-Language: en-US
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

Hello Tom,

as we have started to generate ACPI tables in U-Boot we should request 
an ACPI vendor ID for the U-Boot project.

As described in https://uefi.org/PNP_ACPI_Registry this is done by 
sending a mail to vid-request@uefi.org.

As the ID is meant to have 4 letters I suggest to use 'UBOO'.

https://uefi.org/ACPI_ID_List shows existing IDs. I don't know if the 
owner must be a legal company (which probably needs to be member of the 
UEFI forum) or we simply can have "Das U-Boot project" as owner.

Best regards

Heinrich
