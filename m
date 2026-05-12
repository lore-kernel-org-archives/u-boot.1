Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A414CD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 21:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B437E83F14;
	Tue, 12 May 2026 23:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="y42vx0aL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1724D836AC; Tue, 12 May 2026 23:48:50 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68AD98341A
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 23:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso3512728a34.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 14:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778622526; x=1779227326;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UMx0KnMhqoJ8oMJFZHKHZdjGjogamSIb36XliSrZPTE=;
 b=y42vx0aLNQTPorBvSADP+v7IspMfJpgl0791Lc9nbPcoq7i+M0wj0/pTMbZWVPPivg
 2zHXcxqTxNyeQEBSHop0eECnYdEoeTQSGIzy17mup+lO0kY9sof54V0J0FLpCuPs5zBe
 eJD9UJ0oGv7lggvgFWPdEUF5xhBLUB7HxkXsjIZHPKJKawhSs2hSyyZ0ngjYN4QrK79b
 9W5sGzzLW0HYimzin9Drd9DC/lxtpsL8mKSp2o/2n6RJPZSGz3IJcYrosW4o8biA/iQA
 2taqPguJD585ceUzP8iUCGpaFX1HjisL1K0arX22BifB/3ZS4N/WKB2lplNojMOK2AED
 id+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778622526; x=1779227326;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMx0KnMhqoJ8oMJFZHKHZdjGjogamSIb36XliSrZPTE=;
 b=VHzMyKQDG9ynVbmYco85ZrKgTTzJX1hCBDZkfOC7G0p+amU+wuPmg8Ud14mOPfZVYD
 hXZrLLs2PPEYYtlY9lwSTUTh9U9oEDghVBhdcpIjdEQ5IyVpZ6vGpPZ/JhP2M3wKH8yE
 zZJultOCJPLY6bxun+1RZpDsk7pFH8C9fdLrZwH6LfrU+bjTHkU/JEnsApyzH53YcqeI
 PkNg3Ip5aXtD8tyaW0x8ToAh4r4ivu0CI0I9WQD6eiR0cXW5zzaUtzjB7KYXj770cYO/
 bcnFbwLeOL86TGsdd53RupDOxO8XFjqZevE9jKQDpKg6dQsbeV7MIuwRfdfC/dKHAlRG
 B5pw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mN98E7PyptplrIUKyrsjNU22uE8EynYNhVg35EbWeOKTzlOlPeMu2/zD2oXbHkqzOIIblbi0=@lists.denx.de
X-Gm-Message-State: AOJu0YzqnrejuUR/bJONwOAUkFIrk6IfSE+5h+iZjAY5EXk+fMaj1hjo
 vefHtA6+huEvjLUuyuQJnDddGafFPXQ5G4Iaw37nrWOwr2t5ulX1Platy+vHqUgHbNQ=
X-Gm-Gg: Acq92OHDTZM/gMxqO5LO0DC2Cn2NXr6CgE8TBcAOD38yrmr4t+gkTijZAqGuIx+3dOs
 j2eenp9elV5xpqAS3/DAHrWkx/+vBtmGdAQ1V73K8enA00nNQas/C8s567jjr4B6qunFspue8eh
 BFZTotWJ4ENAMl3MFThTZjnZuCEqDZsUe+JC6RkeSmEOcrogTpzYz6xD5h63RgHQzTOWo0Tie8d
 HrryafjEP49+9iFS7Qtjgg6ogudW4/qcARbg9HOt1SzenkKLkzMPaXrjTGaTumhfO3trbASts9j
 FTdX/CcMuzRP9KHfl1WfiGEolRAUzvy5xbcqnlRjMWzEipo1t1nIVUw7u5yuqqtHEx6WZTspiVo
 Z7XFjdis8clmI/NUZCWBS0EiknESwVjczRYBm3bgT7/jkLNJ1MC+CI3D6xUKrcTOnBBFURAO2sg
 /4wNEuIZhPomzxAsrp0UnH1W+M2Zgd
X-Received: by 2002:a05:6830:928:b0:7dc:4947:36a1 with SMTP id
 46e09a7af769-7e3da15934emr387886a34.12.1778622526043; 
 Tue, 12 May 2026 14:48:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:baa4:f7fb:528a:2457])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367c04e66sm9671795a34.8.2026.05.12.14.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 14:48:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/3] net: lwip: halt ethernet after network commands
