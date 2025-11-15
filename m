Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05177CEB2EE
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 17:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40E3083A3D;
	Sat, 15 Nov 2025 18:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=zoho.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=zoho.com header.i=krumelmonster@zoho.com header.b="AtK9KL/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DD4883A3B; Sat, 15 Nov 2025 17:30:26 +0100 (CET)
Received: from sender3-of-g91.zoho.com (sender3-of-g91.zoho.com
 [136.143.184.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAA4483A35
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 17:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=zoho.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krumelmonster@zoho.com
ARC-Seal: i=1; a=rsa-sha256; t=1763224218; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Z2rMCneQLvNz1xCas+6rzMCgHMHp3p6eNeRLXqpY8i+JORtioowbD2Bu5pZhc/dV1m3xBTmiYp21pwZi2plZGeebo6WVJz+9U97VMHXKw+hFI2BIlrHMmFjDTGmUrJK2sPRJtulypmF6v06tBDxNNgCp8Bt418OL1VwFZzXAJqY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763224218;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=sjfiDIjUIWy1iCOC5HXDC/oOfnj37vpObVWS6MeC19k=; 
 b=cEh/rHK61CpypwYEslJdXG2T2aFaVUZ81m6bVyjILlZeAnzQEWicSxpkaBG8tYUqjAflF5wh+kMqkXRC+Zz+9NrRVWsYmaXtF93/QgIynBWiEKl5lsrhnt6S1wU1+TsmSqQpQk0rGuuS6tPkE475qDpfxRXuiwJWr+D5aU541kU=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=zoho.com;
 spf=pass  smtp.mailfrom=krumelmonster@zoho.com;
 dmarc=pass header.from=<krumelmonster@zoho.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763224218; 
 s=zm2022; d=zoho.com; i=krumelmonster@zoho.com;
 h=Message-ID:Date:Date:MIME-Version:To:To:From:From:Subject:Subject:Cc:Cc:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
 bh=sjfiDIjUIWy1iCOC5HXDC/oOfnj37vpObVWS6MeC19k=;
 b=AtK9KL/aI7trOFQzyG6otsIBgGBu1j0+OAxEKLntSO0bNJKPKO3VRW1B6RdlMN/z
 O+qYpl5UHXcMXGSoHagidIBBPHrsmvf5tt696/vXpra673rgwySVFif9Z4sQrnk+LGr
 j6Y8NDCtm4Gvb6/fFXNVb2DMSQzoMg20cULOyL4g=
Received: by mx.zohomail.com with SMTPS id 1763224215601144.91696450832865;
 Sat, 15 Nov 2025 08:30:15 -0800 (PST)
Message-ID: <0cbfcfd3-c0e1-432f-92f2-d7bc349bdf57@zoho.com>
Date: Sat, 15 Nov 2025 17:30:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
From: Krumelmonster <krumelmonster@zoho.com>
Subject: `usb start` freezes friendlyelec CM3588 Plus NAS board
Autocrypt: addr=krumelmonster@zoho.com; keydata=
 xsDNBGV5/WABDADQEnbcAQnADMQ5YPm2XaAKUwsl36dsTUCTv5LBrxLaxSeD2ON024ThleWE
 iuZeKW0jGTn5SIGf+x4xhdXWP6OvMScUd6DO16jJUOkaN+fiTRMyFApcP4Iat6lpoi1sYAU2
 N8OnnyeTzpk1UwXTSOO1T7HGD/bsJz4uLHDrGMXXly38u0d8RD6gEmyABdd7rvfI+dQ1wIYd
 yReWogGWjhc0lpKOIEdTnYE8IQsjYM4eRzWOHAZlteK8RTytgNOOuSDRjDuz0OFzvTnqz3hp
 UJWP03Rv0VjTmZt2uxI6z9z9WK46YSbU/j5CEYc8iuOJzkqgpYVyM2e7hlKHoJd3YqnfWHRp
 vgjiGgc8zgCdWnfsS0SKOOafLiXWsY6FpJv/MIMVdKfspC4kGiv24MVOvgfegXqTmKUEzvIm
 cgcKiiZEzJk5rQ32ZFS2J8ZQVWEJp/oVzs+VL6bau+P75n9CCxJQ8cF8VOYvEI/2CbiCBOe8
 IsStun9qsozCBERVTLWXDiEAEQEAAc0mS3J1bWVsbW9uc3RlciA8a3J1bWVsbW9uc3RlckB6
 b2hvLmNvbT7CwQ0EEwEIADcWIQTnvawX80S6aEM+FMeoUUvcouAPVgUCZXn9YQUJCWYBgAIb
 AwQLCQgHBRUICQoLBRYCAwEAAAoJEKhRS9yi4A9W4m0MAKDTOvMNqVlhFRUuCZ5pAn4kT4q6
 x6Ivs8kp2wiVD1c4mQlFfrL6hKxy44uPz4wjgdD54HJ/CWeZIpKL252g9zsD3hOlQA4w4XVt
 CT42zKRHfd4a7qXJT7gqdkrywj1op+4knDaaBCsTmGefBkZholnpA/2p0lwr9+Yqo8N09Gb4
 6mtuQBf21zWrixx81s0xjk2K2iISJ5pkYDOm04m+YhhJlJJVl3wZxvXjBezYfWgMoFvl2fA8
 Rzh/xvM0IHHrY3wC6+0dc+1j21tJgr7QmCLqRiQYX6jtzHnhXVZYP+UHghWzbo9j0I9ZzHpd
 8FdHMC1gMtBGNIgpUvuOq43JR2gx/Z4BwPXHnqlsgWNxbiWWRiiTF137OCDS6qaogjduX4Cz
 W5jVQLEF/ErpUA7VoMBjccW8jVU2ZbgDtu8wgrquhpc6VgW/ZxpmD7Vh/LUL7pD0VYcDutPa
 AXZfw2b8v9/g0dAOHmXXrxzUvmzWLBc1gwemW0hwF0wrqQWyi0yOjc7AzQRlef1hAQwA6LjZ
 1hO9C8VPtctxAjVq/45coo55apu8f7rQo38L7LcPQQUCJXqFUSRIqXSBPDUzZYp7PazYGDVt
 YJ2qQns9JPFMB+qhBPUeZVYnzBN/iXLEp3X8f0yFzfwZyEsMtyDYfkRdrqM/Z7VszNZWNyOU
 lrPvI/foRq7dTqNK0Mr1tj7EZep67ZV8CSbEehUAADg1PXldBdujzpsFfla0PhN7+UBfVNFy
 VfyZjcPqaeOXqtNoC+5SdC0xj9WGYMwrzISOVGc+NSCU0qSaum7FtNyGyvMC+vK0cEoyUAeR
 uBWstPAcleFZShxXDZ/v7V9eB8zZNW59UCtCFCXokiDIAdBV+5t/c6eEZnX7qRH9mSoWhlTR
 FutisFUmfpz1S5B0eoOIP7dnrzWPeJR4bOVMus7QcpaLKqwc+v2dz5S5tlUZlNiyAKVoM6Jw
 SlcxXtJHsAb5xOpGJgC55ElSBX7PjxJG5SDaNFKYCYkpVATjNUGfJZ5JrkxV1k30knANUX0J
 m7RJABEBAAHCwPwEGAEIACYWIQTnvawX80S6aEM+FMeoUUvcouAPVgUCZXn9YgUJCWYBgAIb
 DAAKCRCoUUvcouAPViszC/4rHUtvNKHUmNt53a/gMzez6UjVkpgxa8gY2RIN5xKsxL8PySsR
 QUGuq/ZluXN3IKiHswD6bQpqNnv6PN96efxf+GPE7SOTuwju2F3muH9oKBpaF79x22S9jiZ2
 C6q4Qyf8xKigRqThP3jv4o8aICM4aY3eKCSvaOGXOm7yPJkXQ++jphDEUw1AssRov/pvK3PB
 PJnroPgMvQ7k0WzN6SBQtrF/b6efsvSA9psu6tuaeY6Cgcqeshb9MqwSg8FZShZMl21c/Lai
 KUxBUXzd8NcxPGsJSGC4c7R1+6hfAKkTcs8d/F5UK4gC5upce+FCXDvoS6EUwPn50gtSU/Zp
 S/xgn8cGNBy/0fQOxVs8hTmHfF6LtGjM08Mb9GrILks4tkZmtDHQjDhYrC9cmx/UbqHcUPIb
 Jc+J7C/6g7Hd+FeSren+l1CwY8OIJm3c1GO6yJGYLftZP/bd/kQ8JQb0siHRpvIfdcgizMqZ
 0umNs8easGJLUrDeEObR8cXi5oWRCGA=
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227e661f59acbb7013ded7cfb0a00003a90f13fa57be25560f19c5ea1a6068c25417973a6f9f034a3:zu08011226427dd00ddc241fa7527dbd230000885a4d84a800f11dec7a00334f75b696ef8c3e0ce77a68c7:rf08011226591a5363d238d4f87992de29000070d57cdc23a2c7a787335b1b1e119e19c860fe7f9d20a664:ZohoMail
X-ZohoMailClient: External
X-ZohoMail-Owner: <0cbfcfd3-c0e1-432f-92f2-d7bc349bdf57@zoho.com>+zmo_0_
X-Mailman-Approved-At: Sat, 15 Nov 2025 18:20:38 +0100
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

Hello everyone,

Using the cm3588-nas-rk355_defconfig, running `usb start` in u-boot 
freezes my cm3588 nas in all commits I checked:
v2024.10, v2025.10, v2026.01-rc, and the current `rockchip` branch 
(commit a81c91446a1) on collaboras rk3588 repo at
https://gitlab.collabora.com/hardware-enablement/rockchip-3588/u-boot

It doesn't freeze if I disable PHY_ROCKCHIP_INNO_USB2.

This is the 32GB RAM, 64GB eMMC variant of the CM3588 Plus NAS Kit as 
sold by friendlyelec.

I don't intend to use usb support there, just happened to stumble upon 
this. USB gadget and host are supposedly working on the CM3588 according 
to commit 5bc8209e1ba ("board: rockchip: Add FriendlyElec CM3588 NAS").

=> usb start
starting USB...
USB EHCI 1.00

No further output follows.

I will happily provide further information upon request.

Regards,
krumelmonster
