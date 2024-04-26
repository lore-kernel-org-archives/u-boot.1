Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A61C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AF3587FED;
	Fri, 26 Apr 2024 16:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=asics.ws
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=asics.ws header.i=@asics.ws header.b="brd3SAtr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F9988834D; Fri, 26 Apr 2024 15:18:57 +0200 (CEST)
Received: from durango.smallvillages.com (durango.smallvillages.com
 [192.211.125.240])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9359A8808B
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 15:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=asics.ws
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=chris@asics.ws
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=asics.ws;
 s=default; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
 MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Is8nbFMc9TU6ymk1zj849RJP1PZL0NCMqAhE/t6yDY4=; b=brd3SAtrGm9k82guwpCSav/Pfy
 7peIKg+qIwdl/tbn3yMiMeqNKbSWL523B6AC5hcermXCVwT12xj1YO2vR/VX8Lt+0TIZlAV9urdLG
 GsT0IfnGpKYB9iB6p5ZaWb+eYFaU6kjUPoVpHYUw45XqsIpNjtfWmDFFgbpL3tQNVWPyrao4yYHhC
 5N3iHEe9yAwzwe9vkeThWz0kfXRqHxcUKiJ4Ya5yAbrV+75JIRBwErV1l1oy8m2ohCCuDE1srvU3N
 a7KudUB5JMIhppry8wLhenNzB+mtG4EiRaqz2WXmNNT+p9MMs3q5+1JIgjZiyUd+H0h7/9F1dE0hW
 EnNX6ZOw==;
Received: from [223.205.153.24] (port=55594 helo=[192.168.1.212])
 by durango.smallvillages.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96.2)
 (envelope-from <chris@asics.ws>) id 1s0LTY-0000By-2r
 for u-boot@lists.denx.de; Fri, 26 Apr 2024 09:18:53 -0400
Message-ID: <045921fa-aad3-13f4-7f30-85b028891016@asics.ws>
Date: Fri, 26 Apr 2024 20:18:48 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: u-boot@lists.denx.de
From: Chris Ziomkowski <chris@asics.ws>
Subject: Many USB storage drives fail in latest U-boot
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - durango.smallvillages.com
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - asics.ws
X-Get-Message-Sender-Via: durango.smallvillages.com: authenticated_id:
 chris@asics.ws
X-Authenticated-Sender: durango.smallvillages.com: chris@asics.ws
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Mailman-Approved-At: Fri, 26 Apr 2024 16:21:35 +0200
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

Hi everyone,

The latest version of u-boot seems to have some serious issues with USB 
drives. More than half of my disks do not work. I have traced the issue 
down to the following:

1. During a transfer, the XHCI TRB ring buffer reports back an error of 
type 4. (USB Transaction Error)
2. The COMP_TX_ERR is not matched in 
'drivers/usb/host/xhci-ring.c:record_transfer_result()', so the status 
gets set to the default value in the switch statement:

      udev->status = 0x80;  /* USB_ST_TOO_LAZY_TO_MAKE_A_NEW_MACRO */

3. 'common/usb.c:usb_bulk_msg()' then incorrectly reports this as a timeout
4. On the next loop, an endpoint reset is attempted, which fails with 
another completion code 4, and the USB subsystem becomes stuck in an 
loop trying to reset the drive until it finally gives up.


Question:  how should this situation be handled? Can we recover from it? 
It doesn't appear the current logic was designed to handle it (or at 
least it doesn't handle it).

The XHCI documentation lists a code 4 as a result of:

"Asserted in the case where the host did not receive a valid response 
from the device (Timeout, CRC, Bad PID, unexpected NYET, etc.)."


Can the individual who is maintaining this section of the code (or 
anyone knowledgeable about the implementation) offer some advice on how 
this should be corrected?

Best regards,

Chris






