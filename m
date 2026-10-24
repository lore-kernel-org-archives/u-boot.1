Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BBC606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jhJa67uU;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T35R4Gai
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C705D6073E;
	Sat, 24 Oct 2026 22:36:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FDUc4keaV6uT; Sat, 24 Oct 2026 22:36:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 19E636065A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792881353;
	b=GiOMnEIdjwDl0p3RbONiKkQEcloORniHNgfQNlOWP2Y/gGmGTtJ8+njD6UaDRpHUWWii
	 XKQ6OoDsyiEJkmw+nEOFis1OdtDars74gk/jjWoSzXWh7ZcbNljtBH0euKkM5RVeyofvx
	 C3kKF0FDvkAcgCK8zd3bT3IlcguhXG3C0uCSFlX3uOkKhCQBz8F0d+lMvIH+313g52sZg
	 h2hMRrkq42kXCpAasJloKKToT5SgQLNGj1vWQM+wuAg3Jm4mLkcD6wgw/BBv07NOyGnUZ
	 YKIgapXbYk4d/qKXsbh8Ts1FSPvfgMv/B3J/rKeKNq7HtQEJnSNX3UX97O7c5JWkuVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792881353;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7o2ZHxngKMSuJwuOggzrozZCGd+93u8MYHHxyn/nkXQ=;
	b=s4k8W7T3QSgTAFhL+/SGoZ+apsBfmJ1pC86ryysmjIyQADdfSWuBFjLDLoXFileUtbj9
	 cYR6Vfm5F0IvbXnZ6llL8Vf6C9+qjKUbfsbHmtuH6m911TF3Jto/C1uzEpyz/LPlZzLGo
	 dqbv8FShYoL9tN4WFFbAHsKZRX0ZzX4YgkVJe71W0TC5laHPKuE32OWsviMuYMqwKbTmQ
	 UyQn3JpdexxuX1Wk16ZEgxmPu5n0WH1wApWdhUSwjpoFn7fpmUbNVnhGILyDVjZ2ze7hb
	 1UvnzPgUTUr9wFvq+aY1DIYNP+OOgrYT/B6OA90JpthV/AhQOeas2Lm3xYYbIDpcCqw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T35R4Gai;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792881353;
	bh=7o2ZHxngKMSuJwuOggzrozZCGd+93u8MYHHxyn/nkXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jhJa67uUy4SE01ejOQj/zxBXfG9f0EbxXiGpT078ousL5s9luYJ3t2Xvrphwr8i/w
	 /QA76Nc5sWqqlCiclcmU900UR4+D08A5ms96x/AX1nf2u2CDg2mvmh5xBI75Y/NW/O
	 cbwqafuJ4FwFoJ9OG82E6QNk/qrQxGtRQejBI5N1xuuZ2CbeeomxNw/v4VWGfWAXh/
	 Yc+6hiI1lSgaewCWi2C8yyQKhD3z3kiz7f6cvnrWF40+siXQjcBuHJnSGGXwEwQxb9
	 6n7k6zgFKUwcJavmdJOlB3yTcMI4wBNqL2Q6x0J5FFFPWRhGPa5023aV5Tj4oa6cH7
	 Oyp0JmFWNeKuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19E636065A;
	Sat, 24 Oct 2026 22:35:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 042653D9
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD70E606B3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tsyfa5jupRmz for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 22:35:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E029C60626
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792881333;
 b=S+mf73g7Cg28AelrK+38r+tGPDsCAk9f3+O5qiVP03eiuuuClpgLGP/5DX0/YpAD0yUY
 i1pdWpDDsAYrRzkz7bcoU3Z/Mebe5OCh8Vb9tMFzV/zSy/lb09Ps9DmXRJ99kkIwhm3vf
 unVha1K4i2MWIZy7eKtDMDZK8aBF3RHC86yYJcdcn5SRG1VlzbcB1jVapQU5LF9cu01uB
 NzJoNPiKnc64+A9qoOR87p0R03M8A2Xvw3XPJzJQc9442f2G+uRpVKrsFdgsOXtEGV2tS
 p4V9unrA5Es+Hra+or0CI0rfJ9y1dzogps8dN5g8aCpU9YRxnkW1bhOqwdep/7huXQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792881333;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=7o2ZHxngKMSuJwuOggzrozZCGd+93u8MYHHxyn/nkXQ=;
 b=XMCJDxf5RJkxaDbASuzRZCWMqL/fI78+xfRB3jnk6VAJxOECvG2csX6wgGsNcYwb8Zg+
 i3r7KsD+zyEVwFg9tUTxoxfxa/d2mgvnZHDwawi0JrunPQ0nE7MsmvOB+mPSm4mFTCeeF
 cgzT545CEkI1BbW+h6w3Wwh3cclcguAe8LhCUnkdOOyXnUzVUlzQmVWGvtr9GsmMbOr9F
 dX/kctfnE3SSC1wXzd1ZpKwsAqEwwKpCcoiBTkTeUQr5C6U+OgmC0/5IpmO07wH0cAPdI
 L74VKnW0zcF7wuWgA4ASdABNhLOu7JTiInKr5gGnH68Cgm08wFGrJU0mW+HfrCDVCfw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=T35R4Gai; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=T35R4Gai
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E029C60626
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:31 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6d290b10a35so826689eaf.2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792881331; x=1793486131;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7o2ZHxngKMSuJwuOggzrozZCGd+93u8MYHHxyn/nkXQ=;
 b=T35R4Gaibiio/3nmx0LA7ADWuWF+RFm7wXIZn1/nhalEQ+Yh1mY5mMFUDq5T0hKcfR
 zuHjKUuxJXAkCDKFQpz0IXFmGI1vipXF3vgOzxBic9fXZ3smbMpowp3hMlVLZLK+bBrk
 RpmI8qD5PMgvqGYEop7pVWAwHpeedO/sa/xsCw6VvM0YL2YWqgD8DHY/0mhn1Yp3ob2N
 QEM7FJK7wrfyEWgpZENCcFA/kS80ihEw1DnOFZdQQ3aqtKXgE40/DlbOFqus4GYYJ5xR
 SuXfo5aoDv80ugBBO9kAIwecOjTU8wdpaw9uD/8Ebhyb/aTHddUJDnyPxB7QFqm0djZ+
 MSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792881331; x=1793486131;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7o2ZHxngKMSuJwuOggzrozZCGd+93u8MYHHxyn/nkXQ=;
 b=k1G9eOz3GWS7UDijd7c7K3JQLfSf7Ef2UpKVKmN6Zs8BgU1cuOKAs65UErHBiKPeHM
 Ka6tEfVzk2fPts3s+I71z9XGJJQX1dXJ4gXCNOc7OW6Hno6MLU8ioEoJ6EKCEfYMtzU7
 2Fm0geMiP0cBuwv3hrgRswlmUAWOIivb5SuHNJjUZf+K0I18F6dFe4BdgMqJm/Poebpm
 6Eu9eOjOva06Pv6xfaGWbtNj6D8WBw+8ocCjCpI8TAvEF6FVqDw0dLeLP6rkDvVC7yDv
 WhSy00ihNZndVbgzVAXLl088J6q1gS34rfd7mCHzT3T0QpWGAHiR9iRBlixjY1bGDgYW
 uJaw==
