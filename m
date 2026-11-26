Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4135606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SSKBvBeX;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b9KBlBRc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6ED1760A77;
	Thu, 26 Nov 2026 13:33:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eBwQXf3sGO95; Thu, 26 Nov 2026 13:33:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4A40360A59
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700001;
	b=EcHQ5ZuUvgrKC0SqlVgdNNviCS6hzo3gEah1//W5NmZXwiRLdrV979FWn8zpCt7GcNO/
	 +Hcv1f2TDFpd2t1CexY5yuIUs5EsqUJP2ZoY8dhT19zZDvMMedo2hW/FitvuNxL0dA39f
	 +tnhwsHFB8CRfoUXWvLf7aWm9+RurzAKNag9zd7nUSv1iwwPQPMdP//rnzxJWdmZQEItv
	 ijKf7+DxE/nTlzvxrpF9yxCWYK5kIk9RKkNE2hNjMXcX67sdJEgdL+X75lDmu1/cojv73
	 +gcqPA7vx0jlrT/XQIpj8sWgYlDsf9y9yDgHuMgtdhcvmJUXUbEuKcCh9v8YvDks9LA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700001;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ydy+kQdZpER5Fzk+4gbmu2/UH/+roujiMe61zWawb8s=;
	b=QQQ8hMjqSF5j8hKcK0i8KbDBuUpG3y80fMsxfir3x8v75Q4Wnwkrbia/rZQCwkKgNefH
	 Wr+Ep0OtG6X3Vfqx3fZuZv+J5h6AD2gIixx5/oKMzzsLXY2bvglGfCazPovWOa5y4pl/w
	 a2vVMT5E6Tp8+pmWtUwm+wr8Hujgpw9O6WZAZv2vnUDIXy/OL6QY8uGXo5bqpdLQNLN/c
	 jDuQ6dT04yqLOb/rDv3mdhmceTZVptKq7LsdEx6hS9Rkg+1EAHS0d9Yn+g9e6a3YeY/7r
	 GvtPE8OCepQ9x8FhthXOd1pEXHMADGwNb3+reb5fq9AMY1a00xS8RlqZo7pskeRollA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700001;
	bh=ydy+kQdZpER5Fzk+4gbmu2/UH/+roujiMe61zWawb8s=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SSKBvBeXgO9KdqX4Itb1MIOHiF896DhFyUSiuROIr20EQ+lLxRIsGgfryRcMqmJu+
	 g+Np0zVeFilYDiyK2ZlPm2tu+k3oGVia/3NpH/s/vmISHYZN+vliDc7me7t72/6S9R
	 deYqU+xqtsVR/WhAMqNIc3p42VmWQ7f+ydsaxgjLhCdFTyFxhIDy0p/kzc6j61h41P
	 s17CIGGJOZJb5KL+eDeKUHoKZPPgrnC5cUhMg5zz+NRk32muKPVocMKk3fsgti450a
	 vWq3BBz3KAKAecTiziRQWWt3ZrCrsNB4QYjU+Fq53kk7dyh7eFN3jG4uQn+vV+Di1F
	 ePlRlgN8Cb7wQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A40360A59;
	Thu, 26 Nov 2026 13:33:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 84E89371
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 765124079A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6x5n49QbFSwJ for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6FEA0405C8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=b9KBlBRc
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6FEA0405C8
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:08 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-862a5b64755so3772544a34.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795675988; x=1796280788;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ydy+kQdZpER5Fzk+4gbmu2/UH/+roujiMe61zWawb8s=;
 b=b9KBlBRcDoYAtmDjj4O+pZZGXtfy6zNiZP8sI1a2Yxs6TioDXCESfDhgfAZNSCZVDB
 apTIza2ipd8UR5Xpv+HRE0cM1XkWSVLDq88e8Iihv/Lp4qE983zpESHy6ZLljk+6yCgb
 wlW6hdZJBw6gKCpnZ9zTJrWmJ3Gp6ArKOPjAzmSWiE3jujbJ9y76N5JVfBaXnQUB+qYB
 d7vB8bT4pAfFndS0EjeK0n3MW1ZQPMdF5GF9FRmsxYUX/JMHyL9DOIIl/a0gJpqPS2ki
 zS4O3DiVY7cLqrSsK/39HBq6Xm9xycYisZWhgJZQ/B7W6M/9ep8HcHJSnAFfTVXaDp9x
 4Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795675988; x=1796280788;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ydy+kQdZpER5Fzk+4gbmu2/UH/+roujiMe61zWawb8s=;
 b=ryQPJnzNpQzFqxDdUQU+JR34l0q2b/r+7TkohrbEx2M3MEm82rQ3vQQJU8hE2yg4Kp
 wLobD6zOEJB4L344pRrSlerd8PblKmAJEk7KH/NPYqugqn5bNtEDVedVNEjD92A/boZA
 /gAqEopZlJ9LtmAD1i7oo7MO+J0g5bvBnfP9jW0rhzxnbRW0hrZKNnAcPXgWaeLJTBKl
 DK4qep3eGujn/LGB5DPOrkLkrAfqhi4KswKPmzpfkiod0wj7JhEVvBax0SCwdgiThf0M
 tpDdco77Gvc+huI2uT4G4sGe7f0+5eNR1Xhv5/QCY7hY7qUcaF16fsXSyb/iyeLPkXdV
 su9w==
