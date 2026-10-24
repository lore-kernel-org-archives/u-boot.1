Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4408606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UFovzRyT;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HtJp3j4C
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C14346061E;
	Sat, 24 Oct 2026 22:35:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TdPvlyJoUA_0; Sat, 24 Oct 2026 22:35:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CACA560657
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792881335;
	b=ePXmpt7kbvuoepvVkZ/e5FhFD7WygKIsSkG3ucfCM262l750sSC26KIuPB6ZVJjVkiO/
	 ZS/9o7jEO/F0fRSEKyt4uSH5M40tWpDivkeG49/5vyfeh4CIw7yR4/umbAFYARinb1O4f
	 rovWVgFdfBdA53bNJzm6zbxGHr4genbwGHbe5VcZ75kxMxLv2aKol3Dq5I+qEEsdRj8zL
	 7GOFuCa2Siv1DoqCsEqlTMSpByzZIvM+spsgUIQbhBWQl9ouSYRtDHFj1Vn5qMusQbuA/
	 G0PvsOjM92yMqpaKCk/kcnyzQTYKJ+C43HXQ/4H5oBg+IFid/UzPseAiyqLzkVweu1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792881335;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=eqwDd1dmH9guaTtEXf//2YjRbKr/r7R1SDM+9auztBE=;
	b=aVOj6JK0I6EPlTNsHDmWp5Maf2P+vNfcs0/fFMjRseJEweIYK/pf3wMXY3rMDi9FyhAG
	 hrbbNsvWiquT82XUNVm971j/evu+7vMN+HeLRcl1vFlRdike0PW4x/5jOAxj8ox7nlM2i
	 8MN6Dr+YlrpQTnKDSH5vQ1tXSKFVqLWeN0vRIt/6e5k916WQv+BblPPhM3DhxlxPnBvUU
	 /7PUHcjnOlevR3GYf/ebJuLhAYWaJ1TOuFF3gBj5eLRWaLPtHrGEid5YZubAB17jsPPSR
	 taILaVo6w/zqKhvGVyrilmKNFt7+rJlga1Nw6j2Xco/pYQoNGvKTfahbiwd7x1IGBXA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792881334;
	bh=eqwDd1dmH9guaTtEXf//2YjRbKr/r7R1SDM+9auztBE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UFovzRyTU6sbvMNNf8hfipgTi7hwuzsL2OWgtIrPe+fA3BXVCMt8IrXr/gB4bGXTR
	 0dxDLPgrRAUXYUuyIS50SImZ4aKjiTdNUV4aVa3zW413zqF6hKA+JTR16upCx125Cq
	 Wq4UOfa4Th/E+JYfGJxQ7PIw53VsEKbljSgISSpP2Vyyv+c0ewzJoy06QOALvDBoHR
	 pGtU59sKEcvIZvkzynLESwa3paysldzEU52AKrlSoeJEdTJ9sIwXc/rDVhliuT3/f5
	 D3FxrNj51neGv7+6DLi8QLD5Sxtlk8b+t7txHeJFS3O1TjK7b7NNG+BkxkAHvCz773
	 SAizTIK/jTZEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CACA560657;
	Sat, 24 Oct 2026 22:35:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C18BC2F5
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B423680E4E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ncpnqgaL-3kr for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 22:35:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9FFCC80E3B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792881328;
 b=ZPz6T7IS0HEoPbAutq5soR7rJJx1PDf0zrnhL15YaKzbGabYhB4XaTbXRnHaKE9F8q3a
 FZYEy2lJGtB04k8PZ91HuZYO+4GQpQVq9ExcT58FEDNnOmUVQknSGhDnIF9IwK1qvi4I7
 MeCvLYykZ+KIiyMfR83oVUikwWi1Tmtaht0IG1gFmuSCAG6aNBbaRxO7C8CPGxb7Ui2rx
 8Gwh1jcE0577+sF7oV5cqvlF+lMVNvUxNPFFW2FRODU7jGtysFNe3DMI383d5tP0RmG9V
 XAMq1rOeXzmywylxOtQaJCTX1HkgXs0fowjrMupizkiFJZd6DDep/KmKi/yDeRDf2xw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792881328;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=eqwDd1dmH9guaTtEXf//2YjRbKr/r7R1SDM+9auztBE=;
 b=OmwvX2CGhRELfjf7z/Ee5P7GdCcwInl8KRpdDZptUAx2Ucf5++c4pb0RJXJH13DApcBl
 42uJERN8+g+YIjmu639E80Fj5wYGneTgLvEmTQJvTGd3D9K8GsY4ynfKmP/Pf6Lsmozb7
 ATY9p0crKuGadpUu1TcyTUU2jmiA9fK2THj/IiLlXFAO+YyAT3aRsGE9fFRwpazXuzq+I
 +EYq9IKsRPoY9ZbplYXmuyUuSAhZPfg8T0/8KHM+1fVSYZvVdN0NoIPInM14em1xYcsTp
 uZkyIZ6Oy7DquD44FmzrlPYc6Rw3dZ2m/BfNlgfyyGgku7z5hwNoC53o+sGRKiwMVmw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HtJp3j4C; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=HtJp3j4C
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9FFCC80E3B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:28 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-49e5f85ce89so834886fac.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792881327; x=1793486127;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eqwDd1dmH9guaTtEXf//2YjRbKr/r7R1SDM+9auztBE=;
 b=HtJp3j4CXnhHggmVYGAC8rZc8LyoVlLDCJwgIgEE0ipJxIVnlkpNgpR/Zvn4yL87OW
 ggSM/yXRZyQ++7YxNneguAZc5Xd2IlnbarFibsVB1queuwp9FOkI8NW21p6Ow4L4z1RN
 8tPOWrZDWi+MTWPkOLrHNEKa69KQjUeyf9Y+vgMFr9i2wb0Ug66oR7zQbora2sgmblNX
 xZasg7vNC454P/6EDr3K+SNL3X7X2s90FEAwIdgemGliWDQRu7fym9DUOLm5uGTvlm4+
 ngBLghxZS31znGto9w1i3bY91fCKfJf/Lc3uw0vxuQi+deAjbT1DE1SrPbM6UDo+GbnP
 a32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792881327; x=1793486127;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eqwDd1dmH9guaTtEXf//2YjRbKr/r7R1SDM+9auztBE=;
 b=BDa56Q/4guyRy2JAa29D1yG0dD+u43zLA9Tnbki0jzqsB5Ryoa60VfSUh9F0VsfwgC
 emxeBD4+zTHS7eGyJTP/vlsSdpqnNFa8juOnngI11VBZhFYN48iU8K9yDRuQG4ngoud4
 iNMBLD+QucPGaWIYDPSH8/wEXg2P1o/niNG7+r4m2DhUiAP6je0/OnWArrbyxJKaYp/h
 OGw2/scqSa7qWKxMyFZwkXNal5aNKx6/2nLlMlLoBtqRnCs00T4ByyDxNfgUQM/VORTm
 07pqZ1t1ro2NCh9gn/D+YlUyHEKxGRsCx2nArAbiw0omCrjIe2XY9NXaRrtpd3Vp0ZGI
 KCAQ==
