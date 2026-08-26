Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B191DC61DC2
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 05:30:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8999280963;
	Wed, 26 Aug 2026 05:30:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FgcwdHplvIPO; Wed, 26 Aug 2026 05:30:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787722224;
	bh=NhqA5OZCyW1Qx8sKtu8xxpZjTdY4q3sg+VstG2dSffQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DHaIoP5ta5JrZYqZodPlTER13FmZnVNYzyBNh8hcn5tbmWzTwSUyFK0pnx65skZRE
	 4yFVWuIWYkzB8vb28xQX3ckJdEQ/QIL6zFST2K7ZzJn3uaKGe+lDD0RybazZJ40qaw
	 WbdKwINqd8uIQqEG/dehURHlnFbDrGPPXHlNUsR+FCQIgQh/0j3W6YMqQddIOd2zBe
	 7Ebtn7vLX8ypj9JJj+Vj1E4785nBpRj2k1v8rl0bpqnrYY72xgWOkYTD+eeB/WOqeX
	 bNRRQAoCHd/6uqYhBeM68vTa2Id/sqMRkea+MXEDoSsGK5EQHn8U+Byqg0wWG6lBNF
	 6kgwW6xcRVAiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A182080966;
	Wed, 26 Aug 2026 05:30:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A3D7105
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 681A04054C
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xb7YjSobEPEH for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 05:30:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::34; helo=mail-oa1-x34.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=oYDfO4es
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D7524054B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:21 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-44caeb973b3so277183fac.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787722220; x=1788327020;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NhqA5OZCyW1Qx8sKtu8xxpZjTdY4q3sg+VstG2dSffQ=;
 b=oYDfO4es1kSbF5zai1YytXwnJB5+80UaAuu5/FvNJTDqNYq060+KNlkhNfO1QJXsOo
 cxp16Fj4w9ikhB065Y84PAzZnh2JatowJ9KGYF1kgqjUcz+06ye+0IfcDU5YldX+vr7L
 J4PqEHbZN8Q6brkNS7ieUyf7adJtYNuM2cyM0rjaVldR+fDqomYJqGL7YlODui+SeWvY
 LL39xgUtMGi3e02tVEXO+/YJuu+JaPsmFp3bHA9FU//RzaVgP0aVm/gc7GrXRMNWyb1O
 D901QUBd2TDhspR0XBpRFnGcTIPQZbqfdtzhnHGOJzPhrM8iwerKGgGbXKPWJ3hgldSC
 hlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787722220; x=1788327020;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NhqA5OZCyW1Qx8sKtu8xxpZjTdY4q3sg+VstG2dSffQ=;
 b=oalOl+bkKvqJULTkpVprJ+5xkTdJrqaUBXb2JrMdj7jbTl7/uPLOhKfOms+HRPsfLd
 L5/D9DvQVF+yF0MxbBn2KWK5LRoJZ68XltU31MtfMkKBOP2rOJa/dkaJZpT5ryXEwF8i
 kgTvV/ZOli3JhSTs+T/UBPCzE88hvy7Fau3HSnO+fVlqZ1lldC2Plejz+fnyZbZMRELM
 85kzWmTMLOYRaxQigAoHLO8MosZJVJ4SXo9V9BhNEQxXqIX+lUfB7GYgSL50cmSw3Xdt
 yD+oiIypJdMN/naqztCM9nNCRFlkanqfatwWWtmK4EMlShilEloEcNEJa62IuwqehKhM
 jYlw==
X-Gm-Message-State: AFuF++kIRrsClhBIf9aGcSrk8LM3S85k9ezZhJVncWiPfH5GiRShzeqy
 2JV2jUDi3mbrx2G2utik67yZ32Pwlp9AKteKfVu9YeWYNheBzCXUNgrH
