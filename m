Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12828CD98C7
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 23:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C4AA84841;
	Fri, 12 Jun 2026 01:36:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Tx4D0jkl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B20584841; Fri, 12 Jun 2026 01:36:55 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2B738056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 01:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-48662d16d08so214186b6e.2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781221011; x=1781825811; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S5HMh5JuU0hZ9LOPcnZ/Hw6HUV5gYSzKMWVKX6BtDGQ=;
 b=Tx4D0jkl12BzwcZVB3rjWXewotIaeghdjh8EvVe995wxMUMfU+6Oa+6GjdG4lUSnuJ
 o3F1UD/jbA4r4/6nawdy2RDKcXXpACurQrRzNXhAFqwjL0xIclYVDSEYYjfTXE/WvXLo
 lFoT6YsayvFFRyln+uj5U3NBVE18sRecLm7bUkXRspXa3DphzLQT7XQqbxLtPApnI9ZG
 XYiEUFInBHjUcl9vqpJkwcVGZXqq5JZOQFqZXfmesRqMUW3E3chGzzN6X3DIF2KhEAuC
 q0RGV/4o+/ph5KywdECYzcrZk8TMkllTJqyC8rLmetV+u4ncRNpwCSv7AB22HimkPUcw
 R+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781221011; x=1781825811;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5HMh5JuU0hZ9LOPcnZ/Hw6HUV5gYSzKMWVKX6BtDGQ=;
 b=fs48MQLmi7n4WACP08JBk8X8c97WLxAdWVsjt9/E4NRDrF+ZqYruXJsSWB+rKhgcrZ
 RJy84xXk6yBsY4eSq6QZJ59USnpFTo27xtqcBHhZGNYm+We4HD2LLcaXopKIQI0TWHfm
 EjOVg0OW9n7kh9SAFiKhCu3DbqYU9KL+KdzXmDiqQVBMHAhkpkNf2XlIxoTjKK2ABJK/
 AP7NQoJjA5+zwGGUyvbqa825EPKzckL0nOFQGDbObvABHid+4Z2WnSRBTyXABt/T8Rpj
 KMb1/Onp7QJNQ9N3PSit3gk3w0go7qqdIN9En3/bFJlqnPyoSQpAgcTvjJK1xS5GSsao
 O1Kw==
X-Forwarded-Encrypted: i=1;
 AFNElJ90vd3CK51xRSCTbc3k4CP/sRrQw05tTNdHccrrCLCspE8PsgKnaVtD4wGNbaLsgbiLY/1TxnA=@lists.denx.de
X-Gm-Message-State: AOJu0YxohMwL011Z8MWEF+55uwi78HF+CXu8WXdOWM84NFua/Op2lpwp
 K5Vyyb/QvqjRLXGw0zRQeoy0f4AF3qeVnrTC7IRWfA8xS/jO8+Gssq09+lJlsHB/B5Q=
X-Gm-Gg: Acq92OHr2qfV6C2yMW3af/UIdPcp0WkalFW+P4JQXkFyHSnaRwx1x4Wp7ugKsZWJ76S
 rhM+Npm5f7Iyucf3/uqTi8cTxhW92jfI/JwKYUTF6xbxabmsHuaUdbr0pWuoNJ7FeTjizMJ6lNc
 bjdOaSZkZVebs3eyjMqeICeUWUq19E1EaGu4EPoP1SshmTrGcB333hcJ8T4yFf14xD1ct8rFlug
 5A2w2J9Ok4mJglIJNLcExZLzm5BHPwcP20oWVugSxVG/ZDUjEYsC6nRYLyx0QNT3CJbb/IL5+Sy
 kAthmSzreNMFvmhNSDR9FdWv2xwPtkfVAHGweVyZ8750878NCrmZ5WhekteF4ucfQ4XbdSkJVVA
 eAUz+vrSStE3nRLyUGhgY2d7nhqF8BcsNBwt3mEYMwbHykALawYiDAq2uRpMncZGBc7eKVSujEz
 I/R/GrAZGGALtxoY6EMBCI9Oa9wjA=
X-Received: by 2002:a05:6808:1707:b0:467:1941:1f0d with SMTP id
 5614622812f47-4872f38c512mr400578b6e.11.1781221011392; 
 Thu, 11 Jun 2026 16:36:51 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cba0:23d4:353:6048])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e78144822dsm660346a34.2.2026.06.11.16.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 16:36:50 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 0/3] net: lwip: halt ethernet after network commands
Date: Thu, 11 Jun 2026 18:36:07 -0500
Message-Id: <20260611-net-lwip-add-stop-function-v3-0-8849948fd9c3@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OQW7DIBAF0KtYrDMtEAxOVr1H1QWYcTJRjF3Ab
 qPIdy9xsoi6qLr80p/358oSRsLE9tWVRZwp0RBK2G4q1h5tOCCQL5lJLjWv+Q4CZjh/0QjWe0h
 5GKGbQpvLGZjOmJ3iRjVKsQKMETv6XvH3j3tOkzthm2/ioxHxcyqr+V5jziaEduh7yvtqiHSg8
 NrblDGyG3GkMhkv67uzWC/+89ksQICWvqmV66zW9s3Zy5lcxJeytcqzfNKE/FOTwKGphdLeboX
 x/pe2LMsPxozytFgBAAA=
X-Change-ID: 20260509-net-lwip-add-stop-function-7f7794074844
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3499; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=2Geo1gdGEEHiFU/qDgPhQMJBxZEmuygl9s1EM35iolI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqK0Z1yyaO/nV3vQyQ13T+8VmFRfdRotSqEMWne
 rm/q/TuR7mJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaitGdRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AnqkH+wf3i1ozmwbKA2zZnh0FuwwOlsVT8/sGy6NC2b0
 /GY5tXEve6rk/TduVFdymXMUWVDm/lt3uPfB2jXWcZ3gXUWP0WPriI8u6RBWg/0cSgHFGwQOT0U
 f/QRgE9xx0ueJr1zuS3horGhsbQs84WbRZIbtPBG3c+3N9MA5JjyeSQLL4Z38IW82c07BqpqXBK
 o0gSlt1gCPgk7LPpBkEHO+vUEtDjY1FdqRszwahX+IbZF9VE9srgNPLWMTXyhk8uGmenxomYwwy
 iIYWpJu8tdVppnZGNYIP8JJLumI8uzaKNljCrs1MqpUvyGJW5kMgIKAcYUvwiZYqwX7T5mWbGw8
 TWcw=
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
Changes in v3:
- Fix a few minor issues in first commit message.
- Use reference counting in the final patch.
- Rework do_ping() implementation to work with reference counting.
- Link to v2: https://patch.msgid.link/20260512-net-lwip-add-stop-function-v2-0-85146da317dd@baylibre.com

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

 cmd/lwip/ping.c     |  19 ++++++----
 cmd/lwip/sntp.c     |  10 ++++-
 include/net-lwip.h  |   1 +
 net/lwip/dhcp.c     |  15 ++++++--
 net/lwip/dns.c      |   7 +++-
 net/lwip/net-lwip.c |  16 ++++++++
 net/lwip/nfs.c      |   4 ++
 net/lwip/tftp.c     |   4 ++
 net/lwip/wget.c     | 107 ++++++++++++++++++++++++++++++----------------------
 9 files changed, 122 insertions(+), 61 deletions(-)
---
base-commit: 3cdce049f90d77c3f9221f1eb73922384c8972c3
change-id: 20260509-net-lwip-add-stop-function-7f7794074844

Best regards,
--  
David Lechner <dlechner@baylibre.com>