X-Gm-Message-State: AFq9FYLwzK9dImPnUjNr6RdFdNjQ1IhE0ur24ZkfI/2aK6XoepzGQbcY
 fHyLGh4t2ZC+ovxdaUOHM96m5hvKhyb/2y4rfDv/GPsCQqfPmUZs8vi6
X-Gm-Gg: AYBFou2FxQSdX+vaUPJ6Jib3bMhUPSNZoxzvg1JptK1fcwbPO7t2JJtZQi/J7wsV1OP
 T5C/S/7s5XYn6oAXY8yEca6U0ezKCFgt/6NCoHRbk4w2cFGM2iYT8INsCqFYG3JXMr843ief6rK
 AM+U1jJO9i6OHFf8YAnyCw56lHHxZSx3BSTmKHyq7NHKJGrGzpJ6mA6BEgvyhjrHEGmTDw6ObOM
 zmkYqpcKFp4MtdQfaLWXhBiWxlJkRO7tJ3dFA617zgY2p8Lx4MQ4XPmToBdT5FIc26BLOh0h/2q
 VGi8yd1q9B3eEAJxuTL52yFEOYHC9hRAu0I3hGqYj7iaLKy0ASyVbvqVlGfsCI9+LVqgXWR+4zh
 nT+S6OpGtUuAJ+lzI3AjXUSHDMQiw4FGc89pZ+vfn47ORzGfkELp5CT4nWT2i2bQmOmuV+NmPGe
 U9/JgYZZyU9WM3d7CcEU6WqR22tnlv7dMQEnDC8SI6aGOoyIsuGcfHFHl3l399r7BfXBsYk8DEb
 WrePt0Et4KeqF1+1UrQAopCqjQNkzF82agX4TuMZ7sDjW32AkcyLAV9TA3znrQnHO7vD8PvW1K1
 y6Ycan5KIo5kQBhu8Ewcup3XAXa6DotuZbOYG3jv9LT2IJMFaoJkt+o/NE4vukL3uGcweXDjtDz
 c9AqrgdZSH7k5K5yAPTN0c5fMY/Zth6gO+0pgLkqeM3mfWw1iVw1E3cWTyBZnGnc1pcfORRqaQy
 +85oU=