X-Gm-Message-State: AFq9FYIkxPLZZbBe7DlzsfeACl9gQ9z5whFDSRiPBUyNaHk9A/UI+cDX
 q4Ztn9Xy9uoxc9s5mEPxdYz9SJRzNFcRGbLcYhGzc7T9YlCPExgQ+VoLgyuBkTBK
X-Gm-Gg: AYBFou2VaXqOkowrL5QwUUFPea+GyC9zdlaPaysDCLR8JexTTZKydCpZ0BGqJOF5Lgk
 R/kJvmITFA/UOAiYj+Im+bsrpuqt9/Wf03G6LvehW+L0Rsu5y5nyh4q/FkbfiXmzuZJC+DA424V
 Jd6ZwBWtb971TDkMv4GvHsHPh8TdImPa6W0kbDBxkU5MSgGCO7PNoEXi309vRwFjYnxPbWU+5bW
 1OnPDFhe/kCOctzFHbmzipnzpm9Cd/+Qzxbd1huPjGvOzT05ysZoaSVDhQY52dpmZnP8baCDSj8
 tdjhZ1CKX2G51ICYGHq9uJbWP2MYsNlZq4JDGPf2t8out513yvhEL71Rw2XxBlmUB/gAOKPxMse
 q3N37ZFszz0/w1c/5PBFcI+DxL4U+Ay63rbdO4IQuzmW6M40pOSCQvzoBoAFAlCl/SeP7ImjlO3
 DNXoDvsBMWnQdvlAPTQbxfjDvsY3uqDRHjCsuG3R2K/wu++lmZeLdCMrWhdUFNpJfCRb98MBOGH
 Oty+MUBCV7NIZJ+J4YuTE/y2c9QVuSLg4ufxGNXtu+LNV12mEjWpggiPhWOcaH85YMDdAc82v5V
 FWFKzDfRwa67RWZ+a/HjrtskL5oZsVyKgDBmIJzHAFG4JHILy/Q+43PlFlrhICxV2FfEgb1ZdZC
 dcqXu8JrNVv4uYeqHDSdtpNs4DkHAfwgYkP+uQIvPmKLqpSIGq+VqGTn30tBhQNVraMZdc8ST7a
 he0Og=