Date: Tue, 12 May 2026 16:48:12 -0500
Message-Id: <20260512-net-lwip-add-stop-function-v2-0-85146da317dd@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBBFr0Jm7SiQWtCV9zAuWjrIGCnYFpQQ7
 m5FD+DyJ/+/92fw5Jg8HJMZHI3subMx5JsEqkbZKyGbmCFPc5nu0wNaCnh/co/KGPSh67EebBX
 iDIu6KA4iLUQpBERA76jm1wo/X77ZD/pGVfgQfw1HjyFaw7cGWnnCqmtbDsekc3xlu2uVD+Tgg
 2g4Kt203h2zdfHPszHDDGVuyr3QtZJSnbSa7qwdbaMLLsuyvAGc5sL0CgEAAA==
X-Change-ID: 20260509-net-lwip-add-stop-function-7f7794074844
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3199; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=7Hch/t7Tvti0JEatkt7cI8iWKKerknmnoclhHXa6EMg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqA6AhVt4ttAan/PseERD8LVV0j6E1n0ZjDy3zM
 swg+/5GjyeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagOgIRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A6qMH+wQVGa4NvA3sECi5EtIUTCPbxzVumzcv7nz85wz
 gvKPUqtKRiUpV3QHyOq4lut/hmhiSjISPb6dFs+/e15AHTe471hm54DV4DyKjA7ahM+JoLZwH0v
 wwzsp7SDo8xtFvbioxkdniWb2NrXG2N/is15rUu522KsQ7n4IcECwkRYtYOLuidhEUp3VPmaQ49
 DaF9yVLRio+nR1XICHVC/ptMsJDxnmwz9A5R5kT/0RXNJCqVDeO4Emo2Nqo3c9/3xwEhShXIWn1
 472nhs/guiEaLFNtAdkTWFe9kRuAhHWy1zTXXRPe2iyasclnLualhnffazGgTmMHDqcTWNpJ7Bn
 Lw9M=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Background:

While testing [1], I found that it would take down my local network if
I left the command prompt open for more than 30 seconds after running
any network command. The network activity light on the board running
U-Boot would go crazy and other network adapters on the network would
start getting watchdog timeouts. So apparently, it is doing something
quite low-level and I don't have any hardware to sniff that (Wireshark
on another computer was no help since all network adapters on the
network stopped working.) So I took a logical approach of looking at
the code to see if I could find anything that would cause this. This
seemed to only happen after I switched from the legacy network
implementation to the lwIP implementation, so I looked for differences
between the two implementations.

After some investigation, I found that the lwIP implementation was
different from the legacy implementation in that it does not call
eth_halt() after a network command. Since the problem happened only
when at the command prompt with no command running, this seemed like a
likely culprit. And indeed, it does seem to fix the issue for me.

For reference, the legacy implementation does something like this
as documented in doc/develop/driver-model/ethernet.rst:

	(some net operation (ping / tftp / whatever...))
	eth_init()
		ops->start()
	eth_send()
		ops->send()
	eth_rx()
		ops->recv()
		(process packet)
		if (ops->free_pkt)
			ops->free_pkt()
	eth_halt()
		ops->stop()

After this patch, the lwIP implementation will do the same thing for
all ethernet commands.

[1]: https://lore.kernel.org/u-boot/20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com/

During review of v1, we noticed some existing bugs in wget_handle_request()
so two new patches were added to fix those first before attempting the
primary objective.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Added two new patches to address existing bugs in the code.
- Don't remove eth_halt() before eth_init().
- Link to v1: https://patch.msgid.link/20260509-net-lwip-add-stop-function-v1-1-62d854bfa66a@baylibre.com

To: Jerome Forissier <jerome.forissier@arm.com>
To: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de

---
David Lechner (3):
      net: lwip: wget: fix error handling in wget_do_request()
      net: lwip: wget: return errno codes from wget_do_request()
      net: lwip: introduce net_lwip_eth_stop() function

 cmd/lwip/ping.c     |  10 ++++-
 cmd/lwip/sntp.c     |  10 ++++-
 include/net-lwip.h  |   1 +
 net/lwip/dhcp.c     |  15 ++++++--
 net/lwip/dns.c      |   7 +++-
 net/lwip/net-lwip.c |   5 +++
 net/lwip/nfs.c      |   4 ++
 net/lwip/tftp.c     |   4 ++
 net/lwip/wget.c     | 107 ++++++++++++++++++++++++++++++----------------------
 9 files changed, 108 insertions(+), 55 deletions(-)
---
base-commit: 36d4c653580824b16574560b21d4401614d8b68e
change-id: 20260509-net-lwip-add-stop-function-7f7794074844

Best regards,
--  
David Lechner <dlechner@baylibre.com>

