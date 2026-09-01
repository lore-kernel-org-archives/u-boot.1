Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA23C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 17:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D03FC80DF2;
	Tue,  1 Sep 2026 17:09:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uRIqGiZ7cute; Tue,  1 Sep 2026 17:09:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788282583;
	bh=ErAs9Y1RwShpwXrHT3Vj0a+rIHlQjf/R8SZdaj3tjtw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VlR7bl26hCKChaz9P/n/HjK/MajErajUWNGuTzF9UKnOuUDvc/9n69VYGVZctPhF/
	 M+cgdsQoqxrb35CjcixJcWwxyadeuZMtjtDKBBMtgcmSlMcS94xD1LqmYyR1NVyiY+
	 DrQCYC/7gQSIV9JaUShnuWkk8ucgdAhWy8vNjc9mZLH5QRcK5A18S+2QPMQp5nhiKr
	 p6EesOcBR6xTXcOkAnqlr8KDbFa/7mYEk3yBOdOQylV7lJ/SaJXfwt22TqlRodVcFn
	 TZrvgMZVvqWIsgtscOVhmgYRQQuIJMckFif/zx1be5Ifdg9OBm8TPm8s7ecHJdUmaR
	 nosngWa2X7SGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68A1B80DD6;
	Tue,  1 Sep 2026 17:09:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4239E279
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 29794606F6
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I5Nb0pVH7E3x for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 17:09:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=lXNfOoBL
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F1DE260633
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:40 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7f4dedd67b8so3946813a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788282579; x=1788887379;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ErAs9Y1RwShpwXrHT3Vj0a+rIHlQjf/R8SZdaj3tjtw=;
 b=lXNfOoBLjH4DL7Hw3d93AQvbGT0eJFjqlrXToHJbVZ7ed9xAJwPxRCVVbJoJuZrQM3
 GSBmsEOhJ6oq1uV+AEDFSUh6wleO98/E2gVLpljWgpMBlWU/3KZINik2KureI2pMu7pQ
 d616BIUNAbNxFicEHQfxTyeuKfN7cAM/N+iaXYScT5ARmgL1etVH2OkWEWyM+32gxTd+
 WUKN9HNhvyG7GqigKbO5Rhlm0L8f2wLcvMfAcHtjL8Wk6I3ICLdHu9I7FwXPAFk1Dsbo
 9j/EkxuGPsbMgWIfrytPfWmDfSjbrzLWGTjwB6fdJbDAdqqlJ665X/zcn+C2YRfn231b
 7icQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788282579; x=1788887379;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ErAs9Y1RwShpwXrHT3Vj0a+rIHlQjf/R8SZdaj3tjtw=;
 b=eNHGmA7/mL8HnwkEbeBW5W9tSQgUwtml06Yh8uOJ1FkoJ2JWH7CkJeHjk0Gtqr6Zfk
 ZqzJkHaEe9qNgaeDjDplUgNuoCPfNZK6NLil35Uicz/jWNcXphvpgL8EIRvIHiHMGjzY
 WltEnDCMNpZaVZWdo2VRV2Y4ioMQwYnqzlG8E1EN3M3K0XbDbkJCRrsEcohorPaeik4B
 DcQogJGG6PvhtznTq2rPRQgF1K8O3Q0USbcWe15JKgAHb6pHmln+8lO0kX623Zc9VAXZ
 pbKjDuvq5U2OSiok9qoWUGWSzhimKIjf7Y62FsuF/ytp+guQXpJChBBMKGur8Saui2f7
 7YmQ==
X-Gm-Message-State: AFuF++lXMIlODxK6MoR27ezaD2zXlR1Ts+O8NB3yFU9ktqMO+Q79xJyG
 MEIe1KjrylSJMU8LrzLgv2EIxkyui4AX281yVkhY693HZEbTjZQtx0RY