X-Received: by 2002:a05:6870:3909:b0:48f:e21e:1e6f with SMTP id
 586e51a60fabf-4a83f635d23mr1881064fac.50.1792881327275; 
 Sat, 24 Oct 2026 15:35:27 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8430d8130sm1706457fac.5.2026.10.24.15.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 15:35:26 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 16:34:54 -0600
Subject: [PATCH v2 07/16] net: lwip: preserve the net_loop download return
 contract
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-lwip-tftp-combined-v1-v2-7-0f663f735ee8@gmail.com>
References: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
In-Reply-To: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The compatibility wrapper returns shell status: zero on success and one
on failure. The bubt caller expects the legacy net_loop contract, where
a positive result means a nonempty download and failures are negative.
This rejects successful images and can accept stale size information
after a failed command.

Clear the previous size before calling TFTP, translate command failure
to a negative error and return whether a successful transfer is
nonempty. Pass the caller's image_load_addr and net_boot_file_name
explicitly instead of using shell environment defaults. Clear the size
at command entry as well, including failures before transport
initialization.

Publish completion after teardown, checking both fileaddr and filesize
updates before exposing the new size or EFI boot device. A failed
metadata update must fail the client or receive-server command, not
leave its caller believing a usable image was downloaded.

Add sandbox coverage for nonempty and empty transfers, server errors,
read-only metadata variables, recovery after failure, explicit caller
arguments and failure before transport initialization.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 net/lwip/net-lwip.c     |  13 +++--
 net/lwip/tftp.c         |  45 +++++++--------
 test/dm/Makefile        |   1 +
 test/dm/lwip_net_loop.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 173 insertions(+), 29 deletions(-)

diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 2afe74cc6a5..ac8d3906fd9 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -4,6 +4,7 @@
 
 #include <command.h>
 #include <env.h>
+#include <image.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <hexdump.h>
@@ -700,12 +701,16 @@ void net_process_received_packet(uchar *in_packet, int len)
 
 int net_loop(enum proto_t protocol)
 {
-	char *argv[1];
-
 	switch (protocol) {
 	case TFTPGET:
-		argv[0] = "tftpboot";
-		return do_tftpb(NULL, 0, 1, argv);
+		/* Match the legacy loop, not the shell command's return value.
+		 * In particular, bubt treats a positive result as downloaded data.
+		 * Its caller supplies the load address and filename directly.
+		 */
+		net_boot_file_size = 0;
+		if (tftpb_run(image_load_addr, net_boot_file_name))
+			return -EINVAL;
+		return !!net_boot_file_size;
 	default:
 		return -EINVAL;
 	}
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 025b65a3a82..e58e1995cb3 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -153,7 +153,6 @@ static void tftp_close(void *handle)
 		return;
 	}
 	ctx->done = SUCCESS;
-	net_boot_file_size = ctx->size;
 
 	tftp_tsize = tftp_transfer_size(ctx);
 	if (tftp_tsize) {
@@ -173,11 +172,26 @@ static void tftp_close(void *handle)
 	}
 	puts("\ndone\n");
 	printf("Bytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
+}
 
+/* Publish completion only after teardown and the fallible environment writes. */
+static int tftp_complete(struct tftp_ctx *ctx, ulong addr, const char *fname)
+{
+	if (ctx->done != SUCCESS)
+		return -EIO;
+	if (!ctx->upload && env_set_hex("fileaddr", addr)) {
+		log_err("fileaddr not updated\n");
+		return -EIO;
+	}
 	if (env_set_hex("filesize", ctx->size)) {
 		log_err("filesize not updated\n");
-		return;
+		return -EIO;
 	}
+	net_boot_file_size = ctx->size;
+	if (!ctx->upload)
+		efi_set_bootdev("Net", "", fname, map_sysmem(addr, 0), ctx->size);
+
+	return 0;
 }
 
 static int tftp_read(void *handle, void *buf, int bytes)
