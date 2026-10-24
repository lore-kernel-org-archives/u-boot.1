Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AF1606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tMHq1heQ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BN8OvGqF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A72D4068E;
	Sat, 24 Oct 2026 22:35:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jFAyRFN_ykxN; Sat, 24 Oct 2026 22:35:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 372E84068A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792881319;
	b=GRESCFTuhtzPojkojArjWvBSPolpYmrBU6b8wUlw1rAJkCPQBSPrh0g7NsBuY04N91s5
	 JSUFYNGn4qopjxbotpmLC52zXbFZopyM/9wNmcTBWeSGBba5lgYBcWA8CMaopUIMHHmyF
	 EJZGNIGl+TBCLSr0Z/oRrYEZBernPJT0TLi2zufZmuPwILKHBazRCSG89EdFCnp4Qh9BG
	 +wVvPN0T+Gz4OPNk5NVNiNzRRqcJfefsHQ4RIMf1+UwvEF3daReDt5g1PoealD94VqT1X
	 BxCIgMJKyTA7iIZ5YyMcw7GvyJJXHeFS3Trxclflp2oPOlFDlHP2qmu9Wr3GUELTjuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792881319;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=WJg5Q87OfbkmBjAk0Hzxd+aXPcqAeyk0vWUAms45f44=;
	b=JYYJnDVbDylCfpkZGv8ujHMMkP3+WRMPrMK7f06AtN3Q8jA/cf0wZqiU9OAx28qyaIxn
	 Gft7VQT+k/ZAd72DC6IVMh+ZJdIgYXrUUWHTE0m7o7Sye3XXcS0t9ShYWlPWNhEWcEDCI
	 wsNWS5BNyX5ObQdb6T2wEX8P3aFFUG/Y/XlXJuEZ1n/mivGq+nWd/v0YOW3URMYsRx3RP
	 dV3QKbcH6LjYd4czeJ6dDmHoQUAe7WYFyFKeGg9EOKxV2UHVEU/HHrGOd5Vjbhahkbvxc
	 WoAcYDXeu4mePj11gJbuuXLEk8/VXcIOk6WcrNlSkoo0gC2eL0UyGSB9ctPxezGrU1Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792881319;
	bh=WJg5Q87OfbkmBjAk0Hzxd+aXPcqAeyk0vWUAms45f44=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tMHq1heQDSv3DhQ5fkKHGV7nZ+jUXnl6acg6CQ/thVVuzvd0zbDXCuKLwwq/A1yls
	 LmjPm51YHSlqa5CLRAuRFb4+0Y/1YJYntTfCFSq51v5DQrNNQR6Ya1eMFKyhCpGOmz
	 xqSxtJ1FHmLOYlv8RuK2fdTeEaD4wcud0n/rzNoUCK3zZ7W226QD75CDX6i71pyRqE
	 XAoAUiBKi53mqg/tuBhBiN7UeegziYPkcXbDGH5S/JCkQ/AlxNyJIAeMKX8pk6Dk+z
	 aKYxcIgjowlDaBRXtgpaO4vcBCrctOgFmxnLICiuYXn5CwJAjoz7bIAUyeB6lHZ7gi
	 B1ZzQydiLUjvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 372E84068A;
	Sat, 24 Oct 2026 22:35:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 69C58356
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F98080E4E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ELuobvPdTp-P for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 22:35:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3781280E3B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792881317;
 b=L+QO74jYKsI3iM9okUeC6shin5QHCRpkdq9a/9l5Of6FPskvtb2jjM8gxS2/NftVwxb/
 MwKENTB3kVWWaf2u1alHfUArOGL0eeqBSzqFpoLrLKDXsRPiodLYKzXNTuV2hP/6VocA5
 Wl+PXvzKEKAhHo4hlix9JUeEz9BNdOvPdLLjEkO88hCxAIKo1NCohcH7dRDlvsE6QzNWQ
 W8BQozTsXVkEuTkj93GxplvvElHx1z6+iP/XNDJ02xJ13iIQwBc0w89d3JRQ/MTzJBAZu
 4kXIwJwqnu1tyBH7OODU7QVRpbwFrM6GhWVRQy83f1nMv97pOH96J+8xXRC2CkPFiUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792881317;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=WJg5Q87OfbkmBjAk0Hzxd+aXPcqAeyk0vWUAms45f44=;
 b=AHgyIRbNc7qYuabiol9GHs/fJIMpcaXk8M5/UfAWYXi9urhFDSAxalNGK/cPdywwA7uI
 5+NyZSTOMjq2iRuw5Un8ArAboV1yHFddIJEtzQaGZLfjZYsMqLQ7dkO7Fn6JHVuyinZdH
 wBfhAvI5S9oGUA9tGsEcHgIGUaPctJc+p9Ma3nVnKhm8BN2+s+ojoxH3Gv5kIMHgJ4yNU
 +PGQq5VbZYnA7DoIEi6i9VQzjp/d4Q/mKmd5dndnjOgmL4fBvEUKqNW5tW3VMqxWv45a8
 3ARANViiAjqkFZo6hHr1uq3Jgk4OYAGhDjp/XXJUi6Vol7sxAVsVmoV0z0RhhoA68rQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BN8OvGqF; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=BN8OvGqF
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3781280E3B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:16 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-70094949641so1777208eaf.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792881316; x=1793486116;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WJg5Q87OfbkmBjAk0Hzxd+aXPcqAeyk0vWUAms45f44=;
 b=BN8OvGqFdeI5HTGpkKgKyvxs/oMehNdVckZBvNqV6JfqeyyIFG7uBU5PU42dA9DgaV
 nlQ6ulGMlW5dE1+8GSUvmmT1EYhxJS0HK1mZtGQuS9D3Vk145rC/pdMkmv7R4N9ZbU2s
 BbObiD6yt36hiB/9Wq3F00Ia4NZMS6YEG+491/yGDHla87F2N1pzJ7SD47poJ2wh36LS
 bQFB0aQnWxqkXvHnzf3YlBx+oS2EfbMHNasbv1oABnuqC/UlVzoMaxGSvBy+9MoNb1hw
 yUYq2IIf90DxOt1me8u0aOhY417E+SeY9WoxtA7UrRVl5YehFW6jnd14UMtI5KcCGz99
 XYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792881316; x=1793486116;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WJg5Q87OfbkmBjAk0Hzxd+aXPcqAeyk0vWUAms45f44=;
 b=BXciVIU0gWhJdXZcWkEY0jt9NruX8gYO3nFjtNSbgUDhmlomLuwYFkZ/IbPOS/rSpp
 H64IhigYWSn7Zq9CmR8vk+sk8WJIj3yLVePI5MJultjJ2lDXe9kn1GRE9hi3PY0Ypz+J
 3XIlAYsNPlys+ul3DsgMtrgJGxK1wgaNduCHVJl75ZaH8RK/IPxl2nXVqsxlNJ9WR/i8
 7DrQPPV/T0lk0WocftEFt/Zpb/2y7qL5rEILwnowQd6HfnBZZtL5XtrIXgO/TizNQJro
 gqz5LqaTEMKcq8N8Cq9QTani9XZrwn6/kz1WXbGRLpDtQSYY1PtpgzjXrKWweEw1PcC3
 0t7g==