X-Gm-Gg: AR+sD13Zue3cs5yCGPKIsfG3FM8u0IUAEz5IyGZrsEyirj3obcb3mHvzPRJMzP6Bijr
 +6Ua22r9F4zYOrCPdJMn5dwYnGq7UkuRHL39EFKxcvSxmWhyy+Ct/WBlQe/4qmLv1JsJus9IrE1
 dRmYyc0Haf86U7VHUjLVaXOiNzByRMadWAbQBEPeC5UlJAsoRPpLU+uhT9RjLJwf1b4gCITMCHi
 uCtNDBD8TI+cOv49jZtc21AazWN7ESULtmJAx1+qnzrqlMlmpAQG/6EDYRCwCOs0IFZi6qSYxYP
 V2ZdBgrixW2766rN4PuJ6c3ucUa8Y3zzuLCeOz3t5rSsx/mxkQDE/oowD1r7xigtzhSyMzLV9f/
 beerntrKdNqpaWVC9FJCVLqvrRndzOR9LJD1ViXcunu+qwsLhONB9873aCwOgsJXZKHizDzdFrx
 bia5Ws7J1SWGJRKRVwZ0WTB9Fd4DXMP5CaMzL91SJrdbxCx4PqMvVXgo/akEQJw5vaudAoszfE0
 e1XBGTobM7zoi7ZnyMabgniTBEyEzcvUq6cKdhLwui/cbpT1r1Cnh0rxt28m3JJ8oA7+X19onjk
 C0PcNGPF2XwBYEoLG39XQQgi9e6p6arrsnskpQNrf9tczEdot/bN5r1mkpdttq8NUsXgkaHLgxn
 sjeDa+PMcshuV/72xulbcJM+B
X-Received: by 2002:a05:6820:4def:b0:6b1:5c1b:582f with SMTP id
 006d021491bc7-6b1a0388a21mr4298898eaf.5.1787722220269; 
 Tue, 25 Aug 2026 22:30:20 -0700 (PDT)
Received: from [127.0.1.1] (71-218-10-81.hlrn.qwest.net. [71.218.10.81])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-465b0243574sm1346401fac.15.2026.08.25.22.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 22:30:19 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 00/10] net: share the lwIP runtime and support netconsole
Date: Tue, 25 Aug 2026 23:29:39 -0600
Message-Id: <20260825-submit-lwip-runtime-netconsole-v1-v1-0-0892966aa758@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBBG4auQWTtJaaJUr2JcYPnRMdCSTkETw
 t2tuHyb762kSAKlS7VSwiIqMZSoDxX5ZxseYOlKkzX2ZJw9ss73UTIPb5k4zSHLCA7IPgaNA3i
 p+eyNQ+camB5UnCmhl8/+uN7+XZAXfP7BtG1fE5B/2YUAAAA=
X-Change-ID: 20260825-submit-lwip-runtime-netconsole-v1-9c08ed87e0fe
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 Luca Jones <ljones@t0.technology>, Weijie Gao <weijie.gao@mediatek.com>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, Simon Glass <sjg@chromium.org>, 
 Vincent Jardin <vjardin@free.fr>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>
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
and every attached client. An address-less DHCP attachment temporarily
owns the IPv4 configuration; environment addressing is restored when it
detaches.

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

To: Jerome Forissier <jerome.forissier@arm.com>
To: Sughosh Ganu <sughosh.ganu@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
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
 drivers/net/netconsole-legacy.c                   | 156 ++++++++++
 drivers/net/netconsole-lwip.c                     | 200 ++++++++++++
 drivers/net/netconsole.c                          | 201 +++---------
 drivers/net/netconsole.h                          |  29 ++
 include/net-lwip.h                                |  42 ++-
 lib/lwip/lwip/src/apps/http/http_client.c         |  71 ++++-
 lib/lwip/lwip/src/apps/sntp/sntp.c                |   3 +
 lib/lwip/lwip/src/core/dns.c                      |  26 ++
 lib/lwip/lwip/src/core/ipv4/dhcp.c                |  39 ++-
 lib/lwip/lwip/src/include/lwip/apps/http_client.h |   1 +
 lib/lwip/lwip/src/include/lwip/dhcp.h             |   1 +
 lib/lwip/lwip/src/include/lwip/dns.h              |   1 +
 net/Kconfig                                       |  13 +-
 net/lwip/dhcp.c                                   |  57 ++--
 net/lwip/dns.c                                    |  24 +-
 net/lwip/net-lwip.c                               | 248 ++++++++++++---
 net/lwip/nfs.c                                    |  25 +-
 net/lwip/tftp.c                                   |  54 ++--
 net/lwip/wget.c                                   |  72 +++--
 test/dm/Makefile                                  |   6 +
 test/dm/lwip.c                                    | 353 ++++++++++++++++++++++
 test/dm/netconsole.c                              | 343 +++++++++++++++++++++
 25 files changed, 1646 insertions(+), 385 deletions(-)
---
base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
change-id: 20260825-submit-lwip-runtime-netconsole-v1-9c08ed87e0fe

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