@@ -328,7 +342,6 @@ static int tftp_loop(struct net_lwip_ctx *net,
 	struct tftp_ctx ctx;
 	bool initialized = false;
 	u16 blksize;
-	int ret = -1;
 	err_t err;
 
 	if (!fname || !*fname || !addr)
@@ -427,19 +440,7 @@ out_cleanup:
 	if (initialized)
 		tftp_cleanup();
 
-	if (ctx.done == SUCCESS) {
-		if (!ctx.upload) {
-			if (env_set_hex("fileaddr", addr)) {
-				log_err("fileaddr not updated\n");
-				return -1;
-			}
-			efi_set_bootdev("Net", "", fname, map_sysmem(addr, 0),
-					ctx.size);
-		}
-		ret = 0;
-	}
-
-	return ret;
+	return tftp_complete(&ctx, addr, fname);
 }
 
 static void no_request(void *arg)
@@ -512,15 +513,7 @@ out_cleanup:
 
 	tftp_cleanup();
 
-	if (ctx.done == SUCCESS) {
-		if (env_set_hex("fileaddr", addr)) {
-			log_err("fileaddr not updated\n");
-			goto out;
-		}
-		efi_set_bootdev("Net", "", ctx.fname, map_sysmem(addr, 0),
-				ctx.size);
-		ret = 0;
-	}
+	ret = tftp_complete(&ctx, addr, ctx.fname);
 
 out:
 	tftpsrv_active_ctx = NULL;
@@ -536,6 +529,7 @@ int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	ulong laddr;
 	ulong addr;
 
+	net_boot_file_size = 0;
 	if (!IS_ENABLED(CONFIG_CMD_TFTPSRV))
 		return CMD_RET_FAILURE;
 
@@ -619,6 +613,7 @@ static int do_tftp(struct cmd_tbl *cmdtp, int flag, int argc,
 	const char *ep;
 	ulong value;
 
+	net_boot_file_size = 0;
 	laddr = env_get_ulong("loadaddr", 16, image_load_addr);
 
 	if (operation == TFTP_UPLOAD) {
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 75e82216181..112326c85bb 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -66,6 +66,7 @@ obj-y += lwip_bootp.o
 endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_TFTPBOOT),yy)
 obj-y += lwip_tftp.o
+obj-y += lwip_net_loop.o
 endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_NETCONSOLE),yy)
 obj-y += netconsole.o