X-Gm-Message-State: AFq9FYIRD1fjn8VhIJhEry2n5I5iwZV8TFJeGkjlV46rFmKZTZBct+xJ
 1jRbVFPhHP7Osn9RlZ5MTtW6zw2nRqGiWpFqTI3DFST21nhq0AaYwfIX
X-Gm-Gg: AYBFou0KDnJzVB/AHR/l4Blg/H7gsPRez6J+io//C2uanAqZAuOzaIP9GRsl14CsYfP
 +j1+IT7iTqAkyrlNze6Z3tnQJqtpxtskY2ttXdVdtqYux7xv5TMZcBoNCJPz93ao57L0hglrDoJ
 B3ewE05LI7a0QSExE9PzsoDOmqIjHC1YhC8OYllx0h23dV0SfSEqFsOh0ju3ENszOZTuYLmCaP/
 rI7KjGrT47C67X/WvkO8R661GcFW61AdSUHJRVafEwFZVjcAQH8KesGzDSYy+wmP/gx9YbFo3OA
 j+fgrYM6FeV3kaqGknjJiHCcUh31d3FXDfDtb3XXANhMDpEjFbjUD9F9rwJcNX5TCAoCPvS/dtL
 XkRihRbOhJ6TsZZkIv43WOCSatS5SAIrLBhKJ7uGBQI9lpBttU6Nnh7x4MWh98SU5TjlwOjSBIs
 Hbl1SDjxey5StPZyEehRNaRmYFKJq3NfsvX8mfiTM7bPY535XPWRP5yfoNe22Ral/bAiTYP9s4R
 CtZBm+6K29wzjmcQrNhOD9ml6Z89x1jqEftXokBf7naV6GP6n+uZsgSxEF6qDIh8dqwVQpknOVW
 ZHKuWunikRCqArwCmQoc4QUwok2IBYrUjJgRsAxyZWk5LyVHK7Ruq1zGYo7CNNXn+IQrp0a6f5D
 oN2YKmRr/qX51iSgYxRX6z6tDWLH59BK6Op2WJyr6l0RlX1kzrWzIRN6Pda//mqZ0ioDnS89ohP
 ErmAU=