X-Gm-Message-State: APuU4Z/O5i3vIXtcW90gUlDslld5I2NlFUjBa4nTGkKBRLIG88dzzK18
 EYw6VDrmA4sa68wbeIokLUG499UGsDNllPFzcjFF1zcO48ddrp+AHZs3
X-Gm-Gg: AZFdTZd7KQfrPaiwRRD25AxNH/j/6z+D9XZS89uvweqwJ61TCrW2ZVivrogdKKX7KcJ
 N/zfaemnqOiNkyQSnhmzd0tMngdp4KNfe6QZNw1pJPIP4AyA3mJfzqHx/wsvonZEAiyU7ez+MKU
 AjsDMj7P89Jhe+BAZ28MalGCNzFCsVmBvlVU7PzT2WPuyp/z8UDOqT2VSHqGvZ+1hzv63FT1O9V
 PVQkoc55TuPYrJQI8h22ur3eCLAxykVT22mHjiqGbiihVzeDe9CyiXL24RkI9Fskp3/fZfS1hk/
 mA+Et5KA9VOR2FSdxk+FL26YogEYT8DcmqNbw3+eGjUVAR7LGvvY3ED2m09ulL1m/gdd+EItszR
 PzMA96gNWuC5qyaM8JPAuLL6x5GkaII1vaR/mwG+9q5S+57LgpwMWwpoHWcHR+mmiNHILJLbqDl
 xTPjakWpULy3LDZlThVYq1qiX6Tb+Q93Yiq1vRMhDNppYM6aB1Uaifw/l6zP1ROnPfKJHpPhj5z
 0PTLUvscN+tRTOvlpOHphaXLhkZQJvaWtuDjgQAoQXY5dRXy1tq4lF8hJuL4GyFffLOicffIiQf
 f/k1R1h3AHqw9xCAAS5eqGXaA9LqpMAX6FVNuAzY2w75VRq+umX+NWuueUREkogsyhbWlbLhl1P
 xSp194IUPL+5W2Xqck3lnTNN1Fg9TEPR0Eb4B7JBWbWqbo26fg+zTliIWtynt6JYpDhr6fF0umS
 As2x3fGwS17QFEtXUHq20ExB8RMvYeF5PHi9UGuM/XcBlLPHhmUUU=
X-Received: by 2002:a05:6830:25c2:b0:82f:5471:4dd7 with SMTP id
 46e09a7af769-863159c9683mr22453014a34.30.1795675988003; 
 Wed, 25 Nov 2026 22:53:08 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:07 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 00/19] net: lwip: bring up Ethernet links and load network
 boot images
Date: Wed, 25 Nov 2026 23:52:49 -0700
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6DIBBA0auYWXcSwUYbr9J0oTjoWAsGUEyMd
 y/q8i3+38GTY/JQZzs4WtmzNQnikYEaGtMTcpcMMpelELJAv7Q/DjhFntFQiNZ9sbU24Crwleu
 q0JVuyqeEdJgdad6u+/tzO+UjqXAu4Tj+OZkwZX8AAAA=
X-Change-ID: 20261123-submit-lwip-network-boot-v1-80f73f7fa642
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Piyush Paliwal <piyushthepal@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, Peng Fan <peng.fan@nxp.com>, 
 Carlo Caione <ccaione@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alessandro Rubini <rubini@gnudd.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
 Romain Gantois <romain.gantois@bootlin.com>, kongchen <3305708832@qq.com>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Heiko Schocher <hs@nabladev.com>, 
 Francesco Valla <francesco@valla.it>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Boards booting over Ethernet need a working link and an address before