diff --git a/test/dm/lwip_net_loop.c b/test/dm/lwip_net_loop.c
new file mode 100644
index 00000000000..2e646e40020
--- /dev/null
+++ b/test/dm/lwip_net_loop.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright 2026 James Hilliard <james.hilliard1@gmail.com> */
+
+#include <dm.h>
+#include <env.h>
+#include <image.h>
+#include <malloc.h>
+#include <net.h>
+#include <asm/eth.h>
+#include <asm/unaligned.h>
+#include <dm/test.h>
+#include <test/ut.h>
+
+static int net_loop_reply(struct udevice *dev, void *packet, unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	int mode = *(int *)priv->priv;
+	struct ethernet_hdr *eth = packet, *reply;
+	struct ip_udp_hdr *ip, *rip;
+	u8 *data;
+	unsigned int size = mode ? 5 : 4;
+
+	if (!sandbox_eth_arp_req_to_reply(dev, packet, len))
+		return 0;
+	if (len < ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + 2 ||
+	    ntohs(eth->et_protlen) != PROT_IP)
+		return 0;
+	ip = (void *)(eth + 1);
+	if (ip->ip_p != IPPROTO_UDP || ntohs(ip->udp_dst) != 69 ||
+	    get_unaligned_be16(ip + 1) != 1)
+		return 0;
+	if (strcmp((char *)(ip + 1) + 2, "test.bin"))
+		mode = -1;
+	if (priv->recv_packets >= PKTBUFSRX)
+		return -ENOSPC;
+	reply = (void *)priv->recv_packet_buffer[priv->recv_packets];
+	memcpy(reply->et_dest, eth->et_src, ARP_HLEN);
+	memcpy(reply->et_src, priv->fake_host_hwaddr, ARP_HLEN);
+	reply->et_protlen = htons(PROT_IP);
+	rip = (void *)(reply + 1);
+	memset(rip, 0, IP_UDP_HDR_SIZE);
+	rip->ip_hl_v = 0x45;
+	rip->ip_len = htons(IP_UDP_HDR_SIZE + size);
+	rip->ip_ttl = 64;
+	rip->ip_p = IPPROTO_UDP;
+	rip->ip_src = ip->ip_dst;
+	rip->ip_dst = ip->ip_src;
+	rip->udp_src = htons(1234);
+	rip->udp_dst = ip->udp_src;
+	rip->udp_len = htons(UDP_HDR_SIZE + size);
+	rip->ip_sum = compute_ip_checksum(rip, IP_HDR_SIZE);
+	data = (void *)(rip + 1);
+	put_unaligned_be16(mode < 0 ? 5 : 3, data);
+	put_unaligned_be16(1, data + 2);
+	data[4] = 0;
+	priv->recv_packet_length[priv->recv_packets++] =
+		ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + size;
+	return 0;
+}
+
+static int net_loop_check(struct unit_test_state *uts, int *mode)
+{
+	static const char * const flags[] = { "filesize:xr", "fileaddr:xr" };
+	int i;
+
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("ipaddr", "1.1.2.3"));
+	ut_assertok(env_set("netmask", "255.255.255.0"));
+	ut_assertok(env_set("serverip", "1.1.2.2"));
+	ut_assertok(env_set("tftpserverip", NULL));
+	ut_assertok(env_set("tftpdstp", NULL));
+	ut_assertok(env_set("loadaddr", "2000000"));
+	ut_assertok(env_set("bootfile", "other.bin"));
+	ut_assertok(env_set("autostart", "no"));
+	strcpy(net_boot_file_name, "test.bin");
+	image_load_addr = 0x2100000;
+	for (*mode = -1; *mode <= 1; (*mode)++) {
+		net_boot_file_size = 1234;
+		ut_asserteq(*mode < 0 ? -EINVAL : *mode, net_loop(TFTPGET));
+		ut_asserteq(*mode > 0 ? 1 : 0, net_boot_file_size);
+		if (*mode >= 0)
+			ut_asserteq_str("2100000", env_get("fileaddr"));
+	}
+	for (i = 0; i < ARRAY_SIZE(flags); i++) {
+		/* A complete transfer with unpublishable metadata is still a failure. */
+		*mode = 1;
+		ut_assertok(env_set(".flags", flags[i]));
+		net_boot_file_size = 1234;
+		ut_asserteq(-EINVAL, net_loop(TFTPGET));
+		ut_asserteq(0, net_boot_file_size);
+		ut_assertok(env_set(".flags", NULL));
+		ut_asserteq(1, net_loop(TFTPGET));
+		ut_asserteq(1, net_boot_file_size);
+	}
+	/* Failure before the transport starts must not expose the last size. */
+	ut_assertok(env_set("serverip", NULL));
+	net_boot_file_size = 1234;
+	ut_asserteq(-EINVAL, net_loop(TFTPGET));
+	ut_asserteq(0, net_boot_file_size);
+	return 0;
+}
+
+static int dm_test_lwip_net_loop(struct unit_test_state *uts)
+{
+	static const char * const vars[] = {
+		"ethact", "ipaddr", "netmask", "serverip", "tftpserverip",
+		"loadaddr", "bootfile", "filesize", "fileaddr", "autostart", "tftpdstp",
+		".flags",
+	};
+	char bootfile[sizeof(net_boot_file_name)];
+	ulong load_addr = image_load_addr;
+	u32 size = net_boot_file_size;
+	char *saved[ARRAY_SIZE(vars)] = {};
+	int i, mode, ret = -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(vars); i++) {
+		const char *value = env_get(vars[i]);
+
+		if (value) {
+			saved[i] = strdup(value);
+			if (!saved[i])
+				goto out;
+		}
+	}
+	memcpy(bootfile, net_boot_file_name, sizeof(bootfile));
+	sandbox_eth_set_tx_handler(0, net_loop_reply);
+	sandbox_eth_set_priv(0, &mode);
+	ret = net_loop_check(uts, &mode);
+	sandbox_eth_set_tx_handler(0, NULL);
+	sandbox_eth_set_priv(0, NULL);
+	env_set(".flags", NULL);
+	memcpy(net_boot_file_name, bootfile, sizeof(bootfile));
+	image_load_addr = load_addr;
+	net_boot_file_size = size;
+	for (i = 0; i < ARRAY_SIZE(vars); i++)
+		if (env_set(vars[i], saved[i]))
+			ret = -EINVAL;
+out:
+	for (i = 0; i < ARRAY_SIZE(vars); i++)
+		free(saved[i]);
+	return ret;
+}
+DM_TEST(dm_test_lwip_net_loop, UTF_SCAN_FDT);

-- 
2.53.0