X-Received: by 2002:a05:6820:6ae1:b0:6dc:7513:c06d with SMTP id
 006d021491bc7-70ba0f6c792mr1085592eaf.50.1792881315610; 
 Sat, 24 Oct 2026 15:35:15 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8430d8130sm1706457fac.5.2026.10.24.15.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 15:35:15 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2 00/16] net: lwip: restore TFTP client and command parity
Date: Sat, 24 Oct 2026 16:34:47 -0600
Message-Id: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NzQ6CMBAGX4X07JrdoiiefA/DgZYW1vCXtqKG8
 O4W9Gyyl0lmv5mFN46NF5dkFs5M7HnoI8hdInRT9rUBriILiTIjxBz8Q3UcoH3yCMGGEfTQKe5
 NBRNBZY/pidJcKSQRJ0ZnLL+2+Vvx5fh/Nzqsm6vRsA+De2/9iVbvlyL8n4qHoO0ZUerMHpCud
 Vdyu4+OKJZl+QAVOm/82gAAAA==
X-Change-ID: 20261009-submit-lwip-tftp-combined-v1-df537139bb01
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Drew Kluemke <ankluemk@microsoft.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Restore the legacy stack's TFTP behavior on top of the merged lwIP
BOOTP/DHCP/PXE work in U-Boot mainline.

Fix write requests, retransmissions and option validation; expose client
transport settings and tftpput; and add RFC 7440 receive windows. Preserve
download-only internal callers while supporting command autostart after
successful nonempty downloads and transport cleanup. Make automatic
updates, DFU-over-TFTP and bootvx downloads work with either stack.

Keep runtime restart, interface addressing, TFTP retry policy, DHCP/BOOTP
autoload ownership and ICMP recovery in separate patches. Preserve the
original transfer arguments across retries, refresh DHCP boot configuration
when reacquiring a lease, and keep other shared-runtime clients intact.
Receive-server retries use the legacy compiled defaults; uploads and the
receive server remain stop-and-wait transfers.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Rebase onto U-Boot mainline after the BOOTP/DHCP/PXE series was merged.
- Preserve the legacy TFTP OACK bounds check when restoring the normal
  transfer timeout after the initial server probe.
