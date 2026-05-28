Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00329CD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 14:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 612B083FB0;
	Thu, 28 May 2026 16:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="ORa8Ka6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DF7683FF5; Thu, 28 May 2026 16:46:56 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2921D80398
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 16:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josh2@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id E58D126EB4;
 Thu, 28 May 2026 16:46:52 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qdAmreoZ6SE8; Thu, 28 May 2026 16:46:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1779979612; bh=at4ZzsFmq4/C8X9mFmcPpGx3KcrD46qgEcJyX8MWrYI=;
 h=Date:From:To:CC:Subject:In-Reply-To:References;
 b=ORa8Ka6O//6J3VMnD+l2uZcN9Edu6ojKGH/R7+xftmgrLPgF1+79yriAraGCPwFs4
 en7npRZmNU+Zl+FiFV0Y0T/QcQu3PR4V8jwxX+/JNqGM9lMI5XTElGY2qAu2vd8Jmu
 oGY7Wx5Zd4fKcwnKMjEP12SVl8h0ksKbIoeB0IErFJBpTW3FcjQscT9Z83jYAz7iQP
 xgFj91z9l8uHe7C53Bh/hq68yZ8g6pze5AaIrAnmCkpapDP92Mbjuh1yc8mxD/GL5A
 AMJqgCMwL97OSclJontopCmOsoDaLQUS+ExSjpqcgy30g/kNd7QTBkvcu1QTuD0jod
 xVfLI6+b9Iw1Q==
Date: Thu, 28 May 2026 15:46:51 +0100
From: Josh Law <josh2@disroot.org>
To: "Lee, Brian J" <hibrian827@gatech.edu>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Kim, Youngjoon" <ykim3186@gatech.edu>, trini@konsulko.com,
 sjg@chromium.org
Subject: Re: U-Boot TFTP OACK option parser reads past unterminated values
In-Reply-To: <DM6PR07MB4377F2C4B242629F7E4FE52DF6082@DM6PR07MB4377.namprd07.prod.outlook.com>
References: <DM6PR07MB43775463F18267C7C1AE8981F6082@DM6PR07MB4377.namprd07.prod.outlook.com>
 <8C6CF5D6-B9A5-4837-8D4C-86E151C7A617@disroot.org>
 <DM6PR07MB4377F2C4B242629F7E4FE52DF6082@DM6PR07MB4377.namprd07.prod.outlook.com>
Message-ID: <E4D3C94F-5528-4BFE-9B8C-55CEC835E6B4@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
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

On May 27, 2026 7:55:58 PM GMT+01:00, "Lee, Brian J"
<hibrian827@gatech.edu> wrote:
>Thank you for the acknowledgements! I apologize reproducing the PoC had
>difficulties due to poor quality. I will make sure to improve that. Thank
>you!
>
>Best regards,
>Brian

Hey Brian, sorry for the unexpected email


After playing with my server slightly, I got your script running :)

[run.sh] reusing existing
/home/josh/stuff/u-boot/INT-tftp-uboot-short-ack-oob/INT-tftp-uboot-short-ack-oob/poc/source
at
215496fec59b3fa09256b4fb62f92af46e2ec7f9
ERROR: AddressSanitizer: heap-buffer-overflow

I've CCed more people who can help you here.



[Snip!]

Thanks!