they can fetch an image. Add IPv4 link-local addressing and reverse ARP,
honor the configured VLAN, and let boot scripts obtain the Ethernet
address used to reach the boot server. CDP can supply the VLAN settings;
on NC-SI ports, bring up the sideband channel before starting an IP
client. Both management protocols receive their frames before ordinary
VLAN filtering.

For NFS boot, use a reserved source port, restart a timed-out download
according to netretry, and honor autostart after a nonempty download.
SPL uses BOOTP or DHCP followed by TFTP and loads the image using the
received file length.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
James Hilliard (19):
      env: invalidate caches after bulk imports
      net: lwip: support the IPv4 linklocal command
      net: lwip: apply the configured Ethernet VLAN
      net: lwip: export the Ethernet address used to reach serverip
      net: cdp: decode advertisements from the complete Ethernet frame
      net: cdp: calculate checksums from network-order bytes
      net: lwip: discover VLAN settings with CDP
      net: lwip: bind NFS requests to a reserved UDP port
      net: lwip: honor autostart after an NFS download
      net: lwip: restart NFS after an RPC timeout
      net: lwip: support network boot with reverse ARP
      boot: pxe: allow boot without the DHCP command
      spl: use the known file length for raw U-Boot images
      spl: fit: read the exact size of an embedded FIT
      spl: net: bound reads to the downloaded file
      spl: net: load a boot image with lwIP
      net: ncsi: check the selected interface before probing
      net: ncsi: track the outstanding management command
      net: lwip: configure NC-SI before starting network clients

 board/sunxi/board.c          |   1 +
 boot/bootmeth_pxe.c          |   8 +-
 cmd/Kconfig                  |   8 +-
 cmd/lwip/Makefile            |   2 +
 cmd/lwip/linklocal.c         |  71 +++++++++
 cmd/lwip/ncsi.c              |  23 +++
 cmd/lwip/ping.c              |   2 +-
 cmd/nvedit.c                 |   7 +-
 common/spl/Kconfig           |  10 +-
 common/spl/spl.c             |  49 +++---
 common/spl/spl_fit.c         |   9 +-
 common/spl/spl_nand.c        |   3 +-
 common/spl/spl_net.c         |  23 ++-
 drivers/net/phy/Kconfig      |   2 +-
 drivers/net/phy/ncsi.c       | 302 +++++++++++++++++++++--------------
 env/common.c                 |  25 ++-
 include/net-lwip.h           |   2 +
 include/net/ncsi.h           |   5 +-
 include/spl.h                |  20 ++-
 include/spl_load.h           |   2 +-
 lib/Makefile                 |   2 +-
 lib/lwip/u-boot/lwip-hooks.h |  10 ++
 lib/lwip/u-boot/lwipopts.h   |  19 +--
 net/Kconfig                  |   8 +-
 net/Makefile                 |   4 +-
 net/cdp.c                    | 311 ++++++++++++++----------------------
 net/cdp.h                    |  17 +-
 net/lwip/Makefile            |   7 +
 net/lwip/cdp.c               |  98 ++++++++++++
 net/lwip/dhcp.c              |  71 ++++-----
 net/lwip/net-lwip.c          | 188 ++++++++++++++++++++--
 net/lwip/nfs.c               |  77 ++++++---
 net/lwip/rarp.c              | 181 +++++++++++++++++++++
 net/lwip/wol.c               |   7 +
 net/net.c                    |  79 ++++-----
 net/nfs-common.c             |   5 +
 net/nfs-common.h             |   1 +
 test/dm/Makefile             |   9 ++
 test/dm/eth.c                |  81 ++++++++++
 test/dm/lwip.c               | 233 +++++++++++++++++++++++++++
 test/dm/lwip_cdp.c           | 117 ++++++++++++++
 test/dm/lwip_dhcp.c          |  23 ++-
 test/dm/lwip_ipv6.c          | 116 +++++++++++++-
 test/dm/lwip_rarp.c          | 139 ++++++++++++++++
 test/dm/lwip_test.h          |  42 +++++
 test/dm/ncsi.c               | 369 +++++++++++++++++++++++++++++++++++++++++++
 test/image/spl_load.c        | 113 +++++++++++++
 test/image/spl_load_net.c    |  43 ++++-
 48 files changed, 2444 insertions(+), 500 deletions(-)
---
base-commit: d778970a189b977c14f93961d7009f404d895b5b
base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git for-next
change-id: 20261123-submit-lwip-network-boot-v1-80f73f7fa642

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