- Adapt the retry tests to the upstream sandbox packet-release hook and
  deterministic DHCP receive-batch accounting.
- Link to v1: https://patch.msgid.link/20261010-submit-lwip-tftp-combined-v1-v1-0-cf8002c6f401@gmail.com

---
James Hilliard (16):
      net: lwip: tftp: fix write-request transfers
      net: lwip: tftp: fix transfer retransmissions
      net: lwip: tftp: honor transport variables
      net: lwip: tftp: add tftpput support
      net: tftp: make automatic updates stack-independent
      dfu: enable TFTP transport with lwIP
      net: lwip: preserve the net_loop download return contract
      net: lwip: tftp: support RFC 7440 receive windows
      net: keep internal TFTP and DHCP downloads from automatically booting
      net: lwip: honor autostart after TFTP download commands
      cmd: bootvx: use stack-independent TFTP downloads
      net: lwip: preserve interface state across network retries
      net: lwip: use the selected interface for TFTP addressing
      net: lwip: retry TFTP transfers using the network failure policy
      net: lwip: keep DHCP and BOOTP autoload retries with their caller
      net: lwip: retry TFTP after matching ICMP port-unreachable errors

 arch/sandbox/include/asm/eth.h                    |    6 +
 boot/bootmeth_efi.c                               |    3 +-
 boot/bootmeth_pxe.c                               |    3 +-
 cmd/Kconfig                                       |   40 +-
 cmd/elf.c                                         |   29 +-
 cmd/lwip/Makefile                                 |    1 +
 cmd/lwip/tftp.c                                   |    2 +-
 cmd/lwip/tftpput.c                                |    8 +
 cmd/pxe.c                                         |    2 +-
 common/Kconfig                                    |    6 +-
 common/update.c                                   |   55 +-
 doc/usage/cmd/tftpsrv.rst                         |   13 +-
 drivers/dfu/Kconfig                               |    5 +-
 drivers/net/sandbox.c                             |    6 +
 include/net-common.h                              |   41 +-
 include/net-lwip.h                                |    2 +
 include/net/tftp.h                                |    3 -
 lib/lwip/lwip/src/apps/tftp/tftp.c                |  716 +++++++++---
 lib/lwip/lwip/src/core/ipv4/icmp.c                |   16 +-
 lib/lwip/lwip/src/include/lwip/apps/tftp_client.h |    4 +
 lib/lwip/lwip/src/include/lwip/apps/tftp_common.h |   20 +-
 lib/lwip/lwip/src/include/lwip/apps/tftp_opts.h   |    7 -
 lib/lwip/u-boot/arch/cc.h                         |    2 +-
 net/Kconfig                                       |   19 +-
 net/lwip/Makefile                                 |    2 +-
 net/lwip/dhcp.c                                   |   52 +-
 net/lwip/icmp_unreach.c                           |   44 +-
 net/lwip/net-lwip.c                               |  104 +-
 net/lwip/tftp.c                                   |  658 ++++++++---
 net/net-common.c                                  |   66 +-
 net/tftp.c                                        |   55 +-
 test/dm/Makefile                                  |    7 +
 test/dm/lwip.c                                    |  115 ++
 test/dm/lwip_bootp.c                              |   24 +
 test/dm/lwip_dhcp.c                               |   98 +-
 test/dm/lwip_dhcp_policy.c                        |   19 +
 test/dm/lwip_net_loop.c                           |  144 +++
 test/dm/lwip_tftp.c                               | 1021 ++++++++++++++++
 test/dm/tftp.c                                    | 1282 +++++++++++++++++++++
 39 files changed, 4175 insertions(+), 525 deletions(-)
---
base-commit: 8649a54d301a4d0ac526324c7a7ad2574939ff27
change-id: 20261009-submit-lwip-tftp-combined-v1-df537139bb01

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