X-Received: by 2002:a05:6820:3383:10b0:6b7:8396:f3c3 with SMTP id
 006d021491bc7-70ba0e24fb3mr996393eaf.37.1792881330649; 
 Sat, 24 Oct 2026 15:35:30 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8430d8130sm1706457fac.5.2026.10.24.15.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 15:35:30 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 16:34:56 -0600
Subject: [PATCH v2 09/16] net: keep internal TFTP and DHCP downloads from
 automatically booting
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-lwip-tftp-combined-v1-v2-9-0f663f735ee8@gmail.com>
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

Internal consumers need to inspect or use the downloaded data before
deciding what to boot. Suppress autostart around their network commands
and restore its exact value on every return. Route the TFTP helper, DHCP
helper, PXE file callbacks, EFI device-tree download and lwIP net_loop
shim through the download-only path. Keep the argv form so legacy IPv6
arguments are preserved.

Reuse the common protection from the automatic-update timeout helper
instead of maintaining a separate autostart override. This protects
script, EFI, PXE, update, DFU and bubt callers before command autostart
is enabled for lwIP.

Leave an already-disabled autostart value untouched, including a
read-only setting. If autostart is enabled and cannot be suppressed,
fail without starting the download.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 boot/bootmeth_efi.c  |  3 +--
 boot/bootmeth_pxe.c  |  3 +--
 cmd/pxe.c            |  2 +-
 include/net-common.h | 17 ++++++++++++--
 net/net-common.c     | 64 +++++++++++++++++++++++++++++++---------------------
 5 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index e187dc39912..b315f41d870 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -221,7 +221,6 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 {
 	char file_addr[17], fname[256];
 	char *tftp_argv[] = {"tftp", file_addr, fname, NULL};
-	struct cmd_tbl cmdtp = {};	/* dummy */
 	const char *addr_str, *fdt_addr_str, *bootfile_name;
 	int ret, arch, size;
 	ulong addr, fdt_addr;
@@ -289,7 +288,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	if (!bflow->fdt_fname)
 		return log_msg_ret("fil", -ENOMEM);
 
-	if (!do_tftpb(&cmdtp, 0, 3, tftp_argv)) {
+	if (!tftpb_run_argv(3, tftp_argv)) {
 		bflow->fdt_size = env_get_hex("filesize", 0);
 		bflow->fdt_addr = fdt_addr;
 	} else {
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 7e999730e6a..27f254b9f93 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -102,7 +102,6 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 				  enum bootflow_img_t type, ulong *sizep)
 {
 	char *tftp_argv[] = {"tftp", NULL, NULL, NULL};
-	struct pxe_context *ctx = dev_get_priv(dev);
 	char file_addr[17];
 	ulong size;
 	int ret;
@@ -111,7 +110,7 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 	tftp_argv[1] = file_addr;
 	tftp_argv[2] = (void *)file_path;
 
-	if (do_tftpb(ctx->cmdtp, 0, 3, tftp_argv))
+	if (tftpb_run_argv(3, tftp_argv))
 		return -ENOENT;
 	ret = pxe_get_file_size(&size);
 	if (ret)
diff --git a/cmd/pxe.c b/cmd/pxe.c
index 3deae5e6d47..9635c834eb4 100644
--- a/cmd/pxe.c
+++ b/cmd/pxe.c
@@ -42,7 +42,7 @@ static int do_get_tftp(struct pxe_context *ctx, const char *file_path,
 		num_args = 3;
 	}
 
-	if (do_tftpb(ctx->cmdtp, 0, num_args, tftp_argv))
+	if (tftpb_run_argv(num_args, tftp_argv))
 		return -ENOENT;
 
 	ret = pxe_get_file_size(sizep);
diff --git a/include/net-common.h b/include/net-common.h
index 12c1689bf57..d5a95075ad7 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -504,7 +504,8 @@ int net_loop(enum proto_t protocol);
  * dhcp_run() - Run DHCP on the current ethernet device
  *
  * This temporarily sets autoload and restores its exact original value,
- * including NFS and an unset variable.
+ * including NFS and an unset variable. Downloads never automatically boot;
+ * the caller owns the resulting image. The autostart variable is restored.
  *
  * @addr: Address to load the file into (0 if @autoload is false)
  * @fname: Filename of file to load (NULL if @autoload is false or to use the
@@ -527,7 +528,7 @@ int dhcp_run(ulong addr, const char *fname, bool autoload);
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 /**
- * tftpb_run() - Run TFTP on the current ethernet device
+ * tftpb_run() - Download via TFTP without automatically booting the image
  *
  * @addr: Address to load the file into
  * @fname: Filename of file to load (NULL to use the default filename)
@@ -535,6 +536,18 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
  */
 int tftpb_run(ulong addr, const char *fname);
 
+/**
+ * tftpb_run_argv() - Run TFTP arguments without automatically booting
+ *
+ * Preserves the exact autostart value on success and failure. This form also
+ * supports the legacy command's optional IPv6 argument.
+ *
+ * @argc: Number of command arguments
+ * @argv: Command arguments, including the command name
+ * Return: command status (see enum command_ret_t)
+ */
+int tftpb_run_argv(int argc, char *const argv[]);
+
 /**
  * tftpb_run_timeout() - Download via TFTP with an initial server-probe timeout
  *
diff --git a/net/net-common.c b/net/net-common.c
index c5d13a23b09..85d97cb660c 100644
--- a/net/net-common.c
+++ b/net/net-common.c
@@ -64,11 +64,40 @@ void net_sntp_set_rtc(u32 seconds)
 	       tm.tm_hour, tm.tm_min, tm.tm_sec);
 }
 
+#if defined(CONFIG_CMD_DHCP) || defined(CONFIG_CMD_TFTPBOOT)
+/* Internal downloads return data to their caller; only commands may boot it. */
+static int netboot_run(int (*command)(struct cmd_tbl *, int, int, char *const []),
+		       int argc, char *const argv[])
+{
+	struct cmd_tbl cmdtp = {};
+	const char *value;
+	char *saved;
+	int ret, restore;
+
+	/* An already-disabled setting may be protected against writes. */
+	if (!env_get_autostart())
+		return command(&cmdtp, 0, argc, argv);
+
+	value = env_get("autostart");
+	saved = strdup(value);
+	if (!saved)
+		return CMD_RET_FAILURE;
+	if (env_set("autostart", "no")) {
+		free(saved);
+		return CMD_RET_FAILURE;
+	}
+	ret = command(&cmdtp, 0, argc, argv);
+	restore = env_set("autostart", saved);
+	free(saved);
+
+	return ret ?: (restore ? CMD_RET_FAILURE : CMD_RET_SUCCESS);
+}
+#endif /* defined(CONFIG_CMD_DHCP) || defined(CONFIG_CMD_TFTPBOOT) */
+
 #if defined(CONFIG_CMD_DHCP)
 int dhcp_run(ulong addr, const char *fname, bool autoload)
 {
 	char *dhcp_argv[] = {"dhcp", NULL, (char *)fname, NULL};
-	struct cmd_tbl cmdtp = {};	/* dummy */
 	char file_addr[17];
 	const char *autoload_env = env_get("autoload");
 	char *saved_autoload = NULL;
@@ -91,7 +120,7 @@ int dhcp_run(ulong addr, const char *fname, bool autoload)
 		dhcp_argv[1] = file_addr;
 	}
 
-	result = do_dhcp(&cmdtp, 0, !autoload ? 1 : fname ? 3 : 2, dhcp_argv);
+	result = netboot_run(do_dhcp, !autoload ? 1 : fname ? 3 : 2, dhcp_argv);
 
 	ret = env_set("autoload", saved_autoload);
 	free(saved_autoload);
@@ -113,17 +142,21 @@ const struct tftp_request_timeout *tftp_get_request_timeout(void)
 	return tftp_request_timeout;
 }
 
+int tftpb_run_argv(int argc, char *const argv[])
+{
+	return netboot_run(do_tftpb, argc, argv);
+}
+
 int tftpb_run(ulong addr, const char *fname)
 {
 	char *tftp_argv[] = {"tftpboot", NULL, (char *)fname, NULL};
-	struct cmd_tbl cmdtp = {};      /* dummy */
 	char file_addr[17] = {0};
 
 	log_debug("addr=%lx, fname=%s\n", addr, fname);
 	sprintf(file_addr, "%lx", addr);
 	tftp_argv[1] = file_addr;
 
-	int result = do_tftpb(&cmdtp, 0, fname ? 3 : 2, tftp_argv);
+	int result = tftpb_run_argv(fname ? 3 : 2, tftp_argv);
 
 	if (result)
 		return log_msg_ret("res", -ENOENT);
@@ -136,37 +169,16 @@ int tftpb_run_timeout(ulong addr, const char *fname, ulong timeout_ms,
 {
 	struct tftp_request_timeout timeout = { timeout_ms, max_retries };
 	const struct tftp_request_timeout *saved = tftp_request_timeout;
-	const char *autostart_env = env_get("autostart");
-	char *saved_autostart = NULL;
-	int restore_ret = 0;
 	int ret;
 
 	if (!timeout_ms || timeout_ms > U32_MAX / 4 || max_retries < 0)
 		return -EINVAL;
 
-	if (autostart_env) {
-		saved_autostart = strdup(autostart_env);
-		if (!saved_autostart) {
-			ret = -ENOMEM;
-			goto out_free;
-		}
-	}
-
-	/* Updates need the downloaded data, not the command's automatic boot. */
-	ret = env_set("autostart", "no");
-	if (ret)
-		goto out_free;
-
 	tftp_request_timeout = &timeout;
 	ret = tftpb_run(addr, fname);
 	tftp_request_timeout = saved;
 
-	if (env_set("autostart", saved_autostart))
-		restore_ret = -EINVAL;
-out_free:
-	free(saved_autostart);
-
-	return ret ?: restore_ret;
+	return ret;
 }
 
 #endif

-- 
2.53.0