X-Gm-Gg: AR+sD11ap603urPXmamLF2BNWFx643DRoBgclpdttZOh2rZOFOMryr30ulsW04L1Wp4
 WSaFIDc4F9lq3plnBXy2XzFWVo8zqOLvzp2EaQ+UnUdGnDUMOVqzKxJYFlxZq8LJaasZ/aiR8C9
 UMhEG3ZAeYoamW9d9/IVMY4E/k2qMtkG2OAUorHGJnrvHAKCPuX96SBwZLEehf3DfesesmVRzKO
 appjqQIOGkJzgNgHjbBAl2vdTtccDu6OFNV6izma1jxG8PvxmveN3dqD+Anb9N+CbmDipevlivw
 axIxxgwmXV8ttjc7U0jAK44ymzDphHWJBLFMvCtj4BGKdPK235EIuYZrUNS3jgBIPlkxCPQDjTN
 PsPwCPjH7vdwMJ4uO/ezr5Z2EExQNasFNyHy6mP58WbTmxc/SPnH6JngWCDEvitOI+2n474Bz+0
 ndn2xPbajLAKVb6Osa+gyzlvCpIBI5a1sdjfpm7U8+fXMyW6mHY1ac2Cpm9J075WmGMYg7Yl9Re
 DyRfGxPyDX5CIMJKYvsE1YhR/JDRuflDzSN4IJG+E/OSBoPi96bcAq5csNVE9CsRNV+6ohoC6EB
 rk2k5LXgkBRcol52JdZ2dbl0vrLVEf1TYhh31d9mVWpN6JLnCWaVwhyaZctWh+HzQzuzo02ln5t
 hF6a6fYLaYh40ndca5ZA=
X-Received: by 2002:a05:6830:82d3:b0:7f4:d16e:45f9 with SMTP id
 46e09a7af769-7f687a16b34mr10781336a34.7.1788282579148; 
 Tue, 01 Sep 2026 10:09:39 -0700 (PDT)
Received: from [127.0.1.1] (184-96-151-165.hlrn.qwest.net. [184.96.151.165])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa99d927sm10892218a34.19.2026.09.01.10.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:09:38 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2 00/10] net: share the lwIP runtime and support
 netconsole
Date: Tue, 01 Sep 2026 11:08:54 -0600
Message-Id: <20260901-submit-lwip-runtime-netconsole-v1-v2-0-3e3d95627cf9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOQQqDMBREryJZ95cYUGNXvYe4SONXfzGJJNG2i
 HdvtCcozObB8GY2FtATBnbLNuZxpUDOJhCXjOlR2QGBusRMcFFyKQoIy8NQhOlFM/jFRjIIFqN
 2NrgJYc2h1lxiJyvkPbLkmT329D43mvbHSfJEHQ/x0RgpROc/54k1P3r/7KVw4LIWdVkqVRXyP
 hhF01U7w9p937/on37l5AAAAA==
X-Change-ID: 20260825-submit-lwip-runtime-netconsole-v1-9c08ed87e0fe
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 Luca Jones <ljones@t0.technology>, Weijie Gao <weijie.gao@mediatek.com>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, Simon Glass <sjg@chromium.org>, 
 Vincent Jardin <vjardin@free.fr>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

lwIP commands currently create and remove the stack's only network
interface for each operation. That model cannot support a persistent
client: starting another command replaces its interface, and either
client can stop Ethernet while the other still owns callbacks and PCBs.

First correct wget's existing receive-error path to return ERR_ABRT after
it aborts and frees the TCP PCB.

Introduce a reference-counted runtime which owns one Ethernet device and
one lwIP netif. Clients retain their own protocol callbacks and PCBs,
while one non-reentrant poll entry point services timers, scheduled work
and every attached client. Clients declare whether the IPv4 configuration
must remain stable. An address-less DHCP attachment can coexist only with
flexible clients such as netconsole; environment addressing is restored
when DHCP detaches.

Migrate the existing lwIP commands to the runtime, then add an lwIP
netconsole transport. Netconsole remains attached while a foreground
network command runs, and that command's polling services both protocols.

The runtime permits independent lwIP clients to attach their protocol
state and share the poll loop without creating another netif or Ethernet
owner.

Sharing the stack makes asynchronous teardown significant. Add DNS
callback cancellation, HTTP client abort and DHCP stop-without-release
operations so clients can detach without leaving callbacks or protocol
state behind. The corresponding vendored lwIP changes are kept as
separate patches for upstream submission.

Validation included:

  - sandbox W=1 builds and DM tests for runtime ownership, multiple UDP
    PCBs, address handoff, callback cancellation, immediate abort of an
    established HTTP connection, nested polling and netconsole
    input/output;
  - no-DNS, sandbox_spl, sandbox64_lwIP, qemu_arm64_lwIP and legacy-stack
    builds; and
  - H616 hardware tests of bidirectional netconsole, a TFTP download while
    netconsole remained active, TFTP upload and HTTP wget, with matching
    payload checksums and successful network use after netconsole detached.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
checkpatch reports expected diagnostics for patches 5-7 because vendored
lwIP code follows upstream lwIP formatting. It also reports generic
MAINTAINERS prompts for files already covered by drivers/net/ and test/dm/,
and preprocessor guards required when optional APIs are not declared.

---
Changes in v2:
- Add strict and flexible address modes so DHCP cannot disrupt active
  protocol clients (suggested by Jerome Forissier)
- Prevent environment refreshes from readdressing a strict client
- Test both ownership-conflict directions and strict address stability
- Link to v1: https://patch.msgid.link/20260825-submit-lwip-runtime-netconsole-v1-v1-0-0892966aa758@gmail.com

To: Jerome Forissier <jerome.forissier@arm.com>
To: Sughosh Ganu <sughosh.ganu@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: David Lechner <dlechner@baylibre.com>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: Luca Jones <ljones@t0.technology>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Pranav Tilak <pranav.vinaytilak@amd.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Vincent Jardin <vjardin@free.fr>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: Mateusz Furdyna <mateusz.furdyna@nokia.com>

---
James Hilliard (10):
      net: lwip: return ERR_ABRT after aborting wget receive
      net: split netconsole transport from stdio frontend
      net: netconsole: use unsigned port numbers
      net: netconsole: cache environment settings
      net: lwip: allow DNS callbacks to be canceled
      net: lwip: add an HTTP client abort operation
      net: lwip: allow DHCP to stop without releasing its lease
      net: lwip: share one network runtime between clients
      test: dm: cover the shared lwIP runtime
      net: netconsole: add an lwIP transport

 cmd/lwip/ping.c                                   |  41 +--
 cmd/lwip/sntp.c                                   |  19 +-
 drivers/net/Makefile                              |   6 +-
 drivers/net/netconsole-legacy.c                   | 156 +++++++++
 drivers/net/netconsole-lwip.c                     | 200 ++++++++++++
 drivers/net/netconsole.c                          | 201 +++---------
 drivers/net/netconsole.h                          |  29 ++
 include/net-lwip.h                                |  48 ++-
 lib/lwip/lwip/src/apps/http/http_client.c         |  71 +++-
 lib/lwip/lwip/src/apps/sntp/sntp.c                |   3 +
 lib/lwip/lwip/src/core/dns.c                      |  26 ++
 lib/lwip/lwip/src/core/ipv4/dhcp.c                |  39 ++-
 lib/lwip/lwip/src/include/lwip/apps/http_client.h |   1 +
 lib/lwip/lwip/src/include/lwip/dhcp.h             |   1 +
 lib/lwip/lwip/src/include/lwip/dns.h              |   1 +
 net/Kconfig                                       |  13 +-
 net/lwip/dhcp.c                                   |  57 ++--
 net/lwip/dns.c                                    |  24 +-
 net/lwip/net-lwip.c                               | 270 +++++++++++++---
 net/lwip/nfs.c                                    |  25 +-
 net/lwip/tftp.c                                   |  54 ++--
 net/lwip/wget.c                                   |  72 +++--
 test/dm/Makefile                                  |   6 +
 test/dm/lwip.c                                    | 375 ++++++++++++++++++++++
 test/dm/netconsole.c                              | 344 ++++++++++++++++++++
 25 files changed, 1697 insertions(+), 385 deletions(-)
---
base-commit: 3f19667468fb93bcb5702d23aa057b72639e3ac8
change-id: 20260825-submit-lwip-runtime-netconsole-v1-9c08ed87e0fe

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

